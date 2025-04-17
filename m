Return-Path: <linux-wireless+bounces-21645-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD4CA91EC0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D24E463D98
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134724EABC;
	Thu, 17 Apr 2025 13:53:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D5524EA93
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897991; cv=none; b=ZvOuexwUcLJAPT7zHEvuES3qPUaK2sCjuLoKJAOnDB2oULDAFCwT1Hn8e3yCVb+ox5SpLe/SX1rdNjRsoAXCWSrhszZsKprtfu1h4yH6V8n2wObBix4zmz9q6yz0suodcHh73bI6uupmf+5iGy2auhAg1EO+f0XYK+wR5AkznLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897991; c=relaxed/simple;
	bh=RDYnV9R8FAUgui7wb1hoCO+RugyzO4Yxr3e6VmCpFzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ddMIcQnV3b8YNZf4F4yBW7qmmv0qbLOH7Xr1gYNiWz5srxkgMC4BP8pIDuA5RlQw6xhKWpoZ3DDTQlDtw8C9jv6dgxkZIWHXIiFkC/KV8HaxYIvxBojJXSkNgjGKZN+88dtmcDVBZu/CRCS32wPtud7p4fSUn8309b46hrDNyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: BiFWn/CNSEmuGTmSHhofGw==
X-CSE-MsgGUID: I6xKYjApT/iKAsN5OeS6wg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:07 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 752624005025;
	Thu, 17 Apr 2025 22:53:04 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 05/38] ra6w: add cfg80211.h
Date: Thu, 17 Apr 2025 16:52:03 +0300
Message-Id: <20250417135236.52410-6-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/cfg80211.h | 266 +++++++++++++++++++
 1 file changed, 266 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/cfg80211.h

