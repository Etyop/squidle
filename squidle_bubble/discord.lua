Citizen.CreateThread(function()
	while true do
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(619200942402961428)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('logo')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)