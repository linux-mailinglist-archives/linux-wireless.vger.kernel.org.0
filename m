Return-Path: <linux-wireless+bounces-28959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4FC5B794
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:07:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3452A357550
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D135E2E0B5A;
	Fri, 14 Nov 2025 06:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sU5Jm9he"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F04C2DF12D
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100192; cv=none; b=VZKGZBzHj9z+A7HM9GZWj2HJhTzdxj8aZZjfZQzlC34mImvL1L6VqL4QBTMxH7gcOJjyFEfgcW67uoZpq3k89yzfJ9WffhUGNcYxlvcwcGqP9F9ObVv1fjfNW/4Cw4otPlo5PUoRlNSOjYoAtmKRHWLr3GA3ijo3LCkWPe1fzlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100192; c=relaxed/simple;
	bh=y9v5nOBReEAm+KpQHcA0wWTOS25uCUp+s2tFU6w7pwM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eCR302ocKnThIQ+kq82zpuyXblWgN5DmIc0Jc32scbdYpBT4h6gfIlRKUIsH2LnGQlnXpAhrqZRskOui/a84bhv6U21as6y7WzIWNNrOXcifXeYvPQ6tu/JcAiqJz8tK9ifgi7Fk597tw4C2GW5VJJ7zoc/DHEfAsNSl1x9sSFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sU5Jm9he; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE638iO41038325, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100188; bh=UuPRDsye3GfAQBYgjgCXCTWLn1BVRZLjJzrascjzHAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=sU5Jm9he/GGyQruekQqhtrVHKyMw+RLjTrXw/mVwVbm7IqZ5sJS56AlkHeyZl5vUi
	 sCMtKv957Kl/xRa2pyr/IJSSuSnlaQjeashU3VxgjEwjCPwWz5oEq0xYc9cLzhlVd3
	 w4pXtfCsW26e1Gub/vsaYDkMc/mzqfucCak4JwSo1iPJpD1gQpvmW9Qav3jITjevM7
	 83+wJK6NUfNg3wyKr98lLZ1s7E0VQgZb7uRCz/Odxk5oFZToWlugbX5hvx1rW3/qUl
	 ugSuMvXkdHB/wcelzinPzcKkXvCjKJo2X1cFJDGIxznmpPEf2RWz9rK4KXwyBatu6V
	 AsXO+N1N//rTg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE638iO41038325
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:03:08 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:03:08 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:03:08 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:03:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 12/14] wifi: rtw89: add addr cam H2C command v1
Date: Fri, 14 Nov 2025 14:01:26 +0800
Message-ID: <20251114060128.35363-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The coming RTL8922D uses different format of address CAM command, so add
the new format accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/cam.c      | 39 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/cam.h      | 11 ++++++
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 9 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 8233d91024e8..5f282a02a356 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -819,12 +819,15 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	struct rtw89_addr_cam_entry *addr_cam =
 		rtw89_get_addr_cam_of(rtwvif_link, rtwsta_link);
 	struct ieee80211_sta *sta = rtwsta_link_to_sta_safe(rtwsta_link);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_link_sta *link_sta;
 	const u8 *sma = scan_mac_addr ? scan_mac_addr : rtwvif_link->mac_addr;
 	u8 sma_hash, tma_hash, addr_msk_start;
+	u8 ver = chip->addrcam_ver;
 	u8 sma_start = 0;
 	u8 tma_start = 0;
 	const u8 *tma;
+	u8 mac_id;
 
 	rcu_read_lock();
 
@@ -845,9 +848,17 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 	sma_hash = rtw89_cam_addr_hash(sma_start, sma);
 	tma_hash = rtw89_cam_addr_hash(tma_start, tma);
 
