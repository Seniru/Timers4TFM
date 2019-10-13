tfm.exec.newGame(0)

local Timer = {}
Timer.__index = Timer
Timer._timers = {}
Timer._init = false
Timer._clock = 0

setmetatable(Timer, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Timer.init(time)
  if not Timer._init then
    Timer._init = true
    Timer._clock = time
  end
end

function Timer.process(tc)
  Timer._clock = tc
  for k, v in next, Timer._timers do
    if v:isAlive() and v:getMatureTime() <= Timer._clock then
      v.call(v.args)
      if v.loop then
        v:reset()
      else
        v:kill()
      end
    end
  end
end

function Timer.run(tc)
  Timer.init(tc)
  Timer.process(tc)
end

function Timer.new(id, callback, timeout, loop, ...)
  local self = setmetatable({}, Timer)
  self.id = id
  self.call = callback
  self.timeout = timeout
  self.mature = Timer._clock + timeout
  self.loop = loop
  self.args = ...
  self.alive = true
  Timer._timers[id] = self
  return self
end

--[[Getters]]
function Timer:getId() return self.id end
function Timer:getTimeout() return self.timeout end
function Timer:isLooping() return self.loop end
function Timer:getMatureTime() return self.mature end
function Timer:isAlive() return self.alive end

--[[Setters]]
function Timer:setCallback(func)
    self.call = func
end

function Timer:addTime(time)
    self.mature = self.mature + time
end

function Timer:setLoop(loop)
    self.loop = loop
end

function Timer:setArgs(...)
    self.args = ...
end

--[[Instance methods]]

function Timer:call()
    self.call(self.args)
end


function Timer:kill()
  self.alive = false
  self = nil
end

function Timer:reset()
  self.mature = Timer._clock + self.timeout
end

--[[Testing]]

local i = false;
local timer1 = Timer("timer1", function(name) i = true print(i) end, 5000, true, "seniru")

function eventLoop(tc, tr)
  Timer.run(tc)
end
