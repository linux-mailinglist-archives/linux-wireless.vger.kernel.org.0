Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2194DD321
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Mar 2022 03:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiCRCe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 22:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiCRCeq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 22:34:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72819B09F
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 19:33:27 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22I2XKMT0017675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22I2XKMT0017675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Mar 2022 10:33:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 18 Mar 2022 10:33:20 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:33:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <johnson.lin@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 09/11] rtw89: support variant of fill_txdesc
Date:   Fri, 18 Mar 2022 10:32:12 +0800
Message-ID: <20220318023214.32411-10-pkshih@realtek.com>
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

The txdesc is descriptor related to skb->data. The v1 version contains
8 dwords txwd_body and 6 dwords txwd_info, and the format is also different
from original one.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 68 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 28 ++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      |  8 +--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  2 +
 drivers/net/wireless/realtek/rtw89/txrx.h     | 12 ++++
 6 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a5c13fd7d8a04..3c2cbe479197d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -897,6 +897,26 @@ static __le32 rtw89_build_txwd_body0(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_body0_v1(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_BODY0_WP_OFFSET_V1, desc_info->wp_offset) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_WD_INFO_EN, desc_info->en_wd_info) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_CHANNEL_DMA, desc_info->ch_dma) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_HDR_LLC_LEN, desc_info->hdr_llc_len) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_WD_PAGE, desc_info->wd_page) |
+		    FIELD_PREP(RTW89_TXWD_BODY0_FW_DL, desc_info->fw_dl);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body1_v1(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_BODY1_ADDR_INFO_NUM, desc_info->addr_info_nr) |
+		    FIELD_PREP(RTW89_TXWD_BODY1_SEC_TYPE, desc_info->sec_type);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_body2(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_BODY2_TID_INDICATE, desc_info->tid_indicate) |
@@ -916,6 +936,14 @@ static __le32 rtw89_build_txwd_body3(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_body7_v1(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_BODY7_USE_RATE_V1, desc_info->use_rate) |
+		    FIELD_PREP(RTW89_TXWD_BODY7_DATA_RATE, desc_info->data_rate);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_USE_RATE, desc_info->use_rate) |
@@ -926,6 +954,13 @@ static __le32 rtw89_build_txwd_info0(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_info0_v1(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_INFO0_DISDATAFB, desc_info->dis_data_fb);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_info1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO1_MAX_AGGNUM, desc_info->ampdu_num) |
@@ -946,6 +981,15 @@ static __le32 rtw89_build_txwd_info2(struct rtw89_tx_desc_info *desc_info)
 	return cpu_to_le32(dword);
 }
 
+static __le32 rtw89_build_txwd_info2_v1(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(RTW89_TXWD_INFO2_AMPDU_DENSITY, desc_info->ampdu_density) |
+		    FIELD_PREP(RTW89_TXWD_INFO2_FORCE_KEY_EN, desc_info->sec_en) |
+		    FIELD_PREP(RTW89_TXWD_INFO2_SEC_CAM_IDX, desc_info->sec_cam_idx);
+
+	return cpu_to_le32(dword);
+}
+
 static __le32 rtw89_build_txwd_info4(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(RTW89_TXWD_INFO4_RTS_EN, 1) |
@@ -977,6 +1021,30 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_core_fill_txdesc);
 
