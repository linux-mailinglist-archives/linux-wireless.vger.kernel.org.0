Return-Path: <linux-wireless+bounces-8455-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2488FA7BE
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 03:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30C1BB22406
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 01:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95613288A4;
	Tue,  4 Jun 2024 01:53:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4A4A04
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466033; cv=none; b=lkoKGql5fnR7MQPfnVk/zRXj5neGO69YRauESo5jMDXtMHPmeUwbPh+xc0CAitY6vuHuWEOsLMKIlxUKswZREW6oc7dnZli9R3fV/Itjytpsi6UZoEW+47iRgLkzTgoIunk7hbACefEd/JCcypgJ9m94HMbM2JW0cvRjSaKL1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466033; c=relaxed/simple;
	bh=HCCaNPgkkqUGuhvwcbCpeo1BoLiJ+f2eeF8kU3ufgpo=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=pV8zy4XAt3bnl+XXcgu6JJ4ZBQHco3bdoDkS1mEcHZ5gKg4WnSLfXmQLIlf2UsuWX1XPOce0xXAvGHfgX9OEteFTzjSaHM4zRVkvj63C1xeERdRf3bvS4u3kuBp3trwZJEXED/eypJO/cvbl0+t7U61+2BKhN6WHuHKg61friXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4541rlPP33667163, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4541rlPP33667163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 4 Jun 2024 09:53:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 09:53:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 4 Jun
 2024 09:53:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-06-04
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <6f28cf60-56e3-4a6e-8a5d-1465bb30b53b@RTEXMBS04.realtek.com.tw>
Date: Tue, 4 Jun 2024 09:53:46 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 83127ecada257e27f4740dbca9644dd0e838bc36:

  Merge tag 'wireless-next-2024-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next (2024-05-08 19:09:38 -0700)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-06-04

for you to fetch changes up to 9373ed280651af79e0adfc29797c26ab47bb9f34:

  wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity() (2024-06-03 09:44:53 +0800)

----------------------------------------------------------------
rtw-next patches for v6.11

Some fixes and refactors of rtlwifi, rtw88 and rtw89. Only one major change
listed below:

rtlwifi:
 - add new chip support of RTL8192DU

----------------------------------------------------------------
Bitterblue Smith (14):
      wifi: rtw88: usb: Simplify rtw_usb_write_data
      wifi: rtw88: usb: Fix disconnection after beacon loss
      wifi: rtlwifi: rtl8192d: Use "rtl92d" prefix
      wifi: rtlwifi: Add rtl8192du/table.{c,h}
      wifi: rtlwifi: Add new members to struct rtl_priv for RTL8192DU
      wifi: rtlwifi: Add rtl8192du/hw.{c,h}
      wifi: rtlwifi: Add rtl8192du/phy.{c,h}
      wifi: rtlwifi: Add rtl8192du/trx.{c,h}
      wifi: rtlwifi: Add rtl8192du/rf.{c,h}
      wifi: rtlwifi: Add rtl8192du/fw.{c,h} and rtl8192du/led.{c,h}
      wifi: rtlwifi: Add rtl8192du/dm.{c,h}
      wifi: rtlwifi: Constify rtl_hal_cfg.{ops,usb_interface_cfg} and rtl_priv.cfg
      wifi: rtlwifi: Add rtl8192du/sw.c
      wifi: rtlwifi: Enable the new rtl8192du driver

Breno Leitao (2):
      wifi: rtw89: Un-embed dummy device
      wifi: rtw88: Un-embed dummy device

Jiapeng Chong (1):
      wifi: rtw89: chan: Use swap() in rtw89_swap_sub_entity()

Ping-Ke Shih (6):
      wifi: rtw89: 8852b: restore setting for RFE type 5 after device resume
      wifi: rtw89: correct hardware value of nominal packet padding for WiFi 7 chips
      wifi: rtw89: 8852c: correct logic and restore PCI PHY EQ after device resume
      wifi: rtw89: fill STBC and LDPC capabilities to TX descriptor
      wifi: rtw89: add LDPC and STBC to rx_status and radiotap known fields for monitor mode
      wifi: rtlwifi: handle return value of usb init TX/RX

Po-Hao Huang (2):
      wifi: rtw89: fix HW scan not aborting properly
      wifi: rtw89: Fix P2P behavior for WiFi 7 chips

Zong-Zhe Yang (4):
      wifi: rtw89: ser: avoid multiple deinit on same CAM
      wifi: rtw89: cam: tweak relation between sec CAM and addr CAM
      wifi: rtw89: switch to register vif_cfg_changed and link_info_changed
      wifi: rtw89: support mac_id number according to chip

 drivers/net/wireless/realtek/rtlwifi/Kconfig       |   12 +
 drivers/net/wireless/realtek/rtlwifi/Makefile      |    1 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    3 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.c  |   94 +-
 .../wireless/realtek/rtlwifi/rtl8192d/hw_common.h  |   28 +-
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.c |   92 +-
 .../wireless/realtek/rtlwifi/rtl8192d/trx_common.h |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/hw.c    |   18 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |   20 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/trx.c   |    2 +-
 .../wireless/realtek/rtlwifi/rtl8192du/Makefile    |   13 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/dm.c    |  120 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/dm.h    |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/fw.c    |   63 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/fw.h    |    9 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.c    | 1212 ++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/hw.h    |   22 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/led.c   |   10 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/led.h   |    9 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.c   | 3123 ++++++++++++++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/phy.h   |   32 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/rf.c    |  240 ++
 .../net/wireless/realtek/rtlwifi/rtl8192du/rf.h    |   11 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/sw.c    |  395 +++
 .../net/wireless/realtek/rtlwifi/rtl8192du/table.c | 1675 +++++++++++
 .../net/wireless/realtek/rtlwifi/rtl8192du/table.h |   29 +
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.c   |  372 +++
 .../net/wireless/realtek/rtlwifi/rtl8192du/trx.h   |   60 +
 drivers/net/wireless/realtek/rtlwifi/usb.c         |   36 +-
 drivers/net/wireless/realtek/rtlwifi/usb.h         |    2 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |   12 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   17 +-
 drivers/net/wireless/realtek/rtw88/pci.h           |    2 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |   14 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |   79 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |    5 +-
 drivers/net/wireless/realtek/rtw89/core.c          |  107 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   20 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   16 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |   31 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |    4 +
 drivers/net/wireless/realtek/rtw89/mac.c           |   12 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   42 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |   29 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    1 +
 drivers/net/wireless/realtek/rtw89/ser.c           |    8 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |    4 +
 52 files changed, 7870 insertions(+), 274 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/hw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/sw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/table.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.h

