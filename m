Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E263AB947
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhFQQPX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:15:23 -0400
Received: from mail-db8eur05on2051.outbound.protection.outlook.com ([40.107.20.51]:48736
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233730AbhFQQN3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:13:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjG0y+N1M/JVQ7hHG3TRrIueA6lfss7LCHB0PJNdjXF+bJ6D457soS9iqy9NOUxVc6TRqpjAp0AUYdhF751pX6gAg/CcsMoJbfKG/DH4O73CnViGsDb6bBuTGdeh7ENFFAsbrmiKvqUXBeBEuYlzkEBGbXmKQM18Hyf/ddXYj+M9Wou1tD1qvC911R7sNvmH/QP25WsVTFHR1p7psmjueYZQEstfUQxjwdaCL7gxW15CAehiUM+FVeKP41xcUpdLS06L12oeYQus0omiSd9mzn9YSM8b5t87JMcfoBrrykqmWsG39gG33rckBnO9gLaTBKZyF34xNh0ChSB/XRVhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY7obaHnYjSEoHuV1OnnOh4mi0m7jCL8rSqVq8sHuDU=;
 b=a6SkQjtWFAFNCYS2pEidBPOj89jtGyHovmmUBGbAodP55Eo+/E7jsdViokCW9+TPWpLmrfRKfKPf3emst4iJ6ZjVovkem8jCRkeyE59umOGa9eFuEFIkqxYwYwi/ta9VOH9sDIlAQ5kMh2eEwD374qxnlGJXTB1Hk54FzUVVDZX8Rj/p+x9CWac8B9e5yHnMS5eSzUgUm331UDfGy/m5DvCvqBufLhbJIdKTU83fc9aCRTEVXBFxe9bEBQRMAOeWvIHug3A/gO1wDiah6cUuKw3oG/xBpjNb63cDamjaKm11Z4HyttUETbgF0io6kUmbWQUsI2j1kXjNUvk5NlvV+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aY7obaHnYjSEoHuV1OnnOh4mi0m7jCL8rSqVq8sHuDU=;
 b=O4GNI1q3KTW2FJLKv8Zwjyn+hJy/cOAdyhhp7jlBXig2dPVvPmLrIGHDcQJDmcOlbORK+kUohhLRuYwYYXkYuc9yIM+c8KrnzL5HApzHnsCFBsuF0+b0C3H97XVOyOKTv6hi17H2yXsVKE3IW2X3XGbmvkyP2s/46tpZBoCzlbM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:08:36 +0000
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
Subject: [RFC v1 252/256] cl8k: add wrs/wrs_stats.c
Date:   Thu, 17 Jun 2021 16:02:19 +0000
Message-Id: <20210617160223.160998-253-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28d0f96d-06a7-4fd5-6e01-08d931a9f9ce
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB0978DB3D7F6828D8DE77AE96F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:17;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDV87QyAq+WZkPoz4vwI0IwG3G1tzfqW2+l8Mbb42CRh90aSVakmroG58N/+qhF+7Wlhh/g9oTbjNjAX5qiYz5ivOzQ2Cbyu4ImUUIDiQV/bYxY0W3xsv8LOxGednfTw+VVbNXQYupRtEBG2lTnlXPLqZOmJd2oakEBiVopFTt387HtOTbl3AgF+zxF4s993qZ7gyhRrkyoPRWxyusl2YKd5YBGOPAbtuIhvJTfo0z0gfCMg9x3VIPiGBKqXrnZQte46RwMK6V3/TZAWZlFqEa6LUlG0xV+TVSzr9ewydxp15MUrQw7N+cbW+rd2LNp8oOXPkpMoBa9lFf92lotkDD9zEBFu2klzrGzLZH9G/owKw2HTrFvzQhKLJaMnx+jidZBgD6Z7srwyMkJg8L6PTSqe0xlXJFvgfkHsW2ny8DY7NoYO0d0GFpPfT41EFE8+ARSZgB5SG3gDvRJtemAw6mLGPJ5LNhmyuvXH9PWWI3jnSHsT+Wmx5stSupcvz9JSWE+BCASTgTxlMWrLW/kmAbcXq5PafY0U/b2ap+156mLpOgSv+We2OPGbOwiQ4+aDgE2VXYjgdSrkWK8wN+2fgxpe7s31gBcgIYWpfwC7tRxerd+BYGEReEuXGW5uB3FY3JUvG349NxtqVSjDwkGmY0WdonKMqHxfRIHE4Yb7quDV387p4yaKb22WQThIvgz98/cMrHw1/TLhCGgpcsUNtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(5660300002)(66556008)(83380400001)(26005)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AyJ1tEFyaNburF/eTyRM/s80AaJG4N7RbqiXoBukbHq8vcEQT0GODZVtfZpT?=
 =?us-ascii?Q?Hr76KtpV9c9c0oTw7vGyvbc7ZvtC/pcG0gn64Vz9cvHYclVdIgd2BVZIw7LV?=
 =?us-ascii?Q?gbxsBUHtcI3ZFrdv7+O5hQCOJLbD9PUwcxU7eAlEDxpdO3wI/omXLXAdlZ/X?=
 =?us-ascii?Q?OUUNLOm6d1qeB+v7+XsP4M4l0oESr22gkV8TfiBS9upevlmwyBHFJAizyBVo?=
 =?us-ascii?Q?uYdJbc6di1Ke83bkH44lxQ7tgWgdxChG+dabIkNtu4zxbMcX01xdGOGcSY+/?=
 =?us-ascii?Q?xbU0mb+9/ky/HmW1NHOXdmZTQT4jgDicrrU6+c4O+YvWKyHmqzd0A8RAvqQT?=
 =?us-ascii?Q?p/MWjsueOH4cYPL/wc78y2kGVvncfl2gIo7AHcTOLNs8LsDqeRnM7W+o+Fav?=
 =?us-ascii?Q?96hZkruxR1sud+RT9yqOjuYxfF3T7EIBlNuWCp3/RF0K1/0mxlLOXm0d2E73?=
 =?us-ascii?Q?sei1MiD4/SPQ+q767A6vKxoSReHyA70WNhIxSXMRLj9IQ+KKzyHM3mpYcKZC?=
 =?us-ascii?Q?9tCqdxv+ICpME/QiTwAatrhBBGanK/S/ZPxFBTbvDCaTVmp7RfQTWgEoLIbF?=
 =?us-ascii?Q?HiIw1lgv5Jn5zmFbK5P/zb21dcd99cBvEVc/5obKD+8ubesRO9DPJXO3FuE/?=
 =?us-ascii?Q?K9QTHWgeuBL7mGDY5vWOR4kR8AXEtnOehXcDc6XQQu496Wz359xIXLa9nFT4?=
 =?us-ascii?Q?dBTCsZYXziTQ8H+ugECLODh6wKx5xu++i3FB4rJtcvO0a6XygJj+icaNEIoa?=
 =?us-ascii?Q?asfowWa8tdTPV2dk8unvspIZFmPx1YY0Jr+xwb82o6H4oOrgEZYU0V26XNEK?=
 =?us-ascii?Q?Ufs9YHFfXCGJlVxU2JdH9Zqq1jlgicsO7moSzEE7jJatQ/sNVOOjyePDrPAb?=
 =?us-ascii?Q?wa2aqHtdLw9E/ASfJO08hFt2nxjr4Puip9BalIO/Cm+s74mlq5Ft3/dfh/En?=
 =?us-ascii?Q?xhxtysFtuwDYzu9D+9AtLDpcEJj/SwFjiDUZZ76B3BfFmNjdPPH4po+le4Ez?=
 =?us-ascii?Q?DetdYHq7j7iiavh76aYhxKXKhj+wqCcdFCQggMNS8rxKxbxPUKOpCNuLrOT9?=
 =?us-ascii?Q?KDjeckMr3t0LjAqfb3W5Wu3Cdb7WKJ5wW7CtCBmZJu8P4onq5jIrbn6BVdSy?=
 =?us-ascii?Q?rzGHA6Nyc8kAERTKaTlRRG/qsljo/fYZnWRJU3W/Cspc9O6D0jc/IhagcamN?=
 =?us-ascii?Q?pphLK+n6zQqETCSwGSnWW9rUIOYTS1Ck8OkGzQHV6DLe2m3NaeGBOkz3Cp/X?=
 =?us-ascii?Q?RlHOnh3kca1JAmkdTQR13nXg+uALLbSlR5YWGhO84Tl3BbsW+gWrQTv0gRcA?=
 =?us-ascii?Q?FgHmYNozKbcuPp6tayBQU56D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d0f96d-06a7-4fd5-6e01-08d931a9f9ce
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:16.1647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ac5fGOm0/eUePcDK2xhEzgyQ/eNudDcumnwhCUXnTCGTzzAPPm3hPk34H1MDrL2GQwi1fk8Hmv3fpBbwbxp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/wrs/wrs_stats.c  | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.c b/drivers/net=
/wireless/celeno/cl8k/wrs/wrs_stats.c
new file mode 100644
index 000000000000..3e477e82a16a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_stats.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "wrs/wrs_stats.h"
+#include "wrs/wrs.h"
+#include "utils/utils.h"
+
+static struct cl_wrs_per_stats *cl_wrs_stats_per_entry(struct cl_wrs_param=
s *wrs_params)
+{
+       struct cl_wrs_per_stats *per_stats =3D NULL, *per_stats_new =3D NUL=
L;
+       struct cl_wrs_tx_params *tx_params =3D &wrs_params->tx_params;
+       struct list_head *list_rates =3D &wrs_params->list_rates;
+       u8 bw =3D tx_params->bw;
+       u8 nss =3D tx_params->nss;
+       u8 mcs =3D tx_params->mcs;
+       u8 gi =3D tx_params->gi;
+
+       list_for_each_entry(per_stats, list_rates, list) {
+               if (per_stats->bw !=3D bw ||
+                   per_stats->nss !=3D nss ||
+                   per_stats->mcs !=3D mcs ||
+                   per_stats->gi !=3D gi)
+                       continue;
+
+               /*
+                * Move the entry to the beginning of the list, so that it
+                * will be faster to find next time.
+                */
+               if (per_stats !=3D list_entry(list_rates->next, struct cl_w=
rs_per_stats, list)) {
+                       list_del(&per_stats->list);
+                       list_add(&per_stats->list, list_rates);
+               }
+
+               return per_stats;
+       }
+
+       /* Entry not found - allocate new entry and add to list */
+       per_stats_new =3D kzalloc(sizeof(*per_stats_new), GFP_ATOMIC);
+
+       if (!per_stats_new)
+               return NULL;
+
+       per_stats_new->bw =3D bw;
+       per_stats_new->nss =3D nss;
+       per_stats_new->mcs =3D mcs;
+       per_stats_new->gi =3D gi;
+
+       list_add(&per_stats_new->list, &wrs_params->list_rates);
+
+       return per_stats_new;
+}
+
+void cl_wrs_stats_per_update(struct cl_wrs_db *wrs_db,
+                            struct cl_wrs_sta *wrs_sta,
+                            struct cl_wrs_params *wrs_params,
+                            struct cl_wrs_tx_cntrs *tx_cntrs)
+{
+       u16 curr_rate_idx =3D wrs_params->rate_idx;
+       struct cl_wrs_table *table_node =3D &wrs_params->table[curr_rate_id=
x];
+       struct cl_wrs_per_stats *per_stats =3D cl_wrs_stats_per_entry(wrs_p=
arams);
+
+       if (!per_stats)
+               return;
+
+       wrs_params->frames_total +=3D tx_cntrs->total;
+       wrs_params->fail_total +=3D tx_cntrs->fail;
+       wrs_params->ba_not_rcv_total +=3D tx_cntrs->ba_not_rcv;
+       wrs_params->epr_acc +=3D tx_cntrs->epr_acc;
+
+       per_stats->frames_total +=3D tx_cntrs->total;
+       per_stats->frames_failed +=3D tx_cntrs->fail;
+       per_stats->epr_acc +=3D tx_cntrs->epr_acc;
+
+       if (wrs_params->calc_ba_not_rcv) {
+               per_stats->frames_total +=3D tx_cntrs->ba_not_rcv;
+               per_stats->frames_failed +=3D tx_cntrs->ba_not_rcv;
+       }
+
+       table_node->frames_total =3D wrs_params->frames_total;
+       table_node->ba_not_rcv_total =3D wrs_params->ba_not_rcv_total;
+       table_node->epr_acc =3D wrs_params->epr_acc;
+}
+
+struct per_info {
+       u32 frames_failed;
+       u32 frames_total;
+       u64 epr_acc;
+};
+
+static void _cl_wrs_stats_per_print(char **buf, int *len, ssize_t *buf_siz=
e,
+                                   struct cl_wrs_rate *curr_rate,
+                                   struct per_info *per_info,
+                                   u64 total_all_rates,
+                                   u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+       u64 frames_total =3D per_info->frames_total;
+       u64 frames_failed =3D per_info->frames_failed;
+       u64 epr_acc =3D per_info->epr_acc;
+       u32 per_high =3D 0, per_low =3D 0, usage_high =3D 0, usage_low =3D =
0, epr_high =3D 0, epr_low =3D 0;
+
+       if (frames_total =3D=3D 0)
+               return;
+
+       cl_div64_decimal(100 * frames_failed, frames_total, &per_high, &per=
_low);
+       cl_div64_decimal(100 * frames_total, total_all_rates, &usage_high, =
&usage_low);
+       cl_div64_decimal(epr_acc, frames_total * WRS_DATA_RATE_FACTOR, &epr=
_high, &epr_low);
+
+       cl_snprintf(buf, len, buf_size,
+                   "|%3s|%3u|%3u|%-9s|%4u.%02u|%10llu|%10llu|%3u.%02u|%4u.=
%02u|",
+                   WRS_BW_STR(bw), nss, mcs, WRS_GI_STR(gi),
+                   usage_high, usage_low, frames_failed,
+                   frames_total, per_high, per_low, epr_high,
+                   epr_low);
+
+       /* Add an arrow to the current rate */
+       if (curr_rate->bw =3D=3D bw &&
+           curr_rate->nss =3D=3D nss &&
+           curr_rate->mcs =3D=3D mcs &&
+           curr_rate->gi =3D=3D gi)
+               cl_snprintf(buf, len, buf_size, "<=3D=3D\n");
+       else
+               cl_snprintf(buf, len, buf_size, "\n");
+
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------------------------=
-------------|\n");
+}
+
+void cl_wrs_stats_per_print(struct cl_hw *cl_hw,
+                           struct cl_wrs_sta *wrs_sta,
+                           struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_rate *curr_rate =3D &wrs_params->table[wrs_params->ra=
te_idx].rate;
+       struct cl_wrs_per_stats *per_stats =3D NULL;
+       u8 bw =3D 0, nss =3D 0, mcs =3D 0, gi =3D 0;
+       u16 alloc_size =3D CHNL_BW_MAX * WRS_SS_MAX * WRS_MCS_MAX * WRS_GI_=
MAX;
+       u32 total_epr_high =3D 0, total_epr_low =3D 0;
+       u64 total_epr_acc =3D 0, total_all_rates =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+       struct per_info (*per_info_arr)[WRS_SS_MAX][WRS_MCS_MAX][WRS_GI_MAX=
] =3D
+               kzalloc(alloc_size * sizeof(struct per_info), GFP_ATOMIC);
+
+       if (!per_info_arr)
+               return;
+
+       list_for_each_entry(per_stats, &wrs_params->list_rates, list) {
+               bw =3D per_stats->bw;
+               nss =3D per_stats->nss;
+               mcs =3D per_stats->mcs;
+               gi =3D per_stats->gi;
+
+               total_all_rates +=3D per_stats->frames_total;
+               total_epr_acc +=3D per_stats->epr_acc;
+
+               per_info_arr[bw][nss][mcs][gi].frames_failed =3D per_stats-=
>frames_failed;
+               per_info_arr[bw][nss][mcs][gi].frames_total =3D per_stats->=
frames_total;
+               per_info_arr[bw][nss][mcs][gi].epr_acc =3D per_stats->epr_a=
cc;
+       }
+
+       if (total_all_rates =3D=3D 0) {
+               cl_snprintf(&buf, &len, &buf_size, "Table rate empty\n");
+               goto out;
+       }
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|-----------------------------------------------------=
-------------|\n"
+                   "|BW |NSS|MCS|GI       |Usage  |Fail      |Total     |P=
ER   |EPR    |\n"
+                   "|---+---+---+---------+-------+----------+----------+-=
-----+-------|\n");
+
+       for (bw =3D 0; bw <=3D wrs_sta->max_rate_cap.bw; bw++)
+               for (nss =3D 0; nss <=3D wrs_sta->max_rate_cap.nss; nss++)
+                       for (mcs =3D 0; mcs <=3D wrs_sta->max_rate_cap.mcs;=
 mcs++)
+                               for (gi =3D 0; gi <=3D wrs_sta->max_rate_ca=
p.gi; gi++)
+                                       _cl_wrs_stats_per_print(&buf, &len,=
 &buf_size,
+                                                               curr_rate,
+                                                               &per_info_a=
rr[bw][nss][mcs][gi],
+                                                               total_all_r=
ates,
+                                                               bw, nss, mc=
s, gi);
+
+       cl_div64_decimal(total_epr_acc, total_all_rates * WRS_DATA_RATE_FAC=
TOR,
+                        &total_epr_high, &total_epr_low);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "###  Effective PHY Rate =3D %u.%u Mbps  ###\n",
+                   total_epr_high, total_epr_low);
+
+out:
+       kfree(per_info_arr);
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+void cl_wrs_stats_per_reset(struct cl_wrs_params *wrs_params)
+{
+       cl_wrs_stats_per_remove(wrs_params);
+}
+
+void cl_wrs_stats_per_init(struct cl_wrs_params *wrs_params)
+{
+       INIT_LIST_HEAD(&wrs_params->list_rates);
+}
+
+void cl_wrs_stats_per_remove(struct cl_wrs_params *wrs_params)
+{
+       struct cl_wrs_per_stats *per_stats =3D NULL, *per_stats_next =3D NU=
LL;
+
+       list_for_each_entry_safe(per_stats, per_stats_next, &wrs_params->li=
st_rates, list) {
+               list_del(&per_stats->list);
+               kfree(per_stats);
+       }
+}
+
+void cl_wrs_stats_decision_print(struct cl_wrs_params *wrs_params)
+{
+       u32 *decision_cnt =3D wrs_params->decision_cnt;
+
+       pr_debug("\n");
+       pr_debug("----------------------------\n");
+       pr_debug("|Decision       |Count     |\n");
+       pr_debug("|--------------------------|\n");
+       pr_debug("|NONE           |%10u|\n", decision_cnt[WRS_DECISION_NONE=
]);
+       pr_debug("|SAME           |%10u|\n", decision_cnt[WRS_DECISION_SAME=
]);
+       pr_debug("|UP             |%10u|\n", decision_cnt[WRS_DECISION_UP])=
;
+       pr_debug("|UP QUICK       |%10u|\n", decision_cnt[WRS_DECISION_UP_Q=
UICK]);
+       pr_debug("|UP RSSI        |%10u|\n", decision_cnt[WRS_DECISION_UP_R=
SSI]);
+       pr_debug("|UP MCS1        |%10u|\n", decision_cnt[WRS_DECISION_UP_M=
CS1]);
+       pr_debug("|DOWN           |%10u|\n", decision_cnt[WRS_DECISION_DOWN=
]);
+       pr_debug("|DOWN RSSI      |%10u|\n", decision_cnt[WRS_DECISION_DOWN=
_RSSI]);
+       pr_debug("|DOWN IMMEDIATE |%10u|\n", decision_cnt[WRS_DECISION_DOWN=
_IMMEDIATE]);
+       pr_debug("|DOWN QUICK     |%10u|\n", decision_cnt[WRS_DECISION_DOWN=
_QUICK]);
+       pr_debug("|DOWN NO SYNC   |%10u|\n", decision_cnt[WRS_DECISION_DOWN=
_NO_SYNC]);
+       pr_debug("|RSSI MGMT      |%10u|\n", decision_cnt[WRS_DECISION_RSSI=
_MGMT]);
+       pr_debug("----------------------------\n");
+       pr_debug("\n");
+       pr_debug("Immediate drop ignore =3D [%u]\n", wrs_params->immediate_=
drop_ignore);
+}
+
+void cl_wrs_stats_decision_reset(struct cl_wrs_params *wrs_params)
+{
+       memset(&wrs_params->decision_cnt, 0, sizeof(wrs_params->decision_cn=
t));
+       wrs_params->immediate_drop_ignore =3D 0;
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

