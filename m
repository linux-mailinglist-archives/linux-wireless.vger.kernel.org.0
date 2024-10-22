Return-Path: <linux-wireless+bounces-14297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8B89A9CA9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1521C22548
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 08:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7589527735;
	Tue, 22 Oct 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="c2p4Ra+1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB8157487
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585903; cv=none; b=TqPZTh8cPbywD9zVmd4qw8jGKMwOU1aMrzJ9PtAMhgQm96AT6budAnevZz0uJrr+PoS5l1HGmfoCFxSyl6fn7rjZwvRrSylMd0Lsogjh4Kj9Kgskt0AS0SZ77BQ6HAmosAPjxaEU+mrcq2CBoCde12bmTUS+juTf5H4PoirZrlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585903; c=relaxed/simple;
	bh=EapJNtVjpDlNNRnPSV+Lnw3BsZNPf4t/8AmsKfyhXLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRB13eSIkeyjqEswsEIYdpD7EJFP9RH7fQFjy6u7UOBAu7CXXMzOpRPCq4Rt9oZB2uMMbaW8KnXRaE4CdlL4bOBsf2v6tAgfsC1NjByuv9OY9Anvn9Z0dgrWY+iV5GBrwZhjvozXdlqnz6ela7W8Uh3kx5+4AX9K1+Pl1sFhYC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=c2p4Ra+1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49M8VcCxA3771851, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729585898; bh=EapJNtVjpDlNNRnPSV+Lnw3BsZNPf4t/8AmsKfyhXLc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=c2p4Ra+1h47oCWCmJ4jMQRqHb6ShYzIg8mL/ydh9pWYUT/OOqj5z35Uk5Dx2PtC+A
	 QAwMOEgRjSrwNDcd6DAD3JwvVhFAZ8C+0mCUswEaSrWKg3dZFJ3VNxMUKBmX8raJ0V
	 OSg61CNipbt6UTPi+UM1YEUWWG5R0i8xnXgE8GoMfIizsOKX70NtNGhjOvC23zZaFD
	 3Dds9nP6nKW1rpLy34/wl7KQ+a8OoPy9GdTnTwMiS4RWvrqnDN5q6w6Hsoeu9rZ+lM
	 zVqe5835wYAOuH6VAFF5stUwKgGqgCcr5LVJZIDuq+LMbD5iqVc0zbGsVckU/Ju6O3
	 iecut4DeERxWA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49M8VcCxA3771851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 16:31:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 16:31:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Oct
 2024 16:31:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 2/5] wifi: rtw89: Add encryption support for MLO connections
Date: Tue, 22 Oct 2024 16:31:03 +0800
Message-ID: <20241022083106.149252-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022083106.149252-1-pkshih@realtek.com>
References: <20241022083106.149252-1-pkshih@realtek.com>
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

In order to make encryption/decryption work properly with MLO
connections, MLD address needs to be filled in so circuits can
operate with the correct information.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c | 51 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/cam.h | 24 ++++++++---
 2 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8d140b94cb44..8ef59994c0db 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -961,16 +961,24 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					 struct rtw89_sta_link *rtwsta_link,
 					 struct rtw89_h2c_dctlinfo_ud_v2 *h2c)
 {
+	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif_link->rtwvif);
+	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	struct rtw89_addr_cam_entry *addr_cam =
 		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
+	bool is_mld = sta ? sta->mlo : ieee80211_vif_is_mld(vif);
 	struct rtw89_wow_param *rtw_wow = &rtwdev->wow;
 	u8 *ptk_tx_iv = rtw_wow->key_info.ptk_tx_iv;
+	u8 *mld_sma, *mld_tma, *mld_bssid;
 
 	h2c->c0 = le32_encode_bits(rtwsta_link ? rtwsta_link->mac_id :
 						 rtwvif_link->mac_id,
 				   DCTLINFO_V2_C0_MACID) |
 		  le32_encode_bits(1, DCTLINFO_V2_C0_OP);
 
+	h2c->w2 = le32_encode_bits(is_mld, DCTLINFO_V2_W2_IS_MLD);
+	h2c->m2 = cpu_to_le32(DCTLINFO_V2_W2_IS_MLD);
+
 	h2c->w4 = le32_encode_bits(addr_cam->sec_ent_keyid[0],
 				   DCTLINFO_V2_W4_SEC_ENT0_KEYID) |
 		  le32_encode_bits(addr_cam->sec_ent_keyid[1],
@@ -1036,4 +1044,47 @@ void rtw89_cam_fill_dctl_sec_cam_info_v2(struct rtw89_dev *rtwdev,
 					    DCTLINFO_V2_W4_SEC_KEY_ID);
 		h2c->m4 |= cpu_to_le32(DCTLINFO_V2_W4_SEC_KEY_ID);
 	}
