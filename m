Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 357C11902B4
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 01:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgCXAQ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 20:16:58 -0400
Received: from ozlabs.org ([203.11.71.1]:53415 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgCXAQ6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 20:16:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48mWyb184lz9sSJ;
        Tue, 24 Mar 2020 11:16:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585009015;
        bh=UyAyFRUUjQ9pV8eiOPAkzACSHmb6g27IvMDSbEpjDRk=;
        h=Date:From:To:Cc:Subject:From;
        b=BQyaiOLeINODXxsqwsABi5YDLuWkCLcEvH9F140P9h4NdRizxWFDbSVF6tCLYfSuA
         XesN15TPaz/75RDP9c4HLeZP1k3lcAykSmOHpAibDxYzPlMrWrI6myk8rr1cXpsXr0
         tDinj2rOsJAhMnEJNQCyiZO54a3We1EfvdLsXE5ej7p0nAjXFTTuPtPii6s4b3VvPD
         CYeQkB0IPHl6O5k2UuPcihUEZcyi1/dyYoPToe53iv5ywCp8XSTRcNzfaq6u/NUng0
         lGXSFoXNPZ18rPA9rPYfQYLcOKPyU4/CjTlEk9H1KXy18iM8L0aoL09N2BVuPDOf0i
         vGzB2N7q5vUew==
Date:   Tue, 24 Mar 2020 11:16:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: linux-next: manual merge of the wireless-drivers-next tree with the
 wireless-drivers tree
Message-ID: <20200324111653.35c368e4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1iuFxirNRaHI1rvguqsXKpC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/1iuFxirNRaHI1rvguqsXKpC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the wireless-drivers-next tree got a
conflict in:

  drivers/net/wireless/intel/iwlwifi/pcie/drv.c

between commit:

  cf52c8a776d1 ("iwlwifi: pcie: add 0x2526/0x401* devices back to cfg detec=
tion")

from the wireless-drivers tree and commits:

  67eb556da609 ("iwlwifi: combine 9260 cfgs that only change names")
  d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device tables")

from the wireless-drivers-next tree.

I fixed it up (I am not sure wat to do with this, so I just dropped
the former changes for now) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/1iuFxirNRaHI1rvguqsXKpC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl55UXUACgkQAVBC80lX
0GypWAf/ULY84JHkgyu2HVudGAMWzb0lPVYilJbpv8ZXO915xTphftU7gEPLMf8t
AmRbVQfP1Aw54fr87F4dKOO3gSsquJuIpQhthS9KJBTaxa4Cmms6DuT7J1WrRus8
pHSXpbOTs9AabtvbkPgjuFdT/4CGFeHoSC6nY6vWIF0BZ0Ox7aeDymCuhyeI0WCO
Y9sQP4pTMPainFgWi160afa7JZ1eFeVGyI3iNkoAbCsn6trZ0qtdRGOIevABJWhX
kdFCL8X3MZqGPuduLq44TQJqkYDxs81+XahCtXj2V+hDQlYUf0I52WU6CMyNqPRD
d+nVfbP533IQz/lNvfK/aPF4sK855A==
=E1Ol
-----END PGP SIGNATURE-----

--Sig_/1iuFxirNRaHI1rvguqsXKpC--
