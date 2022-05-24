Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE32532948
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiEXLjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiEXLjJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B3532C4
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPyCu/ZiK4GwqmFEBCdWcUOsQXuvewMEmrPOzC84QEPEUnO0/+JyoN4pqeoYL2sCRbdX/ccGwXy7V97oFHvq3i8fXl+Gaz3D9RChv/Sy8w63bw+IgLyvasfQK+uVqP4CIfqb4YHjJgTBv9llgODT/N2vD+M40HhKsRcvA22K2TzY/CJPv3lAnPwAFV7vCbq0SB2TV+kOiYdedYBJSnqjMVhGV4HOBot+pp0KIE6VpU7Tv9dNH6JtWO+Qlg04DHEISBxWeiqn6qRss1rt9IQIn612Iy73Npz30785wgmSzw9iw4jwUed4eh0C6iBKiQ+cEXk3elAkkn8yxY1Orwqaqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcmkEnhLJ6CF6jArpVXBbfMrT/pwQUHyBkZBxXDxtHo=;
 b=Qj70DEXAbuFPRpYvvuD1f5XJHIx+EUrXw8GpB/461fcE5s8W53mDrq1tGdFuMjdPlPhlGbryUPrMw79VaKZN/S4z2oBCLPKWlkqB2kaUHIH/7SM5kgfPmkyj9BclavdzWeCRmhqNeqSxdrEloa2Dj3u2CtIBDEDlgOFgVxnRUbGFhvbKaznt5JN0ZIm07NdGjnUIJbcBmNLfCnOuR9DrciZY6aN1cZzqIDRzDCKmu0o2vrLRl/z++PC5OK4BTtxQAmnSGI2q3eeooTjGw22Sp9UcVKtTioNHTgesschYKF7XMKDtBUa721Lqz/FIeD4RmgsmTpwao4BJvSxFPAS5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcmkEnhLJ6CF6jArpVXBbfMrT/pwQUHyBkZBxXDxtHo=;
 b=CpvZcNrHnHRySRissJ6L19keqhbRO1D6QJHgpO6lDVqmtp4Vf9MamkjKfquLbn7J65L79LadQHFH796TP+vg+4HAOp4jBgn135cLlAzqoM4RXzNtCWJ+Ge1Lt3wc1MBRXVkedZzcyOarIOHCSlORzIXDiYegyMRtM8r960W5f9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:38:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:53 +0000
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
Subject: [RFC v2 59/96] cl8k: add rates.h
Date:   Tue, 24 May 2022 14:34:25 +0300
Message-Id: <20220524113502.1094459-60-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d866c8ef-ed8b-4388-1d81-08da3d79f0ad
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB091530FBBEC036548210B560F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fz5KSW1MlZR92ea3o7rifGPuJ/iwUELI1DuG5FMOVwyL89NNda2augsvsihVkykpCL3nL4zD47/kd8JBxABvEfTwKBeP2eM4rABm0tdg9F/YgkfzpvSfoToMva6+OU25MT7c+TiMFjjtTsNWdeXMo4ENQAi/Nb4WzvnOaJtUryxRWicmXWl5GqDURefVltj9UHjF0yT3T20e3jM4p+iynWjxO27nD4StjyqdcuRz7hhFyGDZWubF1p3L88gtop/NiIryp68qtY32ya4V9+xZjUxtf44cNwg0cG0BQoqPVc4Lca2rfpxLKGMvJCEXRvXqY08FCehYsv/D9b/jFsju0TpL2/SyuNJUDpQNFJMKHlp+jSER7ZZAq/IuDLHmklmrlLrQwJjk/0oYQk+Zf0/MtxuOVn02Lau12XwMhmZrZT4pXQjp9BzrICCnYmjCWQKuuELb4JOz6F+JzuGx0XcaRAd7hjYhofweX+ezLRiFF3FND1iGJrJ7G4RQG8Y3u/7y+zfCPLaJvcij3Fpqf5fLpBVry3f9k4W5KCDYgjUYjZZANLhGuISoPCZM8ZPeM6mqisuTQspUtWcHbUdhZ8r0XMnCs9TXLRUanwsnijdZtGoymCb4yIJcjAIz/2OO8VsnIN9tH5z/lUgz3/lklTZEVIE/ODZSzZTVZn0cZeWAaa8knzCLq6aJBwzWnK3z/3UVTUi7BLMHUlzGvrZtqiwhLjB6AM0EZlErUmq+9nd8KoA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JxW/yuCO7rAWk4ST5vXd9wssBY2C5q7SPhC6jFGWga8f8DDZ398ePwy9N+dG?=
 =?us-ascii?Q?1IsqyZ5ZzcmsnLeQYDIQAPUgpXqTCdnO5S/t5hinEq8UPu7XbBZ4rVl/Ulw+?=
 =?us-ascii?Q?KKNocr6FZI3K/Tzy8dGQICltCTd5QpYIFaGIgU0wBgJ5PWD4FaIE46oT/CPs?=
 =?us-ascii?Q?xk5+x48oqhQNPzQFO/pC27AF4Lfq9F3BIG3vi64pfutPybr7grcpcYD/7acg?=
 =?us-ascii?Q?joIuWw+JAmsb9HDQqki7PEYCVRzel4eySiu/tVSmihTmL2wFVST5oD0BvqvQ?=
 =?us-ascii?Q?o0NVqZWTEKP+GPZz90mIW8592Il5o2OsR54woI24m2WTM+P5nb1eD8uYaYP1?=
 =?us-ascii?Q?BzmfksWEkbkQIAZcoDit7zvcwIqxbJDy0yhvdvPE5Cs3quuPoQkAIw0csxaY?=
 =?us-ascii?Q?HZ7oMymi0KcEZc7u1ytPbZc84P5q0BtSdIotkJs0rnVletFLszodKu2uglrQ?=
 =?us-ascii?Q?UIPG/yGdWh53/idlCdpWl81COXWzFyF0ePy9d2858bboMJ/iaM2/fbAJ66ko?=
 =?us-ascii?Q?R09GCdG0XunUDcWX+Al+JegMyU9rNMCtdzK8LkF0sWU6/kX+2h9hck9WW9DK?=
 =?us-ascii?Q?/u9kQUltCyD3iQLWNC9HRuC6F79x4Zz/L2ParxtuVDhUR54BFfATc6P5KjNa?=
 =?us-ascii?Q?/99siOhscg0WwJp0+XYnzrt28WQTALyy7BEfmvqlnanyS8w1VhehLUGyTKMa?=
 =?us-ascii?Q?tnHTrbRQ4eC6e7NN1x9co63PhVQ8ELlmy71aNtl1GGWDwnP32/ivCG5ngdWg?=
 =?us-ascii?Q?Y1DJgxcHs0/VcAlATTRC25Cl2cYl0xJYc1d6scEcz8jxrYNARAaXezdxEppz?=
 =?us-ascii?Q?aT3QHUXBxG5u/K5FQdwkKvwsrpTRQpG8TVS+kFcr7FenF+akpSGBUS3tyCAP?=
 =?us-ascii?Q?Z/FAIPVGm5dKEA3FPtcCr7q48xT4Tf0BplFhSTRHS36Ipp7VYFXZljRI5HuX?=
 =?us-ascii?Q?cyQkEF1tImLA+9B3DMIsIux3/NTh5V51yngBE2CgRSNcMQOHD9Sz3N3EGu5+?=
 =?us-ascii?Q?NBwanN6MI1FqL92rTtKTWapTj/TuapYuUQxrH/Dtz3/lLlbjrxzZC9oUHr7e?=
 =?us-ascii?Q?Vk7vIKaJrrMgAtdHXpqWQugeBz2ij8piIk8P/tzA+SBieMR9Q9qmlaMuq7xR?=
 =?us-ascii?Q?i1coBtVP1/0eLmAD5pQx7G1W7UzrbA1+kHHE1GFWXxrojA3uVVfFW2AEFn3N?=
 =?us-ascii?Q?C+tFQNCQoU06atVteg7g+lpNoeHBduUtvEo+wvPvX48g+JJIfM6Hgl42fPsp?=
 =?us-ascii?Q?uaqiSnU9MGafD+ktLxF+eJMhvg0L9XNWnisqtDvcUZDh+CB4qlVxv1BHwR+Z?=
 =?us-ascii?Q?VwWXjKdmMotkNSuLULCjiwyiOmZ5BZTItEQTnUd8xPV8v+nbj6b5AONRFEou?=
 =?us-ascii?Q?cHj5Xw68qyvqbzmm09pTUp/zYzEn9bp2Q8UHLLNoh4l8huQ1FOqBuu92zY0b?=
 =?us-ascii?Q?le8riLYIKE7RbF/Mgi/o6Dw3TgKf396W4a2kPqr6pRgDC5+HYWwUEmN2Eb22?=
 =?us-ascii?Q?HQMmC3TGb0xsU01tUpdncCkt3ymR0ULtLTt2NmbxfWUwjOnARsgayNsv35L+?=
 =?us-ascii?Q?fHfhKn6LM7ivEe7e0E5Cx55fTiIEoNIzIVHZ5W9ZeQNroXYyUD9cwDmDIjR6?=
 =?us-ascii?Q?+QzxybwJLM7MNs+g/5soBg+0w74s1S1VWvXIZc/Q8hQnICtHSncFSsnZUuL8?=
 =?us-ascii?Q?RKgxHG6A2D3/TqvY+TG8NtoV949L2tgUFBph0826LjTO05YgGJBDD9NsQ+Mk?=
 =?us-ascii?Q?jCBOmwcURkrgU2f7H756FupRQBGxeF4=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d866c8ef-ed8b-4388-1d81-08da3d79f0ad
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:36.5966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8O0x5MSZxqODJ410B1CAuq6gXln3sgLrg+6ZmqkfdizG/JF/4wp9zFMv1E/XFoOgJRXCov1gVbFE3VQvQ+B2w==
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
 drivers/net/wireless/celeno/cl8k/rates.h | 154 +++++++++++++++++++++++
 1 file changed, 154 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rates.h

