Return-Path: <linux-wireless+bounces-1254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96D81CC35
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D712F284502
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 15:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0BE2375A;
	Fri, 22 Dec 2023 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FKtmvUAo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5CA23753
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f9f24e7b1so2001626d6.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 07:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703258931; x=1703863731; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VbwcJg7bnB3m+zMob+epuW6L+kJ5aXiNdGW66C4z26g=;
        b=FKtmvUAoG1DO6s/vslBHrvmEdnQRRr8tg9lUfoBYl0raj/wf/zpJUMAmw/b8TUphWw
         OQG/0hH0+2LSIM0zX8BR/L0iPzlM3OX8bgDfKantTvK9WYjrBgJxRhWONGRZkgfGfG5U
         kZfNXSzSN+K0rX49eBfrdUZ4aIbgl3K5qfw0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703258931; x=1703863731;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbwcJg7bnB3m+zMob+epuW6L+kJ5aXiNdGW66C4z26g=;
        b=Gx5k7ARngh3bQUjxnJwDsyPAoDUnQ6zfnnrmsgEB/6A5Q+Yjff7/AXKBrI3SG6LtrQ
         ru6AvmrfP0EhX4tf3rkC1WYYkZp1Vq5bZVWY1r9jhzrgY/E84uwjPO0mN/ovChx/o06t
         QhM2xc0ra3KZOjeDCS8SjnglQUK0lbFTj981WRik73F5K0FOckc3CEF2CNkzqUsZibwo
         +F7HH9DdMerDK4t+oelyEYfLi+OrzERrmaLOdlMCv+J8BLHP420wOYJKeThcIQ/+41eS
         trgGvqNluPlaIPO2xJ3P1jaE9Oq9d+McJnAdGHaKjXVNBsoo+u/fl6PlSF4dqJAcZBlw
         4MWw==
X-Gm-Message-State: AOJu0YzcgO9CZooCmUiAHDCqieF9vRI42MRf05wnaX3WdTR2MRHiYHSo
	Mbj1f9lLL2tPiD17Yg6i1swCBdyeYmrhMXUTaoxORCjXKxgE6lQ=
X-Google-Smtp-Source: AGHT+IEKBphpiE1w4WdURkvSqY0kUYyc/gYwNVaFZKJtFlJwrGZ9MWrqgEVlZYeK4eSN0dkB1oMt3g==
X-Received: by 2002:a05:6214:ccf:b0:67f:9179:5416 with SMTP id 15-20020a0562140ccf00b0067f91795416mr1576081qvx.92.1703258931112;
        Fri, 22 Dec 2023 07:28:51 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id mg7-20020a056214560700b0067f82827611sm1191221qvb.107.2023.12.22.07.28.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Dec 2023 07:28:50 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Stefan Wahren <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>
Date: Fri, 22 Dec 2023 16:28:46 +0100
Message-ID: <18c9224abb0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18c921b1690.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <d9c9336a-6314-4de9-aead-8b865bb30f05@gmx.net>
 <18bbf6acf10.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <cb07408d-af14-4b01-bd96-15c480989643@gmx.net>
 <5c462fac-b27d-41c0-a62c-a8951bf445d2@gmx.net>
 <d8f7dc94-40f5-4544-9693-01d7cbc6fefb@broadcom.com>
 <ca0fd1c5-380d-4756-a33a-cb6c84014ce4@gmx.net>
 <89d3f34a-3427-4871-971c-d960a16918ac@broadcom.com>
 <004dabc3-c345-4d90-9348-5caa9b1f3849@gmx.net>
 <c3996f70-bb2a-4d26-a7e9-a1b062fa0474@broadcom.com>
 <0e5eba2f-e524-4f0d-8217-2770c57ad5ed@gmx.net>
 <18c8d7da558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <f3af378f-fae4-4a98-a5b1-24173d17b64e@gmx.net>
 <18c921b1690.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
User-Agent: AquaMail/1.49.0 (build: 104900403)
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000929c6c060d1adf03"

--000000000000929c6c060d1adf03
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit



On December 22, 2023 4:18:19 PM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

