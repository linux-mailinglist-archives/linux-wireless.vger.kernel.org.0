Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C91CA7C629B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 04:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJLCPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 22:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbjJLCPk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 22:15:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54431C0
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 19:15:37 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C2FUlP4627382, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C2FUlP4627382
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 10:15:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 12 Oct 2023 10:15:23 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 12 Oct
 2023 10:15:22 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/6] wifi: rtw89: mac: add registers of MU-EDCA parameters for WiFi 7 chips
Date:   Thu, 12 Oct 2023 10:14:52 +0800
Message-ID: <20231012021455.19816-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012021455.19816-1-pkshih@realtek.com>
References: <20231012021455.19816-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.25]
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to chip generation, set MU-EDCA parameters from mac80211 when
connected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 16 ++++++++++------
 drivers/net/wireless/realtek/rtw89/reg.h      |  5 +++++
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 16bbb7751197..31d1f7891675 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -328,11 +328,14 @@ static void ____rtw89_conf_tx_edca(struct rtw89_dev *rtwdev,
 	rtw89_fw_h2c_set_edca(rtwdev, rtwvif, ac_to_fw_idx[ac], val);
 }
 
-static const u32 ac_to_mu_edca_param[IEEE80211_NUM_ACS] = {
-	[IEEE80211_AC_VO] = R_AX_MUEDCA_VO_PARAM_0,
-	[IEEE80211_AC_VI] = R_AX_MUEDCA_VI_PARAM_0,
-	[IEEE80211_AC_BE] = R_AX_MUEDCA_BE_PARAM_0,
-	[IEEE80211_AC_BK] = R_AX_MUEDCA_BK_PARAM_0,
+#define R_MUEDCA_ACS_PARAM(acs) {R_AX_MUEDCA_ ## acs ## _PARAM_0, \
+				 R_BE_MUEDCA_ ## acs ## _PARAM_0}
+
+static const u32 ac_to_mu_edca_param[IEEE80211_NUM_ACS][RTW89_CHIP_GEN_NUM] = {
+	[IEEE80211_AC_VO] = R_MUEDCA_ACS_PARAM(VO),
+	[IEEE80211_AC_VI] = R_MUEDCA_ACS_PARAM(VI),
+	[IEEE80211_AC_BE] = R_MUEDCA_ACS_PARAM(BE),
+	[IEEE80211_AC_BK] = R_MUEDCA_ACS_PARAM(BK),
 };
 
 static void ____rtw89_conf_tx_mu_edca(struct rtw89_dev *rtwdev,
@@ -340,6 +343,7 @@ static void ____rtw89_conf_tx_mu_edca(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_tx_queue_params *params = &rtwvif->tx_params[ac];
 	struct ieee80211_he_mu_edca_param_ac_rec *mu_edca;
+	int gen = rtwdev->chip->chip_gen;
 	u8 aifs, aifsn;
 	u16 timer_32us;
 	u32 reg;
@@ -356,7 +360,7 @@ static void ____rtw89_conf_tx_mu_edca(struct rtw89_dev *rtwdev,
 	val = FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_TIMER_MASK, timer_32us) |
 	      FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_CW_MASK, mu_edca->ecw_min_max) |
 	      FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_AIFS_MASK, aifs);
-	reg = rtw89_mac_reg_by_idx(rtwdev, ac_to_mu_edca_param[ac], rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, ac_to_mu_edca_param[ac][gen], rtwvif->mac_idx);
 	rtw89_write32(rtwdev, reg, val);
 
 	rtw89_mac_set_hw_muedca_ctrl(rtwdev, rtwvif, true);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 96d5959c299e..d62b3f93b14e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3780,6 +3780,11 @@
 #define B_BE_P0_SYNC_PORT_SRC_SEL_MASK GENMASK(26, 24)
 #define B_BE_P0_TSFTR_SYNC_OFFSET_MASK GENMASK(18, 0)
 
+#define R_BE_MUEDCA_BE_PARAM_0 0x10350
+#define R_BE_MUEDCA_BK_PARAM_0 0x10354
+#define R_BE_MUEDCA_VI_PARAM_0 0x10358
+#define R_BE_MUEDCA_VO_PARAM_0 0x1035C
+
 #define R_BE_MUEDCA_EN 0x10370
 #define R_BE_MUEDCA_EN_C1 0x14370
 #define B_BE_MUEDCA_WMM_SEL BIT(8)
-- 
2.25.1

