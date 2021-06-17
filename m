Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F2C3AB82A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhFQQFV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:21 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233552AbhFQQFF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3SaecPHvfvj4Y4g2WjGllovHShWutcUajm/bjfFfUseLmD2GUT7Vj9Q7c2iMXHY7CL1Bd1YZeBSsH8zhAaguLL89dQq7Hh5ogz7+3JuReHXOS9SmYjtQ+/lw80XqacHlOLupJ6zPcekqlSxMEeScspaya+ugjj1tvsu2CzecyM6fYMsqj2OutBIvlzOibKQo1mFCOd+yIdKX57wn9+iuNfNMoelHfxQePFqCaVppc3xO2ZSeIXgmIewU0USpqJtinArBUNalstjMSRGkOrey2nwQkqEcEux5OYRMGV/UTBCeyduL6XEwpn8vyZd/BfPlq+htqC/xU9l3TDSyUWPMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYPlY+qHWUL8vYRwlXSiBfYBKqVsJRuPj8OyYZdru+I=;
 b=h4R3EdKaBLvNO7XFhZxDhoNqcieYSYE8inTGFXPjU7jfh62sg1DgFk2p6FWBi39fvUv8+cbj5jAOBF/Q93m57TsGjelzz1iDWXLliY2RV1PmFU9A+V1sV795vT0UDlNdY4L6JKmHIVWNmzi0WjUNZEas4mHjN+ne++JI/Og4JXu4pHZ4DCsBgXFr6MQLGA/75fjZGWCx8v+DHrfm2F9ju4RlIp5bM2FrLJCZaP3SYTmnki7j3BGq6PG5YIW4Ud99BE4Dk0doIE8l5QjOmdW87M07KouxLS3ndZhXBivnnvIXQFx8UijX62vEVD1baAowFk/LBCogfEiBuT3eey7yKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYPlY+qHWUL8vYRwlXSiBfYBKqVsJRuPj8OyYZdru+I=;
 b=LDYuoYIDLHw/TYOad1we5lCfRJ/IYv1GhoenJ3X6mNTpUf9RGRLrWLYpXqf2mVFog5c8Bd4PAzMnNhTNNVeaplt5xJkvRclbdlZcmjIT4D10tNp5V5awc084AwUfEfmxrQJ8FlzPmfEJdgee3Q+4DvYqaxra4B4WM4H2rO1gid4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:54 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:54 +0000
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
Subject: [RFC v1 018/256] cl8k: add bus/pci/ipc.h
Date:   Thu, 17 Jun 2021 15:58:25 +0000
Message-Id: <20210617160223.160998-19-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c88e060d-a13a-4692-701c-08d931a95d82
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499E9548452A8C16F7765E2F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EdpuSOyB4cis81Na18i0dozBc9SnyGDWUNHluKAD7CT9I5rTSUu2JEeWKE2R/Qzmd1SPyVSapCBa1gFlwkdCX6UxZhJyRKkubhn3CIS9BpJDRia1LzLfUjDyYPtBxkyf8VKeWhSZp9LQgck/P/EhKmIPImXcpPaiuR7bx1aZUAwGa0NYl8x/Vv7SSg3TVGENCqN5rowbnVIpFnGycEU0CS9EUaVgcCxoZJ0cH5s9Q3oWL6ctbiDg2IJQ9f+VJnU/WAVscTTZFuSwO66CyWuxARmZ30LLZ80kPemQbPgtgWVbT6woCFP7yskgsDpwVbxGWoU93DgXr7LtVD3h2YEi/rZfALOHuDMQeKlyIGYV0NUQvgzuPpDyw7EL9g+x4vLRks6V9XdkKymYDDWWJci0Iv2w24LYecCFZB9xK5zhUbwOhsIfYdfLHh4clvDSG7P7nwhThh1/Y1iP/KvKJFTj0adE8oJVDSV5qFmVVxbpZo/jAfIYwhlZr277O0Fp8BQzBNxYliq4ffUevI4WXzgD5SL0Q1rX8+R0q31IxZ/EQspnCpCC8WLIaRmTJCD4IV5nQEw1AWYftMHoDSsvJ+78sMwFCamZ2IJNA9JFqTLu3matQ/umxfadbK1vZpHtf5Oa99vKB94F84JDkUMNAgT1JiXmI+NRLQW8CIhG6JaYPZIsorw4fApmDN3MK4JGPw/kOCPhYDVEG4PrJpqXxVop7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+O/4z1JsRQx52JIzEPahvJ821do/oAiGwArA8qM/PClyb2FktV4Ak8gEiKgM?=
 =?us-ascii?Q?QZF3gozjpMgX1WkwDmwrNbSINh87toDv+/F1LRShP5WnOr5NiTUmae4mR51W?=
 =?us-ascii?Q?6oVyXeAqVEcdpulP56H1zsVk8Q1a8c9wUfEQRuZhBiyuUCILZHoEeadG6tNA?=
 =?us-ascii?Q?FU6yGmz8HWKPM9zCHmC8yvp3y5y4/xpbrCT+WsiwjguFL6ZXvSd8Dx23iLua?=
 =?us-ascii?Q?T2tQP0oG4GpntBCEDZ86IEG7Dlg0JGHl0+Mcrcek0ja6++dax8burCbZFeYo?=
 =?us-ascii?Q?UQd/N2RVwVNy1xOMSRwSBgpCS0is7YNeP86trQ+51RJsC6628iGU0rhI32EM?=
 =?us-ascii?Q?j6Rj9KE9cxJQZ/zb5KuMp0bqQ+ravvnQqdLtgBRWK7r6MsIt4pRUcv7MPasc?=
 =?us-ascii?Q?Wmq/UT6FmSYWJgVKWmS/aVKsd2Sga+zQhkPOEJsFu8HvsSOJGBAuTsHAiqbL?=
 =?us-ascii?Q?x8Wh2mSxzE8PXsuxq4IotzdXil+0AgIZ3zAzsdK8Ya70F6/zEXiw49JGCo3u?=
 =?us-ascii?Q?FAlZHmCXypdxgcUAIij+Wicj6yWDspR5BZon4gG8dXPtizgOcKyco2C3o8aU?=
 =?us-ascii?Q?O3vzWDK6S/dy6EFmsfG0nTSmEBTKSmcO9iA03IvX8LSpIO7h6ZE0ggAM2r9u?=
 =?us-ascii?Q?SvjQp/IHEvuT/FsfsFyQI6ew4qhkMXFlLpDOMgL3HBv9FUIY/YhI8txR7adD?=
 =?us-ascii?Q?G6EVJBvMl67Mff9ehiGVxCF+l0dHQz4vNa6/nvA8ic65fhevny/ClFhEQQOx?=
 =?us-ascii?Q?o7zrsijg5fHlEDmD2f5IvyvU8nfSLrjazFI7x9HZqQcn3TddnoMSqecZbR+t?=
 =?us-ascii?Q?DDiHTh0z4NGP69uBYLssDDvhMCGrgRhUPsvDFt91lfbKsyf1C/9z1mEhHfPk?=
 =?us-ascii?Q?hPMVyDeloHIxLh4vh7VtWbfEKRJl+zEogz73p728S05JUn4CuNo5fhTsbV5+?=
 =?us-ascii?Q?zDdgxNvaE5hTev6POmSaYYb8Y0sbsgSJKW4ygcJ/hrkh2H9c+Ls5Fwa4FomU?=
 =?us-ascii?Q?ckGJoMgTkLM7lxNXgcHMIMMDYDmBlQB8r9feDrA5aHO2Z1BH9kcz3xQZ4do3?=
 =?us-ascii?Q?3pvBvIY6D8tQUJ6KY4vY7q2RjaUPafiUNmEdwdqMB/XxKSyAxP31sL7464VU?=
 =?us-ascii?Q?ZdOgdHhyCOj+PbHFQ4yTOpZzhUGPrI8u+OujHiqqe2+apmxKY6P3zgIgd5+C?=
 =?us-ascii?Q?D0vDypFj+TqcsCDsfWlAUBO/xMmhXZlZ4SfIvvjOJXA+LF1ZGKN5VSEvk3rK?=
 =?us-ascii?Q?aMnBKf7iGG22yQeHAwWytGC86l7VCnM/uqsBCKPLPfavJzZCBQ1VefrPaQX4?=
 =?us-ascii?Q?2GeeeX/Lbf9CDqlBOTD8bvJU?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88e060d-a13a-4692-701c-08d931a95d82
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:53.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: laXFlaGMi4FBIA2HoWjAid6UDtUSTYH27IuP4ofKTTONGLuqp+jlJY6cX3d56xf5PtZvxO9hH1g5ZQuq8SaOUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/bus/pci/ipc.h    | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/ipc.h

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/ipc.h b/drivers/net/w=
ireless/celeno/cl8k/bus/pci/ipc.h
new file mode 100644
index 000000000000..81cdae55f467
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/ipc.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_IPC_H
+#define CL_IPC_H
+
+#include "ipc_shared.h"
+#include "hw.h"
+
+/* Struct used to store information about host buffers (DMA Address and lo=
cal pointer) */
+struct cl_ipc_hostbuf {
+       ptrdiff_t hostid; /* Ptr to hostbuf client (ipc_host client) struct=
ure */
+       dma_addr_t dma_addr; /* Ptr to real hostbuf dma address */
+};
+
+/*
+ * Index in txdesc - updated by host on every push, used by firmware side
+ * Keep this structure aligned to 4-byte
+ */
+struct cl_ipc_txdesc_write_idx {
+       u32 agg[IPC_MAX_BA_SESSIONS];
+       u32 single[MAX_SINGLE_QUEUES];
+       u32 bcmc;
+};
+
+struct cl_ipc_ring_indices {
+       /* Last copy of ipc txdesc write desc right after DMA push operatio=
n */
+       volatile struct cl_ipc_txdesc_write_idx txdesc_write_idx;
+       /*
+        * new start sn - equal to last acknowledged sequence number + 1.
+        * Updated by firmware and used by host.
+        */
+       volatile u16 new_ssn_idx[IPC_MAX_BA_SESSIONS];
+       volatile u8 dtim_count[MAX_BSS_NUM];
+       /* Index in rxdesc array, updated by firmware on every payload push=
, used by host */
+       volatile u32 rxdesc_write_idx[CL_RX_BUF_MAX];
+       /* Index in rxdesc array, updated by host on rxdesc copy completion=
, used by firmware */
+       volatile u32 rxdesc_read_idx[CL_RX_BUF_MAX];
+       /* BSR data counters */
+       volatile u32 bsr_data_ctrs[TID_MAX];
+};
+
+/* Structure used to store Shared Txring indices */
+struct cl_ipc_ring_indices_elem {
+       struct cl_ipc_ring_indices *indices;
+       dma_addr_t dma_addr;
+};
+
+struct cl_ipc_host_rxbuf {
+       /* Array of drv desc which holds the skb and additional data */
+       ptrdiff_t **ipc_host_rxdesc_ptr;
+       /* Address of payload for embedded push operation (part of rxdesc d=
ata) */
+       u32 *dma_payload_addr;
+       /* Dma pointer to array of DMA payload addresses */
+       __le32 dma_payload_base_addr;
+};
+
+/*
+ * struct tx_queues_dma_addr - ipc layer queues addresses casted to DMA ad=
dresses
+ *
+ * The ipc layer points to array of txdesc, there are:
+ * 'IPC_MAX_BA_SESSIONS' arrays for aggregation queues
+ * 'MAX_SINGLE_QUEUES' arrayes for singletons queues
+ * '1' arrays for broadcast/unicast queue
+ *
+ * Each one of this arrays should be copied compeletly to the FW, therefor=
e we should
+ * cast all of the arrays to dma addresses.
+ */
+struct tx_queues_dma_addr {
+       u32 agg[IPC_MAX_BA_SESSIONS];
+       u32 single[MAX_SINGLE_QUEUES];
+       u32 bcmc;
+};
+
+/* struct cl_ipc_tx_queues - ipc layer tx queues */
+struct cl_ipc_tx_queues {
+       struct txdesc *ipc_txdesc_agg[IPC_MAX_BA_SESSIONS];
+       struct txdesc *ipc_txdesc_single[MAX_SINGLE_QUEUES];
+       struct txdesc *ipc_txdesc_bcmc;
+       /* Mapping of the TXQ's addresses to DMA addresses */
+       struct tx_queues_dma_addr *queues_dma_addr;
+       /* DMA address of tx_queues_dma_addr */
+       u32 dma_addr;
+};
+
+struct cl_ipc_host_env {
+       /* Pointer to the shared environment */
+       struct cl_ipc_shared_env *shared;
+       /* TX ring indices (RD, WR idx & new_ssn) */
+       struct cl_ipc_ring_indices_elem *ring_indices_elem;
+       /* RX buffers (rxdesc & dma_addr) */
+       ptrdiff_t *ipc_host_rxdesc_rxm[IPC_RXBUF_CNT_RXM];
+       ptrdiff_t *ipc_host_rxdesc_fw[IPC_RXBUF_CNT_FW];
+       struct cl_ipc_host_rxbuf rx_hostbuf_array[CL_RX_BUF_MAX];
+       /* Host last read idx */
+       u32 host_rxdesc_read_idx[CL_RX_BUF_MAX];
+       /* Fields for Radar events handling */
+       struct cl_ipc_hostbuf radar_hostbuf_array[IPC_RADAR_BUF_CNT];
+       u8 radar_host_idx;
+       /* Fields for Emb->App MSGs handling */
+       struct cl_ipc_hostbuf e2a_msg_hostbuf_array[IPC_E2A_MSG_BUF_CNT];
+       u8 e2a_msg_host_idx;
+       /* Fields for Debug MSGs handling */
+       struct cl_ipc_hostbuf dbg_hostbuf_array[IPC_DBG_BUF_CNT];
+       u8 dbg_host_idx;
+       /* IPC queues */
+       struct cl_ipc_tx_queues tx_queues;
+       struct cl_ipc_enhanced_tim enhanced_tim;
+       /* Fields for single confirmation handling */
+       u8 *cfm_virt_base_addr;
+       dma_addr_t cfm_dma_base_addr;
+       /* Index used that points to the first used CFM */
+       u32 cfm_used_idx;
+       /* Tasklets */
+       struct tasklet_struct rxdesc_tasklet;
+       struct tasklet_struct tx_single_cfm_tasklet;
+       struct tasklet_struct tx_agg_cfm_tasklet;
+       struct tasklet_struct msg_tasklet;
+       struct tasklet_struct dbg_tasklet;
+};
+
+int cl_ipc_init(struct cl_hw *cl_hw);
+void cl_ipc_recovery(struct cl_hw *cl_hw);
+void cl_ipc_reset(struct cl_hw *cl_hw);
+void cl_ipc_deinit(struct cl_hw *cl_hw);
+void cl_ipc_stop(struct cl_hw *cl_hw);
+int cl_ipc_rx_elem_alloc(struct cl_hw *cl_hw, struct cl_rx_elem *rx_elem, =
u32 size);
+void cl_ipc_msgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid,=
 dma_addr_t hostbuf);
+void cl_ipc_rxbuf_push(struct cl_ipc_host_env *ipc_env, struct cl_rx_elem =
*rx_elem,
+                      u32 rxdesc_read_idx, u32 host_read_idx, enum rx_buf_=
type type);
+void cl_ipc_radarbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hosti=
d, dma_addr_t hostbuf);
+void cl_ipc_dbgbuf_push(struct cl_ipc_host_env *ipc_env, ptrdiff_t hostid,=
 dma_addr_t hostbuf);
+void cl_ipc_dbginfobuf_push(struct cl_ipc_host_env *ipc_env, dma_addr_t in=
fobuf);
+
+#endif /* CL_IPC_H */
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

