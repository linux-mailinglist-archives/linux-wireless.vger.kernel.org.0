Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD03AB91F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhFQQMu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:50 -0400
Received: from mail-eopbgr30061.outbound.protection.outlook.com ([40.107.3.61]:14471
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229709AbhFQQLn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbQor7xU+idxm+6Ngy9FuDU5ppDRPBjf6vIJdo7QHAEWLtDP1QE2dmexpcmsuoqTAVqBmUNZG9YpDr0gYWkQsXeZAutB1jauUbYanpE2c0S2MRpmmqcTXD2WCGoOqxXWum3Qr0xKTFBCyiVkLIi5fXR3YDEEEOvWHW9cHAOFV984KTNCSdijg7S3//PXKlLcw7yhwk+L65T+SaSZm0881czAgvxiKgHOohBAHHbjv9ZgsID6c2j9pANz1x6HIw898Sw4z9HtEVgetw8t+GHVM71IQqPyU9IqgCxjT5O9f0CPS0AMYWTPUmNH3hiHVm4qC2POxo8nVtc2p6nKKslsTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37e01dGGhQAeJpHcOK/f79aDE5NwEqmGsujwQNPCDzA=;
 b=HgDkO4iakifgEF7Pw0Ek9sq5cPn3pTqt9fvwAT0wZIl5F5Q1G9DtQ9nb8nxbSnOPlCafPWEBUHmLqSxJWe/SRCQ3koLYuVz0eUdFidsvUfXETHqaFA2Ewk3ZMTZmBpcrUMb7aJDs+hoCDrv7bhCmPPOM4IGLlTs4f05KWH7iJwVwx0TxnMF3wZENHfFEUWSpmDTEjadEp96bslxBGsaKdIn5nvmZuNRiWqu8jhXKn5CkD8e9zxZn2cmfhm1iX0t/X1Fu47doyQeFkeYi1r10p+DB2uOqM+W/hjtJIoeRcgXGzsyfI3fnD7eYLwwebJecNqtC04ExqEkncpuR4KjNcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37e01dGGhQAeJpHcOK/f79aDE5NwEqmGsujwQNPCDzA=;
 b=XVCavC0fu9f5YsKBLaQbYNrqGMugZmhXkbTcZqOxjy3mlYGu25te/Oxa+n7cXXj0c6ZJwYDfZXyoi/LaOMwXXqXyzYLvVevhlaRnJbvFBvtj/WPgH55qn9oD7NvtiDtjaCFWF+Hap9IEVYNUX37GXoFn0uBJ9lfhOOY+mberGXY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1187.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3af::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:06:32 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:06:31 +0000
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
Subject: [RFC v1 168/256] cl8k: add rsrc_mgmt.c
Date:   Thu, 17 Jun 2021 16:00:55 +0000
Message-Id: <20210617160223.160998-169-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60add62-f366-4ba7-338d-08d931a9bf74
X-MS-TrafficTypeDiagnostic: AM9P192MB1187:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB11876420F472F86FE042819DF60E9@AM9P192MB1187.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpAMs7Sa0FJkMuw/m8TC5qDUP5dB/WVe56UjOxIpOqPznfxu5x6woOSJqj0NqYLGJf3lMcGHzJ4AvYsCrW37sMO5Vw0W0CXWQ31baqeNapogN8gWKvdv3lW70OKMZmHCs2PelUumIrLuqHtrn93dnAN2UcKBzOfgxcpkSAg3qv7Sk+yHS/67rTUnDAhZdBwIiKbXuxjnaGTyQE2FWsYRBZsTohsQAh1sYgERGSK4Up5akU1iEdnvFupsWOyb+OSFn+Hiqx8UeIqnU8EtesJbJDkmoJ2uOTKPZIowt+jCwbRIrD0/P+2W+5sQqkZOoK52lKqZpxVoRJn21Q1vKR4rX6moXDY0xwJum5ElQeASkiC/mOzVs7TlyvI/rY7Us5ZeEcPQLFTFAWjdMAxLLw5BClETyNTTP4Wgwx/4z7/UpY0h1aqMyBzlD31iJsvLiIkFNYEKM8GAeMBlkAClTPTxP59Pv7+xNpBrYejSbKnlGlR/jR6DbRY2Fd7fLVpo+wzbsQdElkWWULtDW+niR4zWNMM9HcPHn6u0YjNy01jYuG2lquEfkqx7rBF7OcqwstZMl2aep5He9R7K6FPztj1NyBs+GlX+REAbhDbNgzn66Rhy0TaKkimEIYrmfmYjSwa3kaeh8OA99U5PNlhBepXhp2GHp+h+LRcYxMODtTlBL38drfQ2wOrXg7913UoBUidueBhOFMQC08sKUHgeM4RFaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(136003)(366004)(346002)(6512007)(66946007)(55236004)(66556008)(6506007)(54906003)(8676002)(4326008)(186003)(316002)(66476007)(6486002)(26005)(6916009)(86362001)(36756003)(9686003)(8936002)(6666004)(5660300002)(2616005)(956004)(2906002)(478600001)(52116002)(83380400001)(38350700002)(16526019)(1076003)(38100700002)(107886003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKDrNxcQlS+RZKt4UOGISxmrL6SGBRhn2l6A3YqNCuuFgt3QBSaUbN4E+6jV?=
 =?us-ascii?Q?WFnacqsay7IimcPr3kw6ejrHfZlUJpERqz7wDLCvqVVOLj8cRWnroUFLLehW?=
 =?us-ascii?Q?BilTFuFPfTpgOm4RywqczsxuBrcuewXYG9ulgupLTDo4FpaQ9PyIho/XFIQu?=
 =?us-ascii?Q?IraZ3B0+1js7aTjh91jzv8wSDPFJc2l75ZutXt0pZBd72fWnScvST93Huf0E?=
 =?us-ascii?Q?yGR16Hify0rf0igDy06KTFAqRANvKdAKzDDCGu2pBftNsAn2ukVDuIbm5yJZ?=
 =?us-ascii?Q?xFMt7UFJdsFknR+/Rl4C1hKdow6ybEDZuxKZQXVQhc5osVMO1F+gXexe4h4q?=
 =?us-ascii?Q?/4/yhv2UbARY1Q/iIse6I6vOME+XXZJSsO6rU7K6uUxf2zOB9ctJ0vGxBQno?=
 =?us-ascii?Q?QZLUGlC0EAq6cf/7YWSWhlHK/4RW1aq0NOlK1nPmnrRnlzUlTAsFzyrm2aVH?=
 =?us-ascii?Q?co2/6ZJ6/i3iOquRSN4NmYlqEWRjm/ACY1yQAK0n1DBPA9UQbjcDgVUZidLO?=
 =?us-ascii?Q?B8h6DfcU5Ub/x0d6AkLHzWPW6kvK2w2yEpGT7Zso7not9nNZI2eXDclK6m5Z?=
 =?us-ascii?Q?+6bI3f6eytg+1+INAUGkNPEnvTK9MI72TMcdmDw5/JNa+dSfMG5f6wtrIlVi?=
 =?us-ascii?Q?fhGaolFcZLdDuWcRHXZcsVzRtZ63Fo5pUw5s6mwnEfHUIhHtUps21ag4WlQJ?=
 =?us-ascii?Q?HdHlAhmj3Dbc7aOhL/Y4FhVKZHuM0DTFKSrawv8ntMpddioSq+BAs54ZNKlF?=
 =?us-ascii?Q?ppBu8f8U2+iyE51T4oafUSaOMa5gGrmJPz/3c5D68RwKX91NJTn8Pk88x7CS?=
 =?us-ascii?Q?BQcibO5UnRn0WPQM6Kc+BDKPYLEHf47xYIsrQGOZxBLIILTPvIj7aRCEwoEg?=
 =?us-ascii?Q?hCcM+y3f/tr4AmCUu+zI1KSTu1WAp0crvT3zzrIl6+bFCy+zo7PrQ1Mj0Zkq?=
 =?us-ascii?Q?NGdugYN15lkDXnwQQ5P3rNzYodvbZXZ/EPgJ0qG747gCGv9wHawMIne3MIsV?=
 =?us-ascii?Q?2Hdi/Toscd0CczSatXoqYC+O/btBSWT+tFXV5ivCjELeUYi7tH3fADmsnihp?=
 =?us-ascii?Q?fS7/goVSzCPS1jzZcw4ZH9zr9GcnVSTS1BbRtzx5QQFlM7OHSWme8HBuRgK7?=
 =?us-ascii?Q?6hRH+Qbg3PMFiRlnpIWhyZlRATN055bZb76mFYm6G3YsRsaHEyN0yAAIauzF?=
 =?us-ascii?Q?ly/iSqWV9zfzSYWIbE07NSApBPAG7yTZjPAKWLg1me1V74HBFPFDAV/JE5Pq?=
 =?us-ascii?Q?GqGzkxBFdVG9enMWvF7BuAw0QqfxxrSVd3P7yVtVIoZGks/yE3d7dl4EJ69j?=
 =?us-ascii?Q?kqKgqWlaAiAbkqHtWUFrPka7?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60add62-f366-4ba7-338d-08d931a9bf74
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:38.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rtxi0LRy9pBeErxcObdD1951Y7TF83DhJMExD2ptVcu3JepSlM5HCTXRLYfv/O/4ugEZVfmvEYTkgd49udeCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1187
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.c | 279 +++++++++++++++++++
 1 file changed, 279 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/rsrc_mgmt.c

diff --git a/drivers/net/wireless/celeno/cl8k/rsrc_mgmt.c b/drivers/net/wir=
eless/celeno/cl8k/rsrc_mgmt.c
new file mode 100644
index 000000000000..9ba8407a1306
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/rsrc_mgmt.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+#include "fw/msg_tx.h"
+#include "rsrc_mgmt.h"
+#include "rx/rx_amsdu.h"
+#include "prot_mode.h"
+#include "env_det.h"
+
+#ifndef ETYPE2STR
+#define ETYPE2STR(_e) case _e: return # _e
+#endif
+
+static const char *subtype2str(enum mm_rsrc_mgmt_subtype subtype)
+{
+       switch (subtype) {
+       ETYPE2STR(MM_RSRC_MGMT_API_SANITY);
+       ETYPE2STR(MM_RSRC_MGMT_TRAFFIC_START);
+       ETYPE2STR(MM_RSRC_MGMT_TRAFFIC_STOP);
+       ETYPE2STR(MM_RSRC_MGMT_RATES_UPDATE);
+       ETYPE2STR(MM_RSRC_MGMT_CECLI_HINT);
+
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_HINT);
+       ETYPE2STR(MM_RSRC_MGMT_ENV_CHANGE);
+       ETYPE2STR(MM_RSRC_MGMT_STATS);
+       ETYPE2STR(MM_RSRC_MGMT_CONFIG_QUERY);
+       ETYPE2STR(MM_RSRC_MGMT_NOTIF_POLICY_SET);
+       ETYPE2STR(MM_RSRC_MGMT_MAX);
+       default: return "UNKNOWN_SUBTYPE";
+       }
+}
+
+static const char *action2str(enum mm_rsrc_mgmt_action_hint action)
+{
+       switch (action) {
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_ENABLE);
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_DISABLE);
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_RESTORE_DEFAULT);
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_SET);
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_GET);
+       ETYPE2STR(MM_RSRC_MGMT_ACTION_MAX);
+       default: return "UNKNOWN_ACTION";
+       }
+}
+
+static const char *control2str(enum mm_rsrc_mgmt_control_of control_of)
+{
+       switch (control_of) {
+       ETYPE2STR(MM_RSRC_MGMT_OF_TX_AMSDU);
+       ETYPE2STR(MM_RSRC_MGMT_OF_RX_AMSDU);
+       ETYPE2STR(MM_RSRC_MGMT_OF_PROT_MODE);
+       ETYPE2STR(MM_RSRC_MGMT_OF_CCA);
+       default: return "UNKNOWN_CONTROL_OF";
+       }
+}
+
+static inline bool is_in_low_range(s8 th, s8 v)
+{
+       if (th !=3D -1)
+               return th >=3D v;
+       return true;
+}
+
+static inline bool is_in_high_range(s8 th, s8 v)
+{
+       if (th !=3D -1)
+               return th <=3D v;
+       return true;
+}
+
+/*
+ * DRV <- FW: notification_policy.
+ *
+ * Notification filters:
+ * 1. on/off (enabled/disabled);
+ * 2. active sta count (lower and upper);
+ * 3. TODO: frequency (once per 100msec etc);
+ * 4. TODO: amount of failures in feedback;
+ */
+static bool must_notify(struct cl_hw *cl_hw, u8 event_type, u8 active_sta_=
cnt)
+{
+       struct mm_rsrc_mgmt_notif_policy *p =3D &cl_hw->rsrc_mgmt_db.notif_=
policies[event_type];
+
+       return p->enabled &&
+               is_in_low_range(p->active_sta.low_th, active_sta_cnt) &&
+               is_in_high_range(p->active_sta.high_th, active_sta_cnt);
+}
+
+/*
+ * Public API
+ */
+void cl_rsrc_mgmt_init(struct cl_hw *cl_hw)
+{
+       BUILD_BUG_ON(TRAFFIC_LEVEL_MAX >
+                    BITS_PER_TYPE(typeof_member(struct mm_rsrc_mgmt_notif_=
policy,
+                                                level_mask)));
+       BUILD_BUG_ON(TRAFFIC_DIRECTION_MAX >
+                    BITS_PER_TYPE(typeof_member(struct mm_rsrc_mgmt_notif_=
policy,
+                                                direction_mask)));
+
+       cl_dbg_trace(cl_hw, "RSRC MGMT Init: sizeof(req):%zu, sizeof(ind):%=
zu, sizeof(cfm):%zu\n",
+                    sizeof(struct mm_rsrc_mgmt_req),
+                    sizeof(struct mm_rsrc_mgmt_ind),
+                    sizeof(struct mm_rsrc_mgmt_cfm));
+}
+
+/*
+ * Direction: DRV -> FW: Requests/Notifications
+ */
+void cl_rsrc_mgmt_traffic_start(struct cl_hw *cl_hw, enum cl_traffic_level=
 level,
+                               enum cl_traffic_direction direction)
+{
+       u8 event_type =3D MM_RSRC_MGMT_TRAFFIC_START;
+       u8 active_sta_cnt =3D cl_hw->traffic_db.num_active_sta_dir[directio=
n][level];
+
+       if (!must_notify(cl_hw, event_type, active_sta_cnt))
+               return;
+
+       cl_msg_tx_rsrc_mgmt_traffic_event(cl_hw, event_type, level, directi=
on,
+                                         active_sta_cnt);
+}
+
+void cl_rsrc_mgmt_traffic_stop(struct cl_hw *cl_hw, enum cl_traffic_level =
level,
+                              enum cl_traffic_direction direction)
+{
+       u8 event_type =3D MM_RSRC_MGMT_TRAFFIC_STOP;
+       u8 active_sta_cnt =3D cl_hw->traffic_db.num_active_sta_dir[directio=
n][level];
+
+       if (!must_notify(cl_hw, event_type, active_sta_cnt))
+               return;
+
+       cl_msg_tx_rsrc_mgmt_traffic_event(cl_hw, event_type, level, directi=
on,
+                                         active_sta_cnt);
+}
+
+void cl_rsrc_mgmt_rates_update(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       u8 event_type =3D MM_RSRC_MGMT_RATES_UPDATE;
+       u8 active_sta_cnt =3D cl_traffic_num_active_sta(cl_hw);
+
+       if (!must_notify(cl_hw, event_type, active_sta_cnt))
+               return;
+
+       cl_msg_tx_rsrc_mgmt_rates_event(cl_hw, event_type, cl_sta);
+}
+
+void cl_rsrc_mgmt_process_cfm(struct cl_hw *cl_hw, struct mm_rsrc_mgmt_cfm=
 *cfm)
