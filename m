Return-Path: <linux-wireless+bounces-2678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D19884129D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 321711C2396C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920F313BEBF;
	Mon, 29 Jan 2024 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="GnStffR6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8504E76026
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553678; cv=none; b=sN+0mi2oSdZCsNsQGX0GCTkgUNec3Np7NUWsZEcT5F5TN3IOl0q69CWQZ7HVrYd8ydFt7SZ1ayY5YB0kJ5knno+53mzKX+/V3BElOT2RD2sLfBzr0m27mAJm6RfD0ksr8cEfspkQTtT1pbX5+Xmu/XT1h0kYce+oYNTdf0Xe4JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553678; c=relaxed/simple;
	bh=XJ7y/o6eu+AWuGkKn8jJuBeQb4fyHDaU26dZ9cwC5io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJ+6kFkyrN1BuYGk0sjVYyf368wmh4dyPlD/CmwWIZjzInMmn+gKLTBm2tBUsAD9cCxgOBs0DbsWOsMyhG01aX4Z/woc1ySqSIWouktR3BpLmWcUTN4qboLuRQzYCLaSvIurzIyfGdjPW64Fm/hmNp86eNfdKaPZeymUElTC/e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=GnStffR6; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=AzVj86QtEoGzhravpz8pimz0J7wx16icXtoylY7PnTo=;
	t=1706553676; x=1707763276; b=GnStffR6DMstl/VqqAL0GyakhnW5f0vkOXkGD2H+LLIItTy
	uzXKeKY2iUFrQipfmso+8sx2PquXLgC9bBKonAEzRsIomeWEV5TkeEbLz2A4e0mN7d3c0ID1UKf2J
	NjV5hHpFms6Orgsj8HIum7EozApGD6RPjugvbmNEOaS1av+CS3A5Y8y7xiNqt6fEiOqMxyPgOvoLo
	8u63und8ju1D0ukg2k40VFf2tu8/fS30SLMmhHS+9VgVxrsFebTMkt2BhhvEp5e/a6+nxsGprSSMS
	hpkjAnDmDyfYAudac1saVDMZIgns1yoxwHLtmy2/QWEqzKIlkLmr1C1IshdHdxAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZF-00000004z9N-3adB;
	Mon, 29 Jan 2024 19:41:14 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 03/15] wifi: mac80211: clean up HE 6 GHz and EHT chandef parsing
Date: Mon, 29 Jan 2024 19:34:37 +0100
Message-ID: <20240129194108.d06f85082e29.I47e68ed3d97b0a2f4ee61e5d8abfcefc8a5b9c08@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129184108.49639-17-johannes@sipsolutions.net>
References: <20240129184108.49639-17-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the code we currently check for support 80+80, 160
and 320 channel widths, but really the way this should
be (and is otherwise) handled is that we compute the
highest channel bandwidth given there, and then cut it
down to what we support. This is also needed for wider
bandwidth OFDMA support.

Change the code to remove this limitation and always
parse the highest possible channel width.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |   3 +-
 net/mac80211/mesh.c        |   3 +-
 net/mac80211/mlme.c        |   8 ++-
 net/mac80211/spectmgmt.c   |   4 +-
 net/mac80211/util.c        | 104 ++++++++-----------------------------
 5 files changed, 29 insertions(+), 93 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 112029f5a7df..29294cf88d39 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2512,9 +2512,8 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
 void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation_info *info,
-				bool support_160, bool support_320,
 				struct cfg80211_chan_def *chandef);
-bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
+bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_local *local,
 				    const struct ieee80211_he_operation *he_oper,
 				    const struct ieee80211_eht_operation *eht_oper,
 				    struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 6b48914b39fd..60dc453acb5a 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -107,7 +107,8 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 				   ie->vht_operation, ie->ht_operation,
 				   &sta_chan_def);
-	ieee80211_chandef_he_6ghz_oper(sdata, ie->he_operation, ie->eht_operation,
+	ieee80211_chandef_he_6ghz_oper(sdata->local, ie->he_operation,
+				       ie->eht_operation,
 				       &sta_chan_def);
 
 	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chandef,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 9de4723b7751..d51b978c6ff0 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -116,7 +116,7 @@ ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
 
 	/* set 160/320 supported to get the full AP definition */
 	ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
-				   true, true, &ap_chandef);
+				   &ap_chandef);
 	ap_center_freq = ap_chandef.center_freq1;
 	ap_bw = 20 * BIT(u8_get_bits(info->control,
 				     IEEE80211_EHT_OPER_CHAN_WIDTH));
@@ -280,7 +280,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			mode = IEEE80211_CONN_MODE_HE;
 		}
 
