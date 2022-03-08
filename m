Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E114D106F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Mar 2022 07:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiCHGoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Mar 2022 01:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245049AbiCHGoX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Mar 2022 01:44:23 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634671DA7D
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 22:43:26 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nRTZ4-000Sqr-1x;
        Tue, 08 Mar 2022 08:43:23 +0200
Message-ID: <45c8a31b79f538425f9524b0d65c002e1e24fc16.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com,
        You-Sheng Yang <vicamo.yang@canonical.com>, luca@coelho.fi
Date:   Tue, 08 Mar 2022 08:43:21 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-na8/cI+Rd8DeUMS0vFJ5"
User-Agent: Evolution 3.43.2-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2022-03-03-v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-na8/cI+Rd8DeUMS0vFJ5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some new and updated firmwares for all our currently
maintained FW binaries.

In v2 I added three missing binaries that I had forgotten to commit.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit ee0667aa201e7d725ec87b1e4cf08de1d748d64f=
:

  amdgpu: update raven2 VCN firmware (2022-02-28 09:44:17 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2022-03-03-v2

for you to fetch changes up to 8f9285cca830cb709439ee2cf14d0519d155983b:

  iwlwifi: add new FWs from core68-60 release (2022-03-08 08:39:39 +0200)

----------------------------------------------------------------
Update and add iwlwifi firmware binaries for release Core68-60

----------------------------------------------------------------
Luca Coelho (2):
      iwlwifi: update 9000-family firmwares to core68-60
      iwlwifi: add new FWs from core68-60 release

 WHENCE                            |  40 ++++++++++++++++++++++++++++++++++=
++++--
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1519544 -> 1520208 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1490376 -> 1491056 bytes
 iwlwifi-Qu-b0-hr-b0-71.ucode      | Bin 0 -> 1364312 bytes
 iwlwifi-Qu-b0-jf-b0-71.ucode      | Bin 0 -> 1285192 bytes
 iwlwifi-Qu-c0-hr-b0-71.ucode      | Bin 0 -> 1364328 bytes
 iwlwifi-Qu-c0-jf-b0-71.ucode      | Bin 0 -> 1285208 bytes
 iwlwifi-QuZ-a0-hr-b0-71.ucode     | Bin 0 -> 1364308 bytes
 iwlwifi-QuZ-a0-jf-b0-71.ucode     | Bin 0 -> 1285188 bytes
 iwlwifi-cc-a0-71.ucode            | Bin 0 -> 1322288 bytes
 iwlwifi-so-a0-gf-a0-71.ucode      | Bin 0 -> 1550124 bytes
 iwlwifi-so-a0-gf-a0.pnvm          | Bin 41808 -> 41808 bytes
 iwlwifi-so-a0-gf4-a0-71.ucode     | Bin 0 -> 1566352 bytes
 iwlwifi-so-a0-gf4-a0.pnvm         | Bin 21576 -> 28064 bytes
 iwlwifi-so-a0-hr-b0-71.ucode      | Bin 0 -> 1456960 bytes
 iwlwifi-so-a0-jf-b0-71.ucode      | Bin 0 -> 1400056 bytes
 iwlwifi-ty-a0-gf-a0-71.ucode      | Bin 0 -> 1494024 bytes
 iwlwifi-ty-a0-gf-a0.pnvm          | Bin 41588 -> 41588 bytes
 18 files changed, 38 insertions(+), 2 deletions(-)
 create mode 100644 iwlwifi-Qu-b0-hr-b0-71.ucode
 create mode 100644 iwlwifi-Qu-b0-jf-b0-71.ucode
 create mode 100644 iwlwifi-Qu-c0-hr-b0-71.ucode
 create mode 100644 iwlwifi-Qu-c0-jf-b0-71.ucode
 create mode 100644 iwlwifi-QuZ-a0-hr-b0-71.ucode
 create mode 100644 iwlwifi-QuZ-a0-jf-b0-71.ucode
 create mode 100644 iwlwifi-cc-a0-71.ucode
 create mode 100644 iwlwifi-so-a0-gf-a0-71.ucode
 create mode 100644 iwlwifi-so-a0-gf4-a0-71.ucode
 create mode 100644 iwlwifi-so-a0-hr-b0-71.ucode
 create mode 100644 iwlwifi-so-a0-jf-b0-71.ucode
 create mode 100644 iwlwifi-ty-a0-gf-a0-71.ucode


--=-na8/cI+Rd8DeUMS0vFJ5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmIm+wkACgkQoUecoho8
xfplmBAArPJM6ePM1BFMib4oA/2cWyP8HSoQwlv8l2qKJW8q4rbA+wjCrr6cD1C0
+ox1qMZZK6L1rLNMuL+xqRUSSUmIv+4AFKTkW5hjtu2a61GhHnLrSv4fSlhxtKe4
GaEOYgmJ8sKyoNx9sB6qm3yDNSo9cd2MZAMYKZYT7TKxzBAr+lUxcfaFC831aeDt
bsBnkRSHd9h9OeKrVvL3eZxyfbPQw8yNW9kx3ERiF63CM06Ga0jdaWDrg8EYRt/b
4DyT4aL4yL8WHyhD+vz2tWR1DUOrmGBL0byTcn9Nxg4bUJ4EaZ3CGdNV0YVA+zpL
4dERjm5vP3awEsw+pC+W1Hk8AkU60tsdAomt79VItp8JgqHvmQu6FehFaagN9TNd
LuGkXLoan2g76DWqW2wdr1KnP41z9yFdWam9Q78XL+w21YDyIZtIhdB2KpCcWKaT
yXX/ltwJeu/zDkdT8f1Cw3VeaS+CphtaQEyp4ob9+krfFvnWq5LB6llnKwC9PuoF
QhL03pXJcmawQkYkI4oS8vFfd6ySltAp3TBwIR7a2PsX5lywN1Q0/o1hN+/sJn+F
uxNDseQ4tdzU4YNox96kxPvzpBd9p6KtNlhvV1vr5tlI16mTDAZgouN88YntHnIb
1sHOTLtql/ZtqLtB/TY6bkffutdPIiq75ZNKIs60HBrbfCL8qxM=
=Fg0s
-----END PGP SIGNATURE-----

--=-na8/cI+Rd8DeUMS0vFJ5--
