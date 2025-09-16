Return-Path: <linux-wireless+bounces-27375-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C553DB7D9EC
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A8B1C042E4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FE2E0415;
	Tue, 16 Sep 2025 22:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="mGjc88j+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334024A06A
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061426; cv=none; b=LFCDQBAqY9KhlQFL+8lPcwL1MQwVDJjqU9U1Ucc88WyaDKHM7/VmcEl4uIyblOQOeroRInfdIfU8hjVS7MoL/GVirq0iVztsReTBDkGORRIYFeyx1ufI4ajtOJl8cx0gRh3sW+lcSJ/RtjHz3s4iWpQyVg7Hg/ZkO0uGYXt2chA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061426; c=relaxed/simple;
	bh=CR1JE8aalNTh+lxEtbO3HcY5Y6HaPvZCPjOJgGFj3sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWO8K2W525KCb4+2EIX1N7WKcpxBvFv9wZ6fIlNwPaE+jaDkgrHC6JwBc3jSwG2zXkn3WU4JfigwUZ3z2z7In1GUYS3CQkzZauYoYtoFgind5MR4qQapyGgwP4aqvHR6KgeWhtpNaXxiHkWpkQY8G9Ts+seahWG06ilY6uVGqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=mGjc88j+; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061425; x=1789597425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CR1JE8aalNTh+lxEtbO3HcY5Y6HaPvZCPjOJgGFj3sI=;
  b=mGjc88j+q86hjvP+ysNubXsqTmrNaDgc0ouhAdO5Xo84kMS/9eglFZCW
   c+GVzxIrui1RRODBbEpUryTfKTdR9WhhFgsVuYKrgYokcW/GNd76p2dWZ
   QAtUvVqBij0f00ZbiSqqzGCTVQXgAao+ADRS1WhFqYefNlDss5kk0xP0g
   s=;
X-CSE-ConnectionGUID: DMh71M5QSjCuOkfbOw86KA==
X-CSE-MsgGUID: Twd1y7efQ3SFsCxsbNC3vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99293937"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99293937"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:23:43 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:23:42 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:23:39 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 23/57] wifi: inffmac: add eht.c/h
Date: Wed, 17 Sep 2025 03:47:40 +0530
Message-ID: <20250916221821.4387-26-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation to collect the EHT capabilities of the Device and
register it to the wiphy capabilities in the cfg80211 driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/eht.c | 86 +++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/eht.h | 42 ++++++++++
 2 files changed, 128 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/eht.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/eht.h

