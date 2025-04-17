Return-Path: <linux-wireless+bounces-21673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6A1A91EE4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF995A6A3A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8024EF9D;
	Thu, 17 Apr 2025 13:55:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28724EF9B
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898108; cv=none; b=V8mZn36wuCtigJCuQjOH5uAri6tucpmizDNY7fTEER+T/Ky4sQOP/Ne6xlvJGaa08meQL9OtYfbs10r556oRSSp6aAEWhKGhubGfh8EmPuFFny6f6X4HaFCJ4qtgUJNoGQg7kVAuZOIOL8PNi2bnHTTGG+KKj3UkllK7McFO7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898108; c=relaxed/simple;
	bh=qT2sMESs+2ygTerY281vS6yb/yByNuTXqeH+WEgEnu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dTwVJHaI49NfIZGj5F8FhoCp59gusT3ULiYY9csD8fQVX1YtYu1grFto7sNd6NLI4YBWe/3OQD7Kn5JO0Bc97Ter5M0LE5aQnk/qeLIoMuubsu7nfg+J4no6nNOhlNRAQCaJc9EptEMKnBpDMKG4pyo/1cRTnvSSTf7EWp8O72g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 5jslJKBSSvCDd5JqaMjC0w==
X-CSE-MsgGUID: JimpIodiQ3eKMILUS0rOiA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:05 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 12FE240103D5;
	Thu, 17 Apr 2025 22:55:01 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 33/38] ra6w: add testmode.c
Date: Thu, 17 Apr 2025 16:52:31 +0300
Message-Id: <20250417135236.52410-34-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/testmode.c | 649 +++++++++++++++++++
 1 file changed, 649 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/testmode.c

