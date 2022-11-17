Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C51362D870
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Nov 2022 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbiKQKwL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Nov 2022 05:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239414AbiKQKwC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Nov 2022 05:52:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73FD15710
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 02:52:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41B2460AE3
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 10:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26D3C433C1;
        Thu, 17 Nov 2022 10:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668682320;
        bh=Lb3Y8YZJzUYKLPeAx42l0VS1ZrHBX0qzfcpmMgcFksg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WuxtpEEHZxQiN2bN2avjq3aFG7DBjG2XjKp5u6vzCuOw/GY6WVWTWY+rtRmp1AQum
         cNgdB62NPkY2NSd6mTILS/QwHGGh7ykhPWinz1KRQpJqCmPPH0ofowAEyMV23i4XzC
         STd31Es6A5DGFm1BBekrW9g+pn0+BJZqyuzNt8fJxsxAom2ioQOlHN2rhMdxRlSqZ/
         O+dZXt6eOo00kFQrpDpJUlb6p1gf7F49du14iAZtwjsXW297I8zdnHmaFXV+Q9uiNI
         6e4snZAmH35O6/WF0U9BPxxuGNv47f7jvy5dswiWrko19WIUF5/cXwOsdnQZN0mYCU
         eBx91yBMLzsRQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [RFC PATCH 2/2] wifi: wireless: deny wireless extensions on MLO-capable devices
References: <20221104174218.26f9541c0bfa.Ifcf30eeeb8fc7019e4dcf2782b04515254d165e1@changeid>
        <20221104174218.7817a3abaf39.Ib9eabc2ec5bf6b0244e4d973e93baaa3d8c91bd8@changeid>
Date:   Thu, 17 Nov 2022 12:51:57 +0200
In-Reply-To: <20221104174218.7817a3abaf39.Ib9eabc2ec5bf6b0244e4d973e93baaa3d8c91bd8@changeid>
        (Johannes Berg's message of "Fri, 4 Nov 2022 17:42:21 +0100")
Message-ID: <87r0y1rgz6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Johannes Berg <johannes@sipsolutions.net> writes:

> From: Johannes Berg <johannes.berg@intel.com>
>
> These are new devices that will be introduced into the market

s/new/Wi-Fi 7/?

> in 2023, with new drivers. Wireless extensions haven't been in
> real development since 2006. Since wireless has evolved a lot,
> and continues to evolve significantly with MLO, there's really

s/MLO/Multi-Link Operation/?

It would good to spell out the acronym at least once per commit log.

> no good way to still support wireless extensions for devices
> that do MLO.
>
> Stop supporting wireless extensions for new devices. We don't
> consider this a regression since no such devices (apart from
> hwsim) exist yet.
>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  net/wireless/wext-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
> index cbeb8be214a8..d3b5cf02690c 100644
> --- a/net/wireless/wext-core.c
> +++ b/net/wireless/wext-core.c
> @@ -662,6 +662,8 @@ struct iw_statistics *get_wireless_stats(struct net_device *dev)
>  	    dev->ieee80211_ptr->wiphy->wext &&
>  	    dev->ieee80211_ptr->wiphy->wext->get_wireless_stats) {
>  		wireless_warn_cfg80211_wext();
> +		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
> +			return NULL;

Should we have a some kind of warning in this case as well? Otherwise
the user has no idea why it stopped working, right?

>  		return dev->ieee80211_ptr->wiphy->wext->get_wireless_stats(dev);
>  	}
>  #endif
> @@ -702,6 +704,8 @@ static iw_handler get_handler(struct net_device *dev, unsigned int cmd)
>  #ifdef CONFIG_CFG80211_WEXT
>  	if (dev->ieee80211_ptr && dev->ieee80211_ptr->wiphy) {
>  		wireless_warn_cfg80211_wext();
> +		if (dev->ieee80211_ptr->wiphy->flags & WIPHY_FLAG_SUPPORTS_MLO)
> +			return NULL;

And here?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
