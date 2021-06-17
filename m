Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D72883AB83A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbhFQQFu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:50 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:15895
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232689AbhFQQFs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAwLi2WcGFr2ubLd3VKBmadjM/fYm5+xuNowp1f+B+Agpny2CFLxVDFBgrIrquADa3awGmd8Yz7PSaOCJzsF/9DcYubQTPhYd2oXmm2A4DTlH32FTJQydm7cYJVNDcAyCvlEGbW1NAI1eJKEnfdm3KmdiVuBTpSdOfV0ezv4i58K2KK90chJZkBeBrZWuRKIjVJGXR42R9DhVz7beyWfjmhmP5L/30klQxQBxziMWqYW42rkleLbl+ZlsX+3q7dus1AQEpGv0BIxCdnbuM8BQ23t25k/luu79DeHHB6Onxk9BdvClBedbLk4EnFZpX2tSE+1u3kvNDhEGrrmBnm5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KATMfPmJp/KJWKiWZBc3jTXXdjpmP3/fPJ14IpM31M=;
 b=D8LDzp/VOD7s/aa8lu1hULX4ccFdXmFN4iSBgCnnvo4pjlTbNvT6mN26uKR5fYlXUSWJ8MWeN2EyJYBuRn7e3YhpuqaBrcaOIpoMnyrGwXvCR4lVi6a7lZWjKioERzwPuQBNw633eHrQmXM94CnS3ts+GsyYIjStt30czNAoD1Heb5CPjlU5xF34kY9xdKh+FGHu67vKcjayl6yEAfJ5xfGH8XckKjSt9Y7ZjA1J/i0683pSQu+EJ2Vmk4eIyjYvuFVCVtGSYyNvni9FAHBthevChHoOEzLdDL0Aq+rGUfk8GeqQN9bO8ZLsqhyBYt8DuBosQmJegr+ZYROHKxoVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KATMfPmJp/KJWKiWZBc3jTXXdjpmP3/fPJ14IpM31M=;
 b=DxW7QestOKeCeitcd7TWHE/norc9cRVTdM9CSBHESliTkLPukFZGAH/fvwTPd18NgGsdcke/771O5Z2SWrGx+T0l/0sK8l51MD9PCZloDntr4XqVLpFuVQgzP0AZKsXSyRRhLeApYxy/WiFMhugJiHQGZdb9kfzq6gJx6JvO/iY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB0966.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ce::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Thu, 17 Jun
 2021 16:03:37 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:37 +0000
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
Subject: [RFC v1 032/256] cl8k: add cca.c
Date:   Thu, 17 Jun 2021 15:58:39 +0000
Message-Id: <20210617160223.160998-33-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e45f85f9-2070-4250-4ead-08d931a966fc
X-MS-TrafficTypeDiagnostic: AM9P192MB0966:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB09662F9E50CA2DE85A4C9F47F60E9@AM9P192MB0966.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7b6qT2wJhaSNv5IgmUhSbfcZyG0+2TSuK/R1xGbCqjE35jXb5iPfcg+fVNZjCPts9HpgcKcu7BW7FEoST1h8KZPniK+1Ap5ZmBQkX07WazPF1Oz8nUJb6TYCmdyfpg5LFQKNp/0EhVMdhRTCr3zH6yxybz/z8gH2a+b3DeKXppr7U1fO0Z89aD6doTcGW+A22gNqHd0hBtM46Fe1qBTc9BmF/ywbtaMmQyVW/EnpBhz8kDJ23/ms/QQq9NK2n8qkSdu0viSZ3CvB+GwGGYeVftvS9nYCd5bbhewGuOJ42rgOhmgQGjr0MhD+vX3uqORdP4bGZ3Z/G1I+uJrky6w1W84sobO4qSMl81IiGSzxMxHOztYWz9Ytc7q/bjUjSsLAt9ekj/AKdODHHHa4ar1Veq6KaFMYwz8iuWR3jaE/Lok/XEhotqCxRgVUqutqle+WlG2Nus6jTar516YvtSmyySU5/yA2YUqLpFpbRsYvkL+HVHm1j2Yae3HmFMfOYbIoG/qmGRrib6riSV2WOrHGolJAwDkoZLxkyQ2r+vne2OQH88MrntM1GTtrgZEivUOMxYd6rkVaCsYq9DlNi8qzeek5GR2KBekwUH9LnZSOdfNkWG8WIQ5J2YFYe1HHyVm2kt14UINUKYM8775MbyPkYc29UnGj1geYNmESXfMB2bgCjOcaZqS5BRip3YF20RV9tVyPe7P1VoTEvHltU1EAJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(39850400004)(376002)(396003)(30864003)(4326008)(1076003)(2616005)(8676002)(186003)(6512007)(6486002)(107886003)(83380400001)(6916009)(38100700002)(55236004)(316002)(16526019)(6506007)(38350700002)(6666004)(54906003)(8936002)(26005)(508600001)(36756003)(2906002)(9686003)(52116002)(956004)(5660300002)(66946007)(66556008)(66476007)(86362001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NokdRWNpvhupUv3FrAqZOm97MGD7flL46TDaotAHlnTJJZNZKU8yCHEq8FdD?=
 =?us-ascii?Q?nU1kvLKuWoyrsQK3ReE1Xv8fxG8BUYxFrjoXqhl8KfkaghqwNZB71wejE6PT?=
 =?us-ascii?Q?m9qegfVGk6a/moz4gxRlRIlSvCO0bqpGa6IVjisWrzrrFKue6jBnA3+nPwAY?=
 =?us-ascii?Q?1nCM+M6tq+f4mAGcq9LTCi9s1BuI0qYucQh4SctdmE8TkMt2cFd3epCETe3K?=
 =?us-ascii?Q?bxggDKXvg3wcpEXkUbkaCYVTg9g4tBVi5ESDRpVyHLpBhSu7pgxlGqvEN6fe?=
 =?us-ascii?Q?2ErQZ98XUbKaUXMRzgsc0iIsfsDpEPEAuI7pzm0BFwa/17PFg26Nx1qhxAo1?=
 =?us-ascii?Q?ZjfP7FRlDsvTnYKWmPAJTcz4I2sTQZS3CEVjQ7veBYwVCJsBHqOWE9XVAc+i?=
 =?us-ascii?Q?/U/oVUq6RE5hmt4EzzrXjRCzjlj7nxIuh2mW6N5D8zN4oLYQE22DmJ2KVy/S?=
 =?us-ascii?Q?Sqv6jlW5oRh/PDNs9R44TA2Oo9KJ8GTjvy1ZHKc8vp+tV1BdZHZe790ccTBc?=
 =?us-ascii?Q?4ewNBZDEXlhic52xgK67Lky4I7AUv2IjrviSaqRXKNPRxztVCcduI9A8aZ/6?=
 =?us-ascii?Q?UdPGeuTLbVzxJdiB7mjOUvG9YFaFrWnH48UlqzqEO5w53Mr28iP2f5BZyRCN?=
 =?us-ascii?Q?day27ItptDfL40Idfw8mJROE9Rpen0R7H29U+hB49jXC0A34iUTZyCGWvcSY?=
 =?us-ascii?Q?1e/8IUmenwavf7tsjCG43mCbwxPw1Ao/YguGsbZkOxbGP3YkOSQ7PACjBNGs?=
 =?us-ascii?Q?T8xM/UFWXwytMBKgluichM9fvY4QY1950nbfnaYX9uRjD/EGOLIYfNRH9GM0?=
 =?us-ascii?Q?epN6Yop8VNRXfpLx5fld1D2DM4LLiW3yIKEXHSH59YNwz5w72Od2OMkh3TP/?=
 =?us-ascii?Q?kix4y/B93UbHRLDMEnqq9j3l80mTPF1MPPJjIC+9rCcPZ0VW9d9nhHhimxtz?=
 =?us-ascii?Q?Ri0EakxuZGGP55np0//eH8zw7iloYUyIUqcEIwlUPcn9dme/fnCxQdWTzKXQ?=
 =?us-ascii?Q?bKcrRcbjkQs1rUYMlg0UIBF5DIwwXLhgdYokSMJRcP7FP1Umd/4j54rJXXQi?=
 =?us-ascii?Q?r+R/rURVF9dD+TYjxet/NvcF1TEdAtyL5abiO9cMiVIzks7psqueeyAlMZ4g?=
 =?us-ascii?Q?1UxZ9Ht9Nw/doM+4SrFhyRig9G6tD8eueO4mwr66KR6dakm7jNE8lSncPxDD?=
 =?us-ascii?Q?R/u/cFHR9mRIsjl+UwW/pSxxbYtKLnIh7BA96n5nVEOIpHaLN1co1zRcnRET?=
 =?us-ascii?Q?omn9uYlvNv1uAC/QqQk5zSPKumLZ+C9b8SvG1xyrSXB2O9SMpi2ntJywl0rm?=
 =?us-ascii?Q?aHq4VRxEARvRe+IPOFrGQ1s3?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45f85f9-2070-4250-4ead-08d931a966fc
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:10.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PEpiHuLBL/mERpamn3qEGvJCJIXAl2X6Xu/19Yo+5RkbhqJLZAPdCq5hZQ5iuE6Ue1QLrQ5VXrlsMaOCxk5xxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0966
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/cca.c | 518 +++++++++++++++++++++++++
 1 file changed, 518 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/cca.c

diff --git a/drivers/net/wireless/celeno/cl8k/cca.c b/drivers/net/wireless/=
celeno/cl8k/cca.c
new file mode 100644
index 000000000000..70f1d54b771b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/cca.c
@@ -0,0 +1,518 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "cca.h"
+#include "reg/reg_mac_hw.h"
+#include "reg/reg_riu.h"
+#include "band.h"
+#include "hw.h"
+
+#define TO_PERCENT(val, interval) (100 * (val) / (interval))
+#define SET_CCA_OPT(en, a, b) ((en) ? ((a) |=3D (b)) : ((a) &=3D ~(b)))
+#define MDM_AFTER_L_SIG  0x3F0
+#define MDM_BEFORE_L_SIG 0x3F8
+#define SAMPLE_RES       5
+
+static void cl_cca_print_cs(struct cl_hw *cl_hw, unsigned long time)
+{
+       u8 cca_cs =3D TO_PERCENT(riu_cca_cnt_cs_get(cl_hw), time);
+
+       pr_debug("cca_cs =3D %u%%\n", cca_cs);
+}
+
+static void cl_cca_print_mdm_state(struct cl_hw *cl_hw, unsigned long time=
)
+{
+       u32 cca_mdm_state_p =3D TO_PERCENT(riu_cca_cnt_modem_state_p_get(cl=
_hw), time);
+       u32 cca_mdm_state_20s =3D TO_PERCENT(riu_cca_cnt_modem_state_20_s_g=
et(cl_hw), time);
+       u32 cca_mdm_state_40s =3D TO_PERCENT(riu_cca_cnt_modem_state_40_s_g=
et(cl_hw), time);
+       u32 cca_mdm_state_80s =3D TO_PERCENT(riu_cca_cnt_modem_state_80_s_g=
et(cl_hw), time);
+
+       pr_debug("cca_mdm_state: primary =3D %u%%, sec20 =3D %u%%, sec40 =
=3D %u%%, sec80 =3D %u%%\n",
+                cca_mdm_state_p, cca_mdm_state_20s, cca_mdm_state_40s, cca=
_mdm_state_80s);
+}
+
+static void cl_cca_print_mp(struct cl_hw *cl_hw, unsigned long time)
+{
+       u32 cca_mp_20p =3D TO_PERCENT(riu_cca_cnt_gi_20_p_get(cl_hw), time)=
;
+       u32 cca_mp_20s =3D TO_PERCENT(riu_cca_cnt_gi_20_s_get(cl_hw), time)=
;
+       u32 cca_mp_40s =3D TO_PERCENT(riu_cca_cnt_gi_40_s_get(cl_hw), time)=
;
+       u32 cca_mp_80s =3D TO_PERCENT(riu_cca_cnt_gi_80_s_get(cl_hw), time)=
;
+
+       pr_debug("cca_mp: primary =3D %u%%, sec20 =3D %u%%, sec40 =3D %u, s=
ec80 =3D %u%%\n",
+                cca_mp_20p, cca_mp_20s, cca_mp_40s, cca_mp_80s);
+}
+
+static void cl_cca_print_energy(struct cl_hw *cl_hw, unsigned long time)
+{
+       u32 cca_energy_thr_p =3D TO_PERCENT(riu_cca_cnt_energy_thr_p_get(cl=
_hw), time);
+       u32 cca_energy_thr_20s =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_s_g=
et(cl_hw), time);
+       u32 cca_energy_thr_40s =3D TO_PERCENT(riu_cca_cnt_energy_thr_40_s_g=
et(cl_hw), time);
+       u32 cca_energy_thr_80s =3D TO_PERCENT(riu_cca_cnt_energy_thr_80_s_g=
et(cl_hw), time);
+
+       pr_debug("cca_energy_thr: primary =3D %u%%, sec20 =3D %u%%, sec40 =
=3D (%u%%), sec80 =3D %u%%\n",
+                cca_energy_thr_p, cca_energy_thr_20s, cca_energy_thr_40s, =
cca_energy_thr_80s);
+}
+
+static void cl_cca_print_energy_band(struct cl_hw *cl_hw, unsigned long ti=
me)
+{
+       u32 cca_energy_20_band0 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_0_get(cl_hw), time);
+       u32 cca_energy_20_band1 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_1_get(cl_hw), time);
+       u32 cca_energy_20_band2 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_2_get(cl_hw), time);
+       u32 cca_energy_20_band3 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_3_get(cl_hw), time);
+       u32 cca_energy_20_band4 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_4_get(cl_hw), time);
+       u32 cca_energy_20_band5 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_5_get(cl_hw), time);
+       u32 cca_energy_20_band6 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_6_get(cl_hw), time);
+       u32 cca_energy_20_band7 =3D TO_PERCENT(riu_cca_cnt_energy_thr_20_ba=
nd_7_get(cl_hw), time);
+
+       pr_debug("cca_energy_20: band0 =3D %u%%, band1 =3D %u%%, band2 =3D =
%u%%, band3 =3D %u%%, "
+                "band4 =3D %u%%, band5 =3D %u%%, band6 =3D %u%%, band7 =3D=
 %u%%\n",
+                cca_energy_20_band0, cca_energy_20_band1, cca_energy_20_ba=
nd2,
+                cca_energy_20_band3, cca_energy_20_band4, cca_energy_20_ba=
nd5,
+                cca_energy_20_band6, cca_energy_20_band7);
+}
+
+static void cl_cca_update_counters(u16 *hist, u32 counter)
+{
+       if (counter =3D=3D 0)
+               hist[0]++;
+       else if (counter > 100)
+               hist[CCA_MAX_SAMPLE - 1]++;
+       else
+               hist[((counter - 1) / SAMPLE_RES) + 1]++;
+}
+
+static void cl_cca_print_utility(struct cl_hw *cl_hw, unsigned long time)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+       struct cl_edca_hist_db *hist_db =3D &cca_db->edca_hist;
+       u32 cca_cs =3D riu_cca_cnt_cs_get(cl_hw);
+       u32 edca_busy =3D mac_hw_edca_cca_busy_get(cl_hw);
+       u32 cca_mdm_state_p =3D riu_cca_cnt_modem_state_p_get(cl_hw);
+       u32 tx_mine =3D mac_hw_tx_mine_busy_get(cl_hw);
+       u32 rx_mine =3D mac_hw_rx_mine_busy_get(cl_hw);
+       u32 sample_cnt =3D hist_db->sample_cnt;
+       u32 edca_busy_diff =3D edca_busy - cca_db->edca_busy;
+       u32 tx_mine_diff =3D tx_mine - cca_db->tx_mine;
+       u32 rx_mine_diff =3D rx_mine - cca_db->rx_mine;
+
+       /* Cca utility formulas */
+       u32 air_util =3D cca_cs + tx_mine_diff;
+       u32 wifi_air_util =3D cca_mdm_state_p + tx_mine_diff;
+       u32 not_mine_rx_wifi =3D cca_mdm_state_p - rx_mine_diff;
+       u32 mine_util =3D tx_mine_diff + rx_mine_diff;
+       u32 non_wifi_util =3D edca_busy_diff - cca_mdm_state_p;
+       u32 not_mine_util =3D edca_busy_diff - rx_mine_diff;
+       u32 not_mine_time =3D time - mine_util;
+
+       u32 air_util_percent =3D TO_PERCENT(air_util, time);
+       u32 wifi_air_util_percent =3D TO_PERCENT(wifi_air_util, time);
+       u32 not_mine_rx_wifi_percent =3D TO_PERCENT(not_mine_rx_wifi, time)=
;
+       u32 mine_util_percent =3D TO_PERCENT(mine_util, time);
+       u32 non_wifi_util_percent =3D TO_PERCENT(non_wifi_util, time);
+       u32 not_mine_util_percent =3D TO_PERCENT(not_mine_util, time);
+       u32 not_mine_busy_util_percent =3D
+               (not_mine_time > 0) ? TO_PERCENT(not_mine_util, not_mine_ti=
me) : 0;
+
+       cca_db->edca_busy =3D edca_busy;
+       cca_db->tx_mine =3D tx_mine;
+       cca_db->rx_mine =3D rx_mine;
+
+       if (sample_cnt > 0) {
+               cl_cca_update_counters(hist_db->air_util, air_util_percent)=
;
+               cl_cca_update_counters(hist_db->wifi_air_util, wifi_air_uti=
l_percent);
+               cl_cca_update_counters(hist_db->not_mine_rx_wifi, not_mine_=
rx_wifi_percent);
+               cl_cca_update_counters(hist_db->mine, mine_util_percent);
+               cl_cca_update_counters(hist_db->non_wifi_util, non_wifi_uti=
l_percent);
+               cl_cca_update_counters(hist_db->not_mine, not_mine_util_per=
cent);
+               cl_cca_update_counters(hist_db->not_mine_busy, not_mine_bus=
y_util_percent);
+
+               hist_db->sample_cnt--;
+
+               /* Stop sampling */
+               if (hist_db->sample_cnt =3D=3D 0) {
+                       SET_CCA_OPT(0, cca_db->cca_opt, CCA_OPT_REC_HIST);
+                       pr_debug("Record is done\n");
+               }
+       }
+
+       if (cca_db->cca_opt & CCA_OPT_UTIL)
+               pr_debug("air_util =3D %u%%, wifi_air_util =3D %u%%, not_mi=
ne_rx_wifi =3D %u%%, "
+                        "mine_util =3D %u%%, non_wifi_util =3D %u%%, not_m=
ine_util =3D %u%%, "
+                        "not_mine_busy_util =3D %u%%\n",
+                        air_util_percent, wifi_air_util_percent, not_mine_=
rx_wifi,
+                        mine_util_percent, non_wifi_util_percent, not_mine=
_util_percent,
+                        not_mine_busy_util_percent);
+}
+
+static void cl_cca_print_tx_rx_mine(struct cl_hw *cl_hw, unsigned long tim=
e)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+
+       u32 tx_mine =3D mac_hw_tx_mine_busy_get(cl_hw);
+       u32 rx_mine =3D mac_hw_rx_mine_busy_get(cl_hw);
+
+       u32 diff_tx_mine =3D tx_mine - cca_db->print_tx_mine;
+       u32 diff_rx_mine =3D rx_mine - cca_db->print_rx_mine;
+
+       cca_db->print_tx_mine =3D tx_mine;
+       cca_db->print_rx_mine =3D rx_mine;
+
+       pr_debug("tx_mine =3D %u (%lu%%), rx_mine =3D %u (%lu%%)\n",
+                diff_tx_mine,
+                TO_PERCENT(diff_tx_mine, time),
+                diff_rx_mine,
+                TO_PERCENT(diff_rx_mine, time));
+}
+
+static void cl_cca_edca(struct cl_hw *cl_hw, unsigned long time)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool sec80 =3D !is_24g;
+
+       u32 new_edca_busy =3D mac_hw_edca_cca_busy_get(cl_hw);
+       u32 new_edca_busy_sec20 =3D mac_hw_add_cca_busy_sec_20_get(cl_hw);
+       u32 new_edca_busy_sec40 =3D is_24g ? 0 : mac_hw_add_cca_busy_sec_40=
_get(cl_hw);
+       u32 new_edca_busy_sec80 =3D sec80 ? mac_hw_add_cca_busy_sec_80_get(=
cl_hw) : 0;
+
+       u32 diff_edca_busy =3D new_edca_busy - cca_db->edca_busy;
+       u32 diff_edca_busy_sec20 =3D new_edca_busy_sec20 - cca_db->edca_bus=
y_sec20;
+       u32 diff_edca_busy_sec40 =3D new_edca_busy_sec40 - cca_db->edca_bus=
y_sec40;
+       u32 diff_edca_busy_sec80 =3D new_edca_busy_sec80 - cca_db->edca_bus=
y_sec80;
+
+       u32 percent_edca_busy =3D TO_PERCENT(diff_edca_busy, time);
+       u32 percent_edca_busy_sec20 =3D TO_PERCENT(diff_edca_busy_sec20, ti=
me);
+       u32 percent_edca_busy_sec40 =3D TO_PERCENT(diff_edca_busy_sec40, ti=
me);
+       u32 percent_edca_busy_sec80 =3D TO_PERCENT(diff_edca_busy_sec80, ti=
me);
+
+       cca_db->edca_busy =3D new_edca_busy;
+       cca_db->edca_busy_sec20 =3D new_edca_busy_sec20;
+       cca_db->edca_busy_sec40 =3D new_edca_busy_sec40;
+       cca_db->edca_busy_sec80 =3D new_edca_busy_sec80;
+
+       pr_debug("edca_busy: primary =3D %u (%u%%), sec20 =3D %u (%u%%), "
+                "sec40 =3D %u (%u%%), sec80 =3D %u (%u%%)\n",
+                diff_edca_busy, percent_edca_busy,
+                diff_edca_busy_sec20, percent_edca_busy_sec20,
+                diff_edca_busy_sec40, percent_edca_busy_sec40,
+                diff_edca_busy_sec80, percent_edca_busy_sec80);
+}
+
+static void cl_cca_print_edca_nav(struct cl_hw *cl_hw, unsigned long time)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+
+       u32 new_cca_busy_nav =3D mac_hw_edca_nav_busy_get(cl_hw);
+       u32 new_cca_intra_bss_nav =3D mac_hw_intra_bss_nav_busy_get(cl_hw);
+       u32 new_cca_inter_bss_nav =3D mac_hw_inter_bss_nav_busy_get(cl_hw);
+
+       u32 diff_cca_busy_nav =3D new_cca_busy_nav - cca_db->cca_busy_nav;
+       u32 diff_cca_intra_bss_nav =3D new_cca_intra_bss_nav - cca_db->cca_=
intra_bss_nav;
+       u32 diff_cca_inter_bss_nav =3D new_cca_inter_bss_nav - cca_db->cca_=
inter_bss_nav;
+
+       u32 percent_cca_busy_nav =3D TO_PERCENT(diff_cca_busy_nav, time);
+       u32 percent_cca_intra_bss_nav =3D TO_PERCENT(diff_cca_intra_bss_nav=
, time);
+       u32 percent_cca_inter_bss_nav =3D TO_PERCENT(diff_cca_inter_bss_nav=
, time);
+
+       cca_db->cca_busy_nav =3D new_cca_busy_nav;
+       cca_db->cca_intra_bss_nav =3D new_cca_intra_bss_nav;
+       cca_db->cca_inter_bss_nav =3D new_cca_inter_bss_nav;
+
+       pr_debug("cca_busy_nav =3D %u%%, cca_intra_bass_nav =3D %u%%, cca_i=
nter_bass_nav =3D %u%%\n",
+                percent_cca_busy_nav, percent_cca_intra_bss_nav, percent_c=
ca_inter_bss_nav);
+}
+
+static int cl_cca_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "cca usage:\n"
+                "-a : Print TX mine and RX mine [0-dis, 1-en]\n"
+                "-b : Print energy detect registers per20 [0-dis, 1-en]\n"
+                "-c : Print EDCA registers [0-dis, 1-en]\n"
+                "-d : Enable/Disable CCA statistics - [0-dis, 0xff-en all]=
\n"
+                "-e : Print energy detect registers [0-dis, 1-en]\n"
+                "-g : Print mid-packet registers [0-dis, 1-en]\n"
+                "-h : Print histogram [0-reset, 1-print]\n"
+                "-i : Print NAV busy registers [0-dis, 1-en]\n"
+                "-m : Print modem-state registers [0-dis, 1-en]\n"
+                "-n : Set modem-state registers [0-before L-SIG, 1-after L=
-SIG]\n"
+                "-r : Record histogram [samples #]\n"
+                "-s : Print carrier-sense register [0-dis, 1-en]\n"
+                "-u : Print CCA utility [0-dis, 1-en]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static bool cl_cca_is_hist_empty(struct cl_edca_hist_db *hist_db, u8 cnt)
+{
+       if (!hist_db->air_util[cnt] &&
+           !hist_db->mine[cnt] &&
+           !hist_db->non_wifi_util[cnt] &&
+           !hist_db->not_mine[cnt] &&
+           !hist_db->not_mine_busy[cnt] &&
+           !hist_db->not_mine_rx_wifi[cnt] &&
+           !hist_db->wifi_air_util[cnt])
+               return true;
+
+       return false;
+}
+
+static void cl_cca_print_histogram(struct cl_hw *cl_hw)
+{
+       struct cl_edca_hist_db *hist_db =3D &cl_hw->cca_db.edca_hist;
+       u8 i =3D 0;
+       u8 range =3D 1;
+
+       pr_debug("|--------------------------------------------------------=
-------|\n");
+       pr_debug("|Samples|AirUtil|WifiAir|NonWifi|Mine   |NotMine|NotMine|=
NotMine|\n");
+       pr_debug("|       |       |Util   |Util   |       |       |Busy   |=
RxWifi |\n");
+       pr_debug("|-------+-------+-------+-------+-------+-------+-------+=
-------|\n");
+
+       for (i =3D 0; i < CCA_MAX_SAMPLE; i++) {
+               if (cl_cca_is_hist_empty(hist_db, i))
+                       continue;
+
+               if (i > 1)
+                       range =3D ((i - 1) * SAMPLE_RES) + 1;
+
+               if (i !=3D 0)
+                       pr_debug("|%3u-%-3u| %5u | %5u | %5u | %5u | %5u | =
%5u | %5u |\n",
+                                range, range + SAMPLE_RES - 1, hist_db->ai=
r_util[i],
+                                hist_db->wifi_air_util[i], hist_db->non_wi=
fi_util[i],
+                                hist_db->mine[i], hist_db->not_mine[i],
+                                hist_db->not_mine_busy[i], hist_db->not_mi=
ne_rx_wifi[i]);
+               else
+                       pr_debug("|0      | %5u | %5u | %5u | %5u | %5u | %=
5u | %5u |\n",
+                                hist_db->air_util[i], hist_db->wifi_air_ut=
il[i],
+                                hist_db->non_wifi_util[i], hist_db->mine[i=
],
+                                hist_db->not_mine[i], hist_db->not_mine_bu=
sy[i],
+                                hist_db->not_mine_rx_wifi[i]);
+       }
+
+       pr_debug("|--------------------------------------------------------=
-------|\n");
+}
+
+static void cl_cca_opt_update(struct cl_hw *cl_hw, u32 cca_opt_prev)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+       u32 cca_opt_new =3D cca_db->cca_opt;
+
+       if (cca_opt_prev =3D=3D 0 && cca_opt_new !=3D 0) {
+               cca_db->time =3D jiffies_to_usecs(jiffies);
+               riu_rwnxagccca_1_cca_cnt_clear_setf(cl_hw, 0);
+       }
+
+       if (((cca_opt_prev & CCA_OPT_TX_RX_MINE) !=3D CCA_OPT_TX_RX_MINE) &=
&
+           (cca_opt_new & CCA_OPT_TX_RX_MINE)) {
+               cca_db->print_tx_mine =3D mac_hw_tx_mine_busy_get(cl_hw);
+               cca_db->print_rx_mine =3D mac_hw_rx_mine_busy_get(cl_hw);
+       }
+
+       if (((cca_opt_prev & CCA_OPT_UTIL) !=3D CCA_OPT_UTIL) &&
+           (cca_opt_new & CCA_OPT_UTIL)) {
+               cca_db->tx_mine =3D mac_hw_tx_mine_busy_get(cl_hw);
+               cca_db->rx_mine =3D mac_hw_rx_mine_busy_get(cl_hw);
+               cca_db->edca_busy =3D mac_hw_edca_cca_busy_get(cl_hw);
+       }
+}
+
+int cl_cca_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+       u32 cca_opt_prev =3D cca_db->cca_opt;
+       u32 expected_params =3D -1;
+       u32 param =3D (u32)cli_params->params[0];
+       bool print_tx_rx_mine =3D false;
+       bool print_energy_band =3D false;
+       bool print_edca =3D false;
+       bool print_all =3D false;
+       bool print_energy =3D false;
+       bool print_mp =3D false;
+       bool print_histogram =3D false;
+       bool print_nav_edca =3D false;
+       bool print_mdm =3D false;
+       bool set_mdm =3D false;
+       bool record_histogram =3D false;
+       bool print_cs =3D false;
+       bool print_util =3D false;
+
+       switch (cli_params->option) {
+       case 'a':
+               print_tx_rx_mine =3D true;
+               expected_params =3D 1;
+               break;
+       case 'b':
+               print_energy_band =3D true;
+               expected_params =3D 1;
+               break;
+       case 'c':
+               print_edca =3D true;
+               expected_params =3D 1;
+               break;
+       case 'd':
+               print_all =3D true;
+               expected_params =3D 1;
+               break;
+       case 'e':
+               print_energy =3D true;
+               expected_params =3D 1;
+               break;
+       case 'g':
+               print_mp =3D true;
+               expected_params =3D 1;
+               break;
+       case 'h':
+               print_histogram =3D true;
+               expected_params =3D 1;
+               break;
+       case 'i':
+               print_nav_edca =3D true;
+               expected_params =3D 1;
+               break;
+       case 'm':
+               print_mdm =3D true;
+               expected_params =3D 1;
+               break;
+       case 'n':
+               set_mdm =3D true;
+               expected_params =3D 1;
+               break;
+       case 'r':
+               record_histogram =3D true;
+               expected_params =3D 1;
+               break;
+       case 's':
+               print_cs =3D true;
+               expected_params =3D 1;
+               break;
+       case 'u':
+               print_util =3D true;
+               expected_params =3D 1;
+               break;
+       case '?':
+               return cl_cca_cli_help(cl_hw);
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
+       if (print_tx_rx_mine)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_TX_RX_MINE);
+
+       if (print_energy_band)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_CNT_ENERGY_BAND=
);
+
+       if (print_all)
+               cca_db->cca_opt =3D param;
+
+       if (print_edca)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_EDCA);
+
+       if (print_energy)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_CNT_ENERGY);
+
+       if (print_mp)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_CNT_MP);
+
+       if (print_histogram) {
+               if (param)
+                       cl_cca_print_histogram(cl_hw);
+               else
+                       memset(&cca_db->edca_hist, 0, sizeof(struct cl_edca=
_hist_db));
+
+               return 0;
+       }
+
+       if (print_nav_edca)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_EDCA_NAV);
+
+       if (print_mdm)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_CNT_MDM_STATE);
+
+       if (set_mdm) {
+               u16 psel =3D param ? MDM_AFTER_L_SIG : MDM_BEFORE_L_SIG;
+
+               pr_debug("Modem state register set to : %s L-SIG detection!=
\n",
+                        param ? "after" : "before");
+               riu_rwnxagcccastate_0_rxstatecca_20_psel_setf(cl_hw, psel);
+
+               return 0;
+       }
+
+       if (record_histogram) {
+               pr_debug("%s recording samples\n", param ? "Start" : "Stop"=
);
+               cca_db->edca_hist.sample_cnt =3D param;
+               SET_CCA_OPT(!!param, cca_db->cca_opt, CCA_OPT_REC_HIST);
+       }
+
+       if (print_cs)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_CNT_CS);
+
+       if (print_util)
+               SET_CCA_OPT(param, cca_db->cca_opt, CCA_OPT_UTIL);
+
+       cl_cca_opt_update(cl_hw, cca_opt_prev);
+       return 0;
+
+out_err:
+       return -EIO;
+}
+
+void cl_cca_maintenance(struct cl_hw *cl_hw)
+{
+       struct cl_cca_db *cca_db =3D &cl_hw->cca_db;
+       unsigned long time =3D jiffies_to_usecs(jiffies);
+       unsigned long diff_time =3D time - cca_db->time;
+       u32 cca_opt =3D cca_db->cca_opt;
+
+       cca_db->time =3D time;
+
+       if (!diff_time || !cca_opt)
+               return;
+
+       if (cca_opt & CCA_OPT_CNT_CS)
+               cl_cca_print_cs(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_CNT_MDM_STATE)
+               cl_cca_print_mdm_state(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_CNT_MP)
+               cl_cca_print_mp(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_CNT_ENERGY)
+               cl_cca_print_energy(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_CNT_ENERGY_BAND)
+               cl_cca_print_energy_band(cl_hw, diff_time);
+
+       if (cca_opt & (CCA_OPT_UTIL | CCA_OPT_REC_HIST))
+               cl_cca_print_utility(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_TX_RX_MINE)
+               cl_cca_print_tx_rx_mine(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_EDCA)
+               cl_cca_edca(cl_hw, diff_time);
+
+       if (cca_opt & CCA_OPT_EDCA_NAV)
+               cl_cca_print_edca_nav(cl_hw, diff_time);
+
+       /* Rest CCA counters */
+       riu_rwnxagccca_1_cca_cnt_clear_setf(cl_hw, 0);
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

