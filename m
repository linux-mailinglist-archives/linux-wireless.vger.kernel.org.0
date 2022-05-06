Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EBB51D73F
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 14:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391624AbiEFMGi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 08:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391609AbiEFMGg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 08:06:36 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEBC6473D
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 05:02:52 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 246C2fDE2029471, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 246C2fDE2029471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 6 May 2022 20:02:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 20:02:41 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 6 May
 2022 20:02:40 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <hsuan8331@realtek.com>
Subject: [PATCH 2/5] rtw89: correct setting of RX MPDU length
Date:   Fri, 6 May 2022 20:02:13 +0800
Message-ID: <20220506120216.58567-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506120216.58567-1-pkshih@realtek.com>
References: <20220506120216.58567-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/06/2022 11:45:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvNiCkV6TIIDEwOjM5OjAw?=
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

Set proper setting according to RX quota, and then it doesn't break buffer
due to size of received packet exceeding buffer size.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index a06ca65b339ff..e1a1699a1a9cf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2005,6 +2005,7 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 #define TRXCFG_RMAC_DATA_TO	15
 #define RX_MAX_LEN_UNIT 512
 #define PLD_RLS_MAX_PG 127
+#define RX_SPEC_MAX_LEN (11454 + RX_MAX_LEN_UNIT)
 	int ret;
 	u32 reg, rx_max_len, rx_qta;
 	u16 val;
@@ -2035,11 +2036,10 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rx_qta = rtwdev->mac.dle_info.c0_rx_qta;
 	else
 		rx_qta = rtwdev->mac.dle_info.c1_rx_qta;
-	rx_qta = rx_qta > PLD_RLS_MAX_PG ? PLD_RLS_MAX_PG : rx_qta;
-	rx_max_len = (rx_qta - 1) * rtwdev->mac.dle_info.ple_pg_size /
-		     RX_MAX_LEN_UNIT;
-	rx_max_len = rx_max_len > B_AX_RX_MPDU_MAX_LEN_SIZE ?
-		     B_AX_RX_MPDU_MAX_LEN_SIZE : rx_max_len;
+	rx_qta = min_t(u32, rx_qta, PLD_RLS_MAX_PG);
+	rx_max_len = rx_qta * rtwdev->mac.dle_info.ple_pg_size;
+	rx_max_len = min_t(u32, rx_max_len, RX_SPEC_MAX_LEN);
+	rx_max_len /= RX_MAX_LEN_UNIT;
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_MPDU_MAX_LEN_MASK, rx_max_len);
 
 	if (rtwdev->chip->chip_id == RTL8852A &&
-- 
2.25.1

