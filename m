Return-Path: <linux-wireless+bounces-34792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EA0ULvyI32kHVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:56 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B802404704
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 885003107090
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E170532E151;
	Wed, 15 Apr 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="C154ehsG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E9F3242B1
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257137; cv=none; b=hcjQ2X5EiRBPkG3qb55AducTD8l2J8gqDpEjzsqqGqIVNNbrJiYjXGMRWQrBA6NE/0YlWwWlhQMfraUR17fsD2K+udoRnaXFi+JGQa1Bv+s5Ic1SpRG21XdtrYX4h4rFyypaFIjPvkQfaJHeDtUTOXpBUdq3+aQwFlgh0qojan4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257137; c=relaxed/simple;
	bh=CtY6WluEjBN33aGaTrxi3PaINERKanFJxdCP1FnLsos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=doLMec1rr20iP1LtdcbV7TC2jv5bQrCnCr/zaMVz3+ZkAeh9YR7Sc/eaIUFMRAc5RaXwxgMYe/kqDknuVTyOannM09TWmer0tESurTdtmPATbGc0acQSr4tJr+GiRC0RMpNlxJu89nAAQcSFREUpAs4rW4i/EOARasCv+L22JyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=C154ehsG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=eQmSpeSI/vxECr4S/y1/wZBhQ0hD+b2hrgFs+8zkotI=;
	t=1776257134; x=1777466734; b=C154ehsGARL96gYggdUROPbHDlRqskLSIstlkONigVVuw4a
	TRKBPv8ewAWdVwlzT1YZIlM3nfhaNOLW/RyMG3Kyb54balRTP4j2+z4yjQ4R6wsQJqVyBjTEiNw5z
	P564LtB+MBx2lgiHQbX0hTub9kjQHTCGMN7GVhuz7BmtOSnBSp9EzHloqosviUtdp1NT0mZaVrGHj
	jdJrEnrXcm1qzY4w2a15nhbZWT5d79sMmkiLQElaeu87RmjQ7sU5BvMsGYLUcnG4wMT7TYUxI3jTo
	N0W3IPoldc1gDMk275LPpcMQUes6RdRF6shoDZMP80HWdXWZ9TZjKRJKwCHYzBYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzca-00000006OgW-04Rc;
	Wed, 15 Apr 2026 14:45:32 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 20/20] wifi: mac80211: fix per-station PHY capability bandwidth
Date: Wed, 15 Apr 2026 14:42:18 +0200
Message-ID: <20260415144514.d41efd67876c.I29ef615e6ab049a56c20f3226b5e953859f890b0@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34792-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B802404704
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When a (link) station connected to an AP interface is not
capable of EHT, it's possible that the AP interface is in
160 MHz but the HE channel is narrower, e.g. when EHT has
puncturing.  In this case, the code doesn't correctly set
the STAs bandwidth, the station might be capable of using
160 MHz, but it can't use EHT 160 MHz with puncturing, so
it must be set to narrower.

Track the AP's 'he_and_lower_bw' bandwidth, use that when
calculating the maximum bandwidth to transmit to/from any
station not capable of EHT, and update all stations and
the chanctx min_def when it changes.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 116 +++++++++++++++++++++++++++++++++++++
 net/mac80211/chan.c        |   9 +--
 net/mac80211/ieee80211_i.h |   4 ++
 net/mac80211/sta_info.c    |  47 ++++++++++++++-
 4 files changed, 170 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index bc4a8e5ad039..00261bd6674b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1312,6 +1312,120 @@ ieee80211_copy_rnr_beacon(u8 *pos, struct cfg80211_rnr_elems *dst,
 	return offset;
 }
 
