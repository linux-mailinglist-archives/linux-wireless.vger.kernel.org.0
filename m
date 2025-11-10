Return-Path: <linux-wireless+bounces-28756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0101C466DE
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 13:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2261894D00
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54F83112DA;
	Mon, 10 Nov 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUijyECM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8470A30FF21
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775925; cv=none; b=QQeleyLe5Rq66WrfE4W1BI8reMqSz3fBUxbboehB8ORU39IitKY3v2XZmQ4HGYyLk5CEZTdhMTgVLP94wbvA3b9iCqi2oLF3ddH9ZbYCymfXIdgqPFYP6V0ZXEt5KEGqua/ewUFndoaAJmGYKRRnKrdU7MeEAZDZVEbPE8Mc7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775925; c=relaxed/simple;
	bh=j5lgihoR0iZfI2DhfPvM39iJzXqUUPq0jkJq0Nbfo6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FE/Vc9HjQmtYnk4iAEIHcOFmou1C6ieTIJLQ7ZYlSNVkjLEBOitgAGtE6wXYp+uBYtdr/llCxoukx7wD/33HL4w54Y+Wh1pWeomSAIcqsgMQs+UQwO87rrDNJ5MvpnHPPJLrPvWqFcmkDrCNkX4h/Na+8e9EeU1rE5GXiOPeUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUijyECM; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762775923; x=1794311923;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j5lgihoR0iZfI2DhfPvM39iJzXqUUPq0jkJq0Nbfo6c=;
  b=GUijyECMt9xC5RfFl/3IyEDwLR+MTWqrDGlYAF3gnpXVNMsEhK2WnU8e
   tq8MVgOjHTCFkKIp+zzn3fhwvrivFdt/LIAoyijXZiYqqe6ItZom3SFo0
   /CgklkuIiIql0DTFGafhQy3CnTV4S7Qlt+H+NLMOUh9Cx7zLJuqaMb0UJ
   pHsdi4QoMmIzYDKFLIIlrBsfq0k0Exgdix8/nkOcj56JQu4soWo5Ho1rL
   a+vsOUJZpRdh+cYsxC/aUc5xehWY5J+3fLKQ2d8KJhotFNF43cgCd4+TE
   XAi6ZVRUaEPPoAcsVxIF1lEf9AkugjSWuCT0guztge3dhEZ/iMMYwQu+z
   A==;
X-CSE-ConnectionGUID: 5bBe4rEBS/+lozHtIGYAEA==
X-CSE-MsgGUID: 3zNeAAtpT0+3y/1kjevNrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="75929232"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="75929232"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:58:43 -0800
X-CSE-ConnectionGUID: as8L+115Rx+J8OCKe4HWew==
X-CSE-MsgGUID: B5EehAjVRM6+RAnS9HZIQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188820991"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:58:42 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: cfg80211: don't allow adding/removing NAN function when not supported
Date: Mon, 10 Nov 2025 13:58:36 +0200
Message-Id: <20251110135822.5c545f924515.If337e56bfae927b039bccb4ffa38a3f0e0a8f0f5@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

add/remove NAN function is not supposed to be called/implemented for
devices that uses user space DE.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c    | 3 ++-
 net/wireless/nl80211.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9f858a83e912..56c0e2e4bcb1 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -760,7 +760,8 @@ int wiphy_register(struct wiphy *wiphy)
 
 	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN)) &&
 		    (!rdev->ops->start_nan || !rdev->ops->stop_nan ||
-		     !rdev->ops->add_nan_func || !rdev->ops->del_nan_func ||
+		     ((wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE) &&
+		      (!rdev->ops->add_nan_func || !rdev->ops->del_nan_func)) ||
 		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
 		return -EINVAL;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2187e148389d..61d5cc6622b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15822,6 +15822,9 @@ static int nl80211_nan_add_func(struct sk_buff *skb,
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	if (wdev->wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE)
+		return -EOPNOTSUPP;
+
 	if (!wdev_running(wdev))
 		return -ENOTCONN;
 
@@ -16056,6 +16059,9 @@ static int nl80211_nan_del_func(struct sk_buff *skb,
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	if (wdev->wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE)
+		return -EINVAL;
+
 	if (!wdev_running(wdev))
 		return -ENOTCONN;
 
-- 
2.34.1


