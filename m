Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABE3AB8CB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbhFQQKi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:38 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:35227
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232260AbhFQQJi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUVKJJ+tdRKPQFUcy4UTyKQGwG2LmQKhBKxutUfqHLA06b7c/ydc4Cds7wZNfCWiblS2qn2Rbifg+YK+u67dnQr+R0J6IMlzDb+qkOKLqjYPC9rhJYOJ5423uqU+IRRB1zIEFwq42pHNxiizYWDOk5kboK1U4BOQbincF1/9kguMdBAd7E8gNDrd1Au9Bz/luVereercM1YYIwKszGKCLuP902XUYPusdwpLwXVQ2D9eMp43RH/yTY+VbUwNQVy6VcDOeYRFXdOwokhVWbrj9di6xlOt9toT0zAybmRC/Axtz7olHRCEYvysgrUnB80GYYgw9aR8tdNYnpJo9YhxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsWRjZJb+uW52iv0vYy9ONA6d20qhL3iipvwH1Fv7HE=;
 b=nsvJfOrSTyspYS45jg4/b/NZ9QARCZOdJaenfuLH3mmIJh5uC7itvuLEqy+IcEoUHR5/usBuRH3z5yVtZuQdxNe0zJTdb/ToghnNi2aja+HwrWZlV7Pd776W461F9Xsc21iJu3WF8Sc9oFS51vCJhkDVCXs7KuGTkbnau7GRrtXIO8iK8XD+oEK3d1E2G0wTJZAMSjdemcx2u9ZfrxMk4eexqrjYOTpeW1VKkhBKbCuyZfBqggG9R7m4DSzPRoZ6KNiFVIUKmH+N/mljR4w6v9HUDtLBJE2noKjYAMrE3IIzithhsHIjJF2a3I3QxRwwxjOKHUdpDox+vg1zMuhcWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rsWRjZJb+uW52iv0vYy9ONA6d20qhL3iipvwH1Fv7HE=;
 b=gYvGKPxcTVXG3CUO4/u9DgIAfY9kf4drFf5cltsUN8svCIGlatQwGzWBUq7p9q+IJkj8/fHbgQN8mPCXHND+BSKVPunyj8oeqNhgdcCAGoVJwXtOmTl6bb3dCsxu3ZPLZcn24l8p+uVxgS4NpwAhs2JWgl9R3eizFWVP22dOAgo=
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
Subject: [RFC v1 194/256] cl8k: add twt.c
Date:   Thu, 17 Jun 2021 16:01:21 +0000
Message-Id: <20210617160223.160998-195-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 656efcc8-d04f-4d7b-44e1-08d931a9d1e7
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075EAEB329F47B3D3A74D74F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aKmhd0Pj5AR+X3QsbBFcZcXCcC7J0fwixWEuLVg/H199MpMjPiQLr8RQ5GyE3jlEm/sgodxvjHvPps9nRRfFmoc7/4NQjKnd3ZYe9PewhyJPiUMy5KLOblNQkt6JV/86h5UDwfaBeqkEhHYVK3T7RdvmZrjuvjCXXGfnHe1mV1JAuyXpQQ8JPxPWnGuzC6cZkJr+al9FuMWyXUu1GW7idH7euPg/DTrSLBDgEHhT1SGzYeaGyKytyNX3YbC/q5ISAL1xfCgLZADPWP8OyIJI58ZTtv8/3QYSunr3dSiFvZNcenBwVaVDb5eLLYAW8GEYiBuoW9NRfnCWnTascWO5/0tDgPhTbrx2DMiidm9JqLxYBTgg3WNB2ahZRAJdK+4Q0qyknFjkLfLo3C3uRi6EaC0T/8OIesZHvqafRnHcEd1VzTo53nkRikx+Ed9eBrgCKLNw/H+PvBoIerksmg27A1jeGdOTX3Cj+DvWU/o4e/UFsbf6n+1T/t2rLf0ict65hkygwgcdfsmdjVIK0WeULPMCKhOEjve4THZKRhODP9Y9lrj1xzgKSAAwclDL0qGZx2qBAazq53lVWDX418CIuQ7bm+OvRh5vn1CwSoTPva9HptoUbCtawqEtLJxUa/hdHyB59pEnzFo6UbiY14/ZJQxp3NBYsHvxyvJZ1psKn9LkKuWy8WyNLyqYfa3z0PfI3gzG/Lpz6396q8urpzsQqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(30864003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeKxopk4SdGO84wov4htgRAfudfp3dRI4po+HHTq4LcyCf1wMLZPp8bwZZbc?=
 =?us-ascii?Q?aS82NrMn4tJ/9xoCYyraS86OuqE04vMe6z0ulwUP7x/WtgcGEredJR3yLX1h?=
 =?us-ascii?Q?vrGFrb3AwlwbVLOJS4mX1CiWXySpwVddf19trWh/FaujSmqq8ub3DZADYglb?=
 =?us-ascii?Q?rBi2e/ZGcUs5rQ8//3Y1noXDT/y0skrmYj0RAzEixWOetPNxUz3qTSbP+OLo?=
 =?us-ascii?Q?g46spLMYdCkZcXConilZHp/7DUcTaNTKHEwSpAUOP1XhWEYK3Z9tfFC682Ut?=
 =?us-ascii?Q?ZayPSfuFBqJizcT1QWlMdYSChX/vfeozFuWm8QrGbW6ttdCsnyjvhIaUbdwX?=
 =?us-ascii?Q?GldWftwqUwqIwDFrIXgXlRr/FuTJhp4D6fmm6P0xGeY7GsWgNc44kWfLZ5/N?=
 =?us-ascii?Q?nDCRaWdeqLdfFk0I/0+lDnFs+1OKRo3h8I14h6bYWMg+CdJ515Px5y88A1tT?=
 =?us-ascii?Q?fofALLBMJIQ4CIaKwXq+dODIvTDygugoiO3s+y9UKFZ0hAaGpZHgpWdNnzE7?=
 =?us-ascii?Q?Dp6Kd4xUzh/WPep8LAlMisYCJb66dKd8FCLuM0CFnD9fY1cpOcpu/bDYierY?=
 =?us-ascii?Q?7PQwPCM8yKCIfZ8+7vGtF6d0xL53joAVS/UunPSl0OfjGpFkB+U3ot4xnvnz?=
 =?us-ascii?Q?OX4EuxUNhZh1kc4Tsw44uvXmRgfCgF8FjQ5cqv/Jn1h6Knlt+9Qh+hdhkmmn?=
 =?us-ascii?Q?Gq/+ZR93GXCdu13TZVlAt7O6hgqcPBdcGRqXrFLvhyZJQqBM5JFoMX24iecS?=
 =?us-ascii?Q?aF/z29XueTogNjkwZNirYGO9/Tw5sTqKo2hr3HbUDM05Pplo4FxDg2WHyZ3c?=
 =?us-ascii?Q?Z3DOITs+OLAB5X2V7K8HVDiLun9Zf5bd1ANFdNpRAIv35D4s5dpHuqox+Fhg?=
 =?us-ascii?Q?yTUD45NLyHrA4cOBuVG3u2i2Bp9T82sU/7sUc9IVQc0XxZLBo/rl6Yn2Hgay?=
 =?us-ascii?Q?1dGOZVWJO4wmC4UgbpWYukwePUzXJSBMoFNBoeaq8EQd2qisJOHd18A4fvRf?=
 =?us-ascii?Q?Nic9lbScDLNwrGv+oyz2VF2q7qxJpcCUIRLYZtrDbomaWY12itGP8yds7oMB?=
 =?us-ascii?Q?27pmHM5VWnKlc4YAmSILkkatIQ+H/cReBu3V7W+2+ccOGiECXqsnGl7KnATv?=
 =?us-ascii?Q?z1sYK7dlQsw+4EwUHbcH8TiJRlSrHKmjOEl8ysuFPpySzEiUG4NRvBXSTtL6?=
 =?us-ascii?Q?K6GugXmsCMk3bw+TQ0YOseon4BOjVK2rtEu17ht3jjpMOsqUqFJ674ntNl8L?=
 =?us-ascii?Q?T6Z8W9k1gQkk4JiFZF4jIA2hRu73DHJR/7wYWIDZN2+PaxDMJ2YO1OYmCUZR?=
 =?us-ascii?Q?KjcHKAQnOHtlC9PVQqMw7u0+?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656efcc8-d04f-4d7b-44e1-08d931a9d1e7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:09.2784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mz9rYFsT3VAUto9BdpFmhE6EEgBCVeB9koywccdITdVj5lk8Cmn+WrG5wg2n7Ff1vzVljwtChN1rg+fSr6m+Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/twt.c | 455 +++++++++++++++++++++++++
 1 file changed, 455 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/twt.c

diff --git a/drivers/net/wireless/celeno/cl8k/twt.c b/drivers/net/wireless/=
celeno/cl8k/twt.c
new file mode 100644
index 000000000000..3a601c1a3fb7
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/twt.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "twt.h"
+#include "twt_frame.h"
+#include "fw/msg_tx.h"
+#include "sta.h"
+#include "utils/utils.h"
+
+#define CL_TWT_CONST_TARGET_WAKE_TIME_OFFSET_US 500000
+#define WIFI_AWARE_TARGET_WAKE_TIME_MASK        ~0xFULL
+
+struct cl_next_start_time {
+       struct cl_twt_session_db *session;
+       u64 time;
+};
+
+static struct cl_twt_session_db *cl_twt_get_free_session(struct cl_hw *cl_=
hw)
+{
+       u8 i, max_sessions =3D cl_hw->conf->ce_twt_max_sessions;
+       struct cl_twt_session_db *session;
+
+       for (i =3D 0, session =3D &cl_hw->twt_db.cl_twt_sessions[0];
+            i < max_sessions;
+            i++, session++)
+               if (!session->cl_sta)
+                       return session;
+
+       return NULL;
+}
+
+static void cl_twt_remove_session_by_params(struct cl_hw *cl_hw,
+                                           struct cl_sta *cl_sta,
+                                           u8 flow_id,
+                                           bool send_teardown_req)
+{
+       u8 i, handled_sessions =3D 0, num_sessions =3D cl_hw->twt_db.num_se=
ssions;
+       u8 max_sessions =3D cl_hw->conf->ce_twt_max_sessions;
+       struct cl_twt_session_db *session;
+
+       /* If flow_id =3D=3D CL_TWT_FLOW_ID_INVALID then we'd like to remov=
e all the sessions of STA */
+       bool remove_all_flows =3D (flow_id =3D=3D CL_TWT_FLOW_ID_ALL);
+
+       for (i =3D 0, session =3D &cl_hw->twt_db.cl_twt_sessions[0];
+            (i < max_sessions) && (handled_sessions < num_sessions);
+            i++, session++) {
+               if (session->cl_sta =3D=3D cl_sta &&
+                   (remove_all_flows ||
+                    session->twt_setup.req_type.fields.flow_id =3D=3D flow=
_id)) {
+                       cl_twt_remove_session(cl_hw, session, send_teardown=
_req);
+
+                       if (!remove_all_flows)
+                               break;
+
+                       handled_sessions++;
+               }
+       }
+}
+
+static void cl_twt_remove_all_sta_sessions(struct cl_hw *cl_hw,
+                                          struct cl_sta *cl_sta,
+                                          bool send_teardown_req)
+{
+
+       if (send_teardown_req)
+               cl_twt_frame_send_individual_teardown_request(cl_hw, cl_sta=
, CL_TWT_FLOW_ID_ALL);
+
+       cl_twt_remove_session_by_params(cl_hw, cl_sta, CL_TWT_FLOW_ID_ALL, =
false);
+}
+
+static u64 cl_twt_get_next_start_time(struct cl_hw *cl_hw,
+                                     struct cl_twt_session_db *session,
+                                     u64 tsf)
+{
+       struct ieee80211_twt_individual_elem *elem =3D &session->twt_setup;
+       u64 start_time =3D elem->target_wake_time;
+       u64 interval =3D cl_twt_get_wake_interval_us(elem);
+       u64 remainder =3D 0;
+       u64 intervals_from_start_to_tsf =3D div64_u64_rem(tsf - start_time,=
 interval, &remainder);
+       u64 next_time =3D 0;
+
+       if (remainder)
+               /* We add 1 to intervals_from_start_to_tsf to get next_time=
 > tsf */
+               next_time =3D ((intervals_from_start_to_tsf + 1) * interval=
 + start_time);
+       else
+               /* No remainder means that the next start time equals exact=
ly to tsf */
+               next_time =3D tsf;
+
+       return next_time;
+}
+
+static void cl_twt_get_next_start_times_sorted_array(struct cl_hw *cl_hw,
+                                                    u64 tsf,
+                                                    struct cl_next_start_t=
ime *next_start_times)
+{
+       u64 next_time;
+       u8 i, j, handled_sessions =3D 0, num_sessions =3D cl_hw->twt_db.num=
_sessions;
+       u8 max_sessions =3D cl_hw->conf->ce_twt_max_sessions;
+       u8 bytes_to_move =3D 0;
+       struct cl_twt_session_db *session;
+
+       /* Calculate the next TWT time of all sessions and save them in a s=
orted array. */
+       for (i =3D 0, session =3D &cl_hw->twt_db.cl_twt_sessions[0];
+            i < max_sessions && handled_sessions < num_sessions;
+            i++, session++) {
+               if (!session->cl_sta)
+                       continue;
+
+               /* Calculate the current session's next start time */
+               next_time =3D cl_twt_get_next_start_time(cl_hw, session, ts=
f);
+
+               /* Find the correct position in the sorted array */
+               for (j =3D 0;
+                    (j < handled_sessions) && (next_start_times[j].time <=
=3D next_time);
+                     j++)
+                       ;
+
+               /* Make room for the current session's next start time */
+               bytes_to_move =3D (handled_sessions - j) * sizeof(next_star=
t_times[0]);
+
+               if (bytes_to_move)
+                       memmove(&next_start_times[j + 1], &next_start_times=
[j],
+                               bytes_to_move);
+
+               /* Insert the current session's next start time to the arra=
y */
+               next_start_times[j].session =3D session;
+               next_start_times[j].time =3D next_time;
+               handled_sessions++;
+       }
+}
+
+bool cl_twt_is_enabled(struct cl_hw *cl_hw)
+{
+       return cl_hw->conf->ce_twt_en;
+}
+
+void cl_twt_init(struct cl_hw *cl_hw)
+{
+       if (!cl_twt_is_enabled(cl_hw))
+               return;
+
+       memset(&cl_hw->twt_db, 0, sizeof(cl_hw->twt_db));
+}
+
+void cl_twt_close(struct cl_hw *cl_hw)
+{
+       u8 i, max_sessions =3D cl_hw->conf->ce_twt_max_sessions;
+       struct cl_twt_session_db *session;
+
+       if (!cl_hw->twt_db.num_sessions)
+               return;
+
+       /* Remove all sessions */
+       for (i =3D 0, session =3D &cl_hw->twt_db.cl_twt_sessions[0];
+             (i < max_sessions) && (cl_hw->twt_db.num_sessions);
+             i++, session++) {
+               if (!session->cl_sta)
+                       continue;
+
+               cl_twt_remove_all_sta_sessions(cl_hw, session->cl_sta, fals=
e);
+       }
+}
+
+struct cl_twt_session_db *
+cl_twt_get_session(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 flow_id)
+{
+       u8 i, max_sessions =3D cl_hw->conf->ce_twt_max_sessions;
+       struct cl_twt_session_db *session;
+
+       for (i =3D 0, session =3D &cl_hw->twt_db.cl_twt_sessions[0];
+            i < max_sessions;
+            i++, session++)
+               if (session->cl_sta =3D=3D cl_sta &&
+                   session->twt_setup.req_type.fields.flow_id =3D=3D flow_=
id)
+                       return session;
+
+       return NULL;
+}
+
+int cl_twt_update_session(struct cl_hw *cl_hw,
+                         struct cl_sta *cl_sta,
+                         struct ieee80211_twt_individual_elem *twt_elem,
+                         struct  cl_twt_session_db *session)
+{
+       session->cl_sta =3D cl_sta;
+       session->twt_setup =3D *twt_elem;
+
+       return 0;
+}
+
+int cl_twt_add_session(struct cl_hw *cl_hw,
+                      struct cl_sta *cl_sta,
+                      struct ieee80211_twt_individual_elem *twt_elem,
+                      struct  cl_twt_session_db **session)
+{
+       struct cl_twt_session_db *session_db =3D cl_twt_get_free_session(cl=
_hw);
+
+       if (!session_db) {
+               cl_dbg_err(cl_hw, "There are no available TWT sessions\n");
+               return -1;
+       }
+
+       cl_twt_update_session(cl_hw, cl_sta, twt_elem, session_db);
+       cl_hw->twt_db.num_sessions++;
+       *session =3D session_db;
+
+       return 0;
+}
+
+void cl_twt_remove_session(struct cl_hw *cl_hw,
+                          struct cl_twt_session_db *session,
+                          bool send_teardown_req)
+{
+       /* Send a TWT teardown frame */
+       if (send_teardown_req) {
+               u8 flow_id =3D session->twt_setup.req_type.fields.flow_id;
+
+               cl_twt_frame_send_individual_teardown_request(cl_hw, sessio=
n->cl_sta, flow_id);
+       }
+
+       session->cl_sta =3D NULL;
+       memset(&session->twt_setup, 0, sizeof(session->twt_setup));
+       cl_hw->twt_db.num_sessions--;
+}
+
+int cl_twt_teardown_individual_sesseion(struct cl_hw *cl_hw,
+                                       struct cl_sta *cl_sta,
+                                       u8 flow_id,
+                                       bool send_teardown_req)
+{
+       struct cl_twt_session_db *session;
+       struct mm_twt_teardown_req req_msg =3D {
+               .sta_idx =3D cl_sta->sta_idx,
+               .twt_flow_id =3D flow_id
+       };
+
+       /* There are no sessions */
+       if (!cl_hw->twt_db.num_sessions)
+               return -1;
+
+       /* Remove the session(s) from the db */
+       if (flow_id =3D=3D CL_TWT_FLOW_ID_ALL) {
+               cl_twt_remove_all_sta_sessions(cl_hw, cl_sta, send_teardown=
_req);
+       } else {
+               /* Check if the session exists */
+               session =3D cl_twt_get_session(cl_hw, cl_sta, flow_id);
+
+               if (!session) {
+                       cl_dbg_err(cl_hw, "Cannot handle the TWT teardown r=
equest "
+                                         "since no such session was found:=
 "
+                                         "sta_idx %u, flow_id %u\n",
+                                  cl_sta->sta_idx, flow_id);
+                       return -1;
+               }
+
+               cl_twt_remove_session(cl_hw, session, send_teardown_req);
+       }
+
+       /* Send a msg to fw */
+       cl_msg_tx_twt_teardown(cl_hw, &req_msg);
+       return 0;
+}
+
+void cl_twt_sta_remove(struct cl_hw *cl_hw,
+                      struct cl_sta *cl_sta)
+{
+       struct mm_twt_teardown_req req_msg =3D {
+               .sta_idx =3D cl_sta->sta_idx,
+               .twt_flow_id =3D CL_TWT_FLOW_ID_ALL
+       };
+
+       if (!cl_twt_is_enabled(cl_hw))
+               return;
+
+       /* Remove all sessions of STA from the db */
+       cl_twt_remove_all_sta_sessions(cl_hw, cl_sta, false);
+
+       /* Send a msg to fw */
+       cl_msg_tx_twt_teardown(cl_hw, &req_msg);
+}
+
+u64 cl_twt_get_wake_interval_us(struct ieee80211_twt_individual_elem *elem=
)
+{
+       u8 exponent =3D elem->req_type.fields.wake_interval_exponent;
+       u64 mantissa =3D elem->wake_interval_mantissa;
+
+       return (mantissa << exponent);
+}
+
+u32 cl_twt_get_min_wake_time_us(struct ieee80211_twt_individual_elem *elem=
)
+{
+       u8 duration_unit_exp =3D (elem->control.fields.wake_duration_unit <=
< 1);
+       u32 wake_time =3D elem->min_wake_duration;
+
+       /* Convert to us (1 unit =3D 256us/1024us) */
+       return (wake_time << (8 + duration_unit_exp));
+}
+
+void cl_twt_set_target_wake_time(struct cl_hw *cl_hw,
+                                struct ieee80211_twt_individual_elem *elem=
)
+{
+       /*
+        * Read TSF and add it an offset to make sure we set a future TSF.
+        * Make sure that tsf mod 16 =3D 0 to support WiFi aware requiremen=
t.
+        */
+       u64 tsf =3D (cl_get_tsf_u64(cl_hw) + CL_TWT_CONST_TARGET_WAKE_TIME_=
OFFSET_US) &
+               WIFI_AWARE_TARGET_WAKE_TIME_MASK;
+       u64 start_time =3D tsf;
+       struct cl_next_start_time sorted_next_start_times[CL_TWT_MAX_SESSIO=
NS] =3D { { 0 } };
+       u8 i, num_sessions =3D cl_hw->twt_db.num_sessions;
+
+       if (cl_hw->twt_db.num_sessions > 0) {
+               u32 min_wake_time =3D cl_twt_get_min_wake_time_us(elem);
+
+               cl_twt_get_next_start_times_sorted_array(cl_hw, tsf, sorted=
_next_start_times);
+
+               /* Find the closest time for the new session */
+
+               for (i =3D 0; i < num_sessions; i++) {
+                       struct cl_twt_session_db *curr_session =3D
+                               sorted_next_start_times[i].session;
+                       u32 curr_min_wake_time =3D
+                               cl_twt_get_min_wake_time_us(&curr_session->=
twt_setup);
+                       u64 curr_next_time =3D sorted_next_start_times[i].t=
ime;
+                       u64 next_next_time;
+
+                       /*
+                        * We set the new session's start time such that th=
e new TWT window
+                        * would start right after the min wake time of the=
 last session since
+                        * we couldn't find a closer time for it.
+                        */
+
+                       if (i =3D=3D num_sessions - 1) {
+                               start_time =3D curr_next_time + curr_min_wa=
ke_time;
+                               break;
+                       }
+
+                       next_next_time =3D sorted_next_start_times[i + 1].t=
ime;
+
+                       /*
+                        * We can put the new session between sessions i an=
d i+1 without
+                        * overlapping.
+                        * The TWT windows would not overlap only if the in=
tervals are a
+                        * multiply of each other.
+                        */
+
+                       if (next_next_time - curr_next_time >=3D
+                           curr_min_wake_time + min_wake_time) {
+                               start_time =3D curr_next_time + curr_min_wa=
ke_time;
+                               break;
+                       }
+               }
+       }
+
+       elem->target_wake_time =3D start_time;
+}
+
+void cl_twt_set_min_wake_duration(struct cl_hw *cl_hw,
+                                 struct ieee80211_twt_individual_elem *ele=
m,
+                                 u32 duration_us)
+{
+       u16 duration_in_units_of_256_us =3D (duration_us >> 8);
+
+       if (duration_in_units_of_256_us <=3D U8_MAX) {
+               elem->min_wake_duration =3D duration_in_units_of_256_us;
+               elem->control.fields.wake_duration_unit =3D 0;
+       } else {
+               /* Convert to units of 1024us */
+               duration_in_units_of_256_us >>=3D 2;
+               elem->min_wake_duration =3D duration_in_units_of_256_us;
+               elem->control.fields.wake_duration_unit =3D 1;
+       }
+
+       if (duration_in_units_of_256_us > U8_MAX)
+               cl_dbg_err(cl_hw, "Invalid min wake duration %u! exceeds 8 =
bits\n", duration_us);
+
+       cl_dbg_info(cl_hw, "Set TWT min wake duration to %u us: "
+                          "duration val - %u, duration unit - %u us\n",
+                   duration_us, elem->min_wake_duration,
+                   (elem->control.fields.wake_duration_unit ? 1024 : 256))=
;
+}
+
+void cl_twt_set_interval(struct cl_hw *cl_hw,
+                        struct ieee80211_twt_individual_elem *elem,
+                        u64 interval_us)
+{
+       u8 exponent;
+       u16 mantissa;
+
+       if (!interval_us)
+               return;
+
+       exponent =3D ffs((u32)interval_us) - 1;
+
+       elem->req_type.fields.wake_interval_exponent =3D exponent;
+       mantissa =3D (interval_us >> exponent);
+       elem->wake_interval_mantissa =3D mantissa;
+
+       if (mantissa > U16_MAX)
+               cl_dbg_err(cl_hw, "Invalid interval! mantissa exceeds 16 bi=
ts\n");
+
+       cl_dbg_info(cl_hw, "Set TWT interval to %llu us: exponent %u, manti=
ssa %u\n",
+                   interval_us, elem->req_type.fields.wake_interval_expone=
nt,
+                   elem->wake_interval_mantissa);
+}
+
+int cl_twt_handle_individual_setup_request(struct cl_hw *cl_hw,
+                                          struct cl_sta *cl_sta,
+                                          struct cl_ieee80211_mgmt *reques=
t)
+{
+       struct mm_twt_setup_req req_msg;
+       struct cl_twt_session_db *session =3D NULL;
+
+       /* Max sessions reached */
+       if (cl_hw->twt_db.num_sessions >=3D cl_hw->conf->ce_twt_max_session=
s)
+               return -1;
+
+       /* Check the validity of the request */
+       if (!cl_twt_frame_is_individual_setup_request_valid(cl_hw, request)=
) {
+               cl_dbg_err(cl_hw, "TWT individual request is invalid!\n");
+               return -1;
+       }
+
+       /* Send a TWT response and add a new TWT session to the db */
+       if (cl_twt_frame_send_individual_setup_response(cl_hw, cl_sta, requ=
est, &session)) {
+               cl_dbg_err(cl_hw, "TWT response failed!\n");
+               return -1;
+       }
+
+       /* Fill and send a msg to fw */
+       req_msg.sta_idx =3D session->cl_sta->sta_idx;
+       req_msg.twt_flow_id =3D session->twt_setup.req_type.fields.flow_id;
+       req_msg.min_wake_duration_us =3D cl_twt_get_min_wake_time_us(&sessi=
on->twt_setup);
+       req_msg.twt_interval_us =3D cl_twt_get_wake_interval_us(&session->t=
wt_setup);
+       req_msg.twt_start_time_tsf =3D session->twt_setup.target_wake_time;
+       req_msg.announced =3D !(session->twt_setup.req_type.fields.flow_typ=
e);
+       req_msg.triggered =3D session->twt_setup.req_type.fields.trigger;
+
+       cl_msg_tx_twt_setup(cl_hw, &req_msg);
+       return 0;
+}
+
+int cl_twt_handle_individual_teardown_request(struct cl_hw *cl_hw,
+                                             struct cl_sta *cl_sta,
+                                             struct cl_ieee80211_mgmt *req=
uest)
+{
+       u8 flow_id =3D request->u.action.u.twt_individual_teardown.flow_id;
+       bool all_twt =3D request->u.action.u.twt_individual_teardown.teardo=
wn_all_twt;
+
+       if (all_twt)
+               flow_id =3D CL_TWT_FLOW_ID_ALL;
+
+       cl_twt_teardown_individual_sesseion(cl_hw, cl_sta, flow_id, false);
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

