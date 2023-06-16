Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D497331B3
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 14:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345501AbjFPM4f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 08:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345492AbjFPM4e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 08:56:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085D430FE
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:56:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35GCtwHsB024334, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35GCtwHsB024334
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 20:55:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 16 Jun 2023 20:56:17 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 20:56:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/6] wifi: rtw88: use struct instead of macros to set TX desc
Date:   Fri, 16 Jun 2023 20:55:35 +0800
Message-ID: <20230616125540.36877-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230616125540.36877-1-pkshih@realtek.com>
References: <20230616125540.36877-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.227]
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

From: Po-Hao Huang <phhuang@realtek.com>

Remove macros that set TX descriptors. Use struct and
le32_encode_bits() with mask definitions.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
    * correct to use RTW_TX_DESC_W7_DMA_TXAGG_NUM to set agg_num
    * use correct le32p_replace_bits() to set value instead
---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |   6 +-
 drivers/net/wireless/realtek/rtw88/tx.c       |  79 +++++++-----
 drivers/net/wireless/realtek/rtw88/tx.h       | 122 +++++++-----------
 drivers/net/wireless/realtek/rtw88/usb.c      |  12 +-
 4 files changed, 106 insertions(+), 113 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index cadf66f4e8545..c575476a00207 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -1970,15 +1970,17 @@ static void rtw8723d_fill_txdesc_checksum(struct rtw_dev *rtwdev,
 	size_t words = 32 / 2; /* calculate the first 32 bytes (16 words) */
 	__le16 chksum = 0;
 	__le16 *data = (__le16 *)(txdesc);
+	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)txdesc;
 
-	SET_TX_DESC_TXDESC_CHECKSUM(txdesc, 0x0000);
+	le32p_replace_bits(&tx_desc->w7, 0, RTW_TX_DESC_W7_TXDESC_CHECKSUM);
 
 	while (words--)
 		chksum ^= *data++;
 
 	chksum = ~chksum;
 
