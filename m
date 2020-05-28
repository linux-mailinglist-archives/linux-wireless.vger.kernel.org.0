Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08191E5831
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 09:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgE1HIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HIM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 03:08:12 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F398C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 00:08:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeCe7-004hbn-BT; Thu, 28 May 2020 09:08:07 +0200
Message-ID: <643b2e386881de3051f35eaf64d36344cb2df9f6.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/9] cfg80211: Add helper function to identify 6GHz
 PSC channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 09:08:06 +0200
In-Reply-To: <20200526224217.11119-2-pradeepc@codeaurora.org> (sfid-20200527_004804_951011_BE3F0562)
References: <20200526224217.11119-1-pradeepc@codeaurora.org>
         <20200526224217.11119-2-pradeepc@codeaurora.org>
         (sfid-20200527_004804_951011_BE3F0562)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-05-26 at 15:42 -0700, Pradeep Kumar Chitrapu wrote:
Hi,

Just checked what we had here, and it was the following:

> +/**
> + * ieee80211_is_channel_psc - is 6ghz channel a Preferred Scanning Channel (PSC)
> + *
> + * @chan: struct ieee80211_channel to determine
> + * Return: True if 6ghz channel is a PSC channel. False for the rest.
> + */
> +static inline bool ieee80211_is_channel_psc(struct ieee80211_channel *chan)
> +{
> +	if (chan->band != NL80211_BAND_6GHZ)
> +		return false;
> +
> +	/*
> +	 * From IEEE P802.11ax/D6.1: The set of 20 MHz channels in the 6 GHz
> +	 * band, with channel center frequency, ch_a = Channel starting
> +	 * frequency – 55  80 × n (MHz) are referred to as preferred scanning
> +	 * channels (PSCs). Channel starting frequency is defined in 27.3.23.2
> +	 * (Channel allocation in the 6 GHz band), and n = 1, …, 15.
> +	 */
> +	if (!(((chan->center_freq - 5950 + 55) >> 4) % 5))
> +		return true;
> +
> +	return false;
> +}


static inline bool cfg80211_is_psc(struct ieee80211_channel *chan)
{
        int chan_num =
                ieee80211_frequency_to_channel(chan->center_freq);

        return chan->band == NL80211_BAND_6GHZ && chan_num % 16 == 5;
}

Apart from the naming, where I guess I prefer actually

	cfg80211_channel_is_psc()

or so, does that seem reasonable to you? I'd prefer not to hardcode
frequencies everywhere, so in that regard I like our version better.
Maybe bail out earlier if band != 6 ghz:

static inline bool cfg80211_channel_is_psc(struct ieee80211_channel *chan)
{
	if (chan->band != NL80211_BAND_6GHZ)
		return false;

	return ieee80211_frequency_to_channel(chan->center_freq) % 16 == 5;
}

johannes

