Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1633339F5
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Mar 2021 11:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhCJK1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Mar 2021 05:27:44 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:48414 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229948AbhCJK1e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Mar 2021 05:27:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1lJw3t-004SKU-OO; Wed, 10 Mar 2021 12:27:30 +0200
Message-ID: <fd69b57a71eb6a86f857d7b46c0b79dfc39c97cd.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>, tmb@tmb.nu
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Wed, 10 Mar 2021 12:27:28 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-slTvvx2rqWMRRAEEX6lb"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull request: iwlwifi firmware updates 2021-03-05-v3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-slTvvx2rqWMRRAEEX6lb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is v3 of my update which contains some new and updated files for
all our currently maintained FW binaries.

In v3:
   * Fixed a few more issues in the WHENCE file
   * Reset the author dates to avoid confusion

In v2:

   * Fixed WHENCE so that the new files match, with "62" instead of
   "59"

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
t iwlwifi-fw-2021-03-05-v3

for you to fetch changes up to 5a2fd63596125d4ed5ac65614b1811b2d4a68536:

  iwlwifi: add new FWs from core59-66 release (2021-03-10 12:23:21 +0200)

----------------------------------------------------------------
Update iwlwifi firmwares to Core59-66

----------------------------------------------------------------
Luca Coelho (3):
      iwlwifi: update 7265D firmware
      iwlwifi: update 9000-family firmwares
      iwlwifi: add new FWs from core59-66 release

 WHENCE                            |  32 +++++++++++++++++++++++++++++---
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
 13 files changed, 29 insertions(+), 3 deletions(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-62.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-62.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-62.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-62.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-62.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-62.ucode
 create mode 100644 iwlwifi-cc-a0-62.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0-62.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0.pnvm


--=-slTvvx2rqWMRRAEEX6lb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmBInxAACgkQoUecoho8
xfpZTQ//YaNRs/nNkO5BZeiHR1nqOwuhBFkiDrcYUD1vI2ty4ggCnamH6V3Nl2Eo
fUy680cg6KoZHloOPbdOoAKAhjlxO43jDg48W+uhceUn18Ulb8cx4aS9HxawaoiD
MokfyPvjJjW6SFq+M8TWQzA/gk+tYIRHmg0N4oYQfw47KALX8olnet2qoqkFcg+R
4vIzZnFsDAbILg2gQpe6LicKcY4FuLOo5FZtPxGIT7EvdJmNc+aUNodIP/Mk4Tww
WpveEsVqnGhrEy5ytOMX67+iUFE1nF+c7iuzeESdknC8AlSanXuGFboJm4HDISYl
8ScFOF8V2uuwWVmA/+6LcYMAsc57bJYCZeGVdcmR8X5SB4UspmRQAwc+GlmziuGq
NFpwarz0G3fMUgiMhZMNEslsZqYGa64AKDmCrOQ+9/KGhoqR17q9YA5zlsg9bF+B
HFiLRv8sz9P8Rp+vl3vYN1Zf0HW/PZoZpag+fzIZGm/DSplGYOz2d96V3l7sIsWu
gH+VmOlB0zsl906gUfDLCxtt1AOZmwc8ZTRcXtibuQTY+ICS+MBJnVLsr5XaLxAx
6dCU1LF2heCKdBrwCfRNuQ0LUOb+l7JbY4rVOBLfdALuoSVZb/3IyY2kucUc/SlP
0+70FjLRo6A6Ikr/4nDkEGs0eKWrTXN2jKOJGD50UgS8G6APCBk=
=3pMk
-----END PGP SIGNATURE-----

--=-slTvvx2rqWMRRAEEX6lb--

