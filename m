Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B77C3AB8DB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbhFQQLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:01 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:47334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232530AbhFQQJx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5RVp74fuxAKTHJaqNx7tX74SXxss2K4URu/fIxkdj0KQHryEjQiMf940x2tPzBtpwqDl2b9vt9A6C2gF4cyLv74UVRUsR0guEYsdwOzK4flNBLp0qDC6EnZUC8hPJVVpTnHbJYJIBN2P0OfOZocRawId3AqhRcOBnvGp90fGrOaJj7yJbM9th4QU//L5nInkqv9oBP4CuQHMIfBB8Yu5987sLiAa9eWuVwgZaIJ5e8/18t+P3zYn5PaAIpYrzaIib/LI1r0rnwqqsg9Lx69zsxPCIIfHaYuRTe+W5yXO1owYoBZ+9wYL4i857dVoU04n8WRJ8pEmnaD4lNqIJ2Ftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTo6SbFv8Wp0G5khxnuSq5LelCyAqljcWREnXvbK0lo=;
 b=Xa5Q/OJku624argakzsPcipsLSvGryoxkEBWNdZEo8PyAaTjCqDFLsQwPqSekVnQifqQqBkEZvqVwau++VMr4yY0jstnkMiCTo4IjFFWBjl8buIw61Ut4GREdOSOY2Y+hGm8VR8wKwdL4DefX63adPPWUSI3Wv1TvqS12u8Lo6TiDdBCZOYixtzt/WelhHkZXDkf5iKGOYrx4m1kNH0GtdXfrLoGAR6Vas44OXRW5oibsNonax8mfUjKs8cF8xQldHKFB1D/WYEoZ5/LCO+ScaO1INtozA6Xzs7wXbWr9Jf/PQWZrjRm7xIpThuuOr0fsSJy0X0Z6a6ykiPJuHNEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTo6SbFv8Wp0G5khxnuSq5LelCyAqljcWREnXvbK0lo=;
 b=EIDdYMy9tmleBbIvBMU+hDZgTPLzPFXpd078XQXhXzA2rbTNQamPoL/siSFp1KZvIk5WJhuF0uV7ddHaqn/yUEWw9NWh7CQxhxwnQENVD2MpxG1TONpC2BThzcMo4nC5MKsW2DU57ckKAa8cZZZmBfFM1cMXGfEfW3HMjVJ52QE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:27 +0000
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
Subject: [RFC v1 159/256] cl8k: add reg/reg_mac_hw.h
Date:   Thu, 17 Jun 2021 16:00:46 +0000
Message-Id: <20210617160223.160998-160-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed37ae2e-d6b3-4f4a-5d96-08d931a9b9aa
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB11875D4265B9498354D82258F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gcwxiFa6l6SlBPK/KENEA+/VozlxA8W4BkSsLMzN3sn3JO6wit7jcniF2hrawYK4xZYltVRjwL0mPQ7gEUCFQcP046D8wFrwNqCZ9/KbnvA7jfCdkzxHSNbW40PW/ZOSf+zq5WvPItRj8BwL+IOjjOxQkZQulXil+hi/gqvznwF5EJSpyUBb/1rPQJcloak6g87LTC9Vxo+F6Rb7lQ0+d0WCxAX15Ru6XlQGZ5p66kBOjLcDV+JRa643ho/+VB8x+fZp+wY0uAgX8WQfWumdZB7idMSFOy0B205A3UlifE5kE9dUIqmyduXT3cmSHzpNonVYUq2k9HkQ6CYQ5+I76KmpZeUNqMM7FJJCEcv0qFNOWUtEbr2P7YhV5R8p5VjQ0aBtG6eMocruhrpZc0yWUfuRpwRNpw8DKCJMAxuXLN1YeskJTWDHfY329hXisE/uP+qsfNf+lz/vltlYP5wkQWT2yVXAwbiCuTYX/icYOP2hoHo9Kxm1eROsUG0yzyZdnVlc+NuXhPeY+Obf5G0IPKctiL8hKjXis+BsUrJ2vAF5B7ZOpWBOXSYZIKTIoDGj4BBpLOxDxsb58DrkpIs8fV5RciT/rREejyYVco50C0wemH1xvz7GnhIUcjJPh9mx8Z0iMSvM5Eilx8/T1h/U0UveB5sx3xz/eMzJTPfX97WRUM9Kll9G92EYZDYC9mZ3JLCs8bEo4/w+HMYEEOTD7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(30864003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SMT7HLvYooZwA8O8kEHvCwO0+wgDszqyd1W/P8n/wqWDYA1RkPKwcv5cnuLS?=
 =?us-ascii?Q?SAa27EObf9ePd964hK35x/obAg/LJiUVXzFW4jxarB3KUrIZZM9D0foDXCw+?=
 =?us-ascii?Q?hgaWx1hUGaIyDm1jOpmu2glEZPoKy0N3IIh2WWIwtdwhyYAVUBpR2Wj2bnSM?=
 =?us-ascii?Q?c9E7n2Re2TAcW4n6t5UDC7NNitojsWUqB8FJqpfyTvbhRHEGB/XBruWWyQ02?=
 =?us-ascii?Q?N3BO/G7ot/17039RioZbEk8hMkvWPFYDtFnaOqRCPymNrMwbgSuo9nxNKD8+?=
 =?us-ascii?Q?pobDnBI3M9Euc24C774NucT6eBCcxCFc81MtnHo1cE+JKIjZ86y31K33AKXa?=
 =?us-ascii?Q?/v+CafnveYBmwuJym4279dInWyHR7ccrBdKjlutioF+u4tY5LnL4IQUaT5Yl?=
 =?us-ascii?Q?yOTwVfJK2XtVrHqkab+Q9bsTm1tmWmwL/8GH7c2FH2vf4eILhVtx1syNiDKc?=
 =?us-ascii?Q?cfK1FOCCEOKj2r6wmckOX3zjn0gi+U1qltK+U/NyGAMMGJnwoctdSsUPLrjN?=
 =?us-ascii?Q?2TdHUu3BVcEwXVlodH3FeyCAV+LdPhYwFQJGdmpWpHkWwgfmwe5t7dgPIum5?=
 =?us-ascii?Q?tc4JMetyXGTqGeuI+yWrkDzQatwdtKULy0Zbd5AMMOZWLDDKGheW4aT6GLHB?=
 =?us-ascii?Q?c/7PguUDhDuyGKqn87Owvsz/CROINtu96i/JURZzJcGyOG9fbovuq9NjFMSg?=
 =?us-ascii?Q?3vILTATRpncYstOJT5P9TEpvg8wLm+5IHgyh1achlQjtdGEF2eW0Locj+EPw?=
 =?us-ascii?Q?stWazBjddUE4C22BnXQp5H4qkkrh0YfudTKZn2ZWVfkdI5KSwbpe90Lp3iE2?=
 =?us-ascii?Q?vEimN0DJ2Dv394OyCi2thmqg1UnGVmxicwMyIXDmoH4o8TQxXq4UQ1fCjgnz?=
 =?us-ascii?Q?xA81IhuZf6R+JV5zo1WXc0kJ6p/CpGysWwAoQnp4mZuAw8Qu4nK0tGkG2/Lw?=
 =?us-ascii?Q?1fXyf4tgXpesC14vwFkcYTRqGozpbM8Id74II/wlMkPbfbpmY67egyrws5nG?=
 =?us-ascii?Q?57LHp3zsboM+xxcBfjHV8cMxGnnmJDTqpMmRMXUw9e9N4Qb+x29l0oxSKCP2?=
 =?us-ascii?Q?oN9kdu0gqBhF75tqr5POVfRFd7g+O+p3ChXkwvEoCLyEWh4tezELH1oJqdsx?=
 =?us-ascii?Q?0hAuqI3PQ87+I2TxVAt94MMlsaYOec+06VpurhAswK7oizKPQ7rjZAIpVgTD?=
 =?us-ascii?Q?V64vNTdsfIGkAUFzIt1tS0gfuoH+0vWdXpvD3YBqa37RI6YIMKk1vZ2XSAWk?=
 =?us-ascii?Q?0hSCmssKJRF5pm9+L3fFiC97JylFdxteqlFnHS5xM/qtP2shUzUaA8vsT0mb?=
 =?us-ascii?Q?+2Itv0YN3wVmhbkL2cK4T2q+?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed37ae2e-d6b3-4f4a-5d96-08d931a9b9aa
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:28.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xdj3mPWA7aEviMN6CSySp6iH+uK9aKbBlEzSC3Va2EdAx+13twm+KkR9TC2GUnUhbt/j7yzytQiFB3V5dCZxmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_mac_hw.h | 490 ++++++++++++++++++
 1 file changed, 490 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw.h b/drivers/ne=
t/wireless/celeno/cl8k/reg/reg_mac_hw.h
new file mode 100644
index 000000000000..50ee26b2c5fa
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_mac_hw.h
@@ -0,0 +1,490 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_MAC_HW_H
+#define CL_REG_MAC_HW_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+/*
+ * @brief STATE_CNTRL register definition
+ * This register controls the core's state transitions. register descripti=
on
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   07:04 NEXT_STATE                0x0
+ *   03:00 CURRENT_STATE             0x0
+ * </pre>
+ */
+#define MAC_HW_STATE_CNTRL_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000038)
+#define MAC_HW_STATE_CNTRL_OFFSET      0x00000038
+#define MAC_HW_STATE_CNTRL_INDEX       0x0000000E
+#define MAC_HW_STATE_CNTRL_RESET       0x00000000
+
+/* Field definitions */
+#define MAC_HW_STATE_CNTRL_NEXT_STATE_MASK     ((u32)0x000000F0)
+#define MAC_HW_STATE_CNTRL_NEXT_STATE_LSB      4
+#define MAC_HW_STATE_CNTRL_NEXT_STATE_WIDTH    ((u32)0x00000004)
+#define MAC_HW_STATE_CNTRL_CURRENT_STATE_MASK  ((u32)0x0000000F)
+#define MAC_HW_STATE_CNTRL_CURRENT_STATE_LSB   0
+#define MAC_HW_STATE_CNTRL_CURRENT_STATE_WIDTH ((u32)0x00000004)
+
+static inline void mac_hw_state_cntrl_next_state_setf(struct cl_hw *cl_hw,=
 u8 nextstate)
+{
+       ASSERT_ERR((((u32)nextstate << 4) & ~((u32)0x000000F0)) =3D=3D 0);
+       cl_reg_write(cl_hw, MAC_HW_STATE_CNTRL_ADDR,
+                    (cl_reg_read(cl_hw, MAC_HW_STATE_CNTRL_ADDR) & ~((u32)=
0x000000F0)) | ((u32)nextstate << 4));
+}
+
+/*
+ * @brief MAC_CNTRL_1 register definition
+ * Contains various settings for controlling the operation of the core. re=
gister description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31    EOF_PAD_FOR_HE            1
+ *   30    EOF_PAD_FOR_VHT           0
+ *   29:28 IMPLICIT_BF_INT_CONF      0x0
+ *   27    DISABLE_BFR_RESP          0
+ *   26    RX_RIFS_EN                0
+ *   25    TSF_MGT_DISABLE           0
+ *   24    TSF_UPDATED_BY_SW         0
+ *   22    MAC_DETECT_UNDERRUN_EN    0
+ *   21    DISABLE_MU_CTS_RESP       0
+ *   20    BQRP_RESP_BY_FW           0
+ *   19    BSRP_RESP_BY_FW           0
+ *   18    ENABLE_NORMAL_ACK_RESP_IN_HE_MU_W_TRIG 0
+ *   17    DISABLE_NORMAL_ACK_RESP_IN_HE_MU_WO_TRIG 0
+ *   16:14 ABGN_MODE                 0x3
+ *   13    KEY_STO_RAM_RESET         0
+ *   12    MIB_TABLE_RESET           0
+ *   11    RATE_CONTROLLER_MPIF      1
+ *   10    DISABLE_BA_RESP           0
+ *   09    DISABLE_CTS_RESP          0
+ *   08    DISABLE_ACK_RESP          0
+ *   07    ACTIVE_CLK_GATING         1
+ *   06    ENABLE_LP_CLK_SWITCH      0
+ *   05    FORCE_MSTA_BA             0
+ *   04    DISABLE_FAST_COMPARE      0
+ *   03    CFP_AWARE                 0
+ *   02    PWR_MGT                   0
+ *   01    AP                        0
+ *   00    BSS_TYPE                  1
+ * </pre>
+ */
+#define MAC_HW_MAC_CNTRL_1_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000004C)
+#define MAC_HW_MAC_CNTRL_1_OFFSET      0x0000004C
+#define MAC_HW_MAC_CNTRL_1_INDEX       0x00000013
+#define MAC_HW_MAC_CNTRL_1_RESET       0x8000C881
+
+/* Field definitions */
+#define MAC_HW_MAC_CNTRL_1_EOF_PAD_FOR_HE_BIT                           ((=
u32)0x80000000)
+#define MAC_HW_MAC_CNTRL_1_EOF_PAD_FOR_HE_POS                           31
+#define MAC_HW_MAC_CNTRL_1_EOF_PAD_FOR_VHT_BIT                          ((=
u32)0x40000000)
+#define MAC_HW_MAC_CNTRL_1_EOF_PAD_FOR_VHT_POS                          30
+#define MAC_HW_MAC_CNTRL_1_IMPLICIT_BF_INT_CONF_MASK                    ((=
u32)0x30000000)
+#define MAC_HW_MAC_CNTRL_1_IMPLICIT_BF_INT_CONF_LSB                     28
+#define MAC_HW_MAC_CNTRL_1_IMPLICIT_BF_INT_CONF_WIDTH                   ((=
u32)0x00000002)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_BFR_RESP_BIT                         ((=
u32)0x08000000)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_BFR_RESP_POS                         27
+#define MAC_HW_MAC_CNTRL_1_RX_RIFS_EN_BIT                               ((=
u32)0x04000000)
+#define MAC_HW_MAC_CNTRL_1_RX_RIFS_EN_POS                               26
+#define MAC_HW_MAC_CNTRL_1_TSF_MGT_DISABLE_BIT                          ((=
u32)0x02000000)
+#define MAC_HW_MAC_CNTRL_1_TSF_MGT_DISABLE_POS                          25
+#define MAC_HW_MAC_CNTRL_1_TSF_UPDATED_BY_SW_BIT                        ((=
u32)0x01000000)
+#define MAC_HW_MAC_CNTRL_1_TSF_UPDATED_BY_SW_POS                        24
+#define MAC_HW_MAC_CNTRL_1_MAC_DETECT_UNDERRUN_EN_BIT                   ((=
u32)0x00400000)
+#define MAC_HW_MAC_CNTRL_1_MAC_DETECT_UNDERRUN_EN_POS                   22
+#define MAC_HW_MAC_CNTRL_1_DISABLE_MU_CTS_RESP_BIT                      ((=
u32)0x00200000)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_MU_CTS_RESP_POS                      21
+#define MAC_HW_MAC_CNTRL_1_BQRP_RESP_BY_FW_BIT                          ((=
u32)0x00100000)
+#define MAC_HW_MAC_CNTRL_1_BQRP_RESP_BY_FW_POS                          20
+#define MAC_HW_MAC_CNTRL_1_BSRP_RESP_BY_FW_BIT                          ((=
u32)0x00080000)
+#define MAC_HW_MAC_CNTRL_1_BSRP_RESP_BY_FW_POS                          19
+#define MAC_HW_MAC_CNTRL_1_ENABLE_NORMAL_ACK_RESP_IN_HE_MU_W_TRIG_BIT   ((=
u32)0x00040000)
+#define MAC_HW_MAC_CNTRL_1_ENABLE_NORMAL_ACK_RESP_IN_HE_MU_W_TRIG_POS   18
+#define MAC_HW_MAC_CNTRL_1_DISABLE_NORMAL_ACK_RESP_IN_HE_MU_WO_TRIG_BIT ((=
u32)0x00020000)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_NORMAL_ACK_RESP_IN_HE_MU_WO_TRIG_POS 17
+#define MAC_HW_MAC_CNTRL_1_ABGN_MODE_MASK                               ((=
u32)0x0001C000)
+#define MAC_HW_MAC_CNTRL_1_ABGN_MODE_LSB                                14
+#define MAC_HW_MAC_CNTRL_1_ABGN_MODE_WIDTH                              ((=
u32)0x00000003)
+#define MAC_HW_MAC_CNTRL_1_KEY_STO_RAM_RESET_BIT                        ((=
u32)0x00002000)
+#define MAC_HW_MAC_CNTRL_1_KEY_STO_RAM_RESET_POS                        13
+#define MAC_HW_MAC_CNTRL_1_MIB_TABLE_RESET_BIT                          ((=
u32)0x00001000)
+#define MAC_HW_MAC_CNTRL_1_MIB_TABLE_RESET_POS                          12
+#define MAC_HW_MAC_CNTRL_1_RATE_CONTROLLER_MPIF_BIT                     ((=
u32)0x00000800)
+#define MAC_HW_MAC_CNTRL_1_RATE_CONTROLLER_MPIF_POS                     11
+#define MAC_HW_MAC_CNTRL_1_DISABLE_BA_RESP_BIT                          ((=
u32)0x00000400)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_BA_RESP_POS                          10
+#define MAC_HW_MAC_CNTRL_1_DISABLE_CTS_RESP_BIT                         ((=
u32)0x00000200)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_CTS_RESP_POS                         9
+#define MAC_HW_MAC_CNTRL_1_DISABLE_ACK_RESP_BIT                         ((=
u32)0x00000100)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_ACK_RESP_POS                         8
+#define MAC_HW_MAC_CNTRL_1_ACTIVE_CLK_GATING_BIT                        ((=
u32)0x00000080)
+#define MAC_HW_MAC_CNTRL_1_ACTIVE_CLK_GATING_POS                        7
+#define MAC_HW_MAC_CNTRL_1_ENABLE_LP_CLK_SWITCH_BIT                     ((=
u32)0x00000040)
+#define MAC_HW_MAC_CNTRL_1_ENABLE_LP_CLK_SWITCH_POS                     6
+#define MAC_HW_MAC_CNTRL_1_FORCE_MSTA_BA_BIT                            ((=
u32)0x00000020)
+#define MAC_HW_MAC_CNTRL_1_FORCE_MSTA_BA_POS                            5
+#define MAC_HW_MAC_CNTRL_1_DISABLE_FAST_COMPARE_BIT                     ((=
u32)0x00000010)
+#define MAC_HW_MAC_CNTRL_1_DISABLE_FAST_COMPARE_POS                     4
+#define MAC_HW_MAC_CNTRL_1_CFP_AWARE_BIT                                ((=
u32)0x00000008)
+#define MAC_HW_MAC_CNTRL_1_CFP_AWARE_POS                                3
+#define MAC_HW_MAC_CNTRL_1_PWR_MGT_BIT                                  ((=
u32)0x00000004)
+#define MAC_HW_MAC_CNTRL_1_PWR_MGT_POS                                  2
+#define MAC_HW_MAC_CNTRL_1_AP_BIT                                       ((=
u32)0x00000002)
+#define MAC_HW_MAC_CNTRL_1_AP_POS                                       1
+#define MAC_HW_MAC_CNTRL_1_BSS_TYPE_BIT                                 ((=
u32)0x00000001)
+#define MAC_HW_MAC_CNTRL_1_BSS_TYPE_POS                                 0
+
+static inline void mac_hw_mac_cntrl_1_active_clk_gating_setf(struct cl_hw =
*cl_hw, u8 activeclkgating)
+{
+       ASSERT_ERR((((u32)activeclkgating << 7) & ~((u32)0x00000080)) =3D=
=3D 0);
+       cl_reg_write(cl_hw, MAC_HW_MAC_CNTRL_1_ADDR,
+                    (cl_reg_read(cl_hw, MAC_HW_MAC_CNTRL_1_ADDR) & ~((u32)=
0x00000080)) | ((u32)activeclkgating << 7));
+}
+
+/*
+ * @brief EDCA_CCA_BUSY register definition
+ * Indicates the CCA busy time. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 CCA_BUSY_DUR              0x0
+ * </pre>
+ */
+#define MAC_HW_EDCA_CCA_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000022=
0)
+#define MAC_HW_EDCA_CCA_BUSY_OFFSET      0x00000220
+#define MAC_HW_EDCA_CCA_BUSY_INDEX       0x00000088
+#define MAC_HW_EDCA_CCA_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_edca_cca_busy_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_EDCA_CCA_BUSY_ADDR);
+}
+
+/*
+ * @brief RX_MINE_BUSY register definition
+ * RX Busy time by my frames counter register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 rx_mine_time              0x0
+ * </pre>
+ */
+#define MAC_HW_RX_MINE_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000234=
)
+#define MAC_HW_RX_MINE_BUSY_OFFSET      0x00000234
+#define MAC_HW_RX_MINE_BUSY_INDEX       0x0000008D
+#define MAC_HW_RX_MINE_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_rx_mine_busy_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_RX_MINE_BUSY_ADDR);
+}
+
+/*
+ * @brief TX_MINE_BUSY register definition
+ * TX BUSY time by my TX frames register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 TX_MINE_TIME              0x0
+ * </pre>
+ */
+#define MAC_HW_TX_MINE_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000238=
)
+#define MAC_HW_TX_MINE_BUSY_OFFSET      0x00000238
+#define MAC_HW_TX_MINE_BUSY_INDEX       0x0000008E
+#define MAC_HW_TX_MINE_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_tx_mine_busy_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_TX_MINE_BUSY_ADDR);
+}
+
+/*
+ * @brief EDCA_NAV_BUSY register definition
+ * Indicates the NAV busy time register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 NAV_BUSY_DUR              0x0
+ * </pre>
+ */
+#define MAC_HW_EDCA_NAV_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000024=
8)
+#define MAC_HW_EDCA_NAV_BUSY_OFFSET      0x00000248
+#define MAC_HW_EDCA_NAV_BUSY_INDEX       0x00000092
+#define MAC_HW_EDCA_NAV_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_edca_nav_busy_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_EDCA_NAV_BUSY_ADDR);
+}
+
+/*
+ * @brief ADD_CCA_BUSY_SEC_20 register definition
+ * Indicates the CCA on Secondary 20MHz busy time. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 CCA_BUSY_DUR_SEC_20       0x0
+ * </pre>
+ */
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0=
0000290)
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_OFFSET      0x00000290
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_INDEX       0x000000A4
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_RESET       0x00000000
+
+static inline u32 mac_hw_add_cca_busy_sec_20_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_ADD_CCA_BUSY_SEC_20_ADDR);
+}
+
+/*
+ * @brief ADD_CCA_BUSY_SEC_40 register definition
+ * Indicates the CCA on Secondary 40MHz busy time. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 CCA_BUSY_DUR_SEC_40       0x0
+ * </pre>
+ */
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0=
0000294)
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_OFFSET      0x00000294
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_INDEX       0x000000A5
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_RESET       0x00000000
+
+static inline u32 mac_hw_add_cca_busy_sec_40_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_ADD_CCA_BUSY_SEC_40_ADDR);
+}
+
+/*
+ * @brief ADD_CCA_BUSY_SEC_80 register definition
+ * Indicates the CCA on Secondary 80MHz busy time. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 CCA_BUSY_DUR_SEC_80       0x0
+ * </pre>
+ */
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0=
0000298)
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_OFFSET      0x00000298
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_INDEX       0x000000A6
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_RESET       0x00000000
+
+static inline u32 mac_hw_add_cca_busy_sec_80_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_ADD_CCA_BUSY_SEC_80_ADDR);
+}
+
+/*
+ * @brief INTRA_BSS_NAV_BUSY register definition
+ * Count intra BSS NAV busy period register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 INTRA_BSS_NAV_BUSY_DUR    0x0
+ * </pre>
+ */
+#define MAC_HW_INTRA_BSS_NAV_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00=
000408)
+#define MAC_HW_INTRA_BSS_NAV_BUSY_OFFSET      0x00000408
+#define MAC_HW_INTRA_BSS_NAV_BUSY_INDEX       0x00000102
+#define MAC_HW_INTRA_BSS_NAV_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_intra_bss_nav_busy_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_INTRA_BSS_NAV_BUSY_ADDR);
+}
+
+/*
+ * @brief INTER_BSS_NAV_BUSY register definition
+ * Count inter BSS NAV busy period register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 INTER_BSS_NAV_BUSY_DUR    0x0
+ * </pre>
+ */
+#define MAC_HW_INTER_BSS_NAV_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00=
00040C)
+#define MAC_HW_INTER_BSS_NAV_BUSY_OFFSET      0x0000040C
+#define MAC_HW_INTER_BSS_NAV_BUSY_INDEX       0x00000103
+#define MAC_HW_INTER_BSS_NAV_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_inter_bss_nav_busy_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_INTER_BSS_NAV_BUSY_ADDR);
+}
+
+/*
+ * @brief DEBUG_PORT_SEL_A register definition
+ * Used to multiplex different sets of signals on the debug pins. register=
 description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   15:08 DEBUG_PORT_SEL_1          0x0
+ *   07:00 DEBUG_PORT_SEL_0          0x0
+ * </pre>
+ */
+#define MAC_HW_DEBUG_PORT_SEL_A_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000=
0510)
+#define MAC_HW_DEBUG_PORT_SEL_A_OFFSET      0x00000510
+#define MAC_HW_DEBUG_PORT_SEL_A_INDEX       0x00000144
+#define MAC_HW_DEBUG_PORT_SEL_A_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_sel_a_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_SEL_A_ADDR);
+}
+
+static inline void mac_hw_debug_port_sel_a_set(struct cl_hw *cl_hw, u32 va=
lue)
+{
+       cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_SEL_A_ADDR, value);
+}
+
+/*
+ * @brief DEBUG_PORT_SEL_B register definition
+ * Used to multiplex different sets of signals on the register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   15:08 DEBUG_PORT_SEL_3          0x0
+ *   07:00 DEBUG_PORT_SEL_2          0x0
+ * </pre>
+ */
+#define MAC_HW_DEBUG_PORT_SEL_B_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000=
0530)
+#define MAC_HW_DEBUG_PORT_SEL_B_OFFSET      0x00000530
+#define MAC_HW_DEBUG_PORT_SEL_B_INDEX       0x0000014C
+#define MAC_HW_DEBUG_PORT_SEL_B_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_sel_b_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_SEL_B_ADDR);
+}
+
+static inline void mac_hw_debug_port_sel_b_set(struct cl_hw *cl_hw, u32 va=
lue)
+{
+       cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_SEL_B_ADDR, value);
+}
+
+/*
+ * @brief DEBUG_PORT_SEL_C register definition
+ * Used to multiplex different sets of signals on the register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   15:08 DEBUG_PORT_SEL_5          0x0
+ *   07:00 DEBUG_PORT_SEL_4          0x0
+ * </pre>
+ */
+#define MAC_HW_DEBUG_PORT_SEL_C_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000=
0534)
+#define MAC_HW_DEBUG_PORT_SEL_C_OFFSET      0x00000534
+#define MAC_HW_DEBUG_PORT_SEL_C_INDEX       0x0000014D
+#define MAC_HW_DEBUG_PORT_SEL_C_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_sel_c_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_SEL_C_ADDR);
+}
+
+static inline void mac_hw_debug_port_sel_c_set(struct cl_hw *cl_hw, u32 va=
lue)
+{
+       cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_SEL_C_ADDR, value);
+}
+
+/*
+ * @brief DEBUG_PORT_EN register definition
+ * Used to determine which debug ports are enabled register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   05    EN5                       0
+ *   04    EN4                       0
+ *   03    EN3                       0
+ *   02    EN2                       0
+ *   01    EN1                       0
+ *   00    EN0                       0
+ * </pre>
+ */
+#define MAC_HW_DEBUG_PORT_EN_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000053=
8)
+#define MAC_HW_DEBUG_PORT_EN_OFFSET      0x00000538
+#define MAC_HW_DEBUG_PORT_EN_INDEX       0x0000014E
+#define MAC_HW_DEBUG_PORT_EN_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_en_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_EN_ADDR);
+}
+
+static inline void mac_hw_debug_port_en_set(struct cl_hw *cl_hw, u32 value=
)
+{
+       cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_EN_ADDR, value);
+}
+
+/*
+ * @brief DOZE_CNTRL_2 register definition
+ * Contains settings for controlling DOZE state. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31    WAKE_UP_FROM_DOZE         0
+ *   00    WAKE_UP_SW                1
+ * </pre>
+ */
+#define MAC_HW_DOZE_CNTRL_2_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00008048=
)
+#define MAC_HW_DOZE_CNTRL_2_OFFSET      0x00008048
+#define MAC_HW_DOZE_CNTRL_2_INDEX       0x00002012
+#define MAC_HW_DOZE_CNTRL_2_RESET       0x00000001
+
+/* Field definitions */
+#define MAC_HW_DOZE_CNTRL_2_WAKE_UP_FROM_DOZE_BIT ((u32)0x80000000)
+#define MAC_HW_DOZE_CNTRL_2_WAKE_UP_FROM_DOZE_POS 31
+#define MAC_HW_DOZE_CNTRL_2_WAKE_UP_SW_BIT        ((u32)0x00000001)
+#define MAC_HW_DOZE_CNTRL_2_WAKE_UP_SW_POS        0
+
+static inline void mac_hw_doze_cntrl_2_wake_up_sw_setf(struct cl_hw *cl_hw=
, u8 wakeupsw)
+{
+       ASSERT_ERR((((u32)wakeupsw << 0) & ~((u32)0x00000001)) =3D=3D 0);
+       cl_reg_write(cl_hw, MAC_HW_DOZE_CNTRL_2_ADDR,
+                    (cl_reg_read(cl_hw, MAC_HW_DOZE_CNTRL_2_ADDR) & ~((u32=
)0x00000001)) | ((u32)wakeupsw << 0));
+}
+
+/*
+ * @brief TSF_LO register definition
+ * Contains the TSF bits. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 TSF_TIMER_LOW             0x0
+ * </pre>
+ */
+#define MAC_HW_TSF_LO_ADDR        (REG_MAC_HW_BASE_ADDR + 0x000080A4)
+#define MAC_HW_TSF_LO_OFFSET      0x000080A4
+#define MAC_HW_TSF_LO_INDEX       0x00002029
+#define MAC_HW_TSF_LO_RESET       0x00000000
+
+static inline u32 mac_hw_tsf_lo_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_TSF_LO_ADDR);
+}
+
+/*
+ * @brief TSF_HI register definition
+ * Contains the TSF bits. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 TSF_TIMER_HIGH            0x0
+ * </pre>
+ */
+#define MAC_HW_TSF_HI_ADDR        (REG_MAC_HW_BASE_ADDR + 0x000080A8)
+#define MAC_HW_TSF_HI_OFFSET      0x000080A8
+#define MAC_HW_TSF_HI_INDEX       0x0000202A
+#define MAC_HW_TSF_HI_RESET       0x00000000
+
+static inline u32 mac_hw_tsf_hi_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MAC_HW_TSF_HI_ADDR);
+}
+
+#endif /*CL_REG_MAC_HW_H */
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

