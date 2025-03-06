Return-Path: <linux-wireless+bounces-19956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A81A5595A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 23:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6A916AF34
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 22:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B627C86B;
	Thu,  6 Mar 2025 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fh3c7/IQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715527CB0D
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298727; cv=none; b=am75obChdjjDOnGriju85dhx790ogW1BAGXjdw45rwsZuKBv/euXl+q85TCWOHuec5F09N9ykZShZ/qNwRrCslE96YpzgweRP0JiYDEBulWp81FLf6rOnmf/aHbDfO8nFPcdhywVrr3zTjC2zVWsOPUbtrXbJydcMoqkB6pTSaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298727; c=relaxed/simple;
	bh=dFoIkK4Zq5SfnobMXIBldKnjGlGvNU0JEJa612kG4Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iq4tKunU/Pk70LEiQgJSgSkFUXKVg99th9cRE21AXLIOG4H67ebrS1lJKcNxgqaZG4nheo0zLoVJew/nAoOb6N0uhhRP0RLtUlUWwm0xRgvwJnGeZtyYRMaPWV4Gotyk9LjZ++JQvLhLV1uMX8V6PjqpTLYvl5wdou3o+RfhtOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fh3c7/IQ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741298726; x=1772834726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dFoIkK4Zq5SfnobMXIBldKnjGlGvNU0JEJa612kG4Vw=;
  b=Fh3c7/IQok7VKT1NWCgP0suR0fhY4bE6E/1O+DCEtpbYQZ3XHb6mnDHL
   XFKqmIvLAFw98O5sf2ghlqCQUwh+o2EnFDuAjSJmB1Q7dwiFm/bl+pRHh
   0inztxlYdVUaw8RWxwnc7YBK1OmDbn8Ih8Ll2iQ1z6LZkmV2QVbTi+btY
   l91WTDLgqrL6BScqXGhNew3dJ3ALsidNUo+EbQPQet6xrjI6wtfWGY3Yf
   QZML3hgbj+bjd2WNpkHGFUIZCoIR/RGpsX6NumDyiqcCLwHpjxMjE1Mr/
   3tdC5iCC8A7/AnjU3yrNqtxwKfLwQvgX/l0PD4nEHkaQB6RVb2suxTRj3
   g==;
X-CSE-ConnectionGUID: qA5QGuRaR8i2ezVn9+qpWw==
X-CSE-MsgGUID: z6EEEr64Ql+M1jLLU5UW7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42474278"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="42474278"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:23 -0800
X-CSE-ConnectionGUID: Cx8/P6aGQmqCf/Yg4UWboQ==
X-CSE-MsgGUID: kuhibOppT62n8IpQoziXhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120061910"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 14:05:22 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 11/15] wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
Date: Fri,  7 Mar 2025 00:04:50 +0200
Message-Id: <20250307000213.0d44d64f0dd0.I333f1e7fa31f9da1d40f668660c1e25b93ff469e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
References: <20250306220454.543262-1-miriam.rachel.korenblit@intel.com>
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


