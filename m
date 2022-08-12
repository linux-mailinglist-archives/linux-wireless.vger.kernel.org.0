Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9393F5913BB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiHLQKw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiHLQKo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2529F779
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9F3B61529
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85288C433C1;
        Fri, 12 Aug 2022 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320634;
        bh=cs7cUHDsedylXc4X6pEWLx2v+1JpM0HiKu+j0ywfPL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=utJHQcED7KTqkBow6H83I42iJ82poNhoogoVZlhjEEhu5LmR+tMN6FwsanxPTGZnk
         H0gzwnPCaOUxWZpekwN2NC0XQ4E/3nb1XAqgl7tKfkcr8s4Foq7kVNvYz5OGaW+sYh
         6/VXavG39bPIei2Ha9AMKnL5A9sUSBd8+rFSU+knJ3SVBNrPboe0vt+REQgZvgnON0
         6ixlC36GJg+4PhkOnGnapWhT0/Cuj+gTEeyISpuuIO2E0+hNDhLnXFCu4FqqdgdUud
         dSoE9MVKx4+zhNJ0VB3L2o1ZIAZo9dBkuGtcS0QuEpbWmYR+5A8GneETZ2f5Nnosge
         gjU2rDYHGDdgg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 26/50] wifi: ath12k: add hif.h
Date:   Fri, 12 Aug 2022 19:09:39 +0300
Message-Id: <20220812161003.27279-27-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/hif.h | 144 ++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/hif.h b/drivers/net/wireless/ath/ath12k/hif.h
new file mode 100644
index 000000000000..54490cdb63a1
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/hif.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_HIF_H
+#define ATH12K_HIF_H
+
+#include "core.h"
+
+struct ath12k_hif_ops {
+	u32 (*read32)(struct ath12k_base *sc, u32 address);
+	void (*write32)(struct ath12k_base *sc, u32 address, u32 data);
+	void (*irq_enable)(struct ath12k_base *sc);
+	void (*irq_disable)(struct ath12k_base *sc);
+	int (*start)(struct ath12k_base *sc);
+	void (*stop)(struct ath12k_base *sc);
+	int (*power_up)(struct ath12k_base *sc);
+	void (*power_down)(struct ath12k_base *sc);
+	int (*suspend)(struct ath12k_base *ab);
+	int (*resume)(struct ath12k_base *ab);
+	int (*map_service_to_pipe)(struct ath12k_base *sc, u16 service_id,
+				   u8 *ul_pipe, u8 *dl_pipe);
+	int (*get_user_msi_vector)(struct ath12k_base *ab, char *user_name,
+				   int *num_vectors, u32 *user_base_data,
+				   u32 *base_vector);
+	void (*get_msi_address)(struct ath12k_base *ab, u32 *msi_addr_lo,
+				u32 *msi_addr_hi);
+	void (*ce_irq_enable)(struct ath12k_base *ab);
+	void (*ce_irq_disable)(struct ath12k_base *ab);
+	void (*get_ce_msi_idx)(struct ath12k_base *ab, u32 ce_id, u32 *msi_idx);
+};
+
+static inline int ath12k_hif_map_service_to_pipe(struct ath12k_base *ab, u16 service_id,
+						 u8 *ul_pipe, u8 *dl_pipe)
+{
+	return ab->hif.ops->map_service_to_pipe(ab, service_id,
+						ul_pipe, dl_pipe);
+}
+
+static inline int ath12k_hif_get_user_msi_vector(struct ath12k_base *ab,
+						 char *user_name,
+						 int *num_vectors,
+						 u32 *user_base_data,
+						 u32 *base_vector)
+{
+	if (!ab->hif.ops->get_user_msi_vector)
+		return -EOPNOTSUPP;
+
+	return ab->hif.ops->get_user_msi_vector(ab, user_name, num_vectors,
+						user_base_data,
+						base_vector);
+}
+
+static inline void ath12k_hif_get_msi_address(struct ath12k_base *ab,
+					      u32 *msi_addr_lo,
+					      u32 *msi_addr_hi)
+{
+	if (!ab->hif.ops->get_msi_address)
+		return;
+
+	ab->hif.ops->get_msi_address(ab, msi_addr_lo, msi_addr_hi);
+}
+
+static inline void ath12k_hif_get_ce_msi_idx(struct ath12k_base *ab, u32 ce_id,
+					     u32 *msi_data_idx)
+{
+	if (ab->hif.ops->get_ce_msi_idx)
+		ab->hif.ops->get_ce_msi_idx(ab, ce_id, msi_data_idx);
+	else
+		*msi_data_idx = ce_id;
+}
+
+static inline void ath12k_hif_ce_irq_enable(struct ath12k_base *ab)
+{
+	if (ab->hif.ops->ce_irq_enable)
+		ab->hif.ops->ce_irq_enable(ab);
+}
+
+static inline void ath12k_hif_ce_irq_disable(struct ath12k_base *ab)
+{
+	if (ab->hif.ops->ce_irq_disable)
+		ab->hif.ops->ce_irq_disable(ab);
+}
+
+static inline void ath12k_hif_irq_enable(struct ath12k_base *ab)
+{
+	ab->hif.ops->irq_enable(ab);
+}
+
+static inline void ath12k_hif_irq_disable(struct ath12k_base *ab)
+{
+	ab->hif.ops->irq_disable(ab);
+}
+
+static inline int ath12k_hif_suspend(struct ath12k_base *ab)
+{
+	if (ab->hif.ops->suspend)
+		return ab->hif.ops->suspend(ab);
+
+	return 0;
+}
+
+static inline int ath12k_hif_resume(struct ath12k_base *ab)
+{
+	if (ab->hif.ops->resume)
+		return ab->hif.ops->resume(ab);
+
+	return 0;
+}
+
+static inline int ath12k_hif_start(struct ath12k_base *ab)
+{
+	return ab->hif.ops->start(ab);
+}
+
+static inline void ath12k_hif_stop(struct ath12k_base *ab)
+{
+	ab->hif.ops->stop(ab);
+}
+
+static inline u32 ath12k_hif_read32(struct ath12k_base *ab, u32 address)
+{
+	return ab->hif.ops->read32(ab, address);
+}
+
+static inline void ath12k_hif_write32(struct ath12k_base *ab, u32 address,
+				      u32 data)
+{
+	ab->hif.ops->write32(ab, address, data);
+}
+
+static inline int ath12k_hif_power_up(struct ath12k_base *ab)
+{
+	return ab->hif.ops->power_up(ab);
+}
+
+static inline void ath12k_hif_power_down(struct ath12k_base *ab)
+{
+	ab->hif.ops->power_down(ab);
+}
+
+#endif /* ATH12K_HIF_H */

