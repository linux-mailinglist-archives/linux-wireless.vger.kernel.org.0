Return-Path: <linux-wireless+bounces-30126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F789CDE605
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFB10300A37E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202B18DB26;
	Fri, 26 Dec 2025 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="hgLWRZvS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F3135A53
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729752; cv=none; b=CVyyk8FMtsVbNRgE4jCWD7AJOOKj77O/MtUolJwGBRbYADEv8gDICaARlRKKHUQ7XQzXCiqWFwiRzXX36EIoJvSJXg85kaTqGfVp6bS9O8XiTHAf4pTmDLRFnBljAa6/Bbj3lttQpSvh0cVfPmfoLj9D+moZMAdvSIZZoAZyfAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729752; c=relaxed/simple;
	bh=Z9pZHDsRdJydKAOT7TCA/lM+L90acB3wobAfIi1OKnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gy/cA8ISyzU0HVc4A1W4S2Hw3K1Qn+69cWfnbFNQbRChVZO4qMUtkhOxfXWYog5g3iY3nSyW2sqRYD2/qomTV6mLZppYrbLraOIFbU5/KVaU9JYxIv+WVFKaDl4adQEcvE2wxqbU0MO+HM0ISpbVglyzIkG9LcHMiz5HOyl9wB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=hgLWRZvS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6FlIdA3113643, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729747; bh=uji8q6daOuDfyOggCXMe/viMLekm2uD9JGbC20dUo3k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=hgLWRZvSleIIPRaZ5Pxbg46g76zMhj/b8E2E9TpvfrZt6vSciQfy+bLZM68FflFZi
	 tmMGraxMnH95fqAYkkGRkwPAhtiwFjdf55MtDO6AOxZnJJjklKSskC5WH5oUg8k5hz
	 KLsni1GVoPge07TyaNs0PvNQ2B4ntIKL573v2fkqpmac17AM7+DccXjx0G9aGdLuRm
	 hdi0BllNBxRWJ5xGrrZh/dQqAFPJZ36/UvKtWpduQRR/19JSBAGbpZE+OqE0HDXlLn
	 eiy7vjEQZFoGLq4d/NLffbKHKFRYccb/40gFiK/RxacK30pGod6owTRbo6yDrNroFV
	 oO9VIHgCBE7dg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6FlIdA3113643
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:48 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/12] wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
Date: Fri, 26 Dec 2025 14:14:43 +0800
Message-ID: <20251226061446.63514-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251226061446.63514-1-pkshih@realtek.com>
References: <20251226061446.63514-1-pkshih@realtek.com>
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


