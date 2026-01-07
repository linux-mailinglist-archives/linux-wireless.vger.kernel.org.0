Return-Path: <linux-wireless+bounces-30428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B55ACFC9C7
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 09:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D101300CCDF
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817E23C503;
	Wed,  7 Jan 2026 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nNVvbTnl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sa/of7Jj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA11A277C9A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 08:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774675; cv=none; b=UMVdV+Y0i7npbSvgNWFhL6vKrc7+gfdsUHEC1V1B97laagH15sBD/g4se6eZQS64+wdmtz7Z8SBhQUxwyXEtQ6WwY9dTX0zgJxzGFvUBkP6uz4pbEt290KFVW19O5j4KRmZbdr3AdsX4Lu8KEMQ3zxglp5p7CP9N+AH40kgUssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774675; c=relaxed/simple;
	bh=k9br/cNILdAxhgBxrGlpSiF8gcjPWlUDFX87Xn+ZJBE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o6B1eAzXCQ/s9omEXC2+TTjKBdTSt42YDo6kJe4pBLPP6ASA/rpafb8PuSD08d5wMN/tuBYpqJoLPFAd8MqvHVDWUnAzsfublx/m/fCGNaYbmH8BPFN4HuKvZAJ4q8D+VB13e2u1HCXg9N5KAc6No2sAEWkSOsWr7zVASYGb3I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nNVvbTnl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Sa/of7Jj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6072kGp4731861
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 08:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hSeKCIC1dfBCPCn0Crml12FbVFDqZA5Xz8a3HxhOcqw=; b=nNVvbTnlDXwwqFtl
	GzddWxU06TGjSfOZ29h84yveaP7jyoeEAYKRNs8B1jvrkZddA8TBM0axEo1gG/o4
	+qhObesZfUdstvhRlIpTz9LNJv7ihsKpbiE3qvHRb5skEpS/YeBh6aXd38F5E7aj
	p+6NX8k/2GckWh6l78ymCL/9dKEC+XwgcAv08RRA/ZUDXX5m/+svQaG6sNHWL8M+
	EPDhrEmIFbylD6tUyEdJ0kgq/6wOekQ8ryNIG9zja56uCsGfSytJUnZ5fZFzysn+
	rOMsxs/UkWl0C3xFzcu3CfDT0nAdaZdMrI8kZcDPyQecc4PH91syM+llm8CJrPbq
	TfvD7g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh66mjjfr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 08:31:12 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a9fb6fcc78so1444469b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 00:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767774671; x=1768379471; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hSeKCIC1dfBCPCn0Crml12FbVFDqZA5Xz8a3HxhOcqw=;
        b=Sa/of7JjReHZLAfLrqgOV7f5MFxC91sBmZBHsPhIrYwxLC57zZqppDd7UbpCiKSUI4
         xqwQVB86ye91ywjlT7JZHWwEoBDHan8HdUzna4gowK8t0vwF+xmN7QCC2nWvSD9AHDWv
         AmaLEPi3U00PgU3lrdxtYyLwwVRmkpjptSaGbf9iCf27zepu+ltn5XMraMmTI7mo7T9a
         GGIrtSlciQwNXxWDwlPg1CMTkmTqQWJp2YGhQBMsnfESkteWO9qaHixhF+Ng2iXTmKD1
         XWAa4M8Ju8v58kBiXc1K33wc5OHuSPKJz8hjlNQ6oTuC8sReY02ZUzr0r2IM+YcFMYJe
         Ooww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767774671; x=1768379471;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSeKCIC1dfBCPCn0Crml12FbVFDqZA5Xz8a3HxhOcqw=;
        b=OWYBVRo+XGUfr4K06zZ7o61WuEqWJCJ+fhptcTD7IaEfgdsqRu2BhTTKhsBuim9JO7
         bQd4bZ2PiW/XMQfzvxlJ+7puugnaRFO22/5E7CwNI5Awo36F0AZnMvVaj9cCeBY3gGtP
         /mxnKmLHKXb+0Zxfj6Noty24uMDYhGJroJFi8OHBCmbZYZ0L6qElygeKZSZ7Srcxu/py
         Ld4NAdISZM79Xlu6fLHYrKq4GZTUzuGR7/xaslYMbo1Kj183t/FxpFG+GGU+NPkkUQuu
         WZrCixZIUGN389Gskx1242B+VkQGjY4VZ+IiniNsXlYD9SVKVe3SqexBO3l4Y01ZqqTJ
         TS5g==
X-Gm-Message-State: AOJu0YyNih9tKUJ4XzJxAv0mbSWeCUqoP9e67XkTY32g1JfXymFqmEHQ
	45n9miTWMHpAUBFRlaLX21vzuMid3jGq+nNt712g9jJMF5V5X6FxPdFv5x3p4e/bBhhC8d6DxTq
	RKg61MyfSaIKnSgvRSEYvDZHho5PHUjpOvxVSEGQUXilTUzUrCMywfeM8N3StG9+BkHXLYn4moh
	vkmg==
X-Gm-Gg: AY/fxX7n2lezkFnxeoERLF3aY99lKLr1UaPjtuJna4Txr47bezxbdkHB9QUqsIDiuLa
	pfLvWFVoWmmxX2POZcmTTZ67B2WvPFNMlCmhQBoqqZZ/PvKE3j1g5MknBiR0KXHrsYCPJqmaK9k
	8gWzVowHu6Yg8KN6RD/7Zh9QiLh3Jt/zx8N5uJmTai3ze0Oa6Q/Un193/aBbV6/6gzQDAWKgzkS
	5tSrYNE0/2FqAg6JQ6AQq0KkroXvXSPv1j0/YIALFzuEdL53xPTRj0GsrdMy+OghYcEPgUaFxFH
	go7NAX6XaeebgNqEclAf2MCi1nHchliPda45SZwGwp495EZRzj3tpRX2Dd+NVKoDJuo8zPl6jqi
	bDV8RteXqwAQKs8WN9uWjCF08skPvyDi7egKt+qEg3ZOSH2RPXEDSdDh5fgHgKdPDLVho3qZ9C3
	LT+/0jgQ==
