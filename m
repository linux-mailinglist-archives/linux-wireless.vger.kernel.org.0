Return-Path: <linux-wireless+bounces-34784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OItRCXiI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:44 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BF040463C
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2744930078BB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2279D304BB2;
	Wed, 15 Apr 2026 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KCRZxids"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ED431F9A8
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257128; cv=none; b=pYFG5tv2Hvk4XilizN2qnBrIKHJygRhZyVLJUdivlsDJKcLl1nq0iCeMIUwZs8kvrp2ZRI/BV+MH3Ar7csnI01+BPClTSOf9AqmyvS7oLpcU3+WssWuqgUFlwYK9JkfU/7ddSZZO0v8idudSSvFPZtulhiKL4ZbN2sVe+4m3mo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257128; c=relaxed/simple;
	bh=RcBN/SSuIxRIMvU1ent+UpnlGYcqYYw9BuqgCSH9lco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnRZan7sZvosqRz+B1Tdj5ly0RZYL8l/l0OMMeqJDAazgIcvFPOocZtbtcP1LwTQbJTqaj9zVr/YfSYy+PiHiZpWsBorDUfyML9sb3PaZNtBsBMVEcQk4KENbGpmUyI0s657szcvetOMaXcQrzQYRV49wyycggwPCbBBLjdPGTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KCRZxids; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=cSTV8ix3KY69QxpY6fQWZ1INRi/Y6tSS3ERp08QiR00=;
	t=1776257127; x=1777466727; b=KCRZxidsknOozpUIQT66AjlY930Ux2nkLnVA09Lkrl++Fz/
	C1hhqIrsSlo8nJewwT/Hfl+YhN/Cvb5dsks/DvtojPmZDZYv2xOmoVJYkQmVRYKh+KYF/iMUJ3uFq
	0GQXpc1xPGOgzgLaAzhszQAnMxTJo8+XGWib7zo4vZYsaGnsGAg35nw+RZQpURH1nbW8TPNzQqsbz
	gXg8/c2yGit2hIW4DpE/QOi7LvEavg/eXM/ptnrOrF0nqXuY4uEDHqmaurwKcYAo/yamg80R4VVPV
	v6XadLBPreAAo0daDaEaVRztPbQB/gOrdDBwXmycvHvCmoICSlepjf7QWR/HSqew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcT-00000006OgW-0xC3;
	Wed, 15 Apr 2026 14:45:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 12/20] wifi: mac80211: remove ieee80211_sta_cur_vht_bw()
Date: Wed, 15 Apr 2026 14:42:10 +0200
Message-ID: <20260415144514.73659adc198f.Ic8fc88a7e016e62d00dca380ffbf47a54ef3daef@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34784-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B5BF040463C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

We can now easily always call _ieee80211_sta_cur_vht_bw() with
a valid chandef, so do that, remove ieee80211_sta_cur_vht_bw()
and drop the underscore prefix.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        |  4 ++--
 net/mac80211/he.c          |  2 +-
 net/mac80211/ht.c          |  7 ++++++-
 net/mac80211/ieee80211_i.h |  9 ++-------
 net/mac80211/mlme.c        |  4 ++--
 net/mac80211/sta_info.c    |  2 +-
 net/mac80211/vht.c         | 41 ++++++++++++++------------------------
 7 files changed, 29 insertions(+), 40 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 7cbe2ce97d3b..13c0d080ef2a 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -693,8 +693,8 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
 			else
 				new_chandef = &link_conf->chanreq.oper;
 
-			new_sta_bw = _ieee80211_sta_cur_vht_bw(link_sta,
-							       new_chandef);
+			new_sta_bw = ieee80211_sta_cur_vht_bw(link_sta,
+							      new_chandef);
 
 			/* nothing change */
 			if (new_sta_bw == link_sta->pub->bandwidth)
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index e6e9c378ed3a..1e8ce33bfe2e 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -273,7 +273,7 @@ static void ieee80211_link_sta_rc_update_omi(struct ieee80211_link_data *link,
 	band = link->conf->chanreq.oper.chan->band;
 	sband = sdata->local->hw.wiphy->bands[band];
 
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
 	if (link_sta->pub->bandwidth == new_bw)
 		return;
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index e32e40db081b..02ca6e1edc49 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -587,9 +587,14 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
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
@@ -597,7 +602,7 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 
 	/* set cur_max_bandwidth and recalc sta bw */
 	link_sta->cur_max_bandwidth = max_bw;
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
 
 	if (link_sta->pub->bandwidth == new_bw)
 		return;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0c4796d96e65..6b72be762dbe 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2303,13 +2303,8 @@ enum ieee80211_sta_rx_bandwidth
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
index ea190d54d195..6e0e5d3f5015 100644
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
index d53cd8c5df4c..508aad14bdf6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3519,7 +3519,7 @@ void ieee80211_sta_init_nss_bw_capa(struct link_sta_info *link_sta,
 	link_sta->capa_nss = ieee80211_sta_nss_capability(link_sta);
 	link_sta->pub->rx_nss = link_sta->capa_nss;
 
-	link_sta->pub->bandwidth = _ieee80211_sta_cur_vht_bw(link_sta, chandef);
+	link_sta->pub->bandwidth = ieee80211_sta_cur_vht_bw(link_sta, chandef);
 }
 
 void ieee80211_sta_set_max_amsdu_subframes(struct sta_info *sta,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index cf7e5b8d373a..3df5f6c3f777 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -401,12 +401,12 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
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
@@ -414,35 +414,19 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 
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
 
-		/* NAN operates on multiple channels so a chandef must be given */
-		if (sta->sdata->vif.type == NL80211_IFTYPE_NAN ||
-		    sta->sdata->vif.type == NL80211_IFTYPE_NAN_DATA)
-			return IEEE80211_STA_RX_BW_MAX;
-
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
@@ -476,9 +460,14 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
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
@@ -525,7 +514,7 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	new_bw = ieee80211_sta_cur_vht_bw(link_sta);
+	new_bw = ieee80211_sta_cur_vht_bw(link_sta, &link->conf->chanreq.oper);
 	if (new_bw != link_sta->pub->bandwidth) {
 		link_sta->pub->bandwidth = new_bw;
 		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
-- 
2.53.0


