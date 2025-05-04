Return-Path: <linux-wireless+bounces-22390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 143D5AA85F3
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48D01899D3C
	for <lists+linux-wireless@lfdr.de>; Sun,  4 May 2025 10:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B5E1A76DA;
	Sun,  4 May 2025 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qj7BuDhT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2111A3174
	for <linux-wireless@vger.kernel.org>; Sun,  4 May 2025 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746354418; cv=none; b=E8kHI+Xiy+vSjek1vrAKsqPyRY5L0R/h3YH6F7HRLC+uhGBh0Plaz9G6GMAyC+Ah27YOdjUp7KqanKnJt7UwbHFnUX70n0Xj4RXQM3iFPf6aVqkzYr5Po7Tm4Hu44Nz7qMd8zdTKLtv6seI9Ew8xNR/zsMUDhQd6WGF2nvfo5JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746354418; c=relaxed/simple;
	bh=aIvLobtilCXGqsensMwa4sSJsDG6ha12Jg4h8KkSA90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AvJHGOWGoTNVS323CBzlZiCKHk8l5SwDGzP1NNLeF3zyq4ReTivCYlQQ5UTWI9oWrmUnmZ2bieQfE96r/tOJDBzpCjU7fUbMgbKdFGmm/p7j8YUdlscxKo1LFWuRedTIjbnubCsPExSZTLqyWvES7zUJHmR9socmpuTTL6SIqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qj7BuDhT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746354417; x=1777890417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aIvLobtilCXGqsensMwa4sSJsDG6ha12Jg4h8KkSA90=;
  b=Qj7BuDhT/Tu6xQq7k8/ngaNLagkL10sub76as9VpYSv4Sr+K0/Kg9AGc
   tjIRyAR5bAnI3nKwbbs3whMVSVFjerVSwdYYlskXUdCmsnMGYOEYVAecO
   WyDW9lESKXJVNfoEn95oWWk4jTgaqSMFujBf/bIBkriGOTpv46Q/aNQMb
   oZiBK/Ea7G5NMyrH5sOSaKMIe2x2ErVKa4RWT808TCOxX78smF17OyXBI
   jz8lnmn1HWabcHPbsxSGma7iDg4b7lK57OC+Cl1kxlwiZ1qg8pXbNUTdY
   +xI/aMuvjvvryLVJColJ/AgSD4Dq+Eowg7ufh/y4QO68YRIHUCh+DEryT
   g==;
X-CSE-ConnectionGUID: F9wEK75aS3mfcWdbCGIW7g==
X-CSE-MsgGUID: cXvZJgeBRNKwtGHgyR2mXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="65511485"
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="65511485"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:56 -0700
X-CSE-ConnectionGUID: psfTMwW0QniFh05ihUuoLw==
X-CSE-MsgGUID: xwG7KT+7RCq3r0qOs5+0vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,261,1739865600"; 
   d="scan'208";a="139778872"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2025 03:26:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: fw: remove RATE_MCS_NSS_POS
Date: Sun,  4 May 2025 13:26:20 +0300
Message-Id: <20250504132447.b6da6048f8b8.Ib6d78ed6ffb7e99c42c2dd2ca4706a6bf73d3066@changeid>
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

We can use u32_{get,encode}_bits() instead of manual shifts
and remove RATE_MCS_NSS_POS.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/rs.h | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/rs.c     | 7 +++----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
index c2f806cbab59..df176191d659 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/rs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2022, 2024 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2022, 2024-2025 Intel Corporation
  * Copyright (C) 2017 Intel Deutschland GmbH
  */
 #ifndef __iwl_fw_api_rs_h__
@@ -588,11 +588,11 @@ enum {
 /*
  * HT, VHT, HE, EHT rate format for bits 3:0
  * 3-0: MCS
+ * 4: NSS==2 indicator
  *
  */
 #define RATE_HT_MCS_CODE_MSK		0x7
-#define RATE_MCS_NSS_POS		4
-#define RATE_MCS_NSS_MSK		(1 << RATE_MCS_NSS_POS)
+#define RATE_MCS_NSS_MSK		0x10
 #define RATE_MCS_CODE_MSK		0xf
 #define RATE_HT_MCS_INDEX(r)		((((r) & RATE_MCS_NSS_MSK) >> 1) | \
 					 ((r) & RATE_HT_MCS_CODE_MSK))
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/rs.c b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
index 8f99e501629e..9e5603774637 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/rs.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2021-2022 Intel Corporation
+ * Copyright (C) 2021-2022, 2025 Intel Corporation
  */
 
 #include <net/mac80211.h>
@@ -121,7 +121,7 @@ u32 iwl_new_rate_from_v1(u32 rate_v1)
 			rate_v1 & RATE_HT_MCS_RATE_CODE_MSK_V1;
 		nss = (rate_v1 & RATE_HT_MCS_MIMO2_MSK) >>
 			RATE_HT_MCS_NSS_POS_V1;
-		rate_v2 |= nss << RATE_MCS_NSS_POS;
+		rate_v2 |= u32_encode_bits(nss, RATE_MCS_NSS_MSK);
 	} else if (rate_v1 & RATE_MCS_VHT_MSK_V1 ||
 		   rate_v1 & RATE_MCS_HE_MSK_V1) {
 		rate_v2 |= rate_v1 & RATE_VHT_MCS_RATE_CODE_MSK;
@@ -225,8 +225,7 @@ int rs_pretty_print_rate(char *buf, int bufsz, const u32 rate)
 	mcs = format == RATE_MCS_HT_MSK ?
 		RATE_HT_MCS_INDEX(rate) :
 		rate & RATE_MCS_CODE_MSK;
-	nss = ((rate & RATE_MCS_NSS_MSK)
-	       >> RATE_MCS_NSS_POS) + 1;
+	nss = u32_get_bits(rate, RATE_MCS_NSS_MSK);
 	sgi = format == RATE_MCS_HE_MSK ?
 		iwl_he_is_sgi(rate) :
 		rate & RATE_MCS_SGI_MSK;
-- 
2.34.1


