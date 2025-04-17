Return-Path: <linux-wireless+bounces-21655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A83AA91ED0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E278A203D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0655824EF98;
	Thu, 17 Apr 2025 13:53:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210E24EF6A
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898031; cv=none; b=NikFBH76aeFPjPw6Vxeyht4DTa2kzkU52FM5gzpHqU0oJHnKzjJE/wtZUydazTAVgeP1IsEefoXaRzVzDylI5jKO3so0wSMjoJP+DbxZ90VpMrkf4tdWE4R5vnk8YXkQE3iMm8djRSvNh5SagSdK9qCF6Hpao63TyPMGIu5c55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898031; c=relaxed/simple;
	bh=yoStUonIwss4GitjHnZNS3wYTfDdCHe67D6TnWuBz0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qZn6arPUOgMo+x8yG2pKBw/+4U9IykiU0eyMoBvpL5qxUhkwp6y2rOrPtBNVvZHKaL7drjnKIXNoJmoEgQuhXxsn+cEJBF3WrB2uALvb/htfKOeB1MQ5S4yGzx9ykLy6Cxb6dUQo1/GsgfQqMqBxI+jTLbDdobPhGU45rC274j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: HLyQN8KxS/OiqgXykdUyhQ==
X-CSE-MsgGUID: DrDJ/mU7QOCj6n7L+WlGFA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:50 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id AD8A44005025;
	Thu, 17 Apr 2025 22:53:46 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 15/38] ra6w: add dev.h
Date: Thu, 17 Apr 2025 16:52:13 +0300
Message-Id: <20250417135236.52410-16-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/dev.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/dev.h

diff --git a/drivers/net/wireless/renesas/ra6w/dev.h b/drivers/net/wireless/renesas/ra6w/dev.h
new file mode 100644
index 000000000000..792f0193fe59
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/dev.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_DEV_H
+#define RA6W_DEV_H
+
+#include <linux/netdevice.h>
+#include <linux/skbuff.h>
+
+void ra6w_dev_init(struct net_device *ndev);
+void ra6w_dev_set_ops(struct net_device *ndev);
+void ra6w_dev_set_monitor_ops(struct net_device *ndev);
+
+#endif /* RA6W_DEV_H */
-- 
2.17.1


