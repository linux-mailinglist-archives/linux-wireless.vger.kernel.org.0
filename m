Return-Path: <linux-wireless+bounces-7192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C638BBF7A
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 08:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09441C20CC1
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2024 06:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971286FB6;
	Sun,  5 May 2024 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsnrfGi7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8E4428
	for <linux-wireless@vger.kernel.org>; Sun,  5 May 2024 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714890041; cv=none; b=k4x882fMZy2v9RV08Emtr+bBiutyvu7E5Q044x3M70m5/ZGma2cFZTCWWMywqidDstrJ2DYllnhhF/wyJJE0pOBjFpv7Kg3RqCrbffdcFDQFhcx1q/rV4ye7IFVbTuJrFZNRhWutwLvXYK0yeOf1rOfYpCNln+bOWDmiH2PvA8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714890041; c=relaxed/simple;
	bh=Q+aDnm22/nlSBkH5Rj7FRUsaXjzBXkJkUr/a4t83cMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Je2HZmIlAiXNHUmO4N4pF58Si/aKmie4uDPvOekVMKZr0tV5J3vHV41WtzjxyGF+uY40qRpE1xSRUDywUBJSHbE1dUrZQnLp7aZ/g73doVcgvy3VQsYgLgHUv0H2fdKDUuJrCJIw1XR0PYGJLPgFmTuSi+tOI6plbtTTJ9XFps4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsnrfGi7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714890040; x=1746426040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q+aDnm22/nlSBkH5Rj7FRUsaXjzBXkJkUr/a4t83cMY=;
  b=OsnrfGi7F2G4jrTAXcLld+WhyxLlVU1iNKxWQfjvtHSIJcfQaz8fmQ8A
   c8c7t1tEt9BbcCjfVokkdXkTg9sn0+qTmzH8s+Aw3pCWs9SQLhvIb0FEh
   /aaUmK1Zw44vsEisD6OEZlbkFwG/wgm0nqpwQuhq44FFhmGEJukY+A5q1
   vintcXvekgqX7Cxs04ofrofK06/KvplAuFTgSPrFpa+PjyCyZw1mBRplB
   X2PcFJOolJY3XSYqMrDKXOPtTUi5UR9wZ1RY21rNahQ9BQ7FiVIbH5cbi
   JOzet2e+vU1LJJMbQdFL5XA2JDeOeyAjN8InySjRs3APv74y1vuVvROoQ
   w==;
X-CSE-ConnectionGUID: pOHfy1eATSGfDmSqSsJMUA==
X-CSE-MsgGUID: XgF9aFv0R7qHJD6GYr8X3g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="14461836"
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="14461836"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:39 -0700
X-CSE-ConnectionGUID: SF3GOmhOQC6gZAGUlOphxQ==
X-CSE-MsgGUID: n0kgHZy2T2e3HHWg0ZtWPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,255,1708416000"; 
   d="scan'208";a="27903638"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2024 23:20:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: Print EMLSR states name
Date: Sun,  5 May 2024 09:19:58 +0300
Message-Id: <20240505091420.f3509cf652f2.Ic086b6b2132ffe249b3c4bdd24c673ce7fd1b614@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
References: <20240505061959.825245-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

This is useful for debug instead of looking for the hex value.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 57 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 7c8cfa72b8bb..42949537da54 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -5,6 +5,34 @@
 #include "mvm.h"
 #include "time-event.h"
 
