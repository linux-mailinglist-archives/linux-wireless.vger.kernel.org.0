Return-Path: <linux-wireless+bounces-30435-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19927CFD83D
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 12:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5833A3013546
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B762B1D5160;
	Wed,  7 Jan 2026 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nncM4Ak9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A2312837
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786728; cv=none; b=ty0bvB4Cdm5eaN8Ew6PY+u+HMF0EHmEYvZh8uwcytK3Nvnp46VeOUhcHBvZxVWapdq4xmMbJEES2JDaSAhb+AqV6hrmCk7P3Ch+qU2QxoDRB4T5+AiIm5kVTnuqtImb/VJb5hRP/FJMYhB8oQYyxeYMeAzX5zE+NCN67uA2rvis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786728; c=relaxed/simple;
	bh=WOx8z4QX8gjvwGXHszNzzqepbUyQ/o+lMg5VlSCP4DY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XwaMcQRpkimB2BqjshZVlMUikNDviFZNibRWd8kYdQWYP5Zbcn1YIbvF7yvpzYIW9XSrYoqv1ct6hauOOWM4rOn9aojmWg5g7B3yRcixlDk9yLKkeR1M3zUtZ+RwuWRcHcjcxt+e1u3ped/mc0bD9TqIH2imOdysXc57iKgdMWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nncM4Ak9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767786726; x=1799322726;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WOx8z4QX8gjvwGXHszNzzqepbUyQ/o+lMg5VlSCP4DY=;
  b=nncM4Ak9gzAVzfrEpkGOU6Tj5D7bU7BUBjIRMr4r+IsUapdaJA/9ZG1x
   hR3Cw1vCL9T/p59TS1hZ39ULiEzD8MpfpsI9xPluKE9J/CGJLNkw9Wp67
   WSabx8Mb9ZSpWelaG2DQHLX2e6rLCImmCvP0n81s8yloYmvWPhtnqJdW4
   A4iqkQXuiVZWGNbdvuKuUmHObEPGdcI5yKRtRhChyCXqR4OPzCdGlXbtY
   Ag7QmqbXVIIHJEz2yO6pdwLs+s5JAqWTP4pikhBBuezELmdU5eBUm4SWg
   XXrN9brxrkYQ+qDBNtfhe9fDE3vRVZMQsDXmAlRGcPqJ47lT3lmA8id3X
   A==;
X-CSE-ConnectionGUID: Lne2COtPTFiEMKJGwNmyvQ==
X-CSE-MsgGUID: w5lRJibFSJe9sgkwFr4ypw==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="69313127"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="69313127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 03:52:05 -0800
X-CSE-ConnectionGUID: oSnU9pOaSeKIBH+/NWIJyg==
X-CSE-MsgGUID: baoIGjZgQy6xKTG9g4vObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="233615743"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 03:52:05 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next] wifi: cfg80211: allow only one NAN interface, also in multi radio
Date: Wed,  7 Jan 2026 13:51:57 +0200
Message-Id: <20260107135129.fdaecec0fe8a.I246b5ba6e9da3ec1481ff197e47f6ce0793d7118@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

According to Wi-Fi Aware (TM) 4.0 specification 2.8, A NAN device can
have one NAN management interface. This applies also to multi radio
devices.
The current code allows a driver to support more than one NAN interface,
if those are not in the same radio.

Fix it.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/wireless/core.c b/net/wireless/core.c
index 9a420d627d3c..2028bf5686f2 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -661,12 +661,8 @@ int wiphy_verify_iface_combinations(struct wiphy *wiphy,
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-			/* Only a single NAN can be allowed, avoid this
-			 * check for multi-radio global combination, since it
-			 * hold the capabilities of all radio combinations.
-			 */
-			if (!combined_radio &&
-			    WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
+			/* Only a single NAN can be allowed */
+			if (WARN_ON(types & BIT(NL80211_IFTYPE_NAN) &&
 				    c->limits[j].max > 1))
 				return -EINVAL;
 
-- 
2.34.1


