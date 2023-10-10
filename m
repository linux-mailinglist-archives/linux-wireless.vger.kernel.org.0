Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAA77BF0B1
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Oct 2023 04:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441859AbjJJCKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 22:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441851AbjJJCKu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 22:10:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578C299
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 19:10:49 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39A2AcuZ62015425, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.92/5.92) with ESMTPS id 39A2AcuZ62015425
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Oct 2023 10:10:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 10 Oct 2023 10:10:38 +0800
Received: from [127.0.1.1] (172.16.16.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 10 Oct
 2023 10:10:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>, <johannes@sipsolutions.net>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 6/6] wifi: rtw89: add EHT radiotap in monitor mode
Date:   Tue, 10 Oct 2023 10:10:06 +0800
Message-ID: <20231010021006.6061-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231010021006.6061-1-pkshih@realtek.com>
References: <20231010021006.6061-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.25]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

Add IEEE80211_RADIOTAP_EHT and IEEE80211_RADIOTAP_EHT_USIG radiotap to
fill basic EHT NSS, MCS, GI and bandwidth.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 66 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  9 +++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2742e6646cf1..8cb1715d049a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1907,6 +1907,70 @@ static void rtw89_core_hw_to_sband_rate(struct ieee80211_rx_status *rx_status)
 	rx_status->rate_idx -= 4;
 }
 
+static u8 rx_status_bw_to_radiotap_eht_usig[] = {
+	[RATE_INFO_BW_20] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_20MHZ,
+	[RATE_INFO_BW_5] = U8_MAX,
+	[RATE_INFO_BW_10] = U8_MAX,
+	[RATE_INFO_BW_40] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_40MHZ,
+	[RATE_INFO_BW_80] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_80MHZ,
+	[RATE_INFO_BW_160] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_160MHZ,
+	[RATE_INFO_BW_HE_RU] = U8_MAX,
+	[RATE_INFO_BW_320] = IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_320MHZ_1,
+	[RATE_INFO_BW_EHT_RU] = U8_MAX,
+};
+
+static void rtw89_core_update_radiotap_eht(struct rtw89_dev *rtwdev,
+					   struct sk_buff *skb,
+					   struct ieee80211_rx_status *rx_status)
+{
+	struct ieee80211_radiotap_eht_usig *usig;
+	struct ieee80211_radiotap_eht *eht;
+	struct ieee80211_radiotap_tlv *tlv;
+	int eht_len = struct_size(eht, user_info, 1);
+	int usig_len = sizeof(*usig);
+	int len;
+	u8 bw;
+
+	len = sizeof(*tlv) + ALIGN(eht_len, 4) +
+	      sizeof(*tlv) + ALIGN(usig_len, 4);
+
+	rx_status->flag |= RX_FLAG_RADIOTAP_TLV_AT_END;
+	skb_reset_mac_header(skb);
+
+	/* EHT */
+	tlv = skb_push(skb, len);
+	memset(tlv, 0, len);
+	tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT);
+	tlv->len = cpu_to_le16(eht_len);
+
+	eht = (struct ieee80211_radiotap_eht *)tlv->data;
+	eht->known = cpu_to_le32(IEEE80211_RADIOTAP_EHT_KNOWN_GI);
+	eht->data[0] =
+		le32_encode_bits(rx_status->eht.gi, IEEE80211_RADIOTAP_EHT_DATA0_GI);
+
+	eht->user_info[0] =
+		cpu_to_le32(IEEE80211_RADIOTAP_EHT_USER_INFO_MCS_KNOWN |
+			    IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_KNOWN_O);
+	eht->user_info[0] |=
+		le32_encode_bits(rx_status->rate_idx, IEEE80211_RADIOTAP_EHT_USER_INFO_MCS) |
+		le32_encode_bits(rx_status->nss, IEEE80211_RADIOTAP_EHT_USER_INFO_NSS_O);
+
+	/* U-SIG */
+	tlv = (void *)tlv + sizeof(*tlv) + ALIGN(eht_len, 4);
+	tlv->type = cpu_to_le16(IEEE80211_RADIOTAP_EHT_USIG);
+	tlv->len = cpu_to_le16(usig_len);
+
+	bw = rx_status->bw < ARRAY_SIZE(rx_status_bw_to_radiotap_eht_usig) ?
+	     rx_status_bw_to_radiotap_eht_usig[rx_status->bw] : U8_MAX;
+	if (bw == U8_MAX)
+		return;
+
+	usig = (struct ieee80211_radiotap_eht_usig *)tlv->data;
+	usig->common =
+		le32_encode_bits(1, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW_KNOWN) |
+		le32_encode_bits(bw, IEEE80211_RADIOTAP_EHT_USIG_COMMON_BW);
+}
+
 static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 				       struct sk_buff *skb,
 				       struct ieee80211_rx_status *rx_status)
@@ -1925,6 +1989,8 @@ static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 		rx_status->flag |= RX_FLAG_RADIOTAP_HE;
 		he = skb_push(skb, sizeof(*he));
 		*he = known_he;
+	} else if (rx_status->encoding == RX_ENC_EHT) {
+		rtw89_core_update_radiotap_eht(rtwdev, skb, rx_status);
 	}
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8c0dfd73031e..d5272a82ff8b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -37,7 +37,14 @@ extern const struct ieee80211_ops rtw89_ops;
 #define RSSI_FACTOR 1
 #define RTW89_RSSI_RAW_TO_DBM(rssi) ((s8)((rssi) >> RSSI_FACTOR) - MAX_RSSI)
 #define RTW89_TX_DIV_RSSI_RAW_TH (2 << RSSI_FACTOR)
-#define RTW89_RADIOTAP_ROOM ALIGN(sizeof(struct ieee80211_radiotap_he), 64)
+#define RTW89_RADIOTAP_ROOM_HE sizeof(struct ieee80211_radiotap_he)
+#define RTW89_RADIOTAP_ROOM_EHT \
+	(sizeof(struct ieee80211_radiotap_tlv) + \
+	 ALIGN(struct_size((struct ieee80211_radiotap_eht *)0, user_info, 1), 4) + \
+	 sizeof(struct ieee80211_radiotap_tlv) + \
+	 ALIGN(sizeof(struct ieee80211_radiotap_eht_usig), 4))
+#define RTW89_RADIOTAP_ROOM \
+	ALIGN(max(RTW89_RADIOTAP_ROOM_HE, RTW89_RADIOTAP_ROOM_EHT), 64)
 
 #define RTW89_HTC_MASK_VARIANT GENMASK(1, 0)
 #define RTW89_HTC_VARIANT_HE 3
-- 
2.25.1

