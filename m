Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7993B6551
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Jun 2021 17:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbhF1PYu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Jun 2021 11:24:50 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39010 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235187AbhF1PWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Jun 2021 11:22:34 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624893609; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=o72jrWUVeUYKN5rStHn1/hdFWsyZYhxXq9mo6K9nbNw=;
 b=XjiFNjMSisikfTHKhldTvNo0VhLyEmz/l27aeO+0lc8eeV4vYph/eCvxzjlO6LnpaQxiiDJD
 LZzOQBz0jg89ZODMYBuJDNX++gSGPVsuZKF5EFgI+h3AKQkgtulyMl99Om9Fxn5xq0j/2caD
 UtOdvSoyPRELPeJNhBWpGL1Akgc=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60d9e8895d0d101e386766ee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 28 Jun 2021 15:19:37
 GMT
Sender: jjohnson=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B020BC43460; Mon, 28 Jun 2021 15:19:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: jjohnson)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F402C433F1;
        Mon, 28 Jun 2021 15:19:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 28 Jun 2021 08:19:36 -0700
From:   Jeff Johnson <jjohnson@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        P Praneesh <ppranees@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Sriram R <srirrama@codeaurora.org>,
        ath11k <ath11k-bounces@lists.infradead.org>
Subject: Re: [PATCH 02/12] ath11k: allocate dst ring descriptors from
 cacheable memory
In-Reply-To: <20210615211407.92233-3-jouni@codeaurora.org>
References: <20210615211407.92233-1-jouni@codeaurora.org>
 <20210615211407.92233-3-jouni@codeaurora.org>
