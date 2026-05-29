Return-Path: <linux-wireless+bounces-37101-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAeFJPg1GWrzswgAu9opvQ
	(envelope-from <linux-wireless+bounces-37101-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:45:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3708D5FE17A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 08:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D00830512D4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 06:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED1D3161A1;
	Fri, 29 May 2026 06:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="mwwBriYI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D91BBBFC
	for <linux-wireless@vger.kernel.org>; Fri, 29 May 2026 06:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780037111; cv=none; b=pk3Mn19ZWDDNReaHpzaLVwEzETYtODKwUmLPi3KTQfeMv27ud/TzriWU0xHtTNMpBieC6cfm8vf7oF5oo9nNITz/M3EPuV+ZCkFU1DH9khpL323/ogzQ6UAvynt9ajVeYwhYLw9PINgK3/lfHI1jClF14M4WQ8+FszYacN5Mopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780037111; c=relaxed/simple;
	bh=tgwqQCBekBqFWDHucX4zIhhX+R6hBYwAeiqwXwqefLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okVzhMVymF2Rg8ZubErQeO4e9rjqkRfxaDhEzxW+kegSLg27h3AqS4pHah73PKbC2x5bAupG7Bptv7co2Hy88HT2Z90mupNH72vJl55BMddrkPT64+uECDKrf9ip+V2MKb5VQW40uB32xuvdsU0Z2Z4PKzI4H0DQDmyeeDMkDIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=mwwBriYI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=HaCXtqjpibBXlFCDXGX/DLEXFILVLVSZaUbNr9RXgxQ=;
	t=1780037109; x=1781246709; b=mwwBriYIvRplrnNhzGZK9w4YIGgkifcKjC5tnKXCNKPG8Kb
	0UXEcOEonfThlKXffpo4dLaDcwzoT8E/WWtnD2UI0a6vBLWSj6Y3rqJre6JnrVr4k6AiKm9+zDsr4
	ixbkR7dUwAF3CDRpuVHfL9S9b8zENLJsJdc4/Jm+4JU+vWC9fT2NV/eO1ApZc7Bq3H4BilRYc3Ox/
	tInsGXxHnlJMWZaOw6Xr5FzR6kT8sYEefR2cMvL8Aq5hULb5N29BDddL0PcM7Fgo4zR1ufbIQvtGI
	bB3/LSCe/RbMY2tS97RelwkVNSLfMoMZfeNVyijjRpTOS6o33vcdSLNEcs7Khx1g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wSqxu-00000009XXt-2SPu;
	Fri, 29 May 2026 08:45:06 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 2/2] wifi: mac80211: remove 5/10 MHz channel code
