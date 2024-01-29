Return-Path: <linux-wireless+bounces-2684-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C183E8412A3
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 601251F25512
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 18:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541C15957A;
	Mon, 29 Jan 2024 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="UJ0f/xn9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB1158D6A
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553683; cv=none; b=ekbNbxt/fYc2sIMZyXDzRARSZXdZg6xEZW4iP6Ki8TA6QzWBzydV8uobWikXCuwfKhCXyVk+JSvDz7qhtwacwJWvxTNIbdwor/6BTiCvviicDP0DIcvre1uTgp4zpDhwyzEBRoqZ84BvFxCMYiTHT0qbJEnrhQ23c3vf85q04n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553683; c=relaxed/simple;
	bh=zrFHrOW/YrfgNKBqOaz4JzT1/VtUOo40d+iS5oJflE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ho4yBOT9WNaLl4RFUmVWhnXekTp+rU0G74O4VlNWOuXc7gODVbjllYjmyhIbTkkvX7FuWqrC0hJsWVwpUjFVd4Rh0N72idWAB7KI5z6AItMwCAgYNo5/kCwWB/1H4brSD988EYBeFTdnNZ7guXTqWfpR3f5Q8rsr9idVPrHM7l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=UJ0f/xn9; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=NRrxewBoA15MslqWMEe5m9F2nCs4pO4NdmEey7SGMGM=;
	t=1706553681; x=1707763281; b=UJ0f/xn9KbKgiUanOmIBOR327Rgvb4YRn+IV+jIpIyNdcsE
	l8oDRQBrh/8oYiUlpl4nZa1OVIrtZGUauFFlORB4xFEbzKnDzZAHGyyPmZLIC3YhVY6sl9HLt5Z7u
	/SRzcffsDB45M4pfKoksgnr3OZ/MbjPmOIlX0AumAB8MdP93umfS8fSEjeJu4rQhTO3oAO9Bzj24j
	xNAqeKlLUKnEjicrcJAHYqtXfsavTtieZ98VpU5LWnh+EMYQlAXpasND1jgWGkKd4ZITdbTh3N/3u
	py8L3i8sYLErYtMDSN6++ENXzFoIbjfokDni1cq+/gjZBjoZctIAQ/yzLWKRIqLA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWZK-00000004z9N-3FO6;
	Mon, 29 Jan 2024 19:41:18 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/15] wifi: mac80211: validate assoc response channel config
Date: Mon, 29 Jan 2024 19:34:43 +0100
Message-ID: <20240129194108.b3efa5eae60c.I1b70c9fd56781b22cdfdca55d34d69f7d0733e31@changeid>
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

Due to the earlier restructuring we now mostly ignore
the channel configuration in the association response,
apart from the HT/VHT checks we had.

Don't do that, but parse it and update, also dropping the
association if the AP changed its mode in the response.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 08f9348fba36..ffa0909597cc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -867,7 +867,7 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
-			       u64 *changed)
+			       bool update, u64 *changed)
 {
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
@@ -942,6 +942,11 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return -EINVAL;
 	}
 
+	if (!update) {
+		link->conf->chanreq = chanreq;
+		return 0;
+	}
+
 	/*
 	 * We're tracking the current AP here, so don't do any further checks
 	 * here. This keeps us from playing ping-pong with regulatory, without
@@ -4504,6 +4509,8 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	/*
 	 * We previously checked these in the beacon/probe response, so
 	 * they should be present here. This is just a safety net.
+	 * Note that the ieee80211_config_bw() below would also check
+	 * for this (and more), but this has better error reporting.
 	 */
 	if (!is_6ghz && link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HT &&
 	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
@@ -4521,6 +4528,14 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 		goto out;
 	}
 
+	/* check/update if AP changed anything in assoc response vs. scan */
+	if (ieee80211_config_bw(link, elems,
+				link_id == assoc_data->assoc_link_id,
+				changed)) {
+		ret = false;
+		goto out;
+	}
+
 	if (WARN_ON(!link->conf->chanreq.oper.chan)) {
 		ret = false;
 		goto out;
@@ -6597,7 +6612,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-	if (ieee80211_config_bw(link, elems, &changed)) {
+	if (ieee80211_config_bw(link, elems, true, &changed)) {
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_DEAUTH_LEAVING,
 				       true, deauth_buf);
-- 
2.43.0


