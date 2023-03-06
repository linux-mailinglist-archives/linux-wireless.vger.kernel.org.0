Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC876AD14D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Mar 2023 23:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCFWRE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Mar 2023 17:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCFWRA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Mar 2023 17:17:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C755D8AC
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 14:16:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C669CE13C7
        for <linux-wireless@vger.kernel.org>; Mon,  6 Mar 2023 22:16:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1CDC4339B;
        Mon,  6 Mar 2023 22:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678141012;
        bh=1h+NLDwIZodm4D3p81fZ9b+ZhwzivnzHLyY92qQK6VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e3Q277OWdSDbJGi2qMB3bXsvrt8aVwpfpH/YMyqzPBGEQXzwqBtkrlpieWmj8yCL6
         eG0A5SPTxB0/scMSecCPi9MNDtkU9eZUfekHaZzjjL/wpXbuDvxDNLqgohyrJx8fut
         70FCNwb9+8YIsekv3OnUPv2YHXgSlJWZ5a0Wxl1hmjda51LyyOniJ1zvPwon9O0Z1t
         N77sm9qvM1Nfl06yITNa7uhjp8Y+kJExmBOOwNi4X9rR7iO3sUz+BrBX6Yp1Dt1Tkf
         xVrC2nikoNv93w4mu/quX9pXT2vkCRe5FdHqhvADqpE3Lq29j24e6HaLBrQQyx490A
         ejxS6EXmhIaXA==
Date:   Mon, 6 Mar 2023 23:16:48 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com
Subject: Re: [PATCH] wifi: mt76: mt7921: introduce mt7921_get_mac80211_ops
 utility routine
Message-ID: <ZAZmUCBl+8LaoiAq@lore-desk>
References: <e52206331b479cc3089ec5c314a3327e67eb27b8.1678124807.git.lorenzo@kernel.org>
 <41b51fcc9e1ba560fbdad76d818d31167d73c265.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/n0DZKRNy329VbDq"
Content-Disposition: inline
In-Reply-To: <41b51fcc9e1ba560fbdad76d818d31167d73c265.camel@sipsolutions.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--/n0DZKRNy329VbDq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Mon, 2023-03-06 at 18:50 +0100, Lorenzo Bianconi wrote:
> >=20
> > +struct ieee80211_ops *
> > +mt7921_get_mac80211_ops(struct device *dev, void *drv_data, u8 *fw_fea=
tures)
> > +{
> > +	struct ieee80211_ops *ops;
> > +
> > +	ops =3D devm_kmemdup(dev, &mt7921_ops, sizeof(mt7921_ops), GFP_KERNEL=
);
>=20
> It's kind of nice to have static const ops so they can't be a target for
> overwriting and function pointer injection, maybe just declare two
> copies with a macro or so, with and without chanctx, and return the
> appropriate one? It won't even use more memory unless you never run a
> device w/o chanctx ops.

In the current status quo I think it is fine but it does not scale if in the
future we want to add some new fw features that require changing ieee80211_=
ops
pointer. Honestly I do not know if it is something we should consider nowad=
ays.
What do you think?

Regards,
Lorenzo

>=20
> johannes
>=20

--/n0DZKRNy329VbDq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZAZmUAAKCRA6cBh0uS2t
rNYgAQCN1CX6Mh9DdDWqvoThbJVYLFmrIdfAXtZy06+YKNFCcAEA2orq+k+vL5h0
jCHjutlZmPDB4QfqroA5K9k1odEr5gU=
=bIPJ
-----END PGP SIGNATURE-----

--/n0DZKRNy329VbDq--
