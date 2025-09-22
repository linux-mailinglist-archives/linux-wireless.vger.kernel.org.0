Return-Path: <linux-wireless+bounces-27568-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFACB8F375
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB0073BBB7E
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3677B2F0C6C;
	Mon, 22 Sep 2025 07:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Co049/L7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DAB2F0690
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758524669; cv=none; b=FoYrSDnxmMNxCTbsBaOBQHe8VPecnz0AFbjdjH963T4MSLTb2pOkDcEhUjj+oeOl6sgDvA3CFTmQXvss5hqZYU5uPIZTkJRe4MnHAuJbEvVNWzi/Hcd0Bwk60nHA+cW+ghWk1aWuyJjFD2T0K7HMtSyg1SX4NfOQJZlHm/q2UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758524669; c=relaxed/simple;
	bh=E6/jNfqToVSMWvom4JQbayC28/QHEARP2JK0Pg9mLnA=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=HBAHF17dEEME40hBRR/p+GXq6nifxZHcffB9zFc3hXOfLhUFHkQuRIpFjxjNHxsZsgbRSrc+8ol1YqD8EWURurv1ZBJpyUECBsNQSSXo0d6gZrRVPApPoFW1NXGXKqpfdpzDqm4hCPfB5fhIVpJrXuULDQqx3gmALTHfzGMp184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Co049/L7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M74MCQ04009432, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758524662; bh=LELOlC5PT83FQWdpYpQ2JEf1CnP08doTTd/cc3BLl5k=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=Co049/L7a4PqzqcHh/U2TXR3StZmux/Rl0cwuEWkh49znL0hoaTWW+ywP9vEdq2Tx
	 UGfSdMGSRDjZ9yJ9O1tvDzgKhk70kdiVT3NPylGBiIKtPEA3cOk5KqAaPevbp0vqUa
	 5bxBg39JWFQRHbbn2HkFyHtk1oinOHGiXmQTh4TxcY1WOBET4V0kn28+Ca8UldLnWc
	 3kKom4bLDjFZA5Sia4CIeRjpy1qxQLsBQTtOR837838H1MTrWpNvqSqBxCefrOHJpo
	 2YiAz65yH8p7pSx9BrGdNLAxINv8bXwq0sNOSIXOkBbM6qVSZQjPXP/pNl4P50JNWs
	 cIKZ7IeplP0Pw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M74MCQ04009432
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 15:04:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 15:04:23 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 22 Sep
 2025 15:04:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-09-22
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <52077872-4514-4c55-a09a-1489e22e7447@RTKEXHMBS06.realtek.com.tw>
Date: Mon, 22 Sep 2025 15:04:22 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit d9104cec3e8fe4b458b74709853231385779001f:

  Merge tag 'bpf-next-6.17' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next (2025-07-30 09:58:50 -0700)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-09-22

for you to fetch changes up to 570f94511766f9236d3462dfb8a3c719c2b54c23:

  wifi: rtw89: avoid circular locking dependency in ser_state_run() (2025-09-22 13:59:04 +0800)

----------------------------------------------------------------
rtw-next patches for v6.18

Some small fixes and features are listed:

rtw88:

 * correct LED function

rtw89:

 * fix wait/completion racing of sending NULL data

 * implement beacon tracking feature

 * implement report channel noise function supported by RTL8852A

 * correct RTL8851B RF calibration

 * preparation of PCI TX/RX ring and interrupts for coming RTL8922DE

----------------------------------------------------------------
Akhilesh Patil (1):
      wifi: rtw89: 8852bt: Use standard helper for string choice

Aleksej Smirnov (1):
      wifi: rtl8xxxu: Remove TL-WN722N V2 (0x2357: 0x010c) from untested devices

Bitterblue Smith (4):
      wifi: rtw88: Lock rtwdev->mutex before setting the LED
      wifi: rtlwifi: rtl8192cu: Don't claim USB ID 07b8:8188
      wifi: rtl8xxxu: Don't claim USB ID 07b8:8188
      wifi: rtw88: Use led->brightness_set_blocking for PCI too

Chih-Kang Chang (4):
      wifi: rtw89: 8852c: check LPS H2C command complete by C2H reg instead of done ack
      wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
      wifi: rtw89: obtain RX path from ppdu status IE00
      wifi: rtw89: wow: enable TKIP related feature

Ching-Te Ku (1):
      wifi: rtw89: coex: Limit Wi-Fi scan slot cost to avoid A2DP glitch

