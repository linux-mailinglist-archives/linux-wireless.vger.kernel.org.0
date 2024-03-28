Return-Path: <linux-wireless+bounces-5425-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C0388F739
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 06:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FB929D723
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 05:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B923FBB8;
	Thu, 28 Mar 2024 05:28:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EE2C19B
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 05:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711603714; cv=none; b=SnQgaNklBiAQRUse92hreOvWvZZt/f7DomdaukKy8jd2+xRkC6GOqaLNcpEzENLYzxsrwQ2FXFRHoCv2Z2FlbvTuBOeY1Wr05wc4KG7cm90jsoq7T76iR6aQZOirtVAXznEavgfuM6+xx9ot3F7laZYn319Zs2ZSHgx8cNrNF4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711603714; c=relaxed/simple;
	bh=djFLNp/EfqVEQleKUtDkcVIa0c30QMA8HAtqo2h2BtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZkfHAQJJmPkcHvSq2XR5FM54jcO6oRwluirBb+72+za2dJvZ8WvQmi6dNJemwzbfp75wzRqg0OxTQwB13lzFRsPXJH6aWwjcfBN4EpDWspzM4BUAFry2a/Ezyci+1BQcvKEypsy3Q6WXn9YD2nu3+sCn0OfOcLVRCH0H9ewRBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42S5SSVb81958921, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42S5SSVb81958921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:28:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 13:28:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Mar
 2024 13:28:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 2/3] wifi: rtw89: 8922a: download template probe requests for 6 GHz band
Date: Thu, 28 Mar 2024 13:26:55 +0800
Message-ID: <20240328052656.18823-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240328052656.18823-1-pkshih@realtek.com>
References: <20240328052656.18823-1-pkshih@realtek.com>
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

8922a FW supports RNR parsing, provide template probe requests and
let FW do the replacement for SSID/BSSID/short SSIDs.
Don't declare WIPHY_FLAG_SPLIT_SCAN_6GHZ so proper IEs such as
6 GHz capabilities can be passed down within the same scan request.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  6 +++-
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 28 +++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h       |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 9 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index d474b8d5df3d..1de40fa5cd9d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4486,7 +4486,11 @@ static int rtw89_core_register_hw(struct rtw89_dev *rtwdev)
 
 	hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS |
 			    WIPHY_FLAG_TDLS_EXTERNAL_SETUP |
-			    WIPHY_FLAG_AP_UAPSD | WIPHY_FLAG_SPLIT_SCAN_6GHZ;
+			    WIPHY_FLAG_AP_UAPSD;
+
+	if (!chip->support_rnr)
+		hw->wiphy->flags |= WIPHY_FLAG_SPLIT_SCAN_6GHZ;
+
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 
 	hw->wiphy->max_scan_ssids = RTW89_SCANOFLD_MAX_SSID;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fc1ed8612cf1..12133bc3e810 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3981,6 +3981,7 @@ struct rtw89_chip_info {
 	u8 support_bands;
 	u16 support_bandwidths;
 	bool support_unii4;
+	bool support_rnr;
 	bool ul_tb_waveform_ctrl;
 	bool ul_tb_pwr_diff;
 	bool hw_sec_hdr;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f27486d35cbc..18bef266b56f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4692,6 +4692,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	struct rtw89_h2c_scanofld_be_macc_role *macc_role;
 	struct rtw89_chan *op = &scan_info->op_chan;
 	struct rtw89_h2c_scanofld_be_opch *opch;
+	struct rtw89_pktofld_info *pkt_info;
 	struct rtw89_h2c_scanofld_be *h2c;
 	struct sk_buff *skb;
 	u8 macc_role_size = sizeof(*macc_role) * option->num_macc_role;
@@ -4716,6 +4717,16 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	h2c = (struct rtw89_h2c_scanofld_be *)skb->data;
 	ptr = skb->data;
 
+	memset(probe_id, RTW89_SCANOFLD_PKT_NONE, sizeof(probe_id));
+
+	list_for_each_entry(pkt_info, &scan_info->pkt_list[NL80211_BAND_6GHZ], list) {
+		if (pkt_info->wildcard_6ghz) {
+			/* Provide wildcard as template */
+			probe_id[NL80211_BAND_6GHZ] = pkt_info->id;
+			break;
+		}
+	}
+
 	h2c->w0 = le32_encode_bits(option->operation, RTW89_H2C_SCANOFLD_BE_W0_OP) |
 		  le32_encode_bits(option->scan_mode,
 				   RTW89_H2C_SCANOFLD_BE_W0_SCAN_MODE) |
@@ -5553,6 +5564,7 @@ static bool rtw89_is_6ghz_wildcard_probe_req(struct rtw89_dev *rtwdev,
 		info->ssid_len = req->ssids[ssid_idx].ssid_len;
 		return false;
 	} else {
+		info->wildcard_6ghz = true;
 		return true;
 	}
 }
