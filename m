Return-Path: <linux-wireless+bounces-8123-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C78D07F9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9B72A8A27
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89E015EFC8;
	Mon, 27 May 2024 16:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9S0VpnF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76815EFC4
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825998; cv=none; b=rqQZuDAmX78vv2Bxevbz2JziTE284X6yyMfBp8sVSVDw1ck2xLtzMp/uDf93AHVuGxg+KglCk4oNDy1Z/YoAIQ+/R08qGObZakTe0M13L5aQQQQRj2YxTOvk+UiGTGIZRZKV5Bts6R+/XuPDi2BTdJtTMlIgmTOYeya2OHfa0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825998; c=relaxed/simple;
	bh=euGrkW9C9BReiYgJyxO/H5u2czTaAPCJR+tq2G0J10k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BcwgC7kispFDwDeDImE3vpb3LWUZQ4ZfBFtwwlMDtgVQBcnRwt9GVaTf5ZsS96nvzTNVKcPTzEgK1eCT77xPfd6JC+iIUvw/fN9P5zi4qU2tVaDJvGwoGiQsOAP427gGDdF3cBFr/jNn9N9vaFnTlZ0fcvlE+p7dgpKtzVM0/Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9S0VpnF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825998; x=1748361998;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=euGrkW9C9BReiYgJyxO/H5u2czTaAPCJR+tq2G0J10k=;
  b=C9S0VpnFyB0CwyVYQcSZwBVYD6OlzGtuCFtb8RONNQjGnWnKVc9W/xqH
   3Yf9N9oV6PgMpFGDhzIljEF277z1d8bC27opAvBwQZxvZG7QtlX+HHNMi
   /JbGR4qj4nepkzogA6pJsj4gI6MmM+8tj4fPtR0klZzqp5nwB9s7h1LtZ
   REWEULp/zDHI84q7Dyyt3Bke1qVe4P64gyBKkV7Mq4zETy7MXPVlHbgpp
   s97rIDE5jCMKTMhxAf5W/hZk7UH594xAESYqTgtiBuNkCfisevaXNTylW
   Kl71nC+9ln/71HzOw8GCeQWbSqgEJ1Zx71x2m6W6RLeHazFODoTMdA+U3
   Q==;
X-CSE-ConnectionGUID: igvl3rVgS1u9DARcIRT5XA==
X-CSE-MsgGUID: COGY1XKlQo6zDqzvMek3Qw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002089"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002089"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:38 -0700
X-CSE-ConnectionGUID: aJmBKKzYTjmpmlR/y0geAw==
X-CSE-MsgGUID: bZ1Du0VqSvG4WEzP9NPMUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407099"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 09/20] wifi: iwlwifi: mvm: initiator: move setting the sta_id into a function
Date: Mon, 27 May 2024 19:06:04 +0300
Message-Id: <20240527190228.18e3a6a6f1cb.I85e3ee607b3947448532bc16730f8898a11c92b8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
References: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Move setting the target's sta_id (and related flags) into a function
to support different versions of the target struct.
This is done as preparation for moving to the new range request
version.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 55 ++++++++++---------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 98b1bbfc84bc..8596e6f7d1dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -431,9 +431,6 @@ iwl_mvm_ftm_put_target_v2(struct iwl_mvm *mvm,
 	return 0;
 }
 
-#define FTM_PUT_FLAG(flag)	(target->initiator_ap_flags |= \
-				 cpu_to_le32(IWL_INITIATOR_AP_FLAGS_##flag))
-
 #define FTM_SET_FLAG(flag)	(*flags |= \
 				 cpu_to_le32(IWL_INITIATOR_AP_FLAGS_##flag))
 
@@ -525,21 +522,10 @@ iwl_mvm_ftm_put_target_v4(struct iwl_mvm *mvm,
 	return 0;
 }
 
-static int
-iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-		       struct cfg80211_pmsr_request_peer *peer,
-		       struct iwl_tof_range_req_ap_entry_v6 *target)
+static int iwl_mvm_ftm_set_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+			       struct cfg80211_pmsr_request_peer *peer,
+			       u8 *sta_id, __le32 *flags)
 {
-	int ret;
-
-	ret = iwl_mvm_ftm_target_chandef_v2(mvm, peer, &target->channel_num,
-					    &target->format_bw,
-					    &target->ctrl_ch_position);
-	if (ret)
-		return ret;
-
-	iwl_mvm_ftm_put_target_common(mvm, peer, target);
-
 	if (vif->cfg.assoc) {
 		struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 		struct ieee80211_sta *sta;
@@ -551,8 +537,8 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			if (memcmp(peer->addr, link_conf->bssid, ETH_ALEN))
 				continue;
 
-			target->sta_id = mvmvif->link[link_id]->ap_sta_id;
-			sta = rcu_dereference(mvm->fw_id_to_mac_id[target->sta_id]);
+			*sta_id = mvmvif->link[link_id]->ap_sta_id;
+			sta = rcu_dereference(mvm->fw_id_to_mac_id[*sta_id]);
 			if (WARN_ON_ONCE(IS_ERR_OR_NULL(sta))) {
 				rcu_read_unlock();
 				return PTR_ERR_OR_ZERO(sta);
@@ -560,23 +546,42 @@ iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 
 			if (sta->mfp && (peer->ftm.trigger_based ||
 					 peer->ftm.non_trigger_based))
-				FTM_PUT_FLAG(PMF);
+				FTM_SET_FLAG(PMF);
 			break;
 		}
 		rcu_read_unlock();
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 		if (mvmvif->ftm_unprotected) {
-			target->sta_id = IWL_MVM_INVALID_STA;
-			target->initiator_ap_flags &=
-				~cpu_to_le32(IWL_INITIATOR_AP_FLAGS_PMF);
+			*sta_id = IWL_MVM_INVALID_STA;
+			*flags &= ~cpu_to_le32(IWL_INITIATOR_AP_FLAGS_PMF);
 		}
-
 #endif
 	} else {
-		target->sta_id = IWL_MVM_INVALID_STA;
+		*sta_id = IWL_MVM_INVALID_STA;
 	}
 
+	return 0;
+}
+
+static int
+iwl_mvm_ftm_put_target(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
+		       struct cfg80211_pmsr_request_peer *peer,
+		       struct iwl_tof_range_req_ap_entry_v6 *target)
+{
+	int ret;
+
+	ret = iwl_mvm_ftm_target_chandef_v2(mvm, peer, &target->channel_num,
+					    &target->format_bw,
+					    &target->ctrl_ch_position);
+	if (ret)
+		return ret;
+
+	iwl_mvm_ftm_put_target_common(mvm, peer, target);
+
+	iwl_mvm_ftm_set_sta(mvm, vif, peer, &target->sta_id,
+			    &target->initiator_ap_flags);
+
 	/*
 	 * TODO: Beacon interval is currently unknown, so use the common value
 	 * of 100 TUs.
-- 
2.34.1


