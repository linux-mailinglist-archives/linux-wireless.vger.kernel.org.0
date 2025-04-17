Return-Path: <linux-wireless+bounces-21665-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B872BA91ED9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33C2464950
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28524EF87;
	Thu, 17 Apr 2025 13:54:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15B524EF68
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898073; cv=none; b=Bofre5JC16zfdZOAcJwMB1neGQqSk1SCLlkp2ywFc6czfB0I1xr6nw8Vdcp7zm2WB+G6I3xWByMWLd6blByq4Nn28W1S5bMw2AV3aM186cW0zsocYtJ+SKJcK7JtgnlDJVDWF0thTLiSstE1ftwx/KYdUxWR3jQ6Nvnn+HJ+RB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898073; c=relaxed/simple;
	bh=9KB6aECXPbMLZqUEChtYKuv9mj2jKVbCMPNdcmPhoV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=j/7lNNN18Sv6NW26BD/DeuY7Y6TollcKajVqXGLwOHbyUoOJIwtyyKqouFlxiGKYfimD2gQKK10wb78/x8DAqVM1/5bjcfLlswD0rs0xCnH7OPQEsSM8Pqvwb6EbjO7DtW1uokxHlKSbE2x3J0OqCFIGg5jUjbalOQxWbKaNFio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: FiYkDQIwRuqT+DRSZmxHVQ==
X-CSE-MsgGUID: i5uLOj4EQ+im9wfLBHk82w==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:31 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 30E2E400E4E9;
	Thu, 17 Apr 2025 22:54:27 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 25/38] ra6w: add rx.c
Date: Thu, 17 Apr 2025 16:52:23 +0300
Message-Id: <20250417135236.52410-26-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/rx.c | 274 +++++++++++++++++++++++++
 1 file changed, 274 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/rx.c

