Return-Path: <linux-wireless+bounces-24449-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD6AE7428
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 03:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5EDA3AEC24
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 01:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641932E40E;
	Wed, 25 Jun 2025 01:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z/hUNkOB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250022083
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 01:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750814116; cv=none; b=iCMjntOOGOH1jvZhMo0TQi7rYuug8XDOfbJQ0BzLn6KV4ft7Gt67/D2B+hO3AEC+iegD32o/r4y0VC12scBDKSa9p7JoNgcLrAJd18Mx4DZRu9aNEfg0sl1Wo5vCsmSCToXlu5CT1DytHsCjOrC4tmFuRSRAZrh98yJfOWx9Jhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750814116; c=relaxed/simple;
	bh=yau39nPbmjfp4yDSx0gFoRW/1iyGtViUJxKX0V5NASU=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=UB2sbfz3EET9DcrIrA2wfWHFc/rMBcVcQrm0ptV/L+WiPoDIjaY0a5bNU5+wIshVGQghDvYHQCLumsT1LftnKXKuYTFjc0bOQki2hM1P9GD2hbw20goRbP/4VUk7GDLpidFhGALW+3gc2wdaEEVR9Bp988bRv9d6MbRUt3NI+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z/hUNkOB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55P1F87g8432182, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750814108; bh=I/WsWsDuN9i6HZpn6K4FT4nerkpX8UYRccl6Du7ljOs=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=Z/hUNkOBPXM4i96f1NumUowkU9886+RAalsC7l8qdR4uoy56iT5X2ShPmgkOQuJ/V
	 oO1/dZV1krQlu357iHjw28CMfkOL1moaxWV5hz+30crDCwi3iyhn/InYC9OFQX95Dk
	 sl53JvQChHVesK4quH/ienRTamm3wy3JVwrtByxy0p11uSR0oobv5BKpTOUSxAZy1Q
	 1s7jb1IbrzJ+b9Ie6zAc/TZ2e2nVjIXYMVnhdyGAFE0Y38X93o1wuY07mzjPadIcfx
	 Fdywy4g4wEJLngvoVUtyjkQ6g/jj+6BMIGeoPcKAC5asxzAjS43+AGmOKVKAIniXpI
	 TdrE1ItIIC0lA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55P1F87g8432182
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 09:15:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Jun 2025 09:15:24 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Jun
 2025 09:15:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2025-06-25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <450cdb49-90dc-489e-a970-5911398ea1b0@RTEXDAG02.realtek.com.tw>
Date: Wed, 25 Jun 2025 09:15:23 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21:

  Merge tag 'net-next-6.16' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-05-28 15:24:36 -0700)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2025-06-25

for you to fetch changes up to 16d8fd74dbfca0ea58645cd2fca13be10cae3cdd:

  wifi: rtl818x: Kill URBs before clearing tx status queue (2025-06-24 15:31:45 +0800)

----------------------------------------------------------------
rtw-next patches for v6.17

Regular development, refinement and minor fixes. Some notable changes are:

rtw88:

 * enable AP/ad-hoc modes for SDIO devices

rtw89:

 * implement BT-coexistence for WiFi MLO

 * ongoing to develop STA+P2P MCC

----------------------------------------------------------------
Arnd Bergmann (1):
      wifi: rtlwifi: avoid stack size warning for _read_eeprom_info

Bitterblue Smith (2):
      wifi: rtw88: Rename the RTW_WCPU_11{AC,N} enums
      wifi: rtw88: Enable AP and adhoc modes for SDIO again

Chih-Kang Chang (11):
      wifi: rtw89: mcc: update format of RF notify MCC H2C command
      wifi: rtw89: mcc: correct frequency when MCC
      wifi: rtw89: mcc: adjust beacon filter when MCC and detect connection
      wifi: rtw89: mcc: stop TX during MCC prepare
      wifi: rtw89: TX nulldata 0 after scan complete
      wifi: rtw89: mcc: adjust TX nulldata early time from 3ms to 7ms
      wifi: rtw89: mcc: enlarge scan time of GC when GO in MCC
      wifi: rtw89: mcc: clear normal flow NoA when MCC start
      wifi: rtw89: mcc: use anchor pattern when bcn offset less than min of tob
      wifi: rtw89: mcc: enlarge TX retry count when GC auth
      wifi: rtw89: scan abort when assign/unassign_vif

Chin-Yen Lee (2):
      wifi: rtw88: pci: add PCI Express error handling
      wifi: rtw89: pci: add PCI Express error handling

Ching-Te Ku (20):
      wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.63.0
      wifi: rtw89: coex: Implement Wi-Fi MLO related logic
      wifi: rtw89: coex: Update Wi-Fi status logic for WiFi 7
      wifi: rtw89: coex: refine debug log with format version and readable string
      wifi: rtw89: coex: Add H2C command to collect driver outsource information to firmware
      wifi: rtw89: coex: Update Pre-AGC logic for WiFi 7
      wifi: rtw89: coex: Update BTG control for WiFi 7
      wifi: rtw89: coex: Update hardware PTA resource binding logic
      wifi: rtw89: coex: Add PTA grant signal setting offload to firmware feature
      wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
      wifi: rtw89: coex: Enable outsource info H2C command
      wifi: rtw89: coex: Query Bluetooth TX power when firmware support
      wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.71.0
      wifi: rtw89: coex: Get Bluetooth desired version by WiFi firmware version
      wifi: rtw89: coex: Update scoreboard to avoid Bluetooth re-link fail
      wifi: rtw89: coex: Assign priority table before entering power save
      wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware issue
      wifi: rtw89: coex: Update Bluetooth slot length when Wi-Fi is scanning
      wifi: rtw89: coex: RTL8852B coexistence Wi-Fi firmware support for v0.29.122.0
      wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.0.0

