Return-Path: <linux-wireless+bounces-37119-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SE1YHJROGWr2uggAu9opvQ
	(envelope-from <linux-wireless+bounces-37119-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF35FF2FC
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5B6F319EA96
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823F036D9F6;
	Fri, 29 May 2026 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vCtNNeMR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7933F5B0
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043222; cv=none; b=Un5rcCvwtmTiaf4Dc0ncgW/+C6abJSfhI/WgDrt4N9C7zeax2TfzqtodabNxQ75RAoAkmIkdmmXyjVNyXGl7KV9XlXRqOBUDEe20CwbysYNz2p4O+eE1dNosx5ccHB6uctxh+VJLZf+LmLmy+5X7nk1rXRP2YfGSVGmlEsX0IWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043222; c=relaxed/simple;
	bh=pn/H/hBAvFoDd1XjMU3EmX4qCB5p2wGWd7HnAz3X3Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mq5jJZ+jzmlv+YB4BWUOIoDYp5cfzkNzvHNy2oHEhQjFMzN0xuer13Sv9SnPtS0FuHu0if3rFvZmOvfr6b0fDGtMt/rT+mwady9SEowTvEdV1o6KBGFXs8hJox2KVGa9zr9Y1YlgU3ICIFc+SFHT1PjjNiljmzQ4iGwh4XMO/mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vCtNNeMR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9I7qqhoxA8AuPbyXlQ6xwJiIHglx38A6x32zCYn6fyE=;
	t=1780043221; x=1781252821; b=vCtNNeMRAZimk1W9Yaqkwo3LMx+3y+f7EZI/j6SDvOTSeks
	HxOPT0fQaANUl2N3S6tyPyGBoZUM91Katd4P8p+7+4APJ828+XAUeCrg9D439kZXgUIEDAl9tu12y
	dAtCX06p/ypGwE6tQYAHuiaDvp8RANTQxARvqL8PZx6bdSgCJjWYvYiso26fEO94cHeoVVSLq1IF+
	/+/q6Jk6Y9p3JuObOsRWTm04rLSzhILHyoCEp3fYmHmwG/H7lDq5MPFdUM2CgToHfqMQW9qZLw70d
	mCB5rm6MNJCt+JJNYRhvXYZNugPLUkZ8GYjmDvnlHLqBMZe6BCPf4vFaP+XXkiMA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYU-00000009bVp-2hfG;
	Fri, 29 May 2026 10:26:58 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 13/16] wifi: mac80211: refactor link STA bandwidth update
Date: Fri, 29 May 2026 10:25:06 +0200
Message-ID: <20260529102644.577c2f304d33.I09df4fce83c4e3e6deddfecbea74ffdbeedb4927@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529082644.106145-18-johannes@sipsolutions.net>
References: <20260529082644.106145-18-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[sipsolutions.net: no valid DMARC record];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37119-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BAEF35FF2FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

There's similar code in two places in HT and HE, and we need to add
the same again for UHR. Rename ieee80211_link_sta_rc_update_omi()
to ieee80211_link_sta_update_rc_bw() and move it to sta_info.c and
update existing code that can use it to do so.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/he.c       | 25 ++-----------------------
 net/mac80211/ht.c       | 24 ++++++++----------------
 net/mac80211/sta_info.c | 23 +++++++++++++++++++++++
 net/mac80211/sta_info.h |  3 +++
 4 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index b7d9e4cb6ba6..5acf482c177a 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -262,27 +262,6 @@ ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
 	}
 }
 
