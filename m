Return-Path: <linux-wireless+bounces-21648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9682CA91EC8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 695D45A6C67
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A48D24EABB;
	Thu, 17 Apr 2025 13:53:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F7B24E4B2
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898003; cv=none; b=FP/rmB8Ybw15Te9VmBoAr55BAxUx3pTd3/vajRZj+fdWcGGFC18+jBuQ2hUosur4kDuKkiHih0xlvY/6r+zqz5DYt0MJVGYyX85N4nqDcL/zrqSB8uFQS9ygjNEVUOu//5gcGGgjSHWdz2RbiJ6VM5rua1fo9lJbwlrgi1IhpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898003; c=relaxed/simple;
	bh=tJ07C6YZyODuHeOLhuwjyJ8CF5t/NnWhjqQ5uX/6Y5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AWswLau2K6aRaB357ATyzTqSQjDjkfGyyJlrBq6KyFqLsoy1Fzug+oDH3scvWFrY9+jEZpfrHQ/+hiyZNLfD5omOPk/c3JV4NlTrmWsWozZ6j2cHGlIb2GzsOBMGxl085bYKrN6hs+Lf19k1itouZ1WYn0Dzf2ofSkyGcL2uaAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: n1TXYwYmRSiWdujinXtaYQ==
X-CSE-MsgGUID: pqrHJYwKQiC1IIlqoXToLA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:20 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5262D4006DE8;
	Thu, 17 Apr 2025 22:53:16 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 08/38] ra6w: add core.h
Date: Thu, 17 Apr 2025 16:52:06 +0300
Message-Id: <20250417135236.52410-9-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/core.h | 99 ++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/core.h

diff --git a/drivers/net/wireless/renesas/ra6w/core.h b/drivers/net/wireless/renesas/ra6w/core.h
new file mode 100644
index 000000000000..78f7102e15f6
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/core.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_CORE_H
+#define RA6W_CORE_H
+
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/completion.h>
+#include <linux/workqueue.h>
+#include <linux/netdevice.h>
+
+#include "status.h"
+#include "cmd.h"
+#include "rx.h"
+#include "tx.h"
+#include "indi.h"
+#include "ctrl.h"
+#include "sdio.h"
+#include "recovery.h"
+
+#define RA6W_BASE_HDR_SIZE			(sizeof(u8) + sizeof(u8) + sizeof(u16))
+#define RA6W_GET_DATA_SIZE(ext_len, data_len)	(RA6W_BASE_HDR_SIZE + (ext_len) + (data_len))
+
+struct ra6w_core_stat {
+	u32 packets;
+	u32 err;
+};
+
+struct ra6w_core_stats {
+	struct ra6w_core_stat tx;
+	struct ra6w_core_stat rx;
+};
+
+struct ra6w_sys_info {
+	struct ra6w_cmd_fw_ver_rsp fw_ver;
+	char fw_version[32];
+	u8 machw_support_type;
+	u8 default_mac[ETH_ALEN];
+};
+
+enum ra6w_core_data_event {
+	RA6W_CORE_EVENT_DATA,
+
+	RA6W_CORE_EVENT_DATA_MAX,
+};
+
+#define RA6W_CORE_EVENT_RESET RA6W_CORE_EVENT_DATA_MAX
+#define RA6W_CORE_EVENT_MASK (BIT(RA6W_CORE_EVENT_DATA) | BIT(RA6W_CORE_EVENT_RESET))
+
+enum ra6w_core_handler_id {
+	RA6W_CORE_HNDL_RX,
+	RA6W_CORE_HNDL_CTRL,
+	RA6W_CORE_HNDL_INDI,
+	RA6W_CORE_HNDL_STATUS,
+
+	RA6W_CORE_HNDL_MAX,
+};
+
+/*
+ * @priv: private cfg80211 data
+ * @task: main kthread task
+ * @event: main kthread event data
+ * @status: status of Tx, Rx, ctrl fw routines
+ * @ctrl: synchronous fw routine data
+ * @indi: asynchronous fw routine data
+ * @rx: Rx routine data
+ * @tx: Tx routine data
+ * @stats: Rx, Tx statistics
+ * @sinfo: fw version information
+ * @recovery: recovery data
+ */
+struct ra6w_core {
+	struct ra6w_cfg80211_priv *priv;
+	struct task_struct *task;
+	struct ra6w_q_event event;
+	struct ra6w_status status;
+	struct ra6w_ctrl ctrl;
+	struct ra6w_indi indi;
+	struct ra6w_rx rx;
+	struct ra6w_tx tx;
+	struct ra6w_core_stats stats;
+	struct ra6w_sys_info sinfo;
+	struct ra6w_recovery recovery;
+};
+
+union ra6w_core_data {
+	struct ra6w_rx_buf rx;
+	struct ra6w_indi_buf indi;
+	struct ra6w_ctrl_rsp ctrl;
+};
+
+int ra6w_core_init(struct ra6w_core *core);
+void ra6w_core_deinit(struct ra6w_core *core);
+int ra6w_core_post_init(struct ra6w_core *core);
+
+#endif /* RA6W_CORE_H */
-- 
2.17.1


