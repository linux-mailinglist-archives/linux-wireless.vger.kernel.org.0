Return-Path: <linux-wireless+bounces-32411-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AGzI/vxpmmSagAAu9opvQ
	(envelope-from <linux-wireless+bounces-32411-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:36:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D93D1F19B1
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 15:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0352302E1DE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2436543C060;
	Tue,  3 Mar 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="jAuPBDwp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F09E4301D4
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548487; cv=none; b=n7ztJc/h9cTotBWD9LCDwmf53QM00i0xPTPl7Ev715gQtAqIMfdqa0tJYWWunYXYzI9WPtASMRCKcbWin/KsrcLwts93Jf+J1vx6fUwHHgvSLtUUCisavKpy3e1Jp0mDeS1ZvO1zZY719kB/MwZTO6lwlkKkitvlybgZ8t3pYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548487; c=relaxed/simple;
	bh=lXLAFup6ebExM/SCklkl0UXGvUR7ixGhxCn0/5xCzNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOtH6dYee4BJAZHJb9WuxHZMnbH/ZgY14hGanAHaLAlYp4atcrcpw9de7+WN9XMUtDRw6pRB//LIRY1ugd+s8r+MyOtDNvL4iDcT3jAo2Ss9p4g1SCkhwhqMNAjV78zV+zSZ0CZCkQKrsSpoIkuDWbiwMoHNBx8+8gkeIIhmx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=jAuPBDwp; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SDNTx0FdIFOKHWX4MqGRzI6ktcviNtaFoqimA7Flzks=;
	t=1772548485; x=1773758085; b=jAuPBDwpL9KRwG3NqszE0GvHMKawoPysHVKtUMVLxFO1xK0
	ZqV6nyDFmEd174Eh9szTTFXpvNPWWr/4zBYnPyg0AXAPIZVHZJHn2CIWH7mg24sFwOi0L+dnWl0q9
	1ZtPV8vJBBSx3M3XzjCSUAlr1L60TQsI9JA6z2ejsc7SBgSJ555mHVjT1ZQqmn3sjgsDCyVod0QJR
	EaqNazOEs/GRhsepfpdUnFgT7BMFWrg/8jeH+yQ8dJ31timK3kIl3ndqSEkvTXV4jPl59Yj+Oqzxp
	PPsOZGjn5J0iydqCkbajkK8C3hO1fnimGHkZ1s4thve8CyYt1bgMulpV7Wa0VmKA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vxQpd-00000007A1T-3MJt;
	Tue, 03 Mar 2026 15:34:42 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC wireless-next 6/8] wifi: mac80211: allow only AP chanctx sharing with NPCA
Date: Tue,  3 Mar 2026 15:27:01 +0100
Message-ID: <20260303153435.e544cd01d457.I08a7c7f47d796f4d5d8f9a682c1fba37db2e4cf5@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303143434.273141-10-johannes@sipsolutions.net>
References: <20260303143434.273141-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D93D1F19B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-32411-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

When two interfaces share a channel context, disable NPCA
unless both are AP interfaces that require NPCA. This way,
two AP interfaces can have identical chandefs set up and
share the channel context, but any non-APs cannot share a
chanctx with NPCA (they'd almost certainly have different
BSS color.)

This doesn't mean the chanctx cannot be shared but rather
that NPCA will be disabled on the shared channel context.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  7 +++++++
 net/mac80211/cfg.c     | 15 ++++++++++++---
 net/mac80211/chan.c    | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 9f8251fb9832..11ee96aeb155 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -218,6 +218,8 @@ struct ieee80211_low_level_stats {
  *	bandwidth) OFDMA settings need to be changed
  * @IEEE80211_CHANCTX_CHANGE_PUNCTURING: The punctured channel(s) bitmap
  *	was changed.
+ * @IEEE80211_CHANCTX_CHANGE_NPCA: NPCA configuration changed
+ * @IEEE80211_CHANCTX_CHANGE_NPCA_PUNCT: NPCA puncturing changed
  */
 enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_WIDTH		= BIT(0),
