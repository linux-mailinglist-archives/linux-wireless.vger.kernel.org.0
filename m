Return-Path: <linux-wireless+bounces-29788-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C77A6CC149F
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 08:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86CD1305D439
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FE633971D;
	Tue, 16 Dec 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oy8opNSg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aptR3O/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B333A038
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765869278; cv=none; b=LSk0b1FB7dYvxPgOvkfXPf5hhNRt3dC+jzyJ3T5eN6/Nrbp3p9sBRCCRyJyLKn88uem5RZroiC9ajRSSfPEX9TeunVXoisFxAFwDNYFbcJ8SVW5Ofhb8SnsTkWZ0gKxalJuG2aV1mcr43ST5+TMD2oe2HBeuWCPPQVREqYK/mGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765869278; c=relaxed/simple;
	bh=tSkq52f6vSmN0vQbvDevZQ5zZcG8g+1vnbR5dSdgBfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tt/5q++myXKjx3Wvw5xjotW7HnBX+C4ME54tNVzC0z3nih+W2UG1eAN7KeXYWxwi3+V46sjyAsX5Ho99fK4cqOplXRltJl99/AxEh9VDsQJWh5lBR8eFDslZYROZk6eWFGWq6q7Ie9xSgXLshS95urrfZx6R8UeqxZRCrbe/f6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oy8opNSg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aptR3O/Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BG4rt4m2278295
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ucHmwTUo2AKxUUsRWDspxJiGVK41TjRwQDHmb0VHij4=; b=oy8opNSgg1XSrBEq
	2d4Os2WCSq64lfevoTlwE0P32y/QtrfQVjgoPOTsVRJwD6qwuUu+i2iFaQa3fwXF
	RzWI49+hdA4KR/mh+CzxDkbgqeQDSTz0vRjrMVro/9VJWZFVbYZ1da2HX9dMwNtf
	I0B+7fyslroPOrwSOsvSg5VJzJ5ff3C/9SEtCmlU3r2mZOwz29Y6S2lj3kxQIS3L
	uNrG06d0kAfvNuWwVNbrEn6wRzraih28ndZmnPRj56O5IOV3NQ1iSbNp9juljpTs
	Koa6sy9IDdcc+ZhzZnPBJZcHM2O7oSf0m/fBa0Iloo7Ew0JbZc/nQ45QcakZSBr9
	dFhaXQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b2perakpb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:14:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-bc0de474d4eso9032179a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 23:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765869272; x=1766474072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucHmwTUo2AKxUUsRWDspxJiGVK41TjRwQDHmb0VHij4=;
        b=aptR3O/ZyjkiLfUbZeSAnXxFOKy1xiGTlC2QAoAtTHHIriUfitaObiyTQkNteEsiT5
         Zb8In/Df0WPJyj7rbhOs/iI3rIeHPhgR6bYxArJ2FyaPwR36CTtUCu3UumdqVo/qtxjQ
         6LbAGMeIjixwlVzpxuVbOWZXCFxSJ8bwsW2hLUDB40BLYBaMibb0j8Us1yLHTCHoP8d2
         LxmI2PCWbRxqLquJg82bPJaS6PjmIeWVSvbnpZZPUxOOp5SHVEs8IqSBQ5pwJW+026HY
         pyXWwzxFBBInqtUOvqK6+T/RhY3M3NNt/LJMo6dr7PgZrx1eaqRJHqJPm8+USfOIRrsP
         xZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765869272; x=1766474072;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ucHmwTUo2AKxUUsRWDspxJiGVK41TjRwQDHmb0VHij4=;
        b=QD94rQtpnaxpwZ50zenCu2y/AmFx9GUb+4QMtI0vxUVGJ/Uk7DxUCIKPmHjnkiykO/
         urqLRaXY8caSrR5iJ5RBhvjz0glbk1lgfvsOVmTQEbIdHkKIOp4/MODqF0SSn6CB9MH3
         Lc0IPwVd6p2Uqklpwtk/b3hEiLtzACooZ6j0v/mN8VTMb9bE/OR331t9tw9v9uXh4pSV
         enB+0Bi1RYFsWIOiLx4pmcF1ghT1NpuYPyF8bq8JvxGtFi9I/d4RBHe6vRw+K0cbcM75
         06RtWiXokWqU9aYSzIUAp9JArMvjGW93iUQGQx2VHZXnva84fur8DX3eok7nBhwZYiph
         DM3g==
