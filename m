Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DE54DD31F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiCRCez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiCRCeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D033A199E1B
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XMyD4017687, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XMyD4017687
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 18 Mar 2022 10:33:22 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 11/11] rtw89: read RX bandwidth from v1 type RX descriptor
Date:   Fri, 18 Mar 2022 10:32:14 +0800
Message-ID: <20220318023214.32411-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318023214.32411-1-pkshih@realtek.com>
References: <20220318023214.32411-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/18/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTggpFekyCAxMjo0MDowMA==?=
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

8852C uses different fields to represent RX bandwidth. Since other fields
are the same, I check chip_id to get bandwidth instead of creating another
v1 function.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 6 +++++-
 drivers/net/wireless/realtek/rtw89/txrx.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 245d8514961e8..d923e4a0f963b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1492,6 +1492,7 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 			     struct rtw89_rx_desc_info *desc_info,
 			     u8 *data, u32 data_offset)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_rxdesc_short *rxd_s;
 	struct rtw89_rxdesc_long *rxd_l;
 	u8 shift_len, drv_info_len;
@@ -1502,7 +1503,10 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 	desc_info->long_rxdesc = RTW89_GET_RXWD_LONG_RXD(rxd_s);
 	desc_info->pkt_type = RTW89_GET_RXWD_RPKT_TYPE(rxd_s);
 	desc_info->mac_info_valid = RTW89_GET_RXWD_MAC_INFO_VALID(rxd_s);
-	desc_info->bw = RTW89_GET_RXWD_BW(rxd_s);
+	if (chip->chip_id == RTL8852C)
+		desc_info->bw = RTW89_GET_RXWD_BW_V1(rxd_s);
+	else
+		desc_info->bw = RTW89_GET_RXWD_BW(rxd_s);
 	desc_info->data_rate = RTW89_GET_RXWD_DATA_RATE(rxd_s);
 	desc_info->gi_ltf = RTW89_GET_RXWD_GI_LTF(rxd_s);
 	desc_info->user_id = RTW89_GET_RXWD_USER_ID(rxd_s);
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 1250e26ade406..b889e7bf34c0c 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -204,6 +204,8 @@
 	le32_get_bits((rxdesc)->dword0, GENMASK(13, 0))
 #define RTW89_GET_RXWD_BW(rxdesc) \
 	le32_get_bits((rxdesc)->dword1, GENMASK(31, 30))
+#define RTW89_GET_RXWD_BW_V1(rxdesc) \
+	le32_get_bits((rxdesc)->dword1, GENMASK(31, 29))
 #define RTW89_GET_RXWD_GI_LTF(rxdesc) \
 	le32_get_bits((rxdesc)->dword1, GENMASK(27, 25))
 #define RTW89_GET_RXWD_DATA_RATE(rxdesc) \
-- 
2.25.1

