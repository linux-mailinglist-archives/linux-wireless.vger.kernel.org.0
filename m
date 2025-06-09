Return-Path: <linux-wireless+bounces-23880-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396FAAD25B1
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA43D189104B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09121CA16;
	Mon,  9 Jun 2025 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFbRRNzO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA23821D596
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494152; cv=none; b=L1I5e+2Zd/DOZpI/2z4dKtmnDz8KscbLi/DU62LZXDSCijEqcFot6Pqctfvc4p1Lv1+UBPxklb0go+Y8IXxiD9NwnXjydI/ySOhMuTpM22RjmP3Na62ZX5N3OKULfGOQEB7Yi/a9DEZTKPf2ywovNvZWr8pnP6gw6H8BM+BkTB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494152; c=relaxed/simple;
	bh=QkVRbIIGUH+jKvbEeudlMHNDYCCuGW/CLQRyQwcoqHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bVBmOiMfSOh/Tb6SjwY5QRoJMH19qmxZwhG0fpI6Sv4Vah8QfGLeQBDuw73iXgnUreQ+RgoDuBNt5Otm1FHO8fKhlFAGPkj1Db0btAP+RGQBFx//60k6ATkUwkiCQOQ50EOPsN38/XSBq3nl6vWkDQOyPfgmxTz2hBbaz6pKfRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFbRRNzO; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494150; x=1781030150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QkVRbIIGUH+jKvbEeudlMHNDYCCuGW/CLQRyQwcoqHU=;
  b=EFbRRNzOD0B/0janhjXZxIPCu/3+nG/escnB5QKe7uixeTiQpXc1agR+
   mpj7ND5yTpnRvbXS5cs8hxF71SrTWNOHDAfiEJXP7kVdxLTKHPivaayfm
   d/VgI6nvY4MSSiyKwWOhrYQX3+XilGvkfK05I6rFNjg3CMnuJNO67WO6S
   7XKqrq635wHLTSUifP+axho5qienG5xz3dk/+ErRptYUHJ5L2VzRohiSQ
   yLbuqyIuAzYB9n4169nERHYpbEjihp9G8qIFISQ+ZnvM75Cg63CFyDjut
   LV/QvDLkVXSZE6nyn29JaLSGO6Gr4tQxcWzxpUbZz//uUBD/ruoIOf+0l
   g==;
X-CSE-ConnectionGUID: JVRz2+c1SDeU4vU1cpEwkA==
X-CSE-MsgGUID: j4WPJY/oTcufX+Ng5R1Qrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249761"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249761"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:50 -0700
X-CSE-ConnectionGUID: xs6dfxNQQ+KYOomjNweZvQ==
X-CSE-MsgGUID: +T76TZY/SH6DirTQcXzoQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732474"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 05/15] wifi: mac80211: add mandatory bitrate support for 6 GHz
Date: Mon,  9 Jun 2025 21:35:17 +0300
Message-Id: <20250609213231.4aecd7f3b85b.I33a54872a3267c9f6155ce537d6c9c2a31c3f117@changeid>
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

From: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>

When a new station is added, ensure that mandatory bit-rates
are enabled for 6 GHz band.

Signed-off-by: Somashekhar Puttagangaiah <somashekhar.puttagangaiah@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/sta_info.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 84b18be1f0b1..93974156a73f 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -4,7 +4,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright (C) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/module.h>
@@ -681,6 +681,7 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 				    IEEE80211_RATE_MANDATORY_G;
 			break;
 		case NL80211_BAND_5GHZ:
+		case NL80211_BAND_6GHZ:
 			mandatory = IEEE80211_RATE_MANDATORY_A;
 			break;
 		case NL80211_BAND_60GHZ:
-- 
2.34.1