+#define HANDLE_ESR_REASONS(HOW)		\
+	HOW(BLOCKED_PREVENTION)		\
+	HOW(BLOCKED_WOWLAN)		\
+	HOW(BLOCKED_TPT)		\
+	HOW(BLOCKED_FW)			\
+	HOW(BLOCKED_NON_BSS)		\
+	HOW(EXIT_MISSED_BEACON)		\
+	HOW(EXIT_LOW_RSSI)		\
+	HOW(EXIT_COEX)			\
+	HOW(EXIT_BANDWIDTH)		\
+	HOW(EXIT_CSA)
+
+static const char *const iwl_mvm_esr_states_names[] = {
+#define NAME_ENTRY(x) [ilog2(IWL_MVM_ESR_##x)] = #x,
+	HANDLE_ESR_REASONS(NAME_ENTRY)
+};
+
+static const char *iwl_get_esr_state_string(enum iwl_mvm_esr_state state)
+{
+	int offs = ilog2(state);
+
+	if (offs >= ARRAY_SIZE(iwl_mvm_esr_states_names) ||
+	    !iwl_mvm_esr_states_names[offs])
+		return "UNKNOWN";
+
+	return iwl_mvm_esr_states_names[offs];
+}
+
 static u32 iwl_mvm_get_free_fw_link_id(struct iwl_mvm *mvm,
 				       struct iwl_mvm_vif *mvm_vif)
 {
@@ -680,10 +708,16 @@ iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
 	if (conf->csa_active)
 		ret |= IWL_MVM_ESR_EXIT_CSA;
 
+#define NAME_FMT(x) "%s"
+#define NAME_PR(x) (ret & IWL_MVM_ESR_##x) ? "[" #x "]" : "",
+
 	if (ret)
 		IWL_DEBUG_INFO(mvm,
-			       "Link %d is not allowed for esr. Reason: 0x%x\n",
-			       link->link_id, ret);
+			       "Link %d is not allowed for esr. reason = "
+			       HANDLE_ESR_REASONS(NAME_FMT) " (0x%x)\n",
+			       link->link_id,
+			       HANDLE_ESR_REASONS(NAME_PR)
+			       ret);
 	return ret;
 }
 
@@ -903,8 +937,9 @@ static bool iwl_mvm_check_esr_prevention(struct iwl_mvm *mvm,
 		IWL_MVM_ESR_PREVENT_LONG;
 
 	IWL_DEBUG_INFO(mvm,
-		       "Preventing EMLSR for %ld seconds due to %u exits with the reason 0x%x\n",
-		       delay / HZ, mvmvif->exit_same_reason_count, reason);
+		       "Preventing EMLSR for %ld seconds due to %u exits with the reason = %s (0x%x)\n",
+		       delay / HZ, mvmvif->exit_same_reason_count,
+		       iwl_get_esr_state_string(reason), reason);
 
 	wiphy_delayed_work_queue(mvm->hw->wiphy,
 				 &mvmvif->prevent_esr_done_wk, delay);
@@ -936,8 +971,9 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 	new_active_links = BIT(link_to_keep);
 	IWL_DEBUG_INFO(mvm,
-		       "Exiting EMLSR. Reason = 0x%x. Current active links=0x%x, new active links = 0x%x\n",
-		       reason, vif->active_links, new_active_links);
+		       "Exiting EMLSR. reason = %s (0x%x). Current active links=0x%x, new active links = 0x%x\n",
+		       iwl_get_esr_state_string(reason), reason,
+		       vif->active_links, new_active_links);
 
 	ieee80211_set_active_links_async(vif, new_active_links);
 
@@ -975,8 +1011,9 @@ void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		return;
 
 	if (!(mvmvif->esr_disable_reason & reason))
-		IWL_DEBUG_INFO(mvm, "Blocking EMLSR mode. reason = 0x%x\n",
-			       reason);
+		IWL_DEBUG_INFO(mvm,
+			       "Blocking EMLSR mode. reason = %s (0x%x)\n",
+			       iwl_get_esr_state_string(reason), reason);
 
 	mvmvif->esr_disable_reason |= reason;
 
@@ -1061,7 +1098,9 @@ void iwl_mvm_unblock_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (!(mvmvif->esr_disable_reason & reason))
 		return;
 
-	IWL_DEBUG_INFO(mvm, "Unblocking EMLSR mode. reason = 0x%x\n", reason);
+	IWL_DEBUG_INFO(mvm,
+		       "Unblocking EMLSR mode. reason = %s (0x%x)\n",
+		       iwl_get_esr_state_string(reason), reason);
 
 	mvmvif->esr_disable_reason &= ~reason;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 115aa1ad970e..56467b9de7f1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -353,6 +353,8 @@ struct iwl_mvm_vif_link_info {
  * For the blocking reasons - use iwl_mvm_(un)block_esr(), and for the exit
  * reasons - use iwl_mvm_exit_esr().
  *
+ * Note: new reasons shall be added to HANDLE_ESR_REASONS as well (for logs)
+ *
  * @IWL_MVM_ESR_BLOCKED_PREVENTION: Prevent EMLSR to avoid entering and exiting
  *	in a loop.
  * @IWL_MVM_ESR_BLOCKED_WOWLAN: WOWLAN is preventing the enablement of EMLSR
-- 
2.34.1