diff --git a/drivers/net/wireless/infineon/inffmac/eht.c b/drivers/net/wireless/infineon/inffmac/eht.c
new file mode 100644
index 000000000000..78434c10713b
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/eht.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/bitfield.h>
+#include "bus.h"
+#include "chip.h"
+#include "eht.h"
+#include "feature.h"
+#include "fwil.h"
+#include "cfg80211.h"
+#include "debug.h"
+#include "xtlv.h"
+
+int
+inff_eht_mlo_get_enable(struct inff_if *ifp, u8 *param, int param_len)
+{
+	s32 ret = 0;
+
+	ret = inff_fil_xtlv_data_get(ifp, "mlo", INFF_EHT_MLO_CMD_ENAB, param, param_len);
+	if (unlikely(ret))
+		iphy_err(ifp->drvr, "failed to check if EHT MLO is enabled");
+
+	return ret;
+}
+
+void
+inff_eht_update_wiphy_cap(struct inff_if *ifp)
+{
+	struct inff_pub *drvr = ifp->drvr;
+	struct wiphy *wiphy = drvr->wiphy;
+	struct ieee80211_supported_band *band;
+	struct ieee80211_sband_iftype_data *data;
+	struct inff_bus *bus_if;
+	struct inff_chip *ci;
+	struct inff_chip_mlo_priv *chip_mlo_priv;
+	u8 eht_mlo_mode;
+	u8 i;
+	s32 ret = 0;
+
+	/* EHT MLO mode */
+	if (!inff_feat_is_enabled(ifp, INFF_FEAT_MLO))
+		return;
+	ret = inff_eht_mlo_get_enable(ifp, &eht_mlo_mode, sizeof(eht_mlo_mode));
+	if (ret || !eht_mlo_mode)
+		return;
+	bus_if = drvr->bus_if;
+	ci = bus_if->chip_pub;
+	chip_mlo_priv = &ci->chip_mlo_priv;
+
+	if (!chip_mlo_priv->get_eht_cap)
+		return;
+
+	inff_dbg(INFO, "EHT MLO Enabled\n");
+
+	/* Update HE Capab for each Band */
+	for (i = 0; i < ARRAY_SIZE(wiphy->bands); i++) {
+		band = wiphy->bands[i];
+		if (!band)
+			continue;
+
+		data = (struct ieee80211_sband_iftype_data *)band->iftype_data;
+
+		switch (band->band) {
+		case NL80211_BAND_6GHZ:
+			if (!inff_feat_is_6ghz_enabled(ifp))
+				break;
+			/* Band 6GHz supports EHT, so */
+			fallthrough;
+
+		case NL80211_BAND_5GHZ:
+			/* Band 5GHz supports EHT, so */
+			fallthrough;
+
+		case NL80211_BAND_2GHZ:
+			/* Band 2.4GHz supports EHT, so */
+			chip_mlo_priv->get_eht_cap(band, data);
+			break;
+
+		default:
+			break;
+		}
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/eht.h b/drivers/net/wireless/infineon/inffmac/eht.h
new file mode 100644
index 000000000000..a2850f1a8bfc
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/eht.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_EHT_H
+#define INFF_EHT_H
+
+#include "core.h"
+
+#define EHT_MAC_CAP_INFO_SIZE	2
+#define EHT_PHY_CAP_INFO_SIZE	9
+
+/**
+ * enum inff_eht_mlo_cmd - EHT iovar subcmds handled by firmware EHT module
+ */
+/* EHT MLO sub command IDs */
+enum inff_eht_mlo_cmd {
+	INFF_EHT_MLO_CMD_ENAB = 0,		/* enable/disable MLO feature as a whole */
+	INFF_EHT_MLO_CMD_CONFIG,		/* configure MLO feature - bsscfg specific */
+	INFF_EHT_MLO_CMD_STATUS,		/* status on MLO feature - interface specific */
+	INFF_EHT_MLO_CMD_EMLSR_CTRL,		/* emlsr control - interface specific */
+	INFF_EHT_MLO_CMD_TID_MAP,		/* configure TID-To-Link Mapping */
+	INFF_EHT_MLO_CMD_CAP,			/* capability of MLO feature as a whole */
+	INFF_EHT_MLO_CMD_ACT_LINK_BMAP,		/* Set active link for MLO TX and RX */
+	INFF_EHT_MLO_CMD_MULTILINK_ACTIVE,	/* Set use of multi links in MLO mode */
+	INFF_EHT_MLO_CMD_LINK_PS_BMAP,		/* Modify PS state of a particular link in MLO. */
+	INFF_EHT_MLO_CMD_LINK_DORMANT_BMAP,	/* Bitmap to configure dormant state for links */
+	INFF_EHT_MLO_CMD_REC_LINK_BMAP,		/* Bitmap to configure recommended links */
+	INFF_EHT_MLO_CMD_CONFIG_PREF,		/* Configure mlo mode and band preferences */
+	INFF_EHT_MLO_CMD_MAX_MLO_LINKS,		/* set/get max MLO links supported */
+	INFF_EHT_MLO_CMD_FEATURE_EN,		/* Enable/Disable a given feature */
+	INFF_EHT_MLO_CMD_NPLINK_CONFIG,		/* configure nplink op upon offchannel of plink */
+	INFF_EHT_MLO_CMD_STATS,			/* stats on MLO feature */
+	/* Add new sub command IDs here... */
+};
+
+int inff_eht_mlo_get_enable(struct inff_if *ifp, u8 *param, int param_len);
+void inff_eht_update_wiphy_cap(struct inff_if *ifp);
+
+#endif /* INFF_EHT_H */
-- 
2.25.1


