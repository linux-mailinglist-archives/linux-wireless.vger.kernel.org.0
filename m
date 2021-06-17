Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137A43AB8C1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbhFQQKT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:19 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:47334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232109AbhFQQJO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0cz/xc3+zh2sdWJdd+8YrxtjTGqVmaRmeFi2OJcxMYiAfbMZzI2LoA4i+DlLW9OXGm7ob5M2n+8YWukK1/ixZvODoV1o2ZtMjy8Rj4N+LKZo1xjAojLj4f8nZM/CVOHbXyCdFWiiBGY1lWenMKZpGbyrv6Cfh7YYKA65P3+Vbp0fxqk7e3pgILgcr9PtPG1qSrS35cGUG0vEafH3ShlR2HY5w7O9Ffy3Tfy2cOKmKOcdCjZSOP3nkQDwMD937OCNr9KBD5LZc+fXqT9HhyTUvLUcVClP4yHC36UzT/vY9NH+Scx7z3FeUK/nbvOlVkKaMzBNfa2LIclj6ET9S3W5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ckg85WOT5VP4GdL3dT51Z3K+dWBnRwRbTSixtFwVgs=;
 b=it220IopDBzL20F+lj4vEfl/9bMQ9MnkKNlB5LAGnT+GUVNmenhkCThew9a4wUPsOdfk+Ul1anUCVoRABEYyHXP68Bpnsau2By2u3rdtMHP3KYWKrCMT+Msam5+PatzakG6S4f2crAosYnMvPDG2alct2qXQvCnU1kTmPsx8pkU5KyLak4CGT0u0tO/ChGMcVUY39KtSDbejKxy343sZsykcvh93fF0CsRRHR5ap78urIL7V8iOUaIDvv4sw4ywO9KFDe7GjTOjFOTGPVQgyzGzIu8WxfmoQQ0qTq3IRwEhXi36AiwUXgP5CfD1J3C3zkL6I3zR0IKKaautBhuBmRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Ckg85WOT5VP4GdL3dT51Z3K+dWBnRwRbTSixtFwVgs=;
 b=ZXfLbu3kQR62BXXKAfvxhdJQO3va5J9xEpRltHICPonN2mVViPoD8WpzZwVQX1l6lNnlFk4Bw7QnmBz6o+6k/mAGSShza7MilC8rgJOxw+wOckf5ie9cPHWgkdyQ+zElQgfXA4uUpWeHe+aHAV8y7YmHkQOEe0QyrEn9O4+9WgM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:26 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:26 +0000
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
Subject: [RFC v1 156/256] cl8k: add reg/reg_lcu_phy.h
Date:   Thu, 17 Jun 2021 16:00:43 +0000
Message-Id: <20210617160223.160998-157-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1dc9ea6c-2181-4dab-015d-08d931a9b7cf
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187C2B1E076C17342CE199CF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCnDcTcPgeyMFHo00jj7LdEekPWS+LVevLomB3AgQnszEx00LwLY89XrbIkjQ4H9cQbx4gbZ1rHI6iJQxL7Zmt1BSJO1FK4I+vbDx8c+EGi2JdzitMsaRt9qZA/rtkcLwsomsVG/SuWb+InkIs0Q/wsJX+OChm/KZVf/K1lK0i11vuvkxkGZ1Bk0WD7xqq3L/ZOoI9/xCjlKnbjKtEd2YdvhBm0a9aBdbPVUUt87vdGY/eGZHiVUrTfzJoWcnmgCL994q1sIzOU4MYsN91VFFHHmm8Nw3lCSQAUEqpFJgKDpP8+C/jR5ZbsY6bCiY09mpzvfA7L7GaHnXUqA5UJKCE1nqcIYYOrP75GuWEJGAIKmHrGv1hDz+//rSXO05svJd4YFp1w/idrJp5cFc7WxHQxXhthkSUnchzGmpRkP7RN7tH2vKvCPng5DJthG2n/nIAy1wMtQzbSnzt48Igxt3+xhgsOhvWVjyEUdEeWNGW+pwX0rGZ6KBeyr+/ucnXiS4kiLHnTtGNBoT55mMpO+grcLnA3wRD/rxROFWNPFhX219KjfSUpeFKV6kTby6JLqqp6OeQ5+ObumlTMLqfR1OpLfM0j1V52HEZdtZQxL9p8EeqQbaoRGXmDRdS27Qp6VWSI6G907laPC6tVjGryMuRVBE5u81xQV+D+etouXzDmddIEfwuP4WLeB9KUv/iWN6xIGF56GUXxPoSbx885+yXU8SiK5zTqfovFAGmHpjRQpPIBZL1i6AiDRno1ug0wo/IWZ+Ly+MVfWqvi2zgek1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cf9UqtEMg5EDUCVFIVtq+zV2FUFiBxDN9dfgX9hdV9PMBjhx6A2QWFK9/Oel?=
 =?us-ascii?Q?ipqw8AvudVa0R7VE+2IJa56Kwsyf3mvGF6OQe86mERcqN7a2JOBTS26lGaxS?=
 =?us-ascii?Q?iEwE2W2MGMuQEeMTjs9eU2gBbFc+9DiZ1vpGsh/YxF/CNKhWAEIkMI6wudui?=
 =?us-ascii?Q?c+uw/xRV84fAvtTtFfcGIc/nzAHCoWTqTnSGc6vEd96Qtp7OIzwzlAuwi6KL?=
 =?us-ascii?Q?bRlST62Ryug9GnqCvImEYY9CT4h78SyIcCUfTz3VrTCZLGde+PDSLPap397X?=
 =?us-ascii?Q?iVFpx3ORIlnpVk/V0YmsDVOPWRwiuzuKoklL5ko1rdlD0pXbOXVVcoSw9mC8?=
 =?us-ascii?Q?/RqPmY9T3296pC+hfWxzWAKMDwC3IMM0ZDuORMzQ1vo9Z0uCGM/tSPtfFQG/?=
 =?us-ascii?Q?RlTKnifJo2dg4GogSgEz5URqh9Bfn46wbm464Pc6bu+nbr5BOM+v6aAbvJ2Z?=
 =?us-ascii?Q?2pL4iMgUlkMmWoNEx21vN4xeW1AF57Tw5omdryaOp5sW60K+Mk8a+S67ZuXn?=
 =?us-ascii?Q?a63rXpg2yHxNmgSi9K3KQNYVexcgDzUv9Gd28CW0C2lI2nzbg8kkEMT9iuSa?=
 =?us-ascii?Q?iIWphyYuLXx73xc9TNiVtgQogkyxUUojCl5u3rWj0JZz9DzrjjGs3QE1Q8dK?=
 =?us-ascii?Q?GY96MfCv65HCk8NgGWyAtu8t8+KavBRvQvkZVJXh96at8vL39APPvNoo9acT?=
 =?us-ascii?Q?jZMMFGpFzvy5gpoYHOmSQpii02e2Z/VUxXiluw2cOok7BbiQc1j34yL0giQB?=
 =?us-ascii?Q?M+i8aM6kjXWiZujLLa91Y78zPQO8g/h6JgavrWo6PdBEo1QAx3xO+v8fjVlA?=
 =?us-ascii?Q?e6uS7L0YcEQYllucSpkFnBrzZJSgTw3xc55VWZv7ISA7WyTVEDdOAa6VDyHt?=
 =?us-ascii?Q?M+dNgQbaQTj/JdwKwuGtJmOEaGqW0wvUSenZUCwbtteIttWA5Jcsa5wwQXYD?=
 =?us-ascii?Q?6MpadC3mnEU/actEdO7Z8YkqsB1iWgseNfu5bkL0Jtf6oE8qkMESupYmTpga?=
 =?us-ascii?Q?hUf90TLWbkiwsVjv9YAsCd+AdYt4hCJnUmfCTExqBhRZK0zLGkPaJYIINX4d?=
 =?us-ascii?Q?uNEBSqAuc1jYFEhUzBVhW/6cDExcY0D1fSm0AFAIyRPk6YbBwX+471ml04hl?=
 =?us-ascii?Q?nRIxfXJMM/elIAww5jc53Il42jSxOON4qhx5i2kL/BlwrcCwZ90bjh3PCkWH?=
 =?us-ascii?Q?wSudNFuuBmaCWlY0sMfl8srA36uTdWR/kx2cn+VrFnPb0rE6AKAAqSVq7qKB?=
 =?us-ascii?Q?dDEbCwVooi+9XSEF3S5H91A3CcKfHxUORJ9NePlGTN/IfnOjFxZd2Iy48X4F?=
 =?us-ascii?Q?zs1Lp71Qf1meFSn6DAxJD6C2?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc9ea6c-2181-4dab-015d-08d931a9b7cf
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:25.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65V3OScN11vGuUpEe4LcL8Rw/zujhZkr74E6cNFmuM8Ujb+zXXmq0ArqcdU/46bZBOOyETt0djIRTjX3XfLcSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_lcu_phy.h    | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_lcu_phy.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_lcu_phy.h b/drivers/n=
et/wireless/celeno/cl8k/reg/reg_lcu_phy.h
new file mode 100644
index 000000000000..b59f327ff6a4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_lcu_phy.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_LCU_PHY_H
+#define CL_REG_LCU_PHY_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+#define REG_LCU_PHY_BASE_ADDR 0x0048E000
+
+/*
+ * @brief LCU_CH_0_STOP register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    CH0_STOP                  0
+ * </pre>
+ */
+#define LCU_PHY_LCU_CH_0_STOP_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000=
070)
+#define LCU_PHY_LCU_CH_0_STOP_OFFSET      0x00000070
+#define LCU_PHY_LCU_CH_0_STOP_INDEX       0x0000001C
+#define LCU_PHY_LCU_CH_0_STOP_RESET       0x00000000
+
+static inline void lcu_phy_lcu_ch_0_stop_set(struct cl_hw *cl_hw, u32 valu=
e)
+{
+       cl_reg_write(cl_hw, LCU_PHY_LCU_CH_0_STOP_ADDR, value);
+}
+
+/* Field definitions */
+#define LCU_PHY_CH_0_STOP_BIT               ((u32)0x00000001)
+#define LCU_PHY_CH_0_STOP_POS               0
+
+#define LCU_PHY_CH_0_STOP_RST               0x0
+
+static inline void lcu_phy_lcu_ch_0_stop_ch_0_stop_setf(struct cl_hw *cl_h=
w, u8 ch0stop)
+{
+       ASSERT_ERR((((u32)ch0stop << 0) & ~((u32)0x00000001)) =3D=3D 0);
+       cl_reg_write(cl_hw, LCU_PHY_LCU_CH_0_STOP_ADDR, (u32)ch0stop << 0);
+}
+
+/*
+ * @brief LCU_CH_1_STOP register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    CH1_STOP                  0
+ * </pre>
+ */
+#define LCU_PHY_LCU_CH_1_STOP_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000=
074)
+#define LCU_PHY_LCU_CH_1_STOP_OFFSET      0x00000074
+#define LCU_PHY_LCU_CH_1_STOP_INDEX       0x0000001D
+#define LCU_PHY_LCU_CH_1_STOP_RESET       0x00000000
+
+static inline void lcu_phy_lcu_ch_1_stop_set(struct cl_hw *cl_hw, u32 valu=
e)
+{
+       cl_reg_write(cl_hw, LCU_PHY_LCU_CH_1_STOP_ADDR, value);
+}
+
+/* Field definitions */
+#define LCU_PHY_CH_1_STOP_BIT               ((u32)0x00000001)
+#define LCU_PHY_CH_1_STOP_POS               0
+
+#define LCU_PHY_CH_1_STOP_RST               0x0
+
+static inline void lcu_phy_lcu_ch_1_stop_ch_1_stop_setf(struct cl_hw *cl_h=
w, u8 ch1stop)
+{
+       ASSERT_ERR((((u32)ch1stop << 0) & ~((u32)0x00000001)) =3D=3D 0);
+       cl_reg_write(cl_hw, LCU_PHY_LCU_CH_1_STOP_ADDR, (u32)ch1stop << 0);
+}
+
+/*
+ * @brief LCU_SW_RST register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    SW_RST                    0
+ * </pre>
+ */
+
+#define LCU_PHY_LCU_SW_RST_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000154=
)
+#define LCU_PHY_LCU_SW_RST_OFFSET      0x00000154
+#define LCU_PHY_LCU_SW_RST_INDEX       0x00000055
+#define LCU_PHY_LCU_SW_RST_RESET       0x00000000
+
+static inline void lcu_phy_lcu_sw_rst_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, LCU_PHY_LCU_SW_RST_ADDR, value);
+}
+
+#endif /* CL_REG_LCU_PHY_H */
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

