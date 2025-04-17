Return-Path: <linux-wireless+bounces-21672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867EA91EDD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A03F7B23D0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6CD24EAAE;
	Thu, 17 Apr 2025 13:55:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C82C24EF6B
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898103; cv=none; b=Rt54ChP6kZzRvWGprrQdZqWaKoc51pEgT3VUhy2Zi0EwXz86OvZOj+HCgOO0gt7KWH5rEAHibB3QjDGonCtBruVUAenFiXi/pJl0pcUo17mVr2s2fgRapX4FJpMIz+6XDdo2doheMPewts+M1yOx06YqWcJRs4p01TnK25i42/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898103; c=relaxed/simple;
	bh=RMviJYm8lGQtJAHfpndeBCfJuNWB5H4Utvn2Inw5vkc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tlUQjGoNVxVM2xBF6ef8gAT6eLA1yMRcqmNtuenW5z9KeY/P1LAavCnmiV40ZYDGMw/Qo3BGjysYz4Mt2F0OTW4xBLKk7kQmAs9HElGVLVwgLvzqLipNydvisoTvUqMp4s4+xcvlrpAwzRtiLTg1Eg3BZNZYT3CSRPlTTLoHH/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: +SUrNCTBRTWk3uAG3RDIRA==
X-CSE-MsgGUID: 21RCBnHSQBCpoOa5dJqa9g==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:55:00 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 4F7E8401009B;
	Thu, 17 Apr 2025 22:54:56 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 32/38] ra6w: add status.h
Date: Thu, 17 Apr 2025 16:52:30 +0300
Message-Id: <20250417135236.52410-33-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/status.h | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/status.h

diff --git a/drivers/net/wireless/renesas/ra6w/status.h b/drivers/net/wireless/renesas/ra6w/status.h
new file mode 100644
index 000000000000..3736e2a2fdb7
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/status.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_STATUS_H
+#define RA6W_STATUS_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
+
+enum ra6w_status_code {
+	RA6W_STATUS_CODE_SUCCESS = 0,
+	RA6W_STATUS_CODE_FAIL,
+	RA6W_STATUS_CODE_EMPTY,
+	RA6W_STATUS_CODE_FULL,
+	RA6W_STATUS_CODE_INVALID_PARAM,
+	RA6W_STATUS_CODE_NOT_FOUND,
+	RA6W_STATUS_CODE_NO_MORE,
+	RA6W_STATUS_CODE_NOT_IN_USE,
+	RA6W_STATUS_CODE_BUSY,
+	RA6W_STATUS_CODE_IN_PROGRESS,
+	RA6W_STATUS_CODE_MEMORY_FAIL,
+	RA6W_STATUS_CODE_NOT_SUPPORT,
+	RA6W_STATUS_CODE_EXIST,
+
+	RA6W_STATUS_CODE_MAX
+};
+
+enum ra6w_status_byte {
+	RA6W_STATUS_BYTE_STATUS,
+	RA6W_STATUS_BYTE_TX_AVAIL_CNT,
+	RA6W_STATUS_BYTE_TX_POWER_AVAIL_CNT,
+	RA6W_STATUS_BYTE_RESERVED,
+
+	RA6W_STATUS_BYTE_MAX
+};
+
+enum ra6w_status_byte_bits {
+	RA6W_STATUS_BIT_RX_EMPTY,
+	RA6W_STATUS_BIT_TX_AC_FULL,
+	RA6W_STATUS_BIT_TX_POWER_FULL,
+
+	RA6W_STATUS_BITS_MAX
+};
+
+struct ra6w_status {
+	u8 value[RA6W_STATUS_BYTE_MAX];
+	spinlock_t lock;
+};
+
+struct ra6w_status_ext_hdr {
+	u32 status : 32;
+};
+
+struct ra6w_status_buf {
+	u8 cmd;
+	u8 ext_len;
+	__le16 data_len;
+	struct ra6w_status_ext_hdr ext_hdr;
+};
+
+#define RA6W_STATUS_EXT_LEN	(sizeof(struct ra6w_status_ext_hdr))
+
+void ra6w_status_init(struct ra6w_status *status);
+void ra6w_status_set(struct ra6w_status *status, u32 value);
+u8 ra6w_status_rx_get(struct ra6w_status *status);
+u8 ra6w_status_tx_get(struct ra6w_status *status, u8 ac);
+u8 ra6w_status_tx_avail_cnt_get(struct ra6w_status *status, u8 ac);
+int ra6w_status_err_code_to_errno(u8 err);
+void ra6w_status_event_post(struct ra6w_status *status, const struct sk_buff *skb);
+
+#endif /* RA6W_STATUS_H */
-- 
2.17.1


