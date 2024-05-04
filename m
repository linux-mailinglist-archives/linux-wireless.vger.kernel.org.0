Return-Path: <linux-wireless+bounces-7164-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B08BBB7C
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 14:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352951C20CC8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2024 12:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CF31C695;
	Sat,  4 May 2024 12:44:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFA74A1C
	for <linux-wireless@vger.kernel.org>; Sat,  4 May 2024 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826654; cv=none; b=fEYB2CSXXrEEicF83RoDvD/TBaZ/uGzYbBpBWcrVEtClIvxzX78wCPHVchF4JndDL4nleoRPUGWsR+2ud/Uz1eg6yacggJSLN8JeFQnhb2hlR+Uqsu8R6nZuy3e/pCDRiTTFJryrW+IyaHqViG34q8otlxWiNcLwgOP06gEMp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826654; c=relaxed/simple;
	bh=dBmalUrriOqenWODGTAidco780JevmcDEHNypLQWPmM=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=ZL0LjgHWuqoE6YSMym7I+dp8+o4JZ8mz7nikbeyLYRN0pJB3jfUplJ4HdfKY0/jG20SS9eBrM3lTofDLJDZWlocERHqmDvF4ylgrjkvyvkLpqBgOvE2EuiuBti3TBHWgOYv+t5p+3dfDG3+5Rl4HrYpOt/DgaBo1eN6jrnjkomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 444CGa9fA237257, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 444CGa9fA237257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 4 May 2024 20:16:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 4 May 2024 20:16:36 +0800
Received: from [127.0.1.1] (172.16.16.175) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 4 May
 2024 20:16:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-05-04-v2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <2ea1dde1-1baf-481d-9783-33b94c113521@RTEXMBS04.realtek.com.tw>
Date: Sat, 4 May 2024 20:16:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

This is v2 pull-request of rtw-next, which additionally fixes GCC
uninitialized warning, to wireless-next tree, more info below.

Thanks
Ping-Ke

---

The following changes since commit a35b36e6ee5dcf323d846ec3881159e4af90c9b4:

  wifi: mac80211: extend IEEE80211_KEY_FLAG_GENERATE_MMIE to other ciphers (2024-04-08 20:52:28 +0200)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-05-04-v2

for you to fetch changes up to 82b85a836a5911ccde97fcbfb642279f5b680ed0:

  wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask() (2024-05-04 20:05:14 +0800)

----------------------------------------------------------------
rtw-next patches for v6.10

Major changes are listed as below

rtl8xxxu:

 - remove rtl8xxxu_ prefix from filename
 - cleanup includes of header files

rtlwifi:

 - adjust code to share with coming support of rtl8192du

rtw89:

 - complete features of new WiFi 7 chip 8922AE including BT-coexistence
   and WoWLAN
 - use BIOS ACPI settings to set TX power and channels

----------------------------------------------------------------
Bitterblue Smith (10):
      wifi: rtl8xxxu: Fix the TX power of RTL8192CU, RTL8723AU
      wifi: rtl8xxxu: Add separate MAC init table for RTL8192CU
      wifi: rtl8xxxu: Add LED control code for RTL8192CU family
      wifi: rtl8xxxu: Add LED control code for RTL8723BU
      wifi: rtlwifi: rtl8192de: Fix 5 GHz TX power
      wifi: rtlwifi: rtl8192de: Fix low speed with WPA3-SAE
      wifi: rtlwifi: rtl8192de: Fix endianness issue in RX path
      wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
      wifi: rtlwifi: Clean up rtl8192d-common a bit
      wifi: rtlwifi: Adjust rtl8192d-common for USB

Chia-Yuan Li (1):
      wifi: rtw89: 8852c: refine power sequence to imporve power consumption

