Return-Path: <linux-wireless+bounces-25641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF6BB09C40
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 09:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79CE97AD4E0
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6132A211A28;
	Fri, 18 Jul 2025 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="u/iAxZfg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAA219E8F
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752823136; cv=none; b=bQDZknhFgzoG/X09kRvELTNOmen/mpnw+eEql161518cEHbZZudzQ++6YgbBi4bVXP3sTeCdAM8P+QHAXBpg6EKzvjiH2c3OlyeWrKlM/5HFVFsfTOAuKMtuDUcdoGIIrzSZ/e680KZb6m5Vpl7cBLuQ2SXnsa6hvLVrMEk6FFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752823136; c=relaxed/simple;
	bh=Keh5ia2AOrQt59TJbIOjcsg1PPf1mBnoZXwkY0ug10w=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=g21vEfTTNuKIoQljB4oSRB3bh+Mb5aRJ7RaVFsW1Zgt6MgRw2ljGV7UIBZ/JCawGBCU6oGNifyeNuJ/2IUrdoGCyNeF8AlRwHd5+2gbdG0Mm4xy+1opFR2vuJ+xCCNXBNAOqNGk+w0+oRdELgVJimaqke5reZkPFKoVm70d4Wrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=u/iAxZfg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56I7InvY61216367, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752823129; bh=q73sg2k7HbGRCKSAE5UIREjwLbN7TjcIQ4Z2RxAIMZE=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=u/iAxZfguFtFa+Lc0N/qazw3edUYnALADipVGm/3sH5rPstLR9I3xGW48TAlPQphu
	 yQD8WnFZx0ZDDnM+27KhZVGJkifhFULmhSJ1GTD0nYh+0mjMRwX2okELaeJBhNl4MY
	 eW5eEJ4SM/cpc0y0fSXRTJvhkJpjz9UB7jVLI0KGSxA88eh7l1SFVfcs4NnC83iALt
	 IgytBSBf/SFTwsQRVRJQGatO9RzgBPe97dtzZNpOcbfxLI2gaPJd5s+hrVh2uhTpzm
	 ShAeFmwXI3f+4GqUTke/XK7cwIOEIFcMPZkS11hpPPEl7+qhbosBrn6NNhjVmGQiqj
	 0KnPpXx6GQSEg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56I7InvY61216367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 15:18:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 18 Jul 2025 15:18:49 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 18 Jul
 2025 15:18:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-07-18
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <bc4ee588-afec-436a-9264-90cc79a2010a@RTEXMBS04.realtek.com.tw>
Date: Fri, 18 Jul 2025 15:18:47 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 28aa52b6189f1cc409f96910c63fa1b99370b99e:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2025-06-26 10:40:50 -0700)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-07-18

for you to fetch changes up to 94cd0ba1842ece06acc15bba5f2bff6b6043eb1d:

  wifi: rtlwifi: Use min()/max() to improve code (2025-07-18 14:41:06 +0800)

----------------------------------------------------------------
rtw-next patches for v6.17

Some minor fixes and refinements. Major changes are listed:

rtw89:

 - STA+P2P concurrency feature gets implemented.

 - add USB architecture and support RTL8851BU and RTL8852BU.

----------------------------------------------------------------
Andrey Skvortsov (1):
      wifi: rtw88: enable TX reports for the management queue

Bitterblue Smith (23):
      wifi: rtw89: 8851b: Accept USB devices and load their MAC address
      wifi: rtw89: Make dle_mem in rtw89_chip_info an array
      wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
      wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
      wifi: rtw89: Disable deep power saving for USB/SDIO
      wifi: rtw89: Add extra TX headroom for USB
      wifi: rtw89: Hide some errors when the device is unplugged
      wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
      wifi: rtw89: Fix rtw89_mac_power_switch() for USB
      wifi: rtw89: Add some definitions for USB
      wifi: rtw89: Add usb.{c,h}
      wifi: rtw89: Add rtw8851bu.c
      wifi: rtw89: Enable the new USB modules
      wifi: rtw89: 8852bx: Accept USB devices and load their MAC address
      wifi: rtw89: 8852b: Fix rtw8852b_pwr_{on,off}_func() for USB
      wifi: rtw89: 8852b: Add rtw8852b_dle_mem_usb3
      wifi: rtw89: 8852b: Add rtw8852b_hfc_param_ini_usb
      wifi: rtw89: Add rtw8852bu.c
      wifi: rtw89: Enable the new rtw89_8852bu module
      wifi: rtw88: Fix macid assigned to TDLS station
      wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
      wifi: rtw89: Lower the timeout in rtw89_fwdl_check_path_ready_ax() for USB

Chia-Yuan Li (2):
      wifi: rtw89: trigger TX stuck if FIFO full
      wifi: rtw89: mac: reduce PPDU status length for WiFi 6 chips