-static void ieee80211_link_sta_rc_update_omi(struct ieee80211_link_data *link,
-					     struct link_sta_info *link_sta)
-{
-	struct ieee80211_sub_if_data *sdata = link->sdata;
-	struct ieee80211_supported_band *sband;
-	enum ieee80211_sta_rx_bandwidth new_bw;
-	enum nl80211_band band;
-
-	band = link->conf->chanreq.oper.chan->band;
-	sband = sdata->local->hw.wiphy->bands[band];
-
-	new_bw = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
-					  IEEE80211_STA_BW_TX_TO_STA);
-	if (link_sta->pub->bandwidth == new_bw)
-		return;
-
-	link_sta->pub->bandwidth = new_bw;
-	rate_control_rate_update(sdata->local, sband, link_sta,
-				 IEEE80211_RC_BW_CHANGED);
-}
-
 bool ieee80211_prepare_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta,
 				 enum ieee80211_sta_rx_bandwidth bw)
 {
@@ -323,7 +302,7 @@ bool ieee80211_prepare_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta,
 
 	if (bw < link_sta->rx_omi_bw_staging) {
 		link_sta->rx_omi_bw_tx = bw;
-		ieee80211_link_sta_rc_update_omi(link, link_sta);
+		ieee80211_link_sta_update_rc_bw(link, link_sta);
 	} else {
 		link_sta->rx_omi_bw_rx = bw;
 		ieee80211_recalc_chanctx_min_def(local, chanctx);
@@ -365,7 +344,7 @@ void ieee80211_finalize_rx_omi_bw(struct ieee80211_link_sta *pub_link_sta)
 		/* rate control in finalize only when widening bandwidth */
 		WARN_ON(link_sta->rx_omi_bw_tx > link_sta->rx_omi_bw_staging);
 		link_sta->rx_omi_bw_tx = link_sta->rx_omi_bw_staging;
-		ieee80211_link_sta_rc_update_omi(link, link_sta);
+		ieee80211_link_sta_update_rc_bw(link, link_sta);
 	}
 
 	if (link_sta->rx_omi_bw_rx != link_sta->rx_omi_bw_staging) {
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 6285ac15c16c..e1e1b7f82f3f 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -584,9 +584,10 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 					 struct link_sta_info *link_sta,
 					 u8 chanwidth, enum nl80211_band band)
 {
-	enum ieee80211_sta_rx_bandwidth max_bw, new_bw;
-	struct ieee80211_supported_band *sband;
-	struct sta_opmode_info sta_opmode = {};
+	enum ieee80211_sta_rx_bandwidth max_bw;
+	struct sta_opmode_info sta_opmode = {
+		.changed = STA_OPMODE_MAX_BW_CHANGED,
+	};
 	struct ieee80211_link_data *link;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -602,21 +603,12 @@ void ieee80211_ht_handle_chanwidth_notif(struct ieee80211_local *local,
 
 	/* set op_mode_bw and recalc sta bw */
 	link_sta->op_mode_bw = max_bw;
-	new_bw = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
-					  IEEE80211_STA_BW_TX_TO_STA);
 
-	if (link_sta->pub->bandwidth == new_bw)
+	if (!ieee80211_link_sta_update_rc_bw(link, link_sta))
 		return;
 
-	link_sta->pub->bandwidth = new_bw;
-	sband = local->hw.wiphy->bands[band];
-	sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(new_bw);
-	sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
+	sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(link_sta->pub->bandwidth);
 
-	rate_control_rate_update(local, sband, link_sta,
-				 IEEE80211_RC_BW_CHANGED);
-	cfg80211_sta_opmode_change_notify(sdata->dev,
-					  sta->addr,
-					  &sta_opmode,
-					  GFP_KERNEL);
+	cfg80211_sta_opmode_change_notify(sdata->dev, sta->addr,
+					  &sta_opmode, GFP_KERNEL);
 }
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0ea37016cd4f..85e0b6c5ff00 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3765,3 +3765,26 @@ ieee80211_sta_current_bw(struct link_sta_info *link_sta,
 	/* unreachable */
 	return IEEE80211_STA_RX_BW_20;
 }
+
+bool ieee80211_link_sta_update_rc_bw(struct ieee80211_link_data *link,
+				     struct link_sta_info *link_sta)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_supported_band *sband;
+	enum ieee80211_sta_rx_bandwidth new_bw;
+	enum nl80211_band band;
+
+	band = link->conf->chanreq.oper.chan->band;
+	sband = sdata->local->hw.wiphy->bands[band];
+
+	new_bw = ieee80211_sta_current_bw(link_sta, &link->conf->chanreq.oper,
+					  IEEE80211_STA_BW_TX_TO_STA);
+	if (link_sta->pub->bandwidth == new_bw)
+		return false;
+
+	link_sta->pub->bandwidth = new_bw;
+	rate_control_rate_update(sdata->local, sband, link_sta,
+				 IEEE80211_RC_BW_CHANGED);
+
+	return true;
+}
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 39608a0abbb5..1da074dfffb4 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -1015,6 +1015,9 @@ ieee80211_sta_current_bw(struct link_sta_info *link_sta,
 			 struct cfg80211_chan_def *chandef,
 			 enum ieee80211_sta_bw_direction direction);
 
+bool ieee80211_link_sta_update_rc_bw(struct ieee80211_link_data *link,
+				     struct link_sta_info *link_sta);
+
 enum sta_stats_type {
 	STA_STATS_RATE_TYPE_INVALID = 0,
 	STA_STATS_RATE_TYPE_LEGACY,
-- 
2.53.0


