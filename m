Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D3F3AB916
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbhFQQMZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:25 -0400
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:37092
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233655AbhFQQLS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJidwIREXYrDXzeTL2cF8yeFN609Eg9XKX7PkDJ1T8P4FaZ2+ZUJ+syzvyUqWY06qXCR719SveeVwOlfL4NS7j59Yo4QXNOEt9K2XmU/DQESygAxEcAxxRcghPgQxZDp4cypAV5Ju4GxnBoW+3DVpi6M8dLRW40htqDeUyCygMXJ4wNDXz/iAG0HlIxYurm1Ww3JpI8Y9I2GZqTdKL6D3n7MHqJVPYH55Vn+PgqgT3kdDhkvc8samo/oSqubHOmJLdc7hd141jsljydqn0khucq+WBOtsK/2t/1jNL4U3UYUvffI61FCx9mxZn6Tepb2eJej4ZJ4VUb77l5Q9lD6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE1TlWDC/8mzpncUXUvVHg6D/yc3SJJZYXj30rLVQ0I=;
 b=lZA2tIJyZk7kbSEj2UbxBgyVdvUmoPiV/kaJMSTRdGGhzYTPm5Bh2RFoaPTHQCV8WRzdyytUmeHADwS2wYGqb24XtbUMB+ru1t83fHFBpUCGYpz/xseWO/PGGNNbFZVBhFCYcaGXYtiMfmPVB3kpvJNpgu2jhYmSkPSEtVIFbXqHcFnESybJM2dnzJ6iNbFU4N64qer2FHR32lkQw/14KXggW+5LXmTEBUrLTSqmSwJmUlWMwGhO0sEx4zodOYiXiOwXC6+GQ12lj+DLthkAA7UHYdDSTDP9b4GcydspxkAZ9yG7KinRX0BuayHGj3LhWKFoWXoxoM5I1e9l23fgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE1TlWDC/8mzpncUXUvVHg6D/yc3SJJZYXj30rLVQ0I=;
 b=bgtiUzSSODmfeL3JzCwLDDjiUrLyZP9u4Klf51S3rsUGUckpcPsWUtw+kpp+Nbr+Fz9SHz+9T3PuKP9OyKDwMwrLTX1/GJHZspU0GClORgJyY2HG9XpagKhjXnva6M2vNfshoRhEcYCWZvsEzgxYkxFDEONmuNVdtSBev0I8Vuo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:16 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:16 +0000
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
Subject: [RFC v1 202/256] cl8k: add tx/agg_tx_report.c
Date:   Thu, 17 Jun 2021 16:01:29 +0000
Message-Id: <20210617160223.160998-203-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e012d52f-850e-455c-0554-08d931a9d720
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1075AAF136081C42A43BA330F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oUeijqTnmQ08yhk4DOe0IQeXsWra+pQL2JGrEnqrcdgdnETYzIgCRTqSUz+oB+16Bl0q1ZErg9Wi/yPBBoPq/WzpG3KhSv0tHimeFHAJxuErdKcitJ/D5p8WMbKZfUvtZTmirPMcWSwQoeR4yVoNqxn3Yv5DUYLBdGlKu4eb+s14Jn+nZQtTN1Y/bZ3ojx2E9gukKwn/wJn2e2+A2LGK/bZjFeAdx6rH6FLnzrfGwkFu1fXqsTmUsNeUtzsHSlHZU8JYEKetna91RP/DtX3/7zNL0Pszp+gn+5NtuqSEQjmP+YxPjrj+/jXFuDZegnQZ7dSr/CXXJxbtaeGdrD/qzKcj8fV32WMQfeDafBMv9Wsxruz21HeYCoaP9QJmcntFGV3wJG8S0EPSR+3fWZkdDqeoqmS4xqLgt4LHg2Xn29pAyu46G97+N+TAo/U/iiGDb0VgCBXN8nGNk2N0s7r8DCXpRgecXocNadUulZzL2Sf+14P+qu1SI6ceXDB5BRtcNTxo0sfMchdtBfj+j9QDgoj3TMriETtTMDAXS4kneE+oc1B1J7btr9ZV498dSQi7f6GNbEMpWFx6Kax7jk47giT13UTEftPCG5xDeC/YbDlUPUmWeet1AlqFOoeKMe46m1GMOAISswj1YUd5dxAXBIej3cvDVMk9CGCrT8cctM6F7Fl2aOb7HaivIZqUGwCn0W+0Tl8BG8B+hbIihnTLDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(136003)(39850400004)(376002)(366004)(346002)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(478600001)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(316002)(2906002)(83380400001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?izainW7Fe5wWOviitLcqReNWSkj5aFMKwHQHFvxJAy7TdtI4/9A3dB07bUCj?=
 =?us-ascii?Q?LZNvySxNt1VioR0wbNjK7D+ex4tTfVlvtbnSYtbqsXq4zBGvAwHEnZ+Ay+sX?=
 =?us-ascii?Q?fUB49PVnIpzRHD1UWkWn8DLgzrkeQhiSCVRBwWSuiXuXoGNXhlDwjH1MFqZ5?=
 =?us-ascii?Q?mOK/ecfa6imbxOckIFHDBimqlePkfr4gIJK/1W8vW5NUKf5PrcLY6yO9jWhw?=
 =?us-ascii?Q?Qf6CHZepMU03uNIbAiRYSQviiR0hczJKtT2xFs0TXtpN2wt/lQXSMq9eCpw1?=
 =?us-ascii?Q?L830WsegIrQL+XOeKC4mpGAp87bpeHVYAM/irE6Z8pVQCxWza5Q4f6ZLGgFM?=
 =?us-ascii?Q?opQw/xjsS2b2Kg3WnSvOlfULmymA8LEZDhig03XvyH2euiryqQgB/4ecJTRq?=
 =?us-ascii?Q?NEt+0U9+yrrQI2Y5xNA89uxGCjw+oLGq000OHeKadJNLaSrbw0Ldvyn/+vg1?=
 =?us-ascii?Q?f9xJm7TvKAbXI4V2BZTdeLJGGKfHUg+vrBZFWhA8lKKIOtdXu58w+R2X22wE?=
 =?us-ascii?Q?xRyUQImoCnAM3gguAF4VBO22sqcuazY+J9t+WG5UgRuKXOPo4RhpXuSQJl+Q?=
 =?us-ascii?Q?OQUL/ZTqglVA4b6NOe8cqLlr4opkkDrx7QLQVywknONpvHbJNc+Pou3iGC0p?=
 =?us-ascii?Q?X6bE3DBRz0+lGdqh6NnM4YJ2Nm2i5mR9ONyizP706gp7ng9yM7QFNT6eocju?=
 =?us-ascii?Q?4fXdgmwjKcAiv6jQ6A8mdQF6VPWsj6iNZc0J1Wa/WksVlDK8yLkyhJXM6TKU?=
 =?us-ascii?Q?oY+y3JZtWjFgiJ+A4jdX8/z+t42JpWRkZt1EcB5zpe38T1wtLLAKBetfM7xv?=
 =?us-ascii?Q?KYoTQ9Id9huZcX+k/7LFtH6RA9yRaqO4nRJZluV39QUEhB4UILMcxqPDx5i5?=
 =?us-ascii?Q?9G/m/rvDUVWYWbotCjPbltyyHyUNASpY4l/XoOqch8fOnvXrVM88cq+mIISv?=
 =?us-ascii?Q?jLrtfw0+X3PKk88DQWwy2neBfCte9TJiEEZWynmqiGzQjxDxYyZth7rfvKoa?=
 =?us-ascii?Q?ZbICQ2Sv03Y17wwDBiqIzaGyNMBvvKKleREaFFInitWr7i44CQUYLukQRfcN?=
 =?us-ascii?Q?FHilLSG2jCaOoEeDrbFa4U0HjWklU3G++W7LKqSoatIvmlc+tfjXuCc97Jv9?=
 =?us-ascii?Q?XP5mgIap8yG30kx0bo/EweITOkLxxnILXmicWMTj69xEuJE+W6ekpj2uPj1Z?=
 =?us-ascii?Q?KE37jcIpqASfVTYjgtQIcq1Il+nQx+1DW4aQ9dFhNcwBYzY5Zfo2OoQnnbLY?=
 =?us-ascii?Q?t781g0UYCRWU0jxWfbuezxiAzqbEkmQ1ahzgiiZ2nqUK+irjU1pdBg9sck9m?=
 =?us-ascii?Q?okW8uyymY+LD3e3SoR0SkIRK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e012d52f-850e-455c-0554-08d931a9d720
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:17.9852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gE0ooXl6u1jwpCRyFH1jp3GLczPSu1AMbNknHYDI0UEf/IJn8/j1Nzvg7lrustE9kZT24RLeiIla+UiWIVYHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../wireless/celeno/cl8k/tx/agg_tx_report.c   | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.c

diff --git a/drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.c b/drivers/=
net/wireless/celeno/cl8k/tx/agg_tx_report.c
new file mode 100644
index 000000000000..478e5e734f08
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/tx/agg_tx_report.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "tx/agg_tx_report.h"
+#include "stats.h"
+#include "rate_ctrl.h"
+#include "wrs/wrs_api.h"
+#include "data_rates.h"
+
+static bool is_same_rate(struct cl_agg_tx_report *agg_report, struct cl_wr=
s_tx_params *tx_params)
+{
+       union cl_rate_ctrl_info rate_ctrl_info =3D {.word =3D agg_report->r=
ate_cntrl_info};
+       u8 mcs =3D U8_MAX, nss =3D U8_MAX;
+
+       if (agg_report->bw_requested !=3D tx_params->bw ||
+           rate_ctrl_info.field.gi !=3D tx_params->gi)
+               return false;
+
+       cl_rate_ctrl_parse(&rate_ctrl_info, &nss, &mcs);
+
+       return ((mcs =3D=3D tx_params->mcs) && (nss =3D=3D tx_params->nss))=
;
+}
+
+static void sync_tx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                        struct cl_agg_tx_report *agg_report,
+                        struct cl_wrs_info *wrs_info, struct cl_wrs_params=
 *wrs_params)
