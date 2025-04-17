Return-Path: <linux-wireless+bounces-21675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08545A91EE2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACECD19E80F5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659D17995E;
	Thu, 17 Apr 2025 13:55:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61624EF72
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898117; cv=none; b=CZjM5EtZtznNANdFi9kDaf7VnLv4MaIqXdJdRiMs+kgZpCRe+5UVMYulyqtYjqK+ELPweo02UW3JMUFcpoeIqjtEYCabURecv8dxbvanjdZL5LR7udlteek2Q69bGl2xQXfUvs5hGCPxFaUkTuKCtZyWpnhU9mSAdDlHwb7lmqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898117; c=relaxed/simple;
	bh=qGkgTIuGh+zFjckOp/sW+fx67jShVhIKCo33yThluCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=blJkBdE/lmB4g3YlDfSKQTcYsqI79cv8NKalO49x2UK7dqIhTnkeLWDiE4mmifzvB/5s0gqchKNB5Fp3M08g8Msl0p2N6+krY9REEOzvKH/yJfSHRnoZGd0iksCk3mNxfsHUeWtJrs2QL5ZNoriaDufmt7Jcgq3UKqISHiihAw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 6uUPsCpaSRKaVeYd2JnChg==
X-CSE-MsgGUID: 7P/uwJymSmGubLvzoREnDA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:13 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 55B61401009B;
	Thu, 17 Apr 2025 22:55:09 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 35/38] ra6w: add tx.c
Date: Thu, 17 Apr 2025 16:52:33 +0300
Message-Id: <20250417135236.52410-36-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/tx.c | 254 +++++++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/tx.c

