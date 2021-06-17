Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030A83AB924
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhFQQM6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:58 -0400
Received: from mail-eopbgr130084.outbound.protection.outlook.com ([40.107.13.84]:35463
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233592AbhFQQLv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YrTnCCQxzMaqWHdX7nRL2jdpoDcJMCGkYHNWk3OIFhUJsg2JuE+QVudlapVlc0GYQUQEreVlxwNgm6eCTIN+ldGdMZJk8pAO1S2LF30uAzo1u8KTLENudno7C4ntFqkfuv1z+pCugzsLbbwDgA1yB6X6ah0Nsw8R7p3po/vI8ID5TBHupWlTNAZyR9olyMhIq0IDlDGup/WuqO2f+CkiwxMmogDLwE6V/DVnFl9r0Q0Jpez88yT0qpRzImcgFKlRph2P86QJCXgST+NwbzX1+vph1BHyKpsvNT0nVOax+W7mOfNUdcRf9USoHa+4UZrAbCJ7f0q6V05ic/X3l6w0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTxKeZcVYsCUP2C1GgwjCfR8NZ8e8GfO+aBVbjRUJjc=;
 b=kkGkbSbLi1RxZZHvhUmk74/giTUXOOJdFadY+9BNVwuDqqFzEPB3eGQUvlwPr+VkWKZmN5BmiH1pdQL9h1ArflsPaPf5xvozZeIpb5K6riHgZbSpSav7TLWNv0Hbl4fZKA9u7D+eJiaAafAMxpK2njzpae7dgjLtKRYVr6pSLhSUSMZmkyrpwf0Zj98+rXMlJEcsEy2u3stCtjOggQQOff2eLKSI4ZgoVTLC31tZxsnkhB3dmSDskClG7/YqYnnFkWDs4TrWzYJy2AWxzRpGejecjEAWNlJbr+38P3IXJozEQPf+glKNjlaPquQ0N8jbAjSPv8hfhIm+uNf5v0BKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTxKeZcVYsCUP2C1GgwjCfR8NZ8e8GfO+aBVbjRUJjc=;
 b=JBwJAJmLVA1DmwDaCfEMFt1QxhIMaaqPnFu4tltfVanzZi/qvD9/oz3vl8qD0cz2iVPATJFfBDSZgjVNwLw27e7u+VJXkDeiniFy1tvxW0UbGXfLpQjJ5tvrH1+6a63OCRsNBniNj5rR1arpmea4kmIMwCSZDnAYCQPVSUK86C4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:34 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:34 +0000
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
Subject: [RFC v1 246/256] cl8k: add wrs/wrs_cli.h
Date:   Thu, 17 Jun 2021 16:02:13 +0000
Message-Id: <20210617160223.160998-247-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02be4a47-2bb3-4f96-99d5-08d931a9f594
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978B03B39808A170F637666F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Y+CFdcE2BIxecbXx54QJ+Ty/O2TxJMmVQX1gpCGrbE21ZbEjuD2/C4oAnfJIF1eDfkTu4n714NIdxMypG7GSuU8li3cuyhbtgIz6cL3FCFE3SUheGbAgZyAIB4R/h93e1EZzMYVJ/ZIlGvBAaZQztX/zhlslF+vc0550aBoUGuk16hI35guurLvlE3TZysXoEf/E02vCz/PNOZvwPj2k3qLZv6ug61M78hdmAnjYkMrAVfcNzp389Jo2ZG8SvSRv8RPSUmtnTT238Z5ixF+aufPozlNavZT/5mGYCgSoi666+liKHSDq6qv5BHHdi52RQU5YIeC4jnICC0KvaklwvDwRpW5mhwk3ftzt6YL/RlOcAsrJBF/Xt8r70k3Qo9O7x3JfzK0HldDAYhcpEKe0WKa1nF+duomFQqxBUkJbs8NwQDthilKIOTuVhIuMtIGhxXtEQ6L4B3FAOnufq9cn6VoFACuXzn+0EyB6ZPGBAaXR1FhzZlgUJn3BfTjGJK90d3jnlbvbtAWrgAJheEc7BQINx21f364gHl6pqBMhNeEE5z5GDHVgBIv+MEH/OH2GR5bVEphIScxTuvVL7k5UXRgEofkeBT5aDBG9gi+7r6eLW8oOxjBPCI0wKew2c7Wd5s8hagrPlw3DbCeA0TU4y4zk9iXGXfTu0oyrpHNZbYJOtxFLJtBP+EcvivDkw9fIfrG5gIwKvuuAZDZnFcRww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(6666004)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzUsVVEhD/GDqU5pLswp6GJJ+Ye019iUK3kJNihVZSfqbxNoPuwOfBjEpC/A?=
 =?us-ascii?Q?/ayV+96Noi+D6Ngt5LQFSoUWjU11d7ZotDKaNxkJd0jmBeualYdZQMEXUrop?=
 =?us-ascii?Q?ixwrSvkqunhpx9FRRanw83NYLGJj9cPmPgvmMSRKGNDoR7d0dKlCc3UXIMQb?=
 =?us-ascii?Q?0jvUtkIrsgs7cTlN2v29eQohyBayYhk8Xpe5gMZUtC0xN/Ilmw9bMf3lcfRh?=
 =?us-ascii?Q?/Igbn4SOmd0ZVUIo7dA0q6jEn1UX24oqNqxF0OeuSR4mg8mz8CwHaUjwdOHr?=
 =?us-ascii?Q?IA0cDemq9qJrPBlgolzZVs16GiF0d8ExCDsoTo1S2erTfazh2GIOeKI23BoX?=
 =?us-ascii?Q?lBW1AWyRN88X9Cz2YTbmjK/N9v5pqZsQYbaUSzC8lvPybu2RxlmC9UO7eQJq?=
 =?us-ascii?Q?IIIv1tY+CZCN0G3fhhHLnMVz+2qMiTwQDWqltTEbCkXXU44JGow6UMUE0C0v?=
 =?us-ascii?Q?OZ3TnZWD3tL5c5XIzRUy54dqgqivmhcGG+X9kD93sD6uwAhCx9X1doTRblGH?=
 =?us-ascii?Q?BCCFr0FOEaVFbfwFLIPlXqCZD6v4kJldB3mw2gEYZXLfJK1BvuUbGT9xCf+F?=
 =?us-ascii?Q?Ir+P0Otm9mGPQE3GpLSZ75WmEgLqWeT585hlgrB14gQy379n8H//4MQCphHV?=
 =?us-ascii?Q?W/yxj0b9gGyIBDyzhmbFXgwPbJDCkjD48OtAQtGoRyoJbmxBkstQi9BSN49w?=
 =?us-ascii?Q?OyEPRdLXhdbmZVbtrEupKveWkjyNNz4apNQjBdzeAnRUSCvw3HiC18tUb9rn?=
 =?us-ascii?Q?w0erSBKR5yENMDxxa/Z0Vjd1Hy27333MbSHGupSDH5om3ds8UIKXI4TaNrWu?=
 =?us-ascii?Q?kWSmcm1fB+ZQXx8wvYp5iXYeDsgCTYbsukoA5V9clT4eLb0UXMwJWGV2ty57?=
 =?us-ascii?Q?oZWk69TPWKbDH29SLdwKIXazWNXKDbSukfpCZxz9UVGRQqv6YWkw3k6+U5zc?=
 =?us-ascii?Q?xbGNKstH8j9RVWG/JEZBsOtGMXFFntotYzUHcaNeVvm3isqNxlmOkz4m5Wag?=
 =?us-ascii?Q?Y4XJdCyLNpNpBdLa3+vb/K73HHlKAiKqkTKMyDZUK1ZzyV654ajbBJzCkS4z?=
 =?us-ascii?Q?h0OnH+9lpPJ2F4u77P9v9zO/Z02tBYRSwfMGuVxZWaIVBHYaPglVrQN4brpx?=
 =?us-ascii?Q?XiBtgp4l6DipU8jcgF8ctq4aOKXpNJIvcPxjMdCGTzK9H/FsdffDq4YNh+/O?=
 =?us-ascii?Q?6eFgETeinyAel6M0gfbHhGtn1ink3G7myd3zTLazYQmVfd2GUka7/hAf7ua3?=
 =?us-ascii?Q?wZD/UFbNKRzAklipi8APtdD1XnsNhY5kNRWWVRW0MPl9z1uJO4/CH0iHGuY/?=
 =?us-ascii?Q?7w3ealeUdJPDAU7kMUkHrN1n?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02be4a47-2bb3-4f96-99d5-08d931a9f594
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:09.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f2ojYq03JdbYE22qAH5gy0Y8qfORfLWH8xTn7Vz+HykSS4wdxUtdlv0AkAsNBKUeHS+hZUH6tNUrPS7BaPPiug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.h b/drivers/net/w=
ireless/celeno/cl8k/wrs/wrs_cli.h
new file mode 100644
index 000000000000..7c7cbd9177fa
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_cli.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_CLI_H
+#define CL_WRS_CLI_H
+
+#include "wrs/wrs_db.h"
+#include "hw.h"
+
+int cl_wrs_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cli_para=
ms *cli_params);
+
+#endif /* CL_WRS_CLI_H */
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

