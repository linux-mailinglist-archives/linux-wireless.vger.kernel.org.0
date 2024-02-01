Return-Path: <linux-wireless+bounces-2962-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8EF845A02
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1975228E0D1
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA15D479;
	Thu,  1 Feb 2024 14:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EAX/O8hV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165662145
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797221; cv=none; b=LNd6qPeUMCS+UQWvM9ZDzQy8FaoQc0l8+7PjBOSy+3suwJs+cRixQzJwwFQKWC2uJ5jYmkn7AkYV2mAOnSzeFPBNeTFjvMLZh/cAKeoJretNs5Vsm3dhDHH/xVNGuYZ0+p39gpeh5Q8wLdwfe6EKz2VJ+S3vUqFxoNw5bp01iDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797221; c=relaxed/simple;
	bh=rEOTLH1ByaWJc9WtU7nc7Ur83YQVXimliVBAWFzgmwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MDebCP9s7MAU0SuWgdASnGnxVzlmZCG4Bh+LvrNsOtZGG6mPFrALxzKMOz2jYtfzFt4Igjcy/MSL4hIBOYqVoDKrNku1b4vuXuCC0UeiQjP15KNmvaHmyU3Xp+BHvE6+itfD1gM3oXmQPaCG1f68v4vHnvnRSIpDn/SiQwlm+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EAX/O8hV; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797219; x=1738333219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rEOTLH1ByaWJc9WtU7nc7Ur83YQVXimliVBAWFzgmwo=;
  b=EAX/O8hVbyzkgnusBcqFJudkH7vc0bg9uYxD1Na7x0aLUv9Ew1RsqDM0
   Igx90Rlbfglc9n4vFlRfWXsfKEoHoON+L2Spit859NGytD/5mzc7oUM8X
   j20Ls9AeBlQi92mDrmh0R491noXZhB/DrSxs2zrsOBTOMOOGw+UT4R8cB
   rN62pnuLppgTdqWGXbRNEo1F4O9fODsmqYB0Q8DMXbmqK8biW3N6t9rfO
   2K+k7MB1c1tQSvqyqUtR0IOhkJt06qVDYoS/RbroJ1z61sfFhHm8mpyxo
   kBtB5HetiInnH1VwSpMM8zWB4t0CK2HY8aABPROIu42LIAjZI0de43nYg
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062989"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062989"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94524"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:20:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/17] wifi: iwlwifi: exit eSR only after the FW does
Date: Thu,  1 Feb 2024 16:17:39 +0200
Message-Id: <20240201155157.d8d9dc277d4e.Ib5aee0fd05e35b1da7f18753eb3c8fa0a3f872f3@changeid>
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

Currently the driver exits eSR by calling
iwl_mvm_esr_mode_inactive() before updating the FW
(by deactivating one of the links), and therefore before
sending the EML frame notifying that we are no longer in eSR.

This is wrong for several reasons:
1. The driver sends SMPS activation frames when we are still in eSR
   and SMPS should be disabled when in eSR
2. The driver restores RLC configuration as it was before eSR
   entering, and RLC command shouldn't be sent in eSR

Fix this by calling iwl_mvm_esr_mode_inactive() after FW update

Fixes: 12bacfc2c065 ("wifi: iwlwifi: handle eSR transitions")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index 35ce84cc0194..ff7d9a7d607e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -435,6 +435,9 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 		mvmvif->ap_ibss_active = false;
 	}
 
+	iwl_mvm_link_changed(mvm, vif, link_conf,
+			     LINK_CONTEXT_MODIFY_ACTIVE, false);
+
 	if (iwl_mvm_is_esr_supported(mvm->fwrt.trans) && n_active > 1) {
 		int ret = iwl_mvm_esr_mode_inactive(mvm, vif);
 
@@ -446,9 +449,6 @@ __iwl_mvm_mld_unassign_vif_chanctx(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_MONITOR)
 		iwl_mvm_mld_rm_snif_sta(mvm, vif);
 
-	iwl_mvm_link_changed(mvm, vif, link_conf,
-			     LINK_CONTEXT_MODIFY_ACTIVE, false);
-
 	if (switching_chanctx)
 		return;
 	mvmvif->link[link_id]->phy_ctxt = NULL;
-- 
2.34.1


