Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4F62C519
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238868AbiKPQoY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238905AbiKPQnd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C93AE1CB30
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4180D61EEB
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D136C433C1;
        Wed, 16 Nov 2022 16:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616783;
        bh=VIPNevEjUaSNBkczAKK/FdH1SU9i1BIXIdu7MhsGUTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HKLVdkTGIfJhErsNlS9fs0mFrOvQPjJTUTqA00hDyltu3Mbpx2vPGCh0d2rBUraJ1
         4IXrho6XrU0/xpnAh0WINsFOuU3y70PWZzBJYgshhTk5Kb6a7+ZK/+Deph2hR+dqbK
         MPqjLd6pN0lRhRWsVjcvBK0NPTgBJD3oO4OnbeuNizysiblipi8S8xEZ7bVZj+9PDI
         hL7hiVgA5pPBDauWgn+d4oCEl0CEQYIT/z5nyhsFnPF7N+2vtwf88T+WcY59Jk1Jc7
         LIIJC0toLnexzpfr95zdjFSg5Fft78Ej3eVf5uikbCg+Imi0rPD1AEstfTX4gl7Duo
         WvZ7PsUNqLegA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 34/50] wifi: ath12k: add mhi.h
Date:   Wed, 16 Nov 2022 18:38:46 +0200
Message-Id: <20221116163902.24996-35-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/mhi.h | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.h b/drivers/net/wireless/ath/ath12k/mhi.h
new file mode 100644
index 000000000000..ebc23640ce7a
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/mhi.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+#ifndef _ATH12K_MHI_H
+#define _ATH12K_MHI_H
+
+#include "pci.h"
+
+#define PCIE_TXVECDB				0x360
+#define PCIE_TXVECSTATUS			0x368
+#define PCIE_RXVECDB				0x394
+#define PCIE_RXVECSTATUS			0x39C
+
+#define MHISTATUS				0x48
+#define MHICTRL					0x38
+#define MHICTRL_RESET_MASK			0x2
+
+enum ath12k_mhi_state {
+	ATH12K_MHI_INIT,
+	ATH12K_MHI_DEINIT,
+	ATH12K_MHI_POWER_ON,
+	ATH12K_MHI_POWER_OFF,
+	ATH12K_MHI_FORCE_POWER_OFF,
+	ATH12K_MHI_SUSPEND,
+	ATH12K_MHI_RESUME,
+	ATH12K_MHI_TRIGGER_RDDM,
+	ATH12K_MHI_RDDM,
+	ATH12K_MHI_RDDM_DONE,
+};
+
+extern const struct mhi_controller_config ath12k_mhi_config_qcn9274;
+extern const struct mhi_controller_config ath12k_mhi_config_wcn7850;
+
+int ath12k_mhi_start(struct ath12k_pci *ar_pci);
+void ath12k_mhi_stop(struct ath12k_pci *ar_pci);
+int ath12k_mhi_register(struct ath12k_pci *ar_pci);
+void ath12k_mhi_unregister(struct ath12k_pci *ar_pci);
+void ath12k_mhi_set_mhictrl_reset(struct ath12k_base *ab);
+void ath12k_mhi_clear_vector(struct ath12k_base *ab);
+
+void ath12k_mhi_suspend(struct ath12k_pci *ar_pci);
+void ath12k_mhi_resume(struct ath12k_pci *ar_pci);
+
+#endif

