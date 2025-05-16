Return-Path: <linux-wireless+bounces-23049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECE8AB9393
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 03:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E790C17A8BC
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 01:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11300221DA3;
	Fri, 16 May 2025 01:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="eW3bUSq0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A609B8F5E
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747358662; cv=none; b=mciDTTa7UAeWFHvcBWyVEr03jgZGAvbzQS4Z+MoQ6veAE3Pw6bSv+UUGwHvrs+EjRpLmYhfLlK/KYvoHr/NnxvDvFyWTp18gykx6beltMqajRBmnz+1Oe8X6vWJCzMP6FB7t5djPPgMoG8s7e3jFUWZZt9SqFnSQH+12UTJzrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747358662; c=relaxed/simple;
	bh=hlbcWaulLAqd9Slz1dPMlJXkqamhqhWqgHCZbNM3LmY=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=sivs6bIUezWVoQ1SaEkXoMbkI41RbvjKBSTf+ZvOz+qxw7mWkJ8ZQx6tYQiWLeIzslZ50kKQQ2EFSJz6A+lFLjbo0noGoF7Ky+Vu0lNvZFW4fyQPkHbolItktohC06a2VwXN5NW4W/FqILw9OnSfeMGdipyY6FWfxmbc/FHTTgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=eW3bUSq0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54G1OF4X0115848, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747358655; bh=hlbcWaulLAqd9Slz1dPMlJXkqamhqhWqgHCZbNM3LmY=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=eW3bUSq0NUHxmI6LUT3RRSb4MTZE+j2vmIk01Dj6ty6+sgeQY4aUVlkhVL1LVQnCS
	 dcI652/akxZCeHdJR6fuF3d9klj410AzYyYEBRoX6i1pQeOLf6MnoL7vJCcZLxkXfq
	 lpdOYAc6s79ekJj72lVR/218fSL6YY1klc4ySsBhVMajiFltCUzc/I3qL//A1ckyNF
	 1EKPAvZpZ9ri4s+wxhoAtMi7QFeYtva4nT7sxm7Ifgqid2SSmDTMLobdBafxKmA+eT
	 nBpr4qahRVs2Sze0Sh9PrCiQ5tdwWp5k1kPRBG1gUYGK9gK99ygzx31gp0KWx2yRaz
	 +6Yt1VIQOAjpw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54G1OF4X0115848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:24:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 May 2025 09:24:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 16 May
 2025 09:24:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-05-16
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <17e74675-70cc-43d7-a797-afb937030d34@RTEXMBS04.realtek.com.tw>
Date: Fri, 16 May 2025 09:24:16 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 1794d7ab34d2221ac7eb921b171e75b856e10561:

  wifi: mt76: mt7996: fix locking in mt7996_mac_sta_rc_work() (2025-03-19 19:44:25 +0100)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-05-16

for you to fetch changes up to 3cc35394fac15d533639c9c9e42f28d28936a4a0:

  wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips (2025-05-16 09:03:40 +0800)

----------------------------------------------------------------
rtw-next patches for v6.16

Some fixes and refinements across drivers, and regular development of
MLO and STA + P2P concurrency. Major changes are listed below.

rtw88:

 * improve throughput for RTL8814AU

rtw89:

 * support MLO

 * improve user experience for STA + P2P concurrency

 * dynamic antenna gain (DAG) with different power by antenna

 * load SAR tables from ACPI

----------------------------------------------------------------
Alexey Kodanev (1):
      wifi: rtw88: fix the 'para' buffer size to avoid reading out of bounds

Bitterblue Smith (10):
      wifi: rtw88: usb: Enable switching the RTL8814AU to USB 3
      wifi: rtw88: usb: Enable RX aggregation for RTL8814AU
      wifi: rtw88: Set AMPDU factor to hardware for RTL8814A
      wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
      wifi: rtw88: Fix the module names printed in dmesg
      wifi: rtw88: Fix RX aggregation settings for RTL8723DS
      wifi: rtw88: Handle RTL8723D(S) with blank efuse
      wifi: rtw88: usb: Reduce control message timeout to 500 ms
      wifi: rtw88: usb: Upload the firmware in bigger chunks
      wifi: rtw88: Fix the random "error beacon valid" messages for USB

