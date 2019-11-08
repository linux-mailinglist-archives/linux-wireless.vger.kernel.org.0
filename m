Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A961DF4418
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbfKHKAi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:00:38 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:53452 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730614AbfKHKAi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:00:38 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT14G-0007Lv-CG; Fri, 08 Nov 2019 11:00:36 +0100
Message-ID: <03dc8fd244558b6c08875be0b497a6d3bdf595c8.camel@sipsolutions.net>
Subject: Re: [PATCHv8 2/6] nl80211: Add new netlink attribute for TID
 speicific retry count
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 08 Nov 2019 11:00:35 +0100
In-Reply-To: <1572957714-16085-3-git-send-email-tamizhr@codeaurora.org>
References: <1572957714-16085-1-git-send-email-tamizhr@codeaurora.org>
         <1572957714-16085-3-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> + *	Station specific retry configuration is valid only for STA's
> + *	current connection. i.e. the configuration will be reset to default when
> + *	the station connects back after disconnection/roaming.
> + *	when user-space does not include %NL80211_ATTR_MAC, this configuration
> + *	should be treated as per-netdev configuration. This configuration will
> + *	be cleared when the interface goes down and on the disconnection from a
> + *	BSS. When retry count has never been configured using this command, the
> + *	other available radio level retry configuration
> + *	(%NL80211_ATTR_WIPHY_RETRY_SHORT and %NL80211_ATTR_WIPHY_RETRY_LONG)
> + *	should be used. Driver supporting this feature should advertise
> + *	NL80211_EXT_FEATURE_PER_TID_RETRY_CONFIG and supporting per station
> + *	retry count configuration should advertise
> + *	NL80211_EXT_FEATURE_PER_STA_RETRY_CONFIG.

Here you pretty much copy-pasted all this text ... that's why I think it
should be in some other section. We want *everything* to be like that,
not have to check every single thing for different validity rules.

> + * @NL80211_TID_CONFIG_ATTR_RETRY_SHORT: Number of retries used with data frame
> + *	transmission, user-space sets this configuration in
> + *	&NL80211_CMD_SET_TID_CONFIG. It is u8 type, min value is 1 and
> + *	the max value should be advertised by the driver through
> + *	max_data_retry_count. when this attribute is not present, the driver
> + *	would use the default configuration.
> + * @NL80211_TID_CONFIG_ATTR_RETRY_LONG: Number of retries used with data frame
> + *	transmission, user-space sets this configuration in
> + *	&NL80211_CMD_SET_TID_CONFIG. Its type is u8, min value is 1 and
> + *	the max value should be advertised by the driver through
> + *	max_data_retry_count. when this attribute is not present, the driver
> + *	would use the default configuration.

I'm almost thinking that these should be a struct with two u8 values
instead of two separate attributes, and then renamed to
NL80211_TID_CONFIG_ATTR_RETRY, to carry both and really ensure thaty
they're always together as a single configuration.

This only really works right if we go for the reset= approach I outlined
in the previous patch though, since you otherwise need
NL80211_TID_CONFIG_ATTR_RETRY for the reset ... but that's a pretty
weird thing.

(there are also some typos here like "notfiy")

> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -326,6 +326,9 @@ static int validate_ie_attr(const struct nlattr *attr,
>  	[NL80211_TID_CONFIG_ATTR_TID] = { .type = NLA_U8 },
>  	[NL80211_TID_CONFIG_ATTR_NOACK] =
>  			NLA_POLICY_MAX(NLA_U8, NL80211_TID_CONFIG_DISABLE),
> +	[NL80211_TID_CONFIG_ATTR_RETRY] = { .type = NLA_FLAG },
> +	[NL80211_TID_CONFIG_ATTR_RETRY_SHORT] = { .type = NLA_U8},
> +	[NL80211_TID_CONFIG_ATTR_RETRY_LONG] = { .type = NLA_U8},

The min value of 1 should be reflected in the policy.

> +		if (rdev->wiphy.max_data_retry_count) {
> +			if (nla_put_u8(msg, NL80211_ATTR_MAX_RETRY_COUNT,
> +			    rdev->wiphy.max_data_retry_count))

bad indentation

> +				goto nla_put_failure;
> +		}
> +
>  		state->split_start++;
>  		if (state->split)
>  			break;

Also not sure which section you put this in, but it looks almost like
it's under "case 1:" where it really shouldn't be ... move it to the end
please.

johannes

