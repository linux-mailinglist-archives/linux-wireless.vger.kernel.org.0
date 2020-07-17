Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E182234E9
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgGQGuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:09 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55022 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6o0Mv9028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6o0Mv9028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:50:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:50:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:49:59 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] rtw88: update tx descriptor of mgmt and reserved page packets
Date:   Fri, 17 Jul 2020 14:49:33 +0800
Message-ID: <20200717064937.27966-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717064937.27966-1-yhchuang@realtek.com>
References: <20200717064937.27966-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Previous settings for TX descriptors of and reserved page packets
are insufficient.

For the sequence number of packets downloaded to reserved page, it
should be filled by hardware.
And for ps-poll packets in reserved page, to prevent AID being
changed by hardware, NAVUSEHDR should be set.
Additionally, the rate should be adjusted based on the current band
for mgmt and reserved page packets.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c   |  10 +--
 drivers/net/wireless/realtek/rtw88/main.h |   2 +
 drivers/net/wireless/realtek/rtw88/tx.c   | 104 +++++++++++++++-------
 drivers/net/wireless/realtek/rtw88/tx.h   |  13 ++-
 4 files changed, 90 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 13e79482f6d5..c922b4bb8d72 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -915,14 +915,14 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 	return skb_new;
 }
 
-static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb)
+static void rtw_fill_rsvd_page_desc(struct rtw_dev *rtwdev, struct sk_buff *skb,
+				    enum rtw_rsvd_packet_type type)
 {
-	struct rtw_tx_pkt_info pkt_info;
+	struct rtw_tx_pkt_info pkt_info = {0};
 	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 *pkt_desc;
 
-	memset(&pkt_info, 0, sizeof(pkt_info));
-	rtw_rsvd_page_pkt_info_update(rtwdev, &pkt_info, skb);
+	rtw_tx_rsvd_page_pkt_info_update(rtwdev, &pkt_info, skb, type);
 	pkt_desc = skb_push(skb, chip->tx_pkt_desc_sz);
 	memset(pkt_desc, 0, chip->tx_pkt_desc_sz);
 	rtw_tx_fill_tx_desc(&pkt_info, skb);
@@ -1261,7 +1261,7 @@ static u8 *rtw_build_rsvd_page(struct rtw_dev *rtwdev, u32 *size)
 		 * And iter->len will be added with size of tx_desc_sz.
 		 */
 		if (rsvd_pkt->add_txdesc)
-			rtw_fill_rsvd_page_desc(rtwdev, iter);
+			rtw_fill_rsvd_page_desc(rtwdev, iter, rsvd_pkt->type);
 
 		rsvd_pkt->skb = iter;
 		rsvd_pkt->page = total_page;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 45ebc5a70b1e..276b5d381467 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -592,6 +592,8 @@ struct rtw_tx_pkt_info {
 	bool dis_qselseq;
 	bool en_hwseq;
 	u8 hw_ssn_sel;
+	bool nav_use_hdr;
+	bool bt_null;
 };
 
 struct rtw_rx_pkt_stat {
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 79c42118825f..7fcc992b01a8 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -61,6 +61,8 @@ void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb)
 	SET_TX_DESC_DISQSELSEQ(txdesc, pkt_info->dis_qselseq);
 	SET_TX_DESC_EN_HWSEQ(txdesc, pkt_info->en_hwseq);
 	SET_TX_DESC_HW_SSN_SEL(txdesc, pkt_info->hw_ssn_sel);
+	SET_TX_DESC_NAVUSEHDR(txdesc, pkt_info->nav_use_hdr);
+	SET_TX_DESC_BT_NULL(txdesc, pkt_info->bt_null);
 }
 EXPORT_SYMBOL(rtw_tx_fill_tx_desc);
 
@@ -227,17 +229,58 @@ void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src)
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 }
 
