\# ⚡ JailFUCK v2.3 by MortisHAck



```markdown

<div align="center">



!\[Version](https://img.shields.io/badge/version-2.3-blue?style=for-the-badge)

!\[Platform](https://img.shields.io/badge/platform-Roblox-red?style=for-the-badge)

!\[Status](https://img.shields.io/badge/status-Beta-yellow?style=for-the-badge)

!\[Lua](https://img.shields.io/badge/language-Lua-purple?style=for-the-badge)



<img src="https://img.shields.io/badge/⚡-JailFUCK-ff5555?style=for-the-badge\&labelColor=1a1a2e" alt="JailFUCK"/>



\### 🎯 Advanced Roblox Cheat Script



\*Многофункциональный скрипт с системой аимбота, ESP, управлением гравитацией и продвинутой гуманизацией\*



---



\[Возможности](#-возможности) •

\[Установка](#-установка) •

\[Управление](#-управление) •

\[Скриншоты](#-скриншоты) •

\[FAQ](#-faq)



</div>



---



\## 📋 Содержание



\- \[Возможности](#-возможности)

\- \[Установка](#-установка)

\- \[Управление](#-управление)

\- \[Конфигурация модулей](#-конфигурация-модулей)

\- \[Changelog](#-changelog)

\- \[FAQ](#-faq)

\- \[Disclaimer](#%EF%B8%8F-disclaimer)



---



\## ✨ Возможности



\### 🎯 Aimbot

| Функция | Описание |

|---------|----------|

| \*\*CFrame.Lerp наведение\*\* | Точное и плавное наведение на цель через интерполяцию камеры |

| \*\*FOV Circle\*\* | Настраиваемый круг зоны захвата цели |

| \*\*Target Selection\*\* | Выбор части тела: Head, UpperTorso, LowerTorso, HumanoidRootPart |

| \*\*Prediction\*\* | Предсказание движения цели с настраиваемой силой |

| \*\*Visibility Check\*\* | Проверка видимости — не целится сквозь стены |

| \*\*Smoothness\*\* | Настраиваемая плавность (1-20) |

| \*\*Max Distance\*\* | Ограничение максимальной дистанции захвата |



\### 🧠 Advanced Humanizer

| Функция | Описание |

|---------|----------|

| \*\*Reaction Time\*\* | Имитация времени реакции человека (0-500мс) |

| \*\*Aim Shake\*\* | Тряска прицела с настраиваемой амплитудой и скоростью |

| \*\*Miss Chance\*\* | Процент шанса промаха (0-50%) |

| \*\*Aim Drift\*\* | Плавное покачивание прицела |

| \*\*Random Seed\*\* | Рандомизация паттернов тряски |



\### 👁️ ESP (Extra Sensory Perception)

| Функция | Описание |

|---------|----------|

| \*\*Box ESP\*\* | Рамка вокруг игроков с настраиваемой толщиной |

| \*\*Box Fill\*\* | Заливка рамки с регулируемой прозрачностью |

| \*\*Name ESP\*\* | Отображение имени с настраиваемым размером и обводкой |

| \*\*Health Bar\*\* | Полоса здоровья с динамическим цветом |

| \*\*Distance\*\* | Отображение дистанции до игрока |

| \*\*Chams\*\* | Highlight-подсветка через стены (тестирование) |

| \*\*Team Check\*\* | Автоматическое скрытие тиммейтов |



\### 🌙 Gravity Control

| Функция | Описание |

|---------|----------|

| \*\*Пресеты\*\* | Земля (196), Луна (32), Марс (74), Космос (0) |

| \*\*Custom\*\* | Произвольное значение от 0 до 400 |

| \*\*Toggle\*\* | Быстрое вкл/выкл по клавише V |

| \*\*Индикатор\*\* | Анимированный индикатор на экране |



\### 🏃 Movement

| Функция | Описание |

|---------|----------|

| \*\*Speed Hack\*\* | Изменение скорости ходьбы (1-200) |

| \*\*Jump Power\*\* | Изменение силы прыжка (1-500) |

| \*\*Infinite Jump\*\* | Бесконечные прыжки в воздухе |

| \*\*No Fall Damage\*\* | Отключение урона от падения |

| \*\*BunnyHop\*\* | Автоматический прыжок при приземлении |

| \*\*Auto Sprint\*\* | Автоматический бег |



\### 🎨 Visual

| Функция | Описание |

|---------|----------|

| \*\*Custom Crosshair\*\* | Полностью настраиваемый прицел |

| \*\*FOV Changer + Lock\*\* | Изменение FOV камеры с защитой от сброса анимациями |

| \*\*Third Person\*\* | Режим от третьего лица с настраиваемой дистанцией |

| \*\*Watermark\*\* | Информационный оверлей с FPS и Ping |

| \*\*Time of Day\*\* | Изменение времени суток |

| \*\*Ambient Color\*\* | Настройка освещения мира |



\### 🔧 Misc

| Функция | Описание |

|---------|----------|

| \*\*Anti-AFK\*\* | Защита от автоматического кика за бездействие |

| \*\*No Recoil\*\* | Уменьшение отдачи оружия |

| \*\*Config System\*\* | Сохранение и загрузка конфигураций |

| \*\*Theme Manager\*\* | Кастомизация темы интерфейса |



---



\## 📦 Установка



\### Требования

\- Roblox Executor с поддержкой:

&nbsp; - `Drawing` API

&nbsp; - `game:HttpGet()`

&nbsp; - `loadstring()`

&nbsp; - `RaycastParams` / `Workspace:Raycast()`



\### Поддерживаемые экзекуторы

| Экзекутор | Статус |

|-----------|--------|

| Synapse X | ✅ Полная поддержка |

| Script-Ware | ✅ Полная поддержка |

| Fluxus | ✅ Работает |

| KRNL | ✅ Работает |

| Delta | ⚠️ Частичная поддержка |

| Solara | ⚠️ Не тестировалось |



\### Быстрый старт



Вставьте в консоль экзекутора:



```lua

loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR\_USERNAME/JailFUCK/main/main.lua"))()

```



> ⚠️ Замените `YOUR\_USERNAME` на ваш GitHub username



\### Ручная установка



1\. Скачайте файл `main.lua` из репозитория

2\. Откройте ваш экзекутор

3\. Загрузите скрипт в редактор

4\. Нажмите \*\*Execute\*\*



---



\## 🎮 Управление



\### Горячие клавиши



| Клавиша | Действие |

|---------|----------|

| `RightShift` | Открыть/закрыть меню |

| `V` | Переключить гравитацию |

| `Space` | Infinite Jump (когда включён) |

| `Mouse2` (ПКМ) | Активация аимбота (по умолчанию) |



\### Навигация по меню



```

🏠 Main      — Информация о скрипте, выгрузка

👁️ ESP       — Настройки ESP и Chams

🎯 Aimbot    — Настройки аимбота и гуманизера

🏃 Movement  — Скорость, прыжок, гравитация

🎨 Visual    — Прицел, FOV, камера, водяной знак

🔧 Misc      — Anti-AFK, отдача, мир

⚙️ Settings  — Конфиги, тема, горячие клавиши

```



---



\## ⚙️ Конфигурация модулей



\### Aimbot — рекомендуемые настройки



\#### 🟢 Легитный профиль

```

FOV: 80-120

Smoothness: 12-16

Humanizer: ON

&nbsp; Reaction Time: 100-200мс

&nbsp; Shake: 1.0-3.0

&nbsp; Miss Chance: 5-15%

&nbsp; Drift: ON (0.5-1.0)

```



\#### 🟡 Полу-рейдж

```

FOV: 200-350

Smoothness: 5-8

Humanizer: ON

&nbsp; Reaction Time: 30-80мс

&nbsp; Shake: 0.3-0.8

&nbsp; Miss Chance: 0-5%

```



\#### 🔴 Рейдж (не рекомендуется)

```

FOV: 400-600

Smoothness: 1-3

Humanizer: OFF

Prediction: ON

```



\### Gravity — пресеты планет



| Планет | Значение | Эффект |

|--------|----------|--------|

| 🌍 Земля | 196 | Стандартная гравитация |

| 🪐 Марс | 74 | Лёгкие прыжки |

| 🌙 Луна | 32 | Высокие прыжки |

| 🚀 Космос | 0 | Невесомость |



---



\## 📸 Скриншоты



<details>

<summary>📷 Нажмите для просмотра</summary>



> \*Скриншоты будут добавлены позже\*



| Модуль | Превью |

|--------|--------|

| Main Menu | `скоро` |

| ESP в действии | `скоро` |

| Aimbot FOV Circle | `скоро` |

| Gravity Control | `скоро` |



</details>



---



\## 📝 Changelog



\### v2.3 (Текущая)

```diff

\+ ✅ Исправлен прицел — точное наведение через CFrame.Lerp

\+ ✅ FOV Lock — защита от сброса анимациями

\+ ✅ Правильный расчёт углов камеры

\+ ✅ Gravity Control с пресетами планет

\+ ✅ Advanced Humanizer (Shake, Drift, Miss Chance, Reaction Time)

\+ ✅ Chams (ESP Highlight) — тестирование

\+ ✅ Full ESP Configuration (Box Fill, Name Size, Health Bar Width)

\+ ✅ BunnyHop

\+ ✅ No Fall Damage

\+ ✅ Ambient Color Control

\+ ✅ Animated Gravity Indicator

```



\### v2.2

```diff

\+ Базовый aimbot

\+ ESP (Box, Name, Distance, Health)

\+ Movement hacks

\+ Anti-AFK

```



\### v2.1

```diff

\+ Начальная версия

\+ Базовый GUI на LinoriaLib

```



---



\## 🏗️ Архитектура



```

