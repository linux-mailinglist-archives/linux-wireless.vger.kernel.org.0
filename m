Return-Path: <linux-wireless+bounces-16786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FEC9FC0F6
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 18:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CCAD7A1D5E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06E014D433;
	Tue, 24 Dec 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cmi2U2Lo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029919995A
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061270; cv=none; b=MRpBeOnWtWRtPh898izjAengyzAecO6feQ9G3YpiMTgEKwCpg2T+82YTe3UDVmPiveHT59CghwEx0hr2TbYOxTcp/3hT2jCTE+yhGGYJc5PkFVWgb0x4tY39DkXylHAVwH4yf5fOXRye1CblvTtfoC1Lh+lSjBmOMcspqfastGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061270; c=relaxed/simple;
	bh=Cp/AgtivjEY7ykqBWZpaXpzuaI/X2JwHZs3dXyggAIM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XMVLwqoQ8D++s/VWg5RMMcQBteZf5eO2PAKymny0KlyG6Vv9+rd3HNUhBwQ8BOv4yO8B6oQmngB9e47g68ig2bRsTkWweAXv32dI+UaOJtFfr7HSjIp+rCfp47cHJTMEg4uY763AzELqXfGXtDl+GWSuX4nhnMTGbZktgzIVJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cmi2U2Lo; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735061269; x=1766597269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cp/AgtivjEY7ykqBWZpaXpzuaI/X2JwHZs3dXyggAIM=;
  b=cmi2U2LowcAEYvF0P/w8+GV/mt8FnlyJ2pq9K5X/JfiwPmwPvv+o/ob5
   uCr8Ewcvzn7okd1bdjATlM3cfL72W4SxQGpZEeo4iLehnZVBQQ9o/pEUF
   oYnUQ5A4u3St/Ih/FZyb/+zAWjptM1gSO/xaR/1KJ6IWRg3Kl/uA6gYN9
   XKrzvdsq+GG/Uz6zfPWkV+Y1LUo2pdMu2k7aBX5MFUo8IO0MiZLfMJzj+
   zE0xyOOeVrJFb236SiABD7uZDJTnWUKAvwHAwt9PP1xc/i4tzYofnZlil
   GZSL0eZtXj9IYUVjjTYmi1mB4FwiO+rLF+9CLP6+zPXGxclbl5ytjtjIA
   Q==;
X-CSE-ConnectionGUID: E/foveNVQLaaynI+/qxhJA==
X-CSE-MsgGUID: 4VJ9TW34SAOlDVcs4qou5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39311120"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39311120"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:48 -0800
X-CSE-ConnectionGUID: LVKwIlT5RRCJUDzRL/86gw==
X-CSE-MsgGUID: JqEznWmWROGL94V+C1a7/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99341013"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [RESEND] [PATCH 1/5] wifi: iwlwifi: mvm: remove pre-mld code from mld path
Date: Tue, 24 Dec 2024 19:27:27 +0200
Message-Id: <20241224192322.a665d16a3857.I840b00a7b38f3967ec5e75ff6a85e756f4d82437@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
References: <20241224172731.2640748-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This code is only relevant for older devices, that are not supporting
mld, so shouldn't be in iwl_mvm_sta_del, which is common to both pre-mld
and mld.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 42 ++++++++++----------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cd74c181c260..f881fde0a06d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2063,28 +2063,6 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 					  lockdep_is_held(&mvm->mutex));
 	sta_id = mvm_link_sta->sta_id;
 
-	/* If there is a TXQ still marked as reserved - free it */
-	if (mvm_sta->reserved_queue != IEEE80211_INVAL_HW_QUEUE) {
-		u8 reserved_txq = mvm_sta->reserved_queue;
-		enum iwl_mvm_queue_status *status;
-
-		/*
-		 * If no traffic has gone through the reserved TXQ - it
-		 * is still marked as IWL_MVM_QUEUE_RESERVED, and
-		 * should be manually marked as free again
-		 */
-		status = &mvm->queue_info[reserved_txq].status;
-		if (WARN((*status != IWL_MVM_QUEUE_RESERVED) &&
-			 (*status != IWL_MVM_QUEUE_FREE),
-			 "sta_id %d reserved txq %d status %d",
-			 sta_id, reserved_txq, *status)) {
-			*ret = -EINVAL;
-			return true;
-		}
-
-		*status = IWL_MVM_QUEUE_FREE;
-	}
-
 	if (vif->type == NL80211_IFTYPE_STATION &&
 	    mvm_link->ap_sta_id == sta_id) {
 		/* if associated - we can't remove the AP STA now */
@@ -2143,6 +2121,26 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 
 	iwl_mvm_disable_sta_queues(mvm, vif, sta);
 
+	/* If there is a TXQ still marked as reserved - free it */
+	if (mvm_sta->reserved_queue != IEEE80211_INVAL_HW_QUEUE) {
+		u8 reserved_txq = mvm_sta->reserved_queue;
+		enum iwl_mvm_queue_status *status;
+
+		/*
+		 * If no traffic has gone through the reserved TXQ - it
+		 * is still marked as IWL_MVM_QUEUE_RESERVED, and
+		 * should be manually marked as free again
+		 */
+		status = &mvm->queue_info[reserved_txq].status;
+		if (WARN((*status != IWL_MVM_QUEUE_RESERVED) &&
+			 (*status != IWL_MVM_QUEUE_FREE),
+			 "sta_id %d reserved txq %d status %d",
+			 mvm_sta->deflink.sta_id, reserved_txq, *status))
+			return -EINVAL;
+
+		*status = IWL_MVM_QUEUE_FREE;
+	}
+
 	if (iwl_mvm_sta_del(mvm, vif, sta, &sta->deflink, &ret))
 		return ret;
 
-- 
2.34.1


