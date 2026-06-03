Return-Path: <linux-wireless+bounces-37330-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ow5mOBzgH2prrgAAu9opvQ
	(envelope-from <linux-wireless+bounces-37330-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 10:04:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E40A6357CD
	for <lists+linux-wireless@lfdr.de>; Wed, 03 Jun 2026 10:04:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realtek.com header.s=dkim header.b=XHvnxQIJ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37330-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37330-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realtek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E46EA30BA803
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2026 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E49A3FE64A;
	Wed,  3 Jun 2026 07:46:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDA39A815
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2026 07:46:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472764; cv=none; b=PSydQmAzDwMNubMuSCvqr19GYuEQWfgomwdcR7e6j0GvtIGOq1AvFwEfOcAbiLu+qRk9+L9qldZDnHzw4f5ao/b7ijM7BZdcwg2JAX3OQ1JrjvEQzXeI1q8mjRAA+NDrBd1eL2pBuAfaEykh4qceCXK91Bsy8GlsxB1zNgRt1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472764; c=relaxed/simple;
	bh=orNshiNqGl3SHEePOSUCJ4y+IgmAVUXy5m6we3l/E+s=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type; b=Q298kdcS3lnjr/RiKERhNsqGwLrhT0yuOPD40gjcgJdCcTgGCF43Q1zw3gl4JkaOzsBcJcYyeAwTgncwx2doqqTdeu9PS+oVZe7Uaxzc+cmVZM8iOq0HS2exHTFOLBRyrd7Nf672YhtmEFoARcttL0F/PoGuXU33MENlnXE0e2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XHvnxQIJ; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6537jxTR33662734, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1780472759; bh=T39h2y0Q3OW/SWx0RjtQdsNd598R01XHs8tphXZuL2k=;
	h=From:To:Subject:Message-ID:Date:MIME-Version:Content-Type;
	b=XHvnxQIJhNGH78Q8RItySalXCOWW7ruhsAo8HoX+04vShucwoyypycb4vdHuzt1ON
	 0PWlJg9tTcLi/REgnLytkncYLWAwfTA8+ci2CpXXGvnmPsmAsHhYjRQj3Ux8x5T74b
	 axBNwdPiZ0genhC0NwZ7sIxBglGkOfKcGeVSuoal/NRNFn4WazlrFJ9EsEoKZVCgk4
	 OumZFjN7ds6Eebk0XKkQOq3ZviLZPeVuBoEQa+VErkgSlNeAkZZgSVgnBySjTE7O83
	 7oTkS4xYbUBAwgK/wa9vkHTXM9KavNJxl5wRmMpIOWX+b1p/q4fvz5jjywwexk3yag
	 8PckRXBXMq8iw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6537jxTR33662734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 3 Jun 2026 15:45:59 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 15:45:58 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Jun 2026 15:45:35 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 3 Jun 2026 15:45:35 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2026-06-03
Message-ID: <405ed697-7d77-493a-95a2-38a436409408@RTKEXHMBS05.realtek.com.tw>
Date: Wed, 3 Jun 2026 15:45:35 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37330-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realtek.com:from_mime,realtek.com:dkim,RTKEXHMBS05.realtek.com.tw:mid];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E40A6357CD

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit 7baf5857e15d722776898510a10546d6b2f18645:

  wifi: brcmsmac: phy_lcn: Remove dead code in wlc_lcnphy_radio_2064_channel_tune_4313() (2026-04-28 10:43:27 +0200)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2026-06-03

for you to fetch changes up to 384cc80f30977d2ff095615f2241b21904499255:

  wifi: rtw89: usb: add serial_number and uuid sysfs attributes for 0x28de:0x2432 (2026-06-03 14:48:22 +0800)

----------------------------------------------------------------
rtw-next patches for -next

Pull-request includes many random fixes and new features.

Major changes are listed below:

rtl8xxxu:

 * declare supported channel width by firmware report

rtw88:

 * validate RX descriptor to avoid malformed data causing warnings

