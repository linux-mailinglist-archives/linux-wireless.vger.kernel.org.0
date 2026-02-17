Return-Path: <linux-wireless+bounces-31943-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDm6EZtXlGkXDAIAu9opvQ
	(envelope-from <linux-wireless+bounces-31943-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1839714BAA6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 12:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 126E73011357
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941C336EF9;
	Tue, 17 Feb 2026 11:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RV4yT5lw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8923370EC
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329404; cv=none; b=mWW4KN9qO7PHheywjApY2wG+vI8bUGYOz+Q21RZuB5TfJzKwzP00tk2Tp8/19I8NsKg5zahWf64mRye0FsNvWOA9oMs6uSGF7CAkN7285H9qOPAMV1+rDOvI+f8ponR0bBispzMsAisxFBF8kF4sXhvp6Yr/kj2EEBOJt/euRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329404; c=relaxed/simple;
	bh=QquAHuHUTLcQJXjjGyHAdlF+rkXtdTEfq4ieCEX8VEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mluo7tcwsyP4750SL+Rthvw0V4yiJTkMGEuyKjEwW3aog8c6rB8BB6qSLMWirMsNdc7YcgTQ+Gxp1RHxxoV2+ngkDP7lPn5kHJjBMDui+HDcVpjL8VO5puXnUnPWGW11OOJYKjR/S89z1U+MGPd49J7W2BUmze17X+6UXtWkr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RV4yT5lw; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771329404; x=1802865404;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QquAHuHUTLcQJXjjGyHAdlF+rkXtdTEfq4ieCEX8VEo=;
  b=RV4yT5lwYtWpCd4Mf+UakoCOfmEvGNeoXCUHsJIj7Vzs2+ofsB7oymC9
   1hDQ5d6wyUg+VzVSyEPno/nLIOU8H+T5dylzknASPT+sFCrSn0UD//k9S
   AEIo+JmVzypp5r8qcPGOckbfFL9a3sFw8ClOHW2wckNJHNPpOJdNH0eaT
   iPIZlL35T6CDjEyKQbcerpExXIYVs0NjvYsZIZAZf23rEH+CH3Nayv4VB
   zxARrPBdxU6wO/3VxnRJ3aZBPbQhhxC96dYDVClphsO9tGces+AK3QVDl
   zboMkGMZvqPSzDkMgGj6tTQ3q68q/gWaY1TbQz0o3i+XGMfz4SgnCHPSx
   A==;
X-CSE-ConnectionGUID: CbmThl+YQoatMKWn9OUZaA==
X-CSE-MsgGUID: bBN6ZChyTEm3+k0GBrHeGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83495878"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83495878"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:44 -0800
X-CSE-ConnectionGUID: wPz9y8hpTHK9Mnr5bVnTdw==
X-CSE-MsgGUID: I4KlF+UPQDOz0T+MNNcX9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="251547154"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 03:56:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>
Subject: [PATCH v3 wireless-next 12/15] wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data interfaces
Date: Tue, 17 Feb 2026 13:56:15 +0200
Message-Id: <20260217115618.2066972-5-miriam.rachel.korenblit@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31943-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,intel.com:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1839714BAA6
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


