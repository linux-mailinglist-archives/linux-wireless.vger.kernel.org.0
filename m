Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BD464FF43
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Dec 2022 16:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiLRPYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Dec 2022 10:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLRPY3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Dec 2022 10:24:29 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BD96340
        for <linux-wireless@vger.kernel.org>; Sun, 18 Dec 2022 07:24:26 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 6A5CE110E6;
        Sun, 18 Dec 2022 15:24:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wDsMYxRTjSwt; Sun, 18 Dec 2022 15:24:22 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sun, 18 Dec 2022 17:24:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1671377062; bh=JlFSwwfK+tbEMEPQ+fK6WOXSmFG2G1SQlfEfguxJWmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9d66n4GAk+tpjDXsYNR5xDlLvWgfs2H8Q70WEanJ0zpASuBZj/iKcxFIAg/x1rKh
         tfntfkl8RJGEmliSOsBNUZHb7xX1DBmmZI5oWV4SWgg87PoJ0JR4nIJC678KafMVFv
         9kNiJagGjzGSlk6ESaoUsT3fFkJwtLfZoFBFV+VmUeWX6H0Qs9JozWEeA7P8ZVHHgK
         Ze8982dyZXa1rT2dcyvhEtGrXSZ6TpA8Kt69E82p5zqgrharjGtU8EKGj8VNd54ghq
         LHK5QzwzxsPFjukQHbfA6D819bWEzBMQVo0hrJFnvlV4yc7KPHIGigajoUu/T5VdBS
         TrKwPn0NlJ9dg==
Date:   Sun, 18 Dec 2022 17:24:20 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v12 2/4] mac80211: MBSSID support in interface handling
Message-ID: <20221218152420.GA906762@w1.fi>
References: <20210916025437.29138-1-alokad@codeaurora.org>
 <20210916025437.29138-3-alokad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916025437.29138-3-alokad@codeaurora.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Sep 15, 2021 at 07:54:35PM -0700, Aloka Dixit wrote:
> Configure multiple BSSID and enhanced multi-BSSID advertisement (EMA)
> parameters in mac80211 for AP mode.
> 
> For each interface, 'mbssid_tx_vif' points to the transmitting interface of
> the MBSSID set. The pointer is set to NULL if MBSSID is disabled.
> 
> Function ieee80211_stop() is modified to always bring down all the
> non-transmitting interfaces first and the transmitting interface last.

This has already been applied, but this has some apparent issues that
are now showing up with mac80211_hwsim testing being available..

> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> +static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
> +					   struct cfg80211_mbssid_config params)

While that does not really break behavior, why is that params argument
passed by value instead of by reference? I see no point in copying
struct cfg80211_mbssid_config members for this call since the function
is only reading the value.

> +	sdata->vif.mbssid_tx_vif = NULL;
> +	sdata->vif.bss_conf.bssid_index = 0;
> +	sdata->vif.bss_conf.nontransmitted = false;
> +	sdata->vif.bss_conf.ema_ap = false;

This cleanup is important, but it is done only here in this helper
function..

> @@ -1105,6 +1135,14 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
> +	if (sdata->vif.type == NL80211_IFTYPE_AP &&
> +	    params->mbssid_config.tx_wdev) {
> +		err = ieee80211_set_ap_mbssid_options(sdata,
> +						      params->mbssid_config);
> +		if (err)
> +			return err;
> +	}

And that is the only place where the help function is called and this
happens only under the params->mbssid_config.tx_wdev condition. In other
words, those bssid_index/nontransmitted/ema_ap values are not cleared in
all cases. This results in issue when the bss_conf (link_conf in the
current kernel snapshot) is left in the previous mbssid configuration.

As an example, this will make the following mac80211_hwsim test case
sequence fail:

hostap/tests/hwsim/vm$ ./vm-run.sh he_ap_ema p2p_group_cli_invalid

This happens because ema_ap is set to true in he_ap_ema and then it is
left set true for p2p_group_cli_invalid and that test case does not
actually end up sending Beacon frames.

This can be fixed by clearing something in the
!params->mbssid_config.tx_wdev case in ieee80211_start_ap(). I'm not
completely sure what is the correct way of doing this, but at least
ema_ap needs to be cleared to false and likely some other cleanup needs
to be done as well.

-- 
Jouni Malinen                                            PGP id EFC895FA
