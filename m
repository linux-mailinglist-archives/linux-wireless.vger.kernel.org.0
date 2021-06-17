Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111173AB90F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhFQQMM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:12 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:21118
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233885AbhFQQLF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXvhQjhu5lwiECfs3AYMbgMSguvJ16MS8TU+Bb0V5W6shQbws7kw1EIdGxxx+bqGHi1NetYumgv+FtBnFkL9m0oluzmjV2qveNTspPdnj0NjT6eRfsli/lV6o8XxPB3WsOF4Njo5dVmVqOQlWHS79Uh+EceIvCxHu9+5IO1nsRHvb69udgZq2zRZMz0wQ3O/U+CSQ1mPdW5BywtnbtUrvYmialBXIhZI4XT5sB1loeK0w7Epe7Mu1PZ+HWM/VqlW+0lJ+L98rHF7ZOJZ3DgzYEM0t93EoG0dRKbvlgDJKSo05b4Cwf2EA23PhnshDWAIgdmEPalsWUKBrzjq6xCSyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMy1IgYmh+3XFj8JWlZWIJKVxp0jA+lDsW0k2RsPmnI=;
 b=LvQGtGN0whqthdACJdlzuFG9lz1ZfGOyBiViuujhJ+CkaIuJ9qsfr+L6x8J69IzL33FEJlrxhiTpRuTV6LbhibumQUAVPwLBRDR7dZaX0+4VnEy/VUJve0SUaTX5bAJOE7saYEmJ5Fqi71nGu9vg2RBxtP05Z/JYo71S6AIEoWxy+tg7sa5PnBi5IglWczt4WOw8iCrqNgTCrXS98Y7YV++vi7z8PqORWZPU52a6aotiIgnxEBLezctRPDvWc2fDSWYqEmnwiFvS/WpAtBsFRYVLnSIyYCKJ8BbNSho7uYiScl4o1TQtK85fWzatdg1rBGgOn6ic7zXN7OmwGFDN1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMy1IgYmh+3XFj8JWlZWIJKVxp0jA+lDsW0k2RsPmnI=;
 b=ombt1aKeEKCPGE9IlAofCamTDq8VCg4EIVga9jj1Ctf7ega0NiPfSmeTI4M3miMYRTvnALBwlP8uEATpLJFftofwentOPMghCxKuZwjGdZm7hdRj1Pmed9IJZ2rcomg7cc6cQaioP6WPsZo294ZG/0UxWhCvSyk3TjtXNZrRR+0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:16 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:16 +0000
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
Subject: [RFC v1 200/256] cl8k: add tx/agg_cfm.c
Date:   Thu, 17 Jun 2021 16:01:27 +0000
Message-Id: <20210617160223.160998-201-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb59f9c9-6b8d-47ef-bf22-08d931a9d5e1
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075AA98A961509AB62F9565F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJ4Kkilr1sksiM4WAjlSnranxOzl3mo6J4d0CJ4oStDS47C2Y96OtfkZRf0KwmiaIodbOmQguWjpFVXKEq2M00lKLhjAge4k6Jt/pPpcHLDkwTjqNe2W2cst5qGM6ei3CD+TzhY4O7x9P3fP/o3zZbH/K5yJKM+sjCGZ7oGP34eVByE7BKlHu1ax/2E2C7WgwpM5yJ7WsNbaDYQFOyQNVT9Byix8gp/Ppq5IXWbpAT+enhajePdDwJn04B1jGl6U8Ixmk3w52mCy+06XzVrdKys2jVEKvHqesL6jlF5tBJnOm4nmj04OxiSMDXB1clgZuWN3Ixtb6LndmrCAVaMaV+8BAdual0lmxpcbua80kcr5kCsVpipidQfvldc2bK6mn6IYFWnuiQT0K0ZK+UGdBUSS1gVobwShBhUZUBNOci6gOZIjOj16UiaIilaLfOd67OWHs5kQU8dREfgbq04snmETgC7/1OZeE/zPgyuEjnYbSPEyMkSCjiPn37Em47P5vPcIrGBs5gyTlMYPyDSOs2W8PO4S8MOSa9LWzvQ1r8lLvTMnOOPKUskGbiIiqeNGw2TrnJsytyPBDaOM4eUpAhidOMQnmGmyHitVMeMrx9vzJ19147mpyDXrqec+7fTUXylZw0QXoGRPV0+9U/WeofCyAXfE+edwf8ETagtl/ugieNT0YKH8oGUsSCnjxCXgh6DP0UdZp1wZCRxDyXKtMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?stneVc0wjhM0JjGabHBzTKPuWfiuo2HMsml+UqLKVVs6XZPqEMD5ORn593vm?=
 =?us-ascii?Q?Cm2r5O+ZD00Y7adWCUitawiGte+YI/373ZfxO+92+gYhHOEMKM5zuCeHU5nU?=
 =?us-ascii?Q?CChgBFHSfVCYjYdhl8NKulZ5i8hDYoUwS8daFQY9Xco5PqUUxlp4wt7wqR5m?=
 =?us-ascii?Q?F4z2hRKcnHOU/P7SXfa1/pwp7U5nityu7yubNRFJ+vdqBlWl77vnQL5UnPy9?=
 =?us-ascii?Q?RrGdUr9dgO5CmdejYqtlQ7ZYJHBnYDOKXPW0cV7tPVtBXDGJm2echCvHMolr?=
 =?us-ascii?Q?5HJuWK1gkE/aT+USoYqJfkHQxbGCkrFTIc3BjIWSUksytzw36YU9CeO38L7f?=
 =?us-ascii?Q?kodtGj1hUfYCpSyb4aqog5v66B2oBcSFx7EKPm+PH/u11JuhhLMYboDSdrDL?=
 =?us-ascii?Q?53WvYiXtX2416+5lPuMy0Wmxum84VF6SUoHf+7X0D/IANihotSO5m/6B4uql?=
 =?us-ascii?Q?LuF15H4b0zg53RzHBM/4Zf02I38BRCNMKm+CDHpsWCfVmD3KQS5dYjWJLfcF?=
 =?us-ascii?Q?M5r0L37RH/hqBQ2KghDGIjrwcLGbR2Rb+ANXiITrfIdR/+1IGVDA47eIecfg?=
 =?us-ascii?Q?G+3RAtRvyYwdvwf2dW4t54x6Fiv7SzwjiSWvc8hpPgT2fx/Cjf9IwoPvGq5R?=
 =?us-ascii?Q?86JRmwWwe/vub2ll5T0TfoCI5Z9epNB9oZiRY+ivr3/rWrPJa95kjsOLvCxO?=
 =?us-ascii?Q?mIFlIluoxu5iA/n6wmSNougJWGJcl9aipt13Ort9rJgPfvsl5pwciFIUg5m3?=
 =?us-ascii?Q?siNVi7li69Phqhe3G/Y+AMGwBT4KM6tLbKvRvWsC57gikJP5mEx25vE/mC6j?=
 =?us-ascii?Q?lHwNILmilnFO6CTtd8m7+TZyHaHN6QnJo9q0N/wZDbzZugZxuyldShV+gN/x?=
 =?us-ascii?Q?ihHoUQr2h59Zcwi1lvocr0oCEdB0JB1Cxbcx/TjbdstXBey8J2ikaIBKKHQJ?=
 =?us-ascii?Q?C70ZUCusI00/sMpwo3rUcwknMAu6apfCWlhYdc5xD0n2/92UpxmrPAzJAuHF?=
 =?us-ascii?Q?J00oCMuwHgDYGZS6qWFC5RMwyfxBP6K7/OBWarbEUV/pSDQQc0JR0cqEW1uJ?=
 =?us-ascii?Q?TamcyihSJoYcv9bErsv4USKI5J9WOuhuPY1W4v395wLHT3MP5JZ093idt6nV?=
 =?us-ascii?Q?yn8FXoZXc6n9BPFWDGgl0dvdmyVe2pOwJ7ZVsIevBY4YJlHgwtK9YIDc49jN?=
 =?us-ascii?Q?N+7PA0KQrOeRk5UqaGKXzZ+vgVj/VfzD/h3nT90T/W9BFmw5zb/8r/oZs1K/?=
 =?us-ascii?Q?JcWv9LwG6IdMYVRzK7vx50kBAWs89N+yPhnferIT4/ZBqEbohu6YDifC573B?=
 =?us-ascii?Q?wxNpo8W3phrUXx3rcACxQAcU?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb59f9c9-6b8d-47ef-bf22-08d931a9d5e1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:15.9003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fiaz7BSYMA8fFgV8Rdp2OscnhJKnzPitHC7dN08PopvNrCGGzRXvBp3nIVY1fPddM1F27yWWGYWicbQeKtW2Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.c | 219 ++++++++++++++++++
 1 file changed, 219 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_cfm.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/agg_cfm.c b/drivers/net/wi=
