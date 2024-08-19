Return-Path: <linux-wireless+bounces-11628-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B61295726A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 19:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08BD1C231AB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 17:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F65F186E2A;
	Mon, 19 Aug 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFbPUx4M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CD818800A
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089927; cv=none; b=MzkkknITmefXVbzt9Llk4tWEUWCz70dl9GuV8FfbD9CYv5IrAwikmGBtHFoeFyKKEzMmeP9dDJdm8V8yEXBR6KGhcg4c+ktR/ByWlv1WXrUzBfCtfW10/B4zeKdbDin3b7NJ8rk/6jngwo61kJOkzbe1Q8+iVgm9OM1oClORZ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089927; c=relaxed/simple;
	bh=h4Wc4T41KGHKk8jzvw90d8+AvicxNlhz3QEXU7py5Ps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=KFM7beI9OzxjUwxgYoh87a5FbfbYCVQHhIzydtUg41v7d7Qs+FLzlhIZjc/RJE8oCtpHP1pV/x1OQucvKBpLPauWc72g33+DucRDJ9tbo4b3kwiMgZ7Mkbff+B5riXCpQqFOAQPCu4K2EMR/0RY2Iffd+q+Y4RYV4fCcO8PJPoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFbPUx4M; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5befd2f35bfso1422969a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 10:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724089924; x=1724694724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d35mfRUacnEJV0a4Du1NA75m3eL8onF3S5Iza1i4nWU=;
        b=UFbPUx4MXbQR48NxyvV3CIQw47ZWniF9qSbwbB9XMmN0w0p+9sWeSeKO3JsbQF3ow5
         9AfGVRxY1i6QkPDryaZQCuUaEa5Y+xK2tMqqa5/faJL8Q/Ugdp0ZnJ5TtHaQ9ui+z+6X
         aCQqjQuzKV4M333X2bVT8qaBQ2jQICsRaEa4qPql27JTZAUXaliVfNM+yVEizzKvk3Jx
         8zAlWDzMjEZA2BlUY/gBSDOEST45yFhUW/Vqaz8vBjLX/m3Gbl6aTpxG+FWilhTLfSQf
         yIXLumc/eQk3FRFQ5kb12J8Ec77ufe57j0pHO6s/k4my5XhK9C31R48byqR/qTSUBWgP
         2n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724089924; x=1724694724;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d35mfRUacnEJV0a4Du1NA75m3eL8onF3S5Iza1i4nWU=;
        b=DKXHjlXmAKYkKYLUkul6CrFpLZtJdQhNCEREdf3vkRPyfRYw/S2tX2QZZOKSy0c+By
         oLWzTzm6USKB6PP50kcqo85AIJwnXER6fw51DdYU9BRofwad6OBRF1naa8KFUCfFvkb4
         WaeXh5fmfcT/Bb/gUj+nACvGO/h4MQbKJyQoxM80TwhSYmiAy3I72EzCHrUg34JFzC+u
         COJfY43s9lWuGymI/7vdcaR4Cs795BxvyzFN/mQ1cGitzrAHa2A+B5jO0qvz6PXYn+Xo
         MjuuV+FsAX2e915hUU56Sxkcc8TTotMutcxI9rn7kHiAyF0Jdg95q4QpOcgPq2oFmcQH
         C2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVwg6tzPCXyBYDQIAFcvOTvPO7CoJU/T02WTwTrjJTeqVJmEQngzcivhVb5zgZObvNMLHkxFaoH2Zt5HGZDpmxBGE3gRbdD2uy5QTln+q0=
X-Gm-Message-State: AOJu0YxMbtQX0xyz42xsV/2Afb49dPMix0ZTCM6AWNe/BrvD+B6GBi4W
	DvrpMFBs8Hai5shxRlR+iymOO60uplIg+GhzWUdXKtIaJkWv02BdBZdf/g==
X-Google-Smtp-Source: AGHT+IHFtCg5tP6sxWYv5F2BN0BTPVBEj7to8DZPFV+llICb2K9TgCJzDGlzOBwuAr4AY2qfNcFwGg==
X-Received: by 2002:a17:907:7da5:b0:a77:e1fb:7de9 with SMTP id a640c23a62f3a-a83928a4a79mr765095366b.5.1724089923149;
        Mon, 19 Aug 2024 10:52:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396c62asm656559466b.209.2024.08.19.10.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:52:02 -0700 (PDT)
Message-ID: <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
Date: Mon, 19 Aug 2024 20:52:00 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
 <6071028680d14afa8e0eed84821f51c6@realtek.com>
Content-Language: en-US
In-Reply-To: <6071028680d14afa8e0eed84821f51c6@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/08/2024 09:14, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
>> Avoid the "invalid ra report c2h length" error.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/fw.c       | 8 ++++++--
>>  drivers/net/wireless/realtek/rtw88/main.h     | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
>>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
>>  7 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>> index 782f3776e0a0..ac53e3e30af0 100644
>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>> @@ -157,7 +157,10 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
>>
>>         rate = GET_RA_REPORT_RATE(ra_data->payload);
>>         sgi = GET_RA_REPORT_SGI(ra_data->payload);
>> -       bw = GET_RA_REPORT_BW(ra_data->payload);
>> +       if (si->rtwdev->chip->c2h_ra_report_size < 7)
> 
> Explicitly specify '== 4' for the case of RTL8821AU and RTL8812AU.
> 
>> +               bw = si->bw_mode;
>> +       else
>> +               bw = GET_RA_REPORT_BW(ra_data->payload);
>>
> 
> 

Would that make sense? I check for less than 7 because the size
has to be at least 7 in order to access payload[6] (GET_RA_REPORT_BW).

