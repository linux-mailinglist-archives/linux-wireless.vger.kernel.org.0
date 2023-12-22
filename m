Return-Path: <linux-wireless+bounces-1247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B467781C8D6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 12:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3014E1F23520
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEEE156F8;
	Fri, 22 Dec 2023 11:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYEWD3x5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128C7156C6;
	Fri, 22 Dec 2023 11:11:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B6CC433C8;
	Fri, 22 Dec 2023 11:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703243488;
	bh=9DfJ+kswQtZa5GxBeRvvqb0ngMLDtO7kuACCsoo3gHA=;
	h=From:Subject:To:Cc:Date:From;
	b=dYEWD3x5LR1w7C387Pf0UYPY720u6+oMgf6/3lS4jSVkLJ+TL3uTbPFHMcClP8RmQ
	 2PFUEjgdCN9Th14U7Vqa3a7i0YGqAEJH6qP4+WKUS30waJ8aJP0OWET3RWaQkEMCzT
	 K5x4zxFqxna4M9aPW0FvM+WYCdOAvChc5YmlHSGgG/gzF8ptHhR1i8OeMa3owic5Cd
	 g6dYTr4uRI2bVIMYh0PRB9487KgmQGgrALLREMXLUVDRN98OcI9lOZVfymX32kAsvM
	 iV6EHwjqpTMBm0E6TbQ3Q2YsVTsOGwUDQLhlYJp8cE0yz6jAin0/HGNiq36q6t8fuB
	 ALVRE3ClMihrA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2023-12-22
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20231222111128.16B6CC433C8@smtp.kernel.org>
Date: Fri, 22 Dec 2023 11:11:27 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit c49b292d031e385abf764ded32cd953c77e73f2d:

  Merge tag 'for-netdev' of https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2023-12-18 16:46:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2023-12-22

for you to fetch changes up to 968509128207f122d7177ffb6ff51c9c6fa7e13d:

  wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP (2023-12-21 20:35:17 +0100)

----------------------------------------------------------------
wireless-next patches for v6.8

The third "new features" pull request for v6.8. This is a smaller one
to clear up our tree before the break and nothing really noteworthy
this time.

Major changes:

stack

* cfg80211: introduce cfg80211_ssid_eq() for SSID matching

* cfg80211: support P2P operation on DFS channels

* mac80211: allow 64-bit radiotap timestamps

iwlwifi

* AX210: allow concurrent P2P operation on DFS channels

----------------------------------------------------------------
Andrei Otcheretianski (7):
      wifi: cfg80211: reg: Support P2P operation on DFS channels
      wifi: cfg80211: Schedule regulatory check on BSS STA channel change
      wifi: mac80211: Schedule regulatory channels check on bandwith change
      wifi: mac80211_hwsim: Add custom reg for DFS concurrent
      wifi: iwlwifi: mvm: Allow DFS concurrent operation
      wifi: iwlwifi: Don't mark DFS channels as NO-IR
      wifi: iwlwifi: replace ENOTSUPP with EOPNOTSUPP

Anjaneyulu (1):
      wifi: iwlwifi: fix out of bound copy_from_user

Ayala Beker (1):
      wifi: mac80211: fix advertised TTLM scheduling

Benjamin Berg (3):
      wifi: cfg80211: free beacon_ies when overridden from hidden BSS
      wifi: cfg80211: ensure cfg80211_bss_update frees IEs on error
      wifi: cfg80211: avoid double free if updating BSS fails

Ching-Te Ku (11):
      wifi: rtw89: coex: Fix wrong Wi-Fi role info and FDDT parameter members
      wifi: rtw89: coex: Record down Wi-Fi initial mode information
      wifi: rtw89: coex: Add Pre-AGC control to enhance Wi-Fi RX performance
      wifi: rtw89: coex: Update BTG control related logic
      wifi: rtw89: coex: Still show hardware grant signal info even Wi-Fi is PS
      wifi: rtw89: coex: Update coexistence policy for Wi-Fi LPS
      wifi: rtw89: coex: Set Bluetooth scan low-priority when Wi-Fi link/scan
      wifi: rtw89: coex: Add Bluetooth RSSI level information
      wifi: rtw89: coex: Update RF parameter control setting logic
      wifi: rtw89: coex: Translate antenna configuration from ID to string
      wifi: rtw89: coex: To improve Wi-Fi performance while BT is idle