rtw89:

 * support USB devices RTL8922AU

 * add sysfs entry to show SN and UUID for specific USB devices

 * support to switch USB 3.0 mode for higher performance

 * add more fields (mainly SIG-A/SIG-B) to radiotap in monitor mode

 * offload packed IO to firmware to reduce IO time (for USB devices)

 * add debugfs to diagnose BB healthy

 * more preparations for RTL8922DE

----------------------------------------------------------------
Bitterblue Smith (16):
      wifi: rtw89: usb: Support 2 bulk in endpoints
      wifi: rtw89: Fix rtw89_usb_ops_mac_lv1_rcvy() for RTL8922AU
      wifi: rtw89: Fix rtw89_usb_ops_mac_pre_init() for RTL8922AU
      wifi: rtw89: Fix rtw89_usb_ops_mac_post_init() for RTL8922AU
      wifi: rtw89: usb: Enable RX aggregation for RTL8922AU
      wifi: rtw89: Fix rtw8922a_pwr_{on,off}_func() for USB
      wifi: rtw89: Let hfc_param_ini have separate settings for USB 2/3
      wifi: rtw89: Add rtw8922a_hfc_param_ini_usb{2,3}
      wifi: rtw89: Add rtw8922a_dle_mem_usb{2,3}
      wifi: rtw89: Add rtw8922au.c
      wifi: rtw89: Enable the new rtw89_8922au module
      wifi: rtlwifi: rtl8821ae: Fix C2H bit location in RX descriptor
      wifi: rtl8xxxu: Detect the maximum supported channel width
      wifi: rtw89: Add missing TX queue mappings for RTL8922AU
      wifi: rtw88: Add more validation for the RX descriptor
      wifi: rtw89: usb: Support switching to USB 3 mode

Chelsy Ratnawat (1):
      wifi: rtlwifi: rtl8821ae: Remove dead code in rtl8821ae_update_hal_rate_table()

Chia-Yuan Li (2):
      wifi: rtw89: add IO offload support via firmware
      wifi: rtw89: offload DMAC and CMAC init IO to firmware

Chih-Kang Chang (3):
      wifi: rtw89: use struct to fill C2H recv ack
      wifi: rtw89: check scan C2H event recv ack instead of C2H event done ack
      wifi: rtw89: suspend DIG when remain-on-channel

Chin-Yen Lee (2):
      wifi: rtw88: fix wrong pci_get_drvdata type in AER handlers
      wifi: rtw89: wow: send ARP reply packets instead of Null packets to keep alive

Christos Longros (1):
      wifi: rtw89: fix wrong pci_get_drvdata type in AER handlers

David Lee (1):
      wifi: rtw89: usb: skip ACPI capability check for USB devices

Dian-Syuan Yang (3):
      wifi: rtw89: disable HTC field in AP mode
      wifi: rtw89: disable CSI STBC for VHT 160MHz
      wifi: rtw89: pci: enable LTR based on pcie control register

Eric Huang (2):
      wifi: rtw89: phy: support static PD level setting
      wifi: rtw89: use firmware offload for PHY and RF batch register writes

Hugo Villeneuve (1):
      wifi: rtlwifi: fix typos in comments in rtl8821ae_card_disable()

Johnson Tsai (5):
      wifi: rtw89: debug: disable hw_scan for latency-sensitive scenarios
      wifi: rtw89: debug: disable inactive power save to reduce bus overhead
      wifi: rtw89: 8832cu: Add ID 2c7c:8206 for RTL8832CU
      wifi: rtw89: add dev_id_quirks to driver_info for per-device quirk control
      wifi: rtw89: usb: add serial_number and uuid sysfs attributes for 0x28de:0x2432

Kuan-Chung Chen (7):
      wifi: rtw89: mlo: rearrange MLSR link decision flow
      wifi: rtw89: phy: support per PHY RX statistics
      wifi: rtw89: debug: bb_info entry including TX rate count for WiFi 7 chips
      wifi: rtw89: debug: add PMAC counter in bb_info
      wifi: rtw89: debug: extend bb_info with TX status and PER
      wifi: rtw89: debug: add RX statistics in bb_info
      wifi: rtw89: debug: add BB diagnose

