Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 907649A6D2
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 06:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391741AbfHWEpN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 00:45:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:38210 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389942AbfHWEpN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 00:45:13 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i11Rk-0003if-4g; Fri, 23 Aug 2019 07:45:08 +0300
Message-ID: <2a5e239858780618fa248bf825e10e3958c56bc9.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>, dor.shaish@intel.com
Date:   Fri, 23 Aug 2019 07:45:06 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Q+3k9GdluOZWOZM3/X5K"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: pull request: iwlwifi firmware updates 2019-08-23
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-Q+3k9GdluOZWOZM3/X5K
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some updated firmwares for all our currently maintained
FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit c0fb3d9862477e31717e04e008debf6328b8980a=
:

  check_whence: Add copy-firmware.sh to the list of ignored files (2019-08-=
21 08:03:43 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2019-08-23

for you to fetch changes up to 40e4162adfc91390f6fbbd8269f9439832af1dde:

  iwlwifi: update FWs to core45-152 release (2019-08-23 07:35:14 +0300)

----------------------------------------------------------------
Update iwlwifi firmwares to Core45-152

----------------------------------------------------------------
Luca Coelho (1):
      iwlwifi: update FWs to core45-152 release

 WHENCE                            |  22 +++++++++++-----------
 iwlwifi-8000C-36.ucode            | Bin 2401356 -> 2401356 bytes
 iwlwifi-8265-36.ucode             | Bin 2414592 -> 2414592 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1467952 -> 1462068 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1469012 -> 1463820 bytes
 iwlwifi-Qu-b0-hr-b0-48.ucode      | Bin 1106204 -> 1106228 bytes
 iwlwifi-Qu-b0-jf-b0-48.ucode      | Bin 1052772 -> 1052796 bytes
 iwlwifi-Qu-c0-hr-b0-48.ucode      | Bin 1106224 -> 1106248 bytes
 iwlwifi-Qu-c0-jf-b0-48.ucode      | Bin 1052792 -> 1052816 bytes
 iwlwifi-QuZ-a0-hr-b0-48.ucode     | Bin 1105644 -> 1105668 bytes
 iwlwifi-QuZ-a0-jf-b0-48.ucode     | Bin 1052584 -> 1052608 bytes
 iwlwifi-cc-a0-48.ucode            | Bin 1096680 -> 1096704 bytes
 12 files changed, 11 insertions(+), 11 deletions(-)

--=-Q+3k9GdluOZWOZM3/X5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl1fb1IACgkQoUecoho8
xfrbbQ/+ONPtXLJnJdoZ5u3wrgdekBrAKP9litckZTfWRUWXVtv6SmahhBNYnVIV
02fXXJ3FGSyvQBX65flZ+JbKgmxdN3800S4EY8VEIRgzSnKEYRS4r94KwaqXm+FT
ikcp5Sb2ChkxUm1zZ/3E1o+VBiOpz5KEmJPFrfOMP3+b9Lz819Y3Sy9z/eWCV+6v
m84KYdpOoC5p/TgpOGTvtftsLK1T4qXfSVZ5PzHO4YV1ijLkSi7EfHDBze4E/4Te
cslg7zMcRnMjLjMjLvTzCvl8JJsW8PESqKQpvc26QtO41OvR5fKJ2Ws2+nDNBBtR
prctcNoumkYCegCfQ562S2lCRg9FReyaLjqDGdmWomDAGYtIiS4scOPfhJZNu5LE
J3gVTRPpxFN0R/jqrGsHIDDu0NIR+a2BX4fsoa7/PL08T9HSrrTM6hnCItE2q8ls
75UwPXqgzapHJU3KSnY5BTXEpWCPNee837WUS0YB9lYe+8cbHwMv/hj/Y1/NNA0f
GnZ/M1kJWy6OjjcIULpkoDKrfe5R0mHdDJlb/M/7V7NHojLDRWXQkpoMQ6NiZrcs
lDyWkXr8b0I5Z2KwvlGPkzp7zIPO9dX64nBNFqYxfF76OcTdA4xZhGSxhGM/368O
wbHKilP/m+2nkzWNKqdFy5q9TAdRW58cor53/loaObVHRFyh+iM=
=h9SK
-----END PGP SIGNATURE-----

--=-Q+3k9GdluOZWOZM3/X5K--

