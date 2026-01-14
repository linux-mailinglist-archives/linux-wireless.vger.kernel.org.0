Return-Path: <linux-wireless+bounces-30828-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 19227D2086E
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 18:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E830300819A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 17:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EE72FFDFC;
	Wed, 14 Jan 2026 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMYn0omk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VpvhsLnk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2A92FF643
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411465; cv=none; b=LDxOD86bSnUi5rxzEG/QqQkyKhvJ5t4rmlszBsuhu0q/7gYqWc3fxlVpGjS9NPEMjc8p4nZVoiSp8lD2N26ZPQvmz7Jkgxy5QLhopRmEAu+6QZRYQyOaYda1g8eWegerx0Gxv3aqr2mUn6k/VtO3gZk8SxJoDvnAbx5gQHtRKKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411465; c=relaxed/simple;
	bh=qQcflF4w079QNMpZfzmyomZEqM2JpNH5WkaVJP7WAyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kotkwXrJP07FI48zBVMAlLpMffbHiKWf5k7wAQwlbhlidbJHCDluThebfgL9DYKglEeMRUjE+Sm0dJ1fPVdkVGEmFJvdy7k5OzoPYSEvu8Nv2z0X1ONsKICG8Gc86IUc8l9ilA08SeZ5djsEzZ9kGi1le4m3DzO1hpfZxU1Azi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BMYn0omk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VpvhsLnk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EE1JB43850524
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9+mDVu2OGbCT81X3aqnLFlTpu1u9SyfEN+WtZVk3UzM=; b=BMYn0omkV3KnPVwr
	aYc7QEPJX7FQ1zDsOUQwM7ueppV982NjHgRbTbww2X1wElcH+dK+devi1eBD4o7R
	31I/Au5ABO8cyTs1ta53A+UbUK4xHZLek6lNkI6T5dCijSRIIpBprL1DxQefB4xL
	PFgq+WLXG1vRbkb5Iwvc4D/U5n+YiT8b69bg2G+ader+BadeegqhOHILJcrBLoVT
	X8uhIX29Oo26kV4oPjNvJnhq9kq7ttG6R8vnBnBPtAG2978gS4QSQXhG15twuFiq
	KOswoKe2n0pUNBJuN/8hyoWz5ZB7SPIOr2xKvFLWf5MGPlQWjlGyDB2UvGasU725
	+sS+rA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp8t2skcr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 17:24:22 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12338749ea9so6236c88.0
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768411462; x=1769016262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9+mDVu2OGbCT81X3aqnLFlTpu1u9SyfEN+WtZVk3UzM=;
        b=VpvhsLnk7JpaVQeOiV9ssHMlE7YKtaPY5rF/g5Mv6jDyLDemz8rtTb3prZtnGCx/p8
         YFW0V3VRhX3xxPcT9mCYrCdQTlsE/CF/BIvHmQaYSP96CgrFrXrispnvsDU/XpqvC+Sw
         HzxkL9M2ZZaheoM2HWlqCFb1uoVDcgZwOWA0+IKUaav4z8oX/vwtMtHHdSgXvtGnX+23
         aN0cW3YH9eIShlLer7Vt/mfL2GXwzQODrbDhWVhKIRdQabE2zQpOg+ZBX1lU7OQvxEEb
         1cs2hzgRprxwiOVAlitxjPyjz8eaKhiQQH5jkeA2du87U0u6D6JX0aP3Co506uYsCRna
         TQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768411462; x=1769016262;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+mDVu2OGbCT81X3aqnLFlTpu1u9SyfEN+WtZVk3UzM=;
        b=GLX+cntwixfkLe2F+qX1gsjc4XDPK0zgKfFup6j86xGAkgW6DMU5B/8lsm4t+LJoI3
         OCaXGWVTpPbtRomcMyooB/cGII2rv1jU0S9hwqREdmh5uKoKzG6kL7UTnt49FZlMAGZy
         WuAmpbvRIlFzIlIMc05hPzmi+Ctq08ZtzzeiUk6BaO+izKO8n08WsMJ43tF3+hvuBHJT
         ATx7mKMQtz9YD0O7QjjFV4/Y0EtMLe5bl6r0npnWwoMJXZNEx+DGSIVV/nYnjy6LQ+u4
         wWy8+Sqh1UMqHtc80eq9pwswu6QkfDMReSWgdUBdbr8qVi13rpBM5c3nCcCFp8zRQPuu
         D2KA==
X-Forwarded-Encrypted: i=1; AJvYcCUAHyDgsJzoO1zKBb2KGk3baBTFP5Ywf7Rf1NM8Hg5gBsNVnM2VpYzdPUCtvPpYNoyji2SkwAyMeelnTByIig==@vger.kernel.org
X-Gm-Message-State: AOJu0YxMY7fPoEXOzB9FDBgX8RRfPEfIPu4VH6CVXokBB/yhxnV2/gAW
	45UV9hfO36Z9aSTptnapAfulRezN3T8Bi835akEu8kkS4cWb5BZi6UJZylVXf5jLwA3EcPYMtry
	R2VE1IFYGc77erjsVDggg1Tp0Ou7ZKaNgCFOsK/zB7wLGDeWOq7Tpo2YFZS5UNwIq9L5/QQ==
