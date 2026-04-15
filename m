Return-Path: <linux-wireless+bounces-34804-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPLYCmuy32lCXwAAu9opvQ
	(envelope-from <linux-wireless+bounces-34804-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:44:43 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF144060E2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 17:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8221E30ED4C3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2026 15:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E38381AE0;
	Wed, 15 Apr 2026 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y/JmtzmY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4403DF00E
	for <linux-wireless@vger.kernel.org>; Wed, 15 Apr 2026 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267377; cv=none; b=Uo8HHkbEetV9fNIyIvFlNayY4LlXqaFgtqioykFs9sOANzZ7sRhixVeoHdMh4FsU89qLE4KQBWlJyK5m7IDTpSPi2k4TfGzRD4Ui3XxhINApn4YEYc/czH1zOw8xixyKPM1CLFBh90Ml1HyfQw/pT0aej39dO+h+nLHG7m2Nxpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267377; c=relaxed/simple;
	bh=LJgVyZr/QUhuqKLGQrb5EImLikk3s3kfVWHLOZi+C38=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lfbMLTGKtrMjYPRORqdi6IMbByJ02O4vttX0EdWfHF/GzL3/hm6i0SJdKG/CLXNILjwpoOriwINOLZp0em015nfRTNWMls8XyAff0+mcRTHk+ds8NNbT1pBrzFO5Go0vgGtUqBu1q1bZgnSP22TbVz1GXwb35l8cC2N5vxOTxI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y/JmtzmY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776267373; x=1807803373;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LJgVyZr/QUhuqKLGQrb5EImLikk3s3kfVWHLOZi+C38=;
  b=Y/JmtzmYoTrKq4/hXnwDf4L9EeVxnyZReAsTW6Z1bMd1xE3WrTMGY6jH
   0TXI+DCajNXOOPW521gBWE7+yZU+9Im6xuPJZbdpbvhYuE86CsRPsG6cj
   Gpfm2HKjRvaFLjQ/S/Y5p+nk7nlFth45s4UezW5tr8R0J1zXzPyBPbE8D
   ihZ5Kflapxe1M8cVYbHfEhtCKl7GVFFdK/9EqAVxDGm2b4GAuh4dkCmD8
   AJfUJuHrfF2s/jhyK1u2ff9yXpe9TEmr3Ibi/zz7X7BdZv/vbmunk2AZ1
   1k4UWSMzvwzZYcAgR0ECzHH7U4UXMFyDH0t8d0iOivnszehwNUY3h+/Yv
   Q==;
X-CSE-ConnectionGUID: r5ViAGgtT9isroiSpChQfA==
X-CSE-MsgGUID: ng7NkjBSQP2GeuB3fMj6ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77361035"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77361035"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 08:36:09 -0700
X-CSE-ConnectionGUID: o7ZJUW7sQ86iO5VJSnO8DA==
X-CSE-MsgGUID: Gm3J3V6FRDSlF7zGL5M1dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229429920"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 08:36:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: validate cipher suite for NAN Data keys
Date: Wed, 15 Apr 2026 18:35:55 +0300
Message-Id: <20260415183550.14a422ac52fd.I486ae7188bc60e44503ecccc99af6ae3a31d16b8@changeid>
X-Mailer: git-send-email 2.34.1
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
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34804-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sipsolutions.net:email]
X-Rspamd-Queue-Id: 8BF144060E2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Gabay <daniel.gabay@intel.com>

Per Wi-Fi Aware v4.0 section 7.1.2, NAN Data interfaces shall only
use CCMP-128 or GCMP-256 for frame protection. Enforce this in
cfg80211_validate_key_settings() by passing the wdev down to it.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.h        |  3 ++-
 net/wireless/nl80211.c     | 11 +++++++----
 net/wireless/util.c        | 10 ++++++++++
 net/wireless/wext-compat.c |  3 ++-
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/net/wireless/core.h b/net/wireless/core.h
index ae2d56d3ad90..0e6f9bd4ba1b 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2025 Intel Corporation
+ * Copyright (C) 2018-2026 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
@@ -446,6 +446,7 @@ bool cfg80211_supported_cipher_suite(struct wiphy *wiphy, u32 cipher);
 bool cfg80211_valid_key_idx(struct cfg80211_registered_device *rdev,
 			    int key_idx, bool pairwise);
 int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
