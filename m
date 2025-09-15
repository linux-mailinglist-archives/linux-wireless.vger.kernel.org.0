Return-Path: <linux-wireless+bounces-27293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BEAB570C0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761113AC2A0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF528DB76;
	Mon, 15 Sep 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kfCKvdTw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD88214236
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919345; cv=none; b=M7OzKCuy8Ry0sTKuMGaS2JVgEDfgTAcCouHg5lvCnN9DxzsgZZPFqjFyQhzRWiASe6u8Cfak1tIwKqz6oL6fpZ1fLQyoHXiexngCcnM9Pz1jgt7BBdlc9qzZTwc8sUYk2oGg1YXYisneM3jpcCkK7Deck1WwvaOFNOr/fcIOOQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919345; c=relaxed/simple;
	bh=917it6lxpxwsnIDAfs8BPb9VXkVVM2sMW5wH19ctkRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q6Dg9gnEmVJK5Ik536iLOuF2ZIk1ige22kepSrBxsv2D+lO0TRrJStFt159I9sOKFOab9zxgD3WON/YbJKVPPa/h0JU1IVIOdW+0Oi8Otme1JCGxSMKsu4MJ39OyZ2gEQLz89ugNcdv3r8orzQcc9lRJWBqBkAG6NgH49d2GcuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kfCKvdTw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6te3sB594835, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919340; bh=31rIQgwHEVialj3xPqMseNZxavafh5dHhkTaQPwJ9lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kfCKvdTwf5pK3VlTa+ITYKNrfvzcdvdU3iCIP6k9vPmDoE35Gn8nMW86IaemR4qMe
	 fxant983QyKlKvk3cBJdFVjtd0ncCyXTO3cM+ZWxYcPfurltqwNqbYvk8jyY2dOoBk
	 HLykfpgcnDHqodv/Ua1ZXbypaQQ7veNr2ct6avwA2RULE3gOeBftoTO5KdrFL6Gczx
	 RIsO1KputfjJj7JOz/lg8vUj1Ph6sJNFzKC1zcpTRd7yQX2w9n6Md3jGik4wIKdFwk
	 6sVRsW6/XZYtFtLhS2JPBlynsIYUvjvdKBv31lSUxMuI5ecFGA8VcMt/WACKW+JrhJ
	 6niAVjYv4y2gA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6te3sB594835
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:55:40 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:55:41 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:55:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 10/11] wifi: rtw89: 8922a: add TAS feature support
Date: Mon, 15 Sep 2025 14:54:29 +0800
Message-ID: <20250915065429.39269-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Kuan-Chung Chen <damon.chen@realtek.com>

Add TAS support for 8922AE. Unlike AX ICs, BE ICs introduce a TAS
timer switch. The firmware starts a TAS timer to periodically
collect TX power information and notify the driver via C2H
events. To avoid unnecessary C2H events, the TAS timer is
enabled during core_start().

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 34 +++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 14 +++-
 drivers/net/wireless/realtek/rtw89/phy.c      | 74 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/phy.h      |  3 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  7 +-
 drivers/net/wireless/realtek/rtw89/sar.c      | 15 ++++
 drivers/net/wireless/realtek/rtw89/sar.h      |  1 +
 8 files changed, 119 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c7907949d3a2..fe059c4a6b55 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5520,6 +5520,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
 	rtw89_fw_h2c_fw_log(rtwdev, rtwdev->fw.log.enable);
 	rtw89_fw_h2c_init_ba_cam(rtwdev);
+	rtw89_tas_fw_timer_enable(rtwdev, true);
 
 	return 0;
 }
@@ -5535,6 +5536,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
 		return;
 
+	rtw89_tas_fw_timer_enable(rtwdev, false);
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_OFF);
 
 	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 9c98c25c10ce..2273dae8434a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6688,6 +6688,40 @@ int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	return ret;
 }
 
