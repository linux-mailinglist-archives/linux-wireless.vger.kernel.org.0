Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A193AB8C6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhFQQKZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:25 -0400
Received: from mail-eopbgr00044.outbound.protection.outlook.com ([40.107.0.44]:21118
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231241AbhFQQJX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CbVBUozsxy9jFGYNzkw2RQ3Y0Uw9I80lfeY+na3XpU6EM0+lK81svrQuL53sY8hF6Z6/ZEKmIjXg5izx6gs8F1+NrEcsVYasThHYPWh+taQJec8Ger/BirwMCGgYvJKKE/BhveQBsOWrbsKeWhpQd58Y/ubNXw1cwG6t4vB+OxJSYQXPfFNKl0JMQTAP9Mtd83Jx7AkhPqsHY1UIz5LGDIX2pvvNQ5n3C2vdXTjvw8VzbpDLjOS21CGDLpjRaEi5T3iOQd3ZUuw/T9ClxjpV7gMuYAsGQnWprmsjn/C33s7kOdmLjofaynv8sY0V4gvl9l6OFN68fpovYdbzmOAOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR26Er8rGmzNBDNVIhxly8Fj56zTfuyQ3VHASzSNxWA=;
 b=WHFodNapKEpShmnyThC7hRL+HFRcncjyzZmEaP65tZwPCcRUeBbfXqIiksAy/r3N6oduHk0nq7k78pWHougrk0Yb4t7r4sR1cZIcSVggjS3SDcjMKuNb2yzrKRdQrhj2ujndkI17xiinv5WUGA5yKqDSJqHtDJ04mTv+bFy5Th6t0Ts+Iq/VG2wJpcRjfMIP1/KvBZDBWT2j6DrKMLYmLUhHyKl7ckIodwgVVbvk9PrjrdLmMQOXyllDaDzp0MKs6wjqfl72aph/LKhPHMjbQHSfsVYZy8hg27/qiQXogveqgnKJn2r1TyJesByts7qpOIcffz6WKQnpwgvMK1c0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR26Er8rGmzNBDNVIhxly8Fj56zTfuyQ3VHASzSNxWA=;
 b=JqXxi8ZrrallibZ2uS6xmIVmiWVZEzo2U3zVvl1GFtVD1ZEBwYKEQslfuhTTRe8Y7ylCLRu+0FLeqEJkw3bBZhw7LdHnkwiMyu99Fkse2RSiZEtphUij+YbFG07UIxrU9iM0tFD4DfSNGrmvVJXQalbJs+B83rgBrJZ8YYWQHX4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:13 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:13 +0000
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
Subject: [RFC v1 192/256] cl8k: add traffic.c
Date:   Thu, 17 Jun 2021 16:01:19 +0000
Message-Id: <20210617160223.160998-193-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcc26f54-0ff0-44c3-e795-08d931a9d09d
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10757B1B6BFE9661A5CD41BBF60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:112;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLhs0kIv13hEBpiyw6QKl6YiaKpXqDBtIUJpNhqj7/4WB5I6uq7ofESZmjh0nbkI8jpqwXaTunPb3WKBRTQ0XGdfqtjheHCzr1scbUomSwgiTPokZ2g7ODhSnUzaZ7F5HxzNiGgGl0XU5KXMXG10HyBaWNBByLYpsBwMYmsRbSNr6hASWfPKqPY+WyBUkRP1qnaVtfT2drl2x/D7flgrwiIPPmvBSjwHB4bfylc2MAwDx+eSJ5f1rIDbA0RndLnCItyQlC25XSZNjQqosQU03wAVG25CIWexyrmJ8WPH3R/NYg+wRiLcHvzX+LCsFi2vYMf4fCNMsCUxlsRLnqIPR1J34+SRDB1teMy0x+4MpGLqog8ej3w66zrCmVviAooUwYCbAMB1pKLzgDWDVNl4k7DG7u7MOKjqOWranWA1E38JpnVBxsQVaEkP9NlAFFvmartUTsDeUp6609tgwClekNlMVNLGjMWg2ZkHLFxVWzTOjPxZmzWRp1UlTqvXAo/n039X9WTj+/xka2c8Z4Ecr6+3xfsBUCS0cTiYiQ0dfJj6FKrXLVvsI0iQM+VwRW/gUTj9O0rb2qtz8SUnS+7ONf8zJad3FFF0o9yX+PebwMRiz74oUg44dxm2ekA0JZXDq6/lJ/aPRu4Tc+mqqtw8HrUnM24TUh6n6gBExtbt2MMS9buRJ2hXR6tn3DPSnq+dNpuv3eJ0lRYls0EFUrymgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(30864003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UuJyDugEADN+aAyQqlKhDd/ZFqYEM/jPE7QXzbawMKRBE63b1t+KK+aXYC2Y?=
 =?us-ascii?Q?Sm/4dA7hU2XfUmcmYBXHDnC8Pozbxz5qF6/myEHW/gRQ0nQgqZ/LnihOVub+?=
 =?us-ascii?Q?pbdphBrQ1sN/2A9x4femC200aRLLt4iG7xv2owRYyKy/IKDUIKHMk+g3bQ1/?=
 =?us-ascii?Q?M8+53qsMWkX1zNqVYj1GtjJuGQNsH4HNTgF+37L9yxzPPJHjO2b7LIMafrOZ?=
 =?us-ascii?Q?lCV//Ej+Yj+rjPf5X15K9mLusMylPzYHNrRpUoS8IUjqM+C4RW80ajrc0KvT?=
 =?us-ascii?Q?RsyG3kffpyJKyqqEU+ycpNS2+xQkEeMg8sHMaVd8yPE0PFCdDslL+lRyCPLp?=
 =?us-ascii?Q?LlGAt6cN4lhk85BIHJ+7vkcioZ9u1pT5fFNNrDuR569MfDp8/cOfw5yPvd6M?=
 =?us-ascii?Q?YP+P4u2hlBG5FZMzGvAnPH1hyIRJZBD04ka6ypSHjfiuezZoX2maweSLHe+i?=
 =?us-ascii?Q?4DCcvz0qqgfLORDfIdTBBMOJC71n+iFwKDVi2X1iXjD0K4ILnQo7SoV77K+y?=
 =?us-ascii?Q?AKhaZCRhVl5444hcklu1AeRkce3xAoUMisP77VoPTTGMtStingJCsj3yL/Ln?=
 =?us-ascii?Q?6PGk92GtuDbAGdrb4IWUWi0FGT1kJCeU8PtjiXMINrAsjuJSyyyRpF2tWp9V?=
 =?us-ascii?Q?CECmBr5/hz/HsWwh9iPkS6QtJZo0LrgXV+yESblyWhE2fnZkUeJDJ5l3XevY?=
 =?us-ascii?Q?oIsjL5RjNFVwC+7eEz1KSit11UeEkCe2Oa9MtleeV/bYyP0vXppJL42rHe6z?=
 =?us-ascii?Q?N1luSpPdgvd4z55z8i0HQmVQpejIzlpTRR/4hyVubGdjCE76DwwC4wPZ4GxD?=
 =?us-ascii?Q?a1dQ3KP62fDioAmwdIbLfXngZZTgWktoUVPazcp3ieKOI8RbN8b9CxiqxGei?=
 =?us-ascii?Q?wiOxRQ4QnB8xVVkCPUAlrDp5vhUWwINrwuRJrp1arHQnS5SqO/zdJYMWFid4?=
 =?us-ascii?Q?Uqk2h0DpbwTwr3re95ctr2RZHksokZtwsbYVs05xcu+4yCm6+gm4lNYjIYBG?=
 =?us-ascii?Q?i12LVMRft/JPuG77a2TmjhEQNSyzuueh/i43/02J2QZRR+9jneStwo0WSYsg?=
 =?us-ascii?Q?mBXTyZhYGnrSthGWdhlYWem7NvGT/MEH2yphjXGtY2NpaLFT0dHLYhdtz4pe?=
 =?us-ascii?Q?6sUrq8DVmylWRceo2hwLN+7rm8+Av77h9Ejjt+T5UpJ3TQUXF8mddpOMJq3W?=
 =?us-ascii?Q?z3YmQS0L9bKRf2gk21WgIHdHGT8mMx0xUjLyR+SWhYvfhIjNZsM9SZtJuasR?=
 =?us-ascii?Q?VrPZKCzAbpZC/928ozG7sVFXYhq3mXNyDN3sUas8W7GQw5Rn1RnabaWrSKgO?=
 =?us-ascii?Q?fJdC1erCQGHC1tGcOKUa1Y/3?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc26f54-0ff0-44c3-e795-08d931a9d09d
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:07.1099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrdnj4sKYk6s3oaGeGovpLn8cGrc1L+8BDfYapl6ll5gg59yoRJh+G24vx4UxVk5gjwPoiZ7ZokcJ70DhqObzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/traffic.c | 315 +++++++++++++++++++++
 1 file changed, 315 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.c

diff --git a/drivers/net/wireless/celeno/cl8k/traffic.c b/drivers/net/wirel=
ess/celeno/cl8k/traffic.c
new file mode 100644
index 000000000000..19d91eb3e999
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/traffic.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "traffic.h"
+#include "env_det.h"
+#include "edca.h"
+#include "bf.h"
+#include "prot_mode.h"
+#include "band.h"
+#include "utils/utils.h"
+#include "rsrc_mgmt.h"
+
+#define TRAFFIC_CNTR_ACTIVE_THR     3       /* 3 * 100ms =3D 300ms */
+#define TRAFFIC_CNTR_IDLE_THR       20      /* 20 * 100ms =3D 2sec */
+
+/* Threshold in bytes */
+#define TRAFFIC_ACTIVE_THR_DRV      1920    /* =3D 150Kbit/sec (150 * 1024=
 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_BF       26214   /* =3D 2mbit/sec (2 * 1024 * 1=
024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_EDCA_6G  2621440 /* =3D 200mbit/sec (200 * 1024=
 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_EDCA_5G  2621440 /* =3D 200mbit/sec (200 * 1024=
 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_EDCA_24G 655360  /* =3D 50mbit/sec (50 * 1024 *=
 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_DFS      13107   /* =3D 1mbit/sec (1 * 1024 * 1=
024 / 8 / 10) */
+
+static const char *level_str[TRAFFIC_LEVEL_MAX] =3D {
+       [TRAFFIC_LEVEL_DRV]  =3D "DRV",
+       [TRAFFIC_LEVEL_BF]   =3D "BF",
+       [TRAFFIC_LEVEL_EDCA] =3D "EDCA",
+       [TRAFFIC_LEVEL_DFS]  =3D "DFS"
+};
+
+static void cl_traffic_sta_start(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a,
+                                enum cl_traffic_level level, enum cl_traff=
ic_direction direction)
+{
+       cl_hw->traffic_db.num_active_sta_dir[direction][level]++;
+
+       /* If other direction is not active increase num_active_sta */
+       if (!cl_sta->traffic_db[1 - direction].activity_db[level].is_active=
)
+               cl_hw->traffic_db.num_active_sta[level]++;
+
+       if (level =3D=3D TRAFFIC_LEVEL_DRV) {
+               /*
+                * Dynamic CTS:
+                * If protection mode is disabled, environment is clean
+                * and station threshold was reached switch to CTS.
+                */
+               if (cl_hw->traffic_db.num_active_sta[TRAFFIC_LEVEL_DRV] =3D=
=3D
+                    cl_hw->conf->ci_dyn_cts_sta_thr)
+                       if (cl_env_det_is_clean(cl_hw) &&
+                           (cl_prot_mode_get(cl_hw) =3D=3D TXL_NO_PROT)) {
+                               cl_hw->traffic_db.dynamic_cts =3D true;
+                               cl_prot_mode_set(cl_hw, TXL_PROT_CTS);
+                       }
+       } else if (level =3D=3D TRAFFIC_LEVEL_BF) {
+               if (direction =3D=3D TRAFFIC_DIRECTION_TX)
+                       cl_bf_sta_active(cl_hw, cl_sta, true);
+       } else if (level =3D=3D TRAFFIC_LEVEL_EDCA) {
+               /* No action */
+       }
+
+       cl_rsrc_mgmt_traffic_start(cl_hw, level, direction);
+}
+
+static void cl_traffic_sta_stop(struct cl_hw *cl_hw, struct cl_sta *cl_sta=
,
+                               enum cl_traffic_level level, enum cl_traffi=
c_direction direction)
+{
+       cl_hw->traffic_db.num_active_sta_dir[direction][level]--;
+
+       /* If other direction is not active decrease num_active_sta */
+       if (!cl_sta->traffic_db[1 - direction].activity_db[level].is_active=
)
+               cl_hw->traffic_db.num_active_sta[level]--;
+
+       if (level =3D=3D TRAFFIC_LEVEL_DRV) {
+               /*
+                * Dynamic CTS:
+                * If it was turned on and active station count became lowe=
r than
+                * threshold --> return to no protection
+                */
+               if (cl_hw->traffic_db.dynamic_cts) {
+                       if (cl_hw->traffic_db.num_active_sta[TRAFFIC_LEVEL_=
DRV] =3D=3D
+                           (cl_hw->conf->ci_dyn_cts_sta_thr - 1)) {
+                               cl_hw->traffic_db.dynamic_cts =3D false;
+                               cl_prot_mode_set(cl_hw, TXL_NO_PROT);
+                       }
+               }
+       } else if (level =3D=3D TRAFFIC_LEVEL_BF) {
+               if (direction =3D=3D TRAFFIC_DIRECTION_TX)
+                       cl_bf_sta_active(cl_hw, cl_sta, false);
+       } else if (level =3D=3D TRAFFIC_LEVEL_EDCA) {
+               /* No action */
+       }
+
+       cl_rsrc_mgmt_traffic_stop(cl_hw, level, direction);
+}
+
+static void cl_traffic_check_activity(struct cl_hw *cl_hw, struct cl_sta *=
cl_sta,
+                                     enum cl_traffic_level level,
+                                     enum cl_traffic_direction direction)
+{
+       struct cl_traffic_activity *activity_db =3D
+               &cl_sta->traffic_db[direction].activity_db[level];
+       u32 num_bytes =3D cl_sta->traffic_db[direction].num_bytes;
+
+       if (num_bytes > cl_hw->traffic_db.active_bytes_thr[level]) {
+               activity_db->cntr_active++;
+               activity_db->cntr_idle =3D 0;
+
+               /* If traffic is above threshold for X consecutive times ch=
ange state to active */
+               if (!activity_db->is_active &&
+                   activity_db->cntr_active >=3D TRAFFIC_CNTR_ACTIVE_THR) =
{
+                       activity_db->is_active =3D true;
+                       cl_traffic_sta_start(cl_hw, cl_sta, level, directio=
n);
+               }
+       } else {
+               activity_db->cntr_active =3D 0;
+               activity_db->cntr_idle++;
+
+               /* If traffic is below threshold for Y consecutive times ch=
ange state to idle */
+               if (activity_db->is_active && activity_db->cntr_idle >=3D T=
RAFFIC_CNTR_IDLE_THR) {
+                       activity_db->is_active =3D false;
+                       cl_traffic_sta_stop(cl_hw, cl_sta, level, direction=
);
+               }
+       }
+}
+
+static void cl_traffic_maintenance_sta(struct cl_hw *cl_hw, struct cl_sta =
*cl_sta)
+{
+       enum cl_traffic_level level =3D 0;
+
+       /* Check Tx & Rx activity in all levels */
+       for (level =3D 0; level < TRAFFIC_LEVEL_MAX; level++) {
+               cl_traffic_check_activity(cl_hw, cl_sta, level, TRAFFIC_DIR=
ECTION_TX);
+               cl_traffic_check_activity(cl_hw, cl_sta, level, TRAFFIC_DIR=
ECTION_RX);
+       }
+
+       /* Reset num_bytes */
+       cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes =3D 0;
+       cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].num_bytes =3D 0;
+}
+
+static int cl_traffic_print_state(struct cl_hw *cl_hw,
+                                 enum cl_traffic_level level)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+       struct cl_traffic_main *db =3D &cl_hw->traffic_db;
+
+       if (level >=3D TRAFFIC_LEVEL_MAX) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "invalid level %d\n", level);
+               goto out;
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Level %s (%d)\n", level_str[level], level);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Active stations    - %u\n",
+                   db->num_active_sta[level]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Active stations TX - %u\n",
+                   db->num_active_sta_dir[TRAFFIC_DIRECTION_TX][level]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Active stations RX - %u\n",
+                   db->num_active_sta_dir[TRAFFIC_DIRECTION_RX][level]);
+
+       if (db->num_active_sta[level] =3D=3D 0)
+               goto out;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|---------------------|\n"
+                   "|Sta|ActiveTx|ActiveRx|\n"
+                   "|---------------------|\n");
+
+       /* Go over all stations */
+       cl_sta_lock_bh(cl_hw);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+               cl_snprintf(&buf, &len, &buf_size,
+                           "|%3u|%-8s|%-8s|\n",
+                           cl_sta->sta_idx,
+                           cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].activi=
ty_db[level].is_active ?
+                           "True" : "False",
+                           cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].activi=
ty_db[level].is_active ?
+                           "True" : "False");
+
+       cl_sta_unlock_bh(cl_hw);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|---------------------|\n");
+out:
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_traffic_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "traffic usage:\n"
+                "-s : Print traffic state [0-drv/1-bf/2-edca/3-dfs]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+void cl_traffic_init(struct cl_hw *cl_hw)
+{
+       struct cl_traffic_main *traffic_db =3D &cl_hw->traffic_db;
+
+       traffic_db->active_bytes_thr[TRAFFIC_LEVEL_DRV] =3D TRAFFIC_ACTIVE_=
THR_DRV;
+       traffic_db->active_bytes_thr[TRAFFIC_LEVEL_BF] =3D TRAFFIC_ACTIVE_T=
HR_BF;
+
+       if (cl_band_is_6g(cl_hw))
+               traffic_db->active_bytes_thr[TRAFFIC_LEVEL_EDCA] =3D TRAFFI=
C_ACTIVE_THR_EDCA_6G;
+       else if (cl_band_is_5g(cl_hw))
+               traffic_db->active_bytes_thr[TRAFFIC_LEVEL_EDCA] =3D TRAFFI=
C_ACTIVE_THR_EDCA_5G;
+       else
+               traffic_db->active_bytes_thr[TRAFFIC_LEVEL_EDCA] =3D TRAFFI=
C_ACTIVE_THR_EDCA_24G;
+
+       traffic_db->active_bytes_thr[TRAFFIC_LEVEL_DFS] =3D TRAFFIC_ACTIVE_=
THR_DFS;
+}
+
+void cl_traffic_tx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32=
 num_bytes)
