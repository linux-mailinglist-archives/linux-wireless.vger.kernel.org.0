Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71748A961
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 09:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbiAKIaq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 03:30:46 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:52256 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234988AbiAKIaq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 03:30:46 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1n7CYE-001aBz-50; Tue, 11 Jan 2022 10:30:43 +0200
Message-ID: <39ee0e148eb24523830b766da9c637c41ad3673c.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com,
        You-Sheng Yang <vicamo.yang@canonical.com>, luca@coelho.fi
Date:   Tue, 11 Jan 2022 10:30:39 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-dINLJ9GLSlSS2le+06Cu"
User-Agent: Evolution 3.42.2-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2022-01-11
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-dINLJ9GLSlSS2le+06Cu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

This adds firmwares from an older stable branch, because this version
is what is support in v5.15 LTS.  Sorry for not including this in my
previous pull-request, but only today I realized they were missing.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 13fc9c285a399932f5a6205b827cf690b4a3c29b=
:

  Merge tag 'iwlwifi-fw-2022-01-10-v2' of git://git.kernel.org/pub/scm/linu=
x/kernel/git/iwlwifi/linux-firmware into main (2022-01-10 13:20:21 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2022-01-11

for you to fetch changes up to 76e8373e07753ebe406f314894f6eae9f8493dfe:

  iwlwifi: add new FWs from core63-136 release (2022-01-11 10:23:38 +0200)

----------------------------------------------------------------
Update and add iwlwifi firmware binaries for release Core63-136

----------------------------------------------------------------
Luca Coelho (1):
      iwlwifi: add new FWs from core63-136 release

 WHENCE                        |  23 ++++++++++++++++++++++-
 iwlwifi-Qu-b0-hr-b0-66.ucode  | Bin 0 -> 1344220 bytes
 iwlwifi-Qu-b0-jf-b0-66.ucode  | Bin 0 -> 1262312 bytes
 iwlwifi-Qu-c0-hr-b0-66.ucode  | Bin 0 -> 1344236 bytes
 iwlwifi-Qu-c0-jf-b0-66.ucode  | Bin 0 -> 1262328 bytes
 iwlwifi-QuZ-a0-hr-b0-66.ucode | Bin 0 -> 1344216 bytes
 iwlwifi-QuZ-a0-jf-b0-66.ucode | Bin 0 -> 1262244 bytes
 iwlwifi-cc-a0-66.ucode        | Bin 0 -> 1307180 bytes
 iwlwifi-ty-a0-gf-a0-66.ucode  | Bin 1477864 -> 1481960 bytes
 9 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-66.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-66.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-66.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-66.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-66.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-66.ucode
 create mode 100644 iwlwifi-cc-a0-66.ucode


--=-dINLJ9GLSlSS2le+06Cu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmHdQC8ACgkQoUecoho8
xfp++BAAtKtg9DelR3nkQdk3PZvqf9JNXPUFxrx24qVLbelcDwsUgS+vPWVxyoHS
ncFmI9YjzZYeKAb6tghMU0WBIEjfne/cjiz3cn0BtWurOgmxZOTHlukuz8UBxSHX
r8v58vVp32CCVJrvPSHE526uh11va3EEV44F9SoD0ij0WulFKa8c5UYVmDz2BtOq
KPIDuQYZpGknwrt6fxbL1OTdjX9OpKwNSYX+mNdfcB6roDyu/TpBL6aKM+kPu8V7
EZEn1IEnGMP4VOoLc/b9M0v0CfZDEgZmaWNALCFuLp15xROm0pL1x5maM5TIGEvn
+kn48SVxiC2L5vp0BP+8W6PqrzszpGQ1Anbvx10OVhNUTM1D/P7tThS3IrLE4+KX
d8MdsRaMv9Eu5dLX+3BV+ffSXv9rMxRWNrflM8V1v9z4Cvt25WCYusjRhjPajC47
RAGIAo5ofzQ62DMFn1edlZvqtGlcT3M0bEIpP7W4zlLRmmQaEyD+HN/OL7VmMYAo
r3XNh716I/Xr7B9VE8ExI4WuclUFwDCDxNO7y/lZkt7XRkqxmt2b8+znMQNtHyIt
jzUdpBXZxRjSWu7cnfNRfn9OxMjGVJgf85CO+9Sw40gO3c2cTJ9AOxeD1pNVYWbD
pYLFiem2gMdFVnD+vhbvTgIDmuLcJmFDRyMNDtUoiAKIeG0vONY=
=AX1R
-----END PGP SIGNATURE-----

--=-dINLJ9GLSlSS2le+06Cu--
