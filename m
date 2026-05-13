Return-Path: <linux-wireless+bounces-36368-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHzDGisQBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36368-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B73D052DB4F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 302DC30C4538
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BE23A6EEF;
	Wed, 13 May 2026 05:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bY6WpNBv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D1C3A6EE2
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651072; cv=none; b=IYHrlnT1tb8P0fbjeeAzfUuwgKN7wflw7U3H1LjW3ABjCxWz4Fi4FAYh1HLC3Kdralp3npLfUQLD6X48eu39VDf66pyu2gReRUPKLrtenC9d2C6j4L6I+YYvheLSH0etXmHu0eADckyh8FEwyp7N8q/4MsuupttT8mgB1r1nhrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651072; c=relaxed/simple;
	bh=h9TixR5m1JtUUcNZEQIXDGEIQUG45ThVQlp3ngWO6U4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAFgg8imRE9EdpcWzmwndLXPV9/u11cily7vU/6ZVlvs2UC94OGn9sg8VlVCOVetOhzS9o25isAo+NwRRTmTVdy9GSZZck1qUuZzoqxV5h5XM8MlpXVZXEbzwaH/sxksoDzL2SQcucaG4XDJ/igXnQjaFnL4fTREV2qv6BTMmz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bY6WpNBv; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651071; x=1810187071;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=h9TixR5m1JtUUcNZEQIXDGEIQUG45ThVQlp3ngWO6U4=;
  b=bY6WpNBvpvV8q7bYpTjATFvDxnNPbFACgg2MAjwOdmGf6SD/28S1eTd2
   /T3Gw0V9HWHKFqk+Hdt8Gfizc8fM5tckepq3E6d1An+mlaaWM9a7R6iDy
   gKe79rdwRFBMUEdC19pczSAPhvgw1hosIchbsNRmvO6PQhwVLyjOJRImh
   jr/HDH6uMk0jteC8Ih3QtKdq0o1oXGtuHbaQEbTflOeErcr7v1XokLKoR
   5XptqWH+6JKF0ywA5ReTy/0qEu8QuoJYXRzYGkAY7pb+sCDJHT24+Ffyl
   EpSAmogSH07BuZ8KdpZXH7m5UEeG5scKgSYJpnnxsYbsFFcvke5vwBpvA
   Q==;
X-CSE-ConnectionGUID: gburQD5dSZGezok7GQk7zA==
X-CSE-MsgGUID: 8JS9haaeRryLhzcO7xwTyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552841"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552841"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:30 -0700
X-CSE-ConnectionGUID: r/sN1CmVRp26UwsBz0adiQ==
X-CSE-MsgGUID: +VM6wTZdRpGN+7+i8N/sBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077941"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 11/15] wifi: iwlwifi: bump core version for BZ/SC/DR to 104
Date: Wed, 13 May 2026 08:43:58 +0300
Message-Id: <20260513084215.9d584ef19b3c.I2b5b08ff63f8fafda6bc888b597615ad7d34f537@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B73D052DB4F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36368-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

Start supporting Core 104 FW on these devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index a70b356d9576..51d7c599e998 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	103
+#define IWL_BZ_UCODE_CORE_MAX	104
 
 /* Lowest firmware core release supported */
 #define IWL_BZ_UCODE_CORE_MIN	101
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index e95112fdc664..76fbc120a092 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2024-2025 Intel Corporation
+ * Copyright (C) 2024-2026 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	103
+#define IWL_DR_UCODE_CORE_MAX	104
 
 /* Lowest firmware core release supported */
 #define IWL_DR_UCODE_CORE_MIN	101
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index d1e5cef42fff..db7858b2cb74 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	103
+#define IWL_SC_UCODE_CORE_MAX	104
 
 /* Lowest firmware core release supported */
 #define IWL_SC_UCODE_CORE_MIN	101
-- 
2.34.1


