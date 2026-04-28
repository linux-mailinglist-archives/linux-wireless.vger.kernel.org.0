Return-Path: <linux-wireless+bounces-35475-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFp+Ip2G8GnuUQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35475-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:06:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D2D48235B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 12:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36A2531EA44B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87360399004;
	Tue, 28 Apr 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tpJ2+kRm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E938838C
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 09:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368444; cv=none; b=O63v0MfK2XeMvTq1v5oRp7IdUTEKY/1xc0fPig8G6VRH3An2Vpj4YUJdG8hEP0TyeuVLwPmxJlMtT2GzqP49csa6tuQjBoGNPvBjSNk0qQC9jLNXjLOipU86mULEoRZFjodgMQzolxyap6kC9wK0M1kp+4f7YhYX7lgFt/jZR8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368444; c=relaxed/simple;
	bh=/By3Ucv+5bJK0taNEjUqEplGLu3pWIaHkl5TkiFCtS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QIZyOO7rAW/GV/b4enkHg8aCGsqcsvuCkEnTJJN+0nO1SU9Lot5UBZ4GN8vaPT52joPztn+P6KNJbcnolbXSRdu1DBGJiHFL1L2yyU4+APPJH7qlmL1n5DTUZik869JSMnB2omENqf7sLF4OBu6/fobGnac7AUNEVArtgmJUx7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net; spf=none smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tpJ2+kRm; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3dqQzEzmOF4zWYvsFzKRCL2LoqOMhHMAhDEcyMSCm0M=;
	t=1777368442; x=1778578042; b=tpJ2+kRmRqsMDNXE5yGKi7MZnlNMh4asgdCfAn9g3P7qHhB
	ft5sCbHWQxO//qUdw8ZDzuAA+1DXcJyyNaztaSEpUJpTCdxkSs5ZfhGN6NLL9pfOYcBfQxsdC2vQI
	+BDHYIe+8NecOcYrQjmvSuhzC8unwSG6NqrSze9jOkxjzunSzFXx2RhWsczbPHiIJ/+jfKapIYMIR
	5xPlDLLita+ibwMztJTIRymfN7c6TBSDqznJTHi2HQZbRyiYVmm4kQnEchpiFlBTXmn6ShAc0xXFs
	7q+bn8r/XrUhyqFwBX1Rk0cnNFK+aTR9OfMmeGKVPdN6x6zs6smgl82mREVGODMQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wHeiu-0000000HLwg-25CO;
	Tue, 28 Apr 2026 11:27:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 10/14] wifi: mac80211: mlme: use NPCA chandef if capable
Date: Tue, 28 Apr 2026 11:25:38 +0200
Message-ID: <20260428112708.eb1e42c0b6d7.I0acd8445d4600363afb8430922531450399d0fab@changeid>
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
X-Rspamd-Queue-Id: 33D2D48235B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-35475-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sipsolutions.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Johannes Berg <johannes.berg@intel.com>

If the device is capable, parse the AP chandef with NPCA.
Also advertise the other NPCA operational parameters to the
underlying driver and track if they change (though not with
BSS critical update etc. yet)

