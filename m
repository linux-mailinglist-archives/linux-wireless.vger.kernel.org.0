Return-Path: <linux-wireless+bounces-29237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BC294C78C6C
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 12:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2F04EBBD3
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 11:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDA34321A;
	Fri, 21 Nov 2025 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SCB5BUav"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2418133E350
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 11:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763724071; cv=none; b=h9C34QP6A/s1uEq3qcNxo31JpW/a7raxiGh49aQ5O+IllcycBjpw7UJQdonmE2WK0J1LrhDmfoa3IY2IWWJ463p9l/xXkPTBQwoCrZ0OinhPGTYCJNy5Ff//lWsr3z9e0UwM40cqjbZ2tMUbRYl7w3MZYHTNSo6BuudJiLqGr0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763724071; c=relaxed/simple;
	bh=e+wk/sOxJv0PUJPjp8gyYyke6STkuRn3BHafSt0SPoQ=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ov9ZxMXgAG0GPiRJCFGCph3Ud3Kipgtq2wLBB83HKybeORbkW9J5l0bLG89JO7ZeKiGP7zJjJGZMNASAC4FXaJDsitNKQOrMmOVoTkBDqCceehAnkUDbM7YLCXIFd22M5ExDMaXAh4W7VT0ksIa/xsY+1DuoGUgwhOmsKtwusn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SCB5BUav; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5ALBL6gsC3468966, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763724066; bh=HOGmBiPJwWrCeAycmhfD8IqR9DDm6fDLlZ7m+EFC/0E=;
	h=From:To:Subject:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=SCB5BUavs1wRe0FnZp+gOgXbIylbQeZbFun0AAUhLktQQmaP6XcoYwRp40HitG8mz
	 XI75TfnSU6zYhp5889jSOqni1csJ2K8nIB8p4UXvx7TSHiWV9Al4933JixpVppJVak
	 2NjWEkk1159z8ZE+/R1wtbJ5ZMnlcI5giMo96soqNIEYExx7+JHq/lYsxKw2zhY/Oj
	 o6NMww2/IMQgWN0vB2+Y4JA77FrO0DNd1Jmo+i7aMm7QC9XpKMLK8vuwN/fyOiIWZT
	 gxdB3qXAlprwoLUVRumAjR8k6RF9bm/aNvMtKs3XbWT2/iC+jUhYkOSiyEDxYQ9WHp
	 UgVREUjIuB6JQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5ALBL6gsC3468966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 21 Nov 2025 19:21:06 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 19:21:07 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 21 Nov 2025 19:21:06 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::2514:51f7:92e3:7d6a%9]) with mapi id
 15.02.1544.027; Fri, 21 Nov 2025 19:21:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-11-21-v2
Thread-Topic: pull-request: rtw-next-2025-11-21-v2
Thread-Index: AQHcWtiTd1ywZmW2fEiIOAXjLTyWXg==
Date: Fri, 21 Nov 2025 11:21:06 +0000
Message-ID: <45eed1763a354460acba15a8e69f9e3e@realtek.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 55db64ddd6a12c5157a61419a11a18fc727e8286=
:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-10-1=
6 11:06:28 -0700)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-11-21-v2

for you to fetch changes up to dbf9b7bb0edfa192d43ebb41dd0e1041f8a9c5b0:

  wifi: rtl8xxxu: Enable 40 MHz width by default (2025-11-21 13:33:41 +0800=
)

----------------------------------------------------------------
rtw-next patches for v6.19

Main changes are about rtw89 USB support, which two USB devices are added
with proper TX status, and other notable items are listed below.

rtl8xxxu:

 - fix 40MHz bandwidth connection

rtw89:

 - support USB devices RTL8852AU and RTL8852CU

 - report TX status from air for USB devices

 - resolve racing between processes of TX and TX report

 - resolve racing of skb queue of C2H events

 - support injected packets with bandwidth and data rate

 - more materials for coming RTL8922DE

----------------------------------------------------------------
Abdun Nihaal (1):
      wifi: rtl818x: Fix potential memory leaks in rtl8180_init_rx_ring()

