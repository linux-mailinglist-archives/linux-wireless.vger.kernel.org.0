Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A213174FE
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 01:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbhBKAIF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 19:08:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45508 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233554AbhBKAHk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 19:07:40 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.69])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9zVS-004ADz-VN; Thu, 11 Feb 2021 02:06:52 +0200
Message-ID: <8fc242539c12e702080789efd0e2f333d2c13bfd.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 11 Feb 2021 02:06:49 +0200
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ddD6RhiMNG3GPfVRN+1U"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: pull-request: iwlwifi-next 2021-02-10
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-ddD6RhiMNG3GPfVRN+1U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's the second batch of patches intended for v5.12.  This includes
the four last patchsets I sent out for v5.12.  Usual development work.
More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit 8e79106a7dbbfcb9e87644d0ee1d038670fba844=
:

  rtlwifi: rtl8821ae: phy: Simplify bool comparison (2021-02-10 09:39:35 +0=
200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-02-10

for you to fetch changes up to 000735e5dbbb739ca3742413858c1d9cac899e10:

  iwlwifi: bump FW API to 62 for AX devices (2021-02-11 01:58:23 +0200)

----------------------------------------------------------------
Second set of iwlwifi patches intended for v5.12

* Add some device IDs that got lost in a rebase;
* A bunch of fixes in the PPAG code;
* A few fixes in the debugging framework;
* Fix a couple of potential crashes in error paths;
* More HW IDs for new HW;
* Add one more value to the device configuration code;
* Support new scan config FW API;
* Some more CSA fixes;
* Support for RF interference mitigation (RFI);
* Improvements in the NVM flows;
* Bump the FW API support version;
* Implement support for PNVM from BIOS;
* Fix PM status when a FW crash happens;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Abhishek Naik (1):
      iwlwifi: mvm: Check ret code for iwl_mvm_load_nvm_to_nic

Emmanuel Grumbach (7):
      iwlwifi: mvm: enhance a print in CSA flows
      iwlwifi: pcie: NULLify pointers after free
      iwlwifi: pcie: don't crash when rx queues aren't allocated in interru=
pt
      iwlwifi: mvm: register to mac80211 last
      iwlwifi: mvm: simplify iwl_mvm_dbgfs_register
      iwlwifi: mvm: isolate the get nvm flow
      iwlwifi: mvm: get NVM later in the mvm_start flow

Golan Ben Ami (1):
      iwlwifi: mvm: reduce the print severity of failing getting NIC temp

Gregory Greenman (2):
      iwlwifi: mvm: add RFI-M support
      iwlwifi: acpi: add support for DSM RFI

Haim Dreyfuss (1):
      iwlwifi: acpi: don't return valid pointer as an ERR_PTR

Ihab Zhaika (1):
      iwlwifi: add new cards for So and Qu family

Ilan Peer (1):
      iwlwifi: mvm: Support SCAN_CFG_CMD version 5

Johannes Berg (6):
      iwlwifi: pcie: don't disable interrupts for reg_lock
      iwlwifi: mvm: remove useless iwl_mvm_resume_d3() function
      iwlwifi: api: clean up some documentation/bits
      iwlwifi: remove flags argument for nic_access
      iwlwifi: remove max_vht_ampdu_exponent config parameter
      iwlwifi: remove max_ht_ampdu_exponent config parameter

Luca Coelho (11):
      iwlwifi: pcie: add a few missing entries for So with Hr
      iwlwifi: acpi: fix PPAG table sizes
      iwlwifi: mvm: fix the type we use in the PPAG table validity checks
      iwlwifi: mvm: store PPAG enabled/disabled flag properly
      iwlwifi: mvm: send stored PPAG command instead of local
      iwlwifi: mvm: assign SAR table revision to the command later
      iwlwifi: pnvm: set the PNVM again if it was already loaded
      iwlwifi: pnvm: increment the pointer before checking the TLV
      iwlwifi: pnvm: move file loading code to a separate function
      iwlwifi: pnvm: implement reading PNVM from UEFI
      iwlwifi: bump FW API to 62 for AX devices

Matti Gottlieb (4):
      iwlwifi: pcie: Change Ma device ID
      iwlwifi: pcie: add CDB bit to the device configuration parsing
      iwlwifi: pcie: add AX201 and AX211 radio modules for Ma devices
      iwlwifi: pcie: define FW_RESET_TIMEOUT for clarity

Miri Korenblit (1):
      iwlwifi:mvm: Add support for version 2 of the LARI_CONFIG_CHANGE comm=
and.

Mordechay Goodstein (4):
      iwlwifi: when HW has rate offload don't look at control field
      iwlwifi: dbg: remove unsupported regions
      iwlwifi: dbg: add op_mode callback for collecting debug data.
      iwlwifi: queue: add fake tx time point

Mukesh Sisodiya (1):
      iwlwifi: correction of group-id once sending REPLY_ERROR

Naftali Goldstein (1):
      iwlwifi: declare support for triggered SU/MU beamforming feedback

Ravi Darsi (1):
      iwlwifi: mvm: global PM mode does not reset after FW crash

Sara Sharon (1):
      iwlwifi: mvm: don't check if CSA event is running before removing

Shaul Triebitz (1):
      iwlmvm: set properly NIC_NOT_ACK_ENABLED flag

Takashi Iwai (1):
      iwlwifi: dbg: Mark ucode tlv data as const

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c            |   8 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c            |  14 +++----
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c           |  43 +++++++++++=
+++++++++-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c            |   8 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c            |  20 ++++------
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c            |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c            |   6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c            |   1 -
 drivers/net/wireless/intel/iwlwifi/dvm/main.c            |  10 ++---
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c              |   7 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c             |  50 +++++++++++=
+++++++------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h             |  24 +++++++++--=
-
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h     |  12 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h     |   7 +++-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h          |   5 +++
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h      |  15 +++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h          |  60 +++++++++++=
++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h         |   5 ++-
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h           |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              |  54 +++++++++++=
+--------------
 drivers/net/wireless/intel/iwlwifi/fw/file.h             |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c             | 190 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------=
------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h          |  14 ++++---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h             |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c         |  86 +++++++++++=
+++++++++++++++++++------------
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h         |   6 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c             |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-eeprom-parse.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c              |  46 +++++++++--=
------------
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c       |   6 +--
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h       |   1 +
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h         |  14 ++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c           |   7 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           |  14 +++----
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile          |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c              |   8 +---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c         |  90 +++++++++++=
++++++++++++++++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h          |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              | 116 +++++++++++=
++++++++++++++++++++++++++++++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c        |  19 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h             |  15 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c             |  79 +++++++++++=
++++++++++++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c             | 118 +++++++++++=
++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c            |  14 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c      |   3 --
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c              |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c              |  22 ++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c |  21 ++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c            | 188 +++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++------------------------------=
-----
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c             |  16 +++++---
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c     |   8 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          |  54 +++++++++++=
++-------------
 drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c        |   5 +--
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c             |  27 ++++++-----=
--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c            |   4 ++
 55 files changed, 1116 insertions(+), 444 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/rfi.h
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c


--=-ddD6RhiMNG3GPfVRN+1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmAkdRoACgkQoUecoho8
xfqr0g//XonOJZej/WDPFkl95oo04LGMtg0iPnI/mWkDH6pUK5sBg2veu5q2cq3U
uLY5pxSib1d/3p0iTNKWhwQQ8Es41cXV3l2c3CHAu+qjIW6bspXP7/H8L4K9eGLt
hGp9aPW0Ajk8ERlXE4LrDPpCT2KcFLqD6k8JdYhZiSPoJECl71mAGkCDJ+g4VQSx
unjbNu+usZLjQ6coKY0wTL2qpQTKHAhUhqafst0UemBGkKncbUoT00aQYNOkl+VB
FAOsuBBx+5IcRk7CV3ILd2E+9PI+Xlq+q2J6a9YGt2CXGtbhBFnjaMsOkSVFbWNy
V1E0CN1Mpa567Y9EtUcjCQgdEP+uoq135L/Jq3pDnndJkLro6zRQXU/hCUgfoR23
FacyKkWNF4tFmFGE+tbJUk4GNO0WdNys5oon2uuTrkE6h1lgL6HdiHoBWy4a7ktT
fwzTEtrFe3+JNXXkc8h0VVjyreYGRkw/KFN6xJOUSAy/0AT7eRJtnyvUOa9EhZNx
TPXgeHd/JuhgXvL52wCKHDVUsLgptj/z1xrDdhjczqrFV9SKg8LmvdBdsL95qZJ+
Rb5P+2I4r7ATe7JJf2vQaga3EapFw6dB0bQOnvnMz7WFOas1+7W1feIxF+92cAST
d6YxXxR9f9pgj/GzEo9jfrTIvrwTyTbPkzVLuCTp/svlxOGyJNU=
=R9X0
-----END PGP SIGNATURE-----

--=-ddD6RhiMNG3GPfVRN+1U--

