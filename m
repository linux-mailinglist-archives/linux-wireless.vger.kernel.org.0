Return-Path: <linux-wireless+bounces-19760-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE71A4DE7B
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 13:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46AE3A8620
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Mar 2025 12:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA1D20127D;
	Tue,  4 Mar 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="g6RPNdSY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C91EA7CE;
	Tue,  4 Mar 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092973; cv=none; b=jDxCTuH81VGjOyzMA2jwKOHyBy1VaUXruFuY2So0ZezE+GdMX9ujtB6uF+Y9dHHSNHH8kybTBbRf1DNz4Bwb4LFujlFs/QgfU6Js2rEw9KU++2gtzlwJNOHTjToyRjoYXqow26SiI6yp44TnJpPOpfXjA+WKIl1SblgxCiSkhsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092973; c=relaxed/simple;
	bh=8ypv2Y9Omx9VpOVz2gSm5wU3cZDv6lURFl8g6x7jPnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hAeP8O4bR9YaLAm5XNlfum320pafc/7wgCUL1MAIZTTFDmzLs8ehgAx4/edJaOJzR7GxRK5CBKO9fuufLgh9CW43e7fR1FD2mYIqrlaoExsmVOfsuP7sxb8AsXUGc1sy+HJ7b6wNdokM18INBAbVqmZC5BfPPD7C7nWVsO4UFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=g6RPNdSY; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=Y+5Oc9iO00nKb8Zc3Zkc6DgCsvPc4Ul3zcuX2kIRiwY=; t=1741092971; x=1742302571; 
	b=g6RPNdSYguzAz/dHk+OwFJaxBEA++MDQBH+AQ/z1GPWzgaGI3a8iQzo6zevdlwTv9xIuPj1BZdo
	HEEIJ1TdrO4pY+fwl8p6QMy3AcH7RuyLVVGkgiyffXcbL8Gk7BPBBOmvHrX8J34HHh8pCcQxdYYUw
	xGi60u9jSfbYapcZTe0vXQpbB74z/XunAjrIWFU69MUaph2qzW0IVV1NEk9mS0dgxBF+tA3G+O8dh
	YMfHTHW4ilE2VGZQxByQ3l+QeXPdoYy1uhUJT7XYiEf3Fo6daEOCh9+2eaYYwe8zAAQi/8VMXQH1e
	7j2BmkN/M1KPWEgvRPufoobs6zqQweHjudmw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tpRoe-00000000hYg-2Sev;
	Tue, 04 Mar 2025 13:56:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Subject: pull-request: wireless-next-2025-03-04-v2
Date: Tue,  4 Mar 2025 13:55:24 +0100
Message-ID: <20250304125605.127914-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Here's a first set of new wifi material for 6.15. It's not
that much yet, but it looks like we'll have the new split
out driver for newer Intel devices next, and then some.

Please pull and let us know if there's any problem.

Thanks,
johannes



The following changes since commit 59372af69d4d71e6487614f1b35712cf241eadb4:

  Merge tag 'batadv-next-pullrequest-20250117' of git://git.open-mesh.org/linux-merge (2025-01-18 17:57:31 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git tags/wireless-next-2025-03-04-v2

for you to fetch changes up to 799b7f93c01060d3d24c09d971bb6ce3c9601c71:

  wifi: iwlwifi: remove mld/roc.c (2025-03-04 13:48:30 +0100)

----------------------------------------------------------------
First 6.15 material:
 * cfg80211/mac80211
   - remove cooked monitor support
   - strict mode for better AP testing
   - basic EPCS support
   - OMI RX bandwidth reduction support
 * rtw88
   - preparation for RTL8814AU support
 * rtw89
   - use wiphy_lock/wiphy_work
   - preparations for MLO
   - BT-Coex improvements
   - regulatory support in firmware files
 * iwlwifi
   - preparations for the new iwlmld sub-driver

