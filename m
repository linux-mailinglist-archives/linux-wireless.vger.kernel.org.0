Return-Path: <linux-wireless+bounces-21671-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF82A91EE1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087758A2AB1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF48E24EA9C;
	Thu, 17 Apr 2025 13:54:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A2824EF74
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898098; cv=none; b=uXjOM4oPArL7gM1OPSYGakQIWPZ6mHpGADjSsndu3Rv+bpiurA4Z0Wt9aIKjU2B0FPCDE5cpvnhf4qZmkBMP5gj5sQOs0e4otkOWKUAOouGoGYNSeU5CYZAB3Pzsk8ezvVtDr+TTZwxcgyMz+xsDbM23PpWL+QmhdTeDPENFWF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898098; c=relaxed/simple;
	bh=+YyPqBC/ODomYOQ6LT83kCF0k8cSDRF6vlYjNdCO0Pk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Xt4hZuSOplzhMPhphwVVdCaD4vJK342ocB/ovfhbb4sL/ZwKGEGPmVTvsIPvWDi5OuiXR99HNR99eDyu/9X4dN23JhoYYfG5+D2vmACLwJvzAqpwX3Rc7hwjZ7351c/kBBRCPvLbUrTQzNuyoUiqbwL4s+jhXNmbXUZifEN6Fa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: DKcktOK7SJeP2MjQgKS3IQ==
X-CSE-MsgGUID: 74tP3qWbTxetLNKZ1lH5Jw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:56 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2BC0A401009B;
	Thu, 17 Apr 2025 22:54:52 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 31/38] ra6w: add status.c
Date: Thu, 17 Apr 2025 16:52:29 +0300
Message-Id: <20250417135236.52410-32-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/status.c | 117 +++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/status.c

diff --git a/drivers/net/wireless/renesas/ra6w/status.c b/drivers/net/wireless/renesas/ra6w/status.c
new file mode 100644
index 000000000000..86427b2be610
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/status.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains driver status operations.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/slab.h>
+
+#include "core.h"
+#include "if.h"
+#include "params.h"
+#include "dbg.h"
+#include "status.h"
+
+void ra6w_status_init(struct ra6w_status *status)
+{
+	spin_lock_init(&status->lock);
+}
+
+void ra6w_status_set(struct ra6w_status *status, u32 value)
+{
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&status->lock, flags);
+	*(u32 *)&status->value[0] = value;
+	spin_unlock_irqrestore(&status->lock, flags);
+}
+
+void ra6w_status_event_post(struct ra6w_status *status, const struct sk_buff *skb)
+{
+	struct ra6w_status_buf *rsp = (struct ra6w_status_buf *)skb->data;
+
+	if (rsp->ext_len == RA6W_STATUS_EXT_LEN)
+		ra6w_status_set(status, rsp->ext_hdr.status);
+}
+
+u8 ra6w_status_rx_get(struct ra6w_status *status)
+{
+	u8 ret = 0;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&status->lock, flags);
+	ret = status->value[RA6W_STATUS_BYTE_STATUS] & BIT(RA6W_STATUS_BIT_RX_EMPTY);
+	spin_unlock_irqrestore(&status->lock, flags);
+
+	return ret;
+}
+
+u8 ra6w_status_tx_get(struct ra6w_status *status, u8 ac)
+{
+	u8 ret = 0;
+	u8 value = 0;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&status->lock, flags);
+
+	value = status->value[RA6W_STATUS_BYTE_STATUS];
+
+	switch (ac) {
+	case RA6W_TX_DATA_AC:
+		ret = value & BIT(RA6W_STATUS_BIT_TX_AC_FULL);
+		break;
+	case RA6W_TX_DATA_AC_POWER:
+		ret = value & BIT(RA6W_STATUS_BIT_TX_POWER_FULL);
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&status->lock, flags);
+
+	return ret;
+}
+
+u8 ra6w_status_tx_avail_cnt_get(struct ra6w_status *status, u8 ac)
+{
+	u8 cnt = 0;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&status->lock, flags);
+
+	switch (ac) {
+	case RA6W_TX_DATA_AC:
+		cnt = status->value[RA6W_STATUS_BYTE_TX_AVAIL_CNT];
+		break;
+	case RA6W_TX_DATA_AC_POWER:
+		cnt = status->value[RA6W_STATUS_BYTE_TX_POWER_AVAIL_CNT];
+		break;
+	default:
+		break;
+	}
+
+	spin_unlock_irqrestore(&status->lock, flags);
+
+	return cnt;
+}
+
+int ra6w_status_err_code_to_errno(u8 err)
+{
+	switch (err) {
+	case RA6W_STATUS_CODE_SUCCESS: return 0;
+	case RA6W_STATUS_CODE_FAIL: return -ENOENT;
+	case RA6W_STATUS_CODE_EMPTY: return -ENODATA;
+	case RA6W_STATUS_CODE_FULL: return -EXFULL;
+	case RA6W_STATUS_CODE_INVALID_PARAM: return -EINVAL;
+	case RA6W_STATUS_CODE_NOT_FOUND: return -ENXIO;
+	case RA6W_STATUS_CODE_NO_MORE: return -ENOSPC;
+	case RA6W_STATUS_CODE_NOT_IN_USE: return -ESPIPE;
+	case RA6W_STATUS_CODE_BUSY: return -EBUSY;
+	case RA6W_STATUS_CODE_IN_PROGRESS: return -EINPROGRESS;
+	case RA6W_STATUS_CODE_MEMORY_FAIL: return -ENOMEM;
+	case RA6W_STATUS_CODE_NOT_SUPPORT: return -EOPNOTSUPP;
+	case RA6W_STATUS_CODE_EXIST: return -EEXIST;
+	default: return -EIO;
+	}
+}
-- 
2.17.1