Chih-Kang Chang (10):
      wifi: rtw89: wow: refine WoWLAN flows of HCI interrupts and low power mode
      wifi: rtw89: wow: parsing Auth Key Management from associate request
      wifi: rtw89: wow: prepare PTK GTK info from mac80211
      wifi: rtw89: use struct to access firmware command h2c_dctl_sec_cam_v1
      wifi: rtw89: use struct to fill H2C of WoWLAN global configuration
      wifi: rtw89: wow: construct EAPoL packet for GTK rekey offload
      wifi: rtw89: wow: add GTK rekey feature related H2C commands
      wifi: rtw89: wow: update latest PTK GTK info to mac80211 after resume
      wifi: rtw89: wow: support 802.11w PMF IGTK rekey
      wifi: rtw89: wow: support WEP cipher on WoWLAN

Chin-Yen Lee (3):
      wifi: rtw89: reset AFEDIG register in power off sequence
      wifi: rtw89: wow: send RFK pre-nofity H2C command in WoWLAN mode
      wifi: rtw89: wow: add ARP offload feature

Ching-Te Ku (17):
      wifi: rtw89: coex: Allow Bluetooth doing traffic during Wi-Fi scan
      wifi: rtw89: coex: Add v7 firmware cycle status report
      wifi: rtw89: coex: Add version 3 report map of H2C command
      wifi: rtw89: coex: Add PTA path control condition for chip RTL8922A
      wifi: rtw89: coex: Update Bluetooth polluted Wi-Fi TX logic
      wifi: rtw89: coex: Add register monitor report v7 format
      wifi: rtw89: coex: Add GPIO signal control version 7
      wifi: rtw89: coex: Add coexistence firmware control report version 8
      wifi: rtw89: coex: Re-order the index for the report from firmware
      wifi: rtw89: coex: Add Wi-Fi null data status version 7
      wifi: rtw89: coex: Add Bluetooth scan parameter report version 7
      wifi: rtw89: coex: Add Bluetooth frequency hopping map version 7
      wifi: rtw89: coex: Add Bluetooth version report version 7
      wifi: rtw89: coex: Fix unexpected value in version 7 slot parameter
      wifi: rtw89: coex: Add Wi-Fi role v8 condition when set Bluetooth channel
      wifi: rtw89: coex: Add Wi-Fi role v8 condition when set BTG control
      wifi: rtw89: coex: Check and enable reports after run coex

Colin Ian King (1):
      wifi: rtlwifi: rtl8723be: Make read-only arrays static const

Gustavo A. R. Silva (1):
      wifi: rtlwifi: Remove unused structs and avoid multiple -Wfamnae warnings

Jiapeng Chong (1):
      wifi: rtw89: Remove the redundant else branch in the function rtw89_phy_get_kpath

Kalle Valo (2):
      wifi: rtl8xxxu: remove some unused includes
      wifi: rtl8xxxu: remove rtl8xxxu_ prefix from filenames

Kuan-Chung Chen (1):
      wifi: rtw89: fix CTS transmission issue with center frequency deviation

Martin Kaistra (2):
      Revert "wifi: rtl8xxxu: enable MFP support"
      wifi: rtl8xxxu: enable MFP support with security flag of RX descriptor

Ping-Ke Shih (6):
      wifi: rtw89: pci: correct TX resource checking for PCI DMA channel of firmware command
      wifi: rtw88: suppress messages of failed to flush queue
      wifi: rtw89: 8852b: update hardware parameters for RFE type 5
      wifi: rtl8xxxu: cleanup includes
      wifi: rtw89: correct aSIFSTime for 6GHz band
      wifi: rtlwifi: 8192d: initialize rate_mask in rtl92de_update_hal_rate_mask()

