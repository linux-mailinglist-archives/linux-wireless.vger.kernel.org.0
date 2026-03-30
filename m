Return-Path: <linux-wireless+bounces-34169-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFM5Clwfymmu5QUAu9opvQ
	(envelope-from <linux-wireless+bounces-34169-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:59:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B19B7356274
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 08:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 08EC13003D1B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Mar 2026 06:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB850382399;
	Mon, 30 Mar 2026 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ll9aWs5G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBBA286D73
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774853977; cv=none; b=bp6fSyi+HzutUHlzVW/PtFC6FYK/dO9OOZRkp6Im6V7LXw8yqNWneBFeKFW9ohFzh/csJLGDV6E03H/kAbIomaH1OmBu45ZzY9D6vGx2/mycU5WuH1HKO2Rqwdt1H+uU20DwNhd0/l8PwC+Az6ERtiq5ZSRd3qUhFWenf65tNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774853977; c=relaxed/simple;
	bh=QbpuH+42ta21KlHovsGzNlM2nyBLaArXM+EMjosb250=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H2LdoZgQcdm9ht37oHq7Ct5CMqxiyq9Cj9hv8wHlLFD+Ac8YyqBZZzgCsATyZMupUHKdUQPJIO2NrE0qyu9CAPlzvCLYqEsb1TQ7n1aA7ZviHhQ/JymHspgEGfvEKrZC2y3bsVeUAmWqGGb0v8imOH9X8NX86+4UuC9VmnEx5uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ll9aWs5G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62U6xXrsD673873, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774853973; bh=mc5oUcefrLnT3/cATPEnWtHcpaUTYdF9dM++6gdhGi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ll9aWs5GhJOx9iWZmEGnd3n2l8sWYp5dwzVniDedTyqywQUlQwG0UGkAPbbdZ5Utn
	 5811fSm1b5CK1hF+JvtAbZgqoL7tdHu9T70M5zb+piTJRM8FyBtl0oOcjVBPYFVY1h
	 FTzFGtW05kMgNUNQ/d6fY9b3NkAjfysNg+NPvyglmuK17NMfjahZsdzGXjjJaRhGWJ
	 ThR0zhATGtsyC1GrCZCN5bvLGz3YxPwMsLZHtkz676OYDLuldYOxf2+xg+EklmqFsJ
	 YpUCBL2t+NRzyFJ61a4InnB6SRQoWxuty8vzoxT5f31IuuezpzLBGyxyc5xIW5saTp
	 i8hCBwZazErLg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 62U6xXrsD673873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 30 Mar 2026 14:59:33 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 30 Mar 2026 14:59:33 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Mon, 30 Mar 2026 14:59:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 8/9] wifi: rtw89: 8922d: add chip_info and chip_ops struct
Date: Mon, 30 Mar 2026 14:58:46 +0800
Message-ID: <20260330065847.48946-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260330065847.48946-1-pkshih@realtek.com>
References: <20260330065847.48946-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34169-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:email,realtek.com:mid]
X-Rspamd-Queue-Id: B19B7356274
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add remaining functions including calculate RX gain for power saving,
channel frequency and RSSI from PPDU status, and WoWLAN declaration.
Then fill chip_info and chip_ops tables, which RTL8922D has two variants
RTL8922D and RTL8922DS supporting 4096 and 1024 QAM respectively. Other
features, such as support of 2/5/6 GHz and up to 160 MHz bandwidth, for
variants are the same,

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h       |  23 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  17 +
 drivers/net/wireless/realtek/rtw89/rtw8922d.c | 344 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922d.h |   3 +
 4 files changed, 380 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4574a281d352..db252d45e498 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4298,13 +4298,22 @@ enum rtw89_fw_element_id {
 	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK) | \
 	 BITS_OF_RTW89_TXPWR_FW_ELEMENTS_NO_6GHZ)
 
