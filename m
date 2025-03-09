Return-Path: <linux-wireless+bounces-20086-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23459A580B0
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9CDB7A310A
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621BC146A72;
	Sun,  9 Mar 2025 05:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETzIDsW0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597C14AD0D
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498643; cv=none; b=LcMR01AIoyFKEN9YrRzLPzjRGGHbuntVS2M14965yUpO3IFNCZbqv1OFf5kaSGQQOoNgJZqmwzXwc6YqnHqjOc8BxZE6SATj2sUhwasT6Dm29C6bzsnpLHs2uk713S1ilZE4VQ5GhwU0PP+oc996ZMd6OIj4f7CFIzFypboUhWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498643; c=relaxed/simple;
	bh=LpsqBxERu74ubq+6NqMBznrCDAtmWg+meNeweARk628=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yuv9/KgQapanWD+BPqAxahQmKgGJoAWZ/EcN8871wYa+wqYoA1Y04VasCrP3KR+5tRBR/9mjJb7eVqhzEh9GlylXAQDWhWLPudsu/JtbAbibmk0v57gw1HRz6ESdB2AdFiq1TWziIxj8FZ4nv6AMTwsqxpb48s1cyy91Xifh0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETzIDsW0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498642; x=1773034642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LpsqBxERu74ubq+6NqMBznrCDAtmWg+meNeweARk628=;
  b=ETzIDsW0Xr1DLvypMGSpGGxbRxBbDN647pB8FOKCav1X6i4f5Cp0pPbr
   fkfXTqXicTDPqcQhixOCW3TWK2WRf3Ke+yLlz1deKAYGdlNRp/RV4n4v2
   YU/WuxMZVNIchZYRpLP2i3Gmi0aZiz7L8nPPVHDV/MLp+0h3JBGdBaeAC
   xEMGQTbjCaARGK41GR7snxKKC1FFuz+CQPi3foo7LT/sQugdatAVGxeDk
   oKZJd4anD2DkSWIrZPogCw6WmQ3i3tlu5Prj7UFuQbq9+fPF8aLQc0u5w
   1hbJUTvLalKbv8jLt1K9VNHhicsm1KJ47nTX0WaED3pDcyDyJruJwZCYW
   w==;
X-CSE-ConnectionGUID: gEgESp+vTBmJIIBdls/u4Q==
X-CSE-MsgGUID: ukxhY6SISn6yRhF8+zwafw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671703"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671703"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:22 -0800
X-CSE-ConnectionGUID: PjREsnvaTYuZyReihO5ygQ==
X-CSE-MsgGUID: n5T+3VOrTfKkbheCuDUN8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470647"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:20 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH v2 wireless-next 10/15] wifi: iwlwifi: mld: move the ftm initiator data to ftm-initiator.h
Date: Sun,  9 Mar 2025 07:36:48 +0200
Message-Id: <20250309073442.92830fd553ec.Icbbd0eba34c9ba318801074f7705f6d1e5af5482@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
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


