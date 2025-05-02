Return-Path: <linux-wireless+bounces-22344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9050AA72AB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F215A2BF4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D557254AF8;
	Fri,  2 May 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GJblBIQD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B812522AB
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190610; cv=none; b=Mv+L1boOwxCrp+Q4mOMEnpgYt68DrM0KPDEgs5T3TEUhkYPUQxHHQ3rJXTQEc6SfEwZRVi53bS1a/q31hKMO5IPpS34N/NM38xvmIpuoF2ElVK/AMCI/o1vtjKiWz/tCm2E4uJ7mvS8M9zBPB6ZaC5ijIgSI92rYO4DCGkioO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190610; c=relaxed/simple;
	bh=VW1uH1TS8CQq2QGxMG8LFdFSdbogbZ8MkiQZc6K54Zk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QaqUdAxhqtPF3K1bLq0eE5kKMjaVf3MF+itAU0FXGB8RRKdQdSvMsVvjkt4+oQK+oAiQWlVK4lIJxIEqbEqhptyYScRf5NDDNF7GBLSqP0zT9NVDLx6qtnX/GAESocBCfI37Ts/jx1+P+UZ75zy7grpeXNPfIhsOFY9EBxeWgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GJblBIQD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190609; x=1777726609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VW1uH1TS8CQq2QGxMG8LFdFSdbogbZ8MkiQZc6K54Zk=;
  b=GJblBIQDi4jxHN4JWUNReqzFsqbQ4KcWHoz0C14fRE4ZgJi9mApeaMD6
   U35o748eejRymyNgYI+6a9aamDs9NESTgoRBeyymgFzWsXLkBRMES0XgL
   JYsiNuq5wSY9HdurZa5gZPrjQSFaV8iKLM1nP12fCWgpLR9lDW80o/sEB
   9wJ+ecnDRzCIjlwUPNSBhAeAezksah4cSYFhtMwVksTpfRBsCn4ivGLZE
   6kynS2KhNJK1iWgOGByV5hmTGhD4637cLTNtIzulzu+pMEzQLVbZ5jW4G
   +aULCCXehX8qMKs6ETSavcLFGN6c2fOWGJ/ydi0zWGQchT1AKD4muMpVZ
   Q==;
X-CSE-ConnectionGUID: sjhpdVE9SL+23o32ZPc1BA==
X-CSE-MsgGUID: yiXl0plnQcqX83bdPoUJjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255535"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255535"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:49 -0700
X-CSE-ConnectionGUID: PV5sCHzKQ1in5e4T+RNyNQ==
X-CSE-MsgGUID: ctUC2K1FTm23MugsQ9Yh5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554701"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:47 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 02/15] wifi: iwlwifi: tests: check configs are not duplicated
Date: Fri,  2 May 2025 15:56:18 +0300
Message-Id: <20250502155404.0cfd9fb8322e.I9567b839405be8d1e4be0bfca7a17b5d222b0158@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
References: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a kunit test to check that all (used) config structs
are not duplicated, ignoring the name since that can be
handled differently via the dev-info list.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index a64880fd3398..0de3a01001d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -58,6 +58,52 @@ static void devinfo_names(struct kunit *test)
 	}
 }
 
+static void devinfo_no_cfg_dups(struct kunit *test)
+{
+	/* allocate iwl_dev_info_table_size as upper bound */
+	const struct iwl_cfg **cfgs = kunit_kcalloc(test,
+						    iwl_dev_info_table_size,
+						    sizeof(*cfgs), GFP_KERNEL);
+	int p = 0;
+
+	KUNIT_ASSERT_NOT_NULL(test, cfgs);
+
+	/* build a list of unique (by pointer) configs first */
+	for (int i = 0; i < iwl_dev_info_table_size; i++) {
+		bool found = false;
+
+		for (int j = 0; j < p; j++) {
+			if (cfgs[j] == iwl_dev_info_table[i].cfg) {
+				found = true;
+				break;
+			}
+		}
+		if (!found) {
+			cfgs[p] = iwl_dev_info_table[i].cfg;
+			p++;
+		}
+	}
+
+	/* check that they're really all different */
+	for (int i = 0; i < p; i++) {
+		struct iwl_cfg cfg_i = *cfgs[i];
+
+		/* null out the names since we can handle them differently */
+		cfg_i.name = NULL;
+
+		for (int j = 0; j < i; j++) {
+			struct iwl_cfg cfg_j = *cfgs[j];
+
+			cfg_j.name = NULL;
+
+			KUNIT_EXPECT_NE_MSG(test, memcmp(&cfg_i, &cfg_j,
+							 sizeof(cfg_i)), 0,
+					    "identical configs: %ps and %ps\n",
+					    cfgs[i], cfgs[j]);
+		}
+	}
+}
+
 static void devinfo_pci_ids(struct kunit *test)
 {
 	struct pci_dev *dev;
@@ -83,6 +129,7 @@ static void devinfo_pci_ids(struct kunit *test)
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_names),
+	KUNIT_CASE(devinfo_no_cfg_dups),
 	KUNIT_CASE(devinfo_pci_ids),
 	{}
 };
-- 
2.34.1


