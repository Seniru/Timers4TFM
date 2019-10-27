local api = require("fromage")
local client = api()
local enums = client.enumerations()


coroutine.wrap(function()
    client.connect(args[2], args[3])

    if client.isConnected() then
        print('Successfully logged in as ' .. args[2])

        print('Answering topic')

        client.answerTopic("Testing fromage. Delete this message", {
            f = enums.forum.atelier801,
            t = 902724 --885034
        })

    end

    client.disconnect()
    os.execute("pause >nul")
end)()