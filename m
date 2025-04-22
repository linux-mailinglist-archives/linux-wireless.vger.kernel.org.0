Return-Path: <linux-wireless+bounces-21806-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB5A95AA0
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D467F3B5121
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7385D1624EA;
	Tue, 22 Apr 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="smhSU5QR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19D810957
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286425; cv=none; b=HhFtTXN9u/aCJhXMiChMjsytnCKW8IoOJn5EIwxjxpVCd34qlYacdl92Sdkb+uU/vODPocI2yqli+kC98Ad0PHhDjJG993zlC8uaBb1HP72WaI0/22ZGZ8JLR91hJY4txLWSo5FIpEBYSkB2nuooduDXOrWWnKNjDuK3mgFCmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286425; c=relaxed/simple;
	bh=w6HQrkcDmydXV0AYgXdNap+WcemoxjhHCsYoSWczS5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjGOyPbPuJ8NVdl0aRCxAPTd6Suu8HrfykhMp2Lq4wEVWAQZHvmmmsGJ5EjyClSU+gd7yu2X7PVu6pnhlmrxMoO3weF+ERA/BmDNwTfwEwfBr8934tzXrwP2CPFlGVFKwvkSimyc9Bn2PXhZ8PUhJVx9BWqpIjsbTIglqHsXfeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=smhSU5QR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1l0oqD3859488, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286420; bh=w6HQrkcDmydXV0AYgXdNap+WcemoxjhHCsYoSWczS5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=smhSU5QRe3bUYNEYD4124qRY/3pt17lr6BFiBze1n/gp8gQvM+857tqO9glw8PUkj
	 rl/c+eca6kfcpjhcW4+sR6f40Pk/c+6UltQU94KaQwgfVyB7uD6kN+MiaUNPEVkvgh
	 9vE8Xm7eC0MCfm9pYaNf6p5C9S8zNpTwnIM0pR/pyF9mrGWeKvekgjPeaHHDxoGzdv
	 yZ5yoDS9hqMG53X5tg7Qn3YgHeDwb2shHObzFevgW7jTOKRfXgbGsoH6fhOqUVzjlL
	 6WAJk1pVhHCzs7pu6K/pj1SBnY9D2hNXoi6G7I6kVzzMcyNwXbegKP347l8cGhB7PK
	 rZs5qneZZOloQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1l0oqD3859488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:00 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:46:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: 8922a: increase beacon loss to 6 seconds
Date: Tue, 22 Apr 2025 09:46:09 +0800
Message-ID: <20250422014620.18421-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Intermittent beacon loss from specific AP triggers disconnection
and reconnection. Increasing the beacon loss count will make the
connection more stable.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 12 +++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  5 +++--
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d49e06f81ba4..68c8bcee2832 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4495,6 +4495,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_LPS_CH_INFO,
 	RTW89_FW_FEATURE_NO_PHYCAP_P1,
 	RTW89_FW_FEATURE_NO_POWER_DIFFERENCE,
+	RTW89_FW_FEATURE_BEACON_LOSS_COUNT_V1,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 16499fce94cc..10cffc8ab7b5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -850,6 +850,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 49, 0, RFK_PRE_NOTIFY_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 71, 0, BEACON_LOSS_COUNT_V1),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -4339,6 +4340,7 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 	struct rtw89_h2c_bcnfltr *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
+	u8 max_cnt, cnt;
 	int ret;
 
 	if (!RTW89_CHK_FW_FEATURE(BEACON_FILTER, &rtwdev->fw))
@@ -4367,12 +4369,20 @@ int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 	skb_put(skb, len);
 	h2c = (struct rtw89_h2c_bcnfltr *)skb->data;
 
+	if (RTW89_CHK_FW_FEATURE(BEACON_LOSS_COUNT_V1, &rtwdev->fw))
+		max_cnt = BIT(7) - 1;
+	else
+		max_cnt = BIT(4) - 1;
+
+	cnt = min(RTW89_BCN_LOSS_CNT, max_cnt);
+
 	h2c->w0 = le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_RSSI) |
 		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_BCN) |
 		  le32_encode_bits(connect, RTW89_H2C_BCNFLTR_W0_MON_EN) |
 		  le32_encode_bits(RTW89_BCN_FLTR_OFFLOAD_MODE_DEFAULT,
 				   RTW89_H2C_BCNFLTR_W0_MODE) |
-		  le32_encode_bits(RTW89_BCN_LOSS_CNT, RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT) |
+		  le32_encode_bits(cnt >> 4, RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT_H3) |
+		  le32_encode_bits(cnt & 0xf, RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT_L4) |
 		  le32_encode_bits(hyst, RTW89_H2C_BCNFLTR_W0_RSSI_HYST) |
 		  le32_encode_bits(thold + MAX_RSSI,
 				   RTW89_H2C_BCNFLTR_W0_RSSI_THRESHOLD) |
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 55255b48bdb7..5ef948343912 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -333,7 +333,7 @@ struct rtw89_fw_macid_pause_sleep_grp {
 #define RTW89_SCAN_LIST_LIMIT_AX RTW89_SCAN_LIST_LIMIT(RTW89_MAC_CHINFO_SIZE)
 #define RTW89_SCAN_LIST_LIMIT_BE RTW89_SCAN_LIST_LIMIT(RTW89_MAC_CHINFO_SIZE_BE)
 
-#define RTW89_BCN_LOSS_CNT 10
+#define RTW89_BCN_LOSS_CNT 60
 
 struct rtw89_mac_chinfo {
 	u8 period;
@@ -3813,7 +3813,8 @@ struct rtw89_h2c_bcnfltr {
 #define RTW89_H2C_BCNFLTR_W0_MON_BCN BIT(1)
 #define RTW89_H2C_BCNFLTR_W0_MON_EN BIT(2)
 #define RTW89_H2C_BCNFLTR_W0_MODE GENMASK(4, 3)
-#define RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT GENMASK(11, 8)
+#define RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT_H3 GENMASK(7, 5)
+#define RTW89_H2C_BCNFLTR_W0_BCN_LOSS_CNT_L4 GENMASK(11, 8)
 #define RTW89_H2C_BCNFLTR_W0_RSSI_HYST GENMASK(15, 12)
 #define RTW89_H2C_BCNFLTR_W0_RSSI_THRESHOLD GENMASK(23, 16)
 #define RTW89_H2C_BCNFLTR_W0_MAC_ID GENMASK(31, 24)
-- 
2.25.1


