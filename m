Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9703AB8CE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFQQKl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:41 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:14471
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233806AbhFQQJn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qqw2GBnKzNgLAIPU9EMoj2GsHVqhIjCk9Sn0NTPFFsMUZj0ZQy1NiOjKAkNCcJdiqRKZPYUSCXlSl7hdKOCRwvJzfDF0G+l++qrHeI8lHgy9INdY78tmKuEQcG5YDji4mFCpEq2EWV0Ol8Ubh3r3Ss/4OlTyYv1JObNjjxy3+RW+xhvl1wUKcA1Wa6zsnmaMCFBtDERxqnmP+5jB1d3ZDa5dN5rSFLJS4FAVIs8iruV55DPZyRymP4F4cKmhTV6ocS+Aly5XQIfYrFDEkf6RY7kF8ECQrg84diD6fc08ny3VDAbFQs3wJl5Bkb8OXsa6K3BrTI7kN0ciWYQZ/cQgbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyKC5Neenhlm6pI75Yz87G8rumom7TZaTC46kjH8xrQ=;
 b=kAAPV9Kv5pRv/iPryu/MkLCHc9xOGgssFFBRwnDXtT1LPDtQfhyWaZv5BbqgMvAAugewSZaWxxY3+OaJZh/f+sr+Rj/VA5tb+gpfZn/SE9Z0/x1PT4WEMHq0xnIi8K/JK+Rsvr4sJum6CSFVHis3kP94zj/Vmv/Eg23ERVexOpKIULXvSidS5cs+q0vD4uor3jWADhQTJunhCZSULiXMBEbJB1QtkHwRl9pPJn22L6AzxnEzOSHzv+WXuN30RGb21X0yGlhVegWDz9t3fX18nOga3vktIMbvwA9tSi+XyQERC1lXX7juj98T5v/wD0LzC2y96WMYTtKfk1a27sCiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyKC5Neenhlm6pI75Yz87G8rumom7TZaTC46kjH8xrQ=;
 b=PqEHa3ZRYi493A+jV5/yTEp/t9V+O7Jlz+JETVVZHuilzJdG7XdYNqNm1tERBCrYTYMMT85YdNoK02nn60RcJiHkKYn/qwKD1AShHENtwCt5mK8GbCyX/GxYVNJYKaKGJ1xBqDlZWkcEhyo3N7HTZe55IxcOWlphMApR1zjVp+s=
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
Subject: [RFC v1 158/256] cl8k: add reg/reg_macsys_gcu.h
Date:   Thu, 17 Jun 2021 16:00:45 +0000
Message-Id: <20210617160223.160998-159-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea0da61-9612-4ca7-5e2f-08d931a9b90c
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1187665595B2DF91F301B54DF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQXPgoX4WeKk550iMRD70aph0aQ41YBY3ZKIabj8gRI/QVkPNdKHp+c3z+55guinteTa5G6ZuDylx45HfljFeehyOLxmYjoW57YfQmDLtTVIXmSCu3yrf1d88/UEScWNXH1MWtW9tzEVh8jm58It7CAklSunuofMeKiLQXiGfR6fHbsSOwN3yGG3zbfpYdcr2RGJEIHHm1lwkmWy+rttP/40ArQGrB1VNDPYfCxQ+d9yuouOuwcomXE19ZW4gll6Va9wTBQTQwRj+0bPGCtOZc8GNIQhyuD2FKn3IsUVrxHIp93cGrDvbvlAdSC4oBDc9U6GxJn8S3vxsHyxFG1GXZVHttsJCLYvWjzVOp4AvYic1oMobEuPVZ3RBxlgz2fh3sWaZB4+w4XifQfSn2Jzeo+HGoeSo3iRW7h1baq0EZnfWIbxzl+PGBZdnZbdKt3Wxl3/xEQHfBpmMG+s3jid2EfKA2sq31no2nX9UBIGr+F3UecrycZGqruQuMiyTEMomF8LiPpUPIIdpbz6PaV/dI8+NA/ZDLkL0vbRJKHSeYtrzpqggxdv02IkMhwiUqGNfaqg7s8bmBR0Y0lfIKCF25V69xJpZdcBCLWSJMTPRsjAwTE3y88sNXDVE58o+I6ZoIp+5hl+Wxkp5pvdf8im3HJWG4VRnbcMmn64TzICEJAZHSWRf6F1iJjDIgasEKu9tRTiIBhuyePoABkzYoG/Mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OXqJnNkXlw6yGiQQcSYzA5TU8J11VfLBkFJD3jWUvuEevAWVzQAm9yinb8ZN?=
 =?us-ascii?Q?YMREP651L7IJtcH1uBZ8sgsOZ9o652aThQ2/eH2CzLXKRbc/46mSckK78Efi?=
 =?us-ascii?Q?yKr26X6JAaKQ9iqy3U4vHLPtPQO+y12KW+I73bzhpKyp4HZ2+iE+hWmjn4vv?=
 =?us-ascii?Q?Az/OQNPmockYb2dkIml8bXCl2ne5BBdXs7GMb0McbgOj+hxr99MwY2EzfShY?=
 =?us-ascii?Q?GALGUAbIWA2ufWfQlcB3qW18+pSy8aC0p6XAudYmnn4LxL0GbDGztcZ4VP63?=
 =?us-ascii?Q?fpR17EEhvZW4qOwERVEMOmrwaTcJFbbLUPhFaimycdTIZ1DWdG/qALH6ga+s?=
 =?us-ascii?Q?RpqJ34+v7m07AMAl7gHPHvtoPErC/ZIOcinX+UKe2wwDcvqc+6Cs3UWp14e1?=
 =?us-ascii?Q?tn9CDNBDCYFco3lCZn0ran5/mzojBrEvmOGueLhFVLqKmVnUqt2/qgN8hWv9?=
 =?us-ascii?Q?DgXuLRJ91PtgMxvvRLdWxtMU2WL41ufa/gPQLVRI+bN5A4pimohHVcfOGv6Z?=
 =?us-ascii?Q?c3gQLE7mfYEqn3uH8i2LI+x1iCJ5uFxTKTotCIO9f5hlNXOYNzkliKDDJYPN?=
 =?us-ascii?Q?hg7sfnrCml9aWovKDvSUtZnIo2Kd84AiWp+pXeJWnpXNAxNLBamHzt5Lvmm3?=
 =?us-ascii?Q?nejB9VrgmlUYSDos5Be/AXa/cApA3TPkDSo1POQ3rPmt61ti9RTCanYQ/ZdU?=
 =?us-ascii?Q?jPo4Y8w0MF1HoIirG4qxAKoA8LHkVTTCp682hU5Xx0uMTQH2BTVW52Vc3MiM?=
 =?us-ascii?Q?8bxtY80MKaD4QUX0zBOoltFQuVjfASw78YTvi1/CZhKDHr8gbCfQbW1qL+TX?=
 =?us-ascii?Q?4OYF3ym87cduPwDNTWcs59vph4cmW5XejGpBaIktztvkC6k2jfIvW8AWEHp5?=
 =?us-ascii?Q?f5Vj+mQzHVXGxarxsywwsViTaFdXLgl54wu0j2/Hs2h4iuGhc++wht6J8ZtG?=
 =?us-ascii?Q?ioOVZIlzHJWnJ/B7qgEBwxgDsfj+x43C2pn4qwpVv4Y1h+Fw7gEXaSQYMwYL?=
 =?us-ascii?Q?7s8lF0CF9mnc6k/qgNd0KjhJZeSGmn8vuJom43bLBesERNRJp706Dgn7M7IA?=
 =?us-ascii?Q?5+AZTHvExyjIVKTcE4r1kVQLM11meQCh4PlJy9iYaUgGaHI9tCaWHyPXjtsC?=
 =?us-ascii?Q?Jr7b1IVP43yWGWil5nEC+5E4lTUwQPppFVUH6FZfbZXPB3Be3twp9nB/CbQH?=
 =?us-ascii?Q?jmxxOvltIeKkRbIiJuawB6OK6Fw2x9vql97M3/RlyOVMjjUm9TH6EDbyQPlc?=
 =?us-ascii?Q?R+Pw+h7S0jG3Homg/7NEVjVeyWPT2aUrrzs8qzjYF0mPh3bfulNlL+EmNej3?=
 =?us-ascii?Q?vTZyyUy5J9ttynZ5XZxASbqd?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea0da61-9612-4ca7-5e2f-08d931a9b90c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:27.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cv1PAcFKdOqkpE6vbcu7vTBWN2qEcf0fX9fAaJhiSlSGhMiD6VbcKcV0uTcbZhRnO0WGf1dBc9JHsa67VsnIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_macsys_gcu.h | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_macsys_gcu.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_macsys_gcu.h b/driver=
