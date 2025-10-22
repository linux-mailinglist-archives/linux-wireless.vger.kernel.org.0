Return-Path: <linux-wireless+bounces-28160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6899BF9AB7
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 04:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6BC74E1B0F
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Oct 2025 02:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BA3350A21;
	Wed, 22 Oct 2025 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fGHZTgmx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE77846F
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761098521; cv=none; b=NDXy7/rzqGPPx+gK8VpvesJ+fZw+/DZ7sFlqL2atMDhlqSy9i9Qn10olz5RXl6HgnrZAhX6QqgOoUkCfxOcBztZGp+bld/IVBXvR2QJajCiF3BHvuXSTtON1fJ8OLTpC1wX+5OJDDnCcYyYaQJE/4pc8BDhVhDf8WWrDoenneDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761098521; c=relaxed/simple;
	bh=82IIhDBoYiGdtjQKpreyCpAu6aBFftgvVZjT8a8L+vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSpjAj48nONj2YE1awhljpK6onEpNQSsAlPYhiRrxvgkRUAY7IyEyCZTIrmLLRYoIb3hNSysq8pzqcOh4Y0uXFCqVWMN33WB3+cE2Wx2fIO75pNjozJrPEjx/dbO6GSjb2TpRVHzzDDS8EMcCkAxUPQLIkbRECgQL25PUlncPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fGHZTgmx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LEk6dg030207
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 02:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1I5p2ZuKHZE1opVS3btm0ptuyLkWXCKsQ8tiIaD/ZrM=; b=fGHZTgmxqUcAM/J7
	zNM/1v+hrDmhG2F8o9WB/Mxo/UubKYEHgbIK+UufFH1WI9bP/JlkIzJSplLXtG6F
	qh/9Ry/SOBJeQoCDclLOvq+mmnOVY824U5lZKm+ihgTIVyTHqSoQdRS4fOHs2GyX
	vnkuhR2j8S6T0Mv6NiVMMFVL6pvd+LzkUZL9MmqAF+XyVDefVt6GDcfPQM22xDe0
	YckSLivmhBxnL4dK7drRi+PM5saYqOxPHItnjrqM+7ewsZHsjjVVJNHan3hVzlkQ
	9N4GBKzSkobtG+MM0Ma7KKoXut5z4q1xHA4OGwPikRKgNGNLQWve9g3BxvV+Etxl
	VyhYwA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge2uc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Oct 2025 02:01:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32edda89a37so5485341a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 19:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761098518; x=1761703318;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1I5p2ZuKHZE1opVS3btm0ptuyLkWXCKsQ8tiIaD/ZrM=;
        b=fZx5WbJ9esbioIkawJkmMoktL2qNVEwwY4hPuCDiCjSuX3A8FwsNPAu/5n/g1mnFuC
         8mi3hRgZebaurqTq9+q1g4Gf87FSJ7SavA2bboDEU4mhfiYzV1v3FpHyEXRh5Aae/IYG
         ko/qOHG4rc0ny6nG9r67DNNBeKzPTDTBN2nD726wnkKp2kdNJ6izCuOuEJ2xZATve8eE
         fNFLxlQpG6gO6bLVYa8+Z5qXE/4bh2TjJyTrJ/8xZkC8PWDzOdZsc+I5WAHtTwDxTyhH
         /l1lzfv7pQ8sG0/3/b4hgW5GF0dlRfL4TnJ499Yd8WKGgi7nUZcKHX8bhUwyNRNlqxuP
         rQvw==
X-Gm-Message-State: AOJu0YxwEEJYQ/IkxYk1zxU+pZYo/J//Iv2dzj8/TeDY4O+y2BTuKsne
	c1NE0SoSYd2bMSINHwEG8b6PI0nG72EXbempsybU2No53dxN57YjZDRS7MgT3PoTKXlU0/w6qFt
	/mmaApV0GrU4xKLqFCmh+nsPjEAlXfsQJh2KS36vzS5VH13BXQC7Bu8+Uc90G5RRx/OSqJg==
