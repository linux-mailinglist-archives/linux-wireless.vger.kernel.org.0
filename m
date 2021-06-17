Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921F73AB8FD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbhFQQLp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:45 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:14471
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231889AbhFQQK0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVbtzZrQQyO/fL7xOLHYayln83GSpxP8Fy/hHkFFPkF0xHD1NuxIyoNwdxajLeAi5h6ne7NKSwcEbC6S5OaAx8gfRZpdD3p+cSPCsAk0QeQYrc/1GdhKl3mW04IzpEiQnK2AEZM2e7pc5S65/yaUY4yqZU6gTG9a6L6hAi1KBm9buSXH5vM3tUS1GHWbqjL1RwpS/QrhX0i6pdBt0p+9MrgbXFyU6tqOTjTBCmBCTeEiBijAwUik9Ajkf3dfd3HH41O/mzFI1c4uUQfsIl91qoVKtUBvK/AndgAop0eOGSCnqVSfTKSSh7ldt7gBXSF6lTIaoF4D7z+LlWPA3+iOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n80FhqlvDQm8Df+kvJDZOnhYx03D33Ar85HQ2gZeSo=;
 b=fzWzxZXX2OJQ7ktmIK3s80g4uIpGbPUsTs13fYB+yWGV08LQe+5vpK3dwePhyI05LoJcjPKXdM4WNegA0DCWL078a9wWrol3BRQPobGcV093q/4DSuOva+SwIB6/EYoXUAhNjrlwCxhKM86xu7doWNJ76idx3pn4egKK2UI4CXdmD5BzvkHBhiRuuGBJF1CSpsKBt1qH+hHo3n6bThsJOsX73fIe5AKKWBZ9GH3P8kv90eBQ3leJnpFOwfNXzuD4p7BmJbECXWccAixYton9p9Vg0SwO3bfM3MBTGb1qdRcBaB68R2z0yO+22JhGKZ8m95Zq4OiVg488zB4mYW0eUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n80FhqlvDQm8Df+kvJDZOnhYx03D33Ar85HQ2gZeSo=;
 b=F/vBQCByGDoyDo9COPOktcDuUJnvxsenyMSzE45lyfAST1IUUAmZ+V1yr/OpOyNLn90SdISaNnoH3Ae8zsLEDGanXDewQ3qSYd1B6mZpVcWT0foNDtYi3mT5x9YuME1JW6RcyB/LdmQcOMwcZ8C+CX9qNFtChPnQ8ZQldmzAFb8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:29 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:29 +0000
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
Subject: [RFC v1 165/256] cl8k: add reg/reg_riu_rc.h
Date:   Thu, 17 Jun 2021 16:00:52 +0000
Message-Id: <20210617160223.160998-166-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 705d5200-17ca-46b4-1b4c-08d931a9bd96
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187772537FD044DD1CDA701F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTvZCs1Pdh35MASEEkcOwcxuQCPlG9Zq//0zQ0XYQEwyKemhf78OAQBQUJJ/yYcV0NxX6cVehPCCZ3RQ9122UrF/bQxzKvHg9fricuZH/YSHw2yoIhN0CuYSzd21TuZSquopa4HMfuZeNwXJV5S+xZO0saHyaHNT0Mng/3U0azbyXTUt98XiqtEhPxbrpvxb/lFvVO+TyrKlduB/bt9iPv5HRL4k6PJ9Dxw4q3UgF23qJXzPT3j11h55wvBnzgd3SSyPbDvTqz6+wRPedrLxVglu7/1iudsChNlYNfc+HGvHVN9uBIWAF6eR41YtlJP01uPISF45dkhKceZKbBfRZP1yIYSU+v35h4m13Fn6DkyHW2HYPMYoSWaTaEDMBaXW9Dz4TK5jC73Pn9y9i197FEGwg5aA/rhw7dez/2vkbHBQItI9vunBcZg6HNx7T6Fe3FNWzvNxJRgNLB4PblxmV19/ag2KOZ6XwnOpVSLDGh5BhphHZvE9ZEuU0Iru2X+d8uqxZr9SD3NJY5uCQEsvzv67ouagnKkyGz8YO30m5OBciYLLrPRsjWBPyrAkLr2AjzFjB0oSkfOkoAVDwaYc9WzqgiRZBJZmDJwURJry9NNJSSGkGjCaN9zdx+0dMeEWEKuMkTi8u/MIzMzouAh/ZoW7DEWq5S2W9vqova5XRqsTaaQVGGNEUrEeKOz9vJtibTL5NcOEQjUdxtNpOry2mA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?673w7unRHcyp+PCAhGrPu58gfhYuY0agUdGrNp5wino0Mhc4mqhDE71hc8uI?=
 =?us-ascii?Q?tp6cq2/QCPkSTn0q6NU5BcwG/SB1w/LxwqmddXf7ZtP5cHWg/zeXe3JQVOrb?=
 =?us-ascii?Q?e1dFkW0SlmmxtaL1xFGqEa2TG2jt6Ad9IUhMy7cLujH2XWohvZXcZXL+SHeQ?=
 =?us-ascii?Q?gJRQ2WMjbMfvK5onGI64WGjLdo+ah2jtYMdlhA7MhWA8ibW3mloNliSLcBbR?=
 =?us-ascii?Q?78sXufjST6qEnJaifVc72VE7pmGP1uYeuJxD179J6l3NuqEIQwbQ1CUC7GRX?=
 =?us-ascii?Q?+btlnTwDB1Skji8KN9riwmfhIA7hlA6CFl8xU/jEStOIiMKmtHQUv4mfmnXC?=
 =?us-ascii?Q?Exj8VryvxBcPGHB4W3b8N9yqFDB5R6LPcKC0AP8yXUkYPWp5NUefSD4IlTU3?=
 =?us-ascii?Q?HlgCx1WbKV5GY20deEOcgFSzzv6qtMeDfl1lDGFnnYRR5yW6A8JrFpmE4qwH?=
 =?us-ascii?Q?uCZLYu1AlPZI6uhfoDtJh4gP9SMOFWN3oZkHsHmeRwJuzapKlmaS9hvPJxDu?=
 =?us-ascii?Q?TszD0TSoEOpZCEBdEkaEdEl+WYcMwe9NR10SWsqBmb72S9Sd/LUotXDMkUW8?=
 =?us-ascii?Q?7fa3k+7uslSNQ0sIg0iqvCT/onmuAKH9ApJvF60asmgloU92dX7GuIcSTOwp?=
 =?us-ascii?Q?xHi0qTroNw8AD0LoAsmoY6tfpOyn6A4El+v06VizUU/wmz5ALcIH+uJ29s1S?=
 =?us-ascii?Q?Cmdbivf56Yf+3O77+yckJg65vXVlzjfDahUw8x9eyh9HDMNnrdrePORt0Md0?=
 =?us-ascii?Q?g2T624J/GLkPdax1zj6ZIpDYVEvEDKKGkYK4ZdlpeeKNJrUYpJYzuNZgSLiY?=
 =?us-ascii?Q?83A2JsZgvKqSOlYSibskISMr0uoTq1RYP1AlT/8hHgvMoEi6oHcZGLZYsSAc?=
 =?us-ascii?Q?PNC5Om8xcgKSvDvMDBc/Lh+1vUBMlZWd4aAbN4Q8hhnVUJTtk0eL3JxaPaVZ?=
 =?us-ascii?Q?mT38iIzlPNsjVC80Gsg65tbzPS3LtmzprgpYSYdPl3MFbg2wZfMzJxysVQP1?=
 =?us-ascii?Q?5JhGJMX00isKi+hv78+H8ZK63eTRirEHDlQtMyzDUUn6Tbcm3qCW+asDp+Jr?=
 =?us-ascii?Q?A1qkPzZSVmU2umGnLYRrmnFsQ2y5jV1IeDsIqm4ldxMGk4y+uIjtNzUHojaD?=
 =?us-ascii?Q?NnsSVJQbIVnFtPJBkpoJ+99QGCy2B0q0GZkjFSwrhs+XVjBTxbEbdRzBkoht?=
 =?us-ascii?Q?Ep6KN7xgLJ1MffgGjHlSpBNf1raaJ1xMcdWjFAPUWqaHtGn02eYtNCn+a0Fz?=
 =?us-ascii?Q?xwlpCohr1AdpIgemUrlhKvulNcPKriXZ7+d04fK6Fc1vu2DYn/5o6ho29Ljk?=
 =?us-ascii?Q?X3lOKzCAsjhS+ePqOgnP1Lt4?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705d5200-17ca-46b4-1b4c-08d931a9bd96
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:35.0965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2aJr/DrWwPxNEG4KkyBW2hninZgSP6UUpfMk3ubue4yj7A3DJ5mG5Byl+CKFaAnqxZp2zWk5eMLoJoJW1NGXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_riu_rc.h | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_riu_rc.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_riu_rc.h b/drivers/ne=
t/wireless/celeno/cl8k/reg/reg_riu_rc.h
new file mode 100644
index 000000000000..320a460df4f1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_riu_rc.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_RC_H
+#define CL_REG_RC_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+#define REG_RIU_RC_BASE_ADDR 0x00485000
+
+/*
+ * @brief SW_CTRL register definition
+ * This register provides write access to the radio SPI interface register=
 description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   31    START_DONE                0
+ *   30    MORE                      0
+ *   29    FASTWR_SPD                0
+ *   28    FASTWR_FORCE              0
+ *   27    FWR_HW_ENABLE             1
+ *   26    FWR_SW_ENABLE             1
+ *   25    FWR_ENABLE                1
+ *   24    RF_RESET_B                0
+ *   23:19 PRESCALER                 0x1
+ *   16    READNOTWRITE              0
+ *   14:08 ADDRESS                   0x0
+ *   07:00 DATA                      0x0
+ * </pre>
+ */
+#define RIU_RC_SW_CTRL_ADDR        (REG_RIU_RC_BASE_ADDR + 0x00000000)
+#define RIU_RC_SW_CTRL_OFFSET      0x00000000
+#define RIU_RC_SW_CTRL_INDEX       0x00000000
+#define RIU_RC_SW_CTRL_RESET       0x0E080000
+
+static inline void riu_rc_sw_ctrl_pack(struct cl_hw *cl_hw, u8 startdone, =
u8 more, u8 fastwrspd,
+                                      u8 fastwrforce, u8 fwrhwenable, u8 f=
wrswenable, u8 fwrenable,
+                                      u8 rfresetb, u8 prescaler, u8 readno=
twrite, u8 address,
+                                      u8 data)
+{
+       ASSERT_ERR((((u32)more << 30) & ~((u32)0x40000000)) =3D=3D 0);
+       ASSERT_ERR((((u32)fastwrspd << 29) & ~((u32)0x20000000)) =3D=3D 0);
+       ASSERT_ERR((((u32)fastwrforce << 28) & ~((u32)0x10000000)) =3D=3D 0=
);
+       ASSERT_ERR((((u32)fwrhwenable << 27) & ~((u32)0x08000000)) =3D=3D 0=
);
+       ASSERT_ERR((((u32)fwrswenable << 26) & ~((u32)0x04000000)) =3D=3D 0=
);
+       ASSERT_ERR((((u32)fwrenable << 25) & ~((u32)0x02000000)) =3D=3D 0);
+       ASSERT_ERR((((u32)rfresetb << 24) & ~((u32)0x01000000)) =3D=3D 0);
+       ASSERT_ERR((((u32)prescaler << 19) & ~((u32)0x00F80000)) =3D=3D 0);
+       ASSERT_ERR((((u32)readnotwrite << 16) & ~((u32)0x00010000)) =3D=3D =
0);
+       ASSERT_ERR((((u32)address << 8) & ~((u32)0x00007F00)) =3D=3D 0);
+
+       cl_reg_write(cl_hw, RIU_RC_SW_CTRL_ADDR, ((u32)startdone << 31) | (=
(u32)more << 30) |
+                    ((u32)fastwrspd << 29) | ((u32)fastwrforce << 28) | ((=
u32)fwrhwenable << 27) |
+                    ((u32)fwrswenable << 26) | ((u32)fwrenable << 25) | ((=
u32)rfresetb << 24) |
+                    ((u32)prescaler << 19) | ((u32)readnotwrite << 16) | (=
(u32)address << 8) |
+                    ((u32)data << 0));
+}
+
+static inline u8 riu_rc_sw_ctrl_start_done_getf(struct cl_hw *cl_hw)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, RIU_RC_SW_CTRL_ADDR);
+
+       return ((local_val & ((u32)0x80000000)) >> 31);
+}
+
+static inline u8 riu_rc_sw_ctrl_data_getf(struct cl_hw *cl_hw)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, RIU_RC_SW_CTRL_ADDR);
+
+       return ((local_val & ((u32)0x000000FF)) >> 0);
+}
+
+/*
+ * @brief RF_LNA_LUT register definition
+ * These registers provide control of the RF LNA assertion by decoding eac=
h possible value the AGC
+ * LNA gain setting, from minimum LNA gain to maximum LNA gain. register d=
escription
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   26:24 RFLNALUT6                 0x6
+ *   22:20 RFLNALUT5                 0x5
+ *   18:16 RFLNALUT4                 0x4
+ *   14:12 RFLNALUT3                 0x3
+ *   10:08 RFLNALUT2                 0x2
+ *   06:04 RFLNALUT1                 0x1
+ *   02:00 RFLNALUT0                 0x0
+ * </pre>
+ */
+
+/* Field definitions */
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_6_MASK  ((u32)0x07000000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_6_LSB   24
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_6_WIDTH ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_5_MASK  ((u32)0x00700000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_5_LSB   20
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_5_WIDTH ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_4_MASK  ((u32)0x00070000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_4_LSB   16
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_4_WIDTH ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_3_MASK  ((u32)0x00007000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_3_LSB   12
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_3_WIDTH ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_2_MASK  ((u32)0x00000700)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_2_LSB   8
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_2_WIDTH ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_1_MASK  ((u32)0x00000070)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_1_LSB   4
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_1_WIDTH ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_0_MASK  ((u32)0x00000007)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_0_LSB   0
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_0_WIDTH ((u32)0x00000003)
+
+#endif /* CL_REG_RC_H */
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

