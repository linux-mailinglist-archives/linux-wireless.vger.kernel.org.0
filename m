Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C2962C513
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbiKPQoF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiKPQnZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3B3F69
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80363B81DFD
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FACC433B5;
        Wed, 16 Nov 2022 16:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616775;
        bh=cs7cUHDsedylXc4X6pEWLx2v+1JpM0HiKu+j0ywfPL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZKdCWpTqtm+JVeZoKIIp8LcYUNVgULkTu4DT6EiCqwmekqls0uRdKsCFUyy2wHCs
         bjO7hxcn8l/aAM8kFoLVv+Y8lwkE2AvghsI5w+RHfZMmhTJq942sK95SzdtEKpyRXt
         4GACsvaeapTNHpr+L3xQThYhliBte2lhJ/DN3um3xsp1JmRTe/goFQo0dccW7fj6cE
         BIdme2H4eN0regkEJe8C9xAG/udymWktfMKCMd8HfU4ZQx5L/t2XfyHR2GaN290XYs
         JQvYTw2c/2yhZp41yEIV2trLEdcfsl+quH0KcngkAMc6Y8tj0D43n1B07JvInvMDEM
         mnCCnF92Xg/YA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 26/50] wifi: ath12k: add hif.h
Date:   Wed, 16 Nov 2022 18:38:38 +0200
Message-Id: <20221116163902.24996-27-kvalo@kernel.org>
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

