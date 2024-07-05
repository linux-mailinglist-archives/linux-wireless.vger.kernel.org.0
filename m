Return-Path: <linux-wireless+bounces-10000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B9992804A
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 04:18:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EEF928381D
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 02:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12E03B1A1;
	Fri,  5 Jul 2024 02:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DF6Vv5Qz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBAB4963A
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jul 2024 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720145861; cv=none; b=Y8nNrsP84q6ZIl2p+++tuk7xer/Sv2aLiNa5oH8wnJ9zyMCoWAc2nBLbhBDKzekCepkyupZCSaOeda9Ewzo39zinDUFnv6XDSYfCIWSccE4Nbn3EO0oXoM66yI0EwbGV4FJni+crVgvuR2k5sm79D5Vww+dmashI1GatyvZiD7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720145861; c=relaxed/simple;
	bh=+NwjvsDRigOlRPF5XwYtKIv8ORLoKEbO+fAjnQvrEhI=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date; b=GHKCin87pQ9ow5vtTb+ObROQXxYvMYhbasj5jJgwIfrHQYNg3fLLLE4AJtSIIwPYwmOIxYQe7S6b6hGB62QW7Nul774P59sUebd5yNJOxTcNrFeS3dwMfSkrKJPndhrLwvEQEuBWXO0gW86F1kY5bG+vwK+O1CVFmaitjoYxZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=fail (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DF6Vv5Qz reason="key not found in DNS"; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4652HaBQ24107140, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720145857; bh=+NwjvsDRigOlRPF5XwYtKIv8ORLoKEbO+fAjnQvrEhI=;
	h=From:To:Subject:MIME-Version:Content-Type:Message-ID:Date;
	b=DF6Vv5QzVdd0ZcWcFDY2S9SgUyy4bwEaZLRBWOX3UyIQkpev4LvZZlZYN3Gtvv1PQ
	 DCpeKiL1tx0aCZ9mA4C3BY5RjwIzD4Zc6C8j97NchrQaB1oMTETk6Ikf8xnYw0LNw2
	 +/D/MQGFkL1gCxTHzgaK+cUu8qyMiLrBCaTd3o34g/YgxW1rGlZ4OwEQaITVfVI9ke
	 k044RyEVOkH9Ma4BTdeuNmR/mV4IYQ6YdA42gfJ8/J17gKEzGn1baBTNUbiD5+yZHq
	 VBTDsOSOl57GD4H6+m/p3hakwvsLMDd2XIddYbZMSOclv7u2tBU79q4Ndkp8H9p5+q
	 tLKFjUkgB1bsA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4652HaBQ24107140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 5 Jul 2024 10:17:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 10:17:37 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Jul
 2024 10:17:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: pull-request: rtw-next-2024-07-05
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <9cc1069b-98a2-4404-bdaa-8a1924b1be03@RTEXMBS04.realtek.com.tw>
Date: Fri, 5 Jul 2024 10:17:36 +0800
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Hi,

A pull-request of rtw-next to wireless-next tree, more info below. Please
let me know if any problems.

Thanks
Ping-Ke

---

The following changes since commit a2ead3445a6317c5d2b53711cf9a98e54c395223:

  wifi: zd1211rw: use 'time_left' variable with wait_for_completion_timeout() (2024-06-12 15:01:09 +0300)

are available in the Git repository at:

  https://github.com/pkshih/rtw.git tags/rtw-next-2024-07-05

for you to fetch changes up to 85099c7ce4f9e64c66aa397cd9a37473637ab891:

  wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter() (2024-07-05 10:03:48 +0800)

----------------------------------------------------------------
rtw-next patches for v6.11

Some cleanups of rtl8xxxu and rtlwifi, and some fixes of rtw88. The major
change is to develop WoWLAN and preparation of RTL8852BE-VT listed below:

rtw89:
  - preparation of RTL8852BE-VT
    * add RF calibration code
    * move shared code with RTL8852BE to common module
  - add WoWLAN for WiFi 6 chips
  - support 36-bit PCI DMA

----------------------------------------------------------------
Aleksandr Mishin (1):
      wifi: rtw89: Fix array index mistake in rtw89_sta_info_get_iter()

Bitterblue Smith (1):
      wifi: rtw88: usb: Further limit the TX aggregation

Chih-Kang Chang (7):
      wifi: rtw89: wow: append security header offset for different cipher
      wifi: rtw89: wow: update WoWLAN reason register for different FW
      wifi: rtw89: wow: update config mac for 802.11ax chip
      wifi: rtw89: wow: fix GTK offload H2C skbuff issue
      wifi: rtw89: wow: prevent to send unexpected H2C during download Firmware
      wifi: rtw89: wow: enable beacon filter after swapping firmware
      wifi: rtw89: add polling for LPS H2C to ensure FW received

Ching-Te Ku (1):
      wifi: rtw89: coex: Add coexistence policy for hardware scan

Fredrik Lonnegren (1):
      wifi: rtlwifi: fix default typo

Jiapeng Chong (1):
      wifi: rtl8xxxu: use swap() in rtl8xxxu_switch_ports()

Kuan-Chung Chen (1):
      wifi: rtw89: 8852b: fix definition of KIP register number

Marcin Slusarz (1):
      wifi: rtw88: usb: schedule rx work after everything is set up

Martin Kaistra (1):
      wifi: rtl8xxxu: 8188f: Limit TX power index

Ping-Ke Shih (15):
      wifi: rtw89: 8852bx: move common code from 8852b to 8852b_common
      wifi: rtw89: 8852bx: add extra handles for 8852BT in 8852b_common
      wifi: rtw89: 885xbx: apply common settings to 8851B, 8852B and 8852BT
      wifi: rtw89: adopt firmware whose version is equal or less but closest
      wifi: rtw89: pci: support 36-bit PCI DMA address
      wifi: rtw89: pci: fix RX tag race condition resulting in wrong RX length
      wifi: rtw89: 8852bt: rfk: add TSSI
      wifi: rtw89: 8852bt: rfk: add DPK
      wifi: rtw89: 8852b: set AMSDU limit to 5000
      wifi: rtw89: 8852bt: rfk: add IQK
      wifi: rtw89: 8852bt: rfk: add RX DCK
      wifi: rtw89: 8852bt: rfk: add DACK
      wifi: rtw89: 8852bt: rfk: add RCK
      wifi: rtw89: 8852bx: move BTC common code from 8852b to 8852b_common
      wifi: rtw89: 8852bx: add extra handles of BTC for 8852BT in 8852b_common

Wolfram Sang (1):
      wifi: rtw89: use 'time_left' variable with wait_for_completion_timeout()

Zong-Zhe Yang (3):
      wifi: rtw89: constrain TX power according to Transmit Power Envelope
      wifi: rtw89: mac: parse MRC C2H failure report
      wifi: rtw89: unify the selection logic of RFK table when MCC

 drivers/net/wireless/realtek/rtl8xxxu/8188f.c      |   15 +
 drivers/net/wireless/realtek/rtl8xxxu/core.c       |    6 +-
 .../net/wireless/realtek/rtlwifi/rtl8188ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ce/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192de/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192ee/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8192se/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723ae/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/sw.c    |    2 +-
 .../net/wireless/realtek/rtlwifi/rtl8821ae/sw.c    |    2 +-
 drivers/net/wireless/realtek/rtw88/mac.c           |    9 +
 drivers/net/wireless/realtek/rtw88/main.h          |    2 +
 drivers/net/wireless/realtek/rtw88/reg.h           |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c      |    1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c      |    1 +
 drivers/net/wireless/realtek/rtw88/usb.c           |   17 +-
 drivers/net/wireless/realtek/rtw89/Kconfig         |    4 +
 drivers/net/wireless/realtek/rtw89/Makefile        |    6 +-
 drivers/net/wireless/realtek/rtw89/cam.c           |    1 +
 drivers/net/wireless/realtek/rtw89/chan.c          |   22 +
 drivers/net/wireless/realtek/rtw89/chan.h          |    4 +
 drivers/net/wireless/realtek/rtw89/coex.c          |   29 +-
 drivers/net/wireless/realtek/rtw89/core.c          |   21 +-
 drivers/net/wireless/realtek/rtw89/core.h          |   38 +-
 drivers/net/wireless/realtek/rtw89/debug.c         |   29 +-
 drivers/net/wireless/realtek/rtw89/fw.c            |  114 +-
 drivers/net/wireless/realtek/rtw89/fw.h            |    6 +
 drivers/net/wireless/realtek/rtw89/mac.c           |  112 +-
 drivers/net/wireless/realtek/rtw89/mac.h           |   11 +
 drivers/net/wireless/realtek/rtw89/mac80211.c      |    3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c        |   20 -
 drivers/net/wireless/realtek/rtw89/pci.c           |  136 +-
 drivers/net/wireless/realtek/rtw89/pci.h           |   24 +-
 drivers/net/wireless/realtek/rtw89/phy.c           |  109 +-
 drivers/net/wireless/realtek/rtw89/phy.h           |   17 +
 drivers/net/wireless/realtek/rtw89/reg.h           |   56 +
 drivers/net/wireless/realtek/rtw89/regd.c          |  190 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c      | 1866 +--------
 drivers/net/wireless/realtek/rtw89/rtw8852b.h      |  122 -
 .../net/wireless/realtek/rtw89/rtw8852b_common.c   | 2053 ++++++++++
 .../net/wireless/realtek/rtw89/rtw8852b_common.h   |  388 ++
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  |   21 +-
 drivers/net/wireless/realtek/rtw89/rtw8852be.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt.h     |   13 +
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 4019 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h |   22 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk_table.c   |  490 +++
 .../wireless/realtek/rtw89/rtw8852bt_rfk_table.h   |   38 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c  |   32 +-
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c     |    1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c      |    6 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c  |   17 +-
 drivers/net/wireless/realtek/rtw89/rtw8922ae.c     |    1 +
 drivers/net/wireless/realtek/rtw89/util.c          |  106 +
 drivers/net/wireless/realtek/rtw89/util.h          |    5 +
 drivers/net/wireless/realtek/rtw89/wow.c           |   33 +-
 drivers/net/wireless/realtek/rtw89/wow.h           |   30 +
 65 files changed, 8131 insertions(+), 2176 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c

