Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D25B7C6270
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 03:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJLBto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 21:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbjJLBtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 21:49:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EA298
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 18:49:38 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C1nUTA1585710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C1nUTA1585710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 09:49:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 12 Oct 2023 09:49:29 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 12 Oct
 2023 09:49:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: mac: generalize register of MU-EDCA switch according to chip gen
Date:   Thu, 12 Oct 2023 09:48:58 +0800
Message-ID: <20231012014902.18523-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012014902.18523-1-pkshih@realtek.com>
References: <20231012014902.18523-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When connected with 802.11ax AP, MU-EDCA parameters are given, so enable
this hardware function by registers according to chip generation.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h    |  2 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  5 +++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  7 +++++++
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4587bd596c32..d2621f31a78a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5593,8 +5593,9 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif, bool en)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 mac_idx = rtwvif->mac_idx;
-	u16 set = B_AX_MUEDCA_EN_0 | B_AX_SET_MUEDCATIMER_TF_0;
+	u16 set = mac->muedca_ctrl.mask;
 	u32 reg;
 	u32 ret;
 
@@ -5602,7 +5603,7 @@ int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MUEDCA_EN, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->muedca_ctrl.addr, mac_idx);
 	if (en)
 		rtw89_write16_set(rtwdev, reg, set);
 	else
@@ -5754,6 +5755,11 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.port_base = &rtw89_port_base_ax,
 	.agg_len_ht = R_AX_AGG_LEN_HT_0,
 
+	.muedca_ctrl = {
+		.addr = R_AX_MUEDCA_EN,
+		.mask = B_AX_MUEDCA_EN_0 | B_AX_SET_MUEDCATIMER_TF_0,
+	},
+
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b318027a977f..982b357ec6f1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -861,6 +861,8 @@ struct rtw89_mac_gen_def {
 	const struct rtw89_port_reg *port_base;
 	u32 agg_len_ht;
 
+	struct rtw89_reg_def muedca_ctrl;
+
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
 				bool dlfw, bool include_bb);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 6c277b6b25b8..514cf566eba1 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -252,6 +252,11 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.port_base = &rtw89_port_base_be,
 	.agg_len_ht = R_BE_AGG_LEN_HT_0,
 
+	.muedca_ctrl = {
+		.addr = R_BE_MUEDCA_EN,
+		.mask = B_BE_MUEDCA_EN_0 | B_BE_SET_MUEDCATIMER_TF_0,
+	},
+
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 8c148d6041d0..96d5959c299e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3780,6 +3780,13 @@
 #define B_BE_P0_SYNC_PORT_SRC_SEL_MASK GENMASK(26, 24)
 #define B_BE_P0_TSFTR_SYNC_OFFSET_MASK GENMASK(18, 0)
 
+#define R_BE_MUEDCA_EN 0x10370
+#define R_BE_MUEDCA_EN_C1 0x14370
+#define B_BE_MUEDCA_WMM_SEL BIT(8)
+#define B_BE_SET_MUEDCATIMER_TF_1 BIT(5)
+#define B_BE_SET_MUEDCATIMER_TF_0 BIT(4)
+#define B_BE_MUEDCA_EN_0 BIT(0)
+
 #define R_BE_PORT_CFG_P0 0x10400
 #define R_BE_PORT_CFG_P0_C1 0x14400
 #define B_BE_BCN_ERLY_SORT_EN_P0 BIT(18)
-- 
2.25.1

