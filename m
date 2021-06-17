Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5879A3AB8BF
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhFQQKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:17 -0400
Received: from mail-eopbgr30064.outbound.protection.outlook.com ([40.107.3.64]:27105
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233781AbhFQQJJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkKvrtoxec4AmpHjqZekz+pNBugFZ7UGBIPNtdSDe2lMd3GHlpmJzkEHSqoSd2ilJdzrAGE86MAbUZq8uBAz7R9Rz+ZS9NaCtBCdEqJg/Y5NJZKmrasTiJ1k6p2BNicb9zVdEzhXFbriA4ymxSWCBm8v3mq26ErsPZXkNNOcoYEOJj8OZw+YqlhBj/F7R1ZxlJ3aqQkcPg3fRUXDGcWNAF0O0Baj91f+zBlm0KaXDv+2Dq5+HbVko4yb1x9H2F6spOtMNYWMnl705ob36X65NAxOYLt7ZGX8qz9/L90TcqkNjUIlPGa99ZoSDkJsvCUXOsk42v54+VFNNJgeq3wYuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbr3kmJlQjKgPwk6fxF7KA87mPVp/KgQZnqCXSAUIaQ=;
 b=KVTprEIrs8EPZm4qwMfkIE2uTwtpUWhLWb/P0jZinKHqSeoCWTN2NPjkJ+hjh8wn/L/lYEyEPnzWLsrO9OvePJae9rz/fwnaRbK3fecFIHdHXfBohfGm8FJ1g4PWFgcOpWCKUddc4QUZyWxZKtJ/uGaC//U3UAtek++EGo32+In66tgffWXSzGqnJrbN5cfMfa2JoCOj2OJBwUn3m9gTi/gQJkoW75d2scVMPzbsukfr3fHDJeTOl5n2s6sXMMQOsqs5LEhfzLTcDMDGSN+emC1jPZXlFw0rtWnw6lRZT2nH8h5PRsjR7AAG6dWV874VPp53bPyYgMDz1GkfqGkPfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbr3kmJlQjKgPwk6fxF7KA87mPVp/KgQZnqCXSAUIaQ=;
 b=UUIqfbgypA9PJkwIqHduDkwF+5iIFjIKF1Pv4hLyU+S5xR6oiw+50Fw/V3E6EatUUT1qvAGXQap313mpBKQKimYF959ofBazX7RB4sjPiLM7AQnXzjG0KzbbeunV8f/ItWM7kiC26ws85YWMidX2yOiqv26URCjaKzyCY4qwO3w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0465.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:43::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:28 +0000
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
Subject: [RFC v1 161/256] cl8k: add reg/reg_modem_gcu.h
Date:   Thu, 17 Jun 2021 16:00:48 +0000
Message-Id: <20210617160223.160998-162-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9463edfa-3b5c-4ba5-7fda-08d931a9bae1
X-MS-TrafficTypeDiagnostic: AM0P192MB0465:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04658121F863FF2ED06F7C57F60E9@AM0P192MB0465.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 80ljoMwjVIbHdVBo4uBR5xi9Gt+c3Mc3VT/j/SLDV+bcEvz9Wd4XT95dKaBpKTmsM49UmNKR7xxbIXJ7Llgtn3VFij3q+hZ7EjKa5utLlVfSjKdN/h/dVt5XACr+0mEh6zox3oVNVA9t/6MmqbgS5TXup/fC9J6Q6BMJHrMheBdAH9mbYGZ7zCRvbrbvjCj8ZjFlarhXJ/Cuz/lYgocA815CHwnprCfnhAtc+Oy6m0eby8CQksME7C5jdoE7GjKCza8eFmh6DAZWbkTEyi/YNNktKJni6u0A6rVfjsBGJwr5i+tgeYydoOQchb6b9WBuwPO3Q2Ultbt670E3VKIgLAvvdvrj0+VjNCTpbyuQTeasFjr6foT6Dx7auz6joA5MhPcx08JKgp7BG14npLZSLoN1VHcIhzv3Xyx2DtDrBpPITafX57rZGrSwG4gW06bYi6E2jFIAFTjJAzJYt+GGHolpYvrfjjbe1VO5mVVhr2EDidOGYiKYiZFHWhWOX0Pw2VWA4dOsqwdUIMJR/th0djCUoTVEWt7UhVRNzXHZTd807Ci8KmmGnJLN5H5QLDf2IDNTWCL9FZ3iPcQSn/4XzIlQR8ZISE+DfNKXKveR/nFlfxVq0OpeiyM9vvFyMjySNwtdZsFcrLopD9N9FfaFSj4B/HCzxhDlwnAbUjVKYyRaDbfF3NxqBnImO8dP4h5ZLkdl8t76V8aUd3TaMZ59pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(55236004)(6506007)(4326008)(5660300002)(54906003)(107886003)(8936002)(86362001)(36756003)(6486002)(38100700002)(38350700002)(26005)(8676002)(2906002)(6666004)(186003)(30864003)(83380400001)(1076003)(6512007)(2616005)(66946007)(66556008)(52116002)(66476007)(956004)(6916009)(498600001)(16526019)(9686003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04K6C37sIb4k0/n8V96IHR1uNmuHrNBwpeqPI2m6lNbxx4AnnZhiUjmfj3V3?=
 =?us-ascii?Q?EPma+ZYdMbRXN8hSxueTiKaSVH9xPXkyo0GkoXoUbdq60Rb+PTGrYLhusjN8?=
 =?us-ascii?Q?84JzueSHt2rwDIeui3CJJy0qCPjD/MsfOLwiaF15AzwmbDJI0sIInhmLJ8cD?=
 =?us-ascii?Q?JUCbtBtDWfIsu7EA9a0/Utrj8HGNuGXUZFLqonZConPLbrmPy1Oo2ru/FciV?=
 =?us-ascii?Q?QTwhU0fowU/8YFkB9/fuNpUrzpuud4h+vYciUsUDbmsBrkBeKTPkFM9CQyUL?=
 =?us-ascii?Q?gc01VxsxinpBNe6Iqbe0i8jBxmDT9bcoZv8rAf3NRhn8guAhAP3DGMHfYMDA?=
 =?us-ascii?Q?vb5ZYXmQycW2rD4nf034LOjg4k+T1oZBiOuvZAnX7fmL/DM+9D6dwai2Nzhf?=
 =?us-ascii?Q?KbxLV/dRvT7eWbeBa4mExuT5LAalWJ1OzGrwbs06tQ11oJivKLPWN5WHszZu?=
 =?us-ascii?Q?du/yhK0xNuqAUcol/SoRjMkgxSGKdFkrVqN3ISXUHusMMnAk8Th+akG76LNu?=
 =?us-ascii?Q?vFFXti/y+oPd3K6uri41xaGnqNSuw7PM67YLrtFs2cq22RLCqYZzqRX7vgfe?=
 =?us-ascii?Q?VQkHilu0uWxinHXIJnI0yERnakbX7206ccIaLfEX2KQpbH5J211CEDO6W6Eg?=
 =?us-ascii?Q?StIBLsTW5vLmN2jYaqTUJljR88+AaLpxa93sSVWfujFrOu67TxZxX88mpZtF?=
 =?us-ascii?Q?U/ro5FVbPjmX1i5E7TXsSwXlTW18C2lqVzXiDq7KD53j4jRprF07f4nUSoxE?=
 =?us-ascii?Q?1ZVeY2K1U8aU3bXynvJ09IPdE9vgGm4PQAFmNuBzMq5J7mcmZBW2F+OKwhBB?=
 =?us-ascii?Q?OmoeyQrzd56FDuc3R6rE2vzCGkTizQoZEVvqdJcQAauLVvk0xC8nApEzUXde?=
 =?us-ascii?Q?u7OBJZjvHVmL1r2sdiymuOyWgcG82ih191wLxiOXgdGu4YHfOKZy/v4ys1Dp?=
 =?us-ascii?Q?51QdVlLYv5pUlQ/UORPkwWKRsyX6cNinOzc/0myAPXEJZnBpR5vGVKW+gYk7?=
 =?us-ascii?Q?0iGpFpvvS6gt7utANgTZDGhu1OH5eMiN3kBWSz8xnEL3oDgKEgwnNnUZpPDs?=
 =?us-ascii?Q?Wf0s30Doq85RH+qYMPH4k+C7mRkW0rcD413kpFELv/sbPZ+7b+Hz1RY8Dv4B?=
 =?us-ascii?Q?bRN4x5IxeMeFCbd3Biv8B+8RWQn9nTu6pFyyx7YHIJEulAb9if/5rVgckRJz?=
 =?us-ascii?Q?C4iDUE9lY8dBcx92F3WKO3X8rcDuS+gYBlAy1YOwTCAKAh1SonqgoLeEaMAk?=
 =?us-ascii?Q?8T1ndH5hHxbxIScINocdHjIVACnrVL4IRapZ3iJ0CqiU34Iy6LiixQxAN21k?=
 =?us-ascii?Q?nc2bZqdfokEayUEARZggwsha?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9463edfa-3b5c-4ba5-7fda-08d931a9bae1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:30.6072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLKIyXbIML4jEuLHDTvq/XI/vLpJJh2CFl7wAjxJFDy5xjQhhRd6YCwzntcRLyQf3APaBuaqPoAuPoiQvajVEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0465
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/reg/reg_modem_gcu.h  | 628 ++++++++++++++++++
 1 file changed, 628 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_modem_gcu.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_modem_gcu.h b/drivers=
/net/wireless/celeno/cl8k/reg/reg_modem_gcu.h
new file mode 100644
index 000000000000..3073a364acec
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_modem_gcu.h
@@ -0,0 +1,628 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_REG_MODEM_GCU_H
+#define CL_REG_MODEM_GCU_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+
+#define REG_MODEM_GCU_BASE_ADDR 0x00480000
+
+/*
+ * @brief MPU register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   21    MPU_CLK_F                 0
+ *   20    MPU_REG_CLK_F             0
+ *   13    MPU_CLK_EN                0
+ *   12    MPU_REG_CLK_EN            0
+ *   01    MPU_RST_N                 0
+ *   00    MPU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_MPU_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000004)
+#define MODEM_GCU_MPU_OFFSET      0x00000004
+#define MODEM_GCU_MPU_INDEX       0x00000001
+#define MODEM_GCU_MPU_RESET       0x00000000
+
+static inline void modem_gcu_mpu_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_MPU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_MPU_CLK_F_BIT         ((u32)0x00200000)
+#define MODEM_GCU_MPU_CLK_F_POS         21
+#define MODEM_GCU_MPU_REG_CLK_F_BIT     ((u32)0x00100000)
+#define MODEM_GCU_MPU_REG_CLK_F_POS     20
+#define MODEM_GCU_MPU_CLK_EN_BIT        ((u32)0x00002000)
+#define MODEM_GCU_MPU_CLK_EN_POS        13
+#define MODEM_GCU_MPU_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_MPU_REG_CLK_EN_POS    12
+#define MODEM_GCU_MPU_RST_N_BIT         ((u32)0x00000002)
+#define MODEM_GCU_MPU_RST_N_POS         1
+#define MODEM_GCU_MPU_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_MPU_REG_RST_N_POS     0
+
+/*
+ * @brief BPU register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   24    BPUL_RX_CLK_F             0
+ *   23    BPU_CLK_F                 0
+ *   22    BPU_RX_CLK_F              0
+ *   21    BPU_TX_CLK_F              0
+ *   20    BPU_REG_CLK_F             0
+ *   16    BPUL_RX_CLK_EN            0
+ *   15    BPU_CLK_EN                0
+ *   14    BPU_RX_CLK_EN             0
+ *   13    BPU_TX_CLK_EN             0
+ *   12    BPU_REG_CLK_EN            0
+ *   03    BPU_RST_N                 0
+ *   02    BPU_RX_RST_N              0
+ *   01    BPU_TX_RST_N              0
+ *   00    BPU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_BPU_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000008)
+#define MODEM_GCU_BPU_OFFSET      0x00000008
+#define MODEM_GCU_BPU_INDEX       0x00000002
+#define MODEM_GCU_BPU_RESET       0x00000000
+
+static inline void modem_gcu_bpu_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_BPU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_BPU_BPUL_RX_CLK_F_BIT  ((u32)0x01000000)
+#define MODEM_GCU_BPU_BPUL_RX_CLK_F_POS  24
+#define MODEM_GCU_BPU_CLK_F_BIT          ((u32)0x00800000)
+#define MODEM_GCU_BPU_CLK_F_POS          23
+#define MODEM_GCU_BPU_RX_CLK_F_BIT       ((u32)0x00400000)
+#define MODEM_GCU_BPU_RX_CLK_F_POS       22
+#define MODEM_GCU_BPU_TX_CLK_F_BIT       ((u32)0x00200000)
+#define MODEM_GCU_BPU_TX_CLK_F_POS       21
+#define MODEM_GCU_BPU_REG_CLK_F_BIT      ((u32)0x00100000)
+#define MODEM_GCU_BPU_REG_CLK_F_POS      20
+#define MODEM_GCU_BPU_BPUL_RX_CLK_EN_BIT ((u32)0x00010000)
+#define MODEM_GCU_BPU_BPUL_RX_CLK_EN_POS 16
+#define MODEM_GCU_BPU_CLK_EN_BIT         ((u32)0x00008000)
+#define MODEM_GCU_BPU_CLK_EN_POS         15
+#define MODEM_GCU_BPU_RX_CLK_EN_BIT      ((u32)0x00004000)
+#define MODEM_GCU_BPU_RX_CLK_EN_POS      14
+#define MODEM_GCU_BPU_TX_CLK_EN_BIT      ((u32)0x00002000)
+#define MODEM_GCU_BPU_TX_CLK_EN_POS      13
+#define MODEM_GCU_BPU_REG_CLK_EN_BIT     ((u32)0x00001000)
+#define MODEM_GCU_BPU_REG_CLK_EN_POS     12
+#define MODEM_GCU_BPU_RST_N_BIT          ((u32)0x00000008)
+#define MODEM_GCU_BPU_RST_N_POS          3
+#define MODEM_GCU_BPU_RX_RST_N_BIT       ((u32)0x00000004)
+#define MODEM_GCU_BPU_RX_RST_N_POS       2
+#define MODEM_GCU_BPU_TX_RST_N_BIT       ((u32)0x00000002)
+#define MODEM_GCU_BPU_TX_RST_N_POS       1
+#define MODEM_GCU_BPU_REG_RST_N_BIT      ((u32)0x00000001)
+#define MODEM_GCU_BPU_REG_RST_N_POS      0
+/*
+ * @brief TFU register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   21    TFU_CLK_F                 0
+ *   20    TFU_REG_CLK_F             0
+ *   13    TFU_CLK_EN                0
+ *   12    TFU_REG_CLK_EN            0
+ *   01    TFU_RST_N                 0
+ *   00    TFU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_TFU_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000000C)
+#define MODEM_GCU_TFU_OFFSET      0x0000000C
+#define MODEM_GCU_TFU_INDEX       0x00000003
+#define MODEM_GCU_TFU_RESET       0x00000000
+
+static inline void modem_gcu_tfu_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_TFU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_TFU_CLK_F_BIT         ((u32)0x00200000)
+#define MODEM_GCU_TFU_CLK_F_POS         21
+#define MODEM_GCU_TFU_REG_CLK_F_BIT     ((u32)0x00100000)
+#define MODEM_GCU_TFU_REG_CLK_F_POS     20
+#define MODEM_GCU_TFU_CLK_EN_BIT        ((u32)0x00002000)
+#define MODEM_GCU_TFU_CLK_EN_POS        13
+#define MODEM_GCU_TFU_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_TFU_REG_CLK_EN_POS    12
+#define MODEM_GCU_TFU_RST_N_BIT         ((u32)0x00000002)
+#define MODEM_GCU_TFU_RST_N_POS         1
+#define MODEM_GCU_TFU_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_TFU_REG_RST_N_POS     0
+
+/*
+ * @brief SMU register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   21    SMU_CLK_F                 0
+ *   20    SMU_REG_CLK_F             0
+ *   13    SMU_CLK_EN                0
+ *   12    SMU_REG_CLK_EN            0
+ *   01    SMU_RST_N                 0
+ *   00    SMU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_SMU_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000010)
+#define MODEM_GCU_SMU_OFFSET      0x00000010
+#define MODEM_GCU_SMU_INDEX       0x00000004
+#define MODEM_GCU_SMU_RESET       0x00000000
+
+static inline void modem_gcu_smu_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_SMU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_SMU_CLK_F_BIT         ((u32)0x00200000)
+#define MODEM_GCU_SMU_CLK_F_POS         21
+#define MODEM_GCU_SMU_REG_CLK_F_BIT     ((u32)0x00100000)
+#define MODEM_GCU_SMU_REG_CLK_F_POS     20
+#define MODEM_GCU_SMU_CLK_EN_BIT        ((u32)0x00002000)
+#define MODEM_GCU_SMU_CLK_EN_POS        13
+#define MODEM_GCU_SMU_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_SMU_REG_CLK_EN_POS    12
+#define MODEM_GCU_SMU_RST_N_BIT         ((u32)0x00000002)
+#define MODEM_GCU_SMU_RST_N_POS         1
+#define MODEM_GCU_SMU_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_SMU_REG_RST_N_POS     0
+
+/*
+ * @brief MUX_FIC register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   20    MUX_FIC_CLK_F             0
+ *   12    MUX_FIC_CLK_EN            0
+ *   01    FIC_MUX_SOFT_RST_N        1
+ *   00    MUX_FIC_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_MUX_FIC_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000001=
4)
+#define MODEM_GCU_MUX_FIC_OFFSET      0x00000014
+#define MODEM_GCU_MUX_FIC_INDEX       0x00000005
+#define MODEM_GCU_MUX_FIC_RESET       0x00000002
+
+static inline void modem_gcu_mux_fic_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_MUX_FIC_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_MUX_FIC_CLK_F_BIT      ((u32)0x00100000)
+#define MODEM_GCU_MUX_FIC_CLK_F_POS      20
+#define MODEM_GCU_MUX_FIC_CLK_EN_BIT     ((u32)0x00001000)
+#define MODEM_GCU_MUX_FIC_CLK_EN_POS     12
+#define MODEM_GCU_MUX_FIC_SOFT_RST_N_BIT ((u32)0x00000002)
+#define MODEM_GCU_MUX_FIC_SOFT_RST_N_POS 1
+#define MODEM_GCU_MUX_FIC_RST_N_BIT      ((u32)0x00000001)
+#define MODEM_GCU_MUX_FIC_RST_N_POS      0
+
+/*
+ * @brief MUX_FIC_CONFIG register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31    FIC_ISOLATED              0
+ *   17    FIC_ISOLATE               0
+ *   16    DISABLE_FIC_MESS          0
+ *   15:08 MUX_FIC_CONFLICT_DELAY_WRITE 0x0
+ *   07:00 MUX_FIC_CONFLICT_DELAY_READ 0x0
+ * </pre>
+ */
+#define MODEM_GCU_MUX_FIC_CONFIG_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x=
0000001C)
+#define MODEM_GCU_MUX_FIC_CONFIG_OFFSET      0x0000001C
+#define MODEM_GCU_MUX_FIC_CONFIG_INDEX       0x00000007
+#define MODEM_GCU_MUX_FIC_CONFIG_RESET       0x00000000
+
+static inline void modem_gcu_mux_fic_config_set(struct cl_hw *cl_hw, u32 v=
alue)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR, value);
+}
+
+static inline u8 modem_gcu_mux_fic_config_fic_isolate_getf(struct cl_hw *c=
l_hw)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR)=
;
+
+       return ((local_val & ((u32)0x00020000)) >> 17);
+}
+
+static inline void modem_gcu_mux_fic_config_fic_isolate_setf(struct cl_hw =
*cl_hw, u8 ficisolate)
+{
+       ASSERT_ERR((((u32)ficisolate << 17) & ~((u32)0x00020000)) =3D=3D 0)=
;
+       cl_reg_write(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR,
+                    (cl_reg_read(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR) & ~=
((u32)0x00020000)) | ((u32)ficisolate << 17));
+}
+
+static inline u8 modem_gcu_mux_fic_config_fic_isolated_getf(struct cl_hw *=
cl_hw)
+{
+       u32 local_val =3D cl_reg_read(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR)=
;
+
+       return ((local_val & ((u32)0x80000000)) >> 31);
+}
+
+/*
+ * @brief RIU_RST register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   07    RIUFE_RST_N               0
+ *   06    RIUAGC_RST_N              0
+ *   05    RIU_MDM_B_RST_N           0
+ *   04    RIULB_RST_N               0
+ *   03    RIURC_RST_N               0
+ *   02    RIU_RADAR_RST_N           0
+ *   01    RIU_RST_N                 0
+ *   00    RIU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_RIU_RST_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000002=
0)
+#define MODEM_GCU_RIU_RST_OFFSET      0x00000020
+#define MODEM_GCU_RIU_RST_INDEX       0x00000008
+#define MODEM_GCU_RIU_RST_RESET       0x00000000
+
+static inline void modem_gcu_riu_rst_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_RIU_RST_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_RIU_FE_RST_N_BIT    ((u32)0x00000080)
+#define MODEM_GCU_RIU_FE_RST_N_POS    7
+#define MODEM_GCU_RIU_AGC_RST_N_BIT   ((u32)0x00000040)
+#define MODEM_GCU_RIU_AGC_RST_N_POS   6
+#define MODEM_GCU_RIU_MDM_B_RST_N_BIT ((u32)0x00000020)
+#define MODEM_GCU_RIU_MDM_B_RST_N_POS 5
+#define MODEM_GCU_RIU_LB_RST_N_BIT    ((u32)0x00000010)
+#define MODEM_GCU_RIU_LB_RST_N_POS    4
+#define MODEM_GCU_RIU_RC_RST_N_BIT    ((u32)0x00000008)
+#define MODEM_GCU_RIU_RC_RST_N_POS    3
+#define MODEM_GCU_RIU_RADAR_RST_N_BIT ((u32)0x00000004)
+#define MODEM_GCU_RIU_RADAR_RST_N_POS 2
+#define MODEM_GCU_RIU_RST_N_BIT       ((u32)0x00000002)
+#define MODEM_GCU_RIU_RST_N_POS       1
+#define MODEM_GCU_RIU_REG_RST_N_BIT   ((u32)0x00000001)
+#define MODEM_GCU_RIU_REG_RST_N_POS   0
+
+/*
+ * @brief RIU_CLK register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31    RIUADC_PWR_CLK_F          0
+ *   30    RIUFEA_5_CLK_F            0
+ *   29    RIUFEA_4_CLK_F            0
+ *   28    RIUFEA_3_CLK_F            0
+ *   27    RIUFEA_2_CLK_F            0
+ *   26    RIUFEA_1_CLK_F            0
+ *   25    RIUFEA_0_CLK_F            0
+ *   24    RIU_MDM_B_TX_CLK_F        0
+ *   23    RIU_MDM_B_RX_CLK_F        0
+ *   22    RIU_MDM_B_CLK_F           0
+ *   21    RIULB_CLK_F               0
+ *   20    RIURC_CLK_F               0
+ *   19    RIU_RADAR_CLK_F           0
+ *   18    RIUAGC_CLK_F              0
+ *   17    RIU_CLK_F                 0
+ *   16    RIU_REG_CLK_F             0
+ *   15    RIUADC_PWR_CLK_EN         0
+ *   14    RIUFEA_5_CLK_EN           0
+ *   13    RIUFEA_4_CLK_EN           0
+ *   12    RIUFEA_3_CLK_EN           0
+ *   11    RIUFEA_2_CLK_EN           0
+ *   10    RIUFEA_1_CLK_EN           0
+ *   09    RIUFEA_0_CLK_EN           0
+ *   08    RIU_MDM_B_TX_CLK_EN       0
+ *   07    RIU_MDM_B_RX_CLK_EN       0
+ *   06    RIU_MDM_B_CLK_EN          0
+ *   05    RIULB_CLK_EN              0
+ *   04    RIURCR_CLK_EN             0
+ *   03    RIU_RADAR_CLK_EN          0
+ *   02    RIUAGC_CLK_EN             0
+ *   01    RIU_CLK_EN                0
+ *   00    RIU_REG_CLK_EN            0
+ * </pre>
+ */
+#define MODEM_GCU_RIU_CLK_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000002=
4)
+#define MODEM_GCU_RIU_CLK_OFFSET      0x00000024
+#define MODEM_GCU_RIU_CLK_INDEX       0x00000009
+#define MODEM_GCU_RIU_CLK_RESET       0x00000000
+
+static inline void modem_gcu_riu_clk_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_ADDR, value);
+}
+
+/*
+ * @brief SPU register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   21    SPU_CLK_F                 0
+ *   20    SPU_REG_CLK_F             0
+ *   13    SPU_CLK_EN                0
+ *   12    SPU_REG_CLK_EN            0
+ *   01    SPU_RST_N                 0
+ *   00    SPU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_SPU_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000030)
+#define MODEM_GCU_SPU_OFFSET      0x00000030
+#define MODEM_GCU_SPU_INDEX       0x0000000C
+#define MODEM_GCU_SPU_RESET       0x00000000
+
+static inline void modem_gcu_spu_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_SPU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_SPU_CLK_F_BIT         ((u32)0x00200000)
+#define MODEM_GCU_SPU_CLK_F_POS         21
+#define MODEM_GCU_SPU_REG_CLK_F_BIT     ((u32)0x00100000)
+#define MODEM_GCU_SPU_REG_CLK_F_POS     20
+#define MODEM_GCU_SPU_CLK_EN_BIT        ((u32)0x00002000)
+#define MODEM_GCU_SPU_CLK_EN_POS        13
+#define MODEM_GCU_SPU_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_SPU_REG_CLK_EN_POS    12
+#define MODEM_GCU_SPU_RST_N_BIT         ((u32)0x00000002)
+#define MODEM_GCU_SPU_RST_N_POS         1
+#define MODEM_GCU_SPU_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_SPU_REG_RST_N_POS     0
+
+/*
+ * @brief LCU register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   14    LCU_HLF_CLK_EN            0
+ *   13    LCU_CLK_EN                0
+ *   12    LCU_REG_CLK_EN            0
+ *   02    LCU_HLF_RST_N             0
+ *   01    LCU_RST_N                 0
+ *   00    LCU_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_LCU_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000034)
+#define MODEM_GCU_LCU_OFFSET      0x00000034
+#define MODEM_GCU_LCU_INDEX       0x0000000D
+#define MODEM_GCU_LCU_RESET       0x00000000
+
+static inline void modem_gcu_lcu_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_LCU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_LCU_HLF_CLK_EN_BIT    ((u32)0x00004000)
+#define MODEM_GCU_LCU_HLF_CLK_EN_POS    14
+#define MODEM_GCU_LCU_CLK_EN_BIT        ((u32)0x00002000)
+#define MODEM_GCU_LCU_CLK_EN_POS        13
+#define MODEM_GCU_LCU_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_LCU_REG_CLK_EN_POS    12
+#define MODEM_GCU_LCU_HLF_RST_N_BIT     ((u32)0x00000004)
+#define MODEM_GCU_LCU_HLF_RST_N_POS     2
+#define MODEM_GCU_LCU_RST_N_BIT         ((u32)0x00000002)
+#define MODEM_GCU_LCU_RST_N_POS         1
+#define MODEM_GCU_LCU_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_LCU_REG_RST_N_POS     0
+
+/*
+ * @brief EPA register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   13    EPA_CLK_EN                0
+ *   12    EPA_REG_CLK_EN            0
+ *   01    EPA_RST_N                 0
+ *   00    EPA_REG_RST_N             0
+ * </pre>
+ */
+#define MODEM_GCU_EPA_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000038)
+#define MODEM_GCU_EPA_OFFSET      0x00000038
+#define MODEM_GCU_EPA_INDEX       0x0000000E
+#define MODEM_GCU_EPA_RESET       0x00000000
+
+static inline void modem_gcu_epa_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_EPA_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_EPA_CLK_EN_BIT        ((u32)0x00002000)
+#define MODEM_GCU_EPA_CLK_EN_POS        13
+#define MODEM_GCU_EPA_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_EPA_REG_CLK_EN_POS    12
+#define MODEM_GCU_EPA_RST_N_BIT         ((u32)0x00000002)
+#define MODEM_GCU_EPA_RST_N_POS         1
+#define MODEM_GCU_EPA_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_EPA_REG_RST_N_POS     0
+
+/*
+ * @brief BF register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   13    BF_CLK_EN                 0
+ *   12    BF_REG_CLK_EN             0
+ *   01    BF_RST_N                  0
+ *   00    BF_REG_RST_N              0
+ * </pre>
+ */
+#define MODEM_GCU_BF_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000003C)
+#define MODEM_GCU_BF_OFFSET      0x0000003C
+#define MODEM_GCU_BF_INDEX       0x0000000F
+#define MODEM_GCU_BF_RESET       0x00000000
+
+static inline void modem_gcu_bf_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_BF_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_BF_CLK_EN_BIT          ((u32)0x00002000)
+#define MODEM_GCU_BF_CLK_EN_POS          13
+#define MODEM_GCU_BF_REG_CLK_EN_BIT      ((u32)0x00001000)
+#define MODEM_GCU_BF_REG_CLK_EN_POS      12
+#define MODEM_GCU_BF_RST_N_BIT           ((u32)0x00000002)
+#define MODEM_GCU_BF_RST_N_POS           1
+#define MODEM_GCU_BF_REG_RST_N_BIT       ((u32)0x00000001)
+#define MODEM_GCU_BF_REG_RST_N_POS       0
+
+/*
+ * @brief RIU_CLK_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   17    RIUFE_EXT_CLK_F           0
+ *   16    RIUFRC_CLK_F              0
+ *   01    RIUFE_EXT_CLK_EN          0
+ *   00    RIUFRC_CLK_EN             0
+ * </pre>
+ */
+#define MODEM_GCU_RIU_CLK_1_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000=
124)
+#define MODEM_GCU_RIU_CLK_1_OFFSET      0x00000124
+#define MODEM_GCU_RIU_CLK_1_INDEX       0x00000049
+#define MODEM_GCU_RIU_CLK_1_RESET       0x00000000
+
+static inline void modem_gcu_riu_clk_1_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_1_ADDR, value);
+}
+
+/*
+ * @brief CEVA_CTRL register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   16    MCCI_ADDR_BASE            0
+ *   14    VINTC                     0
+ *   12    NMI                       0
+ *   10:09 EXT_VOM                   0x0
+ *   08    EXT_PV                    0
+ *   07:06 UIA                       0x0
+ *   05    STOP_SD                   0
+ *   04    MON_STAT                  0
+ *   02    EXTERNAL_WAIT             1
+ *   00    BOOT                      0
+ * </pre>
+ */
+#define MODEM_GCU_CEVA_CTRL_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00001=
004)
+#define MODEM_GCU_CEVA_CTRL_OFFSET      0x00001004
+#define MODEM_GCU_CEVA_CTRL_INDEX       0x00000401
+#define MODEM_GCU_CEVA_CTRL_RESET       0x00000004
+
+static inline u32 modem_gcu_ceva_ctrl_get(struct cl_hw *cl_hw)
+{
+       return cl_reg_read(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR);
+}
+
+static inline void modem_gcu_ceva_ctrl_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_CEVA_CTRL_MCCI_ADDR_BASE_BIT ((u32)0x00010000)
+#define MODEM_GCU_CEVA_CTRL_MCCI_ADDR_BASE_POS 16
+#define MODEM_GCU_CEVA_CTRL_VINTC_BIT          ((u32)0x00004000)
+#define MODEM_GCU_CEVA_CTRL_VINTC_POS          14
+#define MODEM_GCU_CEVA_CTRL_NMI_BIT            ((u32)0x00001000)
+#define MODEM_GCU_CEVA_CTRL_NMI_POS            12
+#define MODEM_GCU_CEVA_CTRL_EXT_VOM_MASK       ((u32)0x00000600)
+#define MODEM_GCU_CEVA_CTRL_EXT_VOM_LSB        9
+#define MODEM_GCU_CEVA_CTRL_EXT_VOM_WIDTH      ((u32)0x00000002)
+#define MODEM_GCU_CEVA_CTRL_EXT_PV_BIT         ((u32)0x00000100)
+#define MODEM_GCU_CEVA_CTRL_EXT_PV_POS         8
+#define MODEM_GCU_CEVA_CTRL_UIA_MASK           ((u32)0x000000C0)
+#define MODEM_GCU_CEVA_CTRL_UIA_LSB            6
+#define MODEM_GCU_CEVA_CTRL_UIA_WIDTH          ((u32)0x00000002)
+#define MODEM_GCU_CEVA_CTRL_STOP_SD_BIT        ((u32)0x00000020)
+#define MODEM_GCU_CEVA_CTRL_STOP_SD_POS        5
+#define MODEM_GCU_CEVA_CTRL_MON_STAT_BIT       ((u32)0x00000010)
+#define MODEM_GCU_CEVA_CTRL_MON_STAT_POS       4
+#define MODEM_GCU_CEVA_CTRL_EXTERNAL_WAIT_BIT  ((u32)0x00000004)
+#define MODEM_GCU_CEVA_CTRL_EXTERNAL_WAIT_POS  2
+#define MODEM_GCU_CEVA_CTRL_BOOT_BIT           ((u32)0x00000001)
+#define MODEM_GCU_CEVA_CTRL_BOOT_POS           0
+
+static inline void modem_gcu_ceva_ctrl_external_wait_setf(struct cl_hw *cl=
_hw, u8 externalwait)
+{
+       ASSERT_ERR((((u32)externalwait << 2) & ~((u32)0x00000004)) =3D=3D 0=
);
+       cl_reg_write(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR,
+                    (cl_reg_read(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR) & ~((u32=
)0x00000004)) | ((u32)externalwait << 2));
+}
+
+static inline void modem_gcu_ceva_ctrl_boot_setf(struct cl_hw *cl_hw, u8 b=
oot)
+{
+       ASSERT_ERR((((u32)boot << 0) & ~((u32)0x00000001)) =3D=3D 0);
+       cl_reg_write(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR,
+                    (cl_reg_read(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR) & ~((u32=
)0x00000001)) | ((u32)boot << 0));
+}
+
+/*
+ * @brief CEVA_VEC register definition
+ * Ceva Vector register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   31:00 VECTOR                    0x0
+ * </pre>
+ */
+#define MODEM_GCU_CEVA_VEC_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x000010=
08)
+#define MODEM_GCU_CEVA_VEC_OFFSET      0x00001008
+#define MODEM_GCU_CEVA_VEC_INDEX       0x00000402
+#define MODEM_GCU_CEVA_VEC_RESET       0x00000000
+
+static inline void modem_gcu_ceva_vec_set(struct cl_hw *cl_hw, u32 value)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_CEVA_VEC_ADDR, value);
+}
+
+/*
+ * @brief RIU_CLK_BW register definition
+ * RIU clocks BW. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   13    agc_clk_bw                0
+ *   12:10 lb_mem_clk_bw             0x2
+ *   09:08 agc_mem_clk_bw            0x1
+ *   07:06 riu_afe_clk_bw            0x2
+ *   05:04 phyfesync_bw              0x2
+ *   03:02 adcpowclk_bw              0x2
+ *   01:00 riulbgclk_bw              0x2
+ * </pre>
+ */
+#define MODEM_GCU_RIU_CLK_BW_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000=
1240)
+#define MODEM_GCU_RIU_CLK_BW_OFFSET      0x00001240
+#define MODEM_GCU_RIU_CLK_BW_INDEX       0x00000490
+#define MODEM_GCU_RIU_CLK_BW_RESET       0x000009AA
+
+static inline void modem_gcu_riu_clk_bw_set(struct cl_hw *cl_hw, u32 value=
)
+{
+       cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_BW_ADDR, value);
+}
+
+static inline void modem_gcu_riu_clk_bw_agc_mem_clk_bw_setf(struct cl_hw *=
cl_hw, u8 agcmemclkbw)
+{
+       ASSERT_ERR((((u32)agcmemclkbw << 8) & ~((u32)0x00000300)) =3D=3D 0)=
;
+       cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_BW_ADDR,
+                    (cl_reg_read(cl_hw, MODEM_GCU_RIU_CLK_BW_ADDR) & ~((u3=
2)0x00000300)) | ((u32)agcmemclkbw << 8));
+}
+
+#endif /* CL_REG_MODEM_GCU_H */
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

