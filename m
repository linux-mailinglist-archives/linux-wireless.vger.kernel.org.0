Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A730E40D9E2
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 14:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239303AbhIPM0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 08:26:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33736 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239473AbhIPM0q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 08:26:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mQqS4-000F6O-RK; Thu, 16 Sep 2021 15:25:17 +0300
Message-ID: <8ddba225f68405b5d4ed8b6cd9dcd05a03f532e4.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com, You-Sheng Yang <vicamo.yang@canonical.com>
Date:   Thu, 16 Sep 2021 15:25:15 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-XvG4qb72zJkmqPpFD9ur"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2021-09-14 v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-XvG4qb72zJkmqPpFD9ur
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I had typos in the WHENCE file in my previous pull request.  I have
fixed that and here's v2.

This pull request contains a single patch that adds firmware binaries
to support one more device family in iwlwifi, namely So SOCs with Gf,
Hr and Jf radio modules.  This replaces the previous patch that we
reverted.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 198ac651f46b7d4efd660a1f5ab4f93ca422947d=
:

  amdgpu: add initial firmware for Yellow Carp (2021-09-15 09:03:35 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2021-09-14-v2

for you to fetch changes up to 0324161cb0723fccf5d7659114851cf8c1b1cda6:

  iwlwifi: add FWs for new So device types with multiple RF modules (2021-0=
9-16 15:19:45 +0300)

----------------------------------------------------------------
Add iwlwifi firmware binaries for So with Gf, Hr and Jf.

----------------------------------------------------------------
Luca Coelho (1):
      iwlwifi: add FWs for new So device types with multiple RF modules

 WHENCE                       |  11 +++++++++++
 iwlwifi-so-a0-gf-a0-64.ucode | Bin 0 -> 1515812 bytes
 iwlwifi-so-a0-gf-a0.pnvm     | Bin 0 -> 41804 bytes
 iwlwifi-so-a0-hr-b0-64.ucode | Bin 0 -> 1427384 bytes
 iwlwifi-so-a0-jf-b0-64.ucode | Bin 0 -> 1365628 bytes
 5 files changed, 11 insertions(+)
 create mode 100644 iwlwifi-so-a0-gf-a0-64.ucode
 create mode 100644 iwlwifi-so-a0-gf-a0.pnvm
 create mode 100644 iwlwifi-so-a0-hr-b0-64.ucode
 create mode 100644 iwlwifi-so-a0-jf-b0-64.ucode


--=-XvG4qb72zJkmqPpFD9ur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmFDN6sACgkQoUecoho8
xfqd5BAAupkyteviyDX5zl8MKpbpKVICL1aV2AocLWjzJrolXEuluRj4pBv1Abaq
I1/8xoNoqsyTeGOE+GE6qqspBvF6+kNbKsrfAhoCUzFVbWL8EpCkfs33Wgpd7Se0
J3GrAtTQijm+1VWX6V1Mbaf0HE9PCcxkoiJh24nZd5F8Qit0G9qqEji8uunNe2e9
1p/fvN2VMpHYgqW4zN9fLc1oI2bQtL/xKwin8vCNV5TwOubzLcA5TKIbTeXvSuSo
cDfuZpVaJa2r9EgHH2/3cjY5yid0KdSfH3gUWiid7wS8CM3KTx7+EIldkrIGqB72
WcQY96RC9/sSRT8VlLmVmOtMKnlqmh6X1H3CHVKLPWP+RGB0VJTyPqbvhKFVbNA1
gL4wP40/ucfTa1+rij4K0QMNm6Hbtc9dYCucJgV7eH6MZUVOS+kdAdXpq3ZQ5vvY
U6H/dsEsbCRw4+NWvgnfLHfgWJnfXd/3ehgHhbseBwh/N/RhQBOzOd6dO/pvpeQv
YU6C6xPJITaWRWV3KZGrZ5DubUlY3RoEHrldTP/Za0oecWCUQ2Y/1M/2sx8CzByr
mDbcE9mliNSbm3FNWrmnkACsfvRpTbKvSLFYD4+Dvi2xRc5POSqTGyJq2vVPutHb
my6OaqKBHl4mooP+EJaceT/EyxvLDWYDxATkmKsfz4ZfOUD24EM=
=UpBU
-----END PGP SIGNATURE-----

--=-XvG4qb72zJkmqPpFD9ur--

