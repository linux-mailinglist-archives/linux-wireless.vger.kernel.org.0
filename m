Return-Path: <linux-wireless+bounces-9538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBED916E77
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80C7B1C21C80
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 16:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13D617837A;
	Tue, 25 Jun 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb/9rsYf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F8C175558
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334299; cv=none; b=fVS0UmJvQCWi6ZkLvEPR7mvOXbnhb795wttOXHdUmhCl74OdFBuhfZPmOretNKiHROg2fpPWCfNnOQKO8C+kID82pQDGh1Rvm8BVWGOyk0Cpzo3KbvmOMGeszyCl2mplFyunJSgakRboY1++6BBJ4U0ZScKH9MIqw6YZOdkN5F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334299; c=relaxed/simple;
	bh=WswbNt9Ol9QDmyiMEvP26aLl07+NEkSLDJboFk2hYw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h4AJjnogUUduIShPxxaDplj15fAzyODNAMFMt5xuGqVKUSKvkxvUsF47KthoA/VO5d/zqeGg1RwMj0URFLZxgEH9oMZdFso59bGmNkQMrybPbUbolecXPSvDuT3GC9WCCLbOOOuDjhUNMjlcm+GqzdfgiKG6AxoBJllff7nt1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb/9rsYf; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719334298; x=1750870298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WswbNt9Ol9QDmyiMEvP26aLl07+NEkSLDJboFk2hYw4=;
  b=hb/9rsYf8CXaJcdWLumOpAhO7IZ4SNJMWuhLYAhOIX6h/HJtZvOUTOMH
   NYHMGAYPPA1n/F1Qmti5HJRthAK3B3sS0q9aaMbz7bWbdS6LVaSA8gS8M
   qrz9Wu4THVXwD3RkZ2xQW1O8ShKX3V3IiHaCZaHHgEV3tKL/qMJnnMGtr
   bMo3aB96/tsMmZdyMKgVHMhixJTyLfCwrXRlKMDx3aObD5CH0NZy1Ha0y
   8VCwPCaVLla6ZBye8Aw+POyE3GPxAyu9Ixcy1AM/Bnm9EludJxhmoBJMQ
   lGn9RFpRXmyak9WbUq+KGbO0NzsnUXODHiuSQ6G8E+gZ107EO8fEsk74i
   A==;
X-CSE-ConnectionGUID: PIOn58W4Q3+Rm0naxbzxuQ==
X-CSE-MsgGUID: A55A/vNURMuGNHIeYr9/jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16594704"
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="16594704"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:38 -0700
X-CSE-ConnectionGUID: wnPCqDQSTj6hoyepO4l2+A==
X-CSE-MsgGUID: 92E+PZlwTW2QQ2D3g59ezg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="48632509"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 09:51:36 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/17] wifi: iwlwifi: mvm: always unblock EMLSR on ROC end
Date: Tue, 25 Jun 2024 19:51:10 +0300
Message-Id: <20240625194805.96bbf98b716d.Id5a36954f8ebaa95142fd3d3a7a52bab5363b0bd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
References: <20240625165123.1624974-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since we always block EMLSR for ROC, we also need to always
unblock it, even if we don't have a P2P device interface.
Fix this.

Fixes: a1efeb823084 ("wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif is active")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index d73e19a8fdda..98490866a7f5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -127,7 +127,7 @@ static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 			iwl_mvm_rm_aux_sta(mvm);
 	}
 
-	if (vif && !IS_ERR_OR_NULL(bss_vif))
+	if (!IS_ERR_OR_NULL(bss_vif))
 		iwl_mvm_unblock_esr(mvm, bss_vif, IWL_MVM_ESR_BLOCKED_ROC);
 	mutex_unlock(&mvm->mutex);
 }
-- 
2.34.1


