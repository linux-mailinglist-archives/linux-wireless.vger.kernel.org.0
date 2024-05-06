Return-Path: <linux-wireless+bounces-7248-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D8E8BD5D0
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 21:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDEEB1F21F66
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 19:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556D15CD52;
	Mon,  6 May 2024 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="upxwP1zf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33A115B98E
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715024747; cv=none; b=QVuIuAxpUW+J0YwW9I+2pjYPpVO3Ixihj2e6mXlvwn2ECPQhGywiYgH57uSIGky/2xEhQQp957g49MG5QYRuz0CnmC2GlfJteapya514NpkCyFTI/stAy3cwmciocbpFUUznBvQiPhkjqOiDYbsAJ8u5svnPpwRS6+2czYl/NJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715024747; c=relaxed/simple;
	bh=AXiKmYB93BgEqwDZBdpxC1S8FTOO47V+bo++lUeHsB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YVCBD1+oFAsYuv5dRfYx0SIL2yOsV1b7olp4m7YrTDZEj8yc1eC7qE6J0sLfM5qZ5461Udl471GNJs7U1zWPaIYJ77PCbH3oVuZ5xwRAA1DU0oxhzZKfkory0da3/xjQulSuyZJOEuf6vH7k9rpbSwcz12tegV+5rojfoD4ZqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=upxwP1zf; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pYS6BhrBuUbwL7RzXgYG7ZTc6LPPExDTG4hT28XWaKA=;
	t=1715024746; x=1716234346; b=upxwP1zfdXslXmRi/dimnnk91nGN/ACZ42OVJHSLexMNm3A
	31haBhQn+pHlycn91mh16w0RfbfamBYPjmaF78Bs/8kgXfWPzP60De44bpIlRTzldPZ28A3agXcL8
	qpQRNQdt94H8Zo+3P1Zn5amJvS44mKoLCJzdWAecZExNoOj+6ojaYTs32hD4v5/tG6CDJBTd/FgxJ
	4WdSSoQ7laabkjqkq4oAXRO2PMOi0eoSmhWtkpTh4YnaKalzdqfoj+0dOHKHX/yPNvli5Gpk7JumM
	N3mqtnT+tRZa7o9MoXOiiaZxBEhXZmI8p6DE9RfkKOUSNJKg49zYfG5Jeb4kD1mQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s44HP-00000008C27-1Z1w;
	Mon, 06 May 2024 21:45:43 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 5/5] wifi: mac80211: track changes in AP's TPE
Date: Mon,  6 May 2024 21:37:57 +0200
Message-ID: <20240506214536.103dda923f45.I990877e409ab8eade9ed7c172272e0cae57256cf@changeid>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506194536.102148-7-johannes@sipsolutions.net>
References: <20240506194536.102148-7-johannes@sipsolutions.net>
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

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/mlme.c    | 16 ++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index a4efbfb8d796..a59eacfe0480 100644
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
index 88b4bf87f0f6..68bcc514eef8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -973,6 +973,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chan_req chanreq = {};
+	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
 	u32 vht_cap_info = 0;
 	u16 ht_opmode;
@@ -988,7 +989,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, vht_cap_info,
 					      elems, true, &link->u.mgd.conn,
-					      &chanreq.ap);
+					      &ap_chandef);
 
 	if (ap_mode != link->u.mgd.conn.mode) {
 		link_info(link,
@@ -998,7 +999,8 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return -EINVAL;
 	}
 
-	chanreq.oper = chanreq.ap;
+	chanreq.ap = ap_chandef;
+	chanreq.oper = ap_chandef;
 	if (link->u.mgd.conn.mode < IEEE80211_CONN_MODE_EHT ||
 	    sdata->vif.driver_flags & IEEE80211_VIF_IGNORE_OFDMA_WIDER_BW)
 		chanreq.ap.chan = NULL;
@@ -1026,6 +1028,16 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
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


