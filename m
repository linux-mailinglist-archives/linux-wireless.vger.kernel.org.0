Return-Path: <linux-wireless+bounces-21643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B092FA91EC2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AC53AC573
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FF124EA9F;
	Thu, 17 Apr 2025 13:53:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D01424E4CB
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897981; cv=none; b=TmLIi/c+CRulOUnj/1/tWnoikjKlCHq5KG6HKqCk4w4DJThO/bEXb3g/lb+I16gcLGsmzeTdvdirwDgRYNQ73smtHXM9/83UTEWCvhVH2apyzXRPmjQIZwY7c0xVSV/u4p1MHCcxlA5rEUGNC3IdAiz4Ah1WvxxzI+a8kPb+ZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897981; c=relaxed/simple;
	bh=BDMdGtwaLvScDAFZXwtsqejy1APdeoAS+JH5eKXTI5c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KUHjSS0v0KZUT7CvYkFrBmMAlUt1vbiMdhJ4znfAtSr+SF6Sr1GGZPHy6mGMSaEGgWgaRugHRxO3H4opFTpZEXxI3/pq35YM9JL0SHbh4AE2Q6tjHQvE/Rvn6pMbZ7FzLcobjo/t+j4i00YTU4xGuvnfO5tu9ncvkAk93jBQXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: D90U0r4uRaC0O9vdPt6PGw==
X-CSE-MsgGUID: wqsJqDkaRuiUDbGWHU3FmQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:52:56 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 42F144005B3F;
	Thu, 17 Apr 2025 22:52:52 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 03/38] renesas: add Makefile
Date: Thu, 17 Apr 2025 16:52:01 +0300
Message-Id: <20250417135236.52410-4-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/Makefile | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/Makefile

diff --git a/drivers/net/wireless/renesas/Makefile b/drivers/net/wireless/renesas/Makefile
new file mode 100644
index 000000000000..a8253bcc7d02
--- /dev/null
+++ b/drivers/net/wireless/renesas/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_RA6W) += ra6w/
-- 
2.17.1


