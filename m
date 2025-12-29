Return-Path: <linux-wireless+bounces-30160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF650CE5CE8
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5E03023568
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60F6272E63;
	Mon, 29 Dec 2025 03:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AdILY1hK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E37GoeMT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DE26E17F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766978078; cv=none; b=YNknUk+qidbMaXkxQd2XpO4ZpDrftPiP7qYjY3TKtEr2BM/PLol8WoSMHHcMHpecBuzGGrWplVlocSyXyEA/hbbTQ7jBtnHYPGvi1YyIDiozzibAkWMbY5OJMTisaHn5MafBw7RgsBacTBcs0IDOz9lZhAMt8/OGN8BYWNSpDrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766978078; c=relaxed/simple;
	bh=RTtWXYBUr7n8GCe7Kr1DLSv212cAMWOlpru/jendDVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pO0+GrtjaHfEjcxyQhXi8EYyAGs1M5njfdltLFBccVVQsbsJwdXF7WtcOxB8VazAsqT8qSNX1qgFRL/EXpDls22dI9ZPp6616fyZNIbPiMkxsWFGRIaNrDFAxbnZSal3sSlJ8BF+dAFsj5BEPme7meSgKAnJCuBBzK3ICitX9Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AdILY1hK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E37GoeMT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BSNK5Vw3827684
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M20opajuIAOzQS6JcV1SCG/8yrO4afy2XBUwgx3WtJA=; b=AdILY1hKSAH4ttnJ
	n7IbFXXwoj8260ubFNpSmcVhXTqdVtb6EnnTm0aZhC6e6zFSkE3902K6opmtFwD7
	SvRFTD6NDXyaK4k80vN166bmB+oSsX7b/hwSjJxfOVIua1iGIGwDVR/JShWtTrDw
	odhOeayhqe+MiFSnarJbIhQDLq7iDharyDIHK9m+Ja3guxs2r3C3ZurbaUuXTGNs
	kjVbyPre1w/WBsMKBqne/hSI78lLvA8op1QfWqwRvosm/Jrsgi7hO/SAIZNt/kV3
	BIl0HoFnNwbT8tgjKxKVFJV5enUuj+K5VKzwjz5LyEuQue9x8t6Wd6wob2lYuism
	/274MQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ba55e3d4u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:14:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a08cbeb87eso145349835ad.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Dec 2025 19:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766978074; x=1767582874; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M20opajuIAOzQS6JcV1SCG/8yrO4afy2XBUwgx3WtJA=;
        b=E37GoeMT3llbX7ZALp1LuDSSb96gLfvnE+pfo6lB8Lb5z7x+VhPN1kuveAfyIRUGnT
         tNamWwfds5ajztragOJLhMHHBvYDMzw+1EQIeE44ap9Bdp2VFF802LjY6tixlWDNinBE
         6w4knH86EdmQ22k5m14fSJKuaz/F2EYofJHHUpRcV2l7qvkWLHHZYfmdSnH0Qgvf6Hcy
         9AuDr6Io0P3tsLFZ/6BuCqjhKG/uvQv6obkqhqDr6O0qwMtSpCqTlK0HVTzwysOYPnhS
         //qwL3s5Jhuc9Ke13HJD9v/IusMy7zhkrYHzjdKgDQQfw09h9hOfup8MnmV0Vu087dJ8
         KIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766978074; x=1767582874;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M20opajuIAOzQS6JcV1SCG/8yrO4afy2XBUwgx3WtJA=;
        b=ZP3yN2yw10KVV92tDwUI9HMV6kh7iqGaHeIuBG59vqzOgA+srrxgvsNU+HRV9hxtAJ
         OuDHGyq9Ncvf2RyAh4jzX/gQUag1TNHBr7k7YzPLuOhOPFN60m+qji2U1tUJ2BMgL/Jn
         ZypBapMNNbLDDUbGwQrgwveoDteLWqFcnOO48gTPy6qzj25gUhCkkFf0BFJdPZ/r0ajO
         uqX17HghsF72C/98aHwX0NV+6+ThfvrV9F5BaxUFJPEi5kPEJZC5q13j4nC5EosRB+43
         XdykyM0sc6rts+tkqN4f9uNMVttHT7bG6p74QhkMl2k+W11HJzyGZazwfMeLFKI8n1cw
         7rwQ==
X-Gm-Message-State: AOJu0Yz+ybTfoXr4EIzVngN32QMmb6k36yiT4pW7Lg/Q5VlO5CVuZl3X
	gULoDUMVVUBl5HonlS4ZUM1c7MwP7S7D3kgLszgMgAL8Uaa6KNLJcZXfoimhW79D5IZZexg63oo
	1SgqFK8all0tLGyTQR9Hn7FZtooutDSihmcip485XQiMNbSgMS/T/btse7cLKvoaxjoUidg==
X-Gm-Gg: AY/fxX5s9dAgG9RoxyrAm+HMKyDUL7JOkTrK6IwUp4yCIPFlzk0Y+VRJoGmBooQf38R
	62blDhtK30HySepux495ZYlxlwmyI03EbeLd49RcREhNwhK6sgapNGArm6sYH+9Bx7C/F3/V/Il
	a1RTcXaDusovz2uvoBqzgsY+gPwdsPagspyfuat2Gzmf55zy/t2fCnItsXIhXH5EBcwl/hHARUp
	pQDLShiNxdpoIqlPTfKt7JVu7ntvYEK20HQYclzwoEc0AuozHiWDzwnMxrzJazDaYyn47tJYByG
	BIc2BxidKHG+oipG1qaNCj+PLyAj3RFbWFASnirI68LZRvwlPbLd1xo/Hdt/9VG70uPRGD28g3d
	lpJ8I+uForuvrT7TiEzKsQ0Nzi9/Q5JvaXmkDCXVQzQirSsuy0jgXgB7Q84qIUzvxTvXE/Q==
