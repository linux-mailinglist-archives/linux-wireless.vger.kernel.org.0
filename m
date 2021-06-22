Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6140B3B076C
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 16:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhFVOeO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 10:34:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48560 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230047AbhFVOeN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 10:34:13 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=[192.168.100.150])
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lvhRN-001azP-SH; Tue, 22 Jun 2021 17:31:52 +0300
Message-ID: <12cde492bacfa8ae6aa1f02d3c5a0dfa241ac576.camel@coelho.fi>
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Date:   Tue, 22 Jun 2021 17:31:48 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-Md9O3RTY2K6QgiueeIpd"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: pull-request: iwlwifi-next 2021-06-22
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--=-Md9O3RTY2K6QgiueeIpd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

Here's my pull request for v5.14 with the four patchesets I sent
earlier.  This is all normal development, new features, bugfixes and
cleanups.  More details about the contents in the tag description.

Please let me know if there are any issues.

Cheers,
Luca.


The following changes since commit adf6a0f8c0a656df3d29403f314bf3e0dbb2dd77=
:

  rtl8xxxu: avoid parsing short RX packet (2021-06-19 12:06:09 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git ta=
gs/iwlwifi-next-for-kalle-2021-06-22

for you to fetch changes up to 4c59eac6ac434e08b65edd3d4bef41adfa90f58e:

  iwlwifi: bump FW API to 64 for AX devices (2021-06-22 16:57:58 +0300)

----------------------------------------------------------------
iwlwifi patches for v5.14

* Some robustness improvements in the PCI code;
* Remove some duplicate and unused declarations;
* Improve PNVM load robustness by increasing the timeout a bit;
* Support for a new HW;
* Suport for BIOS control of 11ax enablement in Russia;
* Support UNII4 enablement from BIOS;
* Support LMR feedback;
* Fix in TWT;
* Some fixes in IML (image loader) DMA handling;
* Fixes in WoWLAN;
* Updates in the WoWLAN FW commands;
* Add one new device to the PCI ID lists;
* Support reading PNVM from a UEFI variable;
* Bump the supported FW API version;
* Some other small fixes, clean-ups and improvements.

----------------------------------------------------------------
Abhishek Naik (1):
      iwlwifi: mvm: Read acpi dsm to get unii4 enable/disable bitmap.

Avraham Stern (1):
      iwlwifi: mvm: support LMR feedback

Emmanuel Grumbach (5):
      iwlwifi: mvm: support LONG_GROUP for WOWLAN_GET_STATUSES version
      iwlwifi: mvm: introduce iwl_proto_offload_cmd_v4
      iwlwifi: mvm: update iwl_wowlan_patterns_cmd
      iwlwifi: mvm: introduce iwl_wowlan_kek_kck_material_cmd_v4
      iwlwifi: mvm: introduce iwl_wowlan_get_status_cmd

Harish Mitty (1):
      iwlwifi: mvm: Call NMI instead of REPLY_ERROR

Ilan Peer (1):
      iwlwifi: mvm: Explicitly stop session protection before unbinding

Johannes Berg (18):
      iwlwifi: mvm: don't change band on bound PHY contexts
      iwlwifi: pcie: handle pcim_iomap_table() failures better
      iwlwifi: pcie: print interrupt number, not index
      iwlwifi: pcie: remove CSR_HW_RF_ID_TYPE_CHIP_ID
      iwlwifi: remove duplicate iwl_ax201_cfg_qu_hr declaration
      iwlwifi: pcie: identify the RF module
      iwlwifi: mvm: don't request SMPS in AP mode
      iwlwifi: mvm: apply RX diversity per PHY context
      iwlwifi: mvm: honour firmware SMPS requests
      iwlwifi: correct HE capabilities
      iwlwifi: pcie: fix some kernel-doc comments
      iwlwifi: pcie: remove TR/CR tail allocations
      iwlwifi: pcie: free IML DMA memory allocation
      iwlwifi: pcie: fix context info freeing
      iwlwifi: mvm: fill phy_data.d1 for no-data RX
      iwlwifi: pcie: free some DMA memory earlier
      iwlwifi: move error dump to fw utils
      iwlwifi: fw: dump TCM error table if present

Luca Coelho (8):
      iwlwifi: mvm: pass the clock type to iwl_mvm_get_sync_time()
      iwlwifi: mvm: fix indentation in some scan functions
      iwlwifi: remove unused REMOTE_WAKE_CONFIG_CMD definitions
      iwlwifi: increase PNVM load timeout
      iwlwifi: fix NUM_IWL_UCODE_TLV_* definitions to avoid sparse errors
      iwlwifi: move UEFI code to a separate file
      iwlwifi: support loading the reduced power table from UEFI
      iwlwifi: bump FW API to 64 for AX devices

Matti Gottlieb (1):
      iwlwifi: pcie: Add support for AX231 radio module with Ma devices

Miri Korenblit (1):
      iwlwifi: mvm: support BIOS enable/disable for 11ax in Russia

Mukesh Sisodiya (1):
      iwlwifi: yoyo: support region TLV version 2

Naftali Goldstein (2):
      iwlwifi: mvm: don't request mac80211 to disable/enable sta's queues
      iwlwifi: support ver 6 of WOWLAN_CONFIGURATION and ver 10 of WOWLAN_G=
ET_STATUSES

Shaul Triebitz (2):
      iwlwifi: mvm: fix error print when session protection ends
      iwlwifi: advertise broadcast TWT support

ybaruch (1):
      iwlwifi: add 9560 killer device

 drivers/net/wireless/intel/iwlwifi/Makefile                |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c             |  16 +++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c              |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c               |  50 ++++++++-=
--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h               |  10 +++
 drivers/net/wireless/intel/iwlwifi/fw/api/commands.h       |   5 --
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h             | 110 +++++++++=
+++------------
 drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h       |  26 ++++++
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h        |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h        |  19 +++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c                |  47 ++-------=
--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h                |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c               | 418 +++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
 drivers/net/wireless/intel/iwlwifi/fw/file.h               |  25 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c               | 120 +++++++++=
-----------------
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h               |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c               | 262 +++++++++=
++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h               |  42 +++++++++=
+
 drivers/net/wireless/intel/iwlwifi/iwl-config.h            |   6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h |  20 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h               |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c           |  13 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c               |  11 +++
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c         | 138 +++++++++=
+++++++++------------
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h              |   4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h             |  20 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c                | 118 +++++++++=
+++++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs-vif.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c           |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c     |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c                |  44 +++++++--=
-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c          |  25 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h               |  20 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/offloading.c        |  26 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c               |  40 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c          |  26 ++++--
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c              |  10 +--
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c              |  14 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c               |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c        |  45 +++++++--=
-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c             | 357 +++++++--=
--------------------------------------------------------------------
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |  90 +++++++++=
++++++-----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c              |  19 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h         |  24 +++---
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c               |  34 --------
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c       |  78 +++++++++=
+++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c            |  39 ++++++++-
 47 files changed, 1637 insertions(+), 784 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dump.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/uefi.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/uefi.h


--=-Md9O3RTY2K6QgiueeIpd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF3LNfgb2BPWm68smoUecoho8xfoFAmDR9FQACgkQoUecoho8
xfpVOw/8DzPiqRINm6CZmPYGD2DWpAWeG6HzPdBWw+9FzMCEE2YPCDsflNcOYmim
7hCPvpfGWIzFhtH/rmbbwL4xUoHjQge+frMy1hA9URLaeI9OELlxkRIOaPKbOoF3
hDjRlee2OjeaC6Hm38EW0a7pTmN7mIBDe6rkgcThF6mjwinGXkPe/sBDf6GjQh9g
56xSFQ02ayIiQOVWaD8UtCJAUH8AyJrSVj1LGZxk3mrPbTNR8ZYXmo1jFkMoWO3L
/PC5goCnb4yOYu7PuTwXcbbc4eOwHXxTD57TKnWyRVnmV8mDQcnGFGY2zC52daJV
HZFTEUCvDWMhzdSjFNiGbFtkMKq1gHM+dqG/xyabb1OGVVk1VpapsDZLpp8cAmNA
YmcAfc+oggOeEq6w8NAtGiEQMP7vr1pPeWulk7mdYBxXo+lt2nVIpaElyyKLc4rz
XVYLFBHtDMaBQXKsigjqAKMXZk8akGYYbH4kxuRrxq/5u+jLXfJZTeSoJ/gmLjzC
NY5YnQylgXebj57gBXL32luL9mi6CIf2tqz9bEo574RUnDCXbf8XlZ5phMSz1xjr
2ZCbsp6RdX86A6PqEiE08ZIWmy99OtTzo7w45hoe/NgQ88CWAU5UQVVIQ5Mp74Zf
ihiF3xh0KPcUOfegzJhC8SeoGxmteDu3601cuuiZCQbS1jx8rC0=
=LtBu
-----END PGP SIGNATURE-----

--=-Md9O3RTY2K6QgiueeIpd--

