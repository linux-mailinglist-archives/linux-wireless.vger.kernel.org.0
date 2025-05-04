Return-Path: <linux-wireless+bounces-22397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F68BAA85FA
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9C1178B3C
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D2718FC84;
	Sun,  4 May 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxw4FWQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1910D1A4E70
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354430; cv=none; b=DP7GZ2h/wL23VtyR1+JmJijddVZ5xXILsJNIomFDqii0aG+YXX/rBcKA5co5l+cwRVEQkRXRGOJgwP4otlR7hKNnLmnIKk6WMpTyFuQsnwbhsu75Dn/E0uBkexLftQRoWYtOTDv+i1v2nBWrYCJRtBw5sxdyBiB2S/PS1vyID0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354430; c=relaxed/simple;
	bh=Kf4HRVjH+u8ImGmcyfN9FQt4uo/iOrhxY88QgFgZLaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ThfAKC+xmOutrt2GgsdoKux+J6CUW3tmzi8oYy73N/2OUM3IB8fwNqnGHwR9LvDzgC9m5jV48j2bhAW9Y0lCPlhk/h9z4Faf0u5pndYt+L9M+HtqQG5GdwYjcFNRBRbCs11tQR+O4n6fmW1Ok977oaMK5bp+oL3dxMgzzazxiM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxw4FWQI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354429; x=1777890429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kf4HRVjH+u8ImGmcyfN9FQt4uo/iOrhxY88QgFgZLaI=;
  b=kxw4FWQIJybltgsykkxhuQFtTfY4QNwrIxjp08xB1ZDuxclOAjWynyry
   ibaZ1qb92Sn+G6OO6uWD4lEzMtu3ahl/ys8/KmxP3xvHRzpffa25k6VJd
   gWoy7EjKWDc5KEW3QHW1n5pIM3DyrQ6vfCZhQMbJqSRfoOsAQj1EZ0FMA
   znN6tOCyEc9gXC8QDPiNS2HmS5ep9SofWhFq7J9pGOiBsv5Saxzv8BtUW
   eyF0tIQcELq8WeNkuYv0UL+blMJMu1KKCQge8MLKCAK38sy3blCNrfoGz
   xQb5T667nW4l+bhxCEA+ehGbLdCPKZIf+sS2MQZuv0K9qrmT8cJW717DE
   A==;
X-CSE-ConnectionGUID: R9BDNDe2SeCHAypP9fW/dw==
X-CSE-MsgGUID: tLOb18EBT06or/Idybn9+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511510"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511510"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:08 -0700
X-CSE-ConnectionGUID: LJpPI9FsRDOSaTCXwEdxtg==
X-CSE-MsgGUID: /nSRBqbtQOeoZlhjqOLM1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778909"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:27:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: iwlwifi: tests: allow same config for different MACs
Date: Sun,  4 May 2025 13:26:27 +0300
Message-Id: <20250504132447.27f5d570eb32.I1649309a0e54a1d446a38c5b2124a582de9f6d61@changeid>
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

For different MACs we maintain the configs in different
files, and while it's a small waste of space, this is a
worthwhile trade-off for maintenance and simplicity. So
allow different MAC types to have the same config. This
could allow the same config for two MACs in the same MAC
family, but that's not hugely important. Also simplify
the test to not build a config list, there's no good
reason to do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 44 +++++++------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 575327cd3c92..bf15e8bdc4e8 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -60,41 +60,27 @@ static void devinfo_names(struct kunit *test)
 
 static void devinfo_no_cfg_dups(struct kunit *test)
 {
-	/* allocate iwl_dev_info_table_size as upper bound */
-	const struct iwl_cfg **cfgs = kunit_kcalloc(test,
-						    iwl_dev_info_table_size,
-						    sizeof(*cfgs), GFP_KERNEL);
-	int p = 0;
-
-	KUNIT_ASSERT_NOT_NULL(test, cfgs);
-
-	/* build a list of unique (by pointer) configs first */
 	for (int i = 0; i < iwl_dev_info_table_size; i++) {
-		bool found = false;
+		const struct iwl_cfg *cfg_i = iwl_dev_info_table[i].cfg;
 
-		for (int j = 0; j < p; j++) {
-			if (cfgs[j] == iwl_dev_info_table[i].cfg) {
-				found = true;
-				break;
-			}
-		}
-		if (!found) {
-			cfgs[p] = iwl_dev_info_table[i].cfg;
-			p++;
-		}
-	}
+		for (int j = 0; j < i; j++) {
+			const struct iwl_cfg *cfg_j = iwl_dev_info_table[j].cfg;
 
-	/* check that they're really all different */
-	for (int i = 0; i < p; i++) {
-		struct iwl_cfg cfg_i = *cfgs[i];
+			if (cfg_i == cfg_j)
+				continue;
 
-		for (int j = 0; j < i; j++) {
-			struct iwl_cfg cfg_j = *cfgs[j];
+			/*
+			 * allow different MAC type to have the same config
+			 * for better maintenance / file split
+			 */
+			if (iwl_dev_info_table[i].mac_type !=
+			    iwl_dev_info_table[j].mac_type)
+				continue;
 
-			KUNIT_EXPECT_NE_MSG(test, memcmp(&cfg_i, &cfg_j,
-							 sizeof(cfg_i)), 0,
+			KUNIT_EXPECT_NE_MSG(test, memcmp(cfg_i, cfg_j,
+							 sizeof(*cfg_i)), 0,
 					    "identical configs: %ps and %ps\n",
-					    cfgs[i], cfgs[j]);
+					    cfg_i, cfg_j);
 		}
 	}
 }
-- 
2.34.1


