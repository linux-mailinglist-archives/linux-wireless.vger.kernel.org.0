Return-Path: <linux-wireless+bounces-34036-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGOvG5BQxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34036-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:40:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D67E341E5E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BABD73073A1A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63C3DBD55;
	Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jVuQTkKf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5FC379EC4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604232; cv=none; b=gG8kx6QQmA2fuYlTmf6o77NW3crpq08o67YqYTTwaWUE8Mmcibo2BRc398WXlbRdbOwFX1p90tgoCubJrWtqefd0MZ4u7nRFGE12qYWdpTphDFVSx/EwBewt+yvd6bNYtrKyka0A/AoYiUFM8uEdKCY4rgstk0ZpLqFw9GLI+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604232; c=relaxed/simple;
	bh=qzDxLG3XM1PzIzRIN+WSt1IPuSpd0xPpwG8FAf2poxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHpnb0sRJKglBQrLgOJHMb1ZQKRvFEwjjXv1GUKeu9YbZ3mr9n9bhkvkgTMyWQqBTGtyxnBDbIOZxWrXY44LjxLNdnfQCHa9TkWS3Rtns7IywtXaW7KnglJHFu1y/9I8CNVOztLO2EjsSX9DSuwHpvCWhf1H2ANRtRzLmohzALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jVuQTkKf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FGqzA2ktDiRCqMGDAHBfvOOXgcaH16IKU3ZkjRaNAHE=;
	t=1774604230; x=1775813830; b=jVuQTkKfNWpWw4MPDkKkKyrGPg8PHKN3ftEh9DnxLiZ2h4e
	09XePNkfcleDPOmXQzSo8j3n9j6C0X2unO3+/PmJU1E0RElTjqP0oSjbt4PAo7cJBlESbVzVnbvA+
	LeY0JtbhGNpocnVlmXNZZPGfqGvYGT+4iCRjiPh9TNLGYAzRC2Um/4KB3XBLZE2GuAXJ8W1KVYjFi
	UgcMN2DbIakI7byS/yQFCHZuV7j9Awz2y1uWHTpPKT5xvb+xXErnfLWmSbDCX6RPklr8TscqlSBVh
	MG5KbFsxyusdWvwHnOzMFAIKvXmTFeNTv+vgSayM3hnB8H7fN1AFjfVaz3gYJJKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cq-0000000E83L-3B2V;
	Fri, 27 Mar 2026 10:37:08 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 11/19] wifi: mac80211: remove ieee80211_sta_cur_vht_bw()
Date: Fri, 27 Mar 2026 10:31:37 +0100
Message-ID: <20260327103659.070eeeb91e85.Ic8fc88a7e016e62d00dca380ffbf47a54ef3daef@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34036-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sta_opmode.bw:url,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D67E341E5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

We can now easily always call _ieee80211_sta_cur_vht_bw() with
a valid chandef, so do that, remove ieee80211_sta_cur_vht_bw()
and drop the underscore prefix.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        |  4 ++--
 net/mac80211/he.c          |  2 +-
 net/mac80211/ht.c          |  7 ++++++-
 net/mac80211/ieee80211_i.h |  9 ++-------
 net/mac80211/mlme.c        |  4 ++--
 net/mac80211/sta_info.c    |  2 +-
 net/mac80211/vht.c         | 36 +++++++++++++++---------------------
 7 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6beebbc93c3c..62f6d7f4be0d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -626,8 +626,8 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 			else
 				new_chandef = &link_conf->chanreq.oper;
 
-			new_sta_bw = _ieee80211_sta_cur_vht_bw(link_sta,
-							       new_chandef);
+			new_sta_bw = ieee80211_sta_cur_vht_bw(link_sta,
+							      new_chandef);
 
 			/* nothing change */
 			if (new_sta_bw == link_sta->pub->bandwidth)
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index 028c5a8459b3..2f7f7a834da6 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -269,7 +269,7 @@ static void ieee80211_link_sta_rc_update_omi(struct ieee80211_link_data *link,
 	band = link->conf->chanreq.oper.chan->band;
 	sband = sdata->local->hw.wiphy->bands[band];
 
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
 	if (link_sta->pub->bandwidth == new_bw)
 		return;
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index d5528fbc5fbe..f0d5c9363a5f 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -581,9 +581,14 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 	enum ieee80211_sta_rx_bandwidth max_bw, new_bw;
 	struct ieee80211_supported_band *sband;
 	struct sta_opmode_info sta_opmode = {};
+	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
+	link = sdata_dereference(sdata->link[link_sta->link_id], sdata);
+	if (WARN_ON(!link))
+		return;
+
 	if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
 		max_bw = IEEE80211_STA_RX_BW_20;
 	else
@@ -591,7 +596,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 
 	/* set cur_max_bandwidth and recalc sta bw */
 	link_sta->cur_max_bandwidth = max_bw;
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
 
 	if (link_sta->pub->bandwidth == new_bw)
 		return;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8a5640cdf298..29f51ec142ed 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2281,13 +2281,8 @@ enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 			struct cfg80211_chan_def *chandef);
 enum ieee80211_sta_rx_bandwidth
