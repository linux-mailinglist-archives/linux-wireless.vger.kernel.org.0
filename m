Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C243AB8A9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhFQQJl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:41 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:19069
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232834AbhFQQIV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An8snhHf9NlafZC2OJY4o3igeG1MOqveODeMT/FFd5AsA0cX0SFz/4Hg22W4kMjqINpazqWvDeJ41bsQOyhCkmDJhiVjtFeR5mpEOfbD1HU6Pzed1uHbhT/SKoTYjyYaTg6VSVYIeAf1SLfg/9ceKk/R9MGdIGSQEcNl+6LKcd03t9DexciLoX2/ISFq4MV0uhfSsYbF6OWQOQSvYM0g5TR79dVcntRZptmwUBs7lsPheij/kqwugIDZas3LF8cW3lNR5hwtU+Oooplu4Ht761aOc/2RCN61G57XwBw9623XBfbddqOMlzltLm6uWAPSQPR7/QqMf7F7HCuJ8/YG7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4FGYK6DQkHVVdzg9KaGo6AeMTD31+zmk0BhuTIRkKI=;
 b=atE+xwhZJ0wFCn+1GsPiVvWrT+Rv6zR+a2QvD+KnzBd4adUTs+5etCAZqbvNPflKkEuz6qXUINVwJ1syiXXXCjxyNU1A0/2DfM6g6bsLNPnYKZzmY4x2DBWwVB4NjheF5Bw64JtNPt1di0EyOMByj4odSsRQSBdqlNNXJfPixYl2XnmAlf7BqpdgFDTA1skqlSgswt4/NgRScL4M2G4QJFAXteULTE0gSRXM2hFfvnPVNY6vMVLLMpciHVFdcyjcHNClXKOkNDdoCD35pDiWXVwlQPh0qklvl4WRHNFrTVLPHDVMbdzF4NTHmsNhgv96IGpzzJPj3L5x9jRy8qGZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4FGYK6DQkHVVdzg9KaGo6AeMTD31+zmk0BhuTIRkKI=;
 b=grQNj8vcgg5vOOfnXuwBD02grqE+05BHPtgqyMVzciZlBHs3J//3CR9k7QlYWQWLDfJCXhI6NWFuwnXdWXA5lQGKQmb8aCmYvvAV9mDS2epdhJ99V8XrsrBbRuvJp+6LrpOnole/nlCt67KGLtuI48rHX8C3+uUy4NxrrdUpWMs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0887.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:05:04 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:04 +0000
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
Subject: [RFC v1 102/256] cl8k: add ipc_shared.h
Date:   Thu, 17 Jun 2021 15:59:49 +0000
Message-Id: <20210617160223.160998-103-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:04:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09ac3a4a-265d-41ac-8dce-08d931a994e1
X-MS-TrafficTypeDiagnostic: AM9P192MB0887:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0887694EBB9FDF6BD5DBD504F60E9@AM9P192MB0887.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXjSFWH0m071S4ZSfGNEbLPhfXshcFDZq5sU5zwNopGA9zF350IrACdKIII5+/pkUjmbPOvJn9zANzUxXb65W3vqOwjgOHZ741XYNRxebReRLqeB8Bw6h5OI0Tv1Z/8wnlnkBSPKT2/K+uFq6k8lbGyDmRKMN1YXO0qgdeM/1ArV2l9D3KiMvt6Hn3BuaC3ZsHv5K0M2fbfWbW9FyS7JUT7lQ//sroB+m/6kG3HczebEbX5kR0Kq56YvIuRn1vdfkH8xu2iXwRVU/kM2LV2zsWwpuSJfe4I/VYxqkXaf4XzAKQVyienjHMQCZ+Ym1FwXc+TxIj4nOseQIQzlmC6d+nIz61VI7PsumzprTGa4+I8uzMPO1gcpfOKpvrt60jEr/Jw8srWDzXLHEOXc9u6P4lmCxUVyPoHTUsDIT5ymALQhSpHOGslhiscqkK6nksOoZhTGpdrUXunZS3L9lwlicFa/2PN/M0Lxq6zQAoFbnkc4vSE67ZDZZg1A37Xj5DtUjjIyecJoZYBInWw6PaAO5AFwDWlkZRV9Z8vD1SBI/1SBLFtZtDWNSJnozj6ohNek0gRHvvOSvtcVdv9gKrhaYcnBi5ptpgkzH4JnyG0pq+mA7ZpMs+DteKqrz55e8Ew/OPvvq5xkD4auwDCQimqjmDpVuTw1C1LV8SSXW0qpYLSBWxiknZPlJAGLLqk/OQd4JkGSqj7CNbCIsYsfjCKWPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(396003)(366004)(39850400004)(136003)(346002)(83380400001)(6666004)(38350700002)(4326008)(186003)(16526019)(5660300002)(54906003)(6506007)(26005)(55236004)(38100700002)(316002)(1076003)(107886003)(30864003)(52116002)(8936002)(508600001)(66476007)(66946007)(66556008)(36756003)(6916009)(6486002)(86362001)(2616005)(956004)(2906002)(8676002)(9686003)(6512007)(69590400013)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lKHhOSXIMEilMtiH1Du+Dx0CUau57/a1l8Roq4nVwzJcUN2xywJM2BFcdYAs?=
 =?us-ascii?Q?b9HIWztZ5C/GG9o/s3ZNRoSk0rEzb3D28K2FcZx0RkmFyKCi23te6tazIBb2?=
 =?us-ascii?Q?A7rrhgXnsqmZ8Mq+DiHFClbb3ORGAkoUUY7f0Ynzdi5MzaAB6eh38iI+cmUZ?=
 =?us-ascii?Q?3Ld2P4o/kzdd00XxzmIlQpZDLd1AEcV15exbK8EP/iu1z9SzKne3PnLiVoYk?=
 =?us-ascii?Q?b0VJBKHEj06OYGx/L+z/YTmaVwx8HTGL1v6HGw7SqFvIQ4VbwQKYxruhbVrs?=
 =?us-ascii?Q?xhhtaoNqmFerzAY9AI2ZSbLKBeX3R9msBs1NnUYsIjbLVatrIxZC4U6aQlow?=
 =?us-ascii?Q?AGpl5Q273JkMssN2tZf7pAQOkRv0hMIrrZtNBYM9RQbgAPJFYSoFTvdJs4qG?=
 =?us-ascii?Q?++B22WBaCfNsWNG8c82QIBjbWT2OeugOUg50eWht8xf9AXRmpgPhOSuHRriw?=
 =?us-ascii?Q?Cu7d0XdV6nD+fumMnEA6MH4PoLK0EVE9jo7LVUhOyTwtC+Mt2/BN4pha5BEQ?=
 =?us-ascii?Q?t7yXExFiAm+WMu/keh9tjp/GT6oeC+kZOe43srji1XWbiHHHd+ylZCkmG/Gv?=
 =?us-ascii?Q?P+bOnmyprvq0gNLnqDomHxH7SLj/iJnQ4pWT3l3CFEO/l/9s+7U0YEEgWLwn?=
 =?us-ascii?Q?R39bBr/fTrdKpeqjOe1yf2oyXw8LJwR5hNUWwq45JNa+bOJGAD19TL4U5MwK?=
 =?us-ascii?Q?9P+zfczxJyG0dBl9Ug5Q8wU5anl85bUo26NIpXHCG1pgn6eEV1N3qTXvOqEt?=
 =?us-ascii?Q?gSBk08XbDAb9XXsFb4tYDGxWqN6bQyl9+aU2/XezLnAlZMDi8SM5/5cFYGWT?=
 =?us-ascii?Q?peJRTDuVuBECkJKSkb/3B+cXQ7QQsx0p+6tFTa1L4c4nOhqWkPgrphAsrm+b?=
 =?us-ascii?Q?KtTRvK/MkoR9HsiSy+hgY5keAI0S/WLkbWoWesERpCWGjdyHQXWP7cbdWs19?=
 =?us-ascii?Q?fUQkaeJqzh7SApO9JFTcdfLzUY0E6trSnjndxXfdLHNwY/kKS8TTQ4NG9zIh?=
 =?us-ascii?Q?oIhhKYYLFULkeKXwpaB0sR7EPnfnZu5vbCsbwL96xoR6sdfEiRRTBW/dfakX?=
 =?us-ascii?Q?5y1Oj1dxAw/7xqIc61fLvhxwcOjT5+JJwaOB+ZFyMCZEVqYUVEeCN4mb5ryA?=
 =?us-ascii?Q?ZdrmnSX3tZCwER3k3eWr0i/Xs+xy/nqdBKM+KVH9R6o88UOf+DfmmiK9TMtB?=
 =?us-ascii?Q?xS7RAlHUmGuBAoqDSVAEpLKOpyIDc4ljMOFE6Arg5U43fGEco2cewej0YVgH?=
 =?us-ascii?Q?DbctR+STJGn3DrFumQaK0iik5nic/iTD5Isjn7JKwHzcsD5JEyaS8+7Jv2q7?=
 =?us-ascii?Q?y3IYFDwhkA051BfqGiQX9LTk?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac3a4a-265d-41ac-8dce-08d931a994e1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:26.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rl6PPg90VhrG2I9XR3RG8phLDq0JqrKWRUhxPj/sDGE22/z0H65fS3ButrPsuvEx4PMws8RN5cy1azHc+vhIig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0887
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ipc_shared.h | 1445 +++++++++++++++++
 1 file changed, 1445 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ipc_shared.h

