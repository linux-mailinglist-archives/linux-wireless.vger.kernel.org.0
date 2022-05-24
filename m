Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0B53295A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiEXLkK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiEXLkK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:10 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2086.outbound.protection.outlook.com [40.107.104.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416CB8D687
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBASZrGq1K+ppZhgduow5hsabj7ZbwehywFrYSIt0zoj+QXRKAKNNTxTwOG+0yDtBbEaUuyRP5lIt+E4ID/+zM84DB9RP2hWVit90KXZDwbeD6LbplyCE4zFKTtQhkB5LbxbjW3s/x+6oZ8cr2ae4OpiOOtd6lVmWpVkwhIRajlo5sGoaOCEh1FuzquClZwjE6+UM909Je4zEc19JP6i522ZDBbC0TyQfHmhWkmspTIAfcuOGUUIJ0Ayghr8FwqRhH2dPODazEF0ZC3CUs4LXV8Fx3/sgoCrHwL0LLR3hnswDIrWh9tPSyS5bAVxtMyfuc9WwBjOchZuAHBQTrLexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AiHYJ0zvtX6Pwkzdn/mSLyHwqah32921ts8a1DgqoA=;
 b=IT+uz84JIqdrHXepiQlcAqAgSfEWTngxixBo+4ppKzaLQCKd2tAjgTdL9WU0oxuSKVb9ia42AVJeFA5+ZWio51VNj/AMT8LBYZTj3BD30nn7i5eN8FSkG22cZGClKAEt3FaT6jUlNbo2RBGnQ+fjJH7kL0gYfXxikiZL0neHHs1OV3gB0wNY8GgxFRWBZe3S/7WSRAIyZ17xa6YNW9ZmAlwDsK3OTcw0nhbilFwZRX8NnzigXkRZFGEtPJtgE7wfS6wVmVAROUVnLXDpMkrgqaYC0GT2i0HVv3zKXTk14PRofuE6EvnnJVYpXKF/yeooboI6GqJF3tMrIg2sl+k2qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AiHYJ0zvtX6Pwkzdn/mSLyHwqah32921ts8a1DgqoA=;
 b=HNYBg21E6AElPLS5tvbXQNP+M/3VMvqc+HPmLX9n7+yQIlHzH8de2ZL+NnD1aKNyqwlbBgeQijBE156P5ZhknETBGmvkuJb7LzeQE5C1CwGgbVo9vp6EGIJ7wWMjaYmrtEzwJB38ZZLsSRCReXagWY9zA9w9IF6dDygZW/U2bPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:44 +0000
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
Subject: [RFC v2 44/96] cl8k: add maintenance.c
Date:   Tue, 24 May 2022 14:34:10 +0300
Message-Id: <20220524113502.1094459-45-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 44863fd3-71ae-48a9-9cdf-08da3d79e7f2
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB03841EB45972F49E98D59A64F6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSMRHICxRnHZjViLTa+CnGlKxFvEfrHd1tRx/EMJpLGMAd9EuxLZx+7sDem40mw8/ecS6AdlB7Yeb+3eCXVnaImFrcYwjOIpXPCYW2emeGkXwmCLv4Y3IU2ThL8H3e8ipZMC7PpTs3AwxfnvHRMzTtTE+ly43J2AbmFF5SOS3n8w3uJH2o6PpnifRzpWqZWETn7zojZofyVem1ezflvfzPjUZcuQH/1tWRP4BFjoHRcLI7mmgfGmL/nPMYBnFxUDSWDW2RVzo5AANGd6iq/mZEfjNZkCcdnoZtNj7uFlRNRTsUfDtYLwjZ8kDZn58tN215RGf8GfWahASL3Q9D6RGXQruDupiZvYylRelSN6fTDeVEHAMQGZaKbHiJZGukXSdlpngZ7wxYrCLRkqB63Dlg4TIencDhFS8uW3/aF8E9i/1GBXloh9+Jwd3h6rlsqLjqs06w0tbo6/OL89FJWOUde2lpvGTMaWlR62PazIg6NY6nqy0PKSgS5gcEU0Cog5vXa4PG2mP/bkpD2ulIRlgIKzNZzIrhJdtzvdJz7ZYmNacjE45R/dRspeN7E7DM2PP6bAG967kINnv0jATEd10OQa9f0FqJnC/H6c8SUktI//+99+5DDLjncB4g62g3pw7vTnWYHqmSLAQS2V+cUwR84woBxbqa3OFxVsbqCOAedlRpsZN+zwUqWs3iFW+YMV4Leesj4fFLxAoWS8N426l3yXAaFabCmRHwQR3a9os0U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(8936002)(508600001)(186003)(83380400001)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MM8CgWkOoHMzY/ei9Wtu3QOTuILaQgEJvHsy9yjNhhsHGf6hIjqJVHFUl9vi?=
 =?us-ascii?Q?2xQYAkHrlAA+BvUD/84CkzDdU/tVWYumRn+8G8vpVhXQjN8p3NifsHBmU3xF?=
 =?us-ascii?Q?gN3gmZIjzFkiRo2xaW3rhHhgV9B6UBeNyCt5GpdQEvqOEWxesOAQadYtXUVX?=
 =?us-ascii?Q?pU0gZRNOmkBeV8Dr8ys3Z4Shouxew9vIeuHdbZa79mgq/To6ycRVriuY2V07?=
 =?us-ascii?Q?X6CVP3SzlrBY6fTYbvfTQUMDe6qncekev4s6KDagNcG+NF2S+NTiUUOejkQc?=
 =?us-ascii?Q?dSAst33r/O3BlidSYWE83XkjzxjFAA81EesrS2DTb8SeFL51IvIJ1K4E3btm?=
 =?us-ascii?Q?Ta3q7zkEwVsA3cyVc1fZop4cCq3NAcjrsnhQIyJnMLPHANa6RebKDy6ckWGH?=
 =?us-ascii?Q?HTSAYkg0MGh3fkRC7tLcYviJ3Bksj6PO7n2CgAt6WH0DT7AWYD5IzvGcZm+m?=
 =?us-ascii?Q?484Zp2qqSDirRs+MYxsVymoC1pF/yXJIDpGLZhXRZWbbkesx3USrwrCV6xJe?=
 =?us-ascii?Q?1tFErlbvGhE/VTet5DY7AkacPtdLvSkSqttc9mI00G7GCw8Lp7icv3cmRQ4x?=
 =?us-ascii?Q?ThPReNZgjZYzsyP+ZB7B5rgzxKMooUyGFwsstaEfY3FF0fLAL50FCfS1wGr/?=
 =?us-ascii?Q?muJoeLejjs2KIfdYIm9wAYxUE/TFFhRwrEy4fQMCNwbrYbXso/rHTswkXZ2s?=
 =?us-ascii?Q?kPbRHyk6hyb3cFMdRazmhL9+eELscsggA6KDT2yGAhQrlepen512Zk50Lx1A?=
 =?us-ascii?Q?ao2nPQzYUYGGc5spuOenQwh9zbX5MJk1g3Wczqo+ez7tX9EFvODKtVhhGAhf?=
 =?us-ascii?Q?+yT1asX+hNsWXJVdlXD4/WCRRNtxI+O04Vl78oEPFO5B2mUVYn6HsOrlW6ya?=
 =?us-ascii?Q?Yno+c2C1/w6cuYfaG2YaCSi8K6JgGTAut1XjuKxDAmBgcKyCy857xjJNE4l9?=
 =?us-ascii?Q?SgC2ZORLOLwQ4Qx8wI4dP1fWPulh07W9dQfGjFhepHoLEjSSbV7jIxjWqJZ1?=
 =?us-ascii?Q?d40ZfgCotHQjQ8q1P+T2IsWmtGHOLbIW9aSGmY9lnLdMQOBe78Jp3LtukPve?=
 =?us-ascii?Q?IbwRtfsEeY0uhaohj7HSYKwB6xc5ek/UU1KADW27sjv2ffrBM2P6qeJUD/8v?=
 =?us-ascii?Q?07NSmEVnWBKxyuEN6uIR0plqplptgEb9tZ8AXwycyQXqMy9yCmOTjfNZOKmL?=
 =?us-ascii?Q?TtCVPJCUBIsECopz7wOwncN/QlbLgPxjJelJOe/lge5VMIEJAFK6Ty/fA5MA?=
 =?us-ascii?Q?PbnYWSXfiz4og/IQfYoQGdsxS75dIBtbncESDe1XJEl+3/TGA86SmjSsDKPR?=
 =?us-ascii?Q?9TWj2Aw/xWjtAlN1kImaNZXGGRxWqJSsIly/ZFbmzho3o/gvUdDLwChPpjfV?=
 =?us-ascii?Q?uGb6c/BZJ5fKOQaXJDykRHewJiMrcDwutXcbqO3jMsjTumrYKPhb3YTiY3E1?=
 =?us-ascii?Q?APEexiTfJMTviZ1x9JPZTpLFyys4Vl9UIWiYeq8C2V/TOoIT8774em5bZdpx?=
 =?us-ascii?Q?7WQ52OoZHFC6pNpsR/5l9+NzeVI5DAbTc6o8doGEd/d9D9cJLkCHKr+zwFa7?=
 =?us-ascii?Q?NG5XVv7/x2p62LzMsBuL3L3FzQHO2Bg34nJa8OQCl35CzAhCwFYoVMQ5hcGd?=
 =?us-ascii?Q?y63250XLsVrDIz58VJQS62c2RqeGFu6NZRhkV7UTR8wbwZql1spPJLLBoSOA?=
 =?us-ascii?Q?LAm6cw/IKl0gqChvnxlb0lifeO/e3Iy5RYhlOUKBgX55h073fW3vFrGVKrAC?=
 =?us-ascii?Q?rhglfPGq5HShzQqoC1weKegq7gEGQpA=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44863fd3-71ae-48a9-9cdf-08da3d79e7f2
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:21.9526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gP26ajJORhCfhK3jDZazC5bG9J/1hfBgU5wlRS7xSVP0Q9vANVI7CvkOdss5N0NmeT5lAUMw3d75s8H66z3UOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 .../net/wireless/celeno/cl8k/maintenance.c    | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/maintenance.c

diff --git a/drivers/net/wireless/celeno/cl8k/maintenance.c b/drivers/net/wireless/celeno/cl8k/maintenance.c
new file mode 100644
index 000000000000..3230757edacc
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/maintenance.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "maintenance.h"
+#include "traffic.h"
+#include "vns.h"
+#include "reg/reg_access.h"
+#include "sounding.h"
+#include "sta.h"
+#include "motion_sense.h"
+#include "radio.h"
+
+static void cl_maintenance_callback_slow(struct timer_list *t)
+{
+	struct cl_hw *cl_hw = from_timer(cl_hw, t, maintenance_slow_timer);
+
+	cl_cca_maintenance(cl_hw);
+	cl_noise_maintenance(cl_hw);
+
+	if (cl_hw_is_prod_or_listener(cl_hw))
+		goto reschedule_timer;
+
+	cl_vns_maintenance(cl_hw);
+
+	if (cl_hw->conf->ci_traffic_mon_en)
+		cl_sta_loop(cl_hw, cl_traffic_mon_sta_maintenance);
+
+	if (cl_sta_num(cl_hw) == 0)
+		goto reschedule_timer;
+
+	cl_motion_sense_maintenance(cl_hw);
+	cl_sounding_maintenance(cl_hw);
+
+reschedule_timer:
+	mod_timer(&cl_hw->maintenance_slow_timer,
+		  jiffies + msecs_to_jiffies(CL_MAINTENANCE_PERIOD_SLOW_MS));
+}
+
+static void cl_maintenance_callback_fast(struct timer_list *t)
+{
+	struct cl_hw *cl_hw = from_timer(cl_hw, t, maintenance_fast_timer);
+
+	if (cl_sta_num(cl_hw) == 0)
+		goto reschedule_timer;
+
+	cl_traffic_maintenance(cl_hw);
+
+reschedule_timer:
+	mod_timer(&cl_hw->maintenance_fast_timer,
+		  jiffies + msecs_to_jiffies(CL_MAINTENANCE_PERIOD_FAST_MS));
+}
+
+void cl_maintenance_init(struct cl_hw *cl_hw)
+{
+	timer_setup(&cl_hw->maintenance_slow_timer, cl_maintenance_callback_slow, 0);
+	timer_setup(&cl_hw->maintenance_fast_timer, cl_maintenance_callback_fast, 0);
+
+	cl_maintenance_start(cl_hw);
+}
+
+void cl_maintenance_close(struct cl_hw *cl_hw)
+{
+	del_timer_sync(&cl_hw->maintenance_slow_timer);
+	del_timer_sync(&cl_hw->maintenance_fast_timer);
+}
+
+void cl_maintenance_stop(struct cl_hw *cl_hw)
+{
+	del_timer(&cl_hw->maintenance_slow_timer);
+	del_timer(&cl_hw->maintenance_fast_timer);
+}
+
+void cl_maintenance_start(struct cl_hw *cl_hw)
+{
+	mod_timer(&cl_hw->maintenance_slow_timer,
+		  jiffies + msecs_to_jiffies(CL_MAINTENANCE_PERIOD_SLOW_MS));
+
+	if (!cl_hw_is_prod_or_listener(cl_hw))
+		mod_timer(&cl_hw->maintenance_fast_timer,
+			  jiffies + msecs_to_jiffies(CL_MAINTENANCE_PERIOD_FAST_MS));
+}
-- 
2.36.1

