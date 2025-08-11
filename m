Return-Path: <linux-wireless+bounces-26251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72CFB2089B
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABB218A195E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Aug 2025 12:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97ED220297C;
	Mon, 11 Aug 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRW+ziwZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B341E8320
	for <linux-wireless@vger.kernel.org>; Mon, 11 Aug 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914742; cv=none; b=ut27e4/Hv8VpBDRB2jKkkz+PJH5w21RptFx2VKo0IsK8lnRS/kw2DwnPUj7ogT3nBH+KHcJSJGSeoUTmvrg/mIYoXK4nSZPyu1dSI6BP/QH0LMiIu9Lkn+nWHyA7sy+Ia1BxHsgAbAt/5tmfz7Jwb4GLZ/H0WeTC4KqrukAvuww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914742; c=relaxed/simple;
	bh=B0q0VCoSGFsWXnQk/OGywcrhb1d6o10G/4CThZZNhhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sA78VRUVVmiRrRrA09rFoxO41q8pvjQR6YThdiGkbYi92No87rrJDUxIBbwzYKu844A/eu8v+aIYOxqyT3iKKxy7cG7b6qLPRduJ/MUSomfb0AyrX9lQ3xhv6uYI8zds+Ylo85QRCbUBjuaJH6TEjClhx9LagNWV/w/KIhYiCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRW+ziwZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDA4C4CEED;
	Mon, 11 Aug 2025 12:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754914741;
	bh=B0q0VCoSGFsWXnQk/OGywcrhb1d6o10G/4CThZZNhhw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XRW+ziwZcZnE5Sw3KPLr4rPG6IDo5MDkXrR0SeZOlTUUiFXEiv9hShcDYQ/SE5UyV
	 Iscat/SPo6ULnkE0SCH7ut4q0ecv5RvNboSGs1vIMVlQra2uWJaq2W2QywsKKrTQ6E
	 +n2CqsHM8BLEFzIRdQWFjW0F0iBQ8OoIiEgp+Hz4balaivWOnbF0bGEVh5pGr+f/Wa
	 cJRJtKAODjVV0fzb8qOLQXg76zypFAMYjRuJEKFiehXOlg8ZWMJyKvKtP7Wwz6lzPJ
	 ow27t2Uqx+ffVHRYfzWJYc1Hc/tkiq4f2RzRyLOtwR9czsqXWkA2EcFqU9TTYbPC6p
	 M5v4oJM8NY/Ig==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3750D19CE18; Mon, 11 Aug 2025 14:18:58 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Oleksiy Protas <elfy.ua@gmail.com>, elfy.ua@gmail.com
Cc: linux-wireless@vger.kernel.org, Oleksiy Protas <elfy@ecognize.me>
Subject: Re: [PATCH] ath9k: keep ANI in monitor mode
In-Reply-To: <20250514180413.373876-2-elfy@ecognize.me>
References: <CACC_pfLYxUXPTAo0P9aqeP-xKAMdGsAckg_=j0HO6fRf7rNxoA@mail.gmail.com>
 <20250514180413.373876-1-elfy@ecognize.me>
 <20250514180413.373876-2-elfy@ecognize.me>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 11 Aug 2025 14:18:58 +0200
Message-ID: <87qzxikq4t.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oleksiy Protas <elfy.ua@gmail.com> writes:

> Earlier changes that made is_monitoring a separate flag as opposed to setting the opmode caused AMI to never start when monitoring
> ---
>  drivers/net/wireless/ath/ath9k/link.c | 2 +-
>  drivers/net/wireless/ath/ath9k/main.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
> index 9d84003db800..cd2ead7b2883 100644
> --- a/drivers/net/wireless/ath/ath9k/link.c
> +++ b/drivers/net/wireless/ath/ath9k/link.c
> @@ -468,7 +468,7 @@ void ath_check_ani(struct ath_softc *sc)
>  			if (!test_bit(ATH_OP_PRIM_STA_VIF, &common->op_flags))
>  				goto stop_ani;
>  		}
> -	} else if (ah->opmode == NL80211_IFTYPE_STATION) {
> +	} else if (ah->opmode == NL80211_IFTYPE_STATION && !ah->is_monitoring) {
>  		if (!test_bit(ATH_OP_PRIM_STA_VIF, &common->op_flags))
>  			goto stop_ani;
>  	}

AFAICT, if you're trying to restore the old logic, ANI should always be
enabled if monitoring is. But here you're only changing the station
branch of the logic. Shouldn't it be something like:

--- i/drivers/net/wireless/ath/ath9k/link.c
+++ w/drivers/net/wireless/ath/ath9k/link.c
@@ -481,6 +481,9 @@ void ath_check_ani(struct ath_softc *sc)
 	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
 	struct ath_beacon_config *cur_conf = &sc->cur_chan->beacon;
 
+	if (ah->is_monitoring)
+		goto start_ani;
+
 	/*
 	 * Check for the various conditions in which ANI has to
 	 * be stopped.
@@ -502,6 +505,7 @@ void ath_check_ani(struct ath_softc *sc)
 			goto stop_ani;
 	}
 
+start_ani:
 	if (!test_bit(ATH_OP_ANI_RUN, &common->op_flags)) {
 		set_bit(ATH_OP_ANI_RUN, &common->op_flags);
 		ath_start_ani(sc);


> diff --git a/drivers/net/wireless/ath/ath9k/main.c b/drivers/net/wireless/ath/ath9k/main.c
> index aa271b82875e..2685aeecffad 100644
> --- a/drivers/net/wireless/ath/ath9k/main.c
> +++ b/drivers/net/wireless/ath/ath9k/main.c
> @@ -1530,6 +1530,7 @@ static int ath9k_config(struct ieee80211_hw *hw, u32 changed)
>  		if (conf->flags & IEEE80211_CONF_MONITOR) {
>  			ath_dbg(common, CONFIG, "Monitor mode is enabled\n");
>  			sc->sc_ah->is_monitoring = true;
> +			ath_check_ani(sc);
>  		} else {
>  			ath_dbg(common, CONFIG, "Monitor mode is disabled\n");
>  			sc->sc_ah->is_monitoring = false;

And shouldn't this call to ath_check_ani() be done regardless of whether
monitoring mode is being enabled or disabled? I.e., go after the else of
that if branch?

-Toke