-_ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
-			  struct cfg80211_chan_def *chandef);
-static inline enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
-{
-	return _ieee80211_sta_cur_vht_bw(link_sta, NULL);
-}
+ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef);
 
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_link_data *link,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 06300cf1c8ec..3cd5fe11756f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2571,8 +2571,8 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 			return;
 
 		link_sta->pub->bandwidth =
-			_ieee80211_sta_cur_vht_bw(link_sta,
-						  &link->csa.chanreq.oper);
+			ieee80211_sta_cur_vht_bw(link_sta,
+						 &link->csa.chanreq.oper);
 		return;
 	}
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 51d5618bd3f9..9ae32d601b61 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3494,7 +3494,7 @@ void ieee80211_sta_init_nss_bw_capa(struct link_sta_info *link_sta,
 	link_sta->capa_nss = ieee80211_sta_nss_capability(link_sta);
 	link_sta->pub->rx_nss = link_sta->capa_nss;
 
-	link_sta->pub->bandwidth = _ieee80211_sta_cur_vht_bw(link_sta, chandef);
+	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta, chandef);
 }
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index f8992d71fd19..3e3efabe9149 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -397,12 +397,12 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 	 * The purpose, however, is to save power, and that requires
 	 * changing also transmissions to the AP and the chanctx. The
 	 * transmissions depend on link_sta->bandwidth which is set in
-	 * _ieee80211_sta_cur_vht_bw() below, but the chanctx depends
+	 * ieee80211_sta_cur_vht_bw() below, but the chanctx depends
 	 * on the result of this function which is also called by
-	 * _ieee80211_sta_cur_vht_bw(), so we need to do that here as
+	 * ieee80211_sta_cur_vht_bw(), so we need to do that here as
 	 * well. This is sufficient for the steady state, but during
 	 * the transition we already need to change TX/RX separately,
-	 * so _ieee80211_sta_cur_vht_bw() below applies the _tx one.
+	 * so ieee80211_sta_cur_vht_bw() below applies the _tx one.
 	 */
 	return min(_ieee80211_sta_cap_rx_bw(link_sta, chandef->chan->band),
 		   link_sta->rx_omi_bw_rx);
@@ -410,30 +410,19 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 
 /* FIXME: rename/move - this deals with everything not just VHT */
 enum ieee80211_sta_rx_bandwidth
-_ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
-			  struct cfg80211_chan_def *chandef)
+ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef)
 {
 	struct sta_info *sta = link_sta->sta;
 	enum nl80211_chan_width bss_width;
 	enum ieee80211_sta_rx_bandwidth bw;
 	enum nl80211_band band;
 
-	if (chandef) {
-		bss_width = chandef->width;
-		band = chandef->chan->band;
-	} else {
-		struct ieee80211_bss_conf *link_conf;
+	if (WARN_ON(!chandef))
+		return IEEE80211_STA_RX_BW_20;
 
-		rcu_read_lock();
-		link_conf = rcu_dereference(sta->sdata->vif.link_conf[link_sta->link_id]);
-		if (WARN_ON_ONCE(!link_conf)) {
-			rcu_read_unlock();
-			return IEEE80211_STA_RX_BW_20;
-		}
-		bss_width = link_conf->chanreq.oper.width;
-		band = link_conf->chanreq.oper.chan->band;
-		rcu_read_unlock();
-	}
+	bss_width = chandef->width;
+	band = chandef->chan->band;
 
 	/* intentionally do not take rx_bw_omi_rx into account */
 	bw = _ieee80211_sta_cap_rx_bw(link_sta, band);
@@ -467,9 +456,14 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 {
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
+	struct ieee80211_link_data *link;
 	u32 changed = 0;
 	u8 nss;
 
+	link = sdata_dereference(sdata->link[link_sta->link_id], sdata);
+	if (WARN_ON(!link))
+		return 0;
+
 	/* ignore - no support for BF yet */
 	if (opmode & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)
 		return 0;
@@ -516,7 +510,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
 	if (new_bw != link_sta->pub->bandwidth) {
 		link_sta->pub->bandwidth = new_bw;
 		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
-- 
2.53.0


