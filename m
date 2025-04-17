Return-Path: <linux-wireless+bounces-21653-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA22A91ECA
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02B128A189B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157BE24EAA4;
	Thu, 17 Apr 2025 13:53:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3421B24E4B2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898025; cv=none; b=Jdt4LsIQZIevCIT53lwt5vjau9P6f5tRF6iDXr1i53B/h9G3hiMw1kKZ0vY2Ke8OzO45EDg6U4kAI+kTg+Dy2lLZt5aQCb3KDC9rshWnPVywTStRfc2412pX7pLJhBQigRL2fexcy8vwjlBbQohxBhQilY2bswbDZLjOibuL3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898025; c=relaxed/simple;
	bh=Opz41BGZewPIpVabg+NF9R5vbdf8F5RfrOqzj06Vwh4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=DaVy1CQoE4nXLFa9a3VVMPlG4moI2SpFR5FRgI0SeMfRMdsVVT9xm4GiWo1tNh0bXiopKZgdXNaTzpE0GSZn4jgWvpzYz/QWAHFa44Kw+KMiufY4CMjFMCTS/KWAK+WngOOq7ZEGqjYbEO6BQEGshjjRfScpsAECVW3Dzq/OZys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 81XVeJjmQ4idgdhakHUmOA==
X-CSE-MsgGUID: iJg//Z0AS4uXqwERfG1Vpw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:41 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6B0394006DE8;
	Thu, 17 Apr 2025 22:53:38 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 13/38] ra6w: add dbgfs.h
Date: Thu, 17 Apr 2025 16:52:11 +0300
Message-Id: <20250417135236.52410-14-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/dbgfs.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/dbgfs.h

diff --git a/drivers/net/wireless/renesas/ra6w/dbgfs.h b/drivers/net/wireless/renesas/ra6w/dbgfs.h
new file mode 100644
index 000000000000..50e11ac3c8c9
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/dbgfs.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_DBGFS_H
+#define RA6W_DBGFS_H
+
+#ifdef CONFIG_DEBUG_FS
+void ra6w_dbgfs_register(struct ra6w_cfg80211_priv *priv);
+void ra6w_dbgfs_deregister(struct ra6w_cfg80211_priv *priv);
+#else
+static inline void ra6w_dbgfs_register(struct ra6w_cfg80211_priv *priv)
+{
+}
+
+static inline void ra6w_dbgfs_deregister(struct ra6w_cfg80211_priv *priv)
+{
+}
+#endif /* CONFIG_DEBUG_FS */
+
+#endif /* RA6W_DBGFS_H */
-- 
2.17.1


