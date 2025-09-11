Return-Path: <linux-wireless+bounces-27239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20000B52DF5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DD5567808
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Sep 2025 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CD030E846;
	Thu, 11 Sep 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="f+wQ1rFt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B032E8E0E;
	Thu, 11 Sep 2025 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757585347; cv=none; b=lCe/qu5ahDcn0VlI4FWFGs3e9SQTsPzMTR6UyL/XYWlr6i3OfWgrVjqb4nx5ZbFSUa+zBHXl6tv9wFvkyCstMgo6J6ImNbY2bGS8QQQYEYvkdGFmCQUF0ZwHFmDPhXAAW0GnVWr1uRVSKPcnz4+X/DCcAnx0lKYcxHVunkSoerc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757585347; c=relaxed/simple;
	bh=aq66geDYlF4SXS6B1Svh/JQo5uWi6OJnvSpxRRbGWHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0vW6lp7BK3SFs1SCSnKg1mmZC3NJoWXkMb+HIS/Hx+WXsgRQmEhrPFYdHEJWPDiC3KT4FODd8zNCY3aStzVRgqVaZ4atZ/bqRMSUToNu2MxN74UYVVrG5zepyhlAlYTE02MbUJczGVnoODX1iuuq39LySMLPs3ApBIrTYYJ2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=f+wQ1rFt; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=JYP9UC/sikMBPgwznbzRwF6ddBmv1Lk6OVEOYPVJJf4=; t=1757585345; x=1758794945; 
	b=f+wQ1rFt4hu8gqV198wY8r9ZMb1Wm58WvpQm37+DNN5aqYHK9DXRfsPIY8LwHjZHCEVkOKnudCF
	cpvCteS8T1qkHU/RJgzgzQGF83NNO+ejgo8FsJz9XCLeu1SRb/u7yZLmKno/+hCdCerzxzAZDD02I
	2Zx8PadaKwG9t6zJlFz+Q6JAiH6ZUmXrG8+PqUeoUpJ1jWUCaVwLL/BCdcunlt3QCBVAAy4PBcjiz
	uabwZ2XIEWz7hThIhNLC342g+umfd+ggsS6KncVkyyGoo940XbUc2l+zJJH308z1yNSfdt7kUCC5w
	gCPJlNidNULTZzOyaQb+QlKAK77JSSE5CTZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uweEb-0000000F4QL-122t;
	Thu, 11 Sep 2025 12:08:57 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-09-11
Date: Thu, 11 Sep 2025 12:08:28 +0200
Message-ID: <20250911100854.20445-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And a bunch of changes for -next, though that doesn't look
like it'll be quieting down just yet.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit d23ad54de795ec0054f90ecb03b41e8f2c410f3a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-08-29 11:48:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-09-11

for you to fetch changes up to 1b2e9feb351435299863b5e7ebeb02634381c883:

  wifi: mwifiex: fix endianness handling in mwifiex_send_rgpower_table (2025-09-11 08:53:43 +0200)

----------------------------------------------------------------
Plenty of things going on, notably:
 - iwlwifi: major cleanups/rework
 - brcmfmac: gets AP isolation support
 - mac80211: gets more S1G support

----------------------------------------------------------------
Aditya Kumar Singh (3):
      wifi: cfg80211: fix return value in cfg80211_get_radio_idx_by_chan()
      wifi: mac80211: simplify return value handling of cfg80211_get_radio_idx_by_chan()
      wifi: mac80211: consider links for validating SCAN_FLAG_AP in scan request during MLO

Arend van Spriel (3):
      wifi: nl80211: allow drivers to support subset of NL80211_CMD_SET_BSS
      wifi: drivers: indicate support for attributes in NL80211_CMD_SET_BSS
      wifi: nl80211: strict checking attributes for NL80211_CMD_SET_BSS

Dan Carpenter (1):
      wifi: mwifiex: fix double free in mwifiex_send_rgpower_table()

Daniel Gabay (1):
      wifi: iwlwifi: mld: add few missing hcmd/notif names

Darshan Rathod (1):
      wifi: brcmfmac: avoid assignment in if/else-if conditions in NVRAM load path

Gokul Sivakumar (1):
      wifi: brcmfmac: fix 43752 SDIO FWVID incorrectly labelled as Cypress (CYW)

Gustavo A. R. Silva (2):
      wifi: iwlegacy: Remove unused structs and avoid -Wflex-array-member-not-at-end warnings
      wifi: iwlwifi: mei: Remove unused flexible-array member in struct iwl_sap_hdr

Ilan Peer (1):
      wifi: mac80211: Fix HE capabilities element check

Itamar Shalev (2):
      wifi: iwlwifi: pcie: relocate finish_nic_init logic to gen1_2
      wifi: iwlwifi: simplify iwl_poll_prph_bit return value

