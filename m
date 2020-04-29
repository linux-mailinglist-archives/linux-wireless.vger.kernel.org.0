Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1EB1BE0D9
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgD2O0v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 10:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbgD2O0v (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 10:26:51 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BCBC03C1AD
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2020 07:26:51 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jTnfl-001wuG-Km; Wed, 29 Apr 2020 16:26:49 +0200
Message-ID: <73a4e63e16bffb69cd9b62fd904b926dd5278fbf.camel@sipsolutions.net>
Subject: Re: [PATCH 02/10] cfg80211: validate 6 GHz chandef
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 29 Apr 2020 16:26:48 +0200
In-Reply-To: <1587768108-25248-3-git-send-email-rmanohar@codeaurora.org>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
         <1587768108-25248-3-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
> 
> +static inline bool
> +cfg80211_chandef_is_6ghz(const struct cfg80211_chan_def *chandef)
> +{
> +	return (chandef->center_freq1 > 5940 && chandef->center_freq1 < 7105);
> +}

Seems like this

> +++ b/net/wireless/chan.c
> @@ -19,6 +19,29 @@ static bool cfg80211_valid_60g_freq(u32 freq)
>  	return freq >= 58320 && freq <= 70200;
>  }
>  
> +static bool cfg80211_is_6ghz_freq(u32 freq)
> +{
> +	return (freq > 5940 && freq < 7105);
> +}

should use this, by also exposing it, or something.

> +static enum nl80211_chan_width cfg80211_chan_to_bw_6ghz(u8 idx)
> +{
> +	/* channels: 1, 5, 9, 13... */
> +	if ((idx & 0x3) == 0x1)
> +		return NL80211_CHAN_WIDTH_20;
> +	/* channels 3, 11, 19... */
> +	if ((idx & 0x7) == 0x3)
> +		return NL80211_CHAN_WIDTH_40;
> +	/* channels 7, 23, 39.. */
> +	if ((idx & 0xf) == 0x7)
> +		return NL80211_CHAN_WIDTH_80;
> +	/* channels 15, 47, 79...*/
> +	if ((idx & 0x1f) == 0xf)
> +		return NL80211_CHAN_WIDTH_160;
> +
> +	return NL80211_CHAN_WIDTH_20;
> +}

We haven't really done that for anything else - is that really
necessary?

> +static bool cfg80211_6ghz_chandef_valid(const struct cfg80211_chan_def *chandef)
> +{
> +	enum nl80211_chan_width bw;
> +	int chan_idx;
> +
> +	if (!cfg80211_is_6ghz_freq(chandef->center_freq1))
> +		return false;

this is kinda pointless,

> @@ -213,6 +255,10 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
>  	    !cfg80211_edmg_chandef_valid(chandef))
>  		return false;
>  
> +	if (cfg80211_chandef_is_6ghz(chandef) &&
> +	    !cfg80211_6ghz_chandef_valid(chandef))
> +		return false;

You only get there if it was in range ...

Not sure about this whole patch, it seems a bit pointless?

johannes

