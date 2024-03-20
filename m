Return-Path: <linux-wireless+bounces-5059-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DC6881919
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 22:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0059AB21550
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF6D86128;
	Wed, 20 Mar 2024 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oBcwark6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C785C6A
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970045; cv=none; b=qmCMP692pFUggvBW44UT/NE5MV53ICQHi8nF5mBW8ithI+uyNb2zLabmzYTikElCzIKj0BLbM1cUBRMIG6OM4LUYWK8OOrynW5ik/o4+AaPDQyCRVkDJZR1hDGvZphvcODvlg7NrijIJWaHbQF+vJtM3ovKLabHSDnjFEsQSZ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970045; c=relaxed/simple;
	bh=sb/MrSc7f5j4XJm/TkdNyCKfNQxLIBe0XYBQZI4Sksk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rzenf0JfhwsyHrIXffwAW75Vc2WIchdbLHmvGV8R86rybxJVkgOIG3Lt03neU3Gvd3byGk9Lj2inFDQ1qTp8pC+svzw4J7YwJArrQ62sG67DqL7dyn5bAUIMt4i/maT9CdQgOKf0tEwwPVX2u5sLk0YlNdJ/B9RPtmnU91v6x+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oBcwark6; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970043; x=1742506043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sb/MrSc7f5j4XJm/TkdNyCKfNQxLIBe0XYBQZI4Sksk=;
  b=oBcwark63Ddp0tunC6NYaVhyV/HuYTn5UltKTv5vwaFjscrWDhibmgLJ
   raavyzgvWYxNRyNOdMIISyGiBsC1xypGD9kduOnPbWU773YA98J/DxfyQ
   9iseNxTjFnvVxE44RU4GGZVz+Q7+cfTn1ezU2emsklPsO5NSZri4D46Ri
   AAbp/H84EPrBrYAvv6sC8jKH0BHaIlk0xa7v1Yx/AqQqcthPiO/fz8AWV
   wmKGMQRx8/7969WEdzT3C5IrkIAfqnnKOCHwDuGUC6sM2nTgf3QNrSyeL
   +XgxMttV1xWPa2FNgIkyN91njUgcbMZ0T7gG4hK9hpSfDOHfMNPsBGh9A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="9698153"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="9698153"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14184209"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:27:22 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/17] wifi: iwlwifi: mvm: don't change BA sessions during restart
Date: Wed, 20 Mar 2024 23:26:37 +0200
Message-Id: <20240320232419.70ba08540db0.Ic604d384e660c755308a49a79d3f7e78bc27597c@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
References: <20240320212638.1446082-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

During restart, we haven't added BA sessions, so we also cannot
change them to switch between links when that happens in restart.
Short-circuit the appropriate function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 5785b70a4aff..a1c00099cadb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -989,6 +989,10 @@ static int iwl_mvm_mld_update_sta_baids(struct iwl_mvm *mvm,
 	u32 cmd_id = WIDE_ID(DATA_PATH_GROUP, RX_BAID_ALLOCATION_CONFIG_CMD);
 	int baid;
 
+	/* mac80211 will remove sessions later, but we ignore all that */
+	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
+		return 0;
+
 	BUILD_BUG_ON(sizeof(struct iwl_rx_baid_cfg_resp) != sizeof(baid));
 
 	for (baid = 0; baid < ARRAY_SIZE(mvm->baid_map); baid++) {
-- 
2.34.1


