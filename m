Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D883AB82B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhFQQFW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:22 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233561AbhFQQFG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbILaB0W786jrZPuwLSSlRCHfLAk2uzF8CXGZe3h170hnunjJ7OiqI/iKlBe8tYBACoNDIHRU8pMgfcajWNh20Zc+gUD8ii+YjZ75kj1pT6gv8sD/7Fud9T11L6kVIeVBPDwIbSR3UBuEm1uemU+tPVZRLc0VKDFdDeaY3MyABFb/YgFUL4PEVAcqdHWkpG6gcJ2V0oN3xLd11myJDuJ1+Ro3E88XfZH+/kkcZb6ouSaDv2HQrIKMO5HpRVzvhLViwsPp3k5mqw66G8aiNJ6foj1QeQV/Jav+QTcYBibhgdQq0Cq1XtDqZ6eWVj9KAOWdjC9oElfRenDy0D0rRfnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iBtH2i5EQgXcathytMEBpY1SA9u1V4vktnDE+N/H20=;
 b=VHpqJSMZH7/ZndLCQA0KHGgL7A4VxZNL5uhtCLF/3NBeU4mfsviJkps+oBEHU65muz+9qh84/OoA9O08MH98IY2saxo7o/S2MGrTtY3SHQ8Xo50pGIupMPQPaEsZTttA0e5exSmg3SvEK/xPksVEJfbmgjiKNgglJvKn6G01BTaxR3pr74lFO5yY9eAp2mk1ix5fxgExnhJ+CNpW2tiyKNE3feOMHapVTWwyqg1Exqw1FMFF6mnAVmsGGNzn6du3CLq7eIY0hI9FGZ8uSzVgN5I6qH38yP/lmYUd6WMMIVGssNdQyTMWett606mW6t7kdnv+gThJRLPxBfOsqxe1hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iBtH2i5EQgXcathytMEBpY1SA9u1V4vktnDE+N/H20=;
 b=H7k6MfXPXdBdON+JvdDfMmsmWB5dQugcBnd8zAn/y44TC4TrSWqHdRGA4PIVttqa6rK2kgObEdI7/qeM8JfegBc6NQAEkY5csxjrHTBOuQNMMetOUjRwBavEMzD4FthzQWQrVt59XJX+1jdouRItYs7key+Jm2/jNXtiNC+clEU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:55 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:55 +0000
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
Subject: [RFC v1 019/256] cl8k: add bus/pci/irq.c
Date:   Thu, 17 Jun 2021 15:58:26 +0000
Message-Id: <20210617160223.160998-20-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a93a481-de33-43f4-8c7e-08d931a95e1d
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499C23858ADA8E5B3705C91F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AaGS5mPoumBhOXYr/RfW7DZwXYOYiCQwMKn+mgbUg7y8PCucX0spcB4KHAQcNyFCOk8+mBsi9h14Mc7EjmAWwUuZrg+rmq2qFEuafeReoFO4nMpFHmXwaTeEgHIME8sb0RREi1WOaOXCYjCTsSribAK1crdvQX/sJ1JguUgh4YYithu6LTsxS+lRyaeUgAyYjYc+l0CXfXtPfkUzWdsFUNpnmcvZPSuY9IcM0tDOeir+riyFMA4kn7617k52E32w8fe2lu3kYs9KhoAUPjq+KPHeFuI/HSz4wT10Bqu7StfQb370Aqg6jyemvPw6X+eBsk/bBz7xpoaQJ/cIPu9nuIjDmZkxepZUTeQMPb5VIHxFTNpdw2mda6IGOKl83XN84MguIFNt0O2kdndu0lyAG6IJI2Kp3tBabEDFEV6HkI4YDzlyTOb8e6vUTWm8UrFyjZmL7Guck9wWAo08vqhgTgbTYuFhMEQc7dZqpvuRqeTHsG8c1CbxqwSgt/6TFDjtHBjO9IBL6EwRMoYRF4ZZO8vFD7uhTzHnDz8WMkfL7CMZr9GaYnj/ZnnJfeALKynubM7geTJhKbUr1VBFBqIaMr8LIaPu6/n7YWyIAB0uGKFMXanMifSss5bwm+ExN8Oynt0ZJoIl04RJSn1Zhf2qqxH0hXVrYooyAsOroMmm5PJG9f84cXOEOFkv00z7wODb2jXFSfwe6YPAl7jTHAaPBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VHMzjr0Cax0RPD0yQ+S6QQGsx/e+B4fb9EzVobMfHvBp2ni+NrF+b3l4Gy6Z?=
 =?us-ascii?Q?unv1b6fawnk/MCLbU1bQ8ko2kUZon7Aejg6/towqcMaz6jKPpCQ0+CT67hpd?=
 =?us-ascii?Q?4L14qYzdzi+C2vdMwFqqUPOMFkaqUJNHC6V7e3iq//ihNMg+E7cmXsYRuA5r?=
 =?us-ascii?Q?KjDMb92Jgup849sACIPxetR/R6VjnnGeeG7XGinpMwMVU7qUJ82wC7aE3wF7?=
 =?us-ascii?Q?uPejllUIpRIvQcZbOnfloocckktsGOxDUrYFztDJE8rYmkW4YP9raVslpaEK?=
 =?us-ascii?Q?mqCN0AL/JkdqhnofnzsliCljalF5Vy2FL+BCj5QODCz+ypGl+BsIiddph04q?=
 =?us-ascii?Q?z6yTNbk6OCelZFEhCWRbLeUoMFoVEjwsuBKPGAETAW8FVwroo1hWbdaiU6oZ?=
 =?us-ascii?Q?lwU5fXzEcvWRgnuAVhrYRnyljo63eGgg1sqSmjRRxtSN2ldzRm8c6Fl60bT5?=
 =?us-ascii?Q?pRTnDjhV6sXJ4AQL1b60rgzBWPiF9Jwbd0uB44wL9bp8ELaKKb1rzfQT/KqD?=
 =?us-ascii?Q?HhfZIqyxOhbH0HidAxuwzY5g9AQmVRQiStjJ2XpidYY0v1wZh4JIs8aEGNhd?=
 =?us-ascii?Q?knn+uNeqPV1iAHrkn2xWSa/Gc07eO15D4bG8SwzOnvh5hkO5toYtySxovDpQ?=
 =?us-ascii?Q?mJ7KWVZzEJEkPOkx5/EO8E+swrnAutPv6ldfFfeMDpaD0HGmSeiYPEMP58WB?=
 =?us-ascii?Q?MnfmQ6vDvoFA9EFM3SlvPrbawdcjAHm8ZLckYiqM4yfOx1qwBBEBXrtz8I7J?=
 =?us-ascii?Q?ki47JG3I3WnC6JAYUlMbuPajrrwQ0tgTlCUayP1+pqUm+RuLvIYOdjvAYtik?=
 =?us-ascii?Q?P5x3Q/lhrd+071SYbXh9d/6igI8bhZ8l1Qy7YyWBFgL0BDKJToRq2GL0NrH9?=
 =?us-ascii?Q?oYS5WYgnAEeGiG+N+GPgkUqJU0Ns7zeXy6I64Ao/QsABIofLsBt6klptW27O?=
 =?us-ascii?Q?pXRDjQite0MdOM03rl8kgvLpaECsurE4F0OT/QjyUZr8+iNOyPU7r354RVei?=
 =?us-ascii?Q?nrsuAWQLRYFhGIC/KeH0JcrKt5hc11YiDhXyL5pEGlR0ABB1qyqugVtkwRhv?=
 =?us-ascii?Q?FvzGT77e6c35oibBPBcGUsm8iDaWey4Wwz07sIO32oJWxbWVDVBDp9xa0MiY?=
 =?us-ascii?Q?IdYZzyO+EfowSb0260THHyvSQw/RuWJksXjyh4folKGivfYklldoWZVphxwT?=
 =?us-ascii?Q?ZpL9v+Rnlrwwe3l0ts99oB21DO1JVuqmsZZbobSFmDVf7UCrUTckFoYujARz?=
 =?us-ascii?Q?ALhvKsUfobCvWQQ0pmKLuoW6MHekmLSJSKN4teVg/CsVxfumgeD3J8cfvNzr?=
 =?us-ascii?Q?i9WWk1iCiEhrxVSLkFyjMj6W?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a93a481-de33-43f4-8c7e-08d931a95e1d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:55.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1xpH5igyesVryT96KvXfaZx4vifr19EvGpfpBtkzc+gi5Pbl0kJ0Kvz9s6yaLMRKStV+QLO7ld8HwL5dR8crQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/bus/pci/irq.c    | 331 ++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/irq.c

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/irq.c b/drivers/net/w=
ireless/celeno/cl8k/bus/pci/irq.c
new file mode 100644
index 000000000000..8ef5d2dba9ac
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/irq.c
@@ -0,0 +1,331 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include "reg/reg_access.h"
+#include "reg/reg_ipc.h"
+#include "bus/pci/ipc.h"
+#include "fw/msg_rx.h"
+#include "bus/pci/irq.h"
+#include "chip.h"
+#include "hw.h"
+#include "tx/tx.h"
+#include "dfs/radar.h"
+#include "recovery.h"
+#include "radio.h"
+#include "bus/pci/rx_pci.h"
+
+static void cl_irq_status_rxdesc(struct cl_hw *cl_hw, struct cl_ipc_host_e=
nv *ipc_env)
+{
+       /* Handle the reception of a Rx Descriptor */
+
+       /*
+        * Disable the RX interrupt until rxelement/skb handled
+        * this would avoid redundant context switch + redundant tasklet sc=
heduling
+        */
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.rxdesc);
+
+       /* Acknowledge the interrupt BEFORE handling the packet */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.rxdesc);
+
+       /*
+        * If more than 50% of buffer are populated handle them in the inte=
rrupt,
+        * otherwise schedule a tasklet to handle the buffers.
+        */
+       if (cl_rx_process_in_irq(cl_hw))
+               cl_rx_pci_desc_handler(cl_hw);
+       else
+               tasklet_schedule(&ipc_env->rxdesc_tasklet);
+}
+
+static void cl_irq_status_txcfm(struct cl_hw *cl_hw, struct cl_ipc_host_en=
v *ipc_env)
+{
+       /*
+        * Disable the TXCFM interrupt bit - will be enabled
+        * at the end of cl_tx_pci_single_cfm_tasklet()
+        */
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.txcfm);
+
+       /* Acknowledge the TXCFM interrupt */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.txcfm);
+
+       /* Schedule tasklet to handle the TXCFM */
+       tasklet_schedule(&ipc_env->tx_single_cfm_tasklet);
+}
+
+static void cl_irq_status_tbtt(struct cl_hw *cl_hw)
+{
+       unsigned long tbtt_diff_msec =3D jiffies_to_msecs(jiffies - cl_hw->=
last_tbtt_irq);
+
+       /* Acknowledge the interrupt BEFORE handling the request */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.tbtt);
+
+       cl_hw->last_tbtt_irq =3D jiffies;
+       cl_hw->tbtt_cnt++;
+
+       /*
+        * Send beacon only if radio is on, there is at least one AP interf=
ace
+        * up, we aren't in the middle of recovery, and user didn't disable=
 them.
+        */
+       if (cl_radio_is_off(cl_hw) ||
+           cl_hw->vif_db.num_iface_bcn =3D=3D 0 ||
+           cl_recovery_in_progress(cl_hw) ||
+           cl_hw->tx_disable_flags ||
+           !test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+           test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+               return;
+
+       if (cl_hw->iface_conf =3D=3D CL_IFCONF_MESH_ONLY ||
+           (cl_hw->mesh_tbtt_div > 1 &&
+           ((cl_hw->tbtt_cnt % cl_hw->mesh_tbtt_div) =3D=3D 0))) {
+               tasklet_hi_schedule(&cl_hw->tx_mesh_bcn_task);
+       } else {
+               /*
+                * More than 2 times the beacon interval passed between bea=
cons - WARNING
+                * More than 3 times the beacon interval passed between bea=
cons - ERROR
+                */
+               if (tbtt_diff_msec > (cl_hw->conf->ha_beacon_int * 3))
+                       cl_dbg_err(cl_hw, "last_tbtt_irq=3D%lu, curr_time=
=3D%lu, diff=3D%lu\n",
+                                  cl_hw->last_tbtt_irq, jiffies, tbtt_diff=
_msec);
+               else if (tbtt_diff_msec > (cl_hw->conf->ha_beacon_int * 2))
+                       cl_dbg_warn(cl_hw, "last_tbtt_irq=3D%lu, curr_time=
=3D%lu, diff=3D%lu\n",
+                                   cl_hw->last_tbtt_irq, jiffies, tbtt_dif=
f_msec);
+       }
+
+       cl_tx_bcns(cl_hw);
+}
+
+static void cl_irq_status_msg(struct cl_hw *cl_hw, struct cl_ipc_host_env =
*ipc_env)
+{
+       /* Acknowledge the interrupt BEFORE handling the request */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.msg);
+
+       /* Schedule tasklet to handle the messages */
+       tasklet_schedule(&ipc_env->msg_tasklet);
+}
+
+static u8 cl_radar_handler(struct cl_hw *cl_hw, ptrdiff_t hostid)
+{
+       struct cl_radar_elem *radar_elem =3D (struct cl_radar_elem *)hostid=
;
+       u8 ret =3D 0;
+       struct cl_radar_pulse_array *pulses;
+
+       /* Retrieve the radar pulses structure */
+       pulses =3D (struct cl_radar_pulse_array *)radar_elem->radarbuf_ptr;
+
+       /* Look for pulse count meaning that this hostbuf contains RADAR pu=
lses */
+       if (pulses->cnt =3D=3D 0) {
+               ret =3D -1;
+               goto radar_no_push;
+       }
+
+       /* Push pulse information to queue and schedule a tasklet to handle=
 it */
+       cl_radar_push(cl_hw, radar_elem);
+
+       /* Reset the radar element and re-use it */
+       pulses->cnt =3D 0;
+
+       /* Make sure memory is written before push to HW */
+       wmb();
+
+       /* Push back the buffer to the firmware */
+       cl_ipc_radarbuf_push(cl_hw->ipc_env, (ptrdiff_t)radar_elem, radar_e=
lem->dma_addr);
+
+radar_no_push:
+       return ret;
+}
+
+static void cl_irq_status_radar(struct cl_hw *cl_hw, struct cl_ipc_host_en=
v *ipc_env)
+{
+       /*
+        * Firmware has triggered an IT saying that a radar event has been =
sent to upper layer.
+        * Then we first need to check the validity of the current msg buf,=
 and the validity
+        * of the next buffers too, because it is likely that several buffe=
rs have been
+        * filled within the time needed for this irq handling
+        */
+
+       /* Disable the RADAR interrupt bit - will be enabled at the end of =
cl_radar_tasklet() */
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.radar);
+
+       /* Acknowledge the RADAR interrupt */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.radar);
+
+       /* Push all new radar pulses to queue */
+       while (cl_radar_handler(cl_hw,
+                               ipc_env->radar_hostbuf_array[ipc_env->radar=
_host_idx].hostid) =3D=3D 0)
+               ;
+
+       /* Schedule tasklet to handle the radar pulses */
+       cl_radar_tasklet_schedule(cl_hw);
+}
+
+static void cl_irq_status_dbg(struct cl_hw *cl_hw, struct cl_ipc_host_env =
*ipc_env)
+{
+       /* Disable the DBG interrupt bit - will be enabled at the end of cl=
_dbgfile_tasklet() */
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.dbg);
+
+       /* Acknowledge the DBG interrupt */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.dbg);
+
+       /* Schedule tasklet to handle the debug */
+       tasklet_schedule(&ipc_env->dbg_tasklet);
+}
+
+static void cl_irq_status_txdesc_ind(struct cl_hw *cl_hw, struct cl_ipc_ho=
st_env *ipc_env)
+{
+       /*
+        * Disable the TXDESC_IND interrupt bit -
+        * will be enabled at the end of cl_tx_pci_agg_cfm_tasklet()
+        */
+       cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.txdesc_ind);
+
+       /* Acknowledge the TXDESC_IND interrupt */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.txdesc_ind)=
;
+
+       tasklet_schedule(&ipc_env->tx_agg_cfm_tasklet);
+       tasklet_schedule(&cl_hw->tx_task);
+}
+
+static void cl_irq_status_sync(struct cl_hw *cl_hw, struct cl_ipc_host_env=
 *ipc_env)
