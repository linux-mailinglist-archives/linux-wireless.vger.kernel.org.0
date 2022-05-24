Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B61532936
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbiEXLiZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbiEXLiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048188CCFB
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuhcbAlsLT8tMUTZmAjc37kJ1CX3vubtp0hsbFa7l/Gei4DCpTFOeKREAdUFWKCCCj4RECkScQSzpIrkE06sOpCP3cR8lXGJeTYt9raXEWZlc/nu9fMM/ddtu2ktZ+glkKxfmP1e577+a2Zgc+5i94fEEyAAB3XV+rDr17KoPTasokWhBMOHFT1nKILMmy6moSE8zIRiv4NXW4YGEztX9amMVkZF25t7PqTkgOtFl2+24TTyfPQKbj79gg5yr66rBpERXTir1QCJ8wClLy5OH3nupt7NLaY0zl4S4RcaJFO42l+Dh7Cm2TcIKI6mIaSG80TPv/ZwFMyQXwOrZbhQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR1alug55Mo1W1eIVpnKL1Y70kdnT36BzL+K+24WZus=;
 b=OCvm1x/l+Jjb0OIe2hxWcJYuTp90CrHH9ZYx+eUnRdQedPPa1NLQ3VTURVk9ZAocXUxTVCK+cAY1+VGzqsjJ2b42tH9YNq9ErtI9OWEspel79AH6bryQDoA8nYMTZo6KJWWel8NJ/tgkmF8r2oggUEz9n2EQl2DPTxnySar6sRx8L4ZDJONL69LGD76najBrAIxOJ+d95JHCJF9L4I620l6EnoOsP9KXdvpc8XHhB8hDTxfKHza+rugn0qC75VvjsKVfj3ajUPl+l78mCDPpZ3mOSQN7l+PfdtExXbr6gnmmyuzJFAkusIzU1R2WMCASHPNrEXkvp/b2qC1c8Ob0nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR1alug55Mo1W1eIVpnKL1Y70kdnT36BzL+K+24WZus=;
 b=dqdvKruC/9jCfJksJXFgGz/xebtEEgmt3KIqMvv1OfTPoWzzciw1LgQ5BkKTKvbc894f9qk8mQ9FgWGo5zYfitOPU75kqlL+W1CPw8vjJZZ/huLF4DxkHxrnayzyo1eJN8PUvFNIK80B7HTo3zLANV0/U3P/+dT0uPVP2m1ZqFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:58 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:58 +0000
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
Subject: [RFC v2 20/96] cl8k: add dfs.c
Date:   Tue, 24 May 2022 14:33:46 +0300
Message-Id: <20220524113502.1094459-21-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b91881ac-7b9d-4358-d860-08da3d79d976
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469FD894E3AC89BCDF2816FF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8AtQY4qtd8aPZTVDl3gdJtoWiWpURsl3BHOcHTEld6fSbj4HtE390iMjxNUasgZYUOb3YAPIkPRUdx5dhXNAFLgM1uyB54dWIP7P+NeQ/YHsvYmRUl+QDdV3IorGKDDcEKMYEqd+f8aTjZPkbt7g2j36gzKr00yXMNepKBrikQbp9s8WmyPVLUF3VWf6LSha/v/4U3B7+D6upGDbLJW7mi9NBf/PAGRVD/LiTSWmxJ++KDl74wbIxCUNApOWRpvq7rt2PIXFlItpmjZrk3hW9U/iOwX3CF1DfE2Cs9SVCzjMsoOGZvt4mnYqZ8imRGtI0YurMQ47dS64Tlnb2OPCSq7Fketpiz7L3JO22a4bfR4nDyW6V5+mGJsIEs4wmTpm95asTnc6x5SnqMaHE6NB7iBcMTBLftVCJDYPzJuMe2q8hxrXjKYkap7mAVjFIVakxlCFvWgZP05lqvHrQuu8muG3G/vEGRJ4ykcMkudNN3SZ6GzwCIFFZoGnqtUtDrUew3t/UmwJdNzVa2rzLgp+XE8Bh2/BvmEaHkNiR/xll6VhT/TsYg1mrFKWXHPGozs5C4n6tj5p061qDRpLwIbG4OQ2UvOIKX1dqrRrq2PQ2fsuJtfJ30j2ufT6MIMl5dBsoZeH8bLemxmfFOPioDmiagg7Yna2mprBQav8uAeGeflQoYa3PFmXtpwPvFkac29dhkyqzEvZWea9HsweSpvV6rE1k+7vrya+cEHJ30sfR64=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jkp91JE8YM0kYEaG3yhmkr7xt2A5tU6YLg8QACZLT7UI+oiBOy7Jpp2xdnYP?=
 =?us-ascii?Q?M47PmMJM/J/Gb0WtWrdb1IeluTi/9J2AfoUo32PFpBdb1Sjd0Fgp4BfeQyDK?=
 =?us-ascii?Q?WopaKAd6KBEoSUKRIGkcdPg96ssG02f2xzAbLrv5vsj9wJiN6vVfvdNVn8gn?=
 =?us-ascii?Q?gZx0Hd52cqipyYwS30SX/G/ED4H+Uw6nQ3ij1PxuroKmzBnabOslV1MnFm6m?=
 =?us-ascii?Q?iWJS8bjrxrrHlzZNg+YBr2BhBpmE7LNvhnHC+SAzRaDGJlwT0QspTenXuRgP?=
 =?us-ascii?Q?vi/bdE+gL/MUmDMTRSH0qM0wh/drwh38VznUcyXQLcRhu5KbyXRFdEQfJv0t?=
 =?us-ascii?Q?lMmlOersct3gpBdJbWrYX2z+FJ7f9qXxSXtnpwfZRoZZGGfsriw/GLZtm3bU?=
 =?us-ascii?Q?Hs6/cBKcq6oAZkcTYb0x0yUZrBVv+E8fLBshJXRl0S07K8hnn3/k05aT8ETc?=
 =?us-ascii?Q?LUW0lEEWLk5pm01Krlc0trFoK6z/8weFFFUtaiCTLHUhyQ5CmU3z4D62tVgE?=
 =?us-ascii?Q?0kC8yAGzkV3bte03g0shAlLCK0KrcX2TotseyaqkDm+vVVqY2eyfDnkZKVVL?=
 =?us-ascii?Q?srfKwNQksbLsEN0jkEI0kPHxo3wc5yutN6CVS+leiORyDSni/fmMLzbCgBZY?=
 =?us-ascii?Q?Q2t8TWmEtJ4G7Sv9KLvQZwUWgTpFMT2cbA3mB4fHZUVXssREMiawlpKtjdP0?=
 =?us-ascii?Q?w0BUidxTmAIIcLddNKwDpTz3P9NvJHpE3Y0fOQpCg99JmGSDHGTQvm+hwuPo?=
 =?us-ascii?Q?1FyKHUKBGTUk8+LmWyt2i2psniFZjju4OA3QKwjsf/OJ9/tV3h4ewzXygL7P?=
 =?us-ascii?Q?emgP8QXNcJUPnMyFQdLrnmlWZFydGPqNt2WaTAGC+Ez7LGg0Gf8uPHScrEj/?=
 =?us-ascii?Q?BX9teFFPOqkNMCPn6qh2HgTM26/bbvF8b709EtNyJzub9PMcs8m29nMabOeR?=
 =?us-ascii?Q?IbKepCQ64K2yeJk6ZDJhubCs9ZsnRllfgC5zE34xe+gKmwaDttURP+HNVQrv?=
 =?us-ascii?Q?ENn8EfqraBUKEj/rJpWyrfDd7yQKQ4ag+/HDFSZdtEmNErMTKF4EPayvlonI?=
 =?us-ascii?Q?fhuUXbIuwnrFPRqUgT0TjEvZqjWBzX5eZjQ/Lds0E21oCsy2ctWH65IxK6q8?=
 =?us-ascii?Q?WZAENxzwPurZ69qxQ7T1eTT+Y2Rm+Cf0fw5hN1puehiozf8H1CzoslDnGAwu?=
 =?us-ascii?Q?r3AdyID8KBHTAoiM6i5ZHS487stgEoLcBsTHo2AMw1w654i57/g3T8P1lHf5?=
 =?us-ascii?Q?Xhfsu4RYo4HKkLG+oT4McUdkmYHqTgg7WF57dOFKKg/hRItIByu2qTCYFfZJ?=
 =?us-ascii?Q?lnpFcu1tp5CczBgxh3O0OWGFygUoRxAZgWy/tBLN1ZlzbK4+/LYIvGc8Uql8?=
 =?us-ascii?Q?DLHjY1DCwsGJWOVVFKc6OGzqNlwVCgdd2qHqAatgf2Yo/6I1t0NmpDX7l3q0?=
 =?us-ascii?Q?DkAwjp19bK9hctmLwOyyaQ5SsvBg72YCKVOSCeYt04fKNvggZBgY3KGRExI6?=
 =?us-ascii?Q?L4Vk+vJDW766An3R/VcCdzKLRrX0inFYD0fyMaAvJraf5RNCKff+YWZ9cWvx?=
 =?us-ascii?Q?8gRlCUswN9+SS6Soc2jONErquZWisNBRpFO83sDDmNTvbIW63eL6YyObCA7j?=
 =?us-ascii?Q?Ua+v0+yH8FpSlwhcyZ5g+FkZFjEBG0Bl9Dsiy8KHSSA7k35jh9PB6x8F0u8f?=
 =?us-ascii?Q?x76wtTcaofiUTDDGIWhmwC1HFHxmzqYJjQ/DKTbUUo+DpudCkYZPP6FNZhIo?=
 =?us-ascii?Q?Yxvha0Pr8AAJiW2h4xEHOLHcwk59Bcc=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b91881ac-7b9d-4358-d860-08da3d79d976
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:57.9971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaeftMgk4Lfe0EQSRhdU79u3sYTNqRLSBX5Ognikcj7Hxn9nmms1etPAgDQTEqcA8bJa9ejHXQzUgKolFE9Low==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6P192MB0469
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
 drivers/net/wireless/celeno/cl8k/dfs.c | 768 +++++++++++++++++++++++++
 1 file changed, 768 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs.c