+int rtw89_fw_h2c_rf_tas_trigger(struct rtw89_dev *rtwdev, bool enable)
+{
+	struct rtw89_h2c_rf_tas *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c RF TAS\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_rf_tas *)skb->data;
+
+	h2c->enable = cpu_to_le32(enable);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
+			      H2C_FUNC_RFK_TAS_OFFLOAD, 0, 0, len);
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
+
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 98b187305481..ddebf7972068 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4430,6 +4430,7 @@ enum rtw89_rfk_offload_h2c_func {
 	H2C_FUNC_RFK_DACK_OFFLOAD = 0x5,
 	H2C_FUNC_RFK_RXDCK_OFFLOAD = 0x6,
 	H2C_FUNC_RFK_PRE_NOTIFY = 0x8,
+	H2C_FUNC_RFK_TAS_OFFLOAD = 0x9,
 };
 
 struct rtw89_fw_h2c_rf_get_mccch {
@@ -4611,6 +4612,10 @@ struct rtw89_h2c_rf_rxdck_v0 {
 	u8 rxdck_dbg_en;
 } __packed;
 
+struct rtw89_h2c_rf_tas {
+	__le32 enable;
+} __packed;
+
 struct rtw89_h2c_rf_rxdck {
 	struct rtw89_h2c_rf_rxdck_v0 v0;
 	u8 is_chl_k;
@@ -4743,12 +4748,16 @@ struct rtw89_c2h_rfk_report {
 	u8 version;
 } __packed;
 
-struct rtw89_c2h_rf_tas_info {
-	struct rtw89_c2h_hdr hdr;
+struct rtw89_c2h_rf_tas_rpt_log {
 	__le32 cur_idx;
 	__le16 txpwr_history[20];
 } __packed;
 
+struct rtw89_c2h_rf_tas_info {
+	struct rtw89_c2h_hdr hdr;
+	struct rtw89_c2h_rf_tas_rpt_log content;
+} __packed;
+
 #define RTW89_FW_RSVD_PLE_SIZE 0x800
 
 #define RTW89_FW_BACKTRACE_INFO_SIZE 8
@@ -4889,6 +4898,7 @@ int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 const struct rtw89_chan *chan);
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			  const struct rtw89_chan *chan, bool is_chl_k);
+int rtw89_fw_h2c_rf_tas_trigger(struct rtw89_dev *rtwdev, bool enable);
 int rtw89_fw_h2c_raw_with_hdr(struct rtw89_dev *rtwdev,
 			      u8 h2c_class, u8 h2c_func, u8 *buf, u16 len,
 			      bool rack, bool dack);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 45823c9e9448..ba7feadd7582 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3172,6 +3172,34 @@ void (* const rtw89_phy_c2h_dm_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_DM_FUNC_FW_SCAN] = rtw89_phy_c2h_fw_scan_rpt,
 };
 
+static
+void rtw89_phy_c2h_rfk_tas_pwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_c2h_rf_tas_rpt_log *content)
+{
+	const enum rtw89_sar_sources src = rtwdev->sar.src;
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+	u64 linear = 0;
+	u32 i, cur_idx;
+	s16 txpwr;
+
+	if (!tas->enable || src == RTW89_SAR_SOURCE_NONE)
+		return;
+
+	cur_idx = le32_to_cpu(content->cur_idx);
+	for (i = 0; i < cur_idx; i++) {
+		txpwr = le16_to_cpu(content->txpwr_history[i]);
+		linear += rtw89_db_quarter_to_linear(txpwr);
+
+		rtw89_debug(rtwdev, RTW89_DBG_SAR,
+			    "tas: index: %u, txpwr: %d\n", i, txpwr);
+	}
+
+	if (cur_idx == 0)
+		tas->instant_txpwr = rtw89_db_to_linear(0);
+	else
+		tas->instant_txpwr = DIV_ROUND_DOWN_ULL(linear, cur_idx);
+}
+
 static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_c2h_rfk_log_func func,
 				      void *content, u16 len)
@@ -3423,6 +3451,13 @@ static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[TXGAPK]rpt power_d[1] = %*ph\n",
 			    (int)sizeof(txgapk->power_d[1]), txgapk->power_d[1]);
 		return;
+	case RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR:
+		if (len != sizeof(struct rtw89_c2h_rf_tas_rpt_log))
+			goto out;
+
+		rtw89_phy_c2h_rfk_tas_pwr(rtwdev, content);
+
+		return;
 	default:
 		break;
 	}
@@ -3475,9 +3510,6 @@ static void rtw89_phy_c2h_rfk_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 	u16 chunk_len;
 	bool handled;
 
-	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_RFK))
-		return;
-
 	log_ptr += sizeof(*c2h_hdr);
 	len -= sizeof(*c2h_hdr);
 
@@ -3554,6 +3586,13 @@ rtw89_phy_c2h_rfk_log_txgapk(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32
 			      RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK, "TXGAPK");
 }
 
+static void
+rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	rtw89_phy_c2h_rfk_log(rtwdev, c2h, len,
+			      RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR, "TAS");
+}
+
 static
 void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 					       struct sk_buff *c2h, u32 len) = {
@@ -3563,6 +3602,7 @@ void (* const rtw89_phy_c2h_rfk_log_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK] = rtw89_phy_c2h_rfk_log_rxdck,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI] = rtw89_phy_c2h_rfk_log_tssi,
 	[RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK] = rtw89_phy_c2h_rfk_log_txgapk,
+	[RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
 };
 
 static
@@ -3625,39 +3665,19 @@ rtw89_phy_c2h_rfk_report_state(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u3
 }
 
 static void
