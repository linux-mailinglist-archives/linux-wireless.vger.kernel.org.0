Return-Path: <linux-wireless+bounces-18505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6781A286D9
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 10:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BB33A8512
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 09:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A6922ACF7;
	Wed,  5 Feb 2025 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GUp0CvdT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901B922A80A
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738748405; cv=none; b=QHrZBzp68eLjQ23vrV44uy/upIOwc/dY0jVas/Ev39sCroaVOFDtuGA0//g8d07CB9BcyCqhWCrKE7qtk70bFRn05TNqLSmghYbkob2jJyOuZ1CzjfyO9KBbUmelLgLXgFzhFZcGrrwbWAbTsMTOlrEQdCF3HteqHGf/KPUP/Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738748405; c=relaxed/simple;
	bh=YcewaombO7iw8sjsLmgO/SoTzjA7g+wkj0iH7gHRkic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bs0IUIJ2ZV8VJPzy2BKXOgXKuutz2Ze8MqWZUuE8/wsBac32uQuuwIDAsiXHILc2SgeXKgIfhWBdNFy3Xl2dLMl/8QrrOToLX1OJ+Hw0pfFdN1YEgnmBunARlYFjxvYhAKUOtGaRXQL+1pl9sJqPAW7r3OeAE1Dxm/gMhXDC7hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GUp0CvdT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738748403; x=1770284403;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YcewaombO7iw8sjsLmgO/SoTzjA7g+wkj0iH7gHRkic=;
  b=GUp0CvdTdA+bnZ/aa7B94W/H6eDuYVvLr+0h2Mju18I2WYsHQUSi7qbd
   T9LnqelFEMs3pAku5CZxpcPBAhHg08h8nidF4j2ENT7SZ73e8cWUguO9x
   8QEVgNWDH9VQBa6OU4c+fnOPAh50kQ7agaFvq/mqGZc70jSPv1fUcp6jo
   RJve1+8Uk3/gyDMj36GbD1ikvaupa9qmqPDRZZ2oyJPRb3asLwuhSh6NQ
   sfC5Cvoisv7XGc0neNWP1qTBV3JKACeSG2rBrmh34QzOfFVkABIa1Ao0b
   dRIRiiDr41zD3BxfcOUtTBGIed3fFfRBmSApFXCC08jgF4r5i3F2XrMPF
   Q==;
X-CSE-ConnectionGUID: z18CbJekTGuevqusUBHlWw==
X-CSE-MsgGUID: /VB1tC2tQVOW0WqUCckJ9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43225243"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="43225243"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:03 -0800
X-CSE-ConnectionGUID: 7qOJnfr9SNKxT6kMEoEwCQ==
X-CSE-MsgGUID: 13+qP9bBQ16u9SCafXGFhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="115845308"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 01:40:00 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 11/17] wifi: mac80211: remove misplaced drv_mgd_complete_tx() call
Date: Wed,  5 Feb 2025 11:39:21 +0200
Message-Id: <20250205110958.6ed954179bbf.Id8ef8835b7e6da3bf913c76f77d201017dc8a3c9@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
References: <20250205093927.1775858-1-miriam.rachel.korenblit@intel.com>
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
index 184b328d92cb..bb3e42afd34e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -9751,7 +9751,6 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
-		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.34.1


