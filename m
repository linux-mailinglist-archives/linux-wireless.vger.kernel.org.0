Return-Path: <linux-wireless+bounces-30415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7449CFBB32
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 03:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3CA430057F3
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 02:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E512737F9;
	Wed,  7 Jan 2026 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUeUsB9E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IEypDJdo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24F2701DC
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751964; cv=none; b=RhiwOq9xgTZm6C5mvxZQoNN5Z7Rb/VvDc1k9eQxQDsBoaTXfjWTNmCuUgXuV7Q0e2AnbWWQUSkmUtdm3FEo7Ssz9HV2q7WDtrMv/OqVxb9Mt+dYcWI6pTZnd4TIm9fXXa7fq5KHhWmCwc8/qKN4yDTXaY0SD6DA30aN+PA/aEh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751964; c=relaxed/simple;
	bh=+DS22IVXdBD5oEG7x7JSJyc0KfvO2kV8Q5S0qLLQmjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y43f50QeywO5B9jS9q2Jk7V/owCO1yjxTg6DSCTk533SlVO/uGRPvujIb5ZTSaCkCbslswvPQukEbNrDyOi5xITTmeg0drCw2Dy/blC9ngMuK37kAMmdnFYKROkbZfEvOGpcS4vPPtQN2Ki7gFlKlg0qzgaUQq8pAxey6/rLlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUeUsB9E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IEypDJdo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606LHAdR4048526
	for <linux-wireless@vger.kernel.org>; Wed, 7 Jan 2026 02:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rjQk9a6hGDgSnraXJs+oPiFhzINTIm1xQToVCBCY9XQ=; b=cUeUsB9E/e9lUrj0
	5JAPgWGZKqu+ukoQ8L8GViPE8EzRtvkUjq4eLCU/ETpc/xAAjoULrmBfdqrNx+kR
	uetss0Is2mo5NIJpSkNuwI6/AjoHTjyvbun6z4MvlJ8GtE+Il+1AXkUFk9kKBb8n
	VmZdK6xijcXuTrwE7tSD2kAYArGNLd3xrQ6+b85gOrcX4enhEWb8sDuuZElHuy1I
	DK+v2EOkHH6YDfp4kJMP0UVdIJo2lTstVjWXDhbmvpywcqHvSemyqig64rbW5Kpp
	MJp/m1RU0Mhn846K4qFOSohbwB3ZGlVZORZoumixtWtyQBV5NNxI38NKAMDRdaQx
	Pl9YxA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh25rt7mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 07 Jan 2026 02:12:41 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-11dd10b03c6so1386728c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 18:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767751961; x=1768356761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjQk9a6hGDgSnraXJs+oPiFhzINTIm1xQToVCBCY9XQ=;
        b=IEypDJdoCtANhkmuJAhf6e4Zb2IRZTZ/l7o2Qi8GEnfNsIQDPB0Hy/31t/moq62URw
         UjSUDtRUuR1Sq3pwGBneX18X1LSDIRZA1NdrK/K5pxSYUoSvu/l6oupTWx/VMm8viYdm
         sGMZEL0JfOZZfg5We44p7otAjxahhnDghf36NLOmgc+U05BxzDPY1W7VrK2i3pKkFdwf
         B6yfiMDjW4eK3FtLcND8/seNfq2A1/qehqUP3GrZ5G6rvGyuk76mYpoXwcRAgRtuISlm
         iUNXZFOutiTV6jOZxVQvajN8JG+SqgTOBTBqpykUsLWix/ETbpEjEs9ADwx4He0B0CtL
         tzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751961; x=1768356761;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rjQk9a6hGDgSnraXJs+oPiFhzINTIm1xQToVCBCY9XQ=;
        b=uq1ynaPZqeKIH4bYrQQ2Vnbwr5vPdeJW8HsvSRIE4y82U52sxxPLpvPZ15i3BtvU/f
         TJtCTybo2lNayA0PGWA42pv2fswO8tLkpzsmXVuv3filI61IlPZUCNcjBXdj3Sf3JhWw
         t/dwa+EdmV3v87glZlAxdX4kCJdjfvp5lBTa94FPNFQpQDNa2+FOGL3DLogOXrxgW8hQ
         L441Zp3gZndzstqXdVnjVNimFnaYt8nwb69Iyh9iR4J4rjVKETYsbpi9shqTsDY7ocUZ
         cr09X3elvBtMYVXLfZZ1F232R0ty4GD0SxJ8Xo6gbyo7vovfdEGmtV4KHY8JUV9q8lxx
         4MAQ==
X-Gm-Message-State: AOJu0YwXiFbAhKMWcZUtJqmH5JqZ6YNcCSWlGUaHBM6+Yz9v7gYWbrgh
	Ahl7Sx55NrFi93uEzTD/uUG25UOK6vVUJ1BpzDRybpQOu5JMude/D3UNLwruDJKvSoq6XmVubGX
	j5Sz6XljsueeP8OBOg4b/KLFgdlPM2adqLRCMiY1zhiQvH13TlS7idhVBJV/XUy6WVqS4mw==
