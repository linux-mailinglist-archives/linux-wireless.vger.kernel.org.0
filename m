Return-Path: <linux-wireless+bounces-7095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0478B936D
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 04:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FFD284C7C
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2024 02:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FE017BAF;
	Thu,  2 May 2024 02:25:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487F517997
	for <linux-wireless@vger.kernel.org>; Thu,  2 May 2024 02:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714616759; cv=none; b=QFeda6QPa9RTxaDsCox5a/vZq/rYUysQ2A/QEynOCXfD/j0BPRyntEdgSxQnltqABZgTgKuOHoqJjXUoYmF3NOm9+cqLxJvXHSNgHFg///zdnegBEUkllunGTHIN/1qTPz5vXYuVKBqACQ+gU/DFZzCaT02gwM3kIaM10h3X2D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714616759; c=relaxed/simple;
	bh=+bMqIaw4lELvhzEHUN6zE22oLGhZ45ojHfcJG3uds2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXKniILJHI4DeGduwsIUIvKF1Z8ADa2M0E050dehZEwQMKtjHsxItgeT4NVVEiUsxUlGradFcAdxYh0s7ATvf9NYYhMX5ULkE3plx1920s0rGfmvNChmfz6Q4mvbPflipFo55+8tDSk9v1rJbcp1ORA0mgzt80PqgUjUxGNrMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4422Ptm862026953, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4422Ptm862026953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 2 May 2024 10:25:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 2 May 2024 10:25:55 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 2 May
 2024 10:25:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>
Subject: [PATCH v2 08/12] wifi: rtw89: wow: add GTK rekey feature related H2C commands
Date: Thu, 2 May 2024 10:25:01 +0800
Message-ID: <20240502022505.28966-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240502022505.28966-1-pkshih@realtek.com>
References: <20240502022505.28966-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Chih-Kang Chang <gary.chang@realtek.com>

Add PTK TRX IV, GTK RX IV, key encryption algorithm to H2C command to
enable GTK rekey feature.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 38 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c  |  8 ++++-
 drivers/net/wireless/realtek/rtw89/wow.c | 12 ++++++++
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 9581cd108298..67f13e4c3d15 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -756,6 +756,8 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 					 struct rtw89_h2c_dctlinfo_ud_v1 *h2c)
 {
 	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
 
 	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif->mac_id,
 				   DCTLINFO_V1_C0_MACID) |
@@ -808,6 +810,23 @@ void rtw89_cam_fill_dctl_sec_cam_info_v1(struct rtw89_dev *rtwdev,
 			      DCTLINFO_V1_W6_SEC_ENT4 |
 			      DCTLINFO_V1_W6_SEC_ENT5 |
 			      DCTLINFO_V1_W6_SEC_ENT6);
+
+	if (rtw_wow->ptk_alg) {
+		h2c->w0 = le32_encode_bits(ptk_tx_iv[0] | ptk_tx_iv[1] << 8,
+					   DCTLINFO_V1_W0_AES_IV_L);
+		h2c->m0 = cpu_to_le32(DCTLINFO_V1_W0_AES_IV_L);
+
+		h2c->w1 = le32_encode_bits(ptk_tx_iv[4]       |
+					   ptk_tx_iv[5] << 8  |
+					   ptk_tx_iv[6] << 16 |
+					   ptk_tx_iv[7] << 24,
+					   DCTLINFO_V1_W1_AES_IV_H);
+		h2c->m1 = cpu_to_le32(DCTLINFO_V1_W1_AES_IV_H);
+
+		h2c->w4 |= le32_encode_bits(rtw_wow->ptk_keyidx,
+					    DCTLINFO_V1_W4_SEC_KEY_ID);
+		h2c->m4 |= cpu_to_le32(DCTLINFO_V1_W4_SEC_KEY_ID);
+	}
 }
 
 void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
@@ -816,6 +835,8 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c)
 {
 	struct rtw89_addr_cam_entry *addr_cam = rtw89_get_addr_cam_of(rtwvif, rtwsta);
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
+	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
 
 	h2c->c0 = le32_encode_bits(rtwsta ? rtwsta->mac_id : rtwvif->mac_id,
 				   DCTLINFO_V2_C0_MACID) |
@@ -869,4 +890,21 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 				   DCTLINFO_V2_W7_SEC_ENT6_V1);
 	h2c->m7 = cpu_to_le32(DCTLINFO_V2_W7_SEC_ENT5_V1 |
 			      DCTLINFO_V2_W7_SEC_ENT6_V1);
+
+	if (rtw_wow->ptk_alg) {
+		h2c->w0 = le32_encode_bits(ptk_tx_iv[0] | ptk_tx_iv[1] << 8,
+					   DCTLINFO_V2_W0_AES_IV_L);
+		h2c->m0 = cpu_to_le32(DCTLINFO_V2_W0_AES_IV_L);
+
+		h2c->w1 = le32_encode_bits(ptk_tx_iv[4] |
+					   ptk_tx_iv[5] << 8 |
+					   ptk_tx_iv[6] << 16 |
+					   ptk_tx_iv[7] << 24,
+					   DCTLINFO_V2_W1_AES_IV_H);
+		h2c->m1 = cpu_to_le32(DCTLINFO_V2_W1_AES_IV_H);
+
+		h2c->w4 |= le32_encode_bits(rtw_wow->ptk_keyidx,
+					    DCTLINFO_V2_W4_SEC_KEY_ID);
+		h2c->m4 |= cpu_to_le32(DCTLINFO_V2_W4_SEC_KEY_ID);
+	}
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index a7ae5f85d57d..f47bdede6c62 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6404,6 +6404,7 @@ int rtw89_fw_h2c_disconnect_detect(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			    bool enable)
 {
+	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	struct rtw89_h2c_wow_global *h2c;
 	u8 macid = rtwvif->mac_id;
 	u32 len = sizeof(*h2c);
@@ -6420,7 +6421,12 @@ int rtw89_fw_h2c_wow_global(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	h2c = (struct rtw89_h2c_wow_global *)skb->data;
 
 	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_WOW_GLOBAL_W0_ENABLE) |
-		  le32_encode_bits(macid, RTW89_H2C_WOW_GLOBAL_W0_MAC_ID);
+		  le32_encode_bits(macid, RTW89_H2C_WOW_GLOBAL_W0_MAC_ID) |
+		  le32_encode_bits(rtw_wow->ptk_alg,
+				   RTW89_H2C_WOW_GLOBAL_W0_PAIRWISE_SEC_ALGO) |
+		  le32_encode_bits(rtw_wow->gtk_alg,
+				   RTW89_H2C_WOW_GLOBAL_W0_GROUP_SEC_ALGO);
+	h2c->key_info = rtw_wow->key_info;
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 185e24626691..3fb352f65e67 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -845,6 +845,12 @@ static int rtw89_wow_fw_start(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, true);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to enable GTK offload\n");
+		goto out;
+	}
+
 	ret = rtw89_wow_cfg_wake(rtwdev, true);
 	if (ret) {
 		rtw89_err(rtwdev, "wow: failed to config wake\n");
@@ -881,6 +887,12 @@ static int rtw89_wow_fw_stop(struct rtw89_dev *rtwdev)
 		goto out;
 	}
 
+	ret = rtw89_fw_h2c_wow_gtk_ofld(rtwdev, rtwvif, false);
+	if (ret) {
+		rtw89_err(rtwdev, "wow: failed to disable GTK offload\n");
+		goto out;
+	}
+
 	rtw89_fw_release_general_pkt_list(rtwdev, true);
 
 	ret = rtw89_wow_cfg_wake(rtwdev, false);
-- 
2.25.1


