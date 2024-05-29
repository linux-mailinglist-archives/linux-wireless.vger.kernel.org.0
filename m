Return-Path: <linux-wireless+bounces-8277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DC68D3DC8
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 19:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C645287FCE
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 17:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118EF15B551;
	Wed, 29 May 2024 17:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrWVtk6z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF055DDA1
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 17:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717005311; cv=none; b=Fbul8yoo5N4OeI0ESud9ZRLTTcONjvm1AG5RFNFFjJ9lfMn4IwY+rGkGLUOmaWBrjwFIC8/IDLMYakvdHYZ3QHX2Bz+RtoSil7QkClEAbt6tiPRL63PJioWGHF66N7K38TRBbH+tc1s2FwXy8cXgBLRgoGW3xCEQlIfgllbeFXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717005311; c=relaxed/simple;
	bh=fbsACgXOaS6r9JjfiBziDzgumtxSq46X0N+/fT+6TAk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m+lJkRg/lKdUYjD3remcAvwl6fi6Zfw3YQYp5SKVAUHUvngiRcSTn0SPwOjbYQTmndsbcPCLdl400GAJFpgKH035xKKaiBL4VwYtkMZm2cyGsikbGirOeBgxImoGO118QhJ+86A3YoR7s8Vxd4YDCCZLsLt0aMaI2gTWNmng650=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrWVtk6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB11C113CC;
	Wed, 29 May 2024 17:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717005310;
	bh=fbsACgXOaS6r9JjfiBziDzgumtxSq46X0N+/fT+6TAk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JrWVtk6zNNHuyf+pKQbeT0+Nvny6kOlslLoWjVNlNFEtVU1uj+oLPsCHZ+hh8KH6F
	 8sZOKKQ6yvoz6GAAZRgHHDrhmu/aWSmsTK7CbtOdNs74RXQ3k6R4fq4Z+CLmIeBwId
	 Xr8FDCsIyiCJVt6ZDfzAGQIDGXrY9shc9pdxPdZEpQrUrwcVINsvv5gazrVSORhu0Z
	 B24HVvD4YEhYzsSYWgDhP+A4RL7TaI6pJzqzfmnwk49giiE4IAVesUgYnYyTNelDUJ
	 JImGnZ6AYXt8b4zGBC2z9N3iQmX7KXLoSZ5A7pvPt8k9Z7FsLAuexyt1WsjhXCAb2H
	 +ehC2tsvZGflw==
From: Kalle Valo <kvalo@kernel.org>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
  Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: [PATCH] wifi: rtlwifi: Ignore IEEE80211_CONF_CHANGE_RETRY_LIMITS
References: <1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com>
Date: Wed, 29 May 2024 20:55:07 +0300
In-Reply-To: <1fabb8e4-adf3-47ae-8462-8aea963bc2a5@gmail.com> (Bitterblue
	Smith's message of "Wed, 29 May 2024 20:19:47 +0300")
Message-ID: <87o78omrk4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:

> Since commit 0a44dfc07074 ("wifi: mac80211: simplify non-chanctx
> drivers") ieee80211_hw_config() is no longer called with changed = ~0.
> rtlwifi relied on ~0 in order to ignore the default retry limits of
> 4/7, preferring 48/48 in station mode and 7/7 in AP/IBSS.
>
> RTL8192DU has a lot of packet loss with the default limits from
> mac80211. Fix it by ignoring IEEE80211_CONF_CHANGE_RETRY_LIMITS
> completely, because it's the simplest solution.
>
> Link: https://lore.kernel.org/linux-wireless/cedd13d7691f4692b2a2fa5a24d44a22@realtek.com/
> Cc: stable@vger.kernel.org # 6.9.x
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Ping, should this go to v6.10? If you agree, ack and assign it to me on
patchwork. I'll then take it to wireless tree.

But feel free to take it to rtw-next as well, your call.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

