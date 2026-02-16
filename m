Return-Path: <linux-wireless+bounces-31911-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P3QFVuSk2lu6gEAu9opvQ
	(envelope-from <linux-wireless+bounces-31911-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A08147D48
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 22:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8161300B59E
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 21:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EE2D9EF3;
	Mon, 16 Feb 2026 21:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="di0Ghkhg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A373D2E62B5
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771278919; cv=none; b=JBrWvcLTHYEE7cmn3Cxf9YLdDh9d4M8OLO/OyT+rHXLkfKo8Lktg1JyrlpSmrcksfMY616Ytdd3ciGBXjmFBQGjZJHF4uhBuXZ+iHxLY/L9tZwRTYNyGVgJjbJzp88yOiZc9wELaPF4mAgkZ6Zo619glly+7GXFC38m7iweLSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771278919; c=relaxed/simple;
	bh=QquAHuHUTLcQJXjjGyHAdlF+rkXtdTEfq4ieCEX8VEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YnB+nZsYx0w5Ai3L10JYbbjThCKjkSYSXBuQoVp0iRYhs/SortZrMwGcEF+N4Vy2YO7gKKktjik1d/ECkqB0FLqFMU2Qv7LvjUorYvcRVzbVuPRaigm0EWF79xqzTxkSmP4AYCoR3fUkCw91GLrJMfWQjHxHo1X3EFJStn6XyPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=di0Ghkhg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771278919; x=1802814919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QquAHuHUTLcQJXjjGyHAdlF+rkXtdTEfq4ieCEX8VEo=;
  b=di0Ghkhgaiw9UmPCCcEDzME6whMZgP2Q/wXWt1VGe4IZ+D7mV3lGM+md
   w9n+MBcTr2S4xpUIrG/eIiajfHEKLUBQn7wpP2PNjec9vgl2VCjoYGHkp
   FwywmRJKOYI9ZRU7rJUQ4HrQymr1oYkim3aSu+2bPfCDBja4VoXyP9p+m
   JPL8bCEbUnJnyy4HKVdGhvzpj2JIJKjzc1V1Z/7b6ipf1qv86Je4BOM5U
   q0q2TTGt8pgXlYo26JN83MHyVUEC2iyKOIdP/7JBuDRAlOKlYthWv0Ts8
   rCZxFd+vxz2CNGPm7vGZQsuXZQDc/TaI5z52AYcqG5TJ1ks0ObgiqnG5N
   g==;
X-CSE-ConnectionGUID: n0LEqkuLTfiZEfhMqjT9qQ==
X-CSE-MsgGUID: SKUN8bnoRZi9p+Z9bkarNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="75980298"
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="75980298"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:19 -0800
X-CSE-ConnectionGUID: U/HbwposSECdVBaic6sXrg==
X-CSE-MsgGUID: wK+C0VTFRpiV8Rn/kKfwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,295,1763452800"; 
   d="scan'208";a="213547365"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2026 13:55:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH iwlwifi-next 12/15] wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces
Date: Mon, 16 Feb 2026 23:54:49 +0200
Message-Id: <20260216215452.1538316-5-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31911-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: D6A08147D48
X-Rspamd-Action: no action

From: Daniel Gabay <daniel.gabay@intel.com>

According to Wi-Fi Aware (TM) specification Table 3, data frame should
have 0 in the FromDS/ToDS fields. Don't drop received frames with 0
FromDS/ToDS if they are received on NAN_DATA interface.
While at it, fix a double indent.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20260108102921.de5f318a790a.Id34dd69552920b579e6881ffd38fa692a491b601@changeid
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index f2ebef59a943..dedbed33311f 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -625,8 +625,9 @@ int ieee80211_data_to_8023_exthdr(struct sk_buff *skb, struct ethhdr *ehdr,
 	case cpu_to_le16(0):
 		if (iftype != NL80211_IFTYPE_ADHOC &&
 		    iftype != NL80211_IFTYPE_STATION &&
-		    iftype != NL80211_IFTYPE_OCB)
-				return -1;
+		    iftype != NL80211_IFTYPE_OCB &&
+		    iftype != NL80211_IFTYPE_NAN_DATA)
+			return -1;
 		break;
 	}
 
-- 
2.34.1


