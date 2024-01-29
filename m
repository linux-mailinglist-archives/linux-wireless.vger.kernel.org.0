Return-Path: <linux-wireless+bounces-2736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30F884134C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB0228A521
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D5F4C637;
	Mon, 29 Jan 2024 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7tDc/lb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01937602D
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556179; cv=none; b=qTV1biGZ1LlhVTsCGeTuzZmZE7CEIf3o2m3AtGUXmTAfRACaOQtkGOONSpGn1ohinlwNtsYQuueimb+zHFl1L2klUK6+SBpgXUuDqpqVa2Y6wnoikIOjdwZ+Xa4duSwMT5F2+vvBrVXTwbwPopfSCsQHX+TrSKtsCekysxZUSSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556179; c=relaxed/simple;
	bh=PUc3+opYRkCpb7hn/Lq13gVx2epUSXGA6qUtJHO/Wfc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LOQvqT25rnoKS2lJWapvDc2wlRT6NovwRvf8TiModEUdg1WpLWbNJObNCFG2AuT7t1zQFSfdZCuHuK4Rv+2vZooA1e1I9uOodu+eszUGwYf+g4iN+tlCPkhgduFDUWsvexhxDKbl+CX74hskJhOsxHl1GOwTfSxd14jwe7wvq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7tDc/lb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556178; x=1738092178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PUc3+opYRkCpb7hn/Lq13gVx2epUSXGA6qUtJHO/Wfc=;
  b=B7tDc/lb/m1IoCF93xNAOpLWPuLRPEFRZ2T1T74Req8TCg/AinCzLafL
   Pka0xicoQIh1lcMy6EXqFSQj9Nt2ilv6mtLtl6DrQIO7bp1QfMLMLbBKs
   A44IHsdbl6VoFyiQn9Yu8mLFkWP+BWbWZVi5tPuf2HE6qnRizdkVHD2Ss
   lkeLvvcGKvrjCChfF80efnLHShjwZaJTwd5HyRQGelWHCOC7uqDomV+zs
   mfR7ELBsUg+s6DsHrSV9+mblsGPPYtlt/4zk/9XPY5XJbzr1gwHvZCjWK
   CyFSF36IHowlxMAwCpBoh4NlK6kWq2M1cQYozFe3MVbsVB/zLJEqbk3I8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943077"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943077"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459182"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: refactor duplicate chanctx condition
Date: Mon, 29 Jan 2024 21:22:03 +0200
Message-Id: <20240129211905.6fcde4051adf.I343934874612d21727ed167accaa967958b2c25b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Refactor the check for using a chanctx's def vs. min_def,
to have the same in both places and reuse it later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 13 +++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 843544cfcfe9..dbad30e61451 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -4810,8 +4810,8 @@ static void iwl_mvm_ftm_responder_chanctx_iter(void *_data, u8 *mac,
 		data->responder = true;
 }
 
-static bool iwl_mvm_is_ftm_responder_chanctx(struct iwl_mvm *mvm,
-					     struct ieee80211_chanctx_conf *ctx)
+bool iwl_mvm_is_ftm_responder_chanctx(struct iwl_mvm *mvm,
+				      struct ieee80211_chanctx_conf *ctx)
 {
 	struct iwl_mvm_ftm_responder_iter_data data = {
 		.responder = false,
@@ -4830,9 +4830,7 @@ static int __iwl_mvm_add_chanctx(struct iwl_mvm *mvm,
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt;
-	bool use_def = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx) ||
-		iwl_mvm_enable_fils(mvm, ctx);
-	struct cfg80211_chan_def *def = use_def ? &ctx->def : &ctx->min_def;
+	struct cfg80211_chan_def *def = iwl_mvm_chanctx_def(mvm, ctx);
 	int ret;
 
 	lockdep_assert_held(&mvm->mutex);
@@ -4898,9 +4896,7 @@ void iwl_mvm_change_chanctx(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
-	bool use_def = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx) ||
-		iwl_mvm_enable_fils(mvm, ctx);
-	struct cfg80211_chan_def *def = use_def ? &ctx->def : &ctx->min_def;
+	struct cfg80211_chan_def *def = iwl_mvm_chanctx_def(mvm, ctx);
 
 	if (WARN_ONCE((phy_ctxt->ref > 1) &&
 		      (changed & ~(IEEE80211_CHANCTX_CHANGE_WIDTH |
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e148ef02ff73..d414007c4755 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2752,4 +2752,17 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 int iwl_mvm_mld_get_primary_link(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif,
 				 unsigned long usable_links);
+
+bool iwl_mvm_is_ftm_responder_chanctx(struct iwl_mvm *mvm,
+				      struct ieee80211_chanctx_conf *ctx);
+
+static inline struct cfg80211_chan_def *
+iwl_mvm_chanctx_def(struct iwl_mvm *mvm, struct ieee80211_chanctx_conf *ctx)
+{
+	bool use_def = iwl_mvm_is_ftm_responder_chanctx(mvm, ctx) ||
+		iwl_mvm_enable_fils(mvm, ctx);
+
+	return use_def ? &ctx->def : &ctx->min_def;
+}
+
 #endif /* __IWL_MVM_H__ */
-- 
2.34.1


