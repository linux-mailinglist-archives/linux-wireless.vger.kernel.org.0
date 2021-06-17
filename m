Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240A13AB82D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbhFQQFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:24 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:38880
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233555AbhFQQFJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVAicImFOArXblUhfH9D/R6VFbCz0bZKGKOuY6rwSk3H9p6tzB/zf0WnMfj4K5RTAv3QOw9XVKqtJGs2Gu4BaLGrhh6YAaLNvkeBanjk2RS+2oqroUbCvoSSd7FyaETPsF9cutojPsKVXE/G5g53E9irEInZGZkfBSkO+x5aJF+WsNw7m4PptazMiz2hUDuq0lHRdsO1IH6df+y7GG8NOav2uKNpQHBvgGtBdvQc3Wske7DutBVUWwG4jGAHr2dcBANPf4N+f3pyztpE9SSkeiDbOIIAzoQnR3K4GySx7pf00E/Ys8f9scbfN3yZgErXVoHvhOTLmfEJ4KwCh+vMcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDbhRsT9WrwRxZ/2+pdjv3Z63rEIwDMz4bDr18B+Vk4=;
 b=FdBQhpLT6E05M3iwqer8+UtB8s4Sde5qLllVtZppQ63tLMy99mU2zTwRSsYX39T8X1EdO8U9JYLg9SI9HcEzioqPNXCdQLfLXATfflA7DSwW5gf2z+FAvcKIEMab/kK7f+97p54jWdGUzoaxbqGsXg9cpMeczQi7eQnCd4w63PzVLrpS4pmxIr1w3V2X1ClIOAodLErl+FKHCJO+pSWvGuFqRrnkbIFiRTwmyto9s91ynswQ3KMTzHEja/pN8xSSGIwyTFvRoX9d0Skc8O++i3+XI7Hbkfnj0IIB+bw6FrKV4JJQ99RC5JYdhfLdJI5ke+BYHyB+9g97JjqGcZd93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDbhRsT9WrwRxZ/2+pdjv3Z63rEIwDMz4bDr18B+Vk4=;
 b=GHMNnUIxhPgocByKUOncHlpmbaDVc0iuNmFLc1RC1NlSEfkdscGJ3IdunSTcVu0HbvEsn3Ox266TWcV/N5JHMqXiwb8tv0GwB0HLuuK/fWJ8bZjoBJIMXsrsrJ7LCsgZpI/j0eEoVsK0uDD0OLjRehBRJMxXsRwRVVkkVNoPhCE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:02:57 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:57 +0000
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
Subject: [RFC v1 021/256] cl8k: add bus/pci/msg_pci.c
Date:   Thu, 17 Jun 2021 15:58:28 +0000
Message-Id: <20210617160223.160998-22-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1d4803c-cc13-4d1a-a1de-08d931a95f58
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB04993A6E4DE868327A988E27F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L415dG700QzjDzum0P9kM61bZrEBRSuI4aQilQ3Ba0wNu36eMjZo5pmF9R6AWaQLBM29hpFZ3nBqodhdZZ+uOpgxpHGUTD5WWr129606SlIfeeUjW+8ycApli8BcDdlYdcTn5aasGmO7qFhwOxfEeVTKYc+o49AJ6rTqIqLcpyzZrQl8wxtOCR+M6ozds6t4Ra+nlkVo1SxqxTMQwBrLK5AJ4rBse3lpOOJT5OupjAO7HHsc3aWtIovTfxkxKV1rIoy0uO9v2Jxw3z8PnwNuVyT2Q1cKPtD+2nA1ak6xP1p6alm5+QRyxK14qSMqAqAOck3pFeOM25Sa4r9ca9oh3kigzFKXndc6xPIR892T9uzcOIRNWEbzLtUZbrmPIhpImJqRUPPzbG8fDuAfHvdC1TaHOTcaj6etuOZZdupwFOHt8S1I/ye1MAbaevTPopGlW7PndwL1oVyxVb8WB5u9o3D8ulZ5ElH+r/SZ4GGBFK26XHHOzhArXwClmISZcI8AmSterkYe+tNX0ieC1p6aWDnjnpRvVxCKk+WfrO6TsKYlgKxBvQo51DdetV7xXzdwBKFOG++Xw0c8Tus13f1N0pa6ZXMSnIS1Uw64aJYhrgiV/yOYUCZ/fZYS07GvpyWNH1tNrs/EoMC6CHcdXddrmP04Y9ioILsV5W9q5npV9kZqjNEBHjg2vSgVzc14K94vYmqhk85r7oW6bLRLwR7ncQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WVCFkAqqo9S7vhkLHkqaPV46C93UZC/cNWu2oUTJnQcS+EQQ+oblwpSoV8dp?=
 =?us-ascii?Q?YmPqo8eOpp7WoVzd8MmcIzFMbArhBiQ+QXQoh+QIBb+izGUXtlxfWUphhqC9?=
 =?us-ascii?Q?Mg5CnIHGOlikGOzrmyWQV5McC2kDJqlrW7tDbql3takIrFTF4aRuw2UoiBjM?=
 =?us-ascii?Q?vrXASktr5okM4yuDGRfvHjPvkOpR27KobOuBqTB8+SxYKgJ3gzBqQbAUKilE?=
 =?us-ascii?Q?sxt3HaU4nJiZJwTSWqBCTuJqsMGKix4vxdMq6UMmB36LYmq4BiOddVU6Cfy9?=
 =?us-ascii?Q?KmjljIkyBSGyp53uXeYjpK8c8pYlI8NJrFOheLxOoHtv7LjFvraYa0soERfr?=
 =?us-ascii?Q?kW/BQxKj/7DtOFCbdIKFGKtvmJebMpjv69CjEP5SiM2KMCxIOMZtogCCPpVN?=
 =?us-ascii?Q?VaoJY74ki4JbNwu0LTeVzkqjfx8efXqmQShTM30rSpVaosjJnC5vKt6EffRK?=
 =?us-ascii?Q?0uvMMA+zcNs2GOeFb1GFAco5c/qtQwRwEzTu6r30OAdLTE2NpS9PStDaP7Eo?=
 =?us-ascii?Q?dVXIw1dbF5jO9A348NwoSDS+hACBrQW2bivt9Pgyi5kW7JaYzDV6bYfQVgw0?=
 =?us-ascii?Q?aF92bYpSVZrt+spIPXFo9Ht8MbLtJkrSW1XBq6IcyIf0pRzPxN236se+Q/vG?=
 =?us-ascii?Q?Nhf6YoJep7EG2593uqWvVH0DKh2vaiWkRCfnut7gPIin/EeJCAZeL+h1gjHW?=
 =?us-ascii?Q?PLRJENhtmI4YOFUDUmcN5P0cAuSRBYZ/MYXgyGHtP5/5OVNm4IWysdRSduCL?=
 =?us-ascii?Q?g989tFZu0XPPn9g8r4POu95nhYE5BKfnTmcpWTpZoraaP844vdjC+5jT4FKN?=
 =?us-ascii?Q?VrMEPDCm2FY/OCbonaeEswJ/WtYXsr/Wa7rlkM1n5Eadh9twXD+Af/2bIEkh?=
 =?us-ascii?Q?bjxBlcwoWmGjw4C2gZe3sF11DxNeXu6+HxGC75T1/BXr3OKk92eT/0mqe9Qj?=
 =?us-ascii?Q?NpNu2q0H/Ir274khvjsVrn/Fy+2hPPq5+CpY7qiCVlt8LuATHLjry80CWf9k?=
 =?us-ascii?Q?HE3zh9pB8SdSWTKMmSUD5a+SJnYs7QCI/bt5ZvLszDQWtNv/9cffCiE/6iQk?=
 =?us-ascii?Q?Q2UAEYEQYyUZ4prs8HFLjbhsIdN7/mE8pztleEsC4Xj4ExZM4KRePKba+xiE?=
 =?us-ascii?Q?i7i6BQN+Un5wwKGeCODAYOqI9roSpg6NqOGeZQc8OZ5l5Dj1dImnmMyQqrZe?=
 =?us-ascii?Q?xv8ZbAMBRq4OL2BokdwZNRxIGOJ/lR/zW+wvXbEswGgA+G/nnmhTSIK/UvJN?=
 =?us-ascii?Q?r1APOEWiviG/nYHOKMKmWx593lVCWuOdEo4djVwGYIXukkYuHPpy47rSOpJx?=
 =?us-ascii?Q?CiDUmdiGibxa0zaAWIBxfEaH?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d4803c-cc13-4d1a-a1de-08d931a95f58
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:56.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Enh3wZNByzRAvI0ZDgThjPb9yJeEMiruBAeeh1ZDR+IZJrCZ3BbtrMv0MKDnO69xdz3UtqPAVNhi19AP8zTY/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/bus/pci/msg_pci.c    | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.c

