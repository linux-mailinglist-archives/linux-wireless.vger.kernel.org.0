Return-Path: <linux-wireless+bounces-17764-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EBBA17333
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 20:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50303A73F4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 19:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCA1EE026;
	Mon, 20 Jan 2025 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+6epu4S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84CE1E0E0A
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 19:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737402130; cv=none; b=WSSL+/FzCCVlbzFdn5lNkQLmeDHgtihKLoN63VZCkrwJyZil2meyS/lXOa3yU8cD6Z7LA1/6j05S9MyNcHZGIENCzsi2KzRHqAW/uMRnYUs62SQA7iyjy0GDVW2CPQouC5zeGRDu8t/FeKzMlPnet8CkGCtxUKf2T9ifZtWUG3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737402130; c=relaxed/simple;
	bh=JzAUXxTY+6ZV5IrjIdD4nG1HZa0HD6D0C7YLLG1eTdQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=sR28kjvl/iJMUGdRwD6kq43ZCMXXzgwd7voomgh5JG9blf68OsAbxvvePIgZw6d0PW8PhUExBaBkqgr+/rxsN0onMmcbvQCyciJ84g9QQ9kjSoFuVhtA6m1+qviGzz4WpvukJXxM9sxAmqhNl+uBId0rfJHJPvRj38Pu+dFoRoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+6epu4S; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so49744975e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 11:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737402127; x=1738006927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+sMdP1ffQ1QpY9XYLjygUA9VyRu5Zs9pUaqg1dvK6s=;
        b=d+6epu4SLyJY4kq0AFJhChtgkUQh8pwzowrPOCYbJTgCMKIzIiECS1eYmEOyjc1zCv
         jNhi9JqXkwrdAOUVNLqspCgZrdYPNXAwKvCy2qdMznd6f1ky9/9iOyTWXjG3FxVdZeB4
         hFycz/hhdQ4vNnxA581mMwES1v1TBlj9UM9kDE4dlimulRxBYwgvGmGep5gG9SZ1Cjjp
         EmdEkYLfaZ5qC0R4iAntz9toDlCEPAjPn4LS/oGHggGDuRniTuRdXten8NjK0zyqSglR
         nTO2HH90N7PrT58oezWcV1Ldpb6d+Y/UsHXSVC9VPBpxE/V39JwTTAFZ2m8UFiwhii3N
         lU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737402127; x=1738006927;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G+sMdP1ffQ1QpY9XYLjygUA9VyRu5Zs9pUaqg1dvK6s=;
        b=haJq76o5WKC7KNW1JcFIfTa00DyFZ6of8MHzBJjXqB06OPmgpQqhAf9eA0rk+KnWy2
         LDwehnD6IFJhQOfz1KyIWWUYFQ5W2N0XTzZxfW2EjBn7SjRnzf9dMxgk3JZD2MECzN5k
         gNJ6jW7vm7QqBVdhZ3GEeh6E0RkqxUf/2Uj2/lyinE97ptzeFGuHSCBC6pTZdBtM1F07
         /jzKKo8AO1cENqiG5U+qwyIjYXJgtQliFLeAy2kxW76/+LtxRWPW/EkA2tgXwkqx3SOy
         +GKir76VB48qPk3xDF31zCp8wnksR38D53JybEOW8RrSvPLH7Pz5wLq6KLwHDumnkUC2
         7KVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpI4+FBm4+1VaNO8aGl5udWozNsacWQiOl8dXV8J8s6QEntuvTQAHAzGoQjXg4tsF/FYQ76ggCJfpAV3v37A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYWx/b8QlR3wcGXuo2bhVAIVAYHVsGf2XX8/ivkY6PWU3DNLv
	z5j0OzxAu5UhiiAmDBSw2Nej+xr4a6C86a41ggSu0+heGbY4g2ORRNA9cA==
