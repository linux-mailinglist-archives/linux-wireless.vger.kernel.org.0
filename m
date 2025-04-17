Return-Path: <linux-wireless+bounces-21658-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BE1A91ED2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F770464A7A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B605324EABC;
	Thu, 17 Apr 2025 13:54:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217A124EAA4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898044; cv=none; b=AGxbKvvFeQNUvtK01RmB5PB6Nt0/bKGRlmnzo94ILdrqjhWiwaDQEI6nnrmj1o72z13Pw78+MX8iKV2YYM7XvhS4eXchcAi5hqDjaUpiabiJMqPiL8D7vVtw6f8XZJWZG4ww3wM8Q3MYEleTRxLyohjyy3Nz7okdcAqAqlHLjJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898044; c=relaxed/simple;
	bh=YMaLRV2UlDXx+u6uIXARxUODfFPonUWr4uQX3CuKn9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Lvcp5Vj+2LILS0PROIJS+aftkOD9sY+CtxtyVDFgwkG5O/X+94J8f10Pd5Pj7d7R0FoiFQdqqN00MVfHyo129KGJitx1toT9djwMYLICCTyK//HMjD9evtL8yafIrv8RbatPkUJZmefVpIt7IfLk3Drnqw0aTd89oYn3mHSUE9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: j4gk3zGeSY2TI4sC62KPmw==
X-CSE-MsgGUID: COwuOctmSH6MAWcWPdtPwg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:02 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2F75F4006DE8;
	Thu, 17 Apr 2025 22:53:58 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 18/38] ra6w: add indi.h
Date: Thu, 17 Apr 2025 16:52:16 +0300
Message-Id: <20250417135236.52410-19-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/indi.h | 59 ++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/indi.h

diff --git a/drivers/net/wireless/renesas/ra6w/indi.h b/drivers/net/wireless/renesas/ra6w/indi.h
new file mode 100644
index 000000000000..ee050d086f52
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/indi.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_INDI_H
+#define RA6W_INDI_H
+
+#include <linux/kernel.h>
+#include <linux/completion.h>
+
+#include "q.h"
+
+#define RA6W_INDI_DATA_LEN	980
+#define RA6W_INDI_EXT_LEN	(sizeof(struct ra6w_indi_ext_hdr))
+#define RA6W_INDI_BUF_Q_MAX	64
+
+enum ra6w_indi_disconnect_reason {
+	RA6W_INDI_DIS_RSN_MIN = 100,
+	RA6W_INDI_DIS_RSN_BEACON_MISS = RA6W_INDI_DIS_RSN_MIN,
+	RA6W_INDI_DIS_RSN_PS_TX_MAX_ERR,
+	RA6W_INDI_DIS_RSN_CHAN_SWITCH_FAIL,
+
+	RA6W_INDI_DIS_RSN_MAX,
+	RA6W_INDI_DIS_RSN_LAST = RA6W_INDI_DIS_RSN_MAX - 1,
+};
+
+struct ra6w_indi_ext_hdr {
+	u32 status : 32;
+};
+
+struct ra6w_indi_buf {
+	u8 cmd;
+	u8 ext_len;
+	__le16 data_len;
+	struct ra6w_indi_ext_hdr ext_hdr;
+	u8 data[RA6W_INDI_DATA_LEN];
+};
+
+enum ra6w_indi_data_event {
+	RA6W_INDI_EVENT,
+	RA6W_INDI_EVENT_RESET,
+
+	RA6W_INDI_EVENT_MAX,
+};
+
+#define RA6W_INDI_EVENT_MASK (BIT(RA6W_INDI_EVENT) | BIT(RA6W_INDI_EVENT_RESET))
+
+struct ra6w_indi {
+	struct task_struct *task;
+	struct ra6w_q_event event;
+	struct ra6w_q q;
+};
+
+int ra6w_indi_init(struct ra6w_indi *indi);
+void ra6w_indi_deinit(struct ra6w_indi *indi);
+int ra6w_indi_event_post(struct ra6w_indi *indi, struct sk_buff *skb);
+
+#endif /* RA6W_INDI_H */
-- 
2.17.1


