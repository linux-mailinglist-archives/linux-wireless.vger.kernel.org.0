Return-Path: <linux-wireless+bounces-18923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD2A34984
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70BEE3A2916
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708571DE4C1;
	Thu, 13 Feb 2025 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTH6f9Uf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E91CBEAA
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 16:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463191; cv=none; b=P7R38YAygscCRg3ANjm57oBbn/m1qorCLdXNDPJ5+f5qLqbPz4q3773t5Ws26UJV5usXlHTQaLrz3yaZLkAtY0pNhz6k3/xdxatk10liBDQXjlK17c5gpKTgjTHVpkdn0dFvi/ayPvvEYUFMFdeD4nHJW/Y/c/oSKcrlfNXX1ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463191; c=relaxed/simple;
	bh=FgyQItFHZ5V3G06lHLo7qfoHsViGuJnqONGJgvkLeUY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=LIGzMAT9J75mvwu0Mm3CBvIZusDkV8CjPVlMP1MPe/51yme4TqnE3yADtGs6QQ7yx/LRYdY3qhjGtEt2/yiaAVjxEcgvHlCJm0McmwO8C7yLdO2mrHqPVOEn8giNX3JORnD9gn2K1TbEPvkBRTwPUkLdlyckLXintqVde7o80Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTH6f9Uf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de6c708315so1566670a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 08:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739463188; x=1740067988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh9TEHg/Lf8POrjNWdgYs0gHGWjauaV7UFrb23eNqfI=;
        b=lTH6f9UfUpz042tKt4koegclJI2lWitNYhwzPDHYpzrTTqT16uLdgEO+NbMou3gmBY
         ZIMkkHK1OGAkNZRzP3kP4+bvLicNEfkhiabUEAZA6TfuppDGG//chXeiv5MrT614TKYT
         Fyiuvc5VumVnQzlMsJsbkL7Vadxrz311e5c/+Ge7fJimRACNGWUl9o/DBgc1tls4hJ4w
         gCwVDjJaZ1OvIM36+hGxRILDgAKvf+ytAQ9eEgM3lgsLy2AGNH0XnsGFo/fi7YqU4WxX
         xYxmv6PTMxgKZXYTV/S3tKPw5/59XgcSErEhsXyJu5w7bubaGVN2ECKBk8uhxq7SFign
         8lEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463188; x=1740067988;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh9TEHg/Lf8POrjNWdgYs0gHGWjauaV7UFrb23eNqfI=;
        b=YBJeB32q5CIa2J/NFvd0GRTWChy6gXthuqUTRIYpPP6DbmwnOAR4wZwmnLPrPq4hwY
         nQGvvonxbxnE5psPQklaM1X26+C7VouPfHWSByz/DleEl5NyNo2w25i1bJU4YJHf68kJ
         2HSIDuZfE4udEwDVduO3sTKrY+TNRuhHRKNb40fT4RYzbwK+NkDH/VQITTdssswx7Xpf
         am0Rk9vNL9BMxw9uLjQD/KJ7nQXPY6cAHhWUhUebb1FaSw/0q0rdORxYNqou+0W8E1bY
         twymws9HdotaDkimC+X2q0It42WrLGAgj8a2Eyu+ESfyFyXqVf0Q0V4ukJOdqSJorhsq
         wD2g==
X-Forwarded-Encrypted: i=1; AJvYcCV3kNsAKmQhUlQkoXLPolI8q2yzQxXppktf1HLQLYyESibYJKloPH7dSWBH6xS0e2S3wiq6rmR0j2G3JjzYhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwhybmaHTKOULYnp7FBoecuH8e2hREk8JrLDq3paqfQcavvWb+6
	z99+s6XWHRn63GSvKEDYE6yUkHmkqKlhXQM5oiCy8IRx+Z8i6Vvb
X-Gm-Gg: ASbGncs/ZF4VtX0Ugdbt3VzP2pUPdDWTOrHJuDxst30aw5slhlKWrXGGXCKNlhzc2+P
	/bDa82XCJPNwdsKOYQ36bMqsuO6yHm62coI2Rfl59Fyyqn5OnbimBpqSgjulKfTDz8rv3UhYFxW
	5vgf/yXM1vG5pYjfplvrBmXbbgp9WPsbS4o9HkyiEAI2QBXvP4KcVicFWz3QIY3AKf5stbeCOgq
	6svqcN8TR4hkW5KL/jdtyPRDnjJ3wHHIKVXvUUDK6x1Wh53u0K6yM+96q0f/MSEBTfP1lQerHc3
	pnKYMaKjiXUnN3RMjgPJdLiX
X-Google-Smtp-Source: AGHT+IGj9Rz0eg93xCbtwdJ1FpjKoIvyFWR/JL97FMmAks5LrvJWZbvbDik0tDg8Co+WENUqTwjhVQ==
X-Received: by 2002:a17:906:f597:b0:ab7:59a0:dd16 with SMTP id a640c23a62f3a-ab7f33449f1mr769128466b.2.1739463187697;
        Thu, 13 Feb 2025 08:13:07 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339dec3sm158467566b.157.2025.02.13.08.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:13:07 -0800 (PST)
Message-ID: <14e4f32e-60d9-41a2-b1d9-beabbd106b01@gmail.com>
Date: Thu, 13 Feb 2025 18:13:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 8/8] wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for
 RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <6bb6443a-3e2a-4cd4-83b9-34d2eb235654@gmail.com>
 <b4001e93119b4f9cafa9b02dd328ff71@realtek.com>
Content-Language: en-US
In-Reply-To: <b4001e93119b4f9cafa9b02dd328ff71@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 09:52, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Make it print the TX power details for RF paths C and D, and for 3SS and
>> 4SS rates.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/debug.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
>> index 1adb03d1210a..0efb5c19b90e 100644
>> --- a/drivers/net/wireless/realtek/rtw88/debug.c
>> +++ b/drivers/net/wireless/realtek/rtw88/debug.c
>> @@ -708,20 +708,14 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
>>                    "path", "rate", "pwr", "base", "byr", "lmt", "sar", "rem");
>>
>>         mutex_lock(&hal->tx_power_mutex);
>> -       for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
>> +       for (path = RF_PATH_A; path <= RF_PATH_D; path++) {
> 
> Can we limit path and rate by efuse->hw_cap.nss or rf_path?
> Only showing two paths and 2SS rate for 2SS chips would avoid confusing. 
> 

Oh, right. That is a lot of unnecessary output with the 1SS and 2SS chips.

>>                 /* there is no CCK rates used in 5G */
>>                 if (hal->current_band_type == RTW_BAND_5G)
>>                         rate = DESC_RATE6M;
>>                 else
>>                         rate = DESC_RATE1M;
>>
>> -               /* now, not support vht 3ss and vht 4ss*/
>> -               for (; rate <= DESC_RATEVHT2SS_MCS9; rate++) {
>> -                       /* now, not support ht 3ss and ht 4ss*/
>> -                       if (rate > DESC_RATEMCS15 &&
>> -                           rate < DESC_RATEVHT1SS_MCS0)
>> -                               continue;
>> -
>> +               for (; rate <= DESC_RATEVHT4SS_MCS9; rate++) {
>>                         rtw_get_tx_power_params(rtwdev, path, rate, bw,
>>                                                 ch, regd, &pwr_param);
>>
>> --
>> 2.48.1
> 


