Return-Path: <linux-wireless+bounces-1922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E802882D914
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 13:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 843C01F211A0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 12:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E114F8C;
	Mon, 15 Jan 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBeQ4URx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04E514F86
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e760e5b49so11184215e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 04:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705323052; x=1705927852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMtuJ4YDZ0P+YnEq3HxtB5OZNuKvllHb7JRzamrYGAg=;
        b=JBeQ4URxnbwgb5iD4usM1c6oddJyrGCS5ZOxE7yHvNQPVKHlmKPKnH5iCoOstw4XGu
         PIxq2pvqsocJEE6ZVlF1GzBSBEZXbfteb9mTXe70j7qfSFSsZfQQZQGAr9AHlvJUmOMn
         LSJO4OJqSIw6j+C5TvakSfRuEwNlsAaYJkBx5NSc8CkncD0QJBLBU1eIYOjH4up1qHGz
         FfaX5V24jCcTxc0/Z8CniD84u7ACWDorEOr8pyAnIfC0OWS5kAAgL6Z6ysv2OPmjYBHX
         A3cfd6bvD+FVK4Fv5IgwsrwgaEqT/8qMrazuRbXYBcpfLBEwshO0sRkttQp00l8q0Xk+
         HyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705323052; x=1705927852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMtuJ4YDZ0P+YnEq3HxtB5OZNuKvllHb7JRzamrYGAg=;
        b=ZnSs9Ik0mn9064vrC2MrKDGqZU2bXa5TMZ8A+gMUmqwYqgJLmFR3ap9wZKHmxXOIiU
         mklFn55AAjU9BQiu6N0qISzv3RMTlOfdYNK1BnL7nWI0DKqcwPgqvVaOmL194TCBQ71+
         DKTgRUIQjyX31B7XtUUhdNuIICfO9L/kFNjdZKDEn/+jUtGjjC2/zdIlbdwqupTNvXyB
         RmO+xqy5Bws7dtganx+qajSsNBs3+ODVnUZks/wQ4LN1o8F7KuWWEOhJV3u0IYhvedMQ
         t/etwj8mx119eHY9LxLpiy5rOYkdROc7pymFjPiKrlhMXLsaTUn4pSzwFiI4YMnQlpTZ
         CpbA==
X-Gm-Message-State: AOJu0YzpvaOl344ur1uxJau0V1QAmxjoaECrH/5Cm3Huz7nj70vQm0FP
	zcUJQBnm+e6cyZ8cA2TApos=
X-Google-Smtp-Source: AGHT+IGHn3bO6FmoXjEEDiowFwvlEFMrwk8LcK1JWfH4QWaC98e7VOQP2Fp4n+RkvT0ICRss7vdGAw==
X-Received: by 2002:a05:600c:4591:b0:40e:6e82:6f1d with SMTP id r17-20020a05600c459100b0040e6e826f1dmr1159476wmo.26.1705323051655;
        Mon, 15 Jan 2024 04:50:51 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id o9-20020aa7c509000000b0055504002a5fsm5413579edq.72.2024.01.15.04.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:50:51 -0800 (PST)
Message-ID: <d4fa544d-46fc-4795-8da1-5dd6199bdea9@gmail.com>
Date: Mon, 15 Jan 2024 14:50:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
References: <81b6c452-e940-423a-acf7-4a7b7c5e7847@gmail.com>
 <c369eeb8b3014f068d1c60b42b44e206@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c369eeb8b3014f068d1c60b42b44e206@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/01/2024 07:42, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Saturday, January 13, 2024 6:50 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; Larry Finger <Larry.Finger@lwfinger.net>
>> Subject: [PATCH] wifi: rtlwifi: rtl8192de: Fix byte order of chip version
>>
>> The chip version stored in the efuse is currently assumed to be in
>> big endian order:
>>
>> #define EEPROME_CHIP_VERSION_L                  0x3FF
>> #define EEPROME_CHIP_VERSION_H                  0x3FE
>>
>> But other 2-byte things in the efuse are stored in little endian order.
>> For example, the EEPROM ID, the vendor ID, the product ID.
>>
>> The out-of-kernel driver for the USB version of the chip uses the same
>> macros and version detection code as this driver.
> 
> I run vendor driver with 8192DU, and got correct 0xcc33. 
> 
> efuse[EEPROME_CHIP_VERSION_H] = efuse[0x3fe] = cutvalue[1] = 0xcc
> efuse[EEPROME_CHIP_VERSION_L] = efuse[0x3ff] = cutvalue[0] = 0x33
> 
> So, 
> 
> chhipvalue = (cutvalue[1] << 8) | cutvalue[0] = (0xcc << 8) | 0x33 = 0xcc33;
> 
>> They recognise
>> 0xaa55, 0x9966, and 0xcc33 as correct versions. With the original
>> macros, my device's version is the unrecognised value of 0x33cc. This
>> seems like a mistake.
> 
> Can you check the efuse value you read out?
> 
> 

I checked again like this:

diff --git a/hal/rtl8192d_hal_init.c b/hal/rtl8192d_hal_init.c
index 156541b..175c856 100644
--- a/hal/rtl8192d_hal_init.c
+++ b/hal/rtl8192d_hal_init.c
@@ -1565,6 +1565,8 @@ hal_EfuseUpdateNormalChipVersion_92D(
 	ReadEFuseByte(Adapter,EEPROME_CHIP_VERSION_L,&CutValue[0], _FALSE);
 
 	ChipValue= (CutValue[1]<<8)|CutValue[0];
+
+	pr_err("%s: EEPROME_CHIP_VERSION_H: %#x EEPROME_CHIP_VERSION_L: %#x CutValue[1]: %#x CutValue[0]: %#x ChipValue: %#x\n", __func__, EEPROME_CHIP_VERSION_H, EEPROME_CHIP_VERSION_L, CutValue[1], CutValue[0], ChipValue);
 	switch(ChipValue){
 		case 0xAA55:
 			//ChipVer |= CHIP_92D_C_CUT;

This is the output:

Jan 15 14:35:21 ideapad2 kernel: hal_EfuseUpdateNormalChipVersion_92D: EEPROME_CHIP_VERSION_H: 0x3fe EEPROME_CHIP_VERSION_L: 0x3ff CutValue[1]: 0x33 CutValue[0]: 0xcc ChipValue: 0x33cc

I'm using branch v4.0.10:
https://github.com/lwfinger/rtl8192du/tree/v4.0.10
because the master branch doesn't work. I don't think it
matters because this code is the same in both branches.

Maybe my device really is a different version.

