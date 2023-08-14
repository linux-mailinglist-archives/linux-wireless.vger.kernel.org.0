Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E6477AFC1
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 04:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjHNC4U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Aug 2023 22:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjHNC4B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Aug 2023 22:56:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1998E65;
        Sun, 13 Aug 2023 19:56:00 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RPJpg74lFzNn9T;
        Mon, 14 Aug 2023 10:52:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 10:55:57 +0800
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
Subject: [PATCH net-next v3 1/5] net: dsa: realtek: Remove redundant of_match_ptr()
Date:   Mon, 14 Aug 2023 10:55:15 +0800
Message-ID: <20230814025520.2708714-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/realtek/realtek-mdio.c | 2 +-
 drivers/net/dsa/realtek/realtek-smi.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/realtek-mdio.c b/drivers/net/dsa/realtek/realtek-mdio.c
index 4310e7793e58..292e6d087e8b 100644
--- a/drivers/net/dsa/realtek/realtek-mdio.c
+++ b/drivers/net/dsa/realtek/realtek-mdio.c
@@ -276,7 +276,7 @@ MODULE_DEVICE_TABLE(of, realtek_mdio_of_match);
 static struct mdio_driver realtek_mdio_driver = {
 	.mdiodrv.driver = {
 		.name = "realtek-mdio",
-		.of_match_table = of_match_ptr(realtek_mdio_of_match),
+		.of_match_table = realtek_mdio_of_match,
 	},
 	.probe  = realtek_mdio_probe,
 	.remove = realtek_mdio_remove,
diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index c2bd8bb6c9c2..ff13563059c5 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -556,7 +556,7 @@ MODULE_DEVICE_TABLE(of, realtek_smi_of_match);
 static struct platform_driver realtek_smi_driver = {
 	.driver = {
 		.name = "realtek-smi",
-		.of_match_table = of_match_ptr(realtek_smi_of_match),
+		.of_match_table = realtek_smi_of_match,
 	},
 	.probe  = realtek_smi_probe,
 	.remove = realtek_smi_remove,
-- 
2.34.1

