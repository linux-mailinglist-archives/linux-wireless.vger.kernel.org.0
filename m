Return-Path: <linux-wireless+bounces-33959-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEhsFRIMxWma5wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33959-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E81F33337A7
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A7131B09A4
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1AE3C5552;
	Thu, 26 Mar 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n99zvqtp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F933C3BF5
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520117; cv=none; b=f0b5+72vy0x5K5xOmUND+/I9OYHRve6pZngEU7zvXTH7MM7GGvywzgjm056d0+VYLJat0A2Z8FKvl2Yb5YF4ZlBeu3WWPji7CFnTuVupquhQGlyIs0UFTYPguGqCIqrNRPt1EZdJPcYMJtPsKCFFsYZeOU9h5E/+IEpqXFi2fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520117; c=relaxed/simple;
	bh=9Jg+dwfJNkWw9AO7aDRm5h3MJv5VgnBMT6bZcJwi2jQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PhfZvo1OlFxthj0MPpSHMfSBvLJbLGjdwk0Lw7plCe89H9E84EkIONojA6H1tyKfjLtgaOABjewCP/DclFMkCBhJtQpxh0J5iAsLWXUMjtf+Uld3phPv2UCu9nDQNR4JlxoiAK58X2d+YgzoB32b0a1WStBHZ9o/4YEyrQa2Noo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n99zvqtp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520116; x=1806056116;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=9Jg+dwfJNkWw9AO7aDRm5h3MJv5VgnBMT6bZcJwi2jQ=;
  b=n99zvqtp1IenehPbE3EvH/hHbk8WDZWT8ztwv3W6vNdYiRR+W5ApH45R
   7ZcYPF2AIvWnfYC14Qon8iDs9MxdE7dXicP5s9tVVQdc9M5Bv/JJMt6LN
   MDnGuyU3u0S4PZ9YxWq/kS2RPy72OBM6Eo5eFhCo/6hpBR2FoZHLx+DQ1
   T2/n/w2/ksqGyEknnnmOyJvxt+SAu0FAOe6u6ZpjD0RvB28Mv6LzSPUDj
   jTYWRqV3khh/p5CfoG0lPcwz0erFYdm/BbUwtFZoAjnoAXHrXXEoepDNv
   pgoP4h8Nl5XQJUpmVetLgAQQJOYwWdeBC/nXHRbIL4cH2V83TEh8dVNLh
   g==;
X-CSE-ConnectionGUID: XNtmYCZBRb6W83wo1sm0Sg==
X-CSE-MsgGUID: KPhJyMgXRIO+5YXTO/pmeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048572"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048572"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:15 -0700
X-CSE-ConnectionGUID: hWfAf4EuSbCOprIG5jl8PQ==
X-CSE-MsgGUID: Wn8vEyjUTxCzxlbliWs0kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653230"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:15 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 wireless-next 13/15] wifi: mac80211: allow block ack agreements in NAN Data
Date: Thu, 26 Mar 2026 12:14:43 +0200
Message-Id: <20260326121156.fe51df9d65f4.I104435f2af65e032cba168b1d842cb9610720041@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
References: <20260326101445.1443198-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33959-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: E81F33337A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow receiving and sending Add Block Ack action frames for NAN Data

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
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


