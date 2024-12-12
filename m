Return-Path: <linux-wireless+bounces-16283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A05A89EDE87
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 05:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18484281B78
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 04:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEA31547F5;
	Thu, 12 Dec 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="oqUf4C/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AE153800
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 04:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977867; cv=none; b=sG0NxgteRBthFNiMjGtlVgo87A8vOxHp3WSImJESx0R4HPWiOmDopFC59tAlit77ycryJ3jdyC75i52byroGmdRfI9GiH8cWbB6P7WMTmpUbb94YEo2DCS8wDV9g3XrMZwx5OB63z9/jNwEx/9Mw/vli/scK226bUXa9RkGuMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977867; c=relaxed/simple;
	bh=7dl05Trlieti+GHLaASGdQ3c672266SI9NmcntDoCpY=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=oMqTp/+yD7EathGDHm9tjTXSl50+EsJVAf09SYF7atSSXxIb9aHm9ty9tzFfRDblJFaEp4sup36Buyy0ubOBms4DKg+P69YHmy6QPCqew8CtpU4fxUFPkbXyHGFbiwDqMfS9FLY39P5J0dGAkczA7vP4Hdo98GESykgcqrXkVo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=oqUf4C/h; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4BC4V2x34626272, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733977862; bh=7dl05Trlieti+GHLaASGdQ3c672266SI9NmcntDoCpY=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=oqUf4C/h2NiYUFQ+ZT2J2DDHJxaIynCSjo/C2TKG1JcrlSTQ6X7i9TGb8NTdqULER
	 saEGk7X/PAyDFJ1H1Vd9jdnGaDOxIuw1X1lTjJaO37q391OMq7R9Lxw7dA6S5m/F6U
	 PJjDqWq6odNIpq7ID1wJnu1ax4Jw2beGoTjNqVn5IbUvePUBvQ1Qz7DMbADRrDHPL0
	 M7Rr/333RElrZGV3vBX4OYYxDoESX0es8NJpZT4qDil2eyRIO5ex9T/K20lyqyTcUc
	 OdSiYn+yuEuNuGUToSV/XJhQRZIEYEO++JwSu2TXKyoQv5D9sy115g68ur8LWFctWd
	 eo1I0tlnMNVeQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4BC4V2x34626272
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Dec 2024 12:31:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 12:31:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 12 Dec
 2024 12:31:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-12-12
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <34aea27b-9825-454f-9c0a-2e8bccc8ac5f@RTEXMBS04.realtek.com.tw>
Date: Thu, 12 Dec 2024 12:31:01 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit dfc14664794a4706e0c2186a0c082386e6b14c4d:

  Merge branch 'net-make-rss-rxnfc-semantics-more-explicit' (2024-11-14 19:53:44 -0800)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-12-12

for you to fetch changes up to 09489812013f9ff3850c3af9900c88012b8c1e5d:

  wifi: rtw89: phy: add dummy C2H event handler for report of TAS power (2024-12-12 11:09:12 +0800)

----------------------------------------------------------------
rtw-next patches for v6.14

Regular development in this period. Main changes are listed:

rtl8xxxu:

 * add more USB devices IDs

rtlwifi:

 * refine error path

rtw88:

 * add more USB devices IDs

 * enable USB RX aggregation and USB 3 to improve performance

rtw89:

 * implement more stuffs including PS flow for MLO

----------------------------------------------------------------
Bitterblue Smith (2):
      wifi: rtw88: usb: Support USB 3 with RTL8812AU
      wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au

Chih-Kang Chang (3):
      wifi: rtw89: 8922a: use RSSI from PHY report in RX descriptor
      wifi: rtw89: add crystal_cap check to avoid setting as overflow value
      wifi: rtw89: 8922a: update format of RFK pre-notify H2C command v2

Colin Ian King (1):
      wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop

Eric Huang (1):
      wifi: rtw89: ps: update data for firmware and settings for hardware before/after PS

Hans de Goede (1):
      wifi: rtl8xxxu: add more missing rtl8192cu USB IDs

Kuan-Chung Chen (5):
      wifi: rtw89: sar: tweak 6GHz SAR subbands span
      wifi: rtw89: introduce dynamic antenna gain feature
      wifi: rtw89: handle different TX power between RF path
      wifi: rtw89: disable firmware training HE GI and LTF
      wifi: rtw89: 8852c: disable ER SU when 4x HE-LTF and 0.8 GI capability differ

Larry Finger (1):
      wifi: rtw88: 8821au: Add additional devices to the USB_DEVICE list

Nick Morrow (2):
      wifi: rtw88: 8812au: Add more device IDs
      wifi: rtw88: Add additional USB IDs for RTL8812BU

