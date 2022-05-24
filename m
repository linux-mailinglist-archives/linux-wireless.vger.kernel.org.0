Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF953292A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiEXLi4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236832AbiEXLiz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:55 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF228CCEB
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLHdFpwtwsVrBv+Z0cAbeaAfsh+SoHBng2lFdjTbfx6N5hJIlDhkBu7ZUpz/51qGJeYzy+J6g039FsknvvedbFH+bjnc2R7uFNebnWkSWnf0swg8kG/JsZHyxYfX+A9SWYZVnqU6EcJk33glreRV8/fQj8+Mi869kANpQ9pIxlg355wa3ail20tBaS8hf3VYkM3XLspL87jkZCYW/P/YT4iCsJ67kv9qOqO0oIPw9iaKJSvkNrKLhJI6jDDM3faSgxTLv4ZQ4OFZXlw+E0IhTijMwTzsZ5SRZAX4PSvu5kf22exI3eV3gQJ12nDRxsjlnWxlmdg0n+marygIAEklOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W0yqa9mwBVjCKcu9pGBZ+EOGbpSkNVkptIQnl4NsrUs=;
 b=hp4Y4ZRyrNRyI8zg7J0mnMDqzdtBU9cXA0lIh6cMtfzUbO3XVmbwFv8mKJJ5un/9gUyyrZ7f7rfNriZZx4gigjy1cW4HcundY7b3A0Y+wgp6Jn5I0S0A1H5o4HpTdhrM5fStCDmlOje9n8rTYgQvsfx0ZVccjLgNLXLBfGkVf7c8823J2Kc/8pGuf93b9Xy9YClNf+Bchixjhuw7dzecJAYxLKEMRqJg4LGatwOjmmr8pCrE1NOqkoeS6QjM//96FDheIWw5mYaLVVc3WA08k3b2bNwz/vkJBZv9DAmWjmu6uEFXD7CucopEeaUfJWjDrT+noX6vLOikMG3izuxWTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0yqa9mwBVjCKcu9pGBZ+EOGbpSkNVkptIQnl4NsrUs=;
 b=cp4YZNWvVbYOlTLVMWhazQ5fNOefKatkM//Pnlcnnj3OiXsAQ6d9ZaOVX1vOsANxb/0vPKij5HWSlyHPznPiVH6mW/GJDgQS8pZLzR439Sf/pbyHOsVQ8yLqlczbP4fkkQ9nTeNLbi3IIj0Ulip5CxHyG48h96fultDYhfzM8fk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:37 +0000
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
Subject: [RFC v2 33/96] cl8k: add hw.c
Date:   Tue, 24 May 2022 14:33:59 +0300
Message-Id: <20220524113502.1094459-34-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6b5f82b6-00dd-4e8a-a736-08da3d79dfb4
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB0384019FC84A79C08CB08E1FF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BC7OLjl2Iz0X5MDY2XtZ7QBarSjlQh82qGcIFzb46J6ogwwdrrQoEUwXbpFoHrbzEbOENsyWKEDu4EirD54C8k8kWUaJJ4wEjPgCOuLAp83nNAAebj45DLlo0JGAg5VO1X5OroYQ1WneZ8Nor1+uB4PLeBiT4as9umJ4+9Q7XGT8U5vJUFY7a3WNfSX2YoSe2nv17NuqAdW6xLb6FFJPQMwcBsl3k/nOrDpKvZGN8aHYspvR1dv1tk5dhulBISaKSHMIkh3xuYPVrF3clU31WKH86BPh5rkxQACF3gub07s5495jzaLeieeu3dAct234lSMZLiQe5HD9ZEgG2YXlCKyvZo2OWqJgyKZUdzyIBNc+YF4fAVqQcer9EwxazGKxmkjuJnflaXLWj5dDTqqVDAzb/YJoahSWqwLWrSkjQ3d6bSisyuKFM3+e9un+9lGDMWFz101/v6lvmpFsLYZGXNsQtCFve4XErXAXpqgyzDqZlVxPTvXZ238kRcY73VKhWZhCJNtHLVg/1J7s7q+fdwhxMVnkLh+SwlGuy/zy3ClxdSHC+J/kyKbSZf2vURnR5MRqG7pIy63tTPbLF7F+QF9fcM77q3AN9Qmd9oQGAD40QZOuSIMbyS2zwPHZ7hZJOXcICdROVaU/P9ao/ahAViLvXBWxrto0O2R4MGbs59Cy5jwTpoc02Ay5VM0wOuBnqXtGlIKIgJqchk6/2glV59U8Snn05Ri3wD9a+Iokzf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5hXB3+r1UNVc8rQHJgprUDuukeb/QVjSZO9EkqlSeOkaTbDukmYLCDAAjR2h?=
 =?us-ascii?Q?ab5GOa5AvCKsRoeJhFhTbWlfUwkuxyTX36NGFi/UeJ0jKJj3W8tlGxXNLd79?=
 =?us-ascii?Q?FPffPzNoLRlaXsT2QuxTaDfCTQOW2V98ttkG4MjK4tE5SQkQgsGu6RvHZXKM?=
 =?us-ascii?Q?Y/uG5mYmhzUeAzdgW+uLxsGya4E2grLc7UOB5d7TKBX2OTwPyvEUTkv/KZYn?=
 =?us-ascii?Q?45wGEQgkluR1Ev6OACRIAK/tTsJ8ioaLRLzZ7EXJKpZAt+f13CNJMO+25XR5?=
 =?us-ascii?Q?53p37LpORn8KjUCb4WWYJd/6qpvmPnH7HnRVhjE3jlYxuRu0sfrhRqyHrb2w?=
 =?us-ascii?Q?PoTuSSVdYkix8tkSxp2QiGaXFNcizwiiznjafw+2oOw3Ejz91JpcugKQye2K?=
 =?us-ascii?Q?LJzSYaK2n3KpikIo38tPhwaKR0Q0yWUXHxXxhyElGfoMzJSoA9D/7Bg3KFiq?=
 =?us-ascii?Q?+DneN25fq8fnP4yHdGpX+MftS57gLQ1bzDgyCLVFKVXdDVCxx2NQPyoI3YFw?=
 =?us-ascii?Q?WiOQdmD7OscYjLK+65cBcxPuQHSOBkF2LnUUumH44T5oyIs10qQGPvGkSEJb?=
 =?us-ascii?Q?DJRAl3Wwm7yAV4Y9W6oR8+CKLoEDc+6h4xhSBDYR6EpqKDG8yb08G9dkqoOW?=
 =?us-ascii?Q?tiVMr5ytrBMo8j0bgl58jNV1/k8En6wGXDyJPcM0fGx6kFgmaihMfB3qrwOT?=
 =?us-ascii?Q?QQhmjXmsIAeGtyPG4cMI3wuH3+MwJKyTuxMUUplVJw8f8rrTERBZzL2FPUze?=
 =?us-ascii?Q?hFM3cqWy8jezMSajQyIeB1ZEqZppNRjfGufTt0iMe4InmtBX0ApJkY2NYEkT?=
 =?us-ascii?Q?yAbY2EIe0qQ9iakcob/sY8akdWb6z7bNjAndhbIWBWMdGMvD1CpIVcXu33P1?=
 =?us-ascii?Q?ssP8MTD8rr0e7ITfppIfkSSEVfPlOJVWYAapMCBZtT5dbbhZpR62SYs19xB2?=
 =?us-ascii?Q?mEN56IfTxixxZmmDnaO1rS9FnGorc5oXi5a1rVn4uWBSEFtwyamyoZCpPoZV?=
 =?us-ascii?Q?3cN7lAmWoYSQLxUVhvSo2w2iUELPdcP02sDYnQcuEdg5BvhNUy3lSYAEaNkf?=
 =?us-ascii?Q?I1SrC5+pjg+ej5lTwqILMFBotA8fRTR5+I54ZNbOf+71OYbnxAsnz+T6ONm2?=
 =?us-ascii?Q?m7Kv4r+xbEQGnY/3g5US8kdhyLTAjRbj3pLUy/y0+bFiXbHp9e1qSGJl9h8+?=
 =?us-ascii?Q?WQxIgJxYx5h0VZpwihs3CmgtRAQQF7NWuEGnhLSb6+zoE/4jJpqsFDzX08kC?=
 =?us-ascii?Q?t8G2fu5xMwMU1mq8oZBrPXmC8je92lFuA9nMjTtMRwMXq60SrwzjYZl7KP8M?=
 =?us-ascii?Q?I0eKcm8NL67yAZ2kO/2nvAd6kn2SEAtAEezMnGw2XG/R5P2dOuPsSmI1CNQb?=
 =?us-ascii?Q?5BDKxIy1bt6gk5VVJ42WCXCNNCbIodCRb7emj0HFtgSo+wz2FNfGFeGCvy5i?=
 =?us-ascii?Q?HuxCa/NmWldHsAu72TOAJi6VuBUHn17RMDuhxb2Ael2h6Lm2RzE0YzAnI3RY?=
 =?us-ascii?Q?rFOAc8ulJt+d8U+rm6AFAaguisxaNkpCkYX1lhgwdM7hk7iIg1RgHa+wA8jN?=
 =?us-ascii?Q?J8NPiUK1tHZIuERx5ZqIFKZnBwdCkFRaGa984gk94zmwdOkVwMgMimxlwDz9?=
 =?us-ascii?Q?L3K7M88ua+zNyXDD1zwbcIBYHyLJKAI1fdRzpmUqzWvgJKQiPIeld3WIEcnD?=
 =?us-ascii?Q?GBTYGdYtSHSZi4JG6M7y9DAL54jhd9W8Owb067JrZ5Vja+p/CgYADU4hmzb7?=
 =?us-ascii?Q?nDq1jxqQ0yQbd/EGHHIUqZTvalNMspA=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5f82b6-00dd-4e8a-a736-08da3d79dfb4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:08.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gc8WBeoS6xXgyZwsvFte5zBLgAiJTJg3TJvN0iTrUy+iL1zMvgyU93AsG4wEd8V2kRJ17V0GA0FyoMWAMoL3Jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/hw.c | 432 ++++++++++++++++++++++++++
 1 file changed, 432 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/hw.c

