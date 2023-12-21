Return-Path: <linux-wireless+bounces-1175-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BED481BE5B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 19:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055EB1F23E07
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3538864A92;
	Thu, 21 Dec 2023 18:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="M+c13E4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4B5B1ED
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1703184037; x=1703788837; i=wahrenst@gmx.net;
	bh=4bHRk8mZfZF6L9FVn/jun4wjyIg4t+C6cTlWbdncev8=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=M+c13E4g1wJNSIm+zAPvQNXs+7sQpqeCjw8H5czo3oz+LDVNJ3rsvORcXcVvqgHE
	 5hutTgy68BAEwFlMAIx1LOi+p6BEstfgTSd1I4BWc15fFj8swc50v+tidgprbUtTl
	 LNSFmP5qoKcn89hVe+amrj6t0FWiNqHu3K3wXo206j3kkDlQE0vKFNCQX9b59VMXX
	 p/+Y618xSnZXmL8H8diuHep8qof61Omb3GO1/lUC5ceafv6sauH/ijUtg568NVewC
	 9TGNIC5Wru49tQsHPoPNjdUEKcUslE7SPs646hjFVJV2YoroQSfK4+5uqyJOCIq0/
	 YFb7IGGJ90+OejkTFQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.130] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MrhQ6-1qtCEL1KQW-00nlZU; Thu, 21
 Dec 2023 19:40:37 +0100
Message-ID: <f3af378f-fae4-4a98-a5b1-24173d17b64e@gmx.net>
Date: Thu, 21 Dec 2023 19:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail,
 reason -52 - Part 2
Content-Language: en-US
To: Arend Van Spriel <arend.vanspriel@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com,
 SHA-cyfmac-dev-list@infineon.com, Hector Martin <marcan@marcan.st>,
 Kalle Valo <kvalo@kernel.org>
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
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <18c8d7da558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1xi07dtUGF4GIv+XbTG98TY6FR2bao3aLC764eKsVBBNY051ErE
 x/wanUZoY8vy/s+X8FbPKNi/5QWmiZjGmf5u3NOdagziJb/cqSh0vtE9505rePMph8oDH/N
 bUMTGoSikaN2bWj65KqMGnFs6Bkj8hboOmNeFKkQ1VQF38kDZV0PtCWGDuQVH2r81Ip+eGn
 XvL6ydQhUj58WaK7mHJmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/6phcYs61AE=;n9/toIueHigOhGf4MxbfBodx4f3
 Y/Wnq6UMBFMYVhYJM9ARURe1VWEZiAV208rsJHryjcq97hyiqtupGM6knGREQJzlm8gQPPUN9
 J+dvv0Dp1J+1tDQI5WRwvqzFwM55UM79+6DjhJmtaCk4ZSl3sUoqXb0vBL3BdS9xaQkRo3dxN
 CtIpLrVc3wJdHrCTZU7bMhUVTdekOjR+Ace4wZ0yuBZopxW6NifZCz9ae0XhM194D6SJ1WZ8O
 2QMGQCmVs05WTPzPvDdo6oeOCiqnWos/ahqcl95HkzuAgd1jzyzG6mLNxCRz48A0l1Ud0H2z5
 GA2wBeXEZSneAZUMIBO0uCT0HhRLWtESLhB3LRJMPxpOE7QeBIqioqaAs0q9UFsIgEQZxB3tP
 qDpv5O8S4iyrXi9GUPV7JzY8gh05vCnHPMr1CRG64NEnb4MEyC7zjcavrNT5l2Ylff0BvSmSG
 Qyb8BmO/lWBwI9DtQ/kmLIFhOwB+F/1HosBfenIvW8IB1r1Y+EAMfqcviit4EkO7r76PqIsmc
 z1LpmSDHu4XpkxF+Ow+7qd16ep0zCXpRV0PpkpNfb0NDPnQTPf4U/VIz+Kp0plZQHjaBE4r7a
 x+eVlbgb7eMSgC2Y28ah7xx12P/SxKaJJUvBdvCxtx+Zou4eOcZmMCX8ZB+ifwHTmxSrUxnVW
 ZAaMpsGsAi3Dc9LqyGbumt+7J22iAECKlEZySqLbyLEeDi1xy27pLuJS896p1Mj2TKp1uJr8Q
 pyTREeLTMzI2sNvTemZbjsTSm6rcPub1GVihSLIb82UEtAG3QscoF+ufOPp7HTwYkEUR3rCSe
 fQvwDUNBWX/GPtXXgjo/Ufi3r6byw2QjMj0PD8A8yZCXmi37xi5tOpn4L6VLPDEfkcJWe3HdM
 utKXZGNy6Do6NHYuByqfcKnCDzERg8afQcd5QeyiO0YkBJ/JJ5aRVDbkQv7mWGt+Riww5kaar
 dCiJC9ALtFt9R2+IbGyiCTEcd6I=

