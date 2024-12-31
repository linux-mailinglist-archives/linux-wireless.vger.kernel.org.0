Return-Path: <linux-wireless+bounces-16937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6799FEF3C
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE1C18834E8
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558A19A2A2;
	Tue, 31 Dec 2024 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jf/AyLvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007E01993A3
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646378; cv=none; b=WJbHCuqZ7CkUA9EcwvypLiPScZzoHUzTYGA3Hm/3cb01iqfwVzckJXpVmzQuBnPBqj38FYi/PmR1/M4c3HPmPXvjuFBj/w+0dGbdwl3xruqHGh4/kLZ5s2NOuCVa5RAdqrca7icQDILrLIApXIGrgDiEo2B7XpRQCVCgcQ6ASBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646378; c=relaxed/simple;
	bh=GAEPsLYSAjmFWSLLb/gkIbKd9SOlQLJT3SLs41LCsN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gF8nbqDHUloz33n8OQCw+7DMfTfXvY8DMFK9R+R9WznAMmP/tgmSntIGwOVs0GBkcYptyvL9R4iyadzteZjrQUYppYH9Uugdgq62TiSRDMt1gqCmh2ECwqc3lyWwOlvOVGA55wzwQLkM9UwO4PsCg74cA8BUpnADQyLomAVFiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jf/AyLvM; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646377; x=1767182377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GAEPsLYSAjmFWSLLb/gkIbKd9SOlQLJT3SLs41LCsN8=;
  b=jf/AyLvMLoDevUcjxIOGiQhlnshePsdFbCnIB7kHYl4jVFnqPuIXFwXW
   8357x1GWacm2LDEMKADMU89pVVJjQQHbDmD4CQpLMu9o/aQu4Bm7ZM8SU
   Ru5gikvcTDa8VyJdUJnSLBGUPvsyLDX0BE3usj7iISh1ShK0xnqjlfabO
   YdtmDOuKC53gzvgSzPK7EbT9qT37hM3h+ZO4VjbTVtIGh7RPMdTTkeI/+
   hFAdZe5r2Ff6ZrdWv36zSlaOGO4tcciT6sj+AEALFT9CrCMcT23YiUTEb
   BMlzbfjd/EosyWcKxmZaMureeIYF8H6QFfibfd7wlaDT/DDdL05DmKigC
   w==;
X-CSE-ConnectionGUID: n5kyylM+TbqHOhHNaPMnwg==
X-CSE-MsgGUID: R5XN/iRrTF6kmN5jcODixg==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330170"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330170"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:37 -0800
X-CSE-ConnectionGUID: Mt9N0LgaSN6oi3H0HRHe0g==
X-CSE-MsgGUID: rAgGzXrZRM2SOMUtE7Zv7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380288"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:36 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: iwlwifi: mvm: improve/fix chanctx min_def use logic
Date: Tue, 31 Dec 2024 13:59:05 +0200
Message-Id: <20241231135726.7b91025e103d.I4c99c03fd32363d574ab5e34798b6099401f0729@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
References: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There are two cases in which the min_def isn't used:
 a) if FILS will be enabled
 b) if FTM responder is enabled

Both of these apply to AP mode only, but for FILS we're
not checking that right now. Change the code to iterate
the interfaces and links using the channel context, and
check for AP mode for both, not just for FTM responder.

In the case of iwl_mvm_enable_fils() this might also fix
an issue where FILS is enabled for an IBSS network that
happens to be started on 6 GHz, though that's not very
likely to be possible due to regulatory.

