Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8820253298B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbiEXLlV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiEXLlH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:07 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28949939C1
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ghZ9jkrAttnyJ0br6pxC6SsCLMbRsDBFCQjKO/QlIAQOznhLmCTa9kkfxoK50KoeL1MrQ+Ij6rmkoUyAyxkf6RtsX7Nb5UbKDiMrdUEkXpYhWmRwRRLtGb09kN7C0EOupHrNFJT5W1JEOpduQ3p66aMj5UA3RMrezp4ZOk1UUNaG9TtVTyR4HxlZl8F/A+jTfYqjUlZIPNsjzHNIs2QS0Kq7T423YX2Gt9Wko2M9hetq5CopLCjQQQkYVZfK5j6T96e82v/QQU5iRZVM+M34TtlNu3Wqe6KFZ7uLb6OReuNXLMJ4+OWEa4HQB8/ep1KlyHaS5or0TzGfSBYU3MreuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezFzTKm+SPHZR3WunxeWCl5uQoANH8wfRCQqI6VTySY=;
 b=Ksx4GWAcVP2nIeAx2oCw29pGVtrP/YztsfAXOsc14+matp1vd0kmTk3f4flZxW9htj57FjL/rpaJm8WNuvWQFpYsLcp4sjP1DH7dXFqq+NJ5+B164iUPD1rQR6I7hShrEaW6BqNeU5weNs856dDr/fPNF/f51SiepK4z0bgK142rhhvrj872U1FuMJUiK+CPhbCCvLW7wwW4q8Olm6JNhyoMariXZ14t0n/qtchJRAp6oGFbJuBTMiZCdzZhjQnFUOXetRmd1/us4gisHU0OkLkzW5ZFrHoxro6K0dJuyf0wEZfN+wZqdl7OxIIOj8Zbmej0i+rOgcjEo6abnykiMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezFzTKm+SPHZR3WunxeWCl5uQoANH8wfRCQqI6VTySY=;
 b=FLWuPfo8w44k+TpTwSps1tvE//CZE/1Ywrz+x8Ur6P53q50O4bHpCfbzGIlZyGsvsg0oBmqdjLXFPvkYodOK9VIjclD4go58LcKZNAWH/K18YS8LBik29tDjigiBV+IxVDJ7AyOx+GTs9RkocHK0SwKbkjFlK9MgkElccwZrTFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:39:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:26 +0000
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
Subject: [RFC v2 73/96] cl8k: add sounding.h
Date:   Tue, 24 May 2022 14:34:39 +0300
Message-Id: <20220524113502.1094459-74-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6d9a4160-b921-452a-b44a-08da3d79f7c1
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915711238C8560B38CAD596F6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24UNXHCUQFfbO2asd8ZpYEvahFrXkkPzqdAFjNQD16oYO7ylOsUbQd4/iRZ6EFx2L+g03xQlkyS50aqDlFTGUhzau3n8USFIZHNv1iFZwUeowty3ktHGQfVpOGpDiCOKw1DWfXv2h9WuKUpLby1dG2UyEj6Dx8+DG9LWbNGWSvR30/BLATRiXsZvzcIlsn1e8gYuCvTfZoUWz01QMQaLRixVWmyvTs/HUClFo9HW5J2MfdocaQSLYEJknkfAoo8ozSAkLYrLRqX6+heNEkMb0HBAfNK77KxIQxv9Z7hxQwAhdnqOXVA5h1Be9rulylaqNrWo7+7GIAVA0db9NSPgc2URj0de1Eb6mNqYAzyTSgzwPneO9AixjDtFoNX9B1xKIZmeSeOw89DAGWgeBUnvr90H60oD3vIwWiEZfJ4XT1cs75XuUSWOk73HG2IcoJd+Z1WlQhYZO2UPkrjVfRkkcWVvSRfKK9fmzs9RRCp0V/pdaMBvYGZ5Toiw0pTkHX+TF8srX+/arQbUpWqX/RRIQt2jnrpxBqXNi0gQLVvt1/5s7z5p3LmYTctpNp9MbwxB6uNJ9LOLIyGnVYU8ebEe1TR9/mopo7IL2+hGtCDFH2UpH3dQX3o73pLI6YORirGzRsyan9NUPNJ5wvUha2KVNeSpYYZ6D2pTi5xBf/ZgENK4i2kve+ovhM4kR6biB4eBVs4AwHdIBlUq5lfOrtf5Kz1E0U716PQxGWWpryEIFCw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k+oqY7q4Z2+GsYGXDnuLIDr5Tk1/qzrzLEqfhPwo3UnE1G9GYYZa+NxwBoa2?=
 =?us-ascii?Q?3Qn4GXnDG36N3an2BxDWp3a/lKtWmS+JOFWkq8fqwgMjwZjduUuXiDSRTHNT?=
 =?us-ascii?Q?/9gF0MZ/ojiCPuKhFf3pl3tNfD9OlAIWT6vgtsu8a6eO/LA0HCWmS7r1J5UJ?=
 =?us-ascii?Q?O8hRSHA5lvO7kTrDO82AwwERnolk1bpNuRu+Obo9dDYFZmDb1Cae7JR2J682?=
 =?us-ascii?Q?W44aw8u5IBQ3RlsDuUBopSP+yCw9w2vl8hPfs6KitxcLBqC+i7btDd7JPDFc?=
 =?us-ascii?Q?7K2yyLLLRK0S5UEDMJ4OgmRKS4TiIcthCZ+phrP6iN7QuO3PRcaTKh0fIRJe?=
 =?us-ascii?Q?jOw693YBCr2eukSoFPloclW9jc/cX8oRN5XaIrYG2XYs42A5ZoQ1yeNRdTLd?=
 =?us-ascii?Q?uUaHnkCBBdiosHtHYIMAZB+mA7BERQKZKtnVjOejjAIM7zO4E22iW40HAzRO?=
 =?us-ascii?Q?pq4ceNRFlgKSJlZepR2YBbqAcFk4LmI8bypWU1W5F+75nihe4qoQZcIKCwlD?=
 =?us-ascii?Q?WmaZ+74iG6lvljSKSOuh+lEavCT3jR4xGuLMMUxPljzNAqWpbdeqqxIjj8sl?=
 =?us-ascii?Q?/lILC9SedKFeeiCeGI83E84DaDf9EZwxcNTNbpEhNgOpg8IwbotWbKTO1WEy?=
 =?us-ascii?Q?KMNC572gfp9ZxCPAhv1mogQy0XwsF91HK2d/5Ty4/GlyDWAEDRhD1SRP0a6i?=
 =?us-ascii?Q?NI1u7QxW35QjnI9NRGZ14yVP+IHRfvFbTMQaufHyzH2lyoUqxrDtC0dBZJQK?=
 =?us-ascii?Q?GHFJc2EXQDC1WXABg4hL0gkP6ZR2o9QMYq0R950gEt1SIkM+Gz+IOsxdp/hu?=
 =?us-ascii?Q?i3/jFKwBvVAPTLN3wP3p4vKhCADj8BJ8+o1SX7xQ35Oy7BSG5l3WU+jCzgeW?=
 =?us-ascii?Q?a82l5jFX4xhbfrJeNdBsW1Iuv9i8zv0UyW6bDRT2d8zvtSa2s0EUlRS1CY5V?=
 =?us-ascii?Q?OSIi77byXGxNYrU2BC5DRRyA5oG/idHNsNZQLiNQKrr7K2R6ieuCVxWUQy3o?=
 =?us-ascii?Q?OBnSfz4rsSupJ+HoXpNoV+faznXubiQwa4/S4LjCLat5AKg5e2eLEz/taBso?=
 =?us-ascii?Q?IIflmoAvVtDfTqRfRcXAOU8bzn1TrhDcj7C2gSFyRO97gJoIl7uACEoK3aJ/?=
 =?us-ascii?Q?XJbi0Kc0nWXxc8zoRpbu2+MSTHwgWdatdSzLeEXTILHzxG9KDFUaw10hIpVp?=
 =?us-ascii?Q?Rlipmnhn4rl47Adj/05RP6l1fplSJYXNQPPGDZBysvG+OJiEUXULMpbsfwkB?=
 =?us-ascii?Q?/B8ozehcyq9eQMi8c7vtCyYRWmOB86PIGV/dZZiNXiGDQWNVaZxdNtbWZqW6?=
 =?us-ascii?Q?vwLCy1a93xdOR9IOa82PSD6gs3aoIb2axr91cN7SAB5wqGvIYg8vbtXP2uRm?=
 =?us-ascii?Q?XEI6a7zLq3udvodzB7NYhGoSPBaygN6HI+wLx1MK4qTxrXoVebL6m1EEsAyC?=
 =?us-ascii?Q?pC4kF1YaElZLeQk6QNbaH7NBof8uCecSxyfP+wDghWrC/Y+0uWI4683uyu/7?=
 =?us-ascii?Q?xQ/JnR2JZ91L9lbAK/rscV5wHptiPYWsEVJImFt28fdsqKjJRKjFzaNNJJLf?=
 =?us-ascii?Q?0FDJoByq2UAkQuiMvbaXXjQ7dsFwygGIYrOa5la1lz/W4z1It9zaiuu9HuFy?=
 =?us-ascii?Q?9DljzOlRBcAcgixJYeLxDunNDjNv7Vst2b/oYAdD9X5ZCRDWW61K0PI2Nh78?=
 =?us-ascii?Q?R7c8+anT6DKSWeo+G0hspKFx9Id/F21BHfPwiUBl7+pZrKd4uOiI5M7olxVl?=
 =?us-ascii?Q?f2CQXwe7yI6kAL23xgPbZVqIgAUuGJs=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9a4160-b921-452a-b44a-08da3d79f7c1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:48.4756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 23c8jKV1RE7PAX7J/iG+goBaOlzJMyGrHBjeDEbNBeLlV7B40gn7YxOWdMAZ8fIeyfjp6LlYegKHSCCrh3OmKg==
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
 drivers/net/wireless/celeno/cl8k/sounding.h | 151 ++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sounding.h

