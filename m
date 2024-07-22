Return-Path: <linux-wireless+bounces-10433-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC896938E2A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 13:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FF31F2191B
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8630027702;
	Mon, 22 Jul 2024 11:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+pFm0UF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC3F17597
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 11:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721648606; cv=none; b=Ep7ZhsfeQnclwPwFNIzs0CvMIdj54dHoP2BcPCvkxUiJlJpQK0WyCEcLJLPP6pdDJcd0rMeHxcrc42I4MR121VGF2o15cUQFGHWjwYhd7pz/yyOjCBVCaOzFAJg6SrOOgV5LJUO8ogvFXLASBMcm6wvEhaTs38xYZ5ezbFOWmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721648606; c=relaxed/simple;
	bh=+YoJl37GupD9CGD14o2L5dfew+nSeomM0cav7/Z5WL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Arp7S6FDQiIh0U79gV4et8fR1WHvmm9FEn2fElvqo+hAC/So9Ik4o+9rAgzzpNSbrw/sryJ2LrnC+dU7XrZzJtIKE4bABrqqsneEv6ee0Z6Ec2iCK7Lrl3D7YBJh4zpvl+U4H8BCTa1pIXQkp0pBrPqYzmVvF+wIgdGoxdWU1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+pFm0UF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77b550128dso430500166b.0
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721648603; x=1722253403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5010jcDvjAPb+qCt+fZ10QUoiU+P1ntn2eDsLW9e8SE=;
        b=g+pFm0UFyyh3XixvgslplJQV+ZzWmbXzmtAV1NKPhUa2f8A+GHqPuRXddRFeq0zmDS
         UJ8piv2Y3HZR1RkNF1TZl+u9DroRnLROno/me61AZGkJV/HfbsC6RV1th948ZAK8on+u
         7t4Qg8XB8V5VQnlMfXeW+4TZ8CbQ5pK5vKp4DarrJhyD0CGgyFT+waCL6g/zeMs4dwt0
         hOKXx5RzZDk+dmd8V8PWfJxirWgigqZhg91MX7sSVmjjiR0FSaQJiAcmMl+ZeuweeHnT
         y38mliWGKdoP2N2MOLF1OOmyY02k+KQBXESbe6getawpPB8enDXMfYZdc0w9Zc/5us4B
         UX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721648603; x=1722253403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5010jcDvjAPb+qCt+fZ10QUoiU+P1ntn2eDsLW9e8SE=;
        b=xM3ZwS+GLAIhVP0ewmztNP7TOOWq7c/jCRRbXi1ivOwxI+5LEck8NXO5BfSxLGDc0Q
         J/xgcGkTGl+45Hv5ybfcoWJ5N/hdycYP/LiJFOQSbllNaX2Tv1f4GNypmzeM2W+BV1mB
         5OKo9c6WsFwp3z0HwodgO+sM3vFjVcv0UgZ1unaWr5tGMwVEZrSqKtuPd7TT28NWfhso
         nGz3gMNvvBj1RY79/v/a4dh0WBemZtydelMpeokKBbmwDgn1WNVW8Hegcl58qSLZlC5K
         jKQAAcX1jDhbQR6OdnEpiLFmALxpgP/U3yLikNtrgqaIFhMhamYHP8UBqSDAgfd5Pv9j
         +oYg==
X-Forwarded-Encrypted: i=1; AJvYcCUhJLrk5T/Gou6A1dOl/6/ad71AzJFWKj4AdJRtjVpP+WEbT/TZh1sKQOAEgH+yLZJIbDjptsHXw98zRSoBmJZ3e5VlL50ZsIK9aeMRcck=
X-Gm-Message-State: AOJu0Yxbk76i+Iij7tK7e0jE5i9bPrYfLizjy/rBifUHJecwiqRU69Wf
	ZZRNRhOWE0YjZS7l2PGnGxR/SfSD4b/P/WTq3sPYRBeadam1BSCgiBfjPA==
X-Google-Smtp-Source: AGHT+IF1re0lGqSoyeYHbVZyCvjicG0tbIIDhieTCwMvUjhCpSOebuONUCBRnHNbL8i94Rriemm8LQ==
X-Received: by 2002:a17:907:6d10:b0:a72:44d8:3051 with SMTP id a640c23a62f3a-a7a4c051a77mr495163366b.16.1721648603135;
        Mon, 22 Jul 2024 04:43:23 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a81b9cbdesm7846766b.59.2024.07.22.04.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 04:43:22 -0700 (PDT)
Message-ID: <67646f1a-250b-4939-9358-b0d076fa87f7@gmail.com>
Date: Mon, 22 Jul 2024 14:43:20 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] wifi: rtw88: 8822c: Fix reported RX band width
To: Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d3267712-e458-4a02-9408-f3d443185207@gmail.com>
 <e4ff967f72cc2138b9171e81ccadc35488c45559.camel@sipsolutions.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e4ff967f72cc2138b9171e81ccadc35488c45559.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/07/2024 13:58, Johannes Berg wrote:
> On Mon, 2024-07-22 at 13:50 +0300, Bitterblue Smith wrote:
>> "iw dev wlp2s0 station dump" shows incorrect rx bitrate:
>>
>> tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
>> rx bitrate:     86.7 MBit/s VHT-MCS 9 VHT-NSS 1
>>
>> This is because the RX band width is calculated incorrectly. Fix the
>> calculation according to the phydm_rxsc_2_bw() function from the
>> official drivers.
>>
>> After:
>>
>> tx bitrate:     866.7 MBit/s VHT-MCS 9 80MHz short GI VHT-NSS 2
>> rx bitrate:     390.0 MBit/s VHT-MCS 9 80MHz VHT-NSS 1
>>
>> It also works correctly with the AP configured for 20 MHz and 40 MHz.
>>
>> Tested with RTL8822CE.
>>
>> Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - Use Fixes instead of Cc: stable.
>>
> 
> For the record, if you want it backported, you really should have
> _both_. Having the Fixes: is good, but will not necessarily lead to it
> being backported when/where you want it.
> 
> johannes

Oh. But my other patches were backported when I used Fixes.

