Return-Path: <linux-wireless+bounces-6765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BBA8B06C8
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 12:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020C928435A
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Apr 2024 10:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5090B158DDC;
	Wed, 24 Apr 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erte2xSF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2931D158DC9;
	Wed, 24 Apr 2024 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952883; cv=none; b=nvSYCtaBk4YTGL9X7J70rK8q2+HeKZcqkBxPLHrLys6aMRXlagEyWSglAvq8XDt8K3McERo08e+Y0c69RsVtWuSFKnmczL8lQIiRXvZob0PAJtdXJ9seCib4PhObmbFw2EXjaA0cZA31bLGXm8kZCXQvT5AGpo94eVfBDcvaXD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952883; c=relaxed/simple;
	bh=lz2thafF6ahyvIUTgV1Rjoc/rhrDKB+UdayI+K+jAO8=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=auv4UCBcuw9o2QOYF/TM+bVu/j4XRmEfycr10NV0jIs0blfd53KGQD7xzqVjMA22h+tctOuBbT3UiB5o9KnfkvK263Q59m8qdpPn150Eqs+sM5akSjtqJ7qq08WJ3AtEOhaNIfvW/18evsA96LUA1zie7ysorcZU0WVSS9thfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erte2xSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217AEC113CE;
	Wed, 24 Apr 2024 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713952882;
	bh=lz2thafF6ahyvIUTgV1Rjoc/rhrDKB+UdayI+K+jAO8=;
	h=From:Subject:To:Cc:Date:From;
	b=Erte2xSFvQfDXebuF+gmCgCsEd0oXkctTsM3kasQaXvEnASpw3UcU6evVG22804/E
	 jCjXIkJNpxjo975NA7b8qJ4lfCTvTwJ2XrOUciLrbXdX5ZNM3avsnfwPv7qg0k+B2g
	 7GyMawe0PqW2AZzdgmPRbpd78jY6t0l8rv5Io02kX2G893UUFspVbziIgWs1TiaV3H
	 izAzbt+F3mlnHdWkQkP2YmqhLRyf+5nDmqDPxb/cOe8TY4EMd5HnABr9ivfcVxWA5s
	 /t2PRG2vZd7cG6lvzobtuR4AytxYliLzdCWgYUXnpZFIuyHDtTaz6irJPn2qNUtcqD
	 v0JC6OpRiMwzA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-04-24
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240424100122.217AEC113CE@smtp.kernel.org>
Date: Wed, 24 Apr 2024 10:01:21 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 57a03d83f229126b0aab6f305821358755c7b130:

  Merge branch 'mlxsw-preparations-for-improving-performance' (2024-04-03 19:50:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-04-24

for you to fetch changes up to b0d2d8f996c1ce3d4c8a1c8cb7d634536e7c2118:

  wifi: mac80211: handle link ID during management Tx (2024-04-19 10:54:58 +0200)

----------------------------------------------------------------
wireless-next patches for v6.10

The second "new features" pull request for v6.10 with changes both in
stack and in drivers. This time the pull request is rather small and
nothing special standing out except maybe that we have several
kernel-doc fixes. Great to see that we are getting warning free
wireless code (until new warnings are added).

Do note that this pull request has a simple conflict in mac80211 with
net tree, here's an example conflict resolution:

https://lore.kernel.org/all/20240422105623.7b1fbda2@canb.auug.org.au/

Major changes:

rtl8xxxu:

* enable Management Frame Protection (MFP) support

rtw88:

* disable unsupported interface type of mesh point for all chips, and only
  support station mode for SDIO chips.

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211: handle sdata->u.ap.active flag with MLO

Alexis Lothoré (2):
      wifi: wilc1000: set atomic flag on kmemdup in srcu critical section
      wifi: wilc1000: convert list management to RCU

Anjaneyulu (4):
      wifi: iwlwifi: move WTAS macro to api file
      wifi: iwlwifi: move lari_config handlig to regulatory
      wifi: iwlwifi: mvm: Add support for PPAG cmd v6
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD v10

Benjamin Berg (2):
      wifi: iwlwifi: mvm: move phy band to nl80211 band helper
      wifi: mac80211: keep mac80211 consistent on link activation failure

Chaitanya Tata (1):
      wifi: mac80211_hwsim: Use wider regulatory for custom for 6GHz tests

Chia-Yuan Li (2):
      wifi: rtw89: disable txptctrl IMR to avoid flase alarm
      wifi: rtw89: download firmware with five times retry

Chih-Kang Chang (1):
      wifi: rtw89: 8922a: update scan offload H2C fields

Ching-Te Ku (1):
      wifi: rtw88: coex: Prevent doing I/O during Wi-Fi power saving

Colin Ian King (1):
      wifi: brcmfmac: Fix spelling mistake "ivalid" -> "invalid"

Dmitry Antipov (2):
      wifi: rtlwifi: drop WMM stubs from rtl8192cu
      wifi: rtlwifi: always assume QoS mode in rtl8192cu

Emmanuel Grumbach (2):
      wifi: iwlwifi: add a device ID for BZ-W
      wifi: iwlwifi: mvm: introduce esr_disable_reason

Ilan Peer (1):
      wifi: iwlwifi: mvm: Refactor tracking of scan UIDs

Jeff Johnson (4):
      wifi: mac80211: correctly document struct mesh_table
      wifi: mac80211: remove ieee80211_set_hw_80211_encap()
      wifi: mac80211: Add missing return value documentation
      wifi: cfg80211: fix cfg80211 function kernel-doc

Johannes Berg (8):
      wifi: mac80211: transmit deauth only if link is available
      wifi: iwlwifi: mvm: extend STEP URM workaround for new devices
      wifi: iwlwifi: mvm: init vif works only once
      wifi: mac80211: reserve chanctx during find
      wifi: mac80211: simplify ieee80211_assign_link_chanctx()
      wifi: mac80211: add return docs for sta_info_flush()
      wifi: cfg80211: make some regulatory functions void
      wifi: cfg80211: add return docs for regulatory functions

Kalle Valo (1):
      Merge tag 'rtw-next-2024-04-04' of https://github.com/pkshih/rtw

Krzysztof Kozlowski (4):
      wifi: rsi: sdio: simplify module initialization
      wifi: wl1251: simplify module initialization
      wifi: wilc1000: replace open-coded module_sdio_driver()
      wifi: mwifiex: replace open-coded module_sdio_driver()

Kuan-Chung Chen (1):
      wifi: rtw89: 8922a: configure UL MU/OFDMA power setting

Martin Kaistra (1):
      wifi: rtl8xxxu: enable MFP support

Michael-CY Lee (1):
      wifi: mac80211: extend IEEE80211_KEY_FLAG_GENERATE_MMIE to other ciphers

Miri Korenblit (13):
      wifi: mac80211: defer link switch work in reconfig
      wifi: iwlwifi: mvm: implement link grading
      wifi: iwlwifi: mvm: calculate EMLSR mode after connection
      wifi: iwlwifi: mvm: don't always disable EMLSR due to BT coex
      wifi: iwlwifi: mvm: check if EMLSR is allowed before selecting links
      wifi: iwlwifi: mvm: move EMLSR/links code
      wifi: iwlwifi: mvm: Implement new link selection algorithm
      wifi: iwlwifi: mvm: Add helper functions to update EMLSR status
      wifi: iwlwifi: mvm: exit EMLSR upon missed beacon
      wifi: iwlwifi: mvm: implement EMLSR prevention mechanism.
      wifi: iwlwifi: mvm: don't recompute EMLSR mode in can_activate_links
      wifi: iwlwifi: mvm: get periodic statistics in EMLSR
      wifi: iwlwifi: mvm: Don't allow EMLSR when the RSSI is low

Mukesh Sisodiya (1):
      wifi: iwlwifi: mvm: send ap_tx_power_constraints cmd to FW in AP mode

Ping-Ke Shih (4):
      wifi: rtw88: station mode only for SDIO chips
      wifi: rtw89: 8852c: add quirk to set PCI BER for certain platforms
      wifi: rtw89: 8852c: disable PCI PHY EQ to improve compatibility
      wifi: rtw88: remove unsupported interface type of mesh point

Po-Hao Huang (3):
      wifi: rtw89: 8922a: download template probe requests for 6 GHz band
      wifi: rtw89: 8922a: add beacon filter and CQM support
      wifi: rtw88: Set default CQM config if not present

Sriram R (1):
      wifi: mac80211: handle link ID during management Tx

Yedidya Benshimol (1):
      wifi: iwlwifi: mvm: disable EMLSR when we suspend with wowlan

Zong-Zhe Yang (1):
      wifi: rtw89: 8852c: update TX power tables to R69

 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c       |  36 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h       |  16 +
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |  46 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |  44 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c | 127 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |  23 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h       |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/Makefile    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |  75 +--
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  24 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |  97 +---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      | 567 +++++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |  21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  78 ++-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 287 +++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       | 138 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  29 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  47 +-
 .../net/wireless/intel/iwlwifi/mvm/tests/Makefile  |   3 +
 .../net/wireless/intel/iwlwifi/mvm/tests/links.c   | 394 ++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/tests/module.c  |  10 +
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |  22 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   1 +
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  41 +-
 drivers/net/wireless/microchip/wilc1000/hif.c      |  17 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |  43 +-
 drivers/net/wireless/microchip/wilc1000/netdev.h   |   5 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   5 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |   5 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   9 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    | 193 ++-----
 drivers/net/wireless/realtek/rtw88/coex.c          |   4 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |  14 +-
 drivers/net/wireless/realtek/rtw88/fw.h            |   2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |   2 +
 drivers/net/wireless/realtek/rtw88/main.c          |  18 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  24 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  11 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  56 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   4 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  91 ++++
 drivers/net/wireless/realtek/rtw89/pci.h           |  13 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  18 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   1 +
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    |  90 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |  23 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   1 +
 drivers/net/wireless/rsi/rsi_91x_sdio.c            |  31 +-
 drivers/net/wireless/ti/wl1251/sdio.c              |  20 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   4 +-
 include/linux/ieee80211.h                          |  18 +
 include/net/cfg80211.h                             | 111 ++--
 include/net/mac80211.h                             |  54 +-
 net/mac80211/cfg.c                                 |  22 +-
 net/mac80211/chan.c                                |  79 ++-
 net/mac80211/ieee80211_i.h                         |  17 +-
 net/mac80211/iface.c                               |   9 +-
 net/mac80211/link.c                                |  21 +-
 net/mac80211/mlme.c                                |  53 +-
 net/mac80211/offchannel.c                          |  12 +-
 net/mac80211/sta_info.h                            |   4 +-
 net/mac80211/util.c                                |   7 +
 net/mac80211/wpa.c                                 |  12 +-
 net/wireless/nl80211.c                             |   3 +-
 net/wireless/reg.c                                 |  18 +-
 net/wireless/reg.h                                 |  13 +-
 81 files changed, 2448 insertions(+), 931 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/Makefile
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/links.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/module.c


