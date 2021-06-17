Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6693AB84B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbhFQQGT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:19 -0400
Received: from mail-eopbgr140058.outbound.protection.outlook.com ([40.107.14.58]:8512
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233641AbhFQQGC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEhQVMyVTrkXVvQ5CXxOXYkQ8VDf/CvZ3qkm8D+GOyQjd5LRudxPfTsyLJtM6ZaqG9RveYMqpp1sfTHezdHRo7h2p8SYYt/rU6oiHeKmN3hFzouX3Y0/z4XZaJz3cKmnUZ20g9ZsrIqwh5cK5MY8RohVdLOtyLGFfaujFXHQPNcn4pdr1AED2BR/eLHJexel8YbUMt56sg0agFsW82YZIs8fPR7Z4soxKLrB6R0cobBieE1h7705QrphFVgn2AQrsAra74YyksWiGjQ85drZdUU6hhFR1MM/zw3mPZxMlYAAARtVtLSQqumkV1IU5zvLkqGLqMh5P+tBM3xpKLsNUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hZgrx06cJo6mnAyLUoiQr335ePvexiMpiNguQ5Pbbs=;
 b=PhGclUHTtsOA3iAsxFGi5EeogODxNB5Ih42vserJ5yGgOtPNyGOTe56rmsFND90+lw9e3OUj1wIu4uDbE8IZ5a/2lXyux+SmdzgsIhma6TjtJnmkLMAkAnjLEeH8crVEpNbss885r+TV+yuFOrSnegbbbqp/d9eQMxTMtEZOVb5/uV1fiS3pmqLV6yXzyYjqIhEhOCjsKsclYgTPfvorHDcveet5243qlo+zXQ6igAVwRsCxMCPo4DZDLEJ1lhjTvItEplGfV3P9J7fhzh2fuc9tZzY5Jgjd9H6iG8JjNCwaF2tDCU0koPbKpAPe/ZhHVQ3/3MMgDg67YOA3dMFqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hZgrx06cJo6mnAyLUoiQr335ePvexiMpiNguQ5Pbbs=;
 b=0mVqYLB3UIzRjiAPJTKskS/SRdr+atSTmnvDcvMrOiax+EmIVJnPYz1Ow3m1CJpd66xKWL410qHB1lgc7GrlBGvOGq+5wonuZI362IAODf3MLLXin1I6ZSG6Ythj56XhCYAFixG67GMqH61+HluJAAvMKC8A2aI/U0hwBurOGu0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:44 +0000
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
Subject: [RFC v1 049/256] cl8k: add coredump.h
Date:   Thu, 17 Jun 2021 15:58:56 +0000
Message-Id: <20210617160223.160998-50-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e999b533-733e-40e4-150c-08d931a971a7
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12349A1337CD1BE3E3E7C48AF60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RT28A6TbRx4eoQjRNjn2sJvWMC8c2Q2EcIkQ2ae8EVVSbtxJHzFn8+OXN8OwDP6Hk1zSU3L18aShIAvSLrwCdNKSXRt+AXZLGIfc1+aFZLxGA4MPw/grKEBM7POZDOIVpdAB5BWMycsjtXVfDpklqMw+zypiqLhbDc6XsAbtvYG3v1pre1FBM7mMl5nxtbMClXxHCwjHvWHMD2r3loAlXp4aLR9a8e8A4813OnihDQFsRzqzQKWXAXKIvMDYm2vCeEoFe3Ce+Lzp7/GHtHwh43Z9BQ+zvxGuzT0QAQ2C6c5Rm1r0sJildxHDEx9w71QswKdUwmsKntlq+QhvhAtok+9JqQR1aklVRDN/m8A9vnSD97F669jMUUR6lf0K4R05Y7rUAFpCGLsUUE+lUg3z/jFLfWQ4pbTXNq/+vjXsLMD3nBOFH0xLFZgv8tbZqOwwuqmGdYYIxJjLp32XtiEnMLS9eI5iajl50axrhqnssMbIRbcV4c89qtXf7HLMXd8yszMDTNJkIqKbXuR78tVkao4ugjlNyR7FuUoV9yfgM5aoEs9EZfGFW3OAakHTc6o03IJs1HlJYg/TMXEPmGrLCj0UBO1freQPg87XVBsGzjpb0LOYQt7C1VSxS00Ej4TtZMsapiSNI6YSlGTZsPKK1jwvtf6ZAjCrMOWXQSOIFpO7A0xVAxemDLVQPrZJH7/d5pbKxcbjkZdn2LqLk02PMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rcG3YIAIRTVBJUWLiRr6dNFMD2QbgK0Oim6Jl/1ctlYjLaXLqnyN8VuhWvb6?=
 =?us-ascii?Q?zgGUpZ3qFA17fWRRUvD7ZrmqU6woGN/zAP0XgGnz0YUtTP2GJclyYoVn2L1w?=
 =?us-ascii?Q?DgxyhIM6ySN7vH0IZWFlgvj1yRc/1Q+Ukeb0saOanKgDAQIV+94prVVBPA6a?=
 =?us-ascii?Q?rGMXnOFKbbv3jPYqxeP0eStgLTuU5mi+cdbSEpLxpzyEgqEvrIebCvu1T9CE?=
 =?us-ascii?Q?UBC0iLBaOTbeerKvwRtQZ+IhmiKFolKQfVEG4TVpM/PDN/RCKpIgsOUvIJNb?=
 =?us-ascii?Q?myqd6pIFnwmuQ/NOJ/MNIKPANqjAWh+A7NNBATlC9SQkzkarm0D7Waqvu6Jk?=
 =?us-ascii?Q?QazfsbQ87dqC494/jKgSBjklk0f57zdrTgHoiu1C6RrO9JCDUs2/8ZKzOGJ4?=
 =?us-ascii?Q?bcU+V7jAJiQasi2lLKbwegkuPGePkUOc5nEFef8Eq4moKu6v+tGwfkPXFT3P?=
 =?us-ascii?Q?VGAIxtJwVpqJSpaLnJO8ZPNR1Lz6PeHyGIiFjZomaSvd4WRCY68lVOU6o/Oa?=
 =?us-ascii?Q?IyHhkptTAn3bBrG+VtAJtiWqYxgXDSm11icnEITsqRJ6kynORfWcwARGegmy?=
 =?us-ascii?Q?jvEXoeoWklqRXjEk0s5c+KBNpAhf7N874LrPOoKDevg4+XkFX5fgm76s8Eh5?=
 =?us-ascii?Q?wBV2ke6oOApuZmFc6clwiiuPb9xTmes0lTfk7XwEYyUDYdSUCiHgjRVgPP2J?=
 =?us-ascii?Q?81A/h8llKrJJCPoVvV6ubZzuI+htCxhLc7gi/8SEZn3eRNch2agaSzppoDuA?=
 =?us-ascii?Q?ZQ90eK4sACmnZeP4IaA3bF4/mhu90/ReKyNtOQfabJ4gmws7hPEsVBtZ4g0M?=
 =?us-ascii?Q?XSy/8gZ965dyLgnykcBZocdkjSOS32KVT1ciQ+JGNE276yt1RXz7uf1aAZ5h?=
 =?us-ascii?Q?DLe4NJi5XL/f2ZvZOTcL0/WiyNp1+GfC65rN1gQrxxLB7Cx6qAYIn1kDgxIv?=
 =?us-ascii?Q?8MIDilt7hBb8yG2w917BxVPzOwL1t0Xy6yMHS91aP+BlL8Ywd8LCyI76li/F?=
 =?us-ascii?Q?Og/JA7XIBhO3sjwQh0JIXxsWHzO3G5Ysl8IMGJNVvp5coAIh29wwZw49mcXW?=
 =?us-ascii?Q?8PKZcnrDVJEpd0PYr9E+FUIqutJr4zpAZBdJo2PmIQTNfHdAUji0mOYVPSwW?=
 =?us-ascii?Q?/bQQ+6JkyRLoV1wGTUJ7rX6yLIWJ+8AZxVxdnLzvmIgK+1g/hj9uHlaxmIh7?=
 =?us-ascii?Q?LJwQ3j7P/PdVzio57LVc0OBELP864vUHmZDSJBPTvBOAlC4Ws7mgiGzwr/EW?=
 =?us-ascii?Q?nRCUVxPIYyZMwjR9O56tEQsnJiZ/acAtQtKWG/E5Z6hvM2m2/iVraxxibMj6?=
 =?us-ascii?Q?geMPNq5tyF7jh0GauuBPDkcm?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e999b533-733e-40e4-150c-08d931a971a7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:27.6959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MjclCPPXN4kWjtfDvzMJIbEguxtp98PZx5gmFQKX+ccDWZC+K4NVAezgSpDVU+l8DFoUjxpPF2GS90zDSmIC8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/coredump.h | 76 +++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/coredump.h

diff --git a/drivers/net/wireless/celeno/cl8k/coredump.h b/drivers/net/wire=
less/celeno/cl8k/coredump.h
new file mode 100644
index 000000000000..d24f97b8f5de
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/coredump.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_COREDUMP_H
+#define CL_COREDUMP_H
+
+#include "hw.h"
+
+#define CL_COREDUMP_V1 1
+#define CL_COREDUMP_MAGIC_LEN 16
+
+struct cl_coredump {
+       char magic[CL_COREDUMP_MAGIC_LEN];
+       __le32 len;
+
+       /* 28 bits of self sizes + 4 bits of CL_COREDUMP_V* indicators */
+       __le32 self_version;
+
+       /* timings */
+       __le64 trig_tv_sec;
+       __le64 trig_tv_nsec;
+
+       /* dump info */
+       __le32 dump_mask;
+
+       u8 reserved[256];
+
+       /* Consists of multiple NLEV elements */
+       u8 data[];
+} __packed;
+
+/* NLEV - Name-Length-Error-Value element */
+struct cl_nlev {
+       char n[CL_COREDUMP_MAGIC_LEN];
+       __le32 l;
+       __le32 e;
+       u8 v[];
+} __packed;
+
+#ifdef CONFIG_CL_DEBUGFS
+
+int cl_coredump_trigger(struct cl_hw *cl_hw);
+bool cl_coredump_recovery(struct cl_hw *cl_hw, int reason);
+bool cl_coredump_is_scheduled(struct cl_hw *cl_hw);
+void cl_coredump_reset_trace(struct cl_hw *cl_hw);
+void cl_coredump_init(struct cl_hw *cl_hw, struct dentry *dir_drv);
+void cl_coredump_close(struct cl_hw *cl_hw);
+
+#else
+
+static inline int cl_coredump_trigger(struct cl_hw *cl_hw)
+{
+       return 0;
+}
+
+static inline bool cl_coredump_recovery(struct cl_hw *cl_hw, int reason)
+{
+       return false;
+}
+
+static inline bool cl_coredump_is_scheduled(struct cl_hw *cl_hw)
+{
+       return false;
+}
+
+static inline void cl_coredump_reset_trace(struct cl_hw *cl_hw)
+{}
+
+static inline void cl_coredump_init(struct cl_hw *cl_hw, struct dentry *di=
r_drv)
+{}
+
+static inline void cl_coredump_close(struct cl_hw *cl_hw)
+{}
+#endif /* CONFIG_CL_DEBUGFS */
+
+#endif /* CL_COREDUMP_H */
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

