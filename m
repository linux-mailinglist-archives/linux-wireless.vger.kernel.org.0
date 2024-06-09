Return-Path: <linux-wireless+bounces-8731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FE49017AD
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE228453C
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7384D8B4;
	Sun,  9 Jun 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Wzy7dMNm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE47603F;
	Sun,  9 Jun 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957381; cv=none; b=Oq5CwOxZgMHkITt4y5zoMgxF12UAq7A5Qq/e0X7EltVVvYThMP6qAWqs6m98dwgGx55htMB2dMB7GEm0vsw4UfPEj61je7F5MuksEWZ7+fnU9+iPpyTmNfd77SYcw1WW8bcDj2s+uqwrHmmcagQh0HEJ8oRZG0zBjzIi4VOmvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957381; c=relaxed/simple;
	bh=i8K3Ux3Z/cBupX2WMMCK5fZqPW621c1mS4TOzZjAAWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+YSDgBvCg1te7OZRt4R0oPxUPCM22Byf0h9uCMku9870VCNum0wfjJAbs4XfO35ROGxgSrM/JOKRgz9PbC38kYE5xLH7ITok76dx1fsmxqArrl1JzKjg3DbgrFAyw0yktXDptYJrpL+wtI/ajG4gawwpcuHc5g0XV+94TF7P5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Wzy7dMNm; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMpvT075158;
	Sun, 9 Jun 2024 13:22:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957371;
	bh=YKpb1uxx/sJKyGxHuWsphCI/VgLTO2hem/+/azo+pdE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Wzy7dMNmyPBtiNn85Lh9eb9PGSouacVQeWms1E6PiPF3x5z6NWOM5BdJQBDK4VYvw
	 MKUJX81gU2EaUxJh3ZVSC+qiFTCYMIRLzCU5PX5MI05A5lyTaB/XB/fce8nj1fsKUd
	 vY+tFxO1dBHk0Yp1RHg4VLBoIF7XzG7DiVRa7nr8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMpKn053617
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:51 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:51 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMoBo067823;
	Sun, 9 Jun 2024 13:22:50 -0500
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
Subject: [PATCH v2 14/17] wifi: cc33xx: Add ps.c, ps.h
Date: Sun, 9 Jun 2024 21:20:59 +0300
Message-ID: <20240609182102.2950457-15-michael.nemanov@ti.com>
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

80211 power-save modes are handled automictically by HW but
can be overridden here.
---
 drivers/net/wireless/ti/cc33xx/ps.c | 117 ++++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.h |  16 ++++
 2 files changed, 133 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.h

diff --git a/drivers/net/wireless/ti/cc33xx/ps.c b/drivers/net/wireless/ti/cc33xx/ps.c
new file mode 100644
index 000000000000..e708ef8d5f46
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/ps.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "ps.h"
+#include "tx.h"
+#include "debug.h"
+
+int cc33xx_ps_set_mode(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		       enum cc33xx_cmd_ps_mode_e mode)
+{
+	int ret;
+	u16 timeout = cc->conf.host_conf.conn.dynamic_ps_timeout;
+
+	switch (mode) {
+	case STATION_AUTO_PS_MODE:
+	case STATION_POWER_SAVE_MODE:
+		cc33xx_debug(DEBUG_PSM, "entering psm (mode=%d,timeout=%u)",
+			     mode, timeout);
+
+		ret = cc33xx_cmd_ps_mode(cc, wlvif, mode, timeout);
+		if (ret < 0)
+			return ret;
+
+		set_bit(WLVIF_FLAG_IN_PS, &wlvif->flags);
+		break;
+
+	case STATION_ACTIVE_MODE:
+		cc33xx_debug(DEBUG_PSM, "leaving psm");
+
+		ret = cc33xx_cmd_ps_mode(cc, wlvif, mode, 0);
+		if (ret < 0)
+			return ret;
+
+		clear_bit(WLVIF_FLAG_IN_PS, &wlvif->flags);
+		break;
+
+	default:
+		cc33xx_warning("trying to set ps to unsupported mode %d", mode);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static void cc33xx_ps_filter_frames(struct cc33xx *cc, u8 hlid)
+{
+	int i;
+	struct sk_buff *skb;
+	struct ieee80211_tx_info *info;
+	unsigned long flags;
+	int filtered[NUM_TX_QUEUES];
+	struct cc33xx_link *lnk = &cc->links[hlid];
+
+	/* filter all frames currently in the low level queues for this hlid */
+	for (i = 0; i < NUM_TX_QUEUES; i++) {
+		filtered[i] = 0;
+		while ((skb = skb_dequeue(&lnk->tx_queue[i]))) {
+			filtered[i]++;
+
+			if (WARN_ON(cc33xx_is_dummy_packet(cc, skb)))
+				continue;
+
+			info = IEEE80211_SKB_CB(skb);
+			info->flags |= IEEE80211_TX_STAT_TX_FILTERED;
+			info->status.rates[0].idx = -1;
+			ieee80211_tx_status_ni(cc->hw, skb);
+		}
+	}
+
+	spin_lock_irqsave(&cc->cc_lock, flags);
+	for (i = 0; i < NUM_TX_QUEUES; i++) {
+		cc->tx_queue_count[i] -= filtered[i];
+		if (lnk->wlvif)
+			lnk->wlvif->tx_queue_count[i] -= filtered[i];
+	}
+
+	spin_unlock_irqrestore(&cc->cc_lock, flags);
+	cc33xx_handle_tx_low_watermark(cc);
+}
+
+void cc33xx_ps_link_start(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  u8 hlid, bool clean_queues)
+{
+	struct ieee80211_sta *sta;
+	struct ieee80211_vif *vif = cc33xx_wlvif_to_vif(wlvif);
+
+	if (WARN_ON_ONCE(wlvif->bss_type != BSS_TYPE_AP_BSS))
+		return;
+
+	if (!test_bit(hlid, wlvif->ap.sta_hlid_map) ||
+	    test_bit(hlid, &cc->ap_ps_map))
+		return;
+
+	cc33xx_debug(DEBUG_PSM,
+		     "start mac80211 PSM on hlid %d pkts %d clean_queues %d",
+		     hlid, cc->links[hlid].allocated_pkts, clean_queues);
+
+	rcu_read_lock();
+	sta = ieee80211_find_sta(vif, cc->links[hlid].addr);
+	if (!sta) {
+		cc33xx_error("could not find sta %pM for starting ps",
+			     cc->links[hlid].addr);
+		rcu_read_unlock();
+		return;
+	}
+
+	ieee80211_sta_ps_transition_ni(sta, true);
+	rcu_read_unlock();
+
+	/* do we want to filter all frames from this link's queues? */
+	if (clean_queues)
+		cc33xx_ps_filter_frames(cc, hlid);
+
+	__set_bit(hlid, &cc->ap_ps_map);
+}
diff --git a/drivers/net/wireless/ti/cc33xx/ps.h b/drivers/net/wireless/ti/cc33xx/ps.h
new file mode 100644
index 000000000000..47f65b684b52
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/ps.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __PS_H__
+#define __PS_H__
+
+#include "acx.h"
+
+int cc33xx_ps_set_mode(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		       enum cc33xx_cmd_ps_mode_e mode);
+void cc33xx_ps_link_start(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  u8 hlid, bool clean_queues);
+
+#endif /* __PS_H__ */
-- 
2.25.1


