Return-Path: <linux-wireless+bounces-2951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4638459F3
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE5F1F23F57
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B4486635;
	Thu,  1 Feb 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nnufn99P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF08665E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797190; cv=none; b=blcXwBhzD9zQZgbPRaDAvQwXFjjMpe1xyaRddazrtelaeg0+YcEJ6mIx8CumTqCldxxn4c9URHgm7xR1Pl8PhHVyuPRnZ4R4OCebS0TqnGCoJCUIStnDZRjYUs6zV+XxWMZzc9xiL3Vl+PwibHvgQT26jD3IQJ0j013UhSUAzgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797190; c=relaxed/simple;
	bh=Zh9DXmPFqz9KgyxksXgLnaLLQes+aa+DjjDFcjI28pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ejy7Qv1Iz2V3/HjFgDxhR83Mjgbv+wvWn1VShV19bvvTIjF/ePS8JuTwRYo51PZoS4MjL7B0HO+TNdGGtXej19DLYtQW1JcyE7cNLvPAlTwFdGNd+ZFwcDf8oSs7Tsogm6kr8L/wkYX1dcleQmfO7fk4k49AMe94fl1jI0LedZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nnufn99P; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797188; x=1738333188;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zh9DXmPFqz9KgyxksXgLnaLLQes+aa+DjjDFcjI28pY=;
  b=Nnufn99Powzw9000Ycef0ZkEHL0FTHZx22AzvhrTVPOLxo/L0wFP5Hxa
   oW1OvdHVG1ujVbV1LeCGHgZwjpPGZf7CPkjwJAtERFpO6XkuiBbiEq6aT
   scdnC2CN64LEN24NPs8MEGfsZ0ql32qIqhp0OKzG3Rg1xCUDxdjlOvNfd
   5NXMWLEs5cgoyyakQ3iFYe2DxuCsvYA7oAKULnJ0fq2oYmUs64ZShiRqI
   qDv+WniQ4MeHUYbM16yf7hpQk/eqCcHHu1fUyS8aRBFyqApLkVP42alFh
   uugJT7PG/mWw4tBRTSDywuR+IaZdc/iNpUbKQxUTTrpi0IJG0xtoz+wGS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062864"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062864"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94105"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:44 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 04/17] wifi: iwlwifi: mvm: use fast balance scan in case of an active P2P GO
Date: Thu,  1 Feb 2024 16:17:28 +0200
Message-Id: <20240201155157.310a00388e11.Ib136140dffa8704e68ff14e8fb69d35b97057171@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
References: <20240201141741.2569180-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

Set fast balance scan in case of active P2P GO, regardless of the
BSS DTIM interval.
This will increase the chances of scheduler to successfully schedule
out-of-channel events.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7b6f1cdca067..f3e3986b4c72 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -241,13 +241,11 @@ iwl_mvm_scan_type _iwl_mvm_get_scan_type(struct iwl_mvm *mvm,
 			return IWL_SCAN_TYPE_FRAGMENTED;
 
 		/*
-		 * in case of DCM with GO where BSS DTIM interval < 220msec
-		 * set all scan requests as fast-balance scan
+		 * in case of DCM with P2P GO set all scan requests as
+		 * fast-balance scan
 		 */
 		if (vif && vif->type == NL80211_IFTYPE_STATION &&
-		    data.is_dcm_with_p2p_go &&
-		    ((vif->bss_conf.beacon_int *
-		      vif->bss_conf.dtim_period) < 220))
+		    data.is_dcm_with_p2p_go)
 			return IWL_SCAN_TYPE_FAST_BALANCE;
 	}
 
-- 
2.34.1