X-Gm-Gg: ASbGncszrmQEUzyRRSaob0qE3Crpx9sAkYOj4h/arQ4wVzpCmvxgLakfFL4XcXL715S
	tfalgq5FZvPG/Z4dt/fDLTfrSDRL91ZP7B8TEZ9394U3mV1cVOlZbebdABmX5mcLUwplnSDPf0r
	V0hrJYltHzk+VIPDkYxVSdn7hzUQlvrm/iWp+A11WOqz+4b7xyqPjr02DlHpCBd1bFhIHdGYLPx
	1QDs4QXIjalTLDbBMXTvasWdk9dMrII9KrqHAbAa6G7+QPPVQL0hjH1cTlEYQN2vHaTQyfh5ixp
	BQ==
X-Google-Smtp-Source: AGHT+IHs8LP5/7gF/6PdpRbnkY4YbCP07bIBWo0q3veScHv/CdvLZoPDT36p1KNPvxZSMTOrOqijHg==
X-Received: by 2002:a05:600c:1c0f:b0:431:44f6:566f with SMTP id 5b1f17b1804b1-438913deb12mr122806935e9.13.1737402126421;
        Mon, 20 Jan 2025 11:42:06 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4389041f7e9sm153949685e9.23.2025.01.20.11.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 11:42:05 -0800 (PST)
Message-ID: <62826d1d-9cef-4eff-b6c5-5ed11405a482@gmail.com>
Date: Mon, 20 Jan 2025 21:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [RESEND. PATCH] drivers/mediatek: Fix some mt7601u vendor could
 not connect
To: Jakub Kicinski <kuba@kernel.org>, WangYuli <wangyuli@uniontech.com>
Cc: guanwentao@uniontech.com, linux-wireless@vger.kernel.org
References: <A9442D62405552CE+20240715094714.1553336-1-wangyuli@uniontech.com>
 <20240715065426.73ba0869@kernel.org>
 <43a58f4a-6579-40f8-bb92-6bee8075c72e@gmail.com>
 <54abe45f-a26d-4606-8f13-6b27b22d4811@gmail.com>