David Lin (1):
      wifi: mwifiex: fix uninitialized firmware_stat

Dmitry Antipov (3):
      wifi: cfg80211: introduce cfg80211_ssid_eq()
      wifi: mwifiex: use cfg80211_ssid_eq() instead of mwifiex_ssid_cmp()
      wifi: rtw88: use cfg80211_ssid_eq() instead of rtw_ssid_equal()

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: use the new command to clear the internal buffer

Ilan Peer (1):
      wifi: iwlwifi: mvm: Do not warn if valid link pair was not found

Johannes Berg (7):
      wifi: mac80211: rework RX timestamp flags
      wifi: mac80211: allow 64-bit radiotap timestamps
      wifi: iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request
      wifi: iwlwifi: mvm: send TX path flush in rfkill
      wifi: iwlwifi: mvm: d3: avoid intermediate/early mutex unlock
      wifi: iwlwifi: mvm: add US/Canada MCC to API
      wifi: iwlwifi: mvm: disallow puncturing in US/Canada

Jonathan Corbet (2):
      wifi: cfg80211: address several kerneldoc warnings
      wifi: mac80211: address some kerneldoc warnings

Jouni Malinen (1):
      wifi: mac80211: Skip association timeout update after comeback rejection

Miri Korenblit (4):
      wifi: mac80211_hwsim: support HE 40 MHz in 2.4 GHz band
      wifi: mac80211: add a driver callback to check active_links
      wifi: iwlwifi: assign phy_ctxt before eSR activation
      wifi: iwlwifi: cleanup BT Shared Single Antenna code

Mukesh Sisodiya (2):
      wifi: cfg80211: handle UHB AP and STA power type
      wifi: iwlwifi: Add rf_mapping of new wifi7 devices

Ping-Ke Shih (2):
      wifi: rtw89: mac: add sys_init and filter option for WiFi 7 chips
      wifi: rtw89: mac: implement to configure TX/RX engines for WiFi 7 chips

Su Hui (11):
      wifi: rtlwifi: add calculate_bit_shift()
      wifi: rtlwifi: rtl8821ae: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
      wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
      wifi: rtlwifi: rtl8723_common: using calculate_bit_shift()
      wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

Zenm Chen (1):
      wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

 drivers/net/wireless/ath/ath10k/htt_rx.c           |    2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/debug.h  |    6 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    9 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    4 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    1 -
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       |    2 +
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   15 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |    7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   16 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |   11 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |    2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   10 +
 drivers/net/wireless/marvell/mwifiex/join.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    1 -
 drivers/net/wireless/marvell/mwifiex/scan.c        |   11 -
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    2 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    4 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   12 +
 .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   |   14 +-
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.c |   12 +-
 .../wireless/realtek/rtlwifi/rtl8192c/phy_common.h |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.c   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192cu/phy.c   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |   15 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c   |   15 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |    4 +-
 .../realtek/rtlwifi/rtl8723com/phy_common.c        |   12 +-
 .../realtek/rtlwifi/rtl8723com/phy_common.h        |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |   15 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |    7 +
 drivers/net/wireless/realtek/rtw88/fw.c            |    4 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   12 -
 drivers/net/wireless/realtek/rtw89/coex.c          |  640 +++++++++---
 drivers/net/wireless/realtek/rtw89/coex.h          |   38 +
 drivers/net/wireless/realtek/rtw89/core.h          |   23 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        | 1072 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h           |  541 ++++++++++
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   25 +
 include/linux/ieee80211.h                          |    1 +
 include/net/cfg80211.h                             |   46 +-
 include/net/mac80211.h                             |   38 +-
 include/uapi/linux/nl80211.h                       |   29 +
 net/mac80211/driver-ops.h                          |   20 +
 net/mac80211/ieee80211_i.h                         |    6 +-
 net/mac80211/link.c                                |    3 +
 net/mac80211/mlme.c                                |   61 +-
 net/mac80211/rx.c                                  |   13 +-
 net/mac80211/trace.h                               |   25 +
 net/mac80211/util.c                                |   16 +-
 net/wireless/chan.c                                |   94 +-
 net/wireless/nl80211.c                             |   24 +
 net/wireless/reg.c                                 |    8 +-
 net/wireless/reg.h                                 |    5 +
 net/wireless/scan.c                                |   79 +-
 net/wireless/sme.c                                 |    2 +
 67 files changed, 2733 insertions(+), 419 deletions(-)