+				   struct wireless_dev *wdev,
 				   struct key_params *params, int key_idx,
 				   bool pairwise, const u8 *mac_addr);
 void __cfg80211_scan_done(struct wiphy *wiphy, struct wiphy_work *wk);
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index f334cdef8958..31a39ffc7d0d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1733,6 +1733,7 @@ static int nl80211_parse_key(struct genl_info *info, struct key_parse *k)
 
 static struct cfg80211_cached_keys *
 nl80211_parse_connkeys(struct cfg80211_registered_device *rdev,
+		       struct wireless_dev *wdev,
 		       struct genl_info *info, bool *no_ht)
 {
 	struct nlattr *keys = info->attrs[NL80211_ATTR_KEYS];
@@ -1782,7 +1783,7 @@ nl80211_parse_connkeys(struct cfg80211_registered_device *rdev,
 				goto error;
 		} else if (parse.defmgmt)
 			goto error;
-		err = cfg80211_validate_key_settings(rdev, &parse.p,
+		err = cfg80211_validate_key_settings(rdev, wdev, &parse.p,
 						     parse.idx, false, NULL);
 		if (err)
 			goto error;
@@ -5407,7 +5408,7 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 	if (!rdev->ops->add_key)
 		return -EOPNOTSUPP;
 
-	if (cfg80211_validate_key_settings(rdev, &key.p, key.idx,
+	if (cfg80211_validate_key_settings(rdev, wdev, &key.p, key.idx,
 					   key.type == NL80211_KEYTYPE_PAIRWISE,
 					   mac_addr)) {
 		GENL_SET_ERR_MSG(info, "key setting validation failed");
@@ -13163,7 +13164,8 @@ static int nl80211_join_ibss(struct sk_buff *skb, struct genl_info *info)
 	if (ibss.privacy && info->attrs[NL80211_ATTR_KEYS]) {
 		bool no_ht = false;
 
-		connkeys = nl80211_parse_connkeys(rdev, info, &no_ht);
+		connkeys = nl80211_parse_connkeys(rdev, dev->ieee80211_ptr,
+						  info, &no_ht);
 		if (IS_ERR(connkeys))
 			return PTR_ERR(connkeys);
 
@@ -13605,7 +13607,8 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	if (connect.privacy && info->attrs[NL80211_ATTR_KEYS]) {
-		connkeys = nl80211_parse_connkeys(rdev, info, NULL);
+		connkeys = nl80211_parse_connkeys(rdev, dev->ieee80211_ptr,
+						  info, NULL);
 		if (IS_ERR(connkeys))
 			return PTR_ERR(connkeys);
 	}
diff --git a/net/wireless/util.c b/net/wireless/util.c
index cff5a1bd95cc..95ae06e94f10 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -284,6 +284,7 @@ bool cfg80211_valid_key_idx(struct cfg80211_registered_device *rdev,
 }
 
 int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
+				   struct wireless_dev *wdev,
 				   struct key_params *params, int key_idx,
 				   bool pairwise, const u8 *mac_addr)
 {
@@ -344,6 +345,15 @@ int cfg80211_validate_key_settings(struct cfg80211_registered_device *rdev,
 		break;
 	}
 
+	/*
+	 * Per Wi-Fi Aware v4.0 section 7.1.2, NAN Data interfaces
+	 * shall only use CCMP-128 or GCMP-256.
+	 */
+	if (wdev->iftype == NL80211_IFTYPE_NAN_DATA &&
+	    params->cipher != WLAN_CIPHER_SUITE_CCMP &&
+	    params->cipher != WLAN_CIPHER_SUITE_GCMP_256)
+		return -EINVAL;
+
 	switch (params->cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
 		if (params->key_len != WLAN_KEY_LEN_WEP40)
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 22d9d9bae8f5..28bc996c1437 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -489,7 +489,8 @@ static int cfg80211_set_encryption(struct cfg80211_registered_device *rdev,
 	if (addr)
 		tx_key = false;
 
-	if (cfg80211_validate_key_settings(rdev, params, idx, pairwise, addr))
+	if (cfg80211_validate_key_settings(rdev, wdev, params, idx,
+					   pairwise, addr))
 		return -EINVAL;
 
 	err = 0;
-- 
2.34.1


