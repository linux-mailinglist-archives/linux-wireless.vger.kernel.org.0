Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15498532978
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbiEXLmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237003AbiEXLmO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:42:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A90450440
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObfeQgQL7H+WfFGYFUiSAB7vwG4nuWtpATMEJrCD4hMBkVkvwudSQ4KkYR16Gz+htjZL7tGrCNa4fnAawCp0m8DDUgecNSQKXmgJsSsFGHG4sajNpc0EfxD+wTg+5sJhY38I6TrOBDDC9xSDgFMnrdhBFSRXhTniqCtdKvFgC/Q1/6ZTzkRxkbLFg7gLB63Mj4zz3LYQqOvQ5f2I+hV/Akv+lCNkvY6zHYHjZK9GvMjXKOyBjTYRJAQNbB7QOPuwYF8/7oUy1GPYHKgHMLOxS3rgR0kf3Ugxfce5nQogl/6yUdAGlaD46N/q6DSQQ2RpLYpZ4TRVd8e3JeAMaB9TAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1TUN//VIfhqSrNOT4S1q54sDdl75aZGWUQmjxQV1s8=;
 b=RdR05GU+Uwxb44WFB9csbCPSWIloSrWqRkZ5cWtocbwfhNEJI1bqbd4ClMYFbyFQUzS/AQynkl8DU/wzrWSlTw3oD/QJBUUEapvb+z+VE/Nr5vxUx7yhJ5BrXYi3+dX28Q+r6rtutCRDqlO3hNaPY/qLVOoohNKItjFlge2iD0ZMsnbEvti2K3yssZxCdaJz2RuFPbqD0Z8lAM5Hz91Y3f7QD1p8ZjI8goi4QhqWJfYwnngFqxOM9DT070CMimVzjk/h5eJJ8P12qaNntyjyUCkhRJ0jG9wYkxqtR7ilmBJ+VzeBPev0FqiTXel6Nn6gvqVHheFI7LA9yHVh8BAUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1TUN//VIfhqSrNOT4S1q54sDdl75aZGWUQmjxQV1s8=;
 b=Bm3NGLzXf71x1NTbbX+qSgFMQQS/H850RmtRafENnPWOA69Ob0VThbuUlPCwMOjdBMDCROrqQbs4nQYnsN3rWjMVHO12lt8vaIX4SWiQR6UqeDscr4qqVbj/AwHjkEHG4LbdlYJQxjblo+2vARpZdCzUHv/RDwPQGbfjIgPxk/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:30 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:30 +0000
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
Subject: [RFC v2 81/96] cl8k: add temperature.h
Date:   Tue, 24 May 2022 14:34:47 +0300
Message-Id: <20220524113502.1094459-82-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5d29ad78-2e3e-4ed8-8464-08da3d79fb5c
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB06698A0630ADE0DC033C0560F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9PPeybzNuQGzncTIawzefL5Xp7ra3rgIp3Wb1wi8mTkteoTLuVi6NxlAwLZ+E4XbXoR6biS7fUWgqQyE+OlG72gv3DBaMtut0zkP02pqs7VG0pA5bo9HegLHRc6wM/UbVBd1H+bDoHqLxI1NKvnaGP0dWF4FzenjuwRclPXGoMTlhk48gibRSFFtTJ86uP3R+5Etvo25c8fTeaCLYLDlrgbzB5feutlsi3RYfKl93JhozoXypgNUmiVy+R5hZbggYgVBF1BFoXa3ngOTSLeG2mWo5H2WVib2zfhp9eqO/hMKXLw7CrmR3tz9GmIn+eRKuPUKPTb9QEMNTvgS9KfRxvdAnhlwFsMEZsHJVwf9yD7Imj1VTtgTcARSliH7wkFrkTNe4Yy+0lMRR8A1EKGzb4ZFRwCjZX3cwdrkFu0Ir3Cq1LqKlbox7W+8WdvMKTYQVzrO9ufUpgZuFfVNNTNTuApwWveFM3k2tKEuQrClpBcG41lTINZ5Q0pPpJP2vcwF82+h0jgy0zh2HESb7zsORcR4KxBgvA4St65iA/3Be4OOdfBBhKSdsN4TRTa8gOo1CX0STcvYHu1SKsrfMseOyCJMz4iB3Zsn4DkU7Xu1HKzRRgnc/NYDFGwH49R0anKhgk0p5oURCfkiJ7MEXznHyyjt8+NfFCxZA11DHWZxuH31bwO+DU3LmDcr9hbAxCMAsSZ3ThbUAL86PoGT+AiH5SskpWZSAdTRQ68X9/DBSfY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sl7jNflxk6UbE0unayZRRlneU9AoQ2uB5kJVmDVF/G+xiifbLoDW/g08yRSr?=
 =?us-ascii?Q?PgaLo5sPowp1tk8V313VseAyrCP7UyYv3BxhR87dsdpKONZ5GRPLYThYJNKx?=
 =?us-ascii?Q?LMGLNnxQNgbyKQ4e+EmxB4h8aSreGVaef9KiAH46JmFPsCQ4K5Vd/iN5XDtr?=
 =?us-ascii?Q?g4vC0IgSACuGgEUQFIKJYNOZ6QEeQP0Uzx/T3eN7bFituhRhmj2FJfbdQFq2?=
 =?us-ascii?Q?tdLMFlshFgdjx15oqisRreEI/9uM7wacNt+JoLqCgdk6nwfWoEF2VzM6b860?=
 =?us-ascii?Q?OnTeOWAO2MKeGtA4Wbcj+nOWFbcXq7pDMxkPQB4mg4zPaaNbWya58uNVVBda?=
 =?us-ascii?Q?pLqDg/iLXmyE7eAj1ojZ8l8cUSN+Bp+XfV7xu/NEFQ1C4dw5oNWuVcToqevT?=
 =?us-ascii?Q?M4QHMZG6eHLzuTij6A8udIoHtgMDNsKLiOvXF9F7xkD1YvZ6nZdDMGbHgiPS?=
 =?us-ascii?Q?x90ORtmq85tMPllnE2N7Qmx9Py9Mr0i64Hh90qpD7p/Wzz8IYtVJDTxNJebm?=
 =?us-ascii?Q?sQYrh3/6ePoO8HF6BV00YpB1UUkwJOULM0PXep1Y4mHprWaRYk744HxVeEXQ?=
 =?us-ascii?Q?4bcZ1Vqu+WSbM36wDRNRYPqlv9G524NfmexM8LndWp8kJH5R9felzFNjy8Ur?=
 =?us-ascii?Q?8zpZl4M08VzmQ6WneGCUdBaxYSHleQ8C+hd8/dzhy7S2QnqZyHIdB398/NdC?=
 =?us-ascii?Q?eVM1HTZLPq3TtR5rx0rJfl2DYbJy11fzDHBVQX6S3uSLasGA0XTzQyrRuRZW?=
 =?us-ascii?Q?3QtoFJP0huPTkv7f8e0XsrVE0/gq/dwVl2/AqtP8wmwe4z5dmaf87ZAzROaU?=
 =?us-ascii?Q?IzwKXn0SGXimd5xIuUii7XoDpecKbjWrWej/q+FoKu2IViQcbuqMVPcOFWMo?=
 =?us-ascii?Q?rB4dQLv4q/GXunmWpIBhi9t+DcWkQ4wndLD7wZnscXaekF7DhUnEzBOaxneO?=
 =?us-ascii?Q?2IhpI64ppIVw3/wSSkc6Be0gi3A8Z+7pk+E0L5Q6H9XdWMvDH2hBgUkkusPN?=
 =?us-ascii?Q?VLZIrob07uwaTVyJ1NBgV2x16eZuZxtNK7Maq1cvhRQwx7+9CRhJZeJNw+mF?=
 =?us-ascii?Q?s2SGaNSA14rCBUywDJ9DE3wJIqlVq2h6cRl5KXwdgUHW7U3Wh/vUEf+6dCAu?=
 =?us-ascii?Q?pMAN5cjd190b1U9bfKdDrm/8cdHKn2gO1cTJCrsi0jmEEnVzFx/uc79bmppi?=
 =?us-ascii?Q?il7eCmGRrXxomWts11hb93t97IsEzGOLgfDpp2xAkCdN1yuvHvtKzM5GKKBP?=
 =?us-ascii?Q?nVC5QvsT+oV37HTkF1gsZ59X9UmP22kMm7k9UpPeVv1kdHiT0QIxiLNizFVB?=
 =?us-ascii?Q?qzwHErrTe8JuFfCI46lsYNHULnetr/nucqHbosR27XALLIlgBD79PrOUA39T?=
 =?us-ascii?Q?F8BDgCSX43M5xeWGTKoIgdqXIsAO8PZ9dB+AN5xZ4IuPuwGgS4P1C5mcNG8G?=
 =?us-ascii?Q?lpRt20FIiGwSYKZ05x9zdui4oYGuIge8CFqmLLhhhc7JaTKaxLkGMwD1LYLi?=
 =?us-ascii?Q?3wolY7TAj4JSVcnfR1vyemdH/d2XdQJ1HMTwECAMhtx+zkvfKucalk4pX1Qm?=
 =?us-ascii?Q?+MbQCeOup32b5QKWBZeq4AxNmevgQ0/vSUSxDrMB8NYwIlCHC/FRYiSmwxFm?=
 =?us-ascii?Q?M3+CeOylL8puilYU2J4eJ2pBtchprxmoV4NDoPtkg/38QptYoRrQ/+aZ2+r2?=
 =?us-ascii?Q?crSAnOR5WOAhqt3S17F/4EUgSoiXaHXvI3ZO/5Df8Cj2rNHQpIHP0rfvk8Uo?=
 =?us-ascii?Q?f5Vk+3PCViv1o+gfr85k3myndnA6fxM=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d29ad78-2e3e-4ed8-8464-08da3d79fb5c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:54.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8Eeq9iIVbAHmTJp5WUbrZhWZW9emirZaaZzusJk+NKGJrvZvgPW1KDplp3Z9p3ZP9aDs+dvmoRzDAZZlD26Ww==
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
 .../net/wireless/celeno/cl8k/temperature.h    | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/temperature.h