diff --git a/drivers/net/wireless/renesas/ra6w/rx.c b/drivers/net/wireless/renesas/ra6w/rx.c
new file mode 100644
index 000000000000..9e2570938c88
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/rx.c
@@ -0,0 +1,274 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains Rx routine.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include "core.h"
+#include "dev.h"
+#include "params.h"
+#include "dbg.h"
+#include "cfg80211.h"
+#include "rx.h"
+
+#define RA6W_RX_THREAD_NAME	"ra6w_rx_thread"
+
+static void ra6w_rx_update_stats(struct ra6w_cfg80211_vif *vif, const struct ra6w_rx_buf *rx_buf)
+{
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_cfg80211_sta_stats *stats = NULL;
+
+	sta = ra6w_cfg80211_sta_get(vif->priv, rx_buf->ext_hdr.sta_idx);
+	if (!sta)
+		return;
+
+	stats = &sta->stats;
+
+	sta->stats.last_acttive_time = jiffies;
+	stats->rx_packets++;
+	stats->rx_bytes += le16_to_cpu(rx_buf->data_len);
+	stats->last_rx_data_ext = rx_buf->ext_hdr;
+
+	if (stats->last_rx_data_ext.format_mod > 1)
+		stats->last_stats = rx_buf->ext_hdr;
+
+	ra6w_stats_rx_update(&vif->stats, stats);
+}
+
+static int ra6w_rx_mgmt_set(struct ra6w_cfg80211_vif *vif, struct sk_buff *skb)
+{
+	struct net_device *ndev = vif->ndev;
+	struct ra6w_rx_buf *rx_buf = (struct ra6w_rx_buf *)skb->data;
+	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)rx_buf->data;
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_CLIENT:
+	case NL80211_IFTYPE_P2P_GO:
+		if (ieee80211_is_beacon(mgmt->frame_control)) {
+			struct wiphy *wiphy = vif->wdev.wiphy;
+
+			if (!wiphy)
+				return -ENOENT;
+
+			cfg80211_report_obss_beacon(wiphy, rx_buf->data,
+						    le16_to_cpu(rx_buf->data_len),
+						    rx_buf->ext_hdr.prim20_freq,
+						    rx_buf->ext_hdr.rssi1);
+
+			return 0;
+		}
+
+		if (!ieee80211_is_deauth(mgmt->frame_control) &&
+		    !ieee80211_is_disassoc(mgmt->frame_control))
+			break;
+
+		if (mgmt->u.deauth.reason_code ==
+		    cpu_to_le16(WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) ||
+		    mgmt->u.deauth.reason_code ==
+		    cpu_to_le16(WLAN_REASON_CLASS3_FRAME_FROM_NONASSOC_STA)) {
+			cfg80211_rx_unprot_mlme_mgmt(ndev, rx_buf->data,
+						     le16_to_cpu(rx_buf->data_len));
+
+			return 0;
+		}
+		break;
+	default:
+		break;
+	}
+
+	cfg80211_rx_mgmt(&vif->wdev, rx_buf->ext_hdr.prim20_freq, rx_buf->ext_hdr.rssi1,
+			 rx_buf->data, le16_to_cpu(rx_buf->data_len), 0);
+
+	return 0;
+}
+
+static void ra6w_rx_mgmt(struct ra6w_cfg80211_priv *priv, struct sk_buff *skb)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct net_device *ndev = NULL;
+	struct ra6w_rx_buf *rx_buf = (struct ra6w_rx_buf *)skb->data;
+	u8 vif_idx = rx_buf->ext_hdr.vif_idx;
+	int ret;
+	int len;
+
+	if (vif_idx == RA6W_CFG80211_VIF_IDX_INVALID) {
+		u8 n = 0;
+
+		n = find_first_bit(priv->vif_map, RA6W_CFG80211_VIF_MAX);
+		if (n >= RA6W_CFG80211_VIF_MAX)
+			return;
+
+		vif_idx = n;
+	}
+
+	vif = ra6w_cfg80211_vif_get(priv, vif_idx);
+	if (!vif)
+		return;
+
+	ndev = vif->ndev;
+
+	ra6w_rx_update_stats(vif, rx_buf);
+
+	len = le16_to_cpu(rx_buf->data_len);
+	ret = ra6w_rx_mgmt_set(vif, skb);
+	if (ret) {
+		ndev->stats.rx_errors++;
+		ndev->stats.rx_dropped++;
+	} else {
+		ndev->stats.rx_packets++;
+		ndev->stats.rx_bytes += len;
+	}
+}
+
+static void ra6w_rx_sta(struct ra6w_cfg80211_priv *priv, struct sk_buff *skb)
+{
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct net_device *ndev = NULL;
+	struct ra6w_rx_buf *rx_buf = (struct ra6w_rx_buf *)skb->data;
+	int ret;
+	int len;
+
+	vif = ra6w_cfg80211_vif_get(priv, rx_buf->ext_hdr.vif_idx);
+	if (!vif) {
+		dev_kfree_skb(skb);
+		return;
+	}
+
+	ndev = vif->ndev;
+
+	skb->len = RA6W_GET_DATA_SIZE(rx_buf->ext_len, le16_to_cpu(rx_buf->data_len));
+	skb_pull(skb, rx_buf->ext_len + RA6W_BASE_HDR_SIZE);
+	skb->dev = ndev;
+	skb->priority = rx_buf->ext_hdr.priority;
+	skb->protocol = eth_type_trans(skb, skb->dev);
+
+	ra6w_rx_update_stats(vif, rx_buf);
+
+	len = skb->len;
+	ret = netif_rx(skb);
+	if (ret) {
+		ndev->stats.rx_errors++;
+		ndev->stats.rx_dropped++;
+	} else {
+		ndev->stats.rx_packets++;
+		ndev->stats.rx_bytes += len;
+	}
+}
+
+static void ra6w_rx_skb(struct ra6w_rx *rx, struct sk_buff *skb)
+{
+	struct ra6w_core *core = container_of(rx, struct ra6w_core, rx);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_rx_buf *rx_buf = (struct ra6w_rx_buf *)skb->data;
+
+	core->stats.rx.packets++;
+
+	if (rx_buf->ext_hdr.mpdu == 0) {
+		ra6w_rx_sta(priv, skb);
+		return;
+	}
+
+	ra6w_rx_mgmt(priv, skb);
+	dev_kfree_skb(skb);
+}
+
+static void ra6w_rx_worker(struct ra6w_rx *rx)
+{
+	struct sk_buff *skb = NULL;
+
+	while (!kthread_should_stop() && (skb = ra6w_q_pop(&rx->q)))
+		ra6w_rx_skb(rx, skb);
+}
+
+static int ra6w_rx_thread_handler(void *arg)
+{
+	struct ra6w_rx *rx = arg;
+	int event = 0;
+
+	while (!kthread_should_stop()) {
+		event = ra6w_q_wait(&rx->event, RA6W_RX_EVENT_MASK);
+		if (event & BIT(RA6W_RX_DATA_EVENT))
+			ra6w_rx_worker(rx);
+
+		if (event & BIT(RA6W_RX_EVENT_RESET))
+			break;
+
+		atomic_set(&rx->event.condition, 0);
+	}
+
+	return 0;
+}
+
+static int _ra6w_rx_init(struct ra6w_rx *rx, size_t rx_buf_num)
+{
+	int ret = -ENOENT;
+
+	if (rx_buf_num == 0) {
+		ra6w_err("[%s] rx queue size must be greater then zero\n", __func__);
+		return -EINVAL;
+	}
+
+	ret = ra6w_q_init(&rx->q, rx_buf_num, sizeof(struct ra6w_rx_buf *));
+	if (ret)
+		return ret;
+
+	atomic_set(&rx->event.condition, 0);
+	init_waitqueue_head(&rx->event.wait_queue);
+
+	rx->task = kthread_run(ra6w_rx_thread_handler, rx, RA6W_RX_THREAD_NAME);
+	if (!rx->task) {
+		ra6w_err("[%s] kthread_run %s failed\n", __func__, RA6W_RX_THREAD_NAME);
+		ret = -ENOENT;
+
+		goto rx_buf_free;
+	}
+
+	return 0;
+
+rx_buf_free:
+	ra6w_q_deinit(&rx->q);
+
+	return ret;
+}
+
+int ra6w_rx_init(struct ra6w_rx *rx)
+{
+	return _ra6w_rx_init(rx, RA6W_RX_BUF_Q_MAX);
+}
+
+int ra6w_rx_event_post(struct ra6w_rx *rx, struct sk_buff *skb)
+{
+	struct ra6w_core *core = container_of(rx, struct ra6w_core, rx);
+	struct ra6w_rx_buf *rx_buf = (struct ra6w_rx_buf *)skb->data;
+	int ret;
+
+	if (rx_buf->ext_len != RA6W_RX_EXT_LEN) {
+		core->stats.rx.err++;
+		return -EINVAL;
+	}
+
+	ra6w_status_set(&core->status, rx_buf->ext_hdr.status);
+
+	if (rx_buf->data_len == 0) {
+		core->stats.rx.err++;
+		return -EINVAL;
+	}
+
+	ret = ra6w_q_push(&rx->q, skb);
+	if (!ret || !ra6w_q_empty(&rx->q))
+		ra6w_q_event_set(&rx->event, BIT(RA6W_RX_DATA_EVENT));
+
+	return ret;
+}
+
+void ra6w_rx_deinit(struct ra6w_rx *rx)
+{
+	if (rx->task) {
+		atomic_set(&rx->event.condition, BIT(RA6W_RX_EVENT_RESET));
+		kthread_stop(rx->task);
+	}
+
+	ra6w_q_deinit(&rx->q);
+}
-- 
2.17.1


