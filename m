Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC2344D011
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 03:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKKCkS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 21:40:18 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:52884 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbhKKCkR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 21:40:17 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AB2bOyW5008580, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AB2bOyW5008580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Nov 2021 10:37:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 11 Nov 2021 10:37:23 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 11 Nov
 2021 10:37:23 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 0/2] rtw89: correct scan behavior and results
Date:   Thu, 11 Nov 2021 10:37:04 +0800
Message-ID: <20211111023706.14154-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2021 02:24:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzExIKRXpMggMTI6MjM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 11/11/2021 02:21:48
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 167193 [Nov 11 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 465 465 eb31509370142567679dd183ac984a0cb2ee3296
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/11/2021 02:24:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

First patch fixes no ack to probe response for randomize MAC sacn.
The second one is to report correct frequency and rate while scanning.

Note: this patchset add some functions followed by the patchset
      "rtw89: fix crash when loading firmware file on certain platforms"

Ping-Ke Shih (1):
  rtw89: update scan_mac_addr during scanning period

Po Hao Huang (1):
  rtw89: fix incorrect channel info during scan

 drivers/net/wireless/realtek/rtw89/cam.c      |  22 ++--
 drivers/net/wireless/realtek/rtw89/cam.h      |   3 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  57 ++++++---
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/debug.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |   5 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |   3 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   6 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 111 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  60 ++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  23 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  19 +++
 drivers/net/wireless/realtek/rtw89/txrx.h     |  45 +------
 14 files changed, 292 insertions(+), 72 deletions(-)

-- 
2.25.1