+void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
+			       struct rtw89_tx_desc_info *desc_info,
+			       void *txdesc)
+{
+	struct rtw89_txwd_body_v1 *txwd_body = (struct rtw89_txwd_body_v1 *)txdesc;
+	struct rtw89_txwd_info *txwd_info;
+
+	txwd_body->dword0 = rtw89_build_txwd_body0_v1(desc_info);
+	txwd_body->dword1 = rtw89_build_txwd_body1_v1(desc_info);
+	txwd_body->dword2 = rtw89_build_txwd_body2(desc_info);
+	txwd_body->dword3 = rtw89_build_txwd_body3(desc_info);
+	txwd_body->dword7 = rtw89_build_txwd_body7_v1(desc_info);
+
+	if (!desc_info->en_wd_info)
+		return;
+
+	txwd_info = (struct rtw89_txwd_info *)(txwd_body + 1);
+	txwd_info->dword0 = rtw89_build_txwd_info0_v1(desc_info);
+	txwd_info->dword1 = rtw89_build_txwd_info1(desc_info);
+	txwd_info->dword2 = rtw89_build_txwd_info2_v1(desc_info);
+	txwd_info->dword4 = rtw89_build_txwd_info4(desc_info);
+}
+EXPORT_SYMBOL(rtw89_core_fill_txdesc_v1);
+
 static __le32 rtw89_build_txwd_fwcmd0_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(AX_RXD_RPKT_LEN_MASK, desc_info->pkt_size) |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 501381bb74adf..b5587d799bd83 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -642,6 +642,17 @@ struct rtw89_txwd_body {
 	__le32 dword5;
 } __packed;
 
+struct rtw89_txwd_body_v1 {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+	__le32 dword6;
+	__le32 dword7;
+} __packed;
+
 struct rtw89_txwd_info {
 	__le32 dword0;
 	__le32 dword1;
@@ -2079,6 +2090,9 @@ struct rtw89_chip_ops {
 				       s8 pw_ofst, enum rtw89_mac_idx mac_idx);
 	int (*pwr_on_func)(struct rtw89_dev *rtwdev);
 	int (*pwr_off_func)(struct rtw89_dev *rtwdev);
+	void (*fill_txdesc)(struct rtw89_dev *rtwdev,
+			    struct rtw89_tx_desc_info *desc_info,
+			    void *txdesc);
 	void (*fill_txdesc_fwcmd)(struct rtw89_dev *rtwdev,
 				  struct rtw89_tx_desc_info *desc_info,
 				  void *txdesc);
@@ -2351,6 +2365,7 @@ struct rtw89_chip_info {
 
 	u32 hci_func_en_addr;
 	u32 h2c_desc_size;
+	u32 txwd_body_size;
 	u32 h2c_ctrl_reg;
 	const u32 *h2c_regs;
 	u32 c2h_ctrl_reg;
@@ -3514,6 +3529,16 @@ static inline void rtw89_ctrl_btg(struct rtw89_dev *rtwdev, bool btg)
 		chip->ops->ctrl_btg(rtwdev, btg);
 }
 
+static inline
+void rtw89_chip_fill_txdesc(struct rtw89_dev *rtwdev,
+			    struct rtw89_tx_desc_info *desc_info,
+			    void *txdesc)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	chip->ops->fill_txdesc(rtwdev, desc_info, txdesc);
+}
+
 static inline
 void rtw89_chip_fill_txdesc_fwcmd(struct rtw89_dev *rtwdev,
 				  struct rtw89_tx_desc_info *desc_info,
@@ -3597,6 +3622,9 @@ void rtw89_core_tx_kick_off(struct rtw89_dev *rtwdev, u8 qsel);
 void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 			    struct rtw89_tx_desc_info *desc_info,
 			    void *txdesc);
