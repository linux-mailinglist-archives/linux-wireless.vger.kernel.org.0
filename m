Return-Path: <linux-wireless+bounces-10267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525349329CE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 17:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA919282482
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223E0195B27;
	Tue, 16 Jul 2024 15:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOvJDmo7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3211DFF0;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721142033; cv=none; b=gk2bynEGOpjHbumCP2CqT65QOiTGG73N+Y6fpPlY9UqNiurs9VhshIdXKPCQ8NPOBjuf2modphHYKMzVzxpchi5NoP332oljdDq642g5znIfHaOOVt8h5AHUhUU8z75YZDjEJH31K51AU+51Kfw6S+ChUfzngW6x44usOPnJ7m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721142033; c=relaxed/simple;
	bh=uYe9BapfTsJ13P9ZljegPThBOOGzlgPGt1rLPJq/+iA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GHM7RnVl+GxN7Gc1/zX2H+o0i5oA1sT/d7mfuvW8gybJw7iv+9Pq4QTfhLxCqKwMK1SlGqcSwz3ApJjgzQTSPo8sRhwRRhe06Ra2FOxX9+Uq0ibK3iNFoquLWcx1KHVsndsiOJ3s8lpVKCJvsc+AmTr+O2C3aLo3LjIuWJoRNFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOvJDmo7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C951C4AF0F;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721142032;
	bh=uYe9BapfTsJ13P9ZljegPThBOOGzlgPGt1rLPJq/+iA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cOvJDmo7Qo70vfoKH3LCj/Ay/cisN3fWNCwNH0Cd1pillnKj36xafDzm8FuB6/e1+
	 Q5SXcRZIBntMt0ZAPoxnbPUd+90npTYrGvMOg0P7T5aeSVzHJAcUch61tBNIpOMCYx
	 OPs6JPrcihbJDcf6W5hHcrw3AKFiadlgdQzLBsUW0cuIX0EuhbPUQ3bDVQoMd+d1gd
	 PYa15i9dStUmwngKdM0dmNwiMl4EaOkXMZ51bDCTcLt30DInNRJiS/gBaxTNJtgM/h
	 4tB8/IM/kq7gUz1bEWgyq5EhXAELw14P/85v8tW4mDX1Pwn41mCphca2VPkP+KQAQz
	 mUFS6A7NonKYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6616DC43443;
	Tue, 16 Jul 2024 15:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] wifi: ath12k: fix build vs old compiler
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172114203241.4794.15315713329706160319.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jul 2024 15:00:32 +0000
References: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
In-Reply-To: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kvalo@kernel.org, jjohnson@kernel.org,
 quic_bqiang@quicinc.com, linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jul 2024 13:06:39 +0200 you wrote:
> gcc 11.4.1-3 warns about memcpy() with overlapping pointers:
> 
> drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>   637 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
>   190 |                         memcpy(pat, eth_pat, eth_pat_len);
>       |                         ^~~~~~
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>   637 |         __underlying_##op(p, q, __fortify_size);                        \
>       |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
>       |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
>   232 |                         memcpy(pat, eth_pat, eth_pat_len);
>       |                         ^~~~~~
> 
> [...]

Here is the summary with links:
  - [net] wifi: ath12k: fix build vs old compiler
    https://git.kernel.org/netdev/net-next/c/b49991d83bba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



