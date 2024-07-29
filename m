Return-Path: <linux-wireless+bounces-10623-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6728093FC4B
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA0E5B23024
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B8D16F0E7;
	Mon, 29 Jul 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WinuKeNP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1BA15F3EA
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273636; cv=none; b=bmeN4XuIwbtZfANzh/jKczpYD6dgTe2mvfyG/hDaBdLe9SqsUbJcFTWlV2P1KjcrAL6A7iwYSZxrVYjz/FNIBfmhwHFK7/f5BRNpnlrrSMH1oRC5O76tDYL9M6NBh7KH13+DC6dt7XkN7nOL2P1y/9A0oyqMgbE4QyqR+pOjP1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273636; c=relaxed/simple;
	bh=TdJcwoGbXIqi4dSr6mfoBhylZDeLZWuV4HAgHGVQwgE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rDD33UZNFXIwyq0eyyo2eYnWQcwCxDbqPfgUcu+lg/2b1NF7LQ7+CkmfjyVYfZjMmk/4KE3OYXsF1hwgZpGmKtCdndSoYDRuUqOHPTqhhhbOMY/1o9lnArziiQdSL67PDQc48rBZw5TKm3HyTGYOXN1rnq8/A0BREPwEUtOZ7Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WinuKeNP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273635; x=1753809635;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TdJcwoGbXIqi4dSr6mfoBhylZDeLZWuV4HAgHGVQwgE=;
  b=WinuKeNPUeHFYCeJKQXoH7tVnmAy1XPdmFDIQ2oFTY9UMrheaGJnbMJ4
   iEiQTYHe7mO1L4BWqzBEMXuze0RilQWzuTUV+yWaMbLWbaqr1HICYcRaX
   lFw6BqUAYMedrxglAdEXF++u5gHdOG13ZV6Cq0z3tGTP5mEtNc8qxxRru
   mwTZCCWtJGJrDhbcFBifVHZDTV0zEIeapbzJ4gNsGAOGydYaBPohnK+vc
   MaHbN776k7YybknFCsqEqUSKC9lPjGuocMzXYBqLK7e9z/umH4FGZlmFl
   P9q8RfTJkGMJ8OrJBnIlh5eoUw31cPGAX+FZIhcjSWmWz/qXKcJkSEaAp
   A==;
X-CSE-ConnectionGUID: ahtAja/VSfiId7EcLAGtvA==
X-CSE-MsgGUID: kb59tZvjTZ6Qu8/fN7Qs4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445568"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445568"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:35 -0700
X-CSE-ConnectionGUID: j2vxSz+uQeqcCdEoeoQ7OA==
X-CSE-MsgGUID: YE2GQKZVS/C0I7vmE/dRZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288266"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:33 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 03/17] wifi: iwlwifi: remove MVM prefix from FW macros
Date: Mon, 29 Jul 2024 20:20:04 +0300
Message-Id: <20240729201718.939b32f84f46.I293957bf172680871eba24448d9d1870e49100b6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

