Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58946532939
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiEXLjH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiEXLjG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:06 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50045.outbound.protection.outlook.com [40.107.5.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9241316
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx7rtHvw5u8hyWQvQ5SGDv5ye/BW3Ol8SE1KnsTOhgtc5fEAYMe0IrGO6SOzks2gyq1FuV8Hkh1Hg3tHmwMujCNKrtJtRHfpbkW05+BI/CTwNBhaN/pr0jUcyBn3x/UVNvnYGtLfhS9O4rK5qAn/sttHcSmIv0wZDDG9DZ/fpYRt0Uz4/7ig7uXZ8+9233U5Y730mhYbyX3dR+0WM53VFU84XDKCITYo8DdvT3qRoCR6C77aR4U9CqnTIazgE8ZladGeWb0hh/Fg8nQVLIeaUGXBqitg8b3QeqPw9Vw0iMm84Lu+ieDzqEmohtGKRDjZUxqcD6SUfvs4aucEi82klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcuVxWpRuXCPem6tX4JQD9O4XBSTxEsEXwKxJMuu2TA=;
 b=fWjP/RFGlh8Jrcskn3VbvS3Ck8ixEJ9BVV9K5HjQ/o1ceYe5cV4PRKwG7iYEJVga+h/akZASsUfMx/fXXhKv93PuTKbGwtZt3FUKTX8jdm/uaj9MNfMXH1ZivMKKunxe2Rp8/WP4be/rjSzSbHoLDYs+8whUX63DS0B07jTOn7+hfoveJaSPkySuXQjOsTHx7q4Tv/MRjYA2R8y3ajeFqtcdjVWdQn1eO0V7QTmSuINRaVyDnrWjVSrunFsI+LTsgcyjTWtc1vdGASdo+BZk9xcxDWcO167gCFalZbRxvC+KlrN+Wg/0hjDIF1T3JuaqRrxDB+gfLyU+pI83tc5Ksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcuVxWpRuXCPem6tX4JQD9O4XBSTxEsEXwKxJMuu2TA=;
 b=0kNvuujvhmdJorNcH4FuTYByprM09z3sJAG9UIbEoYG657UnojcY3muhd8CsJ5dQAxhAScgMYjqu94Ci1haOAPh3KJSlA/e82RdhUrzqCHpafYK8xT5vS7XD/xupKmRnyJpjUlwd5Bqu6ez/56IUI7agtcT7At17Jgftt97AZCM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:45 +0000
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
Subject: [RFC v2 45/96] cl8k: add maintenance.h
Date:   Tue, 24 May 2022 14:34:11 +0300
Message-Id: <20220524113502.1094459-46-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3a1b938-733b-497c-476d-08da3d79e860
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571CDCC95AA1505FDB2B075F6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4aBZcKpw5tvMVT5Qc5UMkra7htnSVguOlgZ5A2PHKUd0L2+4EH6g8NH6iTRAiVnlqUA3IwvAibQAoDtQo+gvZwfYsDVCZU3Pvz+i9fOZVru8J5ZYPDn5gDrJNgtLkayxrg9lwEZuBVLtiI90WCePke0WxI0Ztx/lUBUzyn9Piq2Ym17Q1W8tJheo8+0Ss8pWQwPRsEYLLxVt4YWE34PF7jp+IkB4TVBsM9ng/kZMLlUUEJ6O53XseRMcVArfSBXWL0xGdfJTYX8JYP0nm2MoApq/D4AHDbL8EtLLHiY8rhzz8/xmx7nj9NoL9Q+LRBQUjbQhWqblUPdlbc5zD21MVUenvL1D+zLttHBDRPlCJSdu32kdxsm+yHnodDRT6AR3uxTykxRPhlIr3uzo9nOU6vapVhqHjUwD1D9IoUS98A8P5uNEp9occULmENlfTDKKySJzxGi+Ao0o8W3UptJMmHhO7EjOBhPd3sPqXHJCCAwOINe8jQO0JvO8hmTNTuNMoW7IFfaSpUbKOqKxghQrtNpZ0G61WfKFHtBMwkptCadFAJ6C041vquPVSponASTmaj3j7emIwLm6Btc0BLwzmlCIKxN6t4uVrVPD+RAT24mahThnqvOwt1ICxHfTsyE+76t4AJ+38Ljgs63O/+AdPPNys1cVfk5jIL3drCO2mng8glIkGm77pMK6CXesSxzwxq6/85MeD2YC/UdKqaZIXgY9BsoFf8jWfFCJDD1FXE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JiWf7+ExVPJrXeYrDnUNT6c4xOld8H74u+H2aIGIu1RYzRVy07yjXD866Hdw?=
 =?us-ascii?Q?WWHW5a1Cug7/SvfIL2JTntrbyJKe69CZkCZk4wUIHqvjLJZAIE+0qgvJNBmh?=
 =?us-ascii?Q?vfCYIHFpxlCWL0cGFMJxPYPZe5SSAhjO0Aomcv7y4ItyvPjD+ETucUUw0QWH?=
 =?us-ascii?Q?6idys2Ke6ePlIRc6OjKqMcmOKjCbXM1+BNV9AmQw8u33JJL3JwCAtvIOfDN4?=
 =?us-ascii?Q?HgUOgmHv+wEm8OkR89ksrqFDpuqzlBK9CLVrjzvJoyO7ikPbuAXkByO/XAuf?=
 =?us-ascii?Q?UCa8e6TOkkD5ZuGxvab0lA4Vfxs+0YXIwUCeo3W1f5+2WAEf5G8IqjYs5lv0?=
 =?us-ascii?Q?kBPd8LEK7qjiLzTEVxc2E2f6Z/CICNl0Czfal63n7d1RG8fdI2wxbhB63uqa?=
 =?us-ascii?Q?ixzOio0TZoP8NgAbLO4i8ENhiK7ymWERc266YMSSee8hQM1MOxl+gpxDyMUb?=
 =?us-ascii?Q?6i6vB99TKjmhl7Bq9g0u4Hd8mZ+gaymWxsnODRBnjQt/XkWGhVeHizAz5ghM?=
 =?us-ascii?Q?GUux0vC2Cxh51zEbuH6YlF4GmBcSzPuGL+8OuTirb91sH9IBEMfoBC9qlW6Z?=
 =?us-ascii?Q?vugeE9Acvf1nslMubIGWGUT6A0yIfJT5DCIfLUs6c0eEPGB2VYQSFYFRrL0W?=
 =?us-ascii?Q?mDmmyxYIJuVzX7gg6opGGSOXMIslYOMGYb6Y0UaXxp7/MZP12KNEa0zsXrzX?=
 =?us-ascii?Q?e+npR/25xxN5yNORcq6RZXH74BFaUlVAFqxPcDKMHkv5U/P0Rbmueah6Qviy?=
 =?us-ascii?Q?N0VwgxdWZNNYBS99oeW1pYOm8lgYbWe4bsdvHVmW0jqb6xCiKHkGp1YYRIPv?=
 =?us-ascii?Q?eRENaB82prAbve6P7osD6lmys/UrDB4/QWkoMS3MimyLdi/1EQ0hjEDGlqBR?=
 =?us-ascii?Q?aYpi5gk3ehvKQp1R1PDwwVURUrxh6PXu0jBAWN3ftXa+xHfjk8g1BMnXvxW3?=
 =?us-ascii?Q?k7orSJJ7y8T9TnrBlocibNmeeYtAuvIGxbIe5YPV3QtnQXm8nJEF3mIilGYw?=
 =?us-ascii?Q?B2DOVQlCau5n3s2VCoVtYAmgNBVkxImFBCZlCQnu3SB+6//uXotkr/75ZqDh?=
 =?us-ascii?Q?zzfQIXdzLH7bBCmtrFRZcNxVqjdUuwx67e0Sjqk4TISkl1Vbe/RUbpkNmZbw?=
 =?us-ascii?Q?hINccgod2tEYLTp/zqOhSZ+FbySdyHjPaVy3boUdKyhL2KSWFQzlfP1rxKip?=
 =?us-ascii?Q?5p/NkUnjjxd/jMYbUFXASvsQB+Q6rlrz/b27u348FwyfDFJhbX3VmmSMBfWs?=
 =?us-ascii?Q?BPzxcWC5yhyL4p8oh07H253cf7vI1YyGs5+8Zo0mTnaqJ6WisMIqX45yWeXf?=
 =?us-ascii?Q?W84S/6EXssywBY3EX9Tg4z7W2mmi0EtXXQ5+KHYu7EKGr6EWFd7NO2ojCEIj?=
 =?us-ascii?Q?9WFRazVfTmkr4/Rse8CG6pkbHfDx9I/J2jdkWf3fKAeNJXin76zFKxa6NkV6?=
 =?us-ascii?Q?DYdHVvnLZT1ZlyiAPiOijpzzi8eSZ1N2f/46DP9ECvqkHWNWTjEPmk9msZZW?=
 =?us-ascii?Q?RUl9srNEpszDsFtv3YVI8YR9nrIyis1GBn0O/W9UlbyQ9cqy8jqNaT4fmy7i?=
 =?us-ascii?Q?46ere6ogUAkJ8SGmybuISuLTYO6D3OZQtXwA8QqZvfYargo/iuDA5Ay1+roz?=
 =?us-ascii?Q?qozE75imWg4AM05bcCcoiHfHNJ0eQ26kGPzRGY4yhvbu6n+LFLwljyuulFDF?=
 =?us-ascii?Q?Hk51isCJMYVsHVaKjzt/No5SczHPbN5+2BvFT8+GwjmNvTKKxoyu7wRmEIsA?=
 =?us-ascii?Q?VKYHZtuvMuGfmaMPMmgG6YPizxTLPvo=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a1b938-733b-497c-476d-08da3d79e860
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:22.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+gcFr2f9ckt4zsWN/GIxpSB9zukMiZomrxF7aBgizS3oUnE4d12Iik16z0KglKETkipY/Bx4jGAvA4lXUN4hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
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
 drivers/net/wireless/celeno/cl8k/maintenance.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.h

diff --git a/drivers/net/wireless/celeno/cl8k/maintenance.h b/drivers/net/wireless/celeno/cl8k/maintenance.h
new file mode 100644
index 000000000000..c9d1526a47a0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/maintenance.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_MAINTENANCE_H
+#define CL_MAINTENANCE_H
+
+#include "hw.h"
+
+#define CL_MAINTENANCE_PERIOD_SLOW_MS   1000
+#define CL_MAINTENANCE_PERIOD_FAST_MS   100
+
+void cl_maintenance_init(struct cl_hw *cl_hw);
+void cl_maintenance_close(struct cl_hw *cl_hw);
+void cl_maintenance_stop(struct cl_hw *cl_hw);
+void cl_maintenance_start(struct cl_hw *cl_hw);
+
+#endif /* CL_MAINTENANCE_H */
-- 
2.36.1

