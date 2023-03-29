Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534D66CD2A6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjC2HI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjC2HIx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:53 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56E62D44
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073722; x=1711609722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ecvfe0ifweuXoFmFhRb+5eRtvYrAWeyBK6kFVR8odP8=;
  b=mJGiD+lrs7qoKV8L3xonpLJp29bfmjmLlL6gtec0lBYR3Bl0dZfiocuq
   e+vgIqruSKgRFRZ/86e9w5w05s/eat+B5SANSCPhiusTl7zIYASNDRj8W
   lAz7OGyBxsNYutYqOhMIr/0fFMVXDyLNRiIEmryNmpCPNCiNtLUXkLogC
   UVqsWXaZObzm6dtNf6LBAqoYICZt+MFGhlKvxKrEEmKafN1K5t8a9B4hE
   Ao8klT7r/nRObMf9pqxS11+FRKe5xojw0aei0UoEJxy+pTYB5Kax7uuZW
   CgRBh2FKJGd2Ji7+YeveVociMooQ6z8f6AwdRPkab+z0gyFA/qMsiHBr6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320451044"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320451044"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111554"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111554"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:07:00 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 34/34] wifi: iwlwifi: mvm: correctly use link in iwl_mvm_sta_del()
Date:   Wed, 29 Mar 2023 10:05:40 +0300
Message-Id: <20230329100040.b85f6052d51a.Iedfef4b4c4f3ca557aebc0093fdc3f5cfb49b507@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230329070540.2739372-1-gregory.greenman@intel.com>
References: <20230329070540.2739372-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This function can be invoked for both MLO and non-MLO, so
it must deal with multi-link correctly. Notable, on auth
timeout, we'd otherwise get a warning due to the erroneous
deflink usage in MLO cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   | 18 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h   |  2 +-
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index ca788a427fa6..78d4f186cd99 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -780,7 +780,7 @@ int iwl_mvm_mld_rm_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 						  lockdep_is_held(&mvm->mutex));
 		bool stay_in_fw;
 
-		stay_in_fw = iwl_mvm_sta_del(mvm, vif, sta, mvm_link_sta, &ret);
+		stay_in_fw = iwl_mvm_sta_del(mvm, vif, sta, link_sta, &ret);
 		if (ret)
 			break;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index a57de37f6e02..8489554e58b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1986,14 +1986,22 @@ int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
  */
 bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta,
-		     struct iwl_mvm_link_sta *mvm_link_sta, int *ret)
+		     struct ieee80211_link_sta *link_sta, int *ret)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif_link_info *mvm_link =
+		mvmvif->link[link_sta->link_id];
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	u8 sta_id = mvm_link_sta->sta_id;
+	struct iwl_mvm_link_sta *mvm_link_sta;
+	u8 sta_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
+	mvm_link_sta =
+		rcu_dereference_protected(mvm_sta->link[link_sta->link_id],
+					  lockdep_is_held(&mvm->mutex));
+	sta_id = mvm_link_sta->sta_id;
+
 	/* If there is a TXQ still marked as reserved - free it */
 	if (mvm_sta->reserved_queue != IEEE80211_INVAL_HW_QUEUE) {
 		u8 reserved_txq = mvm_sta->reserved_queue;
@@ -2022,10 +2030,10 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			return true;
 
 		/* first remove remaining keys */
-		iwl_mvm_sec_key_remove_ap(mvm, vif, &mvmvif->deflink, 0);
+		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link, 0);
 
 		/* unassoc - go ahead - remove the AP STA now */
-		mvmvif->deflink.ap_sta_id = IWL_MVM_INVALID_STA;
+		mvm_link->ap_sta_id = IWL_MVM_INVALID_STA;
 	}
 
 	/*
@@ -2082,7 +2090,7 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 	iwl_mvm_disable_sta_queues(mvm, vif, sta);
 
-	if (iwl_mvm_sta_del(mvm, vif, sta, &mvm_sta->deflink, &ret))
+	if (iwl_mvm_sta_del(mvm, vif, sta, &sta->deflink, &ret))
 		return ret;
 
 	ret = iwl_mvm_rm_sta_common(mvm, mvm_sta->deflink.sta_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 625e1dfd47a2..7b9e91935aa0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -489,7 +489,7 @@ int iwl_mvm_wait_sta_queues_empty(struct iwl_mvm *mvm,
 				  struct iwl_mvm_sta *mvm_sta);
 bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		     struct ieee80211_sta *sta,
-		     struct iwl_mvm_link_sta *mvm_link_sta, int *ret);
+		     struct ieee80211_link_sta *link_sta, int *ret);
 int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		   struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta);
-- 
2.38.1

