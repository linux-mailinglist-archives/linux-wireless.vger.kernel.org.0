Return-Path: <linux-wireless+bounces-6680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 980878AD349
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F7ECB21970
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030221534EF;
	Mon, 22 Apr 2024 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4toDFpL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CD146A6A
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806707; cv=none; b=XQWRyBXu/oPcmrQRqLri2FGy1akiQ2gJXj0tBifwiX9hR2Vaso6LaxZ1LCEX3TZPHcmnkE7R8Z0iriPLa3Zi/NL7nvUax5r1SWai5JhS31+z1TetY0XYYVNY5EtXY2bQRxJtR4DyxNYT190Yk/MXRBclml2UsDLbTEv+0j1aRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806707; c=relaxed/simple;
	bh=7eJ7TQkbfD3YTD4LF10qmURKt0hnPyOFJ7iMKFqBwuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKtkN6hJjdguhnIbsfO2ajInkT/HaJAnsp7WU0LHb/dNLFZIKBe5F+wytE4bODK2/D+cnTXBjqdSOJ2jEhiB0uuZTJkr4Z0186fOKyYvoTy7UN2DiNnTLs4GCTOWVMfCLauV4BlItZzX6SX+7yvYf0MnCQhU/6cHUsdr8G9VFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4toDFpL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a52aa665747so568945666b.2
        for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713806705; x=1714411505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FmiBryrvqKrNbkCzf4o4d6sE0hBrYpo3F79VTyWBcC4=;
        b=D4toDFpLCQ+4Q1Dnkq+DpPMYiLVcnK45tRn7FfXrnuThTTKI4bd4d772iRmQE4YbMx
         4AV5Owj/HLJq4dQe+yNq0ULYwESB7cBspIE2DBoBq2SnOy1B6tfwnixWRdQkL8HyNVlG
         bprro5Q/bXBs/o1ACDQr3r5LL2qbaaupipfjqpeWMosKCGNP78+8YS2VMAWXb+K+uXwO
         vgnL7aefS7r7kZQdNqgIkQZHt8ALpRMFjvcdAB5pmBTVDfLxXLm6+7wgoiKHVfjhHTY8
         DwrlrwxFTIbLNfTBwZmNP/roYn8Q/xwJwCLyRlT+xta2PFo6g0G43ake5WntvK694P4y
         LeCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806705; x=1714411505;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FmiBryrvqKrNbkCzf4o4d6sE0hBrYpo3F79VTyWBcC4=;
        b=MpHwAKAYqVRSDgLxtw3c93nAtYsFHm+3l7Sj97bfsx2ppL/yaB9VUpLHJWUIqKrFgl
         NaOn2ngwSftGj2Nu0BLIfmA03GJN0P+5/sm9AiIOin8wHrzVm+kjK/fnKaixjNfwjhTm
         EJLz30KOVPOjET0vdlA47xL2wSEmylfC9F2nLPSHo4aE/9iv+hDSaJaI6EPzkPZhCdY4
         OpdYu41iAZiN9LVMnDYZSvACpmKXkNiBGEJk/6CRPrzZwCoNW2ngbQrZMQQxduABWzse
         AZQmZ7jcqdkrX+eyqMwUBRpgGKXSvKiBCd95+GOIHo+Iy7NFuKpAw6eYauqTviyEfzbm
         RqRA==
X-Forwarded-Encrypted: i=1; AJvYcCWECcuHSYkwax8Sm5lW34sUpf9uLVJd7MSXBuWjBlK3imriWlTZK8hhbsHOGVACh9Yue5ZwdD3QQvynP5NuKwovYiOiqg56wmq6fAQ16Vk=
X-Gm-Message-State: AOJu0YxVkDtGJvgEqZt6W8B66wtuM2raGlPPXAbaYkVR9MCcq2sHODA/
	P+F0PB4AQDE8u8eDcHdKTpLtDF4zujMxdEmWOrnKDraKdk8X0UDJ
X-Google-Smtp-Source: AGHT+IGDez0B8YH8kRNiTQcLZITM8YqVMcnhSHJfMo5lVnQ8zpsezZHVZbOUvbStNRbMbd7ACH3tGg==
X-Received: by 2002:a17:906:c144:b0:a55:ac00:63f7 with SMTP id dp4-20020a170906c14400b00a55ac0063f7mr3805679ejc.15.1713806704434;
        Mon, 22 Apr 2024 10:25:04 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id qs29-20020a170906459d00b00a5197fa2970sm5976593ejc.25.2024.04.22.10.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:25:04 -0700 (PDT)
Message-ID: <509ded5b-6b31-4750-9f87-4d080ea4f71a@gmail.com>
Date: Mon, 22 Apr 2024 20:25:03 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <459a193c-ce2e-4b89-827c-ff6721c470e0@gmail.com>
 <4e7bb78f7dad4383bc98f4a94a2c9b48@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4e7bb78f7dad4383bc98f4a94a2c9b48@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 05:55, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Create the new module rtl8192d-common and move some code into it from
>> rtl8192de. Now the rtl8192de driver (PCI) and the new rtl8192du driver
>> (USB) can share some of the code.
>>
>> This is mostly the code that required little effort to make it
>> shareable. There are a few more functions which they could share, with
>> more changes.
>>
>> Add phy_iq_calibrate member to struct rtl_hal_ops to allow moving the
>> TX power tracking code from dm.c.
>>
>> The other changes in this patch are adjusting whitespace, renaming some
>> functions, making some arrays const, and making checkpatch.pl less
>> unhappy.
>>
>> rtl8192de is compile-tested only. rtl8192d-common is tested with the
>> new rtl8192du driver.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> [..]
> 
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
>> @@ -0,0 +1,9 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>> +
>> +#include "../wifi.h"
>> +#include <linux/module.h>
>> +
>> +MODULE_AUTHOR("Realtek WlanFAE <wlanfae@realtek.com>");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Realtek 8192D 802.11an common routines");
> 
> Not sure why you emphasize '802.11an' instead of just '802.11n'.
> 
> 

I saw somewhere a dual-band chip described as 802.11an.
It seemed like a good idea. Should I change it?

