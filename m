Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E0978EF5F
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 16:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjHaOOV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbjHaOOU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 10:14:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331F110D2
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 07:14:01 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rc34L2bC7zVk7K;
        Thu, 31 Aug 2023 22:11:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 22:13:57 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <gregory.greenman@intel.com>, <kvalo@kernel.org>,
        <briannorris@chromium.org>, <nbd@nbd.name>, <lorenzo@kernel.org>,
        <ryder.lee@mediatek.com>, <shayne.chen@mediatek.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <avraham.stern@intel.com>, <johannes.berg@intel.com>,
        <emmanuel.grumbach@intel.com>, <trix@redhat.com>,
        <dmantipov@yandex.ru>, <christophe.jaillet@wanadoo.fr>,
        <yangyang@marvell.com>, <linville@tuxdriver.com>,
        <rramesh@marvell.com>, <akarwar@marvell.com>,
        <nishants@marvell.com>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH net 1/3] wifi: iwlwifi: mei: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date:   Thu, 31 Aug 2023 22:13:45 +0800
Message-ID: <20230831141347.3166988-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831141347.3166988-1-ruanjinjie@huawei.com>
References: <20230831141347.3166988-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since debugfs_create_dir() returns ERR_PTR and never return NULL, So use
IS_ERR() to check it instead of checking NULL.

Fixes: 4ea7da5fad43 ("iwlwifi: mei: add debugfs hooks")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 1dd9106c6513..d0438f9a9ab8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1894,7 +1894,7 @@ static void iwl_mei_dbgfs_register(struct iwl_mei *mei)
 {
 	mei->dbgfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
-	if (!mei->dbgfs_dir)
+	if (IS_ERR(mei->dbgfs_dir))
 		return;
 
 	debugfs_create_ulong("status", S_IRUSR,
-- 
2.34.1

