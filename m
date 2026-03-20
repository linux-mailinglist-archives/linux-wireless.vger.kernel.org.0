Return-Path: <linux-wireless+bounces-33582-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNMSOVIDvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33582-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:20:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE382D71F1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F177C3001FCD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED2B37187F;
	Fri, 20 Mar 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJAxdgel"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C213C370D76
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994830; cv=none; b=JcKNDPSLYSG8J72EUq1YMR9K3ZYbrId9H4AafkZw2XrYJFxqNv2ziZtY607zAGh1/CAdZkwzFulx1qVUS91HQ/MVMrB43zdZcn41L9W/wsfjwU4n0QixLdXyoSVkhfs2qDHanhNrtzc3k6CQl7K3CqjfK29BTm5fzou1V91Bl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994830; c=relaxed/simple;
	bh=l1sA+dB/k+K6DLVGt5G5/EtU/jIAtoh4jZoC9a480QU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SFDFDxb2N/vw8FhBrXuVSnPPROIoOT8vq1UShwW/dZ7PkiJavCFuO+pLB0NMdxOgI1s4sQhEYFzYDJ9v5KHSpGhqhHFl/bCTnwJpXrbKcv8KmomuZQNlHFy52or6UQ92o5r+4I3cxswgrnlq/ZjUrZHvBmzpLKpV8S306dSZUEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJAxdgel; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994830; x=1805530830;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l1sA+dB/k+K6DLVGt5G5/EtU/jIAtoh4jZoC9a480QU=;
  b=QJAxdgelXNvm+8d4pAg/xtLiQNjhId15TLVO5VI12xETzX8xKzxeTYiD
   A0+ItbTMkEeKD9zS3u/lMKpRLdFKc7CsdFj97KWEPL1hTae7iMy6j+Cn4
   ajok0Lo1m6Q/5PRF87JoEcvp2dH4zPOLDSiFwHxoQ8q+A6zyBDaY/4pgB
   rB1wVGOSJisfzLMfs7Tme1GQCAr5EnyhAJ+OH6/JjHaA8BL1oWrrV2Szk
   yvwEH66pKZ/41g6btmrWV526/je3eo0ZPwF47/vmXzY2Wgwa8MdRiXILB
   piKqVrTxvfMYcP2Y4IyboAA/QGpbNent2Bp+1xvOGy68jWI7Rqxva3X+0
   Q==;
X-CSE-ConnectionGUID: OjJ9X62LT+egfhH3QOFf8A==
X-CSE-MsgGUID: yg6O8BHWRH2AlOJFx89c0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74958842"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74958842"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:20:30 -0700
X-CSE-ConnectionGUID: hSZG/up7Q+KyVwQZSsaL/Q==
X-CSE-MsgGUID: PTr+Cs/3TsmX81I2Az8ZOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="217134893"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:20:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: extract channel logic from link logic
Date: Fri, 20 Mar 2026 10:20:17 +0200
Message-Id: <20260320102013.6a695fb57f40.Id24934d14f240f8d38a23f3b1786235bac0b3e60@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33582-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CE382D71F1
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


