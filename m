Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95D2AEF4F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 06:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfD3EIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 00:08:35 -0400
Received: from ozlabs.org ([203.11.71.1]:39185 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbfD3EIf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 00:08:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44tSgg6714z9s9T;
        Tue, 30 Apr 2019 14:08:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556597312;
        bh=C5jmSAwGU4wULlxPVC3aIbIFHP35gyUYmZb0JCkUpH8=;
        h=Date:From:To:Cc:Subject:From;
        b=TE2sO4Q3T5tfLrnfG+mQNDi2Qpvcg9ILjbwbHHPf5OUqlEoveyKqaRbsAPx17aeaJ
         0oFekzb0HHVXOQgH/bZprMjlLm7VcwRfqRU09dYbiPTeO6bfEU9XCVj8mV8415tx+N
         I00lb2Z7VgKh48a4ylORTlTlXVZPkLuRuBngRPDgSBc9mGXcYzepOHlNWGIctS6fZw
         BTpcI7jP4L2/7uoi2IjG9y9j+Z60F6eOKCrKeNDOdYzBus7RGg/IrzxVODh3k6vnxL
         p1DAxO3o+vx7+OymZbRZU4bTQkgqtPsnxRlCvEEEqLdExipACWDycyWajSaaZmQVWy
         wqWb0jeVYqPTw==
Date:   Tue, 30 Apr 2019 14:08:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>
Subject: linux-next: manual merge of the wireless-drivers-next tree with the
 wireless-drivers tree
Message-ID: <20190430140831.6095243c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/.r+ego657j0+ULOk+yG7gms"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/.r+ego657j0+ULOk+yG7gms
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-drivers-next tree got a
conflict in:

  drivers/net/wireless/intel/iwlwifi/fw/file.h

between commit:

  b35f63972c5c ("iwlwifi: dbg_ini: check debug TLV type explicitly")

from the wireless-drivers tree and commit:

  aee1b6385e29 ("iwlwifi: support fseq tlv and print fseq version")

from the wireless-drivers-next tree.

I fixed it up (the latter is a superset of the former) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/.r+ego657j0+ULOk+yG7gms
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzHyj8ACgkQAVBC80lX
0GxKWQgAl7k/YiZbxsRuQX2dYBCZrZKieidNaLZ/YIpqGxPQB6gF2RnfD28Qrf7x
cZ2CdxmwsBKyuD/2RdmmJrNzer8c9LNfv9OLimwgL8dFKnMbVhLpUZ48Qioeu8Sc
+SSLKIxn4dquOJzaYmgxplgsAt7exD6D1GApfeykCbx1fyl+GyMpaQ1yafJ0ApKR
EZxq9kx/w8908rDBxH1hiUw2C0xLxd0XmYubWn52zCcUxe0/sOkQzGpfkUqiv9pu
Wwi9SzaEC71Gi8l9bGNEK4A89EKbJjYBA8zrqEVFi1wm20oBlPeGJQXNag5jsVtu
eRpWSe10j9zbezv79+txwKs2POctyg==
=799w
-----END PGP SIGNATURE-----

--Sig_/.r+ego657j0+ULOk+yG7gms--