Hi Arend,

Am 21.12.23 um 18:47 schrieb Arend Van Spriel:
>
>
> On November 18, 2023 12:43:24 PM Stefan Wahren <wahrenst@gmx.net> wrote:
>
>> Hi Arend,
>>
>> Am 15.11.23 um 21:09 schrieb Arend van Spriel:
>>> On 11/15/2023 7:35 PM, Stefan Wahren wrote:
>>>> Am 15.11.23 um 10:34 schrieb Arend van Spriel:
>>>>> On 11/13/2023 10:02 PM, Stefan Wahren wrote:
>>>>>> Hi Arend,
>>>>>>
>>>>>> Am 13.11.23 um 10:11 schrieb Arend van Spriel:
>>>>>>> On 11/11/2023 9:30 PM, Stefan Wahren wrote:
>>>>>>>> Am 11.11.23 um 19:29 schrieb Stefan Wahren:
>>>>>>>>>
>>>>>>>>> Am 11.11.23 um 18:25 schrieb Arend Van Spriel:
>>>>>>>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net=
>
>>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Again look like these are disabled channels. At least chanspec
>>>>>>>>>> 0xd022
>>>>>>>>>> is 5G channel 34. You say you get this only once so not every 6=
0
>>>>>>>>>> seconds?
>>>>>>>>> I get this everytime i trigger a reconnect to the wifi
>>>>>>>>> network, so
>>>>>>>>> not
>>>>>>>>> periodically (checked that). Strangely the initial automatic
>>>>>>>>> connect
>>>>>>>>> doesn't trigger this errors.
>>>>>>>> I additionally placed a WARN_ON_ONCE after the error log and
>>>>>>>> enabled the
>>>>>>>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>>>>>>>
>>>>>>> It does a bit. At least it shows this is happening with the
>>>>>>> dump_survey (again). I don't really understand why though. It
>>>>>>> implies
>>>>>>> the channel is not disabled, but unclear why. The channel flags ar=
e
>>>>>>> changed in brcmf_construct_chaninfo() so we probably should focus
>>>>>>> debug on that function.
>>>>>>
>>>>>> i placed a pr_err at the start of brcmf_construct_chaninfo and
>>>>>> another
>>>>>> pr_err into the for loop before the "if (channel->orig_flags &
>>>>>> IEEE80211_CHAN_DISABLED) continue".
>>>>>>
>>>>>> pr_err("%s: Ch num %d, chanspec 0x%x, orig_flags: %x.\n", __func__,
>>>>>> ch.control_ch_num, ch.chspec, channel->orig_flags);
>>>>>>
>>>>>> It seems that brcmf_construct_chaninfo is called two times, but the
>>>>>> results are different. I could find 0xd090 in the first run, but
>>>>>> not in
>>>>>> second. The other chanspecs doesn't seem to occur in both runs. No
>>>>>> idea
>>>>>> what's going on here.
>>>>>
>>>>> Can you print all wiphy band channels before exiting
>>>>> brcmf_construct_chaninfo() and print both channel->orig_flags and
>>>>> channel->flags?
>>>>
>>>> Sure. It seems that in the first call of brcmf_construct_chaninfo the
>>>> channel 144 is not disabled, but in the second.
>>>
>>> I am a bit confused. So the chanspec as mentioned in this email
>>> subject is no longer observed, but you still see failure in
>>> brcmf_set_channel() for other chanspecs?
>>
>> before we dive deeper into this let me summarize my observations from
>> the beginning. From my understanding the errors are triggered for the 5
>> GHz channels 34, 38, 42, 46, 144 (chanspec: 0xd022, 0xd026, 0xd02a,
>> 0xd090). So i would focus my observations on those.
>>
>> As you said that the channel flags are set in brcmf_construct_chaninfo(=
)
>> i dump them, here is the output of the first call:
>>
>> [=C2=A0=C2=A0=C2=A0 8.785850] brcmfmac: 5 GHz: 0: hw_value 34: orig_fla=
gs: 00080000,
>> flags 00000001
>> [=C2=A0=C2=A0=C2=A0 8.785861] brcmfmac: 5 GHz: 2: hw_value 38: orig_fla=
gs: 00080000,
>> flags 00000001
>> [=C2=A0=C2=A0=C2=A0 8.785872] brcmfmac: 5 GHz: 4: hw_value 42: orig_fla=
gs: 00080000,
>> flags 00000001
>> [=C2=A0=C2=A0=C2=A0 8.785882] brcmfmac: 5 GHz: 6: hw_value 46: orig_fla=
gs: 00080000,
>> flags 00000001
>> [=C2=A0=C2=A0=C2=A0 8.785974] brcmfmac: 5 GHz: 23: hw_value 144: orig_f=
lags: 00080000,
>> flags 0000011a
>>
>> All of them except 144 are disabled via flags. Btw wpa_supplicant is
>> configured to country DE within the configuration.
>>
>> The second and last time brcmf_construct_chaninfo() is called is a few
>> seconds later during boot, we get the following:
>>
>> [=C2=A0=C2=A0 12.490877] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 0=
0080000,
>> flags 00000001
>> [=C2=A0=C2=A0 12.490891] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 0=
0080000,
>> flags 00000001
>> [=C2=A0=C2=A0 12.490904] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 0=
0080000,
>> flags 00000001
>> [=C2=A0=C2=A0 12.490918] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 0=
0080000,
>> flags 00000001
>> [=C2=A0=C2=A0 12.491031] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags:=
 00080000,
