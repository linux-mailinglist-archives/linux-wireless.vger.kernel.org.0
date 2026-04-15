Return-Path: <linux-wireless+bounces-34778-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFCIJ7mI32kHVAAAu9opvQ
	(envelope-from <linux-wireless+bounces-34778-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E24046A3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B15B630D353D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1360532E743;
	Wed, 15 Apr 2026 12:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="kpufYlEP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143D532548B
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257125; cv=none; b=jIEGdg0qlS8BBkehILezaxGvAz+0H/W0JAi5qYPqntiedMKtthqEaYTHp78pl8awbK0lRWXKUn5IEGNnPgPJrZWwYnoFuz4DsMPrbjV3XPo2RTYdaLaq9fFyQxFkWKynLhivK8tZiCyliwOYO11GznD3/gLqn4ZZcNyod9BdGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257125; c=relaxed/simple;
	bh=mdD55rRi7gBZ3B5aVWOQQB+QIgue1wZnnD/jhfvAfZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTA3dlIx9ZvlfzzRuA8Lue+2QrfNquw732/DiRyuO8a0XW87HZ+w+6H6LIdSKmsWCi/yDHMqBaT5TSqD6YcqZu1HkZnQ4LcdXBKnniU5noh1hza0Zhw9dz/qvkeS0SAz2uKSe9QxVCcXq/31uxr15hOdDT1JRXtG9xl3y8Z6n7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=kpufYlEP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=VBikkz+XioIarGvdkIYQam1f+TueaJrpLVuLcZbbgWI=;
	t=1776257123; x=1777466723; b=kpufYlEPzyhNLcuWQsTR2C1WAnnxhvVw/QTYv1A+gYNekB8
	aPykq6imoARPf4nYgsVYzTfUyFYAtYeeiRuc/Vg+8F0kuP1+9UVYsnz8SQNJfrExAMCFPtbxZ2knx
	Aqi6XyaiEVanfY2GIWu2ZcASpt/kITcKxCJYTLwyk+YnAwX7sW0eRC3HYDorjBuhT2DjfQkLXRS+m
	FSOEXMo+6Zl+DX5MnMeKvNsyWmKD3E++Z579hDIplU0ESxnF5vQTanKicrduxQIZer3WJYQyuOt+h
	ii0bFP1DSCrEJ4w0kRgYtnrhEqyXMlc6uNA+I6QFVJ7SdlQ2nLyULCN5F4JyiK4w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcP-00000006OgW-06jt;
	Wed, 15 Apr 2026 14:45:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 06/20] wifi: mac80211: remove ieee80211_sta_cap_chan_bw()
Date: Wed, 15 Apr 2026 14:42:04 +0200
Message-ID: <20260415144514.138728393e2b.I4ea9221cafcfd034dda430e76de82eec59ab1e71@changeid>
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
	TAGGED_FROM(0.00)[bounces-34778-lists,linux-wireless=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:dkim,intel.com:email]
X-Rspamd-Queue-Id: 255E24046A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

This function is only used by TDLS, but is more or less equivalent
to ieee80211_sta_cap_rx_bw() (which takes OMI into account, but that
won't be used in TDLS), except it tries to differentiate 80+80 and
160, but then caller doesn't care about that. Remove the function.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 --
 net/mac80211/tdls.c        | 19 +++++++++++--------
 net/mac80211/vht.c         | 24 ------------------------
 3 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2a693406294b..029600b3b7c0 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2316,8 +2316,6 @@ ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
 	return _ieee80211_sta_cur_vht_bw(link_sta, NULL);
 }
 void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
-enum nl80211_chan_width
-ieee80211_sta_cap_chan_bw(struct link_sta_info *link_sta);
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
 				 struct ieee80211_link_data *link,
 				 struct ieee80211_mgmt *mgmt);
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 90a122dc274f..874752738c68 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -311,17 +311,20 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 	/* IEEE802.11ac-2013 Table E-4 */
 	static const u16 centers_80mhz[] = { 5210, 5290, 5530, 5610, 5690, 5775 };
 	struct cfg80211_chan_def uc = sta->tdls_chandef;
-	enum nl80211_chan_width max_width =
-		ieee80211_sta_cap_chan_bw(&sta->deflink);
+	enum nl80211_chan_width max_width;
 	int i;
 
-	/* only support upgrading non-narrow channels up to 80Mhz */
-	if (max_width == NL80211_CHAN_WIDTH_5 ||
-	    max_width == NL80211_CHAN_WIDTH_10)
-		return;
-
-	if (max_width > NL80211_CHAN_WIDTH_80)
+	switch (ieee80211_sta_cap_rx_bw(&sta->deflink)) {
+	case IEEE80211_STA_RX_BW_20:
+		max_width = NL80211_CHAN_WIDTH_20;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		max_width = NL80211_CHAN_WIDTH_40;
+		break;
+	default: /* 80 or higher, only support upgrade to 80 */
 		max_width = NL80211_CHAN_WIDTH_80;
+		break;
+	}
 
 	if (uc.width >= max_width)
 		return;
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 6da8a5021136..c25190bc7c5c 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -433,30 +433,6 @@ _ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
 		   link_sta->rx_omi_bw_rx);
 }
 
-enum nl80211_chan_width
-ieee80211_sta_cap_chan_bw(struct link_sta_info *link_sta)
-{
-	struct ieee80211_sta_vht_cap *vht_cap = &link_sta->pub->vht_cap;
-	u32 cap_width;
-
-	if (!vht_cap->vht_supported) {
-		if (!link_sta->pub->ht_cap.ht_supported)
-			return NL80211_CHAN_WIDTH_20_NOHT;
-
-		return link_sta->pub->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
-				NL80211_CHAN_WIDTH_40 : NL80211_CHAN_WIDTH_20;
-	}
-
-	cap_width = vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK;
-
-	if (cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ)
-		return NL80211_CHAN_WIDTH_160;
-	else if (cap_width == IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ)
-		return NL80211_CHAN_WIDTH_80P80;
-
-	return NL80211_CHAN_WIDTH_80;
-}
-
 enum nl80211_chan_width
 ieee80211_sta_rx_bw_to_chan_width(struct link_sta_info *link_sta)
 {
-- 
2.53.0


