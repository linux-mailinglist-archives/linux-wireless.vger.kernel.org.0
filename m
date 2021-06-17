Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414303AB886
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFQQIp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:45 -0400
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:41442
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231876AbhFQQHu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHTac60/se8wEN4f86nfZ6E8cxBdIjYNi9Bvw5bhXbJyhHwrw6TGSXJW7xKmCNeTyk6POhTy6UkmlFhXQXulzeOyhG6xzkoXpikbaNpDym1tWvEOftpBh3KFq/JbA8adPuFWoXPhjP7nb9JR0U35KleNSyFDZLXzT8GicGUr6rbm2ndyYXgSjRu3vRq1iX+AC2VD0BOV/GwbU7kCxfjA5gbG5fJTcyrhn+x5BVOlSHvnU/ZkMJ11Wxzo9/H2A4uVdvf0wcBy2VOR7ty9ua/dzVB/UltOrcYdzfW2QB7nfT/OZhEPExo+aqXMJVze4Dj65LOzocNoPn+HrK2BRkMdAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIUeCH1SRGvG0645fMOYbUAFw+2xRJhEtIcsZO2qp/A=;
 b=W529/7WtP8YfQi0pusrKsTuR3c6HgfNyQh9YRnbvjZKtPA4Jw+P18mpfTm5S1tviG49GtwmhyIaz1mSedP/F0rVBJnaC5GY7ZIxvx8geS+AQVET4oJGBdLPh0GqZNxS19MB7c+6HcPJdSdKB6saqzidTjcVydD6sxyjFZl597EvU7VWipftNDLxA12JqMy8UDkPCsFyi6MmsCDoW036PKEAqGBzjeb9Dfd9Ovm7Lm1r6a/jNdS4mHVLHdrxVv01HryRKxcB2BY+01xrpxSFK7u5xDrcgFF8YkQ+Iut0pe0binfOYmgXPBniuSvzmLaq3VJyIQHW3XFMlcEZeuTgsEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIUeCH1SRGvG0645fMOYbUAFw+2xRJhEtIcsZO2qp/A=;
 b=yzV/+oo2XegmO4RdtC4AwwSxD1RYKyf5+WYfaLaK2SgVRaeyZs2vBJhbuE/t3iO5n2wLngH01fVQqPaHtTwX6M7PknK7y+zgTZhoeH9xV6DWFPs5oDeJ0JMex5tNqR7fiseINfPEzrfe/gRHc8lMczKvXEJ2OI+iNymPjPrTLSM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0402.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:46::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:09 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:09 +0000
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
Subject: [RFC v1 112/256] cl8k: add maintenance.h
Date:   Thu, 17 Jun 2021 15:59:59 +0000
Message-Id: <20210617160223.160998-113-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac3a67ab-d5ab-4204-bf04-08d931a99b69
X-MS-TrafficTypeDiagnostic: AM0P192MB0402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB040270383BD5DB307226CA33F60E9@AM0P192MB0402.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnqxaMRwA0xPuP6ZAEK+/RVc0vAk/pX1xwGKeqUiQG7NVrfrhbtveFvxvnISTrItyXJf0Awx1G7/l2xW6Q2E59lpidTZ4cTmVpmA+L+xRW6qkeRYf9A4zUq60QLdKrjiUYdhunuXfKYo84GCpFTaoRgOXZI+yudyMyMEcpT5HKBUVj8jNfF1gdPAGX4plNKso7l8eV84gbrCd0ssdtYW5JDttpSfyMXG1ehgAS3AKnVx9JYwveuf7GhCOgzkhEykJrZ323AebUQd4DoGBvnjbLlpRRGWDkxSjZJuQ9LI36sw7lD9Ob3pN3RlJFA/RSJL20S25sPw43IAShsLG4IpF8jVCUzMpVuOZJAv80Od+CrRbI43Va7HrEY+xiNnyPIPRbOIlSgrhZx8qNR8bJVpECciZ17AERq6R6mgiUMvlYq6GC/lAPWDQOzSi6MWDnuqG+xYFGCVQ3k8qATaLzi9amLJjGLiJ4YE4khLU4EBxl2pxzCGAKF1uv8tFcwLjdNBKirDE9g8vNRBvfHsMjPRfLAF0R3i+uZTfX/Nv0YL6UmEUf8u4K7bcMjU504RARFSssk8tjEsDHyMTJ7gLUnw5K40pIF9Lg3ZXIyqlX/X+TKxZsIEZf0B2+9PJtDlPI73QLgGV138cZQTjB2l4sun5YZkgVuHEGUxDXVy2p2/wY3lRICxIFtuTt3u/gfkCZpolEnmzZdUYIGLJs21qH4vdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(376002)(396003)(366004)(346002)(6916009)(6512007)(9686003)(6666004)(52116002)(2616005)(186003)(16526019)(38100700002)(38350700002)(1076003)(6506007)(5660300002)(107886003)(55236004)(86362001)(6486002)(8936002)(956004)(26005)(8676002)(508600001)(2906002)(36756003)(54906003)(316002)(66946007)(66556008)(4326008)(66476007)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?McWpxNSHq8+HJqQegxhZmWfooulImwu9Nuw4s5UjuPttJCwWWWbxy0swj42a?=
 =?us-ascii?Q?5wj22tT6AB0KIonQVgJRDC8zaNbaL+Sc9u+Y2R6bWPWLeYHcBt2iuYbOJVfm?=
 =?us-ascii?Q?jIiyZ8RKPWwDgZRQ1lXtsDetRpvMoyRVfABd3UVeelohigyTG8rrJRrbl0u1?=
 =?us-ascii?Q?zmvf2e4JN83orOzSI5I6RPdalvwYQ6V92A+YDCAeIMjFIIVagPbaRyBPnrKD?=
 =?us-ascii?Q?A8HfSky8Qv724EZCDEeZ9VJdcsF7NnKewibEFMKZvjEwFi0E9ZCWdPAQdHxN?=
 =?us-ascii?Q?h4cD7JDqlHoO64N8+Kk7isawt+1c/TArti6kV/2kdijRXDlOmYU8NKZQjfbx?=
 =?us-ascii?Q?YV+nbOnKIGkjxiKDm4E9zNUwQmwIk/BZOXUtBhf3SMdW5XrySCFo9lzmpH0P?=
 =?us-ascii?Q?ZfdVl54gkBXk8dk2hCSPwBCt22rmOEMrOooHG9TB7QvABa6tCYhfOxgoz0to?=
 =?us-ascii?Q?XdLHpNPRGo6oGhPAKgrtNQ1fYHhgv7Bu2LHkJedoIX6ZX5MUZq+M4difwN15?=
 =?us-ascii?Q?5JoTrl4MTrX136A+w8aM8uroXvCLFJiKMDek3OachTPEq9VFE3UBWVe8LgNt?=
 =?us-ascii?Q?lhoFShAuEjW81EIAXvTg+ERlaOv525Hm+oaUvdJkv8A1XcbFFJ+eIbzcK7jQ?=
 =?us-ascii?Q?vw5stCCG1e2B488nzqv76MPVe9mjI+98Et/m/H47Bk3QfnkqYfYonLUc4axk?=
 =?us-ascii?Q?ZT6H0XXAU6TEUyYSeWSyx1QCy6/fum+zQ7VJRH6iRVEYR/AgH69H1zp0u8F/?=
 =?us-ascii?Q?lPLNrlhXXPnoOwGT+hcjbmoblsrNC2TWuF2TMX2kY6rEYFlt0Yf9cKnrIzWX?=
 =?us-ascii?Q?K6DTE9IAICbGTk5HdOu9oMhejQA75esr+7towFqH7Z1hqq+pen9ATkURMyS3?=
 =?us-ascii?Q?M05p6qDq3NtM2P4AFbLK2dtHDsKlX2xdH5azgQKvZIUQ0pHlGfzQKttjM/OF?=
 =?us-ascii?Q?nTRvl0KjxioWWQFCWZw/SCxkpblsVA2V1Yfgc3eFx4Rtyh4kn+CVgC3pGMlI?=
 =?us-ascii?Q?Xg83vfC0KFmM79lVOuVFd1GvVTB6gB9kKyA9MuOkw+HnBukADl28j72n6mY3?=
 =?us-ascii?Q?5Tjp9sEX/UU3CW42LWEHEBjGHPzIoVcZLfssyElLwXFNiInKDZBEfv3F5Fnd?=
 =?us-ascii?Q?GWhWcy5j8bO14D6MZphB6j9ta3qRnNvhWdc/DarR3M82JsJhp9YXtzEfSAO2?=
 =?us-ascii?Q?Bjs2tJo1861gCKYpEf5odB/Tgo4cYCVZnF6Lu20ra1SogEWwl6Hy9jEoxhcR?=
 =?us-ascii?Q?WwCnOT7Fkos0r6PJlDkGDoMcTPcvBGEk7ua2bsgKfWXXGktTVi7uYD1AQvoi?=
 =?us-ascii?Q?ybLhjy7/UNIuN6m57Hsg4lWZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3a67ab-d5ab-4204-bf04-08d931a99b69
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:37.7592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZh1hRDTsavOcvB2/iE+/WRUlaFQ0nZw3u8rghHAvNG1U8O3ED0gn5DOw7eXDsQZFiAOIPi9QqoSbV9wkOAAEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0402
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

diff --git a/drivers/net/wireless/celeno/cl8k/maintenance.h b/drivers/net/w=
ireless/celeno/cl8k/maintenance.h
new file mode 100644
index 000000000000..456aa4e75d4b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/maintenance.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
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

