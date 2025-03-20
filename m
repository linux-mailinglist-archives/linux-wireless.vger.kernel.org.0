Return-Path: <linux-wireless+bounces-20611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09223A6A05F
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 08:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CFD61889E32
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940D31EFF8C;
	Thu, 20 Mar 2025 07:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owaW0wef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B40189B80
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455428; cv=none; b=TzvLm4jCX1ctFOr5z7oO6fyuuLm3bJZHyL1tui8VuVDJ9fz0D93ZgE+s1vVYBwcfOzb2RiE7M97eTHj3bpm5vrF9BRp/mWhXpWTgcsXLEyRkOgSgjVOI8XrTo7teemlUd7T5Tffjp/pZCLB1J24V30CYLU5UfIkaNMC7290WInA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455428; c=relaxed/simple;
	bh=sFD1mz28JCXdkPB1syw4vIX/Dh23/SQ9SEmrK0kv3oU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BaJG8JqdMhI0XwLSGeC3MbcWeKyAHCcsNIx/04DeLz99A0IsFz//Ckq42xkcjADgtO94aE75ou/sWgTMEtMk3nuAjxLuxOEcR5y2434lchrMkMrgSytFIaKdWqM/mpjC34kxL/S5PToX/PQBQBp0rTS1otUlkJ/5szpKXhagYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owaW0wef; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52K6Z7gf025426
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 07:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DG/5sD4Uvf9BOqZKHlnsUC3tiWerZEGqI1/LRL2gjes=; b=owaW0wef5EtBNa2H
	sEoUuyguN9WHKrJPo2z+rX/YirJK/kBA+rdQKnOizcOie3QeuQcGaAj89xatWOkt
	LtM/YpAtWJY4pKHQj/LuQugBo0Ewmh29jq2UM/PjtVj/EsN6eW3x7fv0EeiLu99M
	L7mt+uNvAF347509tfj2bNpzVUiRbV+BCY0qLvGWgzZjxOM+leM1KLfUmo/FDXBZ
	IyA8O+5kyjGthgd12x2g3Nw+U/YH/eZ96DuMx2ngnQA2iw9Oj+2YYxULH3pgkrur
	aFkC8TQgliO+k3gARLmHV+Qij+OPDAuz7NRajsJ7pUNMY5WfzBOMv3B6VAU7i7WN
	LeQ4gQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45g15y1ydt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 07:23:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so783801a91.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 00:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742455424; x=1743060224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG/5sD4Uvf9BOqZKHlnsUC3tiWerZEGqI1/LRL2gjes=;
        b=X2WS9QxgEKvU7ln+lXqCZWgn3/A9ts4cqVamTlBexGhdifr/JgCoy51SDWsWW8trx1
         MsjWs6Dr5J+DUNYOmNeWwFjFrU8+VZ1S4oPY1AEfp5rQdwKGNRniqtUSU7fE8/Nif5ka
         EVMr8fphb2sVE3ttiIRkJVD+3xohiFr5ZyzB+P4/2u5oglaEE8wy7VuqeYhbSKMMw8Bw
         wStVfzNvYd6ttl+hNPLmqAFuyT7vuPLHpfzBI26w8URmsMwaZIXcs8hCuak7hLWJ12Zg
         spIRWzp9HnNUal8D+FKMWppXwRYYUD7YehwEQOiUt8cN7W8oyWjHThbHql9FowvvcI1/
         LIQg==
X-Forwarded-Encrypted: i=1; AJvYcCXEC9iLu64Kh4d8dQRDikMjHLXL2pOk0Q20/LT6PLueDoOSFX4wg49o08uYSEwmz9NDNUljImW8k38UKfmR3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yykszf6QNSbYhe8ItHc2p3AAp0XOyynb/oD9+4vgj+l1Qt6RHFq
	e6B5Q2+VX428xVzC5nL45298HqTESqQ6sXPcyAG3BbM9ukIuKgNxFRhj+BbZPlU/5lLUiKo03NL
	rvhRFVswWcyyclwzGYzRGPBLPI/C/zsVZLRQFpGZEyt3Z7MPi/b8REoVhuQ5vgU9nAQ==
