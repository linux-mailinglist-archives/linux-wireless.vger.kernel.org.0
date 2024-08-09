Return-Path: <linux-wireless+bounces-11156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCBA94C80A
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 03:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BC2B225E9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148098BFC;
	Fri,  9 Aug 2024 01:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="E/nlilEL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C166B8F66
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723166944; cv=none; b=u+lJSWteGil4rZP0vsfr0bxQcGEWm37qUTwwMBi5qhvaRWhUf4BNfnK86xVJdF5szJfoGwwymqZufXI95vgEX2+p3ZPRRFi6o4NU8FA2Io2J9yvxMAPwVcEb80VtAgl8bkkL8CAVPwBt23zLBWvvz9wpW/Av6Up6v/MZOlGe4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723166944; c=relaxed/simple;
	bh=U9KZyLDy3XxaS9EpouJmc5s1xv1Wj/qlP3g0FeY0xS0=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=R/++CKg/1CH4qEv6sxo89S7fs1yUITtHlBTKHtfcgVhNDrhaINjVgjo7+4Pxey8+TwnBCYZGkh2cNSQCTn1Va4abDSq25ojBzitLk74kGj8NxbxMfg9BgEZKiU/kHWm99jsghG/c3lqz93I6mltKeMllGX+y9uBx0E1swvRzb5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=E/nlilEL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4791Sxg06156418, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723166939; bh=U9KZyLDy3XxaS9EpouJmc5s1xv1Wj/qlP3g0FeY0xS0=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=E/nlilELbl9eqwLXajcQmtN1TXnHSkCl5/D7TfRDhHi1pQhD/knyNjNt6nooT+DR4
	 je48SpNZR6gjFrepvS8CLtBAoS5OawMDreWx13KAl+cEhMo+KxID05ixtxff2spfNu
	 JkMEVPQrkH0gENcjES/nKD/+5FHr8Sj6lyMC1XBucjxfBAhRquPfGtBjCFtWoVU+cl
	 bwll/fYRvU8hAaBo9rpTz5QpIFyseBs0xC125/Hc+BFVs028ToF5R33eFBKC/U/9YT
	 bFl+N7pSK/b4yCzZfMf+0ZrIzeONR7aa97WLn/Pci+bfk2AF7VoAkVUyJK6AnSVvQx
	 sbxeFBWjFJ0eQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4791Sxg06156418
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 09:28:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 09:28:59 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 09:28:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-08-09
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <ac0c5d1d-ae4f-4c65-b7b3-93ac5d1384a7@RTEXMBS04.realtek.com.tw>
Date: Fri, 9 Aug 2024 09:28:59 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 338a93cf4a18c2036b567e9f613367f7a52f2511:

  net: mctp-i2c: invalidate flows immediately on TX errors (2024-07-12 13:37:31 +0100)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-08-09

for you to fetch changes up to 002a5db9a52a0e7af0fa9a450d31049748435748:

  wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c (2024-08-09 09:12:51 +0800)

----------------------------------------------------------------
rtw-next patches for v6.12

A pull-request for v6.12 containing fixes and features, and list major
changes below:

rtw88:
 - improve USB performance by aggregation
 - fix RX bandwidth for rx_status

rtw89:
 - support new WiFi 6 chip RTL8852BE-VT
 - support WoWLAN net-detect feature
 - support hardware encryption in unicast management frames
 - support hardware rfkill

----------------------------------------------------------------
Bitterblue Smith (8):
      wifi: rtw88: Set efuse->ext_lna_5g - fix typo
      wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
      wifi: rtw88: 8822c: Fix reported RX band width
      wifi: rtw88: 8703b: Fix reported RX band width
      wifi: rtw88: usb: Init RX burst length according to USB speed
      wifi: rtw88: usb: Update the RX stats after every frame
      wifi: rtw88: usb: Support RX aggregation
      wifi: rtw88: Enable USB RX aggregation for 8822c/8822b/8821c

Chih-Kang Chang (1):
      wifi: rtw89: avoid to add interface to list twice when SER

Chin-Yen Lee (4):
      wifi: rtw89: wow: implement PS mode for net-detect
      wifi: rtw89: wow: add WoWLAN net-detect support
      wifi: rtw89: wow: add delay option for net-detect
      wifi: rtw89: wow: add net-detect support for 8852c

Colin Ian King (1):
      wifi: rtw89: 8852bt: rfk: Fix spelling mistake "KIP_RESOTRE" -> "KIP_RESTORE"

