Return-Path: <linux-wireless+bounces-24452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D27AE7485
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A405A44A4
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 01:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F261991CD;
	Wed, 25 Jun 2025 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JqRxlnjY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A37E70813;
	Wed, 25 Jun 2025 01:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816477; cv=none; b=P3XA9xsQexs5VS5XQE1KlKJD5oirC+k5oBQrMsjmrV30fFt545YEOY9EnEMJ9hdFpxkIe1BMu0fh/2Qf5NbLLca8IuAgRsIoinlfYkC+fm8nsC1YEurs6aRQbXaAqtgYEaslSNBSBpSB9yNzhIOQ1ANmtzioEiB9oSGPvbRQb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816477; c=relaxed/simple;
	bh=Hab9wA7C3uRH3mAJRczNQB77fCzSDyyyF+2+9qITcY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kbGIkB6fJdYlOOxUjOETiudbyUYdkvWYE+XD4Xtzo4xWEnfdvEuIe9pu7KSLbSLcWVSc6SquuedUbueroavdkLmwvGCBMjca2nn7qQ36sb00vCD0gmJXYOWLH/JTcPGtfAzAEhZSybZ2Dq83RXbeARGSLTV7vivrFUyQFoVnSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JqRxlnjY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFFunO005903;
	Wed, 25 Jun 2025 01:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/sCyxHk0RmWf992RkcJbic6PXS5rmLllEZWxrab6Mnk=; b=JqRxlnjYbHX4015W
	l5qA8uzECFgzJw+qcuFhkcJ4kZ91Am7npH/EolB7wHZaPR3QEuylUq951fKeER1+
	l91QUx78Sk4ftYgUCzavZa+BJJkBHU4nv9FqqLCRAGHKqoZrlIL/hVFlXMJiCtFz
	m5hp/tdX8Ci1h3mZUpp1cIHvbE1ZoIkLjyZOIHCM930SnsGuQF/aE+GJWkYRxt9f
	Om3xAkX5R96Xo6A8JL9tmFA6MIcHHtBoKFA+YqGC10n1q9VezBi2Mqh3zIgysWS0
	GwvrZdqVsRY7/FBtIkBgqc7DFJCrhMGyMjXPCmm3HyoXrbeG8g1BToxZAI2MpAJZ
	tx7E3g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f3bge5rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:54:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55P1sSc3004649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 01:54:28 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 24 Jun
 2025 18:54:25 -0700
Message-ID: <d3ab26b1-1205-4c36-8422-ef60202c8bff@quicinc.com>
Date: Wed, 25 Jun 2025 09:54:23 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] wifi: ath12k: fix source ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Miaoqing Pan <quic_miaoqing@quicinc.com>,
        Remi Pommarel
	<repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250617084402.14475-1-johan+linaro@kernel.org>
 <20250617084402.14475-4-johan+linaro@kernel.org>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20250617084402.14475-4-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3NoDaBKBJzQiwMegsInScjUz482BiwF4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDAxMyBTYWx0ZWRfX/p0Zr3z4nazM
 4V1PFKeOdAMQWyKlrslAO8J0L+M4f+7GEWfXe70wNvN3Of17u+PiQdiiKyoH0APFhaoxMPsQUH0
 SWZEIfzDlrgXNzMAp3JLYPs5LiecOaVm0DIjfwEbXHbGjHaVRxSgCfoAi6k3lzjcB9rHlVEKiuU
 ACpk/xGAr7sufEQD4YYYg7ePwtz7IXwgJonWJ6zZ8+mse1MFaiX6mqin2cxjxdyvq4pRfYRIbKG
 jx5fAQN9SOwfjVB/hSQTBwBCYTvXyrs1Ln5iiZIdCofhAJvCZ5xmX9Q2tltOXpxJiXxqDjyLk+P
 AqGI1KxIKS6TZmqsYMlVR+qkghG3DP0CFqn13UcALVB4v1E3JS77HC/2CG++uKxq2qryNrDWlcR
 f4PrigGQAAVGN4b7foP6UHt6spiXEEuO2gwFocJ0ojMpuQMW9L+2sNBtONjnOPv7g64rJYuN
X-Authority-Analysis: v=2.4 cv=L4kdQ/T8 c=1 sm=1 tr=0 ts=685b56d5 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=WnX9ENNIfPvkDGQfGdAA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 3NoDaBKBJzQiwMegsInScjUz482BiwF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 mlxlogscore=499 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250013



On 6/17/2025 4:44 PM, Johan Hovold wrote:
> Add the missing memory barrier to make sure that LMAC source ring
> descriptors are written before updating the head pointer to avoid
> passing stale data to the firmware on weakly ordered architectures like
> aarch64.
> 
> Note that non-LMAC rings use MMIO write accessors which have the
> required write memory barrier.
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org      # 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/net/wireless/ath/ath12k/hal.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/hal.c b/drivers/net/wireless/ath/ath12k/hal.c
> index 726969cfcaec..d8193d9577bb 100644
> --- a/drivers/net/wireless/ath/ath12k/hal.c
> +++ b/drivers/net/wireless/ath/ath12k/hal.c
> @@ -2178,7 +2178,11 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  			srng->u.src_ring.last_tp =
>  				*(volatile u32 *)srng->u.src_ring.tp_addr;
> -			*srng->u.src_ring.hp_addr = srng->u.src_ring.hp;
> +			/* Make sure descriptor is written before updating the
> +			 * head pointer.
> +			 */
> +			dma_wmb();
> +			WRITE_ONCE(*srng->u.src_ring.hp_addr, srng->u.src_ring.hp);
>  		} else {
>  			srng->u.dst_ring.last_hp = *srng->u.dst_ring.hp_addr;
>  			*srng->u.dst_ring.tp_addr = srng->u.dst_ring.tp;
> @@ -2187,6 +2191,10 @@ void ath12k_hal_srng_access_end(struct ath12k_base *ab, struct hal_srng *srng)
>  		if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  			srng->u.src_ring.last_tp =
>  				*(volatile u32 *)srng->u.src_ring.tp_addr;
> +			/* Assume implementation use an MMIO write accessor
> +			 * which has the required wmb() so that the descriptor
> +			 * is written before the updating the head pointer.
> +			 */
>  			ath12k_hif_write32(ab,
>  					   (unsigned long)srng->u.src_ring.hp_addr -
>  					   (unsigned long)ab->mem,

Reviewed-by: Baochen Qiang <quic_bqiang@quicinc.com>


