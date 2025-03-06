Return-Path: <linux-wireless+bounces-19905-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B2A54A01
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2DD188BD27
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6614D20B1EB;
	Thu,  6 Mar 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8Hxx1ur"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D4B20C00C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261769; cv=none; b=LtHE94/2pZDUhrmp+czVXnQOWl7tNNkjzmV1HuTbbGGIdNoDCEiEaYpMiw+Nh6M4nVMBiDXq1glEyDWJZHVECD8LNv1FPae7ezDmW4zNJdP4+kS8SdwV8JV4KklNHlZyYmatVP1XryQBXDuNzjxC7F4QN8cJFn5p5nTg7qMPpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261769; c=relaxed/simple;
	bh=dFoIkK4Zq5SfnobMXIBldKnjGlGvNU0JEJa612kG4Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jJc+wh79FXHvPRI65G8BQnc7uzVyVSJwnb6jjCDE517E4yIKRP3EdP72QBqhtz4e8Qs0PJwBi/K7n0WCV6AUiNCl0QqP+2Qv4paLlM9TwrWaP9K9j4WFI3cfQcd530JtT3RljWWdTIkgJ5QGPrzSl3Z59uc39ldAX9hRA1RCzLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8Hxx1ur; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261768; x=1772797768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dFoIkK4Zq5SfnobMXIBldKnjGlGvNU0JEJa612kG4Vw=;
  b=P8Hxx1urfv+N0bvHg8PfS9KZ3NLa+4qugkfu5x+LuoTrwn0nytzs647C
   i1B3WFP7VzGSBlEUsoQMIV1zZV7hfJaeovdsVnnrnthF3tp5gKTXa1dTN
   xCuYJoRuQELjMrM6/PAH9o9oDGPHdVCBKC/cBFpzBvO0QRQifYlCBTLgA
   PZFUoqOE7NKi4fn2HPLLRAY9stSR3F0OnK/t3p/Svdrq1pQhl50D2/Rej
   VBncpzCTit05IHIj9ETV9L7WDS3ua3LklV31cjy+K+hEFZektVgOS4XcC
   kagJ4v+TjBSeqxYVJtDBONE1Iov6eie54KDTxhnGUyu0Yq6sBYaDcCz28
   g==;
X-CSE-ConnectionGUID: CeE4rGnAQhqwWcPMnne9+Q==
X-CSE-MsgGUID: Xe12nBhiSuuizXINy2YyYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474543"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474543"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:28 -0800
X-CSE-ConnectionGUID: 7WQG1clxTt20gjDcF2Jd/g==
X-CSE-MsgGUID: BUJtmMwyQnKm7iZFytppcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915573"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 12/19] wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
Date: Thu,  6 Mar 2025 13:48:48 +0200
Message-Id: <20250306134559.9bfec241c554.I333f1e7fa31f9da1d40f668660c1e25b93ff469e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
References: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 98 for those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index e0ec9d6337e4..d7636f817b01 100644
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
-#define IWL_BZ_UCODE_API_MAX	97
+#define IWL_BZ_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	92
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 09df9037c91d..282b9b846c3a 100644
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
-#define IWL_DR_UCODE_API_MAX	97
+#define IWL_DR_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	96
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 46c2f3f105ee..a9fc9e8ec431 100644
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
-#define IWL_SC_UCODE_API_MAX	97
+#define IWL_SC_UCODE_API_MAX	98
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	92
-- 
2.34.1


