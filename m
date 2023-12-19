Return-Path: <linux-wireless+bounces-1034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4C2819122
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 21:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E27251F255EE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54D3B198;
	Tue, 19 Dec 2023 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+sFep/D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DC3A269
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015984; x=1734551984;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cG2KThKpx7ORRAAFsSIojFKsUEmo0o1OaQhA4bjJMlw=;
  b=D+sFep/D5d776uzzJpwWbI/LlREsE/VSz089hsq01WztXfU2zE9Lufkq
   WJ7B5waoa1jzCSJ0R10DHymFw2NGcnOeqW70O+4bPdxhKuJ5T7JaUglav
   786LOIKZazFQyrff2DLUsMhZfMIYqa8w9/UXz3V4ZQWHSkYbUulnaQa7J
   DiOiiKy1v174fK2mdfAqh20P3+i/0d+xELdZ+Xt67vKHKfTfgDVsMi2js
   /T5dwnpntiBHpxx99fS2LZHMmXgzIK/PfHzwyfN1IwKQM+xiMGH0cmhnZ
   W6yJvR586ZtisYx0qXhDOXJjqvHO6+PgIfG/IlNLNuQnmxCO8VHf3f2Gt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694959"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694959"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589117"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589117"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:41 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: assign phy_ctxt before eSR activation
Date: Tue, 19 Dec 2023 21:58:56 +0200
Message-Id: <20231219215605.3d94507f5d9a.I537fcd73aedf94c7348c03157e486f24301fef14@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
References: <20231219195902.3336105-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

eSR is activated when a chanctx is assigned to more than one link.
During eSR activation we should disable RLC for both phys, and configure
the FW with a special phy command for both phys.
Currently we assign the phy_ctxt to the link only after eSR activation,
so RLC is not disabled for the new phy_ctxt, and a cmd is not sent to FW.
Fix this by first assigning the new phy_ctxt to the link and then
doing the eSR activation.

Fixes: 12bacfc2c065 ("wifi: iwlwifi: handle eSR transitions")
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 8e263acbc763..61170173f917 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -271,17 +271,17 @@ __iwl_mvm_mld_assign_vif_chanctx(struct iwl_mvm *mvm,
 		}
 	}
 
+	mvmvif->link[link_id]->phy_ctxt = phy_ctxt;
+
 	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
 		mvmvif->link[link_id]->listen_lmac = true;
 		ret = iwl_mvm_esr_mode_active(mvm, vif);
 		if (ret) {
 			IWL_ERR(mvm, "failed to activate ESR mode (%d)\n", ret);
-			return ret;
+			goto out;
 		}
 	}
 
-	mvmvif->link[link_id]->phy_ctxt = phy_ctxt;
-
 	if (switching_chanctx) {
 		/* reactivate if we turned this off during channel switch */
 		if (vif->type == NL80211_IFTYPE_AP)
-- 
2.34.1


