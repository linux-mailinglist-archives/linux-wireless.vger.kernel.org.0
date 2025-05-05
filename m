Return-Path: <linux-wireless+bounces-22477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FBCAA9C1F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1BC17E04F
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F657264A6D;
	Mon,  5 May 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HoRttltX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC14A26FA7B
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471453; cv=none; b=NHdNdcL2wI0/vEAgc2jrnAOAH6K0piEyocqirJCWhkd/NLpE4UHuePhoEL3ARKcmHDjODBBi5pHFsNMxrPDageidWFzXDrVz+B9LvQ5aVrDjj53Wm0/AxJG0LqNZchbDsjRNmIS7LgAJ4Se7hgiNh0xlFRRkgxTkkdvl0m1IaX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471453; c=relaxed/simple;
	bh=55t9cHsxvdyIV0zjarXoHM55VvrZ5+i5640FmvERsYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ACW+sFH7jDluKiQWV9Vijv53XW2jr4i+fqJDzSKWwdnUaXeQxz3RUgK2SCccWxwZzcwqv2d8q6GOZSURQEEpvca2nuW/JPFycMEpOuU86rbTcrxN0xT0Jf2iOYk5OkXbHhNdTjsfdGbE+RouaPN3eEDNoatZsVfLc2AWPmcs4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HoRttltX; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471451; x=1778007451;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=55t9cHsxvdyIV0zjarXoHM55VvrZ5+i5640FmvERsYI=;
  b=HoRttltXbw/C4h4fBIOuJHfw/hcgWtzSWbp0St9mY/ZVLncmFOpHaEgU
   cjElSSxkZGxzjXEooFIc2d9jfB5C8f3EIc6UqebeWAw0t1PprQDIEXzCY
   u/5HqigrR++i+kSsqun/IEnHIRBSDB/Tuc5i8ZOA4QFAWeqZaBtV5xlJE
   YRhiaalxUaXgqXvLvNaLp4oWAuTf6NKepd6U4bUen6IaEhpIqiCWq/Ulc
   oDGJeOi8vJkV4TTr9paengfLTFwtM39InaydFD+wylz8Y/lIwM9eAMlQP
   lQfQtP4coeYTzLiFZ5C5O5kxd1IfvV6+ENcHxLFfK/c+cHWVb1IaqZ2hP
   Q==;
X-CSE-ConnectionGUID: F8fp6bzBTP+VkZzmwivvgg==
X-CSE-MsgGUID: VTrqH2zBT2yjWhxVp6BD8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359463"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359463"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:31 -0700
X-CSE-ConnectionGUID: jpOgYeivQq+lA87dWxEqEg==
X-CSE-MsgGUID: 9P/bYmi1QNORd4UB1IswVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135698053"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Subject: [PATCH iwlwifi-next 14/15] wifi: iwlwifi: mld: add RFI_CONFIG_CMD to iwl_mld_system_names array
Date: Mon,  5 May 2025 21:56:53 +0300
Message-Id: <20250505215513.da89484cb838.I755709232f5e441ca159bdc5a151bac73d9744d3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
References: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Add RFI_CONFIG_CMD into the names array to facilitate the
display of this command name when sending it to the firmware.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index dfb9908de09d..5bd40b7697f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -193,6 +193,7 @@ static const struct iwl_hcmd_names iwl_mld_system_names[] = {
 	HCMD_NAME(SOC_CONFIGURATION_CMD),
 	HCMD_NAME(INIT_EXTENDED_CFG_CMD),
 	HCMD_NAME(FW_ERROR_RECOVERY_CMD),
+	HCMD_NAME(RFI_CONFIG_CMD),
 	HCMD_NAME(RFI_GET_FREQ_TABLE_CMD),
 	HCMD_NAME(SYSTEM_STATISTICS_CMD),
 	HCMD_NAME(SYSTEM_STATISTICS_END_NOTIF),
-- 
2.34.1


