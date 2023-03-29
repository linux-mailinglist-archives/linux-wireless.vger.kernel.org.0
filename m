Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064146CD297
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Mar 2023 09:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjC2HIK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Mar 2023 03:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC2HIH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Mar 2023 03:08:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864F30D8
        for <linux-wireless@vger.kernel.org>; Wed, 29 Mar 2023 00:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680073670; x=1711609670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f3HDR4aVm0JWez9hfBt7bKAt/ojbwpayn5VmYY7nOvs=;
  b=et5ioPSlGyZukfA9TpaGAmXMwBd1U2ZoVDvMXwVz3MUc/eCsoCL0D6BX
   H379bR/4BPKrLP2AkpfYD/c8py/Io/JEm0HXsngmfcR2+qKCf5VWH9PEG
   8i91AAdvmXnLbK6i6LIigLKWbw82OnFJrlDi+QAASgqE63cwIEP5BMz9b
   jDuqu1qK2xjVFkj4XFJMD3nEjnHdZQ3egObRO78Nl5kECMCLYPw4kLVFM
   UkeAMxTWX+28bKZIbgjgUb5eKue5FLES9YjE9ku8olR67WaQryAUIea1x
   3T/Z24gRHi5odasQSKyBvKKFftUAL8/VRcUE75SznEpUf1xnuNpZeV3Ve
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="320450872"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="320450872"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="795111368"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="795111368"
Received: from sfrank1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.228.42])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:06:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 21/34] wifi: iwlwifi: mvm: use the new lockdep-checking macros
Date:   Wed, 29 Mar 2023 10:05:27 +0300
Message-Id: <20230329100039.112df5c8dec2.I1a1008f5566e509953d988f254d15c9e58630418@changeid>
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

Use the new macros from mac80211 that do lockdep checking
on the RCU dereferences, instead of hard-coding 1 as the
argument to rcu_dereference_protected().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 14 +++++++-------
 .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |  4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c   | 10 +++++-----
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 98c940271648..7fb00220e6cc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3591,9 +3591,9 @@ static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
 
 	for_each_mvm_vif_valid_link(mvmvif, link_id) {
 		struct ieee80211_bss_conf *conf =
-			rcu_dereference_protected(vif->link_conf[link_id], 1);
+			link_conf_dereference_protected(vif, link_id);
 		struct ieee80211_link_sta *link_sta =
-			rcu_dereference_protected(sta->link[link_id], 1);
+			link_sta_dereference_protected(sta, link_id);
 
 		if (!conf || !link_sta || !mvmvif->link[link_id]->phy_ctxt)
 			continue;
@@ -3622,9 +3622,9 @@ static bool iwl_mvm_vif_conf_from_sta(struct iwl_mvm *mvm,
 	for_each_set_bit(i, (unsigned long *)&sta->valid_links,
 			 IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta =
-			rcu_dereference_protected(sta->link[i], 1);
+			link_sta_dereference_protected(sta, i);
 		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_protected(vif->link_conf[i], 1);
+			link_conf_dereference_protected(vif, i);
 
 		if (!link_conf || !link_sta)
 			continue;
@@ -3653,9 +3653,9 @@ static void iwl_mvm_vif_set_he_support(struct ieee80211_hw *hw,
 	for_each_set_bit(i, (unsigned long *)&sta->valid_links,
 			 IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_link_sta *link_sta =
-			rcu_dereference_protected(sta->link[i], 1);
+			link_sta_dereference_protected(sta, i);
 		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_protected(vif->link_conf[i], 1);
+			link_conf_dereference_protected(vif, i);
 
 		if (!link_conf || !link_sta || !mvmvif->link[i])
 			continue;
@@ -3753,7 +3753,7 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 		for_each_set_bit(i, (unsigned long *)&sta->valid_links,
 				 IEEE80211_MLD_MAX_NUM_LINKS) {
 			struct ieee80211_bss_conf *link_conf =
-				rcu_dereference_protected(vif->link_conf[i], 1);
+				link_conf_dereference_protected(vif, i);
 
 			if (WARN_ON(!link_conf))
 				return -EINVAL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8ed76fc83702..ddc09012549b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -921,9 +921,7 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 		if (added & BIT(i)) {
 			struct ieee80211_bss_conf *link_conf;
 
-			/* FIXME: allow use of sdata_dereference()? */
-			link_conf = rcu_dereference_protected(vif->link_conf[i],
-							      1);
+			link_conf = link_conf_dereference_protected(vif, i);
 			if (WARN_ON(!link_conf))
 				continue;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index a713b8a10781..34b85a9a27af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -499,7 +499,7 @@ static int iwl_mvm_mld_alloc_sta_link(struct iwl_mvm *mvm,
 				      unsigned int link_id)
 {
 	struct ieee80211_link_sta *link_sta =
-		rcu_dereference_protected(sta->link[link_id], 1);
+		link_sta_dereference_protected(sta, link_id);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
 	struct iwl_mvm_link_sta *link;
 	u32 sta_id = iwl_mvm_find_free_sta_id(mvm,
@@ -654,7 +654,7 @@ int iwl_mvm_mld_add_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_protected(vif->link_conf[link_id], 1);
+			link_conf_dereference_protected(vif, link_id);
 		struct iwl_mvm_link_sta *mvm_link_sta =
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
@@ -704,7 +704,7 @@ int iwl_mvm_mld_update_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_protected(vif->link_conf[link_id], 1);
+			link_conf_dereference_protected(vif, link_id);
 		struct iwl_mvm_link_sta *mvm_link_sta =
 			rcu_dereference_protected(mvm_sta->link[link_id],
 						  lockdep_is_held(&mvm->mutex));
@@ -983,9 +983,9 @@ int iwl_mvm_mld_update_sta_links(struct iwl_mvm *mvm,
 
 	for_each_set_bit(link_id, &links_to_add, IEEE80211_MLD_MAX_NUM_LINKS) {
 		struct ieee80211_bss_conf *link_conf =
-			rcu_dereference_protected(vif->link_conf[link_id], 1);
+			link_conf_dereference_protected(vif, link_id);
 		struct ieee80211_link_sta *link_sta =
-			rcu_dereference_protected(sta->link[link_id], 1);
+			link_sta_dereference_protected(sta, link_id);
 		mvm_vif_link = mvm_vif->link[link_id];
 
 		if (WARN_ON(!mvm_vif_link || !link_conf || !link_sta ||
-- 
2.38.1

