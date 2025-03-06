Return-Path: <linux-wireless+bounces-19860-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7528CA54793
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A490171BAB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3AC202F9A;
	Thu,  6 Mar 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSpK8AoT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AACA1EA7C5
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741256333; cv=none; b=ewAjDyxtVhuuFaGIzUr/NKJYNY+yoHA6p2MG2xtHfMiZoR1/el3HVR7RdaDuQqo4M9qWOu7DhgNfRbAS6N6wR+alZJQKTR7q2XeXUQGg948KZdhRW/WnkOk9nsLBBwY06Jp1IL8DO6kGE9Ckan0qJWvSVmY4utGdBeG4EW3VAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741256333; c=relaxed/simple;
	bh=ZYNfFyPn/uv9iaTmv1j53v2cCqjuDgD8vvhKJucMvTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zl+DCthYE9X1L3m//S0ah+yv5cfO5aLwJO/oiSE3jfsXfAt41lCHP4LXfHvHh/0l5eYht1jafGeg5duI5mx79YfwEoXYHUWyAKIE065wfuw4DQ2EQxMKStPoujQmnCayzD/jozQZnVfFufGwSx7fKcGAEGlLREgPPLw2vrQJGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VSpK8AoT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741256333; x=1772792333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZYNfFyPn/uv9iaTmv1j53v2cCqjuDgD8vvhKJucMvTA=;
  b=VSpK8AoTlJ/uQiSVOXG/6/wWG9JfyapTPYJLrtlFAsoFUjNj73bqwq8w
   qGDIKtYX60wuLUVEHWXH9I6xQM/1iK68vcnFpYiUed+Hi1LRjClqWO3Z4
   2BvUsrS5aDv1CnFsPsAGmUHIfxJ8tBJTq+UgIdtIEdjR0n8ggsGMJsXMY
   TSBhnN9Pd3KkRoaOoUjfEMjR0Fc0gEv9o7hGGxvz4EBPULNCbEn+0Hjhw
   wYkkNZAIEj9PVCP1WHfQ5rjyPuOpP3/uz2RBo+Zlos5fCIQR5MMTNwmf1
   kgqHF2QHy5OzO+OMCQ2XiW4jVr8Io7gI4tJNcGYA+zXFqhBwzzTEsCh09
   w==;
X-CSE-ConnectionGUID: P9nVbAmUScOMMMkRyAML0Q==
X-CSE-MsgGUID: qk2Ygc80SUuJ5cJLFdOoDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="46181384"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="46181384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:53 -0800
X-CSE-ConnectionGUID: k5/LcENdRhGL1MLbBfMp0w==
X-CSE-MsgGUID: b7wCvAsETNqMJlFvZxSDNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118705731"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:18:51 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/5] wifi: cfg80211: cancel wiphy_work before freeing wiphy
Date: Thu,  6 Mar 2025 12:18:31 +0200
Message-Id: <20250306121409.efd1d19f6e07.I48229f96f4067ef73f5b87302335e2fd750136c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
References: <20250306101831.4042303-1-miriam.rachel.korenblit@intel.com>
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


