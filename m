Return-Path: <linux-wireless+bounces-22709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2FAAADF4D
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 14:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF81C3B551B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF5025E448;
	Wed,  7 May 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VacKoebf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6048825F7B4
	for <linux-wireless@vger.kernel.org>; Wed,  7 May 2025 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621243; cv=none; b=Or0g7WGepNQa29JwABX/7naoaBuyk6LusqttyQ53sPZyhjqkDfnRCbgOXBGrMOtb3Q/fww6HuhpGQVhrLapftuNDbnWxg7yUA4hQxYWqqqGEZDh5VLDdOdkqWOE989wjFNF3FCI8GNzkvNgYbs07Ye2S2WKdJ5qjEsVeqVA4Qzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621243; c=relaxed/simple;
	bh=s1nWMSAsqLkUyvjaUg7HtoD/qw/s1CiRNpr/p5nwflI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Cd566eTvDj9Nc+ooRoNyV3+j+CznGZtkHxcPgl8EKLfDbVxttsMDWQqdkqzDeIVA5vT/jhqjGsbSiD+U4pk4212zdjYbKh9WscqQ04AFBHHPksO4K6uVF/C1keKm5OmLkVbY7egxGCaMuTAhDJQRJFOjtFNauFOp/yLOLc6qHqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VacKoebf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-acb615228a4so182268766b.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 May 2025 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746621239; x=1747226039; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NViojh1UZmKOXZB2h8qH9qc2/mGhk8LtxoxD813chjU=;
        b=VacKoebf2cpcoqH+Y5X+j7o3bVDwIRxINnU6QEdX3lDjB11OkS/sukG8DQDZrmstR6
         iGPwfArikxwfQ0c+tuT+zaWIBbi6mNlFek7M6lVux3b34p6CSaRfZAuSLbDdG9ESu7eb
         ozHnlDZL3vMM5RoU1B4DzTq0CkU8hEnvVo4L/vr9WlM8XiM/i6o50LrgavWXsNetVNyK
         8Yjet0tf8+bsMze2rRjBHfr9ZM5A1Q+KVR6QduSoz73iT62Z+7MXc1+wsOeRgRzstF8G
         Hb/eVrdYYLVR3msfNmQ5uEDmP7+ZmXd3i1A/DZYDNB0QPPst0k/5MQm6Xzh4hX2VzsMx
         Xmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746621239; x=1747226039;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NViojh1UZmKOXZB2h8qH9qc2/mGhk8LtxoxD813chjU=;
        b=OoV9drV/1PBlJgmuJOTZqfq8G1uM0mEG7EOCJbM4wkJG/MCeC2wpg3Ge/JdrbpyNtl
         GCbNsigXIqM9klBt4rot+raL8/MFN8X6kOmSv3DBDNk36Z04KHYFofePO28HWPakSlYA
         MQp7PUE66FUP0qPHuZux3s5OyqfTiIfI1vTI+BDqpDiUTWLMN8h8ziIji9beXoxWGuot
         C7RQC4NF6ERs5HFX2cw71A86aw22Fl75HUyqkR97WU0wqehsIF9gApEZST5Nx7C/VfOi
         X6IpBHF6YAP7uTuO8VZ4CrpXvn310wUGqY5DNq4qA6gme1iZF6tI59XuG7Rt+ufi8GS7
         fd8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVGG5D077MmorGr1wCGvifxxchYiJgqEU9Rrhkds7Jr51gY09B2BHCYKpRL9hNfthYIoj2UQcekojwxgytNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzoiSqVkEK2PFvPhZKilr9Sxmb9aVWuEmIY3uQutjYc/K5677F
	P0hOD0Hk9wQ6OBx2JlOOa3HmL5K2Lg1qkIvd7OcKuD/10yk4+Pd/hrtLJQ==
