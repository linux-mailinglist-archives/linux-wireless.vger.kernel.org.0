Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAEB1CD160
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 07:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgEKFsY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 01:48:24 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50597 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgEKFsW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 01:48:22 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04B5m20t9020762, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04B5m20t9020762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 May 2020 13:48:02 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 13:48:02 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 13:48:02 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>, <kevin_yang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH v2 1/7] rtw88: extract: export symbols used in chip functionalities
Date:   Mon, 11 May 2020 13:47:54 +0800
Message-ID: <20200511054800.27422-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511054800.27422-1-yhchuang@realtek.com>
References: <20200511054800.27422-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In the current design, various chip functions and tables
are built into rtw88 core. That causes kernel to load its
functionalities even if a chip isn't currently used. We
plan to make each chip's functionalities a separate
kernel module to reduce rtw88 core. And kernel will be
able to load the necessary.

Before extracting chip functionalities, we export symbols
inside rtw88 core which will be used in chip modules.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/bf.c   |  7 ++++++
 drivers/net/wireless/realtek/rtw88/coex.c |  3 +++
 drivers/net/wireless/realtek/rtw88/fw.c   |  1 +
 drivers/net/wireless/realtek/rtw88/mac.c  |  1 +
 drivers/net/wireless/realtek/rtw88/phy.c  | 26 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rx.c   |  1 +
 drivers/net/wireless/realtek/rtw88/util.c |  2 ++
 7 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index a5912da327e2..8a070d5d9174 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -220,6 +220,7 @@ void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 	/* ndp rx standby timer */
 	rtw_write8(rtwdev, REG_SND_PTCL_CTRL + 3, RTW_NDP_RX_STANDBY_TIME);
 }
+EXPORT_SYMBOL(rtw_bf_enable_bfee_su);
 
 /* nc index: 1 2T2R 0 1T1R
  * nr index: 1 use Nsts 0 use reg setting
@@ -263,6 +264,7 @@ void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 	/* accept NDPA and BF report poll */
 	rtw_write16_set(rtwdev, REG_RXFLTMAP1, BIT_RXFLTMAP1_BF);
 }
+EXPORT_SYMBOL(rtw_bf_enable_bfee_mu);
 
 void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev,
 			   struct rtw_bfee *bfee)
@@ -288,6 +290,7 @@ void rtw_bf_remove_bfee_su(struct rtw_dev *rtwdev,
 	clear_bit(bfee->su_reg_index, bfinfo->bfer_su_reg_maping);
 	bfee->su_reg_index = 0xFF;
 }
+EXPORT_SYMBOL(rtw_bf_remove_bfee_su);
 
 void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev,
 			   struct rtw_bfee *bfee)
@@ -301,6 +304,7 @@ void rtw_bf_remove_bfee_mu(struct rtw_dev *rtwdev,
 	if (bfinfo->bfer_su_cnt == 0 && bfinfo->bfer_mu_cnt == 0)
 		rtw_bf_del_sounding(rtwdev);
 }
+EXPORT_SYMBOL(rtw_bf_remove_bfee_mu);
 
 void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			  struct ieee80211_bss_conf *conf)
@@ -329,6 +333,7 @@ void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 
 	rtw_bf_cfg_mu_bfee(rtwdev, &param);
 }
+EXPORT_SYMBOL(rtw_bf_set_gid_table);
 
 void rtw_bf_phy_init(struct rtw_dev *rtwdev)
 {
@@ -365,6 +370,7 @@ void rtw_bf_phy_init(struct rtw_dev *rtwdev)
 	rtw_write32_mask(rtwdev, REG_BBPSF_CTRL, BIT_MASK_CSI_RATE,
 			 DESC_RATE6M);
 }
+EXPORT_SYMBOL(rtw_bf_phy_init);
 
 void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 			 u8 fixrate_en, u8 *new_rate)
@@ -395,3 +401,4 @@ void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 		*new_rate = DESC_RATE24M;
 	}
 }
+EXPORT_SYMBOL(rtw_bf_cfg_csi_rate);
diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 567372fb4e12..924dccd5d146 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -283,6 +283,7 @@ void rtw_coex_write_scbd(struct rtw_dev *rtwdev, u16 bitpos, bool set)
 		rtw_write16(rtwdev, REG_WIFI_BT_INFO, val);
 	}
 }
+EXPORT_SYMBOL(rtw_coex_write_scbd);
 
 static u16 rtw_coex_read_scbd(struct rtw_dev *rtwdev)
 {
@@ -732,6 +733,7 @@ u32 rtw_coex_read_indirect_reg(struct rtw_dev *rtwdev, u16 addr)
 
 	return val;
 }
+EXPORT_SYMBOL(rtw_coex_read_indirect_reg);
 
 void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
 				 u32 mask, u32 val)
@@ -745,6 +747,7 @@ void rtw_coex_write_indirect_reg(struct rtw_dev *rtwdev, u16 addr,
 	if (!ltecoex_reg_write(rtwdev, addr, tmp))
 		rtw_err(rtwdev, "failed to write indirect register\n");
 }
