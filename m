Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EB953295F
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbiEXLjy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236870AbiEXLjx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:53 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B509792D05
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWTpbQv5pe9mtuMCi0QiSsB+99jnWNXrBv8pbFCik0+NMY842FXHjETLPl4f8Hv7JXB9sc6USzQoL3/nUtL8VK2mmA3qqNWi3jO5ova4PbXg5XUq1IOiHVVXdWyf+sPzn/wW7nxalnLXpNelrmvEXTl9uMYyfxpKCemD7z/73mlI/A9ejuMRWQDYzKPuONmiOnoRUqJFkCtjtkifDtjRO8r/RIU+P9klDclN+n5bVSg633x3FvavWBGqb4bPOLN7bzwIuw73ECEceM8SGkSE6/uysWPvxlfEqUklVP+Ay4QqEh0yoQSP+mbPx82WRmxhoPx5dfJvGUuWQlb3zbVQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1QMp427PszoGDOKJWlCbEEHJoWVoA48pzfD1C6lCKNk=;
 b=aqE2x4tVRLG16zNaWOr8oUzlsZI08gKXcqsPAkBbFgwh/EjzVqhsu/7gJFYTL/VAHa8SGSTFHATFsMiwgoiXvjPY87SQsUTAARobZ5FLTwdJbh83PTNkmsDI/eXDWgxvbP+u3j8BXSAiyF64uTc8+CciJ3OVqZ85jw9zjUJH8SoDDBUSbqik8HCTc7dp90pw2ive6aDD73pb63OB04SAmtvPJYQqKxdRZK+//xrhK5tvnGpFz1DMeKfpQ/cl7m32f2wllYylkjB7fuAC/iBWh1jrE+4pmzWcQ/itSJFu6O75yT4OOFWd9GRMgFrpYSTL7BYE1waGx53yPMCdsfPeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1QMp427PszoGDOKJWlCbEEHJoWVoA48pzfD1C6lCKNk=;
 b=TmLh1+dsuMSTqLk3JI1uxEbIYz5WOiqrktOF/hbcWsiKFijCelm2BosqFhhYdZJ4xjwAFwXVLbNyMKSKMahQ46IaeLIhrSXGNJpfRcAMDnXP0eQxn9AuAOtmJbZflYSZ/7ruBuubv5qmq2uchzW6KtgWwa9ZCAOdNyQ0P2RHUxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:28 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:28 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Maksym Kokhan <maksym.kokhan@celeno.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v2 77/96] cl8k: add stats.h
