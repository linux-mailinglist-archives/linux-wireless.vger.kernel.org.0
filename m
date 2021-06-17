Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB60E3AB829
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbhFQQFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:20 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233537AbhFQQFE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfzO6U+SuMQ8ZO25tMx7J5OktJX44dm7ylH30Ug1D+S2iR0EmntgfPo6Evl81vLnGg2OQl5cJrFaWYWLA+PXwkAEBiYBF9OGqZog2L9ldjzBCGg2RJlEeYu17BZ0yL1dND4JxwHpQS9ml9Dspg4qubYuuZz6519gniuCGy9173McARjoPV0CUi7r7XWWvQyO80B3COe7oV+gmzbN2LAJQyexg+2QwpZGFdyPZPMmhFIHYfheJ1AVXDOH9lH4mdT7zWwVb0q9xUAg0lN7ObIZKBsrQfrjDIgg04oT6Fmao7JZQIVof15wC5/lXJPv4R5wdR2OX8fTXAGOLrMsIv4AYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYw6R8I8CovpGgb96OdTjpfYCV0NuI2/N35pdIblpPc=;
 b=L2dzJGGhBIEIVoiBddO8rNLYV/bSQ3FjdhbyLLoZ+tRb3SJ78KXh0FrgpCW2RWbHbrg8y/C5Os24hjVWqVI5sWPKWKQfseZlvlCugLQ2bQGL1so+PqkAjeRfjkrMlWLv1zO1YeYJ+V7u2ZLJSAjGhecDWzJsQlb6RV0EGbV45n9chhmNuHaXPIpKbIGO3cN4YMSVrTFg5pmLgvnGmPNTm/PDHwBEH/ABNIXrjN9YwuNABRiz9hJD7JhMY+dTSnNW76T7i418q91XtapmCLeIjkKwcgd+c0vtqQpFPrrOSU/EC7kRywffJ74Y2kJOUUjrr+stVIYoNJPDDdkiN/r2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYw6R8I8CovpGgb96OdTjpfYCV0NuI2/N35pdIblpPc=;
 b=cF8V5kBNB19I6La9kUrMi7pvU7onqguYY+hk5RHOHsiJbVxRdGjBGdHhs3J7dZeHp/e2CHtednsbrFXigZT8KyeTUbECZ4CjkQTeGSU8jdlckWjfEh/fLF3hWCSpvuQhlaDcamKDJleNiWm4pvIfYXXm5uL83qWu8BO3z/pBA0A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:53 +0000
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
Subject: [RFC v1 017/256] cl8k: add bus/pci/ipc.c
Date:   Thu, 17 Jun 2021 15:58:24 +0000
Message-Id: <20210617160223.160998-18-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 305a10b3-20a1-4198-0edd-08d931a95cd2
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499C9C5485AEED3AC76D4DBF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0ynlz/a8HgDVbGtRiX++GeE5+fY3CEYAXEtmxEyWj6/1xKVkQQanUssZc9IlXyLlxt/ShABj9sk0/3mqBz3M9SBzf70jHMQjGh0DfU/kXxxJeHeWwsQ5AIiVYy4qJ7o8AgF7RdXHOc2B5/Kv9Cy69Yc5qB5wcirTKcbR+3vwoKtl+N537LnrbagPa4wAHfk9ofYDutwxMPAs+YMrssPrf8nhE9LAFuGW+eIQMNgLgF3toonY1RwpJibaapW7mo4x+lJZ/pNTkQ5QINN6fzohbLwkFSoE34kqv98PGCcXE/JsrqzDPGVYUpIu9ap054xEZL9Vy39BrXSYjtSCvgpr0Lrn430JHh/M2AQD5sjww67Htz18/KSoYamoZn8G01uTklZWMXmA9SHeInpfKjDiHXbas+y/hWKnqP2S+am34LQ1YuJ0EsrYROIQ6yLu9T0nYrfq49f2jghzRdLzcBdBglM+0ZnFLwsrsUtKifSpyjNN4bW65SA9o7UcakLLaPLQP9R0x55bdHxJFzKkpRZmWYdswMfD64wjxxUEQlDjHKSJdJVoUuZ+qzGv/ctu/TuXpaJ9rXqp4mDoH7u1HwRcvW75Zkvby94gPrTvQXjyVUnCZoOhSey0XBDTHVT+EJEl+LtKr7cXUn5CSsOpGoIX+hJtMBDD2/3ViCIhUvZj1ORmwC8S38KgAGzUgX9riMxJ+bBceplJf/ojqumv+npvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/2eZcdhfb5SKzafMZzu3Pr9mgk9QpWl98MIcEEEFFViZRj9wuNn1vkVrSxU?=
 =?us-ascii?Q?obgRi+PWzllnf8ZDRC0fIrY6AbHihcGQuU0i6iMG/p4ld196vO+r4VB9x/WA?=
 =?us-ascii?Q?Cidvc17ifAHHNXceO+Gq0MuTAhbx1U9rJuK6jb/C8/oguD3nkxlkPFqB33Y3?=
 =?us-ascii?Q?dMxZncEs4d5bKHlo3m1UpqPhYlLOFpDISZYsmJjlX0mNTsOgUwR8nnUPE8/M?=
 =?us-ascii?Q?/lFtIETnTBROK5/E85TAfBR4Shy+Q6+Zdscc8boizZuQQMT0CkwisCVwnxi7?=
 =?us-ascii?Q?mjaQHkOYtHKlt6N5YpY/0z34n1M+NsT2H+chXywz5b/4o3BaeG1Z0p7rLBql?=
 =?us-ascii?Q?RpTcnyUnSiPLLEOs/Slz7hIPLj8ztxYm/MzHy6i7/GzNfm1WSripNrajmOnh?=
 =?us-ascii?Q?Nv+fZjzr25VaGAjEltx0tKpyuhq9pcZarSECUL8c/i49eN3KyIgZH30bvusu?=
 =?us-ascii?Q?FD2fiLZRI0lS9Vwra9OfyT94BmYKyd/VN0/xqFm60WLscsXuDADYlanT2d8Y?=
 =?us-ascii?Q?KZWV9JDIJ1nMK3YA01bochwu1/GEv+91c1hIMu4fujJf20zDdWPG5VJx/Uu9?=
 =?us-ascii?Q?ZzvwpD/Hknux8W2oG0F43ZpK6dqYgfJj4ApBdU7YzsUCZucBcgdtsRItnVyA?=
 =?us-ascii?Q?vt7P0son0YQv2+fDgh79q6w2yunlvWl7uyx0KBEuZa7jGGhxS9/B4xdcJ8J/?=
 =?us-ascii?Q?2dDj0CzJEeRpvKzo/2TgbOIiE6yWqBqkY5rXIdpkVsUw5Q8ug/3E6OIMbT7e?=
 =?us-ascii?Q?wSVNwHfVYeSij14YxndLJcuUrlfKt+TDG500AIE/vezNIFTkHWYmRTHNjxAO?=
 =?us-ascii?Q?hhUag4WaonRhrzgYH7CIYHqvNFZRSvcDTORh/4a72pX+w18h+6oGiJMJcB5E?=
 =?us-ascii?Q?d0hq9e5UZXyzGv7I3VtXSr5QQW/3TXsrYuEOdn9hJA5NRwXlOOYAEGO02Ggr?=
 =?us-ascii?Q?zTKcD7lytA00MwyKGz1FtxFHL7za5rodTYSKXT2FF9iUGGjB5H14angBbpVe?=
 =?us-ascii?Q?OiSYz9Wts4ueuXLl0r5d/vhpdK5eDZfN9AR98p0Xx2sggN1elTcHrZRpwBrI?=
 =?us-ascii?Q?g2nTplWLhnFinqeiNqmWIv9V3U2HZ8nA+4nnSEDZb39UIK6TndkXUr5CcqhG?=
 =?us-ascii?Q?75rY5zfpSRx5yn8k4DOOx3e+0+zh8qnkWKcu9Y1/o0kildgiZkzigqWdp35J?=
 =?us-ascii?Q?c1GE09jjV74Wqp2bz4lRRvWnzmgBMc2LnNNpiX/3eHLJ6lfzn2gNhbl1UPZ1?=
 =?us-ascii?Q?QvFaCj72tbj2bjUXhmHK1K+CZOMHdH1Y0tsCxmGn+2UNxD+sQ7muZQyVWN/N?=
 =?us-ascii?Q?1cm6ifzk3Grmb7Fvp0VosQr7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305a10b3-20a1-4198-0edd-08d931a95cd2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:52.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XtyZGwRNt7zFcAI9g/CwsdyXadRPGgQ7iKp+M/28draDq6SxX3xuPX5CHG/Lor2nAiwerGx94lfQD/LRMA0AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/bus/pci/ipc.c    | 1278 +++++++++++++++++
 1 file changed, 1278 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/ipc.c

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/ipc.c b/drivers/net/w=
ireless/celeno/cl8k/bus/pci/ipc.c
new file mode 100644
index 000000000000..c7ba5eb09be0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/ipc.c
@@ -0,0 +1,1278 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/dma-mapping.h>
+#include <linux/dmapool.h>
+
+#include "bus/pci/ipc.h"
+#include "rx/rx.h"
+#include "bus/pci/rx_pci.h"
+#include "tx/tx.h"
+#include "bus/pci/tx_pci.h"
+#include "bus/pci/irq.h"
+#include "fw/fw_dbg.h"
+#include "reg/reg_access.h"
+#include "reg/reg_ipc.h"
+#include "enhanced_tim.h"
+#include "fw/msg_rx.h"
+#include "dbgfile.h"
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+#define DMA_CFM_QUEUE_SIZE 1024
+#define DMA_CFM_TOTAL_SIZE (8 * sizeof(struct cl_ipc_cfm_msg) * DMA_CFM_QU=
EUE_SIZE)
+
+static void ipc_env_free(struct cl_hw *cl_hw)
+{
+       kfree(cl_hw->ipc_env);
+       cl_hw->ipc_env =3D NULL;
+}
+
+static void ring_indices_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       if (!ipc_env->ring_indices_elem)
+               return;
+
+       memset(ipc_env->ring_indices_elem->indices, 0, sizeof(struct cl_ipc=
_ring_indices));
+       ipc_env->ring_indices_elem->indices =3D NULL;
+       kfree(ipc_env->ring_indices_elem);
+       ipc_env->ring_indices_elem =3D NULL;
+}
+
+static void _txdesc_dealloc(struct cl_hw *cl_hw,
+                           struct txdesc *txdesc,
+                           __le32 dma_addr,
+                           u32 desc_num)
+{
+       dma_addr_t phys_dma_addr =3D le32_to_cpu(dma_addr);
+       u32 size =3D (desc_num * sizeof(struct txdesc));
+
+       if (size < PAGE_SIZE)
+               dma_pool_free(cl_hw->txdesc_pool, txdesc, phys_dma_addr);
+       else
+               dma_free_coherent(cl_hw->chip->dev, size, txdesc, phys_dma_=
addr);
+}
+
+static void txdesc_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_tx_queues *tx_queues =3D &cl_hw->ipc_env->tx_queues;
+       struct tx_queues_dma_addr *queues_dma_addr =3D tx_queues->queues_dm=
a_addr;
+       u32 i;
+
+       if (queues_dma_addr->bcmc) {
+               _txdesc_dealloc(cl_hw, tx_queues->ipc_txdesc_bcmc, queues_d=
ma_addr->bcmc,
+                               IPC_TXDESC_CNT_BCMC);
+               queues_dma_addr->bcmc =3D 0;
+       }
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               if (queues_dma_addr->single[i]) {
+                       _txdesc_dealloc(cl_hw, tx_queues->ipc_txdesc_single=
[i],
+                                       queues_dma_addr->single[i], IPC_TXD=
ESC_CNT_SINGLE);
+                       queues_dma_addr->single[i] =3D 0;
+               }
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               if (queues_dma_addr->agg[i]) {
+                       _txdesc_dealloc(cl_hw, tx_queues->ipc_txdesc_agg[i]=
,
+                                       queues_dma_addr->agg[i], cl_hw->max=
_agg_tx_q_size);
+                       queues_dma_addr->agg[i] =3D 0;
+               }
+
+       dma_pool_destroy(cl_hw->txdesc_pool);
+       cl_hw->txdesc_pool =3D NULL;
+}
+
+static void tx_queues_dealloc(struct cl_hw *cl_hw)
+{
+       u32 len =3D sizeof(struct tx_queues_dma_addr);
+       dma_addr_t phys_dma_addr =3D cl_hw->ipc_env->tx_queues.dma_addr;
+
+       if (!cl_hw->ipc_env->tx_queues.queues_dma_addr)
+               return;
+
+       dma_free_coherent(cl_hw->chip->dev, len,
+                         (void *)cl_hw->ipc_env->tx_queues.queues_dma_addr=
,
+                         phys_dma_addr);
+       cl_hw->ipc_env->tx_queues.queues_dma_addr =3D NULL;
+}
+
+static void rx_dealloc_skb(struct cl_hw *cl_hw, struct cl_rx_elem *rx_elem=
,
+                          u16 len)
+{
+       dma_unmap_single(cl_hw->chip->dev, rx_elem->dma_addr, len,
+                        DMA_FROM_DEVICE);
+       kfree_skb(rx_elem->skb);
+       rx_elem->skb =3D NULL;
+}
+
+static void _rx_dealloc_buff(struct cl_hw *cl_hw,
+                            u32 *rxbuf,
+                            __le32 dma_addr,
+                            u32 desc_num)
+{
+       dma_addr_t phys_dma_addr =3D le32_to_cpu(dma_addr);
+       u32 size =3D (desc_num * sizeof(u32));
+
+       dma_free_coherent(cl_hw->chip->dev, size, rxbuf, phys_dma_addr);
+}
+
+static void rx_dealloc_buff(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_host_rxbuf *rxbuf_rxm =3D &ipc_env->rx_hostbuf_array[=
CL_RX_BUF_RXM];
+       struct cl_ipc_host_rxbuf *rxbuf_fw =3D &ipc_env->rx_hostbuf_array[C=
L_RX_BUF_FW];
+
+       if (rxbuf_rxm->dma_payload_base_addr)
+               _rx_dealloc_buff(cl_hw,
+                                rxbuf_rxm->dma_payload_addr,
+                                rxbuf_rxm->dma_payload_base_addr,
+                                IPC_RXBUF_CNT_RXM);
+
+       if (rxbuf_fw->dma_payload_base_addr)
+               _rx_dealloc_buff(cl_hw,
+                                rxbuf_fw->dma_payload_addr,
+                                rxbuf_fw->dma_payload_base_addr,
+                                IPC_RXBUF_CNT_FW);
+}
+
+static void rx_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_rx_elem *rx_elem =3D cl_hw->rx_elems;
+       u16 rxbuf_size_rxm =3D cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_RXM=
];
+       u16 rxbuf_size_fw =3D cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_FW];
+       int i;
+
+       if (!cl_hw->rx_elems)
+               return;
+
+       for (i =3D 0; i < IPC_RXBUF_CNT_RXM; i++, rx_elem++)
+               if (rx_elem->skb && !rx_elem->passed)
+                       rx_dealloc_skb(cl_hw, rx_elem, rxbuf_size_rxm);
+
+       for (i =3D 0; i < IPC_RXBUF_CNT_FW; i++, rx_elem++)
+               if (rx_elem->skb && !rx_elem->passed)
+                       rx_dealloc_skb(cl_hw, rx_elem, rxbuf_size_fw);
+
+       kfree(cl_hw->rx_elems);
+       cl_hw->rx_elems =3D NULL;
+
+       rx_dealloc_buff(cl_hw);
+}
+
+static void msg_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_e2a_msg_elem *msg_elem;
+       int i;
+
+       if (!cl_hw->e2a_msg_elems || !cl_hw->e2a_msg_pool)
+               return;
+
+       for (i =3D 0, msg_elem =3D cl_hw->e2a_msg_elems;
+            i < IPC_E2A_MSG_BUF_CNT; i++, msg_elem++) {
+               if (msg_elem->msgbuf_ptr) {
+                       dma_pool_free(cl_hw->e2a_msg_pool, msg_elem->msgbuf=
_ptr,
+                                     msg_elem->dma_addr);
+                       msg_elem->msgbuf_ptr =3D NULL;
+               }
+       }
+
+       dma_pool_destroy(cl_hw->e2a_msg_pool);
+       cl_hw->e2a_msg_pool =3D NULL;
+
+       kfree(cl_hw->e2a_msg_elems);
+       cl_hw->e2a_msg_elems =3D NULL;
+}
+
+static void radar_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_radar_elem *radar_elem;
+       int i;
+
+       if (!cl_hw->radar_pool || !cl_hw->radar_elems)
+               return;
+
+       for (i =3D 0, radar_elem =3D cl_hw->radar_elems;
+            i < IPC_RADAR_BUF_CNT; i++, radar_elem++) {
+               if (radar_elem->radarbuf_ptr) {
+                       dma_pool_free(cl_hw->radar_pool, radar_elem->radarb=
uf_ptr,
+                                     radar_elem->dma_addr);
+                       radar_elem->radarbuf_ptr =3D NULL;
+               }
+       }
+
+       dma_pool_destroy(cl_hw->radar_pool);
+       cl_hw->radar_pool =3D NULL;
+
+       kfree(cl_hw->radar_elems);
+       cl_hw->radar_elems =3D NULL;
+}
+
+static void dbg_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_dbg_elem *dbg_elem;
+       int i;
+
+       if (!cl_hw->dbg_pool || !cl_hw->dbg_elems)
+               return;
+
+       for (i =3D 0, dbg_elem =3D cl_hw->dbg_elems;
+            i < IPC_DBG_BUF_CNT; i++, dbg_elem++) {
+               if (dbg_elem->dbgbuf_ptr) {
+                       dma_pool_free(cl_hw->dbg_pool, dbg_elem->dbgbuf_ptr=
,
+                                     dbg_elem->dma_addr);
+                       dbg_elem->dbgbuf_ptr =3D NULL;
+               }
+       }
+
+       dma_pool_destroy(cl_hw->dbg_pool);
+       cl_hw->dbg_pool =3D NULL;
+
+       kfree(cl_hw->dbg_elems);
+       cl_hw->dbg_elems =3D NULL;
+}
+
+static void cfm_dealloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       dma_free_coherent(cl_hw->chip->dev,
+                         DMA_CFM_TOTAL_SIZE,
+                         ipc_env->cfm_virt_base_addr,
+                         ipc_env->cfm_dma_base_addr);
+
+       ipc_env->cfm_dma_base_addr =3D 0;
+       ipc_env->cfm_virt_base_addr =3D NULL;
+}
+
+static void dbg_info_dealloc(struct cl_hw *cl_hw)
+{
+       if (!cl_hw->dbginfo.buf)
+               return;
+
+       dma_free_coherent(cl_hw->chip->dev,
+                         cl_hw->dbginfo.bufsz,
+                         cl_hw->dbginfo.buf,
+                         cl_hw->dbginfo.dma_addr);
+
+       cl_hw->dbginfo.buf =3D NULL;
+}
+
+static void ipc_elems_dealloc(struct cl_hw *cl_hw)
+{
+       ring_indices_dealloc(cl_hw);
+       txdesc_dealloc(cl_hw);
+       tx_queues_dealloc(cl_hw);
+       rx_dealloc(cl_hw);
+       msg_dealloc(cl_hw);
+       radar_dealloc(cl_hw);
+       dbg_dealloc(cl_hw);
+       cfm_dealloc(cl_hw);
+       dbg_info_dealloc(cl_hw);
+}
+
+static int ring_indices_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       ipc_env->ring_indices_elem =3D kzalloc(sizeof(*ipc_env->ring_indice=
s_elem), GFP_KERNEL);
+
+       if (!ipc_env->ring_indices_elem)
+               return -ENOMEM;
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               ipc_env->ring_indices_elem->indices =3D chip->ring_indices.=
params;
+               ipc_env->ring_indices_elem->dma_addr =3D chip->ring_indices=
.dma_addr;
+       } else {
+               ipc_env->ring_indices_elem->indices =3D chip->ring_indices.=
params + 1;
+               ipc_env->ring_indices_elem->dma_addr =3D
+                       (u32)chip->ring_indices.dma_addr + sizeof(struct cl=
_ipc_ring_indices);
+       }
+
+       memset(ipc_env->ring_indices_elem->indices, 0, sizeof(struct cl_ipc=
_ring_indices));
+
+       return 0;
+}
+
+static int tx_queues_alloc(struct cl_hw *cl_hw)
+{
+       struct tx_queues_dma_addr *buf =3D NULL;
+       u32 size =3D sizeof(struct tx_queues_dma_addr);
+       dma_addr_t phys_dma_addr;
+
+       buf =3D dma_alloc_coherent(cl_hw->chip->dev, size, &phys_dma_addr, =
GFP_KERNEL);
+
+       if (!buf)
+               return -ENOMEM;
+
+       cl_hw->ipc_env->tx_queues.queues_dma_addr =3D buf;
+       cl_hw->ipc_env->tx_queues.dma_addr =3D phys_dma_addr;
+
+       return 0;
+}
+
+static int __txdesc_alloc(struct cl_hw *cl_hw,
+                         struct txdesc **txdesc,
+                         u32 *dma_addr,
+                         u32 desc_num)
+{
+       dma_addr_t phys_dma_addr;
+       u32 size =3D (desc_num * sizeof(struct txdesc));
+
+       if (size < PAGE_SIZE) {
+               *txdesc =3D dma_pool_alloc(cl_hw->txdesc_pool, GFP_KERNEL, =
&phys_dma_addr);
+
+               if (!(*txdesc)) {
+                       cl_dbg_err(cl_hw, "dma_pool_alloc failed size=3D%d\=
n", size);
+                       return -ENOMEM;
+               }
+       } else {
+               *txdesc =3D dma_alloc_coherent(cl_hw->chip->dev, size, &phy=
s_dma_addr, GFP_KERNEL);
+
+               if (!(*txdesc)) {
+                       cl_dbg_err(cl_hw, "dma_alloc_coherent failed size=
=3D%d\n", size);
+                       return -ENOMEM;
+               }
+       }
+
+       *dma_addr =3D cpu_to_le32(phys_dma_addr);
+       memset(*txdesc, 0, size);
+
+       return 0;
+}
+
+static int _txdesc_alloc(struct cl_hw *cl_hw)
+{
+       /*
+        * Allocate ipc txdesc for each queue, map the base
+        * address to the DMA and set the queues size
+        */
+       struct cl_ipc_tx_queues *tx_queues =3D &cl_hw->ipc_env->tx_queues;
+       struct tx_queues_dma_addr *queues_dma_addr =3D tx_queues->queues_dm=
a_addr;
+       u32 i;
+       int ret =3D 0;
+
+       cl_hw->max_agg_tx_q_size =3D LMAC_TXDESC_AGG_Q_SIZE_MAX;
+
+       ret =3D __txdesc_alloc(cl_hw, &tx_queues->ipc_txdesc_bcmc,
+                            &queues_dma_addr->bcmc, IPC_TXDESC_CNT_BCMC);
+       if (ret)
+               return ret;
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++) {
+               ret =3D __txdesc_alloc(cl_hw, &tx_queues->ipc_txdesc_single=
[i],
+                                    &queues_dma_addr->single[i], IPC_TXDES=
C_CNT_SINGLE);
+               if (ret)
+                       return ret;
+       }
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+               ret =3D __txdesc_alloc(cl_hw, &tx_queues->ipc_txdesc_agg[i]=
,
+                                    &queues_dma_addr->agg[i], cl_hw->max_a=
gg_tx_q_size);
+               if (ret)
+                       return ret;
+       }
+
+       return 0;
+}
+
+static int txdesc_alloc(struct cl_hw *cl_hw)
+{
+       u32 pool_size =3D IPC_TXDESC_CNT_SINGLE * sizeof(struct txdesc);
+
+       cl_hw->txdesc_pool =3D dma_pool_create("cl_txdesc_pool", cl_hw->chi=
p->dev, pool_size,
+                                            cache_line_size(), 0);
+
+       if (!cl_hw->txdesc_pool) {
+               cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+               return -ENOMEM;
+       }
+
+       return _txdesc_alloc(cl_hw);
+}
+
+static int rx_skb_alloc(struct cl_hw *cl_hw)
+{
+       /*
+        * This function allocates Rx elements for DMA
+        * transfers and pushes the DMA address to FW.
+        */
+       struct cl_rx_elem *rx_elem =3D cl_hw->rx_elems;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       int i =3D 0;
+       u16 rxbuf_size_rxm =3D cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_RXM=
];
+       u16 rxbuf_size_fw =3D cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_FW];
+
+       /* Allocate and push RXM buffers */
+       for (i =3D 0; i < IPC_RXBUF_CNT_RXM; rx_elem++, i++) {
+               if (cl_ipc_rx_elem_alloc(cl_hw, rx_elem, rxbuf_size_rxm)) {
+                       cl_dbg_verbose(cl_hw, "RXM rx_elem allocation faile=
d !!!\n");
+                       return -ENOMEM;
+               }
+               cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_RXM);
+       }
+
+       /* Allocate and push FW buffers */
+       for (i =3D 0; i < IPC_RXBUF_CNT_FW; rx_elem++, i++) {
+               if (cl_ipc_rx_elem_alloc(cl_hw, rx_elem, rxbuf_size_fw)) {
+                       cl_dbg_verbose(cl_hw, "FW rx_elem allocation failed=
 !!!\n");
+                       return -ENOMEM;
+               }
+               cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_FW);
+       }
+
+       return 0;
+}
+
+static int _rx_buf_alloc(struct cl_hw *cl_hw, u32 **rxbuf, u32 *dma_addr, =
u32 desc_num)
+{
+       dma_addr_t phys_dma_addr;
+       u32 size =3D (desc_num * sizeof(u32));
+
+       *rxbuf =3D dma_alloc_coherent(cl_hw->chip->dev,
+                                   size,
+                                   &phys_dma_addr,
+                                   GFP_KERNEL);
+
+       if (!(*rxbuf))
+               return -ENOMEM;
+
+       *dma_addr =3D cpu_to_le32(phys_dma_addr);
+       memset(*rxbuf, 0, size);
+
+       return 0;
+}
+
+static int rx_buf_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_host_rxbuf *rxbuf_rxm =3D &ipc_env->rx_hostbuf_array[=
CL_RX_BUF_RXM];
+       struct cl_ipc_host_rxbuf *rxbuf_fw =3D &ipc_env->rx_hostbuf_array[C=
L_RX_BUF_FW];
+       int ret =3D 0;
+
+       rxbuf_rxm->ipc_host_rxdesc_ptr =3D ipc_env->ipc_host_rxdesc_rxm;
+       rxbuf_fw->ipc_host_rxdesc_ptr =3D ipc_env->ipc_host_rxdesc_fw;
+
+       /* Allocate RXM RX write/read indexes */
+       ret =3D _rx_buf_alloc(cl_hw,
+                           (u32 **)&rxbuf_rxm->dma_payload_addr,
+                           &rxbuf_rxm->dma_payload_base_addr,
+                           IPC_RXBUF_CNT_RXM);
+       if (ret)
+               return ret;
+
+       /* Allocate FW RX write/read indexes */
+       ret =3D _rx_buf_alloc(cl_hw,
+                           (u32 **)&rxbuf_fw->dma_payload_addr,
+                           &rxbuf_fw->dma_payload_base_addr,
+                           IPC_RXBUF_CNT_FW);
+       if (ret)
+               return ret;
+
+       return 0;
+}
+
+static int rx_alloc(struct cl_hw *cl_hw)
+{
+       u32 total_rx_elems =3D IPC_RXBUF_CNT_RXM + IPC_RXBUF_CNT_FW;
+       u32 alloc_size =3D total_rx_elems * sizeof(struct cl_rx_elem);
+       int ret =3D rx_buf_alloc(cl_hw);
+
+       if (ret)
+               return ret;
+
+       cl_hw->rx_elems =3D kzalloc(alloc_size, GFP_KERNEL);
+
+       if (!cl_hw->rx_elems)
+               return -ENOMEM;
+
+       return rx_skb_alloc(cl_hw);
+}
+
+static int _msg_alloc(struct cl_hw *cl_hw, struct cl_e2a_msg_elem *msg_ele=
m)
+{
+       dma_addr_t dma_addr;
+       struct cl_ipc_e2a_msg *msg;
+
+       /* Initialize the message pattern to NULL */
+       msg =3D dma_pool_alloc(cl_hw->e2a_msg_pool, GFP_KERNEL, &dma_addr);
+       if (!msg)
+               return -ENOMEM;
+
+       msg->pattern =3D 0;
+
+       /* Save the msg pointer (for deallocation) and the dma_addr */
+       msg_elem->msgbuf_ptr =3D msg;
+       msg_elem->dma_addr =3D dma_addr;
+
+       return 0;
+}
+
+static int msg_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_e2a_msg_elem *msg_elem;
+       u32 alloc_size =3D IPC_E2A_MSG_BUF_CNT * sizeof(struct cl_e2a_msg_e=
lem);
+       u32 i;
+
+       cl_hw->e2a_msg_elems =3D kzalloc(alloc_size, GFP_KERNEL);
+
+       if (!cl_hw->e2a_msg_elems)
+               return -ENOMEM;
+
+       cl_hw->e2a_msg_pool =3D dma_pool_create("dma_pool_msg",
+                                             cl_hw->chip->dev,
+                                             sizeof(struct cl_ipc_e2a_msg)=
,
+                                             cache_line_size(),
+                                             0);
+
+       if (!cl_hw->e2a_msg_pool) {
+               cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+               return -ENOMEM;
+       }
+
+       /* Initialize the msg buffers in the global IPC array. */
+       for (i =3D 0, msg_elem =3D cl_hw->e2a_msg_elems;
+            i < IPC_E2A_MSG_BUF_CNT; msg_elem++, i++) {
+               if (_msg_alloc(cl_hw, msg_elem)) {
+                       cl_dbg_verbose(cl_hw, "msg allocation failed !!!\n"=
);
+                       return -ENOMEM;
+               }
+
+               cl_ipc_msgbuf_push(ipc_env, (ptrdiff_t)msg_elem, msg_elem->=
dma_addr);
+       }
+
+       return 0;
+}
+
+static int _radar_alloc(struct cl_hw *cl_hw, struct cl_radar_elem *radar_e=
lem)
+{
+       dma_addr_t dma_addr;
+       struct cl_radar_pulse_array *radar;
+
+       /* Initialize the message pattern to NULL */
+       radar =3D dma_pool_alloc(cl_hw->radar_pool, GFP_KERNEL, &dma_addr);
+       if (!radar)
+               return -ENOMEM;
+
+       radar->cnt =3D 0;
+
+       /* Save the msg pointer (for deallocation) and the dma_addr */
+       radar_elem->radarbuf_ptr =3D radar;
+       radar_elem->dma_addr =3D dma_addr;
+
+       return 0;
+}
+
+static int radar_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_radar_elem *radar_elem;
+       u32 alloc_size =3D IPC_RADAR_BUF_CNT * sizeof(struct cl_radar_elem)=
;
+       u32 i;
+
+       cl_hw->radar_elems =3D kzalloc(alloc_size, GFP_KERNEL);
+
+       if (!cl_hw->radar_elems)
+               return -ENOMEM;
+
+       cl_hw->radar_pool =3D dma_pool_create("dma_pool_radar",
+                                           cl_hw->chip->dev,
+                                           sizeof(struct cl_radar_pulse_ar=
ray),
+                                           cache_line_size(),
+                                           0);
+
+       if (!cl_hw->radar_pool) {
+               cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+               return -ENOMEM;
+       }
+
+       /* Initialize the radar buffers in the global IPC array. */
+       for (i =3D 0, radar_elem =3D cl_hw->radar_elems;
+            i < IPC_RADAR_BUF_CNT; radar_elem++, i++) {
+               if (_radar_alloc(cl_hw, radar_elem)) {
+                       cl_dbg_verbose(cl_hw, "radar allocation failed !!!\=
n");
+                       return -ENOMEM;
+               }
+
+               cl_ipc_radarbuf_push(ipc_env, (ptrdiff_t)radar_elem, radar_=
elem->dma_addr);
+       }
+
+       return 0;
+}
+
+static int _dbg_alloc(struct cl_hw *cl_hw, struct cl_dbg_elem *dbg_elem)
+{
+       dma_addr_t dma_addr;
+       struct cl_ipc_dbg_msg *dbg_msg;
+
+       dbg_msg =3D dma_pool_alloc(cl_hw->dbg_pool, GFP_KERNEL, &dma_addr);
+       if (!dbg_msg)
+               return -ENOMEM;
+
+       dbg_msg->pattern =3D 0;
+
+       /* Save the Debug msg pointer (for deallocation) and the dma_addr *=
/
+       dbg_elem->dbgbuf_ptr =3D dbg_msg;
+       dbg_elem->dma_addr =3D dma_addr;
+
+       return 0;
+}
+
+static int dbg_alloc(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_dbg_elem *dbg_elem;
+       u32 alloc_size =3D IPC_DBG_BUF_CNT * sizeof(struct cl_dbg_elem);
+       u32 i;
+
+       cl_hw->dbg_elems =3D kzalloc(alloc_size, GFP_KERNEL);
+
+       if (!cl_hw->dbg_elems)
+               return -ENOMEM;
+
+       cl_hw->dbg_pool =3D dma_pool_create("dma_pool_dbg",
+                                         cl_hw->chip->dev,
+                                         sizeof(struct cl_ipc_dbg_msg),
+                                         cache_line_size(),
+                                         0);
+
+       if (!cl_hw->dbg_pool) {
+               cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+               return -ENOMEM;
+       }
+
+       /* Initialize the dbg buffers in the global IPC array. */
+       for (i =3D 0, dbg_elem =3D cl_hw->dbg_elems;
+            i < IPC_DBG_BUF_CNT; dbg_elem++, i++) {
+               if (_dbg_alloc(cl_hw, dbg_elem)) {
+                       cl_dbg_verbose(cl_hw, "dbgelem allocation failed !!=
!\n");
+                       return -ENOMEM;
+               }
+
+               cl_ipc_dbgbuf_push(ipc_env, (ptrdiff_t)dbg_elem, dbg_elem->=
dma_addr);
+       }
+
+       return 0;
+}
+
+static int cfm_alloc(struct cl_hw *cl_hw)
+{
+       dma_addr_t dma_addr;
+       u8 *host_virt_addr;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       host_virt_addr =3D dma_alloc_coherent(cl_hw->chip->dev,
+                                           DMA_CFM_TOTAL_SIZE,
+                                           &dma_addr,
+                                           GFP_KERNEL);
+
+       if (!host_virt_addr)
+               return -ENOMEM;
+
+       memset(host_virt_addr, 0, DMA_CFM_TOTAL_SIZE);
+       ipc_env->cfm_dma_base_addr =3D dma_addr;
+       ipc_env->cfm_virt_base_addr =3D host_virt_addr;
+
+       memset(ipc_env->cfm_virt_base_addr, 0, IPC_CFM_SIZE);
+
+       return 0;
+}
+
+static int _dbg_info_alloc(struct cl_hw *cl_hw)
+{
+       dma_addr_t dma_addr;
+       u32 len =3D sizeof(struct dbg_info);
+       struct dbg_info *buf =3D dma_alloc_coherent(cl_hw->chip->dev, len, =
&dma_addr, GFP_KERNEL);
+
+       if (!buf) {
+               cl_dbg_verbose(cl_hw, "buffer alloc of size %u failed\n", l=
en);
+               return -ENOMEM;
+       }
+
+       memset(buf, 0, sizeof(struct dbg_info));
+       buf->u.type =3D DBG_INFO_UNSET;
+
+       cl_hw->dbginfo.buf =3D buf;
+       cl_hw->dbginfo.dma_addr =3D dma_addr;
+       cl_hw->dbginfo.bufsz =3D len;
+
+       return 0;
+}
+
+static int dbg_info_alloc(struct cl_hw *cl_hw)
+{
+       /* Initialize the debug information buffer */
+       if (_dbg_info_alloc(cl_hw)) {
+               cl_dbg_verbose(cl_hw, "dbginfo allocation failed !!!\n");
+               return -ENOMEM;
+       }
+
+       cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+
+       return 0;
+}
+
+static int ipc_elems_alloc(struct cl_hw *cl_hw)
+{
+       /* Allocate all the elements required for communications with firmw=
are */
+       if (ring_indices_alloc(cl_hw))
+               goto out_err;
+
+       if (tx_queues_alloc(cl_hw))
+               goto out_err;
+
+       if (txdesc_alloc(cl_hw))
+               goto out_err;
+
+       if (rx_alloc(cl_hw))
+               goto out_err;
+
+       if (msg_alloc(cl_hw))
+               goto out_err;
+
+       if (radar_alloc(cl_hw))
+               goto out_err;
+
+       if (dbg_alloc(cl_hw))
+               goto out_err;
+
+       if (cfm_alloc(cl_hw))
+               goto out_err;
+
+       if (dbg_info_alloc(cl_hw))
+               goto out_err;
+
+       return 0;
+
+out_err:
+       ipc_elems_dealloc(cl_hw);
+       return -ENOMEM;
+}
+
+static u8 cl_ipc_dbgfile_handler(struct cl_hw *cl_hw, ptrdiff_t hostid)
+{
+       struct cl_dbg_elem *dbg_elem =3D (struct cl_dbg_elem *)hostid;
+       struct cl_ipc_dbg_msg *dbg_msg;
+       u8 ret =3D 0;
+
+       /* Retrieve the message structure */
+       dbg_msg =3D (struct cl_ipc_dbg_msg *)dbg_elem->dbgbuf_ptr;
+
+       if (!dbg_msg) {
+               ret =3D -1;
+               cl_dbg_err(cl_hw, "dbgbuf_ptr is NULL!!!!\n");
+               goto dbg_push;
+       }
+
+       /* Look for pattern which means that this hostbuf has been used for=
 a MSG */
+       if (le32_to_cpu(dbg_msg->pattern) !=3D IPC_DBG_VALID_PATTERN) {
+               ret =3D -1;
+               goto dbg_no_push;
+       }
+
+       /* Reset the msg element and re-use it */
+       dbg_msg->pattern =3D 0;
+
+       /* Display the firmware string */
+       cl_dbgfile_print_fw_str(cl_hw, dbg_msg->string, IPC_DBG_PARAM_SIZE)=
;
+
+dbg_push:
+       /* make sure memory is written before push to HW */
+       wmb();
+
+       /* Push back the buffer to the firmware */
+       cl_ipc_dbgbuf_push(cl_hw->ipc_env, (ptrdiff_t)dbg_elem, dbg_elem->d=
ma_addr);
+
+dbg_no_push:
+       return ret;
+}
+
+static void cl_ipc_dbgfile_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_hostbuf *dbg_array =3D ipc_env->dbg_hostbuf_array;
+       int dbg_handled =3D 0;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_dbgfile_tasklet_start(cl_hw->idx);
+#endif
+
+       while (!cl_ipc_dbgfile_handler(cl_hw, dbg_array[ipc_env->dbg_host_i=
dx].hostid))
+               dbg_handled++;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_dbgfile_tasklet_end(cl_hw->idx, dbg_handled);
+#endif
+
+       /* Enable the DBG interrupt */
+       if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+               cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.dbg);
+}
+
+static void ipc_tasklet_init(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       tasklet_init(&ipc_env->rxdesc_tasklet,
+                    cl_rx_pci_desc_tasklet,
+                    (unsigned long)cl_hw);
+       tasklet_init(&ipc_env->tx_single_cfm_tasklet,
+                    cl_tx_pci_single_cfm_tasklet,
+                    (unsigned long)cl_hw);
+       tasklet_init(&ipc_env->tx_agg_cfm_tasklet,
+                    cl_tx_pci_agg_cfm_tasklet,
+                    (unsigned long)cl_hw);
+       tasklet_init(&ipc_env->msg_tasklet,
+                    cl_msg_rx_tasklet,
+                    (unsigned long)cl_hw);
+       tasklet_init(&ipc_env->dbg_tasklet,
+                    cl_ipc_dbgfile_tasklet,
+                    (unsigned long)cl_hw);
+}
+
+static int ipc_env_init(struct cl_hw *cl_hw)
+{
+       u32 *dst;
+       u32 i;
+
+       BUILD_BUG_ON_NOT_POWER_OF_2(IPC_RXBUF_CNT_RXM);
+       BUILD_BUG_ON_NOT_POWER_OF_2(IPC_RXBUF_CNT_FW);
+
+       /* Allocate the IPC environment */
+       cl_hw->ipc_env =3D kzalloc(sizeof(*cl_hw->ipc_env), GFP_KERNEL);
+       if (!cl_hw->ipc_env)
+               return -ENOMEM;
+
+       dst =3D (u32 *)(cl_hw->ipc_env);
+
+       /*
+        * Reset the IPC Host environment.
+        * Perform the reset word per word because memset() does
+        * not correctly reset all (due to misaligned accesses)
+        */
+       for (i =3D 0; i < sizeof(*cl_hw->ipc_env); i +=3D sizeof(u32))
+               *dst++ =3D 0;
+
+       return 0;
+}
+
+static bool is_la_enabled(struct cl_chip *chip)
+{
+       s8 *ela_mode =3D chip->conf->ce_ela_mode;
+
+       return (!strcmp(ela_mode, "default") ||
+               !strncmp(ela_mode, "lcu_mac", 7) ||
+               !strncmp(ela_mode, "lcu_phy", 7));
+}
+
+static void ipc_shared_env_init(struct cl_hw *cl_hw)
+{
+       struct cl_chip *chip =3D cl_hw->chip;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_shared_env *shared_env =3D
+               (struct cl_ipc_shared_env *)(chip->pci_bar0_virt_addr + SHA=
RED_RAM_START_ADDR);
+       u32 *dst, i;
+
+       /* The shared environment of TCV1 is located after the shared envir=
onment of TCV0. */
+       if (cl_hw_is_tcv1(cl_hw))
+               shared_env++;
+
+       dst =3D (u32 *)(shared_env);
+
+       /* Reset the shared environment */
+       for (i =3D 0; i < sizeof(struct cl_ipc_shared_env); i +=3D sizeof(u=
32))
+               *dst++ =3D 0;
+
+       shared_env->la_enable =3D is_la_enabled(chip);
+       shared_env->max_retry =3D cl_hw->chip->conf->ce_production_mode ?
+               0 : cpu_to_le16(cl_hw->conf->ce_max_retry);
+       shared_env->lft_limit_ms =3D cpu_to_le16(CL_TX_LIFETIME_MS);
+       shared_env->phy_dev =3D cpu_to_le16(chip->conf->ci_phy_dev);
+
+       /* Initialize the shared environment pointer */
+       ipc_env->shared =3D shared_env;
+}
+
+static void ipc_e2a_irq_init(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_e2a_irq *ipc_e2a_irq =3D &cl_hw->ipc_e2a_irq;
+
+       if (cl_hw_is_tcv0(cl_hw)) {
+               ipc_e2a_irq->dbg =3D IPC_IRQ_L2H_DBG;
+               ipc_e2a_irq->msg =3D IPC_IRQ_L2H_MSG;
+               ipc_e2a_irq->rxdesc =3D IPC_IRQ_L2H_RXDESC;
+               ipc_e2a_irq->txcfm =3D IPC_IRQ_L2H_TXCFM;
+               ipc_e2a_irq->radar =3D IPC_IRQ_L2H_RADAR;
+               ipc_e2a_irq->txdesc_ind =3D IPC_IRQ_L2H_TXDESC_IND;
+               ipc_e2a_irq->tbtt =3D IPC_IRQ_L2H_TBTT;
+               ipc_e2a_irq->sync =3D IPC_IRQ_L2H_SYNC;
+               ipc_e2a_irq->all =3D IPC_IRQ_L2H_ALL;
+       } else {
+               ipc_e2a_irq->dbg =3D IPC_IRQ_S2H_DBG;
+               ipc_e2a_irq->msg =3D IPC_IRQ_S2H_MSG;
+               ipc_e2a_irq->rxdesc =3D IPC_IRQ_S2H_RXDESC;
+               ipc_e2a_irq->txcfm =3D IPC_IRQ_S2H_TXCFM;
+               ipc_e2a_irq->radar =3D IPC_IRQ_S2H_RADAR;
+               ipc_e2a_irq->txdesc_ind =3D IPC_IRQ_S2H_TXDESC_IND;
+               ipc_e2a_irq->tbtt =3D IPC_IRQ_S2H_TBTT;
+               ipc_e2a_irq->sync =3D IPC_IRQ_S2H_SYNC;
+               ipc_e2a_irq->all =3D IPC_IRQ_S2H_ALL;
+       }
+}
+
+int cl_ipc_init(struct cl_hw *cl_hw)
+{
+       /*
+        * This function initializes IPC interface by registering callbacks=
, setting
+        * shared memory area and calling IPC Init function.
+        * This function should be called only once during driver's lifetim=
e.
+        */
+       int ret =3D ipc_env_init(cl_hw);
+
+       if (ret)
+               return ret;
+
+       ipc_e2a_irq_init(cl_hw);
+       if (cl_hw_is_tcv0(cl_hw))
+               cl_hw->ipc_host2xmac_trigger_set =3D ipc_host_2_lmac_trigge=
r_set;
+       else
+               cl_hw->ipc_host2xmac_trigger_set =3D ipc_host_2_smac_trigge=
r_set;
+
+       ipc_shared_env_init(cl_hw);
+
+       ret =3D ipc_elems_alloc(cl_hw);
+       if (ret) {
+               ipc_env_free(cl_hw);
+               return ret;
+       }
+
+       ipc_tasklet_init(cl_hw);
+
+       return ret;
+}
+
+static void ring_indices_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       memset(ipc_env->ring_indices_elem->indices, 0,
+              sizeof(*ipc_env->ring_indices_elem->indices));
+
+       /* Reset host desc read idx follower */
+       ipc_env->host_rxdesc_read_idx[CL_RX_BUF_RXM] =3D 0;
+       ipc_env->host_rxdesc_read_idx[CL_RX_BUF_FW] =3D 0;
+}
+
+static void _txdesc_reset(struct txdesc **txdesc, u32 desc_num)
+{
+       u32 size =3D (desc_num * sizeof(struct txdesc));
+
+       memset(*txdesc, 0, size);
+}
+
+static void txdesc_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_tx_queues *tx_queues =3D &cl_hw->ipc_env->tx_queues;
+       u32 i;
+
+       _txdesc_reset(&tx_queues->ipc_txdesc_bcmc, IPC_TXDESC_CNT_BCMC);
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               _txdesc_reset(&tx_queues->ipc_txdesc_single[i], IPC_TXDESC_=
CNT_SINGLE);
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               _txdesc_reset(&tx_queues->ipc_txdesc_agg[i], cl_hw->max_agg=
_tx_q_size);
+}
+
+static void rx_skb_reset(struct cl_hw *cl_hw)
+{
+       /*
+        * This function allocates Rx elements for DMA
+        * transfers and pushes the DMA address to FW.
+        */
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_rx_elem *rx_elem =3D cl_hw->rx_elems;
+       int i =3D 0;
+
+       /* Push RXM buffers */
+       for (i =3D 0; i < IPC_RXBUF_CNT_RXM; rx_elem++, i++)
+               cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_RXM);
+
+       /* Push FW buffers */
+       for (i =3D 0; i < IPC_RXBUF_CNT_FW; rx_elem++, i++)
+               cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_FW);
+}
+
+static void _rx_buf_reset(u32 **rxbuf, u32 desc_num)
+{
+       u32 size =3D (desc_num * sizeof(u32));
+
+       memset(*rxbuf, 0, size);
+}
+
+static void rx_buf_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_host_rxbuf *rxbuf_rxm =3D &ipc_env->rx_hostbuf_array[=
CL_RX_BUF_RXM];
+       struct cl_ipc_host_rxbuf *rxbuf_fw =3D &ipc_env->rx_hostbuf_array[C=
L_RX_BUF_FW];
+
+       /* Reset RXM RX buffer */
+       _rx_buf_reset((u32 **)&rxbuf_rxm->dma_payload_addr,
+                     IPC_RXBUF_CNT_RXM);
+
+       /* Reset FW RX buffer */
+       _rx_buf_reset((u32 **)&rxbuf_fw->dma_payload_addr,
+                     IPC_RXBUF_CNT_FW);
+}
+
+static void rx_reset(struct cl_hw *cl_hw)
+{
+       rx_buf_reset(cl_hw);
+       rx_skb_reset(cl_hw);
+}
+
+static void msg_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_e2a_msg_elem *msg_elem;
+       u32 i;
+
+       ipc_env->e2a_msg_host_idx =3D 0;
+
+       /* Initialize the msg buffers in the global IPC array. */
+       for (i =3D 0, msg_elem =3D cl_hw->e2a_msg_elems;
+            i < IPC_E2A_MSG_BUF_CNT; msg_elem++, i++) {
+               msg_elem->msgbuf_ptr->pattern =3D 0;
+               cl_ipc_msgbuf_push(ipc_env, (ptrdiff_t)msg_elem, msg_elem->=
dma_addr);
+       }
+}
+
+static void radar_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_radar_elem *radar_elem;
+       u32 i;
+
+       ipc_env->radar_host_idx =3D 0;
+
+       /* Initialize the radar buffers in the global IPC array. */
+       for (i =3D 0, radar_elem =3D cl_hw->radar_elems;
+            i < IPC_RADAR_BUF_CNT; radar_elem++, i++) {
+               radar_elem->radarbuf_ptr->cnt =3D 0;
+               cl_ipc_radarbuf_push(ipc_env, (ptrdiff_t)radar_elem, radar_=
elem->dma_addr);
+       }
+}
+
+static void dbg_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_dbg_elem *dbg_elem;
+       u32 i;
+
+       ipc_env->dbg_host_idx =3D 0;
+
+       /* Initialize the dbg buffers in the global IPC array. */
+       for (i =3D 0, dbg_elem =3D cl_hw->dbg_elems;
+            i < IPC_DBG_BUF_CNT; dbg_elem++, i++) {
+               dbg_elem->dbgbuf_ptr->pattern =3D 0;
+               cl_ipc_dbgbuf_push(ipc_env, (ptrdiff_t)dbg_elem, dbg_elem->=
dma_addr);
+       }
+}
+
+static void cfm_reset(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       ipc_env->cfm_used_idx =3D 0;
+       memset(ipc_env->cfm_virt_base_addr, 0, IPC_CFM_SIZE);
+}
+
+static void dbg_info_reset(struct cl_hw *cl_hw)
+{
+       struct dbg_info *buf =3D cl_hw->dbginfo.buf;
+
+       memset(buf, 0, sizeof(struct dbg_info));
+       buf->u.type =3D DBG_INFO_UNSET;
+
+       cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+}
+
+static void ipc_elems_reset(struct cl_hw *cl_hw)
+{
+       ring_indices_reset(cl_hw);
+       txdesc_reset(cl_hw);
+       rx_reset(cl_hw);
+       msg_reset(cl_hw);
+       radar_reset(cl_hw);
+       dbg_reset(cl_hw);
+       cfm_reset(cl_hw);
+       dbg_info_reset(cl_hw);
+       cl_enhanced_tim_reset(cl_hw);
+}
+
+void cl_ipc_recovery(struct cl_hw *cl_hw)
+{
+       ipc_shared_env_init(cl_hw);
+       ipc_elems_reset(cl_hw);
+}
+
+void cl_ipc_reset(struct cl_hw *cl_hw)
+{
+       cl_hw->ipc_env->shared->cfm_read_pointer =3D 0;
+       cl_hw->ipc_env->cfm_used_idx =3D 0;
+}
+
+void cl_ipc_deinit(struct cl_hw *cl_hw)
+{
+       ipc_elems_dealloc(cl_hw);
+       ipc_env_free(cl_hw);
+}
+
+void cl_ipc_stop(struct cl_hw *cl_hw)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       tasklet_kill(&ipc_env->rxdesc_tasklet);
+       tasklet_kill(&ipc_env->tx_single_cfm_tasklet);
+       tasklet_kill(&ipc_env->tx_agg_cfm_tasklet);
+       tasklet_kill(&ipc_env->msg_tasklet);
+       tasklet_kill(&ipc_env->dbg_tasklet);
+}
+
+int cl_ipc_rx_elem_alloc(struct cl_hw *cl_hw, struct cl_rx_elem *rx_elem, =
u32 size)
+{
+       struct sk_buff *skb;
+       dma_addr_t dma_addr;
+       struct hw_rxhdr *rxhdr;
+
+       rx_elem->passed =3D 0;
+
+       skb =3D dev_alloc_skb(size);
+
+       if (unlikely(!skb)) {
+               cl_dbg_verbose(cl_hw, "skb alloc failed (size %u)\n", size)=
;
+               rx_elem->dma_addr =3D (dma_addr_t)0;
+               return -ENOMEM;
+       }
+
+       /* Reserve room for RX vector */
+       skb_reserve(skb, IPC_RXBUF_EXTRA_HEADROOM);
+
+       rxhdr =3D (struct hw_rxhdr *)skb->data;
+       rxhdr->pattern =3D 0;
+
+       dma_addr =3D dma_map_single(cl_hw->chip->dev, skb->data, size, DMA_=
FROM_DEVICE);
+
+       if (unlikely(dma_mapping_error(cl_hw->chip->dev, dma_addr))) {
+               cl_dbg_verbose(cl_hw, "dma_mapping_error\n");
+               kfree_skb(skb);
+               return -1;
+       }
+
+       rx_elem->skb =3D skb;
+       rx_elem->dma_addr =3D dma_addr;
+
+       cl_rx_skb_alloc_handler(skb);
+
+       return 0;
+}
+
+void cl_ipc_msgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid,=
 dma_addr_t hostbuf)
