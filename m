Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBFE3AB938
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFQQNn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:43 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:48736
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233729AbhFQQMY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwczaTJ3OKO8z8kXECiaFGT8ogce8hZMUh5wkapAIFINYrOUUjGw4F5/B0xSieK1cOTTbeqlQ26fviHRKTglDTFod3vSrl7odSjeRKMPsyzOeC3ReYS6RZnz4gxDmfPspHQCf8+Y5y+7l8V0aRT91qTz19V0Ev5qu3KFZ07Qfm6eIh/+GPMwEBzlN/jerUUNxw7H18Hd/KvSzmllDU1TDHlNWTtRfV4DRLGH1dyllquTqI3vKpNMoosdE7fWTkmDsjD4IAqBb578dGGBLsynaY7woT3fEiZYEQXFai3aEt+WGhNZUkkKRPOwSScCS7ULEix9u29hZgPm23lGeW9RqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcVj6Gnnu/aWxUKB2Snw09O/GIPWlZ0qfcWlspJEiQI=;
 b=Yq+BVuGGLgERzKg6u60j1j5H3asHk+PgJQ3SpvQ6WgEyZ3d4NvBmJtNuYD4PtqkdYpqWJ7aY8n8TZBBt+oK0aCojAA7ltn+z2rOT66uH+mJ8iepsOzpG03COMcEg0eQf3FaiM5lFyHu9KpYlnwAciWuhki/9c+oah2uoIrEfAUFnguoOqpIeZmnGQ4nHM0xnjt/XPj1XIw42vj50vzxRCD70OXaXzBESuHp/kT7XNlJnL3UEBMU5oHK+LqdZjtioWphpPAu4UvzkFHgm/Jr0e4RHuEezhkvpH+PiMTgAhsfk1Ihgq40u61vFTUo2RnR7WUcLrV/3waUPS1HRPTjClg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcVj6Gnnu/aWxUKB2Snw09O/GIPWlZ0qfcWlspJEiQI=;
 b=NCUaYohj75JMD2ChSTEsCfdKJ2/h27L2I7u3WMrp2frFDFNHw3r08K+/Pu98OfkLfdER8rh43ye86YZgv+h1+P/0r9oCAnH8qk/zabhBBaImw4vJWYtdRnDckWZsLy/y7jAemHXjjQ4CmZCT1NkLzG3+bEr8DqtB6BJzP1Dp6rA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:35 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:34 +0000
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
Subject: [RFC v1 248/256] cl8k: add wrs/wrs_rssi.c
Date:   Thu, 17 Jun 2021 16:02:15 +0000
Message-Id: <20210617160223.160998-249-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4c924dc-1960-4a0b-158d-08d931a9f6ff
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978004D9DCCEF0F90E3D78BF60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:27;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y6QggG3cYCgWlF92C0mQHNCITENl8RjkISurdy9W7VJTni8TWQo7MWXTMANRVgg9X2fS97cmLWO2Mc4uO35Yk0PutkCyx38il4jQ9sOkXbPnG6ZJMmY8R6nMyKrcMeNThyEUjjMU7yoSfhXFE5qJdifSARGvuiqdMKaqHLzn0H3oGK39FE6L0QGPXQCxZMk7GIKj1yNq/WXsHN8BgZJbB0hno5CjydxcR0BmA5qyjXco7pnqAMopgYVGkcQRy+N9R1ndjP9uUtEJGEOtZ+TmcQ9uYyphxyys8KAPPjGYB9TBee+NMleXuyqFgM2sJwpNaV2GxTcGgl3SIoMasuunrKvIjT3dQcm6W41KJq6N3RqV9FOOwzQrqhRgyXrDHY10z8VKYSaIsd1IusH5QRik0BW1r/F2mobBYanJSMYeMsmBk23MFEmGyNyy3nF4BI6hakdWmrwYLmdYy+jXlFmBC5eI+k0gUgZi20HrbYXKH/crp2cdxZd9Pn75DrRGIe7aL9H5q1RkX4BCbqBOK6L7IK/zsBAT/QouoI1cBUZskiXue9Ef2AtSJSPUJ/l6Svvolaer29gpYRB+1k/FlBa9w+Sx7S4zz2zWcjNNyWfqMeN++oretFygo5qkWXuENUn5i60gnJjL30h2tfa7TrlsSzn/CeRv0eZHRHkxLUkt/9eLS92VqPEVdkdFjQOpv8T0Vlr70j44Itm8PQbHSJ+iHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(30864003)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jQ1WHE6+ZnpX7Ax1p3NoEMnYwJkZ5pnox107C7ya3jZLzCbedk0bz+2FIyYf?=
 =?us-ascii?Q?/naj8S2p0t+HrJJHZSJhR5MpN0jvh+RKst8nwdoe8NllWttvriAbaY6rqbY8?=
 =?us-ascii?Q?qMN1/MLHRDGk0EB1q4KsCNOA/LRuiy/zIJd6NMfjX68I+fEBCdvSHjbf4DxW?=
 =?us-ascii?Q?xAoZRUAKcW8bmPMUqjAOxc0P+hlS4yIWCQLlYMxIuR/JowjRkSiwsH4THy5N?=
 =?us-ascii?Q?wicxVcAOMhquOiXpmOgh5BDoYAqI+0l0nH6Sdn6QW0KeULFdwn4X13Cj/lh2?=
 =?us-ascii?Q?B1fysFhcxFIvfAmlRSnkTTHsNuMngVIIdlAk12FJkmZSPbw1plnbSMqscBiC?=
 =?us-ascii?Q?hF18Ni7knomjuerspUWhaAr7tSB79hXvNDTZjviObcsbV5blkX56XCubhiPL?=
 =?us-ascii?Q?MhHVpZWz0KLzEBNnBiKAIjZugBM/dodGvJId8fnJsEYKhYtRU4LkoMVaWQPf?=
 =?us-ascii?Q?gfYZ+32y5YdvubGFVxnCzOl1x5WPnICO611FCbq1hsMTxjYCqGbtP4PZDcAp?=
 =?us-ascii?Q?6hga4wQbW72LyERH/lJqbupn9b8NwkTlFVKN4MpFH7c376kMG1JEJTD6yXM4?=
 =?us-ascii?Q?FQll/KTK42I5l/aAhysQ3lLcS30Y7YuyYMMrkszbyWKm8NqVfDbT1OijjgIp?=
 =?us-ascii?Q?UhCcqfSdSoM2ojI5Db4K1EILW0REKWrh1S2gTyo0eCXyNjIgxn6HatukFfoA?=
 =?us-ascii?Q?sCSCCRyalsBBfuvEJjH0Lh9Rq40eTNMMyK7jTLCVxabfimifamrgN2UthB69?=
 =?us-ascii?Q?RJ587sj/CDrMMrOLM/yYK8ZGf5YhMuOr4Xlsbu08IkTRXe6AgNPpjoTYn9Is?=
 =?us-ascii?Q?6jDM1oQB9toBEGONkuy+jUBdmDKa6skueDXHy45b7KBL63dpi4cYK2+CQxdd?=
 =?us-ascii?Q?a7CLiJmU4XUgWLAAXrZM/6NFdISJH+nYAkMvaBIZFdbC0M+gXDbGZ8zdhLgn?=
 =?us-ascii?Q?tpWwV01pyBSIw6yVxqv13O0M9rwfqL/m7WVrH+eqo+mkNLK2q5wxdOf84CNb?=
 =?us-ascii?Q?TZyhYn/3P3Y/aJ3utKKifPqJb2kycUONlxMw8g1dNmiSfxyw61H6T8Bnk6Xz?=
 =?us-ascii?Q?PvXTEOY8qem/q84t2u85n8baHxkNJf3jugOeX2P+pGXAyJ4m96UnPinwynUf?=
 =?us-ascii?Q?kij43U+K5MimZim6oMHvveXcOegzDIHivNDFSF6J440mqHEAXpnvaRFV27tJ?=
 =?us-ascii?Q?hQlKLny5JhWqSza3DQ6XzwoyRXuBbDm+/X8neX0V1QAxS439BoT7JDEg5iVH?=
 =?us-ascii?Q?O5ZqyFI06GhOjZyxKr5lJb2MV3iBTyVs62CqRQwgQb4E2phYZEe3vzH3bQM5?=
 =?us-ascii?Q?mAeXPoEB3GCwqgs9VZiid2bA?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c924dc-1960-4a0b-158d-08d931a9f6ff
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:11.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSHu2ptoBFdRqc+Uz7g4YOjQMCTKlDd2x6+j6KqBUu1bOVCi4M8sFQ6D9NqaQIQJb3K/mLTDwuceELGVOe56CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_rssi.c   | 444 ++++++++++++++++++
 1 file changed, 444 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.c b/drivers/net/=
