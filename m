Return-Path: <linux-wireless+bounces-24779-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BE5AF63CA
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 23:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6A04E23B0
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98A523026B;
	Wed,  2 Jul 2025 21:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDGpMe3v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752C2DE704
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 21:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751490822; cv=none; b=gUriqB9+xx07OOOlTAavQiclmUzwiG2vfgHrXpNGK/gf5TFX/5rbnNhN5GX3OJs6MY5CS+cgA1lNF2erpOCrYdr6tMbiCWmqimebACCdryf7MjY9EieuwLP8U1xT4dkVMFKMD1ITWvAejDVZyY4k7OY6NTWjlTYzpe/Mw6Gm0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751490822; c=relaxed/simple;
	bh=8YMsS5fkKyvSyItUz09TgJmgIS/5LonUGAE5AZTXh98=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZDvJk+3tEuJszLFW95NX89fjK/E8TYFNbiAVblmuo8ILW7GcthLsw87Udcjd3B0aG0RTtiXk0KY39NI/YP4Pi/AqCC12/jHQPG+AvMclVqokd+EX0azUnMt88GlbeYJR9RYFKFaDOAKaBl2ObfLZeZ/t5w9jkOnR7/WunJSkwks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDGpMe3v; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-454aaade1fbso1913085e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751490819; x=1752095619; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3+Hl7cVnRlSb37aVj0JkVJ0ftgbOilQfeh37QUHOGh8=;
        b=fDGpMe3vVk5S/v2/EBv7d1IhPky4P5vyJBeH+J1PRniaURewx2lgx7RAJJZKVleejx
         lq42uvyX4pZsolHYQy1iopVpg7Wqk3eBbEWK4O+rmSX/bFJL24GZ1keWcn2vU4VhX1IS
         0IwVmItSSJ/MKfBHZMf3T+Q2fiKMyMZD79GxnudNRGvKWLtkUWkJLkTmvOA+/XHK0AP2
         uB5n5qH8oGvrn8t8gSSaqdoHJnjm0JBYpHATqD5ahxZmy8t5HZ1nYrY4Q+hBWCrzb8aF
         OIHfZYdZeN2HliOWeo8jHMDUAc3kAdjg/19Eh6S+qiHGC5PL8jdjsbVfsZ4ve3NeND1w
         tiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751490819; x=1752095619;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+Hl7cVnRlSb37aVj0JkVJ0ftgbOilQfeh37QUHOGh8=;
        b=ZXSmCBPFdqXCN9W+6jqR8Ms1Ts4xUq6IXhPknaLGbtUnmjcnPHFsdvsTUdqCE3Tmek
         WE4Ib+YLF1o9DMKc2yTz4d6F9Ep3oyHckysqPm3AbGOGfai0V2erGlyq80Xqtxw3fpR9
         m1Jovm4bMTRPgpA+lsMjM1SweKC47qcDdFDG12VYEbJtmppj2+J1Igz1ujvRsdMunLDt
         FezOl8TxhK7XmDLqgMKCR1jqzzFPhJ1zzqITWlhWAUj6K1Qj44MOyTp4QtLPoYtrzeE4
         BOLVSMWoukvhwbiGErBPWVu/f0PsYZbKZkQyW5CJltUy66fUadioK/dgbHfoDIAnGuSU
         VuDw==
X-Forwarded-Encrypted: i=1; AJvYcCV+/sFsnnSIj9Jw2eKfD9oAdpDDioctEhZfJy6NZ2p0zDF3wgP2J9WmoujuX/XG3a1VILjr/zJ3flf5YX6BKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQlrRCtgOpXHVq1NLXRGTBMmCDR3UdZXAryoOzBntC/3W0HTOa
	lF3KIuu0PZ07Uz+APmv2JUPbt/FbefGlBAvY4AXo19rUQxHVbc8b6fQl
X-Gm-Gg: ASbGncud4xFy5tQsSl77ijLQYlxthMz2vpIVG6FHNKMnfLmrycJENIZuiyDgCIiMiV8
	6tmF6Lp9JCS3M9uEz9HCTil8AIv8m+xO/LV+PsbScpbgKwMLbTd3g7lu+AhWtTCqNWZj7ljHCvJ
	kYLwgcow1kk6r4CSYjCzKaCK8FISd6jgXPpxEn9XC59HfVxsOlac4sCHX1Z0jIOcryAHAui1GbR
	HdvTVkFdPVTtfVa2Jaaj19QadyncwXUZ+Wqk6STzXOPAMV+HtXFIOsJ352WjlqHeqUl5uKY773n
	a+Wg9tHmjB425vv0iXmPMJyFjhorG3+8Hb9vo5nBgiO+w+Wh2TDCVtS3KFL4CVzcQpfd2g==
X-Google-Smtp-Source: AGHT+IEZDUhkiq9MhKVcmrjgRKqGKG8stuauBYu9wBvFFrRy/6yraHeumPmYwXzhq4GGYpfMvxPDPA==
X-Received: by 2002:a05:600c:8710:b0:43c:fe5e:f03b with SMTP id 5b1f17b1804b1-454a372e783mr54859725e9.30.1751490819063;
        Wed, 02 Jul 2025 14:13:39 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a997e367sm8102605e9.15.2025.07.02.14.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 14:13:38 -0700 (PDT)
Message-ID: <db605d50-5424-4cd8-968a-9864f9067458@gmail.com>
Date: Thu, 3 Jul 2025 00:13:37 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next 0/6] wifi: rtw89: Add support for RTL8852BU
To: Shengyu Qu <wiagn233@outlook.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <6f7333ac-17ad-445a-b273-c45e3f0542fa@gmail.com>
 <TY4PR01MB1443286365BCAAE548AD4702A9841A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <TY4PR01MB1443286365BCAAE548AD4702A9841A@TY4PR01MB14432.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01/07/2025 20:44, Shengyu Qu wrote:
> Hi,
> 
> Great to see 8852BU support! Btw will you also add support for 8852BS?
> 
> Best regards,
> Shengyu
> 

Hi,

I can do it if someone wants to pay for that. Otherwise, I don't have
any plans.

> 在 2025/7/2 0:00, Bitterblue Smith 写道:
>> Add support for RTL8852BU. The changes needed for this chip are very
>> similar to the changes needed for RTL8851BU.
>>
>> These patches depend on the initial USB support, of course:
>> https://patchwork.kernel.org/project/linux-wireless/list/?series=977480
>>
>> Bitterblue Smith (6):
>>    wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
>>    wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
>>    wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
>>    wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
>>    wifi: rtw89: Add rtw8852bu.c
>>    wifi: rtw89: Enable the new rtw89_8852bu module
>>
>>   drivers/net/wireless/realtek/rtw89/Kconfig    | 12 +++
>>   drivers/net/wireless/realtek/rtw89/Makefile   |  3 +
>>   drivers/net/wireless/realtek/rtw89/rtw8852b.c | 85 +++++++++++++++++--
>>   .../wireless/realtek/rtw89/rtw8852b_common.c  | 16 ++--
>>   .../net/wireless/realtek/rtw89/rtw8852bu.c    | 55 ++++++++++++
>>   5 files changed, 156 insertions(+), 15 deletions(-)
>>   create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c
>>
> 


