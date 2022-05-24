Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4762A532959
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236866AbiEXLjm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbiEXLjk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:40 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50045.outbound.protection.outlook.com [40.107.5.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788A38CCC5
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djUfPvq+9xlbgCsk1RP47SdOARhe7ll3yHVCjKmbY0Mxfh1pt6QeJ/sU112jT1FtD6rlmWVBiXLrCDBpVATYAKgheuzKVLhpNVB4LKDt0tJqsHz0fdh9IiVPi5XEoVwg8mgeRUKzUSnnc6zVNcvRk5deL3Pq274FGHLJwJOKCBuGW5JfBsimDrGdbESThe7rVT+ll/mPuEn6bL3lOJ+4UGEeZ286mEHbfHVRyscr6paoAFN8/ZRhDMqGUigzIjI41RNI3AimLb/1AGDNx8gSLkXCg+ROi78uFu9PCS0wVDNgaZ0bEYvHIvHCphYnxu9BAc2CmiFE/RvFlRt0AOZpXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbFwNoLDetNRL9pSM2yqP7f+QPSmXwL9C0yQrYD8EuI=;
 b=e2UzBbgJpbq3lDXBvr1O4HWa7dqSnRdHlVI06UjLzS6ckl4AZ0UQ4ULT0/6aV2rAZBG6k9QmSkTnuTLQjDapK/Dh6pDQP4QVKS4jUp266MtaM4thdpQOp3waS+Pom9VI2w25wil/vzNIIWVwdh8t+vSnoLbBhlNgYYjWKAmKx/XrjWyjdl2NJpF2tx7QdFOJYUodjXbyCwMWGMq5gZoOJmcccki4cur15bKhsfL0AGx2LsNXmcTGWnzIacQQcFyA2npd0nePppSnqo5XU2j1df0YvYR4Ua/6SONpdxFEidtSGOQKbvagPFkwCeOgon5RnP4DD+i6peYN3HKJ+xnfpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbFwNoLDetNRL9pSM2yqP7f+QPSmXwL9C0yQrYD8EuI=;
 b=d9ynHD4z3Ht7MIVZC7cwcyoOiPRnROIzjdAPPf6fbOc/lj1FT0juP7tiuCDrfW9PSAYbDotml4jiMRvS8PjppaASGllTWe0jUrZ9AB8woMWUwivbTZpgj4pWl1EGFNgSK07dEFjV/V6Fh1c5883Cfg/BHNY3VjOHxDfN10UUS2g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:48 +0000
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
Subject: [RFC v2 53/96] cl8k: add platform.h
Date:   Tue, 24 May 2022 14:34:19 +0300
Message-Id: <20220524113502.1094459-54-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: ba8ce742-5e9e-4497-b2c4-08da3d79eded
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571471C716F3D0F2EE7F1FBF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fi9sZ2qbVUA7AL6wqIK7YAKaf09HyIhrRu6mcSBjIooigMhv4WuWJ9dAaeBD/RNFmfZaRkl4L6US+9U8rMiw46YVZD0Yr7VS5kOySYf4Eacy1QDnCXOK9/AYpJ+I1wsDXfpbif7Uhag6zjTiUsuGACpNsU5/w5suDYMBJctDfTaIYnuEIYSgqnGpXMM3Qzqf3LqHcR7gzvD6+TibNMm3RsggCYM6v7uuLC5vdMC2XNcu2LhBLohc23IFkpisvc/cILQjeHURbae/0aYLzTW0XCEeddJk7potFP0umnfOBPpHciLNRLZjpQsYx97TtSA23fGuSRl0XGN/zCRqG98xFpzk3UYLrOrBCPX8rggf/LEJ1BtQvBOaYDws4tu6wtK69AEOzc21xBM/Xbvu7SmfcUwTIn3WpFJQcOyowdpjb0QjVKhPKBS8e4Zl1z3PWi9fhffWY2uE/A6Y2nf7838gOkAYcWt2XgS8a5++M7EQPTFL1T1Nucz0JSQCNiKKDDIwt67rP+939iPRTLtGYc5MROCpAk5iV0CiM0rfL/wS/4UFM6z2x6rrAkyV0wKlgrUUfrYDnkkgE8ZCREKDW4nTjoVfRo0EdsDtxozW/l40IYQ2zKUhImqycrYZ5/EqkpsdabMQMtUAywskDRV0KN7/TzRLCxY7knH6jCCIOzQdmsZDcbEYmK2A8SZdQMpyDL8W2XhcKqvwY/qWbUhdxOvMs9P3f0vY+a37HMwXW78Rkl8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qYt3caMzyyfFOMjHyq1394htLyyZ2Lj+tdsToZMVzYtplMyO4dBrqSMGOlnz?=
 =?us-ascii?Q?rgMIrePNQbdXM64Rzz4TGSRtjzGIUcNAp0CsYVioY955joduJRljyPqVEc9j?=
 =?us-ascii?Q?pH8TBQFhqH159OnJsptHJQB1Ds1GiNRVkApvr6B2Hr6QWsIWBkelIMZMg7JA?=
 =?us-ascii?Q?xd9enq2ngiHMX2r9PdZ+B2br+unrHiI6yoGAjlji8kU2QksK9Uuf6+Z5vzKK?=
 =?us-ascii?Q?aSf48mMwQoE11luXu37gmc3Q8e1Qe/Iue8sOttPZ2uN8jgaNJJibVpcpULkD?=
 =?us-ascii?Q?1pfx30fr87Ro4s7Zutbmcp1x3Q9mBcw834xbDomZRqsdxGlXl40cr6ooscNh?=
 =?us-ascii?Q?PPmmH5FAFi04uejYhQdAXapknu8swtfaqQWM8m9za4Fvv5OWhDbsCX1VppV1?=
 =?us-ascii?Q?lAbwHWxPbg3A7t/25jEcAvOr+Lmb1NHL841H8tVxX4k/j1RHxO03mnDMhkDs?=
 =?us-ascii?Q?GROfcv6tHfEWZ2oELDU/xuio8tHoloVqrNKSgsqohAuOucEV5gxwm+mQNqE5?=
 =?us-ascii?Q?KaFA1sIsfKJ6a6aNLcILKM1ZrBU7EpnhpQEVUMJYWWnlywrqYp5ddtA6wTKh?=
 =?us-ascii?Q?RuxH5PXXsyEqfR2IlxPqE8BCHWoiLLV6Vv5RjhEsrLkTh3tOBVfzWcTDHnr8?=
 =?us-ascii?Q?pFUpVynPtFrR5EBfYar2QQUZOn18x96+3EVRsELupcN9g5i9djowimlTm1xW?=
 =?us-ascii?Q?hvtOSBXGD41UoeSsShUJJ2N/x7hu5rFxiKotlHaQz68WkwiJtUosUvC0p/sl?=
 =?us-ascii?Q?WO+/DbvqhunDZP83nI6WH/y6wzpau0/cpUdBKaC0L2lxVwqLPyLWjIHiShtq?=
 =?us-ascii?Q?1P1E4nBKDYMmKaenxIvLj009tIWpXW8WaotqI0qaH6oD/iVYdx6P5XO00uIR?=
 =?us-ascii?Q?98rQsT/mfMIxPaOh+quefspAnX/1AdkotiYONgZT2fzTw05k1TOJPThJlFHI?=
 =?us-ascii?Q?f8X3InkLMj5XKGTk6CRYC8pN8odcVEvW8rOcal0BbEiM/sHTGUbilZCr9f8I?=
 =?us-ascii?Q?eSTNbNXolmHq0+Kb2b3zcLgkvXP6yp9K+hV5M3iRF2gUgSgT5rcZi2IWoKZ5?=
 =?us-ascii?Q?dE86YBBQd33KNjAttIyfnya0OiMFI+ayr+Az92kFXyDD0R4lkPLG6hkjx+aY?=
 =?us-ascii?Q?vvbSZWLHhI7RstAI5AMv93zh5sG5CCwvo5R7bqKOx2bkw3wQaj40q79YkWl/?=
 =?us-ascii?Q?56hm4hlut7vt5ZbxPYEdZiUMoGQnB0oFWvQz92wHcG1TW+yS5Jar/T51Vdtj?=
 =?us-ascii?Q?0RksH3XAka8qFvOTyzHVAwBYz73Vn3mkWUHxRAxktofW7vadSSzS4Ir6UNm0?=
 =?us-ascii?Q?TxRo2qFFVK9dQyq1da+QG3rQv07KZGvfilkhr7LHWLwUxsi/t1KXRhMVUeZu?=
 =?us-ascii?Q?qjKUVP2D6bmsn7/lhMQYE7iRrH1/7y2h36/uA9sDrRRRwbSfesK2BTa9Ijlv?=
 =?us-ascii?Q?YsRtkGwSADZ30Qm5gG6SGjTeLASIFvSe05eceh0gH5UVc50rOh4EN0L0Hke3?=
 =?us-ascii?Q?8JRKVNyi+LDHH2NLMwxyfKfzsitjZN7TbEQw9COrTAN+d6Vxb1Pc0qAOeQ11?=
 =?us-ascii?Q?ztnTt0aa6pjmYTh7v4o1pp55JBCVvXlvxxx9kYbfYg6SikR84hFMP8pVEgx2?=
 =?us-ascii?Q?WeFgWLuKHYVxZM5nw+1OUw3qJUj289cbIyENpHedIduyVODD72ChViB3CaG4?=
 =?us-ascii?Q?Flp2Ax1nEadA4E2B/bn4eXbguIHB1Rva/e+47WTN0VQ6yfqiAunXpce3QgEq?=
 =?us-ascii?Q?ZZobkyIPGMBjGrTne4LStMc8+2P/oeA=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8ce742-5e9e-4497-b2c4-08da3d79eded
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:32.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3sV9OiNumvEIuZf8sjyaX0QnQT6mO/VyAfvnKoovKEUrp0Gsodj0Xz4DxPmk01jJgn1Bj8Lk+o52xin7GTnhqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
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
 drivers/net/wireless/celeno/cl8k/platform.h | 196 ++++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/platform.h

diff --git a/drivers/net/wireless/celeno/cl8k/platform.h b/drivers/net/wireless/celeno/cl8k/platform.h
new file mode 100644
index 000000000000..d0268eded0c3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/platform.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_PLATFORM_H
+#define CL_PLATFORM_H
+
+#define PLATFORM_DESCRIPTION_LENGTH 100
+#define PLATFORM_CUSTOMER_MASK   0xffff0000
+#define PLATFORM_BOARD_MASK      0x0000ff00
+#define PLATFORM_CHIP_MASK       0x000000f0
+
+#define PLATFORM_CUSTOMER(platform) \
+	u32_get_bits(platform, PLATFORM_CUSTOMER_MASK)
+#define PLATFORM_BOARD(platform) \
+	u32_get_bits(platform, PLATFORM_BOARD_MASK)
+#define PLATFORM_CHIP(platform) \
+	u32_get_bits(platform, PLATFORM_CHIP_MASK)
+
+#define PLATFORM_PACK_VERSION_V1  1
+#define PLATFORM_PACK_MAGIC_V1    "CL8K-AGC-PPCK"
+#define PLATFORM_PACK_FILENAME_V1 "agcppk.bin"
+#define PLATFORM_PACK_MAGIC_LEN   16
+
+struct cl_platform_table {
+	u32 platform_id;
+	u8 platform_description[PLATFORM_DESCRIPTION_LENGTH];
+	struct cl_agc_profile_per_bw *agc_profile[TCV_MAX];
+	struct cl_agc_profile_per_bw *agc_profile_elastic[TCV_MAX];
+	struct cl_agc_profile_per_bw *agc_profile_sensing;
+	const u8 *power_conv_table_2;
+	const u8 *power_conv_table_5;
+	const u8 *power_conv_table_6;
+};
+
+enum cl_agc_pack_type {
+	CL_AGC_PACK_UNDEFINED,
+	CL_AGC_PACK_PLATFORM_BINDING,
+	CL_AGC_PACK_PROFILE,
+	CL_AGC_PACK_POWER_TABLE,
+	CL_AGC_PACK_EOF,
+
+	CL_AGC_PACK_MAX
+};
+
+enum cl_agc_profile_type {
+	CL_AGC_PROFILE_UNDEFINED,
+	CL_AGC_PROFILE_FIRST,
+	CL_AGC_PROFILE_2_1_9 = CL_AGC_PROFILE_FIRST,
+	CL_AGC_PROFILE_5_1_9,
+	CL_AGC_PROFILE_6_1_3,
+	CL_AGC_PROFILE_50_0_1,
+	CL_AGC_PROFILE_60_1_3,
+
+	CL_AGC_PROFILE_MAX
+};
+
+enum cl_power_table_type {
+	CL_POWER_TO_POWERWORD_CONV_TABLE_UNDEFINED,
+	CL_POWER_TO_POWERWORD_CONV_TABLE_FIRST,
+	CL_POWER_TO_POWERWORD_CONV_TABLE_COMMON_ID_0 = CL_POWER_TO_POWERWORD_CONV_TABLE_FIRST,
+	CL_POWER_TO_POWERWORD_CONV_TABLE_COMMON_ID_1,
+	CL_POWER_TO_POWERWORD_CONV_TABLE_COMMON_ID_2,
+	CL_POWER_TO_POWERWORD_CONV_TABLE_ATHOS_B_ID_0,
+	CL_POWER_TO_POWERWORD_CONV_TABLE_ATHOS_B_ID_1,
+
+	CL_POWER_TO_POWERWORD_CONV_TABLE_MAX
+};
+
+struct cl_agc_platform_pack {
+	char magic[PLATFORM_PACK_MAGIC_LEN];
+	__le32 version;
+	u8 reserved[249];
+	u8 data[];
+} __packed;
+
+struct cl_agc_tilv {
+	u8 t;
+	u8 i;
+	u32 l;
+	u8 v[];
+} __packed;
+
+struct cl_platform_binding {
+	u32 platform_id;
+	u8 platform_description[PLATFORM_DESCRIPTION_LENGTH];
+	u8 agc_profile[TCV_MAX];
+	u8 agc_profile_elastic[TCV_MAX];
+	u8 agc_profile_sensing;
+	u8 power_conv_table_2;
+	u8 power_conv_table_5;
+	u8 power_conv_table_6;
+} __packed;
+
+struct cl_platform {
+	struct cl_agc_platform_pack *app;
+	ssize_t app_size;
+	struct cl_platform_table table;
+	u8 idx;
+};
+
+struct cl_platform_table *cl_platform_get_active_table(struct cl_chip *chip,
+						       u8 idx);
+int cl_platform_get_tables_cnt(struct cl_chip *chip);
+int cl_platform_unpack_v1(struct cl_platform_table *table,
+			  struct cl_agc_platform_pack *app,
+			  ssize_t buf_len, u8 platform_idx);
+int cl_platform_alloc(struct cl_chip *chip);
+void cl_platform_dealloc(struct cl_chip *chip);
+
+/**
+ * AGC (=Automatic Gain Control)
+ */
+
+struct cl_agc_reg {
+	u32 val;
+	u32 mask;
+};
+
+struct cl_agc_regs {
+	struct cl_agc_reg fsm_preset_p2;      /* 0x244 */
+	struct cl_agc_reg lna_thr_set0_ref2;  /* 0x25C */
+	struct cl_agc_reg lna_thr_set0_ref3;  /* 0x260 */
+	struct cl_agc_reg lna_thr_set1_ref2;  /* 0x264 */
+	struct cl_agc_reg lna_thr_set1_ref3;  /* 0x268 */
+	struct cl_agc_reg lna_thr_set2_ref2;  /* 0x26C */
+	struct cl_agc_reg lna_thr_set2_ref3;  /* 0x270 */
+	struct cl_agc_reg lna_gain_set0_ref2; /* 0x274 */
+	struct cl_agc_reg lna_gain_set0_ref3; /* 0x278 */
+	struct cl_agc_reg lna_nf_set0_ref2;   /* 0x27C */
+	struct cl_agc_reg lna_nf_set0_ref3;   /* 0x280 */
+	struct cl_agc_reg lna_icp1_set0_ref2; /* 0x284 */
+	struct cl_agc_reg lna_icp1_set0_ref3; /* 0x288 */
+	struct cl_agc_reg fsm_preset_p10;     /* 0x2A8 */
+	struct cl_agc_reg fsm_preset_p11;     /* 0x2AC */
+	struct cl_agc_reg fsm_preset_p12;     /* 0x2B0 */
+	struct cl_agc_reg ant_loss;           /* 0x300 */
+	struct cl_agc_reg gain_range;         /* 0x304 */
+	struct cl_agc_reg vga_ref0;           /* 0x308 */
+	struct cl_agc_reg lna_gain_set0_ref0; /* 0x30C */
+	struct cl_agc_reg lna_gain_set0_ref1; /* 0x310 */
+	struct cl_agc_reg lna_thr_set0_ref0;  /* 0x314 */
+	struct cl_agc_reg lna_thr_set0_ref1;  /* 0x318 */
+	struct cl_agc_reg lna_thr_set1_ref0;  /* 0x31C */
+	struct cl_agc_reg lna_thr_set1_ref1;  /* 0x320 */
+	struct cl_agc_reg lna_thr_set2_ref0;  /* 0x324 */
+	struct cl_agc_reg lna_thr_set2_ref1;  /* 0x328 */
+	struct cl_agc_reg lna_nf_set0_ref0;   /* 0x32C */
+	struct cl_agc_reg lna_nf_set0_ref1;   /* 0x330 */
+	struct cl_agc_reg lna_icp1_set0_ref0; /* 0x334 */
+	struct cl_agc_reg lna_icp1_set0_ref1; /* 0x338 */
+	struct cl_agc_reg saturation;         /* 0x364 */
+	struct cl_agc_reg ramp;               /* 0x36C */
+	struct cl_agc_reg dsp0;               /* 0x394 */
+	struct cl_agc_reg dsp1;               /* 0x398 */
+	struct cl_agc_reg dsp2;               /* 0x39C */
+	struct cl_agc_reg dsp3;               /* 0x3A0 */
+	struct cl_agc_reg lna_gain_set1_ref0; /* 0x590 */
+	struct cl_agc_reg lna_gain_set1_ref1; /* 0x594 */
+	struct cl_agc_reg lna_gain_set1_ref2; /* 0x598 */
+	struct cl_agc_reg lna_gain_set1_ref3; /* 0x59c */
+	struct cl_agc_reg lna_nf_set1_ref0;   /* 0x5A0 */
+	struct cl_agc_reg lna_nf_set1_ref1;   /* 0x5A4 */
+	struct cl_agc_reg lna_nf_set1_ref2;   /* 0x5A8 */
+	struct cl_agc_reg lna_nf_set1_ref3 ;  /* 0x5AC */
+	struct cl_agc_reg lna_icp1_set1_ref0; /* 0x5B0 */
+	struct cl_agc_reg lna_icp1_set1_ref1; /* 0x5B4 */
+	struct cl_agc_reg lna_icp1_set1_ref2; /* 0x5B8 */
+	struct cl_agc_reg lna_icp1_set1_ref3 ;/* 0x5BC */
+};
+
+struct cl_agc_profile_per_bw {
+	u32 id;
+	struct cl_agc_regs regs[CHNL_BW_MAX];
+};
+
+struct cl_agc_profile {
+	u32 id;
+	struct cl_agc_regs regs;
+};
+
+struct cl_agc_params {
+	u8 num_profiles;
+	u8 ant_mask1;
+	u8 ant_mask2;
+	struct cl_agc_profile profile1;
+	struct cl_agc_profile profile2;
+};
+
+struct cl_chip;
+
+int cl_agc_params_read_platform_id(struct cl_chip *chip);
+int cl_agc_params_fill(struct cl_hw *cl_hw, struct cl_agc_params *agc_params);
+void cl_agc_params_dump_profile_id(char *buf, ssize_t buf_size, ssize_t *len,
+				   u32 id, const char *str);
+
+#endif /* CL_PLATFORM_H */
-- 
2.36.1

