Return-Path: <linux-wireless+bounces-3384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0EF84F2FD
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 11:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57CD22870D4
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 10:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0F767E87;
	Fri,  9 Feb 2024 10:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vGUlxuX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32D67E84
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707473567; cv=none; b=k29j2v+AfqIqD1/QeGX2Lpt9Lbfrt0s2Y7ZZWssJV1LSBzB9LmDRR8shbuRCsfQWEbhh4cG7GzS+WeA+uKVJE6pGmr2L+80gYHmdLPgdjxYmDlz26uQfZpHcD7FxX5KZL4+FOg/IKlqvvPHvODkEJuOdowsIARPHtsoFSK1gS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707473567; c=relaxed/simple;
	bh=m/Ioyes5yrICnVycteB2uRJv/WQnHgJIFWkW/s4fuDg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=LwTq9cW5dLqIpPHEG6FF/1XSN3xq2T/y5rej7KU7LIJSxEiIgL5xBT6UMxYsUWI7ZB/vA+LYLMCw13z/hC6glDOztZB6iyz7HCVlxU4IRkxJJZApEyi2zyEelSK65ZP41D5y8ZHzfewRiTZRfGDdf72RewN30xOQHYC7yg2a18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vGUlxuX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E722AC433F1;
	Fri,  9 Feb 2024 10:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707473566;
	bh=m/Ioyes5yrICnVycteB2uRJv/WQnHgJIFWkW/s4fuDg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=vGUlxuX1OdonFAVzfZ213gPef8sxWeLo4PbBTsbwDRjL+1NUifdntMm+a4slkjBpV
	 aIcwjhUr8hRlFMGkV5ECueKZR/ZfPTl9Ryo0z0ByFR1fS+ToVJNwcOq1DhcwKZwDud
	 Fnmvd3hn2pMukRpgo/eb5ILF4r74NIipXu7JqnKP1Yehb1GPeHdd2faKGDL8T01jwJ
	 NuvzRu9HYPsGAp+/0goPDwMWSn9fwJu0Q3Ot4Xd6k1CLUDRAGUnKu4zXGKKMpb/OOT
	 BtUp4VGWQU5lsLa8cLyN/ByEomUVcCvcuoQXg0PcSAW237UFGrfy9AmoSbNQ7nNVds
	 AoUBQjPczEa4Q==
From: Kalle Valo <kvalo@kernel.org>
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: Refactor hardware recovery synchronous
References: <20240130060838.3895599-1-quic_periyasa@quicinc.com>
	<20240130060838.3895599-3-quic_periyasa@quicinc.com>
Date: Fri, 09 Feb 2024 12:12:43 +0200
In-Reply-To: <20240130060838.3895599-3-quic_periyasa@quicinc.com> (Karthikeyan
	Periyasamy's message of "Tue, 30 Jan 2024 11:38:37 +0530")
Message-ID: <87sf22osis.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> Currently, in multi wiphy models, radio/link level synchronization is
> sufficient for MAC hardware (ieee80211_hw) reconfigure/recovery procedures
> since each radio/link is exposed as a MAC hardware (ieee80211_hw). However,
> in single wiphy models, multiple radio/links is exposed as a MAC hardware
> (ieee80211_hw) through the driver hardware abstraction (ath12k_hw) layer.
> In such scenario, we need synchronization between the reconfigure/recovery
> callback operations (i.e., ath12k_core_post_reconfigure_recovery(),
> ieee80211_ops->start(), ieee80211_ops->reconfig_complete(),
> ieee80211_ops->stop()) at the driver hardware abstraction (ath12k_hw) layer
> instead of radio/link (ath12k) layer. Therefore, introduce a new mutex in
> the ath12k_hw layer. This approach ensures compatibility of the hardware
> recovery procedure with both multi wiphy models and future single wiphy
> models.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

[...]

> --- a/drivers/net/wireless/ath/ath12k/core.h
> +++ b/drivers/net/wireless/ath/ath12k/core.h
> @@ -600,7 +600,12 @@ struct ath12k {
>  struct ath12k_hw {
>  	struct ieee80211_hw *hw;
>  
> +	/* To synchronize hardware restart operation */
> +	struct mutex conf_mutex;

As we discussed already offline, there's a high bar for adding new
mutexes. I would rather remove the existing conf_mutex than add a new
one.

Also having two mutexes named 'conf_mutex' in the same driver is risky,
it would be very easy to confuse the two.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

