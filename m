Return-Path: <linux-wireless+bounces-14090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1104F9A0BBD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0E7B26859
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 13:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8329420966C;
	Wed, 16 Oct 2024 13:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XqV5RbcP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C56D2071FC
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085888; cv=none; b=PEiNOzfQF1AWWyiV1yaGn7WZ9v/Wpcqwhkr4IMljiXAUljeB4qwU7zalxJsi2sT5W6fRWW6d+eJlVSDxsXv2Tu214vwN+WPN1yn5lJkm+z68VeoNY2K2GmPyxi/COWuNBu+lbF55CUtx876Ai8yFKOoHhYm0bhHrbBttbRsDZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085888; c=relaxed/simple;
	bh=a3ErnihHQalxETV0bgdOovfaL6yf3X/foUL8tJer8ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ly6vMcDY0C7gZztd//tHJAKYkcj7ybgA//KCDEc3FVOxk7Em1w8WHL7p1YtP5ePcP9IqDSqdPQAqM154qOn3XI8bGexOkLxy8fkYmKDksB7jEQpBbcZ0hJ2pJrHAOby7a1tffWYPK/I6LwFpq4KENtfWM2zSl1r/LpttARBVYxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XqV5RbcP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49GDc3yV53078487, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729085883; bh=a3ErnihHQalxETV0bgdOovfaL6yf3X/foUL8tJer8ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XqV5RbcPeNwseY1NDQqpO/K0QLtCTZFXeXN9uonhD3OGN6IPZxTBqWg0IPQXjoktD
	 /2m5d67tZKvNsNPdnibWb6aoSyAMzpljNLW2fSHKTTv3kErI656K2YAX8Day9yzJVX
	 bMXZtS5XDSQmFlpheSKsfA8yJ7Y8Wbrj2O7kN+ruJToaoPkRSnGrp4CbA9wnhRwnMy
	 GYqgnsgl5mZx1M3jKtwfFoknGZJsY7nOeeBuL0WlNsgM6L1mGLR/ywmRaF8rVNwgIz
	 YiMXndygjZnaRztZBMob1tRPqeek5mxYKPCbof4XDayYgm3KjKJXRu5GzpBN0yLHkt
	 T3Kl3jTNMmIKg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49GDc3yV53078487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 21:38:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 21:38:03 +0800
