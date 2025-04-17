Return-Path: <linux-wireless+bounces-21644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B0A91EBE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90AF463E3E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2271324EA9C;
	Thu, 17 Apr 2025 13:53:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F8224EAB6
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897989; cv=none; b=tRs196urj2Dv82FQBXegxajzk/rSqS/06z647xtVYL/VlpVibEcAlfBpNFdQDTYSzaXgp/OP0XbwlinTdKvzWMBA1hSqhfSQce+P51g4oDhPCwRrA7V6454pnNy6jsBM+8SusxEoy2LMk7Xyov5DNcAXrmegvyN6yj7QdOD7luw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897989; c=relaxed/simple;
	bh=K3hbmSn2IEDrGLVS2GRWOhf3+NthrsVcfb1MyA7W6Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=n0I4bYSBsJUdslBb3d8hNRAKKVVqqkW+zj0I9eV5UR1DESF7Gx1a2OVabnJPiGohpVyfVbWLkpd67NfkmoN3ZBmodvKml1rTv4eFZsHS6QNdPfBLJi0XDN4Z9VZA7hp8HJ4Uj5HevZsGH0HG9AAzWQNsYRajq3MPP3Udg8cGA1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: E2WY/yqhTPKLgbO9DKXgZw==
X-CSE-MsgGUID: jwSxsgL6Tcu7MLCaKX5jyA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:03 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6D42B4006DE8;
	Thu, 17 Apr 2025 22:52:57 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 04/38] ra6w: add cfg80211.c
Date: Thu, 17 Apr 2025 16:52:02 +0300
Message-Id: <20250417135236.52410-5-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/cfg80211.c | 2519 ++++++++++++++++++
 1 file changed, 2519 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/cfg80211.c

