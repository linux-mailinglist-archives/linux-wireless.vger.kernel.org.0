Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21B3638D3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 02:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhDSAij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 20:38:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54329 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhDSAii (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 20:38:38 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13J0c4vuD013521, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13J0c4vuD013521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 08:38:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 08:38:03 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 19 Apr
 2021 08:38:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH v2 0/3] rtw89: 8822c: add GAPK
Date:   Mon, 19 Apr 2021 08:37:45 +0800
Message-ID: <20210419003748.3224-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTggpFWkyCAwNDowNDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 00:21:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163189 [Apr 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
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
X-KSE-Antiphishing-Bases: 04/19/2021 00:25:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 00:21:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163189 [Apr 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 00:25:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

GAPK is used to calibrate RF character to make every module good
performance. With a debug switch, we can make sure if it helps in field.

Besides, we sort the register definition to make it looks better. Since
previous patchset "rtw88: add some fixes and 8822c features" also changes
the registers, I create this patchset based on the previous one, expecting
this patchset is merged later than it.

---
v2: fix merge conflicts

Guo-Feng Fan (3):
  rtw88: 8822c: reorder macro position according to the register number
  rtw88: 8822c: Add gap-k calibration to improve long range performance
  rtw88: 8822c: debug: allow debugfs to enable/disable TXGAPK

 drivers/net/wireless/realtek/rtw88/debug.c    |  91 +++
 drivers/net/wireless/realtek/rtw88/fw.c       |  12 +
 drivers/net/wireless/realtek/rtw88/fw.h       |   5 +
 drivers/net/wireless/realtek/rtw88/main.h     |  31 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   8 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 724 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h | 336 ++++----
 7 files changed, 1065 insertions(+), 142 deletions(-)

-- 
2.21.0

