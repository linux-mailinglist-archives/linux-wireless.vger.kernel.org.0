Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8630B332492
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 12:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbhCIL6J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 06:58:09 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:48264 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229688AbhCIL5t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 06:57:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lJazg-004Rqj-93; Tue, 09 Mar 2021 13:57:45 +0200
Message-ID: <8e3877efc92f413d47ee1d71a119885c765d7312.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>, tmb@tmb.nu
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Tue, 09 Mar 2021 13:57:42 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-YmT9WImHGlGjsNz0NIG6"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull request: iwlwifi firmware updates 2021-03-05-v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-YmT9WImHGlGjsNz0NIG6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is v2 of my update which contains some new and updated files for
all our currently maintained FW binaries.

In v2:

   * Fixed WHENCE so that the new files match, with "62" instead of
   "59".

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 5ecd13ffe8e24385cf4f30f3d0dcaff4dfb24de2=
:

  Mellanox: Add new mlxsw_spectrum firmware xx.2008.2406 (2021-03-03 13:23:=
49 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-firmware.gi=
t iwlwifi-fw-2021-03-05-v2

for you to fetch changes up to b46d336044c448987589bd6cf3057f404c5581ad:

  iwlwifi: add new FWs from core59-66 release (2021-03-09 13:51:26 +0200)

----------------------------------------------------------------
Update iwlwifi firmwares to Core59-66

----------------------------------------------------------------
Luca Coelho (3):
      iwlwifi: update 7265D firmware
      iwlwifi: update 9000-family firmwares
      iwlwifi: add new FWs from core59-66 release

 WHENCE                            |  34 +++++++++++++++++++++++++++++++++-
 iwlwifi-7265D-29.ucode            | Bin 1036444 -> 1036772 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1512096 -> 1514240 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1483116 -> 1485556 bytes
 iwlwifi-Qu-b0-hr-b0-62.ucode      | Bin 0 -> 1329296 bytes
 iwlwifi-Qu-b0-jf-b0-62.ucode      | Bin 0 -> 1248672 bytes
 iwlwifi-Qu-c0-hr-b0-62.ucode      | Bin 0 -> 1329312 bytes
 iwlwifi-Qu-c0-jf-b0-62.ucode      | Bin 0 -> 1248688 bytes
 iwlwifi-QuZ-a0-hr-b0-62.ucode     | Bin 0 -> 1328924 bytes
 iwlwifi-QuZ-a0-jf-b0-62.ucode     | Bin 0 -> 1248672 bytes
 iwlwifi-cc-a0-62.ucode            | Bin 0 -> 1292672 bytes
 iwlwifi-ty-a0-gf-a0-62.ucode      | Bin 0 -> 1455104 bytes
 iwlwifi-ty-a0-gf-a0.pnvm          | Bin 0 -> 27456 bytes
 13 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-62.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-62.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-62.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-62.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-62.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-62.ucode
 create mode 100644 iwlwifi-cc-a0-62.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0-62.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0.pnvm


--=-YmT9WImHGlGjsNz0NIG6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmBHYrYACgkQoUecoho8
xfoYHRAAhRfLLyBa8EsmwrOkIaNk8jkYrYqCwg2QY31im3nveYXKwQ+m5dMwvfYf
y6oI7/FvjWbeJtygs443w0zPJE145+S1nxzJn1YYlXHx8Xy7AMn87Sd1vC27azO7
EfMXAUcR/jzWzX2ga9qiCruvA0U5QeRsjQIzTihLxyPaWyZaCQVmLiDI7el/+dVz
WovYy+ZZEqxtWmEFDgfDvsMpVAAgEy0AQ6WBqhAyxIu1O/NnmRgOJZyHrobnsDpr
sdRhEtAlNAyMOzFpNmslPeURj2yPVN61RIDnKYdJBxDc4aTpkd3f4/ThOO/QPwxw
JZ/FmK4c+TPzyPvxLtEnAbRJ7nPtblyUb1mj/+3/O2ZQ/7zFqmzrOJFeECjOsfbj
8IsQtxx4AKeaqcXfs3uVcyCCinClcYJ0Q9b9z8PkpMIhH4xjb58VPmw6+WyK7Gz0
DhQauFLD92CKG/G0qyyrfyOxueICvvnpkd4gRnA01gAXR3RoRCUuEods1J++tmv4
GCsnX7xfc4hS/qA9/wO3fW659e2yppf09bRr5x5D7nAi/TRgSrdU0EQnjwRoMTCR
69mtdF06akbOl7dxj8RA8ypf62J5ITnj0VsFfCPpI0hol72YKWd+eXOQReKt9mLY
hEmhJcU3BTc6zcnb6SMmnD0nOE4YacZIFSgaRNxW373b0HO/v/w=
=Hssw
-----END PGP SIGNATURE-----

--=-YmT9WImHGlGjsNz0NIG6--

