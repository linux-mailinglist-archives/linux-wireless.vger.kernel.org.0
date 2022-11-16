Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4DE62C4FD
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239010AbiKPQnl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiKPQm6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:42:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4639FEB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FED361EED
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A5AC433B5;
        Wed, 16 Nov 2022 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616756;
        bh=Zcjc5OROfk0wE9GIbJku0cp3SYGaeZZXtW8eXHfJB3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cd8iiJ20R2ZQtz8h2fuOYkMhQGGDVLWHaiCBvISnamkbx5aBbPkKYkvB6NAOiRl5+
         ON3/mIu1tloizGHqM+HlVkCqHj4IfRiH1N0AkKMG6QsZGo9e2wONzueKa6vCFy8NH+
         nhx1P/IjGqRvPKM1/ChgFvBiEnedpmE9WrqfxUdCnzSSzpG0zPnswYY+SC9yOsDbGc
         UgJkj9z5V+DGB1VNi32+W8D5M+oZ8Hn145c+OawedtL3m8wJPL2jX8H+LcEQ05JGsN
         l62b8cfHlBxErjzj7wT3ZG50pajYbbtwv4BgL4W+0Yx3mu0+UVuW2ek9WqQQdYBN1T
         kuS8mQeFgDDxA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 08/50] wifi: ath12k: add dbring.h
Date:   Wed, 16 Nov 2022 18:38:20 +0200
Message-Id: <20221116163902.24996-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221116163902.24996-1-kvalo@kernel.org>
References: <20221116163902.24996-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/dbring.h | 80 ++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dbring.h b/drivers/net/wireless/ath/ath12k/dbring.h
new file mode 100644
index 000000000000..e1c0eba774ec
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/dbring.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_DBRING_H
+#define ATH12K_DBRING_H
+
+#include <linux/types.h>
+#include <linux/idr.h>
+#include <linux/spinlock.h>
+#include "dp.h"
+
+struct ath12k_dbring_element {
+	dma_addr_t paddr;
+	u8 payload[];
+};
+
+struct ath12k_dbring_data {
+	void *data;
+	u32 data_sz;
+	struct ath12k_wmi_dma_buf_release_meta_data_params meta;
+};
+
+struct ath12k_dbring_buf_release_event {
+	struct ath12k_wmi_dma_buf_release_fixed_params fixed;
+	const struct ath12k_wmi_dma_buf_release_entry_params *buf_entry;
+	const struct ath12k_wmi_dma_buf_release_meta_data_params *meta_data;
+	u32 num_buf_entry;
+	u32 num_meta;
+};
+
+struct ath12k_dbring_cap {
+	u32 pdev_id;
+	enum wmi_direct_buffer_module id;
+	u32 min_elem;
+	u32 min_buf_sz;
+	u32 min_buf_align;
+};
+
+struct ath12k_dbring {
+	struct dp_srng refill_srng;
+	struct idr bufs_idr;
+	/* Protects bufs_idr */
+	spinlock_t idr_lock;
+	dma_addr_t tp_addr;
+	dma_addr_t hp_addr;
+	int bufs_max;
+	u32 pdev_id;
+	u32 buf_sz;
+	u32 buf_align;
+	u32 num_resp_per_event;
+	u32 event_timeout_ms;
+	int (*handler)(struct ath12k *ar, struct ath12k_dbring_data *data);
+};
+
+int ath12k_dbring_set_cfg(struct ath12k *ar,
+			  struct ath12k_dbring *ring,
+			  u32 num_resp_per_event,
+			  u32 event_timeout_ms,
+			  int (*handler)(struct ath12k *,
+					 struct ath12k_dbring_data *));
+int ath12k_dbring_wmi_cfg_setup(struct ath12k *ar,
+				struct ath12k_dbring *ring,
+				enum wmi_direct_buffer_module id);
+int ath12k_dbring_buf_setup(struct ath12k *ar,
+			    struct ath12k_dbring *ring,
+			    struct ath12k_dbring_cap *db_cap);
+int ath12k_dbring_srng_setup(struct ath12k *ar, struct ath12k_dbring *ring,
+			     int ring_num, int num_entries);
+int ath12k_dbring_buffer_release_event(struct ath12k_base *ab,
+				       struct ath12k_dbring_buf_release_event *ev);
+int ath12k_dbring_get_cap(struct ath12k_base *ab,
+			  u8 pdev_idx,
+			  enum wmi_direct_buffer_module id,
+			  struct ath12k_dbring_cap *db_cap);
+void ath12k_dbring_srng_cleanup(struct ath12k *ar, struct ath12k_dbring *ring);
+void ath12k_dbring_buf_cleanup(struct ath12k *ar, struct ath12k_dbring *ring);
+#endif /* ATH12K_DBRING_H */

