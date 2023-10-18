Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CAF7CDAC1
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 13:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjJRLjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 07:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344551AbjJRLjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 07:39:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1112F
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 04:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bCy8dKQpQ9iG+rcaw3GhkrRi3vhdBx1LFm1P6vdeUMg=;
        t=1697629181; x=1698838781; b=mBREfynix1xIdOUPcGItiRvWugesxKn2euXOyVeaYOuPTfz
        L25HXgLQVa66ExgdaeXa/LspbDmISaUwFU/f2JjoIgSxJ38mO6WLu8fKJ1bs6piJWHpOGu+nZ4llK
        gJhLucDVsSGKQDDUOM2CJGFGImwZKkdsAGEhZDZI97wu7eFU+cSXmoGdYG04H7rVCIVgkXd9f5wI9
        5RLRyjNNj4qkkweN7leq2PKnD1Nfjslcm4SQUQS9oBE1gVtX6djbdz6YI/MN1fLw/+m9GYtUVAxw3
        41W9JJfTDcDbo3WXcguvIsDhHmgl3/OjBtK8hXrSxO7x36eAGWgZoUcTWKLLHddA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qt4tm-0000000Blvt-1ctA;
        Wed, 18 Oct 2023 13:39:38 +0200
Message-ID: <08ff36664eb34bce8e7beb425233b1e8d4a4971c.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] wifi: mac80211: mlme: fix verification of
 puncturing bitmap obtained from AP
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kang Yang <quic_kangyang@quicinc.com>, ath12k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 18 Oct 2023 13:39:37 +0200
In-Reply-To: <20230928055022.9670-2-quic_kangyang@quicinc.com>
References: <20230928055022.9670-1-quic_kangyang@quicinc.com>
         <20230928055022.9670-2-quic_kangyang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
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

On Thu, 2023-09-28 at 13:50 +0800, Kang Yang wrote:
>=20
> +static enum nl80211_chan_width
> +ieee80211_rx_bw_to_nlwidth(enum ieee80211_sta_rx_bandwidth bw)
> +{
> +	switch (bw) {
> +	case IEEE80211_STA_RX_BW_20:
> +		return NL80211_CHAN_WIDTH_20;

So for a while now I was actually not responding to this because I was
scratching my head over how this function ever could be needed or make
sense ...


>  static bool ieee80211_config_puncturing(struct ieee80211_link_data *link=
,
>  					const struct ieee80211_eht_operation *eht_oper,
>  					u64 *changed)
>  {
> +	struct cfg80211_chan_def rx_chandef =3D link->conf->chandef;
>  	u16 bitmap =3D 0, extracted;
> +	u8 bw =3D 0;
> =20
>  	if ((eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT) &&
>  	    (eht_oper->params &
> @@ -5684,6 +5706,28 @@ static bool ieee80211_config_puncturing(struct iee=
e80211_link_data *link,
>  		const u8 *disable_subchannel_bitmap =3D info->optional;
> =20
>  		bitmap =3D get_unaligned_le16(disable_subchannel_bitmap);
> +		bw =3D u8_get_bits(info->control, IEEE80211_EHT_OPER_CHAN_WIDTH);
> +		rx_chandef.width =3D ieee80211_rx_bw_to_nlwidth(bw);

But looking here, it clearly _doesn't_ make sense. IEEE80211_STA_RX_BW_*
is a purely internal API, has nothing to do with the spec.

All this might even be "accidentally correct", but it really isn't right
at all - the values in IEEE80211_EHT_OPER_CHAN_WIDTH are
IEEE80211_EHT_OPER_CHAN_WIDTH_*, not IEEE80211_STA_RX_BW_*.



More generally though, I don't even understand the change.

> +		if (rx_chandef.width =3D=3D NL80211_CHAN_WIDTH_80)
> +			rx_chandef.center_freq1 =3D
> +				ieee80211_channel_to_frequency(info->ccfs0,
> +							       rx_chandef.chan->band);
> +		else if (rx_chandef.width =3D=3D NL80211_CHAN_WIDTH_160 ||
> +			 rx_chandef.width =3D=3D NL80211_CHAN_WIDTH_320)
> +			rx_chandef.center_freq1 =3D
> +				ieee80211_channel_to_frequency(info->ccfs1,
> +							       rx_chandef.chan->band);
> +	}
> +
> +	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
> +						      &rx_chandef)) {
> +		link_info(link,
> +			  "Got an invalid disable subchannel bitmap from AP %pM: bitmap =3D 0=
x%x, bw =3D 0x%x. disconnect\n",
> +			  link->u.mgd.bssid,
> +			  bitmap,
> +			  rx_chandef.width);
> +		return false;
>  	}
> =20
>  	extracted =3D ieee80211_extract_dis_subch_bmap(eht_oper,
// I've filled in the context here in the patch
>                                                      &link->conf->chandef=
,
>                                                      bitmap);
>=20
>         /* accept if there are no changes */
>         if (!(*changed & BSS_CHANGED_BANDWIDTH) &&
>             extracted =3D=3D link->conf->eht_puncturing)
>                 return true;

but ... ieee80211_extract_dis_subch_bmap actually already takes the
bandwidth from eht_oper into account!
=20
> -	if (!cfg80211_valid_disable_subchannel_bitmap(&bitmap,
> -						      &link->conf->chandef)) {

So are you saying that the real bug is that we're missing to update the
link->conf->chandef with the EHT operation from the assoc response?

But you didn't fix that issue ... so not sure?

johannes

