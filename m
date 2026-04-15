Return-Path: <linux-wireless+bounces-34791-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANIoMviI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34791-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 358174046F5
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AD3C31056F6
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3291D33F582;
	Wed, 15 Apr 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pJSJFfRp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BAB330B09
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257137; cv=none; b=dWQi2Ok+oyUg/V/S6z44VkXZ14+Xc98Md4n5kuVS113zMIKCBOEp9Ace9fugsEbidAWM8AkGMN9ndGU77lRErQK4CWtQkhZIHOF2r12J+gB6CYVvEWag8zLln9kYb1zqc0v1ebImsKTObPwX5NDFBcefQ4qUlmwLQsQ69/nsBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257137; c=relaxed/simple;
	bh=jjYmx4iFGpJzAixva5ljkMLZwfF2QNQZOtnJDbve7bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RzfZ4ITUiXdrkzFWiHInmdNOONLw0EWGD+gfkQIUZVTwdtSlHWYoH6AKU7rHkFLQvmh10dlnmRrvKxq3VAVoy+zQ8c0+HKinRkNAXiqnB/qo+qJ43b0SQtzRnCIVeFnRWczJU9cIDaiKXigZm2tUQQZPvNlTVQFI3eEL9DlocW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pJSJFfRp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=A8JKMpBtZXlGFCDBPRp3+2U0imLa43s/Wn5aB9c38BQ=;
	t=1776257133; x=1777466733; b=pJSJFfRpgDMcHExTVjS8wxETZwbI7yo+BBGBaYGhFgJW22I
	PDyfUsyyNV0r6of/scXUxVGQCMRWmob02GCepOsO2z3a5XX8rwLSsxiGd0JtwQZbKrkwE/aia4N3b
	INVJCa+qz6EQ0EcteMo4sdRq8IlaW7LFNTSQRtoeDEP6bNbQitqVogz3SenYsVIDzTnz9hEl+XT/Q
	alEdyeYwj69Gq3N8mhCEPgx6CYiBrQZqRJyBmA2fVdsEhuu7g3l2maLZ+tNrmnj8CdLnHAYVPel2K
	cGLnJ3Gu9N609SLID7U+O9w2DXvEUcEk5Wh+g/pp2gsaRbQZzlMKyeuXIUN339XQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcZ-00000006OgW-12Lk;
	Wed, 15 Apr 2026 14:45:31 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 19/20] wifi: mac80211: clarify per-STA bandwidth handling
Date: Wed, 15 Apr 2026 14:42:17 +0200
Message-ID: <20260415144514.09ae71b74d5c.Ib59c2ac82e030559d1f7d462f06ba3488a090946@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415124514.284345-22-johannes@sipsolutions.net>
References: <20260415124514.284345-22-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34791-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,sta_opmode.bw:url,intel.com:email]
X-Rspamd-Queue-Id: 358174046F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

The per-STA bandwidth handling is completely confusing, given
the function names etc.

Move everything to sta_info.c and rename the functions to
accurately reflect what they return:
 - ieee80211_sta_bw_capability()
 - ieee80211_sta_current_bw() can return the appropriate
   bandwidth in the desired direction (a new enum)

At any given time, the bandwidth with which we expect to receive
frames from a station may differ from the bandwidth with which
we may transmit frames to the station; this will happen either
during RX OMI negotiation, or for a long time if the station
used an HT Notify Channel Width frame. We also implement the
(VHT) Operating Mode Notification as an asymmetric setting, even
if the spec would seem to imply it could be symmetric.

Also rename the 'cur_max_bandwidth' value to 'op_mode_bw' which
matches the 'op_mode_nss', indicating more clearly what it _is_
rather than how it's _used_. It's not quite precise (NSS is)
since it's also HT chanwidth notification, but that seems OK.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        |  11 +--
 net/mac80211/he.c          |   3 +-
 net/mac80211/ht.c          |   7 +-
 net/mac80211/ieee80211_i.h |   7 --
 net/mac80211/mlme.c        |   5 +-
 net/mac80211/sta_info.c    | 157 ++++++++++++++++++++++++++++++++++++-
 net/mac80211/sta_info.h    |  14 +++-
 net/mac80211/tdls.c        |   8 +-
 net/mac80211/vht.c         | 136 ++------------------------------
 9 files changed, 193 insertions(+), 155 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 13c0d080ef2a..ecc0123ed448 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -455,10 +455,10 @@ ieee80211_get_sta_bw(struct sta_info *sta, struct ieee80211_link_data *link)
 	 * We assume that TX/RX might be asymmetric (so e.g. VHT operating
 	 * mode notification changes what a STA wants to receive, but not
 	 * necessarily what it will transmit to us), and therefore use the
