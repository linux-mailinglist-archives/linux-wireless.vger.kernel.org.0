Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEB079A5F4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbjIKIW7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbjIKIW4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF7116
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:50 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8MgAxA1003652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8MgAxA1003652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:22:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Sep 2023 16:22:02 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:22:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: add to fill TX descriptor v2
Date:   Mon, 11 Sep 2023 16:20:46 +0800
Message-ID: <20230911082049.33541-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230911082049.33541-1-pkshih@realtek.com>
References: <20230911082049.33541-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The format v2 of TX descriptor contains 8-word body and 8-word info, and
fields include packet size, MAC_ID, security key ID and etc.

By design, it can possibly only fill body to reduce overhead, but this
driver keeps thing simple, so always fill body and info currently.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 130 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  25 ++++
 drivers/net/wireless/realtek/rtw89/txrx.h | 175 ++++++++++++++++++++++
 3 files changed, 330 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7e2ba17c278e..2d189e1f2650 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1215,6 +1215,136 @@ void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_core_fill_txdesc_v1);
 
+static __le32 rtw89_build_txwd_body0_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY0_WP_OFFSET_V1, desc_info->wp_offset) |
+		    FIELD_PREP(BE_TXD_BODY0_WDINFO_EN, desc_info->en_wd_info) |
+		    FIELD_PREP(BE_TXD_BODY0_CH_DMA, desc_info->ch_dma) |
+		    FIELD_PREP(BE_TXD_BODY0_HDR_LLC_LEN, desc_info->hdr_llc_len) |
+		    FIELD_PREP(BE_TXD_BODY0_WD_PAGE, desc_info->wd_page);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body1_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY1_ADDR_INFO_NUM, desc_info->addr_info_nr) |
+		    FIELD_PREP(BE_TXD_BODY1_SEC_KEYID, desc_info->sec_keyid) |
+		    FIELD_PREP(BE_TXD_BODY1_SEC_TYPE, desc_info->sec_type);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body2_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY2_TID_IND, desc_info->tid_indicate) |
+		    FIELD_PREP(BE_TXD_BODY2_QSEL, desc_info->qsel) |
+		    FIELD_PREP(BE_TXD_BODY2_TXPKTSIZE, desc_info->pkt_size) |
+		    FIELD_PREP(BE_TXD_BODY2_AGG_EN, desc_info->agg_en) |
+		    FIELD_PREP(BE_TXD_BODY2_BK, desc_info->bk) |
+		    FIELD_PREP(BE_TXD_BODY2_MACID, desc_info->mac_id);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body3_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY3_WIFI_SEQ, desc_info->seq);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body4_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY4_SEC_IV_L0, desc_info->sec_seq[0]) |
+		    FIELD_PREP(BE_TXD_BODY4_SEC_IV_L1, desc_info->sec_seq[1]);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body5_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY5_SEC_IV_H2, desc_info->sec_seq[2]) |
+		    FIELD_PREP(BE_TXD_BODY5_SEC_IV_H3, desc_info->sec_seq[3]) |
+		    FIELD_PREP(BE_TXD_BODY5_SEC_IV_H4, desc_info->sec_seq[4]) |
+		    FIELD_PREP(BE_TXD_BODY5_SEC_IV_H5, desc_info->sec_seq[5]);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_body7_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_BODY7_USERATE_SEL, desc_info->use_rate) |
+		    FIELD_PREP(BE_TXD_BODY7_DATA_ER, desc_info->er_cap) |
+		    FIELD_PREP(BE_TXD_BODY7_DATA_BW_ER, 0) |
+		    FIELD_PREP(BE_TXD_BODY7_DATARATE, desc_info->data_rate);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_info0_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_INFO0_DISDATAFB, desc_info->dis_data_fb) |
+		    FIELD_PREP(BE_TXD_INFO0_MULTIPORT_ID, desc_info->port);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_info1_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_INFO1_MAX_AGG_NUM, desc_info->ampdu_num) |
+		    FIELD_PREP(BE_TXD_INFO1_A_CTRL_BSR, desc_info->a_ctrl_bsr) |
+		    FIELD_PREP(BE_TXD_INFO1_DATA_RTY_LOWEST_RATE,
+			       desc_info->data_retry_lowest_rate);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_info2_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_INFO2_AMPDU_DENSITY, desc_info->ampdu_density) |
+		    FIELD_PREP(BE_TXD_INFO2_FORCE_KEY_EN, desc_info->sec_en) |
+		    FIELD_PREP(BE_TXD_INFO2_SEC_CAM_IDX, desc_info->sec_cam_idx);
+
+	return cpu_to_le32(dword);
+}
+
+static __le32 rtw89_build_txwd_info4_v2(struct rtw89_tx_desc_info *desc_info)
+{
+	u32 dword = FIELD_PREP(BE_TXD_INFO4_RTS_EN, 1) |
+		    FIELD_PREP(BE_TXD_INFO4_HW_RTS_EN, 1);
+
+	return cpu_to_le32(dword);
+}
+
+void rtw89_core_fill_txdesc_v2(struct rtw89_dev *rtwdev,
+			       struct rtw89_tx_desc_info *desc_info,
+			       void *txdesc)
+{
+	struct rtw89_txwd_body_v2 *txwd_body = txdesc;
+	struct rtw89_txwd_info_v2 *txwd_info;
+
+	txwd_body->dword0 = rtw89_build_txwd_body0_v2(desc_info);
+	txwd_body->dword1 = rtw89_build_txwd_body1_v2(desc_info);
+	txwd_body->dword2 = rtw89_build_txwd_body2_v2(desc_info);
+	txwd_body->dword3 = rtw89_build_txwd_body3_v2(desc_info);
+	if (desc_info->sec_en) {
+		txwd_body->dword4 = rtw89_build_txwd_body4_v2(desc_info);
+		txwd_body->dword5 = rtw89_build_txwd_body5_v2(desc_info);
+	}
+	txwd_body->dword7 = rtw89_build_txwd_body7_v2(desc_info);
+
+	if (!desc_info->en_wd_info)
+		return;
+
+	txwd_info = (struct rtw89_txwd_info_v2 *)(txwd_body + 1);
+	txwd_info->dword0 = rtw89_build_txwd_info0_v2(desc_info);
+	txwd_info->dword1 = rtw89_build_txwd_info1_v2(desc_info);
+	txwd_info->dword2 = rtw89_build_txwd_info2_v2(desc_info);
+	txwd_info->dword4 = rtw89_build_txwd_info4_v2(desc_info);
+}
+EXPORT_SYMBOL(rtw89_core_fill_txdesc_v2);
+
 static __le32 rtw89_build_txwd_fwcmd0_v1(struct rtw89_tx_desc_info *desc_info)
 {
 	u32 dword = FIELD_PREP(AX_RXD_RPKT_LEN_MASK, desc_info->pkt_size) |
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 77a6a5856cc3..72327b67c4f3 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -948,6 +948,17 @@ struct rtw89_txwd_body_v1 {
 	__le32 dword7;
 } __packed;
 
+struct rtw89_txwd_body_v2 {
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
@@ -957,6 +968,17 @@ struct rtw89_txwd_info {
 	__le32 dword5;
 } __packed;
 
+struct rtw89_txwd_info_v2 {
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
 struct rtw89_rx_desc_info {
 	u16 pkt_size;
 	u8 pkt_type;
@@ -5463,6 +5485,9 @@ void rtw89_core_fill_txdesc(struct rtw89_dev *rtwdev,
 void rtw89_core_fill_txdesc_v1(struct rtw89_dev *rtwdev,
 			       struct rtw89_tx_desc_info *desc_info,
 			       void *txdesc);
+void rtw89_core_fill_txdesc_v2(struct rtw89_dev *rtwdev,
+			       struct rtw89_tx_desc_info *desc_info,
+			       void *txdesc);
 void rtw89_core_fill_txdesc_fwcmd_v1(struct rtw89_dev *rtwdev,
 				     struct rtw89_tx_desc_info *desc_info,
 				     void *txdesc);
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index f3204197bdaa..7142cce167de 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -137,6 +137,181 @@ static inline u8 rtw89_get_data_nss(struct rtw89_dev *rtwdev, u16 hw_rate)
 
 /* TX WD INFO DWORD 5 */
 
+/* TX WD BODY DWORD 0 */
+#define BE_TXD_BODY0_EN_HWSEQ_MODE GENMASK(1, 0)
+#define BE_TXD_BODY0_HW_SSN_SEL GENMASK(4, 2)
+#define BE_TXD_BODY0_HWAMSDU BIT(5)
+#define BE_TXD_BODY0_HW_SEC_IV BIT(6)
+#define BE_TXD_BODY0_WD_PAGE BIT(7)
+#define BE_TXD_BODY0_CHK_EN BIT(8)
+#define BE_TXD_BODY0_WP_INT BIT(9)
+#define BE_TXD_BODY0_STF_MODE BIT(10)
+#define BE_TXD_BODY0_HDR_LLC_LEN GENMASK(15, 11)
+#define BE_TXD_BODY0_CH_DMA GENMASK(19, 16)
+#define BE_TXD_BODY0_SMH_EN BIT(20)
+#define BE_TXD_BODY0_PKT_OFFSET BIT(21)
+#define BE_TXD_BODY0_WDINFO_EN BIT(22)
+#define BE_TXD_BODY0_MOREDATA BIT(23)
+#define BE_TXD_BODY0_WP_OFFSET_V1 GENMASK(27, 24)
+#define BE_TXD_BODY0_AZ_FTM_SEC_V1 BIT(28)
+#define BE_TXD_BODY0_WD_SOURCE GENMASK(30, 29)
+#define BE_TXD_BODY0_HCI_SEQNUM_MODE BIT(31)
+
+/* TX WD BODY DWORD 1 */
+#define BE_TXD_BODY1_DMA_TXAGG_NUM GENMASK(6, 0)
+#define BE_TXD_BODY1_REUSE_NUM GENMASK(11, 7)
+#define BE_TXD_BODY1_SEC_TYPE GENMASK(15, 12)
+#define BE_TXD_BODY1_SEC_KEYID GENMASK(17, 16)
+#define BE_TXD_BODY1_SW_SEC_IV BIT(18)
+#define BE_TXD_BODY1_REUSE_SIZE GENMASK(23, 20)
+#define BE_TXD_BODY1_REUSE_START_OFFSET GENMASK(25, 24)
+#define BE_TXD_BODY1_ADDR_INFO_NUM GENMASK(31, 26)
+
+/* TX WD BODY DWORD 2 */
+#define BE_TXD_BODY2_TXPKTSIZE GENMASK(13, 0)
+#define BE_TXD_BODY2_AGG_EN BIT(14)
+#define BE_TXD_BODY2_BK BIT(15)
+#define BE_TXD_BODY2_MACID_EXTEND BIT(16)
+#define BE_TXD_BODY2_QSEL GENMASK(22, 17)
+#define BE_TXD_BODY2_TID_IND BIT(23)
+#define BE_TXD_BODY2_MACID GENMASK(31, 24)
+
+/* TX WD BODY DWORD 3 */
+#define BE_TXD_BODY3_WIFI_SEQ GENMASK(11, 0)
+#define BE_TXD_BODY3_MLO_FLAG BIT(12)
+#define BE_TXD_BODY3_IS_MLD_SW_EN BIT(13)
+#define BE_TXD_BODY3_TRY_RATE BIT(14)
+#define BE_TXD_BODY3_RELINK_FLAG_V1 BIT(15)
+#define BE_TXD_BODY3_BAND0_SU_TC_V1 GENMASK(21, 16)
+#define BE_TXD_BODY3_TOTAL_TC GENMASK(27, 22)
+#define BE_TXD_BODY3_RU_RTY BIT(28)
+#define BE_TXD_BODY3_MU_PRI_RTY BIT(29)
+#define BE_TXD_BODY3_MU_2ND_RTY BIT(30)
+#define BE_TXD_BODY3_BAND1_SU_RTY_V1 BIT(31)
+
+/* TX WD BODY DWORD 4 */
+#define BE_TXD_BODY4_TXDESC_CHECKSUM GENMASK(15, 0)
+#define BE_TXD_BODY4_SEC_IV_L0 GENMASK(23, 16)
+#define BE_TXD_BODY4_SEC_IV_L1 GENMASK(31, 24)
+
+/* TX WD BODY DWORD 5 */
+#define BE_TXD_BODY5_SEC_IV_H2 GENMASK(7, 0)
+#define BE_TXD_BODY5_SEC_IV_H3 GENMASK(15, 8)
+#define BE_TXD_BODY5_SEC_IV_H4 GENMASK(23, 16)
+#define BE_TXD_BODY5_SEC_IV_H5 GENMASK(31, 24)
+
+/* TX WD BODY DWORD 6 */
+#define BE_TXD_BODY6_MU_TC GENMASK(4, 0)
+#define BE_TXD_BODY6_RU_TC GENMASK(9, 5)
+#define BE_TXD_BODY6_PS160 BIT(10)
+#define BE_TXD_BODY6_BMC BIT(11)
+#define BE_TXD_BODY6_NO_ACK BIT(12)
+#define BE_TXD_BODY6_UPD_WLAN_HDR BIT(13)
+#define BE_TXD_BODY6_A4_HDR BIT(14)
+#define BE_TXD_BODY6_EOSP_BIT BIT(15)
+#define BE_TXD_BODY6_S_IDX GENMASK(23, 16)
+#define BE_TXD_BODY6_RU_POS GENMASK(31, 24)
+
+/* TX WD BODY DWORD 7 */
+#define BE_TXD_BODY7_RTS_TC GENMASK(5, 0)
+#define BE_TXD_BODY7_MSDU_NUM GENMASK(9, 6)
+#define BE_TXD_BODY7_DATA_ER BIT(10)
+#define BE_TXD_BODY7_DATA_BW_ER BIT(11)
+#define BE_TXD_BODY7_DATA_DCM BIT(12)
+#define BE_TXD_BODY7_GI_LTF GENMASK(15, 13)
+#define BE_TXD_BODY7_DATARATE GENMASK(27, 16)
+#define BE_TXD_BODY7_DATA_BW GENMASK(30, 28)
+#define BE_TXD_BODY7_USERATE_SEL BIT(31)
+
+/* TX WD INFO DWORD 0 */
+#define BE_TXD_INFO0_MBSSID GENMASK(3, 0)
+#define BE_TXD_INFO0_MULTIPORT_ID GENMASK(6, 4)
+#define BE_TXD_INFO0_DISRTSFB BIT(9)
+#define BE_TXD_INFO0_DISDATAFB BIT(10)
+#define BE_TXD_INFO0_DATA_LDPC BIT(11)
+#define BE_TXD_INFO0_DATA_STBC BIT(12)
+#define BE_TXD_INFO0_DATA_TXCNT_LMT GENMASK(21, 16)
+#define BE_TXD_INFO0_DATA_TXCNT_LMT_SEL BIT(22)
+#define BE_TXD_INFO0_RESP_PHYSTS_CSI_EN_V1 BIT(23)
+#define BE_TXD_INFO0_RLS_TO_CPUIO BIT(30)
+#define BE_TXD_INFO0_ACK_CH_INFO BIT(31)
+
+/* TX WD INFO DWORD 1 */
+#define BE_TXD_INFO1_MAX_AGG_NUM GENMASK(7, 0)
+#define BE_TXD_INFO1_BCN_SRCH_SEQ GENMASK(9, 8)
+#define BE_TXD_INFO1_NAVUSEHDR BIT(10)
+#define BE_TXD_INFO1_A_CTRL_BQR BIT(12)
+#define BE_TXD_INFO1_A_CTRL_BSR BIT(14)
+#define BE_TXD_INFO1_A_CTRL_CAS BIT(15)
+#define BE_TXD_INFO1_DATA_RTY_LOWEST_RATE GENMASK(27, 16)
+#define BE_TXD_INFO1_SW_DEFINE GENMASK(31, 28)
+
+/* TX WD INFO DWORD 2 */
+#define BE_TXD_INFO2_SEC_CAM_IDX GENMASK(7, 0)
+#define BE_TXD_INFO2_FORCE_KEY_EN BIT(8)
+#define BE_TXD_INFO2_LIFETIME_SEL GENMASK(15, 13)
+#define BE_TXD_INFO2_FORCE_TXOP BIT(17)
+#define BE_TXD_INFO2_AMPDU_DENSITY GENMASK(20, 18)
+#define BE_TXD_INFO2_LSIG_TXOP_EN BIT(21)
+#define BE_TXD_INFO2_OBW_CTS2SELF_DUP_TYPE GENMASK(29, 26)
+#define BE_TXD_INFO2_SPE_RPT_V1 BIT(30)
+#define BE_TXD_INFO2_SIFS_TX_V1 BIT(31)
+
+/* TX WD INFO DWORD 3 */
+#define BE_TXD_INFO3_SPE_PKT GENMASK(3, 0)
+#define BE_TXD_INFO3_SPE_PKT_TYPE GENMASK(7, 4)
+#define BE_TXD_INFO3_CQI_SND BIT(8)
+#define BE_TXD_INFO3_RTT_EN BIT(9)
+#define BE_TXD_INFO3_HT_DATA_SND_V1 BIT(10)
+#define BE_TXD_INFO3_BT_NULL BIT(11)
+#define BE_TXD_INFO3_TRI_FRAME BIT(12)
+#define BE_TXD_INFO3_NULL_0 BIT(13)
+#define BE_TXD_INFO3_NULL_1 BIT(14)
+#define BE_TXD_INFO3_RAW BIT(15)
+#define BE_TXD_INFO3_GROUP_BIT_IE_OFFSET GENMASK(23, 16)
+#define BE_TXD_INFO3_SIGNALING_TA_PKT_EN BIT(25)
+#define BE_TXD_INFO3_BCNPKT_TSF_CTRL BIT(26)
+#define BE_TXD_INFO3_SIGNALING_TA_PKT_SC GENMASK(30, 27)
+#define BE_TXD_INFO3_FORCE_BSS_CLR BIT(31)
+
+/* TX WD INFO DWORD 4 */
+#define BE_TXD_INFO4_PUNCTURE_PATTERN GENMASK(15, 0)
+#define BE_TXD_INFO4_PUNC_MODE GENMASK(17, 16)
+#define BE_TXD_INFO4_SW_TX_OK_0 BIT(18)
+#define BE_TXD_INFO4_SW_TX_OK_1 BIT(19)
+#define BE_TXD_INFO4_SW_TX_PWR_DBM GENMASK(26, 23)
+#define BE_TXD_INFO4_RTS_EN BIT(27)
+#define BE_TXD_INFO4_CTS2SELF BIT(28)
+#define BE_TXD_INFO4_CCA_RTS GENMASK(30, 29)
+#define BE_TXD_INFO4_HW_RTS_EN BIT(31)
+
+/* TX WD INFO DWORD 5 */
+#define BE_TXD_INFO5_SR_RATE_V1 GENMASK(4, 0)
+#define BE_TXD_INFO5_SR_EN_V1 BIT(5)
+#define BE_TXD_INFO5_NDPA_DURATION GENMASK(31, 16)
+
+/* TX WD INFO DWORD 6 */
+#define BE_TXD_INFO6_UL_APEP_LEN GENMASK(11, 0)
+#define BE_TXD_INFO6_UL_GI_LTF GENMASK(14, 12)
+#define BE_TXD_INFO6_UL_DOPPLER BIT(15)
+#define BE_TXD_INFO6_UL_STBC BIT(16)
+#define BE_TXD_INFO6_UL_LENGTH_REF GENMASK(21, 18)
+#define BE_TXD_INFO6_UL_RF_GAIN_IDX GENMASK(31, 22)
+
+/* TX WD INFO DWORD 7 */
+#define BE_TXD_INFO7_UL_FIXED_GAIN_EN BIT(0)
+#define BE_TXD_INFO7_UL_PRI_EXP_RSSI_DBM GENMASK(7, 1)
+#define BE_TXD_INFO7_ELNA_IDX BIT(8)
+#define BE_TXD_INFO7_UL_APEP_UNIT GENMASK(10, 9)
+#define BE_TXD_INFO7_UL_TRI_PAD GENMASK(13, 11)
+#define BE_TXD_INFO7_UL_T_PE GENMASK(15, 14)
+#define BE_TXD_INFO7_UL_EHT_USR_PRES BIT(16)
+#define BE_TXD_INFO7_UL_HELTF_SYMBOL_NUM GENMASK(19, 17)
+#define BE_TXD_INFO7_ULBW GENMASK(21, 20)
+#define BE_TXD_INFO7_ULBW_EXT GENMASK(23, 22)
+#define BE_TXD_INFO7_USE_WD_UL GENMASK(25, 24)
+#define BE_TXD_INFO7_EXTEND_MODE_SEL GENMASK(31, 28)
+
 /* RX WD dword0 */
 #define AX_RXD_RPKT_LEN_MASK GENMASK(13, 0)
 #define AX_RXD_SHIFT_MASK GENMASK(15, 14)
-- 
2.25.1

