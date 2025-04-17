Return-Path: <linux-wireless+bounces-21646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C42A91EC1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885D9464312
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76A824EAA4;
	Thu, 17 Apr 2025 13:53:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2A24EA93
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897996; cv=none; b=JJsCyh1kZUDxTjQlSiL7CndoPpWA61QxWU/n0ZzQQtuUtUcXlPccFU/XkzKnnjEMeMoDIkvwsb9cwrK/uiOibITNZX2twFXfHHWONWd/sCZgk4EQkDyC500rpYZTqnDSGkLi4hS5/zEnaYaiS6vep+HEoR+BxGxyMvgO8B6RkaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897996; c=relaxed/simple;
	bh=x8ZX/qobYB6KdqWRChx5iTU+X7UCaBsbY/nJC0T3Cws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j1mqxzn6CZPlo9eKPXjSaWCngKynlqeP7n8QgFeggjRA80Uy6gE6CkIcrRu0aPRpK4vXqLIyV1ckH/Do5KxIrwhn8bxntsaxIFxW3l4jW9M7lNFDIuHe9mBi2eAQg8ExUxp25gP6pEaLrSNq2sIJy2CQEV/m2LT/eje7L8tQYHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: FIdAisRdT2y1XXL5Klqatg==
X-CSE-MsgGUID: lnVUS/ylQS+ItSfF30LHNg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:12 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9D5734006DE8;
	Thu, 17 Apr 2025 22:53:08 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 06/38] ra6w: add cmd.h
Date: Thu, 17 Apr 2025 16:52:04 +0300
Message-Id: <20250417135236.52410-7-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/renesas/ra6w/cmd.h | 978 ++++++++++++++++++++++++
 1 file changed, 978 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/cmd.h

