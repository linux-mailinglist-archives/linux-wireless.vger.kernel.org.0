Return-Path: <linux-wireless+bounces-8544-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C7F8FC9B1
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 13:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5C9285418
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 11:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC50192B67;
	Wed,  5 Jun 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mXUdgQW0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC61922F7
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585532; cv=none; b=tViSFyHiqKtnAfxBDGTh3k34Vl+GF/8QZc5A6J5IXfotLVGXD9oUBDY9JJhfX1z8kWKO00BubEBKflFvw9TgWjr+L3CxwB8Q53pkq+9B3x7TzsXA/DU0NISU+NmwBcX6uQEhhe3/nPEn8E7G7jBQC1TVz/gVh+3Lj5wi0mGlJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585532; c=relaxed/simple;
	bh=c6x8OzBkfrC4V1bPeebuxYjfL8DTtyCE11CyD1nEFZw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n5m7psFbEr5sXO4qW3+kIXn3IyR0shCXxbOrdYxDsKAhhTO99PPXPp1S3eSBhA8Dw3t5LYNpjI1GK0TZO5g6pCJ102NHSrHs/7/WUMoS6qSKa1FVydHJLAa8aPX5yRRJWkAmGw4L9bT5Kvq2OWG5t5U8x8yIR3S8YCPBn93wIzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mXUdgQW0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585531; x=1749121531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c6x8OzBkfrC4V1bPeebuxYjfL8DTtyCE11CyD1nEFZw=;
  b=mXUdgQW0Xf78LkYOww2qIKtGUiKi2wpAlwvAZrwmN2tG/Yf2aSkT0DU3
   bQlvuxsUcsbqAcoq1YiFbRbZajkWSTSBM35aR4ia6XRC/MeQVZ9U5nPuY
   5CCNyS3whJ/jARkAOv0OyLHn2ja4ZdTfsfkLHASHEqtE3a/fpUXJ4jlgs
   TRbApES8seDXUoIAqY1hddwKOBxF9VCvTc3M4YpBZ6is5qX42hzmB2CBV
   xBICgZ3mSxauybmWlLRPsOkzh6YUEMeDePaFjCF6qL6rdZ1r/Mg10RZAz
   gLSux6umNUDRNIrA3viHG8E8YJ+3yzLPqkFOqzeAiwxLIsCSLX3CM1PXx
   A==;
X-CSE-ConnectionGUID: zw2goqUrRdqQT2ZzIyygzQ==
X-CSE-MsgGUID: iLQpvJRbQayGGrtG9w/MAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="14402202"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="14402202"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:31 -0700
X-CSE-ConnectionGUID: ROE+0YgWSRa/RRxAlAZQOA==
X-CSE-MsgGUID: 5RX3X8hKRlKMXRLPxpCNCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="41997441"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 04:05:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/11] wifi: iwlwifi: bump min API version for Qu/So devices
Date: Wed,  5 Jun 2024 14:05:07 +0300
Message-Id: <20240605140327.ad6d43fe9893.I96f769e7d5be3e6499d260451df781bd694a5142@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
References: <20240605110507.2044059-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Stop supporting all FWs older than the max API version.
These FW versions were supported since v6.5.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d594694206b3..2e2fcb3807ef 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -13,7 +13,7 @@
 #define IWL_22000_UCODE_API_MAX	77
 
 /* Lowest firmware API version supported */
-#define IWL_22000_UCODE_API_MIN	50
+#define IWL_22000_UCODE_API_MIN	77
 
 /* NVM versions */
 #define IWL_22000_NVM_VERSION		0x0a1d
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 25952d0bea99..975e8aed1526 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -13,7 +13,7 @@
 #define IWL_AX210_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
-#define IWL_AX210_UCODE_API_MIN	59
+#define IWL_AX210_UCODE_API_MIN	77
 
 /* NVM versions */
 #define IWL_AX210_NVM_VERSION		0x0a1d
-- 
2.34.1