> On December 21, 2023 7:40:46 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>
>> Hi Arend,
>>
>> Am 21.12.23 um 18:47 schrieb Arend Van Spriel:
>>>
>>>
>>> On November 18, 2023 12:43:24 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>>>
>>>> Hi Arend,
>>>>
>>>> Am 15.11.23 um 21:09 schrieb Arend van Spriel:
>>>>> On 11/15/2023 7:35 PM, Stefan Wahren wrote:
>>>>>> Am 15.11.23 um 10:34 schrieb Arend van Spriel:
>>>>>>> On 11/13/2023 10:02 PM, Stefan Wahren wrote:
>>>>>>>> Hi Arend,
>>>>>>>>
>>>>>>>> Am 13.11.23 um 10:11 schrieb Arend van Spriel:
>>>>>>>>> On 11/11/2023 9:30 PM, Stefan Wahren wrote:
>>>>>>>>>> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>>>>>>>>>>
>>>>>>>>>>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>>>>>>>>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net>
>>>>>>>>>>>> wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Again look like these are disabled channels. At least chanspec
>>>>>>>>>>>> 0xd022
>>>>>>>>>>>> is 5G channel 34. You say you get this only once so not every 60
>>>>>>>>>>>> seconds?
>>>>>>>>>>> I get this everytime i trigger a reconnect to the wifi
>>>>>>>>>>> network, so
>>>>>>>>>>> not
>>>>>>>>>>> periodically (checked that). Strangely the initial automatic
>>>>>>>>>>> connect
>>>>>>>>>>> doesn't trigger this errors.
>>>>>>>>>> I additionally placed a WARN_ON_ONCE after the error log and
>>>>>>>>>> enabled the
>>>>>>>>>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>>>>>>>>>
>>>>>>>>> It does a bit. At least it shows this is happening with the
>>>>>>>>> dump_survey (again). I don't really understand why though. It
>>>>>>>>> implies
>>>>>>>>> the channel is not disabled, but unclear why. The channel flags are
>>>>>>>>> changed in brcmf_construct_chaninfo() so we probably should focus
>>>>>>>>> debug on that function.
>>>>>>>>
>>>>>>>> i placed a pr_err at the start of brcmf_construct_chaninfo and
>>>>>>>> another
>>>>>>>> pr_err into the for loop before the "if (channel->orig_flags &
>>>>>>>> IEEE80211_CHAN_DISABLED) continue".
>>>>>>>>
>>>>>>>> pr_err("%s: Ch num %d, chanspec 0x%x, orig_flags: %x.\n", __func__,
>>>>>>>> ch.control_ch_num, ch.chspec, channel->orig_flags);
>>>>>>>>
>>>>>>>> It seems that brcmf_construct_chaninfo is called two times, but the
>>>>>>>> results are different. I could find 0xd090 in the first run, but
>>>>>>>> not in
>>>>>>>> second. The other chanspecs doesn't seem to occur in both runs. No
>>>>>>>> idea
>>>>>>>> what's going on here.
>>>>>>>
>>>>>>> Can you print all wiphy band channels before exiting
>>>>>>> brcmf_construct_chaninfo() and print both channel->orig_flags and
>>>>>>> channel->flags?
>>>>>>
>>>>>> Sure. It seems that in the first call of brcmf_construct_chaninfo the
>>>>>> channel 144 is not disabled, but in the second.
>>>>>
>>>>> I am a bit confused. So the chanspec as mentioned in this email
>>>>> subject is no longer observed, but you still see failure in
>>>>> brcmf_set_channel() for other chanspecs?
>>>>
>>>> before we dive deeper into this let me summarize my observations from
>>>> the beginning. From my understanding the errors are triggered for the 5
>>>> GHz channels 34, 38, 42, 46, 144 (chanspec: 0xd022, 0xd026, 0xd02a,
>>>> 0xd090). So i would focus my observations on those.
>>>>
>>>> As you said that the channel flags are set in brcmf_construct_chaninfo()
>>>> i dump them, here is the output of the first call:
>>>>
>>>> [    8.785850] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 00080000,
>>>> flags 00000001
>>>> [    8.785861] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 00080000,
>>>> flags 00000001
>>>> [    8.785872] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 00080000,
>>>> flags 00000001
>>>> [    8.785882] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 00080000,
>>>> flags 00000001
>>>> [    8.785974] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags: 00080000,
>>>> flags 0000011a
>>>>
>>>> All of them except 144 are disabled via flags. Btw wpa_supplicant is
>>>> configured to country DE within the configuration.
>>>>
>>>> The second and last time brcmf_construct_chaninfo() is called is a few
>>>> seconds later during boot, we get the following:
>>>>
>>>> [   12.490877] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 00080000,
>>>> flags 00000001
>>>> [   12.490891] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 00080000,
>>>> flags 00000001
>>>> [   12.490904] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 00080000,
>>>> flags 00000001
>>>> [   12.490918] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 00080000,
>>>> flags 00000001
>>>> [   12.491031] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags: 00080000,
>>>> flags 00000001
>>>>
>>>> Now all of them are disabled via flags.
>>>>
>>>> So after that i trigger the reconnect to the same 5 GHz network as
>>>> before. brcmf_construct_chaninfo is never called again, but at the time
>>>> brcmf_set_channel is called the flags for these channels are completely
>>>> different:
>>>>
>>>> [   90.010002] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
>>>> reason -52
>>>> [   90.010017] brcmfmac: hw_value 34, orig_flags: 00080000, flags
>>>> 00080220
>>>> [   90.120007] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>>>> [   90.120038] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
>>>> reason -52
>>>> [   90.120053] brcmfmac: hw_value 38, orig_flags: 00080000, flags
>>>> 00080200
>>>> [   90.230029] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>>>> [   90.230058] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
>>>> reason -52
>>>> [   90.230073] brcmfmac: hw_value 42, orig_flags: 00080000, flags
>>>> 00080200
>>>> [   90.340042] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>>>> [   90.340071] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
>>>> reason -52
>>>> [   90.340086] brcmfmac: hw_value 46, orig_flags: 00080000, flags
>>>> 00080210
>>>> [   92.100073] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>>>> [   92.100110] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
>>>> reason -52
>>>> [   92.100126] brcmfmac: hw_value 144, orig_flags: 00080000, flags
>>>> 00080118
>>>>
>>>> Where does these new flags come from? It's clear that these doesn't come
>>>> from brcmf_construct_chaninfo(). So what manipulates the flags
>>>> afterwards? Shouldn't brcmf_construct_chaninfo() called on reconnect?
>>>
>>> I suspect it is not the driver, but net/wireless/reg.c. Could you
>>> define DEBUG in top of that file and build cfg80211.ko with that. Or
>>> if you have CONFIG_DYNAMIC_DEBUG enable debug prints for reg.c through
>>> sysfs [1]
>> Sure, this is a more recent Linux 6.7 and the disconnect is at uptime
>> ~316s followed by the reconnect:
>>
>> [    0.000000] Booting Linux on physical CPU 0x0
>> [    0.000000] Linux version 6.7.0-rc6-00022-g55cb5f43689d-dirty
>> (stefanw@stefanw-SCHENKER) (arm-linux-gnueabihf-gcc (GCC) 11.3.1
>> 20220604 [releases/gcc-11 revision
>> 591c0f4b92548e3ae2e8173f4f93984b1c7f62bb], GNU ld
>> (Linaro_Binutils-2022.06) 2.37.20220122) #175 SMP Thu Dec 21 19:15:10
>> CET 2023
>> [    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7),
>> cr=10c5383d
>> [    0.000000] CPU: div instructions available: patching division code
>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
>> instruction cache
>> [    0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model B Plus Rev 1.3
>> ...
>> [    9.538797] cfg80211: Loading compiled-in X.509 certificates for
>> regulatory database
>> [    9.699412] usb 1-1.3: USB disconnect, device number 4
>> [    9.716116] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
>> [    9.760066] brcmfmac: brcmf_fw_alloc_request: using
>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>> [    9.770023] cfg80211: loaded regulatory.db is malformed or signature
>> is missing/invalid
>> [    9.770047] cfg80211: Restoring regulatory settings
>> [    9.770057] cfg80211: Kicking the queue
>> [    9.770078] cfg80211: Calling CRDA to update world regulatory domain
>> [    9.801533] Console: switching to colour dummy device 80x30
>> [    9.813535] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops [vc4])
>> [    9.816895] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops [vc4])
>> [    9.817106] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops [vc4])
>> [    9.817282] vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_ops [vc4])
>> [    9.817413] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops
>> vc4_crtc_ops [vc4])
>> [    9.817538] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops
>> vc4_crtc_ops [vc4])
>> [    9.817745] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops
>> vc4_crtc_ops [vc4])
>> [    9.817864] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops [vc4])
>> [    9.823689] Bluetooth: hci0: BCM: chip id 107
>> [    9.825669] Bluetooth: hci0: BCM: features 0x2f
>> [    9.826383] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0
>> [    9.827278] Bluetooth: hci0: BCM4345C0
>> [    9.827291] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
>> [    9.869190] Bluetooth: hci0: BCM4345C0
>> 'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd' Patch
>> [    9.915063] Console: switching to colour frame buffer device 240x75
>> [    9.944429] vc4-drm soc:gpu: [drm] fb0: vc4drmfb frame buffer device
>> [    9.958353] hub 1-1:1.0: USB hub found
>> [    9.958412] hub 1-1:1.0: 4 ports detected
>> [    9.992604] onboard-usb-hub 3f980000.usb:usb-port@1: supply vdd not
>> found, using dummy regulator
>> [    9.994313] onboard-usb-hub 3f980000.usb:usb-port@1:usb-port@1:
>> supply vdd not found, using dummy regulator
>> [    9.995590] hub 1-1:1.0: USB hub found
>> [    9.995690] hub 1-1:1.0: 4 ports detected
>> [    9.998640] onboard-usb-hub 3f980000.usb:usb-port@1:usb-port@1:
>> supply vdd not found, using dummy regulator
>> [   10.086053] usbcore: registered new interface driver lan78xx
>> [   10.094129] brcmfmac: brcmf_c_process_txcap_blob: no txcap_blob
>> available (err=-2)
>> [   10.098005] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0:
>> Nov  1 2021 00:37:25 version 7.45.241 (1a2f2fa CY) FWID 01-703fd60
>> [   10.135643] cfg80211: Ignoring regulatory request set by core since
>> the driver uses its own custom regulatory domain
>> [   10.307704] usb 1-1.1: new high-speed USB device number 7 using dwc2
>> [   10.452108] hub 1-1.1:1.0: USB hub found
>> [   10.452310] hub 1-1.1:1.0: 3 ports detected
>> [   10.557660] usb 1-1.3: new low-speed USB device number 8 using dwc2
>> [   10.726697] input: PixArt Microsoft USB Optical Mouse as
>> /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:045E:00CB.0003/input/input2
>> [   10.727785] hid-generic 0003:045E:00CB.0003: input: USB HID v1.11
>> Mouse [PixArt Microsoft USB Optical Mouse] on usb-3f980000.usb-1.3/input0
>> [   10.797638] usb 1-1.1.2: new low-speed USB device number 9 using dwc2
>> [   10.957069] input: HID 046a:0011 as
>> /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003:046A:0011.0004/input/input3
>> [   11.019525] hid-generic 0003:046A:0011.0004: input: USB HID v1.11
>> Keyboard [HID 046a:0011] on usb-3f980000.usb-1.1.2/input0
>> [   11.048402] Bluetooth: hci0: BCM: features 0x2f
>> [   11.050164] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+-0190
>> [   11.050178] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0382
>> [   11.324175] usb 1-1.1.1: new high-speed USB device number 10 using dwc2
>> [   11.714298] lan78xx 1-1.1.1:1.0 (unnamed net_device) (uninitialized):
>> No External EEPROM. Setting MAC Speed
>> [   11.854291] cfg80211: Pending regulatory request, waiting for it to
>> be processed...
>> [   12.099129] cfg80211: Ignoring regulatory request set by core since
>> the driver uses its own custom regulatory domain
>> [   12.099161] cfg80211: World regulatory domain updated:
>> [   12.099168] cfg80211:  DFS Master region: unset
>> [   12.099174] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [   12.099189] cfg80211:   (755000 KHz - 928000 KHz @ 2000 KHz), (N/A,
>> 2000 mBm), (N/A)
>> [   12.099201] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   12.099213] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz, 92000
>> KHz AUTO), (N/A, 2000 mBm), (N/A)
>> [   12.099224] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   12.099235] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
>> [   12.099248] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [   12.099259] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz),
>> (N/A, 2000 mBm), (0 s)
>> [   12.099269] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   12.099280] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
>> (N/A, 0 mBm), (N/A)
>> [   12.101316] cfg80211: Calling CRDA for country: DE
>> [   12.125129] cfg80211: Disabling freq 2484.000 MHz
>> [   12.176440] cfg80211: Regulatory domain changed to country: DE
>> [   12.176459] cfg80211:  DFS Master region: ETSI
>> [   12.176464] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [   12.176473] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   12.176487] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   12.176496] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [   12.176504] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [   12.176512] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [   12.176521] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   12.176529] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [   13.893866] Adding 102396k swap on /var/swap.  Priority:-2 extents:1
>> across:102396k SS
>> [   14.530323] lan78xx 1-1.1.1:1.0 eth0: Link is Down
>> [   14.641536] Bluetooth: MGMT ver 1.22
>> [   14.689962] NET: Registered PF_ALG protocol family
>> [   14.744513] cryptd: max_cpu_qlen set to 1000
>> [   16.791666] cfg80211: Found new beacon on frequency: 5180.000 MHz (Ch
>> 36) on phy0
>> [   16.791716] cfg80211: Found new beacon on frequency: 5220.000 MHz (Ch
>> 44) on phy0
>> [   20.481971] cfg80211: Calling CRDA for country: DE
>> [   20.501082] cfg80211: Disabling freq 2484.000 MHz
>> [   20.501465] cfg80211: Regulatory domain changed to country: DE
>> [   20.501471] cfg80211:  DFS Master region: ETSI
>> [   20.501475] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [   20.501490] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [   20.501497] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   20.501504] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [   20.501511] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [   20.501517] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [   20.501524] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [   20.501531] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [   46.174010] systemd-journald[125]: Failed to set ACL on
>> /var/log/journal/0b443a02fdd340c68f8aac17d2e5ebf8/user-1000.journal,
>> ignoring: Operation not supported
>> [   84.956286] cfg80211: Verifying active interfaces after reg change
>> [  128.323869] cfg80211: Found new beacon on frequency: 2472.000 MHz (Ch
>> 13) on phy0
>> [  192.477390] cfg80211: Verifying active interfaces after reg change
>> [  316.329988] cfg80211: All devices are disconnected, going to restore
>> regulatory settings
>
> Ok. So here the disconnect happens...
>
>> [  316.330038] cfg80211: Restoring regulatory settings while preserving
>> user preference for: DE
>> [  316.330063] cfg80211: Ignoring regulatory request set by core since
>> the driver uses its own custom regulatory domain
>> [  316.330088] cfg80211: World regulatory domain updated:
>> [  316.330097] cfg80211:  DFS Master region: unset
>> [  316.330104] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [  316.330120] cfg80211:   (2402000 KHz - 2472000 KHz @ 40000 KHz), (600
>> mBi, 2000 mBm), (N/A)
>> [  316.330140] cfg80211:   (2457000 KHz - 2482000 KHz @ 20000 KHz, 92000
>> KHz AUTO), (600 mBi, 2000 mBm), (N/A)
>> [  316.330156] cfg80211:   (2474000 KHz - 2494000 KHz @ 20000 KHz), (600
>> mBi, 2000 mBm), (N/A)
>> [  316.330172] cfg80211:   (5170000 KHz - 5250000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (600 mBi, 2000 mBm), (N/A)
>> [  316.330190] cfg80211:   (5250000 KHz - 5330000 KHz @ 80000 KHz,
>> 160000 KHz AUTO), (600 mBi, 2000 mBm), (0 s)
>> [  316.330206] cfg80211:   (5490000 KHz - 5730000 KHz @ 160000 KHz),
>> (600 mBi, 2000 mBm), (0 s)
>> [  316.330222] cfg80211:   (5735000 KHz - 5835000 KHz @ 80000 KHz), (600
>> mBi, 2000 mBm), (N/A)
>> [  316.330238] cfg80211:   (57240000 KHz - 63720000 KHz @ 2160000 KHz),
>> (N/A, 0 mBm), (N/A)
>> [  316.330307] cfg80211: Disabling freq 2484.000 MHz
>> [  316.340457] cfg80211: Regulatory domain changed to country: DE
>> [  316.340487] cfg80211:  DFS Master region: ETSI
>> [  316.340495] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [  316.340511] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [  316.340529] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [  316.340547] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [  316.340563] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [  316.340577] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [  316.340592] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [  316.340607] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [  316.340643] cfg80211: Kicking the queue
>> [  331.276421] cfg80211: Found new beacon on frequency: 5180.000 MHz (Ch
>> 36) on phy0
>> [  331.276494] cfg80211: Found new beacon on frequency: 5220.000 MHz (Ch
>> 44) on phy0
>> [  331.276562] cfg80211: Found new beacon on frequency: 2472.000 MHz (Ch
>> 13) on phy0
>> [  332.729896] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
>> reason -52
>> [  332.840008] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
>> reason -52
>> [  332.949910] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
>> reason -52
>> [  333.059802] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
>> reason -52
>> [  334.819896] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
>> reason -52
>> [  334.820318] brcmfmac: brcmf_set_channel: set chanspec 0xd095 fail,
>> reason -52
>> [  334.820719] brcmfmac: brcmf_set_channel: set chanspec 0xd099 fail,
>> reason -52
>> [  334.821120] brcmfmac: brcmf_set_channel: set chanspec 0xd09d fail,
>> reason -52
>> [  334.821521] brcmfmac: brcmf_set_channel: set chanspec 0xd0a1 fail,
>> reason -52
>> [  334.821922] brcmfmac: brcmf_set_channel: set chanspec 0xd0a5 fail,
>> reason -52
>
> Do you know if this happens before or after the reconnect has completed?
> You could enable CONN debug level in brcmfmac to determine that.
>
>> [  334.956787] cfg80211: Calling CRDA for country: DE
>
> I guess this message is a bit stale and there is no crda user-mode helper.
>
>> [  334.990709] cfg80211: Disabling freq 2484.000 MHz
>
> So 2GHz channel 14 gets disabled here probably due to country change to DE.
>
> Not learned a whole lot more from this test round except that reg.c is
> active during the reconnect so I suggest to zoom in there. Especially
> around the "restoring" message.

I wonder whether we end up in restore_custom_reg_settings() which does:

chan->flags = chan->orig_flags;

for each channel. That would re-enable those channels. Have you always seen 
this or at certain kernel update or wpa_supplicant maybe?

Regards,
Arend

>
> Regards,
> Arend
>
>> [  334.991199] cfg80211: Regulatory domain changed to country: DE
>> [  334.991212] cfg80211:  DFS Master region: ETSI
>> [  334.991218] cfg80211:   (start_freq - end_freq @ bandwidth),
>> (max_antenna_gain, max_eirp), (dfs_cac_time)
>> [  334.991236] cfg80211:   (2400000 KHz - 2483500 KHz @ 40000 KHz),
>> (N/A, 2000 mBm), (N/A)
>> [  334.991249] cfg80211:   (5150000 KHz - 5250000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [  334.991261] cfg80211:   (5250000 KHz - 5350000 KHz @ 80000 KHz,
>> 200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
>> [  334.991273] cfg80211:   (5470000 KHz - 5725000 KHz @ 160000 KHz),
>> (N/A, 2698 mBm), (0 s)
>> [  334.991284] cfg80211:   (5725000 KHz - 5875000 KHz @ 80000 KHz),
>> (N/A, 1397 mBm), (N/A)
>> [  334.991296] cfg80211:   (5945000 KHz - 6425000 KHz @ 160000 KHz,
>> 480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
>> [  334.991307] cfg80211:   (57000000 KHz - 66000000 KHz @ 2160000 KHz),
>> (N/A, 4000 mBm), (N/A)
>> [  397.278378] cfg80211: Verifying active interfaces after reg change




--000000000000929c6c060d1adf03
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQdwYJKoZIhvcNAQcCoIIQaDCCEGQCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3OMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVYwggQ+oAMCAQICDE79bW6SMzVJMuOi1zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMTQzMjNaFw0yNTA5MTAxMTQzMjNaMIGV
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEFyZW5kIFZhbiBTcHJpZWwxKzApBgkqhkiG
9w0BCQEWHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDxOB8Yu89pZLsG9Ic8ZY3uGibuv+NRsij+E70OMJQIwugrByyNq5xgH0BI22vJ
LT7VKCB6YJC88ewEFfYi3EKW/sn6RL16ImUM40beDmQ12WBquJRoxVNyoByNalmTOBNYR95ZQZJw
1nrzaoJtK0XIsv0dNCUcLlAc+jHkngD+I0ptVuWoMO1BcJexqJf5iX2M1CdC8PXTh9g4FIQnG2mc
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCC/QmANByYpDpNBFSb5
L8vZn+EniAzepLrdxGQYt7NGYjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEyMjIxNTI4NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA13RyHF6df0XdtzJ4UtbXzmc/CGbv7eQhJQsM
PcDbIT3QboYLx0Wl9DNRExJkWl5DtW8nUQlHoGoTdgkwTPaP81FQ7MxBKL4igd0C4VTV3uJrxEKv
fQ1mlOXF1FGsKCUiVjk8C4IUtuUlrSgFssFgjSqWavBeC+FcvG8WKTD0jMMTznQyn7U5G5X4SfiF
37F+EftPpobQMd5IohyPWKlDPC/xJ3u1HsKmyuEx4nN+GOVevBcD+UTiPJWq/Bf+a3MF9cscF7Yp
zhQMXtT1S7nKbFhennT6WPIW+IQ9k3EhZG12nWA/A4rDFzqaWfQVl+v7hGuLBX9ENmIXzPfm+z2V
fw==
--000000000000929c6c060d1adf03--

