Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C839D4ACF46
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Feb 2022 03:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiBHC4T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 21:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbiBHC4S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 21:56:18 -0500
X-Greylist: delayed 409 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 18:56:16 PST
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D217FC061A73
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 18:56:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 7A4C35C01A1;
        Mon,  7 Feb 2022 21:49:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 07 Feb 2022 21:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=etXZ6wl4Ah6pH5VQ98v25ir+EO88HVZOUHoQ5LhRz
        +c=; b=RM3uy5cHv1A5FVCdVUWrEWmVCRJM+AMcAnpGow8SbRrwbSk6Q5qCiNIR4
        EHBpjOUN/yehiTaQgar3SPQrNJ0Nr0ZEUcLM2sZxYipaykuiiXlkLGciFEuMaORz
        sJ7G+KqCTerRDPdd8sP6peeZRkaVDpzPrr0LWD6qAYpM9zHL2lVY2rxKXquSNT7+
        dGF+avjZXUUgbPSdCueY+GYZwf7M99HW9GE/id+hONPooCiP4mXqOYJncGZ78wl7
        V8p1aPYBRKL41w06w4SrtPdWCI1zQOnPmwM86KmYzZEcuiQ0n90y+uKnerdDQY32
        eWxq2EeXYpMEwgNXZZV6MxGPHUf1A==
X-ME-Sender: <xms:NtoBYvb7ACjkLYPwaU2hC1qOJsAID8Dd3TilZNbnq2tGXIF60m9aUA>
    <xme:NtoBYuZniM1sOF6ziyXZstgPSHlyHkdjsrxJQH2_3nB8SqU3dtJBrVXJw9rF4t2eV
    OREnWBk-SNSFg>
X-ME-Received: <xmr:NtoBYh851UMhUIiBLObF0Y10jl7GQTierTn29RYwL_cZKIAGMEpHRj4GsDeraUc0R33B7-Yzvac0rxsHtQhjYXIyvSs8uMwVHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrheeigdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtjeenucfhrhhomhepofgrrhgvkhcuofgr
    rhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinhhvihhsih
    gslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgeehteegiefh
    kedviedutdejieeugeekheetgeektdfhkedtgedvgeevhfehfedtnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghksehinhhvihhsihgslh
    gvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:NtoBYlqYkkKleZ5O5CBwlWJVl1djqYm_2Yz9IgfIGmeMAsUg9trlig>
    <xmx:NtoBYqp-h8iUTwId5vNrnVvRZagnyiYmEvYicslYs_9E6S6qUlxguw>
    <xmx:NtoBYrRGHM_7Onj6TqliBh8ZZ8-aPgFkt4yGFBGebE9mrQ_Gsncd8w>
    <xmx:NtoBYhS7vtdzYs-sn9tt_GcoMySkQaVpn_08myWmaEM1i5hu3zji-A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Feb 2022 21:49:25 -0500 (EST)
Date:   Tue, 8 Feb 2022 03:49:22 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: GPF on memory allocation, bisected down to "iwlwifi: fix leaks/bad
 data after failed firmware load"
Message-ID: <YgHaMm7ibTHgxHLn@mail-itl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pP8LWyKJE64aEzdQ"
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--pP8LWyKJE64aEzdQ
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 8 Feb 2022 03:49:22 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>
Subject: GPF on memory allocation, bisected down to "iwlwifi: fix leaks/bad
 data after failed firmware load"

Hi,

After updating from 5.15.14 to 5.16.5, I started getting GPF at
seemingly random places, but always(?) related to some memory allocation
(kmalloc, kmem_cache_alloc_trace etc). Since I had very specific good
and bad versions, and trivial reproducer (it crashes on boot rather
quickly), I bisected it, and ended up with:

    iwlwifi: fix leaks/bad data after failed firmware load

    If firmware load fails after having loaded some parts of the
    firmware, e.g. the IML image, then this would leak. For the
    host command list we'd end up running into a WARN on the next
    attempt to load another firmware image.

    Fix this by calling iwl_dealloc_ucode() on failures, and make
    that also clear the data so we start fresh on the next round.

    Signed-off-by: Johannes Berg <johannes.berg@intel.com>
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
    Link: https://lore.kernel.org/r/iwlwifi.20211210110539.1f742f0eb58a.I13=
15f22f6aa632d94ae2069f85e1bca5e734dce0@changeid
    Signed-off-by: Luca Coelho <luciano.coelho@intel.com>

as the first bad commit.

And indeed, after reverting it on top of 5.16.5, the problem disappears.

What I think is an important details, I don't have any firmware for the
network card on this setup, so all attempts fails (several messages
about failed firmware load, for a variety of versions).

Some more details (including specific crash log) are at https://github.com/=
QubesOS/qubes-issues/issues/7241


--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--pP8LWyKJE64aEzdQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmIB2jIACgkQ24/THMrX
1yxdnQf/VcbQsAz7QVs4rC9SkOOWeF1g3t8KFlgU6c47tdDuiU9G9gTqA0BOnkuh
m5zGf8dBmPbznSKkBtAGnSvPEeq+mwpAFtdC7IgrW0RkgXk0UYbUqV8tlT15yJyl
RjssErwuACb1RFa031O3gsExrOqBnPW/RgPrHRdk8ben/F9lMLj2F5bPGv/Sn5FF
xkGg3JZ68LrH3NRomL23EzvarmPQD2MGNYWTMvokiBNB1bJIquYjB2Jyq8HPTjSI
yyl9wcM7nDvQkDI6o/87+7nRiQ0+W8pwWlgv0eX9i488B7wW4VXrvBVh0i90y4DV
6SZAVCcEwy3h8RI371BFRer09YmTow==
=fEOR
-----END PGP SIGNATURE-----

--pP8LWyKJE64aEzdQ--
