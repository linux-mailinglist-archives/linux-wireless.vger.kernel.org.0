Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839AB3AB93E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhFQQNs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:48 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:15879
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231892AbhFQQMs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k64f8oHv85pvRMBE8JPlW+y08M2A1pZ26KV13uGFiZJlBhZiT++SIpXNFcVGAFSbhiXc/96C7EyfqJK6epVXry4dqI4dKmRqbG/OOpv2Z/I5c7RMc3P1e7akgDkq/J6GuVQTksISBLI8jbrA0POGPxhx+XUIpXnSdUVQEWCZ6H+6h7pLKiQcoy6fiFjs7aa/ux5RncnV28j6mrlwEZ63Hkny2Ks9GkFwuTOtbIyvj7SnkL9saXB0C1rI/RXgyQsQi/r+UiIVjAsAOk/OiMkrh3EY9xTAzlHtOw/KAtRxPqqpnZo3Dwy9bf4koIYjQNnbqJSeiSukNy0eF/7edaIZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62jMvmfm3/xoZkJF6DjJu54WfoYXM/TibLRDXCT6sLA=;
 b=Z0UikkubVx59rCtxqgS5AncArygHWf3tIoTBK+FZfygYlXUnXhZIn5lR7eG4zXCQpHY4Dj4CR7YA82Dj8cTyxwVgdGMDWZLuiWrkNMv2WEiSxYZBSPjdkelnowYSRsGGGVHDj9Ldp4Ef5qid8H8b69DQJMK4crBGds1texU6NUVVDuvEGW7QycfDU60TMw9b7iRTdot1aJv6+cp6hu+4QyqFuIBRxi6i89H4jLmgTylcQrv3YjSMEj9qt5IytZHwUE+iP07Jl/sw4TmsC66piN8GGWkJtAFPpw4GMmrMXf0/W0sY5cpca9xkx1eKDsXHcooMYyBNmkSIPVX5VOilTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=62jMvmfm3/xoZkJF6DjJu54WfoYXM/TibLRDXCT6sLA=;
 b=n2nX6vNrzo94oiRN1sfjvD2lDRnaKeDTjwhGCX7HJ4DK2dTUFfKF4Wv33vieY1IK+3sAvE6EaPawxV1xUz85yYYB+kg6JNe0HjIzjAL6GooVgKhud0eAbwppOWAAkHYdCEqRn87Lh+XDixpmZHXoB6tU6PfJtSlhEPiPnz9XgxI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:19 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:19 +0000
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
Subject: [RFC v1 208/256] cl8k: add tx/single_cfm.c
Date:   Thu, 17 Jun 2021 16:01:35 +0000
Message-Id: <20210617160223.160998-209-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ab610b5-104b-4108-7764-08d931a9daec
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075AFCDC12958FAE2861E9FF60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: No/Uxin0tQPdeGlFOkJR+vYqdJdirGTICS5Gmu8FYM4FT6BAYJpZHSoNOH2lwHDLhdznWAu/xzJvDqhXIi3zk1B0379s4k79c8fbvHMxV7mM774lDmJgoq1xF4jJbdN2blR3utrK5l5hY1OMw0B85ICVdcqTYNYZ+u7g3HzQ779OGq7tgrdg+o6j+hUj7nV++aFrQ82ow9juLMLo0C5B2IfIm+nw5HPaaK/YiyxPKngKCMJXjrvsVA/BCEQwX9bTz0NsLQhlwA2zxcD4XSa/4p6GwDNeJUWjMy2/2cuOb1ufcv65pS87Z/wPOvnm1/REG2E+99zAjLUWdFZyQjcFL8nU+MrQ5evUY1gPFSCOXKtUYVTP26tgykapKn4arOqcMgopYW3ZklFdM+7zNu83t+uIRldD8WopAfc4VQ/5VukGBjnv+F18LMzK3I0ucx4vT7WVVAVegNqFq935AUsQ46ztlatYNqBin654JnoVPihAyHS+YFuWoZYhaIXRooNYySdq0tBIpUa4par2jaGtoA0+8K7jw/wnxQSGgpWOYmh9AC+N9L582g6KaT48abBfA1B79qSbKLlVaPK9E/ej0S9zfrT5HBEuZrM45+gl+3ytW8JkpsSlkNzCRASAFKF5c/E0MFI8CO9dNxtOiG00S3HpDQVhin5+RVHU4dZ/kE68koDQTZYV8NiyBDJ5NmHF1DT86OlrcFSjuQq7QI1ueQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8iwoiNPo07C8RPTEF1VwSyjEzEBh5TBC5UCHxW12lXNTRSkxiL8kf7MLuZRo?=
 =?us-ascii?Q?pC1lawG15ciPfEFns4ZuHez8Iu11BTtLLNLdGm1428HnfCp1VQ2NF1Go61Mx?=
 =?us-ascii?Q?jkSpXDHUz9EX1Q6S8nx6MrUhS7tez9C54+SH0w8t7Ece5EsfkemvSCESRJsq?=
 =?us-ascii?Q?Yens+NvEL5B55Zfob7/f9NekVmOOVgQJ+h3jsCgOtHkY9BRVFtJcbBxzlkGC?=
 =?us-ascii?Q?wNaeHZqAjn2tLM2kW8Pk3cnFmMJZhEy4x06DftjWoKQY+f+dhxtwdj7/Hv+9?=
 =?us-ascii?Q?xunyzDOHU+HiO2J4CYppAXCwUj9vqNDD5u2FClwmRPZV8PNzWQotncN5ox5C?=
 =?us-ascii?Q?QRjjp4hY5YLTZDdzXTvFLHMxezuoNexga8gy9BhrEQPy8CR6zdiSWqS+2npD?=
 =?us-ascii?Q?roxcFJY5oecWqgLrLI8rAXtxnbh33yBT5WyY5cLuHbzSAoj1v6YYcLfSU9MZ?=
 =?us-ascii?Q?gqOtrfwBRy/peD0dQ5DaD+w9VQDUuy5ZqaqN8CDurO9jzxPRJHeQEIs7DP8G?=
 =?us-ascii?Q?jKgdg7jltMx2x8DSqZEfHG4aHVGyLOCLylzOrf7slgQW6R0JzlXsIasCqFBZ?=
 =?us-ascii?Q?qWWXys6v0ggHbSu1/Tmql37DUPMq6M8mCaVDkSb6SosMcUH4MM+xWjyxDAU8?=
 =?us-ascii?Q?d0QpALeYMwf+cD43tG3j5W8/a/XJ/vGn7Z6fFgWsYdi6BfuVEx8PITkZyhKU?=
 =?us-ascii?Q?HoEV74ww7Dc83UlZHZoXyFmn2z5BUbUbDzLLjd/UxGbXePHxQd0dG8ZDzi9A?=
 =?us-ascii?Q?6Yh8Zz35tXtlWMT2jt6wGtUDyDd/zwOXXcoS2Zwpec3K5vzQ4ZCvGeYIKQpP?=
 =?us-ascii?Q?LGF1oCWz8FWATiV1nQCvcLS6MpCkylSjfGS+z5Jnk8NFfm/GWLnWMgShviIS?=
 =?us-ascii?Q?oKBkt3Z5fH/77vArRILOnKcF2tDh/PMB1RV871vb2Kv93Uer7hsvuORiemet?=
 =?us-ascii?Q?cHjoQBGNkrs8+HBKN6OJQhhn8S4RIk/8ctjYV8VR0cW/X9aG9rBjDhZ5a0w4?=
 =?us-ascii?Q?gPuqW1F4IRVEilUC9/uOuY2UkdBVIQ1u9dk74ASeM/vg6E7Iq3WzfItDs9wB?=
 =?us-ascii?Q?WBotpt8Nxpdrs4nGuj3udZbBLVaGCLpvxgBZiwNt8SweuGgrUHIrtjFusGtm?=
 =?us-ascii?Q?55qEBxsbp5nC2xnRQ0vs2ECqfKQXlrcd9Gu2vZZW3CT2eIbAClGVbexSu2Ej?=
 =?us-ascii?Q?GUQ4X6obdcj83lpZLk3nLwIDgzrXfX/YaeXZx3QwSgqzg1O+5PTZW4Ayvg7K?=
 =?us-ascii?Q?Xlt3a0RGopN7hDS1AM20FGFTVPZERTbhCOOR8xxM2rU6jTdeWX32HntAEXix?=
 =?us-ascii?Q?XjTjmFwnS0XyGe+xlBHwyEQP?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab610b5-104b-4108-7764-08d931a9daec
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:24.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GroQceMcauKG/oPrZ2KvwQI0NHlv1Lo/5GKkjlK5qIVLzjrlygJpU83N5QBZiNmeNFjVzg/+gxz4EIxxs02ktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/single_cfm.c  | 214 ++++++++++++++++++
 1 file changed, 214 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/single_cfm.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/single_cfm.c b/drivers/net=
