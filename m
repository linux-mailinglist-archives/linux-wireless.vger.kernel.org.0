Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8D0777263
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Aug 2023 10:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjHJILy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Aug 2023 04:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjHJILx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Aug 2023 04:11:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24161BCF;
        Thu, 10 Aug 2023 01:11:50 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM03Y2QGrzkX7k;
        Thu, 10 Aug 2023 16:10:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 16:11:45 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <linus.walleij@linaro.org>, <alsi@bang-olufsen.dk>,
        <andrew@lunn.ch>, <f.fainelli@gmail.com>, <olteanv@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <clement.leger@bootlin.com>,
        <ulli.kroll@googlemail.com>, <kvalo@kernel.org>,
        <bhupesh.sharma@linaro.org>, <robh@kernel.org>, <elder@linaro.org>,
        <wei.fang@nxp.com>, <nicolas.ferre@microchip.com>,
        <simon.horman@corigine.com>, <romieu@fr.zoreil.com>,
        <dmitry.torokhov@gmail.com>, <netdev@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [patch net-next 5/5] wlcore: spi: Remove redundant of_match_ptr()
Date:   Thu, 10 Aug 2023 16:11:02 +0800
Message-ID: <20230810081102.2981505-6-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810081102.2981505-1-ruanjinjie@huawei.com>
References: <20230810081102.2981505-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/wireless/ti/wlcore/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/spi.c b/drivers/net/wireless/ti/wlcore/spi.c
index 3f88e6a0a510..7d9a139db59e 100644
--- a/drivers/net/wireless/ti/wlcore/spi.c
+++ b/drivers/net/wireless/ti/wlcore/spi.c
@@ -554,7 +554,7 @@ static void wl1271_remove(struct spi_device *spi)
 static struct spi_driver wl1271_spi_driver = {
 	.driver = {
 		.name		= "wl1271_spi",
-		.of_match_table = of_match_ptr(wlcore_spi_of_match_table),
+		.of_match_table = wlcore_spi_of_match_table,
 	},
 
 	.probe		= wl1271_probe,
-- 
2.34.1

