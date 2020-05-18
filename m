Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82661D7924
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2020 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgERNBe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 May 2020 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbgERNBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 May 2020 09:01:34 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D20C061A0C;
        Mon, 18 May 2020 06:01:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49QfKH5PKQz9sTY;
        Mon, 18 May 2020 23:01:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589806885;
        bh=X87x2O/NgHgg3pQpZtNm9qm3ZbblNwSzNsBmhoy99ww=;
        h=Date:From:To:Cc:Subject:From;
        b=cVS7jAFaI3QUD3oMiUjV1oa9TRmDqjdksbhYdPw68gGZHUCID3kP5plttFCMHyPnz
         GVJ6C430GOrSl0NeVfAXOPVrUUdSDVfN6BgLBQBGpak/QQIZZB4OZ01guSKg3Pz0oi
         8/WM++ctW1HmwBKuNJ0IXtUoPISZlYV6PXTwtoa1fXOyozeuHapLfi+ha4IoUBh7PO
         bKfHwIZmEiX2mnMN46SWyI9XauCqoI3DLNFIsR0Y01JHNNu2DLVYTlSILP23+kSyAE
         6fXyuLGq1zM7kq1lJ4TCNnl3Dt/dNvbMgsxqXEs792FtkQbxVr2jxz4mdp3QdQPdmk
         RmNHjPOHAVyJA==
Date:   Mon, 18 May 2020 23:01:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: linux-next: Fixes tag needs some work in the wireless-drivers-next
 tree
Message-ID: <20200518230120.7b4c6074@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/dSih45EDoyKnaSCqCDR/H=S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/dSih45EDoyKnaSCqCDR/H=S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f8d6379932dd ("mt76: mt7663: fix the usage WoW with net detect support")

Fixes tag

  Fixes: bd39bd2f00c3 ("mt76: mt7663: introduce WoW with net detect support=
")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a72ad451e704 ("mt76: mt7663: introduce WoW with net detect support")

--=20
Cheers,
Stephen Rothwell

--Sig_/dSih45EDoyKnaSCqCDR/H=S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7ChyAACgkQAVBC80lX
0GyYuAf/Q7gNlAhBoIJFTdZtFGN/5W95393jFP7jFdQh6WpjGZGxicr/sVpe+qSQ
K2Wtj3elCW4rQsuEdTVSfOHCpwbw00niNP8krcc6Ktmv+XSmRiqVie/9Qqf+ATUG
AfvWK2JYyQxZLUQZ1OsBW5Te2szDyCgewlNE5gl25gpBfTQhOAaY3qCdtSFkPaSI
LPiXibm9hY8GwshznMH2FF/paZ03p9PGrN1buIuiMHzp/hA2DV/c2QIDwzdLLt5O
VY/E//yuvfPuwJCe26MVJggv7JqaL7hQwsXGfM0GIVFLq6CaeKAIRDyamIqMv3Ef
jtcXWkITe8UqFShODEdgKOXp4mGf7Q==
=5c9u
-----END PGP SIGNATURE-----

--Sig_/dSih45EDoyKnaSCqCDR/H=S--
