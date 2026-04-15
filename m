Return-Path: <linux-wireless+bounces-34776-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KHpEa6I32nSUgAAu9opvQ
	(envelope-from <linux-wireless+bounces-34776-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E75404687
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 14:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67F130C64DB
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50E632E75A;
	Wed, 15 Apr 2026 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ZTm5Da2M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98D31A062
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776257123; cv=none; b=Fvb+qp89B+tsRFkK/tpJPfSQuYpDnwwbPYNB6qyJZUflPZRICgAhVMFvfdCO1v+d5RPidmN2DrxKG90qrt0hx8C59SSR8NJ5wwJKVjeQr8GM57/mq97JEC0cPoOiAsPX2/idvwAAHK0vc20TlVA1H0pRMLY2/5XVg+vkBQFijAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776257123; c=relaxed/simple;
	bh=IBemyFmqhTEQzB0ExE15wwoOrbIlm9tnx5t7NGXf1Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4l93zFHAoFvE6Jcx1lRANatZvicPt7R8GE53Ff+jTYCTmcEH5soBOk2tklNSwd/qVRW0JrifVh6WN74uie+xlJmKQ6qZjiF/uM0f9Xnmk4dnvak7lhHI4AlMH8zAt/0McZEceQU4nQ+HjRcRlxLyaq4l10e5Oik7xC1jR30DhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=ZTm5Da2M; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=svB9Unc/RMd1Gmd6WDQkvWMV7TCi8UeqLvuQvzn5998=;
	t=1776257122; x=1777466722; b=ZTm5Da2MJO53ld0j6Kt51YbUvunSLvdl4dWVkC7Oqmov9mQ
	yybi+minp9BCChg5i9OFtYv4XRD+s9WYiffBU5nxs2kzSOJlDMaUt7+p0MtKTR5P7shlR+M82mco7
	u20S2rmokoiYlbvg/9JkRKhwJNvsDKRhzUgJ2NXXz5+UD7+v9EP6v33ndvzXVewJ9G+AzWOgCoVRi
	/8UkptkEzwNT40G1ulIt8IscC652QGQwlVdkP6i6/NxKe5MOYbKvq3jGSYk/GVPYmmEDXfY1AuzPt
	P/Gj4KjmKmKRchEXWiPUYhYeCq0W6x3k+nQcdS/H+QZatKHYsDthvs0Njte5YNag==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1wCzcN-00000006OgW-3ykR;
	Wed, 15 Apr 2026 14:45:20 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 04/20] wifi: mac80211: use chandef in ieee80211_get_sta_bw()
Date: Wed, 15 Apr 2026 14:42:02 +0200
Message-ID: <20260415144514.d2bdf106a39f.I6ae07289a272dd9e27118f9fa324a4865f994003@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34776-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johannes@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:dkim,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1E75404687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

When getting the bandwidth the station uses in order to
calculate the channel context's min_def, pass the channel
for the link to _ieee80211_sta_cap_rx_bw() instead of using
ieee80211_sta_cap_rx_bw(), which looks it up.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/chan.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index fda692316f08..5e93405d70a3 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -438,11 +438,12 @@ ieee80211_find_reservation_chanctx(struct ieee80211_local *local,
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
 
@@ -457,7 +458,7 @@ static enum nl80211_chan_width ieee80211_get_sta_bw(struct sta_info *sta,
 	 * capabilities here. Calling it RX bandwidth capability is a bit
 	 * wrong though, since capabilities are in fact symmetric.
 	 */
-	width = ieee80211_sta_cap_rx_bw(link_sta);
+	width = _ieee80211_sta_cap_rx_bw(link_sta, &link->conf->chanreq.oper);
 
 	switch (width) {
 	case IEEE80211_STA_RX_BW_20:
@@ -492,7 +493,6 @@ static enum nl80211_chan_width
 ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
-	unsigned int link_id = link->link_id;
 	enum nl80211_chan_width max_bw = NL80211_CHAN_WIDTH_20_NOHT;
 	struct sta_info *sta;
 
@@ -503,7 +503,7 @@ ieee80211_get_max_required_bw(struct ieee80211_link_data *link)
 		    !(sta->sdata->bss && sta->sdata->bss == sdata->bss))
 			continue;
 
-		max_bw = max(max_bw, ieee80211_get_sta_bw(sta, link_id));
+		max_bw = max(max_bw, ieee80211_get_sta_bw(sta, link));
 	}
 
 	return max_bw;
-- 
2.53.0


