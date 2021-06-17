Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE163AB830
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhFQQF0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:26 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233570AbhFQQFN (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvzTeb5LtuVce0UXLVtId8g37RKDDooghTe1nbOxBLEsV5QrOPu+s4/5WUmm5LYYysf05+m6YrmwFPRAuOuc9lq5RVVxDjC50YsmrPvxfBj5qHcQZu7n+wjQGoVtG3sLQyH5+TSslHXcI91lJY2Zz4U3t8ANnGeOi+tljyVi1hbHSnQpWPc6V88G2Z3W+Z6VTG3/uXr9BOKQsrhJovnqcBjKEhmUBbVBlFYfZUrhgvO0iblTvDL8Wj/qSpVzFi8hMaFxv9Jlu1NurKq4H8CDAbX6mFZx07Gr6xT20fSeJZDpk9griXxJlffBdbHw7uvnj5OOxHgVLtfjbv/O0w9MPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orQV9KEBadryEtpmadIhlMGk5B0REN1Q3Wtg2rw8klI=;
 b=Jz5Cz9u2NndaXk+EIg4pdWSp74LMF1WS1QVNI1NXpmdGy/jCs7tkYaqUNzstvZ+MoVXa3J4kvk/KIgRgOXU2UAXNVnNJ3x3F6iA3GywaNOGjTrNyv2p9pdO2yjCySQ9pkqDFoUaZD0i770X24InVc6o7sBB5E/8zuuHACwU197aCgDWFtsKgJE7yhClvEhFsk84IFMA1JWp0vsCUnKq1Vw1cmIGW/ma0iBxlvLiUu0V+qgb5cEuNpJ8qaxB72ryUATd6fWcDqpH7sFNLbJB1RiOE8Xl9aGwjojOTNzoZs2EJxoI64Ix9pKlimID7SeXkD50S2WvbcIKu3UTbbHGwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orQV9KEBadryEtpmadIhlMGk5B0REN1Q3Wtg2rw8klI=;
 b=qA40A2aQ4/NQx2PlYyTOgUd0HoWm3yi/0GSNm8+Y6iHTwSkxU+0f9K1oKV8BW86ZTIfZGV8Q3RKZSkFyreQhtqWcH2ZS2Pg4LgtMI9WNszoTo2rVedaR+M4vG6TDwR/w1BPfycprxX8iNtmcWkxCFd09eifxA87UJR5/H0Z3NK0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:00 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:00 +0000
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
Subject: [RFC v1 024/256] cl8k: add bus/pci/rx_pci.c
Date:   Thu, 17 Jun 2021 15:58:31 +0000
Message-Id: <20210617160223.160998-25-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d44bd2e-f133-47b9-6c3b-08d931a96136
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499B35808356407AF50A621F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xpV4k60cxYq7fNb+oG/8ZOPJapllUHvA/JAj4E3wARD+yS+vjrlx1XCV/oA9iaypGnCn4iRV8VwZdx8ZJU5jJ8amJjl+jI7XEznQBquXb9WmuEHycDpLSxG97PCa1jkWgSiPCcqliYr73HqXFWYeuC6CUZIdgfbVyON53WcOZUZ3VwUM1kxwCI37wrJEBdNI9SdU79kdJrlvCi6hH8N6sjTkJOoDA/W7MH+OpjxhW8inLEhzYQOCX6hiqlQq+QAtQsh/nF6HbvU+xeXIGgDKNET8RUpHExSbwjdnOKb9lZfmhES3koVmft0h8Gxpd5O6JV8f+HBi6KpusZWeZVrjP0Baa0VtRe+aijyU0+m2wqNqy+eQLBUqu6lNVhhXXII7gsMGedN6RiPQOv3AD94KANrMxnHFPjUr3EeHZTKGT1smt8gx1TDFbJzUayqDtwSqjtbXA/tN3H/DIERqYX74Fj4G/XCxD8Rl7TJxiuJ2RqvXw8ybDioXE9nq8oIZOfrkfXLrl//NgRUkyufgwiRI30H5HPcrq0hZCpCXm+B78yft9K42mVLZuVZ/gFxSwCE5hq3Hu0KuQ69xra97JP2fO2mjfg9z5rj4UKNs9tiExsYzI3wM4IDkWVY3xVUasJYLFljIQNaGG+og8iVhlvfrzsmzdsleOVJWDEwa53RP18T24Uthuv5+OKl1tsU8OloS+MWrpEBMY+1Ee0+uN3g8kQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TkrVga1905HI8mRSJDfxVNVx0tAWcuca9/V8ja4bCc0OZhh4UM9I+kpHVc4D?=
 =?us-ascii?Q?lkVfDj8p8z/8MQFlE8QNdBpXLuUIqhLGHhDDwRYiy/CQbrXZzs66cYLsBljM?=
 =?us-ascii?Q?ApQ7gLc3OUDYEaYvqrhf59wdiw/9LIU+Wn6QijWyW9NBEQjPik3qdILVC7C5?=
 =?us-ascii?Q?jdgfE8GdOapAMXiaBl598szmGCjtFArotRmJqZSM378lDdrhdvFT4obGgNgD?=
 =?us-ascii?Q?MaDOL4FHMc83sGXg3sPsDdEmcRAl71YhLf+x8uZZ/a4++Z7ZMbwFRKFKssBk?=
 =?us-ascii?Q?C2u8+s0agGomuI/LvhMMdpaFniQHl3zMnsGJamRKifu/zq6UVg9bETFzL1jl?=
 =?us-ascii?Q?ay2bpYiYp30302az8/YibGJA7H6SIz0/iwcO69gUi0R8ZXv26BA/ANZq34ZZ?=
 =?us-ascii?Q?tOoLASADK+BaA+baR2g8gJ2AV5Kf7H7WF/XhI09mBS2mvLyQM0REkWKe5q/4?=
 =?us-ascii?Q?7SC6Uo/2nW7bCBYuHnQ8gxPTwhQ+sPzZtNnMe1TEGFadvvFLPeVKgYJubbIK?=
 =?us-ascii?Q?cBsVOtqNM/U16PtLFKCywjkZkL7xTSy4WECzRJtMVO3mpxVuYJ2SCAyiOtOA?=
 =?us-ascii?Q?16k+MypldqAikYeidBPLdzVVXq0DjLKyCjRucs1zh4joKL46V6u2LP2Fgqnz?=
 =?us-ascii?Q?O3RxrGvJTipBatYSpARssh/fayLEWjMWqLj2n5GOdNMtyoSYjiA14I2+1O7s?=
 =?us-ascii?Q?DdKM1DnOIdeBuAhw6fvyBksDdy4ClLoqOj8032uoYAspBU8OaOu2+boz0CBm?=
 =?us-ascii?Q?qlvtcuOBaBLyyZqDMKxp9HJMxezZ7maJKOmyBGVtKNoSqkAnHj4uUAJIxZhn?=
 =?us-ascii?Q?gASgdR7ekL2lJ1a2KqNSs3VRHt99Zyr227mWPiGpOdq+CN9LxMIqjZlapOqo?=
 =?us-ascii?Q?KhXTR2NIDxUXubENO0e/IQQaMXtlhVeqBZA4Nrb+2mze6TN9Cd6NWPF7MDfV?=
 =?us-ascii?Q?JFZqk8EqssngpN/jdLrad9W7U9u24Rckeg5BFOUtuvlIPNcGH/mvsATAFEgq?=
 =?us-ascii?Q?6A0HsA7ylmS0hU1Ndsds2xN9o8ALy/SyHdxGBm5p4l62JdaXGh554K+cD040?=
 =?us-ascii?Q?o247r4VKOmYBX30WmGDyKE5n8lpMXeDLaQsqrRFrlHmwCOiTMaAnx/ad/2ez?=
 =?us-ascii?Q?vxcqE1p7BVS8Yv+LlfH8OWA2UGj36JI63HINABNtUxkJtgFXETsgLQ1i+4ZF?=
 =?us-ascii?Q?OG0rvh/hFYmF3RjbKAs+9mOeMqpbh9lYmiKHfMtm6N54jL5SGsB6ALpwG2XG?=
 =?us-ascii?Q?oSJ3/wGT6sYDkr55lwxtyeP/Ui4fDpLMfOza3gKLFdgU3NK3hU2MtRJdHh2B?=
 =?us-ascii?Q?Jv9lqfCWqxoovnpCFcZnREMo?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d44bd2e-f133-47b9-6c3b-08d931a96136
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:00.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58ThltdAOOLxJwrcTB5X10FCC6x34rf8B76RHIZlzhlSCsmZ59DhcxPD7ncstC3pRrrVmoGK8UNyo94cE1RyWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/bus/pci/rx_pci.c | 219 ++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.c

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.c b/drivers/ne=
t/wireless/celeno/cl8k/bus/pci/rx_pci.c
new file mode 100644
index 000000000000..1f0724dcc692
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/rx_pci.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "bus/pci/rx_pci.h"
+#include "bus/pci/ipc.h"
+#include "rx/rx.h"
+#include "ipc_shared.h"
+#include "def.h"
+#include "bus/pci/irq.h"
+#include "chip.h"
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+static DEFINE_PER_CPU(struct tasklet_struct, rx_remote_tasklet_drv[TCV_TOT=
AL]);
+
+static void cl_rx_pci_stats_rxm(struct cl_hw *cl_hw, u16 bucket_idx)
+{
+       if (bucket_idx < IPC_RXBUF_NUM_BUCKETS_RXM)
+               cl_hw->rx_info.pkt_handle_bucket_rxm[bucket_idx]++;
+       else
+               cl_hw->rx_info.pkt_handle_bucket_rxm[IPC_RXBUF_NUM_BUCKETS_=
RXM - 1]++;
+}
+
+static void cl_rx_pci_stats_fw(struct cl_hw *cl_hw, u16 bucket_idx)
+{
+       if (bucket_idx < IPC_RXBUF_NUM_BUCKETS_FW)
+               cl_hw->rx_info.pkt_handle_bucket_fw[bucket_idx]++;
+       else
+               cl_hw->rx_info.pkt_handle_bucket_fw[IPC_RXBUF_NUM_BUCKETS_F=
W - 1]++;
+}
+
+static void cl_rx_pci_stats(struct cl_hw *cl_hw, u16 pkt_cnt, enum rx_buf_=
type type)
+{
+       /* Collect stats - fill the bucket stats */
+       if (pkt_cnt) {
+               u16 bucket_idx =3D pkt_cnt >> IPC_RXBUF_BUCKET_POW_SIZE;
+
+               if (type =3D=3D CL_RX_BUF_RXM)
+                       cl_rx_pci_stats_rxm(cl_hw, bucket_idx);
+               else
+                       cl_rx_pci_stats_fw(cl_hw, bucket_idx);
+       }
+}
+
+static int _cl_rx_pci_start(struct cl_hw *cl_hw, u32 rxdesc_read_idx, u32 =
host_read_idx,
+                           enum rx_buf_type type)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_host_rxbuf *rx_hostbuf =3D &ipc_env->rx_hostbuf_array=
[type];
+       struct cl_rx_elem *rxelem =3D
+               (struct cl_rx_elem *)rx_hostbuf->ipc_host_rxdesc_ptr[host_r=
ead_idx];
+       struct sk_buff *skb;
+       int ret =3D 0;
+       dma_addr_t dma_addr;
+       u32 size =3D cl_hw->conf->ci_ipc_rxbuf_size[type];
+
+       cl_hw->rx_info.rx_desc[type]++;
+
+       /* Copy the current skb buffer & dma_addr. */
+       skb =3D rxelem->skb;
+       dma_addr =3D rxelem->dma_addr;
+
+       /* Try to populate the rxelem with new skb */
+       if (cl_ipc_rx_elem_alloc(cl_hw, rxelem, size)) {
+               cl_hw->rx_info.elem_alloc_fail++;
+               /* Restore skb and dma_addr value */
+               rxelem->skb =3D skb;
+               rxelem->dma_addr =3D dma_addr;
+               ret =3D -ENOMEM;
+               goto handle_done;
+       }
+
+       /* Release dma virtual memory early */
+       dma_unmap_single(cl_hw->chip->dev, dma_addr, size, DMA_FROM_DEVICE)=
;
+
+       if (!skb) {
+               cl_hw->rx_info.skb_null++;
+               cl_dbg_verbose(cl_hw, "skb is NULL\n");
+               goto handle_done;
+       }
+
+       cl_ipc_rxbuf_push(ipc_env, rxelem, rxdesc_read_idx, host_read_idx, =
type);
+
+       cl_rx_push_queue(cl_hw, skb);
+
+handle_done:
+       return ret;
+}
+
+static void cl_rx_pci_start(struct cl_hw *cl_hw, enum rx_buf_type type, u1=
6 rx_buf_cnt)
+{
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+       struct cl_ipc_ring_indices *indices =3D ipc_env->ring_indices_elem-=
>indices;
+       u16 buf_cnt_mask =3D rx_buf_cnt - 1;
+       u16 pkt_cnt =3D 0;
+       u32 rxdesc_read_idx =3D le32_to_cpu(indices->rxdesc_read_idx[type])=
;
+       u32 host_read_idx =3D 0;
+       u32 rxdesc_write_idx =3D le32_to_cpu(indices->rxdesc_write_idx[type=
]);
+       u32 host_write_idx =3D 0;
+
+       /*
+        * Firmware has triggered an interrupt saying that a reception has =
occurred.
+        * Iterate over all valid rxdesc pushed by embedded.
+        * The read index is incremented once the callback function finishe=
s meaning
+        * a new allocated skb pushed the rxbuff.
+        * The write index is incremented in direct write by the embedded l=
ayer,
+        * indicating that allocated skb was populated with packet data.
+        */
+
+       do {
+               host_write_idx =3D rxdesc_write_idx;
+
+               while (ipc_env->host_rxdesc_read_idx[type] !=3D host_write_=
idx) {
+                       host_read_idx =3D rxdesc_read_idx & buf_cnt_mask;
+
+                       if (_cl_rx_pci_start(cl_hw, rxdesc_read_idx, host_r=
ead_idx, type) =3D=3D 0) {
+                               /* Local application follower of embedded r=
ead idx */
+                               ipc_env->host_rxdesc_read_idx[type]++;
+                               rxdesc_read_idx++;
+                               pkt_cnt++;
+                       } else {
+                               /*
+                                * Replacing old skb with new allocated skb=
 failed
+                                * (should not happen). Postpone the handle=
 of the
+                                * old skb until this function is reschdule=
d again.
+                                */
+                               if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_f=
lags))
+                                       tasklet_schedule(&ipc_env->rxdesc_t=
asklet);
+                               goto out;
+                       }
+               }
+
+               /* Check if firmware pushed new descriptors */
+               rxdesc_write_idx =3D le32_to_cpu(indices->rxdesc_write_idx[=
type]);
+       } while (host_write_idx !=3D rxdesc_write_idx);
+
+out:
+       cl_rx_pci_stats(cl_hw, pkt_cnt, type);
+}
+
+static void cl_rx_pci_remote_tasklet_handler(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       cl_rx_remote_cpu_info(cl_hw);
+       cl_rx_pci_desc_handler(cl_hw);
+}
+
+static void cl_rx_pci_remote_cpu_sched(struct cl_hw *cl_hw)
+{
+       int cpu =3D cl_hw->conf->ci_rx_remote_cpu_drv;
+       struct tasklet_struct *t =3D &per_cpu(rx_remote_tasklet_drv[cl_hw->=
idx], cpu);
+
+       if (!test_bit(TASKLET_STATE_SCHED, &t->state))
+               smp_call_function_single(cpu, cl_rx_remote_tasklet_sched, t=
, 0);
+}
+
+void cl_rx_pci_init(struct cl_hw *cl_hw)
+{
+       s8 cpu =3D cl_hw->conf->ci_rx_remote_cpu_drv;
+
+       if (cpu >=3D 0)
+               tasklet_init(&per_cpu(rx_remote_tasklet_drv[cl_hw->idx], cp=
u),
+                            cl_rx_pci_remote_tasklet_handler,
+                            (unsigned long)cl_hw);
+}
+
+void cl_rx_pci_deinit(struct cl_hw *cl_hw)
+{
+       s8 cpu =3D cl_hw->conf->ci_rx_remote_cpu_drv;
+
+       if (cpu >=3D 0)
+               tasklet_kill(&per_cpu(rx_remote_tasklet_drv[cl_hw->idx], cp=
u));
+}
+
+void cl_rx_pci_desc_handler(struct cl_hw *cl_hw)
+{
+#ifdef TRACE_SUPPORT
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       trace_cl_trace_rx_desc_tasklet_start(cl_hw->idx,
+                                            ipc_env->host_rxdesc_read_idx[=
CL_RX_BUF_RXM],
+                                            ipc_env->host_rxdesc_read_idx[=
CL_RX_BUF_FW]);
+#endif
+
+       /* Handle all RXM rx elements */
+       cl_rx_pci_start(cl_hw, CL_RX_BUF_RXM, IPC_RXBUF_CNT_RXM);
+       /* Handle all FW rx elements */
+       cl_rx_pci_start(cl_hw, CL_RX_BUF_FW, IPC_RXBUF_CNT_FW);
+
+       /* Initiate interrupt to embbeded when all rx elements were handled=
 */
+       if (!test_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags))
+               cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, IPC_IRQ_A2E_R=
XBUF_BACK);
+
+       /*
+        * Finished handle all valid rx elements, restore the RX interrupt
+        * to enable handling new populated rx elements
+        */
+       if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+               cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.rxdesc);
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_rx_desc_tasklet_end(cl_hw->idx,
+                                          ipc_env->host_rxdesc_read_idx[CL=
_RX_BUF_RXM],
+                                          ipc_env->host_rxdesc_read_idx[CL=
_RX_BUF_FW]);
+#endif
+}
+
+void cl_rx_pci_desc_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       if (cl_hw->conf->ci_rx_remote_cpu_drv =3D=3D -1)
+               cl_rx_pci_desc_handler(cl_hw);
+       else
+               cl_rx_pci_remote_cpu_sched(cl_hw);
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

