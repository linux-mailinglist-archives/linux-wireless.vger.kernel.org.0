Return-Path: <linux-wireless+bounces-32022-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DMXGbXclmlJpgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32022-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD51515D86A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 10:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EA013071F09
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 09:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EA93101DC;
	Thu, 19 Feb 2026 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEJLfJuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB2320A33
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494472; cv=none; b=lWJ3qHvp+Ba8p8JqpsItBAJC1QwWFT7CD14FsZchBUZYV9kFLyu0UBDdJz6JxPgXSm1NdhwtdyePonCGzIpF5x17c1aS9FcRcBCMA7alrNUxrQctAjt5fv9uD9J9oNv5vxhMul96dMoOC1S/X8FLNr7r2ffjFYghoa60c8BSRmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494472; c=relaxed/simple;
	bh=QquAHuHUTLcQJXjjGyHAdlF+rkXtdTEfq4ieCEX8VEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GdlSg8GHV953+GCGBXzFo49PGjUtIurs1iOx6wK5LKVguWHz2meSN21lM6jTrnvcDU6vdwMV2FEsbmPh3sSURi0HlVj1n7t1QmJROf3y8Q1casxNkwlkliulhR1N1KdQu6YHKMim1dHcSVFQs1cWEWIc11T8UfN8VtN57QFjNmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEJLfJuK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771494472; x=1803030472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QquAHuHUTLcQJXjjGyHAdlF+rkXtdTEfq4ieCEX8VEo=;
  b=lEJLfJuK99tpEsJiceMklPdgDlcTRH8fmEzm/eJbILraDg5J+XPcDmrp
   DIh75Y+Xk/CAh18BK7A2x2r0/z5Nvxfl6jbw+BOnw50EN3colRbiIQmZ+
   TH9Sfd/OGQpU5pwu186cgl9pOV3xPRcVhAyBaq2DvOnntaex5PaLMLzF9
   0U9wGEbDKKOytt8iqV/dYs9yiQ+XkUT4G+9KkyrxzLGFIR+dP5E9VsN6a
   ozwJi+yrmEqAvLTc5wvlSbW6ZBvQ2IPs+vaLV8U2QV0R8rQHD38oCkgfk
   1w8qs6uqp0/mqk+uuEqeo8bk7ZHb9piVGx6oF3s3JWWMSSLh1EKJ9q6aQ
   w==;
X-CSE-ConnectionGUID: qsq3jXfFR3qEzAAHvkdmeQ==
X-CSE-MsgGUID: 0UogoWLGT6OaSpVeRDAV1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11705"; a="83680113"
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="83680113"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:52 -0800
X-CSE-ConnectionGUID: Evzs6Dl+QJy3YZp9R4DxeA==
X-CSE-MsgGUID: rODiIFL1SQOuteBCO4lhQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,299,1763452800"; 
   d="scan'208";a="218989044"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2026 01:47:50 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v4 wireless-next 12/15] wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces
Date: Thu, 19 Feb 2026 11:47:22 +0200
Message-Id: <20260219094725.3846371-5-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-32022-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: DD51515D86A
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


