Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807CB65FAD8
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 06:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjAFFGr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 00:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjAFFGq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 00:06:46 -0500
Received: from out20-85.mail.aliyun.com (out20-85.mail.aliyun.com [115.124.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDA6AD86
        for <linux-wireless@vger.kernel.org>; Thu,  5 Jan 2023 21:06:43 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5151947|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0646523-0.00917353-0.926174;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QlgjGTM_1672981569;
Received: from localhost.localdomain(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QlgjGTM_1672981569)
          by smtp.aliyun-inc.com;
          Fri, 06 Jan 2023 13:06:10 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Aiden Leong <aiden.leong@aibsd.com>
Subject: [PATCH v2] wifi: iwlwifi: pcie: add support for AX101NGW
Date:   Fri,  6 Jan 2023 13:05:48 +0800
Message-Id: <20230106050548.9112-1-aiden.leong@aibsd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a bug introduced by: 
commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
 config table"), so now we pick the FIRST matching config.

Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
---

I split patchset v1 to two standalone patches, since there are not that
strongly related to each other.

---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index a46df1320372..5d74adbd49cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1461,7 +1461,7 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 	if (!num_devices)
 		return NULL;
 
-	for (i = num_devices - 1; i >= 0; i--) {
+	for (i = 0; i < num_devices; i++) {
 		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
 
 		if (dev_info->device != (u16)IWL_CFG_ANY &&
-- 
2.39.0