wireless/celeno/cl8k/wrs/wrs_rssi.c
new file mode 100644
index 000000000000..9f4e691c81db
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_rssi.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_rssi.h"
+#include "wrs/wrs.h"
+#include "def.h"
+#include "rssi.h"
+#include "data_rates.h"
+
+/*
+ * Section #1:
+ * rate based on rssi.
+ */
+static s8 rssi_threshold_he[WRS_MCS_MAX_HE] =3D {
+       -35, -40, -45, -50, -55, -60, -65, -70, -75, -80, -85, -90
+};
+
+static s8 rssi_threshold_vht[WRS_MCS_MAX_VHT] =3D {
+       -36, -42, -48, -54, -60, -66, -72, -78, -84, -90
+};
+
+static s8 rssi_threshold_ht[WRS_MCS_MAX_HT] =3D {
+       -34, -42, -50, -58, -66, -74, -82, -90
+};
+
+static s8 rssi_threshold_ofdm[WRS_MCS_MAX_OFDM] =3D {
+       -34, -42, -50, -58, -66, -74, -82, -90
+};
+
+static s8 rssi_threshold_cck[WRS_MCS_MAX_CCK] =3D {
+       -45, -60, -75, -90
+};
+
+static u16 cl_wrs_rssi_find_rate_ht_vht_he(struct cl_hw *cl_hw, struct cl_=
wrs_db *wrs_db,
+                                          struct cl_wrs_sta *wrs_sta, s8 *=
rssi_sort,
+                                          s8 *thresholds)
+{
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+       s8 max_ss =3D (s8)wrs_sta->max_rate_cap.nss;
+       s8 nss =3D 0;
+       u8 max_bw =3D wrs_sta->max_rate_cap.bw;
+       u8 bw =3D 0;
+       u8 max_mcs =3D wrs_sta->max_rate_cap.mcs;
+       u8 mcs =3D 0;
+       u8 gi =3D WRS_GI_LONG;
+       u8 selected_mcs =3D 0;
+       u8 selected_nss =3D 0;
+       u8 selected_bw =3D 0;
+       u8 i =3D 0;
+       u16 rate_idx =3D 0;
+       u16 data_rate =3D 0;
+       u16 max_data_rate =3D 0;
+
+       if (max_bw > cl_hw->conf->ci_wrs_max_bw)
+               max_bw =3D cl_hw->conf->ci_wrs_max_bw;
+
+       for (i =3D 0; i <=3D max_mcs; i++) {
+               mcs =3D max_mcs - i;
+
+               for (nss =3D max_ss; nss >=3D 0; nss--) {
+                       if (rssi_sort[nss] <=3D thresholds[i])
+                               continue;
+
+                       /* In last level decrease BW */
+                       bw =3D ((i =3D=3D max_mcs) && (max_bw > CHNL_BW_20)=
) ? (max_bw - 1) : max_bw;
+
+                       if (wrs_sta->mode =3D=3D WRS_MODE_HE) {
+                               data_rate =3D data_rate_he_x10[nss][bw][mcs=
][WRS_GI_LONG];
+                       } else {
+                               if (wrs_sta->mode =3D=3D WRS_MODE_VHT) {
+                                       /* 160MHz in VHT is valid only for =
1/2 SS */
+                                       if (nss >=3D WRS_SS_3 && bw =3D=3D =
CHNL_BW_160)
+                                               bw =3D CHNL_BW_80;
+
+                                       /* BW 80, 3 SS MCS 6 is invalid in =
VHT */
+                                       if (bw =3D=3D CHNL_BW_80 &&
+                                           nss =3D=3D WRS_SS_3 &&
+                                           mcs =3D=3D WRS_MCS_6)
+                                               continue;
+                               }
+
+                               data_rate =3D data_rate_ht_vht_x10[bw][nss]=
[mcs][gi];
+                       }
+
+                       if (data_rate > max_data_rate) {
+                               selected_mcs =3D mcs;
+                               selected_nss =3D nss;
+                               selected_bw =3D bw;
+                               max_data_rate =3D data_rate;
+                               rate_idx =3D cl_wrs_tables_find_rate_idx(wr=
s_params,
+                                                                      bw, =
nss, mcs, gi);
+                       }
+
+                       break;
+               }
+       }
+
+       if (cl_env_det_is_noisy(cl_hw) || cl_env_det_is_very_noisy(cl_hw)) =
{
+               /* In conservative mode select less agressive parameters */
+               if (wrs_db->conservative_nss_noisy_env && selected_nss > 0)
+                       selected_nss--;
+
+               if (wrs_db->conservative_nss_noisy_env && selected_mcs > 0)
+                       selected_mcs--;
+
+               /* BW 80, 3 SS MCS 6 is invalid in VHT */
+               if (wrs_sta->mode =3D=3D WRS_MODE_VHT &&
+                   selected_bw =3D=3D CHNL_BW_80 &&
+                   selected_nss =3D=3D WRS_SS_3 &&
+                   selected_mcs =3D=3D WRS_MCS_6)
+                       selected_mcs--;
+
+               rate_idx =3D cl_wrs_tables_find_rate_idx(wrs_params,
+                                                      selected_bw, selecte=
d_nss, selected_mcs, gi);
+       }
+
+       return rate_idx;
+}
+
+static u16 cl_wrs_rssi_find_rate_cck_ofdm(struct cl_wrs_sta *wrs_sta,
+                                         s8 *rssi_sort, s8 *thresholds)
+{
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+       u8 max_mcs =3D wrs_sta->max_rate_cap.mcs;
+       u8 mcs =3D 0;
+       u8 i =3D 0;
+
+       for (i =3D 0; i <=3D max_mcs; i++) {
+               mcs =3D max_mcs - i;
+
+               if (rssi_sort[WRS_SS_1] > thresholds[i])
+                       return cl_wrs_tables_find_rate_idx(wrs_params,
+                                                          CHNL_BW_20, WRS_=
SS_1, mcs, WRS_GI_LONG);
+       }
+
+       return 0;
+}
+
+static u16 cl_wrs_rssi_find_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wr=
s_db,
+                                struct cl_wrs_sta *wrs_sta, s8 *rssi_sort)
+{
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+       u16 rate_idx =3D 0;
+
+       switch (wrs_sta->mode) {
+       case WRS_MODE_HE:
+               rate_idx =3D cl_wrs_rssi_find_rate_ht_vht_he(cl_hw, wrs_db,=
 wrs_sta,
+                                                          rssi_sort, rssi_=
threshold_he);
+               break;
+       case WRS_MODE_VHT:
+               rate_idx =3D cl_wrs_rssi_find_rate_ht_vht_he(cl_hw, wrs_db,=
 wrs_sta,
+                                                          rssi_sort, rssi_=
threshold_vht);
+               break;
+       case WRS_MODE_HT:
+               rate_idx =3D cl_wrs_rssi_find_rate_ht_vht_he(cl_hw, wrs_db,=
 wrs_sta,
+                                                          rssi_sort, rssi_=
threshold_ht);
+               break;
+       case WRS_MODE_OFDM:
+               rate_idx =3D cl_wrs_rssi_find_rate_cck_ofdm(wrs_sta, rssi_s=
ort,
+                                                         rssi_threshold_of=
dm);
+               break;
+       case WRS_MODE_CCK:
+               rate_idx =3D cl_wrs_rssi_find_rate_cck_ofdm(wrs_sta, rssi_s=
ort,
+                                                         rssi_threshold_cc=
k);
+               break;
+       default:
+               break;
+       }
+
+       if (rate_idx =3D=3D WRS_INVALID_RATE)
+               rate_idx =3D 0;
+
+       wrs_pr_trace(wrs_db,
+                    "[WRS] Select rate based rssi - sta=3D%u, rssi [%d,%d,=
%d,%d], "
+                    "rate_idx=3D%u, bw=3D%u, nss=3D%u, mcs=3D%u\n",
+                    wrs_sta->sta_idx,
+                    rssi_sort[0],
+                    rssi_sort[1],
+                    rssi_sort[2],
+                    rssi_sort[3],
+                    rate_idx,
+                    wrs_params->table[rate_idx].rate.bw,
+                    wrs_params->table[rate_idx].rate.nss,
+                    wrs_params->table[rate_idx].rate.mcs);
+
+       return rate_idx;
+}
+
+bool cl_wrs_rssi_set_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                         struct cl_wrs_sta *wrs_sta)
+{
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+       s8 rssi_sort[MAX_ANTENNAS] =3D {0};
+       u16 new_rate_idx =3D 0;
+
+       /* Get rssi */
+       cl_wrs_rssi_eq_calc(cl_hw, wrs_sta, true, rssi_sort);
+
+       /* Find new rate according to rssi thresholds */
+       new_rate_idx =3D cl_wrs_rssi_find_rate(cl_hw, wrs_db, wrs_sta, rssi=
_sort);
+
+       if (new_rate_idx !=3D wrs_params->rate_idx) {
+               cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params,
+                                      WRS_DECISION_RSSI_MGMT, new_rate_idx=
);
+               cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                       new_rate_idx, false);
+       } else {
+               wrs_params->sync =3D true;
+       }
+
+       return true;
+}
+
+/*
+ * Section #2:
+ * rssi protect.
+ */
+static void cl_wrs_rssi_prot_set_avg(struct cl_wrs_sta *wrs_sta, s8 avg)
+{
+       struct cl_wrs_rssi_prot_db *rssi_prot_db =3D &wrs_sta->rssi_prot_db=
;
+
+       memset(rssi_prot_db->samples_old, avg, WRS_RSSI_PROTECT_BUF_SZ_OLD)=
;
+       memset(rssi_prot_db->samples_new, avg, WRS_RSSI_PROTECT_BUF_SZ_NEW)=
;
+       rssi_prot_db->sum =3D avg << WRS_RSSI_PROTECT_SHIFT;
+}
+
+static s8 cl_wrs_rssi_prot_add_smpl(struct cl_wrs_sta *wrs_sta, s8 rssi_eq=
)
+{
+       struct cl_wrs_rssi_prot_db *rssi_prot_db =3D &wrs_sta->rssi_prot_db=
;
+       u8 curr_idx_old =3D rssi_prot_db->curr_idx_old;
+       u8 curr_idx_new =3D rssi_prot_db->curr_idx_new;
+
+       rssi_prot_db->sum +=3D
+               rssi_prot_db->samples_new[curr_idx_new] - rssi_prot_db->sam=
ples_old[curr_idx_old];
+       rssi_prot_db->samples_old[curr_idx_old] =3D rssi_prot_db->samples_n=
ew[curr_idx_new];
+       rssi_prot_db->samples_new[curr_idx_new] =3D rssi_eq;
+
+       rssi_prot_db->curr_idx_old =3D
+               WRS_INC_POW2(rssi_prot_db->curr_idx_old, WRS_RSSI_PROTECT_B=
UF_SZ_OLD);
+       WRS_INC(rssi_prot_db->curr_idx_new, WRS_RSSI_PROTECT_BUF_SZ_NEW);
+
+       return (s8)(wrs_sta->rssi_prot_db.sum >> WRS_RSSI_PROTECT_SHIFT);
+}
+
+static bool cl_wrs_rssi_prot_decision_up(struct cl_hw *cl_hw, struct cl_wr=
s_db *wrs_db,
+                                        struct cl_wrs_sta *wrs_sta, s8 rss=
i_avg, s8 rssi_eq,
+                                        s8 *rssi_sort, u8 up_rate_idx)
+{
+       /* Decide UP only if all new samples are greater than old average *=
/
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+       s8 *samples_new =3D wrs_sta->rssi_prot_db.samples_new;
+       s8 up_thr =3D rssi_avg + wrs_db->rssi_protect_up_thr;
+       u8 i =3D 0;
+
+       for (i =3D 0; i < WRS_RSSI_PROTECT_BUF_SZ_NEW; i++)
+               if (samples_new[i] <=3D up_thr)
+                       return false;
+
+       if (wrs_db->rssi_protect_mode =3D=3D WRS_RSSI_PROT_MODE_RSSI) {
+               u16 rate_idx_old =3D wrs_params->rate_idx;
+               u16 rate_idx_new =3D cl_wrs_rssi_find_rate(cl_hw, wrs_db, w=
rs_sta, rssi_sort);
+               struct cl_wrs_rate *rate_old =3D &wrs_params->table[rate_id=
x_old].rate;
+               struct cl_wrs_rate *rate_new =3D &wrs_params->table[rate_id=
x_new].rate;
+               u16 data_rate_old =3D cl_data_rates_get_x10(wrs_sta->mode, =
rate_old->bw,
+                                                         rate_old->nss, ra=
te_old->mcs,
+                                                         rate_old->gi);
+               u16 data_rate_new =3D cl_data_rates_get_x10(wrs_sta->mode, =
rate_new->bw,
+                                                         rate_new->nss, ra=
te_new->mcs,
+                                                         rate_new->gi);
+
+               if (rate_idx_old =3D=3D rate_idx_new || data_rate_old >=3D =
data_rate_new)
+                       rate_idx_new =3D up_rate_idx;
+
+               wrs_pr_info(wrs_db, "[WRS] Increase rate based on RSSI - ol=
d [%u], new [%u]\n",
+                           rate_idx_old, rate_idx_new);
+               cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params,
+                                      WRS_DECISION_UP_RSSI, rate_idx_new);
+               cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta,
+                                       wrs_params, rate_idx_new, true);
+       } else {
+               cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                    WRS_DECISION_UP_RSSI, up_rate_idx);
+       }
+
+       cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+       cl_wrs_rssi_prot_set_avg(wrs_sta, rssi_eq);
+
+       return true;
+}
+
+static bool cl_wrs_rssi_prot_decision_down(struct cl_hw *cl_hw, struct cl_=
wrs_db *wrs_db,
+                                          struct cl_wrs_sta *wrs_sta, s8 r=
ssi_avg, s8 rssi_eq,
+                                          s8 *rssi_sort, u8 down_rate_idx)
+{
+       /* Decide DOWN only if all new samples are smaller than old average=
 */
+       struct cl_wrs_params *wrs_params =3D &wrs_sta->su_params;
+       s8 *samples_new =3D wrs_sta->rssi_prot_db.samples_new;
+       s8 dn_thr =3D rssi_avg - wrs_db->rssi_protect_dn_thr;
+       u8 i =3D 0;
+
+       if (wrs_params->rate_idx =3D=3D 0)
+               return false;
+
+       for (i =3D 0; i < WRS_RSSI_PROTECT_BUF_SZ_NEW; i++)
+               if (samples_new[i] >=3D dn_thr)
+                       return false;
+
+       if (wrs_db->rssi_protect_mode =3D=3D WRS_RSSI_PROT_MODE_RSSI) {
+               u16 rate_idx_old =3D wrs_params->rate_idx;
+               u16 rate_idx_new =3D cl_wrs_rssi_find_rate(cl_hw, wrs_db, w=
rs_sta, rssi_sort);
+               struct cl_wrs_rate *rate_old =3D &wrs_params->table[rate_id=
x_old].rate;
+               struct cl_wrs_rate *rate_new =3D &wrs_params->table[rate_id=
x_new].rate;
+               u16 data_rate_old =3D cl_data_rates_get_x10(wrs_sta->mode, =
rate_old->bw,
+                                                         rate_old->nss, ra=
te_old->mcs,
+                                                         rate_old->gi);
+               u16 data_rate_new =3D cl_data_rates_get_x10(wrs_sta->mode, =
rate_new->bw,
+                                                         rate_new->nss, ra=
te_new->mcs,
+                                                         rate_new->gi);
+
+               if (rate_idx_old =3D=3D rate_idx_new || data_rate_old <=3D =
data_rate_new)
+                       rate_idx_new =3D down_rate_idx;
+
+               wrs_pr_info(wrs_db, "[WRS] Decrease rate based on RSSI - ol=
d [%u], new [%u]\n",
+                           rate_idx_old, rate_idx_new);
+               cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params,
+                                      WRS_DECISION_DOWN_RSSI, rate_idx_new=
);
+               cl_wrs_tx_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                       rate_idx_new, true);
+       } else {
+               cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+                                    WRS_DECISION_DOWN_RSSI, down_rate_idx)=
;
+       }
+
+       cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+       cl_wrs_rssi_prot_set_avg(wrs_sta, rssi_eq);
+
+       return true;
+}
+
+static void cl_wrs_rssi_prot_reset(struct cl_hw *cl_hw, struct cl_sta *cl_=
sta)
+{
+       memset(&cl_sta->wrs_sta.rssi_prot_db, 0, sizeof(struct cl_wrs_rssi_=
prot_db));
+}
+
+void cl_wrs_rssi_prot_start(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_wrs_sta *wrs_sta =3D &cl_sta->wrs_sta;
+       s8 rssi_sort[MAX_ANTENNAS] =3D {0};
+       s8 rssi_eq =3D 0;
+
+       if (!cl_hw->wrs_db.rssi_protect_en)
+               return;
+
+       rssi_eq =3D cl_wrs_rssi_eq_calc(cl_hw, wrs_sta, false, rssi_sort);
+       cl_wrs_rssi_prot_set_avg(wrs_sta, rssi_eq);
+}
+
+bool cl_wrs_rssi_prot_decision(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_=
db,
+                              struct cl_wrs_sta *wrs_sta, bool up_rate_val=
id,
+                              u8 up_rate_idx, u8 down_rate_idx)
+{
+       s8 rssi_avg =3D 0;
+       s8 rssi_eq =3D 0;
+       s8 rssi_sort[MAX_ANTENNAS] =3D {0};
+
+       rssi_eq =3D cl_wrs_rssi_eq_calc(cl_hw, wrs_sta, true, rssi_sort);
+       rssi_avg =3D cl_wrs_rssi_prot_add_smpl(wrs_sta, rssi_eq);
+
+       if (up_rate_valid)
+               if (cl_wrs_rssi_prot_decision_up(cl_hw, wrs_db, wrs_sta, rs=
si_avg,
+                                                rssi_eq, rssi_sort, up_rat=
e_idx))
+                       return true;
+
+       return cl_wrs_rssi_prot_decision_down(cl_hw, wrs_db, wrs_sta, rssi_=
avg,
+                                             rssi_eq, rssi_sort, down_rate=
_idx);
+}
+
+void cl_wrs_rssi_prot_dbg(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+                         struct cl_wrs_sta *wrs_sta)
+{
+       struct cl_wrs_rssi_prot_db *rssi_prot_db =3D NULL;
+       u8 curr_idx_old =3D 0;
+       u8 curr_idx_new =3D 0;
+       u8 rate_idx =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       if (!wrs_db->rssi_protect_en) {
+               cl_snprintf(&buf, &len, &buf_size, "RSSI protect is disable=
d!\n");
+               goto out;
+       }
+
+       rssi_prot_db =3D &wrs_sta->rssi_prot_db;
+       curr_idx_old =3D rssi_prot_db->curr_idx_old;
+       curr_idx_new =3D rssi_prot_db->curr_idx_new;
+
+       cl_snprintf(&buf, &len, &buf_size, "sta %u\n", wrs_sta->sta_idx);
+       cl_snprintf(&buf, &len, &buf_size, "Old rssi samples:");
+
+       for (rate_idx =3D 0; rate_idx < WRS_RSSI_PROTECT_BUF_SZ_OLD; rate_i=
dx++) {
+               if (!(rate_idx & 0x7))
+                       cl_snprintf(&buf, &len, &buf_size, "\n");
+
+               cl_snprintf(&buf, &len, &buf_size, "%3u) %d, ",
+                           rate_idx, rssi_prot_db->samples_old[curr_idx_ol=
d]);
+               curr_idx_old =3D WRS_INC_POW2(curr_idx_old, WRS_RSSI_PROTEC=
T_BUF_SZ_OLD);
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "\nAvg =3D [%d]\n\n",
+                   wrs_sta->rssi_prot_db.sum >> WRS_RSSI_PROTECT_SHIFT);
+
+       cl_snprintf(&buf, &len, &buf_size, "New rssi samples:\n");
+       for (rate_idx =3D 0; rate_idx < WRS_RSSI_PROTECT_BUF_SZ_NEW; rate_i=
dx++) {
+               cl_snprintf(&buf, &len, &buf_size, "%u) %d\n", rate_idx,
+                           rssi_prot_db->samples_new[curr_idx_new]);
+               curr_idx_new =3D WRS_INC_POW2(curr_idx_new, WRS_RSSI_PROTEC=
T_BUF_SZ_NEW);
+       }
+out:
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+void cl_wrs_rssi_prot_config(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db=
,
+                            bool enable, bool mode, s32 rssi_up_thr, s32 r=
ssi_dn_thr)
+{
+       bool en_prev =3D wrs_db->rssi_protect_en;
+
+       wrs_db->rssi_protect_en =3D enable;
+       wrs_db->rssi_protect_mode =3D mode;
+       wrs_db->rssi_protect_up_thr =3D (s8)rssi_up_thr;
+       wrs_db->rssi_protect_dn_thr =3D (s8)rssi_dn_thr;
+
+       if (!en_prev && wrs_db->rssi_protect_en)
+               cl_sta_loop_bh(cl_hw, cl_wrs_rssi_prot_start);
+       else if (en_prev && !wrs_db->rssi_protect_en)
+               cl_sta_loop_bh(cl_hw, cl_wrs_rssi_prot_reset);
+
+       pr_debug("[WRS] Enable =3D %s, Mode =3D %s, Up threshold =3D %d, Do=
wn threshold =3D %d\n",
+                wrs_db->rssi_protect_en ? "true" : "false",
+                wrs_db->rssi_protect_mode ? "rssi" : "neighbor",
+                wrs_db->rssi_protect_up_thr,
+                wrs_db->rssi_protect_dn_thr);
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

