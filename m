Return-Path: <linux-wireless+bounces-16787-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C3E9FC0F7
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C76164F34
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Dec 2024 17:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02D7212D7C;
	Tue, 24 Dec 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT52/DdC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94F7212B3B
	for <linux-wireless@vger.kernel.org>; Tue, 24 Dec 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061271; cv=none; b=ZIbMGrWKyQWR2/J2oIia+MW6nlYeX4x8gHK0pasY4Ui1kFcD5o0NJIfisMTN80HhnA7EWcfKWKj9mTekSu7ZI1FyV4jNE0G/5jupdVQ3QVxEHk0b2Lqi2U1ec2wpZDx9zT/Hdxc+WgMn4G/4UVPWp9M2GIdKDpdhSYEZ+RNze+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061271; c=relaxed/simple;
	bh=AyZsKNcFCIjAUeYKDUkLUkLG+7CcfoCFWFIyPS/H0gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cdkosshzmQDUipFUnLfRMA+YEAQjrRLyCHaI48YYtblifhuBrv492Ulj0j8tMZk8vmZ22AryY6btmCSMrZMFAjXBB/xn2XfYeS/H53lCOj2F5no8ajPXaKOnQjzaSmhAs1tGNVZVNKvXTkGw1o8znHtDeIJUqFdedsUt2lPxxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT52/DdC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735061270; x=1766597270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AyZsKNcFCIjAUeYKDUkLUkLG+7CcfoCFWFIyPS/H0gc=;
  b=AT52/DdCpIdYiUioc1J6D/VL4KaVU18SaMKnYb3gBEBf2HrleC1trV50
   6yEPnR8J+a/BMiTW7H5NzOMCRY+9neT+0di0JIKTELnytztX1e6kvjUeW
   fl8k164BS9kETHDAuvIqwgrfflXewBBQXb3zf4m695j7SyYvyookjJEE5
   jIjNHtQwcdft6soLGkfV9a/QbvFCwuXqzfir8INsmTDDiNHAt33ws6fAN
   k4zZYPiU0vhCi+FlUYBF9UocnBazWtomXUkVwIrcD/38suFnbcW/b4WHv
   mmYQneCAAFgyjnbRqbbcFAks1MEksbBOy9zQbJGZFyCYNKt4q1mYVcK/I
   Q==;
X-CSE-ConnectionGUID: lpDLgpKvSc6WdH1rZSzdCg==
X-CSE-MsgGUID: fkQYweJRTBC8uNCWgRAO7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39311125"
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="39311125"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:50 -0800
X-CSE-ConnectionGUID: WohMKDgXQ4eIsmsMVyss8g==
X-CSE-MsgGUID: prf3qiDtQdeLicSlSG7PbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,260,1728975600"; 
   d="scan'208";a="99341022"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 09:27:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [RESEND] [PATCH 2/5] wifi: iwlwifi: mvm: send the right link id
Date: Tue, 24 Dec 2024 19:27:28 +0200
Message-Id: <20241224192322.db7a5f551492.I79fe16a14fa0bb20751ba2526c3195fef39ef772@changeid>
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

in iwl_mvm_sta_del we call iwl_mvm_sec_key_remove_ap with link id 0,
when it might actually be something else, causing us to skip all
the keys.

Since the call to iwl_mvm_sec_key_remove_ap was mostly skipped (because
for STA mode we are not removing the ap sta immediately, but later when
the vif is set to unassocicated),
this was fine.
The other call to iwl_mvm_sec_key_remove_ap, when we actually do remove the
ap sta, was called with the right link id. So the bug didn't happen so far.

Now that mac80211 is going to change such that we can immediately
remove the ap sta, the call to iwl_mvm_sec_key_remove_ap with link id 0
will not be skipped, so no key will be removed, and then when
mac80211 eventually tells us to remove that keys, we no longer have the
sta ids for them.

Simply pass the right link id to iwl_mvm_sec_key_remove_ap.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index f881fde0a06d..d3fa2c4feb0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2070,7 +2070,8 @@ bool iwl_mvm_sta_del(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 			return true;
 
 		/* first remove remaining keys */
-		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link, 0);
+		iwl_mvm_sec_key_remove_ap(mvm, vif, mvm_link,
+					  link_sta->link_id);
 
 		/* unassoc - go ahead - remove the AP STA now */
 		mvm_link->ap_sta_id = IWL_INVALID_STA;
-- 
2.34.1


