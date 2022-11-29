Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77E463BBB5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 09:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiK2Idw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 03:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiK2IdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 03:33:15 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CC2A93B2
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 00:32:36 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AT8VhOM2002138, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AT8VhOM2002138
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Nov 2022 16:31:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 29 Nov 2022 16:32:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 29 Nov
 2022 16:32:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: preparation of MCC
Date:   Tue, 29 Nov 2022 16:31:24 +0800
Message-ID: <20221129083130.45708-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/29/2022 08:08:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI5IKRXpMggMDY6MDE6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patchset is preparation of MCC, which needs many handshakes between
driver and firmware, so rtw89_wait_for_cond() and rtw89_complete_cond()
are introduced to assist this work.

Based on above APIs, implement H2C and C2H handlers to interactive with
firmware, and callers of H2C will be added by another patchset.

Another basic preparation is to link rtw89_vif and channel context, but
we still use first entry as default currently, so adjust index of instance
of chandef when remove_chanctx().

v2:
  - move #define out of struct definition
  - use bare casting of completion data
  - explain H2C and C2H in commit message

Zong-Zhe Yang (6):
  wifi: rtw89: rfk: rename rtw89_mcc_info to rtw89_rfk_mcc_info
  wifi: rtw89: check if atomic before queuing c2h
  wifi: rtw89: introduce helpers to wait/complete on condition
  wifi: rtw89: mac: process MCC related C2H
  wifi: rtw89: fw: implement MCC related H2C
  wifi: rtw89: link rtw89_vif and chanctx stuffs

 drivers/net/wireless/realtek/rtw89/chan.c     |  40 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  37 ++
 drivers/net/wireless/realtek/rtw89/core.h     |  54 ++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 386 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 451 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 181 +++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  35 ++
 drivers/net/wireless/realtek/rtw89/mac80211.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  20 +-
 10 files changed, 1174 insertions(+), 35 deletions(-)

-- 
2.25.1

