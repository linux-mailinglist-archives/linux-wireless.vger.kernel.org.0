Return-Path: <linux-wireless+bounces-21677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 170BFA91EEB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597A319E8047
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A919124FC04;
	Thu, 17 Apr 2025 13:55:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFB2250C01
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898124; cv=none; b=ViKKgh/l68OR/3siy+KiegvB+A7je8OAXs//Yn/D92LwctrDyHQBHty/75so7kMCTlE9XY4XSETxC07sgY08Ujp5Q9e0aNo2XwplLnjcL3XpMU+bxuKID3SKfA+eknSkBoo9zH0OeSQapVUuBnE06H2Ua2EUvfPKv5gnYMZRQJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898124; c=relaxed/simple;
	bh=5LE+16tyjI3K+ZRflMyYLEWaYGNlNvylTcnaqaOZsnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LPsAOw3A5lSfVRHhZ9HRNFgNQUt8FeXPA4TgTw4+jzwemk2sTRS5UfHQCz55PXRmx46k09J1AYY5coG5kKmj78t0BGDkp7HoCdF1caSgLCFmIdKWCkza7I7OQFf741BuIrXD/5HJ0TrPMqbpl64csCZ41fpgHOTc2IPY2XW6k54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: /FIV1lTiSGe5RJehBmcZaA==
X-CSE-MsgGUID: XRhT6G9BSTyrmNHQkHBKsQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:22 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A4F5740103A8;
	Thu, 17 Apr 2025 22:55:18 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 37/38] ra6w: add Makefile
Date: Thu, 17 Apr 2025 16:52:35 +0300
Message-Id: <20250417135236.52410-38-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/Makefile

diff --git a/drivers/net/wireless/renesas/ra6w/Makefile b/drivers/net/wireless/renesas/ra6w/Makefile
new file mode 100644
index 000000000000..e828a8ca1c95
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+ra6w-$(CONFIG_RA6W) += sdio.o cfg80211.o dev.o params.o \
+		       core.o q.o ctrl.o indi.o rx.o tx.o \
+		       status.o recovery.o
+
+ra6w-$(CONFIG_DEBUG_FS)		+= dbgfs.o
+ra6w-$(CONFIG_NL80211_TESTMODE)	+= stats.o
+ra6w-$(CONFIG_NL80211_TESTMODE)	+= testmode.o
+obj-$(CONFIG_RA6W)		+= ra6w.o
-- 
2.17.1


