Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41523E3E35
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 05:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhHIDSh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Aug 2021 23:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhHIDSh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Aug 2021 23:18:37 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA6C061757;
        Sun,  8 Aug 2021 20:18:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gjh9d6X6Hz9sWX;
        Mon,  9 Aug 2021 13:18:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1628479094;
        bh=JSjEqkO0SK13kfbGfd0rXE6B3pLcWE5fT+mLWjxOuiw=;
        h=Date:From:To:Cc:Subject:From;
        b=nKJDIYvetzsui66DegHwPeFqT0Gb3dN7kKtMnzeKtXFeusjw5KeWSf6uE7gOIRyib
         +kSmEkj75DJQWP810obJ0c6YkaShU60RMX5kTugApNusgi/RnNjOnDB+jp7VL0wtZr
         JW4oznlQNA03WJuE8gKZsUWWsSpUSjR5DqEBx6E00JrkSXNPTTSrJYT/6vmDFrnWE0
         GijB2ao4HwlslA/or2BZAd37l/CiOr8a4cZEwCBJuk2aDHEcJyhnTvQhI+IPr/7rZv
         9b/gFG1OYjvrf8Mpu8MXJgixJfbRYnFn3XQqjkjeKrBgj7DYjx7S6Gd4gKi2atgPEn
         Ryg7bsoCR9WkQ==
Date:   Mon, 9 Aug 2021 13:18:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: linux-next: manual merge of the wireless-drivers-next tree with the
 printk tree
Message-ID: <20210809131813.3989f9e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J0qSpD.0pt+p+Ol=dY3doOR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/J0qSpD.0pt+p+Ol=dY3doOR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-drivers-next tree got a
conflict in:

  MAINTAINERS

between commit:

  337015573718 ("printk: Userspace format indexing support")

from the printk tree and commit:

  d249ff28b1d8 ("intersil: remove obsolete prism54 wireless driver")

from the wireless-drivers-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 5cf181197a50,492bc169c3bd..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -14974,18 -14927,6 +14974,11 @@@ S:	Maintaine
  F:	include/linux/printk.h
  F:	kernel/printk/
 =20
 +PRINTK INDEXING
 +R:	Chris Down <chris@chrisdown.name>
 +S:	Maintained
 +F:	kernel/printk/index.c
 +
- PRISM54 WIRELESS DRIVER
- M:	Luis Chamberlain <mcgrof@kernel.org>
- L:	linux-wireless@vger.kernel.org
- S:	Obsolete
- W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
- F:	drivers/net/wireless/intersil/prism54/
-=20
  PROC FILESYSTEM
  L:	linux-kernel@vger.kernel.org
  L:	linux-fsdevel@vger.kernel.org

--Sig_/J0qSpD.0pt+p+Ol=dY3doOR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEQnnUACgkQAVBC80lX
0GwOYwf+MWaAUMoUFCY9sT8KILHP1ELpF5s271ME6q15pHJp/cOQjUh88YvcbjaZ
UMR3opUfNatDLhVZb1DW/L9ru29hOIO8ShIO4OaJrhuk6Dp0Y+5vt8wMzOzbFoOm
RPL2bIQJTvNRo1nXb2Wah1TAH1UZ80LzS7ZDA/lbs+eT2Zy3EAzsW6LHI6BSeOE/
eGIW73qh7HNXtJBP4cOjP5ILf5FHmat+BygqIJ/Hf/QK37HeaK8RThLjfkANFv+D
rhsi64Si6uLOVdy697lqXTdKWOcil66J7OyGBKpk/sJDqKKJ1n6zeRbpeLcrjhzS
8ESUqh7YLm9dLU/GSNf5M/xtS20e3Q==
=k0gP
-----END PGP SIGNATURE-----

--Sig_/J0qSpD.0pt+p+Ol=dY3doOR--
