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

setmetatable(Timer, {
    __call = function (cls, ...)
        return cls.new(...)
    end
})

--[====[
    @type func
    @name Timer.process(tc)
    @param tc:number Number of milliseconds from start
    @brief Processes all the timers
    @desc One should call this inside eventLoop function to work the timers properly
--]====]
function Timer.process()
    local time = os.time()
    local toRemove = {}
    for k, v in next, Timer._timers do
        if v.isAlive and v.mature <= time then
            v:call()
            if v.loop then
                v:reset()
            else
                v:kill()
                toRemove[#toRemove + 1] = k
            end
        end
    end
    for k, v in next, toRemove do
        Timer._timers[v] = nil
    end
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
    self.callback = callback
    self.timeout = timeout
    self.isAlive = true
    self.mature = os.time() + timeout
    self.loop = loop
    self.args = { ... }
    Timer._timers[id] = self
    return self
end


--[[Setters]]

--[====[
    @type func
    @name Timer:setCallback(func)
    @param func:function The new function
    @brief Changes the callback with the new function provided
--]====]
function Timer:setCallback(func)
    self.callback = func
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
    self.args = { ... }
end

--[[Instance methods]]

--[====[
    @type func
    @name Timer:call()
    @brief Calls the timer prematurely or after the mature
--]====]
function Timer:call()
    self.callback(table.unpack(self.args))
end

--[====[
    @type func
    @name Timer:kill()
    @brief Kills the timer
--]====]
function Timer:kill()
    self.isAlive = false
end

--[====[
    @type func
    @name Timer:reset()
    @brief Resets the timer
    @desc Resets the timer. After reseting the mature time would be increased by the timeout provided at the instantiation
--]====]
function Timer:reset()
    self.mature = os.time() + self.timeout
end
