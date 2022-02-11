Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6B34B1F29
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Feb 2022 08:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238024AbiBKHQI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Feb 2022 02:16:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiBKHQI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Feb 2022 02:16:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F88710A4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 23:16:06 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21B7FvsdE011046, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21B7FvsdE011046
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 15:15:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 11 Feb 2022 15:15:56 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 11 Feb
 2022 15:15:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <ku920601@realtek.com>
Subject: [PATCH 0/6] rtw88: switch WiFi to 1ss mode to get better experience with BT HID gaming device
Date:   Fri, 11 Feb 2022 15:15:27 +0800
Message-ID: <20220211071533.34716-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/11/2022 07:03:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTEgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The BT HID gaming controller uses high frequency BT traffic to quickly
reflect user's operation. Then, it occupies too much timeslot, and WiFi
doesn't have enough time to TX/RX data, and leads low throughput. To
handle this case, switch WiFi to 1SS mode and coexistence uses freerun
operation mode.

Chin-Yen Lee (1):
  rtw88: 8822ce: add support for txrx 1ss mode

Ching-Te Ku (5):
  rtw88: coex: Improve WL throughput when HFP COEX
  rtw88: coex: update BT PTA counter regularly
  rtw88: coex: Add WL MIMO power saving for Bluetooth gaming controller
  rtw88: coex: Add C2H/H2C handshake with BT mailbox for asking HID Info
  rtw88: coex: Update rtl8822c COEX version to 22020720

 drivers/net/wireless/realtek/rtw88/coex.c     | 298 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/coex.h     |   5 +
 drivers/net/wireless/realtek/rtw88/debug.c    |   4 +-
 drivers/net/wireless/realtek/rtw88/fw.c       |  15 +
 drivers/net/wireless/realtek/rtw88/fw.h       |   9 +
 drivers/net/wireless/realtek/rtw88/main.c     |  36 ++-
 drivers/net/wireless/realtek/rtw88/main.h     |  48 ++-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  43 ++-
 drivers/net/wireless/realtek/rtw88/tx.c       |   2 +-
 12 files changed, 426 insertions(+), 37 deletions(-)

-- 
2.25.1

