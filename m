Return-Path: <linux-wireless+bounces-1174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8F781BD98
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C20121C25019
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98204634E6;
	Thu, 21 Dec 2023 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RvgCYFcM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F276281A
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d2376db79so8470445e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 09:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1703181029; x=1703785829; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pz1yuj0Wr8dVhZXC4CPmwpwjkvl5wDfuYEUKU6n2UY=;
        b=RvgCYFcMGbpglpCpWkLEGO5pkbMkBODL/29Dy/N2WnmLNf9lgNbVFhuC+az4AKblyJ
         k/fRnZBps7dhSx305eZSO3SXjwWHBQf/FYbW6VE275ii+vS8Jn5UoTjIOn1NZzVlYRoO
         Q2AOCQmMr/pXRKj2MsI/KZYOKekbGI+RLBKNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703181029; x=1703785829;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Pz1yuj0Wr8dVhZXC4CPmwpwjkvl5wDfuYEUKU6n2UY=;
        b=mv67K0b+S8GexpZ1ZYyjdrnkRxtNIO4gb7y60Gqg/J4Ga5kDRIHwffSFIMHrzSwfBZ
         q0esw0ZCBOfj1oL3LREZqPU21Km2i6JeB200M/T7EtCmeSy19KkHwxB8EJQTYEmI1fZY
         osvEw+5n4hA8BS8GOMnRv1vMZ5ZkQtpTtx0i/a0f9B1fstBUu/tylpKlZrgI96PilOu8
         uOFzMrrhH0XtBVAUwgpHC0AWBZIyyVLuOwQnckiInI1aYppAkRSBZtHtaZbruWhXPpTO
         DrqimQ4sHp/PgZe2/4raqiXrgyrEK3UXo353vUmGTbu1DVy6MLKqOsLPQ5poqAUbEUxh
         tftQ==
X-Gm-Message-State: AOJu0YzNSNjjyefZuzG6C2in78zIrY26A/+u2Cezqve30MYF5EUkak7H
	pwNbfwIYYKUdoraa4Ru3SvU9k3fjYyqk
X-Google-Smtp-Source: AGHT+IE3s0LYnS0QhQzUYaJP0eE3P+X8M2xxyR/Vyi6PBSk54y2vyNCbKAt0y9yg3aWKDN5Vy0LNsQ==
X-Received: by 2002:a05:600c:1f10:b0:40d:423d:7f3e with SMTP id bd16-20020a05600c1f1000b0040d423d7f3emr47965wmb.94.1703181024080;
        Thu, 21 Dec 2023 09:50:24 -0800 (PST)
Received: from [10.230.35.166] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id he3-20020a05600c540300b00405d9a950a2sm11606773wmb.28.2023.12.21.09.50.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Dec 2023 09:50:23 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Stefan Wahren <wahrenst@gmx.net>, Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>
CC: <linux-wireless@vger.kernel.org>, <brcm80211-dev-list.pdl@broadcom.com>, <SHA-cyfmac-dev-list@infineon.com>, Hector Martin <marcan@marcan.st>, Kalle Valo <kvalo@kernel.org>
Date: Thu, 21 Dec 2023 18:50:21 +0100
Message-ID: <18c8d7feb60.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18c8d7da558.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
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
User-Agent: AquaMail/1.49.0 (build: 104900403)
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000003bf1d0060d08bc2c"

