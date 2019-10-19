Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A77ADD7B4
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Oct 2019 11:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfJSJjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Oct 2019 05:39:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50434 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbfJSJjQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Oct 2019 05:39:16 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iLlCb-0002fy-S1; Sat, 19 Oct 2019 12:39:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 19 Oct 2019 12:38:57 +0300
Message-Id: <20191019123747.a534c879f656.Ifeabf1fdd22e5009c1780fa8de946dfe6d072ddd@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191019093902.29823-1-luca@coelho.fi>
References: <20191019093902.29823-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 07/12] iwlwifi: scan: create function for scan scheduling params
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tova Mussai <tova.mussai@intel.com>

In the next patch, this code will be used from different places.
As preparation export this code into function.

Signed-off-by: Tova Mussai <tova.mussai@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 61 ++++++++++++-------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 2f92f6516415..538cd7b2018b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1485,6 +1485,39 @@ static u16 iwl_mvm_scan_umac_flags(struct iwl_mvm *mvm,
 	return flags;
 }
 
+static int
+iwl_mvm_fill_scan_sched_params(struct iwl_mvm_scan_params *params,
+			       struct iwl_scan_umac_schedule *schedule,
+			       __le16 *delay)
+{
+	int i;
+	if (WARN_ON(!params->n_scan_plans ||
+		    params->n_scan_plans > IWL_MAX_SCHED_SCAN_PLANS))
+		return -EINVAL;
+
+	for (i = 0; i < params->n_scan_plans; i++) {
+		struct cfg80211_sched_scan_plan *scan_plan =
+			&params->scan_plans[i];
+
+		schedule[i].iter_count = scan_plan->iterations;
+		schedule[i].interval =
+			cpu_to_le16(scan_plan->interval);
+	}
+
+	/*
+	 * If the number of iterations of the last scan plan is set to
+	 * zero, it should run infinitely. However, this is not always the case.
+	 * For example, when regular scan is requested the driver sets one scan
+	 * plan with one iteration.
+	 */
+	if (!schedule[params->n_scan_plans - 1].iter_count)
+		schedule[params->n_scan_plans - 1].iter_count = 0xff;
+
+	*delay = cpu_to_le16(params->delay);
+
+	return 0;
+}
+
 static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			     struct iwl_mvm_scan_params *params,
 			     int type)
@@ -1498,7 +1531,7 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		(struct iwl_scan_req_umac_tail_v2 *)sec_part;
 	struct iwl_scan_req_umac_tail_v1 *tail_v1;
 	struct iwl_ssid_ie *direct_scan;
-	int uid, i;
+	int uid, ret = 0;
 	u32 ssid_bitmap = 0;
 	u8 channel_flags = 0;
 	u16 gen_flags;
@@ -1508,9 +1541,6 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (WARN_ON(params->n_scan_plans > IWL_MAX_SCHED_SCAN_PLANS))
-		return -EINVAL;
-
 	uid = iwl_mvm_scan_uid_by_status(mvm, 0);
 	if (uid < 0)
 		return uid;
@@ -1559,25 +1589,10 @@ static int iwl_mvm_scan_umac(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	chan_param->flags = channel_flags;
 	chan_param->count = params->n_channels;
 
-	for (i = 0; i < params->n_scan_plans; i++) {
-		struct cfg80211_sched_scan_plan *scan_plan =
-			&params->scan_plans[i];
-
-		tail_v2->schedule[i].iter_count = scan_plan->iterations;
-		tail_v2->schedule[i].interval =
-			cpu_to_le16(scan_plan->interval);
-	}
-
-	/*
-	 * If the number of iterations of the last scan plan is set to
-	 * zero, it should run infinitely. However, this is not always the case.
-	 * For example, when regular scan is requested the driver sets one scan
-	 * plan with one iteration.
-	 */
-	if (!tail_v2->schedule[i - 1].iter_count)
-		tail_v2->schedule[i - 1].iter_count = 0xff;
-
-	tail_v2->delay = cpu_to_le16(params->delay);
+	ret = iwl_mvm_fill_scan_sched_params(params, tail_v2->schedule,
+					     &tail_v2->delay);
+	if (ret)
+		return ret;
 
 	if (iwl_mvm_is_scan_ext_chan_supported(mvm)) {
 		tail_v2->preq = params->preq;
-- 
2.23.0

