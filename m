Return-Path: <linux-wireless+bounces-2519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 524CC83D488
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09AA7285202
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 07:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516661CFB4;
	Fri, 26 Jan 2024 06:34:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBB81CF8D
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706250892; cv=none; b=iZVFUQ0qvXRjM9THLue5kb2dfDJI1bs+/IUgUN50+sYbgk6EjEUa3qYti+egLH66L/DV2VNMJo1eyV0keQZLi/GsiPwLb1hjXRWu05rJAX0XwFk4b36TsRL0m/upXvyMz+e9wvOticGvPJbl7yuwVmDR6TEKzfkPHGOGC0E4aZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706250892; c=relaxed/simple;
	bh=X1qUYcaN/gsALpVhKWZEt8wF1moOD57JbntodFey4KY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+SsHB24VzOR8+oROYjzY14uKoDZ2fpXvKvz2Q5BM+JUyBTB+p2/yCk7omtdJ8t0v+nXrOQVkrJ8Sdcw6dZwRcjko+peUXZ/Ql0tRDOtvSr94q/17fqo1HhoFBMx9k4fzgXJB40RT7nEJySag2mOKoz7QGp9OoNnMSw/fcdqftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q6Yh4B22085611, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q6Yh4B22085611
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 14:34:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 26 Jan 2024 14:34:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 26 Jan
 2024 14:34:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw89: 8922a: add ieee80211_ops::hw_scan
Date: Fri, 26 Jan 2024 14:33:53 +0800
Message-ID: <20240126063356.17857-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126063356.17857-1-pkshih@realtek.com>
References: <20240126063356.17857-1-pkshih@realtek.com>
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

This adds support for hardware scan after FW version 0.34.35. Currently
we only support scanning on single hardware band and support of dual band
scan will be added in the future. Adjust the current flow to make driver
compatible with different generation ICs.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  39 +++++
 drivers/net/wireless/realtek/rtw89/fw.c     | 178 +++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h     |  86 +++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c    |  15 +-
 drivers/net/wireless/realtek/rtw89/mac.h    |   3 +
 drivers/net/wireless/realtek/rtw89/mac_be.c |   1 +
 6 files changed, 314 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c86b46e7964f..30cc77ac78c5 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3258,6 +3258,45 @@ enum rtw89_mlo_dbcc_mode {
 	DBCC_LEGACY = 0xffffffff,
 };
 
