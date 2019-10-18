--[[
  @author: Seniru Pasan
  @license: Apache-2.0
  An advanced timer library for all module developers in transformice
]]

--[====[
    @type class
    @name Timer
    @brief The class which holds all the properties and methods related to Timers
--]====]
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

--[====[
    @type func
    @name Timer.init(time)
    @param time:number Number of milliseconds from start
    @brief Initializes all the timers and the clock
    @desc Initializes all the timers and the clock. One should call this on each new game (otherwise the timers won't work properly. <br>The <i>time</i> could be passed inside the eventLoop function to be more precise.
--]====]
function Timer.init(time)
  if not Timer._init then
    Timer._init = true
    Timer._clock = time
  end
end

--[====[
    @type func
    @name Timer.process(tc)
    @param tc:number Number of milliseconds from start
    @brief Processes all the timers
    @desc One should call this inside eventLoop function to work the timers properly
--]====]
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

--[====[
    @type func
    @name Timer.run(tc)
    @param tc:number Number of milliseconds from start
    @brief Shorthand method to include both #init and #process methods
--]====]
function Timer.run(tc)
  Timer.init(tc)
  Timer.process(tc)
end

--[====[
    @type func
    @name Timer.new(id, callback, timeout, loop, ...)
    @param id:any The ID of the timer.
    @param callback:function The function to be called after timeout
    @param timeout:number Number of milliseconds for the mature
    @param loop:boolean Sets the timers looping function. If <i>true</i> runs again after mature.
    @param ...:any This is a vararg. These varagrs are used to call the callback
    @return Timer A new timer
    @brief Creates a new timer with given properties
--]====]
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

--[====[
    @type func
    @name Timer:getId()
    @return any The timer's ID
    @brief Returns the timer's ID
--]====]
function Timer:getId() return self.id end

--[====[
    @type func
    @name Timer:getTimeout()
    @return number Number of milliseconds for timeout
    @brief Returns the timeout milliseconds
--]====]
function Timer:getTimeout() return self.timeout end

--[====[
    @type func
    @name Timer:isLooping()
    @return boolean The looping status
    @brief Returns the looping status of the timer
--]====]
function Timer:isLooping() return self.loop end

--[====[
    @type func
    @name Timer:getMatureTime()
    @return number Time by which the timer get matured
    @brief Returns the maturing time of the timer
--]====]
function Timer:getMatureTime() return self.mature end

--[====[
    @type func
    @name Timer:isAlive()
    @return boolean The timers living status
    @brief Returns the timers life status
    @desc This will return <i>true</i> if the timer is alive. A timer become dead if :kill() function is called on self. Also a timer get died after the mature if the loop status is <i>false</i>
--]====]
function Timer:isAlive() return self.alive end

--[[Setters]]

--[====[
    @type func
    @name Timer:setCallback(func)
    @param func:function The new function
    @brief Changes the callback with the new function provided
--]====]
function Timer:setCallback(func)
    self.call = func
end

--[====[
    @type func
    @name Timer:addTime(time)
    @param time:number Milliseconds to be added
    @brief Adds more time for maturing
--]====]
function Timer:addTime(time)
    self.mature = self.mature + time
end

--[====[
    @type func
    @name Timer:setLoop(loop)
    @param loop:boolean The loop status of the timer
    @brief Sets the loop status of the timer
--]====]
function Timer:setLoop(loop)
    self.loop = loop
end

--[====[
    @type func
    @name Timer:setArgs(...)
    @param ...:any Varargs that to be passed to the callback
    @brief Passese the new parameter for the callback function
--]====]
function Timer:setArgs(...)
    self.args = ...
end

--[[Instance methods]]

--[====[
    @type func
    @name Timer:call()
    @brief Calls the timer prematurely or after the mature
--]====]
function Timer:call()
    self.call(self.args)
end

--[====[
    @type func
    @name Timer:kill()
    @brief Kills the timer
--]====]
function Timer:kill()
  self.alive = false
  self = nil
end

--[====[
    @type func
    @name Timer:reset()
    @brief Resets the timer
    @desc Resets the timer. After reseting the mature time would be increased by the timeout provided at the instantiation
--]====]
function Timer:reset()
  self.mature = Timer._clock + self.timeout
end