diff --git a/drivers/net/wireless/celeno/cl8k/dfs.c b/drivers/net/wireless/celeno/cl8k/dfs.c
new file mode 100644
index 000000000000..f320e5885a58
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs.c
@@ -0,0 +1,768 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "utils.h"
+#include "debug.h"
+#include "temperature.h"
+#include "traffic.h"
+#include "reg/reg_defs.h"
+#include "config.h"
+#include "debug.h"
+#include "dfs.h"
+
+#define dfs_pr(cl_hw, level, ...) \
+	do { \
+		if ((level) <= (cl_hw)->dfs_db.dbg_lvl) \
+			pr_debug(__VA_ARGS__); \
+	} while (0)
+
+#define dfs_pr_verbose(cl_hw, ...) dfs_pr((cl_hw), DBG_LVL_VERBOSE, ##__VA_ARGS__)
+#define dfs_pr_err(cl_hw, ...)     dfs_pr((cl_hw), DBG_LVL_ERROR, ##__VA_ARGS__)
+#define dfs_pr_warn(cl_hw, ...)    dfs_pr((cl_hw), DBG_LVL_WARNING, ##__VA_ARGS__)
+#define dfs_pr_trace(cl_hw, ...)   dfs_pr((cl_hw), DBG_LVL_TRACE, ##__VA_ARGS__)
+#define dfs_pr_info(cl_hw, ...)    dfs_pr((cl_hw), DBG_LVL_INFO, ##__VA_ARGS__)
+
+/*
+ * ID  Min    Max    Tol    Min  Max  Tol  Tol   MIN    PPB  Trig   Type
+ *     Width  Width  Width  PRI  PRI  PRI  FREQ  Burst       Count
+ */
+
+/* ETSI Radar Types v1.8.2 */
+static struct cl_radar_type radar_type_etsi[] = {
+	{0, 1,  10, 2, 1428, 1428, 2, 1, 1, 18, 10, RADAR_WAVEFORM_SHORT},
+	{1, 1,  10, 2, 1000, 5000, 2, 1, 1, 10, 5,  RADAR_WAVEFORM_SHORT},
+	{2, 1,  15, 2, 625,  5000, 2, 1, 1, 15, 8,  RADAR_WAVEFORM_SHORT},
+	{3, 1,  15, 2, 250,  435,  2, 1, 1, 25, 9, RADAR_WAVEFORM_SHORT},
+	{4, 10, 30, 2, 250,  500,  2, 1, 1, 20, 9, RADAR_WAVEFORM_SHORT},
+	{5, 1,  10, 2, 2500, 3334, 2, 1, 2, 10, 5,  RADAR_WAVEFORM_STAGGERED},
+	{6, 1,  10, 2, 833,  2500, 2, 1, 2, 15, 8,  RADAR_WAVEFORM_STAGGERED},
+};
+
+/* FCC Radar Types 8/14 */
+static struct cl_radar_type radar_type_fcc[] = {
+	{0, 1,  10,   0,  1428, 1428, 1, 1, 1, 18, 10, RADAR_WAVEFORM_SHORT},
+	{1, 1,  10,   3,  518,  3066, 3, 1, 1, 18, 10, RADAR_WAVEFORM_SHORT},
+	{2, 1,  10,   3,  150,  230,  3, 1, 1, 23, 10, RADAR_WAVEFORM_SHORT},
+	{3, 3,  10,   3,  200,  500,  3, 1, 1, 16, 6,  RADAR_WAVEFORM_SHORT},
+	{4, 6,  20,   3,  200,  500,  3, 1, 1, 12, 6,  RADAR_WAVEFORM_SHORT},
+	{5, 50, 100,  50, 1000, 2000, 1, 1, 2, 10, 5,  RADAR_WAVEFORM_LONG},
+	{6, 1,  10,   0,  333,  333,  1, 1, 2, 30, 10, RADAR_WAVEFORM_LONG},
+};
+
+static void cl_dfs_en(struct cl_hw *cl_hw, u8 dfs_en)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+
+	cl_msg_tx_set_dfs(cl_hw, dfs_en, dfs_db->dfs_standard,
+			  conf->ci_dfs_initial_gain, conf->ci_dfs_agc_cd_th);
+	dfs_pr_verbose(cl_hw, "DFS: %s\n", dfs_en ? "Enable" : "Disable");
+}
+
+static bool cl_dfs_create_detection_buffer(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_db,
+					   struct cl_dfs_pulse *pulse_buffer, u8 *samples_cnt,
+					   unsigned long time)
+{
+	u8 i;
+	u8 pulse_idx;
+	/* Init First index to last */
+	u8 first_pulse_idx = (dfs_db->buf_idx - 1 + CL_DFS_PULSE_BUF_SIZE) & CL_DFS_PULSE_BUF_MASK;
+
+	/* Find Start Pulse indexes */
+	for (i = 0; i < CL_DFS_PULSE_BUF_SIZE; i++) {
+		pulse_idx = (i + dfs_db->buf_idx) & CL_DFS_PULSE_BUF_MASK;
+
+		if ((time - dfs_db->dfs_pulse[pulse_idx].time) < dfs_db->search_window) {
+			first_pulse_idx = pulse_idx;
+			break;
+		}
+	}
+
+	dfs_pr_info(cl_hw, "DFS: First pulse idx = %u, Last  pulse idx = %u\n",
+		    first_pulse_idx, (dfs_db->buf_idx - 1 + CL_DFS_PULSE_BUF_SIZE)
+		    & CL_DFS_PULSE_BUF_MASK);
+
+	if (dfs_db->buf_idx >= first_pulse_idx + 1) {
+		if ((dfs_db->buf_idx - first_pulse_idx) < dfs_db->min_pulse_eeq)
+			goto not_enough_pulses;
+	} else {
+		if ((dfs_db->buf_idx + CL_DFS_PULSE_BUF_SIZE - first_pulse_idx) <
+		    dfs_db->min_pulse_eeq)
+			goto not_enough_pulses;
+	}
+
+	/* Copy the processed samples to local Buf to avoid index castings */
+	for (i = 0; pulse_idx != ((dfs_db->buf_idx - 1 + CL_DFS_PULSE_BUF_SIZE)
+		& CL_DFS_PULSE_BUF_MASK); i++) {
+		pulse_idx = (i + first_pulse_idx) & CL_DFS_PULSE_BUF_MASK;
+		memcpy(&pulse_buffer[i], &dfs_db->dfs_pulse[pulse_idx], sizeof(pulse_buffer[i]));
+	}
+	*samples_cnt = i + 1;
+
+	return true;
+not_enough_pulses:
+	/* Return if buffer don't hold enough valid samples */
+	dfs_pr_warn(cl_hw, "DFS: Not enough pulses in buffer\n");
+
+	return false;
+}
+
+static bool cl_dfs_is_valid_dfs_freq(struct cl_hw *cl_hw, u32 freq_off)
+{
+	u16 freq = cl_hw->center_freq + freq_off;
+	u16 freq_min = max((u16)(cl_hw->center_freq - cl_center_freq_offset(cl_hw->bw) - 10),
+		(u16)CL_DFS_MIN_FREQ);
+	u16 freq_max = min((u16)(cl_hw->center_freq + cl_center_freq_offset(cl_hw->bw) + 10),
+		(u16)CL_DFS_MAX_FREQ);
+
+	if (freq > freq_min && freq < freq_max)
+		return true;
+
+	return false;
+}
+
+static void cl_dfs_add_pulses_to_global_buffer(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_db,
+					       struct cl_radar_pulse *pulse, u8 pulse_cnt,
+					       unsigned long time)
+{
+	int  i;
+
+	for (i = 0; i < pulse_cnt; i++)
+		dfs_pr_info(cl_hw, "Pulse=%d, Width=%u, PRI=%u, FREQ=%d, Time=%lu, FOM=%x\n",
+			    i, pulse[i].len, pulse[i].rep, pulse[i].freq, time, pulse[i].fom);
+
+	/* Maintain cyclic pulse buffer */
+	for (i = 0; i < pulse_cnt; i++) {
+		if (!cl_dfs_is_valid_dfs_freq(cl_hw, (u32)pulse[i].freq))
+			continue;
+
+		dfs_db->dfs_pulse[dfs_db->buf_idx].freq = pulse[i].freq;
+		dfs_db->dfs_pulse[dfs_db->buf_idx].width = pulse[i].len;
+		dfs_db->dfs_pulse[dfs_db->buf_idx].pri = pulse[i].rep;
+		dfs_db->dfs_pulse[dfs_db->buf_idx].fom = pulse[i].fom;
+		dfs_db->dfs_pulse[dfs_db->buf_idx].occ = 0; /* occ temp disabled. */
+		dfs_db->dfs_pulse[dfs_db->buf_idx].time = time;
+
+		dfs_db->buf_idx++;
+		dfs_db->buf_idx &= CL_DFS_PULSE_BUF_MASK;
+	}
+}
+
+static bool cl_dfs_buf_maintain(struct cl_hw *cl_hw, struct cl_radar_pulse *pulse,
+				struct cl_dfs_pulse *pulse_buffer, u8 pulse_cnt,
+				unsigned long time, u8 *samples_cnt, struct cl_dfs_db *dfs_db)
+{
+	int  i;
+
+	cl_dfs_add_pulses_to_global_buffer(cl_hw, dfs_db, pulse, pulse_cnt, time);
+	if (!cl_dfs_create_detection_buffer(cl_hw, dfs_db, pulse_buffer, samples_cnt, time))
+		return false;
+
+	for (i = 0; i < *samples_cnt; i++)
+		dfs_pr_info(cl_hw, "DFS: pulse[%d]: width=%u, pri=%u, freq=%d\n",
+			    i, pulse_buffer[i].width, pulse_buffer[i].pri, pulse_buffer[i].freq);
+
+	return true;
+}
+
+static inline bool cl_dfs_pulse_match(s32 pulse_val, s32 spec_min_val,
+				      s32 spec_max_val, s32 spec_tol)
+{
+	return ((pulse_val >= (spec_min_val - spec_tol)) &&
+		(pulse_val <= (spec_max_val + spec_tol)));
+}
+
+static u8 cl_dfs_is_stag_pulse(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_db,
+			       struct cl_dfs_pulse *pulse)
+{
+	int  i;
+	struct cl_radar_type *radar_type;
+
+	for (i = 0; i < dfs_db->radar_type_cnt; i++) {
+		radar_type = &dfs_db->radar_type[i];
+
+		if (radar_type->waveform != RADAR_WAVEFORM_STAGGERED)
+			continue;
+
+		if (cl_dfs_pulse_match((s32)pulse->width, radar_type->min_width,
+				       radar_type->max_width, radar_type->tol_width) &&
+		    cl_dfs_pulse_match((s32)pulse->pri, radar_type->min_pri,
+				       radar_type->max_pri, radar_type->tol_pri)) {
+			/* Search for the second burst */
+			if (abs(pulse[0].pri - pulse[2].pri) <= dfs_db->radar_type[i].tol_pri &&
+			    abs(pulse[1].pri - pulse[3].pri) <= radar_type->tol_pri &&
+			    abs(pulse[0].pri - pulse[1].pri) > radar_type->tol_pri &&
+			    abs(pulse[2].pri - pulse[3].pri) > radar_type->tol_pri) {
+				dfs_pr_info(cl_hw, "DFS: Found match type %d\n", i);
+				return (i + 1);
+			} else if (abs(pulse[0].pri - pulse[3].pri) <= radar_type->tol_pri &&
+				   abs(pulse[1].pri - pulse[4].pri) <= radar_type->tol_pri &&
+				   abs(pulse[0].pri - pulse[1].pri) > radar_type->tol_pri &&
+				   abs(pulse[3].pri - pulse[4].pri) > radar_type->tol_pri) {
+				dfs_pr_info(cl_hw, "DFS: Found match radar %d\n", i);
+				return (i + 1);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static u8 cl_dfs_is_non_stag_pulse(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_db,
+				   struct cl_dfs_pulse *pulse)
+{
+	int  i;
+	struct cl_radar_type *radar_type;
+
+	for (i = 0; i < dfs_db->radar_type_cnt; i++) {
+		radar_type = &dfs_db->radar_type[i];
+
+		if (radar_type->waveform == RADAR_WAVEFORM_STAGGERED)
+			continue;
+
+		if (cl_dfs_pulse_match((s32)pulse->width, radar_type->min_width,
+				       radar_type->max_width, radar_type->tol_width) &&
+		    cl_dfs_pulse_match((s32)pulse->pri, radar_type->min_pri,
+				       radar_type->max_pri, radar_type->tol_pri)) {
+			dfs_pr_info(cl_hw, "DFS: Found match type %d\n", i);
+			return (i + 1);
+		}
+	}
+
+	dfs_pr_warn(cl_hw, "DFS: Match not found\n");
+
+	return 0;
+}
+
+static u8 cl_dfs_get_pulse_type(struct cl_hw *cl_hw, struct cl_dfs_pulse *pulse,
+				bool stag_candidate)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+
+	if (stag_candidate) {
+		u8 pulse_type = cl_dfs_is_stag_pulse(cl_hw, dfs_db, pulse);
+
+		if (pulse_type)
+			return pulse_type;
+	}
+
+	return cl_dfs_is_non_stag_pulse(cl_hw, dfs_db, pulse);
+}
+
+static bool cl_dfs_compare_cand(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_db, u8 pulse_type,
+				struct cl_dfs_pulse radar_cand, u8 *match, int idx,
+				u8 *occ_ch_cand)
+{
+	int i;
+
+	if (!(abs(dfs_db->pulse_buffer[idx].width - radar_cand.width) <=
+	    dfs_db->radar_type[pulse_type].tol_width))
+		goto end;
+
+	if (!(abs(dfs_db->pulse_buffer[idx].freq - radar_cand.freq) <=
+	    dfs_db->radar_type[pulse_type].tol_freq))
+		goto end;
+
+	for (i = 1; i < CL_DFS_CONCEAL_CNT; i++)
+		if (abs(dfs_db->pulse_buffer[idx].pri - i * radar_cand.pri) <=
+		    dfs_db->radar_type[pulse_type].tol_pri)
+			break;
+
+	if (i == CL_DFS_CONCEAL_CNT)
+		goto end;
+
+	(*match)++;
+	(*occ_ch_cand) += dfs_db->pulse_buffer[i].occ;
+
+end:
+	dfs_pr_info(cl_hw, "DFS: compared pulse - width=%u, pri=%u, freq=%u match: %u "
+		    "trig cnt: %u\n",
+		    dfs_db->pulse_buffer[idx].width, dfs_db->pulse_buffer[idx].pri,
+		    dfs_db->pulse_buffer[idx].freq, *match,
+		    dfs_db->radar_type[pulse_type].trig_count);
+
+	if (*match < dfs_db->radar_type[pulse_type].trig_count)
+		return false;
+
+	return true;
+}
+
+static bool cl_dfs_check_cand(struct cl_hw *cl_hw, struct cl_dfs_db *dfs_db, u8 pulse_type,
+			      struct cl_dfs_pulse radar_cand, u8 samples_cnt)
+{
+	u8 occ_ch_cand = 0;
+	u8 match = 0;
+	int i;
+
+	dfs_pr_info(cl_hw, "DFS: candidate pulse - width=%u, pri=%u, freq=%u\n",
+		    radar_cand.width, radar_cand.pri, radar_cand.freq);
+
+	for (i = 0; i < samples_cnt; i++) {
+		if (!cl_dfs_compare_cand(cl_hw, dfs_db, pulse_type, radar_cand, &match, i,
+					 &occ_ch_cand))
+			continue;
+
+		dfs_pr_verbose(cl_hw, "DFS: Radar detected - type %u\n", pulse_type);
+
+		return true;
+	}
+
+	return false;
+}
+
+static bool cl_dfs_short_pulse_search(struct cl_hw *cl_hw, struct cl_radar_pulse *pulse,
+				      u8 pulse_cnt, unsigned long time, struct cl_dfs_db *dfs_db)
+{
+	int i;
+	bool stag_candidate;
+	u8 samples_cnt = 0;
+	u8 pulse_type;
+
+	/* Return if not enough pulses in the buffer */
+	if (!cl_dfs_buf_maintain(cl_hw, pulse, dfs_db->pulse_buffer, pulse_cnt, time,
+				 &samples_cnt, dfs_db))
+		return false;
+
+	for (i = 0; i < samples_cnt; i++) {
+		struct cl_dfs_pulse radar_cand;
+
+		stag_candidate = false;
+
+		/* Make sure there is enough samples to staggered check */
+		if (dfs_db->dfs_standard == NL80211_DFS_ETSI &&
+		    (samples_cnt - i) > CL_DFS_STAGGERED_CHEC_LEN)
+			stag_candidate = true;
+
+		pulse_type = cl_dfs_get_pulse_type(cl_hw, &dfs_db->pulse_buffer[i], stag_candidate);
+
+		if (!pulse_type)
+			continue;
+
+		radar_cand.width = dfs_db->pulse_buffer[i].width;
+		radar_cand.pri = dfs_db->pulse_buffer[i].pri;
+		radar_cand.freq = dfs_db->pulse_buffer[i].freq;
+
+		if (cl_dfs_check_cand(cl_hw, dfs_db, pulse_type - 1, radar_cand, samples_cnt))
+			return true;
+	}
+
+	return false;
+}
+
+static bool cl_dfs_long_pulse_search(struct cl_hw *cl_hw, struct cl_radar_pulse *pulse,
+				     u8 pulse_cnt, unsigned long time)
+{
+	u32 prev_pulse_time_diff;
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	int i;
+
+	for (i = 0; i < pulse_cnt; i++) {
+		if (pulse[i].len > CL_DFS_LONG_MIN_WIDTH) {
+			prev_pulse_time_diff = time - dfs_db->last_long_pulse_ts;
+
+			if (pulse[i].rep >= dfs_db->radar_type[5].min_pri &&
+			    pulse[i].rep <= dfs_db->radar_type[5].max_pri)
+				dfs_db->long_pri_match_count += 1;
+
+			dfs_pr_info(cl_hw, "DFS: Long pulse search: width = %u, delta_time = %u\n",
+				    pulse[i].len, prev_pulse_time_diff);
+
+			if (dfs_db->long_pulse_count == 0 ||
+			    (prev_pulse_time_diff >= conf->ci_dfs_long_pulse_min &&
+			     prev_pulse_time_diff <= conf->ci_dfs_long_pulse_max)) {
+				dfs_db->long_pulse_count += 1;
+			} else if (prev_pulse_time_diff > min(dfs_db->max_interrupt_diff,
+						     conf->ci_dfs_long_pulse_min)) {
+				dfs_db->long_pulse_count = 0;
+				dfs_db->short_pulse_count = 0;
+				dfs_db->long_pri_match_count = 0;
+			}
+			dfs_db->last_long_pulse_ts = time;
+		} else if (pulse[i].len < CL_DFS_LONG_FALSE_WIDTH) {
+			dfs_db->short_pulse_count++;
+
+			if (dfs_db->short_pulse_count > CL_DFS_LONG_FALSE_IND) {
+				dfs_db->long_pulse_count = 0;
+				dfs_db->short_pulse_count = 0;
+				dfs_db->long_pri_match_count = 0;
+
+				dfs_pr_warn(cl_hw, "DFS: Restart long sequence search\n");
+			}
+		}
+	}
+
+	if (dfs_db->long_pulse_count >= dfs_db->radar_type[5].trig_count &&
+	    dfs_db->long_pri_match_count >= (dfs_db->radar_type[5].trig_count - 1)) {
+		dfs_db->short_pulse_count = 0;
+		dfs_db->long_pulse_count = 0;
+		dfs_db->long_pri_match_count = 0;
+		return true;
+	} else {
+		return false;
+	}
+}
+
+static bool cl_dfs_post_detection(struct cl_hw *cl_hw)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+
+	/* Make sure firmware sets the DFS registers */
+	cl_radar_flush(cl_hw);
+	cl_msg_tx_set_dfs(cl_hw, false, dfs_db->dfs_standard,
+			  cl_hw->conf->ci_dfs_initial_gain, cl_hw->conf->ci_dfs_agc_cd_th);
+
+	ieee80211_radar_detected(cl_hw->hw);
+
+	return true;
+}
+
+bool cl_dfs_pulse_process(struct cl_hw *cl_hw, struct cl_radar_pulse *pulse, u8 pulse_cnt,
+			  unsigned long time)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+
+	dfs_db->pulse_cnt += pulse_cnt;
+
+	if (dfs_db->dfs_standard == NL80211_DFS_FCC &&
+	    cl_dfs_long_pulse_search(cl_hw, pulse, pulse_cnt, time)) {
+		dfs_pr_verbose(cl_hw, "DFS: Radar detected - long\n");
+		return cl_dfs_post_detection(cl_hw);
+	} else if (cl_dfs_short_pulse_search(cl_hw, pulse, pulse_cnt, time, dfs_db)) {
+		return cl_dfs_post_detection(cl_hw);
+	}
+
+	return false;
+}
+
+static void cl_dfs_set_min_pulse(struct cl_hw *cl_hw)
+{
+	int i;
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+
+	dfs_db->min_pulse_eeq = U8_MAX;
+
+	for (i = 0; i < dfs_db->radar_type_cnt; i++) {
+		if (dfs_db->radar_type[i].trig_count < dfs_db->min_pulse_eeq)
+			dfs_db->min_pulse_eeq = dfs_db->radar_type[i].trig_count;
+	}
+	dfs_db->min_pulse_eeq = max(dfs_db->min_pulse_eeq, (u8)CL_DFS_MIN_PULSE_TRIG);
+}
+
+static void cl_dfs_set_region(struct cl_hw *cl_hw, enum nl80211_dfs_regions std)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+
+	dfs_db->dfs_standard = std;
+
+	if (dfs_db->dfs_standard == NL80211_DFS_FCC) {
+		dfs_db->radar_type = radar_type_fcc;
+		dfs_db->radar_type_cnt = sizeof(radar_type_fcc) / sizeof(struct cl_radar_type);
+	} else {
+		dfs_db->radar_type = radar_type_etsi;
+		dfs_db->radar_type_cnt = sizeof(radar_type_etsi) / sizeof(struct cl_radar_type);
+	}
+}
+
+static void cl_dfs_start_cac(struct cl_dfs_db *db)
+{
+	db->cac.started = true;
+}
+
+static void cl_dfs_end_cac(struct cl_dfs_db *db)
+{
+	db->cac.started = false;
+}
+
+void cl_dfs_radar_listen_start(struct cl_hw *cl_hw)
+{
+	set_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+
+	cl_dfs_en(cl_hw, true);
+
+	dfs_pr_verbose(cl_hw, "DFS: Started radar listening\n");
+}
+
+void cl_dfs_radar_listen_end(struct cl_hw *cl_hw)
+{
+	clear_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+
+	cl_dfs_en(cl_hw, false);
+
+	dfs_pr_verbose(cl_hw, "DFS: Ended radar listening\n");
+}
+
+void cl_dfs_force_cac_start(struct cl_hw *cl_hw)
+{
+	bool is_listening = test_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+
+	cl_dfs_start_cac(&cl_hw->dfs_db);
+
+	/* Reset request state upon completion */
+	cl_dfs_request_cac(cl_hw, false);
+
+	/* Disable all the TX flow - be silent */
+	cl_tx_en(cl_hw, CL_TX_EN_DFS, false);
+
+	/* If for some reason we are still not listening radar, do it */
+	if (unlikely(!is_listening && cl_hw->hw->conf.radar_enabled))
+		cl_dfs_radar_listen_start(cl_hw);
+
+	dfs_pr_verbose(cl_hw, "DFS: CAC started\n");
+}
+
+void cl_dfs_force_cac_end(struct cl_hw *cl_hw)
+{
+	bool is_listening = test_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+
+	/* Enable all the TX flow */
+	cl_tx_en(cl_hw, CL_TX_EN_DFS, true);
+
+	/*
+	 * If for some reason we are still listening and mac80211 does not
+	 * require to listen radar - disable it
+	 */
+	if (unlikely(is_listening && !cl_hw->hw->conf.radar_enabled))
+		cl_dfs_radar_listen_end(cl_hw);
+
+	cl_dfs_end_cac(&cl_hw->dfs_db);
+
+	dfs_pr_verbose(cl_hw, "DFS: CAC ended\n");
+}
+
+bool __must_check cl_dfs_is_in_cac(struct cl_hw *cl_hw)
+{
+	return cl_hw->dfs_db.cac.started;
+}
+
+bool __must_check cl_dfs_radar_listening(struct cl_hw *cl_hw)
+{
+	return test_bit(CL_DEV_RADAR_LISTEN, &cl_hw->drv_flags);
+}
+
+bool __must_check cl_dfs_requested_cac(struct cl_hw *cl_hw)
+{
+	return cl_hw->dfs_db.cac.requested;
+}
+
+void cl_dfs_request_cac(struct cl_hw *cl_hw, bool should_do)
+{
+	cl_hw->dfs_db.cac.requested = should_do;
+}
+
+static void cl_dfs_edit_tbl(struct cl_hw *cl_hw, u8 row, u8 line, s16 val)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+
+	if (row > dfs_db->radar_type_cnt) {
+		dfs_pr_err(cl_hw, "Invalid row number (%u) [0 - %u]\n", line,
+			   dfs_db->radar_type_cnt - 1);
+		return;
+	}
+
+	if (line == 0 || line > CL_DFS_MAX_TBL_LINE) {
+		dfs_pr_err(cl_hw, "Invalid line number (%u) [1 - %u]\n", line,
+			   CL_DFS_MAX_TBL_LINE - 1);
+		return;
+	}
+
+	if (line == 1)
+		dfs_db->radar_type[row].min_width = (s32)val;
+	else if (line == 2)
+		dfs_db->radar_type[row].max_width = (s32)val;
+	else if (line == 3)
+		dfs_db->radar_type[row].tol_width = (s32)val;
+	else if (line == 4)
+		dfs_db->radar_type[row].min_pri = (s32)val;
+	else if (line == 5)
+		dfs_db->radar_type[row].max_pri = (s32)val;
+	else if (line == 6)
+		dfs_db->radar_type[row].tol_pri = (s32)val;
+	else if (line == 7)
+		dfs_db->radar_type[row].tol_freq = (s32)val;
+	else if (line == 8)
+		dfs_db->radar_type[row].min_burst = (u8)val;
+	else if (line == 9)
+		dfs_db->radar_type[row].ppb = (u8)val;
+	else if (line == 10)
+		dfs_db->radar_type[row].trig_count = (u8)val;
+	else if (line == 11)
+		dfs_db->radar_type[row].waveform = (enum cl_radar_waveform)val;
+
+	/* Verify if min_pulse_eeq was changed */
+	cl_dfs_set_min_pulse(cl_hw);
+}
+
+static void cl_dfs_tbl_overwrite_set(struct cl_hw *cl_hw)
+{
+	char *tok = NULL;
+	u8 param1 = 0;
+	u8 param2 = 0;
+	s16 param3 = 0;
+	char str[64];
+	char *strp = str;
+
+	if (strlen(cl_hw->conf->ce_dfs_tbl_overwrite) == 0)
+		return;
+
+	snprintf(str, sizeof(str), cl_hw->conf->ce_dfs_tbl_overwrite);
+
+	tok = strsep(&strp, ";");
+	while (tok) {
+		if (sscanf(tok, "%hhd,%hhd,%hd", &param1, &param2, &param3) == 3)
+			cl_dfs_edit_tbl(cl_hw, param1, param2, param3);
+		tok = strsep(&strp, ";");
+	}
+}
+
+void cl_dfs_init(struct cl_hw *cl_hw)
+{
+	struct cl_dfs_db *dfs_db = &cl_hw->dfs_db;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+
+	if (!cl_band_is_5g(cl_hw))
+		return;
+
+	dfs_db->en = conf->ci_ieee80211h;
+
+	cl_hw->dfs_db.dbg_lvl = DBG_LVL_ERROR;
+
+	/*
+	 * Setting min window size to avoid the case where the second interrupt
+	 * within the burst is setting the counter to 0. the max is between jiffies
+	 * unit and max PRI in ms.
+	 */
+	dfs_db->max_interrupt_diff = max(1000 / HZ, 2);
+
+	cl_dfs_set_region(cl_hw, cl_hw->channel_info.standard);
+	dfs_db->search_window = CL_DFS_PULSE_WINDOW;
+
+	cl_dfs_set_min_pulse(cl_hw);
+	cl_dfs_tbl_overwrite_set(cl_hw);
+}
+
+void cl_dfs_reinit(struct cl_hw *cl_hw)
+{
+	cl_dfs_init(cl_hw);
+}
+
+void cl_dfs_recovery(struct cl_hw *cl_hw)
+{
+	/* Re-enable DFS after recovery */
+	if (cl_dfs_is_in_cac(cl_hw)) {
+		cl_dfs_en(cl_hw, true);
+
+		/* If recovery happened during CAC make sure to disable beacon backup */
+		cl_tx_en(cl_hw, CL_TX_EN_DFS, false);
+	}
+}
+
+static bool cl_radar_handler(struct cl_hw *cl_hw, struct cl_radar_elem *radar_elem,
+			     unsigned long time)
+{
+	/* Retrieve the radar pulses structure */
+	struct cl_radar_pulse_array *pulses = radar_elem->radarbuf_ptr;
+
+	cl_dfs_pulse_process(cl_hw, (struct cl_radar_pulse *)pulses->pulse, pulses->cnt, time);
+
+	return false;
+}
+
+static void cl_radar_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct cl_radar_queue_elem *radar_elem = NULL;
+	unsigned long flags = 0;
+	bool radar_stat = false;
+
+	while (!list_empty(&cl_hw->radar_queue.head)) {
+		spin_lock_irqsave(&cl_hw->radar_queue.lock, flags);
+		radar_elem = list_first_entry(&cl_hw->radar_queue.head,
+					      struct cl_radar_queue_elem, list);
+		list_del(&radar_elem->list);
+		spin_unlock_irqrestore(&cl_hw->radar_queue.lock, flags);
+
+		radar_stat = cl_radar_handler(radar_elem->cl_hw, &radar_elem->radar_elem,
+					      radar_elem->time);
+
+		kfree(radar_elem->radar_elem.radarbuf_ptr);
+		kfree(radar_elem);
+	}
+
+	if (!test_bit(CL_DEV_STOP_HW, &cl_hw->drv_flags))
+		if (!radar_stat)
+			cl_irq_enable(cl_hw, cl_hw->ipc_e2a_irq.radar);
+}
+
+void cl_radar_init(struct cl_hw *cl_hw)
+{
+	INIT_LIST_HEAD(&cl_hw->radar_queue.head);
+
+	tasklet_init(&cl_hw->radar_tasklet, cl_radar_tasklet, (unsigned long)cl_hw);
+
+	spin_lock_init(&cl_hw->radar_queue.lock);
+}
+
+void cl_radar_push(struct cl_hw *cl_hw, struct cl_radar_elem *radar_elem)
+{
+	struct cl_radar_queue_elem *new_queue_elem = NULL;
+	u32 i;
+
+	new_queue_elem = kmalloc(sizeof(*new_queue_elem), GFP_ATOMIC);
+
+	if (new_queue_elem) {
+		new_queue_elem->radar_elem.radarbuf_ptr =
+			kmalloc(sizeof(*new_queue_elem->radar_elem.radarbuf_ptr), GFP_ATOMIC);
+
+		if (new_queue_elem->radar_elem.radarbuf_ptr) {
+			new_queue_elem->radar_elem.dma_addr = radar_elem->dma_addr;
+			new_queue_elem->radar_elem.radarbuf_ptr->cnt =
+				radar_elem->radarbuf_ptr->cnt;
+
+			/* Copy into local list */
+			for (i = 0; i < RADAR_PULSE_MAX; i++)
+				new_queue_elem->radar_elem.radarbuf_ptr->pulse[i] =
+					radar_elem->radarbuf_ptr->pulse[i];
+
+			new_queue_elem->time = jiffies_to_msecs(jiffies);
+			new_queue_elem->cl_hw = cl_hw;
+
+			spin_lock(&cl_hw->radar_queue.lock);
+			list_add_tail(&new_queue_elem->list, &cl_hw->radar_queue.head);
+			spin_unlock(&cl_hw->radar_queue.lock);
+		} else {
+			kfree(new_queue_elem);
+		}
+	}
+}
+
+void cl_radar_tasklet_schedule(struct cl_hw *cl_hw)
+{
+	tasklet_schedule(&cl_hw->radar_tasklet);
+}
+
+void cl_radar_flush(struct cl_hw *cl_hw)
+{
+	struct cl_radar_queue_elem *radar_elem = NULL;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&cl_hw->radar_queue.lock, flags);
+
+	while (!list_empty(&cl_hw->radar_queue.head)) {
+		radar_elem = list_first_entry(&cl_hw->radar_queue.head,
+					      struct cl_radar_queue_elem, list);
+		list_del(&radar_elem->list);
+		kfree(radar_elem->radar_elem.radarbuf_ptr);
+		kfree(radar_elem);
+	}
+
+	spin_unlock_irqrestore(&cl_hw->radar_queue.lock, flags);
+}
+
+void cl_radar_close(struct cl_hw *cl_hw)
+{
+	cl_radar_flush(cl_hw);
+	tasklet_kill(&cl_hw->radar_tasklet);
+}
+
-- 
2.36.1

