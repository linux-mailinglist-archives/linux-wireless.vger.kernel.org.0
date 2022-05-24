Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C607C53294B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiEXLjP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbiEXLjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:13 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EFA84A19
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+MPfer5Z63W1BBQLTq7piipz//mz5sU0ISMkeq8p2F2teHYnHmzAIvc9KjgkFbRbYaO5D8ab+A0RSXS9NifSwSdhe9ho/6jfueRqHlxRZuy9sCgIxxUqFOaiNAKdHlGS6Rlg1jtPlV2RBUN+t3Sarj5QsyXS8/fbHeZtfnvzqp/M2bi7cshW9PLaUvt6b8D5eaO6Nm7lGl7hp/pjkvb7fmTY4DcXcakEf74odIRsNq+l3zbIuWyymK0pys884ErTLzDBDE4oVF1PB8F8OMoAUqP7nQNEXA7lydXo90vdzZq9xJfdcpUy3AxFCezR9UePr1ZYsuDDk4hnoIM3yToBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saLagVdEJcwvy0SK/qSNW2bOKZlh8ZsljFy6tjamgP0=;
 b=doSwuT/qmJv+KTe/ZdKqz5jJkX3dI1W0TUm1xzyoVvwG2UonbK/rvu3KZCKo2qj28d8Yu+541OD/FRaRVWna1HpwuHlJD8Pu2A3xj7HNT3nSeeysqjha9IxbtapPP6YI/wyCE+Scnv3lgtcgvh20WJ7l6wo3ZFyhmuhgGaLnbyzHhR86IoeDAZrVnkK+mY9J/FDHyRD+etPgHQu5HbSCvO/mRjMRRHshAGmmpQacLWH70HreKXm3dFqOkUsF5kqyapmA0JKXvjLVHnOzzbwa4d18GhkhEwwo0CcxihY1UM6MAo6JVO5IhpRQz1ROBLUYLo+U1Ib7ElI4eXsnNmWkfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saLagVdEJcwvy0SK/qSNW2bOKZlh8ZsljFy6tjamgP0=;
 b=po2DbkKsK7TZeuV8FJ845dC1xDwpG3W4/4lMTnl9D7dKkMa+XFSTB+fv/Z3SgCSYs4a+NVbBqctATJzIOfZHMrhLJvnSHsi/mnRnzRrwZ65r63Uo0RtlKJDz7LIMjYnMjOcY3YdhDlHIv7f6lZLn/JqwHcdV8qdFCMfdldjmS4U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:38:39 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:39 +0000
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
Subject: [RFC v2 35/96] cl8k: add ipc_shared.h
Date:   Tue, 24 May 2022 14:34:01 +0300
Message-Id: <20220524113502.1094459-36-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13e586da-0947-451b-1f19-08da3d79e092
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB030521919D0B3FC567240EBAF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OBy8jZuRYnSplflL5c7eh7mLgCRearMJujpX5gFPP7K7nRn4cMVMH25aEnG9blURnQWjHWqBuhew/fbT2pY6HrFgRZAtSZKe6BfbzUaua9MUgLpdNRGEiDlTBEvCW7CljqW9ewLEs2LNzI/X4qA7PkdxNscaExgDeTHiJ1yLbpByw5cTlP48JhTNGN6IDKMevOPSzjb+pCcLcxcXp6SPxAaVRzAHeVLkPp6awb6FNaOPnfQCHh0/L4BN05lpaLTCGJ6Ki82tdOBGqjqzUboHvT5qQwdGxsAVjn3lYUMx2C1dwkBFpiCz2Yo0iKZ1Ksa+BX52yi0i6/P3kwOlUvzPOLCDJgJkB3+zmbSpszq50iN0KwdKhydf/OdBhmmE7FJXrVflXcHRJGFIe7ysWZlAWN2Y6Is3SXeOta/O4aJoFt5FFm8ZnXGZAxgLsVRMO4YHYY5vXq5U2pOqwiouR4i73o1/L24jbWhiMdLZVG6ocehCeog2IHIHWB9kbo6mrRBmQnOx9g9KknhmQadTp6I+X1X4xuQOHZcEYOY1zJk05tPZkgc7WT+1H3RuLGJR8WhoADBoIxORlS7oueo15bcw770bDzK58CevSiu6l/2v8nbxDlxfozmPAJ7u5qjyonTgyiO4E2F2cflyJSfQwHMudSpCq0N1BxtTgwdiWqAo52dKDf+swsigvYSeV8oWMDx/mrTh7Nw1DbbYQUeOkdCoIRj451I+nlkYJXLxnPu3IKA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(30864003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BVRmYO4Zd7l7CIceZY/WUW2XP0udnOE8ZwWz1zcubo3R92o+mzSrGYsrQvgj?=
 =?us-ascii?Q?+vwLte/4eQumHhHXyg/+oJi7z5Xu75mS7bJe75gDpLKuGxFHbLR4bNCgx6vJ?=
 =?us-ascii?Q?F0N2Fk6roDsA5+BgQ3eE/2QX7dEatZUwN3A7gNbgdCiUOLbR7hOYTL2smOue?=
 =?us-ascii?Q?CcuwjgWb08TtUQTkRNDsZ6D6u/UnvBzsyYjZ8jpn2AS66RMspo+/E85kmeJW?=
 =?us-ascii?Q?6KG/hLf4QW6CLBonN1jwAkksRVaa5AASdle4FdlNpLIyajlE27nz4tD5DlWq?=
 =?us-ascii?Q?NngLRvHml2YbDI6xJ1RNV+HtHBGCnvSgS/SC8ryRlCtLuI+HiqerVUqtnBji?=
 =?us-ascii?Q?nytr4kDk/1VCM5fWju5srb7FuqgshZxlRiMiL8N8yeUQRW1K2SqhZ9f7axiH?=
 =?us-ascii?Q?nZUHR/XsrLM7nitHxnWXtwBc0MV7KsTDSh3lQYc2kszQN+1XmVcO/aoi7ThW?=
 =?us-ascii?Q?Wqw3S2FEqrV9Cyx7RtMie6jDbzZqfjUnpHqbmxWbofp1oL5TnL6tP6BaeKBt?=
 =?us-ascii?Q?7LvgNlSRAdaqkBmRJhZMHgbB7c4vBLI1LbAYZsSMTOIbNb3kkkPyLCDIN2y2?=
 =?us-ascii?Q?UHFqtZ6jX2DWOSbxX3v1LmsnJBDxZoNerxxLg/f9VUQ7OjKOBq7s7ggxHF4m?=
 =?us-ascii?Q?AsRKC+Rt+aPB+ajcnP9zoEAZHr7l2zpDhemW5bECO9T/YqCOhsGFCWYXTPrV?=
 =?us-ascii?Q?7kQ7pzJDtu8Ha5GHNTJcd2X+ibx7h1O2ipPGwQInF3C3OcRKQ8Q8rEbqOnc7?=
 =?us-ascii?Q?XHgDkcI27WTzX4oUm1b6lp6ooR67j6j/YuYoVdO5q6hXACXtCEmb+NUHjbLh?=
 =?us-ascii?Q?TqRm03E4i0r7B1Sn4nT2+L26c0sP2EoSIJyX1Qhf9qVV9yvw8RALnhjBm9JK?=
 =?us-ascii?Q?ihSsqvAN25oUYkXZkzzU1K3uDApCxj/xGaIrg3wALHh2qHgEX1Z0GMgxgUA6?=
 =?us-ascii?Q?PT1EAxkj2ST83CjY6DdVYwL1MPblD+kLpq1FQjdnmXvVUzrY12G5CUPocAPi?=
 =?us-ascii?Q?FskKyhigQhY0Ma+pDyYV88/+TttHiZXVUSEnTbRSKOLIgOgqOCYCIqogv1Ls?=
 =?us-ascii?Q?ZwOM41fc3UbWGvfiS+Lo48t+iIBLLzotwD4zUbpSDuseQWgs9PB4jeTKAjM0?=
 =?us-ascii?Q?G66CF6WC07ZzRiQCV92tmdz/oSXj0LVPuDt+jvd6iOJNhsmeZmbLN/G5AX1f?=
 =?us-ascii?Q?aNrRAnuu0c3ove7G4IcrjTj3fV4s9tXohquAJ44DPw/uRJH/hzgNNYY3PTGR?=
 =?us-ascii?Q?+aXvVBP8KhJ1elpUMLai3gIqR5ajoG8jVd7gJc40qUWFlokrrxrFZ8UxcD4f?=
 =?us-ascii?Q?msHfjui/lJDsy1US6LnMEjKptMhMPUz48v/u7Cz5b5QOyvk2LBeJe0XMt25r?=
 =?us-ascii?Q?NdWTwCqScjTYTUq0P0jmdOQyULPt0MVjWXYfoOo1JXK4Fv3yIO+pJAgNg8bZ?=
 =?us-ascii?Q?KjO1/SUWxPJg2+P3b96aSMbVKCny0e9iWGGUotqo6Kp9RFGW2jhDqZmhNmps?=
 =?us-ascii?Q?qmD3XXBQEW/BGRCN7M/Svvn9E7qpHuzkTe3vy1YtqHQuuvkum93+PDDv/jo0?=
 =?us-ascii?Q?V4Cek49FeILUk46hso1AgdPNxez5uFPxMJ0JgfncFUML4tkC9mHrutmkDnUB?=
 =?us-ascii?Q?13BCUKombBsDCzxuwDYVnyRkHKAKQUXG3i8zh//pfcDhy0YDC0ISawTeaFIp?=
 =?us-ascii?Q?OlP2VVcHaMlAgcjZsdERSOmgf++NRbOcLz+WQwLK2l4O5MQcKJZDSOH1Wo6F?=
 =?us-ascii?Q?4HaHrf7hYDj87oLRnXpfWl2n0dC1hr0=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e586da-0947-451b-1f19-08da3d79e092
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:09.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MfwSHfNVr4KotS46lL9op320U0Ea+KUq6vua7KdkdoSKdPeE0C0XN5HchxAsg8N4mMi5nrnoDQizv1JwI+XW8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
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
 drivers/net/wireless/celeno/cl8k/ipc_shared.h | 1386 +++++++++++++++++
 1 file changed, 1386 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ipc_shared.h

diff --git a/drivers/net/wireless/celeno/cl8k/ipc_shared.h b/drivers/net/wireless/celeno/cl8k/ipc_shared.h
new file mode 100644
index 000000000000..b8560bc632c7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ipc_shared.h
@@ -0,0 +1,1386 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_IPC_SHARED_H
+#define CL_IPC_SHARED_H
+
+#include <net/mac80211.h>
+
+#include "def.h"
+
+/** DOC: IPC - introduction
+ *
+ * IPC layer between the FW (XMAC -> LMAC, SMAC, UMAC) and the driver. Driver
+ * talks with lower layer via custom IPC messages and DMA. Basically, drv <->
+ * fw messages flow consists of %cl_fw_msg, that contains info about direction,
+ * message id (which is enum field of %mm_msg_tag or %dbg_msg_tag) and payload
+ * itself.
+ *
+ * Messages may be synchronous (with the confirmation feedback) and
+ * asynchronous. The latter is typically being used as inidication of
+ * occurrence of some event.
+ *
+ * Driver              LMAC/SMAC
+ *  +                     +
+ *  |       AA_REQ        |
+ *  |-------------------->|...+ (Request)
+ *  |       AA_CFM        |   | Mandatory control messages
+ *  |<--------------------|...+ (Confirmation)
+ *  |                     |
+ *  .       BB_IND        .
+ *  |<--------------------|... Asynchronous indication
+ *
+ *  Messages are using prelocated buffers and size limit of %IPC_RXBUF_SIZE.
+ *  Each message may have verification pattern, that allows to verify the
+ *  validity of payload. Most important TX/RX flow operations are tracked and
+ *  are reflected by stats change (like &cl_rx_path_info structure).
+ */
+
+/*
+ * Number of Host buffers available for Data Rx handling (through DMA)
+ * Must correspond to FW code definition, and must be power of 2.
+ */
+#define IPC_RXBUF_CNT_RXM 2048
+#define IPC_RXBUF_CNT_FW  128
+
+/* Bucket debug */
+#define IPC_RXBUF_BUCKET_POW_SIZE 5
+#define IPC_RXBUF_BUCKET_SIZE     BIT(IPC_RXBUF_BUCKET_POW_SIZE) /* 2 ^ 5 = 32 */
+#define IPC_RXBUF_NUM_BUCKETS_RXM (IPC_RXBUF_CNT_RXM / IPC_RXBUF_BUCKET_SIZE)
+#define IPC_RXBUF_NUM_BUCKETS_FW  (IPC_RXBUF_CNT_FW / IPC_RXBUF_BUCKET_SIZE)
+
+#define MU_MAX_STREAMS     8
+#define MU_MAX_SECONDARIES (MU_MAX_STREAMS - 1)
+
+#define CL_MU0_IDX 0
+#define CL_MU1_IDX 1
+#define CL_MU2_IDX 2
+#define CL_MU3_IDX 3
+#define CL_MU4_IDX 4
+#define CL_MU5_IDX 5
+#define CL_MU6_IDX 6
+#define CL_MU7_IDX 7
+#define CL_MU_IDX_MAX CL_MU7_IDX
+
+#define IPC_TX_QUEUE_CNT 5
+
+#define IPC_MAX_BA_SESSIONS 128
+
+#if IPC_MAX_BA_SESSIONS > CL_MAX_NUM_STA
+#define IPC_MAX_TIM_TX_OR_RX_AGG_SIZE IPC_MAX_BA_SESSIONS
+#else
+#define IPC_MAX_TIM_TX_OR_RX_AGG_SIZE CL_MAX_NUM_STA
+#endif
+
+#define IPC_QUEUE_IDX_DIFF_ARRAY_SIZE 6
+
+#define IPC_TIM_AGG_SIZE (IPC_MAX_TIM_TX_OR_RX_AGG_SIZE * 2)
+
+#define IPC_TX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(idx) ((idx) * 2)
+
+#define IPC_RX_QUEUE_IDX_TO_COMMON_QUEUE_IDX(idx) (((idx) * 2) + 1)
+
+#define CL_MAX_BA_PHYSICAL_QUEUE_CNT (AC_MAX + MU_MAX_SECONDARIES)
+#define CE_AC_MAX (IPC_TX_QUEUE_CNT + MU_MAX_SECONDARIES)
+
+enum {
+	AGG_AC0_IDX = AC_BK,
+	AGG_AC1_IDX = AC_BE,
+	AGG_AC2_IDX = AC_VI,
+	AGG_AC3_IDX = AC_VO,
+	AGG_MU1_IDX,
+	AGG_MU2_IDX,
+	AGG_MU3_IDX,
+	AGG_MU4_IDX,
+	AGG_MU5_IDX,
+	AGG_MU6_IDX,
+	AGG_MU7_IDX,
+	AGG_IDX_MAX,
+};
+
+#define DBG_DUMP_BUFFER_SIZE (1024 * 40)
+
+#define IPC_TXDESC_CNT_SINGLE 16
+#define IPC_TXDESC_CNT_BCMC   16
+
+/* Max count of Tx MSDU in A-MSDU */
+#define CL_AMSDU_TX_PAYLOAD_MAX 4
+
+#define TXDESC_AGG_Q_SIZE_MAX 512
+
+#define CL_MAX_AGG_IN_TXOP 20
+
+/* Keep LMAC & SMAC debug agg stats arrays size aligned */
+#define DBG_STATS_MAX_AGG_SIZE (256 + 1)
+
+/* Must be power of 2 */
+#define IPC_CFM_CNT 4096
+
+#define IPC_CFM_SIZE (IPC_CFM_CNT * sizeof(struct cl_ipc_cfm_msg))
+
+/* Number of rates in Policy table */
+#define CL_RATE_CONTROL_STEPS 4
+
+/*
+ * Stringified DRV/FW versions should be small enough to fit related ethtool
+ * descriptors size (32)
+ */
+#define CL_VERSION_STR_SIZE 32
+
+#if (IPC_CFM_CNT & (IPC_CFM_CNT - 1))
+#error "IPC_CFM_CNT Not a power of 2"
+#endif
+
+/*
+ * the calculation is conducted as follow:
+ * 1500 - max ethernet frame
+ * conversion of ETH to MSDU:
+ * 1500[eth max] - 12[hdr frame] + 14[msdu frame] + 8[llc snap] + 4[MSDU Padding] = 1514
+ * MSDU + WLAN HDR = 1514[MSDU MAX] + 36[MAX WLAN HDR] = 1550
+ * 2 bytes is being PADDED by SKB alloc for alignment.
+ * 18 byte encryption
+ * sizeof(struct hw_rxhdr)
+ */
+#define IPC_RXBUF_SIZE (1570 + sizeof(struct hw_rxhdr))
+
+/* Number of available host buffers */
+#define IPC_RADAR_BUF_CNT   32
+#define IPC_E2A_MSG_BUF_CNT 128
+#define IPC_DBG_BUF_CNT     64
+
+/* Length used in MSGs structures (size in 4-byte words) */
+#define IPC_A2E_MSG_BUF_SIZE   255
+#define IPC_E2A_MSG_PARAM_SIZE 63
+
+/* Debug messages buffers size (in bytes) */
+#define IPC_DBG_PARAM_SIZE 256
+
+/* Pattern indication for validity */
+#define IPC_RX_DMA_OVER_PATTERN   0xAAAAAA00
+#define IPC_E2A_MSG_VALID_PATTERN 0xADDEDE2A
+#define IPC_DBG_VALID_PATTERN     0x000CACA0
+#define IPC_EXCEPTION_PATTERN     0xDEADDEAD
+
+#define HB_POOL_DMA_DESCS_NUM 2
+
+/* Tensilica backtrace depth */
+#define IPC_BACKTRACT_DEPTH  5
+
+/* Maximum length of the SW diag trace */
+#define DBG_SW_DIAG_MAX_LEN  1024
+
+/* Maximum length of the error trace */
+#define DBG_ERROR_TRACE_SIZE 256
+
+/* Number of MAC diagnostic port banks */
+#define DBG_DIAGS_MAC_MAX    48
+
+/* Driver mem size used for THDs PTs & PBDs */
+#define DBG_THD_CHAINS_INFO_THD_CNT 5
+#define DBG_THD_CHAINS_INFO_PBD_CNT 9
+#define DBG_THD_CHAINS_INFO_PT_CNT  1
+#define DBG_THD_CHAINS_INFO_ARRAY_SIZE \
+	((DBG_THD_CHAINS_INFO_THD_CNT * sizeof(struct tx_hd)) + \
+	 (DBG_THD_CHAINS_INFO_PBD_CNT * sizeof(struct tx_pbd)) + \
+	 (DBG_THD_CHAINS_INFO_PT_CNT * sizeof(struct tx_policy_tbl)))
+
+#define DBG_CHAINS_INFO_ELEM_CNT 10
+
+/* Txl chain info - per ac */
+#define DBG_TXL_FRAME_EXCH_TRACE_DEPTH 5
+
+/* FW debug trace size */
+#define DBG_FW_TRACE_SIZE    30
+#define DBG_FW_TRACE_STR_MAX 20
+
+/* Number of embedded logic analyzers */
+#define LA_CNT               1
+
+/* Length of the configuration data of a logic analyzer */
+#define LA_CONF_LEN          102
+
+/* Structure containing the configuration data of a logic analyzer */
+struct la_conf_tag {
+	u32 conf[LA_CONF_LEN];
+};
+
+/* Size of a logic analyzer memory */
+#define LA_MEM_LEN (256 * 1024)
+
+/* Message structure for MSGs from Emb to App */
+struct cl_ipc_e2a_msg {
+	__le16 id;
+	__le16 dummy_dest_id;
+	__le16 dummy_src_id;
+	__le16 param_len;
+	u32 param[IPC_E2A_MSG_PARAM_SIZE];
+	__le32 pattern;
+};
+
+enum rx_buf_type {
+	CL_RX_BUF_RXM,
+	CL_RX_BUF_FW,
+	CL_RX_BUF_MAX
+};
+
+/*
+ * Structs & function  associated with HW & SW debug data
+ * The Debug information forwarded to host when an error occurs, and printed to stdout
+ * This data must be consistent with firmware, any new debug data should exist also in
+ * firmware side
+ */
+
+struct tx_hd {
+	u32 upatterntx;
+	u32 nextfrmexseq_ptr;
+	u32 nextmpdudesc_ptr;
+	u32 first_pbd_ptr;
+	u32 datastartptr;
+	u32 dataendptr;
+	u32 frmlen;
+	u32 spacinginfo;
+	u32 phyctrlinfo1;
+	u32 policyentryaddr;
+	u32 bar_thd_desc_ptr;
+	u32 reserved1;
+	u32 macctrlinfo1;
+	u32 macctrlinfo2;
+	u32 statinfo;
+	u32 phyctrlinfo2;
+};
+
+struct tx_policy_tbl {
+	u32 upatterntx;
+	u32 phycntrlinfo1;
+	u32 phycntrlinfo2;
+	u32 maccntrlinfo1;
+	u32 maccntrlinfo2;
+	u32 ratecntrlinfo[CL_RATE_CONTROL_STEPS];
+	u32 phycntrlinfo3;
+	u32 phycntrlinfo4;
+	u32 phycntrlinfo5;
+	u32 stationinfo;
+	u32 ratecntrlinfohe[CL_RATE_CONTROL_STEPS];
+	u32 maccntrlinfo3;
+	u32 triggercommoninfo;
+	u32 triggerinforuallocationu0u3;
+	u32 triggerinforuallocationu4u7;
+	u32 triggerperuserinfo[MU_MAX_STREAMS];
+};
+
+struct tx_pbd {
+	u32 upatterntx;
+	u32 next;
+	u32 datastartptr;
+	u32 dataendptr;
+	u32 bufctrlinfo;
+};
+
+enum cl_macfw_dbg_severity {
+	CL_MACFW_DBG_SEV_NONE,
+	CL_MACFW_DBG_SEV_ERROR,
+	CL_MACFW_DBG_SEV_WARNING,
+	CL_MACFW_DBG_SEV_INFO,
+	CL_MACFW_DBG_SEV_VERBOSE,
+
+	CL_MACFW_DBG_SEV_MAX
+};
+
+struct phy_channel_info {
+	__le32 info1;
+	__le32 info2;
+};
+
+struct dbg_debug_info_tag {
+	u32 error_type; /* (0: recoverable, 1: fatal) */
+	u32 hw_diag;
+	char error[DBG_ERROR_TRACE_SIZE];
+	u32 sw_diag_len;
+	char sw_diag[DBG_SW_DIAG_MAX_LEN];
+	struct phy_channel_info chan_info;
+	struct la_conf_tag la_conf[LA_CNT];
+	u16 diags_mac[DBG_DIAGS_MAC_MAX];
+};
+
+/*
+ * Defines, enums and structs below are used at TX statistics
+ * structure.
+ * Because of the TX statistics structure should be same at
+ * host and at firmware,the change of these parameters requires
+ * similar firmware changes
+ */
+
+struct cl_txl_ba_statistics {
+	u32 total_cnt;
+	u32 total_rtx_cnt;
+	u16 total_ba_received;
+	u16 total_ba_not_received_cnt;
+	u16 total_lifetime_expired_cnt;
+	u16 total_rtx_limit_reached;
+	u16 total_packets_below_baw;
+	u16 total_packets_above_baw;
+	u16 total_ba_not_received_cnt_ps;
+	u16 total_cleard_ba;
+	u16 total_unexpected_ba;
+	u16 total_invalid_ba;
+	u16 total_ack_instead_ba;
+};
+
+struct cl_txl_single_statistics {
+	u32 total_cnt;
+	u32 total_rtx_cnt;
+	u16 total_lifetime_expired_cnt;
+	u16 total_rtx_limit_reached;
+	u16 total_rtx_limit_reached_ps;
+};
+
+enum {
+	CE_BACKOFF_25,
+	CE_BACKOFF_50,
+	CE_BACKOFF_100,
+	CE_BACKOFF_500,
+	CE_BACKOFF_1000,
+	CE_BACKOFF_5000,
+	CE_BACKOFF_10000,
+	CE_BACKOFF_20000,
+	CE_BACKOFF_20000_ABOVE,
+	CE_BACKOFF_MAX
+};
+
+struct cl_txl_backoff_statistics {
+	u32 chain_time;
+	u32 backoff_hist[CE_BACKOFF_MAX];
+};
+
+struct cl_txl_tid_statistics {
+	u32 total_tid_desc_cnt;
+};
+
+/* Natt closed an aggregation due to one of the bellow reasons. */
+enum {
+	NATT_REASON_MAX_LEN    = 0x1,
+	NATT_REASON_TXOP_LIMIT = 0x2,
+	NATT_REASON_MPDU_NUM   = 0x4,
+	NATT_REASON_LAST_BIT   = 0x8,
+	NATT_REASON_MAX
+};
+
+/* Tx BW */
+enum {
+	NATT_BW_20,
+	NATT_BW_40,
+	NATT_BW_80,
+	NATT_BW_160,
+	NATT_BW_MAX
+};
+
+struct cl_txl_natt_statistics {
+	u32 agg_close_reason[NATT_REASON_MAX];
+	u32 chosen_frame_bw[NATT_BW_MAX];
+	u32 operation_mode[8];
+};
+
+enum {
+	AGG_IN_TXOP_CLOSE_REASON_NO_TXDESC,
+	AGG_IN_TXOP_CLOSE_REASON_TXOP_EXPIRED,
+	AGG_IN_TXOP_CLOSE_REASON_ACTIVE_DELBA,
+	AGG_IN_TXOP_CLOSE_REASON_MAX
+};
+
+struct amsdu_stat {
+	u16 packet_cnt_2;
+	u16 packet_cnt_3;
+	u16 packet_cnt_4;
+	u16 packet_cnt_5_or_more;
+};
+
+struct cl_txl_mu_statistics {
+	u16 chain_cnt;
+	u16 status_cnt;
+	u16 ba_received;
+	u16 ba_no_received;
+	u16 clear_ba;
+	u16 correct_ba;
+	u16 unexpected_ba;
+	u16 invalid_ba;
+};
+
+struct cl_txl_agg_statistics {
+	u16 agg_size_statistics[DBG_STATS_MAX_AGG_SIZE];
+	u32 packet_failed_statistics[DBG_STATS_MAX_AGG_SIZE];
+	u32 packet_passed_statistics[DBG_STATS_MAX_AGG_SIZE];
+	u16 htp_agg_size_statistics[DBG_STATS_MAX_AGG_SIZE];
+	u32 htp_packet_failed_statistics[DBG_STATS_MAX_AGG_SIZE];
+	u32 htp_packet_passed_statistics[DBG_STATS_MAX_AGG_SIZE];
+	u16 agg_in_txop_statistics[CL_MAX_AGG_IN_TXOP];
+	u16 agg_in_txop_close_reason[AGG_IN_TXOP_CLOSE_REASON_MAX];
+	u16 agg_in_txop_queue_switch;
+	u16 agg_in_txop_queue_switch_abort_bw;
+	struct amsdu_stat amsdu_stat[IPC_MAX_BA_SESSIONS];
+	u16 mu_agg_size_statistics[MU_MAX_STREAMS][DBG_STATS_MAX_AGG_SIZE];
+	struct cl_txl_mu_statistics mu_stats[MU_MAX_STREAMS];
+};
+
+struct cl_txl_ac_statistics {
+	u32 total_q_switch_cnt;
+	u32 total_ac_desc_cnt;
+};
+
+struct cl_txl_underrun_statistics {
+	u16 length_cnt;
+	u16 pattern_cnt;
+	u16 flushed_frames_cnt;
+};
+
+struct cl_txl_rts_cts_statistics {
+	u32 fw_rts_cnt;
+	u32 fw_rts_retry_cnt;
+	u32 fw_rts_retry_limit_cnt;
+	u32 hw_rts_cnt;
+	u32 fw_cts_cnt;
+	u32 hw_cts_cnt;
+};
+
+struct cl_txl_backoff_params {
+	u32 singelton_total[AC_MAX];
+	u32 singelton_cnt[AC_MAX];
+	u32 agg_total[AC_MAX];
+	u32 agg_cnt[AC_MAX];
+};
+
+struct cl_txl_htp_statistics {
+	u32 total_cnt[TID_MAX];
+	u32 need_response;
+	u32 tb_response_required;
+	u32 ac_not_found;
+	u32 end_of_packet_int;
+	u32 tb_bw_decision;
+	u32 tb_ba_thd_removed;
+	u32 tb_ac_unchain;
+	u32 tb_htp_unchain;
+	u32 tb_dummy_htp_tx;
+	u32 tb_dummy_no_tx;
+	u32 msta_ba_received;
+	u32 msta_ba_aid_not_found;
+	u32 uora_cnt_trigger_frame_tx;
+	u32 uora_cnt_trigger_frame_rx;
+	u32 uora_cnt_probe_req_tx;
+	u32 uora_cnt_probe_req_rx;
+};
+
+struct cl_txl_vns_statistics {
+	u32 off_he;
+	u32 off_ht_vht;
+	u32 off_ofdm;
+	u32 off_cck;
+	u32 on_he;
+	u32 on_ht_vht;
+	u32 on_ofdm;
+	u32 on_cck;
+};
+
+struct cl_txl_fec_statistics {
+	u32 ldpc;
+	u32 bcc;
+};
+
+struct cl_txl_mu_desision_statistics {
+	u32 num_sta_in_mu_group[MU_MAX_STREAMS];
+	u32 mu_tx_active;
+	u32 prim_not_in_mu_group;
+	u32 prim_rate_invalid;
+	u32 other_reason;
+	u32 total_num_su;
+	u32 is_2nd_rate_invalid;
+	u32 is_2nd_awake;
+	u32 is_2nd_enouhg_data;
+};
+
+struct cl_txl_statistics {
+	u32 type; /* This field should be first in the struct */
+	u32 recovery_count;
+	u32 tx_obtain_bw_fail_cnt;
+	struct cl_txl_single_statistics single[IPC_TX_QUEUE_CNT];
+	struct cl_txl_ba_statistics ba[IPC_MAX_BA_SESSIONS];
+	struct cl_txl_backoff_statistics backoff_stats[AC_MAX];
+	struct cl_txl_natt_statistics natt;
+	struct cl_txl_tid_statistics tid[TID_MAX];
+	struct cl_txl_agg_statistics agg;
+	struct cl_txl_ac_statistics ac[CE_AC_MAX];
+	struct cl_txl_underrun_statistics underrun;
+	struct cl_txl_rts_cts_statistics rts_cts;
+	struct cl_txl_backoff_params backoff_params;
+	struct cl_txl_htp_statistics htp;
+	struct cl_txl_vns_statistics vns;
+	struct cl_txl_fec_statistics fec;
+	struct cl_txl_mu_desision_statistics mu_desision;
+};
+
+/* Flushed beacon list options */
+enum {
+	BCN_FLUSH_PENDING,
+	BCN_FLUSH_DOWNLOADING,
+	BCN_FLUSH_TRANSMITTING,
+	BCN_FLUSH_MAX,
+};
+
+struct bcn_backup_stats {
+	u32 bcn_backup_used_cnt;
+	u32 bcn_backup_tx_cnt;
+	u32 bcn_backup_flushed_cnt;
+	u32 bcn_backup_used_in_arow_cnt;
+	u32 bcn_backup_max_used_in_arow_cnt;
+};
+
+struct beacon_timing {
+	/* Time measurements between beacons */
+	u32 last_bcn_start_time;
+	u32 max_time_from_last_bcn;
+	u32 min_time_from_last_bcn;
+	u32 total_bcn_time;
+	/* Time measurements until beacon chained */
+	u32 imp_tbtt_start_time;
+	u32 bcn_chain_total_time;
+	u32 bcn_chain_max_time;
+	u32 bcn_chain_min_time;
+	/* Time measurements until received beacon from host */
+	u32 bcn_last_request_time;
+	u32 max_bcn_time_until_get_beacon_from_driver_in_tbtt;
+	u32 bcn_last_req_rec_time;
+	/* Time measurements of bcn from pending to chain */
+	u32 bcn_push_pending_start_time;
+	u32 bcn_pending_2_chain_max_time;
+};
+
+struct beacon_counters {
+	u32 bcn_time_from_driver_not_in_threshold_cnt;
+	u32 nof_time_intervals_between_beacons;
+	u32 total_cnt;
+	u32 bcn_chain_total_cnt;
+	u32 ce_txl_flushed_beacons[BCN_FLUSH_MAX];
+	u32 pending2chain_not_in_threshold_cnt;
+	u32 total_beacons_received_from_driver;
+};
+
+struct cl_bcn_statistics {
+	u32 type; /* This field should be first in the struct */
+	struct beacon_counters beacon_counters;
+	struct beacon_timing beacon_timing;
+	struct bcn_backup_stats bcn_backup_stats;
+};
+
+struct cl_queue_idx_dif_stats {
+	u32 type; /* This field should be first in the struct */
+	u32 diff_array_count[IPC_QUEUE_IDX_DIFF_ARRAY_SIZE];
+	u32 last_diff;
+	u32 wr_idx;
+	u32 rd_idx;
+};
+
+enum agg_tx_rate_drop_reason {
+	AGG_TX_RATE_DROP_MAX_BA_NOT_RECEIVED_REACHED,
+	AGG_TX_RATE_DROP_MAX_BA_PER_REACHED,
+	AGG_TX_RATE_DROP_MAX_RETRY_REACHED,
+	AGG_TX_RATE_DROP_MAX,
+};
+
+struct cl_rate_drop_statistics {
+	u32 type;
+	u32 drop_reason[AGG_TX_RATE_DROP_MAX];
+};
+
+#define BF_DB_MAX 16
+
+enum bfr_rx_err {
+	BFR_RX_ERR_BW_MISMATCH,
+	BFR_RX_ERR_NSS_MISMATCH,
+	BFR_RX_ERR_SOUNDING_CHBW,
+	BFR_RX_ERR_TOKEN_MISMATCH,
+	BFR_RX_ERR_NDP_DROP,
+	BFR_SEGMENTED_DROP,
+	BFR_RX_ERR_MISS_ACK,
+	BFR_RX_ERR_RESOURCE_NA,
+	BFR_RX_ERR_MAX
+};
+
+enum TX_BF_DATA_STAT {
+	TX_BF_DATA_OK = 0,
+	TX_BF_DATA_BUFFERED_RESOURCE_ERR,
+	TX_BF_DATA_RELEASED_RESOURCE_ERR,
+	TX_BF_DATA_BUFFERED_PS_STA,
+	TX_BF_DATA_RELEASED_PS_STA,
+	TX_BF_DATA_ERR_BFR_MISS,
+	TX_BF_DATA_ERR_BFR_OUTDATED,
+	TX_BF_DATA_ERR_MISMATCH_BW,
+	TX_BF_DATA_ERR_MISMATCH_NSS,
+	TX_BF_DATA_ERR_MAX
+};
+
+struct bf_ctrl_dbg {
+	u16 ndp_cnt;
+	u16 bfp_cnt;
+	u16 su_bfr_cnt;
+	u16 mu_bfr_cnt;
+	u16 bf_invalid_cnt[BFR_RX_ERR_MAX];
+	u16 tx_bf_data_err[TX_BF_DATA_ERR_MAX];
+};
+
+struct bf_stats_database {
+	bool is_active_list;
+	struct bf_ctrl_dbg dbg;
+	u8 sta_idx;
+	u16 active_dsp_idx;
+	u16 passive_dsp_idx;
+};
+
+struct cl_bf_statistics {
+	u32 type;
+	bool print_active_free_list;
+	struct bf_stats_database stats_data[BF_DB_MAX];
+};
+
+enum amsdu_deaggregation_err {
+	AMSDU_DEAGGREGATION_ERR_MAX_MSDU_REACH,
+	AMSDU_DEAGGREGATION_ERR_MSDU_GT_AMSDU_LEN,
+	AMSDU_DEAGGREGATION_ERR_MSDU_LEN,
+	AMSDU_ENCRYPTION_KEY_GET_ERR,
+
+	AMSDU_DEAGGREGATION_ERR_MAX
+};
+
+enum emb_ll1_handled_frm_type {
+	BA_FRM_TYPE,
+	NDPA_FRM_TYPE,
+	NDP_FRM_TYPE,
+	ACTION_NO_ACK_FRM_TYPE,
+
+	MAX_HANDLED_FRM_TYPE
+};
+
+enum rhd_decr_idx {
+	RHD_DECR_UNENC_IDX,
+	RHD_DECR_ICVFAIL_IDX,
+	RHD_DECR_CCMPFAIL_IDX,
+	RHD_DECR_AMSDUDISCARD_IDX,
+	RHD_DECR_NULLKEY_IDX,
+	RHD_DECR_IDX_MAX
+};
+
+#define RX_CLASSIFICATION_MAX 6
+#define FREQ_OFFSET_TABLE_IDX_MAX 8 /* Must be a power of 2 */
+#define RX_MAX_MSDU_IN_SINGLE_AMSDU 16
+
+struct cl_rxl_statistics {
+	u32 type; /* This field should be first in the struct */
+	u32 rx_imp_bf_counter[MU_UL_MAX];
+	u32 rx_imp_bf_int_counter[MU_UL_MAX];
+	u32 rx_class_counter[MU_UL_MAX][RX_CLASSIFICATION_MAX];
+	u32 rx_class_int_counter[MU_UL_MAX];
+	u32 counter_timer_trigger_ll1[MU_UL_MAX];
+	u32 counter_timer_trigger_ll2[MU_UL_MAX];
+	u32 total_rx_packets[MU_UL_MAX];
+	u32 total_agg_packets[MU_UL_MAX];
+	u32 rx_fifo_overflow_err_cnt[MU_UL_MAX];
+	u32 rx_dma_discard_cnt;
+	u32 host_rxelem_not_ready_cnt;
+	u32 msdu_host_rxelem_not_ready_cnt;
+	u32 dma_rx_pool_not_ready_cnt;
+	u32 rx_pckt_exceed_max_len_cnt[MU_UL_MAX];
+	u32 rx_pckt_bad_ba_statinfo_cnt[MU_UL_MAX];
+	u32 nav_value[MU_UL_MAX];
+	u16 max_mpdu_data_len[MU_UL_MAX];
+	u8 rhd_ll2_max_cnt[MU_UL_MAX]; /* Rhd first list */
+	u8 rhd_ll1_max_cnt[MU_UL_MAX]; /* Rhd second list */
+	u8 cca_busy_percent;
+	u8 rx_mine_busy_percent;
+	u8 tx_mine_busy_percent;
+	u8 sample_cnt;
+	/* Emb handled frames */
+	u32 emb_ll1_handled_frame_counter[MU_UL_MAX][MAX_HANDLED_FRM_TYPE];
+	u32 rxm_stats_overflow[MU_UL_MAX];
+	/* RX AMSDU statistics counters */
+	u32 stats_tot_rx_amsdu_cnt[MU_UL_MAX];
+	u32 stats_rx_amsdu_cnt[MU_UL_MAX][RX_MAX_MSDU_IN_SINGLE_AMSDU];
+	u32 stats_rx_amsdu_err[MU_UL_MAX][AMSDU_DEAGGREGATION_ERR_MAX];
+	u32 stats_rx_format[FORMATMOD_MAX];
+	/* RX decryption error */
+	u32 decrypt_err[RHD_DECR_IDX_MAX];
+	u32 rx_incorrect_format_mode[MU_UL_MAX];
+	u32 fcs_error_counter[MU_UL_MAX];
+	u32 phy_error_counter[MU_UL_MAX];
+	u32 ampdu_received_counter[MU_UL_MAX];
+	u32 delimiter_error_counter[MU_UL_MAX];
+	u32 ampdu_incorrect_received_counter[MU_UL_MAX];
+	u32 correct_received_mpdu[MU_UL_MAX];
+	u32 incorrect_received_mpdu[MU_UL_MAX];
+	u32 discarded_mpdu[MU_UL_MAX];
+	u32 incorrect_delimiter[MU_UL_MAX];
+	u32 rxm_mpdu_cnt[MU_UL_MAX];
+	u32 rxm_rule0_match[MU_UL_MAX];
+	u32 rxm_rule1_match[MU_UL_MAX];
+	u32 rxm_rule2_match[MU_UL_MAX];
+	u32 rxm_rule3_match[MU_UL_MAX];
+	u32 rxm_rule4_match[MU_UL_MAX];
+	u32 rxm_rule5_match[MU_UL_MAX];
+	u32 rxm_rule6_match[MU_UL_MAX];
+	u32 rxm_default_rule_match[MU_UL_MAX];
+	u32 rxm_amsdu_1[MU_UL_MAX];
+	u32 rxm_amsdu_2[MU_UL_MAX];
+	u32 rxm_amsdu_3[MU_UL_MAX];
+	u32 rxm_amsdu_4[MU_UL_MAX];
+	u32 rxm_amsdu_5_15[MU_UL_MAX];
+	u32 rxm_amsdu_16_or_more[MU_UL_MAX];
+	u32 frequency_offset[FREQ_OFFSET_TABLE_IDX_MAX];
+	u32 frequency_offset_idx;
+	u32 rts_bar_cnt[MU_UL_MAX];
+};
+
+enum trigger_flow_single_trigger_type {
+	TRIGGER_FLOW_BASIC_TRIGGER_TYPE,
+	TRIGGER_FLOW_BSRP_TYPE,
+	TRIGGER_FLOW_BFRP_TYPE,
+	TRIGGER_FLOW_MAX
+};
+
+struct cl_trigger_flow_statistics {
+	u32 type; /* This field should be first in the struct */
+	u32 single_trigger_sent[TRIGGER_FLOW_MAX][AC_MAX];
+	u32 htp_rx_failure[AC_MAX];
+	u32 trigger_based_mpdu[MU_UL_MAX];
+};
+
+#define DYN_CAL_DEBUG_NUM_ITER  3
+
+struct dyn_cal_debug_info_t {
+	u16 calib_num;
+	u8 curr_config;
+	union {
+		struct {
+			u8 iter_num;
+			u32 measured_val;
+		};
+		struct {
+			u8 min_config;
+			u32 dyn_cal_min_val;
+			u32 dyn_cal_max_val;
+			u8 max_config;
+		};
+	};
+
+	u8 new_config;
+};
+
+struct cl_dyn_calib_statistics {
+	u32 type; /* This field should be first in the struct */
+	u8 is_multi_client_mode;
+	u8 default_dyn_cal_val;
+	u8 dyn_cal_debug_info_ix;
+	u16 dyn_cal_process_cnt;
+	u16 mac_phy_sync_err_cnt;
+	struct dyn_cal_debug_info_t dyn_cal_debug_info[DYN_CAL_DEBUG_NUM_ITER];
+};
+
+/* End of parameters that require host changes */
+
+/* Structure containing the parameters for assert prints DBG_PRINT_IND message. */
+struct dbg_print_ind {
+	__le16 file_id;
+	__le16 line;
+	__le16 has_param;
+	u8 err_no_dump;
+	u8 reserved;
+	__le32 param;
+};
+
+/* 4 ACs + BCN + HTP + current THD */
+#define MACHW_THD_REGS_CNT (IPC_TX_QUEUE_CNT + 2)
+
+/* Enumeration of MAC-HW registers (debug dump at recovery event) */
+enum {
+	HAL_MACHW_AGGR_STATUS,
+	HAL_MACHW_DEBUG_HWSM_1,
+	HAL_MACHW_DEBUG_HWSM_2,
+	HAL_MACHW_DEBUG_HWSM_3,
+	HAL_MACHW_DMA_STATUS_1,
+	HAL_MACHW_DMA_STATUS_2,
+	HAL_MACHW_DMA_STATUS_3,
+	HAL_MACHW_DMA_STATUS_4,
+	HAL_MACHW_RX_HEADER_H_PTR,
+	HAL_MACHW_RX_PAYLOAD_H_PTR,
+	HAL_MACHW_DEBUG_BCN_S_PTR,
+	HAL_MACHW_DEBUG_AC0_S_PTR,
+	HAL_MACHW_DEBUG_AC1_S_PTR,
+	HAL_MACHW_DEBUG_AC2_S_PTR,
+	HAL_MACHW_DEBUG_AC3_S_PTR,
+	HAL_MACHW_DEBUG_HTP_S_PTR,
+	HAL_MACHW_DEBUG_TX_C_PTR,
+	HAL_MACHW_DEBUG_RX_HDR_C_PTR,
+	HAL_MACHW_DEBUG_RX_PAY_C_PTR,
+	HAL_MACHW_MU0_TX_POWER_LEVEL_DELTA_1,
+	HAL_MACHW_MU0_TX_POWER_LEVEL_DELTA_2,
+	HAL_MACHW_POWER_BW_CALIB_FACTOR,
+	HAL_MACHW_TX_POWER_ANTENNA_FACTOR_1_ADDR,
+	HAL_MACHW_TX_POWER_ANTENNA_FACTOR_2_ADDR,
+	/* Keep this entry last */
+	HAL_MACHW_REG_NUM
+};
+
+#define HAL_MACHW_FSM_REG_NUM ((HAL_MACHW_DEBUG_HWSM_3 - HAL_MACHW_AGGR_STATUS) + 1)
+
+enum {
+	MPU_COMMON_FORMAT,
+	MPU_COMMON_FIELD_CTRL,
+	MPU_COMMON_LEGACY_INFO,
+	MPU_COMMON_COMMON_CFG_1,
+	MPU_COMMON_COMMON_CFG_2,
+	MPU_COMMON_COMMON_CFG_3,
+	MPU_COMMON_HE_CFG_1,
+	MPU_COMMON_HE_CFG_2,
+	MPU_COMMON_INT_STAT_RAW,
+	RIU_CCAGENSTAT,
+	PHY_HW_DBG_REGS_CNT
+};
+
+/* Error trace CE_AC info */
+struct dbg_ac_info {
+	u8 chk_state;
+	u8 tx_path_state;
+	u8 physical_queue_idx;
+	u16 active_session;
+	u32 last_frame_exch_ptr;
+};
+
+/* Error trace txdesc lists info */
+struct dbg_txlist_info {
+	u8 curr_session_idx;
+	u8 next_session_idx;
+	u16 pending_cnt;
+	u16 download_cnt;
+	u16 transmit_cnt;
+	u16 wait_for_ba_cnt;
+	u16 next_pending_cnt;
+};
+
+/* Txl chain info */
+struct dbg_txl_chain_info {
+	u32 count;
+	u32 frm_type;
+	u32 first_thd_ptr;
+	u32 last_thd_ptr;
+	u32 prev_thd_ptr;
+	u32 req_phy_flags;
+	u8 reqbw;
+	u8 ce_txq_idx;
+	u16 mpdu_count;
+	u8 chbw;
+	u32 rate_ctrl_info;
+	u32 rate_ctrl_info_he;
+	u32 txstatus;
+	u32 length;
+	u32 tx_time;
+};
+
+struct dbg_txl_ac_chain_trace {
+	struct dbg_txl_chain_info data[DBG_TXL_FRAME_EXCH_TRACE_DEPTH];
+	u32 count;
+	u8 next_chain_index;
+	u8 next_done_index;
+	u8 delta;
+};
+
+struct dbg_fw_trace {
+	u32 string_ptr;
+	u32 var_1;
+	u32 var_2;
+	u32 var_3;
+	u32 var_4;
+	u32 var_5;
+	u32 var_6;
+	/*
+	 * This field is used only for driver pring dump file.
+	 * collect string char is done at error dump collect data function.
+	 */
+	char string_char[DBG_FW_TRACE_STR_MAX];
+};
+
+/* Error trace MAC-FW info */
+struct dbg_fw_info {
+	struct dbg_ac_info ac_info[CE_AC_MAX];
+	struct dbg_txlist_info txlist_info_singles[IPC_TX_QUEUE_CNT];
+	struct dbg_txlist_info txlist_info_agg[AGG_IDX_MAX];
+	struct dbg_txl_ac_chain_trace txl_ac_chain_trace[CE_AC_MAX];
+	struct dbg_fw_trace fw_trace[DBG_FW_TRACE_SIZE];
+	u32 fw_trace_idx;
+};
+
+/* TXM regs */
+struct dbg_txm_regs {
+	u8 hw_state;
+	u8 fw_state;
+	u8 spx_state;
+	u8 free_buf_state;
+	u8 mpdu_cnt;
+	u8 lli_cnt;
+	u8 lli_done_reason;
+	u8 lli_done_mpdu_num;
+	u16 active_bytes;
+	u16 prefetch_bytes;
+	u32 last_thd_done_addr;
+	u16 last_thd_done_mpdu_num;
+	u16 underrun_cnt;
+};
+
+/* Error trace HW registers */
+struct dbg_hw_reg_info {
+	u32 mac_hw_reg[HAL_MACHW_REG_NUM];
+	u32 mac_hw_sec_fsm[CL_MU_IDX_MAX][HAL_MACHW_FSM_REG_NUM];
+	u32 phy_mpu_hw_reg[PHY_HW_DBG_REGS_CNT];
+	struct dbg_txm_regs txm_regs[AGG_IDX_MAX];
+};
+
+struct dbg_meta_data {
+	__le32 lmac_req_buf_size;
+	u8 physical_queue_cnt;
+	u8 agg_index_max;
+	u8 ce_ac_max;
+	u8 mu_user_max;
+	u8 txl_exch_trace_depth;
+	__le16 mac_hw_regs_max;
+	__le16 phy_hw_regs_max;
+	__le16 thd_chains_data_size;
+	u8 chains_info_elem_cnt;
+};
+
+struct dbg_agg_thds_addr {
+	u32 rts_cts_thd_addr;
+	u32 athd_addr;
+	u32 tf_thd_addr;
+	u32 bar_thd_addr;
+	u32 policy_table_addr;
+};
+
+struct dbg_agg_thd_info {
+	struct tx_hd rts_cts_thd;
+	struct tx_hd athd;
+	struct tx_hd tf_thd;
+	struct tx_hd bar_thd;
+	struct tx_policy_tbl policy_table;
+};
+
+struct dbg_machw_regs_thd_info {
+	struct tx_hd thd[MACHW_THD_REGS_CNT];
+};
+
+struct dbg_thd_chains_info {
+	u8 type_array[DBG_CHAINS_INFO_ELEM_CNT];
+	u32 elem_address[DBG_CHAINS_INFO_ELEM_CNT];
+};
+
+struct dbg_thd_chains_data {
+	u8 data[DBG_THD_CHAINS_INFO_ARRAY_SIZE];
+};
+
+/* Error trace debug structure. common to fw & drv */
+struct dbg_error_trace_info_common {
+	struct dbg_print_ind error_info;
+	struct dbg_meta_data dbg_metadata;
+	struct dbg_hw_reg_info hw_info;
+	struct dbg_fw_info fw_info;
+	struct dbg_agg_thds_addr agg_thds_addr[AGG_IDX_MAX];
+};
+
+/* Dbg error info driver side */
+struct dbg_error_trace_info_drv {
+	struct dbg_error_trace_info_common common_info;
+	struct dbg_agg_thd_info agg_thd_info[AGG_IDX_MAX];
+	struct dbg_machw_regs_thd_info machw_thd_info;
+	struct dbg_thd_chains_info thd_chains_info[CE_AC_MAX];
+	struct dbg_thd_chains_data thd_chains_data[CE_AC_MAX];
+};
+
+/*
+ * This is the main debug struct, the kernel allocate the needed spaces using kmalloc().
+ * the firmware holds a pointer to this struct.
+ */
+struct dbg_dump_info {
+	u32 dbg_info; /* Should be first member in the struct */
+	/* Dump data transferred to host */
+	struct dbg_debug_info_tag general_data;
+	struct dbg_error_trace_info_drv fw_dump;
+	u8 la_mem[LA_CNT][LA_MEM_LEN];
+};
+
+struct dbg_info {
+	union {
+		u32 type;
+		struct cl_txl_statistics tx_stats;
+		struct cl_bcn_statistics bcn_stats;
+		struct cl_rxl_statistics rx_stats;
+		struct cl_dyn_calib_statistics dyn_calib_stats;
+		struct cl_rate_drop_statistics rate_drop_stats;
+		struct cl_bf_statistics bf_stats;
+		struct cl_trigger_flow_statistics trigger_flow_stats;
+		struct cl_queue_idx_dif_stats txdesc_idx_diff_stats;
+		struct dbg_dump_info dump;
+	} u;
+};
+
+/* Structure of a list element header */
+struct co_list_hdr {
+	__le32 next;
+};
+
+/* ETH2WLAN and NATT common parameters field (e2w_natt_param) struct definition: */
+struct cl_e2w_natt_param {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u32 valid           : 1,  /* [0] */
+	    ampdu           : 1,  /* [1] */
+	    last_mpdu       : 1,  /* [2] */
+	    lc_snap         : 1,  /* [3] */
+	    vlan            : 1,  /* [4] */
+	    amsdu           : 1,  /* [5] */
+	    e2w_band_id     : 1,  /* [6] */
+	    use_local_addr  : 1,  /* [7] */
+	    hdr_conv_enable : 1,  /* [8] */
+	    sta_index       : 7,  /* [9:15] */
+	    packet_length   : 15, /* [30:16] */
+	    e2w_int_enable  : 1;  /* [31] */
+#else /* __BIG_ENDIAN_BITFIELD */
+	u32 e2w_int_enable  : 1,  /* [0] */
+	    packet_length   : 15, /* [15:1] */
+	    sta_index       : 7,  /* [22:16] */
+	    hdr_conv_enable : 1,  /* [23] */
+	    use_local_addr  : 1,  /* [24] */
+	    e2w_band_id     : 1,  /* [25] */
+	    amsdu           : 1,  /* [26] */
+	    vlan            : 1,  /* [27] */
+	    llc_snap        : 1,  /* [28] */
+	    last_mpdu       : 1,  /* [29] */
+	    ampdu           : 1,  /* [30] */
+	    valid           : 1;  /* [31] */
+#endif
+};
+
+#define CL_CCMP_GCMP_PN_SIZE 6
+
+struct cl_e2w_txhdr_param {
+	__le16 frame_ctrl;
+	__le16 seq_ctrl;
+	__le32 ht_ctrl;
+	u8 encrypt_pn[CL_CCMP_GCMP_PN_SIZE];
+	__le16 qos_ctrl;
+};
+
+/* Bit 16 Has different usage for single (valid sta - set by host) or agg (tx done - set by HW) */
+struct cl_e2w_result {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u32 backup_bcn                        : 1,  /* [0] */
+	    dont_chain                        : 1,  /* [1] */
+	    is_flush_needed                   : 1,  /* [2] */
+	    is_internal                       : 1,  /* [3] */
+	    which_descriptor                  : 2,  /* [5:4] */
+	    is_first_in_AMPDU                 : 1,  /* [6] */
+	    is_ext_buff                       : 1,  /* [7] */
+	    is_txinject                       : 1,  /* [8] */
+	    is_vns                            : 1,  /* [9] */
+	    single_type                       : 2,  /* [11:10] */
+	    tid                               : 4,  /* [15:12] */
+	    single_valid_sta__agg_e2w_tx_done : 1,  /* [16] */
+	    msdu_length                       : 13, /* [29:17] */
+	    bcmc                              : 1,  /* [30] */
+	    sw_padding                        : 1;  /* [31] */
+#else /* __BIG_ENDIAN_BITFIELD */
+	u32 sw_padding                        : 1,  /* [0] */
+	    bcmc                              : 1,  /* [1] */
+	    msdu_length                       : 13, /* [14:2] */
+	    single_valid_sta__agg_e2w_tx_done : 1,  /* [15] */
+	    tid                               : 4,  /* [19:16] */
+	    single_type                       : 2,  /* [21:20] */
+	    is_vns                            : 1,  /* [22] */
+	    is_txinject                       : 1,  /* [23] */
+	    is_ext_buff                       : 1,  /* [24] */
+	    is_first_in_AMPDU                 : 1,  /* [25] */
+	    which_descriptor                  : 2,  /* [27:26] */
+	    is_internal                       : 1,  /* [28] */
+	    is_flush_needed                   : 1,  /* [29] */
+	    dont_chain                        : 1,  /* [30] */
+	    backup_bcn                        : 1;  /* [31] */
+#endif
+};
+
+struct tx_host_info {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+	u32 packet_cnt               : 4, /* [3:0] */
+	    host_padding             : 8, /* [11:4] */
+	    last_MSDU_LLI_INT_enable : 1, /* [12] */
+	    is_eth_802_3             : 1, /* [13] */
+	    is_protected             : 1, /* [14] */
+	    vif_index                : 4, /* [18:15] */
+	    rate_ctrl_entry          : 3, /* [21:19] */
+	    expected_ack             : 1, /* [22] */
+	    is_bcn                   : 1, /* [23] */
+	    hw_key_idx               : 8; /* [31:24] */
+#else /* __BIG_ENDIAN_BITFIELD */
+	u32 hw_key_idx               : 8, /* [7:0] */
+	    is_bcn                   : 1, /* [8] */
+	    expected_ack             : 1, /* [9] */
+	    rate_ctrl_entry          : 3, /* [12:10] */
+	    vif_index                : 4, /* [16:13] */
+	    is_protected             : 1, /* [17] */
+	    is_eth_802_3             : 1, /* [18] */
+	    last_MSDU_LLI_INT_enable : 1, /* [19] */
+	    host_padding             : 8, /* [27:20] */
+	    packet_cnt               : 4; /* [31:28] */
+#endif
+};
+
+struct lmacapi {
+	__le32 packet_addr[CL_AMSDU_TX_PAYLOAD_MAX];
+	__le16 packet_len[CL_AMSDU_TX_PAYLOAD_MAX];
+	__le16 push_timestamp; /* Milisec */
+};
+
+struct txdesc {
+	/* Pointer to the next element in the queue */
+	struct co_list_hdr list_hdr;
+	/* E2w txhdr parameters */
+	struct cl_e2w_txhdr_param e2w_txhdr_param __aligned(4);
+	/* Celeno flags field */
+	struct tx_host_info host_info __aligned(4);
+	/* Common parameters for ETH2WLAN and NATT hardware modules */
+	struct cl_e2w_natt_param  e2w_natt_param;
+	/* ETH2WLAN status and NATT calculation results */
+	struct cl_e2w_result e2w_result;
+	/* Information provided by UMAC to LMAC */
+	struct lmacapi umacdesc;
+};
+
+/*
+ * Comes from ipc_dma.h
+ * Element in the pool of TX DMA bridge descriptors.
+ * PAY ATTENTION - Avoid Changing/adding pointers to that struct,
+ * or any shared-memory-related-structs !!!
+ * Since in 64Bit platforms (Where pointers are 64Bit) such pointers
+ * might change alignments in shared-memory-related-structs of FW and DRV.
+ */
+struct dma_desc {
+	/*
+	 * Application subsystem address which is used as source address for DMA payload
+	 * transfer
+	 */
+	u32 src;
+	/*
+	 * Points to the start of the embedded data buffer associated with this descriptor.
+	 * This address acts as the destination address for the DMA payload transfer
+	 */
+	u32 dest;
+	/* Complete length of the buffer in memory */
+	u16 length;
+	/* Control word for the DMA engine (e.g. for interrupt generation) */
+	u16 ctrl;
+	/* Pointer to the next element of the chained list */
+	u32 next;
+	/*
+	 * When working with 64bit application the high 32bit address should be provided
+	 * in the following variable (note: "PCIEW_CONF" register should be configured accordingly)
+	 */
+	u32 app_hi_32bit;
+};
+
+/* Message structure for CFMs from Emb to App */
+struct cl_ipc_cfm_msg {
+	__le32 status;
+	__le32 dma_addr;
+	__le32 single_queue_idx;
+};
+
+/* Message structure for Debug messages from Emb to App */
+struct cl_ipc_dbg_msg {
+	char string[IPC_DBG_PARAM_SIZE];
+	__le32 pattern;
+};
+
+/*
+ * Message structure for MSGs from App to Emb.
+ * Actually a sub-structure will be used when filling the messages.
+ */
+struct cl_ipc_a2e_msg {
+	u32 dummy_word;
+	u32 msg[IPC_A2E_MSG_BUF_SIZE];
+};
+
+/* Struct for tensilica  backtrace */
+struct cl_ipc_backtrace_struct {
+	u32 pc[IPC_BACKTRACT_DEPTH];
+};
+
+/* Struct for tensilica  exception indication */
+struct cl_ipc_exception_struct {
+	u32 pattern;
+	u32 type;
+	u32 epc;
+	u32 excsave;
+	struct cl_ipc_backtrace_struct backtrace;
+};
+
+/*
+ * Can't use BITS_TO_LONGS since in firmware sizeof(long) == 4 and in the host
+ * this might be different from compiler to compiler. We need our own macro to
+ * match the firmware definition.
+ */
+#define CL_BITS_TO_U32S(nr) DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
+
+/*
+ * struct cl_ipc_enhanced_tim - ipc enhanced tim element
+ *
+ * This structure hold indication on the buffered traffic resembles the TIM element.
+ * This enhanced TIM holds more info on the buffered traffic, it indicate whether the
+ * traffic is associated with BA or singles and on which AC's.
+ *
+ * @tx_agg: indicate buffered tx-aggregated traffic per AC per BA session index
+ * @tx_single: indicate buffered tx-singles traffic per AC per station index
+ * @rx: indicate buffered rx traffic per AC per station index
+ */
+struct cl_ipc_enhanced_tim {
+	/*
+	 * Traffic indication map
+	 * our driver push packets to the IPC queues (DRIVER_LAYER -> IPC_LAYER),
+	 * on each push it also notify the IPC_LAYER for which queue it pushed packets.
+	 * this indication done by filling the bitmap.
+	 *
+	 * this is enhanced tim element because it is divided into AC and packet type
+	 * (aggregatable/non aggregatable).
+	 * the regular tim element which exist in the beacon is divided by AID only
+	 * which is less informative.
+	 *
+	 * TODO: add TIM element maintenance in the FW, this can be achived by the
+	 * enhanced tim elements abstraction.
+	 */
+	u32 tx_rx_agg[AC_MAX][CL_BITS_TO_U32S(IPC_TIM_AGG_SIZE)];
+	u32 tx_single[AC_MAX][CL_BITS_TO_U32S(FW_MAX_NUM_STA)];
+};
+
+struct cl_ipc_shared_env {
+	volatile struct cl_ipc_a2e_msg a2e_msg_buf;
+	/* Fields for MSGs sending from Emb to App */
+	volatile struct cl_ipc_e2a_msg e2a_msg_buf;
+	volatile struct dma_desc msg_dma_desc;
+	volatile __le32 e2a_msg_hostbuf_addr[IPC_E2A_MSG_BUF_CNT];
+	/* Fields for Debug MSGs sending from Emb to App */
+	volatile struct cl_ipc_dbg_msg dbg_buf;
+	volatile struct dma_desc dbg_dma_desc;
+	volatile __le32 dbg_hostbuf_addr[IPC_DBG_BUF_CNT];
+	volatile __le32 dbginfo_addr;
+	volatile __le32 dbginfo_size;
+	volatile __le32 pattern_addr;
+	volatile __le32 radarbuf_hostbuf[IPC_RADAR_BUF_CNT]; /* Buffers for radar events */
+	/* Used to update host general debug data */
+	volatile struct dma_desc dbg_info_dma_desc;
+	/*
+	 * The following members are associated ith the process of fetching
+	 * "application txdesc" from the application and copy them to the
+	 * internal embedded queues.
+	 *
+	 * @host_address_dma: dedicated dma descriptor to fetch the addresses of
+	 * "application txdesc" queues
+	 * @write_dma_desc_pool: dedicated dma descriptor to fetch the "@txdesc_emb_wr_idx"
+	 * index (dma for application txdesc metadata)
+	 * @last_txdesc_dma_desc_pool: dedicated dma descriptor to fetch "application txdescs"
+	 * (dma for application txdesc)
+	 * @txdesc_emb_wr_idx: indicate the last valid "application txdesc" fetched
+	 */
+	volatile struct dma_desc host_address_dma;
+	volatile struct dma_desc tx_power_tables_dma_desc;
+	volatile __le32 txdesc_emb_wr_idx[IPC_TX_QUEUE_CNT + CL_MAX_BA_PHYSICAL_QUEUE_CNT];
+	volatile __le32 host_rxbuf_rd_idx[CL_RX_BUF_MAX];                       /* For FW only */
+	volatile struct dma_desc rx_fw_hb_pool_dma_desc[HB_POOL_DMA_DESCS_NUM]; /* For FW only */
+	volatile struct dma_desc rxm_hb_pool_dma_desc[HB_POOL_DMA_DESCS_NUM];   /* For FW only */
+	volatile __le32 cfm_read_pointer; /* CFM read point. Updated by Host, Read by FW */
+	volatile __le16 phy_dev;
+	volatile u8 la_enable;
+	volatile u8 flags;
+	volatile u8 first_tcv;
+	volatile u8 ant_num;
+	volatile __le16 max_retry;
+	volatile __le16 lft_limit_ms;
+	volatile __le16 bar_max_retry; /* Not used by driver */
+	volatile __le32 assert_pattern;
+	volatile __le16 assert_file_id;
+	volatile __le16 assert_line_num;
+	volatile __le32 assert_param;
+	volatile struct cl_ipc_enhanced_tim enhanced_tim;
+	volatile u8 la_mirror_enable;
+};
+
+/* IRQs from app to emb */
+#define IPC_IRQ_A2E_TXDESC     0xFF00
+#define IPC_IRQ_A2E_RXBUF_BACK BIT(2)
+#define IPC_IRQ_A2E_MSG        BIT(1)
+#define IPC_IRQ_A2E_RXREQ      0x78
+#define IPC_IRQ_A2E_ALL        (IPC_IRQ_A2E_TXDESC | IPC_IRQ_A2E_MSG)
+
+#define IPC_IRQ_A2E_TXDESC_FIRSTBIT 8
+#define IPC_IRQ_A2E_RXREQ_FIRSTBIT  3
+
+#define IPC_IRQ_A2E_TXDESC_AGG_MAP(ac)    (IPC_IRQ_A2E_TXDESC_FIRSTBIT + IPC_TXQ_CNT + (ac))
+#define IPC_IRQ_A2E_TXDESC_SINGLE_MAP(ac) (IPC_IRQ_A2E_TXDESC_FIRSTBIT + (ac))
+#define IPC_IRQ_A2E_RX_STA_MAP(ac)        (IPC_IRQ_A2E_RXREQ_FIRSTBIT + (ac))
+
+struct cl_ipc_e2a_irq {
+	u32 dbg;
+	u32 msg;
+	u32 rxdesc;
+	u32 txcfm;
+	u32 radar;
+	u32 txdesc_ind;
+	u32 tbtt;
+	u32 sync;
+	u32 all;
+};
+
+/*
+ * IRQs from emb to app
+ * This interrupt is used by the firmware to indicate the driver that it may proceed.
+ * The corresponding interrupt handler sets the CL_DEV_FW_SYNC flag in cl_hw->drv_flags.
+ * There is also the cl_hw->fw_sync_wq wait queue, on which we may sleep while waiting for
+ * the interrupt, if we are allowed to do so (e.g., when we are in a system call).
+ */
+#define IPC_IRQ_L2H_DBG        BIT(0)
+#define IPC_IRQ_L2H_MSG        BIT(1)
+#define IPC_IRQ_L2H_RXDESC     BIT(2)
+#define IPC_IRQ_L2H_TXCFM      0x000000F8
+#define IPC_IRQ_L2H_RADAR      BIT(8)
+#define IPC_IRQ_L2H_TXDESC_IND BIT(9)
+#define IPC_IRQ_L2H_TBTT       BIT(10)
+#define IPC_IRQ_L2H_SYNC       BIT(11)
+
+#define IPC_IRQ_L2H_ALL          \
+	(IPC_IRQ_L2H_TXCFM |     \
+	IPC_IRQ_L2H_RXDESC |     \
+	IPC_IRQ_L2H_MSG |        \
+	IPC_IRQ_L2H_DBG |        \
+	IPC_IRQ_L2H_RADAR |      \
+	IPC_IRQ_L2H_TXDESC_IND | \
+	IPC_IRQ_L2H_TBTT |       \
+	IPC_IRQ_L2H_SYNC)
+
+#define IPC_IRQ_S2H_DBG        BIT(12)
+#define IPC_IRQ_S2H_MSG        BIT(13)
+#define IPC_IRQ_S2H_RXDESC     BIT(14)
+#define IPC_IRQ_S2H_TXCFM      0x000F8000
+#define IPC_IRQ_S2H_RADAR      BIT(20)
+#define IPC_IRQ_S2H_TXDESC_IND BIT(21)
+#define IPC_IRQ_S2H_TBTT       BIT(22)
+#define IPC_IRQ_S2H_SYNC       BIT(23)
+
+#define IPC_IRQ_S2H_ALL          \
+	(IPC_IRQ_S2H_TXCFM |     \
+	IPC_IRQ_S2H_RXDESC |     \
+	IPC_IRQ_S2H_MSG |        \
+	IPC_IRQ_S2H_DBG |        \
+	IPC_IRQ_S2H_RADAR |      \
+	IPC_IRQ_S2H_TXDESC_IND | \
+	IPC_IRQ_S2H_TBTT |       \
+	IPC_IRQ_S2H_SYNC)
+
+#endif /* CL_IPC_SHARED_H */
-- 
2.36.1

