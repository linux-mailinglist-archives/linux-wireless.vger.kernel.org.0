Return-Path: <linux-wireless+bounces-5056-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08245881916
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B161F21CCB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285ED85C70;
	Wed, 20 Mar 2024 21:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mpg7dDvT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9869C85C6A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970041; cv=none; b=G9Fbj8qlLySLQaYuH7RZ037cGNQcMLiMMvmfXvyuQYK7RgiApxx4odsW/q/EZ10hpqCGJTELzgEBOMaP4dQg+sKXet/PvVqXgNCAM9HIPq+QYnAVb2qVHeJjoZh+R12+zpsUCDqH9Tzpx94INmDx+4zFZxYnbVrTbKjz/YP4VwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970041; c=relaxed/simple;
	bh=jMmq3FBBSZV1RcYJ0p91pG+T8fW8kNGy/1K+l9C1iH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGawKe2gnlFaT9iwhYu1VU61hW2av5z4Sw9zuiItGzgUPcsZ20JphWumruAeaVz967AJbWU+S8O1WJX95hi7iiZIuoVdbWEgpwlenWS+Rtros9cQLY9sohzBF8Pyv5u+kPZfQitb2T45A0tP/m5W3fjMSXK042/CRsO/GNnB08g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mpg7dDvT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970039; x=1742506039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jMmq3FBBSZV1RcYJ0p91pG+T8fW8kNGy/1K+l9C1iH4=;
  b=mpg7dDvTHs3tALDKs4VsKUX5SE0Z6TO3A/FCkpzAT2Dp7F3pxYo4yWhT
   akMgZqJ08e+yrFVeWtLmkhflH+AVnL6CK4jQIEA4n/K8TApuI9Jrs4XLL
   +HkuUFG8FIcR0ujK2w+fKAnkaH7dG1gFlyMcjmFQLifjGk7tmtCgjup5K
   KKmJQtiyW9QonGoO97CWu97UuCWeAaLoNDJl69tR9gAOy1qJLh5KxqkM9
   aijZ1HGuazS9+D2gprTutbzIRnihrfCXfp51JCDdDOQojZjS5BeGPc6x9
   s8R6A8UD1pk/mzR90Wx63/65bD0DR5oVKKEXsVlLo3GqjLqqTs/bGZRKx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698140"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698140"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184198"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:18 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/17] wifi: iwlwifi: mvm: set wider BW OFDMA ignore correctly
Date: Wed, 20 Mar 2024 23:26:35 +0200
Message-Id: <20240320232419.0d5fb0e971e4.I3b67c5e0ddcbe6e58143ec0bc4e40dd6dba4f863@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Clearly, I put this flag into the wrong place: devices using the
code in mac80211.c only do not support EHT, so this isn't even
relevant. Fix this by moving the code to the right function.

Fixes: 32a5690e9acb ("wifi: iwlwifi: mvm: support wider-bandwidth OFDMA")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c     | 3 ---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 448b43d73625..40e70ffecd14 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1698,9 +1698,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 				     IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 	}
 
-	if (vif->p2p || iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1) < 5)
-		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
-
 	if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		mvm->p2p_device_vif = vif;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index d18304ac126c..5a4973431c8b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -92,6 +92,9 @@ static int iwl_mvm_mld_mac_add_interface(struct ieee80211_hw *hw,
 		mvm->csme_vif = vif;
 	}
 
+	if (vif->p2p || iwl_fw_lookup_cmd_ver(mvm->fw, PHY_CONTEXT_CMD, 1) < 5)
+		vif->driver_flags |= IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW;
+
 	goto out_unlock;
 
  out_free_bf:
-- 
2.34.1


