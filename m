Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C991591396
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbiHLQKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiHLQKU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F85DC2
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C32DF61592
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F1C433D7;
        Fri, 12 Aug 2022 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320615;
        bh=3HuRZQ7mHpBGFRiOKZpXORCrciqC9LKHuFEUKnciue0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U0NDuKzAA4G2jLsc0GmE/FS7qdBj/JLLcpSxbBDIv8SFFXRnt4yK/x6YjUuSRgYtt
         ST81sFo1cNl7Sfxnr3tT9yhsWmZkg2XFwV4aVJzyNfijvbNgOB6IHxpFtFHtxQSq9Y
         nH4u2WyG7005WMY06CWpG9MOGwWpaBCdHjiYKafyFGX2bK3T7C/I8+P3uaH0vDgHAz
         +DHjUB6o91NQNsNAU4L0LaoXrfKA6KxPgDC1mn3V+K3I9Sy2jXHwPpTUwVtU5qaX5f
         kxg+ziQEQ4Z9sWFMhq3OwdH59iT82+kcRCiuNkYmZlQW+aDPwmBvjoJIZENwEBMBXi
         FWWDvmWBANxiA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 08/50] wifi: ath12k: add dbring.h
Date:   Fri, 12 Aug 2022 19:09:21 +0300
Message-Id: <20220812161003.27279-9-kvalo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220812161003.27279-1-kvalo@kernel.org>
References: <20220812161003.27279-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 000000000000..2be2d8def3f0
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
+	u8 payload[0];
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

