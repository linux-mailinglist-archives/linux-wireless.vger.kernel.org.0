Return-Path: <linux-wireless+bounces-20055-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B26A57E82
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD003B13E4
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBA1F9F5C;
	Sat,  8 Mar 2025 21:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQj/bbaz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60B820B803
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741468794; cv=none; b=aXUrEoU9msQ8AlDa9dgvW0KvvEym4mt6VapQGKQau6zbUXjCZ9c9YeWPLhPSBKh8Y8W1BUsGvcTNqijMfYGBoLK/lFXi0qYQIB4kgadnTodEdG3DBfOTA+VCiKw0hDlBIJILsv/iMgbs9NFuw+KjzZWh0XaqTljaf4L1cllGz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741468794; c=relaxed/simple;
	bh=Ichdq+tZ7ND6n1DbkCc5GuJ3+XlFAGNzacYrCqlVfm8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EJwIRmNrtMa9NywxulygvQDmqYzqVeLfUL0tiWnXQ+6HQ+gsRE3zPea+wLv5yPlq2K+G4BMkxb6PWbM+jK+TwMgmium//l7dnUl6W6L0B4RUOKaVub87xrFah0WV2YNwR9U2AES98PGjlRjJ2HUppwTLn0sEXTagfEuM5++BcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQj/bbaz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741468793; x=1773004793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ichdq+tZ7ND6n1DbkCc5GuJ3+XlFAGNzacYrCqlVfm8=;
  b=BQj/bbazWRXYnitY12iYj5TXmcAu96Se3AIbPZQikOKu+8unpmVs4545
   Slua8levfGrhhEgOW/alqfsi/woUowBPGlxvx8/t5BlA1Y7oBDPS9dX2M
   lVWIpTWjTMDPT18zgJYeortBKZZv14WaLL3DzHryOiQOQLVpRbHMFYiBI
   +YzNey2Kvf2SXjp5OJDDGLvWUZVCOlrTZnELxq2hbTLjk/vUd/9lIIYPE
   xIqXpI9mhf4UNx78wIxuEGwE6EAnKg+YDk7Q2YprZ+hIq/bA7F21rEcXk
   K6JTMVSH5mrFrLPoFfVE1uoQsHMJV0ycTQ4KjnUjtJMQGM2QEkorp+QVa
   Q==;
X-CSE-ConnectionGUID: 310eYZarQTu31mfUXNtiBA==
X-CSE-MsgGUID: vU07P2g8Q9qy1IwIJOps1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="60052383"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="60052383"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:53 -0800
X-CSE-ConnectionGUID: lPp2C6pkRhm6pKGSYfCJ7Q==
X-CSE-MsgGUID: HMiBbB0eSMWiBZhMdNaW+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142859942"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:19:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v3 wireless-next 10/14] wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
Date: Sat,  8 Mar 2025 23:19:21 +0200
Message-Id: <20250308231427.55b5455795aa.I333f1e7fa31f9da1d40f668660c1e25b93ff469e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
References: <20250308211925.2332313-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API versions 97 and 98 for those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
---
v3: this is now squashed with the 'bump to 97' commit

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 36e8e3a991dc..dbd303385157 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	96
+#define IWL_BZ_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	92
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 48b487f6e366..282b9b846c3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024 Intel Corporation
+ * Copyright (C) 2024-2025 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	96
+#define IWL_DR_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	96
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 05cbb80ab575..a9fc9e8ec431 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	96
+#define IWL_SC_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	92
-- 
2.34.1


