Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B74730FAA
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244107AbjFOGtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244092AbjFOGtG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 02:49:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A4F2970
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 23:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686811655; x=1718347655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PtT0h5RLGNP5oRwYOmdQ9ELHVtvzYnB+zz6c5o0vZW8=;
  b=eCz2Yw7uqrk4Gk2YmpirefiOIxMM8Ospd1AGk5btNzuD91nSreoOjcwb
   /NNxEaLr41ENEEO2cXfaKY6/VEqZtMzcv44WXjcSbFxk4Y4gZh21N5Ppl
   pxC0MPj6+KnHj1IVaTI3tFIfb9a/i9tx+Tzr+wC+OHY4BNctYbdZ33p3C
   HV7FWGKPeZjZ1OJNO3lWPGFgHR74MvXNPpbzqR+F3xw1nq52TTlDZr9O7
   mKnC8l+g+P20PIaEPSY+jDq07v4khd9BRBMKx9zZnd2SYRDArvg/2DT8l
   GIUVGUZfJZnwLGegUph0Apq53PCwBJYYdlqWEUtUrAvwWkyT0N9gG+tP3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="362212221"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="362212221"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782395928"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="782395928"
Received: from uabekas-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.220.240])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:47:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 1/5] wifi: iwlwifi: fix max number of fw active links
Date:   Thu, 15 Jun 2023 09:47:16 +0300
Message-Id: <20230615094410.e78ad74c6715.I68b26911c0a312d72eaf25344b448d03b1c61f4e@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230615064720.459645-1-gregory.greenman@intel.com>
References: <20230615064720.459645-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

The max active links that are supported by the FW is hard coded.
This is wrong since this value is HW-dependent. Fix this by
determining according to the actual HW.

Also remove a redundant check that the number of active links
doesn't exceeds the maximum.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 18 ---------------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  6 ++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 22 +++++++++++++++++++
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 563396dfd3cd..69ebd844de2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -118,24 +118,6 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		if (!link_info->phy_ctxt)
 			return 0;
 
-		/* check there aren't too many active links */
-		if (!link_info->active && active) {
-			int i, count = 0;
-
-			/* link with phy_ctxt is active in FW */
-			for_each_mvm_vif_valid_link(mvmvif, i)
-				if (mvmvif->link[i]->phy_ctxt)
-					count++;
-
-			if (vif->type == NL80211_IFTYPE_AP) {
-				if (count > mvm->fw->ucode_capa.num_beacons)
-					return -EOPNOTSUPP;
-			/* this should be per HW or such */
-			} else if (count >= IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM) {
-				return -EOPNOTSUPP;
-			}
-		}
-
 		/* Catch early if driver tries to activate or deactivate a link
 		 * twice.
 		 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8cd03357ce79..37b5b7f1f153 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -900,9 +900,7 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 	u16 added = new_links & ~old_links;
 	int err, i;
 
-	if (hweight16(new_links) > 2) {
-		return -EOPNOTSUPP;
-	} else if (hweight16(new_links) > 1) {
+	if (hweight16(new_links) > 1) {
 		unsigned int n_active = 0;
 
 		for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
@@ -917,7 +915,7 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 		if (vif->type == NL80211_IFTYPE_AP) {
 			if (n_active > mvm->fw->ucode_capa.num_beacons)
 				return -EOPNOTSUPP;
-		} else if (n_active > 1) {
+		} else if (n_active > iwl_mvm_max_active_links(mvm)) {
 			return -EOPNOTSUPP;
 		}
 	}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index de7aa4713c93..35cf0015b362 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1544,6 +1544,28 @@ static inline bool iwl_mvm_is_ctdp_supported(struct iwl_mvm *mvm)
 			   IWL_UCODE_TLV_CAPA_CTDP_SUPPORT);
 }
 
+static inline bool iwl_mvm_is_esr_supported(struct iwl_trans *trans)
+{
+	if ((CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM) &&
+	    !CSR_HW_RFID_IS_CDB(trans->hw_rf_id))
+		/* Step A doesn't support eSR */
+		return CSR_HW_RFID_STEP(trans->hw_rf_id);
+
+	return false;
+}
+
+static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm)
+{
+	struct iwl_trans *trans = mvm->fwrt.trans;
+
+	if (iwl_mvm_is_esr_supported(trans) ||
+	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
+	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
+		return IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM;
+
+	return 1;
+}
+
 extern const u8 iwl_mvm_ac_to_tx_fifo[];
 extern const u8 iwl_mvm_ac_to_gen2_tx_fifo[];
 
-- 
2.38.1

