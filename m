Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2634B3AB923
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbhFQQMy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:54 -0400
Received: from mail-eopbgr80075.outbound.protection.outlook.com ([40.107.8.75]:12246
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232858AbhFQQLt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7x9lQiq3hQpemCVXvtYLrdpzUdnWufXEwJbQ0BzaVMtvXwZZA3qwbsumqj0IcDXeFVOnoPWBRcI4knI103hSq3uaoMBROVHoRSlWD4LHH1ztmGPOXEKOo6HnG1NUnW4FMaSYNEZGioR/4SwUPYxUPjghQ36d9HkuUVMwr2XP/rUfnx1dkuF3iI8L4lwJYkg3wKOl3DwX5uf2GT+arYd7PqXZy9F1ExlDRk00Zg2DuESGE5TyVgAip/nxuqLBnnbYjlGZHPZWHpmL10g+rNq6DadmldWRafR5Gao69a2PjWj0e0SUF3IgFnxBafOPbOG2YRnnneumi59OR38fgD36A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f4Vmsn/aQBqZ5XmzGp93bUE7FmB7KFQVKBi3RfJnkQ=;
 b=RXhEVDjQ0Sw9lZS4kX7J5gDRhea400udtyxFifIjfW2cQBf1QQTdhViP2LULohFP40XKmHiKrhwCyrnH1ZYgJY+kCOiiaY0cR4dJ3UfFTKqaG2FijKNMdFNNnje9a+gTqBXAdBvXxEQc/xEMknCCblS+aGpgFfPJzE+SHGtYk19BVYsQE/SM+JktRne2XHth/arZcZzp2VKrf6A41TOYOOuZmS140fF9SDk5roaq2qYuw5uHn/etusIpYWwvm6QDDlxW8PxkHOHRIBz/FpDdXdlQna4k/ftN6mXNKEAkLxaFFbve2C3tjWy5XFJyVEelImMtsRrYO24hsEBE9QPpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0f4Vmsn/aQBqZ5XmzGp93bUE7FmB7KFQVKBi3RfJnkQ=;
 b=SLNvCaADkfA66FJVIfRyA6ZR1KPr/KAY8scVlBslST3QtZUEtDLKojFmootPDZYioynYttm3uy1av3Sdf5VbKnNXt5A04HYWP3zFqJkCVNqmjmR6xnNeUIbtT6hO1H8oCyWEr4Gtfm6/7JEacivUoxJkK4W9dGjrguRBzCPitOo=
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
Subject: [RFC v1 216/256] cl8k: add tx/tx_inject.c
Date:   Thu, 17 Jun 2021 16:01:43 +0000
Message-Id: <20210617160223.160998-217-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45226289-2339-4408-3bc9-08d931a9e13b
X-MS-TrafficTypeDiagnostic: AM9P192MB1329:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB13292BDD29B2170B9F7E07BBF60E9@AM9P192MB1329.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DT74zmYIBgg+v7b4PZIdLUT2gICpIzMMS9PmOWOoMbAzSIxSlgy5HWyPKOf930mDt+1Bvl8eRk/s9j+ohZLim5AL5tR1N61IIKQNk13Is86yP6uYRDvyKNbee/iY2Cw0muXV1vojgipOOHrhoARvbiuegdoLOIWWFBxcfL8V7hDTkN+I6tpSmB1Uf4WQU0RCyuguXPJjFyX3/L07lVnIT2AA7p8za2KWPJy9keZPoV9dnyz7R+VsTojIWW+LLAGDaMuaaamXduETlGbFd6/5mHV3/2VCAcpfnYkT3h6Q2LoncGrMFPV3+iykpeRcZooe/nZhfPRXX3n5y12wHT8ObONNXeVGfDrEie6LgcPYORhNtaydb5OvOoKFpt5ZV+V76ug45pulJ6enJeFAZH6cYZqOV867FWxBvitSJsGzT1RuSSvQERsQyRGegln5/6e3qL3MQ/gvgalva7MZN93P/qv/8UX3jUOA0oiUpaaWzJyKd5eqqgit+dyeRdeDfo9DZoAiCEmReIPgryliB76ueaBhCF02ZCmyXMSDfCtLeQX+FnyLvJ9KcxvDQECQFduK8TMXcvP+3B3Zvu5Z3pA7Mxz0qaZ3tns7W7tozIHVa21rRZzxprZ1lKwu5tAxq1ZeN4bu/+HrnkPp6B3RT5PHuNwRyCWqV+MC63afEE2187J4dWSnyvaerhyKb9bAIBzKKSVnRxtZ17bjxsrdeoWWsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39850400004)(376002)(136003)(346002)(396003)(86362001)(38350700002)(8936002)(38100700002)(6916009)(52116002)(6486002)(55236004)(54906003)(36756003)(6506007)(956004)(4326008)(30864003)(186003)(2616005)(1076003)(478600001)(26005)(16526019)(107886003)(6666004)(66556008)(83380400001)(5660300002)(2906002)(6512007)(9686003)(8676002)(316002)(66476007)(66946007)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fBzORSWaTly1LfzZVTjEj28hnKpH4UnO3JR4OKmYnVPLg73lTtDi29Oz8Ay+?=
 =?us-ascii?Q?y1M32Xi3LPnie+RavQ357fQJulo4PAQgWlp1temPVex2V7E7Jt+oKr/iCI0I?=
 =?us-ascii?Q?JYGuIXc1NxUjsmpZpEG1sDulVgaA08OOjz7466w+jA18wgT0OuZ8WE+IVfbO?=
 =?us-ascii?Q?zp1dRVNzNAO8jX7kc/6QG2zrspugv6jaTjhT4TMSGnZbGUA2wk5rDgyeUtkR?=
 =?us-ascii?Q?i0/CqXtGKrtn/1DyUNx4qXGIFwrRWxvoNwBiTOfZkn0XSk8aQnkxj3VKoxOM?=
 =?us-ascii?Q?0ZoVQoE6X4IOnG99jT59UhluKalJSbmqYIxzzjPeYZGJlvEwSb4IKq8pa8GD?=
 =?us-ascii?Q?JBtPDyT9H/bKOjfJM8ArZqm/7TZl8KLfL4Zse3NUM5EUbOeRD4cYgfvMT9DZ?=
 =?us-ascii?Q?OniC+yerjCnLAKn40MjYDGBlDElbFxrr5vBXVabOAzwjWwbzyynZRIWa8nJY?=
 =?us-ascii?Q?1L7mUShh9B+ZJ93i4MWPcz6NQPBQImIcR3X2Jau+IwRTlAfM3UtNxvXRY8bJ?=
 =?us-ascii?Q?FJh9Bu6ptEj66fNm2lIrXoUxDlnYkDsUWhRJ3Evti+3etJ81C+3fGjzBOK3r?=
 =?us-ascii?Q?tixWDxmnvzScnBvTCpj4/M0wPKjhw3eW8kyT2bFVqgyGiWYPSqYwzjuA1dcj?=
 =?us-ascii?Q?Q1c+o6A6tVPwPloT5GWF0WuYknC6Qa0+cUYn7P2PCwmHAbRP8mapy4GCuNve?=
 =?us-ascii?Q?RoK3aMQDoDeSAt6aJ0VPAXBWioPQsBgF1Dg6T1D02BJhM0v+gxHFWYf1rkjU?=
 =?us-ascii?Q?68iP/MWpVApgpaz5Q2gLBvjEkMSUiAUKf+CfnhwyttRTlcsB1Tw1OTWOE0Jk?=
 =?us-ascii?Q?i1LIuc8AfAECCPoSEvhLiZvbF+3T+7g3AHFoN2Af634zjcQ/2H+8LMvSvT4a?=
 =?us-ascii?Q?fNmaEKDm09FCWrY8TdA8nUvzT8e8jW5IacCcRl0IqKbr99KYyiaOBX1vm3Vw?=
 =?us-ascii?Q?VylaH72tKty3z4e4h9a6vIMb3j/ok3nDm1A/KtlJzuRiIvEOCbrGerXlFWf7?=
 =?us-ascii?Q?1IHlwIAefxeoDmrEkgS7bTGrWuBOkZlsHX2SoEXhwkxGZSQxrmLFgRdyMCIS?=
 =?us-ascii?Q?i8D/8GX6SD8CtS+N/AeQJPnAMFvJmBruNpe1aQxr04dFDMj/2sBWMP+gIXPa?=
 =?us-ascii?Q?yCBMpBYchg/Bc4BVgrAmxexT2LkRjQz9HLa4vFSZuevD1D3kIzsgywAmVAs1?=
 =?us-ascii?Q?macacL0Xg2jMHSQ76BCANR48a/RVuaooD26XyVG3/Ym+CbR9TR4f3poqErRp?=
 =?us-ascii?Q?E2PJm4b3m7uh8GIAxWJ0ptBDbqL/eVff7Y1LuTngnSb3re3LQuGZWFUaRyhr?=
 =?us-ascii?Q?jt5IWsEEQA32Q6rLM9LTnnPs?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45226289-2339-4408-3bc9-08d931a9e13b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:34.9865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lKrhgdzoImhYKP7OLU01kvJjwiS6J+CrssCIaHEAWI3MuxxPVWnm6KyeDe0KutAW7+qpeiXcu7YLajpPux4Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1329
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/tx/tx_inject.c   | 364 ++++++++++++++++++
 1 file changed, 364 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/tx_inject.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/tx_inject.c b/drivers/net/=
