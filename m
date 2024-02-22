Return-Path: <linux-wireless+bounces-3908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE085F62F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 11:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AABBF1F2658D
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ECC3FB03;
	Thu, 22 Feb 2024 10:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTqPAU4o"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57D1A48;
	Thu, 22 Feb 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599126; cv=none; b=R/3lWDv3jDRxfiqiKO2eth5Zi0+/Bp9ZEfHawaSywTzQbZjOYlSsDkrD0jM18a8auLSwlASh5fUJJwqTS4IlsqmVl5RYq3h56RT0+TfrnucUgfEVSuP918HmjhiPwL8cp4KQfNmtvVVYomWPqBlv58tMX58z9sIGrdNMIAonEN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599126; c=relaxed/simple;
	bh=PeWahynVJh08YPdnY/pDdxwmw8nVg1XRPNPykKILfsg=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=XNroh8Km4IA2SEiZZkrNfntgK6DKJeWXnEyYZYEapsJe1fPsvF/f8NAlRB4JNp0xZMBEhgix+vIZo1rAd6ZHbTYsjli4luelQDOe98Xmx5jgCpZxwVODgoDBlf47WM0it+Wf/uWWSJvSnOVkKtWd65gllVlDu1IAHVJ3Vpuv0S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTqPAU4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC54C433F1;
	Thu, 22 Feb 2024 10:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708599126;
	bh=PeWahynVJh08YPdnY/pDdxwmw8nVg1XRPNPykKILfsg=;
	h=From:Subject:To:Cc:Date:From;
	b=lTqPAU4oi4+YPKKfg4W8lACCxTbvEs1mLKPjAKxW/8mB/dPGnRonQf0gYZsaapHJd
	 Jgb5NcKv2AQdAFvxR8B620YVsMWRv0MQfVcvD4zAGlEIi7hBX+FjLdw78yGLrRX0Ne
	 pQ0ubgpAVwMvcVdjYGXlHcly+0SwG/ahiYfOnKIqHHmJTzwjxgMlwE1UE+0NKLAxie
	 Oaj/cfhmJIvdb6JpMszqgAgVkVJoBjAmJhqVt4FgFemss/z38ZWKKAN5fiNOnB/k3g
	 F7tsAsLVfRDS9k9XZ6bZ79KcLmDkVbS/7v9HurTN1YsSKzhX0VBxUpA0VfE8fzYSFK
	 IoXr5LDFog1fA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-02-22
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240222105205.CEC54C433F1@smtp.kernel.org>
Date: Thu, 22 Feb 2024 10:52:05 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit e199c4ba8260ba845d9faf972d0718562cae042a:

  Merge tag 'wireless-next-2024-02-20' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-02-21 11:48:20 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-02-22

for you to fetch changes up to 1c33f0ffacfd22dd748d69199d0575bcc461684e:

  Merge tag 'ath-next-20240222' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-02-22 12:41:45 +0200)

----------------------------------------------------------------
wireless-next patches for v6.9

