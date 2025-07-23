Return-Path: <linux-wireless+bounces-25898-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE7B0EADD
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 08:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 718235656ED
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Jul 2025 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24D526FD95;
	Wed, 23 Jul 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cup1T9Ec"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2201271476
	for <linux-wireless@vger.kernel.org>; Wed, 23 Jul 2025 06:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253147; cv=none; b=rwyVE1k2knHduPmRcZSLQgd/kr3Hzu/YCPM4vuu0UrBMHt/0MhMsYMCMZmNt7JA+1Rz7/8nydZpAvUiLfam1e2Jef5OKEiyUs1FB49Ft9aJ8lgPNklAH0rpQGK0blTBSH6znWqOY78fqcm6lQVrD2WAfQS7UPpFpDBfySJVET/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253147; c=relaxed/simple;
	bh=IqZZyVIeeBrID/lM2VEj8m1k6jBqjIFO2Sg27PKc/ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mofV7x2hiVLtTqAvfIb2mSusKr+jCedPTTUz46Lep/4qLuNjQo7qZDayELvxeA95stadjIg4JJ/7M/w/IwbROKBG2WJJeYAEXFxhW2SXKQcF4zUg1r6PlwXi6aNzg+F6JgnVTDA+apfLwT1o6M3blEPZdlofVd1Wnj9CccXZM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cup1T9Ec; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753253146; x=1784789146;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IqZZyVIeeBrID/lM2VEj8m1k6jBqjIFO2Sg27PKc/ig=;
  b=Cup1T9Ecx+/0sZFFOiocBAzPJRM9Z13xVYb6TssdLywCkFJAdhvMvYh6
   uhnAbfmd5KXFTPXN0oCfh/FCFPRJ3zd4A7Pb/kQN2jaTReZSOq3gIaYMB
   JE3teSmo8ZNRcCBYBdR/e9rwzmnrKw8XOTztoCD+nRPGthvgTy65SO2Wn
   tyNoolvv3Bmac/4mNMQF0I31DWJMhoI8DvHhl1m8Q9AHx3rIADen4zP6P
   IVNU8qZbWp7RZT0zYrV35D5DkbwApocQJilcDuI6A76V9/zG6DmcSGOgU
   AM1ugM7mZGqsPeaWlmtHfae98ab6eqGYZKLftSvYp1GiItH5lS/OpHW7m
   Q==;
X-CSE-ConnectionGUID: WEl0cHa7Sje7V37G8ggrqA==
X-CSE-MsgGUID: 8ERbwMJ4RESVehG0aWR6xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11500"; a="59340747"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="59340747"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:44 -0700
X-CSE-ConnectionGUID: HlxusGTST1+NMIFy0mWaqA==
X-CSE-MsgGUID: e7O4Y7OdTB+rCcOY4POYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159918084"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 23:45:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 05/14] wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn
Date: Wed, 23 Jul 2025 09:45:06 +0300
Message-Id: <20250723094230.e1f62a9a603c.I7b57a481122074b1f40d39cd31db2e5262668eb2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
References: <20250723064515.2084903-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

If no frames are received on a queue for a while, the reorder buffer
head_sn may be an old one. When the next frame that is received on
that queue and buffered is a subframe of an AMSDU but not the last
subframe, it will not update the buffer's head_sn. When the frame
release notification arrives, it will not release the buffered frame
because it will look like the notification's NSSN is lower than the
buffer's head_sn (because of a wraparound).
Fix it by updating the head_sn when the first frame is buffered.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/agg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/agg.c b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
index 6b349270481d..3bf36f8f6874 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/agg.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/agg.c
@@ -305,10 +305,15 @@ iwl_mld_reorder(struct iwl_mld *mld, struct napi_struct *napi,
 	 * already ahead and it will be dropped.
 	 * If the last sub-frame is not on this queue - we will get frame
 	 * release notification with up to date NSSN.
+	 * If this is the first frame that is stored in the buffer, the head_sn
+	 * may be outdated. Update it based on the last NSSN to make sure it
+	 * will be released when the frame release notification arrives.
 	 */
 	if (!amsdu || last_subframe)
 		iwl_mld_reorder_release_frames(mld, sta, napi, baid_data,
 					       buffer, nssn);
+	else if (buffer->num_stored == 1)
+		buffer->head_sn = nssn;
 
 	return IWL_MLD_BUFFERED_SKB;
 }
-- 
2.34.1


