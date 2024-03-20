Return-Path: <linux-wireless+bounces-5047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C073488190C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0FB283FE7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170F36B08;
	Wed, 20 Mar 2024 21:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I1RXqf8n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3D85C7A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970020; cv=none; b=FXmXDdVmRlzmGTSQxj4f7GXptL5jg2Riw0e1ufmtizrto9u4n7zdH36DKGNCp5XfBJsFga6RP7LMv5cg2DoOzW/NaoiX4wIvxQPhoXI6sEC139HvWwq4spYGIadQcqJW7j7YowzUrRSKrZXzTgYR0zHjtbzdQt+2w2W7xbrxoBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970020; c=relaxed/simple;
	bh=fcJ8CrsPRAVXFoZQOM98OWVdso0c02n6BbLCezAtY1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/RJwbtdW7WWz+h92OVtMwJoqLXCLwNXlqmJaMt8FWR3fVzbhahl8/X3pGqw5GqSq1jWVIQSFCa3QYhu62pbyxJ23PgO4cTizYFz9cg/xVTMJ9RIPAX8wD0P9cP0xY8UDUdD+He5u3YaeXSYgFCQGPxpnSi2zMWqRVxc30UBSGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I1RXqf8n; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970018; x=1742506018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fcJ8CrsPRAVXFoZQOM98OWVdso0c02n6BbLCezAtY1c=;
  b=I1RXqf8nULGK7U0cnGKrPOboKdCzUAkLmGE0k9S4A6rWWWtiSP4tnWJf
   MiS+HvR4i0G3UGbN7wUx+xPlVQit/cJL74oDbFwkeSxWbW17GqK6zZYsZ
   F0jRv1Oz9jRp/9KvBZ46dCB9VsID9OBWWJkimdq/b4m3Q3xBm3EC6Q8D+
   UMt1LaQQH6JURzbiJvgj6VY5xqglLPAHVUeqRIPuDJUdJMiTaYq+Pm67X
   GybsXj6v4lEO689+szCgTMrzLHgdpcYh9mIXTGWRrojHq9HvYz/g+zc0x
   cVYvUi1WrAWyGoFIe/vFmWj8m8mWqrPBkNRjDIrVEEwLoEnEKgZYuz2vJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698057"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698057"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184120"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:26:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/17] wifi: iwlwifi: mvm: fix active link counting during recovery
Date: Wed, 20 Mar 2024 23:26:25 +0200
Message-Id: <20240320232419.55f37339e7d1.I57006568a90ffb7a1232def1b2f3264dea711ba6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

During recovery, the chanctx_conf in mac80211 is still non-NULL even
though the channel context has not yet been assigned again. In that
case, the real count is actually lower.

Switch to instead count the phy_ctx assignment and ensure that the
assignment is cleared at the start of recovery.

Fixes: 12bacfc2c065 ("wifi: iwlwifi: handle eSR transitions")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 084314bf6f36..d18304ac126c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -189,17 +189,13 @@ static void iwl_mvm_mld_mac_remove_interface(struct ieee80211_hw *hw,
 	mutex_unlock(&mvm->mutex);
 }
 
-static unsigned int iwl_mvm_mld_count_active_links(struct ieee80211_vif *vif)
+static unsigned int iwl_mvm_mld_count_active_links(struct iwl_mvm_vif *mvmvif)
 {
 	unsigned int n_active = 0;
 	int i;
 
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
-		struct ieee80211_bss_conf *link_conf;
-
-		link_conf = link_conf_dereference_protected(vif, i);
-		if (link_conf &&
-		    rcu_access_pointer(link_conf->chanctx_conf))
+		if (mvmvif->link[i] && mvmvif->link[i]->phy_ctxt)
 			n_active++;
 	}
 
@@ -245,18 +241,18 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 {
 	u16 *phy_ctxt_id = (u16 *)ctx->drv_priv;
 	struct iwl_mvm_phy_ctxt *phy_ctxt = &mvm->phy_ctxts[*phy_ctxt_id];
-	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	unsigned int n_active = iwl_mvm_mld_count_active_links(mvmvif);
 	unsigned int link_id = link_conf->link_id;
 	int ret;
 
-	/* if the assigned one was not counted yet, count it now */
-	if (!rcu_access_pointer(link_conf->chanctx_conf))
-		n_active++;
-
 	if (WARN_ON_ONCE(!mvmvif->link[link_id]))
 		return -EINVAL;
 
+	/* if the assigned one was not counted yet, count it now */
+	if (!mvmvif->link[link_id]->phy_ctxt)
+		n_active++;
+
 	/* mac parameters such as HE support can change at this stage
 	 * For sta, need first to configure correct state from drv_sta_state
 	 * and only after that update mac config.
@@ -416,7 +412,7 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	unsigned int n_active = iwl_mvm_mld_count_active_links(vif);
+	unsigned int n_active = iwl_mvm_mld_count_active_links(mvmvif);
 	unsigned int link_id = link_conf->link_id;
 
 	/* shouldn't happen, but verify link_id is valid before accessing */
-- 
2.34.1


