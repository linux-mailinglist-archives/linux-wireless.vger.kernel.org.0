Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2415549C
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2020 10:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgBGJ2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Feb 2020 04:28:54 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44677 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgBGJ2y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Feb 2020 04:28:54 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0179SlkG018552, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0179SlkG018552
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 17:28:47 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:47 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 7 Feb 2020 17:28:47 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Fri, 7 Feb 2020 17:28:47 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Fri, 7 Feb 2020 17:28:46 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <pkshih@realtek.com>
Subject: [PATCH 1/8] rtw88: sar: add SAR of TX power limit
Date:   Fri, 7 Feb 2020 17:28:37 +0800
Message-ID: <20200207092844.29175-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207092844.29175-1-yhchuang@realtek.com>
References: <20200207092844.29175-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Originally, there are three factors of TX power:
 1) TX base power, calibrated manually and programmed in efuse.
 2) By-rate power, an offset to increase power depends on TX rate.
 3) TX limit power, an offset to contraint the max power.

So, driver can get the TX power index by using:
    TX_POWER_IDX = tx_base_power + min(by-rate, limit)

To take SAR into consideration, we can treat it as another limit of
the TX power. Then driver can get the TX power by using:
    TX_POWER_IDX = tx_base_power + min(by-rate, limit, sar)

Note that the values stored in driver are not presented in dBm, so
driver needs to also convert the power limit indexes of SAR with
tx_scale_factor, then get the difference to the TX base power.
rtw_phy_set_tx_power_sar() will convert the values of SAR power in unit of
0.125d Bm (sar_q3) and store them in tx_pwr_sar_{2,5}g[regd][path][rs][ch].

Since certain SAR tables have single one table that isn't regulatory domain
specific, parser can apply to all 'regd' or only one domain RTW_REGD_WW
that SAR TX power limit can be applied no matter which regulatory domain
is selected. Because driver get 'sar' argument by
rtw_phy_get_tx_power_limit() with rule
    sar = is_existing(tx_pwr_sar_{2,5}g[regd]) ? tx_pwr_sar_{2,5}g[regd] :
          tx_pwr_sar_{2,5}g[RTW_REGD_WW];

There are various sources of SAR table, but it is expected to adopt only
one source. So, save current source of rtw_sar_sources to prevent more
than one source are adopted.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c |  14 +-
 drivers/net/wireless/realtek/rtw88/main.h  |  17 ++
 drivers/net/wireless/realtek/rtw88/phy.c   | 173 +++++++++++++++++----
 drivers/net/wireless/realtek/rtw88/phy.h   |   3 +
 4 files changed, 175 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5a181e01ebef..3ec15a49ecc9 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -530,8 +530,8 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	u8 ch = hal->current_channel;
 	u8 regd = rtwdev->regd.txpwr_regd;
 
-	seq_printf(m, "%-4s %-10s %-3s%6s %-4s %4s (%-4s %-4s)\n",
-		   "path", "rate", "pwr", "", "base", "", "byr", "lmt");
+	seq_printf(m, "%-4s %-10s %-3s%6s %-4s %4s (%-4s %-4s %-4s)\n",
+		   "path", "rate", "pwr", "", "base", "", "byr", "lmt", "sar");
 
 	mutex_lock(&hal->tx_power_mutex);
 	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
@@ -553,13 +553,15 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 
 			seq_printf(m, "%4c ", path + 'A');
 			rtw_print_rate(m, rate);
-			seq_printf(m, " %3u(0x%02x) %4u %4d (%4d %4d)\n",
+			seq_printf(m, " %3u(0x%02x) %4u %4d (%4d %4d %4d)\n",
 				   hal->tx_pwr_tbl[path][rate],
 				   hal->tx_pwr_tbl[path][rate],
 				   pwr_param.pwr_base,
-				   min_t(s8, pwr_param.pwr_offset,
-					 pwr_param.pwr_limit),
-				   pwr_param.pwr_offset, pwr_param.pwr_limit);
+				   min3(pwr_param.pwr_offset,
+					pwr_param.pwr_limit,
+					pwr_param.pwr_sar),
+				   pwr_param.pwr_offset, pwr_param.pwr_limit,
+				   pwr_param.pwr_sar);
 		}
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index f334d201bfb5..b4e9e18f89a5 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -386,6 +386,13 @@ enum rtw_wow_flags {
 	RTW_WOW_FLAG_MAX,
 };
 
