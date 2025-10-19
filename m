Return-Path: <linux-wireless+bounces-28047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF51DBEE02D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 09:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B7BD4E6B61
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 07:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71910A1E;
	Sun, 19 Oct 2025 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7R4Tjyi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFA146A66
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760860662; cv=none; b=kRN2xVKWIaCAP31Wqf8/GWjf6onwbMa0bEukksHNr5f+KgqfWtv+XmwoC4JMaUF5oExRW/VjFRJzhSrNIiCPj6mRW4qLQGAIKbFORtFi0UczULNuHT8w/Me4rGCDvbg4ipKioVxtjmhsoJSGUQJsO5TfpxgeRJ7d5PxN3nKBDP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760860662; c=relaxed/simple;
	bh=N10+fkZVXqgT2aDbB0LdNSP5YzmGVWXQ+OcgF+ZX4Po=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CG0+9hI7pN07XTPuZ05sq7kgq6QFgcbmCzlY0ocU8xWI5nRacD1X9YCfJ2MXGpSwqNGHczlLqx8/od1brjQAMUV038PG97vpGIFbxWcRyMX4A0Ie/CwrJc+eM0JA+14Ff63E614d7A69DL+9sFq6h6liwIEMapQUbG+68CdpH1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7R4Tjyi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760860661; x=1792396661;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N10+fkZVXqgT2aDbB0LdNSP5YzmGVWXQ+OcgF+ZX4Po=;
  b=U7R4TjyiI8Nnr5hcpYDp1TOWqrLs8Es0SN1RCHJ6rOiSd1BVMCoRkmkh
   oEEqLO+zdBbeVZ4dtNbAlVAel2t1U4nEdor6nX6ObSVE86VNFtAXLbCWz
   gSpmCfgbz2DghVmuMpwLMdyImvCzb8HD8YHC6+V+4QwTN3zBamDkYHaNV
   Hwhir7sM5kFFMkeaHH1y0J4Tc7BLrmQBBHNBorsuInrNGFOBpaaZlAheZ
   WkCv2XGmAdHINDFmF9yNhpezwREI1lkagzvnTyvYAJuxBPmtIXndUYn5A
   NePrzJvd08Bjr1R0LAoiM5ihbxMXSsOZPgPIOjeRHpGMM6FOEeEqjPaWL
   A==;
X-CSE-ConnectionGUID: Z0V1EDVbTiqswv9PkNqsDQ==
X-CSE-MsgGUID: mCqn79ewS3SsykOp1QNZfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="73616940"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="73616940"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:57:40 -0700
X-CSE-ConnectionGUID: O4PcRUWYTxabiw8hTun+Og==
X-CSE-MsgGUID: i04BSAGFSZy6vUl0w3+sVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="214055622"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 00:57:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wifi: mac80211: fix key tailroom accounting leak
Date: Sun, 19 Oct 2025 10:57:29 +0300
Message-Id: <20251019105720.c88eafb4083e.I69e9d4d78a756a133668c55b5570cf15a4b0e6a4@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

For keys added by ieee80211_gtk_rekey_add(), we assume that
they're already present in the hardware and set the flag
KEY_FLAG_UPLOADED_TO_HARDWARE. However, setting this flag
needs to be paired with decrementing the tailroom needed,
which was missed.

Fixes: f52a0b408ed1 ("wifi: mac80211: mark keys as uploaded when added by the driver")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/key.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index b14e9cd9713f..d5da7ccea66e 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -508,11 +508,16 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 				ret = ieee80211_key_enable_hw_accel(new);
 		}
 	} else {
-		if (!new->local->wowlan)
+		if (!new->local->wowlan) {
 			ret = ieee80211_key_enable_hw_accel(new);
-		else if (link_id < 0 || !sdata->vif.active_links ||
-			 BIT(link_id) & sdata->vif.active_links)
+		} else if (link_id < 0 || !sdata->vif.active_links ||
+			 BIT(link_id) & sdata->vif.active_links) {
 			new->flags |= KEY_FLAG_UPLOADED_TO_HARDWARE;
+			if (!(new->conf.flags & (IEEE80211_KEY_FLAG_GENERATE_MMIC |
+						 IEEE80211_KEY_FLAG_PUT_MIC_SPACE |
+						 IEEE80211_KEY_FLAG_RESERVE_TAILROOM)))
+				decrease_tailroom_need_count(sdata, 1);
+		}
 	}
 
 	if (ret)
-- 
2.34.1


