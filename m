Return-Path: <linux-wireless+bounces-8532-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E48FC98C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A62F282600
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3612E192B81;
	Wed,  5 Jun 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="he50FG6L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB571922F2
	for <linux-wireless@vger.kernel.org>; Wed,  5 Jun 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717585058; cv=none; b=sQoZZ2oHnA6yuwselzWbGlTY2bXnfUW/93Di2IIvaX+zNBKnuzJb/7FBDUdo9cwFowPxoO2ZKhEwio8zNjaGx87OWdNGrY2NvnaOFt8fPU/5rmNSvBSe8IGtXNXEPBD5hulvnFx8B19C0B+NuwVa2YMvpNl+38cCQszIkMyHN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717585058; c=relaxed/simple;
	bh=zCzf87zuYlcS7QlJEs8hi1Y+ECX1zAwGj/MwI5/13tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lw+5QF7DPlAzzPY759Z0MRN3Vp7G+Hzxkhce19ovULYwWe4Uo8K0CYsNuF6mzkjkMiDw1USfthOZXBnUpmHvP2lLangChR4ovbB03Ketmp9txJ0nuxE2JAPi+ZiblY483zNUdTRIGtE8BZoV4P4c6Sj95cONBpxUkeKCqa4Cu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=he50FG6L; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717585057; x=1749121057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zCzf87zuYlcS7QlJEs8hi1Y+ECX1zAwGj/MwI5/13tI=;
  b=he50FG6LtSKdR8MM5G95gwgBLaqf6wlK3LbT+AQRSZnnlRK0677YGQHW
   uOK5MMz3ea4E87zT2asoMHJgjvpogZ4HRbmPmnnJCwqppcX92ITVxIwkF
   NY+bIMiSw3s/YzBMs1gc0gXFJS1++a6SytaQsCWDQPI91qIE4skUKWiPF
   2Pbo/zaMaSlBAZtSh9TDdOKfuDTrt6//BNdtk1AFIQYDH0PQYJcADIpEm
   o13af5P2Z3LN0/zY4RISUtxvWH2jPOmHCkmQJaPToXFIFjHnaY5iXaOd+
   Kxwfd+YpVY7/G14gdCefHvt0+vuIAbEzoqJPCTbP3CRBg9dC+RVK1yHCZ
   A==;
X-CSE-ConnectionGUID: eHFTrUQJSUqx0AnIcNxPkg==
X-CSE-MsgGUID: B7+fX14XRneqalxu+COOqA==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="11919957"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="11919957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:36 -0700
X-CSE-ConnectionGUID: SA0MtzqVSVuQGYZlFKt6mw==
X-CSE-MsgGUID: FsjUWCDaQKqnP/hnUBpgMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="37563019"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 03:57:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/7] wifi: cfg80211: honor WIPHY_FLAG_SPLIT_SCAN_6GHZ in cfg80211_conn_scan
Date: Wed,  5 Jun 2024 13:57:20 +0300
Message-Id: <20240605135233.33f03661476a.I7b5be20a55aafe012cd9ddb3b4ba2d46b256ace4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
References: <20240605105722.2034610-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If a user uses iw to connect to a network and we don't have any
information about the existing networks, cfg80211 will trigger a scan
internally even if the user didn't ask for a scan. This scan is
implemented by cfg80211_conn_scan(). This function called rdev_scan()
directly without honoring the WIPHY_FLAG_SPLIT_SCAN_6GHZ flag.
Use cfg80211_scan instead, this will split the scan if the low level
driver asked to.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/sme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/sme.c b/net/wireless/sme.c
index a8ad55f11133..e419aa8c4a5a 100644
--- a/net/wireless/sme.c
+++ b/net/wireless/sme.c
@@ -5,7 +5,7 @@
  * (for nl80211's connect() and wext)
  *
  * Copyright 2009	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2009, 2020, 2022-2023 Intel Corporation. All rights reserved.
+ * Copyright (C) 2009, 2020, 2022-2024 Intel Corporation. All rights reserved.
  * Copyright 2017	Intel Deutschland GmbH
  */
 
@@ -130,7 +130,7 @@ static int cfg80211_conn_scan(struct wireless_dev *wdev)
 
 	rdev->scan_req = request;
 
-	err = rdev_scan(rdev, request);
+	err = cfg80211_scan(rdev);
 	if (!err) {
 		wdev->conn->state = CFG80211_CONN_SCANNING;
 		nl80211_send_scan_start(rdev, wdev);
-- 
2.34.1


