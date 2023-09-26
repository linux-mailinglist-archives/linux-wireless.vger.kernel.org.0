Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446787AEEA4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Sep 2023 16:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjIZN4N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Sep 2023 09:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjIZN4M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Sep 2023 09:56:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB2710C
        for <linux-wireless@vger.kernel.org>; Tue, 26 Sep 2023 06:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695736566; x=1727272566;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EKQ4N692XSeeoJRWAobK6SZsuAuCevmA7AKCJL1ZDHw=;
  b=RfLMFhR4EaTjdqcJssGjIOfFt2IE8y7HJrg+lNL9uiKkniLG5Be/f4cD
   t88iayrDiH1ckIho8r9xlh020HjbvGnT4Ly+PbrZ8PgJKnfGxhCEyW+TL
   a7biEo6E/dSlG8iYyokKt3I+b1rORwZP8d4y2UvUaAEFbkisKtD3wG9I0
   J/wBjcTFq49WHsxKf2nTD3bdy6Gn67wM3UQrE4kC5WFvoir2lCLkfXLLK
   LYrpWnQx7NiDcIXBgiSg/QesMcuQQwujOv/7hjSAgch+MJdCAPD/+ZwAB
   TFy81asW5jQ+e+ljNWw236sbmfMBMJtxDNjpy56+jsG7KbSFhIII+QFvm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="378846633"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="378846633"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:56:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819032893"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819032893"
Received: from nbenitzh-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.250])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 06:56:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH] wifi: iwlwifi: mvm: Fix incorrect usage of scan API
Date:   Tue, 26 Sep 2023 16:55:50 +0300
Message-Id: <20230926165546.086e635fbbe6.Ia660f35ca0b1079f2c2ea92fd8d14d8101a89d03@changeid>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The support for using link ID in the scan request API was only
added in version 16. However, the code wrongly enabled this
API usage also for older versions. Fix it.

Reported-by: Antoine Beaupré <anarcat@debian.org>
Fixes: e98b23d0d7b8 ("wifi: iwlwifi: mvm: Add support for SCAN API version 16")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index c1d9ce753468..3cbe2c0b8d6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -2342,7 +2342,7 @@ iwl_mvm_scan_umac_fill_general_p_v12(struct iwl_mvm *mvm,
 	if (gen_flags & IWL_UMAC_SCAN_GEN_FLAGS_V2_FRAGMENTED_LMAC2)
 		gp->num_of_fragments[SCAN_HB_LMAC_IDX] = IWL_SCAN_NUM_OF_FRAGS;
 
-	if (version < 12) {
+	if (version < 16) {
 		gp->scan_start_mac_or_link_id = scan_vif->id;
 	} else {
 		struct iwl_mvm_vif_link_info *link_info;
-- 
2.38.1

