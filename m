Return-Path: <linux-wireless+bounces-13829-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 424C99979F7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 03:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3027284896
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 01:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4921105;
	Thu, 10 Oct 2024 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="T9K67kiU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49621C2E9
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 01:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728522393; cv=none; b=e+cqAC942VqNJRi3eSCr9xzRgrGfgRGycVTbcJHTVtEkltaOhZZnWpbl4mRHFswo8M99NXUeke35Xzl2MauuBj/2jJ+Uuh7WhMW7IDbqzH3Wrj8xKw72sef8PzJa3CDdbPaYJgvsjaPJgLYpc7m0ZsETIjoOnKmgWXHkhEcbFN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728522393; c=relaxed/simple;
	bh=seF9MRFwj/lp33VXjon+HZto+aeAaArbaD5jDbXLBPo=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=jUZcqzx+3Qb1lbB4RMNwcDJsBOAeXqpaysojzLbWGxlkHnjj95acAY5k3ohuongR1r/a+zDwmZeZAc11geET7CnibJbzGB2dlrpUzkaRUISk0AJsROXVWFCy9NJBgsqYHydYYRR126dpThWN+x5WBzJ6rBt6rJKbWzXB4r5dRBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=T9K67kiU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49A16S5e81586044, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1728522388; bh=seF9MRFwj/lp33VXjon+HZto+aeAaArbaD5jDbXLBPo=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=T9K67kiU9D4SCKyPvM+W03UaGIYNMUxSjWnmXijmVYL6a9jIcw4LzAz0UzEbd5+pp
	 jSnLkoasgxKg0qMMSXal1GHDzMO2kusFt7iF5vxjWDDJldeFIVbNlQ5QnYRJfhuZpz
	 k3NvKMZZpoNvcDCuV5oxCzLGxbgLoz1sA6xu8fUvcMjxbn6L/QYJ3HZjCacXLyIvXF
	 IrPd/sRKTB4hhTHxg5S8rdiveZmM2fkVlSvjp6Op+wD/YhCJLQ+VmK86mNZTLf8KL9
	 X7Qmvcm8kcyfnR/NQRJjOwewNKqjyDiU3JmD465Yd4uErEd02IIycLvXIacTEprNvG
	 5J4LYjqvPWqmQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49A16S5e81586044
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 09:06:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 10 Oct 2024 09:06:29 +0800
Received: from [127.0.1.1] (172.16.17.99) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Oct
 2024 09:06:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-10-10
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <4a90097d-a2ce-4a30-953e-fb0ddae8d012@RTEXMBS04.realtek.com.tw>
Date: Thu, 10 Oct 2024 09:06:28 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8:

  wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq() (2024-09-18 16:54:30 +0300)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-10-10

for you to fetch changes up to fc442560016d9246460b317771bebbcbaf910aa2:

  wifi: rtw89: wow: do not configure CPU IO to receive packets for old firmware (2024-10-10 08:45:37 +0800)

----------------------------------------------------------------
rtw-next patches for v6.13

No big change at this point. Regular development and fixes are listed:

rtl8xxxu:
 - correct beaconing for the case of STA + AP

rtw88:
 - consolidate parser of RX descriptor as preparation to support coming
   chips

rtw89:
 - update BT-coexistence to improve user experience for RTL8852BE and
   RTL8852BE-VT
 - correct RTL8922AE RF calibration timeout time and print out firmware
   log
 - set proper PCI EQ value for RTL8852CE and RTL8922AE
 - adjust to support MLO continuously

----------------------------------------------------------------
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

Martin Kaistra (1):
      wifi: rtl8xxxu: Perform update_beacon_work when beaconing is enabled

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

 drivers/net/wireless/realtek/rtl8xxxu/core.c       |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |  18 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   2 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   4 +-
 drivers/net/wireless/realtek/rtw88/main.h          |  13 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   2 +-
 drivers/net/wireless/realtek/rtw88/phy.c           |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |  62 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |  49 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |  65 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |  53 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |  54 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |  70 +-
 drivers/net/wireless/realtek/rtw88/rx.h            |  64 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   9 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   9 +-
 drivers/net/wireless/realtek/rtw89/cam.c           | 259 ++++--
 drivers/net/wireless/realtek/rtw89/cam.h           |  24 +-
 drivers/net/wireless/realtek/rtw89/chan.c          | 215 +++--
 drivers/net/wireless/realtek/rtw89/chan.h          |  15 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 383 ++++++---
 drivers/net/wireless/realtek/rtw89/coex.h          |   6 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 927 ++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h          | 450 +++++++---
 drivers/net/wireless/realtek/rtw89/debug.c         | 134 ++-
 drivers/net/wireless/realtek/rtw89/fw.c            | 706 +++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h            | 261 ++++--
 drivers/net/wireless/realtek/rtw89/mac.c           | 721 +++++++++-------
 drivers/net/wireless/realtek/rtw89/mac.h           | 115 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c      | 654 ++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  71 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  68 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |  24 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  77 ++
 drivers/net/wireless/realtek/rtw89/phy.c           | 668 ++++++++++-----
 drivers/net/wireless/realtek/rtw89/phy.h           |  13 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |  12 +-
 drivers/net/wireless/realtek/rtw89/ps.c            | 109 ++-
 drivers/net/wireless/realtek/rtw89/ps.h            |  14 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |  79 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  12 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  33 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |  37 +-
 drivers/net/wireless/realtek/rtw89/wow.c           | 217 ++---
 drivers/net/wireless/realtek/rtw89/wow.h           |  10 +-
 50 files changed, 4443 insertions(+), 2406 deletions(-)

