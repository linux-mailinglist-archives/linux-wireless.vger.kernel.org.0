Return-Path: <linux-wireless+bounces-35812-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPjiNPxI+Gn+sAIAu9opvQ
	(envelope-from <linux-wireless+bounces-35812-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:32 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 518D94B9451
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 09:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4AFCB3012C84
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B459C2E2EF9;
	Mon,  4 May 2026 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fqk+Viif"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CD02DCF45
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879283; cv=none; b=McjndZwFI0UyDajcAZG3Uw3XA1+gzLmhRF41lk+so0S1QiFU8q1TyAXmczwGlc4NHCIIfyu8m88yAKPtOLI8ajTiJsL05SC22AqrIK0sSCbra4ZGN9+7yt4nm3Dro6jokm+OrMhJvUW1nKXpO4Cb1ZxeEK28MyMHstjQV8N4MA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879283; c=relaxed/simple;
	bh=RS3EKfpot6D7dTUjQ3XjZqVY1xcnz4AL+HQugEAKGqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IYZ81AJquhmYvf3TP/u0bZG0wQtL+C1iTpFK3NabzepD/782ju/aNtDdYc0SdpyFv4J88/RP0OWJBoyBU5TryDWjvseFJYnZlEgiR3Jsf7CAjUhKYT9TtU/yD73x89cr18DAPUf0SuZM+O9IoiCMLk0DrBBR7YoyYCKULfGVTiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fqk+Viif; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777879282; x=1809415282;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RS3EKfpot6D7dTUjQ3XjZqVY1xcnz4AL+HQugEAKGqA=;
  b=Fqk+ViifyCbydpwUD8H6Z2TWcZ2GAG3PZDk+gigkzPLRAcM8l5RDDZrM
   Z5mWCdKRDW0IOxl4V7+Gy5F3YRbDAP7EAm1toLdrnMBgtE1ut+vvvhBOs
   B5jLS/RSfkT3RlcARvbZHhFgB3j/ei2PtBUOjxsIQAYVcUPvfZ41LjA1s
   a8HhuhPhapq940PittubPpjn9Q9GJGlBVrl7+jM5bwQC9EmaRh38to/yx
   iOJQ/9falHP1d4xoNOANSTGhZUKcHFhqTLd3qdhHSC+mNkdwheY6bxAVs
   oDtglsJv/6X6UwFC01ORnKOjdQmHSQvnrq/Q/mJLN8DUK0+bihL83y6Iy
   g==;
X-CSE-ConnectionGUID: zl/K5xxzSlSKwhKF2KgzMQ==
X-CSE-MsgGUID: qToME+hgQ32DY9U1zfdHqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101398321"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="101398321"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:18 -0700
X-CSE-ConnectionGUID: UcKUDA3IQC+3SlbzSnW4/w==
X-CSE-MsgGUID: Bp44ACJtR3aIRepdVEOE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273555242"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:21:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH v4 wireless-next 05/15] wifi: mac80211: Fix a kernel panic in ieee80211_encrypt_tx_skb()
Date: Mon,  4 May 2026 10:20:45 +0300
Message-Id: <20260504072055.1292999-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
References: <20260504072055.1292999-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 518D94B9451
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-35812-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

skb->dev may be NULL for frames on non-netdev devices. For example, NAN
device frames after pairing. Fix it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/tx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index c18de2cb3769..933c86ca21c3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5355,7 +5355,7 @@ static int ieee80211_beacon_protect(struct sk_buff *skb,
 int ieee80211_encrypt_tx_skb(struct sk_buff *skb)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_sub_if_data *sdata = NULL;
 	struct sk_buff *check_skb;
 	struct ieee80211_tx_data tx;
 	ieee80211_tx_result res;
@@ -5370,7 +5370,14 @@ int ieee80211_encrypt_tx_skb(struct sk_buff *skb)
 	__skb_queue_head_init(&tx.skbs);
 	__skb_queue_tail(&tx.skbs, skb);
 
-	sdata = IEEE80211_DEV_TO_SUB_IF(skb->dev);
+	if (skb->dev)
+		sdata = IEEE80211_DEV_TO_SUB_IF(skb->dev);
+	else if (info->control.vif)
+		sdata = vif_to_sdata(info->control.vif);
+
+	if (WARN_ON(!sdata))
+		return -EINVAL;
+
 	tx.sdata = sdata;
 	tx.local = sdata->local;
 	res = ieee80211_tx_h_encrypt(&tx);
-- 
2.34.1