Received: from [127.0.1.1] (172.16.21.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Oct
 2024 21:38:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: add thermal protection
Date: Wed, 16 Oct 2024 21:37:34 +0800
Message-ID: <20241016133735.7571-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016133735.7571-1-pkshih@realtek.com>
References: <20241016133735.7571-1-pkshih@realtek.com>
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

To prevent chip overheating, reduce TX duty as the mechanism of thermal
protection. When temperature is raising over a threshold, send a firmware
command to reduce TX duty. If temperature is still raising, higher level
is adopted to have lower active duration.

The equation and unit of thermal values are different from chip to chip,
so define constant thresholds of thermal value to corresponding absolute
temperature of 110 and 120 degree Celsius.

Latter patch will decide which thermal threshold is adopted, and current
is still not enable thermal protection.

For debugging, add a flag to disable_dm that thermal protection can be
disabled to clarify low throughput in field.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  9 ++++
 drivers/net/wireless/realtek/rtw89/debug.c    | 10 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 46 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 18 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 13 ++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 34 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  7 ++-
 13 files changed, 138 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 38df161bfd35..6218e033b2b8 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4244,6 +4244,7 @@ struct rtw89_chip_info {
 	u8 wde_qempty_acq_grpnum;
 	u8 wde_qempty_mgq_grpsel;
 	u32 rf_base_addr[2];
+	u8 thermal_th[2];
 	u8 support_macid_num;
 	u8 support_link_num;
 	u8 support_chanctx_num;
@@ -4651,8 +4652,12 @@ struct rtw89_edcca_bak {
 
 enum rtw89_dm_type {
 	RTW89_DM_DYNAMIC_EDCCA,
+	RTW89_DM_THERMAL_PROTECT,
 };
 
+#define RTW89_THERMAL_PROT_LV_MAX 5
+#define RTW89_THERMAL_PROT_STEP 19 /* -19% for each level */
+
 struct rtw89_hal {
 	u32 rx_fltr;
 	u8 cv;
@@ -4679,6 +4684,9 @@ struct rtw89_hal {
 
 	struct rtw89_edcca_bak edcca_bak;
 	u32 disabled_dm_bitmap; /* bitmap of enum rtw89_dm_type */
+
+	u8 thermal_prot_th;
+	u8 thermal_prot_lv; /* 0 ~ RTW89_THERMAL_PROT_LV_MAX */
 };
 
 #define RTW89_MAX_MAC_ID_NUM 128
@@ -4751,6 +4759,7 @@ DECLARE_EWMA(thermal, 4, 4);
 
 struct rtw89_phy_stat {
 	struct ewma_thermal avg_thermal[RF_PATH_MAX];
+	u8 last_thermal_max;
 	struct ewma_rssi bcn_rssi;
 	struct rtw89_pkt_stat cur_pkt_stat;
 	struct rtw89_pkt_stat last_pkt_stat;
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 74b0c722a5b8..6abd88fa80ba 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3672,14 +3672,19 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 	struct rtw89_pkt_stat *pkt_stat = &rtwdev->phystat.last_pkt_stat;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_rx_rate_cnt_info *info;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_hw_rate first_rate;
 	u8 rssi;
 	int i;
 
 	rssi = ewma_rssi_read(&rtwdev->phystat.bcn_rssi);
 
-	seq_printf(m, "TP TX: %u [%u] Mbps (lv: %d), RX: %u [%u] Mbps (lv: %d)\n",
-		   stats->tx_throughput, stats->tx_throughput_raw, stats->tx_tfc_lv,
+	seq_printf(m, "TP TX: %u [%u] Mbps (lv: %d",
+		   stats->tx_throughput, stats->tx_throughput_raw, stats->tx_tfc_lv);
+	if (hal->thermal_prot_lv)
+		seq_printf(m, ", duty: %d%%",
+			   100 - hal->thermal_prot_lv * RTW89_THERMAL_PROT_STEP);
+	seq_printf(m, "), RX: %u [%u] Mbps (lv: %d)\n",
 		   stats->rx_throughput, stats->rx_throughput_raw, stats->rx_tfc_lv);
 	seq_printf(m, "Beacon: %u (%d dBm), TF: %u\n", pkt_stat->beacon_nr,
 		   RTW89_RSSI_RAW_TO_DBM(rssi), stats->rx_tf_periodic);
@@ -3886,6 +3891,7 @@ static const struct rtw89_disabled_dm_info {
 	const char *name;
 } rtw89_disabled_dm_infos[] = {
 	DM_INFO(DYNAMIC_EDCCA),
+	DM_INFO(THERMAL_PROTECT),
 };
 
 static int
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2c2fdf21f065..29898163a1a9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3795,6 +3795,52 @@ int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+int rtw89_fw_h2c_tx_duty(struct rtw89_dev *rtwdev, u8 lv)
+{
+	struct rtw89_h2c_tx_duty *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u16 pause, active;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c tx duty\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_tx_duty *)skb->data;
+
+	static_assert(RTW89_THERMAL_PROT_LV_MAX * RTW89_THERMAL_PROT_STEP < 100);
+
+	if (lv == 0 || lv > RTW89_THERMAL_PROT_LV_MAX) {
+		h2c->w1 = le32_encode_bits(1, RTW89_H2C_TX_DUTY_W1_STOP);
+	} else {
+		active = 100 - lv * RTW89_THERMAL_PROT_STEP;
+		pause = 100 - active;
+
+		h2c->w0 = le32_encode_bits(pause, RTW89_H2C_TX_DUTY_W0_PAUSE_INTVL_MASK) |
+			  le32_encode_bits(active, RTW89_H2C_TX_DUTY_W0_TX_INTVL_MASK);
+	}
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_TX_DUTY, 0, 0, len);
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
 int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  bool connect)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d338c3aec725..2e2035705881 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3689,6 +3689,13 @@ struct rtw89_c2h_pkt_ofld_rsp {
 #define RTW89_C2H_PKT_OFLD_RSP_W2_PTK_OP GENMASK(10, 8)
 #define RTW89_C2H_PKT_OFLD_RSP_W2_PTK_LEN GENMASK(31, 16)
 
+struct rtw89_c2h_tx_duty_rpt {
+	struct rtw89_c2h_hdr c2h_hdr;
+	__le32 w2;
+} __packed;
+
+#define RTW89_C2H_TX_DUTY_RPT_W2_TIMER_ERR GENMASK(2, 0)
+
 struct rtw89_c2h_wow_aoac_report {
 	struct rtw89_c2h_hdr c2h_hdr;
 	u8 rpt_ver;
@@ -3713,6 +3720,15 @@ struct rtw89_c2h_wow_aoac_report {
 
 #define RTW89_C2H_WOW_AOAC_RPT_REKEY_IDX BIT(0)
 
+struct rtw89_h2c_tx_duty {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_H2C_TX_DUTY_W0_PAUSE_INTVL_MASK GENMASK(15, 0)
+#define RTW89_H2C_TX_DUTY_W0_TX_INTVL_MASK GENMASK(31, 16)
+#define RTW89_H2C_TX_DUTY_W1_STOP BIT(0)
+
 struct rtw89_h2c_bcnfltr {
 	__le32 w0;
 } __packed;
@@ -4071,6 +4087,7 @@ enum rtw89_fw_ofld_h2c_func {
 	H2C_FUNC_OFLD_CFG		= 0x14,
 	H2C_FUNC_ADD_SCANOFLD_CH	= 0x16,
 	H2C_FUNC_SCANOFLD		= 0x17,
+	H2C_FUNC_TX_DUTY		= 0x18,
 	H2C_FUNC_PKT_DROP		= 0x1b,
 	H2C_FUNC_CFG_BCNFLTR		= 0x1e,
 	H2C_FUNC_OFLD_RSSI		= 0x1f,
@@ -4506,6 +4523,7 @@ int rtw89_fw_h2c_macid_pause(struct rtw89_dev *rtwdev, u8 sh, u8 grp,
 int rtw89_fw_h2c_set_edca(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
 			  u8 ac, u32 val);
 int rtw89_fw_h2c_set_ofld_cfg(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_tx_duty(struct rtw89_dev *rtwdev, u8 lv);
 int rtw89_fw_h2c_set_bcn_fltr_cfg(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif_link *rtwvif_link,
 				  bool connect);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e09f926bb4a0..588e2b96bf43 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5028,6 +5028,18 @@ rtw89_mac_c2h_pkt_ofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h,
 	rtw89_complete_cond(wait, cond, &data);
 }
 
+static void
+rtw89_mac_c2h_tx_duty_rpt(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 len)
+{
+	struct rtw89_c2h_tx_duty_rpt *c2h =
+		(struct rtw89_c2h_tx_duty_rpt *)skb_c2h->data;
+	u8 err;
+
+	err = le32_get_bits(c2h->w2, RTW89_C2H_TX_DUTY_RPT_W2_TIMER_ERR);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK, "C2H TX duty rpt with err=%d\n", err);
+}
+
 static void
 rtw89_mac_c2h_tsf32_toggle_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h,
 			       u32 len)
@@ -5354,6 +5366,7 @@ void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_BCN_RESEND] = NULL,
 	[RTW89_MAC_C2H_FUNC_MACID_PAUSE] = rtw89_mac_c2h_macid_pause,
 	[RTW89_MAC_C2H_FUNC_SCANOFLD_RSP] = rtw89_mac_c2h_scanofld_rsp,
+	[RTW89_MAC_C2H_FUNC_TX_DUTY_RPT] = rtw89_mac_c2h_tx_duty_rpt,
 	[RTW89_MAC_C2H_FUNC_TSF32_TOGL_RPT] = rtw89_mac_c2h_tsf32_toggle_rpt,
 	[RTW89_MAC_C2H_FUNC_BCNFLTR_RPT] = rtw89_mac_c2h_bcn_fltr_rpt,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index e59c1fcfea46..721fa3b4f82b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -391,6 +391,7 @@ enum rtw89_mac_c2h_ofld_func {
 	RTW89_MAC_C2H_FUNC_MACID_PAUSE,
 	RTW89_MAC_C2H_FUNC_TSF32_TOGL_RPT = 0x6,
 	RTW89_MAC_C2H_FUNC_SCANOFLD_RSP = 0x9,
+	RTW89_MAC_C2H_FUNC_TX_DUTY_RPT = 0xa,
 	RTW89_MAC_C2H_FUNC_BCNFLTR_RPT = 0xd,
 	RTW89_MAC_C2H_FUNC_OFLD_MAX,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5a08e3d46bac..f24aca663cf0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4836,11 +4836,36 @@ static void rtw89_phy_antdiv_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_antdiv_reg_init(rtwdev);
 }
 
+static void rtw89_phy_thermal_protect(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u8 th_max = phystat->last_thermal_max;
+	u8 lv = hal->thermal_prot_lv;
+
+	if (!hal->thermal_prot_th ||
+	    (hal->disabled_dm_bitmap & BIT(RTW89_DM_THERMAL_PROTECT)))
+		return;
+
+	if (th_max > hal->thermal_prot_th && lv < RTW89_THERMAL_PROT_LV_MAX)
+		lv++;
+	else if (th_max < hal->thermal_prot_th - 2 && lv > 0)
+		lv--;
+	else
+		return;
+
+	hal->thermal_prot_lv = lv;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK, "thermal protection lv=%d\n", lv);
+
+	rtw89_fw_h2c_tx_duty(rtwdev, hal->thermal_prot_lv);
+}
+
 static void rtw89_phy_stat_thermal_update(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
+	u8 th, th_max = 0;
 	int i;
-	u8 th;
 
 	for (i = 0; i < rtwdev->chip->rf_path_num; i++) {
 		th = rtw89_chip_get_thermal(rtwdev, i);
@@ -4850,7 +4875,11 @@ static void rtw89_phy_stat_thermal_update(struct rtw89_dev *rtwdev)
 		rtw89_debug(rtwdev, RTW89_DBG_RFK_TRACK,
 			    "path(%d) thermal cur=%u avg=%ld", i, th,
 			    ewma_thermal_read(&phystat->avg_thermal[i]));
+
+		th_max = max(th_max, th);
 	}
+
+	phystat->last_thermal_max = th_max;
 }
 
 struct rtw89_phy_iter_rssi_data {
@@ -4923,6 +4952,8 @@ static void rtw89_phy_stat_init(struct rtw89_dev *rtwdev)
 	memset(&phystat->last_pkt_stat, 0, sizeof(phystat->last_pkt_stat));
 
 	ewma_rssi_init(&phystat->bcn_rssi);
+
+	rtwdev->hal.thermal_prot_lv = 0;
 }
 
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
@@ -4930,6 +4961,7 @@ void rtw89_phy_stat_track(struct rtw89_dev *rtwdev)
 	struct rtw89_phy_stat *phystat = &rtwdev->phystat;
 
 	rtw89_phy_stat_thermal_update(rtwdev);
+	rtw89_phy_thermal_protect(rtwdev);
 	rtw89_phy_stat_rssi_update(rtwdev);
 
 	phystat->last_pkt_stat = phystat->cur_pkt_stat;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index f9766bf30e71..4f24a6e41989 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2454,6 +2454,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000},
+	.thermal_th		= {0x32, 0x35},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.bb_table		= &rtw89_8851b_phy_bb_table,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 42d369d2e916..e647759ebd69 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2170,6 +2170,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xc000, 0xd000},
+	.thermal_th		= {0x32, 0x35},
 	.pwr_on_seq		= pwr_on_seq_8852a,
 	.pwr_off_seq		= pwr_off_seq_8852a,
 	.bb_table		= &rtw89_8852a_phy_bb_table,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 364aa21cbd44..9fa1d1848c63 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -808,6 +808,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
+	.thermal_th		= {0x32, 0x35},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.bb_table		= &rtw89_8852b_phy_bb_table,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index dab7e71ec6a1..90a4947103d6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -742,6 +742,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
+	.thermal_th		= {0x32, 0x35},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.bb_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index dbe77abb2c48..d2463a71acd0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2947,6 +2947,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.wde_qempty_acq_grpnum	= 16,
 	.wde_qempty_mgq_grpsel	= 16,
 	.rf_base_addr		= {0xe000, 0xf000},
+	.thermal_th		= {0x32, 0x35},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.bb_table		= &rtw89_8852c_phy_bb_table,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 58c9721ac3ab..a07534df2eb2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2218,10 +2218,12 @@ static void rtw8922a_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 static u8 rtw8922a_get_thermal(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path)
 {
 	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	int th;
 
-	/* read thermal only if debugging */
-	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_CFO | RTW89_DBG_RFK_TRACK))
+	/* read thermal only if debugging or thermal protection enabled */
+	if (!rtw89_debug_is_enabled(rtwdev, RTW89_DBG_CFO | RTW89_DBG_RFK_TRACK) &&
+	    !hal->thermal_prot_th)
 		return 80;
 
 	rtw89_write_rf(rtwdev, rf_path, RR_TM, RR_TM_TRI, 0x1);
@@ -2652,6 +2654,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.wde_qempty_acq_grpnum	= 4,
 	.wde_qempty_mgq_grpsel	= 4,
 	.rf_base_addr		= {0xe000, 0xf000},
+	.thermal_th		= {0xad, 0xb4},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.bb_table		= NULL,
-- 
2.25.1


