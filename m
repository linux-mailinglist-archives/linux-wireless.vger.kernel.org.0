Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF678137CEF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2020 10:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgAKJve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Jan 2020 04:51:34 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:52420 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728818AbgAKJve (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Jan 2020 04:51:34 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iqDQX-0004b6-Jk; Sat, 11 Jan 2020 11:51:30 +0200
Message-ID: <f548bee28a2ef4700a024e33c02b62893af498c7.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, linuxwifi@intel.com,
        david.e.box@intel.com, joe.konno@intel.com
Date:   Sat, 11 Jan 2020 11:51:28 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-XevzO/iOtc29cktaTJzq"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.2
Subject: pull-request: iwlwifi-next 2020-01-11
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-XevzO/iOtc29cktaTJzq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the fist batch of patches intended for v5.6.  This includes
the last two patchsets I sent out.  Usual development work.  More
details about the contents in the tag description.

I pushed these patches to my pending branch, but it was just now, so I
didn't get the results from kbuildbot yet.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit ae0a723c4cfd89dad31ce238f47ccfbe81b35b84=
:

  Merge ath-next from git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/a=
th.git (2019-12-19 18:27:36 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-01-11

for you to fetch changes up to 0b295a1eb81f37dc7d4f4f2ee9ef375fb36ab5d8:

  iwlwifi: add device name to device_info (2020-01-04 12:48:41 +0200)

----------------------------------------------------------------
First set of patches intended for v5.6

* Support new versions of the FTM FW APIs;
* Fix an old bug in D3 (WoWLAN);
* A couple of fixes/improvements in the receive-buffers code;
* Fix in the debugging where we were skipping one TXQ;
* Support new version of the beacon template FW API;
* Print some extra information when the driver is loaded;
* Some debugging infrastructure (aka. yoyo) updates;
* Support for a new HW version;
* Second phase of device configuration work started;
* Some clean-ups;

----------------------------------------------------------------
Andrei Otcheretianski (1):
      iwlwifi: mvm: Update BEACON_TEMPLATE_CMD firmware API

Avraham Stern (2):
      iwlwifi: mvm: add support for location range request version 8
      iwlwifi: mvm: add support for responder config command version 7

Johannes Berg (8):
      iwlwifi: mvm: update powersave correctly for D3
      iwlwifi: allocate more receive buffers for HE devices
      iwlwifi: pcie: map only used part of RX buffers
      iwlwifi: pcie: use partial pages if applicable
      iwlwifi: pcie: validate queue ID before array deref/bit ops
      iwlwifi: incorporate firmware filename into version
      iwlwifi: mvm: print out extended secboot status before dump
      iwlwifi: prph: remove some unused register definitions

Luca Coelho (10):
      iwlwifi: dbg_ini: don't skip a TX FIFO when dumping
      iwlwifi: remove some outdated iwl22000 configurations
      iwlwifi: remove CSR registers abstraction
      iwlwifi: yoyo: don't allow changing the domain via debugfs
      iwlwifi: yoyo: remove unnecessary active triggers status flag
      iwlwifi: yoyo: remove the iwl_dbg_tlv_gen_active_trigs() function
      iwlwifi: yoyo: check for the domain on all TLV types during init
      iwlwifi: assume the driver_data is a trans_cfg, but allow full cfg
      iwlwifi: implement a new device configuration table
      iwlwifi: add device name to device_info

Oren Givon (1):
      iwlwifi: add new iwlax411 struct for type SoSnj

Tova Mussai (1):
      iwlwifi: scan: remove support for fw scan api v11

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c            |   6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c            |  12 ++---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |  81 +++++++++++=
++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c            |   7 +--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c            |  19 +++-----
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c            |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c            |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c            |  12 ++++-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c            |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h     | 144 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |  41 -----------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h           |   7 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |   9 ++--
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c          |  29 +----------=
-
 drivers/net/wireless/intel/iwlwifi/fw/img.h              |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h          |  13 +----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  68 +++++++----=
---------------
 drivers/net/wireless/intel/iwlwifi/iwl-context-info.h    |  20 ++++----
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h             |  27 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  65 ++++++++---=
--------------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h         |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |  26 +++++++---
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h              |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c              |  37 ++---------=
----
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |  14 ++----
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h            |  10 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |  22 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |   6 +++
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c         |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c   | 239 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c   |  95 +++++++++++=
++++++++++++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              |  27 ++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c             |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c           |  27 +++++------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  47 -----------=
-------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c      |  11 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c            | 173 +++++++++++=
+++++++++++++++++++++++++++++++------------------------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       |  21 +++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c             | 108 +++++++++++=
+++++++++++++++++++------------
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c     |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          |  51 ++++++++++-=
---------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |  16 ++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c             |  12 ++---
 46 files changed, 938 insertions(+), 597 deletions(-)

--=-XevzO/iOtc29cktaTJzq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl4ZmqAACgkQoUecoho8
xfrxDQ/+JSKMmubYu45UGx/gsPB9tMDA+P0C/OJxNgJpwQ0FalydAIFlneR/mhAi
YMFRDu693suKvUGT8F75r8095KD2goESjjlmEmSJ9Y692hhyRSKUl41HlL2G0QYo
sM2NVDQARt1oGSwr7gNDcAXejKUqvdSCKn8zr+aJdRZDd3ym58s4U1qv+DSqZ7eU
j1mIzUKqzCoegJ2w1/bXcoY50TTLT83uXTtMUd40Dpg9aA7jHVxn+joFnMUx2+B0
eVyfTc2Lc2cPFphkUupmurpSb01+gK7QzlE8g8yUC+GiXWmmOmdIDfADz2u5JXcc
/KxB3XOXRZATSPd+5cudSmgy4EJaN3LYiTbnN733rxqrdm2omxk0TQc0VZNMAU99
KPMbDcNvQjA97lcOveVo5mAGuqdL0Ha+3gNACKZZ+e09mIP7gapKcPyxBL51In5c
C5GYHnMIiNo9Ldc5wHoJUjS5DSqozL3/DA0TgcQ8LhuFaSirtbF4mUmMPWTWO6iD
BX7rDKlFgVUUsF9kWu2PKrEQoR+/FzLBwqjYjBwGdP9mCXNlKYaF7gZ0ml8hLc/a
aBQwz/zxddhBnrg8lUJZAYNH2rZgJvInDlW8je+zoEkDW7Wewn0CmTOhFUgi4ZLo
NdutIPFiWL+ndDjHL02JEyYoGvhsc0JhnKLjNI0/ZHkaeHdpxS4=
=tN55
-----END PGP SIGNATURE-----

--=-XevzO/iOtc29cktaTJzq--