+
+	if (!is_mld)
+		return;
+
+	if (rtwvif_link->net_type == RTW89_NET_TYPE_INFRA) {
+		mld_sma = rtwvif->mac_addr;
+		mld_tma = vif->cfg.ap_addr;
+		mld_bssid = vif->cfg.ap_addr;
+	} else if (rtwvif_link->net_type == RTW89_NET_TYPE_AP_MODE && sta) {
+		mld_sma = rtwvif->mac_addr;
+		mld_tma = sta->addr;
+		mld_bssid = rtwvif->mac_addr;
+	} else {
+		return;
+	}
+
+	h2c->w8 = le32_encode_bits(mld_sma[0], DCTLINFO_V2_W8_MLD_SMA_0) |
+		  le32_encode_bits(mld_sma[1], DCTLINFO_V2_W8_MLD_SMA_1) |
+		  le32_encode_bits(mld_sma[2], DCTLINFO_V2_W8_MLD_SMA_2) |
+		  le32_encode_bits(mld_sma[3], DCTLINFO_V2_W8_MLD_SMA_3);
+	h2c->m8 = cpu_to_le32(DCTLINFO_V2_W8_ALL);
+
+	h2c->w9 = le32_encode_bits(mld_sma[4], DCTLINFO_V2_W9_MLD_SMA_4) |
+		  le32_encode_bits(mld_sma[5], DCTLINFO_V2_W9_MLD_SMA_5) |
+		  le32_encode_bits(mld_tma[0], DCTLINFO_V2_W9_MLD_TMA_0) |
+		  le32_encode_bits(mld_tma[1], DCTLINFO_V2_W9_MLD_TMA_1);
+	h2c->m9 = cpu_to_le32(DCTLINFO_V2_W9_ALL);
+
+	h2c->w10 = le32_encode_bits(mld_tma[2], DCTLINFO_V2_W10_MLD_TMA_2) |
+		   le32_encode_bits(mld_tma[3], DCTLINFO_V2_W10_MLD_TMA_3) |
+		   le32_encode_bits(mld_tma[4], DCTLINFO_V2_W10_MLD_TMA_4) |
+		   le32_encode_bits(mld_tma[5], DCTLINFO_V2_W10_MLD_TMA_5);
+	h2c->m10 = cpu_to_le32(DCTLINFO_V2_W10_ALL);
+
+	h2c->w11 = le32_encode_bits(mld_bssid[0], DCTLINFO_V2_W11_MLD_BSSID_0) |
+		   le32_encode_bits(mld_bssid[1], DCTLINFO_V2_W11_MLD_BSSID_1) |
+		   le32_encode_bits(mld_bssid[2], DCTLINFO_V2_W11_MLD_BSSID_2) |
+		   le32_encode_bits(mld_bssid[3], DCTLINFO_V2_W11_MLD_BSSID_3);
+	h2c->m11 = cpu_to_le32(DCTLINFO_V2_W11_ALL);
+
+	h2c->w12 = le32_encode_bits(mld_bssid[4], DCTLINFO_V2_W12_MLD_BSSID_4) |
+		   le32_encode_bits(mld_bssid[5], DCTLINFO_V2_W12_MLD_BSSID_5);
+	h2c->m12 = cpu_to_le32(DCTLINFO_V2_W12_ALL);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index a6f72edd30fe..3134ebf08825 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -514,16 +514,28 @@ struct rtw89_h2c_dctlinfo_ud_v2 {
 #define DCTLINFO_V2_W7_SEC_ENT7 GENMASK(23, 16)
 #define DCTLINFO_V2_W7_SEC_ENT8 GENMASK(31, 24)
 #define DCTLINFO_V2_W7_ALL GENMASK(31, 0)
-#define DCTLINFO_V2_W8_MLD_SMA_L_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W8_MLD_SMA_0 GENMASK(7, 0)
+#define DCTLINFO_V2_W8_MLD_SMA_1 GENMASK(15, 8)
+#define DCTLINFO_V2_W8_MLD_SMA_2 GENMASK(23, 16)
+#define DCTLINFO_V2_W8_MLD_SMA_3 GENMASK(31, 24)
 #define DCTLINFO_V2_W8_ALL GENMASK(31, 0)
-#define DCTLINFO_V2_W9_MLD_SMA_H_V1 GENMASK(15, 0)
-#define DCTLINFO_V2_W9_MLD_TMA_L_V1 GENMASK(31, 16)
+#define DCTLINFO_V2_W9_MLD_SMA_4 GENMASK(7, 0)
+#define DCTLINFO_V2_W9_MLD_SMA_5 GENMASK(15, 8)
+#define DCTLINFO_V2_W9_MLD_TMA_0 GENMASK(23, 16)
+#define DCTLINFO_V2_W9_MLD_TMA_1 GENMASK(31, 24)
 #define DCTLINFO_V2_W9_ALL GENMASK(31, 0)
-#define DCTLINFO_V2_W10_MLD_TMA_H_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W10_MLD_TMA_2 GENMASK(7, 0)
+#define DCTLINFO_V2_W10_MLD_TMA_3 GENMASK(15, 8)
+#define DCTLINFO_V2_W10_MLD_TMA_4 GENMASK(23, 16)
+#define DCTLINFO_V2_W10_MLD_TMA_5 GENMASK(31, 24)
 #define DCTLINFO_V2_W10_ALL GENMASK(31, 0)
-#define DCTLINFO_V2_W11_MLD_TA_BSSID_L_V1 GENMASK(31, 0)
+#define DCTLINFO_V2_W11_MLD_BSSID_0 GENMASK(7, 0)
+#define DCTLINFO_V2_W11_MLD_BSSID_1 GENMASK(15, 8)
+#define DCTLINFO_V2_W11_MLD_BSSID_2 GENMASK(23, 16)
+#define DCTLINFO_V2_W11_MLD_BSSID_3 GENMASK(31, 24)
 #define DCTLINFO_V2_W11_ALL GENMASK(31, 0)
-#define DCTLINFO_V2_W12_MLD_TA_BSSID_H_V1 GENMASK(15, 0)
+#define DCTLINFO_V2_W12_MLD_BSSID_4 GENMASK(7, 0)
+#define DCTLINFO_V2_W12_MLD_BSSID_5 GENMASK(15, 8)
 #define DCTLINFO_V2_W12_ALL GENMASK(15, 0)
 
 int rtw89_cam_init(struct rtw89_dev *rtwdev, struct rtw89_vif_link *vif);
-- 
2.25.1


