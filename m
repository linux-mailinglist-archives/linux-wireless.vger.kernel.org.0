Return-Path: <linux-wireless+bounces-30652-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F032D0F85F
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E48283035315
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C029AAF8;
	Sun, 11 Jan 2026 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmOdmob4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160F34D3B3
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768153182; cv=none; b=c4BhAkrvddvy2A9OIZ+Xcs+T9ATPP7lzH8Qms6DpIRRgTRI1bXMyTG1PtvsDjzgi+d91VMxsYI5Z7gde1THAOpcRQRYBd2Jt1Q2cIfuhmMQQf+M/NKKBE0bIJG5VJmSnOOxXaHwSQHhOqFb8ZvRotUPNl3yjlZf2fukkBLtY8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768153182; c=relaxed/simple;
	bh=G8luCaaHxlhxZ2h79Gjj4QjYUmAFF5fTboBkiMRxyQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUadwdoTj6/i4FMLh3yz27pLA+AT4Hbn10krBXl7bD7CeGsLeSub18TVo3OoxdeNO6HNNmmOrO7bJJCAzf00T5NdriMAOz4MFj37mTFKgx5Z/SrTeYxtToHPYn/k0KviwhQSWXTUjKPF4Pto8DHHhUV12kAkwMHryweQ7tetnzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmOdmob4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768153179; x=1799689179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G8luCaaHxlhxZ2h79Gjj4QjYUmAFF5fTboBkiMRxyQo=;
  b=gmOdmob4+5/TUhTLDH2WxaS8LONGq4wr9ybAFdltzCOPEKXtA3FcZS+8
   VCy7acgfpplhyj41wtqV93uzxSWcFN3OKgedT39oxTEsmyNPArAj1F66Q
   4R3sN4cbgs9PFQXnieRsXGGWM3LpWUtgulu0wWLH0IY5BMEP22Au1Bqkq
   B5OkHu8C6XcV2ilVpk0hDE+/hOHh8w1cCyht+4m4OuMcGMeYH8lAxmV2J
   cTG17Tx1j3IW2tai1xfFfo3j3UIxVRcndP/SSiwW62wjOnBEJdi22ZRKm
   SMDus0iCpKkviF4rW71+ukj0l10ZefH0wTBF1el9N9tirNYREBtS9pfwX
   w==;
X-CSE-ConnectionGUID: ZIwWyvHOQjGosrjmVGBIZw==
X-CSE-MsgGUID: xcDvwwYiR8SUzmry7rmLGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="69521084"
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="69521084"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:39 -0800
X-CSE-ConnectionGUID: CBONuH6aRx+K5IbZ6TOlCA==
X-CSE-MsgGUID: +wqX5jGvS2u1Qqy5cWxBdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,219,1763452800"; 
   d="scan'208";a="208393782"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 09:39:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Nidhish A N <nidhish.a.n@intel.com>
Subject: [PATCH iwlwifi-next 03/15] wifi: iwlwifi: mld: Fix primary link selection logic
Date: Sun, 11 Jan 2026 19:39:14 +0200
Message-Id: <20260111193638.38b2e14e3a20.Ie81a88dfff0c5d2becedabab8398702808f6b1bf@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
References: <20260111173926.2216629-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Nidhish A N <nidhish.a.n@intel.com>

When assigning emlsr.primary with emlsr.selected_primary
we are checking if BIT(mld_vif->emlsr.selected_links) are
a part of vif->active_links. This is incorrect as
emlsr.selected_links is a bitmap of possibly two selected links.
Therefore, performing the BIT() operation on it does not
yield any meaningful result and almost always leads to
incorrect primary link selection.

Additionally, we cannot rely on vif->active_links at this
stage of the link switch flow because it contains both the
removed links and also the newly added links.
For example, if we had selected links in the past (0x11)
and we now select links because of TTLM/debugfs (0x100),
vif->active_links will now be (0x111) and primary link
will be 0, while 0 is not even an active link. Thus,
we create our own bitmap of final active links.

Signed-off-by: Nidhish A N <nidhish.a.n@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 23 ++++++++++++-------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 8466345d7f21..411a2d56e5f0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1052,7 +1052,9 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
-	unsigned int n_active = iwl_mld_count_active_links(mld, vif);
+	struct iwl_mld_link *temp_mld_link;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	u16 final_active_links = 0;
 	int ret;
 
 	lockdep_assert_wiphy(mld->wiphy);
@@ -1060,10 +1062,7 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 	if (WARN_ON(!mld_link))
 		return -EINVAL;
 
-	/* if the assigned one was not counted yet, count it now */
 	if (!rcu_access_pointer(mld_link->chan_ctx)) {
-		n_active++;
-
 		/* Track addition of non-BSS link */
 		if (ieee80211_vif_type_p2p(vif) != NL80211_IFTYPE_STATION) {
 			ret = iwl_mld_emlsr_check_non_bss_block(mld, 1);
@@ -1084,17 +1083,25 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	rcu_assign_pointer(mld_link->chan_ctx, ctx);
 
-	if (n_active > 1) {
-		struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	/* We cannot rely on vif->active_links at this stage as it contains
+	 * both the removed links and the newly added links.
+	 * Therefore, we create our own bitmap of the final active links,
+	 * which does not include the removed links.
+	 */
+	for_each_mld_vif_valid_link(mld_vif, temp_mld_link) {
+		if (rcu_access_pointer(temp_mld_link->chan_ctx))
+			final_active_links |= BIT(link_id);
+	}
 
+	if (hweight16(final_active_links) > 1) {
 		/* Indicate to mac80211 that EML is enabled */
 		vif->driver_flags |= IEEE80211_VIF_EML_ACTIVE;
 		mld_vif->emlsr.last_entry_ts = jiffies;
 
-		if (vif->active_links & BIT(mld_vif->emlsr.selected_links))
+		if (final_active_links == mld_vif->emlsr.selected_links)
 			mld_vif->emlsr.primary = mld_vif->emlsr.selected_primary;
 		else
-			mld_vif->emlsr.primary = __ffs(vif->active_links);
+			mld_vif->emlsr.primary = __ffs(final_active_links);
 
 		iwl_dbg_tlv_time_point(&mld->fwrt, IWL_FW_INI_TIME_ESR_LINK_UP,
 				       NULL);
-- 
2.34.1


