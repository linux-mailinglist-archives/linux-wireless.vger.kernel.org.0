Return-Path: <linux-wireless+bounces-9994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E11E2927F22
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 01:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0044B22E5B
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 23:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B59143867;
	Thu,  4 Jul 2024 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMY9OE+Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF274143748
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jul 2024 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720135504; cv=none; b=d9itMUECDkWldLbaDGznMUgZn+1I1NawAOFg1T+n23fMJxQ/tht6J99zAZZGgtKBeo8NL15RdQTDNg4Btgj7X2ylTN2su1c3K99zg9RLKXazKVp0N2ZLtVdo14fTRKPvu+R7bI6TxJW8ofBEPlaYe9lnOGirCIya9OCSLsS3TWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720135504; c=relaxed/simple;
	bh=h/MhLT48xCMPodi/QfEIU2H8ZaCUdDmFDJhZGxscQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhxrAyH+QW9X36pzN3B0yHSGqayHw/kUqgFho6lg5//TE1dco//EbbGj6zYOM/dkbVD3QD3O9P+6zDDQXK1ZA6SlbNHGafMDaVFIAOh9F7uJrifrdrn+8dGfwgZCV6IZyoDhCRnwZjYV7VBk3wqHCcxa57PldkC+6z+yNa3RAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMY9OE+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D23C3277B;
	Thu,  4 Jul 2024 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720135504;
	bh=h/MhLT48xCMPodi/QfEIU2H8ZaCUdDmFDJhZGxscQw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mMY9OE+YBKmII3oiZLlmhKJuwEya5BjSfhAMfeQoUj9UzeanyfjO0yQcrc7dxSCl2
	 6hKiPb/dS/dVWO8vcxHPguE4i6N/DCMni7SfThs4k6P3qy37woRZVl9wAsOvSeE5rJ
	 p5zuwut+XosjVlrYQLNcOJpNKD7zxnfHg5ikOe0UPIIrIxVDDO9Cl4/tI745nxGAe0
	 HDw/Xwv14HrWbEAWku7HKZJ5J6mS41QtSMJL2cxrrcwVIOGS/bob0frJXrKIB3+KD9
	 sGlJxiOCTcQs9tdVXzkrmQJIid7CE4bEibxeVoJLe/ff5ORFwa7php5N/WriA8umZ9
	 y+VHa+xIVvvDA==
Date: Thu, 4 Jul 2024 16:25:03 -0700
From: Kees Cook <kees@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: ath12k: workaround fortify warnings in
 ath12k_wow_convert_8023_to_80211()
Message-ID: <202407041551.1DC8C03D@keescook>
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

FWIW, this isn't fortify, but -Wrestrict. I would expect the same
warnings even with CONFIG_FORTIFY_SOURCE disabled. Regardless, it's
worth figuring out what's going on. It looks like this is GCC's value
range tracker deciding it sees a way for things to go weird.

I suspect they fixed -Wrestrict in later GCC versions. It might need to
be version-limited...

> In file included from ./include/linux/string.h:374,
>                  from ./include/linux/bitmap.h:13,
>                  from ./include/linux/cpumask.h:13,
>                  from ./include/linux/sched.h:16,
>                  from ./include/linux/delay.h:23,
>                  from drivers/net/wireless/ath/ath12k/wow.c:7:
> drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]

These huge negative values imply to me that GCC is looking at some
signed values somewhere.

> [...]
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

Both eth_pkt_ofs and eth_pat_len are size_t. ETH_ALEN isn't, but it
would be promoted to size_t here. The value tracker should see that
eth_pkt_ofs could be [0..ETH_ALEN). eth_pat_len is coming from an "int",
though, so that might be the confusion. It may think eth_pat_len could
be [0..UINT_MAX] (i.e. the full range of int within size_t).

So [0..ETH_ALEN) + [0..UINT_MAX] < 6 might be doing something wrong in
GCC 11.x, and it's not actually doing the size_t promotion correctly,
or deciding something has wrapped and then thinking eth_pat_len could
span a giant region of the address space, which freaks out -Wrestrict.
i.e. it's seeing that for the "if" to be true, eth_pat_len could be large
enough to wrap around the addition (though this shouldn't be possible
for 64-bit size_t).

So I could see how [0..UINT_MAX] < 6 - [0..ETH_ALEN) would make it
happier: the right side is now [1..6], so eth_pat_len becomes [1..6).

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