-#define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS (BIT(RTW89_FW_ELEMENT_ID_BBMCU0) | \
-					     BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
-					     BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
-					     BIT(RTW89_FW_ELEMENT_ID_RADIO_B) | \
-					     BIT(RTW89_FW_ELEMENT_ID_RF_NCTL) | \
-					     BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK) | \
-					     BITS_OF_RTW89_TXPWR_FW_ELEMENTS)
+#define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS_BASE \
+	(BIT(RTW89_FW_ELEMENT_ID_BB_REG) | \
+	 BIT(RTW89_FW_ELEMENT_ID_RADIO_A) | \
+	 BIT(RTW89_FW_ELEMENT_ID_RADIO_B) | \
+	 BIT(RTW89_FW_ELEMENT_ID_RF_NCTL) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TXPWR_TRK) | \
+	 BITS_OF_RTW89_TXPWR_FW_ELEMENTS)
+
+#define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS \
+	(RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS_BASE | \
+	 BIT(RTW89_FW_ELEMENT_ID_BBMCU0))
+
+#define RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS_V1 \
+	(RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS_BASE | \
+	 BIT(RTW89_FW_ELEMENT_ID_AFE_PWR_SEQ) | \
+	 BIT(RTW89_FW_ELEMENT_ID_TX_COMP))
 
 struct __rtw89_fw_txpwr_element {
 	u8 rsvd0;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e5e689f1bfa3..42ffe83931a3 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4291,6 +4291,20 @@
 #define B_BE_VERIFY_ENV_MASK GENMASK(9, 8)
 #define B_BE_HW_ID_MASK GENMASK(7, 0)
 
+#define R_BE_SCOREBOARD_0 0x0110
+#define B_BE_SB0_TOGGLE BIT(31)
+#define B_BE_SB0_WL_DATA_LINE_MASK GENMASK(30, 0)
+
+#define R_BE_SCOREBOARD_0_BT_DATA 0x0114
+#define B_BE_SB0_BT_DATA_LINE_MASK GENMASK(30, 0)
+
+#define R_BE_SCOREBOARD_1 0x0118
+#define B_BE_SB1_TOGGLE BIT(31)
+#define B_BE_SB1_WL_DATA_LINE_MASK GENMASK(30, 0)
+
+#define R_BE_SCOREBOARD_1_BT_DATA 0x011C
+#define B_BE_SB1_BT_DATA_LINE_MASK GENMASK(30, 0)
+
 #define R_BE_HALT_H2C_CTRL 0x0160
 #define B_BE_HALT_H2C_TRIGGER BIT(0)
 
@@ -10656,6 +10670,9 @@
 #define B_RX_LDPC08_BE4 GENMASK(29, 24)
 #define R_RX_LDPC01_BE4 0x26840
 #define B_RX_LDPC09_BE4 GENMASK(5, 0)
+#define R_BSS_CLR_MAP_BE4 0x26914
+#define R_BSS_CLR_VLD_BE4 0x26920
+#define B_BSS_CLR_VLD_BE4 BIT(2)
 
 #define R_SW_SI_DATA_BE4 0x2CF4C
 #define B_SW_SI_READ_DATA_BE4 GENMASK(19, 0)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.c b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
index a9a7ffb5fb58..e3b77cd23514 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.c
@@ -1447,6 +1447,20 @@ static void rtw8922d_set_rx_gain_normal(struct rtw89_dev *rtwdev,
 	rtw8922d_set_rx_gain_normal_ofdm(rtwdev, chan, path, phy_idx);
 }
 
+static void rtw8922d_calc_rx_gain_normal(struct rtw89_dev *rtwdev,
+					 const struct rtw89_chan *chan,
+					 enum rtw89_rf_path path,
+					 enum rtw89_phy_idx phy_idx,
+					 struct rtw89_phy_calc_efuse_gain *calc)
+{
+	rtw8922d_calc_rx_gain_normal_ofdm(rtwdev, chan, path, phy_idx, calc);
+
+	if (chan->band_type != RTW89_BAND_2G)
+		return;
+
+	rtw8922d_calc_rx_gain_normal_cck(rtwdev, chan, path, phy_idx, calc);
+}
+
 static void rtw8922d_set_cck_parameters(struct rtw89_dev *rtwdev,
 					const struct rtw89_chan *chan,
 					enum rtw89_phy_idx phy_idx)
@@ -2742,6 +2756,336 @@ static void rtw8922d_btc_set_wl_rx_gain(struct rtw89_dev *rtwdev, u32 level)
 	/* Feature move to firmware */
 }
 
