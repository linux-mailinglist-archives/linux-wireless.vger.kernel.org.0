Return-Path: <linux-wireless+bounces-5091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FC8885A32
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 14:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98AC1F21377
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0118484FA2;
	Thu, 21 Mar 2024 13:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDZoQ16p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16A784FA0
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029448; cv=none; b=sWY8KQevlz8i9MthnYln1kjq4GNHM9kP1TWblXR89PXAt7JGhBRUhN8eu8fKyPS/bJjtNwUoL6jcvzqnWWYn56IOf/kAheBbOGdgjJ2l9hNKDkN7nz+HqJOw3YzP9D4fca+/Ob6TISbQyFCQgRTvE7klexBiXllBiKp/EZXAPJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029448; c=relaxed/simple;
	bh=Dwncs3U9DZWTnsWHAmyVgb/52un51cGEoj5hGPqs6G4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=ZFcrE6x0MOdu9zcKdsLB5QeerBNw0GwOHgPr5+nqsPYB6ShymLOKIqpwik/7ztFXHUjz6h7920rdgSviO8C1r+4KBYVH9IVPnXmHCDQdQVAS9W87d68+3q/EvE9YTWxXzSTbViP3AKacEGgdk04O/D7CvGC3FJyX49UpP6Vt320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDZoQ16p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590E2C433C7;
	Thu, 21 Mar 2024 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711029448;
	bh=Dwncs3U9DZWTnsWHAmyVgb/52un51cGEoj5hGPqs6G4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DDZoQ16pPkZMLFK5k/NO5VVI60ZLWjQ4FREPYa6Kq6B783/DVpuZG16uL9dXPNwFf
	 Dbe0USk3OFV1fBuxc2wyxh3PQRgwQo8dgkx6Ti9d7Nmyr2qSUehouvWbOSg2XBRpSD
	 Augg6yOMvCJCbZIXt3KXsdjrHq6nWCBtYf6SXy0kntKdg+6sV5nN+SfZdFIsYqHMBE
	 jxqWWCqwMYasIzOkim1wvoyAjywJYwpf0gSP0cR6PInAU+MZBfVg7+NvVl+5k8PyLC
	 zMsZJNSIcRzfYodGgqtuPzwQ+CCTG9/QaUliXr+boIkscAsuvPdCSZAK/p9tP0p7lN
	 IKBkF38a/CNbQ==
From: Kalle Valo <kvalo@kernel.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
  linux-wireless@vger.kernel.org,
  lvc-project@linuxtesting.org
Subject: Re: [PATCH] wifi: ath9k: cleanup ath_tx_complete_aggr()
References: <20240321122642.175645-1-dmantipov@yandex.ru>
Date: Thu, 21 Mar 2024 15:57:25 +0200
In-Reply-To: <20240321122642.175645-1-dmantipov@yandex.ru> (Dmitry Antipov's
	message of "Thu, 21 Mar 2024 15:26:42 +0300")
Message-ID: <877chvadru.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
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

FWIW I don't like this style (defining variables within a loop) but
that's really up to Toke to decide. Also what does the generated code
look like when assigning the same variables in every loop iteration?

But honestly this just feels unnecessary code churn. Dmitry, I have to
warn that these kind of cleanups (without no concrete improvement) from
you are getting annoying, it's very close that I just start ignoring
your patches.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