@@ -227,6 +229,8 @@ enum ieee80211_chanctx_change {
 	IEEE80211_CHANCTX_CHANGE_MIN_DEF	= BIT(4),
 	IEEE80211_CHANCTX_CHANGE_AP		= BIT(5),
 	IEEE80211_CHANCTX_CHANGE_PUNCTURING	= BIT(6),
+	IEEE80211_CHANCTX_CHANGE_NPCA		= BIT(7),
+	IEEE80211_CHANCTX_CHANGE_NPCA_PUNCT	= BIT(8),
 };
 
 /**
@@ -234,10 +238,13 @@ enum ieee80211_chanctx_change {
  * @oper: channel definition to use for operation
  * @ap: the channel definition of the AP, if any
  *	(otherwise the chan member is %NULL)
+ * @require_npca: If NPCA is configured, require it to
+ *	remain, this is used by AP interfaces
  */
 struct ieee80211_chan_req {
 	struct cfg80211_chan_def oper;
 	struct cfg80211_chan_def ap;
+	bool require_npca;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index ee64ac8e0f61..a1691b9bfceb 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1493,7 +1493,10 @@ static int ieee80211_start_ap(struct wiphy *wiphy, struct net_device *dev,
 	unsigned int link_id = params->beacon.link_id;
 	struct ieee80211_link_data *link;
 	struct ieee80211_bss_conf *link_conf;
-	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
+	struct ieee80211_chan_req chanreq = {
+		.oper = params->chandef,
+		.require_npca = true,
+	};
 	u64 tsf;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -4349,7 +4352,10 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 			   struct cfg80211_csa_settings *params)
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
-	struct ieee80211_chan_req chanreq = { .oper = params->chandef };
+	struct ieee80211_chan_req chanreq = {
+		.oper = params->chandef,
+		.require_npca = true,
+	};
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_channel_switch ch_switch = {
 		.link_id = params->link_id,
@@ -4791,7 +4797,10 @@ static int ieee80211_set_ap_chanwidth(struct wiphy *wiphy,
 {
 	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
 	struct ieee80211_link_data *link;
-	struct ieee80211_chan_req chanreq = { .oper = *chandef };
+	struct ieee80211_chan_req chanreq = {
+		.oper = *chandef,
+		.require_npca = true,
+	};
 	int ret;
 	u64 changed = 0;
 
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 2f0c93f3ace6..26ae7da3b2fd 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -223,19 +223,41 @@ ieee80211_chanreq_compatible(const struct ieee80211_chan_req *a,
 			     const struct ieee80211_chan_req *b,
 			     struct ieee80211_chan_req *tmp)
 {
+	struct ieee80211_chan_req _a = *a, _b = *b;
 	const struct cfg80211_chan_def *compat;
 
 	if (a->ap.chan && b->ap.chan &&
 	    !cfg80211_chandef_identical(&a->ap, &b->ap))
 		return NULL;
 
-	compat = cfg80211_chandef_compatible(&a->oper, &b->oper);
+	/*
+	 * Remove NPCA if it's not required, so that interfaces
+	 * sharing a channel context will not use NPCA while the
+	 * channel context is shared.
+	 * If both sides are AP interfaces requiring NPC, there's
+	 * an assumption that userspace will set them up with
+	 * identical configurations and the same BSS color
+	 * (if the config is not identical, sharing will fail due
+	 * to cfg80211_chandef_compatible() failing below.)
+	 */
+	if (!_a.require_npca) {
+		_a.oper.npca_chan = NULL;
+		_a.oper.npca_punctured = 0;
+	}
+
+	if (!_b.require_npca) {
+		_b.oper.npca_chan = NULL;
+		_b.oper.npca_punctured = 0;
+	}
+
+	compat = cfg80211_chandef_compatible(&_a.oper, &_b.oper);
 	if (!compat)
 		return NULL;
 
 	/* Note: later code assumes this always fills & returns tmp if compat */
 	tmp->oper = *compat;
 	tmp->ap = a->ap.chan ? a->ap : b->ap;
+	tmp->require_npca = a->require_npca && b->require_npca;
 	return tmp;
 }
 
@@ -671,7 +693,6 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 				      const struct ieee80211_chan_req *chanreq,
 				      struct ieee80211_link_data *rsvd_for)
 {
-	const struct cfg80211_chan_def *chandef = &chanreq->oper;
 	struct ieee80211_chan_req ctx_req = {
 		.oper = ctx->conf.def,
 		.ap = ctx->conf.ap,
@@ -679,7 +700,7 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 	u32 changed = 0;
 
 	/* 5/10 MHz not handled here */
-	switch (chandef->width) {
+	switch (chanreq->oper.width) {
 	case NL80211_CHAN_WIDTH_1:
 	case NL80211_CHAN_WIDTH_2:
 	case NL80211_CHAN_WIDTH_4:
@@ -724,10 +745,15 @@ static void _ieee80211_change_chanctx(struct ieee80211_local *local,
 			changed |= IEEE80211_CHANCTX_CHANGE_WIDTH;
 		if (ctx->conf.def.punctured != chanreq->oper.punctured)
 			changed |= IEEE80211_CHANCTX_CHANGE_PUNCTURING;
+		if (ctx->conf.def.npca_chan != chanreq->oper.npca_chan)
+			changed |= IEEE80211_CHANCTX_CHANGE_NPCA;
+		if (chanreq->oper.npca_chan &&
+		    ctx->conf.def.npca_punctured != chanreq->oper.npca_punctured)
+			changed |= IEEE80211_CHANCTX_CHANGE_NPCA_PUNCT;
 	}
 	if (!cfg80211_chandef_identical(&ctx->conf.ap, &chanreq->ap))
 		changed |= IEEE80211_CHANCTX_CHANGE_AP;
-	ctx->conf.def = *chandef;
+	ctx->conf.def = chanreq->oper;
 	ctx->conf.ap = chanreq->ap;
 
 	/* check if min chanctx also changed */
-- 
2.53.0


