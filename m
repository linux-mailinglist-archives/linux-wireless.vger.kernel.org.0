Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F5E70BE56
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 14:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjEVMaL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 08:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234006AbjEVM2O (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 08:28:14 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A113E45
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 05:25:59 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34MCPgmoE030969, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34MCPgmoE030969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 20:25:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 22 May 2023 20:25:53 +0800
Received: from [127.0.1.1] (172.16.17.50) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 22 May
 2023 20:25:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: use struct and le32_get_bits() to access RX descriptor
Date:   Mon, 22 May 2023 20:25:12 +0800
Message-ID: <20230522122513.13559-5-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

RX descriptor is to provide basic and important information related to
packets, such as packet size, security, MAC ID and so on. Change to use
struct to access these fields, and not change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 50 ++++++++---------
 drivers/net/wireless/realtek/rtw89/txrx.h | 65 -----------------------
 2 files changed, 25 insertions(+), 90 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5a52815fc6077..101047686fffb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1806,27 +1806,27 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 	u8 shift_len, drv_info_len;
 
 	rxd_s = (struct rtw89_rxdesc_short *)(data + data_offset);
-	desc_info->pkt_size = RTW89_GET_RXWD_PKT_SIZE(rxd_s);
-	desc_info->drv_info_size = RTW89_GET_RXWD_DRV_INFO_SIZE(rxd_s);
-	desc_info->long_rxdesc = RTW89_GET_RXWD_LONG_RXD(rxd_s);
-	desc_info->pkt_type = RTW89_GET_RXWD_RPKT_TYPE(rxd_s);
-	desc_info->mac_info_valid = RTW89_GET_RXWD_MAC_INFO_VALID(rxd_s);
+	desc_info->pkt_size = le32_get_bits(rxd_s->dword0, AX_RXD_RPKT_LEN_MASK);
+	desc_info->drv_info_size = le32_get_bits(rxd_s->dword0, AX_RXD_DRV_INFO_SIZE_MASK);
+	desc_info->long_rxdesc = le32_get_bits(rxd_s->dword0,  AX_RXD_LONG_RXD);
+	desc_info->pkt_type = le32_get_bits(rxd_s->dword0,  AX_RXD_RPKT_TYPE_MASK);
+	desc_info->mac_info_valid = le32_get_bits(rxd_s->dword0, AX_RXD_MAC_INFO_VLD);
 	if (chip->chip_id == RTL8852C)
-		desc_info->bw = RTW89_GET_RXWD_BW_V1(rxd_s);
+		desc_info->bw = le32_get_bits(rxd_s->dword1, AX_RXD_BW_v1_MASK);
 	else
-		desc_info->bw = RTW89_GET_RXWD_BW(rxd_s);
-	desc_info->data_rate = RTW89_GET_RXWD_DATA_RATE(rxd_s);
-	desc_info->gi_ltf = RTW89_GET_RXWD_GI_LTF(rxd_s);
-	desc_info->user_id = RTW89_GET_RXWD_USER_ID(rxd_s);
-	desc_info->sr_en = RTW89_GET_RXWD_SR_EN(rxd_s);
-	desc_info->ppdu_cnt = RTW89_GET_RXWD_PPDU_CNT(rxd_s);
-	desc_info->ppdu_type = RTW89_GET_RXWD_PPDU_TYPE(rxd_s);
-	desc_info->free_run_cnt = RTW89_GET_RXWD_FREE_RUN_CNT(rxd_s);
-	desc_info->icv_err = RTW89_GET_RXWD_ICV_ERR(rxd_s);
-	desc_info->crc32_err = RTW89_GET_RXWD_CRC32_ERR(rxd_s);
-	desc_info->hw_dec = RTW89_GET_RXWD_HW_DEC(rxd_s);
-	desc_info->sw_dec = RTW89_GET_RXWD_SW_DEC(rxd_s);
-	desc_info->addr1_match = RTW89_GET_RXWD_A1_MATCH(rxd_s);
+		desc_info->bw = le32_get_bits(rxd_s->dword1, AX_RXD_BW_MASK);
+	desc_info->data_rate = le32_get_bits(rxd_s->dword1, AX_RXD_RX_DATARATE_MASK);
+	desc_info->gi_ltf = le32_get_bits(rxd_s->dword1, AX_RXD_RX_GI_LTF_MASK);
+	desc_info->user_id = le32_get_bits(rxd_s->dword1, AX_RXD_USER_ID_MASK);
+	desc_info->sr_en = le32_get_bits(rxd_s->dword1, AX_RXD_SR_EN);
+	desc_info->ppdu_cnt = le32_get_bits(rxd_s->dword1, AX_RXD_PPDU_CNT_MASK);
+	desc_info->ppdu_type = le32_get_bits(rxd_s->dword1, AX_RXD_PPDU_TYPE_MASK);
+	desc_info->free_run_cnt = le32_get_bits(rxd_s->dword2, AX_RXD_FREERUN_CNT_MASK);
+	desc_info->icv_err = le32_get_bits(rxd_s->dword3, AX_RXD_ICV_ERR);
+	desc_info->crc32_err = le32_get_bits(rxd_s->dword3, AX_RXD_CRC32_ERR);
+	desc_info->hw_dec = le32_get_bits(rxd_s->dword3, AX_RXD_HW_DEC);
+	desc_info->sw_dec = le32_get_bits(rxd_s->dword3, AX_RXD_SW_DEC);
+	desc_info->addr1_match = le32_get_bits(rxd_s->dword3, AX_RXD_A1_MATCH);
 
 	shift_len = desc_info->shift << 1; /* 2-byte unit */
 	drv_info_len = desc_info->drv_info_size << 3; /* 8-byte unit */
@@ -1841,12 +1841,12 @@ void rtw89_core_query_rxdesc(struct rtw89_dev *rtwdev,
 		return;
 
 	rxd_l = (struct rtw89_rxdesc_long *)(data + data_offset);
-	desc_info->frame_type = RTW89_GET_RXWD_TYPE(rxd_l);
-	desc_info->addr_cam_valid = RTW89_GET_RXWD_ADDR_CAM_VLD(rxd_l);
-	desc_info->addr_cam_id = RTW89_GET_RXWD_ADDR_CAM_ID(rxd_l);
-	desc_info->sec_cam_id = RTW89_GET_RXWD_SEC_CAM_ID(rxd_l);
-	desc_info->mac_id = RTW89_GET_RXWD_MAC_ID(rxd_l);
-	desc_info->rx_pl_id = RTW89_GET_RXWD_RX_PL_ID(rxd_l);
+	desc_info->frame_type = le32_get_bits(rxd_l->dword4, AX_RXD_TYPE_MASK);
+	desc_info->addr_cam_valid = le32_get_bits(rxd_l->dword5, AX_RXD_ADDR_CAM_VLD);
+	desc_info->addr_cam_id = le32_get_bits(rxd_l->dword5, AX_RXD_ADDR_CAM_MASK);
+	desc_info->sec_cam_id = le32_get_bits(rxd_l->dword5, AX_RXD_SEC_CAM_IDX_MASK);
+	desc_info->mac_id = le32_get_bits(rxd_l->dword5, AX_RXD_MAC_ID_MASK);
+	desc_info->rx_pl_id = le32_get_bits(rxd_l->dword5, AX_RXD_RX_PL_ID_MASK);
 }
 EXPORT_SYMBOL(rtw89_core_query_rxdesc);
 
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 5f20656aa1ad6..ec96da36eacc6 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -186,71 +186,6 @@
 #define AX_RXD_BIP_KEYID BIT(27)
 #define AX_RXD_BIP_ENC BIT(28)
 
-/* RX DESC helpers */
-/* Short Descriptor */
-#define RTW89_GET_RXWD_LONG_RXD(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, BIT(31))
-#define RTW89_GET_RXWD_DRV_INFO_SIZE(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, GENMASK(30, 28))
-#define RTW89_GET_RXWD_RPKT_TYPE(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, GENMASK(27, 24))
-#define RTW89_GET_RXWD_MAC_INFO_VALID(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, BIT(23))
-#define RTW89_GET_RXWD_BB_SEL(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, BIT(22))
-#define RTW89_GET_RXWD_HD_IV_LEN(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, GENMASK(21, 16))
-#define RTW89_GET_RXWD_SHIFT(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, GENMASK(15, 14))
-#define RTW89_GET_RXWD_PKT_SIZE(rxdesc) \
-	le32_get_bits((rxdesc)->dword0, GENMASK(13, 0))
-#define RTW89_GET_RXWD_BW(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(31, 30))
-#define RTW89_GET_RXWD_BW_V1(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(31, 29))
-#define RTW89_GET_RXWD_GI_LTF(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(27, 25))
-#define RTW89_GET_RXWD_DATA_RATE(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(24, 16))
-#define RTW89_GET_RXWD_USER_ID(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(15, 8))
-#define RTW89_GET_RXWD_SR_EN(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, BIT(7))
-#define RTW89_GET_RXWD_PPDU_CNT(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(6, 4))
-#define RTW89_GET_RXWD_PPDU_TYPE(rxdesc) \
-	le32_get_bits((rxdesc)->dword1, GENMASK(3, 0))
-#define RTW89_GET_RXWD_FREE_RUN_CNT(rxdesc) \
-	le32_get_bits((rxdesc)->dword2, GENMASK(31, 0))
-#define RTW89_GET_RXWD_ICV_ERR(rxdesc) \
-	le32_get_bits((rxdesc)->dword3, BIT(10))
-#define RTW89_GET_RXWD_CRC32_ERR(rxdesc) \
-	le32_get_bits((rxdesc)->dword3, BIT(9))
-#define RTW89_GET_RXWD_HW_DEC(rxdesc) \
-	le32_get_bits((rxdesc)->dword3, BIT(2))
-#define RTW89_GET_RXWD_SW_DEC(rxdesc) \
-	le32_get_bits((rxdesc)->dword3, BIT(1))
-#define RTW89_GET_RXWD_A1_MATCH(rxdesc) \
-	le32_get_bits((rxdesc)->dword3, BIT(0))
-
-/* Long Descriptor */
-#define RTW89_GET_RXWD_FRAG(rxdesc) \
-	le32_get_bits((rxdesc)->dword4, GENMASK(31, 28))
-#define RTW89_GET_RXWD_SEQ(rxdesc) \
-	le32_get_bits((rxdesc)->dword4, GENMASK(27, 16))
-#define RTW89_GET_RXWD_TYPE(rxdesc) \
-	le32_get_bits((rxdesc)->dword4, GENMASK(1, 0))
-#define RTW89_GET_RXWD_ADDR_CAM_VLD(rxdesc) \
-	le32_get_bits((rxdesc)->dword5, BIT(28))
-#define RTW89_GET_RXWD_RX_PL_ID(rxdesc) \
-	le32_get_bits((rxdesc)->dword5, GENMASK(27, 24))
-#define RTW89_GET_RXWD_MAC_ID(rxdesc) \
-	le32_get_bits((rxdesc)->dword5, GENMASK(23, 16))
-#define RTW89_GET_RXWD_ADDR_CAM_ID(rxdesc) \
-	le32_get_bits((rxdesc)->dword5, GENMASK(15, 8))
-#define RTW89_GET_RXWD_SEC_CAM_ID(rxdesc) \
-	le32_get_bits((rxdesc)->dword5, GENMASK(7, 0))
-
 struct rtw89_rxinfo_user {
 	__le32 w0;
 };
-- 
2.25.1

