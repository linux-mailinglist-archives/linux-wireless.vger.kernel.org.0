Return-Path: <linux-wireless+bounces-21662-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59901A91ECF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E92CE19E795C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3647E24EF68;
	Thu, 17 Apr 2025 13:54:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B624EAAE
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898061; cv=none; b=h8ddBqDzyuVY5WeToLJeHonn/MAxziujmxw17Nk1qOVskEepAo5suPNKV6+Ux7l7c8KddcU9ulJWQZOnJa2qYpGGlUsW57fWxCHEefU3DpLHlfuDZsI05ZPe1RF4VOlfcKinklGobo2EWDLJf//Za3iH4EHWAi4NIyFjBHawzZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898061; c=relaxed/simple;
	bh=NSOjeTQzrSHltDuz0G3J6cqJ6L1wwx55nF/bgrlu4EU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BgL/1KQH4Vcsx81oxsv8rOSxlFGFCUKQvfHugu7/Uz34cFxFe1XnZYBA7s/dWMeCioQBVB0a8P3lI1u9+Dkc3S7AEukuaeJs/dtH7c7SPsLvGDnURxMhJDUaUdg22Io75MXdwm9OKeNh27HYvQ1u7OH5Kj2LvauvrnXO3Ti9nXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: m35NB3JERCK0sq45yyLlqg==
X-CSE-MsgGUID: DMu9qfs7Si6kkMXp1EJs6g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:19 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id BB54D400E4E9;
	Thu, 17 Apr 2025 22:54:15 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 22/38] ra6w: add q.h
Date: Thu, 17 Apr 2025 16:52:20 +0300
Message-Id: <20250417135236.52410-23-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/q.h | 39 +++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/q.h

diff --git a/drivers/net/wireless/renesas/ra6w/q.h b/drivers/net/wireless/renesas/ra6w/q.h
new file mode 100644
index 000000000000..5f8a165ae84d
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/q.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_Q_H
+#define RA6W_Q_H
+
+#include <linux/kernel.h>
+#include <linux/circ_buf.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/completion.h>
+
+struct ra6w_q {
+	size_t max_count;
+	unsigned long head;
+	unsigned long tail;
+	spinlock_t lock;
+	void **buf;
+};
+
+struct ra6w_q_event {
+	atomic_t condition;
+	wait_queue_head_t wait_queue;
+	u32 timeout;
+};
+
+int ra6w_q_init(struct ra6w_q *q, size_t max_count, size_t buf_size);
+bool ra6w_q_empty(struct ra6w_q *q);
+int ra6w_q_push(struct ra6w_q *q, void *buf);
+void *ra6w_q_pop(struct ra6w_q *q);
+void ra6w_q_event_set(struct ra6w_q_event *event, int event_val);
+bool ra6w_q_event_condition(const struct ra6w_q_event *event, int event_mask, int *ret_event);
+int ra6w_q_wait(struct ra6w_q_event *event, int event_mask);
+int ra6w_q_wait_timeout(struct ra6w_q_event *event, int event_mask);
+void ra6w_q_deinit(struct ra6w_q *q);
+
+#endif /* RA6W_Q_H */
-- 
2.17.1


