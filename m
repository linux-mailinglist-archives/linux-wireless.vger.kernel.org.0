Return-Path: <linux-wireless+bounces-3228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1FA84B891
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B262F1F23A39
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D8E1339A1;
	Tue,  6 Feb 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OPq+nhSg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BAB13473F
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231280; cv=none; b=rqC+CC8Xmc+GtoJPTMuh0TgPxFogWKX6TaKLXbb1EoOxS7qdwbOi5mz7Js8P+P4PhMHwutjJ0FfXVh0qy8/cMkU34wGTKMvNB0r0wp8tTMxC0J91uyLvijDNvDdZPlTQSPRJLAHT3Q6cC2tZxTAvcal6raMpiGD8OBjhWXm89s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231280; c=relaxed/simple;
	bh=mx3bXq841Ulj/a1gi+PsJ3DUTCk1V3xyn6I3ZUYNDwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U9JU+WHLPKy3XJu2lFEjgJoS0Z/K8fqiQUDO6HWuKEkIfBQxEQmyB170xa3fl5XrJHGTcs2nbs0reVyLZex7YcqIsovR0BLtwXylIdJG+rTnWS2bT2nPTjrjEan/ND4Ag0GQl1ulOjgwi0KO9jmgNNRSuL15W31JEbKiNVJHSa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OPq+nhSg; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231279; x=1738767279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mx3bXq841Ulj/a1gi+PsJ3DUTCk1V3xyn6I3ZUYNDwk=;
  b=OPq+nhSgVbD+q6r3opVKRvjr4ZmOjVc4r9y1UFNqbVl8ddKc5tFGsGOT
   i1C0/+QdCaxl2AuiFrG5OFyyq/+6md9HBYJXlNrFG7pkRnSbqls8fmaBo
   xhrC4+COfFhzGpKGNFO/qvbmls0UKFWOnaTTddzDx2iTgPsnIi8IDO76a
   eu8J/tl6WeQOGtDD9ETVRnx4rEk1+41+PwMCJbXlYllb4cm0QfOvtK2Uu
   71tMPUS1xqDa3n1J+YdPoNPinO9AnqEZ+sxCk6BB4mKqSG0UFX7zKj+5I
   WKVaoQxiepRERaO9mUgeuaVC8w74z8i7i4RKB3T8zh2aSy0D1byFfZVP3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917827"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917827"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197958"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197958"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/8] wifi: mac80211: drop injection on disabled-chan monitor
Date: Tue,  6 Feb 2024 16:54:09 +0200
Message-Id: <20240206164849.9c03dcf67dbe.Ib86a851c274c440908c663f6dd774b79bfc3965d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the driver uses the new IEEE80211_CHAN_CAN_MONITOR, we
may monitor on channels that are, e.g. via regulatory,
otherwise considered disabled. However, we really shouldn't
transmit on them, so prevent that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/tx.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 68a48abc7287..02ef09edb9e4 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -2398,6 +2398,14 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 	else
 		goto fail_rcu;
 
+	/*
+	 * If driver/HW supports IEEE80211_CHAN_CAN_MONITOR we still
+	 * shouldn't transmit on disabled channels.
+	 */
+	if (!cfg80211_chandef_usable(local->hw.wiphy, chandef,
+				     IEEE80211_CHAN_DISABLED))
+		goto fail_rcu;
+
 	/*
 	 * Frame injection is not allowed if beaconing is not allowed
 	 * or if we need radar detection. Beaconing is usually not allowed when
-- 
2.34.1


