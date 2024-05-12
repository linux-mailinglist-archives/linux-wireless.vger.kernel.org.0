Return-Path: <linux-wireless+bounces-7524-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D498C350F
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 06:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F9E281C57
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 04:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13F1CD29;
	Sun, 12 May 2024 04:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMVujXq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6F1CAAF
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 04:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715488305; cv=none; b=Va6VjDb7kOJwG+EGTkNs0mUkU66TfC5RYUdf3FQGCWeqhGrw6mh5+uO4LeRaArFEFdBxpWq3uXR0WZFVSQfQKKrW7zwqXvENa6oUFaoGGKNAjG0O/7dtXX0T8ECBUY4fQ4xiJWPjmWHhwSIVFF+0RHTq2EFy07rpPzlNSyRjd4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715488305; c=relaxed/simple;
	bh=wOQxW2LdvztdWJbk2efwWJDEqDHxFJ7VbJ3xuJna98w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OR1zaqbbQoJDa7VB3tkmoNJ77hhMzD9zv1DZoCkg8KGCU2VFstzLpi+igKK7boTMZDByVBKIjvcyNvZ/0jXaCmid0cSc7pGLceAHWI0tAaZ47j+EqVAN5np3MafcTNWGGNI9+jb5dq5/tgQL48TOg91qMSqCRpt+ENb8LqkO6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMVujXq5; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715488303; x=1747024303;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wOQxW2LdvztdWJbk2efwWJDEqDHxFJ7VbJ3xuJna98w=;
  b=JMVujXq5DUKiAjOCckMi33q4P9Ncy/HA4hyUPjsrGoFyZxtV4fR2GWM3
   l3Ci2JzUh4gaY6LXd/F8HGvd1cwGZjuTgZDpGuEj/FjXmnHs6ydIB0jgC
   yplnPLrRJx5xHfme3wj5FLmiSu9xcYbVreITOMUKnRyg54DQWIXoAiWz/
   H0szlERceTPhInWYhOz+eYKfQjn8lfj4oZuA/nXLJD41ngESJpGiq3IKo
   D9YDvkBUtbkuV7Ophgl/SX6SshEY/qjOutHdzg/GkyKbw/9Dfr6a3bE0b
   vno7vn96lTHHIPJYGn2FtuHKbyvwEMgF+chvwRrYxM0i/dTo7ARXrZEzd
   A==;
X-CSE-ConnectionGUID: b7XX8QppR56ch+mH8guokQ==
X-CSE-MsgGUID: ukhrtrRpSjq8OzPdrWBkyg==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11323866"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11323866"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:43 -0700
X-CSE-ConnectionGUID: 1rzcfEnTTUiIGyOZZofAkQ==
X-CSE-MsgGUID: a7rzdvVuQ2ezFvvSJ4JzQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34532187"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 21:31:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 13/16] wifi: iwlwifi: mvm: don't track used links separately
Date: Sun, 12 May 2024 07:31:07 +0300
Message-Id: <20240512072733.1a67d8af815f.Ie642c12dce3ab55c688abd9a25918569e83e558a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
References: <20240512043110.3413383-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We track which link is using which FW link ID, so there
really isn't a need to separately track which link IDs
are in use. Remove that code and check the table when
looking for a new link ID to use.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  2 --
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 22 +++++--------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 3 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ca7fcae6995e..87cc1471dfdd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1499,8 +1499,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	for (i = 0; i < IWL_MVM_FW_MAX_LINK_ID + 1; i++)
 		RCU_INIT_POINTER(mvm->link_id_to_link_conf[i], NULL);
 
-	memset(&mvm->fw_link_ids_map, 0, sizeof(mvm->fw_link_ids_map));
-
 	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
 
 	/* reset quota debouncing buffer - 0xff will yield invalid data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 6ec9a8e21a34..14dab617c0bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -50,26 +50,15 @@ static void iwl_mvm_print_esr_state(struct iwl_mvm *mvm, u32 mask)
 static u32 iwl_mvm_get_free_fw_link_id(struct iwl_mvm *mvm,
 				       struct iwl_mvm_vif *mvm_vif)
 {
-	u32 link_id;
+	u32 i;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	link_id = ffz(mvm->fw_link_ids_map);
+	for (i = 0; i < ARRAY_SIZE(mvm->link_id_to_link_conf); i++)
+		if (!rcu_access_pointer(mvm->link_id_to_link_conf[i]))
+			return i;
 
-	/* this case can happen if there're deactivated but not removed links */
-	if (link_id > IWL_MVM_FW_MAX_LINK_ID)
-		return IWL_MVM_FW_LINK_ID_INVALID;
-
-	mvm->fw_link_ids_map |= BIT(link_id);
-	return link_id;
-}
-
-static void iwl_mvm_release_fw_link_id(struct iwl_mvm *mvm, u32 link_id)
-{
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!WARN_ON(link_id > IWL_MVM_FW_MAX_LINK_ID))
-		mvm->fw_link_ids_map &= ~BIT(link_id);
+	return IWL_MVM_FW_LINK_ID_INVALID;
 }
 
 static int iwl_mvm_link_cmd_send(struct iwl_mvm *mvm,
@@ -380,7 +369,6 @@ int iwl_mvm_unset_link_mapping(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	RCU_INIT_POINTER(mvm->link_id_to_link_conf[link_info->fw_link_id],
 			 NULL);
-	iwl_mvm_release_fw_link_id(mvm, link_info->fw_link_id);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ca1c5944da67..d732780aae5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1043,7 +1043,6 @@ struct iwl_mvm {
 	struct iwl_rx_phy_info last_phy_info;
 	struct ieee80211_sta __rcu *fw_id_to_mac_id[IWL_MVM_STATION_COUNT_MAX];
 	struct ieee80211_link_sta __rcu *fw_id_to_link_sta[IWL_MVM_STATION_COUNT_MAX];
-	unsigned long fw_link_ids_map;
 	u8 rx_ba_sessions;
 
 	/* configured by mac80211 */
-- 
2.34.1


