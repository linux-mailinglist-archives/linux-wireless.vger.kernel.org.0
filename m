Return-Path: <linux-wireless+bounces-28063-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D26BEE0F8
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A1FEB4E6F07
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF60A2BD001;
	Sun, 19 Oct 2025 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNT6Q1pq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD026F296
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863542; cv=none; b=j/kdM1zqGB0wNBZD+CmcntNhWWl+cQatefVGagR8sU1yd0wNsGwh50fr3VkDDTXoKmyyrL7d1WV7mzVEBFxPCTP0+HIe4gj5rW1H5FrxUVxzRuxWgHtm2TI6wLaHpeX//i2ZvQqPQjgUvEpTjDQm04OmkaEzSBfVe+/riQGSbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863542; c=relaxed/simple;
	bh=Cw2sXqwF1Su9/ngBjZX79sZpxrB9+oh1uKyKmbplrMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FSxCYHsTwNNEeSZ3D8PB+fXZ+w+V/qrKtmHHDbRStQ6G3KBKs5rPHWLRAFLLZdjQaQgNQmtL8KwSn/1gVepQqys2bB1+Xm+Wdo1vQkpx75cjN2r6V8fag0a7i9t9qslwEKZX7L4m4WiLiI7HG6eZYE8kJlLlicFJoFgRzUmOoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNT6Q1pq; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863541; x=1792399541;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cw2sXqwF1Su9/ngBjZX79sZpxrB9+oh1uKyKmbplrMQ=;
  b=fNT6Q1pq6FmXzR7v2i1vy+YKE15Zu6hN7NYW8iLpa0F6lYTMLTmS/+5L
   CIt3jR/Q0XNDf80f7oqlXnGXbfNWpu04QFQDl372ALSkuyoPeNlVOBzx/
   5A++r3ve6u64ceWY7nb+WL5dluiIL3LcFSzCCUAqQgZzEISBQHBaS8FVH
   w4aZUcwH1kieHIANDIrbqOKNvY3kiWhtUEmCc7XnBvnCcfIMf93NOwVLn
   uic6YT4FGibAdVtPi04QZtn75lw1g6eKccWchDacoTd8JfELjbdMxiSBO
   mf8HrjRsw0JItWWT8pLQPMMa62UE6IN4LmO+PHHX7tLpnNGNyjc+zWjEM
   A==;
X-CSE-ConnectionGUID: kZz+OyuxR+OkmmB9l+ZsHw==
X-CSE-MsgGUID: LTgWui7pS8OSPrsWGrkX5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74363186"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="74363186"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:41 -0700
X-CSE-ConnectionGUID: D60fDRl3SNiiaFhGPxpyvA==
X-CSE-MsgGUID: U2mNOfQzQVmgk/A2wF3oMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="182279888"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:45:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: bump core version for BZ/SC/DR
Date: Sun, 19 Oct 2025 11:45:09 +0300
Message-Id: <20251019114304.00c28b4259da.Idd6281cd647f1b33f2572a8c107c3a3228e03665@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
References: <20251019084516.2568208-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Start supporting Core 100 FW on those devices.
In addition, the move to the new Core scheme (instead of API scheme)
will start Core 100 and not 99, as planned. Adjust for that as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c  | 2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index 7babb60463be..28005f25c38b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_BZ_UCODE_CORE_MAX	99
+#define IWL_BZ_UCODE_CORE_MAX	100
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
index ad65951d5643..c1c6174534d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/dr.c
@@ -9,7 +9,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_DR_UCODE_CORE_MAX	99
+#define IWL_DR_UCODE_CORE_MAX	100
 
 /* Lowest firmware API version supported */
 #define IWL_DR_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index abb6283dfb8f..d9943d252ae0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware core release supported */
-#define IWL_SC_UCODE_CORE_MAX	99
+#define IWL_SC_UCODE_CORE_MAX	100
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	100
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index a51d8b878412..f7016e4b28cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -348,8 +348,8 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 
 	if (first)
 		drv->fw_index = ucode_api_max;
-	else if (drv->fw_index == ENCODE_CORE_AS_API(99))
-		drv->fw_index = 101; /* last API-scheme number below core 99 */
+	else if (drv->fw_index == ENCODE_CORE_AS_API(100))
+		drv->fw_index = 102; /* last API-scheme number below core 100 */
 	else
 		drv->fw_index--;
 
-- 
2.34.1


