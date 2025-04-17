Return-Path: <linux-wireless+bounces-21661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54AAA91ED7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A788C1714D6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A85D24EABC;
	Thu, 17 Apr 2025 13:54:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744D24EF6A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898057; cv=none; b=Zr4ZsZmlekCRcWgy3qZNOkzNXsSBq0lgWBDzxVx8j3I5ln2Oi5hT4bM3LOC8JKhdNsD/kd96kelbRa5vTlTXGgnhGqgToQhp7dsooBsL6xEErqUk8PG24a8rTCBx9Rr1gyJoBMHTY7O3ZQ1P7nHTZ1ZFAFdtbjoAP7HskNlLOwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898057; c=relaxed/simple;
	bh=ZGE2x5odtT5fIcXumSEK7h+Mjw/eESosf6vPg8T/BvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qgZ/u/9qu5FTaPx6w8xMbV56xg/ywhXo+n+1jS81CwIIH4wlHllmsobmbyYPXG5q5yqMat24hDSIHGwDP+DRrJct6LNYyY7ebbFemDykdG973bv8gl61ZBiR7eUQjZwIXiNYysS3FOy21IDrHTz8Ns3qrPFpQv4fO26gwlw9mVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 8+joch4rQaeVqVWOL7SO/Q==
X-CSE-MsgGUID: w1XTj++sSoWoU9JFW6+5Pg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:15 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 9BDBB400E4E9;
	Thu, 17 Apr 2025 22:54:11 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 21/38] ra6w: add q.c
Date: Thu, 17 Apr 2025 16:52:19 +0300
Message-Id: <20250417135236.52410-22-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/q.c | 134 ++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/q.c

diff --git a/drivers/net/wireless/renesas/ra6w/q.c b/drivers/net/wireless/renesas/ra6w/q.c
new file mode 100644
index 000000000000..74f1c3a8421b
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/q.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains queue API.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include "q.h"
+
+bool ra6w_q_empty(struct ra6w_q *q)
+{
+	unsigned long flags = 0;
+	bool empty = 0;
+
+	spin_lock_irqsave(&q->lock, flags);
+	empty = (CIRC_CNT(q->head, q->tail, q->max_count) == 0);
+	spin_unlock_irqrestore(&q->lock, flags);
+
+	return empty;
+}
+
+int ra6w_q_push(struct ra6w_q *q, void *buf)
+{
+	int ret = -ENOENT;
+	unsigned long head;
+	unsigned long tail;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&q->lock, flags);
+
+	head = q->head;
+	tail = READ_ONCE(q->tail);
+
+	if (CIRC_SPACE(head, tail, q->max_count) >= 1) {
+		q->buf[head] = buf;
+		WRITE_ONCE(q->head, (head + 1) & (q->max_count - 1));
+		ret = 0;
+	}
+
+	spin_unlock_irqrestore(&q->lock, flags);
+
+	return ret;
+}
+
+void *ra6w_q_pop(struct ra6w_q *q)
+{
+	void *buf = NULL;
+	unsigned long head;
+	unsigned long tail;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&q->lock, flags);
+
+	head = READ_ONCE(q->head);
+	tail = q->tail;
+
+	if (CIRC_CNT(head, tail, q->max_count) >= 1) {
+		buf = q->buf[tail];
+		WRITE_ONCE(q->tail, (tail + 1) & (q->max_count - 1));
+	}
+
+	spin_unlock_irqrestore(&q->lock, flags);
+
+	return buf;
+}
+
+bool ra6w_q_event_condition(const struct ra6w_q_event *event, int event_mask, int *ret_event)
+{
+	*ret_event = atomic_read(&event->condition);
+
+	return *ret_event & event_mask;
+}
+
+void ra6w_q_event_set(struct ra6w_q_event *event, int event_val)
+{
+	atomic_or(event_val, &event->condition);
+	wake_up_interruptible(&event->wait_queue);
+}
+
+int ra6w_q_wait(struct ra6w_q_event *event, int event_mask)
+{
+	int ret_event = 0;
+
+	wait_event_interruptible(event->wait_queue,
+				 ra6w_q_event_condition(event, event_mask, &ret_event));
+
+	return ret_event;
+}
+
+int ra6w_q_wait_timeout(struct ra6w_q_event *event, int event_mask)
+{
+	int ret_event = 0;
+
+	wait_event_interruptible_timeout(event->wait_queue,
+					 ra6w_q_event_condition(event, event_mask, &ret_event),
+					 msecs_to_jiffies(event->timeout));
+
+	return ret_event;
+}
+
+int ra6w_q_init(struct ra6w_q *q, size_t max_count, size_t buf_size)
+{
+	q->head = 0;
+	q->tail = 0;
+	q->max_count = max_count;
+	spin_lock_init(&q->lock);
+
+	q->buf = kcalloc(max_count, buf_size, GFP_KERNEL);
+	if (!q->buf)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void ra6w_q_free(struct ra6w_q *q)
+{
+	void *buf = NULL;
+
+	while ((buf = ra6w_q_pop(q)))
+		kfree(buf);
+}
+
+void ra6w_q_deinit(struct ra6w_q *q)
+{
+	ra6w_q_free(q);
+	kfree(q->buf);
+	q->head = 0;
+	q->tail = 0;
+	q->max_count = 0;
+	q->buf = NULL;
+}
-- 
2.17.1


