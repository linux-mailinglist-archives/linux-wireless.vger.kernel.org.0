Return-Path: <linux-wireless+bounces-14965-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8DB9BDF94
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7562835A3
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469181D27A9;
	Wed,  6 Nov 2024 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="trxhU5Zm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F541CF2A6
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 07:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730878866; cv=none; b=FS6o/+8vLJMRNOeqnDYGmlJh4IDggHb/0x3FwYnflcZ6ckBTPssVv6CubrPtKubFIkNUN4a836llUiKGQovX393cWm4oaS4BvqvhVnIuIdCshq2O+FIkTTei3P2atcR0gg9RLqv0IJkL92GQ2DB05V11b39a5eSa2DGMTuge6Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730878866; c=relaxed/simple;
	bh=2xG40PLG+7LNH36Jf4qWz3ke6gBzHABewMI7HXayeyg=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=X/sFYNns2jNHsKEztE/fXXcmM2DJhTp4NVDNplQHDUFZkBVPa+mFintqClOzO2GegpmxfGrSsfL4Z6ZB5p88JRP7AFyA9+I7Wu/cccpjAYOMOoCJZJw0QgaHFlSENBjMtRdHxhxfljSHGxmqMQCz6NLp6IjENZuUK3DVqPzY+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=trxhU5Zm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A67exXkB2393667, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730878859; bh=2xG40PLG+7LNH36Jf4qWz3ke6gBzHABewMI7HXayeyg=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=trxhU5Zm3i0cSsFlx1QVd1jiGzY1FZPT/6JPVDvf6HozNGO4A4433OkygPsOewmEQ
	 1/5PbgElwqkjiKfQE6fWHcwNPYOBHV3/KO83zWWlG4mehLKY+oGrfyHSgM6sFqoo/I
	 2RfJKVcNNTOtINp45pjmLICBDTzzXSm/2c/1juzC0GsYonFzNLomh49uIyK5jhn5jT
	 pdMCZ4QqoPadE0MeyZzbyymVFKCEzvyZIkGhFa3yX50oXV0BAudUBHA3FklNp6weY4
	 bNSJXiNPmMy5gVmc1pfOBIM6ZbnpO1CuMCY0hxU5tsvhhRdj5qZRgKS23ITrCH8YO4
	 vJ5FZMzGr85Aw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A67exXkB2393667
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 6 Nov 2024 15:40:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 6 Nov 2024 15:40:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Nov
 2024 15:40:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-11-06
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <32a36217-21db-4234-bd05-b05fae3eaea4@RTEXMBS04.realtek.com.tw>
Date: Wed, 6 Nov 2024 15:40:59 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 1f3de77752a7bf0d1beb44603f048eb46948b9fe:

  Merge tag 'rtw-next-2024-10-10' of https://github.com/pkshih/rtw (2024-10-17 20:21:22 +0300)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-11-06

for you to fetch changes up to d41df04183dbeea02b9bffdedb3dd14e4b3d3334:

  wifi: rtlwifi: Remove some exhalbtc deadcode (2024-11-06 14:35:54 +0800)

----------------------------------------------------------------
rtw-next patches for v6.13

Major changes are listed:

rtw88:
 - support two USB adapters 8821au and 8812au

rtw89:
 - add thermal protection
 - fine tune BT-coexsitence to improve user experience
 - firmware secure boot for WiFi 6 chip
 - more materials for MLO

----------------------------------------------------------------
Arnd Bergmann (1):
      wifi: rtw89: fix -Wenum-compare-conditional warnings

Bitterblue Smith (23):
      wifi: rtw88: Report the signal strength only if it's known
      wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
      wifi: rtw88: Dump the HW features only for some chips
      wifi: rtw88: Allow different C2H RA report sizes
      wifi: rtw88: Extend the init table parsing for RTL8812AU
      wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
      wifi: rtw88: Let each driver control the power on/off process
      wifi: rtw88: Enable data rate fallback for older chips
      wifi: rtw88: Make txagc_remnant_ofdm an array
      wifi: rtw88: Support TX page sizes bigger than 128
      wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
      wifi: rtw88: usb: Set pkt_info.ls for the reserved page
      wifi: rtw88: Detect beacon loss with chips other than 8822c
      wifi: rtw88: coex: Support chips without a scoreboard
      wifi: rtw88: 8821a: Regularly ask for BT info updates
      wifi: rtw88: 8812a: Mitigate beacon loss
      wifi: rtw88: Add rtw8812a_table.{c,h}
      wifi: rtw88: Add rtw8821a_table.{c,h}
      wifi: rtw88: Add rtw88xxa.{c,h}
      wifi: rtw88: Add rtw8821a.{c,h}
      wifi: rtw88: Add rtw8812a.{c,h}
      wifi: rtw88: Add rtw8821au.c and rtw8812au.c
      wifi: rtw88: Enable the new RTL8821AU/RTL8812AU drivers

Chih-Kang Chang (2):
      wifi: rtw89: set pause_data field to avoid transmitting data in scan channels
      wifi: rtw89: 8852b: change RF mode to normal mode when set channel

Chin-Yen Lee (1):
      wifi: rtw89: don't check done-ack for entering PS