Bitterblue Smith (25):
      wifi: rtl8xxxu: Report the signal strength only if it's known
      wifi: rtl8xxxu: Dump the efuse right after reading it
      wifi: rtl8xxxu: Use correct power off sequence for RTL8192CU
      wifi: rtw89: Add rtw89_core_get_ch_dma_v2()
      wifi: rtw89: usb: Move bulk out map to new struct rtw89_usb_info
      wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_pre_init() for RTL8852CU
      wifi: rtw89: usb: Prepare rtw89_usb_ops_mac_post_init() for RTL8852CU
      wifi: rtw89: Fix rtw89_mac_dmac_func_pre_en_ax() for USB/SDIO
      wifi: rtw89: 8852c: Fix rtw8852c_pwr_{on,off}_func() for USB
      wifi: rtw89: Add rtw8852c_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8852c_hfc_param_ini_usb
      wifi: rtw89: 8852c: Accept USB devices and load their MAC address
      wifi: rtw89: Add rtw8852cu.c
      wifi: rtw89: Enable the new rtw89_8852cu module
      wifi: rtw89: Use the correct power sequences for USB/SDIO
      wifi: rtw89: Add rtw8852a_dle_mem_usb
      wifi: rtw89: Add rtw8852a_hfc_param_ini_usb
      wifi: rtw89: 8852a: Accept USB devices and load their MAC address
      wifi: rtw89: Add rtw8852au.c
      wifi: rtw89: Enable the new rtw89_8852au module
      wifi: rtl8xxxu: Fix HT40 channel config for RTL8192CU, RTL8723AU
      wifi: rtl8xxxu: Make RTL8192CU, RTL8723AU TX with 40 MHz width
      wifi: rtl8xxxu: Fix the 40 MHz subchannel for RTL8192EU, RTL8723BU
      wifi: rtl8xxxu: Fix RX channel width reported by RTL8192FU
      wifi: rtl8xxxu: Enable 40 MHz width by default

Chih-Kang Chang (3):
      wifi: rtw89: flush TX queue before deleting key
      wifi: rtw89: update format of addr cam H2C command
      wifi: rtw89: correct user macid mask of RX info for RTL8922D

Chin-Yen Lee (2):
      wifi: rtw89: restart hardware to recover firmware if power-save becom=
es abnormal
      wifi: rtw88: 8822c: use fixed rate and bandwidth to reply CSI packets

Dan Hamik (1):
      wifi: rtw89: rtw8852bu: Added dev id for ASUS AX57 NANO USB Wifi dong=
le

Fedor Pchelkin (9):
      wifi: rtw89: usb: use common error path for skbs in rtw89_usb_rx_hand=
ler()
      wifi: rtw89: usb: fix leak in rtw89_usb_write_port()
      wifi: rtw89: usb: use ieee80211_free_txskb() where appropriate
      wifi: rtw89: refine rtw89_core_tx_wait_complete()
      wifi: rtw89: implement C2H TX report handler
      wifi: rtw89: usb: anchor TX URBs
      wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
      wifi: rtw89: provide TX reports for management frames
      wifi: rtw89: process TX wait skbs for USB via C2H handler

Hiroaki Yamamoto (1):
      wifi: rtw88: Add BUFFALO WI-U3-866DHP to the USB ID list

Jui-Peng Tsai (1):
      wifi: rtw89: improve scan time on 6 GHz band

Kuan-Chung Chen (2):
      wifi: rtw89: 8852c: fix ADC oscillation in 160MHz affecting RX perfor=
mance
      wifi: rtw89: phy: fix out-of-bounds access in rtw89_phy_read_txpwr_li=
mit()

Marco Crivellari (2):
      wifi: rtlwifi: add WQ_UNBOUND to alloc_workqueue users
      wifi: rtw88: add WQ_UNBOUND to alloc_workqueue users

Ping-Ke Shih (25):
      wifi: rtw89: splice C2H events queue to local to prevent racing
      wifi: rtw89: use skb_dequeue() for queued ROC packets to prevent raci=
ng
      wifi: rtw89: 8832cu: turn off TX partial mode
      wifi: rtw89: fill TX descriptor of FWCMD in shortcut
      wifi: rtlwifi: rtl8188ee: correct allstasleep in P2P PS H2C command
      wifi: rtw89: pci: add to read PCI configuration space from common cod=
