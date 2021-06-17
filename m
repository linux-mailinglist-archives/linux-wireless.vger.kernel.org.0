Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7A3AB8AC
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbhFQQJp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:45 -0400
Received: from mail-eopbgr140087.outbound.protection.outlook.com ([40.107.14.87]:56046
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231597AbhFQQIa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc9TPYgpl3U9ar8LbmmbfaB/FBB9q18DXlQBAYgKaa4x+6vFjoIxh+m3QOiiMtPZOOBcdpOITJsY6ZW1r0DGK5gqMmFLGw4N90RBv12DvYsFcoF/9kry5kyYorhux9+2kvyS4dbLPBJtpAQEeW+caFyRvbCHf6mHuM5jgCPFunO0ezgE9wzCy6aBDefC3Llh1t5fJWPdGDZnSq17U5hdzfvceOITg/S0E7hBuHZbVfwY0oHYfYGCIM7d34cSwFWHTUByLdEeW/MNGxyMIuyr77Iw8Mkm3NjYCGn5mlWzfa376cdDBJfk3H/O/eL7JgfmOXJ1n3gKs0ygvsOgvWiKwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5rGKCTLV4IQb4W1VaMIuLYr3gioe+/21zdjrN8y1Uo=;
 b=PpwZt9qVGEYsWW0I0Z0+VwQJM/pbt+E+ozQaBqB3fSk9wasGAWyOj50wDiuO1HhEPfTbnzp64vVJJt0JZnlz+BjsxU/uP3wf71T7+IyOUMidZsHDzZuwAO+sA5MEZYsx6nGoFSXd4u3sZsaTWvM6qO11VOEArB5WBIixVKBFq3zUSUQIPZEk4eCRVdPo/TMpntnhdcWEEl7XENeYauqzJsQTWz4USmCLATearBaAwFpQjkcESqUDL2FcMMn9qQbj/uRRogNpcQcY+HmuLWtV+GilZTuXOrwqwmIUoH2o9DcDzy8pnDWVECbYhnDJSl1g+XcGhQcE753cF97N/183Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5rGKCTLV4IQb4W1VaMIuLYr3gioe+/21zdjrN8y1Uo=;
 b=bEVkF/iXiOiXa3AmphO0dwlnYDxXVgkM/836LETIwNjfR0C0ezc00JhGjwnw18aJkXV1MEI9yvcq1PHVFjASShA5y+BKAjFMExpZlzVY4jFxBNSdg9/foYxZAm0ieuJgutetAH+YfyG6K7rq3fFRlbVteeiMf0dGj1xkwWWdbpI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:49 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:48 +0000
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
Subject: [RFC v1 137/256] cl8k: add power_table.c
Date:   Thu, 17 Jun 2021 16:00:24 +0000
Message-Id: <20210617160223.160998-138-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0fa7d554-ccc9-4d6f-6bf2-08d931a9abdf
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10593EC3DC6A3ED184CB27A8F60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nqiGI2ENGOgqTCzZUJ3UHitQJdi4LspUUXDXtVSSWKHvokNkn57BO/4aFilKtlGzLpKOdfWlzwbZUSIOSnoC1+UBjTH1+A7HWLbZk6rO9wCq8Y1zkjle51pEKjCAbk800Lb3VewcU4ZLtOG2jfWfmenncEk6RbVg7AExVI9OXwNNWlJwmfoEX99j/r6BWs6pXL68eFNIMMZyX0M/wADbRmR6dd9Ba3mCjMmVbIcs+255sJvH2RcOxCpceVCyhJBgAriqlkFAdf/d/GRtOf6QcsZKo9x9tci49iA0maHCsLKmPX9PXGSEBUW8AS+O2IAr+4EtkcCtjTbpmWogXF1viRsdsclh35raLRw7pvr6UAS9purwQne47i0vobbB/55FsofzxBmLkuF2PBghvZmfrhJ1TCvk+FhVPB6pChjuUQ6WLUT8UiNPRJ/iUXTjTb6GGJvHlg2XglSIBJlSmukUj7DEpjrfKgEMu+XOQFXfe4GFQ1wEe9cbpmfILWUCoAamGxffl3Bxj0jLFpUHHlEzkIkFsQbk1icOn8POUJE6Jwq/bDzPl4Jn7zIxTuySJgEXjF/oHkxAjcZ7keZcGou6puzGRv+bR7G8HYp8CWbNP1Yx4q81ZhRpsNvlR5TwPimGBVc04I0RbkjR+eS55kqggeUJ1SDf7How8tvTg53GL4QsVxXHZ52v65QE3UZMSV6Bnkf/PQ5f0ZXP2XY+iMteaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(30864003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3LtRPNPUuTtzTWMBQ3eCs7PC1am8YtmZl72yQWLSIZQl4ZiiaO0wvds3a4rX?=
 =?us-ascii?Q?gnlzsVF5H6TKr2ZKvXHWgAR8GGSnrUj1cWGyVgcUxy+q1tlw8iaPHn/7ZH6g?=
 =?us-ascii?Q?O3c7sqHfLuMj4MuSvIvI/5mcKD42OcI297hscXMZhNETuZj/WyKqIQOralfC?=
 =?us-ascii?Q?u1NQQ9ePT7iNbcmztia8hnvmBjxlum14zAHk08Uq/DtCeKoSnUH2Opdescfc?=
 =?us-ascii?Q?bOeETvsmbZoYKkrziwsVAhWOCsXFzxm+wkP+jfTpVZCf5rXYLGRp37T2XzBI?=
 =?us-ascii?Q?8W+2NV34rTEMTvHrEkicYl4X2W2lCtWZrLabNu6BaQD+oHKKPQSEF47sQed9?=
 =?us-ascii?Q?72Ry4TKbLXmGqxAvcqzdPiR8J0vM1cNNmn/40rCzwQDALAW3fDv1/nlXQSFn?=
 =?us-ascii?Q?taIE6OAo7/Quec/qALzZ0PI+lXbKdaAfBChGQYHRTIvfGnU8iUMU276j/c3P?=
 =?us-ascii?Q?Vm1scqdo4fVYcCQhGMkzjzXRi+aayRLAz5FoywbKMcOghL4Cy9ezMAxnL2vg?=
 =?us-ascii?Q?QX40OvrFpIlKLSGMQnVg/hf2rwzN4bZtlvZk9aAkh7BejPkFkfpyyVb9yD4B?=
 =?us-ascii?Q?f0Vl10IHHTNJH+0la5ZiePYwfCUflYeuP/mqyKRV+ofbzJ0demP7F4qWyC9W?=
 =?us-ascii?Q?ki7A4CPeNKz0ObXFgFGNrp6z7ivIIqOfr32KH2uTjyntJH0Fs7z3VcAQ18dh?=
 =?us-ascii?Q?dYr1HsJ1kPrqoucCkYA7r7U7TiqWq9HzwFrgke4HpHQSzA8bfK4R8pHv89iF?=
 =?us-ascii?Q?0uT6I9t/UJyK91vej6B3jDm6dk3ZOSVwGRfPnab/JW9pzTiHK0rCU7BvFG4R?=
 =?us-ascii?Q?4g9sXr3kcJcP4MPuAd2jVPWYLI8QEmMLPH+vKvs9D7LKCbnJkGvdSK0DZdti?=
 =?us-ascii?Q?0WpA/rGm75WVujLSFXtuLKDBj6U6svhSlBUuJdrUFi6PUOShe1Wq7SvOccGy?=
 =?us-ascii?Q?DoKODh67kOcyz+9A/Thap033aBlM8MKwsZoQETELAq66fW+c47tmhX6ppSdz?=
 =?us-ascii?Q?NONXGO30UwLRrPxxv93X9tB184atGjcO4dO7feVHNJkedCiAE9a6NRYcQRMi?=
 =?us-ascii?Q?qKj4X+2fDpUyuElqDK/ww6fF/PAV0qYCtamIqN49K8tyviuBhGKO1AyWd139?=
 =?us-ascii?Q?EJUgtx0JC+YFqNuOucptWM5ydA/wYZNm0eTKYimoEYjkWqjcZTUqV9zJnOJ3?=
 =?us-ascii?Q?MyBgtcqs3F4KzLJg9Dwg1msdU+ERw2pXk1odmL9xZznRBoAXGuvo5mc/o47l?=
 =?us-ascii?Q?vwstIDhyaam4m1Apk2Y9Qx0a+dFdA2ptuDDzWJCsnFyaxgVEISVXDCloTd3Q?=
 =?us-ascii?Q?LUdvRSdgL9K8WNq7AJ2F+9VO?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa7d554-ccc9-4d6f-6bf2-08d931a9abdf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:05.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4Af5ttZNCBdWi+tAEhzsY615OzuAQiVMscElAdQitkJ/6okeV6brx4n0z3P9O4ADnpyL3fcO67gJzyl7X2r5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/power_table.c    | 218 ++++++++++++++++++
 1 file changed, 218 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_table.c

diff --git a/drivers/net/wireless/celeno/cl8k/power_table.c b/drivers/net/w=
ireless/celeno/cl8k/power_table.c
new file mode 100644
index 000000000000..27cbe5596af0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power_table.c
@@ -0,0 +1,218 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "power_table.h"
+#include "chip.h"
+#include "e2p.h"
+#include "debug.h"
+#include "band.h"
+
+/*
+ * How to fill power table:
+ * Set 81 values in the range of 100 - 180 according to the Excel file.
+ * 100 corresponds to power of -10dBm (Pout Ant).
+ * 180 corresponds to power of +30dBm (Pout Ant).
+ * All values between 0 - 99 should be same as the value of 100.
+ * All values between 181 - 255 should be same as the value of 180.
+ */
+
+static const u8 power_to_powerword_conv_table_id_0[NUM_POWER_WORDS] =3D {
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 0 - 7 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 8 - 15 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 16 - 23 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 24 - 31 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 32 - 39 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 40 - 47 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 48 - 55 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 56 - 63 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 64 - 71 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 72 - 79 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 80 - 87 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 88 - 95 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0F, 0x10, 0x11, /* 96 - 103 */
+       0x12, 0x13, 0x14, 0x40, 0x41, 0x42, 0x43, 0x44, /* 104 - 111 */
+       0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, /* 112 - 119 */
+       0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54, /* 120 - 127 */
+       0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, /* 128 - 135 */
+       0x5D, 0x5E, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, /* 136 - 143 */
+       0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, /* 144 - 151 */
+       0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, /* 152 - 159 */
+       0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, /* 160 - 167 */
+       0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xF9, 0xFA, 0xFB, /* 168 - 175 */
+       0xFC, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 176 - 183 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 184 - 191 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 192 - 199 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 200 - 207 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 208 - 215 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 216 - 223 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 224 - 231 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 232 - 239 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, /* 240 - 247 */
+       0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD  /* 248 - 255 */
+};
+
+static const u8 power_to_powerword_conv_table_id_1[NUM_POWER_WORDS] =3D {
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 0 - 7 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 8 - 15 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 16 - 23 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 24 - 31 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 32 - 39 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 40 - 47 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 48 - 55 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 56 - 63 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 64 - 71 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 72 - 79 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 80 - 87 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, /* 88 - 95 */
+       0x03, 0x03, 0x03, 0x03, 0x03, 0x04, 0x05, 0x06, /* 96 - 103 */
+       0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, /* 104 - 111 */
+       0x0F, 0x10, 0x11, 0x12, 0x40, 0x41, 0x42, 0x43, /* 112 - 119 */
+       0x44, 0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, /* 120 - 127 */
+       0x4C, 0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, /* 128 - 135 */
+       0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, /* 136 - 143 */
+       0x5C, 0x5D, 0x5E, 0x60, 0x61, 0x62, 0x63, 0x64, /* 144 - 151 */
+       0x65, 0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, /* 152 - 159 */
+       0x6D, 0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74, /* 160 - 167 */
+       0x75, 0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, /* 168 - 175 */
+       0x7D, 0xB9, 0xBA, 0xBB, 0xBC, 0xBC, 0xBC, 0xBC, /* 176 - 183 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 184 - 191 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 192 - 199 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 200 - 207 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 208 - 215 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 216 - 223 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 224 - 231 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 232 - 239 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, /* 240 - 247 */
+       0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC, 0xBC  /* 248 - 255 */
+};
+
+static const u8 power_to_powerword_conv_table_id_2[NUM_POWER_WORDS] =3D {
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 0 - 7 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 8 - 15 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 16 - 23 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 24 - 31 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 32 - 39 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 40 - 47 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 48 - 55 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 56 - 63 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 64 - 71 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 72 - 79 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 80 - 87 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0E, /* 88 - 95 */
+       0x0E, 0x0E, 0x0E, 0x0E, 0x0E, 0x0F, 0x10, 0x11, /* 96 - 103 */
+       0x12, 0x13, 0x14, 0x40, 0x41, 0x42, 0x43, 0x44, /* 104 - 111 */
+       0x45, 0x46, 0x47, 0x48, 0x49, 0x4A, 0x4B, 0x4C, /* 112 - 119 */
+       0x4D, 0x4E, 0x4F, 0x50, 0x51, 0x52, 0x53, 0x54, /* 120 - 127 */
+       0x55, 0x56, 0x57, 0x58, 0x59, 0x5A, 0x5B, 0x5C, /* 128 - 135 */
+       0x5D, 0x5E, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, /* 136 - 143 */
+       0x66, 0x67, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, /* 144 - 151 */
+       0x6E, 0x6F, 0x70, 0x71, 0x72, 0x73, 0x74, 0x75, /* 152 - 159 */
+       0x76, 0x77, 0x78, 0x79, 0x7A, 0x7B, 0x7C, 0x7D, /* 160 - 167 */
+       0xB9, 0xBA, 0xBB, 0xBC, 0xBD, 0xBD, 0xBD, 0xBD, /* 168 - 175 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 176 - 183 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 184 - 191 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 192 - 199 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 200 - 207 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 208 - 215 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 216 - 223 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 224 - 231 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 232 - 239 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, /* 240 - 247 */
+       0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD, 0xBD  /* 248 - 255 */
+};
+
+static u8 cl_power_table_read(struct cl_hw *cl_hw)
+{
+       u8 pwr_table_id =3D 0;
+
+       if (cl_e2p_read(cl_hw->chip, &pwr_table_id, 1, ADDR_GEN_PWR_TABLE_I=
D + cl_hw->tcv_idx))
+               return U8_MAX;
+
+       return pwr_table_id;
+}
+
+static int cl_power_table_fill(struct cl_hw *cl_hw)
+{
+       u8 pwr_table_id =3D cl_power_table_read(cl_hw);
+
+       switch (pwr_table_id) {
+       case 0:
+               if (cl_band_is_5g(cl_hw)) {
+                       memcpy(cl_hw->power_table_info.data->conv_table,
+                              power_to_powerword_conv_table_id_0, NUM_POWE=
R_WORDS);
+                       cl_hw->tx_power_version =3D 5;
+               } else {
+                       CL_DBG_ERROR(cl_hw, "Power table ID (%u) is valid f=
or 5g only\n",
+                                    pwr_table_id);
+
+                       if (!cl_hw->chip->conf->ce_production_mode)
+                               return -1;
+               }
+               break;
+       case 1:
+               if (cl_band_is_24g(cl_hw)) {
+                       memcpy(cl_hw->power_table_info.data->conv_table,
+                              power_to_powerword_conv_table_id_1, NUM_POWE=
R_WORDS);
+                       cl_hw->tx_power_version =3D 25;
+               } else {
+                       CL_DBG_ERROR(cl_hw, "Power table ID (%u) is valid f=
or 2.4g only\n",
+                                    pwr_table_id);
+
+                       if (!cl_hw->chip->conf->ce_production_mode)
+                               return -1;
+               }
+               break;
+       case 2:
+               if (cl_band_is_6g(cl_hw)) {
+                       memcpy(cl_hw->power_table_info.data->conv_table,
+                              power_to_powerword_conv_table_id_2, NUM_POWE=
R_WORDS);
+                       cl_hw->tx_power_version =3D 1;
+               } else {
+                       CL_DBG_ERROR(cl_hw, "Power table ID (%u) is valid f=
or 6g only\n",
+                                    pwr_table_id);
+
+                       if (!cl_hw->chip->conf->ce_production_mode)
+                               return -1;
+               }
+               break;
+       default:
+               CL_DBG_ERROR(cl_hw, "Power table ID is not configured in EE=
PROM\n");
+
+               if (!cl_hw->chip->conf->ce_production_mode)
+                       return -1;
+       }
+
+       cl_dbg_verbose(cl_hw, "Power table ID %u (V%u)\n", pwr_table_id, cl=
_hw->tx_power_version);
+
+       return 0;
+}
+
+int cl_power_table_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_power_table_data *buf =3D NULL;
+       u32 len =3D sizeof(struct cl_power_table_data);
+       dma_addr_t phys_dma_addr;
+
+       buf =3D dma_alloc_coherent(cl_hw->chip->dev, len, &phys_dma_addr, G=
FP_KERNEL);
+
+       if (!buf)
+               return -1;
+
+       cl_hw->power_table_info.data =3D buf;
+       cl_hw->power_table_info.dma_addr =3D cpu_to_le32(phys_dma_addr);
+
+       return cl_power_table_fill(cl_hw);
+}
+
+void cl_power_table_free(struct cl_hw *cl_hw)
+{
+       struct cl_power_table_info *power_table_info =3D &cl_hw->power_tabl=
e_info;
+       u32 len =3D sizeof(struct cl_power_table_data);
+       dma_addr_t phys_dma_addr =3D le32_to_cpu(power_table_info->dma_addr=
);
+
+       if (!power_table_info->data)
+               return;
+
+       dma_free_coherent(cl_hw->chip->dev, len, (void *)power_table_info->=
data, phys_dma_addr);
+       power_table_info->data =3D NULL;
+}
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

