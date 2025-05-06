Return-Path: <linux-wireless+bounces-22685-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E5AACE39
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA624E68E0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367CA217703;
	Tue,  6 May 2025 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C9OIf/OZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913B3217F30
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560492; cv=none; b=se/XuSk7fsxKzHzm+tKTVFkdz/W9k4k4tyX0Wmf6Ta12D3XBHz72sw0tkqc5HJ2kLPWd0+sYxhE5yGtD5Z1rnvvRX2GpgfAFScLTrUQJW7KZN/UtSSKqr9cwSXhhCZZe+V5xX65GYQ71kdNQYBpHTnlxw8kMVn8NR7ZFSw9wzyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560492; c=relaxed/simple;
	bh=8VqpbzHxBbf5fnHevkrSjtGbPMBr5de4AansZ3ylWUk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qsN+oL+quUnDDpMPdagnTXRKToxk6DWVKC+c9o/NIL6G/h3LnN4goL0tKLMS1CnEuvJVvmGBGrtB85gW7qI/R3JT3jLHtZFG2XygPy/p0IuM2Un7SWnCjtyzCM1KrTsINNsEn905DSOu/rtGGjqFlxUMHmDVMbTsi7MTcrGBnzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C9OIf/OZ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560491; x=1778096491;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VqpbzHxBbf5fnHevkrSjtGbPMBr5de4AansZ3ylWUk=;
  b=C9OIf/OZTTNAqgB+AnGSon+VFZWdf+OwdcqWwI+1oYywmJwhcDjva56j
   iOPihZO6no+lB6x80oXNz8RUOFV6tTg896dzabLJ3grd7mb/Q7fiM+UtT
   2g5QF1v5Zp93kH8v2ngWZhHopi9B3wq7UxJyZNkoo3TAmwOablGil2PFe
   zjB99SwaVXVSpOFj6MlicFWcZygxlb1KSb0wNBeuGQCBrqEUslhD8Xcjx
   gYjZlcV1zqy9pN6vQA8sYzofBOxWbj+ErF69Av63Hnlyd69irsjG8eYtX
   wlg14WqsUYqHFDwbN6FRMP6QwGrz+XOXVADl5oxvYHlTAZxzPqFMMsXRu
   w==;
X-CSE-ConnectionGUID: XO0oaF0CTL2+IdzGPtcCkQ==
X-CSE-MsgGUID: AdDvDZM9Rue+2ar9uFLu4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961658"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961658"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:31 -0700
X-CSE-ConnectionGUID: fHRJvXTrTd6cpNp1QNQ9xQ==
X-CSE-MsgGUID: 5qTLV/K6TWy0yToS2ndYCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465485"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 10/15] wifi: iwlwifi: mld: avoid init-after-queue
Date: Tue,  6 May 2025 22:40:57 +0300
Message-Id: <20250506194102.3407967-11-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
References: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

rx_omi::finished_work is initialized when the containing link is.
If the worker was queued and then an error happened, we will get to
iwl_mld_init_link from the reconfig and initialize the work after it was
queued.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20250506223834.c048817b3919.Ie12a2968563ea088b4884f139acea59060a51871@changeid>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index fa822b748791..cecefa26445f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -785,8 +785,9 @@ iwl_mld_init_link(struct iwl_mld *mld, struct ieee80211_bss_conf *link,
 	iwl_mld_init_internal_sta(&mld_link->aux_sta);
 	iwl_mld_init_internal_sta(&mld_link->mon_sta);
 
-	wiphy_delayed_work_init(&mld_link->rx_omi.finished_work,
-				iwl_mld_omi_bw_finished_work);
+	if (!mld->fw_status.in_hw_restart)
+		wiphy_delayed_work_init(&mld_link->rx_omi.finished_work,
+					iwl_mld_omi_bw_finished_work);
 
 	return iwl_mld_allocate_link_fw_id(mld, &mld_link->fw_id, link);
 }
-- 
2.34.1


