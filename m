Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEFA674C17
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jan 2023 06:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjATFXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Jan 2023 00:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjATFXg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Jan 2023 00:23:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EEF518E2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 21:13:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47A9EB8229C
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 18:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C308C433D2;
        Thu, 19 Jan 2023 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674153379;
        bh=zd/EkAAlkdTq8J7TE4rPZJX0/BqiOxjrGk4JpUHzfQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZviGmF8HOGozsdQ7L8Oyfy/gFcyT/irK2N7YuQGF2vJKOKLOleY1EIx/qxi4ZTAiU
         LzH+8pokS3vsMf1ZXVs+GDSxoySrnlyxOkBsUG9YS2EpQdfaDcJQ19MLf4weDs1+ow
         l/LnufHM14Jryy7GuMA7wj0KWw8El2deZseCTS5mLL8kxtEEz9MzdpO/pMfcmtuOkC
         KTUk5aLv+xJPOcORWQzy0cPFgI/Bc6/BNlBfhjuS94olF3GVPp56f+DmhZFrHxrJLb
         LhVZhp+XGrlR7FSB2SjKheeyI6BVXaZj40ewX8z72nX4TAhefOND6h1EvUYU5+Z71O
         LItcsn7Z8UfnQ==
Date:   Thu, 19 Jan 2023 19:36:15 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
Message-ID: <Y8mNn18XeUcEjLWe@lore-desk>
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
 <20221226083328.29051-2-quic_ramess@quicinc.com>
 <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
 <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
 <2a2332211b2ca9daa968a3644006f5c9e0c88a00.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CjbjeWRTJw133AO1"
Content-Disposition: inline
In-Reply-To: <2a2332211b2ca9daa968a3644006f5c9e0c88a00.camel@sipsolutions.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--CjbjeWRTJw133AO1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, 2023-01-19 at 15:52 +0100, Nicolas Cavallari wrote:
> >=20
> > This may not be related, but the software color collision detection=20
> > sends a netlink message for every colliding frame and it can hose up th=
e=20
> > system if the other network is very active.
> >=20
> > Also, cfg80211_bss_color_notify() complains that the wdev lock isn't he=
ld.
>=20
> Yay.
>=20
> Lorenzo can you take a look at that?

It seems fine to me, I am just wondering if we need to forward the info to =
the
hw (if it supports hw color collision detection) if we just flip
collision_detection_enabled field in ieee80211_change_beacon().
What do you think?

Regards,
Lorenzo

>=20
> johannes

--CjbjeWRTJw133AO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8mNnwAKCRA6cBh0uS2t
rF1WAQDn0Cpq8dywuxhT9abbxS+UcqmUcLXe506jMOtSe0qEgQD+ISFZ0CY7xESa
GESufErqWNSQzx08Bf2a03IvzoCfIg8=
=9anP
-----END PGP SIGNATURE-----

--CjbjeWRTJw133AO1--
