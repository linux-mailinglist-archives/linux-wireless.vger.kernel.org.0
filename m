Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB282234F5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgGQGxm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgGQGxm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:53:42 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A2C061755;
        Thu, 16 Jul 2020 23:53:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B7MKF4Q8Vz9sRN;
        Fri, 17 Jul 2020 16:53:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594968819;
        bh=TW11RH4a+EN4x+mZM4SOcko8dhOIwqkcGt1Dnpx8oYA=;
        h=Date:From:To:Cc:Subject:From;
        b=HVSNQOpLpJwIgiuS61jiO0pV6IbvtgVlvz/39c28XQefQoj1lHloubT8yHiQP4Yyf
         +uw8sNfuFdx5swECB8zWHXGocWhtH9h4+INLFCNoKX0IoQbyddCSg8jxDRPRLeWEz1
         7YhsEiOJMV85YoYd8IMvEqfruDfmUwXt7pFF2zrgLtWikfWg9g/GyeVLZXJqQ2TOgu
         X/ZDeT+3BIkP1nakkpTLv2InLVHyHVT8zGhGM9WgnRrc5VxpmIaTMvuCxsgYFBbWvF
         bbIEk4GW77C0RQ5mNcwHAPO2THkc4uHRZeUWL1iVnO+vuBL1WpNzY9Sgd8ln45oHJa
         K1FrQ/WFqtGtQ==
Date:   Fri, 17 Jul 2020 16:53:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>, Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: linux-next: manual merge of the dmaengine tree with the
 wireless-drivers-next and Linus' trees
Message-ID: <20200717165336.312dcf09@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Uf/BJuEv2ixcmi=SB=JFSm5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/Uf/BJuEv2ixcmi=SB=JFSm5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dmaengine tree got a conflict in:

  MAINTAINERS

between commit:

  5625f965d764 ("wilc1000: move wilc driver out of staging")

from the wireless-drivers-next tree, commit:

  6e701c299469 ("MAINTAINERS: merge entries for felix and ocelot drivers")

from Linus' tree and commit:

  c3846c4cce15 ("MAINTAINERS: dmaengine: Microchip: add Tudor Ambarus as co=
-maintainer")

from the dmaengine tree.

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
index 07d6eae16e77,9af8f81f726d..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -11399,20 -11364,14 +11401,13 @@@ L:	linux-arm-kernel@lists.infradead.or
  S:	Supported
  F:	drivers/usb/gadget/udc/atmel_usba_udc.*
 =20
 -MICROSEMI ETHERNET SWITCH DRIVER
 -M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
 -M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
 -L:	netdev@vger.kernel.org
 +MICROCHIP WILC1000 WIFI DRIVER
 +M:	Ajay Singh <ajay.kathat@microchip.com>
 +M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 +L:	linux-wireless@vger.kernel.org
  S:	Supported
 -F:	drivers/net/ethernet/mscc/
 -F:	include/soc/mscc/ocelot*
 +F:	drivers/net/wireless/microchip/wilc1000/
 =20
- MICROCHIP XDMA DRIVER
- M:	Ludovic Desroches <ludovic.desroches@microchip.com>
- L:	linux-arm-kernel@lists.infradead.org
- L:	dmaengine@vger.kernel.org
- S:	Supported
- F:	drivers/dma/at_xdmac.c
-=20
  MICROSEMI MIPS SOCS
  M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
  M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>

--Sig_/Uf/BJuEv2ixcmi=SB=JFSm5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8RSvAACgkQAVBC80lX
0GzJ4gf/QE464SKG+82DKbBdRf9XtK6X9hLGlMfWpWIsJWwHhbHrzEPQEs1eTmL/
T6idIqQ6cfw9gM7TMDaAmZd1h9K1+dZQN1bZ3k2PMn6DfYngEyeCqb3XYDTyw8cu
kApO94RiZIcipPdrx8pr4DfBEERSdBu8mSevYgxyYAhrNrCjoe/LdWEoBZ/kO+CN
KxtB9AypNLgtp5fio4UtR8x1tQwo/SoRMLUAYp6zJrQYJ5imDuCBZcefiBvjIohJ
uARPLWu5lnipjj3HVc+VFgBX2mnb6TjW1Dgllp1BrONTVliAXftUOgYU7vi4s3+D
RldGA0ZWeu/DLx1ysGcELkoXSmEIPw==
=0EUF
-----END PGP SIGNATURE-----

--Sig_/Uf/BJuEv2ixcmi=SB=JFSm5--
