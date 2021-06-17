Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A10A3AB833
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhFQQF3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:29 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233543AbhFQQFR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Noo9wRAQi+uKNt+YByopryEpJHhSvK3EpQBdH7gAqFhliQ2ASInnUtgwFBr+OFLBiPRV6r6ApdoeILrhCt9ZZ0El15vOr6q1oIMEeq9sVoECpn11n8jSHDh/qsQSSV5RhyhG6h9RhbjQU67FYBcLUPHyeRV9MGA/t/+iUvb7l975fvhdhKyO4luJoPHy5+LldwvujNso7ZE+LDC5yDvksZ4EJOFuvjZ6bAfDezX9YRAp4lKrEJWD+NZKpKJv+gxNNpqTIxc4NQu6X/8z9Olb4yHsK6+LkjNdqmGArOCSlMIedCo1YbJxkY7xqxn8A5S/SxVdCA+KrkKqFTdmpyWgOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD/41sEriRtup+4fF6oWf/011z9oOz3y+id2pp+iDXU=;
 b=BvAurTV5v5nlLbnkAoa+F083pb7pUpATaucMCirPwcx1LRudO/t+FGEzm+J4tKFrAur799YueG5tTJ5CKD+rrAVAdPC3jBEqA8mqcHA3XOcTY9jMk//q97nYDu7pCPONt9ZDD8Li2UzEOlJViIboP1oZfsl53sdQOPSFPwYU9y8CGyyywYAx+lCKXp7Lf9Q/4FwGHHiyj12r93k4KRdRBXrhCIyJFQIFcZQLHEH6eKOEemm+elR16s0w9m9ruEvVZL4K51rCYEZrZGQRijntOYgKmESmL35csbtzW47rrS60rar+VVMvJVtVwMlFKsdSPyw7zctLElkctrhps5ijOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iD/41sEriRtup+4fF6oWf/011z9oOz3y+id2pp+iDXU=;
 b=XcJHrTCwOWj52AOhemfOhHXvLnU9pHGqtPcetxTMGRFpepKT+2m+58YPcxJcuveJSDNG//eN3nO/Odyor9hx7p4+yL24sQYiJO4j6PXhLE4wWXV19Uiy2EU1GnkGlOFMhu86dLufQ8ci/fJXCoiner4RlO2ouh5raVHH74kAMZ8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:02 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:02 +0000
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
Subject: [RFC v1 026/256] cl8k: add bus/pci/tx_pci.c
Date:   Thu, 17 Jun 2021 15:58:33 +0000
Message-Id: <20210617160223.160998-27-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a8b3a71-8792-45c4-6066-08d931a962b2
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499C1BA6666407B9C549C3EF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cy2zA+p1JFQhpk9byWFstmicGB536LdvixeN0cHy8aEpj8Wd3t6qaWDQ+AJzDe/AGuTnY13hvknyzAEowDVEuEt4tUvZGTJUWAUPWgnFmYpZMzPGEwXwsn3MPJdIwrlAgd7TJs5mo//bXHAsWwDTJl//EOfol/06xcgED6nm1LUvhBeATW8fttLY9lhv2c9V4n/Ts2F/hkaNhVGnv22B2J0lPHeQdAYk6byGa9zCMCZYq7MlPvo/RLeKFmcQBN5hTa3PdA+RB8cpJAFvaBAZtqRsut3i078C02zi7K3x1o1ErvgwcXkP8BzlBgF0HK1nsLqLW7qGsMe2PNNIQyl0zBG9C+i6IJzZymqfeuGfGWcT/I+UvuAXDZDKZdgHMwmxHvmRIFuLw0AZQwEl/KWitHU8BYPKHW9er80sxfwFzys+btolmmCqnMhd9fErJQKMpcufuSzL9DCcZYYZjmaeLpYUOIxIcAQYAnqTOYhZrt2rluUX0bUAj5qjzzA91Hd22aLyj0LTVO+z/uUxpYp8kOf8UmRWkU35ok3X8cskoXyk8yT5OOCKxPpxefFhm6ZT15pfkG/vEM3v6sA0iUFzHlDIEpez3VaGPP1U+2hJuqnDzm6Zxe1hJH1cQUDa9oa0H+aHgS1W7XWCiOUB0gzAbUGxKpHjTkDOKGU3nzTQI9YBWpb/Moqiz8Qs5urNtWhyJKvHiGpr+0liy9TOgHQCNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YYXjy5PV1H2Sbg0m2m9KHXdkyTvu4fjjBjVyQy0x5b3bYL0TKnyXn9p/f858?=
 =?us-ascii?Q?hGHIFIDpyOE42FvwJdlg4BcUj2R7cfXFifpvFD3bd2YnHX7d0SiWOsmlPJMn?=
 =?us-ascii?Q?v8g2Ze1pNrUbCsnnAaSPNVmq5MdoZbKFdTQECkFCVpMv4mhsrHCms8m3Aci2?=
 =?us-ascii?Q?zVJfuQl+sWbDT1x7D3zZORls5K7rBeBKqgF0cUF55ALzuHPUNQ/a2xNgNv3G?=
 =?us-ascii?Q?/d1PEf8dzzBn11B7LxV3nQ/8a1nas1rf3fT7zkIsFd9Y0u/vBtaFhlinItsi?=
 =?us-ascii?Q?Tko+ssaLJxMeXkVLtp4+HEITZaN4cvkKqMiIjSF6kqBT4z4bNmIXixW9WdXS?=
 =?us-ascii?Q?75Ttg6b1tkiumHpi+Jx9nLop87k9WMY077kXGaa7HOlrdBaZ6kecaVdtKX3i?=
 =?us-ascii?Q?dOVxO01GbyZxQzZR5lNYqLhbAPoSSRXKBS//kgTg4nn9E/wbKeQn+vbolehl?=
 =?us-ascii?Q?65A8ZXGujHBzdpPDnp7txNaCggVE8aZ1tvHIwNv8DDm70U9qh2FSdJbxaNtc?=
 =?us-ascii?Q?yT3DT45PGrqO7H5H/GwlfOxR1ouHaSQI46bEqrz0Owepm8Pz1asrcmTzY82C?=
 =?us-ascii?Q?IIE/kuyd0vEq06I9+/CcfyQmB8yPbSNTQu6kXs9x4S1r0GfndIO9Le1znwsR?=
 =?us-ascii?Q?Ok9BKTs4WMRUam9n8WyuVLZ0c1bqqbCEC1sdYiHw26U3WIlg/xLVLVZOs/Vd?=
 =?us-ascii?Q?y8loudU6P4XFwduuef93sjolhRB3MTiu6ex6k9x2XaG2ELKnJ7qUNjr/QMBv?=
 =?us-ascii?Q?z1i8WzYIWeLzJte+z+kQeloy4GJwva02Q4+vpMNH1mDLohrWPeRPfejX/quN?=
 =?us-ascii?Q?IeSEwEtbijKwIFEfF5mQZ3SKPrcadJXlrWod6ll7ME/K20zdyeS9ATJ0mtp9?=
 =?us-ascii?Q?A2CZbFNXq/8pO6j593bcV8PLDgCZNpIbP54+kUGUGa0X0VnzpxKX4pjCoVuq?=
 =?us-ascii?Q?8l+lhAdgpCjUqia17hwOwHdwxAbzKeq4V2/3FaLxKErXSw7CFPPdFy5q7ziE?=
 =?us-ascii?Q?2ZYqNsaoKANZTlq7RboGxpjUlPE1kxw28Y6lHmTP66br02zJcd0tYdrFCLOC?=
 =?us-ascii?Q?b+n5OX1AWMovyY/dWpp4iojtekyjMSx/Ow2jVFgyjZpe2zeb+5ayjRUULaIq?=
 =?us-ascii?Q?Ithy8Sun5SlgWak6Gqew8dOrF5mAoChgGLAFKZ7gnwV0Y7Y5x7krGu3Z0wTq?=
 =?us-ascii?Q?l2l2QK3i6zQHyh3wI2husylZpRx5yxxzr9NgeS0VilDYaSbfizt4+8pIvtnm?=
 =?us-ascii?Q?BQmcPMYF3z16RxVwNY2jAsNhQtGzddizV9tT2tS2qkWwG6jSxBYJAMPxF5zm?=
 =?us-ascii?Q?4cQ9kirOQEJAfD9Uf6AMnA7O?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8b3a71-8792-45c4-6066-08d931a962b2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:02.5981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnDbyZWVlmMt8CG3z85O5diYt+x3t26SGqSB8YfxXYmkQZQ82tlV7Dt8nMIg99gd59DBM7G482YtUMkZ85u4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/bus/pci/tx_pci.c | 434 ++++++++++++++++++
 1 file changed, 434 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.c

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.c b/drivers/ne=
t/wireless/celeno/cl8k/bus/pci/tx_pci.c
new file mode 100644
index 000000000000..4aeaa6a74777
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/tx_pci.c
@@ -0,0 +1,434 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <net/mac80211.h>
+#include "bus/pci/tx_pci.h"
+#include "bus/pci/ipc.h"
+#include "ipc_shared.h"
+#include "chip.h"
+#include "tx/tx.h"
+#include "sta.h"
+#include "enhanced_tim.h"
+#include "tx/bcmc_cfm.h"
+#include "tx/single_cfm.h"
+#include "tx/agg_cfm.h"
+#include "tx/tx_queue.h"
+#include "tx/agg_tx_report.h"
+#include "tx/sw_txhdr.h"
+#include "tx/tx_inject.h"
+#include "bus/pci/irq.h"
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+static void cl_tx_ipc_txdesc_populate(struct cl_hw *cl_hw, struct txdesc *=
txdesc,
+                                     u8 queue_type, u32 ipc_queue_idx)
+{
+       /*
+        * 1) Request allocation of txdesc associated with queue type and i=
ndex from the ipc layer.
+        * 2) Populate ipc-txdesc with the received txdesc.
+        * 3) Increase write index - (must be last action since FW fetch WR=
 idx first).
+        */
+       u32 *write_idx_ptr =3D NULL;
+       struct txdesc *ipc_txdesc =3D NULL;
+       struct cl_ipc_ring_indices *indices =3D cl_hw->ipc_env->ring_indice=
s_elem->indices;
+       struct cl_ipc_txdesc_write_idx *txdesc_write_idx =3D
+               (struct cl_ipc_txdesc_write_idx *)&indices->txdesc_write_id=
x;
+       u32 write_idx =3D 0;
+       u32 masked_write_idx =3D 0;
+
+       switch (queue_type) {
+       case QUEUE_TYPE_AGG:
+               ipc_txdesc =3D cl_hw->ipc_env->tx_queues.ipc_txdesc_agg[ipc=
_queue_idx];
+               write_idx =3D le32_to_cpu(txdesc_write_idx->agg[ipc_queue_i=
dx]);
+               write_idx_ptr =3D &txdesc_write_idx->agg[ipc_queue_idx];
+               masked_write_idx =3D write_idx & (cl_hw->max_agg_tx_q_size =
- 1);
+               break;
+       case QUEUE_TYPE_SINGLE:
+               ipc_txdesc =3D cl_hw->ipc_env->tx_queues.ipc_txdesc_single[=
ipc_queue_idx];
+               write_idx =3D le32_to_cpu(txdesc_write_idx->single[ipc_queu=
e_idx]);
+               write_idx_ptr =3D &txdesc_write_idx->single[ipc_queue_idx];
+               masked_write_idx =3D write_idx & (IPC_TXDESC_CNT_SINGLE - 1=
);
+               break;
+       case QUEUE_TYPE_BCMC:
+               ipc_txdesc =3D cl_hw->ipc_env->tx_queues.ipc_txdesc_bcmc;
+               write_idx =3D le32_to_cpu(txdesc_write_idx->bcmc);
+               write_idx_ptr =3D &txdesc_write_idx->bcmc;
+               masked_write_idx =3D write_idx & (IPC_TXDESC_CNT_BCMC - 1);
+               break;
+       default:
+               cl_dbg_verbose(cl_hw, "undefined queue type %u\n", queue_ty=
pe);
+               WARN_ON(true);
+       }
+
+       ipc_txdesc +=3D masked_write_idx;
+
+       memcpy(ipc_txdesc, txdesc, sizeof(struct txdesc));
+
+       /*
+        * Update write pointer only after new txdesc copy is done since FW
+        * fetch WR pointer first, if not, FW might read and old txdesc sin=
ce
+        * WR index indicate txdesc is valid.
+        */
+       *write_idx_ptr =3D cpu_to_le32(write_idx + 1);
+}
+
+static int cl_tx_pci_agg_cfm_handler(struct cl_hw *cl_hw)
+{
+       struct cl_agg_cfm_queue *cfm_queue =3D NULL;
+       struct cl_tx_queue *tx_queue =3D NULL;
+       struct cl_ipc_ring_indices *indices =3D cl_hw->ipc_env->ring_indice=
s_elem->indices;
+       int total_cfm_handled =3D 0;
+       int free_space_add =3D 0;
+       u16 new_ssn =3D 0;
+       u16 prev_ssn =3D 0;
+       u8 used_cntr =3D 0;
+       u8 ba_queue_idx =3D 0;
+
+       for (ba_queue_idx =3D 0; ba_queue_idx < IPC_MAX_BA_SESSIONS; ba_que=
ue_idx++) {
+
+               spin_lock(&cl_hw->tx_lock_cfm_agg);
+
+               cfm_queue =3D &cl_hw->agg_cfm_queues[ba_queue_idx];
+               if (list_empty(&cfm_queue->head)) {
+                       spin_unlock(&cl_hw->tx_lock_cfm_agg);
+                       continue;
+               }
+
+               tx_queue =3D cfm_queue->tx_queue;
+               free_space_add =3D 0;
+               prev_ssn =3D cfm_queue->ssn;
+               new_ssn =3D le16_to_cpu(indices->new_ssn_idx[ba_queue_idx])=
;
+
+               /*
+                * Continue to free skb's until:
+                * 1. list is empty.
+                * 2. agg ssn is equal to new ssn received from ssn.
+                */
+               while (!list_empty(&cfm_queue->head) && (cfm_queue->ssn !=
=3D new_ssn)) {
+                       cl_agg_cfm_free_head_skb(cl_hw, cfm_queue, ba_queue=
_idx);
+                       free_space_add++;
+                       cfm_queue->ssn =3D ((cfm_queue->ssn + 1) & 0xFFF);
+               }
+
+               /* Sanity check. test if all skb's marked to be free. */
+               if (unlikely(cfm_queue->ssn !=3D new_ssn))
+                       cl_dbg_err(cl_hw,
+                                  "ssn diff - queue idx=3D%u, new ssn=3D%u=
, prev ssn=3D%u, cfm ssn=3D%u\n",
+                                  ba_queue_idx, new_ssn, prev_ssn, cfm_que=
ue->ssn);
+
+               spin_unlock(&cl_hw->tx_lock_cfm_agg);
+
+               if (free_space_add > 0) {
+                       spin_lock(&cl_hw->tx_lock_agg);
+
+                       if (tx_queue) {
+                               tx_queue->fw_free_space +=3D free_space_add=
;
+                               tx_queue->total_fw_cfm +=3D free_space_add;
+
+                               /*
+                                * If FW used all packets that driver pushe=
d to him,
+                                * clear the enhanced TIM bit.
+                                */
+                               if (cl_txq_is_fw_empty(tx_queue))
+                                       cl_enhanced_tim_clear_tx_agg(cl_hw,
+                                                                    ba_que=
ue_idx,
+                                                                    tx_que=
ue->hw_index,
+                                                                    tx_que=
ue->cl_sta,
+                                                                    tx_que=
ue->tid);
+                       }
+
+                       spin_unlock(&cl_hw->tx_lock_agg);
+
+                       total_cfm_handled +=3D free_space_add;
+               }
+
+               /* Optimization - avoid running the for loop IPC_MAX_BA_SES=
SIONS times */
+               used_cntr++;
+               if (used_cntr =3D=3D cl_hw->used_agg_queues)
+                       break;
+       }
+
+       return total_cfm_handled;
+}
+
+void cl_tx_pci_agg_cfm_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       int cfm_handled;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_tx_agg_cfm_tasklet_start(cl_hw->idx);
+#endif
+
+       cfm_handled =3D cl_tx_pci_agg_cfm_handler(cl_hw);
+
+       if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+               cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.txdesc_ind);
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_tx_agg_cfm_tasklet_end(cl_hw->idx, cfm_handled);
+#endif
+}
+
+static void cl_tx_pci_single_cfm_handler(struct cl_hw *cl_hw, u32 cfm_stat=
us,
+                                        u32 dma_addr, u32 single_queue_idx=
)
+{
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_tx_info *tx_info =3D NULL;
+       struct cl_hw_tx_status *status =3D (struct cl_hw_tx_status *)&cfm_s=
tatus;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       struct cl_tx_queue *tx_queue =3D NULL;
+       struct cl_sta *cl_sta =3D NULL;
+       unsigned long flags =3D 0;
+       u8 hw_queue;
+       bool is_bcn;
+
+       if (status->is_bcmc) {
+               spin_lock_irqsave(&cl_hw->tx_lock_bcmc, flags);
+               sw_txhdr =3D cl_bcmc_cfm_find(cl_hw, dma_addr, status->keep=
_skb);
+               tx_queue =3D &cl_hw->tx_queues.bcmc;
+       } else {
+               spin_lock_bh(&cl_hw->tx_lock_single);
+               sw_txhdr =3D cl_single_cfm_find(cl_hw, single_queue_idx, dm=
a_addr);
+               tx_queue =3D &cl_hw->tx_queues.single[single_queue_idx];
+       }
+
+       if (!sw_txhdr) {
+               cl_dbg_err(cl_hw, "Failed to find single cfm [single_queue_=
idx %u] status 0x%x\n",
+                          single_queue_idx, cfm_status);
+               goto out;
+       }
+
+       skb =3D sw_txhdr->skb;
+       tx_info =3D IEEE80211_SKB_CB(skb);
+       hw_queue =3D sw_txhdr->hw_queue;
+       is_bcn =3D sw_txhdr->is_bcn;
+
+       /*
+        * Used for beacon frames only !!
+        * if skb was already confirmed we do not need to inc FwFreeSpace c=
ounter
+        */
+       if (likely(!status->freespace_inc_skip)) {
+               tx_queue->total_fw_cfm++;
+               tx_queue->fw_free_space++;
+
+               /* Clear the TIM element if assoicated IPC queue is empty *=
/
+               if (!is_bcn && cl_txq_is_fw_empty(tx_queue)) {
+                       bool no_ps_buffer =3D
+                               (tx_info->flags & IEEE80211_TX_CTL_NO_PS_BU=
FFER) ? true : false;
+
+                       cl_sta_lock(cl_hw);
+                       cl_sta =3D cl_sta_get(cl_hw, sw_txhdr->sta_idx);
+                       cl_enhanced_tim_clear_tx_single(cl_hw, single_queue=
_idx, hw_queue,
+                                                       no_ps_buffer, cl_st=
a, sw_txhdr->tid);
+                       cl_sta_unlock(cl_hw);
+               }
+       } else  if (!is_bcn) {
+               cl_dbg_verbose(cl_hw, "should no be here - is_bcn=3D%d hw_q=
ueue=3D%d\n",
+                              is_bcn, hw_queue);
+       }
+
+       /*
+        * Used for beacon frames only !!
+        * if this flag is set, it means FW still need this beacon skb, the=
refore
+        * we do not free this skb.
+        */
+       if (unlikely(status->keep_skb)) {
+               if (!is_bcn)
+                       cl_dbg_verbose(cl_hw, "should not be here - is_bcn=
=3D%d hw_queue=3D%d\n",
+                                      is_bcn, hw_queue);
+               goto out;
+       }
+
+       dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA=
_TO_DEVICE);
+
+       /*
+        * If queue is not empty call cl_txq_sched() to
+        * transfer packets from the queue to firmware
+        */
+       if (!list_empty(&tx_queue->hdrs))
+               cl_txq_sched(cl_hw, tx_queue);
+
+       /* Cl_tx_inject_cfm() must be called inside the lock */
+       if (cl_tx_ctrl_is_inject(tx_info)) {
+               cl_sta_lock(cl_hw);
+               cl_sta =3D cl_sta_get(cl_hw, sw_txhdr->sta_idx);
+               if (cl_sta)
+                       cl_agg_tx_report_simulate_for_single(cl_hw, cl_sta,=
 status);
+               cl_sta_unlock(cl_hw);
+
+               cl_tx_inject_cfm(cl_hw);
+               dev_kfree_skb_any(skb);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+               goto out;
+       }
+
+       if (status->is_bcmc)
+               spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+       else
+               spin_unlock_bh(&cl_hw->tx_lock_single);
+
+       if (is_bcn) {
+               struct ieee80211_vif *vif =3D sw_txhdr->cl_vif->vif;
+
+               if (vif) {
+                       if (vif->csa_active &&
+                           ieee80211_beacon_cntdwn_is_complete(vif))
+                               ieee80211_csa_finish(vif);
+               }
+
+               consume_skb(skb);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+               return;
+       }
+
+       if (status->frm_successful && !(tx_info->flags & IEEE80211_TX_CTL_N=
O_ACK))
+               tx_info->flags |=3D IEEE80211_TX_STAT_ACK;
+
+       cl_sta_lock(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, sw_txhdr->sta_idx);
+
+       if (cl_sta) {
+               if (tx_queue->type !=3D QUEUE_TYPE_BCMC &&
+                   ieee80211_is_data(sw_txhdr->fc) &&
+                   !cl_tx_ctrl_is_eapol(tx_info))
+                       cl_agg_tx_report_simulate_for_single(cl_hw, cl_sta,=
 status);
+
+               cl_tx_check_start_ba_session(cl_hw, cl_sta->stainfo, skb);
+       }
+
+       cl_sta_unlock(cl_hw);
+
+       if (tx_info->ack_frame_id)
+               ieee80211_tx_status(cl_hw->hw, skb);
+       else
+               consume_skb(skb);
+
+       cl_sw_txhdr_free(cl_hw, sw_txhdr);
+       return;
+
+out:
+       if (status->is_bcmc)
+               spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+       else
+               spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_tx_pci_single_cfm_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_cfm_msg *msg =3D NULL;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_tx_pci_single_cfm_tasklet_start(cl_hw->idx, ipc_env-=
>cfm_used_idx);
+#endif
+
+       msg =3D (struct cl_ipc_cfm_msg *)(ipc_env->cfm_virt_base_addr) +
+               (ipc_env->cfm_used_idx % IPC_CFM_CNT);
+
+       while (msg && msg->dma_addr) {
+               u32 cfm_used_idx =3D ipc_env->cfm_used_idx++;
+
+               cl_tx_pci_single_cfm_handler(cl_hw,
+                                            le32_to_cpu(msg->status),
+                                            le32_to_cpu(msg->dma_addr),
+                                            le32_to_cpu(msg->single_queue_=
idx));
+               msg->dma_addr =3D 0;
+               ipc_env->shared->cfm_read_pointer =3D cpu_to_le32(cfm_used_=
idx);
+               msg =3D (struct cl_ipc_cfm_msg *)(ipc_env->cfm_virt_base_ad=
dr) +
+                       (ipc_env->cfm_used_idx % IPC_CFM_CNT);
+       }
+
+       /* Enable the Tx CFM interrupt bit */
+       if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+               cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.txcfm);
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_tx_pci_single_cfm_tasklet_end(cl_hw->idx, ipc_env->c=
fm_used_idx);
+#endif
+}
+
+void cl_tx_pci_pkt_fw_send(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txh=
dr,
+                          struct cl_tx_queue *tx_queue)
+{
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+       struct txdesc *txdesc =3D &sw_txhdr->txdesc;
+       struct tx_host_info *host_info =3D &txdesc->host_info;
+       struct cl_sta *cl_sta =3D sw_txhdr->cl_sta;
+       struct cl_vif *cl_vif =3D sw_txhdr->cl_vif;
+       u8 hw_queue =3D sw_txhdr->hw_queue;
+       u16 a2e_trigger_bit_pos;
+       u8 tid =3D sw_txhdr->tid;
+       u8 queue_type =3D tx_queue->type;
+       bool no_ps_buffer =3D !!(tx_info->flags & IEEE80211_TX_CTL_NO_PS_BU=
FFER);
+       u16 ipc_queue_idx =3D tx_queue->index;
+       bool is_mgmt =3D ieee80211_is_mgmt(sw_txhdr->fc);
+       u8 *cpu_addr =3D (u8 *)sw_txhdr->skb->data -
+                      ((host_info->host_padding & 1) * 2);
+       dma_addr_t dma_addr =3D dma_map_single(cl_hw->chip->dev, cpu_addr,
+                                            sw_txhdr->map_len, DMA_TO_DEVI=
CE);
+
+       if (WARN_ON(dma_mapping_error(cl_hw->chip->dev, dma_addr))) {
+               tx_queue->dump_dma_map_fail++;
+
+               if (queue_type =3D=3D QUEUE_TYPE_SINGLE) {
+                       if (!is_mgmt)
+                               cl_vif->sequence_number =3D DEC_SN(cl_vif->=
sequence_number);
+
+                       cl_tx_single_free_skb(cl_hw, sw_txhdr->skb);
+               } else {
+                       if (queue_type =3D=3D QUEUE_TYPE_AGG) {
+                               struct cl_baw *baw =3D &cl_sta->baws[tid];
+
+                               baw->tid_seq =3D DEC_SN(baw->tid_seq);
+                       }
+
+                       dev_kfree_skb_any(sw_txhdr->skb);
+               }
+
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+               return;
+       }
+
+       txdesc->umacdesc.packet_addr[0] =3D cpu_to_le32(dma_addr);
+
+       cl_tx_ipc_txdesc_populate(cl_hw, txdesc, queue_type, ipc_queue_idx)=
;
+
+       /* make sure memory is written before push to HW */
+       wmb();
+
+       /*
+        * 1) Notify firmware on new buffered traffic by updating the enhan=
ced tim.
+        * 2) Push sw_txhdr to confirmation list
+        */
+       if (queue_type =3D=3D QUEUE_TYPE_AGG) {
+               a2e_trigger_bit_pos =3D IPC_IRQ_A2E_TXDESC_AGG_MAP(hw_queue=
);
+               cl_agg_cfm_add(cl_hw, sw_txhdr, ipc_queue_idx);
+               cl_enhanced_tim_set_tx_agg(cl_hw, ipc_queue_idx, hw_queue,
+                                          no_ps_buffer, cl_sta, tid);
+       } else if (queue_type =3D=3D QUEUE_TYPE_SINGLE) {
+               a2e_trigger_bit_pos =3D IPC_IRQ_A2E_TXDESC_SINGLE_MAP(hw_qu=
eue);
+               cl_single_cfm_add(cl_hw, sw_txhdr, ipc_queue_idx);
+               cl_enhanced_tim_set_tx_single(cl_hw, ipc_queue_idx, hw_queu=
e,
+                                             no_ps_buffer, cl_sta, tid);
+       } else {
+               a2e_trigger_bit_pos =3D IPC_IRQ_A2E_TXDESC_SINGLE_MAP(hw_qu=
eue);
+               cl_bcmc_cfm_add(cl_hw, sw_txhdr);
+       }
+
+       /* Tx_queue counters */
+       tx_queue->fw_free_space--;
+       tx_queue->total_fw_push_desc++;
+       tx_queue->total_fw_push_skb +=3D host_info->packet_cnt;
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_tx_push(cl_hw->idx, sw_txhdr->skb, host_info->packet=
_cnt,
+                              txdesc->e2w_txhdr_param.seq_ctrl, tid);
+#endif
+
+       /* Trigger interrupt to firmware so that it will know that a new de=
scriptor is ready */
+       cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, BIT(a2e_trigger_bit_p=
os));
+}
+
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

