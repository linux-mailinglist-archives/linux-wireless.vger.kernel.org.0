Return-Path: <linux-wireless+bounces-23881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AA3AD25B2
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C32189143C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5A21D5BA;
	Mon,  9 Jun 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSxE84sd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EDE21D5B6
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494153; cv=none; b=sH6ns7apDS2Mjyx7edBmbNpXoIV5AZCLMhqeBNkShVAS7h4tObIRDSTuSWzGbhqjonyB1+ojWVndFZOFDf3AmGU/kH0rjxjvoVfYnS8c6LAzjIN2tQv/ABoG96uo/DjjuEztBI4zFEuqVPYpBCRwQYyBqKA+pwzIqh0rW7K9CjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494153; c=relaxed/simple;
	bh=ZttONvGURv6EvI4wo5RX5uQzeZ6w2iyXQUfcIMinqdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mx8+8R+8nfQFEhHdgfsgM1i6+J7TAZD55eP+RMqtt0tM8dLS/NsENLijbQOeVPbE8LUpeiajFIIN9Y0AOBbNAT+TeOZcBYqIoWgtN3uoRZBA8lwP0ZrG1apUIn6+lGocrQRSSPbSOkmSRcC4JxvRnOcJfvI9xKyfe0lVwDHl7KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSxE84sd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494152; x=1781030152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZttONvGURv6EvI4wo5RX5uQzeZ6w2iyXQUfcIMinqdw=;
  b=MSxE84sdXd4K8t8O5afi5GD/1fIgiJZiI9pyCOBZB2UNt4C0Crz6ABWL
   AS35oKa+e5TRx5/5s9mM7ulckNTNsnINM+t5CFB8PYY6A3wXZXlmNwmie
   k36asCfbMUkJykwZG2YE3l77dWP+AeoTMOjPiUL+TmiNeNtE/UcNArPBf
   bZtO1+x6n85bCTLxRwHqrtqIqcY9Q5JFbVSvO3INYpryBR4KgQeYZOomu
   d9uDJduA73WJorjcwzxauMVycwj67s5MJEAht7jsu0aQu54L+PoWahXA2
   mdV6mMXJUQMXgXWmGjeYqd7BD+g2hQHajCUDyRbEhvOlbj5wxU/8hahDa
   A==;
X-CSE-ConnectionGUID: Ic4BwhLoThGi6B928T5erA==
X-CSE-MsgGUID: KAvIGUjaSaiYwHS51Xd/Og==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249764"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249764"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:51 -0700
X-CSE-ConnectionGUID: O6SbleSNQrqdsS4VoLhhYg==
X-CSE-MsgGUID: p/OFdjTiQ0qPFtvKqLFV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732482"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 06/15] wifi: mac80211: fix deactivated link CSA
Date: Mon,  9 Jun 2025 21:35:18 +0300
Message-Id: <20250609213231.07f120cf687d.I5a868c501ee73fcc2355d61c2ee06e5f444b350f@changeid>
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

If the link is deactivated and the CSA completes, then that
needs to update the link station's bandwidth (only the AP STA
can exist at this point, no TDLS on inactive links) and set
the CSA to no longer be active. Fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6d6ec1e15001..ef15a60ef522 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2381,9 +2381,26 @@ static void ieee80211_csa_switch_work(struct wiphy *wiphy,
 	 * update cfg80211 directly.
 	 */
 	if (!ieee80211_vif_link_active(&sdata->vif, link->link_id)) {
+		struct link_sta_info *link_sta;
+		struct sta_info *ap_sta;
+
 		link->conf->chanreq = link->csa.chanreq;
 		cfg80211_ch_switch_notify(sdata->dev, &link->csa.chanreq.oper,
 					  link->link_id);
+		link->conf->csa_active = false;
+
+		ap_sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+		if (WARN_ON(!ap_sta))
+			return;
+
+		link_sta = wiphy_dereference(wiphy,
+					     ap_sta->link[link->link_id]);
+		if (WARN_ON(!link_sta))
+			return;
+
+		link_sta->pub->bandwidth =
+			_ieee80211_sta_cur_vht_bw(link_sta,
+						  &link->csa.chanreq.oper);
 		return;
 	}
 
-- 
2.34.1


