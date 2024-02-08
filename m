Return-Path: <linux-wireless+bounces-3353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246784E5C3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D98D28BBB3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1C773164;
	Thu,  8 Feb 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHmPuyVd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC7823CD
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411554; cv=none; b=O3ZVh9y1av/cbQhkDNMKXPMRgFhLkj711WIKK0//SCE41jMgvmtyxvmp2VYoWAI3Hr44DYYLRg2YH371e3FU6+yY2CxC+HEW61FDM/0vvFF7hfXfb2MbY0bwbpN0JaNUeFHlsWG0lfSV8gjFO9hieGbpeD0ztIWsgar96hRs9b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411554; c=relaxed/simple;
	bh=bS2ZdlLPI2/2HR/TDuWsjapJ4ulXGvKJ1Qrhe4M53KM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8xvl31QUGQlkkCGp+gdmgyYfG4FXIp/0gZW4ndjM972Gz7D+ZU/g9HOJeFXj7RX7q5rB1R5wOT/qAaJtnpohHt+lm0FvOJh0JXbasTkNlScy1a4NEMoYn93+uJjwwsQ6pL1hIKV8Po8RmQ89YRuhhj00ph62ySM3Giva9+D/78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHmPuyVd; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707411553; x=1738947553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bS2ZdlLPI2/2HR/TDuWsjapJ4ulXGvKJ1Qrhe4M53KM=;
  b=WHmPuyVdtcLM39c+kLlT8Y9YGNOjgvF+I9bpDBYzra0P9e6jEHAwUiCL
   bX49VJhAkV9UMY+E/1k9/OI/0mHbwYB4PhtP5S3P5O/NshYnG06o79GUQ
   3PUhL027n862XmbMJbNIKmBf/NxD/KVmOGRym2YjSSM3gtQajZN2f/UHn
   PJQE0IMF6KgzZ+8q2tRrqAf2fY9jEke/E2+cwJn2g3UduEw07yglaFvHG
   aFt02BwRqNFwmhZlDXFRtQLX9nZbSkZZBJspr61uMujpfsYNTlV6X3mQs
   evEu7Dxc0y3eJbnYogQzguwYzqlQw1APmV9+Bki3V9ot3W0Kn7fxhMnln
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1404001"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1404001"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="6318853"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 08:59:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 07/13] wifi: iwlwifi: mvm: fix thermal kernel-doc
Date: Thu,  8 Feb 2024 18:58:41 +0200
Message-Id: <20240208185302.5eb9f05fbfe2.Id0a4df70f21e7e6d079a7a2084b748ab499b828c@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

This was misnamed, fix it. Also add a space to make it
look cleaner.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2dd45f39b77f..ce78c21883e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -540,8 +540,8 @@ struct iwl_mvm_tt_mgmt {
 
 #ifdef CONFIG_THERMAL
 /**
- *struct iwl_mvm_thermal_device - thermal zone related data
- * @temp_trips: temperature thresholds for report
+ * struct iwl_mvm_thermal_device - thermal zone related data
+ * @trips: temperature thresholds for report
  * @fw_trips_index: keep indexes to original array - temp_trips
  * @tzone: thermal zone device data
 */
-- 
2.34.1