-	 * capabilities here. Calling it RX bandwidth capability is a bit
-	 * wrong though, since capabilities are in fact symmetric.
+	 * "from station" bandwidth here.
 	 */
-	width = ieee80211_sta_cap_rx_bw(link_sta, &link->conf->chanreq.oper);
+	width = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
+					 IEEE80211_STA_BW_RX_FROM_STA);
 
 	if (width == IEEE80211_STA_RX_BW_20 &&
 	    !link_sta->pub->ht_cap.ht_supported &&
@@ -693,8 +693,9 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 			else
 				new_chandef = &link_conf->chanreq.oper;
 
-			new_sta_bw = ieee80211_sta_cur_vht_bw(link_sta,
-							      new_chandef);
+			new_sta_bw = ieee80211_sta_current_bw(link_sta,
+							      new_chandef,
+							      IEEE80211_STA_BW_TX_TO_STA);
 
 			/* nothing change */
 			if (new_sta_bw == link_sta->pub->bandwidth)
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 1e8ce33bfe2e..b7d9e4cb6ba6 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -273,7 +273,8 @@ static void ieee80211_link_sta_rc_update_omi(struct ieee80211_link_data *link,
 	band = link->conf->chanreq.oper.chan->band;
 	sband = sdata->local->hw.wiphy->bands[band];
 
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
+	new_bw = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
+					  IEEE80211_STA_BW_TX_TO_STA);
 	if (link_sta->pub->bandwidth == new_bw)
 		return;
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 02ca6e1edc49..6285ac15c16c 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -600,9 +600,10 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 	else
 		max_bw = IEEE80211_STA_RX_BW_MAX;
 
-	/* set cur_max_bandwidth and recalc sta bw */
-	link_sta->cur_max_bandwidth = max_bw;
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
+	/* set op_mode_bw and recalc sta bw */
+	link_sta->op_mode_bw = max_bw;
+	new_bw = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
+					  IEEE80211_STA_BW_TX_TO_STA);
 
 	if (link_sta->pub->bandwidth == new_bw)
 		return;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6b72be762dbe..f1bab633697e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2299,13 +2299,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
 				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta);
-enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
-			struct cfg80211_chan_def *chandef);
-enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
-			 struct cfg80211_chan_def *chandef);
-
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_link_data *link,
 				 struct ieee80211_mgmt *mgmt);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6e0e5d3f5015..00b4beff0e43 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2571,8 +2571,9 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 			return;
 
 		link_sta->pub->bandwidth =
