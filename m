Return-Path: <linux-wireless+bounces-15770-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B389DB2A0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE60164DF3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 05:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B042613DDB5;
	Thu, 28 Nov 2024 05:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Liy/lIPW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319D313DBB1
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 05:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773293; cv=none; b=SNZ2hPS6rFm6P/5TYzU+gRmDu2FHpsRHpWiFJfujgG/lTfXK6fL/XcTW8Dv/DO/YKbvaGFOud0DkDUk8yzxPDYu5CAJb8DhceWuCKlJa/KgW6/OHKIxxDnbIyFe1IXlkpxl3V7GQ5V39QH4/pKmXKA+89JrA0KN67gUidm5lFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773293; c=relaxed/simple;
	bh=4+kV2zk+iMTHgV4G9DLANHJ/yH4oqtZ1CGiafpzKaYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4q/rWLwhnzrzxqg0DdTkzxpeuTgw4TwG38bugEkKGTM8J6w5W1m1hil5PQLfK0mvq964ZA4eapvRwNLkdSSqnLQV4UPk+YYmQ++enugcNLDt/Gh9lHLdWPof06fkAifoOVsP66UnkK90Eix5o0QBmyquaJSDKQKsqk3RVeTXNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Liy/lIPW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS5slLsB3960093, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732773287; bh=4+kV2zk+iMTHgV4G9DLANHJ/yH4oqtZ1CGiafpzKaYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Liy/lIPWd8NXHmgqwDwfwORr2V/dy1kaTKdrhtU1OiiMcLgh/PLFes5LUlKYM8Arx
	 VErCNqotO+2mraLgIHPEUg2UCbpYRtQp952ryebfEw5zdW4KyUrRzHT0yDQoptgPs/
	 O82wb2H04ngMqIFwgqqedOffnKRF+ppQdYH9PabzWJPlHI2/j+so6aCqXPO5pK2eld
	 5S9BqV5ddi0M2kOD8+tJVsdFR/eE2ONuOjuWmKDnUSb3BqUsLIeJF+BfYujd1OPzHF
	 HAOw1DtoyVn0kiCky0nNOoigAK2XkCHeLp3dqcljhngt8iFq1boXnsGd61hs1HZUp8
	 U9WxciluPLBpQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS5slLsB3960093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 13:54:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 13:54:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Nov
 2024 13:54:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 1/6] wifi: rtw89: 8922a: Extend channel info field length for scan
Date: Thu, 28 Nov 2024 13:54:28 +0800
Message-ID: <20241128055433.11851-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128055433.11851-1-pkshih@realtek.com>
References: <20241128055433.11851-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Po-Hao Huang <phhuang@realtek.com>

Extend the bitfield for duration in channel info to 16 bits.
Update the related format in H2C and C2H, then increase firmware
format sequence to 3.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 43 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h       | 22 +++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 24 ++++++++---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 +-
 5 files changed, 71 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 409cbdc6b92a..8c7e8b1c954f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4456,6 +4456,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
 	RTW89_FW_FEATURE_NOTIFY_AP_INFO,
+	RTW89_FW_FEATURE_CH_INFO_BE_V0,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index cbd759c844e5..a0408fcd6799 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -729,6 +729,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -4956,13 +4957,14 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_h2c_chinfo_elem_be *elem;
 	struct rtw89_mac_chinfo_be *ch_info;
-	struct rtw89_h2c_chinfo *h2c;
+	struct rtw89_h2c_chinfo_be *h2c;
 	struct sk_buff *skb;
 	unsigned int cond;
+	u8 ver = U8_MAX;
 	int skb_len;
 	int ret;
 
-	static_assert(sizeof(*elem) == RTW89_MAC_CHINFO_SIZE);
+	static_assert(sizeof(*elem) == RTW89_MAC_CHINFO_SIZE_BE);
 
 	skb_len = struct_size(h2c, elem, ch_num);
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, skb_len);
@@ -4971,8 +4973,11 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 		return -ENOMEM;
 	}
 
+	if (RTW89_CHK_FW_FEATURE(CH_INFO_BE_V0, &rtwdev->fw))
+		ver = 0;
+
 	skb_put(skb, sizeof(*h2c));
