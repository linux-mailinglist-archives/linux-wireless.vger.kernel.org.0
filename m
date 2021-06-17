Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDCC3AB8E0
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhFQQLE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:04 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:14478
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232277AbhFQQJz (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfHZk0t3nJRcgSvkXOpQC5ptmxkOxrogR9VyvsWq48nIzznQ6fTl7iCRk3BUQomHgCwPCo51/4AsQzuBgnHC/z8SI5lndIevp+HdXNILCFEI4cy+1WSbtwyKd+7fv6E49lF34H5roxZwZlBQxqA2iSa5nJxfQWlwu1KHuUSA0pqVGghVJwpNi1tsvt8sW8tJ8PVRo51+OngN2uVG5uFQuy/qeTKjAj/3XatS7ZAAOVp22A0vsQ9nozsG47SLMy0ia2DOfWTW+uEiAOitY2Ts0o7S1q7rlxIb++Tr7w6EZoLPfVx84jeBYLAZOK0Kr4qvMK9lc+DTiIFSOCCu5XeYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbijr2SNhKnpiKxFoFFjnmUZGOdPNBWFAJz3s7O+Gno=;
 b=CKJrXLsFRSgS6rFwtrfxww4Ff4apSWU6+xjv9TgGjTLAiUQhzcJnknrV6+logfiMZsD5YhJDaqGTlpVw1t5lHfsXNShyZNYcJxVqKVDCa8FUNXfLBAjQdnqrOKv24ZI0onH+uc7etEE/o7rmqZucpeg2UlSOBYqsCvFja3S/CamqAu5/K6grdSjrPBartbq05V4tBVVPY9O39iCKPh5g5MOL7McuxZlHlI0tcaITibXXrZ2z+Z9RoEj+VKYgX68hlCyqz14aBUeApuAbEOzDj9gxikXGcNjNL+cxsyPPhOcPdUhBUq8/1ibxoLIWG1BjNBu8lSW17j1IKwXNCjX+nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lbijr2SNhKnpiKxFoFFjnmUZGOdPNBWFAJz3s7O+Gno=;
 b=zR5XBUaZUEsOGVinsUw2Exx96ye3LQULeM/ZPS1yMg6VmHDHI4CreanggzwZ10RTWIOLoKN2Q0u0Iixx1weZiwD6ygSrJ9443c99vRu7pWTcIO/16eS0J7r7x8KdCEvAdOMk0jNGLez5z1scjmYi2J/VOS4Ht8mje0gkCitntE0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0981.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:06:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:37 +0000
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
Subject: [RFC v1 178/256] cl8k: add rx/rx_reorder.c
Date:   Thu, 17 Jun 2021 16:01:05 +0000
Message-Id: <20210617160223.160998-179-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00f46c62-c867-4858-4831-08d931a9c6b5
X-MS-TrafficTypeDiagnostic: AM9P192MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09818E786BE6BA44870876CCF60E9@AM9P192MB0981.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rdZ6VDAtBsHi0L9FGbQwJU0xvF5563OztXIbknxQFAPGaoe4U+hOTxkQSILI7MoozaQdxHmtOSAb9r5RdSJ+7rewqdhSf87oU4F+GPWMjO7/vKK2kSVU+0FNlMYixa5CXtjzl0PZ45ZdkCYtB9GcRgWgb7YfA2oGCV4wvmWrcy7e8tigi1xpkIX2BQVxw6okX5TaKQr5pQMl71XCySUjgNpAmj0QCJKhdHgMSfcfR+Eo8qgMMbzf4jYwj1EBlfYZOoUUDIrKw1cxf95PTCki+4SBocglaMr9cLl79eCOfTOzPefrn8I/HExSZEryk6Zlwe0TwHHokfaQQuRQRCW7nR7nWRsn7BoqELM4mMJau/2n++ZNacwXHYiclOSWw5p2xnOdL9dUnB8ljY5fHxEunLYMItPXb4EXT7eFk9r/cnevsDs147In4Fe01HYrVNEZKu5FAzIrXRjbVs7+Wmk7/JqA1CdVOc0XeJREZT9MMmuhXclxUxtw5GPOdwNUuKqy/QDzbO3El7dckQKTRhjPDhJzTMQRj0NKJmvI2PLHQ9J8s9KUAI6GWacnbqaF+iwySor7vZhB1W1Y6BqKg+xJ+YfjGp80n/SEUaoGjJ83hOaNwFbl8wrHRX/2WttYAADS6ts6Him31x9BXwVmfYcwgSoONJWjyLQbBthn41nG2uNTiemgjKueylyEMfZEjEyjYeMIqq1YJ6JIwjyKY/e0Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(86362001)(5660300002)(9686003)(54906003)(107886003)(6666004)(1076003)(2906002)(478600001)(6512007)(26005)(2616005)(38350700002)(16526019)(55236004)(38100700002)(6506007)(4326008)(8676002)(66946007)(30864003)(186003)(66476007)(66556008)(956004)(83380400001)(6916009)(8936002)(36756003)(52116002)(6486002)(316002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EHHVTem1f7AMISVv2lT/jJneTrAVx91GtnEabBl9dAwtN7+Qjr4VbquHzBm0?=
 =?us-ascii?Q?lvvNctvSHeSoS1xjDaqoVzASQw2xLi6n52C8JHwtws6klsNzsYUvXV7lRTD+?=
 =?us-ascii?Q?eveR8bXva6KCKO08FU+ywg5ePEupfugHGQq/oYFWpACD0kiCnH5uZEfy3giJ?=
 =?us-ascii?Q?RFJSTvx42ZlCqks+v/HQ+54u41b5uwO9HnH6YeLjt42Q8AVCw3rR0L66C0KG?=
 =?us-ascii?Q?6gstKOYuRNfHR5DUEDfN3nPOows+kNTYQEnr45CCs7eiZgZqoF8myuWnhI8h?=
 =?us-ascii?Q?piT8ygbI0p0dAnwgXEEd31CTVSAOE3zKwf4BMfoB0ZJUiJXucFcd0Hy+oJBW?=
 =?us-ascii?Q?0+bgHFLwz9yYzyeCxj5dSXHU8veL/N92MOmz3K10UY6xzBlBRtnp6APvtsrL?=
 =?us-ascii?Q?TQF4vql5itD3RPrx+YL/aiGiYTN8mG7Jv2gPgcY3yFa/lZVj2881oRPGN9JQ?=
 =?us-ascii?Q?byNmAFi0xtetULQruYslDACiWTXstg787Aw1rNAGB6NQTDsUBLqGKbRSZvA2?=
 =?us-ascii?Q?F8d+bQAhxZKJnup99j+Ymh+xcnanD6usLzr0IQBYgE6oIoNmooeVO3bjDuzx?=
 =?us-ascii?Q?K7ifRK443tJMoslZWh1c5mrPA0imp5TA8quqxz8zcr1I7C9KlwBTnnuMI2HD?=
 =?us-ascii?Q?4VK+qizszAwa9pkWzUDw6eeq/g7C2gXr1O6CwpfashnjgrH+co5GLqCXJQyr?=
 =?us-ascii?Q?wt3U3Elxmi7qR6jq118frOP8kNiaHtoXR3xOYRlLGoOUZVTnO0WEaxY1LCE+?=
 =?us-ascii?Q?vKZM/RF1ULSQDppP37mZpjJhIJ1/12icCUZ9nuNfmlw6ufpYGhWB3EBvQdP4?=
 =?us-ascii?Q?TeeilKWLUxz74CvYSyRB127CerkVpJMZ1uuzrLK+Hsp4dE67ow/6aiXHtNhH?=
 =?us-ascii?Q?AbMicVExpAUd9VvXjFWwU1/F7xcmzlNoakU0Q9RwhvLWKg9WOMLCKZW+cH3l?=
 =?us-ascii?Q?aVk1agzJDnMNgr9rohiI4e3NOyTZcT3Ha4wwlpsUWx7eyh1izrkm6jAaWHR7?=
 =?us-ascii?Q?SIFLUuuDdYyf1uX8gp97Nb9pToYsILjvWv0XAfNSjRtQ9fjF9f98aDdT6+EP?=
 =?us-ascii?Q?LtXNBlqTdczg3MWOyuqQcBOvDvz+JyelmuIeXK3pOoSSX6YBpvtTCwK8gv0q?=
 =?us-ascii?Q?eB0vyebHdQBeukH6txmL4AVufQwuUgPEkrY2i0ZsgZEbtTXamzXnwQ6KQj94?=
 =?us-ascii?Q?m1WjPKt7wx0IwvubgSX/7b4UruwXY1O2ylOG+e1vUWFmjkdfahuvM/Klncrx?=
 =?us-ascii?Q?iZc89Y7S/LIOf/mghF75vYMXVnrzuwbfusAnsyofZehLyi0Yl+XxBu0HDBOP?=
 =?us-ascii?Q?8svMitItxF8jxDeOQlbQinWr?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f46c62-c867-4858-4831-08d931a9c6b5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:50.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LXqATJcV5C1gwgc1iqePsTtIrM1+3MiJmUcfff5QoMzFGgfDgco5SdLoz6EJnSrxZhXORVXg8eTlIeUlp3n3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0981
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/rx/rx_reorder.c  | 335 ++++++++++++++++++
 1 file changed, 335 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rx/rx_reorder.c

diff --git a/drivers/net/wireless/celeno/cl8k/rx/rx_reorder.c b/drivers/net=
/wireless/celeno/cl8k/rx/rx_reorder.c
new file mode 100644
index 000000000000..7a5c38369d2e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rx/rx_reorder.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "rx_reorder.h"
+#include "sta.h"
+#include "utils/utils.h"
+
+#define REORDER_BUF_TIMEOUT (HZ / 10)
+
+static bool cl_rx_reorder_ready(struct cl_tid_ampdu_rx *tid_agg_rx, u8 ind=
ex)
+{
+       struct sk_buff_head *frames =3D &tid_agg_rx->reorder_buf[index];
+       struct sk_buff *tail =3D skb_peek_tail(frames);
+       struct ieee80211_rx_status *status;
+
+       if (tid_agg_rx->reorder_buf_filtered & BIT_ULL(index))
+               return true;
+
+       if (!tail)
+               return false;
+
+       status =3D IEEE80211_SKB_RXCB(tail);
+
+       if (status->flag & RX_FLAG_AMSDU_MORE)
+               return false;
+
+       return true;
+}
+
+static void cl_rx_release_reorder_frame(struct cl_tid_ampdu_rx *tid_agg_rx=
, int index,
+                                       struct sk_buff_head *frames)
+{
+       struct sk_buff_head *skb_list =3D &tid_agg_rx->reorder_buf[index];
+       struct sk_buff *skb;
+
+       lockdep_assert_held(&tid_agg_rx->reorder_lock);
+
+       if (skb_queue_empty(skb_list))
+               goto no_frame;
+
+       if (!cl_rx_reorder_ready(tid_agg_rx, index)) {
+               __skb_queue_purge(skb_list);
+               goto no_frame;
+       }
+
+       tid_agg_rx->stored_mpdu_num--;
+
+       while ((skb =3D __skb_dequeue(skb_list)))
+               __skb_queue_tail(frames, skb);
+
+no_frame:
+       tid_agg_rx->reorder_buf_filtered &=3D ~BIT_ULL(index);
+       tid_agg_rx->head_seq_num =3D ieee80211_sn_inc(tid_agg_rx->head_seq_=
num);
+}
+
+static void cl_rx_release_reorder_frames(struct cl_tid_ampdu_rx *tid_agg_r=
x,
+                                        u16 head_seq_num,
+                                        struct sk_buff_head *frames)
+{
+       int index;
+
+       lockdep_assert_held(&tid_agg_rx->reorder_lock);
+
+       while (ieee80211_sn_less(tid_agg_rx->head_seq_num, head_seq_num)) {
+               index =3D tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+               cl_rx_release_reorder_frame(tid_agg_rx, index, frames);
+       }
+}
+
+static void cl_reorder_release(struct cl_tid_ampdu_rx *tid_agg_rx, struct =
sk_buff_head *frames)
+{
+       u8 index, i, j;
+
+       lockdep_assert_held(&tid_agg_rx->reorder_lock);
+
+       /* Release buffer until next hole */
+       index =3D tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+       if (!cl_rx_reorder_ready(tid_agg_rx, index) && tid_agg_rx->stored_m=
pdu_num) {
+               u8 skipped =3D 1;
+
+               for (j =3D (index + 1) % tid_agg_rx->buf_size; j !=3D index=
;
+                    j =3D (j + 1) % tid_agg_rx->buf_size) {
+                       if (!cl_rx_reorder_ready(tid_agg_rx, j)) {
+                               skipped++;
+                               continue;
+                       }
+                       if (skipped &&
+                           !time_after(jiffies, tid_agg_rx->reorder_time[j=
] +
+                                       REORDER_BUF_TIMEOUT))
+                               goto set_release_timer;
+
+                       /* Incomplete A-MSDUs */
+                       for (i =3D (index + 1) % tid_agg_rx->buf_size; i !=
=3D j;
+                            i =3D (i + 1) % tid_agg_rx->buf_size) {
+                               __skb_queue_purge(&tid_agg_rx->reorder_buf[=
i]);
+                       }
+
+                       cl_rx_release_reorder_frame(tid_agg_rx, j, frames);
+
+                       tid_agg_rx->head_seq_num =3D
+                               (tid_agg_rx->head_seq_num +
+                                skipped) & IEEE80211_SN_MASK;
+                       skipped =3D 0;
+               }
+       } else {
+               while (cl_rx_reorder_ready(tid_agg_rx, index)) {
+                       cl_rx_release_reorder_frame(tid_agg_rx, index, fram=
es);
+                       index =3D tid_agg_rx->head_seq_num % tid_agg_rx->bu=
f_size;
+               }
+       }
+
+       if (tid_agg_rx->stored_mpdu_num) {
+               j =3D tid_agg_rx->head_seq_num % tid_agg_rx->buf_size;
+               index =3D j;
+               for (; j !=3D (index - 1) % tid_agg_rx->buf_size;
+                    j =3D (j + 1) % tid_agg_rx->buf_size) {
+                       if (cl_rx_reorder_ready(tid_agg_rx, j))
+                               break;
+               }
+
+ set_release_timer:
+               if (!tid_agg_rx->removed)
+                       cl_timer_rearm_offset(&tid_agg_rx->reorder_timer,
+                                             tid_agg_rx->reorder_time[j]);
+       } else {
+               cl_timer_disable(&tid_agg_rx->reorder_timer);
+       }
+}
+
+static void cl_rx_reorder_release_timeout(unsigned long data)
+{
+       struct cl_tid_ampdu_rx *tid_agg_rx =3D (struct cl_tid_ampdu_rx *)da=
ta;
+       struct sk_buff *skb =3D NULL;
+       struct cl_hw *cl_hw =3D NULL;
+       struct ieee80211_sta *sta =3D NULL;
+       struct sk_buff_head buffer;
+
+       if (!tid_agg_rx)
+               return;
+
+       __skb_queue_head_init(&buffer);
+
+       spin_lock(&tid_agg_rx->reorder_lock);
+
+       cl_hw =3D tid_agg_rx->cl_hw;
+       sta =3D tid_agg_rx->sta;
+       cl_reorder_release(tid_agg_rx, &buffer);
+
+       spin_unlock(&tid_agg_rx->reorder_lock);
+
+       while (!skb_queue_empty(&buffer)) {
+               skb =3D __skb_dequeue(&buffer);
+               ieee80211_rx_napi(cl_hw->hw, sta, skb, NULL);
+       }
+}
+
+static bool cl_rx_manage_reorder_buf(struct cl_tid_ampdu_rx *tid_agg_rx,
+                                    struct sk_buff *skb,
+                                    struct sk_buff_head *ordered_mpdu)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       struct ieee80211_rx_status *status =3D IEEE80211_SKB_RXCB(skb);
+       u16 sc =3D le16_to_cpu(hdr->seq_ctrl);
+       u16 mpdu_seq_num =3D (sc & IEEE80211_SCTL_SEQ) >> 4;
+       u16 head_seq_num, buf_size;
+       u8 index;
+       bool ret =3D true;
+
+       if (unlikely(tid_agg_rx->auto_seq)) {
+               tid_agg_rx->auto_seq =3D false;
+               tid_agg_rx->ssn =3D mpdu_seq_num;
+               tid_agg_rx->head_seq_num =3D mpdu_seq_num;
+       }
+
+       buf_size =3D tid_agg_rx->buf_size;
+       head_seq_num =3D tid_agg_rx->head_seq_num;
+
+       /* Current SN is smaller than the SSN */
+       if (unlikely(!tid_agg_rx->started)) {
+               if (ieee80211_sn_less(mpdu_seq_num, head_seq_num)) {
+                       ret =3D false;
+                       goto out;
+               }
+               tid_agg_rx->started =3D true;
+       }
+
+       /* Out of date sequence number */
+       if (ieee80211_sn_less(mpdu_seq_num, head_seq_num)) {
+               dev_kfree_skb(skb);
+               goto out;
+       }
+
+       /* SN exceeds buffer window */
+       if (!ieee80211_sn_less(mpdu_seq_num, head_seq_num + buf_size)) {
+               head_seq_num =3D ieee80211_sn_inc(ieee80211_sn_sub(mpdu_seq=
_num, buf_size));
+               cl_rx_release_reorder_frames(tid_agg_rx, head_seq_num, orde=
red_mpdu);
+       }
+
+       index =3D mpdu_seq_num % tid_agg_rx->buf_size;
+
+       /* Frame already stored */
+       if (cl_rx_reorder_ready(tid_agg_rx, index)) {
+               dev_kfree_skb(skb);
+               goto out;
+       }
+
+       if (mpdu_seq_num =3D=3D tid_agg_rx->head_seq_num &&
+           tid_agg_rx->stored_mpdu_num =3D=3D 0) {
+               if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
+                       tid_agg_rx->head_seq_num =3D
+                               ieee80211_sn_inc(tid_agg_rx->head_seq_num);
+               }
+               ret =3D false;
+               goto out;
+       }
+
+       /* Insert frame into reorder buffer */
+       __skb_queue_tail(&tid_agg_rx->reorder_buf[index], skb);
+       if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
+               tid_agg_rx->reorder_time[index] =3D jiffies;
+               tid_agg_rx->stored_mpdu_num++;
+               cl_reorder_release(tid_agg_rx, ordered_mpdu);
+       }
+
+ out:
+       return ret;
+}
+
+void cl_rx_reorder_ampdu(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                        struct sk_buff *skb, struct sk_buff_head *ordered_=
mpdu)
+{
+       struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)skb->data;
+       struct cl_tid_ampdu_rx *tid_agg_rx;
+       u8 tid, ack_policy;
+
+       if (!cl_sta)
+               return;
+
+       ack_policy =3D *ieee80211_get_qos_ctl(hdr) &
+                    IEEE80211_QOS_CTL_ACK_POLICY_MASK;
+       tid =3D ieee80211_get_tid(hdr);
+
+       tid_agg_rx =3D cl_sta->tid_agg_rx[tid];
+       if (!tid_agg_rx)
+               return;
+
+       spin_lock(&tid_agg_rx->reorder_lock);
+       if (!ieee80211_is_data_qos(hdr->frame_control) ||
+           is_multicast_ether_addr(hdr->addr1))
+               goto dont_reorder;
+
+       if (unlikely(hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_NULLF=
UNC)))
+               goto dont_reorder;
+
+       if (ack_policy !=3D IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
+           ack_policy !=3D IEEE80211_QOS_CTL_ACK_POLICY_NORMAL)
+               goto dont_reorder;
+
+       /* Ignore EAPOL frames */
+       if (cl_is_eapol(skb))
+               goto dont_reorder;
+
+       if (cl_rx_manage_reorder_buf(tid_agg_rx, skb, ordered_mpdu)) {
+               spin_unlock(&tid_agg_rx->reorder_lock);
+               return;
+       }
+
+ dont_reorder:
+       spin_unlock(&tid_agg_rx->reorder_lock);
+       __skb_queue_tail(ordered_mpdu, skb);
+}
+
+void cl_rx_reorder_close(struct cl_sta *cl_sta, u8 tid)
+{
+       struct cl_tid_ampdu_rx *tid_agg_rx =3D cl_sta->tid_agg_rx[tid];
+       u16 i;
+
+       spin_lock_bh(&tid_agg_rx->reorder_lock);
+       tid_agg_rx->removed =3D true;
+       spin_unlock_bh(&tid_agg_rx->reorder_lock);
+
+       cl_timer_disable_sync(&tid_agg_rx->reorder_timer);
+
+       spin_lock_bh(&tid_agg_rx->reorder_lock);
+       for (i =3D 0; i < tid_agg_rx->buf_size; i++)
+               __skb_queue_purge(&tid_agg_rx->reorder_buf[i]);
+
+       kfree(tid_agg_rx->reorder_buf);
+       kfree(tid_agg_rx->reorder_time);
+       cl_sta->tid_agg_rx[tid] =3D NULL;
+
+       spin_unlock_bh(&tid_agg_rx->reorder_lock);
+       kfree(tid_agg_rx);
+}
+
+void cl_rx_reorder_init(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 tid=
, u16 buf_size)
+{
+       struct cl_tid_ampdu_rx *tid_agg_rx;
+       u16 i;
+
+       tid_agg_rx =3D kzalloc(sizeof(*tid_agg_rx), GFP_KERNEL);
+       if (!tid_agg_rx)
+               return;
+
+       spin_lock_init(&tid_agg_rx->reorder_lock);
+
+       cl_timer_init(&tid_agg_rx->reorder_timer, cl_rx_reorder_release_tim=
eout,
+                     (unsigned long)tid_agg_rx, REORDER_BUF_TIMEOUT + 1, f=
alse);
+
+       tid_agg_rx->reorder_buf =3D
+               kcalloc(buf_size, sizeof(struct sk_buff_head), GFP_KERNEL);
+       tid_agg_rx->reorder_time =3D
+               kcalloc(buf_size, sizeof(unsigned long), GFP_KERNEL);
+       if (!tid_agg_rx->reorder_buf || !tid_agg_rx->reorder_time) {
+               pr_err("Allocation failed!\n");
+               kfree(tid_agg_rx->reorder_buf);
+               kfree(tid_agg_rx->reorder_time);
+               return;
+       }
+
+       for (i =3D 0; i < buf_size; i++)
+               __skb_queue_head_init(&tid_agg_rx->reorder_buf[i]);
+
+       tid_agg_rx->ssn =3D 0;
+       tid_agg_rx->head_seq_num =3D 0;
+       tid_agg_rx->buf_size =3D buf_size;
+       tid_agg_rx->stored_mpdu_num =3D 0;
+       tid_agg_rx->auto_seq =3D 0;
+       tid_agg_rx->started =3D false;
+       tid_agg_rx->reorder_buf_filtered =3D 0;
+       tid_agg_rx->tid =3D tid;
+       tid_agg_rx->sta =3D &cl_sta->stainfo->sta;
+       tid_agg_rx->cl_hw =3D cl_hw;
+       cl_sta->tid_agg_rx[tid] =3D tid_agg_rx;
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

