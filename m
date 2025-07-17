Return-Path: <linux-wireless+bounces-25597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C90AB089A5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61FF81A60D34
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 09:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF821DE3BB;
	Thu, 17 Jul 2025 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="TK/BF7VD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EBE33086;
	Thu, 17 Jul 2025 09:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745598; cv=none; b=tpsvWFoJPHsXGiKp7Ql1rGtJJFoPjYh38+7DhhxjDDVDcjMBDEbnpZKbrcOujr2C6qDAmz9YQG3nxeec9GLgUbNMaZrdonGkxcfiOPx0PS/eJs4EUsGD3BxJIIzM8xwVkm9gXYDQ6rGaDBjOQ23yXmb0Y7nk3VElQdz8qKpN/JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745598; c=relaxed/simple;
	bh=GRo6BqRDVlHbq/t471LD2soyGMfCA8eTw/hdnfLrUv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N8lO7TWOqDF7QISyd1ZcG1OsAGXOYhrO1PzusNB83NAwNhNReqcaev9xAW54Ehe4t1sZmDDEeGGOWiet9Oo31nuB5Py+4JK+Bh3LcexFksf/IKD2XZ2TNvCDFqSFnjwwAJIEAVUYnquuCSAXkFHQTrFnfxcaO3teSSi5ABNlBqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=TK/BF7VD; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=sNA0xIRmPN1ZnjdIGACVLF6KGztJoPFnWMptz+PKhqI=; t=1752745596; x=1753955196; 
	b=TK/BF7VDkQtYBwhh33kEHX2dkF/UWfEfDhwXXckwxEkrzPHC+AdkxsG6DHIb7MkOXOpXzqxJdnL
	HVyJ4iAfZZd5dzGHVrrL7HHBIvvHWNP8YNLhUbtWTy/Mn5kZq0FwsfxiVkfQg27KBGpnstUgSxg4K
	+gwNNb4IuS6XBE3f1/V/ROs1bbC3mq0huPlUl9pi5wS552rwO4+oqJLXy/zV5lqBL4zceRbDMeBee
	+nin/k4693nUW/LEg5LCUfsve/0UucVgPOLPrZwbkJRGDUPeBJsgU4QeDpploR9G+ejd5HmsP5UHp
	9fjti72aj66fCeTZujH3YmFjakYn9hDy/nRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1ucLBx-0000000AHJk-19li;
	Thu, 17 Jul 2025 11:46:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: [GIT PULL] wireless-next-2025-07-17
Date: Thu, 17 Jul 2025 11:38:02 +0200
Message-ID: <20250717094610.20106-47-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

And here's another set of changes for net-next. There will
be a merge conflict with the material I just sent for net
due to the BIOS workaround/fix, the resolution should just
take the -next version.

Next week we'll have some more changes (Jeff announced, and
I have some things pending in patchwork), but things are
clearly winding down (as they well should.) This is mostly
now to fix the double-free and RCU regressions.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 0cad34fb7c5d12a9b61862744e7130e9ce3bc58f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-07-11 11:42:38 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-07-17

for you to fetch changes up to 003322be55c650b30f0c836e1dc99d708d787a32:

  Merge tag 'iwlwifi-next-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2025-07-15 13:21:09 +0200)

----------------------------------------------------------------
Another set of changes, notably:
 - cfg80211: fix double-free introduced earlier
 - mac80211: fix RCU iteration in CSA
 - iwlwifi: many cleanups (unused FW APIs, PCIe code, WoWLAN)
 - mac80211: some work around how FIPS affects wifi, which was
             wrong (RC4 is used by TKIP, not only WEP)
 - cfg/mac80211: improvements for unsolicated probe response
                 handling

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: cfg80211: fix off channel operation allowed check for MLO

Alex Gavin (1):
      wifi: mac80211_hwsim: Update comments in header