However for RX OMI bandwidth reduction the driver needs
to use the min_def in client mode as well, in order to
actually reduce bandwidth when it requested that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  5 ++-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 44 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 13 ++----
 3 files changed, 34 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index daa3bfaccaba..6b06732441c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1075,9 +1075,10 @@ static int iwl_mvm_mac_ctxt_send_beacon_v7(struct iwl_mvm *mvm,
 }
 
 bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_chanctx_conf *ctx)
 {
-	if (IWL_MVM_DISABLE_AP_FILS)
+	if (vif->type != NL80211_IFTYPE_AP || IWL_MVM_DISABLE_AP_FILS)
 		return false;
 
 	if (cfg80211_channel_is_psc(ctx->def.chan))
@@ -1106,7 +1107,7 @@ static int iwl_mvm_mac_ctxt_send_beacon_v9(struct iwl_mvm *mvm,
 	ctx = rcu_dereference(link_conf->chanctx_conf);
 	channel = ieee80211_frequency_to_channel(ctx->def.chan->center_freq);
 	WARN_ON(channel == 0);
-	if (iwl_mvm_enable_fils(mvm, ctx)) {
+	if (iwl_mvm_enable_fils(mvm, vif, ctx)) {
 		flags |= iwl_fw_lookup_cmd_ver(mvm->fw, BEACON_TEMPLATE_CMD,
 					       0) > 10 ?
 			IWL_MAC_BEACON_FILS :
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 359b8bf25e49..25124c7078d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5006,34 +5006,46 @@ int iwl_mvm_cancel_roc(struct ieee80211_hw *hw,
 	return 0;
 }
 
-struct iwl_mvm_ftm_responder_iter_data {
-	bool responder;
+struct iwl_mvm_chanctx_usage_data {
+	struct iwl_mvm *mvm;
 	struct ieee80211_chanctx_conf *ctx;
+	bool use_def;
 };
 
-static void iwl_mvm_ftm_responder_chanctx_iter(void *_data, u8 *mac,
-					       struct ieee80211_vif *vif)
+static void iwl_mvm_chanctx_usage_iter(void *_data, u8 *mac,
+				       struct ieee80211_vif *vif)
 {
-	struct iwl_mvm_ftm_responder_iter_data *data = _data;
+	struct iwl_mvm_chanctx_usage_data *data = _data;
+	struct ieee80211_bss_conf *link_conf;
+	int link_id;
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		if (rcu_access_pointer(link_conf->chanctx_conf) != data->ctx)
+			continue;
 
-	if (rcu_access_pointer(vif->bss_conf.chanctx_conf) == data->ctx &&
-	    vif->type == NL80211_IFTYPE_AP && vif->bss_conf.ftmr_params)
-		data->responder = true;
+		if (iwl_mvm_enable_fils(data->mvm, vif, data->ctx))
+			data->use_def = true;
+
+		if (vif->type == NL80211_IFTYPE_AP && link_conf->ftmr_params)
+			data->use_def = true;
+	}
 }
 
-bool iwl_mvm_is_ftm_responder_chanctx(struct iwl_mvm *mvm,
-				      struct ieee80211_chanctx_conf *ctx)
+struct cfg80211_chan_def *
+iwl_mvm_chanctx_def(struct iwl_mvm *mvm, struct ieee80211_chanctx_conf *ctx)
 {
-	struct iwl_mvm_ftm_responder_iter_data data = {
-		.responder = false,
+	struct iwl_mvm_chanctx_usage_data data = {
+		.mvm = mvm,
 		.ctx = ctx,
+		.use_def = false,
 	};
 
 	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
-					IEEE80211_IFACE_ITER_NORMAL,
-					iwl_mvm_ftm_responder_chanctx_iter,
-					&data);
-	return data.responder;
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   iwl_mvm_chanctx_usage_iter,
+						   &data);
+
+	return data.use_def ? &ctx->def : &ctx->min_def;
 }
 
 static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fbf7306b9b6f..7fd51976924d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2990,18 +2990,11 @@ int iwl_mvm_set_hw_timestamp(struct ieee80211_hw *hw,
 			     struct cfg80211_set_hw_timestamp *hwts);
 int iwl_mvm_update_mu_groups(struct iwl_mvm *mvm, struct ieee80211_vif *vif);
 bool iwl_mvm_enable_fils(struct iwl_mvm *mvm,
+			 struct ieee80211_vif *vif,
 			 struct ieee80211_chanctx_conf *ctx);
-bool iwl_mvm_is_ftm_responder_chanctx(struct iwl_mvm *mvm,
-				      struct ieee80211_chanctx_conf *ctx);
 
-static inline struct cfg80211_chan_def *
-iwl_mvm_chanctx_def(struct iwl_mvm *mvm, struct ieee80211_chanctx_conf *ctx)
-{
-	bool use_def = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx) ||
-		iwl_mvm_enable_fils(mvm, ctx);
-
-	return use_def ? &ctx->def : &ctx->min_def;
-}
+struct cfg80211_chan_def *
+iwl_mvm_chanctx_def(struct iwl_mvm *mvm, struct ieee80211_chanctx_conf *ctx);
 
 void iwl_mvm_roc_duration_and_delay(struct ieee80211_vif *vif,
 				    u32 duration_ms,
-- 
2.34.1


