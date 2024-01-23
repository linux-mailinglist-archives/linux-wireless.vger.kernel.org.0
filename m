Return-Path: <linux-wireless+bounces-2409-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8CD839754
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 629561F2D326
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AE381211;
	Tue, 23 Jan 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNDZSxGo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA68121F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033367; cv=none; b=ZMYgvm5CMGaQ3WxC/2AdyV1++C1aQV7iMrbnN2lNkFwVy9Hrj6sX1Sm2pGXldbicOTg/zReXHU4lmJAWD6FD6ANGIs2Y18DiiX4e0ZXfeiujD4wr/BfwokR97HPw+MkcqM5C/9iyjODvPRthwdSp4myxN+PerqNvkRUCQswU8c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033367; c=relaxed/simple;
	bh=ncZf8uq8kzz463ROZE+VQzmdV9sScl9KnreaLMZDyMM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HvekXsGKWByVhAsWUr3/dY7mQ+gMPkwD1kvmhO7r/5haYXgcimwm91/jmHKHh38LvD8geP77MB2aXb4afd0I3RNuLouGniGwWGXopyQkTVbl2qBumtvPDXj2Svc2iLA+mi+g4NbZ4KOu0huc+xsAhkcchvZPld/rApUUxmonDP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNDZSxGo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033366; x=1737569366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ncZf8uq8kzz463ROZE+VQzmdV9sScl9KnreaLMZDyMM=;
  b=kNDZSxGo9te+U6Mq2dnTZZLlRR7/Cc5n8LFozKK/zMVVmpctBFacuPdP
   XSndy0HMo7jsnXV2E5VUfqKVKJSWvaM9ejFUh7yyoga2QJot2WexJOjZH
   MCSlFNTdgvwLFEyOyZcVHmrq0gXkGqdtObGt+m4Pb5hU0q+6GlWN6+h+Q
   qPjO5cuI48yba/lBbQ20PPoIJg57E7TEBWrl1LyRPGN10rl+9vsfVTlvH
   9ks1naskvRdQ3E7WE26g9A1mYPU9s/zKy5JBBvZfMdI5MpCfYLrOK6y+1
   0/PBLNanh32TcOKT2OwY5H/85mJWSLyafKGoYwSKm97+mbupsqi2+sIaE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="502063"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="502063"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666633"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/15] wifi: iwlwifi: implement can_activate_links callback
Date: Tue, 23 Jan 2024 20:08:22 +0200
Message-Id: <20240123200528.a26fd48bfe3d.I03ae6b4c7fd24e8701660a68cec9403dc3469a0e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This callback checks if a given bitmap of active_links
will be supported by the driver or not.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c  | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 1f36e934ef69..b1caf5163121 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -254,9 +254,6 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 	if (!rcu_access_pointer(link_conf->chanctx_conf))
 		n_active++;
 
-	if (n_active > iwl_mvm_max_active_links(mvm, vif))
-		return -EOPNOTSUPP;
-
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
 		return -EINVAL;
 
@@ -1122,17 +1119,12 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 			     struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
 {
 	struct iwl_mvm_vif_link_info *new_link[IEEE80211_MLD_MAX_NUM_LINKS] = {};
-	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u16 removed = old_links & ~new_links;
 	u16 added = new_links & ~old_links;
 	int err, i;
 
-	if (hweight16(new_links) > 1 &&
-	    n_active > iwl_mvm_max_active_links(mvm, vif))
-		return -EOPNOTSUPP;
-
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 		int r;
 
@@ -1224,6 +1216,15 @@ iwl_mvm_mld_change_sta_links(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static bool iwl_mvm_mld_can_activate_links(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif,
+					   u16 desired_links)
+{
+	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
+
+	return hweight16(desired_links) <= iwl_mvm_max_active_links(mvm, vif);
+}
+
 const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 	.tx = iwl_mvm_mac_tx,
 	.wake_tx_queue = iwl_mvm_mac_wake_tx_queue,
@@ -1318,4 +1319,5 @@ const struct ieee80211_ops iwl_mvm_mld_hw_ops = {
 
 	.change_vif_links = iwl_mvm_mld_change_vif_links,
 	.change_sta_links = iwl_mvm_mld_change_sta_links,
+	.can_activate_links = iwl_mvm_mld_can_activate_links,
 };
-- 
2.34.1


