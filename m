Return-Path: <linux-wireless+bounces-26968-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF923B418C1
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 10:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1F93B4024
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B8F2EBDFB;
	Wed,  3 Sep 2025 08:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FuWuCqQz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17F2D7DF1
	for <linux-wireless@vger.kernel.org>; Wed,  3 Sep 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888775; cv=none; b=YRD7I2IFkdNjDhMqLeg63iUItzT0eWSRXdgbHXCl1RFde2D5cuqeg0v0DidARcxPFLsct7mhzo72kqL+yGJkknsAjYtcZ+CX+WYgMPereqlgCodR2pXysUmbtfcPSly3GtBU/lDxKR6tKOfGnZn9OpyMDChPFLl7UYVI18b6bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888775; c=relaxed/simple;
	bh=dbUueDoEmA3LPn+RMpkG6Uy5yR2Hd0qCrWuhDva1ZSc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L/q+OUo3bXanBid1UR9KOqDPDiFM/ewPSbO9Zbhoa3UqHwT2HtPxuRBHW11PsSR00skDRyDpKlmGex+z21U1C9FZTPNk7RQk09EMI8WdYiBmnQ0jul74na+U8LvhFNAel7xhDvtk3LmE3IlYZVWFS4ncqgI6lVAJIhYr062lYsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FuWuCqQz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756888774; x=1788424774;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=dbUueDoEmA3LPn+RMpkG6Uy5yR2Hd0qCrWuhDva1ZSc=;
  b=FuWuCqQzxdWbQu2rd+adPj9R1rl2HhxkaImTqhyQxjmLDMGme/g9rCW5
   dUOxAxmIxcUECNHVAE+U9Zw0b8yAB2NGrFGeDkEE+sF+OxwcWDFVLBsmo
   SwBl6HWMi1RQ0AM4QPXKly4oufGGo4euQejQlMRQCYq70oLsW/vpJbBxa
   eS/5jIF/Sy2QlE794yDwvmGQOd/5Ikb4/PW1X1jDyFq7QQ1SRjI0pL91p
   ao2ZDQewsQsxRfyWKHpFXwjNI3lsNlAAtjmWlxyQrmYICDF/BMEoXQp16
   R7jOMlCk9NGDsN8r7h/mPdfRdnBvnfHurNcsR3fxmijDl1L/oqrSDAIok
   A==;
X-CSE-ConnectionGUID: QY63EENkT5+0oWtpT5hOrw==
X-CSE-MsgGUID: mO3bq1dJRQyXnd4AxOIBvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63028823"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63028823"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:39:33 -0700
X-CSE-ConnectionGUID: uAzU1cmLSGGazAVGO9p2CQ==
X-CSE-MsgGUID: AQmXsEtcSu+grpSKzVlM6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; 
   d="scan'208";a="175896592"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 01:39:32 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 1/2] wifi: mac80211: reduce the scope of link_id
Date: Wed,  3 Sep 2025 11:39:03 +0300
Message-Id: <20250903083904.1972284-2-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
References: <20250903083904.1972284-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Reduce the scope of the link_id variable in sta_set_sinfo to the 'if'
scope.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/sta_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 8c550aab9bdc..8e275f0a1238 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2962,7 +2962,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 	u32 thr = 0;
-	int i, ac, cpu, link_id;
+	int i, ac, cpu;
 	struct ieee80211_sta_rx_stats *last_rxstats;
 
 	last_rxstats = sta_get_last_rx_stats(sta, -1);
@@ -3204,6 +3204,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 	if (sta->sta.valid_links) {
 		struct ieee80211_link_data *link;
 		struct link_sta_info *link_sta;
+		int link_id;
 
 		ether_addr_copy(sinfo->mld_addr, sta->addr);
 		for_each_valid_link(sinfo, link_id) {
-- 
2.34.1


