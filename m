Return-Path: <linux-wireless+bounces-20289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54775A5E998
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 02:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA90176333
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Mar 2025 01:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC854179BD;
	Thu, 13 Mar 2025 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="r5me4Axr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596F56FC5
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741831161; cv=none; b=YPdHQKmv2yxd9JzLoEyYKG8pBMZR3pFkrMWrDWsfF68NUu5IcZ25T2QboQKNxB80A//Wyzcweeq8EAIUuEe1AOOHfi6U/7mb/LH9xzN2diVq0cgp5L/SG6KH4g8MQl0i3vlCK0ne6SOtYeHO58W4vQLZNGptNTfMPK+N1cEfH0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741831161; c=relaxed/simple;
	bh=8wUeiNya8c03Hmir9d8hPr+lYsBJSIGcWUAN7fWdVHI=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=acW4oPIOVejS2ph28huxbwoUTnoI6GnptyWzCQke4WeGY+0pXwAjdEcEKlfo+pgGb3Wuf/nr5ocA4M8N8pH0Cb03gIRd5iu9HPzhRL2OhDlWIskXLps4S6h139K3gjK/cvR251T/q34DlqiTCiNpwIqQsKZtVI+65+UepbxFreI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=r5me4Axr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52D1xG6B1317566, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741831156; bh=8wUeiNya8c03Hmir9d8hPr+lYsBJSIGcWUAN7fWdVHI=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=r5me4AxrTC4VWtFFHqYrwGFik2VKlj93H/WZ+uCn/j4XeKY0rajqpn4Fk5Tzc5zzW
	 +t1K5SN9ldvsyc/0TLWPIhQnqT3ysWNV5KbG/Jiwb5zaMwBFd32hijXcFlSAGlnEg1
	 HZuqeGhS+25ysPN87j5gA7aJst289Zf537zzRN8U0DmZsQa/tpS8hJ9qBSDQdsj45q
	 ASBoH6Czj3AmoIMlBKF45TsZ5pXQBUoihlWe90oxWING6+9a+Vo6Wgym78bscEWTUc
	 K8tQBR1iYyIjHkIHOZFUG0Xdqi3otB3MLtf2aN0J/M9PPFC5CRsem3343lQ07k2cpZ
	 pP4xj0qqv0TUA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52D1xG6B1317566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 13 Mar 2025 09:59:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Mar 2025 09:59:16 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 13 Mar
 2025 09:59:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-03-13
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9052a8d7-63be-4aa2-af1c-364e23bfe84f@RTEXMBS04.realtek.com.tw>
Date: Thu, 13 Mar 2025 09:59:15 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit c61da149b9c2e439abe27845a71dae5ce5f5985c:

  Merge tag 'rtw-next-2025-02-10-v2' of https://github.com/pkshih/rtw (2025-02-11 15:56:20 +0100)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-03-13

for you to fetch changes up to d58ad77d5cc2a6d04db622a898e54d93fc7002a2:

  wifi: rtw88: Add __nonstring annotations for unterminated strings (2025-03-13 09:18:31 +0800)

----------------------------------------------------------------
rtw-next patches for v6.15

Some minor fixes and refinements of rtw89.

The only major change is rtw88:

 * support RTL8814AE/RTL8814AU

----------------------------------------------------------------
Bitterblue Smith (15):
      wifi: rtw88: Fix rtw_mac_power_switch() for RTL8814AU
      wifi: rtw88: Fix rtw_desc_to_mcsrate() to handle MCS16-31
      wifi: rtw88: Fix rtw_init_ht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_init_vht_cap() for RTL8814AU
      wifi: rtw88: Fix rtw_rx_phy_stat() for RTL8814AU
      wifi: rtw88: Extend rtw_phy_config_swing_table() for RTL8814AU
      wifi: rtw88: Extend rtw_debugfs_get_phy_info() for RTL8814AU
      wifi: rtw88: Extend rtw_debugfs_get_tx_pwr_tbl() for RTL8814AU
      wifi: rtw88: Add some definitions for RTL8814AU
      wifi: rtw88: Add rtw8814a_table.c (part 1/2)
      wifi: rtw88: Add rtw8814a_table.c (part 2/2)
      wifi: rtw88: Add rtw8814a.{c,h}
      wifi: rtw88: Add rtw8814ae.c
      wifi: rtw88: Add rtw8814au.c
      wifi: rtw88: Enable the new RTL8814AE/RTL8814AU drivers