/wireless/celeno/cl8k/tx/single_cfm.c
new file mode 100644
index 000000000000..d90148d3f9bf
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/single_cfm.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/single_cfm.h"
+#include "tx/tx_queue.h"
+#include "tx/tx_inject.h"
+#include "chip.h"
+#include "tx/sw_txhdr.h"
+#include "enhanced_tim.h"
+
+/*
+ * cl_hw->single_cfm_queues:
+ * These queues are used to keep pointers to skb's sent
+ * as singles and waiting for confirmation.
+ */
+
+#define SINGLE_POLL_TIMEOUT 50
+
+void cl_single_cfm_init(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               INIT_LIST_HEAD(&cl_hw->single_cfm_queues[i].head);
+}
+
+void cl_single_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, =
u32 queue_idx)
+{
+       list_add_tail(&sw_txhdr->cfm_list, &cl_hw->single_cfm_queues[queue_=
idx].head);
+}
+
+struct cl_sw_txhdr *cl_single_cfm_find(struct cl_hw *cl_hw, u32 queue_idx,
+                                      dma_addr_t dma_addr)
+{
+       struct cl_single_cfm_queue *cfm_queue =3D NULL;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       struct cl_sw_txhdr *tmp =3D NULL;
+
+       if (queue_idx >=3D MAX_SINGLE_QUEUES)
+               return NULL;
+
+       cfm_queue =3D &cl_hw->single_cfm_queues[queue_idx];
+
+       list_for_each_entry_safe(sw_txhdr, tmp, &cfm_queue->head, cfm_list)
+               if (le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_addr[0]) =
=3D=3D dma_addr) {
+                       list_del(&sw_txhdr->cfm_list);
+
+                       return sw_txhdr;
+               }
+
+       return NULL;
+}
+
+static void cl_single_cfm_flush_queue(struct cl_hw *cl_hw, u32 queue_idx)
+{
+       struct cl_single_cfm_queue *cfm_queue =3D &cl_hw->single_cfm_queues=
[queue_idx];
+       struct cl_tx_queue *tx_queue =3D NULL;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_tx_info *tx_info =3D NULL;
+       dma_addr_t dma_addr;
+
+       if (list_empty(&cfm_queue->head))
+               return;
+
+       do {
+               sw_txhdr =3D list_first_entry(&cfm_queue->head, struct cl_s=
w_txhdr, cfm_list);
+               dma_addr =3D le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_a=
ddr[0]);
+               skb =3D sw_txhdr->skb;
+               tx_info =3D IEEE80211_SKB_CB(skb);
+
+               dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_=
len, DMA_TO_DEVICE);
+
+               if (cl_tx_ctrl_is_inject(tx_info))
+                       cl_tx_inject_cfm(cl_hw);
+
+               cl_tx_single_free_skb(cl_hw, skb);
+               list_del(&sw_txhdr->cfm_list);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+       } while (!list_empty(&cfm_queue->head));
+
+       /*
+        * Set fw_free_space back to maximum after flushing the queue
+        * and clear the enhanced TIM.
+        */
+       tx_queue =3D &cl_hw->tx_queues.single[queue_idx];
+       tx_queue->fw_free_space =3D tx_queue->fw_max_size;
+       cl_enhanced_tim_clear_tx_single(cl_hw, queue_idx, tx_queue->hw_inde=
x,
+                                       false, tx_queue->cl_sta, tx_queue->=
tid);
+}
+
+void cl_single_cfm_flush_all(struct cl_hw *cl_hw)
+{
+       u32 i =3D 0;
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               cl_single_cfm_flush_queue(cl_hw, i);
+}
+
+void cl_single_cfm_flush_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       /* Flush all single confirmation queues of this sta, and reset writ=
e index */
+       u8 ac;
+       u16 queue_idx;
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               queue_idx =3D QUEUE_IDX(sta_idx, ac);
+               cl_single_cfm_flush_queue(cl_hw, queue_idx);
+
+#ifdef CONFIG_CL_PCIE
+               cl_hw->ipc_env->ring_indices_elem->indices->txdesc_write_id=
x.single[queue_idx] =3D 0;
+#endif
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_single_cfm_poll_timeout(struct cl_hw *cl_hw, u32 queue_idx)
+{
+       /*
+        * When polling failed clear the enhanced TIM so that firmware will
+        * not try to transmit these packets.
+        */
+       struct cl_tx_queue *tx_queue =3D &cl_hw->tx_queues.single[queue_idx=
];
+
+       cl_dbg_err(cl_hw, "Polling timeout (queue_idx =3D %u)\n", queue_idx=
);
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+       cl_enhanced_tim_clear_tx_single(cl_hw, queue_idx, tx_queue->hw_inde=
x,
+                                       false, tx_queue->cl_sta, tx_queue->=
tid);
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_single_cfm_poll_empty(struct cl_hw *cl_hw, u32 queue_idx)
+{
+       struct cl_single_cfm_queue *cfm_queue =3D &cl_hw->single_cfm_queues=
[queue_idx];
+       bool empty =3D false;
+       int i =3D 0;
+
+       if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+               return;
+
+       while (true) {
+               spin_lock_bh(&cl_hw->tx_lock_single);
+               empty =3D list_empty(&cfm_queue->head);
+               spin_unlock_bh(&cl_hw->tx_lock_single);
+
+               if (empty)
+                       return;
+
+               if (++i =3D=3D SINGLE_POLL_TIMEOUT) {
+                       cl_single_cfm_poll_timeout(cl_hw, queue_idx);
+                       return;
+               }
+
+               msleep(20);
+       }
+}
+
+static bool list_hp_empty_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       struct cl_single_cfm_queue *hp_cfm_queue =3D &cl_hw->single_cfm_que=
ues[HIGH_PRIORITY_QUEUE];
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+
+       list_for_each_entry(sw_txhdr, &hp_cfm_queue->head, cfm_list)
+               if (sw_txhdr->sta_idx =3D=3D sta_idx)
+                       return false;
+
+       return true;
+}
+
+static void cl_single_cfm_poll_empty_hp(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       bool empty =3D false;
+       int i =3D 0;
+
+       if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+               return;
+
+       while (true) {
+               spin_lock_bh(&cl_hw->tx_lock_single);
+               empty =3D list_hp_empty_sta(cl_hw, sta_idx);
+               spin_unlock_bh(&cl_hw->tx_lock_single);
+
+               if (empty)
+                       return;
+
+               if (++i =3D=3D SINGLE_POLL_TIMEOUT) {
+                       cl_single_cfm_poll_timeout(cl_hw, HIGH_PRIORITY_QUE=
UE);
+                       return;
+               }
+
+               msleep(20);
+       }
+}
+
+void cl_single_cfm_poll_empty_sta(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       /*
+        * Poll all single queues belonging to this station, and poll all
+        * packets belonging to this station in the high priority queue.
+        */
+       u8 ac;
+       u16 queue_idx;
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               queue_idx =3D QUEUE_IDX(sta_idx, ac);
+               cl_single_cfm_poll_empty(cl_hw, queue_idx);
+       }
+
+       cl_single_cfm_poll_empty_hp(cl_hw, sta_idx);
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

