Return-Path: <linux-wireless+bounces-14669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98189B50A0
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD09D1C225AA
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC1320A5E4;
	Tue, 29 Oct 2024 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kC1BJ+Kz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732A1209F32;
	Tue, 29 Oct 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222692; cv=none; b=m9w498F8o2zNO9a+FVctxkh62xCDOGoewfKMQCLya1DepSYgX1OKqkH32KzEMDjiQANa4ezdAc4xy9MK7UlJE4YGW2i3wi3M0HJCDfzeAWNImT7UrNE3fVo/sb7IDDBh3jZ2NX3yu+m6LB3sItH2Es3+8A0WIOza/wOPFBrBcRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222692; c=relaxed/simple;
	bh=6cHKr+wfiiogbejYnMLD0LdbcbGA4BDdEeUn2O+K3O0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDBuzh6fArfRzw1H3/cl3eFSc2L1PZ0UC3OJMy4XirrVKyyOMLqwA6yyXYjtPzRA+TMa7GH6muDIVgDu1h38mjpR2F2NgpkeM/aBXzG7SuGe56/wv0XCEqI7DZtdlFgGdQodmxcpusL+UyDvi4kM7ymPkPD5w1+LMJq+KstI4k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kC1BJ+Kz; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49THOhYj027151;
	Tue, 29 Oct 2024 12:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730222683;
	bh=3kC/T8kYABRP+bgBGlTrGCzGjj2W0s1hDujCc4snWHk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kC1BJ+KzCrS1fG4BnTQxBiz2b4J15UNOq9+t3E0xB613QoMArAlyCOBuaf0pgFWuL
	 CeegzC5qeviSr28T/7jAbvvlFWhSQThNFybZ//e8K+ZXbfru5m/V7vd0FSLDWitSlL
	 nu2TsKg30cyFrqksfCHPLB55/Rdz9TU3wweoaEMo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49THOhhV022430
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 12:24:43 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 12:24:43 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 12:24:43 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49THOgMu065872;
	Tue, 29 Oct 2024 12:24:42 -0500
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v4 15/17] wifi: cc33xx: Add ps.c, ps.h
Date: Tue, 29 Oct 2024 19:23:52 +0200
Message-ID: <20241029172354.4027886-16-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029172354.4027886-1-michael.nemanov@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

80211 power-save modes are handled automictically by HW but
can be overridden here.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/ps.c | 108 ++++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/ps.h |  16 +++++
 2 files changed, 124 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/ps.h

diff --git a/drivers/net/wireless/ti/cc33xx/ps.c b/drivers/net/wireless/ti/cc33xx/ps.c
new file mode 100644
index 000000000000..768f1f2fc3f1
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/ps.c
@@ -0,0 +1,108 @@
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
+		ret = cc33xx_cmd_ps_mode(cc, wlvif, mode, timeout);
+		if (ret < 0)
+			return ret;
+
+		set_bit(WLVIF_FLAG_IN_PS, &wlvif->flags);
+		break;
+
+	case STATION_ACTIVE_MODE:
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
2.34.1


