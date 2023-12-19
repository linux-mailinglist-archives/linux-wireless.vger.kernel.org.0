Return-Path: <linux-wireless+bounces-1032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85BF819120
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A531C2098A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E053A1BC;
	Tue, 19 Dec 2023 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RKoq0mbc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692239FD3
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703015982; x=1734551982;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=baMBgVm83ShQXDitTeGEVkbYVm7UC+cjXvo7N5jWa2U=;
  b=RKoq0mbcwlYRRwwTOHqxksmFlXlhn4ALbMY4dGmSk1dINxbb61zj5RHn
   C6muZGTh/hxoTADpNCD3TDLtP1lJvIH1wpOvVMZThESlMNV2P8G8C6KCD
   EGrgyJo7cZ/oOA0UR0s/oQHjm8tjYssyD2UkJ5+R9DR9j34hJX8FfuBvk
   lgB4mcwrt29S+9D17g78pqqBJRKgmkkJMQtCITF7CX7ABSEnCq3k69sR/
   95qaXg+692O5OBRz6p8f9sEG1CQs2fLfngBUJvNCaebfqu4g3aCwmMrDQ
   iHHxc8TBI/a1bikWe+B0xQmJ+diqOWVGv0joV2LqG2Gcy4/umSWMPUAlF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="380694949"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="380694949"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779589108"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779589108"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:59:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: mvm: Do not warn if valid link pair was not found
Date: Tue, 19 Dec 2023 21:58:54 +0200
Message-Id: <20231219215605.142e57a05230.I7cfe78c94c3d15c4c744bccadd8f187e43594932@changeid>
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

From: Ilan Peer <ilan.peer@intel.com>

It is possible that though multiple links are enabled we cannot enabled
EMLSR enable more than a single link, e.g., all valid links are on the
same band etc. Thus, do not warn in case no valid link pair is found.

Fixes: b9be67fb4207 ("wifi: iwlwifi: mvm: Add basic link selection logic")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index ff6cb064051b..8e263acbc763 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -716,7 +716,7 @@ void iwl_mvm_mld_select_links(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		}
 	}
 
-	if (WARN_ON(!new_active_links))
+	if (!new_active_links)
 		return;
 
 	if (vif->active_links != new_active_links)
-- 
2.34.1