>> flags 00000001
>>
>> Now all of them are disabled via flags.
>>
>> So after that i trigger the reconnect to the same 5 GHz network as
>> before. brcmf_construct_chaninfo is never called again, but at the time
>> brcmf_set_channel is called the flags for these channels are completely
>> different:
>>
>> [=C2=A0=C2=A0 90.010002] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
22 fail,
>> reason -52
>> [=C2=A0=C2=A0 90.010017] brcmfmac: hw_value 34, orig_flags: 00080000, f=
lags
>> 00080220
>> [=C2=A0=C2=A0 90.120007] ieee80211 phy0: brcmf_fil_cmd_data: Firmware e=
rror: (-20)
>> [=C2=A0=C2=A0 90.120038] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
26 fail,
>> reason -52
>> [=C2=A0=C2=A0 90.120053] brcmfmac: hw_value 38, orig_flags: 00080000, f=
lags
>> 00080200
>> [=C2=A0=C2=A0 90.230029] ieee80211 phy0: brcmf_fil_cmd_data: Firmware e=
rror: (-20)
>> [=C2=A0=C2=A0 90.230058] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
2a fail,
>> reason -52
>> [=C2=A0=C2=A0 90.230073] brcmfmac: hw_value 42, orig_flags: 00080000, f=
lags
>> 00080200
>> [=C2=A0=C2=A0 90.340042] ieee80211 phy0: brcmf_fil_cmd_data: Firmware e=
rror: (-20)
>> [=C2=A0=C2=A0 90.340071] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
2e fail,
>> reason -52
>> [=C2=A0=C2=A0 90.340086] brcmfmac: hw_value 46, orig_flags: 00080000, f=
lags
>> 00080210
>> [=C2=A0=C2=A0 92.100073] ieee80211 phy0: brcmf_fil_cmd_data: Firmware e=
rror: (-20)
>> [=C2=A0=C2=A0 92.100110] brcmfmac: brcmf_set_channel: set chanspec 0xd0=
90 fail,
>> reason -52
>> [=C2=A0=C2=A0 92.100126] brcmfmac: hw_value 144, orig_flags: 00080000, =
flags
>> 00080118
>>
>> Where does these new flags come from? It's clear that these doesn't com=
e
>> from brcmf_construct_chaninfo(). So what manipulates the flags
>> afterwards? Shouldn't brcmf_construct_chaninfo() called on reconnect?
>
> I suspect it is not the driver, but net/wireless/reg.c. Could you
> define DEBUG in top of that file and build cfg80211.ko with that. Or
> if you have CONFIG_DYNAMIC_DEBUG enable debug prints for reg.c through
> sysfs [1]
>
Sure, this is a more recent Linux 6.7 and the disconnect is at uptime
~316s followed by the reconnect:

[=C2=A0=C2=A0=C2=A0 0.000000] Booting Linux on physical CPU 0x0
[=C2=A0=C2=A0=C2=A0 0.000000] Linux version 6.7.0-rc6-00022-g55cb5f43689d-=
dirty
(stefanw@stefanw-SCHENKER) (arm-linux-gnueabihf-gcc (GCC) 11.3.1
20220604 [releases/gcc-11 revision
591c0f4b92548e3ae2e8173f4f93984b1c7f62bb], GNU ld
(Linaro_Binutils-2022.06) 2.37.20220122) #175 SMP Thu Dec 21 19:15:10
CET 2023
[=C2=A0=C2=A0=C2=A0 0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (=
ARMv7),
cr=3D10c5383d
[=C2=A0=C2=A0=C2=A0 0.000000] CPU: div instructions available: patching di=
vision code
[=C2=A0=C2=A0=C2=A0 0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIP=
T aliasing
instruction cache
[=C2=A0=C2=A0=C2=A0 0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model=
 B Plus Rev 1.3
...
[=C2=A0=C2=A0=C2=A0 9.538797] cfg80211: Loading compiled-in X.509 certific=
ates for
regulatory database
[=C2=A0=C2=A0=C2=A0 9.699412] usb 1-1.3: USB disconnect, device number 4
[=C2=A0=C2=A0=C2=A0 9.716116] Loaded X.509 cert 'sforshee: 00b28ddf47aef9c=
ea7'
[=C2=A0=C2=A0=C2=A0 9.760066] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[=C2=A0=C2=A0=C2=A0 9.770023] cfg80211: loaded regulatory.db is malformed =
or signature
is missing/invalid
[=C2=A0=C2=A0=C2=A0 9.770047] cfg80211: Restoring regulatory settings
[=C2=A0=C2=A0=C2=A0 9.770057] cfg80211: Kicking the queue
[=C2=A0=C2=A0=C2=A0 9.770078] cfg80211: Calling CRDA to update world regul=
atory domain
[=C2=A0=C2=A0=C2=A0 9.801533] Console: switching to colour dummy device 80=
x30
[=C2=A0=C2=A0=C2=A0 9.813535] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4=
_hvs_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.816895] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc=
4_hdmi_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.817106] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4=
_vec_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.817282] vc4-drm soc:gpu: bound 3f004000.txp (ops vc4=
_txp_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.817413] vc4-drm soc:gpu: bound 3f206000.pixelvalve (=
ops
vc4_crtc_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.817538] vc4-drm soc:gpu: bound 3f207000.pixelvalve (=
ops
vc4_crtc_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.817745] vc4-drm soc:gpu: bound 3f807000.pixelvalve (=
ops
vc4_crtc_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.817864] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4=
_v3d_ops [vc4])
[=C2=A0=C2=A0=C2=A0 9.823689] Bluetooth: hci0: BCM: chip id 107
[=C2=A0=C2=A0=C2=A0 9.825669] Bluetooth: hci0: BCM: features 0x2f
[=C2=A0=C2=A0=C2=A0 9.826383] [drm] Initialized vc4 0.0.0 20140616 for soc=
:gpu on minor 0
[=C2=A0=C2=A0=C2=A0 9.827278] Bluetooth: hci0: BCM4345C0
[=C2=A0=C2=A0=C2=A0 9.827291] Bluetooth: hci0: BCM4345C0 (003.001.025) bui=
ld 0000
[=C2=A0=C2=A0=C2=A0 9.869190] Bluetooth: hci0: BCM4345C0
'brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd' Patch
[=C2=A0=C2=A0=C2=A0 9.915063] Console: switching to colour frame buffer de=
vice 240x75
[=C2=A0=C2=A0=C2=A0 9.944429] vc4-drm soc:gpu: [drm] fb0: vc4drmfb frame b=
uffer device
[=C2=A0=C2=A0=C2=A0 9.958353] hub 1-1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 9.958412] hub 1-1:1.0: 4 ports detected
[=C2=A0=C2=A0=C2=A0 9.992604] onboard-usb-hub 3f980000.usb:usb-port@1: sup=
ply vdd not
found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 9.994313] onboard-usb-hub 3f980000.usb:usb-port@1:usb-=
port@1:
supply vdd not found, using dummy regulator
[=C2=A0=C2=A0=C2=A0 9.995590] hub 1-1:1.0: USB hub found
[=C2=A0=C2=A0=C2=A0 9.995690] hub 1-1:1.0: 4 ports detected
[=C2=A0=C2=A0=C2=A0 9.998640] onboard-usb-hub 3f980000.usb:usb-port@1:usb-=
port@1:
supply vdd not found, using dummy regulator
[=C2=A0=C2=A0 10.086053] usbcore: registered new interface driver lan78xx
[=C2=A0=C2=A0 10.094129] brcmfmac: brcmf_c_process_txcap_blob: no txcap_bl=
ob
available (err=3D-2)
[=C2=A0=C2=A0 10.098005] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM434=
5/6 wl0:
Nov=C2=A0 1 2021 00:37:25 version 7.45.241 (1a2f2fa CY) FWID 01-703fd60
[=C2=A0=C2=A0 10.135643] cfg80211: Ignoring regulatory request set by core=
 since