JailFUCK v2.3

├── 📦 Библиотека (LinoriaLib)

│   ├── Library.lua

│   ├── ThemeManager.lua

│   └── SaveManager.lua

│

├── 🎯 Модули

│   ├── Aimbot

│   │   ├── Target Selection (FOV-based)

│   │   ├── CFrame.Lerp Smoothing

│   │   ├── Prediction System

│   │   ├── Visibility Raycast

│   │   └── Humanizer Engine

│   │

│   ├── ESP

│   │   ├── Box Drawing (Square)

│   │   ├── Name Labels (Text)

│   │   ├── Health Bars (Dynamic Color)

│   │   ├── Distance Labels

│   │   └── Chams (Highlight Instance)

│   │

│   ├── Movement

│   │   ├── Gravity Control

│   │   ├── Speed/Jump Modifier

│   │   ├── Infinite Jump

│   │   ├── No Fall Damage

│   │   └── BunnyHop

│   │

│   ├── Visual

│   │   ├── Custom Crosshair

│   │   ├── FOV Changer + Lock

│   │   ├── Watermark (FPS/Ping)

│   │   └── Third Person Camera

│   │

│   └── Misc

│       ├── Anti-AFK

│       ├── No Recoil

│       ├── Time/Ambient Control

│       └── Config System

│

└── 🔄 Main Loop (RenderStepped)

&nbsp;   ├── UpdateESP()

&nbsp;   ├── Aimbot:Update()

&nbsp;   ├── CrosshairDraw:Update()

&nbsp;   ├── GravityControl:Update()

&nbsp;   └── WatermarkObj:Update()

```



---



\## ❓ FAQ



<details>

<summary><b>Скрипт не загружается</b></summary>



1\. Убедитесь, что ваш экзекутор поддерживает `Drawing` API

2\. Проверьте подключение к интернету (скрипт загружает LinoriaLib)

3\. Попробуйте другой экзекутор

</details>



<details>

<summary><b>Аимбот не работает</b></summary>



1\. Убедитесь, что аимбот включён в меню

2\. Проверьте привязку клавиши (по умолчанию ПКМ)

3\. Убедитесь, что в зоне FOV есть враги

4\. Если включён Team Check — убедитесь, что цель из другой команды

</details>



<details>

<summary><b>ESP не отображается</b></summary>



1\. Включите ESP в табе 👁️ ESP

2\. Проверьте настройку "Скрывать своих" — возможно все игроки в вашей команде

3\. Увеличьте максимальную дистанцию отображения

</details>



<details>

<summary><b>FOV камеры сбрасывается</b></summary>



Используйте функцию \*\*"Изменить FOV камеры + Lock"\*\* во вкладке Visual. FOV Lock принудительно удерживает значение FOV каждый кадр, предотвращая сброс анимациями.

</details>



<details>

<summary><b>Как сохранить настройки?</b></summary>



Перейдите во вкладку ⚙️ Settings → введите имя конфига → нажмите Save. Для автозагрузки нажмите "Set as autoload".

</details>



---



\## 🤝 Contributing



Если вы хотите помочь проекту:



1\. \*\*Fork\*\* этот репозиторий

2\. Создайте ветку: `git checkout -b feature/новая-функция`

3\. Внесите изменения и сделайте коммит

4\. Отправьте \*\*Pull Request\*\*



\### Приоритетные задачи

\- \[ ] Silent Aim

\- \[ ] Triggerbot

\- \[ ] Radar/Minimap ESP

\- \[ ] Skeleton ESP

\- \[ ] Tracer Lines

\- \[ ] Улучшенный No Recoil (перехват Remote Events)

\- \[ ] Поддержка специфичных игр (Jailbreak, Da Hood, etc.)



---



\## ⚠️ Disclaimer



> \*\*Этот проект создан исключительно в образовательных целях.\*\*

>

> Использование данного скрипта может нарушать Terms of Service Roblox и привести к бану вашего аккаунта. Авторы не несут ответственности за любые последствия использования данного ПО.

>

> \*\*Используйте на свой страх и риск.\*\*



---



\## 📜 License



Этот проект распространяется под лицензией \*\*MIT\*\*.



```

MIT License



Copyright (c) 2024 MortisHAck



Permission is hereby granted, free of charge, to any person obtaining a copy

of this software and associated documentation files (the "Software"), to deal

in the Software without restriction, including without limitation the rights

to use, copy, modify, merge, publish, distribute, sublicense, and/or sell

copies of the Software, and to permit persons to whom the Software is

furnished to do so, subject to the following conditions:



The above copyright notice and this permission notice shall be included in all

copies or substantial portions of the Software.



THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR

IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,

FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE

AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER

LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,

OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

SOFTWARE.

```



---



<div align="center">



\*\*⚡ JailFUCK v2.3 by MortisHAck\*\*



Made with ❤️ and ☕



⭐ Star this repo if you find it useful!



</div>

```

