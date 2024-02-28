Return-Path: <linux-wireless+bounces-4172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2786ABB8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9297528C1E4
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D92936AE1;
	Wed, 28 Feb 2024 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dz6JZdCs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749A536AE5
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 09:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114225; cv=none; b=NEu6py9RUQSyd3HWAvum6++Gyjm2Y76WMF5f3ouxhf1FyC6w2Hext2I0rldLeW5bbo3aGV+55NUjC+VkoQH7mfj+CYmFwI9omVVpstIh81fpdC1N/DfrzSMwUTVfbtXPXy+FkNydFftOYqTiA/pPQ1nNkSmyV4dlWYyOP+n8qw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114225; c=relaxed/simple;
	bh=ytukn58XE2jz8twDhgASBLNiY4Lgqw6GNzAVZ8aLAUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=odQBH97oUq3l+gkjP3D9cQL58/Pm27oBw/MbhhUVD5lSK7b7Vvqm+O3GYv/VI7xFrDIHEnsDWRBaJrqkYBq0g/RFvwZdQC6GOo2zIDPpSPltVx7krBwHULC3wzhjhYrlv/9K/e6rzM8DHek0HmPxD/pbRl29aiWTW1pOLCGyW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dz6JZdCs; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso7047716a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 01:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709114222; x=1709719022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYeIZVyhQqvBcCqZKAZX3Q597galSijOaaLq9tWBOPY=;
        b=Dz6JZdCsoZXwb80Xk8iIOnvPZSMRuYVCmTr4TEgiBmpWXQweKnbHkDC/H9tGHV88e2
         apmVWgoECjHHJ2v2sLnYKJ8kGLUllWzuDoL6rEqV0Kvvgo71kACgrFKawwJyMPU1Jg8Y
         /eyOxnZ9h19UIk2O7BGe7Fx+ENZjtkAZ81I8rrsVzsQBP8zWYAP0H5zKA9+9KRvXSts1
         Z3fUKtINluJRYcQMQpWm3rHu2lLrH0ybpD5LtTJnDPgrbEASVidP5mu4WrMWGmLEA7ro
         VKjejds3PPQO2a2ilXMB6jhEB15/DCzIWQnRwdou8tsWNmcIdxVZUA1RaVkiwPXdaG04
         SBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114222; x=1709719022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYeIZVyhQqvBcCqZKAZX3Q597galSijOaaLq9tWBOPY=;
        b=HN8jhHWtA7DYuHfFlHYQGyGySnUIMRlA0VwUXzSAkuJCK2u2c+L32HgsD5do4LrBuo
         ONS/v/WaIbm5F2sfWKajlkq8J4Ulmjn77yf5z1Luefdh7925pUdrwYJ6xTdlXR6pPlx3
         X+0ucY/teP4rb2M95DDXhIkNfVIcM7XlIuNCUO5BxWiRmB92QiPBv98tRDHVu5YDuwWS
         OHBPl/C7IgK2/G1jg6bugNVZ550DzDpv7lHPDiAI4YQcCgYzSu3v/YWiabfl2KUovqYI
         nSWaTzJoSqhKc0/l2U5g8T7jthVDMYzlVreRel15qJOe0PloSqcqLmBhnIIkPq8hyg6H
         kj4g==
X-Forwarded-Encrypted: i=1; AJvYcCV+twKtKIA4e3NYDrTkfN3megVCkze8x5YruGrrdd54176/HgsZ/IRgPlUz5HQJjvgqWWvlAPrJAIJRwPvDFpqLrjrsCRsRP0snlkpJ49o=
X-Gm-Message-State: AOJu0YwEeq910a/DpKuHdEjrItM6aevNyufhIN71S3tvFUWWIe6jRJ3j
	9cmHpByz610kJVPypKVkADd0IrkA/F7eb4NLz4AuepgzBVbpbTmvEL9xiW2K
X-Google-Smtp-Source: AGHT+IHKgoRAWkE50lep95qovcqSNMxRt88vCw0l4gkUlNqCI+PT41bZz3P4NtpwUzj+avqpwBmMsw==
X-Received: by 2002:aa7:c695:0:b0:566:ef9:a499 with SMTP id n21-20020aa7c695000000b005660ef9a499mr4775973edq.1.1709114221611;
        Wed, 28 Feb 2024 01:57:01 -0800 (PST)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b005658186279csm1619725edv.18.2024.02.28.01.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 01:57:01 -0800 (PST)
Message-ID: <c68d2d91-fb81-41e2-b8a2-0eb63783311b@gmail.com>
Date: Wed, 28 Feb 2024 11:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: rtw88: 8821c: Fix false alarm count
To: Larry Finger <Larry.Finger@lwfinger.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <38e3d94e-0cab-4a43-be10-c15ff5387919@gmail.com>
 <b908b9a7-e1fd-47ba-b573-ac11b334101b@lwfinger.net>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <b908b9a7-e1fd-47ba-b573-ac11b334101b@lwfinger.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/02/2024 00:46, Larry Finger wrote:
> On 2/27/24 06:20, Bitterblue Smith wrote:
>> Make dm_info->total_fa_cnt the sum of cck_fa_cnt and ofdm_fa_cnt,
>> not just ofdm_fa_cnt.
>>
>> Fixes: 960361238b86 ("rtw88: 8821c: add false alarm statistics")
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>   drivers/net/wireless/realtek/rtw88/rtw8821c.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> index 429bb420b056..fe5d8e188350 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
>> @@ -773,9 +773,9 @@ static void rtw8821c_false_alarm_statistics(struct rtw_dev *rtwdev)
>>         dm_info->cck_fa_cnt = cck_fa_cnt;
>>       dm_info->ofdm_fa_cnt = ofdm_fa_cnt;
>> +    dm_info->total_fa_cnt = ofdm_fa_cnt;
>>       if (cck_enable)
>>           dm_info->total_fa_cnt += cck_fa_cnt;
>> -    dm_info->total_fa_cnt = ofdm_fa_cnt;
>>         crc32_cnt = rtw_read32(rtwdev, REG_CRC_CCK);
>>       dm_info->cck_ok_cnt = FIELD_GET(GENMASK(15, 0), crc32_cnt);
> 
> I applied these 4 patches to my rtw88 GitHub repo, and loaded rtw_core with the disable_lps_deep=y option. The option reduced the number of "firmware failed to leave lps state" messages, but did not eliminate all of them. The messages I received are as follows:
> 
> [ 2063.847153] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
> [ 2450.120216] rtw_8821cu 3-6:1.0: timed out to flush queue 2

[...]

> [ 4323.823755] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
> [ 4453.846759] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
> [ 4455.822861] rtw_8821cu 3-6:1.0: firmware failed to leave lps state
> 
> My system has now been up for about 4470 sec. Obviously these messages come in a burst.
> 
> Larry
> 

I have never seen these. I guess you don't get these messages
without the patches? Can you see which patch causes this, please?

