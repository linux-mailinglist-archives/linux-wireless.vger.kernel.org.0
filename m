Return-Path: <linux-wireless+bounces-5288-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2388CAE5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999641F6590D
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61F21CD2D;
	Tue, 26 Mar 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4KLqaZY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BD51CF9B
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474220; cv=none; b=hMnxyWCql/yBubFvbBnkHez4RIK0V4aGMtk1sSRnMacRRyTxS00mvm5XVy6/PoYChUQtDktQ9Gj2if2+GkNSgd9LMYnJSC2Ob/WfA1q1JWyKsP+3deI0K4EHeoHjGi7nGWkr2aswQgb98XywD4JFs/KP0w4+hiBwgNDfcwXlwIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474220; c=relaxed/simple;
	bh=6VVxL8dDdhGxwIbfiSuGs7I5CKuKiuU4LilEjtb+oko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBMcNg3irtNMfIL8+zbG2rPlfQ+AgEjvFTojolRzsWvkVHY/li6zvLzr8QVsqGTh47nUBSV4tg9lSeSs6XTnBgusX3vlH07DrKlrwQWpztvnAMkbbFujdf5R8b2M+uw6lnOa/laHqtW+muRo3kPznB7MlxVXQo2bptJQzUcsS48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4KLqaZY; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d6ee6c9945so5619031fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711474217; x=1712079017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FunLBNSFotRb+aA+5dZO9Og2kuqXv/9opKuv8VaZg1c=;
        b=B4KLqaZY7FNyRz7g0e6d6ZnW9AAgRTNGCXjhc5yRx3249Z6WUmC6hHppjr4LOm4Q/A
         9OUaZs+LtId3uaEP6rgd6ADSC/AJiIJ24+BANgyzGJx+LRHjPwvXA8vAvxfYqcVPSVwe
         Db0Cm7qXH5YX01e+n2P/59dc9kJH77cEZcsqGuc8URwSZoZ5kKpwOXzmaj3d/Ckbta8/
         JBr7jhbalSIHHvDhmiHbUkvqHxLYjSAGp/1SPn4lQluv5GfGgp0GDMtRqYhsLooXsPcs
         pM1GOd6aflAevRTrniOfer5EKyFBQB1qPCascmR8O42VUwjQG3dTPK4s7AtyhUG/WEeW
         v8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711474217; x=1712079017;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FunLBNSFotRb+aA+5dZO9Og2kuqXv/9opKuv8VaZg1c=;
        b=VvE6It0LSR2773W6Rr/D6mbHMZfRH5MDVvdXRl8NKpeDS50cD+5FcYL6TpkYu13JMR
         PDdSE3PZ+fmAfp0TtBdxCWwEVGCeanUYhrrF15h3j5wZs6w2Fjvgego66ttGhiCOM3KG
         2anEGHKrWJIQp1WmFH6VitsNjturtBUmDvhFMo+XqqXbp+pvWEbd/35/Y8Q2Q9xhniQ6
         oI71z92eJ8VZkw4zG0p6VeHOnZUwnndefV2l0Xq/Ovd5wE6DP6RNc4ODgQwsXTnrfS3k
         h2Nyt9cxQUnb5jE3T+w2O9n+wj5NDdvvNVcwcHLu0bnJv0ppKh0NoSev3Qsp8e8iQVLp
         +IIA==
X-Forwarded-Encrypted: i=1; AJvYcCX/hvJunixSGZWcFTE0TqYZStT/fnjs7hpgcs48NLHaOBIorqG7a9MoCXvJe7Fcy9q0PZCYrD0oj1woFoBvXW7E+JR/pBD4o77Fp35H4kQ=
X-Gm-Message-State: AOJu0YwM5/RJu/me3d8NNSdBd1cxnw25BaHtCtMt76pYkH/AYQt8zXDU
	u40snxoFTZlHRLzWj13Z8d/PAxcwQKuioXdy9JCV3UJN0ztQk/wr
