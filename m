Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5A64E6F27
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 08:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353065AbiCYHu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 03:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241046AbiCYHuY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 03:50:24 -0400
X-Greylist: delayed 1354 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 25 Mar 2022 00:48:51 PDT
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472883B543
        for <linux-wireless@vger.kernel.org>; Fri, 25 Mar 2022 00:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1648194529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i+P0KHJR5IxWQGQVnkvS35TIM3P98/PQ/lmJTKSZ9jo=;
        b=T2JIac/TgTqZJdCwgxlR4XNogDy6pp2IWqRCW9x+aSjY+/6lH849qZ7fz0++zpFDqV91L5
        Vl/6eqzaMqFafaln7HpPRtqCokugGTgLrKBNw3l6SHAaTzugN9kWKysnFv1ca1uQn5Y0+a
        0MdVFlMJZtiFuAYudDQ51sUYDQIbhPQ=
From:   Sven Eckelmann <sven@narfation.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v6 1/3] nl80211: Add support for beacon tx mode
Date:   Fri, 25 Mar 2022 08:48:44 +0100
Message-ID: <4555984.c4UlCidsYr@ripper>
In-Reply-To: <20220325055949.3035053-2-quic_mkenna@quicinc.com>
References: <20220325055949.3035053-1-quic_mkenna@quicinc.com> <20220325055949.3035053-2-quic_mkenna@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6084859.M4ah1GsTNC"; micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart6084859.M4ah1GsTNC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v6 1/3] nl80211: Add support for beacon tx mode
Date: Fri, 25 Mar 2022 08:48:44 +0100
Message-ID: <4555984.c4UlCidsYr@ripper>
In-Reply-To: <20220325055949.3035053-2-quic_mkenna@quicinc.com>
References: <20220325055949.3035053-1-quic_mkenna@quicinc.com> <20220325055949.3035053-2-quic_mkenna@quicinc.com>

On Friday, 25 March 2022 06:59:47 CET Maharaja Kennadyrajan wrote:
> @@ -5555,6 +5558,10 @@ static int nl80211_start_ap(struct sk_buff *skb, struct genl_info *info)
>         params->dtim_period =
>                 nla_get_u32(info->attrs[NL80211_ATTR_DTIM_PERIOD]);
>  
> +       if (info->attrs[NL80211_ATTR_BEACON_TX_MODE])
> +               params->beacon_tx_mode =
> +                       nla_get_u32(info->attrs[NL80211_ATTR_BEACON_TX_MODE]);
> +
>         err = cfg80211_validate_beacon_int(rdev, dev->ieee80211_ptr->iftype,
>                                            params->beacon_interval);
>         if (err)

But why are you setting it by vif when it is actually a PHY setting? [1]


And there is also the open question from Felix [2]:

On Tuesday, 10 August 2021 16:33:41 CET Felix Fietkau wrote:
> It still seems to me like something that the driver should detect and
> handle internally without user configuration, based on number of VAPs
> and maybe multicast/beacon rate (since the packet duration issue will be
> worse with CCK rates).

Kind regards,
        Sven

[1] https://lore.kernel.org/all/2718995.X0rUDs3ZmB@ripper/
    https://lore.kernel.org/all/4581459.tLtf2NohVe@ripper/
    https://lore.kernel.org/all/6210385.n8AMQ0p90U@ripper/
    https://lore.kernel.org/all/4594028.WNQrFERZ9z@ripper/
[2] https://lore.kernel.org/all/92b48724-277c-fc48-a922-6b1d49cd6a71@nbd.name/
--nextPart6084859.M4ah1GsTNC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmI9c90ACgkQXYcKB8Em
e0Y7FRAAm3fE0tpWVdZo4Hz419mTkM4kURrTcS+8uYtS7GPSRcT9ZhdwCKV4OnV3
MIyFGSGznYUeVwTcEsNwtyac2BhmialPykapF6XHpbNK9+gaVIvCKG764mtvPOjS
TxsEPW72RnG5PjMNVvnDNAmqxNR5R5lNPG29v6HmyOCdW7FwHfXdWm6gIC+Lg88j
z5fMZixyQZr92EnNpfItH6VlTIwppjEt7bO2DX9Yqlrh7JESYF2c5BTiXxjXwKJ9
qdI6iVSfHkOwkb7iC1OlMIOmq7Vsn/+zmyrOmw87gw1wY4gIC8nn0McDjLc8lycg
7xmdOHC6afW44kJB60RUF5LCNhNxCec0Q/VVaedq59GGfj5UGrV6rDlo1Zwbr5WQ
8jnn8Y3pCJyFlsgvdF+ydfZwJpX3Go5jKYj6Ysg5iSJo1guyqrR3puU+Fb4YhH91
iT7E9JWBfYQtpLAH2bIWil0ibSKoVUEzxqIshFwvJEbfB41/DQ5aOnjIijpfPMtu
WRa977JutlN6p88lZTSQ5j36aMdU7CFLVPOFi5A8URz5HmcD8qCxofW7opiW6zBj
BYWiWCtkgrj+vUZhwcn5FfVB53EgXO//nrT7BOlP8xkDktmeEfV2c5esIgfFagQf
t4o2vzK6bOOu0omKk+eNW+DSl+0832yO2wyl0kGAScl+x8ZB820=
=kHAi
-----END PGP SIGNATURE-----

--nextPart6084859.M4ah1GsTNC--



