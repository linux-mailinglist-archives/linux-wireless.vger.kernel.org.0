Return-Path: <linux-wireless+bounces-19887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718EA5483A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6010F17240D
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1A02040BE;
	Thu,  6 Mar 2025 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YZHN5cIP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109AF20B1E2
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741257838; cv=none; b=PjqJYITkPJYV6C7N80MgdX70xaV7tP7XioSiUtvFdowEpXyfv0AxUe+qmIWef42tEShsTbU9f5kOkhCgWaWgDCL5wK/jqfA3586YiRCQkKX710nVultM8Qd0uU2+CWfroiLGWVs2/lyW0z6iE0qoYVTafHEYUpuGMoYOIWLVHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741257838; c=relaxed/simple;
	bh=gsIIy478v8/6nY9cvDyZuNEbjerd5nropVjWreVv+qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6aI3Gg51Rhx4nYtoOfjvrfYEArjUVbpWVK4mz5s709BJCBTRkFrA19HOeu2/ZOk05Bx+CkSsrO8UXvqkQV1pzJP5evNU91FV1KkFF9qLnwqP7jO6LeSahXgjz/5CtpO2pnoTm/qpaNXpElkmxrXArJOi1h/Qbt/VBr+tkJmByE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YZHN5cIP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741257837; x=1772793837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gsIIy478v8/6nY9cvDyZuNEbjerd5nropVjWreVv+qI=;
  b=YZHN5cIPyuHU+WxxKg7qTdo8/bxgjDCpGiCaRVAPDD197H5Uk1hlvx27
   QYuTsAN8TN6uwR+kkgJjCxKwA4/903x+0zD6qElBuXhvvFsx5A4/7lSmd
   2JQm1cH1gbr7wpcVRj4ryjsVTwt2u9uG8DNc84lq/RTY6xoHzSk+3ZGju
   U9P38PmFEyHpHo99DSB3Ml+xj4IOeTnXA2DLKrEXlvtADsPYtbSos3TVG
   eQKI4xQqyV6rxVaDTnimnuuzJwDrxKenOckYnaKUcke+wgszaYQhoOlKK
   56mwBFxEsLLEkvHqLyCwjyTjTWAdchCwoTjQkC+7Rza5OqJ5GiWPIv5DK
   A==;
X-CSE-ConnectionGUID: DnSHaI/jSo6Z7AflAEJLrQ==
X-CSE-MsgGUID: e3h2Q+ZOSlKjenuPsWeKlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="29844513"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="29844513"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:57 -0800
X-CSE-ConnectionGUID: froFF3XWRZqEV4URd5UnLA==
X-CSE-MsgGUID: bH6caF1iTTuQpotNAQYs6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118797777"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 02:43:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 12/15] wifi: mac80211: Notify cfg80211 about added link addresses
Date: Thu,  6 Mar 2025 12:43:23 +0200
Message-Id: <20250306124057.f686a1690c92.I2aa16801f07321a580dd7dce4a074a3486f627f1@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
References: <20250306104326.4105722-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When ML reconfiguration is done and new links are added, update
cfg80211 with the addresses of the newly added links.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index f3bf66d4ce6a..60a585caa96d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10135,8 +10135,11 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	done_data.len = orig_len;
 	done_data.added_links = link_mask;
 
-	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++)
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		done_data.links[link_id].bss = add_links_data->link[link_id].bss;
+		done_data.links[link_id].addr =
+			add_links_data->link[link_id].addr;
+	}
 
 	cfg80211_mlo_reconf_add_done(sdata->dev, &done_data);
 	kfree(sdata->u.mgd.reconf.add_links_data);
-- 
2.34.1