X-Gm-Gg: ASbGncsDsIZz277Z6WRkTEh+02Q1xRROf3CynAqPhqqPccqakpi6MHMM5y+QX1JNBCB
	vtlmFW2bPjIDbsy9Jfvtj2OKWlFcIPCkBlX3Szk+t6rADssRNwFlnJLytcrgzrTStB4XBBKJQ6K
	n8kYraDnwoqJ4gyORLjZp9NwTloYxpRGYxG0MU29VBFpxCKnJGsAmnjJQAHq/C4V4cIy+tbt8Pe
	Uis7GLejfIE68M5lT17SPuSHHNw+WfHWdlJDu3/Z+a2Nyt6sHqwKj1OeKyL6a2nOUhcTDNiMFAM
	17Mp9Q2bLJeF7QfOmrPFtRKCmd4rEQ/GuZSyfkAYNF4N7bFAxWfXBoEqoQ==
X-Received: by 2002:a05:6a20:7f9f:b0:1f5:8622:5ecd with SMTP id adf61e73a8af0-1fbecd36dcemr12362595637.32.1742455423745;
        Thu, 20 Mar 2025 00:23:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6vL0FKiT0FrUm64NWVT0vyhZLgbzJ4G/pmtWfyzAlb6pKCq5XuCaqJLVhL29ETCkhsjK99A==
X-Received: by 2002:a05:6a20:7f9f:b0:1f5:8622:5ecd with SMTP id adf61e73a8af0-1fbecd36dcemr12362537637.32.1742455423217;
        Thu, 20 Mar 2025 00:23:43 -0700 (PDT)
Received: from [10.152.204.0] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea0408fsm12218652a12.42.2025.03.20.00.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 00:23:42 -0700 (PDT)
Message-ID: <c556876d-01af-a6b7-51dd-2748d6d0bbba@oss.qualcomm.com>
Date: Thu, 20 Mar 2025 12:53:37 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net] wifi: ath12k: properly set single_chip_mlo_supp to
 true in ath12k_core_alloc()
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, neil.armstrong@linaro.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson
 <jjohnson@kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250303-topic-ath12k-fix-crash-v1-1-f871d4e4d968@linaro.org>
 <24b2f1f8-97bd-423a-acbd-9a5cd45e4a40@oss.qualcomm.com>
 <7901d7f0-d6d0-4bf3-89ad-d710e88477b7@linaro.org>
 <7b4b598f-bc13-aa4b-8677-71477e1f5434@quicinc.com>
 <8b05760b-db99-4b43-8444-d655b18d3699@kernel.org>
 <db232678-fa85-d75f-de72-d2b5e1ec611f@quicinc.com>
 <2a5hvicenftfiktviiofvknanyz756cbryu35gkfczdvbcdd5j@fktlzfieotgl>
 <c6e3b0c1-18fe-a9fa-0e72-d955809144e3@oss.qualcomm.com>
 <hmfvyajygmjoeaaashmddu4rg6ttzn7es4sjls5qvnemykkx2l@zuzixrzkmkgx>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <hmfvyajygmjoeaaashmddu4rg6ttzn7es4sjls5qvnemykkx2l@zuzixrzkmkgx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: iXp5E6jnT-BVRen_ZHUwp42HSL5-HkDP
X-Proofpoint-ORIG-GUID: iXp5E6jnT-BVRen_ZHUwp42HSL5-HkDP
X-Authority-Analysis: v=2.4 cv=VaD3PEp9 c=1 sm=1 tr=0 ts=67dbc281 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=fppTZj3WDclMhW0upbEA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-20_02,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503200044