wireless/celeno/cl8k/tx/tx_inject.c
new file mode 100644
index 000000000000..a311b7b8406a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/tx_inject.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/tx_inject.h"
+#include "tx/tx.h"
+#include "edca.h"
+#include "reg/reg_access.h"
+#include "rate_ctrl.h"
+#include "edca.h"
+#include "tx/tx_queue.h"
+#include "ate.h"
+#include "tx/single_cfm.h"
+#include "mac_addr.h"
+#include "tx/baw.h"
+#include "ampdu.h"
+#include "key.h"
+
+#define TX_BA_SESSION_TIMEOUT 10
+
+const static u8 skb_inject_prefix_single[] =3D {
+       0x88, 0x02,                         /* Frame control - DATA, QOS-DA=
TA, FROM-DS */
+       0x00, 0x00,                         /* Duration / ID */
+       0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, /* Addr1 - RA =3D DA */
+       0x00, 0x11, 0x22, 0x33, 0x44, 0x55, /* Addr2 - TA =3D BSSID */
+       0x00, 0x11, 0x22, 0x33, 0x44, 0x55, /* Addr3 - SA */
+       0x00, 0x00,                         /* Sequence control */
+       0x00, 0x00,                         /* QoS control */
+};
+
+struct sk_buff *cl_tx_inject_alloc_skb(struct cl_hw *cl_hw, struct cl_sta =
*cl_sta)
+{
+       u8 *skb_data =3D NULL;
+       u8 cyclic_data =3D 0;
+       u32 i;
+       struct sk_buff *skb =3D NULL;
+       struct ieee80211_tx_info *tx_info =3D NULL;
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+       u32 prefix_size =3D sizeof(skb_inject_prefix_single);
+
+       skb =3D dev_alloc_skb(tx_inject->packet_len);
+
+       if (!skb)
+               return NULL;
+
+       tx_info =3D IEEE80211_SKB_CB(skb);
+       memset(tx_info, 0, sizeof(struct ieee80211_tx_info));
+
+       /* Copy data */
+       skb_data =3D skb_put(skb, tx_inject->packet_len);
+
+       memcpy(skb_data, skb_inject_prefix_single, prefix_size);
+
+       if (cl_sta) {
+               skb->dev =3D cl_sta->cl_vif->dev;
+               struct ieee80211_qos_hdr *qos_hdr =3D (struct ieee80211_qos=
_hdr *)skb->data;
+
+               cl_mac_addr_copy(qos_hdr->addr1, cl_sta->addr);
+               cl_mac_addr_copy(qos_hdr->addr2, cl_sta->cl_vif->vif->addr)=
;
+               cl_mac_addr_copy(qos_hdr->addr3, cl_sta->cl_vif->vif->addr)=
;
+       }
+
+       for (i =3D prefix_size; i < tx_inject->packet_len; i++) {
+               *(skb_data + i) =3D cyclic_data;
+               cyclic_data++;
+       }
+
+       tx_info->band =3D cl_hw->nl_band;
+       tx_info->flags =3D IEEE80211_TX_CTL_INJECTED;
+
+       if (cl_sta) {
+               tx_info->hw_queue =3D CL_HWQ_BE;
+               tx_info->control.vif =3D cl_sta->cl_vif->vif;
+               tx_info->control.hw_key =3D cl_key_get(cl_sta);
+       } else {
+               struct cl_vif *cl_vif =3D cl_vif_get_first(cl_hw);
+
+               if (!cl_vif) {
+                       kfree_skb(skb);
+                       return NULL;
+               }
+
+               tx_info->hw_queue =3D CL_HWQ_VO;
+               tx_info->flags |=3D IEEE80211_TX_CTL_NO_ACK;
+               tx_info->control.vif =3D cl_vif->vif;
+       }
+
+       tx_inject->alloc_counter++;
+
+       return skb;
+}
+
+static struct cl_sta *get_first_sta(struct cl_hw *cl_hw)
+{
+       return list_first_entry_or_null(&cl_hw->cl_sta_db.head, struct cl_s=
ta, list);
+}
+
+static struct cl_sta *get_next_sta(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta)
+{
+       if (list_is_last(&cl_sta->list, &cl_hw->cl_sta_db.head))
+               return get_first_sta(cl_hw);
+       else
+               return list_next_entry(cl_sta, list);
+}
+
+static void cl_tx_inject_tasklet(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+       struct sk_buff *skb =3D NULL;
+
+       while ((tx_inject->current_counter < tx_inject->max_counter) || tx_=
inject->continuous) {
+               u16 queue_idx =3D tx_inject->cl_sta ?
+                       QUEUE_IDX(tx_inject->cl_sta->sta_idx, TX_INJECT_SIN=
GLE_AC) :
+                       HIGH_PRIORITY_QUEUE;
+
+               if (cl_txq_single_is_full(cl_hw, queue_idx))
+                       return;
+
+               if (tx_inject->alloc_counter =3D=3D TX_INJECT_MAX_SKBS)
+                       return;
+
+               skb =3D cl_tx_inject_alloc_skb(cl_hw, tx_inject->cl_sta);
+
+               if (!skb)
+                       return;
+
+               cl_tx_single(cl_hw, tx_inject->cl_sta, skb, false, true);
+
+               if (tx_inject->cl_sta)
+                       tx_inject->cl_sta =3D get_next_sta(cl_hw, tx_inject=
->cl_sta);
+
+               if (!tx_inject->continuous)
+                       tx_inject->current_counter++;
+       }
+}
+
+static void edca_set_aggressive(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       if (!tx_inject->aggressive_edca) {
+               struct edca_params aggressive_params =3D {
+                       .aifsn =3D 1, .cw_min =3D 0, .cw_max =3D 1, .txop =
=3D 0
+               };
+
+               cl_edca_set(cl_hw, EDCA_AC_VO, &aggressive_params, NULL);
+               tx_inject->aggressive_edca =3D true;
+       }
+}
+
+static void edca_restore_default(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       if (tx_inject->aggressive_edca) {
+               cl_edca_restore_conf(cl_hw, EDCA_AC_VO);
+               tx_inject->aggressive_edca =3D false;
+       }
+}
+
+void cl_tx_inject_init(struct cl_hw *cl_hw)
+{
+       tasklet_init(&cl_hw->tx_inject.tasklet, cl_tx_inject_tasklet, (unsi=
gned long)cl_hw);
+}
+
+void cl_tx_inject_close(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       tasklet_kill(&tx_inject->tasklet);
+}
+
+void cl_tx_inject_reset(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       /* Return packet_len tp default */
+       tx_inject->packet_len =3D TX_INJECT_SKB_LEN_DEFAULT;
+       tx_inject->cl_sta =3D NULL;
+}
+
+static void _cl_tx_inject_start(struct cl_tx_inject *tx_inject,
+                               u32 max_counter,
+                               bool continuous)
+
+{
+       tx_inject->current_counter =3D 0;
+       tx_inject->max_counter =3D max_counter;
+       tx_inject->continuous =3D continuous;
+       tx_inject->is_running =3D true;
+}
+
+void cl_tx_inject_start(struct cl_hw *cl_hw, u32 tx_cnt)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       edca_set_aggressive(cl_hw);
+
+       _cl_tx_inject_start(tx_inject, tx_cnt, false);
+
+       if (!tx_inject->cl_sta)
+               tx_inject->cl_sta =3D get_first_sta(cl_hw);
+
+       tasklet_schedule(&tx_inject->tasklet);
+}
+
+void cl_tx_inject_start_continuous(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       edca_set_aggressive(cl_hw);
+
+       _cl_tx_inject_start(tx_inject, 0, true);
+
+       if (!tx_inject->cl_sta)
+               tx_inject->cl_sta =3D get_first_sta(cl_hw);
+
+       tasklet_schedule(&tx_inject->tasklet);
+}
+
+static void _cl_tx_inject_stop(struct cl_tx_inject *tx_inject)
+{
+       tx_inject->current_counter =3D 0;
+       tx_inject->max_counter =3D 0;
+       tx_inject->continuous =3D false;
+       tx_inject->is_running =3D false;
+}
+
+void cl_tx_inject_stop(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       /* Return to default EDCA */
+       edca_restore_default(cl_hw);
+
+       _cl_tx_inject_stop(tx_inject);
+
+       if (tx_inject->cl_sta) {
+               struct cl_sta *cl_sta =3D NULL;
+
+               list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+                       u16 queue_idx =3D QUEUE_IDX(cl_sta->sta_idx, TX_INJ=
ECT_SINGLE_AC);
+
+                       cl_txq_flush_single(cl_hw, queue_idx);
+                       cl_single_cfm_poll_empty(cl_hw, queue_idx);
+               }
+       } else {
+               cl_txq_flush_single(cl_hw, HIGH_PRIORITY_QUEUE);
+               cl_single_cfm_poll_empty(cl_hw, HIGH_PRIORITY_QUEUE);
+       }
+}
+
+void cl_tx_inject_stop_in_recovery(struct cl_hw *cl_hw)
+{
+       /*
+        * When recovery starts:
+        *  - change edca back to default
+        *  - stop traffic
+        *  - kill tasklet
+        *  - free stations
+        */
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       if (!tx_inject->is_running)
+               return;
+
+       pr_debug("[TX inject] Stop due to recovery\n");
+
+       edca_restore_default(cl_hw);
+
+       _cl_tx_inject_stop(tx_inject);
+
+       cl_tx_inject_close(cl_hw);
+
+       cl_hw->ate_db.active =3D false;
+       cl_hw->entry_fixed_rate =3D false;
+}
+
+void cl_tx_inject_stop_traffic(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       _cl_tx_inject_stop(tx_inject);
+}
+
+bool cl_tx_inject_is_running(struct cl_hw *cl_hw)
+{
+       return cl_hw->tx_inject.is_running;
+}
+
+static void cl_tx_inject_cfm_single(struct cl_hw *cl_hw)
+{
+       struct cl_sta *cl_sta =3D NULL;
+
+       cl_sta_lock(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               u16 queue_idx =3D  QUEUE_IDX(cl_sta->sta_idx, TX_INJECT_SIN=
GLE_AC);
+
+               cl_txq_single_sched(cl_hw, queue_idx);
+       }
+
+       cl_sta_unlock(cl_hw);
+
+       cl_txq_single_sched(cl_hw, HIGH_PRIORITY_QUEUE);
+}
+
+void cl_tx_inject_cfm(struct cl_hw *cl_hw)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+
+       tx_inject->alloc_counter--;
+
+       if (tx_inject->current_counter < tx_inject->max_counter || tx_injec=
t->continuous)
+               tasklet_schedule(&tx_inject->tasklet);
+       else
+               cl_tx_inject_cfm_single(cl_hw);
+
+       if (tx_inject->is_running &&
+           tx_inject->alloc_counter =3D=3D 0 &&
+           tx_inject->current_counter =3D=3D tx_inject->max_counter) {
+               pr_debug("[TX inject] Complete - %u packets\n", tx_inject->=
max_counter);
+               _cl_tx_inject_stop(tx_inject);
+       }
+}
+
+void cl_tx_inject_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_tx_inject *tx_inject =3D &cl_hw->tx_inject;
+       bool stop_ate =3D false;
+
+       tasklet_disable(&tx_inject->tasklet);
+
+       if (cl_tx_inject_is_running(cl_hw)) {
+               if (tx_inject->cl_sta =3D=3D cl_sta) {
+                       tx_inject->cl_sta =3D get_next_sta(cl_hw, cl_sta);
+
+                       /*
+                        * If next STA is the same then only the current cl=
_sta exists.
+                        * In this case - stop ATE
+                        */
+                       if (tx_inject->cl_sta =3D=3D cl_sta)
+                               stop_ate =3D true;
+               }
+       }
+
+       if (stop_ate)
+               cl_ate_stop(cl_hw->hw->wiphy, NULL, NULL, 0);
+
+       tasklet_enable(&tx_inject->tasklet);
+}
+
+int cl_tx_inject_set_length(struct cl_hw *cl_hw, u32 length)
+{
+       if (length >=3D TX_INJECT_SKB_LEN_MIN && length <=3D TX_INJECT_SKB_=
LEN_MAX) {
+               cl_hw->tx_inject.packet_len =3D length;
+               return 0;
+       }
+
+       pr_debug("[TX inject] Packet length must be between %u and %u\n",
+                TX_INJECT_SKB_LEN_MIN, TX_INJECT_SKB_LEN_MAX);
+
+       return -EINVAL;
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

