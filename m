Return-Path: <linux-wireless+bounces-34047-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMoGEi1Qxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34047-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD87C341D89
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F89E30A8F37
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEC53DDDC8;
	Fri, 27 Mar 2026 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aw6+QL6X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225863DD51D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604235; cv=none; b=mHtiifurwC/m2mXwJgQ2n9V/jKjO5dwaluLfvGeblRviWNdXfpAYwzc/r/y61+k3SfqS4CpGvcOiSfSAHKBLYG3sAVPseKUWMcpmKIPMt+DUWNEp22zH5eS8Bm7QV2HBoKjLlaOCw5n0ZK4RTRfMEsGFeSHxYETfFRut2BFpyWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604235; c=relaxed/simple;
	bh=GbXpiTsZvubnJ3wH6Vog283fjLEdm23qXn6YzyuT1IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPrXEyK+yPqWlai5h9CSqjl5t/nRhs9tT53M/7pT7267m3Opa07xNQSf7P20meNaxdfJNsdk45eyza9xlw2ZXi/Ptoug/1bK82L7UxXNi9Dmz39wqjQd/K8y6jLErjy8UGE13gh1sQyTDt58h3ojl627uPabXIrosqlQ9IXHzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aw6+QL6X; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OKg/AJe3PBOZtq+C658OViEexgfXN+J1A+d7rIyuRO0=;
	t=1774604234; x=1775813834; b=aw6+QL6X7PXenqltdmYfipdds0C0tuRf2cihhus3gxzuImW
	RdfVZj9JuMBrq5wgWwLtgorTkVGTnN23NtqKrFPrTm6olHds9VTiSIE2lQ7kMOv71LqtBcoc6vysx
	uLmQPG8DI0/ED01xmyQPApMA9cZB4U3ebC6x5FL9PvHFRTnbxmC7Lj6tQMHbnItXUvlEiBpy0QH4L
	ksu6cOMdWnB+iF/rfyvOZSheg8PosRifSbGi6IkBD3BzOprXHiZRHUnTNcTpYmm9kQBo3KYhaxrVs
	cU0+0Su0S+wuYE3oXF/sajw0OPOEnODTwBY4ZZSo5RP1CYtOO0Oq6GnhTHadxWJw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63co-0000000E83L-0mYh;
	Fri, 27 Mar 2026 10:37:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 07/19] wifi: mac80211: simplify ieee80211_sta_rx_bw_to_chan_width()
Date: Fri, 27 Mar 2026 10:31:33 +0100
Message-ID: <20260327103659.15e5c49a1787.I573add4e3ed68b15f8b45122d053ac523afe4025@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327093659.711584-21-johannes@sipsolutions.net>
References: <20260327093659.711584-21-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34047-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD87C341D89
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

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        | 38 +++++++++++---------------------------
 net/mac80211/ht.c          |  3 +--
 net/mac80211/ieee80211_i.h |  5 +++--
 net/mac80211/util.c        | 19 +++++++++++++++++++
 net/mac80211/vht.c         | 34 +---------------------------------
 5 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 57e8f8db3d9d..606d768b62cb 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -405,33 +405,17 @@ ieee80211_get_sta_bw(struct sta_info *sta, struct ieee80211_link_data *link)
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
index d951a4302e9a..614fa7a9d027 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -629,8 +629,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 
 	link_sta->pub->bandwidth = new_bw;
 	sband = local->hw.wiphy->bands[band];
-	sta_opmode.bw =
-		ieee80211_sta_rx_bw_to_chan_width(link_sta);
+	sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
 	sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
 
 	rate_control_rate_update(local, sband, link_sta,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 24ff9073b3ff..f8f728619249 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2307,8 +2307,6 @@ void ieee80211_apply_vhtcap_overrides(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_sta_vht_cap *vht_cap);
 void ieee80211_get_vht_mask_from_cap(__le16 vht_cap,
 				     u16 vht_mask[NL80211_VHT_NSS_MAX]);
-enum nl80211_chan_width
-ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *sta);
 
 /* HE */
 void
@@ -2694,6 +2692,9 @@ void ieee80211_add_s1g_capab_ie(struct ieee80211_sub_if_data *sdata,
 void ieee80211_add_aid_request_ie(struct ieee80211_sub_if_data *sdata,
 				  struct sk_buff *skb);
 
+enum nl80211_chan_width
+ieee80211_sta_rx_bw_to_chan_width(enum ieee80211_sta_rx_bandwidth bw);
+
 /* element building in SKBs */
 int ieee80211_put_srates_elem(struct sk_buff *skb,
 			      const struct ieee80211_supported_band *sband,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8987a4504520..b4caa31f6359 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3764,6 +3764,25 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
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
index 8a2ebbbc1807..a72cf532bec7 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -425,38 +425,6 @@ _ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
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
@@ -658,7 +626,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
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


