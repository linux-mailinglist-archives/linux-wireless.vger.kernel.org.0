Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA8470BE57
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjEVMaM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbjEVM2l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 08:28:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E853E66
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 05:26:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34MCPlw06031001, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34MCPlw06031001
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 20:25:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 22 May 2023 20:25:58 +0800
Received: from [127.0.1.1] (172.16.17.50) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 22 May
 2023 20:25:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: use struct to access register-based H2C/C2H
Date:   Mon, 22 May 2023 20:25:13 +0800
Message-ID: <20230522122513.13559-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230522122513.13559-1-pkshih@realtek.com>
References: <20230522122513.13559-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.50]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The register-based H2C/C2H are used to exchange commands and events with
firmware. The exchange data is limited, but it is relatively simple,
because it can work before HCI initialization. To make these code clean,
use struct to access them. This patch doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  18 ++--
 drivers/net/wireless/realtek/rtw89/fw.h  | 102 ++++++++++++-----------
 drivers/net/wireless/realtek/rtw89/mac.c |  23 ++---
 3 files changed, 77 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ad277f22b1973..8f1ef151b8f6e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2916,12 +2916,13 @@ static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 	}
 
 	len = DIV_ROUND_UP(info->content_len + RTW89_H2CREG_HDR_LEN,
-			   sizeof(info->h2creg[0]));
+			   sizeof(info->u.h2creg[0]));
+
+	u32p_replace_bits(&info->u.hdr.w0, info->id, RTW89_H2CREG_HDR_FUNC_MASK);
+	u32p_replace_bits(&info->u.hdr.w0, len, RTW89_H2CREG_HDR_LEN_MASK);
 
-	RTW89_SET_H2CREG_HDR_FUNC(&info->h2creg[0], info->id);
-	RTW89_SET_H2CREG_HDR_LEN(&info->h2creg[0], len);
 	for (i = 0; i < RTW89_H2CREG_MAX; i++)
-		rtw89_write32(rtwdev, h2c_reg[i], info->h2creg[i]);
+		rtw89_write32(rtwdev, h2c_reg[i], info->u.h2creg[i]);
 
 	fw_info->h2c_counter++;
 	rtw89_write8_mask(rtwdev, chip->h2c_counter_reg.addr,
@@ -2951,13 +2952,14 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	}
 
 	for (i = 0; i < RTW89_C2HREG_MAX; i++)
-		info->c2hreg[i] = rtw89_read32(rtwdev, c2h_reg[i]);
+		info->u.c2hreg[i] = rtw89_read32(rtwdev, c2h_reg[i]);
 
 	rtw89_write8(rtwdev, chip->c2h_ctrl_reg, 0);
 
