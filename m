Return-Path: <linux-wireless+bounces-8197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA21E8D1B38
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49ACF1F2264A
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 12:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88D36F08A;
	Tue, 28 May 2024 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRQwfNcZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7E16D4C8
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899145; cv=none; b=Uqca2q+H961hx9Ssw+9EOVEv/jcC+Lu5Awv0SdCUKQo4kqhL8IsHVEWHSpjfCRNtP//gQXswvXV1cie9FWBGC9XkHFwYsUEx5at4CcQB4ELpTFjlMeGwkCtVwLagJ9A3RusLe+shXVAK/xbRNqEqnWwFdN+vfyfGJG8vxnxIw8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899145; c=relaxed/simple;
	bh=0flKcpmTI1kGdeZhR/8SnoUbTYOKjlKrDabA8ATdfW4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B68a5jP1Sf1Cw48MsB2+M5UPizJ0oNFCSectwwCuBydnROlPopU/IdJJXf7LmA0WExfntJUm7+FDSsiH9yNAc76NtW+XrXOHvHcr2n/8AKisZjKhvZ2heth2Gp2CahHTMj/ELLuNaE4+DBjiJYpPvVklqCJ2iaUHtBWcrEQT8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRQwfNcZ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a635a74e0deso15154866b.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 05:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716899142; x=1717503942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xtQTzcuwR5RIrvdVCwk6SoidJz/PMhtH2p6tuhNr0fc=;
        b=dRQwfNcZInTPsyGDrcvtDuwc7OmE7UhoNy6LnmBEvlCEKW2KEjhGzPrDdPwBSojqyJ
         KSbt+T6YVeSCQhLXhvjaky3shO7nvZ39Kkt89V5rLBrFtJOUXHg4tcPB8FVgHMnJWJj9
         suSL0Vh4njlKc181X8jaWpILBd+E86USW/JP8mDyPaGOcxSbBhKvmHF72HpwBnYyGHRs
         wkhuaxduwrTneNFQz6kpa22gXHViVXzuoJQsQiAn0039pJ37EWcu/GzRhXZDvY9lwJFV
         lOXbfxQF9MX4xPK5Ta+Um1HOm6LvfaEjKWb2ebvJENoU+oI7Dv/qUhR1AhIOkIjM5PYI
         VgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716899142; x=1717503942;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtQTzcuwR5RIrvdVCwk6SoidJz/PMhtH2p6tuhNr0fc=;
        b=pNcxfVRFk6OFi0zbgYNO16m1K76INZURl1L4OUt31t61Si5lLqIWrlu3V8rSvAfSIX
         +lWkOpRCRpXqf7tVqeoit6SlN34uLS1FJc77EPAzgiAZJg+RodrZOBfmlzcdVLUwub8X
         F/IB89ZfwUVa86CdUn+1n+LlFJ8l9l8co5a4+9a1l0Z63VhBsunh8fmu4tUwcGDpmzl4
         AvaWSGmGr+ENOlHpGZUSlyVCOs9qTSDAYUuSIlHfosMb0uBm3lUR10xOr4Ot3yZkHq11
         CsZd76Fy8wqz3oQ2LFr6adghpC+1w1xM6bhm+rgPgsylt9TqxtaPxSrSRjqzqnbDWy/4
         MpMg==
X-Gm-Message-State: AOJu0YzjTAz9ngTLqaAybq9u6/B+lbf3KkMHMxKt5Be3AwOHktgKCOee
	fDsX1rYwyaa3dnRgFcS/+IMDFOLYvSAr4pwM+BwyRZjC4RjcRaJN
X-Google-Smtp-Source: AGHT+IHcZb1M8wrO3b/kRHHxx6+hdaVw9hejqf2SjtlpE9MqISYO0sBUlGv+1KVmJyKzHdC9IUacKQ==
X-Received: by 2002:a17:906:bca:b0:a5a:743b:20d2 with SMTP id a640c23a62f3a-a62643e2436mr731345266b.38.1716899141017;
        Tue, 28 May 2024 05:25:41 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a63395fb1d0sm86524966b.89.2024.05.28.05.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 05:25:40 -0700 (PDT)
Message-ID: <fdb30dac-4ab3-4182-80b2-8dc197420778@gmail.com>
Date: Tue, 28 May 2024 15:25:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on
 cycles
To: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?Q?Marcin_=C5=9Alusarz?=
 <mslusarz@renau.com>
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <0f1aef25-2b91-408d-aca9-9943dc9367b3@gmail.com>
 <CA+GA0_vz7S++ttaug2kGZWyzyc-PMZoVSsiSH-sXn4uctX5V2A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+GA0_vz7S++ttaug2kGZWyzyc-PMZoVSsiSH-sXn4uctX5V2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/05/2024 13:42, Marcin Ślusarz wrote:
> pon., 27 maj 2024 o 20:43 Bitterblue Smith <rtl8821cerfe2@gmail.com> napisał(a):
>>
>> On 27/05/2024 20:34, Marcin Ślusarz wrote:
>>> From: Marcin Ślusarz <mslusarz@renau.com>
>>>
>>> If I don't connect to any Wifi network, after around 10 minutes, the device
>>> hangs with endless spamming of:
>>> rtw_8821cu 1-1:1.2: rtw_usb_reg_sec: reg 0x4e0, usb write 1 fail, status: -71
>>> killing both Wifi and Bluetooth part of the device.
>>>
>>> On arm, just leaving the wifi device unconnected kills it in up to 20 minutes.
>>> If I keep restarting wpa_supplicant I can trigger it within a minute.
>>> Looping "ifconfig wlan0 down; ifconfig wlan0 up" also triggers it within a minute.
>>>
>>> On x86_64 system the only way I could trigger this was via ifconfig loop,
>>> but it took 3 hours and 20 minutes to do it.
>>>
>>> The only thing that can "fix" the device is replugging it.
>>>
>>> I found out that the reason for those hangs is a power-off+on sequence that's
>>> triggered by the above steps.
>>>
>>> Disabling power-off for that chip "fixes" the issue. The patches below
>>> implement that, but I'm not seriously proposing them for merging.
>>>
>>> Marcin Ślusarz (2):
>>>   wifi: rtw88: use RTW_FLAG_RUNNING for deciding whether to enter/leave
>>>     IPS
>>>   wifi: rtw88: disable power offs for 8821C
>>>
>>>  drivers/net/wireless/realtek/rtw88/main.c | 14 ++++++++------
>>>  drivers/net/wireless/realtek/rtw88/ps.c   |  4 ++--
>>>  2 files changed, 10 insertions(+), 8 deletions(-)
>>>
>>
>> The first patch alone doesn't fix it?
> 
> The first patch exists only to make the second patch work.
> Without the first one, rtw_enter_ips will perform all actions except actually
> doing the power off, which clears the POWERON flag.
> After that, rtw_leave_ips will happily return early success without actually
> undoing the stuff that rtw_enter_ips did (like canceling all work_structs).

I see.

I wonder if it's really the chip that has a problem, or rtw88?
Can you try your ifconfig loop with the other driver?
https://github.com/morrownr/8821cu-20210916/