Christophe JAILLET (1):
      wifi: rtlwifi: Constify struct rtl_hal_ops and rtl_hal_cfg

Colin Ian King (1):
      wifi: rtlwifi: rtl8821ae: make the read-only array params static const

Dan Carpenter (1):
      wifi: rtw89: mcc: prevent shift wrapping in rtw89_core_mlsr_switch()

Daniil Dulov (1):
      wifi: rtl818x: Kill URBs before clearing tx status queue

Eric Huang (3):
      wifi: rtw89: add EHT physts and adjust init flow accordingly
      wifi: rtw89: update EDCCA report for subband 40M/80M/sub-20M
      wifi: rtw89: correct length for IE18/19 PHY report and IE parser

Fedor Pchelkin (3):
      wifi: rtw89: fix spelling mistake of RTW89_FLAG_FORBIDDEN_TRACK_WORK
      wifi: rtw89: sar: drop lockdep assertion in rtw89_set_sar_from_acpi
      wifi: rtw89: sar: do not assert wiphy lock held until probing is done

Kuan-Chung Chen (5):
      wifi: rtw89: fix EHT 20MHz TX rate for non-AP STA
      wifi: rtw89: 8852c: increase beacon loss to 6 seconds
      wifi: rtw89: add chip_ops::chan_to_rf18_val to get code of RF register value
      wifi: rtw89: 8922a: pass channel information when enter LPS
      wifi: rtw89: mac: differentiate mem_page_size by chip generation

Ping-Ke Shih (2):
      wifi: rtw89: rfk: support IQK firmware command v1
      wifi: rtw89: mac: add dummy handler of MAC C2H event class 27

Thomas Fourier (2):
      wifi: rtlwifi: fix possible skb memory leak in _rtl_pci_init_one_rxdesc()
      wifi: rtlwifi: fix possible skb memory leak in `_rtl_pci_rx_interrupt()`.

Zong-Zhe Yang (8):
      wifi: rtw89: chan: concentrate the logic of setting/clearing chanctx bitmap
      wifi: rtw89: chan: re-config default chandef only when none is registered
      wifi: rtw89: implement channel switch support
      wifi: rtw89: fw: add RFE type to RF TSSI H2C command
      wifi: rtw89: extend HW scan of WiFi 6 chips for extra OP chan when concurrency
      wifi: rtw89: introduce rtw89_query_mr_chanctx_info() for multi-role chanctx info
      wifi: rtw89: avoid NULL dereference when RX problematic packet on unsupported 6 GHz band
      wifi: rtw89: report boottime of receiving beacon and probe response

 drivers/net/wireless/realtek/rtl818x/rtl8187/dev.c |    3 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   23 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8192cu/sw.c    |    4 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/hw.c    |    7 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/hw.c    |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |   16 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |    8 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |   22 +-
 drivers/net/wireless/realtek/rtw88/main.c          |   15 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   12 +-
 drivers/net/wireless/realtek/rtw88/pci.c           |   49 +-
 drivers/net/wireless/realtek/rtw88/pci.h           |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8723de.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8812a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8814a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821a.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8821ce.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822be.c     |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822ce.c     |    1 +
 drivers/net/wireless/realtek/rtw88/sdio.c          |    8 +-
 drivers/net/wireless/realtek/rtw89/chan.c          |  347 +++++-
 drivers/net/wireless/realtek/rtw89/chan.h          |   58 +-
 drivers/net/wireless/realtek/rtw89/coex.c          | 1287 +++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/coex.h          |    7 +
 drivers/net/wireless/realtek/rtw89/core.c          |  135 +-
 drivers/net/wireless/realtek/rtw89/core.h          |  147 ++-
 drivers/net/wireless/realtek/rtw89/debug.c         |   13 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  314 ++++-
 drivers/net/wireless/realtek/rtw89/fw.h            |   47 +-
 drivers/net/wireless/realtek/rtw89/mac.c           |   68 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |    6 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |   78 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |    1 +
 drivers/net/wireless/realtek/rtw89/pci.c           |   37 +
 drivers/net/wireless/realtek/rtw89/pci.h           |    1 +
 drivers/net/wireless/realtek/rtw89/phy.c           |   96 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |    1 +
 drivers/net/wireless/realtek/rtw89/ps.c            |   26 +-
 drivers/net/wireless/realtek/rtw89/ps.h            |    3 +
 drivers/net/wireless/realtek/rtw89/reg.h           |    2 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |   46 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   52 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/sar.c           |    5 +-
 drivers/net/wireless/realtek/rtw89/ser.c           |   11 +-
 72 files changed, 2413 insertions(+), 625 deletions(-)

