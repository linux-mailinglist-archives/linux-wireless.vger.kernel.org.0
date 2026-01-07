Return-Path: <linux-wireless+bounces-30436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66CCFD888
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 13:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0E53300996E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 12:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AC4309F00;
	Wed,  7 Jan 2026 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuiI8u1F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F92308F30
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 12:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787507; cv=none; b=qv+3HFTCuIZQFsvwV+XnKNyLsDj0ZmhKYJrdx3kIsHRpWtHNl5KDmIbfwoxqW596foGGyYsmDDLHJ19Lizj9wdiTI9aqoEJeUDqm6FuVadNVtDcsFX5jthlPWa2nOTc8whUrpeH3dPMJNwoPLj2agk/VZMeqBbgQxvyzVcbYLVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787507; c=relaxed/simple;
	bh=WsjwjQIbU2X1OvcpYqgx6eJI18EXiuQLkC0Zc7ZzUUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejd+dPB9qkSekCGwhkbBCjxcl28RkAaIUI0G3Gq4I/b5tmj/AitTLc9hUMA03GRybzNYK4dT0XqsG0WZ3QcaZ/0xyaBJf6a2CxEBmjZdSMWIsi0AOwYgfmgtHLeX+XZ0dpDakmSOjZ4u0IoU8OewJhO4HAEkXriaS6zR+wGc2Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuiI8u1F; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767787504; x=1799323504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WsjwjQIbU2X1OvcpYqgx6eJI18EXiuQLkC0Zc7ZzUUA=;
  b=SuiI8u1FiQOkCx56XhQjBRUn8V/nT+67Lnv4iEtaS7R++Twa01IMRjER
   aOydz+yjaoFZL6zXOyvCrhLAin3a/Vq4XWiCgaEoIUI5Z7IRZznEKgdf0
   MkINF+JWS1AMbO5IfxEqSSqsrqnmApBzyIFj1ugEZK8Lz7tgRNo5t5rEv
   pXBzXWTRh92RK7q+FH6mK+mQ0GtTUoHFaxdHg5TdTDyAFujI2IdJnwokF
   g1CMgUczI2MPUiVQwy4rBYaQHuI+hVDQO9Tuy+LDENsYnfVP/wDUUoJVQ
   cf3CM/pTHmHO/OAsLNlugKQ/Mtyv81l04btOJmJFwPKHWoO0LP8+8YG3/
   g==;
X-CSE-ConnectionGUID: dH/RoMkyR8uE3dSfchuMyA==
X-CSE-MsgGUID: Oi8+/y7EQKyjemECY0AtXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="69088638"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="69088638"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:05:02 -0800
X-CSE-ConnectionGUID: rjjY1zOhR4+Xf9CJSe6zDA==
X-CSE-MsgGUID: pkE7eMqKT/CYMYrtxwqzlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="207059248"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 04:05:01 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: stop NAN and P2P in cfg80211_leave
Date: Wed,  7 Jan 2026 14:04:51 +0200
Message-Id: <20260107140430.dab142cbef0b.I290cc47836d56dd7e35012ce06bec36c6da688cd@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Seems that there is an assumption that this function should be called
only for netdev interfaces, but it can also be called in suspend, or
from nl80211_netlink_notify (indirectly).
Note that the documentation of NL80211_ATTR_SOCKET_OWNER explicitly
says that NAN interfaces would be destroyed as well in the
nl80211_netlink_notify case.

Fix this by also stopping P2P and NAN.

Fixes: cb3b7d87652a ("cfg80211: add start / stop NAN commands")
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 2028bf5686f2..16ccf6fb28b2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1411,8 +1411,10 @@ void cfg80211_leave(struct cfg80211_registered_device *rdev,
 		cfg80211_leave_ocb(rdev, dev);
 		break;
 	case NL80211_IFTYPE_P2P_DEVICE:
+		cfg80211_stop_p2p_device(rdev, wdev);
+		break;
 	case NL80211_IFTYPE_NAN:
-		/* cannot happen, has no netdev */
+		cfg80211_stop_nan(rdev, wdev);
 		break;
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_MONITOR:
-- 
2.34.1


