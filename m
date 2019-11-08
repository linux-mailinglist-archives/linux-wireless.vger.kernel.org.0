Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35DDF4502
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 11:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbfKHKwg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 05:52:36 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:54606 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbfKHKwf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 05:52:35 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iT1sX-0008Pk-Qc; Fri, 08 Nov 2019 11:52:33 +0100
Message-ID: <fadb0452c72b2e64ef5577b4b0fdf9c2ada49430.camel@sipsolutions.net>
Subject: Re: [PATCH V9 2/3] mac80211: add hw 80211 encapsulation offloading
 support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Date:   Fri, 08 Nov 2019 11:52:32 +0100
In-Reply-To: <20191029091304.7330-3-john@phrozen.org>
References: <20191029091304.7330-1-john@phrozen.org>
         <20191029091304.7330-3-john@phrozen.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FWIW, I applied the first patch since it's just some preparation.

Couple of questions on this.

> +/**
> + * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading.
> + *
> + * This function is used to notify mac80211 that a vif can be passed raw 802.3.
> + * The driver needs to then handle the 802.11 encapsulation inside the hardware
> + * or firmware.
> + *
> + * The driver should call this function during the creation of the vif instance.

You state this, here ("during creation"), and that makes sense given the
fact that you redirect the ops, and I don't know how the network stack
behaves. Hard to imagine it could do much with it other than dereference
and then both pointers are valid, but still ...

Or did you mean this only because of the locking?

> +bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable)
> +{
> +	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
> +	struct ieee80211_local *local = sdata->local;
> +	struct ieee80211_sub_if_data *iter;
> +	struct ieee80211_key *key;
> +
> +	sdata_assert_lock(sdata);

that is required here?

> +	mutex_lock(&local->iflist_mtx);
> +	list_for_each_entry(iter, &local->interfaces, list) {
> +		if (vif->type == NL80211_IFTYPE_MONITOR)
> +			__ieee80211_set_hw_80211_encap(iter, false);
> +		else if (iter->vif.type == NL80211_IFTYPE_MONITOR)
> +			enable = false;

(side note - maybe some debug messages in these cases would be useful?)

> +++ b/net/mac80211/key.c
> @@ -176,6 +176,10 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
>  		}
>  	}
>  
> +	/* TKIP countermeasures don't work in encap offload mode */
> +	if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP)
> +		ieee80211_set_hw_80211_encap(&sdata->vif, false);

But now here we're long in operation already, and could suddenly reset
this. Is that valid from the network stack's POV?

Also, minor detail ;-)

This will deadlock if it actually has to disable hwaccel because inside
it you re-acquire the key_mtx you already hold here. I think inside of
the function you can just bypass all the checks that set enable=false if
it's already false anyway, and then you don't have that issue? Or just
call __ieee80211_set_hw_80211_encap() and duplicate the test for doing
nothing in there ...

> @@ -202,6 +206,9 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
>  			  key->conf.keyidx,
>  			  sta ? sta->sta.addr : bcast_addr, ret);
>  
> +	if (sdata->hw_80211_encap)
> +		return -EINVAL;

If this is a valid scenario and the driver didn't anyway say it doesn't
want software crypto, should this switch back to non-hwaccel? OTOH, if
that happens in the middle of the connection (GTK rekeying or such?) for
some reason, probably everything breaks left and right ... I guess it's
better this way.

> @@ -2875,7 +2876,8 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
>  	struct ieee80211_chanctx_conf *chanctx_conf;
>  	__le16 fc;
>  
> -	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT))
> +	if (!ieee80211_hw_check(&local->hw, SUPPORT_FAST_XMIT) ||
> +	    sdata->hw_80211_encap)
>  		return;

Not sure I understand this - we're not treating the offload as fast-
xmit? Couldn't we bypass more by doing so?

Might be good to add a comment here either way.

Actually, we don't get here with a packet whose TX will be offloaded, do
we? Does this even matter?

> +	rcu_read_lock();
> +
> +	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
> +		goto out_free;
> +
> +	ieee80211_8023_xmit(sdata, dev, sta, skb);
> +
> +	goto out;
> +
> +out_free:
> +	kfree_skb(skb);

You only use that label once, and you don't really need any?

if (lookup())
	kfree_skb(skb);
else
	ieee80211_8023_xmit();

rcu_read_unlock;
return NETDEV_TX_OK;

is equivalent, no?

johannes

