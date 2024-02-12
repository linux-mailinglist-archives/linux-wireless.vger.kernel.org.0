Return-Path: <linux-wireless+bounces-3463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3C685183A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 16:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BAE01C211C7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 15:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240373C47A;
	Mon, 12 Feb 2024 15:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8RtITPZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F42083C478
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752250; cv=none; b=SzbQGMnQt7n3LB/It6NrL88LKp1UuNgZv/5O0lVl1AF+49jA2LUYWu9N520B/y9N+T8d9Pa8077K/5e7HuWPOdlZAvdKTDTLD+DI+1N4f8lwipXWBaEvQyuvSUl+nXa3QSqfp4J/9Srt9ueyMGbT0w2dp9XjwkIzBeN52LdQnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752250; c=relaxed/simple;
	bh=d+o2IrXtBU5bXLNNCf0XAj0ZsPXDy2HjR0M+jym32dM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=TkYzJOWeMGBS+542RRbPpGwh60lR2HV7734zp7dZ0YSlp3okNa7BUE0y+pt89W9zYp2jthTewHqy8s0Jh5YPL9Fc5gpj1cjMjHDqdlIDLjvIMkQCYjVt0iHhW6N7nsXKyT8fkgxEwEKrlCMEsaqSPUT1vK0IYS4pkoGrbI86Re8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8RtITPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8B4C433C7;
	Mon, 12 Feb 2024 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707752249;
	bh=d+o2IrXtBU5bXLNNCf0XAj0ZsPXDy2HjR0M+jym32dM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=e8RtITPZYbQSLwE5YGwwqxWXC+i1HFaDudRYSC7Nin/XavwmIGK+T/UMX3s2ILNYI
	 m5OKc+wa+p0CfLvm0DmmZh7gH+qSqsAVtl5n7HkJ5oZgE/RW4rT6H3iwlWq3bWH0X8
	 0YYEv7ulkqlNFu1wF9t3KfMVcsOnLdPZLnVVWvludprHsP5kSStaPD4DNVgvE225b2
	 bfENaEri56lLzARpougJ81JYpLm3MIqrher5/WXV2oqxdhZUzbBJ7mJzHqa8Wo821y
	 Rw8OGpirtLgxSAKXPsfiO/LXg88sFgA1z95ZIpeiGennf8/j1eOeCL4SRrwbgSfna/
	 h3i6i5I9grKTA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/6] wifi: rtw89: drop TIMING_BEACON_ONLY and sync beacon
 TSF
 by self
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240206030624.23382-2-pkshih@realtek.com>
References: <20240206030624.23382-2-pkshih@realtek.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170775224670.2851594.13780000075047390270.kvalo@kernel.org>
Date: Mon, 12 Feb 2024 15:37:28 +0000 (UTC)

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Some of our calculation during concurrent mode depend on last beacon
> TSF. Originally, we just set IEEE80211_HW_TIMING_BEACON_ONLY and get
> what we want from mac80211. But, IEEE80211_HW_TIMING_BEACON_ONLY will
> be restricted once we declare MLO.
> 
> Since we are about to consider the MLO stuffs, so sync beacon TSF by
> ourselves now and unset IEEE80211_HW_TIMING_BEACON_ONLY.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

188045a85614 wifi: rtw89: drop TIMING_BEACON_ONLY and sync beacon TSF by self
4f0beeefcce8 wifi: rtw89: chan: add sub-entity swap function to cover replacing
ab12a3bfbf77 wifi: rtw89: chan: tweak bitmap recalc ahead before MLO
d79fa0a6d8c2 wifi: rtw89: chan: tweak weight recalc ahead before MLO
1ae9fbaf22ee wifi: rtw89: chan: move handling from add/remove to assign/unassign for MLO
162bf67f74c7 wifi: rtw89: chan: MCC take reconfig into account

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240206030624.23382-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


