Return-Path: <linux-wireless+bounces-21663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71FAA91ED8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D893175737
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE924EAAE;
	Thu, 17 Apr 2025 13:54:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D0F24EF74
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898065; cv=none; b=tPVVU+VbPt7LAmIggA6t/ODDr2Vz8tHw1jEgmWbMnAHjwuFjYmaLJBtPaNKD5EpYgd1KkJf2PfLEix/RW4tF0U3/SamusH8dXcvVAweKbkmHmv+xEyj6/5g7WlWFgpuxgqtDOkf6B2vSqntV3cV9tFVlK640h01YkhX0xQxGRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898065; c=relaxed/simple;
	bh=UMDOtzRzvuu7j3V3b7dl0F732n48pj5aVluYqrOoE+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GqAib15MkfRFvgXiOO3gwUj21/oO8vi6XqTJWSYwnZI7EmUp/tZaAGB2Y8OjGuQyH1QCx0Acg9rPnzhx+QONcfpTfncZviFwqxksFy7iQRNQFNCF+TUEkRuuCdZ8VX7J8tA4zePLP39iLt2stXTOFVmqyqkEDT80bUH19ATxBG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: PY9MFCUORWa718VErTQ2fw==
X-CSE-MsgGUID: Lh8+n+eETMCrbDzYc6ItHQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:23 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DD160400E4E9;
	Thu, 17 Apr 2025 22:54:19 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 23/38] ra6w: add recovery.c
Date: Thu, 17 Apr 2025 16:52:21 +0300
Message-Id: <20250417135236.52410-24-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/recovery.c | 87 ++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/recovery.c

diff --git a/drivers/net/wireless/renesas/ra6w/recovery.c b/drivers/net/wireless/renesas/ra6w/recovery.c
new file mode 100644
index 000000000000..5fc9a8cf42e5
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/recovery.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains recovery handler.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include "core.h"
+#include "if.h"
+#include "params.h"
+#include "dbg.h"
+#include "recovery.h"
+
+#define RA6W_RECOVERY_WQ_NAME	"ra6w_recovery_wq"
+
+static bool ra6w_recovery_reprobe;
+
+void ra6w_recovery_reprobe_set(bool set)
+{
+	ra6w_recovery_reprobe = set;
+}
+
+bool ra6w_recovery_reprobe_get(void)
+{
+	return ra6w_recovery_reprobe;
+}
+
+void ra6w_recovery_event_post(struct ra6w_recovery *recovery)
+{
+	struct ra6w_core *core = container_of(recovery, struct ra6w_core, recovery);
+
+	if (!recovery->wq)
+		return;
+
+	if (recovery->in_recovery)
+		return;
+
+	ra6w_ctrl_dev_hw_reset(&core->ctrl);
+	recovery->in_recovery = true;
+
+	queue_work(recovery->wq, &recovery->work);
+}
+
+static void ra6w_recovery_process(struct ra6w_recovery *recovery)
+{
+	struct ra6w_core *core = container_of(recovery, struct ra6w_core, recovery);
+	struct ra6w_if *ifp = container_of(core, struct ra6w_if, core);
+
+	ra6w_info("recovery start\n");
+
+	ra6w_sdio_reprobe(ifp->dev.func);
+
+	ra6w_recovery_reprobe_set(true);
+}
+
+static void ra6w_recovery_handler(struct work_struct *work)
+{
+	struct ra6w_recovery *recovery = container_of(work, struct ra6w_recovery, work);
+
+	ra6w_recovery_process(recovery);
+}
+
+int ra6w_recovery_init(struct ra6w_recovery *recovery)
+{
+	struct workqueue_struct *wq;
+
+	wq = create_singlethread_workqueue(RA6W_RECOVERY_WQ_NAME);
+	if (!wq) {
+		ra6w_err("[%s] create workqueue %s failed\n", __func__, RA6W_RECOVERY_WQ_NAME);
+		return -ENOENT;
+	}
+
+	INIT_WORK(&recovery->work, ra6w_recovery_handler);
+	recovery->wq = wq;
+
+	return 0;
+}
+
+void ra6w_recovery_deinit(struct ra6w_recovery *recovery)
+{
+	cancel_work_sync(&recovery->work);
+
+	if (recovery->wq)
+		destroy_workqueue(recovery->wq);
+
+	recovery->wq = NULL;
+}
-- 
2.17.1


