Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC4532961
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbiEXLj3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236852AbiEXLj0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:26 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50064.outbound.protection.outlook.com [40.107.5.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7BA98DDC7
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBOGImi9UM2vRNZz9Nqw4SUBzW8wtNtmjrGGhPjY2WlfQGK7DL4s+sK6zlA+5vzbsGNeUu+6sf8Ic1dWtN70l7D9ddpI/EnwUssWK8V6vR82QoGVpIlqUcNrtfVmKRHOH2we+62GpKFxD9dP/niv3GkPQ9gmZGsO0DQGLfYUoXBTfKSq2v6cIscXn1xPu0UzzWdcUVcw3hcnSHL1/fcbLYDTDhO3Sptshr1Od4OZJ21pCayrdDOWvLDDaCCyxdSm6FQynrXdLG9cCMDLRQGQ9ZIvxgmvAIQP4WZG3+SwsKFLh0ULfd6bPUFXTLlm81chvLy1YA3AUiZ7XS4q91TcfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhK8McDfVqVGnvitP3Yvl4/xJgXhlC7tw2eQuJnKCAI=;
 b=XzS7kZ7+7ehK1ngM/qsFR6Vj+gPOnnFFvQ+psgzhvlVuDoVhRabUrFy5PKG+xbQBCIlCu86EBkCkTpo/jkczpd8h+fAeoi6OTD9MmJ28H10ItWBvtb9tCvlAGDnIhRPlQVAIZQuSZU49Cbn35Sg5MkzD6oiTGqOspdplaftSpfWL1GW2tQXdeAcE6KtqmrcWzWHc1ZEF8nWk33vwtJEjpOrzshDe9eD5ivCB2EITLNma5CFKLj1/abwjB0VAcSMX9S//oG5I8hoeOoVCYv3knQKaAsYC9c/p3gJyPS9sGL4i5bY9pIQmpi+IajC/fglZehBkTju69jx4mqerOM8Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhK8McDfVqVGnvitP3Yvl4/xJgXhlC7tw2eQuJnKCAI=;
 b=TcTT9PkD6lyz282M3X28kli2Rthmvv+EolpvFnmEvoNPb6JKnH+mNMYYzX+D+zICO26RuNTHlrg+KqFXmpKCXsyjjNsTdO/zzI9qPwIWhYiypzmpFBeU+ioqC0PiP5CL8OIKnecb+PqJbmnFBp68CoOh0YpiHwzfKQCiqZBqfYI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:46 +0000
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
Subject: [RFC v2 48/96] cl8k: add pci.c
Date:   Tue, 24 May 2022 14:34:14 +0300
Message-Id: <20220524113502.1094459-49-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1e6c3c16-9c69-4be0-7c3f-08da3d79ea90
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571126AD0F5449E1E18EAB6F6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2q4Hd0kFuuBBAEyvUE2Za44EDfVpQz3DvOTMs+1a5Ww6k+LDrr4Apv9W4JH4h9ScevlRSBuzXkfpewP2pzytNnPWuIpsA9ve/uL1bSXvAzRWbjubT6SQIIbvEw2e0ftpwv1BH8/2KGcH8MhIX9Nku/D7tPUxbX6f3YRZZxg95PD6cYHsmHnSY/UvmVQhFiayZTlyxWlwQ6YTrgj+0bRaYUt4D7gi+st2TBZMZXbEVdSvuTPdA4wED9Loqx/WGW73HNIC11c+023blIZIwnsHVf9WESypLPTaJ1n/xZ/67NbR65CvzgaOfU7By+Ach9JDbfF8ODAbzflf5UEHJqdQNTZB3oL1tvVENhMHHAH5LRsYgBEw39ElDuozhkuR2X2Rj82zW5P8ylETuXT/AFg+PPChf+BvGRDpRP4bngPCnE+qa2OEaziPVMOIKgsbAvONnyfVeVS/ALXp3GYx2Ijk6XZluy1PUmDktPpAlOH5vsNCbwuxiYuauh9bGXUqubbE2AVVZonwXMDWQs1RJ/ZrBjrJX098uMa6qZg8N8vldr9ig3nyvqHujXMxOwlSxbu7XmA0KUrm2gDjZCYaLkAITS2kk+zpqhmaTT+yXClLyQOwtAM4X4W6UmOoGDKJPVNsTl/yIvok+4mtgcJaLBseVCjcUIi5hu81XTR7yyToRvZcfq7voLZg0n9gt87PvacRKdffmJP9bD7lJgkiV5cLcs5vqSObksYA14YIB89dUS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(30864003)(5660300002)(6486002)(26005)(32563001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+74waqGjs1SQfZEasvVJrSnC+2PSI2t3zxAA1YDHZRltGDEhfW6VxyxQr1mo?=
 =?us-ascii?Q?MWtAzeFjYpC6ctBnEQVFKGlCHXjjXkvW/NJoP7moCCmdphnV8Oq42zuKVipV?=
 =?us-ascii?Q?hum0qMLCF81bW971gMtxdBjGsz9Eb4+fM4LlewZ7Ockmy9Dvwo0REwiOlVqT?=
 =?us-ascii?Q?Bj04fzr91JDbrVrhfY/C+VNvta9QTU7BpOUX6eeAfKRKdbTuSLnlzY7PMFNl?=
 =?us-ascii?Q?PBriLH5zx4tcX4u1C6P8GnTRfl7klesty6Fjqt1Mm72zGKTUj74x3JVMAzbO?=
 =?us-ascii?Q?4lTeVSobqImbeajmR68AcDX9qeloWT0nJE08vcRQl9xiyEt5/ozHYfIPNSUX?=
 =?us-ascii?Q?ZwEMWDZWjqWt4J4PuBBw8gD9o9uYVB+j8pdtTKLcLJBN/DdMd/Nn4x7Jly+O?=
 =?us-ascii?Q?0M4fWyM9A/mzV9u4pClrb6a0ls831Lz4HUuESl21UA9TX4wBI3PjyqaTZsz/?=
 =?us-ascii?Q?rXJwelaW1+3rSnHJZQ3ssBi6WpsV9mX0nYZCF8tpqkMqYUwZFEmCraFUq2ss?=
 =?us-ascii?Q?GNbdrgdi9f1ejjsfqewUchETMVkVZiuc0owiU9aN7ryt4ebrdKL0vb4YHbkW?=
 =?us-ascii?Q?cSeQ0LnWZFzuZHOY9HTx0SDUV/ihVFq/SNTmYEy75/LWVXBAv1fdxKSS4fKe?=
 =?us-ascii?Q?glZ9kQirso5Iy9+PoAydAjtmJp+Rrh8oGKeVaOuj4ufE7yYjZCLo5Sq4Zm69?=
 =?us-ascii?Q?2UJApuo8iIJiVjDHuSmA7m/ueQUJEYG4JMNb23ftqegnBmmeu8vPPOgiKACv?=
 =?us-ascii?Q?Tcxr8koXFpKwoGCSThFB664rhxafJdTRUkfoVCTXq3IrIsLoFlC3ozax51MI?=
 =?us-ascii?Q?VPSpdMvx4t4jFkKI2C405itiHpMJfliZyzGswD3V08SZP4mbBztSK5kLTQDV?=
 =?us-ascii?Q?FfRkAXesmw5XvkA2AE0lZgsyqKT6rJSP1SWAHY2nXSPi9NgUCMthclQ/SG78?=
 =?us-ascii?Q?JvRlKCj6XDhqYFh2AMIVjZYIEasC2xRs3fpgY9jBPMJk4ZajScEatmtgr3hS?=
 =?us-ascii?Q?ms2xTqvOwgYQ1HDZxkl0tVcGgwpcGt2AWQ8YYPrIOzL8OrHWeTxab5v9molf?=
 =?us-ascii?Q?+Xstu2WY2gQMcph9Bl3zMfAdALbYypw6rboA4vzoqbWr/4gYQh6hrhBkLnty?=
 =?us-ascii?Q?h1KkthtXdhkbdXvPszIHTZXX92YBcXj3t1Bd1D5SEe1D1Yumnercv+9PgIxo?=
 =?us-ascii?Q?wlsC7gRV+wiEO3tK3o37eo0VnUDZzHgeLeOshj19sP+RGCJoKCxpEMkLX492?=
 =?us-ascii?Q?2y2wb/5qQ1rdB8PUUyHVOz3+ci2FRgjtxFmIqmkN92EGmh96+YzDDqBz2MaZ?=
 =?us-ascii?Q?gcl2B70k/Q0LFIVENUhe+yG0xNi1NbuRiLX6JfmPVrNUfBU43LB5ZC/rjs0a?=
 =?us-ascii?Q?h3/ZVQr5vr7ufzDW949qbrcHji4/n1UDtaDv2MM6VoIMQBrW3aRW7KiwU9va?=
 =?us-ascii?Q?udNVRbdwdp/waEhVBS0TsE+D5Hqx3FB9kcXYrxXrh6mGKQSutOdDDcmTnQe5?=
 =?us-ascii?Q?QeLI8gS1Jv+lwqikYEaFqBd/S4cp5K/eLHTgxYvJKZ0VYGRMVg113OtlNcjb?=
 =?us-ascii?Q?KXMm60c9s7pe1FSlpQZsT52WC0XGyh+Pi/XRGh8hreUF4PY1uEkh1jMxrMQa?=
 =?us-ascii?Q?jPd2xwT37f2Tr1wxTcqxDBjKxAWfrz0jEYYEcNCsZLUCdOQhbGe9RzldZxTn?=
 =?us-ascii?Q?2voaFpfmsDNoDpa41YcIyZ/FUaWpHgxIvPKsuQcVw/fr7QQq3VsVXH46BB6H?=
 =?us-ascii?Q?DGBancZ37mv0ngBPzNWVTs+pDhJKYXQ=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6c3c16-9c69-4be0-7c3f-08da3d79ea90
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:26.7644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2cIn/xZYcf7Z4qs9/okrP9UMgoFJtv+omTM44DqnZUeojexSCGO3dPDxERo8aCQGIbQy+LKZvNEyPmkLI7TYoA==
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
 drivers/net/wireless/celeno/cl8k/pci.c | 2468 ++++++++++++++++++++++++
 1 file changed, 2468 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/pci.c

diff --git a/drivers/net/wireless/celeno/cl8k/pci.c b/drivers/net/wireless/celeno/cl8k/pci.c
new file mode 100644
index 000000000000..dffbcc9478ee
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/pci.c
@@ -0,0 +1,2468 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/irq.h>
+
+#include "chip.h"
+#include "hw.h"
+#include "main.h"
+#include "ela.h"
+#include "debug.h"
+#include "reg/reg_defs.h"
+#include "enhanced_tim.h"
+#include "pci.h"
+
+#define DMA_CFM_QUEUE_SIZE 1024
+#define DMA_CFM_TOTAL_SIZE (8 * sizeof(struct cl_ipc_cfm_msg) * DMA_CFM_QUEUE_SIZE)
+
+static void cl_ipc_env_free(struct cl_hw *cl_hw)
+{
+	kfree(cl_hw->ipc_env);
+	cl_hw->ipc_env = NULL;
+}
+
+static void cl_ipc_ring_indices_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	if (!ipc_env->ring_indices_elem)
+		return;
+
+	memset(ipc_env->ring_indices_elem->indices, 0, sizeof(struct cl_ipc_ring_indices));
+	ipc_env->ring_indices_elem->indices = NULL;
+	kfree(ipc_env->ring_indices_elem);
+	ipc_env->ring_indices_elem = NULL;
+}
+
+static void _cl_ipc_txdesc_dealloc(struct cl_hw *cl_hw,
+				   struct txdesc *txdesc,
+				   __le32 dma_addr,
+				   u32 desc_num)
+{
+	dma_addr_t phys_dma_addr = le32_to_cpu(dma_addr);
+	u32 size = (desc_num * sizeof(struct txdesc));
+
+	if (size < PAGE_SIZE)
+		dma_pool_free(cl_hw->txdesc_pool, txdesc, phys_dma_addr);
+	else
+		dma_free_coherent(cl_hw->chip->dev, size, txdesc, phys_dma_addr);
+}
+
+static void cl_ipc_txdesc_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_tx_queues *tx_queues = &cl_hw->ipc_env->tx_queues;
+	struct tx_queues_dma_addr *queues_dma_addr = tx_queues->queues_dma_addr;
+	u32 i;
+
+	if (queues_dma_addr->bcmc) {
+		_cl_ipc_txdesc_dealloc(cl_hw, tx_queues->ipc_txdesc_bcmc,
+				       queues_dma_addr->bcmc, IPC_TXDESC_CNT_BCMC);
+		queues_dma_addr->bcmc = 0;
+	}
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++)
+		if (queues_dma_addr->single[i]) {
+			_cl_ipc_txdesc_dealloc(cl_hw, tx_queues->ipc_txdesc_single[i],
+					       queues_dma_addr->single[i],
+					       IPC_TXDESC_CNT_SINGLE);
+			queues_dma_addr->single[i] = 0;
+		}
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++)
+		if (queues_dma_addr->agg[i]) {
+			_cl_ipc_txdesc_dealloc(cl_hw, tx_queues->ipc_txdesc_agg[i],
+					       queues_dma_addr->agg[i],
+					       TXDESC_AGG_Q_SIZE_MAX);
+			queues_dma_addr->agg[i] = 0;
+		}
+
+	dma_pool_destroy(cl_hw->txdesc_pool);
+	cl_hw->txdesc_pool = NULL;
+}
+
+static void cl_ipc_tx_queues_dealloc(struct cl_hw *cl_hw)
+{
+	u32 len = sizeof(struct tx_queues_dma_addr);
+	dma_addr_t phys_dma_addr = cl_hw->ipc_env->tx_queues.dma_addr;
+
+	if (!cl_hw->ipc_env->tx_queues.queues_dma_addr)
+		return;
+
+	dma_free_coherent(cl_hw->chip->dev, len,
+			  (void *)cl_hw->ipc_env->tx_queues.queues_dma_addr,
+			  phys_dma_addr);
+	cl_hw->ipc_env->tx_queues.queues_dma_addr = NULL;
+}
+
+static void cl_ipc_rx_dealloc_skb(struct cl_hw *cl_hw, struct cl_rx_elem *rx_elem,
+				  u16 len)
+{
+	dma_unmap_single(cl_hw->chip->dev, rx_elem->dma_addr, len,
+			 DMA_FROM_DEVICE);
+	kfree_skb(rx_elem->skb);
+	rx_elem->skb = NULL;
+}
+
+static void _cl_ipc_rx_dealloc_buff(struct cl_hw *cl_hw,
+				    u32 *rxbuf,
+				    __le32 dma_addr,
+				    u32 desc_num)
+{
+	dma_addr_t phys_dma_addr = le32_to_cpu(dma_addr);
+	u32 size = (desc_num * sizeof(u32));
+
+	dma_free_coherent(cl_hw->chip->dev, size, rxbuf, phys_dma_addr);
+}
+
+static void cl_ipc_rx_dealloc_buff(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_host_rxbuf *rxbuf_rxm = &ipc_env->rx_hostbuf_array[CL_RX_BUF_RXM];
+	struct cl_ipc_host_rxbuf *rxbuf_fw = &ipc_env->rx_hostbuf_array[CL_RX_BUF_FW];
+
+	if (rxbuf_rxm->dma_payload_base_addr)
+		_cl_ipc_rx_dealloc_buff(cl_hw,
+					rxbuf_rxm->dma_payload_addr,
+					rxbuf_rxm->dma_payload_base_addr,
+					IPC_RXBUF_CNT_RXM);
+
+	if (rxbuf_fw->dma_payload_base_addr)
+		_cl_ipc_rx_dealloc_buff(cl_hw,
+					rxbuf_fw->dma_payload_addr,
+					rxbuf_fw->dma_payload_base_addr,
+					IPC_RXBUF_CNT_FW);
+}
+
+static void cl_ipc_rx_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_rx_elem *rx_elem = cl_hw->rx_elems;
+	u16 rxbuf_size_rxm = cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_RXM];
+	u16 rxbuf_size_fw = cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_FW];
+	int i;
+
+	if (!cl_hw->rx_elems)
+		return;
+
+	for (i = 0; i < IPC_RXBUF_CNT_RXM; i++, rx_elem++)
+		if (rx_elem->skb && !rx_elem->passed)
+			cl_ipc_rx_dealloc_skb(cl_hw, rx_elem, rxbuf_size_rxm);
+
+	for (i = 0; i < IPC_RXBUF_CNT_FW; i++, rx_elem++)
+		if (rx_elem->skb && !rx_elem->passed)
+			cl_ipc_rx_dealloc_skb(cl_hw, rx_elem, rxbuf_size_fw);
+
+	kfree(cl_hw->rx_elems);
+	cl_hw->rx_elems = NULL;
+
+	cl_ipc_rx_dealloc_buff(cl_hw);
+}
+
+static void cl_ipc_msg_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_e2a_msg_elem *msg_elem;
+	int i;
+
+	if (!cl_hw->e2a_msg_elems || !cl_hw->e2a_msg_pool)
+		return;
+
+	for (i = 0, msg_elem = cl_hw->e2a_msg_elems;
+	     i < IPC_E2A_MSG_BUF_CNT; i++, msg_elem++) {
+		if (msg_elem->msgbuf_ptr) {
+			dma_pool_free(cl_hw->e2a_msg_pool, msg_elem->msgbuf_ptr,
+				      msg_elem->dma_addr);
+			msg_elem->msgbuf_ptr = NULL;
+		}
+	}
+
+	dma_pool_destroy(cl_hw->e2a_msg_pool);
+	cl_hw->e2a_msg_pool = NULL;
+
+	kfree(cl_hw->e2a_msg_elems);
+	cl_hw->e2a_msg_elems = NULL;
+}
+
+static void cl_ipc_radar_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_radar_elem *radar_elem;
+	int i;
+
+	if (!cl_hw->radar_pool || !cl_hw->radar_elems)
+		return;
+
+	for (i = 0, radar_elem = cl_hw->radar_elems;
+	     i < IPC_RADAR_BUF_CNT; i++, radar_elem++) {
+		if (radar_elem->radarbuf_ptr) {
+			dma_pool_free(cl_hw->radar_pool, radar_elem->radarbuf_ptr,
+				      radar_elem->dma_addr);
+			radar_elem->radarbuf_ptr = NULL;
+		}
+	}
+
+	dma_pool_destroy(cl_hw->radar_pool);
+	cl_hw->radar_pool = NULL;
+
+	kfree(cl_hw->radar_elems);
+	cl_hw->radar_elems = NULL;
+}
+
+static void cl_ipc_dbg_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_dbg_elem *dbg_elem;
+	int i;
+
+	if (!cl_hw->dbg_pool || !cl_hw->dbg_elems)
+		return;
+
+	for (i = 0, dbg_elem = cl_hw->dbg_elems;
+	     i < IPC_DBG_BUF_CNT; i++, dbg_elem++) {
+		if (dbg_elem->dbgbuf_ptr) {
+			dma_pool_free(cl_hw->dbg_pool, dbg_elem->dbgbuf_ptr,
+				      dbg_elem->dma_addr);
+			dbg_elem->dbgbuf_ptr = NULL;
+		}
+	}
+
+	dma_pool_destroy(cl_hw->dbg_pool);
+	cl_hw->dbg_pool = NULL;
+
+	kfree(cl_hw->dbg_elems);
+	cl_hw->dbg_elems = NULL;
+}
+
+static void cl_ipc_cfm_dealloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	dma_free_coherent(cl_hw->chip->dev,
+			  DMA_CFM_TOTAL_SIZE,
+			  ipc_env->cfm_virt_base_addr,
+			  ipc_env->cfm_dma_base_addr);
+
+	ipc_env->cfm_dma_base_addr = 0;
+	ipc_env->cfm_virt_base_addr = NULL;
+}
+
+static void cl_ipc_dbg_info_dealloc(struct cl_hw *cl_hw)
+{
+	if (!cl_hw->dbginfo.buf)
+		return;
+
+	dma_free_coherent(cl_hw->chip->dev,
+			  cl_hw->dbginfo.bufsz,
+			  cl_hw->dbginfo.buf,
+			  cl_hw->dbginfo.dma_addr);
+
+	cl_hw->dbginfo.buf = NULL;
+}
+
+static void cl_ipc_elems_dealloc(struct cl_hw *cl_hw)
+{
+	cl_ipc_ring_indices_dealloc(cl_hw);
+	cl_ipc_txdesc_dealloc(cl_hw);
+	cl_ipc_tx_queues_dealloc(cl_hw);
+	cl_ipc_rx_dealloc(cl_hw);
+	cl_ipc_msg_dealloc(cl_hw);
+	cl_ipc_radar_dealloc(cl_hw);
+	cl_ipc_dbg_dealloc(cl_hw);
+	cl_ipc_cfm_dealloc(cl_hw);
+	cl_ipc_dbg_info_dealloc(cl_hw);
+}
+
+static int cl_ipc_ring_indices_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	ipc_env->ring_indices_elem = kzalloc(sizeof(*ipc_env->ring_indices_elem), GFP_KERNEL);
+
+	if (!ipc_env->ring_indices_elem)
+		return -ENOMEM;
+
+	if (cl_hw_is_tcv0(cl_hw)) {
+		ipc_env->ring_indices_elem->indices = chip->ring_indices.params;
+		ipc_env->ring_indices_elem->dma_addr = chip->ring_indices.dma_addr;
+	} else {
+		ipc_env->ring_indices_elem->indices = chip->ring_indices.params + 1;
+		ipc_env->ring_indices_elem->dma_addr =
+			(u32)chip->ring_indices.dma_addr + sizeof(struct cl_ipc_ring_indices);
+	}
+
+	memset(ipc_env->ring_indices_elem->indices, 0, sizeof(struct cl_ipc_ring_indices));
+
+	return 0;
+}
+
+static int cl_ipc_tx_queues_alloc(struct cl_hw *cl_hw)
+{
+	struct tx_queues_dma_addr *buf = NULL;
+	u32 size = sizeof(struct tx_queues_dma_addr);
+	dma_addr_t phys_dma_addr;
+
+	buf = dma_alloc_coherent(cl_hw->chip->dev, size, &phys_dma_addr, GFP_KERNEL);
+
+	if (!buf)
+		return -ENOMEM;
+
+	cl_hw->ipc_env->tx_queues.queues_dma_addr = buf;
+	cl_hw->ipc_env->tx_queues.dma_addr = phys_dma_addr;
+
+	return 0;
+}
+
+static int __cl_ipc_txdesc_alloc(struct cl_hw *cl_hw,
+				 struct txdesc **txdesc,
+				 __le32 *dma_addr,
+				 u32 desc_num)
+{
+	dma_addr_t phys_dma_addr;
+	u32 size = (desc_num * sizeof(struct txdesc));
+
+	if (size < PAGE_SIZE) {
+		*txdesc = dma_pool_alloc(cl_hw->txdesc_pool, GFP_KERNEL, &phys_dma_addr);
+
+		if (!(*txdesc)) {
+			cl_dbg_err(cl_hw, "dma_pool_alloc failed size=%d\n", size);
+			return -ENOMEM;
+		}
+	} else {
+		*txdesc = dma_alloc_coherent(cl_hw->chip->dev, size, &phys_dma_addr, GFP_KERNEL);
+
+		if (!(*txdesc)) {
+			cl_dbg_err(cl_hw, "dma_alloc_coherent failed size=%d\n", size);
+			return -ENOMEM;
+		}
+	}
+
+	*dma_addr = cpu_to_le32(phys_dma_addr);
+	memset(*txdesc, 0, size);
+
+	return 0;
+}
+
+static int _cl_ipc_txdesc_alloc(struct cl_hw *cl_hw)
+{
+	/*
+	 * Allocate ipc txdesc for each queue, map the base
+	 * address to the DMA and set the queues size
+	 */
+	struct cl_ipc_tx_queues *tx_queues = &cl_hw->ipc_env->tx_queues;
+	struct tx_queues_dma_addr *queues_dma_addr = tx_queues->queues_dma_addr;
+	u32 i;
+	int ret = 0;
+
+	ret = __cl_ipc_txdesc_alloc(cl_hw, &tx_queues->ipc_txdesc_bcmc,
+				    &queues_dma_addr->bcmc, IPC_TXDESC_CNT_BCMC);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++) {
+		ret = __cl_ipc_txdesc_alloc(cl_hw, &tx_queues->ipc_txdesc_single[i],
+					    &queues_dma_addr->single[i],
+					    IPC_TXDESC_CNT_SINGLE);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++) {
+		ret = __cl_ipc_txdesc_alloc(cl_hw, &tx_queues->ipc_txdesc_agg[i],
+					    &queues_dma_addr->agg[i],
+					    TXDESC_AGG_Q_SIZE_MAX);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int cl_ipc_txdesc_alloc(struct cl_hw *cl_hw)
+{
+	u32 pool_size = IPC_TXDESC_CNT_SINGLE * sizeof(struct txdesc);
+
+	cl_hw->txdesc_pool = dma_pool_create("cl_txdesc_pool", cl_hw->chip->dev,
+					     pool_size, cache_line_size(), 0);
+
+	if (!cl_hw->txdesc_pool) {
+		cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+		return -ENOMEM;
+	}
+
+	return _cl_ipc_txdesc_alloc(cl_hw);
+}
+
+static int cl_ipc_rx_skb_alloc(struct cl_hw *cl_hw)
+{
+	/*
+	 * This function allocates Rx elements for DMA
+	 * transfers and pushes the DMA address to FW.
+	 */
+	struct cl_rx_elem *rx_elem = cl_hw->rx_elems;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	int i = 0;
+	u16 rxbuf_size_rxm = cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_RXM];
+	u16 rxbuf_size_fw = cl_hw->conf->ci_ipc_rxbuf_size[CL_RX_BUF_FW];
+
+	/* Allocate and push RXM buffers */
+	for (i = 0; i < IPC_RXBUF_CNT_RXM; rx_elem++, i++) {
+		if (cl_ipc_rx_elem_alloc(cl_hw, rx_elem, rxbuf_size_rxm)) {
+			cl_dbg_verbose(cl_hw, "RXM rx_elem allocation failed !!!\n");
+			return -ENOMEM;
+		}
+		cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_RXM);
+	}
+
+	/* Allocate and push FW buffers */
+	for (i = 0; i < IPC_RXBUF_CNT_FW; rx_elem++, i++) {
+		if (cl_ipc_rx_elem_alloc(cl_hw, rx_elem, rxbuf_size_fw)) {
+			cl_dbg_verbose(cl_hw, "FW rx_elem allocation failed !!!\n");
+			return -ENOMEM;
+		}
+		cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_FW);
+	}
+
+	return 0;
+}
+
+static int _cl_ipc_rx_buf_alloc(struct cl_hw *cl_hw, u32 **rxbuf, __le32 *dma_addr, u32 desc_num)
+{
+	dma_addr_t phys_dma_addr;
+	u32 size = (desc_num * sizeof(u32));
+
+	*rxbuf = dma_alloc_coherent(cl_hw->chip->dev,
+				    size,
+				    &phys_dma_addr,
+				    GFP_KERNEL);
+
+	if (!(*rxbuf))
+		return -ENOMEM;
+
+	*dma_addr = cpu_to_le32(phys_dma_addr);
+	memset(*rxbuf, 0, size);
+
+	return 0;
+}
+
+static int cl_ipc_rx_buf_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_host_rxbuf *rxbuf_rxm = &ipc_env->rx_hostbuf_array[CL_RX_BUF_RXM];
+	struct cl_ipc_host_rxbuf *rxbuf_fw = &ipc_env->rx_hostbuf_array[CL_RX_BUF_FW];
+	int ret = 0;
+
+	rxbuf_rxm->ipc_host_rxdesc_ptr = ipc_env->ipc_host_rxdesc_rxm;
+	rxbuf_fw->ipc_host_rxdesc_ptr = ipc_env->ipc_host_rxdesc_fw;
+
+	/* Allocate RXM RX write/read indexes */
+	ret = _cl_ipc_rx_buf_alloc(cl_hw,
+				   (u32 **)&rxbuf_rxm->dma_payload_addr,
+				   &rxbuf_rxm->dma_payload_base_addr,
+				   IPC_RXBUF_CNT_RXM);
+	if (ret)
+		return ret;
+
+	/* Allocate FW RX write/read indexes */
+	ret = _cl_ipc_rx_buf_alloc(cl_hw,
+				   (u32 **)&rxbuf_fw->dma_payload_addr,
+				   &rxbuf_fw->dma_payload_base_addr,
+				   IPC_RXBUF_CNT_FW);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int cl_ipc_rx_alloc(struct cl_hw *cl_hw)
+{
+	u32 total_rx_elems = IPC_RXBUF_CNT_RXM + IPC_RXBUF_CNT_FW;
+	u32 alloc_size = total_rx_elems * sizeof(struct cl_rx_elem);
+	int ret = cl_ipc_rx_buf_alloc(cl_hw);
+
+	if (ret)
+		return ret;
+
+	cl_hw->rx_elems = kzalloc(alloc_size, GFP_KERNEL);
+
+	if (!cl_hw->rx_elems)
+		return -ENOMEM;
+
+	return cl_ipc_rx_skb_alloc(cl_hw);
+}
+
+static int _cl_ipc_msg_alloc(struct cl_hw *cl_hw, struct cl_e2a_msg_elem *msg_elem)
+{
+	dma_addr_t dma_addr;
+	struct cl_ipc_e2a_msg *msg;
+
+	/* Initialize the message pattern to NULL */
+	msg = dma_pool_alloc(cl_hw->e2a_msg_pool, GFP_KERNEL, &dma_addr);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->pattern = 0;
+
+	/* Save the msg pointer (for deallocation) and the dma_addr */
+	msg_elem->msgbuf_ptr = msg;
+	msg_elem->dma_addr = dma_addr;
+
+	return 0;
+}
+
+static int cl_ipc_msg_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_e2a_msg_elem *msg_elem;
+	u32 alloc_size = IPC_E2A_MSG_BUF_CNT * sizeof(struct cl_e2a_msg_elem);
+	u32 i;
+
+	cl_hw->e2a_msg_elems = kzalloc(alloc_size, GFP_KERNEL);
+
+	if (!cl_hw->e2a_msg_elems)
+		return -ENOMEM;
+
+	cl_hw->e2a_msg_pool = dma_pool_create("dma_pool_msg",
+					      cl_hw->chip->dev,
+					      sizeof(struct cl_ipc_e2a_msg),
+					      cache_line_size(),
+					      0);
+
+	if (!cl_hw->e2a_msg_pool) {
+		cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize the msg buffers in the global IPC array. */
+	for (i = 0, msg_elem = cl_hw->e2a_msg_elems;
+	     i < IPC_E2A_MSG_BUF_CNT; msg_elem++, i++) {
+		if (_cl_ipc_msg_alloc(cl_hw, msg_elem)) {
+			cl_dbg_verbose(cl_hw, "msg allocation failed !!!\n");
+			return -ENOMEM;
+		}
+
+		cl_ipc_msgbuf_push(ipc_env, (ptrdiff_t)msg_elem, msg_elem->dma_addr);
+	}
+
+	return 0;
+}
+
+static int _cl_ipc_radar_alloc(struct cl_hw *cl_hw, struct cl_radar_elem *radar_elem)
+{
+	dma_addr_t dma_addr;
+	struct cl_radar_pulse_array *radar;
+
+	/* Initialize the message pattern to NULL */
+	radar = dma_pool_alloc(cl_hw->radar_pool, GFP_KERNEL, &dma_addr);
+	if (!radar)
+		return -ENOMEM;
+
+	radar->cnt = 0;
+
+	/* Save the msg pointer (for deallocation) and the dma_addr */
+	radar_elem->radarbuf_ptr = radar;
+	radar_elem->dma_addr = dma_addr;
+
+	return 0;
+}
+
+static int cl_ipc_radar_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_radar_elem *radar_elem;
+	u32 alloc_size = IPC_RADAR_BUF_CNT * sizeof(struct cl_radar_elem);
+	u32 i;
+
+	cl_hw->radar_elems = kzalloc(alloc_size, GFP_KERNEL);
+
+	if (!cl_hw->radar_elems)
+		return -ENOMEM;
+
+	cl_hw->radar_pool = dma_pool_create("dma_pool_radar",
+					    cl_hw->chip->dev,
+					    sizeof(struct cl_radar_pulse_array),
+					    cache_line_size(),
+					    0);
+
+	if (!cl_hw->radar_pool) {
+		cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize the radar buffers in the global IPC array. */
+	for (i = 0, radar_elem = cl_hw->radar_elems;
+	     i < IPC_RADAR_BUF_CNT; radar_elem++, i++) {
+		if (_cl_ipc_radar_alloc(cl_hw, radar_elem)) {
+			cl_dbg_verbose(cl_hw, "radar allocation failed !!!\n");
+			return -ENOMEM;
+		}
+
+		cl_ipc_radarbuf_push(ipc_env, (ptrdiff_t)radar_elem, radar_elem->dma_addr);
+	}
+
+	return 0;
+}
+
+static int _cl_ipc_dbg_alloc(struct cl_hw *cl_hw, struct cl_dbg_elem *dbg_elem)
+{
+	dma_addr_t dma_addr;
+	struct cl_ipc_dbg_msg *dbg_msg;
+
+	dbg_msg = dma_pool_alloc(cl_hw->dbg_pool, GFP_KERNEL, &dma_addr);
+	if (!dbg_msg)
+		return -ENOMEM;
+
+	dbg_msg->pattern = 0;
+
+	/* Save the Debug msg pointer (for deallocation) and the dma_addr */
+	dbg_elem->dbgbuf_ptr = dbg_msg;
+	dbg_elem->dma_addr = dma_addr;
+
+	return 0;
+}
+
+static int cl_ipc_dbg_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_dbg_elem *dbg_elem;
+	u32 alloc_size = IPC_DBG_BUF_CNT * sizeof(struct cl_dbg_elem);
+	u32 i;
+
+	cl_hw->dbg_elems = kzalloc(alloc_size, GFP_KERNEL);
+
+	if (!cl_hw->dbg_elems)
+		return -ENOMEM;
+
+	cl_hw->dbg_pool = dma_pool_create("dma_pool_dbg",
+					  cl_hw->chip->dev,
+					  sizeof(struct cl_ipc_dbg_msg),
+					  cache_line_size(),
+					  0);
+
+	if (!cl_hw->dbg_pool) {
+		cl_dbg_verbose(cl_hw, "dma_pool_create failed !!!\n");
+		return -ENOMEM;
+	}
+
+	/* Initialize the dbg buffers in the global IPC array. */
+	for (i = 0, dbg_elem = cl_hw->dbg_elems;
+	     i < IPC_DBG_BUF_CNT; dbg_elem++, i++) {
+		if (_cl_ipc_dbg_alloc(cl_hw, dbg_elem)) {
+			cl_dbg_verbose(cl_hw, "dbgelem allocation failed !!!\n");
+			return -ENOMEM;
+		}
+
+		cl_ipc_dbgbuf_push(ipc_env, (ptrdiff_t)dbg_elem, dbg_elem->dma_addr);
+	}
+
+	return 0;
+}
+
+static int cl_ipc_cfm_alloc(struct cl_hw *cl_hw)
+{
+	dma_addr_t dma_addr;
+	u8 *host_virt_addr;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	host_virt_addr = dma_alloc_coherent(cl_hw->chip->dev,
+					    DMA_CFM_TOTAL_SIZE,
+					    &dma_addr,
+					    GFP_KERNEL);
+
+	if (!host_virt_addr)
+		return -ENOMEM;
+
+	memset(host_virt_addr, 0, DMA_CFM_TOTAL_SIZE);
+	ipc_env->cfm_dma_base_addr = dma_addr;
+	ipc_env->cfm_virt_base_addr = host_virt_addr;
+
+	memset(ipc_env->cfm_virt_base_addr, 0, IPC_CFM_SIZE);
+
+	return 0;
+}
+
+static int _cl_ipc_dbg_info_alloc(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct dbg_info *buf;
+	dma_addr_t dma_addr;
+	u32 len = sizeof(struct dbg_info);
+
+	if (!chip->conf->ci_la_mirror_en)
+		len -= sizeof_field(struct dbg_dump_info, la_mem);
+
+	buf = dma_alloc_coherent(chip->dev, len, &dma_addr, GFP_KERNEL);
+
+	if (!buf) {
+		cl_dbg_verbose(cl_hw, "buffer alloc of size %u failed\n", len);
+		return -ENOMEM;
+	}
+
+	memset(buf, 0, len);
+	buf->u.type = DBG_INFO_UNSET;
+
+	cl_hw->dbginfo.buf = buf;
+	cl_hw->dbginfo.dma_addr = dma_addr;
+	cl_hw->dbginfo.bufsz = len;
+
+	return 0;
+}
+
+static int cl_ipc_dbg_info_alloc(struct cl_hw *cl_hw)
+{
+	/* Initialize the debug information buffer */
+	if (_cl_ipc_dbg_info_alloc(cl_hw)) {
+		cl_dbg_verbose(cl_hw, "dbginfo allocation failed !!!\n");
+		return -ENOMEM;
+	}
+
+	cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+
+	return 0;
+}
+
+static int cl_ipc_elems_alloc(struct cl_hw *cl_hw)
+{
+	/* Allocate all the elements required for communications with firmware */
+	if (cl_ipc_ring_indices_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_tx_queues_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_txdesc_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_rx_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_msg_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_radar_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_dbg_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_cfm_alloc(cl_hw))
+		goto out_err;
+
+	if (cl_ipc_dbg_info_alloc(cl_hw))
+		goto out_err;
+
+	return 0;
+
+out_err:
+	cl_ipc_elems_dealloc(cl_hw);
+	return -ENOMEM;
+}
+
+static u8 cl_ipc_dbgfile_handler(struct cl_hw *cl_hw, ptrdiff_t hostid)
+{
+	struct cl_dbg_elem *dbg_elem = (struct cl_dbg_elem *)hostid;
+	struct cl_ipc_dbg_msg *dbg_msg;
+	u8 ret = 0;
+
+	/* Retrieve the message structure */
+	dbg_msg = (struct cl_ipc_dbg_msg *)dbg_elem->dbgbuf_ptr;
+
+	if (!dbg_msg) {
+		ret = -1;
+		cl_dbg_err(cl_hw, "dbgbuf_ptr is NULL!!!!\n");
+		goto dbg_push;
+	}
+
+	/* Look for pattern which means that this hostbuf has been used for a MSG */
+	if (le32_to_cpu(dbg_msg->pattern) != IPC_DBG_VALID_PATTERN) {
+		ret = -1;
+		goto dbg_no_push;
+	}
+
+	/* Reset the msg element and re-use it */
+	dbg_msg->pattern = 0;
+
+	/* Display the firmware string */
+	cl_dbgfile_print_fw_str(cl_hw, dbg_msg->string, IPC_DBG_PARAM_SIZE);
+
+dbg_push:
+	/* make sure memory is written before push to HW */
+	wmb();
+
+	/* Push back the buffer to the firmware */
+	cl_ipc_dbgbuf_push(cl_hw->ipc_env, (ptrdiff_t)dbg_elem, dbg_elem->dma_addr);
+
+dbg_no_push:
+	return ret;
+}
+
+static void cl_ipc_dbgfile_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_hostbuf *dbg_array = ipc_env->dbg_hostbuf_array;
+	int dbg_handled = 0;
+
+	while (!cl_ipc_dbgfile_handler(cl_hw, dbg_array[ipc_env->dbg_host_idx].hostid))
+		dbg_handled++;
+
+	/* Enable the DBG interrupt */
+	if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+		cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.dbg);
+}
+
+static void cl_ipc_tasklet_init(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	tasklet_init(&ipc_env->rxdesc_tasklet,
+		     cl_rx_pci_desc_tasklet,
+		     (unsigned long)cl_hw);
+	tasklet_init(&ipc_env->tx_single_cfm_tasklet,
+		     cl_tx_pci_single_cfm_tasklet,
+		     (unsigned long)cl_hw);
+	tasklet_init(&ipc_env->tx_agg_cfm_tasklet,
+		     cl_tx_pci_agg_cfm_tasklet,
+		     (unsigned long)cl_hw);
+	tasklet_init(&ipc_env->msg_tasklet,
+		     cl_msg_rx_tasklet,
+		     (unsigned long)cl_hw);
+	tasklet_init(&ipc_env->dbg_tasklet,
+		     cl_ipc_dbgfile_tasklet,
+		     (unsigned long)cl_hw);
+	tasklet_init(&ipc_env->bcn_tasklet,
+		     cl_tx_bcns_tasklet,
+		     (unsigned long)cl_hw);
+}
+
+static int cl_ipc_env_init(struct cl_hw *cl_hw)
+{
+	u32 *dst;
+	u32 i;
+
+	BUILD_BUG_ON_NOT_POWER_OF_2(IPC_RXBUF_CNT_RXM);
+	BUILD_BUG_ON_NOT_POWER_OF_2(IPC_RXBUF_CNT_FW);
+
+	/* Allocate the IPC environment */
+	cl_hw->ipc_env = kzalloc(sizeof(*cl_hw->ipc_env), GFP_KERNEL);
+
+	if (!cl_hw->ipc_env)
+		return -ENOMEM;
+
+	dst = (u32 *)(cl_hw->ipc_env);
+
+	/*
+	 * Reset the IPC Host environment.
+	 * Perform the reset word per word because memset() does
+	 * not correctly reset all (due to misaligned accesses)
+	 */
+	for (i = 0; i < sizeof(struct cl_ipc_host_env); i += sizeof(u32))
+		*dst++ = 0;
+
+	return 0;
+}
+
+static bool cl_pci_is_la_enabled(struct cl_chip *chip)
+{
+	s8 *ela_mode = chip->conf->ce_ela_mode;
+
+	return (!strcmp(ela_mode, "default") ||
+		!strncmp(ela_mode, "lcu_mac", 7) ||
+		!strncmp(ela_mode, "lcu_phy", 7));
+}
+
+static void cl_ipc_shared_env_init(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_shared_env __iomem *shared_env =
+		(struct cl_ipc_shared_env __iomem *)(chip->pci_bar0_virt_addr +
+					     SHARED_RAM_START_ADDR);
+	u32 i;
+	u16 max_retry = cl_hw_is_prod_or_listener(cl_hw) ?
+			0 : cl_hw->conf->ce_max_retry;
+	bool first_tcv = cl_hw_is_first_tcv(cl_hw) &&
+			 !cl_recovery_in_progress(cl_hw);
+	void __iomem *dst;
+
+	/* The shared environment of TCV1 is located after the shared environment of TCV0. */
+	if (cl_hw_is_tcv1(cl_hw))
+		shared_env++;
+
+	dst = (void __iomem *)(shared_env);
+
+	/* Reset the shared environment */
+	for (i = 0; i < sizeof(struct cl_ipc_shared_env); i += sizeof(u32),
+	     dst += sizeof(u32))
+		iowrite32(0, dst);
+
+	iowrite8(cl_pci_is_la_enabled(chip), (void __iomem *)&shared_env->la_enable);
+	iowrite16(max_retry, (void __iomem *)&shared_env->max_retry);
+	iowrite16(CL_TX_LIFETIME_MS, (void __iomem *)&shared_env->lft_limit_ms);
+	iowrite16(chip->conf->ci_phy_dev, (void __iomem *)&shared_env->phy_dev);
+	iowrite8(first_tcv, (void __iomem *)&shared_env->first_tcv);
+	iowrite8(chip->conf->ci_la_mirror_en,
+		 (void __iomem *)&shared_env->la_mirror_enable);
+
+	/* Initialize the shared environment pointer */
+	ipc_env->shared = shared_env;
+}
+
+static void cl_ipc_e2a_irq_init(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_e2a_irq *ipc_e2a_irq = &cl_hw->ipc_e2a_irq;
+
+	if (cl_hw_is_tcv0(cl_hw)) {
+		ipc_e2a_irq->dbg = IPC_IRQ_L2H_DBG;
+		ipc_e2a_irq->msg = IPC_IRQ_L2H_MSG;
+		ipc_e2a_irq->rxdesc = IPC_IRQ_L2H_RXDESC;
+		ipc_e2a_irq->txcfm = IPC_IRQ_L2H_TXCFM;
+		ipc_e2a_irq->radar = IPC_IRQ_L2H_RADAR;
+		ipc_e2a_irq->txdesc_ind = IPC_IRQ_L2H_TXDESC_IND;
+		ipc_e2a_irq->tbtt = IPC_IRQ_L2H_TBTT;
+		ipc_e2a_irq->sync = IPC_IRQ_L2H_SYNC;
+		ipc_e2a_irq->all = IPC_IRQ_L2H_ALL;
+	} else {
+		ipc_e2a_irq->dbg = IPC_IRQ_S2H_DBG;
+		ipc_e2a_irq->msg = IPC_IRQ_S2H_MSG;
+		ipc_e2a_irq->rxdesc = IPC_IRQ_S2H_RXDESC;
+		ipc_e2a_irq->txcfm = IPC_IRQ_S2H_TXCFM;
+		ipc_e2a_irq->radar = IPC_IRQ_S2H_RADAR;
+		ipc_e2a_irq->txdesc_ind = IPC_IRQ_S2H_TXDESC_IND;
+		ipc_e2a_irq->tbtt = IPC_IRQ_S2H_TBTT;
+		ipc_e2a_irq->sync = IPC_IRQ_S2H_SYNC;
+		ipc_e2a_irq->all = IPC_IRQ_S2H_ALL;
+	}
+}
+
+int cl_ipc_init(struct cl_hw *cl_hw)
+{
+	/*
+	 * This function initializes IPC interface by registering callbacks, setting
+	 * shared memory area and calling IPC Init function.
+	 * This function should be called only once during driver's lifetime.
+	 */
+	int ret = cl_ipc_env_init(cl_hw);
+
+	if (ret)
+		return ret;
+
+	cl_ipc_e2a_irq_init(cl_hw);
+	if (cl_hw_is_tcv0(cl_hw))
+		cl_hw->ipc_host2xmac_trigger_set = ipc_host_2_lmac_trigger_set;
+	else
+		cl_hw->ipc_host2xmac_trigger_set = ipc_host_2_smac_trigger_set;
+
+	cl_ipc_shared_env_init(cl_hw);
+
+	ret = cl_ipc_elems_alloc(cl_hw);
+	if (ret) {
+		cl_ipc_env_free(cl_hw);
+		return ret;
+	}
+
+	cl_ipc_tasklet_init(cl_hw);
+
+	return ret;
+}
+
+static void cl_ipc_ring_indices_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	memset(ipc_env->ring_indices_elem->indices, 0, sizeof(struct cl_ipc_ring_indices));
+
+	/* Reset host desc read idx follower */
+	ipc_env->host_rxdesc_read_idx[CL_RX_BUF_RXM] = 0;
+	ipc_env->host_rxdesc_read_idx[CL_RX_BUF_FW] = 0;
+}
+
+static void _cl_ipc_txdesc_reset(struct txdesc **txdesc, u32 desc_num)
+{
+	u32 size = (desc_num * sizeof(struct txdesc));
+
+	memset(*txdesc, 0, size);
+}
+
+static void cl_ipc_txdesc_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_tx_queues *tx_queues = &cl_hw->ipc_env->tx_queues;
+	u32 i;
+
+	_cl_ipc_txdesc_reset(&tx_queues->ipc_txdesc_bcmc, IPC_TXDESC_CNT_BCMC);
+
+	for (i = 0; i < MAX_SINGLE_QUEUES; i++)
+		_cl_ipc_txdesc_reset(&tx_queues->ipc_txdesc_single[i], IPC_TXDESC_CNT_SINGLE);
+
+	for (i = 0; i < IPC_MAX_BA_SESSIONS; i++)
+		_cl_ipc_txdesc_reset(&tx_queues->ipc_txdesc_agg[i], TXDESC_AGG_Q_SIZE_MAX);
+}
+
+static void cl_ipc_rx_skb_reset(struct cl_hw *cl_hw)
+{
+	/*
+	 * This function allocates Rx elements for DMA
+	 * transfers and pushes the DMA address to FW.
+	 */
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_rx_elem *rx_elem = cl_hw->rx_elems;
+	int i = 0;
+
+	/* Push RXM buffers */
+	for (i = 0; i < IPC_RXBUF_CNT_RXM; rx_elem++, i++)
+		cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_RXM);
+
+	/* Push FW buffers */
+	for (i = 0; i < IPC_RXBUF_CNT_FW; rx_elem++, i++)
+		cl_ipc_rxbuf_push(ipc_env, rx_elem, i, i, CL_RX_BUF_FW);
+}
+
+static void _cl_ipc_rx_buf_reset(u32 **rxbuf, u32 desc_num)
+{
+	u32 size = (desc_num * sizeof(u32));
+
+	memset(*rxbuf, 0, size);
+}
+
+static void cl_ipc_rx_buf_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_host_rxbuf *rxbuf_rxm = &ipc_env->rx_hostbuf_array[CL_RX_BUF_RXM];
+	struct cl_ipc_host_rxbuf *rxbuf_fw = &ipc_env->rx_hostbuf_array[CL_RX_BUF_FW];
+
+	/* Reset RXM RX buffer */
+	_cl_ipc_rx_buf_reset((u32 **)&rxbuf_rxm->dma_payload_addr,
+			     IPC_RXBUF_CNT_RXM);
+
+	/* Reset FW RX buffer */
+	_cl_ipc_rx_buf_reset((u32 **)&rxbuf_fw->dma_payload_addr,
+			     IPC_RXBUF_CNT_FW);
+}
+
+static void cl_ipc_rx_reset(struct cl_hw *cl_hw)
+{
+	cl_ipc_rx_buf_reset(cl_hw);
+	cl_ipc_rx_skb_reset(cl_hw);
+}
+
+static void cl_ipc_msg_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_e2a_msg_elem *msg_elem;
+	u32 i;
+
+	ipc_env->e2a_msg_host_idx = 0;
+
+	/* Initialize the msg buffers in the global IPC array. */
+	for (i = 0, msg_elem = cl_hw->e2a_msg_elems;
+	     i < IPC_E2A_MSG_BUF_CNT; msg_elem++, i++) {
+		msg_elem->msgbuf_ptr->pattern = 0;
+		cl_ipc_msgbuf_push(ipc_env, (ptrdiff_t)msg_elem, msg_elem->dma_addr);
+	}
+}
+
+static void cl_ipc_radar_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_radar_elem *radar_elem;
+	u32 i;
+
+	ipc_env->radar_host_idx = 0;
+
+	/* Initialize the radar buffers in the global IPC array. */
+	for (i = 0, radar_elem = cl_hw->radar_elems;
+	     i < IPC_RADAR_BUF_CNT; radar_elem++, i++) {
+		radar_elem->radarbuf_ptr->cnt = 0;
+		cl_ipc_radarbuf_push(ipc_env, (ptrdiff_t)radar_elem, radar_elem->dma_addr);
+	}
+}
+
+static void cl_ipc_dbg_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_dbg_elem *dbg_elem;
+	u32 i;
+
+	ipc_env->dbg_host_idx = 0;
+
+	/* Initialize the dbg buffers in the global IPC array. */
+	for (i = 0, dbg_elem = cl_hw->dbg_elems;
+	     i < IPC_DBG_BUF_CNT; dbg_elem++, i++) {
+		dbg_elem->dbgbuf_ptr->pattern = 0;
+		cl_ipc_dbgbuf_push(ipc_env, (ptrdiff_t)dbg_elem, dbg_elem->dma_addr);
+	}
+}
+
+static void cl_ipc_cfm_reset(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	ipc_env->cfm_used_idx = 0;
+	memset(ipc_env->cfm_virt_base_addr, 0, IPC_CFM_SIZE);
+}
+
+static void cl_ipc_dbg_info_reset(struct cl_hw *cl_hw)
+{
+	struct dbg_info *buf = cl_hw->dbginfo.buf;
+	struct cl_chip *chip = cl_hw->chip;
+	u32 len = sizeof(struct dbg_info);
+
+	if (!chip->conf->ci_la_mirror_en)
+		len -= sizeof_field(struct dbg_dump_info, la_mem);
+
+	memset(buf, 0, len);
+	buf->u.type = DBG_INFO_UNSET;
+
+	cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+}
+
+static void cl_ipc_elems_reset(struct cl_hw *cl_hw)
+{
+	cl_ipc_ring_indices_reset(cl_hw);
+	cl_ipc_txdesc_reset(cl_hw);
+	cl_ipc_rx_reset(cl_hw);
+	cl_ipc_msg_reset(cl_hw);
+	cl_ipc_radar_reset(cl_hw);
+	cl_ipc_dbg_reset(cl_hw);
+	cl_ipc_cfm_reset(cl_hw);
+	cl_ipc_dbg_info_reset(cl_hw);
+	cl_enhanced_tim_reset(cl_hw);
+}
+
+void cl_ipc_recovery(struct cl_hw *cl_hw)
+{
+	cl_ipc_shared_env_init(cl_hw);
+	cl_ipc_elems_reset(cl_hw);
+}
+
+void cl_ipc_deinit(struct cl_hw *cl_hw)
+{
+	cl_ipc_elems_dealloc(cl_hw);
+	cl_ipc_env_free(cl_hw);
+}
+
+void cl_ipc_stop(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	tasklet_kill(&ipc_env->bcn_tasklet);
+	tasklet_kill(&ipc_env->rxdesc_tasklet);
+	tasklet_kill(&ipc_env->tx_single_cfm_tasklet);
+	tasklet_kill(&ipc_env->tx_agg_cfm_tasklet);
+	tasklet_kill(&ipc_env->msg_tasklet);
+	tasklet_kill(&ipc_env->dbg_tasklet);
+}
+
+int cl_ipc_rx_elem_alloc(struct cl_hw *cl_hw, struct cl_rx_elem *rx_elem, u32 size)
+{
+	struct sk_buff *skb;
+	dma_addr_t dma_addr;
+	struct hw_rxhdr *rxhdr;
+
+	rx_elem->passed = 0;
+
+	skb = dev_alloc_skb(size);
+
+	if (unlikely(!skb)) {
+		cl_dbg_verbose(cl_hw, "skb alloc failed (size %u)\n", size);
+		rx_elem->dma_addr = (dma_addr_t)0;
+		return -ENOMEM;
+	}
+
+	rxhdr = (struct hw_rxhdr *)skb->data;
+	rxhdr->pattern = 0;
+
+	dma_addr = dma_map_single(cl_hw->chip->dev, skb->data, size, DMA_FROM_DEVICE);
+
+	if (unlikely(dma_mapping_error(cl_hw->chip->dev, dma_addr))) {
+		cl_dbg_verbose(cl_hw, "dma_mapping_error\n");
+		kfree_skb(skb);
+		return -1;
+	}
+
+	rx_elem->skb = skb;
+	rx_elem->dma_addr = dma_addr;
+
+	cl_rx_skb_alloc_handler(skb);
+
+	return 0;
+}
+
+void cl_ipc_msgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid, dma_addr_t hostbuf)
+{
+	/*
+	 * Push a pre-allocated buffer descriptor for MSGs
+	 * This function is only called at Init time since the MSGs will be handled directly
+	 * and buffer can be re-used as soon as the message is handled, no need to re-allocate
+	 * new buffers in the meantime.
+	 */
+	struct cl_ipc_shared_env __iomem *shared_env = ipc_env->shared;
+	u8 e2a_msg_host_idx = ipc_env->e2a_msg_host_idx;
+
+	/* Save the hostid and the hostbuf in global array */
+	ipc_env->e2a_msg_hostbuf_array[e2a_msg_host_idx].hostid = hostid;
+	ipc_env->e2a_msg_hostbuf_array[e2a_msg_host_idx].dma_addr = hostbuf;
+
+	/* Copy the hostbuf (DMA address) in the ipc shared memory */
+	iowrite32(hostbuf, (void __iomem *)&shared_env->e2a_msg_hostbuf_addr[e2a_msg_host_idx]);
+
+	/* Increment the array index */
+	ipc_env->e2a_msg_host_idx = (e2a_msg_host_idx + 1) % IPC_E2A_MSG_BUF_CNT;
+}
+
+void cl_ipc_rxbuf_push(struct cl_ipc_host_env *ipc_env, struct cl_rx_elem *rx_elem,
+		       u32 rxdesc_read_idx, u32 host_read_idx, enum rx_buf_type type)
+{
+	/*
+	 * Push a pre-allocated buffer descriptor for Rx packet.
+	 * This function is called to supply the firmware with new empty buffer.
+	 */
+	struct cl_ipc_ring_indices *indices = ipc_env->ring_indices_elem->indices;
+	struct cl_ipc_host_rxbuf *host_rxbuf = &ipc_env->rx_hostbuf_array[type];
+
+	/* Save the hostid and the hostbuf in global array */
+	host_rxbuf->ipc_host_rxdesc_ptr[host_read_idx] = (ptrdiff_t *)rx_elem;
+	host_rxbuf->dma_payload_addr[host_read_idx] = rx_elem->dma_addr;
+
+	/* Update rxbuff metadata */
+	indices->rxdesc_read_idx[type] = cpu_to_le32(rxdesc_read_idx + 1);
+}
+
+void cl_ipc_radarbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid, dma_addr_t hostbuf)
+{
+	/*
+	 * Push a pre-allocated radar event buffer descriptor.
+	 * This function should be called by the host IRQ handler to supply the embedded
+	 * side with new empty buffer.
+	 */
+	struct cl_ipc_shared_env __iomem *shared_env = ipc_env->shared;
+	u8 radar_host_idx = ipc_env->radar_host_idx;
+
+	/* Save the hostid and the hostbuf in global array */
+	ipc_env->radar_hostbuf_array[radar_host_idx].hostid = hostid;
+	ipc_env->radar_hostbuf_array[radar_host_idx].dma_addr = hostbuf;
+
+	/* Copy the hostbuf (DMA address) in the ipc shared memory */
+	iowrite32(hostbuf, (void __iomem *)&shared_env->radarbuf_hostbuf[radar_host_idx]);
+
+	/* Increment the array index */
+	ipc_env->radar_host_idx = (radar_host_idx + 1) % IPC_RADAR_BUF_CNT;
+}
+
+void cl_ipc_dbgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid, dma_addr_t hostbuf)
+{
+	/*
+	 * Push a pre-allocated buffer descriptor for Debug messages.
+	 * This function is only called at Init time since the Debug messages will be
+	 * handled directly and buffer can be re-used as soon as the message is handled,
+	 * no need to re-allocate new buffers in the meantime.
+	 */
+	struct cl_ipc_shared_env __iomem *shared_env = ipc_env->shared;
+	u8 dbg_host_idx = ipc_env->dbg_host_idx;
+
+	/* Save the hostid and the hostbuf in global array */
+	ipc_env->dbg_hostbuf_array[dbg_host_idx].hostid = hostid;
+	ipc_env->dbg_hostbuf_array[dbg_host_idx].dma_addr = hostbuf;
+
+	/* Copy the hostbuf (DMA address) in the ipc shared memory */
+	iowrite32(hostbuf, (void __iomem *)&shared_env->dbg_hostbuf_addr[dbg_host_idx]);
+
+	/* Increment the array index */
+	ipc_env->dbg_host_idx = (dbg_host_idx + 1) % IPC_DBG_BUF_CNT;
+}
+
+void cl_ipc_dbginfobuf_push(struct cl_ipc_host_env *ipc_env, dma_addr_t infobuf)
+{
+	/*Push the pre-allocated logic analyzer and debug information buffer */
+	struct cl_ipc_shared_env __iomem *shared_env = ipc_env->shared;
+
+	/* Copy the hostbuf (DMA address) in the ipc shared memory */
+	iowrite32(infobuf, (void __iomem *)&shared_env->dbginfo_addr);
+	/* Copy the hostbuf size in the ipc shared memory */
+	iowrite32(DBG_DUMP_BUFFER_SIZE, (void __iomem *)&shared_env->dbginfo_size);
+}
+
+static void cl_irq_status_rxdesc(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/*
+	 * Handle the reception of a Rx Descriptor.
+	 *
+	 * Disable the RX interrupt until rxelement/skb handled
+	 * this would avoid redundant context switch + redundant tasklet scheduling
+	 */
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.rxdesc);
+
+	/* Acknowledge the interrupt BEFORE handling the packet */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.rxdesc);
+
+	/*
+	 * If more than 50% of buffer are populated handle them in the interrupt,
+	 * otherwise schedule a tasklet to handle the buffers.
+	 */
+	if (cl_rx_process_in_irq(cl_hw))
+		cl_rx_pci_desc_handler(cl_hw);
+	else
+		tasklet_schedule(&ipc_env->rxdesc_tasklet);
+}
+
+static void cl_irq_status_txcfm(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/*
+	 * Disable the TXCFM interrupt bit - will be enabled
+	 * at the end of cl_tx_pci_single_cfm_tasklet()
+	 */
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.txcfm);
+
+	/* Acknowledge the TXCFM interrupt */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.txcfm);
+
+	/* Schedule tasklet to handle the TXCFM */
+	tasklet_schedule(&ipc_env->tx_single_cfm_tasklet);
+}
+
+static void cl_irq_status_tbtt(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	unsigned long tbtt_diff_msec = jiffies_to_msecs(jiffies - cl_hw->last_tbtt_irq);
+
+	/* Acknowledge the interrupt BEFORE handling the request */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.tbtt);
+
+	cl_hw->last_tbtt_irq = jiffies;
+	cl_hw->tbtt_cnt++;
+
+	/*
+	 * Send beacon only if radio is on, there is at least one AP interface
+	 * up, we aren't in the middle of recovery, and user didn't disable them.
+	 */
+	if (unlikely(!cl_is_tx_allowed(cl_hw)))
+		return;
+
+	if (cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_MESH_ONLY) {
+		tasklet_hi_schedule(&cl_hw->tx_mesh_bcn_task);
+		return;
+	} else if (cl_hw_get_iface_conf(cl_hw) == CL_IFCONF_MESH_AP && cl_hw->mesh_tbtt_div >= 1 &&
+		   ((cl_hw->tbtt_cnt % cl_hw->mesh_tbtt_div) == 0)) {
+		tasklet_hi_schedule(&cl_hw->tx_mesh_bcn_task);
+	} else if (IS_REAL_PHY(cl_hw->chip) && cl_hw->smallest_beacon_int > 0) {
+		/*
+		 * More than 2 times the beacon interval passed between beacons - WARNING
+		 * More than 3 times the beacon interval passed between beacons - ERROR
+		 */
+		if (tbtt_diff_msec > (cl_hw->smallest_beacon_int * 3))
+			cl_dbg_err(cl_hw, "last_tbtt_irq=%lu, curr_time=%lu, diff=%lu\n",
+				   cl_hw->last_tbtt_irq, jiffies, tbtt_diff_msec);
+		else if (tbtt_diff_msec > (cl_hw->smallest_beacon_int * 2))
+			cl_dbg_warn(cl_hw, "last_tbtt_irq=%lu, curr_time=%lu, diff=%lu\n",
+				    cl_hw->last_tbtt_irq, jiffies, tbtt_diff_msec);
+	}
+
+	tasklet_hi_schedule(&ipc_env->bcn_tasklet);
+}
+
+static void cl_irq_status_msg(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/* Acknowledge the interrupt BEFORE handling the request */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.msg);
+
+	/* Schedule tasklet to handle the messages */
+	tasklet_schedule(&ipc_env->msg_tasklet);
+}
+
+static u8 cl_radar_handler(struct cl_hw *cl_hw, ptrdiff_t hostid)
+{
+	struct cl_radar_elem *radar_elem = (struct cl_radar_elem *)hostid;
+	u8 ret = 0;
+	struct cl_radar_pulse_array *pulses;
+
+	/* Retrieve the radar pulses structure */
+	pulses = (struct cl_radar_pulse_array *)radar_elem->radarbuf_ptr;
+
+	/* Look for pulse count meaning that this hostbuf contains RADAR pulses */
+	if (pulses->cnt == 0) {
+		ret = -1;
+		goto radar_no_push;
+	}
+
+	/* Push pulse information to queue and schedule a tasklet to handle it */
+	cl_radar_push(cl_hw, radar_elem);
+
+	/* Reset the radar element and re-use it */
+	pulses->cnt = 0;
+
+	/* Make sure memory is written before push to HW */
+	wmb();
+
+	/* Push back the buffer to the firmware */
+	cl_ipc_radarbuf_push(cl_hw->ipc_env, (ptrdiff_t)radar_elem, radar_elem->dma_addr);
+
+radar_no_push:
+	return ret;
+}
+
+static void cl_irq_status_radar(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/*
+	 * Firmware has triggered an IT saying that a radar event has been sent to upper layer.
+	 * Then we first need to check the validity of the current msg buf, and the validity
+	 * of the next buffers too, because it is likely that several buffers have been
+	 * filled within the time needed for this irq handling
+	 */
+
+	/* Disable the RADAR interrupt bit - will be enabled at the end of cl_radar_tasklet() */
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.radar);
+
+	/* Acknowledge the RADAR interrupt */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.radar);
+
+	/* Push all new radar pulses to queue */
+	while (cl_radar_handler(cl_hw,
+				ipc_env->radar_hostbuf_array[ipc_env->radar_host_idx].hostid) == 0)
+		;
+
+	/* Schedule tasklet to handle the radar pulses */
+	cl_radar_tasklet_schedule(cl_hw);
+}
+
+static void cl_irq_status_dbg(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/* Disable the DBG interrupt bit - will be enabled at the end of cl_dbgfile_tasklet() */
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.dbg);
+
+	/* Acknowledge the DBG interrupt */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.dbg);
+
+	/* Schedule tasklet to handle the debug */
+	tasklet_schedule(&ipc_env->dbg_tasklet);
+}
+
+static void cl_irq_status_txdesc_ind(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/*
+	 * Disable the TXDESC_IND interrupt bit -
+	 * will be enabled at the end of cl_tx_pci_agg_cfm_tasklet()
+	 */
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.txdesc_ind);
+
+	/* Acknowledge the TXDESC_IND interrupt */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.txdesc_ind);
+
+	tasklet_schedule(&ipc_env->tx_agg_cfm_tasklet);
+	tasklet_schedule(&cl_hw->tx_task);
+}
+
+static void cl_irq_status_sync(struct cl_hw *cl_hw, struct cl_ipc_host_env *ipc_env)
+{
+	/* Acknowledge the interrupt BEFORE handling the request */
+	ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.sync);
+
+	set_bit(CL_DEV_FW_SYNC, &cl_hw->drv_flags);
+	wake_up_interruptible(&cl_hw->fw_sync_wq);
+}
+
+void cl_irq_status(struct cl_hw *cl_hw, u32 status)
+{
+	/* Handle all IPC interrupts on the host side */
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+
+	if (status & cl_hw->ipc_e2a_irq.rxdesc)
+		cl_irq_status_rxdesc(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.txcfm)
+		cl_irq_status_txcfm(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.tbtt)
+		cl_irq_status_tbtt(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.msg)
+		cl_irq_status_msg(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.radar)
+		cl_irq_status_radar(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.dbg)
+		cl_irq_status_dbg(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.txdesc_ind)
+		cl_irq_status_txdesc_ind(cl_hw, ipc_env);
+
+	if (status & cl_hw->ipc_e2a_irq.sync)
+		cl_irq_status_sync(cl_hw, ipc_env);
+}
+
+static void cl_irq_handler(struct cl_chip *chip)
+{
+	/* Interrupt handler */
+	u32 status, statuses = 0;
+	unsigned long now = jiffies;
+	struct cl_irq_stats *irq_stats = &chip->irq_stats;
+
+	while ((status = ipc_xmac_2_host_status_get(chip))) {
+		statuses |= status;
+
+		if (status & IPC_IRQ_L2H_ALL)
+			cl_irq_status(chip->cl_hw_tcv0, status);
+
+		if (status & IPC_IRQ_S2H_ALL)
+			cl_irq_status(chip->cl_hw_tcv1, status);
+	}
+
+	if (statuses & (IPC_IRQ_L2H_RXDESC | IPC_IRQ_S2H_RXDESC))
+		irq_stats->last_rx = now;
+
+	if (statuses & (IPC_IRQ_L2H_TXCFM | IPC_IRQ_S2H_TXCFM))
+		irq_stats->last_tx = now;
+
+	irq_stats->last_isr = now;
+	irq_stats->last_isr_statuses = statuses;
+}
+
+static irqreturn_t cl_irq_request_handler(int irq, void *dev_id)
+{
+	struct cl_chip *chip = (struct cl_chip *)dev_id;
+
+	cl_irq_handler(chip);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_SMP
+static void cl_irq_set_affinity(struct cl_chip *chip, struct pci_dev *pci_dev)
+{
+	s32 irq_smp_affinity = chip->conf->ce_irq_smp_affinity;
+
+	if (irq_smp_affinity != -1) {
+		struct irq_data *data = irq_get_irq_data(pci_dev->irq);
+
+		if (data) {
+			static struct cpumask mask;
+
+			cpumask_clear(&mask);
+			cpumask_set_cpu(irq_smp_affinity, &mask);
+
+			if (data->chip->irq_set_affinity) {
+				data->chip->irq_set_affinity(data, &mask, false);
+				pr_debug("irq=%d, affinity=%d\n", pci_dev->irq, irq_smp_affinity);
+			}
+		}
+	}
+}
+#endif /* CONFIG_SMP */
+
+int cl_irq_request(struct cl_chip *chip)
+{
+	/*
+	 * Allocate host irq line.
+	 * Enable PCIe device interrupts
+	 */
+	int ret;
+	unsigned long flags = IRQF_SHARED;
+	struct pci_dev *pci_dev = chip->pci_dev;
+
+	ret = request_irq(pci_dev->irq, cl_irq_request_handler, flags, "cl", chip);
+
+	if (ret) {
+		pr_err("ERROR: could not assign interrupt %d, err=%d\n", pci_dev->irq, ret);
+		return ret;
+	}
+
+#ifdef CONFIG_SMP
+	cl_irq_set_affinity(chip, pci_dev);
+#endif /* CONFIG_SMP */
+
+	return ret;
+}
+
+void cl_irq_free(struct cl_chip *chip)
+{
+	struct pci_dev *pci_dev = chip->pci_dev;
+	/* Disable PCI device interrupt and release irq line */
+	free_irq(pci_dev->irq, chip);
+}
+
+void cl_irq_enable(struct cl_hw *cl_hw, u32 value)
+{
+	/* Enable IPC interrupts */
+	ipc_xmac_2_host_enable_set_set(cl_hw->chip, value);
+}
+
+void cl_irq_disable(struct cl_hw *cl_hw, u32 value)
+{
+	/* Disable IPC interrupts */
+	ipc_xmac_2_host_enable_clear_set(cl_hw->chip, value);
+}
+
+static void cl_msg_pci_fw_push(struct cl_hw *cl_hw, void *msg_buf, u16 len)
+{
+	/* Send a message to the embedded side */
+	int i;
+	u32 *src;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	void __iomem *dst = (void __iomem *)&ipc_env->shared->a2e_msg_buf;
+
+	/* Copy the message into the IPC MSG buffer */
+	src = (u32 *)msg_buf;
+
+	/*
+	 * Move the destination pointer forward by one word
+	 * (due to the format of the firmware kernel messages)
+	 */
+	dst += sizeof(u32);
+
+	/* Align length of message to 4 */
+	len = ALIGN(len, sizeof(u32));
+
+	/* Copy the message in the IPC queue */
+	for (i = 0; i < len; i += sizeof(u32), dst += sizeof(u32))
+		iowrite32(*src++, dst);
+
+	/* Trigger the irq to send the message to EMB */
+	cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, IPC_IRQ_A2E_MSG);
+}
+
+int cl_msg_pci_msg_fw_send(struct cl_hw *cl_hw, const void *msg_params,
+			   bool background)
+{
+	struct cl_fw_msg *msg = container_of((void *)msg_params, struct cl_fw_msg, param);
+	u16 req_id = le16_to_cpu(msg->msg_id);
+	u16 cfm_bit = cl_msg_cfm_set_bit(req_id);
+	int length = sizeof(struct cl_fw_msg) + le16_to_cpu(msg->param_len);
+	int error = 0;
+
+	if (!cl_hw->fw_active) {
+		cl_dbg_verbose(cl_hw, "Bypass %s (firmware not loaded)\n", MSG_ID_STR(req_id));
+		/* Free the message */
+		kfree(msg);
+		return -EBUSY;
+	}
+
+	if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags)) {
+		cl_dbg_verbose(cl_hw, "Bypass %s (CL_DEV_FW_ERROR is set)\n", MSG_ID_STR(req_id));
+		/* Free the message */
+		kfree(msg);
+		return -EBUSY;
+	}
+
+	if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) &&
+	    req_id != MM_RESET_REQ &&
+	    req_id != MM_START_REQ) {
+		cl_dbg_verbose(cl_hw, "Bypass %s (CL_DEV_STARTED not set)\n", MSG_ID_STR(req_id));
+		/* Free the message */
+		kfree(msg);
+		return -EBUSY;
+	}
+
+	/* Lock msg tx of the correct msg buffer. */
+	error = mutex_lock_interruptible(&cl_hw->msg_tx_mutex);
+	if (error != 0) {
+		cl_dbg_verbose(cl_hw, "Bypass %s (mutex error %d)\n", MSG_ID_STR(req_id), error);
+		/* Free the message */
+		kfree(msg);
+		return error;
+	}
+
+	cl_hw->msg_background = background;
+
+	CFM_SET_BIT(cfm_bit, &cl_hw->cfm_flags);
+
+	cl_dbg_trace(cl_hw, "%s\n", MSG_ID_STR(req_id));
+
+	/* Push the message in the IPC */
+	cl_msg_pci_fw_push(cl_hw, msg, length);
+
+	/* Free the message */
+	kfree(msg);
+
+	return cl_msg_cfm_wait(cl_hw, cfm_bit, req_id);
+}
+
+static DEFINE_PER_CPU(struct tasklet_struct, rx_remote_tasklet_drv[TCV_TOTAL]);
+
+static void cl_rx_pci_stats_rxm(struct cl_hw *cl_hw, u16 bucket_idx)
+{
+	if (bucket_idx < IPC_RXBUF_NUM_BUCKETS_RXM)
+		cl_hw->rx_info.pkt_handle_bucket_rxm[bucket_idx]++;
+	else
+		cl_hw->rx_info.pkt_handle_bucket_rxm[IPC_RXBUF_NUM_BUCKETS_RXM - 1]++;
+}
+
+static void cl_rx_pci_stats_fw(struct cl_hw *cl_hw, u16 bucket_idx)
+{
+	if (bucket_idx < IPC_RXBUF_NUM_BUCKETS_FW)
+		cl_hw->rx_info.pkt_handle_bucket_fw[bucket_idx]++;
+	else
+		cl_hw->rx_info.pkt_handle_bucket_fw[IPC_RXBUF_NUM_BUCKETS_FW - 1]++;
+}
+
+static void cl_rx_pci_stats(struct cl_hw *cl_hw, u16 pkt_cnt, enum rx_buf_type type)
+{
+	/* Collect stats - fill the bucket stats */
+	if (pkt_cnt) {
+		u16 bucket_idx = pkt_cnt >> IPC_RXBUF_BUCKET_POW_SIZE;
+
+		if (type == CL_RX_BUF_RXM)
+			cl_rx_pci_stats_rxm(cl_hw, bucket_idx);
+		else
+			cl_rx_pci_stats_fw(cl_hw, bucket_idx);
+	}
+}
+
+static int _cl_rx_pci_start(struct cl_hw *cl_hw, u32 rxdesc_read_idx, u32 host_read_idx,
+			    enum rx_buf_type type)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_host_rxbuf *rx_hostbuf = &ipc_env->rx_hostbuf_array[type];
+	struct cl_rx_elem *rxelem =
+		(struct cl_rx_elem *)rx_hostbuf->ipc_host_rxdesc_ptr[host_read_idx];
+	struct sk_buff *skb;
+	int ret = 0;
+	dma_addr_t dma_addr;
+	u32 size = cl_hw->conf->ci_ipc_rxbuf_size[type];
+
+	cl_hw->rx_info.rx_desc[type]++;
+
+	/* Copy the current skb buffer & dma_addr. */
+	skb = rxelem->skb;
+	dma_addr = rxelem->dma_addr;
+
+	/* Try to populate the rxelem with new skb */
+	if (cl_ipc_rx_elem_alloc(cl_hw, rxelem, size)) {
+		cl_hw->rx_info.elem_alloc_fail++;
+		/* Restore skb and dma_addr value */
+		rxelem->skb = skb;
+		rxelem->dma_addr = dma_addr;
+		ret = -ENOMEM;
+		goto handle_done;
+	}
+
+	/* Release dma virtual memory early */
+	dma_unmap_single(cl_hw->chip->dev, dma_addr, size, DMA_FROM_DEVICE);
+
+	if (!skb) {
+		cl_hw->rx_info.skb_null++;
+		cl_rx_skb_error(cl_hw);
+		cl_dbg_verbose(cl_hw, "skb is NULL\n");
+		goto handle_done;
+	}
+
+	cl_ipc_rxbuf_push(ipc_env, rxelem, rxdesc_read_idx, host_read_idx, type);
+
+	cl_rx_push_queue(cl_hw, skb);
+
+handle_done:
+	return ret;
+}
+
+static void cl_rx_pci_start(struct cl_hw *cl_hw, enum rx_buf_type type, u16 rx_buf_cnt)
+{
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_ring_indices *indices = ipc_env->ring_indices_elem->indices;
+	u16 buf_cnt_mask = rx_buf_cnt - 1;
+	u16 pkt_cnt = 0;
+	u32 rxdesc_read_idx = le32_to_cpu(indices->rxdesc_read_idx[type]);
+	u32 host_read_idx = 0;
+	u32 rxdesc_write_idx = le32_to_cpu(indices->rxdesc_write_idx[type]);
+	u32 host_write_idx = 0;
+
+	/*
+	 * Firmware has triggered an interrupt saying that a reception has occurred.
+	 * Iterate over all valid rxdesc pushed by embedded.
+	 * The read index is incremented once the callback function finishes meaning
+	 * a new allocated skb pushed the rxbuff.
+	 * The write index is incremented in direct write by the embedded layer,
+	 * indicating that allocated skb was populated with packet data.
+	 */
+
+	do {
+		host_write_idx = rxdesc_write_idx;
+
+		while (ipc_env->host_rxdesc_read_idx[type] != host_write_idx) {
+			host_read_idx = rxdesc_read_idx & buf_cnt_mask;
+
+			if (_cl_rx_pci_start(cl_hw, rxdesc_read_idx, host_read_idx, type) == 0) {
+				/* Local application follower of embedded read idx */
+				ipc_env->host_rxdesc_read_idx[type]++;
+				rxdesc_read_idx++;
+				pkt_cnt++;
+			} else {
+				/*
+				 * Replacing old skb with new allocated skb failed
+				 * (should not happen). Postpone the handle of the
+				 * old skb until this function is reschduled again.
+				 */
+				if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+					tasklet_schedule(&ipc_env->rxdesc_tasklet);
+				goto out;
+			}
+		}
+
+		/* Check if firmware pushed new descriptors */
+		rxdesc_write_idx = le32_to_cpu(indices->rxdesc_write_idx[type]);
+	} while (host_write_idx != rxdesc_write_idx);
+
+out:
+	cl_rx_pci_stats(cl_hw, pkt_cnt, type);
+}
+
+static void cl_rx_pci_remote_tasklet_handler(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+
+	cl_rx_remote_cpu_info(cl_hw);
+	cl_rx_pci_desc_handler(cl_hw);
+}
+
+static call_single_data_t csd_rx_pci_remote_cpu_sched[TCV_TOTAL];
+static void cl_rx_pci_remote_cpu_sched(struct cl_hw *cl_hw)
+{
+	int cpu = cl_hw->conf->ci_rx_remote_cpu_drv;
+	struct tasklet_struct *t = csd_rx_pci_remote_cpu_sched[cl_hw->idx].info;
+
+	if (!test_bit(TASKLET_STATE_SCHED, &t->state))
+		smp_call_function_single_async(cpu, &csd_rx_pci_remote_cpu_sched[cl_hw->idx]);
+}
+
+void cl_rx_pci_init(struct cl_hw *cl_hw)
+{
+	s8 cpu = cl_hw->conf->ci_rx_remote_cpu_drv;
+
+	if (cpu >= 0) {
+		struct tasklet_struct *t = &per_cpu(rx_remote_tasklet_drv[cl_hw->idx], cpu);
+
+		tasklet_init(t,
+			     cl_rx_pci_remote_tasklet_handler,
+			     (unsigned long)cl_hw);
+
+		csd_rx_pci_remote_cpu_sched[cl_hw->idx].func = cl_rx_remote_tasklet_sched;
+		csd_rx_pci_remote_cpu_sched[cl_hw->idx].info = t;
+	}
+}
+
+void cl_rx_pci_deinit(struct cl_hw *cl_hw)
+{
+	s8 cpu = cl_hw->conf->ci_rx_remote_cpu_drv;
+
+	if (cpu >= 0)
+		tasklet_kill(&per_cpu(rx_remote_tasklet_drv[cl_hw->idx], cpu));
+}
+
+void cl_rx_pci_desc_handler(struct cl_hw *cl_hw)
+{
+	/* Handle all RXM rx elements */
+	cl_rx_pci_start(cl_hw, CL_RX_BUF_RXM, IPC_RXBUF_CNT_RXM);
+	/* Handle all FW rx elements */
+	cl_rx_pci_start(cl_hw, CL_RX_BUF_FW, IPC_RXBUF_CNT_FW);
+
+	/* Initiate interrupt to embbeded when all rx elements were handled */
+	if (!test_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags))
+		cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, IPC_IRQ_A2E_RXBUF_BACK);
+
+	/*
+	 * Finished handle all valid rx elements, restore the RX interrupt
+	 * to enable handling new populated rx elements
+	 */
+	if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+		cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.rxdesc);
+}
+
+void cl_rx_pci_desc_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+
+	if (cl_hw->conf->ci_rx_remote_cpu_drv == -1)
+		cl_rx_pci_desc_handler(cl_hw);
+	else
+		cl_rx_pci_remote_cpu_sched(cl_hw);
+}
+
+static void cl_tx_ipc_txdesc_populate(struct cl_hw *cl_hw, struct txdesc *txdesc,
+				      u8 queue_type, u32 ipc_queue_idx)
+{
+	/*
+	 * 1) Request allocation of txdesc associated with queue type and index from the ipc layer.
+	 * 2) Populate ipc-txdesc with the received txdesc.
+	 * 3) Increase write index - (must be last action since FW fetch WR idx first).
+	 */
+	__le32 *write_idx_ptr = NULL;
+	struct txdesc *ipc_txdesc = NULL;
+	struct cl_ipc_ring_indices *indices = cl_hw->ipc_env->ring_indices_elem->indices;
+	struct cl_ipc_txdesc_write_idx *txdesc_write_idx =
+		(struct cl_ipc_txdesc_write_idx *)&indices->txdesc_write_idx;
+	u32 write_idx = 0;
+	u32 masked_write_idx = 0;
+
+	switch (queue_type) {
+	case QUEUE_TYPE_AGG:
+		ipc_txdesc = cl_hw->ipc_env->tx_queues.ipc_txdesc_agg[ipc_queue_idx];
+		write_idx = le32_to_cpu(txdesc_write_idx->agg[ipc_queue_idx]);
+		write_idx_ptr = &txdesc_write_idx->agg[ipc_queue_idx];
+		masked_write_idx = write_idx & (TXDESC_AGG_Q_SIZE_MAX - 1);
+		break;
+	case QUEUE_TYPE_SINGLE:
+		ipc_txdesc = cl_hw->ipc_env->tx_queues.ipc_txdesc_single[ipc_queue_idx];
+		write_idx = le32_to_cpu(txdesc_write_idx->single[ipc_queue_idx]);
+		write_idx_ptr = &txdesc_write_idx->single[ipc_queue_idx];
+		masked_write_idx = write_idx & (IPC_TXDESC_CNT_SINGLE - 1);
+		break;
+	case QUEUE_TYPE_BCMC:
+		ipc_txdesc = cl_hw->ipc_env->tx_queues.ipc_txdesc_bcmc;
+		write_idx = le32_to_cpu(txdesc_write_idx->bcmc);
+		write_idx_ptr = &txdesc_write_idx->bcmc;
+		masked_write_idx = write_idx & (IPC_TXDESC_CNT_BCMC - 1);
+		break;
+	default:
+		cl_dbg_verbose(cl_hw, "undefined queue type %u\n", queue_type);
+		WARN_ON(true);
+	}
+
+	ipc_txdesc += masked_write_idx;
+
+	memcpy(ipc_txdesc, txdesc, sizeof(struct txdesc));
+
+	/*
+	 * Update write pointer only after new txdesc copy is done since FW
+	 * fetch WR pointer first, if not, FW might read and old txdesc since
+	 * WR index indicate txdesc is valid.
+	 */
+	*write_idx_ptr = cpu_to_le32(write_idx + 1);
+}
+
+int cl_tx_release_skbs_from_cfm(struct cl_hw *cl_hw, u8 queue_idx, u16 new_ssn)
+{
+	struct cl_agg_cfm_queue *cfm_queue = NULL;
+	struct cl_tx_queue *tx_queue = NULL;
+	int free_space_add = 0;
+	u16 prev_ssn = 0;
+
+	if (new_ssn == CE_INVALID_SN)
+		return free_space_add;
+
+	cfm_queue = &cl_hw->agg_cfm_queues[queue_idx];
+	tx_queue = cfm_queue->tx_queue;
+
+	/*
+	 * Continue to free skb's until:
+	 * 1. list is empty.
+	 * 2. agg ssn is equal to new ssn received from ssn.
+	 */
+
+	spin_lock(&cl_hw->tx_lock_cfm_agg);
+	prev_ssn = cfm_queue->ssn;
+	while (!list_empty(&cfm_queue->head) && (cfm_queue->ssn != new_ssn)) {
+		cl_agg_cfm_free_head_skb(cl_hw, cfm_queue, queue_idx);
+		free_space_add++;
+		cfm_queue->ssn = ((cfm_queue->ssn + 1) & 0xFFF);
+	}
+
+	/* Sanity check. test if all skb's marked to be free. */
+	if (unlikely(cfm_queue->ssn != new_ssn))
+		cl_dbg_err(cl_hw, "ssn diff - queue idx=%u, new ssn=%u, prev ssn=%u, cfm ssn=%u\n",
+			   queue_idx, new_ssn, prev_ssn, cfm_queue->ssn);
+
+	spin_unlock(&cl_hw->tx_lock_cfm_agg);
+
+	if (free_space_add > 0) {
+		if (tx_queue) {
+			spin_lock(&cl_hw->tx_lock_agg);
+			tx_queue->fw_free_space += free_space_add;
+			tx_queue->total_fw_cfm += free_space_add;
+
+			/*
+			 * If FW used all packets that driver pushed to him,
+			 * clear the enhanced TIM bit.
+			 */
+			if (cl_txq_is_fw_empty(tx_queue))
+				cl_enhanced_tim_clear_tx_agg(cl_hw, queue_idx,
+							     tx_queue->hw_index, tx_queue->cl_sta,
+							     tx_queue->tid);
+			spin_unlock(&cl_hw->tx_lock_agg);
+		}
+	}
+
+	return free_space_add;
+}
+
+static int cl_tx_pci_agg_cfm_handler(struct cl_hw *cl_hw)
+{
+	struct cl_ipc_ring_indices *indices = cl_hw->ipc_env->ring_indices_elem->indices;
+	int total_cfm_handled = 0;
+	u16 new_ssn;
+	u8 used_cntr = 0;
+	u8 ba_queue_idx;
+
+	for (ba_queue_idx = 0; ba_queue_idx < IPC_MAX_BA_SESSIONS; ba_queue_idx++) {
+		new_ssn = (u16)le32_to_cpu(indices->new_ssn_idx[ba_queue_idx]);
+		total_cfm_handled += cl_tx_release_skbs_from_cfm(cl_hw, ba_queue_idx, new_ssn);
+
+		/* Optimization - avoid running the for loop IPC_MAX_BA_SESSIONS times */
+		used_cntr++;
+		if (used_cntr == cl_hw->used_agg_queues)
+			break;
+	}
+
+	return total_cfm_handled;
+}
+
+void cl_tx_pci_agg_cfm_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+
+	cl_tx_pci_agg_cfm_handler(cl_hw);
+
+	if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+		cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.txdesc_ind);
+}
+
+static void cl_tx_pci_single_cfm_handler(struct cl_hw *cl_hw, u32 cfm_status,
+					 u32 dma_addr, u32 single_queue_idx)
+{
+	struct sk_buff *skb = NULL;
+	struct ieee80211_tx_info *tx_info = NULL;
+	struct cl_hw_tx_status *status = (struct cl_hw_tx_status *)&cfm_status;
+	struct cl_sw_txhdr *sw_txhdr = NULL;
+	struct cl_tx_queue *tx_queue = NULL;
+	struct cl_sta *cl_sta = NULL;
+	u8 hw_queue;
+	bool is_bcn;
+
+	if (status->is_bcmc) {
+		spin_lock_bh(&cl_hw->tx_lock_bcmc);
+		sw_txhdr = cl_bcmc_cfm_find(cl_hw, dma_addr, status->keep_skb);
+		tx_queue = &cl_hw->tx_queues->bcmc;
+	} else {
+		spin_lock_bh(&cl_hw->tx_lock_single);
+		sw_txhdr = cl_single_cfm_find(cl_hw, single_queue_idx, dma_addr);
+		tx_queue = &cl_hw->tx_queues->single[single_queue_idx];
+	}
+
+	if (!sw_txhdr) {
+		cl_dbg_trace(cl_hw, "Failed to find CFM for single_queue_idx %u status 0x%x\n",
+			     single_queue_idx, cfm_status);
+		goto out;
+	}
+
+	skb = sw_txhdr->skb;
+	tx_info = IEEE80211_SKB_CB(skb);
+	hw_queue = sw_txhdr->hw_queue;
+	is_bcn = sw_txhdr->is_bcn;
+
+	/*
+	 * Used for beacon frames only !!
+	 * if skb was already confirmed we do not need to inc FwFreeSpace counter
+	 */
+	if (likely(!status->freespace_inc_skip)) {
+		tx_queue->total_fw_cfm++;
+		tx_queue->fw_free_space++;
+
+		/* Clear the TIM element if assoicated IPC queue is empty */
+		if (!is_bcn && cl_txq_is_fw_empty(tx_queue)) {
+			bool no_ps_buffer =
+				(tx_info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER);
+
+			cl_sta_lock(cl_hw);
+			cl_sta = cl_sta_get(cl_hw, sw_txhdr->sta_idx);
+			cl_enhanced_tim_clear_tx_single(cl_hw, single_queue_idx, hw_queue,
+							no_ps_buffer, cl_sta, sw_txhdr->tid);
+			cl_sta_unlock(cl_hw);
+		}
+	} else  if (!is_bcn) {
+		cl_dbg_verbose(cl_hw, "should no be here - is_bcn=%d hw_queue=%d\n",
+			       is_bcn, hw_queue);
+	}
+
+	/*
+	 * Used for beacon frames only !!
+	 * if this flag is set, it means FW still need this beacon skb, therefore
+	 * we do not free this skb.
+	 */
+	if (unlikely(status->keep_skb)) {
+		if (!is_bcn)
+			cl_dbg_verbose(cl_hw, "should not be here - is_bcn=%d hw_queue=%d\n",
+				       is_bcn, hw_queue);
+		goto out;
+	}
+
+	dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA_TO_DEVICE);
+
+	/*
+	 * If queue is not empty call cl_txq_sched() to
+	 * transfer packets from the queue to firmware
+	 */
+	if (!list_empty(&tx_queue->hdrs))
+		cl_txq_sched(cl_hw, tx_queue);
+
+	if (status->is_bcmc)
+		spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+	else
+		spin_unlock_bh(&cl_hw->tx_lock_single);
+
+	if (is_bcn) {
+		struct ieee80211_vif *vif = sw_txhdr->cl_vif->vif;
+
+		if (vif) {
+			if (vif->csa_active &&
+			    ieee80211_beacon_cntdwn_is_complete(vif))
+				ieee80211_csa_finish(vif);
+		}
+
+		consume_skb(skb);
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+		return;
+	}
+
+	if (status->frm_successful && !(tx_info->flags & IEEE80211_TX_CTL_NO_ACK))
+		tx_info->flags |= IEEE80211_TX_STAT_ACK;
+
+	cl_sta_lock(cl_hw);
+	cl_sta = cl_sta_get(cl_hw, sw_txhdr->sta_idx);
+
+	if (cl_sta) {
+		if (tx_queue->type != QUEUE_TYPE_BCMC &&
+		    ieee80211_is_data(sw_txhdr->fc) &&
+		    !cl_tx_ctrl_is_eapol(tx_info))
+			cl_agg_tx_report_simulate_for_single(cl_hw, cl_sta, status);
+
+		cl_tx_check_start_ba_session(cl_hw, cl_sta->sta, skb);
+	}
+
+	cl_sta_unlock(cl_hw);
+
+	if (tx_info->ack_frame_id)
+		ieee80211_tx_status(cl_hw->hw, skb);
+	else
+		consume_skb(skb);
+
+	cl_sw_txhdr_free(cl_hw, sw_txhdr);
+	return;
+
+out:
+	if (status->is_bcmc)
+		spin_unlock_bh(&cl_hw->tx_lock_bcmc);
+	else
+		spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_tx_pci_single_cfm_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_ipc_cfm_msg *msg = NULL;
+
+	msg = (struct cl_ipc_cfm_msg *)(ipc_env->cfm_virt_base_addr) +
+		(ipc_env->cfm_used_idx % IPC_CFM_CNT);
+
+	while (msg && msg->dma_addr) {
+		u32 cfm_used_idx = ipc_env->cfm_used_idx++;
+
+		cl_tx_pci_single_cfm_handler(cl_hw,
+					     le32_to_cpu(msg->status),
+					     le32_to_cpu(msg->dma_addr),
+					     le32_to_cpu(msg->single_queue_idx));
+		msg->dma_addr = 0;
+		iowrite32(cfm_used_idx, (void __iomem *)&ipc_env->shared->cfm_read_pointer);
+		msg = (struct cl_ipc_cfm_msg *)(ipc_env->cfm_virt_base_addr) +
+			(ipc_env->cfm_used_idx % IPC_CFM_CNT);
+	}
+
+	/* Enable the Tx CFM interrupt bit */
+	if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+		cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.txcfm);
+}
+
+void cl_tx_pci_pkt_fw_send(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+			   struct cl_tx_queue *tx_queue)
+{
+	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(sw_txhdr->skb);
+	struct txdesc *txdesc = &sw_txhdr->txdesc;
+	struct tx_host_info *host_info = &txdesc->host_info;
+	struct cl_sta *cl_sta = sw_txhdr->cl_sta;
+	struct cl_vif *cl_vif = sw_txhdr->cl_vif;
+	u8 hw_queue = sw_txhdr->hw_queue;
+	u16 a2e_trigger_bit_pos;
+	u8 tid = sw_txhdr->tid;
+	u8 queue_type = tx_queue->type;
+	bool no_ps_buffer = !!(tx_info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER);
+	u16 ipc_queue_idx = tx_queue->index;
+	bool is_mgmt = ieee80211_is_mgmt(sw_txhdr->fc);
+	u8 i = 0;
+	u8 *cpu_addr = (u8 *)sw_txhdr->skb->data -
+		       ((host_info->host_padding & 1) * 2);
+	dma_addr_t dma_addr = dma_map_single(cl_hw->chip->dev, cpu_addr,
+					     sw_txhdr->map_len, DMA_TO_DEVICE);
+
+	if (WARN_ON(dma_mapping_error(cl_hw->chip->dev, dma_addr))) {
+		tx_queue->dump_dma_map_fail++;
+
+		if (queue_type == QUEUE_TYPE_SINGLE) {
+			if (!is_mgmt)
+				cl_vif->sequence_number = DEC_SN(cl_vif->sequence_number);
+
+			cl_tx_single_free_skb(cl_hw, sw_txhdr->skb);
+		} else {
+			if (queue_type == QUEUE_TYPE_AGG) {
+				struct cl_baw *baw = &cl_sta->baws[tid];
+
+				baw->tid_seq = DEC_SN(baw->tid_seq);
+			}
+
+			dev_kfree_skb_any(sw_txhdr->skb);
+		}
+
+		cl_sw_txhdr_free(cl_hw, sw_txhdr);
+		return;
+	}
+
+	txdesc->umacdesc.packet_addr[0] = cpu_to_le32(dma_addr);
+
+	cl_tx_ipc_txdesc_populate(cl_hw, txdesc, queue_type, ipc_queue_idx);
+
+	/* make sure memory is written before push to HW */
+	wmb();
+
+	/*
+	 * 1) Notify firmware on new buffered traffic by updating the enhanced tim.
+	 * 2) Push sw_txhdr to confirmation list
+	 */
+	if (queue_type == QUEUE_TYPE_AGG) {
+		a2e_trigger_bit_pos = IPC_IRQ_A2E_TXDESC_AGG_MAP(hw_queue);
+		cl_agg_cfm_add(cl_hw, sw_txhdr, ipc_queue_idx);
+		cl_enhanced_tim_set_tx_agg(cl_hw, ipc_queue_idx, hw_queue,
+					   no_ps_buffer, cl_sta, tid);
+	} else if (queue_type == QUEUE_TYPE_SINGLE) {
+		a2e_trigger_bit_pos = IPC_IRQ_A2E_TXDESC_SINGLE_MAP(hw_queue);
+		cl_single_cfm_add(cl_hw, sw_txhdr, ipc_queue_idx);
+		cl_enhanced_tim_set_tx_single(cl_hw, ipc_queue_idx, hw_queue,
+					      no_ps_buffer, cl_sta, tid);
+	} else {
+		a2e_trigger_bit_pos = IPC_IRQ_A2E_TXDESC_SINGLE_MAP(hw_queue);
+		cl_bcmc_cfm_add(cl_hw, sw_txhdr);
+	}
+
+	if (cl_hw->conf->ci_tx_delay_tstamp_en)
+		cl_tx_update_hist_tstamp(tx_queue, sw_txhdr->skb, tx_queue->hist_xmit_to_push,
+					 true);
+
+	/* Tx_queue counters */
+	tx_queue->fw_free_space--;
+	tx_queue->total_fw_push_desc++;
+	tx_queue->total_fw_push_skb += host_info->packet_cnt;
+
+	/* VIF statistics */
+	cl_vif->trfc_cntrs[sw_txhdr->ac].tx_packets += host_info->packet_cnt;
+
+	for (i = 0; i < host_info->packet_cnt; i++)
+		cl_vif->trfc_cntrs[sw_txhdr->ac].tx_bytes +=
+			le16_to_cpu(txdesc->umacdesc.packet_len[i]);
+
+	/* Trigger interrupt to firmware so that it will know that a new descriptor is ready */
+	cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, BIT(a2e_trigger_bit_pos));
+}
+
+struct cl_pci_db {
+	u8 device_cntr;
+	struct pci_dev *dev[CHIP_MAX];
+};
+
+static struct cl_pci_db pci_db;
+
+static void cl_pci_get_celeno_device(void)
+{
+	/*
+	 * Search the PCI for all Celeno devices.
+	 * If there are two devices sort them in ascending order.
+	 */
+	struct pci_dev *dev = NULL;
+
+	while ((dev = pci_get_device(CL_VENDOR_ID, PCI_ANY_ID, dev))) {
+		pci_db.dev[pci_db.device_cntr] = dev;
+		pci_db.device_cntr++;
+
+		if (pci_db.device_cntr == CHIP_MAX) {
+			if (pci_db.dev[CHIP0]->device > pci_db.dev[CHIP1]->device)
+				swap(pci_db.dev[CHIP0], pci_db.dev[CHIP1]);
+
+			break;
+		}
+	}
+}
+
+static u8 cl_pci_chip_idx(struct pci_dev *pci_dev)
+{
+	if (pci_db.device_cntr == 0)
+		cl_pci_get_celeno_device();
+
+	if (pci_db.device_cntr == 1)
+		return CHIP0;
+
+	return (pci_db.dev[CHIP0] == pci_dev) ? CHIP0 : CHIP1;
+}
+
+static const struct cl_driver_ops drv_ops = {
+	.msg_fw_send = cl_msg_pci_msg_fw_send,
+	.pkt_fw_send = cl_tx_pci_pkt_fw_send,
+};
+
+static int cl_pci_probe(struct pci_dev *pci_dev,
+			const struct pci_device_id *pci_id)
+{
+	u16 pci_cmd;
+	int ret;
+	u8 step_id;
+	u8 chip_idx = cl_pci_chip_idx(pci_dev);
+	struct cl_chip *chip = cl_chip_alloc(chip_idx);
+
+	if (!chip) {
+		pr_err("Chip [%u] alloc failed\n", chip_idx);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	chip->pci_dev = pci_dev;
+	chip->dev = &pci_dev->dev;
+	chip->bus_type = CL_BUS_TYPE_PCI;
+
+	ret = cl_chip_config_read(chip);
+	if (ret) {
+		cl_chip_dealloc(chip);
+		return 0;
+	}
+
+	pci_set_drvdata(pci_dev, chip);
+
+	/* Hotplug fixups */
+	pci_read_config_word(pci_dev, PCI_COMMAND, &pci_cmd);
+	pci_cmd |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
+	pci_write_config_word(pci_dev, PCI_COMMAND, pci_cmd);
+	pci_write_config_byte(pci_dev, PCI_CACHE_LINE_SIZE, L1_CACHE_BYTES >> 2);
+
+	ret = pci_enable_device(pci_dev);
+	if (ret) {
+		cl_dbg_chip_err(chip, "pci_enable_device failed\n");
+		goto out;
+	}
+
+	if (!dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(32))) {
+		cl_dbg_chip_verbose(chip, "Using 32bit DMA\n");
+	} else {
+		cl_dbg_chip_verbose(chip, "No suitable DMA available\n");
+		goto out_disable_device;
+	}
+
+	pci_set_master(pci_dev);
+
+	ret = pci_request_regions(pci_dev, chip->pci_drv.name);
+	if (ret) {
+		cl_dbg_chip_verbose(chip, "pci_request_regions failed\n");
+		goto out_disable_device;
+	}
+
+	chip->pci_bar0_virt_addr = pci_ioremap_bar(pci_dev, 0);
+	if (!chip->pci_bar0_virt_addr) {
+		cl_dbg_chip_verbose(chip, "pci_ioremap_bar 0 failed\n");
+		ret = -ENOMEM;
+		goto out_release_regions;
+	}
+
+#ifdef CONFIG_PCI_MSI
+	if (chip->conf->ci_pci_msi_enable) {
+		ret = pci_enable_msi(pci_dev);
+		if (ret)
+			cl_dbg_chip_err(chip, "pci_enable_msi failed (%d)\n", ret);
+	}
+#endif
+
+	step_id = macsys_gcu_chip_version_step_id_getf(chip);
+	if (step_id != 0xB) {
+		cl_dbg_chip_err(chip, "Invalid Step ID: 0x%X\n", step_id);
+		ret = -EOPNOTSUPP;
+		goto out_release_regions;
+	}
+
+	ret = cl_chip_init(chip);
+	if (ret)
+		goto out_chip_deinit;
+
+	ret = cl_main_init(chip, &drv_ops);
+	if (ret)
+		goto out_chip_deinit;
+
+	if (cl_ela_init(chip))
+		cl_dbg_chip_info(chip, "Non-critical: cl_ela_init failed\n");
+
+	return 0;
+
+out_chip_deinit:
+	cl_chip_deinit(chip);
+#ifdef CONFIG_PCI_MSI
+	if (chip->conf->ci_pci_msi_enable)
+		pci_disable_msi(pci_dev);
+#endif
+	iounmap(chip->pci_bar0_virt_addr);
+out_release_regions:
+	pci_release_regions(pci_dev);
+out_disable_device:
+	pci_disable_device(pci_dev);
+out:
+
+	return ret;
+}
+
+static void cl_pci_remove(struct pci_dev *pci_dev)
+{
+	struct cl_chip *chip = pci_get_drvdata(pci_dev);
+
+	if (!chip) {
+		pr_err("%s: failed to find chip\n", __func__);
+		return;
+	}
+
+	cl_ela_deinit(chip);
+
+	cl_main_deinit(chip);
+
+	cl_chip_deinit(chip);
+
+#ifdef CONFIG_PCI_MSI
+	if (chip->conf->ci_pci_msi_enable) {
+		pci_disable_msi(pci_dev);
+		pr_debug("pci_disable_msi\n");
+	}
+#endif
+
+	iounmap(chip->pci_bar0_virt_addr);
+	cl_chip_dealloc(chip);
+	pci_release_regions(pci_dev);
+	pci_disable_device(pci_dev);
+}
+
+static const struct pci_device_id cl_pci_id_table[] = {
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8000) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8001) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8040) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8060) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8080) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8046) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8066) },
+	{ PCI_DEVICE(CL_VENDOR_ID, 0x8086) },
+	{ },
+};
+
+static struct pci_driver cl_pci_driver = {
+	.name = "cl_pci",
+	.id_table = cl_pci_id_table,
+	.probe = cl_pci_probe,
+	.remove = cl_pci_remove,
+};
+
+static int cl_pci_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&cl_pci_driver);
+	if (ret)
+		pr_err("failed to register cl pci driver: %d\n", ret);
+
+	return ret;
+}
+module_init(cl_pci_init);
+
+static void cl_pci_exit(void)
+{
+	pci_unregister_driver(&cl_pci_driver);
+}
+module_exit(cl_pci_exit);
-- 
2.36.1

