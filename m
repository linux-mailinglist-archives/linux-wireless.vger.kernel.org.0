Return-Path: <linux-wireless+bounces-30654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E1DD0F865
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C8E133062E32
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C234CFCF;
	Sun, 11 Jan 2026 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2MibGx3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43A721ABBB
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153183; cv=none; b=kUEEThJ3CY/Mx5zoPjNHA9GNhJZTJM0PYZBHDkIxZHPC8YMvpt3YuMDup6fO6AxwS3x7y0UcJoOLxuAwhh+3+cwvdPDDuNTpkNpB6WeMvLnrKRLugy/Np8ZudabT82JkksnM1H9TGoH4/yEOR2TqP5n9j7vEK3oxif5H7zraZCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153183; c=relaxed/simple;
	bh=i051tcTKhuei/lfG+CVlOMWQ2/enG/ChckSKoLnNyaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NFcKEGoHf46rOZxSRLAkXfwifbll4mgl5Q3ljFYFkJSrDNJUra4iSU1Kjo6y55UfwywYJdcWfLJhUXRuXN2CYrma4RSb7CqiTX4MUoUfHbJLmuVboVoGktTVOmt45Q7nJ9Bn6fcUKfH5z69ty7eVg+6itzVdvMtnJUxw3LZ4gCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2MibGx3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153182; x=1799689182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i051tcTKhuei/lfG+CVlOMWQ2/enG/ChckSKoLnNyaU=;
  b=h2MibGx3Hksw8FqUfwnCZ0aJoNQwCkdvPfArfGvzm0hzpXvi2A0Mp3Gx
   Fu6HoO9mpzKh4RkxTraHDylgZlRzIrCnDMWwZKAJJwg7gZDbtem2yDM2a
   MOKJkhyjSOEftjyEZLUeQZWh7mB/HD8ZQvFegFQhqwjZR2KsaErB26Ir9
   LZmWHa9jfSfK1YrffaXT9OPffJpPWhzCrlkyDeK4l4R5gtA5hpn31MA5X
   G+8um0C2/FAOEj3pnKof8JH82Omu/2zG0AhKJK825iC3KnYv0+38JpXL8
   48dyXpSlyeCybRD21uQw2SbBZu+aF87Q2nbUtsN6v2drBCbB3FHxP4frj
   A==;
X-CSE-ConnectionGUID: 7Z1/S7CXToKzkeSQWbH3rQ==
X-CSE-MsgGUID: LWeXQ0YYTnO0MzjweEy6NA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521087"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521087"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:41 -0800
X-CSE-ConnectionGUID: OliJjy4FR16k3HAOgM7otg==
X-CSE-MsgGUID: cy4mvMB7QQ2NMwK5xFBMCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393790"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:40 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: mld: prevent EMLSR when NAN is active
Date: Sun, 11 Jan 2026 19:39:16 +0200
Message-Id: <20260111193638.8baef343023a.Ie94e5f32db003ebce33bde65e0ed8c6d98673b5a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

