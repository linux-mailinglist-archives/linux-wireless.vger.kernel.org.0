Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9943AB824
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbhFQQFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:12 -0400
Received: from mail-eopbgr20077.outbound.protection.outlook.com ([40.107.2.77]:62438
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233540AbhFQQFB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jxWl6A8m4HRrkVqXLEuLoPbK5B4/Hm92lx48N8hPC25hJK7skF2Jue7HreNgsnklQ7iApyD/i63xun6iFYt4tFOodUQVEdqYEz3puMT8V9+gcHw2fF3mx9i95ABd8+hilkxwf1e8UWrq/VLK+53eysUf809cQ2XEQ8BrJa5uXkHZeRqADEXGJPtPQ5DNGFp0q5mtZ5HXaRbxA238w2ZcUJriD2fhDXTgAUFIjfmGQNAcTMoKcnh3h0mL282x40n9yiAE2aEusRvNrBDDQ6pGy8ErIoDKqZHAw25q4UGjly7zD/N8x8kVDajWJXJCJMOncBtK8tnP0wYI1iDa+Cah4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PoMtbWrS4RIid+Ug74S/cd6PATVlDvxk1FKujVncBo=;
 b=CB5ASiyGVi/EiCSx6XQjdWJo/18ki7J3XwaKJorM4bVMaYX3jXjxr8bEiTDhUL4l7Nf4AzVXjq4NSDazxtOiv07uHWmEEHNvEUSx2y7Kio4Yb53x7b8xfPCxeSPc4Aq55HX3D28+Sxd184m/5Cjv7G5jleryvTx4oLIkYzI7ceEgSxRB399O4WTxLKrcj4pr6yqV2cv0fGC9n/U/kzoO4rBugNTrNxbiiod18pjQp24p/cWuxFP9XQPthq0IF1I6z/y8npAc8BG7aEsgyjxv0xIuoexLlf0js7W2b+pIe1FaA7BmJ74JrL+z5fqisoLnYTIa/KneM0zedMlAwEzI8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PoMtbWrS4RIid+Ug74S/cd6PATVlDvxk1FKujVncBo=;
 b=2Cg91tcqGkq4RoctsNwqBaOxFWEhlmMgqATG81hltTTsQtMs0LAjmQwAlzQJNlEpdWRHXVxsNPh33giIXOX5WGakZBBjiQDStP2u8pTHCAIRaQ1iGiRWdi8zWVaYs5LqEMN2qe0uX7jlVOhilZDX1uqHBorakAPld+FySQG1wcE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1188.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:02:50 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:50 +0000
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
Subject: [RFC v1 015/256] cl8k: add bf.c
Date:   Thu, 17 Jun 2021 15:58:22 +0000
Message-Id: <20210617160223.160998-16-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc61784-e8b3-4d1e-6160-08d931a95b9b
X-MS-TrafficTypeDiagnostic: AM9P192MB1188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1188574E44BEEE40715929DDF60E9@AM9P192MB1188.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1HJkQO2Kwu1XqEbC2RfQsRSkq6ejhWir2+/6qLNXbEbljg8c/Kr6CMbEeNgt+pOPiUH+bvn3sm/ARmS7P0I9TvGReJnHf++IDgDorE4S1+VjrqrJWcXnALRfFZJ5k888CRozYyzQ2co/NCKb9uZ29pxQn5xIh8CMw8qZUoETGxTkcAT7EbDqbF1gUO/JuwVgFBWJLzydSz8p4Rk5fOV7jgniPLaxky/Y9qmE7L2LjJwSBoLxkNDcTPck/MYHQKTkV0YXK1oMaSrUm+6yyePL4BZSfva5sX9lGiuWg8b715+rNUJcxIZKY71J3l60+ak0sFwxhcZgyh44LruhzkS3Rdc0ftuuOBjC6Cb2wl7zeIpINyfjrWaNYsJ8XSYUHbZd37M5PzY/UKdTGCP8oFdhA+bgGjDErlsJiGsYlV8YM5IyPW0MOoYbGRZst+Cc0UnuI8R0lTt4pdIZ6VTuH7y+36ND+sTuBXpLq3pM98beej3gLBKglBu3CfbL5+4zdayxDve7vtRfqpl0SdXUhZIQkfMEpAs7+Jak0CvjAVEeZlIpKSjy5QpuXWx1GC9PC3txM3lv2zrB8lFluEqNQOVNT7JW3GjHd+hX4uUr9N8qFNiqAVWRhQKAVl7D2p6quc18DZphVoZ+x811x2Ld7WcErPTqhGR0ofdkh4jUQJ3yJNGOVZBNEPw2yffHulOXBrC50FoEJPlSUCr7hT+Vg/4LxQYuzJSrLmuoD/kQoIo30mg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(346002)(396003)(376002)(366004)(16526019)(66946007)(26005)(66476007)(30864003)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(508600001)(8676002)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(5660300002)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+SvIqLtukDSfAFdKdB8PBhlryCfAdIZiq3Xj5g4ilaoYOJmZ99kGrfbs02yC?=
 =?us-ascii?Q?VVNGat6jifEVQxycXrDCLJiazr27pFYE/h8oYMQ0SbmVW8eeofBNKsXZ6reB?=
 =?us-ascii?Q?InYmuet798uaQT09fjIAaCCFi2ENiazqrgtccCSuvAg+vKz/cqDwvuURaaKe?=
 =?us-ascii?Q?8hAb+ww/Z1zT+8gI15P7sTSkvlwMMjsFzdLSDyBRJlSyMvCU0whbg5tDyRUi?=
 =?us-ascii?Q?Hw5mMq06r453jtN0ordiUacJdNK4gSjpt0dJhSmnXwrLpqY1ONcfCzmw8303?=
 =?us-ascii?Q?I+0ZKLgi5EZOlZdm8EFqpJMQz8ZFphJI1ogKePGgwSwndn1/B07jseVM4GgO?=
 =?us-ascii?Q?YDInr7xn/KaiF/lRmd7XvK+aA5kfFjvAIgJ+4oYluNFaqi1uA1x4Ni4Z4m62?=
 =?us-ascii?Q?74h/9IXrPvEi5ArVH79oNi2wdsjUgP8UwYBhUsJjMudVQdEM5G85ilTy+PJN?=
 =?us-ascii?Q?HJN17LYef+xQsohuPCXVDf4k/4dZe6FPLjQhF1iG6BzRiAZisJC6wSQ7s+OS?=
 =?us-ascii?Q?BBODW8DnR3PLApkI6EZOiKQyekBBZrMiMSXGtI9q1Psq53E7Od68Eux/rscd?=
 =?us-ascii?Q?rvDprncNdtz5r5d0smyhH5K142zepNOqpR2TBY7EmVC/c/gQTwCN8LvS9bUI?=
 =?us-ascii?Q?+WWVDHblVeUwmrmwro/pDJrTWD0pwkVniDlVBMTA/km3f7YXKftozFrhUe5z?=
 =?us-ascii?Q?wjfI0z6XiQv2/SrSdMtHHYWtGVjc9JtXecP/jsqZ935hmcEBqOV0MnYTtgDI?=
 =?us-ascii?Q?hJH0c9il3IBfpKO5GXph67c05RqsE5Kpl9beeV/HUZBuChWVJcv6BQszbLY4?=
 =?us-ascii?Q?jlcDGxW6p+bkMdR1mtHKpVZ27bZO/N9LmvNUzYONGj0MKa1M/3PgbfoYkbuR?=
 =?us-ascii?Q?DG/odsMQFnv7b7xlAtajqTj/kpRdnONRwZgdAWfS3GSGJQYsB49oyuu9kvWI?=
 =?us-ascii?Q?dN3ydUSgnKy4SJzW2skutc6V4U3oyJU7GNJgxuSwsxn56bU6Ym9lO4Z2vOEy?=
 =?us-ascii?Q?Nj8ZtGUAa58XnWarT0Qegh6HS+zttMDaKXXaEPJOaoVxI05QwqeMg/XswXii?=
 =?us-ascii?Q?UJtC7zwzSwB9z8FxoN9Df2zhPl5U1wjUpWUClOqa6YGaUYhPmF7nvU3NxKvK?=
 =?us-ascii?Q?9xBN2CYIT6KNRk+30JVJQkfmo+UzALQ/FTbBnp94MCiVUESf0KV7SgBz0c27?=
 =?us-ascii?Q?KM/M3+ltQEj+vkk1w7mLbZ31VXsuDth10kNZ9wpGKgsz2UJ1ubMR7bpymCdm?=
 =?us-ascii?Q?G6CwQGQaYtRAqCB8m54+LevmH+QF+BRcssL3ihra91BJ+NybXsRx4BORyrbo?=
 =?us-ascii?Q?fPoT80FnAvU0PLaCjbFAq0z8?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc61784-e8b3-4d1e-6160-08d931a95b9b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:50.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i1NWZsB2CNpu4N0vl13SVMIiXkk/977ra8vvJWQGDnjX1rOW369m9g3R+D1WiuuKBqRGIzH48Be/LaMKi6xjtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1188
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/bf.c | 556 ++++++++++++++++++++++++++
 1 file changed, 556 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.c

diff --git a/drivers/net/wireless/celeno/cl8k/bf.c b/drivers/net/wireless/c=
eleno/cl8k/bf.c
new file mode 100644
index 000000000000..1b4521080aa5
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bf.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "bf.h"
+#include "sounding.h"
+#include "fw/msg_tx.h"
+#include "traffic.h"
+#include "sta.h"
+#include "utils/math.h"
+#include "utils/utils.h"
+
+#define CL_BF_SOUNDING_INTERVAL_MAX 0x3ff
+#define CL_BF_MIN_SOUNDING_NR       3
+
+#define bf_pr(cl_hw, level, ...) \
+       do { \
+               if ((level) <=3D (cl_hw)->bf_db.dbg_level) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+#define bf_pr_verbose(cl_hw, ...) bf_pr((cl_hw), DBG_LVL_VERBOSE, ##__VA_A=
RGS__)
+#define bf_pr_err(cl_hw, ...)     bf_pr((cl_hw), DBG_LVL_ERROR, ##__VA_ARG=
S__)
+#define bf_pr_warn(cl_hw, ...)    bf_pr((cl_hw), DBG_LVL_WARNING, ##__VA_A=
RGS__)
+#define bf_pr_trace(cl_hw, ...)   bf_pr((cl_hw), DBG_LVL_TRACE, ##__VA_ARG=
S__)
+#define bf_pr_info(cl_hw, ...)    bf_pr((cl_hw), DBG_LVL_INFO, ##__VA_ARGS=
__)
+
+static void cl_bf_cli_fw_control_stats(struct cl_hw *cl_hw, u32 action)
+{
+       if (action =3D=3D 0)
+               cl_msg_tx_dbg_print_stats(cl_hw, DBG_PRINT_RESET, 0, 0, 0, =
0);
+       else if (action =3D=3D 1)
+               cl_msg_tx_dbg_print_stats(cl_hw, DBG_PRINT_BF_CTRL_ACTIVE, =
0, 0, 0, 0);
+       else if (action =3D=3D 2)
+               cl_msg_tx_dbg_print_stats(cl_hw, DBG_PRINT_BF_CTRL_PASSIVE,=
 0, 0, 0, 0);
+       else
+               bf_pr_verbose(cl_hw, "Invalid input [%u]\n", action);
+}
+
+static bool cl_bf_is_beamformee_capable_he(struct ieee80211_sta *sta, bool=
 mu_cap)
