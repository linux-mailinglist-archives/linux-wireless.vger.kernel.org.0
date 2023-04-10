Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610676DC7A5
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 16:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDJOHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjDJOHh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 10:07:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AEB5261
        for <linux-wireless@vger.kernel.org>; Mon, 10 Apr 2023 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681135657; x=1712671657;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lN40OxVTJqvLB2QqA1Rg5N98/oCedIrNfJG9EIz4FyY=;
  b=jKiyqRz2hIxB+BEL6oBmrOAKU1t1Tm/hM11pYx3QUq+EFb+Vdo29geZ7
   4UBGN6b6392BcY9WHwhDMia+VhRQahb2SOBL9hwn0i9654iEnzehb+zCr
   uDvoEtHpKxz3kbDSCDILKQ2vcYKWDO69l64fQHl/V4Fdo6E29SJPfqPjG
   94sUx7nQRoeAb1zxlN/BOgA4j1TcR/3lNcdS8tQtaESWa2xsH6dWAzjU/
   DC17SjPhgmNe+g1s8BlZ9p76tUWgyRid8gUEf9sPAhE68d3gL1wdD/UvD
   gYikI6tAhULaPAOwEUtDIB4+70ID0A0meBoxSSucMEd+4AL4EVTW0krd9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="327455106"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="327455106"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 07:07:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="812171442"
X-IronPort-AV: E=Sophos;i="5.98,333,1673942400"; 
   d="scan'208";a="812171442"
Received: from mrichert-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.200.107])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 07:07:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] wifi: iwlwifi: mvm: fix the order of TIMING_MEASUREMENT notifications
Date:   Mon, 10 Apr 2023 17:07:20 +0300
Message-Id: <20230410140721.897683-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Host commands and notifications are expected to be ordered in
iwl_mvm_groups array. Fix the order of two new TIMING_MEASUREMENT
notifications.

Fixes: c7eca79def44 ("wifi: iwlwifi: mvm: report hardware timestamps in RX/TX status")
Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/linux-wireless/20230331175121.GA3127046@dev-arch.thelio-3990X/
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 56a4e9d6ae33..6f082059025a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -472,8 +472,8 @@ static const struct iwl_hcmd_names iwl_mvm_legacy_names[] = {
 	HCMD_NAME(SCAN_OFFLOAD_PROFILES_QUERY_CMD),
 	HCMD_NAME(BT_COEX_UPDATE_REDUCED_TXP),
 	HCMD_NAME(BT_COEX_CI),
-	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION),
 	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_NOTIFICATION),
+	HCMD_NAME(WNM_80211V_TIMING_MEASUREMENT_CONFIRM_NOTIFICATION),
 	HCMD_NAME(PHY_CONFIGURATION_CMD),
 	HCMD_NAME(CALIB_RES_NOTIF_PHY_DB),
 	HCMD_NAME(PHY_DB_CMD),
-- 
2.38.1

