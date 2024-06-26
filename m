Return-Path: <linux-wireless+bounces-9567-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF591762D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C6931C217AB
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 02:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C981BC44;
	Wed, 26 Jun 2024 02:32:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0817BAF
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 02:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369173; cv=none; b=AD48YDkCYT8OioCS1vSWIcLu09R/diXTA7E5pgEJFGXqkRZvIyJCkWAfybz8rP8Lw+QY99qJCv5iqq0jeeqEsc9AZF1oclOcNdY3dQaYa/w+OeDnHEZPREiZoAU78hlIiZuiwMvHK+I0zoj0jv7WXeWBFDs4LOCddg09b8DdqPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369173; c=relaxed/simple;
	bh=NNlRuqRkjfe4UU7QtTDuISx+jL57hT8OFSYTKfD6uSc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tHTkKyNad0inHx69FSwNVavLuWPFopC4CUNw9jishJfDKL5hueC4i5z6s4GjR6dK7MuXOGPg76nvfpXyIPp2mDtohIVZMfKJStLtFURSOH6BOe6knZ/r/9WcJtvE8mrmKzi39Fln7WxCQrDk3JvCIwIOWvzVGojwq0BndL1wf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45Q2Wly26877446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45Q2Wly26877446
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <linux-wireless@vger.kernel.org>; Wed, 26 Jun 2024 10:32:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 10:32:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 26 Jun
 2024 10:32:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH] wifi: rtw89: constrain TX power according to Transmit Power Envelope
Date: Wed, 26 Jun 2024 10:32:37 +0800
Message-ID: <20240626023237.7901-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Calculate a TX power constraint based on content of ieee80211 Transmit
Power Envelope (TPE). Since HW control registers aren't designed as many
as all kinds of TPE fields, we strictly intersect all TPE inputs in driver.
Then, according to result, constrain TX power via TX power limit/limit_RU.

Besides, extend dbgfs txpwr_table to show info about 6 GHz regulatory.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.h     |  14 +-
 drivers/net/wireless/realtek/rtw89/debug.c    |  25 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   3 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  38 +++-
 drivers/net/wireless/realtek/rtw89/regd.c     | 190 +++++++++++++++++-
 6 files changed, 262 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 87c38cdc691b..f24f1521f91c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3375,8 +3375,12 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
 		/* for station mode, assign the mac_id from itself */
 		rtwsta->mac_id = rtwvif->mac_id;
-		/* must do rtw89_reg_6ghz_power_recalc() before rfk channel */
-		rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif, true);
+
+		/* must do rtw89_reg_6ghz_recalc() before rfk channel */
+		ret = rtw89_reg_6ghz_recalc(rtwdev, rtwvif, true);
+		if (ret)
+			return ret;
+
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_CONN_START);
 		rtw89_chip_rfk_channel(rtwdev);
@@ -3564,7 +3568,7 @@ int rtw89_core_sta_remove(struct rtw89_dev *rtwdev,
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls) {
-		rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif, false);
+		rtw89_reg_6ghz_recalc(rtwdev, rtwvif, false);
 		rtw89_btc_ntfy_role_info(rtwdev, rtwvif, rtwsta,
 					 BTC_ROLE_MSTS_STA_DIS_CONN);
 	} else if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b55071f21a53..5fa8827dbb1b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -746,6 +746,14 @@ enum rtw89_reg_6ghz_power {
 	RTW89_REG_6GHZ_POWER_DFLT = RTW89_REG_6GHZ_POWER_VLP,
 };
 
