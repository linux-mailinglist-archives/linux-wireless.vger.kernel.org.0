Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DCA70BE54
	for <lists+linux-wireless@lfdr.de>; Mon, 22 May 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbjEVM3u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 May 2023 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbjEVM1x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 May 2023 08:27:53 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBA1B4
        for <linux-wireless@vger.kernel.org>; Mon, 22 May 2023 05:25:54 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34MCPbT12030937, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34MCPbT12030937
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 22 May 2023 20:25:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 22 May 2023 20:25:47 +0800
Received: from [127.0.1.1] (172.16.17.50) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 22 May
 2023 20:25:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] wifi: rtw89: use struct and le32_get_bits to access RX info
Date:   Mon, 22 May 2023 20:25:10 +0800
Message-ID: <20230522122513.13559-3-pkshih@realtek.com>
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

If received packet type is PPDU status, RX info provides information
attached by MAC hardware, and mention how long BB information attached.

This conversion patch doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |  7 +--
 drivers/net/wireless/realtek/rtw89/txrx.h | 53 +++++++++++------------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ae547b38dfaa8..c92a83bf2f36f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1213,14 +1213,15 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 					  struct sk_buff *skb,
 					  struct rtw89_rx_phy_ppdu *phy_ppdu)
 {
+	const struct rtw89_rxinfo *rxinfo = (const struct rtw89_rxinfo *)skb->data;
 	bool rx_cnt_valid = false;
 	u8 plcp_size = 0;
 	u8 usr_num = 0;
 	u8 *phy_sts;
 
-	rx_cnt_valid = RTW89_GET_RXINFO_RX_CNT_VLD(skb->data);
-	plcp_size = RTW89_GET_RXINFO_PLCP_LEN(skb->data) << 3;
-	usr_num = RTW89_GET_RXINFO_USR_NUM(skb->data);
+	rx_cnt_valid = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_RX_CNT_VLD);
+	plcp_size = le32_get_bits(rxinfo->w1, RTW89_RXINFO_W1_PLCP_LEN) << 3;
+	usr_num = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_USR_NUM);
 	if (usr_num > RTW89_PPDU_MAX_USR) {
 		rtw89_warn(rtwdev, "Invalid user number in mac info\n");
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index d880ecb879ca8..d096d16c8d3be 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -251,34 +251,31 @@
 #define RTW89_GET_RXWD_SEC_CAM_ID(rxdesc) \
 	le32_get_bits((rxdesc)->dword5, GENMASK(7, 0))
 
-#define RTW89_GET_RXINFO_USR_NUM(rpt) \
-	le32_get_bits(*((const __le32 *)rpt), GENMASK(3, 0))
-#define RTW89_GET_RXINFO_FW_DEFINE(rpt) \
-	le32_get_bits(*((const __le32 *)rpt), GENMASK(15, 8))
-#define RTW89_GET_RXINFO_LSIG_LEN(rpt) \
-	le32_get_bits(*((const __le32 *)rpt), GENMASK(27, 16))
-#define RTW89_GET_RXINFO_IS_TO_SELF(rpt) \
-	le32_get_bits(*((const __le32 *)rpt), BIT(28))
-#define RTW89_GET_RXINFO_RX_CNT_VLD(rpt) \
-	le32_get_bits(*((const __le32 *)rpt), BIT(29))
-#define RTW89_GET_RXINFO_LONG_RXD(rpt) \
-	le32_get_bits(*((const __le32 *)rpt), GENMASK(31, 30))
-#define RTW89_GET_RXINFO_SERVICE(rpt) \
-	le32_get_bits(*((const __le32 *)(rpt) + 1), GENMASK(15, 0))
-#define RTW89_GET_RXINFO_PLCP_LEN(rpt) \
-	le32_get_bits(*((const __le32 *)(rpt) + 1), GENMASK(23, 16))
-#define RTW89_GET_RXINFO_MAC_ID_VALID(rpt, usr) \
-	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(0))
-#define RTW89_GET_RXINFO_DATA(rpt, usr) \
-	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(1))
-#define RTW89_GET_RXINFO_CTRL(rpt, usr) \
-	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(2))
-#define RTW89_GET_RXINFO_MGMT(rpt, usr) \
-	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(3))
-#define RTW89_GET_RXINFO_BCM(rpt, usr) \
-	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), BIT(4))
-#define RTW89_GET_RXINFO_MACID(rpt, usr) \
-	le32_get_bits(*((const __le32 *)(rpt) + (usr) + 2), GENMASK(15, 8))
+struct rtw89_rxinfo_user {
+	__le32 w0;
+};
+
+#define RTW89_RXINFO_USER_MAC_ID_VALID BIT(0)
+#define RTW89_RXINFO_USER_DATA BIT(1)
+#define RTW89_RXINFO_USER_CTRL BIT(2)
+#define RTW89_RXINFO_USER_MGMT BIT(3)
+#define RTW89_RXINFO_USER_BCM BIT(4)
+#define RTW89_RXINFO_USER_MACID GENMASK(15, 8)
+
+struct rtw89_rxinfo {
+	__le32 w0;
+	__le32 w1;
+	struct rtw89_rxinfo_user user[];
+} __packed;
+
+#define RTW89_RXINFO_W0_USR_NUM GENMASK(3, 0)
+#define RTW89_RXINFO_W0_FW_DEFINE GENMASK(15, 8)
+#define RTW89_RXINFO_W0_LSIG_LEN GENMASK(27, 16)
+#define RTW89_RXINFO_W0_IS_TO_SELF BIT(28)
+#define RTW89_RXINFO_W0_RX_CNT_VLD BIT(29)
+#define RTW89_RXINFO_W0_LONG_RXD GENMASK(31, 30)
+#define RTW89_RXINFO_W1_SERVICE GENMASK(15, 0)
+#define RTW89_RXINFO_W1_PLCP_LEN GENMASK(23, 16)
 
 #define RTW89_GET_PHY_STS_IE_MAP(sts) \
 	le32_get_bits(*((const __le32 *)(sts)), GENMASK(4, 0))
-- 
2.25.1

