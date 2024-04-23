Return-Path: <linux-wireless+bounces-6741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23B38AF7B7
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 22:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B6B1F2290A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CF91422A3;
	Tue, 23 Apr 2024 20:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="DWfbtGeP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3B71422CB
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902429; cv=none; b=EPlHUd4LuDyR1xQ0+OmoTkDQawFCFaPrlozF5o8iKI/2mf2uhAuxoyGXa7Sa2xWBLEnUGkjE1R8eH09SBjh3gE9eYtZtcDheryw2re2k8m+E8jsOgKHvpakRZHyTmemPstTPsyWVPti90GbwUXMnQtwz3lQxg86NknjtZJe/oSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902429; c=relaxed/simple;
	bh=MPJdTmkfo23DJjapoi7WOjVkI/xXI+x+dnoledk9C0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrFIvSboNsBV/dQdrXPI8NW/IFssU7fs0k8ePvw7fxXPrIGa7bRpNs7piEtfb6qtXpiJfNNjZoPv7zsiOPUz4OHWhwLvha/ws0dRuvstSdxzjJQpOZQudqNUpPkxvve6DLOSLZz/iQlk9THZKPNOKeF6SW8dKvaqvEkPfk09eCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=DWfbtGeP; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h7HmUGK21G81lCULsh021xVx9MsMuv3S3fj6BkaRq+0=;
	t=1713902428; x=1715112028; b=DWfbtGePK2SCwad9FkTV/RE89pLCx1r2Ix8iWM7TviTC/QA
	3FCQxr1AfHOBILO5wg8S/HRrJ2W96hoDyNiHok7j3+J0sHzG9D3VLfXQ6xiKIapmZUQgjZ58BeOcy
	9qGz5lDlB6KxIWQpaks9IlNSnG+s/1dMgddbmf+vR7+4VxGM0XrLOYKvRhYKQB2UVkRB0XFlGCJC6
	pp0Z12uTBrtOdFb7/s0QpH9emoLPGFmkDcRp7aX10j3ys/5Re0pXM732xRp9gY+G4KajE8LZtIidX
	rBG6BvCphq2QHjeLmfC01dca5Y9kfxOLMtzVjfl5Du5crBI0971d1dZrVjNgESGw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rzMJV-00000002OTL-3CSM;
	Tue, 23 Apr 2024 22:00:25 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [RFC PATCH 4/4] wifi: mac80211: track changes in AP's TPE
Date: Tue, 23 Apr 2024 21:56:15 +0200
Message-ID: <20240423220019.301201d125b2.I990877e409ab8eade9ed7c172272e0cae57256cf@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423200019.192941-6-johannes@sipsolutions.net>
References: <20240423200019.192941-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the TPE (transmit power envelope) is changed, detect and
report that to the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/mlme.c    | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index b8ce4531631e..7d4f5f86c622 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -362,6 +362,7 @@ struct ieee80211_vif_chanctx_switch {
  *	status changed.
  * @BSS_CHANGED_MLD_VALID_LINKS: MLD valid links status changed.
  * @BSS_CHANGED_MLD_TTLM: negotiated TID to link mapping was changed
+ * @BSS_CHANGED_TPE: transmit power envelope changed
  */
 enum ieee80211_bss_change {
 	BSS_CHANGED_ASSOC		= 1<<0,
@@ -398,6 +399,7 @@ enum ieee80211_bss_change {
 	BSS_CHANGED_UNSOL_BCAST_PROBE_RESP = 1<<31,
 	BSS_CHANGED_MLD_VALID_LINKS	= BIT_ULL(33),
 	BSS_CHANGED_MLD_TTLM		= BIT_ULL(34),
+	BSS_CHANGED_TPE			= BIT_ULL(35),
 
 	/* when adding here, make sure to change ieee80211_reconfig */
 };
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 409484d59c79..46abb7db8639 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -966,6 +966,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chan_req chanreq = {};
+	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
 	u32 vht_cap_info = 0;
 	u16 ht_opmode;
@@ -981,7 +982,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, vht_cap_info,
 					      elems, true, &link->u.mgd.conn,
-					      &chanreq.ap);
+					      &ap_chandef);
 
 	if (ap_mode != link->u.mgd.conn.mode) {
 		link_info(link,
@@ -991,7 +992,8 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return -EINVAL;
 	}
 
-	chanreq.oper = chanreq.ap;
+	chanreq.ap = ap_chandef;
+	chanreq.oper = ap_chandef;
 	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
 		chanreq.ap.chan = NULL;
@@ -1019,6 +1021,16 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			ieee80211_min_bw_limit_from_chandef(&chanreq.oper))
 		ieee80211_chandef_downgrade(&chanreq.oper, NULL);
 
+	if (ap_chandef.chan->band == NL80211_BAND_6GHZ &&
+	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE) {
+		ieee80211_rearrange_tpe(&elems->tpe, &ap_chandef,
+					&chanreq.oper);
+		if (memcmp(&link->conf->tpe, &elems->tpe, sizeof(elems->tpe))) {
+			link->conf->tpe = elems->tpe;
+			*changed |= BSS_CHANGED_TPE;
+		}
+	}
+
 	if (ieee80211_chanreq_identical(&chanreq, &link->conf->chanreq))
 		return 0;
 
-- 
2.44.0


