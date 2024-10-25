Return-Path: <linux-wireless+bounces-14554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC359B0A8B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 19:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D29C1C21CFC
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF332206515;
	Fri, 25 Oct 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZVl9SHaH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BF42064EF;
	Fri, 25 Oct 2024 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876026; cv=none; b=FB5uEn4mwbdKd2bccQLsk5OEwCgQKIZybB2xZdOgsAQzWoXY6Cq2pAr4k2KpxRof4L5N/3TZ9Whmp3XooT8VF5vWcwaOKWqUMQoBt/AtT/aAIoHYvIws28gx2/MejumXcG1Mse0psOqEJUFAbTy3phMv5f1C/78R5D2ydbkg/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876026; c=relaxed/simple;
	bh=K9Uxp5+YcIKwmGtiZzj2/KMcLnIQteQm2f35z2p9EyY=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Message-Id:Date; b=sGMARNztQjWSMLJ68adoG3qk1hOo8JaFS7X23ca0ss/MO05L6juUW20CUcCGTvROypVf1RJPXQZbNt5I3JdaMw0e55iYPhOC+JeYM38Fw3RMz1baW+FtUOnRZcx60+e9xY9aiZpNgZhXMQlniqerexsNfKq2DtpnW4J6PmKYb1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZVl9SHaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F6B2C4CEC3;
	Fri, 25 Oct 2024 17:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729876026;
	bh=K9Uxp5+YcIKwmGtiZzj2/KMcLnIQteQm2f35z2p9EyY=;
	h=From:Subject:To:Cc:Date:From;
	b=ZVl9SHaHrnS6whIL8CcVGwCgrrgRN5Q6TKz/lBKUvj9QpzNtsYPNpJLoRKfMpKlWR
	 0LJD2hhjFkV2TSMNruWbzSLONYUom0k4k6mRXisy61dGTdrU+iQcEvvJ4s/xILTpGv
	 s8SfL4bTF8YpQL9GtZUaQlRrHFYlMnPeZjL3vlsdJnHVqS2VfKkJi9bg1uXigQHPQR
	 iAJVpvhScjmh0ZMeitTqxzC4FT+wswBczG8p90kLu6nOVCL87xkjMXzEZbsWZgwc+D
	 naEDnwQqb8xw3aJCuN/Ssk8/w71z4A5ycXFIBhO9TWQ3c2d8Is5YMt++yPDxNzrbRj
	 FENocRn/Xm4iw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Kalle Valo <kvalo@kernel.org>
Subject: pull-request: wireless-next-2024-10-25
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Message-Id: <20241025170705.5F6B2C4CEC3@smtp.kernel.org>
Date: Fri, 25 Oct 2024 17:07:05 +0000 (UTC)

Hi,

here's a pull request to net-next tree, more info below. Please let me know if
there are any problems.

Kalle

