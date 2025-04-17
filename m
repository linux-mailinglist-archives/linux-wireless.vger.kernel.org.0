Return-Path: <linux-wireless+bounces-21647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98716A91EC3
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C890464371
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743EE24EAA8;
	Thu, 17 Apr 2025 13:53:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E83424EAB6
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897999; cv=none; b=m2GvTzRI+kXVboMFsOXmkBcXidhexLndKq2YgkrVwX40v7gwrCPJKGK9wMiO6czV7LRdY/vyJXv1LOqTGinfqNqqBGSFoUK1l9uA7VJm95h8l8ZxVxo1K5p/Ck33Vl1ydsBnyowqOmJwzt/YjtBSnH9XP3cGvgM7Bxpu7DAfx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897999; c=relaxed/simple;
	bh=Dza1K45MMLZYCFpwctrzjwbv7OY5hIgEfE5LTKsNoLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TH1z47aMf+gqIAG6b8jcOazad9S50NFDPY2rqLL0UwLYDXJelHenqpj+gGAVT+kGmoCgBInOlkBbZqQgIz2mIHDDsq0zc6k09CrzqQkFrMzleBTIHq3+rpgq898xeCd3Vp2tdFWw8HGWtnfL8CmoK8j++oJdTbWfz9bvxklDvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: sr7G5/7RR8SX3adOhu32Tg==
X-CSE-MsgGUID: eLnd9bb+RBmjmDhti6GxOQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:16 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2E6C64006DE8;
	Thu, 17 Apr 2025 22:53:12 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 07/38] ra6w: add core.c
Date: Thu, 17 Apr 2025 16:52:05 +0300
Message-Id: <20250417135236.52410-8-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/core.c | 286 +++++++++++++++++++++++
 1 file changed, 286 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/core.c

