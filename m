Return-Path: <linux-wireless+bounces-1018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85C18190A9
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 20:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A586828912A
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 19:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536438F8B;
	Tue, 19 Dec 2023 19:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eSpEVYTG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD138F80
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703013835; x=1734549835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hI7LjjysimauNPp7SG57cRxuLO+YIRZhG1B4eNI6360=;
  b=eSpEVYTGafYXmGssxoZae2b9IxmImkNyTwIoIciAXXiA+2fo4C6X8ipC
   SZSZXO2sT/JICdJ0EwLl7TKkIFQrgqor53do5yudDplpA8Bi/m87CXT7D
   BWUKhu8/isdnDHd7/+lzIi/3UVr0+5l5YE71JwyXfY6CUJ6nQlKSRcpIo
   jQfSiGQgOnMDl2tF1wjE6PNFYjBtEXKcQBLwRIfBczY36vOEvMS5t56Hb
   shby7gxHBUG21jx4cu39TSGQMYJniYE2BKlNYc7EjwO37ewf/vtsOK4US
   h80XltlGjySfIAlkjTDyGN7LhkN8GegnD4aCcAd1wWZhr8ToHz3+OiXtI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="481900251"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="481900251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:23:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="779582590"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="779582590"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 11:23:53 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Luciano Coelho <luciano.coelho@intel.com>
Subject: [PATCH 01/14] iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request
Date: Wed, 20 Dec 2023 15:24:31 +0200
Message-Id: <20231220152135.7f031f1a127f.Idc816e0f604b07d22a9d5352bc23c445512fad14@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220132444.3310698-1-miriam.rachel.korenblit@intel.com>
References: <20231220132444.3310698-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The firmware changed their mind, don't set the chains to zero,
instead set them to 1 as we normally would for connections to
APs that don't use MIMO.

Fixes: 2a7ce54ccc23 ("iwlwifi: mvm: honour firmware SMPS requests")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Luciano Coelho <luciano.coelho@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
index 4e1fccff3987..334d1f59f6e4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c
@@ -99,17 +99,6 @@ static void iwl_mvm_phy_ctxt_set_rxchain(struct iwl_mvm *mvm,
 		active_cnt = 2;
 	}
 
-	/*
-	 * If the firmware requested it, then we know that it supports
-	 * getting zero for the values to indicate "use one, but pick
-	 * which one yourself", which means it can dynamically pick one
-	 * that e.g. has better RSSI.
-	 */
-	if (mvm->fw_static_smps_request && active_cnt == 1 && idle_cnt == 1) {
-		idle_cnt = 0;
-		active_cnt = 0;
-	}
-
 	*rxchain_info = cpu_to_le32(iwl_mvm_get_valid_rx_ant(mvm) <<
 					PHY_RX_CHAIN_VALID_POS);
 	*rxchain_info |= cpu_to_le32(idle_cnt << PHY_RX_CHAIN_CNT_POS);
-- 
2.34.1