+#define RTW89_MIN_VALID_POWER_CONSTRAINT (-10) /* unit: dBm */
+
+/* calculate based on ieee80211 Transmit Power Envelope */
+struct rtw89_reg_6ghz_tpe {
+	bool valid;
+	s8 constraint; /* unit: dBm */
+};
+
 enum rtw89_fw_pkt_ofld_type {
 	RTW89_PKT_OFLD_TYPE_PROBE_RSP = 0,
 	RTW89_PKT_OFLD_TYPE_PS_POLL = 1,
@@ -3397,6 +3405,7 @@ struct rtw89_vif {
 	bool chanctx_assigned; /* only valid when running with chanctx_ops */
 	enum rtw89_sub_entity_idx sub_entity_idx;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
+	struct rtw89_reg_6ghz_tpe reg_6ghz_tpe;
 
 	u8 mac_id;
 	u8 port;
@@ -4938,6 +4947,7 @@ struct rtw89_regd {
 struct rtw89_regulatory_info {
 	const struct rtw89_regd *regd;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
+	struct rtw89_reg_6ghz_tpe reg_6ghz_tpe;
 	DECLARE_BITMAP(block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz_sp, RTW89_REGD_MAX_COUNTRY_NUM);
@@ -6532,8 +6542,8 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   const u8 *mac_addr, bool hw_scan);
 void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 			      struct ieee80211_vif *vif, bool hw_scan);
-void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif, bool active);
+int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			  bool active);
 void rtw89_core_update_p2p_ps(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event);
 
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 49bbbd049316..9cbf136aa2ac 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -818,6 +818,28 @@ static const struct dbgfs_txpwr_table *dbgfs_txpwr_tables[RTW89_CHIP_GEN_NUM] =
 	[RTW89_CHIP_BE] = &dbgfs_txpwr_table_be,
 };
 
+static
+void rtw89_debug_priv_txpwr_table_get_regd(struct seq_file *m,
+					   struct rtw89_dev *rtwdev,
+					   const struct rtw89_chan *chan)
+{
+	const struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_reg_6ghz_tpe *tpe6 = &regulatory->reg_6ghz_tpe;
+
+	seq_printf(m, "[Chanctx] band %u, ch %u, bw %u\n",
+		   chan->band_type, chan->channel, chan->band_width);
+
+	seq_puts(m, "[Regulatory] ");
+	__print_regd(m, rtwdev, chan);
+
+	if (chan->band_type == RTW89_BAND_6G) {
+		seq_printf(m, "[reg6_pwr_type] %u\n", regulatory->reg_6ghz_power);
+
+		if (tpe6->valid)
+			seq_printf(m, "[TPE] %d dBm\n", tpe6->constraint);
+	}
+}
+
 static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
@@ -831,8 +853,7 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 	rtw89_leave_ps_mode(rtwdev);
 	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
-	seq_puts(m, "[Regulatory] ");
-	__print_regd(m, rtwdev, chan);
+	rtw89_debug_priv_txpwr_table_get_regd(m, rtwdev, chan);
 
 	seq_puts(m, "[SAR]\n");
 	rtw89_print_sar(m, rtwdev, chan->freq);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 41b286da3d59..c8a0ad0cffc9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -487,6 +487,9 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_CQM)
 		rtw89_fw_h2c_set_bcn_fltr_cfg(rtwdev, vif, true);
 
+	if (changed & BSS_CHANGED_TPE)
+		rtw89_reg_6ghz_recalc(rtwdev, rtwvif, true);
+
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 60f20e596321..e025f0ed9f59 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1847,6 +1847,36 @@ static s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
 	return txpwr_rf >> (chip->txpwr_factor_rf - chip->txpwr_factor_mac);
 }
 
+static s8 rtw89_phy_txpwr_dbm_to_mac(struct rtw89_dev *rtwdev, s8 dbm)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return clamp_t(s16, dbm << chip->txpwr_factor_mac, -64, 63);
+}
+
+static s8 rtw89_phy_txpwr_dbm_without_tolerance(s8 dbm)
+{
+	const u8 tssi_deviation_point = 0;
+	const u8 tssi_max_deviation = 2;
+
+	if (dbm <= tssi_deviation_point)
+		dbm -= tssi_max_deviation;
+
+	return dbm;
+}
+
+static s8 rtw89_phy_get_tpe_constraint(struct rtw89_dev *rtwdev, u8 band)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_reg_6ghz_tpe *tpe = &regulatory->reg_6ghz_tpe;
+	s8 cstr = S8_MAX;
+
+	if (band == RTW89_BAND_6G && tpe->valid)
+		cstr = rtw89_phy_txpwr_dbm_without_tolerance(tpe->constraint);
+
+	return rtw89_phy_txpwr_dbm_to_mac(rtwdev, cstr);
+}
+
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 			       const struct rtw89_rate_desc *rate_desc)
 {
@@ -1921,6 +1951,7 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
 	s8 lmt = 0, sar;
+	s8 cstr;
 
 	switch (band) {
 	case RTW89_BAND_2G:
@@ -1953,8 +1984,9 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 
 	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt);
 	sar = rtw89_query_sar(rtwdev, freq);
+	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
-	return min(lmt, sar);
+	return min3(lmt, sar, cstr);
 }
 EXPORT_SYMBOL(rtw89_phy_read_txpwr_limit);
 
