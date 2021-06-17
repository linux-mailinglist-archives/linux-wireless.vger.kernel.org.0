Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BAC3AB939
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhFQQNo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:44 -0400
Received: from mail-eopbgr80072.outbound.protection.outlook.com ([40.107.8.72]:12391
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229683AbhFQQMk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brmDKNI5M4ATNkJH1dSvZdPtM/gWh5nVsKdGxxR+YmvXHUXxHAn4uZf0yCL2eP7zqCWKlVMZq5T+2hDc8IEFjlptKBWdq5sn0xP7gyjeg0uD+ucBiXU+X58BIy2NQv0MsR/Wn9UbJwXJrwFrwjRUdc966zMHW+uNobyidhnQ139qTQ9cR02+PiuTFHqlwsqt+mGz/MkqrkDe1H0RMmJ28kvgLb5xH5Sd90UD+16ltAxfw+mHA+gWj4/0GeQqVXqGj1ns2xiPb/BIkDYoaLg41RzH17Mp5fc+C61Hg63JjO7g8AEtJMc6vpUqq2UNPxoW9zvmPRpWSZq8SW1ccpoJuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZnVJoZ4fdt1b3qmWzL6CQjPkMFf+0TG6kRUZLbg6Bg=;
 b=J4C4975tqBmbTUdFJC5riS7vze1Rr0SIoGJKgll8QnWkSFYzjw4xQ3splvKPOwG0UYSWVdY4o2h8MVIN+W4utALS7f7KW5jgWKu5K6USysPOlkcGPdKVPtOiiiXAL9VPwqUANKVxSxFuZeEiy1iQUHkB06OlYc5PWN72IVWO14tXOOgP1lhWVrgGIixcu5nmwJFF3SjhNzmwlDaTklyAtBvYNRlXjOvps5BrCAYo91Hz9fAfXkZSuD81N/Ehv5+k2GYcyM5PhYd9cJnoNb83u1Io0/BKqrz/XxzabUG0sTDgwYYjgJ/yh5a7q4cUEM87WVm9jYAM+5i1UsCWOolYmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZnVJoZ4fdt1b3qmWzL6CQjPkMFf+0TG6kRUZLbg6Bg=;
 b=Fdav82QX9KBcJ9izb0spw0NKqWbZ0DXXpiv03ep30Hq3QL0cYRb7vOmD7RmefAGUk4x1CpPnOj8ge+goRiFJU+/EBDGSAC10UH4lu1C1ZOBhk+tttulUh+WeJrVExQ13nh9OTWyhgTGU1y8KslIcZyUF15nzTnEMSG7Pnr1wPQc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1329.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:07:52 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:52 +0000
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
Subject: [RFC v1 218/256] cl8k: add tx/tx_queue.c
Date:   Thu, 17 Jun 2021 16:01:45 +0000
Message-Id: <20210617160223.160998-219-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10547838-7774-48b5-7c02-08d931a9e287
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1329DA877C37DAF992D30805F60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DaS20mFmAFQTMI0gRY9qOzYMnn9CjSFvgsqQdFbRYTzQxpCzxp49GZBJXml1B8omrisp1VV5pbxHoPDEDeE4zEiovofekt8NYJ8pa5NK4TlxfCoyDj+m3Rugvq3VIOmcWUGxoVQxh1Q16HmNfufZ464ElP+K3pokqA18Rrm1jf4CHRWN1e+1eJwatewwW/xZ06kolnzpJUBsTSbDI/GxpMBKDpwjaAjoUHlImFHni0KxCtki6PylOXFybb2xEdZKIYCupxVOadQgDgMS8gVUfUzO9isQ+sJUQVgVHMAun0KKlpHsPDJ7EEgKF0HxZbcMxfdpbcJUaN9EWqsIyEWGEvCu1EyiQmxdLax8uZM1bVaoHpJQFHfI6Gw/RFYwmgodV/8S0s5Ec3qD9qvpGfoxzyBcoTQ/7QbUfjJoXtIGuJGEA6YuaCozzMvRLUcs7YGUB58aAbGE8ED8j34uOeuRdkhTF9gGOgxWjeR5qCEzFnq/egj/UPBJqu28GC1huIGsQ10f18T2qB+tXulaOt6VCxPiJGt7gJmN/Z5DHqQVdwu311XTZa7xxBJ0liGdNUlMzVSh5+o2BiuvAEuCUsr762+rybDxd+W8o9NGDY/TvzXqw4pHBcHCHoYqifkbLBLd/1AkM6MVPuJFwBxZXY+yVeAokOkxLz4uDhsE/xI9NJ7rdC3o4oKZIAIlCSbF/Mwnp2nWQSzQ+UTNHVIB+Twmhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(30864003)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001)(559001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5cVPC7L9oe3+WYB+vpmuOhiZTZX+IUXr4tbCarpNrcLrGPzJ5sCvBPgk1aTJ?=
 =?us-ascii?Q?7uA2+y3o5c60pjQd6zpFk3YeNhTHGlndasOJpHn391spd19Kikhtj58NSwSQ?=
 =?us-ascii?Q?ePx8jqo0ahYxaQH5tXDPNnxvLTUg321dnOH1OSPk79zZAmleOrTVMrbWgFTa?=
 =?us-ascii?Q?qU9vj7ROrA/PMfCuvg9b50jbI1kAD4VrqNKITJW8ET5IyQEBwXtHO1/onXec?=
 =?us-ascii?Q?wknOtkYkE6OX6Sli0Ik5pyylCYGqQOw2LM9YEqKhdhOJbJGRxV+GVcmWXi5T?=
 =?us-ascii?Q?T/pUa/ldfmwJmYXEdi7XOYXkQuXBo7W8/W1muj8vSNLt9pfQ6Hbt/12+v6cM?=
 =?us-ascii?Q?tKrJ6G/VNppthcB7sazowagGBzAkDC5dVwqDNpObLth59hyPXz5rtlf3VSOk?=
 =?us-ascii?Q?GDZiWOn29apDe9IsLdRJFycT52wHaXtJF8CfGJ382NhFegIFBBJwGDse8FRs?=
 =?us-ascii?Q?ZTpgk3HDkbe/8bT56x7KgJrtLH2UWGqFXVCDYbj5cC/JFASzluBBAm0ZWCDU?=
 =?us-ascii?Q?EiaLlpmHhohIxlmUtLEWAJo4P1YjC1/jBmc+F8OimqiA39GKrAZ8QMQqlEAS?=
 =?us-ascii?Q?wB8j2U5frQLvokE2CvsMxsyEHUXKf1My+ZZQ4cpMcR6QvGsbvhvLpn9uMb79?=
 =?us-ascii?Q?YYbwGUqBthOF8I3SvylyL3COdnXJkzDJVbVgxvpgciE75oTxhYmW/evKI4TR?=
 =?us-ascii?Q?CT2tWzjbPGRe/x5MsxvPSXlFRN09oCHcsQbqkrULl2U4cXBKf8KhnxkK/zNN?=
 =?us-ascii?Q?nyzYxbYCL8LRHG2IYqhS1bmNGRNdSzeB2rnhI1g8aN0sC/NR0Hyd03702w3d?=
 =?us-ascii?Q?E4bl+dy4ITtD0AZPsTjRsQQppKxmsU9j16hwdrtFPL7CaJ/j1N156XN7A9Xp?=
 =?us-ascii?Q?f/9Rm69w2nmHCn0CG0NaWvHx6BSobw5jt33Jk53kyklqGFXnwJLY0T+ski7v?=
 =?us-ascii?Q?YDgpBpoNbmBHqZox2fM/PDVgh+ZyTUwC04sy9kontfV0qnA2RUyFXPiOKJ3s?=
 =?us-ascii?Q?nPWJ63kKcfmJEBe8qciKC4k9s42QrNmqG2WJbxYhyBVpf3hvI9PesK/7GuLa?=
 =?us-ascii?Q?T1HOuqL4knue65QK3Uq7h5UfX4fzyMsvYIIiaUHQGCsUB11FsqNoDuFHN0ER?=
 =?us-ascii?Q?RIpqppOfgKVlvXHS5soj05pbVg6mo/NARvyJlF4DY+du8MhqT+uKbcZSqQZ3?=
 =?us-ascii?Q?h/uuoNgo8fAP0U5k0pobvf3jGCin2ivmy6+Ry2nPgeWzhopXJSgImxOYMtC7?=
 =?us-ascii?Q?vvs+eQNioQUMW74036OLjb6u0Agp64u4BVCX9RykNc6nWBJu84cAlu7xFECX?=
 =?us-ascii?Q?XYZ6dNl/X0eXX0CO8gWnt5jp?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10547838-7774-48b5-7c02-08d931a9e287
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:37.6418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBEkYn8pakiTrGEA/zLDOt+COwgw4s1fdS5mTPOiHRr5t2EKnN4g5puvYV029xdNQpL8cANlKYJ21wD2MHlsCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/tx_queue.c    | 1620 +++++++++++++++++
 1 file changed, 1620 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_queue.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx_queue.c b/drivers/net/w=
ireless/celeno/cl8k/tx/tx_queue.c
new file mode 100644
index 000000000000..18c5bd2b81f7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx_queue.c
@@ -0,0 +1,1620 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <net/cfg80211.h>
+#include <net/mac80211.h>
+#include <linux/ieee80211.h>
+#include <linux/types.h>
+
+#include "tx/tx_queue.h"
+#include "tx/tx.h"
+#include "tx/sw_txhdr.h"
+#include "tx/tx_amsdu.h"
+#include "tx/baw.h"
+#ifdef CONFIG_CL_PCIE
+#include "bus/pci/ipc.h"
+#endif
+#include "tx/agg_cfm.h"
+
+const u8 cl_tid2hwq[IEEE80211_NUM_TIDS] =3D {
+       CL_HWQ_BE,
+       CL_HWQ_BK,
+       CL_HWQ_BK,
+       CL_HWQ_BE,
+       CL_HWQ_VI,
+       CL_HWQ_VI,
+       CL_HWQ_VO,
+       CL_HWQ_VO,
+       /* At the moment, all others TID are mapped to BE */
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+       CL_HWQ_BE,
+};
+
+static u32 cl_txq_total_dump_drv(struct cl_tx_queue *tx_queue)
+{
+       return tx_queue->dump_queue_full + tx_queue->dump_dma_map_fail;
+}
+
+static void cl_txq_sched_list_add(struct cl_tx_queue *tx_queue, struct cl_=
hw *cl_hw)
+{
+       /* Add to schedule queue */
+       if (tx_queue->sched)
+               return;
+
+       tx_queue->sched =3D true;
+       if (tx_queue->type =3D=3D QUEUE_TYPE_AGG)
+               list_add_tail(&tx_queue->sched_list, &cl_hw->list_sched_q_a=
gg);
+       else
+               list_add_tail(&tx_queue->sched_list, &cl_hw->list_sched_q_s=
ingle);
+}
+
+static void cl_txq_sched_list_remove(struct cl_tx_queue *tx_queue)
+{
+       /* Remove from schedule queue */
+       if (tx_queue->sched) {
+               tx_queue->sched =3D false;
+               list_del(&tx_queue->sched_list);
+       }
+}
+
+static void cl_txq_sched_list_remove_if_empty(struct cl_tx_queue *tx_queue=
)
+{
+       /* If queue is empty remove it from schedule list */
+       if (list_empty(&tx_queue->hdrs))
+               cl_txq_sched_list_remove(tx_queue);
+}
+
+static void cl_txq_transfer_single_to_agg(struct cl_hw *cl_hw,
+                                         struct cl_tx_queue *single_queue,
+                                         struct cl_tx_queue *agg_queue, u8=
 tid)
+{
+       struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+       struct ieee80211_tx_info *tx_info;
+       struct sk_buff *skb;
+       u8 hdr_pads;
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       if (single_queue->num_packets =3D=3D 0)
+               goto out;
+
+       list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &single_queue->hdr=
s, tx_queue_list) {
+               if (sw_txhdr->tid !=3D tid)
+                       continue;
+
+               if (!ieee80211_is_data_qos(sw_txhdr->fc))
+                       continue;
+
+               cl_hw->tx_packet_cntr.transfer.single_to_agg++;
+
+               /* Remove from single queue */
+               list_del(&sw_txhdr->tx_queue_list);
+
+               /* Update single queue counters */
+               single_queue->num_packets--;
+               single_queue->total_packets--;
+
+               /* Turn on AMPDU flag */
+               skb =3D sw_txhdr->skb;
+               tx_info =3D IEEE80211_SKB_CB(skb);
+               tx_info->flags |=3D IEEE80211_TX_CTL_AMPDU;
+
+               /* Push skb to agg queue */
+               hdr_pads =3D CL_SKB_DATA_ALIGN_PADS(skb->data);
+               cl_tx_agg_prep(cl_hw, sw_txhdr, skb->len, hdr_pads, false);
+               agg_queue->total_packets++;
+               sw_txhdr->tx_queue =3D agg_queue;
+               cl_txq_push(cl_hw, sw_txhdr);
+       }
+
+       /* If single queue is empty remove it from schedule list */
+       cl_txq_sched_list_remove_if_empty(single_queue);
+
+out:
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_delete_packets(struct cl_hw *cl_hw, struct cl_tx_queue =
*tx_queue, u8 sta_idx)
+{
+       struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+
+       list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &tx_queue->hdrs, t=
x_queue_list) {
+               /*
+                * Brodcast frames do not have cl_sta and should not be
+                * deleted at station remove sequence.
+                */
+               if (!sw_txhdr->cl_sta)
+                       continue;
+
+               if (sw_txhdr->sta_idx !=3D sta_idx)
+                       continue;
+
+               list_del(&sw_txhdr->tx_queue_list);
+               tx_queue->num_packets--;
+
+               cl_tx_single_free_skb(cl_hw, sw_txhdr->skb);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+       }
+
+       /* If queue is empty remove it from schedule list */
+       cl_txq_sched_list_remove_if_empty(tx_queue);
+}
+
+static void cl_txq_reset_counters(struct cl_tx_queue *tx_queue)
+{
+       tx_queue->total_fw_push_desc =3D 0;
+       tx_queue->total_fw_push_skb =3D 0;
+       tx_queue->total_fw_cfm =3D 0;
+       tx_queue->total_packets =3D 0;
+       tx_queue->dump_queue_full =3D 0;
+       tx_queue->dump_dma_map_fail =3D 0;
+
+       memset(tx_queue->stats_hw_amsdu_cnt, 0,
+              sizeof(tx_queue->stats_hw_amsdu_cnt));
+
+       memset(tx_queue->stats_sw_amsdu_cnt, 0,
+              sizeof(tx_queue->stats_sw_amsdu_cnt));
+}
+
+static u16 cl_txq_desc_in_fw(struct cl_tx_queue *tx_queue)
+{
+       return (tx_queue->fw_max_size - tx_queue->fw_free_space);
+}
+
+static void cl_txq_reset_counters_during_traffic(struct cl_tx_queue *tx_qu=
eue)
+{
+       /*
+        * This function can be called during traffic, while descriptors
+        * are waiting in firmware. We set total_fw_cfm to minus the number
+        * of descriptors in firmware so that after confirmation arrives
+        * total_fw_cfm will be equal to total_fw_push_desc.
+        */
+       u32 desc_in_fw =3D cl_txq_desc_in_fw(tx_queue);
+
+       cl_txq_reset_counters(tx_queue);
+       tx_queue->total_fw_cfm =3D -desc_in_fw;
+}
+
+static void cl_txq_agg_size_set(struct cl_hw *cl_hw)
+{
+       struct cl_tx_queue *tx_queue =3D NULL;
+       u16 new_size =3D 0;
+       u16 drv_max_size =3D 0;
+       int i =3D 0;
+       int j =3D 0;
+
+       if (!cl_hw->used_agg_queues || !cl_hw->conf->ci_tx_packet_limit)
+               return;
+
+       new_size =3D cl_hw->conf->ci_tx_packet_limit / cl_hw->used_agg_queu=
es;
+       drv_max_size =3D max(new_size, cl_hw->conf->ci_tx_queue_size_agg);
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+               tx_queue =3D &cl_hw->tx_queues.agg[i];
+
+               if (!tx_queue->cl_sta)
+                       continue;
+
+               tx_queue->max_packets =3D drv_max_size;
+
+               j++;
+               if (j =3D=3D cl_hw->used_agg_queues)
+                       break;
+       }
+
+       cl_dbg_trace(cl_hw, "drv_max_size =3D %u\n", drv_max_size);
+}
+
+static int cl_txq_request_find(struct cl_hw *cl_hw, u8 sta_idx, u8 tid)
+{
+       int i =3D 0;
+       struct cl_req_agg_db *req_agg_db =3D NULL;
+       u8 req_agg_queues =3D 0;
+
+       for (i =3D 0; (i < IPC_MAX_BA_SESSIONS) && (req_agg_queues < cl_hw-=
>req_agg_queues); i++) {
+               req_agg_db =3D &cl_hw->req_agg_db[i];
+
+               if (!req_agg_db->is_used)
+                       continue;
+
+               req_agg_queues++;
+
+               if (sta_idx =3D=3D req_agg_db->sta_idx && tid =3D=3D req_ag=
g_db->tid)
+                       return i;
+       }
+
+       return -1;
+}
+
+static void cl_txq_traffic_counters_print_bcmc(struct cl_hw *cl_hw,
+                                              char **buf, int *len, ssize_=
t *buf_size)
+{
+       struct cl_tx_queue *tx_queue =3D &cl_hw->tx_queues.bcmc;
+       unsigned long flags;
+       u8 hw_index;
+       u32 total_packets;
+       u16 fw_curr;
+       u32 total_push;
+       u32 total_cfm;
+       u32 dump;
+
+       spin_lock_irqsave(&cl_hw->tx_lock_bcmc, flags);
+
+       hw_index =3D tx_queue->hw_index;
+       total_packets =3D tx_queue->total_packets;
+       fw_curr =3D cl_txq_desc_in_fw(tx_queue);
+       total_push =3D tx_queue->total_fw_push_skb;
+       total_cfm =3D tx_queue->total_fw_cfm;
+       dump =3D cl_txq_total_dump_drv(tx_queue);
+
+       spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+
+       if (total_packets =3D=3D 0)
+               return;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nTX MULTICAST AND BOROADCAST QUEUE (MAX 1):\n"
+                   "|-----------------------------------------------------=
------|\n"
+                   "| hw  | driver   | fw      | fw total | fw total | dum=
p     |\n"
+                   "| idx | total    | current | push     | cfm      |    =
      |\n"
+                   "|-----+----------+---------+----------+----------+----=
------|\n"
+                   "| %3u |%10u|%9u|%10u|%10u|%10u|\n",
+                   hw_index, total_packets, fw_curr, total_push, total_cfm=
, dump);
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
------|\n");
+}
+
+static void cl_txq_traffic_counters_print_single(struct cl_hw *cl_hw,
+                                                char **buf, int *len, ssiz=
e_t *buf_size)
+{
+       u16 queue_idx =3D 0;
+       u32 sta_idx =3D 0, ac =3D 0;
+       struct cl_tx_queue *tx_queue;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nTX SINGLE QUEUES (MAX %d):\n", MAX_SINGLE_QUEUES);
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
-----------------"
+                   "----------|\n"
+                   "| idx | sta | ac | driver   | driver  | fw      | fw t=
otal | fw total |"
+                   " dump     |\n"
+                   "|     |     |    | total    | current | current | push=
     | cfm      |"
+                   "          |\n"
+                   "|-----+-----+----+----------+---------+---------+-----=
-----+----------+"
+                   "----------|\n");
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       for (sta_idx =3D 0; sta_idx < FW_MAX_NUM_STA; sta_idx++) {
+               for (ac =3D 0; ac < AC_MAX; ac++) {
+                       queue_idx =3D QUEUE_IDX(sta_idx, ac);
+                       tx_queue =3D &cl_hw->tx_queues.single[queue_idx];
+
+                       if (tx_queue->total_packets =3D=3D 0)
+                               continue;
+
+                       if (tx_queue->index =3D=3D HIGH_PRIORITY_QUEUE)
+                               cl_snprintf(buf, len, buf_size,
+                                           "|-----+-----+----+----------+-=
--------+---------+"
+                                           "----------+----------+--------=
--|\n");
+
+                       cl_snprintf(buf, len, buf_size,
+                                   "| %3u | %3u | %2u |%10u|%9u|%9u|%10u|%=
10u|%10u|\n",
+                                   tx_queue->index,
+                                   sta_idx,
+                                   tx_queue->hw_index,
+                                   tx_queue->total_packets,
+                                   tx_queue->num_packets,
+                                   cl_txq_desc_in_fw(tx_queue),
+                                   tx_queue->total_fw_push_skb,
+                                   tx_queue->total_fw_cfm,
+                                   cl_txq_total_dump_drv(tx_queue));
+               }
+       }
+
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
-------------------"
+                   "--------|\n");
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_traffic_counters_print_agg(struct cl_hw *cl_hw,
+                                             char **buf, int *len, ssize_t=
 *buf_size)
