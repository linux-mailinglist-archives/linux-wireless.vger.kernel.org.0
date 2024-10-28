Return-Path: <linux-wireless+bounces-14610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E333F9B3650
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 17:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC11C221DA
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2024 16:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CC11DE3C6;
	Mon, 28 Oct 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WrDODJoi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C618732E
	for <linux-wireless@vger.kernel.org>; Mon, 28 Oct 2024 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730132361; cv=none; b=WmsOJVCXODam9CvlqeYH6XXXEUlj7+LnHLXimSv4C2hNLZVbTag8E77F9Q5ZQOPw7kFeiafpO+Zxzm19DlKWHFClSYsIdekzCqMokAb5HL7vybdR1Y+9l2byYC6mNq9yExXYHFHKiRytGclvIo+LQFCg6FfZ19XVXFT1HYFU8UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730132361; c=relaxed/simple;
	bh=p9ftd+kstM1Aun3rsIwwGaxvFnSVCNGC336ssYDhELE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oZA/jeGzTg4bEH84ajew/aiqJpl5tIAxBALZfHCqKf7uy+M+cuapKBAOlutuzXTgMJtVh2F2ncFSQmcbHQBgWVi2kPe3mXCRcZ1fS8TnGNDpBA+6+ugXzO62rZz34VsXl6PLnonzcpWWs7FFeJA3VoNPUdFZQZ/+R56BOqBwfAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WrDODJoi; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730132359; x=1761668359;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p9ftd+kstM1Aun3rsIwwGaxvFnSVCNGC336ssYDhELE=;
  b=WrDODJoiZ3XOyuaOzA7EZP7jQzjn3dbHAhEM/CLQHuQSTo0qX8QU877L
   PZw123P4TbGvK5IQclIn5LznteXQrgLqU4folPCWPyfgBDUgWcTZq8GkA
   FUEvABh/8/PjDWafHZFb1DIzO2zBTrzvAqDuPJPzaHEeDMkSccdKg/7gF
   M5xIBS2YVC6WAhQxUNZf5CtrcpZSOhXIZJ7La84tkwKcJgOMbqhw3QZR9
   ALSLJmVbjKB7LX9itmFfzhhzbLAuxknK8dyq9XgD5giE3zHIy95AxMFiM
   NDxZdNhF/AcjxhPP1R0mAVFiFGwkcXIj8y3PK7cqdY5kUjtvg1lnmKKje
   Q==;
X-CSE-ConnectionGUID: WTLeKXqCQ9KnoU3fBmr0wg==
X-CSE-MsgGUID: EodM5Y2PRLilkC7aQEUiOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11239"; a="41099894"
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="41099894"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:17 -0700
X-CSE-ConnectionGUID: T9I/ivfnSNa6rJIqUEsXiQ==
X-CSE-MsgGUID: N3ru+5s/ScuuBNkecP4+4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,239,1725346800"; 
   d="scan'208";a="81561537"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 09:19:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/5] wifi: iwlwifi: mvm: remove pre-mld code from mld path
Date: Mon, 28 Oct 2024 18:18:58 +0200
Message-Id: <20241028181512.ea8f08350665.I840b00a7b38f3967ec5e75ff6a85e756f4d82437@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
References: <20241028161902.531165-1-miriam.rachel.korenblit@intel.com>
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
index 9d05c344d967..45656132d05c 100644
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


