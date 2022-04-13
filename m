Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D264FEC13
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Apr 2022 03:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiDMBLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 21:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiDMBLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 21:11:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21A25595
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 18:08:39 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23D18RkuC014509, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23D18RkuC014509
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Apr 2022 09:08:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 09:08:26 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 13 Apr
 2022 09:08:26 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 1/4] rtw89: extend H2C of CMAC control info
Date:   Wed, 13 Apr 2022 09:08:01 +0800
Message-ID: <20220413010804.8941-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413010804.8941-1-pkshih@realtek.com>
References: <20220413010804.8941-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/13/2022 00:46:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTIgpFWkyCAxMDo1NzowMA==?=
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

In order to support new chip that has capability of 160M, we need new
format to fill new information, so add a new V1 ID for newer use. Since
most fields are the same, fill fields according to the function ID of chip.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +-
 drivers/net/wireless/realtek/rtw89/fw.c       | 47 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h       | 43 ++++++++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 5 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ec181c1989bc6..2715dc1ff73ff 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -578,7 +578,7 @@ enum rtw89_ps_mode {
 #define RTW89_2G_BW_NUM (RTW89_CHANNEL_WIDTH_40 + 1)
 #define RTW89_5G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 #define RTW89_6G_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
-#define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_80 + 1)
+#define RTW89_PPE_BW_NUM (RTW89_CHANNEL_WIDTH_160 + 1)
 
 enum rtw89_ru_bandwidth {
 	RTW89_RU26 = 0,
@@ -2413,6 +2413,7 @@ struct rtw89_chip_info {
 	const struct rtw89_btc_rf_trx_para *rf_para_dlink;
 	u8 ps_mode_supported;
 
+	u32 h2c_cctl_func_id;
 	u32 hci_func_en_addr;
 	u32 h2c_desc_size;
 	u32 txwd_body_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 986d6249c1084..bd07d2b83d077 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -780,6 +780,7 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct sk_buff *skb;
 	u8 ntx_path = hal->antenna_tx ? hal->antenna_tx : RF_B;
@@ -794,16 +795,18 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 	skb_put(skb, H2C_CMC_TBL_LEN);
 	SET_CTRL_INFO_MACID(skb->data, macid);
 	SET_CTRL_INFO_OPERATION(skb->data, 1);
-	SET_CMC_TBL_TXPWR_MODE(skb->data, 0);
-	SET_CMC_TBL_NTX_PATH_EN(skb->data, ntx_path);
-	SET_CMC_TBL_PATH_MAP_A(skb->data, 0);
-	SET_CMC_TBL_PATH_MAP_B(skb->data, map_b);
-	SET_CMC_TBL_PATH_MAP_C(skb->data, 0);
-	SET_CMC_TBL_PATH_MAP_D(skb->data, 0);
-	SET_CMC_TBL_ANTSEL_A(skb->data, 0);
-	SET_CMC_TBL_ANTSEL_B(skb->data, 0);
-	SET_CMC_TBL_ANTSEL_C(skb->data, 0);
-	SET_CMC_TBL_ANTSEL_D(skb->data, 0);
+	if (chip->h2c_cctl_func_id == H2C_FUNC_MAC_CCTLINFO_UD) {
+		SET_CMC_TBL_TXPWR_MODE(skb->data, 0);
+		SET_CMC_TBL_NTX_PATH_EN(skb->data, ntx_path);
+		SET_CMC_TBL_PATH_MAP_A(skb->data, 0);
+		SET_CMC_TBL_PATH_MAP_B(skb->data, map_b);
+		SET_CMC_TBL_PATH_MAP_C(skb->data, 0);
+		SET_CMC_TBL_PATH_MAP_D(skb->data, 0);
+		SET_CMC_TBL_ANTSEL_A(skb->data, 0);
+		SET_CMC_TBL_ANTSEL_B(skb->data, 0);
+		SET_CMC_TBL_ANTSEL_C(skb->data, 0);
+		SET_CMC_TBL_ANTSEL_D(skb->data, 0);
+	}
 	SET_CMC_TBL_DOPPLER_CTRL(skb->data, 0);
 	SET_CMC_TBL_TXPWR_TOLERENCE(skb->data, 0);
 	if (rtwvif->net_type == RTW89_NET_TYPE_AP_MODE)
@@ -811,7 +814,7 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
-			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      chip->h2c_cctl_func_id, 0, 1,
 			      H2C_CMC_TBL_LEN);
 
 	if (rtw89_h2c_tx(rtwdev, skb, false)) {
@@ -851,6 +854,8 @@ static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 
 		for (i = 0; i < RTW89_PPE_BW_NUM; i++)
 			pads[i] = pad;
+
+		return;
 	}
 
 	ru_bitmap = FIELD_GET(IEEE80211_PPE_THRES_RU_INDEX_BITMASK_MASK, ppe_thres_hdr);
@@ -885,6 +890,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 				struct ieee80211_vif *vif,
 				struct ieee80211_sta *sta)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
@@ -917,9 +923,17 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	else
 		SET_CMC_TBL_ULDL(skb->data, 0);
 	SET_CMC_TBL_MULTI_PORT_ID(skb->data, rtwvif->port);
-	SET_CMC_TBL_NOMINAL_PKT_PADDING(skb->data, pads[RTW89_CHANNEL_WIDTH_20]);
-	SET_CMC_TBL_NOMINAL_PKT_PADDING40(skb->data, pads[RTW89_CHANNEL_WIDTH_40]);
-	SET_CMC_TBL_NOMINAL_PKT_PADDING80(skb->data, pads[RTW89_CHANNEL_WIDTH_80]);
+	if (chip->h2c_cctl_func_id == H2C_FUNC_MAC_CCTLINFO_UD_V1) {
+		SET_CMC_TBL_NOMINAL_PKT_PADDING_V1(skb->data, pads[RTW89_CHANNEL_WIDTH_20]);
+		SET_CMC_TBL_NOMINAL_PKT_PADDING40_V1(skb->data, pads[RTW89_CHANNEL_WIDTH_40]);
+		SET_CMC_TBL_NOMINAL_PKT_PADDING80_V1(skb->data, pads[RTW89_CHANNEL_WIDTH_80]);
+		SET_CMC_TBL_NOMINAL_PKT_PADDING160_V1(skb->data, pads[RTW89_CHANNEL_WIDTH_160]);
+	} else if (chip->h2c_cctl_func_id == H2C_FUNC_MAC_CCTLINFO_UD) {
+		SET_CMC_TBL_NOMINAL_PKT_PADDING(skb->data, pads[RTW89_CHANNEL_WIDTH_20]);
+		SET_CMC_TBL_NOMINAL_PKT_PADDING40(skb->data, pads[RTW89_CHANNEL_WIDTH_40]);
+		SET_CMC_TBL_NOMINAL_PKT_PADDING80(skb->data, pads[RTW89_CHANNEL_WIDTH_80]);
+		SET_CMC_TBL_NOMINAL_PKT_PADDING160(skb->data, pads[RTW89_CHANNEL_WIDTH_160]);
+	}
 	if (sta)
 		SET_CMC_TBL_BSR_QUEUE_SIZE_FORMAT(skb->data,
 						  sta->deflink.he_cap.has_he);
@@ -928,7 +942,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
-			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      chip->h2c_cctl_func_id, 0, 1,
 			      H2C_CMC_TBL_LEN);
 
 	if (rtw89_h2c_tx(rtwdev, skb, false)) {
@@ -946,6 +960,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_CMC_TBL_LEN);
@@ -967,7 +982,7 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
-			      H2C_FUNC_MAC_CCTLINFO_UD, 0, 1,
+			      chip->h2c_cctl_func_id, 0, 1,
 			      H2C_CMC_TBL_LEN);
 
 	if (rtw89_h2c_tx(rtwdev, skb, false)) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2a010154a8e88..9cba8990b8365 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -973,6 +973,36 @@ static inline void SET_CMC_TBL_ANTSEL_D(void *table, u32 val)
 	le32p_replace_bits((__le32 *)(table) + 14, SET_CMC_TBL_MASK_ANTSEL_D,
 			   BIT(31));
 }
