Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BE93F8FC5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Aug 2021 22:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbhHZUrz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Aug 2021 16:47:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33562 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232115AbhHZUry (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Aug 2021 16:47:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mJMH9-002XPM-Q7; Thu, 26 Aug 2021 23:47:05 +0300
Message-ID: <c0d6e33d5f9e113e59ee34ca65a4fb45cd89f33b.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org, luca@coelho.fi
Date:   Thu, 26 Aug 2021 23:47:03 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-LpQ5LyfLLuGCju4IDxwB"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: pull-request: iwlwifi-next 2021-08-26
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-LpQ5LyfLLuGCju4IDxwB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my pull request for v5.15 with all the patchesets I sent
earlier.  This is all normal development, new features, bugfixes and
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit e3f30ab28ac866256169153157f466d90f44f122=
:

  Merge branch 'pktgen-samples-next' (2021-08-25 13:44:30 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-08-26

for you to fetch changes up to d9a406ac813dd6a4cfc92bc2576adf43219792ef:

  iwlwifi: bump FW API to 66 for AX devices (2021-08-26 23:39:05 +0300)

----------------------------------------------------------------
iwlwifi patches for v5.15

* Support scanning hidden 6GHz networks;
* Some improvements in the FW error dumps;
* Add some HE capability flags
* A bunch of janitorial clean-ups;
* Clean-ups in the TX code;
* Small fix for SMPS;
* Support for a new hardware family (Bz);
* Small fix in the scan code;
* A bunch of changes in the D3 code, including new FW API;
* Finalize the refactoring of 6GHz scan;
* Initial changes in the SAR profile code;
* Fix reading one of our ACPI tables (WTAS);
* Support some new ACPI table revisions;
* Support new API of the WoWlan status FW notification;
* Fixes in SAR ACPI tables handling;
* Some debugging improvements;
* Fix in ROC;
* Support for new FW API versions;
* Support new FW command versions;
* Ongoing work on support for Bz devices;
* Add new DHC framework to help with debugging of FW flows;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Abhishek Naik (1):
      iwlwifi: skip first element in the WTAS ACPI table

Avraham Stern (4):
      iwlwifi: mvm: silently drop encrypted frames for unknown station
      iwlwifi: mvm: don't schedule the roc_done_wk if it is already running
      iwlwifi: mvm: add support for range request command version 13
      iwlwifi: mvm: add support for responder config command version 9

Dror Moshe (1):
      iwlwifi: move get pnvm file name to a separate function

Gregory Greenman (2):
      iwlwifi: mvm: support version 11 of wowlan statuses notification
      iwlwifi: mvm: introduce iwl_stored_beacon_notif_v3

Ilan Peer (5):
      iwlwifi: mvm: Do not use full SSIDs in 6GHz scan
      iwlwifi: mvm: Add support for hidden network scan on 6GHz band
      iwlwifi: mvm: Fix umac scan request probe parameters
      iwlwifi: mvm: Refactor setting of SSIDs for 6GHz scan
      iwlwifi: mvm: Fix scan channel flags settings

Johannes Berg (33):
      iwlwifi: nvm: enable IEEE80211_HE_PHY_CAP10_HE_MU_M1RU_MAX_LTF
      iwlwifi: mvm: avoid FW restart while shutting down
      iwlwifi: pcie: optimise struct iwl_rx_mem_buffer layout
      iwlwifi: pcie: free RBs during configure
      iwlwifi: prepare for synchronous error dumps
      iwlwifi: pcie: dump error on FW reset handshake failures
      iwlwifi: mvm: set replay counter on key install
      iwlwifi: mvm: restrict FW SMPS request
      iwlwifi: mvm: avoid static queue number aliasing
      iwlwifi: mvm: clean up number of HW queues
      iwlwifi: mvm: treat MMPDUs in iwl_mvm_mac_tx() as bcast
      iwlwifi: split off Bz devices into their own family
      iwlwifi: give Bz devices their own name
      iwlwifi: read MAC address from correct place on Bz
      iwlwifi: pcie: implement Bz device startup
      iwlwifi: implement Bz NMI behaviour
      iwlwifi: pcie: implement Bz reset flow
      iwlwifi: mvm: support new station key API
      iwlwifi: mvm: simplify __iwl_mvm_set_sta_key()
      iwlwifi: mvm: d3: separate TKIP data from key iteration
      iwlwifi: mvm: d3: remove fixed cmd_flags argument
      iwlwifi: mvm: d3: refactor TSC/RSC configuration
      iwlwifi: mvm: d3: add separate key iteration for GTK type
      iwlwifi: mvm: d3: make key reprogramming iteration optional
      iwlwifi: mvm: d3: implement RSC command version 5
      iwlwifi: mvm: fix access to BSS elements
      iwlwifi: fw: correctly limit to monitor dump
      iwlwifi: pcie: avoid dma unmap/remap in crash dump
      iwlwifi: fix __percpu annotation
      iwlwifi: api: remove datamember from struct
      iwlwifi: fw: fix debug dump data declarations
      iwlwifi: allow debug init in RF-kill
      iwlwifi: mvm: don't use FW key ID in beacon protection

Luca Coelho (18):
      iwlwifi: print PNVM complete notification status in hexadecimal
      iwlwifi: pcie: remove spaces from queue names
      iwlwifi: mvm: remove check for vif in iwl_mvm_vif_from_mac80211()
      iwlwifi: rename ACPI_SAR_NUM_CHAIN_LIMITS to ACPI_SAR_NUM_CHAINS
      iwlwifi: convert flat SAR profile table to a struct version
      iwlwifi: remove ACPI_SAR_NUM_TABLES definition
      iwlwifi: pass number of chains and sub-bands to iwl_sar_set_profile()
      iwlwifi: acpi: support reading and storing WRDS revision 1 and 2
      iwlwifi: support reading and storing EWRD revisions 1 and 2
      iwlwifi: remove unused ACPI_WGDS_TABLE_SIZE definition
      iwlwifi: convert flat GEO profile table to a struct version
      iwlwifi: acpi: support reading and storing WGDS revision 2
      iwlwifi: bump FW API to 65 for AX devices
      iwlwifi: acpi: fill in WGDS table with defaults
      iwlwifi: acpi: fill in SAR tables with defaults
      iwlwifi: export DHC framework and add first public entry, twt_setup
      iwlwifi: mvm: add fixed_rate debugfs entry to public DHC
      iwlwifi: bump FW API to 66 for AX devices

Matti Gottlieb (3):
      iwlwifi: Add support for getting rf id with blank otp
      iwlwifi: Add support for more BZ HWs
      iwlwifi: Start scratch debug register for Bz family

Miri Korenblit (2):
      iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage
      iwlwifi: mvm: load regdomain at INIT stage

Mordechay Goodstein (3):
      iwlwifi: iwl-nvm-parse: set STBC flags for HE phy capabilities
      iwlwifi: iwl-dbg-tlv: add info about loading external dbg bin
      iwlwifi: mvm: remove trigger EAPOL time event

Mukesh Sisodiya (2):
      iwlwifi: yoyo: cleanup internal buffer allocation in D3
      iwlwifi: yoyo: support for new DBGI_SRAM region

Shaul Triebitz (4):
      iwlwifi: mvm: set BROADCAST_TWT_SUPPORTED in MAC policy
      iwlwifi: mvm: trigger WRT when no beacon heard
      iwlwifi: add 'Rx control frame to MBSSID' HE capability
      iwlwifi: mvm: support broadcast TWT alone

Tom Rix (1):
      iwlwifi: remove trailing semicolon in macro definition

Wei Yongjun (1):
      iwlwifi: mvm: fix old-style static const declaration

Zhang Qilong (1):
      iwlwifi: mvm: fix a memory leak in iwl_mvm_mac_ctxt_beacon_changed

Zheng Yongjun (1):
      iwlwifi: use DEFINE_MUTEX() for mutex lock

 drivers/net/wireless/intel/iwlwifi/Kconfig             |   6 +
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c         |  99 +++++++++++++=
+--
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c          |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c          |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c            |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c           | 304 +++++++++++++=
++++++++++++++++++++++--------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h           |  66 ++++++++---
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h       |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h   |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h         |  22 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h        | 132 +++++++++++++=
+++++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/location.h   | 189 +++++++++++++=
+++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/mac.h        |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/offload.h    |  31 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h         |  40 ++++++-
 drivers/net/wireless/intel/iwlwifi/fw/api/scan.h       |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h        |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c            | 146 +++++++++++++=
++---------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h            |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c           |   7 ++
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h     |  26 ++---
 drivers/net/wireless/intel/iwlwifi/fw/file.h           |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c           |  15 +--
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h           |  20 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h        |  11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h           |  29 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c       |  34 +++---
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.h       |  24 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c            |  26 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c     |  40 ++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h       |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h          |  43 +++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h         |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h     |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c            | 580 +++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------=
------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |  87 +++++++++++++=
+
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c       |  57 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  85 +++++++++++--=
-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-responder.c |  27 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw-api.h        |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c            | 108 ++++++++++---=
-----
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c      |  44 ++++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c      |  35 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h           |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c           |  75 ++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c           |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c         |  33 ++++++
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h            |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c          |  45 +++++---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c          |  93 ++++++++-----=
--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c           | 120 +++++++++++++=
+------
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c    |  41 +++++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c          | 118 +++++++++++++=
+++++-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h     |  24 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c           |  17 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |  57 ++++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c        |  49 +++++---
 60 files changed, 2392 insertions(+), 710 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h


--=-LpQ5LyfLLuGCju4IDxwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmEn/ccACgkQoUecoho8
xfq22w//cBdrplU7813n4WDxio/cXxqqlm69r72JY1Q3Yk8gU4EdyYt+Vyez17pZ
6PhHKr3Jn3rotrWi8m0Cq8MgbiHUnmssQ6r7gzYuWptLRoctQ/9hBqOZ8A1SQRl6
6n682w4OxylaInHJI/1CjKzIgtftyKpv7BC8FMg8KFcRQHbLoKghVQQBT8nu9uOJ
XmrKTZb0n+2A22hwjBlJ7KD7kake17ANELWMQn6xHjootyoW7soyJ4nPmC9n4M+A
Hd3tJ7Proc5RkFoNeqOjVGEHXcCN4DZty00ejkPkuFbxW1yAccYubYCDMTRg4Ff1
Yio6sK41T5KPYYZO/cgcig2eSVbqtRJNNAplq9zEProfn867V1efoqc9QZiX5bBF
5bgbu0RjT+OOS/2QsExDv09DL+IETOgDW76834hAHJpPONVs+zOL4O3e7HDYvF1C
UjdKd6PIIrd18IDUxbRzFIgMtC/t37Qo92oGzHLPMl3RBcQfvcvEjgoCq2TW/9jH
c0s2mIZg0x4N8ivMPG8AS83KFS/O+Nl+3JiIKd6wOUPSxepnJ23FWqFXTCLuaSjS
MLOOtawDLFdL7WoOfLlfC7eDBKXfblsQZYwAdatQIuYPMGaz9+11k71wx+x85P/h
VHSd8NEwh3mfalOH9VZri1vaYv2lKK8FTR/6ZZTq6CGHoiahEbM=
=0ksb
-----END PGP SIGNATURE-----

--=-LpQ5LyfLLuGCju4IDxwB--

