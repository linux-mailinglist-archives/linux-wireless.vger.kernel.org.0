Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A69651299
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 20:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbiLSTQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 14:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbiLSTPX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 14:15:23 -0500
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868571004C
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 11:15:12 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.w1.fi (Postfix) with ESMTP id 09008110E8;
        Mon, 19 Dec 2022 19:15:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
        by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nn8EnYv_Z51e; Mon, 19 Dec 2022 19:15:07 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Mon, 19 Dec 2022 21:15:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
        t=1671477307; bh=ZCCaiy2VSvy4wVe1VOzWhZ4YhRIyJSj9AbbujOgYnxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wK7KXXEcFDbbkAJKWAciZhddJKAPwBk8DQ+sjql8Q50ofwaO7HmH8Ugq2PGEjzHeW
         QluqvBR8dT3z9+BPA83rK70Zau/N35sMy00RzTow+yYuGgkZvLnSw5dfyAA2K7znLY
         xbkKfGXsuQWARIbAH5EcFQGl24kaDi0RnD/hoTXuhym8FJ28TH0TfIZNicwaKm0YJE
         UEqXNHgwsWNGw5sL9at11S8v74WCPvQmE3oLs1geNLhBmnh9ilF0u2PP0RJMLeUsMj
         0uRmYHmNrGY8xryZJqZ6poOwxaCYxPWU4+iIXVpcclmSVjYRIesouzzoWKmrnV1kaF
         KIz0a0hxcQ3Ug==
Date:   Mon, 19 Dec 2022 21:15:06 +0200
From:   Jouni Malinen <j@w1.fi>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v12 2/4] mac80211: MBSSID support in interface handling
Message-ID: <20221219191506.GA17184@w1.fi>
References: <20210916025437.29138-1-alokad@codeaurora.org>
 <20210916025437.29138-3-alokad@codeaurora.org>
 <20221218152420.GA906762@w1.fi>
 <441771f8-6269-0ce4-fce8-513f7f3f7d95@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441771f8-6269-0ce4-fce8-513f7f3f7d95@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 19, 2022 at 10:53:55AM -0800, Aloka Dixit wrote:
> On 12/18/2022 7:24 AM, Jouni Malinen wrote:
> > On Wed, Sep 15, 2021 at 07:54:35PM -0700, Aloka Dixit wrote:
> > > diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> > > +static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
> > > +					   struct cfg80211_mbssid_config params)
> > 
> > While that does not really break behavior, why is that params argument
> > passed by value instead of by reference? I see no point in copying
> > struct cfg80211_mbssid_config members for this call since the function
> > is only reading the value.
> 
> Hi Jouni, the only reason for value instead of reference is that this
> function does not need to change anything in 'params'. I didn't understand
> your question. Are you suggesting moving the assignments to
> ieee80211_start_ap() instead of this separate function?

I would use a constant pointer (const struct cfg80211_mbssid_config
*params) to avoid the need to copy the full contents of that struct
whenever calling the function.

Maybe the following patch is a clearer way of showing what I was
thinking of (and testing with):

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e30b2bdb8f01..b0abd99f006e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -138,7 +138,7 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 }
 
 static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
-					   struct cfg80211_mbssid_config params,
+					   const struct cfg80211_mbssid_config *params,
 					   struct ieee80211_bss_conf *link_conf)
 {
 	struct ieee80211_sub_if_data *tx_sdata;
@@ -148,10 +148,10 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 	link_conf->nontransmitted = false;
 	link_conf->ema_ap = false;
 
-	if (sdata->vif.type != NL80211_IFTYPE_AP || !params.tx_wdev)
+	if (sdata->vif.type != NL80211_IFTYPE_AP || !params->tx_wdev)
 		return -EINVAL;
 
-	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params.tx_wdev);
+	tx_sdata = IEEE80211_WDEV_TO_SUB_IF(params->tx_wdev);
 	if (!tx_sdata)
 		return -EINVAL;
 
@@ -160,9 +160,9 @@ static int ieee80211_set_ap_mbssid_options(struct ieee80211_sub_if_data *sdata,
 	} else {
 		sdata->vif.mbssid_tx_vif = &tx_sdata->vif;
 		link_conf->nontransmitted = true;
-		link_conf->bssid_index = params.index;
+		link_conf->bssid_index = params->index;
 	}
-	if (params.ema)
+	if (params->ema)
 		link_conf->ema_ap = true;
 
 	return 0;
@@ -1268,10 +1268,17 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	if (sdata->vif.type == NL80211_IFTYPE_AP &&
 	    params->mbssid_config.tx_wdev) {
 		err = ieee80211_set_ap_mbssid_options(sdata,
-						      params->mbssid_config,
+						      &params->mbssid_config,
 						      link_conf);
 		if (err)
 			return err;
+	} else {
+		/* FIX: Is this the correct thing to do here and under which
+		 * conditions? At least ema_ap needs to be cleared for AP mode
+		 * if mbssid_config.tx_wdev is not set. */
+		link_conf->bssid_index = 0;
+		link_conf->nontransmitted = false;
+		link_conf->ema_ap = false;
 	}
 
 	mutex_lock(&local->mtx);


> > This cleanup is important, but it is done only here in this helper
> > function..
> > And that is the only place where the help function is called and this
> > happens only under the params->mbssid_config.tx_wdev condition. In other
> > words, those bssid_index/nontransmitted/ema_ap values are not cleared in
> > all cases. This results in issue when the bss_conf (link_conf in the
> > current kernel snapshot) is left in the previous mbssid configuration.
> > 
> 
> Will send a patch to fix this part.

Thanks.

> Please let me know regarding the first question above so that I can include
> that in the same patch.

That should not be in the same patch since it is just
cleanup/optimization while the not clearing parameters in some cases is
a visible bug that should be fixed on its own first.

-- 
Jouni Malinen                                            PGP id EFC895FA
