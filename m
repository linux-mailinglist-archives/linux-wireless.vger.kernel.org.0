Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965047D8CE4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 03:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjJ0Bzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 21:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0Bzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 21:55:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C57AB
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 18:55:34 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39R1tQEF13465344, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39R1tQEF13465344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Oct 2023 09:55:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 27 Oct 2023 09:53:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 27 Oct
 2023 09:51:39 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 3/4] wifi: rtw89: consider RX info for WiFi 7 chips
Date:   Fri, 27 Oct 2023 09:50:58 +0800
Message-ID: <20231027015059.10032-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027015059.10032-1-pkshih@realtek.com>
References: <20231027015059.10032-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For WiFi 7 chips, some fields and predefined length are changed, so
add them accordingly.

The mac_id field is used to identify peer that send a packet, and we can
use it to know RSSI and traffic from the peer. For WiFi 7 chips,
RXWD.mac_id of PPDU status packet is not set by hardware. Instead, we
should fill it by rxinfo_user[].mac_id of PPDU status content.

Also, filter out invalid reports to prevent warning messages keep showing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: correct typo of subject prefix
---
 drivers/net/wireless/realtek/rtw89/core.c | 59 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/txrx.h |  4 ++
 3 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6a70c035b22e..ac99434c0e66 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1409,29 +1409,63 @@ static int rtw89_core_rx_process_mac_ppdu(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rxinfo *rxinfo = (const struct rtw89_rxinfo *)skb->data;
+	const struct rtw89_rxinfo_user *user;
+	enum rtw89_chip_gen chip_gen = rtwdev->chip->chip_gen;
+	int rx_cnt_size = RTW89_PPDU_MAC_RX_CNT_SIZE;
 	bool rx_cnt_valid = false;
+	bool invalid = false;
 	u8 plcp_size = 0;
-	u8 usr_num = 0;
 	u8 *phy_sts;
+	u8 usr_num;
+	int i;
+
+	if (chip_gen == RTW89_CHIP_BE) {
+		invalid = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_INVALID_V1);
+		rx_cnt_size = RTW89_PPDU_MAC_RX_CNT_SIZE_V1;
+	}
+
+	if (invalid)
+		return -EINVAL;
 
 	rx_cnt_valid = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_RX_CNT_VLD);
-	plcp_size = le32_get_bits(rxinfo->w1, RTW89_RXINFO_W1_PLCP_LEN) << 3;
-	usr_num = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_USR_NUM);
+	if (chip_gen == RTW89_CHIP_BE) {
+		plcp_size = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_PLCP_LEN_V1) << 3;
+		usr_num = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_USR_NUM_V1);
+	} else {
+		plcp_size = le32_get_bits(rxinfo->w1, RTW89_RXINFO_W1_PLCP_LEN) << 3;
+		usr_num = le32_get_bits(rxinfo->w0, RTW89_RXINFO_W0_USR_NUM);
+	}
 	if (usr_num > chip->ppdu_max_usr) {
 		rtw89_warn(rtwdev, "Invalid user number (%d) in mac info\n",
 			   usr_num);
 		return -EINVAL;
 	}
 
+	/* For WiFi 7 chips, RXWD.mac_id of PPDU status is not set by hardware,
+	 * so update mac_id by rxinfo_user[].mac_id.
+	 */
+	for (i = 0; i < usr_num && chip_gen == RTW89_CHIP_BE; i++) {
+		user = &rxinfo->user[i];
+		if (!le32_get_bits(user->w0, RTW89_RXINFO_USER_MAC_ID_VALID))
+			continue;
+
+		phy_ppdu->mac_id =
+			le32_get_bits(user->w0, RTW89_RXINFO_USER_MACID);
+		break;
+	}
+
 	phy_sts = skb->data + RTW89_PPDU_MAC_INFO_SIZE;
 	phy_sts += usr_num * RTW89_PPDU_MAC_INFO_USR_SIZE;
 	/* 8-byte alignment */
 	if (usr_num & BIT(0))
 		phy_sts += RTW89_PPDU_MAC_INFO_USR_SIZE;
 	if (rx_cnt_valid)
