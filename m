Return-Path: <linux-wireless+bounces-30156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BECCE5C73
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 04:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75CAC3002688
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 03:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D2204C36;
	Mon, 29 Dec 2025 03:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="IkSbBNtc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044901FBEB0
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 03:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766977834; cv=none; b=I1Fo1gJi9xgGHkzCXYDRc9cj/oStPvRJEaFj6NtfYtvZLuzx1ifvUGkhwvcXvbhO+aPNsgPQWikT3C7eZ3dyhwe3RAB5mwZvVNLP555bgG7+fptCp0IfR14OFJ81QDpOkBNyfQTses8nQcI7TXs6+F/DfnQmYpEwOd4kmZVgfKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766977834; c=relaxed/simple;
	bh=Z9pZHDsRdJydKAOT7TCA/lM+L90acB3wobAfIi1OKnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzLYJUMu9BdGQwzX4gsPCqnXVJ1c/9sI6MaPaLSXzA9dgc/roLFeOhXkGfzblMvRyomWAjPrr5V7CvmGY0MwVHow6n9Hwr2ZdA8L0ZbMXGHJ9ggDzITTRyFbIZa+36A2wjVk7GkBEK21swzghR5+82+WBdq+xtFDG1YBNWTlvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=IkSbBNtc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BT3ATfaC282931, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766977829; bh=uji8q6daOuDfyOggCXMe/viMLekm2uD9JGbC20dUo3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=IkSbBNtcogfhgieSMvEdT/d4Qt0++VNwyVvHYwl5o+97y5tH4pE5anyO8Yy6O5dD3
	 /uHacmZtqBk1fOvjM4LssoozbtapdgcOygtekYj3TFrpA9WZrZEtiDNirf6SXNkPZG
	 tra/Dtl6MSrrsrPsr5SCrsfn6NJcSUR6kJQk/uYVP1EheqkPkFtLvrvn+EWwB9o0+O
	 4yADngn0p5SKqxZ2esGb0+b3+4kAolC1BEo8RIsqWFjzdCxWwp4TCCbp90c/kLrY8X
	 tct+HS5HHx55nqVLflREENmJQwgtifDbyPc9pNcA9ebW4dOaOGzKZs8eZNfQQzt1ZD
	 UIabIxHLPK2ew==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BT3ATfaC282931
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 29 Dec 2025 11:10:29 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 29 Dec 2025 11:10:29 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 29 Dec 2025 11:10:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 09/12] wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
Date: Mon, 29 Dec 2025 11:09:23 +0800
Message-ID: <20251229030926.27004-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251229030926.27004-1-pkshih@realtek.com>
References: <20251229030926.27004-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chih-Kang Chang <gary.chang@realtek.com>

When scan with 2 OP channels, for the case like
not-connect(macid 0) + GO(macid 1) or not-connect(macid 0) + GC(macid 1),
the macid 0 doesn't offload NULL data packet to FW. Therefore, refine the
NULL data judgement to let interfaces that only connected and non-AP mode
need to TX nulldata.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 54 ++++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/fw.h |  1 +
 2 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9b3a9fc7c629..1e22ea51292a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5944,27 +5944,18 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 scan_offload_ver = U8_MAX;
 	u8 cfg_len = sizeof(*h2c);
 	unsigned int cond;
-	u8 ap_idx = U8_MAX;
 	u8 ver = U8_MAX;
 	u8 policy_val;
 	void *ptr;
+	u8 txnull;
 	u8 txbcn;
 	int ret;
 	u32 len;
 	u8 i;
 
