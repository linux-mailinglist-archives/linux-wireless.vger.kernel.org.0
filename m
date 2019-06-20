Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D874C8A8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfFTHve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 03:51:34 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54556 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725912AbfFTHve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 03:51:34 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hdrr0-0003Im-8G; Thu, 20 Jun 2019 10:51:30 +0300
Message-ID: <86eada55d771732ac0477a008d3c5f0a61570952.camel@coelho.fi>
Subject: pull request: iwlwifi firmware updates 2019-06-20
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>
Date:   Thu, 20 Jun 2019 10:51:28 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-eu0l8m9rPSvhrEhAT86Y"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-eu0l8m9rPSvhrEhAT86Y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some updated firmwares for the 9000 and 22000 series of
devices, and new firmwares for new integrated 22000 series devices.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit acb56f2fae3235195bc99ecb7d09742fb4b65e63=
:

  cavium: Add firmware for CNN55XX crypto driver. (2019-06-18 09:12:52 -040=
0)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2019-06-20

for you to fetch changes up to 90e6845190c2f32bb631f40a9d6c929eb504a82f:

  iwlwifi: add new firmwares for integrated 22000 series (2019-06-20 10:41:=
13 +0300)

----------------------------------------------------------------
iwlwifi firmware updates

* Update version 46 FWs for 9260 and 9000;
* Add version 48 FWs for 22000 series;
* Add version 48 FWs for new integrated 22000 series;

----------------------------------------------------------------
Emmanuel Grumbach (1):
      iwlwifi: udpate -36 firmware for 8000 series

Luca Coelho (4):
      iwlwifi: update Core45 FWs for 22260, 9000 and 9260
      iwlwifi: update FWs for 9000 series to Core45-96
      iwlwifi: update FW for 22000 to Core45-96
      iwlwifi: add new firmwares for integrated 22000 series

 WHENCE                            |  29 +++++++++++++++++++++++++----
 iwlwifi-8000C-36.ucode            | Bin 2486572 -> 2400700 bytes
 iwlwifi-8265-36.ucode             | Bin 2498044 -> 2414296 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1448644 -> 1460788 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1456088 -> 1462324 bytes
 iwlwifi-Qu-b0-hr-b0-48.ucode      | Bin 0 -> 1106208 bytes
 iwlwifi-Qu-b0-jf-b0-48.ucode      | Bin 0 -> 1053156 bytes
 iwlwifi-Qu-c0-hr-b0-48.ucode      | Bin 0 -> 1106228 bytes
 iwlwifi-Qu-c0-jf-b0-48.ucode      | Bin 0 -> 1053176 bytes
 iwlwifi-QuZ-a0-hr-b0-48.ucode     | Bin 0 -> 1105648 bytes
 iwlwifi-QuZ-a0-jf-b0-48.ucode     | Bin 0 -> 1052968 bytes
 iwlwifi-cc-a0-48.ucode            | Bin 0 -> 1096684 bytes
 12 files changed, 25 insertions(+), 4 deletions(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-48.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-48.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-48.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-48.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-48.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-48.ucode
 create mode 100644 iwlwifi-cc-a0-48.ucode

--=-eu0l8m9rPSvhrEhAT86Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl0LOwAACgkQoUecoho8
xfqfchAAh1Dz0pMLWVRgUC5d/U7BAmqRnLCwfoPKxhI/YUEy/dbVIINXIAHJTUB2
EOvN/2yYHakTVoDxjDKPY63y2AOAgb0ZlL5pVoZalCumA+tL+WuRQLLUTciHqC5H
4XFt09N7Fs+73mLAsG2G+PA0uZGGX9c9Qp85ozakQeHquBl9yDHGE3H2rtHcR/jK
qJkXEJLGnEk2ijIKenyznzpP5hyBArEzv1p1ZKjDykHkZFQCeCMa47DxG4JxNhOx
h8Mybzb2Yh7j1/PeBV6CkeRRPjzDiy264Zv+olsjQCiiwYfhbqrpDYqAA4pvsJKF
Em008LaeXjAc0gP3Kos24lPNy/3ro5T5WdwibIFRxbhUVpqJiGEUTCHh6PHMtvF/
9O+dnsuSnEV4F6zSNZ9Qtg9km5X1RHBOZT1cHukNffz//m8jwqZZwR5Y9hJyDKlA
HP+q1f+I6PLMCTRWchiUGDOVRmjK8ESdXtc1QiylnVlq00M+Wzo1dCZcC3GNiZ14
7DJAlEEPWx0aYJwTy1Igx4cT5CZg5hHo49RU4ihPYPCipDzPwkySQpxdlB6Q3/KH
zC46pCc/NJ7YTYcCGWYbvHp//5YIwvLmQZhU/wTKlrwpsggm7xNIYvz0QhU/HpYI
x6uAJZu96Uqiu1SjPWnkUpI2uSZU7X9cxyIRjrfUZkrN+7BjiBY=
=CXvT
-----END PGP SIGNATURE-----

--=-eu0l8m9rPSvhrEhAT86Y--

