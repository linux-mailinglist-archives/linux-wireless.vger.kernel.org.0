Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1837B754
	for <lists+linux-wireless@lfdr.de>; Wed, 12 May 2021 10:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhELIBx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 May 2021 04:01:53 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46012 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229994AbhELIBw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 May 2021 04:01:52 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lgjnJ-0013j7-2P; Wed, 12 May 2021 11:00:39 +0300
Message-ID: <c4d8c2f040b368225b72a91e74ee282d9ceab4d5.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>, tmb@tmb.nu
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Wed, 12 May 2021 11:00:35 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ghLC+rynZWXdwNcnb0BC"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: pull request: iwlwifi firmware updates 2021-05-12
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-ghLC+rynZWXdwNcnb0BC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 7685cf49917b281b8799ba822e97595eeecb26b5=
:

  nvidia: Update Tegra194 XUSB firmware to v60.09 (2021-05-11 07:48:10 -040=
0)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2021-05-12

for you to fetch changes up to 56115b259807e0417f30ef84bc6d2093572e6901:

  iwlwifi: update 8000 family firmwares (2021-05-12 10:53:38 +0300)

----------------------------------------------------------------
Update iwllwifi firmwaresto Core60-51

----------------------------------------------------------------
Luca Coelho (3):
      iwlwifi: add new FWs from core60-51 release
      iwlwifi: update 9000-family firmwares to core60-51
      iwlwifi: update 8000 family firmwares

 WHENCE                            |  32 ++++++++++++++++++++++++++++----
 iwlwifi-8000C-36.ucode            | Bin 2428004 -> 2428004 bytes
 iwlwifi-8265-36.ucode             | Bin 2436632 -> 2436632 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1514240 -> 1514876 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1485556 -> 1485620 bytes
 iwlwifi-Qu-b0-hr-b0-63.ucode      | Bin 0 -> 1334856 bytes
 iwlwifi-Qu-b0-jf-b0-63.ucode      | Bin 0 -> 1252748 bytes
 iwlwifi-Qu-c0-hr-b0-63.ucode      | Bin 0 -> 1334872 bytes
 iwlwifi-Qu-c0-jf-b0-63.ucode      | Bin 0 -> 1252764 bytes
 iwlwifi-QuZ-a0-hr-b0-63.ucode     | Bin 0 -> 1334804 bytes
 iwlwifi-QuZ-a0-jf-b0-63.ucode     | Bin 0 -> 1252744 bytes
 iwlwifi-cc-a0-63.ucode            | Bin 0 -> 1298688 bytes
 iwlwifi-ty-a0-gf-a0-63.ucode      | Bin 0 -> 1460012 bytes
 iwlwifi-ty-a0-gf-a0.pnvm          | Bin 27456 -> 27456 bytes
 14 files changed, 28 insertions(+), 4 deletions(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-63.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-63.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-63.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-63.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-63.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-63.ucode
 create mode 100644 iwlwifi-cc-a0-63.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0-63.ucode


--=-ghLC+rynZWXdwNcnb0BC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmCbiyMACgkQoUecoho8
xfqtpxAAlsiKcQ3GBDuB5L1JXrNbtdjuo1IxGzSbqE0vCv89VZcxa2uucd+vf913
/vl1caCeniCdO7Q24YjAb9IpCgC3XlpOPdPba96X2FWWliVU3s+o/zqFX4N8N8Hh
JdXsAawhiyd3/s5WilUIOsEmyYA/oYVN7OHeFMDEoj1Y8l8J5UedrSMoxo+PslfN
gg3Gr/B7RKznhOX9SQmTQXP86iOxHWPngFsvCWS73OEhpw2BFkSv//8LflRvKQDB
W4yTs0I4dpwb9oDqztAxz7NcKYQQKeTShAl5C1GyAnHKjoRfp4zmTjO3MVLZfFaF
B6IVGFfG4ltTI2+t4CIqBfD1hcN7mfVmih6NLlWRdILnuXMHlKDF2/snm3/OiTJM
6AJxfqw3s5eKLJzo9T0HcBiwqrCWnLEqso6FUfGu1LMvn86gdSmKRj3Km94ZeEvj
8CEE4b90ERHFUjB9u1WwKwEAswwElaI1v4WmjROMfJsf7qXtfeR9X04lKpsQ7J2P
Lf7yEv3q9IiPcZHnQ+7z/bI45aYgehVnzHWC+pDz8MQNglmYNU8XwEjS90bLVQaQ
DnwThvAizvAYMXLWW5k/Fbe9vPvIeGJWElsNPUv9qQiC4wvFAmaT9vpSVr9s98mZ
p6QeOTJhvno1Gv55mngUBeFj9LOZhG9DkMsSNNNj/PSwJTqfrD8=
=K7/m
-----END PGP SIGNATURE-----

--=-ghLC+rynZWXdwNcnb0BC--

