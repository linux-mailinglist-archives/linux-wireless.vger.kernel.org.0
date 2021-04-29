Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C461336E66A
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 10:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbhD2IDm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 04:03:42 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:43286 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhD2IDj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 04:03:39 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13T82kR62025039, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13T82kR62025039
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 29 Apr 2021 16:02:46 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 29 Apr 2021 16:02:45 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 29 Apr
 2021 16:02:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v4 00/19] rtw89: add Realtek 802.11ax driver
Date:   Thu, 29 Apr 2021 16:01:30 +0800
Message-ID: <20210429080149.7068-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXH36502.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwMjo0NTowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:29:45
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163401 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:33:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjkgpFekyCAwNzoyMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/29/2021 07:51:53
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163403 [Apr 29 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 445 445 d5f7ae5578b0f01c45f955a2a751ac25953290c9
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/29/2021 07:54:00
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

Ping-Ke Shih (19):
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
  rtw89: add PS files
  rtw89: add Kconfig and Makefile

 drivers/net/wireless/realtek/Kconfig          |     1 +
 drivers/net/wireless/realtek/Makefile         |     1 +
 drivers/net/wireless/realtek/rtw89/Kconfig    |    50 +
 drivers/net/wireless/realtek/rtw89/Makefile   |    24 +
 drivers/net/wireless/realtek/rtw89/cam.c      |   680 +
 drivers/net/wireless/realtek/rtw89/cam.h      |   164 +
 drivers/net/wireless/realtek/rtw89/coex.c     |  5455 ++
 drivers/net/wireless/realtek/rtw89/coex.h     |   152 +
 drivers/net/wireless/realtek/rtw89/core.c     |  2195 +
 drivers/net/wireless/realtek/rtw89/core.h     |  3239 +
 drivers/net/wireless/realtek/rtw89/debug.c    |  2367 +
 drivers/net/wireless/realtek/rtw89/debug.h    |    77 +
 drivers/net/wireless/realtek/rtw89/efuse.c    |   188 +
 drivers/net/wireless/realtek/rtw89/efuse.h    |    13 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  1316 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  1150 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  3639 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |   854 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |   568 +
 drivers/net/wireless/realtek/rtw89/pci.c      |  2918 +
 drivers/net/wireless/realtek/rtw89/pci.h      |   565 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  2538 +
 drivers/net/wireless/realtek/rtw89/phy.h      |   295 +
 drivers/net/wireless/realtek/rtw89/ps.c       |   148 +
 drivers/net/wireless/realtek/rtw89/ps.h       |    15 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  2037 +
 drivers/net/wireless/realtek/rtw89/regd.c     |   351 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2047 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |   109 +
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  3806 ++
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.h |    22 +
 .../realtek/rtw89/rtw8852a_rfk_table.c        |  1596 +
 .../realtek/rtw89/rtw8852a_rfk_table.h        |   132 +
 .../wireless/realtek/rtw89/rtw8852a_table.c   | 48725 ++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852a_table.h   |    28 +
 drivers/net/wireless/realtek/rtw89/ser.c      |   435 +
 drivers/net/wireless/realtek/rtw89/ser.h      |    14 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |   389 +
 38 files changed, 88303 insertions(+)
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
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/ser.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/txrx.h

-- 
2.21.0

