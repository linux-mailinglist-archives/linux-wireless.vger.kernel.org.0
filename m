Return-Path: <linux-wireless+bounces-8118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F18D07F2
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 340C61F21D80
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29727347E;
	Mon, 27 May 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtI7brAu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5715A874
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825992; cv=none; b=qOXGpGcF/0ZXrvRCFFDvwg8kguc+WONcqwH7rEpc/fB1xdDVYUSf0OWomU1nZ2DGhiiMIqplwOFE/KTVDdsZ7NPdIx+i+DM+8tAJBdUA4VqrvyBwU6oXwfcCKc2d8ZU0Omf0WOfMxKTirK3GYbnNRVqJJQDfBWGZLP8H5hpOR9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825992; c=relaxed/simple;
	bh=x+hJ0WZJSbXevrGpC1b/J/ZsRiqmsh+sCFUjPpZn2VE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9wXo+iQG5kj1ah6iZYujcLzG+AQtXd4uV8gF5Mfc8sX7J8co4+vCWcLoQKGjTwr1eobMPz3cu33jFP4sFT+R9t7SABLVBWxtI0GVKhO+gJzu9vMffIqT3yTllz51y8TCu8nRXgFf+P3YxiefMWbqgYI9Drc/J+8emzDOAeF6gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtI7brAu; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825992; x=1748361992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x+hJ0WZJSbXevrGpC1b/J/ZsRiqmsh+sCFUjPpZn2VE=;
  b=AtI7brAuLQwyMOb/QUC4M8d9V+kkL+Ddn3ajOVU+EvBpWCUfi57v1gcY
   O9ABf7Gmii0PVTDhjR+wJhE/nI3tlmFK5CIlDg9ys0xYOqtvh96OXJ5va
   +WNbZznO9cnrAZD6Fm/N4JyJn4v52WmYoQ1LIGnxIcc8ojyp3FqlNiYPu
   d5JXYmW03cTCWpFP7/aDvWljva4FqmhydGd/4DEOUBvJC+e+O1DXcRDSj
   2JCl9OnWX97xhnlg7EXuUb5XKM9XSbEhOM841ueyMnRDrmt/ZmzXYo2Dw
   FQvYUY2/21LppQo1pwyO0OtI28ruhprhbzhQoGoNNzgP43wT62jsORUna
   A==;
X-CSE-ConnectionGUID: yO5PL5UsR3CPW9ViNsz86g==
X-CSE-MsgGUID: qv/2vkyySNaElM4v51yGBA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002077"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:32 -0700
X-CSE-ConnectionGUID: lMGz6E5QQpCfr/ZkLaW8bA==
X-CSE-MsgGUID: D1SsIYwdSPmziDymZiyZlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407080"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 05/20] wifi: iwlwifi: mvm: move a constant to constants.h
Date: Mon, 27 May 2024 19:06:00 +0300
Message-Id: <20240527190228.395f5b24ff82.Id78a5a404c3ae15cbbc950b1f1d7e500a8b92a43@changeid>
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

Move IWL_MVM_MIN_BEACON_INTERVAL_TU to constants.h

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/constants.h | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c  | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index c991eaeade15..d840653cc907 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -123,6 +123,7 @@
 #define IWL_MVM_DISABLE_AP_FILS			false
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_TIMEOUT       3000 /* in seconds */
 #define IWL_MVM_6GHZ_PASSIVE_SCAN_ASSOC_TIMEOUT 60   /* in seconds */
+#define IWL_MVM_MIN_BEACON_INTERVAL_TU		16
 #define IWL_MVM_AUTO_EML_ENABLE                 true
 #define IWL_MVM_MISSED_BEACONS_EXIT_ESR_THRESH	7
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 87825fb496bc..752fdb6a783f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3753,8 +3753,6 @@ static void iwl_mvm_rs_rate_init_all_links(struct iwl_mvm *mvm,
 	}
 }
 
-#define IWL_MVM_MIN_BEACON_INTERVAL_TU 16
-
 static bool iwl_mvm_vif_conf_from_sta(struct iwl_mvm *mvm,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta)
-- 
2.34.1