Zong-Zhe Yang (10):
      wifi: rtw89: sar: correct TX power boundary for MAC domain
      wifi: rtw89: fw: scan offload prohibit all 6 GHz channel if no 6 GHz sband
      wifi: rtw89: 8852c: update TX power tables to R69.1 (1 of 2)
      wifi: rtw89: 8852c: update TX power tables to R69.1 (2 of 2)
      wifi: rtw89: regd: block 6 GHz by policy if not specific country
      wifi: rtw89: regd: extend policy of UNII-4 for IC regulatory
      wifi: rtw89: acpi: process 6 GHz SP policy from ACPI DSM
      wifi: rtw89: regd: handle policy of 6 GHz SP according to BIOS
      wifi: rtw89: set WIPHY_FLAG_DISABLE_WEXT before MLO
      wifi: rtw89: 8922a: fix argument to hal_reset in bb_cfg_txrx_path

 .../realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} |   67 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} |   18 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} |   45 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} |   41 +-
 drivers/net/wireless/realtek/rtl8xxxu/Makefile     |    6 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c}   |   75 +-
 .../realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h}   |    0
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   13 +-
 drivers/net/wireless/realtek/rtlwifi/Kconfig       |    4 +
 drivers/net/wireless/realtek/rtlwifi/Makefile      |    1 +
 drivers/net/wireless/realtek/rtlwifi/cam.c         |    5 +-
 drivers/net/wireless/realtek/rtlwifi/cam.h         |    6 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |    2 +-
 drivers/net/wireless/realtek/rtlwifi/efuse.h       |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192d/Makefile |   11 +
 .../realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h  |    0
 .../wireless/realtek/rtlwifi/rtl8192d/dm_common.c  | 1061 ++++++++
 .../wireless/realtek/rtlwifi/rtl8192d/dm_common.h  |   79 +
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.c  |  370 +++
 .../wireless/realtek/rtlwifi/rtl8192d/fw_common.h  |   49 +
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  | 1225 +++++++++
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.h  |   24 +
 .../net/wireless/realtek/rtlwifi/rtl8192d/main.c   |    9 +
 .../wireless/realtek/rtlwifi/rtl8192d/phy_common.c |  856 +++++++
 .../wireless/realtek/rtlwifi/rtl8192d/phy_common.h |  111 +
 .../realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h  |  162 +-
 .../wireless/realtek/rtlwifi/rtl8192d/rf_common.c  |  359 +++
 .../wireless/realtek/rtlwifi/rtl8192d/rf_common.h  |   13 +
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.c |  516 ++++
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.h |  405 +++
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.c    | 1072 +-------
 .../net/wireless/realtek/rtlwifi/rtl8192de/dm.h    |   91 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.c    |  375 +--
 .../net/wireless/realtek/rtlwifi/rtl8192de/fw.h    |   37 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    | 1168 +--------
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.h    |   11 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/led.c   |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  918 +------
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.h   |   59 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.c    |  375 +--
 .../net/wireless/realtek/rtlwifi/rtl8192de/rf.h    |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |   12 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |  515 +---
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.h   |  433 ----
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   45 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |    3 +
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   33 +-
 drivers/net/wireless/realtek/rtw88/debug.h         |    1 +
 drivers/net/wireless/realtek/rtw88/mac.c           |    5 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          |   47 +
 drivers/net/wireless/realtek/rtw89/acpi.h          |   21 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |  120 +-
 drivers/net/wireless/realtek/rtw89/cam.h           |   71 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 1002 +++++++-
 drivers/net/wireless/realtek/rtw89/coex.h          |   36 +
 drivers/net/wireless/realtek/rtw89/core.c          |   13 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  242 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  338 ++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  466 +---
 drivers/net/wireless/realtek/rtw89/mac.c           |   50 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    7 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   28 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    5 +
 drivers/net/wireless/realtek/rtw89/pci.c           |    3 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |    6 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |    3 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    3 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  156 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   14 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   12 +-
 .../net/wireless/realtek/rtw89/rtw8852c_table.c    | 2616 --------------------
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |    4 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  716 +++++-
 drivers/net/wireless/realtek/rtw89/wow.h           |   57 +
 81 files changed, 8371 insertions(+), 8438 deletions(-)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188e.c => 8188e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8188f.c => 8188f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192c.c => 8192c.c} (90%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192e.c => 8192e.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8192f.c => 8192f.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8710b.c => 8710b.c} (99%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723a.c => 8723a.c} (90%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_8723b.c => 8723b.c} (98%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_core.c => core.c} (98%)
 rename drivers/net/wireless/realtek/rtl8xxxu/{rtl8xxxu_regs.h => regs.h} (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/Makefile
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/def.h (100%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/fw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/hw_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/main.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h
 rename drivers/net/wireless/realtek/rtlwifi/{rtl8192de => rtl8192d}/reg.h (90%)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192d/trx_common.h

