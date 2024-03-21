Return-Path: <linux-wireless+bounces-5114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E254C88613A
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 20:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBD21C215A2
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 19:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A21F133993;
	Thu, 21 Mar 2024 19:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="u+88zv5x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A5D132C38
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 19:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050255; cv=none; b=qrDwuxE37UjhN2yxNiNHyt4P2RuKYbUrOUMMKiYSiX3DvmxLf/gukICsfdtUhadHN7f8c6a81JE4xYZ0JXtDYLowiX+bzzrGx8JDNmCyjyZxHTfp/IehVfPo3G+4Qj95vAcqxI5SjpZ92OrYvxgcmVJtIBD9dkShG6wGCoN7Y7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050255; c=relaxed/simple;
	bh=OnhhZwYsqR8b6hhB4hEK0d/Aicu6xh0og4PaUHx7fvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJsMOV9OSIEbbSk4NfM+bDQ0f1NstejViDMDPI+5bgcipG6qcgHj42GhbRTWXTwuSJOSAADXoOt4CVoRBsb1OlYbEM+1XpaWzkYsTHvdHrqNHGWnh1P/IRKu8E9Zpy+a+eweAfpJz/kT7wxGRKKXQmIAm8CA6x96200bPOee/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=u+88zv5x; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1711050250; bh=OnhhZwYsqR8b6hhB4hEK0d/Aicu6xh0og4PaUHx7fvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u+88zv5x+k4BFNiFnR8AZFyFilQht0b5VAhMLJJbEfIa2icDDvfuPx1Y9e52xhntA
	 ASY31MCA+1MYWgRJjBiw2RgX74vHaAtPRQyRac/1C590bEeqB2kNoeSUmxIfnIKNq7
	 p32lhyWAKS8PAj14nTnGYe3XfqiDb5BB1Res6NAQQXJ7jw6VJKhpCuQ8E/CE9en6lw
	 FBuCurFZ6yVqEN6nGPBP4x4MmNsZ149kDAllb9hVagyxcRwWFmE8LrKpPL5KqP1FJJ
	 Eb4uyCsZvIpde9Qijn3XAmvCSznSSea7uRxlVQgLZ42CrZvMH8yhqRRFEHWWVc58wI
	 5wQz4d6aYFY1g==
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
 lvc-project@linuxtesting.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject: Re: [PATCH] wifi: ath9k: cleanup ath_tx_complete_aggr()
In-Reply-To: <20240321122642.175645-1-dmantipov@yandex.ru>
References: <20240321122642.175645-1-dmantipov@yandex.ru>
Date: Thu, 21 Mar 2024 20:44:10 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7b7fjzp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dmitry Antipov <dmantipov@yandex.ru> writes:

> Since 'skb', 'tx_info' and 'fi' are actually used within
> buffers processing loop only, move them inside the latter
> and avoid some redundant initialization at the beginning
> of 'ath_tx_complete_aggr()'. Compile tested only.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/ath/ath9k/xmit.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
> index d519b676a109..657862be45e5 100644
> --- a/drivers/net/wireless/ath/ath9k/xmit.c
> +++ b/drivers/net/wireless/ath/ath9k/xmit.c
> @@ -491,8 +491,6 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
>  				 struct ath_tx_status *ts, int txok)
>  {
>  	struct ath_node *an = NULL;
> -	struct sk_buff *skb;
> -	struct ieee80211_tx_info *tx_info;
>  	struct ath_buf *bf_next, *bf_last = bf->bf_lastbf;
>  	struct list_head bf_head;
>  	struct sk_buff_head bf_pending;
> @@ -501,15 +499,11 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
>  	int isaggr, txfail, txpending, sendbar = 0, needreset = 0, nbad = 0;
>  	bool rc_update = true, isba;
>  	struct ieee80211_tx_rate rates[4];
> -	struct ath_frame_info *fi;
>  	int nframes;
>  	bool flush = !!(ts->ts_status & ATH9K_TX_FLUSH);
>  	int i, retries;
>  	int bar_index = -1;
>  
> -	skb = bf->bf_mpdu;
> -	tx_info = IEEE80211_SKB_CB(skb);
> -
>  	memcpy(rates, bf->rates, sizeof(rates));
>  
>  	retries = ts->ts_longretry + 1;
> @@ -571,14 +565,13 @@ static void ath_tx_complete_aggr(struct ath_softc *sc, struct ath_txq *txq,
>  	ath_tx_count_frames(sc, bf, ts, txok, &nframes, &nbad);
>  	while (bf) {
>  		u16 seqno = bf->bf_state.seqno;
> +		struct sk_buff *skb = bf->bf_mpdu;
> +		struct ath_frame_info *fi = get_frame_info(skb);
> +		struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
>  
>  		txfail = txpending = sendbar = 0;
>  		bf_next = bf->bf_next;
>  
> -		skb = bf->bf_mpdu;
> -		tx_info = IEEE80211_SKB_CB(skb);
> -		fi = get_frame_info(skb);
> -

I'm OK with moving the variable declarations inside the loop body, but
please keep the assignment here as separate statements (and maintain
reverse x-mas tree ordering in the declarations at the top of the loop).

-Toke

