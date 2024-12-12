Return-Path: <linux-wireless+bounces-16315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220D09EE962
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 15:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7139283C6B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA121571D;
	Thu, 12 Dec 2024 14:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+T6r0AN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C92121571B
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015220; cv=none; b=JHCADPNEcEFZNbJDSJuowweTZ+KcChkz8pzaCA8oO7O2LlBZv1VR+AjmdBcok+rZj9D3ItJN3fm10RBgqOtcgPPbvjm3yBPSCOHmWbe3l6tK6FkE+97ID/UzXjiD8WjugCib8J2cuNsOkgQx0HypwAivPq6xgcvDBCEUBADYvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015220; c=relaxed/simple;
	bh=OY3GhRgWTrJpMq7G4x3kgzAeJmhXstpLimNOpeOAYds=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=pLBgo3HHH0MyaWvPGVEj1HqMkqX7S8CWkeJNPd3ebgRuexuUJPX5m9VRJ2JdziLd/pPNTYu7M5kdzbfIbbIrlMjxIwps8buoL2J8ETBi9sI8KilEn3hHBouA7lqf7Oka0qC9OU8QDFLb2ByA6zSZI69TYGZTyR0bKwl50I4Ae1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+T6r0AN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C34C4CECE;
	Thu, 12 Dec 2024 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734015219;
	bh=OY3GhRgWTrJpMq7G4x3kgzAeJmhXstpLimNOpeOAYds=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=g+T6r0ANPqeSEBPZVvY1SOu8liOnZnWEQcSNfPx4VkT6u25BUmENhc6/cNfmVBaVf
	 LGSCxFJUfz0EJ948PZgvMu1VGRVZ+MOw+kpr3HvUBXRLCz0E64tIOxo2XYsdkYWxHy
	 yRyBqOzDxAyZ2HNLxK/w1nRxfCSmHWrKfc5j9ANElDRN9MppXuc1kEH0a/t02cT9oT
	 5cEmRsv55+YoON7gWrp0BD4GCfrpH6cyEbTIWd54jvGON76Bl82sUuWT5Dq8SabfNU
	 6lfQiWEpYN19Ae3pQBj6+VW93UhkrNQTIN+oPQNu4kmiHjgCJkdfO2Pmf3tdMtvk47
	 OyhVYHzxdUoag==
From: Kalle Valo <kvalo@kernel.org>
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: <ath11k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] wifi: ath11k: add srng->lock for
 ath11k_hal_srng_* in monitor mode
References: <20241008053744.1070-1-quic_kangyang@quicinc.com>
	<20241008053744.1070-3-quic_kangyang@quicinc.com>
Date: Thu, 12 Dec 2024 16:53:37 +0200
In-Reply-To: <20241008053744.1070-3-quic_kangyang@quicinc.com> (Kang Yang's
	message of "Tue, 8 Oct 2024 13:37:44 +0800")
Message-ID: <87ttb9nea6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kang Yang <quic_kangyang@quicinc.com> writes:

> ath11k_hal_srng_* should be used with srng->lock to protect srng data.
>
> For ath11k_dp_rx_mon_dest_process() and ath11k_dp_full_mon_process_rx(),
> they use ath11k_hal_srng_* for many times but never call srng->lock.
>
> So when running (full) monitor mode, warning will occur:
> RIP: 0010:ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
> Call Trace:
>  ? ath11k_hal_srng_dst_peek+0x18/0x30 [ath11k]
>  ath11k_dp_rx_process_mon_status+0xc45/0x1190 [ath11k]
>  ? idr_alloc_u32+0x97/0xd0
>  ath11k_dp_rx_process_mon_rings+0x32a/0x550 [ath11k]
>  ath11k_dp_service_srng+0x289/0x5a0 [ath11k]
>  ath11k_pcic_ext_grp_napi_poll+0x30/0xd0 [ath11k]
>  __napi_poll+0x30/0x1f0
>  net_rx_action+0x198/0x320
>  __do_softirq+0xdd/0x319
>
> So add srng->lock for them to avoid such warnings.
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>

[...]

> @@ -5607,7 +5609,7 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
>  	struct hal_sw_mon_ring_entries *sw_mon_entries;
>  	struct ath11k_pdev_mon_stats *rx_mon_stats;
>  	struct sk_buff *head_msdu, *tail_msdu;
> -	void *mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
> +	struct hal_srng *mon_dst_srng;
>  	void *ring_entry;
>  	u32 rx_bufs_used = 0, mpdu_rx_bufs_used;
>  	int quota = 0, ret;
> @@ -5623,6 +5625,9 @@ static int ath11k_dp_full_mon_process_rx(struct ath11k_base *ab, int mac_id,
>  		goto reap_status_ring;
>  	}
>  
> +	mon_dst_srng = &ar->ab->hal.srng_list[dp->rxdma_mon_dst_ring.ring_id];
> +	spin_lock_bh(&mon_dst_srng->lock);

Why initialise mon_dst_srng differently? The commit message mentions
nothing about this change.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

