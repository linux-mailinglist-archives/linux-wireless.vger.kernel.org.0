Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F94532953
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236878AbiEXLkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236864AbiEXLjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3750440
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cea0pbHX91opWFBxEPtDcLISIu7fYaix9TENfi4sVHSSwBp4ydyEAPUXTFkMVGsx1MmK62paPFJm1m8TvSHuyYhdLJIngPCbl/n92pL/DS+0QRxFbg7X7a7qv9MCD2UT8l/c69QDrp/ZkduFNz1PtoHcNQbMrWrCYrDMO7qUIjPPtmn0rc3QaibGaFp/L6BNXXbTVJCISgufwLJN1TByW4R34LXh9BlmwZB9RGBYNn9DpkSgr00rKaPJHf33cNJEFD97UTX3FG9fzu9tyo2A8lxlQzrpCoCRr1SBLBVv7vLJiL7nYKp8FKumPLH5Y7+jAuDn/0KEGKWqDvvydplakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q7JCX6RqfDahvqWt6iGrau9gXDxsxbj0qFlt0nzXWE=;
 b=kgbPdbeMAQij7eC/r8nHo4kZnTj/pH4FB59EjYLi0VupAvlt55sDdiB7NpGbAAXJYHS+1nsUG9UPb7TMpzC9P0thHDfQ5suBhieymGECzsXsqxV6cvUWDhgS0HkYg9mb6txSWAAP/YBSfVunp5/fW57lGEVrfGG23P1ICTjzmbp+HqzxK78PBIMQ2gRR4m7uFIzxEFLyKmPkNT4xFjGKlvi8c+sJkftuXYmKYf8KAXR0tXSkC8Qb8N+YP6w3Q8Gi9rs9Gvvm1W65eyTYQYvtyCgz6b113yYKgMskfYj9VGo69TtFT81yFKl3yoFTJ4MsmHhNyz7yqxjRLIWxzkTO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q7JCX6RqfDahvqWt6iGrau9gXDxsxbj0qFlt0nzXWE=;
 b=ZYX5H8wZl7tZEB6b00r+EDie7F5m1M1hxbx8DYKmRhUgvFAgAzaHAlDmyQOloWMvPwvyILTQFA7B+bVnDlv4NhL2LRDGgdY/ifJEFyJPC6xGNMYvJbxEepTAD+vzTg/v9OKWJBTNWnCf94v9DtHqVJkHFJqHitTDLrDyaCuEuUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:24 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:24 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 64/96] cl8k: add reg/reg_access.h