Date: Fri, 29 May 2026 08:40:28 +0200
Message-ID: <20260529084502.4e5a9350206c.I2f6169a067ddd1b5e234668fcb6e07957fafacf2@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529064502.37422-4-johannes@sipsolutions.net>
References: <20260529064502.37422-4-johannes@sipsolutions.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
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
	TAGGED_FROM(0.00)[bounces-37101-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: 3708D5FE17A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

Now that cfg80211 refuses all attempts to use 5/10 MHz
channels, all of this code is unreachable; remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c        |  2 --
 net/mac80211/chan.c       |  4 +---
 net/mac80211/ibss.c       | 31 ++-----------------------------
 net/mac80211/mesh.c       | 36 +++++++++---------------------------
 net/mac80211/mesh_plink.c |  2 --
 net/mac80211/mlme.c       |  6 ++----
 net/mac80211/offchannel.c |  4 +---
 net/mac80211/rate.c       |  8 +-------
 net/mac80211/spectmgmt.c  | 10 ----------
 net/mac80211/util.c       |  7 -------
 10 files changed, 16 insertions(+), 94 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index fb4c1c298159..1554e31f0029 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4591,8 +4591,6 @@ static int ieee80211_set_csa_beacon(struct ieee80211_link_data *link_data,
 			    cfg80211_get_chandef_type(&sdata->u.ibss.chandef))
 				return -EINVAL;
 			break;
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
 		case NL80211_CHAN_WIDTH_20_NOHT:
 		case NL80211_CHAN_WIDTH_20:
 			break;
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 23d46cd57137..5152b84a3357 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -642,9 +642,7 @@ __ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	lockdep_assert_wiphy(local->hw.wiphy);
 
 	/* don't optimize non-20MHz based and radar_enabled confs */
-	if (ctx->conf.def.width == NL80211_CHAN_WIDTH_5 ||
-	    ctx->conf.def.width == NL80211_CHAN_WIDTH_10 ||
-	    ctx->conf.def.width == NL80211_CHAN_WIDTH_1 ||
+	if (ctx->conf.def.width == NL80211_CHAN_WIDTH_1 ||
 	    ctx->conf.def.width == NL80211_CHAN_WIDTH_2 ||
 	    ctx->conf.def.width == NL80211_CHAN_WIDTH_4 ||
 	    ctx->conf.def.width == NL80211_CHAN_WIDTH_8 ||
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 08690342cfaa..d0fd6054f182 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -167,8 +167,6 @@ ieee80211_ibss_build_presp(struct ieee80211_sub_if_data *sdata,
 
 	/* add HT capability and information IEs */
 	if (chandef->width != NL80211_CHAN_WIDTH_20_NOHT &&
-	    chandef->width != NL80211_CHAN_WIDTH_5 &&
-	    chandef->width != NL80211_CHAN_WIDTH_10 &&
 	    sband->ht_cap.ht_supported) {
 		struct ieee80211_sta_ht_cap ht_cap;
 
@@ -259,9 +257,7 @@ static void __ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 	chan = chanreq.oper.chan;
 	if (!cfg80211_reg_can_beacon(local->hw.wiphy, &chanreq.oper,
 				     NL80211_IFTYPE_ADHOC)) {
-		if (chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-		    chanreq.oper.width == NL80211_CHAN_WIDTH_10 ||
-		    chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
+		if (chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
 		    chanreq.oper.width == NL80211_CHAN_WIDTH_20) {
 			sdata_info(sdata,
 				   "Failed to join IBSS, beacons forbidden\n");
@@ -405,12 +401,6 @@ static void ieee80211_sta_join_ibss(struct ieee80211_sub_if_data *sdata,
 		chan_type = cfg80211_get_chandef_type(&sdata->u.ibss.chandef);
 		cfg80211_chandef_create(&chandef, cbss->channel, chan_type);
 		break;
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
-		cfg80211_chandef_create(&chandef, cbss->channel,
-					NL80211_CHAN_NO_HT);
-		chandef.width = sdata->u.ibss.chandef.width;
-		break;
 	case NL80211_CHAN_WIDTH_80:
 	case NL80211_CHAN_WIDTH_80P80:
 	case NL80211_CHAN_WIDTH_160:
@@ -762,8 +752,6 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
 	switch (ifibss->chandef.width) {
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20_NOHT:
 		conn.mode = IEEE80211_CONN_MODE_LEGACY;
 		fallthrough;
@@ -811,19 +799,6 @@ ieee80211_ibss_process_chanswitch(struct ieee80211_sub_if_data *sdata,
 		cfg80211_chandef_create(&params.chandef, params.chandef.chan,
 					ch_type);
 		break;
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
-		if (params.chandef.width != ifibss->chandef.width) {
-			sdata_info(sdata,
-				   "IBSS %pM received channel switch from incompatible channel width (%d MHz, width:%d, CF1/2: %d/%d MHz), disconnecting\n",
-				   ifibss->bssid,
-				   params.chandef.chan->center_freq,
-				   params.chandef.width,
-				   params.chandef.center_freq1,
-				   params.chandef.center_freq2);
-			goto disconnect;
-		}
-		break;
 	default:
 		/* should not happen, conn_flags should prevent VHT modes. */
 		WARN_ON(1);
@@ -1005,9 +980,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (sta && elems->ht_operation && elems->ht_cap_elem &&
-	    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_20_NOHT &&
-	    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_5 &&
-	    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_10) {
+	    sdata->u.ibss.chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
 		/* we both use HT */
 		struct ieee80211_ht_cap htcap_ie;
 		struct cfg80211_chan_def chandef;
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 04578447df9b..d4507e4e6ec1 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -439,9 +439,7 @@ int mesh_add_ht_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!sband->ht_cap.ht_supported ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_ht_cap))
@@ -480,9 +478,7 @@ int mesh_add_ht_oper_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!ht_cap->ht_supported ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_ht_operation))
@@ -511,9 +507,7 @@ int mesh_add_vht_cap_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!sband->vht_cap.vht_supported ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_vht_cap))
@@ -552,9 +546,7 @@ int mesh_add_vht_oper_ie(struct ieee80211_sub_if_data *sdata,
 		return 0;
 
 	if (!vht_cap->vht_supported ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	if (skb_tailroom(skb) < 2 + sizeof(struct ieee80211_vht_operation))
@@ -576,9 +568,7 @@ int mesh_add_he_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
-	if (sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	if (sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	return ieee80211_put_he_cap(skb, sdata, sband, NULL);
@@ -598,9 +588,7 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 
 	he_cap = ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 	if (!he_cap ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	len = 2 + 1 + sizeof(struct ieee80211_he_operation);
@@ -648,9 +636,7 @@ int mesh_add_eht_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
-	if (sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	if (sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	return ieee80211_put_eht_cap(skb, sdata, sband, NULL);
@@ -669,9 +655,7 @@ int mesh_add_eht_oper_ie(struct ieee80211_sub_if_data *sdata, struct sk_buff *sk
 
 	eht_cap = ieee80211_get_eht_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT);
 	if (!eht_cap ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return 0;
 
 	len = 2 + 1 + offsetof(struct ieee80211_eht_operation, optional) +
@@ -729,9 +713,7 @@ ieee80211_mesh_update_bss_params(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	if (!ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_MESH_POINT) ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_10)
+	    sdata->vif.bss_conf.chanreq.oper.width == NL80211_CHAN_WIDTH_20_NOHT)
 		return;
 
 	sdata->vif.bss_conf.he_support = true;
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 37adb053213e..268857467f29 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -165,8 +165,6 @@ static u64 mesh_set_ht_prot_mode(struct ieee80211_sub_if_data *sdata)
 
 	switch (sdata->vif.bss_conf.chanreq.oper.width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
 		return 0;
 	default:
 		break;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e8d6f6a95c0a..cfb5bc4eac69 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6376,10 +6376,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	ret = ieee80211_link_use_channel(link, &chanreq,
 					 IEEE80211_CHANCTX_SHARED);
 
-	/* don't downgrade for 5/10/S1G MHz channels, though. */
-	if (chanreq.oper.width == NL80211_CHAN_WIDTH_5 ||
-	    chanreq.oper.width == NL80211_CHAN_WIDTH_10 ||
-	    cfg80211_chandef_is_s1g(&chanreq.oper))
+	/* don't downgrade for S1G channels, though. */
+	if (cfg80211_chandef_is_s1g(&chanreq.oper))
 		return ret;
 
 	while (ret && chanreq.oper.width != NL80211_CHAN_WIDTH_20_NOHT) {
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index 8bec39b099a0..2bceb73717c6 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -355,9 +355,7 @@ static void _ieee80211_start_next_roc(struct ieee80211_local *local)
 		 * Note: scan can't run, tmp_channel is what we use, so this
 		 * must be the currently active channel.
 		 */
-		roc->on_channel = roc->chan == local->hw.conf.chandef.chan &&
-				  local->hw.conf.chandef.width != NL80211_CHAN_WIDTH_5 &&
-				  local->hw.conf.chandef.width != NL80211_CHAN_WIDTH_10;
+		roc->on_channel = roc->chan == local->hw.conf.chandef.chan;
 
 		/* start this ROC */
 		ieee80211_recalc_idle(local);
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index ba1a3aa3f5d4..64768abb0a5f 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -601,14 +601,8 @@ static void rate_idx_match_mask(s8 *rate_idx, u16 *rate_flags,
 			return;
 
 		/* if HT BSS, and we handle a data frame, also try HT rates */
-		switch (chan_width) {
-		case NL80211_CHAN_WIDTH_20_NOHT:
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
+		if (chan_width == NL80211_CHAN_WIDTH_20_NOHT)
 			return;
-		default:
-			break;
-		}
 
 		*rate_idx = 0;
 		/* keep protection flags */
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index e2eaf8d8d7ff..ec622750e1c9 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -329,16 +329,6 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	case -1:
 		cfg80211_chandef_create(&csa_ie->chanreq.oper, new_chan,
 					NL80211_CHAN_NO_HT);
-		/* keep width for 5/10 MHz channels */
-		switch (sdata->vif.bss_conf.chanreq.oper.width) {
-		case NL80211_CHAN_WIDTH_5:
-		case NL80211_CHAN_WIDTH_10:
-			csa_ie->chanreq.oper.width =
-				sdata->vif.bss_conf.chanreq.oper.width;
-			break;
-		default:
-			break;
-		}
 		break;
 	}
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 2a7ab269687a..f6d4ae4127c8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3816,13 +3816,6 @@ void ieee80211_chandef_downgrade(struct cfg80211_chan_def *c,
 		conn->mode = IEEE80211_CONN_MODE_S1G;
 		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
 		break;
-	case NL80211_CHAN_WIDTH_5:
-	case NL80211_CHAN_WIDTH_10:
-		WARN_ON_ONCE(1);
-		/* keep c->width */
-		conn->mode = IEEE80211_CONN_MODE_LEGACY;
-		conn->bw_limit = IEEE80211_CONN_BW_LIMIT_20;
-		break;
 	}
 
 	if (new_primary_width != NL80211_CHAN_WIDTH_20_NOHT) {
-- 
2.53.0