diff --git a/drivers/net/wireless/celeno/cl8k/ipc_shared.h b/drivers/net/wi=
reless/celeno/cl8k/ipc_shared.h
new file mode 100644
index 000000000000..fbe3f6b17996
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ipc_shared.h
@@ -0,0 +1,1445 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_IPC_SHARED_H
+#define CL_IPC_SHARED_H
+
+#include "def.h"
+#include <net/mac80211.h>
+#include "utils/math.h"
+
+/** DOC: IPC - introduction
+ *
+ * IPC layer between the FW (XMAC -> LMAC, SMAC, UMAC) and the driver. Dri=
ver
+ * talks with lower layer via custom IPC messages and DMA. Basically, drv =
<->
+ * fw messages flow consists of %fw_msg, that contains info about directio=
n,
+ * message id (which is enum field of %mm_msg_tag or %dbg_msg_tag) and pay=
load
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
+ *  Messages are using prelocated buffers and size limit of %IPC_RXBUF_SIZ=
E.
+ *  Each message may have verification pattern, that allows to verify the
+ *  validity of payload. Most important TX/RX flow operations are tracked =
and
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
+#define IPC_RXBUF_BUCKET_SIZE     BIT(IPC_RXBUF_BUCKET_POW_SIZE) /* 2 ^ 5 =
=3D 32 */
+#define IPC_RXBUF_NUM_BUCKETS_RXM (IPC_RXBUF_CNT_RXM / IPC_RXBUF_BUCKET_SI=
ZE)
+#define IPC_RXBUF_NUM_BUCKETS_FW  (IPC_RXBUF_CNT_FW / IPC_RXBUF_BUCKET_SIZ=
E)
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
+       AGG_AC0_IDX =3D AC_BK,
+       AGG_AC1_IDX =3D AC_BE,
+       AGG_AC2_IDX =3D AC_VI,
+       AGG_AC3_IDX =3D AC_VO,
+       AGG_MU1_IDX,
+       AGG_MU2_IDX,
+       AGG_MU3_IDX,
+       AGG_MU4_IDX,
+       AGG_MU5_IDX,
+       AGG_MU6_IDX,
+       AGG_MU7_IDX,
+       AGG_IDX_MAX,
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
+#define LMAC_TXDESC_AGG_Q_SIZE_MAX 512
+#define SMAC_TXDESC_AGG_Q_SIZE_MAX 256
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
+ * Stringified DRV/FW versions should be small enough to fit related ethto=
ol
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
+ * 1500[eth max] - 12[hdr frame] + 14[msdu frame] + 8[llc snap] + 4[MSDU P=
adding] =3D 1514
+ * MSDU + WLAN HDR =3D 1514[MSDU MAX] + 36[MAX WLAN HDR] =3D 1550
+ * 32 bytes is being PADDED by SKB alloc for alignment.
+ * 18 byte encryption
+ * 50 bytes is save for upper layer + some internal meta data.
+ */
+#define IPC_RXBUF_SIZE           1682
+#define IPC_RXBUF_EXTRA_HEADROOM 40
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
+/* Number of PHY diagnostic port banks */
+#define DBG_DIAGS_PHY_MAX    32
+
+/* Maximum size of the RX header descriptor information in the debug dump =
*/
+#define DBG_RHD_MEM_LEN      (5 * 1024)
+
+/* Maximum size of the RX buffer descriptor information in the debug dump =
*/
+#define DBG_RBD_MEM_LEN      (5 * 1024)
+
+/* Maximum size of the TX header descriptor information in the debug dump =
*/
+#define DBG_THD_MEM_LEN      (10 * 1024)
+
+/* Driver mem size used for THDs PTs & PBDs */
+#define DBG_THD_CHAINS_INFO_THD_CNT 5
+#define DBG_THD_CHAINS_INFO_PBD_CNT 9
+#define DBG_THD_CHAINS_INFO_PT_CNT  1
+#define DBG_THD_CHAINS_INFO_ARRAY_SIZE \
+       ((DBG_THD_CHAINS_INFO_THD_CNT * sizeof(struct tx_hd)) + \
+        (DBG_THD_CHAINS_INFO_PBD_CNT * sizeof(struct tx_pbd)) + \
+        (DBG_THD_CHAINS_INFO_PT_CNT * sizeof(struct tx_policy_tbl)))
+
+#define DBG_CHAINS_INFO_ELEM_CNT 10
+
+enum DBG_CHAINS_INFO_ELEMENTS {
+       DBG_CHAINS_INFO_EMPTY,
+       DBG_CHAINS_INFO_THD,
+       DBG_CHAINS_INFO_PBD,
+       DBG_CHAINS_INFO_PT,
+       DBG_CHAINS_INFO_MAX
+};
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
+#define LA_MAC_IDX 0
+#define LA_PHY_IDX 1
+
+/* Length of the configuration data of a logic analyzer */
+#define LA_CONF_LEN          102
+
+/* Structure containing the configuration data of a logic analyzer */
+struct la_conf_tag {
+       u32 conf[LA_CONF_LEN];
+};
+
+/* Size of a logic analyzer memory */
+#define LA_MEM_LEN (256 * 1024)
+
+/* Message structure for MSGs from Emb to App */
+struct cl_ipc_e2a_msg {
+       __le16 id;
+       __le16 dummy_dest_id;
+       __le16 dummy_src_id;
+       __le16 param_len;
+       u32 param[IPC_E2A_MSG_PARAM_SIZE];
+       __le32 pattern;
+};
+
+struct cl_ipc_msg {
+       struct list_head list;
+       struct cl_ipc_e2a_msg buf;
+};
+
+enum rx_buf_type {
+       CL_RX_BUF_RXM,
+       CL_RX_BUF_FW,
+       CL_RX_BUF_MAX
+};
+
+/*
+ * Structs & function  associated with HW & SW debug data
+ * The Debug information forwarded to host when an error occurs, and print=
ed to stdout
+ * This data must be consistent with firmware, any new debug data should e=
xist also in
+ * firmware side
+ */
+
+struct tx_hd {
+       u32 upatterntx;
+       u32 nextfrmexseq_ptr;
+       u32 nextmpdudesc_ptr;
+       u32 first_pbd_ptr;
+       u32 datastartptr;
+       u32 dataendptr;
+       u32 frmlen;
+       u32 spacinginfo;
+       u32 phyctrlinfo1;
+       u32 policyentryaddr;
+       u32 bar_thd_desc_ptr;
+       u32 reserved1;
+       u32 macctrlinfo1;
+       u32 macctrlinfo2;
+       u32 statinfo;
+       u32 phyctrlinfo2;
+};
+
+struct tx_policy_tbl {
+       u32 upatterntx;
+       u32 phycntrlinfo1;
+       u32 phycntrlinfo2;
+       u32 maccntrlinfo1;
+       u32 maccntrlinfo2;
+       u32 ratecntrlinfo[CL_RATE_CONTROL_STEPS];
+       u32 phycntrlinfo3;
+       u32 phycntrlinfo4;
+       u32 phycntrlinfo5;
+       u32 stationinfo;
+       u32 ratecntrlinfohe[CL_RATE_CONTROL_STEPS];
+       u32 maccntrlinfo3;
+       u32 triggercommoninfo;
+       u32 triggerinforuallocationu0u3;
+       u32 triggerinforuallocationu4u7;
+       u32 triggerperuserinfo[MU_MAX_STREAMS];
+};
+
+struct tx_pbd {
+       u32 upatterntx;
+       u32 next;
+       u32 datastartptr;
+       u32 dataendptr;
+       u32 bufctrlinfo;
+};
+
+enum cl_macfw_dbg_severity {
+       CL_MACFW_DBG_SEV_NONE,
+       CL_MACFW_DBG_SEV_ERROR,
+       CL_MACFW_DBG_SEV_WARNING,
+       CL_MACFW_DBG_SEV_INFO,
+       CL_MACFW_DBG_SEV_VERBOSE,
+
+       CL_MACFW_DBG_SEV_MAX
+};
+
+struct phy_channel_info {
+       __le32 info1;
+       __le32 info2;
+};
+
+struct dbg_debug_info_tag {
+       u32 error_type; /* (0: recoverable, 1: fatal) */
+       u32 hw_diag;
+       char error[DBG_ERROR_TRACE_SIZE];
+       u32 sw_diag_len;
+       char sw_diag[DBG_SW_DIAG_MAX_LEN];
+       struct phy_channel_info chan_info;
+       struct la_conf_tag la_conf[LA_CNT];
+       u16 diags_mac[DBG_DIAGS_MAC_MAX];
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
+       u32 total_cnt;
+       u32 total_rtx_cnt;
+       u16 total_ba_received;
+       u16 total_ba_not_received_cnt;
+       u16 total_lifetime_expired_cnt;
+       u16 total_rtx_limit_reached;
+       u16 total_packets_below_baw;
+       u16 total_packets_above_baw;
+       u16 total_ba_not_received_cnt_ps;
+       u16 total_cleard_ba;
+       u16 total_unexpected_ba;
+       u16 total_invalid_ba;
+       u16 total_ack_instead_ba;
+};
+
+struct cl_txl_single_statistics {
+       u32 total_cnt;
+       u32 total_rtx_cnt;
+       u16 total_lifetime_expired_cnt;
+       u16 total_rtx_limit_reached;
+       u16 total_rtx_limit_reached_ps;
+};
+
+enum {
+       CE_BACKOFF_25,
+       CE_BACKOFF_50,
+       CE_BACKOFF_100,
+       CE_BACKOFF_500,
+       CE_BACKOFF_1000,
+       CE_BACKOFF_5000,
+       CE_BACKOFF_10000,
+       CE_BACKOFF_20000,
+       CE_BACKOFF_20000_ABOVE,
+       CE_BACKOFF_MAX
+};
+
+struct cl_txl_backoff_statistics {
+       u32 chain_time;
+       u32 backoff_hist[CE_BACKOFF_MAX];
+};
+
+struct cl_txl_tid_statistics {
+       u32 total_tid_desc_cnt;
+};
+
+/* Natt closed an aggregation due to one of the bellow reasons. */
+enum {
+       NATT_REASON_MAX_LEN    =3D 0x1,
+       NATT_REASON_TXOP_LIMIT =3D 0x2,
+       NATT_REASON_MPDU_NUM   =3D 0x4,
+       NATT_REASON_LAST_BIT   =3D 0x8,
+       NATT_REASON_MAX
+};
+
+/* Tx BW */
+enum {
+       NATT_BW_20,
+       NATT_BW_40,
+       NATT_BW_80,
+       NATT_BW_160,
+       NATT_BW_MAX
+};
+
+struct cl_txl_natt_statistics {
+       u32 agg_close_reason[NATT_REASON_MAX];
+       u32 chosen_frame_bw[NATT_BW_MAX];
+       u32 operation_mode[8];
+};
+
+enum {
+       AGG_IN_TXOP_CLOSE_REASON_NO_TXDESC,
+       AGG_IN_TXOP_CLOSE_REASON_TXOP_EXPIRED,
+       AGG_IN_TXOP_CLOSE_REASON_ACTIVE_DELBA,
+       AGG_IN_TXOP_CLOSE_REASON_MAX
+};
+
+struct amsdu_stat {
+       u16 packet_cnt_2;
+       u16 packet_cnt_3;
+       u16 packet_cnt_4;
+       u16 packet_cnt_5_or_more;
+};
+
+struct cl_txl_mu_statistics {
+       u16 chain_cnt;
+       u16 status_cnt;
+       u16 ba_received;
+       u16 ba_no_received;
+       u16 clear_ba;
+       u16 correct_ba;
+       u16 unexpected_ba;
+       u16 invalid_ba;
+};
+
+struct cl_txl_agg_statistics {
+       u16 agg_size_statistics[DBG_STATS_MAX_AGG_SIZE];
+       u32 packet_failed_statistics[DBG_STATS_MAX_AGG_SIZE];
+       u32 packet_passed_statistics[DBG_STATS_MAX_AGG_SIZE];
+       u16 htp_agg_size_statistics[DBG_STATS_MAX_AGG_SIZE];
+       u32 htp_packet_failed_statistics[DBG_STATS_MAX_AGG_SIZE];
+       u32 htp_packet_passed_statistics[DBG_STATS_MAX_AGG_SIZE];
+       u16 agg_in_txop_statistics[CL_MAX_AGG_IN_TXOP];
+       u16 agg_in_txop_close_reason[AGG_IN_TXOP_CLOSE_REASON_MAX];
+       u16 agg_in_txop_queue_switch;
+       u16 agg_in_txop_queue_switch_abort_bw;
+       struct amsdu_stat amsdu_stat[IPC_MAX_BA_SESSIONS];
+       u16 mu_agg_size_statistics[MU_MAX_STREAMS][DBG_STATS_MAX_AGG_SIZE];
+       struct cl_txl_mu_statistics mu_stats[MU_MAX_STREAMS];
+};
+
+struct cl_txl_ac_statistics {
+       u32 total_q_switch_cnt;
+       u32 total_ac_desc_cnt;
+};
+
+struct cl_txl_underrun_statistics {
+       u16 length_cnt;
+       u16 pattern_cnt;
+       u16 flushed_frames_cnt;
+};
+
+struct cl_txl_rts_cts_statistics {
+       u32 fw_rts_cnt;
+       u32 hw_rts_cnt;
+       u32 fw_cts_cnt;
+       u32 hw_cts_cnt;
+};
+
+struct cl_txl_backoff_params {
+       u32 singelton_total[AC_MAX];
+       u32 singelton_cnt[AC_MAX];
+       u32 agg_total[AC_MAX];
+       u32 agg_cnt[AC_MAX];
+};
+
+struct cl_txl_htp_statistics {
+       u32 total_cnt[TID_MAX];
+       u32 need_response;
+       u32 tb_response_required;
+       u32 ac_not_found;
+       u32 end_of_packet_int;
+       u32 tb_bw_decision;
+       u32 tb_ba_thd_removed;
+       u32 tb_ac_unchain;
+       u32 tb_htp_unchain;
+       u32 tb_dummy_htp_tx;
+       u32 tb_dummy_no_tx;
+       u32 msta_ba_received;
+       u32 msta_ba_aid_not_found;
+};
+
+struct cl_txl_vns_statistics {
+       u32 off_he;
+       u32 off_ht_vht;
+       u32 off_ofdm;
+       u32 off_cck;
+       u32 on_he;
+       u32 on_ht_vht;
+       u32 on_ofdm;
+       u32 on_cck;
+};
+
+struct cl_txl_fec_statistics {
+       u32 ldpc;
+       u32 bcc;
+};
+
+struct cl_txl_statistics {
+       u32 type; /* This field should be first in the struct */
+       u32 recovery_count;
+       u32 tx_obtain_bw_fail_cnt;
+       struct cl_txl_single_statistics single[IPC_TX_QUEUE_CNT];
+       struct cl_txl_ba_statistics ba[IPC_MAX_BA_SESSIONS];
+       struct cl_txl_backoff_statistics backoff_stats[AC_MAX];
+       struct cl_txl_natt_statistics natt;
+       struct cl_txl_tid_statistics tid[TID_MAX];
+       struct cl_txl_agg_statistics agg;
+       struct cl_txl_ac_statistics ac[CE_AC_MAX];
+       struct cl_txl_underrun_statistics underrun;
+       struct cl_txl_rts_cts_statistics rts_cts;
+       struct cl_txl_backoff_params backoff_params;
+       struct cl_txl_htp_statistics htp;
+       struct cl_txl_vns_statistics vns;
+       struct cl_txl_fec_statistics fec;
+};
+
+/* Flushed beacon list options */
+enum {
+       BCN_FLUSH_PENDING,
+       BCN_FLUSH_DOWNLOADING,
+       BCN_FLUSH_TRANSMITTING,
+       BCN_FLUSH_MAX,
+};
+
+struct bcn_backup_stats {
+       u32 bcn_backup_used_cnt;
+       u32 bcn_backup_tx_cnt;
+       u32 bcn_backup_flushed_cnt;
+       u32 bcn_backup_used_in_arow_cnt;
+       u32 bcn_backup_max_used_in_arow_cnt;
+};
+
+struct beacon_timing {
+       /* Time measurements between beacons */
+       u32 last_bcn_start_time;
+       u32 max_time_from_last_bcn;
+       u32 min_time_from_last_bcn;
+       u32 total_bcn_time;
+       /* Time measurements until beacon chained */
+       u32 imp_tbtt_start_time;
+       u32 bcn_chain_total_time;
+       u32 bcn_chain_max_time;
+       u32 bcn_chain_min_time;
+       /* Time measurements until received beacon from host */
+       u32 bcn_last_request_time;
+       u32 max_bcn_time_until_get_beacon_from_driver_in_tbtt;
+       u32 bcn_last_req_rec_time;
+       /* Time measurements of bcn from pending to chain */
+       u32 bcn_push_pending_start_time;
+       u32 bcn_pending_2_chain_max_time;
+};
+
+struct beacon_counters {
+       u32 bcn_time_from_driver_not_in_threshold_cnt;
+       u32 nof_time_intervals_between_beacons;
+       u32 total_cnt;
+       u32 bcn_chain_total_cnt;
+       u32 ce_txl_flushed_beacons[BCN_FLUSH_MAX];
+       u32 pending2chain_not_in_threshold_cnt;
+       u16 total_bcn_req_without_rec_from_host;
+       u16 max_bcn_not_received_from_host;
+       u32 total_beacons_received_from_host;
+};
+
+struct cl_bcn_statistics {
+       u32 type; /* This field should be first in the struct */
+       struct beacon_counters beacon_counters;
+       struct beacon_timing beacon_timing;
+       struct bcn_backup_stats bcn_backup_stats;
+};
+
+enum agg_tx_rate_drop_reason {
+       AGG_TX_RATE_DROP_MAX_BA_NOT_RECEIVED_REACHED,
+       AGG_TX_RATE_DROP_MAX_BA_PER_REACHED,
+       AGG_TX_RATE_DROP_MAX_RETRY_REACHED,
+       AGG_TX_RATE_DROP_MAX,
+};
+
+struct cl_rate_drop_statistics {
+       u32 type;
+       u32 drop_reason[AGG_TX_RATE_DROP_MAX];
+};
+
+#define BF_DB_MAX 16
+
+enum bfr_rx_err {
+       BFR_RX_ERR_BW_MISMATCH,
+       BFR_RX_ERR_NSS_MISMATCH,
+       BFR_RX_ERR_SOUNDING_CHBW,
+       BFR_RX_ERR_TOKEN_MISMATCH,
+       BFR_RX_ERR_NDP_DROP,
+       BFR_SEGMENTED_DROP,
+       BFR_RX_ERR_MISS_ACK,
+       BFR_RX_ERR_RESOURCE_NA,
+       BFR_RX_ERR_MAX
+};
+
+enum TX_BF_DATA_STAT {
+       TX_BF_DATA_OK =3D 0,
+       TX_BF_DATA_BUFFERED_RESOURCE_ERR,
+       TX_BF_DATA_RELEASED_RESOURCE_ERR,
+       TX_BF_DATA_BUFFERED_PS_STA,
+       TX_BF_DATA_RELEASED_PS_STA,
+       TX_BF_DATA_ERR_BFR_MISS,
+       TX_BF_DATA_ERR_BFR_OUTDATED,
+       TX_BF_DATA_ERR_MISMATCH_BW,
+       TX_BF_DATA_ERR_MISMATCH_NSS,
+       TX_BF_DATA_ERR_MAX
+};
+
+struct bf_ctrl_dbg {
+       u16 ndp_cnt;
+       u16 bfp_cnt;
+       u16 su_bfr_cnt;
+       u16 mu_bfr_cnt;
+       u16 bf_invalid_cnt[BFR_RX_ERR_MAX];
+       u16 tx_bf_data_err[TX_BF_DATA_ERR_MAX];
+};
+
+struct bf_stats_database {
+       bool is_active_list;
+       struct bf_ctrl_dbg dbg;
+       u8 sta_idx;
+       u16 active_dsp_idx;
+       u16 passive_dsp_idx;
+};
+
+struct cl_bf_statistics {
+       u32 type;
+       bool print_active_free_list;
+       struct bf_stats_database stats_data[BF_DB_MAX];
+};
+
+enum amsdu_deaggregation_err {
+       AMSDU_DEAGGREGATION_ERR_MAX_MSDU_REACH,
+       AMSDU_DEAGGREGATION_ERR_MSDU_GT_AMSDU_LEN,
+       AMSDU_DEAGGREGATION_ERR_MSDU_LEN,
+       AMSDU_ENCRYPTION_KEY_GET_ERR,
+
+       AMSDU_DEAGGREGATION_ERR_MAX
+};
+
+enum emb_ll1_handled_frm_type {
+       BA_FRM_TYPE,
+       NDPA_FRM_TYPE,
+       NDP_FRM_TYPE,
+       ACTION_NO_ACK_FRM_TYPE,
+
+       MAX_HANDLED_FRM_TYPE
+};
+
+enum rhd_decr_idx {
+       RHD_DECR_UNENC_IDX,
+       RHD_DECR_ICVFAIL_IDX,
+       RHD_DECR_CCMPFAIL_IDX,
+       RHD_DECR_AMSDUDISCARD_IDX,
+       RHD_DECR_NULLKEY_IDX,
+       RHD_DECR_IDX_MAX
+};
+
+#define RX_CLASSIFICATION_MAX 6
+#define FREQ_OFFSET_TABLE_IDX_MAX 8 /* Must be a power of 2 */
+#define RX_MAX_MSDU_IN_SINGLE_AMSDU 16
+
+struct cl_rxl_statistics {
+       u32 type; /* This field should be first in the struct */
+       u32 rx_imp_bf_counter[MU_UL_MAX];
+       u32 rx_imp_bf_int_counter[MU_UL_MAX];
+       u32 rx_class_counter[MU_UL_MAX][RX_CLASSIFICATION_MAX];
+       u32 rx_class_int_counter[MU_UL_MAX];
+       u32 counter_timer_trigger_ll1[MU_UL_MAX];
+       u32 counter_timer_trigger_ll2[MU_UL_MAX];
+       u32 total_rx_packets[MU_UL_MAX];
+       u32 total_agg_packets[MU_UL_MAX];
+       u32 rx_fifo_overflow_err_cnt[MU_UL_MAX];
+       u32 rx_dma_discard_cnt;
+       u32 host_rxelem_not_ready_cnt;
+       u32 msdu_host_rxelem_not_ready_cnt;
+       u32 dma_rx_pool_not_ready_cnt;
+       u32 rx_pckt_exceed_max_len_cnt[MU_UL_MAX];
+       u32 rx_pckt_bad_ba_statinfo_cnt[MU_UL_MAX];
+       u32 nav_value[MU_UL_MAX];
+       u16 max_mpdu_data_len[MU_UL_MAX];
+       u8 rhd_ll2_max_cnt[MU_UL_MAX]; /* Rhd first list */
+       u8 rhd_ll1_max_cnt[MU_UL_MAX]; /* Rhd second list */
+       u8 cca_busy_percent;
+       u8 rx_mine_busy_percent;
+       u8 tx_mine_busy_percent;
+       u8 sample_cnt;
+       /* Emb handled frames */
+       u32 emb_ll1_handled_frame_counter[MU_UL_MAX][MAX_HANDLED_FRM_TYPE];
+       u32 rxm_stats_overflow[MU_UL_MAX];
+       /* RX AMSDU statistics counters */
+       u32 stats_tot_rx_amsdu_cnt[MU_UL_MAX];
+       u32 stats_rx_amsdu_cnt[MU_UL_MAX][RX_MAX_MSDU_IN_SINGLE_AMSDU];
+       u32 stats_rx_amsdu_err[MU_UL_MAX][AMSDU_DEAGGREGATION_ERR_MAX];
+       u32 stats_rx_format[FORMATMOD_MAX];
+       /* RX decryption error */
+       u32 decrypt_err[RHD_DECR_IDX_MAX];
+       u32 rx_incorrect_format_mode[MU_UL_MAX];
+       u32 fcs_error_counter[MU_UL_MAX];
+       u32 phy_error_counter[MU_UL_MAX];
+       u32 ampdu_received_counter[MU_UL_MAX];
+       u32 delimiter_error_counter[MU_UL_MAX];
+       u32 ampdu_incorrect_received_counter[MU_UL_MAX];
+       u32 correct_received_mpdu[MU_UL_MAX];
+       u32 incorrect_received_mpdu[MU_UL_MAX];
+       u32 discarded_mpdu[MU_UL_MAX];
+       u32 incorrect_delimiter[MU_UL_MAX];
+       u32 rxm_mpdu_cnt[MU_UL_MAX];
+       u32 rxm_rule0_match[MU_UL_MAX];
+       u32 rxm_rule1_match[MU_UL_MAX];
+       u32 rxm_rule2_match[MU_UL_MAX];
+       u32 rxm_rule3_match[MU_UL_MAX];
+       u32 rxm_rule4_match[MU_UL_MAX];
+       u32 rxm_rule5_match[MU_UL_MAX];
+       u32 rxm_rule6_match[MU_UL_MAX];
+       u32 rxm_default_rule_match[MU_UL_MAX];
+       u32 rxm_amsdu_1[MU_UL_MAX];
+       u32 rxm_amsdu_2[MU_UL_MAX];
+       u32 rxm_amsdu_3[MU_UL_MAX];
+       u32 rxm_amsdu_4[MU_UL_MAX];
+       u32 rxm_amsdu_5_15[MU_UL_MAX];
+       u32 rxm_amsdu_16_or_more[MU_UL_MAX];
+       u32 frequency_offset[FREQ_OFFSET_TABLE_IDX_MAX];
+       u32 frequency_offset_idx;
+       u32 rts_bar_cnt[MU_UL_MAX];
+};
+
+enum trigger_flow_single_trigger_type {
+       TRIGGER_FLOW_BASIC_TRIGGER_TYPE,
+       TRIGGER_FLOW_BSRP_TYPE,
+       TRIGGER_FLOW_BFRP_TYPE,
+       TRIGGER_FLOW_MAX
+};
+
+struct cl_trigger_flow_statistics {
+       u32 type; /* This field should be first in the struct */
+       u32 single_trigger_sent[TRIGGER_FLOW_MAX][AC_MAX];
+       u32 htp_rx_failure[AC_MAX];
+       u32 trigger_based_mpdu[MU_UL_MAX];
+};
+
+#define DYN_CAL_DEBUG_NUM_ITER  3
+
+struct dyn_cal_debug_info_t {
+       u16 calib_num;
+       u8 curr_config;
+       union {
+               struct {
+                       u8 iter_num;
+                       u32 measured_val;
+               };
+               struct {
+                       u8 min_config;
+                       u32 dyn_cal_min_val;
+                       u32 dyn_cal_max_val;
+                       u8 max_config;
+               };
+       };
+
+       u8 new_config;
+};
+
+struct cl_dyn_calib_statistics {
+       u32 type; /* This field should be first in the struct */
+       u8 is_multi_client_mode;
+       u8 default_dyn_cal_val;
+       u8 dyn_cal_debug_info_ix;
+       u16 dyn_cal_process_cnt;
+       u16 mac_phy_sync_err_cnt;
+       struct dyn_cal_debug_info_t dyn_cal_debug_info[DYN_CAL_DEBUG_NUM_IT=
ER];
+};
+
+struct ac_info_t {
+       u8 active_session;
+       u32 total_q_switch_cnt;
+       u32 total_ac_desc_cnt;
+       u8 mult_ampdu_in_txop_cnt;
+};
+
+/* End of parameters that require host changes */
+
+/* Structure containing the parameters for assert prints DBG_PRINT_IND mes=
sage. */
+struct dbg_print_ind {
+       __le16 file_id;
+       __le16 line;
+       __le16 has_param;
+       u8 err_no_dump;
+       u8 reserved;
+       __le32 param;
+};
+
+enum {
+       CE_TXL_TX_PATH_IDLE,
+       CE_TXL_TX_PATH_START,
+       CE_TXL_TX_PATH_POST_START_DOWNLOAD,
+       CE_TXL_TX_PATH_TX_DATA_DOWNLOADING,
+       CE_TXL_TX_PATH_MU_RECOVERY,
+       CE_TXL_TX_PATH_LAST_DOWNLOADING,
+       CE_TXL_TX_PATH_NEXT_SESSION_PREPARED,
+       CE_TXL_TX_PATH_MU_NEXT_JOB_READY,
+       CE_TXL_TX_PATH_MAX
+};
+
+/* 4 ACs + BCN + HTP + current THD */
+#define MACHW_THD_REGS_CNT (IPC_TX_QUEUE_CNT + 2)
+
+/* Enumeration of MAC-HW registers (debug dump at recovery event) */
+enum {
+       HAL_MACHW_AGGR_STATUS,
+       HAL_MACHW_DEBUG_HWSM_1,
+       HAL_MACHW_DEBUG_HWSM_2,
+       HAL_MACHW_DEBUG_HWSM_3,
+       HAL_MACHW_DMA_STATUS_1,
+       HAL_MACHW_DMA_STATUS_2,
+       HAL_MACHW_DMA_STATUS_3,
+       HAL_MACHW_DMA_STATUS_4,
+       HAL_MACHW_RX_HEADER_H_PTR,
+       HAL_MACHW_RX_PAYLOAD_H_PTR,
+       HAL_MACHW_DEBUG_BCN_S_PTR,
+       HAL_MACHW_DEBUG_AC0_S_PTR,
+       HAL_MACHW_DEBUG_AC1_S_PTR,
+       HAL_MACHW_DEBUG_AC2_S_PTR,
+       HAL_MACHW_DEBUG_AC3_S_PTR,
+       HAL_MACHW_DEBUG_HTP_S_PTR,
+       HAL_MACHW_DEBUG_TX_C_PTR,
+       HAL_MACHW_DEBUG_RX_HDR_C_PTR,
+       HAL_MACHW_DEBUG_RX_PAY_C_PTR,
+       HAL_MACHW_MU0_TX_POWER_LEVEL_DELTA_1,
+       HAL_MACHW_MU0_TX_POWER_LEVEL_DELTA_2,
+       HAL_MACHW_POWER_BW_CALIB_FACTOR,
+       HAL_MACHW_TX_POWER_ANTENNA_FACTOR_1_ADDR,
+       HAL_MACHW_TX_POWER_ANTENNA_FACTOR_2_ADDR,
+       /* Keep this entry last */
+       HAL_MACHW_REG_NUM
+};
+
+#define HAL_MACHW_FSM_REG_NUM ((HAL_MACHW_DEBUG_HWSM_3 - HAL_MACHW_AGGR_ST=
ATUS) + 1)
+
+enum {
+       MPU_COMMON_FORMAT,
+       MPU_COMMON_FIELD_CTRL,
+       MPU_COMMON_LEGACY_INFO,
+       MPU_COMMON_COMMON_CFG_1,
+       MPU_COMMON_COMMON_CFG_2,
+       MPU_COMMON_COMMON_CFG_3,
+       MPU_COMMON_HE_CFG_1,
+       MPU_COMMON_HE_CFG_2,
+       MPU_COMMON_INT_STAT_RAW,
+       RIU_CCAGENSTAT,
+       PHY_HW_DBG_REGS_CNT
+};
+
+/* Error trace CE_AC info */
+struct dbg_ac_info {
+       u8 chk_state;
+       u8 tx_path_state;
+       u8 physical_queue_idx;
+       u16 active_session;
+       u32 last_frame_exch_ptr;
+};
+
+/* Error trace txdesc lists info */
+struct dbg_txlist_info {
+       u8 curr_session_idx;
+       u8 next_session_idx;
+       u16 pending_cnt;
+       u16 download_cnt;
+       u16 transmit_cnt;
+       u16 wait_for_ba_cnt;
+       u16 next_pending_cnt;
+};
+
+enum {
+       SING_FRM_TYPE,
+       AGG_FRM_TYPE,
+       AGG_NEXT_IN_TXOP_FRM_TYPE,
+       INT_FRM_TYPE,
+       BCN_FRM_TYPE,
+       MU_FRM_TYPE,
+       FRM_TYPE_BASIC_TRIGGER,
+       FRM_TYPE_MU_BAR_TRIGGER,
+       BCK_BCN_TYPE,
+       TB_FRT_TYPE,
+       QOS_NULL,
+       AGG_TB,
+       RTS_TYPE,
+       CTS_TYPE,
+       TB_SINGLE_FRM_TYPE,
+       TF_AMPDU_TYPE,
+       CL_MAX_FRM_TYPE,
+};
+
+/* Txl chain info */
+struct cl_dbg_txl_chain_info {
+       u32 count;
+       u32 frm_type;
+       u32 first_thd_ptr;
+       u32 last_thd_ptr;
+       u32 prev_thd_ptr;
+       u32 req_phy_flags;
+       u8 reqbw;
+       u8 ce_txq_idx;
+       u16 mpdu_count;
+       u8 chbw;
+       u32 rate_ctrl_info;
+       u32 rate_ctrl_info_he;
+       u32 txstatus;
+       u32 length;
+       u32 tx_time;
+};
+
+struct dbg_txl_ac_chain_trace {
+       struct cl_dbg_txl_chain_info data[DBG_TXL_FRAME_EXCH_TRACE_DEPTH];
+       u32 count;
+       u8 next_chain_index;
+       u8 next_done_index;
+       u8 delta;
+};
+
+struct dbg_fw_trace {
+       u32 string_ptr;
+       u32 var_1;
+       u32 var_2;
+       u32 var_3;
+       u32 var_4;
+       u32 var_5;
+       u32 var_6;
+       /*
+        * This field is used only for driver pring dump file.
+        * collect string char is done at error dump collect data function.
+        */
+       char string_char[DBG_FW_TRACE_STR_MAX];
+};
+
+/* Error trace MAC-FW info */
+struct dbg_fw_info {
+       struct dbg_ac_info ac_info[CE_AC_MAX];
+       struct dbg_txlist_info txlist_info_singles[IPC_TX_QUEUE_CNT];
+       struct dbg_txlist_info txlist_info_agg[AGG_IDX_MAX];
+       struct dbg_txl_ac_chain_trace txl_ac_chain_trace[CE_AC_MAX];
+       struct dbg_fw_trace fw_trace[DBG_FW_TRACE_SIZE];
+       u32 fw_trace_idx;
+};
+
+/* TXM regs */
+struct dbg_txm_regs {
+       u8 hw_state;
+       u8 fw_state;
+       u8 spx_state;
+       u8 free_buf_state;
+       u8 mpdu_cnt;
+       u8 lli_cnt;
+       u8 lli_done_reason;
+       u8 lli_done_mpdu_num;
+       u16 active_bytes;
+       u16 prefetch_bytes;
+       u32 last_thd_done_addr;
+       u16 last_thd_done_mpdu_num;
+       u16 underrun_cnt;
+};
+
+/* Error trace HW registers */
+struct dbg_hw_reg_info {
+       u32 mac_hw_reg[HAL_MACHW_REG_NUM];
+       u32 mac_hw_sec_fsm[CL_MU_IDX_MAX][HAL_MACHW_FSM_REG_NUM];
+       u32 phy_mpu_hw_reg[PHY_HW_DBG_REGS_CNT];
+       struct dbg_txm_regs txm_regs[AGG_IDX_MAX];
+};
+
+struct dbg_meta_data {
+       __le32 lmac_req_buf_size;
+       u8 physical_queue_cnt;
+       u8 agg_index_max;
+       u8 ce_ac_max;
+       u8 mu_user_max;
+       u8 txl_exch_trace_depth;
+       __le16 mac_hw_regs_max;
+       __le16 phy_hw_regs_max;
+       __le16 thd_chains_data_size;
+       u8 chains_info_elem_cnt;
+};
+
+struct dbg_agg_thds_addr {
+       u32 rts_cts_thd_addr;
+       u32 athd_addr;
+       u32 tf_thd_addr;
+       u32 bar_thd_addr;
+       u32 policy_table_addr;
+};
+
+struct dbg_agg_thd_info {
+       struct tx_hd rts_cts_thd;
+       struct tx_hd athd;
+       struct tx_hd tf_thd;
+       struct tx_hd bar_thd;
+       struct tx_policy_tbl policy_table;
+};
+
+struct dbg_machw_regs_thd_info {
+       struct tx_hd thd[MACHW_THD_REGS_CNT];
+};
+
+struct dbg_thd_chains_info {
+       u8 type_array[DBG_CHAINS_INFO_ELEM_CNT];
+       u32 elem_address[DBG_CHAINS_INFO_ELEM_CNT];
+};
+
+struct dbg_thd_chains_data {
+       u8 data[DBG_THD_CHAINS_INFO_ARRAY_SIZE];
+};
+
+/* Error trace debug structure. common to fw & drv */
+struct dbg_error_trace_info_common {
+       struct dbg_print_ind error_info;
+       struct dbg_meta_data dbg_metadata;
+       struct dbg_hw_reg_info hw_info;
+       struct dbg_fw_info fw_info;
+       struct dbg_agg_thds_addr agg_thds_addr[AGG_IDX_MAX];
+};
+
+/* Dbg error info driver side */
+struct dbg_error_trace_info_drv {
+       struct dbg_error_trace_info_common common_info;
+       struct dbg_agg_thd_info agg_thd_info[AGG_IDX_MAX];
+       struct dbg_machw_regs_thd_info machw_thd_info;
+       struct dbg_thd_chains_info thd_chains_info[CE_AC_MAX];
+       struct dbg_thd_chains_data thd_chains_data[CE_AC_MAX];
+};
+
+/*
+ * This is the main debug struct, the kernel allocate the needed spaces us=
ing kmalloc().
+ * the firmware holds a pointer to this struct.
+ */
+struct dbg_dump_info {
+       u32 dbg_info; /* Should be first member in the struct */
+       /* Dump data transferred to host */
+       struct dbg_debug_info_tag general_data;
+       struct dbg_error_trace_info_drv fw_dump;
+       u8 la_mem[LA_CNT][LA_MEM_LEN];
+};
+
+struct dbg_info {
+       union {
+               u32 type;
+               struct dbg_dump_info dump;
+               struct cl_txl_statistics tx_stats;
+               struct cl_bcn_statistics bcn_stats;
+               struct cl_rxl_statistics rx_stats;
+               struct cl_dyn_calib_statistics dyn_calib_stats;
+               struct cl_rate_drop_statistics rate_drop_stats;
+               struct cl_bf_statistics bf_stats;
+               struct cl_trigger_flow_statistics trigger_flow_stats;
+       } u;
+};
+
+/* Structure of a list element header */
+struct co_list_hdr {
+       __le32 next;
+};
+
+/* ETH2WLAN and NATT common parameters field (e2w_natt_param) struct defin=
ition: */
+struct cl_e2w_natt_param {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+       u32 valid           : 1,  /* [0] */
+           ampdu           : 1,  /* [1] */
+           last_mpdu       : 1,  /* [2] */
+           lc_snap         : 1,  /* [3] */
+           vlan            : 1,  /* [4] */
+           amsdu           : 1,  /* [5] */
+           e2w_band_id     : 1,  /* [6] */
+           use_local_addr  : 1,  /* [7] */
+           hdr_conv_enable : 1,  /* [8] */
+           sta_index       : 7,  /* [9:15] */
+           packet_length   : 15, /* [30:16] */
+           e2w_int_enable  : 1;  /* [31] */
+#else /* __BIG_ENDIAN_BITFIELD */
+       u32 e2w_int_enable  : 1,  /* [0] */
+           packet_length   : 15, /* [15:1] */
+           sta_index       : 7,  /* [22:16] */
+           hdr_conv_enable : 1,  /* [23] */
+           use_local_addr  : 1,  /* [24] */
+           e2w_band_id     : 1,  /* [25] */
+           amsdu           : 1,  /* [26] */
+           vlan            : 1,  /* [27] */
+           llc_snap        : 1,  /* [28] */
+           last_mpdu       : 1,  /* [29] */
+           ampdu           : 1,  /* [30] */
+           valid           : 1;  /* [31] */
+#endif
+};
+
+#define CL_CCMP_GCMP_PN_SIZE 6
+
+struct cl_e2w_txhdr_param {
+       __le16 frame_ctrl;
+       __le16 seq_ctrl;
+       __le32 ht_ctrl;
+       u8 encrypt_pn[CL_CCMP_GCMP_PN_SIZE];
+       __le16 qos_ctrl;
+};
+
+/* This structure is not filled by the driver, so there is no need to supp=
ort LITTLE/BIG ENDIAN */
+struct cl_natt_result {
+       u32 n_zld     : 16, /* [15:0] Number of Zero-Length Delimiters */
+           reserved  : 15, /* [30:16] */
+           natt_done : 1;  /* [31] NATT Tx Descriptor */
+};
+
+/* Bit 16 Has different usage for single (valid sta - set by host) or agg =
(tx done - set by HW) */
+struct cl_e2w_result {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+       u32 backup_bcn                        : 1,  /* [0] */
+           dont_chain                        : 1,  /* [1] */
+           is_flush_needed                   : 1,  /* [2] */
+           is_internal                       : 1,  /* [3] */
+           which_descriptor                  : 2,  /* [5:4] */
+           is_first_in_AMPDU                 : 1,  /* [6] */
+           is_ext_buff                       : 1,  /* [7] */
+           is_txinject                       : 1,  /* [8] */
+           is_vns                            : 1,  /* [9] */
+           single_type                       : 2,  /* [11:10] */
+           tid                               : 4,  /* [15:12] */
+           single_valid_sta__agg_e2w_tx_done : 1,  /* [16] */
+           msdu_length                       : 13, /* [29:17] */
+           bcmc                              : 1,  /* [30] */
+           sw_padding                        : 1;  /* [31] */
+#else /* __BIG_ENDIAN_BITFIELD */
+       u32 sw_padding                        : 1,  /* [0] */
+           bcmc                              : 1,  /* [1] */
+           msdu_length                       : 13, /* [14:2] */
+           single_valid_sta__agg_e2w_tx_done : 1,  /* [15] */
+           tid                               : 4,  /* [19:16] */
+           single_type                       : 2,  /* [21:20] */
+           is_vns                            : 1,  /* [22] */
+           is_txinject                       : 1,  /* [23] */
+           is_ext_buff                       : 1,  /* [24] */
+           is_first_in_AMPDU                 : 1,  /* [25] */
+           which_descriptor                  : 2,  /* [27:26] */
+           is_internal                       : 1,  /* [28] */
+           is_flush_needed                   : 1,  /* [29] */
+           dont_chain                        : 1,  /* [30] */
+           backup_bcn                        : 1;  /* [31] */
+#endif
+};
+
+struct tx_host_info {
+#ifdef __LITTLE_ENDIAN_BITFIELD
+       u32 packet_cnt               : 4, /* [3:0] */
+           host_padding             : 8, /* [11:4] */
+           last_MSDU_LLI_INT_enable : 1, /* [12] */
+           is_eth_802_3             : 1, /* [13] */
+           is_protected             : 1, /* [14] */
+           vif_index                : 4, /* [18:15] */
+           rate_ctrl_entry          : 3, /* [21:19] */
+           expected_ack             : 1, /* [22] */
+           is_bcn                   : 1, /* [23] */
+           hw_key_idx               : 8; /* [31:24] */
+#else /* __BIG_ENDIAN_BITFIELD */
+       u32 hw_key_idx               : 8, /* [7:0] */
+           is_bcn                   : 1, /* [8] */
+           expected_ack             : 1, /* [9] */
+           rate_ctrl_entry          : 3, /* [12:10] */
+           vif_index                : 4, /* [16:13] */
+           is_protected             : 1, /* [17] */
+           is_eth_802_3             : 1, /* [18] */
+           last_MSDU_LLI_INT_enable : 1, /* [19] */
+           host_padding             : 8, /* [27:20] */
+           packet_cnt               : 4; /* [31:28] */
+#endif
+};
+
+struct lmacapi {
+       __le32 packet_addr[CL_AMSDU_TX_PAYLOAD_MAX];
+       __le16 packet_len[CL_AMSDU_TX_PAYLOAD_MAX];
+       __le16 push_timestamp; /* Milisec */
+};
+
+struct lmacpriv {
+       __le32 buffer;
+};
+
+struct txdesc {
+       /* Pointer to the next element in the queue */
+       struct co_list_hdr list_hdr;
+       /* E2w txhdr parameters */
+       struct cl_e2w_txhdr_param e2w_txhdr_param __aligned(4);
+       /* Celeno flags field */
+       struct tx_host_info host_info __aligned(4);
+       /* Common parameters for ETH2WLAN and NATT hardware modules */
+       struct cl_e2w_natt_param  e2w_natt_param;
+       /* ETH2WLAN status and NATT calculation results */
+       struct cl_e2w_result e2w_result;
+       /* Information provided by UMAC to LMAC */
+       struct lmacapi umacdesc;
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
+       /*
+        * Application subsystem address which is used as source address fo=
r DMA payload
+        * transfer
+        */
+       u32 src;
+       /*
+        * Points to the start of the embedded data buffer associated with =
this descriptor.
+        * This address acts as the destination address for the DMA payload=
 transfer
+        */
+       u32 dest;
+       /* Complete length of the buffer in memory */
+       u16 length;
+       /* Control word for the DMA engine (e.g. for interrupt generation) =
*/
+       u16 ctrl;
+       /* Pointer to the next element of the chained list */
+       u32 next;
+       /*
+        * When working with 64bit application the high 32bit address shoul=
d be provided
+        * in the following variable (note: "PCIEW_CONF" register should be=
 configured accordingly)
+        */
+       u32 app_hi_32bit;
+};
+
+struct dma_desc_hdr {
+       struct co_list_hdr list_hdr;
+       struct dma_desc dma_desc;
+};
+
+enum {
+       DBG_ERROR_RECOVERABLE =3D 0,
+       DBG_ERROR_FATAL
+};
+
+/* Message structure for CFMs from Emb to App */
+struct cl_ipc_cfm_msg {
+       __le32 status;
+       __le32 dma_addr;
+       __le32 single_queue_idx;
+};
+
+/* Message structure for Debug messages from Emb to App */
+struct cl_ipc_dbg_msg {
+       char string[IPC_DBG_PARAM_SIZE];
+       __le32 pattern;
+};
+
+/*
+ * Message structure for MSGs from App to Emb.
+ * Actually a sub-structure will be used when filling the messages.
+ */
+struct cl_ipc_a2e_msg {
+       u32 dummy_word;
+       u32 msg[IPC_A2E_MSG_BUF_SIZE];
+};
+
+/* Struct for tensilica  backtrace */
+struct cl_ipc_backtrace_struct {
+       u32 pc[IPC_BACKTRACT_DEPTH];
+};
+
+/* Struct for tensilica  exception indication */
+struct cl_ipc_exception_struct {
+       u32 pattern;
+       u32 type;
+       u32 epc;
+       u32 excsave;
+       struct cl_ipc_backtrace_struct backtrace;
+};
+
+/*
+ * Can't use BITS_TO_LONGS since in firmware sizeof(long) =3D=3D 4 and in =
the host
+ * this might be different from compiler to compiler. We need our own macr=
o to
+ * match the firmware definition.
+ */
+#define CL_BITS_TO_U32S(nr) DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(u32))
+
+/*
+ * struct cl_ipc_enhanced_tim - ipc enhanced tim element
+ *
+ * This structure hold indication on the buffered traffic resembles the TI=
M element.
+ * This enhanced TIM holds more info on the buffered traffic, it indicate =
whether the
+ * traffic is associated with BA or singles and on which AC's.
+ *
+ * @tx_agg: indicate buffered tx-aggregated traffic per AC per BA session =
index
+ * @tx_single: indicate buffered tx-singles traffic per AC per station ind=
ex
+ * @rx: indicate buffered rx traffic per AC per station index
+ */
+struct cl_ipc_enhanced_tim {
+       /*
+        * Traffic indication map
+        * our driver push packets to the IPC queues (DRIVER_LAYER -> IPC_L=
AYER),
+        * on each push it also notify the IPC_LAYER for which queue it pus=
hed packets.
+        * this indication done by filling the bitmap.
+        *
+        * this is enhanced tim element because it is divided into AC and p=
acket type
+        * (aggregatable/non aggregatable).
+        * the regular tim element which exist in the beacon is divided by =
AID only
+        * which is less informative.
+        *
+        * TODO: add TIM element maintenance in the FW, this can be achieve=
d by the
+        * enhanced tim elements abstraction.
+        */
+       u32 tx_rx_agg[AC_MAX][CL_BITS_TO_U32S(IPC_TIM_AGG_SIZE)];
+       u32 tx_single[AC_MAX][CL_BITS_TO_U32S(FW_MAX_NUM_STA)];
+};
+
+struct cl_ipc_shared_env {
+       volatile struct cl_ipc_a2e_msg a2e_msg_buf;
+       /* Fields for MSGs sending from Emb to App */
+       volatile struct cl_ipc_e2a_msg e2a_msg_buf;
+       volatile struct dma_desc msg_dma_desc;
+       volatile __le32 e2a_msg_hostbuf_addr[IPC_E2A_MSG_BUF_CNT];
+       /* Fields for Debug MSGs sending from Emb to App */
+       volatile struct cl_ipc_dbg_msg dbg_buf;
+       volatile struct dma_desc dbg_dma_desc;
+       volatile __le32 dbg_hostbuf_addr[IPC_DBG_BUF_CNT];
+       volatile __le32 dbginfo_addr;
+       volatile __le32 dbginfo_size;
+       volatile __le32 pattern_addr;
+       volatile __le32 radarbuf_hostbuf[IPC_RADAR_BUF_CNT]; /* Buffers for=
 radar events */
+       /* Used to update host general debug data */
+       volatile struct dma_desc dbg_info_dma_desc;
+       /*
+        * The following members are associated ith the process of fetching
+        * "application txdesc" from the application and copy them to the
+        * internal embedded queues.
+        *
+        * @host_address_dma: dedicated dma descriptor to fetch the address=
es of
+        * "application txdesc" queues
+        * @write_dma_desc_pool: dedicated dma descriptor to fetch the "@tx=
desc_emb_wr_idx"
+        * index (dma for application txdesc metadata)
+        * @last_txdesc_dma_desc_pool: dedicated dma descriptor to fetch "a=
pplication txdescs"
+        * (dma for application txdesc)
+        * @txdesc_emb_wr_idx: indicate the last valid "application txdesc"=
 fetched
+        */
+       volatile struct dma_desc host_address_dma;
+       volatile struct dma_desc tx_power_tables_dma_desc;
+       volatile __le32 txdesc_emb_wr_idx[IPC_TX_QUEUE_CNT + CL_MAX_BA_PHYS=
ICAL_QUEUE_CNT];
+       volatile __le32 host_rxbuf_rd_idx[CL_RX_BUF_MAX];                  =
     /* For FW only */
+       volatile struct dma_desc rx_fw_hb_pool_dma_desc[HB_POOL_DMA_DESCS_N=
UM]; /* For FW only */
+       volatile struct dma_desc rxm_hb_pool_dma_desc[HB_POOL_DMA_DESCS_NUM=
];   /* For FW only */
+       volatile __le32 cfm_read_pointer; /* CFM read point. Updated by Hos=
t, Read by FW */
+       volatile __le16 phy_dev;
+       volatile u8 la_enable;
+       volatile u8 flags;
+       volatile __le16 max_retry;
+       volatile __le16 lft_limit_ms;
+       volatile __le16 bar_max_retry; /* Not used by driver */
+       volatile __le32 assert_pattern;
+       volatile __le16 assert_file_id;
+       volatile __le16 assert_line_num;
+       volatile __le32 assert_param;
+       volatile struct cl_ipc_enhanced_tim enhanced_tim;
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
+#define IPC_IRQ_A2E_TXDESC_AGG_MAP(ac)    (IPC_IRQ_A2E_TXDESC_FIRSTBIT + I=
PC_TXQ_CNT + (ac))
+#define IPC_IRQ_A2E_TXDESC_SINGLE_MAP(ac) (IPC_IRQ_A2E_TXDESC_FIRSTBIT + (=
ac))
+#define IPC_IRQ_A2E_RX_STA_MAP(ac)        (IPC_IRQ_A2E_RXREQ_FIRSTBIT + (a=
c))
+
+struct cl_ipc_e2a_irq {
+       u32 dbg;
+       u32 msg;
+       u32 rxdesc;
+       u32 txcfm;
+       u32 radar;
+       u32 txdesc_ind;
+       u32 tbtt;
+       u32 sync;
+       u32 all;
+};
+
+/*
+ * IRQs from emb to app
+ * This interrupt is used by the firmware to indicate the driver that it m=
ay proceed.
+ * The corresponding interrupt handler sets the CL_DEV_FW_SYNC flag in cl_=
hw->drv_flags.
+ * There is also the cl_hw->fw_sync_wq wait queue, on which we may sleep w=
hile waiting for
+ * the interrupt, if we are allowed to do so (e.g., when we are in a syste=
m call).
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
+       (IPC_IRQ_L2H_TXCFM |     \
+       IPC_IRQ_L2H_RXDESC |     \
+       IPC_IRQ_L2H_MSG |        \
+       IPC_IRQ_L2H_DBG |        \
+       IPC_IRQ_L2H_RADAR |      \
+       IPC_IRQ_L2H_TXDESC_IND | \
+       IPC_IRQ_L2H_TBTT |       \
+       IPC_IRQ_L2H_SYNC)
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
+       (IPC_IRQ_S2H_TXCFM |     \
+       IPC_IRQ_S2H_RXDESC |     \
+       IPC_IRQ_S2H_MSG |        \
+       IPC_IRQ_S2H_DBG |        \
+       IPC_IRQ_S2H_RADAR |      \
+       IPC_IRQ_S2H_TXDESC_IND | \
+       IPC_IRQ_S2H_TBTT |       \
+       IPC_IRQ_S2H_SYNC)
+
+#endif /* CL_IPC_SHARED_H */
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

