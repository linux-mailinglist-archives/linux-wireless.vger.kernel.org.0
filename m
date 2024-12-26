Return-Path: <linux-wireless+bounces-16809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B720F9FCBA3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5794B18832E7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E959B1304B0;
	Thu, 26 Dec 2024 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="STyj1Iii"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAA283CC1
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227921; cv=none; b=KUVPtx5mFE3C25o2vmwHdyfm3KnBJGeF5VJpF1yL32FDFtabcRYvReWCQ7SZ40cjr5VUE0yXl0bw++NNXQyrpRgDVajT0e2zR+JryrQfYFHliJH6JSYc51bpnEBrP4tvYqLikTBemcuijTwYB1NV8qkAk1fCiTQLGqCsxWIc3Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227921; c=relaxed/simple;
	bh=Gtt4abF5FCnYON45c06zytpgSAOqutq7kiaez1iNvXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GaHdN1GCSZRPjLt5AYiNnZPo5JsYGTbSa7U8jas29w+PtEwLenb0ciXOgzxmEp1yKkICyaqSV5Q3eW25aF6hU0Eg3aBPak63/X6xQyeRJ6A8K8hig8pu3MrDw/h9if//ZxDZZlULpBMNSDg66TqJxzgvCf3O6sPaWKY99hUTEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=STyj1Iii; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227919; x=1766763919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gtt4abF5FCnYON45c06zytpgSAOqutq7kiaez1iNvXA=;
  b=STyj1Iiicf+hncMWWLXNZKl3PTO3UNePLYjMFHLiBTes+0jscpKBrBP7
   zqusRN4uxEaP5V9vOxMeSRgKpxMwwx1Wwom1fih4jxVf10rcNAmB/lweZ
   rAUhuVvBTNDDaO0tx56urjhgZS/cbt11jfBRzOaPCkEy6mlDIPqxmO8qm
   chFlF+4OnMl0U1dJArZuz76I7DzYroBcJVJN+BuMUwS5rDkmTUB5vr08e
   FWaBmda/erRcmVDDK2TWck7JqXnxTAGfqeSUzsM5I9iqb5IFn0QGYTfXw
   sZUC+h64cHPeR8HUAli7b1reL+XKXvPm5EdOvALtglL0MZSvPZxUBJmL4
   w==;
X-CSE-ConnectionGUID: L+Z27krDR0KJggTjaENGpw==
X-CSE-MsgGUID: rerGGU1fRDiRviRKG/UlZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878135"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878135"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:18 -0800
X-CSE-ConnectionGUID: bn8KgYfRTD6fCSVpK0nt8g==
X-CSE-MsgGUID: iyhdnedMQGyzAtcEIHa00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777985"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: mvm: update documentation for iwl_nvm_channel_flags
Date: Thu, 26 Dec 2024 17:44:45 +0200
Message-Id: <20241226174257.d4018e62b2bd.Ie20fe3408bcc358078e3e5bf38edeb6b951c9a40@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
References: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Enhance the documentation for the enum iwl_nvm_channel_flags to
provide better clarity for NVM_CHANNEL_IBSS and NVM_CHANNEL_ACTIVE flags

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index d902121da009..9f7e013252fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -141,8 +141,10 @@ static struct ieee80211_rate iwl_cfg80211_rates[] = {
 /**
  * enum iwl_nvm_channel_flags - channel flags in NVM
  * @NVM_CHANNEL_VALID: channel is usable for this SKU/geo
- * @NVM_CHANNEL_IBSS: usable as an IBSS channel
- * @NVM_CHANNEL_ACTIVE: active scanning allowed
+ * @NVM_CHANNEL_IBSS: usable as an IBSS channel and deprecated
+ *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
+ * @NVM_CHANNEL_ACTIVE: active scanning allowed and allows IBSS
+ *	when %IWL_NVM_SBANDS_FLAGS_LAR enabled.
  * @NVM_CHANNEL_RADAR: radar detection required
  * @NVM_CHANNEL_INDOOR_ONLY: only indoor use is allowed
  * @NVM_CHANNEL_GO_CONCURRENT: GO operation is allowed when connected to BSS
-- 
2.34.1