diff --git a/drivers/net/wireless/renesas/ra6w/cfg80211.c b/drivers/net/wireless/renesas/ra6w/cfg80211.c
new file mode 100644
index 000000000000..bbe035751bf1
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/cfg80211.c
@@ -0,0 +1,2519 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains communication with cfg80211 module.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_ether.h>
+#include <linux/inetdevice.h>
+#include <net/cfg80211.h>
+#include <net/ip.h>
+
+#include "dbg.h"
+#include "core.h"
+#include "ctrl.h"
+#include "cfg80211.h"
+#include "dev.h"
+#include "dbgfs.h"
+#include "testmode.h"
+#include "params.h"
+
+#define RATE(_bitrate, _hw_rate, _flags) {	\
+	.bitrate = (_bitrate),			\
+	.flags = (_flags),			\
+	.hw_value = (_hw_rate),			\
+}
+
+#define CHAN(_band, _channel, _freq) {			\
+	.band = (_band),				\
+	.hw_value = (_channel),				\
+	.center_freq = (_freq),				\
+	.flags = 0,					\
+	.max_antenna_gain = 0,				\
+	.max_power = RA6W_CFG80211_CH_MAX_POWER,	\
+}
+
+static const u8 ra6w_ac2hwq[IEEE80211_NUM_ACS] = {
+	[NL80211_TXQ_Q_VO] = RA6W_CMD_AC_VO,
+	[NL80211_TXQ_Q_VI] = RA6W_CMD_AC_VI,
+	[NL80211_TXQ_Q_BE] = RA6W_CMD_AC_BE,
+	[NL80211_TXQ_Q_BK] = RA6W_CMD_AC_BK
+};
+
+static struct ieee80211_iface_limit ra6w_if_limits[] = {
+	{
+		.max = RA6W_CFG80211_VIF_MAX,
+		.types = BIT(NL80211_IFTYPE_AP) | BIT(NL80211_IFTYPE_STATION)
+	}
+};
+
+static const struct ieee80211_iface_combination ra6w_if_comb[] = {
+	{
+		.limits = ra6w_if_limits,
+		.n_limits = ARRAY_SIZE(ra6w_if_limits),
+		.num_different_channels = RA6W_CFG80211_CHANINFO_MAX,
+		.max_interfaces = RA6W_CFG80211_VIF_MAX,
+	},
+};
+
+static struct ieee80211_txrx_stypes ra6w_macm_stypes[NUM_NL80211_IFTYPES] = {
+	[NL80211_IFTYPE_STATION] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4)
+	},
+	[NL80211_IFTYPE_P2P_CLIENT] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_P2P_GO] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4)
+	},
+	[NL80211_IFTYPE_P2P_DEVICE] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ACTION >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4)
+	},
+	[NL80211_IFTYPE_AP] = {
+		.tx = 0xffff,
+		.rx = BIT(IEEE80211_STYPE_ASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_REASSOC_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_PROBE_REQ >> 4) |
+		      BIT(IEEE80211_STYPE_DISASSOC >> 4) |
+		      BIT(IEEE80211_STYPE_AUTH >> 4) |
+		      BIT(IEEE80211_STYPE_DEAUTH >> 4) |
+		      BIT(IEEE80211_STYPE_ACTION >> 4)
+	},
+};
+
+static u32 ra6w_cipher_suites[] = {
+	WLAN_CIPHER_SUITE_WEP40,
+	WLAN_CIPHER_SUITE_WEP104,
+	WLAN_CIPHER_SUITE_TKIP,
+	WLAN_CIPHER_SUITE_CCMP,
+	0,
+	0,
+	0,
+	0,
+	0
+};
+
+static struct ieee80211_rate ra6w_rate_table[] = {
+	RATE(10, 0x00, 0),
+	RATE(20, 0x01, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATE(55, 0x02, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATE(110, 0x03, IEEE80211_RATE_SHORT_PREAMBLE),
+	RATE(60, 0x04, 0),
+	RATE(90, 0x05, 0),
+	RATE(120, 0x06, 0),
+	RATE(180, 0x07, 0),
+	RATE(240, 0x08, 0),
+	RATE(360, 0x09, 0),
+	RATE(480, 0x0A, 0),
+	RATE(540, 0x0B, 0),
+};
+
+static struct ieee80211_channel ra6w_chans_2g[] = {
+	CHAN(NL80211_BAND_2GHZ, 1, 2412),
+	CHAN(NL80211_BAND_2GHZ, 2, 2417),
+	CHAN(NL80211_BAND_2GHZ, 3, 2422),
+	CHAN(NL80211_BAND_2GHZ, 4, 2427),
+	CHAN(NL80211_BAND_2GHZ, 5, 2432),
+	CHAN(NL80211_BAND_2GHZ, 6, 2437),
+	CHAN(NL80211_BAND_2GHZ, 7, 2442),
+	CHAN(NL80211_BAND_2GHZ, 8, 2447),
+	CHAN(NL80211_BAND_2GHZ, 9, 2452),
+	CHAN(NL80211_BAND_2GHZ, 10, 2457),
+	CHAN(NL80211_BAND_2GHZ, 11, 2462),
+	CHAN(NL80211_BAND_2GHZ, 12, 2467),
+	CHAN(NL80211_BAND_2GHZ, 13, 2472),
+	CHAN(NL80211_BAND_2GHZ, 14, 2484),
+};
+
+static struct ieee80211_channel ra6w_chans_5g[] = {
+	CHAN(NL80211_BAND_5GHZ, 36, 5180),
+	CHAN(NL80211_BAND_5GHZ, 40, 5200),
+	CHAN(NL80211_BAND_5GHZ, 44, 5220),
+	CHAN(NL80211_BAND_5GHZ, 48, 5240),
+	CHAN(NL80211_BAND_5GHZ, 52, 5260),
+	CHAN(NL80211_BAND_5GHZ, 56, 5280),
+	CHAN(NL80211_BAND_5GHZ, 60, 5300),
+	CHAN(NL80211_BAND_5GHZ, 64, 5320),
+	CHAN(NL80211_BAND_5GHZ, 100, 5500),
+	CHAN(NL80211_BAND_5GHZ, 104, 5520),
+	CHAN(NL80211_BAND_5GHZ, 108, 5540),
+	CHAN(NL80211_BAND_5GHZ, 112, 5560),
+	CHAN(NL80211_BAND_5GHZ, 116, 5580),
+	CHAN(NL80211_BAND_5GHZ, 120, 5600),
+	CHAN(NL80211_BAND_5GHZ, 124, 5620),
+	CHAN(NL80211_BAND_5GHZ, 128, 5640),
+	CHAN(NL80211_BAND_5GHZ, 132, 5660),
+	CHAN(NL80211_BAND_5GHZ, 136, 5680),
+	CHAN(NL80211_BAND_5GHZ, 140, 5700),
+	CHAN(NL80211_BAND_5GHZ, 144, 5720),
+	CHAN(NL80211_BAND_5GHZ, 149, 5745),
+	CHAN(NL80211_BAND_5GHZ, 153, 5765),
+	CHAN(NL80211_BAND_5GHZ, 157, 5785),
+	CHAN(NL80211_BAND_5GHZ, 161, 5805),
+	CHAN(NL80211_BAND_5GHZ, 165, 5825),
+	CHAN(NL80211_BAND_5GHZ, 169, 5845),
+	CHAN(NL80211_BAND_5GHZ, 173, 5865),
+};
+
+static struct ieee80211_sband_iftype_data ra6w_cap_he_2g = {
+	.types_mask = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP),
+};
+
+static struct ieee80211_sband_iftype_data ra6w_cap_he_5g = {
+	.types_mask = BIT(NL80211_IFTYPE_STATION) | BIT(NL80211_IFTYPE_AP),
+};
+
+static struct ieee80211_supported_band ra6w_band_2g = {
+	.channels = ra6w_chans_2g,
+	.n_channels = ARRAY_SIZE(ra6w_chans_2g),
+	.bitrates = ra6w_rate_table,
+	.n_bitrates = ARRAY_SIZE(ra6w_rate_table),
+	.n_iftype_data = 1,
+	.band = NL80211_BAND_2GHZ,
+};
+
+static struct ieee80211_supported_band ra6w_band_5g = {
+	.channels = ra6w_chans_5g,
+	.n_channels = ARRAY_SIZE(ra6w_chans_5g),
+	.bitrates = &ra6w_rate_table[4],
+	.n_bitrates = ARRAY_SIZE(ra6w_rate_table) - 4,
+	.n_iftype_data = 1,
+	.band = NL80211_BAND_5GHZ,
+};
+
+static const struct ra6w_cfg80211_legrate ra6w_legacy_rate_table[] = {
+	[0] = { .idx = 0, .rate = 10 },
+	[1] = { .idx = 1, .rate = 20 },
+	[2] = { .idx = 2, .rate = 55 },
+	[3] = { .idx = 3, .rate = 110 },
+	[4] = { .idx = -1, .rate = 0 },
+	[5] = { .idx = -1, .rate = 0 },
+	[6] = { .idx = -1, .rate = 0 },
+	[7] = { .idx = -1, .rate = 0 },
+	[8] = { .idx = 10, .rate = 480 },
+	[9] = { .idx = 8, .rate = 240 },
+	[10] = { .idx = 6, .rate = 120 },
+	[11] = { .idx = 4, .rate = 60 },
+	[12] = { .idx = 11, .rate = 540 },
+	[13] = { .idx = 9, .rate = 360 },
+	[14] = { .idx = 7, .rate = 180 },
+	[15] = { .idx = 5, .rate = 90 },
+};
+
+static const int ra6w_mcs_map_to_rate[] = {
+	[IEEE80211_VHT_MCS_SUPPORT_0_7] = 65,
+	[IEEE80211_VHT_MCS_SUPPORT_0_8] = 78,
+	[IEEE80211_VHT_MCS_SUPPORT_0_9] = 78,
+};
+
+static void ra6w_cfg80211_dev_init(struct net_device *ndev)
+{
+	ra6w_dev_init(ndev);
+}
+
+static void ra6w_cfg80211_reg_notifier(struct wiphy *wiphy, struct regulatory_request *req)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+
+	ra6w_dbg("[%s] initiator=%d, alpha=%c%c\n", __func__,
+		 req->initiator, req->alpha2[0], req->alpha2[1]);
+
+	memcpy(priv->phy_config.country_code, req->alpha2, sizeof(req->alpha2));
+
+	ra6w_ctrl_chan_config(&priv->core->ctrl, wiphy);
+}
+
+u8 *ra6w_cfg80211_create_beacon(struct ra6w_cfg80211_beacon_info *bcn,
+				struct cfg80211_beacon_data *new)
+{
+	u8 *buf = NULL;
+	u8 *pos = NULL;
+
+	if (new->head) {
+		u8 *head = kzalloc(new->head_len, GFP_KERNEL);
+
+		if (!head)
+			return NULL;
+
+		kfree(bcn->head);
+
+		bcn->head = head;
+		bcn->head_len = new->head_len;
+		memcpy(bcn->head, new->head, new->head_len);
+	}
+
+	if (new->tail) {
+		u8 *tail = kzalloc(new->tail_len, GFP_KERNEL);
+
+		if (!tail)
+			return NULL;
+
+		kfree(bcn->tail);
+
+		bcn->tail = tail;
+		bcn->tail_len = new->tail_len;
+		memcpy(bcn->tail, new->tail, new->tail_len);
+	}
+
+	if (!bcn->head)
+		return NULL;
+
+	bcn->tim_len = 6;
+	bcn->len = bcn->head_len + bcn->tail_len + bcn->ies_len + bcn->tim_len;
+
+	buf = kzalloc(bcn->len, GFP_KERNEL);
+	if (!buf)
+		return NULL;
+
+	pos = buf;
+	memcpy(pos, bcn->head, bcn->head_len);
+	pos += bcn->head_len;
+	*pos++ = WLAN_EID_TIM;
+	*pos++ = 4;
+	*pos++ = 0;
+	*pos++ = bcn->dtim_period;
+	*pos++ = 0;
+	*pos++ = 0;
+	if (bcn->tail) {
+		memcpy(pos, bcn->tail, bcn->tail_len);
+		pos += bcn->tail_len;
+	}
+
+	if (bcn->ies)
+		memcpy(pos, bcn->ies, bcn->ies_len);
+
+	return buf;
+}
+
+static void ra6w_cfg80211_remove_beacon(struct ra6w_cfg80211_beacon_info *bcn)
+{
+	kfree(bcn->head);
+	bcn->head = NULL;
+	bcn->head_len = 0;
+
+	kfree(bcn->tail);
+	bcn->tail = NULL;
+	bcn->tail_len = 0;
+
+	kfree(bcn->ies);
+	bcn->ies = NULL;
+	bcn->ies_len = 0;
+	bcn->tim_len = 0;
+	bcn->dtim_period = 0;
+	bcn->len = 0;
+}
+
+static void ra6w_cfg80211_csa_remove(struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_cfg80211_csa_info *csa = vif->ap.csa;
+
+	if (!csa)
+		return;
+
+	ra6w_cfg80211_remove_beacon(&csa->bcn);
+	kfree(csa);
+	vif->ap.csa = NULL;
+}
+
+struct ra6w_cfg80211_chan_info *ra6w_cfg80211_chaninfo_get(struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_cfg80211_priv *priv;
+
+	if (!vif)
+		return NULL;
+
+	priv = vif->priv;
+	if (!priv)
+		return NULL;
+
+	if (vif->ch_idx >= RA6W_CFG80211_CHANINFO_MAX ||
+	    !priv->chaninfo_table[vif->ch_idx].chan_def.chan)
+		return NULL;
+
+	return &priv->chaninfo_table[vif->ch_idx];
+}
+
+static void ra6w_cfg80211_csa_work(struct work_struct *ws)
+{
+	struct ra6w_cfg80211_csa_info *csa = container_of(ws, struct ra6w_cfg80211_csa_info,
+							    work);
+	struct ra6w_cfg80211_vif *vif = csa->vif;
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+
+	if (!priv)
+		goto out;
+
+	if (csa->status) {
+		cfg80211_stop_iface(priv->wiphy, &vif->wdev, GFP_KERNEL);
+		goto out;
+	}
+
+	ra6w_ctrl_change_beacon_req(&priv->core->ctrl, vif->vif_idx,
+				    csa->buf,
+				    csa->bcn.len, csa->bcn.head_len,
+				    csa->bcn.tim_len, NULL);
+
+	wiphy_lock(priv->wiphy);
+	ra6w_cfg80211_chaninfo_unset(vif);
+	ra6w_cfg80211_chaninfo_set(vif, csa->ch_idx, &csa->chandef);
+	cfg80211_ch_switch_notify(vif->ndev, &csa->chandef, 0);
+	wiphy_unlock(priv->wiphy);
+
+out:
+	ra6w_cfg80211_csa_remove(vif);
+}
+
+static int ra6w_cfg80211_station_info_fill(struct ra6w_cfg80211_sta *sta,
+					   struct station_info *sinfo,
+					   struct ra6w_cfg80211_vif *vif)
+{
+	const struct ra6w_cfg80211_sta_stats *stats = &sta->stats;
+	u16 format_mod = 0;
+
+	sinfo->generation = vif->generation;
+	sinfo->inactive_time = jiffies_to_msecs(jiffies - stats->last_acttive_time);
+	sinfo->filled = BIT(NL80211_STA_INFO_INACTIVE_TIME);
+	sinfo->rx_bytes = sta->stats.rx_bytes;
+	sinfo->filled |= BIT(NL80211_STA_INFO_RX_BYTES64);
+	sinfo->rx_packets = sta->stats.rx_packets;
+	sinfo->filled |= BIT(NL80211_STA_INFO_RX_PACKETS);
+	sinfo->tx_bytes = sta->stats.tx_bytes;
+	sinfo->filled |= BIT(NL80211_STA_INFO_TX_BYTES64);
+	sinfo->tx_packets = sta->stats.tx_packets;
+	sinfo->filled |= BIT(NL80211_STA_INFO_TX_PACKETS);
+	sinfo->tx_failed = sta->stats.tx_failed;
+	sinfo->filled |= BIT(NL80211_STA_INFO_TX_FAILED);
+	sinfo->signal = stats->last_rx_data_ext.rssi1;
+	sinfo->filled |= BIT(NL80211_STA_INFO_SIGNAL);
+
+	switch (stats->last_rx_data_ext.ch_bw) {
+	case 0:
+		sinfo->rxrate.bw = RATE_INFO_BW_20;
+		break;
+	case 1:
+		sinfo->rxrate.bw = RATE_INFO_BW_40;
+		break;
+	case 2:
+		sinfo->rxrate.bw = RATE_INFO_BW_80;
+		break;
+	case 3:
+		sinfo->rxrate.bw = RATE_INFO_BW_160;
+		break;
+	default:
+		sinfo->rxrate.bw = RATE_INFO_BW_HE_RU;
+		break;
+	}
+
+	if (stats->last_rx_data_ext.pre_type)
+		format_mod = stats->last_rx_data_ext.format_mod + 1;
+	else
+		format_mod = stats->last_rx_data_ext.format_mod;
+
+	if (stats->last_stats.format_mod > 1 && format_mod < 2)
+		format_mod = stats->last_stats.format_mod;
+
+	switch (format_mod) {
+	case RA6W_CFG80211_FORMATMOD_NON_HT:
+	case RA6W_CFG80211_FORMATMOD_NON_HT_DUP_OFDM:
+		sinfo->rxrate.flags = 0;
+		sinfo->rxrate.legacy =
+			ra6w_legacy_rate_table[stats->last_rx_data_ext.leg_rate].rate;
+		break;
+	case RA6W_CFG80211_FORMATMOD_HT_MF:
+	case RA6W_CFG80211_FORMATMOD_HT_GF:
+		sinfo->rxrate.flags = RATE_INFO_FLAGS_MCS;
+		if (stats->last_stats.ht.short_gi)
+			sinfo->rxrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		sinfo->rxrate.mcs = stats->last_stats.ht.mcs;
+		break;
+	case RA6W_CFG80211_FORMATMOD_VHT:
+		sinfo->rxrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (stats->last_stats.vht.short_gi)
+			sinfo->rxrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		sinfo->rxrate.mcs = stats->last_stats.vht.mcs;
+		sinfo->rxrate.nss = stats->last_stats.vht.nss + 1;
+		break;
+	case RA6W_CFG80211_FORMATMOD_HE_MU:
+		sinfo->rxrate.he_ru_alloc = stats->last_stats.he.ru_size;
+		fallthrough;
+	case RA6W_CFG80211_FORMATMOD_HE_SU:
+	case RA6W_CFG80211_FORMATMOD_HE_ER:
+	case RA6W_CFG80211_FORMATMOD_HE_TB:
+		sinfo->rxrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		sinfo->rxrate.mcs = stats->last_stats.he.mcs;
+		sinfo->rxrate.nss = stats->last_stats.he.nss;
+		sinfo->rxrate.he_gi = stats->last_stats.he.gi_type;
+		sinfo->rxrate.he_dcm = stats->last_stats.he.dcm;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	sinfo->filled |= BIT(NL80211_STA_INFO_RX_BITRATE);
+
+	return 0;
+}
+
+struct ra6w_cfg80211_sta *ra6w_cfg80211_sta_get(struct ra6w_cfg80211_priv *priv, u8 sta_idx)
+{
+	if (!priv)
+		return NULL;
+
+	if (sta_idx >= RA6W_CFG80211_STA_TABLE_MAX)
+		return NULL;
+
+	return &priv->sta_table[sta_idx];
+}
+
+void ra6w_cfg80211_sta_free(struct ra6w_cfg80211_vif *vif, u8 sta_idx)
+{
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+	struct ra6w_cfg80211_sta *sta = NULL;
+
+	if (!priv)
+		return;
+
+	sta = ra6w_cfg80211_sta_get(priv, sta_idx);
+	if (!sta)
+		return;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		list_del(&sta->list);
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		vif->sta.ap = NULL;
+	default:
+		break;
+	}
+
+	sta->valid = false;
+	sta->aid = RA6W_CFG80211_STA_IDX_INVALID;
+	sta->sta_idx = RA6W_CFG80211_STA_IDX_INVALID;
+	sta->vif_idx = RA6W_CFG80211_VIF_IDX_INVALID;
+	memset(sta->mac_addr, 0, ETH_ALEN);
+}
+
+static struct ra6w_cfg80211_sta *ra6w_cfg80211_find_sta(struct ra6w_cfg80211_priv *priv,
+							const u8 *mac_addr)
+{
+	struct ra6w_cfg80211_sta *sta = NULL;
+	u8 i;
+
+	for (i = 0; i < RA6W_CFG80211_STA_MAX; i++) {
+		sta = ra6w_cfg80211_sta_get(priv, i);
+		if (!sta)
+			continue;
+
+		if (sta->valid && ether_addr_equal(sta->mac_addr, mac_addr))
+			return sta;
+	}
+
+	return NULL;
+}
+
+static int _ra6w_cfg80211_del_station(struct ra6w_cfg80211_vif *vif, const u8 *mac)
+{
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+	struct ra6w_ctrl *ctrl = &priv->core->ctrl;
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cfg80211_sta *tmp = NULL;
+	int ret = 0;
+	bool all_sta = false;
+
+	if (!mac || is_broadcast_ether_addr(mac))
+		all_sta = true;
+
+	list_for_each_entry_safe(sta, tmp, &vif->ap.sta_list, list) {
+		if (all_sta || (mac && ether_addr_equal(sta->mac_addr, mac))) {
+			u8 sta_idx = sta->sta_idx;
+
+			ra6w_cfg80211_sta_free(vif, sta_idx);
+
+			ret = ra6w_ctrl_del_station_req(ctrl, sta_idx, false);
+			if (ret)
+				return ret;
+
+			vif->generation++;
+
+			if (!all_sta)
+				break;
+		}
+	}
+
+	return 0;
+}
+
+static int ra6w_cfg80211_del_station(struct wiphy *wiphy, struct net_device *ndev,
+				     struct station_del_parameters *params)
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	const u8 *mac = NULL;
+
+	if (!vif->up)
+		return -EIO;
+
+	if (params)
+		mac = params->mac;
+
+	return _ra6w_cfg80211_del_station(vif, mac);
+}
+
+static int ra6w_cfg80211_vif_assign(struct ra6w_cfg80211_priv *priv, enum nl80211_iftype type,
+				    u8 *vif_idx, u8 *addr_idx)
+{
+	struct ra6w_cmd_add_if_rsp rsp = { 0 };
+	int ret;
+	bool p2p = false;
+	unsigned long n;
+
+	switch (type) {
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_P2P_GO:
+		p2p = true;
+		break;
+	default:
+		break;
+	}
+
+	n = find_first_zero_bit(priv->addr_map, RA6W_CFG80211_VIF_MAX);
+	if (n >= RA6W_CFG80211_VIF_MAX)
+		return -EIO;
+
+	ret = ra6w_ctrl_if_add(&priv->core->ctrl, priv->addresses[n].addr, (u8)type, p2p, &rsp);
+	if (ret)
+		return ret;
+
+	*addr_idx = (u8)n;
+	*vif_idx = rsp.vif_idx;
+
+	return 0;
+}
+
+static void ra6w_cfg80211_vif_unassign(struct ra6w_cfg80211_priv *priv, u8 vif_idx, u8 addr_idx)
+{
+	struct ra6w_cfg80211_vif *vif = ra6w_cfg80211_vif_get(priv, vif_idx);
+
+	if (!vif)
+		return;
+
+	list_del(&vif->list);
+	priv->vif_table[vif_idx] = NULL;
+	clear_bit(addr_idx, priv->addr_map);
+	clear_bit(vif_idx, priv->vif_map);
+
+	ra6w_ctrl_if_remove(&priv->core->ctrl, vif_idx);
+}
+
+static int ra6w_cfg80211_vif_type_allowed(struct ra6w_cfg80211_priv *priv,
+					  enum nl80211_iftype type)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	bool mon_presents = false;
+	bool data_presents = false;
+
+	switch (type) {
+	case NL80211_IFTYPE_MONITOR:
+		mon_presents = true;
+		break;
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_P2P_GO:
+	case NL80211_IFTYPE_P2P_DEVICE:
+	case NL80211_IFTYPE_AP:
+		data_presents = true;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_UNSPECIFIED:
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	list_for_each_entry(vif, &priv->vifs, list) {
+		if (vif->type == NL80211_IFTYPE_MONITOR) {
+			mon_presents = true;
+			continue;
+		}
+
+		data_presents = true;
+	}
+
+	if (mon_presents && data_presents) {
+		wiphy_err(priv->wiphy,
+			  "Can't enable monitor and data interfaces simultaneosly\n");
+		return -EPERM;
+	}
+
+	return 0;
+}
+
+static struct net_device *ra6w_cfg80211_alloc_ndev(struct wiphy *wiphy,
+						   const char *name,
+						   unsigned char name_assign_type,
+						   u8 addr_idx,
+						   enum nl80211_iftype type,
+						   struct vif_params *params)
+{
+	struct ra6w_cfg80211_vif *vif;
+	struct net_device *ndev;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct sockaddr addr = { 0 };
+	int ret;
+
+	ndev = alloc_netdev_mqs(sizeof(*vif), name, name_assign_type,
+				ra6w_cfg80211_dev_init,
+				RA6W_CFG80211_NDEV_TXQ,
+				RA6W_CFG80211_NDEV_RXQ);
+	if (!ndev)
+		return ERR_PTR(-ENOMEM);
+
+	vif = netdev_priv(ndev);
+	ndev->ieee80211_ptr = &vif->wdev;
+	ndev->ieee80211_ptr->iftype = type;
+	SET_NETDEV_DEV(ndev, wiphy_dev(wiphy));
+	ether_addr_copy(addr.sa_data, priv->addresses[addr_idx].addr);
+	ret = eth_mac_addr(ndev, &addr);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (params)
+		ndev->ieee80211_ptr->use_4addr = params->use_4addr;
+
+	return ndev;
+}
+
+static struct wireless_dev *ra6w_cfg80211_add_iface(struct wiphy *wiphy,
+						    const char *name,
+						    unsigned char name_assign_type,
+						    enum nl80211_iftype type,
+						    struct vif_params *params)
+{
+	int ret = -EFAULT;
+	struct net_device *ndev = NULL;
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	u8 vif_idx = 0;
+	u8 addr_idx = 0;
+
+	ret = ra6w_cfg80211_vif_type_allowed(priv, type);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = ra6w_cfg80211_vif_assign(priv, type, &vif_idx, &addr_idx);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ndev = ra6w_cfg80211_alloc_ndev(wiphy, name, name_assign_type, addr_idx, type, params);
+	if (IS_ERR(ndev))
+		return ERR_PTR(-ENOMEM);
+
+	vif = netdev_priv(ndev);
+	vif->wdev.wiphy = priv->wiphy;
+	vif->priv = priv;
+	vif->ndev = ndev;
+	vif->wdev.netdev = ndev;
+	vif->wdev.iftype = type;
+	vif->up = false;
+	vif->ch_idx = RA6W_CFG80211_CH_IDX_INVALID;
+	vif->generation = 0;
+	vif->vif_idx = vif_idx;
+	set_bit(vif_idx, priv->vif_map);
+	vif->addr_idx = addr_idx;
+	set_bit(addr_idx, priv->addr_map);
+	vif->type = type;
+
+	switch (type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		INIT_LIST_HEAD(&vif->ap.sta_list);
+		memset(&vif->ap.bcn, 0, sizeof(vif->ap.bcn));
+		vif->ap.ap_isolate = 0;
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		ndev->type = ARPHRD_IEEE80211_RADIOTAP;
+		ra6w_dev_set_monitor_ops(ndev);
+		break;
+	case NL80211_IFTYPE_ADHOC:
+	case NL80211_IFTYPE_OCB:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_MESH_POINT:
+		ret = -EOPNOTSUPP;
+		goto vif_unset;
+	case NL80211_IFTYPE_UNSPECIFIED:
+		ret = -EINVAL;
+		goto vif_unset;
+	default:
+		break;
+	}
+
+	if (params)
+		vif->use_4addr = params->use_4addr;
+
+	priv->vif_table[vif_idx] = vif;
+	list_add_tail(&vif->list, &priv->vifs);
+	set_bit(vif_idx, priv->vif_map);
+
+	ret = cfg80211_register_netdevice(ndev);
+	if (ret) {
+		ra6w_err("[%s] %s not registered: %d\n", __func__, ndev->name, ret);
+		goto vif_unset;
+	}
+
+	return &vif->wdev;
+
+vif_unset:
+	ra6w_cfg80211_vif_unassign(priv, vif_idx, addr_idx);
+	free_netdev(ndev);
+
+	return ERR_PTR(ret);
+}
+
+static void ra6w_cfg80211_vif_cleanup(struct ra6w_cfg80211_vif *vif)
+{
+	struct net_device *ndev = vif->ndev;
+
+	if (ndev->reg_state == NETREG_REGISTERED)
+		unregister_netdevice(ndev);
+
+	ndev->ieee80211_ptr = NULL;
+	vif->ndev = NULL;
+}
+
+static int ra6w_cfg80211_del_iface(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(wdev->netdev);
+
+	ra6w_cfg80211_vif_cleanup(vif);
+	ra6w_cfg80211_vif_unassign(priv, vif->vif_idx, vif->addr_idx);
+
+	return 0;
+}
+
+static int ra6w_cfg80211_change_iface(struct wiphy *wiphy, struct net_device *ndev,
+				      enum nl80211_iftype type, struct vif_params *params)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	int ret;
+	u8 vif_idx;
+	u8 addr_idx;
+
+	if (vif->up)
+		return -EBUSY;
+
+	ret = ra6w_cfg80211_vif_type_allowed(priv, type);
+	if (ret)
+		return ret;
+
+	ra6w_cfg80211_vif_unassign(priv, vif->vif_idx, vif->addr_idx);
+
+	ret = ra6w_cfg80211_vif_assign(priv, type, &vif_idx, &addr_idx);
+	if (ret)
+		return ret;
+
+	vif->type = type;
+	vif->vif_idx = vif_idx;
+	vif->addr_idx = addr_idx;
+	set_bit(addr_idx, priv->addr_map);
+
+	priv->vif_table[vif->vif_idx] = vif;
+	list_add_tail(&vif->list, &priv->vifs);
+	set_bit(vif_idx, priv->vif_map);
+
+	ndev->type = ARPHRD_ETHER;
+	ra6w_dev_set_ops(ndev);
+
+	switch (type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		vif->sta.flags = 0;
+		vif->sta.ap = NULL;
+		vif->sta.tdls_sta = NULL;
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		return -EOPNOTSUPP;
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		INIT_LIST_HEAD(&vif->ap.sta_list);
+		memset(&vif->ap.bcn, 0, sizeof(vif->ap.bcn));
+		vif->ap.ap_isolate = 0;
+		break;
+	case NL80211_IFTYPE_MONITOR:
+		ndev->type = ARPHRD_IEEE80211_RADIOTAP;
+		ra6w_dev_set_monitor_ops(ndev);
+		break;
+	default:
+		break;
+	}
+
+	vif->generation = 0;
+	vif->wdev.iftype = type;
+
+	if (params->use_4addr != -1)
+		vif->use_4addr = params->use_4addr;
+
+	return 0;
+}
+
+static int ra6w_cfg80211_scan(struct wiphy *wiphy, struct cfg80211_scan_request *req)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = container_of(req->wdev, struct ra6w_cfg80211_vif, wdev);
+
+	if (!vif->up)
+		return -EIO;
+
+	if (vif->type == NL80211_IFTYPE_AP)
+		return -EOPNOTSUPP;
+
+	if (priv->scan_request)
+		return -EAGAIN;
+
+	ret = ra6w_ctrl_scan_start(&priv->core->ctrl, req);
+	if (ret)
+		return ret;
+
+	priv->scan_request = req;
+
+	return 0;
+}
+
+static void ra6w_cfg80211_scan_abort(struct wiphy *wiphy, struct wireless_dev *wdev)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = container_of(wdev, struct ra6w_cfg80211_vif, wdev);
+
+	if (!priv->scan_request)
+		return;
+
+	ra6w_ctrl_scan_cancel(&priv->core->ctrl, vif);
+}
+
+void ra6w_cfg80211_scan_done(struct ra6w_cfg80211_priv *priv)
+{
+	static struct cfg80211_scan_info scan_req = {
+		.aborted = true,
+	};
+
+	cfg80211_scan_done(priv->scan_request, &scan_req);
+	priv->scan_request = NULL;
+}
+
+static int ra6w_cfg80211_disconnect(struct wiphy *wiphy, struct net_device *ndev, u16 reason_code)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+
+	if (!vif->up)
+		return -EIO;
+
+	ra6w_stats_deinit(&vif->stats);
+
+	return ra6w_ctrl_disconnect_req(&priv->core->ctrl, vif, reason_code);
+}
+
+struct ra6w_cfg80211_vif *ra6w_cfg80211_vif_get(struct ra6w_cfg80211_priv *priv, u8 vif_idx)
+{
+	if (!priv)
+		return NULL;
+
+	if (!test_bit(vif_idx, priv->vif_map))
+		return NULL;
+
+	return priv->vif_table[vif_idx];
+}
+
+static int ra6w_cfg80211_add_key(struct wiphy *wiphy, struct net_device *ndev,
+				 int link_id, u8 key_index, bool pairwise,
+				 const u8 *mac_addr, struct key_params *params)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cfg80211_key *key = NULL;
+	struct ra6w_cmd_key_add_rsp rsp = { 0 };
+	u8 cipher_type = 0;
+	u8 *tk;
+
+	if (key_index >= RA6W_CFG80211_KEYS_MAX) {
+		ra6w_err("Invalid key index\n");
+		return -EINVAL;
+	}
+
+	if (!vif->up)
+		return -EIO;
+
+	if (mac_addr) {
+		sta = ra6w_cfg80211_find_sta(priv, mac_addr);
+		if (!sta) {
+			ra6w_err("No STA found with MAC address\n");
+			return -EINVAL;
+		}
+		key = &sta->key;
+	} else {
+		key = &vif->keys[key_index];
+	}
+
+	tk = kzalloc(params->key_len, GFP_KERNEL);
+	if (!tk)
+		return -ENOMEM;
+
+	memcpy(tk, params->key, params->key_len);
+
+	switch (params->cipher) {
+	case WLAN_CIPHER_SUITE_WEP40:
+		cipher_type = RA6W_CIPHER_WEP40;
+		break;
+	case WLAN_CIPHER_SUITE_WEP104:
+		cipher_type = RA6W_CIPHER_WEP104;
+		break;
+	case WLAN_CIPHER_SUITE_TKIP:
+		cipher_type = RA6W_CIPHER_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP:
+		cipher_type = RA6W_CIPHER_CCMP;
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		cipher_type = RA6W_CIPHER_AES_CMAC_128;
+		break;
+	case WLAN_CIPHER_SUITE_SMS4: {
+		u8 tmp;
+		int i = 0;
+
+		cipher_type = RA6W_CIPHER_SMS4;
+
+		for (i = 0; i < RA6W_CFG80211_WPI_SUBKEY_LEN / 2; i++) {
+			tmp = tk[i];
+			tk[i] = tk[RA6W_CFG80211_WPI_SUBKEY_LEN - 1 - i];
+			tk[RA6W_CFG80211_WPI_SUBKEY_LEN - 1 - i] = tmp;
+		}
+
+		for (i = 0; i < RA6W_CFG80211_WPI_SUBKEY_LEN / 2; i++) {
+			tmp = tk[i + RA6W_CFG80211_WPI_SUBKEY_LEN];
+			tk[i + RA6W_CFG80211_WPI_SUBKEY_LEN] =
+				tk[RA6W_CFG80211_WPI_KEY_LEN - 1 - i];
+			tk[RA6W_CFG80211_WPI_KEY_LEN - 1 - i] = tmp;
+		}
+		break;
+	}
+	case WLAN_CIPHER_SUITE_GCMP:
+		cipher_type = RA6W_CIPHER_GCMP_128;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+		cipher_type = RA6W_CIPHER_GCMP_256;
+		break;
+	case WLAN_CIPHER_SUITE_CCMP_256:
+		cipher_type = RA6W_CIPHER_CCMP_256;
+		break;
+	default:
+		ra6w_err("[%s] Unsupported cipher %d\n", __func__, params->cipher);
+		ret = -EINVAL;
+		goto free;
+	}
+
+	key->cipher_type = cipher_type;
+	key->pairwise = pairwise;
+	key->sta_idx = sta ? sta->sta_idx : RA6W_CFG80211_STA_IDX_INVALID;
+	key->vif_idx = vif->vif_idx;
+
+	ret = ra6w_ctrl_add_key_req(&priv->core->ctrl, key, tk, params->key_len, key_index, &rsp);
+	if (ret)
+		goto free;
+
+	key->key_index = rsp.hw_key_index;
+	memcpy(key->key, tk, params->key_len);
+	key->key_len = params->key_len;
+	memcpy(key->seq, tk, params->seq_len);
+	key->seq_len = params->seq_len;
+
+free:
+	kfree(tk);
+
+	return ret;
+}
+
+static int ra6w_cfg80211_get_key(struct wiphy *wiphy, struct net_device *ndev, int link_id,
+				 u8 key_index, bool pairwise, const u8 *mac_addr, void *cookie,
+				 void (*callback)(void *cookie, struct key_params *))
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_key *key = NULL;
+	struct key_params params;
+
+	if (!vif->up)
+		return -EIO;
+
+	if (key_index > RA6W_CFG80211_KEYS_MAX) {
+		ra6w_err("[%s] key index %d out of bounds\n", __func__, key_index);
+		return -ENOENT;
+	}
+
+	key = &vif->keys[key_index];
+	memset(&params, 0, sizeof(params));
+	params.cipher = key->cipher;
+	params.key_len = key->key_len;
+	params.seq_len = key->seq_len;
+	params.seq = key->seq;
+	params.key = key->key;
+
+	callback(cookie, &params);
+
+	return key->key_len ? 0 : -ENOENT;
+}
+
+static int ra6w_cfg80211_del_key(struct wiphy *wiphy, struct net_device *ndev, int link_id,
+				 u8 key_index, bool pairwise, const u8 *mac_addr)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cfg80211_key *key = NULL;
+
+	if (!vif->up)
+		return -EIO;
+
+	if (key_index >= RA6W_CFG80211_KEYS_MAX) {
+		ra6w_err("[%s] key index %d out of bounds\n", __func__, key_index);
+		return -EINVAL;
+	}
+
+	if (mac_addr) {
+		sta = ra6w_cfg80211_find_sta(priv, mac_addr);
+		if (!sta)
+			return -EINVAL;
+
+		key = &sta->key;
+	} else {
+		key = &vif->keys[key_index];
+	}
+
+	return ra6w_ctrl_del_key_req(&priv->core->ctrl, key->key_index);
+}
+
+static int ra6w_cfg80211_set_default_key(struct wiphy *wiphy, struct net_device *ndev,
+					 int link_id, u8 key_index, bool unicast, bool multicast)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+
+	if (!vif->up)
+		return -EIO;
+
+	return ret;
+}
+
+static int ra6w_cfg80211_connect(struct wiphy *wiphy, struct net_device *ndev,
+				 struct cfg80211_connect_params *sme)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cmd_sm_connect_rsp rsp = { 0 };
+	int ret;
+
+	if (!vif->up)
+		return -EIO;
+
+	if ((sme->crypto.cipher_group == WLAN_CIPHER_SUITE_WEP40 ||
+	     sme->crypto.cipher_group == WLAN_CIPHER_SUITE_WEP104) &&
+	    (sme->key && sme->key_len > 0)) {
+		struct key_params key_params;
+
+		key_params.key = sme->key;
+		key_params.seq = NULL;
+		key_params.key_len = sme->key_len;
+		key_params.seq_len = 0;
+		key_params.cipher = sme->crypto.cipher_group;
+		ra6w_cfg80211_add_key(wiphy, ndev, -1, sme->key_idx, false, NULL, &key_params);
+	} else if ((sme->auth_type == NL80211_AUTHTYPE_SAE) &&
+		   !(sme->flags & CONNECT_REQ_EXTERNAL_AUTH_SUPPORT)) {
+		netdev_err(ndev, "Doesn't support SAE without external authentication\n");
+		return -EINVAL;
+	}
+
+	ret = ra6w_ctrl_connect(&priv->core->ctrl, ndev, sme, &rsp);
+	if (ret == 0)
+		netif_carrier_on(ndev);
+
+	return ret;
+}
+
+static int ra6w_cfg80211_add_station(struct wiphy *wiphy, struct net_device *ndev, const u8 *mac,
+				     struct station_parameters *params)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cmd_sta_add_rsp rsp = { 0 };
+	struct ra6w_cfg80211_sta *sta = NULL;
+
+	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER))
+		return 0;
+
+	ret = ra6w_ctrl_add_station_req(&priv->core->ctrl, params, mac, vif->vif_idx, &rsp);
+	if (ret)
+		return ret;
+
+	sta = ra6w_cfg80211_sta_get(priv, rsp.sta_idx);
+	if (!sta)
+		return -EINVAL;
+
+	sta->aid = params->aid;
+	sta->sta_idx = rsp.sta_idx;
+	sta->ch_idx = vif->ch_idx;
+	sta->vif_idx = vif->vif_idx;
+	sta->qos = (params->sta_flags_set & BIT(NL80211_STA_FLAG_WME)) != 0;
+	sta->ht = params->link_sta_params.ht_capa ? 1 : 0;
+	sta->vht = params->link_sta_params.vht_capa ? 1 : 0;
+	sta->he = params->link_sta_params.he_capa ? 1 : 0;
+	sta->listen_interval = params->listen_interval;
+	ether_addr_copy(sta->mac_addr, mac);
+	list_add_tail(&sta->list, &vif->ap.sta_list);
+	vif->generation++;
+	sta->valid = true;
+
+	return 0;
+}
+
+static int ra6w_cfg80211_change_station(struct wiphy *wiphy, struct net_device *ndev,
+					const u8 *mac, struct station_parameters *params)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	bool authorized;
+
+	if (is_zero_ether_addr(mac))
+		return 0;
+
+	if (!(params->sta_flags_mask & BIT(NL80211_STA_FLAG_AUTHORIZED)))
+		return 0;
+
+	sta = ra6w_cfg80211_find_sta(priv, mac);
+	if (!sta)
+		return -EINVAL;
+
+	authorized = params->sta_flags_set & BIT(NL80211_STA_FLAG_AUTHORIZED);
+
+	return ra6w_ctrl_port_control_req(&priv->core->ctrl, authorized, sta->sta_idx);
+}
+
+static int ra6w_cfg80211_start_ap(struct wiphy *wiphy, struct net_device *ndev,
+				  struct cfg80211_ap_settings *settings)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cmd_ap_start_rsp rsp = { 0 };
+	struct ra6w_cfg80211_chan_info *chan_info = NULL;
+
+	ret = ra6w_ctrl_ap_start_req(&priv->core->ctrl, vif, settings, &rsp);
+	if (ret) {
+		ra6w_err("Failed to start AP (%d)\n", ret);
+		return ret;
+	}
+
+	vif->ap.bcmc_index = rsp.bcmc_idx;
+	vif->ap.ap_isolate = 0;
+	sta = ra6w_cfg80211_sta_get(priv, rsp.bcmc_idx);
+	if (!sta)
+		return  -EINVAL;
+
+	sta->valid = true;
+	sta->aid = 0;
+	sta->sta_idx = rsp.bcmc_idx;
+	sta->ch_idx = rsp.ch_idx;
+	sta->vif_idx = vif->vif_idx;
+	sta->qos = false;
+	sta->listen_interval = 5;
+	sta->ht = 0;
+	sta->vht = 0;
+	sta->he = 0;
+
+	ra6w_cfg80211_chaninfo_set(vif, rsp.ch_idx, &settings->chandef);
+
+	netif_carrier_on(ndev);
+
+	chan_info = &priv->chaninfo_table[vif->ch_idx];
+	ra6w_info("AP started: freq1 %u bcmc_idx %d\n",
+		  chan_info->chan_def.center_freq1, vif->ap.bcmc_index);
+
+	return 0;
+}
+
+static int ra6w_cfg80211_stop_ap(struct wiphy *wiphy, struct net_device *ndev,
+				 unsigned int link_id)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+
+	netif_carrier_off(ndev);
+	_ra6w_cfg80211_del_station(vif, NULL);
+	ret = ra6w_ctrl_ap_stop_req(&priv->core->ctrl, vif);
+	ra6w_cfg80211_chaninfo_unset(vif);
+
+	return ret;
+}
+
+static int ra6w_cfg80211_change_beacon(struct wiphy *wiphy, struct net_device *ndev,
+				       struct cfg80211_ap_update *info)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_beacon_info *bcn = NULL;
+	u8 *bcn_buf;
+
+	bcn = &vif->ap.bcn;
+
+	bcn_buf = ra6w_cfg80211_create_beacon(bcn, &info->beacon);
+	if (!bcn_buf)
+		return -ENOMEM;
+
+	ret = ra6w_ctrl_change_beacon_req(&priv->core->ctrl, vif->vif_idx,
+					  bcn_buf, bcn->len, bcn->head_len, bcn->tim_len, NULL);
+
+	kfree(bcn_buf);
+
+	return ret;
+}
+
+static
+int ra6w_cfg80211_set_monitor_channel(struct wiphy *wiphy,
+				      struct net_device *ndev,
+				      struct cfg80211_chan_def *chandef)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cmd_mon_mode_rsp rsp = { 0 };
+	const struct ra6w_cfg80211_chan_info *chan_info = NULL;
+	struct cfg80211_chan_def chandef_mon;
+
+	if (priv->mon_vif_idx == RA6W_CFG80211_VIF_IDX_INVALID)
+		return -EINVAL;
+
+	vif = priv->vif_table[priv->mon_vif_idx];
+
+	chan_info = ra6w_cfg80211_chaninfo_get(vif);
+	if (chan_info && chandef && cfg80211_chandef_identical(&chan_info->chan_def, chandef))
+		return 0;
+
+	ret = ra6w_ctrl_monitor_mode_req(&priv->core->ctrl, chandef, &rsp);
+	if (ret)
+		return -EIO;
+
+	ra6w_cfg80211_chaninfo_unset(vif);
+
+	if (rsp.chan_index == RA6W_CFG80211_CH_IDX_INVALID)
+		return 0;
+
+	if (priv->vif_started > 1) {
+		ra6w_cfg80211_chaninfo_set(vif, rsp.chan_index, NULL);
+		return -EBUSY;
+	}
+
+	memset(&chandef_mon, 0, sizeof(chandef_mon));
+	chandef_mon.chan = ieee80211_get_channel(wiphy, le16_to_cpu(rsp.chan.freq_prim20));
+	chandef_mon.center_freq1 = le16_to_cpu(rsp.chan.freq_cen1);
+	chandef_mon.center_freq2 = le16_to_cpu(rsp.chan.freq_cen2);
+	chandef_mon.width = chnl2bw[rsp.chan.ch_bw];
+	ra6w_cfg80211_chaninfo_set(vif, rsp.chan_index, &chandef_mon);
+
+	return 0;
+}
+
+static int ra6w_cfg80211_probe_client(struct wiphy *wiphy, struct net_device *ndev,
+				      const u8 *peer, u64 *cookie)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cmd_probe_client_rsp rsp = { 0 };
+
+	if (vif->type != NL80211_IFTYPE_AP &&
+	    vif->type != NL80211_IFTYPE_P2P_GO)
+		return -EINVAL;
+
+	list_for_each_entry(sta, &vif->ap.sta_list, list) {
+		if (sta->valid && ether_addr_equal(sta->mac_addr, peer))
+			break;
+	}
+
+	if (!sta)
+		return -EINVAL;
+
+	ret = ra6w_ctrl_probe_client_req(&priv->core->ctrl, vif->vif_idx, sta->sta_idx, &rsp);
+	if (ret)
+		return ret;
+
+	*cookie = (u64)le32_to_cpu(rsp.probe_id);
+
+	return 0;
+}
+
+static int ra6w_cfg80211_set_txq_params(struct wiphy *wiphy, struct net_device *ndev,
+					struct ieee80211_txq_params *params)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	u32 param;
+	u8 ac;
+	u8 aifs;
+	u8 cwmin;
+	u8 cwmax;
+
+	ac = ra6w_ac2hwq[params->ac];
+	aifs = params->aifs;
+	cwmin = (u8)fls(params->cwmin);
+	cwmax = (u8)fls(params->cwmax);
+
+	param = (u32)(aifs << 0);
+	param |= (u32)(cwmin << 4);
+	param |= (u32)(cwmax << 8);
+	param |= (u32)(params->txop << 12);
+
+	return ra6w_ctrl_edca_req(&priv->core->ctrl, ac, param, false, vif->vif_idx);
+}
+
+static int ra6w_cfg80211_set_tx_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+				      enum nl80211_tx_power_setting type, int mbm)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cfg80211_vif *tmp = NULL;
+	s8 tx_pwr = 0;
+
+	switch (type) {
+	case NL80211_TX_POWER_AUTOMATIC:
+		tx_pwr = 0x7F;
+		break;
+	case NL80211_TX_POWER_LIMITED:
+	case NL80211_TX_POWER_FIXED:
+		tx_pwr = (s8)MBM_TO_DBM(mbm);
+		break;
+	default:
+		ra6w_err("[%s] Unsupported type %d\n", __func__, type);
+		return -EINVAL;
+	}
+
+	if (wdev) {
+		vif = container_of(wdev, struct ra6w_cfg80211_vif, wdev);
+		if (!vif->up)
+			return -EIO;
+
+		goto req;
+	}
+
+	list_for_each_entry(tmp, &priv->vifs, list) {
+		if (!tmp->up)
+			continue;
+
+		vif = tmp;
+		break;
+	}
+
+req:
+	if (!vif)
+		return -EIO;
+
+	return ra6w_ctrl_set_tx_power_req(&priv->core->ctrl, vif->vif_idx, tx_pwr);
+}
+
+static int ra6w_cfg80211_set_power_mgmt(struct wiphy *wiphy, struct net_device *ndev,
+					bool enabled, int timeout)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	u8 ps_mode;
+
+	if (!vif->up)
+		return -EIO;
+
+	if (!ra6w_params_ps_supported())
+		return -EOPNOTSUPP;
+
+	ps_mode = enabled ? RA6W_CFG80211_PS_MODE_ON_DYN : RA6W_CFG80211_PS_MODE_OFF;
+
+	return ra6w_ctrl_set_power_mgmt_req(&priv->core->ctrl, ps_mode);
+}
+
+static int ra6w_cfg80211_get_station(struct wiphy *wiphy, struct net_device *ndev,
+				     const u8 *mac, struct station_info *sinfo)
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+
+	if (!vif->up)
+		return -EIO;
+
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		return -EINVAL;
+
+	sta = ra6w_cfg80211_find_sta(vif->priv, mac);
+	if (!sta)
+		return -ENOENT;
+
+	return ra6w_cfg80211_station_info_fill(sta, sinfo, vif);
+}
+
+static int ra6w_cfg80211_dump_station(struct wiphy *wiphy, struct net_device *ndev, int idx,
+				      u8 *mac, struct station_info *sinfo)
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cfg80211_sta *tmp = NULL;
+	int i = 0;
+
+	if (!vif)
+		return -ENOENT;
+
+	if (vif->type == NL80211_IFTYPE_MONITOR)
+		return -EINVAL;
+
+	if ((vif->type == NL80211_IFTYPE_STATION ||
+	     vif->type == NL80211_IFTYPE_P2P_CLIENT) &&
+	    !idx && vif->sta.ap && vif->sta.ap->valid) {
+		sta = vif->sta.ap;
+		goto fill;
+	}
+
+	list_for_each_entry(tmp, &vif->ap.sta_list, list) {
+		if (i == idx) {
+			sta = tmp;
+			break;
+		}
+
+		i++;
+	}
+
+fill:
+	if (!sta)
+		return -ENOENT;
+
+	ether_addr_copy(mac, (const u8 *)&sta->mac_addr);
+
+	return ra6w_cfg80211_station_info_fill(sta, sinfo, vif);
+}
+
+static int ra6w_cfg80211_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+					   struct ieee80211_channel *chan,
+					   unsigned int duration, u64 *cookie)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(wdev->netdev);
+	struct ra6w_cfg80211_remain_on_channel *roc = NULL;
+
+	if (!priv || !vif)
+		return -EIO;
+
+	if (priv->roc)
+		return -EBUSY;
+
+	roc = kzalloc(sizeof(*roc), GFP_KERNEL);
+	if (!roc)
+		return -ENOMEM;
+
+	roc->vif = vif;
+	roc->chan = chan;
+	roc->duration = duration;
+	roc->internal = false;
+	roc->on_chan = false;
+	roc->tx_cnt = 0;
+	memset(roc->tx_cookie, 0, sizeof(roc->tx_cookie));
+
+	priv->roc = roc;
+	ret = ra6w_ctrl_remain_on_channel_req(&priv->core->ctrl, vif, chan, duration);
+	if (ret) {
+		kfree(roc);
+		priv->roc = NULL;
+
+		return ret;
+	}
+
+	if (cookie)
+		*cookie = (u64)roc;
+
+	return ret;
+}
+
+static int ra6w_cfg80211_cancel_remain_on_channel(struct wiphy *wiphy,
+						  struct wireless_dev *wdev, u64 cookie)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+
+	if (!priv->roc)
+		return 0;
+
+	if (cookie != (u64)priv->roc)
+		return -EINVAL;
+
+	return ra6w_ctrl_cancel_remain_on_channel_req(&priv->core->ctrl);
+}
+
+static int ra6w_cfg80211_channel_switch(struct wiphy *wiphy, struct net_device *ndev,
+					struct cfg80211_csa_settings *params)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_beacon_info *bcn;
+	struct ra6w_cfg80211_beacon_info *bcn_after;
+	struct ra6w_cfg80211_csa_info *csa;
+	u16 csa_oft[RA6W_CMD_BCN_MAX_CSA_CPT];
+	u8 *bcn_buf;
+	const u8 *bcn_after_buf;
+	int i;
+
+	if (vif->ap.csa)
+		return -EBUSY;
+
+	if (params->n_counter_offsets_beacon > RA6W_CMD_BCN_MAX_CSA_CPT)
+		return -EINVAL;
+
+	bcn = &vif->ap.bcn;
+	bcn_buf = ra6w_cfg80211_create_beacon(bcn, &params->beacon_csa);
+	if (!bcn_buf)
+		return -ENOMEM;
+
+	memset(csa_oft, 0, sizeof(csa_oft));
+	for (i = 0; i < params->n_counter_offsets_beacon; i++)
+		csa_oft[i] = params->counter_offsets_beacon[i] + bcn->head_len + bcn->tim_len;
+
+	if (params->count == 0) {
+		params->count = 2;
+		for (i = 0; i < params->n_counter_offsets_beacon; i++)
+			bcn_buf[csa_oft[i]] = 2;
+	}
+
+	csa = kzalloc(sizeof(*csa), GFP_KERNEL);
+	if (!csa) {
+		ret = -ENOMEM;
+		goto free_bcn_buf;
+	}
+
+	bcn_after = &csa->bcn;
+	bcn_after_buf = ra6w_cfg80211_create_beacon(bcn_after, &params->beacon_after);
+	if (!bcn_after_buf) {
+		ret = -ENOMEM;
+		goto free_csa;
+	}
+
+	vif->ap.csa = csa;
+	csa->vif = vif;
+	csa->chandef = params->chandef;
+	memcpy(csa->buf, bcn_after_buf, bcn_after->len);
+	kfree(bcn_after_buf);
+
+	/* Send new Beacon. FW will extract channel and count from the beacon */
+	ret = ra6w_ctrl_change_beacon_req(&priv->core->ctrl, vif->vif_idx, bcn_buf, bcn->len,
+					  bcn->head_len, bcn->tim_len, csa_oft);
+	if (ret)
+		goto free_csa;
+
+	INIT_WORK(&csa->work, ra6w_cfg80211_csa_work);
+	cfg80211_ch_switch_started_notify(ndev, &csa->chandef, params->link_id,
+					  params->count, params->block_tx);
+
+	kfree(bcn_buf);
+
+	return ret;
+
+free_csa:
+	ra6w_cfg80211_csa_remove(vif);
+
+free_bcn_buf:
+	kfree(bcn_buf);
+
+	return ret;
+}
+
+static int ra6w_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev, int idx,
+				     struct survey_info *info)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	const struct ra6w_cfg80211_survey_info *survey_info = NULL;
+	struct ieee80211_supported_band *sband;
+
+	if (idx >= ARRAY_SIZE(priv->survey_table))
+		return -ENONET;
+
+	survey_info = &priv->survey_table[idx];
+
+	sband = wiphy->bands[NL80211_BAND_2GHZ];
+	if (!sband)
+		return -ENOENT;
+
+	if (idx >= sband->n_channels) {
+		idx -= sband->n_channels;
+		sband = NULL;
+	}
+
+	if (!sband) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+
+		if (!sband || idx >= sband->n_channels)
+			return -ENOENT;
+	}
+
+	info->channel = &sband->channels[idx];
+	info->filled = survey_info->filled;
+
+	if (info->filled) {
+		info->time = (u64)survey_info->chan_dwell_ms;
+		info->time_busy = (u64)survey_info->chan_busy_ms;
+		info->noise = survey_info->chan_noise_dbm;
+	}
+
+	return 0;
+}
+
+static int ra6w_cfg80211_get_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+				     unsigned int link_id,
+				     struct cfg80211_chan_def *chandef)
+{
+	struct ra6w_cfg80211_vif *vif = container_of(wdev, struct ra6w_cfg80211_vif, wdev);
+	const struct ra6w_cfg80211_chan_info *chan_info = NULL;
+
+	if (!vif->up)
+		return -ENODATA;
+
+	chan_info = ra6w_cfg80211_chaninfo_get(vif);
+	if (!chan_info)
+		return -ENODATA;
+
+	*chandef = chan_info->chan_def;
+
+	return 0;
+}
+
+static int ra6w_cfg80211_mgmt_tx_cancel_wait(struct wiphy *wiphy, struct wireless_dev *wdev,
+					     u64 cookie)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	int n_tx_cookie = 0;
+	int i;
+
+	if (!priv->roc || !priv->roc->tx_cnt)
+		return 0;
+
+	for (i = 0; i < RA6W_CFG80211_ROC_TX; i++) {
+		n_tx_cookie++;
+
+		if (priv->roc->tx_cookie[i] == cookie) {
+			priv->roc->tx_cookie[i] = 0;
+			priv->roc->tx_cnt--;
+			break;
+		}
+	}
+
+	if (i == RA6W_CFG80211_ROC_TX) {
+		if (n_tx_cookie != priv->roc->tx_cnt)
+			priv->roc->tx_cnt--;
+		else
+			return 0;
+	}
+
+	if (!priv->roc->internal || priv->roc->tx_cnt > 0)
+		return 0;
+
+	return ra6w_cfg80211_cancel_remain_on_channel(wiphy, wdev, (u64)priv->roc);
+}
+
+static int ra6w_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy, struct net_device *ndev,
+					     s32 rssi_thold, u32 rssi_hyst)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_ctrl *ctrl = &priv->core->ctrl;
+	const struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+
+	return ra6w_ctrl_cqm_rssi_config_req(ctrl, vif->vif_idx, rssi_thold, rssi_hyst);
+}
+
+static int ra6w_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *ndev,
+				    struct bss_parameters *params)
+{
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_ctrl *ctrl = &priv->core->ctrl;
+	struct ra6w_cmd_ap_isolate_rsp rsp;
+
+	if (params->ap_isolate < 0)
+		return -EINVAL;
+
+	vif->ap.ap_isolate = params->ap_isolate;
+
+	return ra6w_ctrl_set_ap_isolate_req(ctrl, vif->ap.ap_isolate, &rsp);
+}
+
+static void ra6w_cfg80211_ht_set(struct ieee80211_sta_ht_cap *ht_cap)
+{
+	int i;
+	int nss;
+
+	ht_cap->ht_supported = ra6w_params_ht_supported();
+	if (!ht_cap->ht_supported)
+		return;
+
+	if (ra6w_params_stbc_enabled())
+		ht_cap->cap |= 1 << IEEE80211_HT_CAP_RX_STBC_SHIFT;
+
+	if (ra6w_params_ldpc_enabled())
+		ht_cap->cap |= IEEE80211_HT_CAP_LDPC_CODING;
+
+	nss = ra6w_params_nss();
+	ht_cap->mcs.rx_highest = cpu_to_le16(65 * nss);
+
+	if (nss > 1)
+		ht_cap->cap |= IEEE80211_HT_CAP_TX_STBC;
+
+	ht_cap->ampdu_factor = IEEE80211_HT_MAX_AMPDU_64K;
+	ht_cap->ampdu_density = IEEE80211_HT_MPDU_DENSITY_16;
+
+	if (ra6w_params_rx_amsdu_size())
+		ht_cap->cap |= IEEE80211_HT_CAP_MAX_AMSDU;
+
+	ht_cap->mcs.rx_mask[0] = 0xff;
+	ht_cap->mcs.rx_highest = cpu_to_le16(65);
+	ht_cap->mcs.tx_params = IEEE80211_HT_MCS_TX_DEFINED;
+
+	if (ra6w_params_use_sgi()) {
+		ht_cap->cap |= IEEE80211_HT_CAP_SGI_20;
+		ht_cap->mcs.rx_highest = cpu_to_le16(72 * nss);
+	}
+
+	for (i = 0; i < nss; i++)
+		ht_cap->mcs.rx_mask[i] = 0xFF;
+}
+
+static void ra6w_cfg80211_vht_set(struct ieee80211_sta_vht_cap *vht_cap)
+{
+	u8 nss;
+	u32 mcs_map;
+	u32 mcs_map_max_2ss_rx = IEEE80211_VHT_MCS_SUPPORT_0_9;
+	int mcs_map_max_2ss_tx = IEEE80211_VHT_MCS_SUPPORT_0_9;
+	u32 i;
+
+	vht_cap->vht_supported = ra6w_params_vht_supported();
+	if (!vht_cap->vht_supported)
+		return;
+
+	vht_cap->cap = 7 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT;
+
+	if (ra6w_params_stbc_enabled())
+		vht_cap->cap |= IEEE80211_VHT_CAP_RXSTBC_1;
+
+	if (ra6w_params_ldpc_enabled())
+		vht_cap->cap |= IEEE80211_VHT_CAP_RXLDPC;
+
+	if (ra6w_params_bfmee_enabled()) {
+		vht_cap->cap |= IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE;
+		vht_cap->cap |= 3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT;
+	}
+
+	nss = ra6w_params_nss();
+	if (nss > 1)
+		vht_cap->cap |= IEEE80211_VHT_CAP_TXSTBC;
+
+	vht_cap->cap |= ra6w_params_rx_amsdu_size();
+
+	if (ra6w_params_bfmer_enabled()) {
+		vht_cap->cap |= IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE;
+		vht_cap->cap |= (nss - 1) << IEEE80211_VHT_CAP_SOUNDING_DIMENSIONS_SHIFT;
+	}
+
+	if (ra6w_params_mu_mimo_rx_enabled())
+		vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE;
+
+	if (ra6w_params_mu_mimo_tx_enabled())
+		vht_cap->cap |= IEEE80211_VHT_CAP_MU_BEAMFORMER_CAPABLE;
+
+	mcs_map = ra6w_params_mcs_map_range();
+	vht_cap->vht_mcs.rx_mcs_map = cpu_to_le16(0);
+
+	for (i = 0; i < nss; i++) {
+		vht_cap->vht_mcs.rx_mcs_map |= cpu_to_le16(mcs_map << (i * 2));
+		vht_cap->vht_mcs.rx_highest = cpu_to_le16(ra6w_mcs_map_to_rate[mcs_map] * nss);
+		mcs_map = min_t(int, mcs_map, mcs_map_max_2ss_rx);
+	}
+
+	for (; i < 8; i++)
+		vht_cap->vht_mcs.rx_mcs_map |=
+			cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2));
+
+	mcs_map = ra6w_params_mcs_map_range();
+	vht_cap->vht_mcs.tx_mcs_map = cpu_to_le16(0);
+
+	for (i = 0; i < nss; i++) {
+		vht_cap->vht_mcs.tx_mcs_map |= cpu_to_le16(mcs_map << (i * 2));
+		vht_cap->vht_mcs.tx_highest = cpu_to_le16(ra6w_mcs_map_to_rate[mcs_map] * nss);
+		mcs_map = min_t(int, mcs_map, mcs_map_max_2ss_tx);
+	}
+
+	for (; i < 8; i++)
+		vht_cap->vht_mcs.tx_mcs_map |=
+			cpu_to_le16(IEEE80211_VHT_MCS_NOT_SUPPORTED << (i * 2));
+
+	vht_cap->cap &= ~IEEE80211_VHT_CAP_SHORT_GI_80;
+}
+
+static void ra6w_cfg80211_threshold_set(struct ieee80211_sta_he_cap *he_cap)
+{
+	const u8 PPE_THRES_INFO_OFT = 7;
+	const u8 PPE_THRES_INFO_BIT_LEN = 6;
+	struct ppe_thres_info_tag {
+		u8 ppet16 : 3;
+		u8 ppet8 : 3;
+	} __packed;
+
+	struct ppe_thres_field_tag {
+		u8 nsts : 3;
+		u8 ru_idx_bmp : 4;
+	};
+
+	struct ppe_thres_field_tag *ppe_thres_field;
+	struct ppe_thres_info_tag ppe_thres_info = {
+		.ppet16 = 0, // BPSK
+		.ppet8 = 7 // None
+	};
+
+	const u8 *ppe_thres_info_ptr = (u8 *)&ppe_thres_info;
+	u16 *ppe_thres_ptr = (u16 *)he_cap->ppe_thres;
+	u8 i;
+	u8 offset;
+	u8 nss;
+
+	ppe_thres_field = (struct ppe_thres_field_tag *)he_cap->ppe_thres;
+
+	ppe_thres_field->ru_idx_bmp = 1;
+
+	nss = ra6w_params_nss();
+	ppe_thres_field->nsts = nss - 1;
+	for (i = 0; i < nss; i++) {
+		offset = i * PPE_THRES_INFO_BIT_LEN + PPE_THRES_INFO_OFT;
+		ppe_thres_ptr = (u16 *)&he_cap->ppe_thres[offset / 8];
+		*ppe_thres_ptr |= *ppe_thres_info_ptr << (offset % 8);
+	}
+}
+
+static void ra6w_cfg80211_he_set(struct ra6w_cfg80211_priv *priv,
+				 struct ieee80211_sband_iftype_data *ifdata)
+{
+	int i;
+	u8 nss;
+	struct ieee80211_sta_he_cap *he_cap = &ifdata->he_cap;
+	int mcs_map;
+	int mcs_map_max_2ss = IEEE80211_HE_MCS_SUPPORT_0_11;
+	u8 dcm_max_ru = IEEE80211_HE_PHY_CAP8_DCM_MAX_RU_242;
+	u32 phy_vers = le32_to_cpu(priv->core->sinfo.fw_ver.phy_version);
+	__le16 unsup_for_ss = 0;
+
+	he_cap->has_he = ra6w_params_he_supported();
+	if (!he_cap->has_he)
+		return;
+
+	if (ra6w_params_twt_enabled()) {
+		priv->ext_capa[9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT;
+		he_cap->he_cap_elem.mac_cap_info[0] |= IEEE80211_HE_MAC_CAP0_TWT_REQ;
+	}
+
+	he_cap->he_cap_elem.mac_cap_info[2] |= IEEE80211_HE_MAC_CAP2_ALL_ACK;
+
+	ra6w_cfg80211_threshold_set(he_cap);
+
+	if (ra6w_params_ldpc_enabled())
+		he_cap->he_cap_elem.phy_cap_info[1] |= IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD;
+
+	he_cap->he_cap_elem.phy_cap_info[1] |=
+		IEEE80211_HE_PHY_CAP1_HE_LTF_AND_GI_FOR_HE_PPDUS_0_8US |
+		IEEE80211_HE_PHY_CAP1_MIDAMBLE_RX_TX_MAX_NSTS;
+	he_cap->he_cap_elem.phy_cap_info[2] |= IEEE80211_HE_PHY_CAP2_MIDAMBLE_RX_TX_MAX_NSTS |
+		IEEE80211_HE_PHY_CAP2_NDP_4x_LTF_AND_3_2US |
+		IEEE80211_HE_PHY_CAP2_DOPPLER_RX;
+
+	if (ra6w_params_stbc_enabled())
+		he_cap->he_cap_elem.phy_cap_info[2] |= IEEE80211_HE_PHY_CAP2_STBC_RX_UNDER_80MHZ;
+
+	he_cap->he_cap_elem.phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_16_QAM |
+					       IEEE80211_HE_PHY_CAP3_RX_PARTIAL_BW_SU_IN_20MHZ_MU;
+
+	nss = ra6w_params_nss();
+	if (nss > 0)
+		he_cap->he_cap_elem.phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_2;
+	else
+		he_cap->he_cap_elem.phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_DCM_MAX_RX_NSS_1;
+
+	if (ra6w_params_bfmee_enabled()) {
+		he_cap->he_cap_elem.phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE;
+		he_cap->he_cap_elem.phy_cap_info[4] |=
+			IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_4;
+	}
+
+	he_cap->he_cap_elem.phy_cap_info[5] |= IEEE80211_HE_PHY_CAP5_NG16_SU_FEEDBACK |
+		IEEE80211_HE_PHY_CAP5_NG16_MU_FEEDBACK;
+	he_cap->he_cap_elem.phy_cap_info[6] |=
+		IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_42_SU |
+		IEEE80211_HE_PHY_CAP6_CODEBOOK_SIZE_75_MU |
+		IEEE80211_HE_PHY_CAP6_TRIG_SU_BEAMFORMING_FB |
+		IEEE80211_HE_PHY_CAP6_TRIG_MU_BEAMFORMING_PARTIAL_BW_FB |
+		IEEE80211_HE_PHY_CAP6_PPE_THRESHOLD_PRESENT |
+		IEEE80211_HE_PHY_CAP6_PARTIAL_BANDWIDTH_DL_MUMIMO;
+	he_cap->he_cap_elem.phy_cap_info[7] |=
+		 IEEE80211_HE_PHY_CAP7_HE_SU_MU_PPDU_4XLTF_AND_08_US_GI;
+	he_cap->he_cap_elem.phy_cap_info[8] |= IEEE80211_HE_PHY_CAP8_20MHZ_IN_40MHZ_HE_PPDU_IN_2G |
+					       dcm_max_ru;
+	he_cap->he_cap_elem.phy_cap_info[9] |=
+		IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_COMP_SIGB |
+		IEEE80211_HE_PHY_CAP9_RX_FULL_BW_SU_USING_MU_WITH_NON_COMP_SIGB |
+		IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
+
+	/* Starting from version v31 more HE_ER_SU modulations is supported */
+	if (RA6W_PHY_VERSION(phy_vers) > 30) {
+		he_cap->he_cap_elem.phy_cap_info[6] |= IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE;
+		he_cap->he_cap_elem.phy_cap_info[8] |=
+			IEEE80211_HE_PHY_CAP8_HE_ER_SU_1XLTF_AND_08_US_GI |
+			IEEE80211_HE_PHY_CAP8_HE_ER_SU_PPDU_4XLTF_AND_08_US_GI;
+	}
+
+	mcs_map = ra6w_params_he_mcs_map_range();
+	memset(&he_cap->he_mcs_nss_supp, 0, sizeof(he_cap->he_mcs_nss_supp));
+	for (i = 0; i < nss; i++) {
+		unsup_for_ss = cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+		he_cap->he_mcs_nss_supp.rx_mcs_80 |= cpu_to_le16(mcs_map << (i * 2));
+		he_cap->he_mcs_nss_supp.rx_mcs_160 |= unsup_for_ss;
+		he_cap->he_mcs_nss_supp.rx_mcs_80p80 |= unsup_for_ss;
+		mcs_map = min_t(int, ra6w_params_he_mcs_map_range(), mcs_map_max_2ss);
+	}
+
+	for (; i < 8; i++) {
+		unsup_for_ss = cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+		he_cap->he_mcs_nss_supp.rx_mcs_80 |= unsup_for_ss;
+		he_cap->he_mcs_nss_supp.rx_mcs_160 |= unsup_for_ss;
+		he_cap->he_mcs_nss_supp.rx_mcs_80p80 |= unsup_for_ss;
+	}
+
+	mcs_map = ra6w_params_he_mcs_map_range();
+	for (i = 0; i < nss; i++) {
+		unsup_for_ss = cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+		he_cap->he_mcs_nss_supp.tx_mcs_80 |= cpu_to_le16(mcs_map << (i * 2));
+		he_cap->he_mcs_nss_supp.tx_mcs_160 |= unsup_for_ss;
+		he_cap->he_mcs_nss_supp.tx_mcs_80p80 |= unsup_for_ss;
+		mcs_map = min_t(int, ra6w_params_he_mcs_map_range(), mcs_map_max_2ss);
+	}
+
+	for (; i < 8; i++) {
+		unsup_for_ss = cpu_to_le16(IEEE80211_HE_MCS_NOT_SUPPORTED << (i * 2));
+		he_cap->he_mcs_nss_supp.tx_mcs_80 |= unsup_for_ss;
+		he_cap->he_mcs_nss_supp.tx_mcs_160 |= unsup_for_ss;
+		he_cap->he_mcs_nss_supp.tx_mcs_80p80 |= unsup_for_ss;
+	}
+}
+
+static int ra6w_cfg80211_set_default_wiphy(struct ra6w_cfg80211_priv *priv, struct wiphy *wiphy)
+{
+	const u8 *mac_addr = priv->core->sinfo.default_mac;
+	int i;
+
+	ether_addr_copy(wiphy->perm_addr, mac_addr);
+	for (i = 0; i < RA6W_CFG80211_VIF_MAX; i++) {
+		ether_addr_copy(priv->addresses[i].addr, mac_addr);
+		priv->addresses[i].addr[5] ^= i;
+	}
+
+	wiphy->addresses = priv->addresses;
+	wiphy->n_addresses = RA6W_CFG80211_VIF_MAX;
+
+	bitmap_zero(priv->addr_map, RA6W_CFG80211_VIF_MAX);
+
+	wiphy->mgmt_stypes = ra6w_macm_stypes;
+
+	ra6w_cfg80211_ht_set(&ra6w_band_2g.ht_cap);
+	if (ra6w_params_he_supported()) {
+		ra6w_cfg80211_he_set(priv, &ra6w_cap_he_2g);
+		ra6w_band_2g.iftype_data = &ra6w_cap_he_2g;
+	}
+
+	wiphy->bands[NL80211_BAND_2GHZ] = &ra6w_band_2g;
+
+	ra6w_cfg80211_ht_set(&ra6w_band_5g.ht_cap);
+	ra6w_cfg80211_vht_set(&ra6w_band_5g.vht_cap);
+	if (ra6w_params_he_supported()) {
+		ra6w_cfg80211_he_set(priv, &ra6w_cap_he_5g);
+		ra6w_band_5g.iftype_data = &ra6w_cap_he_5g;
+	}
+
+	wiphy->bands[NL80211_BAND_5GHZ] = &ra6w_band_5g;
+
+	wiphy->interface_modes = BIT(NL80211_IFTYPE_STATION) |
+		BIT(NL80211_IFTYPE_AP) |
+		BIT(NL80211_IFTYPE_P2P_CLIENT) |
+		BIT(NL80211_IFTYPE_P2P_GO) |
+		BIT(NL80211_IFTYPE_MONITOR);
+	wiphy->flags |= WIPHY_FLAG_HAS_REMAIN_ON_CHANNEL |
+		WIPHY_FLAG_HAS_CHANNEL_SWITCH |
+		WIPHY_FLAG_4ADDR_STATION |
+		WIPHY_FLAG_4ADDR_AP |
+		WIPHY_FLAG_REPORTS_OBSS |
+		WIPHY_FLAG_OFFCHAN_TX;
+
+	wiphy->max_scan_ssids = RA6W_CMD_SCAN_SSID_MAX;
+	wiphy->max_scan_ie_len = RA6W_CMD_SCAN_MAX_IE_LEN;
+
+	wiphy->support_mbssid = 1;
+
+	wiphy->max_num_csa_counters = RA6W_CMD_BCN_MAX_CSA_CPT;
+	wiphy->max_remain_on_channel_duration = 5000;
+
+	wiphy->features |= NL80211_FEATURE_NEED_OBSS_SCAN |
+		NL80211_FEATURE_SK_TX_STATUS |
+		NL80211_FEATURE_VIF_TXPOWER |
+		NL80211_FEATURE_ACTIVE_MONITOR |
+		NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
+		NL80211_FEATURE_SAE;
+
+	wiphy->iface_combinations = ra6w_if_comb;
+	wiphy->n_iface_combinations = ARRAY_SIZE(ra6w_if_comb) - 1;
+
+	if (ra6w_params_regd_mode_is_auto())
+		wiphy->reg_notifier = ra6w_cfg80211_reg_notifier;
+	else
+		wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
+
+	wiphy->signal_type = CFG80211_SIGNAL_TYPE_MBM;
+
+	wiphy->extended_capabilities = priv->ext_capa;
+	wiphy->extended_capabilities_mask = priv->ext_capa;
+	wiphy->extended_capabilities_len = ARRAY_SIZE(priv->ext_capa);
+
+	wiphy->cipher_suites = ra6w_cipher_suites;
+	wiphy->n_cipher_suites =
+		ARRAY_SIZE(ra6w_cipher_suites) - RA6W_CFG80211_RESERVED_CIPHER_NUM;
+
+	if (ra6w_params_wapi_supported())
+		ra6w_cipher_suites[wiphy->n_cipher_suites++] = WLAN_CIPHER_SUITE_SMS4;
+
+	if (ra6w_params_mfp_supported())
+		ra6w_cipher_suites[wiphy->n_cipher_suites++] = WLAN_CIPHER_SUITE_AES_CMAC;
+
+	if (ra6w_params_ccmp256_supported())
+		ra6w_cipher_suites[wiphy->n_cipher_suites++] = WLAN_CIPHER_SUITE_CCMP_256;
+
+	if (ra6w_params_gcmp_supported()) {
+		ra6w_cipher_suites[wiphy->n_cipher_suites++] = WLAN_CIPHER_SUITE_GCMP;
+		ra6w_cipher_suites[wiphy->n_cipher_suites++] = WLAN_CIPHER_SUITE_GCMP_256;
+	}
+
+	if (ra6w_params_tdls_supported()) {
+		wiphy->flags |= WIPHY_FLAG_SUPPORTS_TDLS;
+		wiphy->features |= NL80211_FEATURE_TDLS_CHANNEL_SWITCH;
+		wiphy->flags |= WIPHY_FLAG_TDLS_EXTERNAL_SETUP;
+	}
+
+	if (ra6w_params_ap_uapsd_enabled())
+		wiphy->flags |= WIPHY_FLAG_AP_UAPSD;
+
+	if (ra6w_params_ps_supported())
+		wiphy->flags |= WIPHY_FLAG_PS_ON_BY_DEFAULT;
+
+	strscpy(wiphy->fw_version, priv->core->sinfo.fw_version, sizeof(wiphy->fw_version));
+
+	return 0;
+}
+
+static void ra6w_cfg80211_vif_del_all(struct ra6w_cfg80211_priv *priv)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cfg80211_vif *tmp_vif = NULL;
+
+	rtnl_lock();
+
+	list_for_each_entry_safe(vif, tmp_vif, &priv->vifs, list) {
+		ra6w_cfg80211_vif_cleanup(vif);
+		ra6w_cfg80211_vif_unassign(priv, vif->vif_idx, vif->addr_idx);
+	}
+
+	rtnl_unlock();
+}
+
+void ra6w_cfg80211_chaninfo_set(struct ra6w_cfg80211_vif *vif, u8 ch_idx,
+				const struct cfg80211_chan_def *chandef)
+{
+	struct ra6w_cfg80211_chan_info *chan_info = NULL;
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+
+	if (ch_idx >= RA6W_CFG80211_CHANINFO_MAX) {
+		ra6w_err("Invalid channel idx %d\n", ch_idx);
+		return;
+	}
+
+	vif->ch_idx = ch_idx;
+	chan_info = &priv->chaninfo_table[ch_idx];
+
+	/* For now chandef is NULL for STATION interface */
+	if (chandef && !chan_info->chan_def.chan) {
+		chan_info->chan_def = *chandef;
+		chan_info->count++;
+	}
+}
+
+void ra6w_cfg80211_chaninfo_unset(struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_cfg80211_chan_info *chan_info = NULL;
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+
+	if (vif->ch_idx == RA6W_CFG80211_CH_IDX_INVALID)
+		return;
+
+	chan_info = &priv->chaninfo_table[vif->ch_idx];
+
+	if (chan_info->count == 0)
+		ra6w_dbg("Chan info ref count is already 0\n");
+	else
+		chan_info->count--;
+
+	if (chan_info->count == 0)
+		chan_info->chan_def.chan = NULL;
+
+	vif->ch_idx = RA6W_CFG80211_CH_IDX_INVALID;
+}
+
+static
+struct ra6w_cfg80211_sta *ra6w_cfg80211_get_sta_from_fc(struct ra6w_cfg80211_priv *priv,
+							struct ra6w_cfg80211_vif *vif,
+							const u8 *addr, __le16 fc, bool ap)
+{
+	bool bufferable;
+	struct ra6w_cfg80211_sta *sta = NULL;
+
+	if (!ap) {
+		if (vif->sta.ap && vif->sta.ap->valid &&
+		    ether_addr_equal(vif->sta.ap->mac_addr, addr))
+			return vif->sta.ap;
+
+		return NULL;
+	}
+
+	bufferable = ieee80211_is_deauth(fc) ||
+		     ieee80211_is_disassoc(fc) ||
+		     ieee80211_is_action(fc);
+
+	if (!bufferable)
+		return NULL;
+
+	if (is_broadcast_ether_addr(addr) || is_multicast_ether_addr(addr)) {
+		sta = ra6w_cfg80211_sta_get(priv, vif->ap.bcmc_index);
+		if (!sta || !sta->valid)
+			return NULL;
+
+		return sta;
+	}
+
+	list_for_each_entry(sta, &vif->ap.sta_list, list) {
+		if (sta->valid && ether_addr_equal(sta->mac_addr, addr))
+			return sta;
+	}
+
+	return NULL;
+}
+
+static int ra6w_cfg80211_offchan_proc(struct wiphy *wiphy, struct wireless_dev *wdev,
+				      struct ra6w_cfg80211_priv *priv,
+				      const struct ra6w_cfg80211_vif *vif,
+				      struct cfg80211_mgmt_tx_params *params)
+{
+	struct ieee80211_channel *chan = params->chan;
+	int ret;
+	unsigned int duration = 30;
+
+	if (!chan)
+		return -EINVAL;
+
+	/* Offchannel transmission, need to start a RoC */
+	if (priv->roc) {
+		/* Test if current RoC can be re-used */
+		if (priv->roc->vif != vif || priv->roc->chan->center_freq != chan->center_freq)
+			return -EINVAL;
+
+		return 0;
+	}
+
+	/* Start a new ROC procedure */
+	if (params->wait)
+		duration = params->wait;
+
+	ret = ra6w_cfg80211_remain_on_channel(wiphy, wdev, chan, duration, NULL);
+	if (ret)
+		return ret;
+
+	/* Internal RoC, no need to inform user space about it */
+	priv->roc->internal = true;
+
+	return 0;
+}
+
+static int ra6w_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
+				 struct cfg80211_mgmt_tx_params *params, u64 *cookie)
+{
+	int ret = 0;
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_cfg80211_vif *vif = container_of(wdev, struct ra6w_cfg80211_vif, wdev);
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_tx *tx = &priv->core->tx;
+	const struct ieee80211_mgmt *mgmt = (const struct ieee80211_mgmt *)params->buf;
+	bool ap = false;
+	bool offchan = false;
+	const u8 *da;
+	__le16 fc;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		ap = true;
+
+		if (!(ieee80211_is_assoc_resp(mgmt->frame_control) ||
+		      ieee80211_is_auth(mgmt->frame_control)))
+			break;
+
+		cfg80211_mgmt_tx_status(wdev, *cookie, params->buf, params->len, true, GFP_ATOMIC);
+
+		break;
+	default:
+		break;
+	}
+
+	da = mgmt->da;
+	fc = mgmt->frame_control;
+	sta = ra6w_cfg80211_get_sta_from_fc(priv, vif, da, fc, ap);
+
+	if (params->offchan) {
+		const struct ra6w_cfg80211_chan_info *chan_info = ra6w_cfg80211_chaninfo_get(vif);
+
+		if (!chan_info)
+			return -EINVAL;
+
+		offchan = chan_info->chan_def.chan->center_freq == params->chan->center_freq;
+
+		ret = ra6w_cfg80211_offchan_proc(wiphy, wdev, priv, vif, params);
+		if (ret)
+			return ret;
+	}
+
+	ret = ra6w_tx_mgmt(tx, vif, sta, params, cookie);
+	if (offchan) {
+		if (priv->roc->tx_cnt < RA6W_CFG80211_ROC_TX)
+			priv->roc->tx_cookie[priv->roc->tx_cnt] = *cookie;
+		else
+			ra6w_warn("[%s] %d frames sent within the same Roc (> RA6W_NET_ROC_TX)",
+				  __func__, priv->roc->tx_cnt + 1);
+		priv->roc->tx_cnt++;
+	}
+
+	return ret;
+}
+
+static int ra6w_cfg80211_external_auth(struct wiphy *wiphy, struct net_device *ndev,
+				       struct cfg80211_external_auth_params *params)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct ra6w_ctrl *ctrl = &priv->core->ctrl;
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+
+	if (!(vif->sta.flags & RA6W_CMD_STA_AUTH_EXT_BIT))
+		return -EINVAL;
+
+	vif->sta.flags &= ~RA6W_CMD_STA_AUTH_EXT_BIT;
+
+	return ra6w_ctrl_sm_ext_auth_req_rsp(ctrl, vif->vif_idx, params->status);
+}
+
+static struct cfg80211_ops ra6w_cfg80211_ops = {
+	.add_virtual_intf = ra6w_cfg80211_add_iface,
+	.del_virtual_intf = ra6w_cfg80211_del_iface,
+	.change_virtual_intf = ra6w_cfg80211_change_iface,
+	.scan = ra6w_cfg80211_scan,
+	.abort_scan = ra6w_cfg80211_scan_abort,
+	.connect = ra6w_cfg80211_connect,
+	.disconnect = ra6w_cfg80211_disconnect,
+	.add_key = ra6w_cfg80211_add_key,
+	.get_key = ra6w_cfg80211_get_key,
+	.del_key = ra6w_cfg80211_del_key,
+	.set_default_key = ra6w_cfg80211_set_default_key,
+	.add_station = ra6w_cfg80211_add_station,
+	.del_station = ra6w_cfg80211_del_station,
+	.change_station = ra6w_cfg80211_change_station,
+	.mgmt_tx = ra6w_cfg80211_mgmt_tx,
+	.mgmt_tx_cancel_wait = ra6w_cfg80211_mgmt_tx_cancel_wait,
+	.start_ap = ra6w_cfg80211_start_ap,
+	.change_beacon = ra6w_cfg80211_change_beacon,
+	.stop_ap = ra6w_cfg80211_stop_ap,
+	.set_monitor_channel = ra6w_cfg80211_set_monitor_channel,
+	.probe_client = ra6w_cfg80211_probe_client,
+	.set_txq_params = ra6w_cfg80211_set_txq_params,
+	.set_tx_power = ra6w_cfg80211_set_tx_power,
+	.set_power_mgmt = ra6w_cfg80211_set_power_mgmt,
+	.get_station = ra6w_cfg80211_get_station,
+	.dump_station = ra6w_cfg80211_dump_station,
+	.remain_on_channel = ra6w_cfg80211_remain_on_channel,
+	.cancel_remain_on_channel = ra6w_cfg80211_cancel_remain_on_channel,
+	.channel_switch = ra6w_cfg80211_channel_switch,
+	.dump_survey = ra6w_cfg80211_dump_survey,
+	.get_channel = ra6w_cfg80211_get_channel,
+	.set_cqm_rssi_config = ra6w_cfg80211_set_cqm_rssi_config,
+	.change_bss = ra6w_cfg80211_change_bss,
+	CFG80211_TESTMODE_CMD(ra6w_testmode_cmd)
+	.external_auth = ra6w_cfg80211_external_auth,
+};
+
+static int ra6w_cfg80211_register(struct ra6w_core *core, struct device *dev)
+{
+	int ret;
+	struct wiphy *wiphy = NULL;
+	struct ra6w_cfg80211_priv *priv = NULL;
+
+	wiphy = wiphy_new(&ra6w_cfg80211_ops, sizeof(*priv));
+	if (!wiphy) {
+		ra6w_err("Failed to create new wiphy\n");
+		return -ENOENT;
+	}
+
+	priv = wiphy_priv(wiphy);
+	priv->core = core;
+
+	set_wiphy_dev(wiphy, dev);
+	priv->wiphy = wiphy;
+	core->priv = priv;
+
+	priv->vif_started = 0;
+	priv->mon_vif_idx = RA6W_CFG80211_VIF_IDX_INVALID;
+
+	bitmap_zero(priv->vif_map, RA6W_CFG80211_VIF_MAX);
+
+	INIT_LIST_HEAD(&priv->vifs);
+
+	priv->roc = NULL;
+
+	priv->ext_capa[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING;
+	priv->ext_capa[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
+	priv->ext_capa[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF |
+			    WLAN_EXT_CAPA8_MAX_MSDU_IN_AMSDU_LSB;
+	priv->ext_capa[8] = WLAN_EXT_CAPA9_MAX_MSDU_IN_AMSDU_MSB;
+
+	ret = ra6w_cfg80211_set_default_wiphy(priv, wiphy);
+	if (ret)
+		goto free_wiphy;
+
+	ret = ra6w_ctrl_me_config(&priv->core->ctrl, wiphy);
+	if (ret)
+		goto free_wiphy;
+
+	ret = wiphy_register(wiphy);
+	if (ret) {
+		ra6w_err("register wiphy device failed: %d\n", ret);
+		goto free_wiphy;
+	}
+
+	ret = ra6w_params_regd_set_self(wiphy);
+	if (ret)
+		goto free_wiphy;
+
+	ra6w_dbgfs_register(priv);
+
+	ret = ra6w_ctrl_dev_start(&priv->core->ctrl, &priv->phy_config);
+	if (ret)
+		goto free_wiphy;
+
+	return 0;
+
+free_wiphy:
+	wiphy_free(wiphy);
+	priv->wiphy = NULL;
+	core->priv = NULL;
+
+	return ret;
+}
+
+void ra6w_cfg80211_deinit(struct ra6w_core *core)
+{
+	struct ra6w_cfg80211_priv *priv = NULL;
+	struct wiphy *wiphy = NULL;
+
+	if (!core)
+		return;
+
+	priv = core->priv;
+	if (!priv)
+		return;
+
+	ra6w_cfg80211_vif_del_all(priv);
+
+	ra6w_dbgfs_deregister(priv);
+
+	wiphy = priv->wiphy;
+	if (wiphy) {
+		wiphy_unregister(wiphy);
+		wiphy_free(wiphy);
+	}
+
+	priv->wiphy = NULL;
+	core->priv = NULL;
+}
+
+int ra6w_cfg80211_init(struct ra6w_core *core, struct device *dev)
+{
+	int ret;
+	struct wireless_dev *wdev = NULL;
+
+	ret = ra6w_cfg80211_register(core, dev);
+	if (ret)
+		return ret;
+
+	rtnl_lock();
+	wdev = ra6w_cfg80211_add_iface(core->priv->wiphy, "wlan%d", NET_NAME_UNKNOWN,
+				       NL80211_IFTYPE_STATION, NULL);
+	rtnl_unlock();
+	if (!wdev) {
+		ra6w_info("Failed to instantiate a network device\n");
+		ret = -ENOENT;
+		goto cfg80211_deinit;
+	}
+
+	ra6w_info("New interface created %s\n", wdev->netdev->name);
+
+	return 0;
+
+cfg80211_deinit:
+	ra6w_cfg80211_deinit(core);
+
+	return ret;
+}
-- 
2.17.1


