Return-Path: <linux-wireless+bounces-30778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93CD1B43C
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D35B30C40F5
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ED1314B72;
	Tue, 13 Jan 2026 20:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="KBr3SUXq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A952F0673
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336783; cv=none; b=VXGnIuYZGBPP3B7+ixjLOhJQiHOGPF2guDm3whWQ+EmGCyqhwfQhR3pAeT5SsiNVi3aL2FYdWNZtql0IiMV5p3Ma+FUKBwDDXLXYPtAFotiNqsZAMja6RpCV/9xxNC7FdL8Q0RlBbpla0rSdbvMk4w2PD2XxYhozSsL/tBLHz1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336783; c=relaxed/simple;
	bh=CNVsBXXO/o5HPHoR7hbwz3MflGPEdYCFmV4wvaJFbhY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nn9A6u7FQLJ+aedtZgRqdXAw6l19HTse5isPWg1SovBQswskx8jIjmAQrTXXQsQY5QVrSDjkH3dLl4MlZXNaQo76mkFxwLuyzOMxZwX13g24xdrlb8fahDf/WxP7RFHKoFBznxPPUCQR6Tf4AsqcIHyA+vqLAJcdkwLLONkyVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=KBr3SUXq; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336782; x=1799872782;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNVsBXXO/o5HPHoR7hbwz3MflGPEdYCFmV4wvaJFbhY=;
  b=KBr3SUXqOgK2uJ3UkK6116p0Pu0DNAYbkU4UkFhkO5Ar05zZqsEr6cxP
   o4z6/p0siq9l9HCiN44aFVzovAQHdtTpJhAutLxfxYnjbPZG//+TnfQM7
   kds/BSubO73Oz3+faCCo4YJCJ4q4OPIlVNlgrnphl5xgp2IAdWU0/+iL6
   M=;
X-CSE-ConnectionGUID: LPWooYFHSh2QUoZ+x4VNqA==
X-CSE-MsgGUID: ohood+d/S8OQBj4Et7lrXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="139542045"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="139542045"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:39:40 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:39:38 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:39:37 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 23/34] wifi: inffmac: add commonring.c/h
Date: Wed, 14 Jan 2026 02:03:36 +0530
Message-ID: <20260113203350.16734-24-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE813.infineon.com (172.23.29.39) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation of the Ring buffers used for Control and Data path
communication with the Infineon WLAN Device via the PCIe bus using a
shared memory.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../wireless/infineon/inffmac/commonring.c    | 237 ++++++++++++++++++
 .../wireless/infineon/inffmac/commonring.h    |  63 +++++
 2 files changed, 300 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/commonring.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/commonring.h

