Return-Path: <linux-wireless+bounces-17166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F015DA04A5F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 20:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FF27A3131
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 19:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D41F4E40;
	Tue,  7 Jan 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k689uoA7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AF91D8DFE
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736278916; cv=none; b=awROnwfDeLFFrvWYDxi2m/lGKPFmYyjCEDZQPvPvT7W+EJMMSPp5NW0pO/3bLJDvK8Fl/cx2vD5EHs1O+qMRT74lYCuR9TVG7Tpn48BbHeI5+3DMtCm4+oYt6wL0rmiBkprXev8qasIxmEsXXX5SbMvh4fmBATG6aq9iE69wQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736278916; c=relaxed/simple;
	bh=jfyXnyiwS27l4XHf5wb845dXNP3GsC/zYJpvT8CrZz4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=CRdXPVUqPXqajEbw/6bssCjFP8tN5VvkyrFhkUxPXL7hbpE/EZkSnDwKznDYhBC21vx7DvuWhg8sEnG9qalUphbTJGBKn9NyZeC1RGcwdWPAQ+9bhDyJNPwbhNGFiyyHweuFOzjRiFEEKvtYrAq9SkfQ8Wn+o9gZGJPEzAxPO3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k689uoA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB93C4CED6;
	Tue,  7 Jan 2025 19:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736278916;
	bh=jfyXnyiwS27l4XHf5wb845dXNP3GsC/zYJpvT8CrZz4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=k689uoA7OPxhYoZw3BW3AZRh0nNnsVI6xdpEcoDHG8PZUVAPTYuYN+wOAv00Gh4+F
	 j003TZOjuCRIDR3gqN3C/VQQvmjpOwdB57hpmY8lGvcd8ClVRqNWVm68nvfPtOHnLI
	 tHF4IlGOUNF0xoguq1Nu2wJc/bEqi78v90RBtfbZYoiWDqmv/9ADEYWM69eoktjpAW
	 BBvMO7CunOf7+epSS7ftjEgRAfomcc0x68GrswtArpqR35ZopcCZWVxpYINHORT1eT
	 rZNo4YkKr0cgGvunso75kANtEYUcbtWUNKoNuLgDhAf9igPvZmlefEMQj9mADL7IVO
	 kZIPZiJkp9VCQ==
From: Kalle Valo <kvalo@kernel.org>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>,
  Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: Re: [PATCH 1/2] wifi: ath12k: Support Transmit Rate Buffer Stats
References: <20241128110949.3672364-1-quic_rdevanat@quicinc.com>
	<20241128110949.3672364-2-quic_rdevanat@quicinc.com>
Date: Tue, 07 Jan 2025 21:41:53 +0200
In-Reply-To: <20241128110949.3672364-2-quic_rdevanat@quicinc.com> (Roopni
	Devanathan's message of "Thu, 28 Nov 2024 16:39:48 +0530")
Message-ID: <87o70ifm2m.fsf@kernel.org>
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
> Add support to request transmit rate buffer stats from firmware through
> HTT stats type 31. These stats give information such as MCS, NSS and
> bandwidth of transmit and input buffer.
>
> Sample output:
> -------------
> echo 31 > /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats_type
> cat /sys/kernel/debug/ath12k/pci-0000\:06\:00.0/mac0/htt_stats
> HTT_STATS_PDEV_TX_RATE_TXBF_STATS:
> Legacy OFDM Rates: 6 Mbps: 0, 9 Mbps: 0, 12 Mbps: 0, 18 Mbps: 0
> 24 Mbps: 0, 36 Mbps: 0, 48 Mbps: 0, 54 Mbps: 0
> tx_ol_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> tx_ibf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> tx_txbf_mcs =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, 10:0, 11:0, 12:0, 13:0
> tx_ol_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> tx_ibf_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> tx_txbf_nss =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
> tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> half_tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> quarter_tx_ol_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> half_tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> quarter_tx_ibf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> half_tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
> quarter_tx_txbf_bw =  0:0, 1:0, 2:0, 3:0, 4:0
>
> HTT_STATS_PDEV_TXBF_FLAG_RETURN_STATS:
> TXBF_reason_code_stats: 0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00214-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
> Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

