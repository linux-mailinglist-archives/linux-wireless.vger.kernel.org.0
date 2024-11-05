Return-Path: <linux-wireless+bounces-14923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1A9BCD48
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 14:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE341F220CE
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 13:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594E91D5AD8;
	Tue,  5 Nov 2024 13:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX2/910q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348FA1D5AD4
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 13:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811755; cv=none; b=LQ6fvhKW+YTh2qKKvYQ9eRN05fBXK+bjC7QtUQpcq0QPtkg6YrnwR9EjDFbR0ng5QAFl98sL7YZzJhjUQESyOu2F6Ge66jmh0jGWbVdmjJhtcVMUACAaTbMnGjB/opnxymJexqxNLfdU5w+4bJ4asE5aihm9M8YZYJ3+MHIVcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811755; c=relaxed/simple;
	bh=8gZpjOVWmgNI7NJUxYrgUCdGK7flv9UpWM94FGdUP3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OlS5Dvo/i8o/xQoKwgJpRJMGp/6wgrEvqqcpWDzfrDy8JQgd/rZIyVHKOVwVGmKjsjM/rRJ7uRk7JuZdwSOdH+acQCM4uEZyKGyKXyWRz9tTdQCxUo9nBJJyFBUm7KdsmQSck3H4AQYWpqwSzukRwRd4KOLIpxEjFZZAN04bUUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX2/910q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800E4C4CECF;
	Tue,  5 Nov 2024 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730811754;
	bh=8gZpjOVWmgNI7NJUxYrgUCdGK7flv9UpWM94FGdUP3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=sX2/910q3RCPWRHY6qKKz9wC0mCsMQelNHqCAk2DrZ4u6yij7cYr3suy1htHpP+tF
	 VVPt1dwqSopdmaUwMue7SbdcCqmrfegQ7x/bCP8jGnQFHu1Mij9UOeRI1eIwlaRinZ
	 O28O/ctp90+89W8fwhOSBsaw0xK43u7ROw215nH8GmtsxxW+nrPb2Ku0+UtZIFDMMu
	 WitRO5i0ldTJoB7PBdZSfht3hOfY5ApfP07VosNeicuBM4ygK4GdHaSkdC/wRyUsGT
	 8kIcxPdWyc2RZCOE1Q+AvU1BsMncymvdxMQqd2DL9UY0xbWaNc/Qy1IYZ2K3ou9k8T
	 VIgvFLoY9K+3A==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 71578164C23D; Tue, 05 Nov 2024 14:02:31 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Issam Hamdi <ih@simonwunderlich.de>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de,
 Simon Wunderlich <simon.wunderlich@open-mesh.com>, Simon Wunderlich
 <sw@simonwunderlich.de>, Sven Eckelmann <se@simonwunderlich.de>, Issam
 Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH 2/2] wifi: ath9k: Reset chip on potential deaf state
In-Reply-To: <20241104171627.3789199-2-ih@simonwunderlich.de>
References: <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241104171627.3789199-2-ih@simonwunderlich.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 05 Nov 2024 14:02:31 +0100
Message-ID: <87h68l96l4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Issam Hamdi <ih@simonwunderlich.de> writes:

> From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
>
> The chip is switching seemingly random into a state which can be described
> as "deaf". No or nearly no interrupts are generated anymore for incoming
> packets. Existing links either break down after a while and new links will
> not be established.
>
> The driver doesn't know if there is no other device available or if it
> ended up in an "deaf" state. Resetting the chip proactively avoids
> permanent problems in case the chip really was in its "deaf" state but
> maybe causes unnecessary resets in case it wasn't "deaf".

Proactively resetting the device if there is no traffic on the network
for four seconds seems like a tad aggressive. Do you have any
information on under which conditions this actually happens in practice?
I assume this is a patch that has been lying around in openwrt for a
while, or something?

As for the code itself, see below:

