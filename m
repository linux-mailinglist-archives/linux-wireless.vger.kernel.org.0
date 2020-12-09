Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648952D4E02
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 23:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbgLIWZa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 17:25:30 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:36032 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388388AbgLIWZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 17:25:20 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn7ss-003E6Y-Mp; Thu, 10 Dec 2020 00:24:31 +0200
Message-ID: <665956a3d48af607c232c475f0d7cd3219bb872d.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 10 Dec 2020 00:24:29 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-LMtUmr42KiuOzZHOoloa"
User-Agent: Evolution 3.38.1-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2020-12-09
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-LMtUmr42KiuOzZHOoloa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the first batch of patches intended for v5.11.  This includes all
the patchsets I sent out for v5.11.  Usual development work.  More
details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 3f79e541593fecc2a90687eb7162e15a499caa33=
:

  rtlwifi: rtl8192de: fix ofdm power compensation (2020-12-09 09:22:37 +020=
0)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2020-12-09

for you to fetch changes up to fd1c3318f4e7cf30cd73efb3cb5e9648efc6625b:

  iwlwifi: mvm: validate notification size when waiting (2020-12-10 00:16:0=
8 +0200)

----------------------------------------------------------------
iwlwifi patches intended for v5.11

* A few fixes and improvements in the FW debugging framework;
* A fix in the HE capabilities settings;
* Small fix in the logs for SAR;
* Move queue code to a common place;
* Support for 6GHz;
* Improve validation of firmware notifications;
* Debugging improvements and fixes;
* Replace terminology with inclusive words determined by the guidelines;
* Convert copyright notices to SPDX tags;
* Added more validations for firmware notifications;
* A couple of debugging/recovery fixes;
* Added some more validations for firmware notifications;
* Support for a new type of HW;
* A couple of channel switch fixes;
* Support new FW reset handshake;
* Add a couple of RX handlers that were accidentally left out;
* Some other clean-ups and small fixes;

----------------------------------------------------------------
Avraham Stern (1):
      iwlwifi: mvm: add size checks for range response notification

Emmanuel Grumbach (7):
      iwlwifi: mvm: remove the read_nvm from iwl_run_init_mvm_ucode
      iwlwifi: pcie: remove obsolete pre-release support code
      iwlwifi: mvm: remove the read_nvm from iwl_run_unified_mvm_ucode
      iwlwifi: follow the new inclusive terminology
      iwlwifi: sort out the NVM offsets
      iwlwifi: remove sw_csum_tx
      iwlwifi: mvm: purge the BSS table upon firmware load

Janie Tu (1):
      iwlwifi: mvm: fix sar profile printing issue

Johannes Berg (23):
      iwlwifi: copy iwl_he_capa for modifications
      iwlwifi: validate MPDU length against notification length
      iwlwifi: pcie: validate RX descriptor length
      iwlwifi: mvm: clear up iwl_mvm_notify_rx_queue() argument type
      iwlwifi: mvm: move iwl_mvm_stop_device() out of line
      iwlwifi: pcie: change 12k A-MSDU config to use 16k buffers
      iwlwifi: mvm: fix 22000 series driver NMI
      iwlwifi: mvm: do more useful queue sync accounting
      iwlwifi: mvm: clean up scan state on failure
      iwlwifi: pcie: remove MSIX_HW_INT_CAUSES_REG_IML handling
      iwlwifi: fw: file: fix documentation for SAR flag
      iwlwifi: pcie: remove unnecessary setting of inta_mask
      iwlwifi: trans: consider firmware dead after errors
      iwlwifi: dbg-tlv: fix old length in is_trig_data_contained()
      iwlwifi: use SPDX tags
      iwlwifi: pcie: clean up some rx code
      iwlwifi: mvm: validate firmware sync response size
      iwlwifi: add an extra firmware state in the transport
      iwlwifi: support firmware reset handshake
      iwlwifi: mvm: disconnect if channel switch delay is too long
      iwlwifi: tighten RX MPDU bounds checks
      iwlwifi: mvm: hook up missing RX handlers
      iwlwifi: mvm: validate notification size when waiting

Luca Coelho (1):
      iwlwifi: mvm: add support for 6GHz

Matti Gottlieb (1):
      iwlwifi: Add a new card for MA family

Mordechay Goodstein (9):
      iwlwifi: remove all queue resources before free
      iwlwifi: yoyo: add the ability to dump phy periphery
      iwlwifi: move reclaim flows to the queue file
      iwlwifi: mvm: Init error table memory to zero
      iwlwifi: enable sending/setting debug host event
      iwlwifi: avoid endless HW errors at assert time
      iwlwifi: fix typo in comment
      iwlwifi: mvm: iterate active stations when updating statistics
      iwlwifi: mvm: check that statistics TLV version match struct version

Naftali Goldstein (1):
      iwlwifi: d3: do not send the WOWLAN_CONFIGURATION command for netdete=
ct

Rotem Saado (1):
      iwlwifi: yoyo: align the write pointer to DWs

Sara Sharon (1):
      iwlwifi: mvm: fix a race in CSA that caused assert 0x3420

 drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |  70 ++++-----=
------
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c              |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c              |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c              |  58 ++-------=
----
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h               |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/dvm/calib.c             |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/dvm/calib.h             |  60 +--------=
----
 drivers/net/wireless/intel/iwlwifi/dvm/commands.h          |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c                |  16 +++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c               |  85 ++++-----=