--0000000000003bf1d0060d08bc2c
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 21, 2023 6:47:53 PM Arend Van Spriel 
<arend.vanspriel@broadcom.com> wrote:

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
>>>>>>>>>> On November 11, 2023 5:48:46 PM Stefan Wahren <wahrenst@gmx.net>
>>>>>>>>>> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Again look like these are disabled channels. At least chanspec
>>>>>>>>>> 0xd022
>>>>>>>>>> is 5G channel 34. You say you get this only once so not every 60
>>>>>>>>>> seconds?
>>>>>>>>> I get this everytime i trigger a reconnect to the wifi network, so
>>>>>>>>> not
>>>>>>>>> periodically (checked that). Strangely the initial automatic
>>>>>>>>> connect
>>>>>>>>> doesn't trigger this errors.
>>>>>>>> I additionally placed a WARN_ON_ONCE after the error log and
>>>>>>>> enabled the
>>>>>>>> firmware error log of brcmf_fil_cmd_data(). Maybe this helps.
>>>>>>>
>>>>>>> It does a bit. At least it shows this is happening with the
>>>>>>> dump_survey (again). I don't really understand why though. It implies
>>>>>>> the channel is not disabled, but unclear why. The channel flags are
>>>>>>> changed in brcmf_construct_chaninfo() so we probably should focus
>>>>>>> debug on that function.
>>>>>>
>>>>>> i placed a pr_err at the start of brcmf_construct_chaninfo and another
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
>> As you said that the channel flags are set in brcmf_construct_chaninfo()
>> i dump them, here is the output of the first call:
>>
>> [    8.785850] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 00080000,
>> flags 00000001
>> [    8.785861] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 00080000,
>> flags 00000001
>> [    8.785872] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 00080000,
>> flags 00000001
>> [    8.785882] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 00080000,
>> flags 00000001
>> [    8.785974] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags: 00080000,
>> flags 0000011a
>>
>> All of them except 144 are disabled via flags. Btw wpa_supplicant is
>> configured to country DE within the configuration.
>>
>> The second and last time brcmf_construct_chaninfo() is called is a few
>> seconds later during boot, we get the following:
>>
>> [   12.490877] brcmfmac: 5 GHz: 0: hw_value 34: orig_flags: 00080000,
>> flags 00000001
>> [   12.490891] brcmfmac: 5 GHz: 2: hw_value 38: orig_flags: 00080000,
>> flags 00000001
>> [   12.490904] brcmfmac: 5 GHz: 4: hw_value 42: orig_flags: 00080000,
>> flags 00000001
>> [   12.490918] brcmfmac: 5 GHz: 6: hw_value 46: orig_flags: 00080000,
>> flags 00000001
>> [   12.491031] brcmfmac: 5 GHz: 23: hw_value 144: orig_flags: 00080000,
>> flags 00000001
>>
>> Now all of them are disabled via flags.
>>
>> So after that i trigger the reconnect to the same 5 GHz network as
>> before. brcmf_construct_chaninfo is never called again, but at the time
>> brcmf_set_channel is called the flags for these channels are completely
>> different:
>>
>> [   90.010002] brcmfmac: brcmf_set_channel: set chanspec 0xd022 fail,
>> reason -52
>> [   90.010017] brcmfmac: hw_value 34, orig_flags: 00080000, flags 00080220
>> [   90.120007] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>> [   90.120038] brcmfmac: brcmf_set_channel: set chanspec 0xd026 fail,
>> reason -52
>> [   90.120053] brcmfmac: hw_value 38, orig_flags: 00080000, flags 00080200
>> [   90.230029] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>> [   90.230058] brcmfmac: brcmf_set_channel: set chanspec 0xd02a fail,
>> reason -52
>> [   90.230073] brcmfmac: hw_value 42, orig_flags: 00080000, flags 00080200
>> [   90.340042] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>> [   90.340071] brcmfmac: brcmf_set_channel: set chanspec 0xd02e fail,
>> reason -52
>> [   90.340086] brcmfmac: hw_value 46, orig_flags: 00080000, flags 00080210
>> [   92.100073] ieee80211 phy0: brcmf_fil_cmd_data: Firmware error: (-20)
>> [   92.100110] brcmfmac: brcmf_set_channel: set chanspec 0xd090 fail,
>> reason -52
>> [   92.100126] brcmfmac: hw_value 144, orig_flags: 00080000, flags 00080118
>>
>> Where does these new flags come from? It's clear that these doesn't come
>> from brcmf_construct_chaninfo(). So what manipulates the flags
>> afterwards? Shouldn't brcmf_construct_chaninfo() called on reconnect?
>
> I suspect it is not the driver, but net/wireless/reg.c. Could you define
> DEBUG in top of that file and build cfg80211.ko with that. Or if you have
> CONFIG_DYNAMIC_DEBUG enable debug prints for reg.c through sysfs [1]

Sorry, it's done through debugfs.

>
> Regards,
> Arend
>
> [1] https://www.kernel.org/doc/html/v4.14/admin-guide/dynamic-debug-howto.html
>
>>
>> Best regards
>>
>>>
>>> brcmf_construct_chaninfo() is called from brcmf_setup_wiphybands() and
>>> that function is called in two places:
>>>
>>> 1) brcmf_cfg80211_attach(): right after wiphy_register()
>>> 2) brcmf_cfg80211_reg_notifier()
>>>
>>> Can we figure out if brcmf_cfg80211_reg_notifier() is indeed invoked
>>> on your platform and what country is being configured. If the country
>>> is indeed changed than it can be expected that some channels are
>>> disabled or enabled.
>>>
>>> Regards,
>>> Arend




--0000000000003bf1d0060d08bc2c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB97VJYQ9IuhtviIWgu
XAtHwRJQPEWPN+0+HYIDAAUPDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzEyMjExNzUwMjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJtxcJgIOHCpuoaXi6i1ruJo+Wx5PjnIW3beq
IfOkyv1nOzev3c5sO3UO0HLCuQey7VdXQf3s8ioSVmwDoxLZ216i4YtBTXDuvPhFe/6Qm3avV5cs
mPqFizGxqQI7SeWDnyG3EXBFBoE9D67vYrRyDHZ1xD/ib1ZHnWyp1PN3uF+Z+0bIn69PzjhGz0Zv
zLTDmLdSN5jUGUtb4juq1lZKhm+gbvE/YNN/xINogZO7DeC4XuHzpQs4oekfbLlvJH2OUGCUDtDp
BWb8Obe1CI6hq5e3b/uD9VaDVFUyoFEzC6Co1kele8Gy9Qjzof/4FRxww3cQav4IknG4jw5tUszJ
gQ==
--0000000000003bf1d0060d08bc2c--

