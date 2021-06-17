Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EC33AB832
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhFQQF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:05:28 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:17541
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233545AbhFQQFQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icA2HvkJG2LMZDx9/g8zLni8PHLyy3JmjQSWec2awyFryygicXjIn52XRwRE8uUtONNsB2Mt4Pn7SPTIk/UDsX1oSe9tKXxQtS48zIKMezCvEw8rtgJDeoIq0k9CNWQ4xx9jwM5AkhwLuBauHYQrtCNfGv4qfhpiWjiQwwYv6MKrXBcp3EQmWxl2NLF3TqGGdrMZdTifsexbbsbZ4V0bL5gWZNnJmMEaZy0qk+KdMcYKMmjCNb5bySj90Yklh8Ua+ueY7WRhrw3NyfPAtkzUbzAQoN2FaCAGRKUyzTwfaZonF3kWf9fu5Nak2Niu4R8c+VDWCCd9dDzJCB0gIFemZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpgGfur+Y29XqMxHXzqyJkY/N9ZRGcI/ttuaiPsRbE4=;
 b=VgHfOYfBbjVVeYesAtzjQbVW7Vl9hYU4ceYRCV7GOTWeDGZHMhGJ6xHI74MZGA/bdZv60gaLtJmeliKUZF/DOzUQgfuNPe4HWj4TkbmOrwudc4kGSsDzwfJRpJ6lSAt2dd5pshBF2K9evKWkLo+5wIdS7DzV3uRaimr6LmQTgODrNRzEIqmQBNfPsiF/8mE7oLtGB/WO6yxLo+kuV2KmYO6cMQdZ5CP+/+D/zUbV5R5jxPQO2Xng8r8AL+w06Xhitxg9dqssyDLV5aISGB2ArHeOTILwzX7NF2S0+EfuYZsJgnfFvV5FPT32XBHBm29ywWFu7Yarr+1kq5SLSVZCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpgGfur+Y29XqMxHXzqyJkY/N9ZRGcI/ttuaiPsRbE4=;
 b=JomavYZbkpOgIXy1wvjGz8sPpUN12EfZJKp0iDW2TyQ6SyWPrq0Kao0fmH9U73IVfEoSQs1T/Oc1onLlgtSp6qP7ZAMlfrzSLT9zHVTr+wq3DQr28j74ZFZQuvsZaunOXqh7tD4eqsZ4LV+Ei453tLR+bgPYQ7LsgZyZRiTTq6I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1188.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:03:06 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:06 +0000
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
Subject: [RFC v1 029/256] cl8k: add calib.h
Date:   Thu, 17 Jun 2021 15:58:36 +0000
Message-Id: <20210617160223.160998-30-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17db4ace-0cf0-4526-82d9-08d931a9649f
X-MS-TrafficTypeDiagnostic: AM9P192MB1188:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB11884C125729E1660DDF4C5AF60E9@AM9P192MB1188.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Z3SsKgFFHsI5q/RdexghEjch4zsXi5/L5wxxase13Wv36bNC4VnRAhaD61CeMts6SeHIeRDSq0aP9DpCxnv/0J+BkdpkRagjMxmiKcDmEJDA7g/ZIumIbZgfJKGa+PRfsFv8klv+ooXq0f8pTounGzk5QW4myB7ou4CtcZ88ACBrsB65bh67mcSitX+Gs0jCIH08yb7oOB3tgnOIU8l+iBKdgcUA7CPDJvMnSAjd6jMjwT5uR5RKsdLSfFGgz10PA3QIrzOAnqDgpxFhoculOAn2avBhUIUsgLxTVbGLPeCrgtPvbD0oXRDzEun/jHz91Jw+r0pzxH7KiCBDX1xk+7Bj7qQFDjf2d4ZrWl6X3AoBCur3xdBSx1P3yDt//k6sHs3m1XjQaoHEt73wsAllgTjLM9wn3vCnWFTqKEZRo2/MMVkxWn1H/FNvPx1tvyOFjyUc1cUbEXjkmUQimKUkznuPo48LepREpUOAUFdl/4xpkr7Cya2FCk4pIv1HbOJgLSTdgFXUnBDgQxg+hpcfXFdT2zvfI9K625IAepeOU2cjTo/fuKCPVpw1PouKsG7G7WKhSNM+T4U7nU9+4j+it2/3EWCbcb2SiGox+4qSJey9UwIJyq6K219Wu7JiIjZ6gf+7er8uYR63e5Z2GvXWQf2DVolTRZxKg3J0mCuBDHfrx2LI+hfiTFMH5y/36AEZLXiOzSZsHjtdfU8Z7uezw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(136003)(346002)(396003)(376002)(366004)(16526019)(66946007)(26005)(66476007)(6486002)(186003)(66556008)(9686003)(316002)(86362001)(508600001)(8676002)(6506007)(6666004)(6512007)(55236004)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(5660300002)(2906002)(6916009)(956004)(8936002)(107886003)(54906003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sGR+9EApt3wIUaoiJvUYi+Kfi17ZmYUDx0S0CXCPI2IEBLyGbPL/v72/8upv?=
 =?us-ascii?Q?2agdxuQmzuhpYSqA6uOPPxVoI0lHV0+f3YxKRfDVIk4ReHPM6H6gmFjuzKAj?=
 =?us-ascii?Q?XfE2vVFqaukctwI1VQkeAFaOD79ahph6OME+3fTHJ7oDe9QecI23tEQ780dw?=
 =?us-ascii?Q?PZJoamBCKFAIhMAZ3SE0//owP9v5njl9u/N48+tHRwU9pDcB64jvEOd53a3v?=
 =?us-ascii?Q?WU8PaMUaCecuu0ma4/zITYja/kKNs3r1YeR10xjVtrl2phQA9pBe0l8eysdm?=
 =?us-ascii?Q?qPGbvxUNPD4M1L4QHUxlEmo5QZfsNvCb1Jib1Se5MCoryGmUyq1vne/jS0Yq?=
 =?us-ascii?Q?Q6yYv1QsdE59ryCRn5ex3nv139zXnPUIYsUbQ7rmCOVY1b3xbD+tWMqmBt82?=
 =?us-ascii?Q?me4chw4Bup02MI6/h8FpBeR8nJF64p273HfMWBMgq/TRXNCN0Nhn+OkG4D8e?=
 =?us-ascii?Q?ZIE/lYkRlSEDROJ+Y5eeaGbit1OwerGDPN/7/R9lJVdmTDmMdoYF4TDlIF9n?=
 =?us-ascii?Q?Wjwhy3p30MOp/wN9IdpIUpoTGDURQ9aL/DGOBPtJyRegpURPCrY9Zub2tUbd?=
 =?us-ascii?Q?cxAeAtu5rtyIBRhjdnzLN7CM//KdbIVZYwQt9tj0uZa8Rg9oFKB4/crhWpnb?=
 =?us-ascii?Q?e2cP82PuHwJ1RRQknmqNESyiyxFwe8ouJkQJpzpPQDGgTgI29baKWOTegbhN?=
 =?us-ascii?Q?wnZfNpMLZL4k3dWY3tLgybwE+eNm3aizctBVaeTC2gxwUhojFlKtJU1aJPk0?=
 =?us-ascii?Q?PatOWAxYobTjo+mX9laEtFMy0IVqihtUShKKuDsDzQfYW7wi6Dv8frAhsNUb?=
 =?us-ascii?Q?p1IFHa+uI9f4re3ns31HyVwfY+z/zzyt+E9Bl81i+BGPaUj+CU0DigC0P2yc?=
 =?us-ascii?Q?IVejM2ISx8Y3smDNd17uHYqDJXHOZPb4g25nK83m86u7JbvYLC2znUsHELM7?=
 =?us-ascii?Q?xlFfHVdW1bICJxRIJ+12gOsgChODYFCUGXiMiZ+uQrZItdjJo486Tb9Aoh2Y?=
 =?us-ascii?Q?3fN3J6+qblpnvoQdyigWLTL1MWj7m7X682vr6To3iyiQKw+pMlrCRzUn+X6a?=
 =?us-ascii?Q?iMI6V/M8/HvB749UJZ4ddUfQ9f6dPcWOxdD/arP5IPhybHIuacKB16zgWToe?=
 =?us-ascii?Q?qaz7Kgsl0kCDqkUduFEugPC7sdQi7Y6eMQtQQ4ep4JP39HPkBbFrGM0C1NRA?=
 =?us-ascii?Q?gAMhH4cgx1zIwmA1wPSTOkWxDjmHaHGbHVLtgYiPJ//tb75rYkQeejFXfWkr?=
 =?us-ascii?Q?2X4QALtwtdi9ewx7l6AtWN1+IA8wCyTAAriLtBezYUsd4XPR85/7S9EnHAbs?=
 =?us-ascii?Q?FfrSkz4yNclDw6McWAVsF0cA?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17db4ace-0cf0-4526-82d9-08d931a9649f
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:05.8678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIQ/2Cam70fzwRrFzdgh3pK94QMEg0DzClamVevFDgqyHj5OnIUGPH3QbVt3TBsAxZkmtuRMfxju0w/x1ha2KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1188
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/calib.h | 237 +++++++++++++++++++++++
 1 file changed, 237 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.h

