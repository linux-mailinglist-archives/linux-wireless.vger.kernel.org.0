Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7D06740A9
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 19:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjASSOU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 13:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjASSOR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 13:14:17 -0500
Received: from out28-85.mail.aliyun.com (out28-85.mail.aliyun.com [115.124.28.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E2B31E3D
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 10:14:14 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.7011433|0.3114834;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.0680655-0.00441412-0.92752;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047199;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QxTNeYW_1674152049;
Received: from localhost.localdomain(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QxTNeYW_1674152049)
          by smtp.aliyun-inc.com;
          Fri, 20 Jan 2023 02:14:10 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Aiden Leong <aiden.leong@aibsd.com>
Subject: [PATCH v2] wifi: iwlwifi: pcie: disable tx_with_siso_diversity for AX101NGW
Date:   Fri, 20 Jan 2023 02:13:57 +0800
Message-Id: <20230119181357.1786-1-aiden.leong@aibsd.com>
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

AX101NGW has only one antenna, so we should disable
tx_with_siso_diversity for it.

Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 99768d6a6032..60f0c7e8248b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -990,7 +990,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
+		      iwl_cfg_quz_a0_hr_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-- 
2.39.0

