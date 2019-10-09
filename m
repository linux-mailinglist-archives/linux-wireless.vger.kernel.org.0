Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD04D0C41
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2019 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbfJIKJ5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Oct 2019 06:09:57 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47824 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727219AbfJIKJ5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Oct 2019 06:09:57 -0400
Received: from [91.156.6.193] (helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iI8um-0003oy-7g; Wed, 09 Oct 2019 13:09:55 +0300
Message-ID: <c6f4459b0f0699aae9bd3166c74a538b20f62841.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Wed, 09 Oct 2019 13:09:50 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-kmrqT3d4Ksc7qu1tyI6f"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-fixes 2019-10-09
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-kmrqT3d4Ksc7qu1tyI6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's a batch of fixes intended for v5.4.  This includes the last 2
patchsets I sent.  More details about the contents in the tag
description.

I pushed this to my pending branch and I got results from kbuildbot for the=
 first series, but not to
the second one yet.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 98d22b01f9f6f85eb8870290006241b316829fd3=
:

  rt2x00: remove input-polldev.h header (2019-10-08 18:49:22 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-fixes.git t=
ags/iwlwifi-for-kalle-2019-10-09

for you to fetch changes up to aa0cc7dde17bb6b8cc533bbcfe3f53d70e0dd269:

  iwlwifi: pcie: change qu with jf devices to use qu configuration (2019-10=
-09 13:01:06 +0300)

----------------------------------------------------------------
First batch of fixes intended for v5.4

* fix for an ACPI table parsing bug;
* a fix for a NULL pointer dereference in the cfg with specific
  devices;
* fix the rb_allocator;
* prevent multiple phy configuration with new devices;
* fix a race-condition in the rx queue;
* prevent a couple of memory leaks;
* fix initialization of 3168 devices (the infamous BAD_COMMAND bug);
* fix recognition of some newer systems with integrated MAC;

----------------------------------------------------------------
Haim Dreyfuss (1):
      iwlwifi: mvm: force single phy init

Johannes Berg (2):
      iwlwifi: pcie: fix indexing in command dump for new HW
      iwlwifi: pcie: fix rb_allocator workqueue allocation

Luca Coelho (4):
      iwlwifi: don't access trans_cfg via cfg
      iwlwifi: fix ACPI table revision checks
      iwlwifi: exclude GEO SAR support for 3168
      iwlwifi: pcie: change qu with jf devices to use qu configuration

Naftali Goldstein (1):
      iwlwifi: mvm: fix race in sync rx queue notification

Navid Emamdoost (2):
      iwlwifi: dbg_ini: fix memory leak in alloc_sgtable
      iwlwifi: pcie: fix memory leaks in iwl_pcie_ctxt_info_gen3_init

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c             |  10 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-io.h              |  12 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              |  43 ++++++++++-=
----
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |   9 +--
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  36 ++++++++---=
-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c            | 274 +++++++++++=
+++++++++++++++++++++++++++++++++++----------------------------------------=
------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          |  25 +++++++--
 8 files changed, 229 insertions(+), 181 deletions(-)

--=-kmrqT3d4Ksc7qu1tyI6f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl2dse4ACgkQoUecoho8
xfrS9RAArPO0h1bbxTjOYtRws+q0DYLCZjwapo4h9zZJjZ5NuURkbxdlMeabyiwI
5c8MB9RwJTwxP50JPNzXpHoZ1YKRt5F2tEflkqqR25t+uVGKe39V54T+GTOu5gyp
cKfkbNEx4FoEvJrnYhxtaD6GXQ4MGQf2TdchnaEWhnEPzYxFeaLZXCOXDMjv47a1
1zcOEQ3myK5CUeq4oisict332319wf6yE9Wd4421BEmLmWLkrD/BRa8N9xPfyE7+
R3h7GeVNX1AT9g1wRaet0/S6+ID7AKn+vzCdmrbXgCAS1Gc+Q3lr2O7ItY3fu7zt
STuqTXmQc/95vIBBV/fuWKLA0lRxHxRkFVsDdYi4GvvHJk7IAWFb+gl9OmfiGTEF
qwqJ+Ab9KChb/266fen00VoDYTEgCM/o8dDcW+n6SBHrVwDWFX3UaD0MyatW0FFL
DJNR7sBbdMvFL+qzzLBfzFoxdxWqaVpKXvDmnt9JeW9Ud6Kg9DYYtPUjwQ5ZCrrU
DpcLoOZQLnpUpQcoN85xqpgpavGiI+NztC0iKnOVesZO2z0OupIzCoW32k4pjIkt
9oxwpY8aF8wJZ7IbYzqp6UVUrmV+NlqaY3QP7Xd0chH9oxaQ9p6/z7kn79rKK4OC
gXbr97UUkS5ZhBT7mijiayGG/Zc0GV3dp7q3WtpY6B0265r4vv0=
=7qD6
-----END PGP SIGNATURE-----

--=-kmrqT3d4Ksc7qu1tyI6f--

