Return-Path: <linux-wireless+bounces-19032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6B1A37B60
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A94716BC4E
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4616D17BB35;
	Mon, 17 Feb 2025 06:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dciaLsVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287418DB30
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739773900; cv=none; b=cFqeaHP1cNBlD7iOgaBcmJbRJKUYA8eDz1JOpjBBDFODM9gsEPiVoP26zUEN+a2K6B5EAbvtncOAxEvSLFntCCIbi1qwJg9419eCbNm9+nlvt6nDtU2P+xxhxA7U++zM1yGrQfpu5bgOgWzwu5mTS6AncWqOC6jGs/czNUhSFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739773900; c=relaxed/simple;
	bh=6LlUH23kV7hxTX5Gra0Lqj1DcJKVcR5nIvPPWoJToLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NiB5ZFKPuUsm4rZK1yjSDHd7FZXHcGlmEDVy2ZsoSKbm40iQxIKHUbBeTCTAfkhqxUWlwi1A0eSXyAXtlp69MqBQzuosIJKwuchNirdS2EWn9dwT3FMgd2Ous9rRRZAh/UllYLTn+hxayAxDYMJ+hxQfEX5auApKD4gg4o3goSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dciaLsVR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6VXEX02636804, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739773893; bh=6LlUH23kV7hxTX5Gra0Lqj1DcJKVcR5nIvPPWoJToLE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dciaLsVRMs4I6fjmYk8GrDScZN1OmuFIIHoPCCrJVJY9ak+j3BA5HF0/todZsQnvH
	 RxExlSMTX/Z23rm1Kr9/bU0bd3TuhRC6ki+9dSn1dfLytXYoDZlIKP87Zicr2y/CEB
	 w4QcIp28lLU5O0HSlMgVmiPbPuhLO2CHyNGCfIXIbBWIWq+RjNCcrWB3U3PE/9ISj3
	 zx1/XRLpyealkLOUMKpAtTqbFd58GjbxU2C34NaBYdv0PfvA8d9kW+w+4iXh7jH9zx
	 1piMfV4yLO3i3B3bDhea+x5QgJO26LbsRZk1Yt2j1miTWqbb1m/3nWqDfHlYG9u2oS
	 ywhL80M/hZU8Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6VXEX02636804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:31:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:31:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:31:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: mac: define registers of agg_limit and txcnt_limit to share common flow
Date: Mon, 17 Feb 2025 14:30:52 +0800
Message-ID: <20250217063053.38936-2-pkshih@realtek.com>
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

The agg_limit and txcnt_limit are used by BT-coexistence to reduce
WiFi TX time at once to share time with Bluetooth devices. Since
these registers address are different from WiFi 6 and 7 chips, define
them accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 17 +++++++++++------
 drivers/net/wireless/realtek/rtw89/mac.h    |  2 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  2 ++
 drivers/net/wireless/realtek/rtw89/reg.h    |  7 +++++++
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 3f38f8ed6876..0b2e4ad52774 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6433,6 +6433,7 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 			u32 tx_time)
 {
 #define MAC_AX_DFLT_TX_TIME 5280
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 max_tx_time = tx_time == 0 ? MAC_AX_DFLT_TX_TIME : tx_time;
 	u32 reg;
@@ -6448,8 +6449,8 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_
 			return ret;
 		}
 
-		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AMPDU_AGG_LIMIT, mac_idx);
-		rtw89_write32_mask(rtwdev, reg, B_AX_AMPDU_MAX_TIME_MASK,
+		reg = rtw89_mac_reg_by_idx(rtwdev, mac->agg_limit.addr, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, mac->agg_limit.mask,
 				   max_tx_time >> 5);
 	}
 
@@ -6475,6 +6476,7 @@ int rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwst
 int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link,
 			  u32 *tx_time)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 reg;
 	int ret = 0;
@@ -6488,8 +6490,8 @@ int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwst
 			return ret;
 		}
 