Content-Language: en-US
In-Reply-To: <54abe45f-a26d-4606-8f13-6b27b22d4811@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2025 17:51, Bitterblue Smith wrote:
> On 10/01/2025 00:42, Bitterblue Smith wrote:
>> On 15/07/2024 16:54, Jakub Kicinski wrote:
>>> On Mon, 15 Jul 2024 17:47:14 +0800 WangYuli wrote:
>>>> Some mt7601 devices cannot establish a connection properly.
>>>> This patch fixes the issue.
>>>> We do not know why, but it just works.
>>>
>>> Any chance we can gate this on the version of EEPROM or chip or
>>> something else? It'd be good to avoid regressions on older devices.
>>> Or possibly - could we issue the MCU command as a test and disable
>>> the calibration if it fails?
>>
>> (Removed some people and lists from CC because they seemed
>> unnecessary.)
>>
>> Hi Jakub,
>>
>> I have Tenda W311MI2 which works with vanilla mt7601u, and a no-name
>> "free driver" device from Aliexpress which doesn't. They have the
>> same USB IDs.
>>
>> The Tenda:
>>
>> Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: ASIC revision: 76010001 MAC revision: 76010500                
>> Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
>> Jan 09 22:39:40 ideapad2 kernel: mt7601u 1-2:1.0: EEPROM ver:0d fae:00                                                                                                     
>>
>> 00000000: 01 76 00 0d 50 2b 73 e8 19 76 ff ff ff ff ff ff  .v..P+s..v......
>> 00000010: 01 02 8f 14 01 76 00 00 4a 00 01 00 80 50 08 00  .....v..J....P..
>> 00000020: 03 00 02 00 00 00 ff 01 40 60 80 ff ff ff ff ff  ........@`......
>> 00000030: ff ff ff ff 11 ff 04 28 ff ff 78 01 ff ff 99 99  .......(..x.....
>> 00000040: 8c 88 ff 07 08 00 00 00 00 00 00 00 00 00 00 00  ................
>> 00000050: 00 00 1b 1b 1b 1b 1b 1b 1c 1c 1c 1c 1c 1c 1c 1c  ................
>> 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 80 00  ................
>> 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000d0: 20 f9 00 00 00 00 00 00 00 00 00 00 00 00 05 05   ...............
>> 000000e0: 03 03 04 00 00 00 02 00 00 00 02 00 00 00 02 00  ................
>> 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>
>> The no-name:
>>
>> Jan 09 21:50:34 ideapad2 kernel: mt7601u 1-4:1.0: ASIC revision: 76010001 MAC revision: 76010500                                                
>> Jan 09 21:50:34 ideapad2 kernel: mt7601u 1-4:1.0: EEPROM ver:0d fae:00                                                                                                     
>>
>> 00000000: 01 76 00 0d 00 50 11 00 5b 9b ff ff ff ff ff ff  .v...P..[.......
>> 00000010: 01 02 8f 14 01 76 00 00 4a 00 01 00 80 50 08 00  .....v..J....P..
>> 00000020: 03 00 02 00 00 00 ff 01 40 60 80 ff ff ff ff ff  ........@`......
>> 00000030: ff ff ff ff 11 ff 04 10 ff ff 82 01 ff ff 99 99  ................
>> 00000040: 8c 88 ff 07 08 00 00 00 00 00 00 00 00 00 00 00  ................
>> 00000050: 00 00 05 05 05 04 04 04 05 05 06 06 07 07 07 07  ................
>> 00000060: ff ff ff ff ff ff ff ff ff ff ff ff ff ff 80 00  ................
>> 00000070: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>> 00000080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 00000090: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> 000000d0: 1e f9 00 00 00 00 00 00 00 00 00 00 00 00 05 05  ................
>> 000000e0: 03 03 04 00 00 00 02 00 00 00 02 00 00 00 02 00  ................
>> 000000f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>>
>> The no-name device seems to die after uploading the third chunk of
>> the firmware:
>>
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Firmware Version: 0.1.00 Build: 7640 Build time: 201302052146____
>> Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 64
>> Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 14400
>> Jan 09 16:48:43 ideapad2 kernel: __mt7601u_dma_fw:327 len 14336 dst_addr 28736
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:09a8 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:09a8 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:0734 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:42 off:0230 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:07 off:0080 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:0080 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: Vendor request req:02 off:0080 failed:-110
>> Jan 09 16:48:43 ideapad2 kernel: mt7601u 1-4:1.0: probe with driver mt7601u failed with error -110
>>
>> Removing the call to mt7601u_vendor_reset() fixes that problem.
>> The firmware uploads, the device connects to my network. The
>> Tenda still works. The driver included in Windows 10 doesn't do
>> that reset with either device.
>>
>> At first I tried with len=8192 because that's what the Windows
>> driver does but it didn't help.
>>
>> After fixing the firmware upload, I had some USB disconnects with
>> the no-name device. They were kind of random. Now I'm testing it
>> with those two MCU_CAL_DPD removed. The Windows driver doesn't
>> seem to use MCU_CAL_DPD with the Tenda. I didn't check with the
>> other one.
>>
>> I hope this helps.
> 
> So after using the no-name device some more, I can say that only
> the mt7601u_vendor_reset() needs to be removed to make this device
> work.
> 
> The USB disconnects only happen in one port, no idea why. They
> happen with or without the MCU_CAL_DPD.

I pulled it apart and disconnected pins 9, 10, and 25 (the CHIP_MODE
pins) according to the advice found here:
https://github.com/openwrt/mt76/issues/393#issuecomment-1092754717

Now the CDROM mode is gone and the device works with unpatched
mt7601u.

So I guess you can make it call mt7601u_vendor_reset() only when
the device doesn't have the CDROM mode... if there is a way for
mt7601u to know this.

