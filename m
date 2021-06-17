Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1E53AB85F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhFQQH0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:26 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:6112
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231133AbhFQQG7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKuchYDaxjrPJF5dbESrZTk7njcK4MdLqFhWL5qH8BowLKuOMejSVMwAb8gS83Pg3A6znRx0UBqSsn6CESm/6BBw46mXA8CjMGUjIoC/P5VdOcmXLLDMGjKoz1le6jWv75gn1AvPsVxKMmrxFEUkd7D02ccilU3OEhMA4GgA7NQl5sSOAhrSILAPtBiR9LC40FeizTRY+H7CPOJLNLi8Iz5C8xPNlURh4IsnFfIBzk6TJnDItboV6mJj07lXMCJMFyWEMDg7YQ3P5aM1v5LWi+MyWSFegBBEYvGEr0ehFZD7lJeT5pWOntC1qviFqAmtg+QfRr/d0d+LJFiHns+quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1Wm72r7TOFlT0y2t/cX6QKpu1felnDCOP+f7qhTqvY=;
 b=m+hn7zbGZZ6t+J6yQQsWPSIUu8WL3Xrygb+ULzuxoj2ZSjMzeNg9U1RdGOgjZpslSo0skciRedcNwDp+QWpNKPA6FIftsnWvfjL8v4se8mKz7dNmXXOEng9m7NnRVOKCSyWRSUAd3OsRkjXzsRb1WG5uEgvq15ZBdYfPzNPsicda+SeX7xR1qg5g91Giedz/yFPu3Uc2JYCyxgSYfUpEAulFGCgviftJqNWSYHLkxxdwAhGPW3AAeGNc4jh5KdFwrlhX3kRkzclyP5nzvG3rGFLMxiPr1wpKEmxhgdACPvhXV+Eq3LBmU3Ga9y9m3duVthR6yRK9frY0YpnehyIDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1Wm72r7TOFlT0y2t/cX6QKpu1felnDCOP+f7qhTqvY=;
 b=NVenFDKyxJk//vZGA7AdZYWhSTxN0PNJrK0yZvxieRVTNijn3kxD+NaclUwWVZSwej3jAaNTPexwhKvn6JzNrRHnHlFwp1zqRJ4IPGMvwB+GgS1x2YdAwHtInRQcNsCEghisksLembPhyNuB7sbztpuBPTfkLc/2EDZKJOCY/oM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:04:25 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:25 +0000
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
Subject: [RFC v1 077/256] cl8k: add ext/dyn_bcast_rate.c
Date:   Thu, 17 Jun 2021 15:59:24 +0000
Message-Id: <20210617160223.160998-78-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c968442b-c2da-436f-cc6f-08d931a983f2
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871AB40C73E2F12A3BC12E8F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1pIa4g038KZsFzj+OqjNVMjn8QO7SD4xAzsGqxJ/AahNbMGWXt6frfFGR6RkmyYePcYuSm8nJGxn+bTHl5n+SoNi8qy5mQXBjd3P6y5Vwn//2n8E/01kmX4de6dX1gcyR00d59xHMpO1cnotiP7HnUNO8FO7kWFURhlEv/aQQaosv0JZ4aoN5LsUjiJxD1NAlNp4lGs9aj7SMlKHnjQgsd4jQ6/f1VaTEpp1cWvah/41SDzasdqkB3BKOEVbsY84JzlzzTaSAp0KQuZWZGwdt1WRCVsu+rtLXIvgAS3hcmUSehHxtP/vgz6sSR34AMEKwuIqrQUm+TolcoKnIhPqTyIlUx1+mdUBh9WKfSkP+EPR6svleq4e1i5ntS8beF3N3F3O9fA9OdE02ZAdOHtn66lnt42Y/iAXWrzulTSCEu0hoAVMvzVXd19oTYcAcYUeBYyoM+yAmqM90lrrKrCz4ijP10HF64mr0sU/H1w2qJvUQsTknLBcQd3ZEJObKxz4DgYwB/1fPt8waaR/Wu/C2xKfG+8+esJStIRn3QGgX5T6ZGLjAJJpmhGxwvZh5hNquusXaLhRn9JM7+HgORroUXS49oosDd81ifzvxjlUfDMLx0NntvNlVnvJQH/olNYGQSEWnD4QYBpAut207YBJV1zW66/NAnJMp4Lbkau0HFyHth+BiQOIC0+vcPAzUcVRhqbCQ7LUXv/RcUqoen1xA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wDkIlG2KnzyQeRdGs4Eay48SlmuUM6/aJTrWZMDsbtnSN4z9+uBEq0cOkOo9?=
 =?us-ascii?Q?s2BXVdNgywZR61DB6f/gz5xuiFxA/1dNbj3lpxjy6ic5WZAAooiaRVUNThWT?=
 =?us-ascii?Q?Mvs1bKmqpBZDQhuVlGFeyKAeVjqgfj5VMFSf8PaAzkQdEpT0Kn36iPeWsO47?=
 =?us-ascii?Q?BoFAPVGG40L81E9RZPpyRS1aW/7EGWxAIzvmq46Rn1Gal1E3+9YXYmtDohBi?=
 =?us-ascii?Q?uQtYCn+qhlsojzIJK6F4tBU+a935ZNV90nQ1mQeqsNzFrnGoYZ9XiNMDiDrG?=
 =?us-ascii?Q?Qb1wf6lllFgHJ/ei/eo5rlj0RpPNxSJ9wN3Hg1SpzRneVPQ2+R840UP+ZcFS?=
 =?us-ascii?Q?tchaF08DeOIV6XN33NgvMs86tgX9h3ZjE0ujavUPSfgRjnSZ/QyLGGVrQPYO?=
 =?us-ascii?Q?XMUOsemRF4OjV0FzTnxvno2JzCeDiHaUdE3VWvkrx8WVkc0i9uTAYk0Fu9/3?=
 =?us-ascii?Q?IS5LHsw+s7XWVhrowF+PyzzZHh7d7gouJ7LhyGPPrbVKZP1ZvE4X1d3AFzca?=
 =?us-ascii?Q?lxdyOsW2LT2gBeKz2pNc47YAUGkDNbAv7Nilj03Wj2eKyq1qvzNfAnQ0NRR7?=
 =?us-ascii?Q?TDF0oSUH66Uw85QzzktdgL58DuaL8y0dhjAqZWsoJzXEzGt2485gKzk2aa2H?=
 =?us-ascii?Q?sL/dhYAqWjiihbEqxij8e9Sc8faE1bGuzEhOlRweAijCMmfZYbTWnpbAPJfF?=
 =?us-ascii?Q?LJf0QUiHGVMBZPk8pItxd2rPx69t2IoQAoBx/np1AgYhmj2oQ9znMsIoe8l5?=
 =?us-ascii?Q?nnG5+CYRLkAKOFLxPJyhRCqrkP3nTNPLK2wnu+gVq3+uIurCTgPPZnS3Kotg?=
 =?us-ascii?Q?gEXxytTxYOjJuhGBOVHZmlaAx2Jp7KZyp1+n1aZg8dO5tQ+pZuy8qx1LYs5o?=
 =?us-ascii?Q?vPV0nvcgEgCOGtjPfLBw1DXicOqLIGNldKYDP/N8ZbjjcRc9IvxgyEA6cUxj?=
 =?us-ascii?Q?ZEbgkATZNFytkJx89CVbofyDSylYVKRSMmwfxYE4AxBTlO6kxyKTjRiFTia0?=
 =?us-ascii?Q?HoUp4LVi+IDMc450NVR2HsZPg0S6O65+A/g8deV5U8v6dhm8MKIJFVnoJbY0?=
 =?us-ascii?Q?fs1WH6f7OqEy+DzsPDJkIpZ7rsNXEAnpZPE/rE2F36vSUUenu/rZT/j1AuDs?=
 =?us-ascii?Q?7U+YuGlgL4fX+bXq2kIyMG4nEt7ZV1oqJxuHqgHXY1+oZvLrTjFGkGrH1D7f?=
 =?us-ascii?Q?4vkV6BkrLaT22UfbMhGRvtBYNVxYAtLnDDMBSfpaq1gwMqlZfmWjJrky+p90?=
 =?us-ascii?Q?TQ2Rq8iufDJBjDKwQNrDmxF1mlZA/4fuDn9JeXbnFRqMqnLJaOfqD9NTxlj5?=
 =?us-ascii?Q?H2bp974bYCPjvg+qU6PF5/bN?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c968442b-c2da-436f-cc6f-08d931a983f2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:58.3951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y9M9E92GglNMzzoZ915GIoIqPipdWwGTPfS0dVNyLfgWsJ7tRr1qOd+v1D9/OwD76qJESV/YyabRgVY2YPDl5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/ext/dyn_bcast_rate.c | 182 ++++++++++++++++++
 1 file changed, 182 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.c

