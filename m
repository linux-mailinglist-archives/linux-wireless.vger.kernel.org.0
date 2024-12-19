Return-Path: <linux-wireless+bounces-16631-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01029F8395
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4419516760F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263161A01C6;
	Thu, 19 Dec 2024 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imCkbeQE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB52198A31;
	Thu, 19 Dec 2024 18:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734634631; cv=none; b=twkNag50j7Pgpmg6ueDmuBM41rjJlgJO6tl7V3vhpGElyqVXKzROrWH38hkyLG6A9lClq60ae6tmO1w64xUfZEloKY5yBI5jCY6geUtroi443O5msTn+xIbZ/9+GzG60R0W43jlqyzB+rSgEcLD65iuUJFdGRV68De/uouxEryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734634631; c=relaxed/simple;
	bh=eYyOk2bEyqd9fGa1vFqfVwiRsgnVF5MO1LvYr05b2SY=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=tg7lyh4DuIJjJTjbM/pVj50RX4sMkGMGRFe8HqIx4tv+D4znqRdgpp5e2VB42jgKHePMC3NYGua0fv+WNQAsQXjhVMFR6IvzlVZmhallZEShie3gY8JdrXp9WF6Lu98cOEnqKATZcoo/mOAB9xSrITeyZJoXptXP+JgXBqHbPc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imCkbeQE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774EDC4CECE;
	Thu, 19 Dec 2024 18:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734634630;
	bh=eYyOk2bEyqd9fGa1vFqfVwiRsgnVF5MO1LvYr05b2SY=;
	h=From:Subject:To:Cc:Date:From;
	b=imCkbeQEZN10UjeP6p3bxXTDEb6l7Sw0IE6WFyMYfJDNQ4eEqDI6T/enSTbDvGuva
	 Pb+ZAme87dBBTlytfN6xR4yElgNWGb9CTl1NLDHZbLKLfIBZ+Q+sSiMNXckG8L4kN3
	 wDet/PfzxwsNvMGLBZIjX/80kWpLC7JCxjNzPLRYadKdGcUwLJUekTlC/Y5Aq4OsQP
	 yZP17nBOyqbast6GT35bRHIwEGjUS29JijxWQF6U+mJWMNTAsXKYbnIdoVTJbOW5si
	 k1p77E/pSKuQWFEQiTn+SalxlmhuFA65/QkA7HOgYnvOvnTNdNRTM/A0Q3zyL0jg12
	 HWcwAd1fDpyaQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-12-19
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20241219185709.774EDC4CECE@smtp.kernel.org>
Date: Thu, 19 Dec 2024 18:57:09 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-12-19

for you to fetch changes up to 8ab3bf4764136e8ad8d1064c304be50297bcf9ad:

  wifi: wlcore: sysfs: constify 'struct bin_attribute' (2024-12-18 20:05:06 +0200)

----------------------------------------------------------------
wireless-next patches for v6.14

Multi-Link Operation implementation continues, both in stack and in
drivers. Otherwise it has been relatively quiet.

Major changes:

cfg80211/mac80211

* define wiphy guard

* get TX power per link

* EHT 320 MHz channel support for mesh

ath11k

* QCA6698AQ support

ath9k

* RX inactivity detection

rtl8xxxu

* add more USB device IDs

rtw88

* add more USB device IDs

* enable USB RX aggregation and USB 3 to improve performance

rtw89

* PowerSave flow for Multi-Link Operation

----------------------------------------------------------------
Aditya Kumar Singh (3):
      wifi: ath12k: ath12k_bss_assoc(): MLO support
      wifi: mac80211_hwsim: add 6 GHz EHT Mesh capabilities
      wifi: ath12k: rename mlo_capable_flags to single_chip_mlo_supp

Alex Shumsky (1):
      wifi: brcmfmac: clarify unmodifiable headroom log message

Aloka Dixit (1):
      wifi: mac80211: fix variable used in for_each_sdata_link()

Andrei Otcheretianski (1):
      wifi: mac80211: Accept authentication frames on P2P device

Balaji Pothunoori (2):
      wifi: ath11k: Suspend hardware before firmware mode off for WCN6750
      wifi: ath11k: Fix unexpected return buffer manager error for WCN6750/WCN6855

Barnabás Czémán (1):
      wifi: wcn36xx: fix channel survey memory allocation size

Bitterblue Smith (2):
      wifi: rtw88: usb: Support USB 3 with RTL8812AU
      wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au

Chih-Kang Chang (3):
      wifi: rtw89: 8922a: use RSSI from PHY report in RX descriptor
      wifi: rtw89: add crystal_cap check to avoid setting as overflow value
      wifi: rtw89: 8922a: update format of RFK pre-notify H2C command v2

Christophe JAILLET (1):
      wifi: wlcore: testmode: Constify strutc nla_policy

