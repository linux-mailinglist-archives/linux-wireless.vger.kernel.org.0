Return-Path: <linux-wireless+bounces-17167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B1BA04A6B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 20:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1D6165962
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92391F63DB;
	Tue,  7 Jan 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hez8ws1i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52761F63E7
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279120; cv=none; b=ochZzEpdmotth0cDq5VapaaniPGEys31kvzyELNK7hsD/lezbno+Ue1XtVathcOV4QKWfPNn6RIowCtF3mbc4Y5Nl6z/+f4xbR4DCti5e1c2/c11CEyQ0rxFCTIJ6s1wG9L1/2WWmaakzKtnz4kqWmHI862x2/U3jKM5kUBAz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279120; c=relaxed/simple;
	bh=RD22hk1daK1JvYQmqzUMipy+wpFHrhVOOLxHdLDCat4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=WcPtaFeweW1xxd1sh4JGr8zBR1QoUdyzGoZKS8ZWzoP+wPxKo1aejBjJq8KybBMP2uPwJjfXian72TBlDXQF1bB1GC2LyHH+aB01DXM9ifrtfoIjlbFldJMfsYcf5wTOC8vgBkN5KHvTg9gcUqPuhcQGkUOu2TW9VSLcM6W8q3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hez8ws1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107A8C4CED6;
	Tue,  7 Jan 2025 19:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736279119;
	bh=RD22hk1daK1JvYQmqzUMipy+wpFHrhVOOLxHdLDCat4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Hez8ws1iQOkuGzCzv/pd107HlI827Ne2jj6TF68CAjNNFnZMlRFtWvFURgD4ke1np
	 NJTGhA5K9QE5nb3ewhRVCu+qlI7++8gpRb9tTVR1XyCpJkksodlFWG0otAqTHrvahv
	 gsCP+f292A+WbOfUKTNLU4Wg0MffISZklfS3F/A5KBkENnSnpYuHleT1mF0WDqq/Ru
	 5UGe+3YgduAq7yYVjF+V6TaYqjC0fhe5Tmq4tECfwzK3CZ6rno33xeFFp/XMqb5KDh
	 8smLDce6V6hHKoHC6zcWu8EvhTJYR1Ohmtb6L32ZnHI/BnTPjvIVRsOg9JdJtkiJ/r
	 mP2tMEsHMQ7Ig==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: Re: [PATCH 2/2] wifi: ath12k: Support Transmit Buffer OFDMA Stats
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
	<20241128110949.3672364-3-quic_rdevanat@quicinc.com>
Date: Tue, 07 Jan 2025 21:45:16 +0200
In-Reply-To: <20241128110949.3672364-3-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Thu, 28 Nov 2024 16:39:49 +0530")
Message-ID: <87jzb6flwz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Roopni Devanathan <quic_rdevanat@quicinc.com> writes:

> From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
>
> Add support to request OFDMA stats of transmit buffers from firmware through
> HTT stats type 32. These stats give information about NDPA, NDP, BRP and
> steering mechanisms.
>
> Note: WCN7850 firmware version -
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4 does not
> support HTT stats type 32.
>
> Sample output:
> -------------
> echo 32 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_TXBF_OFDMA_AX_NDPA_STATS_TLV:
> ax_ofdma_ndpa_queued = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> ax_ofdma_ndpa_tried = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> .....
>
> HTT_TXBF_OFDMA_AX_NDP_STATS_TLV:
> ax_ofdma_ndp_queued = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> ax_ofdma_ndp_tried = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> .....
>
> HTT_TXBF_OFDMA_AX_BRP_STATS_TLV:
> ax_ofdma_brpoll_queued = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> ax_ofdma_brpoll_tied = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> .....
>
> HTT_TXBF_OFDMA_AX_STEER_STATS_TLV:
> ax_ofdma_num_ppdu_steer = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> ax_ofdma_num_usrs_prefetch = 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0, 14:0, 15:0, 16:0,
> 17:0, 18:0, 19:0, 20:0, 21:0, 22:0, 23:0, 24:0, 25:0, 26:0, 27:0,
> 28:0, 29:0, 30:0, 31:0, 32:0, 33:0, 34:0, 35:0, 36:0, 37:0
> .....
>
> HTT_TXBF_OFDMA_AX_STEER_MPDU_STATS_TLV:
> rbo_steer_mpdus_tried = 0
> rbo_steer_mpdus_failed = 0
> sifs_steer_mpdus_tried = 0
> sifs_steer_mpdus_failed = 0
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

[...]

> +static void
> +ath12k_htt_print_txbf_ofdma_ax_ndpa_stats_tlv(const void *tag_buf, u16 tag_len,
> +					      struct debug_htt_stats_req *stats_req)
> +{
> +	const struct ath12k_htt_txbf_ofdma_ax_ndpa_stats_tlv *stats_buf = tag_buf;
> +	u32 buf_len = ATH12K_HTT_STATS_BUF_SIZE;
> +	u32 len = stats_req->buf_len;
> +	u8 *buf = stats_req->buf;
> +	u32 num_elements;
> +	u8 i;
> +
> +	if (tag_len < sizeof(*stats_buf))
> +		return;
> +
> +	num_elements = le32_to_cpu(stats_buf->num_elems_ax_ndpa_arr);
> +
> +	len += scnprintf(buf + len, buf_len - len, "HTT_TXBF_OFDMA_AX_NDPA_STATS_TLV:\n");
> +	len += scnprintf(buf + len, buf_len - len, "ax_ofdma_ndpa_queued =");
> +	for (i = 0; i < num_elements; i++)
> +		len += scnprintf(buf + len, buf_len - len, " %u:%u,", i + 1,
> +				 le32_to_cpu(stats_buf->ax_ndpa[i].ax_ofdma_ndpa_queued));
> +	len--;
> +	*(buf + len) = '\0';

Please avoid pointer arithmetic, this is simpler:

buf[len] = '\0';

Or should it be just 0 instead of '\0'? Don't know which one is
preferred.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

