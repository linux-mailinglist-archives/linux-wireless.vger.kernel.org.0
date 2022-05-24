Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7111F532994
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbiEXLlu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiEXLls (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:48 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00041.outbound.protection.outlook.com [40.107.0.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C038B219E
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZvnQY60o5dNTN3BZSHnwjwsHKaM/51dekGohu1WrKdr7y9zSlXrpyhPFGENkZBV9JiSkbQfi3RMNzXbVhw/VJT/8z69f5CSLDyLnOdyoZLW/S/md8EIXtqawtQjqWTuHCRdIBM8kVBtx0Bp8NYDK5IAPAKuyPDGexlVnaN9dE/AmKvi7UCVZu9dpxcPWWSoAyV0HRx66l6YZiCMkia2+QnCOa7/Xtc//85aKB7NDc9+ivXaLcK7UQHYLZZkCWG8V8Hz4pdJnqjYHNBBbzA+LZs8lcaCKcMKqNP9IAFGF/AWdtN1wI9X2Fqm9eDBbC4ltAFNCM1F9WrVfJ0dJTQ8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p29A1K8b151fDW3Y4UfHqvIbDkZNU1nwQmdlhtvtRPk=;
 b=EMx4MYLS5v32fbsMcYFCYFHWEoZK48wyFy8NmmfDT4kw8vfl+QFQJz+4Gx9k/5rL2E3MW8M+WCibehDLRKxnP72X5yyZ2xCaOXTz+tPx36rtLYxwbBt2Au1h7S72nUxsm+0FswkLB8YWxjr7w5wMtJp/Y2R2o8/mP3VScH8PFsgSOPF8sGwhWdsBd6BHmQp5D8EIBzWYrJ/Xzn5EH4q7byWMj7/n9V2FC9+TPcdtWnWGImX0JQnwa4Okswy7kwjvlaMpe98EkQDJFi08nkJj1ESaLX4/LPJEsoMgOZ9zh8HikPW91zRwwaWp7xj+Qo30ZSFr08oG32d1ki7YCiUDwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p29A1K8b151fDW3Y4UfHqvIbDkZNU1nwQmdlhtvtRPk=;
 b=yRN/QKv0S2ylzekigYtyvO9PSuOc7pcjdDFSQ7oqzUwd64k6sNPoIOiYYusEDgpy1mhXBleeOuOkFRZQs5L4noVkYH90knG5B32vB5yWfrCjcXuGRbb3xsoLHDvCGHhcCeEadHhxtNyVHQO/p1qNcm/ihry81v+17QU2hLKWh98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DBAP192MB1033.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:1b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:40:06 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:40:06 +0000
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
Subject: [RFC v2 94/96] cl8k: add wrs.c
Date:   Tue, 24 May 2022 14:35:00 +0300
Message-Id: <20220524113502.1094459-95-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1fb7b295-35a3-48c9-1503-08da3d7a0185
X-MS-TrafficTypeDiagnostic: DBAP192MB1033:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DBAP192MB1033F66DE8D3F9A006EDBF76F6D79@DBAP192MB1033.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z224LvELBOdftG6bXEIJwAxXe+5sYOdWPdJSRaRLxbx9n7VjX0To0e93DzEWNhcyIiVMYyV2mXy5gEbe5CXixV0Mwn5hca3gnh/u4KgmtjdRtFgjgKq9aYKahQxUVpAzISjhSmkgdTb10iysG/IjW+ncZiHrQdPVxuVGkGsLdONpFAlOWLC+hT/jQCqv8UJoUwTjvg/urfTKd8ZlVaBjCt7ur7HUlvciLmCd59UaMgmanthF4Fh9hL9hXvyCmqPwifTxurcPFGD7g+R46AZEJCaB12Xn+2pYQ+tNeOBN7T2ICxN16lNY97YhBmq36OoXovApoZ0Ul8KFC4aFUpE18kj2jlEWmgWbabjOX2sKhiuYA25ex3uVnQBfNLqn+PPp1befkQSgiLrVURS8d38le5jq0ZBcjdEpVGXgTDJYIQTVwttSDJ3hdce0NeLU+u5YEQErBQ+/abxDGwgdKKm3j+jGC771dmUvTsyeJ9ELvo5W2cctKCwjX6/7ranGvVaOF+gGPMJJnX8GM0pbBcHVIa3H5eOIvDU2fwIHy9NLK1wfyOp+9IZwNz/j3yCrDl0fHyslPAh2IcNeuRLvh8tbKr9+rlQCaGTi6IlaromgeodPnUMn3nQdrG+YxcIw7o5OtesszXjbkhjzytUyJHkwp5eV/uPkzK3fRlaDdAICizHom/pG4oh2SqyeooB3wB70l84xXqiwJzkkN3Mxl17Bj5AbBZckFl85pVADaQTSs/9lPHzF2+Wf2sNSocHeqQ6p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(376002)(366004)(136003)(396003)(39850400004)(2906002)(4326008)(6916009)(38350700002)(8676002)(86362001)(316002)(54906003)(38100700002)(66476007)(66556008)(26005)(2616005)(52116002)(9686003)(36756003)(6486002)(66946007)(6512007)(6506007)(30864003)(107886003)(5660300002)(508600001)(83380400001)(8936002)(186003)(1076003)(41300700001)(6666004)(32563001)(579004)(559001)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/RUopYF8I0V8ytm/MXXNwiqfq2rhTV4J1b4pI/Hpp4Jx7Bt/pNDetTNeQcP?=
 =?us-ascii?Q?qzctivOjUkrMvzYf7XB7FjTOY4GzIvkiFHYHd9FDnrqHB25BnVK17JMPkoYH?=
 =?us-ascii?Q?NNLXjXeegFnst8tiD4FuSWQfXvn6RjvakJJ5QMFFaCpd2uIyQRI0RhsefzKM?=
 =?us-ascii?Q?KAjbvnhkJYULFaW+ahBAfi07Yl4RekVsDKw5E8znsZYh2XCpTY3EF8cpR85h?=
 =?us-ascii?Q?ZL0m0hVxakilft/rYd0HGBujU7sPidTsVsrWxD/hdXh5OnYBP1iqVqgwHAo/?=
 =?us-ascii?Q?oy2w8MVoTXO2TI1O4w1T28hARkgY3m6Xk8kMKNvtR3Xevz7FehJlmfrm0T9i?=
 =?us-ascii?Q?AxC75U/KHeMRyDEEQ1Gzx8koRH61lqGXbRVuaVbfiv4hmq3gnGRoB512taPd?=
 =?us-ascii?Q?4Ai/sK7LptHErpomElneKwEkKQ3q2WnEEPQA+E0o017M12l2kfbDySIDtTHl?=
 =?us-ascii?Q?gWpjTrTGICY2YsIPh1MNmBU+K44RZt9Z2bs1nxewaRKB6BIben1vDNn9KRlp?=
 =?us-ascii?Q?7Zz7W0j5cWn2G6CD+0cWKJt+J3pALEmp6WJIB5T3WylJ/YjyW0JzVWvOhDw0?=
 =?us-ascii?Q?HJs92LxuNo8dCZa7xVLsjRBO19sT72AR4PouqoxHqczZIoDW/VAnpsV1hwNV?=
 =?us-ascii?Q?rhGkkgFJt76TMKiLl8ztryjLAt6tb9GvA/KDrmLolyyccMF25yVma8CtPgCv?=
 =?us-ascii?Q?t06aMS/5n7CnvTL9VF7XivTEWiMe4YAo3CLc+B55A9WCoDxtvC2sZIO6kd2e?=
 =?us-ascii?Q?Ta/I/tFFdGlpYqEg21ZJv4WtZ5L85twJ6ICU565hknjwx4kgs0Z49eaNXCyU?=
 =?us-ascii?Q?gnDGPfxeliigmmXiROYl5OC+SmAdrAW8oRJFHXw4vfxoXgHNXv72cxLQGHHx?=
 =?us-ascii?Q?Jz0i/R2lWlMrf83jNRaMK+RSI4Yj8MnP2rEglUhjd7T9+LWichv/yrXI4Wj2?=
 =?us-ascii?Q?/XVK937HU7SXQ2IoEA0Dqu1tndoVdHOO3p6EnC3Sds2iMC/TqtW5ivy7MnEF?=
 =?us-ascii?Q?lQdS7oSPqcQyoU75x9GVk9B22DneWYRa6rnRCYj+drWslP8EoWdpA5vSuFMi?=
 =?us-ascii?Q?Qg/hpKE4/aLSZs7mLVKL2hMWZ3TvnskaLjxeYybYWwI8xcDfljlicwZopsJ6?=
 =?us-ascii?Q?tYLqUFRR9Z6/q5VwJCstakyYMRQDGNiycVFWxTaogWWNSQhO9ba1sRltiBQc?=
 =?us-ascii?Q?qPl541MeCpmhaereHzwmAmdroOmLB9TrOfeBntAhs9U9ROd07Ja9sWSo1klp?=
 =?us-ascii?Q?ceEf5Pc7SLqDFIOi2yDHCdXll+1Z3GlQRKQmMhg9I87svjInZy+HAuQ5AYpM?=
 =?us-ascii?Q?JinWt+AknhVQlSOoJYnDTkUtTVYsqUWW94vMEQSbXGFKDXwYaBW9beSC/MTe?=
 =?us-ascii?Q?O5zey0wGZ63DlkvN4Iqhmt5yd4QCeICwHBmAhYa9G3/dq+8pMP3ynJ7ixxsB?=
 =?us-ascii?Q?xs++bnM8xS4rxZTAKei+BKzwIKAaJvFDlJiMAHPPzR1PDBMwHt+TI2FUaXzh?=
 =?us-ascii?Q?Qidod4NKRlBVIfaHk/Shn+TKQ1XeBNyspf3rmPCP/cqMyeQEsyNI1HFzfv91?=
 =?us-ascii?Q?jZ9jnJ+aawqlw2xrNgVhDYoPwR24M0K3G0qXlxJu1fybOfUlZhVMGm7f656G?=
 =?us-ascii?Q?kzVk7Suz0oJiBhzY+jwg/me7qcNhUaxcfq3HY8h3iJTn+ccb8gWDk8pR7/cA?=
 =?us-ascii?Q?27Krad04d7P3u1Xz/RP8cIsOs7BrUiZByZFfDiuWlM38GFdQQxXqjWiDg3lo?=
 =?us-ascii?Q?0UTnQq5h43ytRZpeVrELbAfSt1jFvAE=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb7b295-35a3-48c9-1503-08da3d7a0185
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:05.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vmlRxamBhtHhnSDlZDGt7w8jckffmpl9SpguUZkJVg98F/wAWRn6QYmYI7g89qs2JUWJtnfLqtFzS4/A065Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP192MB1033
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
 drivers/net/wireless/celeno/cl8k/wrs.c | 3323 ++++++++++++++++++++++++
 1 file changed, 3323 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/wrs.c

diff --git a/drivers/net/wireless/celeno/cl8k/wrs.c b/drivers/net/wireless/celeno/cl8k/wrs.c
new file mode 100644
index 000000000000..9f6b0d8154da
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/wrs.c
@@ -0,0 +1,3323 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/kernel.h>
+
+#include "rates.h"
+#include "chip.h"
+#include "utils.h"
+#include "hw.h"
+#include "reg/reg_defs.h"
+#include "debug.h"
+#include "radio.h"
+#include "wrs.h"
+
+#define wrs_pr(wrs_db, level, ...) \
+	do { \
+		if ((level) <= (wrs_db)->debug_level) \
+			pr_debug("[WRS]" __VA_ARGS__); \
+	} while (0)
+
+#define wrs_pr_verbose(wrs_db, ...) wrs_pr(wrs_db, DBG_LVL_VERBOSE, ##__VA_ARGS__)
+#define wrs_pr_err(wrs_db, ...)     wrs_pr(wrs_db, DBG_LVL_ERROR, ##__VA_ARGS__)
+#define wrs_pr_warn(wrs_db, ...)    wrs_pr(wrs_db, DBG_LVL_WARNING, ##__VA_ARGS__)
+#define wrs_pr_trace(wrs_db, ...)   wrs_pr(wrs_db, DBG_LVL_TRACE, ##__VA_ARGS__)
+#define wrs_pr_info(wrs_db, ...)    wrs_pr(wrs_db, DBG_LVL_INFO, ##__VA_ARGS__)
+
+#define WRS_LOGGER wrs_params->logger[wrs_params->logger_idx]
+
+static void cl_wrs_reset_params_cntrs(struct cl_wrs_params *wrs_params)
+{
+	wrs_params->frames_total = 0;
+	wrs_params->fail_total = 0;
+	wrs_params->ba_not_rcv_total = 0;
+	wrs_params->epr_acc = 0;
+	wrs_params->up_same_time_cnt = 0;
+	wrs_params->down_time_cnt = 0;
+}
+
+static bool cl_wrs_down_epr_check(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+				  struct cl_wrs_params *wrs_params, u8 drop_factor,
+				  enum cl_wrs_decision decision)
+{
+	u16 curr_rate_idx = wrs_params->rate_idx;
+	struct cl_wrs_table *curr_rate = &wrs_params->table[curr_rate_idx];
+	u64 curr_epr_acc = curr_rate->epr_acc;
+	u32 curr_total = curr_rate->frames_total;
+	u16 down_rate_idx = curr_rate->rate_down.rate_idx;
+	struct cl_wrs_table *down_rate = &wrs_params->table[down_rate_idx];
+	u64 down_epr_acc = down_rate->epr_acc;
+	u32 down_total = down_rate->frames_total;
+	u16 down_data_rate = 0;
+	u64 condition1 = 0, condition2 = 0;
+	bool down_decision = false, allow_penalty = true;
+
+	if (wrs_params->calc_ba_not_rcv) {
+		curr_total += curr_rate->ba_not_rcv_total;
+		down_total += down_rate->ba_not_rcv_total;
+	}
+
+	/*
+	 * In the EPR of down candidate is better than or equal to current EPR => return true
+	 *
+	 * (1) curr_epr <= down_epr * factor(%)
+	 *
+	 *       curr_epr_acc     down_epr_acc     factor
+	 * (2)  -------------- <= -------------- * --------
+	 *        curr_total       down_total       100
+	 *
+	 * (3) curr_epr_acc * down_total * 100 <= down_epr_acc * curr_total * factor
+	 *
+	 * (4) conditation1 <= conditation2
+	 *                                                         down_epr_acc
+	 * If (down_total == 0) we use down_data_rate instead of: --------------
+	 *                                                          down_total
+	 */
+	if (down_total) {
+		condition1 = curr_epr_acc * down_total * 100;
+		condition2 = down_epr_acc * curr_total * drop_factor;
+	} else {
+		down_data_rate = cl_data_rates_get_x10(wrs_params->rate_params.mode,
+						       down_rate->rate.bw,
+						       down_rate->rate.nss,
+						       down_rate->rate.mcs,
+						       down_rate->rate.gi);
+
+		condition1 = curr_epr_acc * 100;
+		condition2 = (u64)down_data_rate * curr_total * drop_factor;
+		allow_penalty = false;
+	}
+
+	wrs_params->penalty_decision_dn = wrs_db->step_down;
+
+	if (condition2 && condition1 <= condition2) {
+		down_decision = true;
+
+		if (allow_penalty) {
+			/*
+			 * The penalty is calculated as follow:
+			 *
+			 * penalty = MAX_STEP * penalty_factor
+			 *                                      epr_curr
+			 * penalty = MAX_STEP * (100% - 100% * ----------)
+			 *                                      epr_down
+			 *
+			 *                                    conditation1
+			 * penalty = MAX_STEP * (100% - 100% --------------)
+			 *                                    conditation2
+			 */
+
+			u64 penalty_factor = 100 - div64_u64(condition1 * 100, condition2);
+			u16 max_step = wrs_db->time_th_max_up - wrs_db->step_down;
+
+			wrs_params->penalty_decision_dn +=
+				div64_u64(max_step * penalty_factor, 100);
+		}
+
+		if (decision != WRS_DECISION_SAME)
+			wrs_pr_info(wrs_db,
+				    "[%s] EPR check: sta = %u, pkt_curr = %u, "
+				    "pkt_down = %u, epr_curr = %llu, epr_down * %u%% = %llu, "
+				    "penalty = %u\n",
+				    WRS_TYPE_STR(wrs_params->type),
+				    wrs_sta->sta_idx,
+				    curr_total,
+				    down_total,
+				    div64_u64(curr_epr_acc, curr_total * 10),
+				    drop_factor,
+				    down_total ?
+				    div64_u64(down_epr_acc * drop_factor, down_total * 1000) :
+				    (down_data_rate / 10),
+				    wrs_params->penalty_decision_dn);
+	}
+
+	if (wrs_params->is_logger_en && down_decision) {
+		WRS_LOGGER.curr_epr = (u16)div64_u64(curr_epr_acc, 10 * curr_total);
+		WRS_LOGGER.down_epr = down_total ?
+			(u16)div64_u64(down_epr_acc, down_total * 10) : (down_data_rate / 10),
+		WRS_LOGGER.down_epr_factorized = WRS_LOGGER.down_epr * drop_factor / 100;
+		WRS_LOGGER.penalty = wrs_params->penalty_decision_dn;
+	}
+
+	return down_decision;
+}
+
+static void cl_wrs_time_thr_max_handler(struct cl_wrs_db *wrs_db,
+					struct cl_wrs_table *table, u8 up_idx)
+{
+	/*
+	 * Check if there are at least two UP rates,
+	 * and all UP rates reached max time threshold
+	 */
+	u8 i = 0;
+	u8 time_th_max = 0;
+
+	for (i = 0; i < WRS_TABLE_NODE_UP_MAX; i++) {
+		if (table->rate_up[i].rate_idx == WRS_INVALID_RATE)
+			continue;
+
+		if (table->rate_up[i].time_th != wrs_db->time_th_max_up)
+			return;
+
+		time_th_max++;
+	}
+
+	if (time_th_max < 2)
+		return;
+
+	/* Find the next max rate, and decrease its time threshold by 1 */
+	i = 0;
+	while (i < WRS_TABLE_NODE_UP_MAX) {
+		up_idx++;
+		if (up_idx == WRS_TABLE_NODE_UP_MAX)
+			up_idx = WRS_TABLE_NODE_UP_MCS;
+
+		if (table->rate_up[up_idx].rate_idx != WRS_INVALID_RATE) {
+			/*
+			 * If all up rates reached max time threshold,the first up
+			 * rate will always be selected.
+			 * To overcome it, we decrease the time threshold of the next
+			 * up rate by 1 (so it will be samller and selected next time)
+			 */
+			table->rate_up[up_idx].time_th--;
+			break;
+		}
+
+		i++;
+	}
+}
+
+static bool cl_wrs_find_up_candidate(struct cl_wrs_db *wrs_db, struct cl_wrs_params *wrs_params,
+				     u16 *up_rate_idx, u32 *up_time_th)
+{
+	bool up_rate_valid = false;
+	u8 up_idx = 0;
+	u8 up_candidate = 0;
+	u16 rate_idx = 0;
+	struct cl_wrs_table *table = &wrs_params->table[wrs_params->rate_idx];
+
+	*up_rate_idx = WRS_INVALID_RATE;
+	*up_time_th = U32_MAX;
+
+	for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+		rate_idx = table->rate_up[up_idx].rate_idx;
+
+		if (rate_idx == WRS_INVALID_RATE)
+			continue;
+
+		if (wrs_db->quick_up_en && table->rate_up[up_idx].quick_up_check) {
+			*up_rate_idx = rate_idx;
+			*up_time_th = wrs_db->quick_up_interval;
+			up_rate_valid = true;
+			up_candidate = up_idx;
+			break;
+		} else if (table->rate_up[up_idx].time_th < *up_time_th) {
+			*up_rate_idx = rate_idx;
+			*up_time_th = table->rate_up[up_idx].time_th;
+			up_rate_valid = true;
+			up_candidate = up_idx;
+		}
+	}
+
+	if (wrs_db->time_th_max_up == *up_time_th)
+		cl_wrs_time_thr_max_handler(wrs_db, table, up_candidate);
+
+	return up_rate_valid;
+}
+
+static bool cl_wrs_epr_immeidate_down(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+				      struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+				      u16 down_rate_idx)
+{
+	if (cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+				  wrs_db->immediate_drop_epr_factor,
+				  WRS_DECISION_DOWN_IMMEDIATE)) {
+		/*
+		 * If there are several immediate drops in a row ignore them,
+		 * because it is probably not realted to bad TX rate
+		 */
+		wrs_params->immediate_drop_cntr++;
+
+		if (wrs_params->immediate_drop_cntr > wrs_db->immediate_drop_max_in_row) {
+			wrs_params->immediate_drop_ignore++;
+
+			cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+			cl_wrs_reset_params_cntrs(wrs_params);
+
+			wrs_pr_info(wrs_db,
+				    "[%s] sta %u - ignore immediate down decision (cntr=%u)\n",
+				    WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx,
+				    wrs_params->immediate_drop_cntr);
+			return true;
+		}
+
+		cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+				     WRS_DECISION_DOWN_IMMEDIATE, down_rate_idx);
+		return true;
+	}
+
+	return false;
+}
+
+static void cl_wrs_decision_up(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			       struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			       u16 up_rate_idx, u32 up_th)
+{
+	enum cl_wrs_decision up_decision = (up_th == wrs_db->quick_up_interval) ?
+		WRS_DECISION_UP_QUICK : WRS_DECISION_UP;
+
+	if (wrs_params->is_logger_en)
+		WRS_LOGGER.up_time = wrs_params->up_same_time_cnt;
+
+	cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params, up_decision, up_rate_idx);
+}
+
+static void cl_wrs_decision_same(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+				 struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+				 u16 rate_idx)
+{
+	cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params, WRS_DECISION_SAME, rate_idx);
+}
+
+static void cl_wrs_epr_decision(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+				struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	u16 curr_rate_idx = wrs_params->rate_idx;
+	struct cl_wrs_table *table = &wrs_params->table[curr_rate_idx];
+	u16 down_rate_idx = table->rate_down.rate_idx;
+	u16 up_rate_idx = 0;
+	u16 down_th = table->rate_down.time_th;
+	u32 up_th = 0;
+	bool up_rate_valid = false;
+
+	/* Check if we transmitted enough frames for taking decision */
+	if ((wrs_params->frames_total + wrs_params->ba_not_rcv_total) <
+	    wrs_db->min_frames_for_decision)
+		return;
+
+	if (wrs_params->is_logger_en) {
+		WRS_LOGGER.timestamp = jiffies_to_msecs(jiffies);
+		WRS_LOGGER.rate_idx = wrs_params->rate_idx;
+		WRS_LOGGER.success = wrs_params->frames_total - wrs_params->fail_total;
+		WRS_LOGGER.fail = wrs_params->fail_total;
+		WRS_LOGGER.ba_not_rcv = wrs_params->ba_not_rcv_total;
+	}
+
+	up_rate_valid = cl_wrs_find_up_candidate(wrs_db, wrs_params, &up_rate_idx, &up_th);
+
+	/* RSSI protect */
+	if (!WRS_TYPE_IS_TX_MU_MIMO(wrs_params) && wrs_db->rssi_protect_en)
+		if (cl_wrs_rssi_prot_decision(cl_hw, wrs_db, wrs_sta, wrs_params,
+					      up_rate_valid, up_rate_idx, down_rate_idx))
+			return;
+
+	if (down_rate_idx != curr_rate_idx) {
+		/* Down immediate */
+		if (wrs_db->immediate_drop_en)
+			if (cl_wrs_epr_immeidate_down(cl_hw, wrs_db, wrs_sta,
+						      wrs_params, down_rate_idx))
+				return;
+
+		/* Down */
+		if (wrs_params->down_time_cnt >= down_th) {
+			if (cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+						  wrs_db->epr_factor, WRS_DECISION_DOWN)) {
+				cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+						     WRS_DECISION_DOWN, down_rate_idx);
+				return;
+			}
+
+			wrs_params->down_time_cnt = 0;
+		}
+	}
+
+	/* Up-same */
+	if (wrs_params->up_same_time_cnt >= up_th) {
+		if (up_rate_valid)
+			cl_wrs_decision_up(cl_hw, wrs_db, wrs_sta, wrs_params, up_rate_idx, up_th);
+		else
+			cl_wrs_decision_same(cl_hw, wrs_db, wrs_sta, wrs_params, curr_rate_idx);
+
+		return;
+	}
+
+	/*
+	 * If there is no valid UP rate and the EPR is more
+	 * than EPR down threshold => make a same decision
+	 */
+	if (!up_rate_valid &&
+	    !cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+				   wrs_db->epr_factor, WRS_DECISION_SAME))
+		cl_wrs_decision_same(cl_hw, wrs_db, wrs_sta, wrs_params, curr_rate_idx);
+}
+
+static void cl_wrs_divide_weights_by_two(struct cl_wrs_table *table_node)
+{
+	u8 up_idx = 0;
+	struct cl_wrs_table_node *rate_up;
+
+	/*
+	 * Converge weights - divide all weights by 2
+	 * (make sure they do not go below their init value)
+	 */
+	if (table_node->rate_down.rate_idx != WRS_INVALID_RATE)
+		table_node->rate_down.time_th = max(table_node->rate_down.time_th >> 1,
+						    WRS_INIT_MSEC_WEIGHT_DOWN);
+
+	for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+		rate_up = &table_node->rate_up[up_idx];
+
+		if (rate_up->rate_idx != WRS_INVALID_RATE)
+			rate_up->time_th = max(rate_up->time_th >> 1, WRS_INIT_MSEC_WEIGHT_UP);
+
+		if (rate_up->time_th == WRS_INIT_MSEC_WEIGHT_UP)
+			rate_up->quick_up_check = false;
+	}
+}
+
+static void cl_wrs_converge_weights(struct cl_wrs_params *wrs_params)
+{
+	/*
+	 * Converge weights - divide the weights by 2 (except for the current rate),
+	 * and reset PER counters (except for current rate, down rate, and down-down rate).
+	 */
+	u16 i;
+	u16 curr_idx = wrs_params->rate_idx;
+	u16 down_idx = wrs_params->table[curr_idx].rate_down.rate_idx;
+	u16 down2_idx = wrs_params->table[down_idx].rate_down.rate_idx;
+
+	for (i = 0; i < wrs_params->table_size; i++) {
+		if (i == curr_idx)
+			continue;
+
+		cl_wrs_divide_weights_by_two(&wrs_params->table[i]);
+
+		if (i != down_idx && i != down2_idx) {
+			wrs_params->table[i].frames_total = 0;
+			wrs_params->table[i].ba_not_rcv_total = 0;
+			wrs_params->table[i].epr_acc = 0;
+		}
+	}
+}
+
+static void cl_wrs_converge_weights_idle_decision(struct cl_hw *cl_hw,
+						  struct cl_wrs_db *wrs_db,
+						  struct cl_wrs_sta *wrs_sta,
+						  struct cl_wrs_params *wrs_params)
+{
+	/*
+	 * Continue normal converge (just like during traffic).
+	 * After 6 seconds reset table, and select rate based on RSSI.
+	 */
+	if (!wrs_db->converge_idle_en)
+		return;
+
+	wrs_params->converge_time_idle += wrs_db->interval;
+
+	if (wrs_params->converge_mode == WRS_CONVERGE_MODE_RESET) {
+		if (wrs_params->converge_time_idle < wrs_db->converge_idle_interval_reset) {
+			cl_wrs_converge_weights(wrs_params);
+		} else {
+			wrs_params->converge_mode = WRS_CONVERGE_MODE_RSSI;
+			wrs_params->converge_time_idle = 0;
+
+			wrs_pr_info(wrs_db, "[%s] Converge weights: sta %u - RSSI\n",
+				    WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx);
+
+			/* Reset table and choose new rate based on RSSI */
+			cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+
+			if (!WRS_TYPE_IS_TX_MU_MIMO(wrs_params))
+				cl_wrs_set_rate_idle(cl_hw, wrs_db, wrs_sta, wrs_params);
+		}
+	} else {
+		if (wrs_params->converge_time_idle < wrs_db->converge_idle_interval_rssi)
+			return;
+
+		/* Choose new rate */
+		if (!WRS_TYPE_IS_TX_MU_MIMO(wrs_params)) {
+			wrs_params->converge_time_idle = 0;
+			cl_wrs_set_rate_idle(cl_hw, wrs_db, wrs_sta, wrs_params);
+		}
+	}
+}
+
+static void cl_wrs_converge_weights_idle_reset(struct cl_wrs_db *wrs_db,
+					       struct cl_wrs_sta *wrs_sta,
+					       struct cl_wrs_params *wrs_params)
+{
+	/* There was traffic in last maintenance interval - reset converge parameteres */
+	wrs_params->converge_time_idle = 0;
+
+	if (wrs_params->converge_mode != WRS_CONVERGE_MODE_RESET) {
+		wrs_params->converge_mode = WRS_CONVERGE_MODE_RESET;
+		wrs_pr_info(wrs_db, "[%s] Converge weights: sta %u - RESET\n",
+			    WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx);
+	}
+}
+
+static void cl_wrs_converge_weights_trfc_decision(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+						  struct cl_wrs_db *wrs_db,
+						  struct cl_wrs_params *wrs_params)
+{
+	u32 converge_interval = 0;
+
+	if (!wrs_db->converge_trfc_en)
+		return;
+
+	converge_interval = wrs_db->converge_trfc_interval_static;
+
+	if (!cl_motion_sense_is_static(cl_hw, cl_sta))
+		converge_interval = wrs_db->converge_trfc_interval_motion;
+
+	wrs_params->converge_time_trfc += wrs_db->interval;
+
+	if (wrs_params->converge_time_trfc >= converge_interval) {
+		wrs_params->converge_time_trfc = 0;
+		cl_wrs_converge_weights(wrs_params);
+	}
+}
+
+static u32 cl_wrs_get_sync_attempts(struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+	struct cl_wrs_info *wrs_info = cl_wrs_info_get(cl_sta, wrs_params->type);
+
+	return wrs_info->sync_attempts;
+}
+
+static void cl_wrs_sta_no_sync_handler(struct cl_hw *cl_hw,
+				       struct cl_wrs_db *wrs_db,
+				       struct cl_wrs_sta *wrs_sta,
+				       struct cl_wrs_params *wrs_params)
+{
+	unsigned long time_delta = jiffies_to_msecs(jiffies - wrs_params->no_sync_timestamp);
+
+	if (time_delta < wrs_db->sync_timeout)
+		return;
+
+	if (cl_wrs_get_sync_attempts(wrs_sta, wrs_params) < wrs_db->sync_min_attempts) {
+		/*
+		 * Rate not synced but there is also hardly no traffic -
+		 * change mode to synced!
+		 */
+		wrs_params->sync = true;
+		wrs_params->sync_timestamp = jiffies;
+	} else {
+		struct cl_wrs_table *wrs_table = &wrs_params->table[wrs_params->rate_idx];
+		struct cl_wrs_rate *curr_rate = &wrs_table->rate;
+
+		if (IS_REAL_PHY(cl_hw->chip))
+			wrs_pr_warn(wrs_db,
+				    "[%s] NO SYNC - sta = %u, bw = %u, nss = %u, mcs = %u, gi = %u\n",
+				    WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx, curr_rate->bw,
+				    curr_rate->nss, curr_rate->mcs, curr_rate->gi);
+
+		if (WRS_IS_DECISION_UP(wrs_params->last_decision)) {
+			cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+					     WRS_DECISION_DOWN_NO_SYNC,
+					     wrs_table->rate_down.rate_idx);
+		} else {
+			/* If the last decision was DOWN - change state to SYNCED. */
+			wrs_params->sync = true;
+			wrs_params->sync_timestamp = jiffies;
+		}
+	}
+}
+
+static void cl_wrs_update_ba_not_rcv(struct cl_wrs_db *wrs_db, struct cl_wrs_params *wrs_params)
+{
+	unsigned long time_since_sync = jiffies_to_msecs(jiffies - wrs_params->sync_timestamp);
+
+	wrs_params->calc_ba_not_rcv = (wrs_db->ba_not_rcv_force ||
+				       (time_since_sync < wrs_db->ba_not_rcv_time_since_sync));
+}
+
+static void _cl_wrs_cntrs_reset(struct cl_wrs_info *wrs_info)
+{
+	wrs_info->epr_acc = 0;
+	wrs_info->success = 0;
+	wrs_info->fail = 0;
+	wrs_info->ba_not_rcv = 0;
+	wrs_info->ba_not_rcv_consecutive_max = 0;
+}
+
+static void cl_wrs_cntrs_read(struct cl_wrs_sta *wrs_sta,
+			      struct cl_wrs_cntrs *cntrs,
+			      u8 type)
+{
+	struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+	struct cl_wrs_info *wrs_info = cl_wrs_info_get(cl_sta, type);
+
+	cntrs->epr_acc = wrs_info->epr_acc;
+	cntrs->total = wrs_info->success + wrs_info->fail;
+	cntrs->fail = wrs_info->fail;
+	cntrs->ba_not_rcv = wrs_info->ba_not_rcv;
+	cntrs->ba_not_rcv_consecutive = wrs_info->ba_not_rcv_consecutive_max;
+
+	_cl_wrs_cntrs_reset(wrs_info);
+}
+
+static void _cl_wrs_sta_maintenance(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				    struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	struct cl_wrs_cntrs cntrs = {0};
+
+	if (wrs_params->is_logger_en)
+		memset(&WRS_LOGGER, 0, sizeof(struct cl_wrs_logger));
+
+	if (!wrs_params->sync) {
+		cl_wrs_sta_no_sync_handler(cl_hw, wrs_db, wrs_sta, wrs_params);
+		goto end_logger;
+	}
+
+	if (!WRS_TYPE_IS_RX(wrs_params))
+		cl_wrs_update_ba_not_rcv(wrs_db, wrs_params);
+
+	cl_wrs_cntrs_read(wrs_sta, &cntrs, wrs_params->type);
+
+	if (wrs_params->is_fixed_rate) {
+		cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &cntrs);
+		goto end_logger;
+	}
+
+	wrs_params->down_time_cnt += wrs_db->interval;
+	wrs_params->up_same_time_cnt += wrs_db->interval;
+
+	if ((cntrs.total + cntrs.ba_not_rcv) < wrs_db->converge_idle_packet_th) {
+		/*
+		 * Very few frames were sent in last maintenance interval
+		 * Check if weights should be converged
+		 */
+		cl_wrs_converge_weights_idle_decision(cl_hw, wrs_db, wrs_sta, wrs_params);
+
+		cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &cntrs);
+
+		goto end_logger;
+	} else {
+		/* There was traffic in last maintenance interval - reset converge parameteres */
+		cl_wrs_converge_weights_idle_reset(wrs_db, wrs_sta, wrs_params);
+	}
+
+	cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &cntrs);
+
+	wrs_params->quick_up_check =
+		(cntrs.ba_not_rcv_consecutive >= wrs_db->quick_up_ba_thr);
+	cl_wrs_epr_decision(cl_hw, wrs_db, wrs_sta, wrs_params);
+
+	cl_wrs_converge_weights_trfc_decision(cl_hw, cl_sta, wrs_db, wrs_params);
+
+end_logger:
+	if (wrs_params->is_logger_en && WRS_LOGGER.decision != WRS_DECISION_NONE)
+		wrs_params->logger_idx = WRS_INC_POW2(wrs_params->logger_idx,
+						      wrs_params->logger_size);
+}
+
+static void cl_wrs_sta_maintenance(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	_cl_wrs_sta_maintenance(cl_hw, cl_sta, &cl_sta->wrs_sta.tx_su_params);
+
+	if (cl_sta->wrs_sta.rx_params)
+		_cl_wrs_sta_maintenance(cl_hw, cl_sta, cl_sta->wrs_sta.rx_params);
+}
+
+static void cl_wrs_cca_calc(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, u8 max_bw)
+{
+	u32 cca_primary_new = mac_hw_edca_cca_busy_get(cl_hw);
+	u32 cca_sec80_new = (max_bw > CHNL_BW_80) ? mac_hw_add_cca_busy_sec_80_get(cl_hw) : 0;
+	u32 cca_sec40_new = (max_bw > CHNL_BW_40) ? mac_hw_add_cca_busy_sec_40_get(cl_hw) : 0;
+	u32 cca_sec20_new = mac_hw_add_cca_busy_sec_20_get(cl_hw);
+
+	u32 cca_primary_diff = cca_primary_new - wrs_db->cca_primary;
+	u32 cca_sec80_diff = cca_sec80_new - wrs_db->cca_sec80;
+	u32 cca_sec40_diff = cca_sec40_new - wrs_db->cca_sec40;
+	u32 cca_sec20_diff = cca_sec20_new - wrs_db->cca_sec20;
+
+	wrs_db->cca_primary = cca_primary_new;
+	wrs_db->cca_sec80 = cca_sec80_new;
+	wrs_db->cca_sec40 = cca_sec40_new;
+	wrs_db->cca_sec20 = cca_sec20_new;
+	wrs_db->cca_timestamp = jiffies;
+
+	/* Increase by 25% */
+	cca_primary_diff = cca_primary_diff * WRS_CCA_PRIMARY_FACTOR >> WRS_CCA_PRIMARY_SHIFT;
+
+	/* Adjacent interference - if secondary is higher than primary by 25%. */
+	wrs_db->adjacent_interference80 = (cca_sec80_diff > cca_primary_diff);
+	wrs_db->adjacent_interference40 = (cca_sec40_diff > cca_primary_diff);
+	wrs_db->adjacent_interference20 = (cca_sec20_diff > cca_primary_diff);
+}
+
+static void cl_wrs_cca_maintenance(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db)
+{
+	u8 max_bw = wrs_db->max_cap.bw;
+
+	if (max_bw == CHNL_BW_20)
+		return;
+
+	if (jiffies_to_msecs(jiffies - wrs_db->cca_timestamp) > WRS_CCA_PERIOD_MS)
+		cl_wrs_cca_calc(cl_hw, wrs_db, max_bw);
+}
+
+static void cl_wrs_maintenance(struct timer_list *t)
+{
+	struct cl_wrs_db *wrs_db = from_timer(wrs_db, t, timer_maintenance);
+	struct cl_hw *cl_hw = container_of(wrs_db, struct cl_hw, wrs_db);
+
+	cl_wrs_cca_maintenance(cl_hw, wrs_db);
+
+	cl_wrs_lock(wrs_db);
+	cl_sta_loop(cl_hw, cl_wrs_sta_maintenance);
+	cl_wrs_unlock(wrs_db);
+
+	mod_timer(&wrs_db->timer_maintenance, jiffies + msecs_to_jiffies(wrs_db->interval));
+}
+
+static void cl_wrs_down_decision_weights_update(struct cl_wrs_db *wrs_db,
+						struct cl_wrs_sta *wrs_sta,
+						u16 new_rate_idx,
+						struct cl_wrs_params *wrs_params)
+{
+	u16 old_rate_idx = wrs_params->rate_idx;
+	u8 up_idx = 0;
+	u16 down_th_min = wrs_db->time_th_min;
+	u16 step = wrs_db->step_down;
+	u16 *th_down = &wrs_params->table[old_rate_idx].rate_down.time_th;
+	u16 *th_up = NULL;
+	struct cl_wrs_table *table_node = &wrs_params->table[new_rate_idx];
+
+	/* Decrease the weight from old rate to new rate */
+	if (*th_down > (down_th_min + step))
+		*th_down -= step;
+	else
+		*th_down = down_th_min;
+
+	/* Increase the weight from new rate to old rate */
+	for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+		if (old_rate_idx == table_node->rate_up[up_idx].rate_idx) {
+			th_up = &table_node->rate_up[up_idx].time_th;
+			table_node->rate_up[up_idx].quick_up_check = !!wrs_params->quick_up_check;
+			step = wrs_params->penalty_decision_dn;
+			*th_up = min_t(u16, *th_up + step, wrs_db->time_th_max_up);
+			break;
+		}
+	}
+
+	wrs_pr_info(wrs_db,
+		    "[%s] Down update - sta = %u, "
+		    "down weight [%u-->%u] = %u, up weight [%u-->%u] = %u\n",
+		    WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx, old_rate_idx, new_rate_idx,
+		    *th_down, new_rate_idx, old_rate_idx, th_up ? *th_up : 0);
+}
+
+static void cl_wrs_up_same_decision_weights_update(struct cl_wrs_db *wrs_db,
+						   struct cl_wrs_sta *wrs_sta,
+						   struct cl_wrs_params *wrs_params)
+{
+	u16 curr_rate_idx = wrs_params->rate_idx;
+	u16 down_rate_idx = wrs_params->table[curr_rate_idx].rate_down.rate_idx;
+	u8 up_idx = 0;
+	u16 up_th_min = wrs_db->time_th_min;
+	u16 step = wrs_db->step_up_same;
+	u16 *th_down = &wrs_params->table[curr_rate_idx].rate_down.time_th;
+	u16 *th_up = NULL;
+	u16 th_down_orig = *th_down;
+	u16 th_up_orig = 0;
+	struct cl_wrs_table *table_node = &wrs_params->table[down_rate_idx];
+
+	/* Increase the weight from current rate to down rate */
+	*th_down = min_t(u16, *th_down + step, wrs_db->time_th_max_down);
+
+	/* Decrease the weight from down rate to current rate */
+	for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+		if (curr_rate_idx == table_node->rate_up[up_idx].rate_idx) {
+			th_up = &table_node->rate_up[up_idx].time_th;
+			table_node->rate_up[up_idx].quick_up_check = false;
+
+			th_up_orig = *th_up;
+
+			if (*th_up > (up_th_min + step))
+				*th_up -= step;
+			else
+				*th_up = up_th_min;
+			break;
+		}
+	}
+
+	if (th_up && (th_up_orig != *th_up || th_down_orig != *th_down))
+		wrs_pr_info(wrs_db,
+			    "[%s] Up/same update - sta = %u, "
+			    "down weight [%u-->%u] = %u, up weight [%u-->%u] = %u\n",
+			    WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx, curr_rate_idx,
+			    down_rate_idx, *th_down, down_rate_idx, curr_rate_idx, *th_up);
+}
+
+static bool cl_wrs_is_rate_params_valid(struct cl_wrs_rate *rate_params)
+{
+	return (*(u16 *)rate_params != U16_MAX);
+}
+
+void cl_wrs_init(struct cl_hw *cl_hw)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	/* Default configuration */
+	wrs_db->debug_level = DBG_LVL_ERROR;
+	wrs_db->rssi_protect_en = true;
+	wrs_db->rssi_protect_mode = WRS_RSSI_PROT_MODE_RSSI;
+	wrs_db->rssi_protect_up_thr = WRS_RSSI_PROTECT_UP_THR;
+	wrs_db->rssi_protect_dn_thr = WRS_RSSI_PROTECT_DN_THR;
+	wrs_db->min_frames_for_decision = WRS_MIN_FRAMES_FOR_DECISION;
+	wrs_db->epr_factor = WRS_EPR_FACTOR;
+	wrs_db->converge_idle_en = true;
+	wrs_db->converge_idle_interval_reset = WRS_CONVERGE_IDLE_INTERVAL_RESET;
+	wrs_db->converge_idle_interval_rssi = WRS_CONVERGE_IDLE_INTERVAL_RSSI;
+	wrs_db->converge_idle_packet_th = WRS_CONVERGE_IDLE_PACKET_TH;
+	wrs_db->converge_trfc_en = true;
+	wrs_db->converge_trfc_interval_static = WRS_CONVERGE_TRFC_INTERVAL_STATIC;
+	wrs_db->converge_trfc_interval_motion = WRS_CONVERGE_TRFC_INTERVAL_MOTION;
+	wrs_db->immediate_drop_en = true;
+	wrs_db->immediate_drop_epr_factor = WRS_IMMEDIATE_DROP_EPR_FACTOR;
+	wrs_db->immediate_drop_max_in_row = WRS_IMMEDIATE_DROP_MAX_IN_ROW;
+	wrs_db->time_th_min = WRS_MSEC_WEIGHT_MIN;
+	wrs_db->time_th_max_up = WRS_MSEC_WEIGHT_MAX_UP;
+	wrs_db->time_th_max_down = WRS_MSEC_WEIGHT_MAX_DOWN;
+	wrs_db->step_down = WRS_MSEC_STEP_DOWN;
+	wrs_db->step_up_same = WRS_MSEC_STEP_UP_SAME;
+	wrs_db->interval = msecs_round(WRS_MAINTENANCE_PERIOD_MS);
+	wrs_db->conservative_mcs_noisy_env = false;
+	wrs_db->conservative_nss_noisy_env = false;
+	wrs_db->quick_up_en = true;
+	wrs_db->quick_up_ba_thr = WRS_QUICK_UP_BA_THR;
+	wrs_db->quick_up_interval = msecs_round(WRS_QUICK_UP_INTERVAL_MS);
+	wrs_db->quick_down_en = true;
+	wrs_db->quick_down_epr_factor = WRS_QUICK_DOWN_EPR_FACTOR;
+	wrs_db->quick_down_agg_thr = WRS_QUICK_DOWN_AGG_THR;
+	wrs_db->quick_down_pkt_thr = WRS_QUICK_DOWN_PKT_THR;
+	wrs_db->ba_not_rcv_collision_filter = true;
+	/* Environment of 2.4 is much more noisy, so 'BA not received' are ignored. */
+	wrs_db->ba_not_rcv_force = cl_band_is_24g(cl_hw) ? false : true;
+	wrs_db->ba_not_rcv_time_since_sync = WRS_BA_NOT_RCV_TIME_SINCE_SYNC;
+	wrs_db->sync_timeout = WRS_SYNC_TIMEOUT;
+	wrs_db->sync_min_attempts = WRS_SYNC_MIN_ATTEMPTS;
+
+	/* Init WRS periodic timer */
+	timer_setup(&wrs_db->timer_maintenance, cl_wrs_maintenance, 0);
+
+	if (!cl_hw->chip->conf->ce_production_mode) {
+		wrs_db->cca_timestamp = jiffies;
+		mod_timer(&wrs_db->timer_maintenance,
+			  jiffies + msecs_to_jiffies(wrs_db->interval));
+	}
+
+	spin_lock_init(&wrs_db->lock);
+
+	if ((cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_MODE] != -1) &&
+	    (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_BW] != -1) &&
+	    (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_NSS] != -1) &&
+	    (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_MCS] != -1) &&
+	    (cl_hw->conf->ci_wrs_fixed_rate[WRS_FIXED_PARAM_GI] != -1))
+		wrs_db->is_fixed_rate = WRS_FIXED_FALLBACK_DIS;
+}
+
+inline void cl_wrs_lock_bh(struct cl_wrs_db *wrs_db)
+{
+	spin_lock_bh(&wrs_db->lock);
+}
+
+inline void cl_wrs_unlock_bh(struct cl_wrs_db *wrs_db)
+{
+	spin_unlock_bh(&wrs_db->lock);
+}
+
+inline void cl_wrs_lock(struct cl_wrs_db *wrs_db)
+{
+	spin_lock(&wrs_db->lock);
+}
+
+inline void cl_wrs_unlock(struct cl_wrs_db *wrs_db)
+{
+	spin_unlock(&wrs_db->lock);
+}
+
+void cl_wrs_rate_param_sync(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+			    struct cl_wrs_params *wrs_params)
+{
+	if (wrs_params->sync)
+		return;
+
+	cl_wrs_cntrs_reset(wrs_sta, wrs_params);
+
+	/* Reset counters */
+	cl_wrs_reset_params_cntrs(wrs_params);
+
+	/* Change state to SYNCED */
+	wrs_params->sync = true;
+	wrs_params->sync_timestamp = jiffies;
+
+	wrs_pr_trace(wrs_db, "[%s] Sync - timestamp = %u, sta = %u, rate_idx = %u\n",
+		     WRS_TYPE_STR(wrs_params->type),
+		     jiffies_to_msecs(jiffies),
+		     wrs_sta->sta_idx,
+		     wrs_params->rate_idx);
+}
+
+void cl_wrs_rate_params_update(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			       struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			       u16 new_rate_idx, bool is_sync_required, bool mu_valid)
+{
+	struct cl_wrs_rate_params *rate_params = &wrs_params->rate_params;
+	struct cl_wrs_rate *rate = &wrs_params->table[new_rate_idx].rate;
+	u16 fallback_rate_idx = wrs_params->table[new_rate_idx].rate_down.rate_idx;
+	struct cl_wrs_rate *rate_fallback = &wrs_params->table[fallback_rate_idx].rate;
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+
+	if (!WRS_TYPE_IS_RX(wrs_params)) {
+		struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+
+		cl_dyn_bcast_rate_change(cl_hw, cl_sta, rate_params->mcs, rate->mcs);
+	}
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+
+	rate_params->bw = rate->bw;
+	rate_params->nss = rate->nss;
+	rate_params->mcs = rate->mcs;
+	rate_params->gi = rate->gi;
+	rate_params->mode = wrs_sta->mode;
+	rate_params->fallback_en = (wrs_params->is_fixed_rate != WRS_FIXED_FALLBACK_DIS);
+
+	wrs_pr_trace(wrs_db,
+		     "[%s] Rate params update - "
+		     "sta = %u, rate_idx = %u, bw = %u, nss = %u, mcs = %u, gi = %u\n",
+		     WRS_TYPE_STR(wrs_params->type), wrs_sta->sta_idx,
+		     new_rate_idx, rate_params->bw, rate_params->nss,
+		     rate_params->mcs, rate_params->gi);
+
+	wrs_params->rate_idx = new_rate_idx;
+
+	/* Converge - restart the time for converging weights of all old rates */
+	wrs_params->converge_time_trfc = 0;
+
+	cl_wrs_rate_param_set(cl_hw, wrs_sta, wrs_params, rate_params,
+			      rate_fallback, mu_valid, true);
+
+	if (is_sync_required) {
+		wrs_params->sync = false;
+		wrs_params->no_sync_timestamp = jiffies;
+	} else {
+		wrs_params->sync = true;
+	}
+
+	/* Reset Counters */
+	cl_wrs_reset_params_cntrs(wrs_params);
+}
+
+void cl_wrs_decision_make(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			  enum cl_wrs_decision decision, u16 new_rate_idx)
+{
+	if (WRS_IS_DECISION_DOWN(decision)) {
+		cl_wrs_down_decision_weights_update(wrs_db, wrs_sta, new_rate_idx, wrs_params);
+	} else if (WRS_IS_DECISION_UP(decision)) {
+		cl_wrs_up_same_decision_weights_update(wrs_db, wrs_sta, wrs_params);
+
+		if (wrs_params->rate_idx != wrs_params->table[new_rate_idx].rate_down.rate_idx) {
+			/*
+			 * In case the down rate is different from the previous rate,
+			 * update down rate index and reset the thresholds
+			 */
+			struct cl_wrs_table_node *rate_down =
+				&wrs_params->table[new_rate_idx].rate_down;
+
+			rate_down->rate_idx = wrs_params->rate_idx;
+			rate_down->time_th = WRS_INIT_MSEC_WEIGHT_DOWN;
+		}
+	} else if (decision == WRS_DECISION_SAME) {
+		cl_wrs_up_same_decision_weights_update(wrs_db, wrs_sta, wrs_params);
+
+		/* Reset counters besides down_time_cnt */
+		wrs_params->frames_total = 0;
+		wrs_params->fail_total = 0;
+		wrs_params->ba_not_rcv_total = 0;
+		wrs_params->epr_acc = 0;
+		wrs_params->up_same_time_cnt = 0;
+	}
+
+	cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params, decision, new_rate_idx);
+
+	if (WRS_IS_DECISION_DOWN(decision) || WRS_IS_DECISION_UP(decision))
+		cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+					  new_rate_idx, true, wrs_params->is_mu_valid);
+}
+
+void cl_wrs_decision_update(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+			    struct cl_wrs_params *wrs_params, enum cl_wrs_decision decision,
+			    u16 new_rate_idx)
+{
+	wrs_params->last_decision = decision;
+	wrs_params->decision_cnt[decision]++;
+
+	if (decision != WRS_DECISION_DOWN_IMMEDIATE)
+		wrs_params->immediate_drop_cntr = 0;
+
+	if (wrs_params->is_logger_en) {
+		WRS_LOGGER.decision = decision;
+		WRS_LOGGER.new_rate_idx = new_rate_idx;
+	}
+
+	if (decision == WRS_DECISION_SAME)
+		return;
+
+	wrs_pr_trace(wrs_db,
+		     "[%s] Decision update - timestamp [%u] sta [%u] decision [%s]\n",
+		     WRS_TYPE_STR(wrs_params->type),
+		     jiffies_to_msecs(jiffies),
+		     wrs_sta->sta_idx,
+		     WRS_DECISION_STR(decision));
+}
+
+void cl_wrs_fixed_rate_set(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			   struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params,
+			   u8 is_fixed_rate, u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi, bool mu_valid)
+{
+	u16 rate_idx = 0;
+	u8 type = wrs_params->type;
+
+	if (!is_fixed_rate) {
+		wrs_params->is_fixed_rate = WRS_AUTO_RATE;
+		wrs_pr_verbose(wrs_db, "[%s] Station %u was set to auto rate!\n",
+			       WRS_TYPE_STR(type), wrs_sta->sta_idx);
+		cl_wrs_set_rate_idle(cl_hw, wrs_db, wrs_sta, wrs_params);
+		return;
+	}
+
+	if (mode != wrs_sta->mode) {
+		/* Set fixed rate with a different format-mode */
+		struct cl_wrs_rate_params *rate_params = &wrs_params->rate_params;
+
+		if (cl_band_is_6g(cl_hw) && mode != WRS_MODE_HE) {
+			wrs_pr_verbose(wrs_db, "[%s] Invalid format mode [%u] for 6GHz band\n",
+				       WRS_TYPE_STR(type), mode);
+			return;
+		}
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+
+		if (!WRS_TYPE_IS_RX(wrs_params)) {
+			struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+
+			cl_dyn_bcast_rate_change(cl_hw, cl_sta, rate_params->mcs, mcs);
+		}
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+
+		rate_params->bw = bw;
+		rate_params->nss = nss;
+		rate_params->mcs = mcs;
+		rate_params->gi = gi;
+		rate_params->mode = mode;
+		rate_params->fallback_en = (wrs_params->is_fixed_rate != WRS_FIXED_FALLBACK_DIS);
+
+		wrs_params->is_fixed_rate = is_fixed_rate;
+
+		cl_wrs_rate_param_set(cl_hw, wrs_sta, wrs_params, rate_params,
+				      NULL, mu_valid, true);
+		wrs_pr_verbose(wrs_db,
+			       "[%s] Station %u set to %s - "
+			       "mode=%u, bw=%u, nss=%u, mcs=%u, gi=%u\n",
+			       WRS_TYPE_STR(type), wrs_sta->sta_idx, FIXED_RATE_STR(is_fixed_rate),
+			       mode, bw, nss, mcs, gi);
+		return;
+	}
+
+	rate_idx = cl_wrs_tables_find_rate_idx(wrs_params, bw, nss, mcs, gi);
+
+	if (rate_idx == WRS_INVALID_RATE) {
+		wrs_pr_err(wrs_db,
+			   "[%s] Invalid fixed rate - mode=%u, bw=%u, nss=%u, mcs=%u, gi=%u\n",
+			   WRS_TYPE_STR(type), mode, bw, nss, mcs, gi);
+		return;
+	}
+
+	wrs_params->is_fixed_rate = is_fixed_rate;
+	cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta, wrs_params, rate_idx, false, false);
+	wrs_pr_verbose(wrs_db,
+		       "[%s] Station %u set to %s - mode=%u, bw=%u, nss=%u, mcs=%u, gi=%u\n",
+			WRS_TYPE_STR(type), wrs_sta->sta_idx, FIXED_RATE_STR(is_fixed_rate),
+			mode, bw, nss, mcs, gi);
+}
+
+void cl_wrs_quick_down_check(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			     struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_cntrs cntrs = {0};
+	struct cl_wrs_table *table = NULL;
+	u16 curr_rate_idx = 0;
+	u16 down_rate_idx = 0;
+	u8 type = wrs_params->type;
+
+	if (!wrs_params->sync ||
+	    wrs_params->is_fixed_rate ||
+	    !WRS_IS_DECISION_UP(wrs_params->last_decision))
+		return;
+
+	if (!WRS_TYPE_IS_RX(wrs_params))
+		cl_wrs_update_ba_not_rcv(wrs_db, wrs_params);
+
+	cl_wrs_cntrs_read(wrs_sta, &cntrs, type);
+	cl_wrs_stats_per_update(wrs_db, wrs_sta, wrs_params, &cntrs);
+
+	curr_rate_idx = wrs_params->rate_idx;
+	table = &wrs_params->table[curr_rate_idx];
+	down_rate_idx = table->rate_down.rate_idx;
+
+	/* Check if we transmitted enough frames for taking decision */
+	if (wrs_params->frames_total < wrs_db->min_frames_for_decision)
+		return;
+
+	if (wrs_params->is_logger_en) {
+		memset(&WRS_LOGGER, 0, sizeof(struct cl_wrs_logger));
+		WRS_LOGGER.timestamp = jiffies_to_msecs(jiffies);
+		WRS_LOGGER.rate_idx = curr_rate_idx;
+		WRS_LOGGER.success = wrs_params->frames_total - wrs_params->fail_total;
+		WRS_LOGGER.fail = wrs_params->fail_total;
+		WRS_LOGGER.ba_not_rcv = wrs_params->ba_not_rcv_total;
+	}
+
+	/* Down decision check */
+	if (down_rate_idx != curr_rate_idx &&
+	    cl_wrs_down_epr_check(wrs_db, wrs_sta, wrs_params,
+				  wrs_db->quick_down_epr_factor, WRS_DECISION_DOWN_QUICK))
+		cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+				     WRS_DECISION_DOWN_QUICK, down_rate_idx);
+
+	if (wrs_params->is_logger_en && WRS_LOGGER.decision != WRS_DECISION_NONE)
+		wrs_params->logger_idx = WRS_INC_POW2(wrs_params->logger_idx,
+						      wrs_params->logger_size);
+}
+
+bool cl_wrs_up_mcs1(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+		    struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	/*
+	 * In case of big packets (4300 in VHT and 5400 in HE) and low
+	 * rate (BW 20, NSS 1, MCS 0), firmware will increase rate to MCS 1,
+	 * and give an indication to driver (set rate_fix_mcs1 in cl_agg_tx_report).
+	 * WRS should also move to MCS 1, and give the maximum time
+	 * penalty time from MCS 0 toMCS 1.
+	 */
+	u16 curr_rate_idx = wrs_params->rate_idx;
+	u16 up_rate_idx = 0;
+	struct cl_wrs_table *table = &wrs_params->table[curr_rate_idx];
+
+	if (!table || wrs_params->is_fixed_rate)
+		return false;
+
+	if (table->rate.bw != CHNL_BW_20 ||
+	    table->rate.nss != WRS_SS_1 ||
+	    table->rate.mcs != WRS_MCS_0)
+		return false;
+
+	up_rate_idx = cl_wrs_tables_find_rate_idx(wrs_params,
+						  CHNL_BW_20, WRS_SS_1, WRS_MCS_1, table->rate.gi);
+
+	if (up_rate_idx == WRS_INVALID_RATE)
+		return false;
+
+	if (wrs_params->is_logger_en) {
+		memset(&WRS_LOGGER, 0, sizeof(struct cl_wrs_logger));
+		WRS_LOGGER.timestamp = jiffies_to_msecs(jiffies);
+		WRS_LOGGER.rate_idx = curr_rate_idx;
+	}
+
+	wrs_params->table[up_rate_idx].rate_down.time_th = wrs_db->time_th_max_up;
+
+	cl_wrs_cntrs_reset(wrs_sta, wrs_params);
+	cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params, WRS_DECISION_UP_MCS1, up_rate_idx);
+	cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+				  up_rate_idx, true, wrs_params->is_mu_valid);
+
+	if (wrs_params->is_logger_en)
+		wrs_params->logger_idx = WRS_INC_POW2(wrs_params->logger_idx,
+						      wrs_params->logger_size);
+
+	return true;
+}
+
+void cl_wrs_rate_param_set(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+			   struct cl_wrs_params *wrs_params,
+			   struct cl_wrs_rate_params *rate_params,
+			   struct cl_wrs_rate *rate_fallback,
+			   bool mu_mimo_valid, bool set_su)
+{
+	struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+	struct cl_wrs_info *wrs_info = NULL;
+	u8 op_mode = 0;
+	u8 ltf = 0;
+	u8 ltf_fallback = 0;
+	u8 sta_idx = cl_sta->sta_idx;
+	union cl_rate_ctrl_info rate_ctrl;
+	union cl_rate_ctrl_info rate_ctrl_fallback;
+	union cl_rate_ctrl_info_he rate_ctrl_he;
+
+	rate_ctrl_he.word = 0;
+	wrs_info = cl_wrs_info_get(cl_sta, wrs_params->type);
+
+	wrs_params->data_rate = cl_data_rates_get(rate_params->mode,
+						  rate_params->bw,
+						  rate_params->nss,
+						  rate_params->mcs,
+						  rate_params->gi);
+
+	/*
+	 * Trying to transmit MU-MIMO in bw < bw of sounding (which is STA's max bw) will fail,
+	 * So we prevent it from being transmitted with MU.
+	 */
+	if (rate_params->bw != cl_sta->sta->bandwidth)
+		mu_mimo_valid = false;
+
+	rate_ctrl.word = cl_rate_ctrl_generate(cl_hw, cl_sta, rate_params->mode,
+					       rate_params->bw, rate_params->nss,
+					       rate_params->mcs, rate_params->gi,
+					       rate_params->fallback_en, mu_mimo_valid);
+
+	/* For fallback rate use same mode (if it is NULL use same rate). */
+	if (rate_fallback) {
+		rate_ctrl_fallback.word = cl_rate_ctrl_generate(cl_hw,
+								cl_sta,
+								rate_params->mode,
+								rate_fallback->bw,
+								rate_fallback->nss,
+								rate_fallback->mcs,
+								rate_fallback->gi,
+								rate_params->fallback_en,
+								mu_mimo_valid);
+		ltf_fallback = cl_map_gi_to_ltf(rate_params->mode, rate_fallback->gi);
+	} else {
+		rate_ctrl_fallback.word = rate_ctrl.word;
+	}
+
+	/* Save current BF state and SS for the fallback rate */
+	if (WRS_TYPE_IS_TX_SU(wrs_params)) {
+		struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+		bf_db->is_on = rate_ctrl.field.tx_bf;
+		bf_db->is_on_fallback = rate_ctrl_fallback.field.tx_bf;
+		bf_db->num_ss = rate_params->nss;
+		bf_db->num_ss_fallback = rate_fallback ? rate_fallback->nss : rate_params->nss;
+	}
+
+	/* Reset counters */
+	wrs_info->success = 0;
+	wrs_info->fail = 0;
+
+	/* Mark rate as unsynced */
+	wrs_info->synced = false;
+	wrs_info->quick_rate_check = false;
+	wrs_info->sync_attempts = 0;
+	ltf = cl_map_gi_to_ltf(rate_params->mode, rate_params->gi);
+
+	if (rate_params->mode == WRS_MODE_HE)
+		rate_ctrl_he.field.spatial_conf = RATE_CNTRL_HE_SPATIAL_CONF_DEF;
+
+	/* Send new rate to firmware */
+	if (set_su) {
+		if (WRS_TYPE_IS_TX_SU(wrs_params)) {
+			op_mode = RATE_OP_MODE_STA_SU;
+			cl_msg_tx_update_rate_dl(cl_hw, sta_idx, rate_ctrl.word,
+						 rate_ctrl_fallback.word, rate_params->bw,
+						 op_mode, wrs_params->group_id, mu_mimo_valid,
+						 ltf, ltf_fallback, rate_ctrl_he.word);
+		} else if (WRS_TYPE_IS_RX(wrs_params)) {
+			u8 ul_gi_ltf = CL_TF_GI_TO_GI_LTF(rate_params->gi);
+
+			cl_msg_tx_update_rate_ul(cl_hw, sta_idx, rate_params->bw,
+						 rate_params->nss, rate_params->mcs, ul_gi_ltf);
+		}
+	}
+}
+
+s8 cl_wrs_rssi_eq_calc(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+		       bool read_clear, s8 *sorted_rssi)
+{
+	struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+	struct cl_wrs_rssi *wrs_rssi = &cl_sta->wrs_rssi;
+	int i;
+
+	if (wrs_rssi->cnt == 0) {
+		memcpy(sorted_rssi, cl_sta->last_rssi, cl_hw->num_antennas);
+		goto sort;
+	}
+
+	for (i = 0; i < cl_hw->num_antennas; i++)
+		sorted_rssi[i] = (s8)(wrs_rssi->sum[i] / wrs_rssi->cnt);
+
+	if (read_clear)
+		memset(wrs_rssi, 0, sizeof(struct cl_wrs_rssi));
+
+sort:
+	/* Sort RSSI values in descending order */
+	cl_rssi_sort_descending(sorted_rssi, cl_hw->num_antennas);
+
+	/* Calc equivalent RSSI */
+	return cl_rssi_calc_equivalent(cl_hw, sorted_rssi);
+}
+
+void cl_wrs_cntrs_reset(struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+	struct cl_wrs_info *wrs_info = cl_wrs_info_get(cl_sta, wrs_params->type);
+
+	_cl_wrs_cntrs_reset(wrs_info);
+}
+
+struct cl_wrs_info *cl_wrs_info_get(struct cl_sta *cl_sta, u8 type)
+{
+	if (type == WRS_TYPE_TX_SU)
+		return &cl_sta->wrs_info_tx_su;
+	else if (type == WRS_TYPE_RX)
+		return &cl_sta->wrs_info_rx;
+
+	return NULL;
+}
+
+struct cl_wrs_params *cl_wrs_params_get(struct cl_wrs_sta *wrs_sta, u8 type)
+{
+	if (type == WRS_TYPE_TX_SU)
+		return &wrs_sta->tx_su_params;
+	else if (type == WRS_TYPE_RX)
+		return wrs_sta->rx_params;
+
+	return NULL;
+}
+
+void cl_wrs_update_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr)
+{
+	struct cl_wrs_rate *rate_params = NULL;
+
+	if (!cl_sta ||
+	    !cl_sta->wrs_sta.rx_params ||
+	    rxhdr->format_mod == FORMATMOD_HE_TRIG)
+		return;
+
+	rate_params = &cl_sta->wrs_sta.rx_params->rx_rate_idle;
+
+	rate_params->bw = rxhdr->ch_bw;
+	rate_params->nss = rxhdr->n_sts;
+	rate_params->mcs = rxhdr->mcs;
+	rate_params->gi = rxhdr->gi_type;
+}
+
+bool cl_wrs_set_rate_idle(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_rate *rx_rate_idle = &wrs_params->rx_rate_idle;
+	s8 rssi_sort[MAX_ANTENNAS] = {0};
+	u16 new_rate_idx = 0;
+	u8 decision;
+
+	if (WRS_TYPE_IS_RX(wrs_params) &&
+	    cl_wrs_is_rate_params_valid(rx_rate_idle)) {
+		decision = WRS_DECISION_RX_RATE;
+		if (wrs_params->initial_rate_idx != WRS_INVALID_RATE)
+			new_rate_idx = wrs_params->initial_rate_idx;
+		else
+			/* Get rate from last data packet */
+			new_rate_idx = cl_wrs_tables_find_rate_idx(wrs_params,
+								   rx_rate_idle->bw,
+								   rx_rate_idle->nss,
+								   rx_rate_idle->mcs,
+								   rx_rate_idle->gi);
+
+		cl_wrs_rx_rate_idle_reset(wrs_params);
+	} else {
+		/* Get rate from rssi */
+		cl_wrs_rssi_eq_calc(cl_hw, wrs_sta, true, rssi_sort);
+		new_rate_idx = cl_wrs_rssi_find_rate(cl_hw, wrs_db, wrs_sta, wrs_params, rssi_sort);
+		decision = WRS_DECISION_RSSI_MGMT;
+	}
+
+	if (new_rate_idx != wrs_params->rate_idx) {
+		if (wrs_params->is_logger_en) {
+			memset(&WRS_LOGGER, 0, sizeof(struct cl_wrs_logger));
+			WRS_LOGGER.timestamp = jiffies_to_msecs(jiffies);
+			WRS_LOGGER.rate_idx = wrs_params->rate_idx;
+		}
+
+		cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params, decision, new_rate_idx);
+		cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+					  new_rate_idx, false, false);
+	} else {
+		wrs_params->sync = true;
+	}
+
+	return true;
+}
+
+struct cl_wrs_rate_params *cl_wrs_rx_rate_get(struct cl_sta *cl_sta)
+{
+	struct cl_wrs_params *rx_params = cl_sta->wrs_sta.rx_params;
+
+	if (rx_params)
+		return &rx_params->rate_params;
+
+	return NULL;
+}
+
+void cl_wrs_rx_rate_idle_reset(struct cl_wrs_params *rx_params)
+{
+	struct cl_wrs_rate *rate_idle = &rx_params->rx_rate_idle;
+
+	*(u16 *)rate_idle = U16_MAX;
+}
+
+static void cl_wrs_ap_set_bitmap(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db)
+{
+	u8 mcs, bw, nss, rate_idx;
+
+	memset(wrs_db->ap_supported_rates, 0, sizeof(wrs_db->ap_supported_rates));
+
+	for (bw = cl_hw->conf->ci_wrs_min_bw; bw <= wrs_db->max_cap.bw; bw++)
+		for (nss = 0; nss <= wrs_db->max_cap.nss; nss++)
+			for (mcs = 0; mcs <= wrs_db->max_cap.mcs; mcs++) {
+				rate_idx = mcs + (nss * WRS_MCS_MAX);
+				wrs_db->ap_supported_rates[bw] |= BIT(rate_idx);
+			}
+}
+
+void cl_wrs_ap_capab_set(struct cl_hw *cl_hw,
+			 u8 bw,
+			 u8 use_sgi)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_rate *max_cap = &wrs_db->max_cap;
+	u8 conf_nss = cl_hw->conf->ce_tx_nss - 1;
+
+	switch (cl_hw->wireless_mode) {
+	case WIRELESS_MODE_HE:
+	case WIRELESS_MODE_HT_VHT_HE:
+		wrs_db->mode = WRS_MODE_HE;
+		max_cap->bw = bw;
+		max_cap->nss = conf_nss;
+		max_cap->mcs = WRS_MCS_11;
+		max_cap->gi = use_sgi ? WRS_GI_VSHORT : 0;
+		break;
+	case WIRELESS_MODE_HT_VHT:
+		wrs_db->mode = WRS_MODE_VHT;
+		max_cap->bw = bw;
+		max_cap->nss = conf_nss;
+		max_cap->mcs = WRS_MCS_9;
+		max_cap->gi = use_sgi ? WRS_GI_SHORT : 0;
+		break;
+	case WIRELESS_MODE_HT:
+		wrs_db->mode = WRS_MODE_HT;
+		max_cap->bw = min_t(u8, bw, CHNL_BW_80);
+		max_cap->nss = conf_nss;
+		max_cap->mcs = WRS_MCS_7;
+		max_cap->gi = use_sgi ? WRS_GI_SHORT : 0;
+		break;
+	case WIRELESS_MODE_LEGACY:
+	default:
+		if (cl_hw->hw_mode == HW_MODE_B) {
+			wrs_db->mode = WRS_MODE_CCK;
+			max_cap->mcs = WRS_MCS_3;
+		} else {
+			wrs_db->mode = WRS_MODE_OFDM;
+			max_cap->mcs = WRS_MCS_7;
+		}
+
+		max_cap->bw = CHNL_BW_20;
+		max_cap->nss = 0;
+		max_cap->gi = 0;
+		break;
+	}
+
+	if (cl_hw->conf->ci_wrs_max_bw < max_cap->bw) {
+		max_cap->bw = cl_hw->conf->ci_wrs_max_bw;
+		wrs_pr_warn(wrs_db, "Max BW limited to %uMHz\n", BW_TO_MHZ(max_cap->bw));
+	}
+
+	wrs_db->coex_bw = max_t(u8, max_cap->bw, CHNL_BW_40);
+
+	cl_wrs_ap_set_bitmap(cl_hw, wrs_db);
+}
+
+void cl_wrs_ap_capab_modify_bw(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, u8 max_bw)
+{
+	wrs_db->max_cap.bw = max_bw;
+
+	cl_wrs_ap_set_bitmap(cl_hw, wrs_db);
+}
+
+void cl_wrs_ap_capab_modify_gi(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, u8 use_sgi)
+{
+	switch (cl_hw->wireless_mode) {
+	case WIRELESS_MODE_HE:
+	case WIRELESS_MODE_HT_VHT_HE:
+		wrs_db->max_cap.gi = use_sgi ? WRS_GI_VSHORT : 0;
+		break;
+	case WIRELESS_MODE_HT:
+	case WIRELESS_MODE_HT_VHT:
+		wrs_db->max_cap.gi = use_sgi ? WRS_GI_SHORT : 0;
+		break;
+	default:
+		wrs_db->max_cap.gi = 0;
+	}
+
+	cl_wrs_ap_set_bitmap(cl_hw, wrs_db);
+}
+
+void cl_wrs_api_init(struct cl_hw *cl_hw)
+{
+	cl_wrs_init(cl_hw);
+	cl_wrs_ap_capab_set(cl_hw, cl_hw->conf->ci_cap_bandwidth,
+			    cl_hw->conf->ci_short_guard_interval);
+}
+
+void cl_wrs_api_close(struct cl_hw *cl_hw)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	del_timer_sync(&wrs_db->timer_maintenance);
+}
+
+void cl_wrs_api_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock_bh(wrs_db);
+	cl_wrs_sta_add(cl_hw, sta);
+
+	if (sta->he_cap.has_he && cl_hw->conf->ce_wrs_rx_en)
+		cl_wrs_sta_add_rx(cl_hw, sta);
+
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock_bh(wrs_db);
+	cl_wrs_sta_remove(cl_hw, wrs_db, cl_sta);
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_bss_set_bw(struct cl_hw *cl_hw, u8 bw)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock_bh(wrs_db);
+	cl_wrs_ap_capab_modify_bw(cl_hw, wrs_db, bw);
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_bss_set_sgi(struct cl_hw *cl_hw, u8 use_sgi)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock_bh(wrs_db);
+	cl_wrs_ap_capab_modify_gi(cl_hw, wrs_db, use_sgi);
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+bool cl_wrs_api_bss_is_sgi_en(struct cl_hw *cl_hw)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	bool ret = false;
+
+	cl_wrs_lock_bh(wrs_db);
+	ret = wrs_db->max_cap.gi != 0;
+	cl_wrs_unlock_bh(wrs_db);
+
+	return ret;
+}
+
+void cl_wrs_api_bss_capab_update(struct cl_hw *cl_hw, u8 bw, u8 use_sgi)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock_bh(wrs_db);
+	cl_wrs_ap_capab_set(cl_hw, bw, use_sgi);
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_nss_or_bw_changed(struct cl_hw *cl_hw, struct ieee80211_sta *sta, u8 nss, u8 bw)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+
+	cl_wrs_lock_bh(wrs_db);
+
+	wrs_sta->max_rate_cap.nss = nss;
+	wrs_sta->max_rate_cap.bw = bw;
+	cl_wrs_sta_capabilities_set(wrs_db, sta);
+	cl_wrs_tables_build(cl_hw, wrs_sta, &wrs_sta->tx_su_params);
+
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_he_minrate_changed(struct cl_sta *cl_sta, u8 he_minrate)
+{
+	struct cl_hw *cl_hw = cl_sta->cl_vif->cl_hw;
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	u8 mcs = 0, nss = 0, bw = 0;
+	u16 data_rate_x10 = 0;
+
+	cl_wrs_lock_bh(wrs_db);
+
+	wrs_sta->he_minrate = he_minrate;
+	cl_wrs_tables_build(cl_hw, wrs_sta, &wrs_sta->tx_su_params);
+
+	cl_wrs_unlock_bh(wrs_db);
+
+	for (bw = 0; bw < wrs_sta->max_rate_cap.bw; bw++) {
+		for (nss = 0; nss < wrs_sta->max_rate_cap.nss; nss++) {
+			for (mcs = 0; mcs < wrs_sta->max_rate_cap.mcs; mcs++) {
+				data_rate_x10 = cl_data_rates_get_x10(WRS_MODE_HE, bw,
+								      nss, mcs,
+								      WRS_GI_LONG);
+				if (data_rate_x10 >= (he_minrate * 10)) {
+					cl_rate_ctrl_set_default_per_he_minrate(cl_hw, bw,
+										nss, mcs,
+										WRS_GI_LONG);
+					return;
+				}
+			}
+		}
+	}
+}
+
+static void _cl_wrs_api_recovery(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+				 struct cl_wrs_params *wrs_params)
+{
+	u16 fallback_rate_idx = wrs_params->table[wrs_params->rate_idx].rate_down.rate_idx;
+	struct cl_wrs_rate *rate_fallback = &wrs_params->table[fallback_rate_idx].rate;
+	struct cl_wrs_rate_params *rate_params = &wrs_params->rate_params;
+	bool is_mu_valid = wrs_params->is_mu_valid;
+
+	cl_wrs_rate_param_set(cl_hw, wrs_sta, wrs_params, rate_params,
+			      rate_fallback, is_mu_valid, true);
+}
+
+void cl_wrs_api_recovery(struct cl_hw *cl_hw)
+{
+	struct cl_sta *cl_sta = NULL;
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_sta *wrs_sta = NULL;
+
+	cl_wrs_lock_bh(wrs_db);
+	cl_sta_lock(cl_hw);
+
+	list_for_each_entry(cl_sta, &cl_hw->cl_sta_db.head, list) {
+		wrs_sta = &cl_sta->wrs_sta;
+
+		_cl_wrs_api_recovery(cl_hw, wrs_sta, &wrs_sta->tx_su_params);
+
+		if (wrs_sta->rx_params)
+			_cl_wrs_api_recovery(cl_hw, wrs_sta, wrs_sta->rx_params);
+	}
+
+	cl_sta_unlock(cl_hw);
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+void cl_wrs_api_beamforming_sync(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_params *wrs_params = &cl_sta->wrs_sta.tx_su_params;
+	u8 up_idx = 0;
+	u16 rate_idx = wrs_params->rate_idx;
+
+	cl_wrs_lock(wrs_db);
+
+	for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++)
+		wrs_params->table[rate_idx].rate_up[up_idx].time_th = WRS_INIT_MSEC_WEIGHT_UP;
+
+	cl_wrs_unlock(wrs_db);
+
+	wrs_pr_info(wrs_db, "[%s] sta %u - beamforming sync\n",
+		    WRS_TYPE_STR(wrs_params->type), cl_sta->sta_idx);
+}
+
+void cl_wrs_api_quick_down_check(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				 struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock(wrs_db);
+	cl_wrs_quick_down_check(cl_hw, wrs_db, &cl_sta->wrs_sta, wrs_params);
+	cl_wrs_unlock(wrs_db);
+}
+
+void cl_wrs_api_rate_sync(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			  struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	cl_wrs_lock(wrs_db);
+	cl_wrs_rate_param_sync(wrs_db, &cl_sta->wrs_sta, wrs_params);
+	cl_wrs_unlock(wrs_db);
+}
+
+bool cl_wrs_api_up_mcs1(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	bool result = false;
+
+	cl_wrs_lock(wrs_db);
+	result = cl_wrs_up_mcs1(cl_hw, wrs_db, &cl_sta->wrs_sta, wrs_params);
+	cl_wrs_unlock(wrs_db);
+
+	return result;
+}
+
+void cl_wrs_api_set_smps_mode(struct cl_hw *cl_hw, struct ieee80211_sta *sta, const u8 bw)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	u8 min_bw;
+
+	if (sta->smps_mode == IEEE80211_SMPS_STATIC ||
+	    sta->smps_mode == IEEE80211_SMPS_DYNAMIC) {
+		/* If RTS is enabled, there is no need to go down to 1ss */
+		if (cl_prot_mode_get(cl_hw) == TXL_PROT_RTS_FW)
+			return;
+
+		wrs_sta->smps_enable = true;
+	} else if (sta->smps_mode == IEEE80211_SMPS_OFF && wrs_sta->smps_enable) {
+		wrs_sta->smps_enable = false;
+	}
+
+	cl_wrs_lock_bh(wrs_db);
+	min_bw = min_t(u8, bw, wrs_db->max_cap.bw);
+
+	if (wrs_sta->max_rate_cap.bw != min_bw) {
+		wrs_sta->max_rate_cap.bw = min_bw;
+		wrs_pr_trace(wrs_db, "[TX_SU] SMPS mode: sta %u, bw %u\n",
+			     wrs_sta->sta_idx, min_bw);
+		cl_wrs_tables_build(cl_hw, wrs_sta, &wrs_sta->tx_su_params);
+	}
+
+	cl_wrs_unlock_bh(wrs_db);
+}
+
+u16 cl_wrs_api_get_tx_sta_data_rate(struct cl_sta *cl_sta)
+{
+		return cl_sta->wrs_sta.tx_su_params.data_rate;
+}
+
+static enum rate_info_bw cl_wrs_mode_to_nl80211_rateinfo_bw(u8 bw)
+{
+	switch (bw) {
+	case CHNL_BW_20:
+		return RATE_INFO_BW_20;
+	case CHNL_BW_40:
+		return RATE_INFO_BW_40;
+	case CHNL_BW_80:
+		return RATE_INFO_BW_80;
+	case CHNL_BW_160:
+		return RATE_INFO_BW_160;
+	default:
+		return RATE_INFO_BW_20;
+	}
+}
+
+void cl_wrs_fill_sinfo_rates(struct rate_info *rate_info,
+			     const struct cl_wrs_params *wrs_params,
+			     const struct cl_sta *sta)
+{
+	rate_info->bw = cl_wrs_mode_to_nl80211_rateinfo_bw(wrs_params->rate_params.bw);
+	rate_info->mcs = wrs_params->rate_params.mcs;
+	rate_info->nss = wrs_params->rate_params.nss + 1;
+	rate_info->he_gi = wrs_params->rate_params.gi;
+
+	rate_info->flags = 0;
+	/* GI = 0.4 us */
+	if (wrs_params->rate_params.mode < WRS_MODE_HE && wrs_params->rate_params.gi == 1)
+		rate_info->flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+	if (wrs_params->rate_params.mode == WRS_MODE_HT)
+		rate_info->flags |= RATE_INFO_FLAGS_MCS;
+
+	if (wrs_params->rate_params.mode == WRS_MODE_VHT)
+		rate_info->flags |= RATE_INFO_FLAGS_VHT_MCS;
+
+	if (wrs_params->rate_params.mode == WRS_MODE_HE) {
+		enum cl_mu_ofdma_ru_type ru_type = sta->rate_ctrl_he.field.ru_type;
+
+		rate_info->flags |= RATE_INFO_FLAGS_HE_MCS;
+		if (ru_type) {
+			rate_info->he_ru_alloc = cl_ru_type_to_nl80211_he_ru_alloc(ru_type);
+			rate_info->bw = RATE_INFO_BW_HE_RU;
+		}
+	}
+}
+
+/*
+ * Section #1:
+ * rate based on rssi.
+ */
+static s8 rssi_threshold_he[WRS_MCS_MAX_HE] = {
+	-35, -40, -45, -50, -55, -60, -65, -70, -75, -80, -85, -90
+};
+
+static s8 rssi_threshold_vht[WRS_MCS_MAX_VHT] = {
+	-36, -42, -48, -54, -60, -66, -72, -78, -84, -90
+};
+
+static s8 rssi_threshold_ht[WRS_MCS_MAX_HT] = {
+	-34, -42, -50, -58, -66, -74, -82, -90
+};
+
+static s8 rssi_threshold_ofdm[WRS_MCS_MAX_OFDM] = {
+	-34, -42, -50, -58, -66, -74, -82, -90
+};
+
+static s8 rssi_threshold_cck[WRS_MCS_MAX_CCK] = {
+	-45, -60, -75, -90
+};
+
+static u16 cl_wrs_rssi_find_rate_ht_vht_he(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+					   struct cl_wrs_sta *wrs_sta,
+					   struct cl_wrs_params *wrs_params,
+					   s8 *rssi_sort,
+					   s8 *thresholds)
+{
+	s8 max_ss = (s8)wrs_sta->max_rate_cap.nss;
+	s8 nss = 0;
+	u8 max_bw = wrs_sta->max_rate_cap.bw;
+	u8 bw = 0;
+	u8 max_mcs = wrs_sta->max_rate_cap.mcs;
+	u8 mcs = 0;
+	u8 gi = WRS_GI_LONG;
+	u8 selected_mcs = 0;
+	u8 selected_nss = 0;
+	u8 selected_bw = 0;
+	u8 i = 0;
+	u16 rate_idx = 0;
+	u16 data_rate = 0;
+	u16 max_data_rate = 0;
+
+	if (max_bw > cl_hw->conf->ci_wrs_max_bw)
+		max_bw = cl_hw->conf->ci_wrs_max_bw;
+
+	for (i = 0; i <= max_mcs; i++) {
+		mcs = max_mcs - i;
+
+		for (nss = max_ss; nss >= 0; nss--) {
+			if (rssi_sort[nss] <= thresholds[i])
+				continue;
+
+			/* In last level decrease BW */
+			bw = ((i == max_mcs) && (max_bw > CHNL_BW_20)) ? (max_bw - 1) : max_bw;
+
+			if (wrs_sta->mode == WRS_MODE_HE) {
+				data_rate = data_rate_he_x10[nss][bw][mcs][WRS_GI_LONG];
+			} else {
+				if (wrs_sta->mode == WRS_MODE_VHT) {
+					/* 160MHz in VHT is valid only for 1/2 SS */
+					if (nss >= WRS_SS_3 && bw == CHNL_BW_160)
+						bw = CHNL_BW_80;
+
+					/* BW 80, 3 SS MCS 6 is invalid in VHT */
+					if (bw == CHNL_BW_80 &&
+					    nss == WRS_SS_3 &&
+					    mcs == WRS_MCS_6)
+						continue;
+				}
+
+				data_rate = data_rate_ht_vht_x10[bw][nss][mcs][gi];
+			}
+
+			if (data_rate > max_data_rate) {
+				selected_mcs = mcs;
+				selected_nss = nss;
+				selected_bw = bw;
+				max_data_rate = data_rate;
+				rate_idx = cl_wrs_tables_find_rate_idx(wrs_params,
+								       bw, nss, mcs, gi);
+			}
+
+			break;
+		}
+	}
+
+	return rate_idx;
+}
+
+static u16 cl_wrs_rssi_find_rate_cck_ofdm(struct cl_wrs_sta *wrs_sta,
+					  s8 *rssi_sort, s8 *thresholds)
+{
+	struct cl_wrs_params *wrs_params = &wrs_sta->tx_su_params;
+	u8 max_mcs = wrs_sta->max_rate_cap.mcs;
+	u8 mcs = 0;
+	u8 i = 0;
+
+	for (i = 0; i <= max_mcs; i++) {
+		mcs = max_mcs - i;
+
+		if (rssi_sort[WRS_SS_1] > thresholds[i])
+			return cl_wrs_tables_find_rate_idx(wrs_params,
+							   CHNL_BW_20, WRS_SS_1, mcs, WRS_GI_LONG);
+	}
+
+	return 0;
+}
+
+u16 cl_wrs_rssi_find_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			  struct cl_wrs_sta *wrs_sta,
+			  struct cl_wrs_params *wrs_params,
+			  s8 *rssi_sort)
+{
+	u16 rate_idx = 0;
+
+	if (wrs_params->initial_rate_idx != WRS_INVALID_RATE)
+		return wrs_params->initial_rate_idx;
+
+	switch (wrs_sta->mode) {
+	case WRS_MODE_HE:
+		rate_idx = cl_wrs_rssi_find_rate_ht_vht_he(cl_hw, wrs_db, wrs_sta, wrs_params,
+							   rssi_sort, rssi_threshold_he);
+		break;
+	case WRS_MODE_VHT:
+		rate_idx = cl_wrs_rssi_find_rate_ht_vht_he(cl_hw, wrs_db, wrs_sta, wrs_params,
+							   rssi_sort, rssi_threshold_vht);
+		break;
+	case WRS_MODE_HT:
+		rate_idx = cl_wrs_rssi_find_rate_ht_vht_he(cl_hw, wrs_db, wrs_sta, wrs_params,
+							   rssi_sort, rssi_threshold_ht);
+		break;
+	case WRS_MODE_OFDM:
+		rate_idx = cl_wrs_rssi_find_rate_cck_ofdm(wrs_sta, rssi_sort,
+							  rssi_threshold_ofdm);
+		break;
+	case WRS_MODE_CCK:
+		rate_idx = cl_wrs_rssi_find_rate_cck_ofdm(wrs_sta, rssi_sort,
+							  rssi_threshold_cck);
+		break;
+	default:
+		break;
+	}
+
+	if (rate_idx == WRS_INVALID_RATE)
+		rate_idx = 0;
+
+	wrs_pr_trace(wrs_db,
+		     "[%s] Select rate based rssi - sta=%u, rssi [%d,%d,%d,%d], "
+		     "rate_idx=%u, bw=%u, nss=%u, mcs=%u\n",
+		     WRS_TYPE_STR(wrs_params->type),
+		     wrs_sta->sta_idx,
+		     rssi_sort[0],
+		     rssi_sort[1],
+		     rssi_sort[2],
+		     rssi_sort[3],
+		     rate_idx,
+		     wrs_params->table[rate_idx].rate.bw,
+		     wrs_params->table[rate_idx].rate.nss,
+		     wrs_params->table[rate_idx].rate.mcs);
+
+	return rate_idx;
+}
+
+/*
+ * Section #2:
+ * rssi protect.
+ */
+static void cl_wrs_rssi_prot_set_avg(struct cl_wrs_sta *wrs_sta, s8 avg)
+{
+	struct cl_wrs_rssi_prot_db *rssi_prot_db = &wrs_sta->rssi_prot_db;
+
+	memset(rssi_prot_db->samples_old, avg, WRS_RSSI_PROTECT_BUF_SZ_OLD);
+	memset(rssi_prot_db->samples_new, avg, WRS_RSSI_PROTECT_BUF_SZ_NEW);
+	rssi_prot_db->sum = avg << WRS_RSSI_PROTECT_SHIFT;
+}
+
+static s8 cl_wrs_rssi_prot_add_smpl(struct cl_wrs_sta *wrs_sta, s8 rssi_eq)
+{
+	struct cl_wrs_rssi_prot_db *rssi_prot_db = &wrs_sta->rssi_prot_db;
+	u8 curr_idx_old = rssi_prot_db->curr_idx_old;
+	u8 curr_idx_new = rssi_prot_db->curr_idx_new;
+
+	rssi_prot_db->sum +=
+		rssi_prot_db->samples_new[curr_idx_new] - rssi_prot_db->samples_old[curr_idx_old];
+	rssi_prot_db->samples_old[curr_idx_old] = rssi_prot_db->samples_new[curr_idx_new];
+	rssi_prot_db->samples_new[curr_idx_new] = rssi_eq;
+
+	rssi_prot_db->curr_idx_old =
+		WRS_INC_POW2(rssi_prot_db->curr_idx_old, WRS_RSSI_PROTECT_BUF_SZ_OLD);
+	WRS_INC(rssi_prot_db->curr_idx_new, WRS_RSSI_PROTECT_BUF_SZ_NEW);
+
+	return (s8)(wrs_sta->rssi_prot_db.sum >> WRS_RSSI_PROTECT_SHIFT);
+}
+
+static bool cl_wrs_rssi_prot_decision_up(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+					 struct cl_wrs_sta *wrs_sta,
+					 struct cl_wrs_params *wrs_params,
+					 s8 rssi_avg, s8 rssi_eq,
+					 s8 *rssi_sort, u8 up_rate_idx)
+{
+	/* Decide UP only if all new samples are greater than old average */
+	s8 *samples_new = wrs_sta->rssi_prot_db.samples_new;
+	s8 up_thr = rssi_avg + wrs_db->rssi_protect_up_thr;
+	u8 i = 0;
+
+	for (i = 0; i < WRS_RSSI_PROTECT_BUF_SZ_NEW; i++)
+		if (samples_new[i] <= up_thr)
+			return false;
+
+	if (wrs_db->rssi_protect_mode == WRS_RSSI_PROT_MODE_RSSI) {
+		u16 rate_idx_old = wrs_params->rate_idx;
+		u16 rate_idx_new = cl_wrs_rssi_find_rate(cl_hw, wrs_db, wrs_sta,
+							 wrs_params, rssi_sort);
+		struct cl_wrs_rate *rate_old = &wrs_params->table[rate_idx_old].rate;
+		struct cl_wrs_rate *rate_new = &wrs_params->table[rate_idx_new].rate;
+		u16 data_rate_old = cl_data_rates_get_x10(wrs_sta->mode, rate_old->bw,
+							  rate_old->nss, rate_old->mcs,
+							  rate_old->gi);
+		u16 data_rate_new = cl_data_rates_get_x10(wrs_sta->mode, rate_new->bw,
+							  rate_new->nss, rate_new->mcs,
+							  rate_new->gi);
+
+		if (rate_idx_old == rate_idx_new || data_rate_old >= data_rate_new)
+			rate_idx_new = up_rate_idx;
+
+		wrs_pr_info(wrs_db, "[%s] Increase rate based on RSSI - old [%u], new [%u]\n",
+			    WRS_TYPE_STR(wrs_params->type), rate_idx_old, rate_idx_new);
+		cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params,
+				       WRS_DECISION_UP_RSSI, rate_idx_new);
+		cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta,
+					  wrs_params, rate_idx_new, true, false);
+	} else {
+		cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+				     WRS_DECISION_UP_RSSI, up_rate_idx);
+	}
+
+	cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+	cl_wrs_rssi_prot_set_avg(wrs_sta, rssi_eq);
+
+	return true;
+}
+
+static bool cl_wrs_rssi_prot_decision_down(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+					   struct cl_wrs_sta *wrs_sta,
+					   struct cl_wrs_params *wrs_params,
+					   s8 rssi_avg, s8 rssi_eq,
+					   s8 *rssi_sort, u8 down_rate_idx)
+{
+	/* Decide DOWN only if all new samples are smaller than old average */
+	s8 *samples_new = wrs_sta->rssi_prot_db.samples_new;
+	s8 dn_thr = rssi_avg - wrs_db->rssi_protect_dn_thr;
+	u8 i = 0;
+
+	if (wrs_params->rate_idx == 0)
+		return false;
+
+	for (i = 0; i < WRS_RSSI_PROTECT_BUF_SZ_NEW; i++)
+		if (samples_new[i] >= dn_thr)
+			return false;
+
+	if (wrs_db->rssi_protect_mode == WRS_RSSI_PROT_MODE_RSSI) {
+		u16 rate_idx_old = wrs_params->rate_idx;
+		u16 rate_idx_new = cl_wrs_rssi_find_rate(cl_hw, wrs_db, wrs_sta,
+							 wrs_params, rssi_sort);
+		struct cl_wrs_rate *rate_old = &wrs_params->table[rate_idx_old].rate;
+		struct cl_wrs_rate *rate_new = &wrs_params->table[rate_idx_new].rate;
+		u16 data_rate_old = cl_data_rates_get_x10(wrs_sta->mode, rate_old->bw,
+							  rate_old->nss, rate_old->mcs,
+							  rate_old->gi);
+		u16 data_rate_new = cl_data_rates_get_x10(wrs_sta->mode, rate_new->bw,
+							  rate_new->nss, rate_new->mcs,
+							  rate_new->gi);
+
+		if (rate_idx_old == rate_idx_new || data_rate_old <= data_rate_new)
+			rate_idx_new = down_rate_idx;
+
+		wrs_pr_info(wrs_db, "[%s] Decrease rate based on RSSI - old [%u], new [%u]\n",
+			    WRS_TYPE_STR(wrs_params->type), rate_idx_old, rate_idx_new);
+		cl_wrs_decision_update(wrs_db, wrs_sta, wrs_params,
+				       WRS_DECISION_DOWN_RSSI, rate_idx_new);
+		cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta, wrs_params,
+					  rate_idx_new, true, false);
+	} else {
+		cl_wrs_decision_make(cl_hw, wrs_db, wrs_sta, wrs_params,
+				     WRS_DECISION_DOWN_RSSI, down_rate_idx);
+	}
+
+	cl_wrs_tables_reset(wrs_db, wrs_sta, wrs_params);
+	cl_wrs_rssi_prot_set_avg(wrs_sta, rssi_eq);
+
+	return true;
+}
+
+void cl_wrs_rssi_prot_start(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	s8 rssi_sort[MAX_ANTENNAS] = {0};
+	s8 rssi_eq = 0;
+
+	if (!cl_hw->wrs_db.rssi_protect_en)
+		return;
+
+	rssi_eq = cl_wrs_rssi_eq_calc(cl_hw, wrs_sta, false, rssi_sort);
+	cl_wrs_rssi_prot_set_avg(wrs_sta, rssi_eq);
+}
+
+bool cl_wrs_rssi_prot_decision(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+			       struct cl_wrs_sta *wrs_sta,
+			       struct cl_wrs_params *wrs_params,
+			       bool up_rate_valid,
+			       u8 up_rate_idx, u8 down_rate_idx)
+{
+	s8 rssi_avg = 0;
+	s8 rssi_eq = 0;
+	s8 rssi_sort[MAX_ANTENNAS] = {0};
+
+	rssi_eq = cl_wrs_rssi_eq_calc(cl_hw, wrs_sta, true, rssi_sort);
+	rssi_avg = cl_wrs_rssi_prot_add_smpl(wrs_sta, rssi_eq);
+
+	if (up_rate_valid)
+		if (cl_wrs_rssi_prot_decision_up(cl_hw, wrs_db, wrs_sta, wrs_params, rssi_avg,
+						 rssi_eq, rssi_sort, up_rate_idx))
+			return true;
+
+	return cl_wrs_rssi_prot_decision_down(cl_hw, wrs_db, wrs_sta, wrs_params, rssi_avg,
+					      rssi_eq, rssi_sort, down_rate_idx);
+}
+
+static void cl_wrs_sta_info_set_he(struct cl_wrs_sta *wrs_sta)
+{
+	wrs_sta->mode = WRS_MODE_HE;
+
+	wrs_sta->gi_cap[CHNL_BW_20] = WRS_GI_VSHORT;
+	wrs_sta->gi_cap[CHNL_BW_40] = WRS_GI_VSHORT;
+	wrs_sta->gi_cap[CHNL_BW_80] = WRS_GI_VSHORT;
+	wrs_sta->gi_cap[CHNL_BW_160] = WRS_GI_VSHORT;
+}
+
+static void cl_wrs_sta_info_set_vht(struct cl_wrs_sta *wrs_sta,
+				    struct ieee80211_sta_vht_cap *vht_cap,
+				    struct ieee80211_sta_ht_cap *ht_cap)
+{
+	wrs_sta->mode = WRS_MODE_VHT;
+
+	wrs_sta->gi_cap[CHNL_BW_20] =
+		(ht_cap->cap & IEEE80211_HT_CAP_SGI_20) ? WRS_GI_SHORT : WRS_GI_LONG;
+	wrs_sta->gi_cap[CHNL_BW_40] =
+		(ht_cap->cap & IEEE80211_HT_CAP_SGI_40) ? WRS_GI_SHORT : WRS_GI_LONG;
+	wrs_sta->gi_cap[CHNL_BW_80] =
+		(vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_80) ? WRS_GI_SHORT : WRS_GI_LONG;
+	wrs_sta->gi_cap[CHNL_BW_160] =
+		(vht_cap->cap & IEEE80211_VHT_CAP_SHORT_GI_160) ? WRS_GI_SHORT : WRS_GI_LONG;
+}
+
+static void cl_wrs_sta_info_set_ht(struct cl_wrs_sta *wrs_sta,
+				   struct ieee80211_sta_ht_cap *ht_cap)
+{
+	wrs_sta->mode = WRS_MODE_HT;
+
+	wrs_sta->gi_cap[CHNL_BW_20] =
+		(ht_cap->cap & IEEE80211_HT_CAP_SGI_20) ? WRS_GI_SHORT : WRS_GI_LONG;
+	wrs_sta->gi_cap[CHNL_BW_40] =
+		(ht_cap->cap & IEEE80211_HT_CAP_SGI_40) ? WRS_GI_SHORT : WRS_GI_LONG;
+}
+
+static void cl_wrs_sta_info_set_legacy(struct cl_wrs_sta *wrs_sta,
+				       struct ieee80211_sta *sta)
+{
+	if (sta->supp_rates[NL80211_BAND_5GHZ] ||
+	    (sta->supp_rates[NL80211_BAND_2GHZ] & 0xFF0))
+		wrs_sta->mode = WRS_MODE_OFDM;
+	else
+		wrs_sta->mode = WRS_MODE_CCK;
+}
+
+static void cl_wrs_sta_info_set(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+				struct ieee80211_sta *sta)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	u8 bw = min_t(u8, sta->bandwidth, wrs_db->max_cap.bw);
+
+	if (he_cap->has_he)
+		cl_wrs_sta_info_set_he(wrs_sta);
+	else if (vht_cap->vht_supported && ht_cap->ht_supported)
+		cl_wrs_sta_info_set_vht(wrs_sta, vht_cap, ht_cap);
+	else if (ht_cap->ht_supported)
+		cl_wrs_sta_info_set_ht(wrs_sta, ht_cap);
+	else
+		cl_wrs_sta_info_set_legacy(wrs_sta, sta);
+
+	wrs_sta->max_rate_cap.nss = min_t(u8, sta->rx_nss, WRS_SS_MAX) - 1;
+
+	if (cl_band_is_24g(cl_hw))
+		wrs_sta->max_rate_cap.bw = min(bw, wrs_db->coex_bw);
+	else
+		wrs_sta->max_rate_cap.bw = bw;
+
+	wrs_sta->assoc_bw = bw;
+}
+
+#define TWO_BITS_MASK 0x3
+
+static u8 cl_wrs_calc_max_nss(u16 rx_mcs, u8 max_nss)
+{
+	u8 i, nss = 0;
+
+	for (i = 0; i <= max_nss; i++) {
+		if (((rx_mcs >> (2 * i)) & TWO_BITS_MASK) != IEEE80211_HE_MCS_NOT_SUPPORTED)
+			nss++;
+		else
+			break;
+	}
+
+	return nss;
+}
+
+static void cl_supported_rates_he_cap(struct cl_wrs_db *wrs_db, struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = (struct cl_sta *)sta->drv_priv;
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	struct ieee80211_he_mcs_nss_supp *mcs_nss = &sta->he_cap.he_mcs_nss_supp;
+	int mcs = 0;
+	int supported_mcs = 0;
+	u16 rx_mcs = 0;
+	u8 max_nss = wrs_sta->max_rate_cap.nss;
+	u8 nss = 0, bw = 0;
+	u8 max_nss_80, max_nss_160;
+
+	for (bw = 0; bw <= wrs_sta->max_rate_cap.bw; bw++) {
+		if (bw < CHNL_BW_160) {
+			rx_mcs = le16_to_cpu(mcs_nss->rx_mcs_80);
+		} else if (bw == CHNL_BW_160) {
+			max_nss_80 = cl_wrs_calc_max_nss(le16_to_cpu(mcs_nss->rx_mcs_80),
+							 max_nss) + 1;
+			rx_mcs = le16_to_cpu(mcs_nss->rx_mcs_160);
+			max_nss_160 = cl_wrs_calc_max_nss(rx_mcs, max_nss) + 1;
+			max_nss = max_nss * max_nss_160 / max_nss_80;
+		} else {
+			wrs_pr_err(wrs_db, "bw %u is not supported\n", bw);
+		}
+
+		for (nss = 0; nss <= max_nss; nss++) {
+			switch ((rx_mcs >> (2 * nss)) & TWO_BITS_MASK) {
+			case IEEE80211_HE_MCS_SUPPORT_0_7:
+				supported_mcs = WRS_MCS_7;
+				break;
+			case IEEE80211_HE_MCS_SUPPORT_0_9:
+				supported_mcs = WRS_MCS_9;
+				break;
+			case IEEE80211_HE_MCS_SUPPORT_0_11:
+				supported_mcs = WRS_MCS_11;
+				break;
+			case IEEE80211_HE_MCS_NOT_SUPPORTED:
+				supported_mcs = -1;
+				break;
+			}
+
+			for (mcs = 0; mcs <= supported_mcs; mcs++)
+				cl_wrs_sta_set_supported_rate(wrs_sta, bw, nss, mcs);
+		}
+	}
+}
+
+static void cl_supported_rates_vht_cap(struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	u16 mcs_map = le16_to_cpu(sta->vht_cap.vht_mcs.rx_mcs_map);
+	u8 bw = 0;
+	u8 nss = 0;
+	int mcs = 0;
+	int supported_mcs = 0;
+
+	for (bw = 0; bw <= wrs_sta->max_rate_cap.bw; bw++) {
+		for (nss = 0; nss <= wrs_sta->max_rate_cap.nss; nss++) {
+			switch ((mcs_map >> (2 * nss)) & TWO_BITS_MASK) {
+			case 0:
+				supported_mcs = WRS_MCS_7;
+				break;
+			case 1:
+				supported_mcs = WRS_MCS_8;
+				break;
+			case 2:
+				supported_mcs = WRS_MCS_9;
+				break;
+			case 3:
+				supported_mcs = -1;
+				break;
+			}
+
+			for (mcs = 0; mcs <= supported_mcs; mcs++)
+				cl_wrs_sta_set_supported_rate(wrs_sta, bw, nss, mcs);
+		}
+	}
+}
+
+static void cl_supported_rates_ht_cap(struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	u8 bw = 0;
+	u8 nss = 0;
+	u8 mcs = 0;
+
+	for (mcs = 0; mcs <= WRS_MCS_7; mcs++) {
+		for (nss = 0; nss <= wrs_sta->max_rate_cap.nss; nss++) {
+			if ((ht_cap->mcs.rx_mask[nss] & (1 << mcs)) == 0)
+				continue;
+
+			for (bw = 0; bw <= wrs_sta->max_rate_cap.bw; bw++)
+				cl_wrs_sta_set_supported_rate(wrs_sta, bw, nss, mcs);
+		}
+	}
+}
+
+static void cl_supported_rates_legacy_cap(struct cl_hw *cl_hw,
+					  struct ieee80211_sta *sta,
+					  u8 max_mcs)
+{
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	u8 mcs = 0;
+
+	for (mcs = 0; mcs < max_mcs; mcs++)
+		if (rate_supported(sta, cl_hw->nl_band, mcs))
+			cl_wrs_sta_set_supported_rate(wrs_sta, CHNL_BW_20, WRS_SS_1, mcs);
+}
+
+void cl_wrs_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	struct cl_wrs_params *wrs_params = &wrs_sta->tx_su_params;
+
+	wrs_params->type = WRS_TYPE_TX_SU;
+	wrs_params->is_mu_valid = false;
+	wrs_params->rate_idx = WRS_INVALID_RATE;
+	wrs_params->initial_rate_idx = WRS_INVALID_RATE;
+
+	wrs_sta->sta_idx = cl_sta->sta_idx;
+	cl_wrs_rssi_prot_start(cl_hw, cl_sta);
+	cl_wrs_stats_per_init(wrs_params);
+	cl_wrs_sta_info_set(cl_hw, wrs_sta, sta);
+	cl_wrs_sta_capabilities_set(wrs_db, sta);
+	cl_wrs_tables_build(cl_hw, wrs_sta, wrs_params);
+	cl_wrs_sta_select_first_rate(cl_hw, wrs_db, wrs_sta, wrs_params);
+
+	wrs_pr_trace(wrs_db, "[%s] Add station %pM to database (sta_idx %u)\n",
+		     WRS_TYPE_STR(wrs_params->type), cl_sta->addr, cl_sta->sta_idx);
+}
+
+void cl_wrs_sta_add_rx(struct cl_hw *cl_hw, struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+	struct cl_wrs_params *wrs_params;
+
+	if (wrs_sta->rx_params) {
+		wrs_pr_warn(wrs_db, "[RX] Params already allocated (sta_idx %u)\n",
+			    wrs_sta->sta_idx);
+		return;
+	}
+
+	wrs_params = kzalloc(sizeof(*wrs_params), GFP_ATOMIC);
+
+	if (!wrs_params)
+		return;
+
+	wrs_sta->rx_params = wrs_params;
+	wrs_params->type = WRS_TYPE_RX;
+	wrs_params->is_mu_valid = false;
+	wrs_params->rate_idx = WRS_INVALID_RATE;
+	wrs_params->initial_rate_idx = WRS_INVALID_RATE;
+
+	wrs_sta->sta_idx = cl_sta->sta_idx;
+
+	cl_wrs_rssi_prot_start(cl_hw, cl_sta);
+	cl_wrs_stats_per_init(wrs_params);
+	cl_wrs_sta_info_set(cl_hw, wrs_sta, sta);
+	cl_wrs_sta_capabilities_set(wrs_db, sta);
+	cl_wrs_tables_build(cl_hw, wrs_sta, wrs_params);
+	cl_wrs_sta_select_first_rate(cl_hw, wrs_db, wrs_sta, wrs_params);
+	cl_wrs_rx_rate_idle_reset(wrs_params);
+
+	wrs_pr_trace(wrs_db, "[%s] Add station %pM to database (sta_idx %u)\n",
+		     WRS_TYPE_STR(wrs_params->type), cl_sta->addr, cl_sta->sta_idx);
+}
+
+static void _cl_wrs_sta_remove(struct cl_wrs_params *wrs_params)
+{
+	if (wrs_params->is_logger_en) {
+		kfree(wrs_params->logger);
+		wrs_params->logger = NULL;
+	}
+
+	kfree(wrs_params->table);
+	wrs_params->table = NULL;
+
+	cl_wrs_stats_per_remove(wrs_params);
+}
+
+static void cl_wrs_sta_remove_rx(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta)
+{
+	struct cl_wrs_params *wrs_params = wrs_sta->rx_params;
+
+	if (!wrs_params) {
+		wrs_pr_warn(wrs_db, "[RX] Params already removed (sta_idx %u)\n",
+			    wrs_sta->sta_idx);
+		return;
+	}
+
+	_cl_wrs_sta_remove(wrs_params);
+
+	kfree(wrs_params);
+	wrs_sta->rx_params = NULL;
+
+	wrs_pr_err(wrs_db, "[RX] Remove params (sta_idx %u)\n", wrs_sta->sta_idx);
+}
+
+void cl_wrs_sta_remove(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db, struct cl_sta *cl_sta)
+{
+	struct cl_wrs_sta *wrs_sta = &cl_sta->wrs_sta;
+
+	_cl_wrs_sta_remove(&wrs_sta->tx_su_params);
+
+	if (wrs_sta->rx_params)
+		cl_wrs_sta_remove_rx(wrs_db, wrs_sta);
+	wrs_pr_trace(wrs_db, "Remove station %pM from database (sta_idx %u)\n",
+		     cl_sta->addr, cl_sta->sta_idx);
+}
+
+struct cl_wrs_sta *cl_wrs_sta_get(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	struct cl_sta *cl_sta = cl_sta_get(cl_hw, sta_idx);
+
+	return cl_sta ? &cl_sta->wrs_sta : NULL;
+}
+
+void cl_wrs_sta_select_first_rate(struct cl_hw *cl_hw, struct cl_wrs_db *wrs_db,
+				  struct cl_wrs_sta *wrs_sta, struct cl_wrs_params *wrs_params)
+{
+	if (wrs_db->is_fixed_rate) {
+		s8 *fixed_rate = cl_hw->conf->ci_wrs_fixed_rate;
+
+		cl_wrs_fixed_rate_set(cl_hw, wrs_db, wrs_sta, wrs_params, wrs_db->is_fixed_rate,
+				      fixed_rate[WRS_FIXED_PARAM_MODE],
+				      fixed_rate[WRS_FIXED_PARAM_BW],
+				      fixed_rate[WRS_FIXED_PARAM_NSS],
+				      fixed_rate[WRS_FIXED_PARAM_MCS],
+				      fixed_rate[WRS_FIXED_PARAM_GI], 0);
+	} else {
+		struct cl_sta *cl_sta = container_of(wrs_sta, struct cl_sta, wrs_sta);
+		struct cl_wrs_rate_params *vif_fixed_params = &cl_sta->cl_vif->fixed_params;
+
+		if (vif_fixed_params->is_fixed)
+			cl_wrs_fixed_rate_set(cl_hw, wrs_db, wrs_sta, wrs_params,
+					      WRS_FIXED_FALLBACK_DIS,
+					      vif_fixed_params->mode,
+					      vif_fixed_params->bw,
+					      vif_fixed_params->nss,
+					      vif_fixed_params->mcs,
+					      vif_fixed_params->gi, 0);
+	}
+
+	if (!wrs_params->is_fixed_rate) {
+		bool result = cl_wrs_set_rate_idle(cl_hw, wrs_db, wrs_sta, wrs_params);
+
+		/*
+		 * If new rate wasn't selected according to
+		 * rssi (no samples) or data packets set rate to lowest possible
+		 */
+		if (!result)
+			cl_wrs_rate_params_update(cl_hw, wrs_db, wrs_sta,
+						  wrs_params, 0, false, false);
+	}
+}
+
+void cl_wrs_sta_capabilities_set(struct cl_wrs_db *wrs_db, struct ieee80211_sta *sta)
+{
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+	enum cl_wrs_mode mode = cl_sta->wrs_sta.mode;
+
+	if (mode == WRS_MODE_HE) {
+		cl_supported_rates_he_cap(wrs_db, sta);
+	} else if (mode == WRS_MODE_VHT) {
+		cl_supported_rates_vht_cap(sta);
+	} else if (mode == WRS_MODE_HT) {
+		cl_supported_rates_ht_cap(sta);
+	} else {
+		struct cl_hw *cl_hw = cl_sta->cl_vif->cl_hw;
+		u8 max_mcs = (mode == WRS_MODE_OFDM) ? WRS_MCS_MAX_OFDM : WRS_MCS_MAX_CCK;
+
+		cl_supported_rates_legacy_cap(cl_hw, sta, max_mcs);
+	}
+}
+
+void cl_wrs_sta_set_supported_rate(struct cl_wrs_sta *wrs_sta, u8 bw, u8 nss, u8 mcs)
+{
+	u8 rate_idx = mcs + (nss * WRS_MCS_MAX);
+
+	wrs_sta->supported_rates[bw] |= BIT(rate_idx);
+}
+
+static struct cl_wrs_per_stats *cl_wrs_stats_per_entry(struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_per_stats *per_stats = NULL, *per_stats_new = NULL;
+	struct cl_wrs_rate_params *rate_params = &wrs_params->rate_params;
+	struct list_head *list_rates = &wrs_params->list_rates;
+	u8 bw = rate_params->bw;
+	u8 nss = rate_params->nss;
+	u8 mcs = rate_params->mcs;
+	u8 gi = rate_params->gi;
+
+	list_for_each_entry(per_stats, list_rates, list) {
+		if (per_stats->bw != bw ||
+		    per_stats->nss != nss ||
+		    per_stats->mcs != mcs ||
+		    per_stats->gi != gi)
+			continue;
+
+		/*
+		 * Move the entry to the beginning of the list, so that it
+		 * will be faster to find next time.
+		 */
+		if (per_stats != list_entry(list_rates->next, struct cl_wrs_per_stats, list)) {
+			list_del(&per_stats->list);
+			list_add(&per_stats->list, list_rates);
+		}
+
+		return per_stats;
+	}
+
+	/* Entry not found - allocate new entry and add to list */
+	per_stats_new = kzalloc(sizeof(*per_stats_new), GFP_ATOMIC);
+
+	if (!per_stats_new)
+		return NULL;
+
+	per_stats_new->bw = bw;
+	per_stats_new->nss = nss;
+	per_stats_new->mcs = mcs;
+	per_stats_new->gi = gi;
+
+	list_add(&per_stats_new->list, &wrs_params->list_rates);
+
+	return per_stats_new;
+}
+
+void cl_wrs_stats_per_update(struct cl_wrs_db *wrs_db,
+			     struct cl_wrs_sta *wrs_sta,
+			     struct cl_wrs_params *wrs_params,
+			     struct cl_wrs_cntrs *cntrs)
+{
+	u16 curr_rate_idx = wrs_params->rate_idx;
+	struct cl_wrs_table *table_node = &wrs_params->table[curr_rate_idx];
+	struct cl_wrs_per_stats *per_stats = cl_wrs_stats_per_entry(wrs_params);
+
+	if (!per_stats)
+		return;
+
+	wrs_params->frames_total += cntrs->total;
+	wrs_params->fail_total += cntrs->fail;
+	wrs_params->ba_not_rcv_total += cntrs->ba_not_rcv;
+	wrs_params->epr_acc += cntrs->epr_acc;
+
+	per_stats->frames_total += cntrs->total;
+	per_stats->frames_failed += cntrs->fail;
+	per_stats->epr_acc += cntrs->epr_acc;
+
+	if (wrs_params->calc_ba_not_rcv) {
+		per_stats->frames_total += cntrs->ba_not_rcv;
+		per_stats->frames_failed += cntrs->ba_not_rcv;
+	}
+
+	table_node->frames_total = wrs_params->frames_total;
+	table_node->ba_not_rcv_total = wrs_params->ba_not_rcv_total;
+	table_node->epr_acc = wrs_params->epr_acc;
+}
+
+void cl_wrs_stats_per_init(struct cl_wrs_params *wrs_params)
+{
+	INIT_LIST_HEAD(&wrs_params->list_rates);
+}
+
+void cl_wrs_stats_per_remove(struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_per_stats *per_stats = NULL, *per_stats_next = NULL;
+
+	list_for_each_entry_safe(per_stats, per_stats_next, &wrs_params->list_rates, list) {
+		list_del(&per_stats->list);
+		kfree(per_stats);
+	}
+}
+
+static struct cl_wrs_table
+	ap_rate_table_he[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_HE][WRS_GI_MAX_HE];
+static struct cl_wrs_table
+	ap_rate_table_ht_vht[CHNL_BW_MAX][WRS_SS_MAX][WRS_MCS_MAX_VHT][WRS_GI_MAX_VHT];
+
+/* Rate indexes sorted by data rate */
+static u16 rate_idx_sorted_by_data_rate_he[WRS_HE_RATE_TABLE_SIZE] = {0};
+static u16 rate_idx_sorted_by_data_rate_ht_vht[WRS_HT_VHT_RATE_TABLE_SIZE] = {0};
+
+static void cl_wrs_extract_rate_idx_vht(u16 idx, u8 *bw, u8 *nss, u8 *mcs, u8 *gi)
+{
+	*gi = idx % WRS_GI_MAX_VHT;
+	idx = (idx - *gi) / WRS_GI_MAX_VHT;
+	*mcs = idx % WRS_MCS_MAX_VHT;
+	idx = (idx - *mcs) / WRS_MCS_MAX_VHT;
+	*nss = idx % WRS_SS_MAX;
+	*bw = (idx - *nss) / CHNL_BW_MAX;
+}
+
+static void cl_wrs_extract_rate_idx_he(u16 idx, u8 *bw, u8 *nss, u8 *mcs, u8 *gi)
+{
+	*gi = idx % WRS_GI_MAX_HE;
+	idx = (idx - *gi) / WRS_GI_MAX_HE;
+	*mcs = idx % WRS_MCS_MAX_HE;
+	idx = (idx - *mcs) / WRS_MCS_MAX_HE;
+	*nss = idx % WRS_SS_MAX;
+	*bw = (idx - *nss) / CHNL_BW_MAX;
+}
+
+static void cl_wrs_tables_build_sorted_ht_vht(void)
+{
+	/* Sort according to HT/VHT data rate */
+	u16 i, j;
+	u8 bw1, nss1, mcs1, gi1, bw2, nss2, mcs2, gi2;
+
+	for (i = 0; i < WRS_HT_VHT_RATE_TABLE_SIZE; i++)
+		rate_idx_sorted_by_data_rate_ht_vht[i] = i;
+
+	for (i = 0; i < WRS_HT_VHT_RATE_TABLE_SIZE - 1; i++) {
+		for (j = 0; j < WRS_HT_VHT_RATE_TABLE_SIZE - i - 1; j++) {
+			cl_wrs_extract_rate_idx_vht(rate_idx_sorted_by_data_rate_ht_vht[j],
+						    &bw1, &nss1, &mcs1, &gi1);
+			cl_wrs_extract_rate_idx_vht(rate_idx_sorted_by_data_rate_ht_vht[j + 1],
+						    &bw2, &nss2, &mcs2, &gi2);
+
+			if (data_rate_ht_vht_x10[bw1][nss1][mcs1][gi1] >
+			    data_rate_ht_vht_x10[bw2][nss2][mcs2][gi2])
+				swap(rate_idx_sorted_by_data_rate_ht_vht[j],
+				     rate_idx_sorted_by_data_rate_ht_vht[j + 1]);
+		}
+	}
+}
+
+static void cl_wrs_tables_build_sorted_he(void)
+{
+	/* Sort according to HE data rate */
+	u16 i, j;
+	u8 bw1, nss1, mcs1, gi1, bw2, nss2, mcs2, gi2;
+
+	for (i = 0; i < WRS_HE_RATE_TABLE_SIZE; i++)
+		rate_idx_sorted_by_data_rate_he[i] = i;
+
+	for (i = 0; i < WRS_HE_RATE_TABLE_SIZE - 1; i++) {
+		for (j = 0; j < WRS_HE_RATE_TABLE_SIZE - i - 1; j++) {
+			cl_wrs_extract_rate_idx_he(rate_idx_sorted_by_data_rate_he[j],
+						   &bw1, &nss1, &mcs1, &gi1);
+			cl_wrs_extract_rate_idx_he(rate_idx_sorted_by_data_rate_he[j + 1],
+						   &bw2, &nss2, &mcs2, &gi2);
+
+			if (data_rate_he_x10[nss1][bw1][mcs1][gi1] >
+			    data_rate_he_x10[nss2][bw2][mcs2][gi2])
+				swap(rate_idx_sorted_by_data_rate_he[j],
+				     rate_idx_sorted_by_data_rate_he[j + 1]);
+		}
+	}
+}
+
+static u16 idx_to_offt_ht_vht(u32 bw, u32 nss, u32 mcs, u32 gi)
+{
+	if (bw < CHNL_BW_MAX &&
+	    nss < WRS_SS_MAX &&
+	    mcs < WRS_MCS_MAX_VHT &&
+	    gi < WRS_GI_MAX_VHT)
+		return (gi + WRS_GI_MAX_VHT * (mcs + WRS_MCS_MAX_VHT * (nss + bw * WRS_SS_MAX)));
+	else
+		return -1;
+}
+
+static u16 idx_to_offt_he(u32 bw, u32 nss, u32 mcs, u32 gi)
+{
+	if (bw < CHNL_BW_MAX &&
+	    nss < WRS_SS_MAX &&
+	    mcs < WRS_MCS_MAX_HE &&
+	    gi < WRS_GI_MAX_HE)
+		return (gi + WRS_GI_MAX_HE * (mcs + WRS_MCS_MAX_HE * (nss + bw * WRS_SS_MAX)));
+	else
+		return -1;
+}
+
+static u16 find_down_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi, u16 *data_rates,
+			      u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	u16 idx;
+
+	if (mcs > 0) {
+		idx = idx_to_offt(bw, nss, mcs - 1, gi);
+		if (data_rates[idx])
+			return idx;
+		if (mcs > 1)
+			return idx_to_offt(bw, nss, mcs - 2, gi);
+	}
+
+	if (bw > 0) {
+		idx = idx_to_offt(bw - 1, nss, mcs, gi);
+		if (data_rates[idx])
+			return idx;
+		if (bw > 1)
+			return idx_to_offt(bw - 2, nss, mcs, gi);
+	}
+
+	if (nss > 0) {
+		idx = idx_to_offt(bw, nss - 1, mcs, gi);
+		if (data_rates[idx])
+			return idx;
+		if (nss > 1) {
+			idx = idx_to_offt(bw, nss - 2, mcs, gi);
+			if (data_rates[idx])
+				return idx;
+		}
+	}
+
+	if (gi > 0)
+		return idx_to_offt(bw, nss, mcs, gi - 1);
+
+	return 0;
+}
+
+static u16 find_up_mcs_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi, u16 *data_rates,
+				u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	s16 idx = idx_to_offt(bw, nss, mcs + 1, gi);
+
+	if (idx < 0 || !data_rates[idx])
+		idx = idx_to_offt(bw, nss, mcs + 2, gi);
+
+	return (idx < 0) ? WRS_INVALID_RATE : idx;
+}
+
+static u16 find_up_bw_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+			       u16 *data_rates,
+			       u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	s16 cur_data_rate = data_rates[idx_to_offt(bw, nss, mcs, gi)];
+	s16 min_idx = WRS_INVALID_RATE;
+	s16 idx;
+	s32 min_rate_diff = S32_MAX;
+	s32 rate_diff;
+
+	for (idx = idx_to_offt(++bw, nss, mcs, gi); !(idx < 0);
+	     idx = idx_to_offt(bw, nss, --mcs, gi)) {
+		/*
+		 * If data_rates[idx] == 0, the difference will be negative,
+		 * so the condition below will not hold.
+		 * Therefore, no need to check this possiblity specifically.
+		 */
+		rate_diff = data_rates[idx] - cur_data_rate;
+		if (rate_diff > 0 &&
+		    rate_diff < min_rate_diff &&
+		    (data_rates[idx] * 100) > (cur_data_rate * WRS_EPR_FACTOR)) {
+			min_rate_diff = rate_diff;
+			min_idx = idx;
+		}
+	}
+
+	return min_idx;
+}
+
+static u16 find_up_nss_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+				u16 *data_rates,
+				u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	s16 cur_data_rate = data_rates[idx_to_offt(bw, nss, mcs, gi)];
+	s16 min_idx = WRS_INVALID_RATE;
+	s16 idx;
+	s32 min_rate_diff = S32_MAX;
+	s32 rate_diff;
+
+	for (idx = idx_to_offt(bw, ++nss, mcs, gi); !(idx < 0);
+	     idx = idx_to_offt(bw, nss, --mcs, gi)) {
+		/*
+		 * If data_rates[idx] == 0, the difference will be negative,
+		 * so the condition below will not hold.
+		 * Therefore, no need to check this possiblity specifically.
+		 */
+		rate_diff = data_rates[idx] - cur_data_rate;
+		if (rate_diff > 0 &&
+		    rate_diff < min_rate_diff &&
+		    (data_rates[idx] * 100) > (cur_data_rate * WRS_EPR_FACTOR)) {
+			min_rate_diff = rate_diff;
+			min_idx = idx;
+		}
+	}
+
+	return min_idx;
+}
+
+static u16 find_up_bf_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+			       u16 *data_rates,
+			       u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	s16 cur_data_rate = data_rates[idx_to_offt(bw, nss, mcs, gi)];
+	s16 min_idx = WRS_INVALID_RATE;
+	s16 idx;
+	s32 min_rate_diff = S32_MAX;
+	s16 rate_diff;
+
+	for (idx = idx_to_offt(bw, --nss, mcs, gi); !(idx < 0);
+	     idx = idx_to_offt(bw, nss, ++mcs, gi)) {
+		/*
+		 * If data_rates[idx] == 0, the difference will be negative,
+		 * so the condition below will not hold.
+		 * Therefore, no need to check this possiblity specifically.
+		 */
+		rate_diff = data_rates[idx] - cur_data_rate;
+		if (rate_diff > 0 &&
+		    rate_diff < min_rate_diff &&
+		    (data_rates[idx] * 100) > (cur_data_rate * WRS_EPR_FACTOR)) {
+			min_rate_diff = rate_diff;
+			min_idx = idx;
+		}
+	}
+
+	return min_idx;
+}
+
+static u16 find_up_gi_rate_idx(u32 bw, u32 nss, u32 mcs, u32 gi,
+			       u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	s16 idx = idx_to_offt(bw, nss, mcs, gi + 1);
+
+	return (idx < 0) ? WRS_INVALID_RATE : idx;
+}
+
+static void _cl_wrs_tables_init(struct cl_wrs_table *ap_rate_table,
+				u16 *data_rates,
+				u32 bw, u32 nss, u32 mcs, u32 gi,
+				u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi))
+{
+	struct cl_wrs_table *cur_entry = NULL;
+	int i = 0;
+	u16 offt = idx_to_offt(bw, nss, mcs, gi);
+
+	cur_entry = &ap_rate_table[offt];
+	cur_entry->rate.bw = bw;
+	cur_entry->rate.nss = nss;
+	cur_entry->rate.mcs = mcs;
+	cur_entry->rate.gi = gi;
+
+	/* If current rate is invalid, mark it as such and skip it. */
+	if (!data_rates[offt]) {
+		cur_entry->rate_down.rate_idx = WRS_INVALID_RATE;
+		cur_entry->rate_down.time_th = WRS_MSEC_WEIGHT_MAX_DOWN;
+
+		for (i = 0; i < WRS_TABLE_NODE_UP_MAX; i++) {
+			cur_entry->rate_up[i].rate_idx = WRS_INVALID_RATE;
+			cur_entry->rate_up[i].time_th = WRS_MSEC_WEIGHT_MAX_UP;
+		}
+
+		return;
+	}
+
+	cur_entry->rate_down.rate_idx =
+		find_down_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_offt);
+	cur_entry->rate_up[WRS_TABLE_NODE_UP_MCS].rate_idx =
+		find_up_mcs_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_offt);
+	cur_entry->rate_up[WRS_TABLE_NODE_UP_BW].rate_idx =
+		find_up_bw_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_offt);
+	cur_entry->rate_up[WRS_TABLE_NODE_UP_NSS].rate_idx =
+		find_up_nss_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_offt);
+	cur_entry->rate_up[WRS_TABLE_NODE_UP_BF].rate_idx =
+		find_up_bf_rate_idx(bw, nss, mcs, gi, data_rates, idx_to_offt);
+	cur_entry->rate_up[WRS_TABLE_NODE_UP_GI].rate_idx =
+		find_up_gi_rate_idx(bw, nss, mcs, gi, idx_to_offt);
+
+	cur_entry->rate_down.time_th = WRS_INIT_MSEC_WEIGHT_DOWN;
+
+	for (i = 0; i < WRS_TABLE_NODE_UP_MAX; i++)
+		cur_entry->rate_up[i].time_th =
+			(cur_entry->rate_up[i].rate_idx == WRS_INVALID_RATE) ?
+			WRS_MSEC_WEIGHT_MAX_UP : WRS_INIT_MSEC_WEIGHT_UP;
+}
+
+static void cl_wrs_tables_init(u8 mode)
+{
+	u32 bw, nss, mcs, gi;
+	u32 max_bw, max_nss, max_mcs, max_gi;
+	u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi);
+	struct cl_wrs_table *ap_rate_table = NULL;
+	u16 *data_rates = NULL;
+
+	if (mode == WRS_MODE_HE) {
+		idx_to_offt = idx_to_offt_he;
+		max_bw = CHNL_BW_MAX;
+		max_nss = WRS_SS_MAX;
+		max_mcs = WRS_MCS_MAX_HE;
+		max_gi = WRS_GI_MAX_HE;
+		ap_rate_table = (struct cl_wrs_table *)ap_rate_table_he;
+		data_rates = (u16 *)data_rate_he_x10;
+	} else if (mode == WRS_MODE_VHT) {
+		idx_to_offt = idx_to_offt_ht_vht;
+		max_bw = CHNL_BW_MAX;
+		max_nss = WRS_SS_MAX;
+		max_mcs = WRS_MCS_MAX_VHT;
+		max_gi = WRS_GI_MAX_VHT;
+		ap_rate_table = (struct cl_wrs_table *)ap_rate_table_ht_vht;
+		data_rates = (u16 *)data_rate_ht_vht_x10;
+	} else {
+		return;
+	}
+
+	for (bw = 0; bw < max_bw; bw++)
+		for (nss = 0; nss < max_nss; nss++)
+			for (mcs = 0; mcs < max_mcs; mcs++)
+				for (gi = 0; gi < max_gi; gi++)
+					_cl_wrs_tables_init(ap_rate_table,
+							    data_rates,
+							    bw,
+							    nss,
+							    mcs,
+							    gi,
+							    idx_to_offt);
+}
+
+void cl_wrs_tables_global_build(void)
+{
+	cl_wrs_tables_init(WRS_MODE_HE);
+	cl_wrs_tables_init(WRS_MODE_VHT);
+	cl_wrs_tables_build_sorted_he();
+	cl_wrs_tables_build_sorted_ht_vht();
+}
+
+void cl_wrs_tables_reset(struct cl_wrs_db *wrs_db, struct cl_wrs_sta *wrs_sta,
+			 struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_table_node *rate_up;
+	u16 rate_idx = 0;
+	u8 up_idx = 0;
+
+	for (rate_idx = 0; rate_idx < wrs_params->table_size; rate_idx++) {
+		if (wrs_params->table[rate_idx].rate_down.rate_idx != WRS_INVALID_RATE)
+			wrs_params->table[rate_idx].rate_down.time_th = WRS_INIT_MSEC_WEIGHT_DOWN;
+		else
+			wrs_params->table[rate_idx].rate_down.time_th = wrs_db->time_th_max_down;
+
+		wrs_params->table[rate_idx].rate_down.quick_up_check = false;
+
+		for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+			rate_up = &wrs_params->table[rate_idx].rate_up[up_idx];
+
+			if (rate_up->rate_idx != WRS_INVALID_RATE)
+				rate_up->time_th = WRS_INIT_MSEC_WEIGHT_UP;
+			else
+				rate_up->time_th = wrs_db->time_th_max_up;
+
+			rate_up->quick_up_check = false;
+		}
+
+		wrs_params->table[rate_idx].frames_total = 0;
+		wrs_params->table[rate_idx].ba_not_rcv_total = 0;
+		wrs_params->table[rate_idx].epr_acc = 0;
+	}
+}
+
+static bool cl_wrs_is_rate_valid_he(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+				    struct cl_wrs_params *wrs_params, u8 bw,
+				    u8 nss, u8 mcs, u8 gi)
+{
+	/* Disable rates according to ce_he_mcs_nss_supp_tx */
+	if ((cl_hw->conf->ce_he_mcs_nss_supp_tx[nss] + 1) <= mcs)
+		return false;
+
+	/* TB flow doesn't support 0.8us GI */
+	if (WRS_TYPE_IS_RX(wrs_params) && gi == WRS_GI_VSHORT)
+		return false;
+
+	if (data_rate_he_x10[nss][bw][mcs][gi] < (10 * wrs_sta->he_minrate))
+		return false;
+
+	return true;
+}
+
+static bool cl_wrs_is_rate_valid_vht(struct cl_hw *cl_hw, u8 bw, u8 nss, u8 mcs)
+{
+	/* Disable BW160 */
+	if (bw == CHNL_BW_160)
+		return false;
+
+	/* Disable VHT invalid rates (MCS9 20M 1SS, MCS9 20M 2SS, MCS6 80M 3SS, MCS9 20M 4SS) */
+	if (bw == CHNL_BW_20 && mcs == WRS_MCS_9)
+		if (nss == WRS_SS_1 || nss == WRS_SS_2 || nss == WRS_SS_4)
+			return false;
+
+	if (bw == CHNL_BW_80 && mcs == WRS_MCS_6 && nss == WRS_SS_3)
+		return false;
+
+	/* Disable rates according to ce_vht_mcs_nss_supp_tx */
+	if ((cl_hw->conf->ce_vht_mcs_nss_supp_tx[nss] + 1) <= mcs)
+		return false;
+
+	return true;
+}
+
+static bool cl_wrs_is_rate_valid(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+				 struct cl_wrs_params *wrs_params,
+				 u8 mode, u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+	if (gi > wrs_db->max_cap.gi || gi > wrs_sta->gi_cap[bw])
+		return false;
+
+	if (mode == WRS_MODE_HE)
+		return cl_wrs_is_rate_valid_he(cl_hw, wrs_sta, wrs_params, bw, nss, mcs, gi);
+
+	if (mode == WRS_MODE_VHT)
+		return cl_wrs_is_rate_valid_vht(cl_hw, bw, nss, mcs);
+
+	return true;
+}
+
+static bool cl_wrs_is_rate_supported(u64 *rate_bitmap, u8 bw, u8 nss, u8 mcs)
+{
+	u8 rate_idx = mcs + (nss * WRS_MCS_MAX);
+	u64 mask = BIT(rate_idx);
+
+	return rate_bitmap[bw] & mask;
+}
+
+static bool cl_wrs_tables_is_up_invalid(struct cl_wrs_table *table)
+{
+	/*
+	 * The UP_GI is not part of this if condition, because we would
+	 * like to set the same up candidate for LGI & SGI (except the
+	 * up from LGI to SGI).
+	 */
+	return ((table->rate_up[WRS_TABLE_NODE_UP_MCS].rate_idx == WRS_INVALID_RATE) &&
+		(table->rate_up[WRS_TABLE_NODE_UP_BW].rate_idx == WRS_INVALID_RATE) &&
+		(table->rate_up[WRS_TABLE_NODE_UP_NSS].rate_idx == WRS_INVALID_RATE) &&
+		(table->rate_up[WRS_TABLE_NODE_UP_BF].rate_idx == WRS_INVALID_RATE) &&
+		(table->rate_up[WRS_TABLE_NODE_UP_GI].rate_idx == WRS_INVALID_RATE));
+}
+
+static int cl_wrs_tables_max(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+			     u8 *max_bw, u8 *max_nss, u8 *max_mcs, u8 *max_gi)
+{
+	*max_bw = wrs_sta->max_rate_cap.bw;
+	*max_nss = wrs_sta->smps_enable ? WRS_SS_1 : wrs_sta->max_rate_cap.nss;
+
+	switch (wrs_sta->mode) {
+	case WRS_MODE_CCK:
+		*max_mcs = WRS_MCS_3;
+		*max_gi = WRS_GI_LONG;
+		break;
+	case WRS_MODE_OFDM:
+		*max_mcs = WRS_MCS_7;
+		*max_gi = WRS_GI_LONG;
+		break;
+	case WRS_MODE_HT:
+		*max_mcs = WRS_MCS_7;
+		*max_gi = WRS_GI_SHORT;
+		break;
+	case WRS_MODE_VHT:
+		*max_mcs = WRS_MCS_9;
+		*max_gi = WRS_GI_SHORT;
+		break;
+	case WRS_MODE_HE:
+		*max_mcs = WRS_MCS_11;
+		*max_gi = WRS_GI_VSHORT;
+
+		if (!cl_hw->conf->ce_txldpc_en) {
+			struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+
+			wrs_pr_verbose(wrs_db,
+				       "TX LDPC disabled: limit BW to 20MHz and MCS to 9\n");
+			*max_mcs = WRS_MCS_9;
+			*max_bw = CHNL_BW_20;
+		}
+		break;
+	default:
+		return -1;
+	}
+
+	return 0;
+}
+
+void cl_wrs_tables_build(struct cl_hw *cl_hw, struct cl_wrs_sta *wrs_sta,
+			 struct cl_wrs_params *wrs_params)
+{
+	struct cl_wrs_db *wrs_db = &cl_hw->wrs_db;
+	u8 bw = 0;
+	u8 nss = 0;
+	u8 mcs = 0;
+	u8 gi = 0;
+	u8 max_bw = 0;
+	u8 max_nss = 0;
+	u8 max_mcs = 0;
+	u8 max_gi = 0;
+	u8 up_idx = 0;
+	u8 type = wrs_params->type;
+	u16 rate_idx = 0;
+	u16 new_rate_idx = 0;
+	u16 tmp_rate_idx = 0;
+	u16 max_table_size = 0;
+	u16 new_table_size = 0;
+	u16 (*idx_to_offt)(u32 bw, u32 nss, u32 mcs, u32 gi);
+	u16 *rate_idx_sorted_by_data_rate;
+	struct cl_wrs_table *ap_rate_table;
+	struct cl_wrs_table *new_table = NULL;
+	struct cl_wrs_table_validity *valid_rates = NULL;
+
+	if (cl_wrs_tables_max(cl_hw, wrs_sta, &max_bw, &max_nss, &max_mcs, &max_gi))
+		return;
+
+	if (wrs_sta->mode == WRS_MODE_HE) {
+		max_table_size = WRS_HE_RATE_TABLE_SIZE;
+		idx_to_offt = idx_to_offt_he;
+		ap_rate_table = (struct cl_wrs_table *)ap_rate_table_he;
+		rate_idx_sorted_by_data_rate = rate_idx_sorted_by_data_rate_he;
+	} else {
+		max_table_size = WRS_HT_VHT_RATE_TABLE_SIZE;
+		idx_to_offt = idx_to_offt_ht_vht;
+		ap_rate_table = (struct cl_wrs_table *)ap_rate_table_ht_vht;
+		rate_idx_sorted_by_data_rate = rate_idx_sorted_by_data_rate_ht_vht;
+	}
+
+	valid_rates = kzalloc(max_table_size * sizeof(struct cl_wrs_table_validity), GFP_ATOMIC);
+	if (!valid_rates)
+		goto out;
+
+	wrs_sta->max_rate_cap.mcs = WRS_MCS_0;
+	wrs_sta->max_rate_cap.gi = WRS_GI_LONG;
+
+	for (bw = 0; bw <= max_bw; bw++) {
+		for (nss = 0; nss <= max_nss; nss++) {
+			for (mcs = 0; mcs <= max_mcs; mcs++) {
+				for (gi = 0; gi <= max_gi; gi++) {
+					rate_idx = idx_to_offt(bw, nss, mcs, gi);
+					valid_rates[rate_idx].is_valid =
+						cl_wrs_is_rate_supported(wrs_sta->supported_rates,
+									 bw, nss, mcs) &&
+						cl_wrs_is_rate_supported(wrs_db->ap_supported_rates,
+									 bw, nss, mcs) &&
+						cl_wrs_is_rate_valid(cl_hw, wrs_sta, wrs_params,
+								     wrs_sta->mode,
+								     bw, nss, mcs, gi);
+
+					if (!valid_rates[rate_idx].is_valid)
+						continue;
+
+					valid_rates[rate_idx].new_rate_idx = new_table_size;
+					new_table_size++;
+
+					if (WRS_TYPE_IS_TX_MU_MIMO(wrs_params))
+						continue;
+
+					if (mcs > wrs_sta->max_rate_cap.mcs)
+						wrs_sta->max_rate_cap.mcs = mcs;
+
+					if (gi > wrs_sta->max_rate_cap.gi)
+						wrs_sta->max_rate_cap.gi = gi;
+				}
+			}
+		}
+	}
+
+	if (new_table_size == 0) {
+		/* Error - size of table is 0, add single rate (mcs 0, 1 SS, bw 20 Mhz) */
+		wrs_pr_err(wrs_db, "[%s] Table build error - Size of table is 0\n",
+			   WRS_TYPE_STR(type));
+		cl_wrs_sta_set_supported_rate(wrs_sta, CHNL_BW_20, WRS_SS_1, WRS_MCS_0);
+		valid_rates[0].new_rate_idx = 0;
+		valid_rates[0].is_valid = 1;
+		new_table_size = 1;
+	}
+
+	new_table = kzalloc(new_table_size * sizeof(struct cl_wrs_table), GFP_ATOMIC);
+
+	if (!new_table)
+		goto out;
+
+	for (rate_idx = 0; rate_idx < max_table_size; rate_idx++) {
+		if (!valid_rates[rate_idx].is_valid)
+			continue;
+
+		memcpy(new_table + new_rate_idx,
+		       ap_rate_table + rate_idx,
+		       sizeof(struct cl_wrs_table));
+
+		/* Set down rate */
+		tmp_rate_idx = ap_rate_table[rate_idx].rate_down.rate_idx;
+
+		while ((!valid_rates[tmp_rate_idx].is_valid) &&
+		       (ap_rate_table[tmp_rate_idx].rate_down.rate_idx != tmp_rate_idx))
+			tmp_rate_idx = ap_rate_table[tmp_rate_idx].rate_down.rate_idx;
+
+		if (valid_rates[tmp_rate_idx].is_valid) {
+			new_table[new_rate_idx].rate_down.rate_idx =
+				valid_rates[tmp_rate_idx].new_rate_idx;
+		} else {
+			u16 i = 0;
+			u16 down_idx = 0;
+			u16 down_rate_idx = new_rate_idx;
+
+			while (new_table[new_rate_idx].rate_down.rate_idx !=
+			       rate_idx_sorted_by_data_rate[i]) {
+				down_idx = rate_idx_sorted_by_data_rate[i];
+
+				if (valid_rates[down_idx].is_valid)
+					down_rate_idx = valid_rates[down_idx].new_rate_idx;
+				i++;
+			}
+
+			new_table[new_rate_idx].rate_down.rate_idx = down_rate_idx;
+		}
+
+		/* Set up rates */
+		for (up_idx = 0; up_idx < WRS_TABLE_NODE_UP_MAX; up_idx++) {
+			tmp_rate_idx = new_table[new_rate_idx].rate_up[up_idx].rate_idx;
+
+			if (tmp_rate_idx != WRS_INVALID_RATE &&
+			    valid_rates[tmp_rate_idx].is_valid)
+				new_table[new_rate_idx].rate_up[up_idx].rate_idx =
+					valid_rates[tmp_rate_idx].new_rate_idx;
+			else
+				new_table[new_rate_idx].rate_up[up_idx].rate_idx = WRS_INVALID_RATE;
+		}
+
+		/*
+		 * In case all the UP rates are invalid, find one available UP
+		 * rate based on PHY rate
+		 */
+		if (cl_wrs_tables_is_up_invalid(&new_table[new_rate_idx])) {
+			u16 i = 0;
+
+			for (i = 0; i < max_table_size; i++)
+				if (rate_idx == rate_idx_sorted_by_data_rate[i])
+					break;
+
+			i++;
+
+			while (i < max_table_size) {
+				tmp_rate_idx = rate_idx_sorted_by_data_rate[i];
+				if (!valid_rates[tmp_rate_idx].is_valid) {
+					i++;
+					continue;
+				}
+
+				new_table[new_rate_idx].rate_up[WRS_TABLE_NODE_UP_MCS].rate_idx =
+					valid_rates[tmp_rate_idx].new_rate_idx;
+				break;
+			}
+		}
+
+		new_rate_idx++;
+	}
+
+	if (wrs_params->table) {
+		/*
+		 * Copy epr_acc, frames_total and ba_not_rcv_total
+		 * from the old table to the new table.
+		 * Also, if initial_rate_idx is set, find the new
+		 * value in the new table.
+		 */
+		u16 old_rate_idx = 0;
+		struct cl_wrs_rate *initial_old_rate = NULL;
+
+		if (wrs_params->initial_rate_idx != WRS_INVALID_RATE) {
+			initial_old_rate = &wrs_params->table[wrs_params->initial_rate_idx].rate;
+			wrs_params->initial_rate_idx = WRS_INVALID_RATE;
+		}
+
+		for (rate_idx = 0; rate_idx < new_table_size; rate_idx++) {
+			old_rate_idx = cl_wrs_tables_find_rate_idx(wrs_params,
+								   new_table[rate_idx].rate.bw,
+								   new_table[rate_idx].rate.nss,
+								   new_table[rate_idx].rate.mcs,
+								   new_table[rate_idx].rate.gi);
+
+			if (initial_old_rate &&
+			    new_table[rate_idx].rate.bw == initial_old_rate->bw &&
+			    new_table[rate_idx].rate.nss == initial_old_rate->nss &&
+			    new_table[rate_idx].rate.mcs == initial_old_rate->mcs &&
+			    new_table[rate_idx].rate.gi == initial_old_rate->gi) {
+				wrs_params->initial_rate_idx = rate_idx;
+				initial_old_rate = NULL;
+			}
+
+			if (old_rate_idx == WRS_INVALID_RATE)
+				continue;
+
+			new_table[rate_idx].epr_acc =
+				wrs_params->table[old_rate_idx].epr_acc;
+			new_table[rate_idx].frames_total =
+				wrs_params->table[old_rate_idx].frames_total;
+			new_table[rate_idx].ba_not_rcv_total =
+				wrs_params->table[old_rate_idx].ba_not_rcv_total;
+		}
+
+		kfree(wrs_params->table);
+	}
+
+	wrs_params->table = new_table;
+	wrs_params->table_size = new_table_size;
+
+	if (wrs_params->rate_idx != WRS_INVALID_RATE) {
+		/*
+		 * Check if current rate is included in the new table.
+		 * If not select a rate from the new table accroding to rssi.
+		 */
+		struct cl_wrs_rate_params *rate_params = &wrs_params->rate_params;
+
+		rate_idx = cl_wrs_tables_find_rate_idx(wrs_params,
+						       rate_params->bw, rate_params->nss,
+						       rate_params->mcs, rate_params->gi);
+
+		if (rate_idx != WRS_INVALID_RATE) {
+			wrs_params->rate_idx = rate_idx;
+		} else {
+			if (wrs_params->is_fixed_rate) {
+				wrs_params->is_fixed_rate = false;
+				wrs_pr_verbose(wrs_db,
+					       "[%s] Disable fixed rate for station %u\n",
+					       WRS_TYPE_STR(type), wrs_sta->sta_idx);
+			}
+
+			cl_wrs_sta_select_first_rate(cl_hw, wrs_db, wrs_sta, wrs_params);
+			cl_wrs_cntrs_reset(wrs_sta, wrs_params);
+		}
+	}
+
+out:
+	kfree(valid_rates);
+}
+
+u16 cl_wrs_tables_find_rate_idx(struct cl_wrs_params *wrs_params,
+				u8 bw, u8 nss, u8 mcs, u8 gi)
+{
+	struct cl_wrs_table *table = wrs_params->table;
+	u16 rate_idx = 0;
+
+	for (rate_idx = 0; rate_idx < wrs_params->table_size; rate_idx++)
+		if (bw == table[rate_idx].rate.bw &&
+		    nss == table[rate_idx].rate.nss &&
+		    mcs == table[rate_idx].rate.mcs &&
+		    gi == table[rate_idx].rate.gi)
+			return rate_idx;
+
+	return WRS_INVALID_RATE;
+}
+
-- 
2.36.1

