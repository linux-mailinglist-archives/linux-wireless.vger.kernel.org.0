Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0198701C80
	for <lists+linux-wireless@lfdr.de>; Sun, 14 May 2023 11:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjENJQw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 May 2023 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjENJQt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 May 2023 05:16:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650DC2D70
        for <linux-wireless@vger.kernel.org>; Sun, 14 May 2023 02:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684055799; x=1715591799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BAoLqJ5rb6uPqOvYCsZDdr3WhODaylVNSUFgDKd9ogU=;
  b=B/cOy0xhapzqizVTEphYKX6CqoLrxMVsO7O8TttRZ5qSc3aG65UZIVPe
   8OOjab/eC+vfH+XhZ8XxHbtvsGyynw70QnLVA97EDYwcd1HFN0kXrdz9v
   aydnYKqSDW0ijmYpW4uMwaVeLDDY0TNNi+LSFQVyhXImKDE/cpdQxvZD4
   +kCZY3kofqF01S84cqFIN7R7+FX04bkoL/SfD5OKf0kn5o27x/vA3q4VG
   dzcM1hrzVg0ReU9o2oEf233EzNCfz2baanV4qgoxPq8EeX5yOXeysTnbZ
   zUYchRgfZSy2W5DW5NSdwGt5I1VsGwdfKYjjpgdus7vKJwUkJkmNmot8Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="340366866"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="340366866"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10709"; a="731300472"
X-IronPort-AV: E=Sophos;i="5.99,274,1677571200"; 
   d="scan'208";a="731300472"
Received: from seran-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.239.223])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2023 02:16:37 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless 11/12] wifi: iwlwifi: Don't use valid_links to iterate sta links
Date:   Sun, 14 May 2023 12:15:54 +0300
Message-Id: <20230514120631.f32a8c08730a.Ib02248cd0b7f2bc885f91005c3c110dd027f9dcd@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230514091555.168392-1-gregory.greenman@intel.com>
References: <20230514091555.168392-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This bitmap equals to zero when in a non-MLO mode, and then we won't
be iterating on any link. Use for_each_sta_active_link() instead, as
it handles also the case of non-MLO mode.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 52 ++++++++-----------
 1 file changed, 22 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 1c96cf020801..17f788a5ff6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2022 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -3607,7 +3607,8 @@ static bool iwl_mvm_vif_conf_from_sta(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta)
 {
-	unsigned int i;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
 	/* Beacon interval check - firmware will crash if the beacon
 	 * interval is less than 16. We can't avoid connecting at all,
@@ -3616,14 +3617,11 @@ static bool iwl_mvm_vif_conf_from_sta(struct iwl_mvm *mvm,
 	 * wpa_s will blocklist the AP...
 	 */
 
-	for_each_set_bit(i, (unsigned long *)&sta->valid_links,
-			 IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_link_sta *link_sta =
-			link_sta_dereference_protected(sta, i);
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, i);
+			link_conf_dereference_protected(vif, link_id);
 
-		if (!link_conf || !link_sta)
+		if (!link_conf)
 			continue;
 
 		if (link_conf->beacon_int < IWL_MVM_MIN_BEACON_INTERVAL_TU) {
@@ -3645,24 +3643,23 @@ static void iwl_mvm_vif_set_he_support(struct ieee80211_hw *hw,
 				       bool is_sta)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	unsigned int i;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
-	for_each_set_bit(i, (unsigned long *)&sta->valid_links,
-			 IEEE80211_MLD_MAX_NUM_LINKS) {
-		struct ieee80211_link_sta *link_sta =
-			link_sta_dereference_protected(sta, i);
+	for_each_sta_active_link(vif, sta, link_sta, link_id) {
 		struct ieee80211_bss_conf *link_conf =
-			link_conf_dereference_protected(vif, i);
+			link_conf_dereference_protected(vif, link_id);
 
-		if (!link_conf || !link_sta || !mvmvif->link[i])
+		if (!link_conf || !mvmvif->link[link_id])
 			continue;
 
 		link_conf->he_support = link_sta->he_cap.has_he;
 
 		if (is_sta) {
-			mvmvif->link[i]->he_ru_2mhz_block = false;
+			mvmvif->link[link_id]->he_ru_2mhz_block = false;
 			if (link_sta->he_cap.has_he)
-				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif, i,
+				iwl_mvm_check_he_obss_narrow_bw_ru(hw, vif,
+								   link_id,
 								   link_conf);
 		}
 	}
@@ -3675,6 +3672,7 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 				   struct iwl_mvm_sta_state_ops *callbacks)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct ieee80211_link_sta *link_sta;
 	unsigned int i;
 	int ret;
 
@@ -3699,15 +3697,9 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 					   NL80211_TDLS_SETUP);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sta->link); i++) {
-		struct ieee80211_link_sta *link_sta;
-
-		link_sta = link_sta_dereference_protected(sta, i);
-		if (!link_sta)
-			continue;
-
+	for_each_sta_active_link(vif, sta, link_sta, i)
 		link_sta->agg.max_rc_amsdu_len = 1;
-	}
+
 	ieee80211_sta_recalc_aggregates(sta);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
@@ -3725,7 +3717,8 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm_sta *mvm_sta = iwl_mvm_sta_from_mac80211(sta);
-	unsigned int i;
+	struct ieee80211_link_sta *link_sta;
+	unsigned int link_id;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -3751,14 +3744,13 @@ iwl_mvm_sta_state_auth_to_assoc(struct ieee80211_hw *hw,
 		if (!mvm->mld_api_is_used)
 			goto out;
 
-		for_each_set_bit(i, (unsigned long *)&sta->valid_links,
-				 IEEE80211_MLD_MAX_NUM_LINKS) {
+		for_each_sta_active_link(vif, sta, link_sta, link_id) {
 			struct ieee80211_bss_conf *link_conf =
-				link_conf_dereference_protected(vif, i);
+				link_conf_dereference_protected(vif, link_id);
 
 			if (WARN_ON(!link_conf))
 				return -EINVAL;
-			if (!mvmvif->link[i])
+			if (!mvmvif->link[link_id])
 				continue;
 
 			iwl_mvm_link_changed(mvm, vif, link_conf,
-- 
2.38.1

