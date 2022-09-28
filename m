Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FC15ED820
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiI1Iry (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbiI1IrC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EBF2A1C40E
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8i1w15013380, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8i1w15013380
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 28 Sep 2022 16:44:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/9] wifi: rtw89: 8852b: add tables, chip_ops and PCI entry
Date:   Wed, 28 Sep 2022 16:43:27 +0800
Message-ID: <20220928084336.34981-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/28/2022 08:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjggpFekyCAwNzowMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We are adding more materials to support 8852b. First three patches are to
add tables, but table is quite large so I split them into separated patch.
Patchese 4-8 are to add more chip_ops. The final patch is to add 8852BE
entry, but function isn't completed yet, so we don't add 8852b to Makefile
and Kconfig.

Ping-Ke Shih (7):
  wifi: rtw89: 8852b: add BB and RF tables (1 of 2)
  wifi: rtw89: 8852b: add BB and RF tables (2 of 2)
  wifi: rtw89: 8852b: add tables for RFK
  wifi: rtw89: 8852b: add chip_ops::set_txpwr
  wifi: rtw89: 8852b: add chip_ops to read efuse
  wifi: rtw89: 8852b: add chip_ops to read phy cap
  wifi: rtw89: 8852be: add 8852BE PCI entry

Zong-Zhe Yang (2):
  wifi: rtw89: phy: make generic txpwr setting functions
  wifi: rtw89: debug: txpwr_table considers sign

 drivers/net/wireless/realtek/rtw89/core.h     |     8 +
 drivers/net/wireless/realtek/rtw89/debug.c    |    12 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |     1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   167 +-
 drivers/net/wireless/realtek/rtw89/phy.h      |    25 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |     5 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   145 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.h |     1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   490 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |    90 +
 .../realtek/rtw89/rtw8852b_rfk_table.c        |   794 +
 .../realtek/rtw89/rtw8852b_rfk_table.h        |    62 +
 .../wireless/realtek/rtw89/rtw8852b_table.c   | 22877 ++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852b_table.h   |    30 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |    64 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   145 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |     1 -
 17 files changed, 24608 insertions(+), 309 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk_table.h
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_table.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b_table.h

-- 
2.25.1