----------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |  74 +++------=
-------
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h          |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/binding.h        |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/cmdhdr.h         |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h           |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h       |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/config.h         |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/context.h        |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h             |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h       |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h        |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h          |  81 +++++----=
---------
 drivers/net/wireless/intel/iwlwifi/fw/api/filter.h         |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/led.h            |  62 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h       |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h        |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h            |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  78 +++------=
--------
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h        |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/paging.h         |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h       |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h            |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h          |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h             |  66 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h             |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h           |  83 ++++-----=
---------
 drivers/net/wireless/intel/iwlwifi/fw/api/sf.h             |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/soc.h            |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h            |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h          |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/tdls.h           |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/time-event.h     |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h             |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/api/txq.h            |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                | 151 +++++++++=
+++++++++---------------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h                |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c            |  96 ++++++++-=
------------
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.h            |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h         |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/file.h               |  79 ++++-----=
--------
 drivers/net/wireless/intel/iwlwifi/fw/img.h                |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/init.c               |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.c         |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/notif-wait.h         |  63 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/paging.c             |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h            |  62 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/fw/smem.c               |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-agn-hw.h            |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-config.h            |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |  56 ++-------=
---
 drivers/net/wireless/intel/iwlwifi/iwl-context-info.h      |  58 ++-------=
----
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h               |  71 ++-------=
-------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c           |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h           |  64 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c             |  62 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h               |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c      |  65 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.h      |  76 ++++-----=
--------
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c       |  62 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.h       |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h                |  66 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-io.c                |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-io.h                |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-modparams.h         |  61 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         | 176 +++++++++=
++++++++++++++---------------
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h         |  65 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h           |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c            |  78 ++++-----=
--------
 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.h            |  62 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h              |  93 ++++++---=
-----------
 drivers/net/wireless/intel/iwlwifi/iwl-scd.h               |  62 +--------=
-----
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c             |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h             |  99 ++++++---=
-------------
 drivers/net/wireless/intel/iwlwifi/mvm/binding.c           |  65 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c              |  65 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h         |  71 ++-------=
-------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                |  82 ++-------=
---------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c       |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c           |  71 ++-------=
-------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.h           |  65 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     | 112 +++++++++=
+--------------
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c     |  64 ++-------=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h            |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                | 108 ++++++++-=
---------------
 drivers/net/wireless/intel/iwlwifi/mvm/led.c               |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c          |  95 ++++++---=
------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          | 129 +++++++++=
-------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h               |  88 +++------=
----------
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c               |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/offloading.c        |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c               | 103 ++++++++-=
--------------
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c          |  69 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/power.c             |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/quota.c             |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c             |  76 ++++-----=
--------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                | 120 ++++++++-=
-----------------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c              | 140 +++++++++=
+++++----------------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c              | 421 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------=
-------
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c                |  66 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c               |  76 ++++-----=
--------
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h               |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c              |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c        |  68 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.h        |  67 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c                |  70 ++-------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                |  76 ++-------=
--------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c             |  71 ++-------=
-------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  57 ++-------=
----
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c        |  60 ++-------=
----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c              |  90 +++------=
-----------
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h         |  80 +++------=
---------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c               | 113 ++++++---=
----------------
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  83 +++++++--=
---------
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c            | 155 ++++-----=
-------------------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c          |  57 ++-------=
----
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c               | 351 +++------=
-------------------------------------------------------------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.c              | 308 +++++++++=
+++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h              |  68 +++------=
------
 129 files changed, 1990 insertions(+), 8365 deletions(-)


--=-LMtUmr42KiuOzZHOoloa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAl/RTp0ACgkQoUecoho8
xfoREw/6AonxbHK+1hGuWUQuUNuO+fGoEhA7QJjtwlMEk+0OA48mZixWo+FrmIL5
RAePopM3UY5w7NPQoUA1wGvU/+kWc9zTHgnL536BW6zVz9z4LkYNuKRU4+9EA83j
yJr+0q3QdKUOJb5vxK53hWHV8aOAOxXl4l6l8IMeR542mlLq7Zu6QH+Uxg8ovEmB
YldoMAlvhTIh8BJzdyojHzbeCeSJ36sY1ZxTbynzV0wsIWYQfFq1mE46bMHoNruA
XLuVT7N97t9Op1iOaYA7gG+Yucs0vf4E7ts0bzZ2TpF5pbOdRapdqfTlnV+vAL6+
IcDt/x/AzzBIOdW2xaeTxMWt1ztuwtQCOuzKQsV3jkCMT9zRj6MiL2ZaKXsXsJK6
vS88G8h7JNi2A8WbqXL7BvPKDf8PZi8ozkMD7gMjeDn9nFcBagHQrqUFQGTo2oV7
b/ojZ+ngwubPfEPiWJBRWbrMufZU7Cs8uNfdIhsK+Ub+9hz50o+XpFZ3QdNQ8UyN
CuNaa0HJwxohUA/NJZWQJSFJvacvSi5hNw1t9MoOelKyXDPjhtpK9yxPgMUYV3mN
sAqMipqZZaS7bo9PBbIU7Pfx0Qjpxkk42/vxKUVy7FGLBHTShd+CRdt6qSbCKoCJ
eKlyHCzVq11IbVpgPw1nSeMbvNTibeMqaIqBy/0pm9Wj1qP5wP8=
=DoEG
-----END PGP SIGNATURE-----

--=-LMtUmr42KiuOzZHOoloa--

