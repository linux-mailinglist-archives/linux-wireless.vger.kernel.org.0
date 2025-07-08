Return-Path: <linux-wireless+bounces-24982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A12AFD796
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B996F176DC7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BED23D2AF;
	Tue,  8 Jul 2025 19:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S2G3i4vt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF291DDA24
	for <linux-wireless@vger.kernel.org>; Tue,  8 Jul 2025 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004284; cv=none; b=pj6tdv2dJOTtFO1cU5I6yq7bsmNr8z4zd4vQ/zkWbSbt+8KjJ6ouMVxxElI7Oao6faDs3HdNbociK7KH1tZkcr5zQulYtzSBep/kNhVJj07RF/iSCTrk6y2PpBcC9mHgNwbfSAPi+SYQ7PkK97mB6TnPM6aainHtJWV4oDBWwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004284; c=relaxed/simple;
	bh=L+k4Se5bijqIXNA3qnnceqMeYHHL6EWEcThhrJIfopQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lneFNbh1+1SfNsfpvY76xby3BZ+y1iIpuNIi6CRpMPtbqRRK9DP/YRbx5il+zyUFEjsoQeVYfjNbMyI8hDu9mWztFSHelzoyxGtuOR9SMKXpSmrci3k8KTykKkU4dk0I9xJBIbIVf0mgZBclW3ydthcgM4I/yN4VmJ1j7pfIbJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S2G3i4vt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004283; x=1783540283;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=L+k4Se5bijqIXNA3qnnceqMeYHHL6EWEcThhrJIfopQ=;
  b=S2G3i4vtq8pJlfmlR2tXPfvx90GXpWHjEfbBedg11VXNRG29ZIZ1oj7P
   Ns8Qto6oEM0FAG8yaWcOF+nYkhEe5+6jUlIiGTuIxWFdAb2jqoY4YvzVx
   ioiMgVvy+mcY7YBfIGbo3UvxcTOddFheIOsNO7gae1zBEANLFJ3h2Gz+f
   ZqLTODowNiWvON4pA9Vle8wJGMlZdk6ChpAgS91XZbLS0fiYmNV0OxX+1
   ZZ56gmLAZnJnAPqeoslydGTskpNHw/yDLfuV1Mlgb0dc8pfIX7nC29x20
   UT2vqcmnhc/0ms2npmBJ3eeDz8FrT6ZNxx736t51kjyg2oFH5DKfMBq98
   Q==;
X-CSE-ConnectionGUID: kbS7fEtuQNeu+DyQUTBE4A==
X-CSE-MsgGUID: SG9ufVR4T1+EJATBuMubJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="54229714"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54229714"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:21 -0700
X-CSE-ConnectionGUID: 944CGP//SH2alytSrCgqXg==
X-CSE-MsgGUID: dU+9RYN3TFGtVDXNO65Xxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="155668938"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 05/15] wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
Date: Tue,  8 Jul 2025 22:50:43 +0300
Message-Id: <20250708224652.7abe947221d1.I77150bbf55eb160dbe0ef75c3e28afc053f27ec3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
References: <20250708195053.451143-1-miriam.rachel.korenblit@intel.com>
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


