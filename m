Return-Path: <linux-wireless+bounces-34783-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNi3FXaI32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34783-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E235A404635
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF9A3007482
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A43B3264E6;
	Wed, 15 Apr 2026 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="j7eFfuEK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF13314AC
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257128; cv=none; b=atj5ssZ+nVrv6rkjHIjitSNQv8FEi/06GQbUg0RIur3qWqmy9p5wPhZ9dSbJpqFjwdijezYfMOKtydWoaTgmjIsx7ITk4UlBYVgA3vzPiqusbWMKzAfTfo0jZZlsX3WPJtBDF8psvRYZU8h4CHtu2wTMMkfjDBpZeceaPsGoH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257128; c=relaxed/simple;
	bh=Ybi0Y9nngjPr4TIGLVc1Kph5g/CWtHOQafy7bTlvy/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQLjQx4Y/pxQnor8b+xamgMzXkQ7h3ZhJs4UVvFeqg1WFx9Psggupd+h3aM6JeBb4K39KCRT3ci0DRWWW50sKTRX4Nh4JyyXRYkPcrP6816/o+B6omldZHRJjdBCNXK1wrpC2R4wqsKY2CQtaTgzjS+XZshCKjF53m7jq64h7qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=j7eFfuEK; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=2pu/KnwYIPmt6Gso5HD5V6ihmWdS6mYW6u3tBKmVIP4=;
	t=1776257126; x=1777466726; b=j7eFfuEKeLYRlzqkhImMNIcP0kw/5K+0MVzJgXwvf8Vl+gZ
	VJBXrkuiZzigfpcFuGn/COBeku70VtIYbQ6zhE7yCdbh1S1GiGoQ4EaXbrsP17Xl7nN6hOF4QN29z
	pX2DRBf+GktowoOFN7tqGnl56Cxgo7O+YsMlOHY7kI3sERlKVE8RVYOh6yMIGq4QV1tqAGXmhp90b
	sraU56LWtSQp+3cLEmIQmzAa46tphEiGN54QEnWCg2v7euC9evPIh3cuyoADYcQpM8FCf9ASzwS+p
	6Pgap2PReIrp8+PbnZ7zeKlcYyWZ7VAMZN+DKk+Tux+sdvGculSZDBgldhLczVVw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcS-00000006OgW-2jzl;
	Wed, 15 Apr 2026 14:45:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 11/20] wifi: mac80211: clean up ieee80211_sta_cap_rx_bw()
Date: Wed, 15 Apr 2026 14:42:09 +0200
Message-ID: <20260415144514.62f48003f11c.Ib84ab7aeab8b278ab46d85b142a66bf330909eb6@changeid>
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
	TAGGED_FROM(0.00)[bounces-34783-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: E235A404635
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

There are three versions of this function, but now there's
no caller to ieee80211_sta_cap_rx_bw() and the chandef is
always given. Rename the functions to have one underscore
less and rely on the chandef being passed.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c        |  2 +-
 net/mac80211/ieee80211_i.h |  9 ++-------
 net/mac80211/tdls.c        |  6 +++---
 net/mac80211/vht.c         | 32 ++++++++------------------------
 4 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b3d810e3691f..7cbe2ce97d3b 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -458,7 +458,7 @@ ieee80211_get_sta_bw(struct sta_info *sta, struct ieee80211_link_data *link)
 	 * capabilities here. Calling it RX bandwidth capability is a bit
 	 * wrong though, since capabilities are in fact symmetric.
 	 */
-	width = _ieee80211_sta_cap_rx_bw(link_sta, &link->conf->chanreq.oper);
+	width = ieee80211_sta_cap_rx_bw(link_sta, &link->conf->chanreq.oper);
 
 	if (width == IEEE80211_STA_RX_BW_20 &&
 	    !link_sta->pub->ht_cap.ht_supported &&
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 76213b50fe57..0c4796d96e65 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2300,13 +2300,8 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
-_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
-			 struct cfg80211_chan_def *chandef);
-static inline enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
-{
-	return _ieee80211_sta_cap_rx_bw(link_sta, NULL);
-}
+ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
+			struct cfg80211_chan_def *chandef);
 enum ieee80211_sta_rx_bandwidth
 _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 			  struct cfg80211_chan_def *chandef);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 874752738c68..dcb5fe98ec55 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -314,7 +314,7 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 	enum nl80211_chan_width max_width;
 	int i;
 
