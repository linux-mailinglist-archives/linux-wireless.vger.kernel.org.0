Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3649A47A772
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 10:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhLTJwn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 04:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhLTJwn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 04:52:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37223C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 01:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KlJrdg60r/KjuSLy5I+GSE6vql9IHtR75aqNtJt7He8=;
        t=1639993963; x=1641203563; b=SshRxrBm5j0b9v5+2SEPhGxJc2LwE8aW5lhhUeReIsbkfOi
        Tw7ZfhLy3tGebV5My87H12ZcD2eWDngdL+KHWOis5ccDUvj5RHqJ4wIJEzcysNEdjjEKaAmXqXXpV
        M8wZCToSPnnd3YAfEnxOZTbH777JR5G88nVn1fEasDkzLDYMyvkE9ZhG4m7ikGylk+X6/Q4jII6yJ
        yWHFqDzYGC5owzlvqEn9Ub51fcVYDjbRgUTDA41hUhfBxZN9WJxALAnTgxK5UxOGg7tHdta6PbxwC
        A6pVDe25nMkmKlfPEBZaWYJQ6zjyWSx0PdLtMr6ocFPFxmUSzRrUDXTTe05VE6/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mzFLV-00E3Is-IY;
        Mon, 20 Dec 2021 10:52:41 +0100
Message-ID: <7b7a4c74e7ec7e5516012057c50359c3979d4e67.camel@sipsolutions.net>
Subject: Re: [PATCH v3] nl80211: Add HE UL MU settings used in UL Trigger
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 20 Dec 2021 10:52:40 +0100
In-Reply-To: <1636046620-9663-1-git-send-email-msinada@codeaurora.org>
References: <1636046620-9663-1-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Sorry for the long delay reviewing this here...

> +/*
> + * cfg80211_ul_bitrate_mask - masks for MU uplink bitrate control


Can you add kernel-doc?

Also maybe we should think about EHT already - I guess we can use the
same structure here for EHT in the future?

>  /**
>   * struct cfg80211_tid_cfg - TID specific configuration
> @@ -4233,6 +4245,11 @@ struct cfg80211_ops {
>  				    const u8 *peer,
>  				    const struct cfg80211_bitrate_mask *mask);
>  
> +	int	(*set_ul_bitrate_mask)(struct wiphy *wiphy,
> +				       struct net_device *dev,
> +				       const u8 *peer,
> +				       const struct cfg80211_ul_bitrate_mask *mask);

Missing documentation.

>  	NL80211_CMD_SET_FILS_AAD,
>  
> +	NL80211_CMD_SET_UL_BITRATE_MASK,
>  	/* add new commands above here */

Please keep a newline after.
 
>  	NL80211_ATTR_RADAR_OFFCHAN,
>  
> +	NL80211_ATTR_UL_RATES,
>  	/* add attributes here, update the policy in nl80211.c */

same here
 
>  /**
> + * enum nl80211_ul_rate_attributes - MU uplink rate set attributes
> + * @NL80211_UL_RATE_HE: HE MU UL MCS rates for MU uplink traffic,
> + *	see &struct nl80211_ul_rate_he

Generally, this should be called e.g. NL80211_UL_RATE_ATTR_*, i.e. have
"ATTR" somewhere.

Given my earlier comment about EHT I _think_ it should be

 NL80211_UL_RATE_ATTR_HE_GI

so we can add

 NL80211_UL_RATE_ATTR_EHT_GI

if needed (though I think in that particuilar it's really not needed and
we can use the same GI attribute for both since they both have the same
values.

> +static const struct nla_policy nl80211_ul_rate_attr_policy[NL80211_UL_RATE_MAX + 1] = {
> +	[NL80211_UL_RATE_HE] = NLA_POLICY_EXACT_LEN(sizeof(struct nl80211_ul_rate_he)),
> +	[NL80211_UL_RATE_HE_GI] =  NLA_POLICY_RANGE(NLA_U8,
> +						   NL80211_RATE_INFO_HE_GI_0_8,
> +						   NL80211_RATE_INFO_HE_GI_3_2),
> +	[NL80211_UL_RATE_HE_LTF] = NLA_POLICY_RANGE(NLA_U8,
> +						   NL80211_RATE_INFO_HE_1XLTF,
> +						   NL80211_RATE_INFO_HE_4XLTF),
> +	[NL80211_UL_RATE_HE_LDPC] = { .type = NLA_FLAG },
> +	[NL80211_UL_RATE_HE_STBC] = { .type = NLA_FLAG },
> +};

Nice!

But please link it into the overall policy:

+       [NL80211_ATTR_UL_RATES] =
+		NLA_POLICY_NESTED_ARRAY(nl80211_ul_rate_attr_policy),


I think? The index is the band enum value, but we can still validate it
already?


> +	/* The nested attribute uses enum nl80211_band as the index. This maps
> +	 * directly to the enum nl80211_band values used in cfg80211.
> +	 */
> +	nla_for_each_nested(tx_rates, attrs[attr], rem) {
> +		enum nl80211_band band = nla_type(tx_rates);
> +		int err;
> +
> +		if (band < 0 || band >= NUM_NL80211_BANDS)
> +			return -EINVAL;

NUM_NL80211_BANDS can change, maybe we should just ignore additional
bands?

> +		sband = rdev->wiphy.bands[band];
> +		if (!sband)
> +			return -EINVAL;
> +		err = nla_parse_nested_deprecated(tb, NL80211_UL_RATE_MAX,
> +						  tx_rates,
> +						  nl80211_ul_rate_attr_policy,
> +						  info->extack);

Please don't use _deprecated() in new code. And if you link the policy
properly, you don't need it here.

> +		if (tb[NL80211_UL_RATE_HE_LDPC])
> +			mask->control[band].he_ul_ldpc =
> +				!nla_get_flag(tb[NL80211_UL_RATE_HE_LDPC]);
> +		if (tb[NL80211_UL_RATE_HE_STBC])
> +			mask->control[band].he_ul_stbc =
> +				!nla_get_flag(tb[NL80211_UL_RATE_HE_STBC]);

This doesn't make sense - see how nla_get_flag() works and then remove
the if statements :)

> +TRACE_EVENT(rdev_set_ul_bitrate_mask,
> +	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
> +		 const u8 *peer, const struct cfg80211_ul_bitrate_mask *mask),
> +	TP_ARGS(wiphy, netdev, peer, mask),
> +	TP_STRUCT__entry(
> +		WIPHY_ENTRY
> +		NETDEV_ENTRY
> +		MAC_ENTRY(peer)
> +	),
> +	TP_fast_assign(
> +		WIPHY_ASSIGN;
> +		NETDEV_ASSIGN;
> +		MAC_ASSIGN(peer, peer);
> +	),
> +	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", peer: " MAC_PR_FMT,
> +		  WIPHY_PR_ARG, NETDEV_PR_ARG, MAC_PR_ARG(peer))
> +);
> 

A bit more information would be useful, IMHO.

johannes