+enum rtw_sar_sources {
+	RTW_SAR_SOURCE_NONE,
+	RTW_SAR_SOURCE_VNDCMD,
+	RTW_SAR_SOURCE_ACPI_STATIC,
+	RTW_SAR_SOURCE_ACPI_DYNAMIC,
+};
+
 /* the power index is represented by differences, which cck-1s & ht40-1s are
  * the base values, so for 1s's differences, there are only ht20 & ofdm
  */
@@ -1513,6 +1520,10 @@ struct rtw_fw_state {
 	u16 h2c_version;
 };
 
+struct rtw_sar {
+	enum rtw_sar_sources source;
+};
+
 struct rtw_hal {
 	u32 rcr;
 
@@ -1558,6 +1569,10 @@ struct rtw_hal {
 			  [RTW_CHANNEL_WIDTH_MAX]
 			  [RTW_RATE_SECTION_MAX]
 			  [RTW_MAX_CHANNEL_NUM_5G];
+	s8 tx_pwr_sar_2g[RTW_REGD_MAX][RTW_RF_PATH_MAX][RTW_RATE_SECTION_MAX]
+			[RTW_MAX_CHANNEL_NUM_2G];
+	s8 tx_pwr_sar_5g[RTW_REGD_MAX][RTW_RF_PATH_MAX][RTW_RATE_SECTION_MAX]
+			[RTW_MAX_CHANNEL_NUM_5G];
 	s8 tx_pwr_tbl[RTW_RF_PATH_MAX]
 		     [DESC_RATE_MAX];
 };
@@ -1630,6 +1645,8 @@ struct rtw_dev {
 	struct rtw_fw_state wow_fw;
 	struct rtw_wow_param wow;
 
+	struct rtw_sar sar;
+
 	/* hci related data, must be last */
 	u8 priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index eea9d888fbf1..930757c07b46 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -1295,6 +1295,94 @@ static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 	}
 }
 
+static void
+rtw_phy_set_tx_power_sar_by_chidx(struct rtw_dev *rtwdev, u8 regd, u8 rfpath,
+				  u8 band, u8 rs, u8 ch_idx, s8 sar)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	s8 base;
+	s8 ww_sar;
+	s8 s;
+
+	if (band == PHY_BAND_2G) {
+		base = hal->tx_pwr_by_rate_base_2g[rfpath][rs];
+		s = sar - base;
+		hal->tx_pwr_sar_2g[regd][rfpath][rs][ch_idx] = s;
+		if (regd == RTW_REGD_WW)
+			return;
+		ww_sar = hal->tx_pwr_sar_2g[RTW_REGD_WW][rfpath][rs][ch_idx];
+		ww_sar = min(ww_sar, s);
+		hal->tx_pwr_sar_2g[RTW_REGD_WW][rfpath][rs][ch_idx] = ww_sar;
+	} else {
+		base = hal->tx_pwr_by_rate_base_5g[rfpath][rs];
+		s = sar - base;
+		hal->tx_pwr_sar_5g[regd][rfpath][rs][ch_idx] = s;
+		if (regd == RTW_REGD_WW)
+			return;
+		ww_sar = hal->tx_pwr_sar_5g[RTW_REGD_WW][rfpath][rs][ch_idx];
+		ww_sar = min(ww_sar, s);
+		hal->tx_pwr_sar_5g[RTW_REGD_WW][rfpath][rs][ch_idx] = ww_sar;
+	}
+}
+
+static void
+rtw_phy_set_tx_power_sar_by_range(struct rtw_dev *rtwdev, u8 regd, u8 rfpath,
+				  u8 band, u8 chidx_start, u8 chidx_end, u8 sar_q3)
+{
+	u8 rs;
+	u8 ch_idx;
+	s8 sar;
+
+	if (regd >= RTW_REGD_MAX || rfpath >= RTW_RF_PATH_MAX)
+		return;
+
+	sar = sar_q3 >> (3 - (int)rtwdev->chip->txgi_factor);
+
+	for (ch_idx = chidx_start; ch_idx <= chidx_end; ch_idx++)
+		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+			rtw_phy_set_tx_power_sar_by_chidx(rtwdev, regd, rfpath,
+							  band, rs, ch_idx, sar);
+}
+
+void rtw_phy_set_tx_power_sar(struct rtw_dev *rtwdev, u8 regd, u8 rfpath,
+			      u8 ch_start, u8 ch_end, u8 sar_q3)
+{
+	u8 band_start, band_end;
+	int chidx_start, chidx_end;
+
+	band_start = ch_start <= 14 ? PHY_BAND_2G : PHY_BAND_5G;
+	band_end = ch_end <= 14 ? PHY_BAND_2G : PHY_BAND_5G;
+
+	if (band_start == band_end) {
+		chidx_start = rtw_channel_to_idx(band_start, ch_start);
+		chidx_end = rtw_channel_to_idx(band_start, ch_end);
+		if (chidx_start < 0 || chidx_end < 0)
+			goto err;
+		rtw_phy_set_tx_power_sar_by_range(rtwdev, regd, rfpath, band_start,
+						  chidx_start, chidx_end, sar_q3);
+		return;
+	}
+
+	chidx_start = rtw_channel_to_idx(PHY_BAND_2G, ch_start);
+	if (chidx_start < 0)
+		goto err;
+	rtw_phy_set_tx_power_sar_by_range(rtwdev, regd, rfpath, PHY_BAND_2G,
+					  chidx_start, RTW_MAX_CHANNEL_NUM_2G - 1,
+					  sar_q3);
+
+	chidx_end = rtw_channel_to_idx(PHY_BAND_5G, ch_end);
+	if (chidx_end < 0)
+		goto err;
+	rtw_phy_set_tx_power_sar_by_range(rtwdev, regd, rfpath, PHY_BAND_5G,
+					  0, chidx_end, sar_q3);
+
+	return;
+
+err:
+	rtw_warn(rtwdev, "SAR: invalid channel (start/end)=(%d/%d)\n",
+		 ch_start, ch_end);
+}
+
 /* cross-reference 5G power limits if values are not assigned */
 static void
 rtw_xref_5g_txpwr_lmt(struct rtw_dev *rtwdev, u8 regd,
@@ -1676,9 +1764,10 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 	return tx_power;
 }
 
