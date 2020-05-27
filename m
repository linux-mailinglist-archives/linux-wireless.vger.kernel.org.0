Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E68C1E441B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2020 15:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbgE0Nnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 May 2020 09:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0Nnq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 May 2020 09:43:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D611C08C5C1
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 06:43:46 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdwLP-0047mV-Da; Wed, 27 May 2020 15:43:43 +0200
Message-ID: <7f2a2a382c42b7285b9ad1eeac4e8060bc8d897a.camel@sipsolutions.net>
Subject: Re: [PATCH v3 01/11] cfg80211: use only HE capability to set
 prohibited flags in 6 GHz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Vamsi Krishna <vamsin@codeaurora.org>
Date:   Wed, 27 May 2020 15:43:41 +0200
In-Reply-To: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
References: <1589399105-25472-1-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

This is what we have in this area:
https://p.sipsolutions.net/d8e56772a261199a.txt

but I see it's also incomplete.

> +static bool cfg80211_is_6ghz_freq(u32 freq)
> +{
> +	return (freq > 5940 && freq < 7105);
> +}

That doesn't really make sense, I don't want to see those hardcoded
frequencies all over the place.

>  	case NL80211_CHAN_WIDTH_40:
>  		width = 40;
> +		if (cfg80211_is_6ghz_freq(chandef->center_freq1)) {

You can check chandef->chan->band instead. (In fact, we did)

> +			if (!he_cap)
> +				return false;
> +			if (!he_cap->has_he_6ghz)
> +				return false;

I'm not sure you should even _get_ here with a 6 GHz channel if you
don't have 6 GHz capability? I mean, why did you register the channel in
the first place then? This seems unnecessarily complex. If the channel
didn't exist, it was rejected long before here.

However, looking at D6.0, maybe we do need some checks of the HE
capability?

> +			if (!(he_cap->he_cap_elem.phy_cap_info[0] &
> +			      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G))
> +				return false;

Looks like even D6.0 still changed something in this area...

Evidently our patch just assumed that in 6 GHz all of this is supported,
but the spec doesn't support that theory :-)

Can you respin this with D6.0 taken into account?

johannes

