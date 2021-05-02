Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F569370B6E
	for <lists+linux-wireless@lfdr.de>; Sun,  2 May 2021 14:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhEBMPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 May 2021 08:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhEBMPC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 May 2021 08:15:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B753BC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 May 2021 05:14:08 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bf4so3167117edb.11
        for <linux-wireless@vger.kernel.org>; Sun, 02 May 2021 05:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=JqtWh+P8Z7fl+qjNuuQYpmDZCZRz4myXEoN7V5UQgU8=;
        b=kanXCHQBM2jQ6rJh+/wSN8CXIh7hdWWKP41VZm2rKhGs9VlNjUf5kFv/QH4kz6UzXf
         PXrePTdntnJTP14KiQxiDLK747IbT+HA+Tn2G5LMfBzYqyqhLbjhfypUBKvcEURNrJnv
         Y94A/uq0m3v1S9dmrFvNZTFPbE5yDII9i4Ufrs4R66j6qyy48d56HoBxcemVz2ARNOPN
         Yu6uq3GuY1qd93zTYEBuS+RE5Yk6tLXM2ago6ya7FPX3TCA9ajHN3NHzmLlH9bcqBu6+
         190nK9LRyXjB5JosUqXWS4e9K5UDWTAhEFqPtXIg7RAB9GedjVe79eSReDRe0glE1xrk
         hENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=JqtWh+P8Z7fl+qjNuuQYpmDZCZRz4myXEoN7V5UQgU8=;
        b=ah1BzV5Lt29H06e2oFA+gEPHU+UpEk3SOMWzUd757XR0niaY6yjuAqUI/f5waiZboU
         q53v4MWJ17VvwC9WFyqVUdLL/zRu6zCP+azFy5EhTmX3y3yQhncJ3F1YQc6zpI6RZ1Az
         EW2g3wriceK/DxuygQixjzb6IB+zGaGNWpt90VUwvIWQzma5qoSYqKgS4dt5zBFWW/r7
         SdU7yyVdTBRpFUs+xfHbrjO6XLUwcaXfeki7b703dY2V3GeQdh8JPrF7PcDvnvbU4eXz
         JAut2KxUFW18N9UJK8nUDVLJz+vxt1U757hvHKcz7FI5bXmZdl/b5Pz75R72GtvYVJac
         y2hw==
X-Gm-Message-State: AOAM533ZTojoJ3Ctfg7mudsxLBAmmE9sDhGJAnz2lmGmcLs6KQU0nSSL
        WjPdRLPseo6K9Yz9Sepk3Z+7WePi9XM=
X-Google-Smtp-Source: ABdhPJzlKbCajYuI3blSdxNoUIoGHlSX/nJ0WXlFTbt9I3+a/VdBUHsZhRMCh3cYr3DoxpXz50+98Q==
X-Received: by 2002:a05:6402:cb0:: with SMTP id cn16mr5767009edb.15.1619957646961;
        Sun, 02 May 2021 05:14:06 -0700 (PDT)
Received: from [10.0.0.2] (94-210-190-100.cable.dynamic.v4.ziggo.nl. [94.210.190.100])
        by smtp.gmail.com with ESMTPSA id b5sm8818937edz.88.2021.05.02.05.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 05:14:06 -0700 (PDT)
From:   Friso Smit <fw.smit01@gmail.com>
Subject: Re: iwlwifi: failed to load firmware chunk
To:     Chris Murphy <lists@colorremedies.com>
Cc:     linux-wireless@vger.kernel.org
References: <40bb3a55-a872-414d-ed7f-6548beecd236@gmail.com>
 <CAJCQCtTxroboAeQgByCG0zfNK=Rda=2cOGW4i2_kqxu2Saqqsg@mail.gmail.com>
 <b606a193-3e4d-cdd7-a2e4-c5b801e2f8fc@gmail.com>
 <aef9af7e-9a5b-4eb4-e130-e5ee11d76891@gmail.com>
