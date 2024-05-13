Return-Path: <linux-wireless+bounces-7585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2856C8C3EDF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 12:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF121F2437A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 10:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9414A4E2;
	Mon, 13 May 2024 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dt86Momu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CB14A61B
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715596048; cv=none; b=I8UKr6XcOM0dasQ/9w7w9DCU+ctSTJ+V38I3S0yajsrixkO1XDSoFHk72pDnvQxdZ+ZgPiAmJX9lvjd4u0lb+g7NL99k3B0xXINcFTVMJ6PCt0Yl4icEeuAzGemF41d/Bo69vofNit79M0T8sO6GTg6vl6W7bC8gaqF90T6g5Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715596048; c=relaxed/simple;
	bh=dYfuhCe6RwMSb+Vi0N0TYJPlT0h1+m8QLXI1q6AQ1Dw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uynDSTp9a22RqtMZmh91SHlvUoLaiKogQVEl3DEqOQGdPSBHpLZAhlEKaeHwplMp+znYHrAYmNeNs5izMOAv5JXYgUOSfyg5d1aAHn/aefPMABfIhgNgMjsd0jc5Yb8BMjBCAY4PyecKf9qkNgpMzXV9RNBaX8o/xrMBPFvOfXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dt86Momu; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715596047; x=1747132047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dYfuhCe6RwMSb+Vi0N0TYJPlT0h1+m8QLXI1q6AQ1Dw=;
  b=dt86Momu6qr/pcBdfNjJf3KUK2CPTCqFYUFe2sPLDbPNzyeLDSjUjwmT
   OFV2nxGMo5zqTBzWSrMaVKsR+JsQQkGuwZcAxYD5bUjko6v0yFM4EAU/W
   9EbVPcWFlOWJAANCU+aXg7HiWuzzf9wRdo8K3vOfIkL1R8UQfaILl6dii
   nGzoG7+tmkNCrjeNfTHVOmpATxLhpV9SSv8vVi+CDX8jb28wvvlJPW7BB
   DX+gt6iu0Ptvd01vIoiYetLHmr8eDq5nsnJFF6EiLBJLlD5PzUp01vbsf
   NEP6JqPReAEsyugj7eY8opD1fp/SADxIpYDhRPY2US3J6SLQYCvdghZh3
   Q==;
X-CSE-ConnectionGUID: FefBrzw+Stqbw2ysGnp5ew==
X-CSE-MsgGUID: rW9g+euPTBe4yCppfLLfyw==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="22928659"
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="22928659"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:27 -0700
X-CSE-ConnectionGUID: qYq8CADDTKiWRTSnTj+kmw==
X-CSE-MsgGUID: m0xpJ1KaR/i6uHmKF5eqsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,158,1712646000"; 
   d="scan'208";a="53516411"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 03:27:25 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ayala Beker <ayala.beker@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 4/7] wifi: iwlwifi: mvm: properly set 6 GHz channel direct probe option
Date: Mon, 13 May 2024 13:27:11 +0300
Message-Id: <20240513132416.91a631a0fe60.I2ea2616af9b8a2eaf959b156c69cf65a2f1204d4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
References: <20240513102714.469087-1-miriam.rachel.korenblit@intel.com>
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
index 11559563ae38..85d8cbe6d248 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -1717,7 +1717,10 @@ iwl_mvm_umac_scan_fill_6g_chan_list(struct iwl_mvm *mvm,
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