@@ -2178,6 +2210,7 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
 	s8 lmt_ru = 0, sar;
+	s8 cstr;
 
 	switch (band) {
 	case RTW89_BAND_2G:
@@ -2210,8 +2243,9 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 
 	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt_ru);
 	sar = rtw89_query_sar(rtwdev, freq);
+	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
-	return min(lmt_ru, sar);
+	return min3(lmt_ru, sar, cstr);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 1a133914f673..a251b0e3b16e 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -714,7 +714,154 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	mutex_unlock(&rtwdev->mutex);
 }
 
-static void __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
+/* Maximum Transmit Power field (@raw) can be EIRP or PSD.
+ * Both units are 0.5 dB-based. Return a constraint in dB.
+ */
+static s8 tpe_get_constraint(s8 raw)
+{
+	const u8 hw_deviation = 3; /* unit: 0.5 dB */
+	const u8 antenna_gain = 10; /* unit: 0.5 dB */
+	const u8 array_gain = 6; /* unit: 0.5 dB */
+	const u8 offset = hw_deviation + antenna_gain + array_gain;
+
+	return (raw - offset) / 2;
+}
+
+static void tpe_intersect_constraint(struct rtw89_reg_6ghz_tpe *tpe, s8 cstr)
+{
+	if (tpe->valid) {
+		tpe->constraint = min(tpe->constraint, cstr);
+		return;
+	}
+
+	tpe->constraint = cstr;
+	tpe->valid = true;
+}
+
+static void tpe_deal_with_eirp(struct rtw89_reg_6ghz_tpe *tpe,
+			       const struct ieee80211_parsed_tpe_eirp *eirp)
+{
+	unsigned int i;
+	s8 cstr;
+
+	if (!eirp->valid)
+		return;
+
+	for (i = 0; i < eirp->count; i++) {
+		cstr = tpe_get_constraint(eirp->power[i]);
+		tpe_intersect_constraint(tpe, cstr);
+	}
+}
+
+static s8 tpe_convert_psd_to_eirp(s8 psd)
+{
+	static const unsigned int mlog20 = 1301;
+
+	return psd + 10 * mlog20 / 1000;
+}
+
+static void tpe_deal_with_psd(struct rtw89_reg_6ghz_tpe *tpe,
+			      const struct ieee80211_parsed_tpe_psd *psd)
+{
+	unsigned int i;
+	s8 cstr_psd;
+	s8 cstr;
+
+	if (!psd->valid)
+		return;
+
+	for (i = 0; i < psd->count; i++) {
+		cstr_psd = tpe_get_constraint(psd->power[i]);
+		cstr = tpe_convert_psd_to_eirp(cstr_psd);
+		tpe_intersect_constraint(tpe, cstr);
+	}
+}
+
+static void rtw89_calculate_tpe(struct rtw89_dev *rtwdev,
+				struct rtw89_reg_6ghz_tpe *result_tpe,
+				const struct ieee80211_parsed_tpe *parsed_tpe)
+{
+	static const u8 category = IEEE80211_TPE_CAT_6GHZ_DEFAULT;
+
+	tpe_deal_with_eirp(result_tpe, &parsed_tpe->max_local[category]);
+	tpe_deal_with_eirp(result_tpe, &parsed_tpe->max_reg_client[category]);
+	tpe_deal_with_psd(result_tpe, &parsed_tpe->psd_local[category]);
+	tpe_deal_with_psd(result_tpe, &parsed_tpe->psd_reg_client[category]);
+}
+
+static bool __rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	struct rtw89_reg_6ghz_tpe new = {};
+	struct rtw89_vif *rtwvif;
+	bool changed = false;
+
+	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
+		const struct rtw89_reg_6ghz_tpe *tmp;
+		const struct rtw89_chan *chan;
+
+		chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+		if (chan->band_type != RTW89_BAND_6G)
+			continue;
+
+		tmp = &rtwvif->reg_6ghz_tpe;
+		if (!tmp->valid)
+			continue;
+
+		tpe_intersect_constraint(&new, tmp->constraint);
+	}
+
+	if (memcmp(&regulatory->reg_6ghz_tpe, &new,
+		   sizeof(regulatory->reg_6ghz_tpe)) != 0)
+		changed = true;
+
+	if (changed) {
+		if (new.valid)
+			rtw89_debug(rtwdev, RTW89_DBG_REGD,
+				    "recalc 6 GHz reg TPE to %d dBm\n",
+				    new.constraint);
+		else
+			rtw89_debug(rtwdev, RTW89_DBG_REGD,
+				    "recalc 6 GHz reg TPE to none\n");
+
+		regulatory->reg_6ghz_tpe = new;
+	}
+
+	return changed;
+}
+
+static int rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif *rtwvif, bool active,
+				     unsigned int *changed)
+{
+	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
+	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct rtw89_reg_6ghz_tpe *tpe = &rtwvif->reg_6ghz_tpe;
+
+	memset(tpe, 0, sizeof(*tpe));
+
+	if (!active || rtwvif->reg_6ghz_power != RTW89_REG_6GHZ_POWER_STD)
+		goto bottom;
+
+	rtw89_calculate_tpe(rtwdev, tpe, &bss_conf->tpe);
+	if (!tpe->valid)
+		goto bottom;
+
+	if (tpe->constraint < RTW89_MIN_VALID_POWER_CONSTRAINT) {
+		rtw89_err(rtwdev,
+			  "%s: constraint %d dBm is less than min valid val\n",
+			  __func__, tpe->constraint);
+
+		tpe->valid = false;
+		return -EINVAL;
+	}
+
+bottom:
+	*changed += __rtw89_reg_6ghz_tpe_recalc(rtwdev);
+	return 0;
+}
+
+static bool __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_regd *regd = regulatory->regd;
@@ -751,23 +898,21 @@ static void __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 	}
 
 	if (regulatory->reg_6ghz_power == sel)
