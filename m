Return-Path: <linux-wireless+bounces-31936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGJFO4FXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956714BA63
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11B5A303324D
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCAA3358B9;
	Tue, 17 Feb 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YrqxDncr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7055233508F
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329396; cv=none; b=QnGX95x4x/gP/GNHenhYRFG46bW+5jtBpbclIiXLyHzU+JsPLlLRVDZTmOpnDyQi08WKjQxPBrXhvfwLPlm7t8h0HmIdprd05HU9cgBmQobp7EZsRxtgsi+i7SWpDicQiR1cH9RRQyq4ugVvE7ByfYSWUUrj9VDsMKm3IFX4LzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329396; c=relaxed/simple;
	bh=5y6uFy0UkB5D6/j5pbue7X64l2XYYIebotFdZCYLr9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6MJu6UGTUdZPA/oRhPRgaj+c6414VI1XD4sqVQcvx7ZBAN1NtJtxXn14ciQ3u33qux/ZG3chyHZjux9CdLCuagWXegXiYDpKCT96QVqZqG/LQceX/20lBSaLJvPDws6Q6fsJ9DJ+7gk2HLprnJ3I9GnklDWgYDstSp0XmexZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YrqxDncr; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329396; x=1802865396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5y6uFy0UkB5D6/j5pbue7X64l2XYYIebotFdZCYLr9E=;
  b=YrqxDncr2MvVqY/Jb9l0euYp1XzdyuleuODvb2IASI10iy8bWK0g9puf
   E4X96aJycQg++mHgJFW2XxANJbLx8MiZiCIWj1xFPGVLJG5LFGAZHdHq4
   8hAscUwaBP7jwEPN8MGSlr1ZLAu4On47cnLknTew/9jTHyQodPI+xgOa2
   mEmE2fc36R4c61U7Nx9p0Tl56PeuU2xbiikQ0/U0R3gHb4oImVHN3ZjK7
   BdXmFenKjoppkj/UZi6Fb53tI5My5tBoqZhsZ2mrDWP5lPaflPgQoGRKL
   PSgJwfSuCS/6e0zU8tjgLHD6STGtMCSs3vlWdxhtiYBZZwtjCjwHvY2nk
   Q==;
X-CSE-ConnectionGUID: o+0rG68cTnCc4wQolm4S8g==
X-CSE-MsgGUID: abVB1HefRAOtodhhVX23PQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495867"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:36 -0800
X-CSE-ConnectionGUID: 7FwTYDxQQ3aThxNgPWzfvQ==
X-CSE-MsgGUID: Jb4Y9TkWRr2wRSxJVjzxjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547126"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:34 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v3 wireless-next 05/15] wifi: nl80211: don't allow DFS channels for NAN
Date: Tue, 17 Feb 2026 13:56:08 +0200
Message-Id: <20260217115618.2066972-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
References: <20260217115618.2066972-1-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31936-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 6956714BA63
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