+enum rtw89_scan_be_operation {
+	RTW89_SCAN_OP_STOP,
+	RTW89_SCAN_OP_START,
+	RTW89_SCAN_OP_SETPARM,
+	RTW89_SCAN_OP_GETRPT,
+	RTW89_SCAN_OP_NUM
+};
+
+enum rtw89_scan_be_mode {
+	RTW89_SCAN_MODE_SA,
+	RTW89_SCAN_MODE_MACC,
+	RTW89_SCAN_MODE_NUM
+};
+
+enum rtw89_scan_be_opmode {
+	RTW89_SCAN_OPMODE_NONE,
+	RTW89_SCAN_OPMODE_TBTT,
+	RTW89_SCAN_OPMODE_INTV,
+	RTW89_SCAN_OPMODE_CNT,
+	RTW89_SCAN_OPMODE_NUM,
+};
+
+struct rtw89_scan_option {
+	bool enable;
+	bool target_ch_mode;
+	u8 num_macc_role;
+	u8 num_opch;
+	u8 repeat;
+	u16 norm_pd;
+	u16 slow_pd;
+	u16 norm_cy;
+	u8 opch_end;
+	u64 prohib_chan;
+	enum rtw89_phy_idx band;
+	enum rtw89_scan_be_operation operation;
+	enum rtw89_scan_be_mode scan_mode;
+	enum rtw89_mlo_dbcc_mode mlo_mode;
+};
+
 enum rtw89_qta_mode {
 	RTW89_QTA_SCC,
 	RTW89_QTA_DLFW,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index ea308244b303..7a0671e4ef2c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -459,6 +459,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -4236,6 +4237,169 @@ int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static void rtw89_scan_get_6g_disabled_chan(struct rtw89_dev *rtwdev,
+					    struct rtw89_scan_option *option)
+{
+	struct ieee80211_supported_band *sband;
+	struct ieee80211_channel *chan;
+	u8 i, idx;
+
+	sband = rtwdev->hw->wiphy->bands[NL80211_BAND_6GHZ];
+
+	for (i = 0; i < sband->n_channels; i++) {
+		chan = &sband->channels[i];
+		if (chan->flags & IEEE80211_CHAN_DISABLED) {
+			idx = (chan->hw_value - 1) / 4;
+			option->prohib_chan |= BIT(idx);
+		}
+	}
+}
+
+int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
+				 struct rtw89_scan_option *option,
+				 struct rtw89_vif *rtwvif)
+{
+	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	struct rtw89_h2c_scanofld_be_macc_role *macc_role;
+	struct rtw89_chan *op = &scan_info->op_chan;
+	struct rtw89_h2c_scanofld_be_opch *opch;
+	struct rtw89_h2c_scanofld_be *h2c;
+	struct sk_buff *skb;
+	u8 macc_role_size = sizeof(*macc_role) * option->num_macc_role;
+	u8 opch_size = sizeof(*opch) * option->num_opch;
+	u8 probe_id[NUM_NL80211_BANDS];
+	unsigned int cond;
+	void *ptr;
+	int ret;
+	u32 len;
+	u8 i;
+
+	rtw89_scan_get_6g_disabled_chan(rtwdev, option);
+
+	len = sizeof(*h2c) + macc_role_size + opch_size;
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c scan offload\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_scanofld_be *)skb->data;
+	ptr = skb->data;
+
+	h2c->w0 = le32_encode_bits(option->operation, RTW89_H2C_SCANOFLD_BE_W0_OP) |
+		  le32_encode_bits(option->scan_mode,
+				   RTW89_H2C_SCANOFLD_BE_W0_SCAN_MODE) |
+		  le32_encode_bits(option->repeat, RTW89_H2C_SCANOFLD_BE_W0_REPEAT) |
+		  le32_encode_bits(true, RTW89_H2C_SCANOFLD_BE_W0_NOTIFY_END) |
+		  le32_encode_bits(true, RTW89_H2C_SCANOFLD_BE_W0_LEARN_CH) |
+		  le32_encode_bits(rtwvif->mac_id, RTW89_H2C_SCANOFLD_BE_W0_MACID) |
+		  le32_encode_bits(rtwvif->port, RTW89_H2C_SCANOFLD_BE_W0_PORT) |
+		  le32_encode_bits(option->band, RTW89_H2C_SCANOFLD_BE_W0_BAND);
+
+	h2c->w1 = le32_encode_bits(option->num_macc_role, RTW89_H2C_SCANOFLD_BE_W1_NUM_MACC_ROLE) |
+		  le32_encode_bits(option->num_opch, RTW89_H2C_SCANOFLD_BE_W1_NUM_OP) |
+		  le32_encode_bits(option->norm_pd, RTW89_H2C_SCANOFLD_BE_W1_NORM_PD);
+
+	h2c->w2 = le32_encode_bits(option->slow_pd, RTW89_H2C_SCANOFLD_BE_W2_SLOW_PD) |
+		  le32_encode_bits(option->norm_cy, RTW89_H2C_SCANOFLD_BE_W2_NORM_CY) |
+		  le32_encode_bits(option->opch_end, RTW89_H2C_SCANOFLD_BE_W2_OPCH_END);
+
+	h2c->w3 = le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_W3_NUM_SSID) |
+		  le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_W3_NUM_SHORT_SSID) |
+		  le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_W3_NUM_BSSID) |
+		  le32_encode_bits(probe_id[NL80211_BAND_2GHZ], RTW89_H2C_SCANOFLD_BE_W3_PROBEID);
+
+	h2c->w4 = le32_encode_bits(probe_id[NL80211_BAND_5GHZ],
+				   RTW89_H2C_SCANOFLD_BE_W4_PROBE_5G) |
+		  le32_encode_bits(probe_id[NL80211_BAND_6GHZ],
+				   RTW89_H2C_SCANOFLD_BE_W4_PROBE_6G) |
+		  le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_W4_DELAY_START);
+
+	h2c->w5 = le32_encode_bits(option->mlo_mode, RTW89_H2C_SCANOFLD_BE_W5_MLO_MODE);
+
+	h2c->w6 = le32_encode_bits(option->prohib_chan,
+				   RTW89_H2C_SCANOFLD_BE_W6_CHAN_PROHIB_LOW);
+	h2c->w7 = le32_encode_bits(option->prohib_chan >> 32,
+				   RTW89_H2C_SCANOFLD_BE_W7_CHAN_PROHIB_HIGH);
+	ptr += sizeof(*h2c);
+
+	for (i = 0; i < option->num_macc_role; i++) {
+		macc_role = (struct rtw89_h2c_scanofld_be_macc_role *)&h2c->role[i];
+		macc_role->w0 =
+			le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_BAND) |
+			le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_PORT) |
+			le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_MACID) |
+			le32_encode_bits(0, RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_OPCH_END);
+		ptr += sizeof(*macc_role);
+	}
+
+	for (i = 0; i < option->num_opch; i++) {
+		opch = ptr;
+		opch->w0 = le32_encode_bits(rtwvif->mac_id,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_MACID) |
+			   le32_encode_bits(option->band,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_BAND) |
+			   le32_encode_bits(rtwvif->port,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_PORT) |
+			   le32_encode_bits(RTW89_SCAN_OPMODE_INTV,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY) |
+			   le32_encode_bits(true,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_TXNULL) |
+			   le32_encode_bits(RTW89_OFF_CHAN_TIME / 10,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY_VAL);
+
+		opch->w1 = le32_encode_bits(RTW89_CHANNEL_TIME,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_DURATION) |
+			   le32_encode_bits(op->band_type,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_CH_BAND) |
+			   le32_encode_bits(op->band_width,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_BW) |
+			   le32_encode_bits(0x3,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_NOTIFY) |
+			   le32_encode_bits(op->primary_channel,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_PRI_CH) |
+			   le32_encode_bits(op->channel,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W1_CENTRAL_CH);
+
+		opch->w2 = le32_encode_bits(0,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_PKTS_CTRL) |
+			   le32_encode_bits(0,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SW_DEF) |
+			   le32_encode_bits(2,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W2_SS);
+
+		opch->w3 = le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT0) |
+			   le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT1) |
+			   le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT2) |
+			   le32_encode_bits(RTW89_SCANOFLD_PKT_NONE,
+					    RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT3);
+		ptr += sizeof(*opch);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_SCANOFLD_BE, 1, 1,
+			      len);
+
+	if (option->enable)
+		cond = RTW89_SCANOFLD_BE_WAIT_COND_START;
+	else
+		cond = RTW89_SCANOFLD_BE_WAIT_COND_STOP;
+
+	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait, cond);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW, "failed to scan be ofld\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page)
@@ -5173,6 +5337,7 @@ static bool rtw89_is_any_vif_connected_or_connecting(struct rtw89_dev *rtwdev)
 int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			  bool enable)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_scan_option opt = {0};
 	struct rtw89_vif *rtwvif;
 	bool connected;
