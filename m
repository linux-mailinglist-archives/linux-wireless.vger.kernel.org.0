Return-Path: <linux-wireless+bounces-7203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D18BC803
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 141D81C2094A
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FC85338C;
	Mon,  6 May 2024 07:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EUwtPTQi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59FB5464A
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979089; cv=none; b=DsKpzxxYWfhBpg6Ar3IXUXyeVrGUPG8KDMniOaA41Tweul0zyY0Wp02TLZjr2WaxVxpTjPx0mKFy9hcc+C0dXGGQY/kXhfQpxHtbJ7X6+w2QmcIKSYkdmuwoSQdywlYjPCdl6RoDz7eVt0XoxBFE+EtTjCqGEnyS1Yrr5fHPHIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979089; c=relaxed/simple;
	bh=4C+NKqjDDkmy+8QLLd67L+s0Nt8cHMl1dUa8gu2WtSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lze5dOtP20ZzxypstI54eEkimQZHVZlQrDi4AHfHX8XRCNPpGQfNpXNhGb1woL4sHxh5X6IJhTfQE+/8UHohNd1PEjxh1o+enh4CII/dsbvi6aR2DY9sobS8i9OPsWEwnx7FhJV2eGnYmXxk9yzr+DtQN3+9XLIuebabA1Dmrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EUwtPTQi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979088; x=1746515088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4C+NKqjDDkmy+8QLLd67L+s0Nt8cHMl1dUa8gu2WtSM=;
  b=EUwtPTQiUGJRHQDB+EB7jfA8+2FrVkEf5ZrN+w0DHE76hth0Hl7g4RKO
   Wm3DZ+pNMcigxtptbDZTIAAn8aMkbVNwOISjPH+Z6OzxKVf6HPF3VOZlc
   vtHf8n66aza6yjTqV8Oyz5D3y0HSY5x9D4hh0IkW2qkZ04NuyS+csWN9P
   3cOki9suvcy8ey0JiQ8tmc7Ket7UG05hZbN930GqVabhXYO7XzaCYfOJt
   fZn2eXnWlDrN92SQ8GrmutD/pxKrRKG37SAbODJGf9LqcEk9QMXT4U4F+
   pEOMZ3yHUY2Rf9aIG/kxG4Alg41eOJy58+mZvfuQsZRTquiOSC7/Rr1H3
   w==;
X-CSE-ConnectionGUID: TdWxGZwoSEywOxhK8mEqyA==
X-CSE-MsgGUID: aZsj8N8qTUGzzK4veNdUpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638195"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638195"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:40 -0700
X-CSE-ConnectionGUID: v5L9qm6wSiKSALPDeSb5jQ==
X-CSE-MsgGUID: hFENejD6TeW4yy5fwcenlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264919"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:38 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: Add a print for invalid link pair due to bandwidth
Date: Mon,  6 May 2024 10:04:10 +0300
Message-Id: <20240506095953.9e57ad898cf4.Id8edfd5e3774ea6475d5f4178ab7ea75a870ef95@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Yedidya Benshimol <yedidya.ben.shimol@intel.com>

When validating a link pair for EMLSR, add a print for invalid link
pair due to bandwidth

Signed-off-by: Yedidya Benshimol <yedidya.ben.shimol@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 31 ++++++++++++-------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index 21b5cc0413fe..b0568c74a15b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -691,12 +691,11 @@ s8 iwl_mvm_get_esr_rssi_thresh(struct iwl_mvm *mvm,
 }
 
 static u32
-iwl_mvm_esr_disallowed_with_link(struct ieee80211_vif *vif,
+iwl_mvm_esr_disallowed_with_link(struct iwl_mvm *mvm,
+				 struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *link,
 				 bool primary)
 {
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-	struct iwl_mvm *mvm = mvmvif->mvm;
 	struct wiphy *wiphy = mvm->hw->wiphy;
 	struct ieee80211_bss_conf *conf;
 	enum iwl_mvm_esr_state ret = 0;
@@ -735,20 +734,30 @@ bool iwl_mvm_mld_valid_link_pair(struct ieee80211_vif *vif,
 				 const struct iwl_mvm_link_sel_data *a,
 				 const struct iwl_mvm_link_sel_data *b)
 {
-	/* Per-link considerations */
-	if (iwl_mvm_esr_disallowed_with_link(vif, a, true) ||
-	    iwl_mvm_esr_disallowed_with_link(vif, b, false))
-		return false;
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	enum iwl_mvm_esr_state ret = 0;
 
-	if (a->chandef->width != b->chandef->width)
+	/* Per-link considerations */
+	if (iwl_mvm_esr_disallowed_with_link(mvm, vif, a, true) ||
+	    iwl_mvm_esr_disallowed_with_link(mvm, vif, b, false))
 		return false;
 
-	if (!(a->chandef->chan->band == NL80211_BAND_6GHZ &&
+	if (a->chandef->width != b->chandef->width ||
+	    !(a->chandef->chan->band == NL80211_BAND_6GHZ &&
 	      b->chandef->chan->band == NL80211_BAND_5GHZ))
+		ret |= IWL_MVM_ESR_EXIT_BANDWIDTH;
+
+	if (ret) {
+		IWL_DEBUG_INFO(mvm,
+			       "Links %d and %d are not a valid pair for EMLSR\n",
+			       a->link_id, b->link_id);
+		iwl_mvm_print_esr_state(mvm, ret);
 		return false;
+	}
+
+	return true;
 
-	/* Per-combination considerations */
-	return a->chandef->chan->band != b->chandef->chan->band;
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mvm_mld_valid_link_pair);
 
-- 
2.34.1