-	h2c = (struct rtw89_h2c_chinfo *)skb->data;
+	h2c = (struct rtw89_h2c_chinfo_be *)skb->data;
 
 	h2c->ch_num = ch_num;
 	h2c->elem_size = sizeof(*elem) / 4; /* in unit of 4 bytes */
@@ -4982,8 +4987,7 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 	list_for_each_entry(ch_info, chan_list, list) {
 		elem = (struct rtw89_h2c_chinfo_elem_be *)skb_put(skb, sizeof(*elem));
 
-		elem->w0 = le32_encode_bits(ch_info->period, RTW89_H2C_CHINFO_BE_W0_PERIOD) |
-			   le32_encode_bits(ch_info->dwell_time, RTW89_H2C_CHINFO_BE_W0_DWELL) |
+		elem->w0 = le32_encode_bits(ch_info->dwell_time, RTW89_H2C_CHINFO_BE_W0_DWELL) |
 			   le32_encode_bits(ch_info->central_ch,
 					    RTW89_H2C_CHINFO_BE_W0_CENTER_CH) |
 			   le32_encode_bits(ch_info->pri_ch, RTW89_H2C_CHINFO_BE_W0_PRI_CH);
@@ -5030,6 +5034,12 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 					    RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_SHORTSSIDS) |
 			   le32_encode_bits(ch_info->fw_probe0_bssids,
 					    RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_BSSIDS);
+		if (ver == 0)
+			elem->w0 |=
+			   le32_encode_bits(ch_info->period, RTW89_H2C_CHINFO_BE_W0_PERIOD);
+		else
+			elem->w7 = le32_encode_bits(ch_info->period,
+						    RTW89_H2C_CHINFO_BE_W7_PERIOD_V1);
 	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
@@ -5173,6 +5183,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 probe_id[NUM_NL80211_BANDS];
 	u8 cfg_len = sizeof(*h2c);
 	unsigned int cond;
+	u8 ver = U8_MAX;
 	void *ptr;
 	int ret;
 	u32 len;
@@ -5193,6 +5204,9 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	memset(probe_id, RTW89_SCANOFLD_PKT_NONE, sizeof(probe_id));
 
