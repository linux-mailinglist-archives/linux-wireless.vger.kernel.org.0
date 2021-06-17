Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997A53AB8F2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhFQQLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:19 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:58153
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233730AbhFQQKH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awxnpsEERyUHQ1aOcDjViiygNoMqQ0Zaloq9bX3UvbKCHezX8LOCDZ4419NPa7YyFxR1Yx/O99+ZvPB3btzVhjb7wowkUk7k1FrQzupeVr2VFyeqw/4NJFbmvuT8Uba2QtXz89wTt/QDRsCQLNn9X37F+Q4+Wn16JcAd4pGwXP/ON2Zvotipf9I3L9qwq62Js3RtGuPdeZAq/ForL2IvUNozdD5oX5loA3P0YFQ8YiwS54Uyu69iQi+7/z572St4AMf6OMbw/Nwbp4GpwDpQEVSbT9SmSVKD1YYWLhYpvPEkQwE2nlZBPF77KW9/YzTUmSLgEr0yswD74+BEY2ErfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3b+E3DpGQ8PUSAuJm02XPJy0BMo4drYvgkbW0/jdSQ=;
 b=PbY3VInhZtdZwQc+vblMsjM6EePLza/TaQQ34zAefUOTAFRPSTum7U+007F3pxQNdTDWVLMKhj1jm1LEsVtAB/YNSh/etkeL503CpBqWGTog1YvaEULpZYPSNLBObIHb/utTfHkFUONjozuhEoXKkJ6SLA5/oIOlVRscekGrBZQk4pXClK56FGAhCbk1ImS3Q74DdwPDYOa88K00FkuZ5gk1lQMPlOrBBK0vdF/x1TSKB0T8IbbdV1aPpYG+OX86SYcvNr7dzSVJTyDYZZcc5FtdPGkAihXv/FuGYZGPqm1sIlezAUcH9CO2dD+rDSsTre82RP+uRRweJLEh+XKRjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3b+E3DpGQ8PUSAuJm02XPJy0BMo4drYvgkbW0/jdSQ=;
 b=q/coBeNZKkpI4DYFIhkxAHNI0LeLVdcyGI7Run7vR3d0bFN65SK29gHbMhMYp0b1aS0Sia3D6kXWzjEu8q2G+pAf064543LS3Nmf0jdnK/mgTf8/h9hJI9SXS13ZIGtEjE/C7gOdVJh2Po/xHqfENLY1vKKA0/DslsrTTVAMQ+E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:53 +0000
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
Subject: [RFC v1 221/256] cl8k: add utils/file.h
Date:   Thu, 17 Jun 2021 16:01:48 +0000
Message-Id: <20210617160223.160998-222-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 198256ab-fec2-40d2-08e2-08d931a9e510
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0452BB61952E2BAC2C783BBFF60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EnfpAKgNaTdtufOIR6qWcElSdYMNNzUB3KgO1Jpi//IDdUoVjZVISRQ1rqWTnlEsYeySvthdBpERQjKAGpMx/msUwtdQ9AniCG5I4KbeAN5hNnx3jW75AbBQlQBhLiAy8QuDkCXUWJ4DL5obP492kd3Ji9g+6sDOWSjvOG5ICZqZMCMPgeApoyAMxsRUgJrvbKNS2bcNOLBGUEFKuXJJO7Tjrelfmna5QHAzHPp+HBwaEI/WCR2TOvOxLcwMofUB1+eVbPWziSfQdEkmMrgpC0MPSRif9PkmcVlAuB5L6vObVkDcoMuiTfWZIKHJ7VQYgkq1RGJs0b5qRPucsLAyio9Oou1ilg5PNz7bPa9W4qTYBXphhqAUsPcrjHpvD1h85YDXbObrmz7jizwNVxDCHVwQmGh/tB53okOL5oo8AHYLF3KgqK8ZOdUjd/bl6FPYQQFCUcKW+AjI1ju4ZFAirLKqhp6Hi1G8kvvZkCQWKyMVtNyJT0JR7sfJ6+6VahCzbIvMzZv8Y6pEXsakluTmB3LWuAxM1mdt22EjNoat5zcPMLCXoDZwrnE7Cf1clMikHuLQWyrohpCOoVgrqh5ZVmIc/Ws0xioPDFPykfON4e+zHujpOc/VaC7d+jLPEjv5iozLAHEz8JNVdBZtwk+KfcUoFAqr9dy2qe0bVWpJnbAWercyrDh/8OPCXai2X9zvQJWbjpcNKQfDBeush06TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RCpaZUeQtSflhfGvEOOnfJc9F1Yqc2u+4cIjL1NjqBStHnKJPvpc3/m96uhm?=
 =?us-ascii?Q?UO/dfILE29w6c42twpGX4nRCHXZLna5Bq+N+BgbirNZs1XM/OXA2AISB5Qxd?=
 =?us-ascii?Q?EaIWWXG9FhJVNiyrWdj5DVvCuob6oGK5o6a7HduiJcpPiaGK7GR83htyQy/V?=
 =?us-ascii?Q?KBPDOuG1V3SPcrpCzSCBc3YQBPeSxTaw2XdeaRdackov0PUg+ezOGlR57aEv?=
 =?us-ascii?Q?p2XCYROc/WdLpiOekAaTr600Z5+jpFvAsn6EzZzmbY1MStouR+HvODRpor49?=
 =?us-ascii?Q?R8krEHkOSv+IBmI730yRk6U3DHQ9T9/z5YKnvdJluWo52HsdPkNOntYCGWKh?=
 =?us-ascii?Q?r16X/Luxgn8clz0tcsdG4cspp0n3/79UMPTUZJOIN2eiXkBr5e414X+RMoaq?=
 =?us-ascii?Q?ORqLnWHpbMqhsUhCWuz6faCA16mtQ+WfhSRmGQCWtCeDLROFQTwXM1qj5lKp?=
 =?us-ascii?Q?q5ZjoGUA7sdZ2QZ1aI42Oqyd7l2gzDEE7RPgryiawlMbCkHwN91MyJfbPY67?=
 =?us-ascii?Q?407FyXK+JA9rmxH81WuPyMLjbFcSseXzeVnRvKparyf8IrVtI6Gq2IFD0H1Q?=
 =?us-ascii?Q?pCarnl4K7hyuPx49pbAlZg6D8q6gJNdFpG1p/W98HCdyEscy/8n4Dequjg1u?=
 =?us-ascii?Q?OOKk7fIC4/KCz9I7AwIdouNTkftXDmdVgF+hIUnXuUTsbpBVDKDLRge7Glhb?=
 =?us-ascii?Q?WA7GmaeyDDzbIXU5djEX5AzJirR8nS8HyKiNlKQ76Tq5ALRgoB7UBRqF2Tsw?=
 =?us-ascii?Q?XOvlIX4urbzRORfTj5VSZvlespFtUcZcEcpbjsz4di2jI6torA2vXQ97UvRT?=
 =?us-ascii?Q?nkLJuAYwJIHNU0oLpxPc0T0FIT+6giGew6gpMyn+klZxbEteaiBSnp9QW5DL?=
 =?us-ascii?Q?Z70Qk3i48SR9YVXTnfs6y3XcHS/4ffF0hbCsb9110up8N5Sifd+66nD2JEYx?=
 =?us-ascii?Q?xsLO7oHWpXenEDWDJLHl+34FILJntmJKhvxyIRPw8qrxFyta0FbX5iyZi2Zb?=
 =?us-ascii?Q?NsrUnPSrdnQr7pAMIIgVAbayWz/vYcorJKHcaofuznH61uKunxLTZdU2MeCi?=
 =?us-ascii?Q?uO5jUDhlQhC0cmfP2TV35ki6897VCEQU2XCfAuSWdSZsIy2D+WqDAyAAJhyV?=
 =?us-ascii?Q?NBY2NJUF1WwCwICQD6bXBkwqsogkEhcbAikTotcMt23LB9tIzTqdc6G/wdOJ?=
 =?us-ascii?Q?TsiNP7277gXgORVFL7Rbyjccbhqyksd5x2l0ScraUR3UZ1wKZs1K1LBLiJZ3?=
 =?us-ascii?Q?+XrDOFAYjgwA+l13G126Ra5kpN/Az31NPcgj4zRSOhWi1ys7bcxYQWx8qxHt?=
 =?us-ascii?Q?WXaDumgNTqvnsZ6+Z8kRx5rG?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198256ab-fec2-40d2-08e2-08d931a9e510
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:41.3336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O+EE2BYvKpNHIQe4jWkfTcM6i5vlpCaSWBYpKDYHzcRqadz/Z83c73C0fbVkz7XhHCGGe1a60EPCUtCf279PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/utils/file.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/file.h

diff --git a/drivers/net/wireless/celeno/cl8k/utils/file.h b/drivers/net/wi=
reless/celeno/cl8k/utils/file.h
new file mode 100644
index 000000000000..331666524ef5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/file.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_FILE_H
+#define CL_FILE_H
+
+#include "hw.h"
+
+/*
+ * cl_file_open_and_read - Read the whole file into an allocated buffer.
+ *
+ * Allocates a buffer large enough to hold the contents of file at @filena=
me and reads the
+ * contents of that file into that buffer. Upon success, the address of th=
e allocated buffer
+ * is returned (which needs to be free later). Upon failure, returns NULL.
+ */
+size_t cl_file_open_and_read(struct cl_chip *chip, const char *filename,
+                            char **buf);
+#endif /* CL_FILE_H */
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

