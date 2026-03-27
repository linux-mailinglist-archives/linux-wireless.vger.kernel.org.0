Return-Path: <linux-wireless+bounces-34034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJcdMoJQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:40:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D95341E27
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4ADAB306F5C2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139F78F4A;
	Fri, 27 Mar 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tkyTCXMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9DE36AB46
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604231; cv=none; b=ZZ/Ssn8SUlHZzAlLYxeW+FvbRFcf2vxJi1KpmsWQqR0RUYDi83gud2k3J0C0kk7djZRwjv+v+SSMf/chtEGyf+kdv4lHLp2tqqy8iQCpUNP8Z7ToFytHz0tLrb2O3itk3HNK1N0LZnIN+RnlISIYOXCZqiZ82p0CGKbOKf/7nTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604231; c=relaxed/simple;
	bh=EAQh2Gw6YOwQr+X7fBL+l+AQ2mz254XOcJsyixgalsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMUfL96ncRDgLGjtZAwHPCL7fKvkWUaGIx+4n6wgGXGGmsJIEfvvptT+jVrF6QcA7Nes0nASo6v3VUJqNTLY/SbwhWr6og3xSp6ujkuchxUOfiGjlYd2ZfdvlToLd2Z6EL3TvWm/YUg51LPpNKcFStj0eFRkCulG2hmAJVtvVrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tkyTCXMp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=GoMhw853H4lJEUbJ7Yr+XVVJdGe6U+NHf9CK4cQUkEE=;
	t=1774604229; x=1775813829; b=tkyTCXMpU7M2JYEe8JxQXh4IZjKxG5s6DftMh44JEnM5NUf
	S0XOikpNt0xUzJ/FTOxqkZ17CDHEygC1fkhETTqJe/BOsCjH0PB4kL0AhRLs6NxGuaXHqpbr7/bjh
	GMdozqUVXLbSAAauwaELXCyC4kii9HIK7idShbu5ysaFpnarSk+kgQzLMibJG2I+ZhDBya6dGYB1e
	O810GWY+4BLJsudriLMK/b+qgAIEbD95FnFH6mG6D7ChNxPYvAwpYwBuhTOBkOjsCdrbISKM4Aef7
	hr0qH5FwdLGInR4+ESsz2sIvv6dvd/kntR7Eb88BbzQ57qd5KQy4ijxRAZHNHUqQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cp-0000000E83L-1dwe;
	Fri, 27 Mar 2026 10:37:07 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 09/19] wifi: mac80211: clean up initial STA NSS/bandwidth handling
Date: Fri, 27 Mar 2026 10:31:35 +0100
Message-ID: <20260327103659.9d5167174f6e.Id7a316e75e7e3dce2023d987e6939060f5286378@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34034-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3D95341E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Currently, the initial STA bandwidth is set during each
parsing of HT/VHT/... elements to the station capabilities,
multiple times, in a confusing way that's not very good in
the case of NAN stations either.

For now, keep the NULL chandef pointer and all that, but
clean up the initial handling of NSS/BW capabilities and
then apply the VHT operation mode on top of that. This
clarifies the code and the client code now also handles
the bandwidth change from Operating Mode Notification in
association response.