-		return;
+		return false;
 
 	rtw89_debug(rtwdev, RTW89_DBG_REGD,
 		    "recalc 6 GHz reg power type to %d\n", sel);
 
 	regulatory->reg_6ghz_power = sel;
-
-	rtw89_core_set_chip_txpwr(rtwdev);
+	return true;
 }
 
-void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
-				 struct rtw89_vif *rtwvif, bool active)
+static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif *rtwvif, bool active,
+				       unsigned int *changed)
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 
-	lockdep_assert_held(&rtwdev->mutex);
-
 	if (active) {
 		switch (vif->bss_conf.power_type) {
 		case IEEE80211_REG_VLP_AP:
@@ -787,5 +932,32 @@ void rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 		rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
 	}
 
-	__rtw89_reg_6ghz_power_recalc(rtwdev);
+	*changed += __rtw89_reg_6ghz_power_recalc(rtwdev);
+	return 0;
+}
+
+int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+			  bool active)
+{
+	unsigned int changed = 0;
+	int ret;
+
+	lockdep_assert_held(&rtwdev->mutex);
+
+	/* The result of reg_6ghz_tpe may depend on reg_6ghz_power type,
+	 * so must do reg_6ghz_tpe_recalc() after reg_6ghz_power_recalc().
+	 */
+
+	ret = rtw89_reg_6ghz_power_recalc(rtwdev, rtwvif, active, &changed);
+	if (ret)
+		return ret;
+
+	ret = rtw89_reg_6ghz_tpe_recalc(rtwdev, rtwvif, active, &changed);
+	if (ret)
+		return ret;
+
+	if (changed)
+		rtw89_core_set_chip_txpwr(rtwdev);
+
+	return 0;
 }
-- 
2.25.1


