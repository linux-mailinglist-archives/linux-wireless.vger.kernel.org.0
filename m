Return-Path: <linux-wireless+bounces-10718-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1C094275F
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C1028410A
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 07:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4AB266AB;
	Wed, 31 Jul 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gFtGo7+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5F16CD03
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 07:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722409539; cv=none; b=jLIS1GlPZGToTG1U5GJco7FDQygeYbJzp+5chL3hcSYUE01xGcYYPQdJgeWMgBx6aEkfYIRa3y9lLSlHKhod36NvnQ9ztEpnDvbEv/8ev9labAE6ZPFwlFbPBElFR8CK5xmx062M9cKO6pV22eM9ysGlp4trN4aROIxWdjfcFIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722409539; c=relaxed/simple;
	bh=fT/KdMzIHkyaGZIssJjN2OQpqa9azjt6rGHBPLymRKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWuME8KwCMw/iJlQ6u9ADx4ztVXy4y93lLxOo1TwTmLmSGkXRaBsQVSaqclEb0Sg8IdGRiM6U9bc+hNPf8aRm4fae+cDsHQNz8X5QdQYADyf1m5JBFpx2bF1rLNU7RgynUuRAmbJI5AXbdnZSHNAwdxCsMZpyBSMB/jXh0MRciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gFtGo7+m; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46V75XsS42075369, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722409533; bh=fT/KdMzIHkyaGZIssJjN2OQpqa9azjt6rGHBPLymRKI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gFtGo7+mtIpUVlTq4dUQkvHj5WJHtBTnpPt3rNqFr12TgDkyORfSp3VBXVKNP9+Ar
	 zAjGRFlbQcDpI+DXCeYZGMXejBOnS7Jsv9msvWdM9YQPXpCpxd38fTs3ahz80iZ767
	 HHMeEwJhGxY4IMJQryromtsFGHb+/jopH6oR8oD+LJsaReZj2N3Nv0lXgpJhC6em5L
	 W3MdpKWiF6en290gTVnUEYIkMCVkwy7h7xzrtPksn/RAQ3fV1Jrze5PZmvVxz/N3+T
	 9wyqwMSy+FR+cCe5eeDk8qhqMp8g4ey0K/vMNJp/ZJRfT5grTdkmwNDWXu9MZguK22
	 P6uIl5B2yJaYA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46V75XsS42075369
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 15:05:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 15:05:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 31 Jul
 2024 15:05:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH 2/5] wifi: rtw89: 8922a: Add new fields for scan offload H2C command
Date: Wed, 31 Jul 2024 15:05:03 +0800
Message-ID: <20240731070506.46100-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240731070506.46100-1-pkshih@realtek.com>
References: <20240731070506.46100-1-pkshih@realtek.com>
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

Update scan offload H2C format to fit firmware version 35.21.
The new fields indicate lengths of variable length members, so
when driver and firmware are using mismatch version, FW could
handle the parsing better.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 22 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  7 +++++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  4 ++--
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 9e26763d3269..ba2ac5cefc50 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4357,6 +4357,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_LPS_PG,
 	RTW89_FW_FEATURE_BEACON_FILTER,
 	RTW89_FW_FEATURE_MACID_PAUSE_SLEEP,
+	RTW89_FW_FEATURE_SCAN_OFFLOAD_BE_V0,
 	RTW89_FW_FEATURE_WOW_REASON_V1,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fcbc7de48ddd..4c0a1aed6efd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -683,6 +683,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 21, 0, SCAN_OFFLOAD_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 12, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 22, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 31, 0, RFK_PRE_NOTIFY_V0),
@@ -4907,6 +4908,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	u8 macc_role_size = sizeof(*macc_role) * option->num_macc_role;
 	u8 opch_size = sizeof(*opch) * option->num_opch;
 	u8 probe_id[NUM_NL80211_BANDS];
+	u8 cfg_len = sizeof(*h2c);
 	unsigned int cond;
 	void *ptr;
 	int ret;
@@ -4915,7 +4917,7 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 
 	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
 
-	len = sizeof(*h2c) + macc_role_size + opch_size;
+	len = cfg_len + macc_role_size + opch_size;
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c scan offload\n");
@@ -4980,10 +4982,24 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 			  le32_encode_bits(RTW89_HW_RATE_OFDM6,
 					   RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ);
 	}
-	ptr += sizeof(*h2c);
+
+	if (RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD_BE_V0, &rtwdev->fw)) {
+		cfg_len = offsetofend(typeof(*h2c), w8);
+		goto flex_member;
+	}
+
+	h2c->w9 = le32_encode_bits(sizeof(*h2c) / sizeof(h2c->w0),
+				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG) |
+		  le32_encode_bits(sizeof(*macc_role) / sizeof(macc_role->w0),
+				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_MACC) |
+		  le32_encode_bits(sizeof(*opch) / sizeof(opch->w0),
+				   RTW89_H2C_SCANOFLD_BE_W9_SIZE_OP);
+
+flex_member:
+	ptr += cfg_len;
 
 	for (i = 0; i < option->num_macc_role; i++) {
-		macc_role = (struct rtw89_h2c_scanofld_be_macc_role *)&h2c->role[i];
+		macc_role = ptr;
 		macc_role->w0 =
 			le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_BAND) |
 			le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_PORT) |
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dccda3a12616..0b0c5b5c6bb9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2711,7 +2711,9 @@ struct rtw89_h2c_scanofld_be {
 	__le32 w6;
 	__le32 w7;
 	__le32 w8;
-	struct rtw89_h2c_scanofld_be_macc_role role[];
+	__le32 w9; /* Added after SCAN_OFFLOAD_BE_V1 */
+	/* struct rtw89_h2c_scanofld_be_macc_role (flexible number) */
+	/* struct rtw89_h2c_scanofld_be_opch (flexible number) */
 } __packed;
 
 #define RTW89_H2C_SCANOFLD_BE_W0_OP GENMASK(1, 0)
@@ -2742,6 +2744,9 @@ struct rtw89_h2c_scanofld_be {
 #define RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_2GHZ GENMASK(7, 0)
 #define RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_5GHZ GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_W8_PROBE_RATE_6GHZ GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_BE_W9_SIZE_CFG GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_W9_SIZE_MACC GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_W9_SIZE_OP GENMASK(23, 16)
 
 static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index e611534eeae1..747912736a2f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -13,10 +13,10 @@
 #include "rtw8922a_rfk.h"
 #include "util.h"
 
-#define RTW8922A_FW_FORMAT_MAX 0
+#define RTW8922A_FW_FORMAT_MAX 1
 #define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
 #define RTW8922A_MODULE_FIRMWARE \
-	RTW8922A_FW_BASENAME ".bin"
+	RTW8922A_FW_BASENAME "-" __stringify(RTW8922A_FW_FORMAT_MAX) ".bin"
 
 #define HE_N_USER_MAX_8922A 4
 
-- 
2.25.1


