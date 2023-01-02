Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C494065ACDF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 03:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjABClG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 21:41:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABClF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 21:41:05 -0500
Received: from out20-158.mail.aliyun.com (out20-158.mail.aliyun.com [115.124.20.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37C1E4
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 18:41:02 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.6833171|0.4098935;BR=01201311R111S53rulernew998_84748_2000303;CH=blue;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.0478166-0.0144264-0.937757;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QiQDyiI_1672627239;
Received: from localhost.localdomain(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QiQDyiI_1672627239)
          by smtp.aliyun-inc.com;
          Mon, 02 Jan 2023 10:40:40 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Aiden Leong <aiden.leong@aibsd.com>
Subject: [PATCH 2/2] iwlwifi: pcie: add support for AX101NGW
Date:   Mon,  2 Jan 2023 10:40:38 +0800
Message-Id: <20230102024038.2915-1-aiden.leong@aibsd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Revert:
commit 3f7320428fa4 ("iwlwifi: pcie: simplify iwl_pci_find_dev_info()") 

A bug was introduced by:
commit 32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new
config table"), 
where a goto statement was removed.

Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
---
Notice:
Please run further tests before merging. I'm NOT familiar with device
drivers.
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

