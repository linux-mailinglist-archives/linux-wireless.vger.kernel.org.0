Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4490C59CE0
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 15:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfF1NV7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 09:21:59 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:50578 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726601AbfF1NV7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 09:21:59 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hgqpA-0001tO-QT; Fri, 28 Jun 2019 15:21:57 +0200
Message-ID: <77b693b163faf61d72b2734b97081734f0345211.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Fri, 28 Jun 2019 15:21:55 +0200
In-Reply-To: <1561458567-31866-2-git-send-email-ailizaro@codeaurora.org>
References: <1561458567-31866-1-git-send-email-ailizaro@codeaurora.org>
         <1561458567-31866-2-git-send-email-ailizaro@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-25 at 13:29 +0300, Alexei Avshalom Lazar wrote:
> 
>  /**
> + * struct ieee80211_sta_edmg_cap - EDMG capabilities
> + *
> + * This structure describes most essential parameters needed
> + * to describe 802.11ay EDMG capabilities
> + *
> + * @channels: bitmap that indicates the 2.16 GHz channel(s)
> + *	that are allowed to be used for transmissions.
> + *	Bit 0 indicates channel 1, bit 1 indicates channel 2, etc.
> + *	Set to 0 indicate EDMG not supported.
> + * @bw_config: Channel BW Configuration subfield encodes
> + *	the allowed channel bandwidth configurations
> + */
> +struct ieee80211_sta_edmg_cap {
> +	u8 channels;
> +	u8 bw_config;
> +};

[...]

> + * @edmg: define the EDMG channels configuration.
> + *	If edmg is set, chan will define the primary channel and all other
> + *	parameters are ignored.
>   
>  struct cfg80211_chan_def {

Thinking out loud, maybe this should say "If edmg is requested (i.e. the
.channels member is non-zero) [...]" or so?

> @@ -1192,6 +1218,7 @@ enum rate_info_bw {
>   * @he_dcm: HE DCM value
>   * @he_ru_alloc: HE RU allocation (from &enum nl80211_he_ru_alloc,
>   *	only valid if bw is %RATE_INFO_BW_HE_RU)
> + * @n_bonded_ch: In case of EDMG the number of bonded channels (1-4)

So, just for the stupid me because I didn't really read the spec.

You have N channels (can only be 8 since you use a u8, looking at the
code further it looks like there are only 7) and edmg_cap::channels
indicates which are supported/requested, and then edmg_cap::bw_config
indicates how the channels are used?

I'm not sure I understand this part, because if you, say, request
channels 1 and 2 (channels=0x3) then what configurations could be
possible below that?

Oh, something about the primary channel maybe?


I guess I would've expected something like a list of bitmaps that the
device supports, and then at runtime you select only one bitmap.

If I have channels 1 and 2 enabled, how do the configurations differ?

Clearly they don't differ enough to make capturing them in the rate
worthwhile, here n_bonded_ch would presumably only be 2, and that's
enough to tell the rate. What then does the configuration mean?


It seems to me that you should, however, expose n_bonded_ch to
userspace? We do expose all the details about the bitrate normally, see
nl80211_put_sta_rate(). We do calculate the bitrate to expose that too,
but do expose all the details too.

Hmm. Looking at that, it looks like DMG doesn't actually do that. So
perhaps not, though it seems to me that it ought to be possible?

> @@ -2436,6 +2467,7 @@ struct cfg80211_connect_params {
>  	const u8 *fils_erp_rrk;
>  	size_t fils_erp_rrk_len;
>  	bool want_1x;
> +	struct ieee80211_sta_edmg_cap edmg;

Maybe we really should rename this struct type? It's not a "capability"
here.

> +static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
> +{
> +	int max_continuous = 0;
> +	int num_of_enabled = 0;
> +	int contiguous = 0;

max_continuous vs. contiguous is even more confusing now :-)


> +		max_continuous = max(contiguous, max_continuous);

See? :)

> +	/* basic verification of edmg configuration according to
> +	 * IEEE802.11 section 9.4.2.251

All the IEEE 802.11 references (more than just this one) ... please
qualify them with a version. I'm thinking these are not in -2016, so
probably 802.11ay (perhaps even draft?)

> +	 */
> +	/* check bw_config against contiguous edmg channels */
> +	switch (chandef->edmg.bw_config) {
> +	case 4:
> +	case 8:
> +	case 12:
> +		if (max_continuous < 1)
> +			return false;
> +		break;

I guess I really should try to find a copy of the appropriate spec ...

johannes

