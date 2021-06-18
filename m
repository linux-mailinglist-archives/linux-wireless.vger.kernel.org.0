Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82E83AC421
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 08:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhFRGtK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 02:49:10 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38845 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhFRGtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 02:49:10 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 15I6kuLoB010955, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 15I6kuLoB010955
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Jun 2021 14:46:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 18 Jun 2021 14:46:55 +0800
Received: from localhost (172.16.16.17) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 18 Jun
 2021 14:46:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/24] rtw89: add Realtek 802.11ax driver
Date:   Fri, 18 Jun 2021 14:46:01 +0800
Message-ID: <20210618064625.14131-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.17]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:27:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzYvMTggpFekyCAwNjowMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 06/18/2021 06:23:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 164465 [Jun 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 448 448 71fb1b37213ce9a885768d4012c46ac449c77b17
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;github.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2021 06:27:00
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

v5:
  - add OFDMA feature
  - improve BT coexistence performance
  - improve power save mode
  - support SAR
  - fine tune performance
  - firmware: rtw89: 8852a: update fw to v0.13.24.0
    https://github.com/pkshih/linux-firmware.git 
    pick the commit a5b79c4790da3eb3690e23554225ef8db464f2c6
v4:
  - add basic BT coexistence features
  - add power save mode, so an new patch (two files) is added
  - fine tune performance
  - add debugfs for debugging coex, bb, ...
v3:
  - fix "networking block comments" reported by checkpatch
  - Add MODULE_DEVICE_TABLE() generated by Thomas Backlund <tmb@mageia.org>
  - Add missed BB settings
  - error handle of RX BD and DESC length
  - reduce debug level of C2H ACKs
  - fix rekey failure due to wrong operator
v2:
  - fix compiler warnings made by W=1
    Reported-by: kernel test robot <lkp@intel.com>
  - sort header file alphabetically
  - fix "networking block comments" reported by checkpatch

Ping-Ke Shih (24):
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
  rtw89: 8852a: add 8852a tables (1 of 5)
  rtw89: 8852a: add 8852a tables (2 of 5)
  rtw89: 8852a: add 8852a tables (3 of 5)
  rtw89: 8852a: add 8852a tables (4 of 5)
  rtw89: 8852a: add 8852a tables (5 of 5)
  rtw89: add ser to recover error reported by firmware
  rtw89: add PS files
  rtw89: add SAR files
  rtw89: add Kconfig and Makefile

 drivers/net/wireless/realtek/Kconfig          |     1 +
 drivers/net/wireless/realtek/Makefile         |     1 +
 drivers/net/wireless/realtek/rtw89/Kconfig    |    50 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    26 +
 drivers/net/wireless/realtek/rtw89/cam.c      |   700 +
 drivers/net/wireless/realtek/rtw89/cam.h      |   165 +
 drivers/net/wireless/realtek/rtw89/coex.c     |  5620 ++
 drivers/net/wireless/realtek/rtw89/coex.h     |   152 +
 drivers/net/wireless/realtek/rtw89/core.c     |  2359 +
 drivers/net/wireless/realtek/rtw89/core.h     |  3336 ++
 drivers/net/wireless/realtek/rtw89/debug.c    |  2404 +
 drivers/net/wireless/realtek/rtw89/debug.h    |    77 +
 drivers/net/wireless/realtek/rtw89/efuse.c    |   188 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |    13 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  1599 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  1378 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  4070 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   905 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   667 +
 drivers/net/wireless/realtek/rtw89/pci.c      |  3030 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   601 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  2736 +
 drivers/net/wireless/realtek/rtw89/phy.h      |   305 +
 drivers/net/wireless/realtek/rtw89/ps.c       |   149 +
 drivers/net/wireless/realtek/rtw89/ps.h       |    15 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  2116 +
 drivers/net/wireless/realtek/rtw89/regd.c     |   353 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2083 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |   109 +
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  3806 ++
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |    22 +
 .../realtek/rtw89/rtw8852a_rfk_table.c        |  1596 +
 .../realtek/rtw89/rtw8852a_rfk_table.h        |   132 +
 .../wireless/realtek/rtw89/rtw8852a_table.c   | 48725 ++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852a_table.h   |    28 +
 drivers/net/wireless/realtek/rtw89/sar.c      |   190 +
 drivers/net/wireless/realtek/rtw89/sar.h      |    26 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   491 +
 drivers/net/wireless/realtek/rtw89/ser.h      |    15 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |   393 +
 drivers/net/wireless/realtek/rtw89/util.c     |    37 +
 drivers/net/wireless/realtek/rtw89/util.h     |    31 +
 42 files changed, 90700 insertions(+)
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
 create mode 100644 drivers/net/wireless/realtek/rtw89/ps.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ps.h
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
 create mode 100644 drivers/net/wireless/realtek/rtw89/sar.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/sar.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/txrx.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.h

-- 
2.25.1