X-Received: by 2002:a05:6a00:1c91:b0:7e8:4587:e8bd with SMTP id d2e1a72fcca58-81b80bbbdd5mr1770838b3a.48.1767774671491;
        Wed, 07 Jan 2026 00:31:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFY4N6BSrBQ+OqiONbGfTJZuwiccaRXCZ0Fi+EMa5kM1WSMXJdqcfhDPusUIiphUOoc2hdkWg==
X-Received: by 2002:a05:6a00:1c91:b0:7e8:4587:e8bd with SMTP id d2e1a72fcca58-81b80bbbdd5mr1770814b3a.48.1767774670988;
        Wed, 07 Jan 2026 00:31:10 -0800 (PST)
Received: from [10.133.33.54] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819bafe9b98sm4207553b3a.20.2026.01.07.00.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 00:31:10 -0800 (PST)
Message-ID: <51010173-0d95-4a21-88a4-fca1ca23d3fe@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 16:31:08 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v1] wifi: ath11k: Fix failure to connect to a 6
 GHz AP
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
To: Qian Zhang <qian.zhang@oss.qualcomm.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260107060255.29530-1-qian.zhang@oss.qualcomm.com>
 <bac6e271-5bd8-42be-ac20-6873d88c16a3@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <bac6e271-5bd8-42be-ac20-6873d88c16a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Ws-1ij9c7qPka3zLc5LpIUxoVh3b_orz
X-Authority-Analysis: v=2.4 cv=PoSergM3 c=1 sm=1 tr=0 ts=695e19d0 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=CtV7lcuTZbQYzJlfzmsA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA2NyBTYWx0ZWRfX1nQgElxKa587
 Gnk4nJGss9USTQPOc53w5EHr/yust7LLR2Np3nv8cgpuI4OkylMlcW0BbSUs/E+I1U5T9Ug6aG+
 3fwB+AOZbC4NfuRx38ToVZqwxJ8UgcSQVqWg4BlQ/BBwlljkY8ELcvL+YP7eKLR6cD0LqgrzaGo
 Rt9gWHmr3YsE5y5swyt/O42yStLqntteTD6TAa0q4kVngE7APwREvjQ+sO2Ni/0Yaj1rtIBd68t
 4qu5prhh485OWUMVtLs4pHkxWMjr3gDHe27o5541jISqctnei1ZS75COn3SB9s8EaXvoyx0INAz
 dgRJ7LadjbFJaPpKPjDjLasgOlNNaaspBdlKn6YebTGUY8fBMBTpx6mM/E8J/rGJ/lra88j9sEJ
 Mguwmpdh4eenH8uGnd13udAvdahdQgxP0Xb6aNa0PWdzkfz6dxHqAgwSWLx0QjflRVfNTXXwRIv
 lRoLpj/P5BSS16/xW2g==
X-Proofpoint-ORIG-GUID: Ws-1ij9c7qPka3zLc5LpIUxoVh3b_orz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601070067



On 1/7/2026 4:23 PM, Baochen Qiang wrote:
> 
> 
> On 1/7/2026 2:02 PM, Qian Zhang wrote:
>> STA fails to connect to a 6 GHz AP with the following errors:
>>  ath11k_pci 0000:01:00.0: failed to handle chan list with power type 1
>>  wlp1s0: deauthenticating from c8:a3:e8:dd:41:e3 by local choice (Reason: 3=DEAUTH_LEAVING)
>>
>> ath11k_reg_handle_chan_list() treats the update as redundant and
>> returns -EINVAL. That causes the connection attempt to fail.
>>
>> Avoid unnecessary validation during association. Apply the regulatory
>> redundant check only when the power type is IEEE80211_REG_UNSET_AP,
>> which only occurs during core initialization.
>>
>> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
>>
>> Signed-off-by: Qian Zhang <qian.zhang@oss.qualcomm.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/reg.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
>> index d62a2014315a..8786ca3870fc 100644
>> --- a/drivers/net/wireless/ath/ath11k/reg.c
>> +++ b/drivers/net/wireless/ath/ath11k/reg.c
>> @@ -1,7 +1,7 @@
>>  // SPDX-License-Identifier: BSD-3-Clause-Clear
>>  /*
>>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights reserved.
>> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>   */
>>  #include <linux/rtnetlink.h>
>>  
>> @@ -926,8 +926,11 @@ int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
>>  	 */
>>  	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
>>  	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
>> -		    (char *)reg_info->alpha2, 2))
>> -		goto retfail;
>> +		    (char *)reg_info->alpha2, 2)) {
>> +		if (power_type == IEEE80211_REG_UNSET_AP)
>> +			ath11k_reg_reset_info(reg_info);
>> +		return 0;
>> +	}
>>  
>>  	/* Intersect new rules with default regd if a new country setting was
>>  	 * requested, i.e a default regd was already set during initialization
>>
>> base-commit: e33fc1c6d54ee1569a57255e11c2978ba9a42ffc
> 
> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

Withdraw my above tag as the code has some issues.

We should only return in IEEE80211_REG_UNSET_AP cases. For other types we should go on to
build a new regdomain.

> 


