Return-Path: <linux-wireless+bounces-18451-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D7DA278DA
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA51616591E
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 17:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908FB2165F8;
	Tue,  4 Feb 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUrJAwkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D854721764D
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738691012; cv=none; b=IU9fQBlteSY1bUxYb4qt3avavvyIprpom5Nu901x2m62BC6QmcgoUco/I/Ofe05hdjrN5VKwGNkV0T433O+NDtL1J6D8veYxqe1thXayQG7X9cGpa8s8RVnfL0dpXf1Snfr8cGw6jmMae26GJyYu+hoX3dmpR6indItlVs8phBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738691012; c=relaxed/simple;
	bh=tWcKNkQtV6gb6t+GYMrMWLmuHpPnPcV9o3ixTq7lzIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H2qXSevVSorRuVcBh8RF3QvKaXlTkuR7P8g4kAvptsSi2AN/7lO4EtTcHymj7mrWy2ELb2vncMSxDszvJTh6vfHVVRr8wjnuoKmuucFMqBY9Zxg2/lbHZcs+EqruzwoX2ftUt5Tg/CM20YRt6omPS36gHnJKvygUEJuQK6wR0RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUrJAwkd; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738691011; x=1770227011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tWcKNkQtV6gb6t+GYMrMWLmuHpPnPcV9o3ixTq7lzIw=;
  b=TUrJAwkdpTdsjHlfSCG3OsVMYq/8LrAAYFZ4AjMrApnVMkzd1rAHOrJf
   fX0qh+d1L7SQjxAnGh90hwwlKOyF1maWjAvHY8Q19QSeTSQB5TjpnfgyO
   peQangYgM0SHin0s+XFiqwUOpSmFvrUIxg+YeyiQ1yNh6d/L1XKv1lQqm
   AD/ZbINzxxj+6rtnwG7v9rR/GWU8UMM3/fDOan2LwvvtWclkbApQkSk1d
   r+T6hI5Vm0sR4H1UTAVemdk7ZlWPTligu4PwZVPQ3fg/grGgryzthiBid
   h4pZkfC4fLn3KTRgdgOxNZTaBdFkYeCv6STCzltHkyq0vkD6dWHUf0e9e
   A==;
X-CSE-ConnectionGUID: yK0fXN/8QNuN70NyGhYrwg==
X-CSE-MsgGUID: gq0YUaRhRXW9CCnhBuqUyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="64585439"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="64585439"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:55 -0800
X-CSE-ConnectionGUID: 4ihI9afsSRabzqgIo0H6RA==
X-CSE-MsgGUID: QYl5f5XeSYyt8ZI4wuQQkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="115696800"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 09:42:54 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 13/20] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Tue,  4 Feb 2025 19:42:10 +0200
Message-Id: <20250204193721.5be7863a2ed3.Id8ef8835b7e6da3bf913c76f77d201017dc8a3c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
References: <20250204174217.1161638-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In the original commit 15fae3410f1d ("mac80211: notify driver on
mgd TX completion") I evidently made a mistake and placed the
call in the "associated" if, rather than the "assoc_data". Later
I noticed the missing call and placed it in commit c042600c17d8
("wifi: mac80211: adding missing drv_mgd_complete_tx() call"),
but didn't remove the wrong one. Remove it now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 8879f82878b4..c2bb78002a4e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9752,7 +9752,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.34.1


