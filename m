Return-Path: <linux-wireless+bounces-23887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B8FAD25B8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 394AC7A2724
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E6B21FF26;
	Mon,  9 Jun 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ShwOaDss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF4221D58F
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494161; cv=none; b=EIlwB1eDQ9IVXLeWFeOJyhplWddwPg2W6JB0uz5Ps/ewXJQ8un7irg2YtaShF9s9IGzcH3noSRXgN+NDs4O8L8j2hpaQxojUGWCKBs4HtawdFKG1nAR4hf7XWEdJ30yhi3+w7UkhKNXevyGGVx/4ZajE9dJRSZ0mIPwxdy/IPQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494161; c=relaxed/simple;
	bh=QIt5+yuEEojwX8+9sFOIgoGo+t/OBMLBpq8C5G8eFmI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhRaCLYK/y90gvLvgNYmyvYyBavBFyrT7h5n0g+B67yzvfOdtjzYTwORcOSDJ920bv3WIwXEtBm/BWt6+J6ookYZSZ64qgqyxiSabpCsDHHlxO3L7Ua2NR+0oYDlPpMD0rhzN9b/tfWYQdNqW4p1R/sjny/8uAOO+u+KsOaLDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ShwOaDss; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494160; x=1781030160;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QIt5+yuEEojwX8+9sFOIgoGo+t/OBMLBpq8C5G8eFmI=;
  b=ShwOaDss9UiOsN0wP7RcojjsUGIJbU9XdMhIy9nJ/tMfhM9TeRi0WDDV
   +MU0bsNHg7yYe7MMiIlO701bM2DcWnfuNXeMUgPMBl/i+ejGsL5pHqAYE
   wI2TCJgAjf0VaGK6ZP32DoAn+ZtInQobUQT8bK3PQTJa4VqsiXBgap44G
   3WfuKaIWpxHlwAZ5dW/ofCbjYufv1RNYCqMFX332EEwhX+MFB/fRteIMs
   U15Mprd6Sa7AONvPjE4nFT8Sgfk4r3WJy1W5hwkwap5UmwO7G6dMj/e2D
   ElM1NlE2XdoHpf7YKqpWi69IQJCHic1itotneGOzku2sDFXXB6v9lHGcI
   Q==;
X-CSE-ConnectionGUID: Wc0f/svtR1uZf7+r1vytDA==
X-CSE-MsgGUID: wjK3kJInTLCc3aCpmkUcpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249775"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249775"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:00 -0700
X-CSE-ConnectionGUID: Y8caqzpIQROQIC08GNNftg==
X-CSE-MsgGUID: u610LzNGSsG6Bw/Q0OrQoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732539"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:35:59 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 12/15] wifi: mac80211: copy first_part into HW scan
Date: Mon,  9 Jun 2025 21:35:24 +0300
Message-Id: <20250609213231.63f6078bd7be.Ia6e5cee945e6d9617c2f427552d89d23c92eee83@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

cfg80211 now reports whether this is the first part of a scan. Copy
that information into the driver request.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 7b8da40a912d..ad4970ae8ea4 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2024 Intel Corporation
+ * Copyright (C) 2018-2025 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -795,6 +795,7 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 		local->hw_scan_req->req.scan_6ghz_params =
 			req->scan_6ghz_params;
 		local->hw_scan_req->req.scan_6ghz = req->scan_6ghz;
+		local->hw_scan_req->req.first_part = req->first_part;
 
 		/*
 		 * After allocating local->hw_scan_req, we must
-- 
2.34.1