diff --git a/drivers/net/wireless/renesas/ra6w/cmd.h b/drivers/net/wireless/renesas/ra6w/cmd.h
new file mode 100644
index 000000000000..635709d05af0
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/cmd.h
@@ -0,0 +1,978 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_CMD_H
+#define RA6W_CMD_H
+
+#include <linux/if_ether.h>
+
+#define RA6W_CMD_MAX_Q				4
+#define RA6W_CMD_DATA_SIZE			1700
+#define RA6W_CMD_MAX_MCS_LEN			16
+
+#define RA6W_CMD_MAC_HE_MAC_CAPA_LEN		6
+#define RA6W_CMD_MAC_HE_PHY_CAPA_LEN		11
+#define RA6W_CMD_MAC_HE_PPE_THRES_MAX_LEN	25
+
+#define RA6W_CMD_SCAN_SSID_MAX			2
+#define RA6W_CMD_SCAN_MAX_IE_LEN		200
+#define RA6W_CMD_SSID_LEN			32
+
+#define RA6W_CMD_TX_LIFETIME_MS			100
+
+#define RA6W_CMD_BT_COEX_MAX			3
+#define RA6W_CMD_BCN_MAX_CSA_CPT		2
+#define RA6W_CMD_BCN_SIZE			512
+#define RA6W_CMD_SECURY_KEY_LEN			32
+
+#define RA6W_CMD_SCAN_CHANNEL_24G		14
+#define RA6W_CMD_SCAN_CHANNEL_5G		28
+#define RA6W_CMD_SCAN_CHANNEL_MAX	(RA6W_CMD_SCAN_CHANNEL_24G + RA6W_CMD_SCAN_CHANNEL_5G)
+
+enum ra6w_cmd_data {
+	RA6W_CMD_DATA_START = 0,
+	RA6W_CMD_DATA_RX = 1,
+	RA6W_CMD_DATA_STATUS_RX = 2,
+	RA6W_CMD_DATA_TX = 5,
+
+	RA6W_CMD_DATA_MAX,
+	RA6W_CMD_DATA_LAST = RA6W_CMD_DATA_MAX - 1
+};
+
+enum ra6w_cmd_common {
+	RA6W_CMD_COMMON_START = 10,
+	RA6W_CMD_COMMON_RESET = 11,
+	RA6W_CMD_COMMON_GET_MAC_ADDR = 12,
+
+	RA6W_CMD_COMMON_MAX,
+	RA6W_CMD_COMMON_LAST = RA6W_CMD_COMMON_MAX - 1
+};
+
+enum ra6w_cmd_ctrl {
+	RA6W_CMD_FULLMAC_START = 100,
+
+	RA6W_CMD_MM_RESET = 101,
+	RA6W_CMD_MM_START = 102,
+	RA6W_CMD_MM_GET_VER = 103,
+	RA6W_CMD_MM_ADD_IF = 104,
+	RA6W_CMD_MM_RM_IF = 105,
+	RA6W_CMD_MM_ADD_KEY = 106,
+	RA6W_CMD_MM_DEL_KEY = 107,
+	RA6W_CMD_MM_SET_POWER = 108,
+	RA6W_CMD_MM_GET_RSSI = 109,
+	RA6W_CMD_MM_REMAIN_ON_CHANNEL = 110,
+	RA6W_CMD_MM_SET_EDCA = 111,
+
+	RA6W_CMD_ME_CONFIG = 113,
+	RA6W_CMD_ME_CHAN_CONFIG = 114,
+	RA6W_CMD_ME_SET_CONTROL_PORT = 115,
+	RA6W_CMD_ME_ADD_STA = 116,
+	RA6W_CMD_ME_DEL_STA = 117,
+	RA6W_CMD_ME_SET_MON_CFG = 121,
+	RA6W_CMD_ME_SET_PS_MODE = 122,
+
+	RA6W_CMD_SC_START = 123,
+	RA6W_CMD_SC_CANCEL_CMD = 126,
+
+	RA6W_CMD_SM_CONNECT = 127,
+	RA6W_CMD_SM_DISCONNECT = 128,
+	RA6W_CMD_SM_EXTERNAL_AUTH_REQUIRED_RSP = 129,
+
+	RA6W_CMD_AM_START = 133,
+	RA6W_CMD_AM_STOP = 134,
+	RA6W_CMD_AM_START_CHAN_AVAIL = 135,
+	RA6W_CMD_AM_STOP_CHAN_AVAIL = 136,
+	RA6W_CMD_AM_PROBE_CLIENT = 137,
+	RA6W_CMD_AM_BCN_CHANGE = 138,
+	RA6W_CMD_AM_ISOLATE = 139,
+
+	RA6W_CMD_FULLMAC_MAX,
+	RA6W_CMD_FULLMAC_LAST = RA6W_CMD_FULLMAC_MAX - 1
+};
+
+enum ra6w_cmd_ind {
+	RA6W_CMD_IND_FULLMAC_START = 180,
+
+	RA6W_CMD_ME_TKIP_MIC_FAILURE_IND = 181,
+
+	RA6W_CMD_SC_RESULT_IND = 183,
+	RA6W_CMD_SC_COMPLETE_IND = 184,
+	RA6W_CMD_SC_CHANNEL_SURVEY_IND = 185,
+
+	RA6W_CMD_SM_CONNECT_IND = 186,
+	RA6W_CMD_SM_DISCONNECT_IND = 187,
+	RA6W_CMD_SM_EXTERNAL_AUTH_REQUIRED_IND = 189,
+
+	RA6W_CMD_TWT_SETUP_IND = 190,
+
+	RA6W_CMD_AM_PROBE_CLIENT_IND = 191,
+
+	RA6W_CMD_MM_CHANNEL_SWITCH_IND = 192,
+	RA6W_CMD_MM_CHANNEL_PRE_SWITCH_IND = 193,
+	RA6W_CMD_MM_REMAIN_ON_CHANNEL_EXP_IND = 194,
+	RA6W_CMD_MM_PS_CHANGE_IND = 195,
+	RA6W_CMD_MM_TRAFFIC_REQ_IND = 196,
+	RA6W_CMD_MM_CSA_COUNTER_IND = 198,
+	RA6W_CMD_MM_RSSI_STATUS_IND = 200,
+	RA6W_CMD_MM_CSA_FINISH_IND = 201,
+	RA6W_CMD_MM_CSA_TRAFFIC_IND = 202,
+	RA6W_CMD_MM_PACKET_LOSS_IND = 203,
+
+	RA6W_CMD_TD_CHAN_SWITCH_IND = 204,
+
+	RA6W_CMD_DBG_ERROR_IND = 207,
+
+	RA6W_CMD_IND_FULLMAC_MAX,
+	RA6W_CMD_IND_FULLMAC_LAST = RA6W_CMD_IND_FULLMAC_MAX - 1
+};
+
+enum ra6w_cmd_dbg {
+	RA6W_CMD_DBG_START = 220,
+
+	RA6W_CMD_DBG_MEM_READ = 221,
+	RA6W_CMD_DBG_MEM_WRITE = 222,
+	RA6W_CMD_DBG_SET_MOD_FILTER = 223,
+	RA6W_CMD_DBG_SET_SEV_FILTER = 224,
+	RA6W_CMD_DBG_RF_TX = 227,
+	RA6W_CMD_DBG_RF_CW = 228,
+	RA6W_CMD_DBG_RF_CONT = 229,
+	RA6W_CMD_DBG_RF_CH = 230,
+	RA6W_CMD_DBG_RF_PER = 231,
+	RA6W_CMD_DBG_STATS_TX = 232,
+
+	RA6W_CMD_DBG_MAX,
+	RA6W_CMD_DBG_LAST = RA6W_CMD_DBG_MAX - 1
+};
+
+enum ra6w_cmd_ac {
+	RA6W_CMD_AC_BK,
+	RA6W_CMD_AC_BE,
+	RA6W_CMD_AC_VI,
+	RA6W_CMD_AC_VO,
+
+	RA6W_CMD_AC_MAX,
+};
+
+enum ra6w_cmd_mac_chan_bandwidth {
+	RA6W_CMD_PHY_CHNL_BW_20,
+	RA6W_CMD_PHY_CHNL_BW_40,
+	RA6W_CMD_PHY_CHNL_BW_80,
+	RA6W_CMD_PHY_CHNL_BW_160,
+	RA6W_CMD_PHY_CHNL_BW_80P80,
+
+	RA6W_CMD_PHY_CHNL_BW_OTHER,
+};
+
+enum ra6w_cmd_chan_bits {
+	RA6W_CMD_CHAN_NO_IR_BIT = BIT(0),
+	RA6W_CMD_CHAN_DISABLED_BIT = BIT(1),
+	RA6W_CMD_CHAN_RADAR_BIT = BIT(2),
+	RA6W_CMD_CHAN_HT40M_BIT = BIT(3),
+	RA6W_CMD_CHAN_HT40P_BIT = BIT(4),
+	RA6W_CMD_CHAN_VHT80_10_70_BIT = BIT(5),
+	RA6W_CMD_CHAN_VHT80_30_50_BIT = BIT(6),
+	RA6W_CMD_CHAN_VHT80_50_30_BIT = BIT(7),
+	RA6W_CMD_CHAN_VHT80_70_10_BIT = BIT(8)
+};
+
+enum ra6w_cmd_machw_version {
+	RA6W_CMD_MACHW_DEFAULT = 10,
+	RA6W_CMD_MACHW_HE = 20,
+	RA6W_CMD_MACHW_HE_AP = 30,
+};
+
+enum ra6w_cmd_connection_bits {
+	RA6W_CMD_CONN_CONTROL_PORT_HOST_BIT = BIT(0),
+	RA6W_CMD_CONN_CONTROL_PORT_NO_ENC_BIT = BIT(1),
+	RA6W_CMD_CONN_DISABLE_HT_BIT = BIT(2),
+	RA6W_CMD_CONN_USE_PAIRWISE_KEY_BIT = BIT(3),
+	RA6W_CMD_CONN_MFP_IN_USE_BIT = BIT(4),
+	RA6W_CMD_CONN_REASSOCIATION_BIT = BIT(5),
+	RA6W_CMD_CONN_USE_PRIVACY_BIT = BIT(7),
+	RA6W_CMD_CONN_REQUIRE_SPP_AMSDU_BIT = BIT(8),
+};
+
+enum ra6w_cmd_sm_auth_status_bits {
+	RA6W_CMD_STA_AUTH_EXT_BIT = BIT(0),
+};
+
+enum ra6w_cmd_sta_cap_bits {
+	RA6W_CMD_STA_CAP_QOS_BIT = BIT(0),
+	RA6W_CMD_STA_CAP_HT_BIT = BIT(1),
+	RA6W_CMD_STA_CAP_VHT_BIT = BIT(2),
+	RA6W_CMD_STA_CAP_MFP_BIT = BIT(3),
+	RA6W_CMD_STA_OP_NOT_IE_BIT = BIT(4),
+	RA6W_CMD_STA_CAP_HE_BIT = BIT(5),
+	RA6W_CMD_STA_CAP_SHORT_PREAMBLE_BIT = BIT(6),
+};
+
+enum ra6w_cmd_tdls_state {
+	RA6W_CMD_TDLS_STATE_LINK_IDLE,
+	RA6W_CMD_TDLS_STATE_TX_REQ,
+	RA6W_CMD_TDLS_STATE_TX_RSP,
+	RA6W_CMD_TDLS_STATE_LINK_ACTIVE,
+
+	RA6W_CMD_TDLS_STATE_MAX
+};
+
+enum ra6w_cmd_roc_op_code {
+	RA6W_CMD_ROC_OP_CODE_START,
+	RA6W_CMD_ROC_OP_CODE_STOP,
+
+	RA6W_CMD_ROC_OP_CODE_MAX
+};
+
+struct ra6w_cmd_hdr {
+	u8 cmd;
+	u8 ext_len;
+	__le16 data_len;
+};
+
+struct ra6w_cmd_reset_data {
+	__le64 time_usec;
+	__le32 bt_coex;
+};
+
+struct ra6w_cmd_reset_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_reset_data data;
+} __packed;
+
+struct ra6w_cmd_phy_cfg {
+	u8 boot_mode;
+	u8 band;
+	u8 country_code[4];
+};
+
+struct ra6w_cmd_mm_start_data {
+	struct ra6w_cmd_phy_cfg phy_cfg;
+	__le32 uapsd_timeout;
+	__le16 lp_clk_accuracy;
+	__le16 tx_timeout[RA6W_CMD_MAX_Q];
+	__le16 rx_hostbuf_size;
+};
+
+struct ra6w_cmd_mm_start_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_mm_start_data data;
+} __packed;
+
+struct ra6w_cmd_mm_common_get_mac_req {
+	struct ra6w_cmd_hdr hdr;
+};
+
+struct ra6w_cmd_fw_ver_rsp {
+	__le32 fw_version;
+	__le32 machw_features;
+	__le32 machw_version;
+	__le32 phy_feature;
+	__le32 phy_version;
+	__le32 features;
+	__le16 max_sta_nb;
+	u8 max_vif_nb;
+};
+
+struct ra6w_cmd_mac_addr {
+	u16 addr[ETH_ALEN / 2];
+};
+
+struct ra6w_cmd_add_if_data {
+	u8 iftype;
+	struct ra6w_cmd_mac_addr addr;
+	bool p2p;
+	bool uf;
+};
+
+struct ra6w_cmd_add_if_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_add_if_data data;
+} __packed;
+
+struct ra6w_cmd_add_if_rsp {
+	u8 status;
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_del_if_data {
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_del_if_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_del_if_data data;
+} __packed;
+
+struct ra6w_cmd_oper_ch_info {
+	u8 ch_band;
+	u8 ch_bw;
+	__le16 freq_prim20;
+	__le16 freq_cen1;
+	__le16 freq_cen2;
+	__le16 ch_flags;
+	s8 tx_max_pwr;
+};
+
+struct ra6w_cmd_mac_htcapability {
+	__le16 ht_capa_info;
+	u8 a_mpdu_param;
+	u8 mcs_rate[RA6W_CMD_MAX_MCS_LEN];
+	__le16 ht_extended_capa;
+	__le32 tx_beamforming_capa;
+	u8 asel_capa;
+};
+
+struct ra6w_cmd_mac_vhtcapability {
+	__le32 vht_capa_info;
+	__le16 rx_mcs_map;
+	__le16 rx_highest;
+	__le16 tx_mcs_map;
+	__le16 tx_highest;
+};
+
+struct ra6w_cmd_mac_he_mcs_nss_supp {
+	__le16 rx_mcs_80;
+	__le16 tx_mcs_80;
+	__le16 rx_mcs_160;
+	__le16 tx_mcs_160;
+	__le16 rx_mcs_80p80;
+	__le16 tx_mcs_80p80;
+};
+
+struct ra6w_cmd_mac_hecapability {
+	u8 mac_cap_info[RA6W_CMD_MAC_HE_MAC_CAPA_LEN];
+	u8 phy_cap_info[RA6W_CMD_MAC_HE_PHY_CAPA_LEN];
+	struct ra6w_cmd_mac_he_mcs_nss_supp mcs_supp;
+	u8 ppe_thres[RA6W_CMD_MAC_HE_PPE_THRES_MAX_LEN];
+};
+
+struct ra6w_cmd_me_config_data {
+	struct ra6w_cmd_mac_htcapability ht_cap;
+	struct ra6w_cmd_mac_vhtcapability vht_cap;
+	struct ra6w_cmd_mac_hecapability he_cap;
+	__le16 tx_lft;
+	u8 phy_bw_max;
+	u8 ht_supp;
+	u8 vht_supp;
+	u8 he_supp;
+	u8 he_ul_on;
+	u8 ps_on;
+	u8 ant_div_on;
+	u8 dpsm;
+	u8 amsdu_tx;
+};
+
+struct ra6w_cmd_me_config_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_me_config_data data;
+} __packed;
+
+struct ra6w_cmd_prim_ch_def {
+	__le16 ch_freq;
+	u8 ch_band;
+	s8 tx_max_pwr;
+	__le16 ch_flags;
+};
+
+struct ra6w_cmd_mac_ssid {
+	u8 ssid_len;
+	u8 ssid[RA6W_CMD_SSID_LEN];
+};
+
+struct ra6w_cmd_me_chan_config_data {
+	struct ra6w_cmd_prim_ch_def chan24G[RA6W_CMD_SCAN_CHANNEL_24G];
+	struct ra6w_cmd_prim_ch_def chan5G[RA6W_CMD_SCAN_CHANNEL_5G];
+	u8 chan24G_cnt;
+	u8 chan5G_cnt;
+};
+
+struct ra6w_cmd_me_chan_config_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_me_chan_config_data data;
+} __packed;
+
+struct ra6w_cmd_sc_start_data {
+	struct ra6w_cmd_prim_ch_def chan[RA6W_CMD_SCAN_CHANNEL_MAX];
+	struct ra6w_cmd_mac_ssid ssid[RA6W_CMD_SCAN_SSID_MAX];
+	u8 bssid[ETH_ALEN];
+	__le32 ie_addr;
+	__le16 ie_len;
+	u8 vif_idx;
+	u8 n_channels;
+	u8 n_ssids;
+	u8 no_cck;
+	__le32 duration;
+	u8 ie[RA6W_CMD_SCAN_MAX_IE_LEN];
+};
+
+struct ra6w_cmd_sc_start_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_sc_start_data data;
+} __packed;
+
+struct ra6w_cmd_sc_cancel_data {
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_sc_cancel_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_sc_cancel_data data;
+} __packed;
+
+struct ra6w_cmd_sm_connect_data {
+	struct ra6w_cmd_mac_ssid ssid;
+	struct ra6w_cmd_mac_addr bssid;
+	struct ra6w_cmd_prim_ch_def chan;
+	__le32 flags;
+	__be16 ctrl_port_ethertype;
+	__le16 listen_interval;
+	u8 dont_wait_bcmc;
+	u8 auth_type;
+	u8 uapsd_queues;
+	u8 vif_idx;
+	__le16 ie_len;
+	u32 ie_buf[];
+};
+
+struct ra6w_cmd_sm_connect_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_sm_connect_data data;
+} __packed;
+
+struct ra6w_cmd_sm_connect_rsp {
+	u8 status;
+};
+
+struct ra6w_cmd_change_bcn_data {
+	u8 bcn_ptr[RA6W_CMD_BCN_SIZE];
+	__le16 bcn_len;
+	__le16 tim_oft;
+	u8 tim_len;
+	u8 vif_id;
+	u8 csa_oft[RA6W_CMD_BCN_MAX_CSA_CPT];
+};
+
+struct ra6w_cmd_change_bcn_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_change_bcn_data data;
+} __packed;
+
+#define RA6W_CMD_MAC_RATESET_LEN	12
+
+struct ra6w_cmd_mac_rateset {
+	u8 length;
+	u8 array[RA6W_CMD_MAC_RATESET_LEN];
+};
+
+struct ra6w_cmd_sta_add_data {
+	struct ra6w_cmd_mac_addr mac_addr;
+	struct ra6w_cmd_mac_rateset rate_set;
+	struct ra6w_cmd_mac_htcapability ht_cap;
+	struct ra6w_cmd_mac_vhtcapability vht_cap;
+	struct ra6w_cmd_mac_hecapability he_cap;
+	__le32 flags;
+	__le16 aid;
+	u8 uapsd_queues;
+	u8 max_sp_len;
+	u8 opmode_notif;
+	u8 vif_idx;
+	u8 tdls_sta;
+	u8 tdls_sta_initiator;
+	u8 tdls_chsw_allowed;
+};
+
+struct ra6w_cmd_sta_add_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_sta_add_data data;
+} __packed;
+
+struct ra6w_cmd_sta_del_data {
+	u8 sta_idx;
+	u8 is_tdls_sta;
+};
+
+struct ra6w_cmd_sta_del_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_sta_del_data data;
+} __packed;
+
+struct ra6w_cmd_key_add_rsp {
+	u8 status;
+	u8 hw_key_index;
+};
+
+struct ra6w_cmd_sta_add_rsp {
+	u8 sta_idx;
+	u8 status;
+	u8 pm_state;
+};
+
+struct ra6w_cmd_ap_start_rsp {
+	u8 status;
+	u8 vif_idx;
+	u8 ch_idx;
+	u8 bcmc_idx;
+};
+
+struct ra6w_cmd_mon_mode_rsp {
+	u8 chan_index;
+	struct ra6w_cmd_oper_ch_info chan;
+};
+
+struct ra6w_cmd_probe_client_rsp {
+	u8 status;
+	__le32 probe_id;
+};
+
+struct ra6w_cmd_mem_read_rsp {
+	__le32 memaddr;
+	__le32 memdata;
+};
+
+struct ra6w_cmd_rf_per_rsp {
+	__le32 pass;
+	__le32 fcs;
+	__le32 phy;
+	__le32 overflow;
+};
+
+enum ra6w_cmd_stats_tx_bits {
+	RA6W_STATS_TX_STOP_BIT = BIT(0),
+	RA6W_STATS_TX_START_BIT = BIT(1),
+	RA6W_STATS_TX_REQ_BIT = BIT(2)
+};
+
+struct ra6w_cmd_stats_tx_data {
+	u8 req_type;
+};
+
+struct ra6w_cmd_stats_tx_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_stats_tx_data data;
+} __packed;
+
+#define RA6W_CMD_CCK_OFDM_MCS_CNT	15
+#define RA6W_CMD_HT_GI_CNT		2
+#define RA6W_CMD_HT_MCS_CNT		8
+#define RA6W_CMD_VHT_GI_CNT		2
+#define RA6W_CMD_VHT_MCS_CNT		10
+#define RA6W_CMD_HE_GI_CNT		3
+#define RA6W_CMD_HE_MCS_CNT		10
+
+struct ra6w_cmd_stats_tx_rsp {
+	u8 status;
+	__le64 t_success_cnt[4];
+	__le64 t_fail_cnt[4];
+	__le32 epr[2];
+	u8 format_mod;
+	union {
+		struct {
+			__le64 success[RA6W_CMD_CCK_OFDM_MCS_CNT];
+			__le64 fail[RA6W_CMD_CCK_OFDM_MCS_CNT];
+		} non_ht;
+		struct {
+			__le64 success[RA6W_CMD_HT_GI_CNT][RA6W_CMD_HT_MCS_CNT];
+			__le64 fail[RA6W_CMD_HT_GI_CNT][RA6W_CMD_HT_MCS_CNT];
+		} ht;
+		struct {
+			__le64 success[RA6W_CMD_VHT_GI_CNT][RA6W_CMD_VHT_MCS_CNT];
+			__le64 fail[RA6W_CMD_VHT_GI_CNT][RA6W_CMD_VHT_MCS_CNT];
+		} vht;
+		struct {
+			__le64 success[RA6W_CMD_HE_GI_CNT][RA6W_CMD_HE_MCS_CNT];
+			__le64 fail[RA6W_CMD_HE_GI_CNT][RA6W_CMD_HE_MCS_CNT];
+		} he;
+	};
+};
+
+struct ra6w_cmd_sc_survey_info {
+	__le16 freq;
+	s8 chan_noise_dbm;
+	__le32 chan_dwell_ms;
+	__le32 chan_busy_ms;
+};
+
+struct ra6w_cmd_legacy_info {
+	u32 format_mod : 4;
+	u32 ch_bw : 3;
+	u32 pre_type : 1;
+	u32 leg_length : 12;
+	u32 leg_rate : 4;
+} __packed;
+
+struct ra6w_cmd_sc_result_ind {
+	__le16 length;
+	__le16 framectrl;
+	__le16 center_freq;
+	u8 band;
+	u8 sta_idx;
+	u8 inst_nbr;
+	s8 rssi;
+	struct ra6w_cmd_legacy_info legacy_info;
+	u32 payload[];
+};
+
+#define RA6W_CMD_ASSOC_IE_SIZE	256
+
+struct ra6w_cmd_sm_connect_ind {
+	__le16 conn_status;
+	struct ra6w_cmd_mac_addr bssid;
+	u8 is_roam;
+	u8 vif_idx;
+	u8 ap_idx;
+	u8 ch_idx;
+	u8 flag_qos;
+	u8 acm_bits;
+	__le16 assoc_req_ie_len;
+	__le16 assoc_rsp_ie_len;
+	__le16 assoc_id;
+	struct ra6w_cmd_oper_ch_info oper_chan;
+	__le32 edca_param[RA6W_CMD_AC_MAX];
+	u8 assoc_ie_buf[RA6W_CMD_ASSOC_IE_SIZE];
+};
+
+struct ra6w_cmd_disconnect_data {
+	__le16 deauth_reason;
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_disconnect_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_disconnect_data data;
+} __packed;
+
+struct ra6w_cmd_sm_disconnect_ind {
+	__le16 reason_code;
+	u8 vif_idx;
+	u8 reassoc;
+};
+
+struct ra6w_cmd_secury_key_info {
+	u8 length;
+	u32 array[RA6W_CMD_SECURY_KEY_LEN / 4];
+};
+
+struct ra6w_cmd_key_add_data {
+	u8 key_idx;
+	u8 sta_id;
+	struct ra6w_cmd_secury_key_info key;
+	u8 cipher_suite;
+	u8 vif_idx;
+	u8 spp;
+	u8 pairwise;
+};
+
+struct ra6w_cmd_key_add_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_key_add_data data;
+} __packed;
+
+struct ra6w_cmd_key_del_data {
+	u8 key_index;
+};
+
+struct ra6w_cmd_key_del_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_key_del_data data;
+} __packed;
+
+struct ra6w_cmd_port_control_data {
+	u8 sta_idx;
+	u8 port_control_state;
+};
+
+struct ra6w_cmd_port_control_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_port_control_data data;
+} __packed;
+
+struct ra6w_cmd_roc_data {
+	u8 op_code;
+	u8 vif_idx;
+	struct ra6w_cmd_oper_ch_info chan;
+	__le32 duration_ms;
+};
+
+struct ra6w_cmd_roc_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_roc_data data;
+} __packed;
+
+struct ra6w_cmd_ap_start_data {
+	struct ra6w_cmd_mac_rateset basic_rates;
+	struct ra6w_cmd_oper_ch_info chan;
+	__le16 tim_oft;
+	__le16 bcn_int;
+	__le32 flags;
+	__be16 ctrl_port_ethertype;
+	u8 tim_len;
+	u8 vif_idx;
+	u8 beacon[RA6W_CMD_BCN_SIZE];
+	__le16 bcn_len;
+};
+
+struct ra6w_cmd_ap_start_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_ap_start_data data;
+} __packed;
+
+struct ra6w_cmd_ap_stop_data {
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_ap_stop_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_ap_stop_data data;
+} __packed;
+
+struct ra6w_cmd_mon_mode_data {
+	struct ra6w_cmd_oper_ch_info chan;
+	u8 ch_valid;
+	u8 uf_enable;
+};
+
+struct ra6w_cmd_mon_mode_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_mon_mode_data data;
+} __packed;
+
+struct ra6w_cmd_probe_client_data {
+	u8 vif_idx;
+	u8 sta_idx;
+};
+
+struct ra6w_cmd_probe_client_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_probe_client_data data;
+} __packed;
+
+struct ra6w_cmd_ap_isolate_data {
+	u8 ap_isolate;
+};
+
+struct ra6w_cmd_ap_isolate_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_ap_isolate_data data;
+} __packed;
+
+struct ra6w_cmd_ap_isolate_rsp {
+	u8 ap_isolate;
+};
+
+struct ra6w_cmd_set_tx_power_data {
+	u8 vif_idx;
+	s8 tx_power;
+};
+
+struct ra6w_cmd_set_tx_power_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_set_tx_power_data data;
+} __packed;
+
+struct ra6w_cmd_edca_data {
+	__le32 edca_param;
+	u8 uapsd_enabled;
+	u8 ac;
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_edca_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_edca_data data;
+} __packed;
+
+struct ra6w_cmd_set_power_mgmt_data {
+	u8 ps_mode;
+};
+
+struct ra6w_cmd_set_power_mgmt_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_set_power_mgmt_data data;
+} __packed;
+
+struct ra6w_cmd_cqm_rssi_config_data {
+	u8 vif_idx;
+	s8 rssi_thold;
+	u8 rssi_hyst;
+};
+
+struct ra6w_cmd_cqm_rssi_config_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_cqm_rssi_config_data data;
+} __packed;
+
+struct ra6w_cmd_me_mic_failure_ind {
+	struct ra6w_cmd_mac_addr mac_addr;
+	__le64 tsc;
+	u8 group;
+	u8 keyid;
+	u8 vif_idx;
+};
+
+struct ra6w_cmd_rssi_status_ind {
+	u8 vif_idx;
+	u8 rssi_status;
+	s8 rssi;
+};
+
+struct ra6w_cmd_dbg_mem_read_data {
+	__le32 mem_addr;
+};
+
+struct ra6w_cmd_dbg_mem_read_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_dbg_mem_read_data data;
+} __packed;
+
+struct ra6w_cmd_dbg_mem_write_data {
+	__le32 mem_addr;
+	__le32 mem_value;
+};
+
+struct ra6w_cmd_dbg_mem_write_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_dbg_mem_write_data data;
+} __packed;
+
+struct ra6w_cmd_dbg_mode_filter_data {
+	__le32 mode_filter;
+};
+
+struct ra6w_cmd_dbg_mode_filter_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_dbg_mode_filter_data data;
+} __packed;
+
+struct ra6w_cmd_dbg_level_filter_data {
+	__le32 level_filter;
+};
+
+struct ra6w_cmd_dbg_level_filter_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_dbg_level_filter_data data;
+} __packed;
+
+struct ra6w_cmd_rf_tx_data {
+	__le64 bssid;
+	__le64 dest_addr;
+	__le16 frequency;
+	__le16 num_frames;
+	__le16 frame_len;
+	u8 start;
+	__le32 tx_rate;
+	__le32 tx_power;
+	u8 gi;
+	u8 green_field;
+	u8 preamble_type;
+	u8 qos_enable;
+	u8 ack_policy;
+	u8 aifsn_val;
+};
+
+struct ra6w_cmd_rf_tx_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_rf_tx_data data;
+} __packed;
+
+struct ra6w_cmd_rf_cw_data {
+	u8 start;
+	__le32 tx_power;
+	__le16 frequency;
+};
+
+struct ra6w_cmd_rf_cw_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_rf_cw_data data;
+} __packed;
+
+struct ra6w_cmd_rf_cont_data {
+	__le16 frequency;
+	u8 start;
+	__le32 tx_rate;
+	__le32 tx_power;
+};
+
+struct ra6w_cmd_rf_cont_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_rf_cont_data data;
+} __packed;
+
+struct ra6w_cmd_rf_ch_data {
+	__le16 frequency;
+};
+
+struct ra6w_cmd_rf_ch_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_rf_ch_data data;
+} __packed;
+
+struct ra6w_cmd_rf_per_data {
+	u8 start;
+};
+
+struct ra6w_cmd_rf_per_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_rf_per_data data;
+} __packed;
+
+struct ra6w_cmd_sm_ext_auth_req_ind {
+	u8 vif_idx;
+	struct ra6w_cmd_mac_ssid ssid;
+	struct ra6w_cmd_mac_addr bssid;
+	__le32 key_mgmt_suite;
+};
+
+struct ra6w_cmd_sm_ext_auth_req_rsp_data {
+	u8 vif_idx;
+	__le16 status;
+};
+
+struct ra6w_cmd_sm_ext_auth_req_rsp_req {
+	struct ra6w_cmd_hdr hdr;
+	struct ra6w_cmd_sm_ext_auth_req_rsp_data data;
+} __packed;
+
+struct ra6w_cmd_channel_switch_ind {
+	u8 chan_index;
+	u8 roc_req;
+	u8 vif_idx;
+	u8 roc_tdls;
+	__le32 duration_us;
+	__le16 freq;
+};
+
+struct ra6w_cmd_channel_pre_switch_ind {
+	u8 chan_index;
+};
+
+struct ra6w_cmd_ap_probe_client_ind {
+	u8 vif_idx;
+	u8 sta_idx;
+	u8 client_present;
+	__le32 probe_id;
+};
+
+struct ra6w_cmd_pktloss_ind {
+	u8 vif_idx;
+	struct ra6w_cmd_mac_addr mac_addr;
+	__le32 num_packets;
+};
+
+struct ra6w_cmd_csa_counter_ind {
+	u8 vif_idx;
+	u8 csa_count;
+};
+
+struct ra6w_cmd_csa_finish_ind {
+	u8 vif_idx;
+	u8 status;
+	u8 chan_idx;
+};
+
+struct ra6w_cmd_csa_traffic_ind {
+	u8 vif_idx;
+	u8 enable;
+};
+
+#endif /* RA6W_CMD_H */
-- 
2.17.1


