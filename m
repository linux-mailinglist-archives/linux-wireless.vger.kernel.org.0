Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF43AB90A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhFQQMH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:07 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:33286
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231591AbhFQQKv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:10:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdg4TpqHutf2LTGhUSBXMZ8WUL3IXHKH7HJjmGBqouqRQ2Sj7Fap/wRRf2oHGX939mwLbtnQEy/AS4wpDSSZSnhA4oJnhkkuYIYZxKceQf7fWa/BU403ZQKEepiEYUt9orKKQpPg/vEpbHjOu470dUqnsFy/1/B9sEtEUUyFGdfB4oW63T0uGHVA5KMJowQh0b3eKom3xxzLJSjvhEvLXIf9KDJLUUx/Px6bSHZfE8yjJi54GfAuNi29XIhA1PNTxi2Ocb+QgtQXatEZLJttxCN5OpguhR9xblpAl36SU5L4LoGlVMlWvcH53z1ciacbSpv4u/Fj+37cHV/eePr9Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfAJyIqC65upTMzTte5zMzCwrop8pOboAoDABAp5ShQ=;
 b=PzEfMdR5Xn2KAEI5ICIZ2i+Ej+5KuCNVrg2BD16awrZkIa76F5B3c0t2fh2UPDrhiB88Awe2g/sh1UfN8gfFp9jVFohBS7eIXuHy6eL8sDMC9paCy8TYBm4f8S8nHwv71ybb/YmQU3d4b8N1t3v/7N2EIthpWOrLQjOI1oJ64v9OpEfrtYBxOE+WafQsqYQLKx3VB9W7CH/2Y4MJ3lc61d6YYYiP4bRioJToxROk0Wpx6s2kx+X8Fj4K8Ywg3IjFCSp+EklmP8Yge+n6xZ4cJVnWf6D0FFMb3uOpXudUpu2z+lL92HTZKB7vwgqxTaM/Xyxfnc0FgnvNXkad20twQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfAJyIqC65upTMzTte5zMzCwrop8pOboAoDABAp5ShQ=;
 b=aRzB3fcX+p1qI4qgG+6EzaQ2ug12oH6p06ZvQ69xjA/x0kISVOZ8LDlx3+5rc8nPDocM/2NyeGlRO4Gj+DMW5kam67ZGDPo74xCpYNVvr9pKcj67Ms1PsxN1Oi2Ptj+ekzAXdC0wyM6TXcsEY8Gn5RVd7JSZZ19C/BZv3oBxZtM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:08 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:08 +0000
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
Subject: [RFC v1 182/256] cl8k: add sta.c
Date:   Thu, 17 Jun 2021 16:01:09 +0000
Message-Id: <20210617160223.160998-183-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f65da1b-0e2b-4ab4-5876-08d931a9c9c5
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260FA6409017D38BDF36F63F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AbRtP4CSSHTTtAQmdMJl4apSehEOq5EOXDzIq+j0iSXLUd22hsDvfeTFdgTQOuzMIVynNwle2OS4gQr3+3s5JWZqD89xeRw0Rb/HqqlJnecrVhjQlRchaWHWNNaIxMB1SKFOGNRiyQIFh6CsrdiJYAe5VsI3Vl+TSc6ikkO1v/QwFlB1QUwLiBSoZFuHL08POJiZn++ofcM4R++X+Cp6PPF9/fcK4n5J6xCUariZ+uS42wqCqerTRV6YqsuIXPZzRvVVe7+8kOB/4nbOKjbDjYNoLTeu2b3/a5IJNA5VnhEWPIHSDkiO7GfutpMkUv9LklUt3vIQDfWawTDaYHs0hmMnk6TM8RnhmmxNrcBR4eKwIdvc+OjOSwxkj1xb19ML7/ahpV93juyPyv7MCYJarqccro3oGVP17GITiAh41tcjnepviilxmVDMRkG6FO1Gl1KIsmw6z1GKI3EHApTA7dZFvPP3ihHtIEQRUgUiU6/urdSoGt46ikyvSxDNdXmyi6D36Wjci33HHaFOjR7BHttUkMcO8btXhzrqpjBGs4+Gi26mxSLuglc3pbqeWfb3N2rqOJXmbcI7mzvroptH0lj1754zGmq+a0tt+xoNet5V4GWMeet8sSNmF4I1+g7U3hQ7uzT8OrUXGxc7n2ofeDy0Yet09jlz8g0uvmylIpJh/8gDB+CEUR5vIoarR5ahByoAi+z3/9oHAVRPXiGXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7j44HqXmvtZmT5qAlmZyy4sRh9nlgbkfaX9A4GDfwn6RqkrTLCREQXfW21kt?=
 =?us-ascii?Q?VmLG4pbX+sX6aZzgiIcr1VpsGvUt4iSn84KzCil0SwmQuewgj0UZMZKYojUl?=
 =?us-ascii?Q?f7hbsTOVXcpOhhlJaKZ/HpVBUbX9fVuuxRqNcBGnnTJOHo9gkIilmILJj/QF?=
 =?us-ascii?Q?7exlvVklueV1Qxg05GHhQ2XuX8/6vOKA39oV9W8zNyto9pCIHEF2Bpmnz4lh?=
 =?us-ascii?Q?6AEG0ljMZTynwYUUiyVfz9kQv8q8y4uSPQW62AEeMMlF8uCzhbiZZ4AIvHFV?=
 =?us-ascii?Q?Uwh2PD/mfiNERx59ncaQm9nAv4cLoGuvh6EKJYDUnHg2PfP7zK46UGHhyfR2?=
 =?us-ascii?Q?OrRms/86KdVnbIarpT9Jd2cfjVaAYzooq0Rehgh2wxZpuuuU+E4wIU0HbovE?=
 =?us-ascii?Q?eNq01hIEaOGUekZ33BQtKbqmJmStIHtlL0YyGV+mXumCQFVThELnskSBnKlX?=
 =?us-ascii?Q?8xxFu7H+JW3Zi0tLK4PVTgWX1E3NNWD3BULDfqNbFT4tpW4+49i3G/1T9EPa?=
 =?us-ascii?Q?7CCXUTeZulyvpvPCmcBEM4vw2XRL1hWnlJzEJl8Vlp/w6vcqe8+8XHrgcQrB?=
 =?us-ascii?Q?7PS7VZgLOYIDrU3ll99UlWWKIRQb82hDV+NIlaC9xTgw3B+ZkNpuMZ9IZwNS?=
 =?us-ascii?Q?9agYsZA5PNcnemfsUI1Yqm7uYD7rc894tGLMY6USyVYPrpck0MaJgxL5+q0k?=
 =?us-ascii?Q?KC1w8bUiUFOzK3Of3/2KV9GxQ+Cm2bF1R6I5c/QGK8fjR5uaP9KOninGUvny?=
 =?us-ascii?Q?z7YtPTTv5jCWSCHLPEVEEW4q91JwL50r6zCoK7bppzyOIw3KqZ9Az1CNgI3e?=
 =?us-ascii?Q?PoVBVPASj99Zr9Uwvd/mtrAmL1oKCjF6bKPrYEQaIT88cay60G3HeoZUtZ7s?=
 =?us-ascii?Q?kS8ClWuzTl+z6VygAYD5W6V6o4ijiM78btIxp5sOjduU5PvlekW5RY2vzLgs?=
 =?us-ascii?Q?l3wakI2DDF5uotzyQJCHEn0NLHX0SDsO2pBSRO38DrGZdjr3JxoI1/oxtILC?=
 =?us-ascii?Q?eB1APo99UYc/RpRSRj/hzYTyj40DyuQdQq/5P5BlVGh7SkfU4SAP4x1QDWZE?=
 =?us-ascii?Q?SNC07WVmQoTblIETYPKnnZb8XnVgd3uBi5p9yOObHcbYoXikL8Vybes+NzGL?=
 =?us-ascii?Q?SD6ZLtKDPjirsnfGCmhjNKU/k/FYx4EiMS81J3BLYQLEwEgh3eYbnZNBZZtY?=
 =?us-ascii?Q?2LCGqwjESOISJtYWN5vv/teIk7W/4YxuWdJBGHE5S4agUF+MTYzQ26FlKpNA?=
 =?us-ascii?Q?LnWIie6N+hlIY8gQSXdtKr8JU8kVgfDhUFGY0odKyIVueZBjW1r0kr/cYG6w?=
 =?us-ascii?Q?NCeMTCTNG30/nOYdALQXgGDP?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f65da1b-0e2b-4ab4-5876-08d931a9c9c5
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:55.7030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ExWAmc1de8CVJOwKqwYoVdv+7WeMjIlT3tGuDG8UHHg5wx4Tnb4TuZQy+W9CrMuJyvNHKn4S57d0hqWKvKEu7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/sta.c | 536 +++++++++++++++++++++++++
 1 file changed, 536 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/sta.c

