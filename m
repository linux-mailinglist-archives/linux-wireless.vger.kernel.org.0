Return-Path: <linux-wireless+bounces-4851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5787EE11
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B24EF2839B0
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1255C0B;
	Mon, 18 Mar 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R20yC2bW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D2C55C06
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780843; cv=none; b=Q7NDX2kUCjXXzyPXwfLebvs/hqjG9VlUyX+P/XPtMvjrWCiZsEEfXM+mPhndNaBabT8Nnwxys3OslaIvaGx1CaMbRxWnu3ceuJeNODYIWQtBS0DVzXr6ZfJBQZZt/ojBDRSRGI9bPEGUvBKcoNulkBPdbMCbOi0Gco2uduVl9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780843; c=relaxed/simple;
	bh=6fLWjM6GV1ndCKdjsQVlUtUxMeWVQxlH7pwnSZ6u8Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uX/zt1H6mUZk60cwv59bMjirPWE5Nzfn5A3tTlLiYNU/88x5sHDfc5zM2TKDfodRwYZidNEDmMLvGKfUKaK0NP1Xyozxl4X0PmWAKkqIg25Td0L+NFOyqg2bERv/VOBDIbMVS0Dc0cez/zN/W2ePev8+DJhXOL4sNQ87hfCLZPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R20yC2bW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710780842; x=1742316842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6fLWjM6GV1ndCKdjsQVlUtUxMeWVQxlH7pwnSZ6u8Z8=;
  b=R20yC2bWReV3BsAk1Clqx+O83kqhKNEZfw30fTVUrRxsDFjKZk04clhA
   6FzxImWlnCEa/5/nq1HvCzhJRqhrNxI6etSpRh16Og1yr+zQ65M8/UK/L
   SuIYguOoi2ZtrJ9ijPC+mwNoT6z9dG+AG8b5vB4tfsEuBc7F7Fz4ihXNT
   wyggzJwqJ6N5YYBeGBwHYOknJ2eAnJTmOgxgvMh+o4233fjcqlOxI+wv7
   xbxvAH2pIPLaZYs+3UwIBytXZuOJBzDMKJlbktWY7ICzih11F8e6G75+M
   2v+RU4P1FvqzZ8YgBUH76vKVHLGWso/g6R2COH9aRWQBifaZK4H3iKQp3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5819423"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5819423"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="13909863"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 09:54:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: [PATCH 08/15] wifi: cfg80211: handle indoor AFC/LPI AP in probe response and beacon
Date: Mon, 18 Mar 2024 18:53:24 +0200
Message-Id: <20240318184907.091cfaaa5f45.I23cfa1104a16fd4eb9751b3d0d7b158db4ff3ecd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
References: <20240318165331.3170594-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Mark Indoor LPI and Indoor AFC power types as valid based on channel flags.
While on it, added default case.

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 5a5dd3ce497f..b55ffe73e1ef 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2140,11 +2140,15 @@ static bool cfg80211_6ghz_power_type_valid(const u8 *ie, size_t ielen,
 		switch (u8_get_bits(he_6ghz_oper->control,
 				    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
 		case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+		case IEEE80211_6GHZ_CTRL_REG_INDOOR_LPI_AP:
 			return true;
 		case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+		case IEEE80211_6GHZ_CTRL_REG_INDOOR_SP_AP:
 			return !(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT);
 		case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
 			return !(flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT);
+		default:
+			return false;
 		}
 	}
 	return false;
-- 
2.34.1


