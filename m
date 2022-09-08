Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9205B15D8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 09:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIHHmc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiIHHm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 03:42:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D52B7D51EC
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 00:42:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2887fp7N3010317, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2887fp7N3010317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 15:41:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 8 Sep 2022 15:42:10 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 15:42:10 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/5] wifi: rtw89: support TX diversity for 1T2R variant model
Date:   Thu, 8 Sep 2022 15:41:35 +0800
Message-ID: <20220908074140.39776-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/08/2022 07:27:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvOCCkV6TIIDA2OjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

To support TX diversity, query firmware to know if it is 1T2R variant
model. Then, checking RSSI periodically to know which antenna has better
signal strength that can be seen as the antenna is close to AP. Therefore,
use the antenna with better RSSI to transmit packets dynamically.

v3:
  - patch 3/5: just 'return ret' instead of overwriting error code.

v2:
  - patch 3/5: use separate 'ret'
  - patch 5/5: no need casting from void pointer

Ping-Ke Shih (5):
  wifi: rtw89: use u32_get_bits to access C2H content of PHY capability
  wifi: rtw89: parse phycap of TX/RX antenna number
  wifi: rtw89: configure TX path via H2C command
  wifi: rtw89: record signal strength per RF path
  wifi: rtw89: support TX diversity for 1T2R chipset

 drivers/net/wireless/realtek/rtw89/core.c     | 21 +++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  6 +-
 drivers/net/wireless/realtek/rtw89/debug.c    | 12 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 62 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       | 43 ++++++++-----
 drivers/net/wireless/realtek/rtw89/mac.c      | 35 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac80211.c |  3 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 56 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  6 ++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 +-
 12 files changed, 211 insertions(+), 46 deletions(-)

-- 
2.25.1