X-Gm-Gg: ASbGncspwRGWiHsgagoGiObuA3WVEqjkVWA/juN/5N81/0tKNewmTSTFhI2MlxxgVKH
	MPZ3kn25hI5VBHdOFfNPtZQmJN9IFRO2BNR3IKHAG4Qu3k8qsFqL5Hxr1BobUlRUOXuzSaNVO4n
	eyfqszgXnX1TMtZAk+6JbdW/D4UjEuRIOY11M/j7HC/LA95ADp/nksGuAUP9iObK09i7XieVxom
	a04sMTdML9froW9zZkOeFdtbMApqHF6ZC4YI2uk9PR7CMOfyvoG27GygApgoGUW+OenaBPHYZxy
	KMX9qwkyYImiyBAAOqChBlKFDiMo+Uz/RGWampqwg1INyaS5v8PWD6j3dG89R+7fX7Iz0iZveeI
	vH1L3rbZivQWd1HOpB++n+JOiq1JIikva40Igm9JXw9L5m/lKaEREG2rqYcqoDtTK5EUvOL/C
X-Received: by 2002:a17:90b:3144:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33bcf919094mr27154501a91.35.1761098517610;
        Tue, 21 Oct 2025 19:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyJap8BDy0ySxTYjdyFtOFYf07sWrLUb7sVpImSiLW49i3MvEvmF5sUPoiOz4B5dcTdP0HCQ==
X-Received: by 2002:a17:90b:3144:b0:335:2b86:f319 with SMTP id 98e67ed59e1d1-33bcf919094mr27154449a91.35.1761098517000;
        Tue, 21 Oct 2025 19:01:57 -0700 (PDT)
Received: from [10.133.33.122] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34a94sm12829432b3a.23.2025.10.21.19.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 19:01:56 -0700 (PDT)
Message-ID: <306188de-8d08-4559-99d0-561ae85b45b2@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 10:01:54 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Assert base_lock is held before
 allocating REO update element
To: Sarika Sharma <sarika.sharma@oss.qualcomm.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20251021112204.323242-1-sarika.sharma@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX3KyxdmH63XYr
 yZiej59Ky0fd73bAUcGOGp1hdXwcX79lQTsleMhhq6grsQyELj3zxaWBORZFkDuhHBSFfRz0iLF
 a27RQ7PcPgSww85sw5OCJ7L5LV2WaNvEV3qLk1p7TzJ3CtA888GJRVaeHmALWdITi/kzsGAx8y8
 VsV3w9bIAZHBAWI8NuzmAx4t2WaIrUJipGgZUJWEEQqlFUVmQ8E0p1So89GX6ND+NMuZZlc+NLL
 1q7ywgn4s3MsDaX+FR1rzyNwgUczr+onVuKo3XV9Zjewk/YnuW9xOYM8UHDQKOIdgwqnXTn55Aj
 GsXHqqA95XRK2PbFVNvJFHE55WIebqBdj9C1kxSckvOs8hGkG4PXJd2WOj2yu2Fu1HJTQtBx299
 qbY9RrJa5nHJb+xaTB1MwHhR4QTcUw==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f83b16 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=JwkovW8QCGnPCImCt90A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: ljGx3Kixl5ccCDTZ5hDW0jrWwR-NK8vw
X-Proofpoint-ORIG-GUID: ljGx3Kixl5ccCDTZ5hDW0jrWwR-NK8vw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020



On 10/21/2025 7:22 PM, Sarika Sharma wrote:
> Add a lockdep assertion to verify that ab->base_lock is held prior to
> allocating a REO update element in ath12k_dp_prepare_reo_update_elem().
> This helps detect potential concurrency issues during development and
> improves code robustness.
> Compiled tested only.
> 
> Signed-off-by: Sarika Sharma <sarika.sharma@oss.qualcomm.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 6c9f0839c83a..d28d8ffec0f8 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -1089,6 +1089,8 @@ static int ath12k_dp_prepare_reo_update_elem(struct ath12k_dp *dp,
>  {
>  	struct dp_reo_update_rx_queue_elem *elem;
>  
> +	lockdep_assert_held(&dp->ab->base_lock);
> +
>  	elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
>  	if (!elem)
>  		return -ENOMEM;
> 
> base-commit: 2b306fc6b1d00dfe85b3b80eb257256e2b5ba610

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>