These are not mvm specific.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/api/stats.h   | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h        | 4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c         | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c        | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h        | 2 +-
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
index ca6fa66d1917..b9ed42faa63e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/mac-cfg.h
@@ -524,8 +524,8 @@ struct iwl_link_config_cmd {
 /* Currently FW supports link ids in the range 0-3 and can have
  * at most two active links for each vif.
  */
-#define IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM 2
-#define IWL_MVM_FW_MAX_LINK_ID 3
+#define IWL_FW_MAX_ACTIVE_LINKS_NUM 2
+#define IWL_FW_MAX_LINK_ID 3
 
 /**
  * enum iwl_fw_sta_type - FW station types
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
index 2271b19213fa..659cb40ecfb4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/stats.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018, 2020 - 2021, 2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018, 2020 - 2021, 2023 - 2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -594,7 +594,7 @@ struct iwl_stats_ntfy_per_sta {
 } __packed; /* STATISTICS_NTFY_PER_STA_API_S_VER_1 */
 
 #define IWL_STATS_MAX_PHY_OPERATIONAL 3
-#define IWL_STATS_MAX_FW_LINKS	(IWL_MVM_FW_MAX_LINK_ID + 1)
+#define IWL_STATS_MAX_FW_LINKS	(IWL_FW_MAX_LINK_ID + 1)
 
 /**
  * struct iwl_system_statistics_notif_oper
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index e279fd409b6f..08546e673cf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1483,7 +1483,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 		RCU_INIT_POINTER(mvm->fw_id_to_link_sta[i], NULL);
 	}
 
-	for (i = 0; i < IWL_MVM_FW_MAX_LINK_ID + 1; i++)
+	for (i = 0; i < IWL_FW_MAX_LINK_ID + 1; i++)
 		RCU_INIT_POINTER(mvm->link_id_to_link_conf[i], NULL);
 
 	mvm->tdls_cs.peer.sta_id = IWL_MVM_INVALID_STA;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 22f48b66d79c..e2cc378d6d91 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1164,7 +1164,7 @@ struct iwl_mvm {
 
 	struct ieee80211_vif __rcu *vif_id_to_mac[NUM_MAC_INDEX_DRIVER];
 
-	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_MVM_FW_MAX_LINK_ID + 1];
+	struct ieee80211_bss_conf __rcu *link_id_to_link_conf[IWL_FW_MAX_LINK_ID + 1];
 
 	/* -1 for always, 0 for never, >0 for that many times */
 	s8 fw_restart;
@@ -1745,7 +1745,7 @@ static inline int iwl_mvm_max_active_links(struct iwl_mvm *mvm,
 	if (iwl_mvm_is_esr_supported(trans) ||
 	    (CSR_HW_RFID_TYPE(trans->hw_rf_id) == IWL_CFG_RF_TYPE_FM &&
 	     CSR_HW_RFID_IS_CDB(trans->hw_rf_id)))
-		return IWL_MVM_FW_MAX_ACTIVE_LINKS_NUM;
+		return IWL_FW_MAX_ACTIVE_LINKS_NUM;
 
 	return 1;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 151289e13308..bc8078875c5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -991,7 +991,7 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
 
 		/* The link IDs that doesn't exist will contain 0 */
-		for (int link = 0; link < IWL_MVM_FW_MAX_LINK_ID; link++) {
+		for (int link = 0; link < IWL_FW_MAX_LINK_ID; link++) {
 			total_tx += mvmsta->mpdu_counters[q].per_link[link].tx;
 			total_rx += mvmsta->mpdu_counters[q].per_link[link].rx;
 		}
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 15e64d94d6ea..550c97a014b9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -4458,7 +4458,7 @@ void iwl_mvm_count_mpdu(struct iwl_mvm_sta *mvm_sta, u8 fw_sta_id, u32 count,
 		IWL_DEBUG_STATS(mvm, "MPDU counters are cleared\n");
 	}
 
-	for (int i = 0; i < IWL_MVM_FW_MAX_LINK_ID; i++)
+	for (int i = 0; i < IWL_FW_MAX_LINK_ID; i++)
 		total_mpdus += tx ? queue_counter->per_link[i].tx :
 				    queue_counter->per_link[i].rx;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
index 0dc83d6afb3c..193a1edc38d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.h
@@ -361,7 +361,7 @@ struct iwl_mvm_mpdu_counter {
  */
 struct iwl_mvm_tpt_counter {
 	spinlock_t lock;
-	struct iwl_mvm_mpdu_counter per_link[IWL_MVM_FW_MAX_LINK_ID];
+	struct iwl_mvm_mpdu_counter per_link[IWL_FW_MAX_LINK_ID];
 	unsigned long window_start;
 } ____cacheline_aligned_in_smp;
 
-- 
2.34.1


