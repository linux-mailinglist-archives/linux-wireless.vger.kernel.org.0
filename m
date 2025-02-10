Return-Path: <linux-wireless+bounces-18706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F87A2ED23
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 14:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B937A281E
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 13:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54E92236FF;
	Mon, 10 Feb 2025 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fXXCNvKH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1032236E2
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739192685; cv=none; b=rbIWcIR2zzu6i3JPYPbDCDoH1UXlInnAiJpy6lb+cxObUb76o6rdhvOkMHzoUkyQgojfOWV0jzEPc2V66douzcboKzp5QnvBfyhvrmRvolnMy2Ab/4N6CXenU2OJiPBpTgrtNnKH4Yifu1YEjd2AAnTev4kQlPQxmD4kkDI0pj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739192685; c=relaxed/simple;
	bh=hT2p9PUWBNJgKleMJ+pPTPCJSTcshv6swXLCha+5nxo=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=UHI1eAtlBgeyvivQKeKa6yJvzNPwRWlXQfQpCzPoKlPWMj2IXNJnIiLg20Sbp1Ylas99TJYZMTCxchds+5Olri6MIWB2uqn8RIq7e6scTkNrno1F/tBcK6faYuyAn1AnbLW9Tmkl04tDaJtnBp+KfQo3RLhtBgpJn/Kf/dVThZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fXXCNvKH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51AD4b0222247033, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739192677; bh=hT2p9PUWBNJgKleMJ+pPTPCJSTcshv6swXLCha+5nxo=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=fXXCNvKHD0v106HUAFerKCnzqmfqFe9gCdm/PSZ8MAbCzz0CoS7pUICTAc59bg3RS
	 nhAnKWTp2MdrW4BehG3B1htYHFKq22c4tifJzvGUS/RAgDYzSfrgtGpjPxvnZKqSQ5
	 OWk5x6I9pwxsRMCLnjLVNeLwy2CHXzQCiD6bWPbJi0VwqiBCvf6RE4TEXnHUkYfyWa
	 spNiueqLFm/kUVJFjfgMFEhn9DYV3fe1OR0UmP9PHcndiesHGLKYx3KBx40M/j8TGe
	 pVlyrKNwRZXhNdDThjACyJWYiNRxTwZlaoOpv20boFAsh1SbeEaNDsFAL38V3irmqE
	 prlAfQC7Df8dA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51AD4b0222247033
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 21:04:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 21:04:38 +0800
Received: from [127.0.1.1] (172.16.24.241) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 10 Feb
 2025 21:04:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-02-10-v2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b65fae15-79bf-40fa-8acc-63d87ae35e19@RTEXMBS04.realtek.com.tw>
Date: Mon, 10 Feb 2025 21:04:32 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 59372af69d4d71e6487614f1b35712cf241eadb4:

  Merge tag 'batadv-next-pullrequest-20250117' of git://git.open-mesh.org/linux-merge (2025-01-18 17:57:31 -0800)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-02-10-v2

for you to fetch changes up to a0519433ad8d347d8fb0e7f118f468456dff00fd:

  wifi: rtw89: debugfs depends on CFG80211's one (2025-02-10 20:56:47 +0800)

----------------------------------------------------------------
rtw-next patches for v6.15

Major changes are listed below:

rtw88:

 * preparation to support RTL8814AU

rtw89:

 * switch using wiphy_lock and wiphy_work

 * add BB context to manipulate two PHY as preparation of MLO

 * improve BT-coexistence mechanism to play A2DP smoothly

 * firmware file can contain regd table

----------------------------------------------------------------
Andrew Kreimer (2):
      wifi: rtw88: Fix a typo of debug message in rtw8723d_iqk_check_tx_failed()
      wifi: rtlwifi: rtl8192de: Fix typos of debug message of phy setting

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

Ching-Te Ku (6):
      wifi: rtw89: coex: Add protect to avoid A2DP lag while Wi-Fi connecting
      wifi: rtw89: coex: Separated Wi-Fi connecting event from Wi-Fi scan event
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.2
      wifi: rtw89: coex: Assign value over than 0 to avoid firmware timer hang
      wifi: rtw89: coex: To avoid TWS serials A2DP lag, adjust slot arrangement
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.3

Eric Huang (1):
      wifi: rtw89: ps: update H2C command with more info for PS

Ezra Buehler (1):
      wifi: rtl8xxxu: Enable AP mode for RTL8192CU (RTL8188CUS)

Liang Jie (1):
      wifi: rtw89: Correct immediate cfg_len calculation for scan_offload_be

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

Soeren Moch (1):
      wifi: rtl8xxxu: retry firmware download on error

Zong-Zhe Yang (4):
      wifi: rtw89: regd: support loading regd table from fw element
      wifi: rtw89: regd: handle supported regulatory functions by country
      wifi: rtw89: regd: refactor init/setup flow and prototype
      wifi: rtw89: cleanup unused rtwdev::roc_work

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
 drivers/net/wireless/realtek/rtw89/coex.c          | 2945 +++++++++++---------
 drivers/net/wireless/realtek/rtw89/coex.h          |   18 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  192 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  169 +-
 drivers/net/wireless/realtek/rtw89/debug.c         | 2062 ++++++++------
 drivers/net/wireless/realtek/rtw89/fw.c            |  189 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   46 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   31 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  281 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  748 ++---
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
 51 files changed, 4471 insertions(+), 3438 deletions(-)

