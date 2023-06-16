Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0BA7331B1
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jun 2023 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345493AbjFPM4e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Jun 2023 08:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjFPM4d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Jun 2023 08:56:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C03581
        for <linux-wireless@vger.kernel.org>; Fri, 16 Jun 2023 05:56:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 35GCtxa47024339, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 35GCtxa47024339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 16 Jun 2023 20:55:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 16 Jun 2023 20:56:18 +0800
Received: from [127.0.1.1] (172.16.16.227) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 16 Jun
 2023 20:56:17 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/6] wifi: rtw88: Fix AP mode incorrect DTIM behavior
Date:   Fri, 16 Jun 2023 20:55:36 +0800
Message-ID: <20230616125540.36877-3-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Broadcast and multicast packets in high queue should be transmitted
all at once during DTIM. But without proper settings, hardware fails
to recognize that there are multiple packets and fetches only one.
Fix this by signaling hardware with more data bit set when there are
packets in the high queue.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 2 ++
 drivers/net/wireless/realtek/rtw88/reg.h      | 1 +
 drivers/net/wireless/realtek/rtw88/tx.c       | 7 ++++++-
 drivers/net/wireless/realtek/rtw88/tx.h       | 1 +
 drivers/net/wireless/realtek/rtw88/usb.c      | 3 +++
 5 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 09bcc2345bb05..0dc83c2f420da 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -449,6 +449,7 @@ static int rtw_ops_start_ap(struct ieee80211_hw *hw,
 	const struct rtw_chip_info *chip = rtwdev->chip;
 
 	mutex_lock(&rtwdev->mutex);
+	rtw_write32_set(rtwdev, REG_TCR, BIT_TCR_UPDATE_HGQMD);
 	rtwdev->ap_active = true;
 	rtw_store_op_chan(rtwdev, true);
 	chip->ops->phy_calibration(rtwdev);
@@ -464,6 +465,7 @@ static void rtw_ops_stop_ap(struct ieee80211_hw *hw,
 	struct rtw_dev *rtwdev = hw->priv;
 
 	mutex_lock(&rtwdev->mutex);
+	rtw_write32_clr(rtwdev, REG_TCR, BIT_TCR_UPDATE_HGQMD);
 	rtwdev->ap_active = false;
 	if (!rtw_core_check_sta_active(rtwdev))
 		rtw_clear_op_chan(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 2a2ae2081f347..60de9de1cc7a8 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -410,6 +410,7 @@
 #define REG_TCR			0x0604
 #define BIT_PWRMGT_HWDATA_EN	BIT(7)
 #define BIT_TCR_UPDATE_TIMIE	BIT(5)
+#define BIT_TCR_UPDATE_HGQMD	BIT(4)
 #define REG_RCR			0x0608
 #define BIT_APP_FCS		BIT(31)
 #define BIT_APP_MIC		BIT(30)
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index edf351102f6a9..702e1fbc2ca62 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -35,6 +35,10 @@ void rtw_tx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 {
 	struct rtw_tx_desc *tx_desc = (struct rtw_tx_desc *)skb->data;
+	bool more_data = false;
+
+	if (pkt_info->qsel == TX_DESC_QSEL_HIGH)
+		more_data = true;
 
 	tx_desc->w0 = le32_encode_bits(pkt_info->tx_pkt_size, RTW_TX_DESC_W0_TXPKTSIZE) |
 		      le32_encode_bits(pkt_info->offset, RTW_TX_DESC_W0_OFFSET) |
@@ -45,7 +49,8 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 	tx_desc->w1 = le32_encode_bits(pkt_info->qsel, RTW_TX_DESC_W1_QSEL) |
 		      le32_encode_bits(pkt_info->rate_id, RTW_TX_DESC_W1_RATE_ID) |
 		      le32_encode_bits(pkt_info->sec_type, RTW_TX_DESC_W1_SEC_TYPE) |
-		      le32_encode_bits(pkt_info->pkt_offset, RTW_TX_DESC_W1_PKT_OFFSET);
+		      le32_encode_bits(pkt_info->pkt_offset, RTW_TX_DESC_W1_PKT_OFFSET) |
+		      le32_encode_bits(more_data, RTW_TX_DESC_W1_MORE_DATA);
 
 	tx_desc->w2 = le32_encode_bits(pkt_info->ampdu_en, RTW_TX_DESC_W2_AGG_EN) |
 		      le32_encode_bits(pkt_info->report, RTW_TX_DESC_W2_SPE_RPT) |
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 607c51b90dad1..b126e3c2dcb5f 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -31,6 +31,7 @@ struct rtw_tx_desc {
 #define RTW_TX_DESC_W1_RATE_ID GENMASK(20, 16)
 #define RTW_TX_DESC_W1_SEC_TYPE GENMASK(23, 22)
 #define RTW_TX_DESC_W1_PKT_OFFSET GENMASK(28, 24)
+#define RTW_TX_DESC_W1_MORE_DATA BIT(29)
 #define RTW_TX_DESC_W2_AGG_EN BIT(12)
 #define RTW_TX_DESC_W2_SPE_RPT BIT(19)
 #define RTW_TX_DESC_W2_AMPDU_DEN GENMASK(22, 20)
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 0529ae24f53b0..4a57efdba97bb 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -469,6 +469,9 @@ static u8 rtw_usb_tx_queue_mapping_to_qsel(struct sk_buff *skb)
 
 	if (unlikely(ieee80211_is_mgmt(fc) || ieee80211_is_ctl(fc)))
 		qsel = TX_DESC_QSEL_MGMT;
+	else if (is_broadcast_ether_addr(hdr->addr1) ||
+		 is_multicast_ether_addr(hdr->addr1))
+		qsel = TX_DESC_QSEL_HIGH;
 	else if (skb_get_queue_mapping(skb) <= IEEE80211_AC_BK)
 		qsel = skb->priority;
 	else
-- 
2.25.1

