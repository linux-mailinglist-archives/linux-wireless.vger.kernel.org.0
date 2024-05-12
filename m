Return-Path: <linux-wireless+bounces-7537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579EF8C3675
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10E45281149
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A45224FA;
	Sun, 12 May 2024 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OnuBCT/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095D0219F6
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715516719; cv=none; b=o3x+X+UA5wP6aKZQupfglMp0LKMOoGmevtNC3xOwRpYT/QeOTRYWZkhN2KHVqfkZ5jFthF9msOfsjSDe2I4S9TbUwBoOrlMYG01pcFcR2CJs5KpcBjiMe5Ys/7RR2+msZue0uMWMwnvVKDdqL7MNiGP6hjki1mxO1zAgUPUEerI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715516719; c=relaxed/simple;
	bh=dX7ss4ZG6Z86xLA3ruUc91gzv3+fewM+2BvdzRVp9Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RnJ5Ibwej27+MZcnFnWLXlD43RPWOg7Dp8Zq2367Q4bZogcJkGd2E6382QgpBTNIid0u94BGhJBEeIzYhsUxFV/DTWjG5/M8bVLuYF1tCH7PXXgspKWoYfEAqS1Pyr61tfgBspMXA+oPvSLCv1Dz7rSaNADHitortu7dm29WmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OnuBCT/r; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715516718; x=1747052718;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dX7ss4ZG6Z86xLA3ruUc91gzv3+fewM+2BvdzRVp9Tk=;
  b=OnuBCT/rb+vBMOjr7TSjrDXyOkf498HyU8WRs8bp0sReebDOpchQiqPI
   jboPPKsK+cV8g/GJW2INXllOPZHkjdp6Ymj9TG1nsZzsiG+BligerhGdh
   CvJBmqJBGNymBqK3nzPjg4r7SCXRbxB6RbG2qSQmIpFSUnZz1AqvfKCDQ
   1mceGkVBbaokGFAa3uIKZD+gNz5nCmbLUXnGK6RwLeOozC74/xYrF0AYT
   I2vC9Yf3wQZba/ul8q8DFHc5+M6SAyAxcGyQ8Ds17708fVvBuM4ixxj+b
   g88GZbiBTuFw36xmAfNkTjS0CjGQkipviz0wNK520/GsmuOys5kQn5rF4
   w==;
X-CSE-ConnectionGUID: S17pDUyLQWSEp1U8kaY5ig==
X-CSE-MsgGUID: eKEoNt3gSb2AHyGFMUvcHA==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11397185"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11397185"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:17 -0700
X-CSE-ConnectionGUID: OXpAsJJcRlGsmd5RD20fMQ==
X-CSE-MsgGUID: E9Y3T+zXRQqTtXNFdH3pDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="34761296"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 05:25:17 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 02/14] wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option
Date: Sun, 12 May 2024 15:24:55 +0300
Message-Id: <20240512152312.cb267b832b75.I2ea2616af9b8a2eaf959b156c69cf65a2f1204d4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
References: <20240512122507.3812527-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ayala Beker <ayala.beker@intel.com>

Ensure that the 6 GHz channel is configured with a valid direct BSSID,
avoiding any invalid or multicast BSSID addresses.

Signed-off-by: Ayala Beker <ayala.beker@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 695b5ba3d023..f81a9b7099be 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1730,7 +1730,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
 				break;
 		}
 
-		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE) {
+		if (k == idex_b && idex_b < SCAN_BSSID_MAX_SIZE &&
+		    !WARN_ONCE(!is_valid_ether_addr(scan_6ghz_params[j].bssid),
+			       "scan: invalid BSSID at index %u, index_b=%u\n",
+			       j, idex_b)) {
 			memcpy(&pp->bssid_array[idex_b++],
 			       scan_6ghz_params[j].bssid, ETH_ALEN);
 		}
-- 
2.34.1


