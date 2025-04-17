Return-Path: <linux-wireless+bounces-21676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2240A91EE3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ABCE19E8186
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA06724FC03;
	Thu, 17 Apr 2025 13:55:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFC5250BF1
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898119; cv=none; b=XaNfmdsseToF9woTz19KEUXVpV3WUDqstxdrqyrOh2OjlrF73F7WpYCIAUmJvZD+yKsODlZTcC+OQ6s7TCPYcw/Ed0I9kXqNbDvKePEXujl7kYEvxMagkssdGFeo/+y1U5DPjtJPYxkjPisLYFvlK0O2Xktef9MsmFDj6gWkCHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898119; c=relaxed/simple;
	bh=31NH0et9RAe2gDQ31TIsRvUnTSYSaDHQ/G8scXU+RUE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EZw5BDqR2vvunNjlbtyYz7x/wN2Ed5Jjmjk8OgqHztTbdIreNjNWSPcKYaDM3IGNr15r1+Rtzp4Mps06cBCi5Ri8KO+rqsunE4ryPTt4HsD5kt8CECXYsvxIbnjGOmagYaNkAhZP47GgiSArE5vNq4NVQC3sRHNTEF0QI57HdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: ZJEW6XKmQWOfqIPPs03Z4A==
X-CSE-MsgGUID: ugTnYJXpTfyPPSCKaolA4Q==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:17 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 76CD240103A8;
	Thu, 17 Apr 2025 22:55:14 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 36/38] ra6w: add tx.h
Date: Thu, 17 Apr 2025 16:52:34 +0300
Message-Id: <20250417135236.52410-37-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/tx.h | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/tx.h

diff --git a/drivers/net/wireless/renesas/ra6w/tx.h b/drivers/net/wireless/renesas/ra6w/tx.h
new file mode 100644
index 000000000000..3020946468af
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/tx.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_TX_H
+#define RA6W_TX_H
+
+#include <net/cfg80211.h>
+
+#include "q.h"
+
+#define RA6W_TX_EXT_LEN		(sizeof(struct ra6w_tx_ext_hdr))
+#define RA6W_TX_BUF_Q_MAX	128
+#define RA6W_TX_POWER_BUF_Q_MAX	32
+
+enum ra6w_tx_data_ac {
+	RA6W_TX_DATA_AC,
+	RA6W_TX_DATA_AC_POWER,
+
+	RA6W_TX_DATA_AC_MAX,
+};
+
+#define RA6W_TX_EVENT_RESET	RA6W_TX_DATA_AC_MAX
+#define RA6W_TX_EVENT_MASK	(BIT(RA6W_TX_DATA_AC) | \
+				BIT(RA6W_TX_DATA_AC_POWER) | \
+				BIT(RA6W_TX_EVENT_RESET))
+
+#define RA6W_TX_EVENT_TIMEOUT_MS 100
+
+struct ra6w_tx_ext_hdr {
+	u32 buf_idx : 3;
+	u32 tid : 5;
+	u32 vif_idx : 8;
+	u32 sta_idx : 8;
+	u32 flags : 10;
+	u32 sn : 24;
+};
+
+struct ra6w_tx_buf {
+	u8 cmd;
+	u8 ext_len;
+	__le16 data_len;
+	struct ra6w_tx_ext_hdr ext_hdr;
+	u8 data[RA6W_CMD_DATA_SIZE];
+};
+
+struct ra6w_tx_q_ac {
+	struct ra6w_q q;
+};
+
+struct ra6w_tx {
+	struct task_struct *task;
+	struct ra6w_q_event event;
+	struct ra6w_tx_q_ac q_ac[RA6W_TX_DATA_AC_MAX];
+};
+
+struct ra6w_cfg80211_vif;
+struct ra6w_cfg80211_sta;
+
+int ra6w_tx_init(struct ra6w_tx *tx);
+void ra6w_tx_deinit(struct ra6w_tx *tx);
+int ra6w_tx_event_post(struct ra6w_tx *tx, u8 ac, struct sk_buff *skb);
+int ra6w_tx_mgmt(struct ra6w_tx *tx, const struct ra6w_cfg80211_vif *vif,
+		 const struct ra6w_cfg80211_sta *sta,
+		 const struct cfg80211_mgmt_tx_params *params,
+		 u64 *cookie);
+
+#endif /* RA6W_TX_H */
-- 
2.17.1


