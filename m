Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E21A77AFC3
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Aug 2023 04:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjHNC4V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Aug 2023 22:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjHNC4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Aug 2023 22:56:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3498E6A;
        Sun, 13 Aug 2023 19:56:05 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RPJpj3WqsztQSL;
        Mon, 14 Aug 2023 10:52:29 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 14 Aug
 2023 10:56:02 +0800
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
Subject: [PATCH net-next v3 4/5] net: qualcomm: Remove redundant of_match_ptr()
Date:   Mon, 14 Aug 2023 10:55:18 +0800
Message-ID: <20230814025520.2708714-5-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814025520.2708714-2-ruanjinjie@huawei.com>
References: <20230814025520.2708714-2-ruanjinjie@huawei.com>
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
---
 drivers/net/ethernet/qualcomm/qca_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_uart.c b/drivers/net/ethernet/qualcomm/qca_uart.c
index ace99c62d03a..9adec91f35e9 100644
--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -403,7 +403,7 @@ static struct serdev_device_driver qca_uart_driver = {
 	.remove = qca_uart_remove,
 	.driver = {
 		.name = QCAUART_DRV_NAME,
-		.of_match_table = of_match_ptr(qca_uart_of_match),
+		.of_match_table = qca_uart_of_match,
 	},
 };
 
-- 
2.34.1

