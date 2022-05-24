Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A2E532995
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiEXLmO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbiEXLmB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:42:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60065.outbound.protection.outlook.com [40.107.6.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F300BEE34
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhikojmybDZCiOW1+lNWrre4NqIiII60Z5zPW1Yvt2lQaOF4tNn2h/A4FaCAhhdwbtf30RWikK4FCYZUY02lCKq/VDZKpaycbrKtKV28rDxZg/JwuXlENgt8Q4NX0oZdtj83/KPLGz6K38PYsltha4TSPsK60OzQbJwV1/lRgll7SyatGiLQE4oOJzLjE0nrmp2Hpf7rSMbH/C9Feuzv32kDk3sVrahP8/fcWfs3OlQK3lk0fzMjKpDrxMZKfFYZmCtqgIULmyICEiGvcTu6Q+PGTvn5Xt9MYAcSdGnOGpOUezM0mFWY8EV6HFkDVbFxxUbKlVMJeGrGohVTNdxDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2Xp1gIlEZIft5Fk3scSlNJo0F3sTiv+SgrYEySUfEQ=;
 b=RCAQeXaou8LmaFfwC8VLSXd8zLn7vh4bGvnMYFuWxH08yB1D8baV4X5zm1zV0gS3IhwvWccVkuD+3OgvTCnnSjntPKkSXysLXwVvz0OQYYv8RCuTxikCJc25eZPvw8hnoeuHzf07xUilS23NMQv4v6ajmZxvMGc52KjWrBwJvs5mt1Edd0bIrPrxfK8QlISA7sf0FcB6cURgG6IvgdNPNnT4/kniALKLEBQC+BJpZ3sXG7+CsGH/GmwxOwFpZ97Do3bjmNY+Xf7eyhh97ZtKAA2P4yjTqmHhJq3P7IN7L7aRauSjgvoDx8HlYelBwq5FR2Ol2r+i0aCnqQEBZYNWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2Xp1gIlEZIft5Fk3scSlNJo0F3sTiv+SgrYEySUfEQ=;
 b=QKc0eXk3lueznT4fdJuLCj7MMLWYXRBR9/yAGq5pHS/bmibUdslJEoEe2MQ//+D0stu7Ckrn3Mh097fbzikKBS/nWZT3a6SkgN3+0zhRATD5JqH/vl3KfKnXIXLMrdMQyfdAkb28Nrjo8C6DtKAwDJ+6J1PyG4gmx4p2z1e8mO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:25 +0000
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
Subject: [RFC v2 65/96] cl8k: add reg/reg_defs.h
Date:   Tue, 24 May 2022 14:34:31 +0300
Message-Id: <20220524113502.1094459-66-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2bfdb656-edf0-415e-8d13-08da3d79f36a
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB09150ABE16943964B90877F2F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSetrELk2CODB5IH4LIGdnrDHP4X5jOy9x9CITV8kpQsD9LIvipqGeCRv50DZVYfiFnd7YuDjSlIFRfRgjsXCDgX+K0jPgm9v/Ow036h/7sHixB7HG+YNaikm/ZefapQ1D92KX0Tl4AHgENxzEz+XLM115g0xGdyxeP3SHsGcuERH9satojN6URSGAodRQ6c7SkIxJPM5TrzP3TI6ksAHVKyZAEK5oUE1Q3sU+cIPvPkr5BKb2GZ2YkCoNVE9Jq4oV4FnA4gzrQpeGVwo+JAHvnlpJdy+F+6FfDHF5k6fPeLk/0FAVYniIt93PJRlmWGojwl3ycYKRsI9PiTX5/yBCrFLkJ3RP0vFSGyzEh+l6MHOhJFME2+h+GqO2g7PicwhTkkxXD1bbVolG/DMuOzcZWK6Q1+UpDr9pb4X9pELuVNh4dqZGs75T01irVocrcNGP9dhjLDTcPC4EoRjTSjNJWfYK8JPkZxDP1ZWk1m++2y5vU8GIXcn0aBJpOW4vQJdIF0bZXJ15KJOfwz5oVjYYfDucpFvrxJ7fQ9l4tV5iFvdOnwACRK9o/S9RBagT44VqUJJjI+WF8yW3pN2rR6CRaGBCI1WAbFjjtKaksc22ruaIpwK0FLjwein1UHLb1iNX/o2kRBmDnEaSyUo/yJ0cTHkVsWEuWxIK+mw8gjer/U5bwnCqVO9Ln7UpRKOVJKww824KkEcv5Z/fFZVbcxYALTDu1UO3DHogUqZec+FXJm6iwwFnMCaZTOGJG6lq3I41fQK/3GIVBXmUI4iRZA2DNsAfvLDybpMzhJwR/e2ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(66574015)(107886003)(2906002)(2616005)(30864003)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001)(579004)(559001)(473944003)(414714003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O16/a+Y7TZRECkt0maXxEJB5nHISbCIXlpkxtm6H6wSUwCDJtai+6N/hiW89?=
 =?us-ascii?Q?UC1JmDEIDEtoVuGmnA+61fkaqGJ+IqbqrcL6iHN4wIQRVba5LBnWEQIcgFF4?=
 =?us-ascii?Q?r5SjYa28RUhKoENMRMAQfFRty+ecCMIxqd27//Idz3aH5lrEeJ+TOWKtiDCK?=
 =?us-ascii?Q?sCKeCM3iSR1Gm8NsE9qSnFSNVLaCgq+D8Ew8/aO3VlVYwDJFdpe8+R/1hQ+g?=
 =?us-ascii?Q?asLKkTNsRxTV59AjCOEiDp3yM7RPgn1WmeXJdjeFOIBfgIsNbMXRkZdbQ5+v?=
 =?us-ascii?Q?XhyfXAqc6C9P1Xp4Rggc++5IVJu5GsQSsnBMoCs9NSgt43oxpuFKbsvhFIXZ?=
 =?us-ascii?Q?3Xz2sHXSsc0U9m3jRjHNRdUbLvBuHsNsVQBZ7ZG/V3hIc8vlNT5s6Hzh9i/c?=
 =?us-ascii?Q?H3z5k68qTSRxohrxunYAeEknsd/lsWZO2ed46t+BUzC9g4qYPj4HSJxkz+qN?=
 =?us-ascii?Q?oBx8vgwtt93bDIFd0kQkecdwBV1KEU0LpVRrww8sLxzv8387pEDxPZulhtQR?=
 =?us-ascii?Q?niuD8uU39MgLnvjYxSvd1OuVQCwdjx35oGFD8fXKpODn6+Y4pph2KNg38t+K?=
 =?us-ascii?Q?xPfWjfTQzD+S4gf0QQsbE5rBOlClQZO5gA5+Bh3W5soAebqYdcsGKLgPGsbB?=
 =?us-ascii?Q?iDTeZ93hHgbWTFywlbLZArEKgZ4qca1+RuR1PsFIfVPPoNiJ6Pn22NYx6gGP?=
 =?us-ascii?Q?EKHgjbqyo28jLUpynSqm7KwQoDl8k/Uio/l5aCHu/oRRFCTgsCdtuT66KbCd?=
 =?us-ascii?Q?EReMbLjqdpJAXaD52cPOtmoMLjUe7fykdqkdVeC/XjP5e8/OGvw0nFLFBARs?=
 =?us-ascii?Q?+WcuyhfuBHs8TSrpOptUPyPv1jga7sGx6zizCfNhKzMY1sySkkUv90AlUJqm?=
 =?us-ascii?Q?iswKaNgCe94/wxWwC+gB/hX89RLgGqMvexwB9RvjKkPoFLLVLF8Ghskc+j8t?=
 =?us-ascii?Q?9RMNGS2DCIWE6ZWwB4FAGObCJRsJb1Ex2C9tHkmrRFDIaLQ5YzjNkyd0LcjW?=
 =?us-ascii?Q?2jh7K7Ac1ikEulFRK0HVM38plrbAPTsTADVEP9KzQiH/t3Fh1OgcqyfNuVBS?=
 =?us-ascii?Q?9b9e6FVAvSEdWwT90vnzgNX+fDijhtOIVNJnQkOgo/TxEnKLup+4YlDfaJFm?=
 =?us-ascii?Q?qLNSaDsiVa4FYgJHry4V8Gwc2c5dbk75VMDXVtdmip4yDQYhs5Y1U1LmSDK2?=
 =?us-ascii?Q?3G9wFSQK6RnodwCaEXfXq6YehQi5ZOzgx5ZoeWO8r5/UEoV1ySD1eu9rkEV7?=
 =?us-ascii?Q?k8h7UFfuF3xDO1m+bT7Elb3+Y/ToxDc2lilt7ZxB1MQb+9n2hP4pJraq4jab?=
 =?us-ascii?Q?HsmI3vnWuj4yf+mmsVd+dE/NNRV/pCtWrVzheEESPWFH5DR5BVHN2qMy0GEz?=
 =?us-ascii?Q?a9AyrwAWURlJhhTxNCemtZpWfiMQKMy6CMuE6Uyke/T4fskHsbnrHQkIH+En?=
 =?us-ascii?Q?eiyiBej9/RVvLhnUHFLqSI8+GB1wehFwh9DY9H+SpLZ5OyWzbCvp0I5UK+mL?=
 =?us-ascii?Q?/Joc/s1XtvgOjqpqNjPZy/j1TfrpKhdnwNr4PEU5OEEch13Lj+mATDVBo9Kc?=
 =?us-ascii?Q?HCVBqtbyQAlf9pmITQVkU8QctNg8pSY6hwEI243PdgBCbiTzlsr7shWez2Dm?=
 =?us-ascii?Q?7stJKSZthhy5q4NqoIBcQbuXHUfYTmEVr0lEfRvBnSY4Zk4G/XGI8w5/ZjF+?=
 =?us-ascii?Q?A1kGU6jA0p72c+Lkh6lXJVTU/S5O1quakLLxdMhWHQHXz0BFEVOmEAxmZY+4?=
 =?us-ascii?Q?O32x2IFlm9K34W0Ltzh7eqnMiO1fC2M=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfdb656-edf0-415e-8d13-08da3d79f36a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:41.6310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fm1WVvsDhxzHWTTaaIbH1MGzS8VB3OAwuIW1QM1NvwiydEJlEWjzEdJJLrrM5J4dTXlFcvMKl5XE1jDFyk86Kg==
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
 .../net/wireless/celeno/cl8k/reg/reg_defs.h   | 5494 +++++++++++++++++
 1 file changed, 5494 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/reg/reg_defs.h

diff --git a/drivers/net/wireless/celeno/cl8k/reg/reg_defs.h b/drivers/net/wireless/celeno/cl8k/reg/reg_defs.h
new file mode 100644
index 000000000000..6dd137629ab5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/reg/reg_defs.h
@@ -0,0 +1,5494 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_REG_DEFS_H
+#define CL_REG_DEFS_H
+
+#include <linux/types.h>
+#include "reg/reg_access.h"
+#include "hw.h"
+#include "chip.h"
+
+#define CEVA_MCCI_BASE_ADDR 0x004B0000
+
+#define CEVA_CORE_VERSION_ADDR (CEVA_MCCI_BASE_ADDR + 0x1000)
+#define CEVA_CORE_ID_ADDR (CEVA_MCCI_BASE_ADDR + 0x1004)
+
+#define CEVA_CPM_BASE_ADDR (CEVA_MCCI_BASE_ADDR + 0x2000)
+
+/* PDMA */
+#define CEVA_CPM_PDEA_REG (CEVA_CPM_BASE_ADDR + 0x0008) /* External */
+#define CEVA_CPM_PDIA_REG (CEVA_CPM_BASE_ADDR + 0x000C) /* Internal */
+#define CEVA_CPM_PDTC_REG (CEVA_CPM_BASE_ADDR + 0x0010) /* Control */
+
+/* DDMA */
+#define CEVA_CPM_DDEA_REG (CEVA_CPM_BASE_ADDR + 0x001c) /* External */
+#define CEVA_CPM_DDIA_REG (CEVA_CPM_BASE_ADDR + 0x0020) /* Internal */
+#define CEVA_CPM_DDTC_REG (CEVA_CPM_BASE_ADDR + 0x0024) /* Control */
+
+#define CEVA_CPM_DDTC_WRITE_COMMAND 0x40000000
+
+/* Translated internally to 0x60600000. */
+#define CEVA_SHARED_PMEM_BASE_ADDR_FROM_HOST 0x004C0000
+
+/* Internal address to access Shared */
+#define CEVA_SHARED_PMEM_BASE_ADDR_INTERNAL 0x60600000 /* PMEM */
+#define CEVA_SHARED_XMEM_BASE_ADDR_INTERNAL 0x60900000 /* XMEM */
+
+#define CEVA_DSP_DATA_SIZE 0x80000 /* 512kB. */
+#define CEVA_DSP_EXT_DATA_SIZE 0x60000 /* 384kB. */
+
+/* 512kb */
+#define CEVA_INTERNAL_PMEM_SIZE 0x80000
+
+#define CEVA_SHARED_PMEM_SIZE 0x20000 /* 128kb */
+#define CEVA_SHARED_XMEM_SIZE 0x60000 /* 384kB */
+
+#define CEVA_MAX_PAGES (CEVA_INTERNAL_PMEM_SIZE / CEVA_SHARED_PMEM_SIZE)
+
+#define CEVA_SHARED_PMEM_CACHE_SIZE 0x8000 /* 32kb */
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
+static inline void cmu_clk_en_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, CMU_CLK_EN_ADDR, value);
+}
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
+#define CMU_MAC_ALL_CLK_EN		    (CMU_RICU_CLK_EN_BIT     | \
+		CMU_SMAC_PROC_CLK_EN_BIT | \
+		CMU_UMAC_PROC_CLK_EN_BIT | \
+		CMU_LMAC_PROC_CLK_EN_BIT)
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
+	cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR, value);
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
+#define CMU_PHY0_CLK_EN			    (CMU_CEVA_0_CLK_EN_BIT   | \
+		CMU_PHY_0_APB_CLK_EN_BIT | \
+		CMU_PHY_0_MAIN_CLK_EN_BIT)
+
+static inline void cmu_phy_0_clk_en_pack(struct cl_chip *chip, u8 ceva0clken,
+					 u8 phy0apbclken, u8 phy0mainclken)
+{
+	ASSERT_ERR_CHIP((((u32)ceva0clken << 2) & ~((u32)0x00000004)) == 0);
+	ASSERT_ERR_CHIP((((u32)phy0apbclken << 1) & ~((u32)0x00000002)) == 0);
+	ASSERT_ERR_CHIP((((u32)phy0mainclken << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR,
+			  ((u32)ceva0clken << 2) | ((u32)phy0apbclken << 1) |
+			  ((u32)phy0mainclken << 0));
+}
+
+static inline void cmu_phy_0_clk_en_ceva_0_clk_en_setf(struct cl_chip *chip, u8 ceva0clken)
+{
+	ASSERT_ERR_CHIP((((u32)ceva0clken << 2) & ~((u32)0x00000004)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR,
+			  (cl_reg_read_chip(chip, CMU_PHY_0_CLK_EN_ADDR) & ~((u32)0x00000004)) |
+			  ((u32)ceva0clken << 2));
+}
+
+static inline void cmu_phy_0_clk_en_phy_0_apb_clk_en_setf(struct cl_chip *chip, u8 phy0apbclken)
+{
+	ASSERT_ERR_CHIP((((u32)phy0apbclken << 1) & ~((u32)0x00000002)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_0_CLK_EN_ADDR,
+			  (cl_reg_read_chip(chip, CMU_PHY_0_CLK_EN_ADDR) & ~((u32)0x00000002)) |
+			  ((u32)phy0apbclken << 1));
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
+	cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR, value);
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
+#define CMU_PHY1_CLK_EN			    (CMU_CEVA_1_CLK_EN_BIT   | \
+		CMU_PHY_1_APB_CLK_EN_BIT | \
+		CMU_PHY_1_MAIN_CLK_EN_BIT)
+
+static inline void cmu_phy_1_clk_en_pack(struct cl_chip *chip, u8 ceva1clken,
+					 u8 phy1apbclken, u8 phy1mainclken)
+{
+	ASSERT_ERR_CHIP((((u32)ceva1clken << 2) & ~((u32)0x00000004)) == 0);
+	ASSERT_ERR_CHIP((((u32)phy1apbclken << 1) & ~((u32)0x00000002)) == 0);
+	ASSERT_ERR_CHIP((((u32)phy1mainclken << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR,
+			  ((u32)ceva1clken << 2) | ((u32)phy1apbclken << 1) |
+			  ((u32)phy1mainclken << 0));
+}
+
+static inline void cmu_phy_1_clk_en_ceva_1_clk_en_setf(struct cl_chip *chip, u8 ceva1clken)
+{
+	ASSERT_ERR_CHIP((((u32)ceva1clken << 2) & ~((u32)0x00000004)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR,
+			  (cl_reg_read_chip(chip, CMU_PHY_1_CLK_EN_ADDR) & ~((u32)0x00000004)) |
+			  ((u32)ceva1clken << 2));
+}
+
+static inline void cmu_phy_1_clk_en_phy_1_apb_clk_en_setf(struct cl_chip *chip, u8 phy1apbclken)
+{
+	ASSERT_ERR_CHIP((((u32)phy1apbclken << 1) & ~((u32)0x00000002)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_1_CLK_EN_ADDR,
+			  (cl_reg_read_chip(chip, CMU_PHY_1_CLK_EN_ADDR) & ~((u32)0x00000002)) |
+			  ((u32)phy1apbclken << 1));
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
+static inline void cmu_control_gl_mux_sel_setf(struct cl_chip *chip, u8 glmuxsel)
+{
+	ASSERT_ERR_CHIP((((u32)glmuxsel << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, CMU_CONTROL_ADDR, (u32)glmuxsel << 0);
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
+static inline void cmu_rst_n_ricurst_setf(struct cl_chip *chip, u8 nricurst)
+{
+	ASSERT_ERR_CHIP((((u32)nricurst << 15) & ~((u32)0x00008000)) == 0);
+	cl_reg_write_chip(chip, CMU_RST_ADDR,
+			  (cl_reg_read_chip(chip, CMU_RST_ADDR) & ~((u32)0x00008000)) |
+			  ((u32)nricurst << 15));
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
+	cl_reg_write_chip(chip, CMU_PHY_0_RST_ADDR, value);
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
+#define CMU_PHY0_RST_EN			    (CMU_PHY_0_PRESET_N_BIT | \
+		CMU_MPIF_0_RST_N_BIT |    \
+		CMU_PHY_0_RST_N_BIT |     \
+		CMU_CEVA_0_GLOBAL_RST_N_BIT)
+
+static inline void cmu_phy_0_rst_ceva_0_global_rst_n_setf(struct cl_chip *chip, u8 ceva0globalrstn)
+{
+	ASSERT_ERR_CHIP((((u32)ceva0globalrstn << 3) & ~((u32)0x00000008)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_0_RST_ADDR,
+			  (cl_reg_read_chip(chip, CMU_PHY_0_RST_ADDR) & ~((u32)0x00000008)) |
+			  ((u32)ceva0globalrstn << 3));
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
+	cl_reg_write_chip(chip, CMU_PHY_1_RST_ADDR, value);
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
+#define CMU_PHY1_RST_EN			    (CMU_PHY_1_PRESET_N_BIT | \
+		CMU_MPIF_1_RST_N_BIT |    \
+		CMU_PHY_1_RST_N_BIT |     \
+		CMU_CEVA_1_GLOBAL_RST_N_BIT)
+
+static inline void cmu_phy_1_rst_ceva_1_global_rst_n_setf(struct cl_chip *chip, u8 ceva1globalrstn)
+{
+	ASSERT_ERR_CHIP((((u32)ceva1globalrstn << 3) & ~((u32)0x00000008)) == 0);
+	cl_reg_write_chip(chip, CMU_PHY_1_RST_ADDR,
+			  (cl_reg_read_chip(chip, CMU_PHY_1_RST_ADDR) & ~((u32)0x00000008)) |
+			  ((u32)ceva1globalrstn << 3));
+}
+
+/*
+ * @brief CMU_PLL_0_STAT register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    pll_lock                  0
+ * </pre>
+ */
+#define CMU_PLL_0_STAT_ADDR        (REG_CMU_BASE_ADDR + 0x00000040)
+#define CMU_PLL_0_STAT_OFFSET      0x00000040
+#define CMU_PLL_0_STAT_INDEX       0x00000010
+#define CMU_PLL_0_STAT_RESET       0x00000000
+
+static inline u8 cmu_pll_0_stat_pll_lock_getf(struct cl_chip *chip)
+{
+	u32 local_val = cl_reg_read_chip(chip, CMU_PLL_0_STAT_ADDR);
+
+	ASSERT_ERR_CHIP((local_val & ~((u32)0x80000000)) == 0);
+	return (local_val >> 31);
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
+	u32 local_val = cl_reg_read_chip(chip, CMU_PLL_1_STAT_ADDR);
+
+	ASSERT_ERR_CHIP((local_val & ~((u32)0x80000000)) == 0);
+	return (local_val >> 31);
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
+	cl_reg_write_chip(chip, CMU_PHASE_SEL_ADDR, value);
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
+struct cl_fem_lna_enable_gpio {
+	union {
+		struct {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+			u16 b0 : 1,
+			    b1 : 1,
+			    b2 : 1,
+			    b3 : 1,
+			    b4 : 1,
+			    b5 : 1,
+			    b6 : 1,
+			    b7 : 1,
+			    b8 : 1,
+			    b9 : 1,
+			    b10 : 1,
+			    b11 : 1,
+			    rsv : 4;
+#else /* __BIG_ENDIAN_BITFIELD */
+			u16 rsv : 4,
+			    b11 : 1,
+			    b10 : 1,
+			    b9 : 1,
+			    b8 : 1,
+			    b7 : 1,
+			    b6 : 1,
+			    b5 : 1,
+			    b4 : 1,
+			    b3 : 1,
+			    b2 : 1,
+			    b1 : 1,
+			    b0 : 1;
+#endif
+		} bits;
+		u16 val;
+	};
+};
+
+struct cl_fem_pa_enable_gpio {
+	union {
+		struct {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+			u16 b0 : 1,
+			    b1 : 1,
+			    b2 : 1,
+			    b3 : 1,
+			    b4 : 1,
+			    b5 : 1,
+			    b6 : 1,
+			    b7 : 1,
+			    b8 : 1,
+			    b9 : 1,
+			    b10 : 1,
+			    b11 : 1,
+			    rsv : 4;
+#else /* __BIG_ENDIAN_BITFIELD */
+			u16 rsv : 4,
+			    b11 : 1,
+			    b10 : 1,
+			    b9 : 1,
+			    b8 : 1,
+			    b7 : 1,
+			    b6 : 1,
+			    b5 : 1,
+			    b4 : 1,
+			    b3 : 1,
+			    b2 : 1,
+			    b1 : 1,
+			    b0 : 1;
+#endif
+		} bits;
+		u16 val;
+	};
+};
+
+struct cl_fem_rx_active_gpio {
+	union {
+		struct {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+			u8 b0 : 1,
+			   b1 : 1,
+			   b2 : 1,
+			   b3 : 1,
+			   b4 : 1,
+			   b5 : 1,
+			   b6 : 1,
+			   b7 : 1;
+#else /* __BIG_ENDIAN_BITFIELD */
+			u8 b7 : 1,
+			   b6 : 1,
+			   b5 : 1,
+			   b4 : 1,
+			   b3 : 1,
+			   b2 : 1,
+			   b1 : 1,
+			   b0 : 1;
+#endif
+		} bits;
+		u8 val;
+	};
+};
+
+#define EXTRACT_BYPASS_LUT(lut) ((lut) & 0x7)
+#define FEM_LUT_MASK            0x7777
+
+#define PA_ENABLE_POS  0
+#define LNA_ENABLE_POS 1
+#define RX_ACTIVE_POS  2
+#define GET_BIT(reg, pos) (((reg) >> (pos)) & 0x1)
+
+#define LNA_ENABLE_GPIO_OUT_CFG(val) \
+	(((1 << IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_POS) & IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_BIT) | \
+	 ((1 << IO_CTRL_LNA_ENABLE_0_GPIO_OE_POS) & IO_CTRL_LNA_ENABLE_0_GPIO_OE_BIT) | \
+	 (((u32)(val) << IO_CTRL_LNA_ENABLE_0_GPIO_OUT_POS) & IO_CTRL_LNA_ENABLE_0_GPIO_OUT_BIT))
+#define PA_ENABLE_GPIO_OUT_CFG(val) \
+	 (((1 << IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_POS) & IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_BIT) | \
+	  ((1 << IO_CTRL_PA_ENABLE_0_GPIO_OE_POS) & IO_CTRL_PA_ENABLE_0_GPIO_OE_BIT) | \
+	  (((u32)(val) << IO_CTRL_PA_ENABLE_0_GPIO_OUT_POS) & IO_CTRL_PA_ENABLE_0_GPIO_OUT_BIT))
+#define RX_ACTIVE_GPIO_OUT_CFG(val) \
+	  (((1 << IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_POS) & IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_BIT) | \
+	   ((1 << IO_CTRL_RX_ACTIVE_0_GPIO_OE_POS) & IO_CTRL_RX_ACTIVE_0_GPIO_OE_BIT) | \
+	   (((u32)(val) << IO_CTRL_RX_ACTIVE_0_GPIO_OUT_POS) & IO_CTRL_RX_ACTIVE_0_GPIO_OUT_BIT))
+
+#define REG_IPC_BASE_ADDR 0x007C4000
+
+/*
+ * @brief XMAC_2_HOST_RAW_STATUS register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_raw_status      0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_RAW_STATUS_ADDR        (REG_IPC_BASE_ADDR + 0x00000004)
+#define IPC_XMAC_2_HOST_RAW_STATUS_OFFSET      0x00000004
+#define IPC_XMAC_2_HOST_RAW_STATUS_INDEX       0x00000001
+#define IPC_XMAC_2_HOST_RAW_STATUS_RESET       0x00000000
+
+static inline u32 ipc_xmac_2_host_raw_status_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, IPC_XMAC_2_HOST_RAW_STATUS_ADDR);
+}
+
+/*
+ * @brief XMAC_2_HOST_ACK register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_trigger_clr     0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_ACK_ADDR        (REG_IPC_BASE_ADDR + 0x00000008)
+#define IPC_XMAC_2_HOST_ACK_OFFSET      0x00000008
+#define IPC_XMAC_2_HOST_ACK_INDEX       0x00000002
+#define IPC_XMAC_2_HOST_ACK_RESET       0x00000000
+
+static inline void ipc_xmac_2_host_ack_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_XMAC_2_HOST_ACK_ADDR, value);
+}
+
+/*
+ * @brief XMAC_2_HOST_ENABLE_SET register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_enable_set      0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_ENABLE_SET_ADDR        (REG_IPC_BASE_ADDR + 0x0000000C)
+#define IPC_XMAC_2_HOST_ENABLE_SET_OFFSET      0x0000000C
+#define IPC_XMAC_2_HOST_ENABLE_SET_INDEX       0x00000003
+#define IPC_XMAC_2_HOST_ENABLE_SET_RESET       0x00000000
+
+static inline void ipc_xmac_2_host_enable_set_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_XMAC_2_HOST_ENABLE_SET_ADDR, value);
+}
+
+/*
+ * @brief XMAC_2_HOST_ENABLE_CLEAR register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_enable_clear    0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_ADDR        (REG_IPC_BASE_ADDR + 0x00000010)
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_OFFSET      0x00000010
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_INDEX       0x00000004
+#define IPC_XMAC_2_HOST_ENABLE_CLEAR_RESET       0x00000000
+
+static inline void ipc_xmac_2_host_enable_clear_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_XMAC_2_HOST_ENABLE_CLEAR_ADDR, value);
+}
+
+/*
+ * @brief XMAC_2_HOST_STATUS register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 xmac2host_status          0x0
+ * </pre>
+ */
+#define IPC_XMAC_2_HOST_STATUS_ADDR        (REG_IPC_BASE_ADDR + 0x00000014)
+#define IPC_XMAC_2_HOST_STATUS_OFFSET      0x00000014
+#define IPC_XMAC_2_HOST_STATUS_INDEX       0x00000005
+#define IPC_XMAC_2_HOST_STATUS_RESET       0x00000000
+
+static inline u32 ipc_xmac_2_host_status_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, IPC_XMAC_2_HOST_STATUS_ADDR);
+}
+
+/*
+ * @brief HOST_GLOBAL_INT_EN register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    master_int_enable         0
+ * </pre>
+ */
+#define IPC_HOST_GLOBAL_INT_EN_ADDR        (REG_IPC_BASE_ADDR + 0x00000030)
+#define IPC_HOST_GLOBAL_INT_EN_OFFSET      0x00000030
+#define IPC_HOST_GLOBAL_INT_EN_INDEX       0x0000000C
+#define IPC_HOST_GLOBAL_INT_EN_RESET       0x00000000
+
+static inline void ipc_host_global_int_en_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_HOST_GLOBAL_INT_EN_ADDR, value);
+}
+
+/*
+ * @brief HOST_2_LMAC_TRIGGER register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 host2lmac_trigger         0x0
+ * </pre>
+ */
+#define IPC_HOST_2_LMAC_TRIGGER_ADDR        (REG_IPC_BASE_ADDR + 0x00000080)
+#define IPC_HOST_2_LMAC_TRIGGER_OFFSET      0x00000080
+#define IPC_HOST_2_LMAC_TRIGGER_INDEX       0x00000020
+#define IPC_HOST_2_LMAC_TRIGGER_RESET       0x00000000
+
+static inline void ipc_host_2_lmac_trigger_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_HOST_2_LMAC_TRIGGER_ADDR, value);
+}
+
+/*
+ * @brief HOST_2_UMAC_TRIGGER register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 host2umac_trigger         0x0
+ * </pre>
+ */
+#define IPC_HOST_2_UMAC_TRIGGER_ADDR        (REG_IPC_BASE_ADDR + 0x00000084)
+#define IPC_HOST_2_UMAC_TRIGGER_OFFSET      0x00000084
+#define IPC_HOST_2_UMAC_TRIGGER_INDEX       0x00000021
+#define IPC_HOST_2_UMAC_TRIGGER_RESET       0x00000000
+
+static inline void ipc_host_2_umac_trigger_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_HOST_2_UMAC_TRIGGER_ADDR, value);
+}
+
+/*
+ * @brief HOST_2_SMAC_TRIGGER register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:00 host2smac_trigger         0x0
+ * </pre>
+ */
+#define IPC_HOST_2_SMAC_TRIGGER_ADDR        (REG_IPC_BASE_ADDR + 0x00000088)
+#define IPC_HOST_2_SMAC_TRIGGER_OFFSET      0x00000088
+#define IPC_HOST_2_SMAC_TRIGGER_INDEX       0x00000022
+#define IPC_HOST_2_SMAC_TRIGGER_RESET       0x00000000
+
+static inline void ipc_host_2_smac_trigger_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IPC_HOST_2_SMAC_TRIGGER_ADDR, value);
+}
+
+#define REG_LCU_COMMON_BASE_ADDR 0x007CF000
+
+/*
+ * @brief LCU_COMMON_SW_RST register definition
+ *  Software reset register description
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    SW_RST                    0
+ * </pre>
+ */
+#define LCU_COMMON_SW_RST_ADDR        (REG_LCU_COMMON_BASE_ADDR + 0x00000048)
+#define LCU_COMMON_SW_RST_OFFSET      0x00000048
+#define LCU_COMMON_SW_RST_INDEX       0x00000012
+#define LCU_COMMON_SW_RST_RESET       0x00000000
+
+static inline void lcu_common_sw_rst_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, LCU_COMMON_SW_RST_ADDR, value);
+}
+
+#define REG_LCU_PHY_BASE_ADDR 0x0048E000
+
+/*
+ * @brief LCU_CH_0_START register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    CH0_START                 0
+ * </pre>
+ */
+#define LCU_PHY_LCU_CH_0_START_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000020)
+#define LCU_PHY_LCU_CH_0_START_OFFSET      0x00000020
+#define LCU_PHY_LCU_CH_0_START_INDEX       0x00000008
+#define LCU_PHY_LCU_CH_0_START_RESET       0x00000000
+
+/*
+ * @brief LCU_CH_0_STOP register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    CH0_STOP                  0
+ * </pre>
+ */
+#define LCU_PHY_LCU_CH_0_STOP_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000070)
+#define LCU_PHY_LCU_CH_0_STOP_OFFSET      0x00000070
+#define LCU_PHY_LCU_CH_0_STOP_INDEX       0x0000001C
+#define LCU_PHY_LCU_CH_0_STOP_RESET       0x00000000
+
+static inline void lcu_phy_lcu_ch_0_stop_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, LCU_PHY_LCU_CH_0_STOP_ADDR, value);
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
+#define LCU_PHY_LCU_CH_1_STOP_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000074)
+#define LCU_PHY_LCU_CH_1_STOP_OFFSET      0x00000074
+#define LCU_PHY_LCU_CH_1_STOP_INDEX       0x0000001D
+#define LCU_PHY_LCU_CH_1_STOP_RESET       0x00000000
+
+static inline void lcu_phy_lcu_ch_1_stop_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, LCU_PHY_LCU_CH_1_STOP_ADDR, value);
+}
+
+/*
+ * @brief LCU_CH_0_STOP_EN register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    02    CH0_EXT_STOP_EN           0
+ *    01    CH0_FIC_STOP_EN           0
+ *    00    CH0_STOP_PTRN_EN          0
+ * </pre>
+ */
+#define LCU_PHY_LCU_CH_0_STOP_EN_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000078)
+#define LCU_PHY_LCU_CH_0_STOP_EN_OFFSET      0x00000078
+#define LCU_PHY_LCU_CH_0_STOP_EN_INDEX       0x0000001E
+#define LCU_PHY_LCU_CH_0_STOP_EN_RESET       0x00000000
+
+/*
+ * @brief LCU_SW_RST register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    00    SW_RST                    0
+ * </pre>
+ */
+#define LCU_PHY_LCU_SW_RST_ADDR        (REG_LCU_PHY_BASE_ADDR + 0x00000154)
+#define LCU_PHY_LCU_SW_RST_OFFSET      0x00000154
+#define LCU_PHY_LCU_SW_RST_INDEX       0x00000055
+#define LCU_PHY_LCU_SW_RST_RESET       0x00000000
+
+static inline void lcu_phy_lcu_sw_rst_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, LCU_PHY_LCU_SW_RST_ADDR, value);
+}
+
+/*
+ * @brief CONFIG_SPACE register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:26 ActiveAntennaSet          0x0
+ *    25:20 RxCckActiveChain          0x0
+ *    19:14 RxOfdmActiveChain         0x0
+ *    13:08 TxCckActiveChain          0x0
+ *    07:06 Band                      0x0
+ *    05:04 ChannelBandwidth          0x0
+ *    03    OfdmOnly                  0
+ *    02    RxSensingMode             0
+ *    01    UpdateSync                0
+ *    00    StartupSync               0
+ * </pre>
+ */
+#define MACDSP_API_CONFIG_SPACE_ADDR        (REG_MACDSP_API_BASE_ADDR + 0x00000010)
+#define MACDSP_API_CONFIG_SPACE_OFFSET      0x00000010
+#define MACDSP_API_CONFIG_SPACE_INDEX       0x00000004
+#define MACDSP_API_CONFIG_SPACE_RESET       0x00000000
+
+static inline void macdsp_api_config_space_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MACDSP_API_CONFIG_SPACE_ADDR, value);
+}
+
+/*
+ * @brief STATE_CNTRL register definition
+ * This register controls the core's state transitions. register description
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
+static inline void mac_hw_state_cntrl_next_state_setf(struct cl_hw *cl_hw, u8 nextstate)
+{
+	ASSERT_ERR((((u32)nextstate << 4) & ~((u32)0x000000F0)) == 0);
+	cl_reg_write(cl_hw, MAC_HW_STATE_CNTRL_ADDR,
+		     (cl_reg_read(cl_hw, MAC_HW_STATE_CNTRL_ADDR) & ~((u32)0x000000F0)) |
+		     ((u32)nextstate << 4));
+}
+
+/*
+ * @brief MAC_CNTRL_1 register definition
+ * Contains various settings for controlling the operation of the core. register description
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
+static inline void mac_hw_mac_cntrl_1_active_clk_gating_setf(struct cl_hw *cl_hw,
+							     u8 activeclkgating)
+{
+	ASSERT_ERR((((u32)activeclkgating << 7) & ~((u32)0x00000080)) == 0);
+	cl_reg_write(cl_hw, MAC_HW_MAC_CNTRL_1_ADDR,
+		     (cl_reg_read(cl_hw, MAC_HW_MAC_CNTRL_1_ADDR) & ~((u32)0x00000080)) |
+		     ((u32)activeclkgating << 7));
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
+#define MAC_HW_EDCA_CCA_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000220)
+#define MAC_HW_EDCA_CCA_BUSY_OFFSET      0x00000220
+#define MAC_HW_EDCA_CCA_BUSY_INDEX       0x00000088
+#define MAC_HW_EDCA_CCA_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_edca_cca_busy_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_EDCA_CCA_BUSY_ADDR);
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
+#define MAC_HW_TX_MINE_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000238)
+#define MAC_HW_TX_MINE_BUSY_OFFSET      0x00000238
+#define MAC_HW_TX_MINE_BUSY_INDEX       0x0000008E
+#define MAC_HW_TX_MINE_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_tx_mine_busy_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_TX_MINE_BUSY_ADDR);
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
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000290)
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_OFFSET      0x00000290
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_INDEX       0x000000A4
+#define MAC_HW_ADD_CCA_BUSY_SEC_20_RESET       0x00000000
+
+static inline u32 mac_hw_add_cca_busy_sec_20_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_ADD_CCA_BUSY_SEC_20_ADDR);
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
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000294)
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_OFFSET      0x00000294
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_INDEX       0x000000A5
+#define MAC_HW_ADD_CCA_BUSY_SEC_40_RESET       0x00000000
+
+static inline u32 mac_hw_add_cca_busy_sec_40_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_ADD_CCA_BUSY_SEC_40_ADDR);
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
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000298)
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_OFFSET      0x00000298
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_INDEX       0x000000A6
+#define MAC_HW_ADD_CCA_BUSY_SEC_80_RESET       0x00000000
+
+static inline u32 mac_hw_add_cca_busy_sec_80_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_ADD_CCA_BUSY_SEC_80_ADDR);
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
+#define MAC_HW_INTRA_BSS_NAV_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000408)
+#define MAC_HW_INTRA_BSS_NAV_BUSY_OFFSET      0x00000408
+#define MAC_HW_INTRA_BSS_NAV_BUSY_INDEX       0x00000102
+#define MAC_HW_INTRA_BSS_NAV_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_intra_bss_nav_busy_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_INTRA_BSS_NAV_BUSY_ADDR);
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
+#define MAC_HW_INTER_BSS_NAV_BUSY_ADDR        (REG_MAC_HW_BASE_ADDR + 0x0000040C)
+#define MAC_HW_INTER_BSS_NAV_BUSY_OFFSET      0x0000040C
+#define MAC_HW_INTER_BSS_NAV_BUSY_INDEX       0x00000103
+#define MAC_HW_INTER_BSS_NAV_BUSY_RESET       0x00000000
+
+static inline u32 mac_hw_inter_bss_nav_busy_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_INTER_BSS_NAV_BUSY_ADDR);
+}
+
+/*
+ * @brief DEBUG_PORT_SEL_A register definition
+ * Used to multiplex different sets of signals on the debug pins. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   15:08 DEBUG_PORT_SEL_1          0x0
+ *   07:00 DEBUG_PORT_SEL_0          0x0
+ * </pre>
+ */
+#define MAC_HW_DEBUG_PORT_SEL_A_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000510)
+#define MAC_HW_DEBUG_PORT_SEL_A_OFFSET      0x00000510
+#define MAC_HW_DEBUG_PORT_SEL_A_INDEX       0x00000144
+#define MAC_HW_DEBUG_PORT_SEL_A_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_sel_a_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_SEL_A_ADDR);
+}
+
+static inline void mac_hw_debug_port_sel_a_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_SEL_A_ADDR, value);
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
+#define MAC_HW_DEBUG_PORT_SEL_B_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000530)
+#define MAC_HW_DEBUG_PORT_SEL_B_OFFSET      0x00000530
+#define MAC_HW_DEBUG_PORT_SEL_B_INDEX       0x0000014C
+#define MAC_HW_DEBUG_PORT_SEL_B_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_sel_b_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_SEL_B_ADDR);
+}
+
+static inline void mac_hw_debug_port_sel_b_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_SEL_B_ADDR, value);
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
+#define MAC_HW_DEBUG_PORT_SEL_C_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000534)
+#define MAC_HW_DEBUG_PORT_SEL_C_OFFSET      0x00000534
+#define MAC_HW_DEBUG_PORT_SEL_C_INDEX       0x0000014D
+#define MAC_HW_DEBUG_PORT_SEL_C_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_sel_c_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_SEL_C_ADDR);
+}
+
+static inline void mac_hw_debug_port_sel_c_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_SEL_C_ADDR, value);
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
+#define MAC_HW_DEBUG_PORT_EN_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000538)
+#define MAC_HW_DEBUG_PORT_EN_OFFSET      0x00000538
+#define MAC_HW_DEBUG_PORT_EN_INDEX       0x0000014E
+#define MAC_HW_DEBUG_PORT_EN_RESET       0x00000000
+
+static inline u32 mac_hw_debug_port_en_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, MAC_HW_DEBUG_PORT_EN_ADDR);
+}
+
+static inline void mac_hw_debug_port_en_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MAC_HW_DEBUG_PORT_EN_ADDR, value);
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
+#define MAC_HW_DOZE_CNTRL_2_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00008048)
+#define MAC_HW_DOZE_CNTRL_2_OFFSET      0x00008048
+#define MAC_HW_DOZE_CNTRL_2_INDEX       0x00002012
+#define MAC_HW_DOZE_CNTRL_2_RESET       0x00000001
+
+static inline void mac_hw_doze_cntrl_2_wake_up_sw_setf(struct cl_hw *cl_hw, u8 wakeupsw)
+{
+	ASSERT_ERR((((u32)wakeupsw << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write(cl_hw, MAC_HW_DOZE_CNTRL_2_ADDR,
+		     (cl_reg_read(cl_hw, MAC_HW_DOZE_CNTRL_2_ADDR) & ~((u32)0x00000001)) |
+		     ((u32)wakeupsw << 0));
+}
+
+#define MU_ADDR_OFFSET(i) ((i) << 16)
+#define MAX_MU_CNT 8
+
+/*
+ * @brief MAC_CNTRL_2 register definition
+ * Contains various settings for controlling the operation of the core. register description
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *   00    SOFT_RESET                0
+ * </pre>
+ */
+#define MAC_HW_MU_MAC_CNTRL_2_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00008050)
+#define MAC_HW_MU_MAC_CNTRL_2_OFFSET      0x00008050
+#define MAC_HW_MU_MAC_CNTRL_2_INDEX       0x00002014
+#define MAC_HW_MU_MAC_CNTRL_2_RESET       0x00000000
+
+static inline void mac_hw_mu_mac_cntrl_2_set(struct cl_hw *cl_hw, u32 value, u8 mu_idx)
+{
+	ASSERT_ERR(mu_idx < MAX_MU_CNT);
+	cl_reg_write(cl_hw, (MAC_HW_MU_MAC_CNTRL_2_ADDR + MU_ADDR_OFFSET(mu_idx)), value);
+}
+
+/*
+ * @brief MIB_TABLE register definition
+ * MIB table register description
+ * 1024 memory size
+ * </pre>
+ */
+#define MAC_HW_MU_MIB_TABLE_ADDR        (REG_MAC_HW_BASE_ADDR + 0x00000800)
+#define MAC_HW_MU_MIB_TABLE_OFFSET      0x00000800
+#define MAC_HW_MU_MIB_TABLE_SIZE        0x00000400
+#define MAC_HW_MU_MIB_TABLE_END_ADDR    (MAC_HW_MU_MIB_TABLE_ADDR + MAC_HW_MU_MIB_TABLE_SIZE - 1)
+
+#define REG_MACSYS_GCU_BASE_ADDR 0x007C5000
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
+#define MACSYS_GCU_CHIP_VERSION_ADDR        (REG_MACSYS_GCU_BASE_ADDR + 0x00000050)
+#define MACSYS_GCU_CHIP_VERSION_OFFSET      0x00000050
+#define MACSYS_GCU_CHIP_VERSION_INDEX       0x00000014
+#define MACSYS_GCU_CHIP_VERSION_RESET       0x008000B0
+
+static inline u8 macsys_gcu_chip_version_step_id_getf(struct cl_chip *chip)
+{
+	u32 local_val = cl_reg_read_chip(chip, MACSYS_GCU_CHIP_VERSION_ADDR);
+
+	return ((local_val & ((u32)0x000000F0)) >> 4);
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
+#define MACSYS_GCU_XT_CONTROL_ADDR        (REG_MACSYS_GCU_BASE_ADDR + 0x000000F0)
+#define MACSYS_GCU_XT_CONTROL_OFFSET      0x000000F0
+#define MACSYS_GCU_XT_CONTROL_INDEX       0x0000003C
+#define MACSYS_GCU_XT_CONTROL_RESET       0x000A0A0A
+
+static inline u32 macsys_gcu_xt_control_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, MACSYS_GCU_XT_CONTROL_ADDR);
+}
+
+static inline void macsys_gcu_xt_control_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, MACSYS_GCU_XT_CONTROL_ADDR, value);
+}
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
+	cl_reg_write(cl_hw, MODEM_GCU_MPU_ADDR, value);
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
+	cl_reg_write(cl_hw, MODEM_GCU_BPU_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_BPU_BPUL_RX_CLK_F_BIT     ((u32)0x01000000)
+#define MODEM_GCU_BPU_BPUL_RX_CLK_F_POS     24
+#define MODEM_GCU_BPU_CLK_F_BIT         ((u32)0x00800000)
+#define MODEM_GCU_BPU_CLK_F_POS         23
+#define MODEM_GCU_BPU_RX_CLK_F_BIT      ((u32)0x00400000)
+#define MODEM_GCU_BPU_RX_CLK_F_POS      22
+#define MODEM_GCU_BPU_TX_CLK_F_BIT      ((u32)0x00200000)
+#define MODEM_GCU_BPU_TX_CLK_F_POS      21
+#define MODEM_GCU_BPU_REG_CLK_F_BIT     ((u32)0x00100000)
+#define MODEM_GCU_BPU_REG_CLK_F_POS     20
+#define MODEM_GCU_BPU_BPUL_RX_CLK_EN_BIT    ((u32)0x00010000)
+#define MODEM_GCU_BPU_BPUL_RX_CLK_EN_POS    16
+#define MODEM_GCU_BPU_CLK_EN_BIT        ((u32)0x00008000)
+#define MODEM_GCU_BPU_CLK_EN_POS        15
+#define MODEM_GCU_BPU_RX_CLK_EN_BIT     ((u32)0x00004000)
+#define MODEM_GCU_BPU_RX_CLK_EN_POS     14
+#define MODEM_GCU_BPU_TX_CLK_EN_BIT     ((u32)0x00002000)
+#define MODEM_GCU_BPU_TX_CLK_EN_POS     13
+#define MODEM_GCU_BPU_REG_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_BPU_REG_CLK_EN_POS    12
+#define MODEM_GCU_BPU_RST_N_BIT         ((u32)0x00000008)
+#define MODEM_GCU_BPU_RST_N_POS         3
+#define MODEM_GCU_BPU_RX_RST_N_BIT      ((u32)0x00000004)
+#define MODEM_GCU_BPU_RX_RST_N_POS      2
+#define MODEM_GCU_BPU_TX_RST_N_BIT      ((u32)0x00000002)
+#define MODEM_GCU_BPU_TX_RST_N_POS      1
+#define MODEM_GCU_BPU_REG_RST_N_BIT     ((u32)0x00000001)
+#define MODEM_GCU_BPU_REG_RST_N_POS     0
+
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
+	cl_reg_write(cl_hw, MODEM_GCU_TFU_ADDR, value);
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
+	cl_reg_write(cl_hw, MODEM_GCU_SMU_ADDR, value);
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
+#define MODEM_GCU_MUX_FIC_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000014)
+#define MODEM_GCU_MUX_FIC_OFFSET      0x00000014
+#define MODEM_GCU_MUX_FIC_INDEX       0x00000005
+#define MODEM_GCU_MUX_FIC_RESET       0x00000002
+
+static inline void modem_gcu_mux_fic_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_MUX_FIC_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_MUX_FIC_CLK_F_BIT    ((u32)0x00100000)
+#define MODEM_GCU_MUX_FIC_CLK_F_POS    20
+#define MODEM_GCU_MUX_FIC_CLK_EN_BIT    ((u32)0x00001000)
+#define MODEM_GCU_MUX_FIC_CLK_EN_POS    12
+#define MODEM_GCU_MUX_FIC_SOFT_RST_N_BIT    ((u32)0x00000002)
+#define MODEM_GCU_MUX_FIC_SOFT_RST_N_POS    1
+#define MODEM_GCU_MUX_FIC_RST_N_BIT    ((u32)0x00000001)
+#define MODEM_GCU_MUX_FIC_RST_N_POS    0
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
+#define MODEM_GCU_MUX_FIC_CONFIG_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x0000001C)
+#define MODEM_GCU_MUX_FIC_CONFIG_OFFSET      0x0000001C
+#define MODEM_GCU_MUX_FIC_CONFIG_INDEX       0x00000007
+#define MODEM_GCU_MUX_FIC_CONFIG_RESET       0x00000000
+
+static inline void modem_gcu_mux_fic_config_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR, value);
+}
+
+static inline u8 modem_gcu_mux_fic_config_fic_isolated_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR);
+
+	return ((local_val & ((u32)0x80000000)) >> 31);
+}
+
+static inline void modem_gcu_mux_fic_config_fic_isolate_setf(struct cl_hw *cl_hw, u8 ficisolate)
+{
+	ASSERT_ERR((((u32)ficisolate << 17) & ~((u32)0x00020000)) == 0);
+	cl_reg_write(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR,
+		     (cl_reg_read(cl_hw, MODEM_GCU_MUX_FIC_CONFIG_ADDR) & ~((u32)0x00020000)) |
+		     ((u32)ficisolate << 17));
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
+#define MODEM_GCU_RIU_RST_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000020)
+#define MODEM_GCU_RIU_RST_OFFSET      0x00000020
+#define MODEM_GCU_RIU_RST_INDEX       0x00000008
+#define MODEM_GCU_RIU_RST_RESET       0x00000000
+
+static inline void modem_gcu_riu_rst_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_RIU_RST_ADDR, value);
+}
+
+/* Field definitions */
+#define MODEM_GCU_RIU_FE_RST_N_BIT    ((u32)0x00000080)
+#define MODEM_GCU_RIU_FE_RST_N_POS    7
+#define MODEM_GCU_RIU_AGC_RST_N_BIT    ((u32)0x00000040)
+#define MODEM_GCU_RIU_AGC_RST_N_POS    6
+#define MODEM_GCU_RIU_MDM_B_RST_N_BIT    ((u32)0x00000020)
+#define MODEM_GCU_RIU_MDM_B_RST_N_POS    5
+#define MODEM_GCU_RIU_LB_RST_N_BIT    ((u32)0x00000010)
+#define MODEM_GCU_RIU_LB_RST_N_POS    4
+#define MODEM_GCU_RIU_RC_RST_N_BIT    ((u32)0x00000008)
+#define MODEM_GCU_RIU_RC_RST_N_POS    3
+#define MODEM_GCU_RIU_RADAR_RST_N_BIT    ((u32)0x00000004)
+#define MODEM_GCU_RIU_RADAR_RST_N_POS    2
+#define MODEM_GCU_RIU_RST_N_BIT     ((u32)0x00000002)
+#define MODEM_GCU_RIU_RST_N_POS     1
+#define MODEM_GCU_RIU_REG_RST_N_BIT    ((u32)0x00000001)
+#define MODEM_GCU_RIU_REG_RST_N_POS    0
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
+#define MODEM_GCU_RIU_CLK_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000024)
+#define MODEM_GCU_RIU_CLK_OFFSET      0x00000024
+#define MODEM_GCU_RIU_CLK_INDEX       0x00000009
+#define MODEM_GCU_RIU_CLK_RESET       0x00000000
+
+static inline void modem_gcu_riu_clk_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_ADDR, value);
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
+	cl_reg_write(cl_hw, MODEM_GCU_SPU_ADDR, value);
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
+	cl_reg_write(cl_hw, MODEM_GCU_LCU_ADDR, value);
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
+	cl_reg_write(cl_hw, MODEM_GCU_EPA_ADDR, value);
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
+	cl_reg_write(cl_hw, MODEM_GCU_BF_ADDR, value);
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
+#define MODEM_GCU_RIU_CLK_1_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00000124)
+#define MODEM_GCU_RIU_CLK_1_OFFSET      0x00000124
+#define MODEM_GCU_RIU_CLK_1_INDEX       0x00000049
+#define MODEM_GCU_RIU_CLK_1_RESET       0x00000000
+
+static inline void modem_gcu_riu_clk_1_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_1_ADDR, value);
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
+#define MODEM_GCU_CEVA_CTRL_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00001004)
+#define MODEM_GCU_CEVA_CTRL_OFFSET      0x00001004
+#define MODEM_GCU_CEVA_CTRL_INDEX       0x00000401
+#define MODEM_GCU_CEVA_CTRL_RESET       0x00000004
+
+static inline void modem_gcu_ceva_ctrl_external_wait_setf(struct cl_hw *cl_hw, u8 externalwait)
+{
+	ASSERT_ERR((((u32)externalwait << 2) & ~((u32)0x00000004)) == 0);
+	cl_reg_write(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR,
+		     (cl_reg_read(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR) & ~((u32)0x00000004)) |
+		     ((u32)externalwait << 2));
+}
+
+static inline void modem_gcu_ceva_ctrl_boot_setf(struct cl_hw *cl_hw, u8 boot)
+{
+	ASSERT_ERR((((u32)boot << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR,
+		     (cl_reg_read(cl_hw, MODEM_GCU_CEVA_CTRL_ADDR) & ~((u32)0x00000001)) |
+		     ((u32)boot << 0));
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
+#define MODEM_GCU_CEVA_VEC_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00001008)
+#define MODEM_GCU_CEVA_VEC_OFFSET      0x00001008
+#define MODEM_GCU_CEVA_VEC_INDEX       0x00000402
+#define MODEM_GCU_CEVA_VEC_RESET       0x00000000
+
+static inline void modem_gcu_ceva_vec_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_CEVA_VEC_ADDR, value);
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
+#define MODEM_GCU_RIU_CLK_BW_ADDR        (REG_MODEM_GCU_BASE_ADDR + 0x00001240)
+#define MODEM_GCU_RIU_CLK_BW_OFFSET      0x00001240
+#define MODEM_GCU_RIU_CLK_BW_INDEX       0x00000490
+#define MODEM_GCU_RIU_CLK_BW_RESET       0x000009AA
+
+static inline void modem_gcu_riu_clk_bw_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_BW_ADDR, value);
+}
+
+static inline void modem_gcu_riu_clk_bw_agc_mem_clk_bw_setf(struct cl_hw *cl_hw, u8 agcmemclkbw)
+{
+	ASSERT_ERR((((u32)agcmemclkbw << 8) & ~((u32)0x00000300)) == 0);
+	cl_reg_write(cl_hw, MODEM_GCU_RIU_CLK_BW_ADDR,
+		     (cl_reg_read(cl_hw, MODEM_GCU_RIU_CLK_BW_ADDR) & ~((u32)0x00000300)) |
+		     ((u32)agcmemclkbw << 8));
+}
+
+/*
+ * @brief STATIC_CONF_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30    ARB_ONESHOT_BYPASS        1
+ *    28    BTC_SEL                   0
+ *    27    CLK_SAVE_MODE             0
+ *    26    RF_RST_N_DEFAULT          0
+ *    25    RF_RST_N_REQ              0
+ *    24    FORCE_RSSI_ON             0
+ *    23:20 RSSI_M                    0x2
+ *    19:16 RSSI_N                    0x6
+ *    03:00 CDB_MODE_MAJ              0x0
+ * </pre>
+ */
+#define RICU_STATIC_CONF_0_ADDR        (REG_RICU_BASE_ADDR + 0x00000004)
+#define RICU_STATIC_CONF_0_OFFSET      0x00000004
+#define RICU_STATIC_CONF_0_INDEX       0x00000001
+#define RICU_STATIC_CONF_0_RESET       0x40260000
+
+static inline void ricu_static_conf_0_btc_sel_setf(struct cl_chip *chip, u8 btcsel)
+{
+	ASSERT_ERR_CHIP((((u32)btcsel << 28) & ~((u32)0x10000000)) == 0);
+	cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x10000000)) |
+			  ((u32)btcsel << 28));
+}
+
+static inline void ricu_static_conf_0_clk_save_mode_setf(struct cl_chip *chip, u8 clksavemode)
+{
+	ASSERT_ERR_CHIP((((u32)clksavemode << 27) & ~((u32)0x08000000)) == 0);
+	cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x08000000)) |
+			  ((u32)clksavemode << 27));
+}
+
+static inline void ricu_static_conf_0_rf_rst_n_req_setf(struct cl_chip *chip, u8 rfrstnreq)
+{
+	ASSERT_ERR_CHIP((((u32)rfrstnreq << 25) & ~((u32)0x02000000)) == 0);
+	cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x02000000)) |
+			  ((u32)rfrstnreq << 25));
+}
+
+static inline u8 ricu_static_conf_0_cdb_mode_maj_getf(struct cl_chip *chip)
+{
+	u32 local_val = cl_reg_read_chip(chip, RICU_STATIC_CONF_0_ADDR);
+
+	return ((local_val & ((u32)0x0000000F)) >> 0);
+}
+
+static inline void ricu_static_conf_0_cdb_mode_maj_setf(struct cl_chip *chip, u8 cdbmodemaj)
+{
+	ASSERT_ERR_CHIP((((u32)cdbmodemaj << 0) & ~((u32)0x0000000F)) == 0);
+	cl_reg_write_chip(chip, RICU_STATIC_CONF_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_STATIC_CONF_0_ADDR) & ~((u32)0x0000000F)) |
+			  ((u32)cdbmodemaj << 0));
+}
+
+/*
+ * @brief AFE_CTL_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    PBIAS_CTRL_EN_LC          0
+ *    30    PBIAS_CTRL_EN             0
+ *    29    LRD_EN_LC                 0
+ *    28    LRD_EN                    0
+ *    27    LOCK_EN_LC                0
+ *    26    LOCK_EN                   1
+ *    25    EN_GPADC_CLK              0
+ *    24    EN_GPADC                  0
+ *    23    FEED_EN_LC                0
+ *    22    FEED_EN                   0
+ *    21    EN_CS                     1
+ *    20    EN_CML_GEN                1
+ *    18    EN_AFE_LDO                1
+ *    17    EN_ADC_CLK                1
+ *    15    AFC_ENB_LC                0
+ *    14    AFC_ENB                   0
+ *    13    CP_MODE_LC                1
+ *    12    BYPASS_LC                 0
+ *    11    BYPASS                    0
+ *    10    AFCINIT_SEL_LC            1
+ *    09    AFCINIT_SEL               1
+ *    08    EN_CLK_MON                0
+ *    07    EN_DAC_CLK                1
+ *    06    EN_CDB_DAC_CLK            0
+ *    05    EN_CDB_ADC_CLK            0
+ *    03    EN_CDB_GEN                0
+ *    02    DACCLK_PHASESEL           0
+ *    01    ADCCLK_PHASESEL           0
+ *    00    CDB_CLK_RESETB            0
+ * </pre>
+ */
+#define RICU_AFE_CTL_0_ADDR        (REG_RICU_BASE_ADDR + 0x00000010)
+#define RICU_AFE_CTL_0_OFFSET      0x00000010
+#define RICU_AFE_CTL_0_INDEX       0x00000004
+#define RICU_AFE_CTL_0_RESET       0x04362680
+
+static inline u32 ricu_afe_ctl_0_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTL_0_ADDR);
+}
+
+static inline void ricu_afe_ctl_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR, value);
+}
+
+static inline void ricu_afe_ctl_0_lock_en_lc_setf(struct cl_chip *chip, u8 lockenlc)
+{
+	ASSERT_ERR_CHIP((((u32)lockenlc << 27) & ~((u32)0x08000000)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_0_ADDR) & ~((u32)0x08000000)) |
+			  ((u32)lockenlc << 27));
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_LC_BIT    ((u32)0x80000000)
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_LC_POS    31
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_BIT    ((u32)0x40000000)
+#define RICU_AFE_CTL_0_PBIAS_CTRL_EN_POS    30
+#define RICU_AFE_CTL_0_LRD_EN_LC_BIT        ((u32)0x20000000)
+#define RICU_AFE_CTL_0_LRD_EN_LC_POS        29
+#define RICU_AFE_CTL_0_LRD_EN_BIT           ((u32)0x10000000)
+#define RICU_AFE_CTL_0_LRD_EN_POS           28
+#define RICU_AFE_CTL_0_LOCK_EN_LC_BIT       ((u32)0x08000000)
+#define RICU_AFE_CTL_0_LOCK_EN_LC_POS       27
+#define RICU_AFE_CTL_0_LOCK_EN_BIT          ((u32)0x04000000)
+#define RICU_AFE_CTL_0_LOCK_EN_POS          26
+#define RICU_AFE_CTL_0_EN_GPADC_CLK_BIT     ((u32)0x02000000)
+#define RICU_AFE_CTL_0_EN_GPADC_CLK_POS     25
+#define RICU_AFE_CTL_0_EN_GPADC_BIT         ((u32)0x01000000)
+#define RICU_AFE_CTL_0_EN_GPADC_POS         24
+#define RICU_AFE_CTL_0_FEED_EN_LC_BIT       ((u32)0x00800000)
+#define RICU_AFE_CTL_0_FEED_EN_LC_POS       23
+#define RICU_AFE_CTL_0_FEED_EN_BIT          ((u32)0x00400000)
+#define RICU_AFE_CTL_0_FEED_EN_POS          22
+#define RICU_AFE_CTL_0_EN_CS_BIT            ((u32)0x00200000)
+#define RICU_AFE_CTL_0_EN_CS_POS            21
+#define RICU_AFE_CTL_0_EN_CML_GEN_BIT       ((u32)0x00100000)
+#define RICU_AFE_CTL_0_EN_CML_GEN_POS       20
+#define RICU_AFE_CTL_0_EN_AFE_LDO_BIT       ((u32)0x00040000)
+#define RICU_AFE_CTL_0_EN_AFE_LDO_POS       18
+#define RICU_AFE_CTL_0_EN_ADC_CLK_BIT       ((u32)0x00020000)
+#define RICU_AFE_CTL_0_EN_ADC_CLK_POS       17
+#define RICU_AFE_CTL_0_AFC_ENB_LC_BIT       ((u32)0x00008000)
+#define RICU_AFE_CTL_0_AFC_ENB_LC_POS       15
+#define RICU_AFE_CTL_0_AFC_ENB_BIT          ((u32)0x00004000)
+#define RICU_AFE_CTL_0_AFC_ENB_POS          14
+#define RICU_AFE_CTL_0_CP_MODE_LC_BIT       ((u32)0x00002000)
+#define RICU_AFE_CTL_0_CP_MODE_LC_POS       13
+#define RICU_AFE_CTL_0_BYPASS_LC_BIT        ((u32)0x00001000)
+#define RICU_AFE_CTL_0_BYPASS_LC_POS        12
+#define RICU_AFE_CTL_0_BYPASS_BIT           ((u32)0x00000800)
+#define RICU_AFE_CTL_0_BYPASS_POS           11
+#define RICU_AFE_CTL_0_AFCINIT_SEL_LC_BIT    ((u32)0x00000400)
+#define RICU_AFE_CTL_0_AFCINIT_SEL_LC_POS    10
+#define RICU_AFE_CTL_0_AFCINIT_SEL_BIT      ((u32)0x00000200)
+#define RICU_AFE_CTL_0_AFCINIT_SEL_POS      9
+#define RICU_AFE_CTL_0_EN_CLK_MON_BIT       ((u32)0x00000100)
+#define RICU_AFE_CTL_0_EN_CLK_MON_POS       8
+#define RICU_AFE_CTL_0_EN_DAC_CLK_BIT       ((u32)0x00000080)
+#define RICU_AFE_CTL_0_EN_DAC_CLK_POS       7
+#define RICU_AFE_CTL_0_EN_CDB_DAC_CLK_BIT    ((u32)0x00000040)
+#define RICU_AFE_CTL_0_EN_CDB_DAC_CLK_POS    6
+#define RICU_AFE_CTL_0_EN_CDB_ADC_CLK_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTL_0_EN_CDB_ADC_CLK_POS    5
+#define RICU_AFE_CTL_0_EN_CDB_GEN_BIT       ((u32)0x00000008)
+#define RICU_AFE_CTL_0_EN_CDB_GEN_POS       3
+#define RICU_AFE_CTL_0_DACCLK_PHASESEL_BIT    ((u32)0x00000004)
+#define RICU_AFE_CTL_0_DACCLK_PHASESEL_POS    2
+#define RICU_AFE_CTL_0_ADCCLK_PHASESEL_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTL_0_ADCCLK_PHASESEL_POS    1
+#define RICU_AFE_CTL_0_CDB_CLK_RESETB_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTL_0_CDB_CLK_RESETB_POS    0
+
+static inline void ricu_afe_ctl_0_pbias_ctrl_en_lc_setf(struct cl_chip *chip, u8 pbiasctrlenlc)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_0_ADDR) & ~((u32)0x80000000)) |
+			  ((u32)pbiasctrlenlc << 31));
+}
+
+static inline void ricu_afe_ctl_0_cdb_clk_resetb_setf(struct cl_chip *chip, u8 cdbclkresetb)
+{
+	ASSERT_ERR_CHIP((((u32)cdbclkresetb << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_0_ADDR) & ~((u32)0x00000001)) |
+			  ((u32)cdbclkresetb << 0));
+}
+
+/*
+ * @brief AFE_CTL_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    14    VCO_BOOST                 0
+ *    13    SYS_ADCCLK_SEL            0
+ *    12    SOC_PHASE_SEL             1
+ *    11    SOC_CLK_SEL               1
+ *    10    RESETB_LC                 0
+ *    09    RESETB                    1
+ *    08    PBIAS_CTRL_LC             0
+ *    07    PBIAS_CTRL                0
+ *    06    GP_CLK_PHASESEL           0
+ *    05    FSEL_LC                   0
+ *    04    FSEL                      0
+ *    03    FOUT_MASK_LC              0
+ *    02    FOUT_MASK                 0
+ *    01    EXTCLK_SEL                0
+ *    00    EN_PLL_LDO                0
+ * </pre>
+ */
+#define RICU_AFE_CTL_1_ADDR        (REG_RICU_BASE_ADDR + 0x00000014)
+#define RICU_AFE_CTL_1_OFFSET      0x00000014
+#define RICU_AFE_CTL_1_INDEX       0x00000005
+#define RICU_AFE_CTL_1_RESET       0x00001A00
+
+static inline void ricu_afe_ctl_1_resetb_lc_setf(struct cl_chip *chip, u8 resetblc)
+{
+	ASSERT_ERR_CHIP((((u32)resetblc << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_1_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)resetblc << 10));
+}
+
+static inline void ricu_afe_ctl_1_en_pll_ldo_setf(struct cl_chip *chip, u8 enpllldo)
+{
+	ASSERT_ERR_CHIP((((u32)enpllldo << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_1_ADDR) & ~((u32)0x00000001)) |
+			  ((u32)enpllldo << 0));
+}
+
+/*
+ * @brief AFE_CTL_2 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:22 LOCK_CON_REV_LC           0x0
+ *    21:20 LOCK_CON_REV              0x0
+ *    19:18 LOCK_CON_OUT_LC           0x3
+ *    17:16 LOCK_CON_OUT              0x3
+ *    15:14 LOCK_CON_IN_LC            0x3
+ *    13:12 LOCK_CON_IN               0x3
+ *    11:10 LOCK_CON_DLY_LC           0x3
+ *    09:08 LOCK_CON_DLY              0x3
+ *    07:06 ICP                       0x1
+ *    03:02 CTRL_IB                   0x2
+ *    01:00 CLK_MON_SEL               0x0
+ * </pre>
+ */
+#define RICU_AFE_CTL_2_ADDR        (REG_RICU_BASE_ADDR + 0x00000018)
+#define RICU_AFE_CTL_2_OFFSET      0x00000018
+#define RICU_AFE_CTL_2_INDEX       0x00000006
+#define RICU_AFE_CTL_2_RESET       0x000FFF48
+
+static inline void ricu_afe_ctl_2_lock_con_rev_lc_setf(struct cl_chip *chip, u8 lockconrevlc)
+{
+	ASSERT_ERR_CHIP((((u32)lockconrevlc << 22) & ~((u32)0x00C00000)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_2_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_2_ADDR) & ~((u32)0x00C00000)) |
+			  ((u32)lockconrevlc << 22));
+}
+
+/*
+ * @brief AFE_CTL_3 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:28 RSEL                      0x0
+ *    27:24 I_CSEL_LC                 0xc
+ *    23:20 GM_LC                     0xf
+ *    19:16 CSEL_LC                   0x3
+ *    15:12 CML_SEL                   0x9
+ *    11:09 S_LC                      0x0
+ *    08:06 S                         0x0
+ *    05:03 LBW_LC                    0x7
+ *    02:00 ICP_LC                    0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_3_ADDR        (REG_RICU_BASE_ADDR + 0x0000001C)
+#define RICU_AFE_CTL_3_OFFSET      0x0000001C
+#define RICU_AFE_CTL_3_INDEX       0x00000007
+#define RICU_AFE_CTL_3_RESET       0x0CF3903F
+
+static inline void ricu_afe_ctl_3_cml_sel_setf(struct cl_chip *chip, u8 cmlsel)
+{
+	ASSERT_ERR_CHIP((((u32)cmlsel << 12) & ~((u32)0x0000F000)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_3_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_3_ADDR) & ~((u32)0x0000F000)) |
+			  ((u32)cmlsel << 12));
+}
+
+/*
+ * @brief AFE_CTL_5 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:18 MAIN_SEL_7_2              0x0
+ *    17:12 P_LC                      0x1
+ *    11:06 P                         0xA
+ *    05:00 CAP_BIAS_CODE_LC          0x4
+ * </pre>
+ */
+#define RICU_AFE_CTL_5_ADDR        (REG_RICU_BASE_ADDR + 0x00000024)
+#define RICU_AFE_CTL_5_OFFSET      0x00000024
+#define RICU_AFE_CTL_5_INDEX       0x00000009
+#define RICU_AFE_CTL_5_RESET       0x00001284
+
+static inline void ricu_afe_ctl_5_main_sel_7_2_setf(struct cl_chip *chip, u8 mainsel72)
+{
+	ASSERT_ERR_CHIP((((u32)mainsel72 << 18) & ~((u32)0x00FC0000)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_5_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTL_5_ADDR) & ~((u32)0x00FC0000)) |
+			  ((u32)mainsel72 << 18));
+}
+
+/*
+ * @brief AFE_CTL_8 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    EN_REF7                   0
+ *    30    EN_REF6                   0
+ *    29    EN_REF5                   0
+ *    28    EN_REF4                   0
+ *    27    EN_REF3                   0
+ *    26    EN_REF2                   0
+ *    25    EN_REF1                   0
+ *    24    EN_REF0                   0
+ *    23    EN_EXT_LOAD7              0
+ *    22    EN_EXT_LOAD6              0
+ *    21    EN_EXT_LOAD5              0
+ *    20    EN_EXT_LOAD4              0
+ *    19    EN_EXT_LOAD3              0
+ *    18    EN_EXT_LOAD2              0
+ *    17    EN_EXT_LOAD1              0
+ *    16    EN_EXT_LOAD0              0
+ *    15    CH_CML_SEL7               0
+ *    14    CH_CML_SEL6               0
+ *    13    CH_CML_SEL5               0
+ *    12    CH_CML_SEL4               0
+ *    11    CH_CML_SEL3               0
+ *    10    CH_CML_SEL2               0
+ *    09    CH_CML_SEL1               0
+ *    08    CH_CML_SEL0               0
+ *    07    EN_BGR7                   0
+ *    06    EN_BGR6                   0
+ *    05    EN_BGR5                   0
+ *    04    EN_BGR4                   0
+ *    03    EN_BGR3                   0
+ *    02    EN_BGR2                   0
+ *    01    EN_BGR1                   0
+ *    00    EN_BGR0                   0
+ * </pre>
+ */
+#define RICU_AFE_CTL_8_ADDR        (REG_RICU_BASE_ADDR + 0x00000030)
+#define RICU_AFE_CTL_8_OFFSET      0x00000030
+#define RICU_AFE_CTL_8_INDEX       0x0000000C
+#define RICU_AFE_CTL_8_RESET       0x00000000
+
+static inline u32 ricu_afe_ctl_8_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTL_8_ADDR);
+}
+
+static inline void ricu_afe_ctl_8_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_8_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_8_EN_REF_7_BIT         ((u32)0x80000000)
+#define RICU_AFE_CTL_8_EN_REF_7_POS         31
+#define RICU_AFE_CTL_8_EN_REF_6_BIT         ((u32)0x40000000)
+#define RICU_AFE_CTL_8_EN_REF_6_POS         30
+#define RICU_AFE_CTL_8_EN_REF_5_BIT         ((u32)0x20000000)
+#define RICU_AFE_CTL_8_EN_REF_5_POS         29
+#define RICU_AFE_CTL_8_EN_REF_4_BIT         ((u32)0x10000000)
+#define RICU_AFE_CTL_8_EN_REF_4_POS         28
+#define RICU_AFE_CTL_8_EN_REF_3_BIT         ((u32)0x08000000)
+#define RICU_AFE_CTL_8_EN_REF_3_POS         27
+#define RICU_AFE_CTL_8_EN_REF_2_BIT         ((u32)0x04000000)
+#define RICU_AFE_CTL_8_EN_REF_2_POS         26
+#define RICU_AFE_CTL_8_EN_REF_1_BIT         ((u32)0x02000000)
+#define RICU_AFE_CTL_8_EN_REF_1_POS         25
+#define RICU_AFE_CTL_8_EN_REF_0_BIT         ((u32)0x01000000)
+#define RICU_AFE_CTL_8_EN_REF_0_POS         24
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_7_BIT    ((u32)0x00800000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_7_POS    23
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_6_BIT    ((u32)0x00400000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_6_POS    22
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_5_BIT    ((u32)0x00200000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_5_POS    21
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_4_BIT    ((u32)0x00100000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_4_POS    20
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_3_BIT    ((u32)0x00080000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_3_POS    19
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_2_BIT    ((u32)0x00040000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_2_POS    18
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_1_BIT    ((u32)0x00020000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_1_POS    17
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_0_BIT    ((u32)0x00010000)
+#define RICU_AFE_CTL_8_EN_EXT_LOAD_0_POS    16
+#define RICU_AFE_CTL_8_CH_CML_SEL_7_BIT     ((u32)0x00008000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_7_POS     15
+#define RICU_AFE_CTL_8_CH_CML_SEL_6_BIT     ((u32)0x00004000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_6_POS     14
+#define RICU_AFE_CTL_8_CH_CML_SEL_5_BIT     ((u32)0x00002000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_5_POS     13
+#define RICU_AFE_CTL_8_CH_CML_SEL_4_BIT     ((u32)0x00001000)
+#define RICU_AFE_CTL_8_CH_CML_SEL_4_POS     12
+#define RICU_AFE_CTL_8_CH_CML_SEL_3_BIT     ((u32)0x00000800)
+#define RICU_AFE_CTL_8_CH_CML_SEL_3_POS     11
+#define RICU_AFE_CTL_8_CH_CML_SEL_2_BIT     ((u32)0x00000400)
+#define RICU_AFE_CTL_8_CH_CML_SEL_2_POS     10
+#define RICU_AFE_CTL_8_CH_CML_SEL_1_BIT     ((u32)0x00000200)
+#define RICU_AFE_CTL_8_CH_CML_SEL_1_POS     9
+#define RICU_AFE_CTL_8_CH_CML_SEL_0_BIT     ((u32)0x00000100)
+#define RICU_AFE_CTL_8_CH_CML_SEL_0_POS     8
+#define RICU_AFE_CTL_8_EN_BGR_7_BIT         ((u32)0x00000080)
+#define RICU_AFE_CTL_8_EN_BGR_7_POS         7
+#define RICU_AFE_CTL_8_EN_BGR_6_BIT         ((u32)0x00000040)
+#define RICU_AFE_CTL_8_EN_BGR_6_POS         6
+#define RICU_AFE_CTL_8_EN_BGR_5_BIT         ((u32)0x00000020)
+#define RICU_AFE_CTL_8_EN_BGR_5_POS         5
+#define RICU_AFE_CTL_8_EN_BGR_4_BIT         ((u32)0x00000010)
+#define RICU_AFE_CTL_8_EN_BGR_4_POS         4
+#define RICU_AFE_CTL_8_EN_BGR_3_BIT         ((u32)0x00000008)
+#define RICU_AFE_CTL_8_EN_BGR_3_POS         3
+#define RICU_AFE_CTL_8_EN_BGR_2_BIT         ((u32)0x00000004)
+#define RICU_AFE_CTL_8_EN_BGR_2_POS         2
+#define RICU_AFE_CTL_8_EN_BGR_1_BIT         ((u32)0x00000002)
+#define RICU_AFE_CTL_8_EN_BGR_1_POS         1
+#define RICU_AFE_CTL_8_EN_BGR_0_BIT         ((u32)0x00000001)
+#define RICU_AFE_CTL_8_EN_BGR_0_POS         0
+
+/*
+ * @brief AFE_CTL_9 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    EN_SIN2_BIAS7             1
+ *    30    EN_SIN2_BIAS6             1
+ *    29    EN_SIN2_BIAS5             1
+ *    28    EN_SIN2_BIAS4             1
+ *    27    EN_SIN2_BIAS3             1
+ *    26    EN_SIN2_BIAS2             1
+ *    25    EN_SIN2_BIAS1             1
+ *    24    EN_SIN2_BIAS0             1
+ *    23    EN_DAC_REF7               0
+ *    22    EN_DAC_REF6               0
+ *    21    EN_DAC_REF5               0
+ *    20    EN_DAC_REF4               0
+ *    19    EN_DAC_REF3               0
+ *    18    EN_DAC_REF2               0
+ *    17    EN_DAC_REF1               0
+ *    16    EN_DAC_REF0               0
+ * </pre>
+ */
+#define RICU_AFE_CTL_9_ADDR        (REG_RICU_BASE_ADDR + 0x00000034)
+#define RICU_AFE_CTL_9_OFFSET      0x00000034
+#define RICU_AFE_CTL_9_INDEX       0x0000000D
+#define RICU_AFE_CTL_9_RESET       0xFF000000
+
+static inline u32 ricu_afe_ctl_9_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTL_9_ADDR);
+}
+
+static inline void ricu_afe_ctl_9_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_9_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_7_BIT    ((u32)0x80000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_7_POS    31
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_6_BIT    ((u32)0x40000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_6_POS    30
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_5_BIT    ((u32)0x20000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_5_POS    29
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_4_BIT    ((u32)0x10000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_4_POS    28
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_3_BIT    ((u32)0x08000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_3_POS    27
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_2_BIT    ((u32)0x04000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_2_POS    26
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_1_BIT    ((u32)0x02000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_1_POS    25
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_0_BIT    ((u32)0x01000000)
+#define RICU_AFE_CTL_9_EN_SIN_2_BIAS_0_POS    24
+#define RICU_AFE_CTL_9_EN_DAC_REF_7_BIT     ((u32)0x00800000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_7_POS     23
+#define RICU_AFE_CTL_9_EN_DAC_REF_6_BIT     ((u32)0x00400000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_6_POS     22
+#define RICU_AFE_CTL_9_EN_DAC_REF_5_BIT     ((u32)0x00200000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_5_POS     21
+#define RICU_AFE_CTL_9_EN_DAC_REF_4_BIT     ((u32)0x00100000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_4_POS     20
+#define RICU_AFE_CTL_9_EN_DAC_REF_3_BIT     ((u32)0x00080000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_3_POS     19
+#define RICU_AFE_CTL_9_EN_DAC_REF_2_BIT     ((u32)0x00040000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_2_POS     18
+#define RICU_AFE_CTL_9_EN_DAC_REF_1_BIT     ((u32)0x00020000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_1_POS     17
+#define RICU_AFE_CTL_9_EN_DAC_REF_0_BIT     ((u32)0x00010000)
+#define RICU_AFE_CTL_9_EN_DAC_REF_0_POS     16
+
+/*
+ * @brief AFE_CTL_10 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    VC_LD7                    0
+ *    30    VC_LD6                    0
+ *    29    VC_LD5                    0
+ *    28    VC_LD4                    0
+ *    27    VC_LD3                    0
+ *    26    VC_LD2                    0
+ *    25    VC_LD1                    0
+ *    24    VC_LD0                    0
+ *    23    TWOS7                     0
+ *    22    TWOS6                     0
+ *    21    TWOS5                     0
+ *    20    TWOS4                     0
+ *    19    TWOS3                     0
+ *    18    TWOS2                     0
+ *    17    TWOS1                     0
+ *    16    TWOS0                     0
+ *    07    MINV7                     1
+ *    06    MINV6                     1
+ *    05    MINV5                     1
+ *    04    MINV4                     1
+ *    03    MINV3                     1
+ *    02    MINV2                     1
+ *    01    MINV1                     1
+ *    00    MINV0                     1
+ * </pre>
+ */
+#define RICU_AFE_CTL_10_ADDR        (REG_RICU_BASE_ADDR + 0x00000038)
+#define RICU_AFE_CTL_10_OFFSET      0x00000038
+#define RICU_AFE_CTL_10_INDEX       0x0000000E
+#define RICU_AFE_CTL_10_RESET       0x000000FF
+
+static inline void ricu_afe_ctl_10_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_10_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_12 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:30 EOC_CTRL7                 0x0
+ *    29:28 EOC_CTRL6                 0x0
+ *    27:26 EOC_CTRL5                 0x0
+ *    25:24 EOC_CTRL4                 0x0
+ *    23:22 EOC_CTRL3                 0x0
+ *    21:20 EOC_CTRL2                 0x0
+ *    19:18 EOC_CTRL1                 0x0
+ *    17:16 EOC_CTRL0                 0x0
+ *    15:14 IC_REFSSF7                0x1
+ *    13:12 IC_REFSSF6                0x1
+ *    11:10 IC_REFSSF5                0x1
+ *    09:08 IC_REFSSF4                0x1
+ *    07:06 IC_REFSSF3                0x1
+ *    05:04 IC_REFSSF2                0x1
+ *    03:02 IC_REFSSF1                0x1
+ *    01:00 IC_REFSSF0                0x1
+ * </pre>
+ */
+#define RICU_AFE_CTL_12_ADDR        (REG_RICU_BASE_ADDR + 0x00000040)
+#define RICU_AFE_CTL_12_OFFSET      0x00000040
+#define RICU_AFE_CTL_12_INDEX       0x00000010
+#define RICU_AFE_CTL_12_RESET       0x00005555
+
+static inline void ricu_afe_ctl_12_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_12_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTL_12_EOC_CTRL_7_MASK     ((u32)0xC0000000)
+#define RICU_AFE_CTL_12_EOC_CTRL_7_LSB      30
+#define RICU_AFE_CTL_12_EOC_CTRL_7_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_6_MASK     ((u32)0x30000000)
+#define RICU_AFE_CTL_12_EOC_CTRL_6_LSB      28
+#define RICU_AFE_CTL_12_EOC_CTRL_6_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_5_MASK     ((u32)0x0C000000)
+#define RICU_AFE_CTL_12_EOC_CTRL_5_LSB      26
+#define RICU_AFE_CTL_12_EOC_CTRL_5_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_4_MASK     ((u32)0x03000000)
+#define RICU_AFE_CTL_12_EOC_CTRL_4_LSB      24
+#define RICU_AFE_CTL_12_EOC_CTRL_4_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_3_MASK     ((u32)0x00C00000)
+#define RICU_AFE_CTL_12_EOC_CTRL_3_LSB      22
+#define RICU_AFE_CTL_12_EOC_CTRL_3_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_2_MASK     ((u32)0x00300000)
+#define RICU_AFE_CTL_12_EOC_CTRL_2_LSB      20
+#define RICU_AFE_CTL_12_EOC_CTRL_2_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_1_MASK     ((u32)0x000C0000)
+#define RICU_AFE_CTL_12_EOC_CTRL_1_LSB      18
+#define RICU_AFE_CTL_12_EOC_CTRL_1_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_EOC_CTRL_0_MASK     ((u32)0x00030000)
+#define RICU_AFE_CTL_12_EOC_CTRL_0_LSB      16
+#define RICU_AFE_CTL_12_EOC_CTRL_0_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_7_MASK    ((u32)0x0000C000)
+#define RICU_AFE_CTL_12_IC_REFSSF_7_LSB     14
+#define RICU_AFE_CTL_12_IC_REFSSF_7_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_6_MASK    ((u32)0x00003000)
+#define RICU_AFE_CTL_12_IC_REFSSF_6_LSB     12
+#define RICU_AFE_CTL_12_IC_REFSSF_6_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_5_MASK    ((u32)0x00000C00)
+#define RICU_AFE_CTL_12_IC_REFSSF_5_LSB     10
+#define RICU_AFE_CTL_12_IC_REFSSF_5_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_4_MASK    ((u32)0x00000300)
+#define RICU_AFE_CTL_12_IC_REFSSF_4_LSB     8
+#define RICU_AFE_CTL_12_IC_REFSSF_4_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_3_MASK    ((u32)0x000000C0)
+#define RICU_AFE_CTL_12_IC_REFSSF_3_LSB     6
+#define RICU_AFE_CTL_12_IC_REFSSF_3_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_2_MASK    ((u32)0x00000030)
+#define RICU_AFE_CTL_12_IC_REFSSF_2_LSB     4
+#define RICU_AFE_CTL_12_IC_REFSSF_2_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_1_MASK    ((u32)0x0000000C)
+#define RICU_AFE_CTL_12_IC_REFSSF_1_LSB     2
+#define RICU_AFE_CTL_12_IC_REFSSF_1_WIDTH    ((u32)0x00000002)
+#define RICU_AFE_CTL_12_IC_REFSSF_0_MASK    ((u32)0x00000003)
+#define RICU_AFE_CTL_12_IC_REFSSF_0_LSB     0
+#define RICU_AFE_CTL_12_IC_REFSSF_0_WIDTH    ((u32)0x00000002)
+
+/*
+ * @brief AFE_CTL_13 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31    FORCE_ADC_ON_PHY1         0
+ *    30    FORCE_ADC_ON_PHY0         0
+ *    16    EN_LB8_AUX                0
+ *    15    EN_LB7                    0
+ *    14    EN_LB6                    0
+ *    13    EN_LB5                    0
+ *    12    EN_LB4                    0
+ *    11    EN_LB3                    0
+ *    10    EN_LB2                    0
+ *    09    EN_LB1                    0
+ *    08    EN_LB0                    0
+ * </pre>
+ */
+#define RICU_AFE_CTL_13_ADDR        (REG_RICU_BASE_ADDR + 0x00000044)
+#define RICU_AFE_CTL_13_OFFSET      0x00000044
+#define RICU_AFE_CTL_13_INDEX       0x00000011
+#define RICU_AFE_CTL_13_RESET       0x00000000
+
+static inline void ricu_afe_ctl_13_pack(struct cl_chip *chip, u8 forceadconphy1, u8 forceadconphy0,
+					u8 enlb8aux, u8 enlb7, u8 enlb6, u8 enlb5, u8 enlb4,
+					u8 enlb3, u8 enlb2, u8 enlb1, u8 enlb0)
+{
+	ASSERT_ERR_CHIP((((u32)forceadconphy0 << 30) & ~((u32)0x40000000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb8aux << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb7 << 15) & ~((u32)0x00008000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb6 << 14) & ~((u32)0x00004000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb5 << 13) & ~((u32)0x00002000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb4 << 12) & ~((u32)0x00001000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb3 << 11) & ~((u32)0x00000800)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb2 << 10) & ~((u32)0x00000400)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb1 << 9) & ~((u32)0x00000200)) == 0);
+	ASSERT_ERR_CHIP((((u32)enlb0 << 8) & ~((u32)0x00000100)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_13_ADDR,
+			  ((u32)forceadconphy1 << 31) | ((u32)forceadconphy0 << 30) |
+			  ((u32)enlb8aux << 16) | ((u32)enlb7 << 15) | ((u32)enlb6 << 14) |
+			  ((u32)enlb5 << 13) | ((u32)enlb4 << 12) | ((u32)enlb3 << 11) |
+			  ((u32)enlb2 << 10) | ((u32)enlb1 << 9) | ((u32)enlb0 << 8));
+}
+
+/*
+ * @brief AFE_CTL_15 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 EN_OUT_CM7                0x0
+ *    26:24 EN_OUT_CM6                0x0
+ *    22:20 EN_OUT_CM5                0x0
+ *    18:16 EN_OUT_CM4                0x0
+ *    14:12 EN_OUT_CM3                0x0
+ *    10:08 EN_OUT_CM2                0x0
+ *    06:04 EN_OUT_CM1                0x0
+ *    02:00 EN_OUT_CM0                0x0
+ * </pre>
+ */
+#define RICU_AFE_CTL_15_ADDR        (REG_RICU_BASE_ADDR + 0x0000004C)
+#define RICU_AFE_CTL_15_OFFSET      0x0000004C
+#define RICU_AFE_CTL_15_INDEX       0x00000013
+#define RICU_AFE_CTL_15_RESET       0x00000000
+
+static inline void ricu_afe_ctl_15_pack(struct cl_chip *chip, u8 enoutcm7, u8 enoutcm6,
+					u8 enoutcm5, u8 enoutcm4, u8 enoutcm3,
+					u8 enoutcm2, u8 enoutcm1, u8 enoutcm0)
+{
+	ASSERT_ERR_CHIP((((u32)enoutcm7 << 28) & ~((u32)0x70000000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm6 << 24) & ~((u32)0x07000000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm5 << 20) & ~((u32)0x00700000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm4 << 16) & ~((u32)0x00070000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm3 << 12) & ~((u32)0x00007000)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm2 << 8) & ~((u32)0x00000700)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm1 << 4) & ~((u32)0x00000070)) == 0);
+	ASSERT_ERR_CHIP((((u32)enoutcm0 << 0) & ~((u32)0x00000007)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_15_ADDR,
+			  ((u32)enoutcm7 << 28) | ((u32)enoutcm6 << 24) | ((u32)enoutcm5 << 20) |
+			  ((u32)enoutcm4 << 16) | ((u32)enoutcm3 << 12) | ((u32)enoutcm2 << 8) |
+			  ((u32)enoutcm1 << 4) | ((u32)enoutcm0 << 0));
+}
+
+/*
+ * @brief AFE_CTL_17 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_REF7                   0x1
+ *    26:24 VC_REF6                   0x1
+ *    22:20 VC_REF5                   0x1
+ *    18:16 VC_REF4                   0x1
+ *    14:12 VC_REF3                   0x1
+ *    10:08 VC_REF2                   0x1
+ *    06:04 VC_REF1                   0x1
+ *    02:00 VC_REF0                   0x1
+ * </pre>
+ */
+#define RICU_AFE_CTL_17_ADDR        (REG_RICU_BASE_ADDR + 0x00000054)
+#define RICU_AFE_CTL_17_OFFSET      0x00000054
+#define RICU_AFE_CTL_17_INDEX       0x00000015
+#define RICU_AFE_CTL_17_RESET       0x11111111
+
+static inline void ricu_afe_ctl_17_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_17_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_19 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:28 COMP_CTRL7                0x4
+ *    27:24 COMP_CTRL6                0x4
+ *    23:20 COMP_CTRL5                0x4
+ *    19:16 COMP_CTRL4                0x4
+ *    15:12 COMP_CTRL3                0x4
+ *    11:08 COMP_CTRL2                0x4
+ *    07:04 COMP_CTRL1                0x4
+ *    03:00 COMP_CTRL0                0x4
+ * </pre>
+ */
+#define RICU_AFE_CTL_19_ADDR        (REG_RICU_BASE_ADDR + 0x0000005C)
+#define RICU_AFE_CTL_19_OFFSET      0x0000005C
+#define RICU_AFE_CTL_19_INDEX       0x00000017
+#define RICU_AFE_CTL_19_RESET       0x44444444
+
+static inline void ricu_afe_ctl_19_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_19_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_23 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_LD_AVDI7               0x3
+ *    26:24 VC_LD_AVDI6               0x3
+ *    22:20 VC_LD_AVDI5               0x3
+ *    18:16 VC_LD_AVDI4               0x3
+ *    14:12 VC_LD_AVDI3               0x3
+ *    10:08 VC_LD_AVDI2               0x3
+ *    06:04 VC_LD_AVDI1               0x3
+ *    02:00 VC_LD_AVDI0               0x3
+ * </pre>
+ */
+#define RICU_AFE_CTL_23_ADDR        (REG_RICU_BASE_ADDR + 0x0000006C)
+#define RICU_AFE_CTL_23_OFFSET      0x0000006C
+#define RICU_AFE_CTL_23_INDEX       0x0000001B
+#define RICU_AFE_CTL_23_RESET       0x33333333
+
+static inline void ricu_afe_ctl_23_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_23_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_24 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_LD_AVDQ7               0x3
+ *    26:24 VC_LD_AVDQ6               0x3
+ *    22:20 VC_LD_AVDQ5               0x3
+ *    18:16 VC_LD_AVDQ4               0x3
+ *    14:12 VC_LD_AVDQ3               0x3
+ *    10:08 VC_LD_AVDQ2               0x3
+ *    06:04 VC_LD_AVDQ1               0x3
+ *    02:00 VC_LD_AVDQ0               0x3
+ * </pre>
+ */
+#define RICU_AFE_CTL_24_ADDR        (REG_RICU_BASE_ADDR + 0x00000070)
+#define RICU_AFE_CTL_24_OFFSET      0x00000070
+#define RICU_AFE_CTL_24_INDEX       0x0000001C
+#define RICU_AFE_CTL_24_RESET       0x33333333
+
+static inline void ricu_afe_ctl_24_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_24_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_25 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL0                    0
+ *    14:08 RO_CTRLQ0                 0x7
+ *    06:00 RO_CTRLI0                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_25_ADDR        (REG_RICU_BASE_ADDR + 0x00000074)
+#define RICU_AFE_CTL_25_OFFSET      0x00000074
+#define RICU_AFE_CTL_25_INDEX       0x0000001D
+#define RICU_AFE_CTL_25_RESET       0x00000707
+
+static inline void ricu_afe_ctl_25_pack(struct cl_chip *chip, u8 rosel0, u8 roctrlq0, u8 roctrli0)
+{
+	ASSERT_ERR_CHIP((((u32)rosel0 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq0 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli0 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_25_ADDR,
+			  ((u32)rosel0 << 16) | ((u32)roctrlq0 << 8) | ((u32)roctrli0 << 0));
+}
+
+/*
+ * @brief AFE_CTL_26 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL1                    0
+ *    14:08 RO_CTRLQ1                 0x7
+ *    06:00 RO_CTRLI1                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_26_ADDR        (REG_RICU_BASE_ADDR + 0x00000078)
+#define RICU_AFE_CTL_26_OFFSET      0x00000078
+#define RICU_AFE_CTL_26_INDEX       0x0000001E
+#define RICU_AFE_CTL_26_RESET       0x00000707
+
+static inline void ricu_afe_ctl_26_pack(struct cl_chip *chip, u8 rosel1, u8 roctrlq1, u8 roctrli1)
+{
+	ASSERT_ERR_CHIP((((u32)rosel1 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq1 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli1 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_26_ADDR,
+			  ((u32)rosel1 << 16) | ((u32)roctrlq1 << 8) | ((u32)roctrli1 << 0));
+}
+
+/*
+ * @brief AFE_CTL_27 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL2                    0
+ *    14:08 RO_CTRLQ2                 0x7
+ *    06:00 RO_CTRLI2                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_27_ADDR        (REG_RICU_BASE_ADDR + 0x0000007C)
+#define RICU_AFE_CTL_27_OFFSET      0x0000007C
+#define RICU_AFE_CTL_27_INDEX       0x0000001F
+#define RICU_AFE_CTL_27_RESET       0x00000707
+
+static inline void ricu_afe_ctl_27_pack(struct cl_chip *chip, u8 rosel2, u8 roctrlq2, u8 roctrli2)
+{
+	ASSERT_ERR_CHIP((((u32)rosel2 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq2 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli2 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_27_ADDR,
+			  ((u32)rosel2 << 16) | ((u32)roctrlq2 << 8) | ((u32)roctrli2 << 0));
+}
+
+/*
+ * @brief AFE_CTL_29 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_CML7_I                 0x5
+ *    26:24 VC_CML6_I                 0x5
+ *    22:20 VC_CML5_I                 0x5
+ *    18:16 VC_CML4_I                 0x5
+ *    14:12 VC_CML3_I                 0x5
+ *    10:08 VC_CML2_I                 0x5
+ *    06:04 VC_CML1_I                 0x5
+ *    02:00 VC_CML0_I                 0x5
+ * </pre>
+ */
+#define RICU_AFE_CTL_29_ADDR        (REG_RICU_BASE_ADDR + 0x00000084)
+#define RICU_AFE_CTL_29_OFFSET      0x00000084
+#define RICU_AFE_CTL_29_INDEX       0x00000021
+#define RICU_AFE_CTL_29_RESET       0x55555555
+
+static inline void ricu_afe_ctl_29_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_29_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_30 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    30:28 VC_CML7_Q                 0x5
+ *    26:24 VC_CML6_Q                 0x5
+ *    22:20 VC_CML5_Q                 0x5
+ *    18:16 VC_CML4_Q                 0x5
+ *    14:12 VC_CML3_Q                 0x5
+ *    10:08 VC_CML2_Q                 0x5
+ *    06:04 VC_CML1_Q                 0x5
+ *    02:00 VC_CML0_Q                 0x5
+ * </pre>
+ */
+#define RICU_AFE_CTL_30_ADDR        (REG_RICU_BASE_ADDR + 0x00000088)
+#define RICU_AFE_CTL_30_OFFSET      0x00000088
+#define RICU_AFE_CTL_30_INDEX       0x00000022
+#define RICU_AFE_CTL_30_RESET       0x55555555
+
+static inline void ricu_afe_ctl_30_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTL_30_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTL_33 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL3                    0
+ *    14:08 RO_CTRL3_Q                0x7
+ *    06:00 RO_CTRL3_I                0x7
+ * </pre>
+ */
+#define RICU_AFE_CTL_33_ADDR        (REG_RICU_BASE_ADDR + 0x00000094)
+#define RICU_AFE_CTL_33_OFFSET      0x00000094
+#define RICU_AFE_CTL_33_INDEX       0x00000025
+#define RICU_AFE_CTL_33_RESET       0x00000707
+
+static inline void ricu_afe_ctl_33_pack(struct cl_chip *chip, u8 rosel3, u8 roctrl3q, u8 roctrl3i)
+{
+	ASSERT_ERR_CHIP((((u32)rosel3 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrl3q << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrl3i << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTL_33_ADDR,
+			  ((u32)rosel3 << 16) | ((u32)roctrl3q << 8) | ((u32)roctrl3i << 0));
+}
+
+/*
+ * @brief AFE_CTRL_34_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY0_ADC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY0_ADC_SB_RD_DELAY      0x4
+ *    01:00 PHY0_ADC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_34_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x0000009C)
+#define RICU_AFE_CTRL_34_PHY_0_OFFSET      0x0000009C
+#define RICU_AFE_CTRL_34_PHY_0_INDEX       0x00000027
+#define RICU_AFE_CTRL_34_PHY_0_RESET       0x00000010
+
+static inline
+void ricu_afe_ctrl_34_phy_0_adc_sb_ignore_fifo_indication_setf(struct cl_chip *chip,
+							       u8 phy0adcsbignorefifoindication)
+{
+	ASSERT_ERR_CHIP((((u32)phy0adcsbignorefifoindication << 6) & ~((u32)0x00000040)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR) &
+			   ~((u32)0x00000040)) | ((u32)phy0adcsbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_34_phy_0_adc_sb_rd_delay_setf(struct cl_chip *chip,
+							       u8 phy0adcsbrddelay)
+{
+	ASSERT_ERR_CHIP((((u32)phy0adcsbrddelay << 2) & ~((u32)0x0000003C)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_34_PHY_0_ADDR) &
+			   ~((u32)0x0000003C)) | ((u32)phy0adcsbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_36_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    07    PHY0_ADC_ALWAYS_EN_LD_IR  0
+ *    06    PHY0_ADC_ALWAYS_EN_LD_AVDQ 0
+ *    05    PHY0_ADC_ALWAYS_EN_LD_AVDI 0
+ *    04    PHY0_ADC_ALWAYS_EN_ADCQ   0
+ *    03    PHY0_ADC_ALWAYS_EN_ADCI   0
+ *    01    PHY0_HW_MODE_DAC          0
+ *    00    PHY0_HW_MODE_ADC          0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_36_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000A0)
+#define RICU_AFE_CTRL_36_PHY_0_OFFSET      0x000000A0
+#define RICU_AFE_CTRL_36_PHY_0_INDEX       0x00000028
+#define RICU_AFE_CTRL_36_PHY_0_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_36_phy_0_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR);
+}
+
+static inline void ricu_afe_ctrl_36_phy_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_BIT    ((u32)0x00000080)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_IR_POS    7
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_BIT    ((u32)0x00000040)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDQ_POS    6
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_LD_AVDI_POS    5
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCQ_POS    4
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_36_PHY_0_ADC_ALWAYS_EN_ADCI_POS    3
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_DAC_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_DAC_POS    1
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_ADC_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_36_PHY_0_HW_MODE_ADC_POS    0
+
+static inline void ricu_afe_ctrl_36_phy_0_hw_mode_dac_setf(struct cl_chip *chip, u8 phy0hwmodedac)
+{
+	ASSERT_ERR_CHIP((((u32)phy0hwmodedac << 1) & ~((u32)0x00000002)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR) &
+			   ~((u32)0x00000002)) | ((u32)phy0hwmodedac << 1));
+}
+
+static inline void ricu_afe_ctrl_36_phy_0_hw_mode_adc_setf(struct cl_chip *chip, u8 phy0hwmodeadc)
+{
+	ASSERT_ERR_CHIP((((u32)phy0hwmodeadc << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_0_ADDR) &
+			   ~((u32)0x00000001)) | ((u32)phy0hwmodeadc << 0));
+}
+
+/*
+ * @brief AFE_CTRL_34_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY1_ADC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY1_ADC_SB_RD_DELAY      0x4
+ *    01:00 PHY1_ADC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_34_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000A4)
+#define RICU_AFE_CTRL_34_PHY_1_OFFSET      0x000000A4
+#define RICU_AFE_CTRL_34_PHY_1_INDEX       0x00000029
+#define RICU_AFE_CTRL_34_PHY_1_RESET       0x00000010
+
+static inline
+void ricu_afe_ctrl_34_phy_1_adc_sb_ignore_fifo_indication_setf(struct cl_chip *chip,
+							       u8 phy1adcsbignorefifoindication)
+{
+	ASSERT_ERR_CHIP((((u32)phy1adcsbignorefifoindication << 6) & ~((u32)0x00000040)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR) &
+			   ~((u32)0x00000040)) | ((u32)phy1adcsbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_34_phy_1_adc_sb_rd_delay_setf(struct cl_chip *chip,
+							       u8 phy1adcsbrddelay)
+{
+	ASSERT_ERR_CHIP((((u32)phy1adcsbrddelay << 2) & ~((u32)0x0000003C)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_34_PHY_1_ADDR) &
+			   ~((u32)0x0000003C)) | ((u32)phy1adcsbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_35_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY0_DAC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY0_DAC_SB_RD_DELAY      0x1
+ *    01:00 PHY0_DAC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_35_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000A8)
+#define RICU_AFE_CTRL_35_PHY_0_OFFSET      0x000000A8
+#define RICU_AFE_CTRL_35_PHY_0_INDEX       0x0000002A
+#define RICU_AFE_CTRL_35_PHY_0_RESET       0x00000004
+
+static inline
+void ricu_afe_ctrl_35_phy_0_dac_sb_ignore_fifo_indication_setf(struct cl_chip *chip,
+							       u8 phy0dacsbignorefifoindication)
+{
+	ASSERT_ERR_CHIP((((u32)phy0dacsbignorefifoindication << 6) & ~((u32)0x00000040)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR) &
+			   ~((u32)0x00000040)) | ((u32)phy0dacsbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_35_phy_0_dac_sb_rd_delay_setf(struct cl_chip *chip,
+							       u8 phy0dacsbrddelay)
+{
+	ASSERT_ERR_CHIP((((u32)phy0dacsbrddelay << 2) & ~((u32)0x0000003C)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_35_PHY_0_ADDR) &
+			   ~((u32)0x0000003C)) | ((u32)phy0dacsbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_35_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    06    PHY1_DAC_SB_IGNORE_FIFO_INDICATION 0
+ *    05:02 PHY1_DAC_SB_RD_DELAY      0x1
+ *    01:00 PHY1_DAC_SB_MODE          0x0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_35_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000AC)
+#define RICU_AFE_CTRL_35_PHY_1_OFFSET      0x000000AC
+#define RICU_AFE_CTRL_35_PHY_1_INDEX       0x0000002B
+#define RICU_AFE_CTRL_35_PHY_1_RESET       0x00000004
+
+static inline
+void ricu_afe_ctrl_35_phy_1_dac_sb_ignore_fifo_indication_setf(struct cl_chip *chip,
+							       u8 phy1dacsbignorefifoindication)
+{
+	ASSERT_ERR_CHIP((((u32)phy1dacsbignorefifoindication << 6) & ~((u32)0x00000040)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR) &
+			   ~((u32)0x00000040)) | ((u32)phy1dacsbignorefifoindication << 6));
+}
+
+static inline void ricu_afe_ctrl_35_phy_1_dac_sb_rd_delay_setf(struct cl_chip *chip,
+							       u8 phy1dacsbrddelay)
+{
+	ASSERT_ERR_CHIP((((u32)phy1dacsbrddelay << 2) & ~((u32)0x0000003C)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_35_PHY_1_ADDR) &
+			   ~((u32)0x0000003C)) | ((u32)phy1dacsbrddelay << 2));
+}
+
+/*
+ * @brief AFE_CTRL_37_PHY_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    05    PHY0_EN_DAC5              0
+ *    04    PHY0_EN_DAC4              0
+ *    03    PHY0_EN_DAC3              0
+ *    02    PHY0_EN_DAC2              0
+ *    01    PHY0_EN_DAC1              0
+ *    00    PHY0_EN_DAC0              0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_37_PHY_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000BC)
+#define RICU_AFE_CTRL_37_PHY_0_OFFSET      0x000000BC
+#define RICU_AFE_CTRL_37_PHY_0_INDEX       0x0000002F
+#define RICU_AFE_CTRL_37_PHY_0_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_37_phy_0_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTRL_37_PHY_0_ADDR);
+}
+
+static inline void ricu_afe_ctrl_37_phy_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_37_PHY_0_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_5_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_5_POS    5
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_4_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_4_POS    4
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_3_POS    3
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_BIT    ((u32)0x00000004)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_2_POS    2
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_1_POS    1
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_37_PHY_0_EN_DAC_0_POS    0
+
+/*
+ * @brief AFE_CTRL_37_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    05    PHY1_EN_DAC5              0
+ *    04    PHY1_EN_DAC4              0
+ *    03    PHY1_EN_DAC3              0
+ *    02    PHY1_EN_DAC2              0
+ *    01    PHY1_EN_DAC1              0
+ *    00    PHY1_EN_DAC0              0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_37_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000C0)
+#define RICU_AFE_CTRL_37_PHY_1_OFFSET      0x000000C0
+#define RICU_AFE_CTRL_37_PHY_1_INDEX       0x00000030
+#define RICU_AFE_CTRL_37_PHY_1_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_37_phy_1_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTRL_37_PHY_1_ADDR);
+}
+
+static inline void ricu_afe_ctrl_37_phy_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_37_PHY_1_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_5_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_5_POS    5
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_4_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_4_POS    4
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_3_POS    3
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_BIT    ((u32)0x00000004)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_2_POS    2
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_1_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_1_POS    1
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_0_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_37_PHY_1_EN_DAC_0_POS    0
+
+/*
+ * @brief AFE_CTRL_39 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL4                    0
+ *    14:08 RO_CTRLQ4                 0x7
+ *    06:00 RO_CTRLI4                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_39_ADDR        (REG_RICU_BASE_ADDR + 0x000000CC)
+#define RICU_AFE_CTRL_39_OFFSET      0x000000CC
+#define RICU_AFE_CTRL_39_INDEX       0x00000033
+#define RICU_AFE_CTRL_39_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_39_pack(struct cl_chip *chip, u8 rosel4, u8 roctrlq4, u8 roctrli4)
+{
+	ASSERT_ERR_CHIP((((u32)rosel4 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq4 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli4 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_39_ADDR,
+			  ((u32)rosel4 << 16) | ((u32)roctrlq4 << 8) | ((u32)roctrli4 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_40 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL5                    0
+ *    14:08 RO_CTRLQ5                 0x7
+ *    06:00 RO_CTRLI5                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_40_ADDR        (REG_RICU_BASE_ADDR + 0x000000D0)
+#define RICU_AFE_CTRL_40_OFFSET      0x000000D0
+#define RICU_AFE_CTRL_40_INDEX       0x00000034
+#define RICU_AFE_CTRL_40_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_40_pack(struct cl_chip *chip, u8 rosel5, u8 roctrlq5, u8 roctrli5)
+{
+	ASSERT_ERR_CHIP((((u32)rosel5 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq5 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli5 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_40_ADDR,
+			  ((u32)rosel5 << 16) | ((u32)roctrlq5 << 8) | ((u32)roctrli5 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_41 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL6                    0
+ *    14:08 RO_CTRLQ6                 0x7
+ *    06:00 RO_CTRLI6                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_41_ADDR        (REG_RICU_BASE_ADDR + 0x000000D4)
+#define RICU_AFE_CTRL_41_OFFSET      0x000000D4
+#define RICU_AFE_CTRL_41_INDEX       0x00000035
+#define RICU_AFE_CTRL_41_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_41_pack(struct cl_chip *chip, u8 rosel6, u8 roctrlq6, u8 roctrli6)
+{
+	ASSERT_ERR_CHIP((((u32)rosel6 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq6 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli6 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_41_ADDR,
+			  ((u32)rosel6 << 16) | ((u32)roctrlq6 << 8) | ((u32)roctrli6 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_42 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    16    ROSEL7                    0
+ *    14:08 RO_CTRLQ7                 0x7
+ *    06:00 RO_CTRLI7                 0x7
+ * </pre>
+ */
+#define RICU_AFE_CTRL_42_ADDR        (REG_RICU_BASE_ADDR + 0x000000D8)
+#define RICU_AFE_CTRL_42_OFFSET      0x000000D8
+#define RICU_AFE_CTRL_42_INDEX       0x00000036
+#define RICU_AFE_CTRL_42_RESET       0x00000707
+
+static inline void ricu_afe_ctrl_42_pack(struct cl_chip *chip, u8 rosel7, u8 roctrlq7, u8 roctrli7)
+{
+	ASSERT_ERR_CHIP((((u32)rosel7 << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrlq7 << 8) & ~((u32)0x00007F00)) == 0);
+	ASSERT_ERR_CHIP((((u32)roctrli7 << 0) & ~((u32)0x0000007F)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_42_ADDR,
+			  ((u32)rosel7 << 16) | ((u32)roctrlq7 << 8) | ((u32)roctrli7 << 0));
+}
+
+/*
+ * @brief AFE_CTRL_43 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    01:00 FREQ_SEL                  0x3
+ * </pre>
+ */
+#define RICU_AFE_CTRL_43_ADDR        (REG_RICU_BASE_ADDR + 0x000000DC)
+#define RICU_AFE_CTRL_43_OFFSET      0x000000DC
+#define RICU_AFE_CTRL_43_INDEX       0x00000037
+#define RICU_AFE_CTRL_43_RESET       0x00000003
+
+static inline void ricu_afe_ctrl_43_freq_sel_setf(struct cl_chip *chip, u8 freqsel)
+{
+	ASSERT_ERR_CHIP((((u32)freqsel << 0) & ~((u32)0x00000003)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_43_ADDR, (u32)freqsel << 0);
+}
+
+/*
+ * @brief AFE_CTRL_44 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    01:00 CDB_FREQ_SEL              0x3
+ * </pre>
+ */
+#define RICU_AFE_CTRL_44_ADDR        (REG_RICU_BASE_ADDR + 0x000000E0)
+#define RICU_AFE_CTRL_44_OFFSET      0x000000E0
+#define RICU_AFE_CTRL_44_INDEX       0x00000038
+#define RICU_AFE_CTRL_44_RESET       0x00000003
+
+static inline void ricu_afe_ctrl_44_cdb_freq_sel_setf(struct cl_chip *chip, u8 cdbfreqsel)
+{
+	ASSERT_ERR_CHIP((((u32)cdbfreqsel << 0) & ~((u32)0x00000003)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_44_ADDR, (u32)cdbfreqsel << 0);
+}
+
+/*
+ * @brief SPI_CLK_CTRL register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    05:00 SPI_CLK_BITMAP            0xE
+ * </pre>
+ */
+#define RICU_SPI_CLK_CTRL_ADDR        (REG_RICU_BASE_ADDR + 0x000000E4)
+#define RICU_SPI_CLK_CTRL_OFFSET      0x000000E4
+#define RICU_SPI_CLK_CTRL_INDEX       0x00000039
+#define RICU_SPI_CLK_CTRL_RESET       0x0000000E
+
+static inline void ricu_spi_clk_ctrl_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_SPI_CLK_CTRL_ADDR, value);
+}
+
+/*
+ * @brief FEM_CONF_0 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:20 FEM5_CTL_SEL              0x5
+ *    19:16 FEM4_CTL_SEL              0x4
+ *    15:12 FEM3_CTL_SEL              0x3
+ *    11:08 FEM2_CTL_SEL              0x2
+ *    07:04 FEM1_CTL_SEL              0x1
+ *    03:00 FEM0_CTL_SEL              0x0
+ * </pre>
+ */
+#define RICU_FEM_CONF_0_ADDR        (REG_RICU_BASE_ADDR + 0x000000F0)
+#define RICU_FEM_CONF_0_OFFSET      0x000000F0
+#define RICU_FEM_CONF_0_INDEX       0x0000003C
+#define RICU_FEM_CONF_0_RESET       0x00543210
+
+static inline void ricu_fem_conf_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_FEM_CONF_0_ADDR, value);
+}
+
+/*
+ * @brief FEM_CONF_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    23:20 FEM11_CTL_SEL             0xd
+ *    19:16 FEM10_CTL_SEL             0xc
+ *    15:12 FEM9_CTL_SEL              0xb
+ *    11:08 FEM8_CTL_SEL              0xa
+ *    07:04 FEM7_CTL_SEL              0x9
+ *    03:00 FEM6_CTL_SEL              0x8
+ * </pre>
+ */
+#define RICU_FEM_CONF_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000F4)
+#define RICU_FEM_CONF_1_OFFSET      0x000000F4
+#define RICU_FEM_CONF_1_INDEX       0x0000003D
+#define RICU_FEM_CONF_1_RESET       0x00DCBA98
+
+static inline void ricu_fem_conf_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_FEM_CONF_1_ADDR, value);
+}
+
+/*
+ * @brief AFE_CTRL_36_PHY_1 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    07    PHY1_ADC_ALWAYS_EN_LD_IR  0
+ *    06    PHY1_ADC_ALWAYS_EN_LD_AVDQ 0
+ *    05    PHY1_ADC_ALWAYS_EN_LD_AVDI 0
+ *    04    PHY1_ADC_ALWAYS_EN_ADCQ   0
+ *    03    PHY1_ADC_ALWAYS_EN_ADCI   0
+ *    01    PHY1_HW_MODE_DAC          0
+ *    00    PHY1_HW_MODE_ADC          0
+ * </pre>
+ */
+#define RICU_AFE_CTRL_36_PHY_1_ADDR        (REG_RICU_BASE_ADDR + 0x000000F8)
+#define RICU_AFE_CTRL_36_PHY_1_OFFSET      0x000000F8
+#define RICU_AFE_CTRL_36_PHY_1_INDEX       0x0000003E
+#define RICU_AFE_CTRL_36_PHY_1_RESET       0x00000000
+
+static inline u32 ricu_afe_ctrl_36_phy_1_get(struct cl_chip *chip)
+{
+	return cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR);
+}
+
+static inline void ricu_afe_ctrl_36_phy_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR, value);
+}
+
+/* Field definitions */
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_BIT    ((u32)0x00000080)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_IR_POS    7
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_BIT    ((u32)0x00000040)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDQ_POS    6
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_BIT    ((u32)0x00000020)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_LD_AVDI_POS    5
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_BIT    ((u32)0x00000010)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCQ_POS    4
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_BIT    ((u32)0x00000008)
+#define RICU_AFE_CTRL_36_PHY_1_ADC_ALWAYS_EN_ADCI_POS    3
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_DAC_BIT    ((u32)0x00000002)
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_DAC_POS    1
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_ADC_BIT    ((u32)0x00000001)
+#define RICU_AFE_CTRL_36_PHY_1_HW_MODE_ADC_POS    0
+
+static inline void ricu_afe_ctrl_36_phy_1_hw_mode_dac_setf(struct cl_chip *chip, u8 phy1hwmodedac)
+{
+	ASSERT_ERR_CHIP((((u32)phy1hwmodedac << 1) & ~((u32)0x00000002)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR) &
+			   ~((u32)0x00000002)) | ((u32)phy1hwmodedac << 1));
+}
+
+static inline void ricu_afe_ctrl_36_phy_1_hw_mode_adc_setf(struct cl_chip *chip, u8 phy1hwmodeadc)
+{
+	ASSERT_ERR_CHIP((((u32)phy1hwmodeadc << 0) & ~((u32)0x00000001)) == 0);
+	cl_reg_write_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR,
+			  (cl_reg_read_chip(chip, RICU_AFE_CTRL_36_PHY_1_ADDR) &
+			   ~((u32)0x00000001)) | ((u32)phy1hwmodeadc << 0));
+}
+
+/*
+ * @brief AFE_ADC_CH_ALLOC register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    07:00 AFE_ADC_CH_ALLOC          0xFF
+ * </pre>
+ */
+#define RICU_AFE_ADC_CH_ALLOC_ADDR        (REG_RICU_BASE_ADDR + 0x000000FC)
+#define RICU_AFE_ADC_CH_ALLOC_OFFSET      0x000000FC
+#define RICU_AFE_ADC_CH_ALLOC_INDEX       0x0000003F
+#define RICU_AFE_ADC_CH_ALLOC_RESET       0x000000FF
+
+static inline u8 ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_getf(struct cl_chip *chip)
+{
+	u32 local_val = cl_reg_read_chip(chip, RICU_AFE_ADC_CH_ALLOC_ADDR);
+
+	return (local_val >> 0);
+}
+
+static inline void ricu_afe_adc_ch_alloc_afe_adc_ch_alloc_setf(struct cl_chip *chip,
+							       u8 afeadcchalloc)
+{
+	cl_reg_write_chip(chip, RICU_AFE_ADC_CH_ALLOC_ADDR, (u32)afeadcchalloc << 0);
+}
+
+#define RIU_RSF_FILE_SIZE 0x60C
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
+static inline void riu_rsf_control_rsf_init_en_setf(struct cl_hw *cl_hw, u8 rsfiniten)
+{
+	cl_reg_write(cl_hw, RIU_RSF_CONTROL_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RSF_CONTROL_ADDR) & ~((u32)0x80000000)) |
+		     ((u32)rsfiniten << 31));
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
+	cl_reg_write(cl_hw, RIU_RSF_INIT_ADDR, value);
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
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_en_setf(struct cl_hw *cl_hw,
+								  u8 agcfsmraminiten)
+{
+	cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+		     (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u32)0x80000000)) |
+		     ((u32)agcfsmraminiten << 31));
+}
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_ainc_1_setf(struct cl_hw *cl_hw,
+								      u8 agcfsmraminitainc1)
+{
+	ASSERT_ERR((((u32)agcfsmraminitainc1 << 28) & ~((u32)0x10000000)) == 0);
+	cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+		     (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u32)0x10000000)) |
+		     ((u32)agcfsmraminitainc1 << 28));
+}
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_set_setf(struct cl_hw *cl_hw,
+									u8 agcfsmraminitwptrset)
+{
+	ASSERT_ERR((((u32)agcfsmraminitwptrset << 12) & ~((u32)0x00001000)) == 0);
+	cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+		     (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u32)0x00001000)) |
+		     ((u32)agcfsmraminitwptrset << 12));
+}
+
+static inline void riu_agcfsm_ram_init_1_agc_fsm_ram_init_wptr_setf(struct cl_hw *cl_hw,
+								    u16 agcfsmraminitwptr)
+{
+	ASSERT_ERR((((u32)agcfsmraminitwptr << 0) & ~((u32)0x000007FF)) == 0);
+	cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR,
+		     (cl_reg_read(cl_hw, RIU_AGCFSM_RAM_INIT_1_ADDR) & ~((u32)0x000007FF)) |
+		     ((u32)agcfsmraminitwptr << 0));
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
+static inline void riu_agcfsm_ram_init_2_set(struct cl_hw *cl_hw, u32 value)
+{
+	cl_reg_write(cl_hw, RIU_AGCFSM_RAM_INIT_2_ADDR, value);
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
+#define RIU_AGCINBDPOW_20_PNOISESTAT_ADDR        (REG_RIU_BASE_ADDR + 0x00000228)
+#define RIU_AGCINBDPOW_20_PNOISESTAT_OFFSET      0x00000228
+#define RIU_AGCINBDPOW_20_PNOISESTAT_INDEX       0x0000008A
+#define RIU_AGCINBDPOW_20_PNOISESTAT_RESET       0x00000000
+
+static inline u32 riu_agcinbdpow_20_pnoisestat_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, RIU_AGCINBDPOW_20_PNOISESTAT_ADDR);
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
+#define RIU_AGCINBDPOWSECNOISESTAT_ADDR        (REG_RIU_BASE_ADDR + 0x00000230)
+#define RIU_AGCINBDPOWSECNOISESTAT_OFFSET      0x00000230
+#define RIU_AGCINBDPOWSECNOISESTAT_INDEX       0x0000008C
+#define RIU_AGCINBDPOWSECNOISESTAT_RESET       0x00000000
+
+static inline u32 riu_agcinbdpowsecnoisestat_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, RIU_AGCINBDPOWSECNOISESTAT_ADDR);
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
+static inline void riu_rwnxagccntl_agcfsmreset_setf(struct cl_hw *cl_hw, u8 agcfsmreset)
+{
+	ASSERT_ERR((((u32)agcfsmreset << 12) & ~((u32)0x00001000)) == 0);
+	cl_reg_write(cl_hw, RIU_RWNXAGCCNTL_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCCNTL_ADDR) & ~((u32)0x00001000)) |
+		     ((u32)agcfsmreset << 12));
+}
+
+/*
+ * @brief RWNXAGCDSP_3 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    27:20 INBDPOWMINDBV             0xBF
+ *    17:16 INBDRND                   0x3
+ *    15:08 INBDPOWMINDBM_ANT1        0x9C
+ *    07:00 INBDPOWMINDBM_ANT0        0x9C
+ * </pre>
+ */
+#define RIU_RWNXAGCDSP_3_ADDR        (REG_RIU_BASE_ADDR + 0x000003A0)
+#define RIU_RWNXAGCDSP_3_OFFSET      0x000003A0
+#define RIU_RWNXAGCDSP_3_INDEX       0x000000E8
+#define RIU_RWNXAGCDSP_3_RESET       0x0BF39C9C
+
+static inline u8 riu_rwnxagcdsp_3_inbdpowmindbm_ant_1_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RWNXAGCDSP_3_ADDR);
+
+	return ((local_val & ((u32)0x0000FF00)) >> 8);
+}
+
+static inline void riu_rwnxagcdsp_3_inbdpowmindbm_ant_1_setf(struct cl_hw *cl_hw,
+							     u8 inbdpowmindbmant1)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCDSP_3_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCDSP_3_ADDR) & ~((u32)0x0000FF00)) |
+		     ((u32)inbdpowmindbmant1 << 8));
+}
+
+static inline u8 riu_rwnxagcdsp_3_inbdpowmindbm_ant_0_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RWNXAGCDSP_3_ADDR);
+
+	return ((local_val & ((u32)0x000000FF)) >> 0);
+}
+
+static inline void riu_rwnxagcdsp_3_inbdpowmindbm_ant_0_setf(struct cl_hw *cl_hw,
+							     u8 inbdpowmindbmant0)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCDSP_3_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCDSP_3_ADDR) & ~((u32)0x000000FF)) |
+		     ((u32)inbdpowmindbmant0 << 0));
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
+static inline void riu_rwnxagccca_1_cca_cnt_clear_setf(struct cl_hw *cl_hw, u8 ccacntclear)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCCCA_1_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCCCA_1_ADDR) & ~((u32)0x80000000)) |
+		     ((u32)ccacntclear << 31));
+}
+
+static inline void riu_rwnxagccca_1_cca_cnt_rate_setf(struct cl_hw *cl_hw, u8 ccacntrate)
+{
+	ASSERT_ERR((((u32)ccacntrate << 29) & ~((u32)0x60000000)) == 0);
+	cl_reg_write_direct(cl_hw, RIU_RWNXAGCCCA_1_ADDR,
+			    (cl_reg_read(cl_hw, RIU_RWNXAGCCCA_1_ADDR) & ~((u32)0x60000000)) |
+			    ((u32)ccacntrate << 29));
+}
+
+/*
+ * @brief RWNXAGCDSP_5 register definition
+ * <pre>
+ *   Bits           Field Name   Reset Value
+ *  -----   ------------------   -----------
+ *    31:24 INBDPOWMINDBM_ANT5        0x9C
+ *    23:16 INBDPOWMINDBM_ANT4        0x9C
+ *    15:08 INBDPOWMINDBM_ANT3        0x9C
+ *    07:00 INBDPOWMINDBM_ANT2        0x9C
+ * </pre>
+ */
+#define RIU_RWNXAGCDSP_5_ADDR        (REG_RIU_BASE_ADDR + 0x000003EC)
+#define RIU_RWNXAGCDSP_5_OFFSET      0x000003EC
+#define RIU_RWNXAGCDSP_5_INDEX       0x000000FB
+#define RIU_RWNXAGCDSP_5_RESET       0x9C9C9C9C
+
+static inline u8 riu_rwnxagcdsp_5_inbdpowmindbm_ant_5_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR);
+
+	return ((local_val & ((u32)0xFF000000)) >> 24);
+}
+
+static inline void riu_rwnxagcdsp_5_inbdpowmindbm_ant_5_setf(struct cl_hw *cl_hw,
+							     u8 inbdpowmindbmant5)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCDSP_5_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR) & ~((u32)0xFF000000)) |
+		     ((u32)inbdpowmindbmant5 << 24));
+}
+
+static inline u8 riu_rwnxagcdsp_5_inbdpowmindbm_ant_4_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR);
+
+	return ((local_val & ((u32)0x00FF0000)) >> 16);
+}
+
+static inline void riu_rwnxagcdsp_5_inbdpowmindbm_ant_4_setf(struct cl_hw *cl_hw,
+							     u8 inbdpowmindbmant4)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCDSP_5_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR) & ~((u32)0x00FF0000)) |
+		     ((u32)inbdpowmindbmant4 << 16));
+}
+
+static inline u8 riu_rwnxagcdsp_5_inbdpowmindbm_ant_3_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR);
+
+	return ((local_val & ((u32)0x0000FF00)) >> 8);
+}
+
+static inline void riu_rwnxagcdsp_5_inbdpowmindbm_ant_3_setf(struct cl_hw *cl_hw,
+							     u8 inbdpowmindbmant3)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCDSP_5_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR) & ~((u32)0x0000FF00)) |
+		     ((u32)inbdpowmindbmant3 << 8));
+}
+
+static inline u8 riu_rwnxagcdsp_5_inbdpowmindbm_ant_2_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR);
+
+	return ((local_val & ((u32)0x000000FF)) >> 0);
+}
+
+static inline void riu_rwnxagcdsp_5_inbdpowmindbm_ant_2_setf(struct cl_hw *cl_hw,
+							     u8 inbdpowmindbmant2)
+{
+	cl_reg_write(cl_hw, RIU_RWNXAGCDSP_5_ADDR,
+		     (cl_reg_read(cl_hw, RIU_RWNXAGCDSP_5_ADDR) & ~((u32)0x000000FF)) |
+		     ((u32)inbdpowmindbmant2 << 0));
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
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_ADDR        (REG_RIU_BASE_ADDR + 0x00000478)
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_OFFSET      0x00000478
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_INDEX       0x0000011E
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_0_RESET       0x00000000
+
+static inline u32 riu_agcinbdpownoiseper_20_stat_0_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, RIU_AGCINBDPOWNOISEPER_20_STAT_0_ADDR);
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
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_ADDR        (REG_RIU_BASE_ADDR + 0x0000047C)
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_OFFSET      0x0000047C
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_INDEX       0x0000011F
+#define RIU_AGCINBDPOWNOISEPER_20_STAT_1_RESET       0x00000000
+
+static inline u32 riu_agcinbdpownoiseper_20_stat_1_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, RIU_AGCINBDPOWNOISEPER_20_STAT_1_ADDR);
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
+	return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_0_ADDR);
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
+	return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_1_ADDR);
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
+	return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_2_ADDR);
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
+	return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_3_ADDR);
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
+	return cl_reg_read(cl_hw, RIU_INBDPOWFORMAC_4_ADDR);
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
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_ADDR        (REG_RIU_BASE_ADDR + 0x0000067C)
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_OFFSET      0x0000067C
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_INDEX       0x0000019F
+#define RIU_AGCINBDPOW_20_PNOISESTAT_2_RESET       0x00000000
+
+static inline u32 riu_agcinbdpow_20_pnoisestat_2_get(struct cl_hw *cl_hw)
+{
+	return cl_reg_read(cl_hw, RIU_AGCINBDPOW_20_PNOISESTAT_2_ADDR);
+}
+
+#define REG_RIU_RC_BASE_ADDR 0x00485000
+
+/*
+ * @brief SW_CTRL register definition
+ * This register provides write access to the radio SPI interface register description
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
+static inline void riu_rc_sw_ctrl_pack(struct cl_hw *cl_hw, u8 startdone, u8 more,
+				       u8 fastwrspd, u8 fastwrforce, u8 fwrhwenable,
+				       u8 fwrswenable, u8 fwrenable, u8 rfresetb,
+				       u8 prescaler, u8 readnotwrite, u8 address, u8 data)
+{
+	ASSERT_ERR((((u32)more << 30) & ~((u32)0x40000000)) == 0);
+	ASSERT_ERR((((u32)fastwrspd << 29) & ~((u32)0x20000000)) == 0);
+	ASSERT_ERR((((u32)fastwrforce << 28) & ~((u32)0x10000000)) == 0);
+	ASSERT_ERR((((u32)fwrhwenable << 27) & ~((u32)0x08000000)) == 0);
+	ASSERT_ERR((((u32)fwrswenable << 26) & ~((u32)0x04000000)) == 0);
+	ASSERT_ERR((((u32)fwrenable << 25) & ~((u32)0x02000000)) == 0);
+	ASSERT_ERR((((u32)rfresetb << 24) & ~((u32)0x01000000)) == 0);
+	ASSERT_ERR((((u32)prescaler << 19) & ~((u32)0x00F80000)) == 0);
+	ASSERT_ERR((((u32)readnotwrite << 16) & ~((u32)0x00010000)) == 0);
+	ASSERT_ERR((((u32)address << 8) & ~((u32)0x00007F00)) == 0);
+	cl_reg_write(cl_hw, RIU_RC_SW_CTRL_ADDR,
+		     ((u32)startdone << 31) | ((u32)more << 30) |
+		     ((u32)fastwrspd << 29) | ((u32)fastwrforce << 28) |
+		     ((u32)fwrhwenable << 27) | ((u32)fwrswenable << 26) |
+		     ((u32)fwrenable << 25) | ((u32)rfresetb << 24) |
+		     ((u32)prescaler << 19) | ((u32)readnotwrite << 16) |
+		     ((u32)address << 8) | ((u32)data << 0));
+}
+
+static inline u8 riu_rc_sw_ctrl_start_done_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RC_SW_CTRL_ADDR);
+
+	return ((local_val & ((u32)0x80000000)) >> 31);
+}
+
+static inline u8 riu_rc_sw_ctrl_data_getf(struct cl_hw *cl_hw)
+{
+	u32 local_val = cl_reg_read(cl_hw, RIU_RC_SW_CTRL_ADDR);
+
+	return ((local_val & ((u32)0x000000FF)) >> 0);
+}
+
+/*
+ * @brief RF_LNA_LUT register definition
+ * These registers provide control of the RF LNA assertion by decoding each possible value
+ * the AGC LNA gain setting, from minimum LNA gain to maximum LNA gain. register description
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
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_6_MASK    ((u32)0x07000000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_6_LSB    24
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_6_WIDTH    ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_5_MASK    ((u32)0x00700000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_5_LSB    20
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_5_WIDTH    ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_4_MASK    ((u32)0x00070000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_4_LSB    16
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_4_WIDTH    ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_3_MASK    ((u32)0x00007000)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_3_LSB    12
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_3_WIDTH    ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_2_MASK    ((u32)0x00000700)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_2_LSB    8
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_2_WIDTH    ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_1_MASK    ((u32)0x00000070)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_1_LSB    4
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_1_WIDTH    ((u32)0x00000003)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_0_MASK    ((u32)0x00000007)
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_0_LSB    0
+#define RIU_RC_RF_LNA_LUT_RFLNALUT_0_WIDTH    ((u32)0x00000003)
+
+#define REG_IO_CTRL_BASE_ADDR 0x007C7000
+
+/*
+ * @brief RX_ACTIVE_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000005C)
+#define IO_CTRL_RX_ACTIVE_0_OFFSET      0x0000005C
+#define IO_CTRL_RX_ACTIVE_0_INDEX       0x00000017
+#define IO_CTRL_RX_ACTIVE_0_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_0_ADDR, value);
+}
+
+/* Field definitions */
+#define IO_CTRL_RX_ACTIVE_0_GPIO_IN_BIT     ((u32)0x00002000)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_IN_POS     13
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OUT_BIT    ((u32)0x00001000)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OUT_POS    12
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OE_BIT     ((u32)0x00000800)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_OE_POS     11
+#define IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_BIT    ((u32)0x00000400)
+#define IO_CTRL_RX_ACTIVE_0_GPIO_ENABLE_POS    10
+#define IO_CTRL_RX_ACTIVE_0_INPUT_ENABLE_BIT    ((u32)0x00000200)
+#define IO_CTRL_RX_ACTIVE_0_INPUT_ENABLE_POS    9
+#define IO_CTRL_RX_ACTIVE_0_SLEW_RATE_BIT    ((u32)0x00000100)
+#define IO_CTRL_RX_ACTIVE_0_SLEW_RATE_POS    8
+#define IO_CTRL_RX_ACTIVE_0_DRIVER_PULL_STATE_MASK    ((u32)0x000000C0)
+#define IO_CTRL_RX_ACTIVE_0_DRIVER_PULL_STATE_LSB    6
+#define IO_CTRL_RX_ACTIVE_0_DRIVER_PULL_STATE_WIDTH    ((u32)0x00000002)
+#define IO_CTRL_RX_ACTIVE_0_OUTPUT_PAD_STRENGTH_MASK    ((u32)0x00000030)
+#define IO_CTRL_RX_ACTIVE_0_OUTPUT_PAD_STRENGTH_LSB    4
+#define IO_CTRL_RX_ACTIVE_0_OUTPUT_PAD_STRENGTH_WIDTH    ((u32)0x00000002)
+#define IO_CTRL_RX_ACTIVE_0_SCHMIT_TRIGER_BIT    ((u32)0x00000008)
+#define IO_CTRL_RX_ACTIVE_0_SCHMIT_TRIGER_POS    3
+#define IO_CTRL_RX_ACTIVE_0_MUX_SELECT_MASK    ((u32)0x00000007)
+#define IO_CTRL_RX_ACTIVE_0_MUX_SELECT_LSB    0
+#define IO_CTRL_RX_ACTIVE_0_MUX_SELECT_WIDTH    ((u32)0x00000003)
+
+static inline void io_ctrl_rx_active_0_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_0_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_0_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000060)
+#define IO_CTRL_RX_ACTIVE_1_OFFSET      0x00000060
+#define IO_CTRL_RX_ACTIVE_1_INDEX       0x00000018
+#define IO_CTRL_RX_ACTIVE_1_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_1_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_1_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_1_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_1_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000064)
+#define IO_CTRL_RX_ACTIVE_2_OFFSET      0x00000064
+#define IO_CTRL_RX_ACTIVE_2_INDEX       0x00000019
+#define IO_CTRL_RX_ACTIVE_2_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_2_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_2_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_2_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_2_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_2_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000068)
+#define IO_CTRL_RX_ACTIVE_3_OFFSET      0x00000068
+#define IO_CTRL_RX_ACTIVE_3_INDEX       0x0000001A
+#define IO_CTRL_RX_ACTIVE_3_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_3_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_3_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_3_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_3_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_3_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000006C)
+#define IO_CTRL_RX_ACTIVE_4_OFFSET      0x0000006C
+#define IO_CTRL_RX_ACTIVE_4_INDEX       0x0000001B
+#define IO_CTRL_RX_ACTIVE_4_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_4_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_4_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_4_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_4_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_4_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000070)
+#define IO_CTRL_RX_ACTIVE_5_OFFSET      0x00000070
+#define IO_CTRL_RX_ACTIVE_5_INDEX       0x0000001C
+#define IO_CTRL_RX_ACTIVE_5_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_5_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_5_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_5_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_5_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_5_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000074)
+#define IO_CTRL_RX_ACTIVE_6_OFFSET      0x00000074
+#define IO_CTRL_RX_ACTIVE_6_INDEX       0x0000001D
+#define IO_CTRL_RX_ACTIVE_6_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_6_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_6_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_6_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_6_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_6_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief RX_ACTIVE_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   1
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x3
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_RX_ACTIVE_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000078)
+#define IO_CTRL_RX_ACTIVE_7_OFFSET      0x00000078
+#define IO_CTRL_RX_ACTIVE_7_INDEX       0x0000001E
+#define IO_CTRL_RX_ACTIVE_7_RESET       0x000026D8
+
+static inline void io_ctrl_rx_active_7_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_7_ADDR, value);
+}
+
+static inline void io_ctrl_rx_active_7_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_RX_ACTIVE_7_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_RX_ACTIVE_7_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000007C)
+#define IO_CTRL_LNA_ENABLE_0_OFFSET      0x0000007C
+#define IO_CTRL_LNA_ENABLE_0_INDEX       0x0000001F
+#define IO_CTRL_LNA_ENABLE_0_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_0_ADDR, value);
+}
+
+/* Field definitions */
+#define IO_CTRL_LNA_ENABLE_0_GPIO_IN_BIT    ((u32)0x00002000)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_IN_POS    13
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OUT_BIT    ((u32)0x00001000)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OUT_POS    12
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OE_BIT    ((u32)0x00000800)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_OE_POS    11
+#define IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_BIT    ((u32)0x00000400)
+#define IO_CTRL_LNA_ENABLE_0_GPIO_ENABLE_POS    10
+#define IO_CTRL_LNA_ENABLE_0_INPUT_ENABLE_BIT    ((u32)0x00000200)
+#define IO_CTRL_LNA_ENABLE_0_INPUT_ENABLE_POS    9
+#define IO_CTRL_LNA_ENABLE_0_SLEW_RATE_BIT    ((u32)0x00000100)
+#define IO_CTRL_LNA_ENABLE_0_SLEW_RATE_POS    8
+#define IO_CTRL_LNA_ENABLE_0_DRIVER_PULL_STATE_MASK    ((u32)0x000000C0)
+#define IO_CTRL_LNA_ENABLE_0_DRIVER_PULL_STATE_LSB    6
+#define IO_CTRL_LNA_ENABLE_0_DRIVER_PULL_STATE_WIDTH    ((u32)0x00000002)
+#define IO_CTRL_LNA_ENABLE_0_OUTPUT_PAD_STRENGTH_MASK    ((u32)0x00000030)
+#define IO_CTRL_LNA_ENABLE_0_OUTPUT_PAD_STRENGTH_LSB    4
+#define IO_CTRL_LNA_ENABLE_0_OUTPUT_PAD_STRENGTH_WIDTH    ((u32)0x00000002)
+#define IO_CTRL_LNA_ENABLE_0_SCHMIT_TRIGER_BIT    ((u32)0x00000008)
+#define IO_CTRL_LNA_ENABLE_0_SCHMIT_TRIGER_POS    3
+#define IO_CTRL_LNA_ENABLE_0_MUX_SELECT_MASK    ((u32)0x00000007)
+#define IO_CTRL_LNA_ENABLE_0_MUX_SELECT_LSB    0
+#define IO_CTRL_LNA_ENABLE_0_MUX_SELECT_WIDTH    ((u32)0x00000003)
+
+static inline void io_ctrl_lna_enable_0_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_0_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_0_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000080)
+#define IO_CTRL_LNA_ENABLE_1_OFFSET      0x00000080
+#define IO_CTRL_LNA_ENABLE_1_INDEX       0x00000020
+#define IO_CTRL_LNA_ENABLE_1_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_1_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_1_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_1_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_1_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000084)
+#define IO_CTRL_LNA_ENABLE_2_OFFSET      0x00000084
+#define IO_CTRL_LNA_ENABLE_2_INDEX       0x00000021
+#define IO_CTRL_LNA_ENABLE_2_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_2_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_2_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_2_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_2_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_2_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000088)
+#define IO_CTRL_LNA_ENABLE_3_OFFSET      0x00000088
+#define IO_CTRL_LNA_ENABLE_3_INDEX       0x00000022
+#define IO_CTRL_LNA_ENABLE_3_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_3_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_3_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_3_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_3_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_3_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000008C)
+#define IO_CTRL_LNA_ENABLE_4_OFFSET      0x0000008C
+#define IO_CTRL_LNA_ENABLE_4_INDEX       0x00000023
+#define IO_CTRL_LNA_ENABLE_4_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_4_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_4_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_4_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_4_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_4_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000090)
+#define IO_CTRL_LNA_ENABLE_5_OFFSET      0x00000090
+#define IO_CTRL_LNA_ENABLE_5_INDEX       0x00000024
+#define IO_CTRL_LNA_ENABLE_5_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_5_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_5_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_5_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_5_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_5_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000094)
+#define IO_CTRL_LNA_ENABLE_6_OFFSET      0x00000094
+#define IO_CTRL_LNA_ENABLE_6_INDEX       0x00000025
+#define IO_CTRL_LNA_ENABLE_6_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_6_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_6_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_6_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_6_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_6_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000098)
+#define IO_CTRL_LNA_ENABLE_7_OFFSET      0x00000098
+#define IO_CTRL_LNA_ENABLE_7_INDEX       0x00000026
+#define IO_CTRL_LNA_ENABLE_7_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_7_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_7_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_7_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_7_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_7_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_8 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_8_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000009C)
+#define IO_CTRL_LNA_ENABLE_8_OFFSET      0x0000009C
+#define IO_CTRL_LNA_ENABLE_8_INDEX       0x00000027
+#define IO_CTRL_LNA_ENABLE_8_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_8_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_8_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_8_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_8_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_8_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_9 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_9_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000A0)
+#define IO_CTRL_LNA_ENABLE_9_OFFSET      0x000000A0
+#define IO_CTRL_LNA_ENABLE_9_INDEX       0x00000028
+#define IO_CTRL_LNA_ENABLE_9_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_9_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_9_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_9_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_9_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_9_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_10 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_10_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000A4)
+#define IO_CTRL_LNA_ENABLE_10_OFFSET      0x000000A4
+#define IO_CTRL_LNA_ENABLE_10_INDEX       0x00000029
+#define IO_CTRL_LNA_ENABLE_10_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_10_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_10_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_10_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_10_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_10_ADDR) &
+			   ~((u32)0x00000400)) | ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief LNA_ENABLE_11 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_LNA_ENABLE_11_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000A8)
+#define IO_CTRL_LNA_ENABLE_11_OFFSET      0x000000A8
+#define IO_CTRL_LNA_ENABLE_11_INDEX       0x0000002A
+#define IO_CTRL_LNA_ENABLE_11_RESET       0x00000698
+
+static inline void io_ctrl_lna_enable_11_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_11_ADDR, value);
+}
+
+static inline void io_ctrl_lna_enable_11_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_LNA_ENABLE_11_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_LNA_ENABLE_11_ADDR) &
+			   ~((u32)0x00000400)) | ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000AC)
+#define IO_CTRL_PA_ENABLE_0_OFFSET      0x000000AC
+#define IO_CTRL_PA_ENABLE_0_INDEX       0x0000002B
+#define IO_CTRL_PA_ENABLE_0_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_0_ADDR, value);
+}
+
+/* Field definitions */
+#define IO_CTRL_PA_ENABLE_0_GPIO_IN_BIT     ((u32)0x00002000)
+#define IO_CTRL_PA_ENABLE_0_GPIO_IN_POS     13
+#define IO_CTRL_PA_ENABLE_0_GPIO_OUT_BIT    ((u32)0x00001000)
+#define IO_CTRL_PA_ENABLE_0_GPIO_OUT_POS    12
+#define IO_CTRL_PA_ENABLE_0_GPIO_OE_BIT     ((u32)0x00000800)
+#define IO_CTRL_PA_ENABLE_0_GPIO_OE_POS     11
+#define IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_BIT    ((u32)0x00000400)
+#define IO_CTRL_PA_ENABLE_0_GPIO_ENABLE_POS    10
+#define IO_CTRL_PA_ENABLE_0_INPUT_ENABLE_BIT    ((u32)0x00000200)
+#define IO_CTRL_PA_ENABLE_0_INPUT_ENABLE_POS    9
+#define IO_CTRL_PA_ENABLE_0_SLEW_RATE_BIT    ((u32)0x00000100)
+#define IO_CTRL_PA_ENABLE_0_SLEW_RATE_POS    8
+#define IO_CTRL_PA_ENABLE_0_DRIVER_PULL_STATE_MASK    ((u32)0x000000C0)
+#define IO_CTRL_PA_ENABLE_0_DRIVER_PULL_STATE_LSB    6
+#define IO_CTRL_PA_ENABLE_0_DRIVER_PULL_STATE_WIDTH    ((u32)0x00000002)
+#define IO_CTRL_PA_ENABLE_0_OUTPUT_PAD_STRENGTH_MASK    ((u32)0x00000030)
+#define IO_CTRL_PA_ENABLE_0_OUTPUT_PAD_STRENGTH_LSB    4
+#define IO_CTRL_PA_ENABLE_0_OUTPUT_PAD_STRENGTH_WIDTH    ((u32)0x00000002)
+#define IO_CTRL_PA_ENABLE_0_SCHMIT_TRIGER_BIT    ((u32)0x00000008)
+#define IO_CTRL_PA_ENABLE_0_SCHMIT_TRIGER_POS    3
+#define IO_CTRL_PA_ENABLE_0_MUX_SELECT_MASK    ((u32)0x00000007)
+#define IO_CTRL_PA_ENABLE_0_MUX_SELECT_LSB    0
+#define IO_CTRL_PA_ENABLE_0_MUX_SELECT_WIDTH    ((u32)0x00000003)
+
+static inline void io_ctrl_pa_enable_0_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_0_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_0_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B0)
+#define IO_CTRL_PA_ENABLE_1_OFFSET      0x000000B0
+#define IO_CTRL_PA_ENABLE_1_INDEX       0x0000002C
+#define IO_CTRL_PA_ENABLE_1_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_1_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_1_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_1_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_1_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B4)
+#define IO_CTRL_PA_ENABLE_2_OFFSET      0x000000B4
+#define IO_CTRL_PA_ENABLE_2_INDEX       0x0000002D
+#define IO_CTRL_PA_ENABLE_2_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_2_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_2_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_2_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_2_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_2_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000B8)
+#define IO_CTRL_PA_ENABLE_3_OFFSET      0x000000B8
+#define IO_CTRL_PA_ENABLE_3_INDEX       0x0000002E
+#define IO_CTRL_PA_ENABLE_3_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_3_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_3_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_3_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_3_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_3_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000BC)
+#define IO_CTRL_PA_ENABLE_4_OFFSET      0x000000BC
+#define IO_CTRL_PA_ENABLE_4_INDEX       0x0000002F
+#define IO_CTRL_PA_ENABLE_4_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_4_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_4_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_4_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_4_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_4_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C0)
+#define IO_CTRL_PA_ENABLE_5_OFFSET      0x000000C0
+#define IO_CTRL_PA_ENABLE_5_INDEX       0x00000030
+#define IO_CTRL_PA_ENABLE_5_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_5_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_5_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_5_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_5_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_5_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C4)
+#define IO_CTRL_PA_ENABLE_6_OFFSET      0x000000C4
+#define IO_CTRL_PA_ENABLE_6_INDEX       0x00000031
+#define IO_CTRL_PA_ENABLE_6_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_6_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_6_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_6_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_6_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_6_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000C8)
+#define IO_CTRL_PA_ENABLE_7_OFFSET      0x000000C8
+#define IO_CTRL_PA_ENABLE_7_INDEX       0x00000032
+#define IO_CTRL_PA_ENABLE_7_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_7_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_7_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_7_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_7_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_7_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_8 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_8_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000CC)
+#define IO_CTRL_PA_ENABLE_8_OFFSET      0x000000CC
+#define IO_CTRL_PA_ENABLE_8_INDEX       0x00000033
+#define IO_CTRL_PA_ENABLE_8_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_8_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_8_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_8_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_8_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_8_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_9 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_9_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000D0)
+#define IO_CTRL_PA_ENABLE_9_OFFSET      0x000000D0
+#define IO_CTRL_PA_ENABLE_9_INDEX       0x00000034
+#define IO_CTRL_PA_ENABLE_9_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_9_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_9_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_9_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_9_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_9_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_10 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_10_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000D4)
+#define IO_CTRL_PA_ENABLE_10_OFFSET      0x000000D4
+#define IO_CTRL_PA_ENABLE_10_INDEX       0x00000035
+#define IO_CTRL_PA_ENABLE_10_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_10_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_10_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_10_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_10_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_10_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief PA_ENABLE_11 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               1
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 0
+ *   07:06 DRIVER_PULL_STATE         0x2
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_PA_ENABLE_11_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000D8)
+#define IO_CTRL_PA_ENABLE_11_OFFSET      0x000000D8
+#define IO_CTRL_PA_ENABLE_11_INDEX       0x00000036
+#define IO_CTRL_PA_ENABLE_11_RESET       0x00000698
+
+static inline void io_ctrl_pa_enable_11_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_11_ADDR, value);
+}
+
+static inline void io_ctrl_pa_enable_11_gpio_enable_setf(struct cl_chip *chip, u8 gpioenable)
+{
+	ASSERT_ERR_CHIP((((u32)gpioenable << 10) & ~((u32)0x00000400)) == 0);
+	cl_reg_write_chip(chip, IO_CTRL_PA_ENABLE_11_ADDR,
+			  (cl_reg_read_chip(chip, IO_CTRL_PA_ENABLE_11_ADDR) & ~((u32)0x00000400)) |
+			  ((u32)gpioenable << 10));
+}
+
+/*
+ * @brief SPICLK register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_SPICLK_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000DC)
+#define IO_CTRL_SPICLK_OFFSET      0x000000DC
+#define IO_CTRL_SPICLK_INDEX       0x00000037
+#define IO_CTRL_SPICLK_RESET       0x00000318
+
+static inline void io_ctrl_spiclk_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_SPICLK_ADDR, value);
+}
+
+/*
+ * @brief FWR_EN_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FWR_EN_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000F0)
+#define IO_CTRL_FWR_EN_1_OFFSET      0x000000F0
+#define IO_CTRL_FWR_EN_1_INDEX       0x0000003C
+#define IO_CTRL_FWR_EN_1_RESET       0x00000318
+
+static inline void io_ctrl_fwr_en_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FWR_EN_1_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_7 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_7_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000F8)
+#define IO_CTRL_FASTWR_7_OFFSET      0x000000F8
+#define IO_CTRL_FASTWR_7_INDEX       0x0000003E
+#define IO_CTRL_FASTWR_7_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_7_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_7_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_6 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_6_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x000000FC)
+#define IO_CTRL_FASTWR_6_OFFSET      0x000000FC
+#define IO_CTRL_FASTWR_6_INDEX       0x0000003F
+#define IO_CTRL_FASTWR_6_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_6_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_6_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_5 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_5_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000100)
+#define IO_CTRL_FASTWR_5_OFFSET      0x00000100
+#define IO_CTRL_FASTWR_5_INDEX       0x00000040
+#define IO_CTRL_FASTWR_5_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_5_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_5_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_4 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_4_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000104)
+#define IO_CTRL_FASTWR_4_OFFSET      0x00000104
+#define IO_CTRL_FASTWR_4_INDEX       0x00000041
+#define IO_CTRL_FASTWR_4_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_4_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_4_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_3 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_3_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000108)
+#define IO_CTRL_FASTWR_3_OFFSET      0x00000108
+#define IO_CTRL_FASTWR_3_INDEX       0x00000042
+#define IO_CTRL_FASTWR_3_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_3_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_3_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_2 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_2_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x0000010C)
+#define IO_CTRL_FASTWR_2_OFFSET      0x0000010C
+#define IO_CTRL_FASTWR_2_INDEX       0x00000043
+#define IO_CTRL_FASTWR_2_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_2_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_2_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_1 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_1_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000110)
+#define IO_CTRL_FASTWR_1_OFFSET      0x00000110
+#define IO_CTRL_FASTWR_1_INDEX       0x00000044
+#define IO_CTRL_FASTWR_1_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_1_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_1_ADDR, value);
+}
+
+/*
+ * @brief FASTWR_0 register definition
+ * <pre>
+ *  Bits           Field Name   Reset Value
+ * -----   ------------------   -----------
+ *   13    GPIO_IN                   0
+ *   12    GPIO_OUT                  0
+ *   11    GPIO_OE                   0
+ *   10    GPIO_ENABLE               0
+ *   09    input_enable              1
+ *   08    SLEW_RATE                 1
+ *   07:06 DRIVER_PULL_STATE         0x0
+ *   05:04 OUTPUT_PAD_STRENGTH       0x1
+ *   03    SCHMIT_TRIGER             1
+ *   02:00 MUX_SELECT                0x0
+ * </pre>
+ */
+#define IO_CTRL_FASTWR_0_ADDR        (REG_IO_CTRL_BASE_ADDR + 0x00000114)
+#define IO_CTRL_FASTWR_0_OFFSET      0x00000114
+#define IO_CTRL_FASTWR_0_INDEX       0x00000045
+#define IO_CTRL_FASTWR_0_RESET       0x00000318
+
+static inline void io_ctrl_fastwr_0_set(struct cl_chip *chip, u32 value)
+{
+	cl_reg_write_chip(chip, IO_CTRL_FASTWR_0_ADDR, value);
+}
+
+#endif /*CL_REG_DEFS_H */
-- 
2.36.1

