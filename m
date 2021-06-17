Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF27C3AB91D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhFQQMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:48 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:34016
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231679AbhFQQLl (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeZYW+u1B9pSFOOeAqlh+4CNF13pl6kPJXqJVX8Hj+ofu35xmuRQ8J28fqIwODtrjwMOkngdc28vueFL4FU714vsvRHxPOI4vjktKXdStkQuk8xzLY8RZwCNNlsmuonPM67QSI3wHUva8WSKmnx+7msrbdPXhVNJ0ZcmpEvKCyljuWjXIv7weVxzsu6384tdEDwUUkKeAqzB/l/AVUrx+be4i7cBouLyWLFcDsCSG5NSgn4MQlB4ZSBvh8jsMIC2PbQB2zlPeyIJAHdXLCi3ky+5wo+oDhZdcME9+l4L9ahVMcu70IVgXyepM7fjcljISq2MgIfJBwPknTEGuLJJ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRfZOwK60+MCq8T91Q/iYXkLJVCgt7NaCgdXD0CW62A=;
 b=Yt7d95mWlIwvJSQgkmRRr4EF4dGHJ8bROHc5Jazt2S0pZ7aeeKSh5u9cUWaRJMoF6a55a6sL6Yhkb3QhYykuunyE0qNoh1vjS5FB4z5HU5eov3mmoTBVZbchCgl7lVXGMvzqcdT0JClfUGcYRf3mmy0958ndT97BNeIZhaKfYpuTFWnBXTh9VRx2GtJan0Tl7IyE8HXwcfa0qPuJZLorZBBZ5WOoisFQDPxH5cw8k1Kst1AANbLFMkPyqagd+e1AeACU0F2zlEgjFeUszlKpXJf8agPtQO3I5960x47nX4jhoGXwBt4424CBBwhfjqctstaTzChWNMXAzNjkdNZdnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRfZOwK60+MCq8T91Q/iYXkLJVCgt7NaCgdXD0CW62A=;
 b=SRsICqVmYGq+HBfQolUDp8QLXELfNIe7Mh2wA9QeWWC0Fz2kaYnv/bk487IPNNHa6+kKjJqBin7SVlg7mzn51PlOEXqBs5oTdxaippk0bvrHeQWmd0l6PVnueCkUr+zNISads2XWbMK1TsuEDkBhslViIUQW982U4nVWY3pEb8k=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0260.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Thu, 17 Jun
 2021 16:07:09 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:09 +0000
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
Subject: [RFC v1 184/256] cl8k: add stats.c
Date:   Thu, 17 Jun 2021 16:01:11 +0000
Message-Id: <20210617160223.160998-185-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0d3d35c-6ed1-45c7-fe07-08d931a9cb28
X-MS-TrafficTypeDiagnostic: AM0P192MB0260:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0260CA09D074A8CBCB2E9D21F60E9@AM0P192MB0260.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvH3CYKLen7bL6xhpwO99QOns/6stZvRleLapd6n+nGqxHjrwMaKTLfSOjpGDO4KmbYnebB2caBKMD6UnkHL3VM8xdseYWmTsSd39qIdz63EIwSmxVVR2rOBEeah3uYEn303tCVFkUVZ4GfPI46ee6dVKCWqyfdZW1reolW5Hsq6zuy7H18PyHG+pXgXi/g5kAd2Eglg3FKoyCj1RTiGrIbMHnIYgkekRgcO0uZeuag3c2eoXGoNxJiwau38dTro/3ZCiYWsQ9gWG8OnkdxDhqvoLZdm05/OATW/j4qs9I5IDt+JlIKSQD6CrqylfbxiqdyJEea0aCbJDsjLRy0XNQXL6j1pNtoswNOSiKdAEXIxbfpPpFm4h3loDzRhOQMpo11gGfCCpUkIrqTAKIIeSoqca1CpoWC8Cq9/MNMeqZUHm2kgCUm31uhfcaSFbI6aicL1S3AOX5bDzTIz/Gxb/8zPwFsuAFWTBqCwYhuyzMsVD5+qceLofztJnil2fpQgrGEB6FnNCNZLeN57W/BNyJvXxVokcAbO+J2Wbg2BR41e6KCvDc8vOXbfDl6Z0NkXFTeDrR8SgPh0SWOiINGRDNByhHAzSbFU6fgEOsaDJfwJpfUJJP/nC+gvow+js5MruT905VGR76UKSt4IT5XOUXPWYGJwl6YD4SopePz744PzYTZP7Lf4Gxtm+h0N2yy+yrpTaMwEYh7LF/DsgfxsPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(8936002)(86362001)(107886003)(4326008)(26005)(8676002)(956004)(45080400002)(186003)(6666004)(2906002)(6512007)(66556008)(2616005)(5660300002)(498600001)(38350700002)(54906003)(38100700002)(16526019)(66946007)(9686003)(83380400001)(55236004)(52116002)(66476007)(6486002)(6916009)(30864003)(6506007)(36756003)(1076003)(69590400013)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GU0hAL4BjVMp2Zye58Y7Ind17oyEhVsRfPpPwFQfXO/8BjvxBFv8Aj4beZHD?=
 =?us-ascii?Q?pAvzFbPM/8g9EsaBBxGh8BFMbttgzjNmOEi657ezvFvYJo+IYPtwEpNadv82?=
 =?us-ascii?Q?W+xGkeEW42YC7eAG2Lgu4d+0v8R7blApjAXwmEfYer9xchJF+So2s0p4VTEa?=
 =?us-ascii?Q?HRAEcBuWz1TwxE2ROQrV5bm1G9LCPlsueDhVfXIUtTbsdBhP3V+ePiqRfjA/?=
 =?us-ascii?Q?QSDGu6P04d02fOUnby+yYXpxDhLHM92f/9bCR4Umz0fJZgBPm+FzpK+iRW4p?=
 =?us-ascii?Q?B6ZZI8GkV/8+q01gajvf0w87GSBquuSPFmxB3P3iTrVTRtpRxXyZkKBIj/Wz?=
 =?us-ascii?Q?/jwJ7aLXPSTnAA7pftW0WBN3M8fmuWu6l+pSJkf+D/PVzKYSU9S30Szj+wsp?=
 =?us-ascii?Q?G6IF9xJrNuk0osAa4Vfas8Vgx2+Bb88xx8pi4jPICz5+vk+7tPXHwZx4Snnx?=
 =?us-ascii?Q?P7+wdOguibanw/CAia9IrND8IyTjJ0k8zkMo8HSU7rqpIpClvmzvqj46KZxR?=
 =?us-ascii?Q?PXodkLY+R7T8juLoXe/RQOwFX7kDsfUGw7apsdGjHTp31heJZF395CwjVh3q?=
 =?us-ascii?Q?xPJiZnxg5bHH20pfG7JsoUicojUBVq0tcwehOXfkl5njhLQ/9opg2at7DSIG?=
 =?us-ascii?Q?v9XWl87nXnZDsJWC177RN76PBxAtYU2nqRjy9j5cfCHS0rdQjxehauRu3sY5?=
 =?us-ascii?Q?H4ZskSqFY00saD3EKjWGZvzVVBSp7mdRktUztuNb9d/D82c+P2SLs+6oGw60?=
 =?us-ascii?Q?/UNotiwVjfpekm0Xs1TX1W98wWZ5/Cmp/OEF42iYFK1/ZVkFIC8Jq+2X1d4H?=
 =?us-ascii?Q?B2TjQJvo531U6xcmlJWqR3CkuryAuFaYQ+6y9A1E4X7zA8QOzAK3PKTCMFze?=
 =?us-ascii?Q?1i2SVbSdx12GmfW97Mw6p6VCtS3PZFuDi6SRTzOElBIoFeGhB14XPgNwviAD?=
 =?us-ascii?Q?Aypz31pTjs5O2mDvkZDPcPStw4SdL/Q6IftMipGQTyRFhviaLjrOQLQbBnpl?=
 =?us-ascii?Q?JN+nf0vK2i4wuf1M89gq06oi4X58RL4XBZIdFV/OD7qlO75LfgJjIrpsqAHJ?=
 =?us-ascii?Q?GBfxpOPZRpGPevpOqK+UjmcncnWafDiPnGmQi1mA6R8HmaTFWOAjM6e8gYfU?=
 =?us-ascii?Q?e15p95QpIcT+8bIcz0Njz/uc160yGkN25qR+IEwifpO29lXwOXdmWhl4+xuz?=
 =?us-ascii?Q?j+T/ec+XmQs1C2MEfC9D9f4pHqq9B6xhqCyT91DzpLCAjx55Jb9FrjV3xTVw?=
 =?us-ascii?Q?L5EWzt46AoX4HGYf/cYYb/XZLkrF/rS9nNa9VcDXe8+Su9JKSP/5H3AqGn2j?=
 =?us-ascii?Q?RHaHmIqgxid1qogEXpYTCTso?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d3d35c-6ed1-45c7-fe07-08d931a9cb28
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:58.0666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+dLlNyc7sxFriRht+g8CCHIb59wU7IULwkGtrMhAe7BrSk2Fr81EEtKjCyzxhq60HGA1pT8xljYq08S2LxKbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0260
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/stats.c | 1402 ++++++++++++++++++++++
 1 file changed, 1402 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.c

diff --git a/drivers/net/wireless/celeno/cl8k/stats.c b/drivers/net/wireles=
s/celeno/cl8k/stats.c
new file mode 100644
index 000000000000..f340f60ebab9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/stats.c
@@ -0,0 +1,1402 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/string.h>
+#include "stats.h"
+#include "rx/rx.h"
+#include "reg/reg_access.h"
+#include "sta.h"
+#include "band.h"
+#include "mib.h"
+#include "rate_ctrl.h"
+#include "vif.h"
+#include "data_rates.h"
+
+typedef void (*stats_callback)(struct cl_hw *, struct cl_sta *);
+
+static const char *bw_str[CHNL_BW_MAX_OFDMA] =3D {
+       [CHNL_BW_2_5] =3D "2.5",
+       [CHNL_BW_5] =3D "5",
+       [CHNL_BW_10] =3D "10",
+       [CHNL_BW_20] =3D "20",
+       [CHNL_BW_40] =3D "40",
+       [CHNL_BW_80] =3D "80",
+       [CHNL_BW_160] =3D "160"
+};
+
+static const char *gi_he_str[WRS_GI_MAX_HE] =3D {
+       [WRS_GI_LONG] =3D "3.2",
+       [WRS_GI_SHORT] =3D "1.6",
+       [WRS_GI_VSHORT] =3D "0.8"
+};
+
+static const char *gi_ht_vht_str[WRS_GI_MAX_HT] =3D {
+       [WRS_GI_LONG] =3D "0.8",
+       [WRS_GI_SHORT] =3D "0.4",
+};
+
+static void cl_stats_sta_reset(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_ps_stats *ps =3D &cl_sta->stats->ps;
+       bool is_ps =3D ps->is_ps;
+       unsigned long timestamp_sleep =3D ps->timestamp_sleep;
+
+       memset(cl_sta->stats, 0, sizeof(struct cl_stats));
+
+       /* Restore value of power-save state and timestamp */
+       ps->is_ps =3D is_ps;
+       ps->timestamp_sleep =3D timestamp_sleep;
+}
+
+static void cl_stats_print_per(struct cl_hw *cl_hw, u32 delay)
+{
+       u32 system_per =3D 0, air_per =3D 0, ampdu_all,
+               old_phy_error, old_fcs_error, old_overflow, old_complete,
+               old_ampdu_failed, old_real_fcs, old_ampdu_success,
+               new_phy_error, new_fcs_error, new_overflow, new_complete,
+               new_ampdu_failed, new_real_fcs, new_ampdu_success;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       old_phy_error =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_RX_PHY_ERROR_CO=
UNT);
+       old_fcs_error =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_FCS_ERROR_COUNT=
);
+       old_overflow =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_RX_FIFO_OVERFLOW=
_COUNT);
+       old_complete =3D cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU=
_COUNT0) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT1) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT2) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT3) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT4) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT5) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT6) +
+                      cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_C=
OUNT7);
+       old_ampdu_failed =3D cl_mib_cntr_read(cl_hw, MIB_AMPDU_INCORRECT_RC=
VED_COUNT);
+       old_ampdu_success =3D cl_mib_cntr_read(cl_hw, MIB_RW_U_AMPDU_RECEIV=
ED_COUNT);
+       old_real_fcs =3D old_fcs_error - old_overflow;
+
+       mdelay(delay);
+
+       new_phy_error =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_RX_PHY_ERROR_CO=
UNT);
+       new_fcs_error =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_FCS_ERROR_COUNT=
);
+       new_overflow =3D cl_mib_cntr_read(cl_hw, MIB_DOT11_RX_FIFO_OVERFLOW=
_COUNT);
+       new_complete =3D cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU=
_COUNT0) +
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT1) =
+
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT2) =
+
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT3) =
+
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT4) =
+
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT5) =
+
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT6) =
+
+               cl_mib_cntr_read(cl_hw, MIB_RW_QOS_U_RECEIVED_MPDU_COUNT7);
+       new_ampdu_failed =3D cl_mib_cntr_read(cl_hw, MIB_AMPDU_INCORRECT_RC=
VED_COUNT);
+       new_ampdu_success =3D cl_mib_cntr_read(cl_hw, MIB_RW_U_AMPDU_RECEIV=
ED_COUNT);
+       new_real_fcs =3D new_fcs_error - new_overflow;
+
+       /* Overflow handling */
+       if (old_complete > new_complete ||
+           old_overflow > new_overflow ||
+           old_fcs_error > new_fcs_error ||
+           old_phy_error > new_phy_error ||
+           old_ampdu_failed > new_ampdu_failed)
+               return;
+
+       ampdu_all =3D (new_ampdu_failed - old_ampdu_failed) +
+               (new_ampdu_success - old_ampdu_success);
+
+       if (new_complete - old_complete) {
+               system_per =3D ((new_overflow - old_overflow) * 100 /
+                             (new_complete - old_complete));
+       } else {
+               cl_snprintf(&buf, &len, &buf_size, "No successfully receive=
d packets\n");
+               goto out;
+       }
+
+       if ((new_fcs_error + new_phy_error + new_complete) -
+           (old_fcs_error + old_phy_error + old_complete))
+               air_per =3D (new_real_fcs - old_real_fcs) * 100 /
+               ((new_real_fcs + new_complete) - (old_real_fcs + old_comple=
te));
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Air PER =3D [%u%%]\n"
+                   "System PER =3D [%u%%]\n"
+                   "Successfully received packets =3D [%u]\n"
+                   "Number of phy errors received: [%u]\n"
+                   "Aggregation failure ratio: [%u/%u]\n",
+                   air_per, system_per, new_complete - old_complete,
+                   new_phy_error - old_phy_error,
+                   new_ampdu_failed - old_ampdu_failed, ampdu_all);
+
+out:
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void cl_stats_print_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta=
)
+{
+       struct cl_stats *stats =3D cl_sta->stats;
+       u32 i =3D 0, j =3D 0;
+       u64 avg_rssi[MAX_ANTENNAS] =3D {0};
+       u64 sum_rssi[MAX_ANTENNAS] =3D {0};
+       u64 total_rssi =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "STA #%u, MAC %pM\n", cl_sta->sta_idx, cl_sta->addr);
+
+       cl_snprintf(&buf, &len, &buf_size, "|----");
+       for (j =3D 0; j < cl_hw->num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "-----------");
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       cl_snprintf(&buf, &len, &buf_size, "|RSSI");
+       for (j =3D 0; j < cl_hw->num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "|   Ant%u   ", j + 1);
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       cl_snprintf(&buf, &len, &buf_size, "|----");
+       for (j =3D 0; j < cl_hw->num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+----------");
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       for (i =3D 0; i < RSSI_ARR_SIZE; i++) {
+               total_rssi =3D 0;
+
+               for (j =3D 0; j < cl_hw->num_antennas; j++) {
+                       total_rssi +=3D stats->rssi[i][j];
+                       sum_rssi[j] +=3D stats->rssi[i][j];
+                       avg_rssi[j] +=3D (i * stats->rssi[i][j]);
+               }
+
+               /* Does not print rssi entries with 0 packets */
+               if (total_rssi =3D=3D 0)
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size, "|%3d ", -i);
+               for (j =3D 0; j < cl_hw->num_antennas; j++)
+                       cl_snprintf(&buf, &len, &buf_size,
+                                   "|%10u", stats->rssi[i][j]);
+               cl_snprintf(&buf, &len, &buf_size, "|\n");
+       }
+
+       total_rssi =3D 0;
+
+       for (j =3D 0; j < cl_hw->num_antennas; j++) {
+               if (sum_rssi[j] =3D=3D 0)
+                       goto out;
+
+               avg_rssi[j] =3D div64_u64(avg_rssi[j], sum_rssi[j]);
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "|----");
+       for (j =3D 0; j < cl_hw->num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "+----------");
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       cl_snprintf(&buf, &len, &buf_size, "|AVG ");
+       for (j =3D 0; j < cl_hw->num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "|%10lld", -avg_rssi[j])=
;
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+       cl_snprintf(&buf, &len, &buf_size, "|----");
+       for (j =3D 0; j < cl_hw->num_antennas; j++)
+               cl_snprintf(&buf, &len, &buf_size, "-----------");
+       cl_snprintf(&buf, &len, &buf_size, "|\n");
+
+out:
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void cl_stats_print_fec_coding(struct cl_hw *cl_hw, struct cl_sta *=
cl_sta)
+{
+       struct cl_stats *stats =3D cl_sta->stats;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nSTA #%u, MAC %pM\n", cl_sta->sta_idx, cl_sta->addr);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "BCC  =3D %u\n", stats->fec_coding[CL_FEC_CODING_BCC]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "LDPC =3D %u\n", stats->fec_coding[CL_FEC_CODING_LDPC])=
;
+
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void cl_stats_print_power_save(struct cl_hw *cl_hw, struct cl_sta *=
cl_sta)
+{
+       struct cl_ps_stats *ps_stats =3D &cl_sta->stats->ps;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "STA #%u, MAC %pM\n", cl_sta->sta_idx, cl_sta->addr);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Current state =3D %s\n", ps_stats->is_ps ? "SLEEP" : "=
AWAKE");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|-------------------------|\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| Period     | Counter    |\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|-------------------------|\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 50ms    | %10u |\n", ps_stats->period[PS_PERIOD=
_50MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 100ms   | %10u |\n", ps_stats->period[PS_PERIOD=
_100MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 250ms   | %10u |\n", ps_stats->period[PS_PERIOD=
_250MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 500ms   | %10u |\n", ps_stats->period[PS_PERIOD=
_500MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 750ms   | %10u |\n", ps_stats->period[PS_PERIOD=
_750MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 1000ms  | %10u |\n", ps_stats->period[PS_PERIOD=
_1000MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 2000ms  | %10u |\n", ps_stats->period[PS_PERIOD=
_2000MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 5000ms  | %10u |\n", ps_stats->period[PS_PERIOD=
_5000MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "| <=3D 10000ms | %10u |\n", ps_stats->period[PS_PERIOD=
_10000MS]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|  > 10000ms | %10u |\n", ps_stats->period[PS_PERIOD_A=
BOVE]);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|-------------------------|\n");
+
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void _cl_stats_print_tx(char **buf, int *len, ssize_t *buf_size,
+                              struct cl_tx_cntrs *cntrs,
+                              const char *mode_str, const char *bw_str, co=
nst char *gi_str,
+                              u8 nss, u8 mcs, u8 bf,
+                              u64 *total_success, u64 *total_fail)
+{
+       u8 per =3D 0;
+
+       if (cntrs->fail =3D=3D 0 && cntrs->success =3D=3D 0)
+               return;
+
+       per =3D (u8)div64_u64(100 * (u64)cntrs->fail, cntrs->fail + cntrs->=
success);
+
+       cl_snprintf(buf, len, buf_size,
+                   "|%-8s|%-3s|%2u|%3u|%3s|%2u|%10u|%10u|%3u|\n",
+                   mode_str, bw_str, nss, mcs, gi_str, bf, cntrs->success,=
 cntrs->fail, per);
+
+       *total_success +=3D cntrs->success;
+       *total_fail +=3D cntrs->fail;
+}
+
+static void cl_stats_print_tx_he(char **buf, int *len, ssize_t *buf_size,
+                                struct cl_stats *stats, u64 *total_success=
, u64 *total_fail)
+{
+       struct cl_tx_cntrs *cntrs;
+       u8 bw =3D 0, nss =3D 0, mcs =3D 0, gi =3D 0, bf =3D 0;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX; bw++)
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++)
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX; mcs++)
+                               for (gi =3D 0; gi < WRS_GI_MAX; gi++)
+                                       for (bf =3D 0; bf < BF_IDX_MAX; bf+=
+) {
+                                               cntrs =3D &stats->tx.he[bw]=
[nss][mcs][gi][bf];
+                                               _cl_stats_print_tx(buf, len=
, buf_size,
+                                                                  cntrs,
+                                                                  "HE",
+                                                                  bw_str[b=
w], gi_he_str[gi],
+                                                                  nss, mcs=
, bf,
+                                                                  total_su=
ccess, total_fail);
+                                       }
+}
+
+static void cl_stats_print_tx_vht(char **buf, int *len, ssize_t *buf_size,
+                                 struct cl_stats *stats, u64 *total_succes=
s, u64 *total_fail)
+{
+       struct cl_tx_cntrs *cntrs;
+       u8 bw =3D 0, nss =3D 0, mcs =3D 0, gi =3D 0, bf =3D 0;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_VHT; bw++)
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++)
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_VHT; mcs++)
+                               for (gi =3D 0; gi < WRS_GI_MAX_VHT; gi++)
+                                       for (bf =3D 0; bf < BF_IDX_MAX; bf+=
+) {
+                                               cntrs =3D &stats->tx.vht[bw=
][nss][mcs][gi][bf];
+                                               _cl_stats_print_tx(buf, len=
, buf_size,
+                                                                  cntrs,
+                                                                  "VHT",
+                                                                  bw_str[b=
w], gi_ht_vht_str[gi],
+                                                                  nss, mcs=
, bf,
+                                                                  total_su=
ccess, total_fail);
+                                       }
+}
+
+static void cl_stats_print_tx_ht(char **buf, int *len, ssize_t *buf_size,
+                                struct cl_stats *stats, u64 *total_success=
, u64 *total_fail)
+{
+       struct cl_tx_cntrs *cntrs;
+       u8 bw =3D 0, nss =3D 0, mcs =3D 0, gi =3D 0;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_HT; bw++)
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++)
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HT; mcs++)
+                               for (gi =3D 0; gi < WRS_GI_MAX_HT; gi++) {
+                                       cntrs =3D &stats->tx.ht[bw][nss][mc=
s][gi];
+                                       _cl_stats_print_tx(buf, len, buf_si=
ze,
+                                                          cntrs,
+                                                          "HT",
+                                                          bw_str[bw], gi_h=
t_vht_str[gi],
+                                                          nss, mcs, 0,
+                                                          total_success, t=
otal_fail);
+                               }
+}
+
+static void cl_stats_print_tx_ofdm(char **buf, int *len, ssize_t *buf_size=
,
+                                  struct cl_stats *stats, u64 *total_succe=
ss, u64 *total_fail)
+{
+       struct cl_tx_cntrs *cntrs;
+       u8 mcs;
+
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+               cntrs =3D &stats->tx.ofdm[mcs];
+               _cl_stats_print_tx(buf, len, buf_size,
+                                  cntrs,
+                                  "OFDM", bw_str[0], "0",
+                                  0, mcs, 0,
+                                  total_success, total_fail);
+       }
+}
+
+static void cl_stats_print_tx_cck(char **buf, int *len, ssize_t *buf_size,
+                                 struct cl_stats *stats, u64 *total_succes=
s, u64 *total_fail)
+{
+       struct cl_tx_cntrs *cntrs;
+       u8 mcs;
+
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+               cntrs =3D &stats->tx.cck[mcs];
+               _cl_stats_print_tx(buf, len, buf_size,
+                                  cntrs,
+                                  "CCK", bw_str[0], "0",
+                                  0, mcs, 0,
+                                  total_success, total_fail);
+       }
+}
+
+static void cl_stats_print_tx(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       struct cl_stats *stats =3D cl_sta->stats;
+       u64 total_success =3D 0, total_fail =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\nSTA #%u, MAC %pM\n", cl_sta->sta_idx, cl_sta->addr);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|MODE    |BW |SS|MCS|GI |BF| Success  |   Fail   |PER|=
\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|--------+---+--+---+---+--+----------+----------+---|=
\n");
+
+       cl_stats_print_tx_he(&buf, &len, &buf_size, stats, &total_success, =
&total_fail);
+       cl_stats_print_tx_vht(&buf, &len, &buf_size, stats, &total_success,=
 &total_fail);
+       cl_stats_print_tx_ht(&buf, &len, &buf_size, stats, &total_success, =
&total_fail);
+       cl_stats_print_tx_ofdm(&buf, &len, &buf_size, stats, &total_success=
, &total_fail);
+       cl_stats_print_tx_cck(&buf, &len, &buf_size, stats, &total_success,=
 &total_fail);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "                           |%10llu|%10llu|\n", total_s=
uccess, total_fail);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "                           -----------------------\n")=
;
+       cl_snprintf(&buf, &len, &buf_size,
+                   "\n");
+
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void _cl_stats_print_rx(struct cl_hw *cl_hw, struct cl_rx_stats *rx=
_stats,
+                              struct cl_sta *cl_sta)
+{
+       u8 mode =3D 0, mcs =3D 0, nss =3D 0, bw =3D 0, gi =3D 0, flag =3D r=
x_stats->flag;
+       u16 data_rate =3D 0, data_rate_div_10 =3D 0, data_rate_mod_10 =3D 0=
;
+       u64 remainder =3D 0, packets =3D 0, total_packets[WRS_MODE_MAX] =3D=
 {0},
+               total_data_rate[WRS_MODE_MAX] =3D {0}, equivalent_data_rate=
 =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+
+       if (cl_sta)
+               cl_snprintf(&buf, &len, &buf_size,
+                           "\nSTA #%u, MAC %pM\n",
+                           cl_sta->sta_idx, cl_sta->addr);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
-\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|  MODE   | BW | SS | MCS | GI | Data-Rate | #Packets =
|\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "|---------+----+----+-----+----+-----------+----------=
|\n");
+
+       if ((flag & RX_STATS_HE_TRIG) =3D=3D 0)
+               goto stats_he_ext;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_HE; bw++) {
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                               for (gi =3D 0; gi < WRS_GI_MAX_HE; gi++) {
+                                       packets =3D rx_stats->he_trig[bw][n=
ss][mcs][gi];
+
+                                       if (packets =3D=3D 0)
+                                               continue;
+
+                                       data_rate =3D cl_data_rates_get_x10=
(WRS_MODE_HE, bw,
+                                                                         n=
ss, mcs, gi);
+                                       data_rate_div_10 =3D data_rate / 10=
;
+                                       data_rate_mod_10 =3D data_rate % 10=
;
+
+                                       total_packets[WRS_MODE_HE] +=3D pac=
kets;
+                                       total_data_rate[WRS_MODE_HE] +=3D (=
packets * data_rate);
+
+                                       cl_snprintf(&buf, &len, &buf_size,
+                                                   "| HE_TRIG |%4u|%4u|%5u=
|%4s| %7u.%u |%10llu|\n",
+                                                   BW_TO_MHZ(bw), nss, mcs=
, gi_he_str[gi],
+                                                   data_rate_div_10, data_=
rate_mod_10, packets);
+                               }
+                       }
+               }
+       }
+
+stats_he_ext:
+       if ((flag & RX_STATS_HE_EXT) =3D=3D 0)
+               goto stats_he_mu;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_HE; bw++) {
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                               for (gi =3D 0; gi < WRS_GI_MAX_HE; gi++) {
+                                       packets =3D rx_stats->he_ext[bw][ns=
s][mcs][gi];
+
+                                       if (packets =3D=3D 0)
+                                               continue;
+
+                                       data_rate =3D cl_data_rates_get_x10=
(WRS_MODE_HE, bw,
+                                                                         n=
ss, mcs, gi);
+                                       data_rate_div_10 =3D data_rate / 10=
;
+                                       data_rate_mod_10 =3D data_rate % 10=
;
+
+                                       total_packets[WRS_MODE_HE] +=3D pac=
kets;
+                                       total_data_rate[WRS_MODE_HE] +=3D (=
packets * data_rate);
+
+                                       cl_snprintf(&buf, &len, &buf_size,
+                                                   "| HE_EXT  |%4u|%4u|%5u=
|%4s| %7u.%u |%10llu|\n",
+                                                   BW_TO_MHZ(bw), nss, mcs=
, gi_he_str[gi],
+                                                   data_rate_div_10, data_=
rate_mod_10, packets);
+                               }
+                       }
+               }
+       }
+
+stats_he_mu:
+       if ((flag & RX_STATS_HE_MU) =3D=3D 0)
+               goto stats_he_su;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_HE; bw++) {
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                               for (gi =3D 0; gi < WRS_GI_MAX_HE; gi++) {
+                                       packets =3D rx_stats->he_mu[bw][nss=
][mcs][gi];
+
+                                       if (packets =3D=3D 0)
+                                               continue;
+
+                                       data_rate =3D cl_data_rates_get_x10=
(WRS_MODE_HE, bw,
+                                                                         n=
ss, mcs, gi);
+                                       data_rate_div_10 =3D data_rate / 10=
;
+                                       data_rate_mod_10 =3D data_rate % 10=
;
+
+                                       total_packets[WRS_MODE_HE] +=3D pac=
kets;
+                                       total_data_rate[WRS_MODE_HE] +=3D (=
packets * data_rate);
+
+                                       cl_snprintf(&buf, &len, &buf_size,
+                                                   "| HE_MU   |%4u|%4u|%5u=
|%4s| %7u.%u |%10llu|\n",
+                                                   BW_TO_MHZ(bw), nss, mcs=
, gi_he_str[gi],
+                                                   data_rate_div_10, data_=
rate_mod_10, packets);
+                               }
+                       }
+               }
+       }
+
+stats_he_su:
+       if ((flag & RX_STATS_HE_SU) =3D=3D 0)
+               goto stats_vht;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_HE; bw++) {
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HE; mcs++) {
+                               for (gi =3D 0; gi < WRS_GI_MAX_HE; gi++) {
+                                       packets =3D rx_stats->he_su[bw][nss=
][mcs][gi];
+
+                                       if (packets =3D=3D 0)
+                                               continue;
+
+                                       data_rate =3D cl_data_rates_get_x10=
(WRS_MODE_HE, bw,
+                                                                         n=
ss, mcs, gi);
+                                       data_rate_div_10 =3D data_rate / 10=
;
+                                       data_rate_mod_10 =3D data_rate % 10=
;
+
+                                       total_packets[WRS_MODE_HE] +=3D pac=
kets;
+                                       total_data_rate[WRS_MODE_HE] +=3D (=
packets * data_rate);
+
+                                       cl_snprintf(&buf, &len, &buf_size,
+                                                   "| HE_SU   |%4u|%4u|%5u=
|%4s| %7u.%u |%10llu|\n",
+                                                   BW_TO_MHZ(bw), nss, mcs=
, gi_he_str[gi],
+                                                   data_rate_div_10, data_=
rate_mod_10, packets);
+                               }
+                       }
+               }
+       }
+
+stats_vht:
+       if ((flag & RX_STATS_VHT) =3D=3D 0)
+               goto stats_ht;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_VHT; bw++) {
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_VHT; mcs++) {
+                               for (gi =3D 0; gi < WRS_GI_MAX_VHT; gi++) {
+                                       packets =3D rx_stats->vht[bw][nss][=
mcs][gi];
+
+                                       if (packets =3D=3D 0)
+                                               continue;
+
+                                       data_rate =3D cl_data_rates_get_x10=
(WRS_MODE_VHT,
+                                                                         b=
w, nss, mcs, gi);
+                                       data_rate_div_10 =3D data_rate / 10=
;
+                                       data_rate_mod_10 =3D data_rate % 10=
;
+
+                                       total_packets[WRS_MODE_VHT] +=3D pa=
ckets;
+                                       total_data_rate[WRS_MODE_VHT] +=3D =
(packets * data_rate);
+
+                                       cl_snprintf(&buf, &len, &buf_size,
+                                                   "| VHT     |%4u|%4u|%5u=
|%4s| %7u.%u |%10llu|\n",
+                                                   BW_TO_MHZ(bw), nss, mcs=
, gi_ht_vht_str[gi],
+                                                   data_rate_div_10, data_=
rate_mod_10, packets);
+                               }
+                       }
+               }
+       }
+
+stats_ht:
+       if ((flag & RX_STATS_HT) =3D=3D 0)
+               goto stats_ofdm;
+
+       for (bw =3D 0; bw < CHNL_BW_MAX_HT; bw++) {
+               for (nss =3D 0; nss < WRS_SS_MAX; nss++) {
+                       for (mcs =3D 0; mcs < WRS_MCS_MAX_HT; mcs++) {
+                               for (gi =3D 0; gi < WRS_GI_MAX_HT; gi++) {
+                                       packets =3D rx_stats->ht[bw][nss][m=
cs][gi];
+
+                                       if (packets =3D=3D 0)
+                                               continue;
+
+                                       data_rate =3D cl_data_rates_get_x10=
(WRS_MODE_HT,
+                                                                         b=
w, nss, mcs, gi);
+                                       data_rate_div_10 =3D data_rate / 10=
;
+                                       data_rate_mod_10 =3D data_rate % 10=
;
+
+                                       total_packets[WRS_MODE_HT] +=3D pac=
kets;
+                                       total_data_rate[WRS_MODE_HT] +=3D (=
packets * data_rate);
+
+                                       cl_snprintf(&buf, &len, &buf_size,
+                                                   "| HT      |%4u|%4u|%5u=
|%4s| %7u.%u |%10llu|\n",
+                                                   BW_TO_MHZ(bw), nss, mcs=
, gi_ht_vht_str[gi],
+                                                   data_rate_div_10, data_=
rate_mod_10, packets);
+                               }
+                       }
+               }
+       }
+
+stats_ofdm:
+       if ((flag & RX_STATS_OFDM) =3D=3D 0)
+               goto stats_cck;
+
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_OFDM; mcs++) {
+               packets =3D rx_stats->ofdm[mcs];
+
+               if (packets =3D=3D 0)
+                       continue;
+
+               data_rate =3D cl_data_rates_get_x10(WRS_MODE_OFDM, 0, 0, mc=
s, 0);
+               data_rate_div_10 =3D data_rate / 10;
+               data_rate_mod_10 =3D data_rate % 10;
+
+               total_packets[WRS_MODE_OFDM] +=3D packets;
+               total_data_rate[WRS_MODE_OFDM] +=3D (packets * data_rate);
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "| OFDM    |  20|   0|%5u|   0| %7u.%u |%10llu|=
\n",
+                           mcs, data_rate_div_10, data_rate_mod_10, packet=
s);
+       }
+
+stats_cck:
+       if ((flag & RX_STATS_CCK) =3D=3D 0)
+               goto stats_end;
+
+       for (mcs =3D 0; mcs < WRS_MCS_MAX_CCK; mcs++) {
+               packets =3D rx_stats->cck[mcs];
+
+               if (packets =3D=3D 0)
+                       continue;
+
+               data_rate =3D cl_data_rates_get_x10(WRS_MODE_CCK, 0, 0, mcs=
, 0);
+               data_rate_div_10 =3D data_rate / 10;
+               data_rate_mod_10 =3D data_rate % 10;
+
+               total_packets[WRS_MODE_CCK] +=3D packets;
+               total_data_rate[WRS_MODE_CCK] +=3D (packets * data_rate);
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "| CCK     |  20|   0|%5u|   0| %7u.%u |%10llu|=
\n",
+                           mcs, data_rate_div_10, data_rate_mod_10, packet=
s);
+       }
+
+stats_end:
+       cl_snprintf(&buf, &len, &buf_size,
+                   "------------------------------------------------------=
-\n");
+
+       for (mode =3D 0; mode < WRS_MODE_MAX; mode++) {
+               if (total_packets[mode] =3D=3D 0)
+                       continue;
+
+               equivalent_data_rate =3D div64_u64(total_data_rate[mode], t=
otal_packets[mode]);
+               data_rate_div_10 =3D (u16)div64_u64_rem(equivalent_data_rat=
e, 10, &remainder);
+
+               cl_snprintf(&buf, &len, &buf_size,
+                           "%s: Equivalent data rate =3D %u.%u Mbps\n\n",
+                           WRS_MODE_STR(mode), data_rate_div_10, (u16)rema=
inder);
+       }
+
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void cl_stats_print_rx(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       if (cl_hw->chip->conf->ce_production_mode)
+               _cl_stats_print_rx(cl_hw, cl_hw->rx_stats, NULL);
+       else
+               _cl_stats_print_rx(cl_hw, &cl_sta->stats->rx, cl_sta);
+}
+
+static void cl_stats_print_cpu(struct cl_hw *cl_hw)
+{
+       u32 cpu =3D 0;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+       struct cl_cpu_cntr *cpu_cntr =3D &cl_hw->cpu_cntr;
+
+       cl_snprintf(&buf, &len, &buf_size, "|-------------------------|\n")=
;
+       cl_snprintf(&buf, &len, &buf_size, "|CPU|Tx Agg    |Tx Single |\n")=
;
+       cl_snprintf(&buf, &len, &buf_size, "|---+----------+----------|\n")=
;
+
+       for (cpu =3D 0; cpu < CPU_MAX_NUM; cpu++) {
+               if (cpu_cntr->tx_agg[cpu] =3D=3D 0 && cpu_cntr->tx_single[c=
pu] =3D=3D 0)
+                       continue;
+
+               cl_snprintf(&buf, &len, &buf_size, "| %u |%10u|%10u|\n",
+                           cpu,
+                           cpu_cntr->tx_agg[cpu],
+                           cpu_cntr->tx_single[cpu]);
+       }
+
+       cl_snprintf(&buf, &len, &buf_size, "|-------------------------|\n")=
;
+
+       cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+}
+
+static void cl_sta_print_do(struct cl_hw *cl_hw, u8 sta_idx, stats_callbac=
k callback)
+{
+       struct cl_sta *cl_sta;
+
+       cl_sta_lock(cl_hw);
+
+       cl_sta =3D cl_sta_get(cl_hw, sta_idx);
+       if (cl_sta)
+               callback(cl_hw, cl_sta);
+
+       cl_sta_unlock(cl_hw);
+}
+
+static void cl_stats_cli_cpu(struct cl_hw *cl_hw, bool action)
+{
+       if (action)
+               cl_stats_print_cpu(cl_hw);
+       else
+               memset(&cl_hw->cpu_cntr, 0, sizeof(struct cl_cpu_cntr));
+}
+
+static void cl_stats_cli_rx_info(struct cl_hw *cl_hw, bool action)
+{
+       if (action)
+               cl_rx_info_print(cl_hw);
+       else
+               cl_rx_info_reset(cl_hw);
+}
+
+static void cll_stats_config_ps(struct cl_sta *cl_sta)
+{
+       cl_sta->stats->ps.timestamp_sleep =3D jiffies;
+       cl_sta->stats->ps.is_ps =3D test_sta_flag(cl_sta->stainfo, WLAN_STA=
_PS_STA) ? true : false;
+}
+
+static void cl_stats_free(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       kfree(cl_sta->stats);
+       cl_sta->stats =3D NULL;
+}
+
+static void cl_stats_disable(struct cl_hw *cl_hw)
+{
+       pr_debug("Statistics disabled\n");
+       cl_hw->conf->ci_stats_en =3D false;
+       cl_sta_loop(cl_hw, cl_stats_free);
+
+       if (cl_hw->chip->conf->ce_production_mode) {
+               kfree(cl_hw->rx_stats);
+               cl_hw->rx_stats =3D NULL;
+       }
+}
+
+static void cl_stats_enable(struct cl_hw *cl_hw)
+{
+       /*
+        * Allocate for all existing stations.
+        * If one of the allocations fails disable ci_stats_en (and free th=
e
+        * stations that were already allocated).
+        * In production mode also allocate cl_hw->rx_stats
+        */
+       struct cl_sta *cl_sta =3D NULL;
+       bool success =3D true;
+
+       if (cl_hw->chip->conf->ce_production_mode) {
+               cl_hw->rx_stats =3D kzalloc(sizeof(*cl_hw->rx_stats), GFP_A=
TOMIC);
+
+               if (!cl_hw->rx_stats)
+                       goto out;
+       }
+
+       read_lock(&cl_hw->cl_sta_db.lock);
+
+       list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+               cl_sta->stats =3D kzalloc(sizeof(*cl_sta->stats), GFP_ATOMI=
C);
+
+               if (cl_sta->stats) {
+                       cll_stats_config_ps(cl_sta);
+               } else {
+                       success =3D false;
+                       break;
+               }
+       }
+
+       if (success) {
+               pr_debug("Statistics enabled\n");
+               cl_hw->conf->ci_stats_en =3D true;
+       } else {
+               list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list)
+                       cl_stats_free(cl_hw, cl_sta);
+       }
+
+out:
+       read_unlock(&cl_hw->cl_sta_db.lock);
+}
+
+static void cl_stats_cli_enable(struct cl_hw *cl_hw, bool enable)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (enable =3D=3D cl_hw->conf->ci_stats_en) {
+               pr_debug("Statistics are already %s\n", enable ? "Enabled" =
: "Disabled");
+               goto out;
+       }
+
+       if (enable)
+               cl_stats_enable(cl_hw);
+       else
+               cl_stats_disable(cl_hw);
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static void cl_stats_cli_rx(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       if (cl_hw->chip->conf->ce_production_mode) {
+               cl_stats_print_rx(cl_hw, NULL);
+       } else {
+               if (sta_idx =3D=3D STA_IDX_INVALID)
+                       cl_sta_loop(cl_hw, cl_stats_print_rx);
+               else
+                       cl_sta_print_do(cl_hw, sta_idx, cl_stats_print_rx);
+       }
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static void cl_stats_cli_rssi(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       if (sta_idx =3D=3D STA_IDX_INVALID)
+               cl_sta_loop(cl_hw, cl_stats_print_rssi);
+       else
+               cl_sta_print_do(cl_hw, sta_idx, cl_stats_print_rssi);
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static void cl_stats_cli_fec_coding(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       if (sta_idx =3D=3D STA_IDX_INVALID)
+               cl_sta_loop(cl_hw, cl_stats_print_fec_coding);
+       else
+               cl_sta_print_do(cl_hw, sta_idx, cl_stats_print_fec_coding);
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static void cl_stats_cli_ps(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       if (sta_idx =3D=3D STA_IDX_INVALID)
+               cl_sta_loop(cl_hw, cl_stats_print_power_save);
+       else
+               cl_sta_print_do(cl_hw, sta_idx, cl_stats_print_power_save);
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static void cl_stats_cli_tx(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       if (sta_idx =3D=3D STA_IDX_INVALID)
+               cl_sta_loop(cl_hw, cl_stats_print_tx);
+       else
+               cl_sta_print_do(cl_hw, sta_idx, cl_stats_print_tx);
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static void cl_stats_cli_reset(struct cl_hw *cl_hw, u8 sta_idx)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       if (cl_hw->chip->conf->ce_production_mode) {
+               memset(cl_hw->rx_stats, 0, sizeof(struct cl_rx_stats));
+       } else {
+               if (sta_idx =3D=3D STA_IDX_INVALID)
+                       cl_sta_loop(cl_hw, cl_stats_sta_reset);
+               else
+                       cl_sta_print_do(cl_hw, sta_idx, cl_stats_sta_reset)=
;
+       }
+
+out:
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+static int cl_stats_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "stats usage:\n"
+                "-a : Print air PER and system PER [delay-ms)]\n"
+                "-b : CPU stats [0-reset, 1-print]\n"
+                "-e : Enable/Disable statistics [0-dis, 1-en]\n"
+                "-f : Print RX FEC coding counters [sta_idx]\n"
+                "-p : Print power-save statistics [sta_idx]\n"
+                "-r : Print RX stats table [sta_idx]\n"
+                "-s : Print RSSI stats tables [sta_idx]\n"
+                "-t : Print TX stats table [sta_idx]\n"
+                "-u : Uplink stats [0-reset, 1-print]\n"
+                "-z : Reset stats tables [sta_idx]\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+static void _cl_stats_update_tx(struct cl_hw *cl_hw, struct cl_sta *cl_sta=
,
+                               struct cl_agg_tx_report *agg_report)
+{
+       struct cl_stats *stats =3D cl_sta->stats;
+       struct cl_tx_cntrs *cntrs;
+       union cl_rate_ctrl_info rate_ctrl_info =3D {.word =3D agg_report->r=
ate_cntrl_info};
+       u8 bw, nss, mcs, gi, bf;
+
+       switch (rate_ctrl_info.field.format_mod) {
+       case WRS_MODE_HE:
+               nss =3D (rate_ctrl_info.field.mcs_index >> 4);
+               mcs =3D (rate_ctrl_info.field.mcs_index & 0xF);
+               gi =3D rate_ctrl_info.field.gi;
+               bw =3D rate_ctrl_info.field.bw;
+               bf =3D agg_report->bf;
+               cntrs =3D &stats->tx.he[bw][nss][mcs][gi][bf];
+               break;
+       case WRS_MODE_VHT:
+               bw =3D rate_ctrl_info.field.bw;
+               nss =3D (rate_ctrl_info.field.mcs_index >> 4);
+               mcs =3D (rate_ctrl_info.field.mcs_index & 0xF);
+               gi =3D rate_ctrl_info.field.gi;
+               bf =3D agg_report->bf;
+               cntrs =3D &stats->tx.vht[bw][nss][mcs][gi][bf];
+               break;
+       case WRS_MODE_HT:
+               bw =3D rate_ctrl_info.field.bw;
+               nss =3D (rate_ctrl_info.field.mcs_index >> 3);
+               mcs =3D (rate_ctrl_info.field.mcs_index & 0x7);
+               gi =3D rate_ctrl_info.field.gi;
+               cntrs =3D &stats->tx.ht[bw][nss][mcs][gi];
+               break;
+       case WRS_MODE_OFDM:
+               mcs =3D rate_ctrl_info.field.mcs_index - RATE_CTRL_OFFSET_O=
FDM;
+               cntrs =3D &stats->tx.ofdm[mcs];
+               break;
+       case WRS_MODE_CCK:
+               mcs =3D rate_ctrl_info.field.mcs_index;
+               cntrs =3D &stats->tx.cck[mcs];
+               break;
+       default:
+               return;
+       }
+
+       cntrs->success +=3D agg_report->success;
+       cntrs->fail +=3D agg_report->fail;
+}
+
+void cl_stats_init(struct cl_hw *cl_hw)
+{
+       spin_lock_init(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en && cl_hw->chip->conf->ce_production_mo=
de) {
+               cl_hw->rx_stats =3D kzalloc(sizeof(*cl_hw->rx_stats), GFP_A=
TOMIC);
+
+               if (!cl_hw->rx_stats)
+                       cl_hw->conf->ci_stats_en =3D false;
+       }
+}
+
+void cl_stats_deinit(struct cl_hw *cl_hw)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en && cl_hw->chip->conf->ce_production_mo=
de) {
+               cl_hw->conf->ci_stats_en =3D false;
+
+               kfree(cl_hw->rx_stats);
+               cl_hw->rx_stats =3D NULL;
+       }
+
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+void cl_stats_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       /* If allocation failed disable ci_stats_en, and free the memory of=
 all other stations */
+       bool disable =3D false;
+
+       /* Take regular lock and not BH, because cl_sta_add_to_lut() alread=
y disables BH */
+       spin_lock(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en) {
+               cl_sta->stats =3D kzalloc(sizeof(*cl_sta->stats), GFP_ATOMI=
C);
+
+               if (cl_sta->stats)
+                       cll_stats_config_ps(cl_sta);
+               else
+                       disable =3D true;
+       }
+
+       spin_unlock(&cl_hw->lock_stats);
+
+       if (disable)
+               cl_stats_cli_enable(cl_hw, false);
+}
+
+void cl_stats_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+       spin_lock_bh(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en)
+               cl_stats_free(cl_hw, cl_sta);
+
+       spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                           struct cl_agg_tx_report *agg_report)
+{
+       spin_lock(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en) {
+               struct cl_stats *stats =3D cl_sta->stats;
+
+               stats->tx.agg_cntr++;
+               stats->tx.fail_cntr +=3D agg_report->fail;
+               _cl_stats_update_tx(cl_hw, cl_sta, agg_report);
+       }
+
+       spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+                              struct cl_agg_tx_report *agg_report)
+{
+       spin_lock(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en) {
+               cl_sta->stats->tx.fail_cntr +=3D agg_report->fail;
+               _cl_stats_update_tx(cl_hw, cl_sta, agg_report);
+       }
+
+       spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_rx_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
8 rssi[MAX_ANTENNAS])
+{
+       int i;
+       s8 rx_rssi;
+
+       spin_lock(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       for (i =3D 0; i < cl_hw->num_antennas; i++) {
+               rx_rssi =3D rssi[i] * -1;
+
+               if (rx_rssi >=3D 0 && rx_rssi < RSSI_ARR_SIZE)
+                       cl_sta->stats->rssi[rx_rssi][i]++;
+       }
+
+out:
+       spin_unlock(&cl_hw->lock_stats);
+}
+
+void _cl_stats_update_rx_rate(struct cl_hw *cl_hw, struct cl_rx_stats *rx_=
stats,
+                             struct hw_rxhdr *rxhdr)
+{
+       u8 bw, nss, mcs, gi;
+
+       switch (rxhdr->format_mod) {
+       case FORMATMOD_HE_TRIG:
+               nss =3D rxhdr->n_sts & 0x3;
+               mcs =3D min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+               gi =3D min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+               rx_stats->he_trig[rxhdr->ch_bw][nss][mcs][gi] +=3D rxhdr->f=
rm_successful_rx;
+               rx_stats->flag |=3D RX_STATS_HE_TRIG;
+               break;
+       case FORMATMOD_HE_EXT:
+               nss =3D rxhdr->n_sts & 0x3;
+               mcs =3D min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+               gi =3D min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+               rx_stats->he_ext[rxhdr->ch_bw][nss][mcs][gi] +=3D rxhdr->fr=
m_successful_rx;
+               rx_stats->flag |=3D RX_STATS_HE_EXT;
+               break;
+       case FORMATMOD_HE_MU:
+               nss =3D rxhdr->n_sts & 0x3;
+               mcs =3D min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+               gi =3D min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+               rx_stats->he_mu[rxhdr->ch_bw][nss][mcs][gi] +=3D rxhdr->frm=
_successful_rx;
+               rx_stats->flag |=3D RX_STATS_HE_MU;
+               break;
+       case FORMATMOD_HE_SU:
+               nss =3D rxhdr->n_sts & 0x3;
+               mcs =3D min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+               gi =3D min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+               rx_stats->he_su[rxhdr->ch_bw][nss][mcs][gi] +=3D rxhdr->frm=
_successful_rx;
+               rx_stats->flag |=3D RX_STATS_HE_SU;
+               break;
+       case FORMATMOD_VHT:
+               nss =3D rxhdr->n_sts & 0x3;
+               mcs =3D min_t(u8, rxhdr->mcs, WRS_MCS_MAX_VHT);
+               gi =3D rxhdr->gi_type & 0x1;
+               rx_stats->vht[rxhdr->ch_bw][nss][mcs][gi] +=3D rxhdr->frm_s=
uccessful_rx;
+               rx_stats->flag |=3D RX_STATS_VHT;
+               break;
+       case FORMATMOD_HT_MF:
+       case FORMATMOD_HT_GF:
+               bw =3D rxhdr->ch_bw & 0x1;
+               nss =3D (rxhdr->mcs >> 3) & 0x3;
+               mcs =3D rxhdr->mcs & 0x7;
+               gi =3D rxhdr->gi_type & 0x1;
+               rx_stats->ht[bw][nss][mcs][gi] +=3D rxhdr->frm_successful_r=
x;
+               rx_stats->flag |=3D RX_STATS_HT;
+               break;
+       case FORMATMOD_NON_HT:
+               if (rxhdr->mcs >=3D RATE_CTRL_OFFSET_OFDM) {
+                       mcs =3D (rxhdr->mcs - RATE_CTRL_OFFSET_OFDM) & 0x7;
+                       rx_stats->ofdm[mcs] +=3D rxhdr->frm_successful_rx;
+                       rx_stats->flag |=3D RX_STATS_OFDM;
+               } else if (cl_band_is_24g(cl_hw)) {
+                       mcs =3D rxhdr->mcs & 0x3;
+                       rx_stats->cck[mcs] +=3D rxhdr->frm_successful_rx;
+                       rx_stats->flag |=3D RX_STATS_CCK;
+               }
+               break;
+       }
+}
+
+void cl_stats_update_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s=
truct hw_rxhdr *rxhdr)
+{
+       spin_lock(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en) {
+               _cl_stats_update_rx_rate(cl_hw, &cl_sta->stats->rx, rxhdr);
+               cl_sta->stats->fec_coding[rxhdr->fec_coding]++;
+       }
+
+       spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_rx_rate_production(struct cl_hw *cl_hw, struct hw_rxh=
dr *rxhdr)
+{
+       spin_lock(&cl_hw->lock_stats);
+
+       if (cl_hw->conf->ci_stats_en)
+               _cl_stats_update_rx_rate(cl_hw, cl_hw->rx_stats, rxhdr);
+
+       spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_ps(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool i=
s_ps)
+{
+       struct cl_ps_stats *ps;
+
+       spin_lock(&cl_hw->lock_stats);
+
+       if (!cl_hw->conf->ci_stats_en)
+               goto out;
+
+       ps =3D &cl_sta->stats->ps;
+
+       if (ps->is_ps =3D=3D is_ps)
+               goto out;
+
+       ps->is_ps =3D is_ps;
+
+       if (is_ps) {
+               ps->timestamp_sleep =3D jiffies;
+       } else {
+               unsigned long sleep_time =3D jiffies_to_msecs(jiffies - ps-=
>timestamp_sleep);
+
+               if (sleep_time <=3D 50)
+                       ps->period[PS_PERIOD_50MS]++;
+               else if (sleep_time <=3D 100)
+                       ps->period[PS_PERIOD_100MS]++;
+               else if (sleep_time <=3D 250)
+                       ps->period[PS_PERIOD_250MS]++;
+               else if (sleep_time <=3D 500)
+                       ps->period[PS_PERIOD_500MS]++;
+               else if (sleep_time <=3D 750)
+                       ps->period[PS_PERIOD_750MS]++;
+               else if (sleep_time <=3D 1000)
+                       ps->period[PS_PERIOD_1000MS]++;
+               else if (sleep_time <=3D 2000)
+                       ps->period[PS_PERIOD_2000MS]++;
+               else if (sleep_time <=3D 5000)
+                       ps->period[PS_PERIOD_5000MS]++;
+               else if (sleep_time <=3D 10000)
+                       ps->period[PS_PERIOD_10000MS]++;
+               else
+                       ps->period[PS_PERIOD_ABOVE]++;
+       }
+
+out:
+       spin_unlock(&cl_hw->lock_stats);
+}
+
+int cl_stats_cli(struct cl_hw *cl_hw, struct cl_vif *cl_vif, struct cli_pa=
rams *cli_params)
+{
+       bool print_per =3D false;
+       bool cpu_stats =3D false;
+       bool enable_tx_rx_rssi =3D false;
+       bool print_rx =3D false;
+       bool print_rssi =3D false;
+       bool print_fec_coding =3D false;
+       bool print_power_save =3D false;
+       bool print_tx =3D false;
+       bool uplink_stats =3D false;
+       bool reset_stats =3D false;
+       u32 expected_params =3D -1;
+
+       switch (cli_params->option) {
+       case 'a':
+               print_per =3D true;
+               expected_params =3D 1;
+               break;
+       case 'b':
+               cpu_stats =3D true;
+               expected_params =3D 1;
+               break;
+       case 'e':
+               enable_tx_rx_rssi =3D true;
+               expected_params =3D 1;
+               break;
+       case 'f':
+               print_fec_coding =3D true;
+               expected_params =3D 1;
+               break;
+       case 'p':
+               print_power_save =3D true;
+               expected_params =3D 1;
+               break;
+       case 't':
+               print_tx =3D true;
+               expected_params =3D 1;
+               break;
+       case 'r':
+               print_rx =3D true;
+               expected_params =3D cl_hw->chip->conf->ce_production_mode ?=
 0 : 1;
+               break;
+       case 'z':
+               reset_stats =3D true;
+               expected_params =3D cl_hw->chip->conf->ce_production_mode ?=
 0 : 1;
+               break;
+       case 's':
+               print_rssi =3D true;
+               expected_params =3D 1;
+               break;
+       case 'u':
+               uplink_stats =3D true;
+               expected_params =3D 1;
+               break;
+       case '?':
+               return cl_stats_cli_help(cl_hw);
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
+       if (print_per) {
+               cl_stats_print_per(cl_hw, (u32)cli_params->params[0]);
+               return 0;
+       }
+
+       if (cpu_stats) {
+               cl_stats_cli_cpu(cl_hw, (bool)cli_params->params[0]);
+               return 0;
+       }
+
+       if (uplink_stats) {
+               cl_stats_cli_rx_info(cl_hw, (bool)cli_params->params[0]);
+               return 0;
+       }
+
+       if (enable_tx_rx_rssi) {
+               cl_stats_cli_enable(cl_hw, (bool)cli_params->params[0]);
+               return 0;
+       }
+
+       if (!cl_hw->conf->ci_stats_en) {
+               pr_debug("Statistics are disabled!\n"
+                        "To enable them type: "
+                        "'iwcl <interface> cecli stats -e.1'\n");
+               return 0;
+       }
+
+       if (print_rx) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               cl_stats_cli_rx(cl_hw, sta_idx);
+               return 0;
+       }
+
+       if (print_rssi) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               cl_stats_cli_rssi(cl_hw, sta_idx);
+               return 0;
+       }
+
+       if (print_fec_coding) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               cl_stats_cli_fec_coding(cl_hw, sta_idx);
+               return 0;
+       }
+
+       if (print_power_save) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               cl_stats_cli_ps(cl_hw, sta_idx);
+               return 0;
+       }
+
+       if (print_tx) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               cl_stats_cli_tx(cl_hw, sta_idx);
+               return 0;
+       }
+
+       if (reset_stats) {
+               u8 sta_idx =3D (u8)cli_params->params[0];
+
+               cl_stats_cli_reset(cl_hw, sta_idx);
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

