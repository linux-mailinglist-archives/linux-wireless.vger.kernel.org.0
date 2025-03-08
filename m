Return-Path: <linux-wireless+bounces-20075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238B7A57F3C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79CAC188E70A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19467212D67;
	Sat,  8 Mar 2025 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrUsgNvf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0002135CA
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471321; cv=none; b=u9ltHiLQK44cqj1sn3+oz5KYBvjwHOLuNHuNHxBvvxCELsfsMg5Vf7LEt5DwVNurxjr0vRqfd4zeuwinPleooYNggMRHxUFYnvwB6Ck0GrHdtnrtbxtUc34kffBO0q+H38gI6bwtrompSNagLvdMiL8NSrU9/zJbT6RAY25C2UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471321; c=relaxed/simple;
	bh=mRZzWT9+bZT6a/9YzQAMVvuT8oxnnIH0ZTC0OzcbbiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KJdfA9omyI0NN3zMyyziliCx2+ETwEQ7Ds24V7Ro2mG4w+CKD9ZZe9yN9kUgM4xKugKL4/EsPqokTvE325bqUIy7+kg3xw8XnODKgXKZwnQNqXwFfULhNu34rhCuGdYBEmQ23gA4GukWtHGHC0ZI+v120JPWXIXDYAHm78Au6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrUsgNvf; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471319; x=1773007319;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mRZzWT9+bZT6a/9YzQAMVvuT8oxnnIH0ZTC0OzcbbiA=;
  b=HrUsgNvf2BTIkk+BhD+WxOGkt63aIi8REQ5d1iKekG7s0iTG7G4OuAJ4
   5zFuyNJwvaHohushldgkyqk4EkSGdzlp/N7Tt6/mSACofr9mgxQht+S4r
   B9quQ6cy42WUB31sfH4VahttKugTzq1ke0OYaomWDq8D+Byb4lDD/i6Fk
   KVlWsdDYdnM+wZnY5P+l95mAyjYry/Zb4wB5Oqhr50jdbsqfJ5C0GwyH9
   RncHwLPJwi2INkm0X9Pl/+DuU2113mknIvOTPVSLSy4SooQxx+hgzkScT
   rfTQQJrHFXUpoDtRPCY/HIb07YlEudyCeTPEhmqLURDheSu2FG2KgIoWa
   A==;
X-CSE-ConnectionGUID: d0DZZdpnTHCWijqJG3rtRg==
X-CSE-MsgGUID: VXvC6eYNSkmw1hMBKVBQSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540686"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540686"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:59 -0800
X-CSE-ConnectionGUID: r0FFI4SsTvCIzpyQnRzC5Q==
X-CSE-MsgGUID: dTlacGi6Rs6k/iRqQapwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352188"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH wireless-next 15/15] wifi: iwlwifi: mld: avoid selecting bad links
Date: Sun,  9 Mar 2025 00:01:25 +0200
Message-Id: <20250308235203.6d98e287f10e.I51306021fe9231a8184e89c23707be47d3c05241@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Currently, we don't select a link that wasn't heared in the last 5
seconds.
But if the link started to suffer from missed beacons more recent than
that, we might select this link even we really shouldn't,
leading to a disconnection instead of a link switch.

Fix this by checking if a link was heared in the last MLO scan,
if not - don't include it in the link selection.
Since we do an MLO scan on missed beacons, we will not hear that link in
that scan, and won't select it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 10 +++++-----
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |  4 +++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  5 +++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 99ba4018fb24..879fa7b77780 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -704,10 +704,9 @@ iwl_mld_set_link_sel_data(struct iwl_mld *mld,
 		if (WARN_ON_ONCE(!link_conf))
 			continue;
 
-		/* Ignore any BSS that was not seen in the last 5 seconds */
+		/* Ignore any BSS that was not seen in the last MLO scan */
 		if (ktime_before(link_conf->bss->ts_boottime,
-				 ktime_sub_ns(ktime_get_boottime_ns(),
-					      (u64)5 * NSEC_PER_SEC)))
+				 mld->scan.last_mlo_scan_time))
 			continue;
 
 		data[n_data].link_id = link_id;
@@ -819,8 +818,9 @@ static void _iwl_mld_select_links(struct iwl_mld *mld,
 	if (!mld_vif->authorized || hweight16(usable_links) <= 1)
 		return;
 
-	if (WARN(time_before(mld->scan.last_mlo_scan_jiffies,
-			     jiffies - IWL_MLD_SCAN_EXPIRE_TIME),
+	if (WARN(ktime_before(mld->scan.last_mlo_scan_time,
+			      ktime_sub_ns(ktime_get_boottime_ns(),
+					   5 * NSEC_PER_SEC)),
 		"Last MLO scan was too long ago, can't select links\n"))
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.c b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
index 5f4ede92028b..7ec04318ec2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.c
@@ -1794,6 +1794,9 @@ static void iwl_mld_int_mlo_scan_start(struct iwl_mld *mld,
 	ret = _iwl_mld_single_scan_start(mld, vif, req, &ies,
 					 IWL_MLD_SCAN_INT_MLO);
 
+	if (!ret)
+		mld->scan.last_mlo_scan_time = ktime_get_boottime_ns();
+
 	IWL_DEBUG_SCAN(mld, "Internal MLO scan: ret=%d\n", ret);
 }
 
@@ -1922,7 +1925,6 @@ void iwl_mld_handle_scan_complete_notif(struct iwl_mld *mld,
 		mld->scan.pass_all_sched_res = SCHED_SCAN_PASS_ALL_STATE_DISABLED;
 	} else if (mld->scan.uid_status[uid] == IWL_MLD_SCAN_INT_MLO) {
 		IWL_DEBUG_SCAN(mld, "Internal MLO scan completed\n");
-		mld->scan.last_mlo_scan_jiffies = jiffies;
 
 		/*
 		 * We limit link selection to internal MLO scans as otherwise
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/scan.h b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
index cb589e002319..3ae940d55065 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/scan.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/scan.h
@@ -108,7 +108,8 @@ enum iwl_mld_traffic_load {
  *	in jiffies.
  * @last_start_time_jiffies: stores the last start time in jiffies
  *	(interface up/reset/resume).
- * @last_mlo_scan_jiffies: end time of the last MLO scan in jiffies.
+ * @last_mlo_scan_time: start time of the last MLO scan in nanoseconds since
+ *	boot.
  */
 struct iwl_mld_scan {
 	/* Add here fields that need clean up on restart */
@@ -129,7 +130,7 @@ struct iwl_mld_scan {
 	void *cmd;
 	unsigned long last_6ghz_passive_jiffies;
 	unsigned long last_start_time_jiffies;
-	unsigned long last_mlo_scan_jiffies;
+	unsigned long last_mlo_scan_time;
 };
 
 #endif /* __iwl_mld_scan_h__ */
-- 
2.34.1


