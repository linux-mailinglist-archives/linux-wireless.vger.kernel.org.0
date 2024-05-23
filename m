Return-Path: <linux-wireless+bounces-8010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC858CD3A1
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 15:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59977B21551
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C114B084;
	Thu, 23 May 2024 13:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="emYKTxdu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC9014B083
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470217; cv=none; b=tllNAi3gLEefjO2/ORu9p+l98rEu/4XFtRRV/CLbbtj4PrQRP3uLLMEKYQJK11R5VAsTvZllzg82UDabvylbBOLOhY+aR1HN4PEOu3drSrKnQ8m/oiHg4trwD+UlbJpJKuHE8PA3eJX8FyZ1Jl+lA3b3eompwcPRGlPznjUs20E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470217; c=relaxed/simple;
	bh=J5sH+IM11mBCk3fnWcNmwtCQ+GTlbAmt2HVgytd/hmc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=gOY5ETIX04m1d5UN8jrH329HqMXemFGIAC7UHZ5RUwSCb43BegfgZt+yWgVA1VA2/E79/Zyi7Enm6KbiObIvyi2m8VZckpuDP2w7o30cmJlMnl04gy6sB2F/PC7u5Dkph21tNJA/EqDUNVxPcCquiqge6pRJ35CYLXkhBenbCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=emYKTxdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011B4C2BD10;
	Thu, 23 May 2024 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716470216;
	bh=J5sH+IM11mBCk3fnWcNmwtCQ+GTlbAmt2HVgytd/hmc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=emYKTxduxBpDO12T2xwVodY7YjreMBh9rc90N+1HiMMwq4BYKuneR4jiSMezbRv+v
	 eshWiyqm5GVTsJPBPmqxGQh0B0luEo4WppDy3h66d0KQGNF+vhsQ/OCUnoCa24FUj4
	 vQYufD+/mAT2lAtLQ6Vj+ARuiYHetzdhldo6dYes+1VWrevYXybWaWPOGjsi46iQ2S
	 U4IkV5UqqdiVqsI4RMsMP1hy4dAAlmZ+q6ZJClVen3EvvsMP9RP9qAlubqlTSv97yf
	 QIwbHhwH/+FE5uWJo6Bd2NcoZNdvyMlFkvIWInExWEePPzsIsXIIzyr4UEVrlTO6LL
	 CkhRJFjA2HeXw==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath12k: improve the rx descriptor error
 information
References: <20240516000807.1704913-1-quic_periyasa@quicinc.com>
	<20240516000807.1704913-3-quic_periyasa@quicinc.com>
Date: Thu, 23 May 2024 16:16:53 +0300
In-Reply-To: <20240516000807.1704913-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Thu, 16 May 2024 05:38:07 +0530")
Message-ID: <87a5kgbrcq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> The ath12k_dp_get_rx_desc() failure log currently contains the same
> information across multiple Rx data paths and lacks sufficient detail for
> debugging purposes. To address this, change the ath12k_dp_get_rx_desc()
> failure log to include cookie information along with Rx path details.
> This will provide more specific data for debugging purposes.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 HW2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> ---
>  drivers/net/wireless/ath/ath12k/dp_rx.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
> index 37205e894afe..85ce6e840efa 100644
> --- a/drivers/net/wireless/ath/ath12k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
> @@ -2625,7 +2625,7 @@ int ath12k_dp_rx_process(struct ath12k_base *ab, int ring_id,
>  		if (!desc_info) {
>  			desc_info = ath12k_dp_get_rx_desc(ab, cookie);
>  			if (!desc_info) {
> -				ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
> +				ath12k_warn(ab, "Rx, invalid cookie 0x%x\n", cookie);
>  				continue;
>  			}
>  		}
> @@ -3323,7 +3323,7 @@ ath12k_dp_process_rx_err_buf(struct ath12k *ar, struct hal_reo_dest_ring *desc,
>  	if (!desc_info) {
>  		desc_info = ath12k_dp_get_rx_desc(ab, cookie);
>  		if (!desc_info) {
> -			ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
> +			ath12k_warn(ab, "Rx Exception, invalid cookie 0x%x\n", cookie);
>  			return -EINVAL;
>  		}
>  	}
> @@ -3742,7 +3742,8 @@ int ath12k_dp_rx_process_wbm_err(struct ath12k_base *ab,
>  		if (!desc_info) {
>  			desc_info = ath12k_dp_get_rx_desc(ab, err_info.cookie);
>  			if (!desc_info) {
> -				ath12k_warn(ab, "Invalid cookie in manual desc retrieval");
> +				ath12k_warn(ab, "WBM Rx err, invalid cookie 0x%x\n",
> +					    err_info.cookie);
>  				continue;
>  			}
>  		}

In the error messages please try to use full english sentences to make
them at somehow useful to users. I tried add those now, please check:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=4033754ea78119ede328f09005b8ae1e9dd3f4f2

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

