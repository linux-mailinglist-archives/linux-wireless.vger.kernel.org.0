Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680673AB928
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQQNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:06 -0400
Received: from mail-eopbgr10062.outbound.protection.outlook.com ([40.107.1.62]:13120
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233713AbhFQQLx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSMpkF0YvcL0Dk8ncLNHpS/LTUIVRcK5uhdpMr7UoppuyVFipfHtS2B181rynawnJ74lpsD/Jm9gPNZnxnmpbhwgdrcG1j3/59xMHEKvMzYjtVJ1masTe+VEp5dYjalv0me03ofgClJk0CU7R4d/TUVPIaoI0LiUL1dvGVLJzuozuhQp8+OGtR9MLu/J3kNmiN/AT1Qbi67WOC3rEeVDSUF+1tfWYgbHPMoeBuPjSe8zI61kZIF/PbZON7cuK4wKII6ossEwlq95sYR7E98GjmiA70p4l7l1h6udu7DgRliofdmGH9riT0sGZJtaI60vr98WO6nMswv14IV8NrZidw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zj9/ivXdi6XLVKAukd4eP6IpgdaQCFPAgiT9M9l0SA=;
 b=c+sYEdIKLvJ6tepdKTFsq6+tYEMwe+4hhW9IxPZSelcHmbYTxd+TT5qBPe9e93rH8WEp66g08rDnMzweVoOmMnnc1/8TXak4f4bOzqlo+k2Qm1u2xI9p/fwI7vgQDt7hrCEHismIvKzsRB3aoU0fz+34vRub6u7kkw0NS5vjeUDHu1G1+iwAWNCnIqFCc/slpbceGUpllcM5xpah7B8AVZo0W0vKSo8wsYEkBjGcdyap09FqU4GaH6JvdFYcASySxbZFyyT8AOxjAfPQ3RRlf6qLX9bL4psbT+7UWb+tQKa1cxyvgtn0QTe+mxdPtWoIBFTI7wI5v0iDP8F0wUsT2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zj9/ivXdi6XLVKAukd4eP6IpgdaQCFPAgiT9M9l0SA=;
 b=dBJxpzcxFCFgPGdOB6/orGiYj5u9xaBlYMijZwGgoN07ia0UmNul4Kb9G4kkQxHFi7QKhKpaCcfQ+uL8Szfx1a7u05B/3YoE3OuyisH8EAQSgjCeQoK9NpbPqGu4ihewNgCQl5hXOIrMjWWVTuyWIYc/bZgZiQ0EpRzmOzRVooQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0515.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:45::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:08:01 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:01 +0000
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
Subject: [RFC v1 239/256] cl8k: add wrs/wrs.c
Date:   Thu, 17 Jun 2021 16:02:06 +0000
Message-Id: <20210617160223.160998-240-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f027522-1b74-4187-4072-08d931a9f0a3
X-MS-TrafficTypeDiagnostic: AM0P192MB0515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0515C37799BA0D034226232CF60E9@AM0P192MB0515.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgRVvUOIpvQWptmD/Zfj7ivhec98rU3Juad2wsPF+1k6UX3pc7e2roNOywTON1g2EN/cBeOpO2JfbsLjxwxYPji047ORoGX1WBY8r18GHp/mE3pkAL6Pgd0gWGTveNOlpzSP1IdoOetvjcXjIqP4hxJkTEppmCX9TvV2Q0ga1pdKbf0+giVTAXyOrL5737JXLKSigY7wmR1FEk5BiNijeN3DVevrhfXxnuOexLPolR59IPWxi01paTaw7JPdPWUKz29PjS8WGY47+T1kF+rJ3fAuaZMorp4GJr45eJmKUKfR4qTdBqWh5PtA4JdjwIImoZW/s5BF3xKXtwDmTN91k62K1wR0OHOcUTl9VMXbPrRVoHF5rWvAKTIKZKyxbWnjn7CtxogdqwN+qrQ7NeRV3mUwW4f6i95cjETvdBt+YsYIrCYkSuWPq9Gaa1lpJyXVTkzHZnKbyMFpj6xlz5cF+k6GJLmYX42ockPSz+KzyD0+CR5Nhu8dYtzDxJzl3sO2XMEquEcx1gKW5S7Wv/7qFJOSGM8roXVTIKYylmDafnel1Q3Y1mG5nGEgfh5W5RgquEUjQ2StfjD5Fdfd53+/6gr4B18Fbau8cTtn/g22r+Kn7GwhUIM83B2QTyx9VHO9upDZ8q+PZ960ISqeeSGNGMC1YOmxFnEsA1eNBqrQjKpacYW7tr640XcKe2g3H3huCH0LqRKlkU2EO+acIQu3r4wtse3PBY2l1eIGg7YCKzU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(376002)(39850400004)(136003)(366004)(346002)(4326008)(16526019)(83380400001)(1076003)(8676002)(9686003)(55236004)(36756003)(478600001)(8936002)(956004)(186003)(6486002)(38350700002)(6512007)(6916009)(52116002)(86362001)(5660300002)(2906002)(38100700002)(66946007)(2616005)(316002)(6506007)(30864003)(26005)(54906003)(66476007)(107886003)(66556008)(69590400013)(32563001)(559001)(579004)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gk0DPqhrNVm7dBy6T5HCIOC0HXen1X9xeeZCSmz3iA9Pial+mPW+9+9dPyQa?=
 =?us-ascii?Q?KGJNKok6u6AnXApcnd6GCAn2An6iXdI3evlWa584JoZEr1H96Y+N5cXtg/4R?=
 =?us-ascii?Q?TJkgLci43Yx6irqCpD7D4CXarTbDm/ZAMLWtbrOwqfbyPPTfYtB2S3HNyk7B?=
 =?us-ascii?Q?hfTTN1UkshRfmDWeAmi9lZAvHIlyi2uAgzIPOXK8wKa/j6FdS5/sa8TrDinr?=
 =?us-ascii?Q?IiPgTIQ6XTQ9TqtgG2eMNOyOl8okSPdY5YYm7vImNm5JF81WiM1trNGfQX0u?=
 =?us-ascii?Q?pa93EnnWlsjpzwFRbYFxKG5HO5RqxioeNl1iCCJ0T/kxiBOBhJEKpZQSGh+N?=
 =?us-ascii?Q?2MallxAoAPs9HM9SqWL4qrC4YbnYgAgwHMRDtxolXYmLc2K/MvdHWbigBwrL?=
 =?us-ascii?Q?shYXfKmk/NaH3Os5cm2z1IBRLFe3pP+h9/oov+lerihUP5XUYLFP7aoflPBI?=
 =?us-ascii?Q?GSxGOkdkAwlJ5LVWEru3jCL/vj0UEB8zZB/jZjGIlI1kIG7ZZVOmx8OnNvPh?=
 =?us-ascii?Q?oiVu8tRDpXzbmLj2dxYC1WN0XnyZfc+ySLX4A3yCEqlimOqh00OPszEiWANi?=
 =?us-ascii?Q?6yXPgjO8mkaIF+tubMkHyudD0g1/yMe1unF9MgDgZ6LG5U2bz29SscNdAHgh?=
 =?us-ascii?Q?/m3uSKrCDfWPCXf5SxPNkKrvc1rpVpDQUdA0HdJm5wAeO9TzQ1Enad3HJCkL?=
 =?us-ascii?Q?rRMdAPC7igSjsqlfSbfaozpVXSvM5bqtW6jGdkEg+p45P2VeFz00MnmmYkfa?=
 =?us-ascii?Q?fhj8ZiJaZ805+naC3umcBKP3tX3AKOXxVYItMffzjWA+HTvxHwI1zYzj76cW?=
 =?us-ascii?Q?kFfUns6+jEucKZKEEYt80kLafi6sSJuFKF1a1P4pfn1Ktqy5F/VW0BsPEnWg?=
 =?us-ascii?Q?O6aQNi+pjFd3eV7LLsu5a4bCzXAauMmkD3nPws+TsVHRHSaUVCFjSWL+DHsv?=
 =?us-ascii?Q?4EcyQ3bx/+CIm5WESxBjYhmH+z1eO3tosLY16iPRcERfhnJU+iMp9vn5E8GK?=
 =?us-ascii?Q?HAB3VpudK1Blbid79Hlpm/B0ZWGcZuL3rWmhrs8WRqW68Hf8tE+bml0En2gy?=
 =?us-ascii?Q?PB/Fgc03y5chra2bAne5WTq3bzzyLurN2HlDn/GAbQA4xgzTg//6Wfdj+GmL?=
 =?us-ascii?Q?bUldsoztoYQlkB8hMAOyomMmlbJkfE3B71NNhzN0dyyVeC1KiY9cR7BKpsuT?=
 =?us-ascii?Q?P/SKEQVlogZgll+dExTjtdmnyH4ykreVKbo3/dfWUX7s2PBq0Es3O+Tgr1wm?=
 =?us-ascii?Q?z4644Wn5gyyoXnv1lqeMLQOY7QSZS+q3wtTfzKtSZ/uNQgAMyRwvooPxFr6P?=
 =?us-ascii?Q?pH3foG3Reoz1RGV8htkfonRt?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f027522-1b74-4187-4072-08d931a9f0a3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:00.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iz+jtC/HKXwGddPWivrF5UfaUwaB433pzYTMjw4tfF1eeoG9FCYyu76wNdEXZtRLSEog8zzJXEjBQxZC3wI8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0515
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/wrs/wrs.c | 1159 ++++++++++++++++++++
 1 file changed, 1159 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs.c b/drivers/net/wirel=
ess/celeno/cl8k/wrs/wrs.c
new file mode 100644
index 000000000000..5e2af5d34c8e
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs.c
@@ -0,0 +1,1159 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/kernel.h>
+#include "wrs/wrs.h"
+#include "wrs/wrs_stats.h"
+#include "wrs/wrs_tables.h"
+#include "wrs/wrs_rssi.h"
+#include "env_det.h"
+#include "utils/math.h"
+#include "rssi.h"
+#include "band.h"
+#include "rate_ctrl.h"
+#include "chip.h"
+#include "ext/dyn_bcast_rate.h"
+#include "reg/reg_mac_hw.h"
+#include "data_rates.h"
+#include "rsrc_mgmt.h"
+
+static void cl_wrs_reset_params_cntrs(struct cl_wrs_params *wrs_params)
+{
+       wrs_params->frames_total =3D 0;
+       wrs_params->fail_total =3D 0;
+       wrs_params->ba_not_rcv_total =3D 0;
+       wrs_params->epr_acc =3D 0;
+       wrs_params->up_same_time_cnt =3D 0;
+       wrs_params->down_time_cnt =3D 0;
+}
+
+static bool cl_wrs_down_epr_check(struct cl_wrs_db *wrs_db, struct cl_wrs_=
sta *wrs_sta,
+                                 struct cl_wrs_params *wrs_params, u8 drop=
_factor,
+                                 enum cl_wrs_decision decision)
+{
+       u16 curr_rate_idx =3D wrs_params->rate_idx;
+       struct cl_wrs_table *curr_rate =3D &wrs_params->table[curr_rate_idx=
];
+       u64 curr_epr_acc =3D curr_rate->epr_acc;
+       u32 curr_total =3D curr_rate->frames_total;
+       u16 down_rate_idx =3D curr_rate->rate_down.rate_idx;
+       struct cl_wrs_table *down_rate =3D &wrs_params->table[down_rate_idx=
];
+       u64 down_epr_acc =3D down_rate->epr_acc;
+       u32 down_total =3D down_rate->frames_total;
+       u16 down_data_rate =3D 0;
+       u64 condition1 =3D 0, condition2 =3D 0;
+       bool down_decision =3D false, allow_penalty =3D true;
+
+       if (wrs_params->calc_ba_not_rcv) {
+               curr_total +=3D curr_rate->ba_not_rcv_total;
+               down_total +=3D down_rate->ba_not_rcv_total;
+       }
+
+       /*
+        * In the EPR of down candidate is better than or equal to current =
EPR =3D> return true
+        *
+        * (1) curr_epr <=3D down_epr * factor(%)
+        *
+        *       curr_epr_acc     down_epr_acc     factor
+        * (2)  -------------- <=3D -------------- * --------
+        *        curr_total       down_total       100
+        *
+        * (3) curr_epr_acc * down_total * 100 <=3D down_epr_acc * curr_tot=
al * factor
+        *
+        * (4) conditation1 <=3D conditation2
+        *                                                         down_epr=
_acc
+        * If (down_total =3D=3D 0) we use down_data_rate instead of: -----=
---------
+        *                                                          down_to=
tal
+        */
+       if (down_total) {
+               condition1 =3D curr_epr_acc * down_total * 100;
+               condition2 =3D down_epr_acc * curr_total * drop_factor;
+       } else {
+               down_data_rate =3D cl_data_rates_get_x10(wrs_params->tx_par=
ams.mode,
+                                                      down_rate->rate.bw,
+                                                      down_rate->rate.nss,
+                                                      down_rate->rate.mcs,
+                                                      down_rate->rate.gi);
+
+               condition1 =3D curr_epr_acc * 100;
+               condition2 =3D (u64)down_data_rate * curr_total * drop_fact=
or;
+               allow_penalty =3D false;
+       }
+
+       wrs_params->penalty_decision_dn =3D wrs_db->step_down;
+
+       if (condition2 && condition1 <=3D condition2) {
+               down_decision =3D true;
+
+               if (allow_penalty) {
+                       /*
+                        * The penalty is calculated as follow:
+                        *
+                        * penalty =3D MAX_STEP * penalty_factor
+                        *                                      epr_curr
+                        * penalty =3D MAX_STEP * (100% - 100% * ----------=
)
+                        *                                      epr_down
+                        *
+                        *                                    conditation1
+                        * penalty =3D MAX_STEP * (100% - 100% ------------=
--)
+                        *                                    conditation2
+                        */
+
+                       u64 penalty_factor =3D 100 - div64_u64(condition1 *=
 100, condition2);
+                       u16 max_step =3D wrs_db->time_th_max_up - wrs_db->s=
tep_down;
+
+                       wrs_params->penalty_decision_dn +=3D
+                               div64_u64(max_step * penalty_factor, 100);
+               }
+
+               if (decision !=3D WRS_DECISION_SAME)
+                       wrs_pr_info(wrs_db,
+                                   "[WRS] EPR check: sta =3D %u, pkt_curr =
=3D %u, pkt_down =3D %u, "
+                                   "epr_curr =3D %llu, epr_down * %u%% =3D=
 %llu, penalty =3D %u\n",
+                                   wrs_sta->sta_idx,
+                                   curr_total,
+                                   down_total,
+                                   div64_u64(curr_epr_acc, curr_total * 10=
),
+                                   drop_factor,
+                                   down_total ?
+                                   div64_u64(down_epr_acc * drop_factor, d=
own_total * 1000) :
+                                   (down_data_rate / 10),
+                                   wrs_params->penalty_decision_dn);
+       }
+
+       return down_decision;
+}
+
+static void cl_wrs_time_thr_max_handler(struct cl_wrs_db *wrs_db,
+                                       struct cl_wrs_table *table, u8 up_i=
dx)
+{
+       /*
+        * Check if there are at least two UP rates,
+        * and all UP rates reached max time threshold
+        */
+       u8 i =3D 0;
+       u8 time_th_max =3D 0;
+
+       for (i =3D 0; i < WRS_TABLE_NODE_UP_MAX; i++) {
+               if (table->rate_up[i].rate_idx =3D=3D WRS_INVALID_RATE)
+                       continue;
+
+               if (table->rate_up[i].time_th !=3D wrs_db->time_th_max_up)
+                       return;
+
+               time_th_max++;
+       }
+
+       if (time_th_max < 2)
+               return;
+
+       /* Find the next max rate, and decrease its time threshold by 1 */
+       i =3D 0;
+       while (i < WRS_TABLE_NODE_UP_MAX) {
+               up_idx++;
+               if (up_idx =3D=3D WRS_TABLE_NODE_UP_MAX)
+                       up_idx =3D WRS_TABLE_NODE_UP_MCS;
+
+               if (table->rate_up[up_idx].rate_idx !=3D WRS_INVALID_RATE) =
{
+                       /*
+                        * If all up rates reached max time threshold,the f=
irst up
+                        * rate will always be selected.
+                        * To overcome it, we decrease the time threshold o=
f the next
+                        * up rate by 1 (so it will be samller and selected=
 next time)
+                        */
+                       table->rate_up[up_idx].time_th--;
+                       break;
+               }
+
+               i++;
+       }
+}
+
+static bool cl_wrs_find_up_candidate(struct cl_wrs_db *wrs_db, struct cl_w=
rs_params *wrs_params,
+                                    u16 *up_rate_idx, u32 *up_time_th)
+{
+       bool up_rate_valid =3D false;
+       u8 up_idx =3D 0;
+       u8 up_candidate =3D 0;
+       u16 rate_idx =3D 0;
+       struct cl_wrs_table *table =3D &wrs_params->table[wrs_params->rate_=
idx];
+
+       *up_rate_idx =3D WRS_INVALID_RATE;
+       *up_time_th =3D U32_MAX;
+
+       for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+               rate_idx =3D table->rate_up[up_idx].rate_idx;
+
+               if (rate_idx =3D=3D WRS_INVALID_RATE)
+                       continue;
+
+               if (wrs_db->quick_up_en && table->rate_up[up_idx].quick_up_=
check) {
+                       *up_rate_idx =3D rate_idx;
+                       *up_time_th =3D wrs_db->quick_up_interval;
+                       up_rate_valid =3D true;
+                       up_candidate =3D up_idx;
+                       break;
+               } else if (table->rate_up[up_idx].time_th < *up_time_th) {
+                       *up_rate_idx =3D rate_idx;
+                       *up_time_th =3D table->rate_up[up_idx].time_th;
+                       up_rate_valid =3D true;
+                       up_candidate =3D up_idx;
+               }
+       }
+
+       if (wrs_db->time_th_max_up =3D=3D *up_time_th)
+               cl_wrs_time_thr_max_handler(wrs_db, table, up_candidate);
+
+       return up_rate_valid;
+}
+
+static bool cl_wrs_epr_immeidate_down(struct cl_hw *cl_hw, struct cl_wrs_d=
b *wrs_db,
+                                     struct cl_wrs_sta *wrs_sta, struct cl=
_wrs_params *wrs_params,
+                                     u16 down_rate_idx)
+{
+       if (cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+                                 wrs_db->immediate_drop_epr_factor,
+                                 WRS_DECISION_DOWN_IMMEDIATE)) {
+               /*
+                * If there are several immediate drops in a row ignore the=
m,
+                * because it is probably not realted to bad TX rate
+                */
+               wrs_params->immediate_drop_cntr++;
+
+               if (wrs_params->immediate_drop_cntr > wrs_db->immediate_dro=
p_max_in_row) {
+                       wrs_params->immediate_drop_ignore++;
+
+                       cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+                       cl_wrs_reset_params_cntrs(wrs_params);
+
+                       wrs_pr_info(wrs_db,
+                                   "[WRS] sta %u - ignore immediate down d=
ecision (cntr=3D%u)\n",
+                                   wrs_sta->sta_idx, wrs_params->immediate=
_drop_cntr);
+                       return true;
+               }
+
+               cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                    WRS_DECISION_DOWN_IMMEDIATE, down_rate=
_idx);
+               return true;
+       }
+
+       return false;
+}
+
+static void cl_wrs_decision_up(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_=
db,
+                              struct cl_wrs_sta *wrs_sta, struct cl_wrs_pa=
rams *wrs_params,
+                              u16 up_rate_idx, u32 up_th)
+{
+       enum cl_wrs_decision up_decision =3D (up_th =3D=3D wrs_db->quick_up=
_interval) ?
+               WRS_DECISION_UP_QUICK : WRS_DECISION_UP;
+
+       cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params, up_decisio=
n, up_rate_idx);
+}
+
+static void cl_wrs_decision_same(struct cl_hw *cl_hw, struct cl_wrs_db *wr=
s_db,
+                                struct cl_wrs_sta *wrs_sta, struct cl_wrs_=
params *wrs_params,
+                                u16 rate_idx)
+{
+       cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params, WRS_DECISI=
ON_SAME, rate_idx);
+}
+
+static void cl_wrs_epr_decision(struct cl_hw *cl_hw, struct cl_wrs_db *wrs=
_db,
+                               struct cl_wrs_sta *wrs_sta, struct cl_wrs_p=
arams *wrs_params)
+{
+       u16 curr_rate_idx =3D wrs_params->rate_idx;
+       struct cl_wrs_table *table =3D &wrs_params->table[curr_rate_idx];
+       u16 down_rate_idx =3D table->rate_down.rate_idx;
+       u16 up_rate_idx =3D 0;
+       u16 down_th =3D table->rate_down.time_th;
+       u32 up_th =3D 0;
+       bool up_rate_valid =3D false;
+
+       /* Check if we transmitted enough frames for taking decision */
+       if ((wrs_params->frames_total + wrs_params->ba_not_rcv_total) <
+           wrs_db->min_frames_for_decision)
+               return;
+
+       up_rate_valid =3D cl_wrs_find_up_candidate(wrs_db, wrs_params, &up_=
rate_idx, &up_th);
+
+       /* RSSI protect */
+       if (wrs_db->rssi_protect_en)
+               if (cl_wrs_rssi_prot_decision(cl_hw, wrs_db, wrs_sta, up_ra=
te_valid,
+                                             up_rate_idx, down_rate_idx))
+                       return;
+
+       if (down_rate_idx !=3D curr_rate_idx) {
+               /* Down immediate */
+               if (wrs_db->immediate_drop_en)
+                       if (cl_wrs_epr_immeidate_down(cl_hw, wrs_db, wrs_st=
a,
+                                                     wrs_params, down_rate=
_idx))
+                               return;
+
+               /* Down */
+               if (wrs_params->down_time_cnt >=3D down_th) {
+                       if (cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_para=
ms,
+                                                 wrs_db->epr_factor, WRS_D=
ECISION_DOWN)) {
+                               cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta=
, wrs_params,
+                                                    WRS_DECISION_DOWN, dow=
n_rate_idx);
+                               return;
+                       }
+
+                       wrs_params->down_time_cnt =3D 0;
+               }
+       }
+
+       /* Up-same */
+       if (wrs_params->up_same_time_cnt >=3D up_th) {
+               if (up_rate_valid)
+                       cl_wrs_decision_up(cl_hw, wrs_db, wrs_sta, wrs_para=
ms, up_rate_idx, up_th);
+               else
+                       cl_wrs_decision_same(cl_hw, wrs_db, wrs_sta, wrs_pa=
rams, curr_rate_idx);
+
+               return;
+       }
+
+       /*
+        * If there is no valid UP rate and the EPR is more
+        * than EPR down threshold =3D> make a same decision
+        */
+       if (!up_rate_valid &&
+           !cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+                                  wrs_db->epr_factor, WRS_DECISION_SAME))
+               cl_wrs_decision_same(cl_hw, wrs_db, wrs_sta, wrs_params, cu=
rr_rate_idx);
+}
+
+static void cl_wrs_divide_weights_by_two(struct cl_wrs_table *table_node)
+{
+       u8 up_idx =3D 0;
+       struct cl_wrs_table_node *rate_up;
+
+       /*
+        * Converge weights - divide all weights by 2
+        * (make sure they do not go below their init value)
+        */
+       if (table_node->rate_down.rate_idx !=3D WRS_INVALID_RATE)
+               table_node->rate_down.time_th =3D max(table_node->rate_down=
.time_th >> 1,
+                                                   WRS_INIT_MSEC_WEIGHT_DO=
WN);
+
+       for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+               rate_up =3D &table_node->rate_up[up_idx];
+
+               if (rate_up->rate_idx !=3D WRS_INVALID_RATE)
+                       rate_up->time_th =3D max(rate_up->time_th >> 1, WRS=
_INIT_MSEC_WEIGHT_UP);
+
+               if (rate_up->time_th =3D=3D WRS_INIT_MSEC_WEIGHT_UP)
+                       rate_up->quick_up_check =3D false;
+       }
+}
+
+static void cl_wrs_converge_weights(struct cl_wrs_params *wrs_params)
+{
+       /*
+        * Converge weights - divide the weights by 2 (except for the curre=
nt rate),
+        * and reset PER counters (except for current rate, down rate, and =
down-down rate).
+        */
+       u16 i;
+       u16 curr_idx =3D wrs_params->rate_idx;
+       u16 down_idx =3D wrs_params->table[curr_idx].rate_down.rate_idx;
+       u16 down2_idx =3D wrs_params->table[down_idx].rate_down.rate_idx;
+
+       for (i =3D 0; i < wrs_params->table_size; i++) {
+               if (i =3D=3D curr_idx)
+                       continue;
+
+               cl_wrs_divide_weights_by_two(&wrs_params->table[i]);
+
+               if (i !=3D down_idx && i !=3D down2_idx) {
+                       wrs_params->table[i].frames_total =3D 0;
+                       wrs_params->table[i].ba_not_rcv_total =3D 0;
+                       wrs_params->table[i].epr_acc =3D 0;
+               }
+       }
+}
+
+static void cl_wrs_converge_weights_idle_decision(struct cl_hw *cl_hw,
+                                                 struct cl_wrs_db *wrs_db,
+                                                 struct cl_wrs_sta *wrs_st=
a,
+                                                 struct cl_wrs_params *wrs=
_params)
+{
+       /*
+        * Continue normal converge (just like during traffic).
+        * After 6 seconds reset table, and select rate based on RSSI.
+        */
+       if (!wrs_db->converge_idle_en)
+               return;
+
+       wrs_params->converge_time_idle +=3D wrs_db->interval;
+
+       if (wrs_params->converge_mode =3D=3D WRS_CONVERGE_MODE_RESET) {
+               if (wrs_params->converge_time_idle < wrs_db->converge_idle_=
interval_reset) {
+                       cl_wrs_converge_weights(wrs_params);
+               } else {
+                       wrs_params->converge_mode =3D WRS_CONVERGE_MODE_RSS=
I;
+                       wrs_params->converge_time_idle =3D 0;
+
+                       wrs_pr_info(wrs_db, "[WRS] Converge weights: sta %u=
 - RSSI\n",
+                                   wrs_sta->sta_idx);
+
+                       /* Reset table and choose new rate based on RSSI */
+                       cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+
+                       cl_wrs_rssi_set_rate(cl_hw, wrs_db, wrs_sta);
+               }
+       } else {
+               if (wrs_params->converge_time_idle < wrs_db->converge_idle_=
interval_rssi)
+                       return;
+
+               /* Choose new rate based on RSSI */
+               wrs_params->converge_time_idle =3D 0;
+               cl_wrs_rssi_set_rate(cl_hw, wrs_db, wrs_sta);
+       }
+}
+
+static void cl_wrs_converge_weights_idle_reset(struct cl_wrs_db *wrs_db,
+                                              struct cl_wrs_sta *wrs_sta,
+                                              struct cl_wrs_params *wrs_pa=
rams)
+{
+       /* There was traffic in last maintenance interval - reset converge =
parameteres */
+       wrs_params->converge_time_idle =3D 0;
+
+       if (wrs_params->converge_mode !=3D WRS_CONVERGE_MODE_RESET) {
+               wrs_params->converge_mode =3D WRS_CONVERGE_MODE_RESET;
+               wrs_pr_info(wrs_db, "[WRS] Converge weights: sta %u - RESET=
\n",
+                           wrs_sta->sta_idx);
+       }
+}
+
+static void cl_wrs_converge_weights_trfc_decision(struct cl_hw *cl_hw, str=
uct cl_sta *cl_sta,
+                                                 struct cl_wrs_db *wrs_db,
+                                                 struct cl_wrs_params *wrs=
_params)
+{
+       u32 converge_interval =3D 0;
+
+       if (!wrs_db->converge_trfc_en)
+               return;
+
+       if (cl_motion_sense_is_static(cl_hw, cl_sta) && cl_env_det_is_clean=
(cl_hw))
+               converge_interval =3D wrs_db->converge_trfc_interval_static=
;
+       else
+               converge_interval =3D wrs_db->converge_trfc_interval_motion=
;
+
+       wrs_params->converge_time_trfc +=3D wrs_db->interval;
+
+       if (wrs_params->converge_time_trfc >=3D converge_interval) {
+               wrs_params->converge_time_trfc =3D 0;
+               cl_wrs_converge_weights(wrs_params);
+       }
+}
+
+static u32 cl_wrs_get_sync_attempts(struct cl_wrs_sta *wrs_sta, struct cl_=
wrs_params *wrs_params)
+{
+       struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_sta, wrs_=
sta);
+
+       return cl_sta->wrs_info.sync_attempts;
+}
+
+static void cl_wrs_sta_no_sync_handler(struct cl_hw *cl_hw,
+                                      struct cl_wrs_db *wrs_db,
+                                      struct cl_wrs_sta *wrs_sta,
+                                      struct cl_wrs_params *wrs_params)
+{
+       unsigned long time_delta =3D jiffies_to_msecs(jiffies - wrs_params-=
>no_sync_timestamp);
+
+       if (time_delta < wrs_db->sync_timeout)
+               return;
+
+       if (cl_wrs_get_sync_attempts(wrs_sta, wrs_params) < wrs_db->sync_mi=
n_attempts) {
+               /*
+                * Rate not synced but there is also hardly no traffic -
+                * change mode to synced!
+                */
+               wrs_params->sync =3D true;
+               wrs_params->sync_timestamp =3D jiffies;
+       } else {
+               struct cl_wrs_table *wrs_table =3D &wrs_params->table[wrs_p=
arams->rate_idx];
+               struct cl_wrs_rate *curr_rate =3D &wrs_table->rate;
+
+               if (!cl_hw->ate_db.active)
+                       pr_warn("[WRS] NO SYNC - sta =3D %u, bw =3D %u, nss=
 =3D %u, mcs =3D %u, gi =3D %u\n",
+                               wrs_sta->sta_idx, curr_rate->bw, curr_rate-=
>nss,
+                               curr_rate->mcs, curr_rate->gi);
+
+               if (WRS_IS_DECISION_UP(wrs_params->last_decision)) {
+                       cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_pa=
rams,
+                                            WRS_DECISION_DOWN_NO_SYNC,
+                                            wrs_table->rate_down.rate_idx)=
;
+               } else {
+                       /* If the last decision was DOWN - change state to =
SYNCED. */
+                       wrs_params->sync =3D true;
+                       wrs_params->sync_timestamp =3D jiffies;
+               }
+       }
+}
+
+static void cl_wrs_update_ba_not_rcv(struct cl_wrs_db *wrs_db, struct cl_w=
rs_params *wrs_params)
+{
+       unsigned long time_since_sync =3D jiffies_to_msecs(jiffies - wrs_pa=
rams->sync_timestamp);
+
+       wrs_params->calc_ba_not_rcv =3D (wrs_db->ba_not_rcv_force ||
+                                      (time_since_sync < wrs_db->ba_not_rc=
v_time_since_sync));
+}
+
+static void _cl_wrs_tx_cntrs_reset(struct cl_wrs_info *wrs_info)
+{
+       wrs_info->epr_acc =3D 0;
+       wrs_info->tx_success =3D 0;
+       wrs_info->tx_fail =3D 0;
+       wrs_info->ba_not_rcv =3D 0;
+       wrs_info->ba_not_rcv_consecutive_max =3D 0;
+}
+
+static void cl_wrs_tx_cntrs_read(struct cl_wrs_sta *wrs_sta,
+                                struct cl_wrs_tx_cntrs *tx_cntrs)
+{
+       struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_sta, wrs_=
sta);
+       struct cl_wrs_info *wrs_info =3D &cl_sta->wrs_info;
+
+       tx_cntrs->epr_acc =3D wrs_info->epr_acc;
+       tx_cntrs->total =3D wrs_info->tx_success + wrs_info->tx_fail;
+       tx_cntrs->fail =3D wrs_info->tx_fail;
+       tx_cntrs->ba_not_rcv =3D wrs_info->ba_not_rcv;
+       tx_cntrs->ba_not_rcv_consecutive =3D wrs_info->ba_not_rcv_consecuti=
ve_max;
+
+       _cl_wrs_tx_cntrs_reset(wrs_info);
+}
+
+static void _cl_wrs_sta_maintenance(struct cl_hw *cl_hw, struct cl_sta *cl=
_sta,
+                                   struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       struct cl_wrs_tx_cntrs tx_cntrs =3D {0};
+
+       if (!wrs_params->sync) {
+               cl_wrs_sta_no_sync_handler(cl_hw, wrs_db, wrs_sta, wrs_para=
ms);
+               return;
+       }
+
+       cl_wrs_update_ba_not_rcv(wrs_db, wrs_params);
+       cl_wrs_tx_cntrs_read(wrs_sta, &tx_cntrs);
+
+       if (wrs_params->is_fixed_rate) {
+               cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &tx_cn=
trs);
+               return;
+       }
+
+       wrs_params->down_time_cnt +=3D wrs_db->interval;
+       wrs_params->up_same_time_cnt +=3D wrs_db->interval;
+
+       if ((tx_cntrs.total + tx_cntrs.ba_not_rcv) < wrs_db->converge_idle_=
packet_th) {
+               /*
+                * Very few frames were sent in last maintenance interval
+                * Check if weights should be converged
+                */
+               cl_wrs_converge_weights_idle_decision(cl_hw, wrs_db, wrs_st=
a, wrs_params);
+
+               cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &tx_cn=
trs);
+
+               return;
+       }
+
+       /* There was traffic in last maintenance interval - reset converge =
parameteres */
+       cl_wrs_converge_weights_idle_reset(wrs_db, wrs_sta, wrs_params);
+
+       cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &tx_cntrs);
+
+       wrs_params->quick_up_check =3D
+               (tx_cntrs.ba_not_rcv_consecutive >=3D wrs_db->quick_up_ba_t=
hr) ? 1 : 0;
+       cl_wrs_epr_decision(cl_hw, wrs_db, wrs_sta, wrs_params);
+
+       cl_wrs_converge_weights_trfc_decision(cl_hw, cl_sta, wrs_db, wrs_pa=
rams);
+}
+
+static void cl_wrs_sta_maintenance(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta)
+{
+       _cl_wrs_sta_maintenance(cl_hw, cl_sta, &cl_sta->wrs_sta.su_params);
+}
+
+static void cl_wrs_cca_calc(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,=
 u8 max_bw)
