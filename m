Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA379A5F1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Sep 2023 10:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjIKIWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Sep 2023 04:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbjIKIWz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Sep 2023 04:22:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3035EB
        for <linux-wireless@vger.kernel.org>; Mon, 11 Sep 2023 01:22:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 38B8MfAxA1003652, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 38B8MfAxA1003652
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 16:22:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 11 Sep 2023 16:22:00 +0800
Received: from [127.0.1.1] (172.21.69.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Sep
 2023 16:22:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: add to query RX descriptor format v2
Date:   Mon, 11 Sep 2023 16:20:44 +0800
Message-ID: <20230911082049.33541-2-pkshih@realtek.com>
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

RX descriptor is used to provide meta data of received data. The WiFi 7
chips use different RX descriptor format, so add this parser along with
hardware design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 65 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 27 +++++++
 drivers/net/wireless/realtek/rtw89/txrx.h | 96 +++++++++++++++++++++++
 3 files changed, 188 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 856f3543eff2..127e5b2f72be 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1875,6 +1875,71 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_core_query_rxdesc);
 
+void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_desc_info *desc_info,
+				u8 *data, u32 data_offset)
+{
+	struct rtw89_rxdesc_short_v2 *rxd_s;
+	struct rtw89_rxdesc_long_v2 *rxd_l;
+	u16 shift_len, drv_info_len, phy_rtp_len, hdr_cnv_len;
+
+	rxd_s = (struct rtw89_rxdesc_short_v2 *)(data + data_offset);
+
+	desc_info->pkt_size = le32_get_bits(rxd_s->dword0, BE_RXD_RPKT_LEN_MASK);
+	desc_info->drv_info_size = le32_get_bits(rxd_s->dword0, BE_RXD_DRV_INFO_SZ_MASK);
+	desc_info->phy_rpt_size = le32_get_bits(rxd_s->dword0, BE_RXD_PHY_RPT_SZ_MASK);
+	desc_info->hdr_cnv_size = le32_get_bits(rxd_s->dword0, BE_RXD_HDR_CNV_SZ_MASK);
+	desc_info->shift = le32_get_bits(rxd_s->dword0, BE_RXD_SHIFT_MASK);
+	desc_info->long_rxdesc = le32_get_bits(rxd_s->dword0, BE_RXD_LONG_RXD);
+	desc_info->pkt_type = le32_get_bits(rxd_s->dword0, BE_RXD_RPKT_TYPE_MASK);
+	if (desc_info->pkt_type == RTW89_CORE_RX_TYPE_PPDU_STAT)
+		desc_info->mac_info_valid = true;
+
+	desc_info->frame_type = le32_get_bits(rxd_s->dword2, BE_RXD_TYPE_MASK);
+	desc_info->mac_id = le32_get_bits(rxd_s->dword2, BE_RXD_MAC_ID_MASK);
+	desc_info->addr_cam_valid = le32_get_bits(rxd_s->dword2, BE_RXD_ADDR_CAM_VLD);
+
+	desc_info->icv_err = le32_get_bits(rxd_s->dword3, BE_RXD_ICV_ERR);
+	desc_info->crc32_err = le32_get_bits(rxd_s->dword3, BE_RXD_CRC32_ERR);
+	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_HW_DEC);
+	desc_info->sw_dec = le32_get_bits(rxd_s->dword3, BE_RXD_SW_DEC);
+	desc_info->addr1_match = le32_get_bits(rxd_s->dword3, BE_RXD_A1_MATCH);
+
+	desc_info->bw = le32_get_bits(rxd_s->dword4, BE_RXD_BW_MASK);
+	desc_info->data_rate = le32_get_bits(rxd_s->dword4, BE_RXD_RX_DATARATE_MASK);
+	desc_info->gi_ltf = le32_get_bits(rxd_s->dword4, BE_RXD_RX_GI_LTF_MASK);
+	desc_info->ppdu_cnt = le32_get_bits(rxd_s->dword4, BE_RXD_PPDU_CNT_MASK);
+	desc_info->ppdu_type = le32_get_bits(rxd_s->dword4, BE_RXD_PPDU_TYPE_MASK);
+
+	desc_info->free_run_cnt = le32_to_cpu(rxd_s->dword5);
+
+	shift_len = desc_info->shift << 1; /* 2-byte unit */
+	drv_info_len = desc_info->drv_info_size << 3; /* 8-byte unit */
+	phy_rtp_len = desc_info->phy_rpt_size << 3; /* 8-byte unit */
+	hdr_cnv_len = desc_info->hdr_cnv_size << 4; /* 16-byte unit */
+	desc_info->offset = data_offset + shift_len + drv_info_len +
+			    phy_rtp_len + hdr_cnv_len;
+
+	if (desc_info->long_rxdesc)
+		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_long_v2);
+	else
+		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_short_v2);
+	desc_info->ready = true;
+
+	if (!desc_info->long_rxdesc)
+		return;
+
+	rxd_l = (struct rtw89_rxdesc_long_v2 *)(data + data_offset);
+
+	desc_info->sr_en = le32_get_bits(rxd_l->dword6, BE_RXD_SR_EN);
+	desc_info->user_id = le32_get_bits(rxd_l->dword6, BE_RXD_USER_ID_MASK);
+	desc_info->addr_cam_id = le32_get_bits(rxd_l->dword6, BE_RXD_ADDR_CAM_MASK);
+	desc_info->sec_cam_id = le32_get_bits(rxd_l->dword6, BE_RXD_SEC_CAM_IDX_MASK);
+
+	desc_info->rx_pl_id = le32_get_bits(rxd_l->dword7, BE_RXD_RX_PL_ID_MASK);
+}
+EXPORT_SYMBOL(rtw89_core_query_rxdesc_v2);
+
 struct rtw89_core_iter_rx_status {
 	struct rtw89_dev *rtwdev;
 	struct ieee80211_rx_status *rx_status;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2eaf1df205ec..afdac66745e5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -961,6 +961,8 @@ struct rtw89_rx_desc_info {
 	u16 pkt_size;
 	u8 pkt_type;
 	u8 drv_info_size;
+	u8 phy_rpt_size;
+	u8 hdr_cnv_size;
 	u8 shift;
 	u8 wl_hd_iv_len;
 	bool long_rxdesc;
@@ -999,6 +1001,15 @@ struct rtw89_rxdesc_short {
 	__le32 dword3;
 } __packed;
 
+struct rtw89_rxdesc_short_v2 {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+} __packed;
+
 struct rtw89_rxdesc_long {
 	__le32 dword0;
 	__le32 dword1;
@@ -1010,6 +1021,19 @@ struct rtw89_rxdesc_long {
 	__le32 dword7;
 } __packed;
 
+struct rtw89_rxdesc_long_v2 {
+	__le32 dword0;
+	__le32 dword1;
+	__le32 dword2;
+	__le32 dword3;
+	__le32 dword4;
+	__le32 dword5;
+	__le32 dword6;
+	__le32 dword7;
+	__le32 dword8;
+	__le32 dword9;
+} __packed;
+
 struct rtw89_tx_desc_info {
 	u16 pkt_size;
 	u8 wp_offset;
@@ -5448,6 +5472,9 @@ void rtw89_core_rx(struct rtw89_dev *rtwdev,
 void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 			     struct rtw89_rx_desc_info *desc_info,
 			     u8 *data, u32 data_offset);
+void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_desc_info *desc_info,
+				u8 *data, u32 data_offset);
 void rtw89_core_napi_start(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_stop(struct rtw89_dev *rtwdev);
 void rtw89_core_napi_init(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 02cff0f7d86b..f3204197bdaa 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -269,6 +269,102 @@ struct rtw89_phy_sts_iehdr {
 #define RTW89_PHY_STS_IEHDR_TYPE GENMASK(4, 0)
 #define RTW89_PHY_STS_IEHDR_LEN GENMASK(11, 5)
 
+/* BE RXD dword0 */
+#define BE_RXD_RPKT_LEN_MASK GENMASK(13, 0)
+#define BE_RXD_SHIFT_MASK GENMASK(15, 14)
+#define BE_RXD_DRV_INFO_SZ_MASK GENMASK(19, 18)
+#define BE_RXD_HDR_CNV_SZ_MASK GENMASK(21, 20)
+#define BE_RXD_PHY_RPT_SZ_MASK GENMASK(23, 22)
+#define BE_RXD_RPKT_TYPE_MASK GENMASK(29, 24)
+#define BE_RXD_BB_SEL BIT(30)
+#define BE_RXD_LONG_RXD BIT(31)
+
+/* BE RXD dword1 */
+#define BE_RXD_PKT_ID_MASK GENMASK(11, 0)
+#define BE_RXD_FWD_TARGET_MASK GENMASK(23, 16)
+#define BE_RXD_BCN_FW_INFO_MASK GENMASK(25, 24)
+#define BE_RXD_FW_RLS BIT(26)
+
+/* BE RXD dword2 */
+#define BE_RXD_MAC_ID_MASK GENMASK(7, 0)
+#define BE_RXD_TYPE_MASK GENMASK(11, 10)
+#define BE_RXD_LAST_MSDU BIT(12)
+#define BE_RXD_AMSDU_CUT BIT(13)
+#define BE_RXD_ADDR_CAM_VLD BIT(14)
+#define BE_RXD_REORDER BIT(15)
+#define BE_RXD_SEQ_MASK GENMASK(27, 16)
+#define BE_RXD_TID_MASK GENMASK(31, 28)
+
+/* BE RXD dword3 */
+#define BE_RXD_SEC_TYPE_MASK GENMASK(3, 0)
+#define BE_RXD_BIP_KEYID BIT(4)
+#define BE_RXD_BIP_ENC BIT(5)
+#define BE_RXD_CRC32_ERR BIT(6)
+#define BE_RXD_ICV_ERR BIT(7)
+#define BE_RXD_HW_DEC BIT(8)
+#define BE_RXD_SW_DEC BIT(9)
+#define BE_RXD_A1_MATCH BIT(10)
+#define BE_RXD_AMPDU BIT(11)
+#define BE_RXD_AMPDU_EOF BIT(12)
+#define BE_RXD_AMSDU BIT(13)
+#define BE_RXD_MC BIT(14)
+#define BE_RXD_BC BIT(15)
+#define BE_RXD_MD BIT(16)
+#define BE_RXD_MF BIT(17)
+#define BE_RXD_PWR BIT(18)
+#define BE_RXD_QOS BIT(19)
+#define BE_RXD_EOSP BIT(20)
+#define BE_RXD_HTC BIT(21)
+#define BE_RXD_QNULL BIT(22)
+#define BE_RXD_A4_FRAME BIT(23)
+#define BE_RXD_FRAG_MASK GENMASK(27, 24)
+#define BE_RXD_GET_CH_INFO_V1_MASK GENMASK(31, 30)
+
+/* BE RXD dword4 */
+#define BE_RXD_PPDU_TYPE_MASK GENMASK(7, 0)
+#define BE_RXD_PPDU_CNT_MASK GENMASK(10, 8)
+#define BE_RXD_BW_MASK GENMASK(14, 12)
+#define BE_RXD_RX_GI_LTF_MASK GENMASK(18, 16)
+#define BE_RXD_RX_REORDER_FIELD_EN BIT(19)
+#define BE_RXD_RX_DATARATE_MASK GENMASK(31, 20)
+
+/* BE RXD dword5 */
+#define BE_RXD_FREERUN_CNT_MASK GENMASK(31, 0)
+
+/* BE RXD dword6 */
+#define BE_RXD_ADDR_CAM_MASK GENMASK(7, 0)
+#define BE_RXD_SR_EN BIT(13)
+#define BE_RXD_NON_SRG_PPDU BIT(14)
+#define BE_RXD_INTER_PPDU BIT(15)
+#define BE_RXD_USER_ID_MASK GENMASK(21, 16)
+#define BE_RXD_RX_STATISTICS BIT(22)
+#define BE_RXD_SMART_ANT BIT(23)
+#define BE_RXD_SEC_CAM_IDX_MASK GENMASK(31, 24)
+
+/* BE RXD dword7 */
+#define BE_RXD_PATTERN_IDX_MASK GENMASK(4, 0)
+#define BE_RXD_MAGIC_WAKE BIT(5)
+#define BE_RXD_UNICAST_WAKE BIT(6)
+#define BE_RXD_PATTERN_WAKE BIT(7)
+#define BE_RXD_RX_PL_MATCH BIT(8)
+#define BE_RXD_RX_PL_ID_MASK GENMASK(15, 12)
+#define BE_RXD_HDR_CNV BIT(16)
+#define BE_RXD_NAT25_HIT BIT(17)
+#define BE_RXD_IS_DA BIT(18)
+#define BE_RXD_CHKSUM_OFFLOAD_EN BIT(19)
+#define BE_RXD_RXSC_ENTRY_MASK GENMASK(22, 20)
+#define BE_RXD_RXSC_HIT BIT(23)
+#define BE_RXD_WITH_LLC BIT(24)
+#define BE_RXD_RX_AGG_FIELD_EN BIT(25)
+
+/* BE RXD dword8 */
+#define BE_RXD_MAC_ADDR_MASK GENMASK(31, 0)
+
+/* BE RXD dword9 */
+#define BE_RXD_MAC_ADDR_H_MASK GENMASK(15, 0)
+#define BE_RXD_HDR_OFFSET_MASK GENMASK(20, 16)
+#define BE_RXD_WL_HD_IV_LEN_MASK GENMASK(26, 21)
+
 struct rtw89_phy_sts_ie0 {
 	__le32 w0;
 	__le32 w1;
-- 
2.25.1