Avraham Stern (4):
      wifi: iwlwifi: mvm: fix scan request validation
      wifi: iwlwifi: mld: fix scan request validation
      wifi: iwlwifi: mld: update the P2P device mac before starting the GO
      wifi: iwlwifi: mld: update expected range response notification version

Emmanuel Grumbach (1):
      wifi: iwlwifi: mld: support iwl_omi_send_status_notif version 2

Ilan Peer (2):
      wifi: cfg80211: Fix interface type validation
      wifi: mac80211_hwsim: Declare support for AP scanning

Itamar Shalev (3):
      wifi: iwlwifi: simplify iwl_poll_bits_mask return value
      wifi: iwlwifi: pcie: inform me when op mode leaving
      wifi: iwlwifi: trans: remove retake_ownership parameter from sw_reset

Johannes Berg (15):
      wifi: iwlwifi: pcie: accept new devices for MVM-only configs
      wifi: iwlwifi: mvm: remove regulatory puncturing setup
      wifi: iwlwifi: mld: restrict puncturing disable to FM
      wifi: iwlwifi: fix HE/EHT capabilities
      wifi: iwlwifi: pcie: don't WARN on bad firmware input
      wifi: iwlwifi: mvm: remove extra link ID
      wifi: iwlwifi: mvm/mld: use average RSSI for beacons
      wifi: mac80211: make VHT opmode NSS ignore a debug message
      wifi: mac80211: don't unreserve never reserved chanctx
      wifi: mac80211: remove ieee80211_link_unreserve_chanctx() return value
      wifi: mac80211: don't send keys to driver when fips_enabled
      wifi: mac80211: clean up cipher suite handling
      wifi: mac80211: simplify __ieee80211_rx_h_amsdu() loop
      wifi: mac80211: don't use TPE data from assoc response
      Merge tag 'iwlwifi-next-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

Maharaja Kennadyrajan (1):
      wifi: mac80211: use RCU-safe iteration in ieee80211_csa_finish

Miri Korenblit (27):
      wifi: iwlwifi: handle non-overlapping API ranges
      wifi: iwlwifi: assign a FW API range for JF
      wifi: iwlwifi: bump minimum API version for SO/MA/TY
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v2
      wifi: iwlwifi: add a reference to iwl_wowlan_info_notif_v3
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v12
      wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v9
      wifi: iwlwifi: assign a FW API range for HR
      wifi: iwlwifi: assign a FW API range for GF
      wifi: iwlwifi: pcie: add a missing include
      wifi: iwlwifi: mvm: set gtk id also in older FWs
      wifi: iwlwifi: mvm: always set the key idx in gtk_seq
      wifi: iwlwifi: mvm: don't remove all keys in mcast rekey
      wifi: iwlwifi: mld: don't remove all keys in mcast rekey
      wifi: iwlwifi: mvm: remove support for REDUCE_TX_POWER_CMD ver 6 and 7
      wifi: iwlwifi: mld: remove support for REDUCE_TX_POWER_CMD ver 9
      wifi: iwlwifi: remove an unused struct
      wifi: iwlwifi: mld: remove support for iwl_geo_tx_power_profiles_cmd version 4
      wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: add kunit test for emlsr with bt on"
      wifi: iwlwifi: mld: Revert "wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON"
      wifi: iwlwifi: mld: remove support for iwl_mcc_update_resp versions
      wifi: iwlwifi: remove support of versions 4 and 5 of iwl_alive_ntf
      wifi: iwlwifi: remove support of version 4 of iwl_wowlan_rsc_tsc_params_cmd
      wifi: iwlwifi: remove support of several iwl_ppag_table_cmd versions
      wifi: mac80211: only assign chanctx in reconfig
      wifi: mac80211: don't mark keys for inactive links as uploaded
      wifi: mac80211: handle WLAN_HT_ACTION_NOTIFY_CHANWIDTH async

