Return-Path: <linux-wireless+bounces-4967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64F288101E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 11:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CE41C230C9
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AAA79D1;
	Wed, 20 Mar 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iEvXqsOR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B687335B5
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931325; cv=none; b=J5lciZN9M4gjK2FhahvZJhkilfRBg+iZOlspkvHTtAJPT1oih+0uFunR3f2+NS5O7sSyWfclpiVRsRhdu6Db+4p9oSUjkHUT2+DfZW/NEL08atNc1vBExnPYpCwW96HFnWAPflQbOSOyq0aHlQSQW4nXvDWWjz1TQyf+dtj54Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931325; c=relaxed/simple;
	bh=MPKO4ASOMVUlVvgvWhtlyEOGyOOM0kW9ducnSIwa5S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=HP7745/UzQFU/eg3DIneOrM4OH8+zpR6fEltO/I+Nckb2N8JKhEfwL4XabjG1olnsWTek+wkL+jYEQTizMLDIWoh1itfjogbIelnZsIgq+Jlb8+0pvTYFIru2z5WgTC4JOih8Cn4CNJhZ7FAtjouTqymdPRrdtr8IPZ0JKRRbuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iEvXqsOR; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-781753f52afso360236385a.2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 03:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1710931322; x=1711536122; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:cc:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw296er5HBFzZVOD4eAZAYjOWPb9B3XpkinWhO1ZQgQ=;
        b=iEvXqsORnT7LtLLVs/MVb3+Haat6cH21o+ukEBupwd7hA1oh5rBL1Y9Ob7tKcojvtH
         GnOtFQwRB5SRDqnlr1LCdnV/Kw5e+MTKvELuPbChwD83FRZHZidutzp3o36AydZsYz7M
         XFuND/IDm4AHf7aE6eFqaz8ldKThR0cJKargk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710931322; x=1711536122;
        h=in-reply-to:autocrypt:from:cc:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cw296er5HBFzZVOD4eAZAYjOWPb9B3XpkinWhO1ZQgQ=;
        b=v76/YiJeqIcwaaVgr3OxOIJg7a14oIqM5J4InwoYTTL5TYdZLccNQOMPPjBq+5ETB6
         k1MbvAyD4nxmcXugIjbczCSYPj3cUQUL8ytsnrIbTwpIDYy4HQSzBWiHvA1DalAE1uDQ
         Gjoq8GgltJ5iOX+ifGhFs74zq+EkVRRuSzJFQFeEDQoUwnhkyn6twA8W+Ej5QpQm8mSy
         7vZK1MYBJh6IsVIe3Kk03/Xmsw5HXiGP8qzlsNlwqj39qdWj038eRK6tmJcldg4049s7
         63mBnG8bbs71h9+WueeShwef/UsVVQcFkSlE34TG+oSbXy3v/uoMk+RjN6xdVl69BFcC
         MdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsTTlHiMD5Ao4JHBjJ9QMRIup2TiQKLhWfKTsydzf/Wf6fqOHRIgivQv9p4jvAGzVofdyqddhl6kiwrkDgXF28lErafkfDh54w2U+uWcw=
X-Gm-Message-State: AOJu0YxX6oGJbS+H0wiQ+D7rvi9ZnJWY7jFFgnLaJ9LKXHfST2O0xSGx
	fIm4LC6p1MlCPfxxU3kaPaI7ibdCdNrqutyo1OjBVOJWoDP4Yma+FaENP9nZJKbzgbmozoZIg7H
	Nf0mc3D4=
X-Google-Smtp-Source: AGHT+IEO0kGll9N5HeF8HdamnNvFffKQZYe+naAehL9/oL7tyonxQDuf5FztWapxtBM9rWhlS2DUIg==
X-Received: by 2002:ae9:ec0c:0:b0:789:f1b7:c612 with SMTP id h12-20020ae9ec0c000000b00789f1b7c612mr1617623qkg.4.1710931322333;
        Wed, 20 Mar 2024 03:42:02 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id x26-20020ae9f81a000000b00785d538aebdsm6409026qkh.95.2024.03.20.03.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 03:42:01 -0700 (PDT)
Message-ID: <3618d1dc-cdff-4336-b35a-26307fa7b51c@broadcom.com>
Date: Wed, 20 Mar 2024 11:41:59 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bump
To: Hranislav Milenkovic <hmilenkovic@protonmail.com>
References: <H1YMm0UlsCAAuLjY3yG9iqSb0G4tRSHoe0_-bLXMowq8eNCd7eW5Vs_D_PdO4KnriiKO5e5fehpmXmQPtAR9htqHRT5MgFZumadSikTcNWw=@protonmail.com>
Cc: brcm80211@lists.linux.dev, linux-wireless <linux-wireless@vger.kernel.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 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
In-Reply-To: <H1YMm0UlsCAAuLjY3yG9iqSb0G4tRSHoe0_-bLXMowq8eNCd7eW5Vs_D_PdO4KnriiKO5e5fehpmXmQPtAR9htqHRT5MgFZumadSikTcNWw=@protonmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b919450614153d2e"

