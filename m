Return-Path: <linux-wireless+bounces-22399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90684AA85FC
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B658178B3D
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80F1A5B82;
	Sun,  4 May 2025 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxtArrXk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DC1A4E70
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354434; cv=none; b=ucOTgIvb6wxw41ij3uTxqVlHWhaeeBErG+ecMfk3luzViwF2tfyU38uTou4k1rW3d1pPxXURYMbZpr61I0tc0DNx9whIvqc+402o9FzM/8UbYIx7oroIdVgPzKLE+Zw/X2UBw69Ec1FcwlZ+459CY4RRWVpVYLpuJzckdNF0lSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354434; c=relaxed/simple;
	bh=w7zrDPA41MePIoii2R7fhUlVPprdwALpG9jwE0Bqtpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nYpEEBZGGtZWhKhd7VcRKxZsdhS/3s3kRePgB61jakzzYUHANlxZhHZ5PRsJtP4y01zQGSyt8kgnWa+g4UlR8e8piIpzv3P7szMGhSE7dQ1P5le+JModF7ehUesULgTexIDkDkJh6dSQm+8K3A9qRT0UAGKK42nUr3jcOF8SAIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxtArrXk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354433; x=1777890433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w7zrDPA41MePIoii2R7fhUlVPprdwALpG9jwE0Bqtpc=;
  b=YxtArrXk9pnjsSluYsB4pFqWHeEVQfxAjLDLiMONqt4KXXEG68IaSkUe
   jgYfaOWJqQaJGxgojoBQxY92XlgM0YZ6EsnFfZR1Qu4LrWtynt/yHIRS0
   RAYbn1kVpAPjMW7ypczcMAVxCzTJoFJNahvSFBldc3LuECGRrpMZManK1
   Hk5CW3MfteirGRsy7Z8Rkwy3PdoYvOTZv4cHOntI38mqb7EYEmqRFq8lg
   eYiG4KiN+uAQMTTe/PcIgiL53NX6DSKh0q4ZemrnDpMVUfXgRNeWp5iHA
   sf0njWhv+GofYV49dN14QgHMlTq+0MBobucWLgze7C6dwpSVYN6dA1wlP
   w==;
X-CSE-ConnectionGUID: QQecGmViTTOiqJayz8lDjA==
X-CSE-MsgGUID: mUPLTpy8R9SufVq4xQlifg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511519"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511519"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:12 -0700
X-CSE-ConnectionGUID: NZZwsRKbTaS9sjzncgr/Zg==
X-CSE-MsgGUID: Rskyue3LSPCRbE6shqBaNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778918"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: tests: simplify devinfo_no_trans_cfg_dups()
Date: Sun,  4 May 2025 13:26:29 +0300
Message-Id: <20250504132447.85911c59d96a.I540f464229da3566d1726dfb61b46002fbb73bde@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
References: <20250504102630.757937-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

There's no need to build a list of individual configs
first and then compare them, we can just go through all
of them and compare if the pointers aren't the same.
The complexity (in terms of number of comparisons) is a
bit higher that way, but it's just a test and the code
complexity is much lower without that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 42 +++++--------------
 1 file changed, 10 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index bf15e8bdc4e8..d5071fde20cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -157,43 +157,21 @@ static void devinfo_pci_ids(struct kunit *test)
 
 static void devinfo_no_trans_cfg_dups(struct kunit *test)
 {
-	/* allocate iwl_dev_info_table_size as upper bound */
-	const struct iwl_cfg_trans_params **cfgs;
-	int count = 0;
-	int p = 0;
-
-	for (int i = 0; iwl_hw_card_ids[i].vendor; i++)
-		count++;
-
-	cfgs = kunit_kcalloc(test, count, sizeof(*cfgs), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, cfgs);
-
-	/* build a list of unique (by pointer) configs first */
 	for (int i = 0; iwl_hw_card_ids[i].vendor; i++) {
-		struct iwl_cfg_trans_params *cfg;
-		bool found = false;
+		const struct iwl_cfg_trans_params *cfg_i =
+			(void *)iwl_hw_card_ids[i].driver_data;
 
-		cfg = (void *)iwl_hw_card_ids[i].driver_data;
+		for (int j = 0; j < i; j++) {
+			const struct iwl_cfg_trans_params *cfg_j =
+				(void *)iwl_hw_card_ids[j].driver_data;
 
-		for (int j = 0; j < p; j++) {
-			if (cfgs[j] == cfg) {
-				found = true;
-				break;
-			}
-		}
-		if (!found) {
-			cfgs[p] = cfg;
-			p++;
-		}
-	}
+			if (cfg_i == cfg_j)
+				continue;
 
-	/* check that they're really all different */
-	for (int i = 0; i < p; i++) {
-		for (int j = 0; j < i; j++) {
-			KUNIT_EXPECT_NE_MSG(test, memcmp(cfgs[i], cfgs[j],
-							 sizeof(*cfgs[i])), 0,
+			KUNIT_EXPECT_NE_MSG(test, memcmp(cfg_j, cfg_i,
+							 sizeof(*cfg_i)), 0,
 					    "identical configs: %ps and %ps\n",
-					    cfgs[i], cfgs[j]);
+					    cfg_i, cfg_j);
 		}
 	}
 }
-- 
2.34.1