X-Received: by 2002:a17:903:244a:b0:29f:301a:f6d2 with SMTP id d9443c01a7336-2a2f22235a9mr298490995ad.19.1766978073595;
        Sun, 28 Dec 2025 19:14:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLx0uCawHwZtVejXNuF6nHdr3KCGXW2ZSyGqyz5fveo98kUZiLU/PXOY7Tiu5rTR3M96hGUQ==
X-Received: by 2002:a17:903:244a:b0:29f:301a:f6d2 with SMTP id d9443c01a7336-2a2f22235a9mr298490835ad.19.1766978073026;
        Sun, 28 Dec 2025 19:14:33 -0800 (PST)
Received: from [10.133.33.44] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c666casm256230005ad.3.2025.12.28.19.14.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Dec 2025 19:14:32 -0800 (PST)
Message-ID: <a3df690e-4224-409f-b325-90beb905219e@oss.qualcomm.com>
Date: Mon, 29 Dec 2025 11:14:28 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: ath11k: move .max_tx_ring to struct
 ath11k_hw_hal_params
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, jjohnson@kernel.org,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251228151408.2116108-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDAyNyBTYWx0ZWRfX6klx881epxXT
 DsRC0t5EIkb5YWJ8HODWkWoQJB9POT2fPr84eUvPyaXd1bsOptI06dJilNIRPtGrpf6LkBUA3f0
 xR+60GlnJMVY2IntsaKctlKtdJRxWsK4PWxv/4/oOTd60gGRI7oVGCsQVXkpRPbnpHasFfiIEEX
 sTzJp5BN/JOo9JF8OWdrF8cPC+dcBBXTdOnqekWqztrhxlxlmLMYtL9r9QMh8e2LMbBgc80C4Ae
 Fw4lx98DPh/jyWEro/PrRlsGVdUmWh2zQrvY7+ZZLrPy3oUevZEI+bnjlcpeUR5zxzAamjFaRHo
 RnldDB9SeBQmYwDHBYxcEXlRX7Iv4bokKXn6CKbgQvwerbfHitvwYk5Ux7OyRIdlXE8KC5WBAPn
 U+B22wu619iPO0UQyD0A+ZHdcA7p88xZQuiyTHXWTaJ6OQDLDkxm31PrvUJWRgmT0blHPlDlNTW
 9DJtrS8CxI08bOYFT1w==
X-Authority-Analysis: v=2.4 cv=UMDQ3Sfy c=1 sm=1 tr=0 ts=6951f21a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=WX8WESg8fM6HLtOjjJYA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: PcbLKggvpbZQskcAvo0Y2yBQZbLy6LID
X-Proofpoint-GUID: PcbLKggvpbZQskcAvo0Y2yBQZbLy6LID
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_08,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512290027



On 12/28/2025 11:14 PM, Alexandru Gagniuc wrote:
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
> Changes since v2:
>  - Use ipq5018 rbm_map for ath11k_hw_hal_params_qca6390
>  - Drop unecessarry static_assert
> 
> Changes since v1:
>  - use "num_tx_rings" name instead of "map_len"
>  - make sure debugfs.c is correctly updated
>  - add a static_assert for ath11k_hw_hal_params_qca6390 special case
> ---
>  drivers/net/wireless/ath/ath11k/core.c    | 12 +-----------
>  drivers/net/wireless/ath/ath11k/debugfs.c |  2 +-
>  drivers/net/wireless/ath/ath11k/dp.c      | 12 ++++++------
>  drivers/net/wireless/ath/ath11k/dp.h      |  1 -
>  drivers/net/wireless/ath/ath11k/dp_tx.c   |  9 +++++----
>  drivers/net/wireless/ath/ath11k/hw.c      | 19 ++++++++++++++++++-
>  drivers/net/wireless/ath/ath11k/hw.h      |  3 ++-
>  drivers/net/wireless/ath/ath11k/mac.c     |  2 +-
>  8 files changed, 34 insertions(+), 26 deletions(-)
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
> diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
> index 7a55afd33be82..1bd513f68a3c3 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.h
> +++ b/drivers/net/wireless/ath/ath11k/dp.h
> @@ -199,7 +199,6 @@ struct ath11k_pdev_dp {
>  #define DP_BA_WIN_SZ_MAX	256
>  
>  #define DP_TCL_NUM_RING_MAX	3
> -#define DP_TCL_NUM_RING_MAX_QCA6390	1
>  
>  #define DP_IDLE_SCATTER_BUFS_MAX 16
>  
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
> index caa6dc12a790b..d19c4b372a2aa 100644
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
> @@ -2822,19 +2830,28 @@ const struct ath11k_hw_regs ipq5018_regs = {
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
> -	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq8074,
> +	.tcl2wbm_rbm_map = ath11k_hw_tcl2wbm_rbm_map_ipq5018,
> +	.num_tx_rings = ARRAY_SIZE(ath11k_hw_tcl2wbm_rbm_map_ipq5018),
>  };
>  
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

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