-	SET_TX_DESC_TXDESC_CHECKSUM(txdesc, __le16_to_cpu(chksum));
+	le32p_replace_bits(&tx_desc->w7, __le16_to_cpu(chksum),
+			   RTW_TX_DESC_W7_TXDESC_CHECKSUM);
 }
 
 static struct rtw_chip_ops rtw8723d_ops = {
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index bb5c7492c98b0..edf351102f6a9 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -34,43 +34,52 @@ void rtw_tx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 
 void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 {
-	__le32 *txdesc = (__le32 *)skb->data;
-
-	SET_TX_DESC_TXPKTSIZE(txdesc,  pkt_info->tx_pkt_size);
-	SET_TX_DESC_OFFSET(txdesc, pkt_info->offset);
-	SET_TX_DESC_PKT_OFFSET(txdesc, pkt_info->pkt_offset);
-	SET_TX_DESC_QSEL(txdesc, pkt_info->qsel);
-	SET_TX_DESC_BMC(txdesc, pkt_info->bmc);
-	SET_TX_DESC_RATE_ID(txdesc, pkt_info->rate_id);
-	SET_TX_DESC_DATARATE(txdesc, pkt_info->rate);
-	SET_TX_DESC_DISDATAFB(txdesc, pkt_info->dis_rate_fallback);
-	SET_TX_DESC_USE_RATE(txdesc, pkt_info->use_rate);
-	SET_TX_DESC_SEC_TYPE(txdesc, pkt_info->sec_type);
-	SET_TX_DESC_DATA_BW(txdesc, pkt_info->bw);
-	SET_TX_DESC_SW_SEQ(txdesc, pkt_info->seq);
-	SET_TX_DESC_MAX_AGG_NUM(txdesc, pkt_info->ampdu_factor);
-	SET_TX_DESC_AMPDU_DENSITY(txdesc, pkt_info->ampdu_density);
-	SET_TX_DESC_DATA_STBC(txdesc, pkt_info->stbc);
-	SET_TX_DESC_DATA_LDPC(txdesc, pkt_info->ldpc);
-	SET_TX_DESC_AGG_EN(txdesc, pkt_info->ampdu_en);
-	SET_TX_DESC_LS(txdesc, pkt_info->ls);
-	SET_TX_DESC_DATA_SHORT(txdesc, pkt_info->short_gi);
-	SET_TX_DESC_SPE_RPT(txdesc, pkt_info->report);
-	SET_TX_DESC_SW_DEFINE(txdesc, pkt_info->sn);
-	SET_TX_DESC_USE_RTS(txdesc, pkt_info->rts);
+	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)skb->data;
+
+	tx_desc->w0 = le32_encode_bits(pkt_info->tx_pkt_size, RTW_TX_DESC_W0_TXPKTSIZE) |
+		      le32_encode_bits(pkt_info->offset, RTW_TX_DESC_W0_OFFSET) |
+		      le32_encode_bits(pkt_info->bmc, RTW_TX_DESC_W0_BMC) |
+		      le32_encode_bits(pkt_info->ls, RTW_TX_DESC_W0_LS) |
+		      le32_encode_bits(pkt_info->dis_qselseq, RTW_TX_DESC_W0_DISQSELSEQ);
+
+	tx_desc->w1 = le32_encode_bits(pkt_info->qsel, RTW_TX_DESC_W1_QSEL) |
+		      le32_encode_bits(pkt_info->rate_id, RTW_TX_DESC_W1_RATE_ID) |
+		      le32_encode_bits(pkt_info->sec_type, RTW_TX_DESC_W1_SEC_TYPE) |
+		      le32_encode_bits(pkt_info->pkt_offset, RTW_TX_DESC_W1_PKT_OFFSET);
+
+	tx_desc->w2 = le32_encode_bits(pkt_info->ampdu_en, RTW_TX_DESC_W2_AGG_EN) |
+		      le32_encode_bits(pkt_info->report, RTW_TX_DESC_W2_SPE_RPT) |
+		      le32_encode_bits(pkt_info->ampdu_density, RTW_TX_DESC_W2_AMPDU_DEN) |
+		      le32_encode_bits(pkt_info->bt_null, RTW_TX_DESC_W2_BT_NULL);
+
+	tx_desc->w3 = le32_encode_bits(pkt_info->hw_ssn_sel, RTW_TX_DESC_W3_HW_SSN_SEL) |
+		      le32_encode_bits(pkt_info->use_rate, RTW_TX_DESC_W3_USE_RATE) |
+		      le32_encode_bits(pkt_info->dis_rate_fallback, RTW_TX_DESC_W3_DISDATAFB) |
+		      le32_encode_bits(pkt_info->rts, RTW_TX_DESC_W3_USE_RTS) |
+		      le32_encode_bits(pkt_info->nav_use_hdr, RTW_TX_DESC_W3_NAVUSEHDR) |
+		      le32_encode_bits(pkt_info->ampdu_factor, RTW_TX_DESC_W3_MAX_AGG_NUM);
+
+	tx_desc->w4 = le32_encode_bits(pkt_info->rate, RTW_TX_DESC_W4_DATARATE);
+
+	tx_desc->w5 = le32_encode_bits(pkt_info->short_gi, RTW_TX_DESC_W5_DATA_SHORT) |
+		      le32_encode_bits(pkt_info->bw, RTW_TX_DESC_W5_DATA_BW) |
+		      le32_encode_bits(pkt_info->ldpc, RTW_TX_DESC_W5_DATA_LDPC) |
+		      le32_encode_bits(pkt_info->stbc, RTW_TX_DESC_W5_DATA_STBC);
+
+	tx_desc->w6 = le32_encode_bits(pkt_info->sn, RTW_TX_DESC_W6_SW_DEFINE);
+
+	tx_desc->w8 = le32_encode_bits(pkt_info->en_hwseq, RTW_TX_DESC_W8_EN_HWSEQ);
+
+	tx_desc->w9 = le32_encode_bits(pkt_info->seq, RTW_TX_DESC_W9_SW_SEQ);
+
 	if (pkt_info->rts) {
-		SET_TX_DESC_RTSRATE(txdesc, DESC_RATE24M);
-		SET_TX_DESC_DATA_RTS_SHORT(txdesc, 1);
-	}
-	SET_TX_DESC_DISQSELSEQ(txdesc, pkt_info->dis_qselseq);
-	SET_TX_DESC_EN_HWSEQ(txdesc, pkt_info->en_hwseq);
-	SET_TX_DESC_HW_SSN_SEL(txdesc, pkt_info->hw_ssn_sel);
-	SET_TX_DESC_NAVUSEHDR(txdesc, pkt_info->nav_use_hdr);
-	SET_TX_DESC_BT_NULL(txdesc, pkt_info->bt_null);
-	if (pkt_info->tim_offset) {
-		SET_TX_DESC_TIM_EN(txdesc, 1);
-		SET_TX_DESC_TIM_OFFSET(txdesc, pkt_info->tim_offset);
+		tx_desc->w4 |= le32_encode_bits(DESC_RATE24M, RTW_TX_DESC_W4_RTSRATE);
+		tx_desc->w5 |= le32_encode_bits(1, RTW_TX_DESC_W5_DATA_RTS_SHORT);
 	}
+
+	if (pkt_info->tim_offset)
+		tx_desc->w9 |= le32_encode_bits(1, RTW_TX_DESC_W9_TIM_EN) |
+			       le32_encode_bits(pkt_info->tim_offset, RTW_TX_DESC_W9_TIM_OFFSET);
 }
 EXPORT_SYMBOL(rtw_tx_fill_tx_desc);
 
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 197d5868c8ad9..607c51b90dad1 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -9,76 +9,52 @@
 
 #define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
 
