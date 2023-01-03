Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D5D65BA1A
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 05:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbjACEml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Jan 2023 23:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjACEmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Jan 2023 23:42:40 -0500
Received: from out20-86.mail.aliyun.com (out20-86.mail.aliyun.com [115.124.20.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E76626F
        for <linux-wireless@vger.kernel.org>; Mon,  2 Jan 2023 20:42:34 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2781789|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0780417-0.000864095-0.921094;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.Qj6ro8W_1672720950;
Received: from localhost.localdomain(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.Qj6ro8W_1672720950)
          by smtp.aliyun-inc.com;
          Tue, 03 Jan 2023 12:42:32 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Aiden Leong <aiden.leong@aibsd.com>
Subject: [PATCH] iwlwifi: pcie: fix an indent error reported by checkpatch.pl
Date:   Tue,  3 Jan 2023 12:41:57 +0800
Message-Id: <20230103044157.7636-1-aiden.leong@aibsd.com>
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

ERROR: switch and case should be at the same indent
+	switch (REG_CRF_ID_TYPE(val)) {
[...]
+		case REG_CRF_ID_TYPE_FM:

We should use Git post-commit hooks to avoid such errors.

Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 99768d6a6032..eabbab488e1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1416,9 +1416,9 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	case REG_CRF_ID_TYPE_MR:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_MR << 12);
 		break;
-		case REG_CRF_ID_TYPE_FM:
-			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
-			break;
+	case REG_CRF_ID_TYPE_FM:
+		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
+		break;
 	default:
 		ret = -EIO;
 		IWL_ERR(iwl_trans,
-- 
2.39.0