+{
+       u32 ba_idx =3D 0;
+       struct cl_tx_queue *tx_queue;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       if (cl_hw->used_agg_queues =3D=3D 0)
+               goto out;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nTX AGGREGATION QUEUES (MAX %d):\n", IPC_MAX_BA_SESSI=
ONS);
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
------------------"
+                   "---------------------|\n"
+                   "| idx | sta | tid | driver   | driver  | fw      | fw =
total | fw total |"
+                   " fw total | dump     |\n"
+                   "|     | idx |     | total    | current | current | pus=
h skb | push desc|"
+                   " cfm      |          |\n"
+                   "|-----+-----+-----+----------+---------+---------+----=
------+----------+"
+                   "----------+----------|\n");
+
+       for (ba_idx =3D 0; ba_idx < IPC_MAX_BA_SESSIONS; ba_idx++) {
+               tx_queue =3D &cl_hw->tx_queues.agg[ba_idx];
+
+               if (!cl_hw->tx_queues.agg[ba_idx].cl_sta)
+                       continue;
+
+               if (tx_queue->total_packets =3D=3D 0)
+                       continue;
+
+               cl_snprintf(buf, len, buf_size,
+                           "| %3u | %3u | %3u |%10u|%9u|%9u|%10u|%10u|%10u=
|%10u|\n",
+                           tx_queue->index,
+                           tx_queue->cl_sta->sta_idx,
+                           tx_queue->tid,
+                           tx_queue->total_packets,
+                           tx_queue->num_packets,
+                           cl_txq_desc_in_fw(tx_queue),
+                           tx_queue->total_fw_push_skb,
+                           tx_queue->total_fw_push_desc,
+                           tx_queue->total_fw_cfm,
+                           cl_txq_total_dump_drv(tx_queue));
+       }
+
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
-------------------"
+                   "--------------------|\n");
+
+out:
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+static void cl_txq_traffic_counters_print_mac(struct cl_hw *cl_hw,
+                                             char **buf, int *len, ssize_t=
 *buf_size)
