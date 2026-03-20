Return-Path: <linux-wireless+bounces-33581-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wK8WAUEDvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33581-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:20:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE3A2D71E1
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D99163001FE4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F8D2EBB99;
	Fri, 20 Mar 2026 08:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NVK2vsZE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122D34572B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994813; cv=none; b=sAdCZhLflM0tHU7gGfeDVNZmcM7/xTGgIIZACWPC772eMmb9ohqQNQO7K/R1IIEgyQVAbeM6QIcDPITHSlH7Q65Ej8GfTaRPI+7OyuPRILOpaLNLItzsocq81qil2F5eO0jieWypBN+84Ka7OV+dz4lXdGKkU/ywsSUzs0ucUQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994813; c=relaxed/simple;
	bh=F7Rxl7sZThaTxDwyc5WVP9mu8MsXput8KvdxcqLY0fM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YzLiolokdg+4FLU7/cNyq2W9kzEIfrL/Z9ewqZ1GgiuiK4f9gqH8ITTgXfn9r/3ups/SbHyOVkMLkZJhIohhT12Smd7zTkFA6kHEVzpWWgB8YPsvcfnrEm6QqN4AZhN+QDsbU7ndGFbtctidKW9zz/gLAld7iUPCszdHqrmRTwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NVK2vsZE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994812; x=1805530812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F7Rxl7sZThaTxDwyc5WVP9mu8MsXput8KvdxcqLY0fM=;
  b=NVK2vsZEucHefJy7u17WD5goViZeUUaFsNpAj3Qiik3ud7+Az1kTDW2l
   0gQf/oAlKvF7k0o0I+G0tp1MIPB2cyOzEST8iviEpwnuS00GTVrmCb9BT
   tK9CO7M5hAK1f3QzGECtMtnCnkVdNJ8YikD3u0U29DFVHbc/ZB+le3nOW
   hwcwTY4U5YSpcBTAfcXjCSYtb+oJK07Sr4fgSEcEgSY0qqLJV2AmhVH71
   DFfB/Mm3aQW5sAdleV+AOummSdZ6GzRN5KGimeDjcicbCUfTJTfOI0gx1
   eM3sxt4YhreDeXcri9GYq4V19UNUChrLCHkvlI1h6NXuP/9t+b4q0dvO9
   w==;
X-CSE-ConnectionGUID: YuTYYsGRQ1KCaXio0O7DkA==
X-CSE-MsgGUID: zoOdKKz6RzK0XccP0PHpug==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="74967443"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="74967443"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:20:12 -0700
X-CSE-ConnectionGUID: ENeCj9RXS26Qqly2lWaF3Q==
X-CSE-MsgGUID: IYzR3KSJQb2TYjSqZTcEZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223206016"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:20:11 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: mac80211: make ieee80211_find_chanctx link-unaware
Date: Fri, 20 Mar 2026 10:19:59 +0200
Message-Id: <20260320101954.232499e2a41f.I0b735a607e1ec7aa5749ab01c794ef99dbe82b7f@changeid>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33581-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 9AE3A2D71E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently we have only one user for a channel context: the link.
With NAN, a new type of the channel context user will be added - the NAN
channel.
To prepare for this, we need to separate the channel context code from
the link code.

Removes the link argument from ieee80211_find_chanctx. Since the issue that led
to commit 5e0c422d12b5 ("wifi: mac80211: reserve chanctx during find") - that
added the link argument - is relevant for any user of the channel context, add
a boolean to the chanctx itself, indicating that the chanctx is in the process
of getting used.

When this indication is set, the reference count of the channel context
will be incremented by one, so even if it is getting released from a link
(or another user) it won't be freed.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/chan.c        | 26 ++++++++++++++------------
 net/mac80211/ieee80211_i.h |  3 +++
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index b7604118bf57..1bcf501cfe8e 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -166,6 +166,13 @@ int ieee80211_chanctx_refcount(struct ieee80211_local *local,
 	for_each_chanctx_user_all(local, ctx, &iter)
 		num++;
 
+	/*
+	 * This ctx is in the process of getting used,
+	 * take it into consideration
+	 */
+	if (ctx->will_be_used)
+		num++;
+
 	return num;
 }
 
@@ -769,10 +776,9 @@ static void ieee80211_change_chanctx(struct ieee80211_local *local,
 	_ieee80211_change_chanctx(local, ctx, old_ctx, chanreq, NULL);
 }
 
-/* Note: if successful, the returned chanctx is reserved for the link */
+/* Note: if successful, the returned chanctx will_be_used flag is set */
 static struct ieee80211_chanctx *
 ieee80211_find_chanctx(struct ieee80211_local *local,
-		       struct ieee80211_link_data *link,
 		       const struct ieee80211_chan_req *chanreq,
 		       enum ieee80211_chanctx_mode mode)
 {
@@ -784,9 +790,6 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 	if (mode == IEEE80211_CHANCTX_EXCLUSIVE)
 		return NULL;
 
-	if (WARN_ON(link->reserved_chanctx))
-		return NULL;
-
 	list_for_each_entry(ctx, &local->chanctx_list, list) {
 		const struct ieee80211_chan_req *compat;
 
@@ -807,12 +810,12 @@ ieee80211_find_chanctx(struct ieee80211_local *local,
 			continue;
 
 		/*
-		 * Reserve the chanctx temporarily, as the driver might change
+		 * Mark the chanctx as will be used, as the driver might change
 		 * active links during callbacks we make into it below and/or
 		 * later during assignment, which could (otherwise) cause the
 		 * context to actually be removed.
 		 */
-		link->reserved_chanctx = ctx;
+		ctx->will_be_used = true;
 
 		ieee80211_change_chanctx(local, ctx, ctx, compat);
 
@@ -2066,8 +2069,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	if (!local->in_reconfig)
 		__ieee80211_link_release_channel(link, false);
 
-	ctx = ieee80211_find_chanctx(local, link, chanreq, mode);
-	/* Note: context is now reserved */
+	ctx = ieee80211_find_chanctx(local, chanreq, mode);
+	/* Note: context will_be_used flag is now set */
 	if (ctx)
 		reserved = true;
 	else if (!ieee80211_find_available_radio(local, chanreq,
@@ -2087,9 +2090,8 @@ int _ieee80211_link_use_channel(struct ieee80211_link_data *link,
 	ret = ieee80211_assign_link_chanctx(link, ctx, assign_on_failure);
 
 	if (reserved) {
-		/* remove reservation */
-		WARN_ON(link->reserved_chanctx != ctx);
-		link->reserved_chanctx = NULL;
+		WARN_ON(!ctx->will_be_used);
+		ctx->will_be_used = false;
 	}
 
 	if (ret) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d71e0c6d2165..fe53812eca95 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -928,6 +928,9 @@ struct ieee80211_chanctx {
 
 	bool radar_detected;
 
+	/* This chanctx is in process of getting used */
+	bool will_be_used;
+
 	/* MUST be last - ends in a flexible-array member. */
 	struct ieee80211_chanctx_conf conf;
 };
-- 
2.34.1