-static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
+static void rtw_tx_pkt_info_update_rate(struct rtw_dev *rtwdev,
 					struct rtw_tx_pkt_info *pkt_info,
-					struct ieee80211_sta *sta,
 					struct sk_buff *skb)
 {
+	if (rtwdev->hal.current_band_type == RTW_BAND_2G) {
+		pkt_info->rate_id = RTW_RATEID_B_20M;
+		pkt_info->rate = DESC_RATE1M;
+	} else {
+		pkt_info->rate_id = RTW_RATEID_G;
+		pkt_info->rate = DESC_RATE6M;
+	}
 	pkt_info->use_rate = true;
-	pkt_info->rate_id = 6;
 	pkt_info->dis_rate_fallback = true;
+}
+
+static void rtw_tx_pkt_info_update_sec(struct rtw_dev *rtwdev,
+				       struct rtw_tx_pkt_info *pkt_info,
+				       struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	u8 sec_type = 0;
+
+	if (info && info->control.hw_key) {
+		struct ieee80211_key_conf *key = info->control.hw_key;
+
+		switch (key->cipher) {
+		case WLAN_CIPHER_SUITE_WEP40:
+		case WLAN_CIPHER_SUITE_WEP104:
+		case WLAN_CIPHER_SUITE_TKIP:
+			sec_type = 0x01;
+			break;
+		case WLAN_CIPHER_SUITE_CCMP:
+			sec_type = 0x03;
+			break;
+		default:
+			break;
+		}
+	}
+
+	pkt_info->sec_type = sec_type;
+}
+
+static void rtw_tx_mgmt_pkt_info_update(struct rtw_dev *rtwdev,
+					struct rtw_tx_pkt_info *pkt_info,
+					struct ieee80211_sta *sta,
+					struct sk_buff *skb)
+{
+	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb);
 	pkt_info->dis_qselseq = true;
 	pkt_info->en_hwseq = true;
 	pkt_info->hw_ssn_sel = 0;
+	/* TODO: need to change hw port and hw ssn sel for multiple vifs */
 }
 
 static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
@@ -312,7 +355,6 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	struct rtw_sta_info *si;
 	struct ieee80211_vif *vif = NULL;
 	__le16 fc = hdr->frame_control;
-	u8 sec_type = 0;
 	bool bmc;
 
 	if (sta) {
@@ -325,23 +367,6 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	else if (ieee80211_is_data(fc))
 		rtw_tx_data_pkt_info_update(rtwdev, pkt_info, sta, skb);
 
-	if (info->control.hw_key) {
-		struct ieee80211_key_conf *key = info->control.hw_key;
-
-		switch (key->cipher) {
-		case WLAN_CIPHER_SUITE_WEP40:
-		case WLAN_CIPHER_SUITE_WEP104:
-		case WLAN_CIPHER_SUITE_TKIP:
-			sec_type = 0x01;
-			break;
-		case WLAN_CIPHER_SUITE_CCMP:
-			sec_type = 0x03;
-			break;
-		default:
-			break;
-		}
-	}
-
 	bmc = is_broadcast_ether_addr(hdr->addr1) ||
 	      is_multicast_ether_addr(hdr->addr1);
 
@@ -349,7 +374,7 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 		rtw_tx_report_enable(rtwdev, pkt_info);
 
 	pkt_info->bmc = bmc;
-	pkt_info->sec_type = sec_type;
+	rtw_tx_pkt_info_update_sec(rtwdev, pkt_info, skb);
 	pkt_info->tx_pkt_size = skb->len;
 	pkt_info->offset = chip->tx_pkt_desc_sz;
 	pkt_info->qsel = skb->priority;
@@ -359,24 +384,42 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 	rtw_tx_stats(rtwdev, vif, skb);
 }
 
-void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
-				   struct rtw_tx_pkt_info *pkt_info,
-				   struct sk_buff *skb)
+void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
+				      struct rtw_tx_pkt_info *pkt_info,
+				      struct sk_buff *skb,
+				      enum rtw_rsvd_packet_type type)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	bool bmc;
 
