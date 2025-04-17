Return-Path: <linux-wireless+bounces-21666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FE2A91ED5
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A623719E7A7F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0DB24EF7C;
	Thu, 17 Apr 2025 13:54:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B64324EF68
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898078; cv=none; b=NCTIz01JIO5Al4zbHnTb7Ekh+GNLAZXFh0acAYnEWgpqhbGuOCA/hg5Q2od/cIf88R2MawoBgehi/RD5WR8AS+khdO0D1uSK+o9EQKG7Z+fDaS9F0CZ4CjHe6zSMNhYqClSqHCZImjGQcmWj/e84JPkEnWFmrMqXFojr+ikExck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898078; c=relaxed/simple;
	bh=0XKVgpu8jNkoQSoN0pPT9F308cU1ywVApeYhChk4NDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=k9/Mc4itLF0CwExXY9qCXZT/+h53Fc3cNhhq+ohaGivWN/mDqrt3/5GN6gCCXIUN8R+VKTE3mVrIKAq00XAWelIvtV974AlaArKch52fez4mr4q0jVi10WjBPFj9YZD+O5MIp4U67b/r8RI9XoBzAP5JUndX9oQ7YFNrIiCgcAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: 0AoczfFCSd6x9Z/aVSHsBg==
X-CSE-MsgGUID: IM3ez+KcQM6SO6j3zVWP1A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:35 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 521AC401009B;
	Thu, 17 Apr 2025 22:54:31 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 26/38] ra6w: add rx.h
Date: Thu, 17 Apr 2025 16:52:24 +0300
Message-Id: <20250417135236.52410-27-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/rx.h | 105 +++++++++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/rx.h

diff --git a/drivers/net/wireless/renesas/ra6w/rx.h b/drivers/net/wireless/renesas/ra6w/rx.h
new file mode 100644
index 000000000000..10ee61b3ed6f
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/rx.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_RX_H
+#define RA6W_RX_H
+
+#include <linux/bitops.h>
+
+#include "q.h"
+
+#define RA6W_RX_EXT_LEN	(sizeof(struct ra6w_rx_ext_hdr))
+#define RA6W_RX_BUF_Q_MAX	64
+
+enum ra6w_rx_ext_hdr_flags {
+	RA6W_EXT_FLAGS_MGMT_BIT = BIT(1),
+	RA6W_EXT_FLAGS_MGMT_NO_CCK_BIT = BIT(2),
+	RA6W_EXT_FLAGS_AMSDU_BIT = BIT(3),
+	RA6W_EXT_FLAGS_MGMT_ROBUST_BIT = BIT(4),
+	RA6W_EXT_FLAGS_4ADDR_BIT = BIT(5),
+	RA6W_EXT_FLAGS_EOSP_BIT = BIT(6),
+	RA6W_EXT_FLAGS_MESH_FWD_BIT = BIT(7),
+	RA6W_EXT_FLAGS_TDLS_BIT = BIT(8),
+	RA6W_EXT_FLAGS_SN_BIT = BIT(9)
+};
+
+struct ra6w_rx_ext_ht {
+	u16 short_gi : 1;
+	u16 mcs : 7;
+	u16 num_extn_ss : 2;
+	u16 reserved : 6;
+};
+
+struct ra6w_rx_ext_vht {
+	u16 short_gi : 1;
+	u16 mcs : 7;
+	u16 nss : 3;
+	u16 reserved : 5;
+};
+
+struct ra6w_rx_ext_he {
+	u16 ru_size : 3;
+	u16 mcs : 7;
+	u16 nss : 3;
+	u16 gi_type : 2;
+	u16 dcm : 1;
+};
+
+struct ra6w_rx_ext_hdr {
+	u32 status : 32;
+	u32 amsdu : 1;
+	u32 mpdu : 1;
+	u32 addr_4 : 1;
+	u32 mesh_peer_new : 1;
+	u32 priority : 3;
+	u32 vif_idx : 8;
+	u32 sta_idx : 8;
+	u32 dest_sta_idx : 8;
+	u32 ch_bw : 2;
+	u32 rssi1 : 8;
+	u32 band : 4;
+	u32 channel_type : 8;
+	u32 prim20_freq : 16;
+	u32 center1_freq : 16;
+	u32 center2_freq : 16;
+	u32 format_mod : 4;
+	u32 pre_type : 1;
+	u32 leg_rate : 4;
+
+	union {
+		struct ra6w_rx_ext_ht ht;
+		struct ra6w_rx_ext_vht vht;
+		struct ra6w_rx_ext_he he;
+	};
+};
+
+struct ra6w_rx_buf {
+	u8 cmd;
+	u8 ext_len;
+	__le16 data_len;
+	struct ra6w_rx_ext_hdr ext_hdr;
+	u8 data[RA6W_CMD_DATA_SIZE];
+};
+
+enum ra6w_rx_data_event {
+	RA6W_RX_DATA_EVENT,
+
+	RA6W_RX_DATA_EVENT_MAX,
+};
+
+#define RA6W_RX_EVENT_RESET	RA6W_RX_DATA_EVENT_MAX
+#define RA6W_RX_EVENT_MASK	(BIT(RA6W_RX_DATA_EVENT) | BIT(RA6W_RX_EVENT_RESET))
+
+struct ra6w_rx {
+	struct task_struct *task;
+	struct ra6w_q_event event;
+	struct ra6w_q q;
+};
+
+int ra6w_rx_init(struct ra6w_rx *rx);
+void ra6w_rx_deinit(struct ra6w_rx *rx);
+int ra6w_rx_event_post(struct ra6w_rx *rx, struct sk_buff *skb);
+
+#endif /* RA6W_RX_H */
-- 
2.17.1