+{
+       cl_dbg_trace(cl_hw, "CFM: subtype:%s(%u), status:%d\n",
+                    subtype2str(cfm->subtype), cfm->subtype, cfm->status);
+}
+
+/*
+ * DRV <- FW: Indications processings
+ */
+static void process_env_change(struct cl_hw *cl_hw, enum cl_env_type type)
+{
+       cl_env_det_set_type(cl_hw, type);
+}
+
+static void process_notif_policy(struct cl_hw *cl_hw, u8 subtype,
+                                struct mm_rsrc_mgmt_notif_policy *np)
+{
+       struct cl_rsrc_mgmt_db *db =3D &cl_hw->rsrc_mgmt_db;
+
+       cl_dbg_trace(cl_hw, "[%s(%u)] enabled:%u, sta.low_th:%d, sta.high_t=
h:%d\n",
+                    subtype2str(subtype), subtype, np->enabled,
+                    np->active_sta.low_th, np->active_sta.high_th);
+
+       if (subtype < ARRAY_SIZE(db->notif_policies))
+               db->notif_policies[subtype] =3D *np;
+       else
+               cl_dbg_err(cl_hw, "Invalid subtype index:%s(%u)\n",
+                          subtype2str(subtype), subtype);
+}
+
+static void process_action_hint(struct cl_hw *cl_hw, uint16_t target, uint=
8_t action)
+{
+       int rc =3D 0;
+
+       cl_dbg_info(cl_hw, "Processing hint: target - %s(%u), action - %s(%=
u)\n",
+                   control2str(target), target, action2str(action), action=
);
+
+       switch (target) {
+       case MM_RSRC_MGMT_OF_TX_AMSDU:
+               switch (action) {
+               case MM_RSRC_MGMT_ACTION_ENABLE:
+                       cl_hw->txamsdu_en =3D 1;
+                       break;
+               case MM_RSRC_MGMT_ACTION_DISABLE:
+                       cl_hw->txamsdu_en =3D 0;
+                       break;
+               case MM_RSRC_MGMT_ACTION_RESTORE_DEFAULT:
+                       cl_hw->txamsdu_en =3D cl_hw->conf->ce_txamsdu_en;
+                       break;
+               default:
+                       rc =3D -EOPNOTSUPP;
+               };
+               break;
+       case MM_RSRC_MGMT_OF_RX_AMSDU:
+               switch (action) {
+               case MM_RSRC_MGMT_ACTION_ENABLE:
+                       cl_rx_amsdu_hw_en(cl_hw->hw, true);
+                       break;
+               case MM_RSRC_MGMT_ACTION_DISABLE:
+                       cl_rx_amsdu_hw_en(cl_hw->hw, false);
+                       break;
+               case MM_RSRC_MGMT_ACTION_RESTORE_DEFAULT:
+                       cl_rx_amsdu_hw_en(cl_hw->hw, cl_hw->conf->ce_rxamsd=
u_en);
+                       break;
+               default:
+                       rc =3D -EOPNOTSUPP;
+               };
+               break;
+       case MM_RSRC_MGMT_OF_PROT_MODE:
+               switch (action) {
+               case MM_RSRC_MGMT_ACTION_ENABLE:
+                       cl_prot_mode_enable(cl_hw);
+                       break;
+               case MM_RSRC_MGMT_ACTION_DISABLE:
+                       cl_prot_mode_disable(cl_hw);
+                       break;
+               case MM_RSRC_MGMT_ACTION_RESTORE_DEFAULT:
+                       cl_prot_mode_restore_default(cl_hw);
+                       break;
+               default:
+                       rc =3D -EOPNOTSUPP;
+               };
+               break;
+       case MM_RSRC_MGMT_OF_CCA:
+               switch (action) {
+               case MM_RSRC_MGMT_ACTION_DISABLE:
+                       cl_msg_tx_config_cca(cl_hw, false);
+                       break;
+               case MM_RSRC_MGMT_ACTION_ENABLE:
+               case MM_RSRC_MGMT_ACTION_RESTORE_DEFAULT:
+                       cl_msg_tx_config_cca(cl_hw, true);
+                       break;
+               default:
+                       rc =3D -EOPNOTSUPP;
+               };
+               break;
+       default:
+               rc =3D -EOPNOTSUPP;
+               break;
+       };
+
+       if (rc) {
+               cl_dbg_err(cl_hw, "Hint process failure, rc:%d [%s(%u):%s(%=
u)]\n",
+                          rc, control2str(target), target, action2str(acti=
on),
+                          action);
+       }
+}
+
+void cl_rsrc_mgmt_process_ind(struct cl_hw *cl_hw, struct mm_rsrc_mgmt_ind=
 *ind)
+{
+       switch (ind->subtype) {
+       case MM_RSRC_MGMT_ACTION_HINT:
+               process_action_hint(cl_hw,
+                                   le16_to_cpu(ind->u.action_hint.target),
+                                   ind->u.action_hint.action);
+               break;
+       case MM_RSRC_MGMT_ENV_CHANGE:
+               process_env_change(cl_hw, ind->u.env_event.state);
+               break;
+       case MM_RSRC_MGMT_NOTIF_POLICY_SET:
+               process_notif_policy(cl_hw,
+                                    ind->u.notif_policy_set.subtype,
+                                    &ind->u.notif_policy_set.settings);
+               break;
+       case MM_RSRC_MGMT_STATS:
+       case MM_RSRC_MGMT_CONFIG_QUERY:
+       case MM_RSRC_MGMT_MAX:
+       default:
+               cl_dbg_err(cl_hw, "Invalid subtype %s(%u)\n",
+                          subtype2str(ind->subtype), ind->subtype);
+               break;
+       }
+}
+
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