+{
+       /*
+        * Push a pre-allocated buffer descriptor for MSGs
+        * This function is only called at Init time since the MSGs will be=
 handled directly
+        * and buffer can be re-used as soon as the message is handled, no =
need to re-allocate
+        * new buffers in the meantime.
+        */
+       struct cl_ipc_shared_env *shared_env =3D ipc_env->shared;
+       u8 e2a_msg_host_idx =3D ipc_env->e2a_msg_host_idx;
+
+       /* Save the hostid and the hostbuf in global array */
+       ipc_env->e2a_msg_hostbuf_array[e2a_msg_host_idx].hostid =3D hostid;
+       ipc_env->e2a_msg_hostbuf_array[e2a_msg_host_idx].dma_addr =3D hostb=
uf;
+
+       /* Copy the hostbuf (DMA address) in the ipc shared memory */
+       shared_env->e2a_msg_hostbuf_addr[e2a_msg_host_idx] =3D cpu_to_le32(=
hostbuf);
+
+       /* Increment the array index */
+       ipc_env->e2a_msg_host_idx =3D (e2a_msg_host_idx + 1) % IPC_E2A_MSG_=
BUF_CNT;
+}
+
+void cl_ipc_rxbuf_push(struct cl_ipc_host_env *ipc_env, struct cl_rx_elem =
*rx_elem,
+                      u32 rxdesc_read_idx, u32 host_read_idx, enum rx_buf_=
type type)
+{
+       /*
+        * Push a pre-allocated buffer descriptor for Rx packet.
+        * This function is called to supply the firmware with new empty bu=
ffer.
+        */
+       struct cl_ipc_ring_indices *indices =3D ipc_env->ring_indices_elem-=
>indices;
+       struct cl_ipc_host_rxbuf *host_rxbuf =3D &ipc_env->rx_hostbuf_array=
[type];
+
+       /* Save the hostid and the hostbuf in global array */
+       host_rxbuf->ipc_host_rxdesc_ptr[host_read_idx] =3D (ptrdiff_t *)rx_=
elem;
+       host_rxbuf->dma_payload_addr[host_read_idx] =3D rx_elem->dma_addr;
+
+       /* Update rxbuff metadata */
+       indices->rxdesc_read_idx[type] =3D cpu_to_le32(rxdesc_read_idx + 1)=
;
+}
+
+void cl_ipc_radarbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hosti=
d, dma_addr_t hostbuf)
+{
+       /*
+        * Push a pre-allocated radar event buffer descriptor.
+        * This function should be called by the host IRQ handler to supply=
 the embedded
+        * side with new empty buffer.
+        */
+       struct cl_ipc_shared_env *shared_env =3D ipc_env->shared;
+       u8 radar_host_idx =3D ipc_env->radar_host_idx;
+
+       /* Save the hostid and the hostbuf in global array */
+       ipc_env->radar_hostbuf_array[radar_host_idx].hostid =3D hostid;
+       ipc_env->radar_hostbuf_array[radar_host_idx].dma_addr =3D hostbuf;
+
+       /* Copy the hostbuf (DMA address) in the ipc shared memory */
+       shared_env->radarbuf_hostbuf[radar_host_idx] =3D cpu_to_le32(hostbu=
f);
+
+       /* Increment the array index */
+       ipc_env->radar_host_idx =3D (radar_host_idx + 1) % IPC_RADAR_BUF_CN=
T;
+}
+
+void cl_ipc_dbgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid,=
 dma_addr_t hostbuf)
