Return-Path: <linux-wireless+bounces-37111-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI1tFF1OGWrzuQgAu9opvQ
	(envelope-from <linux-wireless+bounces-37111-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFD55FF293
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FBF43103747
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0636D9F6;
	Fri, 29 May 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="MZK8PS4S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FCB3A0E8B
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 08:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043215; cv=none; b=RI2K4cwXOMLBoKX1p6X+3EpDNDw5rmjKqqeYvHg3CTfcpoVR7+ufA5OIJIqw7fpigbR+YW0R46mQ6PyLpE9e9tuMFSznml1s8uhmW0hA7nEzGn5e3ds8r9y+7ZkjVKM1X2YFsUICdjmBAWjD8gs3iBTKiHfBBnUhWh8CqKPUBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043215; c=relaxed/simple;
	bh=k+NYCI4lcZfzI9Sjlx42mZkxRJTdU4zFZ0X4BpKBnhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOJW10J71CvmekhBviXkui7AiFUStgg27ENkrmSa7eyOLWpnZs1QEYayadEUSorLQCGMK4pHhdPle+r4Gax+SyECbOpcXE+dqXbUBck3X0KHUYZeGy63C4ntbu5yAgCr6ewWykcHcLiZLJPrjcRWmv5PCUurw9+mmegs8HzcYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=MZK8PS4S; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=i+sWXqEsdcdsJ2ZR9XswmhG4jYtnUbk+1zptwYPxWQM=;
	t=1780043213; x=1781252813; b=MZK8PS4S77ZwWeqwKxNMn/TcaBh+nkiEI3cUKeSL1X58aX/
	VAXNNOYEJRy4uBWbxwJjOlAkUcO/i7Q7SFlC7nOycBfO/Z6N2e5Tch8sKy7zq0wxemJLI0xxqO8gX
	0mwHuecyfFnI8Zu2JrIjrYtHLp/yd6ffjl9tvktkFEtlZwhRQnWvT4U7DC6fOu1ofRSpYKX7xOUlM
	p1J7TYbZRRF7pq0OT34QXTgm5pmd6A7HUhRhenDCcNobCk9jTQhTuu6C6NukPQa46cLR7Apgu+Osb
	a09WgsLtSXfVEUZdLqTQ5UkrNwkTv+gdxz5YEK1jXl/aNjr66e7Zp8UztqlkQmKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSsYN-00000009bVp-0kCg;
	Fri, 29 May 2026 10:26:51 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/16] wifi: mac80211: clarify beacon parsing with MBSSID/EMA
Date: Fri, 29 May 2026 10:24:58 +0200
Message-ID: <20260529102644.97527a7dfd7b.Iecd0ef578b85a5a0057538cfff5fdff41d19b7ea@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-37111-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 9BFD55FF293
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When connected to a non-transmitting BSS of multiple BSSID
set with EMA, the correct profile for the connection isn't
always present in the beacon. Indicate this in the parser
and use the information to not check everything in beacon
processing, since the information might not be correct if
taken only from the transmitted BSS.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  9 +++++
 net/mac80211/mlme.c        | 83 ++++++++++++++++++++++++++++----------
 net/mac80211/parse.c       |  4 ++
 3 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 18a101710432..339faa7a0a0e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1898,6 +1898,15 @@ struct ieee802_11_elems {
 	struct ieee80211_mle_per_sta_profile *prof;
 	size_t sta_prof_len;
 
+	/*
+	 * When parsing the beacon with MBSSID (from a transmitted BSS), this
+	 * indicates that the profile the parser was instructed to look for
+	 * (via the bss value in &struct ieee80211_elems_parse_params) couldn't
+	 * be found (due to EMA, or perhaps broken AP) and the result cannot be
+	 * considered complete.
+	 */
+	bool mbssid_nontx_profile_missing;
+
 	/* whether/which parse error occurred while retrieving these elements */
 	u8 parse_error;
 };
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c2ef6c66acde..181fe975fcd9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7668,8 +7668,6 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	struct link_sta_info *link_sta;
 	struct sta_info *sta;
 	u64 changed = 0;
-	bool erp_valid;
-	u8 erp_value = 0;
 	u32 ncrc = 0;
 	u8 *bssid, *variable = mgmt->u.beacon.variable;
 	u8 deauth_buf[IEEE80211_DEAUTH_FRAME_LEN];
@@ -7790,6 +7788,13 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	if (!elems)
 		return;
 
+	/*
+	 * Note: with MBSSID and an EMA (or broken) AP, we could fail to find
+	 * the correct multi-BSSID profile for the non-transmitting AP we're
+	 * connected to. The result's elems->mbssid_nontx_profile_missing is
+	 * indicating that, but some things must happen regardless.
+	 */
+
 	if (rx_status->flag & RX_FLAG_DECRYPTED &&
 	    ieee80211_mgd_ssid_mismatch(sdata, elems)) {
 		sdata_info(sdata, "SSID mismatch for AP %pM, disconnect\n",
@@ -7825,6 +7830,11 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		}
 	}
 
