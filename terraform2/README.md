# Домашнее задание к занятию «Основы Terraform. Yandex Cloud»

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.12.0

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
<img width="1836" height="128" alt="ycscr" src="https://github.com/user-attachments/assets/4bb615dd-6e92-4e2d-b0d0-d72956176cf5" />
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- <img width="504" height="132" alt="ip" src="https://github.com/user-attachments/assets/50a1b924-f0c9-4236-a89b-ed43a2601343" />
- ответы на вопросы.
  preemptible = true — ВМ может быть остановлена в любой момент, используется для экономии, подходит для неответственных задач, core_fraction=5 — гарантированная доля vCPU (5%), позволяет экономить при низкой нагрузке.



### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 


### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.


### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.
<img width="1808" height="184" alt="2026-06-23_10-34-43" src="https://github.com/user-attachments/assets/4a434c4f-17c5-4f54-b7e6-eb2eb344d31c" />
<img width="520" height="256" alt="2026-06-23_10-34-59" src="https://github.com/user-attachments/assets/9c8975e3-7d4c-4a01-947d-01388e58f147" />


### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.


### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.
<img width="1228" height="264" alt="2026-06-23_10-44-26" src="https://github.com/user-attachments/assets/f4ad5c43-f42e-467d-8d10-fb136f783bb5" />



ДОБАВЛЯЮ КОД ДЛЯ СДАЧИ ЗАДАНИЯ.
<img width="462" height="342" alt="prividers tf" src="https://github.com/user-attachments/assets/cc459e65-a05e-4628-8dd9-83f75a0f7ee5" />
<img width="626" height="884" alt="variables tf" src="https://github.com/user-attachments/assets/3e7966fa-e8bc-4fa6-9c60-6f369abe8f82" />
<img width="552" height="576" alt="variables tf2" src="https://github.com/user-attachments/assets/d8af4e5a-5c9f-4ef9-9569-e3ffadfd6792" />
<img width="556" height="574" alt="vms_platform tf" src="https://github.com/user-attachments/assets/2eb44870-2304-467e-95e7-ff8524bc13f3" />
<img width="412" height="272" alt="locals tf" src="https://github.com/user-attachments/assets/50381a83-e259-491b-81bd-aa6ad61aa8a4" />
<img width="508" height="964" alt="main tf" src="https://github.com/user-attachments/assets/5496d5e0-ad43-4f42-aefa-6b50e22ecef8" />
<img width="428" height="910" alt="main tf2" src="https://github.com/user-attachments/assets/d890f4ea-a97d-430f-a9f4-701d06ac9216" />
<img width="692" height="448" alt="outputs tf-terraform tfvars" src="https://github.com/user-attachments/assets/283fb616-f209-4734-8bdc-5ba31b2a4731" />

------
