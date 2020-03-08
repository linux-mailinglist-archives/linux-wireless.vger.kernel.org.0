Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37B617D2AF
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 09:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCHIjF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 04:39:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:32892 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725306AbgCHIjE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 04:39:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jArSd-0006mi-Ds; Sun, 08 Mar 2020 10:39:02 +0200
Message-ID: <1ba480ddb338627ef453e32d03a238ffcdff6068.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Sun, 08 Mar 2020 10:38:57 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-f2sNoMlo2IBWg1LTEQSG"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-fixes for v5.6 2020-03-08
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-f2sNoMlo2IBWg1LTEQSG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of fixes intended for v5.6.  This includes the
patch series I sent a couple of days ago.  More details about the
contents in the tag description.

I pushed this to my pending branch but didn't get any results from
kbuildbot yet.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit b102f0c522cf668c8382c56a4f771b37d011cda2=
:

  mt76: fix array overflow on receiving too many fragments for a packet (20=
20-03-03 17:30:25 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git t=
ags/iwlwifi-for-kalle-2020-03-08

for you to fetch changes up to 9352ed0165ff4313ab340c979446c3d64c531f7a:

  iwlwifi: cfg: use antenna diversity with all AX101 devices (2020-03-06 15=
:26:33 +0200)

----------------------------------------------------------------
First batch of fixes intended for v5.6

* Fix a locking issue in time events handling;
* A fix in rate-scaling;
* Fix for a potential NULL pointer deref;
* Enable antenna diversity in some devices that were erroneously not
  doing it;
* Allow FW dumps to continue when the FW is stuck;
* A fix in the HE capabilities handling;
* Another fix for FW dumps where we were reading wrong addresses.

----------------------------------------------------------------
Avraham Stern (1):
      iwlwifi: mvm: take the required lock when clearing time event data

Ilan Peer (1):
      iwlwifi: mvm: Fix rate scale NSS configuration

Luca Coelho (3):
      iwlwifi: check allocated pointer when allocating conf_tlvs
      iwlwifi: dbg: don't abort if sending DBGC_SUSPEND_RESUME fails
      iwlwifi: cfg: use antenna diversity with all AX101 devices

Mordechay Goodstein (2):
      iwlwifi: consider HE capability when setting LDPC
      iwlwifi: yoyo: don't add TLV offset when reading FIFOs

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c      |  2 ++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c         | 25 ++++++++---------=
--------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h         |  6 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c        |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c      | 35 +++++++++++++++++=
+++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c |  4 ++++
 6 files changed, 44 insertions(+), 30 deletions(-)

--=-f2sNoMlo2IBWg1LTEQSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl5kryEACgkQoUecoho8
xfoXwg//d4MNtbuSA4fXTIa3QRX8hxqLHBbDOhPfKUJgfjUOtTuhCtygwQorBqHu
3bXLpQXTvLgZ01CWWjDaib2Tmiu1ObCZDOB1mwceA6FUoUb1GeTcYzORPDETYhgI
QKX6pLCYk4OUlIaW+I2dsl400cjCSXOp0rzwi6Jf8MDCgpiEKBWw/awoqOFawBob
ANRAiGhtabNPpCmDlPDfqySl24FrAtOdlZCOhJjLEedZeIWYPOnwqRkgHlnv8T1W
wEA7Gn6blLCnhTCXD+eGpW7tu/lke2v3dUkEoXeJr3haeNYdxR/isr81hx2rt4Gj
tCG/vV9Kx+4kWFfiWFzeECo+4AZGXN9cVKX3VyMJ0IAr09Hy+kqrlZwZ42vXTe78
lZfRb/E1n92igQMgny6/kPcAyw4SWo6Ku++n5zVPTyPQdQbQ1WQtvf7lHgB2wNPy
STeFmuHOCiqBxr7TwMzn8BVqnSCIN/sYN1kOnYiwDeGiOWzJQXmCEoHZ1QdX6TQe
sO2gUMxaeNygpiBTHMyiOD1NQgxsrEoYULv7YOhx+pwC/uc6dPg34u1En6d+UbfE
6dEcMkKXEKUs/EChHM53hWsQcmhPw5XvqvBQ5/+B2nwhBTpOhh+UnacItOf/RvVP
tqUZ3ZIJYnawbA1kcYPuvzINCP/nvuJoKXYZZnXZHLtQQ1RkxyU=
=poy7
-----END PGP SIGNATURE-----

--=-f2sNoMlo2IBWg1LTEQSG--

