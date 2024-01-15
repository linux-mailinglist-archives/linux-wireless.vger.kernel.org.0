Return-Path: <linux-wireless+bounces-1938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F88082DC86
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAE581F2247A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44A317C98;
	Mon, 15 Jan 2024 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNumTzzg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09F17C97
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 15:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88159C43390;
	Mon, 15 Jan 2024 15:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705333318;
	bh=K9G1atDFEt7CyyLz6rqv/1ZDMZxiGJZ4BwS+d5OtP84=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=nNumTzzgyv12/X6toNlinVCbzDL6EOVw1z+41vT1BVlHJwCbHuIdzabBuiOlrNyxL
	 hYrBqNk6mKlDxByDMubGw/JkhVmiD+xn6m9X8JnU2aiVztdR/1gkLSI357W1sJPIKU
	 79NFiQMdNfGh/p1OYDQlcQaIco2bvlSV6NwfDWkK3YpnoCGX0fTwkRTsUB/kC8hXzZ
	 TwgVtJ2CAmNOdPo5QxtnO/HQaWrl8UGO1V+WtUR5COp713xMSJHInTfxlb4lFF//WQ
	 UnbPHG0iy1+deTFLwfGoIK2gNxOg+8IkN5n2qA7FDgGU50kBLOms6IqS3w8KnOrVtC
	 Xg3lUzsZSd6Hg==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/2] wifi: ath12k: Introduce the container for mac80211 hw
References: <20240109051252.3325106-1-quic_periyasa@quicinc.com>
	<20240109051252.3325106-3-quic_periyasa@quicinc.com>
Date: Mon, 15 Jan 2024 17:41:55 +0200
In-Reply-To: <20240109051252.3325106-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 9 Jan 2024 10:42:52 +0530")
Message-ID: <87mst67ge4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> To support multi link operation, we need to combine all the link/pdev
> under a single wiphy. This avoids the overhead of synchronization
> across multiple hardware instances in both the cfg80211 and mac80211
> layers. Currently, each link/pdev is registered as separate wiphy,
> tightly coupled with link/pdev/radio (ar) structure. To enable single
> wiphy registration within the chip, we decouple the wiphy data entity from
> the link/pdev/radio (ar) structure and move it under the chip (ab)
> structure with a new data container (ath12k_hw) structure. This approach
> improves scalability for future multi link operation support.
>
> 		mac80211 hw private data structure diagram
> 		------------------------------------------
>
> 	Now						After
>
>  +---------------------+                          +---------------------+
>  |mac80211 hw priv data|                          |mac80211 hw priv data|
>  |                     |                          |                     |
>  |                     |                          |                     |
>  |                     |                          |                     |
>  |                     |                          |   ath12k_hw (ah)    |
>  |                     |                          |                     |
>  |                     |  +------------------->   |                     |
>  |    ath12k (ar)      |                          |   +-------------+   |
>  |                     |                          |   |             |   |
>  |                     |                          |   | ath12k (ar) |   |
>  |                     |                          |   |             |   |
>  |                     |                          |   |             |   |
>  |                     |                          |   +-------------+   |
>  |                     |                          |                     |
>  |                     |                          |                     |
>  +---------------------+                          +---------------------+
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

[...]

> @@ -3790,6 +3831,10 @@ static int ath12k_mac_op_sta_state(struct ieee80211_hw *hw,
>  	     new_state == IEEE80211_STA_NOTEXIST))
>  		cancel_work_sync(&arsta->update_wk);
>  
> +	mutex_lock(&ah->conf_mutex);
> +
> +	ar = ath12k_ah_to_ar(ah);
> +
>  	mutex_lock(&ar->conf_mutex);

Do we really need two mutexes? I don't see any analysis about that. And
even if we do, I feel that it should be added in a separate patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

