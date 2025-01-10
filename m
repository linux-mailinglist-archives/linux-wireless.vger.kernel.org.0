Return-Path: <linux-wireless+bounces-17319-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EFEA09116
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F0BA7A03ED
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FFE20D515;
	Fri, 10 Jan 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQN0FONr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992D920D512
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jan 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513364; cv=none; b=a4X9YaqXwan366nH2m1Zinpbj2PzHndILoTY12CEybVfQxvhYbaDU1NE4omyVln3BhX4IPmBKRF9s+8pkvSfyNH0ZeZpuFWfmESC/BDTYI8mdKf/CvHU4APhLXQhQUoUESssUI9BIbguFEkQwyx69S8shoX8ef6PXckBteAahpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513364; c=relaxed/simple;
	bh=BjaxqsFW2eQHamCUWl9fBBDyR52alehPuwO+5heraW0=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=MH0+lfW62fXmpXkdfCJboLpQwMsOYuVXXkiaKre89fODMNh4IdLqrCOvY3PCi3INq55mrPKASBAbdS923yQH8Xq9XiVY3cDRk4kEOq/+B0dZQaoobu1+BIkU3pjN78GB38jgIZJtF/zc0x5D7llPKZIvvX5YXfeNEHLefkRWR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQN0FONr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472C8C4CED6;
	Fri, 10 Jan 2025 12:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513364;
	bh=BjaxqsFW2eQHamCUWl9fBBDyR52alehPuwO+5heraW0=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=vQN0FONrdiMgW+YF1saub6sGHrYO/UQGL/4xo8EJMcFNgfmuW5wT8zyn2djT81LU3
	 N/XarL24f6PYnY+PYvW/TsyGG/XNZnOmKES9D6smkk+0fGD1vWTT/46W9iC4x1dcKq
	 lsXAfQalHC+pBwYC8wfp+dEMU8AvqITXXJfrCAdg9FmxKC5DnwDEFntWVQY20wo6qC
	 x0GcZJDQnTLCQ3te3E/Trbh7UcEQkU2/ZHK5i70r4EQWKRwY7FXme4kMBmPLbu7H9S
	 v9MIBIRyMauXyd8kdhkV7a/wZQvn7iKRBOePQHk312Kj3xXrYD7rHLJjBpAnlpz/Mb
	 t8atha4Gx2BYw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless] wifi: mt76: mt7996: fix invalid interface
 combinations
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241007135133.5336-1-shayne.chen@mediatek.com>
References: <20241007135133.5336-1-shayne.chen@mediatek.com>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 "Ryder Lee" <ryder.lee@mediatek.com>, Evelyn Tsai <evelyn.tsai@mediatek.com>,
 linux-mediatek <linux-mediatek@lists.infradead.org>, Frank Wunderlich
	<frank-w@public-files.de>, Shayne Chen <shayne.chen@mediatek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651336034.72755.11718043686484576915.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 12:49:22 +0000 (UTC)

Shayne Chen <shayne.chen@mediatek.com> wrote:

> Setting beacon_int_min_gcd and NL80211_IFTYPE_ADHOC in the same interface
> combination is invalid, which will trigger the following warning trace
> and get error returned from wiphy_register().
> 
> [   10.080325] Call trace:
> [   10.082761]  wiphy_register+0xc4/0x76c [cfg80211]
> [   10.087465]  ieee80211_register_hw+0x800/0xac4 [mac80211]
> [   10.092868]  mt76_register_device+0x16c/0x2c0 [mt76]
> [   10.097829]  mt7996_register_device+0x740/0x844 [mt7996e]
> 
> Fix this by removing unused adhoc iftype.
> 
> Fixes: 948f65249868 ("wifi: mt76: mt7996: advertize beacon_int_min_gcd")
> Reported-by: Frank Wunderlich <frank-w@public-files.de>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> Tested-By: Frank Wunderlich <frank-w@public-files.de>

Patch applied to wireless-next.git, thanks.

89aca45f2687 wifi: mt76: mt7996: fix invalid interface combinations

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241007135133.5336-1-shayne.chen@mediatek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


