Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71313FC557
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Aug 2021 12:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240816AbhHaJ6r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Aug 2021 05:58:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51384 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239629AbhHaJ6r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Aug 2021 05:58:47 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mL0Wa-0002eK-CP; Tue, 31 Aug 2021 12:57:49 +0300
Message-ID: <99e8d907c34295f3a00e052b2370ea19a29580df.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "ben@decadent.org.uk" <ben@decadent.org.uk>,
        golan.ben.ami@intel.com
Date:   Tue, 31 Aug 2021 12:57:46 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-XXYxUiTjSb9nJ5bD4kmY"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull request: iwlwifi firmware updates 2021-08-31
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-XXYxUiTjSb9nJ5bD4kmY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


This pull request contains a single patch that adds firmware binaries
to support one more device in iwlwifi, So SOCs with Gf radio modules.

Please pull or let me know if there are any issues.

--
Cheers,
Luca.


The following changes since commit 2e271f23ce4787b3598753f743bb75b8a2da3c61=
:

  rtl_bt: Update RTL8852A BT USB firmware to 0xD9A9_127B (2021-08-30 19:27:=
58 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git =
tags/iwlwifi-fw-2021-08-31

for you to fetch changes up to 1418f75c63fbc72de41aba61376ea30d199cd23e:

  iwlwifi: add FW for new So/Gf device type (2021-08-31 12:30:18 +0300)

----------------------------------------------------------------
Add iwlwifi firmwares for so-a0-gf-a0.

----------------------------------------------------------------
Luca Coelho (1):
      iwlwifi: add FW for new So/Gf device type

 WHENCE                       |   5 +++++
 iwlwifi-so-a0-gf-a0-64.ucode | Bin 0 -> 1515812 bytes
 iwlwifi-so-a0-gf-a0.pnvm     | Bin 0 -> 41804 bytes
 3 files changed, 5 insertions(+)
 create mode 100644 iwlwifi-so-a0-gf-a0-64.ucode
 create mode 100644 iwlwifi-so-a0-gf-a0.pnvm


--=-XXYxUiTjSb9nJ5bD4kmY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmEt/RoACgkQoUecoho8
xfoJ3RAArWPD6LivmyWDAnOxPaGSCE8VWtOuypW9fCjfYu0bux5AsyMzig9REGN+
vYV9kJz9wsglATyyAZOg93DtfKFT36hXr8e8Jd1o2CVE4h2JvcNqxfQhqTVZKPjw
UHfGWBx46KlUMGpL3hiTrjrmPAJkB123NnLny9vYdwdy7isg70ZTvLDhvYBvdZ1s
s+Zxvk2V4u76IBuya5kQQM26Ix6yLVxZN30cszE7VYi38KoYZLNhOfkJx6vpdmP2
kL3MN5b26mMYThvr9rQq2RCFumeA8ZnIn97CRC0u/QQJ38Cy4D54Inu7OtSNkngI
axEEBctDZ1n5G2ljkjasFj2E/AkGUclbAVPqydeVzvl8Ge31mP8dr8BhsBU0BHC6
HZ6fkO5Af1gnYSuPn7D9Tc30Rayn8PTPvG+g98w+2gYhwxoVaGjYAPD/kgfk7eun
ZOL7VS+HMHdsZcPtjx0PMy4v/RYquAKw9phrWdNhqw8mHcO1TGrwtrjSspiq6aMV
jCJYAcYnsEHeRwb7I1B76cvTc4GExhldPR2qaGrxLYPZcpZKwK0nkF2lxrxNKNYY
rDJM+5fCp84XlllCgNHy6E+tLN4m+EUJb2FUYwsKjRF6lk+r1LEQCj1PQdS/A04P
aUMnPbINNP5LmqhrwcPcTB5wlWGK7hbONJzhECN+dAc/FBdd6wA=
=3y+H
-----END PGP SIGNATURE-----

--=-XXYxUiTjSb9nJ5bD4kmY--