+{
+       struct ieee80211_local *local =3D hw_to_local(cl_hw->hw);
+       u32 i =3D 0, total_len =3D 0, q_len[IEEE80211_MAX_QUEUES] =3D {0};
+       unsigned long flags;
+
+       spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+
+       for (i =3D 0; i < IEEE80211_MAX_QUEUES; i++) {
+               q_len[i] =3D skb_queue_len(&local->pending[i]);
+               total_len +=3D q_len[i];
+       }
+
+       spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+
+       if (total_len =3D=3D 0)
+               return;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nMAC80211 PENDING QUEUES (MAX %d):\n", IEEE80211_MAX_=
QUEUES);
+       cl_snprintf(buf, len, buf_size,
+                   "|--------------------|\n"
+                   "| queue |  current   |\n"
+                   "|-------+------------|\n");
+
+       for (i =3D 0; i < IEEE80211_MAX_QUEUES; i++)
+               if (q_len[i] > 0)
+                       cl_snprintf(buf, len, buf_size, "| %5u | %10u |\n",=
 i, q_len[i]);
+
+       cl_snprintf(buf, len, buf_size, "|--------------------|\n");
+}
+
+static int cl_txq_traffic_counters_print(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_txq_traffic_counters_print_bcmc(cl_hw, &buf, &len, &buf_size);
+       cl_txq_traffic_counters_print_single(cl_hw, &buf, &len, &buf_size);
+       cl_txq_traffic_counters_print_agg(cl_hw, &buf, &len, &buf_size);
+       cl_txq_traffic_counters_print_mac(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_txq_drop_reasons_print_bcmc(struct cl_hw *cl_hw,
+                                          char **buf, int *len, ssize_t *b=
uf_size)
+{
+       u32 total =3D 0;
+       u32 dump_queue_full =3D 0;
+       u32 dump_dma_map_fail =3D 0;
+       struct cl_tx_queue *tx_queue =3D &cl_hw->tx_queues.bcmc;
+       unsigned long flags;
+
+       spin_lock_irqsave(&cl_hw->tx_lock_bcmc, flags);
+
+       total =3D cl_txq_total_dump_drv(tx_queue);
+       dump_queue_full =3D tx_queue->dump_queue_full;
+       dump_dma_map_fail =3D tx_queue->dump_dma_map_fail;
+
+       spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+
+       if (total > 0)
+               cl_snprintf(buf, len, buf_size,
+                           "|bcmc  |     |%10u|%10u|%10u|\n",
+                           dump_queue_full, dump_dma_map_fail, total);
+}
+
+static void cl_txq_drop_reasons_print_single(struct cl_hw *cl_hw,
+                                            char **buf, int *len, ssize_t =
*buf_size)
+{
+       u32 i =3D 0, total =3D 0;
+       struct cl_tx_queue *tx_queue;
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++) {
+               tx_queue =3D &cl_hw->tx_queues.single[i];
+               total =3D cl_txq_total_dump_drv(tx_queue);
+
+               if (total =3D=3D 0)
+                       continue;
+
+               cl_snprintf(buf, len, buf_size,
+                           "|single|%5u|%10u|%10u|%10u|\n",
+                           tx_queue->index,
+                           tx_queue->dump_queue_full,
+                           tx_queue->dump_dma_map_fail,
+                           total);
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_drop_reasons_print_agg(struct cl_hw *cl_hw,
+                                         char **buf, int *len, ssize_t *bu=
f_size)
+{
+       u32 i =3D 0, total =3D 0;
+       struct cl_tx_queue *tx_queue;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+               tx_queue =3D &cl_hw->tx_queues.agg[i];
+               total =3D cl_txq_total_dump_drv(tx_queue);
+
+               if (total =3D=3D 0)
+                       continue;
+
+               cl_snprintf(buf, len, buf_size,
+                           "|agg   |%5u|%10u|%10u|%10u|\n",
+                           tx_queue->index,
+                           tx_queue->dump_queue_full,
+                           tx_queue->dump_dma_map_fail,
+                           total);
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+static int cl_txq_drop_reasons_print(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "-----------------------------------------------\n"
+                   "| type | idx | queue    | dma map  | total    |\n"
+                   "|      |     | full     | fail     | dump     |\n"
+                   "|------+-----+----------+----------+----------|\n");
+
+       cl_txq_drop_reasons_print_bcmc(cl_hw, &buf, &len, &buf_size);
+       cl_txq_drop_reasons_print_single(cl_hw, &buf, &len, &buf_size);
+       cl_txq_drop_reasons_print_agg(cl_hw, &buf, &len, &buf_size);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "-----------------------------------------------\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_txq_global_counters_print(struct cl_hw *cl_hw)
+{
+       struct cl_tx_forward_cntr *forward =3D &cl_hw->tx_packet_cntr.forwa=
rd;
+       struct cl_tx_drop_cntr *drop =3D &cl_hw->tx_packet_cntr.drop;
+       struct cl_tx_transfer_cntr *transfer =3D &cl_hw->tx_packet_cntr.tra=
nsfer;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "FORWARD\n"
+                   "----------------------------\n"
+                   "tx_start          =3D %u\n", forward->tx_start);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "drv_fast_agg      =3D %u\n", forward->drv_fast_agg);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "drv_fast_single   =3D %u\n", forward->drv_fast_single)=
;
+       cl_snprintf(&buf, &len, &buf_size,
+                   "to_mac            =3D %u\n", forward->to_mac);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "from_mac_single   =3D %u\n", forward->from_mac_single)=
;
+       cl_snprintf(&buf, &len, &buf_size,
+                   "from_mac_agg      =3D %u\n", forward->from_mac_agg);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "DROP\n"
+                   "----------------------------\n"
+                   "wd_restart        =3D %u\n", drop->wd_restart);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "radio_off         =3D %u\n", drop->radio_off);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "in_recovery       =3D %u\n", drop->in_recovery);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "short_length      =3D %u\n", drop->short_length);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "pending_full      =3D %u\n", drop->pending_full);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "packet_limit      =3D %u\n", drop->packet_limit);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "dev_flags         =3D %u\n", drop->dev_flags);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "length_limit      =3D %u\n", drop->length_limit);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "txhdr_alloc_fail  =3D %u\n", drop->txhdr_alloc_fail);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "queue_null        =3D %u\n", drop->queue_null);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "amsdu_alloc_fail  =3D %u\n", drop->amsdu_alloc_fail);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "amsdu_dma_map_err =3D %u\n", drop->amsdu_dma_map_err);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "build_hdr_fail    =3D %u\n", drop->build_hdr_fail);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "key_disable       =3D %u\n", drop->key_disable);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "queue_flush       =3D %u\n", drop->queue_flush);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "sta_null_in_agg   =3D %u\n", drop->sta_null_in_agg);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TRANSFER\n"
+                   "----------------------------\n"
+                   "single_to_agg     =3D %u\n", transfer->single_to_agg);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "agg_to_single     =3D %u\n", transfer->agg_to_single);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_txq_stop_reasons_print(struct cl_hw *cl_hw)
+{
+       struct ieee80211_local *local =3D hw_to_local(cl_hw->hw);
+       unsigned long queue_stop_reasons;
+       unsigned long flags;
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|------------------------|\n"
+                   "|queue|queue_stop_reasons|\n"
+                   "|-----+------------------|\n");
+
+       for (i =3D 0; i < IEEE80211_MAX_QUEUES; i++) {
+               spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+               queue_stop_reasons =3D local->queue_stop_reasons[i];
+               spin_unlock_irqrestore(&local->queue_stop_reason_lock, flag=
s);
+
+               if (queue_stop_reasons)
+                       cl_snprintf(&buf, &len, &buf_size, "|%5u|0x%-16lx|\=
n",
+                                   i, queue_stop_reasons);
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "|------------------------|\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_txq_requested_agg_print(struct cl_hw *cl_hw)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "## used_agg_queues =3D %u\n", cl_hw->used_agg_queues);
+
+       if (cl_hw->used_agg_queues) {
+               for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+                       if (!cl_hw->tx_queues.agg[i].cl_sta)
+                               continue;
+
+                       cl_snprintf(&buf, &len, &buf_size,
+                                   "%u) sta_idx =3D %u, tid =3D %u\n", i +=
 1,
+                                   cl_hw->tx_queues.agg[i].cl_sta->sta_idx=
,
+                                   cl_hw->tx_queues.agg[i].tid);
+               }
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "## req_agg_queues =3D %u\n", cl=
_hw->req_agg_queues);
+
+       if (cl_hw->req_agg_queues) {
+               for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+                       if (!cl_hw->req_agg_db[i].is_used)
+                               continue;
+
+                       cl_snprintf(&buf, &len, &buf_size, "%u) sta_idx =3D=
 %u, tid =3D %u\n",
+                                   i + 1, cl_hw->req_agg_db[i].sta_idx,
+                                   cl_hw->req_agg_db[i].tid);
+               }
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_txq_hw_amsdu_stats_print(struct cl_hw *cl_hw,
+                                       char **buf, int *len, ssize_t *buf_=
size)
+{
+       u32 i, j;
+       struct cl_tx_queue *tx_queue;
+
+       cl_snprintf(buf, len, buf_size, "HW TX-AMSDU STATS:\n");
+
+       cl_snprintf(buf, len, buf_size, "|-----------");
+       for (i =3D 0; i < CL_AMSDU_TX_PAYLOAD_MAX; i++)
+               cl_snprintf(buf, len, buf_size, "-----------");
+
+       cl_snprintf(buf, len, buf_size, "|\n|agg|sta|tid");
+       for (i =3D 0; i < CL_AMSDU_TX_PAYLOAD_MAX; i++)
+               cl_snprintf(buf, len, buf_size, "| amsdu #%u ", i + 1);
+
+       cl_snprintf(buf, len, buf_size, "|\n|---+---+---");
+       for (i =3D 0; i < CL_AMSDU_TX_PAYLOAD_MAX; i++)
+               cl_snprintf(buf, len, buf_size, "+----------");
+
+       cl_snprintf(buf, len, buf_size, "|\n");
+
+       for (j =3D 0; j < IPC_MAX_BA_SESSIONS; j++) {
+               tx_queue =3D &cl_hw->tx_queues.agg[j];
+
+               if (!tx_queue->cl_sta)
+                       continue;
+
+               if (tx_queue->total_packets =3D=3D 0)
+                       continue;
+
+               cl_snprintf(buf, len, buf_size, "|%3u|%3u|%3u",
+                           tx_queue->index,
+                           tx_queue->cl_sta->sta_idx,
+                           tx_queue->tid);
+
+               for (i =3D 0; i < CL_AMSDU_TX_PAYLOAD_MAX; i++)
+                       cl_snprintf(buf, len, buf_size, "|%10u", tx_queue->=
stats_hw_amsdu_cnt[i]);
+
+               cl_snprintf(buf, len, buf_size, "|\n");
+       }
+
+       cl_snprintf(buf, len, buf_size,  "|-----------");
+       for (i =3D 0; i < CL_AMSDU_TX_PAYLOAD_MAX; i++)
+               cl_snprintf(buf, len, buf_size, "-----------");
+
+       cl_snprintf(buf, len, buf_size, "|\n");
+}
+
+static void cl_txq_sw_amsdu_stats_print(struct cl_hw *cl_hw,
+                                       char **buf, int *len, ssize_t *buf_=
size)
+{
+       u32 i, j;
+       struct cl_tx_queue *tx_queue;
+
+       if (cl_hw->conf->ci_tx_sw_amsdu_max_packets < 2)
+               return;
+
+       cl_snprintf(buf, len, buf_size, "SW TX-AMSDU STATS:\n");
+
+       for (j =3D 0; j < IPC_MAX_BA_SESSIONS; j++) {
+               tx_queue =3D &cl_hw->tx_queues.agg[j];
+
+               if (!tx_queue->cl_sta)
+                       continue;
+
+               if (tx_queue->total_packets =3D=3D 0)
+                       continue;
+
+               cl_snprintf(buf, len, buf_size,
+                           "\nagg idx %u, sta %u, tid %u :\n",
+                           tx_queue->index,
+                           tx_queue->cl_sta->sta_idx,
+                           tx_queue->tid);
+               cl_snprintf(buf, len, buf_size, "--------------------------=
--\n");
+
+               for (i =3D 0; i < cl_hw->conf->ci_tx_sw_amsdu_max_packets; =
i++)
+                       if (tx_queue->stats_sw_amsdu_cnt[i] > 0)
+                               cl_snprintf(buf, len, buf_size,
+                                           "amsdu #%u =3D %u\n", i + 1,
+                                           tx_queue->stats_sw_amsdu_cnt[i]=
);
+       }
+}
+
+static int cl_txq_amsdu_stats_print(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       if (cl_hw->used_agg_queues =3D=3D 0)
+               goto out;
+
+       cl_txq_hw_amsdu_stats_print(cl_hw, &buf, &len, &buf_size);
+       cl_txq_sw_amsdu_stats_print(cl_hw, &buf, &len, &buf_size);
+out:
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_txq_max_size_print_single(struct cl_hw *cl_hw,
+                                        char **buf, int *len, ssize_t *buf=
_size)
+{
+       u8 ac =3D 0;
+       u8 sta_idx =3D 0;
+       u16 queue_idx =3D 0;
+       struct cl_tx_queue *tx_queue;
+
+       cl_snprintf(buf, len, buf_size,
+                   "MAX SIZE SINGLE QUEUES:\n"
+                   "|----------------------|\n"
+                   "|idx|sta|ac| drv | fw  |\n"
+                   "|---+---+--+-----+-----|\n");
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       for (sta_idx =3D 0; sta_idx < FW_MAX_NUM_STA; sta_idx++) {
+               for (ac =3D 0; ac < AC_MAX; ac++) {
+                       queue_idx =3D QUEUE_IDX(sta_idx, ac);
+                       tx_queue =3D &cl_hw->tx_queues.single[queue_idx];
+
+                       if (tx_queue->total_fw_push_skb =3D=3D 0)
+                               continue;
+
+                       cl_snprintf(buf, len, buf_size,
+                                   "|%3u|%3u|%2u|%5u|%5u|\n",
+                                   tx_queue->index,
+                                   sta_idx,
+                                   tx_queue->hw_index,
+                                   tx_queue->max_packets,
+                                   tx_queue->fw_max_size);
+               }
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+
+       cl_snprintf(buf, len, buf_size, "|----------------------|\n");
+}
+
+static void cl_txq_max_size_print_agg(struct cl_hw *cl_hw,
+                                     char **buf, int *len, ssize_t *buf_si=
ze)
+{
+       u8 agg_idx =3D 0;
+       struct cl_tx_queue *tx_queue;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       if (cl_hw->used_agg_queues =3D=3D 0)
+               goto out;
+
+       cl_snprintf(buf, len, buf_size,
+                   "MAX SIZE AGGREGATION QUEUES:\n"
+                   "|-----------------------|\n"
+                   "|idx|sta|tid| drv | fw  |\n"
+                   "|---+---+---+-----+-----|\n");
+
+       for (agg_idx =3D 0; agg_idx < IPC_MAX_BA_SESSIONS; agg_idx++) {
+               tx_queue =3D &cl_hw->tx_queues.agg[agg_idx];
+
+               if (!tx_queue->cl_sta)
+                       continue;
+
+               cl_snprintf(buf, len, buf_size,
+                           "|%3u|%3u|%3u|%5u|%5u|\n",
+                           tx_queue->index,
+                           tx_queue->cl_sta->sta_idx,
+                           tx_queue->tid,
+                           tx_queue->max_packets,
+                           tx_queue->fw_max_size);
+       }
+
+       cl_snprintf(buf, len, buf_size, "|----------------------|\n");
+
+out:
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+static int cl_txq_max_size_print(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_txq_max_size_print_single(cl_hw, &buf, &len, &buf_size);
+       cl_txq_max_size_print_agg(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_txq_stats_reset_bcmc(struct cl_hw *cl_hw)
+{
+       unsigned long flags;
+
+       spin_lock_irqsave(&cl_hw->tx_lock_bcmc, flags);
+       cl_txq_reset_counters_during_traffic(&cl_hw->tx_queues.bcmc);
+       spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+}
+
+static void cl_txq_stats_reset_single(struct cl_hw *cl_hw)
+{
+       u16 i =3D 0;
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               cl_txq_reset_counters_during_traffic(&cl_hw->tx_queues.sing=
le[i]);
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_stats_reset_agg(struct cl_hw *cl_hw)
+{
+       u16 i =3D 0;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               cl_txq_reset_counters_during_traffic(&cl_hw->tx_queues.agg[=
i]);
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+static void cl_txq_stats_reset(struct cl_hw *cl_hw)
+{
+       cl_txq_stats_reset_bcmc(cl_hw);
+       cl_txq_stats_reset_single(cl_hw);
+       cl_txq_stats_reset_agg(cl_hw);
+
+       memset(&cl_hw->tx_packet_cntr, 0, sizeof(struct cl_tx_packet_cntr))=
;
+
+       pr_debug("Reset queue stats\n");
+}
+
+static void cl_txq_sched_list_print_single(struct cl_hw *cl_hw,
+                                          char **buf, int *len, ssize_t *b=
uf_size)
+{
+       struct cl_tx_queue *tx_queue;
+       u32 num_queues =3D 0;
+
+       cl_snprintf(buf, len, buf_size, "TX single sched list:\n");
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       list_for_each_entry(tx_queue, &cl_hw->list_sched_q_single, sched_li=
st) {
+               num_queues++;
+               cl_snprintf(buf, len, buf_size, "%u) Index =3D %u\n", num_q=
ueues, tx_queue->index);
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+
+       if (num_queues =3D=3D 0)
+               cl_snprintf(buf, len, buf_size, "empty\n");
+}
+
+static void cl_txq_sched_list_print_agg(struct cl_hw *cl_hw,
+                                       char **buf, int *len, ssize_t *buf_=
size)
+{
+       struct cl_tx_queue *tx_queue;
+       u32 num_queues =3D 0;
+
+       cl_snprintf(buf, len, buf_size, "\nTX agg sched list:\n");
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       list_for_each_entry(tx_queue, &cl_hw->list_sched_q_agg, sched_list)=
 {
+               num_queues++;
+               cl_snprintf(buf, len, buf_size, "%u) Index =3D %u\n", num_q=
ueues, tx_queue->index);
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+       if (num_queues =3D=3D 0)
+               cl_snprintf(buf, len, buf_size, "empty\n");
+}
+
+static int cl_txq_sched_list_print(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_txq_sched_list_print_single(cl_hw, &buf, &len, &buf_size);
+       cl_txq_sched_list_print_agg(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_txq_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "txq usage:\n"
+                "-a : Print traffic counters\n"
+                "-b : Print drop counters\n"
+                "-c : Print global counters\n"
+                "-d : Print stop reasons\n"
+                "-e : Print requested aggregations\n"
+                "-f : Print AMSDU statistics\n"
+                "-m : Print maximum queues size\n"
+                "-r : Reset queue stats\n"
+                "-s : Print schedule list\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_txq_task_single(struct cl_hw *cl_hw)
+{
+       /* Schedule single queues */
+       struct cl_tx_queue *tx_queue, *tx_queue_tmp;
+
+       spin_lock(&cl_hw->tx_lock_single);
+
+       list_for_each_entry_safe(tx_queue, tx_queue_tmp, &cl_hw->list_sched=
_q_single, sched_list)
+               cl_txq_sched(cl_hw, tx_queue);
+
+       /* Rotate the queue so next schedule will start with a different qu=
eue */
+       list_rotate_left(&cl_hw->list_sched_q_single);
+
+       spin_unlock(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_task_agg(struct cl_hw *cl_hw)
+{
+       /* Schedule agg queueus */
+       struct cl_tx_queue *tx_queue, *tx_queue_tmp;
+
+       spin_lock(&cl_hw->tx_lock_agg);
+
+       list_for_each_entry_safe(tx_queue, tx_queue_tmp, &cl_hw->list_sched=
_q_agg, sched_list)
+               cl_txq_sched(cl_hw, tx_queue);
+
+       /* Rotate the queue so next schedule will start with a different qu=
eue */
+       list_rotate_left(&cl_hw->list_sched_q_agg);
+
+       spin_unlock(&cl_hw->tx_lock_agg);
+}
+
+static void cl_txq_task(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+
+       cl_txq_task_single(cl_hw);
+       cl_txq_task_agg(cl_hw);
+}
+
+static void cl_txq_agg_inc_usage_cntr(struct cl_hw *cl_hw)
+{
+       /* Should be called in cl_hw->tx_lock_agg context */
+       cl_hw->used_agg_queues++;
+       cl_txq_agg_size_set(cl_hw);
+}
+
+static void cl_txq_agg_dec_usage_cntr(struct cl_hw *cl_hw)
+{
+       /* Should be called in cl_hw->tx_lock_agg context */
+       WARN_ON_ONCE(cl_hw->used_agg_queues =3D=3D 0);
+
+       cl_hw->used_agg_queues--;
+       cl_txq_agg_size_set(cl_hw);
+}
+
+static void cl_txq_init_single(struct cl_hw *cl_hw)
+{
+       struct cl_tx_queue *tx_queue;
+       u32 i;
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       INIT_LIST_HEAD(&cl_hw->list_sched_q_single);
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++) {
+               tx_queue =3D &cl_hw->tx_queues.single[i];
+               memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+               INIT_LIST_HEAD(&tx_queue->hdrs);
+               tx_queue->hw_index =3D i / FW_MAX_NUM_STA;
+               tx_queue->fw_max_size =3D IPC_TXDESC_CNT_SINGLE;
+               tx_queue->fw_free_space =3D IPC_TXDESC_CNT_SINGLE;
+               tx_queue->index =3D i;
+               tx_queue->max_packets =3D cl_hw->conf->ci_tx_queue_size_sin=
gle;
+               tx_queue->type =3D QUEUE_TYPE_SINGLE;
+       }
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+static void cl_txq_init_bcmc(struct cl_hw *cl_hw)
+{
+       unsigned long flags;
+       struct cl_tx_queue *tx_queue;
+
+       spin_lock_irqsave(&cl_hw->tx_lock_bcmc, flags);
+
+       tx_queue =3D &cl_hw->tx_queues.bcmc;
+       memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+       INIT_LIST_HEAD(&tx_queue->hdrs);
+       tx_queue->hw_index =3D CL_HWQ_BCN;
+       tx_queue->fw_max_size =3D IPC_TXDESC_CNT_BCMC;
+       tx_queue->fw_free_space =3D IPC_TXDESC_CNT_BCMC;
+       tx_queue->index =3D 0;
+       tx_queue->max_packets =3D 0;
+       tx_queue->type =3D QUEUE_TYPE_BCMC;
+
+       spin_unlock_irqrestore(&cl_hw->tx_lock_bcmc, flags);
+}
+
+static void cl_txq_init_agg(struct cl_hw *cl_hw)
+{
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+       INIT_LIST_HEAD(&cl_hw->list_sched_q_agg);
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+static void cl_txq_agg_request_reset(struct cl_hw *cl_hw)
+{
+       cl_hw->req_agg_queues =3D 0;
+       memset(cl_hw->req_agg_db, 0, sizeof(cl_hw->req_agg_db));
+}
+
+void cl_txq_init(struct cl_hw *cl_hw)
+{
+       tasklet_init(&cl_hw->tx_task, cl_txq_task, (unsigned long)cl_hw);
+
+       cl_txq_agg_request_reset(cl_hw);
+       cl_txq_init_single(cl_hw);
+       cl_txq_init_bcmc(cl_hw);
+       cl_txq_init_agg(cl_hw);
+}
+
+void cl_txq_stop(struct cl_hw *cl_hw)
+{
+       tasklet_kill(&cl_hw->tx_task);
+}
+
+struct cl_tx_queue *cl_txq_get(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw=
_txhdr)
+{
+       struct cl_sta *cl_sta =3D sw_txhdr->cl_sta;
+       struct ieee80211_tx_info *tx_info =3D IEEE80211_SKB_CB(sw_txhdr->sk=
b);
+       u8 hw_queue =3D sw_txhdr->hw_queue;
+
+       if (!cl_sta &&
+           hw_queue =3D=3D CL_HWQ_VO &&
+           is_multicast_ether_addr(sw_txhdr->hdr80211->addr1)) {
+               /*
+                * If HW queue is VO and packet is multicast, it was not bu=
ffered
+                * by mac80211, and it should be pushed to the high-priorit=
y queue
+                * and not to the bcmc queue.
+                */
+               return &cl_hw->tx_queues.single[HIGH_PRIORITY_QUEUE];
+       } else if (!cl_sta &&
+                  (hw_queue !=3D CL_HWQ_BCN) &&
+                  !(tx_info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER)) {
+               /*
+                * If station is NULL, but HW queue is not BCN,
+                * it most go to the high-priority queue.
+                */
+               tx_info->flags |=3D IEEE80211_TX_CTL_NO_PS_BUFFER;
+               sw_txhdr->hw_queue =3D CL_HWQ_VO;
+               return &cl_hw->tx_queues.single[HIGH_PRIORITY_QUEUE];
+       } else if (cl_sta && (tx_info->flags & IEEE80211_TX_CTL_AMPDU)) {
+               /* Agg packet */
+               return cl_sta->agg_tx_queues[sw_txhdr->tid];
+       } else if (hw_queue =3D=3D CL_HWQ_BCN) {
+               return &cl_hw->tx_queues.bcmc;
+       } else if (tx_info->flags & IEEE80211_TX_CTL_NO_PS_BUFFER) {
+               /*
+                * Only frames that are power save response or non-bufferab=
le MMPDU
+                * will have this flag set our driver will push those frame=
 to the
+                * highiest priority queue.
+                */
+               return &cl_hw->tx_queues.single[HIGH_PRIORITY_QUEUE];
+       }
+
+       return &cl_hw->tx_queues.single[QUEUE_IDX(sw_txhdr->sta_idx, hw_que=
ue)];
+}
+
+void cl_txq_push(struct cl_hw *cl_hw, struct cl_sw_txhdr *sw_txhdr)
+{
+       struct cl_tx_queue *tx_queue =3D sw_txhdr->tx_queue;
+
+       if (tx_queue->num_packets < tx_queue->max_packets) {
+               tx_queue->num_packets++;
+
+               /*
+                * This prioritization of action frames helps Samsung Galax=
y Note 8 to
+                * open BA session more easily, when phy dev is PHY_DEV_OLY=
MPUS
+                */
+               if (ieee80211_is_action(sw_txhdr->fc))
+                       list_add(&sw_txhdr->tx_queue_list, &tx_queue->hdrs)=
;
+               else
+                       list_add_tail(&sw_txhdr->tx_queue_list, &tx_queue->=
hdrs);
+
+               /* If it is the first packet in the queue, add the queue to=
 the sched list */
+               cl_txq_sched_list_add(tx_queue, cl_hw);
+       } else {
+               struct cl_sta *cl_sta =3D sw_txhdr->cl_sta;
+               u8 tid =3D sw_txhdr->tid;
+
+               /* If the SW queue full, release the packet */
+               tx_queue->dump_queue_full++;
+
+               if (cl_sta && cl_sta->amsdu_anchor[tid].sw_txhdr) {
+                       if (cl_sta->amsdu_anchor[tid].sw_txhdr =3D=3D sw_tx=
hdr) {
+                               cl_sta->amsdu_anchor[tid].sw_txhdr =3D NULL=
;
+                               cl_sta->amsdu_anchor[tid].packet_cnt =3D 0;
+                       }
+               }
+
+               dev_kfree_skb_any(sw_txhdr->skb);
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+
+               /* Schedule tasklet to try and empty the queue */
+               tasklet_schedule(&cl_hw->tx_task);
+       }
+}
+
+void cl_txq_sched(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue)
+{
+       struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+
+       if (!test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) ||
+           cl_hw->tx_disable_flags ||
+           cl_txq_is_fw_full(tx_queue))
+               return;
+
+       /* Go over all descriptors in queue */
+       list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &tx_queue->hdrs, t=
x_queue_list) {
+               list_del(&sw_txhdr->tx_queue_list);
+               tx_queue->num_packets--;
+
+               cl_tx_push(cl_hw, sw_txhdr, tx_queue);
+
+               if (cl_txq_is_fw_full(tx_queue))
+                       break;
+       }
+
+       /* If queue is empty remove it from schedule list */
+       cl_txq_sched_list_remove_if_empty(tx_queue);
+}
+
+void cl_txq_agg_alloc(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                     struct mm_ba_add_cfm *ba_add_cfm, u16 buf_size)
+{
+       u8 tid =3D ba_add_cfm->tid;
+       u8 fw_agg_idx =3D ba_add_cfm->agg_idx;
+       u8 sta_idx =3D cl_sta->sta_idx;
+       u8 ac =3D cl_tid2hwq[tid];
+       u16 single_queue_idx =3D QUEUE_IDX(sta_idx, ac);
+       struct cl_tx_queue *tx_queue =3D &cl_hw->tx_queues.agg[fw_agg_idx];
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       /* Init aggregated queue struct */
+       memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+       INIT_LIST_HEAD(&tx_queue->hdrs);
+
+       /*
+        * Firmware agg queues size is static and set to 512, so that for t=
he worst
+        * case of HE stations,that support AMPDU of 256, it has room for t=
wo full
+        * aggregation.
+        * To keep this logic, of room for two aggregations, for non-HE sta=
tions, or
+        * for HE stations that do not support AMPDU of 256, we initialize =
fw_max_size
+        to twice the buffer size supported by the station.
+        */
+       tx_queue->fw_max_size =3D min_t(u16, cl_hw->max_agg_tx_q_size, buf_=
size * 2);
+       tx_queue->fw_free_space =3D tx_queue->fw_max_size;
+
+       tx_queue->max_packets =3D cl_hw->conf->ci_tx_queue_size_agg;
+       tx_queue->hw_index =3D ac;
+       tx_queue->cl_sta =3D cl_sta;
+       tx_queue->type =3D QUEUE_TYPE_AGG;
+       tx_queue->tid =3D tid;
+       tx_queue->index =3D fw_agg_idx;
+
+#ifdef CONFIG_CL_PCIE
+       /* Reset the synchronization counters between the fw and the IPC la=
yer */
+       cl_hw->ipc_env->ring_indices_elem->indices->txdesc_write_idx.agg[fw=
_agg_idx] =3D 0;
+#endif
+
+       /* Attach the cl_hw chosen queue to the station and agg queues DB *=
/
+       cl_sta->agg_tx_queues[tid] =3D tx_queue;
+       cl_agg_cfm_set_tx_queue(cl_hw, tx_queue, fw_agg_idx);
+
+       /* Notify upper mac80211 layer of queues resources status */
+       cl_txq_agg_inc_usage_cntr(cl_hw);
+       cl_txq_agg_request_del(cl_hw, sta_idx, tid);
+
+       /*
+        * Move the qos descriptors to the new allocated aggregated queues,
+        * otherwise we might reorder packets)
+        */
+       cl_txq_transfer_single_to_agg(cl_hw, &cl_hw->tx_queues.single[singl=
e_queue_idx],
+                                     tx_queue, tid);
+       /* Move the BA window pending packets to agg path */
+       cl_baw_pending_to_agg(cl_hw, cl_sta, tid);
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+       cl_dbg_trace(cl_hw, "Allocate queue [%u] to station [%u] tid [%u]\n=
",
+                    fw_agg_idx, sta_idx, tid);
+}
+
+void cl_txq_agg_free(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue,
+                    struct cl_sta *cl_sta, u8 tid)
+{
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       cl_dbg_trace(cl_hw, "Free queue [%u] of station [%u] tid [%u]\n",
+                    tx_queue->index, cl_sta->sta_idx, tid);
+
+       memset(tx_queue, 0, sizeof(struct cl_tx_queue));
+
+       cl_txq_agg_dec_usage_cntr(cl_hw);
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+}
+
+void cl_txq_agg_stop(struct cl_sta *cl_sta, u8 tid)
+{
+       cl_sta->agg_tx_queues[tid] =3D NULL;
+}
+
+void cl_txq_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       /* Set cl_sta field for all single queues of this station */
+       u8 ac;
+       u16 queue_idx;
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               queue_idx =3D QUEUE_IDX(cl_sta->sta_idx, ac);
+               cl_hw->tx_queues.single[queue_idx].cl_sta =3D cl_sta;
+       }
+
+       /* Reset pointers to TX agg queues */
+       memset(cl_sta->agg_tx_queues, 0, sizeof(cl_sta->agg_tx_queues));
+}
+
+void cl_txq_sta_remove(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       /* Clear cl_sta field for all single queues of this station */
+       u8 ac;
+       u16 queue_idx;
+
+       for (ac =3D 0; ac < AC_MAX; ac++) {
+               queue_idx =3D QUEUE_IDX(sta_idx, ac);
+               cl_hw->tx_queues.single[queue_idx].cl_sta =3D NULL;
+       }
+}
+
+void cl_txq_transfer_agg_to_single(struct cl_hw *cl_hw, struct cl_tx_queue=
 *agg_queue)
+{
+       /*
+        * 1) Remove from aggregation queue
+        * 2) Free sw_txhdr
+        * 3) Push to single queue
+        */
+       struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+       struct sk_buff *skb;
+       struct ieee80211_tx_info *tx_info;
+       struct cl_tx_queue *single_queue;
+       struct cl_sta *cl_sta =3D agg_queue->cl_sta;
+       u16 single_queue_idx =3D 0;
+
+       if (agg_queue->num_packets =3D=3D 0)
+               return;
+
+       single_queue_idx =3D QUEUE_IDX(cl_sta->sta_idx, agg_queue->hw_index=
);
+       single_queue =3D &cl_hw->tx_queues.single[single_queue_idx];
+
+       list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &agg_queue->hdrs, =
tx_queue_list) {
+               list_del(&sw_txhdr->tx_queue_list);
+               agg_queue->num_packets--;
+
+               skb =3D sw_txhdr->skb;
+               tx_info =3D IEEE80211_SKB_CB(skb);
+
+               if (cl_tx_ctrl_is_amsdu(tx_info)) {
+                       cl_tx_amsdu_transfer_single(cl_hw, sw_txhdr);
+               } else {
+                       tx_info->flags &=3D ~IEEE80211_TX_CTL_AMPDU;
+
+                       if (cl_tx_8023_to_wlan(cl_hw, skb, cl_sta, sw_txhdr=
->tid) =3D=3D 0) {
+                               cl_hw->tx_packet_cntr.transfer.agg_to_singl=
e++;
+                               cl_tx_single(cl_hw, cl_sta, skb, false, fal=
se);
+                       }
+               }
+
+               cl_sw_txhdr_free(cl_hw, sw_txhdr);
+       }
+
+       /* If queue is empty remove it from schedule list */
+       cl_txq_sched_list_remove_if_empty(agg_queue);
+}
+
+void cl_txq_flush(struct cl_hw *cl_hw, struct cl_tx_queue *tx_queue)
+{
+       struct cl_sw_txhdr *sw_txhdr, *sw_txhdr_tmp;
+       struct ieee80211_tx_info *tx_info;
+
+       if (tx_queue->num_packets =3D=3D 0)
+               return;
+
+       list_for_each_entry_safe(sw_txhdr, sw_txhdr_tmp, &tx_queue->hdrs, t=
x_queue_list) {
+               list_del(&sw_txhdr->tx_queue_list);
+               tx_queue->num_packets--;
+
+               /* Can not send AMSDU frames as singles */
+               tx_info =3D IEEE80211_SKB_CB(sw_txhdr->skb);
+
+               /* Free mid & last AMSDU sub frames */
+               if (cl_tx_ctrl_is_amsdu(tx_info)) {
+                       cl_tx_amsdu_flush_sub_frames(cl_hw, sw_txhdr);
+               } else {
+                       if (tx_queue->type =3D=3D QUEUE_TYPE_SINGLE)
+                               cl_tx_single_free_skb(cl_hw, sw_txhdr->skb)=
;
+                       else
+                               kfree_skb(sw_txhdr->skb);
+
+                       cl_sw_txhdr_free(cl_hw, sw_txhdr);
+                       cl_hw->tx_packet_cntr.drop.queue_flush++;
+               }
+       }
+
+       /* Remove from schedule queue */
+       cl_txq_sched_list_remove(tx_queue);
+
+       /* Sanity check that queue is empty */
+       WARN_ON(tx_queue->num_packets > 0);
+}
+
+void cl_txq_flush_single(struct cl_hw *cl_hw, u16 idx)
+{
+       spin_lock_bh(&cl_hw->tx_lock_single);
+       cl_txq_flush(cl_hw, &cl_hw->tx_queues.single[idx]);
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_txq_flush_all_agg(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               cl_txq_flush(cl_hw, &cl_hw->tx_queues.agg[i]);
+}
+
+void cl_txq_flush_all_single(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               cl_txq_flush(cl_hw, &cl_hw->tx_queues.single[i]);
+}
+
+void cl_txq_flush_sta(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       int i =3D 0;
+       u8 sta_idx =3D cl_sta->sta_idx;
+       u32 queue_idx =3D 0;
+       struct cl_tx_queue *tx_queue =3D NULL;
+
+       spin_lock_bh(&cl_hw->tx_lock_agg);
+
+       /* Flush all aggregation queues for this station */
+       for (i =3D 0; i < IEEE80211_NUM_TIDS; i++)
+               if (cl_sta->agg_tx_queues[i])
+                       cl_txq_flush(cl_hw, cl_sta->agg_tx_queues[i]);
+
+       spin_unlock_bh(&cl_hw->tx_lock_agg);
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+
+       /* Flush all single queues for this station */
+       for (i =3D 0; i < AC_MAX; i++) {
+               queue_idx =3D QUEUE_IDX(sta_idx, i);
+               tx_queue =3D &cl_hw->tx_queues.single[queue_idx];
+               cl_txq_flush(cl_hw, tx_queue);
+               cl_txq_reset_counters(tx_queue);
+       }
+
+       /* Go over high prioirty queue and delete packets belonging to this=
 station */
+       cl_txq_delete_packets(cl_hw, &cl_hw->tx_queues.single[HIGH_PRIORITY=
_QUEUE], sta_idx);
+
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+}
+
+void cl_txq_agg_request_add(struct cl_hw *cl_hw, u8 sta_idx, u8 tid)
+{
+       int i =3D cl_txq_request_find(cl_hw, sta_idx, tid);
+       struct cl_req_agg_db *req_agg_db =3D NULL;
+
+       if (i !=3D -1) {
+               cl_dbg_trace(cl_hw, "ALREADY_ADDED - entry =3D %d, sta_idx =
=3D %u, tid =3D %u\n",
+                            i, sta_idx, tid);
+               return;
+       }
+
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++) {
+               req_agg_db =3D &cl_hw->req_agg_db[i];
+
+               if (!req_agg_db->is_used) {
+                       cl_dbg_trace(cl_hw, "ADD - entry =3D %d, sta_idx =
=3D %u, tid =3D %u\n",
+                                    i, sta_idx, tid);
+                       req_agg_db->is_used =3D true;
+                       req_agg_db->sta_idx =3D sta_idx;
+                       req_agg_db->tid =3D tid;
+                       cl_hw->req_agg_queues++;
+                       return;
+               }
+       }
+}
+
+void cl_txq_agg_request_del(struct cl_hw *cl_hw, u8 sta_idx, u8 tid)
+{
+       int i =3D cl_txq_request_find(cl_hw, sta_idx, tid);
+
+       if (i !=3D -1) {
+               cl_dbg_trace(cl_hw, "DEL - entry =3D %d, sta_idx =3D %u, ti=
d =3D %u\n",
+                            i, sta_idx, tid);
+               cl_hw->req_agg_db[i].is_used =3D false;
+               cl_hw->req_agg_queues--;
+       }
+}
+
+bool cl_txq_is_agg_available(struct cl_hw *cl_hw)
+{
+       u8 total_agg_queues =3D cl_hw->used_agg_queues + cl_hw->req_agg_que=
ues;
+
+       return (total_agg_queues < IPC_MAX_BA_SESSIONS);
+}
+
+bool cl_txq_single_is_full(struct cl_hw *cl_hw, u16 idx)
+{
+       struct cl_tx_queue *tx_queue =3D &cl_hw->tx_queues.single[idx];
+       bool is_full =3D 0;
+
+       spin_lock_bh(&cl_hw->tx_lock_single);
+       is_full =3D (tx_queue->max_packets =3D=3D tx_queue->num_packets);
+       spin_unlock_bh(&cl_hw->tx_lock_single);
+
+       return is_full;
+}
+
+void cl_txq_single_sched(struct cl_hw *cl_hw, u16 idx)
+{
+       /*
+        * Don't take lock because it is already taken by
+        * all functions that call cl_txq_single_sched().
+        */
+       struct cl_tx_queue *tx_queue =3D &cl_hw->tx_queues.single[idx];
+
+       if (tx_queue->num_packets)
+               cl_txq_sched(cl_hw, tx_queue);
+}
+
+bool cl_txq_is_fw_empty(struct cl_tx_queue *tx_queue)
+{
+       return (tx_queue->fw_free_space =3D=3D tx_queue->fw_max_size);
+}
+
+bool cl_txq_is_fw_full(struct cl_tx_queue *tx_queue)
+{
+       return (tx_queue->fw_free_space =3D=3D 0);
+}
+
+bool cl_txq_frames_pending(struct cl_hw *cl_hw)
+{
+       int i =3D 0;
+
+       /* Check if we have multicast/bradcast frame in FW queues */
+       if (!cl_txq_is_fw_empty(&cl_hw->tx_queues.bcmc))
+               return true;
+
+       /* Check if we have singles frame in FW queues */
+       for (i =3D 0; i < MAX_SINGLE_QUEUES; i++)
+               if (!cl_txq_is_fw_empty(&cl_hw->tx_queues.single[i]))
+                       return true;
+
+       /* Check if we have aggregation frame in FW queues */
+       for (i =3D 0; i < IPC_MAX_BA_SESSIONS; i++)
+               if (!cl_txq_is_fw_empty(&cl_hw->tx_queues.agg[i]))
+                       return true;
+
+       return false;
+}
+
+int cl_txq_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       switch (cli_params->option) {
+       case 'a':
+               return cl_txq_traffic_counters_print(cl_hw);
+       case 'b':
+               return cl_txq_drop_reasons_print(cl_hw);
+       case 'c':
+               return cl_txq_global_counters_print(cl_hw);
+       case 'd':
+               return cl_txq_stop_reasons_print(cl_hw);
+       case 'e':
+               return cl_txq_requested_agg_print(cl_hw);
+       case 'f':
+               return cl_txq_amsdu_stats_print(cl_hw);
+       case 'm':
+               return cl_txq_max_size_print(cl_hw);
+       case 'r':
+               cl_txq_stats_reset(cl_hw);
+               break;
+       case 's':
+               return cl_txq_sched_list_print(cl_hw);
+       case '?':
+               return cl_txq_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               break;
+       }
+
+       return 0;
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

