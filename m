Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C323AB92C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhFQQNM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:13:12 -0400
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:36864
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233781AbhFQQL7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kt1FSoY7daiI6LKREicrclJVQtOKphK38yBIAQMnZaGGhnNJRg8k8BHIHFzkwAixmw2ylGhFh6bbh5m8SX4viDswWMYk74dwSLVUaD9hebdaQPnie9+FGjYjahNleqmNYMFjgMICu4iI2OaRZhTUkqU/KGY0W8h0n9rtMnoZda6uFr9UF7KraGv/AJqgI13PhIaJRaFSJYUx9jPvnwb6pHwGba51whZIl3BmipThWtwx0XSdPvwmT6aD9kvGMzWdN2AP/8mUAlrYMT/b1rBGNgimOvk1bzzC3I8s56S2e9J/bxza0mGg8Uw+fNxDcEx5reUStZENs92FLQN3mMWseg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvTMS/5/SxHTkFZ93yvrieO7ZTesUdv0to0lY4ZohGs=;
 b=W2unwqNqx+PzGhHdFZLrBWBRnh+dFsZ+3nJjVnfPq7xPkZkDF9+30pMP6Vy6dqDCX1uYvD/wschoogPAvBqYugrXZ4vfn5zMiXIsHBtlpbFec7Lo0FyvKZnFgHSF5vruNrz4HKS7lyAL2t/G2lAYhV2E+5urwnk9/F19bHEM9a86Mj24KjWuVT6QePy+p/j4F1LZOqx2YPpWVP/bUT7ZkTxc8DWQqsP8z6OWOhQJpiNaNe7GVTQ/herwBEE0RdXfvPf3sIhApLuZEyoA1cekvMc6N+Hy7q3riH6tzKBFt5Oy+87MKC1a2rVygazuXIWGN1om10vuW12HkcSzB2cEgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvTMS/5/SxHTkFZ93yvrieO7ZTesUdv0to0lY4ZohGs=;
 b=kV836SW4LDA9kL7mA7u4ltvJh1wtTt+px8nx2ubUONUSi3KUGbd5MNjQOFw4jY+jHfGwxYf9j9Ps7sjW7ETTDXNwkWpUGc5eKGNl+SeHTDIXA99YjvbtGoZWGNZeANHZr8fqnm+h24CwURXlMe2z2xr7besFDZ7tmHSaqrCihKk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0978.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:08:34 +0000
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
Subject: [RFC v1 247/256] cl8k: add wrs/wrs_db.h
Date:   Thu, 17 Jun 2021 16:02:14 +0000
Message-Id: <20210617160223.160998-248-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:07:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d863a3e-0c77-45e0-286c-08d931a9f643
X-MS-TrafficTypeDiagnostic: AM8P192MB0978:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB09783737DFC2B28B626B7494F60E9@AM8P192MB0978.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:140;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmVgIzI3rAFaIRgD9QCHKrMQow/Imvd91B8fBRhU4lc7hsUYx7ah2yd0vp4EAS8z9OfEwwXU2EWAgTAdSssoni1Kx3m/pFb+AHaA6c5a4qbWCgqtDX0gRKLuuEm7oN3hMAGxjdemB8icndKFatVa3p5QUZPtBCkwsZGW3W94Y6j64UruuvYcUUs4xzk5iaukWQLwn9CMOjx0cYQo9Agge6iVk13n1wfsZPAyPaWhd9WEQl3CbVVBkA/4syeRG+jC3IsU0iGvR/E2CzUGzWSLlpZi/WntuS2NtFoYzgNH30b6QjIkgysNxFhmBZLq14JBrmZFPvjQCv4VE0+5IpLAd+STnpoYZ6DW/N6pVxEVt8aRunFY+m4a1nS1FdkJmZXO03yz/D0mdRHO8LFOD8lqPukzr7gnp9Ty0+W6QGeJ5nDqpWCgUdNbFg+KDXncIdQpNYW+mR0WMDo/DW1+Nj5KdHKT/TZqtvoNQf01wrSbZ9nVFpF7c6stBI6PnQNNaWE8WdyLgfeRhAw9Csf9TddhjVOU1YjyS21LOEi1ktFYKiLJ0ViZ72BzMvvQTevdcDdfFJOzQsHHN62zWX0OshBhPTsEJVe0pCEf+m3vPnd8ix9GDbnbK5t3fPlq99O8wouiHoMlkISR/hZni4lPYmMOGW1pNHOnFNkwnUY0IPWR06RS+RYzWSQnpusHtCicO+TXhS8O1cNSuF8GOX9uQIuzQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(376002)(39850400004)(366004)(16526019)(107886003)(6666004)(5660300002)(66556008)(83380400001)(26005)(30864003)(186003)(1076003)(2616005)(316002)(66476007)(66946007)(9686003)(2906002)(6512007)(8676002)(508600001)(52116002)(55236004)(6486002)(38350700002)(86362001)(38100700002)(6916009)(8936002)(6506007)(956004)(4326008)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xx/HlWGElsuOLeRtttX4J6q4Re0TRp5ZxjWCVK8nQV4RmtjvHqeCil/zqn35?=
 =?us-ascii?Q?xdkARF5xldH4A/gkiUUCYKNbNG8lHMdLbP5CbTZSl4j92ao/2vrMso3lmMD9?=
 =?us-ascii?Q?Q4MOqefT42YYIlMMjLhDlgxZrNoAmIYkFRsgb3z0ouaEc9tlZ+QA5GppdrOm?=
 =?us-ascii?Q?MipYgppM8pu0o0EbZEy9dEcWmnsFWFk83zvHSzFcyfdRQaLZMP7vF2CQGqC8?=
 =?us-ascii?Q?jQbvHN/DISaejQPX/RZ6lPK/VRfFuBSYU2tZzQkC3iM+oSONkVYcAOt/7URF?=
 =?us-ascii?Q?rQMvUayFtsWjt+OZu9m0Re7QRP8Nq7YfoMO00bx9HuB2S3UjtZE7hXd0p7+h?=
 =?us-ascii?Q?dT4XS/tc2kFODDVnoeHD1X+siJ3ZMZekuUPUR7Nh559xhOVXS/STN8+w2EAT?=
 =?us-ascii?Q?Q1VDK30l2uIG3zOXaKggg1GqCwyQdBEyZrWEmDNqnDvRH8hm6GiuAiobyDCn?=
 =?us-ascii?Q?7csimcnWtK/O5oS4a4HhvKqSVr2CHq6vP1Due7tXrGdibGhCvT1Cz7csM3MU?=
 =?us-ascii?Q?Ycmb1uw/bdsgMZKdxOaG6SbYQr8NjDYoqwz/M0+q8K6p8aYCCWsRpbksLKPg?=
 =?us-ascii?Q?UzTGNHEX3Ox4T9TuPxkswx3o/Zk4Pyn4TMETeKPy3qMFRuFqPyPWiI5iFkaR?=
 =?us-ascii?Q?TNkO+1I3rSjWKE+8r9lWqcgf4JCRGNl3O6i3nhlsVx1Aa4snLajAywxyS6cx?=
 =?us-ascii?Q?tKLhwuHiwf5OyCGL2sOqcu9xXxRMJ5AeynlpKgxUyS9D7QjT5BE9WdoN+GQV?=
 =?us-ascii?Q?Cq3XX+T5FlpIV1HcUxu2VL74j71UwcQMgrf7uTDdV2AxRcxX2SkmMGa8mANO?=
 =?us-ascii?Q?3QJ1PTAzLGq8+0QhOzOcDOE61kRqtilBhb4dNYoJ6HiQo456rYs3IHs83ZLr?=
 =?us-ascii?Q?vn3T2HzWvNyBT596dTY/ntUDTphun5Dv9+v9p8lxAFvWroBpZkvlpgNw7yjl?=
 =?us-ascii?Q?aiiuzU7wImWZoC3Fqf2lDlyhrqzEjfsZQMHFCWn3U+6g7jb6tmFwcSDvWGnS?=
 =?us-ascii?Q?kaXV+a9JnCfxhnrgdLBZM4ZfTYI01oztzy+u5iKXs+rllF3yNihIiAKxE2hz?=
 =?us-ascii?Q?/gIFr+qH4FNu3RctKcdGm70fQOz9Ik1+/5l6VhJzbQj4cnTsPLN+0g2jS/aC?=
 =?us-ascii?Q?pe4AdJAKFiNQFsYkrIRlvrqFvgjFSPCJuubiyYrU0ZZzOXEc0G0TUL6ohFmO?=
 =?us-ascii?Q?iLDyv87yKY7fk85KwLm3JlfRSFKq+oKzi+1s+NCiv936Kpv1ndGug9nwhnT6?=
 =?us-ascii?Q?nl6u4fQvG6713FLk3H0NntHhAR3vcczwuoDCcLKSHb/P1bFfGwLspb5GT9UH?=
 =?us-ascii?Q?QPgtofng3ivQKRQxUq2jD/3f?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d863a3e-0c77-45e0-286c-08d931a9f643
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:07:10.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GN2CpBD3guNB+9T272m8h7aDnpKF08YX8pI8O3kJo5BK/tQKq0Wqsthw9jXruSm1eFrJbFlEqCa0s4svRerS3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0978
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/wrs/wrs_db.h | 386 ++++++++++++++++++
 1 file changed, 386 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs/wrs_db.h

