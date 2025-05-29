Return-Path: <linux-wireless+bounces-23486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA98AC7961
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 09:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 068951887929
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 07:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3282550CA;
	Thu, 29 May 2025 07:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RDMsCN4X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17707EC4;
	Thu, 29 May 2025 07:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502232; cv=none; b=rySr6CKpO9BLTIA5wx7rIgyFgzTCkIny1mdgZaRaBxInrBXZpfnMLrFvNOdHanfwsEEfiAydUeLy2XF1mzLhmFzKivrPuDDjHJ+ud2XKhMSF7YL5iL2Vp/UF1sgO35SBriMTyQoN/p7vnAqOzttwTMaHHXGrJ6pCcrcHpd9jcTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502232; c=relaxed/simple;
	bh=+xmkRlZ8AGIEZrZiWtJrfAL/ehTHBGAbW3sINC7us5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=h6N1P8iRgMbshaxlMYR5KUM//2iRhGlbDPI7pN25kPYD3QnkzscBBPWCAET1e3ZSUVy+9cbztb3RSNnggiHoVPMzMe1tu5q8uFdTwO5unagkWWv1w8NvI/iTrUS3MvBStOlVoAlpAPVMyJuOnZCuKmtiwazdBdASTX0lLlRCDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RDMsCN4X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54T3U235030924;
	Thu, 29 May 2025 07:03:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yf1sra5ei+YWgbd0wCWc5vmWvo0kR8CErObKG5rUvKE=; b=RDMsCN4XP1TgRFRQ
	vEOJwHkIOHYulO57bBZ2Je6coYZkV8nyC1ucokhXINdOFYQ5U56yoKT2jI0y57UT
	62Z7/1LhhW+yLkPjV06jeO4wDiQjYpZNB/EOUBMgCuIx1T+crXHYOoJeBBB2M6YB
	3bcm+SIo1wfS7qJHzlzoeaWN4UemsYXQjVja2XYeAGeLyPZQn3a2GhoOlJxWsqv0
	sEPrMwchUdukyipzdTQWVL9ZhD34yEmRuC0eHLOiX53A2dDhUtBib8Z/OE4nNPBO
	txvQraQ+A32OUmtewF1HBTZR5S4o0vC2KDTCxT/F0BGTOoOO33cNoqk0ITSHqIHG
	TlN3aA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46whuf56kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 07:03:43 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 54T73hDw007603
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 May 2025 07:03:43 GMT
Received: from [10.133.33.94] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 29 May
 2025 00:03:40 -0700
Message-ID: <026b710f-b50f-4302-ad4f-36932c2558ff@quicinc.com>
Date: Thu, 29 May 2025 15:03:38 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wifi: ath11k: fix dest ring-buffer corruption
To: Johan Hovold <johan+linaro@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20250526114803.2122-1-johan+linaro@kernel.org>
 <20250526114803.2122-2-johan+linaro@kernel.org>
Content-Language: en-US
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
In-Reply-To: <20250526114803.2122-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=OslPyz/t c=1 sm=1 tr=0 ts=683806cf cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8
 a=xt-FAz5EuN-mLoWhW44A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ublGsjyCSGbR_kY6RSrO4PK_2uM8o_TU
X-Proofpoint-GUID: ublGsjyCSGbR_kY6RSrO4PK_2uM8o_TU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDA2OCBTYWx0ZWRfX9l8N77fVGXBz
 VWq+r+buWOo32kfkGPIGql0bJELp1LYd7adoiBZSCjoZZWoVpkGCykOwWt5Tk9+iH3Hn5q2v19A
 7kgCHx2YtE5ji0Rl6pe5O7vj7Y8bxGqWfzrXzx9MVCZwmwdhp7eEathghZCUquWMtT1zEzG1aEI
 zp2+uMD9rb2FWKnF44DS6gJbtkZhsBX8S1I0PsRuogkl7tUXWrBhaTUSZG1iRsqqe+4HHBJd/YP
 H5w+UV7QjDFFeNnCf3cgu9jQ4nJmXRVZoeBuh+K+gKeMsESiLujlMKBWMLg46xT2TT7dwBSmQcN
 8hrqsjodMFAOIGw8SLdT1vKXhxwl9nCySGoapWm75rzNe0kGtqGaZ7vaOODZFGmd6fJ1a75dzVY
 YCee03X1FkH3OmFsnjsJ9ZGyFYIrzMAEaS8QmrgTqPp7cxkBSxDWTKpUrz8tVA63WeuSZG3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_03,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 mlxlogscore=896 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505290068