diff --git a/drivers/net/wireless/infineon/inffmac/commonring.c b/drivers/net/wireless/infineon/inffmac/commonring.c
new file mode 100644
index 000000000000..54047379b30f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/commonring.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+
+#include "utils.h"
+
+#include "main.h"
+#include "commonring.h"
+#include "debug.h"
+
+void inff_commonring_register_cb(struct inff_commonring *commonring,
+				 int (*cr_ring_bell)(void *ctx),
+				 int (*cr_update_rptr)(void *ctx),
+				 int (*cr_update_wptr)(void *ctx),
+				 int (*cr_write_rptr)(void *ctx),
+				 int (*cr_write_wptr)(void *ctx), void *ctx)
+{
+	commonring->cr_ring_bell = cr_ring_bell;
+	commonring->cr_update_rptr = cr_update_rptr;
+	commonring->cr_update_wptr = cr_update_wptr;
+	commonring->cr_write_rptr = cr_write_rptr;
+	commonring->cr_write_wptr = cr_write_wptr;
+	commonring->cr_ctx = ctx;
+}
+
+void inff_commonring_config(struct inff_commonring *commonring, u16 depth,
+			    u16 item_len, void *buf_addr)
+{
+	commonring->depth = depth;
+	commonring->item_len = item_len;
+	commonring->buf_addr = buf_addr;
+	if (!commonring->inited) {
+		spin_lock_init(&commonring->lock);
+		commonring->inited = true;
+	}
+	commonring->r_ptr = 0;
+	if (commonring->cr_write_rptr)
+		commonring->cr_write_rptr(commonring->cr_ctx);
+	commonring->w_ptr = 0;
+	if (commonring->cr_write_wptr)
+		commonring->cr_write_wptr(commonring->cr_ctx);
+	commonring->f_ptr = 0;
+}
+
+void inff_commonring_lock(struct inff_commonring *commonring)
+		__acquires(&commonring->lock)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&commonring->lock, flags);
+	commonring->flags = flags;
+}
+
+void inff_commonring_unlock(struct inff_commonring *commonring)
+		__releases(&commonring->lock)
+{
+	spin_unlock_irqrestore(&commonring->lock, commonring->flags);
+}
+
+bool inff_commonring_write_available(struct inff_commonring *commonring)
+{
+	u16 available;
+	bool retry = true;
+
+again:
+	if (commonring->r_ptr <= commonring->w_ptr)
+		available = commonring->depth - commonring->w_ptr +
+			    commonring->r_ptr;
+	else
+		available = commonring->r_ptr - commonring->w_ptr;
+
+	if (available > 1) {
+		if (!commonring->was_full)
+			return true;
+		if (available > commonring->depth / 8) {
+			commonring->was_full = false;
+			return true;
+		}
+		if (retry) {
+			if (commonring->cr_update_rptr)
+				commonring->cr_update_rptr(commonring->cr_ctx);
+			retry = false;
+			goto again;
+		}
+		return false;
+	}
+
+	if (retry) {
+		if (commonring->cr_update_rptr)
+			commonring->cr_update_rptr(commonring->cr_ctx);
+		retry = false;
+		goto again;
+	}
+
+	commonring->was_full = true;
+	return false;
+}
+
+void *inff_commonring_reserve_for_write(struct inff_commonring *commonring)
+{
+	void *ret_ptr;
+	u16 available;
+	bool retry = true;
+
+again:
+	if (commonring->cr_update_rptr)
+		commonring->cr_update_rptr(commonring->cr_ctx);
+
+	if (commonring->r_ptr <= commonring->w_ptr) {
+		if (commonring->r_ptr == commonring->w_ptr)
+			inff_dbg(MSGBUF, "r_ptr == w_ptr");
+		available = commonring->depth - commonring->w_ptr +
+			    commonring->r_ptr;
+	} else {
+		available = commonring->r_ptr - commonring->w_ptr;
+	}
+
+	if (available > 1) {
+		ret_ptr = commonring->buf_addr +
+			  (commonring->w_ptr * commonring->item_len);
+		commonring->w_ptr++;
+		if (commonring->w_ptr == commonring->depth)
+			commonring->w_ptr = 0;
+		return ret_ptr;
+	}
+
+	if (retry) {
+		retry = false;
+		goto again;
+	}
+
+	commonring->was_full = true;
+	return NULL;
+}
+
+void *
+inff_commonring_reserve_for_write_multiple(struct inff_commonring *commonring,
+					   u16 n_items, u16 *alloced)
+{
+	void *ret_ptr;
+	u16 available;
+	bool retry = true;
+
+again:
+	if (commonring->cr_update_rptr)
+		commonring->cr_update_rptr(commonring->cr_ctx);
+
+	if (commonring->r_ptr <= commonring->w_ptr) {
+		if (commonring->r_ptr == commonring->w_ptr)
+			inff_dbg(MSGBUF, "r_ptr == w_ptr");
+		available = commonring->depth - commonring->w_ptr +
+			    commonring->r_ptr;
+	} else {
+		available = commonring->r_ptr - commonring->w_ptr;
+	}
+
+	if (available > 1) {
+		ret_ptr = commonring->buf_addr +
+			  (commonring->w_ptr * commonring->item_len);
+		*alloced = min_t(u16, n_items, available - 1);
+		if (*alloced + commonring->w_ptr > commonring->depth)
+			*alloced = commonring->depth - commonring->w_ptr;
+		commonring->w_ptr += *alloced;
+		if (commonring->w_ptr == commonring->depth)
+			commonring->w_ptr = 0;
+		return ret_ptr;
+	}
+
+	if (retry) {
+		retry = false;
+		goto again;
+	}
+
+	commonring->was_full = true;
+	return NULL;
+}
+
+int inff_commonring_write_complete(struct inff_commonring *commonring)
+{
+	if (commonring->f_ptr > commonring->w_ptr)
+		commonring->f_ptr = 0;
+
+	commonring->f_ptr = commonring->w_ptr;
+
+	if (commonring->cr_write_wptr)
+		commonring->cr_write_wptr(commonring->cr_ctx);
+	if (commonring->cr_ring_bell)
+		return commonring->cr_ring_bell(commonring->cr_ctx);
+
+	return -EIO;
+}
+
+void inff_commonring_write_cancel(struct inff_commonring *commonring,
+				  u16 n_items)
+{
+	if (commonring->w_ptr == 0)
+		commonring->w_ptr = commonring->depth - n_items;
+	else
+		commonring->w_ptr -= n_items;
+}
+
+void *inff_commonring_get_read_ptr(struct inff_commonring *commonring,
+				   u16 *n_items)
+{
+	if (commonring->cr_update_wptr)
+		commonring->cr_update_wptr(commonring->cr_ctx);
+
+	*n_items = (commonring->w_ptr >= commonring->r_ptr) ?
+				(commonring->w_ptr - commonring->r_ptr) :
+				(commonring->depth - commonring->r_ptr);
+
+	if (*n_items == 0)
+		return NULL;
+
+	return commonring->buf_addr +
+	       (commonring->r_ptr * commonring->item_len);
+}
+
+int inff_commonring_read_complete(struct inff_commonring *commonring,
+				  u16 n_items)
+{
+	commonring->r_ptr += n_items;
+	if (commonring->r_ptr == commonring->depth)
+		commonring->r_ptr = 0;
+
+	if (commonring->cr_write_rptr)
+		return commonring->cr_write_rptr(commonring->cr_ctx);
+
+	return -EIO;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/commonring.h b/drivers/net/wireless/infineon/inffmac/commonring.h
new file mode 100644
index 000000000000..fc5d835344e0
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/commonring.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_COMMONRING_H
+#define INFF_COMMONRING_H
+
+struct inff_commonring {
+	u16 r_ptr;
+	u16 w_ptr;
+	u16 f_ptr;
+	u16 depth;
+	u16 item_len;
+
+	void *buf_addr;
+
+	int (*cr_ring_bell)(void *ctx);
+	int (*cr_update_rptr)(void *ctx);
+	int (*cr_update_wptr)(void *ctx);
+	int (*cr_write_rptr)(void *ctx);
+	int (*cr_write_wptr)(void *ctx);
+
+	void *cr_ctx;
+
+	spinlock_t lock; /* used to protect common ring */
+	unsigned long flags;
+	bool inited;
+	bool was_full;
+
+	atomic_t outstanding_tx;
+};
+
+void inff_commonring_register_cb(struct inff_commonring *commonring,
+				 int (*cr_ring_bell)(void *ctx),
+				 int (*cr_update_rptr)(void *ctx),
+				 int (*cr_update_wptr)(void *ctx),
+				 int (*cr_write_rptr)(void *ctx),
+				 int (*cr_write_wptr)(void *ctx), void *ctx);
+void inff_commonring_config(struct inff_commonring *commonring, u16 depth,
+			    u16 item_len, void *buf_addr);
+void inff_commonring_lock(struct inff_commonring *commonring);
+void inff_commonring_unlock(struct inff_commonring *commonring);
+bool inff_commonring_write_available(struct inff_commonring *commonring);
+void *inff_commonring_reserve_for_write(struct inff_commonring *commonring);
+void *
+inff_commonring_reserve_for_write_multiple(struct inff_commonring *commonring,
+					   u16 n_items, u16 *alloced);
+int inff_commonring_write_complete(struct inff_commonring *commonring);
+void inff_commonring_write_cancel(struct inff_commonring *commonring,
+				  u16 n_items);
+void *inff_commonring_get_read_ptr(struct inff_commonring *commonring,
+				   u16 *n_items);
+int inff_commonring_read_complete(struct inff_commonring *commonring,
+				  u16 n_items);
+
+#define inff_commonring_n_items(commonring) ((commonring)->depth)
+#define inff_commonring_len_item(commonring) ((commonring)->item_len)
+
+#endif /* INFF_COMMONRING_H */
-- 
2.25.1


