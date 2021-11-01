Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E61441C03
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Nov 2021 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhKAOAt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Nov 2021 10:00:49 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:35632 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229826AbhKAOAq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Nov 2021 10:00:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mhXp5-000iIT-Ru; Mon, 01 Nov 2021 15:58:04 +0200
Message-ID: <19391a6dd10076e3a64aff20d68a9a37ac56e794.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com, You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Mon, 01 Nov 2021 15:58:01 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-fqXG1n+632xPSiT2yZO8"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2021-11-01
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-fqXG1n+632xPSiT2yZO8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit b21eb2607f167408b780d1360431a93525e9f229=
:

  amdgpu: update VCN firmware for green sardine (2021-10-28 10:07:10 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2021-11-01

for you to fetch changes up to 4474519a1fd4e7167afae7c5ca2c1b93e17b4d8a:

  iwlwifi: add new FWs from core64-96 release (2021-11-01 15:50:49 +0200)

----------------------------------------------------------------
Update and add iwlwifi firmware binaries for release Core64-96.

----------------------------------------------------------------
Luca Coelho (2):
      iwlwifi: update 9000-family firmwares to core64-96
      iwlwifi: add new FWs from core64-96 release

 WHENCE                            |  21 +++++++++++++++++++--
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1514876 -> 1519264 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1485620 -> 1490096 bytes
 iwlwifi-QuZ-a0-hr-b0-67.ucode     | Bin 0 -> 1347524 bytes
 iwlwifi-cc-a0-67.ucode            | Bin 0 -> 1310488 bytes
 iwlwifi-so-a0-gf-a0-67.ucode      | Bin 0 -> 1524432 bytes
 iwlwifi-so-a0-gf-a0.pnvm          | Bin 41804 -> 41804 bytes
 iwlwifi-so-a0-gf4-a0-67.ucode     | Bin 0 -> 1541932 bytes
 iwlwifi-so-a0-gf4-a0.pnvm         | Bin 0 -> 21576 bytes
 iwlwifi-ty-a0-gf-a0-67.ucode      | Bin 0 -> 1482872 bytes
 iwlwifi-ty-a0-gf-a0.pnvm          | Bin 27480 -> 41612 bytes
 11 files changed, 19 insertions(+), 2 deletions(-)
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-67.ucode
 create mode 100644 iwlwifi-cc-a0-67.ucode
 create mode 100644 iwlwifi-so-a0-gf-a0-67.ucode
 create mode 100644 iwlwifi-so-a0-gf4-a0-67.ucode
 create mode 100644 iwlwifi-so-a0-gf4-a0.pnvm
 create mode 100644 iwlwifi-ty-a0-gf-a0-67.ucode


--=-fqXG1n+632xPSiT2yZO8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmF/8mkACgkQoUecoho8
xfoKmw/9FalbyR8iR3NQbZ/Ou/MBOTpakWdWixe0K89mgKVUaVmScrVBqYs9qS1Q
gPZCRgEdeQPr2qTa/tLN8tOzi+/TkSsY08ak9iXMpPNedpzog0odcRq5KcYSK7Vy
b4TBeu96eRp4K8Yd4r9GCC5W/ytNDNUlXkKSNY5iV1BykrUOePvfgaHvNP+qZJLB
Zng9SezOaPD/iwZQtZBPxIZd8OuJLVsEaU/NCl0b0MihTD5Vzhmk2rhGNnjeAXPD
lUWEMJsbp2SIw41I+K9wg/STu4NyYByK88DKflKD47ngQ/xoecbEw00vejn6YKAv
ounfzeucKq+LHvPXgwEtQSWXpDtSupho5ZECwXYSktzbRRrGQoiEaYjR5qnCj3aE
3QPgKwj/CRmtOiCVT1glRuoE57YYy/gs7N6gG3KWy51Rt+ZMW0180jh8v8UmbM1g
P5/VybvkITR2TJS0ilpgms697C7IPlteIWAQL11Ai9MRcwISg33oNExxcYk7CwTj
ljxWjXcP5BwOx8rC5RlJFtIHdhx6nNmhRTLbYPqd3uKJOgCEZoUpMddOLIyODaVc
ALkV/GP5uPwrWuXXQude1DZQZlIakvn/HyGBAk1jOUxXRhRsX/fjILPeJNYmQos5
0MmkE1LOrguVPBuvPj7NVndK3ZsQZUGaYReclQz/EkvoIeepst0=
=1f9w
-----END PGP SIGNATURE-----

--=-fqXG1n+632xPSiT2yZO8--