Fedor Pchelkin (4):
      wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
      wifi: rtw89: avoid possible TX wait initialization race
      wifi: rtw89: fix leak in rtw89_core_send_nullfunc()
      wifi: rtw89: avoid circular locking dependency in ser_state_run()

Kuan-Chung Chen (9):
      wifi: rtw89: introduce beacon tracking to improve connection stability
      wifi: rtw89: debug: add beacon_info debugfs
      wifi: rtw89: wow: remove notify during WoWLAN net-detect
      wifi: rtw89: 8851b: rfk: update IQK TIA setting
      wifi: rtw89: 8851b: rfk: update TX wideband IQK
      wifi: rtw89: fix BSSID comparison for non-transmitted BSSID
      wifi: rtw89: fix group frames loss when connected to non-transmitted BSSID
      wifi: rtw89: 8852b: enable beacon tracking support
      wifi: rtw89: 8922a: add TAS feature support

Liao Yuanhong (2):
      wifi: rtw89: 8852bt: Simplify unnecessary if-else conditions in _dpk_onoff()
      wifi: rtw89: 8852bt: Remove redundant off_reverse variables

Martin Kaistra (1):
      wifi: rtl8xxxu: expose efuse via debugfs

Ping-Ke Shih (16):
      wifi: rtw88: sdio: use indirect IO for device registers before power-on
      wifi: rtw89: print just once for unknown C2H events
      wifi: rtw89: add dummy C2H handlers for BCN resend and update done
      wifi: rtw89: 8852c: update firmware crash trigger type for newer firmware
      wifi: rtw89: pci: move chip ISR definition out from chip generation
      wifi: rtw89: pci: prepare interrupt related registers and functions for 8922DE
      wifi: rtw89: pci: use RDU status of R_BE_PCIE_DMA_IMR_0_V1 instead for 8922DE
      wifi: rtw89: pci: add struct rtw89_{tx,rx}_rings to put related fields
      wifi: rtw89: pci: define TX/RX buffer descriptor pool
      wifi: rtw89: pci: add group BD address design
      wifi: rtw89: pci: abstract RPP parser
      wifi: rtw89: pci: add RPP parser v1
      wifi: rtw89: abstract getting function of DMA channel
      wifi: rtw89: add getting function of DMA channel v1
      wifi: rtw89: use ieee80211_tx_info::driver_data to store driver TX info
      wifi: rtw89: phy: initialize AFE by firmware element table

Po-Hao Huang (2):
      wifi: rtw89: 8852a: report per-channel noise level by get_survey ops
      wifi: rtw89: 8852a: report average RSSI to avoid unnecessary scanning

Qianfeng Rong (1):
      wifi: rtw89: use int type to store negative error codes

Zenm Chen (2):
      wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
      wifi: rtw89: Add USB ID 2001:3327 for D-Link AX18U rev. A1

Zong-Zhe Yang (4):
      wifi: rtw89: chan: allow callers to check if a link has no managed chanctx
      wifi: rtw89: debug: support SER L0 simulation
      wifi: rtw89: renew a completion for each H2C command waiting C2H event
      wifi: rtw89: open C2H event waiting window first before sending H2C command

 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  27 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |   1 -
 drivers/net/wireless/realtek/rtw88/led.c           |  13 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   4 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  11 +-
 drivers/net/wireless/realtek/rtw89/chan.h          |  10 +-
 drivers/net/wireless/realtek/rtw89/coex.c          |   5 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 684 +++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h          | 148 ++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 125 +++-
 drivers/net/wireless/realtek/rtw89/debug.h         |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c            | 177 +++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |  77 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  72 ++-
 drivers/net/wireless/realtek/rtw89/mac.h           |   1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  35 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   1 +
 drivers/net/wireless/realtek/rtw89/pci.c           | 462 ++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h           | 128 +++-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  18 +-
 drivers/net/wireless/realtek/rtw89/phy.c           | 476 ++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h           |  24 +-
 drivers/net/wireless/realtek/rtw89/phy_be.c        |   9 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |  56 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  | 159 +++--
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  46 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |  14 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   4 +
 drivers/net/wireless/realtek/rtw89/sar.c           |  15 +
 drivers/net/wireless/realtek/rtw89/sar.h           |   1 +
 drivers/net/wireless/realtek/rtw89/ser.c           |   5 +-
 drivers/net/wireless/realtek/rtw89/txrx.h          |  38 +-
 drivers/net/wireless/realtek/rtw89/wow.c           |  79 ++-
 drivers/net/wireless/realtek/rtw89/wow.h           |   6 +
 47 files changed, 2583 insertions(+), 401 deletions(-)