Ping-Ke Shih (6):
      wifi: rtw89: pci: disable PCIE wake bit when PCIE deinit
      wifi: rtw89: ps: refactor PS flow to support MLO
      wifi: rtw89: ps: refactor channel info to firmware before entering PS
      wifi: rtw89: 8852c: rfk: refine target channel calculation in _rx_dck_channel_calc()
      wifi: rtw89: 8851b: rfk: remove unnecessary assignment of return value of _dpk_dgain_read()
      wifi: rtw89: phy: add dummy C2H event handler for report of TAS power

Po-Hao Huang (3):
      wifi: rtw89: 8922a: Extend channel info field length for scan
      wifi: rtw89: 8852b: add beacon filter and CQM support
      wifi: rtw89: 8852bt: add beacon filter and CQM support

Thadeu Lima de Souza Cascardo (9):
      wifi: rtlwifi: do not complete firmware loading needlessly
      wifi: rtlwifi: rtl8192se: rise completion of firmware loading as last step
      wifi: rtlwifi: wait for firmware loading before releasing memory
      wifi: rtlwifi: fix init_sw_vars leak when probe fails
      wifi: rtlwifi: usb: fix workqueue leak when probe fails
      wifi: rtlwifi: remove unused check_buddy_priv
      wifi: rtlwifi: destroy workqueue at rtl_deinit_core
      wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      wifi: rtlwifi: pci: wait for firmware loading before releasing memory

Zong-Zhe Yang (8):
      wifi: rtw89: 8922a: configure AP_LINK_PS if FW supports
      wifi: rtw89: register ops of can_activate_links
      wifi: rtw89: implement ops of change vif/sta links
      wifi: rtw89: apply MLD pairwise key to dynamically active links
      wifi: rtw89: pass target link_id to ieee80211_gtk_rekey_add()
      wifi: rtw89: pass target link_id to ieee80211_nullfunc_get()
      wifi: rtw89: refine link handling for link_sta_rc_update
      wifi: rtw89: regd: update regulatory map to R68-R51

 drivers/net/wireless/realtek/rtl8xxxu/core.c       |  20 ++
 drivers/net/wireless/realtek/rtlwifi/base.c        |  13 +-
 drivers/net/wireless/realtek/rtlwifi/base.h        |   1 -
 drivers/net/wireless/realtek/rtlwifi/pci.c         |  61 +---
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |   7 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |   4 +-
 drivers/net/wireless/realtek/rtlwifi/usb.c         |  12 +-
 drivers/net/wireless/realtek/rtlwifi/wifi.h        |  12 -
 drivers/net/wireless/realtek/rtw88/rtw8812au.c     |  68 ++++-
 drivers/net/wireless/realtek/rtw88/rtw8821au.c     |  52 +++-
 drivers/net/wireless/realtek/rtw88/rtw8822bu.c     |   6 +
 drivers/net/wireless/realtek/rtw88/usb.c           |  72 ++++-
 drivers/net/wireless/realtek/rtw89/acpi.c          |  47 ++++
 drivers/net/wireless/realtek/rtw89/acpi.h          |   9 +
 drivers/net/wireless/realtek/rtw89/cam.c           |  32 ++-
 drivers/net/wireless/realtek/rtw89/cam.h           |   5 +
 drivers/net/wireless/realtek/rtw89/core.c          | 164 +++++++++--
 drivers/net/wireless/realtek/rtw89/core.h          | 145 ++++++++++
 drivers/net/wireless/realtek/rtw89/debug.c         |   4 +
 drivers/net/wireless/realtek/rtw89/fw.c            | 266 +++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h            |  69 ++++-
 drivers/net/wireless/realtek/rtw89/mac.c           |  79 +++++-
 drivers/net/wireless/realtek/rtw89/mac.h           |  43 +++
 drivers/net/wireless/realtek/rtw89/mac80211.c      | 289 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c        |  15 +
 drivers/net/wireless/realtek/rtw89/pci.c           |  16 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   9 +
 drivers/net/wireless/realtek/rtw89/pci_be.c        |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c           | 313 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/phy.h           |  33 ++-
 drivers/net/wireless/realtek/rtw89/ps.c            |  42 +--
 drivers/net/wireless/realtek/rtw89/ps.h            |   4 +-
 drivers/net/wireless/realtek/rtw89/reg.h           |   4 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  57 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c  |   2 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |   7 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      |   3 +
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   |  50 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852bt.c     |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |  54 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |  21 +-
 drivers/net/wireless/realtek/rtw89/sar.c           |  57 +---
 drivers/net/wireless/realtek/rtw89/ser.c           |   1 +
 drivers/net/wireless/realtek/rtw89/txrx.h          |   3 +
 drivers/net/wireless/realtek/rtw89/wow.c           |  11 +-
 47 files changed, 1840 insertions(+), 358 deletions(-)

