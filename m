Return-Path: <linux-wireless+bounces-21651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11515A91EC5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9B919E78DE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8177924E4B2;
	Thu, 17 Apr 2025 13:53:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27E524EAB2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898015; cv=none; b=F1Gnq1o2O5FOaQUEFvC57xPKUKsUkIrMQ+m0hEdgyLigXDx0FGkH4vEh/NHlirenSbqAvfy0+QLJBsWBhzD+G6qxSnWk1TacSsav+JcxnW5I+exMmCf5pygPadW00tlH73B2A+hnkn8upYcOgc79t7xzEL1jWYFJmY/DRd2Uwv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898015; c=relaxed/simple;
	bh=Hhqbf6WuIpUwwc9U0dK/HrZDmRqQNDISvk4adE+ma+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dNH8BpGRiZZk5dy2gZT9II9TG4Txbm4X4FkXOsSGpbPQRmOFd4WxcZl2TbYqiZEmp4UDnw82d2eNXF8YpP3WmdQvigfgRa+mJjGtkalO4rRp9gKJjxpoHFKJ3uHie9vULSa5mNxBefFvHdzJlnrL1WwiWkH8+0vP2fo/xIZHeZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: oSW8//BFSCuL00gYsDfu6A==
X-CSE-MsgGUID: hq/bHy+rQbuTY11BwnsuAA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:33 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 275384006DE8;
	Thu, 17 Apr 2025 22:53:29 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 11/38] ra6w: add dbg.h
Date: Thu, 17 Apr 2025 16:52:09 +0300
Message-Id: <20250417135236.52410-12-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/dbg.h | 47 +++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/dbg.h

diff --git a/drivers/net/wireless/renesas/ra6w/dbg.h b/drivers/net/wireless/renesas/ra6w/dbg.h
new file mode 100644
index 000000000000..2609f4d4003d
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/dbg.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_DBG_H
+#define RA6W_DBG_H
+
+#include <linux/types.h>
+#include <linux/printk.h>
+
+enum ra6w_dbg_level {
+	RA6W_DBG_LVL_OFF,
+	RA6W_DBG_LVL_ERROR,
+	RA6W_DBG_LVL_WARN,
+	RA6W_DBG_LVL_INFO,
+	RA6W_DBG_LVL_DEBUG,
+	RA6W_DBG_LVL_TRACE,
+	RA6W_DBG_LVL_VERBOSE,
+
+	RA6W_DBG_LVL_MAX,
+	RA6W_DBG_LVL_LAST = RA6W_DBG_LVL_MAX - 1
+};
+
+#define RA6W_DEFAULT_LOG_LVL	RA6W_DBG_LVL_INFO
+
+#define RA6W_PRINT(level, type, fmt, arg...)			\
+do {								\
+	if ((level) <= ra6w_params_log_level())			\
+		pr_##type("%s" fmt, THIS_MODULE->name, ##arg);	\
+} while (0)
+
+#define ra6w_err(fmt, arg...)	RA6W_PRINT(RA6W_DBG_LVL_ERROR, err, " E: " fmt, ##arg)
+#define ra6w_warn(fmt, arg...)	RA6W_PRINT(RA6W_DBG_LVL_WARN, warn, " W: " fmt, ##arg)
+#define ra6w_info(fmt, arg...)	RA6W_PRINT(RA6W_DBG_LVL_INFO, info, " I: " fmt, ##arg)
+#define ra6w_trace(fmt, arg...)	RA6W_PRINT(RA6W_DBG_LVL_TRACE, debug, " T: " fmt, ##arg)
+#define ra6w_dbg(fmt, arg...)	RA6W_PRINT(RA6W_DBG_LVL_DEBUG, debug, " D: " fmt, ##arg)
+
+#define RA6W_SET_DBG_LEVEL(level)					\
+do {									\
+	if ((level) >= RA6W_DBG_LVL_OFF && level <= RA6W_DBG_LVL_LAST)	\
+		ra6w_params_log_level_set(level);			\
+} while (0)
+
+#define RA6W_MAC_ADDR_STR_LEN	sizeof("xx:xx:xx:xx:xx:xx")
+
+#endif /* RA6W_DBG_H */
-- 
2.17.1


