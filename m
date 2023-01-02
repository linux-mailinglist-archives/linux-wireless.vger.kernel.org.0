Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D42765ACE0
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 03:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjABCkc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 21:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABCkc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 21:40:32 -0500
Received: from out20-135.mail.aliyun.com (out20-135.mail.aliyun.com [115.124.20.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75F9DEF
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 18:40:30 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.693145|0.3908663;BR=01201311R361S06rulernew998_84748_2000303;CH=blue;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.0129092-0.000629568-0.986461;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QiPcDg-_1672627227;
Received: from localhost.localdomain(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QiPcDg-_1672627227)
          by smtp.aliyun-inc.com;
          Mon, 02 Jan 2023 10:40:28 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Aiden Leong <aiden.leong@aibsd.com>
Subject: [PATCH 1/2] iwlwifi: pcie: add support for AX101NGW
Date:   Mon,  2 Jan 2023 10:40:21 +0800
Message-Id: <20230102024021.2900-1-aiden.leong@aibsd.com>
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

AX101NGW(0x4DF0, 0x0244) should have tx_with_siso_diversity unset.

Signed-off-by: Aiden Leong <aiden.leong@aibsd.com>
---
Ref Commit: 9352ed0165ff4313ab340c979446c3d64c531f7a
Tested on my own device.
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 99768d6a6032..a46df1320372 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -986,6 +986,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      iwl_qu_c0_hr_b0, iwl_ax201_name),
 
 	/* QuZ */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_RF_ID_HR1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_quz_a0_hr_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-- 
2.39.0

