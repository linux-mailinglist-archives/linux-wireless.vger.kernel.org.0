Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963777B8583
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 18:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243405AbjJDQkt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 12:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbjJDQks (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 12:40:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28297EA
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 09:40:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMTiRl7+IhFFCSPpUYlMe79Zr6L9zoGolodbnvY+lgFKEbHNQ7eJ8AKenr0v8/YxsIw3CQfYd9ZxuyyMvH/ngDMzY++5M0/e9KRFUzeVVxAG9V2al6G2KsMljV+c1ye9IqkPoy+Ao9rmhIBqX6BW8dOoL2xhypRqOrdDSBl42csGNsp2NOfj+YCXaIG2+/WEIaAm9r9ibOSAp2jmrL72jSKEwAat0hyTq0MnJ+jkRalL6xQ8GhO2a4AxDUJ0OKmATxHb+OGmVRJifRfGy79hnebP+KnZpSgW1kI78RnG399V5XskNqJdfZs5L88E3vhMdjkZy/3YvZHBzTuejrUq8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiRjXGL3MBpfwribfmN0gJuJl03M5829tphIPpD7np8=;
 b=hNT92vYEdSfS3A5oNkijaZ+o0TVuXm7nJUPlE1Jh1qw0NZpcb/P16W4Fi1Kq/f3/Cc1ZeOlYBUTx10PRKVCXlrKL8YpHe+Nd1VCwQ7OaO8wHzI5Qzsqx5ujEaAg+LEK1FS5lpi8jeus6Joub2omR9iVOJVQmyYsCeNhcQpCT39KX79dJ8W3NAyVf9HOIxrUp1o2QPkypIr5suHQCNFrRtwV+g25qsDtBvCdADfxdpogQoVettcaj2WkzZWuleFcErxIeqD/Cd8UUkBUL7xIxvP5i5sEH5BaoXYFqBFr7dQUoXecPzGMiCL8urYhmD8UbIFnS62ugR9kZILLBlSBsvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiRjXGL3MBpfwribfmN0gJuJl03M5829tphIPpD7np8=;
 b=H6Jb+yph3M6siWukCEdf1JGzlJybE57a0ci33Ga3TjTa5ZN1RVUkXW1aKFmlW11uSOLy7bmYzLuo8TyrbM/FFgAquhBwTJRX4BoOkjZr3DgiXVBlZavcBHD5vVC3TkVcI59QhBcWPdyncUdYHV1aOcYPaE9lLCGJl3ncMg3jSg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBAPR04MB7477.eurprd04.prod.outlook.com (2603:10a6:10:1a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 16:40:42 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::cc84:fc7a:cffe:985a%7]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 16:40:42 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     linux-wireless@vger.kernel.org
Cc:     p.zabel@pengutronix.de, Josua Mayer <josua@solid-run.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        Rhyland Klein <rklein@nvidia.com>
Subject: [PATCH] net: rfkill: gpio: prevent value glitch during probe
Date:   Wed,  4 Oct 2023 18:39:28 +0200
Message-Id: <20231004163928.14609-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0137.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::16) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DBAPR04MB7477:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1290f7-0221-49e4-2e8b-08dbc4f8a63c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nG1z8ksnGUOBIM4xrX0YHRvVHxSxBQeGVcMzErXzh6tcs3nkQORVbRRMdGZ6ypzbu7fX6j2VFLXXAS6n2W406BedbNHw42Hvcba3kpAIcBcP77yKiKO+/vGEin90weusNx0O2NXKqvmXxsL+vHmKsXV88jQtIBsXOYO5ZkScTyNdjiRZ73Sao+VqDQDMLR2pc6fkvMRtvEm7hxbA3APx+hHtUG8caSEUULlsIUeqbHVNSB2KvjySvn93S8e9Cbr1uUb/nzEbJUtKXRdlOOvwLGfwztbOsMSfeddUBuG+SVO4EmNfVAax0NR85Kodaan1eNZdyc/uDVZlJUnUlaVEDE35jWGbxIXpfr2qMpMZZyCgV7xigajuJb6yMs0BX6ijOIZ07HhVideEPvq8GgiOh+vEP+/0H7G1abqOgYdHq+THVrwuqH7Ghl3jAQwCvIRHjYHhUYUKT7NflM7dqLEZy9YPrmvAoOPs2phO+Gh0dfHbi5QFubEi30EPGylyRQ+VhoT/ec5p4xze0SMqtz0FlWec2nJNPatwEeF3mpBV2HggEQJGH/Z8pWIOXYftYQpaeSNIyeICgzsyyXH+7qw/vdV1j5D90fW31oFhQw/Fwj0Uw9ceNQb0+rs05COZBXA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39830400003)(136003)(396003)(376002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(478600001)(6506007)(52116002)(6666004)(6512007)(6486002)(83380400001)(1076003)(26005)(2616005)(2906002)(6916009)(316002)(54906003)(5660300002)(8936002)(66946007)(66556008)(8676002)(4326008)(41300700001)(36756003)(66476007)(38100700002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GT1LB8t3EvvYnN+jjz7RAbBAydf4wmXMuRr4RJuN5c3xIXWsJbQ9qa/jeInN?=
 =?us-ascii?Q?kuUDHognuy8ZsDoSfD228AfUtRBTHetdP3V7kvQ9lGpvVVzUBiE6cbptjJ+D?=
 =?us-ascii?Q?dsMi6QL+xlRyrIYt0IJ+QOu3Ar+L3K90FfNfDZDgqkSNlVEiOpDlDBR6wtIa?=
 =?us-ascii?Q?6hKQxCQEfC+5qtQ3RonQhnam7cfmLYVq5aV5PcNs4GX+C5I5/6iylo7eEhXb?=
 =?us-ascii?Q?LasLoGuwBt9bSBOn10b5bzOC/GeqVbRCv3ZIrJe3YEomMUW3lJyMJLg+f8uJ?=
 =?us-ascii?Q?D6bv5jlevROrLU78vbzcktdxW9/BJ6qWjViBLV4AO3mN9CjKDkUBGiHcy9dH?=
 =?us-ascii?Q?un3weWcdpQ0WuEbdv/BudPMITZgsZY+sgTMR5xDL9+vEQ9wd8s5p7gR19Wnz?=
 =?us-ascii?Q?OZo20BoMSfKKAxAm8l1Nr0bl/34/H/RlH8NSTaQCgZ89+tyG02P6JzErIUyB?=
 =?us-ascii?Q?HHB1ZG7ycnzBMC39zAyEat9c56Syo4ICZwKPF/ZJlWbQTOe6Nvy2ZxEA0MA/?=
 =?us-ascii?Q?G+Ly3S3g0uFfqcR9I9hEOav629kPj70g+6WGf+DjuPPVG24oCmTngg01G5Nx?=
 =?us-ascii?Q?LbLd/tDSMEgnqmSx4BkcJGhfdpwcdmx9ESXlAxLnuFELTDdG9RRYRTpzRoNb?=
 =?us-ascii?Q?BczGNIrB9iDlTsU2TEEDXsY/rd3xBfCdiHzwTED3EbAYwMQ2Y9dg9RuJmr8N?=
 =?us-ascii?Q?dFy/lks4eyUfbOp3lfA3HcnuXbAGhyGVtN4XCQvAdl3GjlvUIjoGMmfR7kOk?=
 =?us-ascii?Q?Ju9eVyXB4tgpyELCcFgoARgW9k+/b2DvIBH8v2YHChf9t4sA+5mfKZKhWVJn?=
 =?us-ascii?Q?y4s+LyW5KweBReyweg01wZEs2/0HbahkTt7YYwbK5W+239nJIh81pGXo6mB5?=
 =?us-ascii?Q?9vDXsNWYxwVDWUj+pCXYkMTWP0WeRhdYqjavGgKfRf2QQ/oC6XBDudVXXm7H?=
 =?us-ascii?Q?hpuPexm4J2zjzqNr86oK01kFSKosdUl1+QpyOfyB2HQRaE9CD+ag85RxvEbW?=
 =?us-ascii?Q?QWvLyUBgCLNBBLXRj4I3iOWSVPcoof6R5ffQhvu10Tmax/2JxnHGLc6hgIQG?=
 =?us-ascii?Q?XT093YaFP/0B6g3ZY5hNIRpTSabYtWTYOHnVKz80a6QR10M8eobD8Wo43N+R?=
 =?us-ascii?Q?gy6VL30xODnfYhFPiA2BdFYEm/jcGj9innPlvgV0XGbKVBtBgnwReMk+hj9U?=
 =?us-ascii?Q?iPEGCIlut+ndr4vbEKjCl7BSRf5OyxrlZ1GddvNKlBQR24TDzWqP42FEhB+K?=
 =?us-ascii?Q?QuujGOMzss+JLkcjlHCB8HepJoQ2wNC3iSa9BMmiDc0zLNJbNGHjBXDQzzFL?=
 =?us-ascii?Q?ARXCNJ2ntJTUtHeZ55zNXu1b6+DFNHAsWSYz2bEFBZmgikgVJWzRoeAnwsWj?=
 =?us-ascii?Q?LXsqLkg8RBAyIbMFfiCvmLUiZQqC3QZya3pCL3avxyI17LZY5ixO8WyAUJUP?=
 =?us-ascii?Q?lfg8EyfZ/adYocD5r1VGRIW2jyZYe3xiR0UaBE8f7ywAWg43bX6+Z8EYxDXG?=
 =?us-ascii?Q?D+HHNLuQrggItG7fxKWjyiWCUj58rtzLTMbHqYUzkkbTpC/9gEhW+hvmIAdg?=
 =?us-ascii?Q?Vxm9iwmdv4VX8hxyRSE/jcZQNfQ6ifkFvWa5bz6k?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1290f7-0221-49e4-2e8b-08dbc4f8a63c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 16:40:42.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3GVBnWDl/JcI69aBrQFTbsN0MapVhioleVgFBvlfFZEmSOvk+crBU1I6x6+pm/PGNuS8nfwxMIGX9ahXGV2EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7477
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When either reset- or shutdown-gpio have are initially deasserted,
e.g. after a reboot - or when the hardware does not include pull-down,
there will be a short toggle of both IOs to logical 0 and back to 1.

It seems that the rfkill default is unblocked, so the driver should not
glitch to output low during probe.
It can lead e.g. to unexpected lte modem reconnect:

[1] root@localhost:~# dmesg | grep "usb 2-1"
[    2.136124] usb 2-1: new SuperSpeed USB device number 2 using xhci-hcd
[   21.215278] usb 2-1: USB disconnect, device number 2
[   28.833977] usb 2-1: new SuperSpeed USB device number 3 using xhci-hcd

The glitch has been discovered on an arm64 board, now that device-tree
support for the rfkill-gpio driver has finally appeared :).

Change the flags for devm_gpiod_get_optional from GPIOD_OUT_LOW to
GPIOD_ASIS to avoid any glitches.
The rfkill driver will set the intended value during rfkill_sync_work.

Fixes: 7176ba23f8b5 ("net: rfkill: add generic gpio rfkill driver")
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 net/rfkill/rfkill-gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index e9d1b2f2ff0a..5a81505fba9a 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -108,13 +108,13 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 
 	rfkill->clk = devm_clk_get(&pdev->dev, NULL);
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
 	rfkill->reset_gpio = gpio;
 
-	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_OUT_LOW);
+	gpio = devm_gpiod_get_optional(&pdev->dev, "shutdown", GPIOD_ASIS);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
-- 
2.35.3

