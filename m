Return-Path: <linux-wireless+bounces-3170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C10484A6F6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F210BB27C93
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01D758AC8;
	Mon,  5 Feb 2024 19:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfION/cM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AB58AB0
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160914; cv=none; b=sgCYT35/CfW5Lo6ILMU0JINq+M1WDxQqAr6WLl6u/VmbYakSGM6HOHf81JOPr8/oN6UHMZIz2NFxtAPL3BlyGtFtcR9sFoMbSQtAt9DGn0ioEwwKPPmk0s4O85LLWOA27nvGZ6KtXYa10GbxwH76NktZMdLIV+wlmIVlj+F+yH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160914; c=relaxed/simple;
	bh=n/xWpyauYLrEOOZ6jJ5S7xvJfF+wDDSK+s+ViHc3mOM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FRVTYOGV/aaJT5BzkEd6mu5PqmgjeBMfinYN8v+NFgN72L7Y+Lmau4ZMXuyVLVAG0/f6GgnWYTVEXHh5vuieMZCUaKncHZ7Xa3QB0S8xxJ5wI4kclg06+8ooGo9jdyxaqcQY/F6tlRD+NiEBme9k7islY6NKr+fa+xbPOfipwSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfION/cM; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160913; x=1738696913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n/xWpyauYLrEOOZ6jJ5S7xvJfF+wDDSK+s+ViHc3mOM=;
  b=VfION/cM22a63F3G7gjm5EsrgdtlvgVBSV/+kIKYhybKIWXVRQS323yU
   vUfYBljitmHAwrJdHJmsd+Y66KmMHG/V5R2TI798N3c9hIrrnp4T7eg7z
   6QGacW6qKTf8OYab8G09m6GBbHrhrSJ1wWwVU0ZxBq3pEcrWxAE5rlj4k
   dZY2JMMLHtsuIBLxlF2B5yCMWzmAW67F8RgwCKi2krk/ux0ZzzdtASEUm
   7rjZtauctUH9thOeiDpz0ZfvcyL53NIWYXT94g8nkJN7iGTzFewkNY0lY
   ehXwZeKNmgwBWREijpAH2Fc/ssUg5Oh0U+c5emkD0OGvvkxQ6ujqHicou
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381624"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381624"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403132"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:52 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Daniel Amosi <amosi.daniel@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: Keep connection in case of missed beacons during RX
Date: Mon,  5 Feb 2024 21:21:07 +0200
Message-Id: <20240205211151.080195242c18.Ib166fc4e46666165a88e673a4a196cb8f18fdec4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Daniel Amosi <amosi.daniel@intel.com>

The client needs to disconnect from AP in case of more than 19 missed
beacons only if no data is coming from that AP, otherwise it needs to
stay connected.

Signed-off-by: Daniel Amosi <amosi.daniel@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 14 +++++++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      |  3 ++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index bcf78ccba8c1..80faf18fda0c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -1626,8 +1626,16 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	 * TODO: the threshold should be adjusted based on latency conditions,
 	 * and/or in case of a CS flow on one of the other AP vifs.
 	 */
-	if (rx_missed_bcon > IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG) {
-		iwl_mvm_connection_loss(mvm, vif, "missed beacons");
+	if (rx_missed_bcon >= IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG) {
+		if (rx_missed_bcon_since_rx >= IWL_MVM_MISSED_BEACONS_SINCE_RX_THOLD) {
+			iwl_mvm_connection_loss(mvm, vif, "missed beacons");
+		} else {
+			IWL_WARN(mvm,
+				 "missed beacons exceeds threshold, but receiving data. Stay connected, Expect bugs.\n");
+			IWL_WARN(mvm,
+				 "missed_beacons:%d, missed_beacons_since_rx:%d\n",
+				 rx_missed_bcon, rx_missed_bcon_since_rx);
+		}
 	} else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
 			ieee80211_beacon_loss(vif);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 167e4acd093a..76f50b3bf893 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -40,8 +40,9 @@
 #define IWL_MVM_MAX_ADDRESSES		5
 /* RSSI offset for WkP */
 #define IWL_RSSI_OFFSET 50
+#define IWL_MVM_MISSED_BEACONS_SINCE_RX_THOLD 4
 #define IWL_MVM_MISSED_BEACONS_THRESHOLD 8
-#define IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG 16
+#define IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG 19
 
 /* A TimeUnit is 1024 microsecond */
 #define MSEC_TO_TU(_msec)	(_msec*1000/1024)
-- 
2.34.1