On 3/19/2025 7:03 PM, Dmitry Baryshkov wrote:
> On Wed, Mar 19, 2025 at 06:24:57PM +0530, Vasanthakumar Thiagarajan wrote:
>>
>>
>> On 3/19/2025 5:21 PM, Dmitry Baryshkov wrote:
>>> On Wed, Mar 19, 2025 at 05:02:39PM +0530, Vasanthakumar Thiagarajan wrote:
>>>>
>>>>
>>>> On 3/19/2025 3:57 PM, Krzysztof Kozlowski wrote:
>>>>> On 19/03/2025 10:06, Vasanthakumar Thiagarajan wrote:
>>>>>>>>> ---
>>>>>>>>> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
>>>>>>>>> change-id: 20250303-topic-ath12k-fix-crash-49e9055c61a1
>>>>>>>>>
>>>>>>>>> Best regards,
>>>>>>>>
>>>>>>>> NAK since this will break QCN
>>>>>>>> There is a series under internal review to address MLO issues for WCN chipsets
>>>>>>>
>>>>>>> ???
>>>>>>>
>>>>>>> The original commit is wrong, this fixes the conversion, nothing else.
>>>>>>
>>>>>> Nope. Driver changes to enable MLO with WCN chipset are not there yet.
>>>>>> Setting the mlo capability flag without having required driver changes
>>>>>> for WCN chipset will likely result in firmware crash. So the recommendation
>>>>>> is to enable MLO (in WCN) only when all the necessary driver changes
>>>>>> (in development, public posting in near future) are in place.
>>>>> Really, these are your answers? There is regression and first reply is
>>>>> upstream should wait for whatever you do internally. Second answer is
>>>>> the same - public posting in near future?
>>>>>
>>>>
>>>> May be I was not clear in my response. I was not telling MLO bug fixes were
>>>> in the development. Actually the MLO feature itself is not enabled
>>>> yet with WCN chip sets. Any code changes enabling it without full feature
>>>> support would result in firmware crashes with the existing firmware binaries
>>>> available in upstream.
>>>
>>> Is there an undocumented change of the behaviour in the commit
>>> 46d16f7e1d14 ("wifi: ath12k: rename mlo_capable_flags to
>>> single_chip_mlo_supp")?
>>>
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>
>> -       if (resp.single_chip_mlo_support_valid) {
>> -               if (resp.single_chip_mlo_support)
>> -                       ab->mlo_capable_flags |= ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> -               else
>> -                       ab->mlo_capable_flags &= ~ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> -       }
>>
>> The above logic seems to keep the initialized intra MLO support even when
>> single_chip_mlo_support_valid is not set. The above code removal is correct as
>> MLO support can not be enabled in host when firmware does not advertise it.
> 
> Ack
> 
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
>>
> 
> You skipped an important chunk:
> 
> -	ab->mlo_capable_flags = ATH12K_INTRA_DEVICE_MLO_SUPPORT;
>> +       ab->single_chip_mlo_supp = false;
> 
> Is this an _undocumented_ change? I think it is. If the developer has
> described that the commit disables MLO, there would be no such
> questions.
> 
>> diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
>>
>> +       if (resp.single_chip_mlo_support_valid &&
>> +           resp.single_chip_mlo_support)
>> +               ab->single_chip_mlo_supp = true;
>>
>> The above code does it in right way. Overriding firmware MLO capability as done
>> in the submitted patch under review is obviously wrong. The firmware used to report
>> the issue seems to have an odd behavior: 1. it does not seem to advertise MLO
>> capability in single_chip_mlo_support bit and 2. expects configurations to enable
>> MLO from host. None of the WCN firmware available in upstream either advertises
>> MLO capability or expects configurations to enable MLO from host.
> 
> Additionally, from the commit message:
> 
>      For the WCN7850 family of chipsets, since the event is not supported,
>      assumption is made that single chip MLO is supported.
> 
> However the code doesn't contain that change. Instead single chip MLO is
> unconditionally disabled.
> 
> I guess, Neil's change should be reworked to be limited to WCN7850 only,
> however it must be done as it is what was expected from the commit
> message.
> 

There has been lots of rework gone in to ath12k driver towards enabling
MLO support for QCN chip set. As of now, MLO boot and runtime configurations
are restricted to  QCN chipset. WCN will not work with those MLO changes.
Re-enabling single_chip_mlo_supp equivalent (single_chip_mlo_supp got cleaned up in 
ath/linux-next) will create issues when MLO gets enabled for WCN. Driver
changes/hacks to support this non-upstream firmware specific behavior will
become a major challenge over a period as new features are getting added in driver/firmware.

Vasanth

