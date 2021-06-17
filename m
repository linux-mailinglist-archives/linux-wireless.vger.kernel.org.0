Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83E33AB861
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbhFQQHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:07:31 -0400
Received: from mail-db8eur05on2082.outbound.protection.outlook.com ([40.107.20.82]:7360
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233641AbhFQQHD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:07:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0mCP5Va65GWIR3wPaZEo6yKgTssyaDJIzm52gWrg93gK2UvO+oND73kAh6uBh2GAsdtmlVgpAzMVCqf0xZNJhe4mVirGMtDhGE/H8AsNtaxlEK8gBgK2/Z72e5aIPZiGOoPFA3s6qyfX6AWUjgZBnZ88hLYKWqsa4az0icVQM1MlZd6k03w8qw0n9+zgse8t26ZRBZQ71yBpP/KzJJlFn8ljwqJQoLSDoafBL9NboU0eyono+0Q5vAkYNos7xLrHk4PFfDjB2IYFJiS+0H0v6WjxkujrKnvLqU9ZUJJXv3Gcdzm4VdHgXh/vVAEFHADlJn1vPo4vV5o44eW4RbzpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJVvRH1ft9+DvgxsD3hWJhAhCqOss9ZHsBiKwWsWC8E=;
 b=gn3+8HaZYCAEUl1DAWu+Ap0YVwJSuAPjAQd57Q3nBFSkfH7IBq5c9+KHXAkJoHYApwhGwlA4nF6U64Z6l+xyE9NTc921jn3e7D9PA9Z+5pTeuqRgnYArLsStpVunEDlR0jtAiGWzAhL/mUwIw75SdIkWOT5JDjjGKDXy+6FJV7CDJXvj5VTD9U4EoXDucr9sEjn1waxA7cvAD6rSC/P0S5v8ifD1FYVSqIAg5vqqjpo2WQdgfCGVMPliEY5Dpee0bX94MFRt27dkTlP0kEQegDWWhPQ2ywQoxUmWp2paomITlcBFWDgw2+mmHz4hH7z0huVdOw2YzisTt4Nk3VkfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJVvRH1ft9+DvgxsD3hWJhAhCqOss9ZHsBiKwWsWC8E=;
 b=YCYE8mwdO9YdQkYVGKgGjYirs+UxdgXhZhIz7JdCxF9IImHle/fPMRW4izlTZbTZvejhpza5P7nIrKqzu6jwE+1atYj71gmUKen8wJ7qzHCDWaLdYjtVZ5ZdGr6YgyJO2NRGjomUr2QfdqMTWzPvzKhsJXaB+5/4jOx78NxaSIE=
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
Subject: [RFC v1 079/256] cl8k: add ext/dyn_mcast_rate.c
Date:   Thu, 17 Jun 2021 15:59:26 +0000
Message-Id: <20210617160223.160998-80-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d3342a4-02b5-4519-5c7b-08d931a98520
X-MS-TrafficTypeDiagnostic: AM9P192MB0871:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB0871A0BCD7130C2BB1910776F60E9@AM9P192MB0871.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eRwAx3XU0fvXX/wJm18y5osfUZ8m/yXK4ODP/yU9i5DNCDRdzOO+w++Vb2OMQQi0nfrsiCcHqPWonQE642wwLYB0/s86lYvfvTIvtzKn1FahemGErbGfHkznrIBE1wpD8JpBtydc42SIfQSCJMXQPInAFrFRHtvESbzZgWbPIGtAkZsPc3m4qtEnClE5MPsxR8apsUePP6R8hAlYrNKo8bNRAAvxDfpeC+ncLsnB1QF06JQIpYCN+upIGtm0JawKE0u4uac21DrMPt/I71nEBKJrArKurACwtsCCIiR6gFi2mEMLGg/uXwtLTEZEZmUGsob+hcJp4yzPU/arWs5ZK2b/XyDbuZ/xwl7PiHwwa2mEr6O8eGoLtXL1QyKFwUW/UykADJvVdXPOjz853qc6Vhik2mvonc18vDQX0gJsqXIfx9eSSE1QiT+Nea3zmZxmQjzjwcB+l0LMCDaGt/3RFnoZvWjUgDa8aSINJHAaG/j92tJPHsrqIiyRKU6wYW8KKkdT/AXdzjMeKN8qtrxvhdH2HUWVe6GMNzXeoaK6f7Wq+df+DsSqO+xCbGl4ahyUEk8mA5mRhDpqm07bCovtz/qe3bO2UPVeU89eg3VN4uf/uLhBpWlTdCGnymKaiL3rV/29Pp+kPitrgCHUzQ1EH+YDk2SIeLAo5zZWmMai0dlojtDiA1UYdIQRTVWpX6+7XtFUdMX5sQrQGUAu6QSWqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(346002)(396003)(39840400004)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(8676002)(83380400001)(5660300002)(52116002)(2616005)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kdub8PfSrEVq97HSbA81/CWflesvzm2NKqcfKXjkLGXQyCcdR+HHKUP9vAuF?=
 =?us-ascii?Q?YwYjaMF71I5P+QMg338JRG/gAHRwSAwB4g+ScfmI3nvu1/6NU7XiXpNITRQs?=
 =?us-ascii?Q?bbvAY2ImzNQprVsf1uubVL+yb3TtPNGn3rHj813lHuu0oTpQAu4kCrpWQY+J?=
 =?us-ascii?Q?Bc+MPVyiy+NCRXPz5ZvHeMJaelv9zT2jLi1YdxMcb2qhzMofVvORZfRd/H07?=
 =?us-ascii?Q?IuIEHyw28VNSDt30zAhO6uISRLDFnXbyD7ZnuVydIVyDQ2dJp+r3gU/TGewn?=
 =?us-ascii?Q?uQP+Gw4eDWsoIvY4CDrlNbdLqyMR63EkZLYFv4J2AcpBWpQy98zMkawqaMQL?=
 =?us-ascii?Q?ZfNcD/MxoUMLjOW2Eb8IjwiTSaPpMJKxkaxlsoACmZshfO3dbHZgj/l2+zdD?=
 =?us-ascii?Q?NCmwkajz/RdCh8qhbqdbk6pC1t8d5PHF73Dtxs7G8hT1fhl8XDdCEL+E3gEs?=
 =?us-ascii?Q?WmVVgEmVXWj0G1V79EC4Uywa4tZYzRevEtyHPOyjLUDvd8vknqp2LJYwgt5Q?=
 =?us-ascii?Q?VJOqtv63kHpFnppJ+tixCyQBDr5ZfpWGfVQVivyfuwAvgobXygTBndKOxeIu?=
 =?us-ascii?Q?d/DTDYycuaAYqQMczIXnm4f7ym/lUg16T/hXUbBbA/pzfmdWXQtaJ1rhrKzb?=
 =?us-ascii?Q?SPFrfCYH5yxdBpG54drNTRRFAxzOHxkokZ3IrFYKP8cUyTB2c8uQ13SuiyoU?=
 =?us-ascii?Q?kn422CM6XWDQl/YeuZYrddgZyx9ZR5tQT9P/jDzpnIsqUOGOyMI6gDBeNQ0a?=
 =?us-ascii?Q?WWrOx0ryoLMfgCtPRjNOrrch0hgelCapIId1TgxL6DRLQe6wsQPgRqZIdzd7?=
 =?us-ascii?Q?STGfMZVmSZgRTgHh9Y18IBpNO71aMBfMTTENLZPIi/TFAQPcaFT13pi2pfgE?=
 =?us-ascii?Q?eqei0GssnoT5FmjsSqQDbdR5+ECFur20KW6CsmSuVYOklcCRKQ5UG2aJHAvh?=
 =?us-ascii?Q?WBUAVXkPCxbpZMeZ7x8wDwJPH8RIdzgRaLUt5Rmcj/LADVUdV5VBtwbQ1QPE?=
 =?us-ascii?Q?NZ8NkfqJN2+gk8y4iBC1WAWy4c+WgEwq32cNWtrzoIl09syNw7Go3VRrrDXj?=
 =?us-ascii?Q?LU/uRiJef9a/OK003s1VOA4fnw8JbcX4rznU8ESrOPvMa/RbP/fTSdq2G6i1?=
 =?us-ascii?Q?IqAggWC6u3aVP3YQbR4zE9Olo7WiMbQJicW9QjQz7XMcvYVWfzC86UVX5f4W?=
 =?us-ascii?Q?A9cGktrNTrUI1aY6w+NybVO4yfDsXns+8ee50BJYt/BB/qfvB39QfMxezMLZ?=
 =?us-ascii?Q?u1jlHTJfrz+MPQKuQxnj6LYkxw0+S5q8pi9L9holUyKGS0WK5yUB/J21T9Ws?=
 =?us-ascii?Q?WrNDvXAhol+4qgz52wAQX1Np?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3342a4-02b5-4519-5c7b-08d931a98520
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:04:00.3694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UFdLgrfvBEzyvOh9qRabj8LL4sEqB8gr46FR0KszFOzKBasJ7tBv/Swah9bcz4zbDByWZeXiL+1FNN0L5IcGRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/ext/dyn_mcast_rate.c | 125 ++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.c

diff --git a/drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.c b/driver=
s/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.c
new file mode 100644
index 000000000000..bbd83468bcc7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ext/dyn_mcast_rate.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "band.h"
+#include "sta.h"
+#include "rate_ctrl.h"
+#include "data_rates.h"
+#include "utils/utils.h"
+
+static void _cl_dyn_mcast_rate_send(struct cl_hw *cl_hw, u8 wrs_mode_new)
+{
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+
+       if (dyn_mcast_rate->wrs_mode_curr =3D=3D wrs_mode_new)
+               return;
+
+       if (!cl_rate_ctrl_set_mcast(cl_hw, wrs_mode_new, cl_hw->conf->ce_mc=
ast_rate))
+               return;
+
+       dyn_mcast_rate->wrs_mode_curr =3D wrs_mode_new;
+       cl_dbg_trace(cl_hw, "New multicast mode =3D %u\n", wrs_mode_new);
+}
+
+void cl_dyn_mcast_rate_init(struct cl_hw *cl_hw)
+{
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+
+       if (cl_hw->conf->ci_min_he_en &&
+           cl_hw->conf->ce_wireless_mode =3D=3D WIRELESS_MODE_HE)
+               dyn_mcast_rate->wrs_mode_default =3D WRS_MODE_HE;
+       else if (cl_band_is_24g(cl_hw) && cl_hw_mode_is_b_or_bg(cl_hw))
+               dyn_mcast_rate->wrs_mode_default =3D WRS_MODE_CCK;
+       else
+               dyn_mcast_rate->wrs_mode_default =3D WRS_MODE_OFDM;
+
+       cl_dbg_trace(cl_hw, "mode =3D %u, mcs =3D %u\n",
+                    dyn_mcast_rate->wrs_mode_default, cl_hw->conf->ce_mcas=
t_rate);
+}
+
+void cl_dyn_mcast_rate_set(struct cl_hw *cl_hw)
+{
+       /*
+        * Set wrs_mode_curr to 0xff so that the message will be sent to
+        * firmware when this function is called from cl_ops_start()
+        */
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+
+       dyn_mcast_rate->wrs_mode_curr =3D U8_MAX;
+
+       _cl_dyn_mcast_rate_send(cl_hw, dyn_mcast_rate->wrs_mode_default);
+}
+
+u16 cl_dyn_mcast_rate_get(struct cl_hw *cl_hw)
+{
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+
+       return cl_data_rates_get(dyn_mcast_rate->wrs_mode_curr, 0, 0,
+                                cl_hw->conf->ce_mcast_rate, 0);
+}
+
+void cl_dyn_mcast_rate_recovery(struct cl_hw *cl_hw)
+{
+       /*
+        * cl_dyn_mcast_rate_recovery() is called during recovery process()=
.
+        * Reset wrs_mode_curr so that message will be sent.
+        */
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+       u8 wrs_mode_curr =3D dyn_mcast_rate->wrs_mode_curr;
+
+       dyn_mcast_rate->wrs_mode_curr =3D U8_MAX;
+
+       _cl_dyn_mcast_rate_send(cl_hw, wrs_mode_curr);
+}
+
+void cl_dyn_mcast_rate_update_upon_assoc(struct cl_hw *cl_hw, u8 wrs_mode,=
 u8 num_sta)
+{
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+
+       if (!cl_hw->conf->ce_dyn_mcast_rate_en)
+               return;
+
+       /*
+        * If the wrs_mode of the new station is lower than the current mul=
ticast
+        * wrs_mode, or if this is the first station to connect - update mu=
lticast mode
+        */
+       if (wrs_mode < dyn_mcast_rate->wrs_mode_curr || num_sta =3D=3D 1)
+               _cl_dyn_mcast_rate_send(cl_hw, wrs_mode);
+}
+
+void cl_dyn_mcast_rate_update_upon_disassoc(struct cl_hw *cl_hw, u8 wrs_mo=
de, u8 num_sta)
+{
+       struct cl_dyn_mcast_rate *dyn_mcast_rate =3D &cl_hw->dyn_mcast_rate=
;
+       struct cl_sta *cl_sta =3D NULL;
+       u8 wrs_mode_min =3D WRS_MODE_HE;
+
+       if (!cl_hw->conf->ce_dyn_mcast_rate_en)
+               return;
+
+       /* When the last station disconnects - set default mcast rate */
+       if (num_sta =3D=3D 0) {
+               _cl_dyn_mcast_rate_send(cl_hw, dyn_mcast_rate->wrs_mode_def=
ault);
+               return;
+       }
+
+       /*
+        * If wrs_mode of the disassociating station is bigger
+        * than the current mode then there is nothing to update.
+        */
+       if (wrs_mode > dyn_mcast_rate->wrs_mode_curr)
+               return;
+
+       /*
+        * Find minimal wrs_mode among the connected stations (the
+        * disassociating station is not in list at this stage).
+        */
+       cl_sta_lock_bh(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+               if (cl_sta->wrs_sta.mode < wrs_mode_min)
+                       wrs_mode_min =3D cl_sta->wrs_sta.mode;
+
+       cl_sta_unlock_bh(cl_hw);
+
+       _cl_dyn_mcast_rate_send(cl_hw, wrs_mode_min);
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