-	h2c->w1 = le32_encode_bits(addr_cam->addr_cam_idx, ADDR_CAM_W1_IDX) |
-		  le32_encode_bits(addr_cam->offset, ADDR_CAM_W1_OFFSET) |
-		  le32_encode_bits(addr_cam->len, ADDR_CAM_W1_LEN);
+	mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
+
+	if (ver == 0)
+		h2c->w1 = le32_encode_bits(addr_cam->addr_cam_idx, ADDR_CAM_W1_IDX) |
+			  le32_encode_bits(addr_cam->offset, ADDR_CAM_W1_OFFSET) |
+			  le32_encode_bits(addr_cam->len, ADDR_CAM_W1_LEN);
+	else
+		h2c->w1 = le32_encode_bits(addr_cam->addr_cam_idx, ADDR_CAM_W1_V1_IDX) |
+			  le32_encode_bits(addr_cam->offset, ADDR_CAM_W1_V1_OFFSET) |
+			  le32_encode_bits(addr_cam->len, ADDR_CAM_W1_V1_LEN);
+
 	h2c->w2 = le32_encode_bits(addr_cam->valid, ADDR_CAM_W2_VALID) |
 		  le32_encode_bits(rtwvif_link->net_type, ADDR_CAM_W2_NET_TYPE) |
 		  le32_encode_bits(rtwvif_link->bcn_hit_cond, ADDR_CAM_W2_BCN_HIT_COND) |
@@ -870,14 +881,20 @@ void rtw89_cam_fill_addr_cam_info(struct rtw89_dev *rtwdev,
 		  le32_encode_bits(tma[3], ADDR_CAM_W6_TMA3) |
 		  le32_encode_bits(tma[4], ADDR_CAM_W6_TMA4) |
 		  le32_encode_bits(tma[5], ADDR_CAM_W6_TMA5);
-	h2c->w8 = le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_PORT_INT) |
-		  le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_TSF_SYNC) |
-		  le32_encode_bits(rtwvif_link->trigger, ADDR_CAM_W8_TF_TRS) |
-		  le32_encode_bits(rtwvif_link->lsig_txop, ADDR_CAM_W8_LSIG_TXOP) |
-		  le32_encode_bits(rtwvif_link->tgt_ind, ADDR_CAM_W8_TGT_IND) |
-		  le32_encode_bits(rtwvif_link->frm_tgt_ind, ADDR_CAM_W8_FRM_TGT_IND) |
-		  le32_encode_bits(rtwsta_link ? rtwsta_link->mac_id :
-						 rtwvif_link->mac_id, ADDR_CAM_W8_MACID);
+	if (ver == 0)
+		h2c->w8 = le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_PORT_INT) |
+			  le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_TSF_SYNC) |
+			  le32_encode_bits(rtwvif_link->trigger, ADDR_CAM_W8_TF_TRS) |
+			  le32_encode_bits(rtwvif_link->lsig_txop, ADDR_CAM_W8_LSIG_TXOP) |
+			  le32_encode_bits(rtwvif_link->tgt_ind, ADDR_CAM_W8_TGT_IND) |
+			  le32_encode_bits(rtwvif_link->frm_tgt_ind, ADDR_CAM_W8_FRM_TGT_IND) |
+			  le32_encode_bits(mac_id, ADDR_CAM_W8_MACID);
+	else
+		h2c->w8 = le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_V1_PORT_INT) |
+			  le32_encode_bits(rtwvif_link->port, ADDR_CAM_W8_V1_TSF_SYNC) |
+			  le32_encode_bits(rtwvif_link->trigger, ADDR_CAM_W8_V1_TF_TRS) |
+			  le32_encode_bits(rtwvif_link->lsig_txop, ADDR_CAM_W8_V1_LSIG_TXOP) |
+			  le32_encode_bits(mac_id, ADDR_CAM_W8_V1_MACID);
 
 	if (rtwvif_link->net_type == RTW89_NET_TYPE_INFRA)
 		h2c->w9 = le32_encode_bits(vif->cfg.aid & 0xfff, ADDR_CAM_W9_AID12);
