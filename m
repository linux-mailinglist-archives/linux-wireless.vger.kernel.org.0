Return-Path: <linux-wireless+bounces-25786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FCEB0D073
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 05:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07F173B31D6
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jul 2025 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DA01DED5D;
	Tue, 22 Jul 2025 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="az7ibTTM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7EEEDE
	for <linux-wireless@vger.kernel.org>; Tue, 22 Jul 2025 03:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753155719; cv=none; b=N0jsaR1W7saGx305nFdNydqBEWaYH3CO4m+l5TMNRoCROlTsLlwxsvi9pqtW/wFSfFztq8t2PXLCqlb+7QcIaqkL54UmYs/3xPbN+ISZnz48JvfsY5/3zoMCT7qy4bmEiEwWOFYaTlXeKtk2tSH53EPSHXqtUcVvNOWjcVQpdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753155719; c=relaxed/simple;
	bh=IqZZyVIeeBrID/lM2VEj8m1k6jBqjIFO2Sg27PKc/ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xb9PhLC/nbILEVOHiCaD7h6hvgFiDuVaZ6JTsG//qzQOJEZkWU2oV/QlLdV+UXjmtTKb/Y7Si3z6MP19kRTRXgu5lK+p0NSQ6j8CH5DKxlvF+pdDrGi3VtBsDgPu5h410eUxHlYk5DN752aC32mgBvcmAH8J4Q/vd34yXSxoFHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=az7ibTTM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753155717; x=1784691717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IqZZyVIeeBrID/lM2VEj8m1k6jBqjIFO2Sg27PKc/ig=;
  b=az7ibTTMC689GPsmaO57pNbd27k+WgOv3XP3XLnaxaNpUdtDSviRosv9
   DdAnVIC6saeFNIbG0NgMjCovrorDZEBG2LpVQIPdxEemmv5M2uEIFwhaA
   VPJwHiJomfhLejVjlKJ9BN8IOp13l3juV9+0tPBInFZ80Slx+zUL6rrGb
   lmpfUKuXtMyOzTFwRt+JTrVel2ShMFfHMWMlRmA49IeZSG/ikheznVtix
   7e9U4pyEWIkCBN5t92bzS4jzWchpXVb6buH86e33mlRmseIoIZwZ+rCro
   uRH17bP0cSR/qvsqWzUr0qBE7iTj+ghx8KZ+kX8wi5W1j+bRQ3/8I1Fed
   A==;
X-CSE-ConnectionGUID: sE0g77IpSei7w26SQoEL4Q==
X-CSE-MsgGUID: POX/cdeGS3iBiLQQQVQEug==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="43006159"
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="43006159"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:57 -0700
X-CSE-ConnectionGUID: XTDmegEDRf+vUM3wJuQD3w==
X-CSE-MsgGUID: tNlcWwrXRsKZZJ6KreyO5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,330,1744095600"; 
   d="scan'208";a="159338102"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 20:41:56 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH iwlwifi-next 07/15] wifi: iwlwifi: mld: avoid outdated reorder buffer head_sn
Date: Tue, 22 Jul 2025 06:41:17 +0300
Message-Id: <20250722063923.b2c877d5cbf7.I7b57a481122074b1f40d39cd31db2e5262668eb2@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
References: <20250722034125.1017387-1-miriam.rachel.korenblit@intel.com>
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