+{
+       /* Acknowledge the interrupt BEFORE handling the request */
+       ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.sync);
+
+       set_bit(CL_DEV_FW_SYNC, &cl_hw->drv_flags);
+       wake_up_interruptible(&cl_hw->fw_sync_wq);
+}
+
+void cl_irq_status(struct cl_hw *cl_hw, u32 status)
+{
+       /* Handle all IPC interrupts on the host side */
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       if (status & cl_hw->ipc_e2a_irq.rxdesc)
+               cl_irq_status_rxdesc(cl_hw, ipc_env);
+
+       if (status & cl_hw->ipc_e2a_irq.txcfm)
+               cl_irq_status_txcfm(cl_hw, ipc_env);
+
+       if (status & cl_hw->ipc_e2a_irq.tbtt)
+               cl_irq_status_tbtt(cl_hw);
+
+       if (status & cl_hw->ipc_e2a_irq.msg)
+               cl_irq_status_msg(cl_hw, ipc_env);
+
+       if (status & cl_hw->ipc_e2a_irq.radar)
+               cl_irq_status_radar(cl_hw, ipc_env);
+
+       if (status & cl_hw->ipc_e2a_irq.dbg)
+               cl_irq_status_dbg(cl_hw, ipc_env);
+
+       if (status & cl_hw->ipc_e2a_irq.txdesc_ind)
+               cl_irq_status_txdesc_ind(cl_hw, ipc_env);
+
+       if (status & cl_hw->ipc_e2a_irq.sync)
+               cl_irq_status_sync(cl_hw, ipc_env);
+}
+
+#ifdef CONFIG_CL_PCIE
+static void cl_irq_handler(struct cl_chip *chip)
+{
+       /* Interrupt handler */
+       u32 status, statuses =3D 0;
+       unsigned long now =3D jiffies;
+       struct cl_irq_stats *irq_stats =3D &chip->irq_stats;
+
+       while ((status =3D ipc_xmac_2_host_status_get(chip))) {
+               statuses |=3D status;
+
+               if (status & IPC_IRQ_L2H_ALL)
+                       cl_irq_status(chip->cl_hw_tcv0, status);
+
+               if (status & IPC_IRQ_S2H_ALL)
+                       cl_irq_status(chip->cl_hw_tcv1, status);
+       }
+
+       if (statuses & (IPC_IRQ_L2H_RXDESC | IPC_IRQ_S2H_RXDESC))
+               irq_stats->last_rx =3D now;
+
+       if (statuses & (IPC_IRQ_L2H_TXCFM | IPC_IRQ_S2H_TXCFM))
+               irq_stats->last_tx =3D now;
+
+       irq_stats->last_isr =3D now;
+       irq_stats->last_isr_statuses =3D statuses;
+}
+
+static irqreturn_t cl_irq_request_handler(int irq, void *dev_id)
+{
+       struct cl_chip *chip =3D (struct cl_chip *)dev_id;
+
+       cl_irq_handler(chip);
+
+       return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_SMP
+static void cl_irq_set_affinity(struct cl_chip *chip, struct pci_dev *pci_=
dev)
+{
+       s32 irq_smp_affinity =3D chip->conf->ce_irq_smp_affinity;
+
+       if (irq_smp_affinity !=3D -1) {
+               struct irq_data *data =3D irq_get_irq_data(pci_dev->irq);
+
+               if (data) {
+                       static struct cpumask mask;
+
+                       cpumask_clear(&mask);
+                       cpumask_set_cpu(irq_smp_affinity, &mask);
+
+                       if (data->chip->irq_set_affinity) {
+                               data->chip->irq_set_affinity(data, &mask, f=
alse);
+                               pr_debug("irq=3D%d, affinity=3D%d\n", pci_d=
ev->irq, irq_smp_affinity);
+                       }
+               }
+       }
+}
+#endif
+
+int cl_irq_request(struct cl_chip *chip)
+{
+       /*
+        * Allocate host irq line.
+        * Enable PCIe device interrupts
+        */
+       int ret;
+       /* Request exclusive PCI interrupt in firmware test mode */
+       struct pci_dev *pci_dev =3D chip->pci_dev;
+
+       ret =3D request_irq(pci_dev->irq, cl_irq_request_handler, IRQF_SHAR=
ED, "cl", chip);
+
+       if (ret) {
+               pr_err("ERROR: could not assign interrupt %d, err=3D%d\n", =
pci_dev->irq, ret);
+               return ret;
+       }
+
+#ifdef CONFIG_SMP
+       cl_irq_set_affinity(chip, pci_dev);
+#endif
+
+       return ret;
+}
+
+void cl_irq_free(struct cl_chip *chip)
+{
+       struct pci_dev *pci_dev =3D chip->pci_dev;
+       /* Disable PCI device interrupt and release irq line */
+       free_irq(pci_dev->irq, chip);
+}
+#endif /* CONFIG_CL_PCIE */
+
+void cl_irq_enable(struct cl_hw *cl_hw, u32 value)
+{
+       /* Enable IPC interrupts */
+       ipc_xmac_2_host_enable_set_set(cl_hw->chip, value);
+}
+
+void cl_irq_disable(struct cl_hw *cl_hw, u32 value)
+{
+       /* Disable IPC interrupts */
+       ipc_xmac_2_host_enable_clear_set(cl_hw->chip, value);
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

