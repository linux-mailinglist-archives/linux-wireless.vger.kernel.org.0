Return-Path: <linux-wireless+bounces-22469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E0AA9C15
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB6445A01DE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D0D26F45F;
	Mon,  5 May 2025 18:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FLFu2/+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34426FA50
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471439; cv=none; b=RbmfNumEc9muuxvMl8JMMsgkiuNql34ffudM55j2qhyp+4wpmpKow+2XC+Aeo1MBvn5tSj/oeueYkYwhe4ewA/+gUqdkNrZHhd1di4koRYU5IbX3rJisoU5ejnVUMlxgmVtTFhcSQSVdqdPYk0VLmPuut9PDCxneLHjCbIZKV+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471439; c=relaxed/simple;
	bh=+tHwTgedQRERVcHbdmVw8O8eHgrJZY5sqlwrYbGjVOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRDtFVE9hMAtlYGXJXn8Rn2FjcwNbcEr3+4V/8hoaXz/P9tsYis4H0m8WSdqyNvGWd6TLjbkD+UVSok8+M+i4LxjZhJWlKTEgTL0RwA5A924Yewju3cz4dHYrZ+gTHLPogXAqIkeHLRowoJAoPmopun4HePBcCiwXrCiXXZAdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FLFu2/+T; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471438; x=1778007438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+tHwTgedQRERVcHbdmVw8O8eHgrJZY5sqlwrYbGjVOk=;
  b=FLFu2/+TwugLVNCgvZhjl/i7zjGbNimBKWQ+cmVcFWDnoKJ8wWQIIz4H
   tStCSkG8Zh2LD5Wkmj83uvl8WQu5LbtmXl4NHkOWqHFCCWFjOq2BhvgSL
   FUbOV9jydfFC+1WEtQ7wsurbRGamLil/HTYgn09MVvTbKJIQ7e+hYECvs
   lK36CtE0gW5PM+Zs4SMCK5CSyTPXG7gJRRqhvKuMWwEsULvhDIXtrLvPE
   vuKiT94/eboOgCcmGrEkoQCHZlFxlyq1TYv0Or6HkqZGj4LPNHK8uhrU9
   DIb54IR0LgKS5xdGWRoBVY+N0WAf65urdWkbrl1Hzn7l9jLf8G9QxkRYN
   A==;
X-CSE-ConnectionGUID: KwzdRNFETFutHD0OgyrkdA==
X-CSE-MsgGUID: ipu6WEAsSo+unzxF+3HveA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359444"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359444"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:17 -0700
X-CSE-ConnectionGUID: YQhK/jU7SEyqeDUfKE7WVw==
X-CSE-MsgGUID: 3OJdlKz8S+eRri5DtYL37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697973"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 06/15] wifi: iwlwifi: dvm: init 'keep_alive_beacons' in power tables
Date: Mon,  5 May 2025 21:56:45 +0300
Message-Id: <20250505215513.1e943bf696f4.Id2d7a413dc594c4525ac7ad0650ec8a50e1970ca@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

These should be zero, but we might as well be explicit about it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/dvm/power.c    | 32 +++++++++----------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/power.c b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
index 6d16a7105656..7f8006ac15d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/power.c
@@ -2,7 +2,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019, 2025 Intel Corporation
  *
  * Portions of this file are derived from the ipw3945 project, as well
  * as portions of the ieee80211 subsystem header files.
