Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9277B76FD18
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Aug 2023 11:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjHDJUE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Aug 2023 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjHDJTh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Aug 2023 05:19:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDF25580
        for <linux-wireless@vger.kernel.org>; Fri,  4 Aug 2023 02:16:07 -0700 (PDT)
Received: from dggpemm100024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHKjX2wvWzNm4v;
        Fri,  4 Aug 2023 17:12:16 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100024.china.huawei.com (7.185.36.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 17:15:42 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 17:15:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>
CC:     <kvalo@kernel.org>, <quic_jjohnson@quicinc.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] wifi: ath11k: simplify the code with module_platform_driver
Date:   Fri, 4 Aug 2023 17:12:55 +0800
Message-ID: <20230804091255.1347178-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The init/exit() of driver only calls platform_driver_register/unregister,
it can be simpilfied with module_platform_driver.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 139da578831a..1074b0828de1 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -1331,17 +1331,7 @@ static struct platform_driver ath11k_ahb_driver = {
 	.shutdown = ath11k_ahb_shutdown,
 };
 
-static int ath11k_ahb_init(void)
-{
-	return platform_driver_register(&ath11k_ahb_driver);
-}
-module_init(ath11k_ahb_init);
-
-static void ath11k_ahb_exit(void)
-{
-	platform_driver_unregister(&ath11k_ahb_driver);
-}
-module_exit(ath11k_ahb_exit);
+module_platform_driver(ath11k_ahb_driver);
 
 MODULE_DESCRIPTION("Driver support for Qualcomm Technologies 802.11ax WLAN AHB devices");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