+static void rtw8922d_fill_freq_with_ppdu(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu,
+					 struct ieee80211_rx_status *status)
+{
+	u8 chan_idx = phy_ppdu->chan_idx;
+	enum nl80211_band band;
+	u8 ch;
+
+	if (chan_idx == 0)
+		return;
+
+	rtw89_decode_chan_idx(rtwdev, chan_idx, &ch, &band);
+	status->freq = ieee80211_channel_to_frequency(ch, band);
+	status->band = band;
+}
+
+static void rtw8922d_query_ppdu(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_phy_ppdu *phy_ppdu,
+				struct ieee80211_rx_status *status)
+{
+	u8 path;
+	u8 *rx_power = phy_ppdu->rssi;
+
+	if (!status->signal)
+		status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A],
+							   rx_power[RF_PATH_B]));
+
+	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
+		status->chains |= BIT(path);
+		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
+	}
+	if (phy_ppdu->valid)
+		rtw8922d_fill_freq_with_ppdu(rtwdev, phy_ppdu, status);
+}
+
+static void rtw8922d_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
+					 struct rtw89_rx_phy_ppdu *phy_ppdu)
+{
+	/* Mapping to BW: 5, 10, 20, 40, 80, 160, 80_80 */
+	static const u8 bw_compensate[] = {0, 0, 0, 6, 12, 18, 0};
+	u8 *rssi = phy_ppdu->rssi;
+	u8 compensate = 0;
+	u8 i;
+
+	if (phy_ppdu->bw_idx < ARRAY_SIZE(bw_compensate))
+		compensate = bw_compensate[phy_ppdu->bw_idx];
+
+	for (i = 0; i < RF_PATH_NUM_8922D; i++) {
+		if (!(phy_ppdu->rx_path_en & BIT(i))) {
+			rssi[i] = 0;
+			phy_ppdu->rpl_path[i] = 0;
+			phy_ppdu->rpl_fd[i] = 0;
+		}
+
+		if (phy_ppdu->ie != RTW89_CCK_PKT && rssi[i])
+			rssi[i] += compensate;
+
+		phy_ppdu->rpl_path[i] = rssi[i];
+	}
+}
+
+static void rtw8922d_phy_rpt_to_rssi(struct rtw89_dev *rtwdev,
+				     struct rtw89_rx_desc_info *desc_info,
+				     struct ieee80211_rx_status *rx_status)
+{
+	if (desc_info->rssi <= 0x1 || (desc_info->rssi >> 2) > MAX_RSSI)
+		return;
+
+	rx_status->signal = (desc_info->rssi >> 2) - MAX_RSSI;
+}
+
+static int rtw8922d_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	return 0;
+}
+
+static int rtw8922d_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	return 0;
+}
+
+static const struct rtw89_chanctx_listener rtw8922d_chanctx_listener = {
+	.callbacks[RTW89_CHANCTX_CALLBACK_TAS] = rtw89_tas_chanctx_cb,
+};
+
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8922d = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT |
+		 WIPHY_WOWLAN_NET_DETECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
+	.max_nd_match_sets = RTW89_SCANOFLD_MAX_SSID,
+};
+#endif
+
+static const struct rtw89_chip_ops rtw8922d_chip_ops = {
+	.enable_bb_rf		= rtw8922d_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw8922d_mac_disable_bb_rf,
+	.bb_preinit		= rtw8922d_bb_preinit,
+	.bb_postinit		= rtw8922d_bb_postinit,
+	.bb_reset		= rtw8922d_bb_reset,
+	.bb_sethw		= rtw8922d_bb_sethw,
+	.read_rf		= rtw89_phy_read_rf_v3,
+	.write_rf		= rtw89_phy_write_rf_v3,
+	.set_channel		= rtw8922d_set_channel,
+	.set_channel_help	= rtw8922d_set_channel_help,
+	.read_efuse		= rtw8922d_read_efuse,
+	.read_phycap		= rtw8922d_read_phycap,
+	.fem_setup		= NULL,
+	.rfe_gpio		= NULL,
+	.rfk_hw_init		= rtw8922d_rfk_hw_init,
+	.rfk_init		= rtw8922d_rfk_init,
+	.rfk_init_late		= rtw8922d_rfk_init_late,
+	.rfk_channel		= rtw8922d_rfk_channel,
+	.rfk_band_changed	= rtw8922d_rfk_band_changed,
+	.rfk_scan		= rtw8922d_rfk_scan,
+	.rfk_track		= rtw8922d_rfk_track,
+	.power_trim		= rtw8922d_power_trim,
+	.set_txpwr		= rtw8922d_set_txpwr,
+	.set_txpwr_ctrl		= rtw8922d_set_txpwr_ctrl,
+	.init_txpwr_unit	= NULL,
+	.get_thermal		= rtw8922d_get_thermal,
+	.chan_to_rf18_val	= rtw8922d_chan_to_rf18_val,
+	.ctrl_btg_bt_rx		= rtw8922d_set_gbt_bt_rx_sel,
+	.query_ppdu		= rtw8922d_query_ppdu,
+	.convert_rpl_to_rssi	= rtw8922d_convert_rpl_to_rssi,
+	.phy_rpt_to_rssi	= rtw8922d_phy_rpt_to_rssi,
+	.ctrl_nbtg_bt_tx	= rtw8922d_ctrl_nbtg_bt_tx,
+	.cfg_txrx_path		= rtw8922d_bb_cfg_txrx_path,
+	.set_txpwr_ul_tb_offset	= NULL,
+	.digital_pwr_comp	= rtw8922d_digital_pwr_comp,
+	.calc_rx_gain_normal	= rtw8922d_calc_rx_gain_normal,
+	.pwr_on_func		= rtw8922d_pwr_on_func,
+	.pwr_off_func		= rtw8922d_pwr_off_func,
+	.query_rxdesc		= rtw89_core_query_rxdesc_v3,
+	.fill_txdesc		= rtw89_core_fill_txdesc_v3,
+	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc_fwcmd_v2,
+	.get_ch_dma		= {rtw89_core_get_ch_dma_v1,
+				   NULL,
+				   NULL,},
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path_v2,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt_v3,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v2,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v2,
+	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v3,
+	.h2c_default_cmac_tbl	= rtw89_fw_h2c_default_cmac_tbl_be,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_be,
+	.h2c_ampdu_cmac_tbl	= rtw89_fw_h2c_ampdu_cmac_tbl_be,
+	.h2c_txtime_cmac_tbl	= rtw89_fw_h2c_txtime_cmac_tbl_be,
+	.h2c_punctured_cmac_tbl	= rtw89_fw_h2c_punctured_cmac_tbl_be,
+	.h2c_default_dmac_tbl	= rtw89_fw_h2c_default_dmac_tbl_v3,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
+	.h2c_wow_cam_update	= rtw89_fw_h2c_wow_cam_update_v1,
+
+	.btc_set_rfe		= rtw8922d_btc_set_rfe,
+	.btc_init_cfg		= rtw8922d_btc_init_cfg,
+	.btc_set_wl_pri		= NULL,
+	.btc_set_wl_txpwr_ctrl	= rtw8922d_btc_set_wl_txpwr_ctrl,
+	.btc_get_bt_rssi	= rtw8922d_btc_get_bt_rssi,
+	.btc_update_bt_cnt	= rtw8922d_btc_update_bt_cnt,
+	.btc_wl_s1_standby	= rtw8922d_btc_wl_s1_standby,
+	.btc_set_wl_rx_gain	= rtw8922d_btc_set_wl_rx_gain,
+	.btc_set_policy		= rtw89_btc_set_policy_v1,
+};
+
+const struct rtw89_chip_info rtw8922d_chip_info = {
+	.chip_id		= RTL8922D,
+	.chip_gen		= RTW89_CHIP_BE,
+	.ops			= &rtw8922d_chip_ops,
+	.mac_def		= &rtw89_mac_gen_be,
+	.phy_def		= &rtw89_phy_gen_be_v1,
+	.fw_def			= {
+		.fw_basename	= RTW8922D_FW_BASENAME,
+		.fw_format_max	= RTW8922D_FW_FORMAT_MAX,
+		.fw_b_aid	= RTL8922D_AID7102,
+	},
+	.try_ce_fw		= false,
+	.bbmcu_nr		= 0,
+	.needed_fw_elms		= RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS_V1,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
+	.fifo_size		= 393216,
+	.small_fifo_size	= false,
+	.dle_scc_rsvd_size	= 0,
+	.max_amsdu_limit	= 11000,
+	.max_vht_mpdu_cap	= IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991,
+	.max_eht_mpdu_cap	= IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991,
+	.max_tx_agg_num		= 128,
+	.max_rx_agg_num		= 256,
+	.dis_2g_40m_ul_ofdma	= false,
+	.rsvd_ple_ofst		= 0x5f800,
+	.hfc_param_ini		= {rtw8922d_hfc_param_ini_pcie, NULL, NULL},
+	.dle_mem		= {rtw8922d_dle_mem_pcie, NULL, NULL, NULL},
+	.wde_qempty_acq_grpnum	= 8,
+	.wde_qempty_mgq_grpsel	= 8,
+	.rf_base_addr		= {0x3e000, 0x3f000},
+	.thermal_th		= {0xac, 0xad},
+	.pwr_on_seq		= NULL,
+	.pwr_off_seq		= NULL,
+	.bb_table		= NULL,
+	.bb_gain_table		= NULL,
+	.rf_table		= {},
+	.nctl_table		= NULL,
+	.nctl_post_table	= &rtw8922d_nctl_post_defs_tbl,
+	.dflt_parms		= NULL, /* load parm from fw */
+	.rfe_parms_conf		= NULL, /* load parm from fw */
+	.chanctx_listener	= &rtw8922d_chanctx_listener,
+	.txpwr_factor_bb	= 3,
+	.txpwr_factor_rf	= 2,
+	.txpwr_factor_mac	= 1,
+	.dig_table		= NULL,
+	.dig_regs		= &rtw8922d_dig_regs,
+	.tssi_dbw_table		= NULL,
+	.support_macid_num	= 64,
+	.support_link_num	= 2,
+	.support_chanctx_num	= 2,
+	.support_rnr		= true,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ) |
+				  BIT(NL80211_BAND_6GHZ),
+	.support_bandwidths	= BIT(NL80211_CHAN_WIDTH_20) |
+				  BIT(NL80211_CHAN_WIDTH_40) |
+				  BIT(NL80211_CHAN_WIDTH_80) |
+				  BIT(NL80211_CHAN_WIDTH_160),
+	.support_unii4		= true,
+	.support_ant_gain	= false,
+	.support_tas		= false,
+	.support_sar_by_ant	= true,
+	.support_noise		= false,
+	.ul_tb_waveform_ctrl	= false,
+	.ul_tb_pwr_diff		= false,
+	.rx_freq_frome_ie	= false,
+	.hw_sec_hdr		= true,
+	.hw_mgmt_tx_encrypt	= true,
+	.hw_tkip_crypto		= true,
+	.hw_mlo_bmc_crypto	= true,
+	.rf_path_num		= 2,
+	.tx_nss			= 2,
+	.rx_nss			= 2,
+	.acam_num		= 128,
+	.bcam_num		= 16,
+	.scam_num		= 32,
+	.bacam_num		= 24,
+	.bacam_dynamic_num	= 8,
+	.bacam_ver		= RTW89_BACAM_V1,
+	.addrcam_ver		= 1,
+	.ppdu_max_usr		= 16,
+	.sec_ctrl_efuse_size	= 4,
+	.physical_efuse_size	= 0x1300,
+	.logical_efuse_size	= 0x70000,
+	.limit_efuse_size	= 0x40000,
+	.dav_phy_efuse_size	= 0,
+	.dav_log_efuse_size	= 0,
+	.efuse_blocks		= rtw8922d_efuse_blocks,
+	.phycap_addr		= 0x1700,
+	.phycap_size		= 0x60,
+	.para_ver		= 0x3ff,
+	.wlcx_desired		= 0x09150000,
+	.scbd			= 0x1,
+	.mailbox		= 0x1,
+
+	.afh_guard_ch		= 6,
+	.wl_rssi_thres		= rtw89_btc_8922d_wl_rssi_thres,
+	.bt_rssi_thres		= rtw89_btc_8922d_bt_rssi_thres,
+	.rssi_tol		= 2,
+	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8922d_mon_reg),
+	.mon_reg		= rtw89_btc_8922d_mon_reg,
+	.rf_para_ulink_v9	= rtw89_btc_8922d_rf_ul_v9,
+	.rf_para_dlink_v9	= rtw89_btc_8922d_rf_dl_v9,
+	.rf_para_ulink_num_v9	= ARRAY_SIZE(rtw89_btc_8922d_rf_ul_v9),
+	.rf_para_dlink_num_v9	= ARRAY_SIZE(rtw89_btc_8922d_rf_dl_v9),
+	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
+				  BIT(RTW89_PS_MODE_CLK_GATED) |
+				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.low_power_hci_modes	= 0,
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD_G7,
+	.hci_func_en_addr	= R_BE_HCI_FUNC_EN,
+	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short_v3),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v2),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info_v2),
+	.h2c_ctrl_reg		= R_BE_H2CREG_CTRL,
+	.h2c_counter_reg	= {R_BE_UDM1 + 1, B_BE_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
+	.h2c_regs		= rtw8922d_h2c_regs,
+	.c2h_ctrl_reg		= R_BE_C2HREG_CTRL,
+	.c2h_counter_reg	= {R_BE_UDM1 + 1, B_BE_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
+	.c2h_regs		= rtw8922d_c2h_regs,
+	.page_regs		= &rtw8922d_page_regs,
+	.wow_reason_reg		= rtw8922d_wow_wakeup_regs,
+	.cfo_src_fd		= true,
+	.cfo_hw_comp            = true,
+	.dcfo_comp		= NULL,
+	.dcfo_comp_sft		= 0,
+	.nhm_report		= NULL,
+	.nhm_th			= NULL,
+	.imr_info		= NULL,
+	.imr_dmac_table		= &rtw8922d_imr_dmac_table,
+	.imr_cmac_table		= &rtw8922d_imr_cmac_table,
+	.rrsr_cfgs		= &rtw8922d_rrsr_cfgs,
+	.bss_clr_vld		= {R_BSS_CLR_VLD_BE4, B_BSS_CLR_VLD_BE4},
+	.bss_clr_map_reg	= R_BSS_CLR_MAP_BE4,
+	.rfkill_init		= &rtw8922d_rfkill_regs,
+	.rfkill_get		= {R_BE_GPIO_EXT_CTRL, B_BE_GPIO_IN_9},
+	.btc_sb			= {{{R_BE_SCOREBOARD_0, R_BE_SCOREBOARD_0_BT_DATA},
+				    {R_BE_SCOREBOARD_1, R_BE_SCOREBOARD_1_BT_DATA}}},
+	.dma_ch_mask		= BIT(RTW89_DMA_ACH1) | BIT(RTW89_DMA_ACH3) |
+				  BIT(RTW89_DMA_ACH5) | BIT(RTW89_DMA_ACH7) |
+				  BIT(RTW89_DMA_B0HI) | BIT(RTW89_DMA_B1HI),
+	.edcca_regs		= &rtw8922d_edcca_regs,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8922d,
+#endif
+	.xtal_info		= NULL,
+	.default_quirks		= BIT(RTW89_QUIRK_THERMAL_PROT_120C),
+};
+EXPORT_SYMBOL(rtw8922d_chip_info);
+
+static const struct rtw89_fw_def rtw8922de_vs_fw_def = {
+	.fw_basename		= RTW8922DS_FW_BASENAME,
+	.fw_format_max		= RTW8922DS_FW_FORMAT_MAX,
+	.fw_b_aid		= RTL8922D_AID7060,
+};
+
+const struct rtw89_chip_variant rtw8922de_vs_variant = {
+	.no_mcs_12_13 = true,
+	.fw_min_ver_code = RTW89_FW_VER_CODE(0, 0, 0, 0),
+	.fw_def_override = &rtw8922de_vs_fw_def,
+};
+EXPORT_SYMBOL(rtw8922de_vs_variant);
+
 MODULE_FIRMWARE(RTW8922D_MODULE_FIRMWARE);
 MODULE_FIRMWARE(RTW8922DS_MODULE_FIRMWARE);
 MODULE_AUTHOR("Realtek Corporation");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922d.h b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
index a3b98ad6636c..22a7d1cc244f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922d.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922d.h
@@ -77,4 +77,7 @@ struct rtw8922d_efuse {
 	struct rtw8922d_rx_gain_6g rx_gain_6g_b_2;
 } __packed;
 
+extern const struct rtw89_chip_info rtw8922d_chip_info;
+extern const struct rtw89_chip_variant rtw8922de_vs_variant;
+
 #endif
-- 
2.25.1


