Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570CD532956
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiEXLj0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiEXLjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461428DDC1
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEIuaI9wJ9G4PkHzGhMiRyKdLQnXG4YqL7l8VjVzgbzPPWyvBFjR8US/zRV4r9E5FCbSFEq+/tYeUk+qgKgJGD+cI9yiFuhIc69+3F4UOsSsNWv/H2tHjZILsgOBH76fff5KkV/k+QAAQDsujVsjOFIQOtFtjZCH4DFVb2ve1XiOMmXV+FMJ/ncNPmVpOygJPWXR0PbJxyLDFJyqsdZLIt0aohoB/F392Fh3o9ZzRb7AX9dwAhTzB0awAoIhDei0xRPVgVWRtpD+N3Ciiyu6chAmF9LPi2bhPF/9OBIRaShyeGtgLw43Thga/HFKb14oB5iMgnMILfD48XYQDvRaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcDpzWGMW77bGjdY+GT2edSgQ8KR6rmN61X/5EOoDp4=;
 b=LLRBbnkkaRGhxjRW/AkUzbh69/iCt6N1XsfQI1gb8+k5K1uEtzljufFN1AY+H9um49XDTTTV4OGnvUnWeoPRq3BHCVNV29XU/jU1UrxiDEm8zKC1WwsDS9P0dcWa1dCJIPZStEurk61GFeKrL1/v41UvWukKXKs7mNcasnzFJX4IzPHmnr+fApBKvAPwHGE0BvEqHWR4dHn4RHMRaV6fzCzML7vTxXy7ySDikbMfcBt7jVRj7VQWMS2GDpD/j8tpPHr4ETfXPp+MWO7fTeBHugZXUZymqU0fJgOyVJaqCA32cM+kl5MWovDK7ziwLXlkFbprx7WarFIlyYrDY8c+zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcDpzWGMW77bGjdY+GT2edSgQ8KR6rmN61X/5EOoDp4=;
 b=I8UzIBvkyjXqswDrsvjU1MIkT4WjSwNkwIvTjOLVTtZ5L/JokvaRQ+bJyKM+Rk7zLVKsCfenUhdK+A4iSgAPXkNousA4RNivhm7cUdGTtk6swNnLdYUuXwsGTPjAy/OXsCwqLBA9ljB6VJCwthndNwYJX/o5zqSxPrJi9pN3EqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB0915.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 11:38:53 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:53 +0000
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
Subject: [RFC v2 60/96] cl8k: add recovery.c
Date:   Tue, 24 May 2022 14:34:26 +0300
Message-Id: <20220524113502.1094459-61-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0352b016-a06e-4dc5-3016-08da3d79f116
X-MS-TrafficTypeDiagnostic: AM8P192MB0915:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM8P192MB0915C9EF6584F6A2EE49C77BF6D79@AM8P192MB0915.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jm69/zNlrjcT3cqhd6u1jbUPdZ3xUTjVOyK/SFwpCR3hJTH0LKN6bL4MOEb3Et0ETRsjFachylxbF467cjnMyyWZ1xhJCAPr82sGa2E/HxIlv5eFxEOqu0uVqzrWM81gIczZPr3eZpLynfTaZndZz27sTu2jVu/xIo0S4tjd0jC8AGsvgioPmVjm/DLyjTrzc9G5mgOW0DGtOydRkA35iAxx6WcrY9UIxdCdemUOvx+J/eneQPQSd+6GlGBqkedOvSPHqKFtSRaQ4I/O+31ZlzPgCXLZiFEI4o5GEhuCjJeBoF3A3NIXrICdNeXwhWXucr6nmPBmO8sixYyvADu9hjTh8suWjlyOCgYvueBgJQd23ilkE9yr6hTKvkvXA0jakz9FEs4MzH3bwYVq7msJkyot8eYNg4In4gwgreefkBNjuk+VSothHCEp+ePwY0lvvir5v1vWIhZOEA5B7l9K/yuRGjR9hIeXLqe99HAeyUQksZ6SEi4+QtADjqTIK6ya8ui4gyCiyiDRWWnMFJPhVmBGg9DtmtNVRpwSOU/KmkZVyxdqfBk2i2Knv5FvuzQ347uSpnGPAVu7VpQxrqrkA+Hi0pir7oc9/hg/xPzzNPBpArvvUF7f9Fm5PDbdHACil9IgiKHGlvRx9U+qNu94qPOLj1qIoW0HbYEqFEmwq49rl0J8dYvVlsto5EkjH2MfPdNDPQP92Eosn1DL435AfdA+5YLc2FjC/DnD00t8BJ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(376002)(346002)(39850400004)(83380400001)(54906003)(186003)(36756003)(107886003)(2906002)(2616005)(1076003)(6916009)(41300700001)(66946007)(8936002)(6666004)(9686003)(66476007)(26005)(86362001)(66556008)(5660300002)(6512007)(4326008)(38350700002)(316002)(6506007)(52116002)(8676002)(6486002)(38100700002)(508600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sk0WbPkZVGmBKz2AAOgdvA9fp+qw33jDJvu6xXPUJb1+9JkCUb9OYgKQMydC?=
 =?us-ascii?Q?fQLlywvN+a4OrBHS3q3wfRkx3f6+17OMfJx6RQD6hGOHfYp9WxJpWgc4hKHo?=
 =?us-ascii?Q?FlnIfYHRtMeN1RD2+5Uu8CRddZoiASPoAvYRNFdaPC3EYsfrhNESnaFHpqwL?=
 =?us-ascii?Q?h/4KAY6JYs4jIUff9pZJFlq5nfh29Ydwg4pCNs+mDUcCLFEIYDeSG74Ah/7l?=
 =?us-ascii?Q?3aoIQTLp8fazecR5rrOZ2gwwd+9XITLic8Tgi1n/JJjmuDwazzMb60Jw4zx2?=
 =?us-ascii?Q?3pJ+6Nide1bLORO9fLs3wB+mnlT18qd+3Vag1eMFsU5zsM92fIJBWeBrxdNI?=
 =?us-ascii?Q?yZ6pG71h3RebqBAhf2kYX24B783I8taNoWEvtktjrfnRI3XTotRzgirVUjqS?=
 =?us-ascii?Q?ZL2vKN2WLRs7PyD8zRzeRkh9gPJ/8RPg/2E38vMquzpS6QCbBhLPgbiKpYLx?=
 =?us-ascii?Q?DflgakbDduHOEErzFjSBbWzNIZYdo3+DN+GyfAIktEVZvgo9hW7r40aCPq2I?=
 =?us-ascii?Q?was2kGxd7gl+Zj1H3oVgLdOdPo0D9N05VbkNfGXENK0xa2zBjU9WI9wFdwap?=
 =?us-ascii?Q?7xlAvEvwOM8u7+cS29Z8TVjmdGjr1VE+Ix0sqokyBXpsoZ/TTvbiamVHisIH?=
 =?us-ascii?Q?MijiuSpOEDYiUjZJOZd2+HEEgwtwN3py4R0Ts1BqtpEYAdo0fNEG5z1x1qRx?=
 =?us-ascii?Q?rPp5S8tfUyDl7+uDHblZgR7LwCneHujfnx2Ds3ydVnZLIOK+TGcsE+Cv12VQ?=
 =?us-ascii?Q?83f4hOYfwBRapYSORyRP9PafmsWcfkK5exgofD9eTfHA1Dn9kC/Fw8AZvihu?=
 =?us-ascii?Q?MTx60vzn2AmNqCz2DC0VZ1Sr1WIjw2RT+QfHy+L4LxEhP+PjH6czM1GWLz5M?=
 =?us-ascii?Q?y29KAlzbunc5NJzWL1BCLVG8JWT4+c9ZQ1NyChp3Aq18aWLLx8vYXWpt9MZw?=
 =?us-ascii?Q?zBUUblcQ3Fbwk7GgK1094UK1XMeTpTvpMPQcVbl6srb+rWle2QeYHxs/sol9?=
 =?us-ascii?Q?xQB3+z+sIAs6/KjpR3kh2ycg8JXc64FOlUSH8FCk30Q03F+a5c9DM0t41lKr?=
 =?us-ascii?Q?Cexjb+e6aVwP5qfoxwbIBlERwOekggbmIG1Z8oFrEPeIx8Qa0HZ/YRSFqJgv?=
 =?us-ascii?Q?hSG20WSuxcDgEaiqQSRqxT5uRAI+EQTjzcvSoJh8D6IzGlPM+3/OKdk/wiUD?=
 =?us-ascii?Q?27PQeR02E7P8PE9fwk9w45bQXzTIOrsUGFx4nLpPljqDU1S3axgnjgmszxIa?=
 =?us-ascii?Q?2paE4Ly/Ot9c0bKN16HKPiA5McM0dTY0NxCo9zFCX8CELAqZNASXev5KMtd4?=
 =?us-ascii?Q?MMoV6Z6kjKvUpsAyWluzOmrK3gkJlnBRldCvLr9EaRr1HmH5Jq+vT5rRv3EU?=
 =?us-ascii?Q?zSMP3Fyw0SnFo0nv/NOwJF4c8AIyfoe03F1dxYEzfDGUVrWL63Z+iLOoWwao?=
 =?us-ascii?Q?MehOOxyLnODRMAqlmif6wO74N4YS0xGZSsrXwVUsZTFjy2MEoZWuNcybr90h?=
 =?us-ascii?Q?9LlaIm0Qfg8fnbYP7fA/N33DFAzxW5gsf4oeRigWq9QbNNyNZkrRI3bPiwja?=
 =?us-ascii?Q?wAGsd+q/ExrfH4jr5q8Y+1nu/DHtEP7t9KjTKFhgXIQXvr02l4skat9TJi7l?=
 =?us-ascii?Q?jKBrvnmVXGmV0om6g7NGWgXzWNvSxIXSMcudFB1k/DdFZxlGjpbH/tOjxZHY?=
 =?us-ascii?Q?HzRW2wm3grcg3LWz8P7bvOAGHoiAK4Bnth0QxFd71FUukFct9r/wnGNP3iH8?=
 =?us-ascii?Q?rFqSJeK1m4medco2MxLhijw7jZzmSjo=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0352b016-a06e-4dc5-3016-08da3d79f116
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:37.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4ftDW0wkeHF8pe2qjzQKz2AoBNDULqBMCch5okmn30I/9zHaYGhk+jO4DRArT7SkNBUVj+B9+j5l7ot3DSJpVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0915
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
 drivers/net/wireless/celeno/cl8k/recovery.c | 280 ++++++++++++++++++++
 1 file changed, 280 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/recovery.c

diff --git a/drivers/net/wireless/celeno/cl8k/recovery.c b/drivers/net/wireless/celeno/cl8k/recovery.c
new file mode 100644
index 000000000000..dc0c33be9200
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/recovery.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "hw.h"
+#include "main.h"
+#include "phy.h"
+#include "vif.h"
+#include "dfs.h"
+#include "maintenance.h"
+#include "vns.h"
+#include "config.h"
+#include "ela.h"
+#include "radio.h"
+#include "recovery.h"
+
+struct cl_recovery_work {
+	struct work_struct ws;
+	struct cl_hw *cl_hw;
+	int reason;
+};
+
+#define RECOVERY_POLL_TIMEOUT 6
+
+static void cl_recovery_poll_completion(struct cl_hw *cl_hw)
+{
+	u8 cntr = 0;
+
+	while (test_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags)) {
+		msleep(1000);
+
+		if (++cntr == RECOVERY_POLL_TIMEOUT) {
+			cl_dbg_verbose(cl_hw, "\n");
+			cl_dbg_err(cl_hw, "Driver handgup was detected!...");
+			break;
+		}
+	}
+}
+
+static void cl_recovery_start_hw(struct cl_hw *cl_hw)
+{
+	clear_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags);
+
+	/* Restart MAC firmware... */
+	if (cl_main_on(cl_hw)) {
+		cl_dbg_err(cl_hw, "Couldn't turn platform on .. aborting\n");
+		return;
+	}
+
+	if (cl_msg_tx_reset(cl_hw)) {
+		cl_dbg_err(cl_hw, "Failed to send firmware reset .. aborting\n");
+		return;
+	}
+
+	set_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags);
+	clear_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags);
+
+	/* Hand over to mac80211 from here */
+	ieee80211_restart_hw(cl_hw->hw);
+	/* Start firmware */
+	if (cl_msg_tx_start(cl_hw)) {
+		cl_dbg_err(cl_hw, "Failed to send firmware start .. aborting\n");
+		return;
+	}
+
+	cl_recovery_poll_completion(cl_hw);
+}
+
+static void cl_recovery_stop_hw(struct cl_hw *cl_hw)
+{
+	/* Start recovery process */
+	ieee80211_stop_queues(cl_hw->hw);
+	cl_hw->recovery_db.in_recovery = true;
+
+	clear_bit(CL_DEV_STARTED, &cl_hw->drv_flags);
+	set_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags);
+	set_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags);
+	/* Disable interrupts */
+	cl_irq_disable(cl_hw, cl_hw->ipc_e2a_irq.all);
+	cl_maintenance_stop(cl_hw);
+
+	mutex_lock(&cl_hw->dbginfo.mutex);
+
+	cl_main_off(cl_hw);
+
+	cl_hw->fw_active = false;
+	cl_hw->fw_send_start = false;
+
+	mutex_unlock(&cl_hw->dbginfo.mutex);
+
+	/* Reset it so MM_SET_FILTER_REQ will be called during the recovery */
+	cl_hw->rx_filter = 0;
+
+	/*
+	 * Reset channel/frequency parameters so that cl_msg_tx_set_channel()
+	 * will not be skipped in cl_ops_config()
+	 */
+	cl_hw->channel = 0;
+	cl_hw->primary_freq = 0;
+	cl_hw->center_freq = 0;
+}
+
+static void cl_recovery_process(struct cl_hw *cl_hw)
+{
+	int ret;
+	struct cl_chip *chip = cl_hw->chip;
+
+	mutex_lock(&chip->recovery_mutex);
+
+	cl_dbg_verbose(cl_hw, "Start\n");
+
+	cl_recovery_stop_hw(cl_hw);
+
+	if (chip->conf->ci_phy_dev != PHY_DEV_DUMMY) {
+		cl_phy_reset(cl_hw);
+
+		ret = cl_phy_load_recovery(cl_hw);
+		if (ret) {
+			cl_dbg_err(cl_hw, "cl_phy_load_recovery failed %d\n", ret);
+			goto out;
+		}
+	}
+
+	cl_recovery_start_hw(cl_hw);
+
+out:
+	mutex_unlock(&chip->recovery_mutex);
+}
+
+static void cl_recovery_handler(struct cl_hw *cl_hw, int reason)
+{
+	unsigned long recovery_diff = jiffies_to_msecs(jiffies - cl_hw->recovery_db.last_restart);
+
+	cl_hw->recovery_db.restart_cnt++;
+
+	if (recovery_diff > cl_hw->conf->ce_fw_watchdog_limit_time) {
+		cl_hw->recovery_db.restart_cnt = 1;
+	} else if (cl_hw->recovery_db.restart_cnt > cl_hw->conf->ce_fw_watchdog_limit_count) {
+		cl_dbg_verbose(cl_hw, "Too many failures... aborting\n");
+		cl_hw->conf->ce_fw_watchdog_mode = FW_WD_DISABLE;
+		return;
+	}
+
+	cl_hw->recovery_db.last_restart = jiffies;
+
+	/* Count recovery attempts for statistics */
+	cl_hw->fw_recovery_cntr++;
+	cl_dbg_trace(cl_hw, "Recovering from firmware failure, attempt #%i\n",
+		     cl_hw->fw_recovery_cntr);
+
+	cl_recovery_process(cl_hw);
+}
+
+static void cl_recovery_work_do(struct work_struct *ws)
+{
+	/* Worker for restarting hw. */
+	struct cl_recovery_work *recovery_work = container_of(ws, struct cl_recovery_work, ws);
+
+	recovery_work->cl_hw->assert_info.restart_sched = false;
+	cl_recovery_handler(recovery_work->cl_hw, recovery_work->reason);
+	kfree(recovery_work);
+}
+
+static void cl_recovery_work_sched(struct cl_hw *cl_hw, int reason)
+{
+	/*
+	 * Schedule work to restart device and firmware
+	 * This is scheduled when driver detects hw assert storm.
+	 */
+	struct cl_recovery_work *recovery_work;
+
+	if (!cl_hw->ipc_env || cl_hw->is_stop_context) {
+		cl_dbg_warn(cl_hw, "Skip recovery - Running down!\n");
+		return;
+	}
+
+	/* If restart is already scheduled - exit */
+	if (cl_hw->assert_info.restart_sched)
+		return;
+
+	cl_hw->assert_info.restart_sched = true;
+
+	/* Recovery_work will be freed by cl_recovery_work_do */
+	recovery_work = kzalloc(sizeof(*recovery_work), GFP_ATOMIC);
+
+	if (!recovery_work)
+		return;
+
+	INIT_WORK(&recovery_work->ws, cl_recovery_work_do);
+	recovery_work->cl_hw = cl_hw;
+	recovery_work->reason = reason;
+
+	queue_work(cl_hw->drv_workqueue, &recovery_work->ws);
+}
+
+bool cl_recovery_in_progress(struct cl_hw *cl_hw)
+{
+	return cl_hw->recovery_db.in_recovery;
+}
+
+void cl_recovery_reconfig_complete(struct cl_hw *cl_hw)
+{
+	clear_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags);
+
+	if (cl_ela_is_on(cl_hw->chip)) {
+		cl_ela_lcu_reset(cl_hw->chip);
+		cl_ela_lcu_apply_config(cl_hw->chip);
+	}
+
+#ifdef CONFIG_CL8K_DYN_MCAST_RATE
+	cl_dyn_mcast_rate_recovery(cl_hw);
+
+#endif /* CONFIG_CL8K_DYN_MCAST_RATE */
+#ifdef CONFIG_CL8K_DYN_BCAST_RATE
+	cl_dyn_bcast_rate_recovery(cl_hw);
+
+#endif /* CONFIG_CL8K_DYN_BCAST_RATE */
+	/* DFS recovery */
+	cl_dfs_recovery(cl_hw);
+
+	/* VNS recovery */
+	cl_vns_recovery(cl_hw);
+
+	/* Restore EDCA configuration */
+	cl_edca_recovery(cl_hw);
+
+	/* Temperature  recovery */
+	cl_temperature_recovery(cl_hw);
+
+	/* Sounding recovery */
+	cl_sounding_recovery(cl_hw);
+
+	/*
+	 * Update Tx params for all connected stations to sync firmware after the
+	 * recovery process. Should be called after cl_mu_ofdma_grp_recovery to let
+	 * MU-OFDMA rates in FW be updated successfully
+	 */
+	cl_wrs_api_recovery(cl_hw);
+
+	/* Enable maintenance timers back */
+	cl_maintenance_start(cl_hw);
+	if (cl_radio_is_on(cl_hw)) {
+		/*
+		 * Rearm last_tbtt_ind so that error message will
+		 * not be printed in cl_irq_status_tbtt()
+		 */
+		cl_hw->last_tbtt_irq = jiffies;
+
+		cl_msg_tx_set_idle(cl_hw, MAC_ACTIVE, true);
+	}
+
+	cl_hw->recovery_db.in_recovery = false;
+
+	pr_debug("cl_recovery: complete\n");
+
+	cl_rx_post_recovery(cl_hw);
+}
+
+void cl_recovery_start(struct cl_hw *cl_hw, int reason)
+{
+	/* Prevent new messages to be sent until firmware has recovered */
+	set_bit(CL_DEV_FW_ERROR, &cl_hw->drv_flags);
+
+	switch (cl_hw->conf->ce_fw_watchdog_mode) {
+	case FW_WD_DISABLE:
+		cl_dbg_info(cl_hw, "Skip recovery - Watchdog is off!\n");
+		break;
+
+	case FW_WD_INTERNAL_RECOVERY:
+		cl_recovery_work_sched(cl_hw, reason);
+		break;
+
+	case FW_WD_DRV_RELOAD:
+		/* TODO: Implement netlink hint to the userspace */
+		cl_dbg_info(cl_hw, "RELOAD handler is absent, doing nothing");
+		break;
+
+	default:
+		break;
+	}
+}
-- 
2.36.1