Message-ID: <8700923ed5cbabf3d55f18149e1bd2de@codeaurora.org>
X-Sender: jjohnson@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-15 14:13, Jouni Malinen wrote:
> From: P Praneesh <ppranees@codeaurora.org>
> 
> tcl_data and reo_dst rings are currently being allocated
> using dma_allocate_coherent() which is non cachable.
> 
> Allocating ring memory from cacheable memory area
> allows cached descriptor access and prefetch next
> descriptors to optimize CPU usage during
> descriptor processing on NAPI.
> 
> Tested-on: QCN9074 hw1.0 PCI 
> WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01695-QCAHKSWPL_SILICONZ-1
> 
> Co-developed-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Co-developed-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp.c  | 34 +++++++++++++++++++++++----
>  drivers/net/wireless/ath/ath11k/dp.h  |  1 +
>  drivers/net/wireless/ath/ath11k/hal.c | 25 ++++++++++++++++++--
>  drivers/net/wireless/ath/ath11k/hal.h |  1 +
>  4 files changed, 54 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp.c
> b/drivers/net/wireless/ath/ath11k/dp.c
> index b0c8f6290099..cf869ebc209a 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.c
> +++ b/drivers/net/wireless/ath/ath11k/dp.c
> @@ -101,8 +101,11 @@ void ath11k_dp_srng_cleanup(struct ath11k_base 
> *ab,
> struct dp_srng *ring)
>  	if (!ring->vaddr_unaligned)
>  		return;
> 
> -	dma_free_coherent(ab->dev, ring->size, ring->vaddr_unaligned,
> -			  ring->paddr_unaligned);
> +	if (ring->cached)
> +		kfree(ring->vaddr_unaligned);
> +	else
> +		dma_free_coherent(ab->dev, ring->size,
> ring->vaddr_unaligned,
> +				  ring->paddr_unaligned);
> 
>  	ring->vaddr_unaligned = NULL;
>  }
> @@ -222,6 +225,7 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab,
> struct dp_srng *ring,
>  	int entry_sz = ath11k_hal_srng_get_entrysize(ab, type);
>  	int max_entries = ath11k_hal_srng_get_max_entries(ab, type);
>  	int ret;
> +	bool cached;
> 
>  	if (max_entries < 0 || entry_sz < 0)
>  		return -EINVAL;
> @@ -229,10 +233,25 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab,
> struct dp_srng *ring,
>  	if (num_entries > max_entries)
>  		num_entries = max_entries;
> 
> +	/* Allocate the reo dst and tx completion rings from cacheable
> memory */
> +	switch (type) {
> +	case HAL_REO_DST:
> +		cached = true;
> +	default:
> +		cached = false;
> +	}
> +
>  	ring->size = (num_entries * entry_sz) + HAL_RING_BASE_ALIGN - 1;
> -	ring->vaddr_unaligned = dma_alloc_coherent(ab->dev, ring->size,
> -						   &ring->paddr_unaligned,
> -						   GFP_KERNEL);
> +
> +	if (cached) {
> +		ring->vaddr_unaligned = kzalloc(ring->size, GFP_KERNEL);
> +		ring->paddr_unaligned = virt_to_phys(ring->vaddr_unaligned);

Internal developers found this is causing a fault in rx data path.
Suggested fix:
-               ring->paddr_unaligned = 
virt_to_phys(ring->vaddr_unaligned);
+               ring->paddr_unaligned = dma_map_single(ab->dev, 
ring->vaddr_unaligned,
+                                                      ring->size, 
DMA_FROM_DEVICE);


> +	} else {
> +		ring->vaddr_unaligned = dma_alloc_coherent(ab->dev,
> ring->size,
> +
> &ring->paddr_unaligned,
> +							   GFP_KERNEL);
> +	}
> +
>  	if (!ring->vaddr_unaligned)
>  		return -ENOMEM;
> 
> @@ -292,6 +311,11 @@ int ath11k_dp_srng_setup(struct ath11k_base *ab,
> struct dp_srng *ring,
>  		return -EINVAL;
>  	}
> 
> +	if (cached) {
> +		params.flags |= HAL_SRNG_FLAGS_CACHED;
> +		ring->cached = 1;
> +	}
> +
>  	ret = ath11k_hal_srng_setup(ab, type, ring_num, mac_id, &params);
>  	if (ret < 0) {
>  		ath11k_warn(ab, "failed to setup srng: %d ring_id %d\n",
> diff --git a/drivers/net/wireless/ath/ath11k/dp.h
> b/drivers/net/wireless/ath/ath11k/dp.h
> index ee768ccce46e..e6591488a28c 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.h
> +++ b/drivers/net/wireless/ath/ath11k/dp.h
> @@ -64,6 +64,7 @@ struct dp_srng {
>  	dma_addr_t paddr;
>  	int size;
>  	u32 ring_id;
> +	u8 cached;
>  };
> 
>  struct dp_rxdma_ring {
> diff --git a/drivers/net/wireless/ath/ath11k/hal.c
> b/drivers/net/wireless/ath/ath11k/hal.c
> index eaa0edca5576..a58e86e42b5b 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.c
> +++ b/drivers/net/wireless/ath/ath11k/hal.c
> @@ -627,6 +627,21 @@ u32 *ath11k_hal_srng_dst_peek(struct ath11k_base 
> *ab,
> struct hal_srng *srng)
>  	return NULL;
>  }
> 
> +static void ath11k_hal_srng_prefetch_desc(struct ath11k_base *ab,
> +					  struct hal_srng *srng)
> +{
> +	u32 *desc;
> +
> +	/* prefetch only if desc is available */
> +	desc = ath11k_hal_srng_dst_peek(ab, srng);
> +	if (likely(desc)) {
> +		dma_sync_single_for_cpu(ab->dev, virt_to_phys(desc),
> +					(srng->entry_size * sizeof(u32)),
> +					DMA_FROM_DEVICE);
> +		prefetch(desc);
> +	}
> +}
> +
>  u32 *ath11k_hal_srng_dst_get_next_entry(struct ath11k_base *ab,
>  					struct hal_srng *srng)
>  {
> @@ -642,6 +657,10 @@ u32 *ath11k_hal_srng_dst_get_next_entry(struct
> ath11k_base *ab,
>  	srng->u.dst_ring.tp = (srng->u.dst_ring.tp + srng->entry_size) %
>  			      srng->ring_size;
> 
> +	/* Try to prefetch the next descriptor in the ring */
> +	if (srng->flags & HAL_SRNG_FLAGS_CACHED)
> +		ath11k_hal_srng_prefetch_desc(ab, srng);
> +
>  	return desc;
>  }
> 
> @@ -775,11 +794,13 @@ void ath11k_hal_srng_access_begin(struct 
> ath11k_base
> *ab, struct hal_srng *srng)
>  {
>  	lockdep_assert_held(&srng->lock);
> 
> -	if (srng->ring_dir == HAL_SRNG_DIR_SRC)
> +	if (srng->ring_dir == HAL_SRNG_DIR_SRC) {
>  		srng->u.src_ring.cached_tp =
>  			*(volatile u32 *)srng->u.src_ring.tp_addr;
> -	else
> +	} else {
>  		srng->u.dst_ring.cached_hp = *srng->u.dst_ring.hp_addr;
> +		ath11k_hal_srng_prefetch_desc(ab, srng);
> +	}
>  }
> 
>  /* Update cached ring head/tail pointers to HW.
> ath11k_hal_srng_access_begin()
> diff --git a/drivers/net/wireless/ath/ath11k/hal.h
> b/drivers/net/wireless/ath/ath11k/hal.h
> index 35ed3a14e200..0f4f9ce74354 100644
> --- a/drivers/net/wireless/ath/ath11k/hal.h
> +++ b/drivers/net/wireless/ath/ath11k/hal.h
> @@ -513,6 +513,7 @@ enum hal_srng_dir {
>  #define HAL_SRNG_FLAGS_DATA_TLV_SWAP		0x00000020
>  #define HAL_SRNG_FLAGS_LOW_THRESH_INTR_EN	0x00010000
>  #define HAL_SRNG_FLAGS_MSI_INTR			0x00020000
> +#define HAL_SRNG_FLAGS_CACHED                   0x20000000
>  #define HAL_SRNG_FLAGS_LMAC_RING		0x80000000
> 
>  #define HAL_SRNG_TLV_HDR_TAG		GENMASK(9, 1)
> --
> 2.25.1

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
