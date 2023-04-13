Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832A66E1453
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 20:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjDMSmY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 14:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDMSmX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 14:42:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB0E6599
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681411329; x=1712947329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qK4ZJnVXZHIf+ARZwnesw+Jpu0/SzUy2QsZlZCy9AJc=;
  b=f3KwOmgrJ/+9Zxq+CvCMfl4aHJUjQ4EBbIKYaDvl/s887xcN37IsyKBz
   eiUHtLqa60Vj/1QnE99f+qF58WwOL85puyPW1j8aKHGwHF+wlqVI1Pzht
   SvAaD7ErDt2irCN9LoMxegvbT2XymtrTO31CIR0nhASOXADPJS3/T+PLV
   1teqKGWryoTdwyOgLixiTcErwp4AQWch3PXeXhBSJ896PWw4VnxxYBwo+
   9L8aBcFoopKVmdBRbZgVUtFhqx7jAYSWtsPt2Oy2fpVJ0o4gTHomN7iZJ
   2zAM9c8Hocj7Abl0cyMB5Bmr1ojJOD2bi/MBODAr5lOAd2kIlEeYQzIdg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372127091"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="372127091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="719984424"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="719984424"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:41:16 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Daniel Gabay <daniel.gabay@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 12/15] wifi: iwlwifi: pcie: fix possible NULL pointer dereference
Date:   Thu, 13 Apr 2023 21:40:32 +0300
Message-Id: <20230413213309.082f6e21341b.I0db21d7fa9a828d571ca886713bd0b5d0b6e1e5c@changeid>
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

It is possible that iwl_pci_probe() will fail and free the trans,
then afterwards iwl_pci_remove() will be called and crash by trying
to access trans which is already freed, fix it.

iwlwifi 0000:01:00.0: Detected crf-id 0xa5a5a5a2, cnv-id 0xa5a5a5a2
		      wfpm id 0xa5a5a5a2
iwlwifi 0000:01:00.0: Can't find a correct rfid for crf id 0x5a2
...
BUG: kernel NULL pointer dereference, address: 0000000000000028
...
RIP: 0010:iwl_pci_remove+0x12/0x30 [iwlwifi]
pci_device_remove+0x3e/0xb0
device_release_driver_internal+0x103/0x1f0
driver_detach+0x4c/0x90
bus_remove_driver+0x5c/0xd0
driver_unregister+0x31/0x50
pci_unregister_driver+0x40/0x90
iwl_pci_unregister_driver+0x15/0x20 [iwlwifi]
__exit_compat+0x9/0x98 [iwlwifi]
__x64_sys_delete_module+0x147/0x260

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 70f6c59eec5d..a60329079167 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1733,6 +1733,9 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 {
 	struct iwl_trans *trans = pci_get_drvdata(pdev);
 
+	if (!trans)
+		return;
+
 	iwl_drv_stop(trans->drv);
 
 	iwl_trans_pcie_free(trans);
-- 
2.38.1

