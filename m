Return-Path: <linux-wireless+bounces-21893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCBAA97F0B
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62CE518978FB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 06:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6DB266F13;
	Wed, 23 Apr 2025 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNn3FQaP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DA266F0A
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 06:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745389034; cv=none; b=U9ijujIssg9/xtzbAj+TUAL/LLkVXCSBx+wyUamj9SLrAGVJR+lrexBrWNpThV0jXhtAhTKjXRcVLiMXQSNxRoooMa+lrU84/YJfArIyItYkpPHVNrNJSZMIHV/Rj61FbQhmJ4n53BmnQVJhsFQn6lNk6w+JWyDleAPxjtJVA4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745389034; c=relaxed/simple;
	bh=TDgUanoiDYEsLusK4sJsMvwRnzTz2Q1fOhniUcB4p7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afATE5jjfKsdu45YsqXM5zoXAiZ/BWCfKOkQZb+ELeBoTLJW/W8jos7fAMrO1u9K0ma9TOrL3n9NmMUpjbwp0fwSLA00d5d1yd/tb3qXZn6ZSnbSKMVMoRJpvsTxureGtZ7pHng0Q8X3NjvwA9kH1aP/gNhXBBjBd9A+XGIWjNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNn3FQaP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745389031; x=1776925031;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TDgUanoiDYEsLusK4sJsMvwRnzTz2Q1fOhniUcB4p7I=;
  b=UNn3FQaPAD2Zid2B1FbmakLW15TmGArnUJzGkimXB2U4bHJZYOfvZbpm
   0dbgX0fmWnIfR5zEzuCQeK40LZ3qxEGAGFqLzHXlXa4MSI+tSVtw+RKez
   QEfWAhcR/P0lnG6XoupDOxFxNyyauG7jtm6rRbWjD+uZ6NMuIqaEifBWo
   qNzRXt9P/aBfP1zBsAHxNoIuXGta3Hf8f/5ME7Wd8Ard1Y68aquhkCcA7
   Q/BT5me0imZuEtESzUU0LopzO97XCEMVELMATO8LxRc7sLRzsDAEDUoIg
   ZDJeTr07HNaWBy3Cph5giDi9GWRblfiSgBWw7MmlHoEiNOrS6JnDn615C
   g==;
X-CSE-ConnectionGUID: iitpIaKCQFmunQX8MUBlkQ==
X-CSE-MsgGUID: M9DGivDgRVOlVJSl5tZLAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="46843651"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="46843651"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:11 -0700
X-CSE-ConnectionGUID: PbFFVQAeTO+gMRwUx0TsKQ==
X-CSE-MsgGUID: OaMNUzXSTYWwV/4qjd6O6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="163269085"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 23:17:10 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 12/15] wifi: iwlwifi: mld: inform trans on init failure
Date: Wed, 23 Apr 2025 09:16:38 +0300
Message-Id: <20250423091408.c7e178748ef7.Ifaf15bdd8ef8c59e04effbd2e7aa0034b30eeacb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
References: <20250423061641.2302908-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If starting the op mode failed, the opmode memory is being freed,
so trans->op_mode needs to be NULLified. Otherwise, trans will access
already freed memory.
Call iwl_trans_op_mode_leave in that case.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mld.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mld.c b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
index 562d320b2c3a..87624730fb50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mld.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mld.c
@@ -425,7 +425,7 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	if (ret) {
 		wiphy_unlock(mld->wiphy);
 		rtnl_unlock();
-		goto free_hw;
+		goto err;
 	}
 
 	/* We are about to stop the FW. Notifications may require an
@@ -471,7 +471,8 @@ iwl_op_mode_mld_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_mld_leds_exit(mld);
 free_nvm:
 	kfree(mld->nvm_data);
-free_hw:
+err:
+	iwl_trans_op_mode_leave(mld->trans);
 	ieee80211_free_hw(mld->hw);
 	return ERR_PTR(ret);
 }
-- 
2.34.1