+{
+       u8 phy_cap_info4 =3D sta->he_cap.he_cap_elem.phy_cap_info[4];
+
+       if (mu_cap)
+               return (phy_cap_info4 & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER=
) ? true : false;
+       else
+               return (phy_cap_info4 & IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE=
) ? true : false;
+}
+
+static bool cl_bf_is_beamformee_capable_vht(struct ieee80211_sta *sta, boo=
l mu_cap)
+{
+       u32 vht_cap =3D sta->vht_cap.cap;
+
+       if (mu_cap)
+               return (vht_cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE) =
? true : false;
+       else
+               return (vht_cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE) =
? true : false;
+}
+
+static bool cl_bf_is_beamformee_capable(struct cl_sta *cl_sta, bool mu_cap=
)
+{
+       struct ieee80211_sta *sta =3D &cl_sta->stainfo->sta;
+
+       if (sta->he_cap.has_he)
+               return cl_bf_is_beamformee_capable_he(sta, mu_cap);
+
+       if (sta->vht_cap.vht_supported)
+               return cl_bf_is_beamformee_capable_vht(sta, mu_cap);
+
+       return false;
+}
+
+static int cl_bf_cli_config_print(struct cl_hw *cl_hw)
+{
+       bool is_enabled =3D cl_bf_is_enabled(cl_hw);
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Beamforming Configuration\n"
+                   "------------------------------\n");
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Is enabled:                %s\n",
+                   is_enabled ? "True" : "False");
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Force:                     %s\n",
+                   cl_hw->bf_db.force ? "True" : "False");
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Debug level:               %d\n",
+                   cl_hw->bf_db.dbg_level);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Max nss supported:         %u\n",
+                   conf->ci_bf_max_nss);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_bf_cli_debug_set(struct cl_hw *cl_hw, u32 dbg_level)
+{
+       if (dbg_level < DBG_LVL_MAX) {
+               cl_hw->bf_db.dbg_level =3D dbg_level;
+               pr_debug("[BF] Debug level [%d]\n", dbg_level);
+       }
+}
+
+void cl_bf_enable(struct cl_hw *cl_hw, bool enable)
+{
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       if (conf->ce_bf_en =3D=3D enable)
+               return;
+
+       conf->ce_bf_en =3D enable;
+       pr_debug("[BF] %s\n", enable ? "Enable" : "Disable");
+
+       cl_sta_loop_bh(cl_hw, cl_bf_sounding_decision);
+}
+
+static void cl_bf_cli_force_set(struct cl_hw *cl_hw, bool force)
+{
+       if (cl_hw->bf_db.force =3D=3D force)
+               return;
+
+       cl_hw->bf_db.force =3D force;
+       pr_debug("[BF] Force: %s\n", force ? "True" : "False");
+
+       cl_sta_loop_bh(cl_hw, cl_bf_sounding_decision);
+}
+
+static int cl_bf_cli_sta_info_print(struct cl_hw *cl_hw)
+{
+       struct cl_sta *cl_sta =3D NULL;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+       int err =3D 0;
+
+       /* Go over all stations - use bottom-half lock */
+       read_lock_bh(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+               u8 nss =3D cl_sta->wrs_sta.su_params.tx_params.nss;
+               bool is_on =3D cl_bf_is_on(cl_hw, cl_sta, nss);
+               bool su_beamformee_capable =3D
+                               cl_bf_is_beamformee_capable(cl_sta, false);
+               bool mu_beamformee_capable =3D
+                               cl_bf_is_beamformee_capable(cl_sta, true);
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "\nStation [%u]\n", cl_sta->sta_idx);
+               cl_snprintf(&buf, &len, &buf_size,
+                           "-------------------------------\n");
+               cl_snprintf(&buf, &len, &buf_size,
+                           "SU beamformee capable: %s\n",
+                           su_beamformee_capable ? "True" : "False");
+               cl_snprintf(&buf, &len, &buf_size,
+                           "MU beamformee capable: %s\n",
+                           mu_beamformee_capable ? "True" : "False");
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Beamformee STS:        %u\n",
+                           bf_db->beamformee_sts);
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Beamformee NSS:        %u\n", bf_db->nc);
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Traffic active:        %s\n",
+                           bf_db->traffic_active ? "True" : "False");
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Sound start:           %s\n",
+                           bf_db->sounding_start ? "True" : "False");
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Sounding indications:  %u\n",
+                           bf_db->sounding_indications);
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Indication_timeout:    %s\n",
+                           bf_db->indication_timeout ? "True" : "False");
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Is on:                 %s\n",
+                           is_on ? "True" : "False");
+       }
+
+       read_unlock_bh(&cl_hw->cl_sta_db.lock);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_bf_cli_help(struct cl_hw *cl_hw)
+{
+       char *ret_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!ret_buf)
+               return -ENOMEM;
+
+       snprintf(ret_buf, PAGE_SIZE,
+                "bf usage\n"
+                "-a: Firmware BF control stats [0-Reset,1-PrintActive,2-Pr=
intPassive]\n"
+                "-c: Print BF configuration\n"
+                "-d: Set debug level [0-OFF,1-ERROR,2-WARN,3-TRACE,4-INFO]=
\n"
+                "-e: Disable or Enable BF [0/1]\n"
+                "-f: Force BF [0-Disable,1-Enable]\n"
+                "-s: Print BF station info\n");
+
+       err =3D cl_vendor_reply(cl_hw, ret_buf, strlen(ret_buf));
+       kfree(ret_buf);
+
+       return err;
+}
+
+static void cl_bf_timer_callback(unsigned long data)
+{
+       /*
+        * If timer expired it means that we started sounding but didn't ge=
t any
+        * indication for (10 * sounding_interval).
+        * So we disable sounding for this station (even when in starts aga=
in traffic).
+        */
+       struct cl_sta *cl_sta =3D (struct cl_sta *)data;
+
+       if (cl_sta) {
+               struct cl_hw *cl_hw =3D cl_sta->cl_vif->cl_hw;
+
+               bf_pr_trace(cl_hw, "[BF] Failed to get reply (%u)\n", cl_st=
a->sta_idx);
+               cl_sta->bf_db.indication_timeout =3D true;
+               cl_bf_sounding_decision(cl_hw, cl_sta);
+       }
+}
+
+void cl_bf_sounding_start(struct cl_hw *cl_hw, enum sounding_type type, st=
ruct cl_sta **cl_sta_arr,
+                         u8 sta_num, struct cl_sounding_info *recovery_ele=
m)
+{
+#define STA_INDICES_STR_SIZE 64
+
+       /* Send request to start sounding */
+       u8 i, bw =3D CHNL_BW_MAX;
+       char sta_indices_str[STA_INDICES_STR_SIZE] =3D {0};
+       u8 str_len =3D 0;
+
+       for (i =3D 0; i < sta_num; i++) {
+               struct cl_sta *cl_sta =3D cl_sta_arr[i];
+               struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+               bw =3D cl_sta->wrs_sta.assoc_bw;
+               bf_db->synced =3D false;
+               bf_db->sounding_start =3D true;
+               bf_db->sounding_indications =3D 0;
+
+               str_len +=3D snprintf(sta_indices_str, STA_INDICES_STR_SIZE=
 - str_len, "%u%s",
+                                   cl_sta->sta_idx, (i =3D=3D sta_num - 1 =
? ", " : ""));
+
+       }
+
+       bf_pr_trace(cl_hw, "[BF] Start sounding: Sta =3D %s\n", sta_indices=
_str);
+       cl_sounding_send_request(cl_hw, cl_sta_arr, sta_num, SOUNDING_ENABL=
E, type, bw, 0,
+                                recovery_elem);
+
+#undef STA_INDICES_STR_SIZE
+}
+
+void cl_bf_reset_sounding_info(struct cl_sta *cl_sta)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       bf_db->synced =3D false;
+       bf_db->sounding_start =3D false;
+       bf_db->sounding_indications =3D 0;
+}
+
+void cl_bf_sounding_stop(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       if (bf_db->sounding_start) {
+               /* Send request to stop sounding */
+               cl_bf_reset_sounding_info(cl_sta);
+               bf_pr_trace(cl_hw, "[BF] Sta =3D %u, Stop sounding\n", cl_s=
ta->sta_idx);
+               cl_sounding_send_request(cl_hw, &cl_sta, 1, SOUNDING_DISABL=
E, SOUNDING_TYPE_HE_SU,
+                                        0, 0, NULL);
+               bf_pr_trace(cl_hw, "[BF] Sta: %u, Beamforming disabled\n", =
cl_sta->sta_idx);
+       }
+}
+
+void cl_bf_sounding_decision(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       if (cl_bf_is_enabled(cl_hw) &&
+           cl_bf_is_beamformee_capable(cl_sta, false) &&
+           !bf_db->indication_timeout &&
+           ((bf_db->beamformee_sts + 1) >=3D CL_BF_MIN_SOUNDING_NR) &&
+           (bf_db->traffic_active || cl_hw->bf_db.force)) {
+               if (!bf_db->sounding_start) {
+                       if (cl_sta->su_sid =3D=3D INVALID_SID)
+                               cl_bf_sounding_start(cl_hw, SOUNDING_TYPE_H=
E_SU, &cl_sta, 1, NULL);
+                       else
+                               bf_pr_verbose(cl_hw, "[%s]: STA %u already =
belongs to sid %u\n",
+                                             __func__, cl_sta->sta_idx, cl=
_sta->su_sid);
+               }
+       } else {
+               cl_timer_disable(&bf_db->timer);
+               cl_bf_sounding_stop(cl_hw, cl_sta);
+       }
+}
+
+static u8 cl_bf_get_sts_he(struct ieee80211_sta *sta)
+{
+       u8 *phy_cap_info =3D sta->he_cap.he_cap_elem.phy_cap_info;
+
+       if (phy_cap_info[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MH=
Z_IN_5G ||
+           phy_cap_info[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLU=
S80_MHZ_IN_5G)
+               return u8_get_bits(phy_cap_info[4],
+                                  IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS=
_ABOVE_80MHZ_MASK);
+       else
+               return u8_get_bits(phy_cap_info[4],
+                                  IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS=
_UNDER_80MHZ_MASK);
+}
+
+static u8 cl_bf_get_sts_vht(struct ieee80211_sta *sta)
+{
+       struct ieee80211_sta_vht_cap *vht_cap =3D &sta->vht_cap;
+
+       return u32_get_bits(vht_cap->cap, IEEE80211_VHT_CAP_BEAMFORMEE_STS_=
MASK);
+}
+
+static u8 cl_bf_get_sts(struct ieee80211_sta *sta)
+{
+       if (sta->he_cap.has_he)
+               return cl_bf_get_sts_he(sta);
+
+       return cl_bf_get_sts_vht(sta);
+}
+
+void cl_bf_update_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       /* Old & new BF state for main rate */
+       bool bf_on_old =3D bf_db->is_on;
+       bool bf_on_new =3D cl_bf_is_on(cl_hw, cl_sta, bf_db->num_ss);
+
+       /* Old & new BF state for fallback rate */
+       bool bf_on_old_fbk =3D bf_db->is_on_fallback;
+       bool bf_on_new_fbk =3D cl_bf_is_on(cl_hw, cl_sta, bf_db->num_ss_fal=
lback);
+
+       if (bf_on_old !=3D bf_on_new || bf_on_old_fbk !=3D bf_on_new_fbk) {
+               /* BF state for main rate or fallback rate changed */
+
+               /* Save the new state */
+               bf_db->is_on =3D bf_on_new;
+               bf_db->is_on_fallback =3D bf_on_new_fbk;
+
+               /* Update the firmware */
+               if (cl_msg_tx_set_tx_bf(cl_hw, cl_sta->sta_idx, bf_on_new, =
bf_on_new_fbk))
+                       pr_err("%s: failed to set TX-BF\n", __func__);
+       }
+}
+
+void cl_bf_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct ieee=
80211_sta *sta)
+{
+       /* Beamformee capabilities */
+       bool su_beamformee_capable =3D cl_bf_is_beamformee_capable(cl_sta, =
false);
+       bool mu_beamformee_capable =3D cl_bf_is_beamformee_capable(cl_sta, =
true);
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       WARN_ON_ONCE(sta->rx_nss =3D=3D 0);
+       bf_db->beamformee_sts =3D cl_bf_get_sts(sta);
+       bf_db->nc =3D min_t(u8, sta->rx_nss, WRS_SS_MAX) - 1;
+       cl_sta->su_sid =3D INVALID_SID;
+
+       bf_pr_trace(cl_hw,
+                   "[BF] sta_idx: %u, su_beamformee_capable: %u, mu_beamfo=
rmee_capable: %u, "
+                   "beamformee_sts: %u, nc =3D %u\n",
+                   cl_sta->sta_idx, su_beamformee_capable, mu_beamformee_c=
apable,
+                   bf_db->beamformee_sts, bf_db->nc);
+
+       if (bf_db->beamformee_sts =3D=3D 0)
+               bf_db->beamformee_sts =3D 3;
+
+       /*
+        * Init the BF timer
+        * Period is set to 0. It will be updated before enabling it.
+        */
+       cl_timer_init(&bf_db->timer, cl_bf_timer_callback, (unsigned long)c=
l_sta, 0, false);
+}
+
+void cl_bf_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       /* Disable timer before removing the station */
+       cl_timer_disable_sync(&bf_db->timer);
+
+       /*
+        * Remove the sounding sequence associated with the STA and possibl=
y start another sequence
+        * for other stations that participate in the same sounding sequenc=
e with the STA
+        */
+       if (cl_sta->su_sid !=3D INVALID_SID) {
+               bf_db->sounding_remove_required =3D true;
+               cl_sounding_stop_by_sid(cl_hw, cl_sta->su_sid, true);
+       }
+}
+
+void cl_bf_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool act=
ive)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       if (bf_db->traffic_active !=3D active) {
+               bf_pr_trace(cl_hw, "[BF] Sta: %u, Active: %s\n",
+                           cl_sta->sta_idx, active ? "True" : " False");
+
+               bf_db->traffic_active =3D active;
+               cl_bf_sounding_decision(cl_hw, cl_sta);
+       }
+}
+
+void cl_bf_reset_sounding_ind(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       cl_sta->bf_db.sounding_indications =3D 0;
+}
+
+bool cl_bf_is_enabled(struct cl_hw *cl_hw)
+{
+       return cl_hw->conf->ce_bf_en;
+}
+
+int cl_bf_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       u32 expected_params =3D 0;
+       bool fw_ctrl_stats =3D false;
+       bool config_print =3D false;
+       bool debug_set =3D false;
+       bool enable_set =3D false;
+       bool force_set =3D false;
+       bool sta_info_print =3D false;
+
+       switch (cli_params->option) {
+       case 'a':
+               fw_ctrl_stats =3D true;
+               expected_params =3D 1;
+               break;
+       case 'c':
+               config_print =3D true;
+               expected_params =3D 0;
+               break;
+       case 'd':
+               debug_set =3D true;
+               expected_params =3D 1;
+               break;
+       case 'e':
+               enable_set =3D true;
+               expected_params =3D 1;
+               break;
+       case 'f':
+               force_set =3D true;
+               expected_params =3D 1;
+               break;
+       case 's':
+               sta_info_print =3D true;
+               expected_params =3D 0;
+               break;
+       case '?':
+               return cl_bf_cli_help(cl_hw);
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
+       if (fw_ctrl_stats)
+               cl_bf_cli_fw_control_stats(cl_hw, cli_params->params[0]);
+       else if (config_print)
+               return cl_bf_cli_config_print(cl_hw);
+       else if (debug_set)
+               cl_bf_cli_debug_set(cl_hw, cli_params->params[0]);
+       else if (enable_set)
+               cl_bf_enable(cl_hw, !!cli_params->params[0]);
+       else  if (force_set)
+               cl_bf_cli_force_set(cl_hw, !!cli_params->params[0]);
+       else if (sta_info_print)
+               return cl_bf_cli_sta_info_print(cl_hw);
+
+       return 0;
+out_err:
+       return -EIO;
+}
+
+bool cl_bf_is_on(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 nss)
+{
+       struct cl_bf_sta_db *bf_db =3D &cl_sta->bf_db;
+
+       return (cl_bf_is_enabled(cl_hw) &&
+               bf_db->sounding_start &&
+               bf_db->sounding_indications &&
+               (nss <=3D min(cl_hw->conf->ci_bf_max_nss, bf_db->nc)));
+}
+
+void cl_bf_sounding_req_success(struct cl_hw *cl_hw, struct cl_sounding_in=
fo *new_elem)
+{
+       /*
+        * Start a timer to check that we are receiving indications from th=
e station.
+        * The period of the timer is set to 10 times the sounding-interval=
.
+        */
+       u8 i;
+       struct cl_sta *cl_sta;
+       struct cl_bf_sta_db *bf_db;
+       unsigned long period =3D CL_SOUNDING_FACTOR * cl_sounding_get_inter=
val(cl_hw);
+
+       for (i =3D 0; i < new_elem->sta_num; i++) {
+               cl_sta =3D new_elem->su_cl_sta_arr[i];
+               bf_db =3D &cl_sta->bf_db;
+
+               if (cl_sta) {
+                       cl_sta->bf_db.sounding_start =3D true;
+                       cl_sta->su_sid =3D new_elem->sounding_id;
+
+                       /* Don't enable BF timer in case of force mode */
+                       if (!cl_hw->bf_db.force) {
+                               cl_timer_period_set(&bf_db->timer, period);
+                               cl_timer_enable(&bf_db->timer);
+                       }
+               }
+       }
+}
+
+void cl_bf_sounding_req_failure(struct cl_hw *cl_hw, struct cl_sounding_in=
fo *new_elem)
+{
+       u8 i;
+       struct cl_sta *cl_sta;
+       struct cl_bf_sta_db *bf_db;
+
+       for (i =3D 0; i < new_elem->sta_num; i++) {
+               cl_sta =3D new_elem->su_cl_sta_arr[i];
+
+               if (cl_sta) {
+                       bf_db =3D &cl_sta->bf_db;
+                       bf_db->sounding_start =3D false;
+                       bf_db->sounding_indications =3D 0;
+               }
+       }
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

