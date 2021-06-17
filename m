Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD53AB85D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFQQHX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:23 -0400
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:43502
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231649AbhFQQGy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJSLF3B3bv2trjk/6OHENgU8A4vwQHxz6+IQD5Z3KGZRhLhOGbvuMgIiVNVpIgQWonXPwC4PhXJyGKmYA4AogMiMG/Pzs6k9JdGQFcKIE1W2LnwZlFSsAV/hxl/FTgcgWrb9R2RULlLfD/vNg5HXCcIvHJb5C1CT27TTxD064ydDzIU5txtw9nWTVGYkZBQALxk8d0cb4FBXx+i4AlVzIGa6e++NMY8pjkLDQaNdIiVOephkoU8Y0g89dv2OYNAmmYtVO4jnZwv9sojLUyrCUfLG7JppcCpbL5JJ0pdKNy+p1HE6jFVCt+nA7JoqAQgv6jJXR2SSUKGo94nPi3EMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t36YL8aex4578GW0N37cv4n5bc8LOr5ZxXMJw4LDo5Y=;
 b=GQqGQbbWc8IwXoXWkAHc3lns3E7dL3G04JBwisIdpaVKj6cIWM82H/r4VnOHQniJ2WTb3xIA+amVkmz9iOJKYxt0AyQx6/Ey8PJhfcLwVKifaDFEnov+vOShTE5v9muCWO2gZ+oW2lsXGdI8BLgwhHKEv8FObhqgMgbf6EJfU1MWK0WRBDYlofTYM1kAI6k8ArqPgh9TQrhcqKk78gs9ngCeApokjV3ZR1KuZkbT8QUmVTvkkI8fUWx62rwbOWyGCQlJyL5Cpkb2pLA7MlqNE7urhJaWV1Ea0+qYokAyyKU7iDrbOHkVpVlWqEbEr/+uLAKIKdqEi4A2l5ofZOc9bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t36YL8aex4578GW0N37cv4n5bc8LOr5ZxXMJw4LDo5Y=;
 b=WKTWakhSBJUbaSb+Htc6IpemmJRzBEiESJxm2vLZ91HmaopW6Z0n9Rh1w4lVekOwJ4Is2gWdY7BDM+7FZjzA+jQ7tDi+0PmAfG/DcrR9qRwDo4uxJVuQKiAsGmvM73vY1KVtH12WOXcfI28A3Dk6dRD7kNgRdC9XZa9f6MwNeV0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:19 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:19 +0000
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
Subject: [RFC v1 062/256] cl8k: add dfs/radar.c
Date:   Thu, 17 Jun 2021 15:59:09 +0000
Message-Id: <20210617160223.160998-63-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dee548d9-40e9-41c0-571a-08d931a97a52
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268DCA9611DAF068F671BD6F60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nRCDWXY/kkymwzccvfz4ZII9TuJAywppQVVjRq6I0Ly8rRMcdL6l3yKjTIykuX7/Cqul9y5lvaNbg/bfGPLu45QJMce7d5KV8fTGGXsvHA3hqdwyLiehCnfCJEI2VanTwYuMZm+Th41b/UNMM7Ycm7h9H3GcyWpsy43mlH4ELUpXZ+URl+r6D9WdchV2N2f68Q0bEQbxURiDpP8/W6UywdNJS/+xxYAfxECnE1B9gjHBWkMYjfnkNjMaPUmb+5MyLZjKGDRF+pj0kQcUpV3e5rTc5dbudNpN0T0XHdPQyZq4J0FPDaqBGvojnznHGmrHmHWI55d/va8scPK/XkHDylA/ZzE4emG0ho5E+GkgGGdPcAJv5GiubOBLSM4MzesOhn8N3y4NFbg7sGl9Ys6273Kiy0ZmPFQ999tnSpE+wWS/8rUpLcpH86IE9jlTcHZQnOTGW2T+Ao1K7nq8C6lju0c4G7CHvomNfmSYvbF6hRPVudEPpvTNvGAt8z5bJvsdWM7Ggaafu9X9B3w1JOu6CycM62Kj/ISVIGREHksrCOEBAyJaQitqGEwdoVu5PAF7KxvE3RRtGdOi8I83xmozaH5hJXBMh7nSpRbTylM2pTaCyGTY5n904hzD669R0Ym3KqNl0LmSDeb6c3Lv51bmmLYnJKYxD03i2Hk+WdU0q619mQuy1Vw6C+b0+HwMkWLWGR/5nK83N3n5m9Zw/toPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMXKMNDDW2mc5oktkmRUlPYdm7AZtaa0L7ao+bdiXrPxZyBu4b27XwmOoM30?=
 =?us-ascii?Q?Oep29UDu+ycVuEoMfSqWXo2UKNC8wLinJ1lIqzfjljRYtN9ZZQCgtzDawnLl?=
 =?us-ascii?Q?9/g/SSlaH7dPbCacCG++0qvGzS49icqpKzMCrBWnXTAm3UksiSPywcdAN+1r?=
 =?us-ascii?Q?O6er7qB++HVO36mexIchUebxanBI3DQei5MHxILdERbPcaVwv1qM3sC4wQsT?=
 =?us-ascii?Q?1K98Y/7T9MW2Hwg5Dp6YcdYwgPcld8FnaaGwYf6c9x/7lgUL8zfk3xxo1dvC?=
 =?us-ascii?Q?uaFBqhRn1puKv8CB3UuHoxWxZ3IbViYOtfCwLdyV+zKOgz3lgewss7u4qdmO?=
 =?us-ascii?Q?yDv80tSjIWI/K52cIEg6kqpUVwFqvL7rEtz2reWsDi65x3N+uIe+ZG4CI1gt?=
 =?us-ascii?Q?9YbQYuE/O5yh/Me8cPrHxz45mUhWhgzQqXdHMT6/hI6EL93ZQ7nm7GOj3Q2+?=
 =?us-ascii?Q?3gX3T984VJGdib10mtq1pkL72kqFsxffam5MnMqKns3on2D376WAUR1WvI/Y?=
 =?us-ascii?Q?GL89S0QAclrOKWgatvr7OMdDJrLomGsfYYH+lS49Ll0YJsynbpStLtNVKyp6?=
 =?us-ascii?Q?0CRsxJ+l+HoTgKmFutlowWuzhqOv4Y0LaEtc8doPp4XrRJe3vqDWDslujs3e?=
 =?us-ascii?Q?bg1LNF5HosucHjDWLrQDsZv7M4TrWG26A+D5UF5zXGUqqkdwoala5Ksb+46z?=
 =?us-ascii?Q?WEakwqy4kWTnuJuw1CYuZ5JgyG41z4exKksMhS2IdCAmWtGhV+gu/UPFwuG8?=
 =?us-ascii?Q?xSZvwrQb7BQyW2tb30vnSNN9qIxF4Q4nf68h75UuS/B9T1OtnGHQ3QiPTN8f?=
 =?us-ascii?Q?7sQE0dcPPaD0RwUxbP7/4cDxtq42T/4YPl1W/PTadTtA1/r46MMTaIlpdFG8?=
 =?us-ascii?Q?wCB0lKDlK0k8dTkqepTW4lVptVqnANf80kzV4HeksFbchE6A3X//mnEBC2Fx?=
 =?us-ascii?Q?8U3qJx4nwDEHjLuojjXi0ZUzSpWB7IJ2yB2m/DVduVdNDnTZ+hPnWkn21KBP?=
 =?us-ascii?Q?247EQc4HyqJ4OU21h3Zglplg3s7/pSlaroeFho65PV43b+iLu3KX0GcVJjRi?=
 =?us-ascii?Q?ENofQ1JYjfrO7R2U7wmbP6WwpEklDVlOxXZm9RHjsVuJeD7DLodh7UtxfQRo?=
 =?us-ascii?Q?8UZwTr8Qd0nHJyjfC2K5rRk6MuXzi2Y4THmh0nyxLRvLLxjOHkFvXyVg1rds?=
 =?us-ascii?Q?T70cOzqcDK4Gvs7YSOK3PPUwLnmlZWadTLL4tQ7nJpR3c+gkj6O+lmEqgKJO?=
 =?us-ascii?Q?fOhbw8KyHOtw77BoeYddfl3Uk0BEf1EB8qSlSn9cRnkyKMVKvVXQ4fUomaY9?=
 =?us-ascii?Q?DJNXzJLjzRuBk07ewUP07K+0?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee548d9-40e9-41c0-571a-08d931a97a52
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:42.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wWIbeHXM+442tzwiabDLzrelQxUg8aWx8gmCR363mtzZyjbD4owqpjXodlrgLYKToMjEnpsPy1aKIbJY8YpKUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dfs/radar.c | 116 +++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/radar.c

