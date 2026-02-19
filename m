Return-Path: <linux-wireless+bounces-32015-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LiHOUHclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32015-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:47:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF01815D812
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 223F03007896
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAB6318EFE;
	Thu, 19 Feb 2026 09:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIsdh04n"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31442ECE91
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494464; cv=none; b=cAXjJfImMPCchoYvIMJ2M+VI3xrH7c2CQytSaC+hIHtt064fSTRyeW6+otz0/VR6joJBFmMxYdlczQgSff404o2ivt7lzf3+qU59hNoXtXQqsRlQ6Tt68llI3l8ecCZsXuw1RtkvNFAdlRMCw1rMD/ZF8qDpmk2t0vI5tHT/fDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494464; c=relaxed/simple;
	bh=5y6uFy0UkB5D6/j5pbue7X64l2XYYIebotFdZCYLr9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tnj7Vaj/JeTyAUGDeICRocsyvgy2aklTSy8/yaY7YbxPen5sa3crQ2UjLjB9YdbwiXX9v2qWKNKDZwF+t9EdcgmhE6zXwPT4RSfEz3f1T2X/IAz2oBNXcrF3G6nNbpNt2aNVSWcH7ljigM2OksL+/uhMTYPjmKIHLW46acegQ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIsdh04n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494463; x=1803030463;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5y6uFy0UkB5D6/j5pbue7X64l2XYYIebotFdZCYLr9E=;
  b=kIsdh04neS0R3+8O0d7hl9CotEkciwf89SzLt/fKuB/OlwTbXn56tNdh
   WAqPyXIuEP3uA9L+b2TpoDRvm4pYRvXkgLxZBlPp/4Uqj3fTfR4JQb9Rr
   42ZXYqvaDVZA/ld+ilMOwr5b/2Dv2/I0ZSFqjIK0UIi3KhxvzJdtly/2h
   vT1Hjimkc5Vwdd/W9sz8Qz1ur8Uzhvo7cPgFr1pumAP3OMWwnJjBPFL3h
   C4l+tse0RL5miJo2HStD0Qj8csZlJlGM4n4E1q8RtggJRSlZZlHhv+I4a
   I9JqDi9ehIQxUKICWlGecxYAyC0A3GYRuTqV+0ol6S++XJBNyLWcPuJ5y
   g==;
X-CSE-ConnectionGUID: a2kmTs57Q9ClCGNYgA4/PQ==
X-CSE-MsgGUID: QKsTp93MQDK10h1zRSQ76Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680083"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680083"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:43 -0800
X-CSE-ConnectionGUID: C3me83hES/6VP01KPOtRpA==
X-CSE-MsgGUID: GbKWPM5ORLytQGZWLEercA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989006"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v4 wireless-next 05/15] wifi: nl80211: don't allow DFS channels for NAN
Date: Thu, 19 Feb 2026 11:47:15 +0200
Message-Id: <20260219094725.3846371-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
References: <20260219094725.3846371-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32015-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
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
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: AF01815D812
X-Rspamd-Action: no action

NAN cannot use DFS channels.
Mark DFS channels as unusable if the chandef is to be used for NAN.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260108102921.c2a5a0a14b9f.Idca29fb8a235df980e63b733a298fd1f2bdf2f48@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/chan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 68221b1ab45e..0dde8f3007f0 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -754,6 +754,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_MESH_POINT:
+	case NL80211_IFTYPE_NAN:
 		width = cfg80211_chandef_get_width(chandef);
 		if (width < 0)
 			return -EINVAL;
@@ -768,7 +769,6 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
 		break;
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_UNSPECIFIED:
-- 
2.34.1


