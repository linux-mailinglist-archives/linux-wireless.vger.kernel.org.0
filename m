Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98533AB8BC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhFQQKK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:10 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:14471
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231955AbhFQQJG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXmI3LTC+Yuw+WZVr/lfMPvZu8UGyZn/GlH5hgji2QHPfCOMEDeLN1B5v2TGymRbPvtwTfxOvpYCwJhlP3p2Q+H7ZnzCvks9etPM9+gdC26T9h7jDGXRhTd7Ys3x1uk/6rMR+iJYYeOtsV/Nd+PXbIPSgCNDPsc8MBNUgk8rZIuCWwY58k7ZpHwOEArfH2oZ9axD6Ym+Ex5BlS7scLatU7s8/6fLEPAstyxhyXTV6VkB6BCWlHG4oWEN6adRQlOc6BRLJ740TCwlBuHDYB2DogI0bJA3z2TldNuriT9rTCud7t4J0xojvQdYNinEQWF/hCrPRAEvk9JvyNUYeeng6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0eLuRQAHkzqRzY+NvwNnzoh61qFq2KPoCLEpRUFO4Q=;
 b=Zi8CFU0zF4uPKexjk3EELdwvCZPeBRwMw3XT0VVLxj0ubOGDu3iqe90OysAHjsszSikGx+FLykZTYFf3ZOkbGO4g9qPgcuUJ8qeEHxb6gIsab2b4bBc6mFqLZe+SmSYBN/W6KmpTN3N2o2d1R9XAlQigd2JJKUxwcs9zgJ94ERzUnwr+HKawVhJ1J/0PGRTUYLVzX352ubGu6peMCNGpDMA/bTAytrDRUOEoPe42bqVBy4NImg+S2yUvzrtoF0EdZaV035e5fOIQGAxTj1gFYwxeY/QpmiKvYQn6Z1/xrJE88JY5hERhuxl83McrnDn7ack34ecHeo8m5YHJisPdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0eLuRQAHkzqRzY+NvwNnzoh61qFq2KPoCLEpRUFO4Q=;
 b=yde1vPJzGBUSpwAq0feMdMbw4+9ZyBOvkNtf8+10jIFq1bS3viedSkcJOHlob2YdEX7SwtLwIZsdkmm2t7xcXaKyITR2KJ48290GN299effPrXhbnnZ77B3mnN6VhmV6iIyp1T6xPUE1Ul2NaqBpCmCNVfQ20/aKrmEz+7uO9g4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:25 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 153/256] cl8k: add reg/reg_io_ctrl.h