X-Gm-Gg: ASbGncsm+c57Uh0Bze3soegfGyqwzojLmPu7SNy9UTmLEwQtzx0DNdxAYzVaH9PFyIL
	5AQwEIREdNUE18dpZGENd2/Wk6JEB4qzyg2ZEOiuzpiuB4xuDap0LuAga6sK5XQnxfpck6d/WW3
	8y3pQTOLpMqUOdIKdMzSOj7YP4JAxjqE4dRoOmCkGy/AwGjOQNkOI6JudB3d1BNmlEokmdmoiHV
	8OrhSbXvfz6aE3NTHMUalhlYIm1M+Dzdh08MtjNSyD8GGz+tXIxFV3iYFZbOpyiS0f4cWRDy/8k
	sUKDH3g7igAzKlDTU11yaIdXbhurUVMGCIkOWjsG/2wjXAtD0g==
X-Google-Smtp-Source: AGHT+IEdJJM3KggfwCezvSkJx9x5Yui5uWffoKbEbmM+c+ly1D2xs+dV/qPdgWYsNzLTA8Cj/OmzUA==
X-Received: by 2002:a17:907:cd0d:b0:ace:be7c:11df with SMTP id a640c23a62f3a-ad1eaefaedcmr295979366b.6.1746621239351;
        Wed, 07 May 2025 05:33:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1894c29d3sm895655966b.113.2025.05.07.05.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 05:33:58 -0700 (PDT)
Message-ID: <05dbbbc9-58b1-4b4c-b170-ea4225b0ccbe@gmail.com>
Date: Wed, 7 May 2025 15:33:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 1/2] wifi: rtw88: Fix RX aggregation settings
 for RTL8723DS
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <4c79fdc1-54bc-4986-9931-bb3ceb418b97@gmail.com>
 <43ff8b6babd649b895e8af8993d53c36@realtek.com>
 <ff57b627-5842-44ee-adcf-f1b4bdfac1b9@gmail.com>
 <e057b56d05bb4d26b95932a05a1c50f9@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <e057b56d05bb4d26b95932a05a1c50f9@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2025 04:56, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 05/05/2025 03:45, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> Use the same RX aggregation size and timeout used by the out-of-tree
>>>> RTL8723DS driver. Also set mystery bit 31 of REG_RXDMA_AGG_PG_TH. This
>>>> improves the RX speed from ~44 Mbps to ~67 Mbps.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>> v2:
>>>>  - Restore the original behaviour for RTL8821A and RTL8812A.
>>>
>>> This patch actually restores the behavior of RTL8821A and RTL8812A. But
>>> they are 802.11ac chips [1] [2], somehow defined as RTW_WCPU_11N.
>>>
>>> I can accept this patch ahead. Please help to think how we can correct
>>> this mistake.
>>>
>>
>> Yes, the enums RTW_WCPU_11AC and RTW_WCPU_11N have wrong names.
>> RTL8821A and RTL8812A are 11ac chips but their MCU is the
>> RTW_WCPU_11N type. RTL8733BU (not supported in rtw88) is 11n but its
>> MCU is the RTW_WCPU_11AC type.
>>
>> I was thinking to rename them:
>>
>> RTW_WCPU_11N  -> RTW_WCPU_8051
>> RTW_WCPU_11AC -> RTW_WCPU_3081
>>
>> 8051 and 3081 are the names used in the vendor drivers:
>>
>> #define PHYDM_IC_8051_SERIES    (ODM_RTL8881A | ODM_RTL8812 | ODM_RTL8821 |\
>>                                  ODM_RTL8192E | ODM_RTL8723B | ODM_RTL8703B |\
>>                                  ODM_RTL8188F | ODM_RTL8192F | ODM_RTL8721D |\
>>                                  ODM_RTL8710C)
>> #define PHYDM_IC_3081_SERIES    (ODM_RTL8814A | ODM_RTL8822B | ODM_RTL8197F |\
>>                                  ODM_RTL8821C | ODM_RTL8195B | ODM_RTL8198F |\
>>                                  ODM_RTL8822C | ODM_RTL8812F | ODM_RTL8814B |\
>>                                  ODM_RTL8197G)
> 
> Thanks. Please help making a patch. 
> 
> 

I will do it soon.

