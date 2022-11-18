Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC3A62ED10
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 06:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiKRFLp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 00:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiKRFLm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 00:11:42 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 885526C73F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 21:11:41 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AI5ArbcE003098, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AI5ArbcE003098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Nov 2022 13:10:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Fri, 18 Nov 2022 13:11:34 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 18 Nov
 2022 13:11:34 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: rfk: rename rtw89_mcc_info to rtw89_rfk_mcc_info
Date:   Fri, 18 Nov 2022 13:10:37 +0800
Message-ID: <20221118051042.29968-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118051042.29968-1-pkshih@realtek.com>
References: <20221118051042.29968-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/18/2022 04:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRVpMggMTA6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The `rtw89_mcc_info mcc` is only for RFK MCC stuffs instead of common
MCC management info. Replace it with `rtw89_rfk_mcc_info rfk_mcc` to
avoid confusion and reserve `struct rtw89_mcc_info mcc` for MCC management
code.

(No logic changes.)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++--
 drivers/net/wireless/realtek/rtw89/fw.c       | 10 +++++-----
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  4 ++--
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 20 +++++++++----------
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b60de6662548b..3fff666c0e84a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3021,7 +3021,7 @@ struct rtw89_dack_info {
 #define RTW89_IQK_CHS_NR 2
 #define RTW89_IQK_PATH_NR 4
 
-struct rtw89_mcc_info {
+struct rtw89_rfk_mcc_info {
 	u8 ch[RTW89_IQK_CHS_NR];
 	u8 band[RTW89_IQK_CHS_NR];
 	u8 table_idx;
@@ -3567,7 +3567,7 @@ struct rtw89_dev {
 	struct rtw89_dack_info dack;
 	struct rtw89_iqk_info iqk;
 	struct rtw89_dpk_info dpk;
-	struct rtw89_mcc_info mcc;
+	struct rtw89_rfk_mcc_info rfk_mcc;
 	struct rtw89_lck_info lck;
 	struct rtw89_rx_dck_info rx_dck;
 	bool is_tssi_mode[RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 10c5ed21da025..3d7b99e15967e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2263,7 +2263,7 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_fw_h2c_rf_get_mccch *mccch;
 	struct sk_buff *skb;
 	int ret;
@@ -2276,10 +2276,10 @@ int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 	skb_put(skb, sizeof(*mccch));
 	mccch = (struct rtw89_fw_h2c_rf_get_mccch *)skb->data;
 
-	mccch->ch_0 = cpu_to_le32(mcc_info->ch[0]);
-	mccch->ch_1 = cpu_to_le32(mcc_info->ch[1]);
-	mccch->band_0 = cpu_to_le32(mcc_info->band[0]);
-	mccch->band_1 = cpu_to_le32(mcc_info->band[1]);
+	mccch->ch_0 = cpu_to_le32(rfk_mcc->ch[0]);
+	mccch->ch_1 = cpu_to_le32(rfk_mcc->ch[1]);
+	mccch->band_0 = cpu_to_le32(rfk_mcc->band[0]);
+	mccch->band_1 = cpu_to_le32(rfk_mcc->band[1]);
 	mccch->current_channel = cpu_to_le32(chan->channel);
 	mccch->current_band_type = cpu_to_le32(chan->band_type);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 6619ba7307199..fcd5703845467 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1832,11 +1832,11 @@ static void rtw8852c_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 
 static void rtw8852c_rfk_init(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 
 	rtwdev->is_tssi_mode[RF_PATH_A] = false;
 	rtwdev->is_tssi_mode[RF_PATH_B] = false;
-	memset(mcc_info, 0, sizeof(*mcc_info));
+	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
 	rtw8852c_lck_init(rtwdev);
 
 	rtw8852c_rck(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index b0672b906e7bc..60cd676fe22c9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1030,9 +1030,9 @@ static bool _iqk_nbtxk(struct rtw89_dev *rtwdev,
 
 static bool _lok_finetune_check(struct rtw89_dev *rtwdev, u8 path)
 {
-	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	u8 idx = mcc_info->table_idx;
+	u8 idx = rfk_mcc->table_idx;
 	bool is_fail1,  is_fail2;
 	u32 val;
 	u32 core_i;
@@ -1375,10 +1375,10 @@ static void _iqk_afebb_restore(struct rtw89_dev *rtwdev,
 
 static void _iqk_preset(struct rtw89_dev *rtwdev, u8 path)
 {
-	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	u8 idx = 0;
 
-	idx = mcc_info->table_idx;
+	idx = rfk_mcc->table_idx;
 	rtw89_phy_write32_mask(rtwdev, R_COEF_SEL + (path << 8), B_COEF_SEL_IQC, idx);
 	rtw89_phy_write32_mask(rtwdev, R_CFIR_LUT + (path << 8), B_CFIR_LUT_G3, idx);
 	rtw89_write_rf(rtwdev, path, RR_RSV1, RR_RSV1_RST, 0x0);
@@ -3824,20 +3824,20 @@ void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
 void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	struct rtw89_mcc_info *mcc_info = &rtwdev->mcc;
-	u8 idx = mcc_info->table_idx;
+	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	u8 idx = rfk_mcc->table_idx;
 	int i;
 
 	for (i = 0; i < RTW89_IQK_CHS_NR; i++) {
-		if (mcc_info->ch[idx] == 0)
+		if (rfk_mcc->ch[idx] == 0)
 			break;
 		if (++idx >= RTW89_IQK_CHS_NR)
 			idx = 0;
 	}
 
-	mcc_info->table_idx = idx;
-	mcc_info->ch[idx] = chan->channel;
-	mcc_info->band[idx] = chan->band_type;
+	rfk_mcc->table_idx = idx;
+	rfk_mcc->ch[idx] = chan->channel;
+	rfk_mcc->band[idx] = chan->band_type;
 }
 
 void rtw8852c_rck(struct rtw89_dev *rtwdev)
-- 
2.25.1

