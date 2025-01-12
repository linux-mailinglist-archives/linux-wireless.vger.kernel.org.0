Return-Path: <linux-wireless+bounces-17367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F26A0A6FA
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 03:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE7B18889E8
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Jan 2025 02:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22592881E;
	Sun, 12 Jan 2025 02:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="cgc1HiMS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B441E522
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 02:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736648836; cv=none; b=Z0Jbo3GTUGpggxWyvOTYje9nBu3qS3G16ZCGm9x5aUsSgOyUVj4vNNN5X3/Vsi5WNhBuwv93fXERzgQ0bNlYhTkth0JaKwaYM+rQn0GfZpZyoMNBm/JfuvRPw+zgVK5uZXm6PqRz4UlmihrbbdUP8dNMHcjgejsBYeqGZterZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736648836; c=relaxed/simple;
	bh=F0o0Qq2ZGNc6+cIVOixw1evcpENHuQ41qGXLMpyAdNQ=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=j7GOHyqsSjjsw4IbOjGBXRtViurUo1Yy5ymF+B5ecGVXFtki4JpNWvGKcafTaYvNqMqkM58ASibKgSMVoadJRGk72n/JY+5zda4kOLWc2Mz6sYDeI0h/HWfixNBlKCtX1u1lhFMT3IcVZKVt0It170i9EGinggmK4Gmx7VJVmTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=cgc1HiMS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50C2RArX41636971, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736648830; bh=F0o0Qq2ZGNc6+cIVOixw1evcpENHuQ41qGXLMpyAdNQ=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=cgc1HiMSxRUGGRVwfoJ+oCxInvaHK/uek0CNc/T1OuCkUf8829l4/nd/CQr6234Oe
	 K6QizoTKeLvdzjNM+VpoOYBim+pSrzNo71VI6tv8fjJTMvPB/+7YnKD20BhV77msaH
	 FRhV9tBEqX6Jndwjj5JjnA5RRqjilIVBkyld99o6soxBAUwxrBxSvf/5UiQMa4n5gP
	 L5Mzq85p3kezQOtB545l87revtO7yutgVAur59TBsm2dNrSut3MlHhV1a3vi9EiBda
	 DVrnuAVCJMakRuSz/iV8UUf7szR/6ppGwxrUhTfmFmtyaovKZiprOZK6aPn5CmBbHd
	 JDTBb2Fplkcsg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50C2RArX41636971
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 12 Jan 2025 10:27:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 12 Jan 2025 10:27:10 +0800
Received: from [127.0.1.1] (172.16.16.103) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 12 Jan
 2025 10:27:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-01-12
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <b02292db-3d80-49d9-a95f-1d70c0af5321@RTEXMBS04.realtek.com.tw>
Date: Sun, 12 Jan 2025 10:27:09 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 104372ff359486b26b5a2db33b8e1dc6bfb39812:

  Merge tag 'rtw-next-2024-12-12' of https://github.com/pkshih/rtw (2024-12-13 14:57:06 +0200)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-01-12

for you to fetch changes up to 4b6652bc6d8d5fb0648b3a7a16ef8af4e0345bcd:

  wifi: rtw88: Add support for LED blinking (2025-01-12 10:07:38 +0800)

----------------------------------------------------------------
rtw-next patches for v6.14

rtl8xxxu, rtlwifi and rtw88 fix field issues reported by users.
rtw89 is ongoing to implement MLO and fix issues during the development.

Major changes:

rtw88:

 - support LED blinking

rtw89:

 - support RTL8922AE-VS chip

----------------------------------------------------------------
Bitterblue Smith (10):
      wifi: rtlwifi: rtl8821ae: Fix media status report
      wifi: rtw88: 8812a: Support RFE type 2
      wifi: rtw88: 8821a/8812a: Set ptct_efuse_size to 0
      wifi: rtw88: usb: Copy instead of cloning the RX skb
      wifi: rtw88: Handle C2H_ADAPTIVITY in rtw_fw_c2h_cmd_handle()
      wifi: rtw88: usb: Preallocate and reuse the RX skbs
      wifi: rtl8xxxu: Fix RTL8188EU firmware upload block size
      wifi: rtw88: Add USB PHY configuration
      wifi: rtw88: Delete rf_type member of struct rtw_sta_info
      wifi: rtw88: Add support for LED blinking

Chih-Kang Chang (2):
      wifi: rtw89: adjust thermal protection step and more RTL8852BE-VT ID
      wifi: rtw89: avoid to init mgnt_entry list twice when WoWLAN failed

Chin-Yen Lee (1):
      wifi: rtw89: pci: disable PCI completion timeout control

Fiona Klute (1):
      wifi: rtw88: sdio: Fix disconnection after beacon loss

Ping-Ke Shih (5):
      wifi: rtw88: add __packed attribute to efuse layout struct
      wifi: rtw89: pci: treat first receiving part as first segment for 8922AE
      wifi: rtw89: fix race between cancel_hw_scan and hw_scan completion
      wifi: rtw89: read hardware capabilities part 1 via firmware command
      wifi: rtw89: 8922ae: add variant info to support RTL8922AE-VS

Po-Hao Huang (1):
      wifi: rtw89: correct header conversion rule for MLO only

Vasily Khoruzhick (1):
      wifi: rtw88: 8703b: Fix RX/TX issues

Zong-Zhe Yang (4):
      wifi: rtw89: debug: print regd for QATAR/UK/THAILAND
      wifi: rtw89: fix proceeding MCC with wrong scanning state after sequence changes
      wifi: rtw89: chan: fix soft lockup in rtw89_entity_recalc_mgnt_roles()
      wifi: rtw89: mcc: consider time limits not divisible by 1024

 drivers/net/wireless/realtek/rtl8xxxu/8188e.c      |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/fw.h    |   4 +-
 drivers/net/wireless/realtek/rtw88/Makefile        |   2 +
 drivers/net/wireless/realtek/rtw88/fw.c            |   7 +-
 drivers/net/wireless/realtek/rtw88/led.c           |  73 ++++++++
 drivers/net/wireless/realtek/rtw88/led.h           |  25 +++
 drivers/net/wireless/realtek/rtw88/main.c          |  21 ++-
 drivers/net/wireless/realtek/rtw88/main.h          |  10 +-
 drivers/net/wireless/realtek/rtw88/reg.h           |  22 +++
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |   8 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |   8 +-
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |  22 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |  28 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |  19 ++
 drivers/net/wireless/realtek/rtw88/rtw8821c.h      |   9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |  19 ++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h      |   9 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |  19 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h      |   9 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   2 +
 drivers/net/wireless/realtek/rtw88/usb.c           | 195 +++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/usb.h           |   3 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |   6 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  31 +++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   9 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  29 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |  18 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   3 +
 drivers/net/wireless/realtek/rtw89/fw.c            |  66 ++++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  16 ++
 drivers/net/wireless/realtek/rtw89/mac.c           |  94 ++++++++--
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  12 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  24 ++-
 drivers/net/wireless/realtek/rtw89/pci.h           |   4 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  10 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |  10 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.h      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |  17 +-
 44 files changed, 762 insertions(+), 122 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/led.h

