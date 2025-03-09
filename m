Return-Path: <linux-wireless+bounces-20090-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE729A580B2
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FEB7A725D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA217A2E7;
	Sun,  9 Mar 2025 05:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCRlZOSC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F0614AD0D
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498649; cv=none; b=s9CXzE+HRHDqpOm11xdRhVZb2QnxMUvRJI89M7y3tIj2ukByrkVfPR6BkVcEYixuRSyOGITEjCp1kmrbNU5On5WlxE3MwrlAVpILpYMVXRvIbD6YwHIiRSLU6QfbMsIxHyrkNspLzZ+mQhu3XPjYgm1QA+RaURPN3sQ6SOi+dVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498649; c=relaxed/simple;
	bh=fMFUirmSSi+PZ9aORxxtumMiw1oYzuSI+08YtsP8rNE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/iftxb41DisYRMx87QDQpFVzLjFmi4AEBLU3/+DGJRJo2lUTwlRXCJVARI7GnS53smVFMwQKtUvXbQB9uKb/PhBj538obRQvUOcqMT8JKpqLimpeeXee8SaEz9xMP4T/5DKE5MpEM8Atw9Q06cywhi7AfbyVOnX/knxaSxA+DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCRlZOSC; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498648; x=1773034648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fMFUirmSSi+PZ9aORxxtumMiw1oYzuSI+08YtsP8rNE=;
  b=XCRlZOSCPsLd+6yhUrpAS6m5Cz9mMCdlWvoTPT5nTMO7yGGSfTlGG2hY
   iyTSHffn+C7K5cKMfO7yZgRmrXAGV8PlLevumI+7uUxaEidap4RJQ60sT
   EZJz3Rs3uoNESNB+/eseTppN4yAmWb2KfIXwNqnNkxgg4KXx2C6ZKKWpe
   GTebYnRnA0FunAUNEGJyrRI0nuMHRPFhRgsJyfz103upWUCLLIwO5iK6i
   lYrtIKzRv/hdJMka8aXZtLhgGHItcHrOqva/yF2gNctI610w1HVtF3FeR
   LuvWu48F+3BQ5hF4XFaQeDs9M/grmXpX1dV68zOuLNdpG274RBjDB8rG2
   w==;
X-CSE-ConnectionGUID: KKvFzd4TQW2G9xBj0uJc2Q==
X-CSE-MsgGUID: qeMg4jEWR/KihC8AWiAJhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671713"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671713"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:28 -0800
X-CSE-ConnectionGUID: 8UnVgZJOTQWRqf2K64TkGQ==
X-CSE-MsgGUID: kb07M3eCQvWhjSmoLKeGMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470663"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 wireless-next 14/15] wifi: iwlwifi: mld: fix bad RSSI handling
Date: Sun,  9 Mar 2025 07:36:52 +0200
Message-Id: <20250309073442.a31b95888244.If6dca30d657658fa902b19e07b6fbc86c48d69cb@changeid>
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

If the RSSI is dropping to below the threshold, we need to do a MLO
scan to try select a better link.
This is true also if the connection doesn't have EMLSR capability,
and also if we are in EMLSR.
Fix the logic to always check the RSSI (and do a MLO scan if needed).

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/stats.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/stats.c b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
index a9d3860d8f9c..75cb204c2419 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/stats.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/stats.c
@@ -378,15 +378,11 @@ static void iwl_mld_update_link_sig(struct ieee80211_vif *vif, int sig,
 
 	/* TODO: task=statistics handle CQM notifications */
 
-	if (!iwl_mld_vif_has_emlsr_cap(vif))
-		return;
+	if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
+		iwl_mld_int_mlo_scan(mld, vif);
 
-	/* Handle inactive EMLSR, check whether to switch links */
-	if (!iwl_mld_emlsr_active(vif)) {
-		if (sig < IWL_MLD_LOW_RSSI_MLO_SCAN_THRESH)
-			iwl_mld_int_mlo_scan(mld, vif);
+	if (!iwl_mld_emlsr_active(vif))
 		return;
-	}
 
 	/* We are in EMLSR, check if we need to exit */
 	exit_emlsr_thresh =
-- 
2.34.1