----------------------------------------------------------------
Alexander Wetzel (3):
      wifi: nl80211/cfg80211: Stop supporting cooked monitor
      wifi: mac80211: Drop cooked monitor support
      wifi: mac80211: Add counter for all monitor interfaces

Andrew Kreimer (2):
      wifi: rtw88: Fix a typo of debug message in rtw8723d_iqk_check_tx_failed()
      wifi: rtlwifi: rtl8192de: Fix typos of debug message of phy setting

Anjaneyulu (2):
      wifi: iwlwifi: mvm: rename and move iwl_mvm_eval_dsm_rfi() to iwl_rfi_is_enabled_in_bios()
      wifi: iwlwifi: Unify TAS block list handling in regulatory.c

Arnd Bergmann (1):
      wifi: iwlegacy: don't warn for unused variables with DEBUG_FS=n

Avraham Stern (1):
      wifi: iwlwifi: location api cleanup

Benjamin Berg (3):
      wifi: mac80211: add HT and VHT basic set verification
      wifi: mac80211: tests: add tests for ieee80211_determine_chan_mode
      wifi: cfg80211: expose update timestamp to drivers

Bitterblue Smith (11):
      wifi: rtw88: Don't use static local variable in rtw8822b_set_tx_power_index_by_rate
      wifi: rtw88: Don't use static local variable in rtw8821c_set_tx_power_index_by_rate
      wifi: rtw88: Fix __rtw_download_firmware() for RTL8814AU
      wifi: rtw88: Fix download_firmware_validate() for RTL8814AU
      wifi: rtw88: Extend struct rtw_pwr_track_tbl for RTL8814AU
      wifi: rtw88: Extend rf_base_addr and rf_sipi_addr for RTL8814AU
      wifi: rtw88: Extend rtw_fw_send_ra_info() for RTL8814AU
      wifi: rtw88: Constify some more structs and arrays
      wifi: rtw88: Rename RTW_RATE_SECTION_MAX to RTW_RATE_SECTION_NUM
      wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
      wifi: rtw88: Fix rtw_update_sta_info() for RTL8814AU

Catalin Popescu (2):
      dt-bindings: net: rfkill-gpio: enable booting in blocked state
      net: rfkill: gpio: allow booting in blocked state

Ching-Te Ku (6):
      wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi connecting
      wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.2
      wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
      wifi: rtw89: coex: To avoid TWS serials A2DP lag, adjust slot arrangement
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.3

Christophe JAILLET (1):
      wifi: mwifiex: Constify struct mwifiex_if_ops

Colin Ian King (2):
      wifi: ipw2x00: Fix spelling mistake "stablization" -> "stabilization"
      wifi: iwlwifi: Fix spelling mistake "Increate" -> "Increase"

Dr. David Alan Gilbert (11):
      wifi: libertas: main: remove unused functions
      wifi: libertas: cmd: remove unused functions
      wifi: libertas: Remove unused auto deep sleep code
      wifi: ipw2x00: Remove unused libipw_rx_any()
      wifi: iwlwifi: dvm: Remove unused iwl_rx_ant_restriction
      wifi: iwlwifi: mvm: Remove unused iwl_mvm_rx_missed_vap_notif
      wifi: iwlwifi: mvm: Remove unused iwl_mvm_ftm_*_add_pasn_sta functions
      wifi: iwlwifi: mvm: Remove unused iwl_mvm_ftm_add_pasn_sta
      wifi: iwlwifi: Remove unused iwl_bz_name
      wifi: iwlwifi: Remove old device data
      wifi: mwifiex: Remove unused mwifiex_uap_del_sta_data

Easwar Hariharan (1):
      wifi: cfg80211: convert timeouts to secs_to_jiffies()

