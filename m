Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B34CE7BF1C
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 13:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfGaLRK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 07:17:10 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:57318 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfGaLRJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 07:17:09 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hsmbT-0006mq-HC; Wed, 31 Jul 2019 13:17:07 +0200
Message-ID: <6ea74d2811639fcb2ea518da59c03a6e89094219.camel@sipsolutions.net>
Subject: Re: [PATCH V8] mac80211: add hw 80211 encapsulation offloading
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Date:   Wed, 31 Jul 2019 13:17:06 +0200
In-Reply-To: <20190730091213.5469-1-john@phrozen.org>
References: <20190730091213.5469-1-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

Just a few things, mostly questions I guess.

> Certain features wont work and the patch masks these out.
> * monitor interfaces are not supported if any of the vif is in encap mode.


> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> Signed-off-by: John Crispin <john@phrozen.org>
> 
> Signed-off-by: John Crispin <john@phrozen.org>

heh.

> Changes in V7
> * dont mask out monitor support when encap is available. Instead turn encap
>   of if a monitor device is brought up or already present

I think that means the commit log (quoted above) needs an update?

> +/**
> + * ieee80211_tx_status_8023 - transmit status callback for 802.3 frame format
> + *
> + * Call this function for all transmitted data frames after their transmit
> + * completion. This callback should only be called for data frames which
> + * are are using driver's (or hardware's) offload capability of encap/decap
> + * 802.11 frames.
> + *
> + * This function may not be called in IRQ context. Calls to this function
> + * for a single hardware must be synchronized against each other.

I guess also against any other calls in the same tx status family?

> @@ -6408,4 +6432,5 @@ void ieee80211_nan_func_match(struct ieee80211_vif *vif,
>  			      struct cfg80211_nan_match_params *match,
>  			      gfp_t gfp);
>  
> +bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);

Please add some docs for that, when to call it, etc. Maybe there are
context requirements (can only be called inside add_vif callback) etc?

> +++ b/net/mac80211/cfg.c
> @@ -2425,11 +2425,17 @@ static int ieee80211_set_mcast_rate(struct wiphy *wiphy, struct net_device *dev,
>  static int ieee80211_set_wiphy_params(struct wiphy *wiphy, u32 changed)
>  {
>  	struct ieee80211_local *local = wiphy_priv(wiphy);
> +	struct ieee80211_sub_if_data *sdata;
>  	int err;
>  
>  	if (changed & WIPHY_PARAM_FRAG_THRESHOLD) {
>  		ieee80211_check_fast_xmit_all(local);
>  
> +		mutex_lock(&local->iflist_mtx);
> +		list_for_each_entry(sdata, &local->interfaces, list)
> +			ieee80211_set_hw_80211_encap(&sdata->vif, false);
> +		mutex_unlock(&local->iflist_mtx);
> +
>  		err = drv_set_frag_threshold(local, wiphy->frag_threshold);

This isn't clear to me - what if the driver *does* support setting the
fragmentation threshold, and maybe even implements it in offload mode?

Shouldn't the driver then reject it, and then we can turn it off, if it
did?

> +bool ieee80211_is_hw_80211_encap(struct ieee80211_local *local);

Maybe that should be something like ieee80211_using_hw_encap() or
something like that?

But a lot of this talks about *encapsulation*, isn't it relevant for
*decapsulation* as well?
Then again, reading all this, I guess it only covers encapsulation so
far.

> +bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable)
> +{
> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_sub_if_data *iter;
> +	struct ieee80211_key *key;
> +
> +	sdata_assert_lock(sdata);
> +
> +	mutex_lock_nested(&local->iflist_mtx, 1);

That can't be right. The _nested is just a lockdep annotation, and that
only works for *different* mutexes, but it still deadlocks if you use
the same ... e.g. you'd have to do this when you have

my_object *a, *b;

mutex_lock(&a->mtx);
mutex_lock(&b->mtx);

and you know this is OK, even if both mutexes have the same class (since
those are the same objects), but I can't see how you'd have two
different "local" instances actually nesting here.

> +	list_for_each_entry(iter, &local->interfaces, list) {
> +		if (vif->type == NL80211_IFTYPE_MONITOR)
> +			__ieee80211_set_hw_80211_encap(iter, false);
> +		else if (iter->vif.type == NL80211_IFTYPE_MONITOR)
> +			enable = 0;

false

> +	}
> +	mutex_unlock(&local->iflist_mtx);
> +
> +	if (enable == sdata->hw_80211_encap)
> +		return enable;
> +
> +	switch (vif->type) {
> +	case NL80211_IFTYPE_STATION:
> +		if (sdata->u.mgd.use_4addr)
> +			enable = 0;

same here and more instances (also "return 0")

> +bool ieee80211_is_hw_80211_encap(struct ieee80211_local *local)
> +{
> +	struct ieee80211_sub_if_data *sdata;
> +	bool offloaded = false;
> +
> +	rcu_read_lock();
> +	mutex_lock(&local->iflist_mtx);

You certainly cannot do that in this order.

> +	/* TKIP countermeasures wont work on encap offload mode */

"won't" (or maybe "don't")?

> +++ b/net/mac80211/main.c
> @@ -997,7 +997,9 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
>  		hw->wiphy->software_iftypes |= BIT(NL80211_IFTYPE_AP_VLAN);
>  	}
>  
> -	/* mac80211 always supports monitor */
> +	/* mac80211 always supports monitor unless we do 802.11
> +	 * encapsulation offloading.
> +	 */

not really true now, I think?

> +	if (!sta || IS_ERR(sta)) {

IS_ERR_OR_NULL(), but can it even be NULL?

> +	/* TODO: Handle frames requiring wifi tx status to be notified */

it'd be nice to address this, it shouldn't even be that hard?

> +	if (WARN_ON(dev->ieee80211_ptr->use_4addr)) {
> +		kfree_skb(skb);
> +		return NETDEV_TX_OK;
> +	}

You have this a lot, but is it even worth it? I mean, the driver ought
to know the interface is in 4-addr mode, and then *it* can decide
whether it supports it in offload or not, rather than mac80211 deciding
for it that it cannot possibly be done?

johannes

