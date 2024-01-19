Return-Path: <linux-wireless+bounces-2230-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E955832585
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93D861C22D2A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9A28E0C;
	Fri, 19 Jan 2024 08:15:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DF228E0A
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 08:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705652158; cv=none; b=gQLN3MZfw96VKUCz/I4it1yNL424PaJo1hvVnv1KXF1CI1kfpTq5qC82hIRGj3U7bGjVwxmhxLOQ8cxykyjoGDIgLlwDsBM7Myn2dAl6xqW4PBp8dMfjB9TMTQnkandbtxkHZ/a9jgljGQKdnEgw2+ebfRHO1hHcGktoJHrqj0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705652158; c=relaxed/simple;
	bh=PKn64mNckNMT2P7roAmThcgTDxTI/uVOQI+yh0RHlEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYRnmqMRLcbaR/J/2/Lv3XXElwIOlkEaocJJCk1+Y4Sp3iWRxVLCcDsGO1aoW9yaS1izB0cHUEqXN7x0o4AHmNF50dbZSpV0ygR1m7HNi9QXI2q6V/ie36RehJSYW3vFuyY48hHHcLr/Um8y2iAvgAa14H2JKbvFFFIoVAeN4zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40J8FpaW62212476, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40J8FpaW62212476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jan 2024 16:15:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 19 Jan 2024 16:15:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jan
 2024 16:15:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: add wait/completion for abort scan
Date: Fri, 19 Jan 2024 16:14:59 +0800
Message-ID: <20240119081501.25223-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240119081501.25223-1-pkshih@realtek.com>
References: <20240119081501.25223-1-pkshih@realtek.com>
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

When aborting scan, wait until FW is done to keep both states aligned.
This prevents driver modifying channel then gets overwritten by FW.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 21 ++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   | 11 +++++++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 29 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h  |  3 ++-
 5 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 80f67f1b0679..888520cd4c15 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4608,6 +4608,7 @@ struct rtw89_hw_scan_info {
 	struct ieee80211_vif *scanning_vif;
 	struct list_head pkt_list[NUM_NL80211_BANDS];
 	struct rtw89_chan op_chan;
+	bool abort;
 	u32 last_chan_idx;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ed0ac3726336..231dd884645a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4063,7 +4063,7 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
 			      H2C_FUNC_ADD_SCANOFLD_CH, 1, 1, skb_len);
 
-	cond = RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_ADD_SCANOFLD_CH);
+	cond = RTW89_SCANOFLD_WAIT_COND_ADD_CH;
 
 	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
 	if (ret) {
@@ -4122,7 +4122,10 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      H2C_FUNC_SCANOFLD, 1, 1,
 			      len);
 
-	cond = RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_SCANOFLD);
+	if (option->enable)
+		cond = RTW89_SCANOFLD_WAIT_COND_START;
+	else
+		cond = RTW89_SCANOFLD_WAIT_COND_STOP;
 
 	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
 	if (ret) {
@@ -4312,7 +4315,7 @@ static bool rtw89_fw_c2h_chk_atomic(struct rtw89_dev *rtwdev,
 	default:
 		return false;
 	case RTW89_C2H_CAT_MAC:
-		return rtw89_mac_c2h_chk_atomic(rtwdev, class, func);
+		return rtw89_mac_c2h_chk_atomic(rtwdev, c2h, class, func);
 	case RTW89_C2H_CAT_OUTSRC:
 		return rtw89_phy_c2h_chk_atomic(rtwdev, class, func);
 	}
@@ -4866,6 +4869,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw89_get_channel(rtwdev, rtwvif, &rtwdev->scan_info.op_chan);
 	rtwdev->scan_info.scanning_vif = vif;
 	rtwdev->scan_info.last_chan_idx = 0;
+	rtwdev->scan_info.abort = false;
 	rtwvif->scan_ies = &scan_req->ies;
 	rtwvif->scan_req = req;
 	ieee80211_stop_queues(rtwdev->hw);
@@ -4917,14 +4921,21 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rtwvif->scan_ies = NULL;
 	scan_info->last_chan_idx = 0;
 	scan_info->scanning_vif = NULL;
+	scan_info->abort = false;
 
 	rtw89_chanctx_proceed(rtwdev);
 }
 
 void rtw89_hw_scan_abort(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif)
 {
-	rtw89_hw_scan_offload(rtwdev, vif, false);
-	rtw89_hw_scan_complete(rtwdev, vif, true);
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	int ret;
+
+	scan_info->abort = true;
+
+	ret = rtw89_hw_scan_offload(rtwdev, vif, false);
+	if (ret)
+		rtw89_hw_scan_complete(rtwdev, vif, true);
 }
 
 static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5d51611d5f6d..a3df701bdc6e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -175,6 +175,12 @@ enum rtw89_scanofld_notify_reason {
 	RTW89_SCAN_LEAVE_OP_NOTIFY,
 };
 
