Return-Path: <linux-wireless+bounces-11913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D324395E449
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 18:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115011C20978
	for <lists+linux-wireless@lfdr.de>; Sun, 25 Aug 2024 16:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B30D17084C;
	Sun, 25 Aug 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZoulE0G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57932119
	for <linux-wireless@vger.kernel.org>; Sun, 25 Aug 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724602657; cv=none; b=MCwhErgCEOR+91tkaZ98MudqJ+jGYFq0JZemoHjC29EFJVo7a9IgWHq8ywEffann1/GkQDNjkybCirI7b8EkD8D4lrlG7hIOXNquwKPgDSKeWBl2m3ud4EtMeZd1jlSo2YjUzdjLD3Twtvkc1zbcHkYAjteKM+nLmC22JijT0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724602657; c=relaxed/simple;
	bh=RyZV9UQsRGjtKkBm7cGAZaaQCuyDdF1zAQ4mBQORxGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sMHmdcvtGemJbF9EfxpXK9cjcQsoIv5yCb7N8i71Ei34Rm5bEelcSDC9dNKYvxkIJ87R5VhLbFZj872m6cWrDAIZWh0rUtoghXZtlVKt6zrm2UsTlRrL9flZ18V5PDPmJWBCddHvl6tHnhkfnVadyesff2FtvJPDUvkvB2g40gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZoulE0G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724602655; x=1756138655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RyZV9UQsRGjtKkBm7cGAZaaQCuyDdF1zAQ4mBQORxGU=;
  b=jZoulE0GyrGELcsFujeHxEMUP0UMCQWVFSqm8nW8lmgM7yXYHLVQz9Ue
   7Y5Xvhyxh9upWBuVGTzaqoXIB1jEclG02HZBSdqvrVB5ygDscBMZlQAOW
   myDRx4rMDLwuwngg2aOtRlFRzpDCzR6l3jGTVDn5WLtZy64j4Kp+UWf+2
   9Dn0RHtcH/QJI+TZL6FELcem6CZoFhQsKj2Ji3jd+Qxd6FGxhr9UuJblb
   2YasklxKCAgVi5sqIrzanMxe0yPt3+nJXHYQI4gupK0db5j/jBRAO7Hl/
   i+G+nFujDvFHC+suWX12Fmlfy9I7ARR3PG1sR0slE5/wRtymdUcDgH/Tu
   w==;
X-CSE-ConnectionGUID: RuQJmindRcyX4oRDAZBARQ==
X-CSE-MsgGUID: EXv4LTUqQdKw23Xi2dCKHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11175"; a="22544132"
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="22544132"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:35 -0700
X-CSE-ConnectionGUID: d4QTzOSMQauYx2m4WI9p4Q==
X-CSE-MsgGUID: GwLi499rT6am1m0jSzGuGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,175,1719903600"; 
   d="scan'208";a="62999754"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2024 09:17:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 08/13] wifi: iwlwifi: fw: fix wgds rev 3 exact size
Date: Sun, 25 Aug 2024 19:17:08 +0300
Message-Id: <20240825191257.cc71dfc67ec3.Ic27ee15ac6128b275c210b6de88f2145bd83ca7b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
References: <20240825161713.3547021-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Check size of WGDS revision 3 is equal to 8 entries size with some header,
but doesn't dependent of no of entries. Check that no of entries
should lie between min and max.

Fixes: 97f8a3d1610b ("iwlwifi: ACPI: support revision 3 WGDS tables")
Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 79774c8c7ff4..8c8880b44827 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -725,22 +725,25 @@ int iwl_acpi_get_wgds_table(struct iwl_fw_runtime *fwrt)
 				entry = &wifi_pkg->package.elements[entry_idx];
 				entry_idx++;
 				if (entry->type != ACPI_TYPE_INTEGER ||
-				    entry->integer.value > num_profiles) {
+				    entry->integer.value > num_profiles ||
+				    entry->integer.value <
+					rev_data[idx].min_profiles) {
 					ret = -EINVAL;
 					goto out_free;
 				}
-				num_profiles = entry->integer.value;
 
 				/*
-				 * this also validates >= min_profiles since we
-				 * otherwise wouldn't have gotten the data when
-				 * looking up in ACPI
+				 * Check to see if we received package count
+				 * same as max # of profiles
 				 */
 				if (wifi_pkg->package.count !=
 				    hdr_size + profile_size * num_profiles) {
 					ret = -EINVAL;
 					goto out_free;
 				}
+
+				/* Number of valid profiles */
+				num_profiles = entry->integer.value;
 			}
 			goto read_table;
 		}
-- 
2.34.1


