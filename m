Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9203FEBF9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Sep 2021 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241698AbhIBKSJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Sep 2021 06:18:09 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52732 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241529AbhIBKSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Sep 2021 06:18:08 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mLjmL-0003qo-Lf; Thu, 02 Sep 2021 13:17:06 +0300
Message-ID: <515534e0ec166fa55f974a44caad0ef6737d169e.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Thu, 02 Sep 2021 13:17:04 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-D7N/v9y228MDmzxVjG0J"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2021-09-02
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-D7N/v9y228MDmzxVjG0J
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


We accidentally release a couple of binaries that were untested and not
ready for public release.  This pull request reverts the patch that
added them so they are not mistakenly used.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 6f5aada830d69e9e086e0ce84a187050ccf0706e=
:

  linux-firmware: update frimware for mediatek bluetooth chip (MT7921) (202=
1-09-01 09:43:05 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2021-09-02

for you to fetch changes up to 359ab775cf55e634abadc99a89eb1e2eabae2d1b:

  Revert "iwlwifi: add FW for new So/Gf device type" (2021-09-02 13:11:39 +=
0300)

----------------------------------------------------------------
Revert accidentally released untested binaries

----------------------------------------------------------------
Luca Coelho (1):
      Revert "iwlwifi: add FW for new So/Gf device type"

 WHENCE                       |   5 -----
 iwlwifi-so-a0-gf-a0-64.ucode | Bin 1515812 -> 0 bytes
 iwlwifi-so-a0-gf-a0.pnvm     | Bin 41804 -> 0 bytes
 3 files changed, 5 deletions(-)
 delete mode 100644 iwlwifi-so-a0-gf-a0-64.ucode
 delete mode 100644 iwlwifi-so-a0-gf-a0.pnvm


--=-D7N/v9y228MDmzxVjG0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmEwpKAACgkQoUecoho8
xfr6uhAAg+S7cK5ApyQCj4U7iBzfM01NyJkyrvXAjxeQrRmVPUfijTYROggGh7LP
gdGF5Oatbw7B+8GFEGl5j3VQYkaLoCa3UD/64PI5+7y5Y0AvuQvu3Co3bqGqK/iG
K33NvOZL7Q+pkjdOlMOj5IvWpeBUz4NdFeyCINS5LnRqV0NfIdGjzsmZ51huCZXc
hw4HJTaj6KFH42I8SiwaRJ3Wwmh7j9gxrmk1ZCm2dJXkkmhocxhYsSwqOrAo2RKF
qO3jTKGzbSNU2ijkoo1L2Lx93vqkzRGkOCDZhWRLbWnA6fA7uVYj4PX6A8FTCEia
1fmOLOTZIN7LfzC1VO/H3UL3By1nXULtZMEUqsn3NMpdeYYP+t52BXtnax0l6F0+
6BUbTCyhli58rOkni7H/Wyni60dtYzfcAY97a42XXk2c7nZmPxtuafaCxBzQ3iIR
wxKsmLz1qxVJb909DLVllcMMCsp/dnCwQizCy7TR2ZQoxrLeIvzVnt07CjEh6/oW
UcIwug/RztSkdTCIuSuBdYd5UmRUzNsDNGSKoVxPMHfrvk/g1yRh/f2Bs8T/YUpA
BzLcj+WVp8YOGykpo1961VHa0/greK+Dl424/AR2C7bctpXNhCI+NaCip0ZAMDRK
lGGibftvGwva2gtX3GeDcsHBLvJxovXS6s6JqxzL25Ux8ZWHxow=
=qN8i
-----END PGP SIGNATURE-----

--=-D7N/v9y228MDmzxVjG0J--

