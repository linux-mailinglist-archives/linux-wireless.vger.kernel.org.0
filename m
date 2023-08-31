Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FDA78EF62
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Aug 2023 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346390AbjHaOOl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Aug 2023 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345681AbjHaOOk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Aug 2023 10:14:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7B2110
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 07:14:11 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rc35J4wfMzrSQs;
        Thu, 31 Aug 2023 22:12:20 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 22:14:00 +0800
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
Subject: [PATCH net 3/3] wifi: mt76: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date:   Thu, 31 Aug 2023 22:13:47 +0800
Message-ID: <20230831141347.3166988-4-ruanjinjie@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since debugfs_create_dir() returns ERR_PTR and never return NULL, So use
IS_ERR() to check it instead of checking NULL.

Fixes: 17f1de56df05 ("mt76: add common code shared between multiple chipsets")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 57fbcc83e074..d9ba700131fd 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -109,7 +109,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("mt76", phy->hw->wiphy->debugfsdir);
-	if (!dir)
+	if (IS_ERR(dir))
 		return NULL;
 
 	debugfs_create_u8("led_pin", 0600, dir, &phy->leds.pin);
-- 
2.34.1

