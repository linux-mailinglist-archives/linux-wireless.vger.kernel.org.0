Return-Path: <linux-wireless+bounces-20068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5366A57F36
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 23:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A91016B36B
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398C1EB5DF;
	Sat,  8 Mar 2025 22:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwo/7kfA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD2721324B
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 22:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741471311; cv=none; b=lEEHu32YW6PMcG4CtnkvnmkNOxxZ9zaOeuU/3QGLJaRMIX50L8g+KKe8mQKDM0tm271dIQgA0Au+WciHKFH+lZ8Notwj8abYnG8jK1Y07Uzb2F2rPoOZ7QYiKEq69uWNZfj67YQHmWdkxTacE1lTj8UdUH9HBcjScQFZ/vGIuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741471311; c=relaxed/simple;
	bh=dIwur6ttrR6eDMU6ax+fbSD92MTmtuIeYgs5PrhU/Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eu7LuS26kq+4c4MaBPLhPB3FuytqiJxLpBR4xvRv6wCLYYajoOOQt90dyr//WA/D4UqmVbjPU3FpyfyGqp0DLb1KLdGDW2PHdeLT7HY+lqFqsA5CS+LiEbQrrxr5fiPQn8Rwst/Lc8ZAKYM/wVO0ARCce16/mLL7yLyig7FubmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cwo/7kfA; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741471310; x=1773007310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dIwur6ttrR6eDMU6ax+fbSD92MTmtuIeYgs5PrhU/Co=;
  b=Cwo/7kfAvFNkzZOjNFc0XR+K4FPUqi5nICYGYBrayCevdfEMNkVhqhLX
   RY/GkfjnMHIsSNxgaS917ajmAoDh9nnbV7klKVDb4X4iS2jThbKfmw7Es
   pgP2mTmUaijiAsyHhlkcQuk23PP818tRNmaX7AGWFokSqKGEBydotMt3I
   vzKE8H+eBXHod1vKVTzzI2xtN1C9e8uCBD3cwCtHbg3f05PVzohmws1t9
   Hd9PkrKTfjAt8/l3/gyELYYIG4clchNBkhW1E6fwK0eLVo9Lc0wOyeXLj
   zLxgFRNDl/omfSKKg1+BI/1VkfDPg2Vlaf/V5AEuaRCs6xRLaoZfeo0ZZ
   Q==;
X-CSE-ConnectionGUID: CAs+IwQQRNubQzGAQvNaKg==
X-CSE-MsgGUID: zKTCvNIuQwm8B2ezE/se4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42540634"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42540634"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:49 -0800
X-CSE-ConnectionGUID: 1IQiM08HT5e5WNHT1cZm5w==
X-CSE-MsgGUID: D0Ci2pI7RsWr7NbhL7x2iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="120352133"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 14:01:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 08/15] wifi: iwlwifi: mld: fix OMI time protection logic
Date: Sun,  9 Mar 2025 00:01:18 +0200
Message-Id: <20250308235203.58efb4c91655.Id596fcda2fb28f5945548d780be9ff90aee76b7e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
References: <20250308220125.2388933-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We're allowed to enter OMI only 5 seconds after the last
exit, so the logic needs to be inverted. Fix that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/link.c b/drivers/net/wireless/intel/iwlwifi/mld/link.c
index 64ebafc35c9b..f6d482817f1b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/link.c
@@ -760,8 +760,8 @@ void iwl_mld_check_omi_bw_reduction(struct iwl_mld *mld)
 		return;
 	}
 
-	if (time_is_before_jiffies(mld_link->rx_omi.exit_ts +
-				   msecs_to_jiffies(IWL_MLD_OMI_EXIT_PROTECTION)))
+	if (time_is_after_jiffies(mld_link->rx_omi.exit_ts +
+				  msecs_to_jiffies(IWL_MLD_OMI_EXIT_PROTECTION)))
 		return;
 
 	/* reduce bandwidth to 80 MHz to save power */
-- 
2.34.1