Emmanuel Grumbach (13):
      wifi: iwlwifi: remove the mvm prefix from iwl_mvm_ctdp_cmd
      wifi: iwlwifi: remove the version number from iwl_dts_measurement_notif_v2
      wifi: iwlwifi: remove the mvm prefix from iwl_mvm_aux_sta_cmd
      wifi: mac80211: set ieee80211_prep_tx_info::link_id upon Auth Rx
      wifi: mac80211: rework the Tx of the deauth in ieee80211_set_disassoc()
      wifi: iwlwifi: be less aggressive with re-probe
      wifi: iwlwifi: make no_160 more generic
      wifi: iwlwifi: properly set the names for SC devices
      wifi: iwlwifi: clarify the meaning of IWL_INIT_PHY
      wifi: iwlwifi: use 0xff instead of 0xffffffff for invalid
      wifi: iwlwifi: add support for external 32 KHz clock
      wifi: iwlwifi: export iwl_get_lari_config_bitmap
      wifi: iwlwifi: remember if the UATS table was read successfully

Eric Huang (1):
      wifi: rtw89: ps: update H2C command with more info for PS

Ezra Buehler (1):
      wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)

Gavrilov Ilia (1):
      wifi: mac80211: fix integer overflow in hwmp_route_info_get()

Gustavo A. R. Silva (1):
      wifi: qtnfmac: Avoid multiple -Wflex-array-member-not-at-end warnings

Ilan Peer (8):
      wifi: cfg80211: Fix trace print for removed links
      wifi: mac80211: Refactor ieee80211_sta_wmm_params()
      wifi: mac80211: Add support for EPCS configuration
      wifi: ieee80211: Add missing EHT MAC capabilities
      wifi: mac80211: Add processing of TTLM teardown frame
      wifi: iwlwifi: Indicate support for EPCS
      wifi: iwlwifi: mvm: Indicate support link reconfiguration
      wifi: mac80211: Fix possible integer promotion issue

Johannes Berg (15):
      wifi: mac80211: add strict mode disabling workarounds
      wifi: mac80211_hwsim: enable strict mode
      wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
      wifi: mac80211: don't unconditionally call drv_mgd_complete_tx()
      wifi: mac80211: always send max agg subframe num in strict mode
      wifi: mac80211: aggregation: remove deflink accesses for MLO
      wifi: mac80211: enable removing assoc link
      wifi: iwlwifi: enable 320 MHz on slow PCIe links
      wifi: iwlwifi: cfg: separate 22000/BZ family HT params
      wifi: iwlwifi: fw: make iwl_send_dbg_dump_complete_cmd() static
      wifi: iwlwifi: use correct IMR dump variable
      wifi: iwlwifi: implement dump region split
      Merge tag 'rtw-next-2025-02-10-v2' of https://github.com/pkshih/rtw
      wifi: iwlwifi: add OMI bandwidth reduction APIs
      wifi: iwlwifi: remove mld/roc.c

Liang Jie (1):
      wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

Miri Korenblit (9):
      wifi: mac80211: ensure sdata->work is canceled before initialized.
      wifi: iwlwifi: don't warn during reprobe
      wifi: mac80211: add ieee80211_iter_chan_contexts_mtx
      wifi: iwlwifi: remove mvm prefix from iwl_mvm_esr_mode_notif
      wifi: iwlwifi: mld: add a debug level for PTP prints
      wifi: iwlwifi: mld: add a debug level for EHT prints
      wifi: iwlwifi: remove mvm prefix from iwl_mvm_d3_end_notif
      wifi: iwlwifi: add IWL_MAX_NUM_IGTKS macro
      wifi: iwlwifi: add Debug Host Command APIs