Colin Ian King (1):
      wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop

Dinesh Karthikeyan (4):
      wifi: ath12k: Support Downlink Pager Stats
      wifi: ath12k: Support phy counter and TPC stats
      wifi: ath12k: Support SoC Common Stats
      wifi: ath12k: Support Transmit PER Rate Stats

Dmitry Antipov (6):
      wifi: ath9k: miscellaneous spelling fixes
      wifi: ath11k: cleanup struct ath11k_vif
      wifi: ath11k: cleanup struct ath11k_reg_tpc_power_info
      wifi: ath11k: cleanup struct ath11k_mon_data
      wifi: ath11k: miscellaneous spelling fixes
      wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()

Dylan Eskew (1):
      wifi: mac80211: ethtool: add monitor channel reporting

Eric Huang (1):
      wifi: rtw89: ps: update data for firmware and settings for hardware before/after PS

Hans de Goede (1):
      wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

Jeff Johnson (4):
      wifi: ath12k: mark QMI driver event helpers as noinline
      wifi: ath11k: mark some QMI driver event helpers as noinline
      wifi: ath11k: mark ath11k_dp_rx_mon_mpdu_pop() as noinline
      wifi: ath11k: mark ath11k_wow_convert_8023_to_80211() as noinline

Johannes Berg (2):
      wifi: cfg80211: define and use wiphy guard
      wifi: mac80211: use wiphy guard

Juan José Arboleda (1):
      wifi: iwlwifi: mvm: Replace spaces for tabs in iwl_mvm_vendor_events_idx

Kalle Valo (7):
      wifi: ath12k: ath12k_mac_vdev_create(): use goto for error handling
      wifi: ath12k: introduce ath12k_hw_warn()
      wifi: ath12k: convert struct ath12k::wmi_mgmt_tx_work to struct wiphy_work
      wifi: ath12k: ath12k_mac_op_set_key(): fix uninitialized symbol 'ret'
      wifi: ath12k: ath12k_mac_op_sta_rc_update(): use mac80211 provided link id
      Merge tag 'ath-next-20241209' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath
      Merge tag 'rtw-next-2024-12-12' of https://github.com/pkshih/rtw

Karol Przybylski (1):
      wifi: ath12k: Fix for out-of bound access error

Karthikeyan Periyasamy (10):
      wifi: ath12k: Refactor core startup
      wifi: ath12k: add ath12k_ab_to_ah() and ath12k_ab_set_ah()
      wifi: ath12k: add ath12k_get_num_hw()
      wifi: ath12k: introduce QMI firmware ready flag
      wifi: ath12k: move ATH12K_FLAG_REGISTERED handling to ath12k_mac_register()
      wifi: ath12k: introduce device group abstraction
      wifi: ath12k: refactor core start based on hardware group
      wifi: ath12k: move struct ath12k_hw from per device to group
      wifi: ath12k: send QMI host capability after device group is ready
      wifi: ath12k: introduce mlo_capable flag for device group

Kuan-Chung Chen (5):
      wifi: rtw89: sar: tweak 6GHz SAR subbands span
      wifi: rtw89: introduce dynamic antenna gain feature
      wifi: rtw89: handle different TX power between RF path
      wifi: rtw89: disable firmware training HE GI and LTF
      wifi: rtw89: 8852c: disable ER SU when 4x HE-LTF and 0.8 GI capability differ

Larry Finger (1):
      wifi: rtw88: 8821au: Add additional devices to the USB_DEVICE list

Liu Jing (1):
      wifi: qtnfmac: fix spelling error in core.h

Marcel Hamer (1):
      wifi: brcmfmac: add missing header include for brcmf_dbg

Miaoqing Pan (1):
      wifi: ath11k: add support for QCA6698AQ

Nick Morrow (2):
      wifi: rtw88: 8812au: Add more device IDs
      wifi: rtw88: Add additional USB IDs for RTL8812BU

Norbert van Bolhuis (1):
      wifi: brcmfmac: fix scatter-gather handling by detecting end of sg list

P Praneesh (1):
      wifi: ath12k: Fix endianness issue in struct hal_tlv_64_hdr

Pin-yen Lin (1):
      wifi: mwifiex: decrease timeout waiting for host sleep from 10s to 5s

Ping-Ke Shih (6):
      wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
      wifi: rtw89: ps: refactor PS flow to support MLO
      wifi: rtw89: ps: refactor channel info to firmware before entering PS
      wifi: rtw89: 8852c: rfk: refine target channel calculation in _rx_dck_channel_calc()
      wifi: rtw89: 8851b: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
      wifi: rtw89: phy: add dummy C2H event handler for report of TAS power

Po-Hao Huang (3):
      wifi: rtw89: 8922a: Extend channel info field length for scan
      wifi: rtw89: 8852b: add beacon filter and CQM support
      wifi: rtw89: 8852bt: add beacon filter and CQM support

