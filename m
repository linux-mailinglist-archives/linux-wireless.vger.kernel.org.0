Return-Path: <linux-wireless+bounces-20091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98825A580B3
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A2C07A69E7
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C8E15533F;
	Sun,  9 Mar 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrPUWKbz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25F17ADE8
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498651; cv=none; b=sh5wJeKPdg4e8hcK5sCDC4AKWiG0I3FcCsqsbPfc8431xTC6rHBKdNEQ63tKWXdb0fwZxj53FM8oVSYWsjHU0V1URDtRR9cZckfYUAbhMqcV5JGiuATXFqnOQiKFgPkZykpqrkZM6iNiHRvefx9xeDOVFIJUNXjsRMYMCM5254c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498651; c=relaxed/simple;
	bh=nGmYcPmZix/b0QbXvdbxaIwGIhD/d/H9+XV2XM+7tA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SsHJwy8mPxEgLFZQRJ3l5WgbF46MCObS+ffs0wwWNNqHYPaOMA+9CPc08fVEebA/d1DfZROBN93ctVFws/AJf87Nr+eleH46HzYBlZOZKQ5DoSVn2sf5qwyfIlOETT0hinSSmGL7kl0X/MMbR5Ly11p75swk0anY/bXX5qs1yrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrPUWKbz; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498650; x=1773034650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nGmYcPmZix/b0QbXvdbxaIwGIhD/d/H9+XV2XM+7tA8=;
  b=OrPUWKbziYwkIbSrUcuR86U0LisGFrNZZ0iib6d9dvkMxOoaOhkqL22v
   WDURTBZJGchV6vUb75x9x5H3E9p90X9Hfwrqb5nKQLKzSgrzaMSBnk/nx
   hCiKfXf2IDfh+RMLVvhoAgxNGB8Kwih7vGZy6W3mVBXzdpcz1tq+2GgbM
   EQFBIfjnRnJCbvQr0oW2d/f0njPff3lTiGq5n7S8khPGjUQSbBm3L0z4H
   q0p5LJJvpPD+ZHtDpV/tB6XL+5rq8cOT+Ok3bsfLCoHqp7Zlxa5Thbbdr
   ZYI8bKB3eECKNDM7gtcPhNRWEGnN5kC3yTZvI30/7XnSWvhyj5towcoFR
   Q==;
X-CSE-ConnectionGUID: oAT7z2KmQHywoK0yGe5EBQ==
X-CSE-MsgGUID: 87KnyTs7SXiHZ+krZJhCnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671715"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671715"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:29 -0800
X-CSE-ConnectionGUID: yV4uKmPHQI2lz5ABfCtmTw==
X-CSE-MsgGUID: 54f3K45UTM6A75k98AEgpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470666"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-next 15/15] wifi: iwlwifi: mld: avoid selecting bad links
Date: Sun,  9 Mar 2025 07:36:53 +0200
Message-Id: <20250309073442.8f950497219e.I51306021fe9231a8184e89c23707be47d3c05241@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
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
---
v2: fix build

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 99ba4018fb24..54f29002cba1 100644
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
+					   (u64) 5 * NSEC_PER_SEC)),
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