On 5/26/2025 7:48 PM, Johan Hovold wrote:
> Add the missing memory barriers to make sure that destination ring
> descriptors are read after the head pointers to avoid using stale data
> on weakly ordered architectures like aarch64.
> 
> Tested-on: WCN6855 hw2.1 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Cc: stable@vger.kernel.org	# 5.6
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/net/wireless/ath/ath11k/dp_rx.c | 19 +++++++++++++++++++
>   drivers/net/wireless/ath/ath11k/dp_tx.c |  3 +++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index ea2959305dec..dfe2d889c20f 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -3851,6 +3851,9 @@ int ath11k_dp_process_rx_err(struct ath11k_base *ab, struct napi_struct *napi,
>   
>   	ath11k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +

Thanks Johan, for continuing to follow up on this issue. I have some 
different opinions.

This change somewhat deviates from the fix approach described in 
https://lore.kernel.org/all/20250321095219.19369-1-johan+linaro@kernel.org/. 
In this case, the descriptor might be accessed before it is updated or 
while it is still being updated. Therefore, a dma_rmb() should be added 
after the call to ath11k_hal_srng_dst_get_next_entry() and before 
accessing ath11k_hal_ce_dst_status_get_length(), to ensure that the DMA 
has completed before reading the descriptor.

However, in this patch, the memory barrier is used to protect the head 
pointer (HP). I don't think a memory barrier is necessary for HP, 
because even if an outdated HP is fetched, 
ath11k_hal_srng_dst_get_next_entry() will return NULL and exit safely. 
So, placing the memory barrier inside 
ath11k_hal_srng_dst_get_next_entry() would be more appropriate.

@@ -678,6 +678,8 @@ u32 *ath11k_hal_srng_dst_get_next_entry(struct 
ath11k_base *ab,
         if (srng->flags & HAL_SRNG_FLAGS_CACHED)
                 ath11k_hal_srng_prefetch_desc(ab, srng);

+       dma_rmb();
+
         return desc;
  }


>   	while (budget &&
>   	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
>   		struct hal_reo_dest_ring *reo_desc = (struct hal_reo_dest_ring *)desc;
> @@ -4154,6 +4157,9 @@ int ath11k_dp_rx_process_wbm_err(struct ath11k_base *ab,
>   
>   	ath11k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while (budget) {
>   		rx_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng);
>   		if (!rx_desc)
> @@ -4280,6 +4286,9 @@ int ath11k_dp_process_rxdma_err(struct ath11k_base *ab, int mac_id, int budget)
>   
>   	ath11k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while (quota-- &&
>   	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
>   		ath11k_hal_rx_reo_ent_paddr_get(ab, desc, &paddr, &desc_bank);
> @@ -4353,6 +4362,9 @@ void ath11k_dp_process_reo_status(struct ath11k_base *ab)
>   
>   	ath11k_hal_srng_access_begin(ab, srng);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while ((reo_desc = ath11k_hal_srng_dst_get_next_entry(ab, srng))) {
>   		tag = FIELD_GET(HAL_SRNG_TLV_HDR_TAG, *reo_desc);
>   
> @@ -5168,6 +5180,9 @@ static void ath11k_dp_rx_mon_dest_process(struct ath11k *ar, int mac_id,
>   	rx_bufs_used = 0;
>   	rx_mon_stats = &pmon->rx_mon_stats;
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
>   		struct sk_buff *head_msdu, *tail_msdu;
>   
> @@ -5630,6 +5645,10 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
>   	spin_lock_bh(&mon_dst_srng->lock);
>   
>   	ath11k_hal_srng_access_begin(ar->ab, mon_dst_srng);
> +
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while ((ring_entry = ath11k_hal_srng_dst_peek(ar->ab, mon_dst_srng))) {
>   		head_msdu = NULL;
>   		tail_msdu = NULL;
> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
> index 8522c67baabf..549d17d90503 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -700,6 +700,9 @@ void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id)
>   
>   	ath11k_hal_srng_access_begin(ab, status_ring);
>   
> +	/* Make sure descriptor is read after the head pointer. */
> +	dma_rmb();
> +
>   	while ((ATH11K_TX_COMPL_NEXT(tx_ring->tx_status_head) !=
>   		tx_ring->tx_status_tail) &&
>   	       (desc = ath11k_hal_srng_dst_get_next_entry(ab, status_ring))) {


