Return-Path: <linux-wireless+bounces-10132-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA9192C266
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 19:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADBCE1C2308E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jul 2024 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19155158873;
	Tue,  9 Jul 2024 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtDY+Xgy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0E3D967;
	Tue,  9 Jul 2024 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546028; cv=none; b=gu8a//c6acMWw0TTP7gCyO4izCdBFfYO8GJzYYBnOak4Rimmx0tMksnsgLP1pEZ/13dfV0oMbFBsXn3wEEUYc5+hDzgkqgHFBZB1YGjiDbEmCei09isRBkaxc6DI0jG6emNsS6h7QlrLjHXRlAbfZSj2WZMWiMmTXesxpEiGCYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546028; c=relaxed/simple;
	bh=fRD0QtuTFpWTIbbNvqJ42bfrkfmvGDAk+6WRXY40IxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEchAebVnAdxz2bCu219aiM7r/9DGjI4hySIFbP8/x2Q2UtrqTvlcBDP//WQPclsRoYK/2scdPYhBmwd5J4wfOyxc6i831MitPp91hwa5qHs0lXex6GdwxYIh2CFBzWdzVZZL+RMNtc4SwA7OUKAmhOamn5QkR8JjFyCpqaHMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtDY+Xgy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B6FC3277B;
	Tue,  9 Jul 2024 17:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720546027;
	bh=fRD0QtuTFpWTIbbNvqJ42bfrkfmvGDAk+6WRXY40IxQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=PtDY+Xgybjud64Zo0AKzyeiTuQ+p43u9Yf7/WkHV3BQsFFeIsF8Vs83/oJv2uTW1L
	 zc0KjhRqmbrVrGQ7H8l2RwneDn9PCdzIanz3rQRo0vzyKDjOHW5rDAiuHYp10cke9F
	 LX5oYh6KMdk8UbvO5Gi7Q6/IjpEtBSGuBqR5rcgcmCIYDr7Oo/U8UjpYKIv4rV+abg
	 Ob01G2gzGkHi3gLaVjlduy5tiSynXRB2KA/cCgbmlP6ZLGoSA9mz5b4RL5vBlJJfUB
	 m5oXDsBWtaPCZmAZmghAaverqMwGsMxkHKjVyAz68jYmMKzQ/WovxgVukWTuJ+XLyU
	 Mkx8Ej3u5IkuQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2CE02CE0A45; Tue,  9 Jul 2024 10:27:07 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:27:07 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
	kees@kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: ath12k: workaround fortify warnings in
 ath12k_wow_convert_8023_to_80211()
Message-ID: <241ec41b-c37a-46e2-bf28-9e18130ea4ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240704144341.207317-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240704144341.207317-1-kvalo@kernel.org>

On Thu, Jul 04, 2024 at 05:43:41PM +0300, Kalle Valo wrote:
> From: Kalle Valo <quic_kvalo@quicinc.com>
> 
> Johannes reported with GCC 11.4 there's a fortify warning below. The warning is
> not seen with GCC 12.1 nor 13.2. Weirdly moving the other operand of sum to the
> other side the warning goes away. This is safe to do as the value of the
> operand is check earlier. But the code looks worse with this so I'm not sure
> what to do.
> 
> In file included from ./include/linux/string.h:374,
>                  from ./include/linux/bitmap.h:13,
>                  from ./include/linux/cpumask.h:13,
>                  from ./include/linux/sched.h:16,
>                  from ./include/linux/delay.h:23,
>                  from drivers/net/wireless/ath/ath12k/wow.c:7:
> drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>   637 |         __underlying_##op(p, q, __fortify_size);                              |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                        |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
>   190 |                         memcpy(pat, eth_pat, eth_pat_len);
>       |                         ^~~~~~
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
>   114 | #define __underlying_memcpy     __builtin_memcpy
>       |                                 ^
> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
>   637 |         __underlying_##op(p, q, __fortify_size);                              |         ^~~~~~~~~~~~~
> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                        |                          ^~~~~~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
>   232 |                         memcpy(pat, eth_pat, eth_pat_len);
>       |                         ^~~~~~
> 
> Compile tested only.
> 
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

(Also compile retested, for whatever that is worth.)

This still shows up in allmodconfig next-20240709 builds.

						Thanx, Paul

> ---
>  drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
> index c5cba825a84a..e9588bb7561c 100644
> --- a/drivers/net/wireless/ath/ath12k/wow.c
> +++ b/drivers/net/wireless/ath/ath12k/wow.c
> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>  	if (eth_pkt_ofs < ETH_ALEN) {
>  		pkt_ofs = eth_pkt_ofs + a1_ofs;
>  
> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
> +		if (eth_pat_len < ETH_ALEN - eth_pkt_ofs) {
>  			memcpy(pat, eth_pat, eth_pat_len);
>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>  
> @@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
>  	} else if (eth_pkt_ofs < prot_ofs) {
>  		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
>  
> -		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
> +		if (eth_pat_len < prot_ofs - eth_pkt_ofs) {
>  			memcpy(pat, eth_pat, eth_pat_len);
>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
>  
> 
> base-commit: c1cacb01f35589bd41360cdb7535afc792c08a7c
> -- 
> 2.39.2
> 