+	if (RTW89_CHK_FW_FEATURE(CH_INFO_BE_V0, &rtwdev->fw))
+		ver = 0;
+
 	if (!wowlan) {
 		list_for_each_entry(pkt_info, &scan_info->pkt_list[NL80211_BAND_6GHZ], list) {
 			if (pkt_info->wildcard_6ghz) {
@@ -5288,9 +5302,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 			   le32_encode_bits(RTW89_OFF_CHAN_TIME / 10,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY_VAL);
 
-		opch->w1 = le32_encode_bits(RTW89_CHANNEL_TIME,
-					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_DURATION) |
-			   le32_encode_bits(op->band_type,
+		opch->w1 = le32_encode_bits(op->band_type,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_CH_BAND) |
 			   le32_encode_bits(op->band_width,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_BW) |
@@ -5316,6 +5328,13 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT2) |
 			   le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT3);
+
+		if (ver == 0)
+			opch->w1 |= le32_encode_bits(RTW89_CHANNEL_TIME,
+						     RTW89_H2C_SCANOFLD_BE_OPCH_W1_DURATION);
+		else
+			opch->w4 = le32_encode_bits(RTW89_CHANNEL_TIME,
+						    RTW89_H2C_SCANOFLD_BE_OPCH_W4_DURATION_V1);
 		ptr += sizeof(*opch);
 	}
 
@@ -6498,7 +6517,7 @@ int rtw89_pno_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 
 	INIT_LIST_HEAD(&chan_list);
 	for (idx = 0, list_len = 0;
-	     idx < nd_config->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx < nd_config->n_channels && list_len < RTW89_SCAN_LIST_LIMIT_AX;
 	     idx++, list_len++) {
 		channel = nd_config->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
@@ -6549,7 +6568,7 @@ int rtw89_hw_scan_add_chan_list_ax(struct rtw89_dev *rtwdev,
 
 	INIT_LIST_HEAD(&chan_list);
 	for (idx = rtwdev->scan_info.last_chan_idx, list_len = 0;
-	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT_AX;
 	     idx++, list_len++) {
 		channel = req->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
@@ -6626,7 +6645,7 @@ int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 	INIT_LIST_HEAD(&chan_list);
 
 	for (idx = 0, list_len = 0;
-	     idx < nd_config->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx < nd_config->n_channels && list_len < RTW89_SCAN_LIST_LIMIT_BE;
 	     idx++, list_len++) {
 		channel = nd_config->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
@@ -6681,7 +6700,7 @@ int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 	INIT_LIST_HEAD(&chan_list);
 
 	for (idx = rtwdev->scan_info.last_chan_idx, list_len = 0;
-	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT;
+	     idx < req->n_channels && list_len < RTW89_SCAN_LIST_LIMIT_BE;
 	     idx++, list_len++) {
 		channel = req->channels[idx];
 		ch_info = kzalloc(sizeof(*ch_info), GFP_KERNEL);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 9106bcce1851..95681c390bb8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -310,9 +310,12 @@ struct rtw89_fw_macid_pause_sleep_grp {
 #define RTW89_SCANOFLD_DEBUG_MASK 0x1F
 #define RTW89_CHAN_INVALID 0xFF
 #define RTW89_MAC_CHINFO_SIZE 28
+#define RTW89_MAC_CHINFO_SIZE_BE 32
 #define RTW89_SCAN_LIST_GUARD 4
-#define RTW89_SCAN_LIST_LIMIT \
-		((RTW89_H2C_MAX_SIZE / RTW89_MAC_CHINFO_SIZE) - RTW89_SCAN_LIST_GUARD)
+#define RTW89_SCAN_LIST_LIMIT(size) \
+		((RTW89_H2C_MAX_SIZE / (size)) - RTW89_SCAN_LIST_GUARD)
+#define RTW89_SCAN_LIST_LIMIT_AX RTW89_SCAN_LIST_LIMIT(RTW89_MAC_CHINFO_SIZE)
+#define RTW89_SCAN_LIST_LIMIT_BE RTW89_SCAN_LIST_LIMIT(RTW89_MAC_CHINFO_SIZE_BE)
 
 #define RTW89_BCN_LOSS_CNT 10
 
@@ -2647,6 +2650,7 @@ struct rtw89_h2c_chinfo_elem_be {
 	__le32 w4;
 	__le32 w5;
 	__le32 w6;
+	__le32 w7;
 } __packed;
 
 #define RTW89_H2C_CHINFO_BE_W0_PERIOD GENMASK(7, 0)
@@ -2678,6 +2682,7 @@ struct rtw89_h2c_chinfo_elem_be {
 #define RTW89_H2C_CHINFO_BE_W5_FW_PROBE0_SSIDS GENMASK(31, 16)
 #define RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_SHORTSSIDS GENMASK(15, 0)
 #define RTW89_H2C_CHINFO_BE_W6_FW_PROBE0_BSSIDS GENMASK(31, 16)
+#define RTW89_H2C_CHINFO_BE_W7_PERIOD_V1 GENMASK(15, 0)
 
 struct rtw89_h2c_chinfo {
 	u8 ch_num;
@@ -2687,6 +2692,14 @@ struct rtw89_h2c_chinfo {
 	struct rtw89_h2c_chinfo_elem elem[] __counted_by(ch_num);
 } __packed;
 
+struct rtw89_h2c_chinfo_be {
+	u8 ch_num;
+	u8 elem_size;
+	u8 arg;
+	u8 rsvd0;
+	struct rtw89_h2c_chinfo_elem_be elem[] __counted_by(ch_num);
+} __packed;
+
 #define RTW89_H2C_CHINFO_ARG_MAC_IDX_MASK BIT(0)
 #define RTW89_H2C_CHINFO_ARG_APPEND_MASK BIT(1)
 
@@ -2733,6 +2746,7 @@ struct rtw89_h2c_scanofld_be_opch {
 	__le32 w1;
 	__le32 w2;
 	__le32 w3;
+	__le32 w4;
 } __packed;
 
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W0_MACID GENMASK(15, 0)
@@ -2754,6 +2768,7 @@ struct rtw89_h2c_scanofld_be_opch {
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT1 GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT2 GENMASK(23, 16)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT3 GENMASK(31, 24)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W4_DURATION_V1 GENMASK(15, 0)
 
 struct rtw89_h2c_scanofld_be {
 	__le32 w0;
@@ -3596,6 +3611,7 @@ struct rtw89_c2h_scanofld {
 	__le32 w5;
 	__le32 w6;
 	__le32 w7;
+	__le32 w8;
 } __packed;
 
 #define RTW89_C2H_SCANOFLD_W2_PRI_CH GENMASK(7, 0)
@@ -3610,6 +3626,8 @@ struct rtw89_c2h_scanofld {
 #define RTW89_C2H_SCANOFLD_W6_EXPECT_PERIOD GENMASK(15, 8)
 #define RTW89_C2H_SCANOFLD_W6_FW_DEF GENMASK(23, 16)
 #define RTW89_C2H_SCANOFLD_W7_REPORT_TSF GENMASK(31, 0)
+#define RTW89_C2H_SCANOFLD_W8_PERIOD_V1 GENMASK(15, 0)
+#define RTW89_C2H_SCANOFLD_W8_EXPECT_PERIOD_V1 GENMASK(31, 16)
 
 #define RTW89_GET_MAC_C2H_MCC_RCV_ACK_GROUP(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 03fc21440271..95f2beb89fe6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4788,9 +4788,11 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	struct rtw89_vif_link *rtwvif_link = rtwdev->scan_info.scanning_vif;
 	struct rtw89_vif *rtwvif;
 	struct rtw89_chan new;
-	u8 reason, status, tx_fail, band, actual_period, expect_period;
 	u32 last_chan = rtwdev->scan_info.last_chan_idx, report_tsf;
+	u16 actual_period, expect_period;
+	u8 reason, status, tx_fail, band;
 	u8 mac_idx, sw_def, fw_def;
+	u8 ver = U8_MAX;
 	u16 chan;
 	int ret;
 
@@ -4799,6 +4801,9 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 
 	rtwvif = rtwvif_link->rtwvif;
 
+	if (RTW89_CHK_FW_FEATURE(CH_INFO_BE_V0, &rtwdev->fw))
+		ver = 0;
+
 	tx_fail = le32_get_bits(c2h->w5, RTW89_C2H_SCANOFLD_W5_TX_FAIL);
 	status = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_STATUS);
 	chan = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_PRI_CH);
@@ -4811,21 +4816,28 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	if (!(rtwdev->chip->support_bands & BIT(NL80211_BAND_6GHZ)))
 		band = chan > 14 ? RTW89_BAND_5G : RTW89_BAND_2G;
 
-	rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
-		    "mac_idx[%d] band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d, actual: %d\n",
-		    mac_idx, band, chan, reason, status, tx_fail, actual_period);
-
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
 		sw_def = le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_SW_DEF);
-		expect_period = le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_EXPECT_PERIOD);
 		fw_def = le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_FW_DEF);
 		report_tsf = le32_get_bits(c2h->w7, RTW89_C2H_SCANOFLD_W7_REPORT_TSF);
+		if (ver == 0) {
+			expect_period =
+				le32_get_bits(c2h->w6, RTW89_C2H_SCANOFLD_W6_EXPECT_PERIOD);
+		} else {
+			actual_period = le32_get_bits(c2h->w8, RTW89_C2H_SCANOFLD_W8_PERIOD_V1);
+			expect_period =
+				le32_get_bits(c2h->w8, RTW89_C2H_SCANOFLD_W8_EXPECT_PERIOD_V1);
+		}
 
 		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
 			    "sw_def: %d, fw_def: %d, tsf: %x, expect: %d\n",
 			    sw_def, fw_def, report_tsf, expect_period);
 	}
 
+	rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
+		    "mac_idx[%d] band: %d, chan: %d, reason: %d, status: %d, tx_fail: %d, actual: %d\n",
+		    mac_idx, band, chan, reason, status, tx_fail, actual_period);
+
 	switch (reason) {
 	case RTW89_SCAN_LEAVE_OP_NOTIFY:
 	case RTW89_SCAN_LEAVE_CH_NOTIFY:
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index a5333099668a..a96b58ce6592 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -14,7 +14,7 @@
 #include "rtw8922a_rfk.h"
 #include "util.h"
 
-#define RTW8922A_FW_FORMAT_MAX 2
+#define RTW8922A_FW_FORMAT_MAX 3
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
 #define RTW8922A_MODULE_FIRMWARE \
 	RTW8922A_FW_BASENAME "-" __stringify(RTW8922A_FW_FORMAT_MAX) ".bin"
-- 
2.25.1


