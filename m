Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6A27BCF3
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387399AbfGaJYZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 05:24:25 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55414 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfGaJYZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 05:24:25 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hskqM-0004Zv-0w; Wed, 31 Jul 2019 11:24:22 +0200
Message-ID: <6351a05f5c205db47740116b4bec5a6476317792.camel@sipsolutions.net>
Subject: Re: [PATCHv6 2/9] nl80211: Add new netlink attribute for TID
 speicific retry count
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:24:21 +0200
In-Reply-To: <1560835632-17405-3-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
         <1560835632-17405-3-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

^^ there's a typo in the subject

> @@ -3951,6 +3957,7 @@ enum wiphy_flags {
>  	WIPHY_FLAG_SUPPORTS_5_10_MHZ		= BIT(22),
>  	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
>  	WIPHY_FLAG_HAS_STATIC_WEP		= BIT(24),
> +	WIPHY_FLAG_HAS_MAX_DATA_RETRY_COUNT	= BIT(25),

This is never used, so that doesn't make sense? You probably want to
advertise the max_data_retry_count value contingent on this flag (*) in
some attribute, so that userspace can also detect the presence/absence
of the flag for the feature?

(*) doesn't really need to be contingent on the flag - could just be
contingent on max_data_retry_count being non-zero and then you don't
need the flag.

> + * @NL80211_ATTR_MAX_RETRY_COUNT: The upper limit for the retry count
> + *	configuration that the driver can accept.
>   *
>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
> @@ -2823,6 +2825,7 @@ enum nl80211_attrs {
>  	NL80211_ATTR_TWT_RESPONDER,
>  
>  	NL80211_ATTR_TID_CONFIG,
> +	NL80211_ATTR_MAX_RETRY_COUNT,

You already have the attribute, but again, aren't using it.

> + * @NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG: Driver supports per TID data retry
> + *	count functionality.
> + * @NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG: Driver supports STA specific
> + *	data retry count functionality.

and if you have these you don't need the WIPHY_FLAG anyway?

> +	[NL80211_TID_ATTR_CONFIG_RETRY] = { .type = NLA_FLAG },
> +	[NL80211_TID_ATTR_CONFIG_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 0),
> +	[NL80211_TID_ATTR_CONFIG_RETRY_LONG] = NLA_POLICY_MIN(NLA_U8, 0),

min of 0 doesn't make sense, maybe you meant 1? otherwise just don't set
anything here.


> +					    "TID specific configuration not "
> +					    "supported");

This applies to all the patches - please don't break strings across
multiple lines, even if they cross 80 columns. Even checkpatch won't
give you any warning on this.

> +		tid_conf->tid_conf_mask |= IEEE80211_TID_CONF_RETRY;
> +		if (attrs[NL80211_TID_ATTR_CONFIG_RETRY_SHORT]) {
> +			tid_conf->retry_short =
> +			nla_get_u8(attrs[NL80211_TID_ATTR_CONFIG_RETRY_SHORT]);
> +			if (tid_conf->retry_short >
> +					rdev->wiphy.max_data_retry_count)
> +				return -EINVAL;
> +		} else {
> +			tid_conf->retry_short = -1;
> +		

I guess you should document that -1 means no changes? Not sure how the
IEEE80211_TID_CONF_RETRY comes in, you're always setting it, so that's
useless - better remove that and document that -1 means no changes?

johannes