-		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper,
+		if (!ieee80211_chandef_he_6ghz_oper(sdata->local, he_oper,
 						    eht_oper, chandef)) {
 			sdata_info(sdata, "bad HE/EHT 6 GHz operation\n");
 			return IEEE80211_CONN_MODE_LEGACY;
@@ -394,9 +394,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		struct cfg80211_chan_def eht_chandef = *chandef;
 
 		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
-					   eht_chandef.width ==
-					   NL80211_CHAN_WIDTH_160,
-					   false, &eht_chandef);
+					   &eht_chandef);
 
 		if (!cfg80211_chandef_valid(&eht_chandef)) {
 			sdata_info(sdata,
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index d8c7b3e16eb7..51efc9bc8168 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -139,9 +139,7 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		/* start with the CSA one */
 		new_vht_chandef = csa_ie->chandef;
 		/* and update the width accordingly */
-		/* FIXME: support 160/320 */
-		ieee80211_chandef_eht_oper(&bwi->info, true, true,
-					   &new_vht_chandef);
+		ieee80211_chandef_eht_oper(&bwi->info, &new_vht_chandef);
 	} else if (wide_bw_chansw_ie) {
 		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
 		struct ieee80211_vht_operation vht_oper = {
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 1d504c8e6bfc..1a2522e699d4 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3841,7 +3841,6 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 }
 
 void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation_info *info,
-				bool support_160, bool support_320,
 				struct cfg80211_chan_def *chandef)
 {
 	chandef->center_freq1 =
@@ -3860,80 +3859,34 @@ void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation_info *info,
 		chandef->width = NL80211_CHAN_WIDTH_80;
 		break;
 	case IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ:
-		if (support_160) {
-			chandef->width = NL80211_CHAN_WIDTH_160;
-			chandef->center_freq1 =
-				ieee80211_channel_to_frequency(info->ccfs1,
-							       chandef->chan->band);
-		} else {
-			chandef->width = NL80211_CHAN_WIDTH_80;
-		}
+		chandef->width = NL80211_CHAN_WIDTH_160;
+		chandef->center_freq1 =
+			ieee80211_channel_to_frequency(info->ccfs1,
+						       chandef->chan->band);
 		break;
 	case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
-		if (support_320) {
-			chandef->width = NL80211_CHAN_WIDTH_320;
-			chandef->center_freq1 =
-				ieee80211_channel_to_frequency(info->ccfs1,
-							       chandef->chan->band);
-		} else if (support_160) {
-			chandef->width = NL80211_CHAN_WIDTH_160;
-		} else {
-			chandef->width = NL80211_CHAN_WIDTH_80;
-
-			if (chandef->center_freq1 > chandef->chan->center_freq)
-				chandef->center_freq1 -= 40;
-			else
-				chandef->center_freq1 += 40;
-		}
+		chandef->width = NL80211_CHAN_WIDTH_320;
+		chandef->center_freq1 =
+			ieee80211_channel_to_frequency(info->ccfs1,
+						       chandef->chan->band);
 		break;
 	}
 }
 
-bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
+bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_local *local,
 				    const struct ieee80211_he_operation *he_oper,
 				    const struct ieee80211_eht_operation *eht_oper,
 				    struct cfg80211_chan_def *chandef)
 {
-	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_supported_band *sband;
-	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
-	const struct ieee80211_sta_he_cap *he_cap;
-	const struct ieee80211_sta_eht_cap *eht_cap;
 	struct cfg80211_chan_def he_chandef = *chandef;
 	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
-	bool support_80_80, support_160, support_320;
-	u8 he_phy_cap, eht_phy_cap;
 	u32 freq;
 
 	if (chandef->chan->band != NL80211_BAND_6GHZ)
 		return true;
 
-	sband = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
-
-	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
-	if (!he_cap) {
-		sdata_info(sdata, "Missing iftype sband data/HE cap");
+	if (!he_oper)
 		return false;
-	}
-
-	he_phy_cap = he_cap->he_cap_elem.phy_cap_info[0];
-	support_160 =
-		he_phy_cap &
-		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-	support_80_80 =
-		he_phy_cap &
-		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
-
-	if (!he_oper) {
-		sdata_info(sdata,
-			   "HE is not advertised on (on %d MHz), expect issues\n",
-			   chandef->chan->center_freq);
-		return false;
-	}
-
-	eht_cap = ieee80211_get_eht_iftype_cap(sband, iftype);
-	if (!eht_cap)
-		eht_oper = NULL;
 
 	he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
 	if (!he_6ghz_oper)
@@ -3946,7 +3899,10 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 	 */
 	freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
 					      NL80211_BAND_6GHZ);
-	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
+	he_chandef.chan = ieee80211_get_channel(local->hw.wiphy, freq);
+
+	if (!he_chandef.chan)
+		return false;
 
 	if (!eht_oper ||
 	    !(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
@@ -3965,13 +3921,10 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 			he_chandef.width = NL80211_CHAN_WIDTH_80;
 			if (!he_6ghz_oper->ccfs1)
 				break;
-			if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8) {
-				if (support_160)
-					he_chandef.width = NL80211_CHAN_WIDTH_160;
-			} else {
-				if (support_80_80)
-					he_chandef.width = NL80211_CHAN_WIDTH_80P80;
-			}
+			if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8)
+				he_chandef.width = NL80211_CHAN_WIDTH_160;
+			else
+				he_chandef.width = NL80211_CHAN_WIDTH_80P80;
 			break;
 		}
 
@@ -3983,30 +3936,17 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 			he_chandef.center_freq1 =
 				ieee80211_channel_to_frequency(he_6ghz_oper->ccfs0,
 							       NL80211_BAND_6GHZ);
-			if (support_80_80 || support_160)
-				he_chandef.center_freq2 =
-					ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
-								       NL80211_BAND_6GHZ);
+			he_chandef.center_freq2 =
+				ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
+							       NL80211_BAND_6GHZ);
 		}
 	} else {
-		eht_phy_cap = eht_cap->eht_cap_elem.phy_cap_info[0];
-		support_320 =
-			eht_phy_cap & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
-
 		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
-					   support_160, support_320,
 					   &he_chandef);
 	}
 
-	if (!cfg80211_chandef_valid(&he_chandef)) {
-		sdata_info(sdata,
-			   "HE 6GHz operation resulted in invalid chandef: %d MHz/%d/%d MHz/%d MHz\n",
-			   he_chandef.chan ? he_chandef.chan->center_freq : 0,
-			   he_chandef.width,
-			   he_chandef.center_freq1,
-			   he_chandef.center_freq2);
+	if (!cfg80211_chandef_valid(&he_chandef))
 		return false;
-	}
 
 	*chandef = he_chandef;
 
-- 
2.43.0