Date:   Tue, 24 May 2022 14:34:30 +0300
Message-Id: <20220524113502.1094459-65-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 921d2494-d491-4037-9050-08da3d79f2f0
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB091528B6B2B81D7E5E2EF592F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDkXVEsrinw4+ZJnxW6g36nJgACdyPiLWHlnKHhuRWyUxaWpgg03WYYdD0LtU8KIDkxArYJM8Bhj21I52wbWvdQ/H8pXTP1gptM/yl9OCARqBbDW08p43JH4szGH58JER4UnU25VbpCyf9KYZbBoQtctAXESQmgj7T8V952f1X8MH8CCN35rD5s0ep2YqzzfZK01c6z/9vtqvOm+46vNq8x8cJnYjNMVwGMIUrmMOCVx2TIyYsUWy4uVMoMDOHKrFCWET78J1NBQy0KtBF4ePkr9FB51jo5EWNNVyiOmJqXCjsyCcwBYbmZiPSjR+HIpoQsSFUsoMVWr9o2hDTIUglCuZ0KmHXbYfuwEdjfvolkGt6zsMrkhqO/EoQfZNgW2c9wHBJAdb7azgyU/2p7Ro2uEBcfGJbr08lBKrL9WHYhaILjLyKiesHmre7hKgcgypFOGXEm7LGK5sCw6XP3J9wJ2X6fKwgu0D+ZNzPf//D6yhAU/07I8ZiiY8lGMbqpN3/RKRSOxbZ8dn+4AsvIQtDN1mSMfmDcYg2kLreUCCiHo9y4lCT9i21zrVuGWkyUL0CRlmQahiJ4iPLfDER48izwZdgHt4luoYYkqQ+5EKsc4xX2TKrZ2tYPTselaW1ETGgEUBr4G+G0kqJGYbE2ZJX2nqnC8sHOX/66CCyj20y9lR8Udsrrb4PZ9F7r9doziFFk3x7czUlZKQG9aHwamc3/uKoRoqVj4p/Nqvtqs2w8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1KTfuCkzapNDPJq+tNlOmW4LwhkFS5pEjzKoXksX+PtqMq68ATN5pwajPHEJ?=
 =?us-ascii?Q?COo340d/lZL6f3+UDnPZY7Gyqv4Wn7Gtt70u/Ea7QyIJuf0W72Ly4qjZGthi?=
 =?us-ascii?Q?6TtxODpmcYO55RWZtx4S8Wx4+LP/J+4/FcVz0dU2dHxxPKFPTI0KTV6MnICa?=
 =?us-ascii?Q?OpRCZbPeZxYjP9BQphEUFdZ1EZH1pykrHJwMJhhfCwo8tu3lUF78Sn5RycxU?=
 =?us-ascii?Q?tH5z8wxbueIuklPyu0hAGUuUccRlZkiZHEN+z1ZL7smzyVg5zzrPtHK90q5R?=
 =?us-ascii?Q?saEbpwzvXZ0Sd/rsXQIt1BJZRmefEjRAwQSuWfON7h7Mipl1G/7Wp59r7cEq?=
 =?us-ascii?Q?iOWver6d/GKXuViXiQP+SJhZvg6zGEWK2dkomD//8VyeNsKnpcxnXJ43VGhM?=
 =?us-ascii?Q?ZkCsNfJJsx50AD3lSHKv5tlm41a3VdAbTCLRqS/4O5RVqQ/ogUqPzoSFDkB5?=
 =?us-ascii?Q?PyUIEWINvIIHcGKVxcnCzMYbXhpFvRwptMkwNVw27EQiETeGhR6AdAuBrnhH?=
 =?us-ascii?Q?jYDzCEtTHz3R4PeMhgwGcf0iZri9iYwTwGnt47a2xhgpx5EGiGcqKLfU5nYx?=
 =?us-ascii?Q?aXzRsRJ10yUyaiY/XpSqb73ZaXSqTrwtA1E10GICqOm7qKinQcQVdUrQl2fJ?=
 =?us-ascii?Q?aMiorDnT4TrLu9MLz2Z8S1EGHSRmByswu27jRdX8WbUEoWdx/4mhEC++cc7L?=
 =?us-ascii?Q?y3yvUHHQsfBFhitBqA8ZUQOiPgeRxIjjRAHxPPBPmOq6OSwyA/S2pgkNZWs8?=
 =?us-ascii?Q?8M6QPKUIbPY+ea4VtkdJs28j6atbnday2SWtsagqbmLbTEhxEU9bddv5qmYY?=
 =?us-ascii?Q?BXKv2G7Hb1RM/omqCCMYzpvQg8sTJqZBCLAoDwpcA+y9hr0M79e4GwK9BlaX?=
 =?us-ascii?Q?4X43ZAaH4BRioUJXAlPQYuLA34TZ5NjiAv4AtBzRHle/tKxYp+/2OtlawMOI?=
 =?us-ascii?Q?Slx3sQ24SSLnO1pqIXTuJEUjwccHlbWqA9TNfar7XkzaIZpASYcYqi5ennLK?=
 =?us-ascii?Q?pvI3R+Bc6K0fgGdX8vwy+hOeO0N1+e60jrOQvDOcoEIKh0oy0yEJ3U/296U2?=
 =?us-ascii?Q?Q1S4f2sdTUVUqfmU926INw2SskQUjjf6fHmYsJCsJRXYPTbOmzePPbwIRUCK?=
 =?us-ascii?Q?IaYK8QYk6kB5DfIqk2fyT/HBKm0CTsxG8r41x35jGhtrbRMAbpeakXsP+Z/A?=
 =?us-ascii?Q?IgBGgMn7C+4VdWfb6IMh8+zoQM9G8sm3VB431OrFLJpXdczTNouj6H2AMGR9?=
 =?us-ascii?Q?v8XuEqsPvmKiiazVIjwWi4voqCE6Cjh7HYU0CK4V2hC0gcDNnMtqj6oadUW2?=
 =?us-ascii?Q?RbtOqexHlnZyTqw0Zvp8DFxZzRnehLQrLoe15zTkDlGwvFKgUBPhb7MQfZnr?=
 =?us-ascii?Q?uuGn9QsXaSRDPDjeRSABpEZ+oSnAqTconMahQ1TfwXVjrIjYWQYBfkKHjJT2?=
 =?us-ascii?Q?QE7iu1tLLy+4rw/X75jP3hBL1bRfbdOaHSZYnYBAFvl4R1cDXm3dxdpvu7Rw?=
 =?us-ascii?Q?K85h7WjK0u5JLGEA9BPhPvsw9g/VLpDsuAXZHD2ignJvXVnQ8ME2gFMl3XMF?=
 =?us-ascii?Q?zMX0kVd6B9j12ncpo7n3z9UGkOIfAcNgZHdetp7PhgQv20wmwK8QVda5bIRL?=
 =?us-ascii?Q?Eqw+CSJDNuZVZSw5cNnD2xlbxEAIutCgW/SxD8a6p84rytLT37Xl8wjCg4Ev?=
 =?us-ascii?Q?zrulccSuxENNCmFPqQ6F1r1+3we1gCkU15l17AZA2epQ5fu8kqyQmVRQl8ap?=
 =?us-ascii?Q?krlr4aFseIjTHsJiKXwfqgB8EdxkGGM=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 921d2494-d491-4037-9050-08da3d79f2f0
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:40.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dp2uMt65eg8rpIkeSK/jidCbV+V3P5v/Nyaf8fL+l2j4xL/ZcL7kBoepKloFjMgrWTkRrEStHRJV+ZoVO9YXRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0915
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/reg/reg_access.h | 199 ++++++++++++++++++
 1 file changed, 199 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_access.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_access.h b/drivers/net/wireless/celeno/cl8k/reg/reg_access.h