Chih-Kang Chang (9):
      wifi: rtw89: mcc: add H2C command to support different PD level in MCC
      wifi: rtw89: add DIG suspend/resume flow when scan and connection
      wifi: rtw89: mcc: enlarge GO NoA duration to cover channel switching time
      wifi: rtw89: mcc: when MCC stop forcing to stay at GO role
      wifi: rtw89: extend HW scan of WiFi 7 chips for extra OP chan when concurrency
      wifi: rtw89: mcc: solve GO's TBTT change and TBTT too close to NoA issue
      wifi: rtw89: check LPS H2C command complete by C2H reg instead of done ack
      wifi: rtw89: update SER L2 type default value
      wifi: rtw89: tweak tx wake notify matching condition

Chin-Yen Lee (2):
      wifi: rtw89: enter power save mode aggressively
      wifi: rtw89: wow: Add Basic Rate IE to probe request in scheduled scan mode

Kuan-Chung Chen (1):
      wifi: rtw89: dynamically update EHT preamble puncturing

Martin Kaistra (1):
      wifi: rtl8xxxu: Fix RX skb size for aggregation disabled

Pei Xiao (1):
      wifi: rtw88: coex: Use bitwise instead of arithmetic operator for flags

Ping-Ke Shih (8):
      wifi: rtw89: 8851b: rfk: extend DPK path_ok type to u8
      wifi: rtw89: 8851b: set ADC bandwidth select according to calibration value
      wifi: rtw89: 8851b: adjust ADC setting for RF calibration
      wifi: rtw89: 8851b: update NCTL 0xB
      wifi: rtw89: 8851b: rfk: update DPK to 0x11
      wifi: rtw89: 8851b: rfk: update IQK to 0x14
      wifi: rtw89: purge obsoleted scan events with software sequence number
      wifi: rtw89: check path range before using in rtw89_fw_h2c_rf_ps_info()

Qianfeng Rong (1):
      wifi: rtlwifi: Use min()/max() to improve code

Zong-Zhe Yang (9):
      wifi: rtw89: regd/acpi: support country CA by BIT(1) in 6 GHz SP conf
      wifi: rtw89: regd/acpi: update field definition to specific country in UNII-4 conf
      wifi: rtw89: regd/acpi: support regulatory rules via ACPI DSM and parse rule of regd_UK
      wifi: rtw89: regd/acpi: support 6 GHz VLP policy via ACPI DSM
      wifi: rtw89: introduce fw feature group and redefine CRASH_TRIGGER
      wifi: rtw89: 8852bt: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: 8852bt: implement RFK multi-channel handling and support chanctx up to 2
      wifi: rtw89: 8852b: configure FW version for SCAN_OFFLOAD_EXTRA_OP feature
      wifi: rtw89: 8852b: implement RFK multi-channel handling and support chanctx up to 2

 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |   19 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |   17 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |   15 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/dm.c    |    5 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/dm.c    |    5 +-
 drivers/net/wireless/realtek/rtw88/coex.c          |   22 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   10 +
 drivers/net/wireless/realtek/rtw88/mac.h           |    1 +
 drivers/net/wireless/realtek/rtw88/main.c          |   10 +-
 drivers/net/wireless/realtek/rtw88/main.h          |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723x.c      |    9 +-
 drivers/net/wireless/realtek/rtw88/rtw8723x.h      |    6 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    1 +
 drivers/net/wireless/realtek/rtw89/Kconfig         |   26 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    9 +
 drivers/net/wireless/realtek/rtw89/acpi.c          |   95 ++
 drivers/net/wireless/realtek/rtw89/acpi.h          |   33 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  234 ++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   15 +
 drivers/net/wireless/realtek/rtw89/core.c          |  140 ++-
 drivers/net/wireless/realtek/rtw89/core.h          |   73 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |    2 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  310 +++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   61 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |  112 ++-
 drivers/net/wireless/realtek/rtw89/mac.h           |   33 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    8 +
 drivers/net/wireless/realtek/rtw89/pci.c           |    5 +
 drivers/net/wireless/realtek/rtw89/phy.c           |  225 ++++-
 drivers/net/wireless/realtek/rtw89/phy.h           |    2 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   28 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   34 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  149 ++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  169 +++-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |  156 ++-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.c    |   77 +-
 .../wireless/realtek/rtw89/rtw8851b_rfk_table.h    |    2 +-
 .../net/wireless/realtek/rtw89/rtw8851b_table.c    |  501 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   39 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   98 +-
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |   16 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   77 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h  |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |   69 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |    3 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   55 ++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |    3 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |    1 +
 drivers/net/wireless/realtek/rtw89/usb.c           | 1042 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/usb.h           |   65 ++
 drivers/net/wireless/realtek/rtw89/wow.c           |   11 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   14 +-
 65 files changed, 3487 insertions(+), 675 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bu.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h

