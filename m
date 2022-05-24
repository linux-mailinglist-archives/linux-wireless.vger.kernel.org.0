Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442CF532927
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236804AbiEXLiu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236813AbiEXLit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:49 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A708CB3D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enEAV2yUHwrNa5S7nU/PSwbcGtZZXUZC0N8NyRYsgGRqTEVWK3n6qnYwA2b+sWC/BkzgFBploYkEWYD5c3LRB3WwuWoaw5NxsUYFcU8n0QCbRIodO6x7m07LzK1kYosMUBnkUJt6KzewMAYtx0bF0NjPqpRrov7W0bYW1gLlOBr3BFGoaKJ16NXsb+Ayl961e/KgvjVKkqBqSLRH2i4h/vFno4E5WJojB6l2TPJMVoUiyGc1vZYsEFbKZxuffa8ESJvyeLbZLyupBU2uCeOk3vVlXnq8EQKkRYFJmBenL4mPJAxdk+8Kg3NvVe0SWz8cxk1KgeRsM3W+Bs9F/GP1EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpDkQhgmR2figWUIoKaEzozOhSDXVZziNtRpXzlq6xE=;
 b=CkOA66ZKHfRq+2+7guGZUOdztD6kBWrG2oG2Pcyof+vkXJ2MmTHo/6mSov3W4b/pEQ0Z2vHGdoqRXV2k61FVnlFlWjovdRDZzEDCBlqqcxorFgxyWf0Qftpn/Evy9hInAFINDACcqrWaX35gk9ltLkjjpG/WAfenUko7DIV0YV5KESeeTFX9gRwqlOQH0sxdddIe3dR3Ucty8aLqEkmKESlF+C3+dfo2/3L4o4WUzrNeLSpxb9e+dca7YGzwfqz51C1bbaVKtTLMAlMY294g99NShCvH+P7gpfQyr1YRhJquckUSe2RLd5l4/bGxLV/vCrWAAFdDIpjg/xdOIHa3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpDkQhgmR2figWUIoKaEzozOhSDXVZziNtRpXzlq6xE=;
 b=R2n0SyUPDNe0nkkLsSDqawFHseIO3KYgFWh54cYCOLwSG+iGE9kBehbVlDwio5ZUG1I7ieTwtIsHeFwmmqG/mcQDe4nmR2FdYRlYbmhZPfXZvsfCG6ttcLsFLCtA0zXAbNPQWJUPQ5E1QUaeVNs9QMHv0buSb0mcRGKLAl9+KaA=
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
Subject: [RFC v2 25/96] cl8k: add e2p.h
Date:   Tue, 24 May 2022 14:33:51 +0300
Message-Id: <20220524113502.1094459-26-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 448de6f5-10f1-4636-d15f-08da3d79dbe7
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469CD7076726715881692FFF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fyl+2leJqlRLA5h0kZXKrFJGE8oKwMR+GBgsNRElCFqcBHloEXg//hPIWD/kEZulG4Wu2TLGmtmJg8KH4t5JAkC8ZtWE2wBTNbJr5IHVwam+YFAQr6gNiOc8L33U5oPoLx3ZLuvz/SBuMzUi61IZKSRt0JqQjz3piSmzz+MJglBLFfrcvwFKKdut68jGP6NvwUp4zEsEb+sGcaYtIBfdTBeUyVRaAQmG0YEtg0xjdRw5pZoBSHrcxxzgtiJJXw4t34ilu7ct7fFoixKN96IZ7ltOwtKPUYHhDHH9ffhyMWDVhcG1ThnGo4y93FgL1xFdRcRtkSEG6NEKxfaBXam21pCZ8SXlyKD+3vn9Tvln3Ip4XfjVWc//1CduRtjxZDfDzWpzkvy5sp9PQucGSZ0lL/AYjtsk7Saizq/LdhVghkwnmq1nasjhM+urEDrSmhmiPNKCstm/aKAeZs4u41oJWYO6gSJ8cB94YRKVqVG3RXF4PUwo1u+BNXtvsTMYWbEyBpC13IZObijWrWWkdBbvmhnLOnCcDYrcEIbTDxzaNAztoRKDNyQlqUwgWW72ImXrC42JJOadDc9VxQXPVyOl+7VJjvBgriKvt/16ngmG/3BbyhNCUmPy3OnPPYR0aiEFqsn4jwqY5nH9xaZrXgD2ZKgd0MF2dGrnbycjeMQgKVswkoNHCtPQoSLrdFrTM8E4VgRh92Xe7srJhgRyt0g15hQXZ5PUyBRNErKkYGsvN+E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gagFCHHbAyCzRNZDsFRIm+Y/C/P+hznjOUAV+Fgn9eUuWCikAE3zHbUXc/BN?=
 =?us-ascii?Q?fcuNkwo9EyilpPC7HHENoaBA7UPTzyNWcvpgiGOZAklzPgTX1TyGA/kNzo8J?=
 =?us-ascii?Q?Cc0mTTo5ku61nyySKqnuooa7kChRfDFE5t2WaME3ywnuxvm5+e2RtMklFeoQ?=
 =?us-ascii?Q?VNjqWnP3kH9nBvL1Wb8z+MR+1aFnhqLeuc7FCaAc0+w2Bqpswd4pH5P65S+Z?=
 =?us-ascii?Q?1tef7jX52+qtCmMgs2GseeQTiU8xunO4CMfUdrdj9NFO/vCKHQQ7FwuZP9V8?=
 =?us-ascii?Q?XGPKvP8L4s7pksKZZkm3BhSRRXotvqgiQSnAImjKHTZ+4UR5iahWOTajstka?=
 =?us-ascii?Q?pQEg3iLIdMTYs4HkfYjpBDoUNK5ZHFEgChyitkYvkX0uHhTpbvdU6tYquebh?=
 =?us-ascii?Q?alxtOnh3wMHjE7j3b2RyhYf01ZBYIc3PAdSwQmzhlmNMZDJhjYx5SSx9BYts?=
 =?us-ascii?Q?WH6nybnxYLHt5N7wleS610UwH8876dlEq2Ax7yRB1X1lHtC3WuINHtGW5dei?=
 =?us-ascii?Q?A9kdp1C02bivJfZmCNrldGsJnw/x4SdcwFM6s6QT5Ps5rt11o2UjBCP6LOB+?=
 =?us-ascii?Q?EfF+kMWZ+Qx74jIprMxcR3NaZ1V0nREmtUHgfR7VTZRLuGH360t5P668nB8B?=
 =?us-ascii?Q?XkxgeEtuGO/1rfJHmlQvNB+TTISmDMxubzWRAsE1NJ3ZlsDXhn7EPYp7xfze?=
 =?us-ascii?Q?BzehWAtnMXbLMdb0PgoXDXGmw34OVIJQswBiz04b+B01ur7UtIGY0xRxMSWy?=
 =?us-ascii?Q?La3XLgMFsPggCw7UAOxiAT2WQq84z96y+joHnssJKbl1lp3BMusit2T71vI6?=
 =?us-ascii?Q?ViwJ52Rgi0XPzVWx2kyML0bnmMh5LGxD9D+tgt0YcN/CyVLEbHIlcriiBhLh?=
 =?us-ascii?Q?XnYwDaAKgWylQR2PBbE6ZP2P5AmzsBGoiUIB/RIAWJwGnlU+BKCLEwM/L3wY?=
 =?us-ascii?Q?viB7OP4wUJ6olYzjELBQge8mPEUpd0YMYmhAg7Ju1BCQyiN9jJaThVzjqq0l?=
 =?us-ascii?Q?wWCr60XROO8weeZAwYpkIUqLWJ4W0O0/QR7ZU8LRB0cYnQZiUeV1ojZro7n3?=
 =?us-ascii?Q?bQxGJPzh0JnP/XtBw/Q9uROw7uKHqfqPox51AbziJo8bZx3yLAUJ7Vv8pTXK?=
 =?us-ascii?Q?CEoumS5dLiHWcOKnTEYMqj1sRDg5j1KKqKVb6S3FW299a3qldPYGPOAF3jsn?=
 =?us-ascii?Q?esSqHgCgNkQyML0BjNZ1ncTF9twhYoZNnF59mwGMGfmMArj74SVCN42bME4n?=
 =?us-ascii?Q?5RY/LI1MA/Iui9mmWY55OSwfYUZtaWF7IGwKhZlSkh7oShG2/fMBi+Xky6Rg?=
 =?us-ascii?Q?DmKxFNn/VC120mXNOeyDzS0tX4/nlDoNSXkWrNeyEnlMTys5wPsfpGDJMjYB?=
 =?us-ascii?Q?D38phU3OhezVmQ7hrDTftN3WrDnB1l2C0cBTzEsXwteR8AFBLzS6XQyYNzOq?=
 =?us-ascii?Q?6FOeyf/NSjx/+HdWBliHqJXOTLf89gHJ9Qe6BmRxgifz7bzX66IszwL2Igcw?=
 =?us-ascii?Q?O4tmVlRhbLEmh9CxcLbTRQeNz1SxpJNfIj6vw4RHzqwDszKfiZT8PmNYxsjH?=
 =?us-ascii?Q?aQiqcFGcPeVQjBVHM/GlgMHxcPy69ICG6bes1rQUxJc6pogIjMasmw2nEdI9?=
 =?us-ascii?Q?BeZYJkrtJjCDkXl6y+sRo1Q/TyCsfuD+4f8U1e5WYPT3b+5N6e9j7obfeCkx?=
 =?us-ascii?Q?70/2IRlh2alxMNb65nP8KaNfDTh9ANgWVB4wZJL7QJggX4hiQoTSjGDozwsh?=
 =?us-ascii?Q?DwVsM3GyoA2VExbSWp7lNfJBB+4xuOA=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448de6f5-10f1-4636-d15f-08da3d79dbe7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:01.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: naDBATcsKmpkJF0bsZ8AFfJEg1UpLVvY8cgj+wdgjqnwokFJ+uS4+gAI3YUi8acMP9kM4fyJZ+yiK4Y+ItfnxA==
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
 drivers/net/wireless/celeno/cl8k/e2p.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/e2p.h

diff --git a/drivers/net/wireless/celeno/cl8k/e2p.h b/drivers/net/wireless/celeno/cl8k/e2p.h
new file mode 100644
index 000000000000..3545e1d110f1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/e2p.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_E2P_H
+#define CL_E2P_H
+
+#include <linux/types.h>
+
+#include "chip.h"
+#include "eeprom.h"
+
+enum {
+	E2P_MODE_BIN,
+	E2P_MODE_EEPROM,
+
+	E2P_MODE_MAX
+};
+
+int cl_e2p_init(struct cl_chip *chip);
+void cl_e2p_close(struct cl_chip *chip);
+int cl_e2p_write(struct cl_chip *chip, u8 *data, u16 size, u16 addr);
+int cl_e2p_read(struct cl_chip *chip, u8 *data, u16 size, u16 addr);
+void cl_e2p_read_eeprom_start_work(struct cl_chip *chip);
+
+#endif /* CL_E2P_H */
-- 
2.36.1

