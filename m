Return-Path: <linux-wireless+bounces-21657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185D3A91ED4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 557915A8073
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC34124EA9C;
	Thu, 17 Apr 2025 13:54:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6F24EABC
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898041; cv=none; b=kHfY3c60kfSyEH53j1yKRkhfDI1ZytPc9p86HOY6PcTnm/oD7Q3gUlgG2hjyN0goTsNMoirspluZydNsN9Db60F3kBr3CMk4f/aTUUHs7tSZx8YNr43wIPRezBw1hDOc2XSouTZHa/STcDeu2tzOaniYmZGWKdEzBZ9OOOSWxIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898041; c=relaxed/simple;
	bh=BkDoe8XVR2ejyHRZmyDrvnnk9LAxn8o5UiglRFSQYxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=QP3MtSWCkUeFVpiNfdq77L8z19LDidxz9wTaoLOIB5fLYAPD1T6lAQE/blFLMs/Ha1XEVm2fona0rgcP+TcxKk2dzkVckECKcZSH/8ddGZxWWb+VRL5Czkci0AN7vSWRGrNwFFML463PjVs6fEixWisf0lfo0TC6C+65JW76naY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: Vk00mgHURQekxaQ5sXq5Qg==
X-CSE-MsgGUID: poQOgpHHQTiIDrV4lJ5pew==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:58 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0FDED4006DE8;
	Thu, 17 Apr 2025 22:53:54 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 17/38] ra6w: add indi.c
Date: Thu, 17 Apr 2025 16:52:15 +0300
Message-Id: <20250417135236.52410-18-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/indi.c | 581 +++++++++++++++++++++++
 1 file changed, 581 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/indi.c