diff --git a/drivers/net/wireless/celeno/cl8k/sta.c b/drivers/net/wireless/=
celeno/cl8k/sta.c
new file mode 100644
index 000000000000..625edd51cb93
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/sta.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "sta.h"
+#include "rssi.h"
+#include "bf.h"
+#include "stats.h"
+#include "wrs/wrs_api.h"
+#include "utils/utils.h"
+#include "band.h"
+#include "vns.h"
+#include "radio.h"
+#include "tx/tx_inject.h"
+#include "twt.h"
+#include "motion_sense.h"
+#include "mac_addr.h"
+#include "tx/baw.h"
+#include "recovery.h"
+#include "tx/tx_queue.h"
+#include "tx/single_cfm.h"
+#include "ext/dyn_mcast_rate.h"
+#include "ext/dyn_bcast_rate.h"
+#include "chip.h"
+#include "fw/msg_tx.h"
+
+void cl_sta_init(struct cl_hw *cl_hw)
+{
+       u32 i;
+
+       rwlock_init(&cl_hw->cl_sta_db.lock);
+       INIT_LIST_HEAD(&cl_hw->cl_sta_db.head);
+
+       for (i =3D 0; i < CL_STA_HASH_SIZE; i++)
+               INIT_LIST_HEAD(&cl_hw->cl_sta_db.hash[i]);
+}
+
+void cl_sta_init_stainfo(struct cl_hw *cl_hw, struct sta_info *stainfo)
+{
+       if (!cl_recovery_in_progress(cl_hw)) {
+
+               struct cl_sta *cl_sta =3D STA_INFO_TO_CL_STA(stainfo);
+
+               /* Reset all cl_sta structure */
+               memset(cl_sta, 0, sizeof(struct cl_sta));
+               cl_sta->stainfo =3D stainfo;
+               /*
+                * Set sta_idx to 0xFF since FW expects this value as long =
as
+                * the STA is not fully connected
+                */
+               cl_sta->sta_idx =3D STA_IDX_INVALID;
+       }
+}
+
+static void cl_sta_add_to_lut(struct cl_hw *cl_hw, struct cl_vif *cl_vif, =
struct cl_sta *cl_sta)
+{
+       write_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       cl_hw->cl_sta_db.num++;
+       cl_vif->num_sta++;
+       cl_hw->cl_sta_db.lut[cl_sta->sta_idx] =3D cl_sta;
+
+       /* Done here inside the lock because it allocates cl_stats */
+       cl_stats_sta_add(cl_hw, cl_sta);
+
+       write_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+       cl_dbg_verbose(cl_hw, "mac=3D%pM, sta_idx=3D%u, vif_index=3D%u\n",
+                      cl_sta->addr, cl_sta->sta_idx, cl_sta->cl_vif->vif_i=
ndex);
+}
+
+static void cl_sta_add_to_list(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       u8 hash_idx =3D CL_STA_HASH_IDX(cl_sta->addr[5]);
+
+       write_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       /* Add to hash table */
+       list_add(&cl_sta->list_hash, &cl_hw->cl_sta_db.hash[hash_idx]);
+
+       /* Make sure that cl_sta's are stored in the list according to thei=
r sta_idx. */
+       if (list_empty(&cl_hw->cl_sta_db.head)) {
+               list_add(&cl_sta->list, &cl_hw->cl_sta_db.head);
+       } else if (list_is_singular(&cl_hw->cl_sta_db.head)) {
+               struct cl_sta *cl_sta_singular =3D
+                       list_first_entry(&cl_hw->cl_sta_db.head, struct cl_=
sta, list);
+
+               if (cl_sta_singular->sta_idx < cl_sta->sta_idx)
+                       list_add_tail(&cl_sta->list, &cl_hw->cl_sta_db.head=
);
+               else
+                       list_add(&cl_sta->list, &cl_hw->cl_sta_db.head);
+       } else {
+               struct cl_sta *cl_sta_last =3D
+                       list_last_entry(&cl_hw->cl_sta_db.head, struct cl_s=
ta, list);
+
+               if (cl_sta->sta_idx > cl_sta_last->sta_idx) {
+                       list_add_tail(&cl_sta->list, &cl_hw->cl_sta_db.head=
);
+               } else {
+                       struct cl_sta *cl_sta_next =3D NULL;
+                       struct cl_sta *cl_sta_prev =3D NULL;
+
+                       list_for_each_entry(cl_sta_next, &cl_hw->cl_sta_db.=
head, list) {
+                               if (cl_sta_next->sta_idx < cl_sta->sta_idx)
+                                       continue;
+
+                               cl_sta_prev =3D list_prev_entry(cl_sta_next=
, list);
+                               __list_add(&cl_sta->list, &cl_sta_prev->lis=
t, &cl_sta_next->list);
+                               break;
+                       }
+               }
+       }
+
+       write_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+       cl_sta->add_complete =3D true;
+}
+
+static void _cl_sta_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif, st=
ruct ieee80211_sta *sta)
+{
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+
+       /* !!! Must be first !!! */
+       cl_sta_add_to_lut(cl_hw, cl_vif, cl_sta);
+
+       cl_baw_init(cl_sta);
+       cl_txq_sta_add(cl_hw, cl_sta);
+       cl_vns_sta_add(cl_hw, cl_sta);
+
+       /*
+        * Add rssi of association request to rssi pool
+        * Make sure to call it before cl_wrs_api_sta_add()
+        */
+       cl_rssi_assoc_find(cl_hw, cl_sta, cl_hw->cl_sta_db.num);
+
+       cl_motion_sense_sta_add(cl_hw, cl_sta);
+       cl_bf_sta_add(cl_hw, cl_sta, sta);
+       cl_wrs_api_sta_add(cl_hw, sta);
+       cl_wrs_api_set_smps_mode(cl_hw, sta,
+                                cl_sta->stainfo->cur_max_bandwidth);
+       /* Should be called after cl_wrs_api_sta_add() */
+       cl_dyn_mcast_rate_update_upon_assoc(cl_hw, cl_sta->wrs_sta.mode,
+                                           cl_hw->cl_sta_db.num);
+       cl_dyn_bcast_rate_update_upon_assoc(cl_hw,
+                                           cl_sta->wrs_sta.su_params.tx_pa=
rams.mcs,
+                                           cl_hw->cl_sta_db.num);
+
+       /* !!! Must be last !!! */
+       cl_sta_add_to_list(cl_hw, cl_sta);
+}
+
+static void cl_sta_disassociate(struct cl_hw *cl_hw, bool ap_only)
+{
+       struct cl_sta *cl_sta;
+       int sta_idx;
+       int cnt =3D 0;
+       int sta_num =3D cl_hw->cl_sta_db.num;
+
+       for (sta_idx =3D 0; ((sta_idx < CL_MAX_NUM_STA) && (cnt < sta_num))=
; sta_idx++) {
+               cl_sta =3D cl_hw->cl_sta_db.lut[sta_idx];
+               if (cl_sta) {
+                       cnt++;
+                       if (ap_only && cl_sta->cl_vif->vif->type !=3D NL802=
11_IFTYPE_AP)
+                               continue;
+                       cfg80211_del_sta(cl_sta->cl_vif->dev, cl_sta->addr,=
 GFP_ATOMIC);
+               }
+       }
+}
+
+/*
+ * Parse the ampdu density to retrieve the value in usec, according to
+ * the values defined in ieee80211.h
+ */
+static u8 cl_sta_density2usec(u8 ampdu_density)
+{
+       switch (ampdu_density) {
+       case IEEE80211_HT_MPDU_DENSITY_NONE:
+               return 0;
+               /* 1 microsecond is our granularity */
+       case IEEE80211_HT_MPDU_DENSITY_0_25:
+       case IEEE80211_HT_MPDU_DENSITY_0_5:
+       case IEEE80211_HT_MPDU_DENSITY_1:
+               return 1;
+       case IEEE80211_HT_MPDU_DENSITY_2:
+               return 2;
+       case IEEE80211_HT_MPDU_DENSITY_4:
+               return 4;
+       case IEEE80211_HT_MPDU_DENSITY_8:
+               return 8;
+       case IEEE80211_HT_MPDU_DENSITY_16:
+               return 16;
+       default:
+               return 0;
+       }
+}
+
+static void cl_sta_set_min_spacing(struct cl_hw *cl_hw,
+                                  struct ieee80211_sta *sta)
+{
+       bool is_6g =3D cl_band_is_6g(cl_hw);
+       u8 sta_min_spacing =3D 0;
+       struct cl_sta *cl_sta =3D IEEE80211_STA_TO_CL_STA(sta);
+
+       if (is_6g)
+               sta_min_spacing =3D
+                       cl_sta_density2usec(sta->he_6ghz_capa.capa &
+                                       IEEE80211_HE_6GHZ_CAP_MIN_MPDU_STAR=
T);
+       else if (sta->ht_cap.ht_supported)
+               sta_min_spacing =3D
+                       cl_sta_density2usec(sta->ht_cap.ampdu_density);
+       else
+               cl_dbg_err(cl_hw, "HT is not supported - cannot set sta_min=
_spacing\n");
+
+       cl_sta->ampdu_min_spacing =3D
+               max(cl_sta_density2usec(cl_hw->sband.ht_cap.ampdu_density),=
 sta_min_spacing);
+}
+
+u32 cl_sta_num(struct cl_hw *cl_hw)
+{
+       u32 num =3D 0;
+
+       read_lock(&cl_hw->cl_sta_db.lock);
+       num =3D cl_hw->cl_sta_db.num;
+       read_unlock(&cl_hw->cl_sta_db.lock);
+
+       return num;
+}
+
+u32 cl_sta_num_bh(struct cl_hw *cl_hw)
+{
+       u32 num =3D 0;
+
+       read_lock_bh(&cl_hw->cl_sta_db.lock);
+       num =3D cl_hw->cl_sta_db.num;
+       read_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+       return num;
+}
+
+bool cl_sta_is_assoc(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       bool is_assoc =3D false;
+
+       if (sta_idx < CL_MAX_NUM_STA) {
+               read_lock_bh(&cl_hw->cl_sta_db.lock);
+               is_assoc =3D cl_hw->cl_sta_db.lut[sta_idx] ? true : false;
+               read_unlock_bh(&cl_hw->cl_sta_db.lock);
+       }
+
+       return is_assoc;
+}
+
+struct cl_sta *cl_sta_get(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       if (sta_idx < CL_MAX_NUM_STA)
+               return cl_hw->cl_sta_db.lut[sta_idx];
+
+       return NULL;
+}
+
+struct cl_sta *cl_sta_get_by_addr(struct cl_hw *cl_hw, u8 *addr)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       u8 hash_idx =3D CL_STA_HASH_IDX(addr[5]);
+
+       if (is_multicast_ether_addr(addr))
+               return NULL;
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.hash[hash_idx], list_=
hash)
+               if (cl_mac_addr_compare(cl_sta->addr, addr))
+                       return cl_sta;
+
+       return NULL;
+}
+
+void cl_sta_loop(struct cl_hw *cl_hw, sta_callback callback)
+{
+       struct cl_sta *cl_sta =3D NULL;
+
+       /* Go over all stations */
+       read_lock(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+               callback(cl_hw, cl_sta);
+
+       read_unlock(&cl_hw->cl_sta_db.lock);
+}
+
+void cl_sta_loop_bh(struct cl_hw *cl_hw, sta_callback callback)
+{
+       struct cl_sta *cl_sta =3D NULL;
+
+       /* Go over all stations - use bottom-half lock */
+       read_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+               callback(cl_hw, cl_sta);
+
+       read_unlock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+void cl_sta_loop_safe(struct cl_hw *cl_hw, sta_callback callback)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       struct cl_sta *cl_sta_tmp =3D NULL;
+
+       /* Go over all stations */
+       read_lock(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry_safe(cl_sta, cl_sta_tmp, &cl_hw->cl_sta_db.head=
, list)
+               callback(cl_hw, cl_sta);
+
+       read_unlock(&cl_hw->cl_sta_db.lock);
+}
+
+static int cl_sta_add_to_firmware(struct cl_hw *cl_hw, struct ieee80211_vi=
f *vif,
+                                 struct ieee80211_sta *sta)
+{
+       struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       struct mm_sta_add_cfm *sta_add_cfm;
+       int error =3D 0;
+       u8 recovery_sta_idx =3D 0;
+       u32 rate_ctrl_info =3D 0;
+
+       if (cl_recovery_in_progress(cl_hw)) {
+               struct cl_wrs_tx_params *tx_params =3D &cl_sta->wrs_sta.su_=
params.tx_params;
+
+               /*
+                * If station is added to firmware during recovery, the dri=
ver passes to firmware
+                * the station index to be used instead of firmware selecti=
ng a free index
+                */
+               recovery_sta_idx =3D cl_sta->sta_idx;
+
+               /* Keep current rate value */
+               rate_ctrl_info =3D cl_rate_ctrl_generate(cl_hw, cl_sta, tx_=
params->mode,
+                                                      tx_params->bw, tx_pa=
rams->nss,
+                                                      tx_params->mcs, tx_p=
arams->gi,
+                                                      false);
+       } else {
+               bool is_cck =3D cl_band_is_24g(cl_hw) && cl_hw_mode_is_b_or=
_bg(cl_hw);
+               u8 mode =3D is_cck ? WRS_MODE_CCK : WRS_MODE_OFDM;
+
+               /*
+                * Not in recovery:
+                * firmware will set sta_idx and will return in confirmatio=
n message
+                */
+               recovery_sta_idx =3D STA_IDX_INVALID;
+
+               /* Default rate value */
+               rate_ctrl_info =3D cl_rate_ctrl_generate(cl_hw, cl_sta, mod=
e,
+                                                      0, 0, 0, 0, false);
+       }
+
+       /* Must be called before cl_msg_tx_sta_add() */
+       cl_sta_set_min_spacing(cl_hw, sta);
+
+       /* Send message to firmware */
+       error =3D cl_msg_tx_sta_add(cl_hw, sta, cl_vif, recovery_sta_idx, r=
ate_ctrl_info);
+       if (error)
+               return error;
+
+       sta_add_cfm =3D (struct mm_sta_add_cfm *)(cl_hw->msg_cfm_params[MM_=
STA_ADD_CFM]);
+       if (!sta_add_cfm)
+               return -ENOMSG;
+
+       if (sta_add_cfm->status !=3D 0) {
+               cl_dbg_verbose(cl_hw, "Status Error (%u)\n", sta_add_cfm->s=
tatus);
+               cl_msg_tx_free_cfm_params(cl_hw, MM_STA_ADD_CFM);
+               return -EIO;
+       }
+
+       /* Save the index retrieved from firmware */
+       cl_sta->sta_idx =3D sta_add_cfm->sta_idx;
+
+       /* Release cfm msg */
+       cl_msg_tx_free_cfm_params(cl_hw, MM_STA_ADD_CFM);
+
+       return 0;
+}
+
+int cl_sta_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+              struct ieee80211_sta *sta)
+{
+       struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       int error =3D 0;
+
+       if (cl_radio_is_going_down(cl_hw))
+               return -EPERM;
+
+       cl_sta->cl_vif =3D cl_vif;
+       cl_mac_addr_copy(cl_sta->addr, sta->addr);
+
+       error =3D cl_sta_add_to_firmware(cl_hw, vif, sta);
+       if (error)
+               return error;
+
+       if (!cl_recovery_in_progress(cl_hw))
+               if (vif->type !=3D NL80211_IFTYPE_STATION ||
+                   cl_hw->chip->conf->ce_production_mode)
+                       _cl_sta_add(cl_hw, vif, sta);
+
+       if (vif->type =3D=3D NL80211_IFTYPE_MESH_POINT &&
+           cl_vif->num_sta =3D=3D 1) {
+               cl_vif_ap_tx_enable(cl_hw, true);
+               set_bit(CL_DEV_MESH_AP, &cl_hw->drv_flags);
+       }
+
+       return 0;
+}
+
+void cl_sta_mgd_add(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct iee=
e80211_sta *sta)
+{
+       /* Should be called in station mode */
+       struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+
+       /* !!! Must be first !!! */
+       cl_sta_add_to_lut(cl_hw, cl_vif, cl_sta);
+
+       cl_baw_init(cl_sta);
+       cl_txq_sta_add(cl_hw, cl_sta);
+       cl_vns_sta_add(cl_hw, cl_sta);
+
+       /*
+        * Add rssi of association response to rssi pool
+        * Make sure to call it before cl_wrs_api_sta_add()
+        */
+       cl_rssi_assoc_find(cl_hw, cl_sta, cl_hw->cl_sta_db.num);
+
+       /* In station mode we assume that the AP we connect to is static */
+       cl_motion_sense_sta_add(cl_hw, cl_sta);
+       cl_bf_sta_add(cl_hw, cl_sta, sta);
+       cl_wrs_api_sta_add(cl_hw, sta);
+       /* Should be called after cl_wrs_api_sta_add() */
+       cl_dyn_mcast_rate_update_upon_assoc(cl_hw, cl_sta->wrs_sta.mode,
+                                           cl_hw->cl_sta_db.num);
+       cl_dyn_bcast_rate_update_upon_assoc(cl_hw,
+                                           cl_sta->wrs_sta.su_params.tx_pa=
rams.mcs,
+                                           cl_hw->cl_sta_db.num);
+
+       /* !!! Must be last !!! */
+       cl_sta_add_to_list(cl_hw, cl_sta);
+}
+
+static void _cl_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       write_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       list_del(&cl_sta->list);
+       list_del(&cl_sta->list_hash);
+
+       cl_hw->cl_sta_db.lut[cl_sta->sta_idx] =3D NULL;
+       cl_hw->cl_sta_db.num--;
+       cl_sta->cl_vif->num_sta--;
+
+       cl_dbg_verbose(cl_hw, "mac=3D%pM, sta_idx=3D%u, vif_index=3D%u\n",
+                      cl_sta->addr, cl_sta->sta_idx, cl_sta->cl_vif->vif_i=
ndex);
+
+       write_unlock_bh(&cl_hw->cl_sta_db.lock);
+}
+
+void cl_sta_remove(struct cl_hw *cl_hw, struct ieee80211_vif *vif, struct =
ieee80211_sta *sta)
+{
+       struct cl_vif *cl_vif =3D (struct cl_vif *)vif->drv_priv;
+       struct cl_sta *cl_sta =3D (struct cl_sta *)sta->drv_priv;
+       u8 sta_idx =3D cl_sta->sta_idx;
+
+       /* !!! Must be first - remove from list and LUT !!! */
+       _cl_sta_remove(cl_hw, cl_sta);
+
+       cl_traffic_sta_remove(cl_hw, cl_sta);
+       cl_bf_sta_remove(cl_hw, cl_sta);
+       cl_dyn_mcast_rate_update_upon_disassoc(cl_hw,
+                                              cl_sta->wrs_sta.mode,
+                                              cl_hw->cl_sta_db.num);
+       cl_dyn_bcast_rate_update_upon_disassoc(cl_hw,
+                                              cl_sta->wrs_sta.su_params.tx=
_params.mcs,
+                                              cl_hw->cl_sta_db.num);
+       cl_wrs_api_sta_remove(cl_hw, cl_sta);
+       cl_tx_inject_sta_remove(cl_hw, cl_sta);
+       cl_twt_sta_remove(cl_hw, cl_sta);
+       cl_stats_sta_remove(cl_hw, cl_sta);
+
+       /*
+        * TX stop flow:
+        * 1) Flush TX queues
+        * 2) Poll confirmation queue and clear enhanced TIM
+        * 3) Send MM_STA_DEL_REQ message to firmware
+        * 4) Flush confirmation queue
+        * 5) Reset write index
+        */
+
+       cl_txq_flush_sta(cl_hw, cl_sta);
+       cl_single_cfm_poll_empty_sta(cl_hw, sta_idx);
+       cl_txq_sta_remove(cl_hw, sta_idx);
+
+       if (cl_vif->vif->type =3D=3D NL80211_IFTYPE_MESH_POINT &&
+           cl_vif->num_sta =3D=3D 0) {
+               cl_sta_disassociate_ap_iface(cl_hw);
+               cl_vif_ap_tx_enable(cl_hw, false);
+               clear_bit(CL_DEV_MESH_AP, &cl_hw->drv_flags);
+       }
+
+       cl_msg_tx_sta_del(cl_hw, sta_idx);
+
+       cl_single_cfm_flush_sta(cl_hw, sta_idx);
+
+       if (cl_vif->num_sta =3D=3D 0)
+               cl_radio_off_wake_up(cl_hw);
+}
+
+void cl_sta_disassociate_all(struct cl_hw *cl_hw)
+{
+       /* Disassociate all associated stations (AP + STA mode) */
+       cl_sta_disassociate(cl_hw, false);
+}
+
+void cl_sta_disassociate_ap_iface(struct cl_hw *cl_hw)
+{
+       /* Disassociate all AP associated stations (AP mode only) */
+       cl_sta_disassociate(cl_hw, true);
+}
+
+void cl_sta_ps_notify(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool is_=
ps)
+{
+       /*
+        * PS-Poll & UAPSD are handled by FW, by setting
+        * WLAN_STA_SP we ensure mac80211 does not re-handle.
+        * flag is unset at ieee80211_sta_ps_deliver_wakeup
+        */
+       if (is_ps)
+               set_sta_flag(cl_sta->stainfo, WLAN_STA_SP);
+
+       cl_stats_update_ps(cl_hw, cl_sta, is_ps);
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

