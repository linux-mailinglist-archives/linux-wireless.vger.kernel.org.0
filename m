Return-Path: <linux-wireless+bounces-21983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F20A9ADAA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0D45A1DF6
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F63427A12A;
	Thu, 24 Apr 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHRSDOzz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA6727A93A
	for <linux-wireless@vger.kernel.org>; Thu, 24 Apr 2025 12:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745498335; cv=none; b=nO4a9YTz7ccn6lh8vqesle++w6JsA3f/ANSjyuGlK5RrBpUyZmg4UkZ6UHUPB0tk/0eGU6qjtXq8PqDe+jT7umSqu55y41pzC+AdhsPO0JamC1zET4g+I04HJMVv7uTBe6+kkYPr9uU6NUD1wHvvxEK5rqe8xEv0NGrlW70FTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745498335; c=relaxed/simple;
	bh=Dqnu8398QCxua+iNJ2/9Luu/Syu+fAOjE/VGOBGL9Cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y4BPkqgAEgFUMK6PSmOnSkq7xCmpMdXY656WKZqiXzCpExUbzb9OVTruKClo7mgu94Wa05vQyNrM3DOpgdkke0VaEPpZSoScTpy0n9Qje0ytouqJ8LY6+4NgOL/wcXjaRcrrf0g58a2onRMrdUZkzHsfArxKJDntNbAPQd8MLd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHRSDOzz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745498334; x=1777034334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dqnu8398QCxua+iNJ2/9Luu/Syu+fAOjE/VGOBGL9Cc=;
  b=WHRSDOzzNts7Z0rCnAMXwdofHyF1rxzH4ftKfXeKRQOl8HUI8LL2OXfv
   jeZFKD3OVo+diJMY4nHUrXtine3z+bJ3Ctzq8Y6srjWPT6mdnf858j3vI
   bZ0DFXSYRoIzEWowam8QbbCo57IiSgXQn/kXGKSVdHJ380vvC3fbqZk83
   RdcC0+ChjEAhKiKu5lDvR8W+zcPPX+mOexQxa9B09ldVA08+i/+umH7Jj
   4/t2okt+GOZdDD3T0X2Lx1miF/5Azqy9/Zg62rfmk03DZbjBBn9s2x+A4
   yPicBktW/mhoMwSN4lAhChgGCyYO7y/qnquR15DZmLAf/nkN4pWHKBY4B
   A==;
X-CSE-ConnectionGUID: hlErq/+sRWK7du83VkcGcg==
X-CSE-MsgGUID: uEuXY0eCTUqlonQvEkP2+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="47302411"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="47302411"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:53 -0700
X-CSE-ConnectionGUID: JMEr9KQBT4i2kll6GhLfEA==
X-CSE-MsgGUID: 8McFQ1fLROS9JkMBzzPFOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133137402"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 05:38:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/14] wifi: iwlwifi: mld: use cfg80211_chandef_get_width()
Date: Thu, 24 Apr 2025 15:38:21 +0300
Message-Id: <20250424153620.586e12d3d07c.Idc27c446d00a7f7925ee76b356f53b72dafc5745@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
References: <20250424123831.3524359-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We can use this helper now to simplify some code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
index 5c92c0a6818d..8f7578bc46b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mlo.c
@@ -773,8 +773,8 @@ iwl_mld_channel_load_allows_emlsr(struct iwl_mld *mld,
 	if (a->chandef->width <= b->chandef->width)
 		return true;
 
-	bw_a = nl80211_chan_width_to_mhz(a->chandef->width);
-	bw_b = nl80211_chan_width_to_mhz(b->chandef->width);
+	bw_a = cfg80211_chandef_get_width(a->chandef);
+	bw_b = cfg80211_chandef_get_width(b->chandef);
 	ratio = bw_a / bw_b;
 
 	switch (ratio) {
-- 
2.34.1