+
+#define SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING GENMASK(1, 0)
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(1, 0));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(1, 0));
+}
+
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING40_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(3, 2));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(3, 2));
+}
+
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING80_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(5, 4));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(5, 4));
+}
+
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING160_V1(void *table, u32 val)
+{
+	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(7, 6));
+	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(7, 6));
+}
+
 #define SET_CMC_TBL_MASK_ADDR_CAM_INDEX GENMASK(7, 0)
 static inline void SET_CMC_TBL_ADDR_CAM_INDEX(void *table, u32 val)
 {
@@ -1001,7 +1031,6 @@ static inline void SET_CMC_TBL_DOPPLER_CTRL(void *table, u32 val)
 	le32p_replace_bits((__le32 *)(table) + 15, SET_CMC_TBL_MASK_DOPPLER_CTRL,
 			   GENMASK(19, 18));
 }
-#define SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING GENMASK(1, 0)
 static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING(void *table, u32 val)
 {
 	le32p_replace_bits((__le32 *)(table) + 7, val, GENMASK(21, 20));
@@ -1106,13 +1135,14 @@ static inline void SET_CMC_TBL_CSI_GI_LTF(void *table, u32 val)
 	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GI_LTF,
 			   GENMASK(27, 25));
 }
-#define SET_CMC_TBL_MASK_CSI_GID_SEL BIT(0)
-static inline void SET_CMC_TBL_CSI_GID_SEL(void *table, u32 val)
+
+static inline void SET_CMC_TBL_NOMINAL_PKT_PADDING160(void *table, u32 val)
 {
-	le32p_replace_bits((__le32 *)(table) + 8, val, BIT(29));
-	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_CSI_GID_SEL,
-			   BIT(29));
+	le32p_replace_bits((__le32 *)(table) + 8, val, GENMASK(29, 28));
+	le32p_replace_bits((__le32 *)(table) + 16, SET_CMC_TBL_MASK_NOMINAL_PKT_PADDING,
+			   GENMASK(29, 28));
 }
+
 #define SET_CMC_TBL_MASK_CSI_BW GENMASK(1, 0)
 static inline void SET_CMC_TBL_CSI_BW(void *table, u32 val)
 {
@@ -2170,6 +2200,7 @@ struct rtw89_fw_h2c_rf_reg_info {
 #define H2C_CL_MAC_FR_EXCHG		0x5
 #define H2C_FUNC_MAC_CCTLINFO_UD	0x2
 #define H2C_FUNC_MAC_BCN_UPD		0x5
+#define H2C_FUNC_MAC_CCTLINFO_UD_V1	0xa
 
 /* CLASS 6 - Address CAM */
 #define H2C_CL_MAC_ADDR_CAM_UPDATE	0x6
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 9871ed78e44ca..6371bbf7a2fd5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2147,6 +2147,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 38b1383307161..d900129c1a7c8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -667,6 +667,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dav_log_efuse_size	= 16,
 	.phycap_addr		= 0x590,
 	.phycap_size		= 0x60,
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD_V1,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v1),
-- 
2.25.1

