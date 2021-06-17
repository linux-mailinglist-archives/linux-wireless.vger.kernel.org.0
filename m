Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF5FD3AB855
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhFQQGj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:39 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:58626
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233644AbhFQQGJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVPC+T80+HyuxhzzdRCrcAx0yr9nlNjmDhqrS6yopWiS772gboFJmuwy20vLWqLz0Luxac1sWWiYvYO+3bwZVg+rTtqjknNoHKeZEZk2WZaJ6BGyb7kU9JImbIm+23XYTdKdz4g0Iey+Yc5IJo7pyiTVFqtaqK6V562nR6UPqkVNLcAcw1fJfxizpxDmDeh8YAfa8qDlO4Y6SS3xj2hSMxm/ikzWYYfBT/V7+NuWe0nO22DMnWKrPdoL5bTeu/W2qe3bzV0ETUkvpX05QRfEfdJo/W3UUow6HCfSdhrzIOrDc9hjwoqTZDEH2lXRWfUg9zJgbTk3Zmud24T/C5Topg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GUoDSoczNNQUgumtLTp+ew/hJxs5ovMI/hnArTTsOA=;
 b=D9Bqi6DZoZkm9amPCC4biHWq9d/4pnsQnLrgAZXQ0FiMlTd9HGB91xfc0vsmUeAgi70QAP4zFZiZwOm5maPhS5uM3bF/p2snP0nhQh3u985K82KZX9169cBK6PkCrSgLrLitnSJzJGr4D7OwojOJAQu+TFUZZccR3fkrg3jrgdrPgcY3UYusnlATGp/Dx1mMQIkmkUdZYQW8eYC7KE0X4UfKWZzxsTOK1Nl/Ur91lVC5jlhtGAB9kEInqkisdsadhZK6XgyC0pIj2HLYHQdHngI6kODt8MUF8WB0WngPzOyDGhMP/xk0arhHVZlTKJnzqWretFjT8/96GAROmeC57g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GUoDSoczNNQUgumtLTp+ew/hJxs5ovMI/hnArTTsOA=;
 b=aaJj7NKWP4ygLq74Kg1HelgTZ7UyXhjY3To4Of/uVrdBcEEwFKx6fSzVA481E8NDTYFckcbZQgIt52d/l9hic0qnoKyc9GUygrbqAH+/GuL+YAlzde4cwwtUqD+EAylF2NWvfQ5ldDlDtbk5FMCc+t02FSJHfSyhpNaRHIdHpBY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:48 +0000
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
Subject: [RFC v1 059/256] cl8k: add dfs/dfs.c
Date:   Thu, 17 Jun 2021 15:59:06 +0000
Message-Id: <20210617160223.160998-60-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebe3e279-10d1-4606-f0fd-08d931a97818
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499FBAC2BE5553CA5CBC9CFF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeitfKhqiu0Bm3qc9CTNjGBWK0u7TODOYAzpahDbtKf4MD1gg0m2wGkqHCuvaQvBLRku0u/i1Cq6/bPijJtfP/NdE0JwQ5jNUI8xlYzBPjpobVAclmBb0fkJrqOWUbFlZEweX05twGQRp0qnYwuZTFBPZXx68sIm4YMk3JntZxzJRTM/XIkpmldw/J3EMneZ8nJ5qbUcxEOrDVxYXFMbCCxsU3ipekv7K1m4ziB0FhRx0czl4IW0hrXS91UdORrJBj2V35tvh8jkUStSJrWGQ/eWe3nP+z5MEhUdOQvxp272NSUn4vF6SeUyNXtuKzTL8k4qrp7KAIQirEsE6XWXa9JVLF3f8CFMUdgJwMOhddfMzK5rBIwQ0GHl3BwRVuHChYFg/af1OwMDgSC2GdMOBBRBZRHbDF7oJuUL9ODgLESQzn+2WM4lK8CRhG8iNoPxDgDc6qjJ0kO4FMCtI9ORpr3quUA9rEqDi4z+Qjvx8qaHISS01Eqh6/OhAiEk4RCc/bVVHh6egkRE/YPRuuyK+ruXIpl/20lzZe8YhHNnjgrTJyZGoILAIXDQpo5Qj9/OvK/2FwVVLmlQ3ZSHOvPougHQbEiJXS1sr1iJI/bd4ypwAloJM3V+B8bCpaK1oRJFaIY+Tcw15mgHOTbXO53wsMA+kTGz5c1DLQ4EZPh9NRV0E82FZZigO2410lfP/TwFULOcCERVHqRUv47uFZPoYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bjdOby3w002dD9a044kxySNvy2qC5auFwufg4zu2Vs5TJToq4xCbZynRIGu0?=
 =?us-ascii?Q?zqm956IpVmLlsIbZde8rhHu2ooQKLdYtkVXNIekISJ5F9C4+eN+Iss7tmTkc?=
 =?us-ascii?Q?nXKIjop/UYSms4mcU6JSoXUT7Da+pSZ6L3Ys10I3+zCoaQ581U+8DsifsCfR?=
 =?us-ascii?Q?jqjBAmh5UWVId+MVsuIQri5wOkdhXtFvkG8CL86PgFyapZEHYOXqXdNXDmdJ?=
 =?us-ascii?Q?dfe3UXE0zdwsItrd+TsOFjTEoy3h/1GBSdIER5OHosps784UWwKA8xl84LBH?=
 =?us-ascii?Q?qOjfsEO9OlvTPMYlgiYjxgzn7pxG4bztfPEv4eSGeuzezQRf//7uBN2dhvmC?=
 =?us-ascii?Q?x57JTTOV46KbEtp/PYzU6iELPSADhg+C4JJas5JhwEQisbjZxS8aHWHkSS8R?=
 =?us-ascii?Q?weMRqLPDAEPVk+nEVngdkasZ4s+DanM4DQoe93St9YmfJpEULaEwM0BFQ9f0?=
 =?us-ascii?Q?gnpSCa8ynDNwKNGDcI10iuNjgU/3D3fb3s9a/6naoiMm2qFq62Pl19AkbySD?=
 =?us-ascii?Q?3chWNy8NvFb+5BR71xUCDwAEs34eUhsrVMY251WT6LBppUwaOl69mft/4CAg?=
 =?us-ascii?Q?t8F+kvLX7MrD31fmsh7+ZQBqrnG57DSX+afEIXkrr7eiv9rIvUA7GPU3Tl3h?=
 =?us-ascii?Q?oIUyEXosuz3naYh1Y+A1nPSZtyygqjUDfbwwySpb9JQm6AK270tmfpM33j4R?=
 =?us-ascii?Q?DGcyD5+UJxpVUMNWAIcUdUWqB6746aPg/+b1oAh67PneWIcBPBQjI2MMitVY?=
 =?us-ascii?Q?3A7DKCck3Oy3Ap6ZlP4OE9kbnQDRxs1JX3TIZtPEGZy37FKRas9BkQ5RTMB/?=
 =?us-ascii?Q?DV1OqyAJwF1GV+mWVPb/JkM946o/UqnJ2IZp3W59FPLO9wb9HK7C/mDCUa46?=
 =?us-ascii?Q?0FwAj7AXo0EHpYiq43KdAD+3/r9HRLUkbBq9glNKnGkxPupfK9aMIXERPGz3?=
 =?us-ascii?Q?XMVU2OE1mqwq8SHZnVdKStFtrU7NBBxDIlNZ5x2VgOT53JNHGulPEUO5jzph?=
 =?us-ascii?Q?uypQ4andm3+2FcpieqGhyMEcd/gN+pFpBRC17RtyMddejOl/8eLZcUS9s8XB?=
 =?us-ascii?Q?Ncg45qArCtWgyq7RidfqoUA1cUfkq3gFaOlVMuoOi29CzgS5Z0UHW8v3FoSJ?=
 =?us-ascii?Q?50lyQuAJ3ESxwI/MtNgvMDTkCBjxN2BPoMDW6cMrT6pk9BrV7bneOi58hylz?=
 =?us-ascii?Q?BbrO8ZWX25WFEBD7/ulpeqvyMJlINZk723bv8T3ARAnuhD1xg9SFrzjIqIfO?=
 =?us-ascii?Q?oR9G0URhZcgBpDIVY8B22Se3dGItEEuk25A0cLhFs4yg+Z6a6grijH+9iv9f?=
 =?us-ascii?Q?ls4E/E2husyqMq2h/ARC5rIb?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe3e279-10d1-4606-f0fd-08d931a97818
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:38.8001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TicE9WvpBg9s1GH312fhlIlu3aNcpNX6cpG15e0hCezBZ6CiDb01g54jw6hb5Bw7wAuFF4O6G3xLnR0ak2J4lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dfs/dfs.c | 977 +++++++++++++++++++++
 1 file changed, 977 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/dfs.c

