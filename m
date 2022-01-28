Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C453E49F962
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348415AbiA1MbR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:31:17 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37820 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348404AbiA1MbR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:31:17 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQPJ-0002A0-OD;
        Fri, 28 Jan 2022 14:31:15 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:30:51 +0200
Message-Id: <iwlwifi.20220128142706.5612eeb9d6d0.I992e10d93fc22919b2bc42daad087ee1b5d6f014@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128123057.524038-1-luca@coelho.fi>
References: <20220128123057.524038-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 2/8] iwlwifi: fix iwl_legacy_rate_to_fw_idx
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

There are a couple of bugs in this function:

1. It is declared as a non-static function, even though
   it's only used in one file.
2. Its return value should be of type u32 but it returns
   (in some cases) -1.

Fix them by making this function static and returning an
error value of type unsigned.

In addition, we're assigning the return value of this function
as the legacy rate even if the function returned an error value.
Fix this by assigning the lowest rate in this case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reported-by: Ye Guojin <ye.guojin@zte.com.cn>
Reported-by: Zeal Robot <zealci@zte.com.cn>
Fixes: 9998f81e4ba5 ("iwlwifi: mvm: convert old rate & flags to the new format.")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    | 33 ++++++++++---------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index 173a6991587b..4a7723eb8c1d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -752,7 +752,6 @@ struct iwl_lq_cmd {
 
 u8 iwl_fw_rate_idx_to_plcp(int idx);
 u32 iwl_new_rate_from_v1(u32 rate_v1);
-u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags);
 const struct iwl_rate_mcs_info *iwl_rate_mcs(int idx);
 const char *iwl_rs_pretty_ant(u8 ant);
 const char *iwl_rs_pretty_bw(int bw);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index a21c3befd93b..a835214611ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -91,6 +91,20 @@ const char *iwl_rs_pretty_bw(int bw)
 }
 IWL_EXPORT_SYMBOL(iwl_rs_pretty_bw);
 
+static u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
+{
+	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
+	int idx;
+	bool ofdm = !(rate_n_flags & RATE_MCS_CCK_MSK_V1);
+	int offset = ofdm ? IWL_FIRST_OFDM_RATE : 0;
+	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
+
+	for (idx = offset; idx < last; idx++)
+		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
+			return idx - offset;
+	return IWL_RATE_INVALID;
+}
+
 u32 iwl_new_rate_from_v1(u32 rate_v1)
 {
 	u32 rate_v2 = 0;
@@ -144,7 +158,10 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 	} else {
 		u32 legacy_rate = iwl_legacy_rate_to_fw_idx(rate_v1);
 
-		WARN_ON(legacy_rate < 0);
+		if (WARN_ON_ONCE(legacy_rate == IWL_RATE_INVALID))
+			legacy_rate = (rate_v1 & RATE_MCS_CCK_MSK_V1) ?
+				IWL_FIRST_CCK_RATE : IWL_FIRST_OFDM_RATE;
+
 		rate_v2 |= legacy_rate;
 		if (!(rate_v1 & RATE_MCS_CCK_MSK_V1))
 			rate_v2 |= RATE_MCS_LEGACY_OFDM_MSK;
@@ -172,20 +189,6 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 }
 IWL_EXPORT_SYMBOL(iwl_new_rate_from_v1);
 
-u32 iwl_legacy_rate_to_fw_idx(u32 rate_n_flags)
-{
-	int rate = rate_n_flags & RATE_LEGACY_RATE_MSK_V1;
-	int idx;
-	bool ofdm = !(rate_n_flags & RATE_MCS_CCK_MSK_V1);
-	int offset = ofdm ? IWL_FIRST_OFDM_RATE : 0;
-	int last = ofdm ? IWL_RATE_COUNT_LEGACY : IWL_FIRST_OFDM_RATE;
-
-	for (idx = offset; idx < last; idx++)
-		if (iwl_fw_rate_idx_to_plcp(idx) == rate)
-			return idx - offset;
-	return -1;
-}
-
 int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 {
 	char *type;
-- 
2.34.1

