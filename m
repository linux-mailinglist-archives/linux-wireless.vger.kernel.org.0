Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA93F25EE
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 06:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhHTEhO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 00:37:14 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39206 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhHTEhN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 00:37:13 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 17K4aTN81003743, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (smtpsrv.realtek.com[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 17K4aTN81003743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Aug 2021 12:36:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 20 Aug 2021 12:36:28 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 20 Aug
 2021 12:36:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
Date:   Fri, 20 Aug 2021 12:35:14 +0800
Message-ID: <20210820043538.12424-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2021 04:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMjAgpFekyCAwMzowODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/20/2021 04:18:54
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165674 [Aug 20 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 454 454 39c6e442fd417993330528e7f9d13ac1bf7fdf8c
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;github.com:7.1.1;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/20/2021 04:22:00
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

v6:
  - improve BT coexistence performance
  - improve power save mode
  - improve OFDMA performance
  - remove some unused code
  - fix can't obtain IPv6 address
  - support device ID 10ec:a85a
  - refine PCI interrupt flow
  - firmware: rtw89: 8852a: update fw to v0.13.28.0
    https://github.com/pkshih/linux-firmware.git 
    pick the commit 344db6dca0610341599cd3e5f8b51fcb6ae06fb5

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
 drivers/net/wireless/realtek/rtw89/Makefile   |    25 +
 drivers/net/wireless/realtek/rtw89/cam.c      |   700 +
 drivers/net/wireless/realtek/rtw89/cam.h      |   165 +
 drivers/net/wireless/realtek/rtw89/coex.c     |  5743 ++
 drivers/net/wireless/realtek/rtw89/coex.h     |   179 +
 drivers/net/wireless/realtek/rtw89/core.c     |  2428 +
 drivers/net/wireless/realtek/rtw89/core.h     |  3360 ++
 drivers/net/wireless/realtek/rtw89/debug.c    |  2404 +
 drivers/net/wireless/realtek/rtw89/debug.h    |    77 +
 drivers/net/wireless/realtek/rtw89/efuse.c    |   188 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |    13 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  1600 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  1394 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  3833 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   860 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   673 +
 drivers/net/wireless/realtek/rtw89/pci.c      |  3060 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   616 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  2748 +
 drivers/net/wireless/realtek/rtw89/phy.h      |   305 +
 drivers/net/wireless/realtek/rtw89/ps.c       |   154 +
 drivers/net/wireless/realtek/rtw89/ps.h       |    16 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  2135 +
 drivers/net/wireless/realtek/rtw89/regd.c     |   353 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2030 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |   109 +
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  3801 ++
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
 drivers/net/wireless/realtek/rtw89/util.h     |    17 +
 41 files changed, 90656 insertions(+)
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
 create mode 100644 drivers/net/wireless/realtek/rtw89/util.h

-- 
2.25.1

