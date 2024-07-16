Return-Path: <linux-wireless+bounces-10268-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E4F932AF0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 17:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4541C22C7A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2024 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29CA19AA78;
	Tue, 16 Jul 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRifRU+X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C886E19A86F;
	Tue, 16 Jul 2024 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144381; cv=none; b=jAq5aqYt+t1RI+lh5f52lHlzg2Z08q1DD+ywlk6uvvTd4K6imQ6a1uQX/WIDHE7SOS06veTh+g5jv7t1dKEoKqtlJaWI1TpRF74kSj090IEt/6YSqlHjPb/aeupgjEBZpreNGElH+sWEG+Azu6XfLmBYf2DcAu0IKVanXKm6HQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144381; c=relaxed/simple;
	bh=C1k0pii6K6mISsN7ikworzl7ytrXnGBw4UelyAmvbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYSOlu4QyfTowlYX8qbvjQOHPBVr182AxJ81udwrjz90gAJzYlaTHhQp75REsTkf679p/hCyTe887O2gx8nTgobSFTYAaTBikHT9NS3Iz0BQipk54uz8/bQlU566GuHaLJOP6F97znLU78KWtFJ87EDMpZMASYCdxKkrrQyl2CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRifRU+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88487C4AF0B;
	Tue, 16 Jul 2024 15:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721144381;
	bh=C1k0pii6K6mISsN7ikworzl7ytrXnGBw4UelyAmvbWc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=pRifRU+Xc+hgTIIzsj8Niih5psN5fJ8f92vDRMRyELzF9g1nEtkXzvSnTQIGcR2pB
	 hdg7LBTYVPJngy4Bu2e9cjVFtjB1q0kgBhMtTpKyQbRGBuWlrBtsl+Ll29hkyH7LeH
	 Fh4qjbFUZwWodMD3luPFQ/Ym7h3H8d5/AVj9dPG9bEuRqNdZ8Xz31nC992fnC84nhk
	 Yw/nQxXQiCfZ7QnXvuGmkjpMIBNam8oiFLKPDo9/26DU+fNbdaMnLM/YYfjusadXKQ
	 hsYZSFx1wXFkkkE+4Fr4BYQY2KKV1Dm/s+fH/SNFTUO9oQobXO39vYx0AS7/ZNnbzL
	 0xQH18MTum5Yw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 269B2CE13CB; Tue, 16 Jul 2024 08:39:41 -0700 (PDT)
Date: Tue, 16 Jul 2024 08:39:41 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] wifi: ath12k: fix build vs old compiler
Message-ID: <834dd0b3-6a2c-4af6-9541-27fd4b21d833@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3175f87d7227e395b330fd88fb840c1645084ea7.1721127979.git.pabeni@redhat.com>
 <a7950e7b-2275-4b6d-b8e1-4f50d0bc28e6@quicinc.com>
 <93d282fb-4691-460a-aa5b-13e9ef054cdb@quicinc.com>
 <A4FF7C44-06C7-4241-B33E-1E9684A979E0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A4FF7C44-06C7-4241-B33E-1E9684A979E0@kernel.org>

