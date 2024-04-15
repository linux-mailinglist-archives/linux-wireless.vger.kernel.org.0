Return-Path: <linux-wireless+bounces-6305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885298A4A4E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 10:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17859B23C96
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020F381BE;
	Mon, 15 Apr 2024 08:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM8Gu7jE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E95376E7
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 08:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713169654; cv=none; b=Ur+ETRqdqUwCPXEcj+EEIz8smsk0/912k3bcxFmQgbhbKWWbXDHcKTTFl6n61InY8KHXC/vsRm+pndXb7+I/4Rb8un5uAz8PSUJdavAp+wQG493982ltlyqfpr5m31h/BF3gOmuJeoCX5n0dvYqZBfCAEw/Uv23DrJcuD7LHtc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713169654; c=relaxed/simple;
	bh=ew1RbLFTU0+AZV9E5Rnzod+YD3LIJuhMEd8isCcMhx4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ApLXGkfYtWTQ3eMIjrFQtIs/ksRrTFr434GK6juYQj+D20rkCoKUlsWczgvnLm/YL9e72R3L2UbYIJIx8dUh8A6YeDKL+BL49jktXRDo9lsmVgJEx/tc47aiaGeHpBG5yd8nZVdQNnZLH+B99/sEEtGkshfjUwPoGB6JfSGFwdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM8Gu7jE; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713169653; x=1744705653;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ew1RbLFTU0+AZV9E5Rnzod+YD3LIJuhMEd8isCcMhx4=;
  b=VM8Gu7jEjZvrsDrUm53chnD2sozxkRfUTiWQzJK8LPGOTZs7/wUW6Wgz
   ZoRBcEH+AdauNrG8lvqKP/Wrh06S1y0TZ31CMtLjejcwmv1nLC30a9rUp
   95e8afB6qo6PYmrwpLX1gwW9mRD9OZnXRVfjcaFAeFWVCUBphrmQuRSGO
   stJPmr93M9BxxnbpdY0yghp3m9cMujJGdyRbDUk/0272Mz+qyWgNFT6Ls
   waHKZztaW8CAb7uB8CPsJuTHy3Ct49nwDXVadEODqh2By2SmMBG9ItyXK
   /YBppYYd5/FEUg3UbQgDVe2sYONj9OkHn4aDt7kLRJSkJb/W3jI6T4U6B
   w==;
X-CSE-ConnectionGUID: gSm+FcSWSmSwTLZLfwn94A==
X-CSE-MsgGUID: aWLkKxUgSWOc5SoUoRA9MA==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="9097277"
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="9097277"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:32 -0700
X-CSE-ConnectionGUID: Dy+K9Nt/RpG7nGiNldKaeA==
X-CSE-MsgGUID: ikPSiJIhQwSz3RIDJc7BnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,202,1708416000"; 
   d="scan'208";a="26403251"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 01:27:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 3/3] wifi: mac80211: defer link switch work in reconfig
Date: Mon, 15 Apr 2024 11:27:13 +0300
Message-Id: <20240415112355.1ef1008e3a0a.I19add3f2152dcfd55a759de97b1d09265c1cde98@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415082713.3822598-1-miriam.rachel.korenblit@intel.com>
References: <20240415082713.3822598-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

If a link switch work was queued, and then a restart happened, the
worker might be executed before the reconfig, and obviously it will fail
(the HW might not respond to updates etc.)
So, don't perform the switch if we are in reconfig, instead - do it
at the end of the reconfig.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/iface.c | 5 +++++
 net/mac80211/util.c  | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index ef6b0fc82d02..dc42902e2693 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1699,8 +1699,13 @@ static void ieee80211_activate_links_work(struct wiphy *wiphy,
 	struct ieee80211_sub_if_data *sdata =
 		container_of(work, struct ieee80211_sub_if_data,
 			     activate_links_work);
+	struct ieee80211_local *local = wiphy_priv(wiphy);
+
+	if (local->in_reconfig)
+		return;
 
 	ieee80211_set_active_links(&sdata->vif, sdata->desired_active_links);
+	sdata->desired_active_links = 0;
 }
 
 /*
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index cda398d8f60d..0b893e958959 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2106,6 +2106,13 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		if (sdata->restart_active_links)
 			ieee80211_set_active_links(&sdata->vif,
 						   sdata->restart_active_links);
+		/*
+		 * If a link switch was scheduled before the restart, and ran
+		 * before reconfig, it will do nothing, so re-schedule.
+		 */
+		if (sdata->desired_active_links)
+			wiphy_work_queue(sdata->local->hw.wiphy,
+					 &sdata->activate_links_work);
 	}
 
 	/* Reconfigure sched scan if it was interrupted by FW restart */
-- 
2.34.1


