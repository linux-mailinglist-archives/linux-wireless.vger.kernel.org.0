Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C15E6A425D
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 14:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjB0NOM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 08:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjB0NOM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 08:14:12 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9336EC50
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 05:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=yr8muG0u4KYhYndiGJKXQkvBTto5mNVGZbnFdI/YQig=;
        t=1677503650; x=1678713250; b=xl803es/fmMm5Kowr2WY899S5tkDyeD/KUqcmPSfXOekivj
        AUFSz+pjNAWQIUVjUu8jpwNpVAJrgFmPT0jDOtImN8GYwfwyTX4gx7gMXMtzZRSsAYr6/1DiS0jag
        CxFYlHD5jNEXi0PySJiGqyQSP7d8AxJEVzWfEKnCb7s3IqPYqZyy4cMnA3BOUX7XT1j3gHRcJBzr3
        WdccBqD4qMafj0vGqUo0IsVvdgldEXuiaeT/PFnMdqRyiCwk94jm43nRfdf339nz0mDIp8n3YqMFt
        ZlvefLblLjneiW8fSI4s+kWrUPEqky4b94XVCZ/JrewsUf/3+oBrGD0JiyHgdhLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pWdKR-0073mp-1F;
        Mon, 27 Feb 2023 14:14:07 +0100
Message-ID: <7cc08b19d3ac643ed21c5c4325a4a8a64c4233f6.camel@sipsolutions.net>
Subject: Re: [RFC 4/5] wifi: mac80211: mesh fast xmit support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     Sriram R <quic_srirrama@quicinc.com>
Date:   Mon, 27 Feb 2023 14:14:06 +0100
In-Reply-To: <20230227110738.54241-4-nbd@nbd.name>
References: <20230227110738.54241-1-nbd@nbd.name>
         <20230227110738.54241-4-nbd@nbd.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Mon, 2023-02-27 at 12:07 +0100, Felix Fietkau wrote:
>=20
> +	/* If the skb is shared we need to obtain our own copy */
> +	if (skb_shared(skb)) {
> +		struct sk_buff *oskb =3D skb;
> +
> +		skb =3D skb_clone(skb, GFP_ATOMIC);
> +		if (!skb)
> +			return false;
> +
> +		kfree_skb(oskb);
> +	}

Use skb_share_check()?

>  	next_hop =3D rcu_dereference(mpath->next_hop);
>  	if (next_hop) {
>  		memcpy(hdr->addr1, next_hop->sta.addr, ETH_ALEN);
>  		memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
>  		ieee80211_mps_set_frame_flags(sdata, next_hop, hdr);
> +		if (ieee80211_hw_check(&sdata->local->hw, SUPPORT_FAST_XMIT))
> +			mesh_fast_tx_cache(sdata, skb, mpath);


I wondered briefly if it's worth moving that check into the function,
but not sure.

> +	/* rate limit, in case fast xmit can't be enabled */
> +	if (mppath->fast_tx_check =3D=3D jiffies)
> +		return;
> +
> +	mppath->fast_tx_check =3D jiffies;

once every jiffies seems pretty frequent though?

> +	spin_lock_bh(&cache->walk_lock);

you could just spin_lock() the inner lock, _bh already taken care of by
the outer?

> @@ -3686,7 +3690,7 @@ static void __ieee80211_xmit_fast(struct ieee80211_=
sub_if_data *sdata,
>  #endif
> =20
>  	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
> -		tid =3D skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
> +		u8 tid =3D skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
>  		*ieee80211_get_qos_ctl(hdr) =3D tid;

That's ... interesting, why wss there an argument in the first place?

but maybe add a blank line now :)

johannes
