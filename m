Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15664319B7B
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 09:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhBLIst (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 03:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhBLIss (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 03:48:48 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932AC061574
        for <linux-wireless@vger.kernel.org>; Fri, 12 Feb 2021 00:48:08 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lAU7S-001mFs-Tw; Fri, 12 Feb 2021 09:48:07 +0100
Message-ID: <35860befe3c3310e7df34417300cd3e06b6dad44.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] cfg80211: Handling driver updated MU-EDCA params
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Muna Sinada <msinada@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 12 Feb 2021 09:48:06 +0100
In-Reply-To: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
References: <1607468044-31789-1-git-send-email-msinada@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-12-08 at 14:54 -0800, Muna Sinada wrote:
> Added necessary functions and attributes to be able to pass driver
> updated MU-EDCA parameters from mac80211 to user space.

Please write a proper commit message, in imperative voice.

> +/**
> + * cfg80211_update_muedca_params_event - Notify the updated MU-EDCA parameters
> + *	to user space.

"Notify the ... to" sounds really odd to me - "notify userspace about
updated ..." or something?

Also this is missing a lot of commit message to explain what this does
and when it's needed.

> + *
> + * @wiphy: the wiphy
> + * @params: Updated MU-EDCA parameters
> + * @gfp: allocation flags
> + */
> +void cfg80211_update_muedca_params_event(struct wiphy *wiphy,
> +					 struct ieee80211_mu_edca_param_set
> +					 *params, gfp_t gfp);

that line breaking is awful

> @@ -1408,6 +1413,7 @@ enum nl80211_commands {
>  
>  	NL80211_CMD_CONTROL_PORT_FRAME_TX_STATUS,
>  
> +	NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS,
>  	/* add new commands above here */

a blank line would be nice

>   *	This is a u8 attribute that encapsulates one of the values from
>   *	&enum nl80211_sae_pwe_mechanism.
>   *
> + * @NL80211_ATTR_HE_MUEDCA_PARAMS: MU-EDCA AC parameters for the
> + *	%NL80211_CMD_UPDATE_HE_MUEDCA_PARAMS command.

That should explain the data type.

>   * @NUM_NL80211_ATTR: total number of nl80211_attrs available
>   * @NL80211_ATTR_MAX: highest attribute number currently defined
>   * @__NL80211_ATTR_AFTER_LAST: internal use
> @@ -3025,6 +3034,7 @@ enum nl80211_attrs {
>  
>  	NL80211_ATTR_SAE_PWE,
>  
> +	NL80211_ATTR_HE_MUEDCA_PARAMS,
>  	/* add attributes here, update the policy in nl80211.c */

blank line again

> +void cfg80211_update_muedca_params_event(struct wiphy *wiphy,
> +					 struct ieee80211_mu_edca_param_set
> +					 *params, gfp_t gfp)

line breaks are awful

probably should have tracing.

johannes