On Tue, Jul 16, 2024 at 07:36:40AM -0700, Kees Cook wrote:
> 
> 
> On July 16, 2024 7:03:55 AM PDT, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> >On 7/16/2024 7:00 AM, Jeff Johnson wrote:
> >> On 7/16/2024 4:06 AM, Paolo Abeni wrote:
> >>> gcc 11.4.1-3 warns about memcpy() with overlapping pointers:
> >>>
> >>> drivers/net/wireless/ath/ath12k/wow.c: In function ‘ath12k_wow_convert_8023_to_80211.constprop’:
> >>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551611 or more bytes at offsets 0 and 0 overlaps 9223372036854775799 bytes at offset -9223372036854775804 [-Werror=restrict]
> >>>   114 | #define __underlying_memcpy     __builtin_memcpy
> >>>       |                                 ^
> >>> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
> >>>   637 |         __underlying_##op(p, q, __fortify_size);                        \
> >>>       |         ^~~~~~~~~~~~~
> >>> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
> >>>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >>>       |                          ^~~~~~~~~~~~~~~~~~~~
> >>> drivers/net/wireless/ath/ath12k/wow.c:190:25: note: in expansion of macro ‘memcpy’
> >>>   190 |                         memcpy(pat, eth_pat, eth_pat_len);
> >>>       |                         ^~~~~~
> >>> ./include/linux/fortify-string.h:114:33: error: ‘__builtin_memcpy’ accessing 18446744073709551605 or more bytes at offsets 0 and 0 overlaps 9223372036854775787 bytes at offset -9223372036854775798 [-Werror=restrict]
> >>>   114 | #define __underlying_memcpy     __builtin_memcpy
> >>>       |                                 ^
> >>> ./include/linux/fortify-string.h:637:9: note: in expansion of macro ‘__underlying_memcpy’
> >>>   637 |         __underlying_##op(p, q, __fortify_size);                        \
> >>>       |         ^~~~~~~~~~~~~
> >>> ./include/linux/fortify-string.h:682:26: note: in expansion of macro ‘__fortify_memcpy_chk’
> >>>   682 | #define memcpy(p, q, s)  __fortify_memcpy_chk(p, q, s,                  \
> >>>       |                          ^~~~~~~~~~~~~~~~~~~~
> >>> drivers/net/wireless/ath/ath12k/wow.c:232:25: note: in expansion of macro ‘memcpy’
> >>>   232 |                         memcpy(pat, eth_pat, eth_pat_len);
> >>>       |                         ^~~~~~
> >>>
> >>> The sum of size_t operands can overflow SIZE_MAX, triggering the
> >>> warning.
> >>> Address the issue using the suitable helper.
> >>>
> >>> Fixes: 4a3c212eee0e ("wifi: ath12k: add basic WoW functionalities")
> >>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> >>> ---
> >>> Only built tested. Sending directly to net to reduce the RTT, but no
> >>> objections to go through the WiFi tree first
> >>> ---
> >>>  drivers/net/wireless/ath/ath12k/wow.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/wireless/ath/ath12k/wow.c b/drivers/net/wireless/ath/ath12k/wow.c
> >>> index c5cba825a84a..bead19db2c9a 100644
> >>> --- a/drivers/net/wireless/ath/ath12k/wow.c
> >>> +++ b/drivers/net/wireless/ath/ath12k/wow.c
> >>> @@ -186,7 +186,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
> >>>  	if (eth_pkt_ofs < ETH_ALEN) {
> >>>  		pkt_ofs = eth_pkt_ofs + a1_ofs;
> >>>  
> >>> -		if (eth_pkt_ofs + eth_pat_len < ETH_ALEN) {
> >>> +		if (size_add(eth_pkt_ofs, eth_pat_len) < ETH_ALEN) {
> >>>  			memcpy(pat, eth_pat, eth_pat_len);
> >>>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
> >>>  
> >>> @@ -228,7 +228,7 @@ ath12k_wow_convert_8023_to_80211(struct ath12k *ar,
> >>>  	} else if (eth_pkt_ofs < prot_ofs) {
> >>>  		pkt_ofs = eth_pkt_ofs - ETH_ALEN + a3_ofs;
> >>>  
> >>> -		if (eth_pkt_ofs + eth_pat_len < prot_ofs) {
> >>> +		if (size_add(eth_pkt_ofs, eth_pat_len) < prot_ofs) {
> >>>  			memcpy(pat, eth_pat, eth_pat_len);
> >>>  			memcpy(bytemask, eth_bytemask, eth_pat_len);
> >>>  
> >> 
> >> Duplicate of https://msgid.link/20240704144341.207317-1-kvalo@kernel.org ??
> >
> >Let me add Kees & Paul to see if they prefer your solution
> 
> Heh, yeah, that works too! Avoid the overflow via saturating addition.
> 
> Reviewed-by: Kees Cook<kees@kernel.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

I have no preference between the two, but it would be really nice if a
fix were to hit both -next and mainline sooner rather than later.  ;-)

							Thanx, Paul

