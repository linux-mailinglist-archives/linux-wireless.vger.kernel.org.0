Return-Path: <linux-wireless+bounces-8733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CD69017B5
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50BA41C209B0
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891047D3F1;
	Sun,  9 Jun 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VThoP2pT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61F76F1B;
	Sun,  9 Jun 2024 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957383; cv=none; b=dpPw9fvlMjQOBj5mJAiIKrccp1K+XL2kwdyG9K/i9uHfPOdOCE7SRZ5KNWozhF52w4c6ORzOcl2JvOG3ws72FmnUZXUDyHEpigZAxeP57zMlBtmOT4oiUXOFUL3QD6ioyisCXXxMaFH1KCaFKIHi/HxDkpRiQSJ+uC3kSa4XwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957383; c=relaxed/simple;
	bh=2u7Lb82cUdtwsf2YhwcR6icWXZ3KM0tayUYYi6w/EtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3GonMCYt+ov97uHF9iQto+GymXqzvCKMHwqVVS2oqIsgdfdtb9LLkeAi2AXBn9NxzUnifgScx6oxC4X3BMTWmICiSfM2YBv42ndk/wqTnuaauD8ynwIDQU5eBgya6bS0fHlfp31ImFsha21iXjrbLfVv5enX8oP5OKRGG2z9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VThoP2pT; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMmUk074359;
	Sun, 9 Jun 2024 13:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957368;
	bh=ghtfBFd78oij9ASmCooUsYMI9QRmQG03qcOJ8mDHQik=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=VThoP2pTlCzm9U2n1YLp8xtK9bMzpieXiRtS9Ls2Fltrox7l9jdvrHBDBp6unjAeN
	 CJrDrnYMIPlRdS0OPt9qMDh5liToW+XRCSoE3bgh7ug7FFHl/lZXHT0cfwaxlVxb09
	 GmlGYF6UN/DLpKv23gmhFU0PcAOJVsVTKy+c8IUQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMm5b035532
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:48 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:48 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:48 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMlmd034721;
	Sun, 9 Jun 2024 13:22:48 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>
Subject: [PATCH v2 12/17] wifi: cc33xx: Add scan.c, scan.h
Date: Sun, 9 Jun 2024 21:20:57 +0300
Message-ID: <20240609182102.2950457-13-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

Handles the scan process.
Scan starts via cc33xx_op_hw_scan (main.c) which calls cc33xx_scan.
Scan channels are packed and sent to HW where scanning is managed by
FW concurrently to other roles without driver intervention.
Scan results are handled like normal management frames
and are sent to MAC80211. HW notifies driver of scan completion via
dedicated event which triggers a call to cc33xx_scan_completed.
---
 drivers/net/wireless/ti/cc33xx/scan.c | 754 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/scan.h | 364 +++++++++++++
 2 files changed, 1118 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/scan.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/scan.h