diff --git a/drivers/net/wireless/celeno/cl8k/hw.c b/drivers/net/wireless/celeno/cl8k/hw.c
new file mode 100644
index 000000000000..834622549f9a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/hw.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/spinlock.h>
+
+#include "tx.h"
+#include "rates.h"
+#include "reg/reg_access.h"
+#include "recovery.h"
+#include "hw.h"
+
+static void cl_hw_init_tcv0(struct cl_hw *cl_hw)
+{
+	struct cl_controller_reg *controller_reg = &cl_hw->controller_reg;
+
+	cl_hw->fw_dst_kern_id = KERN_LMAC;
+	cl_hw->fw_prefix = 'l';
+
+	controller_reg->breset = LMAC_BRESET;
+	controller_reg->debug_enable = LMAC_DEBUG_ENABLE;
+	controller_reg->dreset = LMAC_DRESET;
+	controller_reg->ocd_halt_on_reset = LMAC_OCD_HALT_ON_RESET;
+	controller_reg->run_stall = LMAC_RUN_STALL;
+
+	cl_hw->mac_hw_regs_offset = 0;
+	cl_hw->phy_regs_offset = REG_PHY_LMAC_OFFSET;
+}
+
+static void cl_hw_init_tcv1(struct cl_hw *cl_hw)
+{
+	struct cl_controller_reg *controller_reg = &cl_hw->controller_reg;
+
+	cl_hw->fw_dst_kern_id = KERN_SMAC;
+	cl_hw->fw_prefix = 's';
+
+	controller_reg->breset = SMAC_BRESET;
+	controller_reg->debug_enable = SMAC_DEBUG_ENABLE;
+	controller_reg->dreset = SMAC_DRESET;
+	controller_reg->ocd_halt_on_reset = SMAC_OCD_HALT_ON_RESET;
+	controller_reg->run_stall = SMAC_RUN_STALL;
+
+	cl_hw->mac_hw_regs_offset = REG_MAC_HW_SMAC_OFFSET;
+	cl_hw->phy_regs_offset = REG_PHY_SMAC_OFFSET;
+}
+
+static void cl_hw_set_first_last_riu_chains(struct cl_hw *cl_hw, u8 first_ant, u8 last_ant)
+{
+	u8 ant, chain;
+	u8 min_chain = U8_MAX;
+	u8 max_chain = 0;
+
+	for (ant = first_ant; ant <= last_ant; ant++) {
+		chain = cl_hw_ant_to_riu_chain(cl_hw, ant);
+
+		if (chain < min_chain)
+			min_chain = chain;
+
+		if (chain > max_chain)
+			max_chain = chain;
+	}
+
+	cl_hw->first_riu_chain = min_chain;
+	cl_hw->last_riu_chain = max_chain;
+}
+
+void cl_hw_init(struct cl_chip *chip, struct cl_hw *cl_hw, u8 tcv_idx)
+{
+	write_lock(&chip->cl_hw_lock);
+	chip->cl_hw_lut[tcv_idx] = cl_hw;
+	write_unlock(&chip->cl_hw_lock);
+
+	if (tcv_idx == TCV0)
+		cl_hw_init_tcv0(cl_hw);
+	else
+		cl_hw_init_tcv1(cl_hw);
+}
+
+void cl_hw_deinit(struct cl_hw *cl_hw, u8 tcv_idx)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	write_lock(&chip->cl_hw_lock);
+	chip->cl_hw_lut[tcv_idx] = NULL;
+	write_unlock(&chip->cl_hw_lock);
+}
+
+struct cl_hw *cl_hw_other_tcv(struct cl_hw *cl_hw)
+{
+	/* This function must be called after read lock is taken */
+	return cl_hw->chip->cl_hw_lut[1 - cl_hw->tcv_idx];
+}
+
+bool cl_hw_is_tcv0(struct cl_hw *cl_hw)
+{
+	return (cl_hw->tcv_idx == TCV0);
+}
+
+bool cl_hw_is_tcv1(struct cl_hw *cl_hw)
+{
+	return (cl_hw->tcv_idx == TCV1);
+}
+
+bool cl_hw_is_first_tcv(struct cl_hw *cl_hw)
+{
+	if (cl_hw_is_tcv0(cl_hw))
+		return true;
+	else
+		return cl_chip_is_only_tcv1_enabled(cl_hw->chip);
+}
+
+int cl_hw_set_antennas(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u8 last_ant;
+	u8 ant_shift = cl_hw_ant_shift(cl_hw);
+
+	/* Set num_antennas and max_antennas + masks for both. */
+	switch (chip->fem.wiring_id) {
+	case FEM_WIRING_0_TCV0_6_TCV1_6:
+	case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+		cl_hw->max_antennas = 6;
+		break;
+	case FEM_WIRING_24_TCV0_6_TCV1_4:
+		cl_hw->max_antennas = cl_hw_is_tcv0(cl_hw) ? 6 : 4;
+		break;
+	case FEM_WIRING_7_TCV0_4_TCV1_4:
+	case FEM_WIRING_9_TCV0_4_TCV1_4:
+	case FEM_WIRING_10_TCV0_4_TCV1_4:
+	case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+	case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+	case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+	case FEM_WIRING_18_TCV0_4_TCV1_4:
+	case FEM_WIRING_23_TCV0_4_TCV1_4:
+	case FEM_WIRING_33_TCV0_4_TCV1_4:
+		cl_hw->max_antennas = 4;
+		break;
+	case FEM_WIRING_13_SENSING_4RX_2TX:
+	case FEM_WIRING_14_SENSING_4TX_2RX:
+	case FEM_WIRING_25_TCV0_4_TCV1_2_MODE_0:
+	case FEM_WIRING_26_TCV0_4_TCV1_2_MODE_1:
+	case FEM_WIRING_28_TCV0_4_TCV1_2:
+	case FEM_WIRING_29_TCV0_4_TCV1_2:
+		cl_hw->max_antennas = cl_hw_is_tcv0(cl_hw) ? 4 : 2;
+		break;
+	case FEM_WIRING_30_TCV0_4_TCV1_2:
+			cl_hw->max_antennas = cl_hw_is_tcv0(cl_hw) ? 4 : 2;
+		break;
+	case FEM_WIRING_17_TCV0_4_TCV1_0:
+	case FEM_WIRING_32_TCV0_4_TCV1_0:
+		cl_hw->max_antennas = cl_hw_is_tcv0(cl_hw) ? 4 : 0;
+		break;
+	case FEM_WIRING_16_TCV0_2_TCV1_2:
+	case FEM_WIRING_20_TCV0_2_TCV1_2:
+		cl_hw->max_antennas = 2;
+		break;
+	case FEM_WIRING_27_TCV0_2_TCV1_1:
+	case FEM_WIRING_31_TCV0_2_TCV1_1:
+		cl_hw->max_antennas = cl_hw_is_tcv0(cl_hw) ? 2 : 1;
+		break;
+	default:
+		if (chip->conf->ce_production_mode)
+			cl_hw->max_antennas = chip->max_antennas;
+		else
+			return -1;
+		break;
+	}
+
+	cl_hw->num_antennas = cl_hw->conf->ce_num_antennas;
+	cl_hw->mask_num_antennas = ANT_MASK(cl_hw->num_antennas) << ant_shift;
+	cl_hw->first_ant = ant_shift;
+	last_ant = max_t(s8, cl_hw->num_antennas + ant_shift - 1, 0);
+
+	cl_hw_set_first_last_riu_chains(cl_hw, cl_hw->first_ant, last_ant);
+
+	cl_dbg_trace(cl_hw, "num_antennas = %u, max_antennas = %u\n",
+		     cl_hw->num_antennas, cl_hw->max_antennas);
+
+	if (cl_hw->num_antennas > cl_hw->max_antennas) {
+		CL_DBG_ERROR(cl_hw, "num_antennas (%u) > max_antennas (%u)\n",
+			     cl_hw->num_antennas, cl_hw->max_antennas);
+		return -1;
+	}
+
+	return 0;
+}
+
+u8 cl_hw_ant_shift(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	/* CL808x uses antennas 0 - 3 for both bands */
+	if (cl_chip_is_8ant(chip))
+		return 0;
+
+	if (cl_chip_is_6ant(chip)) {
+		/*
+		 * CL806X on wiring id 24 uses antennas 0-3 for TCV0 and antennas 2-3 for TCV1.
+		 * When only 1 antenna is configured - ant 3 is used.
+		 */
+		if (cl_hw_is_tcv1(cl_hw) && chip->fem.wiring_id == FEM_WIRING_24_TCV0_6_TCV1_4)
+			return (4 - cl_hw->conf->ce_num_antennas);
+
+		/* Other CL806X use antennas 0 - 3 for TCV0 and antennas 0-1 for TCV1 */
+		return 0;
+	}
+
+	/*
+	 * CL8046 uses chains 0 - 3 for TCV0 and no chain for TCV1.
+	 * Wiring ID 31 uses chains 2-3 for TCV0 and chain 4 for TCV1.
+	 */
+	if (cl_chip_is_6g(chip)) {
+		if (chip->fem.wiring_id == FEM_WIRING_31_TCV0_2_TCV1_1)
+			return cl_hw_is_tcv0(cl_hw) ? 2 : 4;
+
+		return 0;
+	}
+
+	/* CL8040 uses chains 1 - 2 for TCV0 and TCV1 */
+	return 1;
+}
+
+u8 cl_hw_ant_to_riu_chain(struct cl_hw *cl_hw, u8 ant)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u8 res = ant;
+
+	if (cl_hw_is_tcv0(cl_hw)) {
+		if (chip->fem.wiring_id == FEM_WIRING_31_TCV0_2_TCV1_1)
+			return ((ant - 2) & 0x3);
+
+		if (chip->fem.wiring_id == FEM_WIRING_30_TCV0_4_TCV1_2) {
+			if (ant == 2)
+				return 3;
+			if (ant == 3)
+				return 2;
+
+			return ant;
+		}
+
+		return ant;
+	}
+
+	switch (chip->fem.wiring_id) {
+	case FEM_WIRING_0_TCV0_6_TCV1_6:
+	case FEM_WIRING_3_TCV0_2_ELASTIC_4_TCV1_2:
+	case FEM_WIRING_17_TCV0_4_TCV1_0:
+	case FEM_WIRING_32_TCV0_4_TCV1_0:
+		return ant;
+	case FEM_WIRING_7_TCV0_4_TCV1_4:
+	case FEM_WIRING_13_SENSING_4RX_2TX:
+	case FEM_WIRING_14_SENSING_4TX_2RX:
+	case FEM_WIRING_15_CHAMELEON_4TX_4RX:
+	case FEM_WIRING_16_TCV0_2_TCV1_2:
+	case FEM_WIRING_18_TCV0_4_TCV1_4:
+	case FEM_WIRING_20_TCV0_2_TCV1_2:
+	case FEM_WIRING_23_TCV0_4_TCV1_4:
+	case FEM_WIRING_25_TCV0_4_TCV1_2_MODE_0:
+	case FEM_WIRING_26_TCV0_4_TCV1_2_MODE_1:
+	case FEM_WIRING_28_TCV0_4_TCV1_2:
+	case FEM_WIRING_29_TCV0_4_TCV1_2:
+	case FEM_WIRING_30_TCV0_4_TCV1_2:
+	case FEM_WIRING_33_TCV0_4_TCV1_4:
+		res = (3 - ant);
+		break;
+	case FEM_WIRING_9_TCV0_4_TCV1_4:
+	case FEM_WIRING_10_TCV0_4_TCV1_4:
+	case FEM_WIRING_11_TCV0_4_TCV1_4_RX_ONLY:
+	case FEM_WIRING_12_TCV0_4_TCV1_4_RX_ONLY:
+	case FEM_WIRING_24_TCV0_6_TCV1_4:
+		res = (5 - ant);
+		break;
+	case FEM_WIRING_27_TCV0_2_TCV1_1:
+		res = (2 - ant);
+		break;
+	case FEM_WIRING_31_TCV0_2_TCV1_1:
+		res = (ant == 2 ? 4 : (ant == 4 ? 2 : 0));
+		break;
+	default:
+		break;
+	}
+
+	/* Verify that the returned value is valid */
+	return res & ANT_MASK(MAX_ANTENNAS);
+}
+
+u8 cl_hw_ant_mask_to_riu_chain_mask(struct cl_hw *cl_hw, u8 ant_mask)
+{
+	u8 ant, riu_chain, riu_chain_mask = 0x0;
+
+	for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+		if (ant_mask & BIT(ant)) {
+			riu_chain = cl_hw_ant_to_riu_chain(cl_hw, ant);
+			riu_chain_mask |= BIT(riu_chain);
+		}
+	}
+
+	return riu_chain_mask;
+}
+
+bool cl_hw_is_prod_or_listener(struct cl_hw *cl_hw)
+{
+	/* TODO: Move ce_listener_en to cl_chip */
+	if (cl_hw->chip->conf->ce_production_mode ||
+	    (cl_hw->conf && cl_hw->conf->ce_listener_en))
+		return true;
+
+	return false;
+}
+
+#define ASSERT_PATTERN 0xC0DEDEAD
+
+/*
+ * Function will take time stamp for each hw error indication.
+ * when time diff between each error is less than ce_hw_assert_time_max
+ * cl_hw_restart work will be scheduled
+ */
+static bool cl_hw_assert_storm_detect(struct cl_hw *cl_hw)
+{
+	struct cl_hw_asserts_info *assert_info = &cl_hw->assert_info;
+	u8 idx = assert_info->index % CL_MIN_ASSERT_CNT;
+	/* Get the oldest assert timestamp. */
+	u8 prev_idx = (assert_info->index + 1) % CL_MIN_ASSERT_CNT;
+	bool is_hw_restarted = false;
+
+	if (assert_info->restart_sched) {
+		is_hw_restarted = true;
+	} else {
+		/* Take time stamp of the assert */
+		assert_info->timestamp[idx] = jiffies;
+		assert_info->index++;
+		/* In case hw assert time diff is less than CL_HW_ASSERT_TIME_MAX, restart hw. */
+		if (assert_info->index > CL_MIN_ASSERT_CNT) {
+			unsigned long time_diff_jiffies =
+				assert_info->timestamp[idx] - assert_info->timestamp[prev_idx];
+			unsigned int time_diff_msecs = jiffies_to_msecs(time_diff_jiffies);
+
+			if (time_diff_msecs < cl_hw->conf->ce_hw_assert_time_max) {
+				assert_info->index = 0;
+
+				cl_dbg_err(cl_hw, "Assert storm detect (time_diff = %u)\n",
+					   time_diff_msecs);
+				cl_recovery_start(cl_hw, RECOVERY_ASSERT_STORM_DETECT);
+
+				is_hw_restarted = true;
+			}
+		}
+	}
+
+	return is_hw_restarted;
+}
+
+void cl_hw_assert_info_init(struct cl_hw *cl_hw)
+{
+	memset(&cl_hw->assert_info, 0, sizeof(cl_hw->assert_info));
+}
+
+static void cl_recovery_no_dump_start(struct cl_hw *cl_hw, enum recovery_reason reason)
+{
+	cl_dbg_trace(cl_hw, "Starting recovery due to assert no dump\n");
+	cl_recovery_start(cl_hw, reason);
+}
+
+void cl_hw_assert_print(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	struct dbg_print_ind *ind = (struct dbg_print_ind *)msg->param;
+	const char *assert_string;
+	u32 assert_pattern;
+	u16 file_id = le16_to_cpu(ind->file_id);
+	u16 line = le16_to_cpu(ind->line);
+	u16 has_param = le16_to_cpu(ind->has_param);
+	u32 param = le32_to_cpu(ind->param);
+
+	/* If ce_hw_assert_time_max is 0, HW assert storm detection is disabled */
+	if (cl_hw->conf->ce_hw_assert_time_max)
+		if (cl_hw_assert_storm_detect(cl_hw))
+			return;
+
+	assert_string = cl_dbgfile_get_msg_txt(&cl_hw->dbg_data, file_id, line);
+
+	/* Avoid printing background asserts */
+	if (cl_hw->conf->ce_bg_assert_print || !strstr(assert_string, "ASSERT_REC")) {
+		/* Print ASSERT message with file_id, line, [parameter] */
+		if (has_param)
+			cl_dbg_err(cl_hw, "ASSERT_TCV%u @ FILE=%u LINE=%u param=0x%08X\n",
+				   cl_hw->idx, file_id, line, param);
+		else
+			cl_dbg_err(cl_hw, "ASSERT_TCV%u @ file=%u line=%u\n",
+				   cl_hw->idx, file_id, line);
+
+		if (!assert_string)
+			assert_string = "ASSERT STRING NOT FOUND";
+
+		/* TODO:length of single print may be limited,consider print long msgs by pieces */
+		cl_dbg_err(cl_hw, "%.500s\n", assert_string);
+	}
+
+	assert_pattern = ioread32((void __iomem *)&cl_hw->ipc_env->shared->assert_pattern);
+
+	/* Reset ASSERT pattern if needed (in order to prevent assert prints loop) */
+	if (assert_pattern == ASSERT_PATTERN)
+		iowrite32(0, (void __iomem *)&cl_hw->ipc_env->shared->assert_pattern);
+
+	if (!ind->err_no_dump)
+		return;
+
+	cl_recovery_no_dump_start(cl_hw, RECOVERY_UNRECOVERABLE_ASSERT_NO_DUMP);
+}
+
+void cl_hw_assert_check(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_shared_env __iomem *shared_env = cl_hw->ipc_env->shared;
+	u32 assert_pattern = ioread32((void __iomem *)&shared_env->assert_pattern);
+
+	if (assert_pattern == ASSERT_PATTERN) {
+		u16 line = ioread16((void __iomem *)&shared_env->assert_line_num);
+		u16 file_id = ioread16((void __iomem *)&shared_env->assert_file_id);
+		u32 param = ioread32((void __iomem *)&shared_env->assert_param);
+		const char *assert_string = cl_dbgfile_get_msg_txt(&cl_hw->dbg_data, file_id, line);
+
+		/* Print 1st ASSERT message with file_id, line, [parameter] */
+		cl_dbg_err(cl_hw, "ASSERT_%cmac @ FILE=%u LINE=%u param=0x%08X\n",
+			   cl_hw->fw_prefix, file_id, line, param);
+
+		if (!assert_string)
+			assert_string = "ASSERT STRING NOT FOUND";
+
+		cl_dbg_err(cl_hw, "%.500s\n", assert_string);
+
+		/* Reset ASSERT pattern in order to prevent assert prints loop */
+		iowrite32(0, (void __iomem *)&shared_env->assert_pattern);
+	}
+}
-- 
2.36.1