> This patch originally developed by "Simon Wunderlich <simon.wunderlich@open-mesh.com>"
> and "Sven Eckelmann <sven.eckelmann@open-mesh.com>"
>
> Co-developed-by: Simon Wunderlich <sw@simonwunderlich.de>
> Co-developed-by: Sven Eckelmann <se@simonwunderlich.de>
> Signed-off-by: Issam Hamdi <ih@simonwunderlich.de>
> ---
>  drivers/net/wireless/ath/ath9k/ath9k.h |  3 ++
>  drivers/net/wireless/ath/ath9k/debug.c |  1 +
>  drivers/net/wireless/ath/ath9k/debug.h |  1 +
>  drivers/net/wireless/ath/ath9k/link.c  | 48 +++++++++++++++++++++++++-
>  4 files changed, 52 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
> index c1ce081445a9..2b98c69fa37f 100644
> --- a/drivers/net/wireless/ath/ath9k/ath9k.h
> +++ b/drivers/net/wireless/ath/ath9k/ath9k.h
> @@ -1026,6 +1026,9 @@ struct ath_softc {
>  	short nbcnvifs;
>  	unsigned long ps_usecount;
>  
> +	unsigned long last_check_time;
> +	u32 last_check_interrupts;
> +
>  	struct ath_rx rx;
>  	struct ath_tx tx;
>  	struct ath_beacon beacon;
> diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
> index 6b2469a01f17..4128cf691166 100644
> --- a/drivers/net/wireless/ath/ath9k/debug.c
> +++ b/drivers/net/wireless/ath/ath9k/debug.c
> @@ -751,6 +751,7 @@ static int read_file_reset(struct seq_file *file, void *data)
>  		[RESET_TX_DMA_ERROR] = "Tx DMA stop error",
>  		[RESET_RX_DMA_ERROR] = "Rx DMA stop error",
>  		[RESET_TYPE_DEADBEEF] = "deadbeef hang",
> +		[RESET_TYPE_DEAF] = "deaf hang",
>  	};
>  	int i;
>  
> diff --git a/drivers/net/wireless/ath/ath9k/debug.h b/drivers/net/wireless/ath/ath9k/debug.h
> index 6ebb6053a8c1..76e27860455c 100644
> --- a/drivers/net/wireless/ath/ath9k/debug.h
> +++ b/drivers/net/wireless/ath/ath9k/debug.h
> @@ -54,6 +54,7 @@ enum ath_reset_type {
>  	RESET_TX_DMA_ERROR,
>  	RESET_RX_DMA_ERROR,
>  	RESET_TYPE_DEADBEEF,
> +	RESET_TYPE_DEAF,
>  	__RESET_TYPE_MAX
>  };
>  
> diff --git a/drivers/net/wireless/ath/ath9k/link.c b/drivers/net/wireless/ath/ath9k/link.c
> index 37438960c278..d1762cc3129d 100644
> --- a/drivers/net/wireless/ath/ath9k/link.c
> +++ b/drivers/net/wireless/ath/ath9k/link.c
> @@ -162,13 +162,59 @@ static bool ath_hw_hang_deadbeef(struct ath_softc *sc)
>  	return true;
>  }
>  
> +static bool ath_hw_hang_deaf(struct ath_softc *sc)
> +{
> +#if !defined(CPTCFG_ATH9K_DEBUGFS) || defined(CPTCFG_ATH9K_TX99)
> +	return false;
> +#else
> +	struct ath_common *common = ath9k_hw_common(sc->sc_ah);
> +	u32 interrupts, interrupt_per_s;
> +	unsigned int interval;
> +
> +	/* get historic data */
> +	interval = jiffies_to_msecs(jiffies - sc->last_check_time);
> +	if (sc->sc_ah->caps.hw_caps & ATH9K_HW_CAP_EDMA)
> +		interrupts = sc->debug.stats.istats.rxlp;
> +	else
> +		interrupts = sc->debug.stats.istats.rxok;
> +
> +	interrupts -= sc->last_check_interrupts;

Relying on the debugfs counters for this seems like an odd roundabout
way of going about things. Why not just record the last time an RX
interrupt was received directly in the interrupt handler code, and then
have the watchdog check if that time was too far in the past?

Recording both TX and RX times may even help distinguish between 'deaf'
and 'idle' (cf the comment above): if we transmitted something, but got
no RX, that's a good indication of the deaf state; but if nothing
happened in either direction, it's probably just the network that's
idle. I think? :)

-Toke

