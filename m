Return-Path: <linux-wireless+bounces-3173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE284A6DB
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DB11F2741D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F159B4B;
	Mon,  5 Feb 2024 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I12PnzK5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73B59B46
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160923; cv=none; b=ULUX2xSEGqUPv61Q7ieLXgEjcsbXF6HVMq1jmXlz3wHyro7pFrq2NfmZeu3TRshTwk32t5LA3YIFb/THLIBwRepDKcktLMYobxldlpDv4aCgP9O5Vd71zJPCelo4MmDZVlK1kqRsoCNodz+xcSfba/sHeZvqqyVkyiLeGdjheZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160923; c=relaxed/simple;
	bh=KXkFh5vDqJJgpqxz2vzZvI9DIVMHl9uk3KQJz5kiRPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0rWqLrQ3acBrhRNbeZvU4YSXd6D/4ZEJug8sHb9JOkG2eT098/ehOySp3gBDXMJSFE15NF5OjiiJMlf1V46Encx2cI6iTfVLI3F5ozMeShWwEN8euAsYrjn6Hfg3ExRrsZxu11+kkCInmZuHelTdAGzNjCtQ8a7edI+14q/IHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I12PnzK5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160922; x=1738696922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXkFh5vDqJJgpqxz2vzZvI9DIVMHl9uk3KQJz5kiRPU=;
  b=I12PnzK5Q7WCGKRHyiVrCY96G1N24mA5t7G1PQ13lHBlIU5x3IiBgtx5
   mMASbPejgc6Gy+Y2dSGi0rmLS6ZvpOYHmrA6vOUY8Z/v8DFznNHsgyqpe
   ruzf2q9Sw76fx6A3F+gIJnJxkcYiyHRhUDDdIravXzP+VMRawkQdReYYW
   APAe4oEwG+JFbT8yd2ZV/IaKj+3hc9PwxsnmAnQfTcnovKzHx5/ts8O8p
   XCg+c6ApxiKyQZujTirDBQRqNjmLff6He8MfGLqPLn2t2SASRYs/j9RGg
   uzCUAiAQiJpN/m1xn2RUSupvuzmZLfaNC7ZU9Av9gs35F63MUgbCAXeFe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381644"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381644"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403175"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:22:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] wifi: iwlwifi: mvm: combine condition/warning
Date: Mon,  5 Feb 2024 21:21:10 +0200
Message-Id: <20240205211151.44f63334760e.If0a2cf347a8676a3830c5c3183a257fe11f31419@changeid>
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

From: Johannes Berg <johannes.berg@intel.com>

WARN() returns the value of the condition, so it's
nicer to combine the warning and the if.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 7979b7952a79..7c0da3b8ad77 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -649,10 +649,8 @@ static void iwl_mvm_release_frames_from_notif(struct iwl_mvm *mvm,
 	rcu_read_lock();
 
 	ba_data = rcu_dereference(mvm->baid_map[baid]);
-	if (!ba_data) {
-		WARN(true, "BAID %d not found in map\n", baid);
+	if (WARN(!ba_data, "BAID %d not found in map\n", baid))
 		goto out;
-	}
 
 	/* pick any STA ID to find the pointer */
 	sta_id = ffs(ba_data->sta_mask) - 1;
-- 
2.34.1


