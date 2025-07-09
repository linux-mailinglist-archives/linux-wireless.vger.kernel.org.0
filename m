Return-Path: <linux-wireless+bounces-25028-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C05ECAFDE83
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F2F57B78DB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AE372613;
	Wed,  9 Jul 2025 03:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gpjZgwgN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0427E21B9D2
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032650; cv=none; b=Ba6HuXsIWgfoyyJBOrqhkjS4zNFGymlCjXStevVryt4czgfjKKLmXblL/70oXC/RtCwqNO3TXfrs00FaqChhE8USr+dCqLYVIj1tLXPDOL/rhfoN0Rrr3XgTjLHXNLK1bPzrY+HhgJqMPiY3NNvr/OtJNQV9kw0ixufU5+/st8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032650; c=relaxed/simple;
	bh=bd8AZMHiOKUx0QQa3RzgnKQ3hk/20Z+g4CH6o7zKxMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iFvbqDfdDhjQNic1Cl2Y1weBY7C0/YX8+YyB7QpV8pZZ3HCtzLlewZrWSdgpgljsBzdMWPcLlvBM5twmk5Tb3xJJQNDnUk0kt1qgZZbMCCAlsEsFTzQAkYv0xSA4ZmsdVBnY8ZlOesseUk0vvCa+1KmED8IYO2PAayIlAFBhJZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gpjZgwgN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032649; x=1783568649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bd8AZMHiOKUx0QQa3RzgnKQ3hk/20Z+g4CH6o7zKxMc=;
  b=gpjZgwgNQIUZh5BYdTXyCupxLZeHb85clcezifjK6xIQsx26tN3TuEPY
   RGlfvyUvVUsljol9qFtCmSgrLWE7oRnu9Uu04m43H/rzxg3kzPrRdvvnY
   P2m1ho2PZOCAO1UgVkqXUR6cx0CVv2idKM9ZmsV340XpnfWZQD5WGAiyZ
   NIKJQ9AcDisAIPSsfYtpWse6O+WB25xXBtbbcCplpd1vyUL48GNfCWnN8
   a1XrMs/cfoa1IkeCk76De6ElgRj1zM1aHbM5uPxxBkKWXK8JcLlIgeYhQ
   XFPwhgRVyjetxnVyzuOB+hHV2XGR3PQQjO8gOcYQxGIGFKKwgWaNfZO2j
   Q==;
X-CSE-ConnectionGUID: f3Nc27y5TqebY5Dq/SqCiA==
X-CSE-MsgGUID: JjUtnDSaQd6Phfz/7inS3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720645"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720645"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:08 -0700
X-CSE-ConnectionGUID: RANWslt0T1Wwf0upWN/VKg==
X-CSE-MsgGUID: zvhyNV2mRW+F9t39VuNbCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390560"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next v2 08/15] wifi: iwlwifi: mvm/mld: make PHC messages debug messages
Date: Wed,  9 Jul 2025 06:43:32 +0300
Message-Id: <20250709063858.b25c2f462035.Ic6f042588ef17719653c077ff89a8b9149c22f92@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

These have no real value for normal users, print them as
debug messages instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c | 12 ++++++------
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c | 14 +++++++-------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
index 5ee38fc168c1..ffeb37a7f830 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/ptp.c
@@ -299,18 +299,18 @@ void iwl_mld_ptp_init(struct iwl_mld *mld)
 			PTR_ERR(mld->ptp_data.ptp_clock));
 		mld->ptp_data.ptp_clock = NULL;
 	} else {
-		IWL_INFO(mld, "Registered PHC clock: %s, with index: %d\n",
-			 mld->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mld->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mld, "Registered PHC clock: %s, with index: %d\n",
+			       mld->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mld->ptp_data.ptp_clock));
 	}
 }
 
 void iwl_mld_ptp_remove(struct iwl_mld *mld)
 {
 	if (mld->ptp_data.ptp_clock) {
-		IWL_INFO(mld, "Unregistering PHC clock: %s, with index: %d\n",
-			 mld->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mld->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mld, "Unregistering PHC clock: %s, with index: %d\n",
+			       mld->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mld->ptp_data.ptp_clock));
 
 		ptp_clock_unregister(mld->ptp_data.ptp_clock);
 		mld->ptp_data.ptp_clock = NULL;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
index e89259de6f4c..06a4c9f74797 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ptp.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2021 - 2023 Intel Corporation
+ * Copyright (C) 2021 - 2023, 2025 Intel Corporation
  */
 
 #include "mvm.h"
@@ -298,9 +298,9 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 			PTR_ERR(mvm->ptp_data.ptp_clock));
 		mvm->ptp_data.ptp_clock = NULL;
 	} else if (mvm->ptp_data.ptp_clock) {
-		IWL_INFO(mvm, "Registered PHC clock: %s, with index: %d\n",
-			 mvm->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mvm->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mvm, "Registered PHC clock: %s, with index: %d\n",
+			       mvm->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mvm->ptp_data.ptp_clock));
 	}
 }
 
@@ -312,9 +312,9 @@ void iwl_mvm_ptp_init(struct iwl_mvm *mvm)
 void iwl_mvm_ptp_remove(struct iwl_mvm *mvm)
 {
 	if (mvm->ptp_data.ptp_clock) {
-		IWL_INFO(mvm, "Unregistering PHC clock: %s, with index: %d\n",
-			 mvm->ptp_data.ptp_clock_info.name,
-			 ptp_clock_index(mvm->ptp_data.ptp_clock));
+		IWL_DEBUG_INFO(mvm, "Unregistering PHC clock: %s, with index: %d\n",
+			       mvm->ptp_data.ptp_clock_info.name,
+			       ptp_clock_index(mvm->ptp_data.ptp_clock));
 
 		ptp_clock_unregister(mvm->ptp_data.ptp_clock);
 		mvm->ptp_data.ptp_clock = NULL;
-- 
2.34.1


