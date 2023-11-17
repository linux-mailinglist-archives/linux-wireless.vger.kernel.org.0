Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC47EEB2C
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjKQCll (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbjKQClj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:39 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93241CE
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:35 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fSM012818749, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fSM012818749
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 17 Nov 2023 10:41:28 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/6] wifi: rtw89: 8922a: read efuse content from physical map
Date:   Fri, 17 Nov 2023 10:40:29 +0800
Message-ID: <20231117024029.113845-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117024029.113845-1-pkshih@realtek.com>
References: <20231117024029.113845-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The calibration values of thermal and bias are programmed in invariable
physical map. Read them into driver and will set them to registers later.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 87 +++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 571db6fe07f9..5451a9b400c5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4345,6 +4345,7 @@ struct rtw89_power_trim_info {
 	bool pg_pa_bias_trim;
 	u8 thermal_trim[RF_PATH_MAX];
 	u8 pa_bias_trim[RF_PATH_MAX];
+	u8 pad_bias_trim[RF_PATH_MAX];
 };
 
 struct rtw89_regd {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index bed74ab4a7c2..d190f095a5a8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -175,6 +175,92 @@ static int rtw8922a_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map,
 	}
 }
 
+#define THM_TRIM_POSITIVE_MASK BIT(6)
+#define THM_TRIM_MAGNITUDE_MASK GENMASK(5, 0)
+
+static void rtw8922a_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	static const u32 thm_trim_addr[RF_PATH_NUM_8922A] = {0x1706, 0x1733};
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = true;
+	u8 pg_th;
+	s8 val;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		pg_th = phycap_map[thm_trim_addr[i] - addr];
+		if (pg_th == 0xff) {
+			info->thermal_trim[i] = 0;
+			pg = false;
+			break;
+		}
+
+		val = u8_get_bits(pg_th, THM_TRIM_MAGNITUDE_MASK);
+
+		if (!(pg_th & THM_TRIM_POSITIVE_MASK))
+			val *= -1;
+
+		info->thermal_trim[i] = val;
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_trim=0x%x (%d)\n",
+			    i, pg_th, val);
+	}
+
+	info->pg_thermal_trim = pg;
+}
+
+static void rtw8922a_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	static const u32 pabias_trim_addr[RF_PATH_NUM_8922A] = {0x1707, 0x1734};
+	static const u32 check_pa_pad_trim_addr = 0x1700;
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 val;
+	u8 i;
+
+	val = phycap_map[check_pa_pad_trim_addr - addr];
+	if (val != 0xff)
+		info->pg_pa_bias_trim = true;
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		info->pa_bias_trim[i] = phycap_map[pabias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d pa_bias_trim=0x%x\n",
+			    i, info->pa_bias_trim[i]);
+	}
+}
+
+static void rtw8922a_phycap_parsing_pad_bias_trim(struct rtw89_dev *rtwdev,
+						  u8 *phycap_map)
+{
+	static const u32 pad_bias_trim_addr[RF_PATH_NUM_8922A] = {0x1708, 0x1735};
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		info->pad_bias_trim[i] = phycap_map[pad_bias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PAD_BIAS][TRIM] path=%d pad_bias_trim=0x%x\n",
+			    i, info->pad_bias_trim[i]);
+	}
+}
+
+static int rtw8922a_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	rtw8922a_phycap_parsing_thermal_trim(rtwdev, phycap_map);
+	rtw8922a_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
+	rtw8922a_phycap_parsing_pad_bias_trim(rtwdev, phycap_map);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -186,6 +272,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 
 static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_efuse		= rtw8922a_read_efuse,
+	.read_phycap		= rtw8922a_read_phycap,
 };
 
 const struct rtw89_chip_info rtw8922a_chip_info = {
-- 
2.25.1

