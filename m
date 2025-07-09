Return-Path: <linux-wireless+bounces-25025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A95EAFDE81
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888D53B6CA5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360AB221FDE;
	Wed,  9 Jul 2025 03:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC2GDRoG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5920E716
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032647; cv=none; b=WLfPLJ7Iy0mw2YD3zFvDS5tnEeaTCHWW2AwhFepy3qWszimYe770CvKKZ8YXlfNRW6DZpsbTKTTrhEf0lDXcrl1nGYFjR+XbG4IdudSdJ5mz2uG3/VGzdhqKdLDdWWXf2S0zeOOEbTSyUNgphJFC0sq5gX3PCi5N/P0lT7COAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032647; c=relaxed/simple;
	bh=L+k4Se5bijqIXNA3qnnceqMeYHHL6EWEcThhrJIfopQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=At3QP2W0S+/LzfYS1wObSMYIZ1/AIBUVsKmNT1OVblnfjDOxOZ4rU0shXFzMgIQnxeakfmMzTc9sRIddZJaaDl1m2sLVydBPmqbCpnF4GYUOiZ/S/bCHu9I9qGA8Hn/LVPjNmedhqGsUgQq/k6APto9zQNi/JCCqBUAXBFioRuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC2GDRoG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032645; x=1783568645;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=L+k4Se5bijqIXNA3qnnceqMeYHHL6EWEcThhrJIfopQ=;
  b=XC2GDRoG1S7/6EHmyVWdhYyPJn+EfPvb/NFUWPWgc7GFwdeULNaTKZos
   14eGEqmFLlgM4bxXcm6l/qSZD4TdcFv+r645ocPli66XzdhqUkInR0+B0
   ntCHhibk3x95bTYpEYlKZERRbleaqxv0QJniW2egDsM4vf/z/BicVyW3Y
   c+piqUoXsm+ZpzCGmX1MLLwCwyV+ZS/n70XJwtWtXOCW0lYUImwX6b+AR
   PD9L46MRofCJ1/8OgbxW7HLI+o1/lN0RFAojY1vNEmF1ND2/Kl4nev9rq
   Efyo2iHw0LH7xT0qd6rmi2QMwzS5aZCErNNmsZX6OMTGif9esRct9rgb8
   Q==;
X-CSE-ConnectionGUID: mukUXKf4So2Kq5Ad53hixA==
X-CSE-MsgGUID: liAhe/JCQuOzFbolk89gKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720632"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720632"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:05 -0700
X-CSE-ConnectionGUID: t5fry5dDToWuxL8pW6ew4Q==
X-CSE-MsgGUID: 8Ofn6oTYQPmz27/DhG2zrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390549"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:44:04 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v2 05/15] wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
Date: Wed,  9 Jul 2025 06:43:29 +0300
Message-Id: <20250709063858.7abe947221d1.I77150bbf55eb160dbe0ef75c3e28afc053f27ec3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
References: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting FW API version 102 on those devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index b5ad6d635fcb..c6cd892bff69 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	99
+#define IWL_BZ_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	94
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index 95aa27c35357..807f4e29d55a 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_DR_UCODE_API_MAX	99
+#define IWL_DR_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	98
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 12c2adb4b5c4..97e503a25eae 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	99
+#define IWL_SC_UCODE_API_MAX	102
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	98
-- 
2.34.1


