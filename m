Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109E96AFE63
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 06:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjCHFdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 00:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjCHFdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 00:33:41 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4488C0F2
        for <linux-wireless@vger.kernel.org>; Tue,  7 Mar 2023 21:33:37 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3285XKcA4016238, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3285XKcA4016238
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 8 Mar 2023 13:33:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 8 Mar 2023 13:33:29 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 8 Mar 2023
 13:33:28 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: coex: Add traffic TX/RX info and its H2C
Date:   Wed, 8 Mar 2023 13:32:21 +0800
Message-ID: <20230308053225.24377-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308053225.24377-1-pkshih@realtek.com>
References: <20230308053225.24377-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

There is a new mechanism which can do some real time performance
tuning for WiFi and BT. This TX/RX info is a condition provide to
firmware to do traffic analysis.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.c | 59 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h | 43 +++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c   | 56 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   | 87 +++++++++++++++++++++++
 4 files changed, 241 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index b56897529504a..908ef8bb149a0 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -1809,6 +1809,9 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	const struct rtw89_btc_ver *ver = btc->ver;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
+	struct rtw89_btc_rf_trx_para rf_para = dm->rf_trx_para;
 
 	switch (type) {
 	case CXDRVINFO_INIT:
@@ -1825,6 +1828,19 @@ static void _fw_set_drv_info(struct rtw89_dev *rtwdev, u8 type)
 	case CXDRVINFO_CTRL:
 		rtw89_fw_h2c_cxdrv_ctrl(rtwdev);
 		break;
+	case CXDRVINFO_TRX:
+		dm->trx_info.tx_power = u32_get_bits(rf_para.wl_tx_power,
+						     RTW89_BTC_WL_DEF_TX_PWR);
+		dm->trx_info.rx_gain = u32_get_bits(rf_para.wl_rx_gain,
+						    RTW89_BTC_WL_DEF_TX_PWR);
+		dm->trx_info.bt_tx_power = u32_get_bits(rf_para.bt_tx_power,
+							RTW89_BTC_WL_DEF_TX_PWR);
+		dm->trx_info.bt_rx_gain = u32_get_bits(rf_para.bt_rx_gain,
+						       RTW89_BTC_WL_DEF_TX_PWR);
+		dm->trx_info.cn = wl->cn_report;
+		dm->trx_info.nhm = wl->nhm.pwr;
+		rtw89_fw_h2c_cxdrv_trx(rtwdev);
+		break;
 	case CXDRVINFO_RFK:
 		rtw89_fw_h2c_cxdrv_rfk(rtwdev);
 		break;
@@ -5361,6 +5377,8 @@ void rtw89_btc_ntfy_icmp_packet_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
+#define BT_PROFILE_PROTOCOL_MASK GENMASK(7, 4)
+
 static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -5417,6 +5435,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	a2dp->exist = btinfo.lb2.a2dp;
 	b->profile_cnt.now += (u8)a2dp->exist;
 	pan->active = btinfo.lb2.pan;
+	btc->dm.trx_info.bt_profile = u32_get_bits(btinfo.val, BT_PROFILE_PROTOCOL_MASK);
 
 	/* parse raw info low-Byte3 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_L3];
@@ -5433,6 +5452,7 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 	btinfo.val = bt->raw_info[BTC_BTINFO_H0];
 	/* raw val is dBm unit, translate from -100~ 0dBm to 0~100%*/
 	b->rssi = chip->ops->btc_get_bt_rssi(rtwdev, btinfo.hb0.rssi);
+	btc->dm.trx_info.bt_rssi = b->rssi;
 
 	/* parse raw info high-Byte1 */
 	btinfo.val = bt->raw_info[BTC_BTINFO_H1];
@@ -5766,6 +5786,8 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 				(struct rtw89_btc_wl_sta_iter_data *)data;
 	struct rtw89_dev *rtwdev = iter_data->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
+	const struct rtw89_btc_ver *ver = btc->ver;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_link_info *link_info = NULL;
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
@@ -5773,6 +5795,8 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
 	struct rtw89_traffic_stats *stats = &rtwvif->stats;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_btc_wl_role_info *r;
+	struct rtw89_btc_wl_role_info_v1 *r1;
 	u32 last_tx_rate, last_rx_rate;
 	u16 last_tx_lvl, last_rx_lvl;
 	u8 port = rtwvif->port;
@@ -5849,10 +5873,33 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 	link_info_t->tx_rate = rtwsta->ra_report.hw_rate;
 	link_info_t->rx_rate = rtwsta->rx_hw_rate;
 
-	wl->role_info.active_role[port].tx_lvl = (u16)stats->tx_tfc_lv;
-	wl->role_info.active_role[port].rx_lvl = (u16)stats->rx_tfc_lv;
-	wl->role_info.active_role[port].tx_rate = rtwsta->ra_report.hw_rate;
-	wl->role_info.active_role[port].rx_rate = rtwsta->rx_hw_rate;
+	if (link_info->role == RTW89_WIFI_ROLE_STATION ||
+	    link_info->role == RTW89_WIFI_ROLE_P2P_CLIENT) {
+		dm->trx_info.tx_rate = link_info_t->tx_rate;
+		dm->trx_info.rx_rate = link_info_t->rx_rate;
+	}
+
+	if (ver->fwlrole == 0) {
+		r = &wl->role_info;
+		r->active_role[port].tx_lvl = stats->tx_tfc_lv;
+		r->active_role[port].rx_lvl = stats->rx_tfc_lv;
+		r->active_role[port].tx_rate = rtwsta->ra_report.hw_rate;
+		r->active_role[port].rx_rate = rtwsta->rx_hw_rate;
+	} else if (ver->fwlrole == 1) {
+		r1 = &wl->role_info_v1;
+		r1->active_role_v1[port].tx_lvl = stats->tx_tfc_lv;
+		r1->active_role_v1[port].rx_lvl = stats->rx_tfc_lv;
+		r1->active_role_v1[port].tx_rate = rtwsta->ra_report.hw_rate;
+		r1->active_role_v1[port].rx_rate = rtwsta->rx_hw_rate;
+	} else if (ver->fwlrole == 2) {
+		dm->trx_info.tx_lvl = stats->tx_tfc_lv;
+		dm->trx_info.rx_lvl = stats->rx_tfc_lv;
+		dm->trx_info.tx_rate = rtwsta->ra_report.hw_rate;
+		dm->trx_info.rx_rate = rtwsta->rx_hw_rate;
+	}
+
+	dm->trx_info.tx_tp = link_info_t->tx_throughput;
+	dm->trx_info.rx_tp = link_info_t->rx_throughput;
 
 	if (is_sta_change)
 		iter_data->is_sta_change = true;
@@ -5866,6 +5913,7 @@ static void rtw89_btc_ntfy_wl_sta_iter(void *data, struct ieee80211_sta *sta)
 void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_btc_wl_info *wl = &btc->cx.wl;
 	struct rtw89_btc_wl_sta_iter_data data = {.rtwdev = rtwdev};
 	u8 i;
@@ -5884,6 +5932,9 @@ void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev)
 		}
 	}
 