-#define SET_TX_DESC_TXPKTSIZE(txdesc, value)                                   \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, GENMASK(15, 0))
-#define SET_TX_DESC_OFFSET(txdesc, value)                                      \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, GENMASK(23, 16))
-#define SET_TX_DESC_PKT_OFFSET(txdesc, value)                                  \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x01, value, GENMASK(28, 24))
-#define SET_TX_DESC_QSEL(txdesc, value)                                        \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x01, value, GENMASK(12, 8))
-#define SET_TX_DESC_BMC(txdesc, value)                                         \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, BIT(24))
-#define SET_TX_DESC_RATE_ID(txdesc, value)                                     \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x01, value, GENMASK(20, 16))
-#define SET_TX_DESC_DATARATE(txdesc, value)                                    \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x04, value, GENMASK(6, 0))
-#define SET_TX_DESC_DISDATAFB(txdesc, value)                                   \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(10))
-#define SET_TX_DESC_USE_RATE(txdesc, value)                                    \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(8))
-#define SET_TX_DESC_SEC_TYPE(txdesc, value)                                    \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x01, value, GENMASK(23, 22))
-#define SET_TX_DESC_DATA_BW(txdesc, value)                                     \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, GENMASK(6, 5))
-#define SET_TX_DESC_SW_SEQ(txdesc, value)                                      \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, GENMASK(23, 12))
-#define SET_TX_DESC_TIM_EN(txdesc, value)                                      \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, BIT(7))
-#define SET_TX_DESC_TIM_OFFSET(txdesc, value)                                  \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x09, value, GENMASK(6, 0))
-#define SET_TX_DESC_MAX_AGG_NUM(txdesc, value)                                 \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(21, 17))
-#define SET_TX_DESC_USE_RTS(tx_desc, value)                                    \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(12))
-#define SET_TX_DESC_RTSRATE(txdesc, value)                                     \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x04, value, GENMASK(28, 24))
-#define SET_TX_DESC_DATA_RTS_SHORT(txdesc, value)                              \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, BIT(12))
-#define SET_TX_DESC_AMPDU_DENSITY(txdesc, value)                               \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, GENMASK(22, 20))
-#define SET_TX_DESC_DATA_STBC(txdesc, value)                                   \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, GENMASK(9, 8))
-#define SET_TX_DESC_DATA_LDPC(txdesc, value)                                   \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, BIT(7))
-#define SET_TX_DESC_AGG_EN(txdesc, value)                                      \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, BIT(12))
-#define SET_TX_DESC_LS(txdesc, value)                                          \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, BIT(26))
-#define SET_TX_DESC_DATA_SHORT(txdesc, value)				       \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x05, value, BIT(4))
-#define SET_TX_DESC_SPE_RPT(tx_desc, value)                                    \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, BIT(19))
-#define SET_TX_DESC_SW_DEFINE(tx_desc, value)                                  \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x06, value, GENMASK(11, 0))
-#define SET_TX_DESC_DISQSELSEQ(txdesc, value)                                 \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x00, value, BIT(31))
-#define SET_TX_DESC_EN_HWSEQ(txdesc, value)                                   \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x08, value, BIT(15))
-#define SET_TX_DESC_HW_SSN_SEL(txdesc, value)                                 \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(7, 6))
-#define SET_TX_DESC_NAVUSEHDR(txdesc, value)				       \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(15))
-#define SET_TX_DESC_BT_NULL(txdesc, value)				       \
-	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, BIT(23))
-#define SET_TX_DESC_TXDESC_CHECKSUM(txdesc, value)				\
-	le32p_replace_bits((__le32 *)(txdesc) + 0x07, value, GENMASK(15, 0))
-#define SET_TX_DESC_DMA_TXAGG_NUM(txdesc, value)				\
-	le32p_replace_bits((__le32 *)(txdesc) + 0x07, value, GENMASK(31, 24))
-#define GET_TX_DESC_PKT_OFFSET(txdesc)						\
-	le32_get_bits(*((__le32 *)(txdesc) + 0x01), GENMASK(28, 24))
-#define GET_TX_DESC_QSEL(txdesc)						\
-	le32_get_bits(*((__le32 *)(txdesc) + 0x01), GENMASK(12, 8))
+struct rtw_tx_desc {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+} __packed;
+
+#define RTW_TX_DESC_W0_TXPKTSIZE GENMASK(15, 0)
+#define RTW_TX_DESC_W0_OFFSET GENMASK(23, 16)
+#define RTW_TX_DESC_W0_BMC BIT(24)
+#define RTW_TX_DESC_W0_LS BIT(26)
+#define RTW_TX_DESC_W0_DISQSELSEQ BIT(31)
+#define RTW_TX_DESC_W1_QSEL GENMASK(12, 8)
+#define RTW_TX_DESC_W1_RATE_ID GENMASK(20, 16)
+#define RTW_TX_DESC_W1_SEC_TYPE GENMASK(23, 22)
+#define RTW_TX_DESC_W1_PKT_OFFSET GENMASK(28, 24)
+#define RTW_TX_DESC_W2_AGG_EN BIT(12)
+#define RTW_TX_DESC_W2_SPE_RPT BIT(19)
+#define RTW_TX_DESC_W2_AMPDU_DEN GENMASK(22, 20)
+#define RTW_TX_DESC_W2_BT_NULL BIT(23)
+#define RTW_TX_DESC_W3_HW_SSN_SEL GENMASK(7, 6)
+#define RTW_TX_DESC_W3_USE_RATE BIT(8)
+#define RTW_TX_DESC_W3_DISDATAFB BIT(10)
+#define RTW_TX_DESC_W3_USE_RTS BIT(12)
+#define RTW_TX_DESC_W3_NAVUSEHDR BIT(15)
+#define RTW_TX_DESC_W3_MAX_AGG_NUM GENMASK(21, 17)
+#define RTW_TX_DESC_W4_DATARATE GENMASK(6, 0)
+#define RTW_TX_DESC_W4_RTSRATE GENMASK(28, 24)
+#define RTW_TX_DESC_W5_DATA_SHORT BIT(4)
+#define RTW_TX_DESC_W5_DATA_BW GENMASK(6, 5)
+#define RTW_TX_DESC_W5_DATA_LDPC BIT(7)
+#define RTW_TX_DESC_W5_DATA_STBC GENMASK(9, 8)
+#define RTW_TX_DESC_W5_DATA_RTS_SHORT BIT(12)
+#define RTW_TX_DESC_W6_SW_DEFINE GENMASK(11, 0)
+#define RTW_TX_DESC_W7_TXDESC_CHECKSUM GENMASK(15, 0)
+#define RTW_TX_DESC_W7_DMA_TXAGG_NUM GENMASK(31, 24)
+#define RTW_TX_DESC_W8_EN_HWSEQ BIT(15)
+#define RTW_TX_DESC_W9_SW_SEQ GENMASK(23, 12)
+#define RTW_TX_DESC_W9_TIM_EN BIT(7)
+#define RTW_TX_DESC_W9_TIM_OFFSET GENMASK(6, 0)
 
 enum rtw_tx_desc_queue_select {
 	TX_DESC_QSEL_TID0	= 0,
@@ -139,13 +115,15 @@ void fill_txdesc_checksum_common(u8 *txdesc, size_t words)
 {
 	__le16 chksum = 0;
 	__le16 *data = (__le16 *)(txdesc);
+	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)txdesc;
 
-	SET_TX_DESC_TXDESC_CHECKSUM(txdesc, 0x0000);
+	le32p_replace_bits(&tx_desc->w7, 0, RTW_TX_DESC_W7_TXDESC_CHECKSUM);
 
 	while (words--)
 		chksum ^= *data++;
 
-	SET_TX_DESC_TXDESC_CHECKSUM(txdesc, __le16_to_cpu(chksum));
+	le32p_replace_bits(&tx_desc->w7, __le16_to_cpu(chksum),
+			   RTW_TX_DESC_W7_TXDESC_CHECKSUM);
 }
 
 static inline void rtw_tx_fill_txdesc_checksum(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 976eafa739a2d..0529ae24f53b0 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -24,11 +24,12 @@ struct rtw_usb_txcb {
 static void rtw_usb_fill_tx_checksum(struct rtw_usb *rtwusb,
 				     struct sk_buff *skb, int agg_num)
 {
+	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)skb->data;
 	struct rtw_dev *rtwdev = rtwusb->rtwdev;
 	struct rtw_tx_pkt_info pkt_info;
 
-	SET_TX_DESC_DMA_TXAGG_NUM(skb->data, agg_num);
-	pkt_info.pkt_offset = GET_TX_DESC_PKT_OFFSET(skb->data);
+	le32p_replace_bits(&tx_desc->w7, agg_num, RTW_TX_DESC_W7_DMA_TXAGG_NUM);
+	pkt_info.pkt_offset = le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_PKT_OFFSET);
 	rtw_tx_fill_txdesc_checksum(rtwdev, &pkt_info, skb->data);
 }
 
