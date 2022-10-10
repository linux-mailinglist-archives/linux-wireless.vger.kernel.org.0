Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D45F9B25
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 10:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJJIiu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 04:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiJJIij (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 04:38:39 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267FA6581B
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 01:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dy469BlGQA1tYXFTLw6nEZ/Ym3SPe9yZQqI9TUb2boc=;
        t=1665391118; x=1666600718; b=PDCP8oTUWCfU+pLya6aC+um/0A+4Hbh4JqMDz9e0xm8rDw/
        rQypdyznKp92v1DZfO4pC1bKnVfJF6UI76W7ezZwElfLqHZN/A7Wi+WUjZDb5FuYyRYFasFWOHXsh
        rlB5rGzVNG42VYKjc8q4v2c5rY2GO48VFmNljeXoaxvHnouhaPo/uZwxPW7vRlqJd29uShtMxc6Qy
        Z4nFg2t+SpIA8KLxPIoRtcWL9OjJm5VDWc2/NJBAfBqpc4uEKrSOnfbZWdpbqnH+MQgMpzvDH0tan
        81BpPjn/Vx2NuRoP7pyBlyOF/wHPr09CuAMtwMvqNFtoq7+ZK7Peb3wagiqZz1Sg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ohoJ2-002xTk-0E;
        Mon, 10 Oct 2022 10:38:36 +0200
Message-ID: <d1ef101320747b30879153e5314abf13c8202578.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: add support for restricting netdev features
 per vif
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Date:   Mon, 10 Oct 2022 10:38:35 +0200
In-Reply-To: <20221009183334.35841-1-nbd@nbd.name>
References: <20221009183334.35841-1-nbd@nbd.name>
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

On Sun, 2022-10-09 at 20:33 +0200, Felix Fietkau wrote:
>=20
> +static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
> +				  struct sta_info *sta,
> +				  struct ieee80211_fast_tx *fast_tx,
> +				  struct sk_buff *skb, u8 tid, bool ampdu)
> +{
> +	struct ieee80211_local *local =3D sdata->local;
> +	struct ieee80211_hdr *hdr =3D (void *)fast_tx->hdr;
> +	struct ieee80211_tx_info *info;
> +	struct ieee80211_tx_data tx;
> +	ieee80211_tx_result r;
> +	int hw_headroom =3D sdata->local->hw.extra_tx_headroom;
> +	int extra_head =3D fast_tx->hdr_len - (ETH_HLEN - 2);
> +	struct ethhdr eth;
> +
>  	/* after this point (skb is modified) we cannot return false */

That's now void so the comment is a bit misleading ... move it somewhere
else?

> +static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
> +				struct sta_info *sta,
> +				struct ieee80211_fast_tx *fast_tx,
> +				struct sk_buff *skb)
> +{
> +	u16 ethertype =3D (skb->data[12] << 8) | skb->data[13];
> +	struct ieee80211_hdr *hdr =3D (void *)fast_tx->hdr;
> +	struct tid_ampdu_tx *tid_tx =3D NULL;
> +	struct sk_buff *next;
> +	u8 tid =3D IEEE80211_NUM_TIDS;
> +
> +	/* control port protocol needs a lot of special handling */
> +	if (cpu_to_be16(ethertype) =3D=3D sdata->control_port_protocol)
> +		return false;
> +
> +	/* only RFC 1042 SNAP */
> +	if (ethertype < ETH_P_802_3_MIN)
> +		return false;
> +
> +	/* don't handle TX status request here either */
> +	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
> +		return false;
> +
> +	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
> +		tid =3D skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
> +		tid_tx =3D rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
> +		if (tid_tx) {
> +			if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
> +				return false;
> +			if (tid_tx->timeout)
> +				tid_tx->last_tx =3D jiffies;
> +		}
> +	}
>=20

Here, I guess, or so?


Another advantage _might_ be that you can create A-MSDUs now with frames
that don't just belong to a single stream, unlike driver-created A-MSDUs
from GSO? But then again I'm not really sure anymore how the A-MSDU
creation works in the first place.

johannes