+	if (dm->trx_info.wl_rssi != wl->rssi_level)
+		dm->trx_info.wl_rssi = wl->rssi_level;
+
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): busy=%d\n",
 		    __func__, !!wl->status.map.busy);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 62c2e0a63a9ba..1d3614f5b2a2b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1367,6 +1367,22 @@ struct rtw89_btc_rf_para {
 	u32 rx_gain_perpkt;
 };
 
+struct rtw89_btc_wl_nhm {
+	u8 instant_wl_nhm_dbm;
+	u8 instant_wl_nhm_per_mhz;
+	u16 valid_record_times;
+	s8 record_pwr[16];
+	u8 record_ratio[16];
+	s8 pwr; /* dbm_per_MHz  */
+	u8 ratio;
+	u8 current_status;
+	u8 refresh;
+	bool start_flag;
+	u8 last_ccx_rpt_stamp;
+	s8 pwr_max;
+	s8 pwr_min;
+};
+
 struct rtw89_btc_wl_info {
 	struct rtw89_btc_wl_link_info link_info[RTW89_PORT_NUM];
 	struct rtw89_btc_wl_rfk_info rfk_info;
@@ -1378,10 +1394,12 @@ struct rtw89_btc_wl_info {
 	struct rtw89_btc_wl_scan_info scan_info;
 	struct rtw89_btc_wl_dbcc_info dbcc_info;
 	struct rtw89_btc_rf_para rf_para;
+	struct rtw89_btc_wl_nhm nhm;
 	union rtw89_btc_wl_state_map status;
 
 	u8 port_id[RTW89_WIFI_ROLE_MLME_MAX];
 	u8 rssi_level;
+	u8 cn_report;
 
 	bool scbd_change;
 	u32 scbd;
@@ -2019,6 +2037,30 @@ struct rtw89_btc_rf_trx_para {
 	u8 bt_rx_gain;  /* LNA constrain level */
 };
 
+struct rtw89_btc_trx_info {
+	u8 tx_lvl;
+	u8 rx_lvl;
+	u8 wl_rssi;
+	u8 bt_rssi;
+
+	s8 tx_power; /* absolute Tx power (dBm), 0xff-> no BTC control */
+	s8 rx_gain;  /* rx gain table index (TBD.) */
+	s8 bt_tx_power; /* decrease Tx power (dB) */
+	s8 bt_rx_gain;  /* LNA constrain level */
+
+	u8 cn; /* condition_num */
+	s8 nhm;
+	u8 bt_profile;
+	u8 rsvd2;
+
+	u16 tx_rate;
+	u16 rx_rate;
+
+	u32 tx_tp;
+	u32 rx_tp;
+	u32 rx_err_ratio;
+};
+
 struct rtw89_btc_dm {
 	struct rtw89_btc_fbtc_slot slot[CXST_MAX];
 	struct rtw89_btc_fbtc_slot slot_now[CXST_MAX];
@@ -2030,6 +2072,7 @@ struct rtw89_btc_dm {
 	struct rtw89_btc_wl_tx_limit_para wl_tx_limit;
 	struct rtw89_btc_dm_step dm_step;
 	struct rtw89_btc_wl_scc_ctrl wl_scc;
+	struct rtw89_btc_trx_info trx_info;
 	union rtw89_btc_dm_error_map error;
 	u32 cnt_dm[BTC_DCNT_NUM];
 	u32 cnt_notify[BTC_NCNT_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 46d9cda2c617c..713aefd0cf8dd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2169,6 +2169,62 @@ int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+#define H2C_LEN_CXDRVINFO_TRX (28 + H2C_LEN_CXDRVHDR)
+int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_btc *btc = &rtwdev->btc;
+	struct rtw89_btc_trx_info *trx = &btc->dm.trx_info;
+	struct sk_buff *skb;
+	u8 *cmd;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LEN_CXDRVINFO_TRX);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_trx\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, H2C_LEN_CXDRVINFO_TRX);
+	cmd = skb->data;
+
+	RTW89_SET_FWCMD_CXHDR_TYPE(cmd, CXDRVINFO_TRX);
+	RTW89_SET_FWCMD_CXHDR_LEN(cmd, H2C_LEN_CXDRVINFO_TRX - H2C_LEN_CXDRVHDR);
+
+	RTW89_SET_FWCMD_CXTRX_TXLV(cmd, trx->tx_lvl);
+	RTW89_SET_FWCMD_CXTRX_RXLV(cmd, trx->rx_lvl);
+	RTW89_SET_FWCMD_CXTRX_WLRSSI(cmd, trx->wl_rssi);
+	RTW89_SET_FWCMD_CXTRX_BTRSSI(cmd, trx->bt_rssi);
+	RTW89_SET_FWCMD_CXTRX_TXPWR(cmd, trx->tx_power);
+	RTW89_SET_FWCMD_CXTRX_RXGAIN(cmd, trx->rx_gain);
+	RTW89_SET_FWCMD_CXTRX_BTTXPWR(cmd, trx->bt_tx_power);
+	RTW89_SET_FWCMD_CXTRX_BTRXGAIN(cmd, trx->bt_rx_gain);
+	RTW89_SET_FWCMD_CXTRX_CN(cmd, trx->cn);
+	RTW89_SET_FWCMD_CXTRX_NHM(cmd, trx->nhm);
+	RTW89_SET_FWCMD_CXTRX_BTPROFILE(cmd, trx->bt_profile);
+	RTW89_SET_FWCMD_CXTRX_RSVD2(cmd, trx->rsvd2);
+	RTW89_SET_FWCMD_CXTRX_TXRATE(cmd, trx->tx_rate);
+	RTW89_SET_FWCMD_CXTRX_RXRATE(cmd, trx->rx_rate);
+	RTW89_SET_FWCMD_CXTRX_TXTP(cmd, trx->tx_tp);
+	RTW89_SET_FWCMD_CXTRX_RXTP(cmd, trx->rx_tp);
+	RTW89_SET_FWCMD_CXTRX_RXERRRA(cmd, trx->rx_err_ratio);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_OUTSRC, BTFC_SET,
+			      SET_DRV_INFO, 0, 0,
+			      H2C_LEN_CXDRVINFO_TRX);
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
 #define H2C_LEN_CXDRVINFO_RFK (4 + H2C_LEN_CXDRVHDR)
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index fa9e786ad7c9a..c3c67ddf61a24 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2152,6 +2152,7 @@ enum rtw89_btc_cxdrvinfo {
 	CXDRVINFO_RUN,
 	CXDRVINFO_CTRL,
 	CXDRVINFO_SCAN,
+	CXDRVINFO_TRX,  /* WL traffic to WL fw */
 	CXDRVINFO_MAX,
 };
 
@@ -2493,6 +2494,91 @@ static inline void RTW89_SET_FWCMD_CXCTRL_TRACE_STEP(void *cmd, u32 val)
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(18, 3));
 }
 
