Return-Path: <linux-wireless+bounces-26503-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB9B2F8E4
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74A81CE37AE
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Aug 2025 12:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9B320CC4;
	Thu, 21 Aug 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQKTE5i5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904E322C61
	for <linux-wireless@vger.kernel.org>; Thu, 21 Aug 2025 12:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780312; cv=none; b=fiqbD8e3r9Vcuj7USVmJsCv5OxFdlpj+a7dZWyaKy58QVJw7N0grtdH5vv6BE3Lob42402GLm+Lb1PEpaj5pRM5bvk+didxDo+P7eB4UVOHlTYOTQcddz+6/AfkPDYkGwlAXHDs8DXDgUJPT2jfsFfIXV9kK2hwyYh/HH020qwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780312; c=relaxed/simple;
	bh=yAsU254Uy2k0VxDrhKiK0bxJpzOTmqRznZ2LKLQx8NI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7BZObf9t3skq2KgR/11Y5pKFpADYAHNeXiPoanbeGjTUD9U5Wb2xMTKd/VfRYQywmiJWCq38v271uIkk62iDev6V+k4j91/DX2mHetyK7eW4E79jKRwArEluD3MFKvAdVoVLml+HXg+5WaW8whcQul8GrUPzvPiXpkyBey+uaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQKTE5i5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755780311; x=1787316311;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=yAsU254Uy2k0VxDrhKiK0bxJpzOTmqRznZ2LKLQx8NI=;
  b=JQKTE5i59IqyrkoH5R4KIUhVEfiV4x4qxOBZhcmoBNho3azAafBaiXDl
   D7dfRVZK7IQu30hr8T3vNRRkTWCy1mZQzBa1aV0bk/w/W7g25aagYqcqB
   ZNJRCmB6OVdZ74M4ZjIB8tXWaxrAyVrVH8N4uM84QurXPRuOu3/PzpVQp
   cDS87bl79TVqTizx5lOz7jTs9E2dWWHNYUSkBV6JLSu/AubRMhQLonxwC
   bkahU/vWxAWXRQpqUIV9TOHMS8ssAvofsOzfiOYKkfFrjqeGt2GzlL76E
   KMAKix5rpMkzsUnHHTIm9F3FMfOcg+qyPmtPuWZj71OpqU5F1IvCH/EnA
   g==;
X-CSE-ConnectionGUID: MWun24m7RpaWdpNf5/0N0g==
X-CSE-MsgGUID: Pxy0UdbkSIejpbbpNmRqJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="61895752"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="61895752"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:10 -0700
X-CSE-ConnectionGUID: Q5i0bXCxQlKejUmMLNIBWA==
X-CSE-MsgGUID: k81sunYUSfyoMxmRjZCreQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="172622194"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 05:45:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm: remove a function declaration
Date: Thu, 21 Aug 2025 15:44:26 +0300
Message-Id: <20250821124433.2234183-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
References: <20250821124433.2234183-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

iwl_mvm_average_dbm_values was removed, but the declaration wasn't.
Remove it now.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4aeb27ee9149..f02da4e0380f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2021,9 +2021,6 @@ struct iwl_mvm_link_sel_data {
 };
 
 #if IS_ENABLED(CONFIG_IWLWIFI_KUNIT_TESTS)
-
-s8 iwl_mvm_average_dbm_values(const struct iwl_umac_scan_channel_survey_notif *notif);
-
 extern const struct iwl_hcmd_arr iwl_mvm_groups[];
 extern const unsigned int iwl_mvm_groups_size;
 #endif
-- 
2.34.1


