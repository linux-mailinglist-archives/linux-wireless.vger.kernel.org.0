Return-Path: <linux-wireless+bounces-35466-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAQmFYN/8GnFUAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35466-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:36:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1C4818AF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 11:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7063530C4C61
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E638F642;
	Tue, 28 Apr 2026 09:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uOSQuJzG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A739387371
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368437; cv=none; b=h+kpU1H1v2d3ZNf4VQ2TUcVjHLEDfl/uk6fRyS3OVUd3skqC8vhU+OLAEhk+Ymc8sTy/uOmngJgKM55Z76Og8839ap0N1ewQF2RzHkQfs2/KOjVAhukuBnmF1INZX4+NKIyZxFbsPrOKKQXjLpiC3MJir77u9Ud6ltIGhj5iVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368437; c=relaxed/simple;
	bh=a7nFtpv8alwh5dVARv8Df9hFMoMfwrJCmA7lcC+mFqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTQBFhbrto5LD7d99NhToViAiCwQcPrOLt+BNdRXpKiPA/KgwoVzmMLycV5A3393vC3yKzFdOgWz1ZpLb34J2ytwCS5SIjLeaDiCvdtiR6xmGN6GfCy3pNlb70bo3nS5vHm9Wzsmlr2r2Gd/SbJfiFfuKYb79DC/1wD0dckm0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uOSQuJzG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4S71TAbewKMrr1Or4GBH/5G6w3FOI3sio4MCZdI9nwg=;
	t=1777368435; x=1778578035; b=uOSQuJzGLZq7XrjK8pqvRpbBzKctA17zyH0FkwAKZKYrNPh
	9nTG6LZxEjt4ckUqHwLdPRP54B6/oVumc5WLHUYhM+/xQMOWvphvjoQt0nC033y3rtpcuoYya5EtB
	eOBuBArutMj35sVOTjNRE2s+F2HgtKbKwsqW9cULTOT4ys/tR4l5NGQuDsxqEHNxT8zU2HMSvMo+v
	TVknqMuO1whykp4Io/JNsKhW8RDLdzQb60oNQ5HarSswzYmwFSl0VWifqZGN0UbwOssAQKq+s2rmt
	/dYNuSMB7FYTml8rhOqvLZ5asMXARkr0PaA7DfCVvRJ7mvZcjisVsDhSWgg/kIkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeim-0000000HLwg-1H0D;
	Tue, 28 Apr 2026 11:27:12 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 01/14] wifi: mac80211: use struct for ieee80211_determine_ap_chan() args
Date: Tue, 28 Apr 2026 11:25:29 +0200
Message-ID: <20260428112708.25728de3468e.Ic3b172b7a52f5876b3ea702bc1f092111db45f20@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428092708.71740-16-johannes@sipsolutions.net>
References: <20260428092708.71740-16-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DBB1C4818AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-35466-lists,linux-wireless=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]

From: Johannes Berg <johannes.berg@intel.com>

There are too many arguments, and we're going to need another one
for DBE. Collect them into a struct instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 57 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 00b4beff0e43..25c7427e11c4 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -149,20 +149,32 @@ static int ecw2cw(int ecw)
 	return (1 << ecw) - 1;
 }
 
+struct ieee80211_determine_ap_chan_data {
+	/* input data */
+	struct ieee80211_channel *channel;
+	const struct ieee802_11_elems *elems;
+	const struct ieee80211_conn_settings *conn;
+	u32 vht_cap_info;
+	bool ignore_ht_channel_mismatch;
+
+	/* target chandef is filled in */
+	struct cfg80211_chan_def *chandef;
+};
+
 static enum ieee80211_conn_mode
 ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
