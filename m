Return-Path: <linux-wireless+bounces-21664-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D27A91ED3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20F019E799D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0228C24EABC;
	Thu, 17 Apr 2025 13:54:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D724EAA4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898069; cv=none; b=LMkbhl3FTXjlg6atsO8/6KQ4qZPir4vwxL9sYsyiqeO7gDnWYsQEfPk7podpzQrw11XxzfndKFaUaq+TDu8K4YmOsDq3j2pkqOsved1ktzLf6Ao6Cv/oi0AkUJqK3YNRIxdmsMBqphG1y9x9FPNZi4elmlJFTh+vw7MhJYtZwJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898069; c=relaxed/simple;
	bh=jh8/0RPh0B4eDJn5iKI1DI3xPFh4teWxL6+cEnSCIRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=N6nmHpIa1wcVxWOaw4nKwHovoX/bYmzrkwylQI7HTjFlA7/kmQFLNYJfgXMURQ+xWkwJduvshxeb/SpcV9XzZm9bHHAspuQ6yGVz3npCNKnZIARYoQe1OcloYqC1wO1Iz8+6TnjUCH40w5Vp43tQ2UDXEx91xxJBFPTihbY971E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 76p1aJRtTVaq9MpVra/QAw==
X-CSE-MsgGUID: w2X5boaPSzSO2pRuY1rWGQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:27 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0986B400502F;
	Thu, 17 Apr 2025 22:54:23 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 24/38] ra6w: add recovery.h
Date: Thu, 17 Apr 2025 16:52:22 +0300
Message-Id: <20250417135236.52410-25-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/recovery.h | 21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/recovery.h

diff --git a/drivers/net/wireless/renesas/ra6w/recovery.h b/drivers/net/wireless/renesas/ra6w/recovery.h
new file mode 100644
index 000000000000..bffe16d6e919
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/recovery.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_RECOVERY_H
+#define RA6W_RECOVERY_H
+
+struct ra6w_recovery {
+	struct workqueue_struct *wq;
+	struct work_struct work;
+	bool in_recovery;
+};
+
+int ra6w_recovery_init(struct ra6w_recovery *recovery);
+void ra6w_recovery_deinit(struct ra6w_recovery *recovery);
+void ra6w_recovery_event_post(struct ra6w_recovery *recovery);
+void ra6w_recovery_reprobe_set(bool set);
+bool ra6w_recovery_reprobe_get(void);
+
+#endif /* RA6W_RECOVERY_H */
-- 
2.17.1


