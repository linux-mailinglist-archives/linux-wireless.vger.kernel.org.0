Return-Path: <linux-wireless+bounces-13850-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539E2998471
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90F9285300
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFEA1C3F30;
	Thu, 10 Oct 2024 11:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaIO4iYb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A091C3F1A
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558335; cv=none; b=aqLw9tjKGoRfk2njnIdeLkMJI92/qbPl+fRX385uizSyHtS6lU4RE3C1q2W5ImqRmgJarPb5QNv3wSrrxAXbms3sbkOh7yPdm4RZbrq0Q8CQ3ZTkWNQZxjRU7ALiWFjPd6eNcKG3QzuG14eQWoJYezNuCBtXo5R9rmghml+RsYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558335; c=relaxed/simple;
	bh=QfbHHRqJxkAmYLAv4UWGXvJ6rOhkKxlRw63IVv4p1M8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=conNG9n1jQlpzPSapxyXSpdsO4cveRJhdtXcT5c47LXcLoffI6TjoRcKkijDRxh1E8BdIBCA59Xje434QQQVtQSKSVwCm+2jjnDVZA9dZVrPevkj3vFwEzXZ+QMNh1nUwSm4g7//DsBqwKnhX2mqpzRdgPAldTHEvevn+VSn6IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaIO4iYb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558333; x=1760094333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QfbHHRqJxkAmYLAv4UWGXvJ6rOhkKxlRw63IVv4p1M8=;
  b=CaIO4iYb/fG/3Tcg5cU666k39ZZMv0gPBKpME2pwrpExVPo/6g5t0hZc
   AXvDhQd1r3JqDk/NF8VX0t5dOJO8ul2THbgCsSZtFXZwi6H2nb0KbcujK
   y1YG3+AlD3OViJkgY0AXQXCgQBvvV0+6/Siky7Ro+5OHpNN9ZiXy9ydkq
   cCc82BdDx/y+X3RGEuPo0r3CSk4aXAPyKLJLyBN24peWNgSnpkU17rPPh
   wZby6MeorHQ44HJKzVZrEEYX4GKnYc887WFkO8qBHOuWHUA0YX0oBwMi8
   DJIkI+Bq46bN8n/pWJLvnm87zC88OKs2fexIFoEOFGCxJXCKnZ9KeXsu0
   Q==;
X-CSE-ConnectionGUID: oKF6lWbaSxuxwhLoNRK51Q==
X-CSE-MsgGUID: tYz9wL2xT+KSsi/TqaJW6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697749"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697749"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:33 -0700
X-CSE-ConnectionGUID: cEc0h7mITJOA33005SJqGw==
X-CSE-MsgGUID: ENaQH4AsRcyMrhoNUw7R/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362344"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 8/9] wifi: iwlwifi: mvm: don't add default link in fw restart flow
Date: Thu, 10 Oct 2024 14:05:06 +0300
Message-Id: <20241010140328.385bfea1b2e9.I4a127312285ccb529cc95cc4edf6fbe1e0a136ad@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

When we add the vif (and its default link) in fw restart we may
override the link that already exists. We take care of this but if
link 0 is a valid MLO link, then we will re-create a default link on
mvmvif->link[0] and we'll loose the real link we had there.

In non-MLO, we need to re-create the default link upon the interface
creation, this is fine. In MLO, we'll just wait for change_vif_links()
to re-build the links.

Fixes: bf976c814c86 ("wifi: iwlwifi: mvm: implement link change ops")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 24 ++++++++++++++-----
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index bd043db906db..e252f0dcea20 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -41,8 +41,6 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 	/* reset deflink MLO parameters */
 	mvmvif->deflink.fw_link_id = IWL_MVM_FW_LINK_ID_INVALID;
 	mvmvif->deflink.active = 0;
-	/* the first link always points to the default one */
-	mvmvif->link[0] = &mvmvif->deflink;
 
 	ret = iwl_mvm_mld_mac_ctxt_add(mvm, vif);
 	if (ret)
@@ -60,9 +58,19 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
-	if (ret)
-		goto out_free_bf;
+	/* We want link[0] to point to the default link, unless we have MLO and
+	 * in this case this will be modified later by .change_vif_links()
+	 * If we are in the restart flow with an MLD connection, we will wait
+	 * to .change_vif_links() to setup the links.
+	 */
+	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) ||
+	    !ieee80211_vif_is_mld(vif)) {
+		mvmvif->link[0] = &mvmvif->deflink;
+
+		ret = iwl_mvm_add_link(mvm, vif, &vif->bss_conf);
+		if (ret)
+			goto out_free_bf;
+	}
 
 	/* Save a pointer to p2p device vif, so it can later be used to
 	 * update the p2p device MAC when a GO is started/stopped
@@ -1194,7 +1202,11 @@ iwl_mvm_mld_change_vif_links(struct ieee80211_hw *hw,
 
 	mutex_lock(&mvm->mutex);
 
-	if (old_links == 0) {
+	/* If we're in RESTART flow, the default link wasn't added in
+         * drv_add_interface(), and link[0] doesn't point to it.
+	 */
+	if (old_links == 0 && !test_bit(IWL_MVM_STATUS_IN_HW_RESTART,
+					&mvm->status)) {
 		err = iwl_mvm_disable_link(mvm, vif, &vif->bss_conf);
 		if (err)
 			goto out_err;
-- 
2.34.1


