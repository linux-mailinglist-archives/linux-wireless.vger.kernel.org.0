Return-Path: <linux-wireless+bounces-3358-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4184E5CB
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C2928EC9D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AFE81AA3;
	Thu,  8 Feb 2024 16:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Am0DxMc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3282D6E
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411564; cv=none; b=BcR2bBEim12Ul7XGW25cbwCfXorw9+YglKOeK3Y4vZB0BpnMEIp2y+7mKwkbBk+1go+CXimru2Fiy9CZmyHkkQM53j4rDiUfhOvvCwzb886g94WJK5FHoWYIhy10kU6dCjRKzhhRfidM3adGoHYcSreFiJ2HczwAkB9TV2J/W2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411564; c=relaxed/simple;
	bh=gRxDtAlwnQXODvVeeW8jSz3FOa9u9Ecs9WZdeUVD/Io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OsjBWLt2XIgHRzpUBril4vXN+5ACQ82YwwGQma19dBilVwbRM3XTQPWS9LsoWRkWFxNDhitnmnrcZV0fUN6wcu4lw6wH21xQp7J3EshG84NjQXgCjrhz4mntphPX1FWTODEz09QfKZyFUwejut7H1Nxhn4OPL+E/XfcbZvPvCag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Am0DxMc2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411563; x=1738947563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gRxDtAlwnQXODvVeeW8jSz3FOa9u9Ecs9WZdeUVD/Io=;
  b=Am0DxMc2ikG88bpAfJv59UCxMJ9V2vRkWY6LrUZEk+QVtOz8POnJdrrS
   d9Mx41a3MeQmRZI+8aeBGBa+mLtLvz2SLjCQuSuLWeT1Zb+HNaNqhsqma
   /rpSrKRObfbGGxBmqsuRhA2u2Llrt35bQFLtCNm7fhKI74NMNi7fzb3ma
   yprC+uh3XQq/CrZtdcQy1myF0ASZ5sOJUpuFdK8OL9/OpoavdnJc9wWXA
   YRPl2ht7x4CUJn1KwhG9GerPEGnccEm0H1chJZrOOShZlEFsr7Y1czXiG
   UqjPE78EraL7qctqLrdRVauQt2MTLVgtVsuVrLTvE+xbL2B6lU6/5BqvE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404029"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404029"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318872"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:21 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 12/13] wifi: iwlwifi: bump FW API to 89 for AX/BZ/SC devices
Date: Thu,  8 Feb 2024 18:58:46 +0200
Message-Id: <20240208185302.b5d0c18c3dad.I55d5bd15638970d27b30b38e9ef47cddf6ba715e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
References: <20240208165847.1190596-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 89 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/ax210.c | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
index 456c7fff60a0..2e530fc928a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/ax210.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_AX210_UCODE_API_MAX	88
+#define IWL_AX210_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
 #define IWL_AX210_UCODE_API_MIN	59
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index c858f355701e..14c5cc265fe3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #include <linux/module.h>
 #include <linux/stringify.h>
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	88
+#define IWL_BZ_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	80
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index be98a174a311..dbbcb2d0968c 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	88
+#define IWL_SC_UCODE_API_MAX	89
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	82
-- 
2.34.1


