Return-Path: <linux-wireless+bounces-25154-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 592D1AFF804
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B70B5A3EB8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3458E19E7D1;
	Thu, 10 Jul 2025 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="a2OuLlfa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123132F3E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121514; cv=none; b=hznwLuA2qvyahOoLNIoLHPnPF33Edcb61vKF1jBbJKH/1rOPl314hh5WK8nmN3no8YwQdE3gpAzVlz4yalRXCiPaLKPOqlrKaPJc0AHtts79zNwILOD4t8ooAQnxTZE7imt8+rFNQErFGW2YzJcKXQ+xu9N/G+rj0IVLPSak/tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121514; c=relaxed/simple;
	bh=qwDooRXu+8KGbM5Edjfi8sku3sl5OsGyCJ/mcWJSvdw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RXMhqUUmv+kAZeF0hWfDdGTVteDVexT9EQ6lxKC+tdDaRf+H3xYFCDFVfeiiNmmTtCP+bbRneyj0IG+0Nj7ZbbiXgOnilYjPJki5Es2PQC81YH9478KGiZ8d9V8vkBDZ1wu/+NuoCTEqQgYdP3oL89XazAWVPGKBEttaUX4TM8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=a2OuLlfa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PAPv82455815, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121510; bh=be0df0y5Gf89Y+9vjjuLwVGW5S3IaCJQTgs0Bbz3tvM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=a2OuLlfasUUNUTev69420cBl1PG6oC6Si/3gpsqGHhU/nBs60P0MzkyytQ2VmHmn6
	 dkz6emvzem44g5I6zfdps9Hl0dnvpI8sReLEKSWj6tbA8ctNTEn2FVzaOVzaV+kwxI
	 dUqZ0tAOyC6VY9T4n1chgHnKqGQQzdTOWH+UWPr+QlxL0+UY1x0573bw/e+a94TzCu
	 UG7kSOmlk4dhguMsVAW2XrcrbYqVvrrNMCWLoyH/vuPcFLIDP0u9wsINxXNUqNZEsQ
	 ECkweWl0pVG1tmWTTQ8SOU5UnQYAvOHgYl84lFvkUZ+ZIEafDPJYesL7Rpu6QZUt1H
	 /87d+vS3MJH3Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PAPv82455815
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:09 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/14] wifi: rtw89: extend HW scan of WiFi 7 chips for extra OP chan when concurrency
Date: Thu, 10 Jul 2025 12:24:14 +0800
Message-ID: <20250710042423.73617-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

HW scan of WiFi 7 chips supports multiple op channel configurations.
When concurrency, fill two channels info to HW scan to avoid packet
lost.