Pagadala Yesu Anjaneyulu (3):
      wifi: iwlwifi: add support for accepting raw DSM tables by firmware
      wifi: iwlwifi: mvm: remove IWL_MVM_ESR_EXIT_FAIL_ENTRY
      wifi: iwlwifi: mvm: Add dump handler to iwl_mvm

Rotem Kerem (3):
      wifi: iwlwifi: add suppress_cmd_error_once() API
      wifi: iwlwifi: add iwl_trans_device_enabled() API
      wifi: iwlwifi: add iwl_trans_is_dead() API

Sarika Sharma (1):
      wifi: cfg80211: fix double free for link_sinfo in nl80211_station_dump()

Thomas Fourier (1):
      mwl8k: Add missing check after DMA map

Yuvarani V (2):
      wifi: cfg80211: parse attribute to update unsolicited probe response template
      wifi: mac80211: parse unsolicited broadcast probe response data

 drivers/net/wireless/intel/iwlwifi/Makefile        |   1 +
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |  24 ---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |  34 +----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   9 --
 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c     |  31 ++++
 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c     |  49 +++++-
 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c     |  29 +++-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |  13 --
 drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c    |  12 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |  15 --
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     | 114 --------------
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |  20 ++-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   1 +
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |  81 +---------
 drivers/net/wireless/intel/iwlwifi/fw/api/rx.h     |  24 ++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/debugfs.c    |   6 +
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |  55 ++++---
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   4 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  10 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  78 ++--------
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  17 ++-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c        |  24 ++-
 drivers/net/wireless/intel/iwlwifi/mld/coex.c      |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c        | 112 +++++---------
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c       |  12 ++
 drivers/net/wireless/intel/iwlwifi/mld/link.c      |  50 +++++-
 drivers/net/wireless/intel/iwlwifi/mld/link.h      |   6 +
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c       |  66 ++------
 drivers/net/wireless/intel/iwlwifi/mld/mld.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c       |  68 ++-------
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h       |   4 -
 drivers/net/wireless/intel/iwlwifi/mld/notif.c     |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/power.c     |  10 +-
 .../net/wireless/intel/iwlwifi/mld/regulatory.c    | 102 +++++--------
 drivers/net/wireless/intel/iwlwifi/mld/rx.c        |  73 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c      |   2 +-
 .../net/wireless/intel/iwlwifi/mld/tests/Makefile  |   2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c        | 140 -----------------
 .../intel/iwlwifi/mld/tests/link-selection.c       |   6 -
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        | 169 +++++++--------------
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  67 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |  62 +-------
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  34 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  21 +--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  31 +---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |  64 +++-----
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  24 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  91 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |  25 +--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   4 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/internal.h  |   1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c         |  20 +++
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c |  12 +-
 .../net/wireless/intel/iwlwifi/pcie/gen1_2/tx.c    |  13 +-
 drivers/net/wireless/intel/iwlwifi/pcie/utils.h    |   2 +
 drivers/net/wireless/marvell/mwl8k.c               |   4 +
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   3 +-
 drivers/net/wireless/virtual/mac80211_hwsim.h      |  14 +-
 include/net/cfg80211.h                             |   6 +-
 net/mac80211/cfg.c                                 |  14 +-
 net/mac80211/chan.c                                |  18 +--
 net/mac80211/driver-ops.c                          |   5 +-
 net/mac80211/driver-ops.h                          |   4 +
 net/mac80211/ht.c                                  |  40 ++++-
 net/mac80211/ieee80211_i.h                         |  25 ++-
 net/mac80211/iface.c                               |  29 ++++
 net/mac80211/key.c                                 |   3 +-
 net/mac80211/main.c                                |  65 ++------
 net/mac80211/mlme.c                                |  36 ++++-
 net/mac80211/rx.c                                  |  58 ++-----
 net/mac80211/vht.c                                 |   5 +-
 net/wireless/nl80211.c                             |  51 ++++++-
 83 files changed, 1039 insertions(+), 1352 deletions(-)
 delete mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c

