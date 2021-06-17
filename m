Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC343AB8B4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233841AbhFQQJz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:55 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:47334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231680AbhFQQIn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJLgkJLmW9dGhh0BelISJtmUkKngzwLDvkInVNizaQk3Bt03A4sjTplNrcLJLZAoZeMrFyTQm90Rk6NGKy968Bls61+jNrouKaEuwZBZzoXkfRsoElEeGBdt0coisPMDT6v4U4L7WkRNb4eTlhQuTOQcUU3s+PKjBOneNjCyg9K6PA42yUzreMggaQg+fOfY28s8c9C1KFX0j5Qjn9Ov9Q1/L5H5MOMUdHJhatNauTr5RmWVgIatcJ1No3KmAneavX+CFc4J1d2KeNCDTzLewkyUrA2yFv5NsYOMnmLc/M0sOkK/SB7keecOm/fOzih446utf/TqIQcbUgSVzwjLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLSPt3m06p/sjN8PHT1jUWE6Ub/8dxzjcRSpRilUfEo=;
 b=a56jddtu4edGtpOgZ5IrAypZP+nSB1VTF0acNyjU5q6SsyKltOHeAOfefOae+QJmq+CfO3UGK/sK358Jpt7cJC1FfQ5adSliNo34pG/YBYQBFY6+F4pqk6ps0Upw+26BW53xtTIoLcgmOF5uOYV/jBPEf4EiPh+m6C8PUh1y2aFGJUqj2/2Rpr8m7O8+ssCL02BWIipkwQonSApmn5t67psDui5B1PqOVEw3sTvLmmfylMFji5lntwZbP77sWVliv9S4llkb3Egpx8Q6sRkHPIvGLjjxCYFXT64AcBFb71fK1/LBio4XjQkaW95Y41MskNyWw9ESCUUFppmtKhlrhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLSPt3m06p/sjN8PHT1jUWE6Ub/8dxzjcRSpRilUfEo=;
 b=wqpzIyt2ur9fvWrnlerTEKgAy1EJ6/SaFlFsShZPn3xFmDxhm+KVB6Kf+GeR2QrjZ3d7nelpdhl68Wi3IXrZqUu0EXQpdiwUFBFSo2uZrJnBaOLCkHRlXyGJzJChTiOzx90GPw4uCfzJvCISMDcitWqKK7TOsKKdeQVLWoMbdfY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:24 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:24 +0000
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
Subject: [RFC v1 152/256] cl8k: add reg/reg_fem.h
Date:   Thu, 17 Jun 2021 16:00:39 +0000
Message-Id: <20210617160223.160998-153-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf14df8-3c60-495a-cc9b-08d931a9b555
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187BB8A9A80E1DB38B6EC54F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gu0ZfOVZrVV5AjVzrRl8c/769W05vYJQmOBK9+EQLgfLD3sUrn3i+x1Pm73mDM3DC1YKl5z25iwGB1we/ztqpHdS/Pso7hnl5q1wprkK7J7tStuoex+j2l0NwMYpMbyo2H1XOMCle0JhNRIVnQ/vW8eknNdAocVd9V1nWndwxApkRI/+lDPBAB/XKDIhl6N5OT19dsJGmDMrtU6nTIGORhITcjFNKrIwcpkT0uO8o4dzETGKt4pa1pYeH1BP4egZ4G0PXMjKy4KT2LbmsbXBl0hOjzJs4qoV54rh96+swEr1lqyiO05G0TW25EHbNOJLW9x0rAtOCFaJwL6Nin+b1to2fId0cjk1FM22f+fZRdPbF5JT3MEyRDqQJjiUlX9xnB56IwE2+vyI5zbZnuKqse4WsZWaMhk5ytLIRO2G7eyItW4+rLFU9HrLPDYF4Vyu1VlJ19A3zmXLo9SoqB5I1Abo2+MAB7Ip90E4IpMtqkLi4dcG6iDhE97BJdtOy0VWakpwhnVydtAwvQ9ajSigIj6Q9rGrZJNPLlgPBW/3d7qLhF8vv8/twTO2B5MTGU1S/WYzRg57IgICK8cs2+aDourqZuzS0Yc7Us8piV4EF2nHrPV8fDwbSxYc141C5CmE4EWUQ87mukqkAVkfHCer9IEPMa20xYCrwKItZZQ99nNMqWegeDjVSYIlShCC9khiwd4GQJIegezshOn/JqOu8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(498600001)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?85sHjb0/k+mCFYng0LsRDBkLfQqt0gX2gt7cM4UzVmu1S70ZhKXR5dtaYvGA?=
 =?us-ascii?Q?h8lMHVRiWxSy7u7Jpaetn7QVw8Qei5wvDkFKCsp5AqADwq0MtNyDdVbY2AwC?=
 =?us-ascii?Q?r5WvkhNFA8Ko4DDhM3qq1CIfdlMNmSWAKX7mv+MUMDfoRjylnqJHyflO/jCi?=
 =?us-ascii?Q?NqrwrIHKQyVxSCmTpRqRxDPF7dMl6Tf/gWpCjLc3Yxpeb0V2zGHSIzJa1FV3?=
 =?us-ascii?Q?VvJVjhYHpfq5kD7E+/zSnsOt+mK/FJtQeWiVLjJABD1CJNUTbLvpF6GsLOLK?=
 =?us-ascii?Q?B9lFoLgUD/mjCaarQOkBHk2QAoLSfK20Oc/5Y4qnXwztZdb8II+P/RCx+Jv2?=
 =?us-ascii?Q?JqumRjpDoUKwhnB3kR3voxxKR+Kpwj8TugcLAKdqgykZU81M+5myG9JZ6sSy?=
 =?us-ascii?Q?kBSb0bWdMnLD7fwfDKjEgd65cEjDu41ABDri+8sNVYlOFti8qOfysIZ62KTb?=
 =?us-ascii?Q?adwS2wRMTJ/rBB9qRjE0bDclFSDWj/KCqK0+VLhQlQvQM4Qp5Bo7zrbppEKi?=
 =?us-ascii?Q?FIshbpM438tXIMQqkKrTlKyjx1WECOD8Swn3kUCr5ZaR/QfhLLyfrwoCV5Ao?=
 =?us-ascii?Q?E1wFP3hQ+aGu13TjooeRrAB5rLtw0/ei9/NFqZyvXXVVuHFgp6VkSMGkZ5LB?=
 =?us-ascii?Q?+QmSui8ZpiUoM05AKW+2+K+BCfYh6sUhydrshxGgjraRNz2VmueeLJQjeC8U?=
 =?us-ascii?Q?FNZcYvrXL1/GpI4SHzaCYQvfntJVy6ruivOrcb1IGfS/l5gHqYRscqR5cdk7?=
 =?us-ascii?Q?HT1OFRxSkWVod3NNdlPb6mjyang5FS59puOdf/ETMSOow+ApBjQJRDZ3PLf7?=
 =?us-ascii?Q?HBX/nYlq1Ivl0Z2bdYYy/s9bnYBSa1FDnK0UaNp3MwgEOzlGX0WJDWvT9snK?=
 =?us-ascii?Q?MbZldwkZ96CxRmZWDT6oxl0DiLT0ut2XlH9ZbR4v+aGuwGBVw6KMAXxZ5y03?=
 =?us-ascii?Q?Q8WbW2mM3o14hwKHuxAbYnfaCnQUFTab3NyWUaF1Nw/zkuDOeuyq7I10b1GN?=
 =?us-ascii?Q?aPXt/oi6FozUBg1LCwLYCKSIjt9nGUF1oboyl4tU9d7ocEi7PAETSmKfMA/B?=
 =?us-ascii?Q?blf1+N04kMwz7S6T2gFidvsb/2hEPme3eLSMn1OoGR/9Cn4FKOgiSmdO+qfk?=
 =?us-ascii?Q?2acTMWWVxs43gbuWQwhXVLhza9S5btA1LuJcJV9V62gAN5z66AtqQV3/Q4p0?=
 =?us-ascii?Q?PtgpUR9ZzbF//+uYK9k5JlguVbqFfxGKtc/fKCPURPni+cS4h+RJ4cWztBb1?=
 =?us-ascii?Q?8nS/dq71F8qRuCZ+kHCkO97R6nPldFZyqY9SQu9AaeCgkKLaBjWTS2VmrWjk?=
 =?us-ascii?Q?Hg/eprsSBjyQAt3Y2ElVcWC4?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf14df8-3c60-495a-cc9b-08d931a9b555
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:21.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaBd7JZ9/FT6t73BfG/OMu+FHxEm7mXWnZjxyoIMiOt6Fuu9AlGW1Vn1UwVNDq9mJc/Xwr1sjOTd+tuoNG4qRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_fem.h    | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_fem.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_fem.h b/drivers/net/w=
ireless/celeno/cl8k/reg/reg_fem.h
new file mode 100644
index 000000000000..ab1aaae23782
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_fem.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_FEM_H
+#define CL_REG_FEM_H
+
+#include "reg/reg_io_ctrl.h"
+
+struct cl_fem_lna_enable_gpio {
+       union {
+               u16 b0 : 1,
+                   b1 : 1,
+                   b2 : 1,
+                   b3 : 1,
+                   b4 : 1,
+                   b5 : 1,
+                   b6 : 1,
+                   b7 : 1,
+                   b8 : 1,
+                   b9 : 1,
+                   b10 : 1,
+                   b11 : 1,
+                   rsv : 4;
+               u16 val;
+       };
+};
+
+struct cl_fem_pa_enable_gpio {
+       union {
+               u16 b0 : 1,
+                   b1 : 1,
+                   b2 : 1,
+                   b3 : 1,
+                   b4 : 1,
+                   b5 : 1,
+                   b6 : 1,
+                   b7 : 1,
+                   b8 : 1,
+                   b9 : 1,
+                   b10 : 1,
+                   b11 : 1,
+                   rsv : 4;
+               u16 val;
+       };
+};
+
+struct cl_fem_rx_active_gpio {
+       union {
+               u8 b0 : 1,
+                  b1 : 1,
+                  b2 : 1,
+                  b3 : 1,
+                  b4 : 1,
+                  b5 : 1,
+                  b6 : 1,
+                  b7 : 1;
+               u8 val;
+       };
+};
+
+#define EXTRACT_OFF_LUT(lut) (((lut) >> 12) & 0x7)
+#define FEM_LUT_MASK         0x0777
+
+#define PA_ENABLE_POS  0
+#define LNA_ENABLE_POS 1
+#define RX_ACTIVE_POS  2
+#define GET_BIT(reg, pos) (((reg) >> (pos)) & 0x1)
+
+/*
+ * LNA_ENABLE
+ * IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_POS is used for all ioctl APIs -
+ * io_ctrl_lna_enable_0_set() ... io_ctrl_lna_enable_11_set()
+ * because all have the same value
+ */
+#define LNA_ENABLE_GPIO_VAL(val) \
+       (((u32)(val) << IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_POS) & \
+        IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_BIT)
+
+/* PA_ENABLE */
+#define PA_ENABLE_GPIO_VAL(val) \
+       (((u32)(val) << IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_POS) & \
+        IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_BIT)
+
+/* RX_ACTIVE */
+#define RX_ACTIVE_GPIO_VAL(val) \
+       (((u32)(val) << IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_POS) & \
+        IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_BIT)
+
+#define LNA_ENABLE_GPIO_OUT_CFG(val) \
+       (((1 << IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_POS) & IO_CTRL_LNA_ENABLE_=
0_GPIO_ENABLE_BIT) | \
+        ((1 << IO_CTRL_LNA_ENABLE_0_GPIO_OE_POS) & IO_CTRL_LNA_ENABLE_0_GP=
IO_OE_BIT) | \
+        (((u32)(val) << IO_CTRL_LNA_ENABLE_0_GPIO_OUT_POS) & IO_CTRL_LNA_E=
NABLE_0_GPIO_OUT_BIT))
+#define PA_ENABLE_GPIO_OUT_CFG(val) \
+        (((1 << IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_POS) & IO_CTRL_PA_ENABLE_0=
_GPIO_ENABLE_BIT) | \
+         ((1 << IO_CTRL_PA_ENABLE_0_GPIO_OE_POS) & IO_CTRL_PA_ENABLE_0_GPI=
O_OE_BIT) | \
+         (((u32)(val) << IO_CTRL_PA_ENABLE_0_GPIO_OUT_POS) & IO_CTRL_PA_EN=
ABLE_0_GPIO_OUT_BIT))
+#define RX_ACTIVE_GPIO_OUT_CFG(val) \
+         (((1 << IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_POS) & IO_CTRL_RX_ACTIVE_=
0_GPIO_ENABLE_BIT) | \
+          ((1 << IO_CTRL_RX_ACTIVE_0_GPIO_OE_POS) & IO_CTRL_RX_ACTIVE_0_GP=
IO_OE_BIT) | \
+          (((u32)(val) << IO_CTRL_RX_ACTIVE_0_GPIO_OUT_POS) & IO_CTRL_RX_A=
CTIVE_0_GPIO_OUT_BIT))
+
+#endif /* CL_REG_FEM_H */
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

