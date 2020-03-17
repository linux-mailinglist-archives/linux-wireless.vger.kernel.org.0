Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01882188DF3
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 20:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQT0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 15:26:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:34592 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726294AbgCQT0U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 15:26:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jEHqz-0003kD-8N; Tue, 17 Mar 2020 21:26:18 +0200
Message-ID: <9940614e4051cc054569033ca7c127f3339469e6.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com
Date:   Tue, 17 Mar 2020 21:26:16 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-I+iWIk54QQCJaTcjUJ/h"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-next 2020-03-17
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-I+iWIk54QQCJaTcjUJ/h
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the fist batch of patches intended for v5.7.  This includes
the last patchset I sent out.  Usual development work.  More details
about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 377c0a94ad1cf005c47d7a502d1f8e46fbcf747a=
:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/a=
th.git (2020-03-16 07:29:55 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-03-17

for you to fetch changes up to 5e003982b07ae351cadef4c252b3279b3424bf0d:

  iwlwifi: move AX200 devices to the new table (2020-03-17 21:10:47 +0200)

----------------------------------------------------------------
First set of iwlwifi patches intended for v5.7

* Refactoring of the device selection algorithms;

----------------------------------------------------------------
Luca Coelho (13):
      iwlwifi: move the remaining 0x2526 configs to the new table
      iwlwifi: combine 9260 cfgs that only change names
      iwlwifi: add mac/rf types and 160MHz to the device tables
      iwlwifi: add GNSS differentiation to the device tables
      iwlwifi: add Pu/PnJ/Th device values to differentiate them
      iwlwifi: map 9461 and 9462 using RF type and RF ID
      iwlwifi: move TH1 devices to the new table
      iwlwifi: convert the 9260-1x1 device to use the new parameters
      iwlwifi: remove 9260 devices with 0x1010 and 0x1210 subsytem IDs
      iwlwifi: move pu devices to new table
      iwlwifi: move shared clock entries to new table
      iwlwifi: remove trans entries from COMMON 9260 macro
      iwlwifi: move AX200 devices to the new table

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  |  47 +++++---------
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   | 161 +++++---------------=
--------------------------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  59 ++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 355 ++++++++++++++++++++=
+++++++++++++++++++++++++--------------------------------------------------=
------
 4 files changed, 241 insertions(+), 381 deletions(-)

--=-I+iWIk54QQCJaTcjUJ/h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl5xJFgACgkQoUecoho8
xfpyNw//fA0PW5ZRv+c2sseoZFsLrxzVvV1gz6neSNb86h/M6AwbME+0XJmvwpze
VM6JI5990ys/aVg3Kst0l5JwVknLyfem/EZd3oaHq0f9ugrLRki+ikkUUnSmwajx
oIUrHuYHqDnJh/wkngpa7Wjc8xItk16IXTeeCMtPa6Nbl6Kvls2MlK7Soe7hh6lO
Ax+vlpUFqbR9bzCESykwlnsZY6apBtO5IPRrzO7R+f6FaGXi5yVr6VcGBiBC1Jxw
4DxvvAiFJKhA5YWJLiTi/Laynt4MqESL4gcq02H8MO6gDNR5zWZX729WBVlxCaqs
PGLuKce7WlgyTwNa6IBuBOQh5kEfdg7futYMN37zXnc5cI/yoXP9o6ppRRzHXV1h
A4QvOZ+8LsvdcaW1V6rlthfT82BZZOPtsNwnHhEyvJCmB+0llFegsMmqFIGTjv4x
4NSOxl3lFg3sPUcN6LhUZrCpfftBUjtuxBQibkd8xLjw6dpd/eDl58EpSnJ9WP1X
qhaXtT3cM/xkk7SNeyuiw4nyrR/3U38GrGBBPu/u/ETERCSF940yEPMMR2o8QdGi
gMg82zh+zc2iBuz4PMdks5Y9p49nlNflMG5QVTFnkYr342wuylp/2TF40sa/9ll4
UoLpPWNJEQ4Rh5gVI6ov8QrvDfizWuDxGPpgVV9HQkhDtma5Ees=
=mgsR
-----END PGP SIGNATURE-----

--=-I+iWIk54QQCJaTcjUJ/h--

