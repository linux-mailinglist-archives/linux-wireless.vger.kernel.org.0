Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C75562F49
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Jul 2022 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbiGAI7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Jul 2022 04:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiGAI7r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Jul 2022 04:59:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AAD192AE
        for <linux-wireless@vger.kernel.org>; Fri,  1 Jul 2022 01:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=LZtVh6oV5lQ8M0xdYOnbzEWyA02biSUYiwH2l9S4o4M=;
        t=1656665986; x=1657875586; b=W+f8aL3ZC3NnJSawAxAAndWCQ2OYLIIOQpo5XI+/kKA9WzG
        xkCPEU9CR9fj8N16S3Idnsm4+TLQuvcpdAEQMLflslI+s4Rhv0Ad8XN2ydHdxwLCBzj/0+wIHhzBy
        IqsDNBSfh4AJxqsVLwnDPAc33yrtvflr1h46c5Q3P6GbTuEHPDcwZ6dInh3OD6D7Hb8JrBmDDUNRV
        vE7FExH45rulzRAmdVo33frA7OA6IAf4NNv0wKcH9+w5AtCdvzhCA1R4XAU54I5Fch5FW7M5HxiCT
        eev1h8YcpedRUb5yivpsMjvywwqIMzFZB8Z6IMaXefLx7cSvme1qSIEYipsvIVNg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1o7CV6-003PZI-Ge;
        Fri, 01 Jul 2022 10:59:44 +0200
Message-ID: <3163fef05bde096540020e58a93003c6048d9a0b.camel@sipsolutions.net>
Subject: Re: [PATCH 1/9] mac80211: generate EMA beacons in AP mode
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <quic_alokad@quicinc.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc:     John Crispin <john@phrozen.org>
Date:   Fri, 01 Jul 2022 10:59:43 +0200
In-Reply-To: <20220523060108.23982-2-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
         <20220523060108.23982-2-quic_alokad@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>=20
> +++ b/include/net/mac80211.h
> @@ -5050,6 +5050,83 @@ ieee80211_beacon_get_template(struct ieee80211_hw =
*hw,
>  			      struct ieee80211_vif *vif,
>  			      struct ieee80211_mutable_offsets *offs);
> =20
> +/**
> + * This macro should be used to get total length for all MBSSID elements
> + * in the beacon, and also to generate a single beacon template with
> + * all MBSSID elements.
> + */
> +#define IEEE80211_MBSSID_ELEMS_ALL -1

Not sure where the driver should use this? Why is it defined in the
driver API?

> + * @ema_index: index of the beacon in the EMA set, should be more than
> + *	IEEE80211_MBSSID_ELEMS_ALL otherwise the set/get functions include al=
l
> + *	MBSSID elements in a single beacon template.

The parameter is a u8 so it cannot be negative anyway ...?

> +struct sk_buff *
> +ieee80211_beacon_get_template_ema_index(struct ieee80211_hw *hw,
> +					struct ieee80211_vif *vif,
> +					struct ieee80211_mutable_offsets *offs,
> +					u8 ema_index);

here ^^

>  static inline int
> -ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems)
> +ieee80211_get_mbssid_beacon_len(struct cfg80211_mbssid_elems *elems, int=
 i)
>  {
> -	int i, len =3D 0;
> +	int len =3D 0;
> =20
>  	if (!elems)
>  		return 0;
> +	else if (i < IEEE80211_MBSSID_ELEMS_ALL || i >=3D elems->cnt)
> +		return -1;

-1 is a strange return value (it means -EPERM but you didn't say it);
maybe use -EINVAL?

> @@ -5059,7 +5065,8 @@ ieee80211_beacon_get_ap(struct ieee80211_hw *hw,
>  			struct ieee80211_mutable_offsets *offs,
>  			bool is_template,
>  			struct beacon_data *beacon,
> -			struct ieee80211_chanctx_conf *chanctx_conf)
> +			struct ieee80211_chanctx_conf *chanctx_conf,
> +			int ema_index)

A lot of this stuff is now conflicting with MLO work, so also needs a
rebase.

> -	mbssid_len =3D ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies);
> +	mbssid_len =3D ieee80211_get_mbssid_beacon_len(beacon->mbssid_ies,
> +						     ema_index);
> +	if (mbssid_len =3D=3D -1)

< 0 then here

> +static void
> +ieee80211_beacon_get_ap_ema_list(struct ieee80211_hw *hw,
> +				 struct ieee80211_vif *vif,
> +				 struct ieee80211_mutable_offsets *offs,
> +				 bool is_template, struct beacon_data *beacon,
> +				 struct ieee80211_chanctx_conf *chanctx_conf,
> +				 struct ieee80211_ema_beacons **ema_beacons)

The API here is weird, why not *return* what goes into *ema_beacons?

> +struct ieee80211_ema_beacons *
> +ieee80211_beacon_get_template_ema_list(struct ieee80211_hw *hw,
> +				       struct ieee80211_vif *vif)
> +{
> +	struct ieee80211_ema_beacons *ema_beacons =3D NULL;
> +	(void)__ieee80211_beacon_get(hw, vif, NULL, false, 0, &ema_beacons);
> +	return ema_beacons;


couple of blank lines would be nice, and maybe check the return value
and WARN_ON() it not being NULL? It should be NULL in this case, I
think?

johannes