+enum rtw89_scanofld_status {
+	RTW89_SCAN_STATUS_NOTIFY,
+	RTW89_SCAN_STATUS_SUCCESS,
+	RTW89_SCAN_STATUS_FAIL,
+};
+
 enum rtw89_chan_type {
 	RTW89_CHAN_OPERATE = 0,
 	RTW89_CHAN_ACTIVE,
@@ -3701,6 +3707,11 @@ enum rtw89_fw_ofld_h2c_func {
 	RTW89_FW_OFLD_WAIT_COND(RTW89_PKT_OFLD_WAIT_TAG(pkt_id, pkt_op), \
 				H2C_FUNC_PACKET_OFLD)
 
+#define RTW89_SCANOFLD_WAIT_COND_ADD_CH RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_ADD_SCANOFLD_CH)
+
+#define RTW89_SCANOFLD_WAIT_COND_START RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_SCANOFLD)
+#define RTW89_SCANOFLD_WAIT_COND_STOP RTW89_FW_OFLD_WAIT_COND(1, H2C_FUNC_SCANOFLD)
+
 /* CLASS 10 - Security CAM */
 #define H2C_CL_MAC_SEC_CAM		0xa
 #define H2C_FUNC_MAC_SEC_UPD		0x1
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d472906bd073..03553b63a4a8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4717,7 +4717,7 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 				rtw89_warn(rtwdev, "HW scan failed: %d\n", ret);
 			}
 		} else {
-			rtw89_hw_scan_complete(rtwdev, vif, false);
+			rtw89_hw_scan_complete(rtwdev, vif, rtwdev->scan_info.abort);
 		}
 		break;
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
@@ -4839,8 +4839,10 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 		default:
 			return;
 		case H2C_FUNC_ADD_SCANOFLD_CH:
+			cond = RTW89_SCANOFLD_WAIT_COND_ADD_CH;
+			break;
 		case H2C_FUNC_SCANOFLD:
-			cond = RTW89_FW_OFLD_WAIT_COND(0, h2c_func);
+			cond = RTW89_SCANOFLD_WAIT_COND_START;
 			break;
 		}
 
@@ -5084,7 +5086,25 @@ void (* const rtw89_mac_c2h_mcc_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_MCC_STATUS_RPT] = rtw89_mac_c2h_mcc_status_rpt,
 };
 
-bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
+static void rtw89_mac_c2h_scanofld_rsp_atomic(struct rtw89_dev *rtwdev,
+					      struct sk_buff *skb)
+{
+	const struct rtw89_c2h_scanofld *c2h =
+		(const struct rtw89_c2h_scanofld *)skb->data;
+	struct rtw89_wait_info *fw_ofld_wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_completion_data data = {};
+	u8 status, reason;
+
+	status = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_STATUS);
+	reason = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_RSN);
+	data.err = status != RTW89_SCAN_STATUS_SUCCESS;
+
+	if (reason == RTW89_SCAN_END_SCAN_NOTIFY)
+		rtw89_complete_cond(fw_ofld_wait, RTW89_SCANOFLD_WAIT_COND_STOP, &data);
+}
+
+bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+			      u8 class, u8 func)
 {
 	switch (class) {
 	default:
@@ -5101,6 +5121,9 @@ bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
 		switch (func) {
 		default:
 			return false;
+		case RTW89_MAC_C2H_FUNC_SCANOFLD_RSP:
+			rtw89_mac_c2h_scanofld_rsp_atomic(rtwdev, c2h);
+			return false;
 		case RTW89_MAC_C2H_FUNC_PKT_OFLD_RSP:
 			return true;
 		}
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index ed98b49809a4..54ce16a2c475 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1127,7 +1127,8 @@ static inline int rtw89_chip_reset_bb_rf(struct rtw89_dev *rtwdev)
 
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev);
 int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err);
-bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
+bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
+			      u8 class, u8 func);
 void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
 int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev);
-- 
2.25.1