+	/* A beacon or dummy reserved page packet indicates that it is the first
+	 * reserved page, and the qsel of it will be set in each hci.
+	 */
+	if (type != RSVD_BEACON && type != RSVD_DUMMY)
+		pkt_info->qsel = TX_DESC_QSEL_MGMT;
+
+	rtw_tx_pkt_info_update_rate(rtwdev, pkt_info, skb);
+
 	bmc = is_broadcast_ether_addr(hdr->addr1) ||
 	      is_multicast_ether_addr(hdr->addr1);
-	pkt_info->use_rate = true;
-	pkt_info->rate_id = 6;
-	pkt_info->dis_rate_fallback = true;
 	pkt_info->bmc = bmc;
 	pkt_info->tx_pkt_size = skb->len;
 	pkt_info->offset = chip->tx_pkt_desc_sz;
-	pkt_info->qsel = TX_DESC_QSEL_MGMT;
 	pkt_info->ls = true;
+	if (type == RSVD_PS_POLL) {
+		pkt_info->nav_use_hdr = true;
+	} else {
+		pkt_info->dis_qselseq = true;
+		pkt_info->en_hwseq = true;
+		pkt_info->hw_ssn_sel = 0;
+	}
+	if (type == RSVD_QOS_NULL)
+		pkt_info->bt_null = true;
+
+	rtw_tx_pkt_info_update_sec(rtwdev, pkt_info, skb);
+
+	/* TODO: need to change hw port and hw ssn sel for multiple vifs */
 }
 
 struct sk_buff *
@@ -399,8 +442,7 @@ rtw_tx_write_data_rsvd_page_get(struct rtw_dev *rtwdev,
 
 	skb_reserve(skb, tx_pkt_desc_sz);
 	skb_put_data(skb, buf, size);
-	pkt_info->tx_pkt_size = size;
-	pkt_info->offset = tx_pkt_desc_sz;
+	rtw_tx_rsvd_page_pkt_info_update(rtwdev, pkt_info, skb, RSVD_BEACON);
 
 	return skb;
 }
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index 72dfd4059f03..cfe84eef5923 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -59,6 +59,10 @@
 	le32p_replace_bits((__le32 *)(txdesc) + 0x08, value, BIT(15))
 #define SET_TX_DESC_HW_SSN_SEL(txdesc, value)                                 \
 	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, GENMASK(7, 6))
+#define SET_TX_DESC_NAVUSEHDR(txdesc, value)				       \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x03, value, BIT(15))
+#define SET_TX_DESC_BT_NULL(txdesc, value)				       \
+	le32p_replace_bits((__le32 *)(txdesc) + 0x02, value, BIT(23))
 
 enum rtw_tx_desc_queue_select {
 	TX_DESC_QSEL_TID0	= 0,
@@ -83,6 +87,8 @@ enum rtw_tx_desc_queue_select {
 	TX_DESC_QSEL_H2C	= 19,
 };
 
+enum rtw_rsvd_packet_type;
+
 void rtw_tx(struct rtw_dev *rtwdev,
 	    struct ieee80211_tx_control *control,
 	    struct sk_buff *skb);
@@ -96,9 +102,10 @@ void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
 void rtw_tx_fill_tx_desc(struct rtw_tx_pkt_info *pkt_info, struct sk_buff *skb);
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn);
 void rtw_tx_report_handle(struct rtw_dev *rtwdev, struct sk_buff *skb, int src);
-void rtw_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
-				   struct rtw_tx_pkt_info *pkt_info,
-				   struct sk_buff *skb);
+void rtw_tx_rsvd_page_pkt_info_update(struct rtw_dev *rtwdev,
+				      struct rtw_tx_pkt_info *pkt_info,
+				      struct sk_buff *skb,
+				      enum rtw_rsvd_packet_type type);
 struct sk_buff *
 rtw_tx_write_data_rsvd_page_get(struct rtw_dev *rtwdev,
 				struct rtw_tx_pkt_info *pkt_info,
-- 
2.17.1