Johannes Berg (6):
      wifi: iwlwifi: add a new FW file numbering scheme
      wifi: iwlwifi: iwl-config: include module.h
      wifi: iwlwifi: uefi: remove runtime check of constant values
      wifi: iwlwifi: acpi: make iwl_guid static
      Merge tag 'iwlwifi-next-2025-09-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next into HEAD
      Merge tag 'iwlwifi-next-2025-09-09' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Lachlan Hodges (3):
      wifi: mac80211: support block bitmap S1G TIM encoding
      wifi: mac80211: support parsing S1G TIM PVB
      wifi: mac80211: kunit: add kunit tests for S1G PVB decoding

Liao Yuanhong (1):
      wifi: iwlwifi: Remove redundant header files

Lorenzo Bianconi (1):
      wifi: mac80211: Make CONNECTION_MONITOR optional for MLO sta

Miaoqian Lin (1):
      wifi: iwlwifi: Fix dentry reference leak in iwl_mld_add_link_debugfs

Miri Korenblit (50):
      wifi: iwlwifi: mld: cleanup cipher lookup in resume
      wifi: iwlwifi: mvm: cleanup cipher lookup in resume
      wifi: iwlwifi: mld: support MLO rekey on resume
      wifi: iwlwifi: mld: track BIGTK per link
      wifi: iwlwifi: mvm/mld: correctly retrieve the keyidx from the beacon
      wifi: iwlwifi: mld/mvm: set beacon protection capability in wowlan config
      wifi: iwlwifi: mvm: remove a function declaration
      wifi: iwlwifi: bump MIN API in HR/GF/BZ/SC/DR
      Reapply "wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions"
      wifi: iwlwifi: make ppag versioning clear
      wifi: iwlwifi: mld: don't consider old versions of PPAG
      wifi: iwlwifi: mld: refactor iwl_mld_add_all_rekeys
      wifi: iwlwifi: mld: rename iwl_mld_set_key_rx_seq
      wifi: iwlwifi: mld: don't validate keys state on resume
      wifi: iwlwifi: mld: don't check the cipher on resume
      wifi: iwlwifi: mvm: remove d3 test code
      wifi: iwlwifi: remove dump file name extension support
      wifi: iwlwifi: trans: remove d3 test code
      wifi: iwlwifi: trans: remove STATUS_SUSPENDED
      wifi: iwlwifi: simplify iwl_trans_pcie_d3_resume
      wifi: iwlwifi: mld: don't modify trans state where not needed
      wifi: iwlwifi: refactor iwl_pnvm_get_from_fs
      wifi: iwlwifi: remove .pnvm files from module info
      wifi: iwlwifi: trans: move dev_cmd_pool to trans specific
      wifi: iwlwifi: don't publish TWT capabilities
      wifi: iwlwifi: remove unneeded jacket indication
      wifi: iwlwifi: really remove hw_wfpm_id
      wifi: iwlwifi: gen1_2: rename iwl_trans_pcie_op_mode_enter
      wifi: iwlwifi: gen1_2: move gen specific code to a function
      wifi: iwlwifi: mld: support TLC command version 5
      wifi: iwlwifi: pcie: remember when interrupts are disabled
      wifi: iwlwifi: mld: make iwl_mld_rm_vif void
      wifi: iwlwifi: carefully select the PNVM source
      wifi: iwlwifi: mld: remove a TODO
      wifi: iwlwifi: don't support WH a step
      wifi: mac80211: count reg connection element in the size
      wifi: mac80211: reduce the scope of link_id
      wifi: mac80211: reduce the scope of rts_threshold
      wifi: iwlwifi: rename iwl_finish_nic_init
      wifi: iwlwifi: pcie: move pm_support to the specific transport
      wifi: iwlwifi: pcie: move ltr_enabled to the specific transport
      wifi: iwlwifi: api: add a flag to iwl_link_ctx_modify_flags
      wifi: iwlwifi: mld: don't consider phy cmd version 5
      wifi: iwlwifi: mld: remove support of mac cmd ver 2
      wifi: iwlwifi: mld: remove support of roc cmd version 5
      wifi: iwlwifi: mld: remove support from of sta cmd version 1
      wifi: iwlwifi: mld: remove support of iwl_esr_mode_notif version 1
      wifi: iwlwifi: mld: CHANNEL_SURVEY_NOTIF is always supported
      wifi: cfg80211: update the time stamps in hidden ssid
      wifi: mac80211: fix incorrect comment

Muna Sinada (1):
      wifi: nl80211: Add EHT fixed Tx rate support

Nidhish A N (1):
      wifi: iwlwifi: fw: Add ASUS to PPAG and TAS list

Pagadala Yesu Anjaneyulu (2):
      wifi: iwlwifi: mvm: remove MLO code
      wifi: iwlwifi: add kunit tests for nvm parse

Ramya Gnanasekar (1):
      wifi: mac80211: Fix 6 GHz Band capabilities element advertisement in lower bands

