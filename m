Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A50A63F1AB
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Dec 2022 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLANcY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Dec 2022 08:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbiLANcX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Dec 2022 08:32:23 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EADA9E9C
        for <linux-wireless@vger.kernel.org>; Thu,  1 Dec 2022 05:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=TO59QAQNdeHVjAJBM/BDKiMNVB+0EZssmoz8Ok9eI3I=;
        t=1669901542; x=1671111142; b=lMgohL+gpN1qJ5fympoy2bIZ6MEPtmv97b01AKdpCaIx98u
        nGt5fPRbp3wWvZiG2OZ/rH835omYkPlKGbvKphGgQKTiimm9Srvzyi4HTnfuA19pC/ipsxWh6WxI8
        jpC6ZpYprFUGRHoccVp7kQWXwKrSgXacsT1G+ZxZx65Q13AK9I6JCpEnzHzgFBd1PELQxwJq2+xzF
        JDPvWisKxayKSyfOzM9diG24URnCm9gCQcERGZ17f4M4HEwL8sJgCHBqHVyycNejdPIQksBo7+oB/
        JA5+ifsIz46hQvnzmJQ1DuMdwXF6Hqw8MZyfJUW8LZey7/kyQEmLnsMvbcNp4m8A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1p0jfo-00E52Z-0R;
        Thu, 01 Dec 2022 14:32:20 +0100
Message-ID: <245eac51ecd65be5b31d433eebf0f212d50b8819.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/4] wifi: mac80211: Add support for randomizing auth
 and deauth frames TA
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     linux-wireless@vger.kernel.org, Jouni Malinen <j@w1.fi>
Date:   Thu, 01 Dec 2022 14:32:19 +0100
In-Reply-To: <20220919121155.3069765-2-quic_vjakkam@quicinc.com>
References: <20220919121155.3069765-1-quic_vjakkam@quicinc.com>
         <20220919121155.3069765-2-quic_vjakkam@quicinc.com>
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

Hi,

So I was going to apply patches 1 and 4 (with a leak fix to 4, please
check before you resend), but have some issues with this one, and that
raises a design question ... +Jouni because of that.

> +++ b/include/net/mac80211.h
> @@ -1832,6 +1832,7 @@ struct ieee80211_vif_cfg {
>   * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
>   *	&enum ieee80211_offload_flags.
>   * @mbssid_tx_vif: Pointer to the transmitting interface if MBSSID is en=
abled.
> + * @random_addr: random address in use for this interface.


That could be in vif_cfg, no?

>=20
> @@ -4164,6 +4167,11 @@ struct ieee80211_prep_tx_info {
>   *	Note that a sta can also be inserted or removed with valid links,
>   *	i.e. passed to @sta_add/@sta_state with sta->valid_links not zero.
>   *	In fact, cannot change from having valid_links and not having them.
> + * @config_random_mac: Configure random MAC address to send acknowledgme=
nt when
> + *	RA of the received frame matches with configured random MAC address.
> + *	Also, clear random MAC address configuration if zero MAC address set.
> + *	Driver must register callback for this when advertise
> + *	%NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA.

And then maybe this isn't necessary, and we can use a new BSS change
flag instead?

Either way, you didn't document the context requirements here.

> +++ b/net/mac80211/rx.c
> @@ -4211,6 +4211,21 @@ static bool ieee80211_accept_frame(struct ieee8021=
1_rx_data *rx)
>  	u8 *bssid =3D ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
>  	bool multicast =3D is_multicast_ether_addr(hdr->addr1) ||
>  			 ieee80211_is_s1g_beacon(hdr->frame_control);
> +	bool skip_addr1_check =3D false;
> +
> +	if ((ieee80211_is_auth(hdr->frame_control) ||
> +	     ieee80211_is_deauth(hdr->frame_control)) &&
> +	    wiphy_ext_feature_isset(
> +		   sdata->local->hw.wiphy,
> +		   NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA) &&

No need for the support check - if not supported then vif.random_addr on
the next line cannot be set properly?

> +	    ether_addr_equal(sdata->vif.random_addr, hdr->addr1)) {
> +		skip_addr1_check =3D true;
> +		if (ieee80211_is_deauth(hdr->frame_control)) {
> +			eth_zero_addr(sdata->vif.random_addr);
> +			drv_config_random_mac(sdata->local,
> +					      rx->sdata->vif.random_addr);
> +		}
> +	}

maybe some unlikely() would be appropriate, e.g. around even only the
first is_auth||is_deauth since those are already unlikely and the rest
of the checks can be done separately?

I also _really_ don't like the call to drv_config_random_mac() in the
middle of this flow here - coming from the driver back into the driver
is always a pain.

This might be a reason *not* to do the vif config and all that, but you
should document that more clearly (the design decision process in the
commit message, and the actual context requirements in the kernel-doc.)

That said, aren't many drivers going to anyway punt this to a worker,
maybe we should here and then we can put it together with other vif
config?

I'm also asking myself when this is going to get cancelled if the frame
is *not* a deauth? For something like PASN you'd expect one response for
every TX, so maybe that's OK and we can cancel when you stop waiting?

OTOH, maybe this really shouldn't be called "random TA" but rather
"temporary address", and userspace picks in both mgmt-TX and remain-on-
channel?

As it is, until you deauth, you keep the random address alive in the
driver, afaict?

> @@ -4657,6 +4676,21 @@ static bool ieee80211_invoke_fast_rx(struct ieee80=
211_rx_data *rx,
>  	} addrs __aligned(2);
>  	struct link_sta_info *link_sta;
>  	struct ieee80211_sta_rx_stats *stats;
> +	bool skip_addr1_check =3D false;
> +
> +	if ((ieee80211_is_auth(hdr->frame_control) ||
> +	     ieee80211_is_deauth(hdr->frame_control)) &&
> +	    wiphy_ext_feature_isset(
> +		   rx->sdata->local->hw.wiphy,
> +		   NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA) &&
> +	    ether_addr_equal(rx->sdata->vif.random_addr, hdr->addr1)) {
> +		skip_addr1_check =3D true;
> +		if (ieee80211_is_deauth(hdr->frame_control)) {
> +			eth_zero_addr(rx->sdata->vif.random_addr);
> +			drv_config_random_mac(rx->sdata->local,
> +					      rx->sdata->vif.random_addr);
> +		}
> +	}

Um, no, there's really no point in changing this function??? How did
that happen?

> +++ b/net/mac80211/tx.c
> @@ -2048,6 +2048,7 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *s=
data,
>  	struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *) skb->data;
>  	int headroom;
>  	enum ieee80211_encrypt encrypt;
> +	bool our_addr =3D true;
> =20
>  	if (info->flags & IEEE80211_TX_INTFL_DONT_ENCRYPT)
>  		encrypt =3D ENCRYPT_NO;
> @@ -2071,6 +2072,32 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *=
sdata,
>  	hdr =3D (struct ieee80211_hdr *) skb->data;
>  	info->control.vif =3D &sdata->vif;
> =20
> +	switch (sdata->vif.type) {

This doesn't seem like an appropriate place for this logic - why not do
that closer to userspace? We go through this for *every* mac80211 TX,
but we only *need* it for userspace TX - i.e. somewhere mgmt_tx or so?


Anyway, I still think there's a design issue here in how you handle the
lifetime of this temporary address, and would think that it might make
more sense to address that within the context of remain-on-channel and
the response waiting time offchannel period. Remain-on-channel might not
even be needed for the purpose here since you'd get a response and then
give up waiting for a response? But it might be needed in some retry
cases perhaps, I don't know.

johannes