-		phy_sts += RTW89_PPDU_MAC_RX_CNT_SIZE;
+		phy_sts += rx_cnt_size;
 	phy_sts += plcp_size;
 
+	if (phy_sts > skb->data + skb->len)
+		return -EINVAL;
+
 	phy_ppdu->buf = phy_sts;
 	phy_ppdu->len = skb->data + skb->len - phy_sts;
 
@@ -1565,6 +1599,11 @@ static int rtw89_core_rx_process_phy_ppdu(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_phy_sts_hdr *hdr = phy_ppdu->buf;
 	u32 len_from_header;
+	bool physts_valid;
+
+	physts_valid = le32_get_bits(hdr->w0, RTW89_PHY_STS_HDR_W0_VALID);
+	if (!physts_valid)
+		return -EINVAL;
 
 	len_from_header = le32_get_bits(hdr->w0, RTW89_PHY_STS_HDR_W0_LEN) << 3;
 
@@ -2054,13 +2093,19 @@ static void rtw89_core_rx_process_ppdu_sts(struct rtw89_dev *rtwdev,
 					     .mac_id = desc_info->mac_id};
 	int ret;
 
-	if (desc_info->mac_info_valid)
-		rtw89_core_rx_process_mac_ppdu(rtwdev, skb, &phy_ppdu);
+	if (desc_info->mac_info_valid) {
+		ret = rtw89_core_rx_process_mac_ppdu(rtwdev, skb, &phy_ppdu);
+		if (ret)
+			goto out;
+	}
+
 	ret = rtw89_core_rx_process_phy_ppdu(rtwdev, &phy_ppdu);
 	if (ret)
-		rtw89_debug(rtwdev, RTW89_DBG_TXRX, "process ppdu failed\n");
+		goto out;
 
 	rtw89_core_rx_process_phy_sts(rtwdev, &phy_ppdu);
+
+out:
 	rtw89_core_rx_pending_skb(rtwdev, &phy_ppdu, desc_info, skb);
 	dev_kfree_skb_any(skb);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2eb29ea9ff7b..da8181539d1a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2818,6 +2818,7 @@ struct rtw89_ra_info {
 #define RTW89_PPDU_MAC_INFO_USR_SIZE 4
 #define RTW89_PPDU_MAC_INFO_SIZE 8
 #define RTW89_PPDU_MAC_RX_CNT_SIZE 96
+#define RTW89_PPDU_MAC_RX_CNT_SIZE_V1 128
 
 #define RTW89_MAX_RX_AGG_NUM 64
 #define RTW89_MAX_TX_AGG_NUM 128
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index 7142cce167de..c467a80ffa88 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -416,8 +416,11 @@ struct rtw89_rxinfo {
 } __packed;
 
 #define RTW89_RXINFO_W0_USR_NUM GENMASK(3, 0)
+#define RTW89_RXINFO_W0_USR_NUM_V1 GENMASK(4, 0)
 #define RTW89_RXINFO_W0_FW_DEFINE GENMASK(15, 8)
+#define RTW89_RXINFO_W0_PLCP_LEN_V1 GENMASK(23, 16)
 #define RTW89_RXINFO_W0_LSIG_LEN GENMASK(27, 16)
+#define RTW89_RXINFO_W0_INVALID_V1 BIT(27)
 #define RTW89_RXINFO_W0_IS_TO_SELF BIT(28)
 #define RTW89_RXINFO_W0_RX_CNT_VLD BIT(29)
 #define RTW89_RXINFO_W0_LONG_RXD GENMASK(31, 30)
@@ -430,6 +433,7 @@ struct rtw89_phy_sts_hdr {
 } __packed;
 
 #define RTW89_PHY_STS_HDR_W0_IE_MAP GENMASK(4, 0)
+#define RTW89_PHY_STS_HDR_W0_VALID BIT(7)
 #define RTW89_PHY_STS_HDR_W0_LEN GENMASK(15, 8)
 #define RTW89_PHY_STS_HDR_W0_RSSI_AVG GENMASK(31, 24)
 #define RTW89_PHY_STS_HDR_W1_RSSI_A GENMASK(7, 0)
-- 
2.25.1

