Return-Path: <linux-wireless+bounces-9205-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1924090D9B6
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 18:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9CF728240B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Jun 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FAB13C9CF;
	Tue, 18 Jun 2024 16:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GncoKCCa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1850B13DB98
	for <linux-wireless@vger.kernel.org>; Tue, 18 Jun 2024 16:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729070; cv=none; b=kaGMeVBgLCciX2yOsnmeku5cbzf0vHEBGtnl9iMFRZTJ0bOJJ46wnmpNFdtMpjJjzOnj4X1wEGJ8zQVRTW8UmxNzzfZUylRPDVo0HJrYAfuSA4S4ukI+HH482cTBisqcXPjuCtA5dnwmI51vunHJkIrQKKfhbSXsKt91Xv+bRSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729070; c=relaxed/simple;
	bh=LFuItK/QRVy3ktGi248XWZegSSWBDONjTeI1Lveksc8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gCR1RSMx+KPUBwYrnge2ScXuFXaCi+bvpXiFRo9qP9Jq2JlbeN4vGWHah1eGklaExsXb38cl9HYVNTNnnW3BZgXuK+D5f0AQ8VrpVbj9cx6jYemweelGV5DXM6ifHnjfBj2BwMunokWUVurPNWMdTQU+TdZuLqWJcHwjQhvxNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GncoKCCa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718729069; x=1750265069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LFuItK/QRVy3ktGi248XWZegSSWBDONjTeI1Lveksc8=;
  b=GncoKCCaoqk4S6Tze2yoQV1z09EnBrZLqAvt3KXfICOIhoYCPLxlRZFZ
   AmEQV6zUNqcdd6Qs+jPmbLXh8bfoLC/4oLPPThRbEFEjDwoy1oVRmxpyC
   Gqk0FmaNQlvFuwzlasBFXIoiKPreP0FYIOEb/g3K9+PmJSg8fnUnoH8tJ
   xsJ8Ct12v2LnXch4XUeJKRSD3jrpRx3oFa4+if1y83tSHn1LusEYy0laD
   IelZ0wZTm3aH60ZjtBANVrTuqnDOS1XlOwYnHbp7s2Lt2zSkMCmmy0Atl
   msEiEWM9vx8kf/5/AV2vjTa6M5Fyunl9gGeRK/C3Cft6NxGvzNZHDhy87
   g==;
X-CSE-ConnectionGUID: 0YVYeIwtTqm/AnqT4PIiGw==
X-CSE-MsgGUID: rRZyYjaJSHyFNYdy0ApOUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="26257175"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="26257175"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:29 -0700
X-CSE-ConnectionGUID: Cw5q7xM8THK/fbviMHfu9w==
X-CSE-MsgGUID: To3mok0LTTGQw4d/Xn3W3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42306513"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 09:44:28 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/11] wifi: iwlwifi: bump FW API to 92 for BZ/SC devices
Date: Tue, 18 Jun 2024 19:44:06 +0300
Message-Id: <20240618194245.433cfbb6f042.I914da5bd0e2ed25148726f9fb55e7a60b895edfd@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
References: <20240618164413.2416719-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Start supporting API version 92 for new devices.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index e3d3abfc5fe4..3b6b8b410be5 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_BZ_UCODE_API_MAX	91
+#define IWL_BZ_UCODE_API_MAX	92
 
 /* Lowest firmware API version supported */
 #define IWL_BZ_UCODE_API_MIN	90
diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
index 7ad3322a3305..4ccb0b7bdc20 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/sc.c
@@ -10,7 +10,7 @@
 #include "fw/api/txq.h"
 
 /* Highest firmware API version supported */
-#define IWL_SC_UCODE_API_MAX	91
+#define IWL_SC_UCODE_API_MAX	92
 
 /* Lowest firmware API version supported */
 #define IWL_SC_UCODE_API_MIN	90
-- 
2.34.1


