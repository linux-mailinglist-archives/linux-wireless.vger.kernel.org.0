Return-Path: <linux-wireless+bounces-16481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F539F4F00
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 16:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA70A188FC4E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D531F7074;
	Tue, 17 Dec 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgTGAvQ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39321F6695
	for <linux-wireless@vger.kernel.org>; Tue, 17 Dec 2024 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448190; cv=none; b=Y2usxNQH5poMYPk1OsoNiuMNR0oo/XHJ3LCa2+X3n69aeMnZZ6Mbe62JlFDPDzm6vL7aUQlD7yvyic3QthROItlTaXVvzTjLsMF0ZdgSBTDJQk3gCqJEMjMSRSecy/NScQvhA6nklqlEos3IMkk/7MvItm/NN4Q9i3juADKNW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448190; c=relaxed/simple;
	bh=b6Ee/2FJS6CMMcv99DMPkaHN/TkaYLJhpK/5ku1jAy0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JX/Sr5F43m275yichmrNvjgW3K9dtrd/JXziCVSfROBGssV0Z/4eN5lzrJM6zlwypeI2IeejAlxLpPbpNltHS9DSsj5an7UjpRvUrLxajCUykMGMvy4PLGD3zYveHWA2bn5eau6aNt+Z0sFkzwS7rzRTrR5ChVtr4njmP42rMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgTGAvQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8C8C4CED4;
	Tue, 17 Dec 2024 15:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448190;
	bh=b6Ee/2FJS6CMMcv99DMPkaHN/TkaYLJhpK/5ku1jAy0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=pgTGAvQ1jUoSGI2MvOGG13oa2mPn7jtJDSXm3Ej82B6I7OXyeof+rmdv6GdiIQotp
	 05f8qQWP6jwQC8LF0/JwRsEdJ1buQqobHGPPVdMWWQF+26hgHkH3rgPP/RKK2Xj7Lb
	 Z/Hq5YcPclIQHgcGPcNqEKycaFQ5Xyx98Mi+MOt7vF894+h4/0apapJecJYnqgElIQ
	 d/Csh5FXpayrOEtp2AP7xItrM1AZUAD/0LL+s7TMzOTP82yX7RSh0jX/67SQl6MRtG
	 etWes5T5K5hx/HIZh3rhBPeX6RszJ4P+8RgCex4wb+6qAcIyTXn2/ny3I6VHcczHGx
	 nuQ7024eLUSxA==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,  Rajat
 Soni <quic_rajson@quicinc.com>
Subject: Re: [PATCH v4 2/2] wifi: ath12k: Support pdev Puncture Stats
References: <20241217055408.1293764-1-quic_rdevanat@quicinc.com>
	<20241217055408.1293764-3-quic_rdevanat@quicinc.com>
Date: Tue, 17 Dec 2024 17:09:47 +0200
In-Reply-To: <20241217055408.1293764-3-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Tue, 17 Dec 2024 11:24:08 +0530")
Message-ID: <87y10el51g.fsf@kernel.org>
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
> +ath12k_htt_get_punct_dir_type_str(enum ath12k_htt_stats_direction direction,
> +				  struct debug_htt_stats_req *stats_req)
> +{
> +	const char *direction_str = "unknown";
> +	u32 len = stats_req->buf_len;

[...]

> +
> +	stats_req->buf_len = len;

What's the idea with len here? I don't get it.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

