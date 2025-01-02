Return-Path: <linux-wireless+bounces-16994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62B69FFA69
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 15:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEBC73A1ECE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 14:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE581B6CFE;
	Thu,  2 Jan 2025 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TDP0gWeo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFC01B6CE9
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735827650; cv=none; b=bDvaD+3htVgfj+CSInY3OsdSOEfkEfFynYNLB6U7QoAmpHe2Uw44ciqyo8+/A+b9W7hQ8FVKBEI2LzC0r61AWTt5NjkxdVtZPpvZ096rpvwZXbN4LilHmsPjrrvYhIPbL0tLY/YW2XpJfJhRYshDlZMztRRuOCVVxye4dPY+Kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735827650; c=relaxed/simple;
	bh=0WeLh/vPG0isVr1D5FJ+l93dwI/8iSWUSs+KXT6PlOw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cmTsFQEIhJmSVLJNX5oBZJ85wKdoiy+5d09QOraf7btSQy2UkB7sE94i+gDtPx1LI0/HdDdPvH4LI+GNh/InBtsz9/tuH1i1TB51kIf7vknJjRfF8A6tdi4nOCXSwjlaYFKxY6lUmseM/KCVZJd/3nNNTp5jnGVKcOY+FXNkksY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TDP0gWeo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735827648; x=1767363648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0WeLh/vPG0isVr1D5FJ+l93dwI/8iSWUSs+KXT6PlOw=;
  b=TDP0gWeo+9gP6ZL4geUW4ofFqXJ3/y/TwNcyupzd5REosgQjUR+J/2pQ
   JAkYrE6SjQ+s+6AwFt56fmX/QgPj73ZBc6gJ0yBGW28lG2JtTOwjJAwMl
   f58WnM1cLryMQrbNDz9PjFqf56yodKVSHBFvIFEup9mApCJPIS8+NgaY/
   Unbjahv5ZEOPUWmFZyLJqwfonoBsWhwVTxf+A2REcBdTMZhwU2alemBp4
   LWMZ2BclmD9SIKbsEOm0OKhPuJ4DMyDwSfkJsTnP11w0aMBnAansgVOiR
   o6y1M3vVij9GQ1415kblgyGQo44gmhtLY5qeEeJeegtilaFiI7ttz35dV
   g==;
X-CSE-ConnectionGUID: MhnPB8T+REeImVWoBPHEsw==
X-CSE-MsgGUID: /z4Fdgb3Q9CyDwMXLQ2Cvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="46735131"
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="46735131"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:47 -0800
X-CSE-ConnectionGUID: HwX1tt1PSeeoZBUcILrLSA==
X-CSE-MsgGUID: 9N4+YrLkT3uv+xfMqow52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,285,1728975600"; 
   d="scan'208";a="132357448"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2025 06:20:46 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/17] wifi: mac80211: ibss: mark IBSS left before leaving
Date: Thu,  2 Jan 2025 16:20:08 +0200
Message-Id: <20250102161730.81a6c12b304c.I8484f768371e128152a84aa164854cca9ec1066b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
References: <20250102142009.3057049-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Mark that we left the IBSS before actually leaving (which
requires calling the driver). Otherwise, it's possible to
have the driver do some work flushing etc. while leaving,
and then get into the work trying to join again while all
data is being destroyed.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ibss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index dfa125219e47..05a945df3259 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1827,8 +1827,8 @@ int ieee80211_ibss_leave(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_if_ibss *ifibss = &sdata->u.ibss;
 
-	ieee80211_ibss_disconnect(sdata);
 	ifibss->ssid_len = 0;
+	ieee80211_ibss_disconnect(sdata);
 	eth_zero_addr(ifibss->bssid);
 
 	/* remove beacon */
-- 
2.34.1