Louis Kotze (1):
      wifi: rtw89: phy: increase RF calibration timeouts for USB transport

Luka Gejak (2):
      wifi: rtw88: increase TX report timeout to fix race condition
      wifi: rtw88: usb: fix memory leaks on USB write failures

Martin Kaiser (1):
      wifi: rtw88: remove rtw_txq_dequeue

Panagiotis Petrakopoulos (1):
      wifi: rtw88: Add NULL check for chip->edcca_th in rtw_fw_adaptivity_result()

Ping-Ke Shih (41):
      wifi: rtl8xxxu: validate action frame size before using in rtl8xxxu_dump_action()
      wifi: rtlwifi: validate action frame size in rtl_action_proc()
      wifi: rtlwifi: validate action frame size before using in _rtl_pci_tx_isr()
      wifi: rtw89: 8922d: fix typo rx_freq_frome_ie
      wifi: rtw89: pci: no need to wait CLK ready for RTL8922DE
      wifi: rtw89: add AMPDU to radiotap
      wifi: rtw89: add VHT beamformed to radiotap
      wifi: rtw89: SNIFFER_MODE bit along IEEE80211_CONF_MONITOR
      wifi: rtw89: phy: define PHY status IE length for generations
      wifi: rtw89: phy: enable IE-09/IE-10 PHY status report for monitor mode
      wifi: rtw89: move HE radiotap to an individual function
      wifi: rtw89: fill VHT radiotap
      wifi: rtw89: fill HE-SU/HE-TB/HE-MU/HE-EXT_SU radiotap
      wifi: rtw89: debug: make implementation of beacon_info entry in order
      wifi: rtw89: add debugfs entry of monitor mode options to capture HE-MU packets
      wifi: rtw89: phy: check length before parsing PHY status IE
      wifi: rtw89: phy: skip trailing 8-byte zeros of PHY status IE for RTL8922D
      wifi: rtw89: phy: support PHY status IE-09 GEN2 for RTL8922D
      wifi: rtw89: check skb headroom before adding radiotap
      wifi: rtw89: phy: define BB wrap data for RTL8922D variants
      wifi: rtw89: phy: set BB wrap of out-of-band DPD
      wifi: rtw89: phy: set BB wrap of DPD by bandwidth
      wifi: rtw89: phy: set BB wrap of control options
      wifi: rtw89: phy: set BB wrap of QAM threshold
      wifi: rtw89: phy: set BB wrap of QAM options
      wifi: rtw89: phy: set BB wrap of trigger-base partial band
      wifi: rtw89: phy: set BB wrap of CIM3K
      wifi: rtw89: phy: change order to align register order
      wifi: rtw89: phy: configure control options of BB wrapper by RFSI band
      wifi: rtw89: phy: add BB wrapper generation 3 for RTL8922D variant
      wifi: rtw89: pci: not disable PCI completion timeout control for a variant of RTL8922DE
      wifi: rtw89: pci: disable PCI PHY error flag 8
      wifi: rtw89: clear auto K delay value before downloading firmware
      wifi: rtw89: 8922d: change naming number and update values for WDE/PLE quota
      wifi: rtw89: mac: add field of release report size to DLE quota
      wifi: rtw89: mac: consolidate quota into a struct for variant chips
      wifi: rtw89: 8922d: add quota for RTL8922DE variant
      wifi: rtw89: 8922d: refactor digital power compensation to support new format
      wifi: rtw89: 8922d: support new digital power compensation format
      wifi: rtw89: fw: load TX compensation element by RFE type
      wifi: rtw89: 8851bu: add Mercusys MA60XNB (2c4e:0128)

Po-Hao Huang (2):
      wifi: rtw89: 8852a: refine power save to lower latency
      wifi: rtw89: correct drop logic for malformed AMPDU frames

Shin-Yi Lin (1):
      wifi: rtw89: Correct data type for scan index to avoid infinite loop

Tristan Madani (2):
      wifi: rtw88: fix OOB read from firmware RX descriptor exceeding DMA buffer
      wifi: rtw89: add bounds check on firmware mac_id in link lookup

