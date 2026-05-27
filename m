Return-Path: <linux-wireless+bounces-37024-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGf7Dq5LF2r0/wcAu9opvQ
	(envelope-from <linux-wireless+bounces-37024-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:53:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA385E9BF1
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 21:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 594F43071EEC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 May 2026 19:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905873B3C14;
	Wed, 27 May 2026 19:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZnB9rCUC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49213B3BE5
	for <linux-wireless@vger.kernel.org>; Wed, 27 May 2026 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911526; cv=none; b=ZPTCIH/XID+4sBRBjRpXcu9ZjrqOIe//lVmzajo+IlG4zdzE5/NRgvM+JqrVSsSb+WqaqPbnE9ZZUdOmA/4F0hZwu4Qj4ozwPXeMGzYw4yJYrX3q2hCV9VRvn6/c1P9u5LO6sM2qO0xQ6/2HVKfFs+eWKYMnVLLTCvKO+GScyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911526; c=relaxed/simple;
	bh=OFbyax4YQCSaQVADczW+kyw2R6NE12w0My7I+kXXk+g=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptnFQTuDWatbh003jdNNLW8xMrc04lkGOFXQQX4eprbbTRtziyWdulEr7dzGHG7ZnMvbLZT6mB1n8hzQVH9dioYsvcE7OcO8DkD2wKLWWzotBsaOVwvPq8ic3a1wjinVTXlyixd/kLYcE+X+g02hWZUz75tTEW9ycQ7e3T+EMB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZnB9rCUC; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779911525; x=1811447525;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=OFbyax4YQCSaQVADczW+kyw2R6NE12w0My7I+kXXk+g=;
  b=ZnB9rCUCEDCtdwvyEQbb/177IXY2Yy17rCqbNbktXM63C4QQjG9Eks0l
   NNJ+eBJTroIDcZ4lVAUFbabWy5xzmvvjQWKSdx73QWzOcio7Pg4vwV121
   LS4dYWo1VRz33mGXdigeLXNsRASGCRXI+k5pv3y0n4CEpz0h+uOSeOM4H
   CfMES43xhngrNW4xE21JYKE9kCCUXyr0NhvXzeagWIYZ3gYhB745w47iG
   +5SqKagMmNnFedQNEP/q7i/EZqvjXximuS7yQ++NHC/aLJ5O5V5PhIttV
   c9BAVyUEiRa5w7/H7fjKMMd7CYJz9jhV63273iIVjJpGcj96rJWc0XUwW
   g==;
X-CSE-ConnectionGUID: cWodd8a9RI6u4wLx45SJaA==
X-CSE-MsgGUID: OVB4Xc5TRtilPsAVyWMGmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80784728"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="80784728"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:52:03 -0700
X-CSE-ConnectionGUID: hujAfgzzSom7/+rEyY518Q==
X-CSE-MsgGUID: JKw9TxKkRo+Is/wGAeiJcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="280465113"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 12:52:02 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 3/3] wifi: mac80211: fix channel evacuation logic
Date: Wed, 27 May 2026 22:51:45 +0300
Message-Id: <20260527224745.5f7b10505145.I1712bc64f9eec9c99f05994208ad124624a29f1c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260527195145.468037-1-miriam.rachel.korenblit@intel.com>
References: <20260527195145.468037-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37024-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PRECEDENCE_BULK(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4FA385E9BF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When we try to assign a chanctx to a link, if
ieee80211_find_or_create_chanctx() failed, we try to evacuate a NAN
channel and call it again.

This logic is broken:
In case there are not enough chanctxs we will fail earlier,
when we check ieee80211_check_combinations().

To fix this, do the following in case ieee80211_check_combinations()
failed:
- check if there is a NAN channel that can be evacuated
- make ieee80211_check_combinations() not consider the chanctx of that NAN
  channel, so we pretend that it was already evacuated
- If now ieee80211_check_combinations() is successful, we know that it
  helped, and we can remove that NAN channel for real.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c        | 78 ++++++++++++++++++++++++++++++++------
 net/mac80211/ieee80211_i.h |  6 +++
 net/mac80211/nan.c         |  4 +-
 3 files changed, 75 insertions(+), 13 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index c64a99131954..23d46cd57137 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2216,6 +2216,64 @@ ieee80211_find_or_create_chanctx(struct ieee80211_sub_if_data *sdata,
 				     assign_on_failure, radio_idx);
 }
 
