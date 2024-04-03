Return-Path: <linux-wireless+bounces-5794-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA18E896ACC
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 11:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D228BA91
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 09:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3836D135A6A;
	Wed,  3 Apr 2024 09:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqQeBzxd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBA2135A5D;
	Wed,  3 Apr 2024 09:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136987; cv=none; b=Ij4GL14jzrA/ZqNPORo9x6enHP0t3A+uazPs0sZZWKkwobgaWSjags1anEbRCdvlE9M40aK9Dl6K2uTbTzgwjIXau0LhJX3Hiuf4/H3DBAeUeR4Zt1t8OitnTpvp8bge4MA6L46I9x2ct/7yHFYfB954QDUiuaE+ZMuyLC22CG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136987; c=relaxed/simple;
	bh=bwb4JvcedxX6rrIHMw10SZ50m7m0GwkH021kKHCM1ho=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=eLQMgKeGHPBHazG75Nc1yOPBQMYbixW1WRLaPRy1e3VJdY+6fA8hAzMd0nQ4xbDtXAZOwjdmy0quSEMlxj2TjrIZMTa7izezAN5umbK/ip9vvsMtvlXCLthnxENk06e5FxOeTNAoAHPRrhuY/zd/XmVRWKCv7iFh0aIRDXIAgnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqQeBzxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF515C433C7;
	Wed,  3 Apr 2024 09:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712136986;
	bh=bwb4JvcedxX6rrIHMw10SZ50m7m0GwkH021kKHCM1ho=;
	h=From:Subject:To:Cc:Date:From;
	b=EqQeBzxd1SC9WhyMkHhDI7GLuuPGd2CDA5JA7I/Jx7BMZetXi8Bbb51Lz1jN9A9J3
	 i+Fv8DhTJqH9yaGL9nlB90KsK8AQaoUiL8EdDgikiMSPg3O1OuBUFGNWIAiJ6hty/k
	 vX4kgriZKIm6bJf6u+BKmiGoiK1HZS9SPhUJ7YUL37RBJg4RAgmZXM/hmJ36OqXPS7
	 6lAVMw6k8Xh75Q56WbJR/I62kLaXpoQVYa+UJLeBHCkqjCG/bsOI0XXEKH6/XV/hyB
	 hjR+437/QypXoPMLLxbwbGbN/J0n+mlKRGKgceeywTsyq8JNTncrCQq6e/iRzN8q19
	 B0Tnks4Jko5sQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-04-03
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20240403093625.CF515C433C7@smtp.kernel.org>
Date: Wed,  3 Apr 2024 09:36:24 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit c2b25092864a16c7865e406badedece5cc25fc2b:

  Merge branch 'qmc-hdlc' (2024-03-11 09:36:11 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-04-03

for you to fetch changes up to 0ccf50df61f98a9f98d46524be4baa00c88c499d:

  Merge tag 'ath-next-20240402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath (2024-04-02 21:19:58 +0300)

----------------------------------------------------------------
wireless-next patches for v6.10

The first "new features" pull request for v6.10 with changes both in
stack and in drivers. The big thing in this pull request is that
wireless subsystem is now almost free of sparse warnings. There's only
one warning left in ath11k which was introduced in v6.9-rc1 and will
be fixed via the wireless tree.

Realtek drivers continue to improve, now we have support for RTL8922AE
and RTL8723CS devices. ath11k also has long waited support for P2P.

This time we have a small conflict in iwlwifi as we didn't consider it
as major enough to justify merging wireless tree to wireless-next. But
Stephen has an example merge resolution which should help with fixing
the conflict:

https://lore.kernel.org/all/20240326100945.765b8caf@canb.auug.org.au/

Major changes:

rtw89

* RTL8922AE Wi-Fi 7 PCI device support

rtw88

* RTL8723CS SDIO device support

iwlwifi

* don't support puncturing in 5 GHz

* support monitor mode on passive channels

* BZ-W device support

* P2P with HE/EHT support

ath11k

* P2P support for QCA6390, WCN6855 and QCA2066

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211_hwsim: set link ID information during Rx

Aloka Dixit (1):
      wifi: ath12k: use correct flag field for 320 MHz channels

Anjaneyulu (3):
      wifi: mac80211: handle indoor AFC/LPI AP on assoc success
      wifi: cfg80211: handle indoor AFC/LPI AP in probe response and beacon
      wifi: iwlwifi: Add support for LARI_CONFIG_CHANGE_CMD cmd v9

Avraham Stern (1):
      wifi: iwlwifi: mvm: add debugfs for forcing unprotected ranging request

Ayala Beker (3):
      wifi: mac80211: fix BSS_CHANGED_MLD_TTLM description
      wifi: mac80211: add support for tearing down negotiated TTLM
      wifi: mac80211: don't select link ID if not provided in scan request

Baochen Qiang (3):
      wifi: ath10k: poll service ready message before failing
      wifi: ath11k: don't force enable power save on non-running vdevs
      wifi: ath11k: do not process consecutive RDDM event

Benjamin Berg (7):
      wifi: mac80211: improve association error reporting slightly
      wifi: cfg80211: check BSSID Index against MaxBSSID
      wifi: cfg80211: ignore non-TX BSSs in per-STA profile
      wifi: iwlwifi: mvm: always apply 6 GHz probe limitations
      wifi: iwlwifi: mvm: assign link STA ID lookups during restart
      wifi: iwlwifi: mvm: fix active link counting during recovery
      wifi: iwlwifi: mvm: mark EMLSR disabled in cleanup iterator

Breno Leitao (1):
      wifi: qtnfmac: allocate dummy net_device dynamically

Ching-Te Ku (5):
      wifi: rtw89: coex: Add WiFi role info format version 8
      wifi: rtw89: coex: Add antenna setting function for RTL8922A
      wifi: rtw89: coex: Add TDMA version 7
      wifi: rtw89: coex: Add TDMA slot parameter setting version 7
      wifi: rtw89: 8922a: update chip parameter for coex

Daniel Amosi (1):
      wifi: iwlwifi: Print a specific device name.

Dian-Syuan Yang (1):
      wifi: rtw89: Correct EHT TX rate on 20MHz connection

Duoming Zhou (1):
      wifi: brcmfmac: pcie: handle randbuf allocation failure

Emmanuel Grumbach (4):
      wifi: iwlwifi: mvm: support iwl_dev_tx_power_cmd_v8
      wifi: iwlwifi: remove devices that never came out
      wifi: iwlwifi: remove wrong CRF_IDs
      wifi: iwlwifi: add support for BZ_W

Fiona Klute (9):
      wifi: rtw88: Shared module for rtw8723x devices
      wifi: rtw88: Debug output for rtw8723x EFUSE
      wifi: rtw88: Add definitions for 8703b chip
      wifi: rtw88: Add rtw8703b.h
      wifi: rtw88: Add rtw8703b.c
      wifi: rtw88: Add rtw8703b_tables.h
      wifi: rtw88: Add rtw8703b_tables.c
      wifi: rtw88: Reset 8703b firmware before download
      wifi: rtw88: SDIO device driver for RTL8723CS

Gustavo A. R. Silva (2):
      wifi: ti: Avoid a hundred -Wflex-array-member-not-at-end warnings
      wifi: mwl8k: Avoid -Wflex-array-member-not-at-end warnings

Ilan Peer (7):
      wifi: iwlwifi: mvm: Move beacon filtering to be per link
      wifi: iwlwifi: mvm: Refactor scan start
      wifi: iwlwifi: mvm: Introduce internal MLO passive scan
      wifi: iwlwifi: mvm: Add debugfs entry for triggering internal MLO scan
      wifi: iwlwifi: mvm: Do not warn on invalid link on scan complete
      wifi: mac80211_hwsim: Declare HE/EHT capabilities support for P2P interfaces
      wifi: iwlwifi: mvm: Declare HE/EHT capabilities support for P2P interfaces

Jeff Johnson (6):
      wifi: ath12k: remove obsolete struct wmi_start_scan_arg
      wifi: ath11k: remove obsolete struct wmi_start_scan_arg
      wifi: ath11k: fix soc_dp_stats debugfs file permission
      wifi: nl80211: rename enum plink_actions
      wifi: nl80211: fix nl80211 uapi comment style issues
      wifi: nl80211: cleanup nl80211.h kernel-doc

Johannes Berg (26):
      wifi: iwlwifi: mvm: fix flushing during quiet CSA
      wifi: iwlwifi: mvm: advertise IEEE80211_HW_HANDLES_QUIET_CSA
      wifi: iwlwifi: pcie: remove duplicate PCI IDs entry
      wifi: mac80211: spectmgmt: simplify 6 GHz HE/EHT handling
      wifi: ieee80211: check for NULL in ieee80211_mle_size_ok()
      wifi: ieee80211: fix ieee80211_mle_basic_sta_prof_size_ok()
      wifi: mac80211_hwsim: move skip_beacons to be per link
      wifi: mac80211: clarify the dormant/suspended links docs
      wifi: mac80211: add flag to disallow puncturing in 5 GHz
      wifi: iwlwifi: add a kunit test for PCI table duplicates
      wifi: iwlwifi: fw: add clarifying comments about iwl_fwrt_dump_data
      wifi: iwlwifi: mvm: don't support puncturing in 5 GHz
      wifi: iwlwifi: remove 6 GHz NVM override
      wifi: iwlwifi: enable monitor on passive/inactive channels
      wifi: iwlwifi: mvm: allocate STA links only for active links
      wifi: mac80211: don't enter idle during link switch
      wifi: mac80211: clarify IEEE80211_STATUS_SUBDATA_MASK
      wifi: mac80211: don't ask driver about no-op link changes
      wifi: mac80211: improve drop for action frame return
      wifi: mac80211: reactivate multi-link later in restart
      wifi: iwlwifi: mvm: set wider BW OFDMA ignore correctly
      wifi: iwlwifi: mvm: select STA mask only for active links
      wifi: iwlwifi: mvm: don't change BA sessions during restart
      wifi: iwlwifi: reconfigure TLC during HW restart
      wifi: mac80211: use kvcalloc() for codel vars
      wifi: iwlwifi: mvm: fix check in iwl_mvm_sta_fw_id_mask

Kalle Valo (9):
      wifi: ath6kl: fix sparse warnings
      wifi: wcn36xx: buff_to_be(): fix sparse warnings
      wifi: wcn36xx: main: fix sparse warnings
      wifi: wil6210: fix sparse warnings
      wifi: ath9k: ath9k_set_moredata(): fix sparse warnings
      wifi: ath9k: fix ath9k_use_msi declaration
      wifi: ath9k: eeprom: fix sparse endian warnings
      wifi: mt76: mt7915: workaround dubious x | !y warning
      Merge tag 'ath-next-20240402' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

Kang Yang (9):
      wifi: ath11k: change interface combination for P2P mode
      wifi: ath11k: add P2P IE in beacon template
      wifi: ath11k: implement handling of P2P NoA event
      wifi: ath11k: change WLAN_SCAN_PARAMS_MAX_IE_LEN from 256 to 512
      wifi: ath11k: change scan flag scan_f_filter_prb_req for QCA6390/WCN6855/QCA2066
      wifi: ath11k: advertise P2P dev support for QCA6390/WCN6855/QCA2066
      wifi: ath12k: remove duplicate definitions in wmi.h
      wifi: ath11k: remove duplicate definitions in wmi.h
      wifi: mac80211: supplement parsing of puncturing bitmap

Karthikeyan Periyasamy (3):
      wifi: ath12k: Refactor Rxdma buffer replinish argument
      wifi: ath12k: Optimize the lock contention of used list in Rx data path
      wifi: ath12k: Refactor error handler of Rxdma replenish

Kevin Lo (1):
      wifi: ath11k: adjust a comment to reflect reality

Li Zhijian (3):
      wifi: b43: Convert sprintf/snprintf to sysfs_emit
      wifi: ti: Convert sprintf/snprintf to sysfs_emit
      wifi: ath: Convert sprintf/snprintf to sysfs_emit

Lorenzo Bianconi (1):
      wifi: mt76: mt7915: workaround too long expansion sparse warnings

Marek Vasut (1):
      dt-bindings: net: wireless: brcm,bcm4329-fmac: Add CYW43439 DT binding

Miri Korenblit (1):
      wifi: iwlwifi: mvm: Remove outdated comment

Ping-Ke Shih (1):
      wifi: rtw89: 8922a: add 8922ae to Makefile and Kconfig

Rand Deeb (1):
      ssb: Fix potential NULL pointer dereference in ssb_device_uevent()

Randy Dunlap (2):
      ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol
      ssb: use "break" on default case to prevent warning

Shaul Triebitz (5):
      wifi: iwlwifi: fix firmware API kernel doc
      wifi: iwlwifi: mvm: fix the sta id in offload
      wifi: iwlwifi: mvm: stop assuming sta id 0 in d3
      wifi: iwlwifi: mvm: skip keys of other links
      wifi: iwlwifi: mvm: support wowlan notif version 4

Thiraviyam Mariyappan (1):
      wifi: ath12k: fix desc address calculation in wbm tx completion

Uwe Kleine-König (2):
      bcma: convert to platform remove callback returning void
      net: rfkill: gpio: Convert to platform remove callback returning void

Víctor Gonzalo (1):
      wifi: mwifiex: Add missing MODULE_FIRMWARE() for SD8801

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    1 +
 drivers/bcma/host_soc.c                            |    6 +-
 drivers/net/wireless/ath/ath10k/thermal.c          |    2 +-
 drivers/net/wireless/ath/ath10k/wmi.c              |   26 +-
 drivers/net/wireless/ath/ath11k/Makefile           |    3 +-
 drivers/net/wireless/ath/ath11k/core.c             |   20 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    4 +-
 drivers/net/wireless/ath/ath11k/mac.c              |  175 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |   17 +-
 drivers/net/wireless/ath/ath11k/p2p.c              |  149 ++
 drivers/net/wireless/ath/ath11k/p2p.h              |   22 +
 drivers/net/wireless/ath/ath11k/pci.h              |    1 +
 drivers/net/wireless/ath/ath11k/thermal.c          |    2 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  107 +-
 drivers/net/wireless/ath/ath11k/wmi.h              |   78 +-
 drivers/net/wireless/ath/ath12k/dp.c               |   31 +-
 drivers/net/wireless/ath/ath12k/dp.h               |    7 +-
 drivers/net/wireless/ath/ath12k/dp_rx.c            |  140 +-
 drivers/net/wireless/ath/ath12k/dp_rx.h            |    1 +
 drivers/net/wireless/ath/ath12k/dp_tx.c            |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.c              |    2 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |   34 -
 drivers/net/wireless/ath/ath6kl/htc_mbox.c         |    3 +-
 drivers/net/wireless/ath/ath6kl/htc_pipe.c         |    3 +-
 drivers/net/wireless/ath/ath9k/ath9k.h             |    1 +
 drivers/net/wireless/ath/ath9k/eeprom_4k.c         |    2 +-
 drivers/net/wireless/ath/ath9k/eeprom_9287.c       |    4 +-
 drivers/net/wireless/ath/ath9k/eeprom_def.c        |    6 +-
 drivers/net/wireless/ath/ath9k/pci.c               |    2 -
 drivers/net/wireless/ath/ath9k/xmit.c              |   10 +-
 drivers/net/wireless/ath/wcn36xx/main.c            |    4 +-
 drivers/net/wireless/ath/wcn36xx/txrx.c            |    4 +-
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |    7 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    4 +-
 drivers/net/wireless/ath/wil6210/fw.h              |    1 -
 drivers/net/wireless/ath/wil6210/fw_inc.c          |    4 +-
 drivers/net/wireless/broadcom/b43/sysfs.c          |   13 +-
 drivers/net/wireless/broadcom/b43legacy/sysfs.c    |   16 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   15 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |   57 +-
 .../net/wireless/intel/iwlwifi/fw/api/nvm-reg.h    |    5 +-
 .../net/wireless/intel/iwlwifi/fw/api/offload.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/power.h  |   30 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |    1 +
 drivers/net/wireless/intel/iwlwifi/fw/file.h       |    3 +
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |   19 +-
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    5 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |    7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |    6 -
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   28 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h      |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c      |   21 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |  212 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs-vif.c   |   60 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |  117 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   30 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |   39 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   38 +-
 .../net/wireless/intel/iwlwifi/mvm/offloading.c    |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/power.c     |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c        |   48 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c      |  292 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |   53 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   26 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    1 +
 drivers/net/wireless/marvell/mwl8k.c               |   92 +-
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c    |    9 +-
 drivers/net/wireless/quantenna/qtnfmac/bus.h       |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/pcie/pcie.c |   13 +-
 .../wireless/quantenna/qtnfmac/pcie/pearl_pcie.c   |    6 +-
 .../wireless/quantenna/qtnfmac/pcie/topaz_pcie.c   |    6 +-
 drivers/net/wireless/realtek/rtw88/Kconfig         |   22 +
 drivers/net/wireless/realtek/rtw88/Makefile        |    9 +
 drivers/net/wireless/realtek/rtw88/mac.c           |    6 +
 drivers/net/wireless/realtek/rtw88/main.h          |    3 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      | 2109 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.h      |  102 +
 .../net/wireless/realtek/rtw88/rtw8703b_tables.c   |  902 +++++++++
 .../net/wireless/realtek/rtw88/rtw8703b_tables.h   |   14 +
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |   34 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |  673 +------
 drivers/net/wireless/realtek/rtw88/rtw8723d.h      |  269 +--
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |  721 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |  518 +++++
 drivers/net/wireless/realtek/rtw88/rx.h            |    2 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |   15 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   12 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |  964 ++++++++-
 drivers/net/wireless/realtek/rtw89/coex.h          |   72 +
 drivers/net/wireless/realtek/rtw89/core.h          |  108 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |   42 +
 drivers/net/wireless/realtek/rtw89/fw.h            |   27 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  154 ++
 drivers/net/wireless/ti/wl1251/cmd.h               |    2 -
 drivers/net/wireless/ti/wl1251/wl12xx_80211.h      |    1 -
 drivers/net/wireless/ti/wlcore/cmd.h               |    2 -
 drivers/net/wireless/ti/wlcore/sysfs.c             |   11 +-
 drivers/net/wireless/ti/wlcore/wl12xx_80211.h      |    1 -
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   42 +-
 drivers/ssb/main.c                                 |    6 +-
 include/linux/ieee80211.h                          |   12 +-
 include/linux/mmc/sdio_ids.h                       |    1 +
 include/linux/ssb/ssb.h                            |    8 -
 include/net/mac80211.h                             |   22 +-
 include/uapi/linux/nl80211.h                       |  236 +--
 net/mac80211/chan.c                                |   34 +-
 net/mac80211/debugfs.c                             |    1 +
 net/mac80211/drop.h                                |    3 +-
 net/mac80211/ht.c                                  |    2 +-
 net/mac80211/ieee80211_i.h                         |    8 +-
 net/mac80211/link.c                                |    7 +-
 net/mac80211/mlme.c                                |   82 +-
 net/mac80211/rx.c                                  |    4 +-
 net/mac80211/scan.c                                |   16 +-
 net/mac80211/spectmgmt.c                           |   18 +-
 net/mac80211/status.c                              |   22 +-
 net/mac80211/tx.c                                  |    6 +-
 net/mac80211/util.c                                |   14 +-
 net/rfkill/rfkill-gpio.c                           |    6 +-
 net/wireless/scan.c                                |   54 +-
 124 files changed, 7816 insertions(+), 1820 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.c
 create mode 100644 drivers/net/wireless/ath/ath11k/p2p.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h


