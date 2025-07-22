Return-Path: <linux-wireless+bounces-25822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE49B0D4A2
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 10:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70DF7165CC9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 08:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835A32D63FA;
	Tue, 22 Jul 2025 08:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iSyVOCnf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FC2D5437
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 08:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172983; cv=none; b=gmCUV7xJVhkydUI4goHWXS1KWtzky1dZx8TunXkKLOTqF196entinkQRrnvtbTmLGuV8LoBNILrfuj8V24j2cK0Itpxj8PIJVA727gjPhO6dp4nT0mM2n2bc07es6/SgznXnKM+Us3njyBX4Nukr518zXl8eW5fK+6Smuhbf9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172983; c=relaxed/simple;
	bh=IqZZyVIeeBrID/lM2VEj8m1k6jBqjIFO2Sg27PKc/ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBBN7dRE7DnGaaT/l5Ef+sJKZvA33wuGtq7cqofJmy2qxydwH4tHBH2k+zBAhv8SndOW1eOGJDd2xb2Y6uf/lnWEVI5V0AI95+ibPxqBTGDBJVXkAaFYeWA1KaxcVUbG9FvdFgkH9geCnMVQaychRlfeIBj43pc0/4vp31vUm6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iSyVOCnf; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753172982; x=1784708982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IqZZyVIeeBrID/lM2VEj8m1k6jBqjIFO2Sg27PKc/ig=;
  b=iSyVOCnf4VnoSuVK0REjQsncsXYAokQpB9nRrz5je5hZ8rUba21qSMhg
   QKwzLqAq7wNrs9ljNTHXsMN67Qz/v6XgeZrUXEU9QYJuxME/OHqE6CA0q
   TCm8iwuOzNxxvca7Ia+tRFkf41P08nWgjEhZpPJhSqmooPuoqAQqUU7eE
   Sg4vWU6T16eeCgJww7LZH5NdggLvRfzhN3afEcJ4RypdmWKlUqOCMDXF7
   OCI3T5qdV+Ujo9J2l61awuMKu+7cRdipWm1Db5QcWcasbpeAWFqSLLKwm
   2KL8V2+A+bCiNEq2EVY+OJQJRUuycjGGchkDNe7+QLyObrYbi8zP/75p4
   A==;
X-CSE-ConnectionGUID: 9R4up0hjQdG3NGP1KWu2LA==
X-CSE-MsgGUID: FnGbWdLIQ6S5LikuAdPryA==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55569876"
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="55569876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:41 -0700
X-CSE-ConnectionGUID: pJD3lqu3QqilRBpUf3aH0A==
X-CSE-MsgGUID: XP8DaBW8SvGarJ2pRM7FvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,331,1744095600"; 
   d="scan'208";a="163124269"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2025 01:29:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn
Date: Tue, 22 Jul 2025 11:29:02 +0300
Message-Id: <20250722112718.b2c877d5cbf7.I7b57a481122074b1f40d39cd31db2e5262668eb2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
References: <20250722082910.1206370-1-miriam.rachel.korenblit@intel.com>
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