Date:   Tue, 24 May 2022 14:34:43 +0300
Message-Id: <20220524113502.1094459-78-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220524113502.1094459-1-viktor.barna@celeno.com>
References: <20220524113502.1094459-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM6PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:8c::33) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78a1538a-0bbe-478e-a99f-08da3d79f98b
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669C8AE6FF8AC105C51EE3CF6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ceDYCliiYMwD4+YvDLZD4WKnE5eTRIEuciXvMl2jBj4ndwU9bk6dweJFKsgN3wRHFkBKaD5MXAC978/wfUKdCBlor9Jy5Q2MkrV3XxHtGE8i/Vf9Ar7jkyCDUoTrKpWyst06ojd4RCn87vKo32OnHwsKxnvdOrqJxcAYasH62Cd42/j4y5px/b9itijFMacbAb+S3CeIs9EGUytzwZjIx4yHu+KtIs20Gz0HzsA+gwVCsw2BDoIaT+4EnxyLkjgoDSw6R2r2xEdWCp1H72UidwrHx17Tou21WBeq2bCMf1/SrDWPrWOy/sadInxei2BVc8WfWwpo1S62j0QbJNIy/EQSGXPrB1IyZDtB52mKal9q+cJV5sgedEpfx6hijQvxM2+1WnEkrgNJha4PlrFAJ4XM5aZiEQHqLKGEIx2qW6GcL50g2+MYtdVv0jMlTxMg/drgQ+OExz+lzYNpXgVqS/84mc9VzNeAr1po/JCJI0kltJruSk/yEeh6FYdSuRdoDh2cTxYnSrZEm9C+ItUY1g/UIoGuy7WZXqADuYabaAV6qS9rWfZ1RjDjvEl5Dr9n/Ruf6AX2qCJHg1FORwQIFtU0j1dzvOiCKVhXdaBXa3lVtXdvNSY+RC1wMJ5tMzrcRK/RX6Jeh36PdnUWBpmv4YNNKbf6ZMBJb2Te/v+P+sYMKfUUAbDyU+rVGckryy48SKkzybl6eFlcwifuVdnW/TWP+6DZs44SzPz7hWKUlxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uc9BXoNzBr66O890ubizoxFmiYFR8/uf0KohNyjOGUAZCweKpgOJ5B1DUUjt?=
 =?us-ascii?Q?z4Q0CjrQaF/Rzoy9BsS5NrppiLna+hAzJ/BA94iFbzDIIEo1IqUlOn528Lue?=
 =?us-ascii?Q?Xto1yOoZqnqzMixUp5HukOeCgkJhR0N2bkucZ4LycSFProjpWYf82aF6HAWY?=
 =?us-ascii?Q?+YA9W0/Xoxp798yYH1Utwgk3qB3wmAxebk6TjZyg9sMFUEKkcl77BoRyxXX+?=
 =?us-ascii?Q?5P2wFeRdWP2Ln3BM+AIRTj79csSme7+mHABX+fZhLuhOR2iRpKyQlzZX2tfM?=
 =?us-ascii?Q?tKORc11R2hAA/Q3/iawG7ZVwZ3fsCRYFn03ZLsXO6LPzqPNnkvb4hoZysGx1?=
 =?us-ascii?Q?lbzFOQz3rUT/C7ZH6b2fK9dhg7JG1C78Ea58yVSPd93RmPQdsA74F2UYAH0M?=
 =?us-ascii?Q?NxbDow+YotW2Iw2XLBZW3cFCcO8xNMt2U/H5V8TjPSV8gP80Wo/gkddzt+Ta?=
 =?us-ascii?Q?EnaEoAZXpec9Sw3WM1w0soOceN90TPT38d+3Q4O3/S4GNcwKu3m13s40BWEz?=
 =?us-ascii?Q?FhVh+DTQV5I9chNm1RfZUaOmcR3VdX7tkkQNjXNyU85ZzDBznm9W+ommSzGq?=
 =?us-ascii?Q?CDCEPlWhxUH1fHoHbQKGa3lAqtxg1jyxlsXdSvBcPmoqQuWK/4A2CEBJuHhT?=
 =?us-ascii?Q?3gbUPplXX6KmoOfb0dsFeJlRMhis4TmLNZ6U9mqukVMUedCjyHjWGCDueZFH?=
 =?us-ascii?Q?iq5Ec1jlyK4mSuiO49RssXR3etzPY9cCPftBvANkRPSjvlhBIAlAEjcAizDM?=
 =?us-ascii?Q?/Ct5TNnppMKmYfAVZs1jHJRJz9AgaQ0g4KhZoo/ZFvYdJVdO0m68lFtTF9y+?=
 =?us-ascii?Q?iSU1UYpv6A478wGW4GDIJuS18W/YcnTamPINlETdYlutiwlwz3LFYLAVYzhp?=
 =?us-ascii?Q?trXdOTkQnBPr8l6+CmfZWBoOBWFJzwusEoJoR823XqReV6uyaMER1IkbbTvh?=
 =?us-ascii?Q?KghJ8wN6AH8ojkDj5WfIdawZyzWeXcMFmB1ycQf2RxY5W7G7X5ZeUDFQ/3+2?=
 =?us-ascii?Q?3dLwO6V+Axixp6+y0L6kH3IMBR9OJD5CqoofquL+J+2Xsv1auTWFAgkf+wsj?=
 =?us-ascii?Q?OV5QzZ/xGKfDbzzeDNALlUY763PNujQVXnIe/A3K9XX7p+L2F4OndXSikaYt?=
 =?us-ascii?Q?Whn27HhoYSKq8HV9swzFhNmpp7igJBcBWDVS5DkaomYZQuQmgy9t0WYM+AtH?=
 =?us-ascii?Q?Yd6790xIADE4SiJ6vCf4Z/0QqDmx7n8ofnZJtEEE3EOhsje9sVLVHCVZo0+J?=
 =?us-ascii?Q?v1P/nYJpZUDX+re60I22Eo6+5uMU7J6fYKpfit9V59AKrOvea2mpRgB9vBhj?=
 =?us-ascii?Q?nltc9udYmGkIKe4hGzZsuu+MK/cINpAV5BQn5CMkEzpUNNIrHYBvDWEwm8CO?=
 =?us-ascii?Q?f4qAH9nGnMLMvEmOfaR0+7WJSYpSqHFrQLfDpu0iFMTrGqtxr+P5qHEY/Pdx?=
 =?us-ascii?Q?zrCmsXAq5YKeOe2XQZuUIvVfl8eL7z0lfjqILY/KbWKh0ZmlyxRDPJVwBDak?=
 =?us-ascii?Q?9PNFBbE0nz/FSlbYbUDirg1CpryGanaa+KIqMo1eAZeDosvLg30b7MegtnKV?=
 =?us-ascii?Q?wiHL0rXd2+YxTP/XOhg9z1KdkYT7cPnhllkztvi/EwZNh8ZlxVJfRof1HluV?=
 =?us-ascii?Q?Tj07o56BeDeBfZFPmbPlzs+Gm0ayLRs3osdbGIGe+7F3oVlyZeSqWu1WLT/J?=
 =?us-ascii?Q?3QvAsOfe9Cnwi8qVlq86T26tmHFurpRt/0V+o3dFffeozNoLYQqazoPG6is7?=
 =?us-ascii?Q?ODQteKzOV6k7LNhcWRK3h67j16kXQ20=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a1538a-0bbe-478e-a99f-08da3d79f98b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:51.4925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 74y5lPh9EvFKLVtMO4c+N3b/LAVfHPtExmy8Y/zzP1EhfRAa9rPbdJevvztiG+jmacdl1WUOS1ZrJwpVT0V4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/stats.h | 108 +++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.h