Dian-Syuan Yang (1):
      wifi: rtw89: correct VHT TX rate on 20MHz connection

Dmitry Antipov (1):
      wifi: rtw88: always wait for both firmware loading attempts

Kuan-Chung Chen (4):
      wifi: rtw89: add EVM statistics for 1SS rate
      wifi: rtw89: add support for hardware rfkill
      wifi: rtw89: 8922a: new implementation for RFK pre-notify H2C
      wifi: rtw89: add support for HW encryption in unicast management frames

Nick Morrow (1):
      wifi: rtw88: 8821cu: Remove VID/PID 0bda:c82c

Peter Robinson (2):
      wifi: rtl8xxxu: drop reference to staging drivers
      wifi: rtl8xxxu: add missing rtl8192cu USB IDs

Ping-Ke Shih (10):
      wifi: rtw88: debugfs: support multiple adapters debugging
      wifi: rtw89: 8852bt: add set_channel_rf
      wifi: rtw89: 8852bt: rfk: use predefined string choice for DPK enable/disable
      wifi: rtw89: 8852bt: add chip_info of RTL8852BT
      wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
      wifi: rtw89: 8852bt: declare firmware features of RTL8852BT
      wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
      wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig
      wifi: rtw89: 885xb: reset IDMEM mode to prevent download firmware failure
      wifi: rtw89: 8852c: support firmware format up to v1

Po-Hao Huang (2):
      wifi: rtw88: 8822c: Parse channel from IE to correct invalid hardware reports
      wifi: rtw89: 8922a: Add new fields for scan offload H2C command

Zong-Zhe Yang (10):
      wifi: rtw88: select WANT_DEV_COREDUMP
      wifi: rtw89: select WANT_DEV_COREDUMP
      wifi: rtw89: fix typo of rtw89_phy_ra_updata_XXX
      wifi: rtw89: chan: refine MCC re-plan flow when unassign chanctx
      wifi: rtw89: mcc: stop at a role holding chanctx
      wifi: rtw89: rename sub_entity to chanctx
      wifi: rtw89: pass rtwvif to RFK channel
      wifi: rtw89: pass rtwvif to RFK scan
      wifi: rtw89: fw: correct chan access in assoc_cmac_tbl_g7 and update_beacon_be
      wifi: rtw89: pass chanctx_idx to rtw89_btc_{path_}phymap()

 drivers/net/wireless/realtek/rtl8xxxu/Kconfig      |   5 +-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   6 +
 drivers/net/wireless/realtek/rtw88/Kconfig         |   1 +
 drivers/net/wireless/realtek/rtw88/debug.c         | 303 ++++----
 drivers/net/wireless/realtek/rtw88/debug.h         |   3 +
 drivers/net/wireless/realtek/rtw88/hci.h           |   7 +
 drivers/net/wireless/realtek/rtw88/main.c          |  23 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   6 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |  17 +
 drivers/net/wireless/realtek/rtw88/rtw8821cu.c     |   2 -
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |   4 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |  18 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |  24 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |  41 +
 drivers/net/wireless/realtek/rtw88/rx.h            |  15 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   2 +
 drivers/net/wireless/realtek/rtw88/usb.c           | 207 ++++-
 drivers/net/wireless/realtek/rtw89/Kconfig         |  16 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   8 +
 drivers/net/wireless/realtek/rtw89/cam.c           |  12 +-
 drivers/net/wireless/realtek/rtw89/chan.c          | 186 +++--
 drivers/net/wireless/realtek/rtw89/chan.h          |   6 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |   2 +-
 drivers/net/wireless/realtek/rtw89/coex.h          |  12 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 207 +++--
 drivers/net/wireless/realtek/rtw89/core.h          |  75 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   7 +-
 drivers/net/wireless/realtek/rtw89/fw.c            | 448 +++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  94 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  25 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |  11 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  35 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  25 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   2 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  82 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  27 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  36 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  23 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |  50 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  21 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |  50 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     | 843 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt.h     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 274 ++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |  93 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  31 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  42 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  29 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   8 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |   2 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   8 +-
 drivers/net/wireless/realtek/rtw89/util.h          |  18 +
 drivers/net/wireless/realtek/rtw89/wow.c           | 337 ++++++--
 drivers/net/wireless/realtek/rtw89/wow.h           |  23 +
 60 files changed, 3217 insertions(+), 652 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c

