Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AC3564BC5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbiGDCgE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jul 2022 22:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiGDCgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jul 2022 22:36:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF43F64D1
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jul 2022 19:36:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2642ZotC6012036, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2642ZotC6012036
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Jul 2022 10:35:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 4 Jul 2022 10:35:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 4 Jul
 2022 10:35:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/6] rtw89: 8852c: modify PCIE prebkf time
Date:   Mon, 4 Jul 2022 10:34:52 +0800
Message-ID: <20220704023453.19935-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704023453.19935-1-pkshih@realtek.com>
References: <20220704023453.19935-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/04/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMyCkVaTIIDEwOjAwOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Chia-Yuan Li <leo.li@realtek.com>

Prebkf time is to inform generating tx command if remaining backoff
time less than this setting value.
It might cause SER if generating tx command early in security mode.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 93124b815825f..799f000c59dcf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1747,6 +1747,7 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 ret;
 	u32 reg;
+	u32 val;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 	if (ret)
@@ -1764,7 +1765,16 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write32_clr(rtwdev, reg, B_AX_BTCCA_EN);
 
 	reg = rtw89_mac_reg_by_idx(R_AX_PREBKF_CFG_0, mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_PREBKF_TIME_MASK, SCH_PREBKF_24US);
+	if (rtwdev->chip->chip_id == RTL8852C) {
+		val = rtw89_read32_mask(rtwdev, R_AX_SEC_ENG_CTRL,
+					B_AX_TX_PARTIAL_MODE);
+		if (!val)
+			rtw89_write32_mask(rtwdev, reg, B_AX_PREBKF_TIME_MASK,
+					   SCH_PREBKF_24US);
+	} else {
+		rtw89_write32_mask(rtwdev, reg, B_AX_PREBKF_TIME_MASK,
+				   SCH_PREBKF_24US);
+	}
 
 	return 0;
 }
-- 
2.25.1