the driver uses its own custom regulatory domain
[=C2=A0=C2=A0 10.307704] usb 1-1.1: new high-speed USB device number 7 usi=
ng dwc2
[=C2=A0=C2=A0 10.452108] hub 1-1.1:1.0: USB hub found
[=C2=A0=C2=A0 10.452310] hub 1-1.1:1.0: 3 ports detected
[=C2=A0=C2=A0 10.557660] usb 1-1.3: new low-speed USB device number 8 usin=
g dwc2
[=C2=A0=C2=A0 10.726697] input: PixArt Microsoft USB Optical Mouse as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:045E:00CB=
.0003/input/input2
[=C2=A0=C2=A0 10.727785] hid-generic 0003:045E:00CB.0003: input: USB HID v=
1.11
Mouse [PixArt Microsoft USB Optical Mouse] on usb-3f980000.usb-1.3/input0
[=C2=A0=C2=A0 10.797638] usb 1-1.1.2: new low-speed USB device number 9 us=
ing dwc2
[=C2=A0=C2=A0 10.957069] input: HID 046a:0011 as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1.2/1-1.1.2:1.0/0003=
:046A:0011.0004/input/input3
[=C2=A0=C2=A0 11.019525] hid-generic 0003:046A:0011.0004: input: USB HID v=
1.11
Keyboard [HID 046a:0011] on usb-3f980000.usb-1.1.2/input0
[=C2=A0=C2=A0 11.048402] Bluetooth: hci0: BCM: features 0x2f
[=C2=A0=C2=A0 11.050164] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+=
-0190
[=C2=A0=C2=A0 11.050178] Bluetooth: hci0: BCM4345C0 (003.001.025) build 03=
82
[=C2=A0=C2=A0 11.324175] usb 1-1.1.1: new high-speed USB device number 10 =
using dwc2
[=C2=A0=C2=A0 11.714298] lan78xx 1-1.1.1:1.0 (unnamed net_device) (uniniti=
alized):
No External EEPROM. Setting MAC Speed
[=C2=A0=C2=A0 11.854291] cfg80211: Pending regulatory request, waiting for=
 it to
