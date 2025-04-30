Return-Path: <linux-wireless+bounces-22254-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CCEAA4B0C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B769A055B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAEB25A2A6;
	Wed, 30 Apr 2025 12:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP2iFus9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B51525B1E0
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015902; cv=none; b=lv/+qI6DqAYR+sEdy8v2MNIQLosCoOb5ZfJB3R6fFEBF1FpJ/zGfKpLDZLvvWGSHYbaItfZKf05L1WLARnCpA81RZEJalL5jqcpZTAxlvsbLAfmw74mumSZ9DncvzdIYqWWgnro2e6ZcdyfNEejbofk5mk/ojbZiXKt1wcv2FMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015902; c=relaxed/simple;
	bh=P+5z9/4xDR4bv6/Bh3d2ERrurwI8dYaSLxUvO7fsU7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIi3Ep3HCe0s2gQAOJ/CFKcbSIOyzm7Hy6QEd6a5ZQL9lIZCdlw+SZqp6vIz4+K0lHQ2UZzq5O3TZhJ4eJOdW1CKFVm0+FmKIIxaA/1wCntwZOR4jpg6Yj2nheoFoyda7q0XLX7dXqB7HCLdw/blSDH51VcJ55wlkBqnykYCOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP2iFus9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015901; x=1777551901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P+5z9/4xDR4bv6/Bh3d2ERrurwI8dYaSLxUvO7fsU7Q=;
  b=HP2iFus9Qw3SBKf8zl8+7ASKRQeM9ztnoJwr5YToU+ywDMwKviPI0x86
   YOoHrMdaDv65H5vceU7drzIWgUUx//W+DYNs+ulPhapwmTcWYwQGzyjqE
   aXmXZ21pOeHCkLK+CfmUOVKQ/4Iu59t614dJkbbSGCYKR6jHd7RqIL3eJ
   ua7fc8YW3uVYOtYUVUt6D/fsUTnPer96vwwA5emvbeTRO5P5LoMP/j1QN
   aWgD3BiYVtNoJPXmySpNlCURN7jHLCNuLNfzA0D43lekZougixx/0Pnim
   nDrZg2NmZCheItfGGhVqTqcPFNia2JTKavCQEfIEcg2kI3vcURSgnHeNx
   g==;
X-CSE-ConnectionGUID: ZugK9QsjSG6eegiQnppBGQ==
X-CSE-MsgGUID: Px5sX5AmS+yaQXMBSY8f5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578286"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578286"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:25:00 -0700
X-CSE-ConnectionGUID: h8gOhqLAREKECa9Ixca9jg==
X-CSE-MsgGUID: 2C1pHQ51RMGGRVpiYECC5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087887"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:25:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 11/14] wifi: iwlwifi: mld: don't return an error if the FW is dead
Date: Wed, 30 Apr 2025 15:23:17 +0300
Message-Id: <20250430151952.c549c72b1f37.I445bf723e9befc9541b4abd0ec7c72db8f1ff177@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
References: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If iwl_mld_change_vif_links failed to add the requested link(s)
because the FW is dead (error before recovery), there is no point
in returning an error value, as the reconfig will re-add the link(s)
after the FW is started.
Return 0 in that case, and WARN in the others.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mac80211.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 284599abf8c6..6710dcacecd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2457,8 +2457,10 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 	for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 		if (added & BIT(i)) {
 			link_conf = link_conf_dereference_protected(vif, i);
-			if (WARN_ON(!link_conf))
-				return -EINVAL;
+			if (!link_conf) {
+				err = -EINVAL;
+				goto remove_added_links;
+			}
 
 			err = iwl_mld_add_link(mld, link_conf);
 			if (err)
@@ -2493,7 +2495,11 @@ iwl_mld_change_vif_links(struct ieee80211_hw *hw,
 		iwl_mld_remove_link(mld, link_conf);
 	}
 
-	return err;
+	if (WARN_ON(!iwl_mld_error_before_recovery(mld)))
+		return err;
+
+	/* reconfig will fix us anyway */
+	return 0;
 }
 
 static int iwl_mld_change_sta_links(struct ieee80211_hw *hw,
-- 
2.34.1