-static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
-				     enum rtw_bandwidth bw, u8 rf_path,
-				     u8 rate, u8 channel, u8 regd)
+static void rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
+				       enum rtw_bandwidth bw, u8 rf_path,
+				       u8 rate, u8 channel, u8 regd,
+				       struct rtw_power_params *pwr_param)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	u8 *cch_by_bw = hal->cch_by_bw;
@@ -1687,9 +1776,10 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	int ch_idx;
 	u8 cur_bw, cur_ch;
 	s8 cur_lmt;
+	s8 sar, sar_ww;
 
 	if (regd > RTW_REGD_WW)
-		return power_limit;
+		goto err;
 
 	if (rate >= DESC_RATE1M && rate <= DESC_RATE11M)
 		rs = RTW_RATE_SECTION_CCK;
@@ -1729,44 +1819,68 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 		power_limit = min_t(s8, cur_lmt, power_limit);
 	}
 
-	return power_limit;
+	ch_idx = rtw_channel_to_idx(band, channel);
+	if (ch_idx < 0)
+		goto err;
+
+	if (band == PHY_BAND_2G) {
+		sar = hal->tx_pwr_sar_2g[regd][rf_path][rs][ch_idx];
+		sar_ww = hal->tx_pwr_sar_2g[RTW_REGD_WW][rf_path][rs][ch_idx];
+	} else {
+		sar = hal->tx_pwr_sar_5g[regd][rf_path][rs][ch_idx];
+		sar_ww = hal->tx_pwr_sar_5g[RTW_REGD_WW][rf_path][rs][ch_idx];
+	}
+	if (sar >= rtwdev->chip->max_power_index)
+		sar = sar_ww;
+
+	pwr_param->pwr_sar = sar;
+	pwr_param->pwr_limit = power_limit;
+	return;
 
 err:
 	WARN(1, "invalid arguments, band=%d, bw=%d, path=%d, rate=%d, ch=%d\n",
 	     band, bw, rf_path, rate, channel);
-	return (s8)rtwdev->chip->max_power_index;
+	pwr_param->pwr_sar = (s8)rtwdev->chip->max_power_index;
+	pwr_param->pwr_limit = (s8)rtwdev->chip->max_power_index;
 }
 