-		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AMPDU_AGG_LIMIT, mac_idx);
-		*tx_time = rtw89_read32_mask(rtwdev, reg, B_AX_AMPDU_MAX_TIME_MASK) << 5;
+		reg = rtw89_mac_reg_by_idx(rtwdev, mac->agg_limit.addr, mac_idx);
+		*tx_time = rtw89_read32_mask(rtwdev, reg, mac->agg_limit.mask) << 5;
 	}
 
 	return ret;
@@ -6517,6 +6519,7 @@ int rtw89_mac_set_tx_retry_limit(struct rtw89_dev *rtwdev,
 int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link, u8 *tx_retry)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u8 mac_idx = rtwsta_link->rtwvif_link->mac_idx;
 	u32 reg;
 	int ret = 0;
@@ -6530,8 +6533,8 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
-		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXCNT, mac_idx);
-		*tx_retry = rtw89_read32_mask(rtwdev, reg, B_AX_L_TXCNT_LMT_MASK);
+		reg = rtw89_mac_reg_by_idx(rtwdev, mac->txcnt_limit.addr, mac_idx);
+		*tx_retry = rtw89_read32_mask(rtwdev, reg, mac->txcnt_limit.mask);
 	}
 
 	return ret;
@@ -6809,6 +6812,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 		.mask = B_AX_RXTRIG_RU26_DIS,
 	},
 	.wow_ctrl = {.addr = R_AX_WOW_CTRL, .mask = B_AX_WOW_WOWEN,},
+	.agg_limit = {.addr = R_AX_AMPDU_AGG_LIMIT, .mask = B_AX_AMPDU_MAX_TIME_MASK,},
+	.txcnt_limit = {.addr = R_AX_TXCNT, .mask = B_AX_L_TXCNT_LMT_MASK,},
 
 	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.sys_init = sys_init_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 6389f54264e5..4d5a06a2fe9b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -964,6 +964,8 @@ struct rtw89_mac_gen_def {
 	struct rtw89_reg_def bfee_ctrl;
 	struct rtw89_reg_def narrow_bw_ru_dis;
 	struct rtw89_reg_def wow_ctrl;
+	struct rtw89_reg_def agg_limit;
+	struct rtw89_reg_def txcnt_limit;
 
 	int (*check_mac_en)(struct rtw89_dev *rtwdev, u8 band,
 			    enum rtw89_mac_hwmod_sel sel);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 16ee378c5418..dce0a4b01440 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2585,6 +2585,8 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 		.mask = B_BE_RXTRIG_RU26_DIS,
 	},
 	.wow_ctrl = {.addr = R_BE_WOW_CTRL, .mask = B_BE_WOW_WOWEN,},
+	.agg_limit = {.addr = R_BE_AMPDU_AGG_LIMIT, .mask = B_BE_AMPDU_MAX_TIME_MASK,},
+	.txcnt_limit = {.addr = R_BE_TXCNT, .mask = B_BE_L_TXCNT_LMT_MASK,},
 
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index c992835d4b63..ec06f5bd0fab 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6618,6 +6618,13 @@
 #define B_BE_RTS_LIMIT_IN_OFDM6 BIT(1)
 #define B_BE_CHECK_CCK_EN BIT(0)
 
+#define R_BE_TXCNT 0x1082C
+#define R_BE_TXCNT_C1 0x1482C
+#define B_BE_ADD_TXCNT_BY BIT(31)
+#define B_BE_TOTAL_TC_OPT BIT(30)
+#define B_BE_S_TXCNT_LMT_MASK GENMASK(29, 24)
+#define B_BE_L_TXCNT_LMT_MASK GENMASK(21, 16)
+
 #define R_BE_MBSSID_DROP_0 0x1083C
 #define R_BE_MBSSID_DROP_0_C1 0x1483C
 #define B_BE_GI_LTF_FB_SEL BIT(30)
-- 
2.25.1


