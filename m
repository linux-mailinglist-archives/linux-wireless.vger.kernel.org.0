Return-Path: <linux-wireless+bounces-1581-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC4B826A67
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE605B2232A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9712B6A;
	Mon,  8 Jan 2024 09:13:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B2A12B71
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089DLrR43873331, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089DLrR43873331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:13:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 8 Jan 2024 17:13:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:13:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/10] wifi: rtw89: add new H2C command to pause/sleep transmitting by MAC ID
Date: Mon, 8 Jan 2024 17:13:15 +0800
Message-ID: <20240108091315.67358-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108091134.67007-1-pkshih@realtek.com>
References: <20240108091134.67007-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

New H2C command is introduced to pause/sleep transmitting. That extends
more bits to support more MAC ID, and currently we still configure 256
MAC ID at most.

This new command is always used by coming WiFi 7 chips, and existing
chips can use old or new command because firmware still preserves the old
one. Add a firmware feature flag to determine which command is adopted
according to firmware version.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 35 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   | 10 +++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2907674f2afc..87bf9cabc8af 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3899,6 +3899,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_DEEP_PS,
 	RTW89_FW_FEATURE_NO_LPS_PG,
 	RTW89_FW_FEATURE_BEACON_FILTER,
+	RTW89_FW_FEATURE_MACID_PAUSE_SLEEP,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 991c42c4e509..9d6748f65ba3 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -458,6 +458,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -2489,27 +2490,49 @@ int rtw89_fw_h2c_notify_dbcc(struct rtw89_dev *rtwdev, bool en)
 int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 			     bool pause)
 {
+	struct rtw89_fw_macid_pause_sleep_grp *h2c_new;
 	struct rtw89_fw_macid_pause_grp *h2c;
 	__le32 set = cpu_to_le32(BIT(sh));
-	u8 len = sizeof(*h2c);
+	u8 h2c_macid_pause_id;
 	struct sk_buff *skb;
+	u32 len;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(MACID_PAUSE_SLEEP, &rtwdev->fw)) {
+		h2c_macid_pause_id = H2C_FUNC_MAC_MACID_PAUSE_SLEEP;
+		len = sizeof(*h2c_new);
+	} else {
+		h2c_macid_pause_id = H2C_FUNC_MAC_MACID_PAUSE;
+		len = sizeof(*h2c);
+	}
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c macid pause\n");
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
-	h2c = (struct rtw89_fw_macid_pause_grp *)skb->data;
 
-	h2c->mask_grp[grp] = set;
-	if (pause)
-		h2c->pause_grp[grp] = set;
+	if (h2c_macid_pause_id == H2C_FUNC_MAC_MACID_PAUSE_SLEEP) {
+		h2c_new = (struct rtw89_fw_macid_pause_sleep_grp *)skb->data;
+
+		h2c_new->n[0].pause_mask_grp[grp] = set;
+		h2c_new->n[0].sleep_mask_grp[grp] = set;
+		if (pause) {
+			h2c_new->n[0].pause_grp[grp] = set;
+			h2c_new->n[0].sleep_grp[grp] = set;
+		}
+	} else {
+		h2c = (struct rtw89_fw_macid_pause_grp *)skb->data;
+
+		h2c->mask_grp[grp] = set;
+		if (pause)
+			h2c->pause_grp[grp] = set;
+	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
-			      H2C_FUNC_MAC_MACID_PAUSE, 1, 0,
+			      h2c_macid_pause_id, 1, 0,
 			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ec90cc9b0b53..0365cd7b8da0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -231,6 +231,15 @@ struct rtw89_fw_macid_pause_grp {
 	__le32 mask_grp[4];
 } __packed;
 
+struct rtw89_fw_macid_pause_sleep_grp {
+	struct {
+		__le32 pause_grp[4];
+		__le32 pause_mask_grp[4];
+		__le32 sleep_grp[4];
+		__le32 sleep_mask_grp[4];
+	} __packed n[4];
+} __packed;
+
 #define RTW89_H2C_MAX_SIZE 2048
 #define RTW89_CHANNEL_TIME 45
 #define RTW89_CHANNEL_TIME_6G 20
@@ -3659,6 +3668,7 @@ enum rtw89_fw_ofld_h2c_func {
 	H2C_FUNC_CFG_BCNFLTR		= 0x1e,
 	H2C_FUNC_OFLD_RSSI		= 0x1f,
 	H2C_FUNC_OFLD_TP		= 0x20,
+	H2C_FUNC_MAC_MACID_PAUSE_SLEEP	= 0x28,
 
 	NUM_OF_RTW89_FW_OFLD_H2C_FUNC,
 };
-- 
2.25.1


