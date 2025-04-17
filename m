Return-Path: <linux-wireless+bounces-21669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7479A91EDE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94D3F8A29F4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DC624EF90;
	Thu, 17 Apr 2025 13:54:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A724EF65
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898090; cv=none; b=F4PW5Nf2fEF16hN60JHPQU97tMzIZZuakrMQlVt3Xb1gwr6QMaFwDW1E1HXSfKaNnDSst0ONyjYeQ5L7MziKEPgivKhP9lloiw+S17FHMMM2lbEFBZKzwhkj3PJAxkJssRS4QOASQD/hgM269TNA15Ub8kK3o17nijEDXiOD4ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898090; c=relaxed/simple;
	bh=xsGy+CsTNezAQ4ZpyUr/x2RHI7fB+scq/QNYJxp4cAI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WzF5SRx103HtbVtIz3rShyuYPvDPwR6dEWrOfFx4lTKUaTej/TaQEjkw+5QpNNi3zaIVnQPb6VrNeqgLGYkKVJoM/MBOwIRBnWE8ZSCDD7w1HaX5SYaWQWhDjGCZDpnVcMsYYMrCO1f8woU4/eopCrNEUaE3p9i1k1DEib1NxIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: arPeOXFyRF6Qqppt3yjC3Q==
X-CSE-MsgGUID: l3S3cntbSWeNWeqDKTGQLw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:48 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BF38940103A8;
	Thu, 17 Apr 2025 22:54:44 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 29/38] ra6w: add stats.c
Date: Thu, 17 Apr 2025 16:52:27 +0300
Message-Id: <20250417135236.52410-30-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/stats.c | 94 +++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/stats.c

diff --git a/drivers/net/wireless/renesas/ra6w/stats.c b/drivers/net/wireless/renesas/ra6w/stats.c
new file mode 100644
index 000000000000..59f431b3f158
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/stats.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains statistics routine.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include "cfg80211.h"
+#include "stats.h"
+
+void ra6w_stats_rx_update(struct ra6w_stats *stats,
+			  const struct ra6w_cfg80211_sta_stats *sta_stats)
+{
+	struct ra6w_stats_rx *rx_stats = stats->rx_stats;
+	const struct ra6w_rx_ext_hdr *last_rx = &sta_stats->last_rx_data_ext;
+
+	if (!stats->stats_enabled || !rx_stats)
+		return;
+
+	rx_stats->format_mode = last_rx->format_mod;
+
+	switch (last_rx->format_mod) {
+	case RA6W_CFG80211_FORMATMOD_NON_HT:
+		rx_stats->flags |= RA6W_STATS_RX_OFDM_BIT;
+		rx_stats->non_ht.ofdm++;
+		fallthrough;
+	case RA6W_CFG80211_FORMATMOD_NON_HT_DUP_OFDM:
+		rx_stats->flags |= RA6W_STATS_RX_CCK_BIT;
+		rx_stats->non_ht.cck++;
+		rx_stats->non_ht.bw = last_rx->ch_bw;
+		break;
+	case RA6W_CFG80211_FORMATMOD_HT_MF:
+	case RA6W_CFG80211_FORMATMOD_HT_GF:
+		rx_stats->flags |= RA6W_STATS_RX_HT_BIT;
+		rx_stats->ht.bw = last_rx->ch_bw & 0x1;
+		rx_stats->ht.nss = last_rx->ht.num_extn_ss & 0x3;
+		rx_stats->ht.mcs = last_rx->ht.mcs & 0x7;
+		rx_stats->ht.gi = last_rx->ht.short_gi & 0x1;
+		rx_stats->ht.ht[rx_stats->ht.gi][rx_stats->ht.mcs]++;
+		break;
+	case RA6W_CFG80211_FORMATMOD_VHT:
+		rx_stats->flags |= RA6W_STATS_RX_VHT_BIT;
+		rx_stats->vht.bw = last_rx->ch_bw;
+		rx_stats->vht.nss = last_rx->vht.nss;
+		rx_stats->vht.mcs = last_rx->vht.mcs;
+		rx_stats->vht.gi = last_rx->vht.short_gi & 0x1;
+		rx_stats->vht.vht[rx_stats->vht.gi][rx_stats->vht.mcs]++;
+		break;
+	case RA6W_CFG80211_FORMATMOD_HE_MU:
+	case RA6W_CFG80211_FORMATMOD_HE_SU:
+	case RA6W_CFG80211_FORMATMOD_HE_ER:
+	case RA6W_CFG80211_FORMATMOD_HE_TB:
+		rx_stats->flags |= RA6W_STATS_RX_HE_SU_BIT;
+		rx_stats->he_su.mcs = last_rx->he.mcs;
+		rx_stats->he_su.nss = last_rx->he.nss;
+		rx_stats->he_su.gi = last_rx->he.gi_type;
+		rx_stats->he_su.he[rx_stats->he_su.gi][rx_stats->he_su.mcs]++;
+		break;
+	default:
+		break;
+	}
+}
+
+int ra6w_stats_init(struct ra6w_stats *stats)
+{
+	struct ra6w_stats_rx *rx_stats = NULL;
+
+	if (stats->stats_enabled)
+		return 0;
+
+	rx_stats = kzalloc(sizeof(*rx_stats), GFP_KERNEL);
+	if (!rx_stats)
+		return -ENOMEM;
+
+	stats->rx_stats = rx_stats;
+	stats->stats_enabled = true;
+
+	return 0;
+}
+
+void ra6w_stats_deinit(struct ra6w_stats *stats)
+{
+	struct ra6w_cfg80211_vif *vif =  container_of(stats, struct ra6w_cfg80211_vif, stats);
+	struct ra6w_cfg80211_priv *priv = vif->priv;
+
+	if (!stats->stats_enabled)
+		return;
+
+	ra6w_ctrl_stats_tx_start_req(&priv->core->ctrl, RA6W_STATS_TX_STOP_BIT);
+
+	stats->stats_enabled = false;
+	kfree(stats->rx_stats);
+	stats->rx_stats = NULL;
+}
-- 
2.17.1


