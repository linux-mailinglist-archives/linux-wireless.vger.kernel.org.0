Return-Path: <linux-wireless+bounces-31904-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WC7gKkuSk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31904-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145A147D16
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCD7630078BA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A3929AB00;
	Mon, 16 Feb 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKZbpHaX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC7629617D
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278913; cv=none; b=LzQuOHjtuq9QplX/FMIGFP6GIvkHQzojNThLleJuhwufIOvi0A3MmOo0BY57TkdytWGPkflpcT6i4W40NCM6LFmwWbHyFEitKVmc5sKrfgOSIWqAkCKAHf3YD+F94WDGWpDv1UQcOw0llQ3mJFuFcOQLLNRg2HoDfPin7QDfvXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278913; c=relaxed/simple;
	bh=5y6uFy0UkB5D6/j5pbue7X64l2XYYIebotFdZCYLr9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLDh25PVwS2peFwjjiTdecNYUDPqaYh/pmenGibVPpW7WtWXUUVsNw0j+a6MCdBe2S/9lBRg6hWy690VqAk0ByOUwlZqwBLgK00g7GDVVtQXJQquQ+YJTP81LEKs5DxcHVF8JZv8xpsmFjCJhDmP7E6y1Tm1xNXP+82iLSr3xCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKZbpHaX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278911; x=1802814911;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5y6uFy0UkB5D6/j5pbue7X64l2XYYIebotFdZCYLr9E=;
  b=SKZbpHaXjrtFq8y/66EjlB4BFoxNvofAeOgx568fOdhaYvfzYz+VDYjg
   ky4CmwNOm+vs30gjhYQ/8Q7VgJ14UGMSHr0nkkBNFgt+scoslvNbORbnJ
   N4W90DC8rrfhCpXIT7ZqaJj8WRC1BBgJJjmLjjCbm0+EB0ZLRS45ES0Vk
   guxYJbIdSivh70rOQOBS0aYXDmgPh2xnjVjB2fybxUGX5ThRJe3vlUR+a
   pQkmv/ob09HSmh8FmH7H5gjSydoHeiFxlsZbozz7zviDQjsp0Jxt4266F
   /oMUnrP3ZGpJZlao1XwFB3ABtFZ/0WVn/xOfdq/dYt3P3dDzqyczJE0ww
   A==;
X-CSE-ConnectionGUID: osRNAn5TSeuJ33ePcB3XOA==
X-CSE-MsgGUID: RMYksbwUTR+A3BCYy7lLTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980288"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980288"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:10 -0800
X-CSE-ConnectionGUID: OaoP6gLsQF2qMeipzr+gxA==
X-CSE-MsgGUID: bVuQ1RVcTQaadbM5WG4ZkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547306"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 05/15] wifi: nl80211: don't allow DFS channels for NAN
Date: Mon, 16 Feb 2026 23:54:42 +0200
Message-Id: <20260216215452.1538316-3-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
References: <20260216215452.1538316-1-miriam.rachel.korenblit@intel.com>
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31904-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5145A147D16
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


