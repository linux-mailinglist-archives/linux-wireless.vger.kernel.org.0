Return-Path: <linux-wireless+bounces-18443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5953EA278CB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C601882ACB
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C51216609;
	Tue,  4 Feb 2025 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJQse7ia"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EE42165F4
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738690998; cv=none; b=TyLN7w+4FyXebMQYUTk6fRct1lrqjDzJbcaBWYJT1PvtGowotwnbG6C0zMnaV87hlf3f5LB1wpVZyw3VoC02genbp+a95NsoI5UbVj41ndGI55lKrZ2Kv9n23VH5GKS8FNIDT23dM8xC+HXu1pdapMY6gtLlf2dK8MNUYqpWtWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738690998; c=relaxed/simple;
	bh=xyxI2LWjPg+jJGbHlxEwgJArzPq3I3qPFeLsDmhVwM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cuiDBYnSEYQ9znyyqRtyINCoaNZVGO7USsQuYSQwVsGNPrO5lNDvMOyO0vMy1CwKhMsh9Q6/aXWntycU8vrroCx8ua9HkY5e7mc0Te3WFtxyRBSrNZ3nZpT1xpWZ66lxv5vX0wHNlCQv6USQIDfnOb2fhwlArQ2v4n9wKpMBsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJQse7ia; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738690996; x=1770226996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xyxI2LWjPg+jJGbHlxEwgJArzPq3I3qPFeLsDmhVwM0=;
  b=jJQse7iasxPm6GOVEnEvB6zsWlK4LeVsaDTYh3Txtfj/4rO2GCbpSzfK
   XMG0bqSDPmL4lpQwUcC/YZ1nv5nK6EAx8w8w+0KyAxW/LzjWLT50FHGCT
   HcfEzhAC/aEZ5RJX2Q9zz8wprp2gSWB16e/lNN9fRc6LO3wP2nYyhc8jt
   A1IfKGRkMk8ifHaTwB2kRsu1CeqNa2LuyyV9mhtKjcmFlEqNjATRqLKLx
   796B+0WVnu0JGv4kDFF28yqppOGMDOi2nMgTSzzFhYsm39Q7rpoUrru0b
   CS+I31+Z5T9wBwDbogUjE9yMmD0Pk3ADiDPQrrPMkprnNVHis6fUPRtHP
   g==;
X-CSE-ConnectionGUID: vB7VhjeER12iZrvGn1y6ag==
X-CSE-MsgGUID: jqelowLXSqmW21PwwEIqiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585371"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585371"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:42 -0800
X-CSE-ConnectionGUID: fQnofeGVQdOFKezxZ8Vwfg==
X-CSE-MsgGUID: lnD6GTC/TJCWmVZvNT4ApQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696697"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 04/20] wifi: ieee80211: Add missing EHT MAC capabilities
Date: Tue,  4 Feb 2025 19:42:01 +0200
Message-Id: <20250204193721.6c1643c345a1.I7405b9c35cb39ae97a52c3fbcc36b0bd81e495dc@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Add missing EHT MAC capabilities definitions.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/linux/ieee80211.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 8f35a3a5211c..508d466de1cc 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3113,6 +3113,11 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define	IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454	        2
 
 #define IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK		0x01
+#define IEEE80211_EHT_MAC_CAP1_EHT_TRS				0x02
+#define IEEE80211_EHT_MAC_CAP1_TXOP_RET				0x04
+#define IEEE80211_EHT_MAC_CAP1_TWO_BQRS				0x08
+#define IEEE80211_EHT_MAC_CAP1_EHT_LINK_ADAPT_MASK		0x30
+#define IEEE80211_EHT_MAC_CAP1_UNSOL_EPCS_PRIO_ACCESS		0x40
 
 /* EHT PHY capabilities as defined in P802.11be_D2.0 section 9.4.2.313.3 */
 #define IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ			0x02
-- 
2.34.1


