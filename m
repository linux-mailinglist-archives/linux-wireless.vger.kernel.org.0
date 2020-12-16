Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC3D2DC81D
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 22:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgLPVES (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 16:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgLPVER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 16:04:17 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D8BC06179C
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 13:03:37 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kpdxP-00AGxH-Ua; Wed, 16 Dec 2020 22:03:36 +0100
Message-ID: <893856dcc9ff9adf65b0bcdbb6ce127d56980ee8.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] mac80211: add rx decapsulation offload support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Wed, 16 Dec 2020 22:03:35 +0100
In-Reply-To: <20201216204316.44498-7-nbd@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
         <20201216204316.44498-7-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
> 
> +	offload = assign &&
> +		  (sdata->vif.offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED);
> +
> +	if (offload)
> +		set_offload = !test_and_set_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
> +	else
> +		set_offload = test_and_clear_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
> +
> +	if (set_offload)
> +		drv_sta_set_decap_offload(local, sdata, &sta->sta, assign);

Some of these lines look a bit long?

> -	skb = ieee80211_rx_monitor(local, skb, rate);
> +	if (!(status->flag & RX_FLAG_8023))
> +		skb = ieee80211_rx_monitor(local, skb, rate);

Is that worth the check? You basically disable it anyway if monitor
interfaces are there.

Not sure that's really the right thing to do ... we often want monitor
interfaces (with no flags set) for debug?

Or maybe we should add some tracing then (instead).

johannes

