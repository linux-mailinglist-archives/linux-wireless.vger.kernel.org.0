Return-Path: <linux-wireless+bounces-36358-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COHRMLUPBGoMDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36358-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F252DAB7
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECCED3070222
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86D53A48E0;
	Wed, 13 May 2026 05:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLBF3odI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394B93A48E3
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651059; cv=none; b=JxUuQM0IxrtCOW0HOH1zXQxXMYGgrwyPx8Hh6tU65qKepesIi534+jDvtPYNzRWtwQiqc8OXAyQtRwr7Vb4cSya8pUcVlGzttX2AjtqDzB3XJ64OoJFSrCbkU45UdQdBtrW7+/a1Aj2qoLabKs3rsu2IUGiGKsrMU6OjFLZICL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651059; c=relaxed/simple;
	bh=A8zopnbn9EWyKjXZr2wL0igkW7GMT610zpwjpWSXVuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PXmRtU+JUwFQH5PPaUY7TsX7nBkK+WQR81SdBhS9HQaI4cLYgZXQfyZ1f5Ej8i1/XT6RYmH5auI9Nq7m4l7dA8QoEepyVnOGJ3r0VaHorRICxv0ifZUi0qlpcZRoD0SjHtwj+lcQgF/XkVrygpux+Qn5mqyyS52xkY4eeBCGRlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLBF3odI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651058; x=1810187058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A8zopnbn9EWyKjXZr2wL0igkW7GMT610zpwjpWSXVuY=;
  b=mLBF3odIfxGafPFECjOJ9miOoDsvMEMKdc2Y9az1pipfRM2TgzSlJ8d4
   XjYB+MaA9Ozifj9BsBjaWpJSi4QoGzfFGAjgtXYi4f2DfxQFOu4ypVssw
   Wr+ufoaiTfRnGE+Uj9MQ60+HofFsS06kys9GimsRWDkcMMK8yVD7ZQgqW
   L0b18kr6sy23SW++TCwTq/JhTW//dl54Tp85dAnsAOKqQqM5xbcLEJMai
   J5D68MG9ZlLMQXCsuiIDSTgzRh1rKoQTB6u+nPDJq30IJw/9w9UtVNYWR
   qx5XM8BB4DPcjWTNgCfqJI4e5QyoHqWtxqZb7p96rQ8SkybKO1L2mtDUE
   g==;
X-CSE-ConnectionGUID: fvIYfBoSSDOAQ6WdvXyzBw==
X-CSE-MsgGUID: 8xFUHQbCQsm1Bq4ogKOcuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552802"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552802"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:18 -0700
X-CSE-ConnectionGUID: Ap1ng1fZSH+wYxM/UftX0A==
X-CSE-MsgGUID: d1vT2CN8Q8ecKtEQ2Sj4sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077891"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH iwlwifi-next 01/15] wifi: iwlwifi: led_compensation is needed for iwldvm only
Date: Wed, 13 May 2026 08:43:48 +0300
Message-Id: <20260513084215.a618af54e3ad.I635c3f49c317960dc8751ddeb5a4a3114d52f406@changeid>
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
X-Rspamd-Queue-Id: 326F252DAB7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36358-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Keep that setting only for devices that use iwldvm.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c  | 3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c  | 3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c  | 3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 3 +--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c    | 1 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 1 -
 8 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index f0453f3f6ba6..5b2a5e254d6e 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -28,7 +28,6 @@ static const struct iwl_family_base_params iwl_22000_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 256,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
index f987ad3192c1..2936ccf1dbb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/7000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020, 2023, 2025 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2020, 2023, 2025-2026 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
@@ -54,7 +54,6 @@ static const struct iwl_family_base_params iwl7000_base = {
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
index 3c844cd419e8..3e936ba7f871 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/8000.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2014, 2018-2020, 2023, 2025 Intel Corporation
+ * Copyright (C) 2014, 2018-2020, 2023, 2025-2026 Intel Corporation
  * Copyright (C) 2014-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -40,7 +40,6 @@ static const struct iwl_family_base_params iwl8000_base = {
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 5872fc9b8caf..7194f681cec2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021, 2023, 2025 Intel Corporation
+ * Copyright (C) 2018-2021, 2023, 2025-2026 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -31,7 +31,6 @@ static const struct iwl_family_base_params iwl9000_base = {
 	.num_of_queues = 31,
 	.max_tfd_queue_size = 256,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 582f61661062..1f862748e33d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -23,7 +23,6 @@ static const struct iwl_family_base_params iwl_ax210_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index c060b12cc952..7b3837b2a8e5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -23,7 +23,6 @@ static const struct iwl_family_base_params iwl_bz_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 3ccbb21276c1..12feac3bc0a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -24,7 +24,6 @@ static const struct iwl_family_base_params iwl_dr_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 04c726e8c283..f82ba1d64b63 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -29,7 +29,6 @@ static const struct iwl_family_base_params iwl_sc_base = {
 	.num_of_queues = 512,
 	.max_tfd_queue_size = 65536,
 	.shadow_ram_support = true,
-	.led_compensation = 57,
 	.wd_timeout = IWL_LONG_WD_TIMEOUT,
 	.max_event_log_size = 512,
 	.shadow_reg_enable = true,
-- 
2.34.1