diff --git a/drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.c b/driver=
s/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.c
new file mode 100644
index 000000000000..434ed433b90f
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ext/dyn_bcast_rate.c
@@ -0,0 +1,182 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "ext/dyn_bcast_rate.h"
+#include "band.h"
+#include "sta.h"
+#include "rate_ctrl.h"
+#include "fw/msg_tx.h"
+#include "utils/utils.h"
+#include "data_rates.h"
+
+/*
+ * MIN_MCS | BCAST_MCS
+ * -------------------
+ * 0 - 1   | 0
+ * 2 - 3   | 1
+ * 4 - 5   | 2
+ * 6 - 7   | 3
+ * 8 - 9   | 4
+ * 10 - 11 | 5
+ */
+
+static u8 conv_min_mcs_to_bcast_mcs[WRS_MCS_MAX] =3D {
+       0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5
+};
+
+static void cl_dyn_bcast_rate_update(struct cl_hw *cl_hw, u8 min_mcs)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+       u8 bcast_mcs =3D conv_min_mcs_to_bcast_mcs[min_mcs];
+
+       dyn_bcast_rate->sta_min_mcs =3D min_mcs;
+
+       if (bcast_mcs !=3D dyn_bcast_rate->bcast_mcs)
+               cl_dyn_bcast_rate_set(cl_hw, bcast_mcs);
+}
+
+void cl_dyn_bcast_rate_init(struct cl_hw *cl_hw)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+
+       dyn_bcast_rate->sta_min_mcs =3D 0;
+       dyn_bcast_rate->bcast_mcs =3D conv_min_mcs_to_bcast_mcs[0];
+
+       if (cl_band_is_6g(cl_hw)) {
+               dyn_bcast_rate->wrs_mode =3D WRS_MODE_HE;
+               dyn_bcast_rate->ltf =3D LTF_X4;
+       } else if (cl_band_is_24g(cl_hw) && cl_hw_mode_is_b_or_bg(cl_hw)) {
+               dyn_bcast_rate->wrs_mode =3D WRS_MODE_CCK;
+               dyn_bcast_rate->ltf =3D 0;
+       } else {
+               dyn_bcast_rate->wrs_mode =3D WRS_MODE_OFDM;
+               dyn_bcast_rate->ltf =3D 0;
+       }
+}
+
+void cl_dyn_bcast_rate_set(struct cl_hw *cl_hw, u8 bcast_mcs)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+       u8 wrs_mode =3D dyn_bcast_rate->wrs_mode;
+       u8 ltf =3D dyn_bcast_rate->ltf;
+       u32 rate_ctrl;
+
+       cl_hw->dyn_bcast_rate.bcast_mcs =3D bcast_mcs;
+
+       rate_ctrl =3D cl_rate_ctrl_generate(cl_hw, NULL, wrs_mode, 0, 0, bc=
ast_mcs,
+                                         0, false);
+       cl_msg_tx_update_rate_dl(cl_hw, U8_MAX, rate_ctrl, 0, 0,
+                                RATE_OP_MODE_BCAST, ltf, 0, 0);
+
+       cl_dbg_info(cl_hw, "Broadcast MCS set to %u\n", bcast_mcs);
+}
+
+u16 cl_dyn_bcast_rate_get(struct cl_hw *cl_hw)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+
+       return cl_data_rates_get(dyn_bcast_rate->wrs_mode, 0, 0, dyn_bcast_=
rate->bcast_mcs, 0);
+}
+
+void cl_dyn_bcast_rate_recovery(struct cl_hw *cl_hw)
+{
+       cl_dyn_bcast_rate_set(cl_hw, cl_hw->dyn_bcast_rate.bcast_mcs);
+}
+
+void cl_dyn_bcast_rate_change(struct cl_hw *cl_hw, struct cl_sta *cl_sta_c=
hange,
+                             u8 old_mcs, u8 new_mcs)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+       struct cl_sta *cl_sta =3D NULL;
+       u8 min_mcs =3D WRS_MCS_MAX - 1;
+       u8 sta_mcs =3D 0;
+
+       if (!cl_hw->conf->ce_dyn_bcast_rate_en)
+               return;
+
+       if (!cl_sta_change->add_complete)
+               return;
+
+       /* Single station */
+       if (cl_sta_num_bh(cl_hw) =3D=3D 1) {
+               cl_dyn_bcast_rate_update(cl_hw, new_mcs);
+               return;
+       }
+
+       /*
+        * If this station did not have the minimum mcs,
+        * and the new rate is now below the minimum mcs there is nothing t=
o do
+        */
+       if (old_mcs > dyn_bcast_rate->sta_min_mcs &&
+           new_mcs > dyn_bcast_rate->sta_min_mcs)
+               return;
+
+       /* Multi station - find new minimum MCS of all stations */
+       cl_sta_lock_bh(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               sta_mcs =3D (cl_sta->sta_idx =3D=3D cl_sta_change->sta_idx)=
 ?
+                       new_mcs : cl_sta->wrs_sta.su_params.tx_params.mcs;
+
+               if (sta_mcs < min_mcs) {
+                       min_mcs =3D sta_mcs;
+
+                       if (min_mcs =3D=3D 0)
+                               break;
+               }
+       }
+
+       cl_sta_unlock_bh(cl_hw);
+
+       cl_dyn_bcast_rate_update(cl_hw, min_mcs);
+}
+
+void cl_dyn_bcast_rate_update_upon_assoc(struct cl_hw *cl_hw, u8 mcs, u8 n=
um_sta)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+
+       if (!cl_hw->conf->ce_dyn_bcast_rate_en)
+               return;
+
+       if (num_sta =3D=3D 1 || mcs < dyn_bcast_rate->sta_min_mcs)
+               cl_dyn_bcast_rate_update(cl_hw, mcs);
+}
+
+void cl_dyn_bcast_rate_update_upon_disassoc(struct cl_hw *cl_hw, u8 mcs, u=
8 num_sta)
+{
+       struct cl_dyn_bcast_rate *dyn_bcast_rate =3D &cl_hw->dyn_bcast_rate=
;
+       struct cl_sta *cl_sta =3D NULL;
+       u8 min_mcs =3D WRS_MCS_MAX - 1;
+
+       if (!cl_hw->conf->ce_dyn_bcast_rate_en)
+               return;
+
+       /* When the last station disconnects - set bcast back to 0 */
+       if (num_sta =3D=3D 0) {
+               cl_dyn_bcast_rate_update(cl_hw, 0);
+               return;
+       }
+
+       /* If this station did not have the minimum rate there is nothing t=
o do */
+       if (mcs > dyn_bcast_rate->sta_min_mcs)
+               return;
+
+       /*
+        * Find new minimum MCS of all station (the disassociating
+        * station is not in list at this stage)
+        */
+       cl_sta_lock_bh(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               if (cl_sta->wrs_sta.su_params.tx_params.mcs < min_mcs) {
+                       min_mcs =3D cl_sta->wrs_sta.su_params.tx_params.mcs=
;
+
+                       if (min_mcs =3D=3D 0)
+                               break;
+               }
+       }
+
+       cl_sta_unlock_bh(cl_hw);
+
+       cl_dyn_bcast_rate_update(cl_hw, min_mcs);
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

