Return-Path: <linux-wireless+bounces-35784-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cADbLHkO92mQbgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35784-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C05784B5014
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB7C23003BD5
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 08:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471ED3AE6FA;
	Sun,  3 May 2026 08:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PmIBKDEW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52923AF65E
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777798771; cv=none; b=nGzpix3/aSZ1fqBQK+DJJyGZnm+pel9UBQfuRAZK/nuSmYd1/MnOflOqsgrzEv9bHqFtOM4zKxyOorphdcWUUTJmM4wdzI3PZ22Mpfmm7QSEbyyum+S6GyDJRmw2fg05E6GDt6iLBH27Jcex9/L5dI96FGZ5RFyeK346OLs92Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777798771; c=relaxed/simple;
	bh=RS3EKfpot6D7dTUjQ3XjZqVY1xcnz4AL+HQugEAKGqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sX9+bKl8u6Q7Mto6FcWWRhM0u+dpA6kYXsaA92aQQR1pGr4mmsPci5Y8WmiAsC4OcRqkWRHmisM/wY4lJ/In4/cnZoy0iUVllN6qySApPYPonmq4GiDYmchxEaJDSmKOLr+udFiHQH9rebL4AoLErny3EVh+ebHQxgNyfsl7shg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PmIBKDEW; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777798768; x=1809334768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RS3EKfpot6D7dTUjQ3XjZqVY1xcnz4AL+HQugEAKGqA=;
  b=PmIBKDEWOt9Aj6hnY59OLANRkG7wEIZ5WRk+4Dj4TdNJCECW1OZ2MJE4
   uYt1jpbg0gxdBlpyhwycE6iY5xPQ3qkl/HFTlEZddomER3Q2DNyFFqGYL
   HKzCD3bp8oy9UUREdTamSP2NWb65QM2Bii6w63G6UF/xozvohBKuBBwu4
   jWTelxJ8AwXn/4ouMDPp8w6n72Pc7u4dqMSEO31XbktS076T3nODg9TNb
   KtKxojNu2Da+y0nfhDFBIFXutQbF12eF4q9134PQ0015mBeZUJd6dqW5Z
   RKa993X49RmTnHO8EnNf2EV9qsVWkMLEOlPIvyoVzTo/jZnRJ5HzbGbQU
   w==;
X-CSE-ConnectionGUID: wHoqfPqTQ9qsXkDM+/TI0Q==
X-CSE-MsgGUID: Kgsor2RgRJyaQcJ1BYsTxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="89380401"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="89380401"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:27 -0700
X-CSE-ConnectionGUID: a3555yVfSyCYcrwngemEqA==
X-CSE-MsgGUID: KtbtqpG7TJmCzQO2N3/pOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="235123791"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2026 01:59:26 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [PATCH v3 wireless-next 05/15] wifi: mac80211: Fix a kernel panic in ieee80211_encrypt_tx_skb()
Date: Sun,  3 May 2026 11:58:57 +0300
Message-Id: <20260503085907.257378-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
References: <20260503085907.257378-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C05784B5014
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-35784-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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