X-Gm-Gg: AY/fxX6KdgIcfDXmreOGDy2yFOPzwp9J8DyP2TBY/CFt9kQKmcgyQhjGhuSeB8/SU5K
	v6ndoxW8eWPcEoQ5C4lSGP/VSRPaHGX9qD0Hop9voPi9kqEtRIHsXeZP0/8Jg3T/NrP3lMDwSJ/
	+EPvf9GRrPodnqhUHHM9qOBdhJ60A10MuhCTaqUMyP4cYXlKqKy2TEumjQvRHo9gpPQQZ05dze6
	2K5v1oFBuB+qvUxrCCUwswTg6X0TO50PBFESt0upIoNgKaoQ+UXaiRuqBVwnWMXPuFS4Ixvfh8b
	lZCVpwNM8QxUBkJeYVvcVZ9QMOPSSS9poOPjv88qtnqE2CXsmCKkYRTFQKS4PIR66ZXHIXByyC/
	3p+Ek5JHpsuF7qSZ9b2hvqMJD95zYm1RU2EezZMj39X1nc60RQDPVq4lsI8/dq4lCQlVfTA==
X-Received: by 2002:a05:7022:fc0b:b0:11b:9b9f:4283 with SMTP id a92af1059eb24-12336a6d9c6mr2588086c88.24.1768411461903;
        Wed, 14 Jan 2026 09:24:21 -0800 (PST)
X-Received: by 2002:a05:7022:fc0b:b0:11b:9b9f:4283 with SMTP id a92af1059eb24-12336a6d9c6mr2588056c88.24.1768411461381;
        Wed, 14 Jan 2026 09:24:21 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121f24985d1sm31170055c88.16.2026.01.14.09.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jan 2026 09:24:21 -0800 (PST)
Message-ID: <c8456b52-f14c-4bcf-9385-580e9607219d@oss.qualcomm.com>
Date: Wed, 14 Jan 2026 09:24:19 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org
Cc: baochen.qiang@oss.qualcomm.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
 <56c6471b-c878-4afd-8e8e-d56266ca9c64@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <56c6471b-c878-4afd-8e8e-d56266ca9c64@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=6967d146 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=4N76r0Ozp7Clb_Fv4mYA:9 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE0NiBTYWx0ZWRfXzm9bhYM/C9ee
 b6r5rCpCXnO1lnC2k7BKEcPGjte3rfjUX8eHYmy6SHtLM2raq4Pc+1rg3mbVyKC4jzLUHPeLaB4
 P4WdJXB75+NTpOvdEnJT3lGa3eOQT6VKhnaGOxzBS+bEufXRZNPldyWkZPZwkZ1FPO7SfKyMY+o
 DOFOIzklH15IgWmSsFvFd2mrOYCNxAGHxug060h88moNuc+TViVLwKcFp7Cv20B1Bf1vhhO3D7N
 fxDHa/LdfXMOrRMpcTDqv0q0WFu0g04xzvz0QMM2T0a8DkVHVQOMU7kAvTtM2oeMYJe+D6e3eCa
 Zal0U2j3treBHfcZISxUOiz22LT1aWsd76YrKzhylUE0I4FxQOmIoHJ1UK5s/Gqmo/H3dxfE9Ix
 BFf2b36ixarhJOpvkiAEtUeJtCLxt5L79TVOxCyXBvRxT2QDboJGZGKHc0qpz9AFLx3nFafg0m1
 kGKO2eqpLusTV316H0w==
X-Proofpoint-GUID: wgcZGEIf7cNYiSfRIMSbeaP4tjwUjM1L
X-Proofpoint-ORIG-GUID: wgcZGEIf7cNYiSfRIMSbeaP4tjwUjM1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601140146

On 1/12/2026 11:00 PM, Vasanthakumar Thiagarajan wrote:
> 
> 
> On 12/28/2025 8:44 PM, Alexandru Gagniuc wrote:
>> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
>> is initialized in, core.c, a different file than the array. This
>> spaghetti-like relation is fragile and not obvious. Accidentally
>> setting ".max_tx_ring" too high leads to a hard to track out-of-
>> bounds access and memory corruption.
>>
>> There is a small ambiguity on the meaning of "max_tx_ring":
>>   - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
>>   - The highest number to use for array indexing (there are 3 rings)
>>
>> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
>> ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
>> instead of #defines to initialize the length field.
>>
>> The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
>> so use a constant to express the correct value. Add a static_assert()
>> to fail compilation if the constant is accidentally set too high.
> 
> Text related to static_assert to be removed accordingly.

I removed the last sentence in 'pending', please check:

https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=26bb149b5e011b0f73f7b74421589cbd38e3304b

> 
>>
>> The intent is to make the code easier to understand rather than fix
>> an existing bug.
>>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> With the above minor comment addressed.
> 
> Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>