+{
+       cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes +=3D num_bytes;
+}
+
+void cl_traffic_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32=
 num_bytes)
+{
+       cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].num_bytes +=3D num_bytes;
+}
+
+void cl_traffic_maintenance(struct cl_hw *cl_hw)
+{
+       cl_sta_loop(cl_hw, cl_traffic_maintenance_sta);
+}
+
+void cl_traffic_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       /* Check if station disconnected during traffic */
+       enum cl_traffic_level level =3D 0;
+       enum cl_traffic_direction direction =3D 0;
+
+       for (direction =3D 0; direction < TRAFFIC_DIRECTION_MAX; direction+=
+) {
+               for (level =3D 0; level < TRAFFIC_LEVEL_MAX; level++) {
+                       if (cl_sta->traffic_db[direction].activity_db[level=
].is_active)
+                               cl_traffic_sta_stop(cl_hw, cl_sta, level, d=
irection);
+               }
+
+               memset(&cl_sta->traffic_db, 0, sizeof(cl_sta->traffic_db));
+       }
+}
+
+bool cl_traffic_is_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       return (cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].activity_db[TRAFFI=
C_LEVEL_DRV].is_active ||
+               cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].activity_db[TRAFFI=
C_LEVEL_DRV].is_active);
+}
+
+bool cl_traffic_is_sta_active_tx(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a)
+{
+       return cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].activity_db[TRAFFIC=
_LEVEL_DRV].is_active;
+}
+
+u32 cl_traffic_num_active_sta(struct cl_hw *cl_hw)
+{
+       return cl_hw->traffic_db.num_active_sta[TRAFFIC_LEVEL_DRV];
+}
+
+u32 cl_traffic_num_active_dfs(struct cl_hw *cl_hw)
+{
+       return cl_hw->traffic_db.num_active_sta[TRAFFIC_LEVEL_DFS];
+}
+
+int cl_traffic_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       bool print_state =3D false;
+       int expected_params =3D -1;
+
+       switch (cli_params->option) {
+       case 's':
+               print_state =3D true;
+               expected_params =3D 1;
+               break;
+       case '?':
+               return cl_traffic_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               goto out_err;
+       }
+
+       if (expected_params !=3D cli_params->num_params) {
+               cl_dbg_err(cl_hw, "Wrong number of arguments (expected %u) =
(actual %u)\n",
+                          expected_params, cli_params->num_params);
+               goto out_err;
+       }
+
+       if (print_state)
+               return cl_traffic_print_state(cl_hw,
+                                             (u8)(cli_params->params[0]));
+
+out_err:
+       return -EIO;
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