X-Google-Smtp-Source: AGHT+IEs87YIekdzFwgYYsTVAO3JpXflZ1nl9+IjbA3GkemWC9AEqcjJVA1v5ZdKudmH2US8yrphRA==
X-Received: by 2002:a2e:9015:0:b0:2d6:f127:f5e7 with SMTP id h21-20020a2e9015000000b002d6f127f5e7mr1026715ljg.21.1711474216771;
        Tue, 26 Mar 2024 10:30:16 -0700 (PDT)
Received: from [192.168.89.216] ([109.166.138.186])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c190600b0041480a98bb3sm11472817wmq.15.2024.03.26.10.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:30:16 -0700 (PDT)
Message-ID: <8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com>
Date: Tue, 26 Mar 2024 19:30:11 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
 <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 05:46, Ping-Ke Shih wrote:
> On Wed, 2024-03-20 at 21:36 +0200, Bitterblue Smith wrote:
>>
>> These contain the MAC, BB, RF, and AGC initialisation tables for
>> RTL8192DU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v3:
>>  - No change.
>>
>> v2:
>>  - Patch is new in v2, split from patch 3/3 in v1.
>> ---
>>  .../realtek/rtlwifi/rtl8192du/table.c         | 1675 +++++++++++++++++
>>  .../realtek/rtlwifi/rtl8192du/table.h         |   30 +
>>  2 files changed, 1705 insertions(+)
>>  create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>>  create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
>>
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>> new file mode 100644
>> index 000000000000..6f571255c1a5
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>> @@ -0,0 +1,1675 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>> +
>> +#include <linux/types.h>
>> +
>> +#include "table.h"
>> +
>> +u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH] = {
> 
> static const ?
> 
>> +
>> +u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH] = {
> 
> static const ?
> 

I can make them static if I move them to table.h. Only phy.c
includes this header, so that should be fine.

> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
>> b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
>> new file mode 100644
>> index 000000000000..71d943158c5f
>> --- /dev/null
>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>> +
>> +#ifndef __RTL92DE_TABLE__H_
>> +#define __RTL92DE_TABLE__H_
>> +
>> +/*Created on  2011/ 1/14,  1:35*/
> 
> Not sure what it means? In fact, version info is added in these tables
> already.
> 

It's copied from rtl8192de. I'll delete the comment.

>> +
>> +#define PHY_REG_2T_ARRAYLENGTH 372
>> +extern u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH];
>> +#define PHY_REG_ARRAY_PG_LENGTH 624
>> +extern u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH];
>> +#define RADIOA_2T_ARRAYLENGTH 378
>> +extern u32 rtl8192du_radioa_2tarray[RADIOA_2T_ARRAYLENGTH];
>> +#define RADIOB_2T_ARRAYLENGTH 384
>> +extern u32 rtl8192du_radiob_2tarray[RADIOB_2T_ARRAYLENGTH];
>> +#define RADIOA_2T_INT_PA_ARRAYLENGTH 378
>> +extern u32 rtl8192du_radioa_2t_int_paarray[RADIOA_2T_INT_PA_ARRAYLENGTH];
>> +#define RADIOB_2T_INT_PA_ARRAYLENGTH 384
>> +extern u32 rtl8192du_radiob_2t_int_paarray[RADIOB_2T_INT_PA_ARRAYLENGTH];
>> +#define MAC_2T_ARRAYLENGTH 192
>> +extern u32 rtl8192du_mac_2tarray[MAC_2T_ARRAYLENGTH];
>> +#define AGCTAB_ARRAYLENGTH 386
>> +extern u32 rtl8192du_agctab_array[AGCTAB_ARRAYLENGTH];
>> +#define AGCTAB_5G_ARRAYLENGTH 194
>> +extern u32 rtl8192du_agctab_5garray[AGCTAB_5G_ARRAYLENGTH];
>> +#define AGCTAB_2G_ARRAYLENGTH 194
>> +extern u32 rtl8192du_agctab_2garray[AGCTAB_2G_ARRAYLENGTH];
>> +
>> +#endif
>> --
>> 2.43.2