X-Gm-Message-State: AOJu0Yynb0tXXKcbWypcSEWClCo0W0MICJaXJ5SU/FqSo2zKMAuObpzX
	yclh51VbSRqSMS9yJdqhT9wr/y9Ybtqekdo+lRSK8R+8Pz3PoEdPt/BXX9SRCbf4oIYMD3EBe/x
	UhiApIjXoPhvp5fj/KDJKtfbnThYz4/s+Zh/51Gzh5v2p3ABvIyDh33qbSKxDoCEsMRWEnw==
X-Gm-Gg: AY/fxX5g6Mo2gjUp1e0SsZTxmD1kHAg8JPwf5h8xlJVi28Vzpwu8omg3wPOID2sZoXy
	1B+UgABol+dhii4GLUh9bOdOp3ITodFX/XeF6+2/NqvJqnZrwpZGzicoyAEhU9geiHOlTa+WZ38
	ss7Jz3El66q8lWlJCDIsY7iffPvflxxkOdHwlY1yG4sZzx2NP003laAmbZF+nhBJ63ci7c+so9Q
	xVniJwfdUT/50v6rWZ1Qc+PO3Q8VosJuMCbYDZ8BMYeVr9zhEakGlU9Iz/TXgqvT7lUVdTfMPS5
	+UcehtBD00jBYZX8tYAXB6pwE27Ooi5VyRTOBh3tvD5CivwKlxiJbre8BXWjp9mCvWxRXmD/Goi
	uXCUnTL88osfgIgfyKWokynfzSiaE79ZIAfIx1nT67ntKI1YlwyppE47SL0BzD6BLgA4soA==
X-Received: by 2002:a05:7022:f90c:b0:11d:c049:2fa3 with SMTP id a92af1059eb24-11f34c26000mr6969974c88.30.1765869272048;
        Mon, 15 Dec 2025 23:14:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNGLiJC8lfb32DCCkHRrEhaxhvCil8ShlxBoJEAit0IhbhwcVVa5w7a7T9W5qPWJLhh2ODEg==
X-Received: by 2002:a05:7022:f90c:b0:11d:c049:2fa3 with SMTP id a92af1059eb24-11f34c26000mr6969953c88.30.1765869271453;
        Mon, 15 Dec 2025 23:14:31 -0800 (PST)
Received: from [10.110.127.186] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f43ced319sm18571475c88.9.2025.12.15.23.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 23:14:31 -0800 (PST)
Message-ID: <83c5bb41-ac0f-4f01-be38-ba536dc8b977@oss.qualcomm.com>
Date: Tue, 16 Dec 2025 15:14:27 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, ath11k@lists.infradead.org,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251216043555.628296-1-mr.nuke.me@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251216043555.628296-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pbDUGUAS_HD1Iz02GGMU2odio3GJAjRP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDA1OCBTYWx0ZWRfX+MzONCoz5aCe
 3dt0Ud8KN+lGRJ1y0BlBoP19KZ0pqHYAiqjSyJ8qEIbcF57pogXUSv2XdZ2sKvg/H/JWEKG64iu
 JexcGGBrqx0PysY8GkLpe1NFYW2hsZgOr6KcMTev45LPWMPTcJCmuWvvrMV/EFrpbxtypFiFeP6
 js0Xppw4HPoaeM+Kpzln1FbA8mpT1nUo//K0e+FIsiV9iOFXa+kRYFDxCY9XrsdjNj6MMY1/dJx
 mKE+WFtTT0mKRWM6B/2pTr5l6mf7JOimMhDfC6HQMpdHZ50RcG76jx5LCvGUeoezL//OQMeFpvK
 TOqzEUyLe8qECfWHfyx+NSSpqXKLgOAJBY++N/Be5n7Js5DV/1dOaf2u/PUXE+m0gjusaEEB54J
 UnvJRhAqmSNNfcZo/6ig3VkN0gX5oQ==
