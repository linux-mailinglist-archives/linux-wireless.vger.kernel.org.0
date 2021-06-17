Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BD83AB8B0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhFQQJv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:51 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:4749
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233726AbhFQQIh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5CHn0sUoq2K5+Joigr1zNMTRkHwVF7EuveHtQD+4o4bYFWYgy6gxwPoyM0e7RLOobM3qeo71pIWY9E5q5xpIsiOAri4+/mPUPW3usVB6w1AbidXsQ8GPSPVC2TMUCiUlS+fLBtaqG+56XZZo8AtwVZhtcD0pCktiLQe76eVuxc1qwYpM4veuQPEw5F4lonifGHvsPv4FIAmS83hYicD85ypJthQsaUczLbV32ARgc26pwuE9pS2dGkpjm3Np0EutxvY7mVGyu94Aj+sB+Izl8EH0wacSuD29EV7UA3B9Skl4Awvt63XnoyBqupL4qj6FCsqSRBvGdijkz/VBNSwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XonmHg04xYKLMaSqJNeIztOEZjjycppqBbn4+RcC9HM=;
 b=nGI4giYGT4V/tB9/E+VpxER6t1RS5qpRhPvNQa+LeIKisKjLCX+Wgh3jdKu9G9KOyN16YJAbe9p2HLtlMOX26P+wVNS9pR9SPrsDD4fjfIOX1N1/dvQL9qED6PdV3dZ2Rc6W14JdvMhTnRLhezRHdBHCCkXLpAd3Z54FJJoC7YxGB5vHgAOWvFzN2+EaSBF+Dc7phv5Yg8jUUB72SA7+wB00cZahvsT/BuUT3biC67zecP6h7BK9LarP4pxwj4loc/KZVsrA0uKeZPHJo3VvoU5ra5zB9tIi2Qc1znXHfLeGNpifCrsGJUGU8SJZmzbW7T67p5dJHR1O+9iG75nw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XonmHg04xYKLMaSqJNeIztOEZjjycppqBbn4+RcC9HM=;
 b=gE6KaCZ5Bez4C6YQdZnk3go4i2shSQbvNAQCQWIG3fsqgpXCTYs7nxwzO8zrtq0ILuouX4ZjZtP0wghyPDwSlmqrPyCewsDH9Tz95fEs+D6GLu6WSurYYGKD0g8C1ck8BUPkP1tKeGRSHiA89FLwp6SuL6V+8o9myfrR197W8z4=
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
Subject: [RFC v1 151/256] cl8k: add reg/reg_cmu.h
Date:   Thu, 17 Jun 2021 16:00:38 +0000
Message-Id: <20210617160223.160998-152-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 668c68bb-84b9-439d-4eb2-08d931a9b4b4
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB11871C4C8FE52603A0C6927CF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sVoFBv/w2MxpUzicY2VJeV6ymgPGITapjEnDkL+NqWVQ80cNWqh3ycVyMgTCbRjRoqOzdm6A3QFe6T1RR/U/NFZFpWCryAU/zOwmdmhfa424NWWlwOce/jQvijlTFpB67JKP4yl+1SLvJBIUpFdbwzwPWk1V7tCNVEuQwvP/znPX5umZoFuv1L6oeM1qQBxOD8nfkbocDcNcn+vRPOadUY25vhNR9Lsb7tjiSaJGfG2SmxPmCEUesfuqbdcY4KIL5YTV4RLrpvkV2GjS7xy3c9Ufhcu8wOAWTeAcoSGMuWZUGUcEBOfxhU+2kYxd1S1xxt9mdMk9crD68Vr7LAikeAu2QSwBwe70vg+EMuk+Ywufu/Cqf5cMT1TC32t51ehdhknrAQ4C7J4G6GSfG3zYXoMpd2CrerfvAEuCKjcOV1HGFKLiScPvNcBed7+MxDnp7F8XW5JTLfpi83kEj5kxDMA7Sw6JGI629dGu/cpVVLQTvj1Pj7LT+ooU8jh/RZTkR/aHYD0jxUsMMcmMUGdJ4bFXL/UGUGwQzuFoaodFjYsaXxTD5TbQuQ0LO2n+UsJ6Ck5P60VZYAfUE3dzod6pMwH7KkS7pQbmncB050QfuddsM1qjlnm1Llp3W17dE7EyKq2oIhlf1cguF1EWgzPEw7SnbKrwslJTBKzUBg6wdCCmrEsNRTXKseN6JaMAddhXLdJ9djMP3E2j860/INlGP6eWA7pztst+H/uMcV2LxxqRZqf4r56qBq6+nFEWNcNqxn/CWK5aVnhEaYgXi73rjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(30864003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(498600001)(107886003)(69590400013)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aZLcXDqSezS0bu3BllWawM9XLe9KbDNwSeAmryKJa/dpT0h83SkeTmZgb8b4?=
 =?us-ascii?Q?nkc3lHdS5Jg1VvrhIn76TZcJ3pMw4B8SVCC8EtVkgoJcKvwJ5lVFSAr8p4/B?=
 =?us-ascii?Q?9xq+l/rIkSTBh05EZh2JJOB7IjoeHYnqBtw3MmkY7B+dBMdgfZlnV98lezlx?=
 =?us-ascii?Q?l/Wk0l/0iS9RQlQETrENFMALIMBaITs9/xyKywsQDENM4SPZUOEs3Bk2Gg7Q?=
 =?us-ascii?Q?rx3q5CJGLhfF5O+jzsUH+s0iE3beQQb/0QUDj9GVSTzlc25qtvknKGvGIcoK?=
 =?us-ascii?Q?KyQcmxjcWDfDS7rUXhZ65cinynPr1EQFkCSJGd8wXIi0w3pYx5NRtYVUKnLX?=
 =?us-ascii?Q?mCokavLi+t/slnhJPeXd77P50lfX59syDMSTwxdKQHRt8Xeh/YpcYvpR5d0X?=
 =?us-ascii?Q?/DTlwwYrODg5ple+wjl71PyzP3rr+iyvagbtLkN3D6fSRu6yPpQhNxh441s5?=
 =?us-ascii?Q?DlN2iPuvEqcNahrDIr9mdfUDpGt45ESq+JAOtvFnLT8yDjX7ts3AIPI7E3Ji?=
 =?us-ascii?Q?aB0wt+NvGhTECRQcfXmhI4TngR/BvRFgsPmHADRUiV9lwy+DrEslh+zOaQU1?=
 =?us-ascii?Q?h4LEWTtX2ELYYt9rOTC1ZYevMWH+l75Ulany+aJmRLVg8jr7Hk0vMzglUM7f?=
 =?us-ascii?Q?Zn392OjOMfPILqEGMk7x/SfFGfm+IpMOjR7XPtYaThwsBjIjCmPIkBzulQzc?=
 =?us-ascii?Q?D9XCBHHANyM+F92POu6pnx4eZ4bp38cgyPfv+eq3/MFXQtdrZUj9ldNfYDW0?=
 =?us-ascii?Q?pk7NoDY92AMEM40m794rbE3BPq3q2T0FYGarTqCrlJDAz2Bop+tKgv6LfnfQ?=
 =?us-ascii?Q?bnsF0txQCNhwrS7OG/VGcEdr0twTT5WhvorpZX2ciVIYzjcuYWjgOVFv4qWf?=
 =?us-ascii?Q?hyVX2GjfQGuTt5ns6BnQX24qojy/i15+Q2IuW+iwEZyVygHohnBfgfXLtQfb?=
 =?us-ascii?Q?lB6wai8HYB6VG30Y/yn2qCiNfvg9JZCJSpA4rWStGjS55CX+fWApK4iiBzkr?=
 =?us-ascii?Q?F6Ds1V9ZzeGyyjmWocapLkaTlRNqOhuWXO+5k/ojMfB8YbK+EtG2Jcnl4oip?=
 =?us-ascii?Q?g62NbcvbWhk2D3B1A8YnxyBf0qmIg+QIwlz2mQUgsShC0qdNbrvaRI2ZIbqH?=
 =?us-ascii?Q?crUteGSDIE3L6WohbUwcuRVpRXJ/X+kqJozmy5VSvGnW/hykAWnThqxZa3lz?=
 =?us-ascii?Q?fmkaDupq/vQ1R9KuQD6MRuxnF3an2BE2klDgITXahhPlF2veY/+U+GuDr6Jd?=
 =?us-ascii?Q?gSeJTu5EytBjr2mVSQwc63VSJXmT9pdPeOmLGfn9twPtW9XO9gy5V8AMDdl7?=
 =?us-ascii?Q?XEeT6PHL4ixYZxSTPRqq2UMY?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668c68bb-84b9-439d-4eb2-08d931a9b4b4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:20.2347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bU3NgrqMmCJiOG8U0dVvW/Emp+vfVrgPIP15Bxi5TA7vBmTj+PQe25UU4eHGw9E5jxJToSHbFvPpgq2eaHye9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_cmu.h    | 379 ++++++++++++++++++
 1 file changed, 379 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_cmu.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_cmu.h b/drivers/net/w=
ireless/celeno/cl8k/reg/reg_cmu.h
new file mode 100644
index 000000000000..59428bf81e20
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_cmu.h
@@ -0,0 +1,379 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_CMU_H
+#define CL_REG_CMU_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "chip.h"
+
+#define REG_CMU_BASE_ADDR 0x007C6000
+
+/*
+ * @brief CMU_CLK_EN register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    spare_afe_gnrl_en         0
+ *    30    spare_sys_gnrl_en         0
+ *    27    spare_riu44_clk_en        0
+ *    26    spare_riu_clk_en          0
+ *    25    spare_riu2x_clk_en        0
+ *    24    spare_riu4x_clk_en        0
+ *    23    spare_phy_clk_en          0
+ *    22    spare_phy2x_clk_en        0
+ *    21    spare_sysx_clk_en         0
+ *    20    spare_sys2x_clk_en        0
+ *    19    ricu_clk_en               0
+ *    05    smac_proc_clk_en          1
+ *    04    umac_proc_clk_en          1
+ *    03    lmac_proc_clk_en          1
+ * </pre>
+ */
+#define CMU_CLK_EN_ADDR        (REG_CMU_BASE_ADDR + 0x00000000)
+#define CMU_CLK_EN_OFFSET      0x00000000
+#define CMU_CLK_EN_INDEX       0x00000000
+#define CMU_CLK_EN_RESET       0x00000038
+
+/* Field definitions */
+#define CMU_SPARE_AFE_GNRL_EN_BIT           ((u32)0x80000000)
+#define CMU_SPARE_AFE_GNRL_EN_POS           31
+#define CMU_SPARE_SYS_GNRL_EN_BIT           ((u32)0x40000000)
+#define CMU_SPARE_SYS_GNRL_EN_POS           30
+#define CMU_SPARE_RIU_44_CLK_EN_BIT         ((u32)0x08000000)
+#define CMU_SPARE_RIU_44_CLK_EN_POS         27
+#define CMU_SPARE_RIU_CLK_EN_BIT            ((u32)0x04000000)
+#define CMU_SPARE_RIU_CLK_EN_POS            26
+#define CMU_SPARE_RIU_2_X_CLK_EN_BIT        ((u32)0x02000000)
+#define CMU_SPARE_RIU_2_X_CLK_EN_POS        25
+#define CMU_SPARE_RIU_4_X_CLK_EN_BIT        ((u32)0x01000000)
+#define CMU_SPARE_RIU_4_X_CLK_EN_POS        24
+#define CMU_SPARE_PHY_CLK_EN_BIT            ((u32)0x00800000)
+#define CMU_SPARE_PHY_CLK_EN_POS            23
+#define CMU_SPARE_PHY_2_X_CLK_EN_BIT        ((u32)0x00400000)
+#define CMU_SPARE_PHY_2_X_CLK_EN_POS        22
+#define CMU_SPARE_SYSX_CLK_EN_BIT           ((u32)0x00200000)
+#define CMU_SPARE_SYSX_CLK_EN_POS           21
+#define CMU_SPARE_SYS_2_X_CLK_EN_BIT        ((u32)0x00100000)
+#define CMU_SPARE_SYS_2_X_CLK_EN_POS        20
+#define CMU_RICU_CLK_EN_BIT                 ((u32)0x00080000)
+#define CMU_RICU_CLK_EN_POS                 19
+#define CMU_SMAC_PROC_CLK_EN_BIT            ((u32)0x00000020)
+#define CMU_SMAC_PROC_CLK_EN_POS            5
+#define CMU_UMAC_PROC_CLK_EN_BIT            ((u32)0x00000010)
+#define CMU_UMAC_PROC_CLK_EN_POS            4
+#define CMU_LMAC_PROC_CLK_EN_BIT            ((u32)0x00000008)
+#define CMU_LMAC_PROC_CLK_EN_POS            3
+
+#define CMU_MAC_ALL_CLK_EN \
+       (CMU_RICU_CLK_EN_BIT | \
+        CMU_SMAC_PROC_CLK_EN_BIT | \
+        CMU_UMAC_PROC_CLK_EN_BIT | \
+        CMU_LMAC_PROC_CLK_EN_BIT)
+
+static inline void cmu_clk_en_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, CMU_CLK_EN_ADDR, value);
+}
+
+/*
+ * @brief CMU_PHY_0_CLK_EN register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    02    ceva0_clk_en              0
+ *    01    phy0_apb_clk_en           0
+ *    00    phy0_main_clk_en          0
+ * </pre>
+ */
+#define CMU_PHY_0_CLK_EN_ADDR        (REG_CMU_BASE_ADDR + 0x00000004)
+#define CMU_PHY_0_CLK_EN_OFFSET      0x00000004
+#define CMU_PHY_0_CLK_EN_INDEX       0x00000001
+#define CMU_PHY_0_CLK_EN_RESET       0x00000000
+
+static inline void cmu_phy_0_clk_en_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR, value);
+}
+
+/* Field definitions */
+#define CMU_CEVA_0_CLK_EN_BIT               ((u32)0x00000004)
+#define CMU_CEVA_0_CLK_EN_POS               2
+#define CMU_PHY_0_APB_CLK_EN_BIT            ((u32)0x00000002)
+#define CMU_PHY_0_APB_CLK_EN_POS            1
+#define CMU_PHY_0_MAIN_CLK_EN_BIT           ((u32)0x00000001)
+#define CMU_PHY_0_MAIN_CLK_EN_POS           0
+
+#define CMU_PHY0_CLK_EN \
+       (CMU_CEVA_0_CLK_EN_BIT | \
+        CMU_PHY_0_APB_CLK_EN_BIT | \
+        CMU_PHY_0_MAIN_CLK_EN_BIT)
+
+static inline void cmu_phy_0_clk_en_pack(struct cl_chip *chip, u8 ceva0clk=
en, u8 phy0apbclken,
+                                        u8 phy0mainclken)
+{
+       ASSERT_ERR_CHIP((((u32)ceva0clken << 2) & ~((u32)0x00000004)) =3D=
=3D 0);
+       ASSERT_ERR_CHIP((((u32)phy0apbclken << 1) & ~((u32)0x00000002)) =3D=
=3D 0);
+       ASSERT_ERR_CHIP((((u32)phy0mainclken << 0) & ~((u32)0x00000001)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR, ((u32)ceva0clken << =
2) |
+                         ((u32)phy0apbclken << 1) | ((u32)phy0mainclken <<=
 0));
+}
+
+static inline void cmu_phy_0_clk_en_ceva_0_clk_en_setf(struct cl_chip *chi=
p, u8 ceva0clken)
+{
+       ASSERT_ERR_CHIP((((u32)ceva0clken << 2) & ~((u32)0x00000004)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR,
+                         (cl_reg_read_chip(chip, CMU_PHY_0_CLK_EN_ADDR) & =
~((u32)0x00000004)) | ((u32)ceva0clken << 2));
+}
+
+static inline void cmu_phy_0_clk_en_phy_0_apb_clk_en_setf(struct cl_chip *=
chip, u8 phy0apbclken)
+{
+       ASSERT_ERR_CHIP((((u32)phy0apbclken << 1) & ~((u32)0x00000002)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR,
+                         (cl_reg_read_chip(chip, CMU_PHY_0_CLK_EN_ADDR) & =
~((u32)0x00000002)) | ((u32)phy0apbclken << 1));
+}
+
+/*
+ * @brief CMU_PHY_1_CLK_EN register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    02    ceva1_clk_en              0
+ *    01    phy1_apb_clk_en           0
+ *    00    phy1_main_clk_en          0
+ * </pre>
+ */
+#define CMU_PHY_1_CLK_EN_ADDR        (REG_CMU_BASE_ADDR + 0x00000008)
+#define CMU_PHY_1_CLK_EN_OFFSET      0x00000008
+#define CMU_PHY_1_CLK_EN_INDEX       0x00000002
+#define CMU_PHY_1_CLK_EN_RESET       0x00000000
+
+static inline void cmu_phy_1_clk_en_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR, value);
+}
+
+/* Field definitions */
+#define CMU_CEVA_1_CLK_EN_BIT               ((u32)0x00000004)
+#define CMU_CEVA_1_CLK_EN_POS               2
+#define CMU_PHY_1_APB_CLK_EN_BIT            ((u32)0x00000002)
+#define CMU_PHY_1_APB_CLK_EN_POS            1
+#define CMU_PHY_1_MAIN_CLK_EN_BIT           ((u32)0x00000001)
+#define CMU_PHY_1_MAIN_CLK_EN_POS           0
+
+#define CMU_PHY1_CLK_EN \
+       (CMU_CEVA_1_CLK_EN_BIT | \
+        CMU_PHY_1_APB_CLK_EN_BIT | \
+        CMU_PHY_1_MAIN_CLK_EN_BIT)
+
+static inline void cmu_phy_1_clk_en_pack(struct cl_chip *chip, u8 ceva1clk=
en, u8 phy1apbclken,
+                                        u8 phy1mainclken)
+{
+       ASSERT_ERR_CHIP((((u32)ceva1clken << 2) & ~((u32)0x00000004)) =3D=
=3D 0);
+       ASSERT_ERR_CHIP((((u32)phy1apbclken << 1) & ~((u32)0x00000002)) =3D=
=3D 0);
+       ASSERT_ERR_CHIP((((u32)phy1mainclken << 0) & ~((u32)0x00000001)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR, ((u32)ceva1clken << =
2) |
+                         ((u32)phy1apbclken << 1) | ((u32)phy1mainclken <<=
 0));
+}
+
+static inline void cmu_phy_1_clk_en_ceva_1_clk_en_setf(struct cl_chip *chi=
p, u8 ceva1clken)
+{
+       ASSERT_ERR_CHIP((((u32)ceva1clken << 2) & ~((u32)0x00000004)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR,
+                         (cl_reg_read_chip(chip, CMU_PHY_1_CLK_EN_ADDR) & =
~((u32)0x00000004)) | ((u32)ceva1clken << 2));
+}
+
+static inline void cmu_phy_1_clk_en_phy_1_apb_clk_en_setf(struct cl_chip *=
chip, u8 phy1apbclken)
+{
+       ASSERT_ERR_CHIP((((u32)phy1apbclken << 1) & ~((u32)0x00000002)) =3D=
=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR,
+                         (cl_reg_read_chip(chip, CMU_PHY_1_CLK_EN_ADDR) & =
~((u32)0x00000002)) | ((u32)phy1apbclken << 1));
+}
+
+/*
+ * @brief CMU_CONTROL register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    gl_mux_sel                0
+ * </pre>
+ */
+#define CMU_CONTROL_ADDR        (REG_CMU_BASE_ADDR + 0x0000000C)
+#define CMU_CONTROL_OFFSET      0x0000000C
+#define CMU_CONTROL_INDEX       0x00000003
+#define CMU_CONTROL_RESET       0x00000000
+
+static inline void cmu_control_gl_mux_sel_setf(struct cl_chip *chip, u8 gl=
muxsel)
+{
+       ASSERT_ERR_CHIP((((u32)glmuxsel << 0) & ~((u32)0x00000001)) =3D=3D =
0);
+       cl_reg_write_chip(chip, CMU_CONTROL_ADDR, (u32)glmuxsel << 0);
+}
+
+/*
+ * @brief CMU_RST register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    18    spare_riu44_reset_n       0
+ *    17    spare_modem_reset_n       0
+ *    16    spare_sys_reset_n         0
+ *    15    n_RICURst                 1
+ * </pre>
+ */
+#define CMU_RST_ADDR        (REG_CMU_BASE_ADDR + 0x00000010)
+#define CMU_RST_OFFSET      0x00000010
+#define CMU_RST_INDEX       0x00000004
+#define CMU_RST_RESET       0x0000FF80
+
+static inline void cmu_rst_n_ricurst_setf(struct cl_chip *chip, u8 nricurs=
t)
+{
+       ASSERT_ERR_CHIP((((u32)nricurst << 15) & ~((u32)0x00008000)) =3D=3D=
 0);
+       cl_reg_write_chip(chip, CMU_RST_ADDR,
+                         (cl_reg_read_chip(chip, CMU_RST_ADDR) & ~((u32)0x=
00008000)) | ((u32)nricurst << 15));
+}
+
+/*
+ * @brief CMU_PHY_0_RST register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    03    ceva0_global_rst_n        1
+ *    02    mpif0_rst_n               1
+ *    01    phy0_preset_n             1
+ *    00    phy0_rst_n                1
+ * </pre>
+ */
+#define CMU_PHY_0_RST_ADDR        (REG_CMU_BASE_ADDR + 0x00000014)
+#define CMU_PHY_0_RST_OFFSET      0x00000014
+#define CMU_PHY_0_RST_INDEX       0x00000005
+#define CMU_PHY_0_RST_RESET       0x0000000F
+
+static inline void cmu_phy_0_rst_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, CMU_PHY_0_RST_ADDR, value);
+}
+
+/* Field definitions */
+#define CMU_CEVA_0_GLOBAL_RST_N_BIT         ((u32)0x00000008)
+#define CMU_CEVA_0_GLOBAL_RST_N_POS         3
+#define CMU_MPIF_0_RST_N_BIT                ((u32)0x00000004)
+#define CMU_MPIF_0_RST_N_POS                2
+#define CMU_PHY_0_PRESET_N_BIT              ((u32)0x00000002)
+#define CMU_PHY_0_PRESET_N_POS              1
+#define CMU_PHY_0_RST_N_BIT                 ((u32)0x00000001)
+#define CMU_PHY_0_RST_N_POS                 0
+
+#define CMU_PHY0_RST_EN \
+       (CMU_PHY_0_PRESET_N_BIT | \
+        CMU_MPIF_0_RST_N_BIT | \
+        CMU_PHY_0_RST_N_BIT | \
+        CMU_CEVA_0_GLOBAL_RST_N_BIT)
+
+static inline void cmu_phy_0_rst_ceva_0_global_rst_n_setf(struct cl_chip *=
chip, u8 ceva0globalrstn)
+{
+       ASSERT_ERR_CHIP((((u32)ceva0globalrstn << 3) & ~((u32)0x00000008)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_0_RST_ADDR,
+                         (cl_reg_read_chip(chip, CMU_PHY_0_RST_ADDR) & ~((=
u32)0x00000008)) | ((u32)ceva0globalrstn << 3));
+}
+
+/*
+ * @brief CMU_PHY_1_RST register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    03    ceva1_global_rst_n        1
+ *    02    mpif1_rst_n               1
+ *    01    phy1_preset_n             1
+ *    00    phy1_rst_n                1
+ * </pre>
+ */
+#define CMU_PHY_1_RST_ADDR        (REG_CMU_BASE_ADDR + 0x00000018)
+#define CMU_PHY_1_RST_OFFSET      0x00000018
+#define CMU_PHY_1_RST_INDEX       0x00000006
+#define CMU_PHY_1_RST_RESET       0x0000000F
+
+static inline void cmu_phy_1_rst_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, CMU_PHY_1_RST_ADDR, value);
+}
+
+/* Field definitions */
+#define CMU_CEVA_1_GLOBAL_RST_N_BIT         ((u32)0x00000008)
+#define CMU_CEVA_1_GLOBAL_RST_N_POS         3
+#define CMU_MPIF_1_RST_N_BIT                ((u32)0x00000004)
+#define CMU_MPIF_1_RST_N_POS                2
+#define CMU_PHY_1_PRESET_N_BIT              ((u32)0x00000002)
+#define CMU_PHY_1_PRESET_N_POS              1
+#define CMU_PHY_1_RST_N_BIT                 ((u32)0x00000001)
+#define CMU_PHY_1_RST_N_POS                 0
+
+#define CMU_PHY1_RST_EN \
+       (CMU_PHY_1_PRESET_N_BIT | \
+        CMU_MPIF_1_RST_N_BIT | \
+        CMU_PHY_1_RST_N_BIT | \
+        CMU_CEVA_1_GLOBAL_RST_N_BIT)
+
+static inline void cmu_phy_1_rst_ceva_1_global_rst_n_setf(struct cl_chip *=
chip, u8 ceva1globalrstn)
+{
+       ASSERT_ERR_CHIP((((u32)ceva1globalrstn << 3) & ~((u32)0x00000008)) =
=3D=3D 0);
+       cl_reg_write_chip(chip, CMU_PHY_1_RST_ADDR,
+                         (cl_reg_read_chip(chip, CMU_PHY_1_RST_ADDR) & ~((=
u32)0x00000008)) | ((u32)ceva1globalrstn << 3));
+}
+
+/*
+ * @brief CMU_PLL_1_STAT register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    pll_lock                  0
+ * </pre>
+ */
+#define CMU_PLL_1_STAT_ADDR        (REG_CMU_BASE_ADDR + 0x00000050)
+#define CMU_PLL_1_STAT_OFFSET      0x00000050
+#define CMU_PLL_1_STAT_INDEX       0x00000014
+#define CMU_PLL_1_STAT_RESET       0x00000000
+
+static inline u8 cmu_pll_1_stat_pll_lock_getf(struct cl_chip *chip)
+{
+       u32 local_val =3D cl_reg_read_chip(chip, CMU_PLL_1_STAT_ADDR);
+
+       ASSERT_ERR_CHIP((local_val & ~((u32)0x80000000)) =3D=3D 0);
+       return (local_val >> 31);
+}
+
+/*
+ * @brief CMU_PHASE_SEL register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    20    gp_clk_phase_sel          1
+ *    19    dac_cdb_clk_phase_sel     0
+ *    18    adc_cdb_clk_phase_sel     0
+ *    17    dac_clk_phase_sel         0
+ *    16    adc_clk_phase_sel         0
+ * </pre>
+ */
+#define CMU_PHASE_SEL_ADDR        (REG_CMU_BASE_ADDR + 0x00000060)
+#define CMU_PHASE_SEL_OFFSET      0x00000060
+#define CMU_PHASE_SEL_INDEX       0x00000018
+#define CMU_PHASE_SEL_RESET       0x00100000
+
+static inline void cmu_phase_sel_set(struct cl_chip *chip, u32 value)
+{
+       cl_reg_write_chip(chip, CMU_PHASE_SEL_ADDR, value);
+}
+
+/* Field definitions */
+#define CMU_GP_CLK_PHASE_SEL_BIT            ((u32)0x00100000)
+#define CMU_GP_CLK_PHASE_SEL_POS            20
+#define CMU_DAC_CDB_CLK_PHASE_SEL_BIT       ((u32)0x00080000)
+#define CMU_DAC_CDB_CLK_PHASE_SEL_POS       19
+#define CMU_ADC_CDB_CLK_PHASE_SEL_BIT       ((u32)0x00040000)
+#define CMU_ADC_CDB_CLK_PHASE_SEL_POS       18
+#define CMU_DAC_CLK_PHASE_SEL_BIT           ((u32)0x00020000)
+#define CMU_DAC_CLK_PHASE_SEL_POS           17
+#define CMU_ADC_CLK_PHASE_SEL_BIT           ((u32)0x00010000)
+#define CMU_ADC_CLK_PHASE_SEL_POS           16
+
+#endif /* CL_REG_CMU_H */
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

