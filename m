Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5BF26EF10
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 12:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfGTK1M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 06:27:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:59542 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbfGTK1M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 06:27:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1homZM-0000Hj-S1; Sat, 20 Jul 2019 13:26:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Date:   Sat, 20 Jul 2019 13:25:43 +0300
Message-Id: <20190720102545.5952-15-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190720102545.5952-1-luca@coelho.fi>
References: <20190720102545.5952-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 14/16] iwlwifi: mvm: fix possible out-of-bounds read when accessing lq_info
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

lq_info is an arary of size 2, active_tbl index is u8.
When accessing lq_info[1 - active_tbl], theoretically it's possible
that the access will be made to a negative index value.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c | 28 +++++++++++++++------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index 3fa50b1955bb..d3f04acfbacb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1352,6 +1352,18 @@ static void rs_set_expected_tpt_table(struct iwl_lq_sta *lq_sta,
 	tbl->expected_tpt = rs_get_expected_tpt_table(lq_sta, column, rate->bw);
 }
 
+/* rs uses two tables, one is active and the second is for searching better
+ * configuration. This function, according to the index of the currently
+ * active table returns the search table, which is located at the
+ * index complementary to 1 according to the active table (active = 1,
+ * search = 0 or active = 0, search = 1).
+ * Since lq_info is an arary of size 2, make sure index cannot be out of bounds.
+ */
+static inline u8 rs_search_tbl(u8 active_tbl)
+{
+	return (active_tbl ^ 1) & 1;
+}
+
 static s32 rs_get_best_rate(struct iwl_mvm *mvm,
 			    struct iwl_lq_sta *lq_sta,
 			    struct iwl_scale_tbl_info *tbl,	/* "search" */
@@ -1699,9 +1711,9 @@ static int rs_switch_to_column(struct iwl_mvm *mvm,
 			       struct ieee80211_sta *sta,
 			       enum rs_column col_id)
 {
-	struct iwl_scale_tbl_info *tbl = &(lq_sta->lq_info[lq_sta->active_tbl]);
+	struct iwl_scale_tbl_info *tbl = &lq_sta->lq_info[lq_sta->active_tbl];
 	struct iwl_scale_tbl_info *search_tbl =
-				&(lq_sta->lq_info[(1 - lq_sta->active_tbl)]);
+		&lq_sta->lq_info[rs_search_tbl(lq_sta->active_tbl)];
 	struct rs_rate *rate = &search_tbl->rate;
 	const struct rs_tx_column *column = &rs_tx_columns[col_id];
 	const struct rs_tx_column *curr_column = &rs_tx_columns[tbl->column];
@@ -2109,7 +2121,7 @@ static void rs_rate_scale_perform(struct iwl_mvm *mvm,
 	if (!lq_sta->search_better_tbl)
 		active_tbl = lq_sta->active_tbl;
 	else
-		active_tbl = 1 - lq_sta->active_tbl;
+		active_tbl = rs_search_tbl(lq_sta->active_tbl);
 
 	tbl = &(lq_sta->lq_info[active_tbl]);
 	rate = &tbl->rate;
@@ -2333,7 +2345,7 @@ static void rs_rate_scale_perform(struct iwl_mvm *mvm,
 		/* If new "search" mode was selected, set up in uCode table */
 		if (lq_sta->search_better_tbl) {
 			/* Access the "search" table, clear its history. */
-			tbl = &(lq_sta->lq_info[(1 - lq_sta->active_tbl)]);
+			tbl = &lq_sta->lq_info[rs_search_tbl(lq_sta->active_tbl)];
 			rs_rate_scale_clear_tbl_windows(mvm, tbl);
 
 			/* Use new "search" start rate */
@@ -2676,7 +2688,7 @@ static void rs_initialize_lq(struct iwl_mvm *mvm,
 	if (!lq_sta->search_better_tbl)
 		active_tbl = lq_sta->active_tbl;
 	else
-		active_tbl = 1 - lq_sta->active_tbl;
+		active_tbl = rs_search_tbl(lq_sta->active_tbl);
 
 	tbl = &(lq_sta->lq_info[active_tbl]);
 	rate = &tbl->rate;
@@ -3172,9 +3184,9 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 
 	if (!lq_sta->search_better_tbl) {
 		curr_tbl = &lq_sta->lq_info[lq_sta->active_tbl];
-		other_tbl = &lq_sta->lq_info[1 - lq_sta->active_tbl];
+		other_tbl = &lq_sta->lq_info[rs_search_tbl(lq_sta->active_tbl)];
 	} else {
-		curr_tbl = &lq_sta->lq_info[1 - lq_sta->active_tbl];
+		curr_tbl = &lq_sta->lq_info[rs_search_tbl(lq_sta->active_tbl)];
 		other_tbl = &lq_sta->lq_info[lq_sta->active_tbl];
 	}
 
@@ -3183,7 +3195,7 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 			       "Neither active nor search matches tx rate\n");
 		tmp_tbl = &lq_sta->lq_info[lq_sta->active_tbl];
 		rs_dump_rate(mvm, &tmp_tbl->rate, "ACTIVE");
-		tmp_tbl = &lq_sta->lq_info[1 - lq_sta->active_tbl];
+		tmp_tbl = &lq_sta->lq_info[rs_search_tbl(lq_sta->active_tbl)];
 		rs_dump_rate(mvm, &tmp_tbl->rate, "SEARCH");
 		rs_dump_rate(mvm, &lq_rate, "ACTUAL");
 
-- 
2.20.1