Ping-Ke Shih (23):
      wifi: rtw89: phy: rename to RTW89_PHY_NUM as proper naming
      wifi: rtw89: phy: add PHY context array to support functions per PHY
      wifi: rtw89: phy: support env_monitor per PHY
      wifi: rtw89: phy: support DIG per PHY
      wifi: rtw89: phy: support ch_info per PHY
      wifi: rtw89: phy: support EDCCA per PHY
      wifi: rtw89: phy: support EDCCA log per PHY
      wifi: rtw89: phy: disable CFO track when two PHY are working simultaneously
      wifi: rtw89: add wiphy_lock() to work that isn't held wiphy_lock() yet
      wifi: rtw89: use wiphy_work() to replace ieee802111_work()
      wifi: rtw89: debugfs: implement file_ops::read/write to replace seq_file
      wifi: rtw89: debugfs: specify buffer size allocated by devm_kazlloc() for reading
      wifi: rtw89: debugfs: use wiphy_locked_debugfs_{read,write}() if needed
      wifi: rtw89: debugfs: use debugfs_short_fops
      wifi: rtw89: remove consumers of driver mutex
      wifi: rtw89: manual cosmetic along lockdep_assert_wiphy()
      wifi: rtw89: remove definition of driver mutex
      wifi: rtw89: pci: not assert wiphy_lock to free early_h2c for PCI probe/remove
      wifi: rtw89: call power_on ahead before selecting firmware
      wifi: rtw89: fw: validate multi-firmware header before accessing
      wifi: rtw89: fw: validate multi-firmware header before getting its size
      wifi: rtw89: regd: avoid using BITMAP_FROM_U64() to assign function bitmap
      wifi: rtw89: debugfs depends on CFG80211's one

Salvatore Bonaccorso (1):
      wifi: b43: Replace outdated firmware URL

Sarika Sharma (2):
      wifi: cfg80211: reorg sinfo structure elements for mesh
      wifi: mac80211: refactor populating mesh related fields in sinfo

Shaul Triebitz (2):
      wifi: iwlwifi: support ROC version 6
      wifi: iwlwifi: add twt operation cmd

Soeren Moch (1):
      wifi: rtl8xxxu: retry firmware download on error

