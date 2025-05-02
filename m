Return-Path: <linux-wireless+bounces-22333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC26DAA719A
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07AD1C009CB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B15254B1F;
	Fri,  2 May 2025 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gOV02GYQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9010252905
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746188456; cv=none; b=uYYYN52CoUMlKPRyFsFG0puuoh0B4RNa+++hjkWdUijpuTlW5IiI12j/8eM/r/fMA2y7rybHA+TYxvEM7kEVgirKe1rsL46GhSq5WvHdW0GRLHV1Wtyjj+tR4nqAjak6EKoo+AHAQQPmgsivOsB91bYUrINneU3eeVO5aiPmX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746188456; c=relaxed/simple;
	bh=tS9mU6qcuPMqIRrnlvkLEnUmL4r2znERDyOmAQiA3Fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JGm0GZERiqrLeR2P/18alQTSEHRMnsekMBdR9i7/2XgPvvttEJ+HXgIRTFdXyc7qHbZI/IEpQ7YlKRrxku5pzF6t5EnDEWxDjDNHDER6j0/jq9VOFqDpnGLpLBYzS+Gnl8SqHjvaE8GwLb4bzCNSQhgYfB3UWPWiXD7NZmp15Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gOV02GYQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746188455; x=1777724455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tS9mU6qcuPMqIRrnlvkLEnUmL4r2znERDyOmAQiA3Fg=;
  b=gOV02GYQSiqB4WV3RrXB62Nt6ZWFS0hFfxlxb2f0ILk+u31ofA91PFXr
   jsFglAjlOYNz/6KY7bkX9jr3c9OOPR/VXKBL3ZpRtUZwYHCeJQDOhsfYy
   anJA7zNCabihsuDLJew0JyKH/7e1oNNusm4JvJWvmH+ZMWtujajm3W2l5
   6PcWWs2Jxxa5C1OA56j/XglxgHP9zeI+TZ+eaX3HXC+d6ieQ97RDl+b+6
   4mhaNgSF+YCYTB3+KrjLQbUNSztQ5m6c93XRSWznNSw4MBa0M/sRf2FzI
   PdFyeeV6CKqBHstNT76VrtVTyUVSWzAUzBFuG6WB/SXP+NPz0RAz/odO7
   g==;
X-CSE-ConnectionGUID: d8XpF+QMT9GUgkr8Fd6jjA==
X-CSE-MsgGUID: e2Uk6BNFRZCMRVQ8H3mShQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="48010361"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="48010361"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:54 -0700
X-CSE-ConnectionGUID: jmnijyZYTx6LxTd3P9lNGA==
X-CSE-MsgGUID: FsCiCdKMSu2WraXN8pH/Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="134586123"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:20:53 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: tests: check for device names
Date: Fri,  2 May 2025 15:20:22 +0300
Message-Id: <20250502151751.c04287134280.Iedc7c05a41dc8bfe04dc8b95fea38543513eac2d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
References: <20250502122030.3130085-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add a unit test that checks that each device has a name,
either via the specific name entry or the config's name.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/tests/devinfo.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 7ef5e89c6af2..a64880fd3398 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -47,6 +47,17 @@ static void devinfo_table_order(struct kunit *test)
 	}
 }
 
+static void devinfo_names(struct kunit *test)
+{
+	int idx;
+
+	for (idx = 0; idx < iwl_dev_info_table_size; idx++) {
+		const struct iwl_dev_info *di = &iwl_dev_info_table[idx];
+
+		KUNIT_ASSERT_TRUE(test, di->name || di->cfg->name);
+	}
+}
+
 static void devinfo_pci_ids(struct kunit *test)
 {
 	struct pci_dev *dev;
@@ -71,6 +82,7 @@ static void devinfo_pci_ids(struct kunit *test)
 
 static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
+	KUNIT_CASE(devinfo_names),
 	KUNIT_CASE(devinfo_pci_ids),
 	{}
 };
-- 
2.34.1


