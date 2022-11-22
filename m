Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43E634933
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 22:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbiKVVZw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 16:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbiKVVZn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 16:25:43 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DF9ACEAD
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 13:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=1wuC51EMjjRe8lH39HAk/veYj8JL3KFtXxqHTZuXP+g=;
        t=1669152342; x=1670361942; b=H6cXIs0z11nF6Shr+NpWq1wO/0pWVGYtvCms8h7gCI6h05b
        cSC0WIi5noctba4f6MdVVWIPU/zxoXSHkgYHVBijDTaGfD3hpINoU7jHnl5KoR6Xf3+4QTVXzREiC
        b9vMSZu81V2//lG5Hx5VBqRRlPkiyybxMATj1fS1DfcQWI1fmV2WNntSPSr7UBVtyd9IsUUNTAhv4
        H0Dp8oqobXqI+ikrkC79f4V3LtfIMumliCL00+pcPqRn/tHZqo1cbduPT7KIhjkQ17gn2EN0PtshQ
        KLz7pUQkdsblmKz8o1myPfELW8PGzk1zWyYRdFoUiyjEu3fULO++HW0BOHj8Zcyg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oxalv-006Tqd-1M;
        Tue, 22 Nov 2022 22:25:39 +0100
Message-ID: <19418837778881777379446e65938b455fbb523a.camel@sipsolutions.net>
Subject: Re: [PATCH v2] wifi: mac80211: integrate PS buffering into iTXQ
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Date:   Tue, 22 Nov 2022 22:25:38 +0100
In-Reply-To: <20221102184005.10649-1-alexander@wetzel-home.de>
References: <20221102184005.10649-1-alexander@wetzel-home.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2022-11-02 at 19:40 +0100, Alexander Wetzel wrote:
>=20
> +++ b/net/mac80211/sta_info.c
> @@ -114,6 +114,28 @@ static int link_sta_info_hash_del(struct ieee80211_l=
ocal *local,
>  			       link_sta_rht_params);
>  }
> =20
> +static void num_sta_ps_dec_for_mc_txq(struct ieee80211_sub_if_data *sdat=
a,
> +				      atomic_t *num_sta_ps)

passing the pointer to the atomic_t variable seems a bit odd here, maybe
pass the 'ps' pointer here:

> +		/* can call wake_tx_queue for vif.txq */
> +		num_sta_ps_dec_for_mc_txq(sdata, &ps->num_sta_ps);

instead?

Also maybe that comment should be a couple of lines above on the
local_bh_disable() since that's the context requirement for that?

> @@ -1046,8 +1070,8 @@ static void __sta_info_recalc_tim(struct sta_info *=
sta, bool ignore_pending)
>  		if (ignore_for_tim & ieee80211_ac_to_qos_mask[ac])
>  			continue;
> =20
> -		indicate_tim |=3D !skb_queue_empty(&sta->tx_filtered[ac]) ||
> -				!skb_queue_empty(&sta->ps_tx_buf[ac]);
> +		indicate_tim |=3D !skb_queue_empty(&sta->tx_filtered[ac]);

This seems odd, we must indicate the TIM whenever we have *any* traffic
pending to that STA? IOW also if there's anything on the TXQs?

> @@ -1553,23 +1547,11 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_i=
nfo *sta)
> =20
>  	BUILD_BUG_ON(BITS_TO_LONGS(IEEE80211_NUM_TIDS) > 1);
>  	sta->driver_buffered_tids =3D 0;
> -	sta->txq_buffered_tids =3D 0;
> =20
>  	if (!ieee80211_hw_check(&local->hw, AP_LINK_PS))
>  		drv_sta_notify(local, sdata, STA_NOTIFY_AWAKE, &sta->sta);
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
> -		if (!sta->sta.txq[i] || !txq_has_queue(sta->sta.txq[i]))
> -			continue;
> -
> -		schedule_and_wake_txq(local, to_txq_info(sta->sta.txq[i]));
> -	}
> -
> -	skb_queue_head_init(&pending);
> -
> -	/* sync with ieee80211_tx_h_unicast_ps_buf */
> -	spin_lock(&sta->ps_lock);
> -	/* Send all buffered frames to the station */
> +	/* Send all filtered frames to the station */
>  	for (ac =3D 0; ac < IEEE80211_NUM_ACS; ac++) {
>  		int count =3D skb_queue_len(&pending), tmp;
> =20
> @@ -1579,16 +1561,39 @@ void ieee80211_sta_ps_deliver_wakeup(struct sta_i=
nfo *sta)
>  		tmp =3D skb_queue_len(&pending);
>  		filtered +=3D tmp - count;
>  		count =3D tmp;
> -
> -		spin_lock_irqsave(&sta->ps_tx_buf[ac].lock, flags);
> -		skb_queue_splice_tail_init(&sta->ps_tx_buf[ac], &pending);
> -		spin_unlock_irqrestore(&sta->ps_tx_buf[ac].lock, flags);
> -		tmp =3D skb_queue_len(&pending);
> -		buffered +=3D tmp - count;
>  	}
> =20
> +	skb_queue_head_init(&pending);
>  	ieee80211_add_pending_skbs(local, &pending);

It seems to me you moved the skb_queue_head_init() erroneously, it's
still needed for the loop for the filtered frames?

If you reinit here you probably leak, and if it's not inited before you
probably crash?

> +	for (i =3D 0; i < ARRAY_SIZE(sta->sta.txq); i++) {
> +		if (!sta->sta.txq[i])
> +			continue;
> +
> +		txqi =3D to_txq_info(sta->sta.txq[i]);
> +		clear_bit(IEEE80211_TXQ_STOP_PS, &txqi->flags);
> +	}

Should we really do this before pending are transmitted? Actually I'm a
bit confused about ieee80211_add_pending_skbs() now - does that mean
those frames don't go to the driver via TXQs?

johannes