+void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
+			       struct rtw89_tx_desc_info *desc_info,
+			       void *txdesc);
 void rtw89_core_fill_txdesc_fwcmd_v1(struct rtw89_dev *rtwdev,
 				     struct rtw89_tx_desc_info *desc_info,
 				     void *txdesc);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 48a5feaf27222..3a27d6f8c6305 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1035,8 +1035,8 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 				 struct rtw89_core_tx_request *tx_req)
 {
 	struct rtw89_pci *rtwpci = (struct rtw89_pci *)rtwdev->priv;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
-	struct rtw89_txwd_body *txwd_body;
 	struct rtw89_txwd_info *txwd_info;
 	struct rtw89_pci_tx_wp_info *txwp_info;
 	void *txaddr_info_addr;
@@ -1050,8 +1050,6 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	dma_addr_t dma;
 	int ret;
 
-	rtw89_core_fill_txdesc(rtwdev, desc_info, txwd->vaddr);
-
 	dma = dma_map_single(&pdev->dev, skb->data, skb->len, DMA_TO_DEVICE);
 	if (dma_mapping_error(&pdev->dev, dma)) {
 		rtw89_err(rtwdev, "failed to map skb dma data\n");
@@ -1062,7 +1060,7 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 	tx_data->dma = dma;
 
 	txwp_len = sizeof(*txwp_info);
-	txwd_len = sizeof(*txwd_body);
+	txwd_len = chip->txwd_body_size;
 	txwd_len += en_wd_info ? sizeof(*txwd_info) : 0;
 
 	txwp_info = txwd->vaddr + txwd_len;
@@ -1079,6 +1077,8 @@ static int rtw89_pci_txwd_submit(struct rtw89_dev *rtwdev,
 
 	txwd->len = txwd_len + txwp_len + txaddr_info_len;
 
+	rtw89_chip_fill_txdesc(rtwdev, desc_info, txwd->vaddr);
+
 	skb_queue_tail(&txwd->queue, skb);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index d44502586d118..142e96b0723df 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2019,6 +2019,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= NULL,
 	.pwr_off_func		= NULL,
+	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
@@ -2097,6 +2098,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				  BIT(RTW89_PS_MODE_PWR_GATED),
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
 	.h2c_regs		= rtw8852a_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 33f0c014be7ba..46d63c450fece 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -490,6 +490,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
+	.fill_txdesc		= rtw89_core_fill_txdesc_v1,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v1,
 	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v1,
 	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v1,
@@ -515,6 +516,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.phycap_size		= 0x60,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v1),
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL_V1,
 	.h2c_regs		= rtw8852c_h2c_regs,
 	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL_V1,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 4e81d6df93688..c943e4e95721e 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -24,6 +24,7 @@
 
 /* TX WD BODY DWORD 0 */
 #define RTW89_TXWD_BODY0_WP_OFFSET GENMASK(31, 24)
+#define RTW89_TXWD_BODY0_WP_OFFSET_V1 GENMASK(28, 24)
 #define RTW89_TXWD_BODY0_MORE_DATA BIT(23)
 #define RTW89_TXWD_BODY0_WD_INFO_EN BIT(22)
 #define RTW89_TXWD_BODY0_FW_DL BIT(20)
@@ -35,7 +36,9 @@
 #define RTW89_TXWD_BODY0_HW_SSN_MODE GENMASK(1, 0)
 
 /* TX WD BODY DWORD 1 */
+#define RTW89_TXWD_BODY1_ADDR_INFO_NUM GENMASK(31, 26)
 #define RTW89_TXWD_BODY1_PAYLOAD_ID GENMASK(31, 16)
+#define RTW89_TXWD_BODY1_SEC_TYPE GENMASK(3, 0)
 
 /* TX WD BODY DWORD 2 */
 #define RTW89_TXWD_BODY2_MACID GENMASK(30, 24)
@@ -52,6 +55,14 @@
 
 /* TX WD BODY DWORD 5 */
 
+/* TX WD BODY DWORD 6 (V1) */
+
+/* TX WD BODY DWORD 7 (V1) */
+#define RTW89_TXWD_BODY7_USE_RATE_V1 BIT(31)
+#define RTW89_TXWD_BODY7_DATA_BW GENMASK(29, 28)
+#define RTW89_TXWD_BODY7_GI_LTF GENMASK(27, 25)
+#define RTW89_TXWD_BODY7_DATA_RATE GENMASK(24, 16)
+
 /* TX WD INFO DWORD 0 */
 #define RTW89_TXWD_INFO0_USE_RATE BIT(30)
 #define RTW89_TXWD_INFO0_DATA_BW GENMASK(29, 28)
@@ -69,6 +80,7 @@
 #define RTW89_TXWD_INFO2_AMPDU_DENSITY GENMASK(20, 18)
 #define RTW89_TXWD_INFO2_SEC_TYPE GENMASK(12, 9)
 #define RTW89_TXWD_INFO2_SEC_HW_ENC BIT(8)
+#define RTW89_TXWD_INFO2_FORCE_KEY_EN BIT(8)
 #define RTW89_TXWD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
 
 /* TX WD INFO DWORD 3 */
-- 
2.25.1