X-Proofpoint-GUID: pbDUGUAS_HD1Iz02GGMU2odio3GJAjRP
X-Authority-Analysis: v=2.4 cv=PYHyRyhd c=1 sm=1 tr=0 ts=694106d9 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=6517jYOTR0an-2ppcwgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_01,2025-12-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512160058



On 12/16/2025 12:35 PM, Alexandru Gagniuc wrote:
> ".max_tx_ring" is an upper bounds to indexing ".tcl2wbm_rbm_map". It
> is initialized in, core.c, a different file than the array. This
> spaghetti-like relation is fragile and not obvious. Accidentally
> setting ".max_tx_ring" too high leads to a hard to track out-of-
> bounds access and memory corruption.
> 
> There is a small ambiguity on the meaning of "max_tx_ring":
>  - The highest ring, max=3 implies there are 4 rings (0, 1, 2, 3)
>  - The highest number to use for array indexing (there are 3 rings)
> 
> Clarify this dependency by moving ".max_tx_ring" adjacent to the array
> ".tcl2wbm_rbm_map", and name it "num_tx_rings". Use ARRAY_SIZE()
> instead of #defines to initialize the length field.
> 
> The ath11k_hw_hal_params_qca6390 uses fewer num_tx_rings than its map,
> so use a constant to express the correct value. Add a static_assert()
> to fail compilation if the constant is accidentally set too high.
> 
> The intent is to make the code easier to understand rather than fix
> an existing bug.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> I am trying to make ath11k work on IPQ9574. My device uses a IPQ9570
> with a QCN5024 as the 2.4 GHz wifi.
> 
> I spent a few days tracking a memory corruption bug caused by
> erroneously setting ".max_tx_ring" too high. I think I would not have
> made this mistake if the initializations of .max_tx_ring and
> .tcl2wbm_rbm_map were right next to each other.
> 
> Changes since v1:
>  - use "num_tx_rings" name instead of "map_len"
>  - make sure debugfs.c is correctly updated
>  - add a static_assert for ath11k_hw_hal_params_qca6390 special case
> 
>  drivers/net/wireless/ath/ath11k/core.c    | 12 +-----------
>  drivers/net/wireless/ath/ath11k/debugfs.c |  2 +-
>  drivers/net/wireless/ath/ath11k/dp.c      | 12 ++++++------
>  drivers/net/wireless/ath/ath11k/dp_tx.c   |  9 +++++----
>  drivers/net/wireless/ath/ath11k/hw.c      | 19 +++++++++++++++++++
>  drivers/net/wireless/ath/ath11k/hw.h      |  3 ++-
>  drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
>  7 files changed, 35 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index 812686173ac8a..07199ceecbeb4 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -100,7 +100,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
>  		.credit_flow = false,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX,
>  		.hal_params = &ath11k_hw_hal_params_ipq8074,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = true,
> @@ -184,7 +183,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
>  		.credit_flow = false,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX,
>  		.hal_params = &ath11k_hw_hal_params_ipq8074,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = true,
> @@ -271,7 +269,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
>  		.credit_flow = true,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
>  		.hal_params = &ath11k_hw_hal_params_qca6390,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = false,
> @@ -358,7 +355,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = false,
>  		.fix_l1ss = true,
>  		.credit_flow = false,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX,
>  		.hal_params = &ath11k_hw_hal_params_ipq8074,
>  		.supports_dynamic_smps_6ghz = true,
>  		.alloc_cacheable_memory = true,
> @@ -445,7 +441,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = true,
>  		.fix_l1ss = false,
>  		.credit_flow = true,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
>  		.hal_params = &ath11k_hw_hal_params_qca6390,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = false,
> @@ -533,7 +528,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = true,
>  		.fix_l1ss = false,
>  		.credit_flow = true,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
>  		.hal_params = &ath11k_hw_hal_params_qca6390,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = false,
> @@ -619,7 +613,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = true,
>  		.fix_l1ss = false,
>  		.credit_flow = true,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX,
>  		.hal_params = &ath11k_hw_hal_params_wcn6750,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = false,
> @@ -662,7 +655,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.qmi_service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074,
>  		.ring_mask = &ath11k_hw_ring_mask_ipq8074,
>  		.credit_flow = false,
> -		.max_tx_ring = 1,
>  		.spectral = {
>  			.fft_sz = 2,
>  			.fft_pad_sz = 0,
> @@ -698,7 +690,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = false,
>  		.idle_ps = false,
>  		.supports_suspend = false,
> -		.hal_params = &ath11k_hw_hal_params_ipq8074,
> +		.hal_params = &ath11k_hw_hal_params_ipq5018,
>  		.single_pdev_only = false,
>  		.coldboot_cal_mm = true,
>  		.coldboot_cal_ftm = true,
> @@ -789,7 +781,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = true,
>  		.fix_l1ss = false,
>  		.credit_flow = true,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
>  		.hal_params = &ath11k_hw_hal_params_qca6390,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = false,
> @@ -876,7 +867,6 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_regdb = true,
>  		.fix_l1ss = false,
>  		.credit_flow = true,
> -		.max_tx_ring = DP_TCL_NUM_RING_MAX_QCA6390,
>  		.hal_params = &ath11k_hw_hal_params_qca6390,
>  		.supports_dynamic_smps_6ghz = false,
>  		.alloc_cacheable_memory = false,
> diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
> index 977f945b6e669..50f344803e8fd 100644
> --- a/drivers/net/wireless/ath/ath11k/debugfs.c
> +++ b/drivers/net/wireless/ath/ath11k/debugfs.c
> @@ -707,7 +707,7 @@ static ssize_t ath11k_debugfs_dump_soc_dp_stats(struct file *file,
>  	len += scnprintf(buf + len, size - len, "\nSOC TX STATS:\n");
>  	len += scnprintf(buf + len, size - len, "\nTCL Ring Full Failures:\n");
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++)
>  		len += scnprintf(buf + len, size - len, "ring%d: %u\n",
>  				 i, soc_stats->tx_err.desc_na[i]);
>  
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index 56b1a657e0b0f..c940de285276d 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -344,7 +344,7 @@ void ath11k_dp_stop_shadow_timers(struct ath11k_base *ab)
>  	if (!ab->hw_params.supports_shadow_regs)
>  		return;
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++)
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++)
>  		ath11k_dp_shadow_stop_timer(ab, &ab->dp.tx_ring_timer[i]);
>  
>  	ath11k_dp_shadow_stop_timer(ab, &ab->dp.reo_cmd_timer);
> @@ -359,7 +359,7 @@ static void ath11k_dp_srng_common_cleanup(struct ath11k_base *ab)
>  	ath11k_dp_srng_cleanup(ab, &dp->wbm_desc_rel_ring);
>  	ath11k_dp_srng_cleanup(ab, &dp->tcl_cmd_ring);
>  	ath11k_dp_srng_cleanup(ab, &dp->tcl_status_ring);
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
>  		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_data_ring);
>  		ath11k_dp_srng_cleanup(ab, &dp->tx_ring[i].tcl_comp_ring);
>  	}
> @@ -400,7 +400,7 @@ static int ath11k_dp_srng_common_setup(struct ath11k_base *ab)
>  		goto err;
>  	}
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
>  		tcl_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].tcl_ring_num;
>  		wbm_num = ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num;
>  
> @@ -782,7 +782,7 @@ int ath11k_dp_service_srng(struct ath11k_base *ab,
>  	int i, j;
>  	int tot_work_done = 0;
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
>  		if (BIT(ab->hw_params.hal_params->tcl2wbm_rbm_map[i].wbm_ring_num) &
>  		    ab->hw_params.ring_mask->tx[grp_id])
>  			ath11k_dp_tx_completion_handler(ab, i);
> @@ -1035,7 +1035,7 @@ void ath11k_dp_free(struct ath11k_base *ab)
>  
>  	ath11k_dp_reo_cmd_list_cleanup(ab);
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
>  		spin_lock_bh(&dp->tx_ring[i].tx_idr_lock);
>  		idr_for_each(&dp->tx_ring[i].txbuf_idr,
>  			     ath11k_dp_tx_pending_cleanup, ab);
> @@ -1086,7 +1086,7 @@ int ath11k_dp_alloc(struct ath11k_base *ab)
>  
>  	size = sizeof(struct hal_wbm_release_ring) * DP_TX_COMP_RING_SIZE;
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
>  		idr_init(&dp->tx_ring[i].txbuf_idr);
>  		spin_lock_init(&dp->tx_ring[i].tx_idr_lock);
>  		dp->tx_ring[i].tcl_data_ring_id = i;
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 562aba66582f3..86e1e6c27b36c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -91,6 +91,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>  	struct hal_srng *tcl_ring;
>  	struct ieee80211_hdr *hdr = (void *)skb->data;
>  	struct dp_tx_ring *tx_ring;
> +	size_t num_tx_rings = ab->hw_params.hal_params->num_tx_rings;
>  	void *hal_tcl_desc;
>  	u8 pool_id;
>  	u8 hal_ring_id;
> @@ -113,7 +114,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>  tcl_ring_sel:
>  	tcl_ring_retry = false;
>  
> -	ti.ring_id = ring_selector % ab->hw_params.max_tx_ring;
> +	ti.ring_id = ring_selector % num_tx_rings;
>  	ti.rbm_id = ab->hw_params.hal_params->tcl2wbm_rbm_map[ti.ring_id].rbm_id;
>  
>  	ring_map |= BIT(ti.ring_id);
> @@ -126,7 +127,7 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>  	spin_unlock_bh(&tx_ring->tx_idr_lock);
>  
>  	if (unlikely(ret < 0)) {
> -		if (ring_map == (BIT(ab->hw_params.max_tx_ring) - 1) ||
> +		if (ring_map == (BIT(num_tx_rings) - 1) ||
>  		    !ab->hw_params.tcl_ring_retry) {
>  			atomic_inc(&ab->soc_stats.tx_err.misc_fail);
>  			return -ENOSPC;
> @@ -244,8 +245,8 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
>  		 * checking this ring earlier for each pkt tx.
>  		 * Restart ring selection if some rings are not checked yet.
>  		 */
> -		if (unlikely(ring_map != (BIT(ab->hw_params.max_tx_ring)) - 1) &&
> -		    ab->hw_params.tcl_ring_retry && ab->hw_params.max_tx_ring > 1) {
> +		if (unlikely(ring_map != (BIT(num_tx_rings)) - 1) &&
> +		    ab->hw_params.tcl_ring_retry && num_tx_rings > 1) {
>  			tcl_ring_retry = true;
>  			ring_selector++;
>  		}
> diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
> index caa6dc12a790b..bbaacdf76af0a 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.c
> +++ b/drivers/net/wireless/ath/ath11k/hw.c
> @@ -2707,6 +2707,14 @@ const struct ath11k_hw_regs wcn6750_regs = {
>  	.hal_reo1_misc_ctl = 0x000005d8,
>  };
>  
> +static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_ipq5018[] = {
> +	{
> +		.tcl_ring_num = 0,
> +		.wbm_ring_num = 0,
> +		.rbm_id = HAL_RX_BUF_RBM_SW0_BM,
> +	},
> +};
> +
>  static const struct ath11k_hw_tcl2wbm_rbm_map ath11k_hw_tcl2wbm_rbm_map_ipq8074[] = {
>  	{
>  		.tcl_ring_num = 0,
> @@ -2822,19 +2830,30 @@ const struct ath11k_hw_regs ipq5018_regs = {
>  	.hal_wbm1_release_ring_base_lsb = 0x0000097c,
>  };
>  
> +const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq5018 = {
> +	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
> +	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq5018,
> +	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018),
> +};
> +
>  const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074 = {
>  	.rx_buf_rbm = HAL_RX_BUF_RBM_SW3_BM,
>  	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
> +	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074),
>  };
>  
>  const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
>  	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
>  	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
> +	.num_tx_rings = DP_TCL_NUM_RING_MAX_QCA6390,
>  };
>  
> +static_assert(ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq8074) >= DP_TCL_NUM_RING_MAX_QCA6390);
> +

instead of keeping this special handling, how about define its own tcl2wbm_rbm_map for
ath11k_hw_hal_params_qca6390？or even simply use the newly introduced
ath11k_hw_tcl2wbm_rbm_map_ipq5018? like

const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390 = {
	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq5018,
	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018)
};

>  const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750 = {
>  	.rx_buf_rbm = HAL_RX_BUF_RBM_SW1_BM,
>  	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_wcn6750,
> +	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_wcn6750),
>  };
>  
>  static const struct cfg80211_sar_freq_ranges ath11k_hw_sar_freq_ranges_wcn6855[] = {
> diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
> index 52d9f4c13b136..9db984ac4321c 100644
> --- a/drivers/net/wireless/ath/ath11k/hw.h
> +++ b/drivers/net/wireless/ath/ath11k/hw.h
> @@ -134,6 +134,7 @@ struct ath11k_hw_tcl2wbm_rbm_map {
>  struct ath11k_hw_hal_params {
>  	enum hal_rx_buf_return_buf_manager rx_buf_rbm;
>  	const struct ath11k_hw_tcl2wbm_rbm_map *tcl2wbm_rbm_map;
> +	size_t num_tx_rings;
>  };
>  
>  struct ath11k_hw_params {
> @@ -198,7 +199,6 @@ struct ath11k_hw_params {
>  	bool supports_regdb;
>  	bool fix_l1ss;
>  	bool credit_flow;
> -	u8 max_tx_ring;
>  	const struct ath11k_hw_hal_params *hal_params;
>  	bool supports_dynamic_smps_6ghz;
>  	bool alloc_cacheable_memory;
> @@ -291,6 +291,7 @@ extern const struct ce_ie_addr ath11k_ce_ie_addr_ipq5018;
>  
>  extern const struct ce_remap ath11k_ce_remap_ipq5018;
>  
> +extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq5018;
>  extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_ipq8074;
>  extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_qca6390;
>  extern const struct ath11k_hw_hal_params ath11k_hw_hal_params_wcn6750;
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 3276fe443502f..33ebe03380114 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -7392,7 +7392,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
>  	idr_for_each(&ar->txmgmt_idr,
>  		     ath11k_mac_vif_txmgmt_idr_remove, vif);
>  
> -	for (i = 0; i < ab->hw_params.max_tx_ring; i++) {
> +	for (i = 0; i < ab->hw_params.hal_params->num_tx_rings; i++) {
>  		spin_lock_bh(&ab->dp.tx_ring[i].tx_idr_lock);
>  		idr_for_each(&ab->dp.tx_ring[i].txbuf_idr,
>  			     ath11k_mac_vif_unref, vif);


