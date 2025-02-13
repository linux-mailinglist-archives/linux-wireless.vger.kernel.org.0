Return-Path: <linux-wireless+bounces-18922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA29FA3497E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 17:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1FC3A8AC8
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025521DE4C1;
	Thu, 13 Feb 2025 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNkWt6jQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3513C14037F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463164; cv=none; b=DeSukB5dh5nPg2NTQYWt+tvhHWKzwujcaMisLk3Iz1c99jpi0QiG71VTxuC1t1JUW1P+9LTh8Yah90Rr//ZMWWv41IdeRy9I44sVrEkDPklnyQGU/CkAnfFX8Nou/rqZwGtZjWB1Pn10kfMAxwwJ/W3o/DVkt79CxtHf43/swWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463164; c=relaxed/simple;
	bh=KaXxcZBDScJ2BjakHYX4G4r9HkmCObgOn07lukWquZg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=MQNY5V6g4u/qUZelFVLqYbnUDJphWxsUGkjCvTTwVopU4E4li4EAWN3x3iGistPZgjBBQ65mSNWOojHorXgRqKDUhNrtvIHptnY4wqWCOEy/J25WYIa9UZ/+prORUCR/C8k3sDSq4Cr/kI56AOZJJGlGnh8GJ9WtNVVO+H/zUj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNkWt6jQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5dedae49c63so104083a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 08:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739463161; x=1740067961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OEPIMmeNEWTyb69yyIgwo0/9GtrAGB2wbMWpXkYngE=;
        b=gNkWt6jQznulggaAXGMgkRcf0hVYK2dSRxz4fJaulz7nDBPvmpiDBisnt5ttbxSm7z
         bgALyHCgRkfti+5vS3LrB9cl7daGpM7Iy5fCu9RZ3O9mfAfqcfzS1GbVRdonbEAEH44/
         X+kWshftgyFyRvt1F6dUpwzlc82r2/4GLNJ4Ab01pRjOp4Hs7nromGxRn7TZgf3ChTon
         TUIm6pa+kh3hQsNHVN1Iuq5c8hBLMRIezt2t+2tu8kLY0B/9QRoq/KX1nxnUs5emewei
         3C0s3kLlHxPz1aEGRvKW9AILgZQWwc3XedzNl8B+4lal+pHgaXt2FL3qGFw+1GICKkHS
         sjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463161; x=1740067961;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OEPIMmeNEWTyb69yyIgwo0/9GtrAGB2wbMWpXkYngE=;
        b=bIroEg8t/h0qPr9QK0Pbf0ToYvYd3xhrN9S8Ad05BX2HaVnzFBYuMITeDm3X4PyIG+
         LI/1mhaWjMsahjoGo04ML3dlQYgWNMDKeYc4g11HKoBIYD1a456AbZgQ8Zwyih2XKwLR
         BleublbNJBt7hmqTfeUF+wJP9fX6BM0WAPmn4dzBPT0gKT+Mo/Wf/6SNbgbn32RLxXTB
         YlLD4JHyW4wfBe4Ki08kx2rgTy8cctDiFrLmvPwvA71jADq7bqxp1VyLbROUHLT1iKVV
         PqZAO9I8Kd1vX1pKfQHYlY7yyY44yFQalRo8M2ANms20OzHesEPwfwIxUNLQurfCw9Kv
         2rEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzr+Ge7nQD+RpqpEYVmyJAjwxfK852LoNdm/8BHpvkkw2T3Sdt1//Il/vXgIpRHg5z6nYDPZnYcSfpbud+WA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wOY8kasP2v4gYkscVOY7qpbEzQLIfjM2wGIBUuzryswmN8eI
	oImJvR5MIjCRkuQUnOGAGSGQiObklrHpybVT5O9fSzAcoxJ5zHoD
X-Gm-Gg: ASbGnct9pzIxEmndnZ4UnB02ztSqg+HxjxTmxNDLuwl8guaXmD+eeNW6QsgY1uJfrHH
	hz0nm5Zcyt1sazKqiVDmAO9sOTzUoAajDY1zyQ5GzHJH+ILRRRcI0Cz1D5jehr99ZIPK+A+ldhR
	k2HGg7//2SCEEa5SjpgMPtNACMk+GhsOpeQJvIX3M26R6k8rIMFOOl2p4O0xiKMpnp78wqEhk2p
	HNXS5sShkvmFvVsMaLKqUAWOzBonfnuK+wuPYKpg+iuI/hnWkPPCno1nbXltaGmOMW63p1Df2Ny
	yemppmtnWK8Bq+RR5zsYBDAe
X-Google-Smtp-Source: AGHT+IFtKhPBG4c0KlKT7ZuXiIzwMNSroXofu5r7AQtMS9qc8dlroxTzYknibrBM/ON19iNPzTrOSg==
X-Received: by 2002:a17:907:968e:b0:ab7:462f:647f with SMTP id a640c23a62f3a-ab7f33d2602mr803444466b.25.1739463161050;
        Thu, 13 Feb 2025 08:12:41 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bdd04sm155794366b.164.2025.02.13.08.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 08:12:40 -0800 (PST)
Message-ID: <1d9c9889-dc63-4f2d-94f7-3f604349ab39@gmail.com>
Date: Thu, 13 Feb 2025 18:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 2/8] wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle
 MCS16-31
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <21111380-5db6-4a72-ace9-f18b5bcd525c@gmail.com>
 <23d28222-8f83-43a8-b312-d5858cf355d8@gmail.com>
 <48e6cdc3d0a240d8b7efee2523f95807@realtek.com>
Content-Language: en-US
In-Reply-To: <48e6cdc3d0a240d8b7efee2523f95807@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2025 09:30, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> This function translates the rate number reported by the hardware into
>> something mac80211 can understand. It was ignoring the 3SS and 4SS HT
>> rates.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/util.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
>> index e222d3c01a77..ba02ba72e104 100644
>> --- a/drivers/net/wireless/realtek/rtw88/util.c
>> +++ b/drivers/net/wireless/realtek/rtw88/util.c
>> @@ -101,7 +101,7 @@ void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
>>                 *nss = 4;
>>                 *mcs = rate - DESC_RATEVHT4SS_MCS0;
>>         } else if (rate >= DESC_RATEMCS0 &&
>> -                  rate <= DESC_RATEMCS15) {
>> +                  rate <= DESC_RATEMCS31) {
>>                 *mcs = rate - DESC_RATEMCS0;
> 
> Somehow, we don't set *nss in this case. The caller rtw_fw_ra_report_iter()
> doesn't initialize nss, so there is potential problem.
> 
> 

I assumed it's not needed because the MCS index implies the NSS,
but I can add that:

		*nss = *mcs / 8 + 1;

