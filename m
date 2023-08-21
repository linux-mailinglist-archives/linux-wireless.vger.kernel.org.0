Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA70782B25
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 16:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235655AbjHUOEH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 10:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjHUOEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 10:04:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CBFF4
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 07:04:02 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RTvLc23dkzrSdq;
        Mon, 21 Aug 2023 22:02:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 22:03:59 +0800
From:   Li Zetao <lizetao1@huawei.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <lizetao1@huawei.com>
Subject: [PATCH -next v2] wifi: wlcore: sdio: Use module_sdio_driver macro to simplify the code
Date:   Mon, 21 Aug 2023 22:03:45 +0800
Message-ID: <20230821140345.3140493-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87350ck14c.fsf@kernel.org>
References: <87350ck14c.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the module_sdio_driver macro to simplify the code, which is the
same as declaring with module_init() and module_exit().

Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Add "wifi:" to the subject.
v1: https://lore.kernel.org/all/20230815075419.1067635-1-lizetao1@huawei.com/

 drivers/net/wireless/ti/wlcore/sdio.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ti/wlcore/sdio.c b/drivers/net/wireless/ti/wlcore/sdio.c
index cf8d909fa826..f0686635db46 100644
--- a/drivers/net/wireless/ti/wlcore/sdio.c
+++ b/drivers/net/wireless/ti/wlcore/sdio.c
@@ -442,18 +442,7 @@ static struct sdio_driver wl1271_sdio_driver = {
 #endif
 };
 
-static int __init wl1271_init(void)
-{
-	return sdio_register_driver(&wl1271_sdio_driver);
-}
-
-static void __exit wl1271_exit(void)
-{
-	sdio_unregister_driver(&wl1271_sdio_driver);
-}
-
-module_init(wl1271_init);
-module_exit(wl1271_exit);
+module_sdio_driver(wl1271_sdio_driver);
 
 module_param(dump, bool, 0600);
 MODULE_PARM_DESC(dump, "Enable sdio read/write dumps.");
-- 
2.34.1

