Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A683F2E9275
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jan 2021 10:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbhADJTi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jan 2021 04:19:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52136 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbhADJTi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jan 2021 04:19:38 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1049IoB72023634, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1049IoB72023634
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Jan 2021 17:18:50 +0800
Received: from localhost (172.21.69.213) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 4 Jan 2021
 17:18:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH V2 00/18] rtw89: add Realtek 802.11ax driver
Date:   Mon, 4 Jan 2021 17:17:59 +0800
Message-ID: <20210104091817.15966-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This driver named rtw89, which is the next generation of rtw88, supports
Realtek 8852AE 802.11ax 2x2 chip whose new features are OFDMA, DBCC,
Spatial reuse, TWT and BSS coloring; now some of them aren't implemented
though.

The chip architecture is entirely different from the chips supported by
rtw88 like RTL8822CE 802.11ac chip. First of all, register address ranges
are totally redefined, so it's impossible to reuse register definition. To
communicate with firmware, new H2C/C2H format is proposed. In order to have
better utilization, TX DMA flow is changed to two stages DMA. To provide
rich RX status information, additional RX PPDU packets are added.

Since there are so many differences mentioned above, we decide to propose
a new driver. It has many authors, they are listed in alphabetic order:

Chin-Yen Lee <timlee@realtek.com>
Ping-Ke Shih <pkshih@realtek.com>
Po Hao Huang <phhuang@realtek.com>
Tzu-En Huang <tehuang@realtek.com>
Vincent Fann <vincent_fann@realtek.com>
Yan-Hsuan Chuang <tony0620emma@gmail.com>
Zong-Zhe Yang <kevin_yang@realtek.com>

v2:
  - fix compiler warnings made by W=1
    Reported-by: kernel test robot <lkp@intel.com>
  - sort header file alphabetically
  - fix "networking block comments" reported by checkpatch

Ping-Ke Shih (18):
  rtw89: add CAM files
  rtw89: add BT coexistence files
  rtw89: add core and trx files
  rtw89: add debug files
  rtw89: add efuse files
  rtw89: add files to download and communicate with firmware
  rtw89: add MAC files
  rtw89: implement mac80211 ops
  rtw89: add pci files
  rtw89: add phy files
  rtw89: define register names
  rtw89: add regulatory support
  rtw89: 8852a: add 8852a specific files
  rtw89: 8852a: add 8852a RFK files
  rtw89: 8852a: add 8852a RFK tables
  rtw89: 8852a: add 8852a tables
  rtw89: add ser to recover error reported by firmware
  rtw89: add Kconfig and Makefile

 drivers/net/wireless/realtek/Kconfig          |     1 +
 drivers/net/wireless/realtek/Makefile         |     1 +
 drivers/net/wireless/realtek/rtw89/Kconfig    |    50 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    23 +
 drivers/net/wireless/realtek/rtw89/cam.c      |   669 +
 drivers/net/wireless/realtek/rtw89/cam.h      |   164 +
 drivers/net/wireless/realtek/rtw89/coex.c     |   385 +
 drivers/net/wireless/realtek/rtw89/coex.h     |   102 +
 drivers/net/wireless/realtek/rtw89/core.c     |  1733 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  1909 ++
 drivers/net/wireless/realtek/rtw89/debug.c    |  1927 ++
 drivers/net/wireless/realtek/rtw89/debug.h    |    75 +
 drivers/net/wireless/realtek/rtw89/efuse.c    |   188 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |    13 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   990 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  1056 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  3257 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   763 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   521 +
 drivers/net/wireless/realtek/rtw89/pci.c      |  2567 ++
 drivers/net/wireless/realtek/rtw89/pci.h      |   560 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  2473 ++
 drivers/net/wireless/realtek/rtw89/phy.h      |   278 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  1843 ++
 drivers/net/wireless/realtek/rtw89/regd.c     |   351 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1340 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |    78 +
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  3558 +++
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |    20 +
 .../realtek/rtw89/rtw8852a_rfk_table.c        |  1561 +
 .../realtek/rtw89/rtw8852a_rfk_table.h        |   129 +
 .../wireless/realtek/rtw89/rtw8852a_table.c   | 24997 ++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852a_table.h   |    28 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   427 +
 drivers/net/wireless/realtek/rtw89/ser.h      |    14 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |   385 +
 36 files changed, 54436 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/Kconfig
 create mode 100644 drivers/net/wireless/realtek/rtw89/Makefile
 create mode 100644 drivers/net/wireless/realtek/rtw89/cam.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/cam.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/coex.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/coex.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/core.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/core.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/debug.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/debug.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/efuse.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac80211.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/pci.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/pci.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/phy.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/phy.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/reg.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/regd.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a_rfk_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852a_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/txrx.h

-- 
2.21.0

