Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A824F26FABB
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Sep 2020 12:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgIRKiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Sep 2020 06:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgIRKiM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Sep 2020 06:38:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F3FC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 18 Sep 2020 03:38:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kJDmL-006CNL-JC; Fri, 18 Sep 2020 12:38:09 +0200
Message-ID: <c5b93cd207ce780a56ad2689d7660fee48683fe9.camel@sipsolutions.net>
Subject: Re: [PATCH v2 06/22] {cfg,mac}80211: get correct default channel
 width for S1G
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Fri, 18 Sep 2020 12:38:08 +0200
In-Reply-To: <20200831205600.21058-7-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
         <20200831205600.21058-7-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-08-31 at 13:55 -0700, Thomas Pedersen wrote:
> 
> +++ b/net/wireless/chan.c
> @@ -33,6 +33,16 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
>  	chandef->edmg.bw_config = 0;
>  	chandef->edmg.channels = 0;
>  
> +	/* S1G allows a single width per channel, and since chan_type seems to
> +	 * be for backwards compatibility only, ignore it and return the per
> +	 * frequency width.
> +	 */
> +	if (chan->band == NL80211_BAND_S1GHZ) {
> +		chandef->width = ieee80211_s1g_channel_width(chan);
> +		chandef->center_freq1 = chan->center_freq;
> +		return;
> +	}

Hmm. I'm not sure I want to let you get away with this?

It might be ... convenient, but it's also confusing to see something
like

	cfg80211_chandef_create(&out, some_channel, NL80211_CHAN_HT40PLUS);

actually create an S1G channel width?

Yes, this is mostly for backward compatibility, but it's also used in
few (21 in the stack) places. Many of those aren't relevant, e.g. in
net/mac80211/ibss.c it would obviously be clearer to handle the new
NL80211_CHAN_WIDTH_* values with e.g. a cfg80211_get_s1g_chandef()
function or so that does this derivation, instead of running into the

        default:
                /* fall back to 20 MHz for unsupported modes */
                cfg80211_chandef_create(&chandef, cbss->channel,
                                        NL80211_CHAN_NO_HT);

code.

IOW, it seems to me that this function should actually instead throw a
warning (and then perhaps configure something sane?), but not be the
default code path.

johannes