@@ -64,32 +64,32 @@ struct iwl_power_vec_entry {
 /* for DTIM period 0 through IWL_DTIM_RANGE_0_MAX */
 /* DTIM 0 - 2 */
 static const struct iwl_power_vec_entry range_0[IWL_POWER_NUM] = {
-	{{SLP, SLP_TOUT(200), SLP_TOUT(500), SLP_VEC(1, 1, 2, 2, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(200), SLP_TOUT(300), SLP_VEC(1, 2, 2, 2, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(50), SLP_TOUT(100), SLP_VEC(2, 2, 2, 2, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(50), SLP_TOUT(25), SLP_VEC(2, 2, 4, 4, 0xFF)}, 1},
-	{{SLP, SLP_TOUT(25), SLP_TOUT(25), SLP_VEC(2, 2, 4, 6, 0xFF)}, 2}
+	{{SLP, SLP_TOUT(200), SLP_TOUT(500), SLP_VEC(1, 1, 2, 2, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(200), SLP_TOUT(300), SLP_VEC(1, 2, 2, 2, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(50), SLP_TOUT(100), SLP_VEC(2, 2, 2, 2, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(50), SLP_TOUT(25), SLP_VEC(2, 2, 4, 4, 0xFF), 0}, 1},
+	{{SLP, SLP_TOUT(25), SLP_TOUT(25), SLP_VEC(2, 2, 4, 6, 0xFF), 0}, 2}
 };
 
 
 /* for DTIM period IWL_DTIM_RANGE_0_MAX + 1 through IWL_DTIM_RANGE_1_MAX */
 /* DTIM 3 - 10 */
 static const struct iwl_power_vec_entry range_1[IWL_POWER_NUM] = {
-	{{SLP, SLP_TOUT(200), SLP_TOUT(500), SLP_VEC(1, 2, 3, 4, 4)}, 0},
-	{{SLP, SLP_TOUT(200), SLP_TOUT(300), SLP_VEC(1, 2, 3, 4, 7)}, 0},
-	{{SLP, SLP_TOUT(50), SLP_TOUT(100), SLP_VEC(2, 4, 6, 7, 9)}, 0},
-	{{SLP, SLP_TOUT(50), SLP_TOUT(25), SLP_VEC(2, 4, 6, 9, 10)}, 1},
-	{{SLP, SLP_TOUT(25), SLP_TOUT(25), SLP_VEC(2, 4, 6, 10, 10)}, 2}
+	{{SLP, SLP_TOUT(200), SLP_TOUT(500), SLP_VEC(1, 2, 3, 4, 4), 0}, 0},
+	{{SLP, SLP_TOUT(200), SLP_TOUT(300), SLP_VEC(1, 2, 3, 4, 7), 0}, 0},
+	{{SLP, SLP_TOUT(50), SLP_TOUT(100), SLP_VEC(2, 4, 6, 7, 9), 0}, 0},
+	{{SLP, SLP_TOUT(50), SLP_TOUT(25), SLP_VEC(2, 4, 6, 9, 10), 0}, 1},
+	{{SLP, SLP_TOUT(25), SLP_TOUT(25), SLP_VEC(2, 4, 6, 10, 10), 0}, 2}
 };
 
 /* for DTIM period > IWL_DTIM_RANGE_1_MAX */
 /* DTIM 11 - */
 static const struct iwl_power_vec_entry range_2[IWL_POWER_NUM] = {
-	{{SLP, SLP_TOUT(200), SLP_TOUT(500), SLP_VEC(1, 2, 3, 4, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(200), SLP_TOUT(300), SLP_VEC(2, 4, 6, 7, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(50), SLP_TOUT(100), SLP_VEC(2, 7, 9, 9, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(50), SLP_TOUT(25), SLP_VEC(2, 7, 9, 9, 0xFF)}, 0},
-	{{SLP, SLP_TOUT(25), SLP_TOUT(25), SLP_VEC(4, 7, 10, 10, 0xFF)}, 0}
+	{{SLP, SLP_TOUT(200), SLP_TOUT(500), SLP_VEC(1, 2, 3, 4, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(200), SLP_TOUT(300), SLP_VEC(2, 4, 6, 7, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(50), SLP_TOUT(100), SLP_VEC(2, 7, 9, 9, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(50), SLP_TOUT(25), SLP_VEC(2, 7, 9, 9, 0xFF), 0}, 0},
+	{{SLP, SLP_TOUT(25), SLP_TOUT(25), SLP_VEC(4, 7, 10, 10, 0xFF), 0}, 0}
 };
 
 /* advance power management */
-- 
2.34.1


