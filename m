Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFE6CAA40F
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388571AbfIENNf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:13:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41018 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388541AbfIENNf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:13:35 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZJ-0005yI-Iz; Thu, 05 Sep 2019 16:12:58 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:37 +0300
Message-Id: <20190905131241.23487-15-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 14/18] iwlwifi: remove unused regdb_ptrs allocation
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

regdb_ptrs is not in used anymore, remove it.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d87a6bb3e456..fd386bfbd5df 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1066,11 +1066,6 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *nvm_chan,
 	return flags;
 }
 
-struct regdb_ptrs {
-	struct ieee80211_wmm_rule *rule;
-	u32 token;
-};
-
 struct ieee80211_regdomain *
 iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 		       int num_of_ch, __le32 *channels, u16 fw_mcc,
@@ -1082,7 +1077,6 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	const u16 *nvm_chan;
 	struct ieee80211_regdomain *regd, *copy_rd;
 	struct ieee80211_reg_rule *rule;
-	struct regdb_ptrs *regdb_ptrs;
 	enum nl80211_band band;
 	int center_freq, prev_center_freq = 0;
 	int valid_rules = 0;
@@ -1114,12 +1108,6 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	if (!regd)
 		return ERR_PTR(-ENOMEM);
 
-	regdb_ptrs = kcalloc(num_of_ch, sizeof(*regdb_ptrs), GFP_KERNEL);
-	if (!regdb_ptrs) {
-		copy_rd = ERR_PTR(-ENOMEM);
-		goto out;
-	}
-
 	/* set alpha2 from FW. */
 	regd->alpha2[0] = fw_mcc >> 8;
 	regd->alpha2[1] = fw_mcc & 0xff;
@@ -1191,8 +1179,6 @@ iwl_parse_nvm_mcc_info(struct device *dev, const struct iwl_cfg *cfg,
 	if (!copy_rd)
 		copy_rd = ERR_PTR(-ENOMEM);
 
-out:
-	kfree(regdb_ptrs);
 	kfree(regd);
 	return copy_rd;
 }
-- 
2.23.0.rc1