Since NPCA can only be enabled when the chanctx isn't shared,
the channel context code needs to clear/set npca.enabled in
the per-link configuration, except during association since
we can't enable NPCA before having completed association. In
this case, set npca.enabled during the association process.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 25 ++++++++++++++
 net/mac80211/chan.c    | 38 +++++++++++++++++++++
 net/mac80211/mlme.c    | 77 +++++++++++++++++++++++++++++++++++++++++-
 net/mac80211/util.c    |  3 ++
 4 files changed, 142 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 62bfa298c67f..316554c0a047 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -373,6 +373,7 @@ struct ieee80211_vif_chanctx_switch {
  * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
  * @BSS_CHANGED_TPE: transmit power envelope changed
  * @BSS_CHANGED_NAN_LOCAL_SCHED: NAN local schedule changed (NAN mode only)
+ * @BSS_CHANGED_NPCA: NPCA parameters changed
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -411,6 +412,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
 	BSS_CHANGED_TPE			= BIT_ULL(35),
 	BSS_CHANGED_NAN_LOCAL_SCHED	= BIT_ULL(36),
+	BSS_CHANGED_NPCA		= BIT_ULL(37),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
@@ -596,6 +598,26 @@ struct ieee80211_parsed_tpe {
 	struct ieee80211_parsed_tpe_psd psd_local[2], psd_reg_client[2];
 };
 
+/**
+ * struct ieee80211_bss_npca_params - NPCA parameters
+ * @min_dur_thresh: NPCA minimum duration threshold (512 + 128*n usec)
+ * @switch_delay: NPCA switch delay (units of 4 usec)
+ * @switch_back_delay: NPCA switch back delay (units of 4 usec)
+ * @init_qsrc: initial QSRC value
+ * @moplen: indicates MOPLEN NPCA is permitted in the BSS
+ * @enabled: NPCA is enabled for this link
+ *
+ * Note: the individual values (except @enabled) are in spec representation.
+ */
+struct ieee80211_bss_npca_params {
+	u32 min_dur_thresh:4,
+	    switch_delay:6,
+	    switch_back_delay:6,
+	    init_qsrc:2,
+	    moplen:1,
+	    enabled:1;
+};
+
 /**
  * struct ieee80211_bss_conf - holds the BSS's changing parameters
  *
@@ -770,6 +792,7 @@ struct ieee80211_parsed_tpe {
  *	(as opposed to hearing its value from another link's beacon).
  * @s1g_long_beacon_period: number of beacon intervals between each long
  *	beacon transmission.
+ * @npca: NPCA parameters
  */
 struct ieee80211_bss_conf {
 	struct ieee80211_vif *vif;
@@ -873,6 +896,8 @@ struct ieee80211_bss_conf {
 	u8 bss_param_ch_cnt_link_id;
 
 	u8 s1g_long_beacon_period;
+
+	struct ieee80211_bss_npca_params npca;
 };
 
 #define IEEE80211_NAN_MAX_CHANNELS 3
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 6c7f5c9de026..d15cb1c22cf4 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -769,6 +769,38 @@ void ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	_ieee80211_recalc_chanctx_min_def(local, ctx, NULL, false);
 }
 
+static void
+ieee80211_chanctx_update_npca_links(struct ieee80211_local *local,
+				    struct ieee80211_chanctx *ctx,
+				    bool enable)
+{
+	struct ieee80211_chanctx_user_iter iter;
+
+	if (!!ctx->conf.def.npca_chan != enable)
+		return;
+
+	for_each_chanctx_user_assigned(local, ctx, &iter) {
+		if (!iter.link)
+			continue;
+		if (!iter.sdata->vif.cfg.assoc)
+			continue;
+
+		if (enable) {
+			if (!iter.link->conf->chanreq.oper.npca_chan)
+				continue;
+		} else {
+			if (!iter.link->conf->npca.enabled)
+				continue;
+		}
+
+		iter.link->conf->npca.enabled = enable;
+		drv_link_info_changed(local, iter.sdata,
+				      iter.link->conf,
+				      iter.link->link_id,
+				      BSS_CHANGED_NPCA);
+	}
+}
+
 static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 				      struct ieee80211_chanctx *ctx,
 				      struct ieee80211_chanctx *old_ctx,
@@ -844,10 +876,16 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 
 	ieee80211_add_wbrf(local, &ctx->conf.def);
 
+	/* disable NPCA on the link using it */
+	ieee80211_chanctx_update_npca_links(local, ctx, false);
+
 	drv_change_chanctx(local, ctx, changed);
 
 	/* check if BW is wider */
 	ieee80211_chan_bw_change(local, old_ctx, false, false);
+
+	/* enable NPCA on the link that requested it */
+	ieee80211_chanctx_update_npca_links(local, ctx, true);
 }
 
 static void ieee80211_change_chanctx(struct ieee80211_local *local,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 247871c10615..0ed3e23c6e60 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -401,6 +401,7 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 				       elems->uhr_operation_len,
 				       false)) {
 		struct cfg80211_chan_def npca_chandef = *chandef;
+		const struct ieee80211_sta_uhr_cap *uhr_cap;
 		const struct ieee80211_uhr_npca_info *npca;
 
 		npca = ieee80211_uhr_npca_info(uhr_oper);
@@ -411,6 +412,14 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 				   "AP UHR NPCA settings invalid, disabling UHR\n");
 			return IEEE80211_CONN_MODE_EHT;
 		}