diff --git a/drivers/net/wireless/ti/cc33xx/scan.c b/drivers/net/wireless/ti/cc33xx/scan.c
new file mode 100644
index 000000000000..28f89b0cbea0
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/scan.c
@@ -0,0 +1,754 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "cc33xx.h"
+#include "debug.h"
+#include "cmd.h"
+#include "scan.h"
+#include "tx.h"
+#include "conf.h"
+
+static void cc33xx_adjust_channels(struct scan_param *scan_param,
+				   struct cc33xx_scan_channels *cmd_channels,
+				   enum scan_request_type scan_type)
+{
+	struct conn_scan_ch_info	*ch_info_list;
+	struct conn_scan_dwell_info	*dwell_info;
+	struct conn_scan_ch_params	*channel;
+	struct conn_scan_ch_params	*ch_params_list;
+
+	u8 *passive;
+	u8 *dfs;
+	u8 *active;
+	int i, j;
+	u8 band;
+
+	if (scan_type == SCAN_REQUEST_CONNECT_PERIODIC_SCAN) {
+		ch_info_list	= scan_param->u.periodic.channel_list;
+		dwell_info	= scan_param->u.periodic.dwell_info;
+		active		= (u8 *)&scan_param->u.periodic.active;
+		passive		= (u8 *)&scan_param->u.periodic.passive;
+		dfs		= (u8 *)&scan_param->u.periodic.dfs;
+	} else {
+		ch_info_list	= scan_param->u.one_shot.channel_list;
+		dwell_info	= scan_param->u.one_shot.dwell_info;
+		active		= (u8 *)&scan_param->u.one_shot.active;
+		passive		= (u8 *)&scan_param->u.one_shot.passive;
+		dfs		= (u8 *)&scan_param->u.one_shot.dfs;
+	}
+
+	memcpy(passive, cmd_channels->passive, sizeof(cmd_channels->passive));
+	memcpy(active, cmd_channels->active, sizeof(cmd_channels->active));
+	*dfs = cmd_channels->dfs;
+
+	ch_params_list = cmd_channels->channels_2;
+	for (i = 0; i < MAX_CHANNELS_2GHZ; ++i) {
+		ch_info_list[i].channel	= ch_params_list[i].channel;
+		ch_info_list[i].flags = ch_params_list[i].flags;
+		ch_info_list[i].tx_power_att = ch_params_list[i].tx_power_att;
+	}
+
+	channel = &ch_params_list[0];
+	band = NL80211_BAND_2GHZ;
+	dwell_info[band].min_duration     = channel->min_duration;
+	dwell_info[band].max_duration     = channel->max_duration;
+	dwell_info[band].passive_duration = channel->passive_duration;
+
+	ch_params_list = cmd_channels->channels_5;
+	for (j = 0; j < MAX_CHANNELS_5GHZ; ++i, ++j) {
+		ch_info_list[i].channel = ch_params_list[j].channel;
+		ch_info_list[i].flags = ch_params_list[j].flags;
+		ch_info_list[i].tx_power_att = ch_params_list[j].tx_power_att;
+	}
+
+	channel = &ch_params_list[0];
+	band = NL80211_BAND_5GHZ;
+	dwell_info[band].min_duration     = channel->min_duration;
+	dwell_info[band].max_duration     = channel->max_duration;
+	dwell_info[band].passive_duration = channel->passive_duration;
+}
+
+static int cc33xx_cmd_build_probe_req(struct cc33xx *cc,
+				      struct cc33xx_vif *wlvif, u8 role_id,
+				      u8 scan_type, const u8 *ssid,
+				      size_t ssid_len, const u8 *ie0,
+				      size_t ie0_len, const u8 *ie1,
+				      size_t ie1_len, bool sched_scan)
+{
+	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
+	struct sk_buff *skb = NULL;
+	struct cc33xx_cmd_set_ies *cmd;
+	int ret;
+
+	cc33xx_debug(DEBUG_SCAN, "build probe request scan_type %d", scan_type);
+
+	cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	skb = ieee80211_probereq_get(cc->hw, vif->addr, ssid,
+				     ssid_len, ie0_len + ie1_len);
+	if (!skb) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	if (ie0_len)
+		skb_put_data(skb, ie0, ie0_len);
+
+	if (ie1_len)
+		skb_put_data(skb, ie1, ie1_len);
+
+	cmd->scan_type = scan_type;
+	cmd->role_id = role_id;
+
+	cmd->len = cpu_to_le16(skb->len - sizeof(struct ieee80211_hdr_3addr));
+
+	if (skb->data) {
+		memcpy(cmd->data,
+		       skb->data + sizeof(struct ieee80211_hdr_3addr), le16_to_cpu(cmd->len));
+	}
+
+	usleep_range(10000, 11000);
+	ret = cc33xx_cmd_send(cc, CMD_SET_PROBE_IE, cmd, sizeof(*cmd), 0);
+
+	if (ret < 0) {
+		cc33xx_warning("cmd set_template failed: %d", ret);
+		goto out_free;
+	}
+
+out_free:
+	dev_kfree_skb(skb);
+	kfree(cmd);
+out:
+	return ret;
+}
+
+static void cc33xx_started_vifs_iter(void *data, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct cc33xx_vif *wlvif = cc33xx_vif_to_data(vif);
+	bool active = false;
+	int *count = (int *)data;
+
+	/* count active interfaces according to interface type.
+	 * checking only bss_conf.idle is bad for some cases, e.g.
+	 * we don't want to count sta in p2p_find as active interface.
+	 */
+	switch (wlvif->bss_type) {
+	case BSS_TYPE_STA_BSS:
+		if (test_bit(WLVIF_FLAG_STA_ASSOCIATED, &wlvif->flags))
+			active = true;
+		break;
+
+	case BSS_TYPE_AP_BSS:
+		if (wlvif->cc->active_sta_count > 0)
+			active = true;
+		break;
+
+	default:
+		break;
+	}
+
+	if (active)
+		(*count)++;
+}
+
+static int cc33xx_count_started_vifs(struct cc33xx *cc)
+{
+	int count = 0;
+
+	ieee80211_iterate_active_interfaces_atomic(cc->hw,
+						   IEEE80211_IFACE_ITER_RESUME_ALL,
+						   cc33xx_started_vifs_iter,
+						   &count);
+	return count;
+}
+
+static int cc33xx_scan_get_channels(struct cc33xx *cc,
+				    struct ieee80211_channel *req_channels[],
+				    u32 n_channels, u32 n_ssids,
+				    struct conn_scan_ch_params *channels,
+				    u32 band, bool radar, bool passive,
+				    unsigned int start, unsigned int max_channels,
+				    u8 *n_pactive_ch, int scan_type)
+{
+	unsigned int i, j;
+	u32 flags;
+	bool force_passive = !n_ssids;
+	u32 min_dwell_time_active, max_dwell_time_active;
+	u32 dwell_time_passive, dwell_time_dfs;
+	struct conn_scan_ch_params *ch;
+	struct ieee80211_channel *req_ch;
+
+	/* configure dwell times according to scan type */
+	if (scan_type == SCAN_TYPE_SEARCH) {
+		struct conf_scan_settings *c = &cc->conf.host_conf.scan;
+		bool active_vif_exists = !!cc33xx_count_started_vifs(cc);
+
+		min_dwell_time_active = active_vif_exists ?
+						c->min_dwell_time_active :
+						c->min_dwell_time_active_long;
+		max_dwell_time_active = active_vif_exists ?
+						c->max_dwell_time_active :
+						c->max_dwell_time_active_long;
+		dwell_time_passive = c->dwell_time_passive;
+		dwell_time_dfs = c->dwell_time_dfs;
+	} else {
+		struct conf_sched_scan_settings *c =
+					&cc->conf.host_conf.sched_scan;
+		u32 delta_per_probe;
+
+		delta_per_probe = (band == NL80211_BAND_5GHZ) ?
+					c->dwell_time_delta_per_probe_5 :
+					c->dwell_time_delta_per_probe;
+
+		min_dwell_time_active = c->base_dwell_time +
+			 n_ssids * c->num_probe_reqs * delta_per_probe;
+
+		max_dwell_time_active = min_dwell_time_active;
+		max_dwell_time_active += c->max_dwell_time_delta;
+		dwell_time_passive = c->dwell_time_passive;
+		dwell_time_dfs = c->dwell_time_dfs;
+	}
+
+	min_dwell_time_active = DIV_ROUND_UP(min_dwell_time_active, 1000);
+	max_dwell_time_active = DIV_ROUND_UP(max_dwell_time_active, 1000);
+	dwell_time_passive = DIV_ROUND_UP(dwell_time_passive, 1000);
+	dwell_time_dfs = DIV_ROUND_UP(dwell_time_dfs, 1000);
+
+	for (i = 0, j = start; i < n_channels && j < max_channels; i++) {
+		flags = req_channels[i]->flags;
+		ch = &channels[j];
+		req_ch = req_channels[i];
+
+		if (force_passive)
+			flags |= IEEE80211_CHAN_NO_IR;
+
+		if (req_ch->band == band && !(flags & IEEE80211_CHAN_DISABLED) &&
+		    (!!(flags & IEEE80211_CHAN_RADAR) == radar) &&
+		    /* if radar is set, we ignore the passive flag */
+		    (radar || !!(flags & IEEE80211_CHAN_NO_IR) == passive)) {
+			if (flags & IEEE80211_CHAN_RADAR) {
+				ch->flags |= SCAN_CHANNEL_FLAGS_DFS;
+
+				ch->passive_duration =
+					cpu_to_le16(dwell_time_dfs);
+			} else {
+				ch->passive_duration =
+					cpu_to_le16(dwell_time_passive);
+			}
+
+			ch->min_duration = cpu_to_le16(min_dwell_time_active);
+			ch->max_duration = cpu_to_le16(max_dwell_time_active);
+
+			ch->tx_power_att = req_ch->max_power;
+			ch->channel = req_ch->hw_value;
+
+			if (n_pactive_ch && band == NL80211_BAND_2GHZ &&
+			    ch->channel >= 12 && ch->channel <= 14 &&
+			    (flags & IEEE80211_CHAN_NO_IR) && !force_passive) {
+				/* pactive channels treated as DFS */
+				ch->flags = SCAN_CHANNEL_FLAGS_DFS;
+
+				/* n_pactive_ch is counted down from the end of
+				 * the passive channel list
+				 */
+				(*n_pactive_ch)++;
+				cc33xx_debug(DEBUG_SCAN, "n_pactive_ch = %d",
+					     *n_pactive_ch);
+			}
+
+			cc33xx_debug(DEBUG_SCAN, "freq %d, ch. %d, flags 0x%x, power %d, min/max_dwell %d/%d%s%s",
+				     req_ch->center_freq, req_ch->hw_value,
+				     req_ch->flags, req_ch->max_power,
+				     min_dwell_time_active,
+				     max_dwell_time_active,
+				     flags & IEEE80211_CHAN_RADAR ? ", DFS" : "",
+				     flags & IEEE80211_CHAN_NO_IR ? ", NO-IR" : "");
+			j++;
+		}
+	}
+
+	return j - start;
+}
+
+static bool cc33xx_set_scan_chan_params(struct cc33xx *cc,
+					struct cc33xx_scan_channels *cfg,
+					struct ieee80211_channel *channels[],
+					u32 n_channels, u32 n_ssids,
+					int scan_type)
+{
+	u8 n_pactive_ch = 0;
+
+	cfg->passive[0] = cc33xx_scan_get_channels(cc, channels, n_channels,
+						   n_ssids, cfg->channels_2,
+						   NL80211_BAND_2GHZ, false,
+						   true, 0, MAX_CHANNELS_2GHZ,
+						   &n_pactive_ch, scan_type);
+
+	cfg->active[0] = cc33xx_scan_get_channels(cc, channels, n_channels,
+						  n_ssids, cfg->channels_2,
+						  NL80211_BAND_2GHZ, false,
+						  false, cfg->passive[0],
+						  MAX_CHANNELS_2GHZ,
+						  &n_pactive_ch, scan_type);
+
+	cfg->passive[1] = cc33xx_scan_get_channels(cc, channels, n_channels,
+						   n_ssids, cfg->channels_5,
+						   NL80211_BAND_5GHZ, false,
+						   true, 0, MAX_CHANNELS_5GHZ,
+						   &n_pactive_ch, scan_type);
+
+	cfg->dfs = cc33xx_scan_get_channels(cc, channels, n_channels, n_ssids,
+					    cfg->channels_5, NL80211_BAND_5GHZ,
+					    true, true, cfg->passive[1],
+					    MAX_CHANNELS_5GHZ, &n_pactive_ch,
+					    scan_type);
+
+	cfg->active[1] = cc33xx_scan_get_channels(cc, channels, n_channels,
+						  n_ssids, cfg->channels_5,
+						  NL80211_BAND_5GHZ, false,
+						  false,
+						  cfg->passive[1] + cfg->dfs,
+						  MAX_CHANNELS_5GHZ,
+						  &n_pactive_ch, scan_type);
+
+	/* 802.11j channels are not supported yet */
+	cfg->passive[2] = 0;
+	cfg->active[2] = 0;
+
+	cfg->passive_active = n_pactive_ch;
+
+	cc33xx_debug(DEBUG_SCAN, "2.4GHz: active %d passive %d",
+		     cfg->active[0], cfg->passive[0]);
+	cc33xx_debug(DEBUG_SCAN, "5GHz: active %d passive %d",
+		     cfg->active[1], cfg->passive[1]);
+	cc33xx_debug(DEBUG_SCAN, "DFS: %d", cfg->dfs);
+
+	return  cfg->passive[0] || cfg->active[0] || cfg->passive[1] ||
+		cfg->active[1] || cfg->dfs || cfg->passive[2] || cfg->active[2];
+}
+
+static int cc33xx_scan_send(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			    struct cfg80211_scan_request *req)
+{
+	struct cc33xx_cmd_scan_params *cmd;
+	struct cc33xx_scan_channels *cmd_channels = NULL;
+	struct cc33xx_ssid *cmd_ssid;
+	u16 alloc_size;
+	int ret;
+	int i;
+
+	alloc_size =  sizeof(*cmd) + (sizeof(struct cc33xx_ssid) * req->n_ssids);
+	cmd = kzalloc(alloc_size, GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* scan on the dev role if the regular one is not started */
+	if (cc33xx_is_p2p_mgmt(wlvif))
+		cmd->role_id = wlvif->dev_role_id;
+	else
+		cmd->role_id = wlvif->role_id;
+
+	if (WARN_ON(cmd->role_id == CC33XX_INVALID_ROLE_ID)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	cmd->scan_type = SCAN_REQUEST_ONE_SHOT;
+	cmd->rssi_threshold = -127;
+	cmd->snr_threshold = 0;
+
+	for (i = 0; i < ETH_ALEN; i++)
+		cmd->bssid[i] = req->bssid[i];
+	cmd->ssid_from_list = 0;
+	cmd->filter = 0;
+	WARN_ON(req->n_ssids > 1);
+
+	/* configure channels */
+	cmd_channels = kzalloc(sizeof(*cmd_channels), GFP_KERNEL);
+	if (!cmd_channels) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_set_scan_chan_params(cc, cmd_channels, req->channels,
+				    req->n_channels, req->n_ssids,
+				    SCAN_TYPE_SEARCH);
+
+	cc33xx_adjust_channels(&cmd->params, cmd_channels, cmd->scan_type);
+	if (req->n_ssids > 0) {
+		cmd->ssid_from_list = 1;
+		cmd->num_of_ssids = req->n_ssids;
+		cmd_ssid = (struct cc33xx_ssid *)((u8 *)cmd + sizeof(*cmd));
+
+		cmd_ssid->len = req->ssids[0].ssid_len;
+		memcpy(cmd_ssid->ssid, req->ssids[0].ssid, cmd_ssid->len);
+		cmd_ssid->type = (req->ssids[0].ssid_len) ?
+				SCAN_SSID_TYPE_HIDDEN : SCAN_SSID_TYPE_PUBLIC;
+	}
+
+	ret = cc33xx_cmd_build_probe_req(cc, wlvif, cmd->role_id, cmd->scan_type,
+					 req->ssids ? req->ssids[0].ssid : NULL,
+					 req->ssids ? req->ssids[0].ssid_len : 0,
+					 req->ie, req->ie_len, NULL, 0, false);
+	if (ret < 0) {
+		cc33xx_error("PROBE request template failed");
+		goto out;
+	}
+
+	cc33xx_dump(DEBUG_SCAN, "SCAN: ", cmd, alloc_size);
+
+	ret = cc33xx_cmd_send(cc, CMD_SCAN, cmd, alloc_size, 0);
+	if (ret < 0) {
+		cc33xx_error("SCAN failed");
+		goto out;
+	}
+
+out:
+	kfree(cmd_channels);
+	kfree(cmd);
+	return ret;
+}
+
+static int cc33xx_scan_sched_scan_ssid_list(struct cc33xx *cc,
+					    struct cc33xx_vif *wlvif,
+					struct cfg80211_sched_scan_request *req,
+					    struct cc33xx_cmd_ssid_list *cmd)
+{
+	struct cfg80211_match_set *sets = req->match_sets;
+	struct cfg80211_ssid *ssids = req->ssids;
+	int ret = 0, i, j, n_match_ssids = 0;
+
+	cc33xx_debug((DEBUG_CMD | DEBUG_SCAN), "cmd sched scan ssid list");
+	/* count the match sets that contain SSIDs */
+	for (i = 0; i < req->n_match_sets; i++) {
+		if (sets[i].ssid.ssid_len > 0)
+			n_match_ssids++;
+	}
+
+	/* No filter, no ssids or only bcast ssid */
+	if (!n_match_ssids && (!req->n_ssids ||
+			       (req->n_ssids == 1 && req->ssids[0].ssid_len == 0)))
+		goto out;
+
+	cmd->role_id = wlvif->role_id;
+	if (!n_match_ssids) {
+		/* No filter, with ssids */
+
+		for (i = 0; i < req->n_ssids; i++) {
+			cmd->ssids[cmd->n_ssids].type = (ssids[i].ssid_len) ?
+				SCAN_SSID_TYPE_HIDDEN : SCAN_SSID_TYPE_PUBLIC;
+			cmd->ssids[cmd->n_ssids].len = ssids[i].ssid_len;
+			memcpy(cmd->ssids[cmd->n_ssids].ssid, ssids[i].ssid,
+			       ssids[i].ssid_len);
+			cmd->n_ssids++;
+		}
+	} else {
+		/* Add all SSIDs from the filters */
+		for (i = 0; i < req->n_match_sets; i++) {
+			/* ignore sets without SSIDs */
+			if (!sets[i].ssid.ssid_len)
+				continue;
+
+			cmd->ssids[cmd->n_ssids].type = SCAN_SSID_TYPE_PUBLIC;
+			cmd->ssids[cmd->n_ssids].len = sets[i].ssid.ssid_len;
+			memcpy(cmd->ssids[cmd->n_ssids].ssid,
+			       sets[i].ssid.ssid, sets[i].ssid.ssid_len);
+			cmd->n_ssids++;
+		}
+		if (req->n_ssids > 1 || (req->n_ssids == 1 && req->ssids[0].ssid_len > 0)) {
+			/* Mark all the SSIDs passed in the SSID list as HIDDEN,
+			 * so they're used in probe requests.
+			 */
+			for (i = 0; i < req->n_ssids; i++) {
+				if (!req->ssids[i].ssid_len)
+					continue;
+
+				for (j = 0; j < cmd->n_ssids; j++) {
+					if (req->ssids[i].ssid_len == cmd->ssids[j].len &&
+					    !memcmp(req->ssids[i].ssid,
+						    cmd->ssids[j].ssid,
+						    req->ssids[i].ssid_len)) {
+						cmd->ssids[j].type =
+							SCAN_SSID_TYPE_HIDDEN;
+						break;
+					}
+				}
+				/* Fail if SSID isn't present in the filters */
+				if (j == cmd->n_ssids) {
+					ret = -EINVAL;
+					goto out;
+				}
+			}
+		}
+	}
+
+	cc33xx_debug(DEBUG_CMD, "cmd sched scan with ssid list %d",
+		     cmd->n_ssids);
+	return cmd->n_ssids;
+out:
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+int cc33xx_sched_scan_start(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			    struct cfg80211_sched_scan_request *req,
+			    struct ieee80211_scan_ies *ies)
+{
+	struct cc33xx_cmd_scan_params *cmd;
+	struct cc33xx_cmd_ssid_list *ssid_list;
+	struct cc33xx_scan_channels *cmd_channels = NULL;
+	struct conf_sched_scan_settings *c = &cc->conf.host_conf.sched_scan;
+	int ret;
+	int n_ssids = 0;
+	int alloc_size = sizeof(*cmd);
+
+	cc33xx_debug(DEBUG_CMD, "cmd sched_scan scan config");
+
+	ssid_list = kzalloc(sizeof(*ssid_list), GFP_KERNEL);
+	if (!ssid_list) {
+		ret = -ENOMEM;
+		goto out_ssid_free;
+	}
+
+	n_ssids = cc33xx_scan_sched_scan_ssid_list(cc, wlvif, req, ssid_list);
+	if (n_ssids < 0)
+		return n_ssids;
+
+	cc33xx_debug(DEBUG_CMD, "ssid list num of ssids %d", ssid_list->n_ssids);
+
+	if (n_ssids <= 5) {
+		alloc_size += (n_ssids * sizeof(struct cc33xx_ssid));
+	} else { /* n_ssids > 5 */
+		ssid_list->scan_type = SCAN_REQUEST_CONNECT_PERIODIC_SCAN;
+		ret = cc33xx_cmd_send(cc, CMD_CONNECTION_SCAN_SSID_CFG,
+				      ssid_list, sizeof(*ssid_list), 0);
+		if (ret < 0) {
+			cc33xx_error("cmd sched scan ssid list failed");
+			goto out_ssid_free;
+		}
+	}
+
+	cmd = kzalloc(alloc_size, GFP_KERNEL);
+	if (!cmd) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	cmd->role_id = wlvif->role_id;
+
+	if (WARN_ON(cmd->role_id == CC33XX_INVALID_ROLE_ID)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	cmd->scan_type = SCAN_REQUEST_CONNECT_PERIODIC_SCAN;
+	cmd->rssi_threshold = c->rssi_threshold;
+	cmd->snr_threshold = c->snr_threshold;
+
+	cmd->filter = 1;
+	cmd->num_of_ssids = n_ssids;
+
+	cc33xx_debug(DEBUG_CMD, "ssid list num of n_ssids %d", n_ssids);
+	if (n_ssids > 0 && n_ssids <= 5) {
+		cmd->ssid_from_list = 1;
+		memcpy((u8 *)cmd + sizeof(*cmd), ssid_list->ssids,
+		       n_ssids * sizeof(struct cc33xx_ssid));
+	}
+
+	cmd_channels = kzalloc(sizeof(*cmd_channels), GFP_KERNEL);
+	if (!cmd_channels) {
+		ret = -ENOMEM;
+		goto out_free;
+	}
+
+	/* configure channels */
+	cc33xx_set_scan_chan_params(cc, cmd_channels, req->channels,
+				    req->n_channels, req->n_ssids,
+				    SCAN_TYPE_PERIODIC);
+	cc33xx_adjust_channels(&cmd->params, cmd_channels, cmd->scan_type);
+
+	memcpy(cmd->params.u.periodic.sched_scan_plans, req->scan_plans,
+	       sizeof(struct sched_scan_plan_cmd) * req->n_scan_plans);
+
+	cmd->params.u.periodic.sched_scan_plans_num = req->n_scan_plans;
+
+	cc33xx_debug(DEBUG_SCAN,
+		     "interval[0]: %d, iterations[0]: %d, num_plans: %d",
+		     cmd->params.u.periodic.sched_scan_plans[0].interval,
+		     cmd->params.u.periodic.sched_scan_plans[0].iterations,
+		     cmd->params.u.periodic.sched_scan_plans_num);
+
+	ret = cc33xx_cmd_build_probe_req(cc, wlvif, cmd->role_id, cmd->scan_type,
+					 req->ssids ? req->ssids[0].ssid : NULL,
+					 req->ssids ? req->ssids[0].ssid_len : 0,
+					 ies->ies[NL80211_BAND_2GHZ],
+					 ies->len[NL80211_BAND_2GHZ],
+					 ies->common_ies,
+					 ies->common_ie_len, true);
+
+	if (ret < 0) {
+		cc33xx_error("PROBE request template failed");
+		goto out_free;
+	}
+
+	cc33xx_dump(DEBUG_SCAN, "SCAN: ", cmd, alloc_size);
+
+	ret = cc33xx_cmd_send(cc, CMD_SCAN, cmd, alloc_size, 0);
+	if (ret < 0) {
+		cc33xx_error("SCAN failed");
+		goto out_free;
+	}
+
+out_free:
+	kfree(cmd_channels);
+	kfree(cmd);
+
+out_ssid_free:
+	kfree(ssid_list);
+
+	return ret;
+}
+
+static int __cc33xx_scan_stop(struct cc33xx *cc,
+			      struct cc33xx_vif *wlvif, u8 scan_type)
+{
+	struct cc33xx_cmd_scan_stop *stop;
+	int ret;
+
+	cc33xx_debug(DEBUG_CMD, "cmd periodic scan stop");
+
+	stop = kzalloc(sizeof(*stop), GFP_KERNEL);
+	if (!stop)
+		return -ENOMEM;
+
+	stop->role_id = wlvif->role_id;
+	stop->scan_type = scan_type;
+
+	ret = cc33xx_cmd_send(cc, CMD_STOP_SCAN, stop, sizeof(*stop), 0);
+	if (ret < 0) {
+		cc33xx_error("failed to send sched scan stop command");
+		goto out_free;
+	}
+
+out_free:
+	kfree(stop);
+	return ret;
+}
+
+void cc33xx_scan_sched_scan_stop(struct cc33xx *cc,
+				 struct cc33xx_vif *wlvif)
+{
+	__cc33xx_scan_stop(cc, wlvif, SCAN_REQUEST_CONNECT_PERIODIC_SCAN);
+}
+
+static int cc33xx_scan_start(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			     struct cfg80211_scan_request *req)
+{
+	return cc33xx_scan_send(cc, wlvif, req);
+}
+
+int cc33xx_scan_stop(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	return __cc33xx_scan_stop(cc, wlvif, SCAN_REQUEST_ONE_SHOT);
+}
+
+void cc33xx_scan_complete_work(struct work_struct *work)
+{
+	struct delayed_work *dwork;
+	struct cc33xx *cc;
+	struct cfg80211_scan_info info = {
+		.aborted = false,
+	};
+
+	dwork = to_delayed_work(work);
+	cc = container_of(dwork, struct cc33xx, scan_complete_work);
+
+	cc33xx_debug(DEBUG_SCAN, "Scanning complete");
+
+	mutex_lock(&cc->mutex);
+
+	if (unlikely(cc->state != CC33XX_STATE_ON))
+		goto out;
+
+	if (cc->scan.state == CC33XX_SCAN_STATE_IDLE)
+		goto out;
+
+	/* Rearm the tx watchdog just before idling scan. This
+	 * prevents just-finished scans from triggering the watchdog
+	 */
+	cc33xx_rearm_tx_watchdog_locked(cc);
+
+	cc->scan.state = CC33XX_SCAN_STATE_IDLE;
+	memset(cc->scan.scanned_ch, 0, sizeof(cc->scan.scanned_ch));
+	cc->scan.req = NULL;
+	cc->scan_wlvif = NULL;
+
+	if (cc->scan.failed) {
+		cc33xx_info("Scan completed due to error.");
+		cc33xx_queue_recovery_work(cc);
+	}
+
+	cc33xx_cmd_regdomain_config_locked(cc);
+
+	ieee80211_scan_completed(cc->hw, &info);
+
+out:
+	mutex_unlock(&cc->mutex);
+}
+
+int cc33xx_scan(struct cc33xx *cc, struct ieee80211_vif *vif, const u8 *ssid,
+		size_t ssid_len, struct cfg80211_scan_request *req)
+{
+	struct cc33xx_vif *wlvif = cc33xx_vif_to_data(vif);
+
+	if (cc->scan.state != CC33XX_SCAN_STATE_IDLE)
+		return -EBUSY;
+
+	cc->scan.state = CC33XX_SCAN_STATE_2GHZ_ACTIVE;
+
+	if (ssid_len && ssid) {
+		cc->scan.ssid_len = ssid_len;
+		memcpy(cc->scan.ssid, ssid, ssid_len);
+	} else {
+		cc->scan.ssid_len = 0;
+	}
+
+	cc->scan_wlvif = wlvif;
+	cc->scan.req = req;
+	memset(cc->scan.scanned_ch, 0, sizeof(cc->scan.scanned_ch));
+
+	/* we assume failure so that timeout scenarios are handled correctly */
+	cc->scan.failed = true;
+	ieee80211_queue_delayed_work(cc->hw, &cc->scan_complete_work,
+				     msecs_to_jiffies(CC33XX_SCAN_TIMEOUT));
+
+	cc33xx_scan_start(cc, wlvif, req);
+
+	return 0;
+}
+
+inline void cc33xx_scan_sched_scan_results(struct cc33xx *cc)
+{
+	cc33xx_debug(DEBUG_SCAN, "got periodic scan results");
+
+	ieee80211_sched_scan_results(cc->hw);
+}
+
+void cc33xx_scan_completed(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	cc->scan.failed = false;
+	cancel_delayed_work(&cc->scan_complete_work);
+	ieee80211_queue_delayed_work(cc->hw, &cc->scan_complete_work,
+				     msecs_to_jiffies(0));
+}
diff --git a/drivers/net/wireless/ti/cc33xx/scan.h b/drivers/net/wireless/ti/cc33xx/scan.h
new file mode 100644
index 000000000000..8475008a8e97
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/scan.h
@@ -0,0 +1,364 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __SCAN_H__
+#define __SCAN_H__
+
+#include "cc33xx.h"
+
+#define CC33XX_SCAN_TIMEOUT    30000 /* msec */
+
+enum {
+	CC33XX_SCAN_STATE_IDLE,
+	CC33XX_SCAN_STATE_2GHZ_ACTIVE,
+	CC33XX_SCAN_STATE_2GHZ_PASSIVE,
+	CC33XX_SCAN_STATE_5GHZ_ACTIVE,
+	CC33XX_SCAN_STATE_5GHZ_PASSIVE,
+	CC33XX_SCAN_STATE_DONE
+};
+
+struct conn_scan_ch_params {
+	__le16 min_duration;
+	__le16 max_duration;
+	__le16 passive_duration;
+
+	u8  channel;
+	u8  tx_power_att;
+
+	/* bit 0: DFS channel; bit 1: DFS enabled */
+	u8  flags;
+
+	u8  padding[3];
+} __packed;
+
+enum {
+	SCAN_SSID_TYPE_PUBLIC = 0,
+	SCAN_SSID_TYPE_HIDDEN = 1,
+};
+
+#define MAX_CHANNELS_2GHZ	14
+#define MAX_CHANNELS_4GHZ	4
+#define MAX_CHANNELS_5GHZ	32
+
+#define SCAN_MAX_CYCLE_INTERVALS 16
+#define SCAN_MAX_BANDS 3
+#define SCHED_SCAN_MAX_SSIDS 16
+
+/******************************************************************************
+ * ** ***                                                               *** ** *
+ * ** ***                          SCAN API                             *** ** *
+ * ** ***                                                               *** ** *
+ ******************************************************************************/
+
+#define CONN_SCAN_MAX_BAND                          (2)
+#define CONN_SCAN_MAX_CHANNELS_ALL_BANDS            (46)
+#define SCAN_MAX_SCHED_SCAN_PLANS           (12)
+
+enum scan_request_type {
+	SCAN_REQUEST_NONE,
+	SCAN_REQUEST_CONNECT_PERIODIC_SCAN,
+	SCAN_REQUEST_ONE_SHOT,
+	SCAN_REQUEST_SURVEY_SCAN,
+	SCAN_NUM_OF_REQUEST_TYPE
+};
+
+/******************************************************************************
+ *	ID:     CMD_SCAN
+ *	Desc:   This command will start scan process depending scan request
+ *		type
+ *	Return: CMD_COMPLETE
+ *****************************************************************************/
+/* struct cc33xx_ssid - SSIDs connection scan description
+ *
+ * @type: SSID type - SCAN_SSID_TYPE_HIDDEN/SCAN_SSID_TYPE_PUBLIC
+ *
+ * @len:  Length of the ssid
+ *
+ * @ssid: SSID
+ */
+struct cc33xx_ssid {
+	u8 type;
+	u8 len;
+	u8 ssid[IEEE80211_MAX_SSID_LEN];
+	u8 padding[2];
+} __packed;
+
+/**
+ * struct cc33xx_cmd_ssid_list - scan SSID list description
+ *
+ * @role_id:            roleID
+ *
+ * @num_of_ssids:       Number of SSID in the list. MAX 16 entries
+ *
+ * @ssid_list:          SSIDs to scan for (active scan only)
+ */
+struct cc33xx_cmd_ssid_list {
+	struct cc33xx_cmd_header header;
+
+	u8 role_id;
+	u8 scan_type;
+	u8 n_ssids;
+	struct cc33xx_ssid ssids[SCHED_SCAN_MAX_SSIDS];
+	u8 padding;
+} __packed;
+
+/**
+ * struct conn_scan_dwell_info - Channels duration info per band
+ *
+ * @min_duration:        Min duration (in ms)
+ *
+ * @max_duration:        Max duration (in ms)
+ *
+ * @passive_duration:    Duration to use for passive scans (in ms)
+ */
+struct conn_scan_dwell_info {
+	__le16  min_duration;
+	__le16  max_duration;
+	__le16  passive_duration;
+} __packed;
+
+/**
+ * struct conn_scan_ch_info - Channels info
+ *
+ * @channel:            channel number (channel_e)
+ *
+ * @tx_power_att:    TX power level in dbm
+ *
+ * @flags:       0 - DFS channel, 1 - DFS enabled (to be included in active scan)
+ */
+struct conn_scan_ch_info {
+	u8   channel;
+	u8   tx_power_att;
+	u8   flags;
+} __packed;
+
+/**
+ * struct scan_one_shot_info - ONE_SHOT scan param
+ *
+ * @passive:		Number of passive scan channels in bands BG,A
+ *
+ * @active:		Number of active scan channels in bands BG,A
+ *
+ * @dfs:		Number of DFS channels in A band
+ *
+ * @channel_list:	Channel list info
+ *			BG band channels are set from place 0 and forward.
+ *			A band channels are from CONN_SCAN_MAX_CHANNELS_BG and forward.
+ *			6Ghz band channels are from CONN_SCAN_MAX_CHANNELS_A_BG and forward.
+
+ * @dwell_info:		Scan duration time info per band
+ *
+ * @reserved:
+ *
+ */
+struct scan_one_shot_info {
+	u8  passive[CONN_SCAN_MAX_BAND];
+	u8  active[CONN_SCAN_MAX_BAND];
+	u8  dfs;
+
+	struct conn_scan_ch_info    channel_list[CONN_SCAN_MAX_CHANNELS_ALL_BANDS];
+	struct conn_scan_dwell_info dwell_info[CONN_SCAN_MAX_BAND];
+	u8  reserved;
+};
+
+/**
+ * sched_scan_plans - Scan plans for scheduled scan
+ *
+ * Each scan plan consists of the number of iterations to scan and the
+ * interval between scans. When a scan plan finishes (i.e., it was run
+ * for the specified number of iterations), the next scan plan is
+ * executed. The scan plans are executed in the order they appear in
+ * the array (lower index first). The last scan plan will run infinitely
+ * (until requested to stop), thus must not specify the number of
+ * iterations. All other scan plans must specify the number of
+ * iterations.
+ */
+struct sched_scan_plan_cmd {
+	u32 interval; /* In seconds */
+	u32 iterations; /* Zero to run infinitely */
+};
+
+/* struct periodicScanParams_t - Periodic scan param
+ *
+ * @sched_scan_plans:	Scan plans for a scheduled scan (defined in supplicant's driver.h)
+ *				interval and iterations
+ *
+ * @sched_scan_plans_num:Number of scan plans in sched_scan_plans array
+ *
+ * @passive:		Number of passive scan channels in bands BG,A
+ *
+ * @active:		Number of active scan channels in bands BG,A
+ *
+ * @dfs:		number of DFS channels in A band
+ *
+ * @channel_list:	Channel list info.
+ *			BG band channels are set from place 0 and forward.
+ *			A band channels are set from CONN_SCAN_MAX_CHANNELS_BG and forward.
+ *			6Ghz band are set from CONN_SCAN_MAX_CHANNELS_A_BG and forward.
+ *
+ * @dwell_info:		Scan duration time info per band
+ *
+ */
+struct scan_periodic_info {
+	struct sched_scan_plan_cmd  sched_scan_plans[SCAN_MAX_SCHED_SCAN_PLANS];
+	u16 sched_scan_plans_num;
+
+	u8 passive[CONN_SCAN_MAX_BAND];
+	u8 active[CONN_SCAN_MAX_BAND];
+	u8 dfs;
+
+	struct conn_scan_ch_info      channel_list[CONN_SCAN_MAX_CHANNELS_ALL_BANDS];
+	struct conn_scan_dwell_info   dwell_info[CONN_SCAN_MAX_BAND];
+} __packed;
+
+/**
+ * struct scan_param - union for ONE_SHOT/PERIODIC scan param
+ *
+ * @one_shot:       ONE_SHOT scan param
+ *
+ * @periodic:       Periodic scan param
+ */
+struct scan_param {
+	union {
+		struct scan_one_shot_info    one_shot;
+		struct scan_periodic_info    periodic;
+	} u;
+} __packed;
+
+/**
+ * struct cc33xx_cmd_scan_params - scan configured param
+ *
+ * @scan_type:		ONE_SHOT/PERIODIC scan
+ *
+ * @role_id:            role ID
+ *
+ * @params:	Scan parameter for ONE_SHOT/PERIODIC Scan
+ *
+ * @rssi_threshold:     RSSI threshold for basic filter
+ *
+ * @snr_threshold:      SNR threshold for basic filter
+ *
+ * @bssid:              BSSID to scan for
+ *
+ * @ssid_from_list:	0 - if there are more than 5 SSIDs entries
+ *				(list was sent SSID CONFIGURE COMMAND),
+ *			1 - 5 or less SSIDs entries, the list is at the end of the scan command
+ *
+ * @filter:		0 - not using filter and all the beacons/probe response frame
+ *                      forward to upper mac,  1 - using filter
+ *
+ * @num_of_ssids:		Number of SSIDs
+ */
+struct cc33xx_cmd_scan_params {
+	struct cc33xx_cmd_header header;
+	u8 scan_type;
+	u8 role_id;
+
+	struct scan_param   params;
+	s8 rssi_threshold; /* for filtering (in dBm) */
+	s8 snr_threshold;  /* for filtering (in dB) */
+
+	u8 bssid[ETH_ALEN];
+	u8 padding[2];
+
+	u8 ssid_from_list; /* use ssid from configured ssid list */
+	u8 filter;         /* forward only results with matching ssids */
+
+	u8 num_of_ssids;
+} __packed;
+
+/******************************************************************************
+ *	ID:     CMD_SET_PROBE_IE
+ *	Desc:   This command will  set the Info elements data for
+ *		probe request
+ *	Return: CMD_COMPLETE
+ *******************************************************************************/
+#define MAX_EXTRA_IES_LEN 512
+/**
+ * struct cc33xx_cmd_set_ies - Probe request info elements
+ *
+ * @scan_type:    ONE_SHOT/PERIODIC scan
+ *
+ * @role_id:      roleID
+ *
+ * @data:         info element buffer
+ *
+ * @len:          info element length
+ */
+struct cc33xx_cmd_set_ies {
+	struct cc33xx_cmd_header header;
+	u8 scan_type;
+	u8 role_id;
+	__le16 len;
+	u8                   data[MAX_EXTRA_IES_LEN];
+} __packed;
+
+/******************************************************************************
+ *	ID:     CMD_STOP_SCAN
+ *	Desc:   This command will stop scan process depending scan request
+ *		type, and if early termination is on
+ *	Return: CMD_COMPLETE
+ ******************************************************************************/
+/**
+ * struct cc33xx_cmd_scan_stop - scan stop param
+ *
+ * @scan_type:           Scan request type
+ *
+ * @role_id:             role ID
+ *
+ * @is_ET:               TRUE - Early termination is on, FALSE - no ET
+ */
+struct cc33xx_cmd_scan_stop {
+	struct cc33xx_cmd_header header;
+
+	u8 scan_type;
+	u8 role_id;
+	u8 is_ET;
+	u8 padding;
+} __packed;
+
+int cc33xx_scan_stop(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+void cc33xx_scan_completed(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_sched_scan_start(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			    struct cfg80211_sched_scan_request *req,
+			    struct ieee80211_scan_ies *ies);
+void cc33xx_scan_sched_scan_stop(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+
+int cc33xx_scan(struct cc33xx *cc, struct ieee80211_vif *vif,
+		const u8 *ssid, size_t ssid_len,
+		struct cfg80211_scan_request *req);
+void cc33xx_scan_complete_work(struct work_struct *work);
+void cc33xx_scan_sched_scan_results(struct cc33xx *cc);
+
+enum {
+	SCAN_SSID_FILTER_ANY      = 0,
+	SCAN_SSID_FILTER_SPECIFIC = 1,
+	SCAN_SSID_FILTER_LIST     = 2,
+	SCAN_SSID_FILTER_DISABLED = 3
+};
+
+#define SCAN_CHANNEL_FLAGS_DFS		BIT(0) /* channel is passive until an
+						* activity is detected on it
+						*/
+#define SCAN_CHANNEL_FLAGS_DFS_ENABLED	BIT(1)
+
+struct cc33xx_scan_channels {
+	u8 passive[SCAN_MAX_BANDS]; /* number of passive scan channels */
+	u8 active[SCAN_MAX_BANDS];  /* number of active scan channels */
+	u8 dfs;		   /* number of dfs channels in 5ghz */
+	u8 passive_active; /* number of passive before active channels 2.4ghz */
+
+	struct conn_scan_ch_params channels_2[MAX_CHANNELS_2GHZ];
+	struct conn_scan_ch_params channels_5[MAX_CHANNELS_5GHZ];
+	struct conn_scan_ch_params channels_4[MAX_CHANNELS_4GHZ];
+};
+
+enum {
+	SCAN_TYPE_SEARCH	= 0,
+	SCAN_TYPE_PERIODIC	= 1,
+	SCAN_TYPE_TRACKING	= 2,
+};
+
+#endif /* __CC33XX_SCAN_H__ */
-- 
2.25.1


