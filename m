Return-Path: <linux-wireless+bounces-33962-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBMdGS4MxWn05wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33962-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB51333813
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 11:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35DC431B8349
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC4301465;
	Thu, 26 Mar 2026 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NuKBAL2N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033303C73E0
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774520119; cv=none; b=QDFffNlWeWsnQMEdSn3hlXvpqmmYisPbGq7/NTbZdnlyfOpQjDcWUhT3HaGqYAoZq9zv/gTXX123GJjZKwG9B1ZBxWeKsEiD2oUUy90oT17Vm6JkNBJTyBoHfrS673ZlAX6+Ynduy0PjF4xIB+Uj088cv2cCp5/G76nhxjlkoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774520119; c=relaxed/simple;
	bh=RKadrG6CCETLS3BVOgAz8sgr8mKsa4om1H1+QSi5dgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W/FLXcqxHzXdEC45YlWu8ag0MRW4EnY1VbpUN9qobxR5U13IGenABCsQei9aHqo4VPDvlas4LpQJNxrZSDp81EhfPB5Qm2ZF5NonpcbZy9Oqe43gdtI2Ev3AtUQg8EXfMLntm7ByM/hNPAlWXBlI5Nn/SokiaScYkEbxTlmklD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NuKBAL2N; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774520118; x=1806056118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RKadrG6CCETLS3BVOgAz8sgr8mKsa4om1H1+QSi5dgc=;
  b=NuKBAL2NNXQx6u0SqOcILglvGz+QwbdP/CpdiiejXPKdAC1VC4qzKRqx
   +EOjKTsCzmg3CFDnNqNFBGe1Hvito/39O20ip8HAvM/zhjdPOr2g4w7Fa
   Rm+i+eseANf6Q6nh2PNErLwHFj4BdPIAaYyxtha5Skiw45wPM6T7GTN4+
   pRGEZY5OxpaVUCfd7RJH4accIRjap5x5DhYzHyWaWoQjhEBzzXpu5C8RQ
   P39kSWC0kvBoShxlwapMY8I0lmhSuonEhb1elDYWFXyAje05ddppMbf1d
   AsHWZ1xI2JZ+ThZd6IPZG13bOo9HL4LnDR/pMD7GCaYuy5f+6L+MbMZF6
   w==;
X-CSE-ConnectionGUID: 51xQGzvOReO0bQ6Wu8kZNg==
X-CSE-MsgGUID: MaoYQUNdRDiQ4WGZEGmORA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="87048576"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="87048576"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:18 -0700
X-CSE-ConnectionGUID: 5KEe/mt6QFSbpqtL/4gu8g==
X-CSE-MsgGUID: RfGy6C8NT4OqOByI68vlHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="221653250"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 03:15:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Avraham Stern <avraham.stern@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 wireless-next 15/15] wifi: mac80211: allow add_key on NAN interfaces
Date: Thu, 26 Mar 2026 12:14:45 +0200
Message-Id: <20260326121156.34961ba9a0c4.I5b7c646c456d4112e5ab8663026153ace9b6b7d6@changeid>
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
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33962-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAB51333813
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Avraham Stern <avraham.stern@intel.com>

Keys may be added to the NAN interfaces to protect
NAN management frames and data, allow that.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/cfg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 8cdbefac1bee..210f0030f228 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -702,6 +702,8 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 		break;
 	case NL80211_IFTYPE_AP:
 	case NL80211_IFTYPE_AP_VLAN:
+	case NL80211_IFTYPE_NAN:
+	case NL80211_IFTYPE_NAN_DATA:
 		/* Keys without a station are used for TX only */
 		if (sta && test_sta_flag(sta, WLAN_STA_MFP))
 			key->conf.flags |= IEEE80211_KEY_FLAG_RX_MGMT;
@@ -718,13 +720,11 @@ static int ieee80211_add_key(struct wiphy *wiphy, struct wireless_dev *wdev,
 	case NL80211_IFTYPE_WDS:
 	case NL80211_IFTYPE_MONITOR:
 	case NL80211_IFTYPE_P2P_DEVICE:
-	case NL80211_IFTYPE_NAN:
 	case NL80211_IFTYPE_UNSPECIFIED:
 	case NUM_NL80211_IFTYPES:
 	case NL80211_IFTYPE_P2P_CLIENT:
 	case NL80211_IFTYPE_P2P_GO:
 	case NL80211_IFTYPE_OCB:
-	case NL80211_IFTYPE_NAN_DATA:
 		/* shouldn't happen */
 		WARN_ON_ONCE(1);
 		break;
-- 
2.34.1