Date:   Thu, 17 Jun 2021 16:00:40 +0000
Message-Id: <20210617160223.160998-154-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8e2a7b5-caf2-4808-a1ac-08d931a9b5ee
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB118788DCB3E3FD731E431180F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: syUN/sMJIk5a/dcBtHjY3nS1P41xtInn0IKPJqKNGI2eH3fvy8QRjARFmjPG+GKUQDcBcj7nw19QL4C6uusFlvcpOq3RGUxlofznwM4ruawLmfeZDQ2qNWacbESkZUUFchATN52v2jDUvtuJh1+x5CywfA2I5XHzwvPrFScNhgxu/4fSH7aflFqw2CWx7ec+xJM6A4Na9lSjvqN11GIeL8GaFDUvZT3VarF9g3lfbqoiWN1ulUTJp+AsXmjPM7f7JKwKnsnYIouIC9Nyq9OKfRwW5dE0x9u2IcGWHt9q0VaOTnGiDs2VpFg7hPFQ/FPlGp5rnGPhRs4H7+2lWNMjwPy7+XzbKlhE2/74cb8zPLC+pOIg6NvcipfBFdEgh2EZghKaDU03iUvqD6fuN9hz0ac24rUSaVjKUbUcEb/7OC7yPeqBCnY9zlCckASiHf3JCFGume/biAYJBC4ZwJ2HGnxF1vsc+1SnSEty1tu8kGtTwBY72ywZ4bz44bAw6oyz2QOdQX2MYQEmraPOpuhYpqR/73DiGP6NOc0UfUtry+7P1WN8Jrm+Ncum4FOkT6+dgeyjv1XQJCke8De84j14jDnFSW/ALibgehkVpGrymS/mABxZrp8gzo3F9Pnm34+i91j+wIkmaPXuS1uWP+bHB4ORwC2JNmirUaFTRlMOaUvJPZ88VjLgbTwF7ApYt/NyyGl4taZ8gK9/J8ztG1aCtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(30864003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(498600001)(107886003)(69590400013)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fOce2VYE+rETWEeZpcy/XZxjpUcpe3hjjR5qZnTKDbRfr6kqg8jVMXMjWPjH?=
 =?us-ascii?Q?5EPbYdVFiA/4KgrUfadwti76FNx1SnggDngfbZk0LEoQfTNm8P/9OZRe4LPY?=
 =?us-ascii?Q?cwehkBJqHKaJ+GaxOGp9IUFI9/XPboCzcgS+gW+dtOVZJiYmA5Hs7i7mEdO1?=
 =?us-ascii?Q?6oxZjfgmrJ1/NnP7tkoXBIor47EhbR8wbQEEpjJffIbTtU602CO6vP57FYzC?=
 =?us-ascii?Q?m6pSclEKi/ZSEGkBdi79bXtlzEbrOYaDvTOxWYSTFIQ+HBPgSTIgiYBVpLWM?=
 =?us-ascii?Q?G/ET7XFaYWJtkEk3mbZhAidVVN9aQIs+5OjQ7XNowgfkT/mEigcBBagEo4gP?=
 =?us-ascii?Q?1NakuR9EdqPMC/IxeocB3V1oHs39LF6A8nkjZFEBg//UWpXvecIvWxTeRud9?=
 =?us-ascii?Q?gPbu53pBWPoEnX0i9+KaHqx+oUgS8YVy/gKTJp/zXfrQQHYvqlLkSo3HmxCc?=
 =?us-ascii?Q?6dgx2qh6VkA2Dj2BSR+Ob9mQtBTW6vsylmg5Wly4xLaXC31xwHGx6z5jfXTy?=
 =?us-ascii?Q?9ixq8uYHMFZvEiOxjYlbxCoOADFT8i+CHts6KLKBColk6fCOFtJ5djKdPZpR?=
 =?us-ascii?Q?vqEJ9MFzdNQEWXxbfz4rNiBlFaWzAdqN36dAStgg+rKiUXwYus8BNeU88FPJ?=
 =?us-ascii?Q?cHXutD0BypjbWmze8vYF0OIdXa6IS3KTYpbsJq8h6C2xssvk30fJHaJutlrN?=
 =?us-ascii?Q?VNsHoRcl4pkkVddswa+Nfi6YMkIkyYrCA1jw6C3oYWw4HqUKbdQ+khgQrpNS?=
 =?us-ascii?Q?nOitGhq4J8LYMsoh4mouAjRTVgYYvkysThDFVoetEtCWFFD8yf9MiLtS9nWm?=
 =?us-ascii?Q?VnrX61ygH7kbUDrmv6VFeLLgawkpDbg9dyNculxy+AB3EczNsr8NT7xyAjMB?=
 =?us-ascii?Q?1R2IUL8hc3ZdYhebmZ6pQENbRR1AgwcZ3EBUVbym+mjF17udkg3hQu+knOIo?=
 =?us-ascii?Q?IZNsbGaKqV0LlcK+fvS1WNk3CI53bLoOSe+RfDXuaeDxLsWdKSXBm2rw0owu?=
 =?us-ascii?Q?4B6oKWAClH6Jv5oNmnnKCVVUBWGHlkRkT8DvxRv5UmcvkRyvyROZcR9q1T+J?=
 =?us-ascii?Q?yRAcEsCRvRf03ONGFkWVzE4HnxPLmfMTr/aA4vF6fizt4qTGK1M3KludJd6S?=
 =?us-ascii?Q?DEsWp91v7IJ7nUOoCfnLRWRaHy1Co47gvc+aOzh36ykzPCRZGsdpeRdixSL9?=
 =?us-ascii?Q?dNpzqYBE0mDOlCYtW/z5p/B5/KM6UTXTTTuO+UWmn2rkCxfOHFCMIXHv68oU?=
 =?us-ascii?Q?79RcvlnojxMgRGA61Tq3CPyy4MsyVbxhwBBjXl0bBppzhz48JaVVvTmK8vCT?=
 =?us-ascii?Q?kii5LYTyV79bdBW7MpaEs8JJ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e2a7b5-caf2-4808-a1ac-08d931a9b5ee
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:22.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QoRyIru0LsV03EloflpDhWJiJf0LACfqlqUIgPYe4iTQ7YN8qARRYe5BSdPmTqKt3p3rO6Wtcm+tL5UK+kevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_io_ctrl.h    | 1223 +++++++++++++++++
 1 file changed, 1223 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_io_ctrl.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_io_ctrl.h b/drivers/n=
et/wireless/celeno/cl8k/reg/reg_io_ctrl.h
new file mode 100644
index 000000000000..190a7a98ebd3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_io_ctrl.h
@@ -0,0 +1,1223 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_IO_CTRL_H
+#define CL_REG_IO_CTRL_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "chip.h"
+
+#define REG_IO_CTRL_BASE_ADDR 0x007C7000
+
+/*
+ * @brief RX_ACTIVE_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000005=
C)
+#define IO_CTRL_RX_ACTIVE_0_OFFSET      0x0000005C
+#define IO_CTRL_RX_ACTIVE_0_INDEX       0x00000017
+#define IO_CTRL_RX_ACTIVE_0_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_0_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_0_ADDR, value);
+}
+
+/* Field definitions */
+#define IO_CTRL_RX_ACTIVE_0_GPIO_IN_BIT               ((u32)0x00002000)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_IN_POS               13
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OUT_BIT              ((u32)0x00001000)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OUT_POS              12
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OE_BIT               ((u32)0x00000800)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OE_POS               11
+#define IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_BIT           ((u32)0x00000400)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_POS           10
+#define IO_CTRL_RX_ACTIVE_0_INPUT_ENABLE_BIT          ((u32)0x00000200)
+#define IO_CTRL_RX_ACTIVE_0_INPUT_ENABLE_POS          9
+#define IO_CTRL_RX_ACTIVE_0_SLEW_RATE_BIT             ((u32)0x00000100)
+#define IO_CTRL_RX_ACTIVE_0_SLEW_RATE_POS             8
+#define IO_CTRL_RX_ACTIVE_0_DRIVER_PULL_STATE_MASK    ((u32)0x000000C0)
+#define IO_CTRL_RX_ACTIVE_0_DRIVER_PULL_STATE_LSB     6
+#define IO_CTRL_RX_ACTIVE_0_DRIVER_PULL_STATE_WIDTH   ((u32)0x00000002)
+#define IO_CTRL_RX_ACTIVE_0_OUTPUT_PAD_STRENGTH_MASK  ((u32)0x00000030)
+#define IO_CTRL_RX_ACTIVE_0_OUTPUT_PAD_STRENGTH_LSB   4
+#define IO_CTRL_RX_ACTIVE_0_OUTPUT_PAD_STRENGTH_WIDTH ((u32)0x00000002)
+#define IO_CTRL_RX_ACTIVE_0_SCHMIT_TRIGER_BIT         ((u32)0x00000008)
+#define IO_CTRL_RX_ACTIVE_0_SCHMIT_TRIGER_POS         3
+#define IO_CTRL_RX_ACTIVE_0_MUX_SELECT_MASK           ((u32)0x00000007)
+#define IO_CTRL_RX_ACTIVE_0_MUX_SELECT_LSB            0
+#define IO_CTRL_RX_ACTIVE_0_MUX_SELECT_WIDTH          ((u32)0x00000003)
+
+/*
+ * @brief RX_ACTIVE_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000006=
0)
+#define IO_CTRL_RX_ACTIVE_1_OFFSET      0x00000060
+#define IO_CTRL_RX_ACTIVE_1_INDEX       0x00000018
+#define IO_CTRL_RX_ACTIVE_1_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_1_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_1_ADDR, value);
+}
+
+/*
+ * @brief RX_ACTIVE_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000006=
4)
+#define IO_CTRL_RX_ACTIVE_2_OFFSET      0x00000064
+#define IO_CTRL_RX_ACTIVE_2_INDEX       0x00000019
+#define IO_CTRL_RX_ACTIVE_2_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_2_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_2_ADDR, value);
+}
+
+/*
+ * @brief RX_ACTIVE_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000006=
8)
+#define IO_CTRL_RX_ACTIVE_3_OFFSET      0x00000068
+#define IO_CTRL_RX_ACTIVE_3_INDEX       0x0000001A
+#define IO_CTRL_RX_ACTIVE_3_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_3_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_3_ADDR, value);
+}
+
+/*
+ * @brief RX_ACTIVE_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000006=
C)
+#define IO_CTRL_RX_ACTIVE_4_OFFSET      0x0000006C
+#define IO_CTRL_RX_ACTIVE_4_INDEX       0x0000001B
+#define IO_CTRL_RX_ACTIVE_4_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_4_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_4_ADDR, value);
+}
+
+/*
+ * @brief RX_ACTIVE_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000007=
0)
+#define IO_CTRL_RX_ACTIVE_5_OFFSET      0x00000070
+#define IO_CTRL_RX_ACTIVE_5_INDEX       0x0000001C
+#define IO_CTRL_RX_ACTIVE_5_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_5_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_5_ADDR, value);
+}
+
+/*
+ * @brief RX_ACTIVE_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000007=
4)
+#define IO_CTRL_RX_ACTIVE_6_OFFSET      0x00000074
+#define IO_CTRL_RX_ACTIVE_6_INDEX       0x0000001D
+#define IO_CTRL_RX_ACTIVE_6_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_6_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_6_ADDR, value);
+}
+
+/*
+ * @brief RX_ACTIVE_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000007=
8)
+#define IO_CTRL_RX_ACTIVE_7_OFFSET      0x00000078
+#define IO_CTRL_RX_ACTIVE_7_INDEX       0x0000001E
+#define IO_CTRL_RX_ACTIVE_7_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_7_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_7_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
7C)
+#define IO_CTRL_LNA_ENABLE_0_OFFSET      0x0000007C
+#define IO_CTRL_LNA_ENABLE_0_INDEX       0x0000001F
+#define IO_CTRL_LNA_ENABLE_0_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_0_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_0_ADDR, value);
+}
+
+/* Field definitions */
+#define IO_CTRL_LNA_ENABLE_0_GPIO_IN_BIT               ((u32)0x00002000)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_IN_POS               13
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OUT_BIT              ((u32)0x00001000)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OUT_POS              12
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OE_BIT               ((u32)0x00000800)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OE_POS               11
+#define IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_BIT           ((u32)0x00000400)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_POS           10
+#define IO_CTRL_LNA_ENABLE_0_INPUT_ENABLE_BIT          ((u32)0x00000200)
+#define IO_CTRL_LNA_ENABLE_0_INPUT_ENABLE_POS          9
+#define IO_CTRL_LNA_ENABLE_0_SLEW_RATE_BIT             ((u32)0x00000100)
+#define IO_CTRL_LNA_ENABLE_0_SLEW_RATE_POS             8
+#define IO_CTRL_LNA_ENABLE_0_DRIVER_PULL_STATE_MASK    ((u32)0x000000C0)
+#define IO_CTRL_LNA_ENABLE_0_DRIVER_PULL_STATE_LSB     6
+#define IO_CTRL_LNA_ENABLE_0_DRIVER_PULL_STATE_WIDTH   ((u32)0x00000002)
+#define IO_CTRL_LNA_ENABLE_0_OUTPUT_PAD_STRENGTH_MASK  ((u32)0x00000030)
+#define IO_CTRL_LNA_ENABLE_0_OUTPUT_PAD_STRENGTH_LSB   4
+#define IO_CTRL_LNA_ENABLE_0_OUTPUT_PAD_STRENGTH_WIDTH ((u32)0x00000002)
+#define IO_CTRL_LNA_ENABLE_0_SCHMIT_TRIGER_BIT         ((u32)0x00000008)
+#define IO_CTRL_LNA_ENABLE_0_SCHMIT_TRIGER_POS         3
+#define IO_CTRL_LNA_ENABLE_0_MUX_SELECT_MASK           ((u32)0x00000007)
+#define IO_CTRL_LNA_ENABLE_0_MUX_SELECT_LSB            0
+#define IO_CTRL_LNA_ENABLE_0_MUX_SELECT_WIDTH          ((u32)0x00000003)
+
+/*
+ * @brief LNA_ENABLE_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
80)
+#define IO_CTRL_LNA_ENABLE_1_OFFSET      0x00000080
+#define IO_CTRL_LNA_ENABLE_1_INDEX       0x00000020
+#define IO_CTRL_LNA_ENABLE_1_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_1_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_1_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
84)
+#define IO_CTRL_LNA_ENABLE_2_OFFSET      0x00000084
+#define IO_CTRL_LNA_ENABLE_2_INDEX       0x00000021
+#define IO_CTRL_LNA_ENABLE_2_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_2_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_2_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
88)
+#define IO_CTRL_LNA_ENABLE_3_OFFSET      0x00000088
+#define IO_CTRL_LNA_ENABLE_3_INDEX       0x00000022
+#define IO_CTRL_LNA_ENABLE_3_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_3_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_3_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
8C)
+#define IO_CTRL_LNA_ENABLE_4_OFFSET      0x0000008C
+#define IO_CTRL_LNA_ENABLE_4_INDEX       0x00000023
+#define IO_CTRL_LNA_ENABLE_4_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_4_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_4_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
90)
+#define IO_CTRL_LNA_ENABLE_5_OFFSET      0x00000090
+#define IO_CTRL_LNA_ENABLE_5_INDEX       0x00000024
+#define IO_CTRL_LNA_ENABLE_5_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_5_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_5_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
94)
+#define IO_CTRL_LNA_ENABLE_6_OFFSET      0x00000094
+#define IO_CTRL_LNA_ENABLE_6_INDEX       0x00000025
+#define IO_CTRL_LNA_ENABLE_6_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_6_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_6_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
98)
+#define IO_CTRL_LNA_ENABLE_7_OFFSET      0x00000098
+#define IO_CTRL_LNA_ENABLE_7_INDEX       0x00000026
+#define IO_CTRL_LNA_ENABLE_7_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_7_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_7_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_8 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_8_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
9C)
+#define IO_CTRL_LNA_ENABLE_8_OFFSET      0x0000009C
+#define IO_CTRL_LNA_ENABLE_8_INDEX       0x00000027
+#define IO_CTRL_LNA_ENABLE_8_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_8_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_8_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_9 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_9_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
A0)
+#define IO_CTRL_LNA_ENABLE_9_OFFSET      0x000000A0
+#define IO_CTRL_LNA_ENABLE_9_INDEX       0x00000028
+#define IO_CTRL_LNA_ENABLE_9_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_9_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_9_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_10 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_10_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000=
0A4)
+#define IO_CTRL_LNA_ENABLE_10_OFFSET      0x000000A4
+#define IO_CTRL_LNA_ENABLE_10_INDEX       0x00000029
+#define IO_CTRL_LNA_ENABLE_10_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_10_set(struct cl_chip *chip, u32 val=
ue)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_10_ADDR, value);
+}
+
+/*
+ * @brief LNA_ENABLE_11 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_11_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000=
0A8)
+#define IO_CTRL_LNA_ENABLE_11_OFFSET      0x000000A8
+#define IO_CTRL_LNA_ENABLE_11_INDEX       0x0000002A
+#define IO_CTRL_LNA_ENABLE_11_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_11_set(struct cl_chip *chip, u32 val=
ue)
+{
+       cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_11_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000A=
C)
+#define IO_CTRL_PA_ENABLE_0_OFFSET      0x000000AC
+#define IO_CTRL_PA_ENABLE_0_INDEX       0x0000002B
+#define IO_CTRL_PA_ENABLE_0_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_0_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_0_ADDR, value);
+}
+
+/* Field definitions */
+#define IO_CTRL_PA_ENABLE_0_GPIO_IN_BIT               ((u32)0x00002000)
+#define IO_CTRL_PA_ENABLE_0_GPIO_IN_POS               13
+#define IO_CTRL_PA_ENABLE_0_GPIO_OUT_BIT              ((u32)0x00001000)
+#define IO_CTRL_PA_ENABLE_0_GPIO_OUT_POS              12
+#define IO_CTRL_PA_ENABLE_0_GPIO_OE_BIT               ((u32)0x00000800)
+#define IO_CTRL_PA_ENABLE_0_GPIO_OE_POS               11
+#define IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_BIT           ((u32)0x00000400)
+#define IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_POS           10
+#define IO_CTRL_PA_ENABLE_0_INPUT_ENABLE_BIT          ((u32)0x00000200)
+#define IO_CTRL_PA_ENABLE_0_INPUT_ENABLE_POS          9
+#define IO_CTRL_PA_ENABLE_0_SLEW_RATE_BIT             ((u32)0x00000100)
+#define IO_CTRL_PA_ENABLE_0_SLEW_RATE_POS             8
+#define IO_CTRL_PA_ENABLE_0_DRIVER_PULL_STATE_MASK    ((u32)0x000000C0)
+#define IO_CTRL_PA_ENABLE_0_DRIVER_PULL_STATE_LSB     6
+#define IO_CTRL_PA_ENABLE_0_DRIVER_PULL_STATE_WIDTH   ((u32)0x00000002)
+#define IO_CTRL_PA_ENABLE_0_OUTPUT_PAD_STRENGTH_MASK  ((u32)0x00000030)
+#define IO_CTRL_PA_ENABLE_0_OUTPUT_PAD_STRENGTH_LSB   4
+#define IO_CTRL_PA_ENABLE_0_OUTPUT_PAD_STRENGTH_WIDTH ((u32)0x00000002)
+#define IO_CTRL_PA_ENABLE_0_SCHMIT_TRIGER_BIT         ((u32)0x00000008)
+#define IO_CTRL_PA_ENABLE_0_SCHMIT_TRIGER_POS         3
+#define IO_CTRL_PA_ENABLE_0_MUX_SELECT_MASK           ((u32)0x00000007)
+#define IO_CTRL_PA_ENABLE_0_MUX_SELECT_LSB            0
+#define IO_CTRL_PA_ENABLE_0_MUX_SELECT_WIDTH          ((u32)0x00000003)
+
+/*
+ * @brief PA_ENABLE_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B=
0)
+#define IO_CTRL_PA_ENABLE_1_OFFSET      0x000000B0
+#define IO_CTRL_PA_ENABLE_1_INDEX       0x0000002C
+#define IO_CTRL_PA_ENABLE_1_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_1_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_1_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B=
4)
+#define IO_CTRL_PA_ENABLE_2_OFFSET      0x000000B4
+#define IO_CTRL_PA_ENABLE_2_INDEX       0x0000002D
+#define IO_CTRL_PA_ENABLE_2_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_2_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_2_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B=
8)
+#define IO_CTRL_PA_ENABLE_3_OFFSET      0x000000B8
+#define IO_CTRL_PA_ENABLE_3_INDEX       0x0000002E
+#define IO_CTRL_PA_ENABLE_3_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_3_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_3_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B=
C)
+#define IO_CTRL_PA_ENABLE_4_OFFSET      0x000000BC
+#define IO_CTRL_PA_ENABLE_4_INDEX       0x0000002F
+#define IO_CTRL_PA_ENABLE_4_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_4_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_4_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C=
0)
+#define IO_CTRL_PA_ENABLE_5_OFFSET      0x000000C0
+#define IO_CTRL_PA_ENABLE_5_INDEX       0x00000030
+#define IO_CTRL_PA_ENABLE_5_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_5_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_5_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C=
4)
+#define IO_CTRL_PA_ENABLE_6_OFFSET      0x000000C4
+#define IO_CTRL_PA_ENABLE_6_INDEX       0x00000031
+#define IO_CTRL_PA_ENABLE_6_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_6_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_6_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C=
8)
+#define IO_CTRL_PA_ENABLE_7_OFFSET      0x000000C8
+#define IO_CTRL_PA_ENABLE_7_INDEX       0x00000032
+#define IO_CTRL_PA_ENABLE_7_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_7_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_7_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_8 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_8_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C=
C)
+#define IO_CTRL_PA_ENABLE_8_OFFSET      0x000000CC
+#define IO_CTRL_PA_ENABLE_8_INDEX       0x00000033
+#define IO_CTRL_PA_ENABLE_8_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_8_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_8_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_9 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_9_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000D=
0)
+#define IO_CTRL_PA_ENABLE_9_OFFSET      0x000000D0
+#define IO_CTRL_PA_ENABLE_9_INDEX       0x00000034
+#define IO_CTRL_PA_ENABLE_9_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_9_set(struct cl_chip *chip, u32 value=
)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_9_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_10 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_10_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
D4)
+#define IO_CTRL_PA_ENABLE_10_OFFSET      0x000000D4
+#define IO_CTRL_PA_ENABLE_10_INDEX       0x00000035
+#define IO_CTRL_PA_ENABLE_10_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_10_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_10_ADDR, value);
+}
+
+/*
+ * @brief PA_ENABLE_11 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_11_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000=
D8)
+#define IO_CTRL_PA_ENABLE_11_OFFSET      0x000000D8
+#define IO_CTRL_PA_ENABLE_11_INDEX       0x00000036
+#define IO_CTRL_PA_ENABLE_11_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_11_set(struct cl_chip *chip, u32 valu=
e)
+{
+       cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_11_ADDR, value);
+}
+
+/*
+ * @brief SPICLK register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_SPICLK_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000DC)
+#define IO_CTRL_SPICLK_OFFSET      0x000000DC
+#define IO_CTRL_SPICLK_INDEX       0x00000037
+#define IO_CTRL_SPICLK_RESET       0x00000318
+
+static inline void io_ctrl_spiclk_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_SPICLK_ADDR, value);
+}
+
+/*
+ * @brief FWR_EN_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FWR_EN_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000F0)
+#define IO_CTRL_FWR_EN_1_OFFSET      0x000000F0
+#define IO_CTRL_FWR_EN_1_INDEX       0x0000003C
+#define IO_CTRL_FWR_EN_1_RESET       0x00000318
+
+static inline void io_ctrl_fwr_en_1_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FWR_EN_1_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000F8)
+#define IO_CTRL_FASTWR_7_OFFSET      0x000000F8
+#define IO_CTRL_FASTWR_7_INDEX       0x0000003E
+#define IO_CTRL_FASTWR_7_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_7_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_7_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000FC)
+#define IO_CTRL_FASTWR_6_OFFSET      0x000000FC
+#define IO_CTRL_FASTWR_6_INDEX       0x0000003F
+#define IO_CTRL_FASTWR_6_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_6_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_6_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000100)
+#define IO_CTRL_FASTWR_5_OFFSET      0x00000100
+#define IO_CTRL_FASTWR_5_INDEX       0x00000040
+#define IO_CTRL_FASTWR_5_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_5_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_5_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000104)
+#define IO_CTRL_FASTWR_4_OFFSET      0x00000104
+#define IO_CTRL_FASTWR_4_INDEX       0x00000041
+#define IO_CTRL_FASTWR_4_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_4_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_4_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000108)
+#define IO_CTRL_FASTWR_3_OFFSET      0x00000108
+#define IO_CTRL_FASTWR_3_INDEX       0x00000042
+#define IO_CTRL_FASTWR_3_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_3_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_3_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000010C)
+#define IO_CTRL_FASTWR_2_OFFSET      0x0000010C
+#define IO_CTRL_FASTWR_2_INDEX       0x00000043
+#define IO_CTRL_FASTWR_2_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_2_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_2_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000110)
+#define IO_CTRL_FASTWR_1_OFFSET      0x00000110
+#define IO_CTRL_FASTWR_1_INDEX       0x00000044
+#define IO_CTRL_FASTWR_1_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_1_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_1_ADDR, value);
+}
+
+
+/*
+ * @brief FASTWR_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000114)
+#define IO_CTRL_FASTWR_0_OFFSET      0x00000114
+#define IO_CTRL_FASTWR_0_INDEX       0x00000045
+#define IO_CTRL_FASTWR_0_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_0_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, IO_CTRL_FASTWR_0_ADDR, value);
+}
+
+#endif /* CL_REG_IO_CTRL_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