-	scan_op[0].macid = rtwvif_link->mac_id;
-	scan_op[0].port = rtwvif_link->port;
-	scan_op[0].chan = *op;
-	vif = rtwvif_to_vif(rtwvif_link->rtwvif);
-	if (vif->type == NL80211_IFTYPE_AP)
-		ap_idx = 0;
-
-	if (ext->set) {
-		scan_op[1] = *ext;
-		vif = rtwvif_to_vif(ext->rtwvif_link->rtwvif);
-		if (vif->type == NL80211_IFTYPE_AP)
-			ap_idx = 1;
+	if (option->num_opch > RTW89_MAX_OP_NUM_BE) {
+		rtw89_err(rtwdev, "num of scan OP chan %d over limit\n", option->num_opch);
+		return -ENOENT;
 	}
 
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
@@ -6069,11 +6060,29 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	}
 
 	for (i = 0; i < option->num_opch; i++) {
-		bool is_ap_idx = i == ap_idx;
+		struct rtw89_vif_link *rtwvif_link_op;
+		bool is_ap;
+
+		switch (i) {
+		case 0:
+			scan_op[0].macid = rtwvif_link->mac_id;
+			scan_op[0].port = rtwvif_link->port;
+			scan_op[0].chan = *op;
+			rtwvif_link_op = rtwvif_link;
+			break;
+		case 1:
+			scan_op[1] = *ext;
+			rtwvif_link_op = ext->rtwvif_link;
+			break;
+		}
 
-		opmode = is_ap_idx ? RTW89_SCAN_OPMODE_TBTT : RTW89_SCAN_OPMODE_INTV;
-		policy_val = is_ap_idx ? 2 : RTW89_OFF_CHAN_TIME / 10;
-		txbcn = is_ap_idx ? 1 : 0;
+		vif = rtwvif_to_vif(rtwvif_link_op->rtwvif);
+		is_ap = vif->type == NL80211_IFTYPE_AP;
+		txnull = !is_zero_ether_addr(rtwvif_link_op->bssid) &&
+			 vif->type != NL80211_IFTYPE_AP;
+		opmode = is_ap ? RTW89_SCAN_OPMODE_TBTT : RTW89_SCAN_OPMODE_INTV;
+		policy_val = is_ap ? 2 : RTW89_OFF_CHAN_TIME / 10;
+		txbcn = is_ap ? 1 : 0;
 
 		opch = ptr;
 		opch->w0 = le32_encode_bits(scan_op[i].macid,
@@ -6084,7 +6093,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_PORT) |
 			   le32_encode_bits(opmode,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY) |
-			   le32_encode_bits(true,
+			   le32_encode_bits(txnull,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_TXNULL) |
 			   le32_encode_bits(policy_val,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY_VAL);
@@ -7396,6 +7405,7 @@ static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_chan *op = &rtwdev->scan_info.op_chan;
 	struct rtw89_pktofld_info *info;
+	struct ieee80211_vif *vif;
 	u8 band, probe_count = 0;
 	int ret;
 
@@ -7448,7 +7458,9 @@ static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
 		ch_info->pri_ch = op->primary_channel;
 		ch_info->ch_band = op->band_type;
 		ch_info->bw = op->band_width;
-		ch_info->tx_null = true;
+		vif = rtwvif_link_to_vif(rtwvif_link);
+		ch_info->tx_null = !is_zero_ether_addr(rtwvif_link->bssid) &&
+				   vif->type != NL80211_IFTYPE_AP;
 		ch_info->num_pkt = 0;
 		break;
 	case RTW89_CHAN_DFS:
@@ -7466,7 +7478,9 @@ static void rtw89_hw_scan_add_chan_ax(struct rtw89_dev *rtwdev, int chan_type,
 		ch_info->pri_ch = ext->chan.primary_channel;
 		ch_info->ch_band = ext->chan.band_type;
 		ch_info->bw = ext->chan.band_width;
-		ch_info->tx_null = true;
+		vif = rtwvif_link_to_vif(ext->rtwvif_link);
+		ch_info->tx_null = !is_zero_ether_addr(ext->rtwvif_link->bssid) &&
+				   vif->type != NL80211_IFTYPE_AP;
 		ch_info->num_pkt = 0;
 		ch_info->macid_tx = true;
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3a72ab3f1895..6a297fad148b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2812,6 +2812,7 @@ struct rtw89_h2c_scanofld_be_macc_role {
 	__le32 w0;
 } __packed;
 
+#define RTW89_MAX_OP_NUM_BE 2
 #define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_BAND GENMASK(1, 0)
 #define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_PORT GENMASK(4, 2)
 #define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_MACID GENMASK(23, 8)
-- 
2.25.1