Chen Ni (2):
      wifi: rtw88: sdio: Remove redundant 'flush_workqueue()' calls
      wifi: rtw88: usb: Remove redundant 'flush_workqueue()' calls

Chin-Yen Lee (1):
      wifi: rtw89: fix firmware scan delay unit for WiFi 6 chips

Dian-Syuan Yang (1):
      wifi: rtw89: leave idle mode when setting WEP encryption for AP mode

Dmitry Antipov (1):
      wifi: rtw88: do not ignore hardware read error during DPK

Dr. David Alan Gilbert (3):
      wifi: rtlwifi: Remove unused rtl_usb_{resume|suspend}
      wifi: rtlwifi: Remove uncalled stub rtl*_phy_ap_calibrate
      wifi: rtlwifi: Remove unused rtl_bb_delay()

Kees Cook (1):
      wifi: rtw89: fw: Remove "const" on allocation type

Kuan-Chung Chen (6):
      wifi: rtw89: 8922a: fix TX fail with wrong VCO setting
      wifi: rtw89: set pre-calculated antenna matrices for HE trigger frame
      wifi: rtw89: 8922a: increase beacon loss to 6 seconds
      wifi: rtw89: acpi: introduce country specific TAS enabling
      wifi: rtw89: phy: add C2H event handler for report of FW scan
      wifi: rtw89: constrain TX power according to dynamic antenna power table

Mingcong Bai (1):
      wifi: rtlwifi: disable ASPM for RTL8723BE with subsystem ID 11ad:1723

Ondrej Jirman (2):
      wifi: rtw89: Convert rtw89_core_set_supported_band to use devm_*
      wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data

Ping-Ke Shih (7):
      wifi: rtw89: set 2TX for 1SS rate by default
      wifi: rtw89: fw: cast mfw_hdr pointer from address of zeroth byte of firmware->data
      wifi: rtw89: phy: reset value of force TX power for MAC ID
      wifi: rtw89: 8852c: update supported firmware format to 2
      wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK
      wifi: rtw89: pci: configure manual DAC mode via PCI config API only
      wifi: rtw89: pci: enlarge retry times of RX tag to 1000

Po-Hao Huang (12):
      wifi: rtw89: 8922a: use SW CRYPTO when broadcast in MLO mode
      wifi: rtw89: Adjust management queue mapping for [MLO, HW-1]
      wifi: rtw89: Configure scan band when mlo_dbcc_mode changes
      wifi: rtw89: extend join_info H2C command for MLO fields
      wifi: rtw89: add MLD capabilities declaration
      wifi: rtw89: Fill in correct Rx link ID for MLO
      wifi: rtw89: allow driver to do specific band TX for MLO
      wifi: rtw89: send nullfunc based on the given link
      wifi: rtw89: add MLO track for MLSR switch decision
      wifi: rtw89: debug: extend dbgfs for MLO
      wifi: rtw89: debug: add MLD table dump
      wifi: rtw89: debug: add FW log component for MLO

Yuuki NAGAO (1):
      wifi: rtw88: rtw8822bu VID/PID for BUFFALO WI-U2-866DM

Zhen XIN (2):
      wifi: rtw88: sdio: map mgmt frames to queue TX_DESC_QSEL_MGMT
      wifi: rtw88: sdio: call rtw_sdio_indicate_tx_status unconditionally