Chih-Kang Chang (1):
      wifi: rtw89: Parse channel from IE to correct invalid hardware reports during scanning

Ching-Te Ku (4):
      wifi: rtw89: coex: RTL8852BT coexistence Wi-Fi firmware support for 0.29.122.0
      wifi: rtw89: coex: Fix coexistence report not show as expected
      wifi: rtw89: coex: Add parser for Bluetooth channel map report version 7
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 7.0.4

Dian-Syuan Yang (1):
      wifi: rtw89: set force HE TB mode when connecting to 11ax AP

Dmitry Antipov (1):
      wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps

Kees Cook (1):
      wifi: rtw88: Add __nonstring annotations for unterminated strings

Kuan-Chung Chen (6):
      wifi: rtw89: 8922a: fix incorrect STA-ID in EHT MU PPDU
      wifi: rtw89: add support for HW TKIP crypto
      wifi: rtw89: add support for negative values of dBm to linear conversion
      wifi: rtw89: refine mechanism of TAS
      wifi: rtw89: enable dynamic antenna gain based on country
      wifi: rtw89: 8922a: enable dynamic antenna gain

Ping-Ke Shih (10):
      wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to share common flow
      wifi: rtw89: add H2C command of TX time for WiFi 7 chips
      wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
      wifi: rtw89: fw: get sb_sel_ver via get_unaligned_le32()
      wifi: rtw89: fw: propagate error code from rtw89_h2c_tx()
      wifi: rtw89: fw: add debug message for unexpected secure firmware
      wifi: rtw89: fw: safely cast mfw_hdr pointer from firmware->data
      wifi: rtw89: fw: correct debug message format in rtw89_build_txpwr_trk_tbl_from_elm()
      wifi: rtw89: fw: don't reject firmware in blacklist to prevent breaking users
      wifi: rtw89: pci: correct ISR RDU bit for 8922AE

Po-Hao Huang (2):
      wifi: rtw89: fw: use struct to fill role_maintain H2C command
      wifi: rtw89: fw: update role_maintain H2C command for roles operating on band 1

Zenm Chen (1):
      wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1

 drivers/net/wireless/realtek/rtw88/Kconfig         |    25 +
 drivers/net/wireless/realtek/rtw88/Makefile        |     9 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    57 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |     1 +
 drivers/net/wireless/realtek/rtw88/main.c          |    40 +-
 drivers/net/wireless/realtek/rtw88/main.h          |     9 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |    24 +
 drivers/net/wireless/realtek/rtw88/reg.h           |    66 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |  2257 ++
 drivers/net/wireless/realtek/rtw88/rtw8814a.h      |    62 +
 .../net/wireless/realtek/rtw88/rtw8814a_table.c    | 23930 +++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8814a_table.h    |    40 +
 drivers/net/wireless/realtek/rtw88/rtw8814ae.c     |    31 +
 drivers/net/wireless/realtek/rtw88/rtw8814au.c     |    54 +
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |     4 +
 drivers/net/wireless/realtek/rtw88/rx.c            |     6 +
 drivers/net/wireless/realtek/rtw88/util.c          |     3 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |     6 +
 drivers/net/wireless/realtek/rtw89/chan.c          |    10 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |    16 +-
 drivers/net/wireless/realtek/rtw89/core.c          |    48 +-
 drivers/net/wireless/realtek/rtw89/core.h          |    39 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |     1 +
 drivers/net/wireless/realtek/rtw89/fw.c            |   180 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |    57 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |    49 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |     4 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |     1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |     6 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |    56 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |     2 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |    41 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |     7 +
 drivers/net/wireless/realtek/rtw89/reg.h           |    39 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |    27 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |     5 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |     6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |    13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |    13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |     7 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    59 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   369 +-
 drivers/net/wireless/realtek/rtw89/sar.h           |     5 +-
 drivers/net/wireless/realtek/rtw89/util.c          |   215 +-
 drivers/net/wireless/realtek/rtw89/util.h          |     8 +-
 48 files changed, 27583 insertions(+), 339 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814ae.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8814au.c

