Return-Path: <linux-wireless+bounces-11143-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A56E94C5A4
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 22:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBCF1C21BE9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3264715B542;
	Thu,  8 Aug 2024 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iI4DIXUM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B03115B0F4
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723148595; cv=none; b=cHNJyvE2HFlv0xRK1/blHtFAOsT4uYAE6MFZsr3qYm7ztGU3XcGY1NBiXQmIMPcyXqwInJthcKleDDYCBUObkaZb13N9OtJshNFA0fn5hr5EtNu0hGOO4KO7eOyC1Ir9SHUuXyRtyflyOF3A7VmtykFQv07SB+TfQ41GC/WzIK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723148595; c=relaxed/simple;
	bh=zOtFqVJQ6aawOIPvMuMp25drxU1zs7i/FYmUT6N4WR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEkx0PA4iBU+Z/Arq6QtiQFMFBqo24WmyqU4y2rBOCQtgDIHi7dOoZGSIDNajBFzchcgjH3e+4wneFgC7wP3vXDjdrtoOfrkyi1KgHjg8dWhPsSprh4oB3hXugJZe9MC+O0hVR3bK6CpIe8XwFIvb6GUI66wxvfbQWmqyWKABDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iI4DIXUM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723148594; x=1754684594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zOtFqVJQ6aawOIPvMuMp25drxU1zs7i/FYmUT6N4WR8=;
  b=iI4DIXUMZv0azxQwuOPufHLuC3ufk6+LmQ2Vgvu8addGsh/Xv3l49skg
   rgLf2vb57yy4HLNObd6J1af0hqlziwIY4jLyHNq8Cng5QAdiATatAx5sz
   lArlDJuaI9JylX1qj37tZrZuoK6oY10QlRqR2p87Mq4pLgEMn14Q4huNe
   m1bxbVfizuHMA5SwnexKXQYoweSZPIypvBi3kl9b964slJw0e6zyCv3rK
   PdAdAhnADyiSibAgkRo6/QFJ+sYdRY/tF60KvHgyCAZ4D//FHGTf3fi2O
   vzuvhwbjDiRsZ9r1lnJPUpL7WrVT76KDChgj404/AaPEzo+SUsUY5ySpn
   w==;
X-CSE-ConnectionGUID: /S2+uH82SJ6FcHnghU5Z0w==
X-CSE-MsgGUID: FKkcMozNTZaYUbYrS40xYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="38808850"
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="38808850"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:13 -0700
X-CSE-ConnectionGUID: oB8pbPquT0uryJ9e9LeI6A==
X-CSE-MsgGUID: rprayx8MSkWpA1vtoRZ7wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,274,1716274800"; 
   d="scan'208";a="57305315"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 13:23:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 08/13] wifi: iwlwifi: mvm: Stop processing MCC update if there was no change
Date: Thu,  8 Aug 2024 23:22:44 +0300
Message-Id: <20240808232017.60dd273d00e0.I985b3bc61ca4a6cac7c1d1365b5c0afba04f3031@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
References: <20240808202249.4004087-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When processing a MCC update notification from the firmware, if
the firmware indicates that the regulatory configuration didn't
change, abort the flow and do not notify higher layers.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 836ca22597bc..80ec59c58ae4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -611,6 +611,7 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 	char mcc[3];
 	struct ieee80211_regdomain *regd;
 	int wgds_tbl_idx;
+	bool changed = false;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -630,10 +631,15 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 	IWL_DEBUG_LAR(mvm,
 		      "RX: received chub update mcc cmd (mcc '%s' src %d)\n",
 		      mcc, src);
-	regd = iwl_mvm_get_regdomain(mvm->hw->wiphy, mcc, src, NULL);
+	regd = iwl_mvm_get_regdomain(mvm->hw->wiphy, mcc, src, &changed);
 	if (IS_ERR_OR_NULL(regd))
 		return;
 
+	if (!changed) {
+		IWL_DEBUG_LAR(mvm, "RX: No change in the regulatory data\n");
+		goto out;
+	}
+
 	wgds_tbl_idx = iwl_mvm_get_sar_geo_profile(mvm);
 	if (wgds_tbl_idx < 1)
 		IWL_DEBUG_INFO(mvm,
@@ -644,5 +650,7 @@ void iwl_mvm_rx_chub_update_mcc(struct iwl_mvm *mvm,
 			       wgds_tbl_idx);
 
 	regulatory_set_wiphy_regd(mvm->hw->wiphy, regd);
+
+out:
 	kfree(regd);
 }
-- 
2.34.1


