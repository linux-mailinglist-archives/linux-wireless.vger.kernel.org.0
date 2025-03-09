Return-Path: <linux-wireless+bounces-20085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D6CA580AF
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 06:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8D587A692F
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Mar 2025 05:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6B715E5DC;
	Sun,  9 Mar 2025 05:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="euYBeDjH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC7146A72
	for <linux-wireless@vger.kernel.org>; Sun,  9 Mar 2025 05:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741498642; cv=none; b=rqX4glWN/Q1Q30/nmp3rFGj38IOQEvm+nhOp6nxP6IuiU8JZu/tv4rf4ODcaJ9qk4q+LygwfJrVyOGHksPt7pQfoRWMC9wLSvZFB8C42ZOjgkLkxfm7b+93kKGQFplluFxiPR92gC5C1kJ4YLGTDzq1jt3BiUv+EkDegcWHhYko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741498642; c=relaxed/simple;
	bh=3w+5rfCCF40uT97oCKOkPAsApigFMEflvsBdCnyyoU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IHSbwTewTB4UfsUpVhVKNb3PhFAcCa8d5s5fEiI+oshR/F9uq1ThxTCalcgkEnSVTo+B2ah3cGvEM7DVCVAWZEh/mhBU4gQud8n/cyMFf3KUmIU9b0SbeVPPZhTld+qO914BkHTA6GBxKeeYUrxcmGaHe3ZSDeOKXrU+6ppocVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=euYBeDjH; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741498640; x=1773034640;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3w+5rfCCF40uT97oCKOkPAsApigFMEflvsBdCnyyoU8=;
  b=euYBeDjHvBBBD3cKXxUkuIWbfbg/w4uGPwCvx4z4UPCfNGz83HzxO5nN
   sI5CowyRL67PkYabJc49NjMOPPKiItArci9Bgb/KTirSDnJaynLQIcIFd
   xgj2Vl5vkIZoBwbluA63Ebo7SsVVrprexuRMwIZ3HjeYLy7XrPfByWmP0
   JTaESJ4CGG+mMOdZgkgrCfrjnYO816wB9ijSM1oQ6TE5uXlh/5dxT1dSy
   4ZAZCHQdm5F9zdeuFa2/XAujR7nRz2qbGU5DJkclXWl/bbNRtI7oxEGwp
   2k/CH5O34yBfA8oTHwbixxD0nGZx9gF4Kd3hJ7iyEJe9N4EHxcC0MpLp5
   g==;
X-CSE-ConnectionGUID: Y/tALd2UTWOpcpUmyeAUbw==
X-CSE-MsgGUID: Rg2HSLGGT4y9pPxxWGirbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="41671701"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="41671701"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:20 -0800
X-CSE-ConnectionGUID: Uvsnv8O8RFOTvHtP9L8vOA==
X-CSE-MsgGUID: VlzvARpZQZaGcwXUOpdqDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="150470643"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 21:37:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next 09/15] wifi: iwlwifi: mld: enable OMI bandwidth reduction on 6 GHz
Date: Sun,  9 Mar 2025 07:36:47 +0200
Message-Id: <20250309073442.2706cbd0b100.Ic34636b1aee81a140eb690fca8139909a58f8e8b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
References: <20250309053653.2697525-1-miriam.rachel.korenblit@intel.com>
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


