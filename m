Return-Path: <linux-wireless+bounces-30639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DE3D0F221
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 15:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAB26302EF7A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Jan 2026 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D24348899;
	Sun, 11 Jan 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3VVDybp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0468348466
	for <linux-wireless@vger.kernel.org>; Sun, 11 Jan 2026 14:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142182; cv=none; b=QkYxg/AkhF1cKywiTlLRdlMj1J0MXygsd5uKpbBWkpqQNPYHQjuW8UWAtW8dZ7k+nmoF4v9qq5DjVlKyFZZr16XtqgAVUVKRQbbr0MOvSyKgzrjw7jmKvvmH8dMd/BckPNXfYCUirB/m4kUXkxI1f01hj/4pwG9O8nvCTgt+EZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142182; c=relaxed/simple;
	bh=WMSGNDZlnu3b4NvEiWEMNSMywaTAxeJUD7DD2xgwEm8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FKWMEU/21n/TqHe1vwHGhBcnxo/WjMlZ0KhSiqIUPHBotyKTxilVfRscRs2D6jz0pulQbBHRV7CrClJlL3gDzCUjVt3sapcPW/aw6l3yFP1d4xZ1AgcraczFV0lxR2LU9bSNFm7EPL1S6h67eCS8PvIaWietjQkYFpGcp80mMzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3VVDybp; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768142179; x=1799678179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WMSGNDZlnu3b4NvEiWEMNSMywaTAxeJUD7DD2xgwEm8=;
  b=V3VVDybp7AUian9cQG8Jw4P04VCTjwtQlOREkYNRFN12G/rdARf2yuw4
   01J/l1uAFBgcGyYY3F4af3JqlossQdCDH0HL6hFdzRhsFno94Ptr0nmpl
   2RppBBlAZX5/et2bymysuL8pY693+0eknHneXn+z67d1icKQkL6JY0wx8
   f3/7UAACHFCPQjcf09UVqZq11Ge/cnzAbE8TkArBO/imPWeC85Us7r0YY
   HKf04KNgE1DRE8c5Sm61xPSWUo6B6Oiy3grG2onkQos9hqmnsCZSJp0Bw
   DzfQNhOCjPgmh1jYCdO419Y7wB8BWwGNBQGtJGbXcQqhgZpXemmJIpb9b
   A==;
X-CSE-ConnectionGUID: EnNeoRYYQfuiyIMp/ClyoQ==
X-CSE-MsgGUID: ye+I9rkXTDq2FVf3+9v96g==
X-IronPort-AV: E=McAfee;i="6800,10657,11668"; a="73071760"
X-IronPort-AV: E=Sophos;i="6.21,218,1763452800"; 
   d="scan'208";a="73071760"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 06:36:18 -0800
X-CSE-ConnectionGUID: V72FM9DwQRC6LtiAv3eI2g==
X-CSE-MsgGUID: rf5Rl6QOTRqIrVkPovxNbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,218,1763452800"; 
   d="scan'208";a="203894044"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2026 06:36:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: treat deprecated INDOOR_SP_AP_OLD control value as LPI mode
Date: Sun, 11 Jan 2026 16:36:08 +0200
Message-Id: <20260111163601.6b5a36d3601e.I1704ee575fd25edb0d56f48a0a3169b44ef72ad0@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Although value 4 (INDOOR_SP_AP_OLD) is deprecated in IEEE standards,
existing APs may still use this control value. Since this value is
based on the old specification, we cannot trust such APs implement
proper power controls.
Therefore, move IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD case
from SP_AP to LPI_AP power type handling to prevent potential
power limit violations.

Signed-off-by: Pagadala Yesu Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cbccedf32228..126d3cf97eba 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -10168,9 +10168,9 @@ cfg80211_6ghz_power_type(u8 control, u32 client_flags)
 	case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
 	case IEEE80211_6GHZ_CTRL_REG_AP_ROLE_NOT_RELEVANT:
+	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_LPI_AP;
 	case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-	case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP_OLD:
 		return IEEE80211_REG_SP_AP;
 	case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 		return IEEE80211_REG_VLP_AP;
-- 
2.34.1


