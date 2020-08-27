Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1E12547E0
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgH0Ozz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 10:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH0NJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 09:09:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4E1C061233
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 06:08:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBHdq-00BbCo-Oy; Thu, 27 Aug 2020 15:08:34 +0200
Message-ID: <2f1de2e5672f1516ac1d94520f54b00153fd24f3.camel@sipsolutions.net>
Subject: Re: [PATCH V3 2/9] mac80211: add multiple bssid support to
 interface handling
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 27 Aug 2020 15:08:33 +0200
In-Reply-To: <20200812150050.2683396-3-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
         <20200812150050.2683396-3-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> +	struct {
> +		struct ieee80211_vif *parent;
> +		struct list_head list;
> +		bool non_transmitted;
> +	} multiple_bssid;

Oh, and also - surely parent isn't set for the transmitted BSSID, so the
bool non_transmitted is redundant? It's basically the same as !!parent?

Which also applies at the cfg80211 level.

> +static int ieee80211_set_multiple_bssid_options(struct ieee80211_sub_if_data *sdata,
> +						struct vif_params *params)
> +{
> +	struct ieee80211_local *local = sdata->local;
> +	struct wiphy *wiphy = local->hw.wiphy;
> +	struct net_device *parent;
> +	struct ieee80211_sub_if_data *psdata;
> +
> +	if (!ieee80211_hw_check(&local->hw, SUPPORTS_MULTI_BSSID_AP))
> +		return 0;

That was probably meant to be an error? Otherwise the function can be
void.

> +++ b/net/mac80211/iface.c
> @@ -810,6 +810,13 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
>  	bool cancel_scan;
>  	struct cfg80211_nan_func *func;
>  
> +	if (sdata->vif.type == NL80211_IFTYPE_AP &&
> +	    sdata->vif.multiple_bssid.non_transmitted)
> +		/* make sure the parent is already down */
> +		if (sdata->vif.multiple_bssid.parent &&
> +		    ieee80211_sdata_running(vif_to_sdata(sdata->vif.multiple_bssid.parent)))
> +			dev_close(vif_to_sdata(sdata->vif.multiple_bssid.parent)->wdev.netdev);
> +
> 

This is nice but somewhere you also need to actually NULL the pointer.
As it is now, it seems you could set up two interfaces, say

wlan_nontx
wlan_tx

then ifup both, then delete wlan_tx (forcing wlan_nontx down) and then
set wlan_nontx back up and back down or whatever, but the parent pointer
wasn't cleared so ... bad things will happen?

Maybe this stuff could even happen at the cfg80211 level? Might be
useful for others too.

johannes