be processed...
[=C2=A0=C2=A0 12.099129] cfg80211: Ignoring regulatory request set by core=
 since
the driver uses its own custom regulatory domain
[=C2=A0=C2=A0 12.099161] cfg80211: World regulatory domain updated:
[=C2=A0=C2=A0 12.099168] cfg80211:=C2=A0 DFS Master region: unset
[=C2=A0=C2=A0 12.099174] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ ba=
ndwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0=C2=A0 12.099189] cfg80211:=C2=A0=C2=A0 (755000 KHz - 928000 KHz @ =
2000 KHz), (N/A,
2000 mBm), (N/A)
[=C2=A0=C2=A0 12.099201] cfg80211:=C2=A0=C2=A0 (2402000 KHz - 2472000 KHz =
@ 40000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 12.099213] cfg80211:=C2=A0=C2=A0 (2457000 KHz - 2482000 KHz =
@ 20000 KHz, 92000
KHz AUTO), (N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 12.099224] cfg80211:=C2=A0=C2=A0 (2474000 KHz - 2494000 KHz =
@ 20000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 12.099235] cfg80211:=C2=A0=C2=A0 (5170000 KHz - 5250000 KHz =
@ 80000 KHz,
160000 KHz AUTO), (N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 12.099248] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5330000 KHz =
@ 80000 KHz,
160000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 12.099259] cfg80211:=C2=A0=C2=A0 (5490000 KHz - 5730000 KHz =
@ 160000 KHz),
(N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 12.099269] cfg80211:=C2=A0=C2=A0 (5735000 KHz - 5835000 KHz =
@ 80000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 12.099280] cfg80211:=C2=A0=C2=A0 (57240000 KHz - 63720000 KH=
z @ 2160000 KHz),
(N/A, 0 mBm), (N/A)
[=C2=A0=C2=A0 12.101316] cfg80211: Calling CRDA for country: DE
[=C2=A0=C2=A0 12.125129] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0=C2=A0 12.176440] cfg80211: Regulatory domain changed to country: D=
E
[=C2=A0=C2=A0 12.176459] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0=C2=A0 12.176464] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ ba=
ndwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0=C2=A0 12.176473] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz =
@ 40000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 12.176487] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 12.176496] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 12.176504] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz =
@ 160000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0=C2=A0 12.176512] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz =
@ 80000 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0=C2=A0 12.176521] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz =
@ 160000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 12.176529] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KH=
z @ 2160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0=C2=A0 13.893866] Adding 102396k swap on /var/swap.=C2=A0 Priority:=
-2 extents:1
across:102396k SS
[=C2=A0=C2=A0 14.530323] lan78xx 1-1.1.1:1.0 eth0: Link is Down
[=C2=A0=C2=A0 14.641536] Bluetooth: MGMT ver 1.22
[=C2=A0=C2=A0 14.689962] NET: Registered PF_ALG protocol family
[=C2=A0=C2=A0 14.744513] cryptd: max_cpu_qlen set to 1000
[=C2=A0=C2=A0 16.791666] cfg80211: Found new beacon on frequency: 5180.000=
 MHz (Ch
36) on phy0
[=C2=A0=C2=A0 16.791716] cfg80211: Found new beacon on frequency: 5220.000=
 MHz (Ch
44) on phy0
[=C2=A0=C2=A0 20.481971] cfg80211: Calling CRDA for country: DE
[=C2=A0=C2=A0 20.501082] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0=C2=A0 20.501465] cfg80211: Regulatory domain changed to country: D=
E
[=C2=A0=C2=A0 20.501471] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0=C2=A0 20.501475] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ ba=
ndwidth),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0=C2=A0 20.501490] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz =
@ 40000 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0=C2=A0 20.501497] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 20.501504] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz =
@ 80000 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0=C2=A0 20.501511] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz =
@ 160000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0=C2=A0 20.501517] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz =
@ 80000 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0=C2=A0 20.501524] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz =
@ 160000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0=C2=A0 20.501531] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KH=
z @ 2160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0=C2=A0 46.174010] systemd-journald[125]: Failed to set ACL on
/var/log/journal/0b443a02fdd340c68f8aac17d2e5ebf8/user-1000.journal,
ignoring: Operation not supported
[=C2=A0=C2=A0 84.956286] cfg80211: Verifying active interfaces after reg c=
hange
[=C2=A0 128.323869] cfg80211: Found new beacon on frequency: 2472.000 MHz =
(Ch
13) on phy0
[=C2=A0 192.477390] cfg80211: Verifying active interfaces after reg change
[=C2=A0 316.329988] cfg80211: All devices are disconnected, going to resto=
re
regulatory settings
[=C2=A0 316.330038] cfg80211: Restoring regulatory settings while preservi=
ng
user preference for: DE
[=C2=A0 316.330063] cfg80211: Ignoring regulatory request set by core sinc=
e
the driver uses its own custom regulatory domain
[=C2=A0 316.330088] cfg80211: World regulatory domain updated:
[=C2=A0 316.330097] cfg80211:=C2=A0 DFS Master region: unset
[=C2=A0 316.330104] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwid=
th),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0 316.330120] cfg80211:=C2=A0=C2=A0 (2402000 KHz - 2472000 KHz @ 400=
00 KHz), (600
mBi, 2000 mBm), (N/A)
[=C2=A0 316.330140] cfg80211:=C2=A0=C2=A0 (2457000 KHz - 2482000 KHz @ 200=
00 KHz, 92000
KHz AUTO), (600 mBi, 2000 mBm), (N/A)
[=C2=A0 316.330156] cfg80211:=C2=A0=C2=A0 (2474000 KHz - 2494000 KHz @ 200=
00 KHz), (600
mBi, 2000 mBm), (N/A)
[=C2=A0 316.330172] cfg80211:=C2=A0=C2=A0 (5170000 KHz - 5250000 KHz @ 800=
00 KHz,
160000 KHz AUTO), (600 mBi, 2000 mBm), (N/A)
[=C2=A0 316.330190] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5330000 KHz @ 800=
00 KHz,
160000 KHz AUTO), (600 mBi, 2000 mBm), (0 s)
[=C2=A0 316.330206] cfg80211:=C2=A0=C2=A0 (5490000 KHz - 5730000 KHz @ 160=
000 KHz),
(600 mBi, 2000 mBm), (0 s)
[=C2=A0 316.330222] cfg80211:=C2=A0=C2=A0 (5735000 KHz - 5835000 KHz @ 800=
00 KHz), (600
mBi, 2000 mBm), (N/A)
[=C2=A0 316.330238] cfg80211:=C2=A0=C2=A0 (57240000 KHz - 63720000 KHz @ 2=
160000 KHz),
(N/A, 0 mBm), (N/A)
[=C2=A0 316.330307] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0 316.340457] cfg80211: Regulatory domain changed to country: DE
[=C2=A0 316.340487] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0 316.340495] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwid=
th),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0 316.340511] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz @ 400=
00 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0 316.340529] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz @ 800=
00 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0 316.340547] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz @ 800=
00 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0 316.340563] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz @ 160=
000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0 316.340577] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz @ 800=
00 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0 316.340592] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz @ 160=
000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0 316.340607] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KHz @ 2=
160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0 316.340643] cfg80211: Kicking the queue
[=C2=A0 331.276421] cfg80211: Found new beacon on frequency: 5180.000 MHz =
(Ch
36) on phy0
[=C2=A0 331.276494] cfg80211: Found new beacon on frequency: 5220.000 MHz =
(Ch
44) on phy0
[=C2=A0 331.276562] cfg80211: Found new beacon on frequency: 2472.000 MHz =
(Ch
13) on phy0
[=C2=A0 332.729896] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
reason -52
[=C2=A0 332.840008] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
reason -52
[=C2=A0 332.949910] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
reason -52
[=C2=A0 333.059802] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
reason -52
[=C2=A0 334.819896] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
reason -52
[=C2=A0 334.820318] brcmfmac: brcmf_set_channel: set chanspec 0xd095 fail,
reason -52
[=C2=A0 334.820719] brcmfmac: brcmf_set_channel: set chanspec 0xd099 fail,
reason -52
[=C2=A0 334.821120] brcmfmac: brcmf_set_channel: set chanspec 0xd09d fail,
reason -52
[=C2=A0 334.821521] brcmfmac: brcmf_set_channel: set chanspec 0xd0a1 fail,
reason -52
[=C2=A0 334.821922] brcmfmac: brcmf_set_channel: set chanspec 0xd0a5 fail,
reason -52
[=C2=A0 334.956787] cfg80211: Calling CRDA for country: DE
[=C2=A0 334.990709] cfg80211: Disabling freq 2484.000 MHz
[=C2=A0 334.991199] cfg80211: Regulatory domain changed to country: DE
[=C2=A0 334.991212] cfg80211:=C2=A0 DFS Master region: ETSI
[=C2=A0 334.991218] cfg80211:=C2=A0=C2=A0 (start_freq - end_freq @ bandwid=
th),
(max_antenna_gain, max_eirp), (dfs_cac_time)
[=C2=A0 334.991236] cfg80211:=C2=A0=C2=A0 (2400000 KHz - 2483500 KHz @ 400=
00 KHz),
(N/A, 2000 mBm), (N/A)
[=C2=A0 334.991249] cfg80211:=C2=A0=C2=A0 (5150000 KHz - 5250000 KHz @ 800=
00 KHz,
200000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0 334.991261] cfg80211:=C2=A0=C2=A0 (5250000 KHz - 5350000 KHz @ 800=
00 KHz,
200000 KHz AUTO), (N/A, 2000 mBm), (0 s)
[=C2=A0 334.991273] cfg80211:=C2=A0=C2=A0 (5470000 KHz - 5725000 KHz @ 160=
000 KHz),
(N/A, 2698 mBm), (0 s)
[=C2=A0 334.991284] cfg80211:=C2=A0=C2=A0 (5725000 KHz - 5875000 KHz @ 800=
00 KHz),
(N/A, 1397 mBm), (N/A)
[=C2=A0 334.991296] cfg80211:=C2=A0=C2=A0 (5945000 KHz - 6425000 KHz @ 160=
000 KHz,
480000 KHz AUTO), (N/A, 2301 mBm), (N/A)
[=C2=A0 334.991307] cfg80211:=C2=A0=C2=A0 (57000000 KHz - 66000000 KHz @ 2=
160000 KHz),
(N/A, 4000 mBm), (N/A)
[=C2=A0 397.278378] cfg80211: Verifying active interfaces after reg change

