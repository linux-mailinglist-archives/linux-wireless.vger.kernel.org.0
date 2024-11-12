Return-Path: <linux-wireless+bounces-15210-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF079C5C86
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 16:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459341F22435
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 15:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87890205AB5;
	Tue, 12 Nov 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvVRnM+t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C6205AB1
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 15:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426764; cv=none; b=H3Ij0EDd96QlRfLKbuQc2BuLui+RMIs5e4lBBj2XbkjvAormjV224sQ1VMMRgjBgQnF7oEr6EgqCCrY1OWlPNXJUv6Ks6BmF71E2U3bURisGIsvHJlxy00CW/ENWZA+eAKvriqKzXxENywCjvQAv3S4Wi9Sda9aSIna7vEAyw7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426764; c=relaxed/simple;
	bh=SJsZQYVXU3ARBv4CchRXa9P05OcKPCJKPiyWbmToLcw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=j6ZKGKet9Eli5vBEJ2PBX4mOfgwoxys6ResutPe1WGtEg/3ZjUGePIuewJeJPZQL0nt7XARdD1L0dOh+M9tuz4i2ssv7LbkIYS2dwtJ7NqL0ulnxQobYobHgA1jGwMUCA8sy+QZU0Aopbes39/ull46//6Mv5gSGtHU0DZ9t8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvVRnM+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F8CC4CED8;
	Tue, 12 Nov 2024 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731426763;
	bh=SJsZQYVXU3ARBv4CchRXa9P05OcKPCJKPiyWbmToLcw=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=XvVRnM+tjABRUYPrahMQPK521snvmNYuQb+c6N6bogT0g/RLDNVC0oba+3cr5FFuV
	 IHd9547YOmSzegfyRCJnhe+ldcthPsCWyzaJDN1DHbisVaNdv6dmfaSLiyEgJGRt0+
	 WH8lS/EeI/aAUx/DZV5Z+jy92tTrQaY3RztuZIlpSGb6rYkAoZHTdRmveWFetcX2Lf
	 E0+gXf02vkOXu4b0/gzQcJLDHmJmwV41v7JuJgq5icIF/hIigAWCLVkJgPYuAygCO/
	 QC4aiwAT6kn7fPnVsYIDXE6Z2QXk3ENNjxb34PoiFgFNqImecJ+dDnfpZgRnNPDe/P
	 HwYTeeu0rrNww==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH v4 2/4] wifi: ath12k: Support phy counter and TPC stats
References: <20241106044548.3530128-1-quic_rdevanat@quicinc.com>
	<20241106044548.3530128-3-quic_rdevanat@quicinc.com>
Date: Tue, 12 Nov 2024 17:52:41 +0200
In-Reply-To: <20241106044548.3530128-3-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Wed, 6 Nov 2024 10:15:46 +0530")
Message-ID: <87bjyk4fg6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Dinesh Karthikeyan <quic_dinek@quicinc.com>
>
> Add support to request counters and Transmission Power Control
> (TPC) stats through HTT stats type 37. These stats give
> information about counters like received packet count, CRC pass
> count, error count, transmit abort count, etc., about counter reset
> like reset cause, channel frequency, number and mode, channel flags,
> etc., about TPC like transmit power scale, maximum transmit power,
> gain cap, EIRP, etc.
>
> Note: MCC firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support HTT stats type 37, i.e., the firmware does not respond to the
> command requesting stats.
>
> Sample output:
> -------------
> echo 37 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PHY_STATS_TLV:
> bdf_nf_chain[0] = -92
> bdf_nf_chain[1] = -94
> bdf_nf_chain[2] = -94
> bdf_nf_chain[3] = -93
> .....
>
> HTT_PHY_COUNTERS_TLV:
> rx_ofdma_timing_err_cnt = 18068
> rx_cck_fail_cnt = 0
> mactx_abort_cnt = 2612
> macrx_abort_cnt = 0
> .....
>
> HTT_PHY_RESET_STATS_TLV:
> pdev_id = 0
> chan_mhz = 0
> chan_band_center_freq1 = 0
> chan_band_center_freq2 = 0
> .....
>
> HTT_PHY_RESET_COUNTERS_TLV:
> pdev_id = 0
> cf_active_low_fail_cnt = 0
> cf_active_low_pass_cnt = 0
> phy_off_through_vreg_cnt = 0
> .....
>
> HTT_PHY_TPC_STATS_TLV:
> pdev_id = 0
> tx_power_scale = 0
> tx_power_scale_db = 0
> min_negative_tx_power = 0
> .....
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Dinesh Karthikeyan <quic_dinek@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
> ---
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 249 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  98 +++++++
>  2 files changed, 347 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index 8a4fe3cbb8dd..912fef503982 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -2625,6 +2625,240 @@ ath12k_htt_print_dlpager_stats_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void
> +ath12k_htt_print_phy_stats_tlv(const void *tag_buf, u16 tag_len,
> +			       struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_phy_stats_tlv *htt_stats_buf = tag_buf;
> +	u8 *buf = stats_req->buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u8 i;

Reverse xmas. I'll stop commenting about that now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

