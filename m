Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA231D90A9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 May 2020 09:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgESHGn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 May 2020 03:06:43 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33372 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725864AbgESHGn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 May 2020 03:06:43 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jawKm-000dPp-Gh; Tue, 19 May 2020 10:06:41 +0300
Message-ID: <77eee10bfa6a63c34085aae12be28943146190a2.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Tue, 19 May 2020 10:06:37 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ZT/+1IH4D7y/EkoWgdo3"
User-Agent: Evolution 3.36.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull request: iwlwifi firmware updates 2020-05-19
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-ZT/+1IH4D7y/EkoWgdo3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit f8d32e4cc99bcd985dd64892392c42b52c941369=
:

  rtw88: update firmware information and README (2020-05-17 14:50:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2020-05-19

for you to fetch changes up to 5ee1c7d65c26b90b796362ac1b5715435e2a1384:

  iwlwifi: update and add new FWs from core50-70 and core52-81 releases (20=
20-05-19 09:36:28 +0300)

----------------------------------------------------------------
Update iwlwifi firmwares to Core50-70 and Core52-81

----------------------------------------------------------------
Luca Coelho (3):
      iwlwifi: update 8265 FW
      iwlwifi: update FWs to core47-142 release
      iwlwifi: update and add new FWs from core50-70 and core52-81 releases

 WHENCE                            |  75 ++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++------
 iwlwifi-3168-29.ucode             | Bin 1036300 -> 1036288 bytes
 iwlwifi-7265D-29.ucode            | Bin 1036668 -> 1036656 bytes
 iwlwifi-8000C-36.ucode            | Bin 2401356 -> 2401100 bytes
 iwlwifi-8265-36.ucode             | Bin 2414592 -> 2409984 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1462068 -> 1481104 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1463820 -> 1470272 bytes
 iwlwifi-Qu-b0-hr-b0-50.ucode      | Bin 0 -> 1103952 bytes
 iwlwifi-Qu-b0-hr-b0-53.ucode      | Bin 0 -> 1209628 bytes
 iwlwifi-Qu-b0-hr-b0-55.ucode      | Bin 0 -> 1223144 bytes
 iwlwifi-Qu-b0-jf-b0-50.ucode      | Bin 0 -> 1053004 bytes
 iwlwifi-Qu-b0-jf-b0-53.ucode      | Bin 0 -> 1147104 bytes
 iwlwifi-Qu-b0-jf-b0-55.ucode      | Bin 0 -> 1163672 bytes
 iwlwifi-Qu-c0-hr-b0-50.ucode      | Bin 0 -> 1103968 bytes
 iwlwifi-Qu-c0-hr-b0-53.ucode      | Bin 0 -> 1209644 bytes
 iwlwifi-Qu-c0-hr-b0-55.ucode      | Bin 0 -> 1223160 bytes
 iwlwifi-Qu-c0-jf-b0-50.ucode      | Bin 0 -> 1053020 bytes
 iwlwifi-Qu-c0-jf-b0-53.ucode      | Bin 0 -> 1147120 bytes
 iwlwifi-Qu-c0-jf-b0-55.ucode      | Bin 0 -> 1163688 bytes
 iwlwifi-QuZ-a0-hr-b0-50.ucode     | Bin 0 -> 1103952 bytes
 iwlwifi-QuZ-a0-hr-b0-53.ucode     | Bin 0 -> 1209628 bytes
 iwlwifi-QuZ-a0-hr-b0-55.ucode     | Bin 0 -> 1223140 bytes
 iwlwifi-QuZ-a0-jf-b0-50.ucode     | Bin 0 -> 1053004 bytes
 iwlwifi-QuZ-a0-jf-b0-53.ucode     | Bin 0 -> 1147104 bytes
 iwlwifi-QuZ-a0-jf-b0-55.ucode     | Bin 0 -> 1163668 bytes
 iwlwifi-cc-a0-50.ucode            | Bin 0 -> 1101228 bytes
 iwlwifi-cc-a0-53.ucode            | Bin 0 -> 1205332 bytes
 iwlwifi-cc-a0-55.ucode            | Bin 0 -> 1219356 bytes
 28 files changed, 69 insertions(+), 6 deletions(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-50.ucode
 create mode 100644 iwlwifi-Qu-b0-hr-b0-53.ucode
 create mode 100644 iwlwifi-Qu-b0-hr-b0-55.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-50.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-53.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-55.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-50.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-53.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-55.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-50.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-53.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-55.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-50.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-53.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-55.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-50.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-53.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-55.ucode
 create mode 100644 iwlwifi-cc-a0-50.ucode
 create mode 100644 iwlwifi-cc-a0-53.ucode
 create mode 100644 iwlwifi-cc-a0-55.ucode

--=-ZT/+1IH4D7y/EkoWgdo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl7DhX0ACgkQoUecoho8
xfoqtw//db9YfX7d3q4Qowj7N/mEg1dR0c5hfNHxP9AFdvgr2ZRms9B5ZSvGCjBV
bkO8ya6YoHwbQd8GxM9TopRAgGcLU32shp05KJyaijfRsyIsiNHU9WTG/plDtxdT
eyN+k/d7+ckHk9xhhJb+egdsWeagYSTgBW9bGWScReKEpdx2Vbu/n3U1kqedWpZD
bhxV5Ct9BSTxlm3+1+5bXtGXVEH2rv0QIB6JnwNQoVljTllWus5JpRGpbAb28ulR
rnUKkYmZ/uiFFoXTNHkGW3g3CSMMBdo4P7zVmYmUt9ptJqCsi8WBZQxsXUoCzI1Q
33D5KyNkeNVqPy5lqgcPOl1ivVDNGzo8bq4Ff9QBaQI43FWJWr5UNRI1+1wYhOFx
70RATduQ7TgbiMCkvsP2HpQcRnefhF+UxoQgf5XcfJvTEQ3BgUKJOxFZIoeR1yVP
4CnOjRe7p7ScqzM4Sp35dIdV+W6rgXlDkL3DDrIo537tcY9NmWhjA0NyNyF5l2ge
SFKnXXF3wyTlzIavOAgdh6x9QT5y20gSOrzzCfQty+Ggo+X9U7F6mqgl7N+4mt2G
1zDUS88j6j9QO7R9c+TRpBX+yx8wql/JdEF1bidnxKb0+J0ohiz7OEiaTGIfW2FU
4up8IWHefOfMYPQVcgoTwb0RTgIOzHCfpRZuIbTCVtEj249570U=
=jL/v
-----END PGP SIGNATURE-----

--=-ZT/+1IH4D7y/EkoWgdo3--

