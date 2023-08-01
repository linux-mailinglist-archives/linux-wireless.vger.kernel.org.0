Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E876BF69
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 23:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjHAVly (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHAVlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 17:41:52 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCF0172B
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1690926106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeuHe0ibwWfeipHJZ12SRhKU9WUjNOeatmosU/WErOA=;
        b=R4crp2cZXdhurP9rHFku1DlFW6A7l1EO8s25nowqefJg7V1h4C5XcBRdsPLtL+1mDceASr
        iT98oMUuBEeTBKv0zBdCOsVgzsQ6Zk6ubVq2W7CI1no9WUPXK2xmaCthmTntRFyTiPC1AG
        g0rRQiOQloFxEWsPF2+WXDyOJPmbrlo=
From:   Sven Eckelmann <sven@narfation.org>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        Felix Fietkau <nbd@nbd.name>
Cc:     Kalle Valo <quic_kvalo@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH RFC] ath11k: Don't drop tx_status when peer cannot be found
Date:   Tue, 01 Aug 2023 23:41:43 +0200
Message-ID: <4836979.GXAFRqVoOG@sven-l14>
In-Reply-To: <a8986afb-3e92-8314-d932-3f2bc8ca1936@nbd.name>
References: <20230801-ath11k-ack_status_leak-v1-1-539cb72c55bc@narfation.org>
 <a8986afb-3e92-8314-d932-3f2bc8ca1936@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1875646.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart1875646.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Aug 2023 23:41:43 +0200
Message-ID: <4836979.GXAFRqVoOG@sven-l14>
In-Reply-To: <a8986afb-3e92-8314-d932-3f2bc8ca1936@nbd.name>
MIME-Version: 1.0

On Tuesday, 1 August 2023 20:11:51 CEST Felix Fietkau wrote:
[...]
> > when new clients try to connect - and connection attempt will obviously
> > fail. Most likely with an "deauthenticated due to inactivity (timer
> > DEAUTH/REMOVE)" by hostapd.
> > 
> > And the fix (required for both platches) would then be something like:
> > 
> >    --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> >    +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> >    @@ -629,8 +629,14 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
> >     			   "dp_tx: failed to find the peer with peer_id %d\n",
> >     			    ts->peer_id);
> >     		spin_unlock_bh(&ab->base_lock);
> >    -		dev_kfree_skb_any(msdu);
> >    -		goto exit;
> >    +		rcu_read_unlock();
> >    +
> >    +		if (skb_cb->flags & ATH11K_SKB_HW_80211_ENCAP)
> >    +			ieee80211_tx_status_8023(ar->hw, skb_cb->vif, msdu);
> >    +		else
> >    +			ieee80211_tx_status(ar->hw, msdu);
> >    +
> >    +		return;
> >     	}
> >     	arsta = (struct ath11k_sta *)peer->sta->drv_priv;
> >     	status.sta = peer->sta;
> > 
> > But this is not possible any longer because Felix Fietkau removed
> > ieee80211_tx_status_8023 in commit 9ae708f00161 ("wifi: mac80211: remove
> > ieee80211_tx_status_8023") - and the function ieee80211_lookup_ra_sta
> > (required for this task) is currently not exported. And the sta information
> > is required to reach the ieee80211_sta_tx_notify code section in
> > ieee80211_tx_status_ext()
> 
> This does not make much sense to me. ieee80211_sta_tx_notify is specific 
> to interfaces running in client mode, thus unrelated to anything hostapd 
> is doing. It's a different kind of probing than the one you're looking into.

Sorry, copied something to my notes and then mixed up basically everything 
after that. Interesting for the fix was only that it reaches 
ieee80211_report_ack_skb via ieee80211_report_used_skb. This can either be 
done via __ieee80211_tx_status/ieee80211_tx_status_ext (which doesn't have any 
dependency to the sta - which I incorrectly said earlier) or via 
ieee80211_free_txskb (which I missed earlier)

[...]
> The main bug is the fact that dev_kfree_skb* must not be called for tx 
> packets passed from mac80211. If you replace it with a call to 
> ieee80211_free_txskb, the bug goes away.

Thanks for the hint. Will submit an actual patch with your recommended
replacement.

Kind regards,
	Sven
--nextPart1875646.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmTJfBcACgkQXYcKB8Em
e0ZmzBAApeRTlHLHJwpLbJzXVLGL3UViBiSk5+pqp1szpk/KWjraXtj7mnySYS87
vl98s5ctuBp1foSgMoabET6xzSzKIpY76wohLIRE87NXEF4xc/2eYtRpX8S7Ne/z
s7h+Li23VjUEtYOfa+4dbEbSXhYSptZ3laCKO5wfqBFFBykFVXU2M0LEECyJDzpU
T4Nt+jfKKw30Gtd/GU8dYyu/7/9wzaEc2KmKLUiArSZ3RF5rdO2QLxph//ECHLMR
cQN856y1SrHhg8rVOFUxqII0uG6ARlMnLURkUmzNs3BRSr2OJbtu95yJ3AlKaZEJ
3vlMHzyIkou0LMp20IYluTyd0jSyR5s3G+zFTQ4LZHtVduryie+XMEQznDaAEga7
CmB/oEYRTCIa4lTtok2u49RRF0+fM7UK5LRC4+lWQ0XPAslbUEE3mhfXoGd6x6Au
Wh7ZWkc+aa8TrOAZrgHBbGu3tIyUSmMKcOczAtSI/3DK2O++xYuDBIMZrDAhNHhW
qtFuFrf48irQuUpVj+oV1RFnUZxZMpFEET9zktiAFKzpkAWoDX/85s9H8wsBWfzj
LLvuKFzwcfj2MD1/SKrUoBuypkBkLsuEym6RK66rlxRuk7BRmf6qkYqF8veCItXF
U2QINKL+/2kyX+avMhCAcnWdzb3/FLhzldWZI6OCWKy1TCLF9lM=
=Pczz
-----END PGP SIGNATURE-----

--nextPart1875646.tdWV9SEqCh--