diff --git a/drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.c b/drivers/n=
et/wireless/celeno/cl8k/bus/pci/msg_pci.c
new file mode 100644
index 000000000000..4ddc060940c1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bus/pci/msg_pci.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "hw.h"
+#include "bus/pci/ipc.h"
+#include "fw/fw_msg.h"
+#include "fw/msg_cfm.h"
+#ifdef TRACE_SUPPORT
+#include "trace.h"
+#endif
+
+static void cl_msg_pci_fw_push(struct cl_hw *cl_hw, void *msg_buf, u16 len=
)
+{
+       /* Send a message to the embedded side */
+       int i;
+       u32 *src;
+       u32 *dst;
+       struct cl_ipc_host_env *ipc_env =3D cl_hw->ipc_env;
+
+       /* Copy the message into the IPC MSG buffer */
+       src =3D (u32 *)msg_buf;
+       dst =3D (u32 *)&ipc_env->shared->a2e_msg_buf;
+
+       /*
+        * Move the destination pointer forward by one word
+        * (due to the format of the firmware kernel messages)
+        */
+       dst++;
+
+       /* Align length of message to 4 */
+       len =3D ALIGN(len, sizeof(u32));
+
+       /* Copy the message in the IPC queue */
+       for (i =3D 0; i < len; i +=3D sizeof(u32))
+               *dst++ =3D cpu_to_le32(*src++);
+
+       /* Trigger the irq to send the message to EMB */
+       cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, IPC_IRQ_A2E_MSG);
+}
+
+int cl_msg_pci_msg_fw_send(struct cl_hw *cl_hw, const void *msg_params,
+                          bool background)
+{
+       struct fw_msg *msg =3D container_of((void *)msg_params, struct fw_m=
sg, param);
+       u16 req_id =3D msg->msg_id;
+       u16 cfm_bit =3D cl_msg_cfm_set_bit(req_id);
+       int length =3D sizeof(struct fw_msg) + msg->param_len;
+       int error =3D 0;
+
+       if (!cl_hw->fw_active) {
+               cl_dbg_verbose(cl_hw, "Bypass %s (firmware not loaded)\n", =
MSG_ID_STR(req_id));
+               /* Free the message */
+               kfree(msg);
+               return -EBUSY;
+       }
+
+       if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags)) {
+               cl_dbg_verbose(cl_hw, "Bypass %s (CL_DEV_FW_ERROR is set)\n=
", MSG_ID_STR(req_id));
+               /* Free the message */
+               kfree(msg);
+               return -EBUSY;
+       }
+
+       if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) &&
+           msg->msg_id !=3D MM_RESET_REQ &&
+           msg->msg_id !=3D MM_START_REQ) {
+               cl_dbg_verbose(cl_hw, "Bypass %s (CL_DEV_STARTED not set)\n=
", MSG_ID_STR(req_id));
+               /* Free the message */
+               kfree(msg);
+               return -EBUSY;
+       }
+
+       /* Lock msg tx of the correct msg buffer. */
+       error =3D mutex_lock_interruptible(&cl_hw->msg_tx_mutex);
+       if (error !=3D 0) {
+               cl_dbg_verbose(cl_hw, "Bypass %s (mutex error %d)\n", MSG_I=
D_STR(req_id), error);
+               /* Free the message */
+               kfree(msg);
+               return error;
+       }
+
+       cl_hw->msg_background =3D background;
+
+       CFM_SET_BIT(cfm_bit, &cl_hw->cfm_flags);
+
+       cl_dbg_trace(cl_hw, "%s\n", MSG_ID_STR(req_id));
+
+       /* Push the message in the IPC */
+       cl_msg_pci_fw_push(cl_hw, msg, length);
+
+       /* Free the message */
+       kfree(msg);
+
+#ifdef TRACE_SUPPORT
+       trace_cl_trace_cl_msg_fw_send(cl_hw->idx, (int)req_id);
+#endif
+
+       return cl_msg_cfm_wait(cl_hw, cfm_bit, req_id);
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

