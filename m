Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8EF04373B6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbhJVIgT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 04:36:19 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231984AbhJVIgP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 04:36:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mdpzw-000biM-A5; Fri, 22 Oct 2021 11:33:57 +0300
Message-ID: <7a4bc2129d69ef7c5ae30f26aa81363d80d5a769.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Fri, 22 Oct 2021 11:33:54 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-JIl5O6QsCsXgEkrnErmp"
User-Agent: Evolution 3.42.0-2 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: pull-request: iwlwifi-next 2021-10-22
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-JIl5O6QsCsXgEkrnErmp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my first pull request for v5.16 with the four patchsets I sent
earlier.  This is all normal development, new features, bugfixes and
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 9bc0b1aa8b7e54d62082749fc5404660690d17ce=
:

  Merge tag 'mt76-for-kvalo-2021-10-20' of https://github.com/nbd168/wirele=
ss (2021-10-20 19:08:25 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-10-22

for you to fetch changes up to 2c5769e358b7b436f4e848f134d2bbac6010a490:

  iwlwifi: pnvm: print out the version properly (2021-10-22 10:54:18 +0300)

----------------------------------------------------------------
iwlwifi patches for v5.16

* Support for 160MHz in ranging measurements;
* Some fixes in HE capabilities;
* Fixes in vendor specific capabilities;
* Add the PC of both processors in error dumps;
* Small fix in TDLS;
* Code to sanitize firmware dumps;
* Updates for new FW rate and flags format;
* Continue implementation of new rate and flags format in the FW APIs;
* Some fixes for BZ family initialization;
* Fix session protection in some scenarios;
* Some debugging improvements;
* Fix BT-coex priority;
* Improve PS-poll timeout detection;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Avraham Stern (1):
      iwlwifi: mvm: add support for 160Mhz in ranging measurements

Gregory Greenman (1):
      iwlwifi: mvm: improve log when processing CSA

Johannes Berg (20):
      iwlwifi: mvm: fix ieee80211_get_he_iftype_cap() iftype
      iwlwifi: mvm: disable RX-diversity in powersave
      iwlwifi: add vendor specific capabilities for some RFs
      iwlwifi: add some missing kernel-doc in struct iwl_fw
      iwlwifi: api: remove unused RX status bits
      iwlwifi: remove MODULE_AUTHOR() statements
      iwlwifi: remove contact information
      iwlwifi: fix fw/img.c license statement
      iwlwifi: api: fix struct iwl_wowlan_status_v7 kernel-doc
      iwlwifi: mvm: correct sta-state logic for TDLS
      iwlwifi: fw dump: add infrastructure for dump scrubbing
      iwlwifi: parse debug exclude data from firmware file
      iwlwifi: mvm: scrub key material in firmware dumps
      iwlwifi: remove redundant iwl_finish_nic_init() argument
      iwlwifi: mvm: remove session protection after auth/assoc
      iwlwifi: allow rate-limited error messages
      iwlwifi: mvm: reduce WARN_ON() in TX status path
      iwlwifi: pcie: try to grab NIC access early
      iwlwifi: mvm: set BT-coex high priority for 802.1X/4-way-HS
      iwlwifi: pnvm: print out the version properly

Luca Coelho (2):
      iwlwifi: mvm: Support new rate_n_flags for REPLY_RX_MPDU_CMD and RX_N=
O_DATA_NOTIF
      iwlwifi: mvm: remove csi from iwl_mvm_pass_packet_to_mac80211()

Matti Gottlieb (3):
      iwlwifi: Add support for getting rf id with blank otp
      iwlwifi: Add support for more BZ HWs
      iwlwifi: Start scratch debug register for Bz family

Miri Korenblit (11):
      iwlwifi: mvm: Remove antenna c references
      iwlwifi: mvm: update definitions due to new rate & flags
      iwlwifi: mvm: add definitions for new rate & flags
      iwlwifi: mvm: convert old rate & flags to the new format.
      iwlwifi: mvm: Support version 3 of tlc_update_notif.
      iwlwifi: mvm: Support new version of ranging response notification
      iwlwifi: mvm: Add support for new rate_n_flags in tx_cmd.
      iwlwifi: mvm: Support new version of BEACON_TEMPLATE_CMD.
      iwlwifi: mvm: Support new TX_RSP and COMPRESSED_BA_RES versions
      iwlwifi: mvm: Add RTS and CTS flags to iwl_tx_cmd_flags.
      iwlwifi: mvm: Read acpi dsm to get channel activation bitmap

Mordechay Goodstein (1):
      iwlwifi: mvm: add lmac/umac PC info in case of error

Mukesh Sisodiya (1):
      iwlwifi: yoyo: fw debug config from context info and preset

Roee Goldfiner (2):
      iwlwifi: BZ Family BUS_MASTER_DISABLE_REQ code duplication
      iwlwifi: BZ Family SW reset support

Rotem Saado (2):
      iwlwifi: dbg: treat dbgc allocation failure when tlv is missing
      iwlwifi: dbg: treat non active regions as unsupported regions

Sara Sharon (1):
      iwlwifi: mvm: set inactivity timeouts also for PS-poll

Yaara Baruch (2):
      iwlwifi: add new killer devices to the driver
      iwlwifi: add new device id 7F70

 drivers/net/wireless/intel/iwlwifi/Makefile                |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c              |   5 --
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c              |   5 --
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |  31 +++++++++=
++
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c              |   5 --
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c              |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h               |  11 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/debugfs.c           |   4 --
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h               |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c           |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/led.c               |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/led.h               |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/lib.c               |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c          |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/main.c              |   6 ---
 drivers/net/wireless/intel/iwlwifi/dvm/power.c             |   4 --
 drivers/net/wireless/intel/iwlwifi/dvm/power.h             |   4 --
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c                |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/rs.h                |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c                |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c              |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/scan.c              |   4 --
 drivers/net/wireless/intel/iwlwifi/dvm/sta.c               |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c                |   4 --
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h                |   4 --
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c                |   5 --
 drivers/net/wireless/intel/iwlwifi/dvm/ucode.c             |   5 --
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h             |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h        |  57 +++++++++=
++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h          |  18 +++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h       |  10 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h            |   3 ++
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  23 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h             | 234 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h             |  31 ++++-----=
--
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h             |  40 +++++++++=
++----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                |  46 +++++++++=
++++++--
 drivers/net/wireless/intel/iwlwifi/fw/dump.c               |   9 +++-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h         |   4 --
 drivers/net/wireless/intel/iwlwifi/fw/file.h               |  10 ++++
 drivers/net/wireless/intel/iwlwifi/fw/img.c                |  58 ++-------=
------------
 drivers/net/wireless/intel/iwlwifi/fw/img.h                |  12 +++++
 drivers/net/wireless/intel/iwlwifi/fw/init.c               |   6 ++-
 drivers/net/wireless/intel/iwlwifi/fw/paging.c             |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c               |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c                 | 252 +++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h            |   5 ++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h            |   8 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h               |   7 +++
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c           | 166 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h           |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-debug.c             |  24 ++++++---
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h             |  26 ++++++---=
-
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-data.h     |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-io.h       |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-iwlwifi.h  |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h      |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-ucode.h    |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.c          |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace.h          |   5 --
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  44 +++++++++=
++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h               |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-read.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c                |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h                |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         |  17 +++++++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h              |  36 +++++++++=
++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h             |  30 +++++++++=
--
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c           |  19 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |  15 +++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c     |  15 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                |  36 +++++++++=
----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c          |  38 +++++++++=
++---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          | 204 +++++++++=
+++++++++++++++++++++++++++++++++++-----------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h               |  13 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c               | 184 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/power.c             |  28 +++++----=
-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c             |  16 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c                | 182 +++++++++=
+++++++++++++-------------------------------------------
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h                |  17 -------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c                |  39 +++++++--=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c              | 119 +++++++++=
++++++++++++++++------------------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c              |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c                | 117 +++++++++=
+++++++++++++++++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c             |  54 +++++++++=
++---------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |   4 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c              | 151 +++++++++=
+++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  38 +++------=
-----
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |  45 +++++++++=
++-----
 91 files changed, 1959 insertions(+), 780 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/rs.c


--=-JIl5O6QsCsXgEkrnErmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmFyd3IACgkQoUecoho8
xfoRRhAAlLeODRXCHTkTkcI7Oy0CkG8LD12tfCADZ057KLaODGyOCRxvkxCdTbOw
cEa938OZxTm1ak8SvJW2ZzGGsjnnP+qqI2EgaJf7SlR30B7cjAJYB8iAcwvhczqn
PgLfdAeJPk/38gM78LmiWbQCL7auULX7tUsmTk+4yb28SAgxBSRWTKbf4/12/Vx0
QvMOnPNu43RfhbWUr6H1xweVIgvznMYt4PycmbBFAPg/kSVaYXZV902eMLQFWp0B
IZgsuAFBaohz+aySiOZ6HuCiCeT6jsCxq90oAtMU82HlJIcswOTC+hM7/aX4dXgw
W1lbQsP06yy/fCmsLdx539C0cuB/1b28U1ak4phEN/EuDWSceXXFW3DZeOvBC7JJ
tmIRZJPMpJTbVSetVfI9D7EsygQVFJFoF8V2hir4rbQ022YhEDoH5E0bkCkGBeRx
jowezHSesmta+v6to3D80+7m4QqpItzI92vsifR2EA1TDMMZhA20UMqC2WXq1OTY
ubAjU4QREQ3+juJxTHntNHwU0j1jCqqxadl1zvt5V74vkmHEGn7b0W9+LeHrvr6K
0+snXPCWv0q/yCb9UteorIn6V+g3GabXvxzcei7kDeWz8gwKwEuRxIrvFfENXyPx
fDiW6IdrowtGqVtblwA1iVCco/RtM/IAhHOESgn62/OZMECxGrI=
=Hr9d
-----END PGP SIGNATURE-----

--=-JIl5O6QsCsXgEkrnErmp--
