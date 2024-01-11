Return-Path: <linux-wireless+bounces-1733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DD282B2C5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F009A1F229C6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B9555E60;
	Thu, 11 Jan 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atQdYq2a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58455E57
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989923; x=1736525923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LL2xQYWBW7O9ESTy9qkr0Utmieg36GN2c5jWyeBIJu4=;
  b=atQdYq2aeF00leyNgv/ATOiSYpGhfIt6ZeSFfx8TPKT8y9eqxuBOWDU/
   rwNtu7c6EsvZUxZPWgFbo5fQIPUd3SIjywuzW5yTnUyDFCTD2+1N1W5p3
   IcviCOXiiycWA4BiVMkaEJuxy1+U/wiT0naHUn3P6E1DJgKZ3GhctcKDU
   PCvXKcqFsDGG/+UhJzYmAmJZ2046YL8R22xlE6BNH0L6y6GpFmQh7IivU
   AZeG5wnZA3pHjOP9/u24UzpNOTbpxoYDzFt7E9a9Ub1u2X16sFdw8pTJ5
   Wim8J1RttTYUOXNn6NPeaqJP0jrsC+9wZdNiJSW1lloVXNUfn2yQ/tsgR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182616"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182616"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606776"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606776"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 7/8] wifi: mac80211: don't set bss_conf in parsing
Date: Thu, 11 Jan 2024 18:17:45 +0200
Message-Id: <20240111181514.c2da4bc515e8.I219ca40e15c0fbaff0e7c3e83ca4b92ecbc1f8ae@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When parsing 6 GHz operation, don't set the bss_conf
values. We only commit to that later in association,
so move the code there. Also clear it later.

While at it, handle IEEE80211_6GHZ_CTRL_REG_VLP_AP.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 27 +++++++++++++++++++++++++++
 net/mac80211/util.c | 21 +--------------------
 2 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5b1bc84760d5..99188bd84799 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3081,6 +3081,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	memset(ifmgd->tx_tspec, 0, sizeof(ifmgd->tx_tspec));
 	wiphy_delayed_work_cancel(local->hw.wiphy, &ifmgd->tx_tspec_wk);
 
+	sdata->vif.bss_conf.power_type = IEEE80211_REG_UNSET_AP;
 	sdata->vif.bss_conf.pwr_reduction = 0;
 	sdata->vif.bss_conf.tx_pwr_env_num = 0;
 	memset(sdata->vif.bss_conf.tx_pwr_env, 0,
@@ -4236,12 +4237,38 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 
 	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    elems->he_cap) {
+		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
 						  elems->he_cap_len,
 						  elems->he_6ghz_capa,
 						  link_sta);
 
+		he_6ghz_oper = ieee80211_he_6ghz_oper(elems->he_operation);
+
+		if (is_6ghz && he_6ghz_oper) {
+			switch (u8_get_bits(he_6ghz_oper->control,
+					    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+			case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+				bss_conf->power_type = IEEE80211_REG_LPI_AP;
+				break;
+			case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+				bss_conf->power_type = IEEE80211_REG_SP_AP;
+				break;
+			case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
+				bss_conf->power_type = IEEE80211_REG_VLP_AP;
+				break;
+			default:
+				bss_conf->power_type = IEEE80211_REG_UNSET_AP;
+				break;
+			}
+		} else if (is_6ghz) {
+			link_info(link,
+				  "HE 6 GHz operation missing (on %d MHz), expect issues\n",
+				  bss_conf->chandef.chan->center_freq);
+		}
+
 		bss_conf->he_support = link_sta->pub->he_cap.has_he;
 		if (elems->rsnx && elems->rsnx_len &&
 		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 643c54855be6..685b55a053f3 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3845,7 +3845,6 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	bool support_80_80, support_160, support_320;
 	u8 he_phy_cap, eht_phy_cap;
 	u32 freq;
@@ -3881,13 +3880,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		eht_oper = NULL;
 
 	he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
-
-	if (!he_6ghz_oper) {
-		sdata_info(sdata,
-			   "HE 6GHz operation missing (on %d MHz), expect issues\n",
-			   chandef->chan->center_freq);
+	if (!he_6ghz_oper)
 		return false;
-	}
 
 	/*
 	 * The EHT operation IE does not contain the primary channel so the
@@ -3898,19 +3892,6 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 					      NL80211_BAND_6GHZ);
 	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
 
-	switch (u8_get_bits(he_6ghz_oper->control,
-			    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-		bss_conf->power_type = IEEE80211_REG_LPI_AP;
-		break;
-	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-		bss_conf->power_type = IEEE80211_REG_SP_AP;
-		break;
-	default:
-		bss_conf->power_type = IEEE80211_REG_UNSET_AP;
-		break;
-	}
-
 	if (!eht_oper ||
 	    !(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
 		switch (u8_get_bits(he_6ghz_oper->control,
-- 
2.34.1


