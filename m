Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B861953294E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236842AbiEXLjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbiEXLjV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:21 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50045.outbound.protection.outlook.com [40.107.5.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D758D6AA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IldXWNZLxYKBUWCD7Iht9R4/YAAAyk8bTsrGGMd+fv1w66uDD6hz4IItEFCZTr/wmBQNQYUYGqwyNQWcyDZdrB7F3Ui1yzWDFt1DAA/ROrDUoSLolEuxTtCoDVcYLfq1437A7TvPH2MIlZzMdgUf2hznWrcP0NHPYfuvRKJZjMSy4OgCTvhoFTsrUgR01HzuKfnPWq/z0fIDlslm60ix8gYkvgb52iQIS6ETL/1Cox1XdY1cxyx6eTaqwb9mohXzncXBmTvlqk2oVZDxU9sKKmRPctJZ+opK8MvuHGCuhJpCQavqbkUjlQ6TF41aWXF3o/dGhrlLYdINe8CA9Hq41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TUNOsgahF0ygfpFr46DzooupHPF69b3OG2NWm7Y0k/M=;
 b=gB3s9lgmuhHJc1wxRs5PN2DFj4cZeH/KCullyP/5KDUP8tA+nrkk3iLgL06epvhV+Zfcq8NbtjSv/S73nzgGPa/fgxjomPZ+BgDoYI9ozO/Pr+6SNqsmPznC2InTNQhCKpJ39QsF5HEcicfEwKqzUQJetOZKlm4lIQt52Mep+e32nz8u+JybBRDPWbgO5u6RVGEQ9gquRs24u7HS3fpyRUgB3zcsMN7k3soCzbvp73QIPHasaHhQPHcz70LcBMgm/8FNQqQDlqcfOeC7ocRDaCX0M60N/EsP9nky8lHFmmM3JsQhEA9DQ05t2m8KPGJpOy51GDDa1hGzATjfjyr1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUNOsgahF0ygfpFr46DzooupHPF69b3OG2NWm7Y0k/M=;
 b=nU8OHuoFCiXIUtmzWcyAqveFhQYbUwux7sqCx3P+T8+srpL/tytVzqgxqQPHucEMCYH71NqMV5M/A6FDxV3HA1au7xEHWkZciAcCP3l6+Cevt4RD6XictwobrvOUNljApsxcZLbJVbPJX5uxj/Ljb2teFlxBbji+VRrK9BSDqXM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:38:47 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:47 +0000
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
Subject: [RFC v2 49/96] cl8k: add pci.h
Date:   Tue, 24 May 2022 14:34:15 +0300
Message-Id: <20220524113502.1094459-50-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 013455a5-ee21-4fdd-2191-08da3d79eb54
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB1571E6207447B2E23E020F1EF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nq2IcfymgyNE+vZ4JDj/iWGok4iBX7LFC8RyxmspRpSjOCEV2D3VoXPYrvzZW+8JhntyJ9hTkkXHLxqtwkoYmYzn00iRg/AUsBkg/Hx0qIFuW6kNq24bB48OuH6AX9AdhkQzyrXyi49Fmr+00W3N2nby/hWLRpMa+/ci78SfkV7uZtFlcsnXX/rvxShiiicaWxCJRFHkU6VngQgBol3xhTivrwiZSy3rF03RU2Bjw7IUAOVTibIeDwd1aslOAUaAadMacC0kKVq6KZ7FodIGoqvcE30WoMWdcrbiC+8HPVd0z78O3Mck9zdznfh0bq/mAnzGA+YEg1YLs9dqgDnZ2Gz3X7Fx/EVY4C8eCrzy46uxEoFk9+95omdRBd1sqgb+fhWGF/cBxc4gLz7NhpvM5riYz+oDZBZ3Ses5E2zpLCU/fpdaaz5WcMPRaM8cwHqhdYAEYp9nrSX1M7+FmwKCuag+RVWl+2DoGAbn5PMUQHfURrc9yFCKe+pudLziRYT3cMuhPjyx94l+hGXEv1M8gWB0e8eMKo6mHeuIKfvrMwI7ZKxMiUKy01zNGfBxqzMALuqo0WyMi7pASMMxzghlPRiwez99O8Iz+wXKW3N8f62VHoH3WPnC0E8CSTa4ksDajAGkjNdy26GEI1/xzbFsftXpuzcivv7To3QY3CB1zcv8z3yv7KbY40jEiPvWAxeeNaIcLzLKruy6s0Gl5jyQETlUItpP2w/SaYQnHkj3e/w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6666004)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDWPJ0XE5HMwnCuenIxG3e6v6533suDzokySeds8LhmMAHZDlXc6TKmd2ufc?=
 =?us-ascii?Q?nTmUKWVSbt8NfTZB4JG2uowiBR0ydNfdtJN+kYa4PomD5rKyBVhKIdWJMD9X?=
 =?us-ascii?Q?5c+r+MatyOjCwXAt2+GeqDMyoEivBX36g2SOIXmrwKmMrsQX44xRNb8l5xC6?=
 =?us-ascii?Q?ty32FYlf6VxLwAOPyQGsKQrcYSHP72etOD49/ccruODrXIXakkKH39+XMBOg?=
 =?us-ascii?Q?SoJS7bVSktuT1o1NuDToX3QLbuoDlocN3Zl0KsbA7LpMez0zn7oAOwlx2xD+?=
 =?us-ascii?Q?6h6YQURy7t7ysjSk8LjtzkyU8fhn/76TXKnweh2rrvovdhee1oogxLox0Z/V?=
 =?us-ascii?Q?F5ariIvKqKJNyLHoWV74T8Rwx2kc2jIUKGqc4E512mtU4i6vO6jK9FQfXIEI?=
 =?us-ascii?Q?/YBFPiJw3UrT9241Pig2hymJpArRL6KZ3gBWf/gU19ciYJJbf/hw960nJ5G2?=
 =?us-ascii?Q?ONEzF5J7MoffOjvvPbaSQ1IWgl+IcrhaPhAcZefGYMgb7OVsx/zXE+xDS9je?=
 =?us-ascii?Q?1nxusjDXbCJyWol7v09afyeq9u96Ac2g8pL+KrY+St0zn7TxVbb/SZbgtytt?=
 =?us-ascii?Q?+lrOFGAuL5iTgppYOpXWhFTfWB4clT7LqkFyp6oA2DD8/no0Peerr9RQ68Wh?=
 =?us-ascii?Q?T6hnsXEQOZCnoUv2xWTjRvSC4SDIjvjGy3vStSYK5pgB8Va98epI7y/5j5Bq?=
 =?us-ascii?Q?mlpLBUlr5kiNsOB0/6iFp9RLCyTq0WTVo6HtSLybW376rWBHp53QP/ZRdwJ5?=
 =?us-ascii?Q?zwNTR+9iFjgxGV1/EgFRqrS6tdyaTyvwDpjRfNUJyiOHlKUQyt3ycb8svb9s?=
 =?us-ascii?Q?ohmPjpUkvHEk+fQVjt8Q/50/QXdbmGUeNzKHp31aRmDLcGtmeAaprc8mVa6Z?=
 =?us-ascii?Q?SSe00uLuXXsV02VH6zergN7imf9YpCQwP2D008Bbnni5KsNecvTvkyACkn0+?=
 =?us-ascii?Q?JT+369F62KDOhA4Ni+t8SBdusIq0YyfmxD9wVvOmUyZGNeHLKYOWXtOefItO?=
 =?us-ascii?Q?RyDuFbeO9p6s6lJC+F90nZvrU5AmnIw5FUNaIN7yKEumW12/nv1yWNJwcEGJ?=
 =?us-ascii?Q?QaG27Hx0PvzaHOS55T2N+nVNkPS1+rcz+gYD742xD+wkos+g5oUqbp/eLTNM?=
 =?us-ascii?Q?tqY9Sn6NTa4j0eXbDVKBQdPVv1XT0vlOgOilNOoXLW6fdpirrAo8AJJvxdHl?=
 =?us-ascii?Q?Lny9lrhs0gcZcV71xLoJC1vwBiH1tZP+9sv1d1lQ8vylvKTZcSL5BsV9m6Eg?=
 =?us-ascii?Q?CDK2ma3b/wg0AfIdLdnYqI+z13mfKluejG/Wu415nZW8TPP3lzvTQ+ZH5JJS?=
 =?us-ascii?Q?dgEp1mAoEVz+UT5IggOZH5Xv43Jzle6dYJ3uJmhGiLC7zvjv9IUklSlYhi+9?=
 =?us-ascii?Q?qK8bw+s/EgV+CngPoBvnnpQXwygmt1vteVhiEJr6z13t8z9jFkUtzNB8barO?=
 =?us-ascii?Q?cInnudKiPT5pYuWFbIiAR190rytLGX1+U5+N1cdRDIXCe+NdMJEc3g7pGFS4?=
 =?us-ascii?Q?74Osc02tSNQoFgkzoIGQcCRdHtbolHK3tKzJWW5KdRw26vf425Oe8sdLqsGc?=
 =?us-ascii?Q?kqu8AnYrhgFW466NiLKl72FMFKUZSyDt/RudLqUQBlhTa7H4E2nTgWm71YjD?=
 =?us-ascii?Q?PwmtzaOBjgKl3ApUH3wFwsErVo0U0w/HAXfWaql5uScUI1xF83FJ4NaY7kqt?=
 =?us-ascii?Q?DD7CJqoOTpHh9qkUPo0vpQ2Cr2gbnreLal+hs46pw6kD5ckjPtmzHA3S6jMu?=
 =?us-ascii?Q?oVxoSWRKDgbcs1OVH+04XEYNgGhUDjk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013455a5-ee21-4fdd-2191-08da3d79eb54
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:27.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0QJe7EmaVozbCke14cycxubnYMy2LmBBJfD2pEd+HbFoCJq5KcpDtgk5skYl5KPr9Qe6WJkcvujalIcDMa5MTQ==
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
 drivers/net/wireless/celeno/cl8k/pci.h | 194 +++++++++++++++++++++++++
 1 file changed, 194 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/pci.h