-	info->id = RTW89_GET_C2H_HDR_FUNC(*info->c2hreg);
-	info->content_len = (RTW89_GET_C2H_HDR_LEN(*info->c2hreg) << 2) -
-				RTW89_C2HREG_HDR_LEN;
+	info->id = u32_get_bits(info->u.hdr.w0, RTW89_C2HREG_HDR_FUNC_MASK);
+	info->content_len =
+		(u32_get_bits(info->u.hdr.w0, RTW89_C2HREG_HDR_LEN_MASK) << 2) -
+		RTW89_C2HREG_HDR_LEN;
 
 	fw_info->c2h_counter++;
 	rtw89_write8_mask(rtwdev, chip->c2h_counter_reg.addr,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 048283750a2d2..dd71beb152aeb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -18,15 +18,51 @@ enum rtw89_fw_dl_status {
 	RTW89_FWDL_WCPU_FW_INIT_RDY = 7
 };
 
-#define RTW89_GET_C2H_HDR_FUNC(info) \
-	u32_get_bits(info, GENMASK(6, 0))
-#define RTW89_GET_C2H_HDR_LEN(info) \
-	u32_get_bits(info, GENMASK(11, 8))
+struct rtw89_c2hreg_hdr {
+	u32 w0;
+};
+
+#define RTW89_C2HREG_HDR_FUNC_MASK GENMASK(6, 0)
+#define RTW89_C2HREG_HDR_ACK BIT(7)
+#define RTW89_C2HREG_HDR_LEN_MASK GENMASK(11, 8)
+#define RTW89_C2HREG_HDR_SEQ_MASK GENMASK(15, 12)
+
+struct rtw89_c2hreg_phycap {
+	u32 w0;
+	u32 w1;
+	u32 w2;
+	u32 w3;
+} __packed;
+
+#define RTW89_C2HREG_PHYCAP_W0_FUNC GENMASK(6, 0)
+#define RTW89_C2HREG_PHYCAP_W0_ACK BIT(7)
+#define RTW89_C2HREG_PHYCAP_W0_LEN GENMASK(11, 8)
+#define RTW89_C2HREG_PHYCAP_W0_SEQ GENMASK(15, 12)
+#define RTW89_C2HREG_PHYCAP_W0_RX_NSS GENMASK(23, 16)
+#define RTW89_C2HREG_PHYCAP_W0_BW GENMASK(31, 24)
+#define RTW89_C2HREG_PHYCAP_W1_TX_NSS GENMASK(7, 0)
+#define RTW89_C2HREG_PHYCAP_W1_PROT GENMASK(15, 8)
+#define RTW89_C2HREG_PHYCAP_W1_NIC GENMASK(23, 16)
+#define RTW89_C2HREG_PHYCAP_W1_WL_FUNC GENMASK(31, 24)
+#define RTW89_C2HREG_PHYCAP_W2_HW_TYPE GENMASK(7, 0)
+#define RTW89_C2HREG_PHYCAP_W3_ANT_TX_NUM GENMASK(15, 8)
+#define RTW89_C2HREG_PHYCAP_W3_ANT_RX_NUM GENMASK(23, 16)
+
+struct rtw89_h2creg_hdr {
+	u32 w0;
+};
+
+#define RTW89_H2CREG_HDR_FUNC_MASK GENMASK(6, 0)
+#define RTW89_H2CREG_HDR_LEN_MASK GENMASK(11, 8)
 
-#define RTW89_SET_H2CREG_HDR_FUNC(info, val) \
-	u32p_replace_bits(info, val, GENMASK(6, 0))
-#define RTW89_SET_H2CREG_HDR_LEN(info, val) \
-	u32p_replace_bits(info, val, GENMASK(11, 8))
+struct rtw89_h2creg_sch_tx_en {
+	u32 w0;
+	u32 w1;
+} __packed;
+
+#define RTW89_H2CREG_SCH_TX_EN_W0_EN GENMASK(31, 16)
+#define RTW89_H2CREG_SCH_TX_EN_W1_MASK GENMASK(15, 0)
+#define RTW89_H2CREG_SCH_TX_EN_W1_BAND BIT(16)
 
 #define RTW89_H2CREG_MAX 4
 #define RTW89_C2HREG_MAX 4
@@ -36,13 +72,21 @@ enum rtw89_fw_dl_status {
 struct rtw89_mac_c2h_info {
 	u8 id;
 	u8 content_len;
-	u32 c2hreg[RTW89_C2HREG_MAX];
+	union {
+		u32 c2hreg[RTW89_C2HREG_MAX];
+		struct rtw89_c2hreg_hdr hdr;
+		struct rtw89_c2hreg_phycap phycap;
+	} u;
 };
 
 struct rtw89_mac_h2c_info {
 	u8 id;
 	u8 content_len;
-	u32 h2creg[RTW89_H2CREG_MAX];
+	union {
+		u32 h2creg[RTW89_H2CREG_MAX];
+		struct rtw89_h2creg_hdr hdr;
+		struct rtw89_h2creg_sch_tx_en sch_tx_en;
+	} u;
 };
 
 enum rtw89_mac_h2c_type {
@@ -63,33 +107,6 @@ enum rtw89_mac_c2h_type {
 	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF
 };
 
-#define RTW89_GET_C2H_PHYCAP_FUNC(info) \
-	u32_get_bits(*((const u32 *)(info)), GENMASK(6, 0))
-#define RTW89_GET_C2H_PHYCAP_ACK(info) \
-	u32_get_bits(*((const u32 *)(info)), BIT(7))
-#define RTW89_GET_C2H_PHYCAP_LEN(info) \
-	u32_get_bits(*((const u32 *)(info)), GENMASK(11, 8))
-#define RTW89_GET_C2H_PHYCAP_SEQ(info) \
-	u32_get_bits(*((const u32 *)(info)), GENMASK(15, 12))
-#define RTW89_GET_C2H_PHYCAP_RX_NSS(info) \
-	u32_get_bits(*((const u32 *)(info)), GENMASK(23, 16))
-#define RTW89_GET_C2H_PHYCAP_BW(info) \
-	u32_get_bits(*((const u32 *)(info)), GENMASK(31, 24))
-#define RTW89_GET_C2H_PHYCAP_TX_NSS(info) \
-	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(7, 0))
-#define RTW89_GET_C2H_PHYCAP_PROT(info) \
-	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(15, 8))
-#define RTW89_GET_C2H_PHYCAP_NIC(info) \
-	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(23, 16))
-#define RTW89_GET_C2H_PHYCAP_WL_FUNC(info) \
-	u32_get_bits(*((const u32 *)(info) + 1), GENMASK(31, 24))
-#define RTW89_GET_C2H_PHYCAP_HW_TYPE(info) \
-	u32_get_bits(*((const u32 *)(info) + 2), GENMASK(7, 0))
-#define RTW89_GET_C2H_PHYCAP_ANT_TX_NUM(info) \
-	u32_get_bits(*((const u32 *)(info) + 3), GENMASK(15, 8))
-#define RTW89_GET_C2H_PHYCAP_ANT_RX_NUM(info) \
-	u32_get_bits(*((const u32 *)(info) + 3), GENMASK(23, 16))
-
 enum rtw89_fw_c2h_category {
 	RTW89_C2H_CAT_TEST,
 	RTW89_C2H_CAT_MAC,
@@ -214,17 +231,6 @@ struct rtw89_fw_macid_pause_grp {
 	__le32 mask_grp[4];
 } __packed;
 
-struct rtw89_h2creg_sch_tx_en {
-	u8 func:7;
-	u8 ack:1;
-	u8 total_len:4;
-	u8 seq_num:4;
-	u16 tx_en:16;
-	u16 mask:16;
-	u8 band:1;
-	u16 rsvd:15;
-} __packed;
-
 #define RTW89_H2C_MAX_SIZE 2048
 #define RTW89_CHANNEL_TIME 45
 #define RTW89_CHANNEL_TIME_6G 20
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index acba53cf7cc31..92274892e01cc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2646,6 +2646,7 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_mac_c2h_info c2h_info = {0};
+	const struct rtw89_c2hreg_phycap *phycap;
 	u8 tx_nss;
 	u8 rx_nss;
 	u8 tx_ant;
@@ -2656,10 +2657,12 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
-	tx_nss = RTW89_GET_C2H_PHYCAP_TX_NSS(c2h_info.c2hreg);
-	rx_nss = RTW89_GET_C2H_PHYCAP_RX_NSS(c2h_info.c2hreg);
-	tx_ant = RTW89_GET_C2H_PHYCAP_ANT_TX_NUM(c2h_info.c2hreg);
-	rx_ant = RTW89_GET_C2H_PHYCAP_ANT_RX_NUM(c2h_info.c2hreg);
+	phycap = &c2h_info.u.phycap;
+
+	tx_nss = u32_get_bits(phycap->w1, RTW89_C2HREG_PHYCAP_W1_TX_NSS);
+	rx_nss = u32_get_bits(phycap->w0, RTW89_C2HREG_PHYCAP_W0_RX_NSS);
+	tx_ant = u32_get_bits(phycap->w3, RTW89_C2HREG_PHYCAP_W3_ANT_TX_NUM);
+	rx_ant = u32_get_bits(phycap->w3, RTW89_C2HREG_PHYCAP_W3_ANT_RX_NUM);
 
 	hal->tx_nss = tx_nss ? min_t(u8, tx_nss, chip->tx_nss) : chip->tx_nss;
 	hal->rx_nss = rx_nss ? min_t(u8, rx_nss, chip->rx_nss) : chip->rx_nss;
@@ -2700,14 +2703,14 @@ static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
 	u32 ret;
 	struct rtw89_mac_c2h_info c2h_info = {0};
 	struct rtw89_mac_h2c_info h2c_info = {0};
-	struct rtw89_h2creg_sch_tx_en *h2creg =
-		(struct rtw89_h2creg_sch_tx_en *)h2c_info.h2creg;
+	struct rtw89_h2creg_sch_tx_en *sch_tx_en = &h2c_info.u.sch_tx_en;
 
 	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_SCH_TX_EN;
-	h2c_info.content_len = sizeof(*h2creg) - RTW89_H2CREG_HDR_LEN;
-	h2creg->tx_en = tx_en_u16;
-	h2creg->mask = mask_u16;
-	h2creg->band = band;
+	h2c_info.content_len = sizeof(*sch_tx_en) - RTW89_H2CREG_HDR_LEN;
+
+	u32p_replace_bits(&sch_tx_en->w0, tx_en_u16, RTW89_H2CREG_SCH_TX_EN_W0_EN);
+	u32p_replace_bits(&sch_tx_en->w1, mask_u16, RTW89_H2CREG_SCH_TX_EN_W1_MASK);
+	u32p_replace_bits(&sch_tx_en->w1, band, RTW89_H2CREG_SCH_TX_EN_W1_BAND);
 
 	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
 	if (ret)
-- 
2.25.1