diff --git a/drivers/net/wireless/renesas/ra6w/core.c b/drivers/net/wireless/renesas/ra6w/core.c
new file mode 100644
index 000000000000..5691ec6d07f9
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/core.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains the main events processing thread.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/firmware.h>
+
+#include "core.h"
+#include "if.h"
+#include "params.h"
+#include "dbg.h"
+
+#define RA6W_CORE_THREAD_NAME  "ra6w_core_thread"
+
+static inline u8 ra6w_core_cmd_to_hndl_type(u8 cmd)
+{
+	if (cmd == RA6W_CMD_DATA_RX)
+		return RA6W_CORE_HNDL_RX;
+
+	if (cmd == RA6W_CMD_DATA_STATUS_RX)
+		return RA6W_CORE_HNDL_STATUS;
+
+	if (cmd >= RA6W_CMD_COMMON_START && cmd < RA6W_CMD_COMMON_MAX)
+		return RA6W_CORE_HNDL_CTRL;
+
+	if (cmd >= RA6W_CMD_FULLMAC_START && cmd < RA6W_CMD_FULLMAC_MAX)
+		return RA6W_CORE_HNDL_CTRL;
+
+	if (cmd >= RA6W_CMD_DBG_START && cmd < RA6W_CMD_DBG_MAX)
+		return RA6W_CORE_HNDL_CTRL;
+
+	if (cmd >= RA6W_CMD_IND_FULLMAC_START && cmd < RA6W_CMD_IND_FULLMAC_MAX)
+		return RA6W_CORE_HNDL_INDI;
+
+	return RA6W_CORE_HNDL_MAX;
+}
+
+static void ra6w_core_event_handler(struct ra6w_core *core)
+{
+	struct ra6w_if *ifp = container_of(core, struct ra6w_if, core);
+	struct ra6w_status *status = &core->status;
+	struct ra6w_indi *indi = &core->indi;
+	struct ra6w_rx *rx = &core->rx;
+	int ret;
+	union ra6w_core_data *data = NULL;
+	struct sk_buff *skb = NULL;
+	u8 cmd;
+
+	do {
+		if (!skb) {
+			skb = dev_alloc_skb(sizeof(*data));
+			if (!skb)
+				return;
+
+			skb_put(skb, sizeof(*data));
+		}
+
+		ret = ra6w_if_read(ifp, skb->data, sizeof(*data));
+		if (ret)
+			break;
+
+		data = (union ra6w_core_data *)skb->data;
+		cmd = ra6w_core_cmd_to_hndl_type(data->rx.cmd);
+		switch (cmd) {
+		case RA6W_CORE_HNDL_RX:
+			ret = ra6w_rx_event_post(rx, skb);
+			if (ret == 0)
+				skb = NULL;
+			break;
+		case RA6W_CORE_HNDL_CTRL:
+			ra6w_ctrl_event_post(&core->ctrl, skb);
+			break;
+		case RA6W_CORE_HNDL_INDI:
+			ret = ra6w_indi_event_post(indi, skb);
+			if (ret == 0)
+				skb = NULL;
+			break;
+		case RA6W_CORE_HNDL_STATUS:
+			ra6w_status_event_post(&core->status, skb);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+	} while (!kthread_should_stop() && !ret && !ra6w_status_rx_get(status));
+
+	dev_kfree_skb(skb);
+}
+
+static int core_thread_handler(void *arg)
+{
+	struct ra6w_core *core = arg;
+	int event = 0;
+
+	while (!kthread_should_stop()) {
+		event = ra6w_q_wait(&core->event, RA6W_CORE_EVENT_MASK);
+		if (event & BIT(RA6W_CORE_EVENT_DATA))
+			ra6w_core_event_handler(core);
+
+		if (event & BIT(RA6W_CORE_EVENT_RESET))
+			break;
+
+		atomic_set(&core->event.condition, 0);
+	}
+
+	return 0;
+}
+
+static int ra6w_core_event_init(struct ra6w_core *core)
+{
+	atomic_set(&core->event.condition, 0);
+	init_waitqueue_head(&core->event.wait_queue);
+	core->task = kthread_run(core_thread_handler, core, RA6W_CORE_THREAD_NAME);
+	if (!core->task) {
+		ra6w_err("[%s] kthread_run %s failed\n", __func__, RA6W_CORE_THREAD_NAME);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+static void ra6w_core_event_deinit(struct ra6w_core *core)
+{
+	if (!core->task)
+		return;
+
+	atomic_set(&core->event.condition, BIT(RA6W_CORE_EVENT_RESET));
+	kthread_stop(core->task);
+	core->task =  NULL;
+}
+
+int ra6w_core_init(struct ra6w_core *core)
+{
+	int ret;
+
+	ret = ra6w_tx_init(&core->tx);
+	if (ret)
+		return ret;
+
+	ra6w_ctrl_init(&core->ctrl);
+
+	ret = ra6w_indi_init(&core->indi);
+	if (ret)
+		goto ctrl_deinit;
+
+	ret = ra6w_rx_init(&core->rx);
+	if (ret)
+		goto indi_deinit;
+
+	ra6w_status_init(&core->status);
+
+	ret = ra6w_core_event_init(core);
+	if (ret)
+		goto rx_deinit;
+
+	return 0;
+
+rx_deinit:
+	ra6w_rx_deinit(&core->rx);
+
+indi_deinit:
+	ra6w_indi_deinit(&core->indi);
+
+ctrl_deinit:
+	ra6w_tx_deinit(&core->tx);
+
+	return ret;
+}
+
+static u8 RENESAS_OUI[] = { 0xd4, 0x3d, 0x39 };
+
+static void ra6w_core_rand_mac_addr_gen(u8 *mac)
+{
+	memcpy(mac, RENESAS_OUI, 3);
+	get_random_bytes(&mac[3], 3);
+}
+
+static const u8 *ra6w_core_find_tag(const u8 *file_data, const u8 *tag_name, u32 tag_name_len)
+{
+	const char *tag_data = NULL;
+
+	if (!tag_name || tag_name_len == 0)
+		return NULL;
+
+	tag_data = strnstr(file_data, tag_name, tag_name_len);
+	if (!tag_data)
+		return NULL;
+
+	return tag_data + tag_name_len;
+}
+
+#define RA6W_CORE_DEFAULT_MAC_NAME		"default_mac.ini"
+#define RA6W_CORE_MAC_TAG			"MAC_ADDR="
+#define RA6W_CORE_MAC_TAG_LEN			strlen(RA6W_CORE_MAC_TAG)
+
+static int ra6w_core_fw_mac_addr_get(struct ra6w_core *core, u8 *mac)
+{
+	struct ra6w_if *ifp = container_of(core, struct ra6w_if, core);
+	const struct firmware *fw = NULL;
+	const u8 *fw_mac = NULL;
+	char path[100] = { 0 };
+	int ret;
+	int n;
+
+	snprintf(path, sizeof(path), "%s/%s", KBUILD_MODNAME, RA6W_CORE_DEFAULT_MAC_NAME);
+
+	ret = request_firmware(&fw, path, &ifp->dev.func->dev);
+	if (ret) {
+		ra6w_warn("request_firmware %s failed: %d\n", path, ret);
+		return -ENOENT;
+	}
+
+	if (RA6W_CORE_MAC_TAG_LEN + RA6W_MAC_ADDR_STR_LEN > fw->size) {
+		ret = -ENOENT;
+		goto free_fw;
+	}
+
+	fw_mac = ra6w_core_find_tag(fw->data, RA6W_CORE_MAC_TAG, RA6W_CORE_MAC_TAG_LEN);
+	if (!fw_mac) {
+		ra6w_warn("Tag %s not found in %s\n", RA6W_CORE_MAC_TAG, path);
+		ret = -ENOENT;
+		goto free_fw;
+	}
+
+	n = sscanf(fw_mac, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
+		   mac + 0, mac + 1, mac + 2, mac + 3, mac + 4, mac + 5);
+	if (n != ETH_ALEN || !is_valid_ether_addr(mac))
+		ret = -ENOENT;
+
+free_fw:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int ra6w_core_mac_addr_init(struct ra6w_core *core)
+{
+	u8 mac[ETH_ALEN] = { 0 };
+	int ret;
+
+	ret = ra6w_ctrl_otp_mac_addr_get(&core->ctrl, mac);
+	if (ret == 0) {
+		ra6w_info("OTP MAC Address : %pM\n", mac);
+		goto set;
+	}
+
+	ret = ra6w_core_fw_mac_addr_get(core, mac);
+	if (ret == 0) {
+		ra6w_info("FW MAC Address %pM\n", mac);
+		goto set;
+	}
+
+	ra6w_core_rand_mac_addr_gen(mac);
+	ra6w_info("Random MAC Address %pM\n", mac);
+
+set:
+	ether_addr_copy(core->sinfo.default_mac, mac);
+
+	return 0;
+}
+
+int ra6w_core_post_init(struct ra6w_core *core)
+{
+	int ret;
+	struct ra6w_ctrl *ctrl = &core->ctrl;
+
+	ret = ra6w_ctrl_dev_reset(ctrl);
+	if (ret)
+		return ret;
+
+	ret = ra6w_ctrl_update_fw_ver(ctrl);
+	if (ret)
+		return ret;
+
+	return ra6w_core_mac_addr_init(core);
+}
+
+void ra6w_core_deinit(struct ra6w_core *core)
+{
+	ra6w_core_event_deinit(core);
+	ra6w_rx_deinit(&core->rx);
+	ra6w_indi_deinit(&core->indi);
+	ra6w_tx_deinit(&core->tx);
+}
-- 
2.17.1


