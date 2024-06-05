Return-Path: <linux-wireless+bounces-8528-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FE58FC988
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CEC41F2509B
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D8D191493;
	Wed,  5 Jun 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQS2n/NX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AB191492
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585053; cv=none; b=JKZPHWKRko8HK6riSfmFsuWos1OeSBGs8nv9NjIdDx5qHA/rnUsFTxr5q9WuQz9prNqMbJxKkcPA4Bh0/mVGvlm2XUwyv9Z3H5nCYe2jDbKmhMZISNROxA0vndDdfJp81XXr1liDSlZxQHrNBkCdZTK9epwdyW7nvacOfHOdGbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585053; c=relaxed/simple;
	bh=bYuH1jGmMmrHWesZoIQzrkle/R8C/oqzDdcCiH00NGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d3jh0X4g1B1WgGqnXK5aRAoe9823MRZSzxQxRjZpMScnuZILmjR93BaXtK9N4mVw4OtISzaIf0KcanpyuPFiMQ6jiL52EVtVg+2IfvO6aI4udFq/i2I8S7vrneXjClxqsMyZ+x7g2m0GFHyoQGDJp8J9U8JXLSYNq1I+jNAhqiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQS2n/NX; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585052; x=1749121052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYuH1jGmMmrHWesZoIQzrkle/R8C/oqzDdcCiH00NGg=;
  b=DQS2n/NXRoCGvEx22pV5KV5HiTc4/gNKKufNA36M2HPwEXUpG5f6p2ro
   tGrYhNlyHO0WTQD/VzyAV/U+nlVGsnZ57VvNw/8LDxJTpYK9R4qgSKBW5
   tXJZ6x2WwViCm0DDaVIphh57UpZFZNxBdhMsg4bcT6X4S20Pg/JxrrDG3
   uE8QGLyqdBVqt4Waaw76/o67ymBPyucU0NLbI3HBpcn+BIaw7aBy/G+Eb
   GYm2f9aUT1zKosFGykB3GljYicdCQAHIK+tP1BNWrq4anhcqj/U1fAS1h
   51WG0ryWbr1bhfQ8FjxUwPMWXJmLe+YC+/qQVyO8f3ZcwqSFcWsOJjUV4
   g==;
X-CSE-ConnectionGUID: K99ALj9bT9KuKrMPLaQJqg==
X-CSE-MsgGUID: aAarZUnwSJKnC+SFcJ5TAA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919945"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919945"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:31 -0700
X-CSE-ConnectionGUID: wo0rJoeCR6ayeEJVb7Ahuw==
X-CSE-MsgGUID: 5OnDzSwASnOf67N3BFtrEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563003"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: [PATCH 1/7] wifi: nl80211: remove the FTMs per burst limit for NDP ranging
Date: Wed,  5 Jun 2024 13:57:16 +0300
Message-Id: <20240605135233.916e228537d9.I5fe4c1cefa1c1328726e7615dd5a0d861c694381@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Avraham Stern <avraham.stern@intel.com>

In NDP ranging, the number of NDP exchanges is not negotiated
and thus is not limited by the protocol. Remove the limit on
FTMs per burst for trigger based and non trigger based ranging.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c |  3 +--
 net/wireless/pmsr.c    | 10 +++++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8ff5f79d446a..296acd2a2a1b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -315,8 +315,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_BURST_PERIOD] = { .type = NLA_U16 },
 	[NL80211_PMSR_FTM_REQ_ATTR_BURST_DURATION] =
 		NLA_POLICY_MAX(NLA_U8, 15),
-	[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST] =
-		NLA_POLICY_MAX(NLA_U8, 31),
+	[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_REQUEST_CIVICLOC] = { .type = NLA_FLAG },
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index e106dcea3977..4af6bd354ad1 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Copyright (C) 2018 - 2021, 2023 Intel Corporation
+ * Copyright (C) 2018 - 2021, 2023 - 2024 Intel Corporation
  */
 #include <net/cfg80211.h>
 #include "core.h"
@@ -148,6 +148,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (out->ftm.ftms_per_burst > 31 && !out->ftm.non_trigger_based &&
+	    !out->ftm.trigger_based) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
+				    "FTM: FTMs per burst must be set lower than 31");
+		return -ERANGE;
+	}
+
 	if ((out->ftm.trigger_based || out->ftm.non_trigger_based) &&
 	    out->ftm.preamble != NL80211_PREAMBLE_HE) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
-- 
2.34.1


