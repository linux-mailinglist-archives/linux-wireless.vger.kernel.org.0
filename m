Return-Path: <linux-wireless+bounces-12298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A406F9674F5
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 06:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B60C2831E9
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Sep 2024 04:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EAD1C36;
	Sun,  1 Sep 2024 04:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3ooF9in"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42E3398B
	for <linux-wireless@vger.kernel.org>; Sun,  1 Sep 2024 04:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725164300; cv=none; b=hsfoDO7GcCzv/rr2tDakUecKWeczxbSGxOp+ZaMyLbjgB1vasdodD2A8Y+wYWhx3yj/Elj8EQFdGsgWgSUSALR6MEsKkgbbSeSdl73iQGND0avPm7VASKIHE6dyxCVRP/6kOrI270IVSg7MdXcqWrRwBTt5WYLoXhZhoDhTtKJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725164300; c=relaxed/simple;
	bh=dezrlh8sjsDQvD57PXKAGugVzIuTC0bmppxBBWkqnJU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luM78fs/vcQbgXcPBfn352SkBAjzSaGaAX1vEL3WAsRfgkbySstDDVD+7BQfQLQqQv7Gh4PJ5KXG99Bln+IZcbHsrCnRr0uAQcDG4XD3So6a6U6peXh7fQJNw7cadZ2fk3AFdKCpedcxpasYvBDYAtfGlumPXca5ImQwleOY5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3ooF9in; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725164299; x=1756700299;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dezrlh8sjsDQvD57PXKAGugVzIuTC0bmppxBBWkqnJU=;
  b=I3ooF9inxfpxiLHTjWQOGFnZSiLxDzpl0Ju9Ijh3anI0JHDqIfXwGpdF
   hwpCg8wmZWlUKceskuUUau4FwVJjX/R/ujGCGz1RsqzxhRYog1p+U7WbG
   hiCOzIb8BdBp08U04w/MzFOOPq12j3JoEI7uLm5jtovT1Qr4vhvUuuN31
   7cRPvi0hEHHc5LKeFZJZKcGzrFEGG28t74kQsLcQByuImB3n2OpxuNweb
   ZGK8PeZdPYS+OD6vG/cNHffTAPDVPdOlDA9daTEt+UQulpgdBNEP3PKfI
   +TMckd6yRvUUbZ1cx2A4RxdOeWpyhGvX1g+g039BrDmbo+5m3H4D/j3jn
   w==;
X-CSE-ConnectionGUID: TCKgoNgyRo+82A64OxNCxw==
X-CSE-MsgGUID: R6mdgv+aSt2QyAXzSQ8zmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11181"; a="27559530"
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="27559530"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:18 -0700
X-CSE-ConnectionGUID: 5aYwd9s7TaSk3jBROZZWAg==
X-CSE-MsgGUID: BejUPZSkSEuS96SoplL7IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,193,1719903600"; 
   d="scan'208";a="64276327"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2024 21:18:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 8/8] wifi: iwlwifi: mvm: properly set the rates in link cmd
Date: Sun,  1 Sep 2024 07:17:57 +0300
Message-Id: <20240901071542.11c2d3609609.I8fa59e29b6bb38e5d06f3536d54dfb2c5d5bab11@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
References: <20240901041757.917200-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

When a channel ctx is assigned to a link, we set the
LINK_CONTEXT_MODIFY_RATES_INFO to indicate that the rate fields are now
valid. But then we always take the rates of 2.4 GHz regardless of actual
used band.
This is because we are getting the band from bss_conf->chanctx_conf, but
this is assigned only after drv_assign_vif_chanctx returns, so we take
the bands of 2.4 GHz.
Fix it by taking the band from the iwl_mvm_link_info::phy_ctxt instead,
as this has already assigned in this point.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c   | 17 ++++++++---------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h    |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index bc8d06127747..2b0652168002 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -264,7 +264,7 @@ int iwl_mvm_link_changed(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	if (vif->type == NL80211_IFTYPE_ADHOC && link_conf->bssid)
 		memcpy(cmd.ibss_bssid_addr, link_conf->bssid, ETH_ALEN);
 
-	iwl_mvm_set_fw_basic_rates(mvm, vif, link_conf,
+	iwl_mvm_set_fw_basic_rates(mvm, vif, link_info,
 				   &cmd.cck_rates, &cmd.ofdm_rates);
 
 	cmd.cck_short_preamble = cpu_to_le32(link_conf->use_short_preamble);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index bbddd984ddf9..a7a10e716e65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -413,19 +413,18 @@ static void iwl_mvm_ack_rates(struct iwl_mvm *mvm,
 }
 
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				struct ieee80211_bss_conf *link_conf,
+				struct iwl_mvm_vif_link_info *link_info,
 				__le32 *cck_rates, __le32 *ofdm_rates)
 {
-	struct ieee80211_chanctx_conf *chanctx;
+	struct iwl_mvm_phy_ctxt *phy_ctxt;
 	u8 cck_ack_rates = 0, ofdm_ack_rates = 0;
+	enum nl80211_band band = NL80211_BAND_2GHZ;
 
-	rcu_read_lock();
-	chanctx = rcu_dereference(link_conf->chanctx_conf);
-	iwl_mvm_ack_rates(mvm, vif, chanctx ? chanctx->def.chan->band
-					    : NL80211_BAND_2GHZ,
-			  &cck_ack_rates, &ofdm_ack_rates);
+	phy_ctxt = link_info->phy_ctxt;
+	if (phy_ctxt && phy_ctxt->channel)
+		band = phy_ctxt->channel->band;
 
-	rcu_read_unlock();
+	iwl_mvm_ack_rates(mvm, vif, band, &cck_ack_rates, &ofdm_ack_rates);
 
 	*cck_rates = cpu_to_le32((u32)cck_ack_rates);
 	*ofdm_rates = cpu_to_le32((u32)ofdm_ack_rates);
@@ -563,7 +562,7 @@ static void iwl_mvm_mac_ctxt_cmd_common(struct iwl_mvm *mvm,
 	else
 		eth_broadcast_addr(cmd->bssid_addr);
 
-	iwl_mvm_set_fw_basic_rates(mvm, vif, &vif->bss_conf, &cmd->cck_rates,
+	iwl_mvm_set_fw_basic_rates(mvm, vif, &mvmvif->deflink, &cmd->cck_rates,
 				   &cmd->ofdm_rates);
 
 	cmd->cck_short_preamble =
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 650b562a22cd..c9b69c3a61fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2016,7 +2016,7 @@ int iwl_mvm_phy_send_rlc(struct iwl_mvm *mvm, struct iwl_mvm_phy_ctxt *ctxt,
 void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 				 struct ieee80211_vif *vif);
 void iwl_mvm_set_fw_basic_rates(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-				struct ieee80211_bss_conf *link_conf,
+				struct iwl_mvm_vif_link_info *link_info,
 				__le32 *cck_rates, __le32 *ofdm_rates);
 void iwl_mvm_set_fw_protection_flags(struct iwl_mvm *mvm,
 				     struct ieee80211_vif *vif,
-- 
2.34.1