diff --git a/drivers/net/wireless/celeno/cl8k/dfs/radar.c b/drivers/net/wir=
eless/celeno/cl8k/dfs/radar.c
new file mode 100644
index 000000000000..3f763e274102
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs/radar.c
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "dfs/radar.h"
+#include "dfs/dfs.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/irq.h"
+#include "ipc_shared.h"
+#endif
+
+static void cl_radar_handler(struct cl_hw *cl_hw, struct cl_radar_elem *ra=
dar_elem,
+                            unsigned long time)
+{
+       /* Retrieve the radar pulses structure */
+       struct cl_radar_pulse_array *pulses =3D radar_elem->radarbuf_ptr;
+
+       cl_dfs_pulse_process(cl_hw, (struct cl_radar_pulse *)pulses->pulse,
+                            pulses->cnt, time);
+}
+
+static void cl_radar_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_radar_queue_elem *radar_elem =3D NULL;
+       unsigned long flags =3D 0;
+
+       while (!list_empty(&cl_hw->radar_queue.head)) {
+               spin_lock_irqsave(&cl_hw->radar_queue.lock, flags);
+               radar_elem =3D list_first_entry(&cl_hw->radar_queue.head,
+                                             struct cl_radar_queue_elem, l=
ist);
+               list_del(&radar_elem->list);
+               spin_unlock_irqrestore(&cl_hw->radar_queue.lock, flags);
+
+               cl_radar_handler(radar_elem->cl_hw, &radar_elem->radar_elem=
,
+                                radar_elem->time);
+
+               kfree(radar_elem->radar_elem.radarbuf_ptr);
+               kfree(radar_elem);
+       }
+
+#ifdef CONFIG_CL_PCIE
+       if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+               cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.radar);
+#endif
+}
+
+void cl_radar_init(struct cl_hw *cl_hw)
+{
+       INIT_LIST_HEAD(&cl_hw->radar_queue.head);
+
+       tasklet_init(&cl_hw->radar_tasklet, cl_radar_tasklet, (unsigned lon=
g)cl_hw);
+
+       spin_lock_init(&cl_hw->radar_queue.lock);
+}
+
+void cl_radar_push(struct cl_hw *cl_hw, struct cl_radar_elem *radar_elem)
+{
+       struct cl_radar_queue_elem *new_queue_elem =3D NULL;
+       u32 i;
+
+       new_queue_elem =3D kzalloc(sizeof(*new_queue_elem), GFP_ATOMIC);
+
+       if (new_queue_elem) {
+               new_queue_elem->radar_elem.radarbuf_ptr =3D
+                       kzalloc(sizeof(*new_queue_elem->radar_elem.radarbuf=
_ptr), GFP_ATOMIC);
+
+               if (new_queue_elem->radar_elem.radarbuf_ptr) {
+                       new_queue_elem->radar_elem.dma_addr =3D radar_elem-=
>dma_addr;
+                       new_queue_elem->radar_elem.radarbuf_ptr->cnt =3D
+                               le32_to_cpu(radar_elem->radarbuf_ptr->cnt);
+
+                       /* Copy into local list */
+                       for (i =3D 0; i < ARRAY_SIZE(radar_elem->radarbuf_p=
tr->pulse); i++)
+                               new_queue_elem->radar_elem.radarbuf_ptr->pu=
lse[i] =3D
+                                       le64_to_cpu(radar_elem->radarbuf_pt=
r->pulse[i]);
+
+                       new_queue_elem->time =3D jiffies_to_msecs(jiffies);
+                       new_queue_elem->cl_hw =3D cl_hw;
+
+                       spin_lock(&cl_hw->radar_queue.lock);
+                       list_add_tail(&new_queue_elem->list, &cl_hw->radar_=
queue.head);
+                       spin_unlock(&cl_hw->radar_queue.lock);
+               } else {
+                       kfree(new_queue_elem);
+               }
+       }
+}
+
+void cl_radar_tasklet_schedule(struct cl_hw *cl_hw)
+{
+       tasklet_schedule(&cl_hw->radar_tasklet);
+}
+
+void cl_radar_flush(struct cl_hw *cl_hw)
+{
+       struct cl_radar_queue_elem *radar_elem =3D NULL;
+       unsigned long flags =3D 0;
+
+       spin_lock_irqsave(&cl_hw->radar_queue.lock, flags);
+
+       while (!list_empty(&cl_hw->radar_queue.head)) {
+               radar_elem =3D list_first_entry(&cl_hw->radar_queue.head,
+                                             struct cl_radar_queue_elem, l=
ist);
+               list_del(&radar_elem->list);
+               kfree(radar_elem->radar_elem.radarbuf_ptr);
+               kfree(radar_elem);
+       }
+
+       spin_unlock_irqrestore(&cl_hw->radar_queue.lock, flags);
+}
+
+void cl_radar_close(struct cl_hw *cl_hw)
+{
+       cl_radar_flush(cl_hw);
+       tasklet_kill(&cl_hw->radar_tasklet);
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

