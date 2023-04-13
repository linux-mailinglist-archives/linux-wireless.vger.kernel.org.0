Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32BB6E1454
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDMSm0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjDMSmY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:42:24 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2B0868D
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411331; x=1712947331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8gP8Uz3uktpIMl41OlNfnXXvFh9bUX3sOtjgtI6mGi0=;
  b=XQEq79jGVYi0XaogDEb76skT2tYVUJBGZE/ttRYmoPGqe39QfjUokEub
   1tvFDBfqGaP8rSKfn/A8sfRA8d9WrxnXNuYh/coRTKgwqL4AMr9lPmMZ+
   dq+JH1vY7rny8dCsmM/1XgpewIFAdoPaWckiTsx4qubkOVH4XlH3nWBFd
   PD7A2kP3iZQZ+lmQuIRVfsEKBJxFd4O09v3huhYoKwSp0oIZZ5hHzfO0Z
   1G2FAdjM948feIdSh8rFOicTfdKANKe6zfe+SFW9ZxzMa55BbEw8qjWLL
   av/K44s9ZzyVY5FEt4Dl/nlBIhbsxpT9HalU4BHoLnG4d46Gl5L/jSqiN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127099"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127099"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984441"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984441"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:18 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/15] wifi: iwlwifi: yoyo: skip dump correctly on hw error
Date:   Thu, 13 Apr 2023 21:40:33 +0300
Message-Id: <20230413213309.df6c0663179d.I36d8487b2419c6fefa65e5514855d94327c3b1eb@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413184035.1140892-1-gregory.greenman@intel.com>
References: <20230413184035.1140892-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Daniel Gabay <daniel.gabay@intel.com>

When NIC is in a bad state, reading data will return 28 bits as
0xa5a5a5a and the lowest 4 bits are not fixed value.

Mask these bits in a few places to skip the dump correctly.

Fixes: 89639e06d0f3 ("iwlwifi: yoyo: support for new DBGI_SRAM region")
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 51cdbc13fbcd..d5b51496bd0b 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1038,7 +1038,7 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 	range->range_data_size = reg->dev_addr.size;
 	for (i = 0; i < le32_to_cpu(reg->dev_addr.size); i += 4) {
 		prph_val = iwl_read_prph(fwrt->trans, addr + i);
-		if (prph_val == 0x5a5a5a5a)
+		if ((prph_val & ~0xf) == 0xa5a5a5a0)
 			return -EBUSY;
 		*val++ = cpu_to_le32(prph_val);
 	}
@@ -1562,7 +1562,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 		prph_data = iwl_read_prph_no_grab(fwrt->trans, (i % 2) ?
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_MSB :
 					  DBGI_SRAM_TARGET_ACCESS_RDATA_LSB);
-		if (prph_data == 0x5a5a5a5a) {
+		if ((prph_data & ~0xf) == 0xa5a5a5a0) {
 			iwl_trans_release_nic_access(fwrt->trans);
 			return -EBUSY;
 		}
-- 
2.38.1