Rameshkumar Sundaram (6):
      wifi: ath12k: add reo queue lookup table for ML peers
      wifi: ath12k: modify chanctx iterators for MLO
      wifi: ath12k: ath12k_mac_station_add(): fix potential rx_stats leak
      wifi: ath12k: defer vdev creation for MLO
      wifi: cfg80211: send MLO links tx power info in GET_INTERFACE
      wifi: mac80211: get tx power per link

Renjaya Raga Zenta (1):
      wifi: brcmfmac: fix brcmf_vif_clear_mgmt_ies when stopping AP

Roopni Devanathan (1):
      wifi: ath12k: Fix inappropriate use of print_array_to_buf_index()

Sathishkumar Muruganandam (1):
      wifi: mac80211: add EHT 320 MHz support for mesh

Sidhanta Sahu (1):
      wifi: ath12k: Support MBSSID Control Frame Stats

Sriram R (16):
      wifi: ath12k: MLO vdev bringup changes
      wifi: ath12k: Refactor sta state machine
      wifi: ath12k: Add helpers for multi link peer creation and deletion
      wifi: ath12k: add multi-link flag in peer create command
      wifi: ath12k: add helper to find multi-link station
      wifi: ath12k: Add MLO peer assoc command support
      wifi: ath12k: Add MLO station state change handling
      wifi: ath12k: support change_sta_links() mac80211 op
      wifi: ath12k: add primary link for data path operations
      wifi: ath12k: use arsta instead of sta
      wifi: ath12k: Use mac80211 vif's link_conf instead of bss_conf
      wifi: ath12k: Use mac80211 sta's link_sta instead of deflink
      wifi: ath12k: ath12k_mac_op_tx(): MLO support
      wifi: ath12k: ath12k_mac_op_flush(): MLO support
      wifi: ath12k: ath12k_mac_op_ampdu_action(): MLO support
      wifi: ath12k: do not return invalid link id for scan link

Thadeu Lima de Souza Cascardo (9):
      wifi: rtlwifi: do not complete firmware loading needlessly
      wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
      wifi: rtlwifi: wait for firmware loading before releasing memory
      wifi: rtlwifi: fix init_sw_vars leak when probe fails
      wifi: rtlwifi: usb: fix workqueue leak when probe fails
      wifi: rtlwifi: remove unused check_buddy_priv
      wifi: rtlwifi: destroy workqueue at rtl_deinit_core
      wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      wifi: rtlwifi: pci: wait for firmware loading before releasing memory

Thomas Weißschuh (1):
      wifi: wlcore: sysfs: constify 'struct bin_attribute'

Toke Høiland-Jørgensen (1):
      wifi: ath9k: Add RX inactivity detection and reset chip when it occurs

Zichen Xie (1):
      wifi: cfg80211: tests: Fix potential NULL dereference in test_cfg80211_parse_colocated_ap()

