Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9437BD20
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 11:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfGaJ2N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 05:28:13 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55498 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfGaJ2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 05:28:13 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsku1-0004eq-4J; Wed, 31 Jul 2019 11:28:09 +0200
Message-ID: <1077c62701b31cfcb4436e6b13be64ade6b1ae1b.camel@sipsolutions.net>
Subject: Re: [PATCHv6 3/9] nl80211: Add netlink attribute for AMPDU
 aggregation enable/disable
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Tamizh chelvam <tamizhr@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 31 Jul 2019 11:28:08 +0200
In-Reply-To: <1560835632-17405-4-git-send-email-tamizhr@codeaurora.org>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
         <1560835632-17405-4-git-send-email-tamizhr@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-06-18 at 10:57 +0530, Tamizh chelvam wrote:
> 
> +		if (!wiphy_ext_feature_isset(&rdev->wiphy,
> +				NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL)) {
> +			NL_SET_ERR_MSG_ATTR(extack,
> +					    attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
> +					    "TID specific configuration not "
> +					    "supported");
> +			return -ENOTSUPP;
> +		}
> +
> +		if (peer && !wiphy_ext_feature_isset(&rdev->wiphy,
> +				NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL)) {
> +			NL_SET_ERR_MSG_ATTR(extack,
> +					    attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
> +					    "peer specfic TID configuration not "
> +					    "supported");
> +			return -ENOTSUPP;
> +		}

I think you should probably make this be a function to which you pass
the attribute pointer and feature flags.

err = nl80211_check_tid_config_supported(extack,
					 attrs[NL80211_TID_ATTR_CONFIG_AMPDU_CTRL],
					 NL80211_EXT_FEATURE_PER_TID_AMPDU_CTRL,
					 NL80211_EXT_FEATURE_PER_STA_AMPDU_CTRL);

since you have this code a lot?

johannes