-void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
-			     u8 ch, u8 regd, struct rtw_power_params *pwr_param)
+static void rtw_phy_get_tx_power_base(struct rtw_dev *rtwdev, u8 band,
+				      enum rtw_bandwidth bw, u8 path, u8 rate,
+				      u8 ch, struct rtw_power_params *pwr_param)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_txpwr_idx *pwr_idx;
-	u8 group, band;
-	u8 *base = &pwr_param->pwr_base;
-	s8 *offset = &pwr_param->pwr_offset;
-	s8 *limit = &pwr_param->pwr_limit;
+	u8 group;
+	u8 base;
+	s8 offset;
 
 	pwr_idx = &rtwdev->efuse.txpwr_idx_table[path];
 	group = rtw_get_channel_group(ch);
 
 	/* base power index for 2.4G/5G */
-	if (IS_CH_2G_BAND(ch)) {
-		band = PHY_BAND_2G;
-		*base = rtw_phy_get_2g_tx_power_index(rtwdev,
-						      &pwr_idx->pwr_idx_2g,
-						      bw, rate, group);
-		*offset = hal->tx_pwr_by_rate_offset_2g[path][rate];
+	if (band == PHY_BAND_2G) {
+		base = rtw_phy_get_2g_tx_power_index(rtwdev,
+						     &pwr_idx->pwr_idx_2g,
+						     bw, rate, group);
+		offset = hal->tx_pwr_by_rate_offset_2g[path][rate];
 	} else {
-		band = PHY_BAND_5G;
-		*base = rtw_phy_get_5g_tx_power_index(rtwdev,
-						      &pwr_idx->pwr_idx_5g,
-						      bw, rate, group);
-		*offset = hal->tx_pwr_by_rate_offset_5g[path][rate];
+		base = rtw_phy_get_5g_tx_power_index(rtwdev,
+						     &pwr_idx->pwr_idx_5g,
+						     bw, rate, group);
+		offset = hal->tx_pwr_by_rate_offset_5g[path][rate];
 	}
 
-	*limit = rtw_phy_get_tx_power_limit(rtwdev, band, bw, path,
-					    rate, ch, regd);
+	pwr_param->pwr_base = base;
+	pwr_param->pwr_offset = offset;
+}
+
+void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
+			     u8 ch, u8 regd, struct rtw_power_params *pwr_param)
+{
+	u8 band = IS_CH_2G_BAND(ch) ? PHY_BAND_2G : PHY_BAND_5G;
+
+	rtw_phy_get_tx_power_base(rtwdev, band, bw, path, rate, ch, pwr_param);
+	rtw_phy_get_tx_power_limit(rtwdev, band, bw, path, rate, ch, regd, pwr_param);
 }
 
 u8
@@ -1781,7 +1895,8 @@ rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 				channel, regd, &pwr_param);
 
 	tx_power = pwr_param.pwr_base;
-	offset = min_t(s8, pwr_param.pwr_offset, pwr_param.pwr_limit);
+	offset = min3(pwr_param.pwr_offset, pwr_param.pwr_limit,
+		      pwr_param.pwr_sar);
 
 	if (rtwdev->chip->en_dis_dpd)
 		offset += rtw_phy_get_dis_dpd_by_rate_diff(rtwdev, rate);
@@ -1970,6 +2085,12 @@ void rtw_phy_init_tx_power(struct rtw_dev *rtwdev)
 			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
 				rtw_phy_init_tx_power_limit(rtwdev, regd, bw,
 							    rs);
+
+	/* init tx power sar */
+	memset(hal->tx_pwr_sar_2g, rtwdev->chip->max_power_index,
+	       sizeof(hal->tx_pwr_sar_2g));
+	memset(hal->tx_pwr_sar_5g, rtwdev->chip->max_power_index,
+	       sizeof(hal->tx_pwr_sar_5g));
 }
 
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index af916d8784cd..ba9b28a6c0bc 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -139,12 +139,15 @@ struct rtw_power_params {
 	u8 pwr_base;
 	s8 pwr_offset;
 	s8 pwr_limit;
+	s8 pwr_sar;
 };
 
 void
 rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path,
 			u8 rate, u8 bw, u8 ch, u8 regd,
 			struct rtw_power_params *pwr_param);
+void rtw_phy_set_tx_power_sar(struct rtw_dev *rtwdev, u8 regd, u8 rfpath,
+			      u8 ch_start, u8 ch_end, u8 sar_q3);
 
 enum rtw_phy_cck_pd_lv {
 	CCK_PD_LV0,
-- 
2.17.1

