Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784917C6271
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 03:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjJLBtp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 21:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjJLBtl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 21:49:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB8BA
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 18:49:39 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39C1nWTA1585710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39C1nWTA1585710
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Oct 2023 09:49:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 12 Oct 2023 09:49:31 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 12 Oct
 2023 09:49:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/6] wifi: rtw89: mac: set bfee_ctrl() according to chip gen
Date:   Thu, 12 Oct 2023 09:49:00 +0800
Message-ID: <20231012014902.18523-5-pkshih@realtek.com>
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

When associated peer has beamformer capability, enable hardware beamformee
function, and then hardware can run sounding protocol itself. Oppositely,
disable this function when disassociated. Define different registers for
WiFi 6 and 7 generations respectively.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 11 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |  5 +++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 16 ++++++++++++++++
 4 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d2621f31a78a..b47b3c9be2cb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5210,12 +5210,12 @@ static void rtw89_mac_bfee_standby_timer(struct rtw89_dev *rtwdev, u8 mac_idx,
 
 static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 reg;
-	u32 mask = B_AX_BFMEE_HT_NDPA_EN | B_AX_BFMEE_VHT_NDPA_EN |
-		   B_AX_BFMEE_HE_NDPA_EN;
+	u32 mask = mac->bfee_ctrl.mask;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BF, "set bfee ndpa_en to %d\n", en);
-	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BFMEE_RESP_OPTION, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->bfee_ctrl.addr, mac_idx);
 	if (en) {
 		set_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
 		rtw89_write32_set(rtwdev, reg, mask);
@@ -5759,6 +5759,11 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 		.addr = R_AX_MUEDCA_EN,
 		.mask = B_AX_MUEDCA_EN_0 | B_AX_SET_MUEDCATIMER_TF_0,
 	},
+	.bfee_ctrl = {
+		.addr = R_AX_BFMEE_RESP_OPTION,
+		.mask = B_AX_BFMEE_HT_NDPA_EN | B_AX_BFMEE_VHT_NDPA_EN |
+			B_AX_BFMEE_HE_NDPA_EN,
+	},
 
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 982b357ec6f1..6c043259c5e0 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -862,6 +862,7 @@ struct rtw89_mac_gen_def {
 	u32 agg_len_ht;
 
 	struct rtw89_reg_def muedca_ctrl;
+	struct rtw89_reg_def bfee_ctrl;
 
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 514cf566eba1..7cf67020c6e6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -256,6 +256,11 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 		.addr = R_BE_MUEDCA_EN,
 		.mask = B_BE_MUEDCA_EN_0 | B_BE_SET_MUEDCATIMER_TF_0,
 	},
+	.bfee_ctrl = {
+		.addr = R_BE_BFMEE_RESP_OPTION,
+		.mask = B_BE_BFMEE_HT_NDPA_EN | B_BE_BFMEE_VHT_NDPA_EN |
+			B_BE_BFMEE_HE_NDPA_EN | B_BE_BFMEE_EHT_NDPA_EN,
+	},
 
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index d62b3f93b14e..aee54859f92b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3937,6 +3937,22 @@
 #define B_BE_UPD_HGQMD BIT(1)
 #define B_BE_UPD_TIMIE BIT(0)
 
+#define R_BE_BFMEE_RESP_OPTION 0x11180
+#define R_BE_BFMEE_RESP_OPTION_C1 0x15180
+#define B_BE_BFMEE_CSI_SEC_TYPE_SH 20
+#define B_BE_BFMEE_CSI_SEC_TYPE_MSK 0xf
+#define B_BE_BFMEE_BFRPT_SEG_SIZE_SH 16
+#define B_BE_BFMEE_BFRPT_SEG_SIZE_MSK 0x3
+#define B_BE_BFMEE_MIMO_EN_SEL BIT(8)
+#define B_BE_BFMEE_MU_BFEE_DIS BIT(7)
+#define B_BE_BFMEE_CHECK_RPTPOLL_MACID_DIS BIT(6)
+#define B_BE_BFMEE_NOCHK_BFPOLL_BMP BIT(5)
+#define B_BE_BFMEE_VHTBFRPT_CHK BIT(4)
+#define B_BE_BFMEE_EHT_NDPA_EN BIT(3)
+#define B_BE_BFMEE_HE_NDPA_EN BIT(2)
+#define B_BE_BFMEE_VHT_NDPA_EN BIT(1)
+#define B_BE_BFMEE_HT_NDPA_EN BIT(0)
+
 #define R_BE_RX_FLTR_OPT 0x11420
 #define R_BE_RX_FLTR_OPT_C1 0x15420
 #define B_BE_UID_FILTER_MASK GENMASK(31, 24)
-- 
2.25.1