Zong-Zhe Yang (4):
      wifi: rtw89: regd: support loading regd table from fw element
      wifi: rtw89: regd: handle supported regulatory functions by country
      wifi: rtw89: regd: refactor init/setup flow and prototype
      wifi: rtw89: cleanup unused rtwdev::roc_work

 .../devicetree/bindings/net/rfkill-gpio.yaml       |    5 +
 drivers/net/wireless/broadcom/b43/main.c           |    2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2200.c       |    2 +-
 drivers/net/wireless/intel/ipw2x00/libipw.h        |    2 -
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c     |   91 -
 drivers/net/wireless/intel/iwlegacy/4965-rs.c      |   15 +-
 drivers/net/wireless/intel/iwlegacy/common.h       |    2 -
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c     |    1 -
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c        |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c        |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tt.c        |   11 -
 drivers/net/wireless/intel/iwlwifi/dvm/tt.h        |    1 -
 drivers/net/wireless/intel/iwlwifi/fw/api/alive.h  |    4 +-
 .../net/wireless/intel/iwlwifi/fw/api/commands.h   |    7 +-
 .../net/wireless/intel/iwlwifi/fw/api/context.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/d3.h     |    2 +-
 .../net/wireless/intel/iwlwifi/fw/api/datapath.h   |   19 +-
 .../net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h    |    9 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h    |  129 +
 .../net/wireless/intel/iwlwifi/fw/api/location.h   |   66 +-
 .../net/wireless/intel/iwlwifi/fw/api/mac-cfg.h    |   95 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/phy.h    |   18 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h     |   52 +
 drivers/net/wireless/intel/iwlwifi/fw/api/sta.h    |    1 +
 .../net/wireless/intel/iwlwifi/fw/api/time-event.h |   42 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  108 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |    3 -
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.c |   56 +-
 drivers/net/wireless/intel/iwlwifi/fw/regulatory.h |    4 +
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h    |    2 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c       |    3 +
 drivers/net/wireless/intel/iwlwifi/iwl-config.h    |   23 +-
 .../wireless/intel/iwlwifi/iwl-context-info-gen3.h |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-debug.h     |    9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   24 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c     |    5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |   11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c        |    2 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c |  119 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-responder.c |   86 -
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c        |   54 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c  |   23 -
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  |    9 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c       |   61 -
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h       |    4 -
 .../net/wireless/intel/iwlwifi/mvm/time-event.c    |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        |    4 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c   |    5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  237 +-
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c |   15 +-
 drivers/net/wireless/marvell/libertas/cmd.c        |  143 +-
 drivers/net/wireless/marvell/libertas/cmd.h        |   10 -
 drivers/net/wireless/marvell/libertas/cmdresp.c    |    1 -
 drivers/net/wireless/marvell/libertas/decl.h       |    4 -
 drivers/net/wireless/marvell/libertas/dev.h        |    4 -
 drivers/net/wireless/marvell/libertas/main.c       |   88 +-
 drivers/net/wireless/marvell/mwifiex/main.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/main.h        |    4 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |    4 +-
 drivers/net/wireless/marvell/mwifiex/uap_event.c   |   16 -
 drivers/net/wireless/marvell/mwifiex/usb.c         |    4 +-
 drivers/net/wireless/quantenna/qtnfmac/qlink.h     |   21 +-
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |    2 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   17 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |    6 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   15 +
 drivers/net/wireless/realtek/rtw88/fw.h            |    1 +
 drivers/net/wireless/realtek/rtw88/mac.c           |    6 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   18 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   36 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    4 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |  191 +-
 drivers/net/wireless/realtek/rtw88/phy.h           |   20 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   16 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   16 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/sar.c           |    2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    2 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |    2 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |   28 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    2 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 2829 +++++++++++---------
 drivers/net/wireless/realtek/rtw89/coex.h          |   18 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  192 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  169 +-
 drivers/net/wireless/realtek/rtw89/debug.c         | 2054 ++++++++------
 drivers/net/wireless/realtek/rtw89/fw.c            |  189 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   46 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   31 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  283 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  746 +++---
 drivers/net/wireless/realtek/rtw89/phy.h           |   15 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    6 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    5 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  574 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   15 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   63 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   17 +-
 drivers/net/wireless/realtek/rtw89/util.c          |   11 +
 drivers/net/wireless/realtek/rtw89/util.h          |    5 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |    7 +-
 drivers/net/wireless/virtual/mac80211_hwsim.c      |    1 +
 include/linux/ieee80211.h                          |   12 +
 include/net/cfg80211.h                             |   48 +-
 include/net/dropreason.h                           |    6 -
 include/net/mac80211.h                             |   38 +-
 include/uapi/linux/nl80211.h                       |    4 +-
 net/mac80211/agg-rx.c                              |   22 +-
 net/mac80211/agg-tx.c                              |    9 +-
 net/mac80211/cfg.c                                 |   23 +-
 net/mac80211/chan.c                                |   20 +-
 net/mac80211/debugfs.c                             |   44 +-
 net/mac80211/driver-ops.h                          |    3 +-
 net/mac80211/drop.h                                |   21 +-
 net/mac80211/ethtool.c                             |    2 +-
 net/mac80211/ieee80211_i.h                         |   30 +-
 net/mac80211/iface.c                               |   76 +-
 net/mac80211/main.c                                |   16 +-
 net/mac80211/mesh_hwmp.c                           |   14 +-
 net/mac80211/mlme.c                                |  582 +++-
 net/mac80211/rx.c                                  |  219 +-
 net/mac80211/sta_info.c                            |   64 +-
 net/mac80211/status.c                              |   34 +-
 net/mac80211/tests/Makefile                        |    2 +-
 net/mac80211/tests/chan-mode.c                     |  254 ++
 net/mac80211/tests/util.c                          |    6 +-
 net/mac80211/tx.c                                  |    5 +-
 net/mac80211/util.c                                |    3 +-
 net/rfkill/rfkill-gpio.c                           |    3 +
 net/wireless/core.h                                |    1 -
 net/wireless/nl80211.c                             |   19 +-
 net/wireless/scan.c                                |    8 +-
 net/wireless/trace.h                               |    2 +-
 153 files changed, 6392 insertions(+), 4805 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h
 create mode 100644 net/mac80211/tests/chan-mode.c

