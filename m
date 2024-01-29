Return-Path: <linux-wireless+bounces-2727-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2076841343
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E838288C2E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C773C46E;
	Mon, 29 Jan 2024 19:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBJRXeil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F64C637
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706556154; cv=none; b=hwhM55q3t0A3fGYzPTPkxYMhpWGdmgpeIN2mffPxlQFfgLL2IxsaFVuNXmpp4aiQAWBM9H60ZW9ojJ5IXssLi0XoTTVk0mr2FXlH0KG/QhoNr1qXmAQ3AVdUOHcnUr8+oUu2hBP7FNuxa6NZxNnrXirR30+wRlPtx/xfN9iC6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706556154; c=relaxed/simple;
	bh=tkLnG0i1VgaL83jl/sFa7p5JG1+HzQ8JPs0in2ZlH2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SRePc83DovkXx13HW7MM0UKng78xyiPrKjGqxEHyr1C0E0yRKAYnlvDVjqq6CkkRIGbCTpKT/m/LtAMBxoRne9AYaBFWWKNBdgeVxURFjtNtYEnyZu1d0HbS0C9BvnXyeZf6S25f+qbhIX9oOCWD2xKtfuVw2HDWj6fQyfA98O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBJRXeil; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706556153; x=1738092153;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkLnG0i1VgaL83jl/sFa7p5JG1+HzQ8JPs0in2ZlH2Q=;
  b=oBJRXeil7JEJXP/9t0CJpTGsfGcRjN2UJ7Ti9FAk3ziJxU6yp8kK4sZz
   xh/JV/vX9xOquMdMDd/jcP9Te0hqxv7sP782vqiud+X66K9HKLjb1L4T9
   V0ibHfThtsBh0TXGm3gat52XUm+hxKcxdkEW6KVwEblhQztJRf6fUtuJ4
   xwdCU1X6VoS9mz7YVktVqyIeuRrIkZ5q5a4vyEKUtqBhGgZAzNiIL3XHZ
   BvPwpP+U7/KIklnMY0SSnw5SAFW2KZ0FfFprm9nUjejiEHk9MATHS3QSj
   /wpkJHBAIl2qj4fhqI74VswItNdd2VxgWlTy2TByzXvJUE9PL3JliddpD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="2942999"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="2942999"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3459101"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:22:31 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: always have 'uats_enabled'
Date: Mon, 29 Jan 2024 21:21:54 +0200
Message-Id: <20240129211905.bdc5fb20f00a.I902d801d79873c5c9cd51cef8e8226e2acefe88d@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

We check this in code that'd be complicated to put under
ifdef (CONFIG_ACPI), so just always have 'uats_enabled'.

Fixes: 4a9bb5b4d949 ("wifi: iwlwifi: fw: Add support for UATS table in UHB")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/runtime.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 1ec2bcdf92b8..048830bb09f2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -176,10 +176,10 @@ struct iwl_fw_runtime {
 	struct iwl_sar_offset_mapping_cmd sgom_table;
 	bool sgom_enabled;
 	u8 reduced_power_flags;
-	bool uats_enabled;
 	struct iwl_uats_table_cmd uats_table;
 	u8 uefi_tables_lock_status;
 #endif
+	bool uats_enabled;
 };
 
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
-- 
2.34.1