@@ -306,11 +307,13 @@ static int rtw_usb_write_port(struct rtw_dev *rtwdev, u8 qsel, struct sk_buff *s
 static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb, struct sk_buff_head *list)
 {
 	struct rtw_dev *rtwdev = rtwusb->rtwdev;
+	struct rtw_tx_desc *tx_desc;
 	struct rtw_usb_txcb *txcb;
 	struct sk_buff *skb_head;
 	struct sk_buff *skb_iter;
 	int agg_num = 0;
 	unsigned int align_next = 0;
+	u8 qsel;
 
 	if (skb_queue_empty(list))
 		return false;
@@ -363,9 +366,10 @@ static bool rtw_usb_tx_agg_skb(struct rtw_usb *rtwusb, struct sk_buff_head *list
 
 queue:
 	skb_queue_tail(&txcb->tx_ack_queue, skb_head);
+	tx_desc = (struct rtw_tx_desc *)skb_head->data;
+	qsel = le32_get_bits(tx_desc->w1, RTW_TX_DESC_W1_QSEL);
 
-	rtw_usb_write_port(rtwdev, GET_TX_DESC_QSEL(skb_head->data), skb_head,
-			   rtw_usb_write_port_tx_complete, txcb);
+	rtw_usb_write_port(rtwdev, qsel, skb_head, rtw_usb_write_port_tx_complete, txcb);
 
 	return true;
 }
-- 
2.25.1