Zong-Zhe Yang (10):
      wifi: rtw89: 8852bt: configure support_noise field explicitly
      wifi: rtw89: chan: introduce new helper to get entity current configuration
      wifi: rtw89: 8922d: update RF calibration flow for MLD
      wifi: rtw89: debug: Wi-Fi 7 show count of SER L0 simulation
      wifi: rtw89: debug: Wi-Fi 7 update simulation of SER L0/L1 by halt H2C command
      wifi: rtw89: fw: dump status of H2C command and C2H event for SER
      wifi: rtw89: fw: load TX power track element according to AID
      wifi: rtw89: Wi-Fi 7 configure TX power limit for large MRU
      wifi: rtw89: debug: show large MRU in txpwr_table dbgfs
      wifi: rtw89: 8922d: configure TX shape settings

 .../ABI/testing/sysfs-class-ieee80211-rtw89        |  24 +
 drivers/net/wireless/realtek/rtl8xxxu/8188e.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8188f.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192c.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192e.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8192f.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8710b.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723a.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/8723b.c      |   1 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  77 +-
 drivers/net/wireless/realtek/rtl8xxxu/regs.h       |   2 +
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |   7 +
 drivers/net/wireless/realtek/rtlwifi/base.c        |  17 +-
 drivers/net/wireless/realtek/rtlwifi/pci.c         |   7 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/hw.c    |  21 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/trx.h   |   2 +-
 drivers/net/wireless/realtek/rtw88/fw.c            |   3 +
 drivers/net/wireless/realtek/rtw88/pci.c           |  29 +-
 drivers/net/wireless/realtek/rtw88/rx.c            |  31 +-
 drivers/net/wireless/realtek/rtw88/rx.h            |   6 +-
 drivers/net/wireless/realtek/rtw88/sdio.c          |   8 +-
 drivers/net/wireless/realtek/rtw88/tx.c            |  25 +-
 drivers/net/wireless/realtek/rtw88/usb.c           |  22 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |  12 +
 drivers/net/wireless/realtek/rtw89/Makefile        |   3 +
 drivers/net/wireless/realtek/rtw89/chan.c          |  92 ++-
 drivers/net/wireless/realtek/rtw89/chan.h          |  21 +-
 drivers/net/wireless/realtek/rtw89/core.c          | 815 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h          | 347 +++++++-
 drivers/net/wireless/realtek/rtw89/debug.c         | 892 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.c            | 500 +++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h            | 115 ++-
 drivers/net/wireless/realtek/rtw89/mac.c           | 153 +++-
 drivers/net/wireless/realtek/rtw89/mac.h           |  52 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c      |  29 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  68 +-
 drivers/net/wireless/realtek/rtw89/pci.c           |  41 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   6 +-
 drivers/net/wireless/realtek/rtw89/pci_be.c        |  15 +
 drivers/net/wireless/realtek/rtw89/phy.c           | 622 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/phy.h           | 164 +++-
 drivers/net/wireless/realtek/rtw89/phy_be.c        | 744 +++++++++++++----
 drivers/net/wireless/realtek/rtw89/ps.c            |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h           | 289 +++++++
 drivers/net/wireless/realtek/rtw89/regd.c          |  24 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |  63 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852au.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |  58 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852bte.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  68 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h      |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852cu.c     |  13 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      | 335 ++++++--
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |  22 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922au.c     |  86 ++
 drivers/net/wireless/realtek/rtw89/rtw8922d.c      | 445 +++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.c  |  92 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922d_rfk.h  |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922de.c     |   2 +
 drivers/net/wireless/realtek/rtw89/sar.c           |   4 +
 drivers/net/wireless/realtek/rtw89/txrx.h          | 110 +++
 drivers/net/wireless/realtek/rtw89/usb.c           | 199 ++++-
 drivers/net/wireless/realtek/rtw89/usb.h           |  11 +-
 74 files changed, 6188 insertions(+), 767 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-ieee80211-rtw89
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922au.c

