Return-Path: <linux-wireless+bounces-20069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 790F6A57F37
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD2916B39A
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678F20F06D;
	Sat,  8 Mar 2025 22:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNmWinWe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189820DD5B
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471312; cv=none; b=ny7mtWNp4EYZ63LVYS2hv2XfjeaedWM4Zd9lY5NwtSD19JD2bgksa+tDEgzJw1a08kJ1HYegrQLvZ1aEKok/2Q9Xkg/mj3+cgFQN1CDMArur3APNadfbgi+yQuNUQwxL9BICVSla6VY56cVVh3D5NZT023xBu8EBgx6VVg/hrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471312; c=relaxed/simple;
	bh=3w+5rfCCF40uT97oCKOkPAsApigFMEflvsBdCnyyoU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T1DkKpg9KdioQOM4/kUmFi3p4cXuFe6RORVCfjcTg+IjNRmKofL5fZBsEhJ62ikxmhrroFtrbh1/OZT7qNxWZYLTOSmQWm36R28gy1b//0ciCBHcOWyF1T9WCujx7lzRhfy8t7DQMt/poxz9E40evqHjoXDIIDY80Qt27FX76rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNmWinWe; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471311; x=1773007311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3w+5rfCCF40uT97oCKOkPAsApigFMEflvsBdCnyyoU8=;
  b=WNmWinWelYyKI9xf9cLebC+TVokuJCMqFfydsWrABq3R8Sifz+x6qzq4
   uBjef0P3AC7IsYWllnPRH1LHYcJC25oPLDS8CEWG6NHDK1CAGAZrUfIji
   qwUYjxK4PeFO4llj7JA7IEwJpC/XKvxIZirmQwK+gBEhGuXeouZRiBB6h
   aWiT9VpOT6Axqu2BralJxRumhHyEfe47GbXZyMolnNe6rrijneaje5qKh
   fkccG1z0fy51YyE9CL3TDm4JW7zsUIQLWpam6OZrtMPaC0XJfVFblo+hP
   YuhsPtJXZRgtQ7pTIaLNsx8pR+N1gm2/Z6xZFduMCmO/rSazNkDuPdX4r
   g==;