diff --git a/drivers/net/wireless/celeno/cl8k/pci.h b/drivers/net/wireless/celeno/cl8k/pci.h
new file mode 100644
index 000000000000..ec6801c7c71b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/pci.h
@@ -0,0 +1,194 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_PCI_H
+#define CL_PCI_H
+
+#include "tx.h"
+
+#define CE_INVALID_SN 0xFFFF
+
+struct cl_chip;
+
+enum cl_bus_type {
+	CL_BUS_TYPE_PCI,
+};
+
+struct cl_driver_ops {
+	int (*msg_fw_send)(struct cl_hw *cl_hw, const void *msg_params, bool background);
+	void (*pkt_fw_send)(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+			    struct cl_tx_queue *tx_queue);
+};
+
+/* Struct used to store information about host buffers (DMA Address and local pointer) */
+struct cl_ipc_hostbuf {
+	ptrdiff_t hostid; /* Ptr to hostbuf client (ipc_host client) structure */
+	dma_addr_t dma_addr; /* Ptr to real hostbuf dma address */
+};
+
+/*
+ * Index in txdesc - updated by host on every push, used by firmware side
+ * Keep this structure aligned to 4-byte
+ */
+struct cl_ipc_txdesc_write_idx {
+	__le32 agg[IPC_MAX_BA_SESSIONS];
+	__le32 single[MAX_SINGLE_QUEUES];
+	__le32 bcmc;
+};
+
+struct cl_ipc_ring_indices {
+	/* Last copy of ipc txdesc write desc right after DMA push operation */
+	volatile struct cl_ipc_txdesc_write_idx txdesc_write_idx;
+	/*
+	 * new start sn - equal to last acknowledged sequence number + 1.
+	 * Updated by firmware and used by host.
+	 */
+	volatile __le32 new_ssn_idx[IPC_MAX_BA_SESSIONS];
+	volatile __le32 dtim_count[MAX_BSS_NUM];
+	/* Index in rxdesc array, updated by firmware on every payload push, used by host */
+	volatile __le32 rxdesc_write_idx[CL_RX_BUF_MAX];
+	/* Index in rxdesc array, updated by host on rxdesc copy completion, used by firmware */
+	volatile __le32 rxdesc_read_idx[CL_RX_BUF_MAX];
+	/* BSR data counters */
+	volatile __le32 bsr_data_ctrs[TID_MAX];
+};
+
+/* Structure used to store Shared Txring indices */
+struct cl_ipc_ring_indices_elem {
+	struct cl_ipc_ring_indices *indices;
+	dma_addr_t dma_addr;
+};
+
+struct cl_ipc_host_rxbuf {
+	/* Array of drv desc which holds the skb and additional data */
+	ptrdiff_t **ipc_host_rxdesc_ptr;
+	/* Address of payload for embedded push operation (part of rxdesc data) */
+	u32 *dma_payload_addr;
+	/* Dma pointer to array of DMA payload addresses */
+	__le32 dma_payload_base_addr;
+};
+
+/*
+ * struct tx_queues_dma_addr - ipc layer queues addresses casted to DMA addresses
+ *
+ * The ipc layer points to array of txdesc, there are:
+ * 'IPC_MAX_BA_SESSIONS' arrays for aggregation queues
+ * 'MAX_SINGLE_QUEUES' arrayes for singletons queues
+ * '1' arrays for broadcast/unicast queue
+ *
+ * Each one of this arrays should be copied compeletly to the FW, therefore we should
+ * cast all of the arrays to dma addresses.
+ */
+struct tx_queues_dma_addr {
+	__le32 agg[IPC_MAX_BA_SESSIONS];
+	__le32 single[MAX_SINGLE_QUEUES];
+	__le32 bcmc;
+};
+
+/* struct cl_ipc_tx_queues - ipc layer tx queues */
+struct cl_ipc_tx_queues {
+	struct txdesc *ipc_txdesc_agg[IPC_MAX_BA_SESSIONS];
+	struct txdesc *ipc_txdesc_single[MAX_SINGLE_QUEUES];
+	struct txdesc *ipc_txdesc_bcmc;
+	/* Mapping of the TXQ's addresses to DMA addresses */
+	struct tx_queues_dma_addr *queues_dma_addr;
+	/* DMA address of tx_queues_dma_addr */
+	u32 dma_addr;
+};
+
+struct cl_ipc_host_env {
+	/* Pointer to the shared environment */
+	struct cl_ipc_shared_env __iomem *shared;
+	/* TX ring indices (RD, WR idx & new_ssn) */
+	struct cl_ipc_ring_indices_elem *ring_indices_elem;
+	/* RX buffers (rxdesc & dma_addr) */
+	ptrdiff_t *ipc_host_rxdesc_rxm[IPC_RXBUF_CNT_RXM];
+	ptrdiff_t *ipc_host_rxdesc_fw[IPC_RXBUF_CNT_FW];
+	struct cl_ipc_host_rxbuf rx_hostbuf_array[CL_RX_BUF_MAX];
+	/* Host last read idx */
+	u32 host_rxdesc_read_idx[CL_RX_BUF_MAX];
+	/* Fields for Radar events handling */
+	struct cl_ipc_hostbuf radar_hostbuf_array[IPC_RADAR_BUF_CNT];
+	u8 radar_host_idx;
+	/* Fields for Emb->App MSGs handling */
+	struct cl_ipc_hostbuf e2a_msg_hostbuf_array[IPC_E2A_MSG_BUF_CNT];
+	u8 e2a_msg_host_idx;
+	/* Fields for Debug MSGs handling */
+	struct cl_ipc_hostbuf dbg_hostbuf_array[IPC_DBG_BUF_CNT];
+	u8 dbg_host_idx;
+	/* IPC queues */
+	struct cl_ipc_tx_queues tx_queues;
+	struct cl_ipc_enhanced_tim enhanced_tim;
+	/* Fields for single confirmation handling */
+	u8 *cfm_virt_base_addr;
+	dma_addr_t cfm_dma_base_addr;
+	/* Index used that points to the first used CFM */
+	u32 cfm_used_idx;
+	/* Tasklets */
+	struct tasklet_struct rxdesc_tasklet;
+	struct tasklet_struct tx_single_cfm_tasklet;
+	struct tasklet_struct tx_agg_cfm_tasklet;
+	struct tasklet_struct msg_tasklet;
+	struct tasklet_struct dbg_tasklet;
+	struct tasklet_struct bcn_tasklet;
+};
+
+/* Structure used to store information regarding Debug msg buffers in the driver */
+struct cl_dbg_elem {
+	struct cl_ipc_dbg_msg *dbgbuf_ptr;
+	dma_addr_t dma_addr;
+};
+
+struct cl_debug_info {
+	struct mutex mutex;
+	struct dbg_info *buf;
+	dma_addr_t dma_addr;
+	int bufsz;
+	struct timespec64 trigger_tstamp;
+};
+
+struct cl_rx_elem {
+	int passed;
+	struct sk_buff *skb;
+	dma_addr_t dma_addr;
+};
+
+int cl_ipc_init(struct cl_hw *cl_hw);
+void cl_ipc_recovery(struct cl_hw *cl_hw);
+void cl_ipc_deinit(struct cl_hw *cl_hw);
+void cl_ipc_stop(struct cl_hw *cl_hw);
+int cl_ipc_rx_elem_alloc(struct cl_hw *cl_hw, struct cl_rx_elem *rx_elem, u32 size);
+void cl_ipc_msgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid, dma_addr_t hostbuf);
+void cl_ipc_rxbuf_push(struct cl_ipc_host_env *ipc_env, struct cl_rx_elem *rx_elem,
+		       u32 rxdesc_read_idx, u32 host_read_idx, enum rx_buf_type type);
+void cl_ipc_radarbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid, dma_addr_t hostbuf);
+void cl_ipc_dbgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid, dma_addr_t hostbuf);
+void cl_ipc_dbginfobuf_push(struct cl_ipc_host_env *ipc_env, dma_addr_t infobuf);
+
+struct cl_irq_stats {
+	unsigned long last_rx;
+	unsigned long last_tx;
+	unsigned long last_isr;
+	u32 last_isr_statuses;
+	u32 count_irq;
+	u32 ipc_success;
+};
+
+int cl_irq_request(struct cl_chip *chip);
+void cl_irq_free(struct cl_chip *chip);
+void cl_irq_status(struct cl_hw *cl_hw, u32 status);
+void cl_irq_enable(struct cl_hw *cl_hw, u32 value);
+void cl_irq_disable(struct cl_hw *cl_hw, u32 value);
+int cl_msg_pci_msg_fw_send(struct cl_hw *cl_hw, const void *msg_params,
+			   bool background);
+void cl_rx_pci_init(struct cl_hw *cl_hw);
+void cl_rx_pci_deinit(struct cl_hw *cl_hw);
+void cl_rx_pci_desc_handler(struct cl_hw *cl_hw);
+void cl_rx_pci_desc_tasklet(unsigned long data);
+int cl_tx_release_skbs_from_cfm(struct cl_hw *cl_hw, u8 queue_idx, u16 new_ssn);
+void cl_tx_pci_single_cfm_tasklet(unsigned long data);
+void cl_tx_pci_agg_cfm_tasklet(unsigned long data);
+void cl_tx_pci_pkt_fw_send(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr,
+			   struct cl_tx_queue *tx_queue);
+
+#endif /* CL_PCI_H */
-- 
2.36.1

