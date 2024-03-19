Return-Path: <linux-wireless+bounces-4893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2597F87F91C
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 09:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 571061C21A81
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 08:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A87D3E7;
	Tue, 19 Mar 2024 08:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VU80H4Au"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7357D3E8
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835872; cv=none; b=VlL8VBiC35kGrWb8dmbCrRm9OgYmjkN5/3l8hsrkKpaYD/XeVlwpSiDpbpdexxMCNO5nt5Ol5OilRzcTWwyD9lny+8z4DIIzmdl78I8ITKrCyyNyfVUdQrfJo56j3KdSlD1WmA2GXBecNbtuzzZ5ESp2XuTaMi4NOKja9UzObWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835872; c=relaxed/simple;
	bh=ORTiShJuuaJljKFtBLTlhvIA30c1rhrqn+dVYOyIzaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EBjY6T5mY/qg06318Xe7gfT0rtaib5ihIpYYEPnYkOvZZHzgllYt5FYWYcf+ZIDXgQDeog61XpMYyS+QC9ZYAbnhdmGFhfrQUc/6DPr1JCsWuo7ExgWw4ZLWc7RTUoqTOBLx8jYSNz06rPnwm7nLFN02Tw86RhHFJ8jRc1FrzrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VU80H4Au; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710835870; x=1742371870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ORTiShJuuaJljKFtBLTlhvIA30c1rhrqn+dVYOyIzaQ=;
  b=VU80H4Aus8cYHFgyyDtfp0vRVBgLeSz0NYaYfxmu0V26V7bcYDCM6q9J
   aDTNgdw/DI/P5UlAkVTrl0phzSpB4zJkfS77FLoGm/Jhgk35JMMlmAdKp
   hNL5//rQlHOWUdePCaQGxyaKB/nHFZj8Ih7nEMlNxsDxUG8EuQLS/CMIb
   oSNMIhlehpaSmPxXpLF+RhxC/BEcfkTJfrsrx9P4QYDdYmjMFAaLjLEH/
   Kby0UfvIIArur7D+g8sj804bgE0ZgF2cqbzHvpBFl4oNhEzl/owKyq1x9
   43RVU0dKuzgyt+sKTSRNvWQ0wdBzM5FDPBtcOf76F03501ZZ3aaPoLuhM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5810582"
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="5810582"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,136,1708416000"; 
   d="scan'208";a="18447663"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 01:11:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: mvm: Do not warn on invalid link on scan complete
Date: Tue, 19 Mar 2024 10:10:25 +0200
Message-Id: <20240319100755.619d3574a757.I0523e92547f0288c8b0119b1fdc5e967a5a8956e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
References: <20240319081027.3853611-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

As it is possible that by the time the scan is completed the link was
already removed.

Fixes: 3a5a5cb06700 ("wifi: iwlwifi: mvm: Correctly report TSF data in scan complete")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 459adba41ca6..fc6b4f699cb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3207,8 +3207,13 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		struct iwl_mvm_vif_link_info *link_info =
 			scan_vif->link[mvm->scan_link_id];
 
-		if (!WARN_ON(!link_info))
+		/* It is possible that by the time the scan is complete the link
+		 * was already removed and is not valid.
+		 */
+		if (link_info)
 			memcpy(info.tsf_bssid, link_info->bssid, ETH_ALEN);
+		else
+			IWL_DEBUG_SCAN(mvm, "Scan link is no longer valid\n");
 
 		ieee80211_scan_completed(mvm->hw, &info);
 		mvm->scan_vif = NULL;
-- 
2.34.1


