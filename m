Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941B869C5FD
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Feb 2023 08:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbjBTH30 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Feb 2023 02:29:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjBTH3Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Feb 2023 02:29:25 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F54CE3AA
        for <linux-wireless@vger.kernel.org>; Sun, 19 Feb 2023 23:29:23 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 31K72l112025234, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 31K72l112025234
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 20 Feb 2023 15:02:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 20 Feb 2023 15:02:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 20 Feb
 2023 15:02:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: adjust channel encoding to common function
Date:   Mon, 20 Feb 2023 15:01:59 +0800
Message-ID: <20230220070202.29868-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230220070202.29868-1-pkshih@realtek.com>
References: <20230220070202.29868-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
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

From: Po-Hao Huang <phhuang@realtek.com>

Since the range of channel table is identical among ICs. Make channel
encode/decode function common and not IC dependent. So all ICs with
matching firmware that needs this kind of coding can use it directly.
This patch doesn't change logic at all.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      | 72 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  3 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 74 +------------------
 3 files changed, 77 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d9f61ba3d1765..d8b035972dd48 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4294,3 +4294,75 @@ void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					      data[RTW89_TSSI_SBW20]);
 }
 EXPORT_SYMBOL(rtw89_phy_tssi_ctrl_set_bandedge_cfg);
+
+static
+const u8 rtw89_ch_base_table[16] = {1, 0xff,
+				    36, 100, 132, 149, 0xff,
+				    1, 33, 65, 97, 129, 161, 193, 225, 0xff};
+#define RTW89_CH_BASE_IDX_2G		0
+#define RTW89_CH_BASE_IDX_5G_FIRST	2
+#define RTW89_CH_BASE_IDX_5G_LAST	5
+#define RTW89_CH_BASE_IDX_6G_FIRST	7
+#define RTW89_CH_BASE_IDX_6G_LAST	14
+
+#define RTW89_CH_BASE_IDX_MASK		GENMASK(7, 4)
+#define RTW89_CH_OFFSET_MASK		GENMASK(3, 0)
+
+u8 rtw89_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band)
+{
+	u8 chan_idx;
+	u8 last, first;
+	u8 idx;
+
+	switch (band) {
+	case RTW89_BAND_2G:
+		chan_idx = FIELD_PREP(RTW89_CH_BASE_IDX_MASK, RTW89_CH_BASE_IDX_2G) |
+			   FIELD_PREP(RTW89_CH_OFFSET_MASK, central_ch);
+		return chan_idx;
+	case RTW89_BAND_5G:
+		first = RTW89_CH_BASE_IDX_5G_FIRST;
+		last = RTW89_CH_BASE_IDX_5G_LAST;
+		break;
+	case RTW89_BAND_6G:
+		first = RTW89_CH_BASE_IDX_6G_FIRST;
+		last = RTW89_CH_BASE_IDX_6G_LAST;
+		break;
+	default:
+		rtw89_warn(rtwdev, "Unsupported band %d\n", band);
+		return 0;
+	}
+
+	for (idx = last; idx >= first; idx--)
+		if (central_ch >= rtw89_ch_base_table[idx])
+			break;
+
+	if (idx < first) {
+		rtw89_warn(rtwdev, "Unknown band %d channel %d\n", band, central_ch);
+		return 0;
+	}
+
+	chan_idx = FIELD_PREP(RTW89_CH_BASE_IDX_MASK, idx) |
+		   FIELD_PREP(RTW89_CH_OFFSET_MASK,
+			      (central_ch - rtw89_ch_base_table[idx]) >> 1);
+	return chan_idx;
+}
+EXPORT_SYMBOL(rtw89_encode_chan_idx);
+
+void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
+			   u8 *ch, enum nl80211_band *band)
+{
+	u8 idx, offset;
+
+	idx = FIELD_GET(RTW89_CH_BASE_IDX_MASK, chan_idx);
+	offset = FIELD_GET(RTW89_CH_OFFSET_MASK, chan_idx);
+
+	if (idx == RTW89_CH_BASE_IDX_2G) {
+		*band = NL80211_BAND_2GHZ;
+		*ch = offset;
+		return;
+	}
+
+	*band = idx <= RTW89_CH_BASE_IDX_5G_LAST ? NL80211_BAND_5GHZ : NL80211_BAND_6GHZ;
+	*ch = rtw89_ch_base_table[idx] + (offset << 1);
+}
+EXPORT_SYMBOL(rtw89_decode_chan_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 21233f094644b..de0a9abf646e3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -555,5 +555,8 @@ void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 					  enum rtw89_tssi_bandedge_cfg bandedge_cfg);
 void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev);
