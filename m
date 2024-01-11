Return-Path: <linux-wireless+bounces-1732-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B655082B2C3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 17:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD0461C232DF
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD09755C31;
	Thu, 11 Jan 2024 16:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR5dz+4H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A42E55C2A
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704989921; x=1736525921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UOHWsntpoU9zApr29jEX5Dksh8ill5Tk3Aoh3z093A8=;
  b=GR5dz+4HSQ/uQyrtfr5qHrZ/5K+FukCWSkOewu2YO1EZiHsXe64ICxNx
   8ekgFRJ8Q44Le4o2uYS5eNaD6qqWKHxFzv5xpO7OW9IKY1oj/xT2A+gHa
   4xEK6MKjXfw26nuRVm45ja+SjJ6qIseywFakIVp1qNYUk+GeIE+JfmwPO
   9xO5jN9vwCywTcz2pcyYcDGM4xejFVdsKR294aGPEwO7pwOmATS3BO4Aj
   xIFvQvr0ngkoG8V/DTt7C+JDJNOwCiFM9NaCyl+S4KJXiJIoV4xbDn5rp
   JFabWusY7Bx/ByNckm5Z+qwz/7IMLlzKAlfqirwwGru+IlvRw96YyBv+9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="463182610"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="463182610"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="1029606725"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="1029606725"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 08:18:38 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 6/8] wifi: mac80211: fix potential sta-link leak
Date: Thu, 11 Jan 2024 18:17:44 +0200
Message-Id: <20240111181514.6573998beaf8.I09ac2e1d41c80f82a5a616b8bd1d9d8dd709a6a6@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
References: <20240111161746.3978601-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

When a station is allocated, links are added but not
set to valid yet (e.g. during connection to an AP MLD),
we might remove the station without ever marking links
valid, and leak them. Fix that.

Fixes: cb71f1d136a6 ("wifi: mac80211: add sta link addition/removal")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/sta_info.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index bf1adcd96b41..92a7ba7c9c9d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -404,7 +404,10 @@ void sta_info_free(struct ieee80211_local *local, struct sta_info *sta)
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sta->link); i++) {
-		if (!(sta->sta.valid_links & BIT(i)))
+		struct link_sta_info *link_sta;
+
+		link_sta = rcu_access_pointer(sta->link[i]);
+		if (!link_sta)
 			continue;
 
 		sta_remove_link(sta, i, false);
-- 
2.34.1


