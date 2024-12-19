Return-Path: <linux-wireless+bounces-16612-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E259F7C5B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 14:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDEDD1895D82
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FE225A4C;
	Thu, 19 Dec 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi68ooMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97B12248AB;
	Thu, 19 Dec 2024 13:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734614898; cv=none; b=P2jFX4aDY0uYaMOJCdJFaUdlLRp5A/8QHXjNqs6hRtdqLlFV1jYn8tJz86GE0w80kyyXwmfaITaf5UhnrNU5eK+z93SPEYsXBTK03P0apupxrEp4i/gjf4cqPMZEfnIiVJdXrfi5aYZ1QaO+qAfpTGRnitSns3145mwIBCNCWng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734614898; c=relaxed/simple;
	bh=aFuHqXV4I1COIteKiVGjzl7LIxkFC3/grQk59KK7cuA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=SxuJQcwtd0Vv5taWx7Eus4TL6WXCdoedO6ziCviuk5FKrIKUPd8yynkuc0bg0NhjkFRryB210oUwnSwIKpsIN2vz8WC+O1QAk3caJWtEAYSjIwQN+zHwWnYTo0Tzv0394LlawMoKsrgU83UXXU9S/LdbyrpXjOOjvZumM33YSLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi68ooMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DC1C4CED0;
	Thu, 19 Dec 2024 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734614897;
	bh=aFuHqXV4I1COIteKiVGjzl7LIxkFC3/grQk59KK7cuA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=mi68ooMeO8Y6wvx2Z/2cdbIKYqyakCHjblB4WxETas9pk9ShFYg43Fj5B4+zmJPFU
	 O52bMx7hOMAbPRsRc/puDBPuHk+ncbVfD/PuKvgQfbHQdkyv8N4rH/MzyA9xh5wnba
	 h/FOcD7Z6JukkSbzjUz9eOPdIH07GpQVS2K4id+LnW5dngGIIpR/7fewqeK9vpbTGo
	 2DKt3NIxC6d0rgKgd1jCe9b6qxi4SwkpFLLDigUVde9NJOg90EIUfTbHeOfE65Bh2b
	 oSqGxifoCwymLiexql+RhDJ6oohUgnr0A1mqN6ZkUTvnC/thpOEq20GiPtgV8/sfAx
	 2cOb0rNuyoLKw==
From: Kalle Valo <kvalo@kernel.org>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>,  <linux-wireless@vger.kernel.org>,
  <ath12k@lists.infradead.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] wifi: ath12k: fix CAC running state during virtual
 interface start
References: <20241218-ath12k_mlo_dfs-v1-0-058e783bcfc7@quicinc.com>
	<20241218-ath12k_mlo_dfs-v1-2-058e783bcfc7@quicinc.com>
Date: Thu, 19 Dec 2024 15:28:14 +0200
In-Reply-To: <20241218-ath12k_mlo_dfs-v1-2-058e783bcfc7@quicinc.com> (Aditya
	Kumar Singh's message of "Wed, 18 Dec 2024 09:11:33 +0530")
Message-ID: <87a5crhkep.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Kumar Singh <quic_adisi@quicinc.com> writes:

> Currently, the DFS CAC time and the usable state of the primary channel in
> the channel definition are used to set the CAC_RUNNING flag for the ath12k
> radio structure. However, this approach is flawed because there are channel
> definitions where the primary channel is not a DFS channel, but the
> secondary channel is. For example, in 5 GHz band, channel 36 with 160 MHz
> bandwidth. In such cases, the flag is not set correctly and hence places
> where this flag is tested will not operate as expected. For example, Rx
> packets will not be dropped.
>
> To fix this issue, use the cfg80211_chandef_dfs_usable() function from
> cfg80211, which returns true if at least one channel is in a usable state.
> This will ensure the CAC_RUNNING flag is set properly.
>
> Additionally, update the CAC running debug log message to include the CAC
> time in milliseconds and also print the center frequency segment 1.
>
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

