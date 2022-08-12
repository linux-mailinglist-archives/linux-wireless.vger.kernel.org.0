Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD45913B4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbiHLQLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiHLQKv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF63A50D6
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B2E561596
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA39C433C1;
        Fri, 12 Aug 2022 16:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320642;
        bh=4bw0DecgrHbSITqaYkcq0i1V56NhfS9iRWooU9MoKfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TFU4VPfU5lnQYZ93u+qA/GR5xopx39ghWabJYYy76X3Mt0OF7TIBA8spkL9EAccME
         RW8ZCRSfDv3MsADORYmJruVv16QU/OU3F1hh31h8dZXXEb1YCQUSV5xF1ySps6r1oG
         ECL3/xkqYcZ3pbYSoNUiBJq8nmOG+NjLd5+WeBmg+1moaoMtlAo+IzktGWfQ8r5W5V
         FZo13zWn5YRm8cnwVn3sYeMAl3UITPCIYW0uE62g0c0p4XT/3WwYoc78samgtOypEw
         rNrYdLqNtMskKHfRK9r6TXG4IVvvZYoYtNGIXQfQFW1NJEDdGZK98+V52xJxfvHsSF
         T4kODyfbksdRg==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 34/50] wifi: ath12k: add mhi.h
Date:   Fri, 12 Aug 2022 19:09:47 +0300
Message-Id: <20220812161003.27279-35-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/mhi.h | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/mhi.h b/drivers/net/wireless/ath/ath12k/mhi.h
new file mode 100644
index 000000000000..258152d3a7dd
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
+extern struct mhi_controller_config ath12k_mhi_config_qcn9274;
+extern struct mhi_controller_config ath12k_mhi_config_wcn7850;
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