diff --git a/drivers/net/wireless/renesas/ra6w/testmode.c b/drivers/net/wireless/renesas/ra6w/testmode.c
new file mode 100644
index 000000000000..ea67183b3c41
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/testmode.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains cfg80211 tetsmode routine.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/version.h>
+#include <net/netlink.h>
+
+#include "core.h"
+#include "params.h"
+#include "dbg.h"
+#include "testmode.h"
+#include "cfg80211.h"
+
+#define TESTMODE_SIZE	1024
+
+static int ra6w_testmode_reg(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct sk_buff *skb;
+	u32 memaddr;
+	u32 val32;
+	int ret = 0;
+
+	if (!tb[RA6W_TESTMODE_ATTR_REG_OFFSET]) {
+		ra6w_err("Error finding register offset\n");
+		return -ENOMSG;
+	}
+
+	memaddr = nla_get_u32(tb[RA6W_TESTMODE_ATTR_REG_OFFSET]);
+
+	switch (nla_get_u32(tb[RA6W_TESTMODE_ATTR_CMD])) {
+	case RA6W_TESTMODE_CMD_READ_REG: {
+		struct ra6w_cmd_mem_read_rsp mem_read_rsp;
+
+		ret = ra6w_ctrl_mem_read_req(ctrl, memaddr, &mem_read_rsp);
+		if (ret)
+			return ret;
+
+		skb = cfg80211_testmode_alloc_reply_skb(priv->wiphy, TESTMODE_SIZE);
+		if (!skb) {
+			ra6w_err("Error allocating memory\n");
+			return -ENOMEM;
+		}
+
+		val32 = le32_to_cpu(mem_read_rsp.memdata);
+		if (nla_put_u32(skb, RA6W_TESTMODE_ATTR_REG_VALUE32, val32))
+			goto nla_put_failure;
+
+		ret = cfg80211_testmode_reply(skb);
+	}
+		break;
+	case RA6W_TESTMODE_CMD_WRITE_REG:
+		if (!tb[RA6W_TESTMODE_ATTR_REG_VALUE32]) {
+			ra6w_err("Error finding value to write\n");
+			return -ENOMSG;
+		}
+
+		val32 = nla_get_u32(tb[RA6W_TESTMODE_ATTR_REG_VALUE32]);
+		ret = ra6w_ctrl_mem_write_req(ctrl, memaddr, val32);
+		break;
+	default:
+		ra6w_err("Unknown TM reg cmd ID\n");
+		return -EINVAL;
+	}
+
+	return ret;
+
+nla_put_failure:
+	kfree_skb(skb);
+
+	return -EMSGSIZE;
+}
+
+static int ra6w_testmode_dbg_filter(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	u32 filter;
+	int ret = 0;
+
+	if (!tb[RA6W_TESTMODE_ATTR_REG_FILTER]) {
+		ra6w_err("Error finding filter value\n");
+		return -ENOMSG;
+	}
+
+	filter = nla_get_u32(tb[RA6W_TESTMODE_ATTR_REG_FILTER]);
+	ra6w_dbg("TM DBG filter, setting: 0x%x\n", filter);
+
+	switch (nla_get_u32(tb[RA6W_TESTMODE_ATTR_CMD])) {
+	case RA6W_TESTMODE_CMD_LOGMODEFILTER_SET:
+		ret = ra6w_ctrl_dbg_mode_filter_req(ctrl, filter);
+		break;
+	case RA6W_TESTMODE_CMD_DBGLEVELFILTER_SET:
+		ret = ra6w_ctrl_dbg_level_filter_req(ctrl, filter);
+		break;
+	default:
+		ra6w_err("Unknown testmode register command ID\n");
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ra6w_testmode_rf_tx(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	struct ra6w_cmd_rf_tx_data data;
+
+	if (!tb[RA6W_TESTMODE_ATTR_START]) {
+		ra6w_err("Error finding RF TX parameters\n");
+		return -ENOMSG;
+	}
+
+	data.start = nla_get_u8(tb[RA6W_TESTMODE_ATTR_START]);
+	if (data.start == RA6W_TESTMODE_VALUE_START) {
+		if (!tb[RA6W_TESTMODE_ATTR_RATE] ||
+		    !tb[RA6W_TESTMODE_ATTR_POWER] ||
+		    !tb[RA6W_TESTMODE_ATTR_GI] ||
+		    !tb[RA6W_TESTMODE_ATTR_GREEN] ||
+		    !tb[RA6W_TESTMODE_ATTR_PREAMBLE] ||
+		    !tb[RA6W_TESTMODE_ATTR_QOS] ||
+		    !tb[RA6W_TESTMODE_ATTR_ACK] ||
+		    !tb[RA6W_TESTMODE_ATTR_AIFSN] ||
+		    !tb[RA6W_TESTMODE_ATTR_CH] ||
+		    !tb[RA6W_TESTMODE_ATTR_FRAMES_NUM] ||
+		    !tb[RA6W_TESTMODE_ATTR_ADDR_DEST] ||
+		    !tb[RA6W_TESTMODE_ATTR_BSSID])
+			return -EINVAL;
+
+		data.tx_rate = cpu_to_le32(nla_get_u32(tb[RA6W_TESTMODE_ATTR_RATE]));
+		data.tx_power = cpu_to_le32(nla_get_u32(tb[RA6W_TESTMODE_ATTR_POWER]));
+		data.gi = nla_get_u8(tb[RA6W_TESTMODE_ATTR_GI]);
+		data.green_field = nla_get_u8(tb[RA6W_TESTMODE_ATTR_GREEN]);
+		data.preamble_type = nla_get_u8(tb[RA6W_TESTMODE_ATTR_PREAMBLE]);
+		data.qos_enable = nla_get_u8(tb[RA6W_TESTMODE_ATTR_QOS]);
+		data.ack_policy = nla_get_u8(tb[RA6W_TESTMODE_ATTR_ACK]);
+		data.aifsn_val = nla_get_u8(tb[RA6W_TESTMODE_ATTR_AIFSN]);
+		data.frequency = cpu_to_le16(nla_get_u16(tb[RA6W_TESTMODE_ATTR_CH]));
+		data.num_frames = cpu_to_le16(nla_get_u16(tb[RA6W_TESTMODE_ATTR_FRAMES_NUM]));
+		data.frame_len = cpu_to_le16(nla_get_u16(tb[RA6W_TESTMODE_ATTR_FRAMES_LEN]));
+		data.dest_addr = cpu_to_le64(nla_get_u64(tb[RA6W_TESTMODE_ATTR_ADDR_DEST]));
+		data.bssid = cpu_to_le64(nla_get_u64(tb[RA6W_TESTMODE_ATTR_BSSID]));
+	}
+
+	return ra6w_ctrl_rf_tx_req(ctrl, &data);
+}
+
+static int ra6w_testmode_rf_cw(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	struct ra6w_cmd_rf_cw_data data = { 0 };
+
+	if (!tb[RA6W_TESTMODE_ATTR_START]) {
+		ra6w_err("Error finding RF CW parameters\n");
+		return -ENOMSG;
+	}
+
+	data.start = nla_get_u8(tb[RA6W_TESTMODE_ATTR_START]);
+	if (data.start == RA6W_TESTMODE_VALUE_START) {
+		if (!tb[RA6W_TESTMODE_ATTR_POWER])
+			return -EINVAL;
+
+		data.tx_power = cpu_to_le32(nla_get_u32(tb[RA6W_TESTMODE_ATTR_POWER]));
+		if (!tb[RA6W_TESTMODE_ATTR_CH])
+			return -EINVAL;
+
+		data.frequency = cpu_to_le16(nla_get_u16(tb[RA6W_TESTMODE_ATTR_CH]));
+	}
+
+	return ra6w_ctrl_rf_cw_req(ctrl, &data);
+}
+
+static int ra6w_testmode_rf_cont(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	struct ra6w_cmd_rf_cont_data data = { 0 };
+
+	if (!tb[RA6W_TESTMODE_ATTR_START]) {
+		ra6w_err("Error finding RF CONT parameters\n");
+		return -ENOMSG;
+	}
+
+	data.start = nla_get_u8(tb[RA6W_TESTMODE_ATTR_START]);
+	if (data.start == RA6W_TESTMODE_VALUE_START) {
+		if (!tb[RA6W_TESTMODE_ATTR_POWER])
+			return -EINVAL;
+
+		data.tx_power = cpu_to_le32(nla_get_u32(tb[RA6W_TESTMODE_ATTR_POWER]));
+		if (!tb[RA6W_TESTMODE_ATTR_CH])
+			return -EINVAL;
+
+		data.frequency = cpu_to_le16(nla_get_u16(tb[RA6W_TESTMODE_ATTR_CH]));
+		if (!tb[RA6W_TESTMODE_ATTR_RATE])
+			return -EINVAL;
+
+		data.tx_rate = cpu_to_le32(nla_get_u32(tb[RA6W_TESTMODE_ATTR_RATE]));
+	}
+
+	return ra6w_ctrl_rf_cont_req(ctrl, &data);
+}
+
+static int ra6w_testmode_rf_ch(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	u16 frequency = 0;
+
+	if (!tb[RA6W_TESTMODE_ATTR_CH]) {
+		ra6w_err("Error finding RF CH parameters\n");
+		return -ENOMSG;
+	}
+
+	frequency = nla_get_u16(tb[RA6W_TESTMODE_ATTR_CH]);
+
+	return ra6w_ctrl_rf_ch_req(ctrl, frequency);
+}
+
+static int ra6w_testmode_rf_per(struct ra6w_ctrl *ctrl, struct nlattr **tb)
+{
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_cmd_rf_per_rsp rsp = { 0 };
+	struct sk_buff *skb = NULL;
+	int ret = 0;
+	u8 start = 0;
+
+	if (!tb[RA6W_TESTMODE_ATTR_START]) {
+		ra6w_err("Error finding RF PER parameters\n");
+		return -ENOMSG;
+	}
+
+	start = nla_get_u8(tb[RA6W_TESTMODE_ATTR_START]);
+	if (start != RA6W_TESTMODE_VALUE_PER_GET)
+		return 0;
+
+	ret = ra6w_ctrl_rf_per_req(ctrl, start, &rsp);
+	if (ret)
+		return ret;
+
+	skb = cfg80211_testmode_alloc_reply_skb(priv->wiphy, TESTMODE_SIZE);
+	if (!skb) {
+		ra6w_err("Error allocating memory\n");
+		return -ENOMEM;
+	}
+
+	if (nla_put_u32(skb, RA6W_TESTMODE_ATTR_PER_PASS, le32_to_cpu(rsp.pass)))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, RA6W_TESTMODE_ATTR_PER_FCS, le32_to_cpu(rsp.fcs)))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, RA6W_TESTMODE_ATTR_PER_PHY, le32_to_cpu(rsp.phy)))
+		goto nla_put_failure;
+
+	if (nla_put_u32(skb, RA6W_TESTMODE_ATTR_PER_OVERFLOW, le32_to_cpu(rsp.overflow)))
+		goto nla_put_failure;
+
+	return cfg80211_testmode_reply(skb);
+
+nla_put_failure:
+	if (skb)
+		kfree_skb(skb);
+
+	return -EMSGSIZE;
+}
+
+static int ra6w_testmode_host_log_level(struct nlattr **tb)
+{
+	u8 level = 0;
+
+	if (!tb[RA6W_TESTMODE_ATTR_HOST_LOG_LEVEL]) {
+		ra6w_err("Error finding level attribute\n");
+		return -ENOMSG;
+	}
+
+	level = nla_get_u8(tb[RA6W_TESTMODE_ATTR_HOST_LOG_LEVEL]);
+
+	RA6W_SET_DBG_LEVEL(level);
+
+	return 0;
+}
+
+static int ra6w_testmode_tx_power(struct ra6w_ctrl *ctrl, struct nlattr **tb,
+				  const struct ra6w_cfg80211_vif *vif)
+{
+	u32 tx_power = 0;
+
+	if (!tb[RA6W_TESTMODE_ATTR_POWER]) {
+		ra6w_err("Error finding tx power attribute\n");
+		return -ENOMSG;
+	}
+
+	tx_power = nla_get_u32(tb[RA6W_TESTMODE_ATTR_POWER]);
+
+	return ra6w_ctrl_set_tx_power_req(ctrl, vif->vif_idx, tx_power);
+}
+
+static struct ra6w_cfg80211_sta *ra6w_testmode_sta_get(struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_cfg80211_sta *sta = NULL;
+
+	if (vif->type == NL80211_IFTYPE_STATION ||
+	    vif->type == NL80211_IFTYPE_P2P_CLIENT)
+		return vif->sta.ap;
+
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_P2P_GO) {
+		list_for_each_entry(sta, &vif->ap.sta_list, list) {
+			if (sta->valid)
+				return sta;
+		}
+	}
+
+	return NULL;
+}
+
+static int ra6w_testmode_stats_start(struct ra6w_ctrl *ctrl, struct nlattr **tb,
+				     struct ra6w_cfg80211_vif *vif)
+{
+	int ret = 0;
+
+	ret = ra6w_stats_init(&vif->stats);
+	if (ret)
+		return ret;
+
+	return ra6w_ctrl_stats_tx_start_req(ctrl, RA6W_STATS_TX_START_BIT);
+}
+
+static int ra6w_testmode_stats_stop(struct ra6w_cfg80211_vif *vif)
+{
+	ra6w_stats_deinit(&vif->stats);
+
+	return 0;
+}
+
+static int ra6w_testmode_stats_tx(struct ra6w_ctrl *ctrl, struct nlattr **tb,
+				  struct ra6w_cfg80211_vif *vif)
+{
+	int ret = 0;
+	struct ra6w_cmd_stats_tx_rsp rsp = { 0 };
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct wiphy *wiphy = priv->wiphy;
+	struct sk_buff *skb = NULL;
+	char bssid[RA6W_MAC_ADDR_STR_LEN] = { 0 };
+	char mac_address[RA6W_MAC_ADDR_STR_LEN] = { 0 };
+
+	if (!vif->stats.stats_enabled)
+		return -EINVAL;
+
+	sta = ra6w_testmode_sta_get(vif);
+	if (!sta)
+		return -EINVAL;
+
+	ret = ra6w_ctrl_stats_tx_req(ctrl, RA6W_STATS_TX_REQ_BIT, &rsp);
+	if (ret)
+		return ret;
+
+	skb = cfg80211_testmode_alloc_reply_skb(wiphy, TESTMODE_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	snprintf(bssid, sizeof(bssid), "%pM", sta->mac_addr);
+	snprintf(mac_address, sizeof(mac_address), "%pM", wiphy->perm_addr);
+
+	if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_FLAGS, rsp.format_mod) ||
+	    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_EPR, sizeof(rsp.epr), rsp.epr) ||
+	    nla_put_string(skb, RA6W_TESTMODE_ATTR_STATS_BSSID, bssid) ||
+	    nla_put_string(skb, RA6W_TESTMODE_ATTR_STATS_OWN_MAC, mac_address) ||
+	    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_STAIDX, sta->sta_idx))
+		goto nla_put_failure;
+
+	switch (rsp.format_mod) {
+	case RA6W_CFG80211_FORMATMOD_NON_HT:
+	case RA6W_CFG80211_FORMATMOD_NON_HT_DUP_OFDM:
+		if (nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_CCK, sizeof(rsp.non_ht.success),
+			    rsp.non_ht.success) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_CCK_FAIL, sizeof(rsp.non_ht.fail),
+			    rsp.non_ht.fail))
+			goto nla_put_failure;
+		break;
+	case RA6W_CFG80211_FORMATMOD_HT_MF:
+	case RA6W_CFG80211_FORMATMOD_HT_GF:
+		if (nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_HT, sizeof(rsp.ht.success),
+			    rsp.ht.success) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_HT_FAIL, sizeof(rsp.ht.fail),
+			    rsp.ht.fail))
+			goto nla_put_failure;
+		break;
+	case RA6W_CFG80211_FORMATMOD_VHT:
+		if (nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_VHT, sizeof(rsp.vht.success),
+			    rsp.vht.success) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_VHT_FAIL, sizeof(rsp.vht.fail),
+			    rsp.vht.fail))
+			goto nla_put_failure;
+		break;
+	case RA6W_CFG80211_FORMATMOD_HE_SU:
+	case RA6W_CFG80211_FORMATMOD_HE_ER:
+	case RA6W_CFG80211_FORMATMOD_HE_MU:
+	case RA6W_CFG80211_FORMATMOD_HE_TB:
+		if (nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_HE, sizeof(rsp.he.success),
+			    rsp.he.success) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_TX_HE_FAIL, sizeof(rsp.he.fail),
+			    rsp.he.fail))
+			goto nla_put_failure;
+		break;
+	};
+
+	return cfg80211_testmode_reply(skb);
+
+nla_put_failure:
+	kfree_skb(skb);
+
+	return -EMSGSIZE;
+}
+
+static int ra6w_testmode_stats_rx(struct ra6w_ctrl *ctrl, struct nlattr **tb,
+				  struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct wiphy *wiphy = priv->wiphy;
+	struct sk_buff *skb = NULL;
+	struct ra6w_stats *stats = &vif->stats;
+	struct ra6w_stats_rx *rx_stats = stats->rx_stats;
+	char bssid[RA6W_MAC_ADDR_STR_LEN] = { 0 };
+	char mac_address[RA6W_MAC_ADDR_STR_LEN] = { 0 };
+
+	if (!stats->stats_enabled || !rx_stats)
+		return -EINVAL;
+
+	sta = ra6w_testmode_sta_get(vif);
+	if (!sta)
+		return -EINVAL;
+
+	skb = cfg80211_testmode_alloc_reply_skb(wiphy, TESTMODE_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_READY, vif->stats.stats_enabled))
+		goto nla_put_failure;
+
+	snprintf(bssid, sizeof(bssid), "%pM", sta->mac_addr);
+	snprintf(mac_address, sizeof(mac_address), "%pM", wiphy->perm_addr);
+
+	if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_FLAGS, rx_stats->flags) ||
+	    nla_put_string(skb, RA6W_TESTMODE_ATTR_STATS_BSSID, bssid) ||
+	    nla_put_string(skb, RA6W_TESTMODE_ATTR_STATS_OWN_MAC, mac_address) ||
+	    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_STAIDX, sta->sta_idx))
+		goto nla_put_failure;
+
+	if (rx_stats->flags & RA6W_STATS_RX_OFDM_BIT ||
+	    rx_stats->flags & RA6W_STATS_RX_CCK_BIT) {
+		if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_BW, rx_stats->non_ht.bw) ||
+		    nla_put_u64_64bit(skb, RA6W_TESTMODE_ATTR_STATS_RX_CCK, rx_stats->non_ht.cck,
+				      NL80211_ATTR_PAD) ||
+		    nla_put_u64_64bit(skb, RA6W_TESTMODE_ATTR_STATS_RX_OFDM,
+				      rx_stats->non_ht.ofdm, NL80211_ATTR_PAD))
+			goto nla_put_failure;
+	}
+
+	if (rx_stats->flags & RA6W_STATS_RX_HT_BIT) {
+		if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_BW, rx_stats->ht.bw) ||
+		    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_NSS, rx_stats->ht.nss) ||
+		    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_GI, rx_stats->ht.gi) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_RX_HT, sizeof(rx_stats->ht.ht),
+			    rx_stats->ht.ht))
+			goto nla_put_failure;
+	}
+
+	if (rx_stats->flags & RA6W_STATS_RX_VHT_BIT) {
+		if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_BW, rx_stats->vht.bw) ||
+		    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_NSS, rx_stats->vht.nss) ||
+		    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_GI, rx_stats->vht.gi) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_RX_VHT, sizeof(rx_stats->vht.vht),
+			    rx_stats->vht.vht))
+			goto nla_put_failure;
+	}
+
+	if (rx_stats->flags & RA6W_STATS_RX_HE_SU_BIT) {
+		if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_BW, rx_stats->he_su.bw) ||
+		    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_NSS, rx_stats->he_su.nss) ||
+		    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_RX_GI, rx_stats->he_su.gi) ||
+		    nla_put(skb, RA6W_TESTMODE_ATTR_STATS_RX_HE_SU, sizeof(rx_stats->he_su.he),
+			    rx_stats->he_su.he))
+			goto nla_put_failure;
+	}
+
+	return cfg80211_testmode_reply(skb);
+
+nla_put_failure:
+	kfree_skb(skb);
+
+	return -EMSGSIZE;
+}
+
+static int ra6w_testmode_stats_rssi(struct ra6w_ctrl *ctrl, struct nlattr **tb,
+				    struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_cfg80211_sta *sta = vif->sta.ap;
+	struct wiphy *wiphy = priv->wiphy;
+	struct sk_buff *skb = NULL;
+	struct ra6w_stats *stats = &vif->stats;
+	char bssid[RA6W_MAC_ADDR_STR_LEN] = { 0 };
+	char mac_address[RA6W_MAC_ADDR_STR_LEN] = { 0 };
+
+	if (!stats->stats_enabled)
+		return -EINVAL;
+
+	if (vif->type == NL80211_IFTYPE_AP ||
+	    vif->type == NL80211_IFTYPE_P2P_GO)
+		return -EINVAL;
+
+	if (!sta)
+		return -EINVAL;
+
+	skb = cfg80211_testmode_alloc_reply_skb(wiphy, TESTMODE_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	snprintf(bssid, sizeof(bssid), "%pM", sta->mac_addr);
+	snprintf(mac_address, sizeof(mac_address), "%pM", wiphy->perm_addr);
+
+	if (nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_READY, stats->stats_enabled) ||
+	    nla_put_u32(skb, RA6W_TESTMODE_ATTR_STATS_RSSI, sta->stats.last_rx_data_ext.rssi1) ||
+	    nla_put_string(skb, RA6W_TESTMODE_ATTR_STATS_BSSID, bssid) ||
+	    nla_put_string(skb, RA6W_TESTMODE_ATTR_STATS_OWN_MAC, mac_address) ||
+	    nla_put_u8(skb, RA6W_TESTMODE_ATTR_STATS_STAIDX, sta->sta_idx))
+		goto nla_put_failure;
+
+	return cfg80211_testmode_reply(skb);
+
+nla_put_failure:
+	kfree_skb(skb);
+
+	return -EMSGSIZE;
+}
+
+static const struct nla_policy ra6w_testmode_attr_policy[RA6W_TESTMODE_ATTR_MAX] = {
+	[RA6W_TESTMODE_ATTR_CMD] = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_REG_OFFSET]  = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_REG_VALUE32] = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_REG_FILTER]  = { .type = NLA_U32 },
+
+	/* RF commands */
+	[RA6W_TESTMODE_ATTR_START]       = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_CH]          = { .type = NLA_U16 },
+	[RA6W_TESTMODE_ATTR_FRAMES_NUM]  = { .type = NLA_U16 },
+	[RA6W_TESTMODE_ATTR_FRAMES_LEN]  = { .type = NLA_U16 },
+	[RA6W_TESTMODE_ATTR_RATE]        = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_POWER]       = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_ADDR_DEST]   = { .type = NLA_U64 },
+	[RA6W_TESTMODE_ATTR_BSSID]       = { .type = NLA_U64 },
+	[RA6W_TESTMODE_ATTR_GI]          = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_GREEN]       = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_PREAMBLE]    = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_QOS]         = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_ACK]         = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_AIFSN]       = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_PER_PASS]    = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_PER_FCS]     = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_PER_PHY]     = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_PER_OVERFLOW] = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_HOST_LOG_LEVEL] = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_STATS_RSSI] = { .type = NLA_U32 },
+	[RA6W_TESTMODE_ATTR_STATS_BSSID] = { .type = NLA_STRING },
+	[RA6W_TESTMODE_ATTR_STATS_STAIDX] = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_STATS_OWN_MAC] = { .type = NLA_STRING },
+	[RA6W_TESTMODE_ATTR_STATS_FLAGS] = { .type = NLA_U8 },
+	[RA6W_TESTMODE_ATTR_STATS_RX_OFDM] = { .type = NLA_U32, .len = 8 },
+	[RA6W_TESTMODE_ATTR_STATS_READY] = { .type = NLA_U8 },
+};
+
+int ra6w_testmode_cmd(struct wiphy *wiphy, struct wireless_dev *wdev, void *data, int len)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	struct nlattr *tb[RA6W_TESTMODE_ATTR_MAX];
+	int ret = -ENOENT;
+	const struct net_device *ndev = wdev->netdev;
+	struct ra6w_cfg80211_vif *vif = netdev_priv(ndev);
+	struct ra6w_ctrl *ctrl = &priv->core->ctrl;
+	u32 cmd;
+
+	ret = nla_parse_deprecated(tb, RA6W_TESTMODE_ATTR_MAX, data, len,
+				   ra6w_testmode_attr_policy, NULL);
+	if (ret)
+		return ret;
+
+	if (!tb[RA6W_TESTMODE_ATTR_CMD]) {
+		ra6w_err("Error finding testmode command type\n");
+		return -ENOMSG;
+	}
+
+	cmd = nla_get_u32(tb[RA6W_TESTMODE_ATTR_CMD]);
+
+	switch (cmd) {
+	case RA6W_TESTMODE_CMD_READ_REG:
+	case RA6W_TESTMODE_CMD_WRITE_REG:
+		ret = ra6w_testmode_reg(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_LOGMODEFILTER_SET:
+	case RA6W_TESTMODE_CMD_DBGLEVELFILTER_SET:
+		ret = ra6w_testmode_dbg_filter(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_TX:
+		ret = ra6w_testmode_rf_tx(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_CW:
+		ret = ra6w_testmode_rf_cw(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_CONT:
+		ret = ra6w_testmode_rf_cont(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_CHANNEL:
+		ret = ra6w_testmode_rf_ch(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_PER:
+		ret = ra6w_testmode_rf_per(ctrl, tb);
+		break;
+	case RA6W_TESTMODE_CMD_HOST_LOG_LEVEL:
+		ret = ra6w_testmode_host_log_level(tb);
+		break;
+	case RA6W_TESTMODE_CMD_TX_POWER:
+		ret = ra6w_testmode_tx_power(ctrl, tb, vif);
+		break;
+	case RA6W_TESTMODE_CMD_STATS_START:
+		ret = ra6w_testmode_stats_start(ctrl, tb, vif);
+		break;
+	case RA6W_TESTMODE_CMD_STATS_STOP:
+		ret = ra6w_testmode_stats_stop(vif);
+		break;
+	case RA6W_TESTMODE_CMD_STATS_TX:
+		ret = ra6w_testmode_stats_tx(ctrl, tb, vif);
+		break;
+	case RA6W_TESTMODE_CMD_STATS_RX:
+		ret = ra6w_testmode_stats_rx(ctrl, tb, vif);
+		break;
+	case RA6W_TESTMODE_CMD_STATS_RSSI:
+		ret = ra6w_testmode_stats_rssi(ctrl, tb, vif);
+		break;
+	default:
+		ra6w_err("Unknown testmode command: %u\n", cmd);
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	return ret;
+}
-- 
2.17.1


