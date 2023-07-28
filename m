Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1767664B5
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjG1HEE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjG1HED (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:04:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC446210B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:04:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73iZI2031498, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73iZI2031498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 28 Jul 2023 15:03:32 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/10] wifi: rtw89: use struct to access RA report
Date:   Fri, 28 Jul 2023 15:02:49 +0800
Message-ID: <20230728070252.66525-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728070252.66525-1-pkshih@realtek.com>
References: <20230728070252.66525-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

RA (rate adaptive), a mechanism to select proper rate, is implemented in
firmware, and this report is used to tell driver TX rate it is currently
using. Use struct to access this report, and doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 24 ++++++++++++------------
 drivers/net/wireless/realtek/rtw89/phy.c | 13 +++++++------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index becd8acce9c1d..586f9707a5ed7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3160,18 +3160,18 @@ struct rtw89_c2h_mac_bcnfltr_rpt {
 #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_EVENT GENMASK(11, 10)
 #define RTW89_C2H_MAC_BCNFLTR_RPT_W2_MA GENMASK(23, 16)
 
-#define RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 0))
-#define RTW89_GET_PHY_C2H_RA_RPT_RETRY_RATIO(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(23, 16))
-#define RTW89_GET_PHY_C2H_RA_RPT_MCSNSS(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(6, 0))
-#define RTW89_GET_PHY_C2H_RA_RPT_MD_SEL(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(9, 8))
-#define RTW89_GET_PHY_C2H_RA_RPT_GILTF(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(12, 10))
-#define RTW89_GET_PHY_C2H_RA_RPT_BW(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(14, 13))
+struct rtw89_c2h_ra_rpt {
+	struct rtw89_c2h_hdr hdr;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define RTW89_C2H_RA_RPT_W2_MACID GENMASK(15, 0)
+#define RTW89_C2H_RA_RPT_W2_RETRY_RATIO GENMASK(23, 16)
+#define RTW89_C2H_RA_RPT_W3_MCSNSS GENMASK(6, 0)
+#define RTW89_C2H_RA_RPT_W3_MD_SEL GENMASK(9, 8)
+#define RTW89_C2H_RA_RPT_W3_GILTF GENMASK(12, 10)
+#define RTW89_C2H_RA_RPT_W3_BW GENMASK(14, 13)
 
 /* VHT, HE, HT-old: [6:4]: NSS, [3:0]: MCS
  * HT-new: [6:5]: NA, [4:0]: MCS
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e0d4b97a372d6..19a0c7ce0451c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2244,21 +2244,22 @@ static void rtw89_phy_c2h_ra_rpt_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_phy_iter_ra_data *ra_data = (struct rtw89_phy_iter_ra_data *)data;
 	struct rtw89_dev *rtwdev = ra_data->rtwdev;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	const struct rtw89_c2h_ra_rpt *c2h =
+		(const struct rtw89_c2h_ra_rpt *)ra_data->c2h->data;
 	struct rtw89_ra_report *ra_report = &rtwsta->ra_report;
-	struct sk_buff *c2h = ra_data->c2h;
 	u8 mode, rate, bw, giltf, mac_id;
 	u16 legacy_bitrate;
 	bool valid;
 	u8 mcs = 0;
 
-	mac_id = RTW89_GET_PHY_C2H_RA_RPT_MACID(c2h->data);
+	mac_id = le32_get_bits(c2h->w2, RTW89_C2H_RA_RPT_W2_MACID);
 	if (mac_id != rtwsta->mac_id)
 		return;
 
-	rate = RTW89_GET_PHY_C2H_RA_RPT_MCSNSS(c2h->data);
-	bw = RTW89_GET_PHY_C2H_RA_RPT_BW(c2h->data);
-	giltf = RTW89_GET_PHY_C2H_RA_RPT_GILTF(c2h->data);
-	mode = RTW89_GET_PHY_C2H_RA_RPT_MD_SEL(c2h->data);
+	rate = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_MCSNSS);
+	bw = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_BW);
+	giltf = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_GILTF);
+	mode = le32_get_bits(c2h->w3, RTW89_C2H_RA_RPT_W3_MD_SEL);
 
 	if (mode == RTW89_RA_RPT_MODE_LEGACY) {
 		valid = rtw89_ra_report_to_bitrate(rtwdev, rate, &legacy_bitrate);
-- 
2.25.1