+static bool
+ieee80211_nan_evac_chanctx_filter(struct ieee80211_chanctx *ctx,
+				  void *filter_data)
+{
+	return ctx == filter_data;
+}
+
+static int
+ieee80211_try_nan_chan_evacuation(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *sdata,
+				  const struct cfg80211_chan_def *chandef,
+				  enum ieee80211_chanctx_mode mode,
+				  u8 radar_detect_width)
+{
+	struct ieee80211_sub_if_data *nan_sdata = ieee80211_find_nan_sdata(local);
+	struct ieee80211_check_combinations_data comb_data = {
+		.chandef = chandef,
+		.chanmode = mode,
+		.radar_detect = radar_detect_width,
+		.radio_idx = -1,
+		.chanctx_filter = ieee80211_nan_evac_chanctx_filter,
+	};
+	struct ieee80211_nan_channel *evac_chan;
+	struct ieee80211_chanctx *evac_ctx;
+	int ret;
+
+	if (!nan_sdata)
+		return -ENOENT;
+
+	/* Find an evacuation candidate... */
+	evac_chan = ieee80211_nan_find_evac_chan(local, nan_sdata, NULL);
+	if (!evac_chan || WARN_ON(!evac_chan->chanctx_conf))
+		return -ENOENT;
+
+	evac_ctx = container_of(evac_chan->chanctx_conf,
+				struct ieee80211_chanctx, conf);
+
+	/*
+	 * ... check combinations assuming to-be-evacuated ctx is already
+	 * released
+	 */
+	comb_data.filter_data = evac_ctx;
+	ret = ieee80211_check_combinations_ext(sdata, &comb_data);
+	if (ret < 0)
+		return ret;
+
+	/* That helped! Let's evacuate the channel */
+	ieee80211_nan_evacuate_channel(nan_sdata, evac_chan);
+
+	/* Re-check, just to be on the safe-side */
+	ret = ieee80211_check_combinations(sdata, chandef, mode,
+					   radar_detect_width, -1);
+
+	/* That shouldn't happen, we checked before! */
+	WARN_ON(ret);
+	return ret;
+}
+
 int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 				const struct ieee80211_chan_req *chanreq,
 				enum ieee80211_chanctx_mode mode,
@@ -2247,23 +2305,21 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	ret = ieee80211_check_combinations(sdata, &chanreq->oper, mode,
 					   radar_detect_width, -1);
-	if (ret < 0)
-		goto out;
+	if (ret < 0) {
+		/* Let's check if evacuating a NAN channel will help */
+		ret = ieee80211_try_nan_chan_evacuation(local, sdata,
+							&chanreq->oper,
+							mode,
+							radar_detect_width);
+		if (ret < 0)
+			goto out;
+	}
 
 	if (!local->in_reconfig)
 		__ieee80211_link_release_channel(link, false);
 
 	ctx = ieee80211_find_or_create_chanctx(sdata, chanreq, mode,
 					       assign_on_failure, &reused_ctx);
-	if (IS_ERR(ctx)) {
-		/* Try to evacuate a NAN channel to free up a chanctx */
-		if (ieee80211_nan_try_evacuate(&local->hw, NULL))
-			ctx = ieee80211_find_or_create_chanctx(sdata, chanreq,
-							       mode,
-							       assign_on_failure,
-							       &reused_ctx);
-	}
-
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 29ae3004655c..99136a850fdf 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2059,6 +2059,12 @@ int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 				 struct cfg80211_nan_peer_sched *sched);
 void ieee80211_nan_free_peer_sched(struct ieee80211_nan_peer_sched *sched);
 void ieee80211_nan_update_ndi_carrier(struct ieee80211_sub_if_data *ndi_sdata);
+struct ieee80211_nan_channel *
+ieee80211_nan_find_evac_chan(struct ieee80211_local *local,
+			     struct ieee80211_sub_if_data *sdata,
+			     struct ieee80211_chanctx *ctx);
+void ieee80211_nan_evacuate_channel(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_nan_channel *nan_channel);
 
 static inline struct ieee80211_sub_if_data *
 ieee80211_find_nan_sdata(struct ieee80211_local *local)
diff --git a/net/mac80211/nan.c b/net/mac80211/nan.c
index 44b6e298d94d..1800bb96dd29 100644
--- a/net/mac80211/nan.c
+++ b/net/mac80211/nan.c
@@ -712,7 +712,7 @@ int ieee80211_nan_set_peer_sched(struct ieee80211_sub_if_data *sdata,
 	return ret;
 }
 
-static void
+void
 ieee80211_nan_evacuate_channel(struct ieee80211_sub_if_data *sdata,
 			       struct ieee80211_nan_channel *nan_channel)
 {
@@ -754,7 +754,7 @@ ieee80211_nan_evacuate_channel(struct ieee80211_sub_if_data *sdata,
 		ieee80211_free_chanctx(sdata->local, ctx, false);
 }
 
-static struct ieee80211_nan_channel *
+struct ieee80211_nan_channel *
 ieee80211_nan_find_evac_chan(struct ieee80211_local *local,
 			     struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_chanctx *ctx)
-- 
2.34.1


