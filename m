Return-Path: <linux-wireless+bounces-27387-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47779B7D783
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EF1B7B606E
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F681C5486;
	Tue, 16 Sep 2025 22:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="m0e6jR7/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AEE30C620
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061572; cv=none; b=fLbFp9OXdN2dcLnbrONZlhiVI4ijuDWlJbjxlhBUSAqpQmwCS7ixypVTMYXZ1aU7JsPf7hfvepGsXf1NlzdI9YO3J2EYypiBCL5A7L73+smczw/dhNTLYRawTP5xKYFi7SjL0ea9/F3Egof3QI3QL/CUDHhzuY6puqRiB8KPMoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061572; c=relaxed/simple;
	bh=60rbPLR6iOjJarooopX+iN9wy52ulYx87Yft/jhQBsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eap8mWNN1n6vyvJXWoJKjXs+Q8fp9OdPaCv5X3pGvlLY0mDcBXshpsRoJoYVro1gWTq5cZgseiUoWM/BvAuayGDNaJ6wxLiNdInZ+F8Sg3+piuCGOPCwN2txuW2q0wOplxqq5pP8txVGqzxxGgTtHAnSJEznR9w6uHpVBgQxvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=m0e6jR7/; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061570; x=1789597570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60rbPLR6iOjJarooopX+iN9wy52ulYx87Yft/jhQBsA=;
  b=m0e6jR7/fjb7hWGyYjzmcx4Fnsehfq8sEVakYFtLqlZ/TlqbvmDB0UmM
   gn3esFbzEzenwCUWsVGQA8P0mPqeMRWqdJqeYPZkm1RekT0OHDuxVkV4w
   AvQuHl7Pf7fabbv9XxI1XmjVrykF3+dNsOgR03EP5k5WDUYFJn5E7Qyw9
   E=;
X-CSE-ConnectionGUID: HXPdOGjvThukHtlaZN/i5g==
X-CSE-MsgGUID: 9Bo+8LkPRseiFXUE3KOTSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="125093671"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="125093671"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:26:08 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:26:08 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:26:05 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 32/57] wifi: inffmac: add commonring.c/h
Date: Wed, 17 Sep 2025 03:47:52 +0530
Message-ID: <20250916221821.4387-38-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
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
index 000000000000..16cccdba186e
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/commonring.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+
+#include "utils.h"
+
+#include "core.h"
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
index 000000000000..6e40b2b07486
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/commonring.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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


