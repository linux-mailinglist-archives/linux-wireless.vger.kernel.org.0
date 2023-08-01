Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC7176A6C8
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjHACMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHACMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 307031BCC
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712BidnE016124, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712BidnE016124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:11:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 1 Aug 2023 10:11:58 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:11:57 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/8] wifi: rtw89: support more formats of firmware file
Date:   Tue, 1 Aug 2023 10:11:19 +0800
Message-ID: <20230801021127.15919-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initially, firmware file contains stuff related to WiFi CPU, and normally
it contains two firmwares with normal and WoWLAN types.

To reduce firmware size, we split debug formatted text into an individual
part (*1), and driver can decide to use it optionally. When we want to
debug firmware, turn on firmware log via debugfs, and then firmware sends
C2H events with log text ID that driver looks up the corresponding format
text and print out. Add this by patches 1/8 and 8/2.

  +===========================================+  <------------------------+
  |      WiFi CPU multi-firmware header       |                           |
  +-------------------------------------------+                           |
  |      WiFi CPU firmware (normal type *2) --|----------------------+    |
  +-------------------------------------------+                      |    |
  |      WiFi CPU firmware (WoWLAN type)      |                      |    |
  +-------------------------------------------+                      |    |
  |      log formatted text (*1)              |                      |    |
  +===========================================+                      |    |
                                                                     |    |
The detail of a Wifi CPU firmware (*2 in above figure) like below.   |    |
The format is also used new hardware component named BB MCU, so we   |    |
need more fields to record the information, and then firmware header |    |
format v1 is introduced by patches 3/8 and 4/8.                      |    |
                                                                     |    |
  +---------------------------------------+    <---------------------+    |
  |      Header                           |                               |
  +---------------------------------------+                               |
  |      Section header 1                 |                               |
  |      Section header 2                 |                               |
  |      Section header 3                 |                               |
  |      ...                              |                               |
  +---------------------------------------+                               |
  |      Dynamic header (variable length) |                               |
  +---------------------------------------+                               |
  |      Data used & pointed by section   |                               |
  |      ...                              |                               |
  +---------------------------------------+                               |
                                                                          |
In order to move static const tables from driver into firmware file, we   |
introduce `firmware elements` followed by WiFi CPU multi-firmware.        |
Since the header of WiFi CPU multi-firmware explicitly points out start   |
address and length, old driver will still access expected range.          |
We introduce the infrastructure by patch 6/8.                             |
                                                                          |
  +===========================================+                           |
  |      WiFi CPU multi-firmware   -----------|---------------------------+
  |                             +-------------+
  |                             |   padding   |
  +===========================================+
  | elm ID 1 | elm size |  other header data  |
  +----------+----------+                     |
  |                                           |
  +-------------------------------------------+
  | content (variable length)                 |
  |                             +-------------+
  |                             |   padding   |
  +===========================================+
  | elm ID 2 | elm size |  other header data  |
  +----------+----------+                     |
  |                                           |
  +-------------------------------------------+
  | content (variable length)                 |
  |                   +-----------------------+
  |                   |
  +===================+

Chin-Yen Lee (2):
  Wifi: rtw89: recognize log format from firmware file
  wifi: rtw89: support firmware log with formatted text

Ping-Ke Shih (6):
  wifi: rtw89: introduce v1 format of firmware header
  wifi: rtw89: add firmware parser for v1 format
  wifi: rtw89: add firmware suit for BB MCU 0/1
  wifi: rtw89: introduce infrastructure of firmware elements
  wifi: rtw89: add to parse firmware elements of BB and RF tables
  wifi: rtw89: return failure if needed firmware elements are not
    recognized

 drivers/net/wireless/realtek/rtw89/core.c     |   8 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  41 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |  14 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 537 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 121 +++-
 drivers/net/wireless/realtek/rtw89/mac.c      |   3 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  15 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 11 files changed, 696 insertions(+), 47 deletions(-)

-- 
2.25.1

