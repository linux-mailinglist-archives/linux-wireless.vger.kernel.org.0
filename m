Return-Path: <linux-wireless+bounces-22351-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26789AA72B6
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11095A4065
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57844254AFB;
	Fri,  2 May 2025 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9Ww/6Xj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17B23C516
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190623; cv=none; b=EPQU00bKmwNQnJLctHJLd0eGsJe50GE1xRGJxRLTqAc+GS/QFItiDujO5VqKkP5Ix7IAOplEU5M7MT4e7CKj6R7wftrXis2ldzG28/e43hCIhThX42osybsgOk6bWS6pAiBfduXEFbtY84fMDbM7rPqUdoDTOj5cn02XnRpiCXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190623; c=relaxed/simple;
	bh=UlqACQsmHlkHmePiqPYFYO66BBp2TY5bX6+dyYwGo1w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aN0SNsvsbdiCOogqoKanW5Y+NeNuZgchHZElzuNEEnZUy9Z5MW7X+IF9MU1hWK8tNcpJlbFQFvr9hjz1EJ8kDvVzwbc1i3aoQ+RTXt6tuW201P1MsnppMwBrkMB699JIop376VP/Zma9lHNmSM6rK07yOHgSVxefj+qiRHTdSUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9Ww/6Xj; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190622; x=1777726622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UlqACQsmHlkHmePiqPYFYO66BBp2TY5bX6+dyYwGo1w=;
  b=a9Ww/6XjdV34w8J8DsHJtURC+qJmmWwmQYeTkc80/1H40yltLVwCxZfb
   PoRASwZqki5v3z5k5bc9u8WoXb/GWBv426antF0mdWgqjfoIi5JRAhPwL
   +qMPW0mJWTI/CLCp/BTb07iVSAsCXfWeWz4aMJ79LlhS07q+TF8EBfzMP
   kHqGmhJDtHbjYJH9t34rjUQs2IhmajoIuyrlVK7PD1TcgD0Aa+kLmTP0e
   3IU/yVKEQ8Li+oxqidT7uW+tvwBWzGp3/nACs5Ni+Hzd0rr3x8YQz9hSV
   0+otrZotXVWQHOo3VTF01q4WK2VZlxpfGs6R7GqiD5OEFupjiTTRfWc+Y
   w==;
X-CSE-ConnectionGUID: Kr7tZtVBQXaLLG/8xqndSg==
X-CSE-MsgGUID: U92zeKlnRLWO04JJ1E7Q4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255557"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255557"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:02 -0700
X-CSE-ConnectionGUID: TTl3RAJxT3GoPDDf/leE1A==
X-CSE-MsgGUID: xCLUdTuLStWhWWcTP/rUoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554739"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:57:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: tests: check for duplicate name strings
Date: Fri,  2 May 2025 15:56:26 +0300
Message-Id: <20250502155404.9adf2790122e.Ia85152c072c7944f0b80e819cf59a51d6adeb49a@changeid>
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

We don't need the same name multiple times in the binary,
add a check for that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
index 1e339284d2c7..575327cd3c92 100644
--- a/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
+++ b/drivers/net/wireless/intel/iwlwifi/tests/devinfo.c
@@ -99,6 +99,24 @@ static void devinfo_no_cfg_dups(struct kunit *test)
 	}
 }
 
+static void devinfo_no_name_dups(struct kunit *test)
+{
+	for (int i = 0; i < iwl_dev_info_table_size; i++) {
+		for (int j = 0; j < i; j++) {
+			if (iwl_dev_info_table[i].name == iwl_dev_info_table[j].name)
+				continue;
+
+			KUNIT_EXPECT_NE_MSG(test,
+					    strcmp(iwl_dev_info_table[i].name,
+						   iwl_dev_info_table[j].name),
+					    0,
+					    "name dup: %ps/%ps",
+					    iwl_dev_info_table[i].name,
+					    iwl_dev_info_table[j].name);
+		}
+	}
+}
+
 static void devinfo_check_subdev_match(struct kunit *test)
 {
 	for (int i = 0; i < iwl_dev_info_table_size; i++) {
@@ -198,6 +216,7 @@ static struct kunit_case devinfo_test_cases[] = {
 	KUNIT_CASE(devinfo_table_order),
 	KUNIT_CASE(devinfo_names),
 	KUNIT_CASE(devinfo_no_cfg_dups),
+	KUNIT_CASE(devinfo_no_name_dups),
 	KUNIT_CASE(devinfo_check_subdev_match),
 	KUNIT_CASE(devinfo_check_killer_subdev),
 	KUNIT_CASE(devinfo_pci_ids),
-- 
2.34.1


