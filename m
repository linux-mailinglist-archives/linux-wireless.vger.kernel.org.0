Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E47B9F442D
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfKHKHo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:07:44 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53518 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKHKHo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:07:44 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT1B8-0007Tw-FM; Fri, 08 Nov 2019 11:07:42 +0100
Message-ID: <42266e95f45d5772e04c9c016bd6179ea14ffefa.camel@sipsolutions.net>
Subject: Re: [PATCH v6 2/4] mac80211: Import airtime calculation code from
 mt76
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Toke =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     linux-wireless@vger.kernel.org,
        make-wifi-fast@lists.bufferbloat.net, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, Kan Yan <kyan@google.com>,
        Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Kevin Hayes <kevinhayes@google.com>
Date:   Fri, 08 Nov 2019 11:07:41 +0100
In-Reply-To: <157182474174.150713.17459330922820192258.stgit@toke.dk>
References: <157182473951.150713.7978051149956899705.stgit@toke.dk>
         <157182474174.150713.17459330922820192258.stgit@toke.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-10-23 at 11:59 +0200, Toke Høiland-Jørgensen wrote:
> From: Toke Høiland-Jørgensen <toke@redhat.com>
> 
> Felix recently added code to calculate airtime of packets to the mt76
> driver. Import this into mac80211 so we can use it for airtime queue limit
> calculations later.
> 
> The airtime.c file is copied verbatim from the mt76 driver, and adjusted to
> use mac80211 data structures instead (which is fairly straight forward).
> The per-rate TX rate calculation is split out to its own
> function (ieee80211_calc_tx_airtime_rate()) so it can be used directly for
> the AQL calculations added in a subsequent patch.

Any way it could be exposed by mac80211 back to the drivers, perhaps, to
share it?

> The only thing that it was not possible to port directly was the bit that
> read the internal driver flags of struct ieee80211_rate to determine
> whether a rate is using CCK or OFDM encoding. Instead, just look at the
> rate index, since at least mt76 and ath10k both seem to have the same
> number of CCK rates (4) in their tables.

This is highly questionable ...

> +	switch (status->encoding) {
> +	case RX_ENC_LEGACY:
> +		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
> +			return 0;
> +
> +		sband = hw->wiphy->bands[status->band];
> +		if (!sband || status->rate_idx > sband->n_bitrates)
> +			return 0;
> +
> +		rate = &sband->bitrates[status->rate_idx];
> +		cck = (status->rate_idx < CCK_NUM_RATES);

Why not

	cck = rate->flags & IEEE80211_RATE_MANDATORY_B;

I mean .. we know that IEEE80211_RATE_MANDATORY_B rates are exactly the
CCK rates, and that's not really going to change?

Alternatively, we could do

	cck = sband->band == NL80211_BAND_2GHZ &&
	      !(rate->flags & IEEE80211_RATE_ERP_G);

or even

	cck = rate->bitrate == 10 || rate->bitrate == 20 ||
	      rate->bitrate == 55 || rate->bitrate == 110;

:)

> +	default:
> +		WARN_ON_ONCE(1);

You can't do that in mac80211 either. That might be fine for mt76, but
mac80211 already supports HE.

johannes

