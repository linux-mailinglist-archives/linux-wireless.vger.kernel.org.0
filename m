Return-Path: <linux-wireless+bounces-20280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3299EA5E74C
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82C53B433B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF31F1307;
	Wed, 12 Mar 2025 22:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHB+vPxc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C601F1303
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818195; cv=none; b=SfR5qpR9i6isRcpXZB9z1UvHjvacoIutx5hAR/mKpG8v69aw9+W5hfF4T3OiarIxRzQf6T0MB2sAIZld/TKUDFNBzM73oKijtOzo4e2VFb113IEjT+jGj1jbSXPj/3rm+n+Ok+s6A4KQrJcr1mlBY60Tl9famOVRZSceLR+ElYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818195; c=relaxed/simple;
	bh=nUJrgbt9yEie7xuh9pvrPjNNC4swWBQVnPgjyyt/9/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1tr+m70KRMIiQDsXLUXqoUuVal16/H+XyZvwUCp8WnFb+SqBSTvHTNS8XrTYGLlDuvaXEBKQ+PLnFXnRdHqTXIKA1R4UvgsUOAlQBDKa+l2fjfViRGawdCEPAmDtbMWstsWr8PgwYUssLTqJGqq0sRM/UTp9vuZChmvxTKpRmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OHB+vPxc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818194; x=1773354194;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nUJrgbt9yEie7xuh9pvrPjNNC4swWBQVnPgjyyt/9/Y=;
  b=OHB+vPxcTbqPNUq+IevIFmxzfQpHIYiF9RT0PuR7dfe0oKt0FFI8nm3j
   MtRcZv7A3A95eGmORCw37FOpZasBkVtBfqdVkdR0DDqUHtWTs6e+1qpWf
   /gnW/AIdCEeVvZGqpz4sGZpD4QAM74BkuwQjsc13ALHWd7+wg3XbdivT9
   4yGf8b6hRkNXIdLQuI4P/Wi5RZtCWalnuTQLvGxo5nk73X5D0cKRKO4N4
   lGiTAqw1MXNx6afLOJh4BEXjR3dNNIEaFB6n41pE7ngrQBTCXky8YCc8Z
   d92w+Ft6afu1amFlFg3hVgHpnmz8oDWhYuhzLjEiOjRBFLwHnObrSsrsi
   g==;
X-CSE-ConnectionGUID: /dlaVGgKT1qEX8VPBgJNtw==
X-CSE-MsgGUID: grDSDU/dSFSypbCe8KWLJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826768"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:14 -0700
X-CSE-ConnectionGUID: p6SmO6RiRCCqo4ddSdnMsw==
X-CSE-MsgGUID: 1zIfUYOSTPCam+Dbx/HiLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267429"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:23:12 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: iwlwifi: mld: add debugfs to control MLO scan
Date: Thu, 13 Mar 2025 00:22:38 +0200
Message-Id: <20250313002008.1a1c2d285336.I5163ceb97ac797e3cf00badf79b9aa9355d7327d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
References: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Add a debugfs entry to start/stop an MLO scan. This is required for
testing.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index 14330daa6d13..453ce2ba39d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -14,6 +14,7 @@
 #include "notif.h"
 #include "ap.h"
 #include "iwl-utils.h"
+#include "scan.h"
 #ifdef CONFIG_THERMAL
 #include "thermal.h"
 #endif
@@ -901,6 +902,33 @@ iwl_dbgfs_vif_twt_operation_write(struct iwl_mld *mld, char *buf, size_t count,
 
 VIF_DEBUGFS_WRITE_FILE_OPS(twt_operation, 256);
 
+static ssize_t iwl_dbgfs_vif_int_mlo_scan_write(struct iwl_mld *mld, char *buf,
+						size_t count, void *data)
+{
+	struct ieee80211_vif *vif = data;
+	u32 action;
+	int ret;
+
+	if (!vif->cfg.assoc || !ieee80211_vif_is_mld(vif))
+		return -EINVAL;
+
+	if (kstrtou32(buf, 0, &action))
+		return -EINVAL;
+
+	if (action == 0) {
+		ret = iwl_mld_scan_stop(mld, IWL_MLD_SCAN_INT_MLO, false);
+	} else if (action == 1) {
+		iwl_mld_int_mlo_scan(mld, vif);
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
+
+	return ret ?: count;
+}
+
+VIF_DEBUGFS_WRITE_FILE_OPS(int_mlo_scan, 32);
+
 void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif)
 {
@@ -939,8 +967,8 @@ void iwl_mld_add_vif_debugfs(struct ieee80211_hw *hw,
 	VIF_DEBUGFS_ADD_FILE(low_latency, mld_vif_dbgfs, 0600);
 	VIF_DEBUGFS_ADD_FILE(twt_setup, mld_vif_dbgfs, 0200);
 	VIF_DEBUGFS_ADD_FILE(twt_operation, mld_vif_dbgfs, 0200);
+	VIF_DEBUGFS_ADD_FILE(int_mlo_scan, mld_vif_dbgfs, 0200);
 }
-
 #define LINK_DEBUGFS_WRITE_FILE_OPS(name, bufsz)			\
 	WIPHY_DEBUGFS_WRITE_FILE_OPS(link_##name, bufsz, bss_conf)
 
-- 
2.34.1