diff --git a/drivers/net/wireless/renesas/ra6w/tx.c b/drivers/net/wireless/renesas/ra6w/tx.c
new file mode 100644
index 000000000000..1023fab47a95
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/tx.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains Tx routine.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include "core.h"
+#include "if.h"
+#include "cfg80211.h"
+#include "params.h"
+#include "dbg.h"
+#include "tx.h"
+
+#define RA6W_TX_THREAD_NAME		"ra6w_tx_thread"
+#define RA6W_TX_BUFFER_THRESHOLD	4
+
+static int ra6w_tx_send(struct ra6w_tx *tx, struct sk_buff *skb)
+{
+	struct ra6w_core *core = container_of(tx, struct ra6w_core, tx);
+	struct ra6w_if *ifp = container_of(core, struct ra6w_if, core);
+	struct ra6w_cfg80211_priv *priv = core->priv;
+	struct ra6w_cfg80211_sta *sta = NULL;
+	struct ra6w_tx_buf *tx_buf = (struct ra6w_tx_buf *)skb->data;
+	int ret;
+	u32 len = 0;
+	u8 sta_idx;
+
+	sta_idx = tx_buf->ext_hdr.sta_idx;
+	if (sta_idx != RA6W_CFG80211_STA_IDX_INVALID)
+		sta = ra6w_cfg80211_sta_get(priv, sta_idx);
+
+	len = RA6W_GET_DATA_SIZE(tx_buf->ext_len, le16_to_cpu(tx_buf->data_len));
+	ret = ra6w_if_write(ifp, tx_buf, len);
+	if (ret) {
+		core->stats.tx.err++;
+		if (sta)
+			sta->stats.tx_failed++;
+
+		return ret;
+	}
+
+	core->stats.tx.packets++;
+	if (sta) {
+		sta->stats.tx_packets++;
+		sta->stats.tx_bytes += len;
+	}
+
+	return 0;
+}
+
+static void ra6w_tx_send_ac(struct ra6w_tx *tx, u8 ac)
+{
+	struct ra6w_core *core = container_of(tx, struct ra6w_core, tx);
+	struct ra6w_status *status = &core->status;
+	struct ra6w_q *q = &tx->q_ac[ac].q;
+	struct sk_buff *skb = NULL;
+	u8 tx_cnt = 0;
+	u8 tx_avail_cnt = 0;
+	u8 tx_cnt_max = 0;
+
+	tx_avail_cnt = ra6w_status_tx_avail_cnt_get(status, ac);
+	tx_cnt_max = min_t(u8, tx_avail_cnt, RA6W_TX_BUFFER_THRESHOLD);
+
+	while (!kthread_should_stop() &&
+	       !ra6w_status_tx_get(status, ac) &&
+	       tx_cnt < tx_cnt_max &&
+	       (skb = ra6w_q_pop(q))) {
+		ra6w_tx_send(tx, skb);
+		dev_kfree_skb(skb);
+		skb = NULL;
+		tx_cnt++;
+	}
+}
+
+static void ra6w_tx_reschedule(struct ra6w_tx *tx)
+{
+	struct ra6w_core *core = container_of(tx, struct ra6w_core, tx);
+	struct ra6w_status *status = &core->status;
+	int event_mask = 0;
+	u8 ac;
+
+	for (ac = RA6W_TX_DATA_AC; ac < RA6W_TX_DATA_AC_MAX; ac++) {
+		if (ra6w_q_empty(&tx->q_ac[ac].q))
+			continue;
+
+		if (ra6w_status_tx_get(status, ac))
+			continue;
+
+		event_mask |= BIT(ac);
+	}
+
+	if (event_mask)
+		ra6w_q_event_set(&tx->event, event_mask);
+}
+
+static int ra6w_tx_thread_handler(void *arg)
+{
+	struct ra6w_tx *tx = arg;
+	int event = 0;
+	u8 ac;
+
+	while (!kthread_should_stop()) {
+		event = ra6w_q_wait_timeout(&tx->event, RA6W_TX_EVENT_MASK);
+		atomic_set(&tx->event.condition, 0);
+
+		for (ac = RA6W_TX_DATA_AC; ac < RA6W_TX_DATA_AC_MAX; ac++) {
+			if (!(event & BIT(ac)))
+				continue;
+
+			ra6w_tx_send_ac(tx, ac);
+		}
+
+		if (event & BIT(RA6W_TX_EVENT_RESET))
+			break;
+
+		if (!atomic_read(&tx->event.condition))
+			ra6w_tx_reschedule(tx);
+	}
+
+	return 0;
+}
+
+int ra6w_tx_mgmt(struct ra6w_tx *tx, const struct ra6w_cfg80211_vif *vif,
+		 const struct ra6w_cfg80211_sta *sta,
+		 const struct cfg80211_mgmt_tx_params *params,
+		 u64 *cookie)
+{
+	struct sk_buff *skb = NULL;
+	struct ra6w_tx_buf *tx_buf = NULL;
+	unsigned int len;
+
+	if (!params || params->len == 0 || params->len > RA6W_CMD_DATA_SIZE || !params->buf)
+		return -EINVAL;
+
+	len = RA6W_GET_DATA_SIZE(RA6W_TX_EXT_LEN, params->len);
+
+	skb = dev_alloc_skb(len);
+	if (!skb)
+		return -ENOMEM;
+
+	skb_put(skb, len);
+	skb->priority = RA6W_CMD_AC_BK;
+
+	*cookie = (unsigned long)skb;
+
+	tx_buf = (struct ra6w_tx_buf *)skb->data;
+	memcpy(tx_buf->data, params->buf, params->len);
+
+	if (unlikely(params->n_csa_offsets > 0) &&
+	    vif->type == NL80211_IFTYPE_AP &&
+	    vif->ap.csa) {
+		int i;
+
+		for (i = 0; i < params->n_csa_offsets; i++)
+			tx_buf->data[params->csa_offsets[i]] = vif->ap.csa->count;
+	}
+
+	tx_buf->cmd = RA6W_CMD_DATA_TX;
+	tx_buf->ext_len = RA6W_TX_EXT_LEN;
+	tx_buf->ext_hdr.buf_idx = RA6W_TX_DATA_AC_POWER;
+	tx_buf->ext_hdr.tid = RA6W_CFG80211_TID_INVALID;
+	tx_buf->ext_hdr.vif_idx = vif->vif_idx;
+	tx_buf->ext_hdr.sta_idx = sta ? sta->sta_idx : RA6W_CFG80211_STA_IDX_INVALID;
+
+	tx_buf->ext_hdr.flags = RA6W_EXT_FLAGS_MGMT_BIT;
+
+	if (ieee80211_is_robust_mgmt_frame(skb))
+		tx_buf->ext_hdr.flags |= RA6W_EXT_FLAGS_MGMT_ROBUST_BIT;
+
+	if (params->no_cck)
+		tx_buf->ext_hdr.flags |= RA6W_EXT_FLAGS_MGMT_NO_CCK_BIT;
+
+	tx_buf->ext_hdr.sn = 0;
+	tx_buf->data_len = cpu_to_le16(params->len);
+
+	return ra6w_tx_event_post(tx, RA6W_TX_DATA_AC_POWER, skb);
+}
+
+int ra6w_tx_event_post(struct ra6w_tx *tx, u8 ac, struct sk_buff *skb)
+{
+	int ret;
+	struct ra6w_q *q;
+
+	if (!skb || ac >= RA6W_TX_DATA_AC_MAX)
+		return -EINVAL;
+
+	q = &tx->q_ac[ac].q;
+	ret = ra6w_q_push(q, skb);
+	ra6w_q_event_set(&tx->event, BIT(ac));
+
+	return ret;
+}
+
+static int ra6w_tx_init_ac(struct ra6w_tx_q_ac *q_ac, size_t tx_buf_num)
+{
+	if (tx_buf_num == 0) {
+		ra6w_err("[%s] AC tx queue size must be greater then zero\n", __func__);
+		return -EINVAL;
+	}
+
+	return ra6w_q_init(&q_ac->q, tx_buf_num, sizeof(struct sk_buff *));
+}
+
+static int _ra6w_tx_init(struct ra6w_tx *tx, size_t tx_buf_num, size_t tx_buf_power_num)
+{
+	int ret;
+
+	ret = ra6w_tx_init_ac(&tx->q_ac[RA6W_TX_DATA_AC], tx_buf_num);
+	if (ret)
+		return ret;
+
+	ret = ra6w_tx_init_ac(&tx->q_ac[RA6W_TX_DATA_AC_POWER], tx_buf_power_num);
+	if (ret)
+		goto tx_buf_free;
+
+	tx->event.timeout = RA6W_TX_EVENT_TIMEOUT_MS;
+	atomic_set(&tx->event.condition, 0);
+	init_waitqueue_head(&tx->event.wait_queue);
+
+	tx->task = kthread_run(ra6w_tx_thread_handler, tx, RA6W_TX_THREAD_NAME);
+	if (!tx->task) {
+		ra6w_err("[%s] kthread_run %s failed\n", __func__, RA6W_TX_THREAD_NAME);
+		goto tx_buf_power_free;
+	}
+
+	return 0;
+
+tx_buf_power_free:
+	ra6w_q_deinit(&tx->q_ac[RA6W_TX_DATA_AC_POWER].q);
+
+tx_buf_free:
+	ra6w_q_deinit(&tx->q_ac[RA6W_TX_DATA_AC].q);
+
+	return ret;
+}
+
+int ra6w_tx_init(struct ra6w_tx *tx)
+{
+	return _ra6w_tx_init(tx, RA6W_TX_BUF_Q_MAX, RA6W_TX_POWER_BUF_Q_MAX);
+}
+
+void ra6w_tx_deinit(struct ra6w_tx *tx)
+{
+	int ac;
+
+	if (tx->task) {
+		atomic_set(&tx->event.condition, BIT(RA6W_TX_EVENT_RESET));
+		kthread_stop(tx->task);
+	}
+
+	for (ac = RA6W_TX_DATA_AC; ac < RA6W_TX_DATA_AC_MAX; ac++)
+		ra6w_q_deinit(&tx->q_ac[ac].q);
+}
-- 
2.17.1