The following changes since commit 36efaca9cb28a893cad98f0448c39a8b698859e2:

  net: phy: microchip_t1: SQI support for LAN887x (2024-10-08 18:24:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2024-10-25

for you to fetch changes up to eaed5fc0c322d75cfcdbc7a16c0c5023d9e4f6fe:

  mac80211: Remove NOP call to ieee80211_hw_config (2024-10-23 17:36:49 +0200)

----------------------------------------------------------------
wireless-next patches for v6.13

The first -next "new features" pull request for v6.13. This is a big
one as we have not been able to send one earlier. We have also some
patches affecting other subsystems: in staging we deleted the rtl8192e
driver and in debugfs added a new interface to save struct
file_operations memory; both were acked by GregKH.

Because of the lib80211/libipw move there were quite a lot of
conflicts and to solve those we decided to merge net-next into
wireless-next.

Currently there's one conflict in
Documentation/networking/net_cachelines/net_device.rst. To fix that
just remove the iw_public_data line:

https://lore.kernel.org/all/20241011121014.674661a0@canb.auug.org.au/

And when net is merged to net-next there will be another simple
conflict in in net/mac80211/cfg.c:

https://lore.kernel.org/all/20241024115523.4cd35dde@canb.auug.org.au/

Major changes:

cfg80211/mac80211

* stop exporting wext symbols

* new mac80211 op to indicate that a new interface is to be added

* support radio separation of multi-band devices

Wireless Extensions

* move wext spy implementation to libiw

* remove iw_public_data from struct net_device

brcmfmac

* optional LPO clock support

ipw2x00

* move remaining lib80211 code into libiw

wilc1000

* WILC3000 support

rtw89

* RTL8852BE and RTL8852BE-VT BT-coexistence improvements

----------------------------------------------------------------
Aditya Kumar Singh (1):
      wifi: mac80211: re-order assigning channel in activate links

Ajay Singh (1):
      wifi: wilc1000: Add WILC3000 support

Alper Nebi Yasak (1):
      wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()

Arnd Bergmann (1):
      wifi: iwlwifi: work around -Wenum-compare-conditional warning

Bartosz Golaszewski (1):
      wifi: brcmfmac: of: use devm_clk_get_optional_enabled_with_rate()

Ben Greear (1):
      mac80211: Remove NOP call to ieee80211_hw_config

Benjamin Berg (2):
      wifi: iwlwifi: mvm: log information about HW restart completion
      wifi: iwlwifi: do not warn about a flush with an empty TX queue

Bitterblue Smith (2):
      wifi: rtw88: Constify some arrays and structs
      wifi: rtw88: Parse the RX descriptor with a single function

Chin-Yen Lee (1):
      wifi: rtw89: wow: do not configure CPU IO to receive packets for old firmware

Ching-Te Ku (4):
      wifi: rtw89: coex: Update priority setting for Wi-Fi is scanning
      wifi: rtw89: coex: Reorder Bluetooth info related logic
      wifi: rtw89: coex: Solved BT PAN profile idle decrease Wi-Fi throughput
      wifi: rtw89: coex: Add function to reorder Wi-Fi firmware report index

Colin Ian King (1):
      wifi: rtlwifi: make read-only arrays static const

Daniel Gabay (2):
      wifi: iwlwifi: mvm: Remove unused last_amsdu from reorder buffer
      wifi: iwlwifi: mvm: Remove redundant rcu_read_lock() in reorder buffer

Dmitry Antipov (3):
      wifi: mac80211, cfg80211: miscellaneous spelling fixes
      wifi: mwifiex: cleanup struct mwifiex_auto_tdls_peer
      wifi: mwifiex: cleanup struct mwifiex_private

Dmitry Kandybka (1):
      wifi: nl80211: remove redundant null pointer check in coalescing

Dr. David Alan Gilbert (3):
      wifi: brcmfmac: Remove unused brcmf_cfg80211_get_iftype()
      wifi: brcmsmac: Remove unused brcms_debugfs_get_devdir()
      wifi: cw1200: Remove unused cw1200_queue_requeue_all()

Emmanuel Grumbach (7):
      wifi: mac80211: make bss_param_ch_cnt available for the low level driver
      wifi: mac80211: remove unneeded parameters
      wifi: mac80211: ieee80211_recalc_txpower receives a link
      wifi: mac80211: __ieee80211_recalc_txpower receives a link
      wifi: mac80211: update the right link for tx power
      wifi: iwlwifi: mvm: exit EMLSR earlier if bss_param_ch_cnt is updated
      wifi: iwlwifi: mvm: prepare the tx_power handling to be per-link

Felix Fietkau (11):
      wifi: cfg80211: add option for vif allowed radios
      wifi: mac80211: use vif radio mask to limit ibss scan frequencies
      wifi: mac80211: use vif radio mask to limit creating chanctx
      wifi: cfg80211: report per wiphy radio antenna mask
      wifi: mac80211: remove status->ampdu_delimiter_crc
      wifi: cfg80211: pass net_device to .set_monitor_channel
      wifi: mac80211: add flag to opt out of virtual monitor support
      wifi: cfg80211: add monitor SKIP_TX flag
      wifi: mac80211: add support for the monitor SKIP_TX flag
      wifi: mac80211: refactor ieee80211_rx_monitor
      wifi: mac80211: filter on monitor interfaces based on configured channel

Ilan Peer (2):
      wifi: mac80211: Add support to indicate that a new interface is to be added
      wifi: iwlwifi: mvm: Add support for prep_add_interface() callback

Jacobe Zang (4):
      dt-bindings: net: wireless: brcm4329-fmac: add pci14e4,449d
      dt-bindings: net: wireless: brcm4329-fmac: add clock description for AP6275P
      wifi: brcmfmac: Add optional lpo clock enable support
      wifi: brcmfmac: add flag for random seed during firmware download

Jeff Johnson (1):
      wifi: mac80211: constify ieee80211_ie_build_{he,eht}_oper() chandef

Jinjie Ruan (3):
      wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
      wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()

Johannes Berg (26):
      wifi: qtnfmac: don't include lib80211.h
      wifi: mwifiex: don't include lib80211.h
      wifi: libertas: don't select/include lib80211
      staging: rtl8192e: delete the driver
      wifi: ipw2x00/lib80211: move remaining lib80211 into libipw
      staging: don't recommend using lib80211
      wifi: wext/libipw: move spy implementation to libipw
      wifi: cfg80211: stop exporting wext symbols
      wifi: remove iw_public_data from struct net_device
      wifi: cfg80211: unexport wireless_nlevent_flush()
      wifi: wext: merge adjacent CONFIG_COMPAT ifdef blocks
      wireless: wext: shorten struct iw_ioctl_description
      Revert "wifi: cfg80211: unexport wireless_nlevent_flush()"
      Merge net-next/main to resolve conflicts
      wifi: ipw: select CRYPTO_LIB_ARC4
      wifi: cfg80211: disallow SMPS in AP mode
      wifi: mac80211: allow rate_control_rate_init() for links
      wifi: mac80211: call rate_control_rate_update() for link STA
      wifi: mac80211: chan: calculate min_def also for client mode
      wifi: mac80211: expose ieee80211_chan_width_to_rx_bw() to drivers
      wifi: iwlwifi: fw: api: update link context API version
      wifi: iwlwifi: allow IWL_FW_CHECK() with just a string
      wifi: mac80211_hwsim: use hrtimer_active()
      wifi: mac80211: remove misleading j_0 construction parts
      debugfs: add small file operations for most files
      wifi: mac80211: convert debugfs files to short fops

Julia Lawall (1):
      mac80211: Reorganize kerneldoc parameter names

Kalle Valo (1):
      Merge tag 'rtw-next-2024-10-10' of https://github.com/pkshih/rtw

Karthikeyan Periyasamy (1):
      wifi: cfg80211: check radio iface combination for multi radio per wiphy

Marek Vasut (8):
      wifi: wilc1000: Keep slot powered on during suspend/resume
      dt-bindings: wireless: wilc1000: Document WILC3000 compatible string
      wifi: wilc1000: Clean up usage of wilc_get_chipid()
      wifi: wilc1000: Fold chip_allow_sleep()/chip_wakeup() into wlan.c
      wifi: wilc1000: Fill in missing error handling
      wifi: wilc1000: Fold wilc_create_wiphy() into cfg80211.c
      wifi: wilc1000: Register wiphy after reading out chipid
      wifi: wilc1000: Set MAC after operation mode

Martin Kaistra (1):
      wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled

Michael-CY Lee (1):
      wifi: mac80211: refactor BW limitation check for CSA parsing

Miri Korenblit (7):
      wifi: mac80211: rename IEEE80211_CHANCTX_CHANGE_MIN_WIDTH
      wifi: mac80211: parse A-MSDU len from EHT capabilities
      wifi: mac80211: add an option to fake ieee80211_connection_loss
      wifi: iwlwifi: bump FW API to 94 for BZ/SC devices
      wifi: iwlwifi: mvm: remove unneeded check
      wifi: iwlwifi: mvm: remove IWL_MVM_HW_CSUM_DISABLE
      wifi: iwlwifi: mvm: remove redundant check

Ping-Ke Shih (14):
      wifi: rtw89: 8922a: rfk: enlarge TSSI timeout time to 20ms
      wifi: rtw89: 8922a: rfk: support firmware command RX DCK v1 format
      wifi: rtw89: rfk: add firmware debug log of TSSI
      wifi: rtw89: rfk: add firmware debug log of IQK
      wifi: rtw89: rfk: update firmware debug log of DACK to v2
      wifi: rtw88: use ieee80211_purge_tx_queue() to purge TX skb
      wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
      wifi: rtw89: coex: initialize local .dbcc_2g_phy in _set_btg_ctrl()
      wifi: rtw89: 8852c: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
      wifi: rtw89: pci: consolidate PCI basic configurations for probe and resume
      wifi: rtw89: 8922ae: disable PCI PHY EQ to improve compatibility
      wifi: rtw89: 8852ce: fix gray code conversion for filter out EQ
      wifi: rtw89: 8852ce: set offset K of PCI PHY EQ to manual mode to improve compatibility
      wifi: rtw89: debug: add beacon RSSI for debugging

Sascha Hauer (1):
      wifi: mwifiex: add missing locking for cfg80211 calls

Vasileios Amoiridis (3):
      wifi: brcmfmac: of: Make use of irq_get_trigger_type()
      wifi: wlcore: sdio: Make use of irq_get_trigger_type()
      wifi: wlcore: sdio: Use helper to define resources

Yan Zhen (1):
      wifi: rt2x00: convert comma to semicolon

Yedidya Benshimol (1):
      wifi: iwlwifi: fw: add an error table status getter

Zong-Zhe Yang (9):
      wifi: rtw89: rename rtw89_vif to rtw89_vif_link ahead for MLO
      wifi: rtw89: rename rtw89_sta to rtw89_sta_link ahead for MLO
      wifi: rtw89: read bss_conf corresponding to the link
      wifi: rtw89: read link_sta corresponding to the link
      wifi: rtw89: refactor VIF related func ahead for MLO
      wifi: rtw89: refactor STA related func ahead for MLO
      wifi: rtw89: tweak driver architecture for impending MLO support
      wifi: rtw89: initialize dual HW bands for MLO and control them by link
      wifi: rtw89: handle entity active flag per PHY

 .../bindings/net/wireless/brcm,bcm4329-fmac.yaml   |    9 +
 .../bindings/net/wireless/microchip,wilc1000.yaml  |    6 +-
 .../networking/net_cachelines/net_device.rst       |    1 -
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.c  |    1 -
 drivers/net/ethernet/toshiba/ps3_gelic_wireless.h  |    1 -
 drivers/net/wireless/ath/ath10k/mac.c              |    5 +-
 drivers/net/wireless/ath/ath11k/mac.c              |    5 +-
 drivers/net/wireless/ath/ath12k/mac.c              |    5 +-
 drivers/net/wireless/ath/ath9k/htc_drv_main.c      |    6 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c        |    1 +
 .../wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c  |    4 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         |    7 -
 .../broadcom/brcm80211/brcmfmac/cfg80211.h         |    1 -
 .../wireless/broadcom/brcm80211/brcmfmac/common.c  |    3 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.c  |   26 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/of.h  |    9 +-
 .../wireless/broadcom/brcm80211/brcmfmac/pcie.c    |   55 +-
 .../wireless/broadcom/brcm80211/brcmfmac/sdio.c    |   22 +-
 .../net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    3 +
 .../wireless/broadcom/brcm80211/brcmsmac/debug.c   |    5 -
 .../wireless/broadcom/brcm80211/brcmsmac/debug.h   |    1 -
 .../broadcom/brcm80211/include/brcm_hw_ids.h       |    2 +
 drivers/net/wireless/intel/ipw2x00/Kconfig         |   11 +-
 drivers/net/wireless/intel/ipw2x00/Makefile        |    7 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c       |    9 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.h       |    2 -
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |   25 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.h       |    4 -
 drivers/net/wireless/intel/ipw2x00/libipw.h        |  114 +-
 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c |  246 ++
 .../wireless/intel/ipw2x00/libipw_crypto_ccmp.c    |   76 +-
 .../wireless/intel/ipw2x00/libipw_crypto_tkip.c    |  106 +-
 .../net/wireless/intel/ipw2x00/libipw_crypto_wep.c |   73 +-
 drivers/net/wireless/intel/ipw2x00/libipw_module.c |   36 +-
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   11 +-
 .../net/wireless/intel/ipw2x00/libipw_spy.c        |   63 +-
 drivers/net/wireless/intel/ipw2x00/libipw_tx.c     |    4 +-
 drivers/net/wireless/intel/ipw2x00/libipw_wx.c     |   43 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   32 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c       |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |   34 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c      |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |   45 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   75 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    3 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs-fw.c     |   13 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c      |    8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c       |    4 +
 drivers/net/wireless/intersil/p54/p54spi.c         |    4 +-
 drivers/net/wireless/marvell/libertas/Kconfig      |    1 -
 drivers/net/wireless/marvell/libertas/cfg.c        |    1 +
 drivers/net/wireless/marvell/libertas/mesh.h       |    1 -
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      |    2 +
 drivers/net/wireless/marvell/mwifiex/fw.h          |    2 +-
 drivers/net/wireless/marvell/mwifiex/ioctl.h       |    2 +-
 drivers/net/wireless/marvell/mwifiex/join.c        |   11 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    4 -
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |    6 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |    2 -
 drivers/net/wireless/marvell/mwifiex/tdls.c        |    2 -
 drivers/net/wireless/marvell/mwifiex/util.c        |    2 +
 drivers/net/wireless/mediatek/mt76/mt7915/main.c   |    5 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c   |    5 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  113 +-
 drivers/net/wireless/microchip/wilc1000/cfg80211.h |    2 +-
 drivers/net/wireless/microchip/wilc1000/netdev.c   |   37 +-
 drivers/net/wireless/microchip/wilc1000/sdio.c     |   99 +-
 drivers/net/wireless/microchip/wilc1000/spi.c      |    8 +-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  452 +++-
 drivers/net/wireless/microchip/wilc1000/wlan.h     |   53 +-
 drivers/net/wireless/quantenna/qtnfmac/commands.c  |    2 +-
 drivers/net/wireless/quantenna/qtnfmac/core.h      |    1 -
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c     |    2 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |   18 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    2 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |    4 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    6 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   13 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   62 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |   49 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   65 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   53 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   54 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |   70 +-
 drivers/net/wireless/realtek/rtw88/rx.h            |   64 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    9 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    9 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |  259 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  219 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |   15 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |  383 ++-
 drivers/net/wireless/realtek/rtw89/coex.h          |    6 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  927 ++++---
 drivers/net/wireless/realtek/rtw89/core.h          |  450 +++-
 drivers/net/wireless/realtek/rtw89/debug.c         |  134 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  706 +++---
 drivers/net/wireless/realtek/rtw89/fw.h            |  261 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  719 +++---
 drivers/net/wireless/realtek/rtw89/mac.h           |  115 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  664 +++--
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   71 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   68 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   24 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   77 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  668 +++--
 drivers/net/wireless/realtek/rtw89/phy.h           |   13 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   12 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |  109 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |   14 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   79 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   33 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   37 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  217 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   10 +-
 drivers/net/wireless/st/cw1200/queue.c             |   27 -
 drivers/net/wireless/st/cw1200/queue.h             |    1 -
 drivers/net/wireless/ti/wl1251/sdio.c              |    4 +-
 drivers/net/wireless/ti/wlcore/main.c              |    5 +-
 drivers/net/wireless/ti/wlcore/sdio.c              |   13 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |   12 +-
 drivers/staging/Kconfig                            |    2 -
 drivers/staging/Makefile                           |    1 -
 drivers/staging/rtl8192e/Kconfig                   |   61 -
 drivers/staging/rtl8192e/Makefile                  |   19 -
 drivers/staging/rtl8192e/TODO                      |   18 -
 drivers/staging/rtl8192e/rtl8192e/Kconfig          |   10 -
 drivers/staging/rtl8192e/rtl8192e/Makefile         |   19 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |  266 --
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c |  198 --
 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h |   17 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c  |   79 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h  |   12 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     | 1915 ---------------
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h     |   34 -
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.c    |  189 --
 .../staging/rtl8192e/rtl8192e/r8192E_firmware.h    |   52 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |  244 --
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     | 1110 ---------
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h     |   55 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |  773 ------
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |  123 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h        |   25 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       | 2016 ---------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |  402 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         | 1856 --------------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |  155 --
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c     |   84 -
 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h     |   12 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c    |   37 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |   79 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h        |   20 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c         |   89 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h         |   16 -
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |  230 --
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h         |   31 -
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  867 -------
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h         |   13 -
 drivers/staging/rtl8192e/rtl8192e/table.c          |  543 -----
 drivers/staging/rtl8192e/rtl8192e/table.h          |   27 -
 drivers/staging/rtl8192e/rtl819x_BA.h              |   60 -
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |  544 -----
 drivers/staging/rtl8192e/rtl819x_HT.h              |  223 --
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  699 ------
 drivers/staging/rtl8192e/rtl819x_Qos.h             |   43 -
 drivers/staging/rtl8192e/rtl819x_TS.h              |   50 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |  450 ----
 drivers/staging/rtl8192e/rtllib.h                  | 1799 --------------
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |  411 ----
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |  706 ------
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |  242 --
 drivers/staging/rtl8192e/rtllib_module.c           |  179 --
 drivers/staging/rtl8192e/rtllib_rx.c               | 2564 --------------------
 drivers/staging/rtl8192e/rtllib_softmac.c          | 2309 ------------------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |  534 ----
 drivers/staging/rtl8192e/rtllib_tx.c               |  901 -------
 drivers/staging/rtl8192e/rtllib_wx.c               |  752 ------
 drivers/staging/rtl8712/TODO                       |    1 -
 drivers/staging/rtl8723bs/TODO                     |    1 -
 drivers/staging/vt6655/TODO                        |    1 -
 drivers/staging/vt6656/TODO                        |    1 -
 fs/debugfs/file.c                                  |  100 +-
 fs/debugfs/inode.c                                 |   63 +-
 fs/debugfs/internal.h                              |    6 +
 include/linux/debugfs.h                            |   62 +-
 include/linux/netdevice.h                          |    2 -
 include/linux/wireless.h                           |    5 +-
 include/net/cfg80211.h                             |   23 +-
 include/net/iw_handler.h                           |   41 +-
 include/net/lib80211.h                             |  122 -
 include/net/mac80211.h                             |   78 +-
 include/uapi/linux/nl80211.h                       |   10 +
 net/mac80211/agg-tx.c                              |    2 +-
 net/mac80211/cfg.c                                 |  178 +-
 net/mac80211/chan.c                                |   65 +-
 net/mac80211/debugfs.c                             |   28 +-
 net/mac80211/debugfs_key.c                         |    9 +-
 net/mac80211/debugfs_netdev.c                      |    3 +-
 net/mac80211/debugfs_sta.c                         |    9 +-
 net/mac80211/driver-ops.c                          |   16 +-
 net/mac80211/driver-ops.h                          |   18 +-
 net/mac80211/eht.c                                 |   21 +-
 net/mac80211/ibss.c                                |    7 +-
 net/mac80211/ieee80211_i.h                         |   16 +-
 net/mac80211/iface.c                               |   52 +-
 net/mac80211/link.c                                |   54 +-
 net/mac80211/mesh.c                                |    2 +-
 net/mac80211/mesh_hwmp.c                           |    6 +-
 net/mac80211/mesh_pathtbl.c                        |   10 +-
 net/mac80211/mesh_plink.c                          |    7 +-
 net/mac80211/mesh_sync.c                           |    2 +-
 net/mac80211/mlme.c                                |  118 +-
 net/mac80211/ocb.c                                 |    4 +-
 net/mac80211/rate.c                                |   35 +-
 net/mac80211/rate.h                                |   10 +-
 net/mac80211/rc80211_minstrel_ht.c                 |    2 +-
 net/mac80211/rx.c                                  |   77 +-
 net/mac80211/scan.c                                |   22 +-
 net/mac80211/spectmgmt.c                           |    9 +-
 net/mac80211/sta_info.h                            |    2 +-
 net/mac80211/status.c                              |    5 +-
 net/mac80211/tdls.c                                |    3 +-
 net/mac80211/tkip.c                                |    2 +-
 net/mac80211/trace.h                               |   34 +-
 net/mac80211/tx.c                                  |    8 +-
 net/mac80211/util.c                                |   20 +-
 net/mac80211/vht.c                                 |   29 +-
 net/mac80211/wpa.c                                 |    3 -
 net/wireless/Kconfig                               |   45 +-
 net/wireless/Makefile                              |    5 -
 net/wireless/chan.c                                |    5 +-
 net/wireless/core.c                                |   66 +-
 net/wireless/core.h                                |    1 +
 net/wireless/lib80211.c                            |  257 --
 net/wireless/nl80211.c                             |  104 +-
 net/wireless/radiotap.c                            |    2 +-
 net/wireless/rdev-ops.h                            |    5 +-
 net/wireless/reg.c                                 |    2 +-
 net/wireless/scan.c                                |   12 +-
 net/wireless/trace.h                               |   10 +-
 net/wireless/util.c                                |   31 +-
 net/wireless/wext-compat.c                         |   13 +-
 net/wireless/wext-compat.h                         |    6 -
 net/wireless/wext-core.c                           |    2 +-
 261 files changed, 6926 insertions(+), 28261 deletions(-)
 create mode 100644 drivers/net/wireless/intel/ipw2x00/libipw_crypto.c
 rename net/wireless/lib80211_crypt_ccmp.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_ccmp.c (83%)
 rename net/wireless/lib80211_crypt_tkip.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_tkip.c (87%)
 rename net/wireless/lib80211_crypt_wep.c => drivers/net/wireless/intel/ipw2x00/libipw_crypto_wep.c (72%)
 rename net/wireless/wext-spy.c => drivers/net/wireless/intel/ipw2x00/libipw_spy.c (81%)
 delete mode 100644 drivers/staging/rtl8192e/Kconfig
 delete mode 100644 drivers/staging/rtl8192e/Makefile
 delete mode 100644 drivers/staging/rtl8192e/TODO
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/Kconfig
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/Makefile
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8190P_rtl8256.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_cmdpkt.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_core.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_core.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_eeprom.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ethtool.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pm.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_pm.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_ps.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/rtl_wx.h
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/table.c
 delete mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_BA.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_BAProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_HT.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_HTProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_Qos.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_TS.h
 delete mode 100644 drivers/staging/rtl8192e/rtl819x_TSProc.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib.h
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_tkip.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_crypt_wep.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_module.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_rx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_softmac.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_softmac_wx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_tx.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_wx.c
 delete mode 100644 include/net/lib80211.h
 delete mode 100644 net/wireless/lib80211.c