diff --git a/drivers/net/wireless/celeno/cl8k/dfs/dfs.c b/drivers/net/wirel=
ess/celeno/cl8k/dfs/dfs.c
new file mode 100644
index 000000000000..b2717a8be26a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs/dfs.c
@@ -0,0 +1,977 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "dfs/dfs.h"
+#include "dfs/dfs_db.h"
+#include "dfs/radar.h"
+#include "chip.h"
+#include "channel.h"
+#include "chan_info.h"
+#include "env_det.h"
+#include "debug.h"
+#include "utils/timer.h"
+#include "tx/tx.h"
+#include "temperature.h"
+#include "utils/math.h"
+#include "calib.h"
+#include "traffic.h"
+#include "utils/utils.h"
+#include "reg/reg_riu.h"
+#include "reg/reg_mac_hw.h"
+#include "band.h"
+#include "chandef.h"
+#include "utils/string.h"
+#include "utils/file.h"
+#include "config.h"
+
+#define dfs_pr(cl_hw, level, ...) \
+       do { \
+               if ((level) <=3D (cl_hw)->dfs_db.dbg_lvl) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+#define dfs_pr_verbose(cl_hw, ...) dfs_pr((cl_hw), DBG_LVL_VERBOSE, ##__VA=
_ARGS__)
+#define dfs_pr_err(cl_hw, ...)     dfs_pr((cl_hw), DBG_LVL_ERROR, ##__VA_A=
RGS__)
+#define dfs_pr_warn(cl_hw, ...)    dfs_pr((cl_hw), DBG_LVL_WARNING, ##__VA=
_ARGS__)
+#define dfs_pr_trace(cl_hw, ...)   dfs_pr((cl_hw), DBG_LVL_TRACE, ##__VA_A=
RGS__)
+#define dfs_pr_info(cl_hw, ...)    dfs_pr((cl_hw), DBG_LVL_INFO, ##__VA_AR=
GS__)
+
+#define COUNTRY_CODE_LEN 2
+
+/*
+ * ID  Min    Max    Tol    Min  Max  Tol  Tol   MIN    PPB  Trig   Type
+ *     Width  Width  Width  PRI  PRI  PRI  FREQ  Burst       Count
+ */
+
+/* ETSI Radar Types v1.8.2 */
+static struct cl_radar_type radar_type_etsi[] =3D {
+
+       {0, 1,  1,  1, 1428, 1428, 1, 1, 1, 18, 10, RADAR_WAVEFORM_SHORT},
+       {1, 1,  5,  1, 1000, 5000, 1, 1, 1, 10, 5,  RADAR_WAVEFORM_SHORT},
+       {2, 1,  15, 1, 625,  5000, 1, 1, 1, 15, 8,  RADAR_WAVEFORM_SHORT},
+       {3, 1,  15, 1, 250,  435,  1, 1, 1, 25, 10, RADAR_WAVEFORM_SHORT},
+       {4, 10, 30, 1, 250,  500,  1, 1, 1, 20, 10, RADAR_WAVEFORM_SHORT},
+       {5, 1,  5,  1, 2500, 3334, 1, 1, 2, 10, 5,  RADAR_WAVEFORM_STAGGERE=
D},
+       {6, 1,  5,  1, 833,  2500, 1, 1, 2, 15, 8,  RADAR_WAVEFORM_STAGGERE=
D},
+};
+
+/* FCC Radar Types 8/14 */
+static struct cl_radar_type radar_type_fcc[] =3D {
+       {0, 1,  1,   0,  1428, 1428, 1, 1, 1, 18, 10, RADAR_WAVEFORM_SHORT}=
,
+       {1, 1,  5,   3,  518,  3066, 3, 1, 1, 18, 10, RADAR_WAVEFORM_SHORT}=
,
+       {2, 1,  5,   3,  150,  230,  3, 1, 1, 23, 10, RADAR_WAVEFORM_SHORT}=
,
+       {3, 3,  10,  3,  200,  500,  3, 1, 1, 16, 6,  RADAR_WAVEFORM_SHORT}=
,
+       {4, 6,  20,  3,  200,  500,  3, 1, 1, 12, 6,  RADAR_WAVEFORM_SHORT}=
,
+       {5, 50, 100, 50, 1000, 2000, 1, 1, 2, 10, 5,  RADAR_WAVEFORM_LONG},
+       {6, 1,  1,   0,  333,  333,  1, 1, 2, 30, 10, RADAR_WAVEFORM_LONG},
+};
+
+static void cl_dfs_fw_en(struct cl_hw *cl_hw, u8 dfs_en)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       cl_msg_tx_set_dfs(cl_hw, dfs_en, dfs_db->dfs_standard,
+                         conf->ci_dfs_initial_gain, conf->ci_dfs_agc_cd_th=
);
+}
+
+static int cl_dfs_print_tbl(struct cl_hw *cl_hw)
+{
+       int i;
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
-------------------"
+                   "---------------\n"
+                   "|    | Min   | Max   | Tol   |  Min  |  Max  | Tol | T=
ol  | Min   |     |"
+                   " Trig  |      |\n"
+                   "| ID | Width | Width | Width |  PRI  |  PRI  | PRI | F=
REQ | Burst | PPB |"
+                   " Count | Type |\n"
+                   "------------------------------------------------------=
-------------------"
+                   "---------------\n");
+
+       for (i =3D 0; i < dfs_db->radar_type_cnt; i++) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "| %2u | %5d  | %5d  | %5d  | %5d  | %5d  | %3d=
  | %4d  | %5u |"