@@ -5190,7 +5355,18 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		if (ret)
 			goto out;
 	}
-	ret = rtw89_fw_h2c_scan_offload(rtwdev, &opt, rtwvif);
+
+	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
+		opt.operation = enable ? RTW89_SCAN_OP_START : RTW89_SCAN_OP_STOP;
+		opt.scan_mode = RTW89_SCAN_MODE_SA;
+		opt.band = RTW89_PHY_0;
+		opt.num_macc_role = 0;
+		opt.mlo_mode = rtwdev->mlo_dbcc_mode;
+		opt.num_opch = connected ? 1 : 0;
+		opt.opch_end = connected ? 0 : RTW89_CHAN_INVALID;
+	}
+
+	ret = mac->scan_offload(rtwdev, &opt, rtwvif);
 out:
 	return ret;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 132809ea05bf..08b8f6d75065 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -266,6 +266,7 @@ struct rtw89_fw_macid_pause_sleep_grp {
 #define RTW89_SCANOFLD_MAX_IE_LEN 512
 #define RTW89_SCANOFLD_PKT_NONE 0xFF
 #define RTW89_SCANOFLD_DEBUG_MASK 0x1F
+#define RTW89_CHAN_INVALID 0xFF
 #define RTW89_MAC_CHINFO_SIZE 28
 #define RTW89_SCAN_LIST_GUARD 4
 #define RTW89_SCAN_LIST_LIMIT \
@@ -325,11 +326,6 @@ struct rtw89_mac_chinfo_be {
 	bool is_psc;
 };
 
-struct rtw89_scan_option {
-	bool enable;
-	bool target_ch_mode;
-};
-
 struct rtw89_pktofld_info {
 	struct list_head list;
 	u8 id;
@@ -2814,6 +2810,79 @@ struct rtw89_h2c_scanofld {
 #define RTW89_H2C_SCANOFLD_W2_NORM_PD GENMASK(15, 0)
 #define RTW89_H2C_SCANOFLD_W2_SLOW_PD GENMASK(23, 16)
 
+struct rtw89_h2c_scanofld_be_macc_role {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_BAND GENMASK(1, 0)
+#define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_PORT GENMASK(4, 2)
+#define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_MACID GENMASK(23, 8)
+#define RTW89_H2C_SCANOFLD_BE_MACC_ROLE_W0_OPCH_END GENMASK(31, 24)
+
+struct rtw89_h2c_scanofld_be_opch {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+} __packed;
+
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W0_MACID GENMASK(15, 0)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W0_BAND GENMASK(17, 16)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W0_PORT GENMASK(20, 18)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY GENMASK(22, 21)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W0_TXNULL BIT(23)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W0_POLICY_VAL GENMASK(31, 24)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W1_DURATION GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W1_CH_BAND GENMASK(9, 8)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W1_BW GENMASK(12, 10)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W1_NOTIFY GENMASK(14, 13)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W1_PRI_CH GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W1_CENTRAL_CH GENMASK(31, 24)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W2_PKTS_CTRL GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W2_SW_DEF GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W2_SS GENMASK(18, 16)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT0 GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT1 GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT2 GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_BE_OPCH_W3_PKT3 GENMASK(31, 24)
+
+struct rtw89_h2c_scanofld_be {
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	struct rtw89_h2c_scanofld_be_macc_role role[];
+} __packed;
+
+#define RTW89_H2C_SCANOFLD_BE_W0_OP GENMASK(1, 0)
+#define RTW89_H2C_SCANOFLD_BE_W0_SCAN_MODE GENMASK(3, 2)
+#define RTW89_H2C_SCANOFLD_BE_W0_REPEAT GENMASK(5, 4)
+#define RTW89_H2C_SCANOFLD_BE_W0_NOTIFY_END BIT(6)
+#define RTW89_H2C_SCANOFLD_BE_W0_LEARN_CH BIT(7)
+#define RTW89_H2C_SCANOFLD_BE_W0_MACID GENMASK(23, 8)
+#define RTW89_H2C_SCANOFLD_BE_W0_PORT GENMASK(26, 24)
+#define RTW89_H2C_SCANOFLD_BE_W0_BAND GENMASK(28, 27)
+#define RTW89_H2C_SCANOFLD_BE_W1_NUM_MACC_ROLE GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_W1_NUM_OP GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_W1_NORM_PD GENMASK(31, 16)
+#define RTW89_H2C_SCANOFLD_BE_W2_SLOW_PD GENMASK(15, 0)
+#define RTW89_H2C_SCANOFLD_BE_W2_NORM_CY GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_BE_W2_OPCH_END GENMASK(31, 24)
+#define RTW89_H2C_SCANOFLD_BE_W3_NUM_SSID GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_W3_NUM_SHORT_SSID GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_W3_NUM_BSSID GENMASK(23, 16)
+#define RTW89_H2C_SCANOFLD_BE_W3_PROBEID GENMASK(31, 24)
+#define RTW89_H2C_SCANOFLD_BE_W4_PROBE_5G GENMASK(7, 0)
+#define RTW89_H2C_SCANOFLD_BE_W4_PROBE_6G GENMASK(15, 8)
+#define RTW89_H2C_SCANOFLD_BE_W4_DELAY_START GENMASK(31, 16)
+#define RTW89_H2C_SCANOFLD_BE_W5_MLO_MODE GENMASK(31, 0)
+#define RTW89_H2C_SCANOFLD_BE_W6_CHAN_PROHIB_LOW GENMASK(31, 0)
+#define RTW89_H2C_SCANOFLD_BE_W7_CHAN_PROHIB_HIGH GENMASK(31, 0)
+
 static inline void RTW89_SET_FWCMD_P2P_MACID(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)cmd, val, GENMASK(7, 0));
@@ -3773,6 +3842,7 @@ enum rtw89_fw_ofld_h2c_func {
 	H2C_FUNC_OFLD_RSSI		= 0x1f,
 	H2C_FUNC_OFLD_TP		= 0x20,
 	H2C_FUNC_MAC_MACID_PAUSE_SLEEP	= 0x28,
+	H2C_FUNC_SCANOFLD_BE		= 0x2c,
 
 	NUM_OF_RTW89_FW_OFLD_H2C_FUNC,
 };
@@ -3788,6 +3858,9 @@ enum rtw89_fw_ofld_h2c_func {
 
 #define RTW89_SCANOFLD_WAIT_COND_START RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_SCANOFLD)
 #define RTW89_SCANOFLD_WAIT_COND_STOP RTW89_FW_OFLD_WAIT_COND(1, H2C_FUNC_SCANOFLD)
+#define RTW89_SCANOFLD_BE_WAIT_COND_START RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_SCANOFLD_BE)
+#define RTW89_SCANOFLD_BE_WAIT_COND_STOP RTW89_FW_OFLD_WAIT_COND(1, H2C_FUNC_SCANOFLD_BE)
+
 
 /* CLASS 10 - Security CAM */
 #define H2C_CL_MAC_SEC_CAM		0xa
@@ -4009,6 +4082,9 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 int rtw89_fw_h2c_scan_offload(struct rtw89_dev *rtwdev,
 			      struct rtw89_scan_option *opt,
 			      struct rtw89_vif *vif);
+int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
+				 struct rtw89_scan_option *opt,
+				 struct rtw89_vif *vif);
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ba2157bdd1d1..ec6acd52f3b2 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4867,6 +4867,9 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 		case H2C_FUNC_SCANOFLD:
 			cond = RTW89_SCANOFLD_WAIT_COND_START;
 			break;
+		case H2C_FUNC_SCANOFLD_BE:
+			cond = RTW89_SCANOFLD_BE_WAIT_COND_START;
+			break;
 		}
 
 		data.err = !!h2c_return;
@@ -5116,14 +5119,21 @@ static void rtw89_mac_c2h_scanofld_rsp_atomic(struct rtw89_dev *rtwdev,
 		(const struct rtw89_c2h_scanofld *)skb->data;
 	struct rtw89_wait_info *fw_ofld_wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_completion_data data = {};
+	unsigned int cond;
 	u8 status, reason;
 
 	status = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_STATUS);
 	reason = le32_get_bits(c2h->w2, RTW89_C2H_SCANOFLD_W2_RSN);
 	data.err = status != RTW89_SCAN_STATUS_SUCCESS;
 
-	if (reason == RTW89_SCAN_END_SCAN_NOTIFY)
-		rtw89_complete_cond(fw_ofld_wait, RTW89_SCANOFLD_WAIT_COND_STOP, &data);
+	if (reason == RTW89_SCAN_END_SCAN_NOTIFY) {
+		if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
+			cond = RTW89_SCANOFLD_BE_WAIT_COND_STOP;
+		else
+			cond = RTW89_SCANOFLD_WAIT_COND_STOP;
+
+		rtw89_complete_cond(fw_ofld_wait, cond, &data);
+	}
 }
 
 bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
@@ -6226,5 +6236,6 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.is_txq_empty = mac_is_txq_empty_ax,
 
 	.add_chan_list = rtw89_hw_scan_add_chan_list,
+	.scan_offload = rtw89_fw_h2c_scan_offload,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8948ea4422b4..8056c85c8dba 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -955,6 +955,9 @@ struct rtw89_mac_gen_def {
 
 	int (*add_chan_list)(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif *rtwvif, bool connected);
+	int (*scan_offload)(struct rtw89_dev *rtwdev,
+			    struct rtw89_scan_option *option,
+			    struct rtw89_vif *rtwvif);
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 177d87c998df..c67cdff14abd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2270,5 +2270,6 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.is_txq_empty = mac_is_txq_empty_be,
 
 	.add_chan_list = rtw89_hw_scan_add_chan_list_be,
+	.scan_offload = rtw89_fw_h2c_scan_offload_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
-- 
2.25.1


