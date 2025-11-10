Return-Path: <linux-wireless+bounces-28755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1772C46508
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 12:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 180214EBEB2
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 11:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E27727280B;
	Mon, 10 Nov 2025 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YFPKRCpr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAD306B00
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762774513; cv=none; b=h7xmwjmvaFTT7FwJ/Q1xRleXmDcKjsBoDlHBVefPK9ySIZsLyykeiwlwPxHwtZLZBw6ulVRk5LBIxMJBj+bf1r1gzk0xQizL8sq2RpZyUmZe+qE+5NgmmY4n52vA5mL/vc9pxzKvtMT2lVAnXatafurS2dhIYmbQv8OyO6PFrfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762774513; c=relaxed/simple;
	bh=j5lgihoR0iZfI2DhfPvM39iJzXqUUPq0jkJq0Nbfo6c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mKauN62I/EjF1t7EGNllyaaWu10kkJgPvWIS6+mHTgnerJoLBlclGPgPvFQMTjanOofUgMYo8k9YoL34FceigyK12aCcu2YDSKHJ1oa9IM1ogYb4E1ZSmTIVXTyfj/6+VEWzIYKOm49cAPtpnG5Eob0uKz7LHFOXZys/pUAf1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YFPKRCpr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762774511; x=1794310511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j5lgihoR0iZfI2DhfPvM39iJzXqUUPq0jkJq0Nbfo6c=;
  b=YFPKRCprlki5KYAQL0u/oJzd4sDXYqjq+IkF/6ON85OCdP6crtOoZYva
   BtUCmnYaUFIThvL9JdYH1Xstc50/xessBKappvpoS3GG4FDfpodxrwBHM
   81dAnfi1noaZfKpQI4IctLRRoYZh1pVOP6dou7Qy61X5LI2dNZO+1Hz4R
   eUyPyf6KbaH72Eh2MY4Dr0hsnM+YEuNtLOtAeJs5w25lHQr7PPLlJ9AVI
   /JjcFnTPRnzZwftfQopVCWGxBN7YZ6rkjwWw0Gh3J89oepmEDathVGn7G
   G3u3M003W10pw6mwS3nfXBvqK6PE2fnkRZmeGCeSvGdqxxxQqsKfaFKyc
   Q==;
X-CSE-ConnectionGUID: 8bwo6whoSEyMunaA6PpokQ==
X-CSE-MsgGUID: pClHakvvQsWdyWm/LYuR/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="90291766"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="90291766"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:35:07 -0800
X-CSE-ConnectionGUID: EIONnm1DQuCt8JfoQ59Pcw==
X-CSE-MsgGUID: TWBzF3C4R/qP83T+dO4epQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="188816947"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 03:35:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless] wifi: cfg80211: don't allow adding/removing NAN function when not supported
Date: Mon, 10 Nov 2025 13:35:00 +0200
Message-Id: <20251110133451.5c545f924515.If337e56bfae927b039bccb4ffa38a3f0e0a8f0f5@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

add/remove NAN function is not supposed to be called/implemented for
devices that uses user space DE.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c    | 3 ++-
 net/wireless/nl80211.c | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9f858a83e912..56c0e2e4bcb1 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -760,7 +760,8 @@ int wiphy_register(struct wiphy *wiphy)
 
 	if (WARN_ON((wiphy->interface_modes & BIT(NL80211_IFTYPE_NAN)) &&
 		    (!rdev->ops->start_nan || !rdev->ops->stop_nan ||
-		     !rdev->ops->add_nan_func || !rdev->ops->del_nan_func ||
+		     ((wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE) &&
+		      (!rdev->ops->add_nan_func || !rdev->ops->del_nan_func)) ||
 		     !(wiphy->nan_supported_bands & BIT(NL80211_BAND_2GHZ)))))
 		return -EINVAL;
 
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 2187e148389d..61d5cc6622b4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -15822,6 +15822,9 @@ static int nl80211_nan_add_func(struct sk_buff *skb,
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	if (wdev->wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE)
+		return -EOPNOTSUPP;
+
 	if (!wdev_running(wdev))
 		return -ENOTCONN;
 
@@ -16056,6 +16059,9 @@ static int nl80211_nan_del_func(struct sk_buff *skb,
 	if (wdev->iftype != NL80211_IFTYPE_NAN)
 		return -EOPNOTSUPP;
 
+	if (wdev->wiphy->nan_capa.flags & WIPHY_NAN_FLAGS_USERSPACE_DE)
+		return -EINVAL;
+
 	if (!wdev_running(wdev))
 		return -ENOTCONN;
 
-- 
2.34.1


