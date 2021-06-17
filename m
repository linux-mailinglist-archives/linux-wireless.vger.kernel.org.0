Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B763AB884
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhFQQIi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:08:38 -0400
Received: from mail-vi1eur05on2083.outbound.protection.outlook.com ([40.107.21.83]:50945
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233183AbhFQQHw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbVt36DkPhdHQYnQYLwEPv9zkTNQIplY6MNfaaUjKiYTxV1EZJB07yWAMXTKN8GT4Ug/HTwriJbApKtnUuxgmsUQ1czvgZ98z9kMZ6UUAT2bmfDs/19tbJlp9oFYwUXYluHDMI1EmRzkpsAPNea+XTIKnZ3QWkx1sXqKmZXU/4RCN2XUdDHSpBog2zLSpxPt2SAeMSU5GWDcnPmuL2BUePTWIjajPwLGi4+NMKgX7Ndu4KIMvBQanv1UoFkPZrrk9skbr4x6Z2auFBIOlTPEOoSCjSFjT1jqOYHQBFJ+xS40VITf7mOgt5W7TYxihFiJRJdnuSWL1HTJ41ycEg/F5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/5qmQoWFPiy8R9C+f6iEOzvfsXzdnQsd9C6CF8XK6Y=;
 b=G/d8fcQotwMoe+jDTs4+6AWV/V3Mp/4ltlsJ49xsxTG3udgSbrpFUupV/5xaEQmwfw+SNd+adbaTZVkw3YKQAgoQRTIRXjwKrZyPCF3dQYUZljgL4qdASvrseVs2sLUZ2PZdOMO4FkyUdrj2U8uOaKpHzXmaV3JyCPZfWW0SrdBur8XQE5M82NZ3toGf5JaXKbbC7PYexRwv33r+n/FB7STigjIspT2DgF8hM0R6HQRdHWPUw4SYnbI7FDVmdtNo41RTRxPm9aNKHj5aW3W99RtUc2u/4loWkxpEY38CVdKOfcBKzT8wzfYxFs8nolsNSihHlqFDLjOKOVVC+jH/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/5qmQoWFPiy8R9C+f6iEOzvfsXzdnQsd9C6CF8XK6Y=;
 b=e8LIDnTpxgQniPeI4sDhztdGOn/hcRRKD7/QeofCsGwW3UL5OZbMLJxQCPaNqTWcEvMtRElc7J9vLhBiO71rpY0j3dYPY5zqrWjE/51W580+KxDDGuSa08ihpfj9LJmmUNxMIvgYZFsIL+jXxvJPt/ga1k51VK2BTKkFHByMzh0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1314.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:42 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:42 +0000
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
Subject: [RFC v1 120/256] cl8k: add noise.h
Date:   Thu, 17 Jun 2021 16:00:07 +0000
Message-Id: <20210617160223.160998-121-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b14d39bd-e061-4df9-c421-08d931a9a0b7
X-MS-TrafficTypeDiagnostic: AM9P192MB1314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1314FCEB3A280B886CD748FAF60E9@AM9P192MB1314.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hwQUo2Do+BAotYoydq+KINA+pa8fpRcusZPfE878Hj+PLAka4EUO+bXyUW2Y1UzX46xRZBdPPWLQb4k/IVsVzLDqOR2BaBsakz4irZp6d45QHBNyrTZeyBjkbkjSCIXb3LH5nBSFxxn0SOmjKSTiPlr7UzrfKUlVHsL244M8mET/aXofQ2dZAmmSn6jH3jDbUc3zDTq8wBh3tpuJ5WQNmFk2LTzP98hq19ORcYUf/VSB2Qw2x3sMToHIKBFZ9nUjp5FradFHy29TourXp7g90hLN3irBzslB5q/d/jd2t3sILbsM4YiDnUevBXxzqsZ9k5rnksK/6JbFifGDdmWjvdFNORt3BA/2RNkhpYhicYmv+hwdtSXhevOWjyqJ8XtCF/YEwnyzsS4vW+VNFlYQehVrgWT/loYHkWAO2BoPwn/QXkz+3K0CL3PGh5I2aq7TZoM40YTmQA5AObM+LHxXmj1f1Q5WHlgcVwGiIkpcQHJX1+gXZfJH1pwEX1Ek1Kv9Q93yZt1qY1Rw6EY2Iq55PgsTsNFERUxVLiEEmU38jNGrLYPT2XyPS5evsTpatlyxcMxR+s3IGacDokroFQnlO07JRtLYHu7Uz9O75EkCFfuGV5Hnweq0+pFDWjIChRgIW2pXHfLwX/cN411ST43N0fivsctwBspcRFmYDdHSRgm6ya9z3nB/wNPymSdAWYom2QU9i/gTa4JN+KUctZMeeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(39840400004)(366004)(376002)(136003)(346002)(8936002)(66946007)(83380400001)(186003)(5660300002)(26005)(36756003)(86362001)(8676002)(55236004)(1076003)(6916009)(2906002)(6506007)(66476007)(478600001)(6666004)(38350700002)(52116002)(66556008)(956004)(4326008)(107886003)(54906003)(38100700002)(6486002)(2616005)(316002)(16526019)(6512007)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P8h5InB1IwalMRo1E7vPfwq/nNWsKIxNjUE3DYf9jExCzqNtUEEMLaBJ0MSF?=
 =?us-ascii?Q?1qPIrArdcGuPOf1UA6nW25pMalTNFWtsjWRP0dpetcjfosk6ORJnzvMRQfj8?=
 =?us-ascii?Q?xDy+RE0ZpF+8G5oX66LE0lA0OOPv+TPYgah2Urvp4zXKU4GHaZ2URq63GdXA?=
 =?us-ascii?Q?+dssCya//n/niLeJqfNU35EathjJ04GJs5t+UsZchyH0jJHSEueVdwT00THY?=
 =?us-ascii?Q?mmdvZ5AoYuHaxT4Nr+NeYUFQGNDvtY8aoDokgIW/s28bScA46gHYmd2qjiQE?=
 =?us-ascii?Q?3b5dJykKcoNYdAz5LyihtEnexq9yiCoD/1BDsiS4EhCSS5npW0pP8L4E0ReQ?=
 =?us-ascii?Q?hTA2m+udqFeICzMUtwbX06EVYllc6HRGgK92+dhqD6sR2MJ6+7/jCUOUYeWs?=
 =?us-ascii?Q?FFI13JMxwIE8jxJIffn4/8xL+Ov5pZMdHeMlwzPWL0FYPC4pfm7qExtxLp9v?=
 =?us-ascii?Q?is29WTXMNVLyCS4kmZfY18WluAv+tu6fz4RAz7PXx66Pdi5wJzh5bbhMU3pD?=
 =?us-ascii?Q?JTmuC116boTAp1Ix4yqc12RoV5XZ5MYnXGORsse6fPkw9mxgMiA0Mtzo1Cca?=
 =?us-ascii?Q?iphPQ1fYHZ7sOhFTN70z6wWNTbTOP+WOZIcdIJxEMW6d89eeg0H7CvUw1TWC?=
 =?us-ascii?Q?n/bPrfY3IbHMzp9nVTi3AQ2W68PvcaKooRAa6LAR5yCrvxyBzjdtUTnfMKmq?=
 =?us-ascii?Q?9ZNVVOJf6fruA2wT5jS0Zwz/DxVrx844vG5H8yaQuJXH0KUwDv/NrGsZDbw6?=
 =?us-ascii?Q?SI4J+bO/oE40w3RkEDuvmrmFCkxHkVbeZARET8hFFWeE7uHGz+yl0zgaZrPI?=
 =?us-ascii?Q?9MeS0EtKEY8jyT/C3FZmUjPqb5cpWuBwhS3Knm/R/f7zIZDRGxUA4sWWxsnZ?=
 =?us-ascii?Q?y3PTNIi9u1t5vDdbwaw83Dlh+SoMIZw7Mt8X8IDoK/IACP7sD16ImpsA94nt?=
 =?us-ascii?Q?phBs8eL3Gy0KQAPxM/udOetQO4plc1dnDSgY87Dj1FCZGyYEzMcsV49dCNVc?=
 =?us-ascii?Q?x5QId1ynFzNvagvFYflFch6kcdcG2E9EjQOGxdNGGJ1ncvlkkLQsFYjq8s7D?=
 =?us-ascii?Q?Q3XuGfha3FeJK4snASDk4P41c08oAKqnJeKcSNVftvWESNuM+2MKFkHRir+F?=
 =?us-ascii?Q?ouv5m/kZs07mvRn+UmPSi8HS5bqLbnXCW4qlp//3hpws7AvA35ZMydMfAkOD?=
 =?us-ascii?Q?5+fL0bca9ZKVcv02Q3walDLtuVX+hRU1lL3MrJyhZiMfwWcaYKO5uKHvj6PW?=
 =?us-ascii?Q?lUIcKtdxXFcy8MJ74Sj4PHZxGQZXuPlubIwQMm1BQDxR0hg5dhAbDPpQbgrr?=
 =?us-ascii?Q?DKd8yjj887SxDjSDeFbCJIah?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14d39bd-e061-4df9-c421-08d931a9a0b7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:46.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frgWmJn2mZ81xhGdd8Cp/MtKc0Y4O/kCyxKfDBpWZqN2WjKLIwtAUVGOMabuJ+LtRjkOz/hoJ88Xp/1bUu7L1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1314
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/noise.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/noise.h

diff --git a/drivers/net/wireless/celeno/cl8k/noise.h b/drivers/net/wireles=
s/celeno/cl8k/noise.h
new file mode 100644
index 000000000000..292705e60925
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/noise.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_NOISE_H
+#define CL_NOISE_H
+
+struct cl_hw;
+struct cli_params;
+
+void cl_noise_init(struct cl_hw *cl_hw);
+void cl_noise_close(struct cl_hw *cl_hw);
+void cl_noise_maintenance(struct cl_hw *cl_hw);
+int cl_noise_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_NOISE_H */
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

