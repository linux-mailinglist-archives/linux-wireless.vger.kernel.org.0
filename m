Return-Path: <linux-wireless+bounces-33846-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMs5Jy3pw2lvugQAu9opvQ
	(envelope-from <linux-wireless+bounces-33846-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:54:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D5326326
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 14:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4F4CC30B2A6C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 13:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52C53D6CB3;
	Wed, 25 Mar 2026 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ko51uYPH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1441234FF49
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446383; cv=none; b=U9sPDNWCIs6gl0Ny2zTnwsEMlXdIm6dhzBVqZv1zo9TOTxuUHR012IoQoB6ZooAuCozHx8ZcNtvuRf9RHwmBLZzpouA2gn8Z/xZBeVa00/5DPCrbDFZYxioRMh4F+Oj5rplA41Kqo/grztmJTcFXxOOqSLDoko5eAId818BTDtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446383; c=relaxed/simple;
	bh=v4KetagLmNS8XADF8f2umUIzj4ZwR1fA+N7U5pMGVzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TQODQRFbQAm7dX1QOT6q5X0U3RE6Yp2bKDc3TORQHhQc18eZVii4wfQpK45+onoXCA2weIgAiSVIhfL2If5no1bV2tPkYJCU43S2UrURCMgGhD7MbxByQUJ46nXsnJB/otMyx2xPD/Vy3VPb07ZRQQTuLbQAttMUOsYZ0ursUBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ko51uYPH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774446382; x=1805982382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v4KetagLmNS8XADF8f2umUIzj4ZwR1fA+N7U5pMGVzU=;
  b=Ko51uYPH+ORFj8pghP8+s3AXDF03AOVwWzLQUnXg2VkEGTeotpBO3uVv
   OyhFfUepAnydgN5o4X8ZpMSB6nqrmxwrNCghmjykVgbQGHIka3Hk5rnc4
   LkrhfSwx8bakZ9szKDUESCNeTQotOx6zGqDX+vWaDzjfvdSt2MI+AIaql
   yVzzkTSmLg50Jm0X4l8qkSxK2ShD8CAfo2QDJ9Q+2jMohza56WQePve9w
   Tn4IjkRsIEfL9yaOxasb6aLBhuiENCPs0uXX3EU01GcDiKe1MC9j5kQ2M
   r2jjKbcbYN9kSrEgzUc4tHAYIySdB+RESRjmNX1EhLpcSh0FYC3DkV55G
   g==;
X-CSE-ConnectionGUID: qFUTyKhtSDSgt/fCCLeFKw==
X-CSE-MsgGUID: dwrijt9cT8aBkW+tx/ahfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="85792178"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="85792178"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:46:21 -0700
X-CSE-ConnectionGUID: d0v0KCCaTPacFc2XmeMPnA==
X-CSE-MsgGUID: 8eYkpILhQ+mLWc6swKu/qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224698799"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 06:46:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless-next] wifi: mac80211: extract channel logic from link logic
Date: Wed, 25 Mar 2026 15:46:09 +0200
Message-Id: <20260325154550.9a08397a7590.Id24934d14f240f8d38a23f3b1786235bac0b3e60@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33846-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: 5E4D5326326
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The logic that tries to reuse an existing chanctx or create a new one if
such doesn't exist will be used for other types of chanctx users.
Extract this logic from _ieee80211_link_use_channel.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c | 54 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 15 deletions(-)
---
v2: make the patch apply

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 1bcf501cfe8e..1669ebf77346 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -2031,6 +2031,36 @@ void __ieee80211_link_release_channel(struct ieee80211_link_data *link,
 		ieee80211_vif_use_reserved_switch(local);
 }
 
+static struct ieee80211_chanctx *
+ieee80211_find_or_create_chanctx(struct ieee80211_sub_if_data *sdata,
+				 const struct ieee80211_chan_req *chanreq,
+				 enum ieee80211_chanctx_mode mode,
+				 bool assign_on_failure,
+				 bool *reused_ctx)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_chanctx *ctx;
+	int radio_idx;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	ctx = ieee80211_find_chanctx(local, chanreq, mode);
+	if (ctx) {
+		*reused_ctx = true;
+		return ctx;
+	}
+
+	*reused_ctx = false;
+
+	if (!ieee80211_find_available_radio(local, chanreq,
+					    sdata->wdev.radio_mask,
+					    &radio_idx))
+		return ERR_PTR(-EBUSY);
+
+	return ieee80211_new_chanctx(local, chanreq, mode,
+				     assign_on_failure, radio_idx);
+}
+
 int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 				const struct ieee80211_chan_req *chanreq,
 				enum ieee80211_chanctx_mode mode,
@@ -2039,9 +2069,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx *ctx;
-	u8 radar_detect_width = 0;
-	bool reserved = false;
-	int radio_idx;
+	u8 radar_detect_width = 0;	
+	bool reused_ctx = false;
 	int ret;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
@@ -2069,17 +2098,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (!local->in_reconfig)
 		__ieee80211_link_release_channel(link, false);
 
-	ctx = ieee80211_find_chanctx(local, chanreq, mode);
-	/* Note: context will_be_used flag is now set */
-	if (ctx)
-		reserved = true;
-	else if (!ieee80211_find_available_radio(local, chanreq,
-						 sdata->wdev.radio_mask,
-						 &radio_idx))
-		ctx = ERR_PTR(-EBUSY);
-	else
-		ctx = ieee80211_new_chanctx(local, chanreq, mode,
-					    assign_on_failure, radio_idx);
+	ctx = ieee80211_find_or_create_chanctx(sdata, chanreq, mode,
+					       assign_on_failure, &reused_ctx);
 	if (IS_ERR(ctx)) {
 		ret = PTR_ERR(ctx);
 		goto out;
@@ -2089,7 +2109,11 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 
 	ret = ieee80211_assign_link_chanctx(link, ctx, assign_on_failure);
 
-	if (reserved) {
+	/*
+	 * In case an existing channel context is being used, we marked it as
+	 * will_be_used, now that it is assigned - clear this indication
+	 */
+	if (reused_ctx) {
 		WARN_ON(!ctx->will_be_used);
 		ctx->will_be_used = false;
 	}
-- 
2.34.1