diff --git a/drivers/net/wireless/realtek/rtw89/cam.h b/drivers/net/wireless/realtek/rtw89/cam.h
index 2bc8fbf79c0b..833a956f0176 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.h
+++ b/drivers/net/wireless/realtek/rtw89/cam.h
@@ -33,6 +33,9 @@ struct rtw89_h2c_addr_cam {
 #define ADDR_CAM_W1_IDX GENMASK(7, 0)
 #define ADDR_CAM_W1_OFFSET GENMASK(15, 8)
 #define ADDR_CAM_W1_LEN GENMASK(23, 16)
+#define ADDR_CAM_W1_V1_IDX GENMASK(9, 0)
+#define ADDR_CAM_W1_V1_OFFSET GENMASK(23, 16)
+#define ADDR_CAM_W1_V1_LEN GENMASK(31, 24)
 #define ADDR_CAM_W2_VALID BIT(0)
 #define ADDR_CAM_W2_NET_TYPE GENMASK(2, 1)
 #define ADDR_CAM_W2_BCN_HIT_COND GENMASK(4, 3)
@@ -62,6 +65,14 @@ struct rtw89_h2c_addr_cam {
 #define ADDR_CAM_W8_LSIG_TXOP BIT(15)
 #define ADDR_CAM_W8_TGT_IND GENMASK(26, 24)
 #define ADDR_CAM_W8_FRM_TGT_IND GENMASK(29, 27)
+#define ADDR_CAM_W8_V1_MACID GENMASK(9, 0)
+#define ADDR_CAM_W8_V1_PORT_INT GENMASK(18, 16)
+#define ADDR_CAM_W8_V1_TSF_SYNC GENMASK(21, 19)
+#define ADDR_CAM_W8_V1_TF_TRS BIT(22)
+#define ADDR_CAM_W8_V1_LSIG_TXOP BIT(23)
+#define ADDR_CAM_W8_V1_TB_RANGING BIT(24)
+#define ADDR_CAM_W8_V1_TB_SENSING BIT(25)
+#define ADDR_CAM_W8_V1_SENS_EN BIT(26)
 #define ADDR_CAM_W9_AID12 GENMASK(11, 0)
 #define ADDR_CAM_W9_AID12_0 GENMASK(7, 0)
 #define ADDR_CAM_W9_AID12_1 GENMASK(11, 8)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1f99d5f264d2..c33ff7c0090f 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4458,6 +4458,7 @@ struct rtw89_chip_info {
 	u8 bacam_num;
 	u8 bacam_dynamic_num;
 	enum rtw89_bacam_ver bacam_ver;
+	u8 addrcam_ver;
 	u8 ppdu_max_usr;
 
 	u8 sec_ctrl_efuse_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 2019f6022cbb..84b628d23882 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2648,6 +2648,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.addrcam_ver		= 0,
 	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 48205aa4a980..8677723e3561 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2334,6 +2334,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.addrcam_ver		= 0,
 	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 38cd151f8c3f..70fb05bc5e98 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -959,6 +959,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.addrcam_ver		= 0,
 	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 15ba780492d6..f956474c3b72 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -818,6 +818,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.bacam_num		= 2,
 	.bacam_dynamic_num	= 4,
 	.bacam_ver		= RTW89_BACAM_V0,
+	.addrcam_ver		= 0,
 	.ppdu_max_usr		= 4,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ee81a6792eee..db99450e9158 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3178,6 +3178,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.bacam_num		= 8,
 	.bacam_dynamic_num	= 8,
 	.bacam_ver		= RTW89_BACAM_V0_EXT,
+	.addrcam_ver		= 0,
 	.ppdu_max_usr		= 8,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 11e8b50a3291..4437279c554b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2931,6 +2931,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.bacam_num		= 24,
 	.bacam_dynamic_num	= 8,
 	.bacam_ver		= RTW89_BACAM_V1,
+	.addrcam_ver		= 0,
 	.ppdu_max_usr		= 16,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 0x1300,
-- 
2.25.1