EMLSR is not allowed when NAN is active. Block EMLSR when starting NAN,
and unblock EMLSR when NAN is stopped.

Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 ++
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  3 +++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 20 ++++++++++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  5 +++++
 drivers/net/wireless/intel/iwlwifi/mld/nan.c  | 18 +++++++++++++++--
 5 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index a3573d20f214..62fca166afd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -32,6 +32,7 @@ enum iwl_mld_cca_40mhz_wa_status {
  *      link is preventing EMLSR. This is a temporary blocking that is set when
  *      there is an indication that a non-BSS interface is to be added.
  * @IWL_MLD_EMLSR_BLOCKED_TPT: throughput is too low to make EMLSR worthwhile
+ * @IWL_MLD_EMLSR_BLOCKED_NAN: NAN is preventing EMLSR.
  */
 enum iwl_mld_emlsr_blocked {
 	IWL_MLD_EMLSR_BLOCKED_PREVENTION	= 0x1,
@@ -40,6 +41,7 @@ enum iwl_mld_emlsr_blocked {
 	IWL_MLD_EMLSR_BLOCKED_NON_BSS		= 0x8,
 	IWL_MLD_EMLSR_BLOCKED_TMP_NON_BSS	= 0x10,
 	IWL_MLD_EMLSR_BLOCKED_TPT		= 0x20,
+	IWL_MLD_EMLSR_BLOCKED_NAN		= 0x40,
 };
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 411a2d56e5f0..df8221277d51 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1784,6 +1784,9 @@ static int iwl_mld_move_sta_state_up(struct iwl_mld *mld,
 			/* Ensure any block due to a non-BSS link is synced */
 			iwl_mld_emlsr_check_non_bss_block(mld, 0);
 
+			/* Ensure NAN block is synced */
+			iwl_mld_emlsr_check_nan_block(mld, vif);
+
 			/* Block EMLSR until a certain throughput it reached */
 			if (!mld->fw_status.in_hw_restart &&
 			    IWL_MLD_ENTER_EMLSR_TPT_THRESH > 0)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 87f67ddfced4..f842f5183223 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -12,7 +12,8 @@
 	HOW(ROC)			\
 	HOW(NON_BSS)			\
 	HOW(TMP_NON_BSS)		\
-	HOW(TPT)
+	HOW(TPT)			\
+	HOW(NAN)
 
 static const char *
 iwl_mld_get_emlsr_blocked_string(enum iwl_mld_emlsr_blocked blocked)
@@ -478,8 +479,8 @@ iwl_mld_vif_iter_update_emlsr_block(void *_data, u8 *mac,
 	}
 }
 
-static int iwl_mld_update_emlsr_block(struct iwl_mld *mld, bool block,
-				      enum iwl_mld_emlsr_blocked reason)
+int iwl_mld_update_emlsr_block(struct iwl_mld *mld, bool block,
+			       enum iwl_mld_emlsr_blocked reason)
 {
 	struct iwl_mld_update_emlsr_block_data block_data = {
 		.block = block,
@@ -1210,3 +1211,16 @@ void iwl_mld_stop_ignoring_tpt_updates(struct iwl_mld *mld)
 						iwl_mld_ignore_tpt_iter,
 						&start);
 }
+
+int iwl_mld_emlsr_check_nan_block(struct iwl_mld *mld, struct ieee80211_vif *vif)
+{
+	if (mld->nan_device_vif &&
+	    ieee80211_vif_nan_started(mld->nan_device_vif))
+		return iwl_mld_block_emlsr_sync(mld, vif,
+						IWL_MLD_EMLSR_BLOCKED_NAN,
+						iwl_mld_get_primary_link(vif));
+
+	iwl_mld_unblock_emlsr(mld, vif, IWL_MLD_EMLSR_BLOCKED_NAN);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
index d936589fe39d..ccc3a7afa095 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.h
@@ -150,6 +150,11 @@ void iwl_mld_emlsr_check_chan_load(struct ieee80211_hw *hw,
  */
 void iwl_mld_retry_emlsr(struct iwl_mld *mld, struct ieee80211_vif *vif);
 
+int iwl_mld_emlsr_check_nan_block(struct iwl_mld *mld, struct ieee80211_vif *vif);
+
+int iwl_mld_update_emlsr_block(struct iwl_mld *mld, bool block,
+			       enum iwl_mld_emlsr_blocked reason);
+
 struct iwl_mld_link_sel_data {
 	u8 link_id;
 	const struct cfg80211_chan_def *chandef;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/nan.c b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
index e7a2c1ec7494..d4298f44baf7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/nan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/nan.c
@@ -5,6 +5,7 @@
 
 #include "mld.h"
 #include "iface.h"
+#include "mlo.h"
 #include "fw/api/mac-cfg.h"
 
 #define IWL_NAN_DISOVERY_BEACON_INTERNVAL_TU 512
@@ -130,15 +131,25 @@ int iwl_mld_start_nan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	IWL_DEBUG_MAC80211(mld, "NAN: start: bands=0x%x\n", conf->bands);
 
-	ret = iwl_mld_add_aux_sta(mld, aux_sta);
+	ret = iwl_mld_update_emlsr_block(mld, true, IWL_MLD_EMLSR_BLOCKED_NAN);
 	if (ret)
 		return ret;
 
+	ret = iwl_mld_add_aux_sta(mld, aux_sta);
+	if (ret)
+		goto unblock_emlsr;
+
 	ret = iwl_mld_nan_config(mld, vif, conf, FW_CTXT_ACTION_ADD);
 	if (ret) {
 		IWL_ERR(mld, "Failed to start NAN. ret=%d\n", ret);
-		iwl_mld_remove_aux_sta(mld, vif);
+		goto remove_aux;
 	}
+	return 0;
+
+remove_aux:
+	iwl_mld_remove_aux_sta(mld, vif);
+unblock_emlsr:
+	iwl_mld_update_emlsr_block(mld, false, IWL_MLD_EMLSR_BLOCKED_NAN);
 
 	return ret;
 }
@@ -190,6 +201,9 @@ int iwl_mld_stop_nan(struct ieee80211_hw *hw,
 	iwl_mld_cancel_notifications_of_object(mld,
 					       IWL_MLD_OBJECT_TYPE_NAN,
 					       0);
+
+	iwl_mld_update_emlsr_block(mld, false, IWL_MLD_EMLSR_BLOCKED_NAN);
+
 	return 0;
 }
 
-- 
2.34.1