diff --git a/drivers/net/wireless/celeno/cl8k/rates.h b/drivers/net/wireless/celeno/cl8k/rates.h
new file mode 100644
index 000000000000..223924f21dc2
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rates.h
@@ -0,0 +1,154 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_RATE_CTRL_H
+#define CL_RATE_CTRL_H
+
+#include <linux/types.h>
+
+#include "ipc_shared.h"
+#include "wrs.h"
+
+#define RATE_CTRL_OFFSET_OFDM          4
+#define RATE_CNTRL_HE_SPATIAL_CONF_DEF 0xF
+
+/* Op_mode field in mm_update_rate_dl_req structure */
+enum cl_op_mode {
+	RATE_OP_MODE_FIXED,
+	RATE_OP_MODE_DEFAULT_HE,
+	RATE_OP_MODE_DEFAULT_OFDM,
+	RATE_OP_MODE_DEFAULT_CCK,
+	RATE_OP_MODE_STA_SU,
+	RATE_OP_MODE_STA_MU,
+	RATE_OP_MODE_MCAST,
+	RATE_OP_MODE_BCAST
+};
+
+/* Value to be set in tx_host_info */
+enum cl_rate_ctrl_entry {
+	RATE_CTRL_ENTRY_NA = 0,
+
+	RATE_CTRL_ENTRY_STA,
+	RATE_CTRL_ENTRY_FIXED_RATE,
+	RATE_CTRL_ENTRY_MIN_HE,
+	RATE_CTRL_ENTRY_MIN_OFDM,
+	RATE_CTRL_ENTRY_MIN_CCK,
+	RATE_CTRL_ENTRY_MCAST,
+	RATE_CTRL_ENTRY_BCAST,
+
+	/* Entry size in firmware is represented by 3 bits */
+	RATE_CTRL_ENTRY_MAX = 8
+};
+
+/*
+ * sw_ctrl includes eights bits (16 - 23) to be used by software.
+ * Bit 16 is used by driver to indicate tx_bf.
+ * Bit 17 is used by driver to indicate fallback.
+ * Bit 18 - 23 are still free.
+ */
+struct cl_rate_ctrl_info_fields {
+	u32 mcs_index        : 7;   /* [6:0] */
+	u32 bw               : 2;   /* [8:7] */
+	u32 gi               : 2;   /* [10:9] */
+	u32 pre_type_or_stbc : 1;   /* [11] */
+	u32 format_mod       : 4;   /* [15:12] */
+	u32 tx_bf            : 1;   /* [16] */
+	u32 fallback         : 1;   /* [17] */
+	u32 sw_ctrl          : 6;   /* [23:18] */
+	u32 tx_chains        : 8;   /* [31:24] */
+};
+
+union cl_rate_ctrl_info {
+	struct cl_rate_ctrl_info_fields field;
+	u32 word;
+};
+
+struct cl_rate_ctrl_info_he_fields {
+	u32 spatial_conf    : 4;   /* [3:0] */
+	u32 starting_sts    : 3;   /* [6:4] */
+	u32 ru_index        : 6;   /* [12:7] */
+	u32 ru_type         : 3;   /* [15:13] */
+	u32 ru_band         : 1;   /* [16] */
+	u32 mu_usr_pos      : 2;   /* [18:17] */
+	u32 dcm_data        : 1;   /* [19] */
+	u32 num_usrs_mu_dl  : 4;   /* [23:20] */
+	u32 ru_alloc        : 8;   /* [31:24] */
+};
+
+union cl_rate_ctrl_info_he {
+	struct cl_rate_ctrl_info_he_fields field;
+	u32 word;
+};
+
+#define DATA_RATE_INVERSE_Q 15
+
+struct cl_inverse_data_rate {
+	u16 he[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+	u16 ht_vht[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VHT];
+	u16 ofdm[WRS_MCS_MAX_OFDM];
+	u16 cck[WRS_MCS_MAX_CCK];
+};
+
+extern struct cl_inverse_data_rate inverse_data_rate;
+
+extern const u16 data_rate_he_x10[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+extern const u16 data_rate_ht_vht_x10[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VHT];
+extern const u16 data_rate_ofdm_x10[];
+extern const u16 data_rate_cck_x10[];
+
+struct cl_hw;
+struct cl_sta;
+struct cl_sw_txhdr;
+
+u32 cl_rate_ctrl_generate(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			  u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi,
+			  bool fallback_en, bool mu_valid);
+void cl_rate_ctrl_convert(union cl_rate_ctrl_info *rate_ctrl_info);
+void cl_rate_ctrl_parse(union cl_rate_ctrl_info *rate_ctrl_info, u8 *nss, u8 *mcs);
+
+void cl_rate_ctrl_set_default(struct cl_hw *cl_hw);
+
+void cl_rate_ctrl_set_default_per_he_minrate(struct cl_hw *cl_hw, u8 bw,
+					     u8 nss, u8 mcs, u8 gi);
+bool cl_rate_ctrl_set_mcast(struct cl_hw *cl_hw, u8 mode, u8 mcs);
+void cl_rate_ctrl_update_desc_single(struct cl_hw *cl_hw, struct tx_host_info *info,
+				     struct cl_sw_txhdr *sw_txhdr);
+void cl_rate_ctrl_update_desc_agg(struct cl_hw *cl_hw, struct tx_host_info *info);
+void cl_data_rates_inverse_build(void);
+u16 cl_data_rates_get(u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi);
+u16 cl_data_rates_get_x10(u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi);
+
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+
+struct cl_dyn_bcast_rate {
+	u8 sta_min_mcs;
+	u8 bcast_mcs;
+	u8 wrs_mode;
+	u8 ltf;
+};
+
+void cl_dyn_bcast_rate_init(struct cl_hw *cl_hw);
+void cl_dyn_bcast_rate_set(struct cl_hw *cl_hw, u8 bcast_mcs);
+void cl_dyn_bcast_rate_recovery(struct cl_hw *cl_hw);
+void cl_dyn_bcast_rate_change(struct cl_hw *cl_hw, struct cl_sta *cl_sta_change,
+			      u8 old_mcs, u8 new_mcs);
+void cl_dyn_bcast_rate_update_upon_assoc(struct cl_hw *cl_hw, u8 mcs, u8 num_sta);
+void cl_dyn_bcast_rate_update_upon_disassoc(struct cl_hw *cl_hw, u8 mcs, u8 num_sta);
+void cl_dyn_bcast_update(struct cl_hw *cl_hw);
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+
+struct cl_dyn_mcast_rate {
+	u8 wrs_mode_default;
+	u8 wrs_mode_curr;
+};
+
+void cl_dyn_mcast_rate_init(struct cl_hw *cl_hw);
+void cl_dyn_mcast_rate_set(struct cl_hw *cl_hw);
+void cl_dyn_mcast_rate_recovery(struct cl_hw *cl_hw);
+void cl_dyn_mcast_rate_update_upon_assoc(struct cl_hw *cl_hw, u8 wrs_mode, u8 num_sta);
+void cl_dyn_mcast_rate_update_upon_disassoc(struct cl_hw *cl_hw, u8 wrs_mode, u8 num_sta);
+void cl_dyn_mcast_update(struct cl_hw *cl_hw);
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+
+#endif /* CL_RATE_CTRL_H */
-- 
2.36.1

