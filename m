Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711F362C521
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 17:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiKPQom (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 11:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiKPQnj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 11:43:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8EC59863
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 08:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B02661EE8
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 16:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B30C433C1;
        Wed, 16 Nov 2022 16:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668616792;
        bh=5F8D0+vl2kZ4/R66S20cfD8525Duset2QibnHedw1qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQ9D+sK27GsLcSFvdXoIMgzaCreO6OmKX8TizfHbCIY093u0vY+uFwSLm8SMeYqJA
         l/yDn3Cm9X3napEEuwGFiyFpirrIuBye8gvBxcOfqz5HyTbULl594JK+FmMu04irp6
         QIK8mdGh0JwnDQiHoZqQy+1LbP3Ww44Ev7fguSlspeUet1vBVkU8O6MOk1j7AfZfpR
         PZ6ODr5yIaVOIQf+TEBXvzE7TRaCuOyVlesPnRRAephkqYvscT1N6H1+MVZCqXBI8Z
         UDV2k5/AUBhKvauPC7QW3IA3poRyiY8TzJnweppC+s04zTHBfEJqZfc8XHCZvoTJV2
         lTnscgVRbZveA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH v2 42/50] wifi: ath12k: add reg.h
Date:   Wed, 16 Nov 2022 18:38:54 +0200
Message-Id: <20221116163902.24996-43-kvalo@kernel.org>
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
 drivers/net/wireless/ath/ath12k/reg.h | 95 +++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/reg.h b/drivers/net/wireless/ath/ath12k/reg.h
new file mode 100644
index 000000000000..56d009a47234
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/reg.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2019-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef ATH12K_REG_H
+#define ATH12K_REG_H
+
+#include <linux/kernel.h>
+#include <net/regulatory.h>
+
+struct ath12k_base;
+struct ath12k;
+
+/* DFS regdomains supported by Firmware */
+enum ath12k_dfs_region {
+	ATH12K_DFS_REG_UNSET,
+	ATH12K_DFS_REG_FCC,
+	ATH12K_DFS_REG_ETSI,
+	ATH12K_DFS_REG_MKK,
+	ATH12K_DFS_REG_CN,
+	ATH12K_DFS_REG_KR,
+	ATH12K_DFS_REG_MKK_N,
+	ATH12K_DFS_REG_UNDEF,
+};
+
+enum ath12k_reg_cc_code {
+	REG_SET_CC_STATUS_PASS = 0,
+	REG_CURRENT_ALPHA2_NOT_FOUND = 1,
+	REG_INIT_ALPHA2_NOT_FOUND = 2,
+	REG_SET_CC_CHANGE_NOT_ALLOWED = 3,
+	REG_SET_CC_STATUS_NO_MEMORY = 4,
+	REG_SET_CC_STATUS_FAIL = 5,
+};
+
+struct ath12k_reg_rule {
+	u16 start_freq;
+	u16 end_freq;
+	u16 max_bw;
+	u8 reg_power;
+	u8 ant_gain;
+	u16 flags;
+	bool psd_flag;
+	u16 psd_eirp;
+};
+
+struct ath12k_reg_info {
+	enum ath12k_reg_cc_code status_code;
+	u8 num_phy;
+	u8 phy_id;
+	u16 reg_dmn_pair;
+	u16 ctry_code;
+	u8 alpha2[REG_ALPHA2_LEN + 1];
+	u32 dfs_region;
+	u32 phybitmap;
+	bool is_ext_reg_event;
+	u32 min_bw_2g;
+	u32 max_bw_2g;
+	u32 min_bw_5g;
+	u32 max_bw_5g;
+	u32 num_2g_reg_rules;
+	u32 num_5g_reg_rules;
+	struct ath12k_reg_rule *reg_rules_2g_ptr;
+	struct ath12k_reg_rule *reg_rules_5g_ptr;
+	enum wmi_reg_6g_client_type client_type;
+	bool rnr_tpe_usable;
+	bool unspecified_ap_usable;
+	/* TODO: All 6G related info can be stored only for required
+	 * combination instead of all types, to optimize memory usage.
+	 */
+	u8 domain_code_6g_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u8 domain_code_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 domain_code_6g_super_id;
+	u32 min_bw_6g_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 max_bw_6g_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 min_bw_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 max_bw_6g_client[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	u32 num_6g_reg_rules_ap[WMI_REG_CURRENT_MAX_AP_TYPE];
+	u32 num_6g_reg_rules_cl[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+	struct ath12k_reg_rule *reg_rules_6g_ap_ptr[WMI_REG_CURRENT_MAX_AP_TYPE];
+	struct ath12k_reg_rule *reg_rules_6g_client_ptr
+		[WMI_REG_CURRENT_MAX_AP_TYPE][WMI_REG_MAX_CLIENT_TYPE];
+};
+
+void ath12k_reg_init(struct ath12k *ar);
+void ath12k_reg_free(struct ath12k_base *ab);
+void ath12k_regd_update_work(struct work_struct *work);
+struct ieee80211_regdomain *ath12k_reg_build_regd(struct ath12k_base *ab,
+						  struct ath12k_reg_info *reg_info,
+						  bool intersect);
+int ath12k_regd_update(struct ath12k *ar, bool init);
+int ath12k_reg_update_chan_list(struct ath12k *ar);
+
+#endif