diff --git a/drivers/net/wireless/celeno/cl8k/stats.h b/drivers/net/wireless/celeno/cl8k/stats.h
new file mode 100644
index 000000000000..480c00b395f1
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/stats.h
@@ -0,0 +1,108 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_STATS_H
+#define CL_STATS_H
+
+#include "wrs.h"
+
+enum cl_rx_stats_flag {
+	RX_STATS_CCK = 0x01,
+	RX_STATS_OFDM = 0x02,
+	RX_STATS_HT = 0x04,
+	RX_STATS_VHT = 0x08,
+	RX_STATS_HE_SU = 0x10,
+	RX_STATS_HE_MU = 0x20,
+	RX_STATS_HE_EXT = 0x40,
+	RX_STATS_HE_TRIG = 0x80,
+};
+
+struct cl_rx_stats {
+	u32 he_trig[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+	u32 he_ext[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+	u32 he_mu[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+	u32 he_su[CHNL_BW_MAX_HE][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+	u32 vht[CHNL_BW_MAX_VHT][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VHT];
+	u32 ht[CHNL_BW_MAX_HT][WRS_SS_MAX][WRS_MCS_MAX_HT][WRS_GI_MAX_HT];
+	u32 ofdm[WRS_MCS_MAX_OFDM];
+	u32 cck[WRS_MCS_MAX_CCK];
+	u8 flag;
+	u64 packet_success;
+};
+
+#define RSSI_ARR_SIZE 128
+#define BF_IDX_MAX 2
+
+struct cl_tx_cntrs {
+	u32 success;
+	u32 fail;
+};
+
+struct cl_tx_stats {
+	struct cl_tx_cntrs he[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX][WRS_GI_MAX][BF_IDX_MAX];
+	struct cl_tx_cntrs
+		vht[CHNL_BW_MAX_VHT][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VHT][BF_IDX_MAX];
+	struct cl_tx_cntrs ht[CHNL_BW_MAX_HT][WRS_SS_MAX][WRS_MCS_MAX_HT][WRS_GI_MAX_HT];
+	struct cl_tx_cntrs ofdm[WRS_MCS_MAX_OFDM];
+	struct cl_tx_cntrs cck[WRS_MCS_MAX_CCK];
+	u32 agg_cntr;
+	u32 fail_cntr;
+	u64 packet_success;
+	u64 packet_fail;
+};
+
+enum cl_ps_period {
+	PS_PERIOD_50MS,
+	PS_PERIOD_100MS,
+	PS_PERIOD_250MS,
+	PS_PERIOD_500MS,
+	PS_PERIOD_750MS,
+	PS_PERIOD_1000MS,
+	PS_PERIOD_2000MS,
+	PS_PERIOD_5000MS,
+	PS_PERIOD_10000MS,
+	PS_PERIOD_ABOVE,
+
+	PS_PERIOD_MAX
+};
+
+struct cl_ps_stats {
+	bool is_ps;
+	unsigned long timestamp_sleep;
+	u32 period[PS_PERIOD_MAX];
+};
+
+enum cl_fec_coding {
+	CL_FEC_CODING_BCC,
+	CL_FEC_CODING_LDPC,
+	CL_FEC_CODING_MAX
+};
+
+struct cl_stats {
+	struct cl_tx_stats tx;
+	struct cl_rx_stats rx;
+	u32 rssi[RSSI_ARR_SIZE][MAX_ANTENNAS];
+	u32 fec_coding[CL_FEC_CODING_MAX];
+	struct cl_ps_stats ps;
+};
+
+struct cl_vif;
+
+void cl_stats_init(struct cl_hw *cl_hw);
+void cl_stats_deinit(struct cl_hw *cl_hw);
+void cl_stats_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_stats_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+void cl_stats_update_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			    struct cl_agg_tx_report *agg_report);
+void cl_stats_update_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       struct cl_agg_tx_report *agg_report);
+void cl_stats_update_rx_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta, s8 rssi[MAX_ANTENNAS]);
+void cl_stats_update_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr);
+void cl_stats_update_rx_rate_production(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr);
+void cl_stats_update_ps(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool is_ps);
+void cl_stats_get_tx(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		     u64 *total_success, u64 *total_fail);
+u64 cl_stats_get_rx(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+int cl_stats_get_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+
+#endif /* CL_STATS_H */
-- 
2.36.1

