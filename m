Return-Path: <linux-wireless+bounces-34780-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OmoOMOI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34780-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DAE4046B1
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BA6130DA15E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C00132548B;
	Wed, 15 Apr 2026 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EYvnhH3c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905DB32FA2B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257126; cv=none; b=cH5vFP4/LUgUazXfYcdTteecFt34UKHbgKxTx1mS+p5TrZQLVEeiG5hVkL+woDOttyzAdmwyoJ5baPNp28gORK3vhmD5Xm6ppmP6KjEPk91QvKffyXrCx2eSM1x38YEX8zkpNNve98eOWf5dyNfn7F78aZE8cwpn85/FZ2gVo7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257126; c=relaxed/simple;
	bh=/dYvb/4tiB4hRrsy3jvRs/pliqBVGnScjhxL7Y8KQRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAECG26L6lLwwWCnEgDrwr7/EUCqNjSBJcibRaF6mA0uBqQ1DvjhUsvnsLgH+T5VQgJWSCBco1Xe5NteSix5tdyeAGzTgGmv95jSss/i2fJWNHc0CtTr+oQGAPlhu2Hu8BShoemiomd9LRpHZEEQNMoPLi2I0b6FbL46UFdTtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EYvnhH3c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=EYYVvnm8OVtdIXAZODkiDQU2hnfdES0vcmc2zQ8LxUg=;
	t=1776257124; x=1777466724; b=EYvnhH3craTAztOdWR7CjtzD3efMGM9/W8IGyCzRbbWCZIO
	7bX9Y45KxoFbT5D2tDg9axTHIZsBd+2MzG3H+fuW9heOSMeiZ0f9l+6Y1n8Sirs3LCtn9nb1R6Fd9
	QwZo9y3i+DZ57Kt+hmY7BaJg7AfzJPclyozRhHBQ+3UqVcQcia6K7g41dL9e1to+DxwqjZiFjubU4
	GkPNeyF5CZV4TP0Ph2UhVh3gxOHWQSR714bSGaljfkaDq8/G4YcPdmTS5art4sJzBbUzolUqp4v32
	VSx4v3RO+sLDxsrxqrDVIg+40VT7vog6bSbJ46eq5j66Y6bXVpYfej7l+SOwkDHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcQ-00000006OgW-0gpS;
	Wed, 15 Apr 2026 14:45:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 08/20] wifi: mac80211: simplify ieee80211_sta_rx_bw_to_chan_width()
Date: Wed, 15 Apr 2026 14:42:06 +0200
Message-ID: <20260415144514.7b0be1059436.I573add4e3ed68b15f8b45122d053ac523afe4025@changeid>
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
	TAGGED_FROM(0.00)[bounces-34780-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,sipsolutions.net:dkim,sta_opmode.bw:url]
X-Rspamd-Queue-Id: 52DAE4046B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This function is only called for at least HT capable stations,
so doesn't need to differentiate 20/20_NOHT. Also, the check
for VHT 160 MHz support is wrong, since a station could have
support for both and the AP is using 80+80, but nothing cares
anyway, so we don't need that.

Simplify the function and move it to util.c since it now no
longer is related to VHT, and also doesn't need a station.

Also use the new function in ieee80211_get_sta_bw() for the
chandef calculations, it just needs to handle the 20/20-noht
separately; while at it fix that to handle HE stations.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 38 +++++++++++---------------------------
 net/mac80211/ht.c          |  3 +--
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/util.c        | 19 +++++++++++++++++++
 net/mac80211/vht.c         | 34 +---------------------------------
 5 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 5e93405d70a3..b3d810e3691f 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -460,33 +460,17 @@ ieee80211_get_sta_bw(struct sta_info *sta, struct ieee80211_link_data *link)
 	 */
 	width = _ieee80211_sta_cap_rx_bw(link_sta, &link->conf->chanreq.oper);
 
-	switch (width) {
-	case IEEE80211_STA_RX_BW_20:
-		if (link_sta->pub->ht_cap.ht_supported)
-			return NL80211_CHAN_WIDTH_20;
-		else
-			return NL80211_CHAN_WIDTH_20_NOHT;
-	case IEEE80211_STA_RX_BW_40:
-		return NL80211_CHAN_WIDTH_40;
-	case IEEE80211_STA_RX_BW_80:
-		return NL80211_CHAN_WIDTH_80;
-	case IEEE80211_STA_RX_BW_160:
-		/*
-		 * This applied for both 160 and 80+80. since we use
-		 * the returned value to consider degradation of
-		 * ctx->conf.min_def, we have to make sure to take
-		 * the bigger one (NL80211_CHAN_WIDTH_160).
-		 * Otherwise we might try degrading even when not
-		 * needed, as the max required sta_bw returned (80+80)
-		 * might be smaller than the configured bw (160).
-		 */
-		return NL80211_CHAN_WIDTH_160;
-	case IEEE80211_STA_RX_BW_320:
-		return NL80211_CHAN_WIDTH_320;
-	default:
-		WARN_ON(1);
-		return NL80211_CHAN_WIDTH_20;
-	}
+	if (width == IEEE80211_STA_RX_BW_20 &&
+	    !link_sta->pub->ht_cap.ht_supported &&
+	    !link_sta->pub->he_cap.has_he)
+		return NL80211_CHAN_WIDTH_20_NOHT;
+
+	/*
+	 * This returns 160 for both 160 and 80+80. Since we use
+	 * the returned value to consider narrowing for
+	 * ctx->conf.min_def, that's correct and necessary.
+	 */
+	return ieee80211_sta_rx_bw_to_chan_width(width);
 }
 
 static enum nl80211_chan_width
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 7d587f968a7f..3775d57d6c22 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -642,8 +642,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 
 	link_sta->pub->bandwidth = new_bw;
 	sband = local->hw.wiphy->bands[band];
