Return-Path: <linux-wireless+bounces-34659-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ET8OROM22nuDAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34659-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9743E3BC3
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 14:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B77A3015A77
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 12:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AACC37B41A;
	Sun, 12 Apr 2026 12:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nFA0nbDs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1CF3382F1
	for <linux-wireless@vger.kernel.org>; Sun, 12 Apr 2026 12:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775995904; cv=none; b=BRE1vGO5099qmGvzSRXcufBnDG6vPDTpIdo9gu2UwB1uqQqXtE7XnoLYkjAiMPXcvIoIRECDQdSYAxZsxd9o/AXDO+4yQpMsIEsPql62PA2tBsp3VVrx/NKhGoiyoUAfpBUXbYsDr+BMAoYOvJYzGUUv/5O8UzTlRnqzM6BtjQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775995904; c=relaxed/simple;
	bh=L6RP8XRU8IqiBZEwJPJPL41WmTWf1nQG3y9BMk4ib7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2hsMO3QogaDin+iCe1zNAW81t4YNZt4ptxR8n6pEDSorw5UbutHiyIybMXlwAFLBYDJIgJA7Eg6cPZuCPOW2pKXP9bg2eFt3x56mazZdAum2trX2gRmDgU2RHl7PF5f42Fa1qw1bEkbOgc0p3yGhy1FoT+NuWPM6vmVwFcp2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nFA0nbDs; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775995903; x=1807531903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L6RP8XRU8IqiBZEwJPJPL41WmTWf1nQG3y9BMk4ib7c=;
  b=nFA0nbDsbtnsKlKR5HlDNV/smuQGOaVYGelD19WEPqT4Gc/Pd497M+9e
   E+mFmKZZe2AQ7M5PNZ1rZJMk6uHLvMnGXunkCg7henwLWBDhkG22dLPB2
   mlD+zOwHqX1Lm7QAfUdPVhE8Dz49Rr0nTFK5+Jo8saEPhLKt8AJccWihL
   GMArDX3myi/9oYZJ+sTgqVkDdefNtIqAjyXf7VLi7/ZhwcLBcI/dUCNHx
   VzKwkdSd423Pwd1ZueeE/V3d+JPoNXRS0IW3yIpt20ZWmUUvBkliNjCjS
   X75DHg4O322HHMSFU4oTit955SmqXqgUWekZ8CxjoKKO2J9+oktO4Tp8C
   A==;
X-CSE-ConnectionGUID: 1LkcBWnSTQSbxhRa6h3GGQ==
X-CSE-MsgGUID: KjHpAKpyRUGcCy6gr79ixA==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="88028461"
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="88028461"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:43 -0700
X-CSE-ConnectionGUID: PNZxvb5OSUOaQNyGoRcKVA==
X-CSE-MsgGUID: zUO6qVSQQaaSdha61ytqYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,175,1770624000"; 
   d="scan'208";a="229411898"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2026 05:11:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: mac80211: Fix a kernel panic in ieee80211_encrypt_tx_skb()
Date: Sun, 12 Apr 2026 15:11:14 +0300
Message-Id: <20260412121124.2246222-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
References: <20260412121124.2246222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34659-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C9743E3BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

skb->dev may be NULL for frames on non-netdev devices. For example, NAN
device frames after pairing. Fix it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/tx.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 6ff36bd658e6..230826960721 100644
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


