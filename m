Return-Path: <linux-wireless+bounces-30440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E98AECFD980
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 913783013ED4
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0EF2E6CDF;
	Wed,  7 Jan 2026 12:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duuDrysm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872C0258ECA
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788167; cv=none; b=qIY3f824/PD4JHjzeoyCeiaKHUITg93N33/bcAVvi9sRAV5/sW5OBanvOVFpxzT4WQG9uRmyHCFty04Ruap1aDufddvwEakxL7nEjMRb/SNQeZx6CRhuDt7hbqvCrrGCotlAbzaoOSdnhbu8rGIXXAAxa2KQ60yfOD5plQ3qz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788167; c=relaxed/simple;
	bh=dZbc0ye3zijikw4SAKktxsWn8w4oMM74ooP5BjklD7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDgcAKUCRllaIbeuKUaihS1cNoxXdNSzFKVfrCoVLJsb+7o1gNoJoRsWmHTrLyI4RiECrXYKZ19J7Z1Zv9PyvUErFnKiIqeP8+8BQj23yS96fC0SN0c0VVhr7cNfgNZ8gIAAofOfFPDmPdIGurPxeySxpcUr0hBa8LpoRur548w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duuDrysm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767788167; x=1799324167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dZbc0ye3zijikw4SAKktxsWn8w4oMM74ooP5BjklD7Y=;
  b=duuDrysmGOp+cm/OC7eoZgEvYapQTDYbK8hcpBFDeQ7PhlEYgoo8QIFy
   mGaoR7TDqw8oQqFoxr4Fxtl6PX5ESIElgmNOXCoMgU1gTK0GT+Pjsz3ZD
   Zevs+c/giEVcBkc79kZHoB8KpW+Jy48mbwmyz+1Ph5zGBOsHFNd0iyOTC
   4eFzZWokOaSQDbhgZ/wra4FhWh99yTt2UKro9/fzJplzM6X8z+trBVo10
   Hhzu5DwgokX0w3ILEODJF+aUsZgAPR3wzgxaLYBpw2AaCUmiGdV1dV4jz
   eRaMfC+4H/RuW/NP0pcM/DbdVn3q8QI7p+8YQRjgGIX3CYIHreTuzoC6q
   A==;
X-CSE-ConnectionGUID: uW13w8cpQhiiSJGc1rquuQ==
X-CSE-MsgGUID: XcknLVuGR8Ocek4DeQbZWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69205859"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69205859"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:16:06 -0800
X-CSE-ConnectionGUID: W+6izmxFRxGRzCIHKZjOLw==
X-CSE-MsgGUID: qbUR8xA8S96xbqZxQ8sf9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="202677823"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:16:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: limit NAN func management APIs to offloaded DE
Date: Wed,  7 Jan 2026 14:15:56 +0200
Message-Id: <20260107141549.86fa96c75211.I8fbb0506377170dd7b41234f20bcba057951dd1e@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

A driver that declared that it has userspace DE should not call NAN func
related APIs such as cfg80211_nan_match and cfg80211_nan_func_terminated
Check and warn in such a case, as this indicates a driver bug.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/nl80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index c961cd42a832..26c1b0caf3af 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16106,6 +16106,9 @@ void cfg80211_nan_match(struct wireless_dev *wdev,
 	struct sk_buff *msg;
 	void *hdr;
 
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
 	if (WARN_ON(!match->inst_id || !match->peer_inst_id || !match->addr))
 		return;
 
@@ -16188,6 +16191,9 @@ void cfg80211_nan_func_terminated(struct wireless_dev *wdev,
 	struct nlattr *func_attr;
 	void *hdr;
 
+	if (WARN_ON(wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE))
+		return;
+
 	if (WARN_ON(!inst_id))
 		return;
 
-- 
2.34.1


