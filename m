Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9845B15DA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 09:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiIHHme (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 03:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiIHHm3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 03:42:29 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECA5BD51EE
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 00:42:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2887frKrB010329, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2887frKrB010329
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 8 Sep 2022 15:41:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 15:42:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 8 Sep 2022
 15:42:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 1/5] wifi: rtw89: use u32_get_bits to access C2H content of PHY capability
Date:   Thu, 8 Sep 2022 15:41:36 +0800
Message-ID: <20220908074140.39776-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220908074140.39776-1-pkshih@realtek.com>
References: <20220908074140.39776-1-pkshih@realtek.com>
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

The definitions of bit fields in structure will be wrong in big-endian
platform, so use u32_get_bits() to access them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 41 +++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.c | 17 +++++-----
 2 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index edd43f00994c4..de70d012cd9bc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -63,21 +63,32 @@ enum rtw89_mac_c2h_type {
 	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF
 };
 
-struct rtw89_c2h_phy_cap {
-	u32 func:7;
-	u32 ack:1;
-	u32 len:4;
-	u32 seq:4;
-	u32 rx_nss:8;
-	u32 bw:8;
-
-	u32 tx_nss:8;
-	u32 prot:8;
-	u32 nic:8;
-	u32 wl_func:8;
-
-	u32 hw_type:8;
-} __packed;
+#define RTW89_GET_C2H_PHYCAP_FUNC(info) \
+	u32_get_bits(*((const u32 *)(info)), GENMASK(6, 0))
+#define RTW89_GET_C2H_PHYCAP_ACK(info) \
+	u32_get_bits(*((const u32 *)(info)), BIT(7))
+#define RTW89_GET_C2H_PHYCAP_LEN(info) \
+	u32_get_bits(*((const u32 *)(info)), GENMASK(11, 8))
+#define RTW89_GET_C2H_PHYCAP_SEQ(info) \
+	u32_get_bits(*((const u32 *)(info)), GENMASK(15, 12))
+#define RTW89_GET_C2H_PHYCAP_RX_NSS(info) \
+	u32_get_bits(*((const u32 *)(info)), GENMASK(23, 16))
+#define RTW89_GET_C2H_PHYCAP_BW(info) \
+	u32_get_bits(*((const u32 *)(info)), GENMASK(31, 24))
+#define RTW89_GET_C2H_PHYCAP_TX_NSS(info) \
+	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(7, 0))
+#define RTW89_GET_C2H_PHYCAP_PROT(info) \
+	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(15, 8))
+#define RTW89_GET_C2H_PHYCAP_NIC(info) \
+	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(23, 16))
+#define RTW89_GET_C2H_PHYCAP_WL_FUNC(info) \
+	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(31, 24))
+#define RTW89_GET_C2H_PHYCAP_HW_TYPE(info) \
+	u32_get_bits(*((const u32 *)(info) + 2), GENMASK(7, 0))
+#define RTW89_GET_C2H_PHYCAP_ANT_TX_NUM(info) \
+	u32_get_bits(*((const u32 *)(info) + 3), GENMASK(15, 8))
+#define RTW89_GET_C2H_PHYCAP_ANT_RX_NUM(info) \
+	u32_get_bits(*((const u32 *)(info) + 3), GENMASK(23, 16))
 
 enum rtw89_fw_c2h_category {
 	RTW89_C2H_CAT_TEST,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index f5bae0b282082..a845575124486 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2262,23 +2262,24 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_mac_c2h_info c2h_info = {0};
-	struct rtw89_c2h_phy_cap *cap =
-		(struct rtw89_c2h_phy_cap *)&c2h_info.c2hreg[0];
+	u8 tx_nss;
+	u8 rx_nss;
 	u32 ret;
 
 	ret = rtw89_mac_read_phycap(rtwdev, &c2h_info);
 	if (ret)
 		return ret;
 
-	hal->tx_nss = cap->tx_nss ?
-		      min_t(u8, cap->tx_nss, chip->tx_nss) : chip->tx_nss;
-	hal->rx_nss = cap->rx_nss ?
-		      min_t(u8, cap->rx_nss, chip->rx_nss) : chip->rx_nss;
+	tx_nss = RTW89_GET_C2H_PHYCAP_TX_NSS(c2h_info.c2hreg);
+	rx_nss = RTW89_GET_C2H_PHYCAP_RX_NSS(c2h_info.c2hreg);
+
+	hal->tx_nss = tx_nss ? min_t(u8, tx_nss, chip->tx_nss) : chip->tx_nss;
+	hal->rx_nss = rx_nss ? min_t(u8, rx_nss, chip->rx_nss) : chip->rx_nss;
 
 	rtw89_debug(rtwdev, RTW89_DBG_FW,
 		    "phycap hal/phy/chip: tx_nss=0x%x/0x%x/0x%x rx_nss=0x%x/0x%x/0x%x\n",
-		    hal->tx_nss, cap->tx_nss, chip->tx_nss,
-		    hal->rx_nss, cap->rx_nss, chip->rx_nss);
+		    hal->tx_nss, tx_nss, chip->tx_nss,
+		    hal->rx_nss, rx_nss, chip->rx_nss);
 
 	return 0;
 }
-- 
2.25.1

