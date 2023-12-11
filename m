Return-Path: <linux-wireless+bounces-665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3780CEBC
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912211C210C7
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 14:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53770495EA;
	Mon, 11 Dec 2023 14:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dAx3NDT7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A9EAB
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 06:54:59 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BBC9kZm010067;
	Mon, 11 Dec 2023 14:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=DXqbcW2/yfevKNDzFduXfzs6j0etXw4ujAd+Te43fK4=; b=dA
	x3NDT7Ww/VxrYNp7+v3LdFuB7OSbkrWwxHSffZygN4VlUGCyYHdORPpniiha2IjO
	zQin4X7vXDlRBcnMtel9H6ViwRtEZC31mqk/AU+C+GUyPFxarlAWo9HhHJIHt8JZ
	AdFrvGt1jx0mFhe/tHkI92oI/M2d6ABEDUqbSQ+t6XwINIoJgWvzTw9F/sTbqLI5
	17cWJYBHpKNQ5ocwgnO28vDkF2GaDfvirm6mKOcFqr+vzgC60KLsKAnWuZjl6Ytz
	xNFLzXN245QRD2J/UafE+C8sxioYYrgOb6bS99ctxELCOwItUvVoq/9Zpi+i9/iq
	ASNM3HAy0i407r+H1vdg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ux25xgbb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 14:54:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BBEscjW021479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 14:54:38 GMT
Received: from [10.110.106.103] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 06:54:37 -0800
Message-ID: <6e09aeb2-4811-47ff-aa4b-beb1a30ba00d@quicinc.com>
Date: Mon, 11 Dec 2023 06:54:36 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix IOMMU errors on buffer rings
Content-Language: en-US
To: Zhenghao Gu <imguzh@gmail.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231206024325.27283-1-imguzh@gmail.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231206024325.27283-1-imguzh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: dgkxoVU3qJQi5SczLJM7wcF_N5AY0Hh3
X-Proofpoint-GUID: dgkxoVU3qJQi5SczLJM7wcF_N5AY0Hh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 lowpriorityscore=0
 mlxlogscore=445 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110122

On 12/5/2023 6:43 PM, Zhenghao Gu wrote:
> virt_to_phys doesn't work on systems with IOMMU enabled,
> which have non-identity physical-to-IOVA mappings.
> It leads to IO_PAGE_FAULTs like this:
> [IO_PAGE_FAULT domain=0x0023 address=0x1cce00000 flags=0x0020]
> and no link can be established.
> 
> This patch changes that to dma_map_single(), which works correctly.
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Zhenghao Gu <imguzh@gmail.com>
> ---
>  drivers/net/wireless/ath/ath11k/dp.c  | 19 ++++++++++++++++---
>  drivers/net/wireless/ath/ath11k/hal.c | 20 ++++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/hal.h |  2 ++
>  3 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
> index d070bcb3f..c74230e4c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -104,11 +104,14 @@ void ath11k_dp_srng_cleanup(struct ath11k_base *ab, struct dp_srng *ring)
>  	if (!ring->vaddr_unaligned)
>  		return;
>  
> -	if (ring->cached)
> +	if (ring->cached) {
> +		dma_unmap_single(ab->dev, ring->paddr_unaligned, ring->size,
> +				 DMA_FROM_DEVICE);
>  		kfree(ring->vaddr_unaligned);
> -	else
> +	} else {
>  		dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
>  				  ring->paddr_unaligned);
> +	}
>  
>  	ring->vaddr_unaligned = NULL;
>  }
> @@ -249,7 +252,17 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab, struct dp_srng *ring,
>  
>  		if (cached) {
>  			ring->vaddr_unaligned = kzalloc(ring->size, GFP_KERNEL);
> -			ring->paddr_unaligned = virt_to_phys(ring->vaddr_unaligned);
> +			if (!ring->vaddr_unaligned)
> +				return -ENOMEM;
> +
> +			ring->paddr_unaligned =
> +				dma_map_single(ab->dev, ring->vaddr_unaligned,
> +					       ring->size, DMA_FROM_DEVICE);
> +			if (dma_mapping_error(ab->dev, ring->paddr_unaligned)) {
> +				kfree(ring->vaddr_unaligned);
> +				ring->vaddr_unaligned = NULL;
> +				return -ENOMEM;
> +			}
>  		}
>  	}
>  
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wireless/ath/ath11k/hal.c
> index 0a99aa7dd..bd4cccdba 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -628,15 +628,31 @@ u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng)
>  	return NULL;
>  }
>  
> +u32 *ath11k_hal_srng_dst_peek_with_dma(struct ath11k_base *ab,
> +				       struct hal_srng *srng, dma_addr_t *paddr)

since this is only used from within hal.c make it static

> +{
> +	lockdep_assert_held(&srng->lock);
> +
> +	if (srng->u.dst_ring.tp != srng->u.dst_ring.cached_hp) {
> +		*paddr = (srng->ring_base_paddr +
> +			  sizeof(*srng->ring_base_vaddr) * srng->u.dst_ring.tp);
> +		return (srng->ring_base_vaddr + srng->u.dst_ring.tp);
> +	}
> +
> +	return NULL;
> +}
> +
>  static void ath11k_hal_srng_prefetch_desc(struct ath11k_base *ab,
>  					  struct hal_srng *srng)
>  {
>  	u32 *desc;
> +	dma_addr_t desc_paddr;
> +
>  
>  	/* prefetch only if desc is available */
> -	desc = ath11k_hal_srng_dst_peek(ab, srng);
> +	desc = ath11k_hal_srng_dst_peek_with_dma(ab, srng, &desc_paddr);
>  	if (likely(desc)) {
> -		dma_sync_single_for_cpu(ab->dev, virt_to_phys(desc),
> +		dma_sync_single_for_cpu(ab->dev, desc_paddr,
>  					(srng->entry_size * sizeof(u32)),
>  					DMA_FROM_DEVICE);
>  		prefetch(desc);
> diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
> index 1942d41d6..facaf8fe0 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.h
> +++ b/drivers/net/wireless/ath/ath11k/hal.h
> @@ -943,6 +943,8 @@ void ath11k_hal_srng_get_params(struct ath11k_base *ab, struct hal_srng *srng,
>  u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
>  					struct hal_srng *srng);
>  u32 *ath11k_hal_srng_dst_peek(struct ath11k_base *ab, struct hal_srng *srng);
> +u32 *ath11k_hal_srng_dst_peek_with_dma(struct ath11k_base *ab,
> +				       struct hal_srng *srng, dma_addr_t *paddr);

should be static so remove this

>  int ath11k_hal_srng_dst_num_free(struct ath11k_base *ab, struct hal_srng *srng,
>  				 bool sync_hw_ptr);
>  u32 *ath11k_hal_srng_src_peek(struct ath11k_base *ab, struct hal_srng *srng);
> 


