Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC85B6EE5F
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 10:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbfGTIDz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 04:03:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59394 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726861AbfGTIDy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 04:03:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hokLL-0000En-PL; Sat, 20 Jul 2019 11:03:50 +0300
Message-ID: <b8246cb77dfc2d1344cd194682001a11a01dbf3a.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi <linuxwifi@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>, dor.shaish@intel.com
Date:   Sat, 20 Jul 2019 11:03:45 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-vh3spvWTBucW87onefQO"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: pull request: iwlwifi firmware updates 2019-07-20
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-vh3spvWTBucW87onefQO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This contains some updated firmwares for all our currently maintained
FW binaries.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit bf13a71b18af229b4c900b321ef1f8443028ded8=
:

  Merge branch 'guc_v33' of git://anongit.freedesktop.org/drm/drm-firmware =
(2019-07-17 09:05:52 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2019-07-20

for you to fetch changes up to cd6cb7bc50aa77d531c4417ffe1237510b71c73e:

  iwlwifi: update -48 FWs for Qu and cc (2019-07-20 10:58:24 +0300)

----------------------------------------------------------------
iwlwifi: update a bunch of FW binaries

----------------------------------------------------------------
Luca Coelho (2):
      iwlwifi: update FWs for 3168, 7265D, 9000, 9260, 8000, 8265 and cc
      iwlwifi: update -48 FWs for Qu and cc

 iwlwifi-3168-29.ucode             | Bin 1036276 -> 1036300 bytes
 iwlwifi-7265D-29.ucode            | Bin 1036432 -> 1036668 bytes
 iwlwifi-8000C-36.ucode            | Bin 2400700 -> 2401356 bytes
 iwlwifi-8265-36.ucode             | Bin 2414296 -> 2414592 bytes
 iwlwifi-9000-pu-b0-jf-b0-46.ucode | Bin 1460788 -> 1467952 bytes
 iwlwifi-9260-th-b0-jf-b0-46.ucode | Bin 1462324 -> 1469012 bytes
 iwlwifi-Qu-b0-hr-b0-48.ucode      | Bin 1106208 -> 1106204 bytes
 iwlwifi-Qu-b0-jf-b0-48.ucode      | Bin 1053156 -> 1052772 bytes
 iwlwifi-Qu-c0-hr-b0-48.ucode      | Bin 1106228 -> 1106224 bytes
 iwlwifi-Qu-c0-jf-b0-48.ucode      | Bin 1053176 -> 1052792 bytes
 iwlwifi-QuZ-a0-hr-b0-48.ucode     | Bin 1105648 -> 1105644 bytes
 iwlwifi-QuZ-a0-jf-b0-48.ucode     | Bin 1052968 -> 1052584 bytes
 iwlwifi-cc-a0-46.ucode            | Bin 1044072 -> 1044452 bytes
 iwlwifi-cc-a0-48.ucode            | Bin 1096684 -> 1096680 bytes
 14 files changed, 0 insertions(+), 0 deletions(-)

--=-vh3spvWTBucW87onefQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl0yyuEACgkQoUecoho8
xfrt0BAAgGlnmVT/OAGKZz3FLI45stmjqwCoR2nPbY9OJbhPYPrG0pob953SwC+o
wmbf6W+6jatY7rGEjn3hknAec7ISNRFFPzqwqkWtb6nkqBIxqMyfUReP8n2UPMki
GQ0kqeI99AFIvJUT4+SO67LUxrJQT9m+bTrSEl/bgn4S/hrxGPLoIXDeB5horqXM
mimGybyP69A89X+O86hC2lCbYU5NY10KhoT6aVQQU7/PB6bo58cZPQyHEYK1jLty
wS/hvrsoEHt7j5SfseTM5x1KbkSijSsoTMXcWCW44rKzhGQ1zIMa57rqy49/rwI/
gGElvLUcj4Rpc6I3zWzm56PuRe0vGO0VB5ixPvLrHHXJVlkKcoqdciXMWS1nvrdp
1sq2hsffezASNfaXNeKEXuZ4l7tyG7McDt+JpC7bhSSZmHGF1lM9X2fKltOl19za
wzOeZwjwoD8p79dD5d6jIaibZDMEgoLXCTGHH+5kq5M2FSwF03TqvHkPv5h7w0lW
lHm5eNv/3pG7eJVIynQMytVt510z9m3i79CkF/IIb5JVLVidR17apM6AqUyxMfkm
Y/J+Ji3B33PqxMkZJralp+HSZkFvFMD9362NXKp/Mre4eSr/UzI9bT03wiG5HUdm
r5VYjU0TQ1uRMJT5WkQ6+Q9p3/3o48qV13zF92OjyBlqmAR5r0U=
=Ppt7
-----END PGP SIGNATURE-----

--=-vh3spvWTBucW87onefQO--

