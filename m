Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C397445CDF
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfFNMbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 08:31:37 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:41246 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 08:31:36 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hblMG-0008Ae-CU; Fri, 14 Jun 2019 14:31:04 +0200
Message-ID: <d1c2fd8d99d8f8420ba265f31709da9326ad38f1.camel@sipsolutions.net>
Subject: Re: [PATCH v3 1/2] nl80211: Add support for EDMG channels
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexei Avshalom Lazar <ailizaro@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com
Date:   Fri, 14 Jun 2019 14:31:02 +0200
In-Reply-To: <1558364020-11064-2-git-send-email-ailizaro@codeaurora.org>
References: <1558364020-11064-1-git-send-email-ailizaro@codeaurora.org>
         <1558364020-11064-2-git-send-email-ailizaro@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Alexei,

Sorry for the long delay here.

I have a few questions.

Looking at this:

>  /**
> + * struct ieee80211_sta_edmg_cap - EDMG capabilities
> + *
> + * This structure describes most essential parameters needed
> + * to describe 802.11ay EDMG capabilities
> + *
> + * @channels: bitmap that indicates the 2.16 GHz channel(s)
> + *	that are allowed to be used for transmissions in the BSS.
> + *	Set to 0 indicate EDMG not supported.
> + * @bw_config: Channel BW Configuration subfield encodes
> + *	the allowed channel bandwidth configurations
> + */
> +struct ieee80211_sta_edmg_cap {
> +	u8 channels;
> +	u8 bw_config;
> +};

What are the bits actually? Seems you should define some enum or so that
shows which bits are used here?

>   * @center_freq1: center frequency of first segment
>   * @center_freq2: center frequency of second segment
>   *	(only with 80+80 MHz)
> + * @edmg_channels: bitmap that indicates the 2.16 GHz channel(s)
> + *	that are allowed to be used for transmissions in the BSS.
> + * @edmg_bw_config: Channel BW Configuration subfield encodes
> + *	the allowed channel bandwidth configurations
>   */
>  struct cfg80211_chan_def {
>  	struct ieee80211_channel *chan;
>  	enum nl80211_chan_width width;
>  	u32 center_freq1;
>  	u32 center_freq2;
> +	u8 edmg_channels;
> +	u8 edmg_bw_config;
>  };

This isn't clear to me. How can the capability and the configuration be
exactly the same? In the capability, you should be able to capture
multiple possible things, and in the setting only choose one?

And if they really are the same, why not use the struct
ieee80211_sta_edmg_cap here? Seems weird to me, but I don't know 11ay.


Also, I think you should describe a bit more how this plays together
with the existing settings. Will ->chan still be set, to something like
the control channel?

