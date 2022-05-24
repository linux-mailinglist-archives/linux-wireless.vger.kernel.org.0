Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9A153292C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236809AbiEXLie (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiEXLid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:33 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950AA4AE15
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zj4GM5jIa55p6Dh6+hWfpST8Sz2/8qpxlYdd+bkxzeypxoWyNbMPvXJGTkV3wh0nU/ePCRtEaASGz6YxUUYbvDkupGdZnV7vMlItZWdPBWNtk/5WEKeBII81QPh9PzAJ2Rfzrs7iJHBSYNxSaQQ96vI89vTW5VFQ+TbvB/274kMk3maizkzmjPTCTnDuuMQLPtbeC1koSpBVMJtxDt8V5TMy3LtjS+zda+0aWPLhQMfidt/ftUGejiefk2ZsfPvWjuP/fcOmLTbCULeGrwJq40W6W8CTFnZ9NrvTR/gHV0fcb9m2CJlvq5K7a291QtWCF+MxLD1QK9Vu/oLFQp7piA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7owtQBxsysZXPucQNcHSWkqO6F18itCYViwPFZa3PI=;
 b=UcRwfwRxy4GM35f1KWVLBga+FiwQub+ZhiAB+SGMd+1QE6S0LxhbT54PcpeYsclC1xeso9avTXO5qfHZ8szD29GTOgnXKNq02POexxZ5de+o+K+NnfksLjfFP6MX0NPJzzXxgDmk0o1+QF0JZge92QqtVV5vOCHDWV0fA+TCRifOTctj0w9ei+SCDFKyUcXvZKAH58HfAIdV9whR3mCVqPbl1FMOoHAQnFvkA8Vb+xpXliNbT7Wz68ZjQokxDyM/9T6mxeGdRMMltYVo0A0owR6HuhAC/g6L1thQAEHp4Zu0qLSGUfb/3gLNvgDONsqAeZxSZqRPQW73cUSBZJu2fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7owtQBxsysZXPucQNcHSWkqO6F18itCYViwPFZa3PI=;
 b=JfBDoqajLmhydrOp9i1YKw9IV/HpovhiyueB0xpjD6PT+IjWU3ESQytyVvJ1ql2YI9AnLU9DPZMcTCGyYIxC4bgwvCDf3xv0rGLnOtZaIE8VokfuFeEXW94PDIH1gXyMekYhyvs+bMz6MaY8XzhwfBUo7SHgzrDRtq4gUuvAE3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:59 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:59 +0000
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
Subject: [RFC v2 22/96] cl8k: add dsp.c
Date:   Tue, 24 May 2022 14:33:48 +0300
Message-Id: <20220524113502.1094459-23-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9e154caa-1dc3-40a3-a216-08da3d79da86
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB046987A7588D4E70EC636FE6F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 12eVieqGCSPQAboHsf/D55dBoWhbkJRwyu5GoQymhFFJz5jhwIIXAXFEq3pgZ5NFpxH6UsoBvihZq7l/bqNS101UjrKm25hyYpkGvShh67YtuZeVRXWQiop8Aq8fR+6DnpK30tGbVzIGhmmSHIG0ujHZ8g0ZJbyTCfbFCPRsWkRJsTkOVj2lIQLVUbhevoKja8Te6J9wtv1N1OGJaVSp221CawnliP3ZwNCPQ9fusD7K5rm81pGWEFtAxVwEdKtFYlDZWU6AS811PXE0KGld+adp7O7u0LiDK103B48/SktxYofIcVfX/AnyZSbxRneMY1kvkYKlm9JcXtdxzDm4RrOI8suoMzPN9/djc0HV9g2APmxX/E8doO7TsT3LnPBPzKRRAN+qIoacvwyyCsdRtaA2iLfa0DIq+bMpeudKps1FguS66YXoZ857L3ox+9O9BPFYL/H/DjE4lrdaDqBpPLi7aUupb+/LUew3oETny/ArBBDb2duxhz4vGeD4v+pxzMbfJZfzf8NRsGmAjt9uGDBXqzD+eVw1v0D5n4ZZ+spOwTLtmdU0KQ3uC6ia49bwtYCESdOGRo2wR2QqW2JFQN0Lwhs/7sszDeLoweZ8rVwParIxAe76m2wDAwODtUxT/8vS6hBPoW3RsQk3jWsMysQH9ziu5iJnklYP7cqXz0OlDfrl3QBONP6j4tIJJ6S7MsvUN0h0IvqWLkgvd2j7u+Nl66hOhpJpE7W1FZud+kM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1J3a2HgVcrAnAM63Ilj8a/HaHKL1ITOm++Ou99lQHrPs9Qo1J0a2x+HGrL1?=
 =?us-ascii?Q?GmwVSTb2tt0oXFkQm4NKJtaQSuSnwaq3OTP8g/00TwgcoAJrfD/2reorpT/b?=
 =?us-ascii?Q?hsT6dny14NgMqCBRchT6OX0Vfw2qu4eDgMc4sfIEfxNVoRZd2lQ6qkSsfx48?=
 =?us-ascii?Q?mNjUwC0FB/GvXTV9BzkjdsZP7NmOOvwHQcPnrkqcuJgdNC1PmbrOcp4aAapd?=
 =?us-ascii?Q?wCeyFmYO4nYtPZA6UFqoRmH351Bm6IwU8+eVWS2JWQM4yutXMS+LUyCI/YXx?=
 =?us-ascii?Q?7UOmYTVib+hXL9hrjvV2gfX37/miT3j/Q1etuD5TnislDpuZA3GqE7DVamGi?=
 =?us-ascii?Q?RORoEJXvycGSv/OaVCDTmpD4vfhTA6/4XSX1HqgllIvJ1YonVLrRPiozD6ZP?=
 =?us-ascii?Q?4hdFk17PkVo2SL5n8+8shOV099hevnKbP9gAGHRxz7ERTzU5KALMFhZ/cwaq?=
 =?us-ascii?Q?EethYX12rSJUDCiM8FzJKNg81KazPzxptZx4n9qgLR7yclc8YoaBLL90/Rwx?=
 =?us-ascii?Q?YnfIEvFAElDe/PV/jey5byrCSbW36CJmd2D43luHH96Nz3O4bWeNxfcugsoY?=
 =?us-ascii?Q?BX2Y+LC4+wroObD+N2GYkhx9ETkFL34bg+ESjfwHUP5RjCd01qcHUfGpSSj7?=
 =?us-ascii?Q?NM+nAuk8TAfS1SKvEHxicr2EtYVTDIMpBmy5T4VIRSixb5BMhA6FJzYtPiZt?=
 =?us-ascii?Q?TRlBNXouFAoLH8PrIsTfWCGTEI53Gzi5JEw8EuXax/EWSEe21UoU08iFKdRj?=
 =?us-ascii?Q?j5AyysTi1ak4jj6WsMrRK8JFfHyoPUE6Lok0rtHhyZijZdpILEK5HAdkhw4m?=
 =?us-ascii?Q?AQ87rfP3iP+KJlQRWuIH7v6sKgEBqXh7Ux7Yn+GvlMhILM7fCOJA9aRE0AR9?=
 =?us-ascii?Q?zqBTwG9srAMdfwjaB1NcWakfoA5fSeuOJOjkCJBWUoGjPQY0LSK9GvXdvhLJ?=
 =?us-ascii?Q?4fHwzuHkm9g1RtJh0yZ+pURQl8Qz4c2szDBov25i+XBqpW7CxugmOo99x4VS?=
 =?us-ascii?Q?mnGglqUa3Sb70/54mgSP48FCERgaWm35awJ/AWr8XYfgMNXveizwO23Q3gkv?=
 =?us-ascii?Q?FKDbnmgQQuIZvToIBsG4Q0dvCf5Tq6Z8BKGAUkjal4vGVFCzLUpQHOgMwwn4?=
 =?us-ascii?Q?30+bbTmXbzKS32mG57/mRLvep4HlZaHUkbd8mN5CNvp0tqLbICC8PfAVjWTS?=
 =?us-ascii?Q?EpVt7SSgPZ2lpGkxBL82znlIwCJIQ51Qcrh9Dk18F4AGTXn6G0uwwBg9qUmn?=
 =?us-ascii?Q?5MCzLf5AqJ2kbwuAWJjdDEm4QupRPJbF6QQ/HfRGh6DyZ5R66Gbxw656U3as?=
 =?us-ascii?Q?FH52S6DkEfVQY1gprdQR9kWg/k9W36mkYMgf5jiNKIx88nmJTGHJCWvbJ0wC?=
 =?us-ascii?Q?W95KvdoAiatzTIov3iEOWg1kUmzG7NffVBtTlajQk/7LJ/akmopDlPKfSezN?=
 =?us-ascii?Q?4hbNnBSta/6Kjvfy6XrKNvUX6aHr5XnmmpJQYiGbBfoqZxZ93BTO80PTBLNs?=
 =?us-ascii?Q?EhNFGQC/+ZfM7Mk3g+JaAAzhDTMbzkPJT9mFPqysvKzQxaKMvXLILf9TWOnP?=
 =?us-ascii?Q?SHEL1VQkRtNIPidepT6mhg6ba5wOophjZwP8gF9HaZBAAErl9c/KT7twHnWp?=
 =?us-ascii?Q?WnHR7QJEINPXNeN5rChOmckWR1zdZwRzkox6j8/NaIrV0HXfxSgmr2jF7rhk?=
 =?us-ascii?Q?4BF1gJ+FM8vGiH05ayMs553qwxCNkst0lwcj1wnVLIWibQ0R3jjIoCMO5rVs?=
 =?us-ascii?Q?bsOAb6KTVjAkQrN3U6LFqzIdZPRvrr0=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e154caa-1dc3-40a3-a216-08da3d79da86
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:59.4345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0J51Ll5LuOaStSGV+Cymy3gpjBGEBevNVK0p3IlB6KcdEPQmYCguV922W3hVkw1iwEANAzH8t1VhQGg4vER0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
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
 drivers/net/wireless/celeno/cl8k/dsp.c | 627 +++++++++++++++++++++++++
 1 file changed, 627 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dsp.c

diff --git a/drivers/net/wireless/celeno/cl8k/dsp.c b/drivers/net/wireless/celeno/cl8k/dsp.c
new file mode 100644
index 000000000000..fbc8b29b9257
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dsp.c
@@ -0,0 +1,627 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/firmware.h>
+
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "dsp.h"
+#include "hw.h"
+
+#define BUSY_WAIT_LIMIT 10000
+
+static int cl_dsp_busy_wait(struct cl_hw *cl_hw, u32 control_reg)
+{
+	int i;
+
+	for (i = 0; i < BUSY_WAIT_LIMIT; i++) {
+		/* Poll Bit29 to verify DMA transfer has ended. */
+		if ((cl_reg_read(cl_hw, control_reg) & 0x20000000) == 0)
+			return 0;
+
+		cpu_relax();
+	}
+
+	return -EIO;
+}
+
+static void cl_dsp_boot(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (cl_hw_is_tcv0(cl_hw)) {
+		/* Disable ceva_free_clk */
+		cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 0);
+		/* Assert Ceva reset */
+		cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 0);
+	} else {
+		/* Disable ceva_free_clk */
+		cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 0);
+		/* Assert Ceva reset */
+		cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 0);
+	}
+
+	/* Set Ceva boot=1 */
+	modem_gcu_ceva_ctrl_boot_setf(cl_hw, 1);
+	/* Set Ceva vector */
+	modem_gcu_ceva_vec_set(cl_hw, 0);
+
+	if (cl_hw_is_tcv0(cl_hw)) {
+		/* Enable ceva_clk */
+		cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+		/* Disabel ceva_clk */
+		cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 0);
+		/* De-Assert Ceva reset - Reset Release */
+		cmu_phy_0_rst_ceva_0_global_rst_n_setf(chip, 1);
+		/* Enable ceva_clk */
+		cmu_phy_0_clk_en_ceva_0_clk_en_setf(chip, 1);
+	} else {
+		/* Enable ceva_clk */
+		cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+		/* Disabel ceva_clk */
+		cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 0);
+		/* De-Assert Ceva reset - Reset Release */
+		cmu_phy_1_rst_ceva_1_global_rst_n_setf(chip, 1);
+		/* Enable ceva_clk */
+		cmu_phy_1_clk_en_ceva_1_clk_en_setf(chip, 1);
+	}
+
+	/* Release Ceva external_wait */
+	modem_gcu_ceva_ctrl_external_wait_setf(cl_hw, 0);
+	/* Set Ceva boot=0 */
+	modem_gcu_ceva_ctrl_boot_setf(cl_hw, 0);
+}
+
+static void cl_dsp_config_dma_for_code_copy(struct cl_hw *cl_hw, u32 page, u32 page_size)
+{
+	/* Configure Program DMA to copy FW code from Shared PMEM to internal PMEM. */
+
+	/* External address to read from. */
+	cl_reg_write(cl_hw, CEVA_CPM_PDEA_REG, CEVA_SHARED_PMEM_BASE_ADDR_INTERNAL);
+	/* Internal address to write to. */
+	cl_reg_write(cl_hw, CEVA_CPM_PDIA_REG, CEVA_SHARED_PMEM_SIZE * page);
+	/* Page size */
+	cl_reg_write(cl_hw, CEVA_CPM_PDTC_REG, page_size);
+}
+
+static void cl_dsp_config_dma_for_external_data_copy(struct cl_hw *cl_hw)
+{
+	/* Configure Program DMA to copy FW code from Shared XMEM to internal XMEM. */
+
+	/* External address to read from. */
+	cl_reg_write(cl_hw, CEVA_CPM_DDEA_REG, CEVA_SHARED_XMEM_BASE_ADDR_INTERNAL);
+	/* Internal address to write to. */
+	cl_reg_write(cl_hw, CEVA_CPM_DDIA_REG, 0);
+	/* Page size + DMA direction is write */
+	cl_reg_write(cl_hw, CEVA_CPM_DDTC_REG,
+		     CEVA_SHARED_XMEM_SIZE | CEVA_CPM_DDTC_WRITE_COMMAND);
+}
+
+static int cl_dsp_hex_load(struct cl_hw *cl_hw, const u8 *buf,
+			   off_t offset, size_t size, size_t buf_size)
+{
+	u8 single_buf[4] = {0};
+	u32 bin_data = 0;
+	u8 next_byte;
+	u8 byte_num = 0;
+	int ret = 0;
+	ssize_t oft = 0;
+	size_t real_size = min(size * 3, buf_size);
+	/*
+	 * CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST is global and we don't
+	 * want to add TCV reg offset.
+	 */
+	bool chip_reg = (offset == CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST);
+
+	if (buf_size % 3) {
+		cl_dbg_err(cl_hw, "DSP size %zu must be divided by 3 !!!\n",
+			   buf_size);
+		return -EINVAL;
+	}
+
+	while (oft < real_size) {
+		memcpy(single_buf, buf + oft, 3);
+		/* Each line contains 2 hex digits + a line feed, i.e. 3 bytes */
+		ret = kstrtou8(single_buf, 16, &next_byte);
+		if (ret < 0) {
+			cl_dbg_err(cl_hw,
+				   "ret = %d, oft = %zu,"
+				   "single_buf = 0x%x 0x%x 0x%x 0x%x\n",
+				   ret, oft, single_buf[0], single_buf[1],
+				   single_buf[2], single_buf[3]);
+			return ret;
+		}
+
+		/* Little-endian order. */
+		bin_data += next_byte << (8 * byte_num);
+		byte_num = (byte_num + 1) % 4;
+
+		/* Read 4 lines from the file, and then write. */
+		if (byte_num == 0) {
+			if (chip_reg)
+				cl_reg_write_chip(cl_hw->chip, offset, bin_data);
+			else
+				cl_reg_write_direct(cl_hw, offset, bin_data);
+			offset += 4;
+			bin_data = 0;
+		}
+
+		memset(&single_buf, 0, sizeof(single_buf));
+		oft += 3;
+	}
+
+	return 0;
+}
+
+static int cl_dsp_load_code(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u32 real_size;
+	u32 page;
+	u32 page_size = CEVA_SHARED_PMEM_SIZE;
+	const struct firmware *fw;
+	size_t size = 0;
+	u8 *buf = NULL;
+	char path_name[CL_PATH_MAX] = {0};
+	int ret;
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s",
+		 cl_hw->conf->ce_dsp_code);
+
+	cl_dbg_verbose(cl_hw, "from %s\n", cl_hw->conf->ce_dsp_code);
+
+	ret = request_firmware(&fw, path_name, chip->dev);
+
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to get %s, with error: %x!\n",
+			   path_name, ret);
+		goto out;
+	}
+
+	size = fw->size;
+	buf = (u8 *)fw->data;
+
+	/* Load all pages + 1 extra cache page */
+	for (page = 0; page < CEVA_MAX_PAGES + 1; page++) {
+		if (page >= CEVA_MAX_PAGES)
+			page_size = CEVA_SHARED_PMEM_CACHE_SIZE;
+
+		real_size = min_t(u32, page_size * 3, size);
+
+		if (!real_size)
+			break;
+
+		/* Copy DSP code (one page each time) */
+		ret =  cl_dsp_hex_load(cl_hw, buf,
+				       CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST,
+				       page_size, size);
+		if (ret != 0) {
+			cl_dbg_err(cl_hw, "Failed to load pmem page 0x%x!\n", page);
+			break;
+		}
+
+		cl_dsp_config_dma_for_code_copy(cl_hw, page, page_size);
+		ret = cl_dsp_busy_wait(cl_hw, CEVA_CPM_PDTC_REG);
+
+		if (ret) {
+			cl_dbg_err(cl_hw, "cl_dsp_busy_wait failed!\n");
+			goto out;
+		}
+
+		buf += real_size;
+		size -= real_size;
+	}
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int cl_dsp_load_data(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	const struct firmware *fw;
+	size_t size = 0;
+	char path_name[CL_PATH_MAX] = {0};
+	int ret;
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s",
+		 cl_hw->conf->ce_dsp_data);
+
+	cl_dbg_verbose(cl_hw, "from %s\n", cl_hw->conf->ce_dsp_data);
+
+	ret = request_firmware(&fw, path_name, chip->dev);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to get %s, with error: %x!\n",
+			   path_name, ret);
+		goto out;
+	}
+
+	size = fw->size;
+
+	ret = cl_dsp_hex_load(cl_hw, fw->data, REG_MACDSP_API_BASE_ADDR,
+			      CEVA_DSP_DATA_SIZE, size);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load HEX file\n");
+		goto out;
+	}
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int cl_dsp_load_external_data(struct cl_hw *cl_hw)
+{
+	/*
+	 * Shared XMEM is not accessible by host.
+	 * Copy the XMEM section to DRAM first and then use CEVA internal DMA to copy to
+	 * SHARED XMEM.
+	 */
+	struct cl_chip *chip = cl_hw->chip;
+	const struct firmware *fw;
+	size_t size = 0;
+	char path_name[CL_PATH_MAX] = {0};
+	int ret;
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s",
+		 cl_hw->conf->ce_dsp_external_data);
+
+	cl_dbg_verbose(cl_hw, "from %s\n", cl_hw->conf->ce_dsp_external_data);
+
+	ret = request_firmware(&fw, path_name, chip->dev);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to get %s, with error: %x!\n",
+			   path_name, ret);
+		goto out;
+	}
+
+	size = fw->size;
+
+	ret = cl_dsp_hex_load(cl_hw, fw->data, REG_MACDSP_API_BASE_ADDR,
+			      CEVA_DSP_EXT_DATA_SIZE, size);
+
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load HEX file\n");
+		goto out;
+	}
+
+	cl_dsp_config_dma_for_external_data_copy(cl_hw);
+	ret = cl_dsp_busy_wait(cl_hw, CEVA_CPM_DDTC_REG);
+
+	if (ret) {
+		cl_dbg_err(cl_hw, "cl_dsp_busy_wait failed!\n");
+		goto out;
+	}
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static bool cl_dsp_is_universal_file(struct cl_chip *chip)
+{
+	return (cl_chip_is_tcv0_enabled(chip) &&
+		cl_chip_is_tcv1_enabled(chip) &&
+		!strcmp(chip->cl_hw_tcv0->conf->ce_dsp_code,
+			chip->cl_hw_tcv1->conf->ce_dsp_code));
+}
+
+static int cl_dsp_load_code_dual(struct cl_chip *chip, const char *filename)
+{
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	u32 real_size;
+	u32 page;
+	u32 page_size = CEVA_SHARED_PMEM_SIZE;
+	const struct firmware *fw;
+	size_t size = 0;
+	u8 *buf = NULL;
+	char path_name[CL_PATH_MAX] = {0};
+	int ret;
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+	cl_dbg_chip_verbose(chip, "from %s\n", filename);
+	ret = request_firmware(&fw, path_name, chip->dev);
+
+	if (ret) {
+		cl_dbg_chip_err(chip, "Failed to get %s, with error: %x!\n",
+				path_name, ret);
+		goto out;
+	}
+
+	size = fw->size;
+	buf = (u8 *)fw->data;
+
+	/* Load all pages + 1 extra cache page */
+	for (page = 0; page < CEVA_MAX_PAGES + 1; page++) {
+		if (page >= CEVA_MAX_PAGES)
+			page_size = CEVA_SHARED_PMEM_CACHE_SIZE;
+
+		real_size = min_t(u32, page_size * 3, size);
+
+		if (!real_size)
+			break;
+
+		/* Copy DSP code (one page each time) */
+		ret = cl_dsp_hex_load(chip->cl_hw_tcv0, buf,
+				      CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST,
+				      page_size, size);
+		if (ret) {
+			cl_dbg_chip_err(chip, "Failed to load pmem page 0x%x!\n", page);
+			break;
+		}
+
+		cl_dsp_config_dma_for_code_copy(cl_hw_tcv0, page, page_size);
+		ret = cl_dsp_busy_wait(cl_hw_tcv0, CEVA_CPM_PDTC_REG);
+
+		if (ret) {
+			cl_dbg_err(cl_hw_tcv0, "cl_dsp_busy_wait failed\n");
+			goto out;
+		}
+
+		cl_dsp_config_dma_for_code_copy(cl_hw_tcv1, page, page_size);
+		ret = cl_dsp_busy_wait(cl_hw_tcv1, CEVA_CPM_PDTC_REG);
+
+		if (ret) {
+			cl_dbg_err(cl_hw_tcv1, "cl_dsp_busy_wait failed\n");
+			goto out;
+		}
+
+		buf += real_size;
+		size -= real_size;
+	}
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int cl_dsp_load_external_data_dual(struct cl_chip *chip, const char *filename)
+{
+	/*
+	 * Shared XMEM is not accessible by host.
+	 * Copy the XMEM section to DRAM first and then use CEVA internal DMA to copy to
+	 * SHARED XMEM.
+	 */
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	const struct firmware *fw;
+	size_t size = 0;
+	char path_name[CL_PATH_MAX] = {0};
+	int ret;
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+	cl_dbg_chip_verbose(chip, "from %s\n", filename);
+	ret = request_firmware(&fw, path_name, chip->dev);
+
+	if (ret) {
+		cl_dbg_chip_err(chip, "Failed to get %s, with error: %x!\n",
+				path_name, ret);
+		goto out;
+	}
+
+	size = fw->size;
+
+	/* TCV0 */
+	ret = cl_dsp_hex_load(cl_hw_tcv0, fw->data, REG_MACDSP_API_BASE_ADDR,
+			      CEVA_DSP_EXT_DATA_SIZE, size);
+
+	if (ret) {
+		cl_dbg_err(cl_hw_tcv0, "Failed to load HEX file\n");
+		goto out;
+	}
+
+	cl_dsp_config_dma_for_external_data_copy(cl_hw_tcv0);
+	ret = cl_dsp_busy_wait(cl_hw_tcv0, CEVA_CPM_DDTC_REG);
+
+	if (ret) {
+		cl_dbg_err(cl_hw_tcv0, "dsp_busy_wait failed!\n");
+		goto out;
+	}
+
+	/* TCV1 */
+	ret = cl_dsp_hex_load(cl_hw_tcv1, fw->data, REG_MACDSP_API_BASE_ADDR,
+			      CEVA_DSP_EXT_DATA_SIZE, size);
+
+	if (ret) {
+		cl_dbg_err(cl_hw_tcv1, "Failed to load HEX file\n");
+		goto out;
+	}
+
+	cl_dsp_config_dma_for_external_data_copy(cl_hw_tcv1);
+	ret = cl_dsp_busy_wait(cl_hw_tcv1, CEVA_CPM_DDTC_REG);
+
+	if (ret) {
+		cl_dbg_err(cl_hw_tcv1, "cl_dsp_busy_wait failed!\n");
+		goto out;
+	}
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int cl_dsp_load_data_dual(struct cl_chip *chip, const char *filename)
+{
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	const struct firmware *fw;
+	size_t size = 0;
+	char path_name[CL_PATH_MAX] = {0};
+	int ret;
+
+	snprintf(path_name, sizeof(path_name), "cl8k/%s", filename);
+	cl_dbg_chip_verbose(chip, "from %s\n", filename);
+	ret = request_firmware(&fw, path_name, chip->dev);
+
+	if (ret) {
+		cl_dbg_chip_err(chip, "Failed to get %s, with error: %x!\n",
+				path_name, ret);
+		goto out;
+	}
+
+	size = fw->size;
+
+	ret = cl_dsp_hex_load(cl_hw_tcv0, fw->data,
+			      REG_MACDSP_API_BASE_ADDR,
+			      CEVA_DSP_DATA_SIZE, size);
+
+	if (ret != 0) {
+		cl_dbg_err(cl_hw_tcv0, "Failed to load HEX file\n");
+		goto out;
+	}
+
+	ret = cl_dsp_hex_load(cl_hw_tcv1, fw->data,
+			      REG_MACDSP_API_BASE_ADDR,
+			      CEVA_DSP_DATA_SIZE, size);
+
+	if (ret != 0) {
+		cl_dbg_err(cl_hw_tcv1, "Failed to load HEX file\n");
+		goto out;
+	}
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static void cl_dsp_print_ceva_core_info(struct cl_hw *cl_hw)
+{
+	cl_dbg_trace(cl_hw, "CEVA_CORE_VERSION_ADDR=0x%X.\n",
+		     cl_reg_read(cl_hw, CEVA_CORE_VERSION_ADDR));
+	cl_dbg_trace(cl_hw, "CEVA_CORE_ID_ADDR=0x%X.\n",
+		     cl_reg_read(cl_hw, CEVA_CORE_ID_ADDR));
+}
+
+static int cl_dsp_load_dual(struct cl_chip *chip)
+{
+	int ret = 0;
+	struct cl_hw *cl_hw_tcv0 = chip->cl_hw_tcv0;
+	struct cl_hw *cl_hw_tcv1 = chip->cl_hw_tcv1;
+	struct cl_tcv_conf *tcv0_conf = cl_hw_tcv0->conf;
+
+	modem_gcu_ceva_ctrl_external_wait_setf(cl_hw_tcv0, 0x1);
+	modem_gcu_ceva_ctrl_external_wait_setf(cl_hw_tcv1, 0x1);
+
+	cl_dsp_print_ceva_core_info(cl_hw_tcv0);
+	cl_dsp_print_ceva_core_info(cl_hw_tcv1);
+
+	ret = cl_dsp_load_code_dual(chip, tcv0_conf->ce_dsp_code);
+	if (ret != 0) {
+		cl_dbg_chip_err(chip,
+				"Failed to load DSP code. Error code %d.\n",
+				ret);
+		return ret;
+	}
+
+	ret = cl_dsp_load_external_data_dual(chip, tcv0_conf->ce_dsp_external_data);
+	if (ret != 0) {
+		cl_dbg_chip_err(chip,
+				"Failed to load DSP external data. Error code %d.\n",
+				ret);
+		return ret;
+	}
+
+	ret = cl_dsp_load_data_dual(chip, tcv0_conf->ce_dsp_data);
+	if (ret != 0) {
+		cl_dbg_chip_err(chip,
+				"Failed to load DSP data. Error code %d.\n",
+				ret);
+		return ret;
+	}
+
+	macdsp_api_config_space_set(cl_hw_tcv0, 0);
+	/* Release DSP wait. */
+	cl_dsp_boot(cl_hw_tcv0);
+
+	macdsp_api_config_space_set(cl_hw_tcv1, 0);
+	/* Release DSP wait. */
+	cl_dsp_boot(cl_hw_tcv1);
+
+	return ret;
+}
+
+static int _cl_dsp_load(struct cl_hw *cl_hw)
+{
+	int ret = 0;
+
+	modem_gcu_ceva_ctrl_external_wait_setf(cl_hw, 0x1);
+	cl_dsp_print_ceva_core_info(cl_hw);
+
+	ret = cl_dsp_load_code(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load DSP code %d\n", ret);
+		return ret;
+	}
+
+	ret = cl_dsp_load_external_data(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load DSP external data %d\n", ret);
+		return ret;
+	}
+
+	ret = cl_dsp_load_data(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load DSP data %d\n", ret);
+		return ret;
+	}
+
+	macdsp_api_config_space_set(cl_hw, 0);
+	/* Release DSP wait */
+	cl_dsp_boot(cl_hw);
+
+	return ret;
+}
+
+int cl_dsp_load_regular(struct cl_chip *chip)
+{
+	int ret = 0;
+
+	if (cl_dsp_is_universal_file(chip))
+		return cl_dsp_load_dual(chip);
+
+	if (cl_chip_is_tcv0_enabled(chip)) {
+		ret = _cl_dsp_load(chip->cl_hw_tcv0);
+		if (ret)
+			return ret;
+	}
+
+	if (cl_chip_is_tcv1_enabled(chip)) {
+		ret = _cl_dsp_load(chip->cl_hw_tcv1);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+int cl_dsp_load_recovery(struct cl_hw *cl_hw)
+{
+	int ret = 0;
+
+	modem_gcu_ceva_ctrl_external_wait_setf(cl_hw, 0x1);
+
+	ret = cl_dsp_load_external_data(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load DSP external data %d\n", ret);
+		return ret;
+	}
+
+	ret = cl_dsp_load_data(cl_hw);
+	if (ret) {
+		cl_dbg_err(cl_hw, "Failed to load DSP data %d\n", ret);
+		return ret;
+	}
+
+	macdsp_api_config_space_set(cl_hw, 0);
+	/* Release DSP wait. */
+	cl_dsp_boot(cl_hw);
+
+	return ret;
+}
-- 
2.36.1

