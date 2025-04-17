Return-Path: <linux-wireless+bounces-21642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00646A91EBF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51F0E3A8742
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1D24E4CB;
	Thu, 17 Apr 2025 13:52:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8306C24EAA0
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897977; cv=none; b=c3ry3APXiLiNwLYDJpgzEFlm5jmOZNHC7vQCkuO0C+9ln2gEKf88Cv5dKHRnxsaU/XCv7y4CHM74prfFGGToRe6zfO9FsCKQcM/9wGZfxf6gy3FxGMyT9oJKPM225G686F53n/+OgRUMa6ctTOTiisq323e/gKEry0Za25DpfTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897977; c=relaxed/simple;
	bh=pDYvL20GbbhHQPz4Z0NeeVhtoq8nKSHSUt1jkOx+ieY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=U8wl+/bFrpu+ZOvXlphuYAQXpbZ3h8QHSagmGQqHboIY34ny94BNfL/T6N316UMRpr9RonOs7bQADOsHrHto/cW+RFJqMf22v2IpM7Vbr6j/dBS5zsdsRV3rszvozaLp3RNamUZ7NVIJAEWSv8hLchKfIoMVb1mQClxbPyi20WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: /dW/BvinTO6GufxkkztNbA==
X-CSE-MsgGUID: 8npkbcg3SnyEiUw827lyoA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:52:52 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 16DB04006DE8;
	Thu, 17 Apr 2025 22:52:48 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 02/38] renesas: add Kconfig
Date: Thu, 17 Apr 2025 16:52:00 +0300
Message-Id: <20250417135236.52410-3-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/Kconfig | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/Kconfig

diff --git a/drivers/net/wireless/renesas/Kconfig b/drivers/net/wireless/renesas/Kconfig
new file mode 100644
index 000000000000..9607b36b3d8c
--- /dev/null
+++ b/drivers/net/wireless/renesas/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config WLAN_VENDOR_RENESAS
+	bool "Renesas devices"
+	default y
+	help
+	  If you have a wireless card belonging to this class, say Y.
+
+if WLAN_VENDOR_RENESAS
+
+source "drivers/net/wireless/renesas/ra6w/Kconfig"
+
+endif # WLAN_VENDOR_RENESAS
-- 
2.17.1


