Return-Path: <linux-wireless+bounces-21670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BA1A91EDF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 694AD8A2E63
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DF024EAAE;
	Thu, 17 Apr 2025 13:54:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8097624EA9C
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898094; cv=none; b=bmdRdSSrA9Ung9U8UStrJu6UnKyjGdI9aWTU15xuWmdU7tTcHVzCdJmFOTWkFBhYMrbUMCB4js1oemLHAS19cBxzJmB+gFITrLnhGkx1J8D2+HVeeSMvhaeuOc+C2rzrRj8AeCYcxke80/aGpSb12UDj/MdSHFACFhfYosv+iEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898094; c=relaxed/simple;
	bh=Z91kGV9gdbQ/5EAiACcYSnbvvRe9vnRkY0c8b91p5aM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=XOlpitXWYiOb2apWJ2+Vvj75o7DVmjYYy3rQRCa/BqV7G9OWCsk/rKNRIfTh3wZEtwmbp3x4JGadmaUyGibCsnT8d6/X/UobT0KP1sD3ipopTfTBFAybSophl1KoDTCBsPqZ7PdOMkG6JGg/gEKQ9xiVq5a/EXrzO02sTRmoSAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: PwBmrmkyRpiTD8CChsf7EA==
X-CSE-MsgGUID: 34EwP5IjQXaOfn0nWY6xig==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:52 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E09AD40103D5;
	Thu, 17 Apr 2025 22:54:48 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 30/38] ra6w: add stats.h
Date: Thu, 17 Apr 2025 16:52:28 +0300
Message-Id: <20250417135236.52410-31-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/stats.h | 100 ++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/stats.h

diff --git a/drivers/net/wireless/renesas/ra6w/stats.h b/drivers/net/wireless/renesas/ra6w/stats.h
new file mode 100644
index 000000000000..06e870f6ae0f
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/stats.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_STATS_H
+#define RA6W_STATS_H
+
+#define RA6W_MCS_MAX_HT		8
+#define RA6W_MCS_MAX_VHT	9
+#define RA6W_MCS_MAX_HE		12
+#define RA6W_GI_MAX_HT		2
+#define RA6W_GI_MAX_VHT		2
+#define RA6W_GI_MAX_HE		3
+
+enum ra6w_stats_bits {
+	RA6W_STATS_RX_CCK_BIT = BIT(0),
+	RA6W_STATS_RX_OFDM_BIT = BIT(1),
+	RA6W_STATS_RX_HT_BIT = BIT(2),
+	RA6W_STATS_RX_VHT_BIT = BIT(3),
+	RA6W_STATS_RX_HE_SU_BIT = BIT(4),
+	RA6W_STATS_RX_HE_MU_BIT = BIT(5),
+	RA6W_STATS_RX_HE_EXT_BIT = BIT(6),
+	RA6W_STATS_RX_HE_TRIGFLAG_LONG_BIT = BIT(7)
+};
+
+enum ra6w_stats_status {
+	RA6W_STATS_STATUS_DISABLED,
+	RA6W_STATS_STATUS_ENABLED,
+
+	RA6W_STATS_STATUS_MAX
+};
+
+struct ra6w_stats_non_ht {
+	u8 bw;
+	u64 ofdm;
+	u64 cck;
+};
+
+struct ra6w_stats_rx {
+	u8 format_mode;
+	u8 flags;
+	struct ra6w_stats_non_ht non_ht;
+	struct {
+		u8 bw;
+		u8 mcs;
+		u8 gi;
+		u8 nss;
+		u64 ht[RA6W_GI_MAX_HT][RA6W_MCS_MAX_HT];
+	} ht;
+	struct {
+		u8 bw;
+		u8 mcs;
+		u8 gi;
+		u8 nss;
+		u64 vht[RA6W_GI_MAX_VHT][RA6W_MCS_MAX_VHT];
+	} vht;
+	struct {
+		u8 bw;
+		u8 mcs;
+		u8 gi;
+		u8 nss;
+		u64 he[RA6W_GI_MAX_HE][RA6W_MCS_MAX_HE];
+	} he_su;
+};
+
+struct ra6w_stats {
+	struct ra6w_stats_rx *rx_stats;
+	bool stats_enabled;
+};
+
+struct ra6w_cfg80211_sta_stats;
+
+#ifdef CONFIG_NL80211_TESTMODE
+
+int ra6w_stats_init(struct ra6w_stats *stats);
+void ra6w_stats_deinit(struct ra6w_stats *stats);
+void ra6w_stats_rx_update(struct ra6w_stats *stats,
+			  const struct ra6w_cfg80211_sta_stats *sta_stats);
+
+#else
+
+static inline int ra6w_stats_init(struct ra6w_stats *stats)
+{
+	return 0;
+}
+
+static inline void ra6w_stats_deinit(struct ra6w_stats *stats)
+{
+}
+
+static inline
+void ra6w_stats_rx_update(struct ra6w_stats *stats,
+			  const struct ra6w_cfg80211_sta_stats *sta_stats)
+{
+}
+
+#endif /* CONFIG_NL80211_TESTMODE */
+
+#endif /* RA6W_STATS_H */
-- 
2.17.1


