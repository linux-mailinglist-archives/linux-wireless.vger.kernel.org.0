Return-Path: <linux-wireless+bounces-20070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30601A57F38
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6CAF188E422
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9EB20F083;
	Sat,  8 Mar 2025 22:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEj9Vu9W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7943E2135AA
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471314; cv=none; b=R9vZefyG60v8hRB7lBBIWBHdAuAE5Qb1/9LVspQmsJ9WHDXrMj3NZvmYzrhVUHtCDl2Y4fguiSpAUXReiHF8a8D4GTXb6e9Kk+t0XGj5424KsBTRANU2Ak6EcnMX3B9zD5SRyhrKTFmXZvjnajS6FVq3yyDvOHmb6B3IZffrUcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471314; c=relaxed/simple;
	bh=LpsqBxERu74ubq+6NqMBznrCDAtmWg+meNeweARk628=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R2Bby0TF55HthqN5CdQLqwr7hyp31rjzAOJfbuBoq+A3hPY0rwlX+J+60i1zhwljUT8N/0qk+PnAnjGSB/BfHTJXiv3/WQFXZm4Wusl22lOKCQRZQGqJR/Q7B9ciL03RV0w4CH+WKqehtnwidp0ehwPGgMQmJ37NUTE2lpW8Aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEj9Vu9W; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471312; x=1773007312;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpsqBxERu74ubq+6NqMBznrCDAtmWg+meNeweARk628=;
  b=XEj9Vu9WHGT2PxVJAg/6xnDT1bk03A0S+kPOES1G1QoTvqVIQ5grj5h3
   1Cj9BqjWApr4xgtp5sKnScxnf+2snr49yGMA4nBhZ8H2o6QH2cAc5+IsG
   wc9E94f01pWEmbY3U7Mk6rNaiecJZs0BJKyCIoqyyVmuGZLHTzZHHI8nh
   Xfh+jFAr1AUhOlYg1+qdKj0Q5RLdr2gVjNvW+zAkbHmK3y/BRbIdxM45E
   FgT2F6KZ1k0Bcr0+YUpEypLUR9Ui8Cek4rqf/wZFFH8zWkKigXQsvYGDu
   Z/ZoHtfhPCqBs5/52347JQC9A8w9sbQS7gS5evubF2y8QNXfyvNIbV2e4
   Q==;
X-CSE-ConnectionGUID: iDzdd62YQ2Gb9OAHt+e1oQ==
X-CSE-MsgGUID: 82f+l3eFSou/RrqphXhwKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540652"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540652"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:52 -0800
X-CSE-ConnectionGUID: v4R3aUfIRa2z31c1vOIayA==
X-CSE-MsgGUID: pSV0iPPWQeGYe3WxtPdVZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352148"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH wireless-next 10/15] wifi: iwlwifi: mld: move the ftm initiator data to ftm-initiator.h
Date: Sun,  9 Mar 2025 00:01:20 +0200
Message-Id: <20250308235203.92830fd553ec.Icbbd0eba34c9ba318801074f7705f6d1e5af5482@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Move the FTM initiator data to the relevant header file and document
its fields.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/ftm-initiator.h | 14 ++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h       |  7 ++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
index e98fac34beba..3fab25a52508 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ftm-initiator.h
@@ -5,6 +5,20 @@
 #ifndef __iwl_mld_ftm_initiator_h__
 #define __iwl_mld_ftm_initiator_h__
 
+/**
+ * struct ftm_initiator_data - FTM initiator data
+ *
+ * @req: a pointer to cfg80211 FTM request
+ * @req_wdev: a pointer to the wdev that requested the current FTM request
+ * @responses: the number of responses received for the current FTM session.
+ *	Used for tracking the burst index in a periodic request.
+ */
+struct ftm_initiator_data {
+		struct cfg80211_pmsr_request *req;
+		struct wireless_dev *req_wdev;
+		int responses[IWL_TOF_MAX_APS];
+};
+
 int iwl_mld_ftm_start(struct iwl_mld *mld, struct ieee80211_vif *vif,
 		      struct cfg80211_pmsr_request *req);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.h b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
index 1ab98ba42c76..38f1d1bc5a24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.h
@@ -34,6 +34,7 @@
 #include "constants.h"
 #include "ptp.h"
 #include "time_sync.h"
+#include "ftm-initiator.h"
 
 /**
  * DOC: Introduction
@@ -277,11 +278,7 @@ struct iwl_mld {
 
 	struct iwl_mld_time_sync_data __rcu *time_sync;
 
-	struct {
-		struct cfg80211_pmsr_request *req;
-		struct wireless_dev *req_wdev;
-		int responses[IWL_TOF_MAX_APS];
-	} ftm_initiator;
+	struct ftm_initiator_data ftm_initiator;
 };
 
 /* memset the part of the struct that requires cleanup on restart */
-- 
2.34.1


