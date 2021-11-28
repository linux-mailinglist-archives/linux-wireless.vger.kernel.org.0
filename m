Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8AF4609D1
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Nov 2021 21:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358192AbhK1U5Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 15:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243450AbhK1UzO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 15:55:14 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AF6C061756;
        Sun, 28 Nov 2021 12:51:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J2LJD51VWz4xQs;
        Mon, 29 Nov 2021 07:51:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638132716;
        bh=4n4EyW8mjec4vXK3msghbyzqZgzR3H9Xayy3JzGc36Y=;
        h=Date:From:To:Cc:Subject:From;
        b=ada6AiNsdUypRax4XdKIK+zrXAnXbhwUKSlktQzdHHCFhuufuaVFY4Zq6suiPhWvr
         tFCH/ej/O3LhTc+pvS4lnOaP9ooKomBNVcLp9HJf3Oi59yaSElB/NLdmQ9rd3j0E51
         jq4w/tEVeQj0Y2hvBrAMAPNV536KOghkiidUQz2DgGb3WEnym2+Biapat9Mw9H42nX
         FB5WNRuq3hIOKPzslh/AKjGGIfICA2+EVrVcieSJyB5GjQCLgOmTAfkggd/Y3g+x5d
         38FFIuwxUVPcBRWaGaiRkDdvYNJneW2jT11TyolbH5RkZ33hE+cK0bEChQm3PTXs0D
         b3fhWxQnPUChw==
Date:   Mon, 29 Nov 2021 07:51:54 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Baligh Gasmi <gasmibal@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mac80211-next
 tree
Message-ID: <20211129075154.2d4f922c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/smN1nSGsTjQOSbfZkwWY=z4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/smN1nSGsTjQOSbfZkwWY=z4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2f6fedd9ff71 ("mac80211: remove useless ieee80211_vif_is_mesh() check")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/smN1nSGsTjQOSbfZkwWY=z4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGj6+oACgkQAVBC80lX
0Gz2ogf/cPVQWo2TE8kCItEI4h5lfWAkPrpxTneedxYziMwjsFkv0J/AB8Sw9Vam
+093aS4YEuMUqzCUW7FS+v30cvLaxZ0BxU0lurwKKOx3wMVdNdkPkeZ09O8S03jd
16MNsmrCgzYCtEj3tkhnjKsbddeuaUJYDDGwISO7Oq9iX6UUfuYkmhpD94jKX5/I
wOgkt9Y8dsr35U+UNZToHdXAr58IGxJU0kX+TklS93wcceR8JoRwLx0H1Or+udVi
mrv94f52kq0u8DsUmniKjKWY85A5v0c8EcyOJ59KC/rkhD/5K4sVzt/TjRdITvWu
xLRQwcmm95rcQgvMIruL4R6qAimXQw==
=U07F
-----END PGP SIGNATURE-----

--Sig_/smN1nSGsTjQOSbfZkwWY=z4--