However, the OP chan timing is arranged by FW, and the actual stay
period depends on AP. It's hard to calculate total scan time for once
NoA in advance. Therefore, change the scan back to GO OP channel every
200TU and TX beacon to ensure GC doesn't beacon loss. Additionally, add
a period NoA with large duration to ensure GC doesn't TX packet during
GO scanning and can still listen beacon at TBTT to update the new NoA
info after scan complete.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 88 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h   |  1 +
 3 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c179fcf5b50a..9da0defc270f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5538,7 +5538,9 @@ struct rtw89_early_h2c {
 struct rtw89_hw_scan_extra_op {
 	bool set;
 	u8 macid;
+	u8 port;
 	struct rtw89_chan chan;
+	struct rtw89_vif_link *rtwvif_link;
 };
 
 struct rtw89_hw_scan_info {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1fd88dc7da85..20b7b4b15450 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5700,26 +5700,47 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	const struct rtw89_hw_scan_extra_op *ext = &scan_info->extra_op;
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_h2c_scanofld_be_macc_role *macc_role;
+	struct rtw89_hw_scan_extra_op scan_op[2] = {};
 	struct rtw89_chan *op = &scan_info->op_chan;
 	struct rtw89_h2c_scanofld_be_opch *opch;
 	struct rtw89_pktofld_info *pkt_info;
 	struct rtw89_h2c_scanofld_be *h2c;
+	struct ieee80211_vif *vif;
 	struct sk_buff *skb;
 	u8 macc_role_size = sizeof(*macc_role) * option->num_macc_role;
 	u8 opch_size = sizeof(*opch) * option->num_opch;
+	enum rtw89_scan_be_opmode opmode;
 	u8 probe_id[NUM_NL80211_BANDS];
 	u8 scan_offload_ver = U8_MAX;
 	u8 cfg_len = sizeof(*h2c);
 	unsigned int cond;
+	u8 ap_idx = U8_MAX;
 	u8 ver = U8_MAX;
+	u8 policy_val;
 	void *ptr;
+	u8 txbcn;
 	int ret;
 	u32 len;
 	u8 i;
 
+	scan_op[0].macid = rtwvif_link->mac_id;
+	scan_op[0].port = rtwvif_link->port;
+	scan_op[0].chan = *op;
+	vif = rtwvif_to_vif(rtwvif_link->rtwvif);
+	if (vif->type == NL80211_IFTYPE_AP)
+		ap_idx = 0;
+
+	if (ext->set) {
+		scan_op[1] = *ext;
+		vif = rtwvif_to_vif(ext->rtwvif_link->rtwvif);
+		if (vif->type == NL80211_IFTYPE_AP)
+			ap_idx = 1;
+	}
+
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
 	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
@@ -5822,29 +5843,35 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	}
 
 	for (i = 0; i < option->num_opch; i++) {
+		bool is_ap_idx = i == ap_idx;
+
+		opmode = is_ap_idx ? RTW89_SCAN_OPMODE_TBTT : RTW89_SCAN_OPMODE_INTV;
+		policy_val = is_ap_idx ? 2 : RTW89_OFF_CHAN_TIME / 10;
+		txbcn = is_ap_idx ? 1 : 0;
+
 		opch = ptr;
-		opch->w0 = le32_encode_bits(rtwvif_link->mac_id,
+		opch->w0 = le32_encode_bits(scan_op[i].macid,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_MACID) |
 			   le32_encode_bits(option->band,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_BAND) |
-			   le32_encode_bits(rtwvif_link->port,
+			   le32_encode_bits(scan_op[i].port,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_PORT) |
-			   le32_encode_bits(RTW89_SCAN_OPMODE_INTV,
+			   le32_encode_bits(opmode,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY) |
 			   le32_encode_bits(true,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_TXNULL) |
-			   le32_encode_bits(RTW89_OFF_CHAN_TIME / 10,
+			   le32_encode_bits(policy_val,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY_VAL);
 
-		opch->w1 = le32_encode_bits(op->band_type,
+		opch->w1 = le32_encode_bits(scan_op[i].chan.band_type,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_CH_BAND) |
-			   le32_encode_bits(op->band_width,
+			   le32_encode_bits(scan_op[i].chan.band_width,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_BW) |
 			   le32_encode_bits(0x3,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_NOTIFY) |
-			   le32_encode_bits(op->primary_channel,
+			   le32_encode_bits(scan_op[i].chan.primary_channel,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_PRI_CH) |
-			   le32_encode_bits(op->channel,
+			   le32_encode_bits(scan_op[i].chan.channel,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_CENTRAL_CH);
 
 		opch->w2 = le32_encode_bits(0,
@@ -5852,7 +5879,9 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 			   le32_encode_bits(0,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SW_DEF) |
 			   le32_encode_bits(rtw89_is_mlo_1_1(rtwdev) ? 1 : 2,
-					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SS);
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SS) |
+			   le32_encode_bits(txbcn,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_TXBCN);
 
 		opch->w3 = le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
 					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT0) |
@@ -7625,7 +7654,7 @@ static int rtw89_hw_scan_prehandle(struct rtw89_dev *rtwdev,
 
 static void rtw89_hw_scan_update_link_beacon_noa(struct rtw89_dev *rtwdev,
 						 struct rtw89_vif_link *rtwvif_link,
-						 u16 tu)
+						 u16 tu, bool scan)
 {
 	struct ieee80211_p2p_noa_desc noa_desc = {};
 	struct ieee80211_bss_conf *bss_conf;
@@ -7651,17 +7680,24 @@ static void rtw89_hw_scan_update_link_beacon_noa(struct rtw89_dev *rtwdev,
 	}
 
 	noa_desc.start_time = cpu_to_le32(tsf);
-	noa_desc.interval = cpu_to_le32(ieee80211_tu_to_usec(tu));
-	noa_desc.duration = cpu_to_le32(ieee80211_tu_to_usec(tu));
-	noa_desc.count = 1;
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_AX) {
+		noa_desc.interval = cpu_to_le32(ieee80211_tu_to_usec(tu));
+		noa_desc.duration = cpu_to_le32(ieee80211_tu_to_usec(tu));
+		noa_desc.count = 1;
+	} else {
+		noa_desc.duration = cpu_to_le32(ieee80211_tu_to_usec(20000));
+		noa_desc.interval = cpu_to_le32(ieee80211_tu_to_usec(20000));
+		noa_desc.count = 255;
+	}
 
 	rtw89_p2p_noa_renew(rtwvif_link);
-	rtw89_p2p_noa_append(rtwvif_link, &noa_desc);
+	if (scan)
+		rtw89_p2p_noa_append(rtwvif_link, &noa_desc);
+
 	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
 }
 
-static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev,
-					    const struct cfg80211_scan_request *req)
+static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev, bool scan)
 {
 	const struct rtw89_entity_mgnt *mgnt = &rtwdev->hal.entity_mgnt;
 	const struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
@@ -7676,6 +7712,9 @@ static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev,
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
+	if (!scan)
+		goto update;
+
 	list_for_each_safe(pos, tmp, &scan_info->chan_list) {
 		switch (chip->chip_gen) {
 		case RTW89_CHIP_AX:
@@ -7699,6 +7738,7 @@ static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev,
 		return;
 	}
 
+update:
 	list_for_each_entry(rtwvif, &mgnt->active_list, mgnt_entry) {
 		unsigned int link_id;
 
@@ -7707,7 +7747,8 @@ static void rtw89_hw_scan_update_beacon_noa(struct rtw89_dev *rtwdev,
 			continue;
 
 		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
-			rtw89_hw_scan_update_link_beacon_noa(rtwdev, rtwvif_link, tu);
+			rtw89_hw_scan_update_link_beacon_noa(rtwdev, rtwvif_link,
+							     tu, scan);
 	}
 }
 
@@ -7742,7 +7783,9 @@ static void rtw89_hw_scan_set_extra_op_info(struct rtw89_dev *rtwdev,
 		*ext = (struct rtw89_hw_scan_extra_op){
 			.set = true,
 			.macid = tmp_link->mac_id,
+			.port = tmp_link->port,
 			.chan = *tmp_chan,
+			.rtwvif_link = tmp_link,
 		};
 
 		rtw89_debug(rtwdev, RTW89_DBG_HW_SCAN,
@@ -7815,7 +7858,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rtw89_phy_dig_suspend(rtwdev);
 
 	if (mode == RTW89_ENTITY_MODE_MCC)
-		rtw89_hw_scan_update_beacon_noa(rtwdev, req);
+		rtw89_hw_scan_update_beacon_noa(rtwdev, true);
 
 	return 0;
 }
@@ -7828,6 +7871,7 @@ struct rtw89_hw_scan_complete_cb_data {
 static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
 	struct rtw89_hw_scan_complete_cb_data *cb_data = data;
 	struct rtw89_vif_link *rtwvif_link = cb_data->rtwvif_link;
 	struct cfg80211_scan_info info = {
@@ -7850,6 +7894,9 @@ static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 
 	rtw89_hw_scan_cleanup(rtwdev, rtwvif_link);
 
+	if (mode == RTW89_ENTITY_MODE_MCC)
+		rtw89_hw_scan_update_beacon_noa(rtwdev, false);
+
 	return 0;
 }
 
@@ -7916,6 +7963,8 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 			  bool enable)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	const struct rtw89_hw_scan_extra_op *ext = &scan_info->extra_op;
 	struct rtw89_scan_option opt = {0};
 	bool connected;
 	int ret = 0;
@@ -7940,6 +7989,9 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 		opt.num_macc_role = 0;
 		opt.mlo_mode = rtwdev->mlo_dbcc_mode;
 		opt.num_opch = connected ? 1 : 0;
+		if (connected && ext->set)
+			opt.num_opch++;
+
 		opt.opch_end = connected ? 0 : RTW89_CHAN_INVALID;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 22b2b2a716ef..479a9f980b7f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2817,6 +2817,7 @@ struct rtw89_h2c_scanofld_be_opch {
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W2_PKTS_CTRL GENMASK(7, 0)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W2_SW_DEF GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W2_SS GENMASK(18, 16)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W2_TXBCN BIT(19)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT0 GENMASK(7, 0)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT1 GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT2 GENMASK(23, 16)
-- 
2.25.1