--000000000000b919450614153d2e
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/7/2024 7:53 AM, Hranislav Milenkovic wrote:
> Hi Arend, couple years later same question... can these crashes be 
> fixed... who maintains chipset firmware for 43602... I get it for 
> brcmfmac but who maintains firmwares from here 
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/brcm/ <https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/brcm/>

Hi Hranislav,

The firmware repo is maintained by kernel.org. Regarding the firmwares 
for the brcm chips these have been submitted by Broadcom. The 43602 is 
EOL so there will be no regular releases. Can you provide hardware 
configuration details for your platform.

The firmware repo has two firmware files for 43602:

-rw-r--r--	brcmfmac43602-pcie.ap.bin	595472
-rw-r--r--	brcmfmac43602-pcie.bin		635449

Which one are you using?

> I have some crashes if you are interested (also have you seen this 
> bugreport 
> https://github.com/openwrt/openwrt/issues/14685#issuecomment-1980108432 
> <https://github.com/openwrt/openwrt/issues/14685#issuecomment-1980108432>)

You made me look. So are you using OpenWrt? What release/branch are you 
using?

>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.722477] ieee80211 phy0: 
> brcmf_fw_crashed: Firmware has halted or crashed
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.729587] 0001:01:00.0: 
> CONSOLE: 005280.898
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.734051] 0001:01:00.0: 
> CONSOLE: FWID 01-f458629d
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.739004] 0001:01:00.0: 
> CONSOLE: flags 110005
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.743562] 0001:01:00.0: 
> CONSOLE: 005280.898
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.748079] 0001:01:00.0: 
> CONSOLE: TRAP 7(26fea8): pc 1871d6, lr 1867e9, sp 26ff00, cpsr 800001df, 
> spsr 800001bf
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.758362] 0001:01:00.0: 
> CONSOLE: 005280.898   r0 1000000, r1 40000000, r2 40, r3 1, r4 1fc8d8, 
> r5 26af20, r6 25f2d4
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.769074] 0001:01:00.0: 
> CONSOLE: 005280.898   r7 25eab4, r8 25f2dc, r9 0, r10 bf3c0282, r11 
> db1d6d6c, r12 6038120
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.779551] 0001:01:00.0: 
> CONSOLE: 005280.898
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.784043] 0001:01:00.0: 
> CONSOLE:    sp+0 00000000 0026af20 00000000 0018861d
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.791385] 0001:01:00.0: 
> CONSOLE: 005280.898   sp+10 00000000 0025f3c0 00000000 0018078c
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.799596] 0001:01:00.0: 
> CONSOLE:
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.803114] 0001:01:00.0: 
> CONSOLE: 005280.898 sp+c 0018861d
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.808743] 0001:01:00.0: 
> CONSOLE: 005280.898 sp+2c 00006fc7
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.814441] 0001:01:00.0: 
> CONSOLE: 005280.898 sp+30 00006f9d
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.820146] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+3c 00007005
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.825842] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+4c 00007243
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.831544] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+5c 00183825
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.837236] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+70 001837f9
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.842937] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+8c 001823d7
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.848640] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+98 000001df
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.854329] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+d8 000071df
>   Mar 05 19:13:21 178.220.177.32 kernel [ 5284.860032] 0001:01:00.0: 
> CONSOLE: 005280.899 sp+e8 00188e59
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.797981] ieee80211 phy0: 
> brcmf_fil_cmd_data: bus is down. we have nothing to do.
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.805670] brcmfmac: 
> brcmf_cfg80211_stop_ap: bss_enable config failed -5
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.812497] ieee80211 phy0: 
> brcmf_fil_cmd_data: bus is down. we have nothing to do.
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.820190] ieee80211 phy0: 
> brcmf_cfg80211_stop_ap: SET SSID error (-5)
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.826827] ieee80211 phy0: 
> brcmf_fil_cmd_data: bus is down. we have nothing to do.
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.834521] ieee80211 phy0: 
> brcmf_fil_cmd_data: bus is down. we have nothing to do.
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.842213] brcmfmac: 
> brcmf_cfg80211_stop_ap: wl apsta failed (-5)
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.848420] ieee80211 phy0: 
> brcmf_fil_cmd_data: bus is down. we have nothing to do.
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.856098] ieee80211 phy0: 
> brcmf_cfg80211_stop_ap: BRCMF_C_DOWN error -5
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.864446] br0: port 
> 4(wlan0) entered disabled state
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.870425] device wlan0 left 
> promiscuous mode
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5285.874923] br0: port 
> 4(wlan0) entered disabled state
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5286.417713] brcmfmac: 
> brcmf_fw_alloc_request: using brcm/brcmfmac43602-pcie for chip BCM43602/1
>   Mar 05 19:13:22 178.220.177.32 kernel [ 5286.428364] brcmfmac 
> 0001:01:00.0: Direct firmware load for �H0� 
> �\`�`�dp�`0�y��H0�\`�`�dp�`0�r� failed with error -2

Not sure why this is all garbled. Can image there is not file with that 
name though ;-) Above seems the driver attempts to recover from the 
firmware crash. I can take a look at the firmware crash and the recovery 
mechanism in the driver.

>   Mar 05 19:13:22 178.220.177.32 kernel [ 5286.441255] brcmfmac 
> 0001:01:00.0: Direct firmware load for brcm/brcmfmac43602-pcie.txt 
> failed with error -2
>   Mar 05 19:13:25 178.220.177.32 kernel [ 5289.150530] BUG: Bad page 
> state in process modprobe  pfn:07150
>   Mar 05 19:13:25 178.220.177.32 kernel [ 5289.156407] page:86cb6f40 
> count:-1 mapcount:0 mapping:  (null) index:0x0
>   Mar 05 19:13:25 178.220.177.32 kernel [ 5289.163118] flags: 0x0()
>   Mar 05 19:13:25 178.220.177.32 kernel [ 5289.165660] page dumped 
> because: nonzero _count
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.171893] 0002:03:00.0: 
> CONSOLE: 041746.172 ucode revision 986.128
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.178467] 0002:03:00.0: 
> CONSOLE: 041746.172 wl0: PSM microcode watchdog fired at 41733 (seconds)
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.187768] 0002:03:00.0: 
> CONSOLE: 041746.172 wl0: psmdebug 0x00ec8111, phydebug 0x00000048, 
> psm_brc 0x0501 psm_brc_1 0x0000maccontrol 0x84160403 ifsstat 0x00af 
> m_cts_duration 0x0000 m_ucode_dbgst 0x0002
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.206038] 0002:03:00.0: 
> CONSOLE: 041746.172 wepctl 0x0050 wepstat 0x0000 wep_hdrloc 0x001e 
> wep_psdulen 281
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.216025] 0002:03:00.0: 
> CONSOLE: 041746.172      RXE_RXCNT: 0x011f   DAGG: ctl: 0x0000, bleft: 
> 0x0096
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.225523] 0002:03:00.0: 
> CONSOLE:      offs: 0x000c, stat: 0x1056, len: 0x0000
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.232995] 0002:03:00.0: 
> CONSOLE: 041746.172 M_RXFRM_BLK scr(0:63) btc_params(0:63) phydebug PC 
> ampdu clk off
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.243076] 0002:03:00.0: 
> CONSOLE: 041746.172 wlc_dump_aggfifo:
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.249089] 0002:03:00.0: 
> CONSOLE: 041746.172 framerdy 0x0 bmccmd 7 framecnt 1024
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.256822] 0002:03:00.0: 
> CONSOLE: 041746.172 AQM agg params 0xfc0 maxlen hi/lo 0x0 0xffff minlen 
> 0x0 adjlen 0x0
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.267153] 0002:03:00.0: 
> CONSOLE: 041746.172 AQM agg results 0x8001 len hi/lo: 0x0 0x22 
> BAbitmap(0-3) 0 0 0 0
>   Mar 06 05:20:56 178.220.177.32 kernel [41739.277244] ieee80211 phy1: 
> brcmf_psm_watchdog_notify: PSM's watchdog has fired!

The PSM watchdog means the microcode got stuck in a bad state. Getting 
microcode development involved in fixing this will prove difficult.

Regards,
Arend

--000000000000b919450614153d2e
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDQm4J/yEzV3Eu4AgyW
RaP82wvc0j7EPZptBb+st1X6qDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAzMjAxMDQyMDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJqqURApS8DXn6R5BfQUNzHUPyiqaefy/ggID
XzJqfQyJr3GGVb79HV2SNIZSfkwMrWTUTa3tNu4VITPRzMZAScIN/FjVwPimxI7M10j8/JUpQ5pp
YEYvCqTxvSnhF6T59qNWVFnemt7xs1j8iEfNF8gOpf9GKqCiHd6qtAAsGyZCmcguwZSUiVnsy8gA
v+R0EDEdRvcy1j6daVLfYmItjPzOB1FEvj4JhsmZOk8vov6Lp7kJuV0i4TkbVkzujNIFHDN37gfV
5SkTIu4zyW9idYZx52V+Gn0jkufnU4k5dY1EM0h2iIzBGJSF7nt/jTGLGBG4UFvMPiNdMyte8J/i
6A==
--000000000000b919450614153d2e--

