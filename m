Return-Path: <linux-wireless+bounces-7561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A609C8C37F2
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D613281363
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423C954F8D;
	Sun, 12 May 2024 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JfQmRd98"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8411F54BF4
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538841; cv=none; b=BlpCTrYHT1f9OGEPjW40ZW7LlvMgTgIeZNmgfDmrO6wDzsFa+tWBTRjbqpSwOv7AwyI0dB6iuIrdqQwWd8cE6Gt2TTmBOdZYBfP+eTqcyAW7ajFm9tE5XHdMEgFz2OFePrrKDOpDBckBrJkwpwOH1BAt1Lq/PxPp86AwHOb4GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538841; c=relaxed/simple;
	bh=ylaNEk531dAyUVCHKFQORYHipFciRfW+YC7usSyyeNw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8eUdcxNoBophGv34SkIwe9Q1Sk9E2VllhtKAu8HLYP+xd1rPLl+GOnZlo7Ev4uTEiTr8oi/ffM5wmOVkGsH/c5/fSswginJ63imEH+aLWIJ/b3BVemcJAk+r1BCNLcrPz8BkbDtoRB/8Y+4gXEV9I4BlnVxDfS61uSP04T8Nc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JfQmRd98; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXu8V006175;
	Sun, 12 May 2024 13:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538836;
	bh=Hyjs0M18n/jpGUGawrzIyPk8VTLjxHGp8wb9dXrUUQM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JfQmRd98O7WKWe151Go199Z6bJdVv6qgk06BfT2lPE288RS4+96uiBCVQJRoXuiKV
	 L9jP8D1zPMPZfd8/5G56GnolFDGFIFZ3+pAU6UDw5Vu46ZTocqCqoc5s7MVQNPfeuC
	 VK+tpePr6EqN9Wr+7ZWaQO0w/Cb9LUKo7KAVA9RA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXuRr029173
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:56 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:55 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:55 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXsbh074885;
	Sun, 12 May 2024 13:33:55 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <Michael.Nemanov@ti.com>,
        Michael
 Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 15/17] Add ps.c, ps.h
Date: Sun, 12 May 2024 21:32:45 +0300
Message-ID: <20240512183247.2190242-16-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
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

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/ps.c | 116 ++++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.h |  15 ++++
 2 files changed, 131 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.h

diff --git a/drivers/net/wireless/ti/cc33xx/ps.c b/drivers/net/wireless/ti/cc33xx/ps.c
new file mode 100644
index 000000000000..7f3d70577606
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/ps.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
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
index 000000000000..d20160ef4f34
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/ps.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
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


