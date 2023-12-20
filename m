Return-Path: <linux-wireless+bounces-1011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF11818E6A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F7FF1C24558
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E66381B2;
	Tue, 19 Dec 2023 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oa0Qwmh2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39554381A1
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007699; x=1734543699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KXQyt1jc1mVsBdrfXw9RuYec/PY+btKgN31FA0aoVJA=;
  b=Oa0Qwmh2GM6pUkjZbDpqLzd973vJRMKFrfcQUJhk1p9bBmUwoBvrPrtM
   K4Pak+09FddyaxQmlQCsyvmoQ6QQO4D2fF8QsNTwTPtXN2V4Y4j5IkVgd
   OPCxF12fjkUelxBRhxtTiTGblQt3y5Op9CWuUPoboQ0qkuKyI+atKK7jd
   45VrEvrMWYXrhJqKnswgs+RftELPOL7NAV0vJhhV4AxwpnDW+axglQKim
   +9K+6CHL0HFSb780uYilobhZcjt0ZZsCPBHQ3Tb1ID+07Z4MLoey5JgPx
   G1CQXQmvdDCWlptm3oNdVX3Srm1xzc5JZf+zJwX0ERjiotbiJtCX7GzXf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790525"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894370271"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894370271"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:41:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 10/13] wifi: cfg80211: avoid double free if updating BSS fails
Date: Wed, 20 Dec 2023 13:41:43 +0200
Message-Id: <20231220133549.8891edb28d51.Id09c5145363e990ff5237decd58296302e2d53c8@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

cfg80211_update_known_bss will always consume the passed IEs. As such,
cfg80211_update_assoc_bss_entry also needs to always set the pointers to
NULL so that no double free can occur.

Note that hitting this would probably require being connected to a
hidden BSS which is then doing a channel switch while also switching to
be not hidden anymore at the same time.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: Fix wrong email addresses
---
 net/wireless/scan.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f7fd7ea0e935..cf2131671eb6 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -3194,10 +3194,9 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 
 	if (new) {
 		/* to save time, update IEs for transmitting bss only */
-		if (cfg80211_update_known_bss(rdev, cbss, new, false)) {
-			new->pub.proberesp_ies = NULL;
-			new->pub.beacon_ies = NULL;
-		}
+		cfg80211_update_known_bss(rdev, cbss, new, false);
+		new->pub.proberesp_ies = NULL;
+		new->pub.beacon_ies = NULL;
 
 		list_for_each_entry_safe(nontrans_bss, tmp,
 					 &new->pub.nontrans_list,
-- 
2.34.1


