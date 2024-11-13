Return-Path: <linux-wireless+bounces-15242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A756A9C6D54
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 12:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C303281301
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 11:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F361FDF84;
	Wed, 13 Nov 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp/IzrBm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520B1FB89D
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495847; cv=none; b=R5b73k4n6uUH4NHV8QlGwasgN1IMGTs8KSD71tyEgctjfyRcUkN3AOjSvXbAm/jDARN4u+ObuZo7fTweb7RFfCVetKqoP8LUNT/DzE/z+9hDTN5HRKwLGzVt2dYGGb3f42OHVpCTh7YI4GxDw5dXZakdPE804xDzujBO/Mpy5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495847; c=relaxed/simple;
	bh=py+b2Nhz+BY4MAu1VQH3cX7boqg4sylhQMNX+cuwUC8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=R18SNgjD56aWXv5g5Dayorua1cxSOK/THodTBA7+bZjUXkweU441CA/FWwMi9yUhEjFyHXssQ35/mDjs2GYza3D4ldoJ9QK8YTmycC40TzftdeubaP8JYhrGg0MQtOXQTh+xR7HI/aSKof8IIMZS2a+I935c1d6JnbiN9CW/mT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp/IzrBm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E61C4CECD;
	Wed, 13 Nov 2024 11:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731495847;
	bh=py+b2Nhz+BY4MAu1VQH3cX7boqg4sylhQMNX+cuwUC8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=hp/IzrBmj1YcS36HSM9Map1rILWv1W6zL3STmg+bmj6m4HPHx+e9zNKu6GjhA8h55
	 N7l2V2edZ56jaRhyvNRxRtrH/iI6RwqfhUCABU+Ic414atZmqnNUwborVrULx0Ri9f
	 fvpdSphZ8JmDn6cJq29LiDJGh/6H/uMpV0BvgOk5VNcvmDkPBL8oM9FBUewj3vtAsk
	 ZBJc+1Fk2u/ZRH/OWmqKx/VWyOmTnryCR+5cXPtElDnwBbhyJdqxjtek7watmd6MQ3
	 mH/MHMmQHx0fSTx5D5H8GGjML4xXOFGNJtzQcN8RLx5sTVeNb1dAU01o3GVzqsIDJ7
	 v6x3NClukO56w==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Dinesh
 Karthikeyan <quic_dinek@quicinc.com>
Subject: Re: [PATCH v5 2/4] wifi: ath12k: Support phy counter and TPC stats
References: <20241113072707.3377341-1-quic_rdevanat@quicinc.com>
	<20241113072707.3377341-3-quic_rdevanat@quicinc.com>
Date: Wed, 13 Nov 2024 13:04:04 +0200
In-Reply-To: <20241113072707.3377341-3-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Wed, 13 Nov 2024 12:57:05 +0530")
Message-ID: <87h68b2y57.fsf@kernel.org>
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
>  .../wireless/ath/ath12k/debugfs_htt_stats.c   | 248 ++++++++++++++++++
>  .../wireless/ath/ath12k/debugfs_htt_stats.h   |  98 +++++++
>  2 files changed, 346 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> index bde3644a7c21..575a03137e9f 100644
> --- a/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> +++ b/drivers/net/wireless/ath/ath12k/debugfs_htt_stats.c
> @@ -2628,6 +2628,239 @@ ath12k_htt_print_dlpager_stats_tlv(const void *tag_buf, u16 tag_len,
>  	stats_req->buf_len = len;
>  }
>  
> +static void
> +ath12k_htt_print_phy_stats_tlv(const void *tag_buf, u16 tag_len,
> +			       struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_phy_stats_tlv *htt_stats_buf = tag_buf;
> +	u32 len = stats_req->buf_len;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u8 *buf = stats_req->buf, i;

I see several cases where reverse xmas is not used still. No need to
resend because of this but please remember this in the future.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