diff --git a/drivers/net/wireless/celeno/cl8k/temperature.h b/drivers/net/wireless/celeno/cl8k/temperature.h
new file mode 100644
index 000000000000..e5ab770199e8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/temperature.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_TEMPERATURE_H
+#define CL_TEMPERATURE_H
+
+#include <net/mac80211.h>
+
+#define CL_TEMP_PROTECT_INTERVAL_MS       40000
+#define CL_TEMP_PROTECT_NUM_SAMPLES       4
+#define CL_TEMP_PROTECT_RADIO_OFF_HYST    10
+#define CL_TEMP_COMP_ITERATIONS           4
+#define CL_TEMPERATURE_TIMER_INTERVAL_MS  4000
+#define CL_TEMPERATURE_UPDATE_INTERVAL_MS (CL_TEMPERATURE_TIMER_INTERVAL_MS - 100)
+
+enum cl_temp_state {
+	TEMP_PROTECT_OFF,
+	TEMP_PROTECT_INTERNAL,
+	TEMP_PROTECT_EXTERNAL,
+	TEMP_PROTECT_DIFF
+};
+
+enum cl_temp_mode {
+	TEMP_MODE_INTERNAL,
+	TEMP_MODE_EXTERNAL
+};
+
+struct cl_temp_comp_db {
+	s8 calib_temperature;
+	s8 power_offset;
+	s32 acc_temp_delta;
+	s32 avg_temp_delta;
+};
+
+struct cl_temp_protect_db {
+	bool force_radio_off;
+	u8 duty_cycle;
+	u8 test_mode_duty_cycle;
+	u8 curr_idx;
+	s16 last_samples[CL_TEMP_PROTECT_NUM_SAMPLES];
+	unsigned long last_timestamp;
+};
+
+struct cl_temperature {
+	s8 diff_internal_external;
+	u8 comp_iterations;
+	struct cl_temp_protect_db protect_db;
+	struct task_struct *kthread;
+	wait_queue_head_t wait_done;
+	wait_queue_head_t measurement_done;
+	s16 internal_last;
+	s16 external_last;
+	unsigned long internal_read_timestamp;
+	unsigned long external_read_timestamp;
+	struct mutex mutex;
+	struct mutex hw_lock;
+	unsigned long used_hw_map;
+};
+
+struct cl_chip;
+
+void cl_temperature_init(struct cl_chip *chip);
+void cl_temperature_close(struct cl_chip *chip);
+s8 cl_temperature_read(struct cl_hw *cl_hw, enum cl_temp_mode mode);
+void cl_temperature_recovery(struct cl_hw *cl_hw);
+int cl_temperature_diff_e2p_read(struct cl_hw *cl_hw);
+s16 cl_temperature_calib_calc(struct cl_hw *cl_hw, u16 raw_bits);
+void cl_temperature_comp_update_calib(struct cl_hw *cl_hw);
+void cl_temperature_wait_for_measurement(struct cl_chip *chip, u8 tcv_idx);
+
+#endif /* CL_TEMPERATURE_H */
-- 
2.36.1