@@ -5587,12 +5599,8 @@ static int rtw89_append_probe_req_ie(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		if (rtw89_is_6ghz_wildcard_probe_req(rtwdev, rtwvif, info, band,
-						     ssid_idx)) {
-			kfree_skb(new);
-			kfree(info);
-			goto out;
-		}
+		rtw89_is_6ghz_wildcard_probe_req(rtwdev, rtwvif, info, band,
+						 ssid_idx);
 
 		ret = rtw89_fw_h2c_add_pkt_offload(rtwdev, &info->id, new);
 		if (ret) {
@@ -5750,6 +5758,10 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 				continue;
 			else if (info->channel_6ghz && probe_count != 0)
 				ch_info->period += RTW89_CHANNEL_TIME_6G;
+
+			if (info->wildcard_6ghz)
+				continue;
+
 			ch_info->pkt_id[probe_count++] = info->id;
 			if (probe_count >= RTW89_SCANOFLD_MAX_SSID)
 				break;
@@ -5804,6 +5816,10 @@ static void rtw89_hw_scan_add_chan_be(struct rtw89_dev *rtwdev, int chan_type,
 			if (info->channel_6ghz &&
 			    ch_info->pri_ch != info->channel_6ghz)
 				continue;
+
+			if (info->wildcard_6ghz)
+				continue;
+
 			ch_info->pkt_id[probe_count++] = info->id;
 			if (probe_count >= RTW89_SCANOFLD_MAX_SSID)
 				break;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a7e78a881f7f..d247fe4b3bb1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -340,8 +340,9 @@ struct rtw89_mac_chinfo_be {
 struct rtw89_pktofld_info {
 	struct list_head list;
 	u8 id;
+	bool wildcard_6ghz;
 
-	/* Below fields are for 6 GHz RNR use only */
+	/* Below fields are for WiFi 6 chips 6 GHz RNR use only */
 	u8 ssid[IEEE80211_MAX_SSID_LEN];
 	u8 ssid_len;
 	u8 bssid[ETH_ALEN];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 51d3e61eaa1d..2e89c18fbf19 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2447,6 +2447,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.dig_regs		= &rtw8851b_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 0,
+	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2deadec715cf..e93cee1456bd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2163,6 +2163,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.dig_regs		= &rtw8852a_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 1,
+	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index d025c4135e1c..85908c55baa9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2597,6 +2597,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dig_regs		= &rtw8852b_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 0,
+	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 17e6164855fa..db354afc486e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2934,6 +2934,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dig_regs		= &rtw8852c_dig_regs,
 	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
 	.support_chanctx_num	= 2,
+	.support_rnr		= false,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0a5dc429b46d..b45a96fd0540 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2545,6 +2545,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.dig_regs		= &rtw8922a_dig_regs,
 	.tssi_dbw_table		= NULL,
 	.support_chanctx_num	= 2,
+	.support_rnr		= true,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ) |
 				  BIT(NL80211_BAND_6GHZ),
-- 
2.25.1