>  /**
> @@ -1144,15 +1169,17 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
>   * @RATE_INFO_FLAGS_MCS: mcs field filled with HT MCS
>   * @RATE_INFO_FLAGS_VHT_MCS: mcs field filled with VHT MCS
>   * @RATE_INFO_FLAGS_SHORT_GI: 400ns guard interval
> - * @RATE_INFO_FLAGS_60G: 60GHz MCS
> + * @RATE_INFO_FLAGS_DMG: 60GHz MCS
>   * @RATE_INFO_FLAGS_HE_MCS: HE MCS information
> + * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
>   */
>  enum rate_info_flags {
>  	RATE_INFO_FLAGS_MCS			= BIT(0),
>  	RATE_INFO_FLAGS_VHT_MCS			= BIT(1),
>  	RATE_INFO_FLAGS_SHORT_GI		= BIT(2),
> -	RATE_INFO_FLAGS_60G			= BIT(3),
> +	RATE_INFO_FLAGS_DMG			= BIT(3),
>  	RATE_INFO_FLAGS_HE_MCS			= BIT(4),
> +	RATE_INFO_FLAGS_EDMG			= BIT(5),
>  };
>  
>  /**
> @@ -1192,6 +1219,7 @@ enum rate_info_bw {
>   * @he_dcm: HE DCM value
>   * @he_ru_alloc: HE RU allocation (from &enum nl80211_he_ru_alloc,
>   *	only valid if bw is %RATE_INFO_BW_HE_RU)
> + * @n_bonded_ch: In case of EDMG the number of bonded channels (1-4)
>   */
>  struct rate_info {
>  	u8 flags;
> @@ -1202,6 +1230,7 @@ struct rate_info {
>  	u8 he_gi;
>  	u8 he_dcm;
>  	u8 he_ru_alloc;
> +	u8 n_bonded_ch;
>  };


It seems like this is missing corresponding nl80211.h changes?

> @@ -2436,6 +2469,8 @@ struct cfg80211_connect_params {
>  	const u8 *fils_erp_rrk;
>  	size_t fils_erp_rrk_len;
>  	bool want_1x;
> +	u8 edmg_channels;
> +	u8 edmg_bw_config;
>  };

Same question as above, why not embed the struct if it's the same?

Again it seems like it shouldn't be the same though.
 
> + * @NL80211_ATTR_WIPHY_EDMG_CHANNELS: bitmap that indicates the 2.16 GHz
> + *	channel(s) that are allowed to be used for EDMG transmissions in the
> + *	BSS as defined by IEEE 802.11 section 9.4.2.251.
> + * @NL80211_ATTR_WIPHY_EDMG_BW_CONFIG: Channel BW Configuration subfield encodes
> + *	the allowed channel bandwidth configurations as defined by IEEE 802.11
> + *	section 9.4.2.251, Table 13.

This is unclear - "in the BSS" means nothing in this context, since
you're using this to advertise capabilities?

This isn't a BSS attribute, after all.

Ah - but looking further, you use this to *set* the channel, not for
capabilities... I guess that makes sense.


>   * @NL80211_BAND_ATTR_VHT_CAPA: VHT capabilities, as in the HT information IE
>   * @NL80211_BAND_ATTR_IFTYPE_DATA: nested array attribute, with each entry using
>   *	attributes from &enum nl80211_band_iftype_attr
> + * @NL80211_BAND_ATTR_EDMG_CHANNELS: bitmap that indicates the 2.16 GHz
> + *	channel(s) that are allowed to be used for EDMG transmissions in the
> + *	BSS as defined by IEEE 802.11 section 9.4.2.251.
> + * @NL80211_BAND_ATTR_EDMG_BW_CONFIG: Channel BW Configuration subfield
> + *	encodes the allowed channel bandwidth configurations as defined by
> + *	IEEE 802.11 section 9.4.2.251, Table 13.
>   * @NL80211_BAND_ATTR_MAX: highest band attribute currently defined
>   * @__NL80211_BAND_ATTR_AFTER_LAST: internal use

And ... that makes more sense than the global attribute I guess?

> +static bool cfg80211_edmg_chandef_valid(const struct cfg80211_chan_def *chandef)
> +{
> +	int max_continuous = 0;
> +	int num_of_enabled = 0;
> +	int continuous = 0;

do you mean "contiguous"? "continuous" doesn't make much sense?

> +	int i;
> +
> +	if (!chandef->edmg_channels && !chandef->edmg_bw_config)
> +		return true;
> +
> +	if ((!chandef->edmg_channels && chandef->edmg_bw_config) ||
> +	    (chandef->edmg_channels && !chandef->edmg_bw_config))
> +		return false;

There probably should be some kind of WARN_ON() check that validates you
get here only if the ->chan is actually 60GHz?

> +++ b/net/wireless/nl80211.c
> @@ -288,6 +288,9 @@ static int validate_ie_attr(const struct nlattr *attr,
>  
>  	[NL80211_ATTR_WIPHY_FREQ] = { .type = NLA_U32 },
>  	[NL80211_ATTR_WIPHY_CHANNEL_TYPE] = { .type = NLA_U32 },
> +	[NL80211_ATTR_WIPHY_EDMG_CHANNELS] = { .type = NLA_U8 },
> +	[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG] = { .type = NLA_U8 },

You probably want something like NLA_POLICY_RANGE() here? This was only
1-4 IIRC?

> +	if (info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]) {
> +		chandef->edmg_channels =
> +		      nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_CHANNELS]);
> +
> +		if (info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG])
> +			chandef->edmg_bw_config =
> +		     nla_get_u8(info->attrs[NL80211_ATTR_WIPHY_EDMG_BW_CONFIG]);
> +	} else {
> +		chandef->edmg_bw_config = 0;
> +		chandef->edmg_channels = 0;
> +	}
> +
>  	if (!cfg80211_chandef_valid(chandef)) {

So I guess what I suggested above shouldn't actually be a WARN_ON() but
just a check w/o WARN_ON()?

johannes