-			ieee80211_sta_cur_vht_bw(link_sta,
-						 &link->csa.chanreq.oper);
+			ieee80211_sta_current_bw(link_sta,
+						 &link->csa.chanreq.oper,
+						 IEEE80211_STA_BW_TX_TO_STA);
 		return;
 	}
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 508aad14bdf6..ec043d88a6a9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -572,13 +572,13 @@ static int sta_info_alloc_link(struct ieee80211_local *local,
 	link_info->rx_omi_bw_tx = IEEE80211_STA_RX_BW_MAX;
 	link_info->rx_omi_bw_staging = IEEE80211_STA_RX_BW_MAX;
 
-	link_info->cur_max_bandwidth = IEEE80211_STA_RX_BW_MAX;
+	link_info->op_mode_bw = IEEE80211_STA_RX_BW_MAX;
 
 	/*
 	 * Cause (a) warning(s) if IEEE80211_STA_RX_BW_MAX != 320
 	 * or if new values are added to the enum.
 	 */
-	switch (link_info->cur_max_bandwidth) {
+	switch (link_info->op_mode_bw) {
 	case IEEE80211_STA_RX_BW_20:
 	case IEEE80211_STA_RX_BW_40:
 	case IEEE80211_STA_RX_BW_80:
@@ -3519,7 +3519,9 @@ void ieee80211_sta_init_nss_bw_capa(struct link_sta_info *link_sta,
 	link_sta->capa_nss = ieee80211_sta_nss_capability(link_sta);
 	link_sta->pub->rx_nss = link_sta->capa_nss;
 
-	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta, chandef);
+	link_sta->pub->bandwidth =
+		ieee80211_sta_current_bw(link_sta, chandef,
+					 IEEE80211_STA_BW_TX_TO_STA);
 }
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
@@ -3554,3 +3556,152 @@ bool lockdep_sta_mutex_held(struct ieee80211_sta *pubsta)
 }
 EXPORT_SYMBOL(lockdep_sta_mutex_held);
 #endif
+
+/**
+ * ieee80211_sta_bw_capability - get STA's bandwidth capability
+ * @link_sta: the (link) STA to get the capability for
+ * @band: the band to get the capability on
+ *
+ * Return: the maximum bandwidth supported by the STA
+ */
+static enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_bw_capability(struct link_sta_info *link_sta,
+			    enum nl80211_band band)
+{
+	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
+	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->pub->eht_cap;
+	u32 cap_width;
+
+	if (he_cap->has_he) {
+		u8 info;
+
+		if (eht_cap->has_eht && band == NL80211_BAND_6GHZ) {
+			info = eht_cap->eht_cap_elem.phy_cap_info[0];
+
+			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+				return IEEE80211_STA_RX_BW_320;
+		}
+
+		info = he_cap->he_cap_elem.phy_cap_info[0];
+
+		if (band == NL80211_BAND_2GHZ) {
+			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
+				return IEEE80211_STA_RX_BW_40;
+			return IEEE80211_STA_RX_BW_20;
+		}
+
+		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G ||
+		    info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+			return IEEE80211_STA_RX_BW_160;
+
+		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
+			return IEEE80211_STA_RX_BW_80;
+
+		return IEEE80211_STA_RX_BW_20;
+	}
+
+	if (!vht_cap->vht_supported)
+		return link_sta->pub->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+				IEEE80211_STA_RX_BW_40 :
+				IEEE80211_STA_RX_BW_20;
+
+	cap_width = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
+
+	if (cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ ||
+	    cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
+		return IEEE80211_STA_RX_BW_160;
+
+	/*
+	 * If this is non-zero, then it does support 160 MHz after all,
+	 * in one form or the other. We don't distinguish here (or even
+	 * above) between 160 and 80+80 yet.
+	 */
+	if (vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
+		return IEEE80211_STA_RX_BW_160;
+
+	return IEEE80211_STA_RX_BW_80;
+}
+
+static enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_current_bw_rx_from_sta(struct link_sta_info *link_sta,
+				     struct cfg80211_chan_def *chandef)
+{
+	/*
+	 * Take RX OMI into account. The value "rx_omi_bw_rx" is what
+	 * we've indicated to the STA we can currently receive.
+	 *
+	 * This is needed since the RX OMI is done by us to save power,
+	 * requiring changing both our TX (rate control) and RX (chanctx),
+	 * which in turn needs to be done in the right order (stop TX
+	 * at a higher bandwidth first while reducing bandwidth, and
+	 * change the chanctx only after the peer accepts, etc.)
+	 */
+	return min(ieee80211_sta_bw_capability(link_sta, chandef->chan->band),
+		   link_sta->rx_omi_bw_rx);
+}
+
+static enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_current_bw_tx_to_sta(struct link_sta_info *link_sta,
+				   struct cfg80211_chan_def *chandef)
+{
+	struct sta_info *sta = link_sta->sta;
+	enum nl80211_chan_width bss_width;
+	enum ieee80211_sta_rx_bandwidth bw;
+	enum nl80211_band band;
+
+	bss_width = chandef->width;
+	band = chandef->chan->band;
+
+	bw = ieee80211_sta_bw_capability(link_sta, band);
+	bw = min(bw, link_sta->op_mode_bw);
+	/* also limit to RX OMI bandwidth we TX to the STA */
+	bw = min(bw, link_sta->rx_omi_bw_tx);
+
+	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
+	 * IEEE80211-2016 specification makes higher bandwidth operation
+	 * possible on the TDLS link if the peers have wider bandwidth
+	 * capability.
+	 *
+	 * However, in this case, and only if the TDLS peer is authorized,
+	 * limit to the tdls_chandef so that the configuration here isn't
+	 * wider than what's actually requested on the channel context.
+	 */
+	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
+	    test_sta_flag(sta, WLAN_STA_TDLS_WIDER_BW) &&
+	    test_sta_flag(sta, WLAN_STA_AUTHORIZED) &&
+	    sta->tdls_chandef.chan)
+		bw = min(bw, ieee80211_chan_width_to_rx_bw(sta->tdls_chandef.width));
+	else
+		bw = min(bw, ieee80211_chan_width_to_rx_bw(bss_width));
+
+	return bw;
+}
+
+/**
+ * ieee80211_sta_current_bw - get STA's current usable bandwidth
+ * @link_sta: the (link) STA to get the bandwidth for
+ * @chandef: the chandef for the channel the STA is on
+ * @direction: the direction (to or from STA)
+ *
+ * Return: the maximum bandwidth that the station can/may
+ *	(currently) use in the given direction
+ */
+enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_current_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef,
+			 enum ieee80211_sta_bw_direction direction)
+{
+	if (WARN_ON(!chandef))
+		return IEEE80211_STA_RX_BW_20;
+
+	switch (direction) {
+	case IEEE80211_STA_BW_RX_FROM_STA:
+		return ieee80211_sta_current_bw_rx_from_sta(link_sta, chandef);
+	case IEEE80211_STA_BW_TX_TO_STA:
+		return ieee80211_sta_current_bw_tx_to_sta(link_sta, chandef);
+	}
+
+	/* unreachable */
+	return IEEE80211_STA_RX_BW_20;
+}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index f0497d7d488a..39608a0abbb5 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -504,7 +504,7 @@ struct ieee80211_fragment_cache {
  * @status_stats.last_ack_signal: last ACK signal
  * @status_stats.ack_signal_filled: last ACK signal validity
  * @status_stats.avg_ack_signal: average ACK signal
- * @cur_max_bandwidth: dynamic bandwidth limit for the station,
+ * @op_mode_bw: dynamic bandwidth limit to transmit to the STA,
  *	taken from HT/VHT capabilities or VHT operating mode notification.
  *	Invalid for NAN since that is operating on multiple bands.
  * @rx_omi_bw_rx: RX OMI bandwidth restriction to apply for RX
@@ -558,7 +558,7 @@ struct link_sta_info {
 		u64 msdu[IEEE80211_NUM_TIDS + 1];
 	} tx_stats;
 
-	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
+	enum ieee80211_sta_rx_bandwidth op_mode_bw;
 	enum ieee80211_sta_rx_bandwidth rx_omi_bw_rx,
 					rx_omi_bw_tx,
 					rx_omi_bw_staging;
@@ -1005,6 +1005,16 @@ void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 
 void __ieee80211_sta_recalc_aggregates(struct sta_info *sta, u16 active_links);
 
+enum ieee80211_sta_bw_direction {
+	IEEE80211_STA_BW_RX_FROM_STA,
+	IEEE80211_STA_BW_TX_TO_STA,
+};
+
+enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_current_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef,
+			 enum ieee80211_sta_bw_direction direction);
+
 enum sta_stats_type {
 	STA_STATS_RATE_TYPE_INVALID = 0,
 	STA_STATS_RATE_TYPE_LEGACY,
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dcb5fe98ec55..ffd575a8d188 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -314,7 +314,8 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_chan_width max_width;
 	int i;
 
-	switch (ieee80211_sta_cap_rx_bw(&sta->deflink, &uc)) {
+	switch (ieee80211_sta_current_bw(&sta->deflink, &uc,
+					 IEEE80211_STA_BW_RX_FROM_STA)) {
 	case IEEE80211_STA_RX_BW_20:
 		max_width = NL80211_CHAN_WIDTH_20;
 		break;
@@ -1337,8 +1338,9 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 			enum ieee80211_sta_rx_bandwidth bw;
 
 			bw = ieee80211_chan_width_to_rx_bw(conf->def.width);
-			bw = min(bw, ieee80211_sta_cap_rx_bw(&sta->deflink,
-							     &conf->def));
+			bw = min(bw, ieee80211_sta_current_bw(&sta->deflink,
+							      &conf->def,
+							      IEEE80211_STA_BW_RX_FROM_STA));
 			if (bw != sta->sta.deflink.bandwidth) {
 				sta->sta.deflink.bandwidth = bw;
 				rate_control_rate_update(local, sband,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 3df5f6c3f777..92a4e0450593 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -331,129 +331,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	ieee80211_sta_recalc_aggregates(&link_sta->sta->sta);
 }
 
-/* FIXME: move this to some better location - parses HE/EHT now */
-static enum ieee80211_sta_rx_bandwidth
-_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta, enum nl80211_band band)
-{
-	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
-	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
-	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->pub->eht_cap;
-	u32 cap_width;
-
-	if (he_cap->has_he) {
-		u8 info;
-
-		if (eht_cap->has_eht && band == NL80211_BAND_6GHZ) {
-			info = eht_cap->eht_cap_elem.phy_cap_info[0];
-
-			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
-				return IEEE80211_STA_RX_BW_320;
-		}
-
-		info = he_cap->he_cap_elem.phy_cap_info[0];
-
-		if (band == NL80211_BAND_2GHZ) {
-			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
-				return IEEE80211_STA_RX_BW_40;
-			return IEEE80211_STA_RX_BW_20;
-		}
-
-		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G ||
-		    info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			return IEEE80211_STA_RX_BW_160;
-
-		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
-			return IEEE80211_STA_RX_BW_80;
-
-		return IEEE80211_STA_RX_BW_20;
-	}
-
-	if (!vht_cap->vht_supported)
-		return link_sta->pub->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
-				IEEE80211_STA_RX_BW_40 :
-				IEEE80211_STA_RX_BW_20;
-
-	cap_width = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-
-	if (cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ ||
-	    cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
-		return IEEE80211_STA_RX_BW_160;
-
-	/*
-	 * If this is non-zero, then it does support 160 MHz after all,
-	 * in one form or the other. We don't distinguish here (or even
-	 * above) between 160 and 80+80 yet.
-	 */
-	if (vht_cap->cap & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
-		return IEEE80211_STA_RX_BW_160;
-
-	return IEEE80211_STA_RX_BW_80;
-}
-
-enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
-			struct cfg80211_chan_def *chandef)
-{
-	/*
-	 * With RX OMI, also pretend that the STA's capability changed.
-	 * Of course this isn't really true, it didn't change, only our
-	 * RX capability was changed by notifying RX OMI to the STA.
-	 * The purpose, however, is to save power, and that requires
-	 * changing also transmissions to the AP and the chanctx. The
-	 * transmissions depend on link_sta->bandwidth which is set in
-	 * ieee80211_sta_cur_vht_bw() below, but the chanctx depends
-	 * on the result of this function which is also called by
-	 * ieee80211_sta_cur_vht_bw(), so we need to do that here as
-	 * well. This is sufficient for the steady state, but during
-	 * the transition we already need to change TX/RX separately,
-	 * so ieee80211_sta_cur_vht_bw() below applies the _tx one.
-	 */
-	return min(_ieee80211_sta_cap_rx_bw(link_sta, chandef->chan->band),
-		   link_sta->rx_omi_bw_rx);
-}
-
-/* FIXME: rename/move - this deals with everything not just VHT */
-enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
-			 struct cfg80211_chan_def *chandef)
-{
-	struct sta_info *sta = link_sta->sta;
-	enum nl80211_chan_width bss_width;
-	enum ieee80211_sta_rx_bandwidth bw;
-	enum nl80211_band band;
-
-	if (WARN_ON(!chandef))
-		return IEEE80211_STA_RX_BW_20;
-
-	bss_width = chandef->width;
-	band = chandef->chan->band;
-
-	/* intentionally do not take rx_bw_omi_rx into account */
-	bw = _ieee80211_sta_cap_rx_bw(link_sta, band);
-	bw = min(bw, link_sta->cur_max_bandwidth);
-	/* but do apply rx_omi_bw_tx */
-	bw = min(bw, link_sta->rx_omi_bw_tx);
-
-	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
-	 * IEEE80211-2016 specification makes higher bandwidth operation
-	 * possible on the TDLS link if the peers have wider bandwidth
-	 * capability.
-	 *
-	 * However, in this case, and only if the TDLS peer is authorized,
-	 * limit to the tdls_chandef so that the configuration here isn't
-	 * wider than what's actually requested on the channel context.
-	 */
-	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
-	    test_sta_flag(sta, WLAN_STA_TDLS_WIDER_BW) &&
-	    test_sta_flag(sta, WLAN_STA_AUTHORIZED) &&
-	    sta->tdls_chandef.chan)
-		bw = min(bw, ieee80211_chan_width_to_rx_bw(sta->tdls_chandef.width));
-	else
-		bw = min(bw, ieee80211_chan_width_to_rx_bw(bss_width));
-
-	return bw;
-}
-
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 				  struct link_sta_info *link_sta,
 				  u8 opmode, enum nl80211_band band)
@@ -496,25 +373,26 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
+		link_sta->op_mode_bw = IEEE80211_STA_RX_BW_20;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
+		link_sta->op_mode_bw = IEEE80211_STA_RX_BW_40;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ:
 		if (opmode & IEEE80211_OPMODE_NOTIF_BW_160_80P80)
-			link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			link_sta->op_mode_bw = IEEE80211_STA_RX_BW_160;
 		else
-			link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+			link_sta->op_mode_bw = IEEE80211_STA_RX_BW_80;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ:
 		/* legacy only, no longer used by newer spec */
-		link_sta->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		link_sta->op_mode_bw = IEEE80211_STA_RX_BW_160;
 		break;
 	}
 
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
+	new_bw = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
+					  IEEE80211_STA_BW_TX_TO_STA);
 	if (new_bw != link_sta->pub->bandwidth) {
 		link_sta->pub->bandwidth = new_bw;
 		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
-- 
2.53.0


