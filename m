Return-Path: <linux-wireless+bounces-7464-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C288C265C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 16:08:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E2B22A54
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24343171645;
	Fri, 10 May 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aTD/LEAu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B28A171085
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350021; cv=none; b=hfB8bRUq0ntxkPzfFwcEPcPulM0K5RLqyL8aU24ZGFqrm2JKChawvHQwF7fx5/0XW9JmrNJ6pl4+w/5a9mxFfDaYXfJ22kUmdPKcgKb2xpMe5CpzcnA28j2/81RZGpHt8SwdabMTkeKuZmJasUYYGTBDVFo8HCy+fGZpgOIVV/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350021; c=relaxed/simple;
	bh=RgzUeUVm7GFYm5Qv+GWEl+Q2yhofmahBPlktfDP+o70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rkFx1ER1SlKaYOLTd84O08UbKTK+waydUgYZjwYaUgXJuG5HEy9L7cSOvdloENgfSMJe7vjbpxdTMZmjhtb/9tm/l2sOLtgdR9333SfxPl4us0L/1//tWkGoDRNlYpcmE8LmsJqPY1CPproqcc7WmlkZzC2eBc8eO2j/98aSwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aTD/LEAu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715350019; x=1746886019;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RgzUeUVm7GFYm5Qv+GWEl+Q2yhofmahBPlktfDP+o70=;
  b=aTD/LEAufLHJjHdntzBz09kRfPTDMBPExKswjClLB1ZWOPIRmfnHs2Sf
   oSFiGOqpUnBTzzojOrrRtF0hfir8XjFkdJ7HqirBK2eJ+ZXjY8GJ/0Oz8
   vxkb6xG/wYSc0uUJbhj6q+9J7g2+3tao2XYh92Fuykulkvj1TcM5iOta9
   feiyZN1ObdRlotlxrpXrlW2N9vfE+wl8+XM4mn8zTTFUcSRuu0FCT8tuS
   UUBYdRQFA2zKRh0TDSEcw+XpjZUpR330iPScpdxtv8Iur7D7YoUCrFSly
   PxDUTiktULkJNxUjwlOu/PmYITH5pOHZn77Npvc2lxii/SHxy1h432moQ
   Q==;
X-CSE-ConnectionGUID: 6od6salaR8ijX2/rDu0PWA==
X-CSE-MsgGUID: 2LQtZbMkSsy49T6BpERO3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15125538"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15125538"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:59 -0700
X-CSE-ConnectionGUID: VyuMQ4scSZmCnYrKNmPOsg==
X-CSE-MsgGUID: J/0SX0exQFy0e4Wt8zpHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="67101847"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 07:06:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>, Coelho@web.codeaurora.org,
	Luciano <luciano.coelho@intel.com>
Subject: [PATCH 04/14] iwlwifi: mvm: allow UAPSD when in SCM
Date: Fri, 10 May 2024 17:06:31 +0300
Message-Id: <20240510170500.1ec19d432497.Id6de5337c878fa70e85bfcf6f4e0e34ce60756fb@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
References: <20240510140641.1895860-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

Allow UAPSD when P2P and BSS interfaces share the same channel.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Coelho, Luciano <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/power.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/power.c b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
index 72f4480ae7f5..cc7176b0be4f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/power.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/power.c
@@ -212,7 +212,7 @@ static void iwl_mvm_power_configure_uapsd(struct iwl_mvm *mvm,
 }
 
 struct iwl_allow_uapsd_iface_iterator_data {
-	struct ieee80211_vif *exclude_vif;
+	struct ieee80211_vif *current_vif;
 	bool allow_uapsd;
 };
 
@@ -220,9 +220,12 @@ static void iwl_mvm_allow_uapsd_iterator(void *_data, u8 *mac,
 					 struct ieee80211_vif *vif)
 {
 	struct iwl_allow_uapsd_iface_iterator_data *data = _data;
+	struct iwl_mvm_vif *other_mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm_vif *curr_mvmvif =
+		iwl_mvm_vif_from_mac80211(data->current_vif);
 
 	/* exclude the given vif */
-	if (vif == data->exclude_vif)
+	if (vif == data->current_vif)
 		return;
 
 	switch (vif->type) {
@@ -232,7 +235,12 @@ static void iwl_mvm_allow_uapsd_iterator(void *_data, u8 *mac,
 		data->allow_uapsd = false;
 		break;
 	case NL80211_IFTYPE_STATION:
-		if (vif->cfg.assoc)
+		/* allow UAPSD if P2P interface and BSS station interface share
+		 * the same channel.
+		 */
+		if (vif->cfg.assoc && other_mvmvif->deflink.phy_ctxt &&
+		    curr_mvmvif->deflink.phy_ctxt &&
+		    other_mvmvif->deflink.phy_ctxt->id != curr_mvmvif->deflink.phy_ctxt->id)
 			data->allow_uapsd = false;
 		break;
 
@@ -246,7 +254,7 @@ static bool iwl_mvm_power_allow_uapsd(struct iwl_mvm *mvm,
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	struct iwl_allow_uapsd_iface_iterator_data data = {
-		.exclude_vif = vif,
+		.current_vif = vif,
 		.allow_uapsd = true,
 	};
 
-- 
2.34.1


