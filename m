Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE283AB8C8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhFQQK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:10:29 -0400
Received: from mail-eopbgr60069.outbound.protection.outlook.com ([40.107.6.69]:39392
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232129AbhFQQJ2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:09:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I35JLinInJI6HwWuigfNiZmx9SRcCGUnHI5AAaHSNYr4GwKpnbG6z4rAb+DkRrOqrM/8L0xR83qX42whHIhp2sezOOeYi86IEaYVjGiKxR+X57dq3/GMbuA55U0TKY5bJB9wqikAbE0erEEuYP4hleni661t6ST3xRsOu/UcCgCTd8bPLILPCMnz9Aj0OSyf+iD6xqMyLvH/QNSrJzC+Aa5bM07FlASsP30A4IV8FLCJx797y+wlr/D+h7ocrBENvT8YTjrA0VEu3KRDZAm8Cw90onNsfWPEV+xc6N1vnTr4tiRDh+RUcgYTEOAIcshONhfr4Lyw4YNwtASgtILPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XIyumR82qhtFj9BvtknjUUyZroz9IIZUbBqMfvME9E=;
 b=n4DFr3CMjbTus/1nt8HGBKnnafWWdIrZQWADylQQHu6APviZx6+7FD6Z3QIGWC7WyvmsmCPm3qzEiYD0VeAyJ9geloxuZMtudIWujLnLvKMNm4IHSI2vk2rUHPUPeZtshfqws/1nzLK0ZGBedUcgJX6/9NxJ2sITIxiC9TqiSKS9yb/CeEMqYv/1oS4zQczBZ7A5bYNaLdOR8h1X8EscNRQTtGL/T8kBFe+uDb5+VMJNrebtIpsPn5CGdH3CgZW/MbXaXz+S9shwn0xcnUbIOiG4YZSsMhI2VDZ7f7l/8Y6wq3LgLlDtQH7mZM7GQbkBxzxmxSG0M02TQEPjW+Sarw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XIyumR82qhtFj9BvtknjUUyZroz9IIZUbBqMfvME9E=;
 b=x8g8d07uoipePM1gc9gbFmvVqZjsNz+FZV25cTsjR9ARZpYBTipLSLubHoFHbj3ogCZ1wG3QymHBnVy5hnTzZ/isveJSqnfjePgpiAtm2vVOgQgdSsE+iMf/XUOKWJEXLe7ecarGT0DYFGZYYfE38iOO6X2NApHkWTjhq2XorXQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1075.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:07:13 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:13 +0000
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
Subject: [RFC v1 193/256] cl8k: add traffic.h
Date:   Thu, 17 Jun 2021 16:01:20 +0000
Message-Id: <20210617160223.160998-194-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d558f8b1-dffa-49b9-182d-08d931a9d14b
X-MS-TrafficTypeDiagnostic: AM8P192MB1075:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB10754D9EE0B3F044B8BC6F72F60E9@AM8P192MB1075.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aey13Z4axxsJ2aFoEh5V6dSAl5hJWYEHX1lwX6VKLsKvz8g9TgjhODZokA3vtvt/54gIMKKcJD9dw3VTfHnjdH9+2QZCpa8bXJQZnWTvm6TQZu8a6G8lVSLJ8i+LQNwOL0Jx3dArlmEdDSCzsqdNnELUBnaBZ2n9NmSebYlYgaAtURjvzLy2oBLBXXhS+Z1LegyYt7IlHYh6B1LZQ6NqWN2YrYKSKrOEiT3xTWnR4+tWfgV81mtpMemk9wwCBzejPSRplHSXsLWasbZK2BBQ/X8f/HRo+Fs2N0zlTht6VsHLJkW/Y8rc2gn0GrEI0QvsRVA0KK2m1R2UedkkuQqGWAGQlbhgG3j6LaLqYrvWV+eHpXY8fnibBVmrbQQCE94DPuEtSWeY073VW3y2RowuQXb8PxHm/k2FcFeTbJAv4ZQn9rpbbTCh2BTCFnAEmbxsVH+NHHVPPOLcas8QtCmAHaztHzLCi3UMXiT5HbbmY58RVO9E01rTSp4L56AJ0xfumExWSCMBK2ZKN28LOnhRpdBHVVtIIH8iFBPpr5x8d/P8bvdURUKcnVFr0CWljMOVSWSQTCEzdIhcJCNmwT924lA0GvBuR4pnXD8cqrqbecv0grs2x6BoNYIYHrFG3BLA+t9SObAUtWTAfGMF8IBxuuCcoJ9ahBGhcrGKk40LXb7hTq17Bvv3v9v4W5PpwKX8UVhaRrzQKg+Ier8DpWKXVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(66476007)(6512007)(8936002)(66556008)(38350700002)(6916009)(9686003)(66946007)(956004)(86362001)(26005)(5660300002)(2616005)(38100700002)(8676002)(6506007)(6666004)(4326008)(1076003)(55236004)(186003)(2906002)(83380400001)(498600001)(16526019)(54906003)(52116002)(36756003)(107886003)(6486002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j+1opkwrmBF+lGwWNrMLC66+qlcSbN3q6kjgK4ks//BAbY1lMnNY4qbgsLd8?=
 =?us-ascii?Q?FwlGtogdImMjZLfpxk+MVgs/5jS3gPz+4c7GWV7OiBzCmKzRVq3hQ29dXAoM?=
 =?us-ascii?Q?iJ8oFDoGm1kWOc7aEUyWDuCibRWDV+4mEh1wJtRP7+QIMWQcX2SfswLyBT4l?=
 =?us-ascii?Q?dscCQvixSrx+6qE4Xro1VcEfRfxBN1MPnOzinEceFAQp5lTgtV50Wjy2OxKO?=
 =?us-ascii?Q?aa/6wMXIO9cyclglePXbJDq3sBZxqZXe4nVGZgIq+8SrRSOwv7jiFY5r9lCQ?=
 =?us-ascii?Q?WgEydL32QwJEri5vISdAaK2mnkDmeQIMZ8YCVVacFwLUOKOfx4RjkZSg8FZB?=
 =?us-ascii?Q?sfqW3pdLagwoMnmgb8qtX9r2HTZi66Tpx7/OHRDRTulQ2AMQUHaNGEj+Pj/h?=
 =?us-ascii?Q?4WcfqFa7heejB4AAKtYO2v2btB/rzVhFaFWp23Z+MV1EdO5CLonZ0eCR6XPh?=
 =?us-ascii?Q?4XnBNQ6UB94q4UCnkcF8kPzRQslzcUpTkwMwF1g482s+uy3LTGzqBuxcfyK2?=
 =?us-ascii?Q?bkq2Fl6c/JB91+3KOJglXtFOSwofbhJLbNZmoXwNAL1DA/NtEzQqr8z6wCU6?=
 =?us-ascii?Q?mGYlvgF8A8XOMxy+IJ+4d4BoKT/uTb1Bwy8uLLWBvalxcvnCxxVYIOknfwCG?=
 =?us-ascii?Q?mvT6TAEd1aU4KIQKKgY83yLjWh6BZ1kz9Iett9GRpLugagzu9XSCxFEiPgpw?=
 =?us-ascii?Q?MaDp71mefLsp1w7xSSd19TBWEBUjqn+Uiik0ZKUfSZwpQf+3vt7qLV+icbRS?=
 =?us-ascii?Q?XTG6DwiqFymYrQxZin7wcdyc8+RKrzVYunkqsapGsAJh/c3ptAr1SqJ2fFEc?=
 =?us-ascii?Q?mvqOM3Dv6cvrUo4b/o73YUI1MzrLSVJsS/rTRsOAdoQ+3o/a/6ncqEOTQ76m?=
 =?us-ascii?Q?6otUpaXEj5totmosvUrIkg9LlFiv6vjLn55Zn9ONBs0cbsuS0toSeFSLqFWB?=
 =?us-ascii?Q?bppO8/495b/ioT6d1INmU6ondQzBmCP+q5GxdpCjC1/Xv8mazbunbdQkuhfQ?=
 =?us-ascii?Q?X1WKOtouIJ+xa6Duy6pnUcTCrUNMdZ/55AJ2JoNdTU+SN2QApyjmR4DxsWAg?=
 =?us-ascii?Q?YbK4UwPe30wO+7vkqiRytDJu7ufU0gG/IVa8Nwj+0jkMO8krbhDBVwjygIV8?=
 =?us-ascii?Q?6RDldedB5zgjVwb1t/4XOocNWSK8qIccJHz1zTElrZHT7wuQjHunFqAV5/HM?=
 =?us-ascii?Q?mylaXvDcYrDIaa5jpN7PuMhG2RKE4LZwQP2TNK2Not0NLJqrGrVonnETI6c1?=
 =?us-ascii?Q?iT7vDg6M62kQI/RfrNlWc5GK+Ow0kqEDIPEcFwcDxprkQXRt7xKK1ClBO7jF?=
 =?us-ascii?Q?pTkjVIro447orZz94wgVkjVN?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d558f8b1-dffa-49b9-182d-08d931a9d14b
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:08.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1/StEQw361vqB0oE6OT+MGzs5X8iWb3hPMpeN7bYVfTz0DDZB38M3kFt15TH4C6gKiSfI1K1zawUjU1XUxbyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1075
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/traffic.h | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.h

diff --git a/drivers/net/wireless/celeno/cl8k/traffic.h b/drivers/net/wirel=
ess/celeno/cl8k/traffic.h
new file mode 100644
index 000000000000..810bec60647d
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/traffic.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_TRAFFIC_H
+#define CL_TRAFFIC_H
+
+#include "vendor_cmd.h"
+
+enum cl_traffic_direction {
+       TRAFFIC_DIRECTION_TX,
+       TRAFFIC_DIRECTION_RX,
+
+       TRAFFIC_DIRECTION_MAX
+};
+
+enum cl_traffic_level {
+       TRAFFIC_LEVEL_DRV,
+       TRAFFIC_LEVEL_BF,
+       TRAFFIC_LEVEL_EDCA,
+       TRAFFIC_LEVEL_DFS,
+
+       TRAFFIC_LEVEL_MAX
+};
+
+struct cl_traffic_activity {
+       u8 cntr_active;
+       u8 cntr_idle;
+       bool is_active;
+};
+
+struct cl_traffic_sta {
+       struct cl_traffic_activity activity_db[TRAFFIC_LEVEL_MAX];
+       u32 num_bytes;
+};
+
+struct cl_traffic_main {
+       u32 num_active_sta[TRAFFIC_LEVEL_MAX];
+       u32 num_active_sta_dir[TRAFFIC_DIRECTION_MAX][TRAFFIC_LEVEL_MAX];
+       u32 active_bytes_thr[TRAFFIC_LEVEL_MAX];
+       bool dynamic_cts;
+};
+
+struct cl_hw;
+struct cl_sta;
+
+void cl_traffic_init(struct cl_hw *cl_hw);
+void cl_traffic_tx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32=
 num_bytes);
+void cl_traffic_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32=
 num_bytes);
+void cl_traffic_maintenance(struct cl_hw *cl_hw);
+void cl_traffic_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_traffic_is_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta);
+bool cl_traffic_is_sta_active_tx(struct cl_hw *cl_hw, struct cl_sta *cl_st=
a);
+u32 cl_traffic_num_active_sta(struct cl_hw *cl_hw);
+u32 cl_traffic_num_active_dfs(struct cl_hw *cl_hw);
+int cl_traffic_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_TRAFFIC_H */
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

