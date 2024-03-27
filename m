Return-Path: <linux-wireless+bounces-5328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E5E88E683
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33FC2B2A688
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 14:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF242A91;
	Wed, 27 Mar 2024 12:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXnL2k5u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835AC12D772
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 12:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542972; cv=none; b=H6RtqzDpaZOHYYhZhI3ZyBrjPs1Yqdcniclj9j1ImyMVV2gyrCysXB5Fn5t3vAsDZ5yeyHbyLEd/FmJC4UjFgykExjGvfdsilvVfGisgT0ViKnAltZHS9fNaFxQuEB6UhJEEgoLhHTtKKhKgrDOeGR89gvxpVyGvVESXNJxMIQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542972; c=relaxed/simple;
	bh=pw7qjHHDzJmnH8cY10SUVKwS/9Swx7mB2F6mQ3esVu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEs5iPudBv8db5/Lu2koPFKOHSkQHpgyOUwQ5aM94glxtVwFTOF+9poSfecYnGk4lb7QitLJ68dI5BVqNLKJ9Mcgsz4pE4UiMwy0uEGvMa6OYHncrzbUmiRcXftsGdSD1i1DWKH/ZgmuKezyV35lzpBj/uZscHhQ1Pg8CjztpvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXnL2k5u; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-414936696b8so4238365e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711542969; x=1712147769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JFyhDRaIZKL855ZoNyhHgPaD90u8u0GtZcPaq/rF7+w=;
        b=DXnL2k5ulq8X0340JwFMH6hIYnTnCcU9Tql8LES8zGQv9YEvwALYnJVHkKcO4pRZ5Y
         XS0xEwOnN4FnkaCrqbmOVGSXz2B0f4vAyw/m3VVr9Sv+1v8SFEgLYm6lKsZOSn8akgJi
         x2LuNTdBt9dwp/+X/vrcQW73xz0J0dTnbXecnazIxNcsqT0qw+CxITKXkp7RKJGpBnU/
         5szuCZw9LzFwdp1PV5AAzseaRlcUt4a2FhOa4ucVqR+dOlLA43Re6K2oPC0ey5mOohnO
         wYVCMSdYp5zKYov8YShJ+TwW87K3tTjFAlbC/D+LVnIItOgRbSa7Wvmp3WWwxXEtBVoS
         /1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711542969; x=1712147769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFyhDRaIZKL855ZoNyhHgPaD90u8u0GtZcPaq/rF7+w=;
        b=KNt0eNpzz1+K7wslFUKFzRPvjyp0ZIo+9xavEoHb8uqIFUh5Dhr69QXX3qsqdrPpN9
         u6IAdCAi727lq5cSWGue/h7FHUsAl3B6y+7koTIn2ZCPIN+dm6e/uCc1ZaSPevNQIq3l
         sFs3srXpNbs7RgcC6uBmdYY8tEb2WELn31JAc1YcMAhfAvzmBr4gigBE3FvLhWJ8on0X
         Gg/eQEpTYQb6kSLnQHHCSqTIHOKfx9nrfrId/k5VDPnTGVt5uaTHS+fUzLLFj7hcq5PM
         s9Cmt13GAP67mX1Ir/62PQuBC07XB02Ang94xY2MiycsuFBqb8JhqW5JZp9jFdioF2uf
         CDoA==
X-Gm-Message-State: AOJu0Yyt6ml4YO2dwtMkZMpdU2SZW3Simm2UbBb7QBe6p0NSMtkdp72e
	LYXxJCDoa3uv8F96bGN97cHCncqeJpc9zySvc2SqyBJCQLeOFo7kS+VhM/bv
X-Google-Smtp-Source: AGHT+IGbeub5j9bTqOEhJM0N4t0Txo0d//mCVUfD4j0xvydGcOO9nq8440+AgcStlA7W/UYxFncSMw==
X-Received: by 2002:a05:600c:5119:b0:413:4299:ec9f with SMTP id o25-20020a05600c511900b004134299ec9fmr4174271wms.5.1711542968618;
        Wed, 27 Mar 2024 05:36:08 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.188])
        by smtp.gmail.com with ESMTPSA id d17-20020a05600c34d100b004146e631a81sm2055183wmq.5.2024.03.27.05.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 05:36:08 -0700 (PDT)
Message-ID: <de1af6c3-25e2-4480-9da3-f3e5de1d6d5f@gmail.com>
Date: Wed, 27 Mar 2024 14:36:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] wifi: rtlwifi: Add rtl8192du/table.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <ed50254c-889e-4dcd-93db-f63b776e3503@gmail.com>
 <5170c29a7b565fdec2e004f9391d325328ef5a72.camel@realtek.com>
 <8a90f3cb-7218-4f23-8aa7-fcc68e2f4a93@gmail.com> <87y1a4yqvh.fsf@kernel.org>
 <5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <5d117cf09134b034e704b8a1b5167235963a9c88.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 11:30, Ping-Ke Shih wrote:
> On Wed, 2024-03-27 at 11:18 +0200, Kalle Valo wrote:
>>
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>
>>>>> --- /dev/null
>>>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
>>>>> @@ -0,0 +1,1675 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/* Copyright(c) 2009-2012  Realtek Corporation.*/
>>>>> +
>>>>> +#include <linux/types.h>
>>>>> +
>>>>> +#include "table.h"
>>>>> +
>>>>> +u32 rtl8192du_phy_reg_2tarray[PHY_REG_2T_ARRAYLENGTH] = {
>>>>
>>>> static const ?
>>>>
>>>>> +
>>>>> +u32 rtl8192du_phy_reg_array_pg[PHY_REG_ARRAY_PG_LENGTH] = {
>>>>
>>>> static const ?
>>>>
>>>
>>> I can make them static if I move them to table.h. Only phy.c
>>> includes this header, so that should be fine.
>>
>> Do note that .h files can't contain static variables, otherwise there
>> will be duplicate data.
>>
> 
> Indeed, so these cases should be 'const u32', no need 'static'. 
> 
> 

So I should leave them in table.c? Only phy.c includes table.h,
so nothing would be duplicated.

