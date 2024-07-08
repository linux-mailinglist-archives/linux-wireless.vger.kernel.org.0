Return-Path: <linux-wireless+bounces-10083-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D27692A9D4
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 21:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0112822E2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 19:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7031B815;
	Mon,  8 Jul 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBjcWO8R"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7B18E1E
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 19:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467067; cv=none; b=Ndn+ebWvdgekCcPFEXvH9rJ07O8bodiFpT8SbqNXLcQbA/Ys+NRrL4DFEqe3UPM0zxS4j08B7uB0klcu/3ue1+fxnRq5JFTuC+8POoR30PJNy35p9wdl0n4NFVrN4WoY9kWKT6+AOKeJi2kZ63p3lHHgxdpcUXhu0IA+UCF/8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467067; c=relaxed/simple;
	bh=xWIqjEKJWV+KQU2fz3X7SNlmN3/sS27O+Ruv3Ju/x2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYVlM2TgNP0iwMvKCNNQEBTzwfaC35xuy8dcZWE9tpRTe8UsVKGR/8PM/bpXX0Gz0V7TpjP5kE97OsY84vO8kk+OdVN/63uvBa1rWVtmed5Hht6HVUQXNcW8RmLzOgvmXtKUAE8K7qRscYDeuJG8CglOvi2kCip11GqDEZUFLTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBjcWO8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42C8C116B1;
	Mon,  8 Jul 2024 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720467066;
	bh=xWIqjEKJWV+KQU2fz3X7SNlmN3/sS27O+Ruv3Ju/x2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MBjcWO8Rxw/AEVgfarlNbrRjEQBAGkMfnwdomr6ihG/k8OYy83SAafO7mxx/uDWiX
	 TsTFnDCqVVdyd84BAPNZl6zMmcdo8m3KICTUYgxNVkVXndaWy34DLpcderCOqzbpTB
	 tgLi3qYTY+uR7GjZu4KxVbsPRXCIeC4SkkigMfWO5IrmcG/7NInLgQXJJJbaV02WB4
	 xSnc0Bny1SjcNpOiHb4ZrZITSlbCUGzE0oSfT+fatcNr1aeFvR0yiU713oKjVT5BiV
	 QrC+79JrWF4C+SrXcxJg8vXcQnpiMMRZhS+SMZEhxfh/Sti78jb2DS8GINPp/bxNpf
	 nkguuUaTpLIDw==
Date: Mon, 8 Jul 2024 12:31:06 -0700
From: Kees Cook <kees@kernel.org>
To: Kalle Valo <kvalo@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] wifi: ath12k: workaround fortify warnings in
 ath12k_wow_convert_8023_to_80211()
Message-ID: <202407081226.94B1FB24@keescook>
References: <20240704144341.207317-1-kvalo@kernel.org>
 <202407041551.1DC8C03D@keescook>
 <877cdvdgpz.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cdvdgpz.fsf@kernel.org>

On Mon, Jul 08, 2024 at 06:51:52PM +0300, Kalle Valo wrote:
> Kees Cook <kees@kernel.org> writes:
> 
> > On Thu, Jul 04, 2024 at 05:43:41PM +0300, Kalle Valo wrote:
> >> From: Kalle Valo <quic_kvalo@quicinc.com>
> >> 
> >> Johannes reported with GCC 11.4 there's a fortify warning below. The warning is
> >> not seen with GCC 12.1 nor 13.2. Weirdly moving the other operand of sum to the
> >> other side the warning goes away. This is safe to do as the value of the
> >> operand is check earlier. But the code looks worse with this so I'm not sure
> >> what to do.
> >
> > FWIW, this isn't fortify, but -Wrestrict.
> 
> Ah, thanks for correcting. I just saw fortify-string.h and made the
> wrong assumption.
> 
> > I would expect the same warnings even with CONFIG_FORTIFY_SOURCE
> > disabled. Regardless, it's worth figuring out what's going on. It
> > looks like this is GCC's value range tracker deciding it sees a way
> > for things to go weird.
> >
> > I suspect they fixed -Wrestrict in later GCC versions. It might need to
> > be version-limited...
> >
> >> In file included from ./include/linux/string.h:374,
> >>                  from ./include/linux/bitmap.h:13,
> >>                  from ./include/linux/cpumask.h:13,
> >>                  from ./include/linux/sched.h:16,
> >>                  from ./include/linux/delay.h:23,
> >>                  from drivers/net/wireless/ath/ath12k/wow.c:7:
> >> drivers/net/wireless/ath/ath12k/wow.c: In function
> >> ‘ath12k_wow_convert_8023_to_80211.constprop’:
> >> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’
> >> accessing 18446744073709551611 or more bytes at offsets 0 and 0
> >> overlaps 9223372036854775799 bytes at offset -9223372036854775804
> >> [-Werror=restrict]
> >
> > These huge negative values imply to me that GCC is looking at some
> > signed values somewhere.
> >
> >> [...]
> >> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
> >> index c5cba825a84a..e9588bb7561c 100644
> >> --- a/drivers/net/wireless/ath/ath12k/wow.c
> >> +++ b/drivers/net/wireless/ath/ath12k/wow.c
> >> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
> >>  	if (eth_pkt_ofs < ETH_ALEN) {
> >>  		pkt_ofs = eth_pkt_ofs + a1_ofs;
> >>  
> >> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
> >> +		if (eth_pat_len < ETH_ALEN - eth_pkt_ofs) {
> >>  			memcpy(pat, eth_pat, eth_pat_len);
> >>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
> >
> > Both eth_pkt_ofs and eth_pat_len are size_t. ETH_ALEN isn't, but it
> > would be promoted to size_t here. The value tracker should see that
> > eth_pkt_ofs could be [0..ETH_ALEN). eth_pat_len is coming from an "int",
> > though, so that might be the confusion. It may think eth_pat_len could
> > be [0..UINT_MAX] (i.e. the full range of int within size_t).
> >
> > So [0..ETH_ALEN) + [0..UINT_MAX] < 6 might be doing something wrong in
> > GCC 11.x, and it's not actually doing the size_t promotion correctly,
> > or deciding something has wrapped and then thinking eth_pat_len could
> > span a giant region of the address space, which freaks out -Wrestrict.
> > i.e. it's seeing that for the "if" to be true, eth_pat_len could be large
> > enough to wrap around the addition (though this shouldn't be possible
> > for 64-bit size_t).
> >
> > So I could see how [0..UINT_MAX] < 6 - [0..ETH_ALEN) would make it
> > happier: the right side is now [1..6], so eth_pat_len becomes [1..6).
> 
> Earlier I did some testing and I noticed that this if test also gives a
> warning:
> 
> 1 + eth_pat_len < ETH_ALEN
> 
> But this doesn't have any warning:
> 
> 0 + eth_pat_len < ETH_ALEN
> 
> And I stopped my investigation there :)
> 
> > Reviewed-by: Kees Cook <kees@kernel.org>
> 
> So you think this should be applied? It's not really logical so I would
> prefer to avoid taking it if possible. Or should we just ignore the
> warning? It only happens on GCC 11 anyway.

I suspect this won't be the only place in the kernel where -Wrestrict
will give weird results with GCC 11, and there are still plenty of folks
using GCC 11. I think the best option would probably be to version-check
GCC to gate the addition of -Wrestrict.

Arnd, what do you think? This looks like a more extreme version of
commit f9fc1ec28bae ("crypto: drivers - avoid memcpy size warning")

-Kees

-- 
Kees Cook