e
      wifi: rtw89: fw: parse firmware element of DIAG_MAC
      wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
      wifi: rtw89: 8852c: add compensation of thermal value from efuse cali=
bration
      wifi: rtw89: consider data rate/bandwidth/GI for injected packets
      wifi: rtw89: do RF calibration once setting channel when running pure=
 monitor mode
      wifi: rtw89: configure RX antenna if chips can support
      wifi: rtw89: fw: part size to download firmware by header info
      wifi: rtw89: mac: separate pre-init code before downloading firmware
      wifi: rtw89: phy: calling BB pre-init by chips with/without BB MCU
      wifi: rtw89: mac: remove undefined bit B_BE_PPDU_MAC_INFO
      wifi: rtw89: mac: update wcpu_on to download firmware for RTL8922D
      wifi: rtw89: phy: consider type 15 in BB gain table
      wifi: rtw89: phy: ignore DCFO if not defined in chip_info
      wifi: rtw89: fw: print band and port where beacon update on
      wifi: rtw89: align RA H2C format v1 for RTL8922A
      wifi: rtw89: fill addr cam H2C command by struct
      wifi: rtw89: add addr cam H2C command v1
      wifi: rtw89: use separated function to set RX filter
      wifi: rtw89: 8852a: correct field mask of reset DAC/ADC FIFO

Seungjin Bae (1):
      wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_=
cb()

Yu-Chun Lin (1):
      wifi: rtw89: Replace hardcoded strings with helper functions

Zenm Chen (3):
      wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
      wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1
      wifi: rtw89: Add default ID 0bda:b831 for RTL8831BU

Zong-Zhe Yang (3):
      wifi: rtw89: mlo: handle needed H2C when link switching is requested =
by stack
      wifi: rtw89: support EHT rate pattern via bitrate mask
      wifi: rtw89: regd: apply ACPI policy even if country code is programm=
ed

 drivers/net/wireless/realtek/rtl818x/rtl8180/dev.c |   9 +-
 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |  27 +-
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |  80 +++-
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c      | 115 +++++-
 drivers/net/wireless/realtek/rtl8xxxu/core.c       | 188 ++-------
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   1 -
 drivers/net/wireless/realtek/rtlwifi/base.c        |   2 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/fw.c    |   2 +-
 drivers/net/wireless/realtek/rtw88/bf.c            |   8 +-
 drivers/net/wireless/realtek/rtw88/bf.h            |   7 +
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |   2 +
 drivers/net/wireless/realtek/rtw88/rtw8822cu.c     |   2 +
 drivers/net/wireless/realtek/rtw88/usb.c           |   3 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |  22 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   6 +
 drivers/net/wireless/realtek/rtw89/cam.c           | 173 ++++----
 drivers/net/wireless/realtek/rtw89/cam.h           | 446 +++++------------=
----
 drivers/net/wireless/realtek/rtw89/core.c          | 231 ++++++++---
 drivers/net/wireless/realtek/rtw89/core.h          | 104 ++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 299 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c            | 169 +++++---
 drivers/net/wireless/realtek/rtw89/fw.h            |  67 +++-
 drivers/net/wireless/realtek/rtw89/mac.c           | 200 ++++++++-
 drivers/net/wireless/realtek/rtw89/mac.h           | 114 +++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  89 +++-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   9 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  18 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   4 -
 drivers/net/wireless/realtek/rtw89/phy.c           |  65 ++-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   4 +
 drivers/net/wireless/realtek/rtw89/ps.c            |  23 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |  24 +-
 drivers/net/wireless/realtek/rtw89/regd.c          |  22 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   5 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |  24 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  85 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c  |  16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |  79 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   5 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |  24 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      | 170 ++++++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |  69 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |  69 ++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  17 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |   7 +-
 drivers/net/wireless/realtek/rtw89/usb.c           | 115 ++++--
 drivers/net/wireless/realtek/rtw89/usb.h           |  12 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   8 +-
 54 files changed, 2377 insertions(+), 891 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852au.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852cu.c=