+{
+       u32 cca_primary_new =3D mac_hw_edca_cca_busy_get(cl_hw);
+       u32 cca_sec80_new =3D (max_bw > CHNL_BW_80) ? mac_hw_add_cca_busy_s=
ec_80_get(cl_hw) : 0;
+       u32 cca_sec40_new =3D (max_bw > CHNL_BW_40) ? mac_hw_add_cca_busy_s=
ec_40_get(cl_hw) : 0;
+       u32 cca_sec20_new =3D mac_hw_add_cca_busy_sec_20_get(cl_hw);
+
+       u32 cca_primary_diff =3D cca_primary_new - wrs_db->cca_primary;
+       u32 cca_sec80_diff =3D cca_sec80_new - wrs_db->cca_sec80;
+       u32 cca_sec40_diff =3D cca_sec40_new - wrs_db->cca_sec40;
+       u32 cca_sec20_diff =3D cca_sec20_new - wrs_db->cca_sec20;
+
+       wrs_db->cca_primary =3D cca_primary_new;
+       wrs_db->cca_sec80 =3D cca_sec80_new;
+       wrs_db->cca_sec40 =3D cca_sec40_new;
+       wrs_db->cca_sec20 =3D cca_sec20_new;
+       wrs_db->cca_timestamp =3D jiffies;
+
+       /* Increase by 25% */
+       cca_primary_diff =3D cca_primary_diff * WRS_CCA_PRIMARY_FACTOR >> W=
RS_CCA_PRIMARY_SHIFT;
+
+       /* Adjacent interference - if secondary is higher than primary by 2=
5%. */
+       wrs_db->adjacent_interference80 =3D (cca_sec80_diff > cca_primary_d=
iff);
+       wrs_db->adjacent_interference40 =3D (cca_sec40_diff > cca_primary_d=
iff);
+       wrs_db->adjacent_interference20 =3D (cca_sec20_diff > cca_primary_d=
iff);
+}
+
+static void cl_wrs_cca_maintenance(struct cl_hw *cl_hw, struct cl_wrs_db *=
wrs_db)
+{
+       u8 max_bw =3D wrs_db->max_cap.bw;
+
+       if (max_bw =3D=3D CHNL_BW_20)
+               return;
+
+       if (jiffies_to_msecs(jiffies - wrs_db->cca_timestamp) > WRS_CCA_PER=
IOD_MS)
+               cl_wrs_cca_calc(cl_hw, wrs_db, max_bw);
+}
+
+static void cl_wrs_maintenance(unsigned long data)
+{
+       struct cl_hw *cl_hw =3D (struct cl_hw *)data;
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       cl_wrs_cca_maintenance(cl_hw, wrs_db);
+
+       cl_wrs_lock(wrs_db);
+       cl_sta_loop(cl_hw, cl_wrs_sta_maintenance);
+       cl_wrs_unlock(wrs_db);
+}
+
+static void cl_wrs_down_decision_weights_update(struct cl_wrs_db *wrs_db,
+                                               struct cl_wrs_sta *wrs_sta,
+                                               u16 new_rate_idx,
+                                               struct cl_wrs_params *wrs_p=
arams)
+{
+       u16 old_rate_idx =3D wrs_params->rate_idx;
+       u8 up_idx =3D 0;
+       u16 down_th_min =3D wrs_db->time_th_min;
+       u16 step =3D wrs_db->step_down;
+       u16 *th_down =3D &wrs_params->table[old_rate_idx].rate_down.time_th=
;
+       u16 *th_up =3D NULL;
+       struct cl_wrs_table *table_node =3D &wrs_params->table[new_rate_idx=
];
+
+       /* Decrease the weight from old rate to new rate */
+       if (*th_down > (down_th_min + step))
+               *th_down -=3D step;
+       else
+               *th_down =3D down_th_min;
+
+       /* Increase the weight from new rate to old rate */
+       for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+               if (old_rate_idx =3D=3D table_node->rate_up[up_idx].rate_id=
x) {
+                       th_up =3D &table_node->rate_up[up_idx].time_th;
+                       table_node->rate_up[up_idx].quick_up_check =3D !!wr=
s_params->quick_up_check;
+                       step =3D wrs_params->penalty_decision_dn;
+                       *th_up =3D min_t(u16, *th_up + step, wrs_db->time_t=
h_max_up);
+                       break;
+               }
+       }
+
+       wrs_pr_info(wrs_db,
+                   "[WRS] Down update - sta =3D %u, "
+                   "down weight [%u-->%u] =3D %u, up weight [%u-->%u] =3D =
%u\n",
+                   wrs_sta->sta_idx, old_rate_idx, new_rate_idx,
+                   *th_down, new_rate_idx, old_rate_idx, th_up ? *th_up : =
0);
+}
+
+static void cl_wrs_up_same_decision_weights_update(struct cl_wrs_db *wrs_d=
b,
+                                                  struct cl_wrs_sta *wrs_s=
ta,
+                                                  struct cl_wrs_params *wr=
s_params)
+{
+       u16 curr_rate_idx =3D wrs_params->rate_idx;
+       u16 down_rate_idx =3D wrs_params->table[curr_rate_idx].rate_down.ra=
te_idx;
+       u8 up_idx =3D 0;
+       u16 up_th_min =3D wrs_db->time_th_min;
+       u16 step =3D wrs_db->step_up_same;
+       u16 *th_down =3D &wrs_params->table[curr_rate_idx].rate_down.time_t=
h;
+       u16 *th_up =3D NULL;
+       u16 th_down_orig =3D *th_down;
+       u16 th_up_orig =3D 0;
+       struct cl_wrs_table *table_node =3D &wrs_params->table[down_rate_id=
x];
+
+       /* Increase the weight from current rate to down rate */
+       *th_down =3D min_t(u16, *th_down + step, wrs_db->time_th_max_down);
+
+       /* Decrease the weight from down rate to current rate */
+       for (up_idx =3D 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+               if (curr_rate_idx =3D=3D table_node->rate_up[up_idx].rate_i=
dx) {
+                       th_up =3D &table_node->rate_up[up_idx].time_th;
+                       table_node->rate_up[up_idx].quick_up_check =3D fals=
e;
+
+                       th_up_orig =3D *th_up;
+
+                       if (*th_up > (up_th_min + step))
+                               *th_up -=3D step;
+                       else
+                               *th_up =3D up_th_min;
+                       break;
+               }
+       }
+
+       if (th_up && (th_up_orig !=3D *th_up || th_down_orig !=3D *th_down)=
)
+               wrs_pr_info(wrs_db,
+                           "[WRS] Up/same update - sta =3D %u, "
+                           "down weight [%u-->%u] =3D %u, up weight [%u-->=
%u] =3D %u\n",
+                           wrs_sta->sta_idx, curr_rate_idx,
+                           down_rate_idx, *th_down, down_rate_idx, curr_ra=
te_idx, *th_up);
+}
+
+void cl_wrs_init(struct cl_hw *cl_hw)
+{
+       struct cl_wrs_db *wrs_db =3D &cl_hw->wrs_db;
+
+       /* Default configuration */
+       wrs_db->debug_level =3D DBG_LVL_ERROR;
+       wrs_db->rssi_protect_en =3D true;
+       wrs_db->rssi_protect_mode =3D WRS_RSSI_PROT_MODE_RSSI;
+       wrs_db->rssi_protect_up_thr =3D WRS_RSSI_PROTECT_UP_THR;
+       wrs_db->rssi_protect_dn_thr =3D WRS_RSSI_PROTECT_DN_THR;
+       wrs_db->min_frames_for_decision =3D WRS_MIN_FRAMES_FOR_DECISION;
+       wrs_db->epr_factor =3D WRS_EPR_FACTOR;
+       wrs_db->converge_idle_en =3D true;
+       wrs_db->converge_idle_interval_reset =3D WRS_CONVERGE_IDLE_INTERVAL=
_RESET;
+       wrs_db->converge_idle_interval_rssi =3D WRS_CONVERGE_IDLE_INTERVAL_=
RSSI;
+       wrs_db->converge_idle_packet_th =3D WRS_CONVERGE_IDLE_PACKET_TH;
+       wrs_db->converge_trfc_en =3D true;
+       wrs_db->converge_trfc_interval_static =3D WRS_CONVERGE_TRFC_INTERVA=
L_STATIC;
+       wrs_db->converge_trfc_interval_motion =3D WRS_CONVERGE_TRFC_INTERVA=
L_MOTION;
+       wrs_db->immediate_drop_en =3D true;
+       wrs_db->immediate_drop_epr_factor =3D WRS_IMMEDIATE_DROP_EPR_FACTOR=
;
+       wrs_db->immediate_drop_max_in_row =3D WRS_IMMEDIATE_DROP_MAX_IN_ROW=
;
+       wrs_db->time_th_min =3D WRS_MSEC_WEIGHT_MIN;
+       wrs_db->time_th_max_up =3D WRS_MSEC_WEIGHT_MAX_UP;
+       wrs_db->time_th_max_down =3D WRS_MSEC_WEIGHT_MAX_DOWN;
+       wrs_db->step_down =3D WRS_MSEC_STEP_DOWN;
+       wrs_db->step_up_same =3D WRS_MSEC_STEP_UP_SAME;
+       wrs_db->interval =3D msecs_round(WRS_MAINTENANCE_PERIOD_MS);
+       wrs_db->conservative_mcs_noisy_env =3D false;
+       wrs_db->conservative_nss_noisy_env =3D false;
+       wrs_db->quick_up_en =3D true;
+       wrs_db->quick_up_ba_thr =3D WRS_QUICK_UP_BA_THR;
+       wrs_db->quick_up_interval =3D msecs_round(WRS_QUICK_UP_INTERVAL_MS)=
;
+       wrs_db->quick_down_en =3D true;
+       wrs_db->quick_down_epr_factor =3D WRS_QUICK_DOWN_EPR_FACTOR;
+       wrs_db->quick_down_agg_thr =3D WRS_QUICK_DOWN_AGG_THR;
+       wrs_db->quick_down_pkt_thr =3D WRS_QUICK_DOWN_PKT_THR;
+       wrs_db->ba_not_rcv_collision_filter =3D true;
+       /* Environment of 2.4 is much more noisy, so 'BA not received' are =
ignored. */
+       wrs_db->ba_not_rcv_force =3D cl_band_is_24g(cl_hw) ? false : true;
+       wrs_db->ba_not_rcv_time_since_sync =3D WRS_BA_NOT_RCV_TIME_SINCE_SY=
NC;
+       wrs_db->sync_timeout =3D WRS_SYNC_TIMEOUT;
+       wrs_db->sync_min_attempts =3D WRS_SYNC_MIN_ATTEMPTS;
+
+       /* Init WRS periodic timer */
+       cl_timer_init(&wrs_db->timer_maintenance,
+                     cl_wrs_maintenance,
+                     (unsigned long)cl_hw,
+                     wrs_db->interval, true);
+
+       if (!cl_hw->chip->conf->ce_production_mode) {
+               wrs_db->cca_timestamp =3D jiffies;
+               cl_timer_enable(&wrs_db->timer_maintenance);
+       }
+
+       spin_lock_init(&wrs_db->lock);
+
+       if ((cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_MODE] !=3D -1) =
&&
+           (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_BW] !=3D -1) &&
+           (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_NSS] !=3D -1) &=
&
+           (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_MCS] !=3D -1) &=
&
+           (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_GI] !=3D -1))
+               wrs_db->is_fixed_rate =3D WRS_FIXED_FALLBACK_DIS;
+}
+
+inline void cl_wrs_lock_bh(struct cl_wrs_db *wrs_db)
+{
+       spin_lock_bh(&wrs_db->lock);
+}
+
+inline void cl_wrs_unlock_bh(struct cl_wrs_db *wrs_db)
+{
+       spin_unlock_bh(&wrs_db->lock);
+}
+
+inline void cl_wrs_lock(struct cl_wrs_db *wrs_db)
+{
+       spin_lock(&wrs_db->lock);
+}
+
+inline void cl_wrs_unlock(struct cl_wrs_db *wrs_db)
+{
+       spin_unlock(&wrs_db->lock);
+}
+
+void cl_wrs_tx_param_sync(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs=
_sta,
+                         struct cl_wrs_params *wrs_params)
+{
+       if (wrs_params->sync)
+               return;
+
+       /* Reset the tx Counters */
+       cl_wrs_tx_cntrs_reset(wrs_sta, wrs_params);
+
+       /* Reset counters */
+       cl_wrs_reset_params_cntrs(wrs_params);
+
+       /* Change state to SYNCED */
+       wrs_params->sync =3D true;
+       wrs_params->sync_timestamp =3D jiffies;
+
+       wrs_pr_trace(wrs_db, "[WRS] Sync - timestamp =3D %u, sta =3D %u, ra=
te_idx =3D %u\n",
+                    jiffies_to_msecs(jiffies),
+                    wrs_sta->sta_idx,
+                    wrs_params->rate_idx);
+}
+
+void cl_wrs_tx_params_update(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db=
,
+                            struct cl_wrs_sta *wrs_sta, struct cl_wrs_para=
ms *wrs_params,
+                            u16 new_rate_idx, bool is_sync_required)
+{
+       struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_sta, wrs_=
sta);
+       struct cl_wrs_tx_params *tx_params =3D &wrs_params->tx_params;
+       struct cl_wrs_rate *rate =3D &wrs_params->table[new_rate_idx].rate;
+       u16 fallback_rate_idx =3D wrs_params->table[new_rate_idx].rate_down=
.rate_idx;
+       struct cl_wrs_rate *rate_fallback =3D &wrs_params->table[fallback_r=
ate_idx].rate;
+
+       cl_dyn_bcast_rate_change(cl_hw, cl_sta, tx_params->mcs, rate->mcs);
+
+       tx_params->bw =3D rate->bw;
+       tx_params->nss =3D rate->nss;
+       tx_params->mcs =3D rate->mcs;
+       tx_params->gi =3D rate->gi;
+       tx_params->mode =3D wrs_sta->mode;
+       tx_params->fallback_en =3D (wrs_params->is_fixed_rate !=3D WRS_FIXE=
D_FALLBACK_DIS);
+
+       wrs_pr_trace(wrs_db,
+                    "[WRS] Tx params update - "
+                    "sta =3D %u, rate_idx =3D %u, bw =3D %u, nss =3D %u, m=
cs =3D %u, gi =3D %u\n",
+                    wrs_sta->sta_idx, new_rate_idx, tx_params->bw,
+                    tx_params->nss, tx_params->mcs, tx_params->gi);
+
+       wrs_params->rate_idx =3D new_rate_idx;
+
+       /* Converge - restart the time for converging weights of all old ra=
tes */
+       wrs_params->converge_time_trfc =3D 0;
+
+       cl_wrs_tx_param_set(cl_hw, wrs_sta, wrs_params, tx_params, rate_fal=
lback);
+
+       if (is_sync_required) {
+               wrs_params->sync =3D false;
+               wrs_params->no_sync_timestamp =3D jiffies;
+       } else {
+               wrs_params->sync =3D true;
+       }
+
+       /* Reset Counters */
+       cl_wrs_reset_params_cntrs(wrs_params);
+}
+
+void cl_wrs_decision_make(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                         struct cl_wrs_sta *wrs_sta, struct cl_wrs_params =
*wrs_params,
+                         enum cl_wrs_decision decision, u16 new_rate_idx)
+{
+       if (WRS_IS_DECISION_DOWN(decision)) {
+               cl_wrs_down_decision_weights_update(wrs_db, wrs_sta, new_ra=
te_idx, wrs_params);
+       } else if (WRS_IS_DECISION_UP(decision)) {
+               cl_wrs_up_same_decision_weights_update(wrs_db, wrs_sta, wrs=
_params);
+
+               if (wrs_params->rate_idx !=3D wrs_params->table[new_rate_id=
x].rate_down.rate_idx) {
+                       /*
+                        * In case the down rate is different from the prev=
ious rate,
+                        * update down rate index and reset the thresholds
+                        */
+                       struct cl_wrs_table_node *rate_down =3D
+                               &wrs_params->table[new_rate_idx].rate_down;
+
+                       rate_down->rate_idx =3D wrs_params->rate_idx;
+                       rate_down->time_th =3D WRS_INIT_MSEC_WEIGHT_DOWN;
+               }
+       } else if (decision =3D=3D WRS_DECISION_SAME) {
+               cl_wrs_up_same_decision_weights_update(wrs_db, wrs_sta, wrs=
_params);
+
+               /* Reset counters besides down_time_cnt */
+               wrs_params->frames_total =3D 0;
+               wrs_params->fail_total =3D 0;
+               wrs_params->ba_not_rcv_total =3D 0;
+               wrs_params->epr_acc =3D 0;
+               wrs_params->up_same_time_cnt =3D 0;
+       }
+
+       cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params, decision, new_r=
ate_idx);
+
+       if (WRS_IS_DECISION_DOWN(decision) || WRS_IS_DECISION_UP(decision))
+               cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                       new_rate_idx, true);
+}
+
+void cl_wrs_decision_update(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *w=
rs_sta,
+                           struct cl_wrs_params *wrs_params, enum cl_wrs_d=
ecision decision,
+                           u16 new_rate_idx)
+{
+       wrs_params->last_decision =3D decision;
+       wrs_params->decision_cnt[decision]++;
+
+       if (decision !=3D WRS_DECISION_DOWN_IMMEDIATE)
+               wrs_params->immediate_drop_cntr =3D 0;
+
+       if (decision =3D=3D WRS_DECISION_SAME)
+               return;
+
+       wrs_pr_trace(wrs_db,
+                    "[WRS] Decision update - timestamp [%u] sta [%u] decis=
ion [%s]\n",
+                    jiffies_to_msecs(jiffies),
+                    wrs_sta->sta_idx,
+                    WRS_DECISION_STR(decision));
+}
+
+void cl_wrs_fixed_rate_set(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                          struct cl_wrs_sta *wrs_sta, struct cl_wrs_params=
 *wrs_params,
+                          u8 is_fixed_rate, u8 mode, u8 bw, u8 nss, u8 mcs=
, u8 gi)
+{
+       u16 rate_idx =3D 0;
+
+       if (!is_fixed_rate) {
+               wrs_params->is_fixed_rate =3D WRS_AUTO_RATE;
+               wrs_pr_verbose(wrs_db, "[WRS] Station %u was set to auto ra=
te!\n",
+                              wrs_sta->sta_idx);
+               cl_wrs_rssi_set_rate(cl_hw, wrs_db, wrs_sta);
+               return;
+       }
+
+       if (mode !=3D wrs_sta->mode) {
+               /* Set fixed rate with a different format-mode */
+               struct cl_wrs_tx_params *tx_params =3D &wrs_params->tx_para=
ms;
+               struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_s=
ta, wrs_sta);
+
+               if (cl_band_is_6g(cl_hw) && mode !=3D WRS_MODE_HE) {
+                       wrs_pr_verbose(wrs_db, "[WRS] Invalid format mode [=
%u] for 6GHz band\n",
+                                      mode);
+                       return;
+               }
+
+               cl_dyn_bcast_rate_change(cl_hw, cl_sta, tx_params->mcs, mcs=
);
+
+               tx_params->bw =3D bw;
+               tx_params->nss =3D nss;
+               tx_params->mcs =3D mcs;
+               tx_params->gi =3D gi;
+               tx_params->mode =3D mode;
+               tx_params->fallback_en =3D (wrs_params->is_fixed_rate !=3D =
WRS_FIXED_FALLBACK_DIS);
+
+               wrs_params->is_fixed_rate =3D is_fixed_rate;
+
+               cl_wrs_tx_param_set(cl_hw, wrs_sta, wrs_params, tx_params, =
NULL);
+               wrs_pr_verbose(wrs_db,
+                              "[WRS] Station %u set to %s - "
+                              "mode=3D%u, bw=3D%u, nss=3D%u, mcs=3D%u, gi=
=3D%u\n",
+                              wrs_sta->sta_idx, FIXED_RATE_STR(is_fixed_ra=
te),
+                              mode, bw, nss, mcs, gi);
+               return;
+       }
+
+       rate_idx =3D cl_wrs_tables_find_rate_idx(wrs_params, bw, nss, mcs, =
gi);
+
+       if (rate_idx =3D=3D WRS_INVALID_RATE) {
+               wrs_pr_err(wrs_db,
+                          "[WRS] Invalid fixed rate - mode=3D%u, bw=3D%u, =
nss=3D%u, mcs=3D%u, gi=3D%u\n",
+                          mode, bw, nss, mcs, gi);
+               return;
+       }
+
+       wrs_params->is_fixed_rate =3D is_fixed_rate;
+       cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta, wrs_params, rate_id=
x, false);
+       wrs_pr_verbose(wrs_db,
+                      "[WRS] Station %u set to %s - mode=3D%u, bw=3D%u, ns=
s=3D%u, mcs=3D%u, gi=3D%u\n",
+                       wrs_sta->sta_idx, FIXED_RATE_STR(is_fixed_rate),
+                       mode, bw, nss, mcs, gi);
+}
+
+void cl_wrs_quick_down_check(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db=
,
+                            struct cl_wrs_sta *wrs_sta, struct cl_wrs_para=
ms *wrs_params)
+{
+       struct cl_wrs_tx_cntrs tx_cntrs =3D {0};
+       struct cl_wrs_table *table =3D NULL;
+       u16 curr_rate_idx =3D 0;
+       u16 down_rate_idx =3D 0;
+
+       if (!wrs_params->sync ||
+           wrs_params->is_fixed_rate ||
+           !WRS_IS_DECISION_UP(wrs_params->last_decision))
+               return;
+
+       cl_wrs_update_ba_not_rcv(wrs_db, wrs_params);
+       cl_wrs_tx_cntrs_read(wrs_sta, &tx_cntrs);
+       cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &tx_cntrs);
+
+       curr_rate_idx =3D wrs_params->rate_idx;
+       table =3D &wrs_params->table[curr_rate_idx];
+       down_rate_idx =3D table->rate_down.rate_idx;
+
+       /* Check if we transmitted enough frames for taking decision */
+       if (wrs_params->frames_total < wrs_db->min_frames_for_decision)
+               return;
+
+       /* Down decision check */
+       if (down_rate_idx !=3D curr_rate_idx &&
+           cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+                                 wrs_db->quick_down_epr_factor, WRS_DECISI=
ON_DOWN_QUICK))
+               cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                    WRS_DECISION_DOWN_QUICK, down_rate_idx=
);
+}
+
+bool cl_wrs_up_mcs1(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                   struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_p=
arams)
+{
+       /*
+        * In case of big packets (4300 in VHT and 5400 in HE) and low
+        * rate (BW 20, NSS 1, MCS 0), firmware will increase rate to MCS 1=
,
+        * and give an indication to driver (set rate_fix_mcs1 in cl_agg_tx=
_report).
+        * WRS should also move to MCS 1, and give the maximum time
+        * penalty time from MCS 0 toMCS 1.
+        */
+       u16 curr_rate_idx =3D wrs_params->rate_idx;
+       u16 up_rate_idx =3D 0;
+       struct cl_wrs_table *table =3D &wrs_params->table[curr_rate_idx];
+
+       if (!table || wrs_params->is_fixed_rate)
+               return false;
+
+       if (table->rate.bw !=3D CHNL_BW_20 ||
+           table->rate.nss !=3D WRS_SS_1 ||
+           table->rate.mcs !=3D WRS_MCS_0)
+               return false;
+
+       up_rate_idx =3D cl_wrs_tables_find_rate_idx(wrs_params,
+                                                 CHNL_BW_20, WRS_SS_1, WRS=
_MCS_1, table->rate.gi);
+
+       if (up_rate_idx =3D=3D WRS_INVALID_RATE)
+               return false;
+
+       wrs_params->table[up_rate_idx].rate_down.time_th =3D wrs_db->time_t=
h_max_up;
+
+       cl_wrs_tx_cntrs_reset(wrs_sta, wrs_params);
+       cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params, WRS_DECISION_UP=
_MCS1, up_rate_idx);
+       cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+                               up_rate_idx, true);
+
+       return true;
+}
+
+void cl_wrs_tx_param_set(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+                        struct cl_wrs_params *wrs_params,
+                        struct cl_wrs_tx_params *tx_params,
+                        struct cl_wrs_rate *rate_fallback)
+{
+       struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_sta, wrs_=
sta);
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+       struct cl_wrs_info *wrs_info =3D NULL;
+       u8 ltf =3D 0;
+       u8 ltf_fallback =3D 0;
+       u8 sta_idx =3D cl_sta->sta_idx;
+       union cl_rate_ctrl_info rate_ctrl;
+       union cl_rate_ctrl_info rate_ctrl_fallback;
+       union cl_rate_ctrl_info_he rate_ctrl_he;
+
+       if (cl_hw->ate_db.active)
+               return;
+
+       rate_ctrl_he.word =3D 0;
+
+       wrs_info =3D &cl_sta->wrs_info;
+
+       wrs_params->data_rate =3D cl_data_rates_get(tx_params->mode,
+                                                 tx_params->bw,
+                                                 tx_params->nss,
+                                                 tx_params->mcs,
+                                                 tx_params->gi);
+
+       rate_ctrl.word =3D cl_rate_ctrl_generate(cl_hw, cl_sta, tx_params->=
mode,
+                                              tx_params->bw, tx_params->ns=
s,
+                                              tx_params->mcs, tx_params->g=
i,
+                                              tx_params->fallback_en);
+
+       /* For fallback rate use same mode (if it is NULL use same rate). *=
/
+       if (rate_fallback) {
+               rate_ctrl_fallback.word =3D cl_rate_ctrl_generate(cl_hw,
+                                                               cl_sta,
+                                                               tx_params->=
mode,
+                                                               rate_fallba=
ck->bw,
+                                                               rate_fallba=
ck->nss,
+                                                               rate_fallba=
ck->mcs,
+                                                               rate_fallba=
ck->gi,
+                                                               tx_params->=
fallback_en);
+               ltf_fallback =3D cl_map_gi_to_ltf(tx_params->mode, rate_fal=
lback->gi);
+       } else {
+               rate_ctrl_fallback.word =3D rate_ctrl.word;
+       }
+
+       /* Save current BF state and SS for the fallback rate */
+       bf_db->is_on =3D rate_ctrl.field.tx_bf;
+       bf_db->is_on_fallback =3D rate_ctrl_fallback.field.tx_bf;
+       bf_db->num_ss =3D tx_params->nss;
+       bf_db->num_ss_fallback =3D rate_fallback ? rate_fallback->nss : tx_=
params->nss;
+
+       /* Reset counters */
+       wrs_info->tx_success =3D 0;
+       wrs_info->tx_fail =3D 0;
+
+       /* Mark rate as unsynced */
+       wrs_info->synced =3D false;
+       wrs_info->quick_rate_check =3D false;
+       wrs_info->sync_attempts =3D 0;
+
+       ltf =3D cl_map_gi_to_ltf(tx_params->mode, tx_params->gi);
+
+       if (tx_params->mode =3D=3D WRS_MODE_HE)
+               rate_ctrl_he.field.spatial_conf =3D RATE_CNTRL_HE_SPATIAL_C=
ONF_DEF;
+
+       /* Send new rate to firmware */
+       cl_msg_tx_update_rate_dl(cl_hw, sta_idx, rate_ctrl.word,
+                                rate_ctrl_fallback.word, tx_params->bw,
+                                RATE_OP_MODE_STA_SU,
+                                ltf, ltf_fallback, rate_ctrl_he.word);
+
+       /*
+        * TODO: Limit by SU/TX if active function will take control
+        *       over MU-SU/TX-RX.
+        */
+       cl_rsrc_mgmt_rates_update(cl_hw, cl_sta);
+}
+
+s8 cl_wrs_rssi_eq_calc(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+                      bool read_clear, s8 *sorted_rssi)
+{
+       struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_sta, wrs_=
sta);
+       struct cl_wrs_rssi *wrs_rssi =3D &cl_sta->wrs_rssi;
+       int i;
+
+       if (wrs_rssi->cnt =3D=3D 0) {
+               memcpy(sorted_rssi, cl_sta->last_rssi, cl_hw->num_antennas)=
;
+               goto sort;
+       }
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++)
+               sorted_rssi[i] =3D (s8)(wrs_rssi->sum[i] / wrs_rssi->cnt);
+
+       if (read_clear)
+               memset(wrs_rssi, 0, sizeof(struct cl_wrs_rssi));
+
+sort:
+       /* Sort RSSI values in descending order */
+       cl_rssi_sort_descending(sorted_rssi, cl_hw->num_antennas);
+
+       /* Calc equivalent RSSI */
+       return cl_rssi_calc_equivalent(cl_hw, sorted_rssi);
+}
+
+void cl_wrs_tx_cntrs_reset(struct cl_wrs_sta *wrs_sta, struct cl_wrs_param=
s *wrs_params)
+{
+       struct cl_sta *cl_sta =3D container_of(wrs_sta, struct cl_sta, wrs_=
sta);
+       struct cl_wrs_info *wrs_info =3D &cl_sta->wrs_info;
+
+       _cl_wrs_tx_cntrs_reset(wrs_info);
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

