Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4119A5AE
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 08:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgDAGye (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 02:54:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33406 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbgDAGye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 02:54:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jJXGh-00BRTz-Oz; Wed, 01 Apr 2020 08:54:31 +0200
Message-ID: <52850c8eb3131ca742eea30a21a7e685a3a3045b.camel@sipsolutions.net>
Subject: Re: [RFC 2/7] cfg80211: express channels with a KHz component
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 01 Apr 2020 08:54:30 +0200
In-Reply-To: <20200401062150.3324-3-thomas@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
         <20200401062150.3324-3-thomas@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-31 at 23:21 -0700, Thomas Pedersen wrote:
> 
> +/**
> + * ieee80211_get_channel_khz - get channel struct from wiphy for specified
> + * frequency

You can't line-break there, but I think I learned a while back that you
can do

/**
 * ieee80211_get_channel_khz -
 * get channel ...

or something like that. Maybe try?

> +/**
> + * ieee80211_chandef_to_khz - convert chandef to frequency in KHz
> + *
> + * @chandef: the chandef to convert
> + *
> + * Returns the center frequency of chandef (1st segment) in KHz.
> + */
> +u32 ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef);

Isn't this one trivial, and probably better inlined (mhz*1000 + khz)?

> +u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
> +{
> +	return __ieee80211_channel_to_frequency(chan, band);
> +}
> +EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
> +
> +int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
> +{
> +	return KHZ_TO_MHZ(__ieee80211_channel_to_frequency(chan, band));
> +}
>  EXPORT_SYMBOL(ieee80211_channel_to_frequency);
>  
> -int ieee80211_frequency_to_channel(int freq)
> +u32 ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
> +{
> +	return MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;
> +}
> +EXPORT_SYMBOL(ieee80211_channel_to_khz);

Some of these should probably be inlines? Or maybe all of them, and

> +static int __ieee80211_frequency_to_channel(u32 freq)

export the double-underscore helpers like this one instead? That'd still
be less code overall, IMHO.

> +int ieee80211_freq_khz_to_channel(u32 freq)
> +{
> +	return __ieee80211_frequency_to_channel(freq);
> +}
> +EXPORT_SYMBOL(ieee80211_freq_khz_to_channel);
> +
> +int ieee80211_frequency_to_channel(int freq)
> +{
> +	return __ieee80211_frequency_to_channel(MHZ_TO_KHZ(freq));
> +}
>  EXPORT_SYMBOL(ieee80211_frequency_to_channel);

similarly here, I guess.

> +struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
> +						    u32 freq)
> +{
> +	return __ieee80211_get_channel(wiphy, freq);
> +}
> +EXPORT_SYMBOL(ieee80211_get_channel_khz);
> +
> +struct ieee80211_channel *ieee80211_get_channel(struct wiphy *wiphy,
> +						int freq)
> +{
> +	return __ieee80211_get_channel(wiphy, MHZ_TO_KHZ(freq));
> +}
>  EXPORT_SYMBOL(ieee80211_get_channel);

And maybe here? In fact, how is __ieee80211_get_channel() even different
from ieee80211_get_channel_khz()?
 
> @@ -1670,6 +1716,12 @@ bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
>  }
>  EXPORT_SYMBOL(ieee80211_chandef_to_operating_class);
>  
> +u32 ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef)
> +{
> +	return MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
> +}
> +EXPORT_SYMBOL(ieee80211_chandef_to_khz);

That's like I thought above.

I think that'd have less code overall, don't you think?

johannes