+static inline void RTW89_SET_FWCMD_CXTRX_TXLV(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 2, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_RXLV(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 3, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_WLRSSI(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 4, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_BTRSSI(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 5, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_TXPWR(void *cmd, s8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 6, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_RXGAIN(void *cmd, s8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 7, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_BTTXPWR(void *cmd, s8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 8, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_BTRXGAIN(void *cmd, s8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 9, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_CN(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 10, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_NHM(void *cmd, s8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 11, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_BTPROFILE(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 12, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_RSVD2(void *cmd, u8 val)
+{
+	u8p_replace_bits((u8 *)cmd + 13, val, GENMASK(7, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_TXRATE(void *cmd, u16 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)cmd + 14), val, GENMASK(15, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_RXRATE(void *cmd, u16 val)
+{
+	le16p_replace_bits((__le16 *)((u8 *)cmd + 16), val, GENMASK(15, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_TXTP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)cmd + 18), val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_RXTP(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)cmd + 22), val, GENMASK(31, 0));
+}
+
+static inline void RTW89_SET_FWCMD_CXTRX_RXERRRA(void *cmd, u32 val)
+{
+	le32p_replace_bits((__le32 *)((u8 *)cmd + 26), val, GENMASK(31, 0));
+}
+
 static inline void RTW89_SET_FWCMD_CXRFK_STATE(void *cmd, u32 val)
 {
 	le32p_replace_bits((__le32 *)((u8 *)(cmd) + 2), val, GENMASK(1, 0));
@@ -3557,6 +3643,7 @@ int rtw89_fw_h2c_cxdrv_role(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v1(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_role_v2(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_ctrl(struct rtw89_dev *rtwdev);
+int rtw89_fw_h2c_cxdrv_trx(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
 int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
-- 
2.25.1

