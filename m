Return-Path: <linux-wireless+bounces-23879-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43535AD25B0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD551891450
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF4921D59F;
	Mon,  9 Jun 2025 18:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICGiWE7K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D89021D583
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494151; cv=none; b=RtJcBxURIVxYrd2YOhj1c3t5G3YP5lUBAd2EfIxhwFXOOY68X3rYeVCfmUibUAkTGBfadtRXU0TnpV0kA5Rf2/lC3FdxucUmSPEyj4vaQ58c4Q8wY8uK5XfvuyeRab1Zy/IU0QyWQM/Et1u42svxqYEQOj02EaJB702Xugbv6rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494151; c=relaxed/simple;
	bh=GQeitgW0gmYcN6PRt5b5iBGmC1PxE4/kZ3aDaD4++uM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GNwGnyOb0GoojRkprZym8MJ/uCqUpnHP9W3Ghv9vrrAqyc5J8JPhNMMQ2pfCISM6g038WCYyPd6ARVmOEiHm3vzmZKRcsqSjQAfZhR/iC8KDH7z8trupfM8lImugYADQoe+Py1l823zcsUAFOU4+ttebT0fQZJhVb9LUfcg6e5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICGiWE7K; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494149; x=1781030149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GQeitgW0gmYcN6PRt5b5iBGmC1PxE4/kZ3aDaD4++uM=;
  b=ICGiWE7KSEIylO0KoZNT9ZRa0fBMtyUDO1QRSywClZtZx3/sSuGmOlbx
   /Kp+T7WGQ5mI9jBhCq2Ej+hiAgOuELZXX0shXFSGHIdaewhCGj67LgFqc
   J1X1O3iH4gRFI50vroN7G1hJALkvWM9V/3c5C+L4ec5dTdDZWlAjtIP+b
   tu6todsmJIv/J9aWxW0Dg2bBO4HTc35yr50kUXpDDli9uHYwvve07SJNT
   KIJM3pwGRfMqkFP8sea1sspVqhyazhNnHntCMw56fiB3B2Pdgl9/XSUov
   sdsVvjNXmsq20xuUw4YQV8hqowiW/bxCHrSPXryHW9SGfdGjBXkqOVrut
   g==;
X-CSE-ConnectionGUID: hVmbYvE0StuWrjEURbvifA==
X-CSE-MsgGUID: fnGQu6uLQ/6CTffKK7aQuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249757"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249757"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:49 -0700
X-CSE-ConnectionGUID: dVPUme1nRKqgSQTmH37tew==
X-CSE-MsgGUID: y6+M0nMgRtWpf5bc2vObgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732468"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 04/15] wifi: mac80211: remove spurious blank line
Date: Mon,  9 Jun 2025 21:35:16 +0300
Message-Id: <20250609213231.a1f4ceae700d.I1d7aae17cc466c1648f31c42b935165db85d2809@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

ieee80211_process_ml_reconf_resp() has a blank line between
an if statement and the covered code, remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c8bf810ff5d8..6d6ec1e15001 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10035,7 +10035,6 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		if (!add_links_data->link[link_id].bss ||
 		    !(sdata->u.mgd.reconf.added_links & BIT(link_id)))
-
 			continue;
 
 		valid_links |= BIT(link_id);
-- 
2.34.1