diff --git a/drivers/net/wireless/celeno/cl8k/wrs/wrs_db.h b/drivers/net/wi=
reless/celeno/cl8k/wrs/wrs_db.h
new file mode 100644
index 000000000000..2eefa0abaf8d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs/wrs_db.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_WRS_DB_H
+#define CL_WRS_DB_H
+
+#include "debug.h"
+#include "utils/timer.h"
+#include "def.h"
+#include "wrs/wrs_tables.h"
+
+#define WRS_MAINTENANCE_PERIOD_MS         40
+#define WRS_DATA_RATE_FACTOR              10
+#define WRS_RSSI_PROTECT_UP_THR           10
+#define WRS_RSSI_PROTECT_DN_THR           10
+#define WRS_MIN_FRAMES_FOR_DECISION       15
+#define WRS_EPR_FACTOR                    105
+#define WRS_CONVERGE_IDLE_PACKET_TH       5
+#define WRS_CONVERGE_IDLE_INTERVAL_RESET  6000  /* 6 sec */
+#define WRS_CONVERGE_IDLE_INTERVAL_RSSI   2000  /* 2 sec */
+#define WRS_CONVERGE_TRFC_INTERVAL_STATIC 30000 /* 30 sec */
+#define WRS_CONVERGE_TRFC_INTERVAL_MOTION 1000  /* 1 sec */
+#define WRS_IMMEDIATE_DROP_EPR_FACTOR     70    /* 70% */
+#define WRS_IMMEDIATE_DROP_MAX_IN_ROW     U32_MAX
+#define WRS_SYNC_MIN_ATTEMPTS             4
+#define WRS_SYNC_TIMEOUT                  1000  /* 1 sec */
+#define WRS_QUICK_UP_BA_THR               5
+#define WRS_QUICK_UP_INTERVAL_MS          1000
+#define WRS_QUICK_DOWN_EPR_FACTOR         85
+#define WRS_QUICK_DOWN_AGG_THR            3
+#define WRS_QUICK_DOWN_PKT_THR            60
+#define WRS_RSSI_PROTECT_SHIFT            7
+#define WRS_RSSI_PROTECT_BUF_SZ_OLD       BIT(WRS_RSSI_PROTECT_SHIFT) /* 2=
 ^ 7 =3D 128 */