+u8 rtw89_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band);
+void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
+			   u8 *ch, enum nl80211_band *band);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index d2dde21d3daf5..8af813132f71d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -852,76 +852,6 @@ static void rtw8852c_set_gain_error(struct rtw89_dev *rtwdev,
 	}
 }
 
-static
-const u8 rtw8852c_ch_base_table[16] = {1, 0xff,
-				       36, 100, 132, 149, 0xff,
-				       1, 33, 65, 97, 129, 161, 193, 225, 0xff};
-#define RTW8852C_CH_BASE_IDX_2G		0
-#define RTW8852C_CH_BASE_IDX_5G_FIRST	2
-#define RTW8852C_CH_BASE_IDX_5G_LAST	5
-#define RTW8852C_CH_BASE_IDX_6G_FIRST	7
-#define RTW8852C_CH_BASE_IDX_6G_LAST	14
-
-#define RTW8852C_CH_BASE_IDX_MASK	GENMASK(7, 4)
-#define RTW8852C_CH_OFFSET_MASK		GENMASK(3, 0)
-
-static u8 rtw8852c_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band)
-{
-	u8 chan_idx;
-	u8 last, first;
-	u8 idx;
-
-	switch (band) {
-	case RTW89_BAND_2G:
-		chan_idx = FIELD_PREP(RTW8852C_CH_BASE_IDX_MASK, RTW8852C_CH_BASE_IDX_2G) |
-			   FIELD_PREP(RTW8852C_CH_OFFSET_MASK, central_ch);
-		return chan_idx;
-	case RTW89_BAND_5G:
-		first = RTW8852C_CH_BASE_IDX_5G_FIRST;
-		last = RTW8852C_CH_BASE_IDX_5G_LAST;
-		break;
-	case RTW89_BAND_6G:
-		first = RTW8852C_CH_BASE_IDX_6G_FIRST;
-		last = RTW8852C_CH_BASE_IDX_6G_LAST;
-		break;
-	default:
-		rtw89_warn(rtwdev, "Unsupported band %d\n", band);
-		return 0;
-	}
-
-	for (idx = last; idx >= first; idx--)
-		if (central_ch >= rtw8852c_ch_base_table[idx])
-			break;
-
-	if (idx < first) {
-		rtw89_warn(rtwdev, "Unknown band %d channel %d\n", band, central_ch);
-		return 0;
-	}
-
-	chan_idx = FIELD_PREP(RTW8852C_CH_BASE_IDX_MASK, idx) |
-		   FIELD_PREP(RTW8852C_CH_OFFSET_MASK,
-			      (central_ch - rtw8852c_ch_base_table[idx]) >> 1);
-	return chan_idx;
-}
-
-static void rtw8852c_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
-				     u8 *ch, enum nl80211_band *band)
-{
-	u8 idx, offset;
-
-	idx = FIELD_GET(RTW8852C_CH_BASE_IDX_MASK, chan_idx);
-	offset = FIELD_GET(RTW8852C_CH_OFFSET_MASK, chan_idx);
-
-	if (idx == RTW8852C_CH_BASE_IDX_2G) {
-		*band = NL80211_BAND_2GHZ;
-		*ch = offset;
-		return;
-	}
-
-	*band = idx <= RTW8852C_CH_BASE_IDX_5G_LAST ? NL80211_BAND_5GHZ : NL80211_BAND_6GHZ;
-	*ch = rtw8852c_ch_base_table[idx] + (offset << 1);
-}
-
 static void rtw8852c_set_gain_offset(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     enum rtw89_phy_idx phy_idx,
@@ -1084,7 +1014,7 @@ static void rtw8852c_ctrl_ch(struct rtw89_dev *rtwdev,
 		}
 	}
 
-	chan_idx = rtw8852c_encode_chan_idx(rtwdev, chan->primary_channel, band);
+	chan_idx = rtw89_encode_chan_idx(rtwdev, chan->primary_channel, band);
 	rtw89_phy_write32_idx(rtwdev, R_MAC_PIN_SEL, B_CH_IDX_SEG0, chan_idx, phy_idx);
 }
 
@@ -2730,7 +2660,7 @@ static void rtw8852c_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
 	if (chan_idx == 0)
 		return;
 
-	rtw8852c_decode_chan_idx(rtwdev, chan_idx, &ch, &band);
+	rtw89_decode_chan_idx(rtwdev, chan_idx, &ch, &band);
 	status->freq = ieee80211_channel_to_frequency(ch, band);
 	status->band = band;
 }
-- 
2.25.1

