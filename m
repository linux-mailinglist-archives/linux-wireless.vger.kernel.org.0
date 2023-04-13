Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2736E0803
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDMHpT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDMHpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:18 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3700F83E5
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371918; x=1712907918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zpBPnnSs2G+7UOkVywjZGuS4XfMmCMz4SW/GKMwnBw=;
  b=VOXHkjaI1OmwBfcfifOMR/aUMvJp7inyV0KhDufQJaTqAYL0re7ZOQBW
   LaiuiAm4C25vNnR1g/v7ObTwtMqEfBIejrM0GrsVifd5gtUlFrxLcrTJF
   44lKPQPIhF0izmJ50yRN4asTeCVbuQKmGQc6r3CIwWSs5L2yEXSwDDm+M
   upsFdbGj9cgUub3hQobnT+u4O/xH3jPb4MNEWQhJj6fuDBAeUjQ3o3Ear
   gRUY8QR5n+VMj7THqqYy9B9H5aFYzUjvWQbj4TbGL736QOZuJtuRqFI5x
   p1jnD4jFDVlHT0/Cf4XHRzktcLxMGtXQL5r2jsjbfJdYSP+IEAB5VZ2rm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735946"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735946"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034715"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034715"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 04/15] wifi: iwlwifi: Update configuration for SO,SOF MAC and HR RF
Date:   Thu, 13 Apr 2023 10:44:04 +0300
Message-Id: <20230413102635.86f08520323f.Ieccb50de47f877b85732000a0d67b645eeeb0c2a@changeid>
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

update the device configuration for HR1 device for SO and SOF device.
QuZ device configuration is corrected to support specific CRF.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 86b094683631..3112821dad78 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -995,6 +995,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax203_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_quz_a0_hr_b0, iwl_ax201_name),
 
 /* QnJ with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1090,7 +1095,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
@@ -1107,7 +1112,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-- 
2.38.1

