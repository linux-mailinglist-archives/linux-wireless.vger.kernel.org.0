Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709986E080F
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjDMHqS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDMHqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:46:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A81A83F1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371976; x=1712907976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DNtjz/Nsw4XniAla7BHnK49+qsOtVTrxMK+sbYH2O3c=;
  b=HB1Pmx72gviZXmafo1FuBZ+8gfvzJn3Itt6ia4n3O8DW1qCoL455yqgZ
   j0ktD7hafBjCokgwioHQIGJlAijozBftv2OkWUL6nlT9etBqCA+oNqed7
   EWrIQO4cFTg1c/9bYXSxCkLo4ONMhyb4ZKbozkFthyg6nol0O1x4EzAQi
   KMh5XFJcKAe07T2kTvNsXV+rW9OUARBwsqPIc1CMwCNTtNfWg0vUTnoWM
   MEkVR2xgA3oummWetcdn2cEpAQiVsvN3p5LJnJp3QQpjVcgqJznyHS74V
   8wwG6iqyfR1dZMYsGgK9+A31YW98b7ypVgvST2jYQgizRt01aMXi/eEfX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323736104"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323736104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034830"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034830"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: Update configurations for Bnj-a0 and specific rf devices
Date:   Thu, 13 Apr 2023 10:44:13 +0300
Message-Id: <20230413102635.879b654c8d83.I7dbea9f411a0b6f47908c4ad6321c7e55cbeb636@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Correction in config data is done for loading the ucode.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3112821dad78..70f6c59eec5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1235,7 +1235,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bnj_a0_hr_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-- 
2.38.1