diff --git a/drivers/net/wireless/celeno/cl8k/sounding.h b/drivers/net/wireless/celeno/cl8k/sounding.h
new file mode 100644
index 000000000000..abdf834150f9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sounding.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_SOUNDING_H
+#define CL_SOUNDING_H
+
+#include <linux/types.h>
+
+#include "fw.h"
+
+#define SOUNDING_ENABLE                                true
+#define SOUNDING_DISABLE                               false
+#define INVALID_SID                                    0xff
+#define XMEM_SIZE                                      (0x180 << 10) /* 384KB */
+#define CL_SOUNDING_STABILITY_TIME                     5
+#define CL_SOUNDING_FACTOR                             10
+
+#define SOUNDING_FEEDBACK_TYPE_SHIFT                   2
+#define SOUNDING_FEEDBACK_TYPE_MASK                    (BIT(SOUNDING_FEEDBACK_TYPE_SHIFT))
+#define SOUNDING_NG_SHIFT                              1
+#define SOUNDING_NG_MASK                               (BIT(SOUNDING_NG_SHIFT))
+#define SOUNDING_MU_CODEBOOK_SIZE_SHIFT                0
+#define SOUNDING_MU_CODEBOOK_SIZE_MASK                 (BIT(SOUNDING_MU_CODEBOOK_SIZE_SHIFT))
+#define SOUNDING_FEEDBACK_TYPE_VAL(fb_type_ng_cb_size) (((fb_type_ng_cb_size) & \
+							  SOUNDING_FEEDBACK_TYPE_MASK) >> \
+							  SOUNDING_FEEDBACK_TYPE_SHIFT)
+#define SOUNDING_NG_VAL(fb_type_ng_cb_size)            (((fb_type_ng_cb_size) & \
+							  SOUNDING_NG_MASK) >> SOUNDING_NG_SHIFT)
+#define SOUNDING_CODEBOOK_SIZE_VAL(fb_type_ng_cb_size) (((fb_type_ng_cb_size) & \
+							  SOUNDING_MU_CODEBOOK_SIZE_MASK) >> \
+							  SOUNDING_MU_CODEBOOK_SIZE_SHIFT)
+
+#define SOUNDING_TYPE_IS_VHT(type)                     ((type) == SOUNDING_TYPE_VHT_SU || \
+							(type) == SOUNDING_TYPE_VHT_MU)
+#define SOUNDING_TYPE_IS_CQI(type)                     ((type) == SOUNDING_TYPE_HE_CQI || \
+							(type) == SOUNDING_TYPE_HE_CQI_TB)
+
+enum fb_type_ng_cb_size {
+	FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_4_2 = 0x0,
+	FEEDBACK_TYPE_SU_NG_4_CODEBOOK_SIZE_6_4,
+	FEEDBACK_TYPE_SU_NG_16_CODEBOOK_SIZE_4_2,
+	FEEDBACK_TYPE_SU_NG_16_CODEBOOK_SIZE_6_4,
+	FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_7_5,
+	FEEDBACK_TYPE_MU_NG_4_CODEBOOK_SIZE_9_7,
+	FEEDBACK_TYPE_CQI_TB,
+	FEEDBACK_TYPE_MU_NG_16_CODEBOOK_SIZE_9_7,
+};
+
+enum cl_sounding_response {
+	CL_SOUNDING_RSP_OK = 0,
+
+	CL_SOUNDING_RSP_ERR_RLIMIT,
+	CL_SOUNDING_RSP_ERR_BW,
+	CL_SOUNDING_RSP_ERR_NSS,
+	CL_SOUNDING_RSP_ERR_INTERVAL,
+	CL_SOUNDING_RSP_ERR_ALREADY,
+	CL_SOUNDING_RSP_ERR_STA,
+	CL_SOUNDING_RSP_ERR_TYPE,
+};
+
+enum sounding_type {
+	SOUNDING_TYPE_HE_SU = 0,
+	SOUNDING_TYPE_HE_SU_TB,
+	SOUNDING_TYPE_VHT_SU,
+	SOUNDING_TYPE_HE_CQI,
+	SOUNDING_TYPE_HE_CQI_TB,
+	SOUNDING_TYPE_HE_MU,
+	SOUNDING_TYPE_VHT_MU,
+
+	SOUNDING_TYPE_MAX
+};
+
+enum sounding_interval_coef {
+	SOUNDING_INTERVAL_COEF_MIN_INTERVAL = 0,
+	SOUNDING_INTERVAL_COEF_STA_STEP,
+	SOUNDING_INTERVAL_COEF_INTERVAL_STEP,
+	SOUNDING_INTERVAL_COEF_MAX_INTERVAL,
+	SOUNDING_INTERVAL_COEF_MAX
+};
+
+struct v_matrix_header {
+	u32 format        : 2,
+	    rsv1          : 30;
+	u32 bw            : 2,
+	    nr_index      : 3,
+	    nc_index      : 3,
+	    rsv2          : 24;
+	u32 grouping      : 4,
+	    rsv3          : 28;
+	u32 feedback_type : 1,
+	    codebook_info : 3,
+	    rsv4          : 28;
+	u32 ru_start_idx  : 7,
+	    rsv5          : 25;
+	u32 ru_end_idx    : 7,
+	    rsv6          : 25;
+	u32 padding       : 6,
+	    rsv7          : 26;
+	u32 rsv8;
+};
+
+struct cl_sounding_info {
+	enum sounding_type type;
+	u8 sounding_id;
+	struct v_matrix_header *v_matrices_data;
+	u32 v_matrices_data_len;
+	u32 v_matrices_dma_addr;
+	u8 gid;
+	u8 bw;
+	u8 sta_num;
+	u8 q_matrix_bitmap;
+	struct cl_sta *su_cl_sta_arr[CL_MU_MAX_STA_PER_GROUP];
+	u32 xmem_space;
+	bool sounding_restart_required;
+	struct list_head list;
+};
+
+struct cl_sounding_db {
+	struct workqueue_struct *sounding_wq;
+	u8 num_soundings;
+	u8 cqi_profiles; /* Num of STAs with CQI active sounding */
+	u8 active_profiles; /* Num of STAs with non-CQI active sounding */
+	u8 active_profiles_prev[CL_SOUNDING_STABILITY_TIME];
+	u8 active_profiles_idx;
+	u8 dbg_level;
+	u8 current_interval;
+	u8 last_conf_active_profiles;
+	rwlock_t list_lock;
+	struct list_head head;
+};
+
+struct cl_xmem {
+	u32 total_used;
+	u32 size;
+};
+
+void cl_sounding_init(struct cl_hw *cl_hw);
+void cl_sounding_close(struct cl_hw *cl_hw);
+void cl_sounding_send_request(struct cl_hw *cl_hw, struct cl_sta **cl_sta_arr,
+			      u8 sta_num, bool enable, u8 sounding_type, u8 bw,
+			      void *mu_grp,
+			      u8 q_matrix_bitmap, struct cl_sounding_info *recovery_elem);
+void cl_sounding_switch_profile(struct cl_hw *cl_hw, u8 sta_idx_en, u8 sta_idx_dis);
+void cl_sounding_stop_by_sid(struct cl_hw *cl_hw, u8 sid, bool sounding_restart_check);
+void cl_sounding_maintenance(struct cl_hw *cl_hw);
+u16 cl_sounding_get_interval(struct cl_hw *cl_hw);
+void cl_sounding_recovery(struct cl_hw *cl_hw);
+struct cl_sounding_info *cl_sounding_get_elem(struct cl_hw *cl_hw, u8 sounding_id);
+void cl_sounding_indication(struct cl_hw *cl_hw, struct mm_sounding_ind *ind);
+
+#endif /* CL_SOUNDING_H */
-- 
2.36.1

