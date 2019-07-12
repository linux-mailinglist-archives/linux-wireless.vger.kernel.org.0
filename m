Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E926693D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 10:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfGLIfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 04:35:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:54830 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLIfL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 04:35:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hlr1J-0005om-I3; Fri, 12 Jul 2019 10:35:09 +0200
Message-ID: <957f8c53224ff6479015519de39a49a6d127bff7.camel@sipsolutions.net>
Subject: Re: [PATCH v4 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Fri, 12 Jul 2019 10:35:06 +0200
In-Reply-To: <1562508727-17082-2-git-send-email-ailizaro@codeaurora.org>
References: <1562508727-17082-1-git-send-email-ailizaro@codeaurora.org>
         <1562508727-17082-2-git-send-email-ailizaro@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2019-07-07 at 17:12 +0300, Alexei Avshalom Lazar wrote:
> 
>  /**
> + * struct ieee80211_edmg - EDMG configuration
> + *
> + * This structure describes most essential parameters needed
> + * to describe 802.11ay EDMG configuration
> + *
> + * @channels: bitmap that indicates the 2.16 GHz channel(s)
> + *	that are allowed to be used for transmissions.
> + *	Bit 0 indicates channel 1, bit 1 indicates channel 2, etc.
> + *	Set to 0 indicate EDMG not supported.
> + * @bw_config: Channel BW Configuration subfield encodes
> + *	the allowed channel bandwidth configurations
> + */
> +struct ieee80211_edmg {
> +	u8 channels;
> +	u8 bw_config;
> +};

So I think the enum here like I just said might be good. I don't know
what to really the values in it, but having something that says "yes
this is just a magic number from the spec" would be nice...

Maybe also call it "struct ieee80211_edmg_chan" or something? Not sure,
it's sort of covering both chan and cfg, so probably what you have is
better.

> @@ -350,6 +369,7 @@ struct ieee80211_supported_band {
>  	int n_bitrates;
>  	struct ieee80211_sta_ht_cap ht_cap;
>  	struct ieee80211_sta_vht_cap vht_cap;
> +	struct ieee80211_edmg edmg_cap;

Yeah, I think if you have edmg_cap as the variable name, your naming is
better :)

> + * @edmg: define the EDMG channels.
> + *	This may specify multiple channels and bonding options for the driver
> + *	to choose from, based on BSS configuration.

Here actually I don't understand how you'd specify *multiple* bonding
options? The bw_config is an enum, right?

Or maybe this case should actually *not* be the same struct, but a
different struct with a *bitmap* of the enum values?

But then it'd need a u16 anyway since the enum values go higher, up to
16 according to your code below:

> +#define NL80211_EDMG_BW_CONFIG_MIN	4
> +#define NL80211_EDMG_BW_CONFIG_MAX	15

> +static bool cfg80211_valid_60g_freq(u32 freq)
> +{
> +	return (freq >= 58320 && freq <= 70200);

nit: no need for the parentheses

> +static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
> +{
> +	int max_contiguous = 0;
> +	int num_of_enabled = 0;
> +	int contiguous = 0;
> +	int i;
> +
> +	if (!chandef->edmg.channels && !chandef->edmg.bw_config)
> +		return true;
> +
> +	if ((!chandef->edmg.channels && chandef->edmg.bw_config) ||
> +	    (chandef->edmg.channels && !chandef->edmg.bw_config) ||
> +	    !cfg80211_valid_60g_freq(chandef->chan->center_freq))
> +		return false;

That's a bit hard to read, maybe pull out the valid_60g_freq into a
separate if statement?

And after the "!channels && !bw_config" part, you don't actually need
the whole condition that way, you just need

	if (!channels || !bw_config)
		return false;

since both cannot be unset at this point.

> @@ -112,7 +206,7 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
>  		return false;
>  	}
>  
> -	return true;
> +	return cfg80211_edmg_chandef_valid(chandef);


I *think* I might prefer the "could this be an EDMG channel" condition
to be outside, i.e.

	if ((chandef->edmg.channels || chandef->edmg.bw_config) &&
	    !cfg80211_edmg_chandef_valid(chandef))
		return false;

	return true;


That's clearly equivalent to what you have now, but I think it's easier
to understand that we only enter the "edmg_chandef_valid()" when it
looks like an EDMG channel and we thus need to validate it.

I'd even go as far as saying that we should have an inline for it in
cfg80211.h:

static inline bool cfg80211_chandef_is_edmg(...)
{
	return chandef->edmg.channels || chandef->edmg.bw_config;
}

and we use that in the code I wrote above, as well as other places that
want to ask this question.


> +	[NL80211_ATTR_WIPHY_EDMG_CHANNELS] = { .type = NLA_U8 },

Since you say there are only 6 channels, this probably also has a lower
bound of 1 (need to set at least one bit) and an upper bound of 63 (all
lower 6 bits set)?

In any case, thanks for your work on this, and especially for your
patience with me reviewing.

johannes

