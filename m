Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDD34631B9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236720AbhK3LDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 06:03:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:29776 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235667AbhK3LDS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 06:03:18 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216207703"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="216207703"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 02:59:59 -0800
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="512129906"
Received: from azohar-mobl1.ger.corp.intel.com (HELO egrumbac-mobl1.intel.com) ([10.254.155.124])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 02:59:57 -0800
From:   Emmanuel Grumbach <emmanuel.grumbach@intel.com>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iwlwifi: mvm: fix a possible NULL pointer deference
Date:   Tue, 30 Nov 2021 12:59:51 +0200
Message-Id: <20211130105951.85539-1-emmanuel.grumbach@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Smatch spot a possible NULL pointer dereference. Fix it.

__iwl_mvm_mac_set_key can be called with sta = NULL
Also add a NULL pointer check after memory allocation.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c     |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 11 ++++++-----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 112cc362e8e7..7fa42fd2ba16 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -627,6 +627,8 @@ static void iwl_mei_handle_csme_filters(struct mei_cl_device *cldev,
 					  lockdep_is_held(&iwl_mei_mutex));
 
 	new_filters = kzalloc(sizeof(*new_filters), GFP_KERNEL);
+	if (!new_filters)
+		return;
 
 	/* Copy the OOB filters */
 	new_filters->filters = filters->filters;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index c96a0ece8066..6356752a8a3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3557,13 +3557,14 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
-	struct iwl_mvm_sta *mvmsta;
+	struct iwl_mvm_sta *mvmsta = NULL;
 	struct iwl_mvm_key_pn *ptk_pn;
 	int keyidx = key->keyidx;
 	int ret, i;
 	u8 key_offset;
 
-	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	if (sta)
+		mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
 	switch (key->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
@@ -3665,7 +3666,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		}
 
 		if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
-		    sta && iwl_mvm_has_new_rx_api(mvm) &&
+		    mvmsta && iwl_mvm_has_new_rx_api(mvm) &&
 		    key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
 		    (key->cipher == WLAN_CIPHER_SUITE_CCMP ||
 		     key->cipher == WLAN_CIPHER_SUITE_GCMP ||
@@ -3699,7 +3700,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 		else
 			key_offset = STA_KEY_IDX_INVALID;
 
-		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+		if (mvmsta && key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
 			mvmsta->pairwise_cipher = key->cipher;
 
 		IWL_DEBUG_MAC80211(mvm, "set hwcrypto key\n");
@@ -3742,7 +3743,7 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 			break;
 		}
 
-		if (sta && iwl_mvm_has_new_rx_api(mvm) &&
+		if (mvmsta && iwl_mvm_has_new_rx_api(mvm) &&
 		    key->flags & IEEE80211_KEY_FLAG_PAIRWISE &&
 		    (key->cipher == WLAN_CIPHER_SUITE_CCMP ||
 		     key->cipher == WLAN_CIPHER_SUITE_GCMP ||
-- 
2.25.1