s/net/wireless/celeno/cl8k/reg/reg_macsys_gcu.h
new file mode 100644
index 000000000000..41eb196f4b7c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_macsys_gcu.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_MACSYS_GCU_H
+#define CL_REG_MACSYS_GCU_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "chip.h"
+
+#define REG_MACSYS_GCU_BASE_ADDR 0x007C5000
+#define REG_MACSYS_GCU_COUNT 63
+
+/*
+ * @brief CHIP_VERSION register definition
+ * Chip Version 8000B0 register description
+ * <pre>
+ * Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *  23:08 PRODUCT_ID                0x8000
+ *  07:04 STEP_ID                   0xB
+ *  03:00 REV_ID                    0x0
+ * </pre>
+ */
+#define MACSYS_GCU_CHIP_VERSION_ADDR        (REG_MACSYS_GCU_BASE_ADDR + 0x=
00000050)
+#define MACSYS_GCU_CHIP_VERSION_OFFSET      0x00000050
+#define MACSYS_GCU_CHIP_VERSION_INDEX       0x00000014
+#define MACSYS_GCU_CHIP_VERSION_RESET       0x008000B0
+
+static inline u32 macsys_gcu_chip_version_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, MACSYS_GCU_CHIP_VERSION_ADDR);
+}
+
+/* Field definitions */
+#define MACSYS_GCU_CHIP_VERSION_PRODUCT_ID_MASK  ((u32)0x00FFFF00)
+#define MACSYS_GCU_CHIP_VERSION_PRODUCT_ID_LSB   8
+#define MACSYS_GCU_CHIP_VERSION_PRODUCT_ID_WIDTH ((u32)0x00000010)
+#define MACSYS_GCU_CHIP_VERSION_STEP_ID_MASK     ((u32)0x000000F0)
+#define MACSYS_GCU_CHIP_VERSION_STEP_ID_LSB      4
+#define MACSYS_GCU_CHIP_VERSION_STEP_ID_WIDTH    ((u32)0x00000004)
+#define MACSYS_GCU_CHIP_VERSION_REV_ID_MASK      ((u32)0x0000000F)
+#define MACSYS_GCU_CHIP_VERSION_REV_ID_LSB       0
+#define MACSYS_GCU_CHIP_VERSION_REV_ID_WIDTH     ((u32)0x00000004)
+
+static inline u8 macsys_gcu_chip_version_step_id_getf(struct cl_chip *chip=
)
+{
+       u32 local_val =3D cl_reg_read_chip(chip, MACSYS_GCU_CHIP_VERSION_AD=
DR);
+
+       return ((local_val & ((u32)0x000000F0)) >> 4);
+}
+
+/*
+ * @brief XT_CONTROL register definition
+ * Tensilica control register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   21    smac_debug_en             0
+ *   20    smac_break_in             0
+ *   19    smac_ocd_halt_on_reset    1
+ *   18    smac_run_stall            0
+ *   17    smac_dreset_n             1
+ *   16    smac_breset_n             0
+ *   13    umac_debug_en             0
+ *   12    umac_break_in             0
+ *   11    umac_ocd_halt_on_reset    1
+ *   10    umac_run_stall            0
+ *   09    umac_dreset_n             1
+ *   08    umac_breset_n             0
+ *   05    lmac_debug_en             0
+ *   04    lmac_break_in             0
+ *   03    lmac_ocd_halt_on_reset    1
+ *   02    lmac_run_stall            0
+ *   01    lmac_dreset_n             1
+ *   00    lmac_breset_n             0
+ * </pre>
+ */
+#define MACSYS_GCU_XT_CONTROL_ADDR        (REG_MACSYS_GCU_BASE_ADDR + 0x00=
0000F0)
+#define MACSYS_GCU_XT_CONTROL_OFFSET      0x000000F0
+#define MACSYS_GCU_XT_CONTROL_INDEX       0x0000003C
+#define MACSYS_GCU_XT_CONTROL_RESET       0x000A0A0A
+
+static inline u32 macsys_gcu_xt_control_get(struct cl_chip *chip)
+{
+       return cl_reg_read_chip(chip, MACSYS_GCU_XT_CONTROL_ADDR);
+}
+
+static inline void macsys_gcu_xt_control_set(struct cl_chip *chip, u32 val=
ue)
+{
+       cl_reg_write_chip(chip, MACSYS_GCU_XT_CONTROL_ADDR, value);
+}
+
+#endif /* CL_REG_MACSYS_GCU_H */
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

