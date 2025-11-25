Return-Path: <linux-wireless+bounces-29345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEEC87084
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 21:26:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4A443B6769
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Nov 2025 20:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D1533AD8C;
	Tue, 25 Nov 2025 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fRkQ+4b8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f99.google.com (mail-oa1-f99.google.com [209.85.160.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2A33BBD4
	for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 20:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764102294; cv=none; b=bW3Qbv+/j/fXwPUg1cJC9tSy7n5e1KtQduLZuZeV+rpXMv4n4Sz4qx11uOfvIhISGznQitWNH7mBZKtkuEgnFMbIXVooaPaH5R67nFCqSDsAc+MxLS/+EtNo8oh3SqyAFHYvueDPCr5zKXV57gg6q3JhxL6hU9+uiCVSqxeCK4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764102294; c=relaxed/simple;
	bh=5kQDw09CcNJD18+fz9Z3OKEyz6KWO/D+EZyUAX6wMbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuOrRCcQupRDCkgA6qdkR2BS7dRTwPjHGTd5SN++mtnpTaP+kfOG8sezmKsjTi8cS8CyixO3e+t4HlrNRnYwV36mXcL28dBj/TvGF9DAARC0ZmFoI+BiIBVt7ZEq/9HKQkDs9DgHq31ZT18Vh1qUB7mOIwCWkEpLZcj+TGyeJCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fRkQ+4b8; arc=none smtp.client-ip=209.85.160.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f99.google.com with SMTP id 586e51a60fabf-3d2ea93836bso3229036fac.3
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 12:24:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764102292; x=1764707092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7MhPP783rkDs/KueGufk+poD0f5FD/g4WWsmzgbXC1Y=;
        b=DDGwee2KjhfabGsD2MPmrSi9Rx1Cb/iVN+a/kth8vd4e+MBAD+H6jxer5Zv5RsbS3a
         geg7hBNtarVEkfOg5POoWDiv+b7qEjJWnZm/URQcFV7rAdKhxkON78p31Q6FynSX30I8
         98ONBlRC4YYznuFMcMD+/omszyzrt3eS9py/zba1MNX4ETtFMHS5fj964HU3PdQ9vLHp
         LzudTjNYm0SkkX8FD5QyBTTk26tbIrnfkxakTCyjJc/UUn65GMHyvZkIPwl96V0xdHiG
         BnV0fJhSyZcTPnzl9mxxM7JEu9cMTxjvXqMYgK0PLVsyAdiEO89huw5XZ8Li9vAYnUHQ
         zWsw==
X-Gm-Message-State: AOJu0Yylct8BNlFUy+dg5DVXU2iAGfVU6LgN5Mk337nR3Ag8Cx3R1ISM
	5S9hlRQs7i8SrlLza6LQrvNwJoc48XjmSKcqyEASro7lqea3LJEW0yhQZtRIQp2sNl2G9SlPDrE
	kOu/RFX/pFx1xjBCmKv3xYH+x88RfvPtfe9dI4e2n1qM1r8bA4oH/YrjXfI4QqVIY9k/aX2Z/qa
	5fFxGW136gXfvdOCrfmJPsjNLmoEur6d5txZTGDiO9Ks+zSZmegrt+o8kqIDaMynn5yoeDi7mUj
	TYRnSJ/fnYAaxj3voq3ftuipXDY
X-Gm-Gg: ASbGncsC6AdPHvc25N/RGG/o2j3c6PdcbKIojvKkoXr39ZChYJU4CCunDyfFdNdgTXE
	AnllfYzAa4MXjCEL7lcDwewTXx8CRBqB8zAAQ3QgSvXJSPx/5W9rFEXht0njaOnVZ5u0YtuDBeh
	BBGrpOINNJ03epYQF8zZ2FXnDC8G8Qfv6X2Kh315svETo6ho73P01iY6zI/CxyNIxIDGG02Jev+
	GOi26x4F5PH+qQyYbEoQRn2jwWID0O0ZINqebh11Ofn0cNGF0RWCoiu8G/LWWAvqmnIvaO7FZTI
	hymF1JLkOY/1+ml10R9THjadVa+4o+oai2LXf3VT8jkMsEOjFv3m3wWajuLb5V8rZjSByatxVAm
	o2Bj5t6fJDcX7c7K7hRVdjwJkACCYvfwdFBEsSvHRdC40NyASy+/9RucdXI9d56Tho2nhNEU+8O
	ND02L84+AYQ4r7lSPJZSnIV92mafVBJfGNI/PhdJg9GncF3Ely
X-Google-Smtp-Source: AGHT+IEvciIX9L5ilza16fVdGHNJmne70LwLmbuuBk1eE/JrWi5i/Ky8MaHGPcjq/RkFp67MQRUfg+gNaRJS
X-Received: by 2002:a05:6871:3409:b0:3e0:788f:2615 with SMTP id 586e51a60fabf-3ed1fbdb7e7mr1978782fac.3.1764102291662;
        Tue, 25 Nov 2025 12:24:51 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-3ec9dc766d6sm1608212fac.14.2025.11.25.12.24.51
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Nov 2025 12:24:51 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779b432aecso43948875e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 25 Nov 2025 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764102290; x=1764707090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7MhPP783rkDs/KueGufk+poD0f5FD/g4WWsmzgbXC1Y=;
        b=fRkQ+4b8aPuafyuViNOYIGr+ejrcyS2pLGhyP7/2lKVieJJ6aWBssbD5Hq+18fPtPY
         75yhO1r7+bCbY7rFG8lERpp8S2bAy6n0J6mf6cro/OhMxrtMDWVlBekgqjHMt6gCXpmB
         UlfNB/fCnVG/0c/66yViyBrfVnCqAamzAI3FI=
X-Received: by 2002:a05:600c:4e93:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-477c10e1ccdmr184827825e9.15.1764102289794;
        Tue, 25 Nov 2025 12:24:49 -0800 (PST)
X-Received: by 2002:a05:600c:4e93:b0:471:9da:5232 with SMTP id 5b1f17b1804b1-477c10e1ccdmr184827625e9.15.1764102289302;
        Tue, 25 Nov 2025 12:24:49 -0800 (PST)
Received: from [10.229.43.180] ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479040ac7e8sm27948075e9.1.2025.11.25.12.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 12:24:48 -0800 (PST)
Message-ID: <640ed685-3c83-4ca8-bbf3-51ddec5b6d5d@broadcom.com>
Date: Tue, 25 Nov 2025 21:24:44 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, wlan-kernel-dev-list@infineon.com,
 Carter Chen <Carter.Chen@infineon.com>, Owen Huang
 <Owen.Huang@infineon.com>, Ian Lin <Ian.Lin@infineon.com>,
 JasonHuang <Jason.Huang2@infineon.com>,
 Shelley Yang <Shelley.Yang@infineon.com>,
 avishad verma <avishad.verma@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
 <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
 <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
 <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Autocrypt: addr=arend.vanspriel@broadcom.com; keydata=
 xsFNBGP96SABEACfErEjSRi7TA1ttHYaUM3GuirbgqrNvQ41UJs1ag1T0TeyINqG+s6aFuO8
 evRHRnyAqTjMQoo4tkfy21XQX/OsBlgvMeNzfs6jnVwlCVrhqPkX5g5GaXJnO3c4AvXHyWik
 SOd8nOIwt9MNfGn99tkRAmmsLaMiVLzYfg+n3kNDsqgylcSahbd+gVMq+32q8QA+L1B9tAkM
 UccmSXuhilER70gFMJeM9ZQwD/WPOQ2jHpd0hDVoQsTbBxZZnr2GSjSNr7r5ilGV7a3uaRUU
 HLWPOuGUngSktUTpjwgGYZ87Edp+BpxO62h0aKMyjzWNTkt6UVnMPOwvb70hNA2v58Pt4kHh
 8ApHky6IepI6SOCcMpUEHQuoKxTMw/pzmlb4A8PY//Xu/SJF8xpkpWPVcQxNTqkjbpazOUw3
 12u4EK1lzwH7wjnhM3Fs5aNBgyg+STS1VWIwoXJ7Q2Z51odh0XecsjL8EkHbp9qHdRvZQmMu
 Ns8lBPBkzpS7y2Q6Sp7DcRvDfQQxPrE2sKxKLZVGcRYAD90r7NANryRA/i+785MSPUNSTWK3
 MGZ3Xv3fY7phISvYAklVn/tYRh88Zthf6iDuq86m5mr+qOO8s1JnCz6uxd/SSWLVOWov9Gx3
 uClOYpVsUSu3utTta3XVcKVMWG/M+dWkbdt2KES2cv4P5twxyQARAQABzS9BcmVuZCB2YW4g
 U3ByaWVsIDxhcmVuZC52YW5zcHJpZWxAYnJvYWRjb20uY29tPsLBhwQTAQgAMRYhBLX1Z69w
 T4l/vfdb0pZ6NOIYA/1RBQJj/ek9AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQlno04hgD/VGw
 8A//VEoGTamfCks+a12yFtT1d/GjDdf3i9agKMk3esn08JwjJ96x9OFFl2vFaQCSiefeXITR
 K4T/yT+n/IXntVWT3pOBfb343cAPjpaZvBMh8p32z3CuV1H0Y+753HX7gdWTEojGWaWmKkZh
 w3nGoRZQEeAcwcF3gMNwsM5Gemj7aInIhRLUeoKh/0yV85lNE1D7JkyNheQ+v91DWVj5/a9X
 7kiL18fH1iC9kvP3lq5VE54okpGqUj5KE5pmHNFBp7HZO3EXFAd3Zxm9ol5ic9tggY0oET28
 ucARi1wXLD/oCf1R9sAoWfSTnvOcJjG+kUwK7T+ZHTF8YZ4GAT3k5EwZ2Mk3+Rt62R81gzRF
 A6+zsewqdymbpwgyPDKcJ8YUHbqvspMQnPTmXNk+7p7fXReVPOYFtzzfBGSCByIkh1bB45jO
 +TM5ZbMmhsUbqA0dFT5JMHjJIaGmcw21ocgBcLsJ730fbLP/L08udgWHywPoq7Ja7lj5W0io
 ZDLz5uQ6CEER6wzD07vZwSl/NokljVexnOrwbR3wIhdr6B0Hc/0Bh7T8gpeM+QcK6EwJBG7A
 xCHLEacOuKo4jinf94YQrOEMnOmvucuQRm9CIwZrQ69Mg6rLn32pA4cK4XWQN1N3wQXnRUnb
 MTymLAoxE4MInhDVsZCtIDFxMVvBUgZiZZszN33OwU0EY/3pIgEQAN35Ii1Hn90ghm/qlvz/
 L+wFi3PTQ90V6UKPv5Q5hq+1BtLA6aj2qmdFBO9lgO9AbzHo8Eizrgtxp41GkKTgHuYChijI
 kdhTVPm+Pv44N/3uHUeFhN3wQ3sTs1ZT/0HhwXt8JvjqbhvtNmoGosZvpUCTwiyM1VBF/ICT
 ltzFmXd5z7sEuDyZcz9Q1t1Bb2cmbhp3eIgLmVA4Lc9ZS3sK1UMgSDwaR4KYBhF0OKMC1OH8
 M5jfcPHR8OLTLIM/Thw0YIUiYfj6lWwWkb82qa4IQvIEmz0LwvHkaLU1TCXbehO0pLWB9HnK
 r3nofx5oMfhu+cMa5C6g3fBB8Z43mDi2m/xM6p5c3q/EybOxBzhujeKN7smBTlkvAdwQfvuD
 jKr9lvrC2oKIjcsO+MxSGY4zRU0WKr4KD720PV2DCn54ZcOxOkOGR624d5bhDbjw1l2r+89V
 WLRLirBZn7VmWHSdfq5Xl9CyHT1uY6X9FRr3sWde9kA/C7Z2tqy0MevXAz+MtavOJb9XDUlI
 7Bm0OPe5BTIuhtLvVZiW4ivT2LJOpkokLy2K852u32Z1QlOYjsbimf77avcrLBplvms0D7j6
 OaKOq503UKfcSZo3lF70J5UtJfXy64noI4oyVNl1b+egkV2iSXifTGGzOjt50/efgm1bKNkX
 iCVOYt9sGTrVhiX1ABEBAAHCwXYEGAEIACAWIQS19WevcE+Jf733W9KWejTiGAP9UQUCY/3p
 PgIbDAAKCRCWejTiGAP9UaC/EACZvViKrMkFooyACGaukqIo/s94sGuqxj308NbZ4g5jgy/T
 +lYBzlurnFmIbJESFOEq0MBZorozDGk+/p8pfAh4S868i1HFeLivVIujkcL6unG1UYEnnJI9
 uSwUbEqgA8vwdUPEGewYkPH6AaQoh1DdYGOleQqDq1Mo62xu+bKstYHpArzT2islvLdrBtjD
 MEzYThskDgDUk/aGPgtPlU9mB7IiBnQcqbS/V5f01ZicI1esy9ywnlWdZCHy36uTUfacshpz
 LsTCSKICXRotA0p6ZiCQloW7uRH28JFDBEbIOgAcuXGojqYx5vSM6o+03W9UjKkBGYFCqjIy
 Ku843p86Ky4JBs5dAXN7msLGLhAhtiVx8ymeoLGMoYoxqIoqVNaovvH9y1ZHGqS/IYXWf+jE
 H4MX7ucv4N8RcsoMGzXyi4UbBjxgljAhTYs+c5YOkbXfkRqXQeECOuQ4prsc6/zxGJf7MlPy
 NKowQLrlMBGXT4NnRNV0+yHmusXPOPIqQCKEtbWSx9s2slQxmXukPYvLnuRJqkPkvrTgjn5d
 eSE0Dkhni4292/Nn/TnZf5mxCNWH1p3dz/vrT6EIYk2GSJgCLoTkCcqaM6+5E4IwgYOq3UYu
 AAgeEbPV1QeTVAPrntrLb0t0U5vdwG7Xl40baV9OydTv7ghjYZU349w1d5mdxg==
In-Reply-To: <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/5/2025 7:58 AM, Gokul Sivakumar wrote:
> As you would be aware that, currently brcmfmac is retrofitted to support chipsets
> from more than 3 WLAN chip vendor organizations (CYW from Infineon/Cypress,
> BCA from Broadcom, WCC from Broadcom, etc). One of the major issue with this
> WLAN driver model is, it is not practically feasible for each vendor to ensure
> that their new chipset architecture specific driver changes do not cause any
> regressions on the chipsets supported by other vendors in the same driver.
> This has an impact for the end users. In a way, this severely hinders each
> WLAN vendor from fully supporting their chipsets in upstream kernel with new
> features for their chipsets. And currently brcmfmac uses fwvid (Firmware Vendor ID)
> param in a vendor agnostic wrapper function brcmf_fwvid_*() to decide which command
> to be sent to the vendor's firmware for doing a particular operation. For Example,
> brcmf_fwvid_set_sae_password() for setting SAE password. This only handles the case
> where two different vendor firmwares expecting two different commands for the same
> operation. However, this does not solve the problem when each vendor firmware
> expects commands in a different sequence. Also fwvid check is currently being used
> only for sending commands/events to & from firmware, and for invoking cfg80211
> callbacks. But other operations are also different across WLAN vendors with the
> new generation chipsets, but they are currently handled in the same way for the
> old generation chipsets in brcmfmac.

Hi Gokul,

When I worked on the multi-vendor support changes the main goal was to 
separate the firmware API as that was diverging or going to be rather 
sooner than later. I was tempted to duplicate cfg80211.c as well so each 
vendor could do its own. However, the concrete scenario for WPA3-SAE 
could be done on a lower granularity reusing common functionality. So 
for these new chips you could add "inf" vendor and completely split off. 
Not sure what you mean by "other operations" in the above paragraph. 
Maybe you can elaborate?

But I understand it is easier to work on your own driver if the chip 
architecture and programming is getting fundamentally different. Not 
seeing that in the current set of patches though. The bus and protocol 
layers look pretty much the same. Agree with Johannes that it would be 
better to start with a driver which provides basic wifi functionality or 
even just firmware initialization instead of throwing in everything and 
more off the bat.

Anyway. I am glad to hear that Infineon intends to keep supporting 
brcmfmac for the older chipsets. I will store your contact info in my 
address book ;-)

Regards,
Arend