Ching-Te Ku (2):
      wifi: rtw89: coex: Set Wi-Fi/Bluetooth priority for Wi-Fi scan case
      wifi: rtw89: coex: set higher priority to BT when WL scan and BT A2DP exist

Dan Carpenter (1):
      wifi: rtw89: unlock on error path in rtw89_ops_unassign_vif_chanctx()

Dr. David Alan Gilbert (1):
      wifi: rtlwifi: Remove some exhalbtc deadcode

Guilherme G. Piccoli (1):
      wifi: rtlwifi: Drastically reduce the attempts to read efuse in case of failures

Kuan-Chung Chen (1):
      wifi: rtw89: 8922a: fill the missing OP1dB configuration

Mohammed Anees (1):
      wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate

Pei Xiao (1):
      wifi: rtw89: coex: check NULL return of kmalloc in btc_fw_set_monreg()

Ping-Ke Shih (18):
      wifi: rtw89: wow: cast nd_config->delay to u64 in tsf arithmetic
      wifi: rtw89: pci: use 'int' as return type of error code in poll_{tx,rx}dma_ch_idle()
      wifi: rtw89: 8851b: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852b: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852bt: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: 8852c: use 'int' as return type of error code pwr_{on,off}_func()
      wifi: rtw89: sar: add supported UNII-4 frequency range along with UNII-3 of SAR subband
      wifi: rtw89: add thermal protection
      wifi: rtw89: pci: add quirks by PCI subsystem ID for thermal protection
      wifi: rtlwifi: use MODULE_FIRMWARE() to declare used firmware
      wifi: rtw89: efuse: move reading efuse of fw secure info to common
      wifi: rtw89: efuse: move recognize firmware MSS info v1 to common
      wifi: rtw89: efuse: read firmware secure info v0 from efuse for WiFi 6 chips
      wifi: rtw89: fw: shrink download size of security section for RTL8852B
      wifi: rtw89: fw: set recorded IDMEM share mode in firmware header to register
      wifi: rtw89: fw: move v1 MSSC out of __parse_security_section() to share with v0
      wifi: rtw89: fw: use common function to parse security section for WiFi 6 chips
      wifi: rtw89: mac: no configure CMAC/DMAC tables for firmware secure boot

Po-Hao Huang (3):
      wifi: rtw89: Fix TX fail with A2DP after scanning
      wifi: rtw89: Add header conversion for MLO connections
      wifi: rtw89: Add encryption support for MLO connections

Zong-Zhe Yang (4):
      wifi: rtw89: regd: block 6 GHz if marked as N/A in regd map
      wifi: rtw89: chan: manage active interfaces
      wifi: rtw89: tweak setting of channel and TX power for MLO
      wifi: rtw89: 8922a: extend RFK handling and consider MLO

 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.c    |   11 -
 .../realtek/rtlwifi/btcoexist/halbtc8723b1ant.h    |    1 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.c       |   79 -
 .../realtek/rtlwifi/btcoexist/halbtcoutsrc.h       |   10 -
 drivers/net/wireless/realtek/rtlwifi/efuse.c       |   11 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    3 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    3 +
 drivers/net/wireless/realtek/rtw88/Kconfig         |   33 +
 drivers/net/wireless/realtek/rtw88/Makefile        |   15 +
 drivers/net/wireless/realtek/rtw88/coex.c          |   37 +-
 drivers/net/wireless/realtek/rtw88/coex.h          |   11 +
 drivers/net/wireless/realtek/rtw88/debug.c         |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   44 +-
 drivers/net/wireless/realtek/rtw88/fw.h            |   17 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   13 +-
 drivers/net/wireless/realtek/rtw88/mac.h           |    3 +
 drivers/net/wireless/realtek/rtw88/main.c          |   35 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   39 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |    2 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |   80 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |  174 ++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |   21 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    3 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      | 1102 ++++++++
 drivers/net/wireless/realtek/rtw88/rtw8812a.h      |   10 +
 .../net/wireless/realtek/rtw88/rtw8812a_table.c    | 2812 ++++++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8812a_table.h    |   26 +
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      | 1197 +++++++++
 drivers/net/wireless/realtek/rtw88/rtw8821a.h      |   10 +
 .../net/wireless/realtek/rtw88/rtw8821a_table.c    | 2350 ++++++++++++++++
 .../net/wireless/realtek/rtw88/rtw8821a_table.h    |   21 +
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |   28 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |   22 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |   24 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   20 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |   12 -
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |   28 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c      | 1989 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw88xxa.h      |  175 ++
 drivers/net/wireless/realtek/rtw88/rx.c            |   12 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |    2 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |    6 +-
 drivers/net/wireless/realtek/rtw88/tx.h            |    4 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |    5 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   51 +
 drivers/net/wireless/realtek/rtw89/cam.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  183 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |    8 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   10 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  188 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   62 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   10 +-
 drivers/net/wireless/realtek/rtw89/efuse.c         |  150 ++
 drivers/net/wireless/realtek/rtw89/efuse.h         |    2 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c      |   52 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  190 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |   23 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   40 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   13 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    2 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   37 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   15 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   34 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |    2 +
 drivers/net/wireless/realtek/rtw89/regd.c          |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    5 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |    8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   88 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   61 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    8 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    6 +-
 84 files changed, 11390 insertions(+), 500 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8812au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8821au.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw88xxa.h

