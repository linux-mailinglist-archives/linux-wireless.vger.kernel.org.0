Return-Path: <linux-wireless+bounces-33884-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICzOK0FSxGljyAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33884-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:23:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4232C624
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 22:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A2D30E0547
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Mar 2026 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238A830C35C;
	Wed, 25 Mar 2026 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHD20mMo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6DD37C90C
	for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 21:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473369; cv=none; b=kNlsR9fxkA27wzIWGuP/IKurb+isjpriMUGmalhnKkmLl54i4L+jcwjnfJ9Pyg5QUKuUH2R3EMVDpjSk77UuN3PdMAl01DkrikhG1TMMSrXcyDgtmLQz8OssoP0QF6r/72LEZKHsvusxkSEJK6Gfb/MNOtvEmXaEfk8s8j8aHng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473369; c=relaxed/simple;
	bh=MmkCjNQnNwU1y6JddAFHSRkcae0XMMb3P6/yQaWwZW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5SSZ2u+Uyd7yWlOkQuwOIqtRYWHfpq6Ng7AhF4gHc1UVAyzET249o4hpySc/f7mLvGtOhL6kKSR6YnEyVX2U5eOIW2rCt9gd/BCkKOPl6sbUafK7bC8O1pNydQQGooPLbYh9+nVFmErLt9Pdsa/FhRxU1BLmXTRJQ6VQxzovg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHD20mMo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774473368; x=1806009368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MmkCjNQnNwU1y6JddAFHSRkcae0XMMb3P6/yQaWwZW4=;
  b=GHD20mMo6oDS6cpBtxguAcvtAleYp/VnFdba6oGSHjMOqng4CXSdbImu
   LmPxkn/2ic7d5I4zFMmFACqAWi1Skr+w3RO1SL+qmC3enyO5pPRBjlYGy
   eqWb9r4aB0g6bt1VgL/POHj/ivQdKgRuKIv5lW8nRY2nm8QN0bYgtx5st
   bGXwdqa7nzE43KOSQkujtGC1I7qKWQFa2D71ao9anzMAbVHnKBhwDZmQ0
   dMVgQMOPxyJXVKRam/6xjagBPe+i8Qycx6BrT1uLvVpDNkEWzjM0kpPQ7
   /8fheAL4WEEBWVuCbT1x0MYxr9EWRMA3YbQFHYx3kXNFnN6RX1acNLCrd
   Q==;
X-CSE-ConnectionGUID: AJ765YvUTOqPtinbxuF+Eg==
X-CSE-MsgGUID: yKXUZ+nYSN+1W0r0l3D0Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75485385"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75485385"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:08 -0700
X-CSE-ConnectionGUID: dPh0cN8ASJmUUaGWeSXkUQ==
X-CSE-MsgGUID: em1+ZxViRwyv/tnTXRAeCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="224747550"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:16:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: mac80211: allow block ack agreements in NAN Data
Date: Wed, 25 Mar 2026 23:15:34 +0200
Message-Id: <20260325230443.aef1006ea6b7.I104435f2af65e032cba168b1d842cb9610720041@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
References: <20260325211536.910411-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33884-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52D4232C624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow receiving and sending Add Block Ack action frames for NAN Data

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-tx.c | 3 ++-
 net/mac80211/rx.c     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 01d927b88264..4833b46770b6 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -641,7 +641,8 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 	    sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
 	    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 	    sdata->vif.type != NL80211_IFTYPE_AP &&
-	    sdata->vif.type != NL80211_IFTYPE_ADHOC)
+	    sdata->vif.type != NL80211_IFTYPE_ADHOC &&
+	    sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
 		return -EINVAL;
 
 	if (test_sta_flag(sta, WLAN_STA_BLOCK_BA)) {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index a00b73420929..979ac26d1173 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3748,7 +3748,8 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 		    sdata->vif.type != NL80211_IFTYPE_MESH_POINT &&
 		    sdata->vif.type != NL80211_IFTYPE_AP_VLAN &&
 		    sdata->vif.type != NL80211_IFTYPE_AP &&
-		    sdata->vif.type != NL80211_IFTYPE_ADHOC)
+		    sdata->vif.type != NL80211_IFTYPE_ADHOC &&
+		    sdata->vif.type != NL80211_IFTYPE_NAN_DATA)
 			break;
 
 		/* verify action_code is present */
-- 
2.34.1