+
+		uhr_cap = ieee80211_get_uhr_iftype_cap_vif(sband, &sdata->vif);
+		/* can't happen since we must have UHR to parse the elems */
+		if (WARN_ON(!uhr_cap))
+			return IEEE80211_CONN_MODE_EHT;
+
+		if (uhr_cap->mac.mac_cap[0] & IEEE80211_UHR_MAC_CAP0_NPCA_SUPP)
+			*chandef = npca_chandef;
 	}
 
 	return IEEE80211_CONN_MODE_UHR;
@@ -1320,6 +1329,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		.conn = &link->u.mgd.conn,
 	};
 	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_chan_req chanreq = {};
 	enum ieee80211_conn_mode ap_mode;
 	const char *frame;
@@ -1403,8 +1413,55 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		}
 	}
 
-	if (ieee80211_chanreq_identical(&chanreq, &link->conf->chanreq))
+	/*
+	 * Beacons don't have the full information - we need to track
+	 * critical updates for NPCA parameters etc. For now only handle
+	 * association and link reconfiguration response.
+	 */
+	if (stype != IEEE80211_STYPE_BEACON &&
+	    chanreq.oper.npca_chan && elems->uhr_operation &&
+	    ieee80211_uhr_oper_size_ok((const void *)elems->uhr_operation,
+				       elems->uhr_operation_len,
+				       false)) {
+		const struct ieee80211_uhr_npca_info *npca;
+		struct ieee80211_bss_npca_params params = {};
+
+		npca = ieee80211_uhr_npca_info(elems->uhr_operation);
+		if (!npca) {
+			chanreq.oper.npca_chan = NULL;
+			chanreq.oper.npca_punctured = 0;
+		} else {
+			params.min_dur_thresh =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_MIN_DUR_THRESH);
+			params.switch_delay =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_DELAY);
+			params.switch_back_delay =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_SWITCH_BACK_DELAY);
+			params.init_qsrc =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_INIT_QSRC);
+			params.moplen =
+				le32_get_bits(npca->params,
+					      IEEE80211_UHR_NPCA_PARAMS_MOPLEN);
+			/* don't change the enabled bit yet */
+			params.enabled = link->conf->npca.enabled;
+		}
+
+		if (memcmp(&params, &link->conf->npca, sizeof(params)) ||
+		    !update) {
+			link->conf->npca = params;
+			*changed |= BSS_CHANGED_NPCA;
+		}
+	}
+
+	if (ieee80211_chanreq_identical(&chanreq, &link->conf->chanreq)) {
+		if (update)
+			goto update_npca;
 		return 0;
+	}
 
 	link_info(link,
 		  "AP %pM changed bandwidth in %s, new used config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
@@ -1451,6 +1508,24 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	}
 
 	cfg80211_schedule_channels_check(&sdata->wdev);
+
+update_npca:
+	chanctx_conf = sdata_dereference(link->conf->chanctx_conf, sdata);
+	/* must be non-NULL when update is true */
+	if (WARN_ON(!chanctx_conf))
+		return -EINVAL;
+
+	/*
+	 * If we're not associated yet (i.e. in the process associating)
+	 * then the chanctx code won't have enabled NPCA in the link, so
+	 * if the channel context was set up with NPCA for us, enable it.
+	 */
+	if (chanreq.oper.npca_chan && chanctx_conf->def.npca_chan &&
+	    !link->conf->npca.enabled && !sdata->vif.cfg.assoc) {
+		link->conf->npca.enabled = true;
+		*changed |= BSS_CHANGED_NPCA;
+	}
+
 	return 0;
 }
 
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8c816a2a65f2..19afa0bdbf25 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2147,6 +2147,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 				ieee80211_bss_info_change_notify(sdata,
 								 changed);
 			} else if (!WARN_ON(!link)) {
+				if (link->conf->npca.enabled)
+					changed |= BSS_CHANGED_NPCA;
+
 				ieee80211_link_info_change_notify(sdata, link,
 								  changed);
 				changed = BSS_CHANGED_ASSOC |
-- 
2.53.0


