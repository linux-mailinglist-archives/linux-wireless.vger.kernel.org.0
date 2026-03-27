Return-Path: <linux-wireless+bounces-34039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFyEH/9Pxmk2IgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF0341D3C
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 10:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1508307AB33
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951D33DBD72;
	Fri, 27 Mar 2026 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aN5S64W+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74E3D34B5
	for <linux-wireless@vger.kernel.org>; Fri, 27 Mar 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604232; cv=none; b=EIyW+YAVBFltouStOq8JFASialtzrfNEqpdgdpPg8kK02ZK3hKx/N7WMOGi+GcsCP65oM8t+03SxjjFHOPeFl0HUnmC8x/CdXBoHRGfs4oRjIzCdcxE6Gy1H3+WT/VBspn3jyo2bIIfifyLNjn3E3BJ29mHtQwJssrGlmi20AEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604232; c=relaxed/simple;
	bh=6l9GCqMIET2yj91ZQYK1kAZaFXRNsvWELjQ8jfef0wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mTwVjX5tLJY4XEaoc27ALMp9Q7yy1hdcQVb+12ujCrCNg2sS/l9dxMVRb3/Mo0nPSZErHcPs4tGIfgnkf4ffUi8TvRSydE9zGj9FKTg/SszU05EvGBQgCkH+nll6TnLTYb3wucsDDGLRmnObTwwJbsXVqKWLSmhRk5z3XskJVb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aN5S64W+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9l9Y04iK+X3OHtSFYBJRZ4ChULWMsUvYRG3lhRSKt1w=;
	t=1774604231; x=1775813831; b=aN5S64W+zTbujLq3GrnX97OW58/9elGcz1YoNIFm05g6Usy
	sLgSBHzfk83yGxp1D1aXmdmHAxrO6A0xVshkmFXjnMYjtUMnvSTv7cuM2R50j+VlHB4N6TH8uShkl
	NXkJEj31dVfJVCtnYj50oVFv9fBJ83NoFO22/0xyRCkgPdgTxAOrmtho9c8t+HzYPT5zDQSAmNvuY
	xgG88nVBuLRM8OeDG86ObwcDrSxDrWRGj+3I6/DNbrA/LgDrPIic5gYvluDgjcA1Mu+7qh6J4Qu5S
	5Ywrx6dpOlxR6MVM+HX4pzVdyBfallLSGnunEPPJeWiVs5a0yPfNnQ9uja6XOuPg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w63cl-0000000E83L-3i63;
	Fri, 27 Mar 2026 10:37:04 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 03/19] wifi: mac80211: use chandef in ieee80211_get_sta_bw()
Date: Fri, 27 Mar 2026 10:31:29 +0100
Message-ID: <20260327103659.c212460c51c6.I6ae07289a272dd9e27118f9fa324a4865f994003@changeid>
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
	TAGGED_FROM(0.00)[bounces-34039-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 41DF0341D3C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When getting the bandwidth the station uses in order to
calculate the channel context's min_def, pass the channel
for the link to _ieee80211_sta_cap_rx_bw() instead of using
ieee80211_sta_cap_rx_bw(), which looks it up.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index dd99fdc1ea9d..57e8f8db3d9d 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -383,11 +383,12 @@ ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
 	return NULL;
 }
 
-static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
-						    unsigned int link_id)
+static enum nl80211_chan_width
+ieee80211_get_sta_bw(struct sta_info *sta, struct ieee80211_link_data *link)
 {
 	enum ieee80211_sta_rx_bandwidth width;
 	struct link_sta_info *link_sta;
+	int link_id = link->link_id;
 
 	link_sta = wiphy_dereference(sta->local->hw.wiphy, sta->link[link_id]);
 
@@ -402,7 +403,7 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
 	 * capabilities here. Calling it RX bandwidth capability is a bit
 	 * wrong though, since capabilities are in fact symmetric.
 	 */
-	width = ieee80211_sta_cap_rx_bw(link_sta);
+	width = _ieee80211_sta_cap_rx_bw(link_sta, &link->conf->chanreq.oper);
 
 	switch (width) {
 	case IEEE80211_STA_RX_BW_20:
@@ -437,7 +438,6 @@ static enum nl80211_chan_width
 ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
@@ -448,7 +448,7 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
 
-		max_bw = max(max_bw, ieee80211_get_sta_bw(sta, link_id));
+		max_bw = max(max_bw, ieee80211_get_sta_bw(sta, link));
 	}
 
 	return max_bw;
-- 
2.53.0