Rotem Kerem (3):
      wifi: iwlwifi: add STATUS_FW_ERROR API
      wifi: iwlwifi: replace SUPPRESS_CMD_ERROR_ONCE status bit with a boolean
      wifi: iwlwifi: implement wowlan status notification API update

Sarika Sharma (2):
      wifi: mac80211: fix reporting of all valid links in sta_set_sinfo()
      wifi: mac80211: add tx_handlers_drop statistics to ethtool

Somashekhar Puttagangaiah (2):
      wifi: iwlwifi: mld: trigger mlo scan only when not in EMLSR
      wifi: iwlwifi: mld: Add debug log for second link

Stefan Kerkmann (3):
      wifi: mwifiex: add rgpower table loading support
      wifi: mwifiex: send world regulatory domain to driver
      wifi: mwifiex: fix endianness handling in mwifiex_send_rgpower_table

Steven Rostedt (1):
      wifi: cfg80211: Remove unused tracepoints

Wright Feng (1):
      wifi: brcmfmac: support AP isolation to restrict reachability between stations

Yang Li (1):
      wifi: iwlwifi: Remove duplicated include in trans.c

Zheng tan (1):
      wifi: cfg80211: Remove the redundant wiphy_dev

 drivers/net/wireless/ath/carl9170/rx.c             |   2 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |   1 +
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |   2 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |  23 +
 .../wireless/broadcom/brcm80211/brcmfmac/chip.c    |   4 +-
 .../broadcom/brcm80211/brcmfmac/firmware.c         |  14 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   8 +-
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |   1 -
 drivers/net/wireless/intel/iwlegacy/iwl-spectrum.h |  24 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |  18 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |  13 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |  22 +-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  18 +-
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |   2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/dvm/power.c     |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |   2 -
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     | 113 ++-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   3 +
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |  34 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |  35 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  43 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |  54 +-
 drivers/net/wireless/intel/iwlwifi/fw/error-dump.h |   3 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c       |  81 ++-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  53 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   1 -
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |   2 -
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |   7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |  40 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  47 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |  95 +--
 drivers/net/wireless/intel/iwlwifi/iwl-io.h        |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  80 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.h |  74 ++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |  71 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  81 +--
 drivers/net/wireless/intel/iwlwifi/mei/sap.h       |   2 -
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        | 555 +++++++++-----
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.c     |  39 +-
 drivers/net/wireless/intel/iwlwifi/mld/iface.h     |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |  38 +
 drivers/net/wireless/intel/iwlwifi/mld/key.h       |   7 +
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  26 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   2 +
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c  |  19 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   4 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  34 +-
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   1 -
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    |  28 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c       |  10 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  26 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c       |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/stats.c     |  11 +-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c       |  75 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      | 131 ----
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |  20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 382 ++--------
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |  94 ---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      | 809 ---------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  38 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 124 +---
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 138 +---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 136 +---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  53 --
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        | 133 ----
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  23 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      | 101 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |  89 ---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |  24 -
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   | 433 -----------
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   3 -
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  10 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   9 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |  53 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c | 237 ++++--
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/tests/Makefile  |   2 +-
 .../net/wireless/intel/iwlwifi/tests/nvm_parse.c   |  72 ++
 drivers/net/wireless/intersil/p54/txrx.c           |   2 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   7 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |   5 +
 drivers/net/wireless/marvell/mwifiex/main.h        |   3 +
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     | 113 +++
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |  58 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   7 -
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c          |   2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |   8 -
 include/linux/ieee80211.h                          | 265 ++++++-
 include/linux/mmc/sdio_ids.h                       |   2 +-
 include/net/cfg80211.h                             |  34 +-
 include/uapi/linux/nl80211.h                       |  51 +-
 net/mac80211/cfg.c                                 |  44 +-
 net/mac80211/chan.c                                |  11 -
 net/mac80211/ethtool.c                             |   6 +-
 net/mac80211/ieee80211_i.h                         |   9 +
 net/mac80211/main.c                                |  11 +-
 net/mac80211/mesh.c                                |   3 +
 net/mac80211/mesh_ps.c                             |   2 +-
 net/mac80211/mlme.c                                |  38 +-
 net/mac80211/sta_info.c                            |  13 +-
 net/mac80211/tests/Makefile                        |   2 +-
 net/mac80211/tests/s1g_tim.c                       | 356 +++++++++
 net/mac80211/tx.c                                  | 173 ++++-
 net/mac80211/util.c                                |  20 +-
 net/wireless/core.c                                |   9 +
 net/wireless/ethtool.c                             |   2 +-
 net/wireless/nl80211.c                             | 318 +++++++-
 net/wireless/scan.c                                |   9 +-
 net/wireless/trace.h                               |  56 --
 net/wireless/util.c                                |   2 +-
 123 files changed, 2915 insertions(+), 3863 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c
 create mode 100644 net/mac80211/tests/s1g_tim.c