-	switch (ieee80211_sta_cap_rx_bw(&sta->deflink)) {
+	switch (ieee80211_sta_cap_rx_bw(&sta->deflink, &uc)) {
 	case IEEE80211_STA_RX_BW_20:
 		max_width = NL80211_CHAN_WIDTH_20;
 		break;
@@ -1337,8 +1337,8 @@ static void iee80211_tdls_recalc_chanctx(struct ieee80211_sub_if_data *sdata,
 			enum ieee80211_sta_rx_bandwidth bw;
 
 			bw = ieee80211_chan_width_to_rx_bw(conf->def.width);
-			bw = min(bw, _ieee80211_sta_cap_rx_bw(&sta->deflink,
-							      &conf->def));
+			bw = min(bw, ieee80211_sta_cap_rx_bw(&sta->deflink,
+							     &conf->def));
 			if (bw != sta->sta.deflink.bandwidth) {
 				sta->sta.deflink.bandwidth = bw;
 				rate_control_rate_update(local, sband,
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 2a85c578e252..cf7e5b8d373a 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -333,35 +333,16 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 
 /* FIXME: move this to some better location - parses HE/EHT now */
 static enum ieee80211_sta_rx_bandwidth
-__ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
-			  struct cfg80211_chan_def *chandef)
+_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta, enum nl80211_band band)
 {
-	unsigned int link_id = link_sta->link_id;
-	struct ieee80211_sub_if_data *sdata = link_sta->sta->sdata;
 	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
 	struct ieee80211_sta_he_cap *he_cap = &link_sta->pub->he_cap;
 	struct ieee80211_sta_eht_cap *eht_cap = &link_sta->pub->eht_cap;
 	u32 cap_width;
 
 	if (he_cap->has_he) {
-		enum nl80211_band band;
 		u8 info;
 
-		if (chandef) {
-			band = chandef->chan->band;
-		} else {
-			struct ieee80211_bss_conf *link_conf;
-
-			if (WARN_ON_ONCE(sdata->vif.type == NL80211_IFTYPE_NAN_DATA ||
-					 sdata->vif.type == NL80211_IFTYPE_NAN))
-				return IEEE80211_STA_RX_BW_20;
-
-			rcu_read_lock();
-			link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
-			band = link_conf->chanreq.oper.chan->band;
-			rcu_read_unlock();
-		}
-
 		if (eht_cap->has_eht && band == NL80211_BAND_6GHZ) {
 			info = eht_cap->eht_cap_elem.phy_cap_info[0];
 
@@ -410,8 +391,8 @@ __ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 }
 
 enum ieee80211_sta_rx_bandwidth
-_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
-			 struct cfg80211_chan_def *chandef)
+ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
+			struct cfg80211_chan_def *chandef)
 {
 	/*
 	 * With RX OMI, also pretend that the STA's capability changed.
@@ -427,7 +408,7 @@ _ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 	 * the transition we already need to change TX/RX separately,
 	 * so _ieee80211_sta_cur_vht_bw() below applies the _tx one.
 	 */
-	return min(__ieee80211_sta_cap_rx_bw(link_sta, chandef),
+	return min(_ieee80211_sta_cap_rx_bw(link_sta, chandef->chan->band),
 		   link_sta->rx_omi_bw_rx);
 }
 
@@ -439,9 +420,11 @@ _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 	struct sta_info *sta = link_sta->sta;
 	enum nl80211_chan_width bss_width;
 	enum ieee80211_sta_rx_bandwidth bw;
+	enum nl80211_band band;
 
 	if (chandef) {
 		bss_width = chandef->width;
+		band = chandef->chan->band;
 	} else {
 		struct ieee80211_bss_conf *link_conf;
 
@@ -457,11 +440,12 @@ _ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
 			return IEEE80211_STA_RX_BW_20;
 		}
 		bss_width = link_conf->chanreq.oper.width;
+		band = link_conf->chanreq.oper.chan->band;
 		rcu_read_unlock();
 	}
 
 	/* intentionally do not take rx_bw_omi_rx into account */
-	bw = __ieee80211_sta_cap_rx_bw(link_sta, chandef);
+	bw = _ieee80211_sta_cap_rx_bw(link_sta, band);
 	bw = min(bw, link_sta->cur_max_bandwidth);
 	/* but do apply rx_omi_bw_tx */
 	bw = min(bw, link_sta->rx_omi_bw_tx);
-- 
2.53.0