diff --git a/drivers/net/wireless/renesas/ra6w/cfg80211.h b/drivers/net/wireless/renesas/ra6w/cfg80211.h
new file mode 100644
index 000000000000..e4eda5898a6a
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/cfg80211.h
@@ -0,0 +1,266 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_CFG80211_H
+#define RA6W_CFG80211_H
+
+#include <net/cfg80211.h>
+
+#include "core.h"
+#include "stats.h"
+
+#define RA6W_CFG80211_CH_MAX_POWER		30
+#define RA6W_CFG80211_EXT_CAPA_MAX		10
+#define RA6W_CFG80211_CHANINFO_MAX		3
+#define RA6W_CFG80211_ROC_TX			5
+#define RA6W_CFG80211_STA_MAX			4
+#define RA6W_CFG80211_VIF_MAX			2
+#define RA6W_CFG80211_STA_TABLE_MAX		(RA6W_CFG80211_STA_MAX + RA6W_CFG80211_VIF_MAX)
+#define RA6W_CFG80211_NDEV_TXQ			1
+#define RA6W_CFG80211_NDEV_RXQ			1
+#define RA6W_CFG80211_LPCA_PPM			20
+#define RA6W_CFG80211_UAPSD_TIMEOUT		300
+#define RA6W_CFG80211_KEYS_MAX			6
+#define RA6W_CFG80211_WPI_SUBKEY_LEN		16
+#define RA6W_CFG80211_WPI_KEY_LEN		32
+#define RA6W_CFG80211_KEY_LEN_MAX		32
+#define RA6W_CFG80211_KEY_SEQ_LEN_MAX		8
+#define RA6W_CFG80211_CH_IDX_INVALID		0xFF
+#define RA6W_CFG80211_VIF_IDX_INVALID		0xFF
+#define RA6W_CFG80211_STA_IDX_INVALID		0xFF
+#define RA6W_CFG80211_TID_INVALID		0x1F
+#define RA6W_CFG80211_RESERVED_CIPHER_NUM	5
+
+enum ra6w_cfg80211_formatmod {
+	RA6W_CFG80211_FORMATMOD_NON_HT,
+	RA6W_CFG80211_FORMATMOD_NON_HT_DUP_OFDM,
+	RA6W_CFG80211_FORMATMOD_HT_MF,
+	RA6W_CFG80211_FORMATMOD_HT_GF,
+	RA6W_CFG80211_FORMATMOD_VHT,
+	RA6W_CFG80211_FORMATMOD_HE_SU,
+	RA6W_CFG80211_FORMATMOD_HE_MU,
+	RA6W_CFG80211_FORMATMOD_HE_ER,
+	RA6W_CFG80211_FORMATMOD_HE_TB,
+
+	RA6W_CFG80211_FORMATMOD_MAX
+};
+
+struct ra6w_cfg80211_legrate {
+	s16 idx;
+	u16 rate; // in 100Kbps
+};
+
+enum ra6w_cfg80211_vif_type {
+	RA6W_VIF_TYPE_STA,
+	RA6W_VIF_TYPE_IBSS,
+	RA6W_VIF_TYPE_AP,
+	RA6W_VIF_TYPE_MESH_POINT,
+	RA6W_VIF_TYPE_MONITOR,
+
+	RA6W_VIF_TYPE_MAX
+};
+
+enum ra6w_cfg80211_machw_support_type {
+	RA6W_MACHW_SUPPORT_DEFAULT = 10,
+	RA6W_MACHW_SUPPORT_HE = 20,
+	RA6W_MACHW_SUPPORT_AP_HE = 30,
+};
+
+enum ra6w_cfg80211_chipher_type {
+	RA6W_CIPHER_WEP40 = 0,
+	RA6W_CIPHER_TKIP = 1,
+	RA6W_CIPHER_CCMP = 2,
+	RA6W_CIPHER_WEP104 = 3,
+	RA6W_CIPHER_SMS4 = 4,
+	RA6W_CIPHER_AES_CMAC_128 = 5,
+	RA6W_CIPHER_GCMP_128 = 6,
+	RA6W_CIPHER_GCMP_256 = 7,
+	RA6W_CIPHER_CCMP_256 = 8,
+	RA6W_CIPHER_BIP_GMAC_128 = 9,
+	RA6W_CIPHER_BIP_GMAC_256 = 10,
+	RA6W_CIPHER_BIP_CMAC_256 = 11,
+	RA6W_CIPHER_INVALID = 0xFF,
+};
+
+enum ra6w_cfg80211_ps_mode {
+	RA6W_CFG80211_PS_MODE_OFF = 0,
+	RA6W_CFG80211_PS_MODE_ON = 1,
+	RA6W_CFG80211_PS_MODE_ON_DYN = 2
+};
+
+struct ra6w_cfg80211_twt_conf_tag {
+	u8 flow_type; /* (0: Announced, 1: Unannounced) */
+	u8 wake_int_exp;
+	bool wake_dur_unit; /* Unit of measurement (0:256us, 1:tu) */
+	u8 min_twt_wake_dur;
+	u16 wake_int_mantissa;
+};
+
+struct ra6w_cfg80211_twt_setup_ind {
+	u8 resp_type;
+	u8 sta_idx;
+	struct ra6w_cfg80211_twt_conf_tag conf;
+};
+
+struct ra6w_cfg80211_beacon_info {
+	u8 *head;
+	u8 *tail;
+	u8 *ies;
+	u16 head_len;
+	u16 tail_len;
+	u16 ies_len;
+	u16 tim_len;
+	u16 len;
+	u8 dtim_period;
+};
+
+struct ra6w_cfg80211_csa_info {
+	struct ra6w_cfg80211_vif *vif;
+	struct ra6w_cfg80211_beacon_info bcn;
+	u8 buf[512];
+	struct cfg80211_chan_def chandef;
+	int count;
+	u8 status;
+	u8 ch_idx;
+	struct work_struct work;
+};
+
+struct ra6w_cfg80211_remain_on_channel {
+	struct ra6w_cfg80211_vif *vif;
+	struct ieee80211_channel *chan;
+	unsigned int duration;
+	bool internal;
+	bool on_chan;
+	s32 tx_cnt;
+	u64 tx_cookie[RA6W_CFG80211_ROC_TX];
+};
+
+struct ra6w_cfg80211_key {
+	u8 key_index;
+	u8 key[RA6W_CFG80211_KEY_LEN_MAX];
+	u8 key_len;
+	u8 seq[RA6W_CFG80211_KEY_SEQ_LEN_MAX];
+	u8 seq_len;
+	u32 cipher;
+	u8 cipher_type;
+	u8 sta_idx;
+	u8 vif_idx;
+	bool pairwise;
+};
+
+struct ra6w_cfg80211_sta_stats {
+	unsigned long last_acttive_time;
+	struct ra6w_rx_ext_hdr last_rx_data_ext;
+	struct ra6w_rx_ext_hdr last_stats;
+	u32 rx_packets;
+	u32 tx_packets;
+	u32 tx_failed;
+	u64 rx_bytes;
+	u64 tx_bytes;
+};
+
+struct ra6w_cfg80211_chan_info {
+	struct cfg80211_chan_def chan_def;
+	u8 count;
+};
+
+struct ra6w_cfg80211_survey_info {
+	u32 filled;
+	u32 chan_dwell_ms;
+	u32 chan_busy_ms;
+	s8 chan_noise_dbm;
+};
+
+struct ra6w_cfg80211_sta {
+	struct list_head list;
+	bool valid;
+	u8 mac_addr[ETH_ALEN];
+	u16 aid;
+	u8 sta_idx;
+	u8 vif_idx;
+	enum nl80211_band band;
+	enum nl80211_chan_width width;
+	u16 center_freq;
+	u32 center_freq1;
+	u32 center_freq2;
+	u8 ch_idx;
+	bool qos;
+	struct ra6w_cfg80211_key key;
+	bool ht;
+	bool vht;
+	bool he;
+	struct ra6w_cfg80211_sta_stats stats;
+	int listen_interval;
+	struct ra6w_cfg80211_twt_setup_ind twt_ind;
+};
+
+struct ra6w_cfg80211_vif {
+	struct list_head list;
+	u8 vif_idx;
+	u8 addr_idx;
+	enum nl80211_iftype type;
+	struct wireless_dev wdev;
+	struct net_device *ndev;
+	void *priv;
+	bool roc_tdls;
+	u8 tdls_status;
+	bool tdls_chsw_prohibited;
+	struct ra6w_cfg80211_key keys[RA6W_CFG80211_KEYS_MAX];
+	u8 ch_idx;
+	bool up;
+	bool use_4addr;
+	s32 generation;
+	struct ra6w_stats stats;
+	union {
+		struct {
+			u32 flags;
+			struct ra6w_cfg80211_sta *ap;
+			struct ra6w_cfg80211_sta *tdls_sta;
+		} sta;
+		struct {
+			u8 ap_isolate;
+			struct list_head sta_list;
+			struct ra6w_cfg80211_beacon_info bcn;
+			u8 bcmc_index;
+			struct ra6w_cfg80211_csa_info *csa;
+		} ap;
+	};
+};
+
+struct ra6w_cfg80211_priv {
+	struct ra6w_core *core;
+	struct wiphy *wiphy;
+	struct dentry *root;
+	u8 ext_capa[RA6W_CFG80211_EXT_CAPA_MAX];
+	struct list_head vifs;
+	struct ra6w_cmd_phy_cfg phy_config;
+	struct ra6w_cfg80211_sta sta_table[RA6W_CFG80211_STA_TABLE_MAX];
+	struct ra6w_cfg80211_vif *vif_table[RA6W_CFG80211_VIF_MAX];
+	DECLARE_BITMAP(vif_map, RA6W_CFG80211_VIF_MAX);
+	struct mac_address addresses[RA6W_CFG80211_VIF_MAX];
+	DECLARE_BITMAP(addr_map, RA6W_CFG80211_VIF_MAX);
+	s32 vif_started;
+	s8 mon_vif_idx;
+	struct ra6w_cfg80211_chan_info chaninfo_table[RA6W_CFG80211_CHANINFO_MAX];
+	u8 chaninfo_index;
+	struct ra6w_cfg80211_remain_on_channel *roc;
+	struct cfg80211_scan_request *scan_request;
+	struct ra6w_cfg80211_survey_info survey_table[RA6W_CMD_SCAN_CHANNEL_MAX];
+};
+
+int ra6w_cfg80211_init(struct ra6w_core *core, struct device *dev);
+void ra6w_cfg80211_deinit(struct ra6w_core *core);
+void ra6w_cfg80211_chaninfo_set(struct ra6w_cfg80211_vif *vif, u8 ch_idx,
+				const struct cfg80211_chan_def *chandef);
+struct ra6w_cfg80211_chan_info *ra6w_cfg80211_chaninfo_get(struct ra6w_cfg80211_vif *vif);
+void ra6w_cfg80211_chaninfo_unset(struct ra6w_cfg80211_vif *vif);
+u8 *ra6w_cfg80211_create_beacon(struct ra6w_cfg80211_beacon_info *bcn,
+				struct cfg80211_beacon_data *new);
+struct ra6w_cfg80211_sta *ra6w_cfg80211_sta_get(struct ra6w_cfg80211_priv *priv, u8 sta_idx);
+void ra6w_cfg80211_sta_free(struct ra6w_cfg80211_vif *vif, u8 sta_idx);
+struct ra6w_cfg80211_vif *ra6w_cfg80211_vif_get(struct ra6w_cfg80211_priv *priv, u8 vif_idx);
+void ra6w_cfg80211_scan_done(struct ra6w_cfg80211_priv *priv);
+
+#endif /* RA6W_CFG80211_H */
-- 
2.17.1