new file mode 100644
index 000000000000..c9d00f7553ea
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_access.h
@@ -0,0 +1,199 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_REG_ACCESS_H
+#define CL_REG_ACCESS_H
+
+#include "hw.h"
+#include "chip.h"
+
+#define hwreg_pr(...) \
+	do { \
+		if (cl_hw->reg_dbg) \
+			cl_dbg_verbose(__VA_ARGS__); \
+	} while (0)
+
+#define chipreg_pr(...) \
+	do { \
+		if (chip->reg_dbg) \
+			cl_dbg_chip_verbose(__VA_ARGS__); \
+	} while (0)
+
+#define XTENSA_PIF_BASE_ADDR     0x60000000
+
+/*
+ * SHARED_RAM Address.
+ * Actually the PCI BAR4 window will be configured such as SHARED RAM
+ * is accessed with offset 0 (within the AHB Bridge main window)
+ */
+#define SHARED_RAM_START_ADDR    0x00000000
+#define REG_MAC_HW_SMAC_OFFSET   0x80000
+#define REG_PHY_LMAC_OFFSET      0x000000
+#define REG_PHY_SMAC_OFFSET      0x100000
+#define REG_MACDSP_API_BASE_ADDR 0x00400000
+#define REG_MAC_HW_BASE_ADDR     0x00600000
+#define REG_RIU_BASE_ADDR        0x00486000
+#define REG_RICU_BASE_ADDR       0x004B4000
+#define APB_REGS_BASE_ADDR       0x007C0000
+#define I2C_REG_BASE_ADDR        (APB_REGS_BASE_ADDR + 0x3000)
+
+/* MACSYS_GCU_XT_CONTROL fields */
+#define SMAC_DEBUG_ENABLE      BIT(21)
+#define SMAC_BREAKPOINT        BIT(20)
+#define SMAC_OCD_HALT_ON_RESET BIT(19)
+#define SMAC_RUN_STALL         BIT(18)
+#define SMAC_DRESET            BIT(17)
+#define SMAC_BRESET            BIT(16)
+#define UMAC_DEBUG_ENABLE      BIT(13)
+#define UMAC_BREAKPOINT        BIT(11)
+#define UMAC_OCD_HALT_ON_RESET BIT(11)
+#define UMAC_RUN_STALL         BIT(10)
+#define UMAC_DRESET            BIT(9)
+#define UMAC_BRESET            BIT(8)
+#define LMAC_DEBUG_ENABLE      BIT(5)
+#define LMAC_BREAKPOINT        BIT(4)
+#define LMAC_OCD_HALT_ON_RESET BIT(3)
+#define LMAC_RUN_STALL         BIT(2)
+#define LMAC_DRESET            BIT(1)
+#define LMAC_BRESET            BIT(0)
+
+#define XMAC_BRESET \
+	(LMAC_BRESET | SMAC_BRESET | UMAC_BRESET)
+#define XMAC_DRESET \
+	(LMAC_DRESET | SMAC_DRESET | UMAC_DRESET)
+#define XMAC_RUN_STALL \
+	(LMAC_RUN_STALL | SMAC_RUN_STALL | UMAC_RUN_STALL)
+#define XMAC_OCD_HALT_ON_RESET \
+	(LMAC_OCD_HALT_ON_RESET | SMAC_OCD_HALT_ON_RESET | UMAC_OCD_HALT_ON_RESET)
+#define XMAC_DEBUG_ENABLE \
+	(LMAC_DEBUG_ENABLE | SMAC_DEBUG_ENABLE | UMAC_DEBUG_ENABLE)
+
+static inline u32 get_actual_reg(struct cl_hw *cl_hw, u32 reg)
+{
+	if (!cl_hw)
+		return -1;
+
+	if ((reg & 0x00ff0000) == REG_MAC_HW_BASE_ADDR)
+		return cl_hw->mac_hw_regs_offset + reg;
+
+	if ((reg & 0x00f00000) == REG_MACDSP_API_BASE_ADDR) {
+		if (cl_hw->chip->conf->ci_phy_dev == PHY_DEV_DUMMY)
+			return -1;
+		return cl_hw->phy_regs_offset + reg;
+	}
+
+	return reg;
+}
+
+static inline bool cl_reg_is_phy_tcvX(u32 phy_reg, u32 reg_offset)
+{
+	return (phy_reg & 0xf00000) == (REG_MACDSP_API_BASE_ADDR + reg_offset);
+}
+
+static inline bool cl_reg_is_phy_tcv0(u32 phy_reg)
+{
+	return cl_reg_is_phy_tcvX(phy_reg, REG_PHY_LMAC_OFFSET);
+}
+
+static inline bool cl_reg_is_phy_tcv1(u32 phy_reg)
+{
+	return cl_reg_is_phy_tcvX(phy_reg, REG_PHY_SMAC_OFFSET);
+}
+
+static inline u32 cl_reg_read(struct cl_hw *cl_hw, u32 reg)
+{
+	u32 actual_reg = get_actual_reg(cl_hw, reg);
+	u32 val = 0;
+
+	if (actual_reg == (u32)(-1))
+		return 0xff;
+
+	val = ioread32(cl_hw->chip->pci_bar0_virt_addr + actual_reg);
+	hwreg_pr(cl_hw, "reg=0x%x, val=0x%x\n", actual_reg, val);
+	return val;
+}
+
+static inline void cl_reg_write_direct(struct cl_hw *cl_hw, u32 reg, u32 val)
+{
+	u32 actual_reg = get_actual_reg(cl_hw, reg);
+
+	if (actual_reg == (u32)(-1))
+		return;
+
+	hwreg_pr(cl_hw, "reg=0x%x, val=0x%x\n", actual_reg, val);
+	iowrite32(val, cl_hw->chip->pci_bar0_virt_addr + actual_reg);
+}
+
+#define BASE_ADDR(reg) ((ptrdiff_t)(reg) & 0x00fff000)
+
+static inline bool should_send_msg(struct cl_hw *cl_hw, u32 reg)
+{
+	/*
+	 * Check in what cases we should send a message to the firmware,
+	 * and in what cases we should write directly.
+	 */
+	if (!cl_hw->fw_active)
+		return false;
+
+	return ((BASE_ADDR(reg) == REG_RIU_BASE_ADDR) ||
+		(BASE_ADDR(reg) == REG_MAC_HW_BASE_ADDR));
+}
+
+static inline int cl_reg_write(struct cl_hw *cl_hw, u32 reg, u32 val)
+{
+	u32 actual_reg = get_actual_reg(cl_hw, reg);
+	int ret = 0;
+
+	if (actual_reg == (u32)(-1))
+		return -1;
+
+	if (should_send_msg(cl_hw, reg)) {
+		hwreg_pr(cl_hw, "calling cl_msg_tx_reg_write: reg=0x%x, val=0x%x\n",
+			 actual_reg, val);
+		cl_msg_tx_reg_write(cl_hw, (XTENSA_PIF_BASE_ADDR + actual_reg), val, U32_MAX);
+	} else {
+		hwreg_pr(cl_hw, "reg=0x%x, val=0x%x\n", actual_reg, val);
+		iowrite32(val, cl_hw->chip->pci_bar0_virt_addr + actual_reg);
+	}
+
+	return ret;
+}
+
+static inline int cl_reg_write_mask(struct cl_hw *cl_hw, u32 reg, u32 val, u32 mask)
+{
+	u32 actual_reg = get_actual_reg(cl_hw, reg);
+	int ret = 0;
+
+	if (actual_reg == (u32)(-1))
+		return -1;
+
+	if (should_send_msg(cl_hw, reg)) {
+		hwreg_pr(cl_hw, "calling cl_msg_tx_reg_write: reg=0x%x, val=0x%x, mask=0x%x\n",
+			 actual_reg, val, mask);
+		cl_msg_tx_reg_write(cl_hw, (XTENSA_PIF_BASE_ADDR + actual_reg), val, mask);
+	} else {
+		u32 reg_rd = ioread32(cl_hw->chip->pci_bar0_virt_addr + actual_reg);
+		u32 val_write = ((reg_rd & ~mask) | (val & mask));
+
+		hwreg_pr(cl_hw, "reg=0x%x, mask=0x%x, val=0x%x\n", actual_reg, mask, val_write);
+		iowrite32(val_write, cl_hw->chip->pci_bar0_virt_addr + actual_reg);
+	}
+
+	return ret;
+}
+
+static inline void cl_reg_write_chip(struct cl_chip *chip, u32 reg, u32 val)
+{
+	chipreg_pr(chip, "reg=0x%x, val=0x%x\n", reg, val);
+	iowrite32(val, chip->pci_bar0_virt_addr + reg);
+}
+
+static inline u32 cl_reg_read_chip(struct cl_chip *chip, u32 reg)
+{
+	u32 val = ioread32(chip->pci_bar0_virt_addr + reg);
+
+	chipreg_pr(chip, "reg=0x%x, val=0x%x\n", reg, val);
+	return val;
+}
+
+#endif /* CL_REG_ACCESS_H */
-- 
2.36.1

