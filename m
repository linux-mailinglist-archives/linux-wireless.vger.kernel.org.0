Return-Path: <linux-wireless+bounces-13843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C0A998466
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 13:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F774B2405E
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 11:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9FD1BFE12;
	Thu, 10 Oct 2024 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VexkbusC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EBB1C231C
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558325; cv=none; b=Mh0yCsMHOwXhETQVjAD5ElKibCNMEx+XGBClDR/SD1cL3UHyPQTJm9gqF4vYC2lNQPh3OyL5yFMbPGlY2ch7JOvzo0B4vzfR9wB8XM68HDFZ0+6HUpBCQrJmpRGOr6lVwrVoIn0MNEz/FDRfCn7mlBOBwC06q9arlbJTMg8sL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558325; c=relaxed/simple;
	bh=QddeRWLzD8HQ5IBiB2I/uU8aSMk3RfqHBRfozV/feb8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PcS6nYFpmhHnD0zeGdzomZauncCm88p7vXCQndhAkDkq0a2FEyKsBPN4EIlyQEOApNWpqPWeYHQZ2K2R+kqanT3PJzLHgx0G+OfqQEUfCeGPZMSuFyEmed3J1wDExVFuUpCmtJUDSfYco19/FR5WZByxog44Qe4cHtX2ny/MAV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VexkbusC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728558323; x=1760094323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QddeRWLzD8HQ5IBiB2I/uU8aSMk3RfqHBRfozV/feb8=;
  b=VexkbusCFVxa8FG49xUgwdi7o3zRAgsQ6ErMz0shkxaz3VHI9P5++UIb
   Y6+9/xJPuzuHdf6AFJZAqzshUoehAJg1pjWEIqGnfBGLx6U4R0PWcYalx
   rxGGCCeBlAFaep29rXVSJAVNuutQx+ukUTHfnd79QKZBo4gYGb5nP41gY
   kiK+NmnpF4E0axX0JA4mo1H+CK3zGObdf+eFVdQzGeorAow7PvXtIJQ5z
   q7OKSevYKvk4NFBO0lx/Ozrc86v3DH2A+kZ7Qslm+FQEXgctruVU3b5Pn
   xe4NdJgcWV9RwWzVIOMUiHQgGOarRrtoArr/3uvHC1vv3hReTCNjLUktO
   A==;
X-CSE-ConnectionGUID: Iur+lw+9SVuY33Th7u+qww==
X-CSE-MsgGUID: 17CNewB1TXKXFoadFe7okQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31697728"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="31697728"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:23 -0700
X-CSE-ConnectionGUID: WT9hinVMSq+4CLJ4YkJByA==
X-CSE-MsgGUID: xoDeVWLDSXmgop6opirWBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="81362307"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 04:05:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 1/9] wifi: iwlwifi: mvm: don't leak a link on AP removal
Date: Thu, 10 Oct 2024 14:04:59 +0300
Message-Id: <20241010140328.c54c42779882.Ied79e0d6244dc5a372e8b6ffa8ee9c6e1379ec1d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
References: <20241010110507.1006209-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Release the link mapping resource in AP removal. This impacted devices
that do not support the MLD API (9260 and down).
On those devices, we couldn't start the AP again after the AP has been
already started and stopped.

Fixes: a8b5d4809b50 ("wifi: iwlwifi: mvm: Configure the link mapping for non-MLD FW")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index a327893c6dce..39b815904501 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1970,7 +1970,6 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->p2p_device_vif = NULL;
 	}
 
-	iwl_mvm_unset_link_mapping(mvm, vif, &vif->bss_conf);
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
 
 	RCU_INIT_POINTER(mvm->vif_id_to_mac[mvmvif->id], NULL);
@@ -1979,6 +1978,7 @@ static void iwl_mvm_mac_remove_interface(struct ieee80211_hw *hw,
 		mvm->monitor_on = false;
 
 out:
+	iwl_mvm_unset_link_mapping(mvm, vif, &vif->bss_conf);
 	if (vif->type == NL80211_IFTYPE_AP ||
 	    vif->type == NL80211_IFTYPE_ADHOC) {
 		iwl_mvm_dealloc_int_sta(mvm, &mvmvif->deflink.mcast_sta);
-- 
2.34.1