+#define WRS_RSSI_PROTECT_BUF_SZ_NEW       3
+#define WRS_BA_NOT_RCV_TIME_SINCE_SYNC    1000
+#define WRS_CCA_PERIOD_MS                 1000
+#define WRS_CCA_PRIMARY_SHIFT             7
+#define WRS_CCA_PRIMARY_FACTOR            160 /* 160 / 2^7 =3D 1.25 =3D 25=
% */
+
+enum cl_wrs_rssi_prot_mode {
+       WRS_RSSI_PROT_MODE_RSSI,     /* Up/down based on rssi */
+       WRS_RSSI_PROT_MODE_NEIGHBOR, /* Up/down based on neighbors */
+
+       WRS_RSSI_PROTECT_MODE_MAX
+};
+
+enum cl_wrs_fixed_rate {
+       WRS_AUTO_RATE,
+       WRS_FIXED_FALLBACK_EN,
+       WRS_FIXED_FALLBACK_DIS,
+
+       WRS_FIXED_RATE_MAX
+};
+
+enum cl_wrs_fixed_param {
+       WRS_FIXED_PARAM_MODE,
+       WRS_FIXED_PARAM_BW,
+       WRS_FIXED_PARAM_NSS,
+       WRS_FIXED_PARAM_MCS,
+       WRS_FIXED_PARAM_GI,
+
+       WRS_FIXED_PARAM_MAX
+};
+
+#define FIXED_RATE_STR(x) \
+       (((x) =3D=3D WRS_AUTO_RATE) ? "auto rate" : \
+       (((x) =3D=3D WRS_FIXED_FALLBACK_EN) ? "fixed rate (fallbacks enable=
d)" : \
+       "fixed rate (fallbacks disabled)"))
+
+enum cl_wrs_decision {
+       WRS_DECISION_NONE,
+       WRS_DECISION_SAME,
+       WRS_DECISION_UP,
+       WRS_DECISION_UP_QUICK,
+       WRS_DECISION_UP_RSSI,
+       WRS_DECISION_UP_MCS1,
+       WRS_DECISION_DOWN,
+       WRS_DECISION_DOWN_RSSI,
+       WRS_DECISION_DOWN_IMMEDIATE,
+       WRS_DECISION_DOWN_QUICK,
+       WRS_DECISION_DOWN_NO_SYNC,
+       WRS_DECISION_RSSI_MGMT,
+
+       WRS_DECISION_MAX,
+};
+
+enum cl_wrs_mcs {
+       WRS_MCS_0,
+       WRS_MCS_1,
+       WRS_MCS_2,
+       WRS_MCS_3,
+       WRS_MCS_4,
+       WRS_MCS_5,
+       WRS_MCS_6,
+       WRS_MCS_7,
+       WRS_MCS_8,
+       WRS_MCS_9,
+       WRS_MCS_10,
+       WRS_MCS_11,
+       WRS_MCS_MAX,
+};
+
+#define WRS_MCS_MAX_CCK  WRS_MCS_4
+#define WRS_MCS_MAX_OFDM WRS_MCS_8
+#define WRS_MCS_MAX_HT   WRS_MCS_8
+#define WRS_MCS_MAX_VHT  WRS_MCS_10
+#define WRS_MCS_MAX_HE   WRS_MCS_MAX
+
+enum cl_wrs_ss {
+       WRS_SS_1,
+       WRS_SS_2,
+       WRS_SS_3,
+       WRS_SS_4,
+
+       WRS_SS_MAX
+};
+
+enum cl_wrs_gi {
+       WRS_GI_LONG,
+       WRS_GI_SHORT,
+       WRS_GI_VSHORT,
+
+       WRS_GI_MAX
+};
+
+#define WRS_GI_MAX_HT  WRS_GI_VSHORT
+#define WRS_GI_MAX_VHT WRS_GI_VSHORT
+#define WRS_GI_MAX_HE  WRS_GI_MAX
+
+enum cl_wrs_ltf {
+       LTF_X1,
+       LTF_X2,
+       LTF_X4,
+       LTF_MAX
+};
+
+enum cl_wrs_converge_mode {
+       WRS_CONVERGE_MODE_RESET,
+       WRS_CONVERGE_MODE_RSSI,
+
+       WRS_CONVERGE_MODE_MAX,
+};
+
+enum cl_wrs_mode {
+       WRS_MODE_CCK,
+       WRS_MODE_OFDM,
+       WRS_MODE_HT,
+       WRS_MODE_VHT,
+       WRS_MODE_HE,
+
+       WRS_MODE_MAX,
+};
+
+#define wrs_pr(wrs_db, level, ...) \
+       do { \
+               if ((level) <=3D (wrs_db)->debug_level) \
+                       pr_debug(__VA_ARGS__); \
+       } while (0)
+
+#define wrs_pr_verbose(wrs_db, ...) wrs_pr(wrs_db, DBG_LVL_VERBOSE, ##__VA=
_ARGS__)
+#define wrs_pr_err(wrs_db, ...)     wrs_pr(wrs_db, DBG_LVL_ERROR, ##__VA_A=
RGS__)
+#define wrs_pr_warn(wrs_db, ...)    wrs_pr(wrs_db, DBG_LVL_WARNING, ##__VA=
_ARGS__)
+#define wrs_pr_trace(wrs_db, ...)   wrs_pr(wrs_db, DBG_LVL_TRACE, ##__VA_A=
RGS__)
+#define wrs_pr_info(wrs_db, ...)    wrs_pr(wrs_db, DBG_LVL_INFO, ##__VA_AR=
GS__)
+
+/* m MUST be power of 2 ! */
+#define WRS_INC_POW2(c, m) (((c) + 1) & ((m) - 1))
+
+#define WRS_INC(c, m) \
+       do { \
+               (c)++; \
+               if ((c) =3D=3D (m)) \
+                       (c) =3D 0; \
+       } while (0)
+
+#define WRS_IS_DECISION_UP(decision) \
+       (((decision) >=3D WRS_DECISION_UP) && ((decision) <=3D WRS_DECISION=
_UP_MCS1))
+#define WRS_IS_DECISION_DOWN(decision) \
+       (((decision) >=3D WRS_DECISION_DOWN) && ((decision) <=3D WRS_DECISI=
ON_DOWN_NO_SYNC))
+
+#define WRS_DECISION_STR(decision) (                                   \
+       (decision) =3D=3D WRS_DECISION_NONE           ? "NONE"           : =
\
+       (decision) =3D=3D WRS_DECISION_SAME           ? "SAME"           : =
\
+       (decision) =3D=3D WRS_DECISION_UP             ? "UP"             : =
\
+       (decision) =3D=3D WRS_DECISION_UP_QUICK       ? "UP QUICK"       : =
\
+       (decision) =3D=3D WRS_DECISION_UP_RSSI        ? "UP RSSI"        : =
\
+       (decision) =3D=3D WRS_DECISION_UP_MCS1        ? "UP MCS1"        : =
\
+       (decision) =3D=3D WRS_DECISION_DOWN           ? "DOWN"           : =
\
+       (decision) =3D=3D WRS_DECISION_DOWN_RSSI      ? "DOWN RSSI"      : =
\
+       (decision) =3D=3D WRS_DECISION_DOWN_IMMEDIATE ? "DOWN IMMEDIATE" : =
\
+       (decision) =3D=3D WRS_DECISION_DOWN_QUICK     ? "DOWN QUICK"     : =
\
+       (decision) =3D=3D WRS_DECISION_DOWN_NO_SYNC   ? "DOWN NO_SYNC"   : =
\
+       (decision) =3D=3D WRS_DECISION_RSSI_MGMT      ? "RSSI MGMT"      : =
\
+       "ERROR")
+
+#define WRS_MODE_STR(mode) (               \
+       (mode) =3D=3D WRS_MODE_CCK  ? "CCK"  : \
+       (mode) =3D=3D WRS_MODE_OFDM ? "OFDM" : \
+       (mode) =3D=3D WRS_MODE_HT   ? "HT"   : \
+       (mode) =3D=3D WRS_MODE_VHT  ? "VHT"  : \
+       (mode) =3D=3D WRS_MODE_HE   ? "HE"   : \
+       "ERR")
+
+#define WRS_CONVERGE_MODE_STR(mode) \
+       ((mode) =3D=3D WRS_CONVERGE_MODE_RESET ? "RESET" : "RSSI")
+
+#define WRS_BW_STR(bw) (                  \
+       (bw) =3D=3D CHNL_BW_20  ? "20"  : \
+       (bw) =3D=3D CHNL_BW_40  ? "40"  : \
+       (bw) =3D=3D CHNL_BW_80  ? "80"  : \
+       (bw) =3D=3D CHNL_BW_160 ? "160" : \
+       "ERR")
+
+#define WRS_GI_STR(gi) (                       \
+       (gi) =3D=3D WRS_GI_LONG   ? "Long"       : \
+       (gi) =3D=3D WRS_GI_SHORT  ? "Short"      : \
+       (gi) =3D=3D WRS_GI_VSHORT ? "VeryShort" :  \
+       "ERROR")
+
+struct cl_wrs_tx_cntrs {
+       u64 epr_acc;
+       u32 total;
+       u32 fail;
+       u32 ba_not_rcv;
+       u32 ba_not_rcv_consecutive;
+};
+
+struct cl_wrs_tx_params {
+       u16 mode        : 3, /* Mode - 0 =3D CCK, 1 =3D OFDM, 2 =3D HT, 3 =
=3D VHT, 4 =3D HE. */
+           gi          : 2, /* GI - O =3D Long, 1 =3D Short, 2 =3D Very sh=
ort. */
+           bw          : 2, /* Bandwidth - 0 =3D 20M, 1 =3D 40M, 2 =3D 80M=
, 3 =3D 160M. */
+           nss         : 3, /* Spatial Streams - 0 =3D 1SS, 1 =3D 2SS, .. =
7 =3D 8SS. */
+           mcs         : 4, /* MCS - CCK (0 - 3), OFDM/HT (0 - 7), VHT (0 =
- 9), HE (0 - 11). */
+           fallback_en : 1,
+           is_fixed    : 1;
+};
+
+struct cl_wrs_logger {
+       unsigned long timestamp;
+       u16 rate_idx;
+       u32 success;
+       u32 fail;
+       u32 ba_not_rcv;
+       u16 down_rate_idx;
+       u16 up_rate_idx;
+       u16 curr_epr;
+       u16 down_epr;
+       u16 down_epr_factorized;
+       u16 penalty;
+       u16 up_time;
+       enum cl_wrs_decision decision;
+       u16 new_rate_idx;
+};
+
+struct cl_wrs_per_stats {
+       struct list_head list;
+       u8 mcs;
+       u8 bw;
+       u8 nss;
+       u8 gi;
+       u32 frames_total;
+       u32 frames_failed;
+       u64 epr_acc;
+};
+
+struct cl_wrs_rssi_prot_db {
+       s8 samples_old[WRS_RSSI_PROTECT_BUF_SZ_OLD];
+       s8 samples_new[WRS_RSSI_PROTECT_BUF_SZ_NEW];
+       u8 curr_idx_old;
+       u8 curr_idx_new;
+       s32 sum;
+};
+
+struct cl_wrs_params {
+       u8 is_fixed_rate  : 2,
+          quick_up_check : 1,
+          rsv            : 5;
+       u32 up_same_time_cnt;
+       u32 down_time_cnt;
+       enum cl_wrs_converge_mode converge_mode;
+       u32 converge_time_idle;
+       u32 converge_time_trfc;
+       u16 data_rate;
+       u16 rate_idx;
+       struct cl_wrs_table *table;
+       u16 table_size;
+       u16 penalty_decision_dn;
+       struct cl_wrs_tx_params tx_params;
+       enum cl_wrs_decision last_decision;
+       u32 decision_cnt[WRS_DECISION_MAX];
+       struct list_head list_rates;
+       u32 frames_total;
+       u32 fail_total;
+       u32 ba_not_rcv_total;
+       u64 epr_acc;
+       bool calc_ba_not_rcv;
+       bool sync;
+       unsigned long sync_timestamp;
+       unsigned long no_sync_timestamp;
+       u32 immediate_drop_cntr;
+       u32 immediate_drop_ignore;
+};
+
+struct cl_wrs_sta {
+       u8 sta_idx;
+       bool smps_enable;
+       u8 assoc_bw;
+       u8 gi_cap[CHNL_BW_MAX];
+       u64 supported_rates[CHNL_BW_MAX];
+       enum cl_wrs_mode mode;
+       struct cl_wrs_rate max_rate_cap;
+       struct cl_wrs_rssi_prot_db rssi_prot_db;
+       struct cl_wrs_params su_params;
+};
+
+struct cl_wrs_db {
+       /* General */
+       spinlock_t lock;
+       enum cl_dbg_level debug_level;
+       /* Timer */
+       struct cl_timer timer_maintenance;
+       u32 interval;
+       /* Fixed rate */
+       u8 is_fixed_rate;
+       /* Conservative initial rate */
+       bool conservative_mcs_noisy_env;
+       bool conservative_nss_noisy_env;
+       /* Immediate drop */
+       bool immediate_drop_en;
+       u8 immediate_drop_epr_factor;
+       u32 immediate_drop_max_in_row;
+       /* Converge idle */
+       bool converge_idle_en;
+       u32 converge_idle_interval_reset;
+       u32 converge_idle_interval_rssi;
+       u32 converge_idle_packet_th;
+       /* Converge traffic */
+       bool converge_trfc_en;
+       u32 converge_trfc_interval_static;
+       u32 converge_trfc_interval_motion;
+       /* Supported rates */
+       u8 mode;
+       u64 ap_supported_rates[CHNL_BW_MAX]; /* Bit array for each bw */
+       struct cl_wrs_rate max_cap;
+       /* RSSI protect */
+       bool rssi_protect_en;
+       u8 rssi_protect_mode;
+       s8 rssi_protect_up_thr;
+       s8 rssi_protect_dn_thr;
+       /* Time + step thresholds */
+       u16 time_th_min;
+       u16 time_th_max_up;
+       u16 time_th_max_down;
+       u16 step_down;
+       u16 step_up_same;
+       /* Quick up */
+       bool quick_up_en;
+       u8 quick_up_ba_thr;
+       u16 quick_up_interval;
+       /* Quick down */
+       bool quick_down_en;
+       u8 quick_down_epr_factor;
+       u8 quick_down_agg_thr;
+       u16 quick_down_pkt_thr;
+       /* BA not received */
+       bool ba_not_rcv_collision_filter;
+       bool ba_not_rcv_force;
+       u32 ba_not_rcv_time_since_sync;
+       /* Sync */
+       u16 sync_timeout;
+       u8 sync_min_attempts;
+       /* CCA counters */
+       unsigned long cca_timestamp;
+       u32 cca_primary;
+       u32 cca_sec80;
+       u32 cca_sec40;
+       u32 cca_sec20;
+       bool adjacent_interference20;
+       bool adjacent_interference40;
+       bool adjacent_interference80;
+       /* All the rest */
+       u32 min_frames_for_decision;
+       u8 epr_factor;
+};
+
+#endif /* CL_WRS_DB_H */
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

