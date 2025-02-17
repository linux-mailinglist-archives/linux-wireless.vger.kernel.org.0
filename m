Return-Path: <linux-wireless+bounces-19033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBAA37B61
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DF003A6B3A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE79C18DB30;
	Mon, 17 Feb 2025 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rP4R/36m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA4B18F2C3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773902; cv=none; b=iUpZB5iVsfBpq8fM1iD648rKDc7m89nyhdP08obUcQkBjAI714rwI/ZsTZ3kw96quUsF9Ioer0O1zjSoO/a/88sJFA62W0Dht1rtD65qbztIODYXOk+iRAZstjDBD+v7IAFiC+IITcRi72ri3mLcMYTUqUXlFLtoHCvyNUikHg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773902; c=relaxed/simple;
	bh=PW2v35eLkeIS8+rXee34LTk8aFFLZyhoO2rIykFjv58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnIwct5LK5vCcedRiu5lBI9elFWiahBnSZ7NrvsGjNp2/idhTTIMbqyb989p4MtSA8jbKxgwSEQSmuY4N5mMHKC0RukEDeSBa3uwFzINjSdKbymmbP+cc0kln2uPsi2+kDj509TGldhAEz7f1IbfyySenVkj0Hnn79yE+GAfPqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rP4R/36m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6VbE122636807, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739773897; bh=PW2v35eLkeIS8+rXee34LTk8aFFLZyhoO2rIykFjv58=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=rP4R/36mAhH6dIjo5Jg9gd2PbvF62qaCr53neH+Yqwf9xjZgAWfayMXIrrW0NV2Z/
	 Fpx8hGNBqmJVH4M0FBHxnahTes26kfsDGmPGnkdPdKlNT4b+8qmGI59f/wTJ91Q9GF
	 8UiDmCOCnvvtIhAHAN0enE9XfJ28rJ12BE8YsjpqRZEb9Dv5XmOgNZr87ZVxy1y0+I
	 OvHEgUkE8NsVUKa1v+lqWdYGR56J1jNVRnCRodbZgKEUsJUvyaWhPdJ53vbysphtev
	 ZpHs1THPvJdY3KIe9tGcEY8bB5qM3qAhHpWlNEJZlfIG7Scznl5k9HGHbAADQPbWS5
	 Oon6tXQEhfs7g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6VbE122636807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:31:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:31:38 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:31:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: add H2C command of TX time for WiFi 7 chips
Date: Mon, 17 Feb 2025 14:30:53 +0800
Message-ID: <20250217063053.38936-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217063053.38936-1-pkshih@realtek.com>
References: <20250217063053.38936-1-pkshih@realtek.com>
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

BT-coexistence configure WiFi TX time to share time slots with Bluetooth
devices. Since the format is different from WiFi 6 chips, add the new
format accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 55 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 11 ++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 10 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b3fdd8eded21..057cb7a3766a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3676,6 +3676,8 @@ struct rtw89_chip_ops {
 	int (*h2c_ampdu_cmac_tbl)(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  struct rtw89_sta_link *rtwsta_link);
+	int (*h2c_txtime_cmac_tbl)(struct rtw89_dev *rtwdev,
+				   struct rtw89_sta_link *rtwsta_link);
 	int (*h2c_default_dmac_tbl)(struct rtw89_dev *rtwdev,
 				    struct rtw89_vif_link *rtwvif_link,
 				    struct rtw89_sta_link *rtwsta_link);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 35b86970db2a..0529424e70f6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3573,6 +3573,61 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_txtime_cmac_tbl);
+
+int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_h2c_cctlinfo_ud_g7 *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for txtime_cmac_g7\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_g7 *)skb->data;
+
+	h2c->c0 = le32_encode_bits(rtwsta_link->mac_id, CCTLINFO_G7_C0_MACID) |
+		  le32_encode_bits(1, CCTLINFO_G7_C0_OP);
+
+	if (rtwsta_link->cctl_tx_time) {
+		h2c->w3 |= le32_encode_bits(1, CCTLINFO_G7_W3_AMPDU_TIME_SEL);
+		h2c->m3 |= cpu_to_le32(CCTLINFO_G7_W3_AMPDU_TIME_SEL);
+
+		h2c->w2 |= le32_encode_bits(rtwsta_link->ampdu_max_time,
+					   CCTLINFO_G7_W2_AMPDU_MAX_TIME);
+		h2c->m2 |= cpu_to_le32(CCTLINFO_G7_W2_AMPDU_MAX_TIME);
+	}
+	if (rtwsta_link->cctl_tx_retry_limit) {
+		h2c->w2 |= le32_encode_bits(1, CCTLINFO_G7_W2_DATA_TXCNT_LMT_SEL) |
+			   le32_encode_bits(rtwsta_link->data_tx_cnt_lmt,
+					    CCTLINFO_G7_W2_DATA_TX_CNT_LMT);
+		h2c->m2 |= cpu_to_le32(CCTLINFO_G7_W2_DATA_TXCNT_LMT_SEL |
+				       CCTLINFO_G7_W2_DATA_TX_CNT_LMT);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_txtime_cmac_tbl_g7);
 
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 994d109a9c3c..53a4083ba128 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4588,6 +4588,8 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
@@ -4869,6 +4871,15 @@ static inline int rtw89_chip_h2c_ampdu_cmac_tbl(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static inline
+int rtw89_chip_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
+				   struct rtw89_sta_link *rtwsta_link)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
+}
+
 static inline
 int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0b2e4ad52774..513c317b286c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6441,7 +6441,7 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 
 	if (rtwsta_link->cctl_tx_time) {
 		rtwsta_link->ampdu_max_time = (max_tx_time - 512) >> 9;
-		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
+		ret = rtw89_chip_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
 	} else {
 		ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 		if (ret) {
@@ -6507,9 +6507,9 @@ int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
 
 	if (!resume) {
 		rtwsta_link->cctl_tx_retry_limit = true;
-		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
+		ret = rtw89_chip_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
 	} else {
-		ret = rtw89_fw_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
+		ret = rtw89_chip_h2c_txtime_cmac_tbl(rtwdev, rtwsta_link);
 		rtwsta_link->cctl_tx_retry_limit = false;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 82289dbad1f4..3ef07d80caf1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2423,6 +2423,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2046832d021f..bcd71d6fce29 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2149,6 +2149,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 652914a36245..2ef534b4e951 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -776,6 +776,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 6f15245b2f74..8f2dccc07bb5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -710,6 +710,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ecc1ff358583..5876b1e8bb6b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2941,6 +2941,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_ampdu_cmac_tbl	= NULL,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl,
 	.h2c_default_dmac_tbl	= NULL,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 898a65a721dc..f3661eb894dc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2702,6 +2702,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl_g7,
 	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
 	.h2c_ampdu_cmac_tbl	= rtw89_fw_h2c_ampdu_cmac_tbl_g7,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl_g7,
 	.h2c_default_dmac_tbl	= rtw89_fw_h2c_default_dmac_tbl_v2,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
-- 
2.25.1


