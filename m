Return-Path: <linux-wireless+bounces-21678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C05A91EED
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A1619E8391
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE624EF82;
	Thu, 17 Apr 2025 13:55:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7596024EF6D
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898127; cv=none; b=iyn4jV2F1VPK5n2R6c5bCoHOarDlJStR0YGQjvQCPEUDokZQrxUL6/TyyIgkv6/b3VNvDl/Ei5MK5hbK92xF9BqT4QN1+bW28o+f0IGm2B1Y5hNsskzILbYRzLqQCVW3gAn7i0nUcZsufVW4OhH2l4TRoCM9xx7Bu7L5aTQh0BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898127; c=relaxed/simple;
	bh=IPo7jDqI6XbpqGyVrtjredTl/bL6IIEv1D0mztFgZOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=a1IR/pbXv/U4VOX2kC9tzy8XWZWzG+QOO7kh+fqAPqcn10Xr/wAqRwxRH3awFS0MZ6OeGOlE9PSonoP00YXCCh/xMfm/bQofO7Sf8euBIxh1/57GUEWXfz8caZFUTSegr5I7fFMUTlMZSeTgue6a1X+JVBlisZ2w/h75GYFai4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 7kv0lfjQSROFsR9aD23CmQ==
X-CSE-MsgGUID: 1CYehWLCSqO28JZlqpNDXQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:26 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D814D401009B;
	Thu, 17 Apr 2025 22:55:22 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 38/38] ra6w: add Kconfig
Date: Thu, 17 Apr 2025 16:52:36 +0300
Message-Id: <20250417135236.52410-39-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/Kconfig

diff --git a/drivers/net/wireless/renesas/ra6w/Kconfig b/drivers/net/wireless/renesas/ra6w/Kconfig
new file mode 100644
index 000000000000..d23b5a5ef469
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config RA6W
+	tristate "Renesas 802.11ax wireless chips support"
+	depends on CFG80211 && MMC
+	help
+	  This module adds support for wireless adapters based on
+	  Renesas RA6W IEEE 802.11ax (Dual-band Wi-Fi6) family of chipsets.
+	  Select M (recommended), if you have a wireless module.
-- 
2.17.1