-rtw89_phy_c2h_rfk_log_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+rtw89_phy_c2h_rfk_report_tas_pwr(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
-	const struct rtw89_c2h_rf_tas_info *rf_tas =
+	const struct rtw89_c2h_rf_tas_info *report =
 		(const struct rtw89_c2h_rf_tas_info *)c2h->data;
-	const enum rtw89_sar_sources src = rtwdev->sar.src;
-	struct rtw89_tas_info *tas = &rtwdev->tas;
-	u64 linear = 0;
-	u32 i, cur_idx;
-	s16 txpwr;
 
-	if (!tas->enable || src == RTW89_SAR_SOURCE_NONE)
-		return;
-
-	cur_idx = le32_to_cpu(rf_tas->cur_idx);
-	for (i = 0; i < cur_idx; i++) {
-		txpwr = (s16)le16_to_cpu(rf_tas->txpwr_history[i]);
-		linear += rtw89_db_quarter_to_linear(txpwr);
-
-		rtw89_debug(rtwdev, RTW89_DBG_SAR,
-			    "tas: index: %u, txpwr: %d\n", i, txpwr);
-	}
-
-	if (cur_idx == 0)
-		tas->instant_txpwr = rtw89_db_to_linear(0);
-	else
-		tas->instant_txpwr = DIV_ROUND_DOWN_ULL(linear, cur_idx);
+	rtw89_phy_c2h_rfk_tas_pwr(rtwdev, &report->content);
 }
 
 static
 void (* const rtw89_phy_c2h_rfk_report_handler[])(struct rtw89_dev *rtwdev,
 						  struct sk_buff *c2h, u32 len) = {
 	[RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE] = rtw89_phy_c2h_rfk_report_state,
-	[RTW89_PHY_C2H_RFK_LOG_TAS_PWR] = rtw89_phy_c2h_rfk_log_tas_pwr,
+	[RTW89_PHY_C2H_RFK_REPORT_FUNC_TAS_PWR] = rtw89_phy_c2h_rfk_report_tas_pwr,
 };
 
 bool rtw89_phy_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 674397c4b9a9..9caacffd0af8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -149,13 +149,14 @@ enum rtw89_phy_c2h_rfk_log_func {
 	RTW89_PHY_C2H_RFK_LOG_FUNC_RXDCK = 3,
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TSSI = 4,
 	RTW89_PHY_C2H_RFK_LOG_FUNC_TXGAPK = 5,
+	RTW89_PHY_C2H_RFK_LOG_FUNC_TAS_PWR = 9,
 
 	RTW89_PHY_C2H_RFK_LOG_FUNC_NUM,
 };
 
 enum rtw89_phy_c2h_rfk_report_func {
 	RTW89_PHY_C2H_RFK_REPORT_FUNC_STATE = 0,
-	RTW89_PHY_C2H_RFK_LOG_TAS_PWR = 6,
+	RTW89_PHY_C2H_RFK_REPORT_FUNC_TAS_PWR = 6,
 };
 
 enum rtw89_phy_c2h_dm_func {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 8eb0cb9bb23e..6aa19ad259ac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2765,6 +2765,10 @@ static int rtw8922a_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static const struct rtw89_chanctx_listener rtw8922a_chanctx_listener = {
+	.callbacks[RTW89_CHANCTX_CALLBACK_TAS] = rtw89_tas_chanctx_cb,
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
@@ -2876,6 +2880,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= NULL, /* load parm from fw */
 	.rfe_parms_conf		= NULL, /* load parm from fw */
+	.chanctx_listener	= &rtw8922a_chanctx_listener,
 	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
@@ -2895,7 +2900,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
 	.support_ant_gain	= true,
-	.support_tas		= false,
+	.support_tas		= true,
 	.support_sar_by_ant	= true,
 	.support_noise		= false,
 	.ul_tb_waveform_ctrl	= false,
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 7f568ffb3766..ef7feccccd5e 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -4,6 +4,7 @@
 
 #include "acpi.h"
 #include "debug.h"
+#include "fw.h"
 #include "phy.h"
 #include "reg.h"
 #include "sar.h"
@@ -843,6 +844,20 @@ void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_tas_chanctx_cb);
 
+void rtw89_tas_fw_timer_enable(struct rtw89_dev *rtwdev, bool enable)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_tas_info *tas = &rtwdev->tas;
+
+	if (!tas->enable)
+		return;
+
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		return;
+
+	rtw89_fw_h2c_rf_tas_trigger(rtwdev, enable);
+}
+
 void rtw89_sar_init(struct rtw89_dev *rtwdev)
 {
 	rtw89_set_sar_from_acpi(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 4b7f3d44f57b..60b3aec5b3be 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -37,6 +37,7 @@ void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force);
 void rtw89_tas_scan(struct rtw89_dev *rtwdev, bool start);
 void rtw89_tas_chanctx_cb(struct rtw89_dev *rtwdev,
 			  enum rtw89_chanctx_state state);
+void rtw89_tas_fw_timer_enable(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_sar_init(struct rtw89_dev *rtwdev);
 void rtw89_sar_track(struct rtw89_dev *rtwdev);
 
-- 
2.25.1


