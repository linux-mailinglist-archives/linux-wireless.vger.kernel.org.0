Return-Path: <linux-wireless+bounces-2950-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4688459F2
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 15:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F881F233BC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Feb 2024 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2486F8665E;
	Thu,  1 Feb 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eF4fApjt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0A86635
	for <linux-wireless@vger.kernel.org>; Thu,  1 Feb 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797182; cv=none; b=ggtiUTvOW8FMkgcte0rUi2DKkFRULyXAR6TlMwxiXYZLbeugp31cOZ7xxKFQK3Kv7ouue9zYj/i5qqOuNoWdF38zlH/C5L2p5HySiEAd8ZyGd8Y4cdXocm9VXio/nzU5MMdgUId2W7n0EPBcBUV7TpFQVdZcvqPPeORi1DtW124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797182; c=relaxed/simple;
	bh=NZqWx5Vzk/FWetBvEwjvde8vVjYT+kif8T3wW0KXHX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T81T+/hg+q31KIGaGMke5b01WzbZYGLYr/pDZf9EtfPLAsyxa+fXf/yJWMYwaEqQBL9WQ0vcY5+mIEPc2MA7pRCoMMDKJfVP13kvQvdqy+SgdLeg8+MBlHaVDyAW24dZ3q/rMKSkCBTKV7MJkAxGSzJ6fJO6fW/3HHjMrW3I5H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eF4fApjt; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706797180; x=1738333180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NZqWx5Vzk/FWetBvEwjvde8vVjYT+kif8T3wW0KXHX4=;
  b=eF4fApjtvaeRIHWPIcKcpGiUpDrjRVeWJybzUbUByorc5y35TX5AWR/I
   tUf9YpeH7nDR62kKkk964mxyV6nhkhcEWwzC1vpbuPosts7111mxDcFUP
   +N+iaCxi30dpuKXialXVJ5Q6aVidY6sHFGMMJpOcwvFD+XhI+vj9MC46P
   hSdrnohkg1gxRCSdT6nFacaHKCVfcksX/uCVQJenghzhj6EJJREnct8eH
   SGE0Hia63EBXHRkWDd8cOILQnKkj2Ri1YW5cJs0xkIPzXfS1MV8I9VlJe
   dIi3+ib0FPNWIZhbyfzFY9jvH014JzX4BNmPasiZ9CS8kYawVq2BtJ1XA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="435062833"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="435062833"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="94082"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:19:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Berg@web.codeaurora.org, Johannes <johannes.berg@intel.com>
Subject: [PATCH 03/17] wifi: iwlwifi: mvm: don't send NDPs for new tx devices
Date: Thu,  1 Feb 2024 16:17:27 +0200
Message-Id: <20240201155157.e95d53448e94.I0ec92f1ca56a62cd8c13390b9fe60e9a7e9411c7@changeid>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

New tx devices may have issues sending NDPs from the host.
Send a CQM event instead. If the AP is really gone, we will get a beacon
loss and disconnect.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Berg, Johannes <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index c4f96125cf33..bcf78ccba8c1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1626,10 +1626,14 @@ void iwl_mvm_rx_missed_beacons_notif(struct iwl_mvm *mvm,
 	 * TODO: the threshold should be adjusted based on latency conditions,
 	 * and/or in case of a CS flow on one of the other AP vifs.
 	 */
-	if (rx_missed_bcon > IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG)
+	if (rx_missed_bcon > IWL_MVM_MISSED_BEACONS_THRESHOLD_LONG) {
 		iwl_mvm_connection_loss(mvm, vif, "missed beacons");
-	else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD)
-		ieee80211_beacon_loss(vif);
+	} else if (rx_missed_bcon_since_rx > IWL_MVM_MISSED_BEACONS_THRESHOLD) {
+		if (!iwl_mvm_has_new_tx_api(mvm))
+			ieee80211_beacon_loss(vif);
+		else
+			ieee80211_cqm_beacon_loss_notify(vif, GFP_ATOMIC);
+	}
 
 	iwl_dbg_tlv_time_point(&mvm->fwrt,
 			       IWL_FW_INI_TIME_POINT_MISSED_BEACONS, &tp_data);
-- 
2.34.1