+{
+       /*
+        * Push a pre-allocated buffer descriptor for Debug messages.
+        * This function is only called at Init time since the Debug messag=
es will be
+        * handled directly and buffer can be re-used as soon as the messag=
e is handled,
+        * no need to re-allocate new buffers in the meantime.
+        */
+       struct cl_ipc_shared_env *shared_env =3D ipc_env->shared;
+       u8 dbg_host_idx =3D ipc_env->dbg_host_idx;
+
+       /* Save the hostid and the hostbuf in global array */
+       ipc_env->dbg_hostbuf_array[dbg_host_idx].hostid =3D hostid;
+       ipc_env->dbg_hostbuf_array[dbg_host_idx].dma_addr =3D hostbuf;
+
+       /* Copy the hostbuf (DMA address) in the ipc shared memory */
+       shared_env->dbg_hostbuf_addr[dbg_host_idx] =3D cpu_to_le32(hostbuf)=
;
+
+       /* Increment the array index */
+       ipc_env->dbg_host_idx =3D (dbg_host_idx + 1) % IPC_DBG_BUF_CNT;
+}
+
+void cl_ipc_dbginfobuf_push(struct cl_ipc_host_env *ipc_env, dma_addr_t in=
fobuf)
+{
+       /*Push the pre-allocated logic analyzer and debug information buffe=
r */
+       struct cl_ipc_shared_env *shared_env =3D ipc_env->shared;
+
+       /* Copy the hostbuf (DMA address) in the ipc shared memory */
+       shared_env->dbginfo_addr =3D cpu_to_le32(infobuf);
+       /* Copy the hostbuf size in the ipc shared memory */
+       shared_env->dbginfo_size =3D cpu_to_le32(DBG_DUMP_BUFFER_SIZE);
+}
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

