Return-Path: <linux-wireless+bounces-1025-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 433658190BA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB95A283BA1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3606139AD1;
	Tue, 19 Dec 2023 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+3Zy9O3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FFB39AE6
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703014158; x=1734550158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=baMBgVm83ShQXDitTeGEVkbYVm7UC+cjXvo7N5jWa2U=;
  b=W+3Zy9O3xgJD0I8jO1yQEHUeD3JW0ZF0sFEpCyQ2ZGXAQULIsvYDNCBW
   NZuCAbDeMAl98SI1/oifrTjHWtS2Hiq3HAx9gCNCxiZzK7cQCvS/8/aD0
   hUL+hlsTBX+vnWA8FpRw+nQb2iULWv3I9Kl7CUb2JRvo/1BPLV5FpCTn8
   HSL67D3k8sdf89bDw3uL8MlhiCJAyk0Zb85j9cmIPoOuzD7eFpVJDfOfH
   aCN8ww782ripFIrJ7i58b2UZp5BTbdJ5wGoK1VNjdRaGd63ox3uXCOC4a
   EOva/KdQnDxTnxALPejEaPXSnhIEdu4VzRoBI8H/dPjhje154NlaDvb/o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="460054363"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="460054363"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="899478251"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="899478251"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:29:16 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 06/14] wifi: iwlwifi: mvm: Do not warn if valid link pair was not found
Date: Wed, 20 Dec 2023 15:29:23 +0200
Message-Id: <20231220152651.142e57a05230.I7cfe78c94c3d15c4c744bccadd8f187e43594932@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
References: <20231220132931.3314293-1-miriam.rachel.korenblit@intel.com>
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