+	/*
+	 * P2P will almost certainly not have MBSSID, but this just
+	 * assumes that it would at least always inherit NoA anyway
+	 * since it's absent from the channel.
+	 */
 	if (sdata->vif.p2p ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_GET_NOA_UPDATE) {
 		struct ieee80211_p2p_noa_attr noa = {};
@@ -7882,23 +7892,17 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	ieee80211_rx_bss_info(link, mgmt, len, rx_status);
 
+	/*
+	 * This assumes that all members of a multiple BSS set must be
+	 * switching together, so we can parse channel switch elements
+	 * from the transmitted BSS even if our non-transmitted one is
+	 * not present in this beacon (due to EMA.)
+	 */
 	ieee80211_sta_process_chanswitch(link, rx_status->mactime,
 					 rx_status->device_timestamp,
 					 elems, elems,
 					 IEEE80211_CSA_SOURCE_BEACON);
 
-	/* note that after this elems->ml_basic can no longer be used fully */
-	ieee80211_mgd_check_cross_link_csa(sdata, rx_status->link_id, elems);
-
-	ieee80211_mgd_update_bss_param_ch_cnt(sdata, bss_conf, elems);
-
-	if (!sdata->u.mgd.epcs.enabled &&
-	    !link->u.mgd.disable_wmm_tracking &&
-	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
-				     elems->wmm_param_len,
-				     elems->mu_edca_param_set))
-		changed |= BSS_CHANGED_QOS;
-
 	/*
 	 * If we haven't had a beacon before, tell the driver about the
 	 * DTIM period (and beacon timing if desired) now.
@@ -7915,17 +7919,53 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		ieee80211_recalc_ps_vif(sdata);
 	}
 
-	if (elems->erp_info) {
-		erp_valid = true;
-		erp_value = elems->erp_info[0];
-	} else {
-		erp_valid = false;
-	}
+	/* RNR isn't inside an MBSSID profile */
+	ieee80211_mgd_update_bss_param_ch_cnt(sdata, bss_conf, elems);
+
+	/* assume ERP would be inherited anyway */
+	if (!ieee80211_is_s1g_beacon(hdr->frame_control)) {
+		u8 erp_value = 0;
+		bool erp_valid;
+
+		if (elems->erp_info) {
+			erp_valid = true;
+			erp_value = elems->erp_info[0];
+		} else {
+			erp_valid = false;
+		}
 
-	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
 		changed |= ieee80211_handle_bss_capability(link,
 				le16_to_cpu(mgmt->u.beacon.capab_info),
 				erp_valid, erp_value);
+	}
+
+	/*
+	 * There are some other things that we can only do when the
+	 * real non-transmitted profile was actually parsed, so exit
+	 * here before doing those.
+	 */
+	if (elems->mbssid_nontx_profile_missing)
+		goto apply;
+
+	/*
+	 * This requires multi-link element, which is from the MBSSID profile.
+	 * Note that after this elems->ml_basic can no longer be used fully.
+	 *
+	 * Note also that currently the parsing is incorrect, so this will
+	 * never actually do anything.
+	 */
+	ieee80211_mgd_check_cross_link_csa(sdata, rx_status->link_id, elems);
+
+	/*
+	 * EDCA parameters should be the same, but perhaps ACM can differ
+	 * between BSSes in an MBSSID set.
+	 */
+	if (!sdata->u.mgd.epcs.enabled &&
+	    !link->u.mgd.disable_wmm_tracking &&
+	    ieee80211_sta_wmm_params(local, link, elems->wmm_param,
+				     elems->wmm_param_len,
+				     elems->mu_edca_param_set))
+		changed |= BSS_CHANGED_QOS;
 
 	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
 	if (WARN_ON(!sta)) {
@@ -7971,6 +8011,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	ieee80211_process_adv_ttlm(sdata, elems,
 				      le64_to_cpu(mgmt->u.beacon.timestamp));
 
+apply:
 	ieee80211_link_info_change_notify(sdata, link, changed);
 free:
 	kfree(elems);
diff --git a/net/mac80211/parse.c b/net/mac80211/parse.c
index 4a7b41995f76..aa06c1fdf472 100644
--- a/net/mac80211/parse.c
+++ b/net/mac80211/parse.c
@@ -1094,6 +1094,10 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		sub.type = params->type;
 		sub.link_id = params->link_id;
 
+		/* indicate to consumer whether or not profile was found */
+		if (params->bss->transmitted_bss && !nontx_len)
+			elems->mbssid_nontx_profile_missing = true;
+
 		/* consume the space used for non-transmitted profile */
 		elems_parse->scratch_pos += nontx_len;
 
-- 
2.53.0