reless/celeno/cl8k/tx/agg_cfm.c
new file mode 100644
index 000000000000..a3c74f57f197
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/agg_cfm.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/agg_cfm.h"
+#include "sta.h"
+#include "enhanced_tim.h"
+#include "tx/sw_txhdr.h"
+#include "chip.h"
+#include "tx/tx_inject.h"
+#include "tx/tx_amsdu.h"
+
+#define AGG_POLL_TIMEOUT 50
+
+/*
+ * cl_hw->agg_cfm_queues:
+ * These queues are used to keep pointers to skb's sent
+ * as aggregation and waiting for confirmation.
+ */
+
+void cl_agg_cfm_init(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               INIT_LIST_HEAD(&cl_hw->agg_cfm_queues[i].head);
+}
+
+void cl_agg_cfm_add(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr, u8 =
agg_idx)
+{
+       spin_lock(&cl_hw->tx_lock_cfm_agg);
+       list_add_tail(&sw_txhdr->cfm_list, &cl_hw->agg_cfm_queues[agg_idx].=
head);
+       spin_unlock(&cl_hw->tx_lock_cfm_agg);
+}
+
+static void cl_agg_cfm_amsdu_free(struct cl_hw *cl_hw, struct cl_sw_txhdr =
*sw_txhdr)
+{
+       struct cl_amsdu_txhdr *amsdu_txhdr =3D NULL;
+       struct cl_amsdu_txhdr *tmp =3D NULL;
+       struct sk_buff *sub_skb =3D NULL;
+       struct ieee80211_tx_info *tx_info_sub_skb =3D NULL;
+
+       list_for_each_entry_safe(amsdu_txhdr, tmp, &sw_txhdr->amsdu_txhdr.l=
ist, list) {
+               sub_skb =3D amsdu_txhdr->skb;
+               tx_info_sub_skb =3D IEEE80211_SKB_CB(sub_skb);
+
+               if (cl_tx_ctrl_is_inject(tx_info_sub_skb))
+                       cl_tx_inject_cfm(cl_hw);
+
+               list_del(&amsdu_txhdr->list);
+               dma_unmap_single(cl_hw->chip->dev, amsdu_txhdr->dma_addr,
+                                (size_t)sub_skb->len, DMA_TO_DEVICE);
+               kfree_skb(sub_skb);
+               cl_tx_amsdu_txhdr_free(cl_hw, amsdu_txhdr);
+       }
+}
+
+void cl_agg_cfm_free_head_skb(struct cl_hw *cl_hw,
+                             struct cl_agg_cfm_queue *cfm_queue,
+                             u8 ba_queue_idx)
+{
+       struct cl_sw_txhdr *sw_txhdr =3D list_first_entry(&cfm_queue->head,
+                                                       struct cl_sw_txhdr,
+                                                       cfm_list);
+       struct sk_buff *skb =3D sw_txhdr->skb;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(skb);
+       dma_addr_t dma_addr =3D le32_to_cpu(sw_txhdr->txdesc.umacdesc.packe=
t_addr[0]);
+
+       dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_len, DMA=
_TO_DEVICE);
+
+       /* If amsdu list not empty free sub MSDU frames first, including am=
sdu_txhdr */
+       if (cl_tx_ctrl_is_amsdu(tx_info))
+               if (!list_empty(&sw_txhdr->amsdu_txhdr.list))
+                       cl_agg_cfm_amsdu_free(cl_hw, sw_txhdr);
+
+       if (cl_tx_ctrl_is_inject(tx_info))
+               cl_tx_inject_cfm(cl_hw);
+
+       consume_skb(skb);
+       list_del(&sw_txhdr->cfm_list);
+       cl_sw_txhdr_free(cl_hw, sw_txhdr);
+}
+
+static void cl_agg_cfm_flush_queue(struct cl_hw *cl_hw, u8 agg_idx)
+{
+       struct cl_agg_cfm_queue *cfm_queue =3D &cl_hw->agg_cfm_queues[agg_i=
dx];
+       struct cl_tx_queue *tx_queue =3D cfm_queue->tx_queue;
+       struct sk_buff *skb =3D NULL;
+       struct cl_sw_txhdr *sw_txhdr =3D NULL;
+       dma_addr_t dma_addr =3D 0;
+       struct ieee80211_tx_info *tx_info;
+
+       if (!tx_queue)
+               return;
+
+       if (list_empty(&cfm_queue->head))
+               return;
+
+       do {
+               sw_txhdr =3D list_first_entry(&cfm_queue->head, struct cl_s=
w_txhdr, cfm_list);
+               skb =3D sw_txhdr->skb;
+
+               dma_addr =3D le32_to_cpu(sw_txhdr->txdesc.umacdesc.packet_a=
ddr[0]);
+               dma_unmap_single(cl_hw->chip->dev, dma_addr, sw_txhdr->map_=
len, DMA_TO_DEVICE);
+
+               tx_info =3D IEEE80211_SKB_CB(skb);
+
+               /* If amsdu list not empty free sub MSDU frames first, incl=
uding amsdu_txhdr */
+               if (cl_tx_ctrl_is_amsdu(tx_info))
+                       if (!list_empty(&sw_txhdr->amsdu_txhdr.list))
+                               cl_agg_cfm_amsdu_free(cl_hw, sw_txhdr);
+
+               tx_queue->total_fw_cfm++;
+
+               if (cl_tx_ctrl_is_inject(tx_info))
+                       cl_tx_inject_cfm(cl_hw);
+
+               kfree_skb(skb);
+               list_del(&sw_txhdr->cfm_list);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+       } while (!list_empty(&cfm_queue->head));
+
+       /*
+        * Set fw_free_space back to maximum after flushing the queue
+        * and clear the enhanced TIM.
+        */
+       tx_queue->fw_free_space =3D tx_queue->fw_max_size;
+       cl_enhanced_tim_clear_tx_agg(cl_hw, agg_idx, tx_queue->hw_index,
+                                    tx_queue->cl_sta, tx_queue->tid);
+
+       cfm_queue->tx_queue =3D NULL;
+}
+
+void cl_agg_cfm_flush_all(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       /* Don't use BH lock, because cl_agg_cfm_flush_all() is called with=
 BH disabled */
+       spin_lock(&cl_hw->tx_lock_cfm_agg);
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               cl_agg_cfm_flush_queue(cl_hw, i);
+
+       spin_unlock(&cl_hw->tx_lock_cfm_agg);
+}
+
+static void cl_agg_cfm_poll_timeout(struct cl_hw *cl_hw, struct cl_tx_queu=
e *tx_queue,
+                                   u8 agg_idx, bool flush)
+{
+       /*
+        * When polling failed clear the enhanced TIM so that firmware will
+        * not try to transmit these packets.
+        * If flush is set cl_enhanced_tim_clear_tx_agg() is called inside
+        * cl_agg_cfm_flush_queue().
+        */
+       cl_dbg_err(cl_hw, "Polling timeout (queue_idx =3D %u)\n", agg_idx);
+
+       spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+
+       if (flush)
+               cl_agg_cfm_flush_queue(cl_hw, agg_idx);
+       else
+               cl_enhanced_tim_clear_tx_agg(cl_hw, agg_idx, tx_queue->hw_i=
ndex,
+                                            tx_queue->cl_sta, tx_queue->ti=
d);
+
+       spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+}
+
+void cl_agg_cfm_poll_empty(struct cl_hw *cl_hw, u8 agg_idx, bool flush)
+{
+       struct cl_agg_cfm_queue *cfm_queue =3D &cl_hw->agg_cfm_queues[agg_i=
dx];
+       bool empty =3D false;
+       int i =3D 0;
+
+       if (test_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags))
+               return;
+
+       while (true) {
+               spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+               empty =3D list_empty(&cfm_queue->head);
+               spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+
+               if (empty)
+                       return;
+
+               if (++i =3D=3D AGG_POLL_TIMEOUT) {
+                       cl_agg_cfm_poll_timeout(cl_hw, cfm_queue->tx_queue,=
 agg_idx, flush);
+                       return;
+               }
+
+               msleep(20);
+       }
+}
+
+void cl_agg_cfm_poll_empty_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       int i =3D 0;
+       struct cl_tx_queue *tx_queue =3D NULL;
+
+       for (i =3D 0; i < IEEE80211_NUM_TIDS; i++) {
+               tx_queue =3D cl_sta->agg_tx_queues[i];
+
+               if (tx_queue)
+                       cl_agg_cfm_poll_empty(cl_hw, tx_queue->index, false=
);
+       }
+}
+
+void cl_agg_cfm_set_ssn(struct cl_hw *cl_hw, u16 ssn, u8 idx)
+{
+       spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+       cl_hw->agg_cfm_queues[idx].ssn =3D ssn;
+       spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
+}
+
+void cl_agg_cfm_set_tx_queue(struct cl_hw *cl_hw, struct cl_tx_queue *tx_q=
ueue, u8 idx)
+{
+       spin_lock_bh(&cl_hw->tx_lock_cfm_agg);
+       cl_hw->agg_cfm_queues[idx].tx_queue =3D tx_queue;
+       spin_unlock_bh(&cl_hw->tx_lock_cfm_agg);
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

