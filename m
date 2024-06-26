Return-Path: <linux-wireless+bounces-9566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6465991762C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C721F22362
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD86134DE;
	Wed, 26 Jun 2024 02:31:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071212B77
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 02:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369107; cv=none; b=RRRTI4hbhaS0el7pT84P5zjGHJItzq3GVgNWz2QxOwuGbXo+ayRAu7UIIpWSwsexESV2r6PgKQA2fm5rmkCH6U5bWtyd13/dHPSShMdydEjO1r5re1WiV7zDpONe+4VKGIMBpiPySQbfUw7hTqzWVtp/nrMpQpqZliWDVXXqgXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369107; c=relaxed/simple;
	bh=GUjkSLSH2NHPSjJc4WOWHBZm9vH6CVlF2+c/FrJ/MLM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqyZ6WbQfiPFpySlXss82gGPLqPEPMG3RGQZSR1okl5ujPaUeP7R/LhDymlp3xrbyBom6+5KcrVw/pOb52Lku3wD4JwZ7Rt4aAY1mfucX7ieQqlFg5Mo3GEnq+BbrRXilqVPIDhfX+0rUDUrJGD+u4eFzQFmXEenFtEvspJ8lRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45Q2VeaeE875884, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45Q2VeaeE875884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 10:31:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 10:31:40 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Jun
 2024 10:31:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH] wifi: rtw89: coex: Add coexistence policy for hardware scan
Date: Wed, 26 Jun 2024 10:31:29 +0800
Message-ID: <20240626023129.7776-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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

From: Ching-Te Ku <ku920601@realtek.com>

Add additional policy option to let Bluetooth audio can play well
during Wi-Fi is hardware scanning.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 26 ++++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index d8fc93318a51..24929ef534e0 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -91,7 +91,7 @@ static const struct rtw89_btc_fbtc_slot s_def[] = {
 	[CXST_BLK]	= __DEF_FBTC_SLOT(500, 0x55555555, SLOT_MIX),
 	[CXST_E2G]	= __DEF_FBTC_SLOT(0,   0xea5a5a5a, SLOT_MIX),
 	[CXST_E5G]	= __DEF_FBTC_SLOT(0,   0xffffffff, SLOT_ISO),
-	[CXST_EBT]	= __DEF_FBTC_SLOT(0,   0xe5555555, SLOT_MIX),
+	[CXST_EBT]	= __DEF_FBTC_SLOT(5,   0xe5555555, SLOT_MIX),
 	[CXST_ENULL]	= __DEF_FBTC_SLOT(0,   0xaaaaaaaa, SLOT_ISO),
 	[CXST_WLK]	= __DEF_FBTC_SLOT(250, 0xea5a5a5a, SLOT_MIX),
 	[CXST_W1FDD]	= __DEF_FBTC_SLOT(50,  0xffffffff, SLOT_ISO),
@@ -3617,6 +3617,7 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	u8 type, null_role;
 	u32 tbl_w1, tbl_b1, tbl_b4;
+	u16 dur_2;
 
 	type = FIELD_GET(BTC_CXP_MASK, policy_type);
 
@@ -3727,7 +3728,21 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 		if (hid->exist || hfp->exist)
 			tbl_w1 = cxtbl[16];
 
+		dur_2 = dm->e2g_slot_limit;
+
 		switch (policy_type) {
+		case BTC_CXP_OFFE_2GBWISOB: /* for normal-case */
+			_slot_set(btc, CXST_E2G, 0, tbl_w1, SLOT_ISO);
+			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
+			break;
+		case BTC_CXP_OFFE_2GISOB: /* for bt no-link */
+			_slot_set(btc, CXST_E2G, 0, cxtbl[1], SLOT_ISO);
+			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+				     s_def[CXST_EBT].cxtbl, s_def[CXST_EBT].cxtype);
+			_slot_set_dur(btc, CXST_EBT, dur_2);
+			break;
 		case BTC_CXP_OFFE_DEF:
 			_slot_set_le(btc, CXST_E2G, s_def[CXST_E2G].dur,
 				     s_def[CXST_E2G].cxtbl, s_def[CXST_E2G].cxtype);
@@ -3747,6 +3762,15 @@ void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type)
 			_slot_set_le(btc, CXST_ENULL, s_def[CXST_ENULL].dur,
 				     s_def[CXST_ENULL].cxtbl, s_def[CXST_ENULL].cxtype);
 			break;
+		case BTC_CXP_OFFE_2GBWMIXB:
+			_slot_set(btc, CXST_E2G, 0, 0x55555555, SLOT_MIX);
+			_slot_set_le(btc, CXST_EBT, s_def[CXST_EBT].dur,
+				     cpu_to_le32(0x55555555), s_def[CXST_EBT].cxtype);
+			break;
+		case BTC_CXP_OFFE_WL: /* for 4-way */
+			_slot_set(btc, CXST_E2G, 0, cxtbl[1], SLOT_MIX);
+			_slot_set(btc, CXST_EBT, 0, cxtbl[1], SLOT_MIX);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index e8ec0246bccd..b55071f21a53 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1330,6 +1330,7 @@ struct rtw89_btc_wl_smap {
 	u32 scan: 1;
 	u32 connecting: 1;
 	u32 roaming: 1;
+	u32 dbccing: 1;
 	u32 transacting: 1;
 	u32 _4way: 1;
 	u32 rf_off: 1;
-- 
2.25.1