Message-ID: <36bb34d7-07de-9e13-d3e9-d1f9f2c8e9ba@gmail.com>
Date:   Sun, 2 May 2021 14:14:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <aef9af7e-9a5b-4eb4-e130-e5ee11d76891@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/13/21 6:05 PM, Friso Smit wrote:
> Okay, this is weird. Right now it's still messed up in Windows, but 
> not anymore in Linux (even though it started while running linux). 
> Dmesg currently doesn't show any errors for iwlwifi. Does anyone have 
> an idea what part of the wifi chip could be broken here (driver, 
> firmware, etc.)?
>
> On 4/11/21 10:56 PM, Friso Smit wrote:
>> On 4/11/21 10:11 PM, Chris Murphy wrote:
>>> On Sun, Apr 11, 2021 at 2:24 AM Friso Smit <fw.smit01@gmail.com> wrote:
>>>> Hi,
>>>>
>>>> After upgrading to linux 5.11.12.arch1-1 I suddenly had no wifi
>>>> connection. I immediately tried downgrading again, but to no avail.
>>> Did only kernel version change? 5.11.12 has one iwlwifi related commit:
>>>
>>> commit 6159f947fb047fd8ecbfbcbcc86a8337e801bd10
>>>      iwlwifi: pcie: don't disable interrupts for reg_lock
>>>
>> It's not the only thing that changed, but this one stood out to me as 
>> the possible cause. Some other things to note are that I sometimes 
>> have to force shutdown my laptop, because of a long time issue in 
>> nouveau. I don't know if this can cause these kinds of issues. And I 
>> want to stress as well that the issue persisted even on another 
>> operating system, so something must have been thoroughly messed up 
>> somehow.
>>
>> Here's a full list of (Arch) packages that were upgraded:
>>
>> expat (2.2.10-2 -> 2.3.0-1)
>> glib2 (2.68.0-5 -> 2.68.1-1)
>> libcups (1:2.3.3op2-1 -> 1:2.3.3op2-2)
>> cups (1:2.3.3op2-1 -> 1:2.3.3op2-2)
>> dleyna-core (0.6.0+2+g1c6853f-2 -> 0.7.0-1)
>> dleyna-connector-dbus (0.3.0-3 -> 0.4.0-1)
>> libdrm (2.4.104-1 -> 2.4.105-1)
>> mesa (21.0.1-1 -> 21.0.2-1)
>> dleyna-renderer (0.6.0-4 -> 0.7.0-1)
>> dleyna-server (0.6.0+2+geb895ae-2 -> 0.7.0-1)
>> gdk-pixbuf2 (2.42.4-1 -> 2.42.6-1)
>> geoclue (2.5.7-2 -> 2.5.7-3)
>> glib2-docs (2.68.0-5 -> 2.68.1-1)
>> gtk-update-icon-cache (1:4.2.0-2 -> 1:4.2.0-3)
>> gtk3 (1:3.24.28-1 -> 1:3.24.28-2)
>> lib32-expat (2.2.10-1 -> 2.3.0-2)
>> lib32-glib2 (2.68.0-5 -> 2.68.1-1)
>> lib32-gdk-pixbuf2 (2.42.4-1 -> 2.42.6-1)
>> lib32-libva-mesa-driver (21.0.1-2 -> 21.0.2-1)
>> lib32-mesa (21.0.1-2 -> 21.0.2-1)
>> lib32-vulkan-intel (21.0.1-2 -> 21.0.2-1)
>> libmwaw (0.3.17-1 -> 0.3.18-1)
>> libva-mesa-driver (21.0.1-1 -> 21.0.2-1)
>> linux (5.11.11.arch1-1 -> 5.11.12.arch1-1)
>> linux-headers (5.11.11.arch1-1 -> 5.11.12.arch1-1)
>> lua (5.4.2-1 -> 5.4.3-1)
>> mesa-vdpau (21.0.1-1 -> 21.0.2-1)
>> meson (0.57.1-1 -> 0.57.2-1)
>> npm (7.8.0-1 -> 7.9.0-1)
>> opera-ffmpeg-codecs (88.0.4324.192-1 -> 89.0.4389.90-1)
>> proj (6.3.2-1 -> 8.0.0-1)
>> qt5-base (5.15.2+kde+r171-2 -> 5.15.2+kde+r171-3)
>> wlroots (0.12.0-1 -> 0.13.0-1)
>> sway (1:1.5.1-2 -> 1:1.6-1)
>> vulkan-headers (1:1.2.173-1 -> 1:1.2.174-1)
>> vulkan-intel (21.0.1-1 -> 21.0.2-1)
>> wine (6.5-2 -> 6.6-1)
>> wine-mono (6.0.0-1 -> 6.1.1-1)
>>
Hi all,