Zong-Zhe Yang (8):
      wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
      wifi: rtw89: register ops of can_activate_links
      wifi: rtw89: implement ops of change vif/sta links
      wifi: rtw89: apply MLD pairwise key to dynamically active links
      wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
      wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()
      wifi: rtw89: refine link handling for link_sta_rc_update
      wifi: rtw89: regd: update regulatory map to R68-R51

 drivers/net/wireless/ath/ath11k/core.c             |  132 ++
 drivers/net/wireless/ath/ath11k/core.h             |    4 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    1 -
 drivers/net/wireless/ath/ath11k/dp_rx.c            |   14 +-
 drivers/net/wireless/ath/ath11k/hal.h              |    6 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |    3 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    1 +
 drivers/net/wireless/ath/ath11k/mac.c              |    7 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |    1 +
 drivers/net/wireless/ath/ath11k/pci.c              |    3 +
 drivers/net/wireless/ath/ath11k/pcic.c             |   13 +-
 drivers/net/wireless/ath/ath11k/qmi.c              |    8 +-
 drivers/net/wireless/ath/ath11k/wow.c              |    6 +-
 drivers/net/wireless/ath/ath12k/core.c             |  486 ++++-
 drivers/net/wireless/ath/ath12k/core.h             |  134 +-
 drivers/net/wireless/ath/ath12k/debug.c            |    6 +-
 drivers/net/wireless/ath/ath12k/debug.h            |    5 +-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.c    |  681 ++++++-
 .../net/wireless/ath/ath12k/debugfs_htt_stats.h    |  218 ++-
 drivers/net/wireless/ath/ath12k/dp.c               |   70 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    3 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |   96 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    6 +-
 drivers/net/wireless/ath/ath12k/hal_desc.h         |    2 +-
 drivers/net/wireless/ath/ath12k/hal_rx.c           |   12 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 1999 +++++++++++++++-----
 drivers/net/wireless/ath/ath12k/mac.h              |   16 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   10 +
 drivers/net/wireless/ath/ath12k/peer.c             |  223 ++-
 drivers/net/wireless/ath/ath12k/peer.h             |   23 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  167 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   20 +
 drivers/net/wireless/ath/ath12k/wmi.c              |  207 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |  115 ++
 drivers/net/wireless/ath/ath6kl/cfg80211.c         |    1 +
 drivers/net/wireless/ath/ath9k/antenna.c           |    2 +-
 drivers/net/wireless/ath/ath9k/ar9002_hw.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_hw.c         |    2 +-
 drivers/net/wireless/ath/ath9k/ar9003_mci.c        |    4 +-
 drivers/net/wireless/ath/ath9k/ar9003_phy.h        |    2 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |    2 +
 drivers/net/wireless/ath/ath9k/channel.c           |    2 +-
 drivers/net/wireless/ath/ath9k/common-spectral.c   |    2 +-
 drivers/net/wireless/ath/ath9k/debug.c             |    1 +
 drivers/net/wireless/ath/ath9k/debug.h             |    1 +
 drivers/net/wireless/ath/ath9k/dfs.c               |    2 +-
 drivers/net/wireless/ath/ath9k/hif_usb.c           |    2 +-
 drivers/net/wireless/ath/ath9k/hw.c                |    4 +-
 drivers/net/wireless/ath/ath9k/hw.h                |    2 +-
 drivers/net/wireless/ath/ath9k/link.c              |   33 +-
 drivers/net/wireless/ath/ath9k/mac.h               |    2 +-
 drivers/net/wireless/ath/ath9k/main.c              |    5 +-
 drivers/net/wireless/ath/ath9k/wow.c               |    6 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |    2 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    5 +-
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    5 +
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    8 +-
 .../wireless/broadcom/brcm80211/brcmfmac/core.c    |    4 +-
 .../wireless/broadcom/brcm80211/brcmfmac/fwil.h    |    2 +
 .../broadcom/brcm80211/brcmsmac/phy/phy_n.c        |    3 +
 .../net/wireless/intel/iwlwifi/mvm/vendor-cmd.c    |    6 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    |    2 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |    2 +-
 drivers/net/wireless/mediatek/mt76/mt76.h          |    2 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/cfg80211.c  |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h      |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   20 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |   13 +-
 drivers/net/wireless/realtek/rtlwifi/base.h        |    1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   61 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |    4 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   12 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   12 -
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |   68 +-
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |   52 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |    6 +
 drivers/net/wireless/realtek/rtw88/usb.c           |   72 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   47 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |    9 +
 drivers/net/wireless/realtek/rtw89/cam.c           |   32 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |    5 +
 drivers/net/wireless/realtek/rtw89/core.c          |  164 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  145 ++
 drivers/net/wireless/realtek/rtw89/debug.c         |    4 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  266 ++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   69 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   79 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   43 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  289 ++-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   15 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   16 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    9 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  315 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |   33 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |   42 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    4 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    4 +
 drivers/net/wireless/realtek/rtw89/regd.c          |   57 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    3 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   50 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   54 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   55 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    1 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |    3 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   11 +-
 drivers/net/wireless/ti/wlcore/sysfs.c             |    4 +-
 drivers/net/wireless/ti/wlcore/testmode.c          |    2 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   39 +
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c  |    3 +-
 include/net/cfg80211.h                             |    6 +-
 include/net/mac80211.h                             |    2 +-
 net/mac80211/cfg.c                                 |   16 +-
 net/mac80211/debugfs.c                             |    4 +-
 net/mac80211/driver-ops.h                          |    7 +-
 net/mac80211/ethtool.c                             |   22 +-
 net/mac80211/ieee80211_i.h                         |    2 +-
 net/mac80211/iface.c                               |   25 +-
 net/mac80211/main.c                                |    9 +-
 net/mac80211/rx.c                                  |    4 +-
 net/mac80211/trace.h                               |   10 +-
 net/mac80211/util.c                                |   29 +-
 net/wireless/chan.c                                |    4 +-
 net/wireless/core.c                                |   42 +-
 net/wireless/mlme.c                                |    8 +-
 net/wireless/nl80211.c                             |  203 +-
 net/wireless/pmsr.c                                |    4 +-
 net/wireless/rdev-ops.h                            |    7 +-
 net/wireless/reg.c                                 |   53 +-
 net/wireless/scan.c                                |   40 +-
 net/wireless/sme.c                                 |   12 +-
 net/wireless/tests/scan.c                          |    2 +
 net/wireless/trace.h                               |   44 +-
 net/wireless/util.c                                |    7 +-
 net/wireless/wext-compat.c                         |  317 ++--
 net/wireless/wext-sme.c                            |   43 +-
 145 files changed, 6347 insertions(+), 1645 deletions(-)