Zong-Zhe Yang (37):
      wifi: rtw89: fix typo of "access" in rtw89_sar_info description
      wifi: rtw89: regd: introduce string getter for reuse
      wifi: rtw89: sar: introduce structure to wrap query parameters
      wifi: rtw89: sar: add skeleton for SAR configuration via ACPI
      wifi: rtw89: acpi: introduce method evaluation function for reuse
      wifi: rtw89: acpi: support loading static SAR table
      wifi: rtw89: acpi: support loading dynamic SAR tables and indicator
      wifi: rtw89: acpi: support loading GEO SAR tables
      wifi: rtw89: sar: add skeleton for different configs by antenna
      wifi: rtw89: 8922a: support different SAR configs by antenna
      wifi: rtw89: 8852c: support different SAR configs by antenna
      wifi: rtw89: 8852bx: support different SAR configs by antenna
      wifi: rtw89: regd: indicate if regd_UK TX power settings follow regd_ETSI
      wifi: rtw89: add suffix "_ax" to Wi-Fi 6 HW scan struct and func
      wifi: rtw89: refactor flow that hw scan handles channel list
      wifi: rtw89: mcc: make GO announce one-time NoA for HW scan process
      wifi: rtw89: don't re-randomize TSF of AP/GO
      wifi: rtw89: mcc: make GO+STA mode calculate dynamic beacon offset
      wifi: rtw89: mcc: handle the case where NoA start time has passed
      wifi: rtw89: mcc: update entire plan when courtesy config changes
      wifi: rtw89: mcc: support courtesy mechanism on both roles at the same time
      wifi: rtw89: mcc: refine filling function of start TSF
      wifi: rtw89: mcc: avoid that loose pattern sets negative timing for auxiliary GO
      wifi: rtw89: extend mapping from Qsel to DMA ch for MLO
      wifi: rtw89: roc: dynamically handle link id and link instance index
      wifi: rtw89: introduce helper to get designated link for MLO
      wifi: rtw89: extract link part from core tx write function
      wifi: rtw89: chan: re-calculate MLO DBCC mode during setting channel
      wifi: rtw89: add handling of mlo_link_cfg H2C command and C2H event
      wifi: rtw89: debug: add mlo_mode dbgfs
      wifi: rtw89: declare MLO support if prerequisites are met
      wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
      wifi: rtw89: mcc: drop queued chanctx changes when stopping
      wifi: rtw89: mcc: add courtesy mechanism conditions to P2P roles
      wifi: rtw89: mcc: introduce calculation of anchor pattern
      wifi: rtw89: mcc: deal with non-periodic NoA
      wifi: rtw89: mcc: avoid redundant recalculations if no chance to improve

 drivers/net/wireless/realtek/rtlwifi/core.c        |   11 -
 drivers/net/wireless/realtek/rtlwifi/core.h        |    1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192de/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   |    5 -
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.h   |    1 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |    4 -
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.h   |    1 -
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   12 -
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 -
 drivers/net/wireless/realtek/rtw88/coex.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/hci.h           |    8 +
 drivers/net/wireless/realtek/rtw88/mac.c           |   11 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    2 +
 drivers/net/wireless/realtek/rtw88/mac80211.c      |    2 +
 drivers/net/wireless/realtek/rtw88/main.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    4 +
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   61 +-
 drivers/net/wireless/realtek/rtw88/rtw8723cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723de.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723ds.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723du.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |   59 ++
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |   12 +
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    2 +
 drivers/net/wireless/realtek/rtw88/rtw8822be.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |    4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    5 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cs.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |    2 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   27 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   63 +-
 drivers/net/wireless/realtek/rtw89/acpi.c          | 1037 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/acpi.h          |  190 ++++
 drivers/net/wireless/realtek/rtw89/cam.c           |    7 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  418 +++++---
 drivers/net/wireless/realtek/rtw89/chan.h          |   17 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  493 +++++++---
 drivers/net/wireless/realtek/rtw89/core.h          |  144 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |  174 +++-
 drivers/net/wireless/realtek/rtw89/fw.c            |  480 +++++++--
 drivers/net/wireless/realtek/rtw89/fw.h            |   94 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   58 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   19 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   38 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    3 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   36 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  131 ++-
 drivers/net/wireless/realtek/rtw89/phy.h           |   15 +
 drivers/net/wireless/realtek/rtw89/phy_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/ps.c            |  147 +++
 drivers/net/wireless/realtek/rtw89/ps.h            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   15 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    2 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   24 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   30 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |    5 -
 drivers/net/wireless/realtek/rtw89/sar.c           |  296 +++++-
 drivers/net/wireless/realtek/rtw89/sar.h           |   19 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    3 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |   31 +
 drivers/net/wireless/realtek/rtw89/wow.c           |    3 +-
 85 files changed, 3740 insertions(+), 682 deletions(-)

