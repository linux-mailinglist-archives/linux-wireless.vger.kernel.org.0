Return-Path: <linux-wireless+bounces-2618-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB3083F475
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5262B21A29
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2BB1E893;
	Sun, 28 Jan 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSq7oyfB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814181E532
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706424906; cv=none; b=AGZA6288++BpemBMzIjNOxDmlmGCp+jQH8qtTdmdpQ0lemBqD1UPcCCX0SLYAVxCbdYnKGEgUHP3gl6GfYjpFJS1YfnOm4XIiZh3Yymp9XghQ6ikqvckoMnefG2m0QeE0vUCT78eWbZ1t3cuWJV4zArAmAkK5gqhSY6o6PcA2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706424906; c=relaxed/simple;
	bh=wQmCjJx2Cmvww60F+UruFrM+TGMAnRAMwqlKt69Uy6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ep+jVUir1W+Kuzfs4VE8CXobz58BVq0h9ns3Z8XhR+jscIE8sQW1bswHCWPlevg88xFQ8k8vmi069ACUSdTZ35YFZ4F9hC2Zw/3OfY7Yr5bJqx8TZ7NNNzTO/lOcK85ZinpNALb3Sq/MM9oRC+y+a4ZtLfbtlUEUyw4MsOHkSPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSq7oyfB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706424905; x=1737960905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wQmCjJx2Cmvww60F+UruFrM+TGMAnRAMwqlKt69Uy6k=;
  b=lSq7oyfBWhOiRf7My+75Ed6Ho3KNREjc88XdNcnhk9ae6+j+ToxMvpS0
   Xera7ewphQ5Ct/Rv+i0TTQktrYdog1aR5lKuSE6rdaTVag3v9FWkRHdX6
   RLCxZEcK2Y2zzdjz0PjOUv9mHXCL+65Ndvo330GRadexk6ihH7OZGI8B/
   osbOmFqRRoT/HjAkppjDAPFOdjqkXDTpz6LyzcYLJlYcOsJ91GE3FuQrL
   12Cg3v5BVBOb+OZ6anALsCix9yTd7wmIhuPVsxO1vFIEP4XncBT3hEmdm
   K1aJxci0SPufWkOTWNdw/8PbOuXNxQy4pMZXsdJdCaE3O1weEUlP1zp+G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="24217688"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="24217688"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="35833378"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:55:02 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/14] wifi: iwlwifi: mvm: initialize rates in FW earlier
Date: Sun, 28 Jan 2024 08:53:58 +0200
Message-Id: <20240128084842.ed7ab1c859c2.I4b4d4fc3905c8d8470fc0fee4648f25c950c9bb7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
References: <20240128065400.2550604-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When connecting to an AP, we currently initialize the rate
control only after associating. Since we now use firmware
to assign rates to auth/assoc frames rather than using the
data in the station and the firmware doesn't know, they're
transmitted using low mandatory rates. However, if the AP
advertised only higher supported rates we want to use them
to be nicer (it still must receive mandatory rates though),
so send the information to the firmware earlier to have it
know about it and be able to use it.

Fixes: 499d02790495 ("wifi: iwlwifi: Use FW rate for non-data frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 85be483b9b7d..c82af4ac27ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3688,6 +3688,19 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mvmvif->ap_sta = sta;
 
+	/*
+	 * Initialize the rates here already - this really tells
+	 * the firmware only what the supported legacy rates are
+	 * (may be) since it's initialized already from what the
+	 * AP advertised in the beacon/probe response. This will
+	 * allow the firmware to send auth/assoc frames with one
+	 * of the supported rates already, rather than having to
+	 * use a mandatory rate.
+	 * If we're the AP, we'll just assume mandatory rates at
+	 * this point, but we know nothing about the STA anyway.
+	 */
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
+
 	return 0;
 }
 
-- 
2.34.1


