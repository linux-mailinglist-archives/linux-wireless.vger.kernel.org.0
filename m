Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E513B6222E0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 04:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKIDza (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Nov 2022 22:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKIDz3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Nov 2022 22:55:29 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B38175B4;
        Tue,  8 Nov 2022 19:55:28 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N6WMT4pJKzRp1R;
        Wed,  9 Nov 2022 11:55:17 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 11:55:26 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <gregory.greenman@intel.com>, <kvalo@kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <luciano.coelho@intel.com>,
        <johannes.berg@intel.com>, <haim.dreyfuss@intel.com>,
        <mordechay.goodstein@intel.com>, <emmanuel.grumbach@intel.com>,
        <michael.golant@intel.com>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] wifi: iwlwifi: Fix memory leak in iwl_mvm_init()
Date:   Wed, 9 Nov 2022 11:52:13 +0800
Message-ID: <20221109035213.570-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When iwl_opmode_register() fails, it does not unregster rate control,
which will cause a memory leak issue, this patch fixes it.

Fixes: 9f66a397c877 ("iwlwifi: mvm: rs: add ops for the new rate scaling in the FW")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index d2d42cd48af2..8374c2c3d31b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -64,8 +64,10 @@ static int __init iwl_mvm_init(void)
 	}
 
 	ret = iwl_opmode_register("iwlmvm", &iwl_mvm_ops);
-	if (ret)
+	if (ret) {
 		pr_err("Unable to register MVM op_mode: %d\n", ret);
+		iwl_mvm_rate_control_unregister();
+	}
 
 	return ret;
 }
-- 
2.17.1