-	sta_opmode.bw =
-		ieee80211_sta_rx_bw_to_chan_width(link_sta);
+	sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
 	sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
 
 	rate_control_rate_update(local, sband, link_sta,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 029600b3b7c0..3ab8368acaf9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2329,8 +2329,6 @@ void ieee80211_apply_vhtcap_overrides(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_sta_vht_cap *vht_cap);
 void ieee80211_get_vht_mask_from_cap(__le16 vht_cap,
 				     u16 vht_mask[NL80211_VHT_NSS_MAX]);
-enum nl80211_chan_width
-ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *sta);
 
 /* HE */
 void
@@ -2716,6 +2714,9 @@ void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
 
+enum nl80211_chan_width
+ieee80211_sta_rx_bw_to_chan_width(enum ieee80211_sta_rx_bandwidth bw);
+
 /* element building in SKBs */
 int ieee80211_put_srates_elem(struct sk_buff *skb,
 			      const struct ieee80211_supported_band *sband,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index b093bc203c81..a2ca8fd0c78a 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3840,6 +3840,25 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 	WARN_ON_ONCE(!cfg80211_chandef_valid(c));
 }
 
+enum nl80211_chan_width
+ieee80211_sta_rx_bw_to_chan_width(enum ieee80211_sta_rx_bandwidth bw)
+{
+	switch (bw) {
+	case IEEE80211_STA_RX_BW_20:
+		return NL80211_CHAN_WIDTH_20;
+	case IEEE80211_STA_RX_BW_40:
+		return NL80211_CHAN_WIDTH_40;
+	case IEEE80211_STA_RX_BW_80:
+		return NL80211_CHAN_WIDTH_80;
+	case IEEE80211_STA_RX_BW_160:
+		return NL80211_CHAN_WIDTH_160;
+	case IEEE80211_STA_RX_BW_320:
+		return NL80211_CHAN_WIDTH_320;
+	default:
+		return NL80211_CHAN_WIDTH_20;
+	}
+}
+
 int ieee80211_send_action_csa(struct ieee80211_sub_if_data *sdata,
 			      struct cfg80211_csa_settings *csa_settings)
 {
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c25190bc7c5c..17f3f281abe1 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -433,38 +433,6 @@ _ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 		   link_sta->rx_omi_bw_rx);
 }
 
-enum nl80211_chan_width
-ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *link_sta)
-{
-	enum ieee80211_sta_rx_bandwidth cur_bw =
-		link_sta->pub->bandwidth;
-	struct ieee80211_sta_vht_cap *vht_cap =
-		&link_sta->pub->vht_cap;
-	u32 cap_width;
-
-	switch (cur_bw) {
-	case IEEE80211_STA_RX_BW_20:
-		if (!link_sta->pub->ht_cap.ht_supported)
-			return NL80211_CHAN_WIDTH_20_NOHT;
-		else
-			return NL80211_CHAN_WIDTH_20;
-	case IEEE80211_STA_RX_BW_40:
-		return NL80211_CHAN_WIDTH_40;
-	case IEEE80211_STA_RX_BW_80:
-		return NL80211_CHAN_WIDTH_80;
-	case IEEE80211_STA_RX_BW_160:
-		cap_width =
-			vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-
-		if (cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
-			return NL80211_CHAN_WIDTH_160;
-
-		return NL80211_CHAN_WIDTH_80P80;
-	default:
-		return NL80211_CHAN_WIDTH_20;
-	}
-}
-
 /* FIXME: rename/move - this deals with everything not just VHT */
 enum ieee80211_sta_rx_bandwidth
 _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
@@ -671,7 +639,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
 	if (new_bw != link_sta->pub->bandwidth) {
 		link_sta->pub->bandwidth = new_bw;
-		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(link_sta);
+		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
 		changed |= IEEE80211_RC_BW_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_MAX_BW_CHANGED;
 	}
-- 
2.53.0


