Return-Path: <linux-wireless+bounces-23679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4C1ACD98B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFB4170CD0
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 08:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5502122F754;
	Wed,  4 Jun 2025 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="N7z1itmJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467742690D4;
	Wed,  4 Jun 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025185; cv=none; b=bQdqC2SzZmwmWorzCtv5feJ9b4WkLGBrTHlo98iVPfnW4Es+oK4L/FBEm+jaHfFF5S2ifBkqBpJwUGUfYpsvZZEMUttC8hMI1/31vIL236Agqsy2WJBCFhjcbhBwL4osOstyZo+yl+xuNv8gepH1rfWL5/R4zmEPJrinqo378hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025185; c=relaxed/simple;
	bh=ah/1l7NWZGuXZNkxhxl003S1bcdw6wA8ArbLwrkGtMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hjQ4IxGnoWdXLamxaON3jbIOQZebVlrDxtHp/QjACfXAYTgFoz2myVU3L9kvWrDbwnY9usk0LVq6xhVZrTHdGoTUMn3apM+IUfVNOSvxMV7H7KDtXkj1aLgos6Hr9stXDzLEDgsJ4D8kHva4g6y2nOVyMJGVVO5+aoaSN/R6HmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=N7z1itmJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553Leo8u010362;
	Wed, 4 Jun 2025 08:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GiAicXB4orilSgc1wX/z9RXRyEqhVTBQmfR4VXtHObc=; b=N7z1itmJMHTn3rAj
	27gmg/+4fzLbfWOxev4iwyJjzYVaxuBgFYxBzglxsrYvrM59IRO7m4Oy0kxPWY4f
	jeNkBHs3R7htogMGQZQO8zIyd1edO0O9RJezY6f8qNcoLkevtafqTEGi7n/3IAiI
	xaqWWVyuh+30qkaoYa7tYm7/MV3hfbj7FgKLWfVxwcXV1YjfXXv79WaP2V10unnp
	y+ZlpSObXwT484MtnD+QRgbi70eZYC8Df5dcbDEPDUuVQHJqjXpWUsymKxH3xCY4
	9eTBDxA7riBCkTCRdfiUAGfVQBfdrJTErWnnrvxzk4D9NmJenpLzIhB6IK5aajYU
	edfSWg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 471g8ynb2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Jun 2025 08:19:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5548JYEN018737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Jun 2025 08:19:34 GMT
Received: from [10.133.33.119] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Jun 2025
 01:19:33 -0700
Message-ID: <e7db7936-1bcf-4179-88e8-c3f6b1b072bf@quicinc.com>
Date: Wed, 4 Jun 2025 16:19:30 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath12k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: Remi Pommarel <repk@triplefau.lt>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20250526115137.2490-1-johan+linaro@kernel.org>
 <20250526115137.2490-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <20250526115137.2490-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDA2NCBTYWx0ZWRfX1Iu+GA69DAkS
 fhJHV3QONBIivJtj3GbobWzxVk90yv4qnyIaTeUTQ5jTxYXLRjv+1vCrZcbuRRI0zFK2+5Dgmik
 E50jXCe1Z56yYbfwwEEjpuz1WMgZOR473RJeIDXJfbKPjKnHk1J+769Xs/GqkkIynqfqoLtiI9i
 yRRlMmyFvl/ENyPlcpxzr4oLzomuy6fFjdr9aVrD5cOZmsmOergTozvrmCFtlN6EwD2UISAjrsc
 GzhYEjRuwV7YhxAhuibcVj8oYlKBDTnFsPFcdaho5FsXE26mmlYAF4jRBoM2IPvv3EemwWWVVk/
 nI/BKX/gsRm7CxYHGFWiyL795A9BMxYFb3Gpn3Y9HXmfhwx+5NMa33QnYTdQoKKJ5TGh+pK5BL1
 aUBENQ3umHmzlqwlHuXycWLC/9VR0N8zeu0vgrBjB0iqfeZORR8aXwfchZM1mcJ/VjydE6yH
X-Proofpoint-ORIG-GUID: qek3o-R4C2fC3tZ1clUGeUly7_pfAhiV
X-Proofpoint-GUID: qek3o-R4C2fC3tZ1clUGeUly7_pfAhiV
X-Authority-Analysis: v=2.4 cv=T/uMT+KQ c=1 sm=1 tr=0 ts=68400197 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=qEKYatp5oTCtzB8XyWEA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=893 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506040064



On 5/26/2025 7:51 PM, Johan Hovold wrote:
> Add the missing memory barriers to make sure that destination ring
> descriptors are read after the head pointers to avoid using stale data
> on weakly ordered architectures like aarch64.
> 
> Note that this may fix the empty descriptor issue recently worked around
> by commit 51ad34a47e9f ("wifi: ath12k: Add drop descriptor handling for
> monitor ring").
> 
> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org	# 6.3
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/net/wireless/ath/ath12k/dp_mon.c |  3 +++
>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 12 ++++++++++++
>   drivers/net/wireless/ath/ath12k/dp_tx.c  |  3 +++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c b/drivers/net/wireless/ath/ath12k/dp_mon.c
> index d22800e89485..90a7763502c8 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
> @@ -3258,6 +3258,9 @@ int ath12k_dp_mon_srng_process(struct ath12k *ar, int *budget,
>   	spin_lock_bh(&srng->lock);
>   	ath12k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while (likely(*budget)) {
>   		*budget -= 1;
>   		mon_dst_desc = ath12k_hal_srng_dst_peek(ab, srng);
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 75bf4211ad42..68fceb4201d7 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2753,6 +2753,9 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>   try_again:
>   	ath12k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while ((desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
>   		struct rx_mpdu_desc *mpdu_info;
>   		struct rx_msdu_desc *msdu_info;
> @@ -3599,6 +3602,9 @@ int ath12k_dp_rx_process_err(struct ath12k_base *ab, struct napi_struct *napi,
>   
>   	ath12k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while (budget &&
>   	       (reo_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
>   		drop = false;
> @@ -3941,6 +3947,9 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>   
>   	ath12k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while (budget) {
>   		rx_desc = ath12k_hal_srng_dst_get_next_entry(ab, srng);
>   		if (!rx_desc)
> @@ -4122,6 +4131,9 @@ void ath12k_dp_rx_process_reo_status(struct ath12k_base *ab)
>   
>   	ath12k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while ((hdr = ath12k_hal_srng_dst_get_next_entry(ab, srng))) {
>   		tag = le64_get_bits(hdr->tl, HAL_SRNG_TLV_HDR_TAG);
>   
> diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
> index ced232bf4aed..3124eafa0201 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
> @@ -853,6 +853,9 @@ void ath12k_dp_tx_completion_handler(struct ath12k_base *ab, int ring_id)
>   
>   	ath12k_hal_srng_access_begin(ab, status_ring);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while (ATH12K_TX_COMPL_NEXT(tx_ring->tx_status_head) != tx_ring->tx_status_tail) {
>   		desc = ath12k_hal_srng_dst_get_next_entry(ab, status_ring);
>   		if (!desc)

Reviewed-by: Miaoqing Pan <quic_miaoqing@quicinc.com>

