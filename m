Return-Path: <linux-wireless+bounces-21656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F26A91ED1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D25498A21EC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF6524EF78;
	Thu, 17 Apr 2025 13:53:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B73324EF6A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898036; cv=none; b=QLr68YvCMMyIMhZcpaSHvGnQT7iPbBPKyGRgxetbh9pBQXdoFuz5M1Xe5E09ULuntz7x81l2/y6ye+sRMoHuhty0ILxRijVKfGCOYrHL8pEM+PasTdvapMGEtdaGF97mHJbNypwSjI5rirV1Ndytkl2tdhl0Fsk0iOKHS63XWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898036; c=relaxed/simple;
	bh=4O/s4m3lOto2Ap8nDH6mV+g/IQN9iN+/H0DrV2Wtjw8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VkRwvFScImwktFeWr+Gsei2L07XxWKFawa+UX3V1KEvgwHNrAyww1AIFgq9lsZnEtSJMxm5QnE9IihKrDgsuZ8y6bLBatSzd3rEFLLyKT2bIXUTnqihZOSa2NfRt5DbM4aOJhSBrtOTDXSt2JtCVJJwPI9BL/BOiR2sKiqoba4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: xclw8bDpSvaLGOpvB4nFMg==
X-CSE-MsgGUID: 8lYi64GtQHyvQC3pUW3ICA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:54 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D80464005025;
	Thu, 17 Apr 2025 22:53:50 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 16/38] ra6w: add if.h
Date: Thu, 17 Apr 2025 16:52:14 +0300
Message-Id: <20250417135236.52410-17-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/if.h | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/if.h

diff --git a/drivers/net/wireless/renesas/ra6w/if.h b/drivers/net/wireless/renesas/ra6w/if.h
new file mode 100644
index 000000000000..35fc7d2865d4
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/if.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_IF_H
+#define RA6W_IF_H
+
+struct ra6w_if_ops {
+	int (*read)(struct sdio_func *func, void *data, int len);
+	int (*write)(struct sdio_func *func, void *data, int len);
+};
+
+struct ra6w_if_dev {
+	struct sdio_func *func;
+	bool dev_on_resume;
+};
+
+struct ra6w_if {
+	struct ra6w_core core;
+	struct ra6w_if_dev dev;
+	const struct ra6w_if_ops *ops;
+};
+
+static inline int ra6w_if_read(struct ra6w_if *ifp, void *buf, int len)
+{
+	if (ifp->core.recovery.in_recovery)
+		return -EINPROGRESS;
+
+	return ifp->ops->read(ifp->dev.func, buf, len);
+}
+
+static inline int ra6w_if_write(struct ra6w_if *ifp, void *buf, int len)
+{
+	if (ifp->core.recovery.in_recovery)
+		return -EINPROGRESS;
+
+	return ifp->ops->write(ifp->dev.func, buf, len);
+}
+
+#endif /* RA6W_IF_H */
-- 
2.17.1