+static enum ieee80211_sta_rx_bandwidth
+ieee80211_calc_ap_he_and_lower(struct cfg80211_beacon_data *params)
+{
+	const struct ieee80211_vht_operation *vht_oper = params->vht_oper;
+	int ccfs0, ccfs1;
+
+	if (params->he_oper) {
+		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+
+		if (params->he_oper->he_oper_params &
+				cpu_to_le32(IEEE80211_HE_OPERATION_VHT_OPER_INFO))
+			vht_oper = (void *)params->he_oper->optional;
+
+		he_6ghz_oper = ieee80211_he_6ghz_oper(params->he_oper);
+		if (he_6ghz_oper) {
+			switch (u8_get_bits(he_6ghz_oper->control,
+					    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
+			case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
+				return IEEE80211_STA_RX_BW_20;
+			case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ:
+				return IEEE80211_STA_RX_BW_40;
+			case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ:
+				return IEEE80211_STA_RX_BW_80;
+			case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
+				return IEEE80211_STA_RX_BW_160;
+			}
+		}
+	}
+
+	if (vht_oper) {
+		switch (vht_oper->chan_width) {
+		case IEEE80211_VHT_CHANWIDTH_USE_HT:
+			/* check for HT (or fall down to 20) below */
+			break;
+		case IEEE80211_VHT_CHANWIDTH_160MHZ:
+		case IEEE80211_VHT_CHANWIDTH_80P80MHZ:
+			/* deprecated encodings */
+			return IEEE80211_STA_RX_BW_160;
+		case IEEE80211_VHT_CHANWIDTH_80MHZ:
+			/*
+			 * See IEEE 802.11-2020 Table 9-352-BSS bandwidth
+			 * when the VHT Operation Information field Channel
+			 * Width subfield is 1
+			 *
+			 * (IEEE80211_VHT_CHANWIDTH_80MHZ == 1)
+			 */
+			ccfs0 = vht_oper->center_freq_seg0_idx;
+			ccfs1 = vht_oper->center_freq_seg1_idx;
+			if (!ccfs0)
+				return IEEE80211_STA_RX_BW_80;
+			if (ccfs1 && abs(ccfs1 - ccfs0) == 8)
+				return IEEE80211_STA_RX_BW_160;
+			/* 80+80 - RX BW doesn't cover that / uses 160 */
+			if (ccfs1 && abs(ccfs1 - ccfs0) > 16)
+				return IEEE80211_STA_RX_BW_160;
+			fallthrough;
+		default:
+			/* reserved encoding - assume 80 */
+			return IEEE80211_STA_RX_BW_80;
+		}
+	}
+
+	if (params->ht_oper) {
+		switch (u8_get_bits(params->ht_oper->ht_param,
+				    IEEE80211_HT_PARAM_CHA_SEC_OFFSET)) {
+		case IEEE80211_HT_PARAM_CHA_SEC_NONE:
+		default: /* invalid values */
+			return IEEE80211_STA_RX_BW_20;
+		case IEEE80211_HT_PARAM_CHA_SEC_ABOVE:
+		case IEEE80211_HT_PARAM_CHA_SEC_BELOW:
+			return IEEE80211_STA_RX_BW_40;
+		}
+	}
+
+	/* nothing found, must be 20 MHz */
+	return IEEE80211_STA_RX_BW_20;
+}
+
+static void ieee80211_update_ap_bandwidth(struct ieee80211_link_data *link,
+					  struct cfg80211_beacon_data *params)
+{
+	struct ieee80211_local *local = link->sdata->local;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	struct ieee80211_chanctx *chanctx;
+
+	/*
+	 * Updating the beacon might, without even changing the channel, cause
+	 * the usable bandwidth for some stations to be changed, for example
+	 * if the beacon configuration is EHT with 160 MHz, HE could change
+	 * between 20, 40, 80 and 160 MHz, and HE (or lower) clients need to
+	 * be handled accordingly.
+	 * Calculate the HE and lower bandwidth and apply that to all stations.
+	 *
+	 * In the future, this also needs to calculate EHT bandwidth and apply
+	 * it to all stations not using UHR DBE, since the chandef would then
+	 * include DBE.
+	 */
+
+	if (link->conf->chanreq.oper.chan->band == NL80211_BAND_S1GHZ)
+		return;
+
+	link->bss_bw.he_and_lower = ieee80211_calc_ap_he_and_lower(params);
+
+	chanctx_conf = sdata_dereference(link->conf->chanctx_conf, link->sdata);
+	chanctx = container_of(chanctx_conf, struct ieee80211_chanctx, conf);
+
+	/*
+	 * Note: this relies on ieee80211_recalc_chanctx_min_def() having
+	 * the side effect of updating all stations, if they changed; that
+	 * was normally for when the chandef changed but is used here too.
+	 */
+	ieee80211_recalc_chanctx_min_def(local, chanctx);
+}
+
 static int
 ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 			struct ieee80211_link_data *link,
@@ -1450,6 +1564,8 @@ ieee80211_assign_beacon(struct ieee80211_sub_if_data *sdata,
 	if (old)
 		kfree_rcu(old, rcu_head);
 
+	ieee80211_update_ap_bandwidth(link, params);
+
 	*changed |= _changed;
 	return 0;
 }
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index ecc0123ed448..248531051a4e 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -718,6 +718,9 @@ static void ieee80211_chan_bw_change(struct ieee80211_local *local,
  * recalc the min required chan width of the channel context, which is
  * the max of min required widths of all the interfaces bound to this
  * channel context.
+ *
+ * Note: ieee80211_update_ap_bandwidth() relies on this iterating all
+ *	 affected stations, even if min_def didn't change.
  */
 static void
 _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
@@ -728,13 +731,11 @@ _ieee80211_recalc_chanctx_min_def(struct ieee80211_local *local,
 	u32 changed = __ieee80211_recalc_chanctx_min_def(local, ctx, rsvd_for,
 							 check_reserved);
 
-	if (!changed)
-		return;
-
 	/* check is BW narrowed */
 	ieee80211_chan_bw_change(local, ctx, false, true);
 
-	drv_change_chanctx(local, ctx, changed);
+	if (changed)
+		drv_change_chanctx(local, ctx, changed);
 
 	/* check is BW wider */
 	ieee80211_chan_bw_change(local, ctx, false, false);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f1bab633697e..e23e347f870d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1133,6 +1133,10 @@ struct ieee80211_link_data {
 
 	struct ieee80211_bss_conf *conf;
 
+	struct {
+		enum ieee80211_sta_rx_bandwidth he_and_lower;
+	} bss_bw;
+
 #ifdef CONFIG_MAC80211_DEBUGFS
 	struct dentry *debugfs_dir;
 #endif
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index ec043d88a6a9..aba2fabfe0db 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3623,6 +3623,49 @@ ieee80211_sta_bw_capability(struct link_sta_info *link_sta,
 	return IEEE80211_STA_RX_BW_80;
 }
 
+/**
+ * ieee80211_sta_usable_bw - get STA's usable bandwidth capability
+ * @link_sta: the (link) STA to get the capability for
+ * @band: the band to get the capability on
+ *
+ * If the STA is on an AP interface, take into account the AP's
+ * bandwidth corresponding to this station's PHY capability
+ *
+ * Return: the maximum bandwidth supported by the STA on the
+ *	connection to the interface it's connected to
+ */
+static enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_usable_bw(struct link_sta_info *link_sta,
+			enum nl80211_band band)
+{
+	struct ieee80211_sub_if_data *sdata = link_sta->sta->sdata;
+	enum ieee80211_sta_rx_bandwidth bw;
+	struct ieee80211_link_data *link;
+
+	bw = ieee80211_sta_bw_capability(link_sta, band);
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN) {
+		sdata = get_bss_sdata(sdata);
+
+		/* for a STA to exist on VLAN, it must have AP */
+		if (WARN_ON(!sdata))
+			return IEEE80211_STA_RX_BW_20;
+	}
+
+	if (sdata->vif.type != NL80211_IFTYPE_AP)
+		return bw;
+
+	/* for a link STA to exist, vif must have the link */
+	link = sdata_dereference(sdata->link[link_sta->link_id], sdata);
+	if (WARN_ON(!link))
+		return IEEE80211_STA_RX_BW_20;
+
+	if (link_sta->pub->eht_cap.has_eht)
+		return bw;
+
+	return min(bw, link->bss_bw.he_and_lower);
+}
+
 static enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_current_bw_rx_from_sta(struct link_sta_info *link_sta,
 				     struct cfg80211_chan_def *chandef)
@@ -3637,7 +3680,7 @@ ieee80211_sta_current_bw_rx_from_sta(struct link_sta_info *link_sta,
 	 * at a higher bandwidth first while reducing bandwidth, and
 	 * change the chanctx only after the peer accepts, etc.)
 	 */
-	return min(ieee80211_sta_bw_capability(link_sta, chandef->chan->band),
+	return min(ieee80211_sta_usable_bw(link_sta, chandef->chan->band),
 		   link_sta->rx_omi_bw_rx);
 }
 
@@ -3653,7 +3696,7 @@ ieee80211_sta_current_bw_tx_to_sta(struct link_sta_info *link_sta,
 	bss_width = chandef->width;
 	band = chandef->chan->band;
 
-	bw = ieee80211_sta_bw_capability(link_sta, band);
+	bw = ieee80211_sta_usable_bw(link_sta, band);
 	bw = min(bw, link_sta->op_mode_bw);
 	/* also limit to RX OMI bandwidth we TX to the STA */
 	bw = min(bw, link_sta->rx_omi_bw_tx);
-- 
2.53.0