The HT code is completely unnecessary now, since the VHT
(soon to be renamed) function will be called and handles
HT as well.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c        | 10 +++++++++-
 net/mac80211/eht.c        |  2 --
 net/mac80211/he.c         |  2 --
 net/mac80211/ht.c         | 31 -------------------------------
 net/mac80211/ibss.c       |  3 ++-
 net/mac80211/mesh_plink.c |  3 ++-
 net/mac80211/mlme.c       | 21 ++++++---------------
 net/mac80211/ocb.c        |  3 ++-
 net/mac80211/sta_info.c   | 18 +++++++++++-------
 net/mac80211/sta_info.h   |  3 ++-
 net/mac80211/vht.c        |  2 --
 11 files changed, 34 insertions(+), 64 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b6163dcc7e92..4011d9d1ffcc 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2176,7 +2176,15 @@ static int sta_link_apply_parameters(struct ieee80211_local *local,
 		ieee80211_s1g_cap_to_sta_s1g_cap(sdata, params->s1g_capa,
 						 link_sta);
 
-	ieee80211_sta_init_nss(link_sta);
+	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
+		/* not applicable - they don't use NSS/BW as capability */
+		break;
+	default:
+		ieee80211_sta_init_nss_bw_capa(link_sta, &link->conf->chanreq.oper);
+		break;
+	}
 
 	if (params->opmode_notif_used) {
 		enum nl80211_chan_width width = link->conf->chanreq.oper.width;
diff --git a/net/mac80211/eht.c b/net/mac80211/eht.c
index 66dd104f8c73..9edfe3380e17 100644
--- a/net/mac80211/eht.c
+++ b/net/mac80211/eht.c
@@ -74,8 +74,6 @@ ieee80211_eht_cap_ie_to_sta_eht_cap(struct ieee80211_sub_if_data *sdata,
 
 	eht_cap->has_eht = true;
 
-	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
-
 	/*
 	 * The MPDU length bits are reserved on all but 2.4 GHz and get set via
 	 * VHT (5 GHz) or HE (6 GHz) capabilities.
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 70da246f8a2d..028c5a8459b3 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -155,8 +155,6 @@ _ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	he_cap->has_he = true;
 
-	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
-
 	if (he_6ghz_capa)
 		ieee80211_update_from_he_6ghz_capa(he_6ghz_capa, link_sta);
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 614fa7a9d027..d5528fbc5fbe 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -140,14 +140,11 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 				       const struct ieee80211_ht_cap *ht_cap_ie,
 				       struct link_sta_info *link_sta)
 {
-	struct ieee80211_bss_conf *link_conf;
 	struct sta_info *sta = link_sta->sta;
 	struct ieee80211_sta_ht_cap ht_cap, own_cap;
 	u8 ampdu_info, tx_mcs_set_cap;
 	int i, max_tx_streams;
 	bool changed;
-	enum ieee80211_sta_rx_bandwidth bw;
-	enum nl80211_chan_width width;
 
 	memset(&ht_cap, 0, sizeof(ht_cap));
 
@@ -252,34 +249,6 @@ bool ieee80211_ht_cap_ie_to_sta_ht_cap(struct ieee80211_sub_if_data *sdata,
 
 	memcpy(&link_sta->pub->ht_cap, &ht_cap, sizeof(ht_cap));
 
-	rcu_read_lock();
-	link_conf = rcu_dereference(sdata->vif.link_conf[link_sta->link_id]);
-	if (WARN_ON(!link_conf))
-		width = NL80211_CHAN_WIDTH_20_NOHT;
-	else
-		width = link_conf->chanreq.oper.width;
-
-	switch (width) {
-	default:
-		WARN_ON_ONCE(1);
-		fallthrough;
-	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_20:
-		bw = IEEE80211_STA_RX_BW_20;
-		break;
-	case NL80211_CHAN_WIDTH_40:
-	case NL80211_CHAN_WIDTH_80:
-	case NL80211_CHAN_WIDTH_80P80:
-	case NL80211_CHAN_WIDTH_160:
-	case NL80211_CHAN_WIDTH_320:
-		bw = ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
-				IEEE80211_STA_RX_BW_40 : IEEE80211_STA_RX_BW_20;
-		break;
-	}
-	rcu_read_unlock();
-
-	link_sta->pub->bandwidth = bw;
-
 	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
 	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
 		enum ieee80211_smps_mode smps_mode;
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index b65f090a35dc..41572eaf6f44 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -553,7 +553,8 @@ static struct sta_info *ieee80211_ibss_finish_sta(struct sta_info *sta)
 
 	memcpy(addr, sta->sta.addr, ETH_ALEN);
 
-	ieee80211_sta_init_nss(&sta->deflink);
+	ieee80211_sta_init_nss_bw_capa(&sta->deflink,
+				       &sdata->deflink.conf->chanreq.oper);
 
 	ibss_dbg(sdata, "Adding new IBSS station %pM\n", addr);
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 99c666fb2d17..502304747d4e 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -470,7 +470,8 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					    elems->eht_cap, elems->eht_cap_len,
 					    &sta->deflink);
 
-	ieee80211_sta_init_nss(&sta->deflink);
+	ieee80211_sta_init_nss_bw_capa(&sta->deflink,
+				       &sdata->deflink.conf->chanreq.oper);
 
 	if (bw != sta->sta.deflink.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3a0fd3dc976c..06300cf1c8ec 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5748,22 +5748,13 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	 * next beacon and update then.
 	 */
 
-	/*
-	 * If an operating mode notification element is present, set the opmode
-	 * NSS override to correct for the current number of spatial streams,
-	 * overriding the capabilities. ieee80211_sta_init_nss() uses this.
-	 */
-	if (elems->opmode_notif &&
-	    !(*elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)) {
-		u8 nss;
+	ieee80211_sta_init_nss_bw_capa(link_sta, &bss_conf->chanreq.oper);
 
-		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
-		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
-		nss += 1;
-		link_sta->op_mode_nss = nss;
-	}
-
-	ieee80211_sta_init_nss(link_sta);
+	/* If an operating mode notification element is present, use it. */
+	if (elems->opmode_notif)
+		__ieee80211_vht_handle_opmode(sdata, link_sta,
+					      *elems->opmode_notif,
+					      sband->band);
 
 	/*
 	 * Always handle WMM once after association regardless
diff --git a/net/mac80211/ocb.c b/net/mac80211/ocb.c
index 447c84235c1c..e9bf4ba3e60b 100644
--- a/net/mac80211/ocb.c
+++ b/net/mac80211/ocb.c
@@ -92,7 +92,8 @@ static struct sta_info *ieee80211_ocb_finish_sta(struct sta_info *sta)
 
 	memcpy(addr, sta->sta.addr, ETH_ALEN);
 
-	ieee80211_sta_init_nss(&sta->deflink);
+	ieee80211_sta_init_nss_bw_capa(&sta->deflink,
+				       &sdata->deflink.conf->chanreq.oper);
 
 	ocb_dbg(sdata, "Adding new IBSS station %pM (dev=%s)\n",
 		addr, sdata->name);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 31cf45095c60..51d5618bd3f9 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3401,7 +3401,7 @@ void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id)
 	sta_remove_link(sta, link_id, true);
 }
 
-void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
+static u8 ieee80211_sta_nss_capability(struct link_sta_info *link_sta)
 {
 	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
 	bool support_160;
@@ -3484,13 +3484,17 @@ void ieee80211_sta_init_nss(struct link_sta_info *link_sta)
 	rx_nss = max(he_rx_nss, rx_nss);
 	rx_nss = max(eht_rx_nss, rx_nss);
 	rx_nss = max_t(u8, 1, rx_nss);
-	link_sta->capa_nss = rx_nss;
 
-	if (link_sta->op_mode_nss)
-		link_sta->pub->rx_nss =
-			min_t(u8, rx_nss, link_sta->op_mode_nss);
-	else
-		link_sta->pub->rx_nss = rx_nss;
+	return rx_nss;
+}
+
+void ieee80211_sta_init_nss_bw_capa(struct link_sta_info *link_sta,
+				    struct cfg80211_chan_def *chandef)
+{
+	link_sta->capa_nss = ieee80211_sta_nss_capability(link_sta);
+	link_sta->pub->rx_nss = link_sta->capa_nss;
+
+	link_sta->pub->bandwidth = _ieee80211_sta_cur_vht_bw(link_sta, chandef);
 }
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9c827199f949..46e133dafc61 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -996,7 +996,8 @@ void ieee80211_sta_ps_deliver_uapsd(struct sta_info *sta);
 
 unsigned long ieee80211_sta_last_active(struct sta_info *sta, int link_id);
 
-void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
+void ieee80211_sta_init_nss_bw_capa(struct link_sta_info *link_sta,
+				    struct cfg80211_chan_def *chandef);
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
 					   const u8 *ext_capab,
 					   unsigned int ext_capab_len);
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 63aa64b77ca0..1bde9adac5a6 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -297,8 +297,6 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta);
-
 	/*
 	 * Work around the Cisco 9115 FW 17.3 bug by taking the min of
 	 * both reported MPDU lengths.
-- 
2.53.0


