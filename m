Return-Path: <linux-wireless+bounces-1940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D425182DD0A
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 591DCB21994
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 16:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7E118048;
	Mon, 15 Jan 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKWrPwW8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5265D18044
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 16:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE97C433F1;
	Mon, 15 Jan 2024 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705334926;
	bh=7JwWw9vE0E8HLaR/TPGGpX/7XTNaoCGleSmriAkMXs4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=WKWrPwW85JftTLzf4E6iOSz8VdUPsbXPTClItYFAq1JOhvDUgCkLvIYuXBW67f/gD
	 75KkoSOMGQVKxRAaKwqIuvcqXtoBzKtzUuZaKvH1ChodBj8i91rXZF75CXtvVsi/Ae
	 NM4mf0w2nkmv/F3kAEa4G1dQWPekkDkr1WHo7MyyeOYmGLFYN4a9bzAerYwUoHRRO/
	 aYS9cvDZ2tPeP2NYL/BT0WkJgQ8w+YLOC0o88N6jCuh1hVJZh8DA7xGusxCm8YYg9E
	 nQEVcJZ/xf1eJvwWfDvMft9mBwylUwHfArbA6WR9okToCB8LPUVUZ9yv8ZnO/172Ve
	 IVjT0fr1zV7/w==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] wifi: ath12k: Introduce the container for
 mac80211 hw
References: <20240112024214.3481840-1-quic_periyasa@quicinc.com>
	<20240112024214.3481840-3-quic_periyasa@quicinc.com>
Date: Mon, 15 Jan 2024 18:08:43 +0200
In-Reply-To: <20240112024214.3481840-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Fri, 12 Jan 2024 08:12:14 +0530")
Message-ID: <87bk9m7f5g.fsf@kernel.org>
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

What about struct ath12k_pdev? Do we need it still or should it be removed?

>  static void ath12k_mac_op_cancel_hw_scan(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif)
>  {
> -	struct ath12k *ar = hw->priv;
> +	struct ath12k_hw *ah = ath12k_hw_to_ah(hw);
> +	struct ath12k *ar;
> +
> +	mutex_lock(&ah->conf_mutex);
> +
> +	ar = ath12k_ah_to_ar(ah);
>  
>  	mutex_lock(&ar->conf_mutex);
>  	ath12k_scan_abort(ar);
>  	mutex_unlock(&ar->conf_mutex);
>  
> +	mutex_unlock(&ah->conf_mutex);
> +
>  	cancel_delayed_work_sync(&ar->scan.timeout);
>  }

Do we really need two mutexes? I don't see any analysis about that. And
even if we do, I feel that it should be added in a separate patch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

