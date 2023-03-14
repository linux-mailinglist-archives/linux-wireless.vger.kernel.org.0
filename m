Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877466B9D93
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCNRyV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjCNRyU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:54:20 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1762D64A90
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816432; x=1710352432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RqYqPbl5OUBtJE22tYViqFFtj7M3v22Fq0UHMFch6eA=;
  b=QV50lmQAptZdD2pZLaIv4p3/QiBb6k7+BBiKjvyYMFF67A+lR1Uvpuaq
   CvxqlhQC1+60KdRFLSae2gbR0NotTusHSD79923Gsu8Edr7DUWoZuJrbH
   6bCtdsUDhObJUq02dCbxIxItV37+6EDCowh0hGLDLPHNvWgiWiaqmsDex
   CBac5gIMyQZrSu1hpNTZtbO7qN66sKNfDrCsx9TYo4AHdV7nfBh8JmteN
   diKoPa3byB+EmU+9+zL8Ub02Ohxi4RLtbN1oP0ENqM4fbg4wH8W0DM4Hm
   hu5TQr6PoG8IGTzrtGJI9s898yoeWgPXlFf04sDYp30IvFYKmRDX7y/wo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149690"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149690"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200579"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200579"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:50:27 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Solomon Tan <solomonbstoner@protonmail.ch>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 17/22] wifi: iwlwifi: Remove prohibited spaces
Date:   Tue, 14 Mar 2023 19:49:29 +0200
Message-Id: <20230314194113.557d6841a166.I0957923fe9ea20c1ec9140477033548ccfe93e9a@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
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

From: Solomon Tan <solomonbstoner@protonmail.ch>

This patch addresses the error from checkpatch.pl regarding the presence
of prohibited spaces.

Signed-off-by: Solomon Tan <solomonbstoner@protonmail.ch>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index aa8e08487b52..923bbfc151dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -81,7 +81,7 @@ static const u16 iwl_nvm_channels[] = {
 	/* 2.4 GHz */
 	1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
 	/* 5 GHz */
-	36, 40, 44 , 48, 52, 56, 60, 64,
+	36, 40, 44, 48, 52, 56, 60, 64,
 	100, 104, 108, 112, 116, 120, 124, 128, 132, 136, 140, 144,
 	149, 153, 157, 161, 165
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 85b99316d029..5790435dc69e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -214,9 +214,9 @@ static ssize_t iwl_dbgfs_set_nic_temperature_read(struct file *file,
 	int pos;
 
 	if (!mvm->temperature_test)
-		pos = scnprintf(buf , sizeof(buf), "disabled\n");
+		pos = scnprintf(buf, sizeof(buf), "disabled\n");
 	else
-		pos = scnprintf(buf , sizeof(buf), "%d\n", mvm->temperature);
+		pos = scnprintf(buf, sizeof(buf), "%d\n", mvm->temperature);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
@@ -261,7 +261,7 @@ static ssize_t iwl_dbgfs_set_nic_temperature_write(struct iwl_mvm *mvm,
 		mvm->temperature = temperature;
 	}
 	IWL_DEBUG_TEMP(mvm, "%sabling debug set temperature (temp = %d)\n",
-		       mvm->temperature_test ? "En" : "Dis" ,
+		       mvm->temperature_test ? "En" : "Dis",
 		       mvm->temperature);
 	/* handle the temperature change */
 	iwl_mvm_tt_handler(mvm);
@@ -291,7 +291,7 @@ static ssize_t iwl_dbgfs_nic_temp_read(struct file *file,
 	if (ret)
 		return -EIO;
 
-	pos = scnprintf(buf , sizeof(buf), "%d\n", temp);
+	pos = scnprintf(buf, sizeof(buf), "%d\n", temp);
 
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
-- 
2.38.1

