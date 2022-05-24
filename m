Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3747532957
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiEXLkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiEXLj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:57 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D7791550
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:39:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVT0B+CQqEzKsIfpsxf4PYEWy49ZtTNEzAMGGId0cZfnM+Pc0ulACtpFHPPBaWmIN7WrhwJSJtiM1Yt+fon+c19/ZeWdB+PxEB9Qti3lEhfsxIUC2DelRb+yir/ZuvPNCs5boPpYXkk6b+dDAqXSC1iduXoLaCMm2oaGTri+6wcPaoF1xQfx8+FE2CDJf/H3KbCMGnM9Vd6FXOgm6lsuEx8Y/EbE2wzb4+Hx3E3OgDctCYDeOhi5vbyxIoSns/vP5N3wPC8nfD++N8jQgNlNY81x/iKNHZiGnfWpH3nVyRNb7GtaNZShX6RheVemWvaP8KshQGbbqzRNf6PKX1MDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucTvL73BxGU3jwDbQm7KMzdaWcUR66LqkJX67jbRs6E=;
 b=IvEg2vnj4DRzQGLIgEMyQmmF0jkBRRb20LF2T0RIlwaNF5MvhCNROa5eonqVB9Ha7+w7pNlCQXc3mJXT/rTWYuQ/kDwdwvjynr+0F9hyDH41p5K/rKWKgSp2UQM4ENeDPndnCQq4LKS6u2Wm7CCBkkgt7B2+gtApbRE7Ej+WGeBiEtvc+/i38sPdpXH7lRhUyygsea5vZybK3cjdLj3jxbBvc3KRuNGlcdc7Ng8h/gnJ0ps8j98+Lg4FEY7w64CQRlqM8/6u8+C5B1/rDW6Y5dJcP5HLh8zqC1ya5HHgcxH+c1SfBgKNFX5p4PAapnXIEM8O6RYi3R4AVYHCZRz/+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucTvL73BxGU3jwDbQm7KMzdaWcUR66LqkJX67jbRs6E=;
 b=RkaNVLV+rFQvOK/127rZ01gexe5vGasNBmt5lFtCRxYPggvhim0KQiu+v5qUdNUbB2qkWkWELFgjb0ngDFp9WoNiX8ZzcJZKYGx587e2sa6AV60nup9OIDryr0mith9x59EgQowuP7xTPU+AFkE49jXqbwZI9pxNaCInk3YProU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:27 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:27 +0000
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
Subject: [RFC v2 76/96] cl8k: add stats.c
Date:   Tue, 24 May 2022 14:34:42 +0300
Message-Id: <20220524113502.1094459-77-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6b1bf08-8085-4f3b-6153-08da3d79f903
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB066919C41FFEF79B7A78AAB8F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXIB0EY0g5AI1ykespUgkVJEg5q/yPjXBIQYPoQrpYMnXl0l9nS8KvdKbMIc0fMSIE2i1loCJjHo7nMEZ1ZTsn9DloQVOpnY29KIkJfdtqYVaqNzkgrx9/H9YLPBpZcdshju3mUciKHmZre1egk9USFTL8nRDcEd8IXhoSNEGlwhwFTdpL1JubLiI/MWVFlSCFElUYslRYKy5ZsErSzwd5V14TFVu6K0Yf5eHBwhuaMgBTuljlw9ZgsGw8be4GtgAzAYzFKLsK3NlqoXzLlWOByvISV+ScoHhOFnXVu+SW3bh0WUGqiynbLvsCwiF+Xk0YrCMCA66r6Gp/bL+sadrxDHi9To0+7ARUoJOq2QZuUFtLx+ygfFadbBgUAmViXf30QCXrOzOG/wdalvQ2yuFnXINBu+v/KcLKQuQruxgZ4JOsN+LT3dxONKX8wi0h8yjG96orLMF+PpSAwUGBVB23FBF9/HYb4LFz6PvuRYVyK0RIVu+a9nqLslV5ZpDG+NmwXFd+j6QwUmRE0QRYaFSqbGrbjKp/kL6VvVUhQcmgP4lBd2h+9s+trm0DL+bIu3bgzX7LMay1+hBB+tfTW7g1UmEDJqJNG6/i80fS5Fy7cILo/D0ET7BLS3NHNi5ESgCB7oGoQdNZR1pvYPywMpO87uQYZ2VzXBQMGZRoWglXrjFRayWOjI/DF/0JGwNrjR4hYWK51RjaQ5S1Ibq1BgGreLns9S9pknrsNEnITChpU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(30864003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YW8FiAqDtU1Z/zojI1k/8wf01HAEEmrGWlEU7Ab5iZoLqK/VPU/qhMsmvAc+?=
 =?us-ascii?Q?WUOMxqb6EapBrj1026q+XE9tRL/BlphkF3b+VEdnq1e5slj7dFLzY7vmoT2J?=
 =?us-ascii?Q?+qt0LZhiiP2UdYDeF5UM+B75jbehHnEnGf1z4vhFzk2mLtlq3wVUxSgp834F?=
 =?us-ascii?Q?KZykkrVRmqHDHOwK2nHDvLX/zAGs6Hv4qIKpxd1OR5frLPYeXPmHvf41pRA+?=
 =?us-ascii?Q?Fjc7DUkMWOsxRvb02wKIZhA5E/1dAK0zZFGfdM9qLxCXgKGOiQKrgLBqiReg?=
 =?us-ascii?Q?yMaHeIrsAX++ia0+kr8z9TKJc0R1UWRodhhx+onDCO17mFMzmil86i6/50TI?=
 =?us-ascii?Q?eduC1DVReazJkrwSBCmykMGQkIKDVDX/CznQykRGdXzFJNMYxLpR7nIU2Qc3?=
 =?us-ascii?Q?bYYrrm0g1Wj3kizKfaNEw3t+L38BBmQpB344wcWG6MoKdR3LQZYEte/4fqxy?=
 =?us-ascii?Q?zx0HSIxQadOjrQKhh374++xofI12+4uRrTbadhJGGyZWaOFjmbjWg7Jc6EPK?=
 =?us-ascii?Q?2JLdOpvR7NjAH0ur9e14fGMeDn8Ra4DtC9ROdOyMzJ38IZ+ryDnR0xSL6pYA?=
 =?us-ascii?Q?UKhJ86YRMnqZtASxpqNz0b3cH3/y6fBTSduWLB7YKNIAHtwRlC2CnjtvFXtz?=
 =?us-ascii?Q?OMi2oMiCBHG74baa96bosNdTU57rT11pHGueonbaC+hbV/zL8LRAT7kw6CT/?=
 =?us-ascii?Q?unI5R1Rab2wo9N8u8wqs3td4n2z2JPJO8XiRe5e+Ulwd04NEnkhzCOLfmISn?=
 =?us-ascii?Q?bW11Mthr3u8leXbdS1ZDWl+Rm4dQcNhINmBd+/dljxXPSm5rYr5SiTCP4Lf4?=
 =?us-ascii?Q?4Q6dnK/B3oPtQhzXu8RLjhPkGs55+zwiP7JMyasmupLBmTyw7+9TVptYjwTv?=
 =?us-ascii?Q?lYn9fKwwNsvdlcKjewTr1m6IP2siOl6ZKFVUGTD5J8+WjDMjFmR+oT2yU5VG?=
 =?us-ascii?Q?ugKc3IBaVMa6yLfY4UsV+RMUWU4Lgkw7layWsOun1iLuCGLiOz2pkat3xiP4?=
 =?us-ascii?Q?7/FlYNEKlzeflv7VgDDUdiGtce/HQNcFBjwqk9i7zv5AYPHzS2Q2PGfKcHIY?=
 =?us-ascii?Q?ALyBJ9t1D53CnfXL8hDWG3Qo18d05+gc/R5c7OBm9RERWaSL0sbgO+fm+9ps?=
 =?us-ascii?Q?lIczuQD1b5nNHt0HBRdWZXEVqMR1V/fuJkot7h505AjvuCf8vgsbGxVfBi+6?=
 =?us-ascii?Q?O7BRO01ZhUr98rbbo37/ag7eQ/YC0oPRT7adGj3DWn5VphRPDVa8V1oTAEJT?=
 =?us-ascii?Q?PC/2zLvudwrXkfpXVFQiFwZoz6pO8I/rATzPKR9zs4RkBiXDrelKfH0lntEV?=
 =?us-ascii?Q?ol1iNL6Tl+RO6ywtVnj8tNIcpdOXbnbqgxwZa1eOusViHG3qzI3daqzDmdxu?=
 =?us-ascii?Q?5plZ/0pLrXJAbBynSgEEeJkJX0OFfesmqc7pQfNpU/rDaNvT4hqS1S0064r+?=
 =?us-ascii?Q?wmlscMUOueaeRI0AN6JDnk0JbPj0BDC9nR+OG0oHpcT/NFieRowcb9vzI2ja?=
 =?us-ascii?Q?Of4GhM5kXrxD35SNBU8gMPovEz5oqz1XGmpe2f0R6sQTraoVcxjS1Yn1l7JS?=
 =?us-ascii?Q?jX+IVIfBiwyzKFQH81/aq/G/V4rrSFUC/y8dkk+mx2dhzl4pHzRgzun4mBQQ?=
 =?us-ascii?Q?fYpkMXx4B5s8TxqkGXZRuxh4qB70GqDY6PRDSFnNdsTRNh4yLWy1iEnEfAg3?=
 =?us-ascii?Q?M0cw2ed5cgkZ/4kct+LXUOkPe2402rGfeW3k3ZEgLZkkKnZhhCN5sk05uglU?=
 =?us-ascii?Q?D+wzKpzOKVdYOlqlZ15CrZVctVb3/3c=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b1bf08-8085-4f3b-6153-08da3d79f903
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:50.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qqp7MWf63nb6WDPMSosjxVqwl2e4mlVu/4S1klqBTW6Cdo6o5oy0z3Re9ZQNf1rJZWDoAMwJjRgC+39VR9aryw==
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
 drivers/net/wireless/celeno/cl8k/stats.c | 438 +++++++++++++++++++++++
 1 file changed, 438 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/stats.c

diff --git a/drivers/net/wireless/celeno/cl8k/stats.c b/drivers/net/wireless/celeno/cl8k/stats.c
new file mode 100644
index 000000000000..c526199513f4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/stats.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/string.h>
+
+#include "reg/reg_access.h"
+#include "sta.h"
+#include "utils.h"
+#include "reg/reg_defs.h"
+#include "rates.h"
+#include "debug.h"
+#include "tx.h"
+#include "vif.h"
+#include "stats.h"
+
+static void cll_stats_config_ps(struct cl_sta *cl_sta)
+{
+	struct sta_info *stainfo = IEEE80211_STA_TO_STAINFO(cl_sta->sta);
+
+	cl_sta->stats->ps.timestamp_sleep = jiffies;
+	cl_sta->stats->ps.is_ps = test_sta_flag(stainfo, WLAN_STA_PS_STA);
+}
+
+static void cl_stats_free(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	kfree(cl_sta->stats);
+	cl_sta->stats = NULL;
+}
+
+static void cl_stats_disable(struct cl_hw *cl_hw)
+{
+	pr_debug("Statistics disabled\n");
+	cl_hw->conf->ci_stats_en = false;
+	cl_sta_loop(cl_hw, cl_stats_free);
+
+	if (cl_hw_is_prod_or_listener(cl_hw)) {
+		kfree(cl_hw->rx_stats);
+		cl_hw->rx_stats = NULL;
+	}
+}
+
+static void _cl_stats_update_tx(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				struct cl_agg_tx_report *agg_report)
+{
+	struct cl_stats *stats = cl_sta->stats;
+	struct cl_tx_cntrs *cntrs;
+	union cl_rate_ctrl_info rate_ctrl_info = {
+		.word = le32_to_cpu(agg_report->rate_cntrl_info)};
+	u8 bw, nss, mcs, gi, bf;
+
+	switch (rate_ctrl_info.field.format_mod) {
+	case WRS_MODE_HE:
+		nss = (rate_ctrl_info.field.mcs_index >> 4);
+		mcs = (rate_ctrl_info.field.mcs_index & 0xF);
+		gi = rate_ctrl_info.field.gi;
+
+		{
+			bw = rate_ctrl_info.field.bw;
+			bf = agg_report->bf;
+
+				cntrs = &stats->tx.he[bw][nss][mcs][gi][bf];
+		}
+		break;
+	case WRS_MODE_VHT:
+		bw = rate_ctrl_info.field.bw;
+		nss = (rate_ctrl_info.field.mcs_index >> 4);
+		mcs = (rate_ctrl_info.field.mcs_index & 0xF);
+		gi = rate_ctrl_info.field.gi;
+		bf = agg_report->bf;
+
+			cntrs = &stats->tx.vht[bw][nss][mcs][gi][bf];
+		break;
+	case WRS_MODE_HT:
+		bw = rate_ctrl_info.field.bw;
+		nss = (rate_ctrl_info.field.mcs_index >> 3);
+		mcs = (rate_ctrl_info.field.mcs_index & 0x7);
+		gi = rate_ctrl_info.field.gi;
+		cntrs = &stats->tx.ht[bw][nss][mcs][gi];
+		break;
+	case WRS_MODE_OFDM:
+		mcs = rate_ctrl_info.field.mcs_index - RATE_CTRL_OFFSET_OFDM;
+		cntrs = &stats->tx.ofdm[mcs];
+		break;
+	case WRS_MODE_CCK:
+		mcs = rate_ctrl_info.field.mcs_index;
+		cntrs = &stats->tx.cck[mcs];
+		break;
+	default:
+		return;
+	}
+
+	cntrs->success += agg_report->success;
+	cntrs->fail += agg_report->fail;
+	stats->tx.packet_success += agg_report->success;
+	stats->tx.packet_fail += agg_report->fail;
+}
+
+static void _cl_stats_update_rx_rate(struct cl_hw *cl_hw, struct cl_rx_stats *rx_stats,
+				     struct hw_rxhdr *rxhdr)
+{
+	u8 bw, nss, mcs, gi;
+
+	switch (rxhdr->format_mod) {
+	case FORMATMOD_HE_TRIG:
+		nss = rxhdr->n_sts & 0x3;
+		mcs = min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+		gi = min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+		rx_stats->he_trig[rxhdr->ch_bw][nss][mcs][gi] += rxhdr->frm_successful_rx;
+		rx_stats->flag |= RX_STATS_HE_TRIG;
+		break;
+	case FORMATMOD_HE_EXT:
+		nss = rxhdr->n_sts & 0x3;
+		mcs = min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+		gi = min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+		rx_stats->he_ext[rxhdr->ch_bw][nss][mcs][gi] += rxhdr->frm_successful_rx;
+		rx_stats->flag |= RX_STATS_HE_EXT;
+		break;
+	case FORMATMOD_HE_MU:
+		nss = rxhdr->n_sts & 0x3;
+		mcs = min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+		gi = min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+		rx_stats->he_mu[rxhdr->ch_bw][nss][mcs][gi] += rxhdr->frm_successful_rx;
+		rx_stats->flag |= RX_STATS_HE_MU;
+		break;
+	case FORMATMOD_HE_SU:
+		nss = rxhdr->n_sts & 0x3;
+		mcs = min_t(u8, rxhdr->mcs, WRS_MCS_MAX_HE);
+		gi = min_t(u8, rxhdr->gi_type, WRS_GI_MAX_HE);
+		rx_stats->he_su[rxhdr->ch_bw][nss][mcs][gi] += rxhdr->frm_successful_rx;
+		rx_stats->flag |= RX_STATS_HE_SU;
+		break;
+	case FORMATMOD_VHT:
+		nss = rxhdr->n_sts & 0x3;
+		mcs = min_t(u8, rxhdr->mcs, WRS_MCS_MAX_VHT);
+		gi = rxhdr->gi_type & 0x1;
+		rx_stats->vht[rxhdr->ch_bw][nss][mcs][gi] += rxhdr->frm_successful_rx;
+		rx_stats->flag |= RX_STATS_VHT;
+		break;
+	case FORMATMOD_HT_MF:
+	case FORMATMOD_HT_GF:
+		bw = rxhdr->ch_bw & 0x1;
+		nss = (rxhdr->mcs >> 3) & 0x3;
+		mcs = rxhdr->mcs & 0x7;
+		gi = rxhdr->gi_type & 0x1;
+		rx_stats->ht[bw][nss][mcs][gi] += rxhdr->frm_successful_rx;
+		rx_stats->flag |= RX_STATS_HT;
+		break;
+	case FORMATMOD_NON_HT:
+		if (rxhdr->mcs >= RATE_CTRL_OFFSET_OFDM) {
+			mcs = (rxhdr->mcs - RATE_CTRL_OFFSET_OFDM) & 0x7;
+			rx_stats->ofdm[mcs] += rxhdr->frm_successful_rx;
+			rx_stats->flag |= RX_STATS_OFDM;
+		} else if (cl_band_is_24g(cl_hw)) {
+			mcs = rxhdr->mcs & 0x3;
+			rx_stats->cck[mcs] += rxhdr->frm_successful_rx;
+			rx_stats->flag |= RX_STATS_CCK;
+		}
+		break;
+	}
+
+	rx_stats->packet_success += rxhdr->frm_successful_rx;
+}
+
+void cl_stats_init(struct cl_hw *cl_hw)
+{
+	spin_lock_init(&cl_hw->lock_stats);
+
+	if (cl_hw->conf->ci_stats_en && cl_hw_is_prod_or_listener(cl_hw)) {
+		cl_hw->rx_stats = kzalloc(sizeof(*cl_hw->rx_stats), GFP_ATOMIC);
+
+		if (!cl_hw->rx_stats)
+			cl_hw->conf->ci_stats_en = false;
+	}
+}
+
+void cl_stats_deinit(struct cl_hw *cl_hw)
+{
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	if (cl_hw->conf->ci_stats_en && (cl_hw_is_prod_or_listener(cl_hw))) {
+		cl_hw->conf->ci_stats_en = false;
+
+		kfree(cl_hw->rx_stats);
+		cl_hw->rx_stats = NULL;
+	}
+
+	spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+void cl_stats_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	/*
+	 * If allocation failed disable ci_stats_en
+	 * and free the memory of all other stations
+	 */
+	bool disable = false;
+
+	if (cl_hw->conf->ci_stats_en) {
+		/*
+		 * Take regular lock and not BH,
+		 * because cl_sta_add_to_lut() already disables BH
+		 */
+		spin_lock(&cl_hw->lock_stats);
+
+		cl_sta->stats = kzalloc(sizeof(*cl_sta->stats), GFP_ATOMIC);
+
+		if (cl_sta->stats)
+			cll_stats_config_ps(cl_sta);
+		else
+			disable = true;
+
+		spin_unlock(&cl_hw->lock_stats);
+	}
+
+	if (disable && cl_hw->conf->ci_stats_en) {
+		spin_lock_bh(&cl_hw->lock_stats);
+		cl_stats_disable(cl_hw);
+		spin_unlock_bh(&cl_hw->lock_stats);
+	}
+}
+
+void cl_stats_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	cl_stats_free(cl_hw, cl_sta);
+
+	spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_tx_agg(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			    struct cl_agg_tx_report *agg_report)
+{
+	struct cl_stats *stats = cl_sta->stats;
+
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock(&cl_hw->lock_stats);
+
+	stats->tx.agg_cntr++;
+	stats->tx.fail_cntr += agg_report->fail;
+	_cl_stats_update_tx(cl_hw, cl_sta, agg_report);
+
+	spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_tx_single(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			       struct cl_agg_tx_report *agg_report)
+{
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock(&cl_hw->lock_stats);
+
+	cl_sta->stats->tx.fail_cntr += agg_report->fail;
+	_cl_stats_update_tx(cl_hw, cl_sta, agg_report);
+
+	spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_rx_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+			     s8 rssi[MAX_ANTENNAS])
+{
+	int i;
+	s8 rx_rssi;
+
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	for (i = 0; i < cl_hw->num_antennas; i++) {
+		rx_rssi = rssi[i] * -1;
+
+		if (rx_rssi >= 0 && rx_rssi < RSSI_ARR_SIZE)
+			cl_sta->stats->rssi[rx_rssi][i]++;
+	}
+
+	spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_rx_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct hw_rxhdr *rxhdr)
+{
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock(&cl_hw->lock_stats);
+
+	_cl_stats_update_rx_rate(cl_hw, &cl_sta->stats->rx, rxhdr);
+	cl_sta->stats->fec_coding[rxhdr->fec_coding]++;
+
+	spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_rx_rate_production(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr)
+{
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock(&cl_hw->lock_stats);
+
+	_cl_stats_update_rx_rate(cl_hw, cl_hw->rx_stats, rxhdr);
+
+	spin_unlock(&cl_hw->lock_stats);
+}
+
+void cl_stats_update_ps(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool is_ps)
+{
+	struct cl_ps_stats *ps;
+
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	ps = &cl_sta->stats->ps;
+
+	if (ps->is_ps == is_ps)
+		goto out;
+
+	ps->is_ps = is_ps;
+
+	if (is_ps) {
+		ps->timestamp_sleep = jiffies;
+	} else {
+		unsigned long sleep_time = jiffies_to_msecs(jiffies - ps->timestamp_sleep);
+
+		if (sleep_time <= 50)
+			ps->period[PS_PERIOD_50MS]++;
+		else if (sleep_time <= 100)
+			ps->period[PS_PERIOD_100MS]++;
+		else if (sleep_time <= 250)
+			ps->period[PS_PERIOD_250MS]++;
+		else if (sleep_time <= 500)
+			ps->period[PS_PERIOD_500MS]++;
+		else if (sleep_time <= 750)
+			ps->period[PS_PERIOD_750MS]++;
+		else if (sleep_time <= 1000)
+			ps->period[PS_PERIOD_1000MS]++;
+		else if (sleep_time <= 2000)
+			ps->period[PS_PERIOD_2000MS]++;
+		else if (sleep_time <= 5000)
+			ps->period[PS_PERIOD_5000MS]++;
+		else if (sleep_time <= 10000)
+			ps->period[PS_PERIOD_10000MS]++;
+		else
+			ps->period[PS_PERIOD_ABOVE]++;
+	}
+
+out:
+	spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+int cl_stats_get_rssi(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_stats *stats = NULL;
+	u32 i = 0, j = 0;
+	u64 total_rssi = 0;
+	s8 avg_signal = 0;
+
+	if (!cl_hw->conf->ci_stats_en)
+		return 0;
+
+	u64 avg_rssi[MAX_ANTENNAS] = {0};
+	u64 sum_rssi[MAX_ANTENNAS] = {0};
+
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	stats = cl_sta->stats;
+
+	if (!stats)
+		goto out;
+
+	for (i = 0; i < RSSI_ARR_SIZE; i++) {
+		total_rssi = 0;
+
+		for (j = 0; j < cl_hw->num_antennas; j++) {
+			sum_rssi[j] += stats->rssi[i][j];
+			avg_rssi[j] += i * stats->rssi[i][j];
+		}
+	}
+
+	for (j = 0; j < cl_hw->num_antennas; j++)
+		if (sum_rssi[j])
+			avg_rssi[j] = div64_u64(avg_rssi[j], sum_rssi[j]);
+
+	for (j = 0; j < cl_hw->num_antennas; j++)
+		total_rssi += avg_rssi[j];
+
+	avg_signal = -div64_u64(total_rssi, cl_hw->num_antennas);
+out:
+	spin_unlock_bh(&cl_hw->lock_stats);
+
+	return avg_signal;
+}
+
+void cl_stats_get_tx(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+		     u64 *total_tx_success, u64 *total_tx_fail)
+{
+	if (!cl_hw->conf->ci_stats_en)
+		return;
+
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	if (!cl_sta->stats)
+		goto out;
+
+	*total_tx_success = cl_sta->stats->tx.packet_success;
+	*total_tx_fail = cl_sta->stats->tx.packet_fail;
+
+out:
+	spin_unlock_bh(&cl_hw->lock_stats);
+}
+
+u64 cl_stats_get_rx(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	u64 total_rx_packets = 0;
+
+	if (!cl_hw->conf->ci_stats_en)
+		return 0;
+
+	spin_lock_bh(&cl_hw->lock_stats);
+
+	if (!cl_sta->stats)
+		goto out;
+
+	total_rx_packets = cl_sta->stats->rx.packet_success;
+
+out:
+	spin_unlock_bh(&cl_hw->lock_stats);
+
+	return total_rx_packets;
+}
+
-- 
2.36.1