+EXPORT_SYMBOL(rtw_coex_write_indirect_reg);
 
 static void rtw_coex_coex_ctrl_owner(struct rtw_dev *rtwdev, bool wifi_control)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 2c28afe525c7..6478fd7a78f6 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -330,6 +330,7 @@ void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para)
 
 	rtw_fw_send_h2c_packet(rtwdev, h2c_pkt);
 }
+EXPORT_SYMBOL(rtw_fw_do_iqk);
 
 void rtw_fw_query_bt_info(struct rtw_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wireless/realtek/rtw88/mac.c
index 3a5cfebe5a62..19b9b7ab016b 100644
--- a/drivers/net/wireless/realtek/rtw88/mac.c
+++ b/drivers/net/wireless/realtek/rtw88/mac.c
@@ -56,6 +56,7 @@ void rtw_set_channel_mac(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		value8 |= BIT_CHECK_CCK_EN;
 	rtw_write8(rtwdev, REG_CCK_CHECK, value8);
 }
+EXPORT_SYMBOL(rtw_set_channel_mac);
 
 static int rtw_mac_pre_system_cfg(struct rtw_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 45181f602e3f..8d93f3159746 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -82,6 +82,8 @@ u8 *rtw_rate_section[RTW_RATE_SECTION_MAX] = {
 	rtw_ht_1s_rates, rtw_ht_2s_rates,
 	rtw_vht_1s_rates, rtw_vht_2s_rates
 };
+EXPORT_SYMBOL(rtw_rate_section);
+
 u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
 	ARRAY_SIZE(rtw_cck_rates),
 	ARRAY_SIZE(rtw_ofdm_rates),
@@ -90,6 +92,8 @@ u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
 	ARRAY_SIZE(rtw_vht_1s_rates),
 	ARRAY_SIZE(rtw_vht_2s_rates)
 };
+EXPORT_SYMBOL(rtw_rate_size);
+
 static const u8 rtw_cck_size = ARRAY_SIZE(rtw_cck_rates);
 static const u8 rtw_ofdm_size = ARRAY_SIZE(rtw_ofdm_rates);
 static const u8 rtw_ht_1s_size = ARRAY_SIZE(rtw_ht_1s_rates);
@@ -137,6 +141,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 
 	dm_info->iqk.done = false;
 }
+EXPORT_SYMBOL(rtw_phy_init);
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
 {
@@ -676,6 +681,7 @@ u8 rtw_phy_rf_power_2_rssi(s8 *rf_power, u8 path_num)
 
 	return rtw_phy_linear_2_db(sum);
 }
+EXPORT_SYMBOL(rtw_phy_rf_power_2_rssi);
 
 u32 rtw_phy_read_rf(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 		    u32 addr, u32 mask)
@@ -698,6 +704,7 @@ u32 rtw_phy_read_rf(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 
 	return val;
 }
+EXPORT_SYMBOL(rtw_phy_read_rf);
 
 u32 rtw_phy_read_rf_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			 u32 addr, u32 mask)
@@ -746,6 +753,7 @@ u32 rtw_phy_read_rf_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 
 	return (val32 & mask) >> shift;
 }
+EXPORT_SYMBOL(rtw_phy_read_rf_sipi);
 
 bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			       u32 addr, u32 mask, u32 data)
@@ -785,6 +793,7 @@ bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 
 	return true;
 }
+EXPORT_SYMBOL(rtw_phy_write_rf_reg_sipi);
 
 bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			  u32 addr, u32 mask, u32 data)
@@ -818,6 +827,7 @@ bool rtw_phy_write_rf_reg_mix(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 
 	return rtw_phy_write_rf_reg_sipi(rtwdev, rf_path, addr, mask, data);
 }
+EXPORT_SYMBOL(rtw_phy_write_rf_reg_mix);
 
 void rtw_phy_setup_phy_cond(struct rtw_dev *rtwdev, u32 pkg)
 {
@@ -910,6 +920,7 @@ void rtw_parse_tbl_phy_cond(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 		}
 	}
 }
+EXPORT_SYMBOL(rtw_parse_tbl_phy_cond);
 
 #define bcd_to_dec_pwr_by_rate(val, i) bcd2bin(val >> (i * 8))
 
@@ -1273,6 +1284,7 @@ void rtw_parse_tbl_bb_pg(struct rtw_dev *rtwdev, const struct rtw_table *tbl)
 					       p->data);
 	}
 }