-			    struct ieee80211_channel *channel,
-			    u32 vht_cap_info,
-			    const struct ieee802_11_elems *elems,
-			    bool ignore_ht_channel_mismatch,
-			    const struct ieee80211_conn_settings *conn,
-			    struct cfg80211_chan_def *chandef)
+			    struct ieee80211_determine_ap_chan_data *data)
 {
+	bool ignore_ht_channel_mismatch = data->ignore_ht_channel_mismatch;
+	const struct ieee802_11_elems *elems = data->elems;
 	const struct ieee80211_ht_operation *ht_oper = elems->ht_operation;
 	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
 	const struct ieee80211_he_operation *he_oper = elems->he_operation;
 	const struct ieee80211_eht_operation *eht_oper = elems->eht_operation;
 	const struct ieee80211_uhr_operation *uhr_oper = elems->uhr_operation;
+	const struct ieee80211_conn_settings *conn = data->conn;
+	struct ieee80211_channel *channel = data->channel;
+	struct cfg80211_chan_def *chandef = data->chandef;
 	struct ieee80211_supported_band *sband =
 		sdata->local->hw.wiphy->bands[channel->band];
 	struct cfg80211_chan_def vht_chandef;
@@ -288,7 +300,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		memcpy(&he_oper_vht_cap, he_oper->optional, 3);
 		he_oper_vht_cap.basic_mcs_set = cpu_to_le16(0);
 
-		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
+		if (!ieee80211_chandef_vht_oper(&sdata->local->hw, data->vht_cap_info,
 						&he_oper_vht_cap, ht_oper,
 						&vht_chandef)) {
 			sdata_info(sdata,
@@ -303,7 +315,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 	} else if (sband->band == NL80211_BAND_2GHZ) {
 		no_vht = true;
 	} else if (!ieee80211_chandef_vht_oper(&sdata->local->hw,
-					       vht_cap_info,
+					       data->vht_cap_info,
 					       vht_oper, ht_oper,
 					       &vht_chandef)) {
 		sdata_info(sdata,
@@ -1085,6 +1097,13 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	enum ieee80211_conn_mode ap_mode;
 	unsigned long unknown_rates_selectors[BITS_TO_LONGS(128)] = {};
 	unsigned long sta_selectors[BITS_TO_LONGS(128)] = {};
+	struct ieee80211_determine_ap_chan_data ap_chan_data = {
+		.channel = channel,
+		.vht_cap_info = bss->vht_cap_info,
+		.ignore_ht_channel_mismatch = false,
+		.chandef = ap_chandef,
+		.conn = conn,
+	};
 	int ret;
 
 again:
@@ -1093,8 +1112,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 	if (!elems)
 		return ERR_PTR(-ENOMEM);
 
-	ap_mode = ieee80211_determine_ap_chan(sdata, channel, bss->vht_cap_info,
-					      elems, false, conn, ap_chandef);
+	ap_chan_data.elems = elems;
+	ap_mode = ieee80211_determine_ap_chan(sdata, &ap_chan_data);
 
 	/* this should be impossible since parsing depends on our mode */
 	if (WARN_ON(ap_mode > conn->mode)) {
@@ -1322,12 +1341,19 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       bool update, u64 *changed, u16 stype)
 {
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
+	struct cfg80211_chan_def ap_chandef;
+	struct ieee80211_determine_ap_chan_data ap_chan_data = {
+		.channel = channel,
+		.vht_cap_info = 0,
+		.ignore_ht_channel_mismatch = true,
+		.chandef = &ap_chandef,
+		.elems = elems,
+		.conn = &link->u.mgd.conn,
+	};
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chan_req chanreq = {};
-	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
 	const char *frame;
-	u32 vht_cap_info = 0;
 	u16 ht_opmode;
 	int ret;
 
@@ -1355,11 +1381,10 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return 0;
 
 	if (elems->vht_cap_elem)
-		vht_cap_info = le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
+		ap_chan_data.vht_cap_info =
+			le32_to_cpu(elems->vht_cap_elem->vht_cap_info);
 
-	ap_mode = ieee80211_determine_ap_chan(sdata, channel, vht_cap_info,
-					      elems, true, &link->u.mgd.conn,
-					      &ap_chandef);
+	ap_mode = ieee80211_determine_ap_chan(sdata, &ap_chan_data);
 
 	if (ap_mode != link->u.mgd.conn.mode) {
 		link_info(link,
-- 
2.53.0