+{
+       if (!agg_report->is_fallback && is_same_rate(agg_report, &wrs_param=
s->tx_params)) {
+               cl_wrs_api_rate_sync(cl_hw, cl_sta, wrs_params);
+
+               wrs_info->synced =3D true;
+               wrs_info->quick_rate_check =3D true;
+               wrs_info->quick_rate_agg_cntr =3D 0;
+               wrs_info->quick_rate_pkt_cntr =3D 0;
+       } else {
+               wrs_info->sync_attempts++;
+       }
+}
+
+static void ba_not_received_handler(struct cl_hw *cl_hw, struct cl_wrs_inf=
o *wrs_info,
+                                   struct cl_agg_tx_report *agg_report)
+{
+       /* Ignore 'BA not received' if station is in power-save or if RTS l=
imit was reached */
+       if (agg_report->is_sta_ps || agg_report->is_rts_retry_limit_reached=
)
+               return;
+
+       /* Count number of consecutive 'BA not received' */
+       wrs_info->ba_not_rcv_consecutive++;
+
+       /* Save longest sequence of consecutive 'BA not received' */
+       if (wrs_info->ba_not_rcv_consecutive > wrs_info->ba_not_rcv_consecu=
tive_max)
+               wrs_info->ba_not_rcv_consecutive_max =3D wrs_info->ba_not_r=
cv_consecutive;
+
+       if (cl_hw->wrs_db.ba_not_rcv_collision_filter) {
+               /*
+                * First 'BA not received' - might just be a collision.
+                * Don't add fail to ba_not_rcv but keep aside.
+                * Second consecutive 'BA not received' - not likely to be =
a collisions.
+                * Add fail to ba_not_rcv including previous fail that was =
kept aside.
+                * More than two consecutive 'BA not received' - very unlik=
ely to be a collisions.
+                * Add fail to ba_not_rcv.
+                */
+               if (wrs_info->ba_not_rcv_consecutive =3D=3D 1)
+                       wrs_info->tx_fail_prev =3D agg_report->fail;
+               else if (wrs_info->ba_not_rcv_consecutive =3D=3D 2)
+                       wrs_info->ba_not_rcv +=3D (agg_report->fail + wrs_i=
nfo->tx_fail_prev);
+               else
+                       wrs_info->ba_not_rcv +=3D agg_report->fail;
+       } else {
+               wrs_info->ba_not_rcv +=3D agg_report->fail;
+       }
+}
+
+void cl_agg_tx_report_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                             struct cl_agg_tx_report *agg_report)
+{
+       struct cl_wrs_info *wrs_info =3D &cl_sta->wrs_info;
+       struct cl_wrs_params *wrs_params =3D &cl_sta->wrs_sta.su_params;
+       bool skip_epr_update =3D false;
+       union cl_rate_ctrl_info rate_ctrl_info =3D {.word =3D agg_report->r=
ate_cntrl_info};
+
+       /* Retry_count for cl_wlan */
+       cl_sta->retry_count +=3D agg_report->success_after_retry;
+
+       /*
+        * In case of big packets (4300 in VHT and 5400 in HE) and low
+        * rate (BW 20, NSS 1, MCS 0), firmware will increase rate to MCS 1=
,
+        * and give an indication to driver (set rate_fix_mcs1 in cl_agg_tx=
_report).
+        * WRS should also move to MCS 1, and give the maximum time
+        * penalty time from MCS 0 toMCS 1.
+        */
+       if (agg_report->rate_fix_mcs1 && !agg_report->is_fallback)
+               if (cl_wrs_api_up_mcs1(cl_hw, cl_sta, wrs_params))
+                       return;
+
+       /* WRS sync mechanism */
+       if (!wrs_info->synced)
+               sync_tx_rate(cl_hw, cl_sta, agg_report, wrs_info, wrs_param=
s);
+
+       if (agg_report->bf && cl_sta->bf_db.is_on && !cl_sta->bf_db.synced)=
 {
+               cl_sta->bf_db.synced =3D true;
+               /* Resetting the WRS UP weights */
+               cl_wrs_api_beamforming_sync(cl_hw, cl_sta);
+       }
+
+       if (agg_report->ba_not_received) {
+               ba_not_received_handler(cl_hw, wrs_info, agg_report);
+       } else {
+               if (!skip_epr_update)
+                       wrs_info->tx_fail +=3D agg_report->fail;
+
+               wrs_info->ba_not_rcv_consecutive =3D 0;
+       }
+
+       if (!skip_epr_update) {
+               u8 mcs =3D 0, nss =3D 0, bw =3D 0;
+               u16 data_rate =3D 0;
+
+               switch (agg_report->bw_requested) {
+               case CHNL_BW_160:
+                       bw =3D (cl_hw->wrs_db.adjacent_interference20 ||
+                             cl_hw->wrs_db.adjacent_interference40 ||
+                             cl_hw->wrs_db.adjacent_interference80) ?
+                               rate_ctrl_info.field.bw : agg_report->bw_re=
quested;
+                       break;
+               case CHNL_BW_80:
+                       bw =3D (cl_hw->wrs_db.adjacent_interference20 ||
+                             cl_hw->wrs_db.adjacent_interference40) ?
+                               rate_ctrl_info.field.bw : agg_report->bw_re=
quested;
+                       break;
+               case CHNL_BW_40:
+                       bw =3D cl_hw->wrs_db.adjacent_interference20 ?
+                               rate_ctrl_info.field.bw : agg_report->bw_re=
quested;
+                       break;
+               case CHNL_BW_20:
+                       bw =3D agg_report->bw_requested;
+                       break;
+               }
+
+               cl_rate_ctrl_parse(&rate_ctrl_info, &nss, &mcs);
+
+               data_rate =3D cl_data_rates_get_x10(rate_ctrl_info.field.fo=
rmat_mod,
+                                                 bw,
+                                                 nss,
+                                                 mcs,
+                                                 rate_ctrl_info.field.gi);
+
+               wrs_info->epr_acc +=3D ((u64)agg_report->success * data_rat=
e);
+               wrs_info->tx_success +=3D agg_report->success;
+       }
+
+       if (cl_hw->wrs_db.quick_down_en && wrs_info->quick_rate_check) {
+               if (is_same_rate(agg_report, &wrs_params->tx_params)) {
+                       wrs_info->quick_rate_agg_cntr++;
+                       wrs_info->quick_rate_pkt_cntr +=3D (agg_report->suc=
cess + agg_report->fail);
+
+                       if (wrs_info->quick_rate_agg_cntr >=3D cl_hw->wrs_d=
b.quick_down_agg_thr &&
+                           wrs_info->quick_rate_pkt_cntr > cl_hw->wrs_db.q=
uick_down_pkt_thr) {
+                               wrs_info->quick_rate_check =3D false;
+                               cl_wrs_api_quick_down_check(cl_hw, cl_sta, =
wrs_params);
+                       }
+               }
+       }
+}
+
+void cl_agg_tx_report_simulate_for_single(struct cl_hw *cl_hw, struct cl_s=
ta *cl_sta,
+                                         struct cl_hw_tx_status *status)
+{
+       /* Assign statistics struct */
+       struct cl_agg_tx_report agg_report;
+       union cl_rate_ctrl_info rate_ctrl_info;
+
+       memset(&agg_report, 0, sizeof(struct cl_agg_tx_report));
+
+       agg_report.bf =3D status->bf;
+       agg_report.success =3D status->frm_successful;
+       agg_report.fail =3D status->num_mpdu_retries + (status->frm_success=
ful ? 0 : 1);
+       agg_report.success_after_retry =3D
+               (status->frm_successful && status->num_mpdu_retries) ? 1 : =
0;
+       agg_report.retry_limit_reached =3D !status->frm_successful ? 1 : 0;
+       agg_report.success_more_one_retry =3D
+               (status->frm_successful && (status->num_mpdu_retries > 1)) =
? 1 : 0;
+       agg_report.sta_idx =3D cl_sta->sta_idx;
+       agg_report.bw_requested =3D status->bw_requested;
+
+       rate_ctrl_info.field.bw =3D status->bw_transmitted;
+       rate_ctrl_info.field.gi =3D status->gi;
+       rate_ctrl_info.field.format_mod =3D status->format_mod;
+       rate_ctrl_info.field.mcs_index =3D status->mcs_index;
+
+       cl_rate_ctrl_convert(&rate_ctrl_info);
+
+       agg_report.rate_cntrl_info =3D rate_ctrl_info.word;
+       cl_agg_tx_report_handler(cl_hw, cl_sta, &agg_report);
+       cl_stats_update_tx_single(cl_hw, cl_sta, &agg_report);
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

