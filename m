Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D883AB8EE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhFQQLQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:11:16 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:39392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233518AbhFQQKJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5mg//bJcEdZCJREYSsWoWVSq9alaN/kosL8YuC51uogv3HFcD/mln5FvGo2cfs/t9c4UlG5im5CLR2YBzgwkGr5h1amGNn5Elxys2IVgOS2lvsGOrHXEiisPP2NOU3FxbeISvH7SkWSU5nIQFdiJq1AIssY43ljPECypOZ3hykg//ReU5t0ilWW3YsjnXQ6dgP2yFJ28JUyKun7JzQARvS9324H9n+Xq+yRqT2tjf3aao3qcz+QlMRbhDFYPMzOfk+rLuLEwlSwcWbv/qUYjUsjCNYHIhq8AhAvl9Z/2GTTj89+dvErqBD76m5DzZZV91Y8Dyqx4Ar9VGbPizAt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0mtNDgIIa7mlN7m24ajN9C4usaMGv70GrroYgZWgHo=;
 b=dVArjbFUllwC2PYUaEmCHY2fAlZnHobIV2OfllKa4ZADhk4bhNegKpn0VKAh5E48kZLzeW2+OIUwy3LdF4feoC2c1D+AkaAi6Qc7DIqwQy8Rep+fBctobXBZV8mjpfkbD4S2MnqazyHfugNCysMi6iV+ay0vMaxxrTfkKd28S/Hww2rcpKRSNpu71bZciRyJKxTs1m7bbMYbPpmocMOvm0p12DvzfJniKRVNB3THxhgOmo/ahTooP7u/4igbI80mZThiTOaEeFv0ctpcGxQd6ik9Qn5om8If/mePeL907QPeDPHzdq2zeuAZl8sbMiWqbgAff6I/5iUb7cl+sarang==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s0mtNDgIIa7mlN7m24ajN9C4usaMGv70GrroYgZWgHo=;
 b=3gx0DMhdXDcBXtStNxFEXWpmjq+n8oJhG4UCKzPefEZpZ0Tii5qmI66gKzCY8BUhKGFUhfTjFMctQcVfKeJLju/AOLk41ucgJPccwUBIY7d/M98ytJggpEsNpPWUzdNwn890Z5hI/puJgGaj2qM9G1PPpk5v2o24jWIBVBZ2u2o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:14 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:14 +0000
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
Subject: [RFC v1 196/256] cl8k: add twt_cli.c
Date:   Thu, 17 Jun 2021 16:01:23 +0000
Message-Id: <20210617160223.160998-197-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2cdf8d0b-3578-4184-36e3-08d931a9d327
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075F178C5ADD281B44FC55BF60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u+E5Qijf6MS+qZvHFIDL7uVBfzYcebi9tqQM/blaTjH2AsZz/XYi41gx/4JzeBImdNi4AXyU2t99FQghMP5u3EM44ZYODk7291UR/O8z/7bZP9xBIxpSSd4OCBn28Eb4f/ueFMY0Z9z2z1WTRmZLzSqGGoyLz5zLeEvyJFGystLtS27Hgd7yK2FeonxTrIUghDcLPAGkgo5BoJbEUFRED2VKwQznLKHdSGne+rgUeD1HwaU25hl1w/6XMUVbLWpz3QA2+0/I0xJMvNHe2YYogvFFxs/b0VkmKgCjmszLRx2dfAEqEH7xN/uu143tqcyrqWHzAWTN2jcQbnvr79GXwPCk3HkTxTp5YZrz7geEsZs9K8d304d/LHlhisfUqKvMzATx6UiDsLoFdx0qqdMKZRxMzwxThkM+UJ4q8PCD+CAvrWlwEhAxuD8n3+6vxneIGhZLQUgY0kp9jBJ/PoejK0KqeByWqaejJSg3+rX6BSuGJskBKgQHtue/1kbN1r0tMfQZODzqnSgocvK5IFHyo2qyKL8ClUEXtk/KjiH52/qv/qD68CujjvhMg6/QEFG4Ljse3noJk9ePq/XEEQx/z+jRSeKyXO75CSTT6iXzmjDjhPXapcMM0PLMRDvc2RPEAzYIyNPCtzUI+auFxXQYWIlDGR9/zAaq1/PwHqr9WaGjRQoYwNdNYrxkr9oGoT+VipPd26gir057X9QNRBX1zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(30864003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EVgcpVC8R8djx2PuVtb2gdtbBvAAIssT9yDZwE9wsT1kAuj/EEiGi6ulbqTK?=
 =?us-ascii?Q?cITI6+v9P5eGv/Sk4VQfQD3srFvGTe7rbskJc/MGDuontd7hALx2Av93ghV/?=
 =?us-ascii?Q?fijUfZkkm2+GiC5TFtjpzv2UNL6ih3F+E0QV7srOrolflmN3Yzpzq1T4bMzG?=
 =?us-ascii?Q?tQNU0RGlBdv4zKWV04G8XZW/y4LlVRGs//APx0dQ6Xtlt6qGiywerUvRKSZe?=
 =?us-ascii?Q?60iCffsYb4LfmLCtIgmo2CWAubWSw/8LDA63OGU+WyB/0v9fRlyfoQwdygtK?=
 =?us-ascii?Q?m6+L+wK+ikCRDsNNtygQvfZ/pt5c5Pk/+6sE1HfzDZyrpAdEvypQ52YUIj22?=
 =?us-ascii?Q?Q1IH8kFIPKlfZ53mj3rbFTaVxQL8htNXAcfxnBB+Ac8XlvPvPvg4PsSdmuBK?=
 =?us-ascii?Q?eLkuwNM5GDU5H2JnqaZsan0aGcG9aJyV7gXM7G6ic9USk/M1N+DdFQltkbto?=
 =?us-ascii?Q?c1zWVom16Tkf9Lm5xVKt2G+2ktu1Yqp96QUBrcz3ks3fsPcvZUsvuhxnFmSV?=
 =?us-ascii?Q?QH7XuaxQcxSgtKIWrS2Iml91MYf9DJBjsf/juSb4TyX7imdY2vQajHmq0QGM?=
 =?us-ascii?Q?kMcpS7uFCcdWTv3Ni9zBX5271j1LyMK3w4ZVv9zWa7KckDwZbHfCU/ar1U7x?=
 =?us-ascii?Q?IvFm43+5RIeRJUSDYiJ8744Ee96qLRr9xizSYC3xFNKBaDXxL9g7j2tVff9y?=
 =?us-ascii?Q?Gv4w8nJF2s80+fQTqv0PkVC9vCUEKsazD/9gnNZw4VvUnt+m5TRxOcdF70C4?=
 =?us-ascii?Q?2rbRmrP4vrgJQJe4rojAqf3NAVdhNSHuUvfQw6l78SPkPyqGJ61H/ML5v73t?=
 =?us-ascii?Q?H/YqRE4ISS6QheZsVcLMty7V1lbPqB0gnGAmyzfNxFdYMZCTBKpZqYCatigW?=
 =?us-ascii?Q?62l+LcvcKwJ2kLa3Nf7txrigg472musUOSEFH3fgYS3V5rEwxly8QJw3Es4a?=
 =?us-ascii?Q?4Uel3mrSgUWIhpSDd3IssT7yKjJQQGgXzNyqwlFsB5HeZ1k1T6jsn0ofu9Fy?=
 =?us-ascii?Q?ZXkg7xhyYMBZtrt/1rTWdMLWiQA5nnBOUunldN3Kd+os2UgtscQkSSLpj96O?=
 =?us-ascii?Q?QOScAsAg6w7oDtt75C7ShFX7nxKLQW7gcwMiJ/8USYTOP4KqbQzCPc8mmeLW?=
 =?us-ascii?Q?PInkjDVGCz9LsqbTMi4NrG8xiLEWXZLzxMm1zCGWymLc6sSsmpGbjVFzgI6K?=
 =?us-ascii?Q?fdvDcDYxyQtMBuxVusQoVoa4OgryU/u9lFEEr6pUPqcn1uznoSzJUMpbPVbI?=
 =?us-ascii?Q?NKO/2F2gccnDd5zZiCaauznRHXdUPTct64XFsIGqJYYAlc9WrLVm0I5o9pYW?=
 =?us-ascii?Q?B8GXc63sf/2sanfgDepc/rbj?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cdf8d0b-3578-4184-36e3-08d931a9d327
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:11.3802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SNgtpKFH8GpnXzNFlYmAMwIX1VQNdm6ME/0sTWnu89nzYqdbc8t4kqyQxw28O/whh9t63iEn6doFfhjPqm9hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/twt_cli.c | 359 +++++++++++++++++++++
 1 file changed, 359 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt_cli.c

diff --git a/drivers/net/wireless/celeno/cl8k/twt_cli.c b/drivers/net/wirel=
ess/celeno/cl8k/twt_cli.c
new file mode 100644
index 000000000000..258df0c83c48
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/twt_cli.c
@@ -0,0 +1,359 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "twt_cli.h"
+#include "twt.h"
+#include "twt_frame.h"
+#include "sta.h"
+#include "utils/utils.h"
+
+#define CL_TWT_MIN_WAKE_DURATION_MAX_VAL_US (0xFFU << 10)
+
+static int cl_twt_cli_configuration_print(struct cl_hw *cl_hw)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TWT configuration:\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TWT enabled:                   %u\n",
+                   conf->ce_twt_en);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TWT default interval:          %u\n",
+                   conf->ce_twt_default_interval);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TWT default min wake duration: %u\n",
+                   conf->ce_twt_default_min_wake_duration);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TWT num of sessions:           %u\n",
+                   cl_hw->twt_db.num_sessions);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "TWT max sessions:              %u\n",
+                   conf->ce_twt_max_sessions);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_twt_cli_sessions_print(struct cl_hw *cl_hw)
+{
+       u8 i, handled_sessions =3D 0, num_sessions =3D cl_hw->twt_db.num_se=
ssions;
+       u8 max_sessions =3D cl_hw->conf->ce_twt_max_sessions;
+       struct cl_twt_session_db *session;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "-----------------------------------------------------"
+                   "---------------------------------\n"
+                   "| STA idx | Flow id | Announced | Triggered | "
+                   "Interval us | Min wake    | Start time |\n"
+                   "|         |         |           |           |        "
+                   "     | duration us |            |\n");
+       for (i =3D 0, session =3D &cl_hw->twt_db.cl_twt_sessions[0];
+            (i < max_sessions) && (handled_sessions < num_sessions);
+            i++, session++) {
+               if (!session->cl_sta)
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "+---------+---------+-----------+-----------+"
+                           "-------------+-------------+------------+\n"
+                           "|   %3u   |    %1u    |     %1u     |     %1u"
+                           "     | %10llu  |   %6u    | %10llu |\n",
+                           session->cl_sta->sta_idx,
+                           session->twt_setup.req_type.fields.flow_id,
+                           !(session->twt_setup.req_type.fields.flow_type)=
,
+                           session->twt_setup.req_type.fields.trigger,
+                           cl_twt_get_wake_interval_us(&session->twt_setup=
),
+                           cl_twt_get_min_wake_time_us(&session->twt_setup=
),
+                           session->twt_setup.target_wake_time);
+               handled_sessions++;
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "-----------------------------------------------------"
+                   "---------------------------------\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_twt_cli_send_individual_setup_request(struct cl_hw *cl_hw,
+                                                   struct cli_params *cli_=
params,
+                                                   bool simulate)
+{
+       u8 sta_idx =3D (u8)cli_params->params[0];
+       u8 setup_cmd =3D (u8)cli_params->params[1];
+       u8 flow_id =3D (u8)cli_params->params[2];
+       bool announced =3D (bool)cli_params->params[3];
+       bool triggered =3D (bool)cli_params->params[4];
+       u32 interval =3D (u32)cli_params->params[5];
+       u32 min_wake_dur =3D (u32)cli_params->params[6];
+       struct cl_sta *cl_sta;
+       int res =3D -1;
+
+       if (!cl_twt_is_enabled(cl_hw)) {
+               cl_dbg_verbose(cl_hw, "Please enable TWT first\n");
+               return -1;
+       }
+
+       cl_sta_lock_bh(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+       if (!cl_sta) {
+               cl_dbg_err(cl_hw, "Invalid sta idx %u\n", sta_idx);
+               goto out;
+       }
+
+       if (setup_cmd > IEEE80211_TWT_SETUP_COMMAND_DEMAND) {
+               cl_dbg_verbose(cl_hw,
+                              "Invalid setup cmd %u. Must be lower than %u=
\n",
+                              setup_cmd, IEEE80211_TWT_SETUP_COMMAND_DEMAN=
D);
+               goto out;
+       }
+
+       if (flow_id > CL_TWT_FLOW_ID_MAX) {
+               cl_dbg_verbose(cl_hw,
+                              "Invalid flow id %u. Must be lower than %u\n=
",
+                              flow_id, CL_TWT_FLOW_ID_MAX);
+               goto out;
+       }
+
+       if (min_wake_dur > CL_TWT_MIN_WAKE_DURATION_MAX_VAL_US) {
+               cl_dbg_verbose(cl_hw,
+                              "Invalid min wake duration (%u). Must be no =
greater than %u\n",
+                              min_wake_dur, CL_TWT_MIN_WAKE_DURATION_MAX_V=
AL_US);
+               goto out;
+       }
+
+       if (min_wake_dur > interval) {
+               cl_dbg_verbose(cl_hw,
+                              "Min wake duration (%u) cannot be greater th=
an interval (%u)\n",
+                              min_wake_dur, interval);
+               goto out;
+       }
+
+       cl_dbg_info(cl_hw,
+                   "sta_idx %u, setup_cmd %u, flow_id %u, announced %u, "
+                   "triggered %u, interval %u, min wake duration %u\n",
+                   sta_idx, setup_cmd, flow_id, announced, triggered, inte=
rval, min_wake_dur);
+
+       if (simulate)
+               res =3D cl_twt_frame_simulate_individual_setup_request(cl_h=
w, cl_sta,
+                                                                    setup_=
cmd, flow_id,
+                                                                    announ=
ced, triggered,
+                                                                    (u64)i=
nterval, min_wake_dur);
+       else
+               res =3D cl_twt_frame_send_individual_setup_request(cl_hw, c=
l_sta, setup_cmd,
+                                                                flow_id, a=
nnounced, triggered,
+                                                                (u64)inter=
val, min_wake_dur);
+
+out:
+       cl_sta_unlock_bh(cl_hw);
+
+       return res;
+}
+
+static int cl_twt_cli_send_individual_teardown_request(struct cl_hw *cl_hw=
,
+                                                      struct cli_params *c=
li_params,
+                                                      bool simulate)
+{
+       u8 sta_idx =3D (u8)cli_params->params[0];
+       u8 flow_id =3D (u8)cli_params->params[1];
+       struct cl_sta *cl_sta;
+       int res =3D 0;
+
+       if (!cl_twt_is_enabled(cl_hw)) {
+               cl_dbg_verbose(cl_hw, "Please enable TWT first\n");
+               return -1;
+       }
+
+       cl_sta_lock_bh(cl_hw);
+       cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+
+       if (!cl_sta) {
+               cl_dbg_err(cl_hw, "Invalid sta idx %u\n", sta_idx);
+               res =3D -1;
+               goto out;
+       }
+
+       if (flow_id > CL_TWT_FLOW_ID_MAX && flow_id !=3D CL_TWT_FLOW_ID_ALL=
) {
+               cl_dbg_verbose(cl_hw,
+                              "Invalid flow id %u. Must be lower than %u o=
r %u\n",
+                              flow_id, CL_TWT_FLOW_ID_MAX, CL_TWT_FLOW_ID_=
ALL);
+               res =3D -1;
+               goto out;
+       }
+
+       if (simulate) {
+               res =3D cl_twt_frame_simulate_individual_teardown_request(c=
l_hw, cl_sta, flow_id);
+       } else {
+               /*
+                * If the session doesn't exist or couldn't be removed -
+                * send a teardown request anyway
+                */
+               if (cl_twt_teardown_individual_sesseion(cl_hw, cl_sta, flow=
_id, true))
+                       cl_twt_frame_send_individual_teardown_request(cl_hw=
, cl_sta, flow_id);
+       }
+
+out:
+       cl_sta_unlock_bh(cl_hw);
+
+       return res;
+}
+
+static void cl_twt_cli_enable(struct cl_hw *cl_hw, bool enable)
+{
+       if (cl_hw->conf->ce_twt_en =3D=3D enable) {
+               pr_debug("TWT is already %s\n", enable ? "enabled" : "disab=
led");
+               return;
+       }
+
+       cl_hw->conf->ce_twt_en =3D enable;
+
+       if (enable)
+               cl_twt_init(cl_hw);
+       else
+               cl_twt_close(cl_hw);
+
+       pr_debug("TWT has been %s\n", (enable ? "enabled" : "disabled"));
+}
+
+static int cl_twt_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "twt usage\n"
+                "-c: Print configuration\n"
+                "-e: Enable/Disable TWT [0 - disable, 1 - enable]\n"
+                "-m: Simulate a reception of a TWT individual request:\n"
+                       "\t[sta_idx].[setup_cmd (0:request, 1:suggest, "
+                       "2:demand)].[flow_id (0-7))].[announced].[triggered=
]."
+                       "[interval].[min_wake_duration]\n"
+                "-n: Simulate a reception of a TWT individual teardown "
+                       "request:\n\t[sta_idx].[flow_id (0-7; 255 all_twt)]=
\n"
+                "-p: Print sessions\n"
+                "-s: Send a TWT individual setup request:\n"
+                       "\t[sta_idx].[setup_cmd (0:request, 1:suggest, "
+                       "2:demand)].[flow_id (0-7))].[announced].[triggered=
]."
+                       "[interval].[min_wake_duration]\n"
+                "-t: Send a TWT individual teardown request:\n"
+                       "\t[sta_idx].[flow_id (0-7; 255 for all_twt)]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_twt_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool print_conf =3D false;
+       bool enable =3D false;
+       bool simulate_req =3D false;
+       bool simulate_teardown =3D false;
+       bool print_sessions =3D false;
+       bool send_req =3D false;
+       bool send_teardown =3D false;
+
+       switch (cli_params->option) {
+       case 'c':
+               print_conf =3D true;
+               expected_params =3D 0;
+               break;
+       case 'e':
+               enable =3D true;
+               expected_params =3D 1;
+               break;
+       case 'm':
+               simulate_req =3D true;
+               expected_params =3D 7;
+               break;
+       case 'n':
+               simulate_teardown =3D true;
+               expected_params =3D 2;
+               break;
+       case 'p':
+               print_sessions =3D true;
+               expected_params =3D 0;
+               break;
+       case 's':
+               send_req =3D true;
+               expected_params =3D 7;
+               break;
+       case 't':
+               send_teardown =3D true;
+               expected_params =3D 2;
+               break;
+       case '?':
+               return cl_twt_cli_help(cl_hw);
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
+       if (print_conf)
+               return cl_twt_cli_configuration_print(cl_hw);
+
+       if (enable) {
+               cl_twt_cli_enable(cl_hw, (bool)cli_params->params[0]);
+               return 0;
+       }
+
+       if (simulate_req) {
+               int res =3D cl_twt_cli_send_individual_setup_request(cl_hw,=
 cli_params, true);
+
+               if (res)
+                       cl_dbg_verbose(cl_hw, "Error %d trying to simulate =
TWT request\n", res);
+
+               return 0;
+       }
+
+       if (simulate_teardown) {
+               cl_twt_cli_send_individual_teardown_request(cl_hw, cli_para=
ms, true);
+               return 0;
+       }
+
+       if (print_sessions)
+               return cl_twt_cli_sessions_print(cl_hw);
+
+       if (send_req) {
+               int res =3D cl_twt_cli_send_individual_setup_request(cl_hw,=
 cli_params, false);
+
+               if (res)
+                       cl_dbg_verbose(cl_hw, "Error %d trying to send TWT =
request\n", res);
+
+               return 0;
+       }
+
+       if (send_teardown) {
+               cl_twt_cli_send_individual_teardown_request(cl_hw, cli_para=
ms, false);
+               return 0;
+       }
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