+                           " %3u | %5u | %4d |\n",
+                           dfs_db->radar_type[i].id,
+                           dfs_db->radar_type[i].min_width,
+                           dfs_db->radar_type[i].max_width,
+                           dfs_db->radar_type[i].tol_width,
+                           dfs_db->radar_type[i].min_pri,
+                           dfs_db->radar_type[i].max_pri,
+                           dfs_db->radar_type[i].tol_pri,
+                           dfs_db->radar_type[i].tol_freq,
+                           dfs_db->radar_type[i].min_burst,
+                           dfs_db->radar_type[i].ppb,
+                           dfs_db->radar_type[i].trig_count,
+                           dfs_db->radar_type[i].waveform);
+               cl_snprintf(&buf, &len, &buf_size,
+                           "----------------------------------------------=
-------------------"
+                           "-----------------------\n");
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static bool cl_dfs_create_detection_buffer(struct cl_hw *cl_hw, struct cl_=
dfs_db *dfs_db,
+                                          struct cl_dfs_pulse *pulse_buffe=
r, u8 *samples_cnt,
+                                          unsigned long time)
+{
+       u8 i;
+       u8 pulse_idx;
+       /* Init First index to last */
+       u8 first_pulse_idx =3D (dfs_db->buf_idx - 1 + CL_DFS_PULSE_BUF_SIZE=
) & CL_DFS_PULSE_BUF_MASK;
+
+       /* Find Start Pulse indexes */
+       for (i =3D 0; i < CL_DFS_PULSE_BUF_SIZE; i++) {
+               pulse_idx =3D (i + dfs_db->buf_idx) & CL_DFS_PULSE_BUF_MASK=
;
+
+               if ((time - dfs_db->dfs_pulse[pulse_idx].time) < dfs_db->se=
arch_window) {
+                       first_pulse_idx =3D pulse_idx;
+                       break;
+               }
+       }
+
+       dfs_pr_info(cl_hw, "DFS: First pulse idx =3D %u, Last  pulse idx =
=3D %u\n",
+                   first_pulse_idx, dfs_db->buf_idx - 1);
+
+       if (dfs_db->buf_idx - 1 >=3D first_pulse_idx)
+               if ((dfs_db->buf_idx - first_pulse_idx - 1) < (dfs_db->min_=
pulse_eeq - 1)) {
+                       /* Return if buffer don't hold enough valid samples=
 */
+                       dfs_pr_warn(cl_hw, "DFS: Not enough pulses in buffe=
r\n");
+
+                       return false;
+               }
+
+       /* Copy the processed samples to local Buf to avoid index castings =
*/
+       for (i =3D 0; pulse_idx !=3D ((dfs_db->buf_idx - 1 + CL_DFS_PULSE_B=
UF_SIZE)
+               & CL_DFS_PULSE_BUF_MASK); i++) {
+               pulse_idx =3D (i + first_pulse_idx) & CL_DFS_PULSE_BUF_MASK=
;
+               memcpy(&pulse_buffer[i], &dfs_db->dfs_pulse[pulse_idx], siz=
eof(pulse_buffer[i]));
+       }
+       *samples_cnt =3D i + 1;
+
+       return true;
+}
+
+static void cl_dfs_add_pulses_to_global_buffer(struct cl_hw *cl_hw, struct=
 cl_dfs_db *dfs_db,
+                                              struct cl_radar_pulse *pulse=
, u8 pulse_cnt,
+                                              unsigned long time)
+{
+       int  i;
+
+       for (i =3D 0; i < pulse_cnt; i++)
+               dfs_pr_info(cl_hw, "Pulse=3D%d, Width=3D%u, PRI=3D%u, FREQ=
=3D%d, Time=3D%lu, FOM=3D%x\n",
+                           i, pulse[i].len, pulse[i].rep, pulse[i].freq, t=
ime, pulse[i].fom);
+
+       /* Maintain cyclic pulse buffer */
+       for (i =3D 0; i < pulse_cnt; i++) {
+               dfs_db->dfs_pulse[dfs_db->buf_idx].freq =3D pulse[i].freq;
+               dfs_db->dfs_pulse[dfs_db->buf_idx].width =3D pulse[i].len;
+               dfs_db->dfs_pulse[dfs_db->buf_idx].pri =3D pulse[i].rep;
+               dfs_db->dfs_pulse[dfs_db->buf_idx].occ =3D 0; /* occ temp d=
isabled. */
+               dfs_db->dfs_pulse[dfs_db->buf_idx].time =3D time;
+
+               dfs_db->buf_idx++;
+               dfs_db->buf_idx &=3D CL_DFS_PULSE_BUF_MASK;
+       }
+}
+
+static bool cl_dfs_buf_maintain(struct cl_hw *cl_hw, struct cl_radar_pulse=
 *pulse,
+                               struct cl_dfs_pulse *pulse_buffer, u8 pulse=
_cnt,
+                               unsigned long time, u8 *samples_cnt, struct=
 cl_dfs_db *dfs_db)
+{
+       int  i;
+
+       cl_dfs_add_pulses_to_global_buffer(cl_hw, dfs_db, pulse, pulse_cnt,=
 time);
+       if (!cl_dfs_create_detection_buffer(cl_hw, dfs_db, pulse_buffer, sa=
mples_cnt, time))
+               return false;
+
+       for (i =3D 0; i < *samples_cnt; i++)
+               dfs_pr_info(cl_hw, "DFS: pulse[%d]: width=3D%u, pri=3D%u, f=
req=3D%d\n",
+                           i, pulse_buffer[i].width, pulse_buffer[i].pri, =
pulse_buffer[i].freq);
+
+       return true;
+}
+
+static inline bool cl_dfs_pulse_match(s32 pulse_val, s32 spec_min_val,
+                                     s32 spec_max_val, s32 spec_tol)
+{
+       return ((pulse_val >=3D (spec_min_val - spec_tol)) &&
+               (pulse_val <=3D (spec_max_val + spec_tol)));
+}
+
+static u8 cl_dfs_is_stag_pulse(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_=
db,
+                              struct cl_dfs_pulse *pulse)
+{
+       int  i;
+       struct cl_radar_type *radar_type;
+
+       for (i =3D 0; i < dfs_db->radar_type_cnt; i++) {
+               radar_type =3D &dfs_db->radar_type[i];
+
+               if (radar_type->waveform !=3D RADAR_WAVEFORM_STAGGERED)
+                       continue;
+
+               if (cl_dfs_pulse_match((s32)pulse->width, radar_type->min_w=
idth,
+                                      radar_type->max_width, radar_type->t=
ol_width) &&
+                   cl_dfs_pulse_match((s32)pulse->pri, radar_type->min_pri=
,
+                                      radar_type->max_pri, radar_type->tol=
_pri)) {
+                       /* Search for the second burst */
+                       if (abs(pulse[0].pri - pulse[2].pri) <=3D dfs_db->r=
adar_type[i].tol_pri &&
+                           abs(pulse[1].pri - pulse[3].pri) <=3D radar_typ=
e->tol_pri &&
+                           abs(pulse[0].pri - pulse[1].pri) > radar_type->=
tol_pri &&
+                           abs(pulse[2].pri - pulse[3].pri) > radar_type->=
tol_pri) {
+                               dfs_pr_info(cl_hw, "DFS: Found match type %=
d\n", i);
+                               return (i + 1);
+                       } else if (abs(pulse[0].pri - pulse[3].pri) <=3D ra=
dar_type->tol_pri &&
+                                  abs(pulse[1].pri - pulse[4].pri) <=3D ra=
dar_type->tol_pri &&
+                                  abs(pulse[0].pri - pulse[1].pri) > radar=
_type->tol_pri &&
+                                  abs(pulse[3].pri - pulse[4].pri) > radar=
_type->tol_pri) {
+                               dfs_pr_info(cl_hw, "DFS: Found match radar =
%d\n", i);
+                               return (i + 1);
+                       }
+               }
+       }
+
+       return 0;
+}
+
+static u8 cl_dfs_is_non_stag_pulse(struct cl_hw *cl_hw, struct cl_dfs_db *=
dfs_db,
+                                  struct cl_dfs_pulse *pulse)
+{
+       int  i;
+       struct cl_radar_type *radar_type;
+
+       for (i =3D 0; i < dfs_db->radar_type_cnt; i++) {
+               radar_type =3D &dfs_db->radar_type[i];
+
+               if (radar_type->waveform =3D=3D RADAR_WAVEFORM_STAGGERED)
+                       continue;
+
+               if (cl_dfs_pulse_match((s32)pulse->width, radar_type->min_w=
idth,
+                                      radar_type->max_width, radar_type->t=
ol_width) &&
+                   cl_dfs_pulse_match((s32)pulse->pri, radar_type->min_pri=
,
+                                      radar_type->max_pri, radar_type->tol=
_pri)) {
+                       dfs_pr_info(cl_hw, "DFS: Found match type %d\n", i)=
;
+                       return (i + 1);
+               }
+       }
+
+       dfs_pr_warn(cl_hw, "DFS: Match not found\n");
+
+       return 0;
+}
+
+static u8 cl_dfs_get_pulse_type(struct cl_hw *cl_hw, struct cl_dfs_pulse *=
pulse,
+                               bool stag_candidate)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+
+       if (stag_candidate) {
+               u8 pulse_type =3D cl_dfs_is_stag_pulse(cl_hw, dfs_db, pulse=
);
+
+               if (pulse_type)
+                       return pulse_type;
+       }
+
+       return cl_dfs_is_non_stag_pulse(cl_hw, dfs_db, pulse);
+}
+
+static bool cl_dfs_compare_cand(struct cl_hw *cl_hw, struct cl_dfs_db *dfs=
_db, u8 pulse_type,
+                               struct cl_dfs_pulse radar_cand, u8 *match, =
int idx,
+                               u8 *occ_ch_cand)
+{
+       int i;
+
+       if (!(abs(dfs_db->pulse_buffer[idx].width - radar_cand.width) <=3D
+           dfs_db->radar_type[pulse_type].tol_width))
+               goto end;
+
+       if (!(abs(dfs_db->pulse_buffer[idx].freq - radar_cand.freq) <=3D
+           dfs_db->radar_type[pulse_type].tol_freq))
+               goto end;
+
+       for (i =3D 1; i < CL_DFS_CONCEAL_CNT; i++)
+               if (abs(dfs_db->pulse_buffer[idx].pri - i * radar_cand.pri)=
 <=3D
+                   dfs_db->radar_type[pulse_type].tol_pri)
+                       break;
+
+       if (i =3D=3D CL_DFS_CONCEAL_CNT)
+               goto end;
+
+       (*match)++;
+       (*occ_ch_cand) +=3D dfs_db->pulse_buffer[i].occ;
+
+end:
+       dfs_pr_info(cl_hw, "DFS: compared pulse - width=3D%u, pri=3D%u, fre=
q=3D%u match: %u "
+                   "trig cnt: %u\n",
+                   dfs_db->pulse_buffer[idx].width, dfs_db->pulse_buffer[i=
dx].pri,
+                   dfs_db->pulse_buffer[idx].freq, *match,
+                   dfs_db->radar_type[pulse_type].trig_count);
+
+       if (*match < dfs_db->radar_type[pulse_type].trig_count)
+               return false;
+
+       return true;
+}
+
+static bool cl_dfs_check_cand(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_d=
b, u8 pulse_type,
+                             struct cl_dfs_pulse radar_cand, u8 samples_cn=
t)
+{
+       u8 occ_ch_cand =3D 0;
+       u8 match =3D 0;
+       int i;
+
+       dfs_pr_info(cl_hw, "DFS: candidate pulse - width=3D%u, pri=3D%u, fr=
eq=3D%u\n",
+                   radar_cand.width, radar_cand.pri, radar_cand.freq);
+
+       for (i =3D 0; i < samples_cnt; i++) {
+               if (!cl_dfs_compare_cand(cl_hw, dfs_db, pulse_type, radar_c=
and, &match, i,
+                                        &occ_ch_cand))
+                       continue;
+
+               dfs_pr_verbose(cl_hw, "DFS: Radar detected - type %u\n", pu=
lse_type);
+               return true;
+       }
+
+       return false;
+}
+
+static bool cl_dfs_short_pulse_search(struct cl_hw *cl_hw, struct cl_radar=
_pulse *pulse,
+                                     u8 pulse_cnt, unsigned long time, str=
uct cl_dfs_db *dfs_db)
+{
+       int i;
+       bool stag_candidate;
+       u8 samples_cnt =3D 0;
+       u8 pulse_type;
+
+       /* Return if not enough pulses in the buffer */
+       if (!cl_dfs_buf_maintain(cl_hw, pulse, dfs_db->pulse_buffer, pulse_=
cnt, time,
+                                &samples_cnt, dfs_db))
+               return false;
+
+       for (i =3D 0; i < samples_cnt; i++) {
+               struct cl_dfs_pulse radar_cand;
+
+               stag_candidate =3D false;
+
+               /* Make sure there is enough samples to staggered check */
+               if (dfs_db->dfs_standard =3D=3D CL_STANDARD_ETSI &&
+                   (samples_cnt - i) > CL_DFS_STAGGERED_CHEC_LEN)
+                       stag_candidate =3D true;
+
+               pulse_type =3D cl_dfs_get_pulse_type(cl_hw, &dfs_db->pulse_=
buffer[i], stag_candidate);
+
+               if (!pulse_type)
+                       continue;
+
+               radar_cand.width =3D dfs_db->pulse_buffer[i].width;
+               radar_cand.pri =3D dfs_db->pulse_buffer[i].pri;
+               radar_cand.freq =3D dfs_db->pulse_buffer[i].freq;
+
+               if (cl_dfs_check_cand(cl_hw, dfs_db, pulse_type - 1, radar_=
cand, samples_cnt))
+                       return true;
+       }
+
+       return false;
+}
+
+static bool cl_dfs_long_pulse_search(struct cl_hw *cl_hw, struct cl_radar_=
pulse *pulse,
+                                    u8 pulse_cnt, unsigned long time)
+{
+       u32 prev_pulse_time_diff;
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       int i;
+
+       for (i =3D 0; i < pulse_cnt; i++) {
+               if (pulse[i].len > CL_DFS_LONG_MIN_WIDTH) {
+                       prev_pulse_time_diff =3D time - dfs_db->last_long_p=
ulse_ts;
+
+                       if (pulse[i].rep >=3D dfs_db->radar_type[5].min_pri=
 &&
+                           pulse[i].rep <=3D dfs_db->radar_type[5].max_pri=
)
+                               dfs_db->long_pri_match_count +=3D 1;
+
+                       dfs_pr_info(cl_hw, "DFS: Long pulse search: width =
=3D %u, delta_time =3D %u\n",
+                                   pulse[i].len, prev_pulse_time_diff);
+
+                       if (dfs_db->long_pulse_count =3D=3D 0 ||
+                           (prev_pulse_time_diff >=3D conf->ci_dfs_long_pu=
lse_min &&
+                            prev_pulse_time_diff <=3D conf->ci_dfs_long_pu=
lse_max)) {
+                               dfs_db->long_pulse_count +=3D 1;
+                       } else if (prev_pulse_time_diff > min(dfs_db->max_i=
nterrupt_diff,
+                                                    conf->ci_dfs_long_puls=
e_min)) {
+                               dfs_db->long_pulse_count =3D 0;
+                               dfs_db->short_pulse_count =3D 0;
+                               dfs_db->long_pri_match_count =3D 0;
+                       }
+                       dfs_db->last_long_pulse_ts =3D time;
+               } else if (pulse[i].len < CL_DFS_LONG_FALSE_WIDTH) {
+                       dfs_db->short_pulse_count++;
+
+                       if (dfs_db->short_pulse_count > CL_DFS_LONG_FALSE_I=
ND) {
+                               dfs_db->long_pulse_count =3D 0;
+                               dfs_db->short_pulse_count =3D 0;
+                               dfs_db->long_pri_match_count =3D 0;
+
+                               dfs_pr_warn(cl_hw, "DFS: Restart long seque=
nce search\n");
+                       }
+               }
+       }
+
+       if (dfs_db->long_pulse_count >=3D dfs_db->radar_type[5].trig_count =
&&
+           dfs_db->long_pri_match_count >=3D (dfs_db->radar_type[5].trig_c=
ount - 1)) {
+               dfs_db->short_pulse_count =3D 0;
+               dfs_db->long_pulse_count =3D 0;
+               dfs_db->long_pri_match_count =3D 0;
+               return true;
+       } else {
+               return false;
+       }
+}
+
+static bool cl_dfs_post_detection(struct cl_hw *cl_hw)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       /* Make sure firmware sets the DFS registers */
+       cl_radar_flush(cl_hw);
+       cl_msg_tx_set_dfs(cl_hw, false, dfs_db->dfs_standard,
+                         conf->ci_dfs_initial_gain, conf->ci_dfs_agc_cd_th=
);
+
+       ieee80211_radar_detected(cl_hw->hw);
+
+       return true;
+}
+
+bool cl_dfs_pulse_process(struct cl_hw *cl_hw, struct cl_radar_pulse *puls=
e, u8 pulse_cnt,
+                         unsigned long time)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+
+       dfs_db->pulse_cnt +=3D pulse_cnt;
+
+       if (dfs_db->dfs_standard =3D=3D CL_STANDARD_FCC &&
+           cl_dfs_long_pulse_search(cl_hw, pulse, pulse_cnt, time)) {
+               dfs_pr_verbose(cl_hw, "DFS: Radar detected - long\n");
+               return cl_dfs_post_detection(cl_hw);
+       } else if (cl_dfs_short_pulse_search(cl_hw, pulse, pulse_cnt, time,=
 dfs_db)) {
+               dfs_pr_verbose(cl_hw, "DFS: Radar detected - short\n");
+               return cl_dfs_post_detection(cl_hw);
+       }
+
+       return false;
+}
+
+static void cl_dfs_set_min_pulse(struct cl_hw *cl_hw)
+{
+       int i;
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+
+       dfs_db->min_pulse_eeq =3D U8_MAX;
+
+       for (i =3D 0; i < dfs_db->radar_type_cnt; i++) {
+               if (dfs_db->radar_type[i].trig_count < dfs_db->min_pulse_ee=
q)
+                       dfs_db->min_pulse_eeq =3D dfs_db->radar_type[i].tri=
g_count;
+       }
+       dfs_db->min_pulse_eeq =3D max(dfs_db->min_pulse_eeq, (u8)CL_DFS_MIN=
_PULSE_TRIG);
+}
+
+static void cl_dfs_set_region(struct cl_hw *cl_hw, enum cl_reg_standard st=
d)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+
+       dfs_db->dfs_standard =3D std;
+
+       if (dfs_db->dfs_standard =3D=3D CL_STANDARD_FCC) {
+               dfs_db->csa_cnt =3D CL_DFS_FCC_CSA_CNT;
+               dfs_db->radar_type =3D radar_type_fcc;
+               dfs_db->radar_type_cnt =3D sizeof(radar_type_fcc) / sizeof(=
struct cl_radar_type);
+       } else {
+               dfs_db->csa_cnt =3D CL_DFS_CE_CSA_CNT;
+               dfs_db->radar_type =3D radar_type_etsi;
+               dfs_db->radar_type_cnt =3D sizeof(radar_type_etsi) / sizeof=
(struct cl_radar_type);
+       }
+}
+
+static void cl_dfs_start_cac(struct cl_dfs_db *db)
+{
+       db->cac.started =3D true;
+}
+
+static void cl_dfs_end_cac(struct cl_dfs_db *db)
+{
+       db->cac.started =3D false;
+}
+
+void cl_dfs_radar_listen_start(struct cl_hw *cl_hw)
+{
+       set_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+
+       cl_dfs_fw_en(cl_hw, true);
+
+       dfs_pr_verbose(cl_hw, "DFS: Started radar listening\n");
+}
+
+void cl_dfs_radar_listen_end(struct cl_hw *cl_hw)
+{
+       clear_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+
+       cl_dfs_fw_en(cl_hw, false);
+
+       dfs_pr_verbose(cl_hw, "DFS: Ended radar listening\n");
+}
+
+void cl_dfs_force_cac_start(struct cl_hw *cl_hw)
+{
+       bool is_listening =3D test_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_fla=
gs);
+
+       cl_dfs_start_cac(&cl_hw->dfs_db);
+
+       /* Reset request state upon completion */
+       cl_dfs_request_cac(cl_hw, false);
+
+       /* Disable all the TX flow - be silent */
+       cl_tx_en(cl_hw, CL_TX_EN_DFS, false);
+
+       /* If for some reason we are still not listening radar, do it */
+       if (unlikely(!is_listening && cl_hw->hw->conf.radar_enabled))
+               cl_dfs_radar_listen_start(cl_hw);
+
+       dfs_pr_verbose(cl_hw, "DFS: CAC started\n");
+}
+
+void cl_dfs_force_cac_end(struct cl_hw *cl_hw)
+{
+       bool is_listening =3D test_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_fla=
gs);
+
+       /* Enable all the TX flow */
+       cl_tx_en(cl_hw, CL_TX_EN_DFS, true);
+
+       /*
+        * If for some reason we are still listening and mac80211 does not
+        * require to listen radar - disable it
+        */
+       if (unlikely(is_listening && !cl_hw->hw->conf.radar_enabled))
+               cl_dfs_radar_listen_end(cl_hw);
+
+       cl_dfs_end_cac(&cl_hw->dfs_db);
+
+       dfs_pr_verbose(cl_hw, "DFS: CAC ended\n");
+}
+
+static u16 cl_dfs_get_remain_cac_time(struct cl_hw *cl_hw)
+{
+       struct cl_vif *cl_vif =3D cl_vif_get_first_ap(cl_hw);
+       struct wireless_dev *wdev =3D cl_vif ? ieee80211_vif_to_wdev(cl_vif=
->vif) : NULL;
+
+       if (wdev && wdev->cac_started)
+               return (jiffies_to_msecs(jiffies - wdev->cac_start_time) / =
1000U);
+
+       return 0;
+}
+
+bool __must_check cl_dfs_is_en(struct cl_hw *cl_hw)
+{
+       return cl_hw->dfs_db.en;
+}
+
+bool __must_check cl_dfs_is_in_cac(struct cl_hw *cl_hw)
+{
+       return cl_hw->dfs_db.cac.started;
+}
+
+bool __must_check cl_dfs_radar_listening(struct cl_hw *cl_hw)
+{
+       return test_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+}
+
+bool __must_check cl_dfs_requested_cac(struct cl_hw *cl_hw)
+{
+       return cl_hw->dfs_db.cac.requested;
+}
+
+void cl_dfs_request_cac(struct cl_hw *cl_hw, bool should_do)
+{
+       cl_hw->dfs_db.cac.requested =3D should_do;
+}
+
+static void cl_dfs_edit_tbl(struct cl_hw *cl_hw, u8 row, u8 line, s16 val)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+
+       if (row > dfs_db->radar_type_cnt) {
+               dfs_pr_err(cl_hw, "Invalid row number (%u) [0 - %u]\n", lin=
e,
+                          dfs_db->radar_type_cnt - 1);
+               return;
+       }
+
+       if (line =3D=3D 0 || line > CL_DFS_MAX_TBL_LINE) {
+               dfs_pr_err(cl_hw, "Invalid line number (%u) [1 - %u]\n", li=
ne,
+                          CL_DFS_MAX_TBL_LINE - 1);
+               return;
+       }
+
+       if (line =3D=3D 1)
+               dfs_db->radar_type[row].min_width =3D (s32)val;
+       else if (line =3D=3D 2)
+               dfs_db->radar_type[row].max_width =3D (s32)val;
+       else if (line =3D=3D 3)
+               dfs_db->radar_type[row].tol_width =3D (s32)val;
+       else if (line =3D=3D 4)
+               dfs_db->radar_type[row].min_pri =3D (s32)val;
+       else if (line =3D=3D 5)
+               dfs_db->radar_type[row].max_pri =3D (s32)val;
+       else if (line =3D=3D 6)
+               dfs_db->radar_type[row].tol_pri =3D (s32)val;
+       else if (line =3D=3D 7)
+               dfs_db->radar_type[row].tol_freq =3D (s32)val;
+       else if (line =3D=3D 8)
+               dfs_db->radar_type[row].min_burst =3D (u8)val;
+       else if (line =3D=3D 9)
+               dfs_db->radar_type[row].ppb =3D (u8)val;
+       else if (line =3D=3D 10)
+               dfs_db->radar_type[row].trig_count =3D (u8)val;
+       else if (line =3D=3D 11)
+               dfs_db->radar_type[row].waveform =3D (enum cl_radar_wavefor=
m)val;
+
+       /* Verify if min_pulse_eeq was changed */
+       cl_dfs_set_min_pulse(cl_hw);
+}
+
+static void cl_dfs_tbl_overwrite_set(struct cl_hw *cl_hw)
+{
+       s8 *tok =3D NULL, *saveptr =3D NULL;
+       u8 param1 =3D 0;
+       u8 param2 =3D 0;
+       s16 param3 =3D 0;
+       char str[64];
+
+       if (strlen(cl_hw->conf->ce_dfs_tbl_overwrite) =3D=3D 0)
+               return;
+
+       snprintf(str, sizeof(str), cl_hw->conf->ce_dfs_tbl_overwrite);
+
+       tok =3D cl_strtok_r(str, ",", &saveptr);
+       while (tok) {
+               if (sscanf(tok, "%hhd,%hhd,%hd", &param1, &param2, &param3)=
 =3D=3D 3)
+                       cl_dfs_edit_tbl(cl_hw, param1, param2, param3);
+               tok =3D cl_strtok_r(NULL, ",", &saveptr);
+       }
+}
+
+void cl_dfs_close(struct cl_hw *cl_hw)
+{
+       if (!cl_band_is_5g(cl_hw))
+               return;
+
+       cl_hw->dfs_db.en =3D false;
+}
+
+void cl_dfs_init(struct cl_hw *cl_hw)
+{
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+
+       if (!cl_band_is_5g(cl_hw))
+               return;
+
+       dfs_db->en =3D conf->ci_ieee80211h;
+
+       /*
+        * Setting min window size to avoid the case where the second inter=
rupt
+        * within the burst is setting the counter to 0. the max is between=
 jiffies
+        * unit and max PRI in ms.
+        */
+       dfs_db->max_interrupt_diff =3D max(1000 / HZ, 2);
+       dfs_db->search_window =3D CL_DFS_PULSE_WINDOW;
+
+       cl_dfs_set_region(cl_hw, cl_hw->channel_info.standard);
+       cl_dfs_set_min_pulse(cl_hw);
+       cl_dfs_tbl_overwrite_set(cl_hw);
+}
+
+void cl_dfs_recovery(struct cl_hw *cl_hw)
+{
+       /* Re-enable DFS after recovery */
+       if (cl_dfs_is_in_cac(cl_hw)) {
+               cl_dfs_fw_en(cl_hw, true);
+
+               /* If recovery happened during CAC make sure to disable bea=
con backup */
+               cl_tx_en(cl_hw, CL_TX_EN_DFS, false);
+       }
+}
+
+static int cl_dfs_print_pulse_buffer(struct cl_hw *cl_hw, bool clear_buf)
+{
+       int i;
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "DFS Pulse Count =3D %u\n", dfs_db->pulse_cnt);
+
+       for (i =3D 0; i < ARRAY_SIZE(dfs_db->dfs_pulse); i++) {
+               cl_snprintf(&buf, &len, &buf_size,
+                           "Pulse Buffer: i=3D%d, Width=3D%u, PRI=3D%u, FR=
EQ=3D%d, OCC=3D%u, Time=3D%lu\n",
+                           i, dfs_db->dfs_pulse[i].width,
+                           dfs_db->dfs_pulse[i].pri,
+                           dfs_db->dfs_pulse[i].freq,
+                           dfs_db->dfs_pulse[i].occ,
+                           dfs_db->dfs_pulse[i].time);
+       }
+
+       if (clear_buf) {
+               dfs_db->pulse_cnt =3D 0;
+               memset(dfs_db->dfs_pulse, 0, sizeof(dfs_db->dfs_pulse));
+       }
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_dfs_cli_force_detection(struct cl_hw *cl_hw, struct cl_dfs_=
db *dfs_db)
+{
+       dfs_pr_verbose(cl_hw, "DFS: Force Radar Detection\n");
+       cl_dfs_post_detection(cl_hw);
+}
+
+static void cl_dfs_cli_set_cac(struct cl_hw *cl_hw, bool start)
+{
+       if (start)
+               cl_dfs_force_cac_start(cl_hw);
+       else
+               cl_dfs_force_cac_end(cl_hw);
+}
+
+static int cl_dfs_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "dfs usage:\n"
+                "-b : Print pulse buffer [(0)Read / (1)Read and clear]\n"
+                "-c : Stop/Start CAC[(0)Stop / (1)Start]\n"
+                "-d : DFS debug mode[0: Verbose 1: Error, 2: Warning, 3: T=
race, 4: Info]\n"
+                "-e : Enable/Disable DFS [(0)Disable DFS / (1)Enable DFS]\=
n"
+                "-f : Force radar detection\n"
+                "-i : Set initial gain\n"
+                "-j : Set agc cd threshold\n"
+                "-k : return remaining cac time (in seconds)\n"
+                "-m : Set Min/Max Windows for Long radar types\n"
+                "-p : Print radar tables [0:Detection Table, 1:Channel inf=
o]\n"
+                "-q : Print jumpable channel list\n"
+                "-s : Simulate radar detection table "
+                       "[width][pri][freq][time]\n"
+                "-t : Edit radar detection table [row][line][value]\n"
+                "-w : Set search window size\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_dfs_cli(struct cl_hw *cl_hw, struct cli_params *cli_params, u8 *ret=
_buf, u16 *ret_buf_len)
+{
+       s32 *params =3D cli_params->params;
+       u32 expected_params =3D 0;
+       struct cl_dfs_db *dfs_db =3D &cl_hw->dfs_db;
+       struct cl_tcv_conf *conf =3D cl_hw->conf;
+       bool print_buf =3D false;
+       bool dbg_lvl =3D false;
+       bool en =3D false;
+       bool force =3D false;
+       bool print_tbl =3D false;
+       bool return_remain_cac_time =3D false;
+       bool radar_sim =3D false;
+       bool edit_tbl =3D false;
+       bool win_set =3D false;
+       bool cac =3D false;
+       bool long_prms =3D false;
+       bool init_gain =3D false;
+       bool agc_cd_hh =3D false;
+
+       switch (cli_params->option) {
+       case 'b':
+               print_buf =3D true;
+               expected_params =3D 1;
+               break;
+       case 'c':
+               cac =3D true;
+               expected_params =3D 1;
+               break;
+       case 'd':
+               dbg_lvl =3D true;
+               expected_params =3D 1;
+               break;
+       case 'e':
+               en =3D true;
+               expected_params =3D 1;
+               break;
+       case 'f':
+               force =3D true;
+               expected_params =3D 0;
+               break;
+       case 'i':
+               init_gain =3D true;
+               expected_params =3D 1;
+               break;
+       case 'j':
+               agc_cd_hh =3D true;
+               expected_params =3D 1;
+               break;
+       case 'k':
+               return_remain_cac_time =3D true;
+               expected_params =3D 0;
+               break;
+       case 'm':
+               long_prms =3D true;
+               expected_params =3D 2;
+               break;
+       case 'p':
+               print_tbl =3D true;
+               expected_params =3D 1;
+               break;
+       case 's':
+               radar_sim =3D true;
+               expected_params =3D 4;
+               break;
+       case 't':
+               edit_tbl =3D true;
+               expected_params =3D 3;
+               break;
+       case 'w':
+               win_set =3D true;
+               expected_params =3D 1;
+               break;
+       case '?':
+               return cl_dfs_cli_help(cl_hw);
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
+       if (cac) {
+               bool start =3D (bool)params[0];
+
+               cl_dfs_cli_set_cac(cl_hw, start);
+               return 0;
+       }
+
+       if (print_buf)
+               return cl_dfs_print_pulse_buffer(cl_hw, (bool)params[0]);
+
+       if (dbg_lvl) {
+               s32 dbg_lvl =3D params[0];
+
+               if (dbg_lvl > 0 && dbg_lvl < DBG_LVL_MAX) {
+                       dfs_db->dbg_lvl =3D dbg_lvl;
+                       dfs_pr_verbose(cl_hw, "Debug level =3D %d\n", dbg_l=
vl);
+               } else {
+                       dfs_pr_err(cl_hw, "Invalid debug level (%d)\n", dbg=
_lvl);
+               }
+
+               return 0;
+       }
+
+       if (en) {
+               dfs_db->en =3D (bool)(params[0]);
+               dfs_pr_verbose(cl_hw, "DFS =3D %s\n", dfs_db->en ? "Enabled=
" : "Disabled");
+               cl_dfs_fw_en(cl_hw, dfs_db->en);
+               return 0;
+       }
+
+       if (force) {
+               cl_dfs_cli_force_detection(cl_hw, dfs_db);
+               return 0;
+       }
+
+       if (print_tbl) {
+               u8 table =3D (u8)params[0];
+
+               if (table =3D=3D 0)
+                       return cl_dfs_print_tbl(cl_hw);
+               return 0;
+       }
+
+       if (return_remain_cac_time) {
+               u16 cac_time =3D cl_dfs_get_remain_cac_time(cl_hw);
+
+               snprintf(ret_buf, PAGE_SIZE, "%u", cac_time);
+               *ret_buf_len =3D strlen(ret_buf);
+               return 1;
+       }
+
+       if (radar_sim) {
+               struct cl_radar_pulse pulse[CL_DFS_MAX_PULSE];
+               unsigned long time;
+
+               pulse[0].len  =3D (u32)params[0];
+               pulse[0].rep  =3D (u32)params[1];
+               pulse[0].freq =3D (s32)params[2];
+               time =3D (unsigned long)params[3];
+               cl_dfs_pulse_process(cl_hw, pulse, 1, time);
+               return 0;
+       }
+
+       if (edit_tbl) {
+               cl_dfs_edit_tbl(cl_hw, (u8)params[0], (u8)params[1], (s16)p=
arams[2]);
+               return 0;
+       }
+
+       if (win_set) {
+               dfs_db->search_window =3D (u16)params[0];
+               dfs_pr_verbose(cl_hw, "Search window size =3D %u\n", dfs_db=
->search_window);
+               return 0;
+       }
+
+       if (long_prms) {
+               conf->ci_dfs_long_pulse_min =3D (u16)params[0];
+               conf->ci_dfs_long_pulse_max =3D (u16)params[1];
+               dfs_pr_verbose(cl_hw, "Long pulse min =3D %u\n", conf->ci_d=
fs_long_pulse_min);
+               dfs_pr_verbose(cl_hw, "Long pulse max =3D %u\n", conf->ci_d=
fs_long_pulse_max);
+               return 0;
+       }
+
+       if (init_gain) {
+               conf->ci_dfs_initial_gain =3D (u8)params[0];
+               dfs_pr_verbose(cl_hw, "Initial gain =3D %u\n", conf->ci_dfs=
_initial_gain);
+               return 0;
+       }
+
+       if (agc_cd_hh) {
+               conf->ci_dfs_agc_cd_th =3D (u8)params[0];
+               dfs_pr_verbose(cl_hw, "AGC CD threshold =3D %u\n", conf->ci=
_dfs_agc_cd_th);
+               return 0;
+       }
+
+out_err:
+       return -EIO;
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

