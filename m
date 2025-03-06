Return-Path: <linux-wireless+bounces-19874-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF24A547FF
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D541168875
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419A22045B6;
	Thu,  6 Mar 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F465/mg8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0E209F4E
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257501; cv=none; b=BJNVb0LrIYM1juy94pFl1j044G4emhExX6/q1xGwhOfEkRK5L63NIZxnJVsP06VSz0AqFsHiSOHATFsdDB3jvxj1iwk9SkJxJwF4i6N4suLuap1eCJPol2O6nY9AIFZD+BvCrp02b8qbYY+MBXQ9O/YgenRjhy8FXlYx+dyq/3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257501; c=relaxed/simple;
	bh=ZYNfFyPn/uv9iaTmv1j53v2cCqjuDgD8vvhKJucMvTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oRP5VPc4qMVTRFUPPryqMKC8zt+NlcSTFpEImg6TTB4KX1HwS6am07gWM4HrufT3zMnXgymDqlt/Tc/wvFol4BhWfSgOUFtxMNeerq1DdXwa3XBZw/Ek9xmcL203MRMNX2xGHPPFAkJj7eHPwHVvwa+ye619KhQPi0C/D0SbhPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F465/mg8; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257500; x=1772793500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZYNfFyPn/uv9iaTmv1j53v2cCqjuDgD8vvhKJucMvTA=;
  b=F465/mg86x3u17FIOeDre2uuFORpJoPH2VVmmxSvsWBkuxc+5QKqmd+4
   Ot4ewvTPru5M/R76BRZRuAee2ks7qkJmXE9YjkVrKZeIqk6iE3VE4EbBI
   UvJKQ1Wylu7V0sXUzqlWAwIp3w9+gs8Mm838zTfr1nSModL0OnFt0UIW1
   j3YWyS6/U7vzpxmpJXqW7+ftSmBkm/dWZ8rOx5qbQUKq37KSQV9ITWfze
   hxP+wasnfVhrrWqmdKsCmtJWU0q+09MI2h7xVluJoewwf1aD1o+eg9inJ
   4IeCRsuJ0TGi8Jj3LWKkgm+T2OLaIm+aiYbR3rZge+JpZFDaSCujszJf8
   Q==;
X-CSE-ConnectionGUID: kDrLiVQXQBKnoQjyYyGyPw==
X-CSE-MsgGUID: uZ8nVQmqQ/KCwS5TOogaPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="45915034"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="45915034"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:19 -0800
X-CSE-ConnectionGUID: S9u191tFRr+fnqDUvzteCw==
X-CSE-MsgGUID: MCPepnbHS6+l6ZF4HdXALw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="123138395"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:38:18 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 wireless 5/5] wifi: cfg80211: cancel wiphy_work before freeing wiphy
Date: Thu,  6 Mar 2025 12:37:59 +0200
Message-Id: <20250306123626.efd1d19f6e07.I48229f96f4067ef73f5b87302335e2fd750136c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
References: <20250306103759.4102293-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

A wiphy_work can be queued from the moment the wiphy is allocated and
initialized (i.e. wiphy_new_nm). When a wiphy_work is queued, the
rdev::wiphy_work is getting queued.

If wiphy_free is called before the rdev::wiphy_work had a chance to run,
the wiphy memory will be freed, and then when it eventally gets to run
it'll use invalid memory.

Fix this by canceling the work before freeing the wiphy.

Fixes: a3ee4dc84c4e ("wifi: cfg80211: add a work abstraction with special semantics")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 12b780de8779..828e29872633 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1191,6 +1191,13 @@ void cfg80211_dev_free(struct cfg80211_registered_device *rdev)
 {
 	struct cfg80211_internal_bss *scan, *tmp;
 	struct cfg80211_beacon_registration *reg, *treg;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rdev->wiphy_work_lock, flags);
+	WARN_ON(!list_empty(&rdev->wiphy_work_list));
+	spin_unlock_irqrestore(&rdev->wiphy_work_lock, flags);
+	cancel_work_sync(&rdev->wiphy_work);
+
 	rfkill_destroy(rdev->wiphy.rfkill);
 	list_for_each_entry_safe(reg, treg, &rdev->beacon_registrations, list) {
 		list_del(&reg->list);
-- 
2.34.1


