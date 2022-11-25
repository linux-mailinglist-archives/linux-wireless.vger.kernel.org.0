Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A709638470
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 08:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKYHZe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 02:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiKYHZ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 02:25:29 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E39B52DAA8
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 23:25:26 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AP7OU5d8004227, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AP7OU5d8004227
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 25 Nov 2022 15:24:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 25 Nov 2022 15:25:14 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 25 Nov
 2022 15:25:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] wifi: rtw89: add HE radiotap for monitor mode
Date:   Fri, 25 Nov 2022 15:24:15 +0800
Message-ID: <20221125072416.94752-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125072416.94752-1-pkshih@realtek.com>
References: <20221125072416.94752-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/25/2022 07:02:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzI1IKRXpMggMDQ6MTA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With basic HE radiotap, we can check data rate in sniffer data. To store
the radiotap data, we reserve headroom of aligned 64 bytes, and then
update HE radiotap in monitor mode, so it doesn't affect performance in
normal mode.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 22 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c  |  2 +-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index af8daa101f457..190d72df800f9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1480,6 +1480,27 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
 	rx_status->rate_idx -= 4;
 }
 
+static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
+				       struct sk_buff *skb,
+				       struct ieee80211_rx_status *rx_status)
+{
+	static const struct ieee80211_radiotap_he known_he = {
+		.data1 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA1_DATA_MCS_KNOWN |
+				     IEEE80211_RADIOTAP_HE_DATA1_BW_RU_ALLOC_KNOWN),
+		.data2 = cpu_to_le16(IEEE80211_RADIOTAP_HE_DATA2_GI_KNOWN),
+	};
+	struct ieee80211_radiotap_he *he;
+
+	if (!(rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR))
+		return;
+
+	if (rx_status->encoding == RX_ENC_HE) {
+		rx_status->flag |= RX_FLAG_RADIOTAP_HE;
+		he = skb_push(skb, sizeof(*he));
+		*he = known_he;
+	}
+}
+
 static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -1494,6 +1515,7 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 
 	rtw89_core_hw_to_sband_rate(rx_status);
 	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
+	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status);
 	/* In low power mode, it does RX in thread context. */
 	local_bh_disable();
 	ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, napi);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1b0acb1c5450e..0be8f7bd3ca2d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -35,6 +35,7 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RSSI_FACTOR 1
 #define RTW89_RSSI_RAW_TO_DBM(rssi) ((s8)((rssi) >> RSSI_FACTOR) - MAX_RSSI)
 #define RTW89_TX_DIV_RSSI_RAW_TH (2 << RSSI_FACTOR)
+#define RTW89_RADIOTAP_ROOM ALIGN(sizeof(struct ieee80211_radiotap_he), 64)
 
 #define RTW89_HTC_MASK_VARIANT GENMASK(1, 0)
 #define RTW89_HTC_VARIANT_HE 3
@@ -4383,6 +4384,23 @@ static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 	return &fw_info->normal;
 }
 
+static inline struct sk_buff *rtw89_alloc_skb_for_rx(struct rtw89_dev *rtwdev,
+						     unsigned int length)
+{
+	struct sk_buff *skb;
+
+	if (rtwdev->hw->conf.flags & IEEE80211_CONF_MONITOR) {
+		skb = dev_alloc_skb(length + RTW89_RADIOTAP_ROOM);
+		if (!skb)
+			return NULL;
+
+		skb_reserve(skb, RTW89_RADIOTAP_ROOM);
+		return skb;
+	}
+
+	return dev_alloc_skb(length);
+}
+
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 7aa0af18cdd50..1c4500ba777c6 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -267,7 +267,7 @@ static u32 rtw89_pci_rxbd_deliver_skbs(struct rtw89_dev *rtwdev,
 
 		rtw89_core_query_rxdesc(rtwdev, desc_info, skb->data, rxinfo_size);
 
-		new = dev_alloc_skb(desc_info->pkt_size);
+		new = rtw89_alloc_skb_for_rx(rtwdev, desc_info->pkt_size);
 		if (!new)
 			goto err_sync_device;
 
-- 
2.25.1

