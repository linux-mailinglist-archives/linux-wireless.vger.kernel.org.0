Return-Path: <linux-wireless+bounces-16482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6059F4F68
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 16:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE09318804CD
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367711F708B;
	Tue, 17 Dec 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C85Rboko"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127081F7082
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449204; cv=none; b=uAJkEOLaCgmWcYa/dGuvMuWckrsY3FvXSV9VcrB3/ASYjMm+hmV4rVHXkXUYC4qtkGVRlWMzystuSDHEL8UMgf/RBRyX3OsHPq72c7bBzD9u8iVqRYhUzWNobURZaL7UCufOoBQE/FpBIlXuM4akrbdDibWOnFOqGiA16LyWGb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449204; c=relaxed/simple;
	bh=XI6WlXJy7+nA87hZkua9BKN48HVzS6jDxkY/GJOikNk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=XnBXCsdzT6NRamFgbDAkPu2eJKyih029Yt0H3MXKSmdfPA9Rpe9x0ZY/Jam1ZknKYQnH+G82HgfOLNSi+WIV+nrVqkIw950pF99jY1qUlj5PHqBtCYcb82hUQPLpkPTnsQqYQW8CPsUlEshlONPSCM0xIlDWSIdLzlMRnD56ohU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C85Rboko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8447C4CED3;
	Tue, 17 Dec 2024 15:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449203;
	bh=XI6WlXJy7+nA87hZkua9BKN48HVzS6jDxkY/GJOikNk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=C85RbokoKSqVSac6qK5mSE52TLo4LGcN30H3L49gWdyr3E8WEARKD2nsIEUQIPxeS
	 YekjBrafEgs/S4uG/emVfpRx7YryX51t03i8uHuGVj4B0ayQE38vyKBXDg1Ru1Sa3x
	 DrluZ56weqbXIpSDhNQnGZ7jPoM+POo+ZCMN/ZmUm9fpBsxYv9TkNWNfH0S7q0KDhR
	 fXZa9/sCZFPQxqz/lfzD5oVPjQ/j6sQkkgLI5dtiP4NIFvSfrJTIpPV6jT9SoweEGC
	 KXfQXMfnvoAaDuMqrzqOkwN7XB6MCPQuIlBojJMvNzYAQRfEnoZHIzz6SenhNbI0sl
	 fg/kKoR2oUshw==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Rajat
 Soni <quic_rajson@quicinc.com>
Subject: Re: [PATCH v4 2/2] wifi: ath12k: Support pdev Puncture Stats
References: <20241217055408.1293764-1-quic_rdevanat@quicinc.com>
	<20241217055408.1293764-3-quic_rdevanat@quicinc.com>
Date: Tue, 17 Dec 2024 17:26:41 +0200
In-Reply-To: <20241217055408.1293764-3-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 11:24:08 +0530")
Message-ID: <87ttb2l49a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Rajat Soni <quic_rajson@quicinc.com>
>
> Add support to request pdev puncture stats from firmware through
> HTT stats type 46. These stats give the count of number of
> subbands used in different wifi standards.
>
> Sample output:
> -------------
> echo 46 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> tx_ofdm_su_last_used_pattern_mask = 0x00000001
> tx_ofdm_su_num_subbands_used_cnt_01 = 217
> tx_ofdm_su_num_subbands_used_cnt_02 = 0
> tx_ofdm_su_num_subbands_used_cnt_03 = 0
> .....
>
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> tx_ax_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
> tx_ax_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
>
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> tx_be_dl_mu_ofdma_last_used_pattern_mask = 0x00000000
> tx_be_dl_mu_ofdma_num_subbands_used_cnt_01 = 0
> tx_be_dl_mu_ofdma_num_subbands_used_cnt_02 = 0
> tx_be_dl_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
>
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> rx_ax_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
> rx_ax_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
>
> HTT_PDEV_PUNCTURE_STATS_TLV:
> mac_id = 0
> rx_be_ul_mu_ofdma_last_used_pattern_mask = 0x00000000
> rx_be_ul_mu_ofdma_num_subbands_used_cnt_01 = 0
> rx_be_ul_mu_ofdma_num_subbands_used_cnt_02 = 0
> rx_be_ul_mu_ofdma_num_subbands_used_cnt_03 = 0
> .....
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Rajat Soni <quic_rajson@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

[...]

> +static const char*
> +ath12k_htt_get_punct_ppdu_type_str(enum ath12k_htt_stats_ppdu_type ppdu_type,
> +				   struct debug_htt_stats_req *stats_req)
> +{
> +	const char *ppdu_type_str = "unknown";
> +	u32 len = stats_req->buf_len;
> +
> +	switch (ppdu_type) {
> +	case ATH12K_HTT_STATS_PPDU_TYPE_MODE_SU:
> +		ppdu_type_str = "su";
> +		break;
> +	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_MIMO:
> +		ppdu_type_str = "dl_mu_mimo";
> +		break;
> +	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_MIMO:
> +		ppdu_type_str = "ul_mu_mimo";
> +		break;
> +	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_OFDMA:
> +		ppdu_type_str = "dl_mu_ofdma";
> +		break;
> +	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_OFDMA:
> +		ppdu_type_str = "ul_mu_ofdma";
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	stats_req->buf_len = len;
> +	return ppdu_type_str;
> +}

Also here I don't get why the len variable is needed. I would just
simplify this and the previous function to:

static const char*
ath12k_htt_get_punct_ppdu_type_str(enum ath12k_htt_stats_ppdu_type ppdu_type,
				   struct debug_htt_stats_req *stats_req)
{
	switch (ppdu_type) {
	case ATH12K_HTT_STATS_PPDU_TYPE_MODE_SU:
		return "su";
	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_MIMO:
		return "dl_mu_mimo";
	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_MIMO:
		return "ul_mu_mimo";
	case ATH12K_HTT_STATS_PPDU_TYPE_DL_MU_OFDMA:
		return "dl_mu_ofdma";
	case ATH12K_HTT_STATS_PPDU_TYPE_UL_MU_OFDMA:
		return "ul_mu_ofdma";
	default:
		return "unknown";
	}

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

