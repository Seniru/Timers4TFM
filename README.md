# Timers4TFM
[![All Contributors](https://img.shields.io/badge/all_contributors-2-orange.svg?style=flat-square)](#contributors) ![GitHub file size in bytes](https://img.shields.io/github/size/Seniru/Timers4TFM/src/timer.min.lua?label=Code%20size%20%28minified%29) [![Actions Status](https://github.com/Seniru/Timers4TFM/workflows/Build/badge.svg)](https://github.com/Seniru/Timers4TFM/actions) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) ![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/Seniru/Timers4TFM?include_prereleases)

> A library which provides easy and advanced timers for module developers

> :warning: This library is still in beta phase. Use at your own risk! Contributions are always welcome

## What is this?

**This is a library which provides easy and advanced timers for module developers.**

This project is inspired by [mk's timer library](https://atelier801.com/topic?f=6&t=875052), so make sure to support that also :heart:

***Background***

Since normal players - who aren't module members are not allowed to use tfm module apis timers (`system.newTimer` and `system.removeTimer`) I decided to create a brand new and an advanced timer system for all!

***There are many capabilities for these timers***

- Create timers
- Reset timers
- Kill timers
- Loop timers
- Execute functions after/before mature
- And more!


## How to use?

In order to use this library you need to insert this libraries code in top of your code.

## Examples

#### Creating new timer

```lua
--insert the library code here

tfm.exec.newGame(0) -- You need to load a new map to use this appropriately

local timer1 = Timer("timer1", function() end, 5000, false) -- Creating a very basic timer with a timeout value of 5000

function eventLoop(tc, tr)
  Timer.run(tc) -- You need to call this method inside eventLoop to start and process timers
end


```

### Creating timers with callbacks

```lua

--a function to greet a user
function greet(name, nice)
    print("Hello" .. name .. "It seems you are " .. (nice and "nice" or "not nice"))
end

-- storing the timer in a variable is optional. Storing will be useful if you need to access information about the timer

Timer("callback", greet, 2000, false, "Seniru", true) --setting the callback to our greet function and pass "Seniru" and true as arguments

function eventLoop(tc, tr)
    Timer.run(tc)
end

--Run this code to see the results!

```

### Looping timers

```lua

Timer("looping", function() print("prints") end, 3000, true)
-- This would print `prints` every 3 seconds. Note that you need to specify the time in milliseconds

```


*That's it! You can read more in the documentation*

<!--TODO: Create documentation and link it to 'documentation'-->


# Contributing

Do you want to contribute this project? Great! There are many way that you can involve in this work

<details>
    <summary>Creating issues</summary>
    You can create issues for the following reasons,
    <ul>
        <li>Something is not working (bug)</li>
        <li>Suggestion / Feature request</li>
        <li>General questions</li>
    </ul>
</details>

<details>
    <summary>Creating PRs</summary>
    You can submit a PR for the following,
    <ul>
        <li>Bug fixes</li>
        <li>Improvements</li>
        <li>Additions of new features</li>
        <li>Minor fixes (such as fixing a typo)</li>
    </ul>
</details>

Please, make sure that you have searched well before creating a new issue or a pull request. I'm actively responding to all kind of contributions :smile:

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/Seniru"><img src="https://avatars2.githubusercontent.com/u/34127015?v=4" width="100px;" alt="Seniru Pasan Indira"/><br /><sub><b>Seniru Pasan Indira</b></sub></a><br /><a href="https://github.com/Seniru/Timers4TFM/commits?author=Seniru" title="Code">💻</a></td>
    <td align="center"><a href="https://allcontributors.org"><img src="https://avatars1.githubusercontent.com/u/46410174?v=4" width="100px;" alt="All Contributors"/><br /><sub><b>All Contributors</b></sub></a><br /><a href="#infra-all-contributors" title="Infrastructure (Hosting, Build-Tools, etc)">🚇</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
