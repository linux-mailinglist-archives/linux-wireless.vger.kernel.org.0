Return-Path: <linux-wireless+bounces-13608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE5992FBD
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 16:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AAF1F23B26
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Oct 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CFF1DA26;
	Mon,  7 Oct 2024 14:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foNpH4ts"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8B18F2C3
	for <linux-wireless@vger.kernel.org>; Mon,  7 Oct 2024 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312473; cv=none; b=G/1T7NI+jTtJN3+LevuF0fiJn74FWXBBIeuWWFg9zhvmlk9IbLSQ5oaqncrmklauvre+rSmoSJWtCUcEg5rmt5Oi33CtGHibR+eRAY/7Sgf8ufp7HANEjTGFcTI/SmHHrX7UAP3lphnLjZHGLdBUIdO9DnYIQUwuHDV+b4IBxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312473; c=relaxed/simple;
	bh=kta8IrAtkDDz8HEN0uJc8OGNkCcT/daoqsaHxC+ytP0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sejk6WYeF+7KQopcEiyl+VHRCbs94gxihgzS4WwmPRJBBltbXOvkUK5VEZvPG5Y/98zKgoQR3stDojTAmIoj6iNKLvTYSuIwI3prHgs27CJ8Yd/lxQAFOm8071esLb8CNdgtBG2qChFGG2oiEhly9WDkxC5zQzPhWu/wF4ddRSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foNpH4ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5724C4CECC;
	Mon,  7 Oct 2024 14:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728312473;
	bh=kta8IrAtkDDz8HEN0uJc8OGNkCcT/daoqsaHxC+ytP0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=foNpH4tsH5efDFICChO/4CUQkKmxxdiVQO4Lab9BCGpF3oLMEijZKIXhaNlCSVIs3
	 A29o6ADurF6j4oTh2gfs2/2OmD/zD7IFZy8+b+Q/ktfvZKVqlzCQ4gzzh5sFbeYvL6
	 xAhHLFZT2VSQm9mq6K8t7D/5gMt/LwApkdPO99rXmSWyP/G3ANJ/bwNoCS1ra5go9x
	 i1Tmgh5t277aOj0x9q6voVq1ag5j2/1HiWe43ysOV4FNGa5gSb2n0doEkajzhOA09r
	 bFE+ruG+gUwDewSsUnRA9arb1F+BkhThihoBvYoO4c0P6pszuxnrdQ/QosnwUiLtf4
	 puKRqMILHBZlQ==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC v3 3/6] wifi: ath12k: switch to using wiphy_lock()
 and remove ar->conf_mutex
References: <20240924092515.1049885-1-kvalo@kernel.org>
	<20240924092515.1049885-4-kvalo@kernel.org>
Date: Mon, 07 Oct 2024 17:47:50 +0300
In-Reply-To: <20240924092515.1049885-4-kvalo@kernel.org> (Kalle Valo's message
	of "Tue, 24 Sep 2024 12:25:12 +0300")
Message-ID: <87v7y43r6x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> From: Kalle Valo <quic_kvalo@quicinc.com>
>
> Switch from using driver specific ar->conf_mutex to wiphy->mtx. The benefits are:
>
> * one lock less and simplified locking
>
> * possibility to use wiphy_work_queue() without other locks
>
> Most of the mac80211 ops are called within wiphy_lock(), most notable exception
> being tx op. This can be checked with lockdep_assert_wiphy() from
> net/mac80211/driver-ops.[ch] and I veried that by manually going through all
> the ops in ath12k_ops which had lockdep_assert_wiphy().
>
> The conversion was simple:
>
> * All conf_mutex lock() and unlock() calls which
>   already were called under wiphy_lock() I replaced with
>   lockdep_assert_wiphy().
>
> * The rest of conf_mutex calls I replaced with wiphy_lock() and wiphy_unlock().
>
> * All lockdep_asset_held(conf_mutex) calls I replaced with
>   lockdep_assert_wiphy().
>
> One exception was in ath12k_core_post_reconfigure_recovery() where the wiphy
> lock needs to be taken before hw_mutex to avoid a lockdep warning.
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

> @@ -6432,7 +6411,8 @@ static int ath12k_mac_vdev_create(struct ath12k *ar, struct ieee80211_vif *vif)
>  	int i;
>  	int ret, vdev_id;
>  
> -	lockdep_assert_held(&ar->conf_mutex);
> +	lockdep_assert_wiphy(ath12k_ar_to_hw(ar)->wiphy);
> +	lockdep_assert_wiphy(hw->wiphy);

The assert is twice, I'll fix that in v3.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

