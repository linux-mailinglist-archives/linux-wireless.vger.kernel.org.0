Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185183AB827
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbhFQQFR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:17 -0400
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:6177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233546AbhFQQFC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3gfzycg9/U/0JdtUEsjOgjzAZimr43yTaLVQMde2gg4eyJQVk9TO4uLiOeqwAtythfkJKWzo4aFAP0MPiB10xE/TtFWXwIhX0g3CaETppTbGozhXRh33WkUxIyIw4mv0Q+G0LMoAJE6U1+lMPn/NWJwHn74A/2KGuz/7Eb6yejz2rPQ052n0yiUkE48ulSoYtI5N6c9/fHPgF/Up+WG5lcVsRW+r2U2npR2ONHcS3AEqheSocIH3YXJYPE/fz0OhMF5SLnfWSswtoichxC88F/9L2PHflX7d9csKBa6EY3Riag9uRSsaMRAdPwVK4ZZRGOlRLAygIJDF3xrLm+lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnLmLS9HfWUOtVIPJkWBKY2tHYqc8NwXY4uOFNUp9QE=;
 b=ioOV/BwtRVW6qK3NIytC9D2gco8FFYgLhwjbOu6xRfH6gyVmaS/TbKaSBuKXQd/Hp8hG8xrOy2M5IEm2l+kfwyMpBZU7v4Ws7YRmWVGdV4tWsEDD6K+XP1HBLlIYSYzZRLNi2kFBktssKtr3C3I/7sJGpEVq/cqieZBOsHjMtfUsap5lpvemJZ7ZYN5ESPRbgVmEB2TqiojYGO10ZT5cjR21PEldJFVYL69lY4g+mN41cou6CE+KAICkn9Q0WNrVbMEnby/kgoVxr9nzOftIiuExJ2Uy2RsGlX0rrMkQRlyzzIHbqGDD8cFn3NEcHHMEj7CUE/dAHzC08cI4z1g1wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnLmLS9HfWUOtVIPJkWBKY2tHYqc8NwXY4uOFNUp9QE=;
 b=lME1LDGE45tNpLE/+0e/pDbN1f0S8hqKzseO3sdMJ6u9zHlj8Fc0q9Xs/VlO06rFsNsFC2DnWvnTcvUjR56fWUQnznENtp3c93cnBR/WjK+IWmxqsJYFu+zTsqLsCba5tsqZPo/8rFzBpjRF5Wn/ki7qwtY2QaJNDWGDCGYfQUk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:02:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:02:46 +0000
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
Subject: [RFC v1 011/256] cl8k: add ate.c
Date:   Thu, 17 Jun 2021 15:58:18 +0000
Message-Id: <20210617160223.160998-12-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:02:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a4e4892-fc5a-4088-673d-08d931a958cd
X-MS-TrafficTypeDiagnostic: AM9P192MB1412:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB141264695DBE87425D268557F60E9@AM9P192MB1412.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TCPDCaVzup+k+bm6enxjVbJU/qvrT3u6HEIkCtHCeh9al9+DGetwKYLuFLehXjUsxpa/7QC5WvswnhPUJue3H5Fo/uKZSgxTCwwaCiy7xMMYj69VPkESxVJYXMiEwfz12DTJ0L1blcSjcnFapwNm8KLCUJJSyEfqsxBlpfDM5JdP5xtClQsowvxKFPYJbxmrCcUGbzcnOuyxbxn6FeXGJsqlC/PHy0M0EY2tPgq3k8m6I/zw2mZH8jJE5+wGh8xr2coO7dbpbnn+zW4r98DnPLRg1UOH3hR5Q4HxZZpZ9YSV6OqNZjS2Y7YdMBCIPQVN3k284v3DxoAy5WHZh6XFe8UQ5DBWFiYVSNAF66aAvvLDp9arLj411kkoddiAWdaGdWMX9bwygzIkxMNR4W15JxCQbmjPONCqzS2EH1sjJmoJ3W2EM7swzRnBnGwCBOlj30qwkNQVqfPLmMi+yOVxA7ljPP9dkl/bUPaZvpaYCwLCWN8USIPoy1shzkcAwPyYLCqWld3iE+G6zJi3CiW2IpYHLYLAti4RuxYb6kVz7IgEYqDup9VlYx62LD8LkpTHFhzeIiMRWXRhrUdfsRLDLECfBf1t0JcF02dAEVxVeewin6XhjDsiI8Q2261Z7ORaBuL91NeEfvTDJ39GXhgrVsCJkvLrjoJb75NJ02iJEYCD44uuffzI3qFjoWLlgxku1AlOePIbB/DAhPoHs9yJvA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(366004)(136003)(376002)(39840400004)(396003)(38350700002)(9686003)(16526019)(38100700002)(6512007)(478600001)(36756003)(6506007)(52116002)(55236004)(6486002)(186003)(66556008)(2906002)(8936002)(2616005)(26005)(66946007)(956004)(66476007)(86362001)(83380400001)(107886003)(5660300002)(1076003)(6666004)(4326008)(316002)(8676002)(30864003)(6916009)(54906003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mztQ38tQqSJq75wZWCggqP/PugQ6oTALHkb14aJwk+8bfvdj9R3SIPdw/Iff?=
 =?us-ascii?Q?ICGnHOgSsV4ogl/Rjr45ib4S38njjtNQaM/r14gtzJ1x41mNN8Mhn49Yf0yw?=
 =?us-ascii?Q?4U0FfM5td+y+jeXYFSK3e1TdacAauQiNGcrodgXR3UvOOifi51vIe4WGbNeC?=
 =?us-ascii?Q?kzNapUjuwQuIU4SzzxE4O1CttW3nipsvl0zTSIKnxZaL00QTzqvT8UWivqX6?=
 =?us-ascii?Q?qWyOnqnzEyaLcU2Rohe3Baoxy2v0y3oLZ8ot8bNPKgfITvcoD+e+n8rPG+rz?=
 =?us-ascii?Q?OacPwpkxRGNh91bMq5ntp9k1QdBNQBtG+oKvC3eu0/t09GL82nbIdUSmUYN0?=
 =?us-ascii?Q?PkCvItA5fPhGNI8wnpBJjg+PLKwOhTgoe9kAujY1wCoDUmPrPJa7xcKGuPUH?=
 =?us-ascii?Q?o1O6dQI5y8g36qsflzXHe3FG5BYNi/L3t3SYXv0KtkJ+2a8eCsOnyS2CmjSO?=
 =?us-ascii?Q?SiNESruZI4/Or64M0YRf214SAJX9dmU7bfz6cj16aQkt2T+FAhkzTT8xAtUB?=
 =?us-ascii?Q?L/kwPOjXjPF/WvJY6o7lLG/yvL0BjSMfn24eNJC8eMHBAp4ra//958wzGCqc?=
 =?us-ascii?Q?S8nFfdt+1BR7xnM24j7tBC2BI2GGot5qPDBa64Wv5t4VLw+vXAro/53ZT1E8?=
 =?us-ascii?Q?i7zramUK45f9OsAypKooMQjWxQraorXm/qerVmcAHy4b3GsTyaB8lKQpwkox?=
 =?us-ascii?Q?WttNzOdCO0yCgIozbB3nbCi6DtZvxsn+BBELpgQsz9dmnvr7qTItln5eT9Y8?=
 =?us-ascii?Q?n9rZulgTPHwdnksVSjTN4laL7vexIXuUR+x4tpMEow0cRlVJ/Ac1vDUGR+hg?=
 =?us-ascii?Q?U6LcyxfQBnqh/+CP/xk85QqGQ1asRZAoDuhcb97oa2cwYTI4ovKsTTWWPbB2?=
 =?us-ascii?Q?fEt4UjiLCeYUCZtYzuTFFCPUjmV3ea5vcQ7RJ0V0oUPCcQ7aWN+Trxg/dxQQ?=
 =?us-ascii?Q?orDaD9sfuAfY99YDLllAe9twFhIjmBBzollaefFkKBC99z212w/2Bau5DQIz?=
 =?us-ascii?Q?VH7AVOLRYAXBhhbWDoOjGTpFn4dhuDX/2Zy1U1t/tl4/6ANTRCQdMDyuVdms?=
 =?us-ascii?Q?aA3mAT5gIlhqtIqzxJSvzIRO/TbuWhvAdFXI5RuV1aCltWDRYsyzV71scOae?=
 =?us-ascii?Q?ojMZAVBerKybl48XlFIU0PU+CWDcKYH8DOSvoxEwbCgtJ+6xMi6jtIuxthXW?=
 =?us-ascii?Q?sSa2VizzeM1mvA1NyrGJzyVzCjZYjQpSC6GwK8PV3hZU3gzyIjKcuTL7vZdU?=
 =?us-ascii?Q?Ydse4epgbWcbQD9KlluF24xr5HQ98M5K/h4WMMz8HPSgfMTl224wX67lII59?=
 =?us-ascii?Q?zKsJ5IIO9mDfbizo6XetvvJD?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4e4892-fc5a-4088-673d-08d931a958cd
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:02:46.1314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPBMBbSV3zWtaalOVmgUqjZ8ZyfkvT+cmMhgwCS8hnupb4yO90O+wCoYK55/SLZVpXriomZVATPT7HYL9C1BcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1412
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/ate.c | 841 +++++++++++++++++++++++++
 1 file changed, 841 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/ate.c

diff --git a/drivers/net/wireless/celeno/cl8k/ate.c b/drivers/net/wireless/=
celeno/cl8k/ate.c
new file mode 100644
index 000000000000..95e4e73cd9c0
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/ate.c
@@ -0,0 +1,841 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "ate.h"
+#include "tx/tx_inject.h"
+#include "calib.h"
+#include "rate_ctrl.h"
+#include "fw/msg_tx.h"
+#include "mib.h"
+#include "edca.h"
+#include "reg/reg_mac_hw.h"
+#include "reg/reg_macdsp_api.h"
+#include "reg/reg_riu.h"
+#include "tx/tx_queue.h"
+#include "utils/utils.h"
+#include "band.h"
+#include "fem.h"
+#include "chandef.h"
+#include "mac_addr.h"
+#include "power.h"
+#include "e2p.h"
+
+#define DIFF(_diff, _new, _old, _member)\
+       ((_diff)._member =3D (_new)._member - (_old)._member)
+
+/* Max freq delta is 100MHz in Q2 */
+#define MAX_FREQ_DELTA (100 << 2)
+
+static void set_fixed_rate(struct cl_hw *cl_hw)
+{
+       struct cl_ate_db *ate_db =3D &cl_hw->ate_db;
+       union cl_rate_ctrl_info_he rate_ctrl_he =3D {.word =3D 0};
+       u8 ltf =3D 0;
+
+       if (ate_db->mode =3D=3D WRS_MODE_HE) {
+               rate_ctrl_he.field.spatial_conf =3D RATE_CNTRL_HE_SPATIAL_C=
ONF_DEF;
+
+               if (ate_db->ltf =3D=3D LTF_MAX)
+                       ltf =3D cl_map_gi_to_ltf(WRS_MODE_HE, ate_db->gi);
+               else
+                       ltf =3D ate_db->ltf;
+       }
+
+       cl_hw->entry_fixed_rate =3D true;
+
+       cl_rate_ctrl_set_fixed(cl_hw, rate_ctrl_he.word, ate_db->mode, ate_=
db->mcs,
+                              ate_db->nss, ate_db->bw, ate_db->gi, ltf);
+}
+
+static inline void read_stat(struct cl_hw *cl_hw, struct ate_stats *stats)
+{
+       stats->tx_bw20 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_20MHZ_FRAME_TR=
ANSMITTED_COUNT);
+       stats->tx_bw40 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_40MHZ_FRAME_TR=
ANSMITTED_COUNT);
+       stats->tx_bw80 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_80MHZ_FRAME_TR=
ANSMITTED_COUNT);
+       stats->tx_bw160 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_160MHZ_FRAME_=
TRANSMITTED_COUNT);
+       stats->rx_bw20 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_20MHZ_FRAME_RE=
CEIVED_COUNT);
+       stats->rx_bw40 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_40MHZ_FRAME_RE=
CEIVED_COUNT);
+       stats->rx_bw80 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_80MHZ_FRAME_RE=
CEIVED_COUNT);
+       stats->rx_bw160 =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_160MHZ_FRAME_=
RECEIVED_COUNT);
+       stats->fcs_err =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_FCS_ERROR_COUN=
T);
+       stats->phy_err =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_RX_PHY_ERROR_C=
OUNT);
+       stats->delimiter_err =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_AMPDU_DE=
LIMITER_CRC_ERROR_COUNT);
+}
+
+static bool is_valid_rate_he(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs, u=
8 gi)
+{
+       u8 ltf =3D cl_hw->ate_db.ltf;
+
+       /* BW */
+       if (!cl_hw->conf->ce_txldpc_en) {
+               if (bw > CHNL_BW_20) {
+                       u8 bw_mhz =3D BW_TO_MHZ(bw);
+
+                       cl_dbg_err(cl_hw, "Invalid bw [%u] - must be 20 whe=
n tx ldpc disabled\n",
+                                  bw_mhz);
+                       return false;
+               }
+       }
+
+       /* NSS */
+       if (nss >=3D cl_hw->conf->ce_tx_nss) {
+               cl_dbg_err(cl_hw, "Invalid nss [%u] - must be < %u\n",
+                          nss, cl_hw->conf->ce_tx_nss);
+               return false;
+       }
+
+       /* MCS */
+       if (cl_hw->conf->ce_txldpc_en) {
+               if (mcs >=3D WRS_MCS_MAX_HE) {
+                       cl_dbg_err(cl_hw, "Invalid mcs [%u] - must be 0 - 1=
1\n", mcs);
+                       return false;
+               }
+       } else {
+               if (mcs >=3D WRS_MCS_10) {
+                       cl_dbg_err(cl_hw, "Invalid mcs [%u] - must be 0-9 w=
hen tx ldpc disabled\n",
+                                  mcs);
+                       return false;
+               }
+       }
+
+       /* GI */
+       if (gi >=3D WRS_GI_MAX_HE) {
+               cl_dbg_err(cl_hw, "Invalid gi [%u] - must be 0(0.8u)/1(1.6u=
)/2(3.2u)\n", gi);
+               return false;
+       }
+
+       /* LTF */
+       if (ltf > LTF_MAX) {
+               cl_dbg_err(cl_hw, "Invalid ltf [%u] - must be 0(X1)/1(X2)/2=
(X4)\n", ltf);
+               return -EINVAL;
+       } else if (ltf < LTF_MAX) {
+               /*
+                * Supported GI/LTF combinations:
+                * GI =3D 3.2: LTF_X4
+                * GI =3D 1.6: LTF_X2
+                * GI =3D 0.8: LTF_X1, LTF_X2, LTF_X4
+                */
+               if (gi =3D=3D WRS_GI_LONG) {
+                       if (ltf !=3D LTF_X4) {
+                               cl_dbg_err(cl_hw, "ltf must be 2 (=3DX4) fo=
r gi=3D0\n");
+                               return false;
+                       }
+               } else if (gi =3D=3D WRS_GI_SHORT) {
+                       if (ltf !=3D LTF_X2) {
+                               cl_dbg_err(cl_hw, "ltf must be 1 (=3DX2) fo=
r gi=3D1\n");
+                               return false;
+                       }
+               }
+       }
+
+       return true;
+}
+
+static bool is_valid_rate_vht(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs, =
u8 gi)
+{
+       /* BW */
+       if (bw =3D=3D CHNL_BW_160 && nss >=3D WRS_SS_3) {
+               cl_dbg_err(cl_hw, "bw 160 is invalid in 3/4 nss\n");
+               return false;
+       }
+
+       /* NSS */
+       if (nss >=3D cl_hw->conf->ce_tx_nss) {
+               cl_dbg_err(cl_hw, "Invalid nss [%u] - must be < %u\n",
+                          nss, cl_hw->conf->ce_tx_nss);
+               return false;
+       }
+
+       /* MCS */
+       if (mcs >=3D WRS_MCS_MAX_VHT) {
+               cl_dbg_err(cl_hw, "Invalid mcs [%u] - must be 0-9\n", mcs);
+               return false;
+       }
+
+       /* GI */
+       if (gi >=3D WRS_GI_MAX_VHT) {
+               cl_dbg_err(cl_hw, "Invalid gi [%u] - must be 0(0.8u)/1(0.4u=
)\n", gi);
+               return false;
+       }
+
+       /* Make sure it is not an invalid VHT rate */
+       if (bw =3D=3D CHNL_BW_20 && mcs =3D=3D WRS_MCS_9)
+               if (nss =3D=3D WRS_SS_1 || nss =3D=3D WRS_SS_2 || nss =3D=
=3D WRS_SS_4) {
+                       cl_dbg_err(cl_hw, "nss 1/2/4 are invalid in bw 20, =
mcs 9\n");
+                       return false;
+               }
+
+       if (bw =3D=3D CHNL_BW_80 && mcs =3D=3D WRS_MCS_6 && nss =3D=3D WRS_=
SS_3) {
+               cl_dbg_err(cl_hw, "bw 80, mcs 6, nss 3 is invalid\n");
+               return false;
+       }
+
+       return true;
+}
+
+static bool is_valid_rate_ht(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs, u=
8 gi)
+{
+       /* BW */
+       if (bw > CHNL_BW_40) {
+               u8 bw_mhz =3D BW_TO_MHZ(bw);
+
+               cl_dbg_err(cl_hw, "Invalid bw [%u] - must be 20/40\n", bw_m=
hz);
+               return false;
+       }
+
+       /* NSS */
+       if (nss >=3D cl_hw->conf->ce_tx_nss) {
+               cl_dbg_err(cl_hw, "Invalid nss [%u] - must be < %u\n",
+                          nss, cl_hw->conf->ce_tx_nss);
+               return false;
+       }
+
+       /* MCS */
+       if (mcs >=3D WRS_MCS_MAX_HT) {
+               cl_dbg_err(cl_hw, "Invalid mcs [%u] - must be 0 - 7\n", mcs=
);
+               return false;
+       }
+
+       /* GI */
+       if (gi >=3D WRS_GI_MAX_HT) {
+               cl_dbg_err(cl_hw, "Invalid gi [%u] - must be 0(0.8u)/1(0.4u=
)\n", gi);
+               return false;
+       }
+
+       return true;
+}
+
+static bool is_valid_rate_ofdm(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs,=
 u8 gi)
+{
+       /*
+        * BW
+        * There is no need to check if bw is valid.
+        * It was already done in is_valid_bw_mhz().
+        * For ofdm we allow bw to be > 20, for FORMAT_NON_HT_DUP.
+        */
+
+       /* NSS */
+       if (nss !=3D 0) {
+               cl_dbg_err(cl_hw, "Invalid  nss [%u] - must be 0\n", nss);
+               return false;
+       }
+
+       /* MCS */
+       if (mcs >=3D WRS_MCS_MAX_OFDM) {
+               cl_dbg_err(cl_hw, "Invalid  mcs [%u] - must be 0 - 7\n", mc=
s);
+               return false;
+       }
+
+       /* GI */
+       if (gi !=3D 0) {
+               cl_dbg_err(cl_hw, "Invalid  gi [%u] - nust be 0\n", gi);
+               return false;
+       }
+
+       return true;
+}
+
+static bool is_valid_rate_cck(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs, =
u8 gi)
+{
+       /* BW */
+       if (bw > CHNL_BW_20) {
+               u8 bw_mhz =3D BW_TO_MHZ(bw);
+
+               cl_dbg_err(cl_hw, "Invalid bw [%u] - must be 20\n", bw_mhz)=
;
+               return false;
+       }
+
+       /* NSS */
+       if (nss !=3D 0) {
+               cl_dbg_err(cl_hw, "Invalid nss [%u] - must be 0\n", nss);
+               return false;
+       }
+
+       /* MCS */
+       if (mcs >=3D WRS_MCS_MAX_CCK) {
+               cl_dbg_err(cl_hw, "Invalid mcs [%u] - must be 0 - 3\n", mcs=
);
+               return false;
+       }
+
+       /* GI */
+       if (gi !=3D 0) {
+               cl_dbg_err(cl_hw, "Invalid gi [%u] - nust be 0\n", gi);
+               return false;
+       }
+
+       return true;
+}
+
+static bool is_valid_rate(struct cl_hw *cl_hw)
+{
+       u8 mode =3D cl_hw->ate_db.mode;
+       u8 bw =3D cl_hw->ate_db.bw;
+       u8 nss =3D cl_hw->ate_db.nss;
+       u8 mcs =3D cl_hw->ate_db.mcs;
+       u8 gi =3D cl_hw->ate_db.gi;
+
+       switch (mode) {
+       case WRS_MODE_HE:
+               return is_valid_rate_he(cl_hw, bw, nss, mcs, gi);
+       case WRS_MODE_VHT:
+               return is_valid_rate_vht(cl_hw, bw, nss, mcs, gi);
+       case WRS_MODE_HT:
+               return is_valid_rate_ht(cl_hw, bw, nss, mcs, gi);
+       case WRS_MODE_OFDM:
+               return is_valid_rate_ofdm(cl_hw, bw, nss, mcs, gi);
+       case WRS_MODE_CCK:
+               return is_valid_rate_cck(cl_hw, bw, nss, mcs, gi);
+       default:
+               cl_dbg_err(cl_hw,
+                          "Invalid mode [%u] - must be: 0(cck)/1(ofdm)/2(h=
t)/3(vht)/4(he)\n",
+                          mode);
+               break;
+       }
+
+       return false;
+}
+
+static bool is_valid_bw(struct cl_hw *cl_hw)
+{
+       if (cl_hw->bw < cl_hw->ate_db.bw) {
+               cl_dbg_err(cl_hw, "TX bw [%u] can't be greater than channel=
 bw [%u]\n",
+                          BW_TO_MHZ(cl_hw->ate_db.bw), BW_TO_MHZ(cl_hw->bw=
));
+               return false;
+       }
+
+       return true;
+}
+
+static bool is_valid_bw_mhz(struct cl_hw *cl_hw, u8 bw_mhz)
+{
+       if (BAND_IS_5G_6G(cl_hw)) {
+               if (bw_mhz !=3D BW_TO_MHZ(CHNL_BW_20) &&
+                   bw_mhz !=3D BW_TO_MHZ(CHNL_BW_40) &&
+                   bw_mhz !=3D BW_TO_MHZ(CHNL_BW_80) &&
+                   bw_mhz !=3D BW_TO_MHZ(CHNL_BW_160)) {
+                       cl_dbg_err(cl_hw,
+                                  "Invalid bw [%u] - must be 20/40/80/160\=
n", bw_mhz);
+                       return false;
+               }
+       } else {
+               if (bw_mhz !=3D BW_TO_MHZ(CHNL_BW_20) &&
+                   bw_mhz !=3D BW_TO_MHZ(CHNL_BW_40)) {
+                       cl_dbg_err(cl_hw, "Invalid bw [%u] - must be 20/40\=
n", bw_mhz);
+                       return false;
+               }
+       }
+
+       return true;
+}
+
+int cl_ate_reset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       if (cl_tx_inject_is_running(cl_hw)) {
+               tasklet_kill(&cl_hw->tx_inject.tasklet);
+               cl_ate_stop(wiphy, NULL, NULL, 0);
+       }
+
+       /* Reset rate parameters */
+       cl_hw->ate_db.mode =3D 0;
+       cl_hw->ate_db.bw =3D 0;
+       cl_hw->ate_db.nss =3D 0;
+       cl_hw->ate_db.mcs =3D 0;
+       cl_hw->ate_db.gi =3D 0;
+       cl_hw->ate_db.ltf =3D LTF_MAX;
+
+       cl_hw->entry_fixed_rate =3D false;
+
+       /* Reset TX power */
+       cl_hw->ate_db.tx_power =3D S8_MAX;
+       memset(cl_hw->ate_db.tx_power_offset, S8_MAX, MAX_ANTENNAS);
+
+       cl_tx_inject_reset(cl_hw);
+
+       /* Go to ACTIVE state */
+       if (cl_hw->chip->conf->ce_production_mode)
+               cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE);
+
+       if (cl_hw->ate_db.ant_mask) {
+               u8 default_ant_mask =3D ANT_MASK(cl_hw->num_antennas);
+
+               cl_msg_tx_set_ant_bitmap(cl_hw, default_ant_mask);
+               cl_hw->ate_db.ant_mask =3D 0;
+       }
+
+       cl_hw->ate_db.active =3D true;
+
+       /*
+        * Rearm last_tbtt_irq so that error message will
+        * not be printed in cl_irq_status_tbtt()
+        */
+       cl_hw->last_tbtt_irq =3D jiffies;
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return 0;
+}
+
+int cl_ate_mode(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->ate_db.mode =3D *(u8 *)data;
+
+       cl_dbg_trace(cl_hw, "mode =3D %u\n", cl_hw->ate_db.mode);
+
+       return 0;
+}
+
+int cl_ate_bw(struct wiphy *wiphy, struct wireless_dev *wdev,
+             const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u8 bw_mhz =3D *(u8 *)data;
+
+       if (!is_valid_bw_mhz(cl_hw, bw_mhz))
+               return -EINVAL;
+
+       cl_hw->ate_db.bw =3D MHZ_TO_BW(bw_mhz);
+
+       cl_dbg_trace(cl_hw, "bw =3D %u\n", bw_mhz);
+
+       return 0;
+}
+
+int cl_ate_mcs(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->ate_db.mcs =3D *(u8 *)data;
+
+       cl_dbg_trace(cl_hw, "mcs =3D %u\n", cl_hw->ate_db.mcs);
+
+       return 0;
+}
+
+int cl_ate_nss(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->ate_db.nss =3D *(u8 *)data;
+
+       cl_dbg_trace(cl_hw, "nss =3D %u\n", cl_hw->ate_db.nss);
+
+       return 0;
+}
+
+int cl_ate_gi(struct wiphy *wiphy, struct wireless_dev *wdev,
+             const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->ate_db.gi =3D *(u8 *)data;
+       cl_dbg_trace(cl_hw, "gi =3D %u\n", cl_hw->ate_db.gi);
+
+       return 0;
+}
+
+int cl_ate_ltf(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->ate_db.ltf =3D *(u8 *)data;
+
+       cl_dbg_trace(cl_hw, "ltf =3D %u\n", cl_hw->ate_db.ltf);
+
+       return 0;
+}
+
+int cl_ate_ldpc(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_hw->conf->ce_txldpc_en =3D (bool)(*(u8 *)data);
+
+       cl_dbg_trace(cl_hw, "ldpc =3D %u\n", cl_hw->conf->ce_txldpc_en);
+
+       return 0;
+}
+
+int cl_ate_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
+                  const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u32 channel =3D ((u32 *)data)[0];
+       u32 bw_mhz =3D ((u32 *)data)[1];
+       u32 bw =3D 0;
+       u32 primary =3D 0;
+       u32 center =3D 0;
+       enum nl80211_chan_width width =3D NL80211_CHAN_WIDTH_20;
+
+       if (!is_valid_bw_mhz(cl_hw, bw_mhz))
+               return -EINVAL;
+
+       if (cl_band_is_6g(cl_hw) && channel =3D=3D 2 &&
+           bw_mhz !=3D BW_TO_MHZ(CHNL_BW_20)) {
+               cl_dbg_err(cl_hw, "Only 20Mhz is allowed for channel 2\n");
+               return -EINVAL;
+       }
+
+       bw =3D MHZ_TO_BW(bw_mhz);
+
+       if (cl_chandef_calc(cl_hw, channel, bw, &width, &primary, &center))=
 {
+               cl_dbg_err(cl_hw, "cl_chandef_calc failed\n");
+               return -EINVAL;
+       }
+
+       if (cl_hw->set_calib) {
+               cl_hw->set_calib =3D false;
+               cl_calib_power_read(cl_hw);
+       }
+
+       cl_msg_tx_set_channel(cl_hw, channel, bw, primary, center);
+
+       return 0;
+}
+
+int cl_ate_ant(struct wiphy *wiphy, struct wireless_dev *wdev,
+              const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u8 ant =3D *(u8 *)data;
+       u8 mask;
+
+       if (ant >=3D MAX_ANTENNAS) {
+               cl_dbg_err(cl_hw, "Invalid antenna value [%u]", ant);
+               return -EINVAL;
+       }
+
+       mask =3D (1 << ant);
+
+       if (mask !=3D cl_hw->ate_db.ant_mask) {
+               cl_hw->ate_db.ant_mask =3D mask;
+               cl_msg_tx_set_ant_bitmap(cl_hw, mask);
+       }
+
+       cl_dbg_trace(cl_hw, "ant =3D %u, mask =3D 0x%x\n", ant, mask);
+
+       return 0;
+}
+
+#define FULL_ANT_MASK ((1 << MAX_ANTENNAS) - 1)
+
+int cl_ate_multi_ant(struct wiphy *wiphy, struct wireless_dev *wdev,
+                    const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u8 mask =3D *(u8 *)data;
+
+       if (mask =3D=3D 0 || mask > FULL_ANT_MASK) {
+               cl_dbg_err(cl_hw, "Invalid antenna bitmap [0x%x]", mask);
+               return -EINVAL;
+       }
+
+       if (mask !=3D cl_hw->ate_db.ant_mask) {
+               cl_hw->ate_db.ant_mask =3D mask;
+               cl_msg_tx_set_ant_bitmap(cl_hw, mask);
+       }
+
+       cl_dbg_trace(cl_hw, "mask =3D 0x%x\n", mask);
+
+       return 0;
+}
+
+int cl_ate_packet_len(struct wiphy *wiphy, struct wireless_dev *wdev,
+                     const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u32 packet_len =3D *(u32 *)data;
+
+       cl_dbg_trace(cl_hw, "packet_len =3D %u\n", packet_len);
+
+       return cl_tx_inject_set_length(cl_hw, packet_len);
+}
+
+int cl_ate_vector(struct wiphy *wiphy, struct wireless_dev *wdev,
+                 const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u32 size =3D data_len / sizeof(u32);
+       int ret =3D 0;
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       ret =3D cl_calib_pivot_channels_set(cl_hw, data, size);
+
+       /* Write EEPROM version when starting calibration process */
+       if (!ret)
+               return cl_e2p_write_version(cl_hw->chip);
+
+       return ret;
+}
+
+int cl_ate_vector_reset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                       const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return cl_calib_pivot_channels_reset(cl_hw);
+}
+
+#define FREQ_OFST_MAX  959
+
+int cl_ate_freq_offset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                      const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u16 freq_offset =3D *(u16 *)data;
+
+       if (freq_offset > FREQ_OFST_MAX) {
+               cl_dbg_err(cl_hw, "Invalid freq offset 0x%04x\n", freq_offs=
et);
+               return -1;
+       }
+
+       cl_dbg_trace(cl_hw, "Freq offset 0x%04x\n", freq_offset);
+
+       return cl_msg_tx_set_freq_offset(cl_hw, freq_offset);
+}
+
+int cl_ate_stat(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       struct ate_stats new_stats;
+       struct ate_stats ret_stats;
+
+       read_stat(cl_hw, &new_stats);
+
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, tx_bw20);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, tx_bw40);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, tx_bw80);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, tx_bw160);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, rx_bw20);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, rx_bw40);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, rx_bw80);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, rx_bw160);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, fcs_err);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, phy_err);
+       DIFF(ret_stats, new_stats, cl_hw->ate_db.stats, delimiter_err);
+
+       /* Present rx seccess of the defined bw */
+       switch (cl_hw->ate_db.bw) {
+       case CHNL_BW_20:
+               ret_stats.rx_success =3D ret_stats.rx_bw20;
+               break;
+       case CHNL_BW_40:
+               ret_stats.rx_success =3D ret_stats.rx_bw40;
+               break;
+       case CHNL_BW_80:
+               ret_stats.rx_success =3D ret_stats.rx_bw80;
+               break;
+       case CHNL_BW_160:
+               ret_stats.rx_success =3D ret_stats.rx_bw160;
+               break;
+       default:
+               /* Should not get here */
+               return -EINVAL;
+       }
+
+       /* Read rssi */
+       macdsp_api_inbdpow_20_unpack(cl_hw, &ret_stats.rssi3, &ret_stats.rs=
si2,
+                                    &ret_stats.rssi1, &ret_stats.rssi0);
+       ret_stats.rssi4 =3D S8_MIN;
+       ret_stats.rssi5 =3D S8_MIN;
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return cl_vendor_reply(cl_hw, &ret_stats, sizeof(struct ate_stats))=
;
+}
+
+int cl_ate_stat_reset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                     const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       read_stat(cl_hw, &cl_hw->ate_db.stats);
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return 0;
+}
+
+int cl_ate_power(struct wiphy *wiphy, struct wireless_dev *wdev,
+                const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       s8 tx_power =3D *(s8 *)data;
+       s8 tx_power_q1 =3D 0;
+
+       if (tx_power < POWER_MIN_DB || tx_power > POWER_MAX_DB) {
+               cl_dbg_err(cl_hw, "Invalid power (%d). Must be between %d a=
nd %d\n",
+                          tx_power, POWER_MIN_DB, POWER_MAX_DB);
+               return 0;
+       }
+
+       cl_hw->ate_db.tx_power =3D tx_power;
+       tx_power_q1 =3D tx_power << 1;
+
+       cl_dbg_trace(cl_hw, "ate_power =3D %u\n", tx_power);
+
+       memset(&cl_hw->phy_data_info.data->pwr_tables,
+              tx_power_q1, sizeof(struct cl_pwr_tables));
+
+       cl_msg_tx_refresh_power(cl_hw);
+
+       return 0;
+}
+
+int cl_ate_power_offset(struct wiphy *wiphy, struct wireless_dev *wdev,
+                       const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       s8 *pwr_offset =3D cl_hw->ate_db.tx_power_offset;
+       int i;
+
+       for (i =3D 0; i < MAX_ANTENNAS; i++) {
+               pwr_offset[i] =3D ((s8 *)data)[i];
+
+               if (pwr_offset[i] < POWER_OFFSET_MIN_Q2 ||
+                   pwr_offset[i] > POWER_OFFSET_MAX_Q2) {
+                       cl_dbg_err(cl_hw, "Invalid power offset (%d). Valid=
 range (%d - %d)\n",
+                                  pwr_offset[i], POWER_OFFSET_MIN_Q2, POWE=
R_OFFSET_MAX_Q2);
+                       memset(pwr_offset, S8_MAX, MAX_ANTENNAS);
+                       return -1;
+               }
+       }
+
+       cl_dbg_trace(cl_hw, "power_offset =3D %d,%d,%d,%d,%d,%d\n",
+                    pwr_offset[0], pwr_offset[1], pwr_offset[2],
+                    pwr_offset[3], pwr_offset[4], pwr_offset[5]);
+
+       return cl_msg_tx_set_ant_pwr_offset(cl_hw, pwr_offset);
+}
+
+int cl_ate_tx_start(struct wiphy *wiphy, struct wireless_dev *wdev,
+                   const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       u32 tx_cnt =3D *(u32 *)data;
+
+       if (!cl_hw->ate_db.active) {
+               cl_dbg_err(cl_hw, "Must call 'ATE reset' first.\n");
+               return -EPERM;
+       }
+
+       if (tx_cnt =3D=3D 0) {
+               cl_tx_inject_stop_traffic(cl_hw);
+               return 0;
+       }
+
+       if (cl_tx_inject_is_running(cl_hw)) {
+               cl_dbg_err(cl_hw, "TX already running.\n");
+               return -EPERM;
+       }
+
+       if (!is_valid_rate(cl_hw) || !is_valid_bw(cl_hw))
+               return -EPERM;
+
+       set_fixed_rate(cl_hw);
+       cl_tx_inject_start(cl_hw, tx_cnt);
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return 0;
+}
+
+int cl_ate_tx_continuous(struct wiphy *wiphy, struct wireless_dev *wdev,
+                        const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       if (!cl_hw->ate_db.active) {
+               cl_dbg_err(cl_hw, "Must call 'ATE reset' first.\n");
+               return -EPERM;
+       }
+
+       if (cl_tx_inject_is_running(cl_hw)) {
+               cl_dbg_err(cl_hw, "TX already running.\n");
+               return -EPERM;
+       }
+
+       if (!is_valid_rate(cl_hw) || !is_valid_bw(cl_hw))
+               return -EPERM;
+
+       set_fixed_rate(cl_hw);
+       cl_tx_inject_start_continuous(cl_hw);
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return 0;
+}
+
+int cl_ate_stop(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+
+       cl_tx_inject_stop(cl_hw);
+
+       /* Go back to IDLE state */
+       if (cl_hw->chip->conf->ce_production_mode)
+               cl_msg_tx_set_idle(cl_hw, MAC_IDLE_SYNC);
+
+       cl_hw->ate_db.active =3D false;
+
+       cl_dbg_trace(cl_hw, "\n");
+
+       return 0;
+}
+
+int cl_ate_help(struct wiphy *wiphy, struct wireless_dev *wdev,
+               const void *data, int data_len)
+{
+       struct cl_hw *cl_hw =3D WIPHY_TO_CL_HW(wiphy);
+       char *ret_buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!ret_buf)
+               return -ENOMEM;
+
+       snprintf(ret_buf, PAGE_SIZE,
+                "usage:\n"
+                "reset - Reset ATE configuration\n"
+                "mode <0=3DCCK,1=3DOFDM,2=3DHT,3=3DVHT,4=3DHE> - Set mode\=
n"
+                "bw <20/40/80/160> - Set TX bandwidth parameter\n"
+                "mcs <CCK=3D0-3, OFDM/HT=3D0-7, VHT=3D0-9, HE=3D0-11> - se=
t mcs parameter\n"
+                "nss <0-3> - set nss parameter\n"
+                "gi <CCK/OFDM=3D0, HT/VHT=3D0-1, HE=3D0-2> - set gi\n"
+                "ltf <HE-LTF: 0=3DLTF_X1,1=3DLTF_X2,2=3DLTF_X4> - set ltf\=
n"
+                "ldpc <0=3DDisable, 1=3DEnable> - set ldpc parameter\n"
+                "channel <ch number> <ch bw [20/40/80/160]> <Frequency del=
ta"
+                " from center Frequency (optional)> - change channel\n"
+                "ant <Antenna index 0-5> - Enable single antenna\n"
+                "multi_ant <Ant bitmap> - Enable multiple antennas\n"
+                "packet_len <packet length (16-4096)> - Set length of pack=
ets to inject\n"
+                "vector <Channel vector separated by space> - Set"
+                " vector of channels to calibrate\n"
+                "freq_offset <0-959> - Set frequency offset\n"
+                "stat <reset (optional)> - Display/Reset statistics\n"
+                "power <-10dB - 30dB> - Set tx power\n"
+                "power_offset <offset_ant1 ... offset_ant6> - Power"
+                " offset per anthenna [range +/-64][units=3D0.25dB]\n"
+                "tx_start <Num of packets> - Start TX packets\n"
+                "tx_continuous - Start transmitting infinite packets\n"
+                "stop - Stop transmission\n");
+
+       err =3D cl_vendor_reply(cl_hw, ret_buf, strlen(ret_buf));
+       kfree(ret_buf);
+
+       return err;
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

