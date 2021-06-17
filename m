Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05273AB902
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhFQQLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:52 -0400
Received: from mail-eopbgr70045.outbound.protection.outlook.com ([40.107.7.45]:47334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232156AbhFQQKk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMFqjQrQgqmOkjoR5zhzSfhGJUiKdmw0yF+pVsLfA5qCYrx4bLBzMHrTfjP04ubx9ppGGp07m929oI7bSf40qyrkZ+oYzwbybkY78vkbrPveBLSt2+veTMKdcsacMm2oCV7AO5F3kb7uDTSRYVJFTf3TT5MPLW3PofnkRSfHNvRunJj3bTiqEk7z59HeEMbLMWwLIkOjlrQcj9w9TFvuz04UNcqxkU3xV9s8nqDXB7e1JrBKZbsCX3ET4mUDJOxvS3nG58Lvohx8Ue2IPAjDWa+ODphv9ddGRW+pXlFoXrpraI0IYA2hdpHnzXu1WO4LaNwd70Yq0B6yhqEKoH0Yhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3R/b9BD2zgvmo+lYDiiKspljq7TL0bd1wwrPt81JF0=;
 b=oEkgb3QWATAeTXE49Q8pwz6qiWzkpcjE/XWcazarv04Hglq9bLuQFWCyniFslFnj4ZwV+MiRK9iU9cJ8yC+wla5NGFmeL8687z2XMTD64b8c2DphfJmqkTMPJMatlMLu4Z3ltpRK5sXIAKnCsUcSs0SfhPhIG3v2sQyY8rVPS6x2VYK/T3F18XEWvfa+RP7xUoYke545yGIuq8kLZIBsakgggsjfRvZ97SAUOz6BZ7tfeWAuOjQVcJIRFuvasNK3CjbrHdIrO4piC1gSNhW3H3B5AmQDy8GRhzJejkDcvBenUTP/a5hvKdHNFpDsNCh8MsL+ZtC/yhBQwiHMGZvNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3R/b9BD2zgvmo+lYDiiKspljq7TL0bd1wwrPt81JF0=;
 b=aODT6Kor9VPzYwABVVfms4bwTUlb/PZVfdS2B6MMCL9YY5k1KFskEurw0DCLSlkNwkFA0iF8p5bGd5bNJVF0w4d/EB4UxJvssUMDvH3tepu+uGeuzdvwY74HYxJ6L/cTAUzNmTRQAlA40NyP9aY9fOUQR4F9Tsrd6hVmtQt2/JE=
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
Subject: [RFC v1 164/256] cl8k: add reg/reg_riu.h
Date:   Thu, 17 Jun 2021 16:00:51 +0000
Message-Id: <20210617160223.160998-165-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3cfb4a1-6fa7-4860-5139-08d931a9bcc9
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB118735CE0EFA93437AE905F5F60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:608;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M6S6gRkbNLZnt/xI7Ymag09qonjHnQVrpNpc/RWCEX2S5jfTkA3/v9EqxSSym3HU0nZfXgTIkby91Iu4mjSgvo6vwuuMYAKVOFO1A34CkUrd3CLVvRFhiWZyXJ7fKJa8tp9K+cUeGC/EuJcT4NYmgdXHRv+y0BMh6pgGRvQS8FGpa6RpDxD6qRXU/u+BtVSGQYIHXM9dzi57puMcxJ2QagJib9SmaFVzmd8NAGQ8Uo5mA2frX6J4nUHnc0jHGXyOD5goYARvbwZsMWe0R4LyghdzFiZ/77I0+b6jqlFGf6g6/qR2kKGWrBthsYEJT5ODBtS76kxU0Elr5+OZ1SJWvlM/7VTXa+jPMgMN42JCbsU4i7RVEJhsbPHCs6zQ82iaQAqV35PKeRGyj8iKIni3jq/oHZDLdvEe/rQAqEUD10p3VHjahhufhO3UfQvV2ODqq90Ic/W6v5DvkTeu+HaKrSy1BSBwRbm9O5raTxveouID1zn29U+vqzhNNPG3Y2sZ5A/XdcB8dTq7VzwTeO70VlCljaO4EC5pMrXhOzZ9x0QezzpffjQ08IhtzBpwBMFWZYwJCQfUVU83fT0A4nMWufcLuPFMT0EmFlcFcomewQHYXX1GuoapgyDuhcVunVZpe7DP67VR7+MYgRFf3v4/AxfSDcDUT07ZNwCaptsXj0ChiHqHKzndlY2TH6K04qOsxg0dxg9w09HbXDgUci2G9Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(30864003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5sTjTJhkB97ZE9MP0kWeJCIHf6E4Y8fSC3VzbvPB6EiW4gVRcgLnC8opH7J9?=
 =?us-ascii?Q?Hnqq/rfPQJyfdiBG+IwKF4yMYVhSrVQ4GFUJ9GxEClVT8BgIfX0zoKxkiVHS?=
 =?us-ascii?Q?LqiRc6D1XrEiTcjPEjoG4vhncWGa0ub0RmwrQgv6wXa8SBwWoO3GDfj8I/r9?=
 =?us-ascii?Q?6HBI1k76k/gy/KdF0cZeT4xtWbnELahm05SH052MqG7LgW7ok/P6GdS5KxnF?=
 =?us-ascii?Q?3KuHQe/UGDC691Bu/++k531vFPUv1o1BCQzZbQpbXjnLUZ8qu1E7KKvHLUij?=
 =?us-ascii?Q?gfXwbGSyoqfSgmE7I3QJjOsmrvYNsCVgB3IVNhPUEidqQo0e6jRw3pWlPm8K?=
 =?us-ascii?Q?sXozGRrmZ4p9JQG/x/aOn7SVmf11YqmQknKyVG8uZcN+kNzmHl4UJubLnf3S?=
 =?us-ascii?Q?oftDqUlRZokFBn7f66gLbsQcMEnqq2mv9aTze9REmmYk35HFDu2xghVdig5k?=
 =?us-ascii?Q?O4uBPuVdvgW1O5Sd67MzeSfZuB/HvjkG8DoaG5Q/Bb0mA9Vz512fFKTijunP?=
 =?us-ascii?Q?To5a4KO9kBQRERAK/nWBe3Oi87rAh+JJmWIrFrrVWsxyGzYbM42xTsRqEwg4?=
 =?us-ascii?Q?WjGSHQ4nP98hGpxe81sA0pNxJzCWOKh6G3Z5zwzk3Z3NEfS03i0/Le2As7dJ?=
 =?us-ascii?Q?h/KoZ71FZxUd1GoBVYktjYsz+jDjEow5jI6AwJUSI1/l50lfdzdnoqM1wn/k?=
 =?us-ascii?Q?LyQImE7VVuMd/PveO8vDzhzmXu0knaLlDJMTMpezujP/VsA/GfTdp7ve6Ri8?=
 =?us-ascii?Q?u/Cw1RT3IpBRVC9lkoz6Efj5Xipd2YqvqzoNzuIM3wZMDF19XmdYifKicsr4?=
 =?us-ascii?Q?O4rbYdHmeYuuiFyurCqVO8NIt+YCTrywlpTZkpK8Nhdxdfe4+sM1mZ3aBzGV?=
 =?us-ascii?Q?LQGgxWqEKLTcgO11uGeM/zxnSoKP/r9htPH3p9rkbUjZMclaBr2U1gD8J/bR?=
 =?us-ascii?Q?v6XnX7T2000DiVb6bHaxeurdpU3XCaIfIEjNn4LrhlL2cyvxuurqEHZgXqtP?=
 =?us-ascii?Q?7ApFGnHzrsc+O7EigvOY5Aas8HAgPIZ+nzZrE7DrQyZojOhUiFT//Y1IJZp7?=
 =?us-ascii?Q?ocrZvw26NLrlu3KbAZfuOmN2toMY7qvyoPttsluXeAISgdYB0gBQ/NUJYCyp?=
 =?us-ascii?Q?wgDFogp9blgcHd4GvhU5vHXVsIR3kA01BBkSedIa7R+1JiSPEGY+8arZxHao?=
 =?us-ascii?Q?oBHvzb68iSOYMe3s/IN6rCZnlnAh106kx+Hm4ygcrjfOg5HsnKmrH4HZAtnT?=
 =?us-ascii?Q?NjVkBfBx/0WZi7R1EvQmcZAmcJo4oHRfOHGWtuE8Fq3DVglgU1xewY7Uxhif?=
 =?us-ascii?Q?uiwBxDHCKY8Fowih3hzSC6T+?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cfb4a1-6fa7-4860-5139-08d931a9bcc9
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:33.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CaQorMnUbaTkN8l0Ihfq8SBe18TjOxMPff5GmN8gYIx4DEXgpVMBRCMEvc7Ln0uqR/4qAaRDOqkSKJLbsN1LsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_riu.h    | 902 ++++++++++++++++++
 1 file changed, 902 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_riu.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_riu.h b/drivers/net/w=
ireless/celeno/cl8k/reg/reg_riu.h
new file mode 100644
index 000000000000..15df2dcb13ee
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_riu.h
@@ -0,0 +1,902 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_RIU_H
+#define CL_REG_RIU_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+#define RIU_RSF_FILE_SIZE 0x60C
+
+/*
+ * @brief CCA_CNT_CS register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_CS                0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_CS_ADDR        (REG_RIU_BASE_ADDR + 0x00000058)
+#define RIU_CCA_CNT_CS_OFFSET      0x00000058
+#define RIU_CCA_CNT_CS_INDEX       0x00000016
+#define RIU_CCA_CNT_CS_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_cs_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_CS_ADDR);
+}
+
+/*
+ * @brief RSF_CONTROL register definition
+ *  resampling filter operation mode register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    rsf_init_en               1
+ *    07    rsf_tx_bypass_type        0
+ *    06    rsf_tx_bypass_mode        1
+ *    05    rsf_rx_bypass_type        0
+ *    04    rsf_rx_bypass_mode        1
+ *    01    rsf_rx_ctl_from_reg       1
+ * </pre>
+ */
+#define RIU_RSF_CONTROL_ADDR        (REG_RIU_BASE_ADDR + 0x000001A8)
+#define RIU_RSF_CONTROL_OFFSET      0x000001A8
+#define RIU_RSF_CONTROL_INDEX       0x0000006A
+#define RIU_RSF_CONTROL_RESET       0x80000053
+
+static inline void riu_rsf_control_rsf_init_en_setf(struct cl_hw *cl_hw, u=
8 rsfiniten)
+{
+       cl_reg_write(cl_hw, RIU_RSF_CONTROL_ADDR,
+                    (cl_reg_read(cl_hw, RIU_RSF_CONTROL_ADDR) & ~((u32)0x8=
0000000)) | ((u32)rsfiniten << 31));
+}
+
+/*
+ * @brief RSF_INIT register definition
+ *  resampling filter initialization data register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 RSF_INIT_DATA             0x0
+ * </pre>
+ */
+#define RIU_RSF_INIT_ADDR        (REG_RIU_BASE_ADDR + 0x000001AC)
+#define RIU_RSF_INIT_OFFSET      0x000001AC
+#define RIU_RSF_INIT_INDEX       0x0000006B
+#define RIU_RSF_INIT_RESET       0x00000000
+
+static inline void riu_rsf_init_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, RIU_RSF_INIT_ADDR, value);
+}
+
+/*
+ * @brief AGCFSM_RAM_INIT_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    AGC_FSM_RAM_INIT_EN       0
+ *    29    AGC_FSM_RAM_INIT_AINC2    0
+ *    28    AGC_FSM_RAM_INIT_AINC1    0
+ *    12    AGC_FSM_RAM_INIT_WPTR_SET 0
+ *    10:00 AGC_FSM_RAM_INIT_WPTR     0x0
+ * </pre>
+ */
+#define RIU_AGCFSM_RAM_INIT_1_ADDR        (REG_RIU_BASE_ADDR + 0x000001B0)
+#define RIU_AGCFSM_RAM_INIT_1_OFFSET      0x000001B0
+#define RIU_AGCFSM_RAM_INIT_1_INDEX       0x0000006C
+#define RIU_AGCFSM_RAM_INIT_1_RESET       0x00000000
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_setf(struct=
 cl_hw *cl_hw,
+                                                                   u16 agc=
fsmraminitwptr)
+{
+       ASSERT_ERR((((u32)agcfsmraminitwptr << 0) & ~((u32)0x000007FF)) =3D=
=3D 0);
+       cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+                    (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u=
32)0x000007FF)) | ((u32)agcfsmraminitwptr << 0));
+}
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_set_setf(st=
ruct cl_hw *cl_hw, u8 agcfsmraminitwptrset)
+{
+       ASSERT_ERR((((u32)agcfsmraminitwptrset << 12) & ~((u32)0x00001000))=
 =3D=3D 0);
+       cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+                    (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u=
32)0x00001000)) | ((u32)agcfsmraminitwptrset << 12));
+}
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_ainc_1_setf(stru=
ct cl_hw *cl_hw,
+                                                                     u8 ag=
cfsmraminitainc1)
+{
+       ASSERT_ERR((((u32)agcfsmraminitainc1 << 28) & ~((u32)0x10000000)) =
=3D=3D 0);
+       cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+                    (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u=
32)0x10000000)) | ((u32)agcfsmraminitainc1 << 28));
+}
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_en_setf(struct c=
l_hw *cl_hw,
+                                                                 u8 agcfsm=
raminiten)
+{
+       cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+                    (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u=
32)0x80000000)) | ((u32)agcfsmraminiten << 31));
+}
+
+/*
+ * @brief AGCFSM_RAM_INIT_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 AGC_FSM_RAM_INIT_WDATA    0x0
+ * </pre>
+ */
+#define RIU_AGCFSM_RAM_INIT_2_ADDR        (REG_RIU_BASE_ADDR + 0x000001B4)
+#define RIU_AGCFSM_RAM_INIT_2_OFFSET      0x000001B4
+#define RIU_AGCFSM_RAM_INIT_2_INDEX       0x0000006D
+#define RIU_AGCFSM_RAM_INIT_2_RESET       0x00000000
+
+static inline void riu_agcfsm_ram_init_2_set(struct cl_hw *cl_hw, u32 valu=
e)
+{
+       cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_2_ADDR, value);
+}
+
+/*
+ * @brief AGCINBDPOW_20_STAT register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOW20_PDBM3           0x0
+ *    23:16 INBDPOW20_PDBM2           0x0
+ *    15:08 INBDPOW20_PDBM1           0x0
+ *    07:00 INBDPOW20_PDBM0           0x0
+ * </pre>
+ */
+#define RIU_AGCINBDPOW_20_STAT_ADDR        (REG_RIU_BASE_ADDR + 0x0000020C=
)
+#define RIU_AGCINBDPOW_20_STAT_OFFSET      0x0000020C
+#define RIU_AGCINBDPOW_20_STAT_INDEX       0x00000083
+#define RIU_AGCINBDPOW_20_STAT_RESET       0x00000000
+
+static inline void riu_agcinbdpow_20_stat_unpack(struct cl_hw *cl_hw,
+                                                u8 *inbdpow20pdbm3, u8 *in=
bdpow20pdbm2,
+                                                u8 *inbdpow20pdbm1, u8 *in=
bdpow20pdbm0)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, RIU_AGCINBDPOW_20_STAT_ADDR);
+
+       *inbdpow20pdbm3 =3D (local_val & ((u32)0xFF000000)) >> 24;
+       *inbdpow20pdbm2 =3D (local_val & ((u32)0x00FF0000)) >> 16;
+       *inbdpow20pdbm1 =3D (local_val & ((u32)0x0000FF00)) >> 8;
+       *inbdpow20pdbm0 =3D (local_val & ((u32)0x000000FF)) >> 0;
+}
+
+/*
+ * @brief AGCINBDPOW_20_PNOISESTAT register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOW20_PNOISEDBM3      0x0
+ *    23:16 INBDPOW20_PNOISEDBM2      0x0
+ *    15:08 INBDPOW20_PNOISEDBM1      0x0
+ *    07:00 INBDPOW20_PNOISEDBM0      0x0
+ * </pre>
+ */
+#define RIU_AGCINBDPOW_20_PNOISESTAT_ADDR        (REG_RIU_BASE_ADDR + 0x00=
000228)
+#define RIU_AGCINBDPOW_20_PNOISESTAT_OFFSET      0x00000228
+#define RIU_AGCINBDPOW_20_PNOISESTAT_INDEX       0x0000008A
+#define RIU_AGCINBDPOW_20_PNOISESTAT_RESET       0x00000000
+
+static inline u32 riu_agcinbdpow_20_pnoisestat_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_AGCINBDPOW_20_PNOISESTAT_ADDR);
+}
+
+/*
+ * @brief AGCINBDPOWSECNOISESTAT register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:16 INBDPOW80_SNOISEDBM       0x0
+ *    15:08 INBDPOW40_SNOISEDBM       0x0
+ *    07:00 INBDPOW20_SNOISEDBM       0x0
+ * </pre>
+ */
+#define RIU_AGCINBDPOWSECNOISESTAT_ADDR        (REG_RIU_BASE_ADDR + 0x0000=
0230)
+#define RIU_AGCINBDPOWSECNOISESTAT_OFFSET      0x00000230
+#define RIU_AGCINBDPOWSECNOISESTAT_INDEX       0x0000008C
+#define RIU_AGCINBDPOWSECNOISESTAT_RESET       0x00000000
+
+static inline u32 riu_agcinbdpowsecnoisestat_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_AGCINBDPOWSECNOISESTAT_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_MODEM_STATE_P register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_MODEM_STATE_P     0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_MODEM_STATE_P_ADDR        (REG_RIU_BASE_ADDR + 0x00000=
2DC)
+#define RIU_CCA_CNT_MODEM_STATE_P_OFFSET      0x000002DC
+#define RIU_CCA_CNT_MODEM_STATE_P_INDEX       0x000000B7
+#define RIU_CCA_CNT_MODEM_STATE_P_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_modem_state_p_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_MODEM_STATE_P_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_MODEM_STATE_20_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_MODEM_STATE_20_S  0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_MODEM_STATE_20_S_ADDR        (REG_RIU_BASE_ADDR + 0x00=
0002E0)
+#define RIU_CCA_CNT_MODEM_STATE_20_S_OFFSET      0x000002E0
+#define RIU_CCA_CNT_MODEM_STATE_20_S_INDEX       0x000000B8
+#define RIU_CCA_CNT_MODEM_STATE_20_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_modem_state_20_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_MODEM_STATE_20_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_MODEM_STATE_40_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_MODEM_STATE_40_S  0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_MODEM_STATE_40_S_ADDR        (REG_RIU_BASE_ADDR + 0x00=
0002E4)
+#define RIU_CCA_CNT_MODEM_STATE_40_S_OFFSET      0x000002E4
+#define RIU_CCA_CNT_MODEM_STATE_40_S_INDEX       0x000000B9
+#define RIU_CCA_CNT_MODEM_STATE_40_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_modem_state_40_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_MODEM_STATE_40_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_MODEM_STATE_80_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_MODEM_STATE_80_S  0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_MODEM_STATE_80_S_ADDR        (REG_RIU_BASE_ADDR + 0x00=
0002E8)
+#define RIU_CCA_CNT_MODEM_STATE_80_S_OFFSET      0x000002E8
+#define RIU_CCA_CNT_MODEM_STATE_80_S_INDEX       0x000000BA
+#define RIU_CCA_CNT_MODEM_STATE_80_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_modem_state_80_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_MODEM_STATE_80_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_P register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_P      0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_P_ADDR        (REG_RIU_BASE_ADDR + 0x000002=
F4)
+#define RIU_CCA_CNT_ENERGY_THR_P_OFFSET      0x000002F4
+#define RIU_CCA_CNT_ENERGY_THR_P_INDEX       0x000000BD
+#define RIU_CCA_CNT_ENERGY_THR_P_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_p_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_P_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_S   0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_S_ADDR        (REG_RIU_BASE_ADDR + 0x000=
002F8)
+#define RIU_CCA_CNT_ENERGY_THR_20_S_OFFSET      0x000002F8
+#define RIU_CCA_CNT_ENERGY_THR_20_S_INDEX       0x000000BE
+#define RIU_CCA_CNT_ENERGY_THR_20_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_GI_20_P register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_GI_20_P           0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_GI_20_P_ADDR        (REG_RIU_BASE_ADDR + 0x000002FC)
+#define RIU_CCA_CNT_GI_20_P_OFFSET      0x000002FC
+#define RIU_CCA_CNT_GI_20_P_INDEX       0x000000BF
+#define RIU_CCA_CNT_GI_20_P_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_gi_20_p_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_GI_20_P_ADDR);
+}
+
+/*
+ * @brief RWNXAGCRAMP register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    26:24 RAMPDNNDLINDEX            0x5
+ *    23:16 RAMPDNGAPQDB              0x20
+ *    10:08 RAMPUPNDLINDEX            0x7
+ *    07:00 RAMPUPGAPQDB              0x10
+ * </pre>
+ */
+#define RIU_RWNXAGCRAMP_ADDR        (REG_RIU_BASE_ADDR + 0x0000036C)
+#define RIU_RWNXAGCRAMP_OFFSET      0x0000036C
+#define RIU_RWNXAGCRAMP_INDEX       0x000000DB
+#define RIU_RWNXAGCRAMP_RESET       0x05200710
+
+static inline u8 riu_rwnxagcramp_rampupgapqdb_getf(struct cl_hw *cl_hw)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, RIU_RWNXAGCRAMP_ADDR);
+
+       return ((local_val & ((u32)0x000000FF)) >> 0);
+}
+
+static inline void riu_rwnxagcramp_rampupgapqdb_setf(struct cl_hw *cl_hw, =
u8 rampupgapqdb)
+{
+       cl_reg_write(cl_hw, RIU_RWNXAGCRAMP_ADDR,
+                    (cl_reg_read(cl_hw, RIU_RWNXAGCRAMP_ADDR) & ~((u32)0x0=
00000FF)) | ((u32)rampupgapqdb << 0));
+}
+
+/*
+ * @brief RWNXAGCCNTL register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:26 COMBPATHSEL               0x3F
+ *    25:20 GAINKEEP                  0x0
+ *    16    HTSTFGAINEN               1
+ *    15    NOISE_CAPTURE_DELAY_MODE  0
+ *    14    EST_PATH_SEL_2            0
+ *    13    CCA_MDM_ST_CLEAR          0
+ *    12    AGCFSMRESET               0
+ *    11    RADARDETEN                0
+ *    10    RIFSDETEN                 1
+ *    09    DSSSONLY                  0
+ *    08    OFDMONLY                  0
+ *    07:04 GPSTATUS                  0x0
+ *    03    EST_PATH_SEL              0
+ *    01    ADC_SEL_RADAR_DETECTOR    0
+ *    00    ADC_SEL_COMP_MODULE       0
+ * </pre>
+ */
+#define RIU_RWNXAGCCNTL_ADDR        (REG_RIU_BASE_ADDR + 0x00000390)
+#define RIU_RWNXAGCCNTL_OFFSET      0x00000390
+#define RIU_RWNXAGCCNTL_INDEX       0x000000E4
+#define RIU_RWNXAGCCNTL_RESET       0xFC010400
+
+static inline void riu_rwnxagccntl_agcfsmreset_setf(struct cl_hw *cl_hw, u=
8 agcfsmreset)
+{
+       ASSERT_ERR((((u32)agcfsmreset << 12) & ~((u32)0x00001000)) =3D=3D 0=
);
+       cl_reg_write(cl_hw, RIU_RWNXAGCCNTL_ADDR,
+                    (cl_reg_read(cl_hw, RIU_RWNXAGCCNTL_ADDR) & ~((u32)0x0=
0001000)) | ((u32)agcfsmreset << 12));
+}
+
+/*
+ * @brief RWNXAGCCCA_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    CCA_CNT_CLEAR             0
+ *    30:29 CCA_CNT_RATE              0x0
+ *    28:20 INBDCCAPOWMINDBM          0x1B5
+ *    19:12 CCAFALLTHRDBM             0xBF
+ *    10    CCAEnergy_Reset_Type      0
+ *    09    DISCCAEN                  1
+ *    08    SATCCAEN                  1
+ *    07:00 CCARISETHRDBM             0xC2
+ * </pre>
+ */
+#define RIU_RWNXAGCCCA_1_ADDR        (REG_RIU_BASE_ADDR + 0x000003AC)
+#define RIU_RWNXAGCCCA_1_OFFSET      0x000003AC
+#define RIU_RWNXAGCCCA_1_INDEX       0x000000EB
+#define RIU_RWNXAGCCCA_1_RESET       0x1B5BF3C2
+
+static inline void riu_rwnxagccca_1_cca_cnt_clear_setf(struct cl_hw *cl_hw=
, u8 ccacntclear)
+{
+       cl_reg_write(cl_hw, RIU_RWNXAGCCCA_1_ADDR,
+                    (cl_reg_read(cl_hw, RIU_RWNXAGCCCA_1_ADDR) & ~((u32)0x=
80000000)) | ((u32)ccacntclear << 31));
+}
+
+/*
+ * @brief RWNXAGCCCACTRL register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:28 CCAFLAG3_CTRL             0xA
+ *    27:24 CCAFLAG2_CTRL             0x2
+ *    23:20 CCAFLAG1_CTRL             0x8
+ *    19:16 CCAFLAG0_CTRL             0x0
+ *    14:12 CCA_SECOND_ANT_SEL        0x1
+ *    10:08 CCA_MAIN_ANT_SEL          0x0
+ *    07:04 CCADEMOD                  0xF
+ *    00    CCACSEN                   1
+ * </pre>
+ */
+#define RIU_RWNXAGCCCACTRL_ADDR        (REG_RIU_BASE_ADDR + 0x000003B0)
+#define RIU_RWNXAGCCCACTRL_OFFSET      0x000003B0
+#define RIU_RWNXAGCCCACTRL_INDEX       0x000000EC
+#define RIU_RWNXAGCCCACTRL_RESET       0xA28010F1
+
+static inline void riu_rwnxagcccactrl_cca_main_ant_sel_setf(struct cl_hw *=
cl_hw, u8 ccamainantsel)
+{
+       ASSERT_ERR((((u32)ccamainantsel << 8) & ~((u32)0x00000700)) =3D=3D =
0);
+       cl_reg_write(cl_hw, RIU_RWNXAGCCCACTRL_ADDR,
+                    (cl_reg_read(cl_hw, RIU_RWNXAGCCCACTRL_ADDR) & ~((u32)=
0x00000700)) | ((u32)ccamainantsel << 8));
+}
+
+/*
+ * @brief RWNXAGCCCASTATE_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    28    CCAMDMSTFORCEEN           0
+ *    27:24 CCAMDMSTFORCE             0x0
+ *    23:12 RXSTATECCA20_SSEL         0x380
+ *    11:00 RXSTATECCA20_PSEL         0x3F8
+ * </pre>
+ */
+#define RIU_RWNXAGCCCASTATE_0_ADDR        (REG_RIU_BASE_ADDR + 0x000003B4)
+#define RIU_RWNXAGCCCASTATE_0_OFFSET      0x000003B4
+#define RIU_RWNXAGCCCASTATE_0_INDEX       0x000000ED
+#define RIU_RWNXAGCCCASTATE_0_RESET       0x003803F8
+
+static inline void riu_rwnxagcccastate_0_rxstatecca_20_psel_setf(struct cl=
_hw *cl_hw,
+                                                                u16 rxstat=
ecca20psel)
+{
+       ASSERT_ERR((((u32)rxstatecca20psel << 0) & ~((u32)0x00000FFF)) =3D=
=3D 0);
+       cl_reg_write(cl_hw, RIU_RWNXAGCCCASTATE_0_ADDR,
+                    (cl_reg_read(cl_hw, RIU_RWNXAGCCCASTATE_0_ADDR) & ~((u=
32)0x00000FFF)) | ((u32)rxstatecca20psel << 0));
+}
+
+/*
+ * @brief AGCINBDPOWNOISEPER_20_STAT_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOWNOISEDBMPER20_3    0x0
+ *    23:16 INBDPOWNOISEDBMPER20_2    0x0
+ *    15:08 INBDPOWNOISEDBMPER20_1    0x0
+ *    07:00 INBDPOWNOISEDBMPER20_0    0x0
+ * </pre>
+ */
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_ADDR        (REG_RIU_BASE_ADDR + =
0x00000478)
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_OFFSET      0x00000478
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_INDEX       0x0000011E
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_RESET       0x00000000
+
+static inline u32 riu_agcinbdpownoiseper_20_stat_0_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_AGCINBDPOWNOISEPER_20_STAT_0_ADDR);
+}
+
+/*
+ * @brief AGCINBDPOWNOISEPER_20_STAT_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOWNOISEDBMPER20_7    0x0
+ *    23:16 INBDPOWNOISEDBMPER20_6    0x0
+ *    15:08 INBDPOWNOISEDBMPER20_5    0x0
+ *    07:00 INBDPOWNOISEDBMPER20_4    0x0
+ * </pre>
+ */
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_ADDR        (REG_RIU_BASE_ADDR + =
0x0000047C)
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_OFFSET      0x0000047C
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_INDEX       0x0000011F
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_RESET       0x00000000
+
+static inline u32 riu_agcinbdpownoiseper_20_stat_1_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_AGCINBDPOWNOISEPER_20_STAT_1_ADDR);
+}
+
+/*
+ * @brief INBDPOWFORMAC_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOW20_PDBMA3_MAC      0x0
+ *    23:16 INBDPOW20_PDBMA2_MAC      0x0
+ *    15:08 INBDPOW20_PDBMA1_MAC      0x0
+ *    07:00 INBDPOW20_PDBMA0_MAC      0x0
+ * </pre>
+ */
+#define RIU_INBDPOWFORMAC_0_ADDR        (REG_RIU_BASE_ADDR + 0x00000480)
+#define RIU_INBDPOWFORMAC_0_OFFSET      0x00000480
+#define RIU_INBDPOWFORMAC_0_INDEX       0x00000120
+#define RIU_INBDPOWFORMAC_0_RESET       0x00000000
+
+static inline u32 riu_inbdpowformac_0_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_0_ADDR);
+}
+
+/*
+ * @brief INBDPOWFORMAC_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    15:08 INBDPOW20_PDBMA5_MAC      0x0
+ *    07:00 INBDPOW20_PDBMA4_MAC      0x0
+ * </pre>
+ */
+#define RIU_INBDPOWFORMAC_1_ADDR        (REG_RIU_BASE_ADDR + 0x00000484)
+#define RIU_INBDPOWFORMAC_1_OFFSET      0x00000484
+#define RIU_INBDPOWFORMAC_1_INDEX       0x00000121
+#define RIU_INBDPOWFORMAC_1_RESET       0x00000000
+
+static inline u32 riu_inbdpowformac_1_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_1_ADDR);
+}
+
+/*
+ * @brief INBDPOWFORMAC_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:16 INBDPOW80_SDBM_MAC        0x0
+ *    15:08 INBDPOW40_SDBM_MAC        0x0
+ *    07:00 INBDPOW20_SDBM_MAC        0x0
+ * </pre>
+ */
+#define RIU_INBDPOWFORMAC_2_ADDR        (REG_RIU_BASE_ADDR + 0x00000488)
+#define RIU_INBDPOWFORMAC_2_OFFSET      0x00000488
+#define RIU_INBDPOWFORMAC_2_INDEX       0x00000122
+#define RIU_INBDPOWFORMAC_2_RESET       0x00000000
+
+static inline u32 riu_inbdpowformac_2_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_2_ADDR);
+}
+
+/*
+ * @brief INBDPOWFORMAC_3 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOWPER20_PDBM_3_MAC   0x0
+ *    23:16 INBDPOWPER20_PDBM_2_MAC   0x0
+ *    15:08 INBDPOWPER20_PDBM_1_MAC   0x0
+ *    07:00 INBDPOWPER20_PDBM_0_MAC   0x0
+ * </pre>
+ */
+#define RIU_INBDPOWFORMAC_3_ADDR        (REG_RIU_BASE_ADDR + 0x0000048C)
+#define RIU_INBDPOWFORMAC_3_OFFSET      0x0000048C
+#define RIU_INBDPOWFORMAC_3_INDEX       0x00000123
+#define RIU_INBDPOWFORMAC_3_RESET       0x00000000
+
+static inline u32 riu_inbdpowformac_3_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_3_ADDR);
+}
+
+/*
+ * @brief INBDPOWFORMAC_4 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOWPER20_PDBM_7_MAC   0x0
+ *    23:16 INBDPOWPER20_PDBM_6_MAC   0x0
+ *    15:08 INBDPOWPER20_PDBM_5_MAC   0x0
+ *    07:00 INBDPOWPER20_PDBM_4_MAC   0x0
+ * </pre>
+ */
+#define RIU_INBDPOWFORMAC_4_ADDR        (REG_RIU_BASE_ADDR + 0x00000490)
+#define RIU_INBDPOWFORMAC_4_OFFSET      0x00000490
+#define RIU_INBDPOWFORMAC_4_INDEX       0x00000124
+#define RIU_INBDPOWFORMAC_4_RESET       0x00000000
+
+static inline u32 riu_inbdpowformac_4_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_4_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_GI_20_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_GI_20_S           0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_GI_20_S_ADDR        (REG_RIU_BASE_ADDR + 0x00000494)
+#define RIU_CCA_CNT_GI_20_S_OFFSET      0x00000494
+#define RIU_CCA_CNT_GI_20_S_INDEX       0x00000125
+#define RIU_CCA_CNT_GI_20_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_gi_20_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_GI_20_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_GI_40_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_GI_40_S           0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_GI_40_S_ADDR        (REG_RIU_BASE_ADDR + 0x00000498)
+#define RIU_CCA_CNT_GI_40_S_OFFSET      0x00000498
+#define RIU_CCA_CNT_GI_40_S_INDEX       0x00000126
+#define RIU_CCA_CNT_GI_40_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_gi_40_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_GI_40_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_GI_80_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_GI_80_S           0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_GI_80_S_ADDR        (REG_RIU_BASE_ADDR + 0x0000049C)
+#define RIU_CCA_CNT_GI_80_S_OFFSET      0x0000049C
+#define RIU_CCA_CNT_GI_80_S_INDEX       0x00000127
+#define RIU_CCA_CNT_GI_80_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_gi_80_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_GI_80_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_40_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_40_S   0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_40_S_ADDR        (REG_RIU_BASE_ADDR + 0x000=
004A0)
+#define RIU_CCA_CNT_ENERGY_THR_40_S_OFFSET      0x000004A0
+#define RIU_CCA_CNT_ENERGY_THR_40_S_INDEX       0x00000128
+#define RIU_CCA_CNT_ENERGY_THR_40_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_40_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_40_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_80_S register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_80_S   0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_80_S_ADDR        (REG_RIU_BASE_ADDR + 0x000=
004A4)
+#define RIU_CCA_CNT_ENERGY_THR_80_S_OFFSET      0x000004A4
+#define RIU_CCA_CNT_ENERGY_THR_80_S_INDEX       0x00000129
+#define RIU_CCA_CNT_ENERGY_THR_80_S_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_80_s_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_80_S_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_0 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_0_ADDR        (REG_RIU_BASE_ADDR + =
0x000004A8)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_0_OFFSET      0x000004A8
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_0_INDEX       0x0000012A
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_0_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_0_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_0_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_1 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_1_ADDR        (REG_RIU_BASE_ADDR + =
0x000004AC)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_1_OFFSET      0x000004AC
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_1_INDEX       0x0000012B
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_1_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_1_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_1_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_2 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_2_ADDR        (REG_RIU_BASE_ADDR + =
0x000004B0)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_2_OFFSET      0x000004B0
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_2_INDEX       0x0000012C
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_2_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_2_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_2_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_3 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_3 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_3_ADDR        (REG_RIU_BASE_ADDR + =
0x000004B4)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_3_OFFSET      0x000004B4
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_3_INDEX       0x0000012D
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_3_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_3_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_3_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_4 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_4 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_4_ADDR        (REG_RIU_BASE_ADDR + =
0x000004B8)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_4_OFFSET      0x000004B8
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_4_INDEX       0x0000012E
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_4_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_4_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_4_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_5 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_5 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_5_ADDR        (REG_RIU_BASE_ADDR + =
0x000004BC)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_5_OFFSET      0x000004BC
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_5_INDEX       0x0000012F
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_5_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_5_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_5_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_6 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_6 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_6_ADDR        (REG_RIU_BASE_ADDR + =
0x000004C0)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_6_OFFSET      0x000004C0
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_6_INDEX       0x00000130
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_6_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_6_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_6_ADDR);
+}
+
+/*
+ * @brief CCA_CNT_ENERGY_THR_20_BAND_7 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 CCA_CNT_ENERGY_THR_20_BAND_7 0x0
+ * </pre>
+ */
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_7_ADDR        (REG_RIU_BASE_ADDR + =
0x000004C4)
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_7_OFFSET      0x000004C4
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_7_INDEX       0x00000131
+#define RIU_CCA_CNT_ENERGY_THR_20_BAND_7_RESET       0x00000000
+
+static inline u32 riu_cca_cnt_energy_thr_20_band_7_get(struct cl_hw *cl_hw=
)
+{
+       return cl_reg_read(cl_hw, RIU_CCA_CNT_ENERGY_THR_20_BAND_7_ADDR);
+}
+
+/*
+ * @brief AGCADCPOWSTAT_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOW20_PDBM5           0x0
+ *    23:16 INBDPOW20_PDBM4           0x0
+ *    14:08 ADCPOWDBV5                0x0
+ *    06:00 ADCPOWDBV4                0x0
+ * </pre>
+ */
+#define RIU_AGCADCPOWSTAT_2_ADDR        (REG_RIU_BASE_ADDR + 0x00000670)
+#define RIU_AGCADCPOWSTAT_2_OFFSET      0x00000670
+#define RIU_AGCADCPOWSTAT_2_INDEX       0x0000019C
+#define RIU_AGCADCPOWSTAT_2_RESET       0x00000000
+
+static inline void riu_agcadcpowstat_2_unpack(struct cl_hw *cl_hw,
+                                             u8 *inbdpow20pdbm5, u8 *inbdp=
ow20pdbm4,
+                                             u8 *adcpowdbv5, u8 *adcpowdbv=
4)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, RIU_AGCADCPOWSTAT_2_ADDR);
+
+       *inbdpow20pdbm5 =3D (local_val & ((u32)0xFF000000)) >> 24;
+       *inbdpow20pdbm4 =3D (local_val & ((u32)0x00FF0000)) >> 16;
+       *adcpowdbv5 =3D (local_val & ((u32)0x00007F00)) >> 8;
+       *adcpowdbv4 =3D (local_val & ((u32)0x0000007F)) >> 0;
+}
+
+/*
+ * @brief AGCINBDPOW_20_PNOISESTAT_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOW20_PNOISEDBM5      0x0
+ *    23:16 INBDPOW20_PNOISEDBM4      0x0
+ *    15:08 ADCPOWDBM5                0x0
+ *    07:00 ADCPOWDBM4                0x0
+ * </pre>
+ */
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_ADDR        (REG_RIU_BASE_ADDR + 0x=
0000067C)
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_OFFSET      0x0000067C
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_INDEX       0x0000019F
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_RESET       0x00000000
+
+static inline u32 riu_agcinbdpow_20_pnoisestat_2_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, RIU_AGCINBDPOW_20_PNOISESTAT_2_ADDR);
+}
+
+#endif /*_REG_RIU_H_ */
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