X-CSE-ConnectionGUID: NUDfObUuTiOZnBcaFs4xaA==
X-CSE-MsgGUID: gq2ADTJxSzimlXqpX1WKuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540641"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540641"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:51 -0800
X-CSE-ConnectionGUID: bdieFaznRs6CMhnshe3RKw==
X-CSE-MsgGUID: bHUZaiIVSG29VX49E8zvIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352138"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 09/15] wifi: iwlwifi: mld: enable OMI bandwidth reduction on 6 GHz
Date: Sun,  9 Mar 2025 00:01:19 +0200
Message-Id: <20250308235203.2706cbd0b100.Ic34636b1aee81a140eb690fca8139909a58f8e8b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Due to the iwl_mld_get_chandef_from_chanctx() logic, even after
the OMI handshake to reduce bandwidth the driver wouldn't apply
that to the PHY context, since it always uses the normal, not
the reduced, configuration on 6 GHz (not strictly always, but
OMI will only apply if the original bandwidth is > 80 MHz.) Fix
this by making that selection contingent on AP mode. Refactor
the code a bit to also make it clearer why the min_def isn't
used in that case (for FILS.)

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  | 49 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |  3 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  2 +-
 5 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index f6d482817f1b..1db69aee4e9f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -67,7 +67,7 @@ static void iwl_mld_fill_rates(struct iwl_mld *mld,
 			       __le32 *cck_rates, __le32 *ofdm_rates)
 {
 	struct cfg80211_chan_def *chandef =
-		iwl_mld_get_chandef_from_chanctx(chan_ctx);
+		iwl_mld_get_chandef_from_chanctx(mld, chan_ctx);
 	struct ieee80211_supported_band *sband =
 		mld->hw->wiphy->bands[chandef->chan->band];
 	unsigned long basic = link->basic_rates;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 27ef41d69479..91e201fde72a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -840,7 +840,7 @@ int iwl_mld_add_chanctx(struct ieee80211_hw *hw,
 
 	phy->mld = mld;
 	phy->fw_id = fw_id;
-	phy->chandef = *iwl_mld_get_chandef_from_chanctx(ctx);
+	phy->chandef = *iwl_mld_get_chandef_from_chanctx(mld, ctx);
 
 	ret = iwl_mld_phy_fw_action(mld, ctx, FW_CTXT_ACTION_ADD);
 	if (ret) {
@@ -872,7 +872,7 @@ void iwl_mld_change_chanctx(struct ieee80211_hw *hw,
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	struct iwl_mld_phy *phy = iwl_mld_phy_from_mac80211(ctx);
 	struct cfg80211_chan_def *chandef =
-		iwl_mld_get_chandef_from_chanctx(ctx);
+		iwl_mld_get_chandef_from_chanctx(mld, ctx);
 
 	/* We don't care about these */
 	if (!(changed & ~(IEEE80211_CHANCTX_CHANGE_RX_CHAINS |
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.c b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
index c38f101628de..2fbc8090088b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.c
@@ -22,16 +22,55 @@ int iwl_mld_allocate_fw_phy_id(struct iwl_mld *mld)
 }
 EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_allocate_fw_phy_id);
 
-struct cfg80211_chan_def *
-iwl_mld_get_chandef_from_chanctx(struct ieee80211_chanctx_conf *ctx)
+struct iwl_mld_chanctx_usage_data {
+	struct iwl_mld *mld;
+	struct ieee80211_chanctx_conf *ctx;
+	bool use_def;
+};
+
+static bool iwl_mld_chanctx_fils_enabled(struct ieee80211_vif *vif,
+					 struct ieee80211_chanctx_conf *ctx)
 {
-	bool use_def = cfg80211_channel_is_psc(ctx->def.chan) ||
+	if (vif->type != NL80211_IFTYPE_AP)
+		return false;
+
+	return cfg80211_channel_is_psc(ctx->def.chan) ||
 		(ctx->def.chan->band == NL80211_BAND_6GHZ &&
 		 ctx->def.width >= NL80211_CHAN_WIDTH_80);
+}
+
+static void iwl_mld_chanctx_usage_iter(void *_data, u8 *mac,
+				       struct ieee80211_vif *vif)
+{
+	struct iwl_mld_chanctx_usage_data *data = _data;
+	struct ieee80211_bss_conf *link_conf;
+	int link_id;
+
+	for_each_vif_active_link(vif, link_conf, link_id) {
+		if (rcu_access_pointer(link_conf->chanctx_conf) != data->ctx)
+			continue;
+
+		if (iwl_mld_chanctx_fils_enabled(vif, data->ctx))
+			data->use_def = true;
+	}
+}
+
+struct cfg80211_chan_def *
+iwl_mld_get_chandef_from_chanctx(struct iwl_mld *mld,
+				 struct ieee80211_chanctx_conf *ctx)
+{
+	struct iwl_mld_chanctx_usage_data data = {
+		.mld = mld,
+		.ctx = ctx,
+	};
+
+	ieee80211_iterate_active_interfaces_mtx(mld->hw,
+						IEEE80211_IFACE_ITER_NORMAL,
+						iwl_mld_chanctx_usage_iter,
+						&data);
 
-	return use_def ? &ctx->def : &ctx->min_def;
+	return data.use_def ? &ctx->def : &ctx->min_def;
 }
-EXPORT_SYMBOL_IF_IWLWIFI_KUNIT(iwl_mld_get_chandef_from_chanctx);
 
 static u8
 iwl_mld_nl80211_width_to_fw(enum nl80211_chan_width width)
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/phy.h b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
index 357bc9fe9624..2212a89321b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/phy.h
@@ -48,7 +48,8 @@ int iwl_mld_allocate_fw_phy_id(struct iwl_mld *mld);
 int iwl_mld_phy_fw_action(struct iwl_mld *mld,
 			  struct ieee80211_chanctx_conf *ctx, u32 action);
 struct cfg80211_chan_def *
-iwl_mld_get_chandef_from_chanctx(struct ieee80211_chanctx_conf *ctx);
+iwl_mld_get_chandef_from_chanctx(struct iwl_mld *mld,
+				 struct ieee80211_chanctx_conf *ctx);
 u8 iwl_mld_get_fw_ctrl_pos(const struct cfg80211_chan_def *chandef);
 
 #endif /* __iwl_mld_phy_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
index b6049918b5db..6331cd91cdf6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -169,7 +169,7 @@ iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def)
 
 	phy->fw_id = fw_id;
 	phy->mld = mld;
-	phy->chandef = *iwl_mld_get_chandef_from_chanctx(ctx);
+	phy->chandef = *def;
 
 	return ctx;
 }
-- 
2.34.1


