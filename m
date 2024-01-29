Return-Path: <linux-wireless+bounces-2728-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED878841344
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB651C24072
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE974E1BA;
	Mon, 29 Jan 2024 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F1EoO9Wp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0F4C637
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556157; cv=none; b=nlUNuxeIngNETIuoVDVRr4N8jo7VRLUhqR8B5HXhjrMExEvswFr38cRSsKe15qoj5qV6R4M3tItk3EvH3kBR7AIp0at5PeVBmFHdfJ+Wsgra8f4+pp/BIQLBa00qcb40XjwxJIl6CVPq+XG8d9/YGx0/JOy02ryqg1fZLdl+Wv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556157; c=relaxed/simple;
	bh=/t0g9T/AywlIcDrgWK32WRnEm7dIGnpKGdRCT/vuz0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ef3+2IUd3T2IMh11iZERdtf8OqtG1v9HZ4+y+sRhM/LezjoOAkon3dNcInSSD1G6dSGVBP2e4HnIltJ3wzZ53WAbZvTNWtvJ7R6V32pq7gfmuUyL7qCYeZpeu1kFDsJQ/XviLYmD+cqip2rbnkdmixWi+ctD04kp2gumfRyJVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F1EoO9Wp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556157; x=1738092157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/t0g9T/AywlIcDrgWK32WRnEm7dIGnpKGdRCT/vuz0M=;
  b=F1EoO9WpZKusowELQ3h988Z7lsUq6tchofZfJ9taFtUyoS4re6x1bZfw
   mOBAOWKB1av9WNGKK2/ruGeG2T6hozC36SBv7DaICXmkMAn0PdqldNNDb
   fuSg+Q6faxwHJWwoy5sKzckVFgwq4IHRyfC0Ixrrpn4Oet3hzw7RozMmQ
   nAf9Be7VwZ8EnAbVNnkNfmmw5sD7HJnnc0BOvR3Vo18aBRJ6SbKA7IlYe
   bjXCkc2JXkJd61lmPBGhmJtySo1K3j0i/SnnCGxQ5cFkjRG67P0Mhb3CE
   7lD0nQz8kI4Dq0WXx6B6Alp3yZeXQahD7HOM1Jt3hXLodhUl0r+ks+0+U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2943019"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2943019"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459106"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: Fix FTM initiator flags
Date: Mon, 29 Jan 2024 21:21:55 +0200
Message-Id: <20240129211905.6cad71069e87.I7f9fd5239cfd2244f155f88419980e6e91d00ff2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
References: <20240129192203.4189915-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When secure LTF is used MFP must also be set.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index 233ae81884a0..4863a3c74640 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #include <linux/etherdevice.h>
 #include <linux/math64.h>
@@ -821,9 +821,10 @@ iwl_mvm_ftm_put_target_v8(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	 * If secure LTF is turned off, replace the flag with PMF only
 	 */
 	flags = le32_to_cpu(target->initiator_ap_flags);
-	if ((flags & IWL_INITIATOR_AP_FLAGS_SECURED) &&
-	    !IWL_MVM_FTM_INITIATOR_SECURE_LTF) {
-		flags &= ~IWL_INITIATOR_AP_FLAGS_SECURED;
+	if (flags & IWL_INITIATOR_AP_FLAGS_SECURED) {
+		if (!IWL_MVM_FTM_INITIATOR_SECURE_LTF)
+			flags &= ~IWL_INITIATOR_AP_FLAGS_SECURED;
+
 		flags |= IWL_INITIATOR_AP_FLAGS_PMF;
 		target->initiator_ap_flags = cpu_to_le32(flags);
 	}
-- 
2.34.1