diff --git a/drivers/net/wireless/renesas/ra6w/indi.c b/drivers/net/wireless/renesas/ra6w/indi.c
new file mode 100644
index 000000000000..b31e588c3e48
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/indi.c
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains asynchronous fw routine.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include "core.h"
+#include "cfg80211.h"
+#include "dev.h"
+#include "params.h"
+#include "dbg.h"
+#include "indi.h"
+
+#define RA6W_INDI_THREAD_NAME	"ra6w_indi_thread"
+
+static int ra6w_indi_freq_to_idx(const struct ra6w_cfg80211_priv *priv, u16 freq, u16 *idx_res)
+{
+	const struct ieee80211_supported_band *sband;
+	u16 ch;
+	u16 band;
+	u16 idx = 0;
+	int ret = -ENOENT;
+
+	for (band = NL80211_BAND_2GHZ; band < NUM_NL80211_BANDS; band++) {
+		sband = priv->wiphy->bands[band];
+		if (!sband)
+			continue;
+
+		for (ch = 0; ch < sband->n_channels; ch++, idx++) {
+			if (sband->channels[ch].center_freq != freq)
+				continue;
+
+			*idx_res = idx;
+			ret = 0;
+
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static void ra6w_indi_channel_survey(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_survey_info *survey = NULL;
+	const struct ra6w_cmd_sc_survey_info *ind = data;
+	u16 idx = 0;
+	int ret;
+
+	ret = ra6w_indi_freq_to_idx(priv, le16_to_cpu(ind->freq), &idx);
+	if (ret)
+		return;
+
+	survey = &priv->survey_table[idx];
+
+	survey->chan_dwell_ms = le32_to_cpu(ind->chan_dwell_ms);
+	survey->filled |= SURVEY_INFO_TIME;
+	survey->chan_busy_ms = le32_to_cpu(ind->chan_busy_ms);
+	survey->filled |= SURVEY_INFO_TIME_BUSY;
+
+	if (ind->chan_noise_dbm) {
+		survey->chan_noise_dbm = ind->chan_noise_dbm;
+		survey->filled |= SURVEY_INFO_NOISE_DBM;
+	}
+}
+
+static void ra6w_indi_scan_result(struct ra6w_cfg80211_priv *priv, void *data)
+{
+	struct cfg80211_bss *bss = NULL;
+	struct ieee80211_channel *chan = NULL;
+	struct ra6w_cmd_sc_result_ind *ind = data;
+
+	chan = ieee80211_get_channel(priv->wiphy, le16_to_cpu(ind->center_freq));
+	if (!chan)
+		return;
+
+	/*
+	 * Since we are using CFG80211_SIGNAL_TYPE_MBM signal_type,
+	 * we have to multiply rssi by 100
+	 */
+	bss = cfg80211_inform_bss_frame(priv->wiphy, chan,
+					(struct ieee80211_mgmt *)ind->payload,
+					le16_to_cpu(ind->length), (s32)ind->rssi * 100,
+					GFP_ATOMIC);
+	if (!bss)
+		return;
+
+	cfg80211_put_bss(priv->wiphy, bss);
+}
+
+static void ra6w_indi_scan_complete(struct ra6w_cfg80211_priv *priv)
+{
+	struct cfg80211_scan_info info = {
+		.aborted = false,
+	};
+
+	if (!priv->scan_request)
+		return;
+
+	cfg80211_scan_done(priv->scan_request, &info);
+	priv->scan_request = NULL;
+}
+
+static void ra6w_indi_sm_connect(struct ra6w_cfg80211_priv *priv, void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct net_device *ndev = NULL;
+	struct ra6w_cmd_sm_connect_ind *ind = data;
+	const u8 *req_ie;
+	const u8 *rsp_ie;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	ndev = vif->ndev;
+	if (!ndev)
+		return;
+
+	if (ind->conn_status == 0) {
+		struct ra6w_cfg80211_sta *sta = ra6w_cfg80211_sta_get(priv, ind->ap_idx);
+		struct ieee80211_channel *chan;
+		struct cfg80211_chan_def chandef;
+
+		sta->valid = true;
+		sta->sta_idx = ind->ap_idx;
+		sta->ch_idx = ind->ch_idx;
+		sta->vif_idx = ind->vif_idx;
+		sta->qos = ind->flag_qos;
+		sta->aid = le16_to_cpu(ind->assoc_id);
+		sta->band = ind->oper_chan.ch_band;
+		sta->width = ind->oper_chan.ch_bw;
+		sta->center_freq = le16_to_cpu(ind->oper_chan.freq_prim20);
+		sta->center_freq1 = le16_to_cpu(ind->oper_chan.freq_cen1);
+		sta->center_freq2 = le16_to_cpu(ind->oper_chan.freq_cen2);
+		vif->sta.ap = sta;
+		vif->generation++;
+		chan = ieee80211_get_channel(priv->wiphy, le16_to_cpu(ind->oper_chan.freq_prim20));
+		cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
+		if (!ra6w_params_ht_supported())
+			chandef.width = NL80211_CHAN_WIDTH_20_NOHT;
+		else
+			chandef.width = chnl2bw[ind->oper_chan.ch_bw];
+		chandef.center_freq1 = le16_to_cpu(ind->oper_chan.freq_cen1);
+		chandef.center_freq2 = le16_to_cpu(ind->oper_chan.freq_cen2);
+		ra6w_cfg80211_chaninfo_set(vif, ind->ch_idx, &chandef);
+		ether_addr_copy(sta->mac_addr, (u8 *)&ind->bssid.addr);
+	}
+
+	req_ie = (const u8 *)ind->assoc_ie_buf;
+	rsp_ie = req_ie + le16_to_cpu(ind->assoc_req_ie_len);
+
+	cfg80211_connect_result(ndev, (const u8 *)ind->bssid.addr,
+				req_ie, le16_to_cpu(ind->assoc_req_ie_len),
+				rsp_ie, le16_to_cpu(ind->assoc_rsp_ie_len),
+				le16_to_cpu(ind->conn_status), GFP_ATOMIC);
+}
+
+static const char *ra6w_indi_reason_to_str(int reason_code)
+{
+	switch (reason_code) {
+	case RA6W_INDI_DIS_RSN_BEACON_MISS: return "BEACON_MISS";
+	case RA6W_INDI_DIS_RSN_PS_TX_MAX_ERR: return "PS_TX_MAX_ERR";
+	case RA6W_INDI_DIS_RSN_CHAN_SWITCH_FAIL: return "CHAN_SWITCH_FAIL";
+	default: return "UNKNOWN";
+	}
+}
+
+static void ra6w_indi_sm_disconnect(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	const struct ra6w_cmd_sm_disconnect_ind *ind = data;
+	struct net_device *ndev = NULL;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	ndev = vif->ndev;
+
+	if (!ind->reassoc) {
+		u16 reason_code = le16_to_cpu(ind->reason_code);
+		bool locally_generated = false;
+
+		if (reason_code > RA6W_INDI_DIS_RSN_MIN &&
+		    reason_code < RA6W_INDI_DIS_RSN_MAX) {
+			ra6w_info("[%s] disconnect reason is %s\n",
+				  __func__, ra6w_indi_reason_to_str(reason_code));
+			reason_code = WLAN_REASON_UNSPECIFIED;
+			locally_generated = true;
+		}
+
+		ra6w_stats_deinit(&vif->stats);
+
+		cfg80211_disconnected(ndev, reason_code, NULL, 0, locally_generated, GFP_ATOMIC);
+	}
+
+	netif_carrier_off(ndev);
+
+	if (vif->sta.ap)
+		ra6w_cfg80211_sta_free(vif, vif->sta.ap->sta_idx);
+
+	vif->generation++;
+
+	ra6w_cfg80211_chaninfo_unset(vif);
+}
+
+static void ra6w_indi_me_mic_failure(struct ra6w_cfg80211_priv *priv, void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct net_device *ndev = NULL;
+	struct ra6w_cmd_me_mic_failure_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	ndev = vif->ndev;
+	if (!ndev)
+		return;
+
+	cfg80211_michael_mic_failure(ndev, (u8 *)&ind->mac_addr,
+				     (ind->group ? NL80211_KEYTYPE_GROUP :
+				      NL80211_KEYTYPE_PAIRWISE),
+				     ind->keyid, (u8 *)&ind->tsc, GFP_ATOMIC);
+}
+
+static void ra6w_indi_twt_setup(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_sta *sta = NULL;
+	const struct ra6w_cfg80211_twt_setup_ind *ind = data;
+
+	sta = ra6w_cfg80211_sta_get(priv, ind->sta_idx);
+	if (!sta)
+		return;
+
+	memcpy(&sta->twt_ind, ind, sizeof(*ind));
+}
+
+static void ra6w_indi_rssi_status(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct net_device *ndev = NULL;
+	const struct ra6w_cmd_rssi_status_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	ndev = vif->ndev;
+	if (!ndev)
+		return;
+
+	cfg80211_cqm_rssi_notify(ndev, (ind->rssi_status ? NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW :
+					NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH),
+				 ind->rssi, GFP_ATOMIC);
+}
+
+static void ra6w_indi_sm_ext_auth_req(struct ra6w_cfg80211_priv *priv, void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct cfg80211_external_auth_params params;
+	struct ra6w_cmd_sm_ext_auth_req_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	params.action = NL80211_EXTERNAL_AUTH_START;
+	ether_addr_copy(params.bssid, (u8 *)&ind->bssid.addr);
+	params.ssid.ssid_len = ind->ssid.ssid_len;
+	memcpy(params.ssid.ssid, ind->ssid.ssid,
+	       min_t(size_t, ind->ssid.ssid_len, sizeof(params.ssid.ssid)));
+	params.key_mgmt_suite = le32_to_cpu(ind->key_mgmt_suite);
+
+	if (vif->type != NL80211_IFTYPE_STATION ||
+	    cfg80211_external_auth_request(vif->ndev, &params, GFP_ATOMIC)) {
+		struct ra6w_ctrl *ctrl = &priv->core->ctrl;
+
+		wiphy_err(priv->wiphy, "Failed to start external auth on vif %d", ind->vif_idx);
+		ra6w_ctrl_sm_ext_auth_req_rsp(ctrl, ind->vif_idx, WLAN_STATUS_UNSPECIFIED_FAILURE);
+
+		return;
+	}
+
+	vif->sta.flags |= RA6W_CMD_STA_AUTH_EXT_BIT;
+}
+
+static void ra6w_indi_rx_chan_switch(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	const struct ra6w_cmd_channel_switch_ind *ind = data;
+
+	if (ind->roc_tdls) {
+		u8 vif_idx = ind->vif_idx;
+
+		list_for_each_entry(vif, &priv->vifs, list) {
+			if (vif->vif_idx == vif_idx)
+				vif->roc_tdls = true;
+		}
+	} else if (ind->roc_req) {
+		struct ra6w_cfg80211_remain_on_channel *roc = priv->roc;
+
+		if (!roc)
+			return;
+
+		vif = roc->vif;
+		if (!vif)
+			return;
+
+		if (!roc->internal)
+			cfg80211_ready_on_channel(&vif->wdev, (u64)(roc), roc->chan,
+						  roc->duration, GFP_ATOMIC);
+
+		roc->on_chan = true;
+	}
+
+	priv->chaninfo_index = ind->chan_index;
+}
+
+static void ra6w_indi_ap_probe_client(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cfg80211_sta *sta = NULL;
+	const struct ra6w_cmd_ap_probe_client_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	sta = ra6w_cfg80211_sta_get(priv, ind->sta_idx);
+	if (!sta)
+		return;
+
+	sta->stats.last_acttive_time = jiffies;
+	cfg80211_probe_status(vif->ndev, sta->mac_addr, (u64)le32_to_cpu(ind->probe_id),
+			      ind->client_present, 0, false, GFP_ATOMIC);
+}
+
+static void ra6w_indi_roc_exp(struct ra6w_cfg80211_priv *priv)
+{
+	struct ra6w_cfg80211_remain_on_channel *roc = NULL;
+	struct ra6w_cfg80211_vif *vif = NULL;
+
+	roc = priv->roc;
+	if (!roc)
+		return;
+
+	vif = roc->vif;
+	if (!vif)
+		return;
+
+	if (!roc->internal && roc->on_chan)
+		cfg80211_remain_on_channel_expired(&vif->wdev, (u64)(roc), roc->chan, GFP_ATOMIC);
+
+	kfree(roc);
+	priv->roc = NULL;
+}
+
+static void ra6w_indi_pktloss_notify(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	const struct ra6w_cmd_pktloss_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	cfg80211_cqm_pktloss_notify(vif->ndev, (const u8 *)ind->mac_addr.addr,
+				    le32_to_cpu(ind->num_packets), GFP_ATOMIC);
+}
+
+static void ra6w_indi_csa_counter(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	const struct ra6w_cmd_csa_counter_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	if (!vif->ap.csa) {
+		netdev_err(vif->ndev, "CSA counter update but no active CSA");
+		return;
+	}
+
+	vif->ap.csa->count = ind->csa_count;
+}
+
+static void ra6w_indi_csa_finish(struct ra6w_cfg80211_priv *priv, const void *data)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	const struct ra6w_cmd_csa_finish_ind *ind = data;
+
+	vif = ra6w_cfg80211_vif_get(priv, ind->vif_idx);
+	if (!vif || !vif->up)
+		return;
+
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_P2P_GO) {
+		if (!vif->ap.csa) {
+			netdev_err(vif->ndev, "CSA finish indication but no active CSA");
+			return;
+		}
+
+		vif->ap.csa->status = ind->status;
+		vif->ap.csa->ch_idx = ind->chan_idx;
+		schedule_work(&vif->ap.csa->work);
+
+		return;
+	}
+
+	if (ind->status == 0) {
+		ra6w_cfg80211_chaninfo_unset(vif);
+		ra6w_cfg80211_chaninfo_set(vif, ind->chan_idx, NULL);
+	}
+}
+
+static void ra6w_indi_rx(struct ra6w_indi *indi, struct sk_buff *skb)
+{
+	struct ra6w_core *core = container_of(indi, struct ra6w_core, indi);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_indi_buf *indi_data = (struct ra6w_indi_buf *)skb->data;
+
+	if (!priv || !indi_data || indi_data->data_len == 0)
+		return;
+
+	switch (indi_data->cmd) {
+	case RA6W_CMD_ME_TKIP_MIC_FAILURE_IND:
+		ra6w_indi_me_mic_failure(priv, indi_data->data);
+		break;
+	case RA6W_CMD_SC_RESULT_IND:
+		ra6w_indi_scan_result(priv, indi_data->data);
+		break;
+	case RA6W_CMD_SC_COMPLETE_IND:
+		ra6w_indi_scan_complete(priv);
+		break;
+	case RA6W_CMD_SC_CHANNEL_SURVEY_IND:
+		ra6w_indi_channel_survey(priv, indi_data->data);
+		break;
+	case RA6W_CMD_SM_CONNECT_IND:
+		ra6w_indi_sm_connect(priv, indi_data->data);
+		break;
+	case RA6W_CMD_SM_DISCONNECT_IND:
+		ra6w_indi_sm_disconnect(priv, indi_data->data);
+		break;
+	case RA6W_CMD_SM_EXTERNAL_AUTH_REQUIRED_IND:
+		ra6w_indi_sm_ext_auth_req(priv, indi_data->data);
+		break;
+	case RA6W_CMD_TWT_SETUP_IND:
+		ra6w_indi_twt_setup(priv, indi_data->data);
+		break;
+	case RA6W_CMD_AM_PROBE_CLIENT_IND:
+		ra6w_indi_ap_probe_client(priv, indi_data->data);
+		break;
+	case RA6W_CMD_MM_CHANNEL_SWITCH_IND:
+		ra6w_indi_rx_chan_switch(priv, indi_data->data);
+		break;
+	case RA6W_CMD_MM_CHANNEL_PRE_SWITCH_IND:
+		break;
+	case RA6W_CMD_MM_REMAIN_ON_CHANNEL_EXP_IND:
+		ra6w_indi_roc_exp(priv);
+		break;
+	case RA6W_CMD_MM_PS_CHANGE_IND:
+		break;
+	case RA6W_CMD_MM_TRAFFIC_REQ_IND:
+		break;
+	case RA6W_CMD_MM_RSSI_STATUS_IND:
+		ra6w_indi_rssi_status(priv, indi_data->data);
+		break;
+	case RA6W_CMD_MM_CSA_COUNTER_IND:
+		ra6w_indi_csa_counter(priv, indi_data->data);
+		break;
+	case RA6W_CMD_MM_CSA_FINISH_IND:
+		ra6w_indi_csa_finish(priv, indi_data->data);
+		break;
+	case RA6W_CMD_MM_CSA_TRAFFIC_IND:
+		break;
+	case RA6W_CMD_MM_PACKET_LOSS_IND:
+		ra6w_indi_pktloss_notify(priv, indi_data->data);
+		break;
+	case RA6W_CMD_DBG_ERROR_IND:
+		ra6w_recovery_event_post(&core->recovery);
+		break;
+	default:
+		ra6w_err("[%s] unknown indi cmd[%d]\n", __func__, indi_data->cmd);
+		break;
+	}
+}
+
+static void ra6w_indi_worker(struct ra6w_indi *indi)
+{
+	struct sk_buff *skb = NULL;
+
+	while (!kthread_should_stop() &&
+	       (skb = ra6w_q_pop(&indi->q))) {
+		ra6w_indi_rx(indi, skb);
+		dev_kfree_skb(skb);
+	}
+}
+
+static int indi_thread_handler(void *arg)
+{
+	struct ra6w_indi *indi = arg;
+	int event = 0;
+
+	do {
+		event = ra6w_q_wait(&indi->event, RA6W_INDI_EVENT_MASK);
+		if (event & BIT(RA6W_INDI_EVENT))
+			ra6w_indi_worker(indi);
+
+		if (event & BIT(RA6W_INDI_EVENT_RESET))
+			break;
+
+		atomic_set(&indi->event.condition, 0);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+static int _ra6w_indi_init(struct ra6w_indi *indi, size_t indi_buf_num)
+{
+	int ret;
+
+	if (indi_buf_num == 0) {
+		ra6w_err("[%s] indication queue size must be greater then zero\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = ra6w_q_init(&indi->q, indi_buf_num, sizeof(struct ra6w_indi_buf *));
+	if (ret)
+		return ret;
+
+	atomic_set(&indi->event.condition, 0);
+	init_waitqueue_head(&indi->event.wait_queue);
+
+	indi->task = kthread_run(indi_thread_handler, indi, RA6W_INDI_THREAD_NAME);
+	if (!indi->task) {
+		ra6w_err("[%s] kthread_run %s failed\n", __func__, RA6W_INDI_THREAD_NAME);
+		goto indi_buf_free;
+	}
+
+	return 0;
+
+indi_buf_free:
+	ra6w_q_deinit(&indi->q);
+
+	return ret;
+}
+
+int ra6w_indi_init(struct ra6w_indi *indi)
+{
+	return _ra6w_indi_init(indi, RA6W_INDI_BUF_Q_MAX);
+}
+
+void ra6w_indi_deinit(struct ra6w_indi *indi)
+{
+	if (indi->task) {
+		atomic_set(&indi->event.condition, BIT(RA6W_INDI_EVENT_RESET));
+		kthread_stop(indi->task);
+	}
+
+	ra6w_q_deinit(&indi->q);
+}
+
+int ra6w_indi_event_post(struct ra6w_indi *indi, struct sk_buff *skb)
+{
+	struct ra6w_core *core = container_of(indi, struct ra6w_core, indi);
+	struct ra6w_indi_buf *indi_data = (struct ra6w_indi_buf *)skb->data;
+	int ret;
+
+	if (indi_data->ext_len == RA6W_INDI_EXT_LEN)
+		ra6w_status_set(&core->status, indi_data->ext_hdr.status);
+
+	ret = ra6w_q_push(&indi->q, skb);
+	if (!ret || !ra6w_q_empty(&indi->q))
+		ra6w_q_event_set(&indi->event, BIT(RA6W_INDI_EVENT));
+
+	return ret;
+}
-- 
2.17.1


