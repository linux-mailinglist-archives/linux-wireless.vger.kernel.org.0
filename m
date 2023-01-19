Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0CF6736EE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 12:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjASLdD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 06:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjASLca (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 06:32:30 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1309E74960
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 03:32:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30JBW0AX0028468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30JBW0AX0028468
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 19:32:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Thu, 19 Jan 2023 19:32:01 +0800
Received: from localhost (172.16.17.60) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 19:32:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <Jes.Sorensen@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <rtl8821cerfe2@gmail.com>
Subject: [PATCH] wifi: rtl8xxxu: fix txdw7 assignment of TX DESC v3
Date:   Thu, 19 Jan 2023 19:31:46 +0800
Message-ID: <20230119113146.9640-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.60]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/19/2023 11:12:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwOToxMTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Type of txdw7 is __le16, so assign __le32 is wrong. Also, the
TXDESC_ANTENNA_SELECT_C is defined for __le32, so shift 16 bits to fit
the value. Compile test only.

sparse warnings: (new ones prefixed by >>)
>> rtl8xxxu_core.c:5198:24: sparse: sparse: invalid assignment: |=
>> rtl8xxxu_core.c:5198:24: sparse:    left side has type restricted __le16
>> rtl8xxxu_core.c:5198:24: sparse:    right side has type restricted __le32

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 35dc777c1fba8..0869b95f1b3f3 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5250,7 +5250,7 @@ rtl8xxxu_fill_txdesc_v3(struct ieee80211_hw *hw, struct ieee80211_hdr *hdr,
 
 	tx_desc->txdw2 |= cpu_to_le32(TXDESC_ANTENNA_SELECT_A |
 				      TXDESC_ANTENNA_SELECT_B);
-	tx_desc->txdw7 |= cpu_to_le32(TXDESC_ANTENNA_SELECT_C);
+	tx_desc->txdw7 |= cpu_to_le16(TXDESC_ANTENNA_SELECT_C >> 16);
 }
 
 static void rtl8xxxu_tx(struct ieee80211_hw *hw,
-- 
2.25.1