diff --git a/drivers/net/wireless/celeno/cl8k/calib.h b/drivers/net/wireles=
s/celeno/cl8k/calib.h
new file mode 100644
index 000000000000..3282b8fc4efd
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/calib.h
@@ -0,0 +1,237 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CALIB_H
+#define CL_CALIB_H
+
+#include <net/cfg80211.h>
+
+#include "def.h"
+#include "vendor_cmd.h"
+
+#define UNCALIBRATED_POWER        15
+#define UNCALIBRATED_POWER_OFFSET 0
+#define UNCALIBRATED_TEMPERATURE  35
+
+#define DCOC_LNA_GAIN_NUM  8
+#define MAX_SX             2
+#define IQ_NUM_TONES_REQ   8
+#define IQ_NUM_TONES_CFM   (2 * IQ_NUM_TONES_REQ)
+#define SINGLETONS_MAX_NUM 1
+#define LOOPS_MAX_NUM      (2 + SINGLETONS_MAX_NUM) /* 1: pre,2-11:singlet=
one,12:post */
+#define SX_FREQ_OFFSET_Q2  5
+
+/* Calibration constants */
+#define CALIB_RX_GAIN_DEFAULT        0x83
+#define CALIB_TX_GAIN_DEFAULT        0x75
+#define GAIN_SLEEVE_TRSHLD_DEFAULT   2
+#define CALIB_NCO_AMP_DEFAULT        -10
+#define CALIB_NCO_FREQ_DEFAULT       16 /* 5M/312.5K */
+#define LO_P_THRESH                  1000000
+#define N_SAMPLES_EXP_LOLC           13
+#define N_SAMPLES_EXP_IQC            13
+#define N_BIT_FIR_SCALE              11
+#define N_BIT_AMP_SCALE              10
+#define N_BIT_PHASE_SCALE            10
+#define GP_RAD_TRSHLD_DEFAULT        1144 /* Represents 1 degree in Q(16,1=
6): 1*(pi/180) */
+#define GA_LIN_UPPER_TRSHLD_DEFAULT  66295 /* Represents 0.1 db in Q(16,16=
): 10^( 0.1/20)*2^16 */
+#define GA_LIN_LOWER_TRSHLD_DEFAULT  64786 /* Represents -0.1 db in Q(16,1=
6): 10^(-0.1/20)*2^16 */
+#define COMP_FILTER_LEN_DEFAULT      9
+#define SINGLETONS_NUM_DEFAULT       10 /* Set to SINGLETONS_MAX_NUM for n=
ow*/
+#define RAMPUP_TIME                  50
+#define LO_COARSE_STEP               20
+#define LO_FINE_STEP                 1
+
+#define DCOC_MAX_VGA                     0x14
+#define CALIB_RX_GAIN_UPPER_LIMIT        0x0
+#define CALIB_RX_GAIN_LOWER_LIMIT        0x14
+#define DCOC_MAX_VGA_ATHOS               0x1E
+#define CALIB_RX_GAIN_DEFAULT_ATHOS      0x8D
+#define CALIB_RX_GAIN_UPPER_LIMIT_ATHOS  0x0A
+#define CALIB_RX_GAIN_LOWER_LIMIT_ATHOS  0x14
+
+#define SET_PHY_DATA_FLAGS_NONE       0x0
+#define SET_PHY_DATA_FLAGS_DCOC       0x1 /* Set DCOC calibration data.*/
+#define SET_PHY_DATA_FLAGS_IQ_TX      0x2 /* Set IQ Tx calibration data.*/
+#define SET_PHY_DATA_FLAGS_IQ_RX      0x4 /* Set IQ Rx calibration data.*/
+#define SET_PHY_DATA_FLAGS_IQ_TX_LOLC 0x8 /* Set IQ Tx LOLC calibration da=
ta.*/
+#define SET_PHY_DATA_FLAGS_ALL   ( \
+       SET_PHY_DATA_FLAGS_DCOC  | \
+       SET_PHY_DATA_FLAGS_IQ_TX | \
+       SET_PHY_DATA_FLAGS_IQ_RX | \
+       SET_PHY_DATA_FLAGS_IQ_TX_LOLC)
+
+enum calib_cfm_id_type {
+       CALIB_CFM_DCOC,
+       CALIB_CFM_IQ,
+       CALIB_CFM_MAX
+};
+
+enum calib_channel_idx_24g {
+       CALIB_CHAN_24G_1,
+       CALIB_CHAN_24G_6,
+       CALIB_CHAN_24G_11,
+       CALIB_CHAN_24G_MAX,
+};
+
+enum calib_channel_idx_5g {
+       CALIB_CHAN_5G_36,
+       CALIB_CHAN_5G_52,
+       CALIB_CHAN_5G_100,
+       CALIB_CHAN_5G_116,
+       CALIB_CHAN_5G_132,
+       CALIB_CHAN_5G_149,
+       CALIB_CHAN_5G_MAX
+};
+
+enum calib_channel_idx_6g {
+       CALIB_CHAN_6G_1,
+       CALIB_CHAN_6G_17,
+       CALIB_CHAN_6G_33,
+       CALIB_CHAN_6G_49,
+       CALIB_CHAN_6G_65,
+       CALIB_CHAN_6G_81,
+       CALIB_CHAN_6G_97,
+       CALIB_CHAN_6G_113,
+       CALIB_CHAN_6G_129,
+       CALIB_CHAN_6G_145,
+       CALIB_CHAN_6G_161,
+       CALIB_CHAN_6G_177,
+       CALIB_CHAN_6G_193,
+       CALIB_CHAN_6G_209,
+       CALIB_CHAN_6G_225,
+       CALIB_CHAN_6G_MAX,
+};
+
+/* MAX(CALIB_CHAN_24G_MAX, CALIB_CHAN_5G_MAX, CALIB_CHAN_6G_MAX) */
+#define CALIB_CHAN_MAX CALIB_CHAN_6G_MAX
+
+struct cl_dcoc_calib {
+       s8 i;
+       s8 q;
+};
+
+struct cl_dcoc_report {
+       __le16 i_dc;
+       __le16 i_iterations;
+       __le16 q_dc;
+       __le16 q_iterations;
+};
+
+struct cl_iq_report {
+       u8 status;
+       s8 ir_db[LOOPS_MAX_NUM][IQ_NUM_TONES_CFM];
+       s8 ir_db_avg_post;
+};
+
+struct cl_iq_calib {
+       __le32 coef0;
+       __le32 coef1;
+       __le32 coef2;
+       __le32 gain;
+};
+
+struct cl_calib_errors {
+       u16 dcoc;
+       u16 lolc;
+       u16 iq_tx;
+       u16 iq_rx;
+};
+
+struct cl_calib_db {
+       struct cl_dcoc_calib
+               dcoc[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_SX][MAX_ANTE=
NNAS][DCOC_LNA_GAIN_NUM];
+       u32 iq_tx_lolc[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_SX][MAX_AN=
TENNAS];
+       struct cl_iq_calib iq_tx[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_=
SX][MAX_ANTENNAS];
+       struct cl_iq_calib iq_rx[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_=
SX][MAX_ANTENNAS];
+       struct cl_calib_errors errors[TCV_MAX];
+       bool scan_complete;
+};
+
+
+struct cl_lolc_report {
+       u8 status;
+       u8 n_iter;
+       __le16 lolc_qual;
+};
+
+struct cl_gain_report {
+       u8 status;
+       u8 rx_gain;
+       u8 tx_gain;
+       u8 gain_quality;
+       __le16 final_p2p;
+       __le16 initial_p2p;
+};
+
+struct cl_iq_dcoc_info {
+       struct cl_dcoc_calib dcoc[DCOC_LNA_GAIN_NUM][MAX_ANTENNAS];
+       struct cl_iq_calib iq_tx[MAX_ANTENNAS];
+       __le32 iq_tx_lolc[MAX_ANTENNAS];
+       struct cl_iq_calib iq_rx[MAX_ANTENNAS];
+};
+
+struct cl_iq_dcoc_report {
+       struct cl_dcoc_report dcoc[DCOC_LNA_GAIN_NUM][MAX_ANTENNAS];
+       struct cl_gain_report gain_tx[MAX_ANTENNAS];
+       struct cl_gain_report gain_rx[MAX_ANTENNAS];
+       struct cl_lolc_report lolc_report[MAX_ANTENNAS];
+       struct cl_iq_report iq_tx[MAX_ANTENNAS];
+       struct cl_iq_report iq_rx[MAX_ANTENNAS];
+};
+
+struct calib_cfm {
+       u8 status;
+       __le16 raw_bits_data_0;
+       __le16 raw_bits_data_1;
+};
+
+struct cl_iq_dcoc_data {
+       struct cl_iq_dcoc_info iq_dcoc_db;
+       struct cl_iq_dcoc_report report;
+       struct calib_cfm dcoc_iq_cfm[CALIB_CFM_MAX];
+};
+
+struct cl_iq_dcoc_data_info {
+       struct cl_iq_dcoc_data *iq_dcoc_data;
+       u32 dma_addr;
+};
+
+struct cl_calib_restore {
+       u8 bw;
+       u32 primary;
+       u32 center;
+       u8 channel;
+};
+
+struct cl_hw;
+struct cl_calib_work {
+       struct work_struct ws;
+       struct cl_hw *cl_hw;
+};
+
+int cl_calib_get(struct wiphy *wiphy, struct wireless_dev *wdev,
+                            const void *data, int data_len);
+int cl_calib_set(struct wiphy *wiphy, struct wireless_dev *wdev,
+                            const void *data, int data_len);
+
+void cl_calib_power_read(struct cl_hw *cl_hw);
+void cl_calib_power_offset_fill(struct cl_hw *cl_hw, u8 channel,
+                                     u8 bw, u8 offset[MAX_ANTENNAS]);
+
+int cl_calib_pivot_channels_set(struct cl_hw *cl_hw, const void *chan_list=
, u32 size);
+int cl_calib_pivot_channels_reset(struct cl_hw *cl_hw);
+
+int cl_calib_start(struct cl_hw *cl_hw);
+void cl_calib_fill_phy_data(struct cl_hw *cl_hw, struct cl_iq_dcoc_info *i=
q_dcoc_db, u8 flags);
+int cl_calib_tables_alloc(struct cl_hw *cl_hw);
+void cl_calib_tables_free(struct cl_hw *cl_hw);
+bool cl_calib_is_needed(struct cl_hw *cl_hw, u8 channel, u8 bw);
+int cl_calib_set_channel(struct cl_hw *cl_hw, u8 channel, u8 bw, u32 prima=
ry, u32 center);
+void cl_calib_start_work(struct cl_hw *cl_hw);
+int cl_calib_handle_cfm(struct cl_hw *cl_hw, u8 mode);
+int cl_calib_validate_ants(struct cl_hw *cl_hw);
+void cl_calib_iq_get_tone_vector(u8 bw, u16 *tone_vector);
+int cl_calib_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_CALIB_H */
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

