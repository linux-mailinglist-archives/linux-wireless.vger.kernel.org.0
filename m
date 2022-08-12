Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998A591394
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Aug 2022 18:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239265AbiHLQLP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Aug 2022 12:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239235AbiHLQLA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Aug 2022 12:11:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869FDA5984
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 09:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D91661585
        for <linux-wireless@vger.kernel.org>; Fri, 12 Aug 2022 16:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECADC4347C;
        Fri, 12 Aug 2022 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660320650;
        bh=5F8D0+vl2kZ4/R66S20cfD8525Duset2QibnHedw1qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5RWMLljRPEn4Dzi1zq3i2pTAO3keaJxqTev6gZi9UwFIXLul4b2X6EnzRYnKeSDf
         Dpvi1yagkLku6qwQvLybzNJFdJ+WnJvTNhAr+lyMLilqLZZQeNyMiXCDbytniOIBNy
         QKIaO0TlvIb4kUhyHql0NOiO88+bCD60lD659aWDp8pv27xn+mWZ7cnhD7qXxTDiZ6
         5vgyjbLWgEDAzwXZ7xL/zzpxgS4+uAQvBAi46ZCU30Avqgj5C7gzLk1yHCUncYt8wK
         gEuJtM/TN3zFOxKxpSC7nlBqyuGDrvIEcjbNwITk0jIsF8zAWLQntqgiNQcgLUN4Is
         +rD5C6rf8KKEQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath12k@lists.infradead.org
Subject: [PATCH 42/50] wifi: ath12k: add reg.h
Date:   Fri, 12 Aug 2022 19:09:55 +0300
Message-Id: <20220812161003.27279-43-kvalo@kernel.org>
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