This issue happened again for me. This time I know exactly how it 
happened. I was connected to the upstairs wifi network and I wanted to 
connect to the other network. I tried doing that by pressing disconnect 
in nm-tui (tui interface from networkmanager). After that it hasn't been 
able to scan for wifi networks again. I haven't checked if I could send 
packets over the upstairs network, but it at least showed up as a 
connected network. Not in Linux and neither in Windows. The last time I 
somehow fixed it by uninstalling the wifi device in the Windows device 
manager, but that didn't fix it this time. Below is the journalctl log 
from when it happened. As you can see, it's again a failure to load a 
firmware chunk.

System info:

- HP Zbook Studio G5

- Network controller: Intel Corporation Wireless-AC 9560 [Jefferson 
Peak] (rev 10)

- Linux 5.11.16-arch1-1

May 02 10:44:41 user NetworkManager[383]: <info> [1619945081.2042] 
manager: NetworkManager state is now DISCONNECTED
May 02 10:44:41 user NetworkManager[383]: <info> [1619945081.2089] 
device (wlp0s20f3): supplicant interface state: disconnected -> 
interface_disabled
May 02 10:44:41 user NetworkManager[383]: <info> [1619945081.2089] 
device (p2p-dev-wlp0s20f3): supplicant management interface state: 
disconnected -> interface_disabled
May 02 10:44:41 user NetworkManager[383]: <info> [1619945081.2372] 
device (wlp0s20f3): supplicant interface state: interface_disabled -> 
disconnected
May 02 10:44:41 user NetworkManager[383]: <info> [1619945081.2372] 
device (p2p-dev-wlp0s20f3): supplicant management interface state: 
interface_disabled -> disconnected
May 02 10:44:42 user ntpd[439]: Deleting interface #12 wlp0s20f3, 
192.168.178.24#123, interface stats: received=0, sent=0, dropped=0, 
active_time=581 secs
May 02 10:44:42 user ntpd[439]: Deleting interface #14 wlp0s20f3, 
2001:1c00:41c:2600:52a0:a336:852c:cfe4#123, interface stats: received=0, 
sent=0, dropped=0, active_time=577 secs
May 02 10:44:42 user ntpd[439]: Deleting interface #15 wlp0s20f3, 
fe80::68cb:c2f2:cfb3:3575%2#123, interface stats: received=0, sent=0, 
dropped=0, active_time=577 secs
May 02 10:44:44 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-REGDOM-CHANGE init=DRIVER type=COUNTRY alpha2=EU
May 02 10:44:44 user NetworkManager[383]: <info> [1619945084.5618] 
policy: auto-activating connection 'Network' (*redacted*)
May 02 10:44:44 user NetworkManager[383]: <info> [1619945084.5622] 
device (wlp0s20f3): Activation: starting connection 'Network' (*redacted*)
May 02 10:44:44 user NetworkManager[383]: <info> [1619945084.5624] 
device (wlp0s20f3): state change: disconnected -> prepare (reason 
'none', sys-iface-state: 'managed')
May 02 10:44:44 user NetworkManager[383]: <info> [1619945084.5627] 
manager: NetworkManager state is now CONNECTING
May 02 10:44:44 user NetworkManager[383]: <info> [1619945084.5848] 
device (wlp0s20f3): set-hw-addr: reset MAC address to *redacted* (preserve)
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: Failed to load 
firmware chunk!
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: iwlwifi transaction 
failed, dumping registers
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: iwlwifi device config 
registers:
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000000: a3708086 
00100406 02800010 00800000 ea290004 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000020: 00000000 
00000000 00000000 00348086 00000000 000000c8 00000000 000001ff
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000040: 00928010 
10000ec0 00100c10 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000060: 00000000 
00080812 00000405 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000080: 800f0011 
00002000 00003000 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 000000a0: 00000000 
00000000 00000000 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 000000c0: 00000000 
00000000 c823d001 0d000008 00804005 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 000000e0: 00000000 
00000000 00000000 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000100: 14c00000 
ff000000 000000ff 00462031 00000000 00002000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000120: 00000000 
00000000 00000000 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000140: 00000000 
00000000 00000000 16410018 00000000 0001001e 00481e1f 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: iwlwifi device memory 
mapped registers:
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000000: 00c89008 
00000040 00000000 00000000 00000000 00000000 00000000 00000000
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: 00000020: 00000010 
0c000005 00000312 d55555d5 d55555d5 d55555d5 80008040 001f0042
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: Could not load the 
[0] uCode section
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: Failed to start INIT 
ucode: -110
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: Failed to run INIT 
ucode: -110
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: Failed to start RT 
ucode: -110
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: iwl_trans_send_cmd 
bad state = 0
May 02 10:44:49 user kernel: iwlwifi 0000:00:14.3: Master Disable Timed 
Out, 100 usec
May 02 10:44:49 user NetworkManager[383]: <warn> [1619945089.7832] 
platform-linux: do-change-link[2]: failure changing link: failure 110 
(Connection timed out)
May 02 10:44:49 user NetworkManager[383]: <info> [1619945089.7832] 
device (wlp0s20f3): state change: prepare -> failed (reason 
'config-failed', sys-iface-state: 'managed')
May 02 10:44:49 user NetworkManager[383]: <info> [1619945089.7836] 
manager: NetworkManager state is now DISCONNECTED
May 02 10:44:49 user NetworkManager[383]: <info> [1619945089.7841] 
device (wlp0s20f3): set-hw-addr: set MAC address to *redacted* (scanning)
May 02 10:44:51 user systemd[1]: NetworkManager-dispatcher.service: 
Deactivated successfully.
May 02 10:44:51 user audit[1]: SERVICE_STOP pid=1 uid=0 auid=4294967295 
ses=4294967295 msg='unit=NetworkManager-dispatcher comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 02 10:44:51 user kernel: audit: type=1131 audit(1619945091.579:198): 
pid=1 uid=0 auid=4294967295 ses=4294967295 
msg='unit=NetworkManager-dispatcher comm="systemd" 
exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: Failed to load 
firmware chunk!
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: Could not load the 
[0] uCode section
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: Failed to start INIT 
ucode: -110
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: Failed to run INIT 
ucode: -110
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: Failed to start RT 
ucode: -110
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: iwl_trans_send_cmd 
bad state = 0
May 02 10:44:54 user kernel: iwlwifi 0000:00:14.3: Master Disable Timed 
Out, 100 usec
May 02 10:44:54 user NetworkManager[383]: <warn> [1619945094.9015] 
platform-linux: do-change-link[2]: failure changing link: failure 110 
(Connection timed out)
May 02 10:44:54 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:44:54 user NetworkManager[383]: <warn> [1619945094.9023] 
device (wlp0s20f3): Activation: failed for connection 'Network'
May 02 10:44:54 user NetworkManager[383]: <info> [1619945094.9045] 
device (wlp0s20f3): supplicant interface state: disconnected -> 
interface_disabled
May 02 10:44:54 user NetworkManager[383]: <info> [1619945094.9045] 
device (p2p-dev-wlp0s20f3): supplicant management interface state: 
disconnected -> interface_disabled
May 02 10:44:54 user NetworkManager[383]: <info> [1619945094.9056] 
device (wlp0s20f3): state change: failed -> disconnected (reason 'none', 
sys-iface-state: 'managed')
May 02 10:44:54 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:44:58 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:45:03 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:45:10 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:45:10 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:45:20 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:45:34 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:45:54 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:46:21 user rtkit-daemon[5045]: Supervising 1 threads of 1 
processes of 1 users.
May 02 10:46:21 user rtkit-daemon[5045]: Supervising 1 threads of 1 
processes of 1 users.
May 02 10:46:23 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100
May 02 10:47:06 user wpa_supplicant[385]: wlp0s20f3: 
CTRL-EVENT-SCAN-FAILED ret=-100