The third "new features" pull request for v6.9. This is a quick
followup to send commit 04edb5dc68f4 ("wifi: ath12k: Fix uninitialized
use of ret in ath12k_mac_allocate()") to fix the ath12k clang warning
introduced in the previous pull request.

We also have support for QCA2066 in ath11k, several new features in
ath12k and few other changes in drivers. In stack it's mostly cleanup
and refactoring.

Major changes:

ath12k

* firmware-2.bin support

* support having multiple identical PCI devices (firmware needs to
  have ATH12K_FW_FEATURE_MULTI_QRTR_ID)

* QCN9274: support split-PHY devices

* WCN7850: enable Power Save Mode in station mode

* WCN7850: P2P support

ath11k:

* QCA6390 & WCN6855: support 2 concurrent station interfaces

* QCA2066 support

iwlwifi

* mvm: support wider-bandwidth OFDMA

* bump firmware API to 90 for BZ/SC devices

brcmfmac

* DMI nvram filename quirk for ACEPC W5 Pro

----------------------------------------------------------------
Aaradhana Sahu (1):
      wifi: ath12k: fix firmware assert during insmod in memory segment mode

Aditya Kumar Singh (2):
      wifi: mac80211: check beacon countdown is complete on per link basis
      wifi: mac80211_hwsim: add support for switch_vif_chanctx callback

Alexis Lothoré (3):
      wifi: nl80211: force WLAN_AKM_SUITE_SAE in big endian in NL80211_CMD_EXTERNAL_AUTH
      wifi: wilc1000: remove AKM suite be32 conversion for external auth request
      wifi: wilc1000: revert reset line logic flip

Andy Shevchenko (1):
      wifi: cfg80211: Add KHZ_PER_GHZ to units.h and reuse

Baochen Qiang (5):
      wifi: ath12k: enable 802.11 power save mode in station mode
      wifi: ath11k: initialize rx_mcs_80 and rx_mcs_160 before use
      wifi: ath11k: initialize eirp_power before use
      wifi: ath11k: move pci.ops registration ahead
      wifi: ath11k: add support for QCA2066

Benjamin Berg (2):
      wifi: cfg80211: set correct param change count in ML element
      wifi: iwlwifi: mvm: unlock mvm if there is no primary link

Bitterblue Smith (1):
      wifi: rtlwifi: rtl8192cu: Fix TX aggregation

Carl Huang (2):
      wifi: ath11k: support 2 station interfaces
      wifi: ath11k: provide address list if chip supports 2 stations

Colin Ian King (3):
      wifi: ath9k:  remove redundant assignment to variable ret
      wifi: carl9170: Remove redundant assignment to pointer super
      wifi: mac80211: clean up assignments to pointer cache.

Ganesh Babu Jothiram (1):
      wifi: ath12k: Read board id to support split-PHY QCN9274

Hans de Goede (1):
      wifi: brcmfmac: Add DMI nvram filename quirk for ACEPC W5 Pro

Harshitha Prem (1):
      wifi: ath12k: add support for peer meta data version

Jeff Johnson (1):
      wifi: ath11k: Really consistently use ath11k_vif_to_arvif()

Johannes Berg (11):
      wifi: cfg80211: remove cfg80211_inform_single_bss_frame_data()
      wifi: cfg80211: clean up cfg80211_inform_bss_frame_data()
      wifi: cfg80211: refactor RNR parsing
      wifi: mac80211: align ieee80211_mle_get_bss_param_ch_cnt()
      wifi: cfg80211: use ML element parsing helpers
      wifi: iwlwifi: mvm: support wider-bandwidth OFDMA
      wifi: iwlwifi: mvm: partially support PHY context version 6
      wifi: iwlwifi: mvm: support PHY context version 6
      wifi: iwlwifi: api: fix kernel-doc reference
      wifi: iwlwifi: iwl-fh.h: fix kernel-doc issues
      wifi: nl80211: refactor parsing CSA offsets

Kalle Valo (1):
      Merge tag 'ath-next-20240222' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kang Yang (11):
      wifi: ath12k: fix broken structure wmi_vdev_create_cmd
      wifi: ath12k: fix incorrect logic of calculating vdev_stats_id
      wifi: ath12k: change interface combination for P2P mode
      wifi: ath12k: add P2P IE in beacon template
      wifi: ath12k: implement handling of P2P NoA event
      wifi: ath12k: implement remain on channel for P2P mode
      wifi: ath12k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
      wifi: ath12k: allow specific mgmt frame tx while vdev is not up
      wifi: ath12k: move peer delete after vdev stop of station for WCN7850
      wifi: ath12k: designating channel frequency for ROC scan
      wifi: ath12k: advertise P2P dev support for WCN7850

Karthikeyan Kathirvel (1):
      wifi: ath12k: subscribe required word mask from rx tlv

Karthikeyan Periyasamy (2):
      wifi: ath12k: add MAC id support in WBM error path
      wifi: ath12k: refactor the rfkill worker

Lingbo Kong (2):
      wifi: ath12k: add processing for TWT enable event
      wifi: ath12k: add processing for TWT disable event

Miri Korenblit (3):
      wifi: mac80211: make associated BSS pointer visible to the driver
      wifi: iwlwifi: bump FW API to 90 for BZ/SC devices
      wifi: iwlwifi: handle per-phy statistics from fw

Mukesh Sisodiya (1):
      wifi: iwlwifi: load b0 version of ucode for HR1/HR2

Nathan Chancellor (1):
      wifi: ath12k: Fix uninitialized use of ret in ath12k_mac_allocate()

Nicolas Escande (6):
      wifi: ath11k: Do not directly use scan_flags in struct scan_req_params
      wifi: ath11k: Remove scan_flags union from struct scan_req_params
      wifi: ath12k: Do not use scan_flags from struct ath12k_wmi_scan_req_arg
      wifi: ath12k: Remove unused scan_flags from struct ath12k_wmi_scan_req_arg
      wifi: ath12k: remove the unused scan_events from ath12k_wmi_scan_req_arg
      wifi: ath11k: remove unused scan_events from struct scan_req_params

P Praneesh (2):
      wifi: ath12k: Add logic to write QRTR node id to scratch
      wifi: ath12k: fix PCI read and write

Ping-Ke Shih (2):
      wifi: rtl8xxxu: check vif before using in rtl8xxxu_tx()
      wifi: rtlwifi: set initial values for unexpected cases of USB endpoint priority

Raj Kumar Bhagat (5):
      wifi: ath12k: add firmware-2.bin support
      wifi: ath12k: fix fetching MCBC flag for QCN9274
      wifi: ath12k: split hal_ops to support RX TLVs word mask compaction
      wifi: ath12k: remove hal_desc_sz from hw params
      wifi: ath12k: disable QMI PHY capability learn in split-phy QCN9274

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: fetch correct pdev id from WMI_SERVICE_READY_EXT_EVENTID

Sriram R (1):
      wifi: ath12k: indicate NON MBSSID vdev by default during vdev start

Toke Høiland-Jørgensen (1):
      wifi: ath9k: delay all of ath9k_wmi_event_tasklet() until init is complete

Wen Gong (1):
      wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID

 drivers/net/wireless/ath/ath10k/mac.c              |   2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/core.c             | 100 +++-
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/hw.c               |   2 +-
 drivers/net/wireless/ath/ath11k/hw.h               |   1 +
 drivers/net/wireless/ath/ath11k/mac.c              | 118 ++--
 drivers/net/wireless/ath/ath11k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |  43 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |  11 +
 drivers/net/wireless/ath/ath11k/wmi.c              |   2 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |  86 ++-
 drivers/net/wireless/ath/ath12k/Makefile           |   4 +-
 drivers/net/wireless/ath/ath12k/core.c             |  55 +-
 drivers/net/wireless/ath/ath12k/core.h             |  27 +
 drivers/net/wireless/ath/ath12k/dp.c               |  25 +-
 drivers/net/wireless/ath/ath12k/dp.h               |  17 +-
 drivers/net/wireless/ath/ath12k/dp_mon.c           |   5 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            | 158 +++---
 drivers/net/wireless/ath/ath12k/dp_tx.c            |  20 +
 drivers/net/wireless/ath/ath12k/fw.c               | 171 ++++++
 drivers/net/wireless/ath/ath12k/fw.h               |  33 ++
 drivers/net/wireless/ath/ath12k/hal.c              | 415 +++++++++++++-
 drivers/net/wireless/ath/ath12k/hal.h              |  20 +-
 drivers/net/wireless/ath/ath12k/hw.c               |  24 +-
 drivers/net/wireless/ath/ath12k/hw.h               |  32 +-
 drivers/net/wireless/ath/ath12k/mac.c              | 443 +++++++++++++--
 drivers/net/wireless/ath/ath12k/mhi.c              |  52 +-
 drivers/net/wireless/ath/ath12k/p2p.c              | 142 +++++
 drivers/net/wireless/ath/ath12k/p2p.h              |  23 +
 drivers/net/wireless/ath/ath12k/pci.c              |  84 ++-
 drivers/net/wireless/ath/ath12k/pci.h              |   6 +-
 drivers/net/wireless/ath/ath12k/qmi.c              |  52 +-
 drivers/net/wireless/ath/ath12k/qmi.h              |   1 -
 drivers/net/wireless/ath/ath12k/rx_desc.h          | 116 +++-
 drivers/net/wireless/ath/ath12k/wmi.c              | 230 +++++++-
 drivers/net/wireless/ath/ath12k/wmi.h              | 202 ++++---
 drivers/net/wireless/ath/ath9k/beacon.c            |   2 +-
 drivers/net/wireless/ath/ath9k/htc.h               |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_beacon.c    |   2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      |   4 +
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   4 -
 drivers/net/wireless/ath/ath9k/wmi.c               |  10 +-
 drivers/net/wireless/ath/ath9k/xmit.c              |   3 +-
 drivers/net/wireless/ath/carl9170/tx.c             |   2 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/dmi.c |   9 +
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |  10 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/phy-ctxt.h   |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h        |  36 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  11 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |  26 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |  17 +-
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c      |   4 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |   2 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |   6 +-
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.c   |  29 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/trx.h   |   2 -
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   3 -
 drivers/net/wireless/virtual/mac80211_hwsim.c      |  46 +-
 include/linux/ieee80211.h                          |  49 +-
 include/linux/units.h                              |   5 +-
 include/net/cfg80211.h                             |   2 +
 include/net/mac80211.h                             |   9 +-
 net/mac80211/ieee80211_i.h                         |   2 -
 net/mac80211/mesh_pathtbl.c                        |   6 +-
 net/mac80211/mlme.c                                |  27 +-
 net/mac80211/tx.c                                  |  14 +-
 net/wireless/nl80211.c                             | 156 +++---
 net/wireless/reg.c                                 |   7 +-
 net/wireless/scan.c                                | 619 +++++++++------------
 83 files changed, 2948 insertions(+), 962 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.c
 create mode 100644 drivers/net/wireless/ath/ath12k/fw.h
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath12k/p2p.h