+EXPORT_SYMBOL(rtw_parse_tbl_bb_pg);
 
 static const u8 rtw_channel_idx_5g[RTW_MAX_CHANNEL_NUM_5G] = {
 	36,  38,  40,  42,  44,  46,  48, /* Band 1 */
@@ -1417,18 +1429,21 @@ void rtw_parse_tbl_txpwr_lmt(struct rtw_dev *rtwdev,
 
 	rtw_xref_txpwr_lmt(rtwdev);
 }
+EXPORT_SYMBOL(rtw_parse_tbl_txpwr_lmt);
 
 void rtw_phy_cfg_mac(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		     u32 addr, u32 data)
 {
 	rtw_write8(rtwdev, addr, data);
 }
+EXPORT_SYMBOL(rtw_phy_cfg_mac);
 
 void rtw_phy_cfg_agc(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		     u32 addr, u32 data)
 {
 	rtw_write32(rtwdev, addr, data);
 }
+EXPORT_SYMBOL(rtw_phy_cfg_agc);
 
 void rtw_phy_cfg_bb(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data)
@@ -1448,6 +1463,7 @@ void rtw_phy_cfg_bb(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 	else
 		rtw_write32(rtwdev, addr, data);
 }
+EXPORT_SYMBOL(rtw_phy_cfg_bb);
 
 void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		    u32 addr, u32 data)
@@ -1461,6 +1477,7 @@ void rtw_phy_cfg_rf(struct rtw_dev *rtwdev, const struct rtw_table *tbl,
 		udelay(1);
 	}
 }
+EXPORT_SYMBOL(rtw_phy_cfg_rf);
 
 static void rtw_load_rfk_table(struct rtw_dev *rtwdev)
 {
@@ -1498,6 +1515,7 @@ void rtw_phy_load_tables(struct rtw_dev *rtwdev)
 		rtw_load_table(rtwdev, tbl);
 	}
 }
+EXPORT_SYMBOL(rtw_phy_load_tables);
 
 static u8 rtw_get_channel_group(u8 channel)
 {
@@ -1841,6 +1859,7 @@ rtw_phy_get_tx_power_index(struct rtw_dev *rtwdev, u8 rf_path, u8 rate,
 
 	return tx_power;
 }
+EXPORT_SYMBOL(rtw_phy_get_tx_power_index);
 
 static void rtw_phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
 					     u8 ch, u8 path, u8 rs)
@@ -1903,6 +1922,7 @@ void rtw_phy_set_tx_power_level(struct rtw_dev *rtwdev, u8 channel)
 	chip->ops->set_tx_power_index(rtwdev);
 	mutex_unlock(&hal->tx_power_mutex);
 }
+EXPORT_SYMBOL(rtw_phy_set_tx_power_level);
 
 static void
 rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
@@ -2060,6 +2080,7 @@ void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 		swing_table->n[RF_PATH_B] = tbl->pwrtrk_2gb_n;
 	}
 }
+EXPORT_SYMBOL(rtw_phy_config_swing_table);
 
 void rtw_phy_pwrtrack_avg(struct rtw_dev *rtwdev, u8 thermal, u8 path)
 {
@@ -2069,6 +2090,7 @@ void rtw_phy_pwrtrack_avg(struct rtw_dev *rtwdev, u8 thermal, u8 path)
 	dm_info->thermal_avg[path] =
 		ewma_thermal_read(&dm_info->avg_thermal[path]);
 }
+EXPORT_SYMBOL(rtw_phy_pwrtrack_avg);
 
 bool rtw_phy_pwrtrack_thermal_changed(struct rtw_dev *rtwdev, u8 thermal,
 				      u8 path)
@@ -2081,6 +2103,7 @@ bool rtw_phy_pwrtrack_thermal_changed(struct rtw_dev *rtwdev, u8 thermal,
 
 	return true;
 }
+EXPORT_SYMBOL(rtw_phy_pwrtrack_thermal_changed);
 
 u8 rtw_phy_pwrtrack_get_delta(struct rtw_dev *rtwdev, u8 path)
 {
@@ -2093,6 +2116,7 @@ u8 rtw_phy_pwrtrack_get_delta(struct rtw_dev *rtwdev, u8 path)
 
 	return min_t(u8, therm_delta, RTW_PWR_TRK_TBL_SZ - 1);
 }
+EXPORT_SYMBOL(rtw_phy_pwrtrack_get_delta);
 
 s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
 			       struct rtw_swing_table *swing_table,
@@ -2126,6 +2150,7 @@ s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
 	else
 		return -delta_swing_table_idx_neg[delta];
 }
+EXPORT_SYMBOL(rtw_phy_pwrtrack_get_pwridx);
 
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev)
 {
@@ -2139,3 +2164,4 @@ bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev)
 	}
 	return false;
 }
+EXPORT_SYMBOL(rtw_phy_pwrtrack_need_iqk);
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 9b90339ab697..7087e385a9b3 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -191,3 +191,4 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 
 	rtw_rx_addr_match(rtwdev, pkt_stat, hdr);
 }
+EXPORT_SYMBOL(rtw_rx_fill_rx_status);
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index 42cf177cd445..2c515af214e7 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -19,6 +19,7 @@ bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target)
 
 	return false;
 }
+EXPORT_SYMBOL(check_hw_ready);
 
 bool ltecoex_read_reg(struct rtw_dev *rtwdev, u16 offset, u32 *val)
 {
@@ -76,6 +77,7 @@ void rtw_restore_reg(struct rtw_dev *rtwdev,
 		}
 	}
 }
+EXPORT_SYMBOL(rtw_restore_reg);
 
 void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
 {
-- 
2.17.1

