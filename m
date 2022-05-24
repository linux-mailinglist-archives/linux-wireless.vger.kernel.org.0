Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811F253292B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236821AbiEXLik (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiEXLig (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A6E8CCFA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ioabgpmgwprepml+osQ8dfFMRtWZ4nAUwgcJA9s9v0c/R+vycrwPkVLVPDCskOXmnqBlhJSc1fcc+5T/fmbrnq8YY7JeBc4TVTliTHaxp/gTNdOYgHqa5PgTG6SXpEPMSAtWomF9L1wT6nc9pozG70oAcZ+z/7JVHSAAOMrrB+67IPDFRT/wI2To1gAKUbtLqUHYafQaCEeR5X1t7oiUW+iw3quBfqBi21pk6VVKNDc5x/wR3JIzM0W5osgAcmdSpEg5GpoCLwmVygZuYZkQF/IJ9U1P3t9EPBlgCpNHd0enHddK4LOpIj7QeUY9q9fWhjUYa99vuBPqJ8RsZC2/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XfbmPiTrH4/U98i0UYCMO8hVcb76Iw3EXn0/n2QLyGY=;
 b=V77/NxSqyJEx9Gkhw7NnJ4tuDev7jMpBLH+zWpf9pI95V0dhGLeg0V7jdaGDB9exNBOgRP9lJ1acrKt1OxkxlocVsnkEiUCpj2b3zOMUD7D5cNDvycXBdOqa99+JnORmIhOLT837QobaywttwDL6SM+g5lTE2qX4eA6AmP43DDzvX3g/bhnajqqQKzyfHdhDFj7bWBVlktnY8NId4QH3ZoZ+ohtkJ9sin0jIpFIRDZ9U/vV4EM56btz7P7TRTuUdKzg7QXm50co8cd+IIpM+qqolzZqzADcFHSqdJTY8EuU4+Y7w4phI5egDH7JfajKPyybizYLl5VXylezSZiK/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfbmPiTrH4/U98i0UYCMO8hVcb76Iw3EXn0/n2QLyGY=;
 b=gj1AgNe9JT4xjwkwMg0Ca7Ff/HrRnF855Ja+Y3E5vueVXvMglKria8OgKAx8FCVAVY3Sm0Mx44U4ddMmft83eEQiqHNkKIsPSW6N3hX1khxvfSQ0ShzaJ2hMehTK7UkWVJNU23yADBAP/d/d6J8f4hNbh8V+5cIeVXz3SGfNm6o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:38:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:01 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 24/96] cl8k: add e2p.c
Date:   Tue, 24 May 2022 14:33:50 +0300
Message-Id: <20220524113502.1094459-25-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f8bd0bf-f879-4582-6e17-08da3d79db70
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB04696423908690A4AB019498F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAFNHOtHsDz52mHwRhOfI82k9dRPOhab9mMcrL5H+xDk0RaN1cGsTrK0oXaGwREBes8NAnKBngjvpMDDeYiTXubAOWJkjlYzl1NnPvVMbKsKAtUZFFWfIX5nGKyfJoNbviRz8ueEQz7EYxoT5gQ3l04zmAKTTU+xlhjelVHXy5cj11HKP6Txx/LBH6u1VMitQuGa6MONQe/tHFJjCZbuUglOmrWn94lmFtKpQhPTyF6xSNVWPCEETM3bZNcAQ/Rn5jqNpv3l8JXrLHWVB/zYA1bejQ1ZO/H864PO9vb4WCZVhj8W3rEntX7Y9Lp1dLG0TSJfahNKw62kVcQlvQVdiyWZiGKzRddOuadS/EHWb14+kOf39B1RsGhLDe2FuRu0OvVKlLcwxGA9uG23g0DlhsYdpkwTokUsv103E33+zYUKrjl+kvDpH9Qz0mV5HEUwTypBzUinVW2hZf0rJ6SplxzrOMUBFrA4RZqhIY3kX1GWLQXLjAHvcmIRpUx9eY8dxyptz9W/2lcIGHlBrGMLFLIJ72Tji7yChtI5QM6srrcxcXLHvxxe4NJSrrBmyhfH2t2pvjXqlIChjCxbHyUCXFT2cFMMDOtAyI0ibeXsXEo04vXW+L2Aq1ZNH8hUzghMiRE/tAXnGLW0Y7PseCclxQ57VSInBNSOyKNLYUQugFdB5s83IQDDu/WsXx+d3pAH5nfdDOgICuOZFt9YZ6pUjwBJjdyqdQHqwlHHo0KRBC4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1Z3YVNJeEx4RVBuQjdTbThPU1FjeDR6SFd3OUg3Mkx4QWU4djU3UG83Ym9k?=
 =?utf-8?B?K2RNZmkvSEFZT0ovYytVMGZEVkE0NnVrakZIN3dvMXZmdVVuRHVDeDZkeXpn?=
 =?utf-8?B?c2xKQUp1S3YzcGh2dWVRNEYxd3lYM2NibmZQNUoxdkNKSUtOUjBrRkVOZkcv?=
 =?utf-8?B?VjVTZGprTEVTRWtFc0NtTTFJWER1WHo0d3A5V1FOQkxaZllKbU5yVUFoUE5Z?=
 =?utf-8?B?QUx3anNCM1NCUG1GVkoyRXpCSVJwdGFpQStMdmIxL0Z6R1lvaWFSYnEySGhm?=
 =?utf-8?B?RkJaTmQzc1M1cDdIUDQ3M2Foc2owOXhHcHF4SFhSL0lJUUVXN0NObGVtOE04?=
 =?utf-8?B?Mnl1NHZ4QXQxOG9qa2VBUTUzSmMxS1JkQUIvKzU4SHdkTkdST1R5K3JtYVpQ?=
 =?utf-8?B?SjFaWFpVNVc3SEdrZEdIV3RsWWRhVTB2eUgrV0NnSmc1NGl1U2VwcnpFcXd1?=
 =?utf-8?B?cndsbTV5TVNkVVVqS0dRNW8wUWxwaVpKOHNzNmRHakhqMGJiMG5abjUreEZ3?=
 =?utf-8?B?QkRIUmxManRxMnEweS83dXhPdU16cGNWWmdJdVduZTBmYzcwSnRyQnhmMmxF?=
 =?utf-8?B?OWJ5S1J2Y2pkTFFZaWlCL0EzV2F6R3g5US9WSGZaYVJIbjEvbVNNZytlMzdS?=
 =?utf-8?B?THpxOTVtZ0Q1YloyQjgzZWpxRHAzckdsWk1LYUhPcWluelVZa0tBbDgwQzdy?=
 =?utf-8?B?VjBJZnVwLzdKamxldStwYUNUWEZTamlQQisrK3FRRG5OdnNXQjYwTXh6bkdM?=
 =?utf-8?B?cksxSFF6UTdmK2l0Nzc2Q0lkOGpGNjhmVU5HRlp1ekpFYTJ1OHpIZGtteXN3?=
 =?utf-8?B?eU4wdnNoakFjNHVGZHMveUNHbmlPL1NvcDlkeURvTmVpcEx6QkEyODNRY1Ux?=
 =?utf-8?B?RUxLUElNcTRiYW5ZRzJDVDNCS2dzNE5IUHROcUx1MjNxQXJtalBDK2pqa3FD?=
 =?utf-8?B?dnlZVEFhNDBBZFltR0RheFp1eituYmd0RFZwbmd1aERubkxlUDFLaHFVRmwz?=
 =?utf-8?B?V0t3THVVN0U1K3o2ZFBHZElOWFM3dzJmYUU3TUR4RWR5SXN2ckhUcFF4ak4z?=
 =?utf-8?B?d3ZRZUhuemZXOUVEZDR0VDVtUkZYUXd4L2xFK0ZIY3R3OTg0cWgxZkZ3YmFO?=
 =?utf-8?B?eUV1NXI0UmhsVDRjYzBlbG1VVDgwWXFUSWMrS3haaGNaWmFQMVR6M0trVlFM?=
 =?utf-8?B?SjFQZll3WmJHSThUNUdzNURZR0VlZG9veVozMkp2NGlKWHgzQ0dVYURXK0tK?=
 =?utf-8?B?dCtvT3pVQ3JZVm12c2RZVWZaRWJNYXQzTnJvWnlza1c1b1RBV0NKTjBWN2dG?=
 =?utf-8?B?WTMvczd1Yjg2eVJCalZQY01NeVNMeTFwTVU2QjlLWkZKZ0dJb1hlMjE1Z0N3?=
 =?utf-8?B?WHlYOG05ajluZE4zR0N5WVZzMmJqNzdpSG42TGJrdXFhd2FFTGN5UERlTHBi?=
 =?utf-8?B?OE5UT2tva3g1a0dyU083VW9nbk9qMDJoYmd4THMzMktZOGQydE1OYzNmcGZN?=
 =?utf-8?B?b2k4VldDbzBqUUE5NlJ4NktQdFdvZHFILzBuc1ZiNnMvMi8zejFHUkIwMFRi?=
 =?utf-8?B?TXVvb0svZ2svaXFseFcrTU04aWZ4QjVKNXpDc3JFMlpFQjNvQmtJS1pzRllW?=
 =?utf-8?B?NTYvUUczUDhJTTJURHFUYk1rTUZTb0JpMEwxRTUrb0k3YWtuZ2tTdlNNV3VO?=
 =?utf-8?B?QndlZDYyY1NYanRzNkMxeFV6cXNOb25HQUE3V3pNMkgySFNGZnAxcE4xVWtG?=
 =?utf-8?B?QzUvVDBsbURES3QwY21NSnRTb1ZSTnJ2Q1hMUXlxVDErcTliMGYxYkRvL29F?=
 =?utf-8?B?YzErOFpwa09VK2xidWxxQmRGR1I4MGJKUjA2Y2J5NFY4d01tK2NxcGQwYS9q?=
 =?utf-8?B?dFhkYjJvY1d1UkN4SmViWm13Y3JZTkw5d0hOYnlrNTZmcnhkeGhLZEZaU25o?=
 =?utf-8?B?TzJiWHpBR2E3WkpUU3Z1aDloOGhuTWNHZG1jNEx2ektVOEgzeW9mdkh5NEZV?=
 =?utf-8?B?MVcybk5UTjhrek4wa3NEdkxLcTk1ZTJhTmdPM3kzZk8vbC9PN1VnTFlrZGlq?=
 =?utf-8?B?dURhMFVHNWttVVJXeHRFS0Z5eklwVDY1RmFteWZtUmdLV1BlNDlCcFpDQmJt?=
 =?utf-8?B?Y2xZNVlpWi8ra21kZnZBamNsVW13cGZwQnMrSEN5dVFSSFJyTzUyN1g5N291?=
 =?utf-8?B?TFg4OTBWQlJaYUhMM3RDNklBdXFjUWN3YnhxZmpoMVQxNUZ5TWltUUdCU2FO?=
 =?utf-8?B?SURCV0V5eFMvcXBWUVc4WmRLdEZwOGRsV25nS1ljNC9lWVg2bkpNVFdkSGp3?=
 =?utf-8?B?S0l3aEpHV01DQ3ZrSitTRlV3TzR0Tmhua1VKOUhTTDhETmcwR2JjdXlQYS8z?=
 =?utf-8?Q?52MV8hoqZrWo55Ys=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8bd0bf-f879-4582-6e17-08da3d79db70
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:01.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXqX6eCCIYGSZp5HRbGRmOVMapegB8gSrY/3NSVKK6SehiaqHXvHXw6sJNASdQjizs+vzsprWlddKAarIuBxfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/e2p.c | 771 +++++++++++++++++++++++++
 1 file changed, 771 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.c

diff --git a/drivers/net/wireless/celeno/cl8k/e2p.c b/drivers/net/wireless/celeno/cl8k/e2p.c
new file mode 100644
index 000000000000..14e9a4498046
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/e2p.c
@@ -0,0 +1,771 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/delay.h>
+#include <linux/kernel.h>
+
+#include "chip.h"
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "config.h"
+#include "utils.h"
+#include "e2p.h"
+#include "calib.h"
+#include "debug.h"
+
+#define EEPROM_VERSION 3
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+/* EEPROM Parameters - Suitable for ST-M24256 */
+#define E2P_SIZE       0x8000              /* 32KB = 256Kbit */
+#define E2P_PAGE_SIZE  0x40                /* 64 Bytes */
+#define E2P_PAGE_MASK  (E2P_PAGE_SIZE - 1) /* 0x3F */
+#define E2P_PAGE_SHIFT 0x6
+#else
+/* EEPROM Parameters - Suitable for ATMEL AT24C16BN */
+#define E2P_SIZE       0x800               /* 2KB = 16Kbit */
+#define E2P_PAGE_SIZE  0x10                /* 16 Bytes */
+#define E2P_PAGE_MASK  (E2P_PAGE_SIZE - 1) /* 0xF */
+#define E2P_PAGE_SHIFT 0x4
+#endif
+
+#define PAGE_NUM(addr) ((addr) >> E2P_PAGE_SHIFT)
+#define PAGE_OFF(addr) ((addr) & E2P_PAGE_MASK)
+
+#define CH_LIST_SIZE_CL80X0         59
+#define CH_LIST_SIZE_CL80X6         105
+
+static const u8 chan_list_cl80x0[CH_LIST_SIZE_CL80X0] = {
+	36, 38, 40, 42, 44, 46, 48, 50,
+	52, 54, 56, 58, 60, 62, 64, 100,
+	102, 104, 106, 108, 110, 112, 114, 116,
+	118, 120, 122, 124, 126, 128, 132, 134,
+	136, 138, 140, 142, 144, 149, 151, 153,
+	155, 157, 159, 161, 165, 1, 2, 3,
+	4, 5, 6, 7, 8, 9, 10, 11,
+	12, 13, 14
+};
+
+static const u16 chan_list_cl80x6[CH_LIST_SIZE_CL80X6] = {
+	1, 2, 5, 9, 13, 17, 21, 25,
+	29, 33, 37, 41, 45, 49, 53, 57,
+	61, 65, 69, 73, 77, 81, 85, 89,
+	93, 97, 101, 105, 109, 113, 117, 121,
+	125, 129, 133, 137, 141, 145, 149, 153,
+	157, 161, 165, 169, 173, 177, 181, 185,
+	189, 193, 197, 201, 205, 209, 213, 217,
+	221, 225, 229, 233, 36, 38, 40, 42,
+	44, 46, 48, 50, 52, 54, 56, 58,
+	60, 62, 64, 100, 102, 104, 106, 108,
+	110, 112, 114, 116, 118, 120, 122, 124,
+	126, 128, 132, 134, 136, 138, 140, 142,
+	144, 149, 151, 153, 155, 157, 159, 161,
+	165
+};
+
+enum bit_num {
+	BIT0,
+	BIT1,
+	BIT2,
+	BIT3,
+	BIT4,
+	BIT5,
+	BIT6,
+	BIT7,
+};
+
+struct cl_e2p_work {
+	struct work_struct ws;
+	struct cl_chip *chip;
+};
+
+/*
+ * MACSYS_I2C:: PRERLO (0x0) - Clock Prescale register lo-byte
+ * Width: 8, Access: RW, Reset: 0xff.
+ */
+#define I2C_PRERLO (I2C_REG_BASE_ADDR + 0x0)
+
+/*
+ * MACSYS_I2C:: PRERHI (0x4) - Clock Prescale register lo-byte
+ * Width: 8, Access: RW, Reset: 0xff.
+ */
+#define I2C_PRERHI (I2C_REG_BASE_ADDR + 0x4)
+
+/*
+ * MACSYS_I2C:: CTR (0x8) - Control Register
+ * Width: 8, Access: RW, Reset: 0x00.
+ */
+#define I2C_CTR (I2C_REG_BASE_ADDR + 0x8)
+
+#define EN (BIT7) /* ‘1’ the core is enabled. */
+
+/*
+ * MACSYS_I2C:: TXR_RXR (0xC) - Transmit Register - Data
+ * Width: 8, Access: W, Reset: 0x00.
+ */
+#define I2C_TXD (I2C_REG_BASE_ADDR + 0xC)
+
+/* 7:0 TXD */
+#define TXD (BIT0) /* Next byte to transmit via I2C */
+
+#define TXD_MASK (0xFF << TXD)
+
+/*
+ * MACSYS_I2C:: TXR_RXR (0xC) - Transmit Register - Address
+ * Width: 8, Access: W, Reset: 0x00.
+ */
+#define I2C_TXADDR (I2C_REG_BASE_ADDR + 0xC)
+
+/*
+ * 7:1 TXADDR
+ * 0 RDWR
+ */
+#define TXADDR (BIT1) /* I2C Slave Address */
+#define RDWR   (BIT0) /* ‘1’ = reading from slave. ‘0’ = writing to slave. */
+
+#define TXADDR_MASK (0x7F << TXADDR)
+
+/*
+ * MACSYS_I2C:: TXR_RXR (0xC) - Receive Register
+ * Width: 8, Access: R, Reset: 0x00.
+ */
+#define I2C_RXD (I2C_REG_BASE_ADDR + 0xC)
+
+/* 7:0 RXD */
+#define RXD (BIT0) /* Last byte received via I2C. */
+#define RXD_MASK (0xFF << RXD)
+
+/*
+ * MACSYS_I2C:: CR_SR (0x10) - Command Register
+ * Width: 8, Access: WC, Reset: 0x00.
+ */
+#define I2C_CR (I2C_REG_BASE_ADDR + 0x10)
+
+/*
+ * 7 STA
+ * 6 STO
+ * 5 RD
+ * 4 WR
+ * 3 ACK
+ * 2:1 RES
+ * 0 IACK
+ */
+#define STA  (BIT7) /* Generate (repeated) start condition. */
+#define STO  (BIT6) /* Generate stop condition. */
+#define RD   (BIT5) /* Read from slave. */
+#define WR   (BIT4) /* Write to slave. */
+#define ACK  (BIT3) /* When a receiver, sent ACK (ACK = ‘0’) or NACK (NACK = ‘1’). */
+#define IACK (BIT0) /* Interrupt acknowledge, When set, clears a pending interrupt. */
+
+/*
+ * MACSYS_I2C:: CR_SR (0x10) - Status Register
+ * Width: 8, Access: R, Reset: 0x00.
+ */
+#define I2C_SR (I2C_REG_BASE_ADDR + 0x10)
+
+/*
+ * 7 RX_ACK - Received acknowledge from slave - ‘1’ = No acknowledge received.
+ * 6 BUSY - I2C bus busy - ‘1’ after START signal detected. ‘0’ after STOP signal detected.
+ * 5 AL - Arbitration lost - This bit is set when the core lost arbitration.
+ * 4:2 RES
+ * 1 TIP - Transfer in progress. ‘1’ when transferring data. ‘0’ when transfer complete.
+ * 0 IF - Set when interrupt is pending, cause a processor interrupt if the IEN bit is set.
+ */
+#define RX_ACK (BIT7)
+#define BUSY   (BIT6)
+#define AL     (BIT5)
+#define TIP    (BIT1)
+#define IF     (BIT0)
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+#define I2C_EEPROM_ADDR(page) (0xA0 | (((page) >> 8) & 0xE)) /* [1-0-1-0-P2-P1-P0-0] */
+#else
+#define I2C_EEPROM_ADDR(page) (0xA0 | (((page) >> 3) & 0xE)) /* [1-0-1-0-P2-P1-P0-0] */
+#endif
+
+/* E2P_MAX_POLLS should not exceed 12 iterations (attemts) */
+#define E2P_MAX_POLLS 500
+#define E2P_INITIAL_DELAY 32
+
+static int i2c_poll_xfer_acked(struct cl_chip *chip)
+{
+	u32 val = cl_reg_read_chip(chip, I2C_SR);
+	int cnt = E2P_MAX_POLLS;
+	unsigned long delay = E2P_INITIAL_DELAY;
+
+	while ((val & BIT(TIP)) && cnt--) {
+		udelay(delay);
+		val = cl_reg_read_chip(chip, I2C_SR);
+		delay <<= 1;
+	}
+	++cnt;
+
+	while ((val & BIT(RX_ACK)) && cnt--) {
+		udelay(delay);
+		val = cl_reg_read_chip(chip, I2C_SR);
+		delay <<= 1;
+	}
+
+	if (cnt >= 0)
+		return 0;
+
+	cl_dbg_chip_err(chip, "ACK FAILED\n");
+	cl_dbg_chip_trace(chip, "I2C_POLL_XFER_ACKED: val=%Xh, cnt=%d.\n", val, cnt);
+
+	return -EBADE;
+}
+
+static int i2c_poll_xfer_no_acked(struct cl_chip *chip)
+{
+	u32 val = cl_reg_read_chip(chip, I2C_SR);
+	int cnt = E2P_MAX_POLLS;
+	unsigned long delay = E2P_INITIAL_DELAY;
+
+	while ((val & BIT(TIP)) && cnt--) {
+		udelay(delay);
+		val = cl_reg_read_chip(chip, I2C_SR);
+		delay <<= 1;
+	}
+
+	++cnt;
+
+	while (!(val & BIT(RX_ACK)) && cnt--) {
+		udelay(delay);
+		val = cl_reg_read_chip(chip, I2C_SR);
+		delay <<= 1;
+	}
+
+	if (cnt >= 0)
+		return 0;
+
+	cl_dbg_chip_err(chip, "NO ACK FAILED\n");
+	cl_dbg_chip_trace(chip, "I2C_POLL_XFER_NO_ACKED: val=%Xh, cnt=%d.\n", val, cnt);
+
+	return -EBADE;
+}
+
+static void i2c_write_start(struct cl_chip *chip, u16 page)
+{
+	u32 addr = I2C_EEPROM_ADDR(page) & TXADDR_MASK;
+
+	cl_reg_write_chip(chip, I2C_TXADDR, addr);
+	cl_reg_write_chip(chip, I2C_CR, BIT(STA) | BIT(WR));
+}
+
+static void i2c_write(struct cl_chip *chip, u8 data)
+{
+	cl_reg_write_chip(chip, I2C_TXD, data & TXD_MASK);
+	cl_reg_write_chip(chip, I2C_CR, BIT(WR));
+}
+
+static void i2c_write_stop(struct cl_chip *chip, u8 data)
+{
+	cl_reg_write_chip(chip, I2C_TXD, data & TXD_MASK);
+	cl_reg_write_chip(chip, I2C_CR, BIT(STO) | BIT(WR));
+}
+
+static void i2c_read_start(struct cl_chip *chip, u16 page)
+{
+	u32 addr = (I2C_EEPROM_ADDR(page) & TXADDR_MASK) | BIT(RDWR);
+
+	cl_reg_write_chip(chip, I2C_TXADDR, addr);
+	cl_reg_write_chip(chip, I2C_CR, BIT(STA) | BIT(WR));
+}
+
+static int i2c_read_stop(struct cl_chip *chip, u8 *data)
+{
+	int ret = 0;
+
+	cl_reg_write_chip(chip, I2C_CR, BIT(STO) | BIT(RD) | BIT(ACK));
+	ret = i2c_poll_xfer_no_acked(chip);
+	if (ret < 0)
+		return ret;
+	*data = cl_reg_read_chip(chip, I2C_RXD) & RXD_MASK;
+	return 0;
+}
+
+static void e2p_reg_set_bit(struct cl_chip *chip, u32 reg, u32 bit)
+{
+	u32 regval = cl_reg_read_chip(chip, reg);
+
+	regval |= bit;
+	cl_reg_write_chip(chip, reg, regval);
+}
+
+static void e2p_reg_clear_bit(struct cl_chip *chip, u32 reg, u32 bit)
+{
+	u32 regval = cl_reg_read_chip(chip, reg);
+
+	regval &= ~bit;
+	cl_reg_write_chip(chip, reg, regval);
+}
+
+/*
+ * helpers for cl_e2p_write_addr_bytes()
+ */
+static inline u16 cl_e2p_addrbyte_lo(u16 v)
+{
+	return v & 0xff;
+}
+
+static inline u16 cl_e2p_addrbyte_hi(u16 v)
+{
+	return (v >> 8) & 0xff;
+}
+
+/*
+ * Helper writing address byte(s) to the eeprom, some eeprom need two
+ * byte address cycles, some need only one.
+ */
+static int cl_e2p_write_addr_bytes(struct cl_chip *chip, u16 addr)
+{
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	int ret = 0;
+
+	/* Addr 8 msbits are 8 bits msb page */
+	i2c_write(chip, cl_e2p_addrbyte_hi(addr));
+
+	ret = i2c_poll_xfer_acked(chip);
+	if (ret)
+		return ret;
+#endif
+	/* Addr 8 lsbits are 4 bits page lsbits or`ed with 4 bits page offset */
+	i2c_write(chip, cl_e2p_addrbyte_lo(addr));
+
+	return i2c_poll_xfer_acked(chip);
+}
+
+static void e2p_enable(struct cl_chip *chip)
+{
+	/* Disable I2C Core */
+	e2p_reg_clear_bit(chip, I2C_CTR, BIT(EN));
+
+	/*
+	 * Set Pre-Scaler LO
+	 * pclk = 240MHz, desired SCL = 400KHz.
+	 * Prescale = [240e6 / (5*400e3) ] – 1 = 120 -1 = 119 = 77h
+	 */
+	cl_reg_write_chip(chip, I2C_PRERLO, 0x77);
+
+	/* Set Pre-Scaler HI */
+	cl_reg_write_chip(chip, I2C_PRERHI, 0x0);
+
+	/* Enable I2C Core */
+	e2p_reg_set_bit(chip, I2C_CTR, BIT(EN));
+}
+
+static int e2p_read_byte(struct cl_chip *chip, u16 addr, u8 *pbyte)
+{
+	int ret = 0;
+
+	if (addr > E2P_SIZE) {
+		cl_dbg_chip_err(chip, "Wrong addr or len\n");
+		return -EFAULT;
+	}
+
+	/* Clock in the address to read from. */
+	i2c_write_start(chip, PAGE_NUM(addr));
+	ret = i2c_poll_xfer_acked(chip);
+	if (ret)
+		return ret;
+
+	ret = cl_e2p_write_addr_bytes(chip, addr);
+	if (ret)
+		return ret;
+
+	/* Read single byte */
+	i2c_read_start(chip, PAGE_NUM(addr));
+	ret = i2c_poll_xfer_acked(chip);
+	if (ret)
+		return ret;
+
+	return i2c_read_stop(chip, pbyte);
+}
+
+static int e2p_write_page(struct cl_chip *chip, u16 addr, u8 *val, u16 num_of_bytes)
+{
+	/*
+	 * This is a write page (up to E2P_PAGE_SIZE bytes) operation indicating the offset
+	 * to write to.
+	 */
+	int i;
+	int ret = 0;
+
+	if (num_of_bytes > E2P_PAGE_SIZE)
+		return -EMSGSIZE;
+
+	/* Clock in the address to write to. */
+	i2c_write_start(chip, PAGE_NUM(addr));
+	ret = i2c_poll_xfer_acked(chip);
+	if (ret)
+		return ret;
+
+	ret = cl_e2p_write_addr_bytes(chip, addr);
+	if (ret)
+		return ret;
+
+	/* Clock in the data to write. */
+	for (i = 0; i < (num_of_bytes - 1); i++, val++) {
+		i2c_write(chip, *val);
+		ret = i2c_poll_xfer_acked(chip);
+		if (ret)
+			return ret;
+	}
+
+	/* Clock in the last data byte to write */
+	i2c_write_stop(chip, *val);
+	ret = i2c_poll_xfer_acked(chip);
+	if (ret)
+		return ret;
+
+	/* Wait for the write to finish */
+	mdelay(6);
+
+	return ret;
+}
+
+static int e2p_write_block(struct cl_chip *chip, u16 addr, u16 num_of_bytes, u8 *val)
+{
+	u16 bytes_on_curr_page = 0, bytes_left_to_write = num_of_bytes;
+	int ret = 0;
+
+	do {
+		bytes_on_curr_page = E2P_PAGE_SIZE - PAGE_OFF(addr);
+		bytes_on_curr_page = min(bytes_left_to_write, bytes_on_curr_page);
+		bytes_left_to_write -= bytes_on_curr_page;
+
+		ret = e2p_write_page(chip, addr, val, bytes_on_curr_page);
+		if (ret) {
+			cl_dbg_chip_err(chip,
+					"Error writing page %u offset %u, ret %d\n",
+					PAGE_NUM(addr), PAGE_OFF(addr), ret);
+			/* Written less bytes than num_of_bytes */
+			return 0;
+		}
+
+		addr += bytes_on_curr_page;
+		val += bytes_on_curr_page;
+	} while (bytes_left_to_write);
+
+	return num_of_bytes - bytes_left_to_write;
+}
+
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+static void cl_e2p_init_calib_ch_bmp_per_bw(struct cl_hw *cl_hw, int data_elem_num,
+					    u16 channel_list[], int bw, int bmp_size,
+					    int bmp_addr, int eeprom_data_size, int data_addr)
+{
+	u8 chan_idx;
+	u8 chan_bmp[SIZE_CALIB_IQ_DCOC_20MHZ_BMP_TCV0] = {0};
+	u8 chan_bmp_prev[SIZE_CALIB_IQ_DCOC_20MHZ_BMP_TCV0] = {0};
+	struct eeprom_calib_data zero_calib = {0};
+	int i;
+
+	for (i = 0; i < data_elem_num; i++) {
+		chan_idx = cl_calib_dcoc_channel_bw_to_idx(cl_hw, channel_list[i], bw);
+		if (channel_list[i] && chan_idx != INVALID_CHAN_IDX)
+			chan_bmp[chan_idx / BITS_PER_BYTE] |= (BIT(chan_idx % BITS_PER_BYTE));
+	}
+
+	cl_e2p_read(cl_hw->chip, chan_bmp_prev, bmp_size, bmp_addr);
+	if (memcmp(chan_bmp, chan_bmp_prev, bmp_size))
+		for (i = 0; i < data_elem_num; i++)
+			cl_e2p_write(cl_hw->chip, (u8 *)&zero_calib,
+				     (u16)sizeof(struct eeprom_calib_data),
+				     data_addr + (i *
+				     (u16)sizeof(struct eeprom_calib_data)));
+
+	cl_e2p_write(cl_hw->chip, chan_bmp, bmp_size,
+		     bmp_addr);
+}
+
+static void cl_e2p_init_calib_ch_bmp(struct cl_hw *cl_hw)
+{
+	if (cl_hw->tcv_idx == 0) {
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV0,
+						cl_hw->conf->ci_calib_eeprom_channels_20mhz,
+						CHNL_BW_20, SIZE_CALIB_IQ_DCOC_20MHZ_BMP_TCV0,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV0,
+						SIZE_CALIB_IQ_DCOC_DATA_20MHZ_TCV0,
+						ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV0);
+
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV0,
+						cl_hw->conf->ci_calib_eeprom_channels_40mhz,
+						CHNL_BW_40, SIZE_CALIB_IQ_DCOC_40MHZ_BMP_TCV0,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV0,
+						SIZE_CALIB_IQ_DCOC_DATA_40MHZ_TCV0,
+						ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV0);
+
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV0,
+						cl_hw->conf->ci_calib_eeprom_channels_80mhz,
+						CHNL_BW_80, SIZE_CALIB_IQ_DCOC_80MHZ_BMP_TCV0,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV0,
+						SIZE_CALIB_IQ_DCOC_DATA_80MHZ_TCV0,
+						ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV0);
+
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV0,
+						cl_hw->conf->ci_calib_eeprom_channels_160mhz,
+						CHNL_BW_160, SIZE_CALIB_IQ_DCOC_160MHZ_BMP_TCV0,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV0,
+						SIZE_CALIB_IQ_DCOC_DATA_160MHZ_TCV0,
+						ADDR_CALIB_IQ_DCOC_DATA_160MHZ_TCV0);
+	} else {
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_20MHZ_TCV1,
+						cl_hw->conf->ci_calib_eeprom_channels_20mhz,
+						CHNL_BW_20, SIZE_CALIB_IQ_DCOC_20MHZ_BMP_TCV1,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_20MHZ_BMP_TCV1,
+						SIZE_CALIB_IQ_DCOC_DATA_20MHZ_TCV1,
+						ADDR_CALIB_IQ_DCOC_DATA_20MHZ_TCV1);
+
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_40MHZ_TCV1,
+						cl_hw->conf->ci_calib_eeprom_channels_40mhz,
+						CHNL_BW_40, SIZE_CALIB_IQ_DCOC_40MHZ_BMP_TCV1,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_40MHZ_BMP_TCV1,
+						SIZE_CALIB_IQ_DCOC_DATA_40MHZ_TCV1,
+						ADDR_CALIB_IQ_DCOC_DATA_40MHZ_TCV1);
+
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_80MHZ_TCV1,
+						cl_hw->conf->ci_calib_eeprom_channels_80mhz,
+						CHNL_BW_80, SIZE_CALIB_IQ_DCOC_80MHZ_BMP_TCV1,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_80MHZ_BMP_TCV1,
+						SIZE_CALIB_IQ_DCOC_DATA_80MHZ_TCV1,
+						ADDR_CALIB_IQ_DCOC_DATA_80MHZ_TCV1);
+
+		cl_e2p_init_calib_ch_bmp_per_bw(cl_hw, EEPROM_CALIB_DATA_ELEM_NUM_160MHZ_TCV1,
+						cl_hw->conf->ci_calib_eeprom_channels_160mhz,
+						CHNL_BW_160, SIZE_CALIB_IQ_DCOC_160MHZ_BMP_TCV1,
+						ADDR_CALIB_IQ_DCOC_CHANNEL_160MHZ_BMP_TCV1,
+						SIZE_CALIB_IQ_DCOC_DATA_160MHZ_TCV1,
+						ADDR_CALIB_IQ_DCOC_DATA_160MHZ_TCV1);
+	}
+}
+
+static void e2p_read_eeprom_handler(struct work_struct *ws)
+{
+	struct cl_e2p_work *e2p_work = container_of(ws, struct cl_e2p_work, ws);
+	struct cl_chip *chip = e2p_work->chip;
+	u8 *cache = (u8 *)chip->eeprom_cache;
+	u16 i;
+
+	if (chip->conf->ce_eeprom_mode == E2P_MODE_EEPROM)
+		for (i = EEPROM_BASIC_NUM_BYTES; i < EEPROM_NUM_BYTES; i++)
+			if (e2p_read_byte(chip, i, &cache[i]) < 0)
+				return;
+
+	if (chip->cl_hw_tcv0)
+		cl_e2p_init_calib_ch_bmp(chip->cl_hw_tcv0);
+	if (chip->cl_hw_tcv1)
+		cl_e2p_init_calib_ch_bmp(chip->cl_hw_tcv1);
+
+	chip->is_calib_eeprom_loaded = 1;
+}
+
+void cl_e2p_read_eeprom_start_work(struct cl_chip *chip)
+{
+	struct cl_e2p_work *e2p_work = kzalloc(sizeof(*e2p_work), GFP_ATOMIC);
+
+	if (!e2p_work)
+		return;
+
+	e2p_work->chip = chip;
+	INIT_WORK(&e2p_work->ws, e2p_read_eeprom_handler);
+	queue_work(chip->chip_workqueue, &e2p_work->ws);
+}
+#endif
+
+static int e2p_load_from_eeprom(struct cl_chip *chip)
+{
+	u8 *cache = (u8 *)chip->eeprom_cache;
+	u16 i;
+	int ret = 0;
+#ifdef CONFIG_CL8K_EEPROM_STM24256
+	u16 eeprom_load_len = EEPROM_BASIC_NUM_BYTES;
+#else
+	u16 eeprom_load_len = EEPROM_NUM_BYTES;
+#endif
+
+	for (i = 0; i < eeprom_load_len; i++) {
+		ret = e2p_read_byte(chip, i, &cache[i]);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int e2p_eeprom_read_block(struct cl_chip *chip, u16 addr, u16 num_of_bytes, u8 *val)
+{
+	void *read_block = NULL;
+
+	if (!val)
+		return -EFAULT;
+
+	if (addr + num_of_bytes > EEPROM_NUM_BYTES)
+		return -ENXIO;
+
+	read_block = (u8 *)chip->eeprom_cache + addr;
+	memcpy(val, read_block, num_of_bytes);
+
+	return num_of_bytes;
+}
+
+static int e2p_eeprom_write_block(struct cl_chip *chip, u16 addr, u16 num_of_bytes, u8 *val)
+{
+	int bytes_written = -EIO;
+	void *write_block = NULL;
+
+	if (!val)
+		return -EFAULT;
+
+	if (addr + num_of_bytes > EEPROM_NUM_BYTES)
+		return -ENXIO;
+
+	bytes_written = e2p_write_block(chip, addr, num_of_bytes, val);
+	write_block = (u8 *)chip->eeprom_cache + addr;
+	memcpy(write_block, val, num_of_bytes);
+
+	return bytes_written;
+}
+
+static int e2p_load_from_bin(struct cl_chip *chip)
+{
+	char filename[CL_FILENAME_MAX];
+	size_t size = 0;
+	char *buf = NULL;
+	int ret = 0;
+
+	if (cl_chip_is_6g(chip))
+		snprintf(filename, sizeof(filename),
+			 "eeprom%u_cl80x6.bin", chip->idx);
+	else
+		snprintf(filename, sizeof(filename),
+			 "eeprom%u_cl80x0.bin", chip->idx);
+
+	size = cl_file_open_and_read(chip, filename,
+				     (char **)&buf);
+
+	if (size < EEPROM_BASIC_NUM_BYTES) {
+		cl_dbg_chip_err(chip,
+				"Invalid EEPROM size - %s (actual %zu) (min size %d)\n",
+				filename, size, EEPROM_BASIC_NUM_BYTES);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (size > EEPROM_NUM_BYTES) {
+		cl_dbg_chip_err(chip,
+				"Invalid EEPROM size - %s (actual %zu) (max size %d)\n",
+				filename, size, EEPROM_NUM_BYTES);
+		ret = -EFBIG;
+		goto err;
+	}
+
+	if (!buf) {
+		cl_dbg_chip_err(chip, "EEPROM data buffer is empty\n");
+
+		ret = -ENODATA;
+		goto err;
+	}
+
+	chip->eeprom_bin_size = size;
+	memcpy(chip->eeprom_cache, buf, size);
+
+err:
+	kfree(buf);
+
+	return ret;
+}
+
+static int e2p_bin_write_block(struct cl_chip *chip, u16 addr, u16 num_of_bytes, u8 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+static int e2p_bin_read_block(struct cl_chip *chip, u16 addr, u16 num_of_bytes, u8 *val)
+{
+	u8 *base;
+	u16 *offset_addr;
+
+	if (!val)
+		return -EFAULT;
+
+	if (addr + num_of_bytes > chip->eeprom_bin_size)
+		return -ENXIO;
+
+	base = (u8 *)chip->eeprom_cache;
+	offset_addr = (u16 *)(base + addr);
+	memmove(val, offset_addr, num_of_bytes);
+
+	return num_of_bytes;
+}
+
+static int cl_e2p_init_bin(struct cl_chip *chip)
+{
+	int ret = 0;
+
+	ret = e2p_load_from_bin(chip);
+	if (ret)
+		return ret;
+
+	chip->eeprom_read_block = e2p_bin_read_block;
+	chip->eeprom_write_block = e2p_bin_write_block;
+
+	return ret;
+}
+
+static int cl_e2p_init_eeprom(struct cl_chip *chip)
+{
+	int ret = 0;
+
+	e2p_enable(chip);
+
+	ret = e2p_load_from_eeprom(chip);
+	if (ret)
+		return ret;
+
+	chip->eeprom_read_block = e2p_eeprom_read_block;
+	chip->eeprom_write_block = e2p_eeprom_write_block;
+
+	return ret;
+}
+
+int cl_e2p_init(struct cl_chip *chip)
+{
+	u8 eeprom_mode = chip->conf->ce_eeprom_mode;
+
+	chip->eeprom_cache = kzalloc(EEPROM_NUM_BYTES, GFP_KERNEL);
+	if (!chip->eeprom_cache)
+		return -ENOMEM;
+
+	if (eeprom_mode == E2P_MODE_BIN)
+		return cl_e2p_init_bin(chip);
+	else if (eeprom_mode == E2P_MODE_EEPROM)
+		return cl_e2p_init_eeprom(chip);
+
+	return -EINVAL;
+}
+
+void cl_e2p_close(struct cl_chip *chip)
+{
+	kfree(chip->eeprom_cache);
+}
+
+int cl_e2p_write(struct cl_chip *chip, u8 *data, u16 size, u16 addr)
+{
+	if (size != chip->eeprom_write_block(chip, addr, size, data)) {
+		cl_dbg_chip_err(chip, "Error writing eeprom addr 0x%x\n", addr);
+		return -EBADE;
+	}
+
+	return 0;
+}
+
+int cl_e2p_read(struct cl_chip *chip, u8 *data, u16 size, u16 addr)
+{
+	if (size != chip->eeprom_read_block(chip, addr, size, data)) {
+		cl_dbg_chip_err(chip, "Error reading eeprom addr 0x%x\n", addr);
+		return -EBADE;
+	}
+
+	return 0;
+}
-- 
2.36.1

