Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8777DC19
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Aug 2023 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242885AbjHPIW5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Aug 2023 04:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242878AbjHPIWb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Aug 2023 04:22:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24B1E212E
        for <linux-wireless@vger.kernel.org>; Wed, 16 Aug 2023 01:22:28 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37G8M1hoC001274, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37G8M1hoC001274
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 16:22:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 16 Aug 2023 16:22:21 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 16 Aug
 2023 16:22:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: sar: let caller decide the center frequency to query
Date:   Wed, 16 Aug 2023 16:21:30 +0800
Message-ID: <20230816082133.57474-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230816082133.57474-1-pkshih@realtek.com>
References: <20230816082133.57474-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

If multiple channels, SAR will be hard to determine the center frequency
to query. Therefore, we move this decision out of SAR.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 10 +++++----
 drivers/net/wireless/realtek/rtw89/phy.c   |  8 ++++++--
 drivers/net/wireless/realtek/rtw89/sar.c   | 24 +++++++++++-----------
 drivers/net/wireless/realtek/rtw89/sar.h   |  6 +++---
 4 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index f6f1e90c3934..48635458c36a 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -572,9 +572,9 @@ static int __print_txpwr_map(struct seq_file *m, struct rtw89_dev *rtwdev,
 		seq_puts(m, #_regd "\n"); \
 		break
 
-static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev)
+static void __print_regd(struct seq_file *m, struct rtw89_dev *rtwdev,
+			 const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 	u8 band = chan->band_type;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 
@@ -604,16 +604,18 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 {
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	const struct rtw89_chan *chan;
 	int ret = 0;
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
+	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
 
 	seq_puts(m, "[Regulatory] ");
-	__print_regd(m, rtwdev);
+	__print_regd(m, rtwdev, chan);
 
 	seq_puts(m, "[SAR]\n");
-	rtw89_print_sar(m, rtwdev);
+	rtw89_print_sar(m, rtwdev, chan->freq);
 
 	seq_puts(m, "[TAS]\n");
 	rtw89_print_tas(m, rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c40c4f8c1271..fcdc61597b9b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1647,6 +1647,8 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	const struct rtw89_txpwr_rule_5ghz *rule_5ghz = &rfe_parms->rule_5ghz;
 	const struct rtw89_txpwr_rule_6ghz *rule_6ghz = &rfe_parms->rule_6ghz;
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	u32 freq = ieee80211_channel_to_frequency(ch, nl_band);
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
@@ -1682,7 +1684,7 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 	}
 
 	lmt = _phy_txpwr_rf_to_mac(rtwdev, lmt);
-	sar = rtw89_query_sar(rtwdev);
+	sar = rtw89_query_sar(rtwdev, freq);
 
 	return min(lmt, sar);
 }
@@ -1902,6 +1904,8 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 	const struct rtw89_txpwr_rule_5ghz *rule_5ghz = &rfe_parms->rule_5ghz;
 	const struct rtw89_txpwr_rule_6ghz *rule_6ghz = &rfe_parms->rule_6ghz;
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	u32 freq = ieee80211_channel_to_frequency(ch, nl_band);
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
@@ -1937,7 +1941,7 @@ static s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 	}
 
 	lmt_ru = _phy_txpwr_rf_to_mac(rtwdev, lmt_ru);
-	sar = rtw89_query_sar(rtwdev);
+	sar = rtw89_query_sar(rtwdev, freq);
 
 	return min(lmt_ru, sar);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index fafc7a0cfe97..881322f85d79 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -85,17 +85,15 @@ static const struct rtw89_sar_span rtw89_sar_overlapping_6ghz[] = {
 	RTW89_DECL_SAR_6GHZ_SPAN(6885, SUBBAND_7_H, SUBBAND_8),
 };
 
-static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev, s32 *cfg)
+static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev,
+					 u32 center_freq, s32 *cfg)
 {
 	struct rtw89_sar_cfg_common *rtwsar = &rtwdev->sar.cfg_common;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
-	enum rtw89_band band = chan->band_type;
-	u32 center_freq = chan->freq;
 	const struct rtw89_sar_span *span = NULL;
 	enum rtw89_sar_subband subband_l, subband_h;
 	int idx;
 
-	if (band == RTW89_BAND_6G) {
+	if (center_freq >= RTW89_SAR_6GHZ_SPAN_HEAD) {
 		idx = RTW89_SAR_6GHZ_SPAN_IDX(center_freq);
 		/* To decrease size of rtw89_sar_overlapping_6ghz[],
 		 * RTW89_SAR_6GHZ_SPAN_IDX() truncates the leading NULLs
@@ -115,8 +113,8 @@ static int rtw89_query_sar_config_common(struct rtw89_dev *rtwdev, s32 *cfg)
 	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_SAR,
-		    "for {band %u, center_freq %u}, SAR subband: {%u, %u}\n",
-		    band, center_freq, subband_l, subband_h);
+		    "center_freq %u: SAR subband {%u, %u}\n",
+		    center_freq, subband_l, subband_h);
 
 	if (!rtwsar->set[subband_l] && !rtwsar->set[subband_h])
 		return -ENODATA;
@@ -186,7 +184,7 @@ static s8 rtw89_txpwr_sar_to_tas(const struct rtw89_sar_handler *sar_hdl,
 		return cfg << (RTW89_TAS_FACTOR - fct);
 }
 
-s8 rtw89_query_sar(struct rtw89_dev *rtwdev)
+s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
@@ -202,7 +200,7 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev)
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return RTW89_SAR_TXPWR_MAC_MAX;
 
-	ret = sar_hdl->query_sar_config(rtwdev, &cfg);
+	ret = sar_hdl->query_sar_config(rtwdev, center_freq, &cfg);
 	if (ret)
 		return RTW89_SAR_TXPWR_MAC_MAX;
 
@@ -224,7 +222,7 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev)
 	return rtw89_txpwr_sar_to_mac(rtwdev, fct, cfg);
 }
 
-void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev)
+void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev, u32 center_freq)
 {
 	const enum rtw89_sar_sources src = rtwdev->sar.src;
 	/* its members are protected by rtw89_sar_set_src() */
@@ -243,7 +241,7 @@ void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev)
 
 	seq_printf(m, "source: %d (%s)\n", src, sar_hdl->descr_sar_source);
 
-	ret = sar_hdl->query_sar_config(rtwdev, &cfg);
+	ret = sar_hdl->query_sar_config(rtwdev, center_freq, &cfg);
 	if (ret) {
 		seq_printf(m, "config: return code: %d\n", ret);
 		seq_printf(m, "assign: max setting: %d (unit: 1/%lu dBm)\n",
@@ -359,6 +357,7 @@ static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
 	s32 txpwr_avg = tas->total_txpwr / RTW89_TAS_MAX_WINDOW / PERCENT;
 	s32 dpr_on_threshold, dpr_off_threshold, cfg;
 	enum rtw89_tas_state state = tas->state;
+	const struct rtw89_chan *chan;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -366,7 +365,8 @@ static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return;
 
-	ret = sar_hdl->query_sar_config(rtwdev, &cfg);
+	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	ret = sar_hdl->query_sar_config(rtwdev, chan->freq, &cfg);
 	if (ret)
 		return;
 
diff --git a/drivers/net/wireless/realtek/rtw89/sar.h b/drivers/net/wireless/realtek/rtw89/sar.h
index 40ce5990ceaf..bd7a657188d9 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.h
+++ b/drivers/net/wireless/realtek/rtw89/sar.h
@@ -13,13 +13,13 @@
 struct rtw89_sar_handler {
 	const char *descr_sar_source;
 	u8 txpwr_factor_sar;
-	int (*query_sar_config)(struct rtw89_dev *rtwdev, s32 *cfg);
+	int (*query_sar_config)(struct rtw89_dev *rtwdev, u32 center_freq, s32 *cfg);
 };
 
 extern const struct cfg80211_sar_capa rtw89_sar_capa;
 
-s8 rtw89_query_sar(struct rtw89_dev *rtwdev);
-void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev);
+s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq);
+void rtw89_print_sar(struct seq_file *m, struct rtw89_dev *rtwdev, u32 center_freq);
 void rtw89_print_tas(struct seq_file *m, struct rtw89_dev *rtwdev);
 int rtw89_ops_set_sar_specs(struct ieee80211_hw *hw,
 			    const struct cfg80211_sar_specs *sar);
-- 
2.25.1