X-Gm-Gg: AY/fxX4HpjrKOgLw6AL9uoW3I3TDnY5ti5Z4J1hsqgq3cSt+4h7iyeANfT9eBv7kFrh
	pV/4EEVlr32MbxPbZuYtWnzhn9mDdVDt1cERMOxEAKU80cOki9R3xfXvHpvk7EiPP9hZ9D53RaC
	2+ycNCDf74ehl/mvN4jcOvZPcA46VfsvBwN55djGRur+1D6hU6b01/V05wjjXwdyoFK4LMq0oIJ
	Wvwjts5QeTh8l52Dg/USxIfB52wJmQTv9TUkO28+mxyx6NBNWn4IHA/gOUIg4tB4cxoC7Ov3b/2
	Vg1wAztnoezpItaCTyYz7JQEKYkaW72FzJ04PFOsCjSE3ZQH8ZABpYXy5YClLBAATr4xbP8+RI9
	okLac/NVZJdAJT7/uZNdAcgM/Jrq8Ut2vyPDVE7jQ+arCy1FjoBOl3fotI9RVXd2cv8Fzrd7AvF
	HDP3c=
X-Received: by 2002:a05:7022:1e05:b0:11b:d561:bc16 with SMTP id a92af1059eb24-121f8b2df81mr899391c88.22.1767751960728;
        Tue, 06 Jan 2026 18:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUlBSNnoP2te7zLYClpylaHWKskrNYNVNy6WA0jogH9Tm1+NotbiFTbueoEOGhBlAA414+rg==
X-Received: by 2002:a05:7022:1e05:b0:11b:d561:bc16 with SMTP id a92af1059eb24-121f8b2df81mr899362c88.22.1767751960098;
        Tue, 06 Jan 2026 18:12:40 -0800 (PST)
Received: from [10.91.225.131] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24a65b9sm6646346c88.17.2026.01.06.18.12.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 18:12:39 -0800 (PST)
Message-ID: <0c8464d2-b047-459c-a85c-9c7098d6742a@oss.qualcomm.com>
Date: Wed, 7 Jan 2026 10:12:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v4 1/6] wifi: ath11k: Add initialization and
 deinitialization sequence for CFR module
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
        Yu Zhang <yu.zhang@oss.qualcomm.com>,
        Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
References: <20251223092728.1950017-1-qian.zhang@oss.qualcomm.com>
 <20251223092728.1950017-2-qian.zhang@oss.qualcomm.com>
 <19b7303bb18.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <9ba229f8-917a-4c58-ab63-fd34d2a66a9f@oss.qualcomm.com>
Content-Language: en-US
From: Qian Zhang <qian.zhang@oss.qualcomm.com>
In-Reply-To: <9ba229f8-917a-4c58-ab63-fd34d2a66a9f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wWK1hfGftxwdlfML93JzV58wP0uZW9zs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDAxNiBTYWx0ZWRfX2fDugUWBPWpD
 LywFXPjhMGTs66/zS8PGqBiB60XLdKGzFKtYJEdMgUlVnr0zM07fCpOtecwImh6ujRnGV+YoTVe
 j/EMvEkUFYx0tCPYejJVfXt1JAWEWzetJ+0JxTscfjf848Nl3MsRrZebmFxGtlYMHVJHSHEMXZJ
 T+ysieSFzYahfLY6kFLobrsjZgUdrZky4Vq8H7wXTHKMy75cAUrdRdyVNh4dttbzgOgHjUCI4jf
 HggTOB3wrA85nEHNbhqAaBz3BRrA3ci7lliuqnbNTFtur8BsDcSTZNhxsoc32vWMGRturWVg3sF
 OnTlNKbfqcNNNdAtJMrMSajs6J8qj8mJVWZIJkLL3mJJYdjjtBR0Y9dP4eRnZMr3y5H1WIky8vy
 LYXmSIJJ9slGAFmlQuN2ehn60K3Y5qcHur0lyPcn6PCfRdTLy7N1ChlkhrHXsHkng85YEOenemk
 409eYVymGEBtgY4yMBQ==
X-Proofpoint-ORIG-GUID: wWK1hfGftxwdlfML93JzV58wP0uZW9zs
X-Authority-Analysis: v=2.4 cv=G48R0tk5 c=1 sm=1 tr=0 ts=695dc119 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Xy3KGXYPQ7ZwAtk6cowA:9 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601070016



On 1/7/2026 8:43 AM, Jeff Johnson wrote:
> On 12/30/2025 10:06 PM, Arend van Spriel wrote:
>> Op 23 december 2025 10:27:46 schreef Qian Zhang <qian.zhang@oss.qualcomm.com>:
>>
>>> Channel Frequency Response (CFR) module will be initialized only when
>>> the following criteria passes:
>>> * Enabled CFR support for the hardware through the hardware param
>>>    'cfr_support'
>>> * WMI service enabled for the CFR support
>>>    'WMI_TLV_SERVICE_CFR_CAPTURE_SUPPORT'
>>
>> [...]
>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/core.c
>>> b/drivers/net/wireless/ath/ath11k/core.c
>>> index 812686173ac8..6a6bf6316ac9 100644
>>> --- a/drivers/net/wireless/ath/ath11k/core.c
>>> +++ b/drivers/net/wireless/ath/ath11k/core.c
>>> @@ -1,7 +1,6 @@
>>> // SPDX-License-Identifier: BSD-3-Clause-Clear
>>> /*
>>>   * Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
>>> - * Copyright (c) 2021-2025 Qualcomm Innovation Center, Inc. All rights
>>> reserved.
>>
>> Hi Qiang Zhang,
>>
>> Some explanation on this would have been nice. Doing this in a separate
>> patch would be even better.
> 
> Are you just referring to the copyright change?
> 
> The guidance from Qualcomm legal changed in 2025, and that was already
> discussed in a few places. The best reference is here:
> 
> https://lore.kernel.org/linux-wireless/bce51392-d5f1-40a2-ae22-58df01b993e7@oss.qualcomm.com/
> 
> Note the guidance is to change copyright when the file changes, so changing
> copyright alone would not be an appropriate change.
> 
> /jeff
I will fix this.

Thanks,
Qian

