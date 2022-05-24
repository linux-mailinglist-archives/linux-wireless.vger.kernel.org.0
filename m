Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E81532933
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbiEXLhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiEXLhr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D90D43382
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiKDUIbf59c46mJZzKILqt6qk4BLi7mg2+O4bRNd65IXB9RD7rAabO75rFfw2N2WQqUFKCZK7rO2hH25Xe90m9CbOAswIIilDKH8WV8LMn24/B7gGMTyg71aflwtoYIo9HRT91LRvxs2WWxCNK7OPEwJNpTS3TwLB3gENzyKsLxtNVhnLdeLTl7tV1D3E2PV90Cilo8DwtMCGh11LUoOCGndnS8WLBxMRKJQglexuJhzDWKYez90Gl+FhrK6Wu+JbMrsAwGZQXpKsMd9ff83BspMx2vQeQZBJeqeWB+GXGBXkJ9WhBthPxZh5+RE7fUrBEg4KZRc320f6B4dbX12dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeb3FHhx+tyxQtFSK2dzU3Egjt5EmUVBktfGqECSgX8=;
 b=Jsa+un4khak5yMXFfDK+To/0F/NmOfL8tUMSDUJvXxpbfMvz+jhaUpXVRfMhjadxKuJg7kIXNvQNOj14UtJ8nyyt3zaAQNl9DMzLpny/nahxe61rDZQ5HallIwMLmNqIbmrqRvH8smf6RW5jX+T4KM2TUcA/guHA+ZMTwRpYAFVVEtzT2KYK5LmI/ZNbNSAkZWKubn2lWKk0RgLX8ZtkUOE2H+iIF0b06bV+zkvC0FW/WDWcOy6uq2Laztn0SuQLvtaAa0kCfDAksIPlHNVaDf3uBGq4Sh1bQPvXKuNeoxxZtMsSJoWJfLNywuSFCEpinnoixcg1fyoUipr2kRBTJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeb3FHhx+tyxQtFSK2dzU3Egjt5EmUVBktfGqECSgX8=;
 b=KAMo0CQk3RBs69jcYzaHNsKEG1TXs8E0oBKrrL+4XOqiifuXxx4Dh98RkYJKs5avHbz8INXD3J5p+SK99Jo5ebvsBh1oh1c5muK8mSgG0MgdWk93LZMBCeSuCQQYO9i5E7204wyvB/T4AK3SGH6PFYF6sguOeWZNztESIZQx7kI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:37:40 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:40 +0000
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
Subject: [RFC v2 07/96] cl8k: add bf.c
Date:   Tue, 24 May 2022 14:33:33 +0300
Message-Id: <20220524113502.1094459-8-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 46645a11-422f-49d0-5c42-08da3d79cf52
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB0305A0AF0E8FE2D1E1FF95EAF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HsDqmtLPpNk+/YVlkwL21WeFoely674JNYelMmB0AmkDz5B7WVUGBgnfRFFNESrQpAZmXbYqU3dzXjeQwkcMIzisTmx3OTQvb9/Qb5I0epAwUVauhP76TdAeGALJMnOL1y7rqKY+KNAAy0q/ms9CbOW1VSKaunbsYze4gV2h8PNnnKAD+zaJ7HELsvTsZ+QbhKapC3gragGAnMcNFu+Zo45f03jiRAaoten6AcDITYvEyKTX/5ROEEOKwq0bf66oqeOiCMuVKYlkpEl9tF/D78rGk0cVaoy5YsnqGgL+gHPPUZ3QCGDjiMWn0jXca0rhnWq9CEv1j3ZBLldmJwF3nnQ3woAmyTns9BM8GeoA80l6rDJZKv5LBBF4K6JPGuxpJMSl/jPdwr+uJLWGBr/wXd/flmkiJqGhOmRTd8V2l2D/jpvmyKyYSYWuw3qpcPTIjDn/8eu9T6TCG+1+L2i0py71155DSF6SVR/OSdBDobCZHouInzHqjTH4gOW1mtElzeT/7EsGhKYN1nD3OmVKbS46fQ1MkJsUBHnbUCJ8nEuRpN7yQkvL/EwslV0dYbMRDILpFn6O+jAoXogIiY6u7FXTq64qarRAMgKAX787zFdPNllWfWxPsA1qLNFt27vc2IAGpl2ONwKJVtukq2V5+aaSJvh/7hPPLviqBJLNYlo2c+ZbmJPn7KBQJheCzX5/+scgY3UdH8l/8Le5OZSFAic4gh/APh2qjky/u198rWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(30864003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VOYkJz3hVsm1XgEb1LTENF6LlnHCe98lW4iRH0+9tQDHIOkC/0Tw5EskWWk1?=
 =?us-ascii?Q?6P5tkh3h3beOBWI1xuIrFnaP1e9GYcdWfiAFcOsEKTiCYXm500AbiWG1Xpvq?=
 =?us-ascii?Q?LpHFFP8EIjlpSyOBkfgUxZVCnYF8RKYgPMmKC9dDbHxxIm3kFVGoozQCXifJ?=
 =?us-ascii?Q?AyzP2iG02NC7PD9eQ6yRDWlirilgfZdQOYSSWkL7CgnzqxOnHzRRNxDMX9cu?=
 =?us-ascii?Q?q+HuNrMMg6Qfi0TKF6Px+b9hhNXWjvBnoaQ1gD77b0nRgWfhUAKrACeCa1Lg?=
 =?us-ascii?Q?ZfJJlsIoiMxfGZdVZXJifV4Q+Fd91kpLaQULd7ldFtHjddKH7L8v2VZP1KgY?=
 =?us-ascii?Q?02xt7atAkVQnqWQKunyWaTxnB1UNz3mjo+Z3MCyaxkCvg8hA1FwQqQzDHs81?=
 =?us-ascii?Q?iHeY8bJhHGuO+a4+xsX2dFokfdyyGbeDWd7ME+wZqbotl9kL3hQ3YnIXfXI3?=
 =?us-ascii?Q?eBo/Y9mYcGO+CSyGC2Ja10AuFzo9gZBHUEaxt4ywTznDOVM9tg+ew0qfxk29?=
 =?us-ascii?Q?zmkm0b39OTAgPy4tqaOrRjSYbeSr1j3kl0tPZ/WxikPjyGdNofprCPsHD59f?=
 =?us-ascii?Q?TlTfuCV9/s8GnCv2awhrvEeAic7CH7oKLkE4sEZXrS8s+rp7vEbB6ASN0kD2?=
 =?us-ascii?Q?/gdAadxgN166KUrEDBxgd119Ogh0QbrXGCntlwYvEIc9O9xIbFCCCWyfsOUW?=
 =?us-ascii?Q?0YhF/7urYbcEs2q7C4x7wBi6iOSMK/5BFfC9XsXzMX117iUkQQURTqUojv05?=
 =?us-ascii?Q?AQpTUcOwePZcWrteN7AMgBKWJqRcD6koecr0PbSv0dal+z300qbI6ZiqyHnW?=
 =?us-ascii?Q?CjD9IN8bC3wky3Qt86o7HCNqhHGwIYHoUKcdN1VFkjA1CBNm4HVUg0UbJ8H4?=
 =?us-ascii?Q?QDeXshRNzfYWO5xQPBDJHmv5Zfnx4Li8TNSmWlD82lLO7BEQDJph1kesSTxN?=
 =?us-ascii?Q?objPU6wg5TG1zqpwSf6TjAtJkkqVuG+0bGNByNN8iWPDLNC1ox3yInc0P/YH?=
 =?us-ascii?Q?JKBbdpM6uoZIYDdAriFPzhCRj+r7oe4e42DGtx/JKzmb70JJjrkfloYVwkFN?=
 =?us-ascii?Q?hjrNDVKG3GYg5JJxqhtYvKqsNlPioI/Zom4pm1ZZVmFQr847Po4Gr0vVVBRi?=
 =?us-ascii?Q?JDnZ2/Vve0eLGAd68nd/gBSsyLujgMHLIp4SilMiw961NADhcEshKMmK8vo9?=
 =?us-ascii?Q?IzaUGdRHat+0iehGA/mjo5IKT6Kpef42JcHxYCAGzFl4SzD/nVV932qYUibS?=
 =?us-ascii?Q?BLvIrPqZaGvq3ziK1RXXTMwP98j+nbaf0RkcRv6MqQ6ZiXH7bl/144fF14+O?=
 =?us-ascii?Q?YkDBcBeFxII0BSF5e1fRjlxJPaPjMkioAiE5/RCjJ3Q90x4zhV3pFTDLa9hN?=
 =?us-ascii?Q?rR6yrCHRGs+28ynmY7NFwQ9Im1IjZ2+lhzIYN1PQ3FceygtoKho78NL+du1w?=
 =?us-ascii?Q?bk3mIbxt5YKg3+aEjl9Zcw3SkCsjjlIERMxxkXnLjNvATn0p5t3mIMDix+nc?=
 =?us-ascii?Q?kOJG8gAmndamDZ0URhPRNq83Es/DhjruGa5Fp6k4ScGr7Lfd3VcfmxERxgcb?=
 =?us-ascii?Q?Cy3DlbqORCocx4Jr8X+/dykwGdTfYbVe8gO8ipY3TgyReDZmIyZM2KokBN0c?=
 =?us-ascii?Q?CyxwBnpsxWMkTgD+o7guYULagndbswxSCGLU8+xGdfwHBDKujeID1Smc0C4j?=
 =?us-ascii?Q?yeSwVLjHtdRygoisXB+Bpj33TH2pPm5xz61IlTfyvPPC8yaI7rpxQ0qy8qmb?=
 =?us-ascii?Q?fxXc9ngdDmbPI4LcM/8gxW1tNp/PkPs=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46645a11-422f-49d0-5c42-08da3d79cf52
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:40.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNUOF8/gscT/mJhU0CzIR3cStl/ves9dhIB9ej82Mv4/tuEQBKHeLfMVm0PeDwQ98Z27BhpiDDaioaJWuiF5Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0305
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
 drivers/net/wireless/celeno/cl8k/bf.c | 346 ++++++++++++++++++++++++++
 1 file changed, 346 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/bf.c

diff --git a/drivers/net/wireless/celeno/cl8k/bf.c b/drivers/net/wireless/celeno/cl8k/bf.c
new file mode 100644
index 000000000000..49d16e13e6e4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/bf.c
@@ -0,0 +1,346 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "hw.h"
+#include "traffic.h"
+#include "sta.h"
+#include "sounding.h"
+#include "debug.h"
+#include "bf.h"
+
+#define CL_BF_MIN_SOUNDING_NR 3
+
+#define bf_pr(cl_hw, level, ...) \
+	do { \
+		if ((level) <= (cl_hw)->bf_db.dbg_level) \
+			pr_debug("[BF]" __VA_ARGS__); \
+	} while (0)
+
+#define bf_pr_verbose(cl_hw, ...) bf_pr((cl_hw), DBG_LVL_VERBOSE, ##__VA_ARGS__)
+#define bf_pr_err(cl_hw, ...)     bf_pr((cl_hw), DBG_LVL_ERROR, ##__VA_ARGS__)
+#define bf_pr_warn(cl_hw, ...)    bf_pr((cl_hw), DBG_LVL_WARNING, ##__VA_ARGS__)
+#define bf_pr_trace(cl_hw, ...)   bf_pr((cl_hw), DBG_LVL_TRACE, ##__VA_ARGS__)
+#define bf_pr_info(cl_hw, ...)    bf_pr((cl_hw), DBG_LVL_INFO, ##__VA_ARGS__)
+
+static bool cl_bf_is_beamformee_capable_he(struct ieee80211_sta *sta, bool mu_cap)
+{
+	u8 phy_cap_info4 = sta->he_cap.he_cap_elem.phy_cap_info[4];
+
+	if (mu_cap)
+		return (phy_cap_info4 & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER);
+	else
+		return (phy_cap_info4 & IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE);
+}
+
+static bool cl_bf_is_beamformee_capable_vht(struct ieee80211_sta *sta, bool mu_cap)
+{
+	u32 vht_cap = sta->vht_cap.cap;
+
+	if (mu_cap)
+		return (vht_cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+	else
+		return (vht_cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+}
+
+static bool cl_bf_is_beamformee_capable(struct cl_sta *cl_sta, bool mu_cap)
+{
+	struct ieee80211_sta *sta = cl_sta->sta;
+
+	if (sta->he_cap.has_he)
+		return cl_bf_is_beamformee_capable_he(sta, mu_cap);
+
+	if (sta->vht_cap.vht_supported)
+		return cl_bf_is_beamformee_capable_vht(sta, mu_cap);
+
+	return false;
+}
+
+void cl_bf_enable(struct cl_hw *cl_hw, bool enable, bool trigger_decision)
+{
+	struct cl_tcv_conf *conf = cl_hw->conf;
+
+	if (cl_hw->bf_db.enable == enable)
+		return;
+
+	if (!conf->ci_bf_en && enable) {
+		bf_pr_err(cl_hw, "Unable to enable - BF is globally disabled\n");
+		return;
+	}
+
+	cl_hw->bf_db.enable = enable;
+	bf_pr_verbose(cl_hw, "%s\n", enable ? "Enable" : "Disable");
+
+	if (trigger_decision)
+		cl_sta_loop_bh(cl_hw, cl_bf_sounding_decision);
+}
+
+static void cl_bf_timer_callback(struct timer_list *t)
+{
+	/*
+	 * If timer expired it means that we started sounding but didn't get any
+	 * indication for (10 * sounding_interval).
+	 * So we disable sounding for this station (even when in starts again traffic).
+	 */
+	struct cl_bf_sta_db *bf_db = from_timer(bf_db, t, timer);
+	struct cl_sta *cl_sta = container_of(bf_db, struct cl_sta, bf_db);
+	struct cl_hw *cl_hw = cl_sta->cl_vif->cl_hw;
+
+	bf_pr_trace(cl_hw, "Failed to get reply (%u)\n", cl_sta->sta_idx);
+	bf_db->indication_timeout = true;
+	cl_bf_sounding_decision(cl_hw, cl_sta);
+}
+
+static void cl_bf_reset_sounding_info(struct cl_sta *cl_sta)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	bf_db->synced = false;
+	bf_db->sounding_start = false;
+	bf_db->sounding_indications = 0;
+}
+
+void cl_bf_sounding_start(struct cl_hw *cl_hw, enum sounding_type type, struct cl_sta **cl_sta_arr,
+			  u8 sta_num, struct cl_sounding_info *recovery_elem)
+{
+#define STA_INDICES_STR_SIZE 64
+
+	/* Send request to start sounding */
+	u8 i, bw = CHNL_BW_MAX;
+	char sta_indices_str[STA_INDICES_STR_SIZE] = {0};
+	u8 str_len = 0;
+
+	for (i = 0; i < sta_num; i++) {
+		struct cl_sta *cl_sta = cl_sta_arr[i];
+		struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+		bw = cl_sta->wrs_sta.assoc_bw;
+		bf_db->synced = false;
+		bf_db->sounding_start = true;
+		bf_db->sounding_indications = 0;
+
+		str_len += snprintf(sta_indices_str, STA_INDICES_STR_SIZE - str_len, "%u%s",
+				    cl_sta->sta_idx, (i == sta_num - 1 ? ", " : ""));
+	}
+
+	bf_pr_trace(cl_hw, "Start sounding: Sta = %s\n", sta_indices_str);
+	cl_sounding_send_request(cl_hw, cl_sta_arr, sta_num, SOUNDING_ENABLE, type, bw, NULL, 0,
+				 recovery_elem);
+
+#undef STA_INDICES_STR_SIZE
+}
+
+void cl_bf_sounding_stop(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	if (bf_db->sounding_start) {
+		/* Send request to stop sounding */
+		cl_bf_reset_sounding_info(cl_sta);
+		bf_pr_trace(cl_hw, "Sta = %u, Stop sounding\n", cl_sta->sta_idx);
+		cl_sounding_send_request(cl_hw, &cl_sta, 1, SOUNDING_DISABLE, SOUNDING_TYPE_HE_SU,
+					 0, NULL, 0, NULL);
+		bf_pr_trace(cl_hw, "Sta: %u, Beamforming disabled\n", cl_sta->sta_idx);
+	}
+}
+
+void cl_bf_sounding_decision(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	if (cl_bf_is_enabled(cl_hw) &&
+	    cl_bf_is_beamformee_capable(cl_sta, false) &&
+	    !bf_db->indication_timeout &&
+	    ((bf_db->beamformee_sts + 1) >= CL_BF_MIN_SOUNDING_NR) &&
+	    (bf_db->traffic_active || cl_hw->bf_db.force)) {
+		if (!bf_db->sounding_start) {
+			if (cl_sta->su_sid == INVALID_SID)
+				cl_bf_sounding_start(cl_hw, SOUNDING_TYPE_HE_SU, &cl_sta, 1, NULL);
+			else
+				bf_pr_verbose(cl_hw, "[%s]: STA %u already belongs to sid %u\n",
+					      __func__, cl_sta->sta_idx, cl_sta->su_sid);
+		}
+	} else {
+		del_timer(&bf_db->timer);
+		cl_bf_sounding_stop(cl_hw, cl_sta);
+	}
+}
+
+static u8 cl_bf_get_sts_he(struct ieee80211_sta *sta)
+{
+	u8 *phy_cap_info = sta->he_cap.he_cap_elem.phy_cap_info;
+
+	if (phy_cap_info[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G ||
+	    phy_cap_info[0] & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
+		return u8_get_bits(phy_cap_info[4],
+				   IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_ABOVE_80MHZ_MASK);
+	else
+		return u8_get_bits(phy_cap_info[4],
+				   IEEE80211_HE_PHY_CAP4_BEAMFORMEE_MAX_STS_UNDER_80MHZ_MASK);
+}
+
+static u8 cl_bf_get_sts_vht(struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+
+	return u32_get_bits(vht_cap->cap, IEEE80211_VHT_CAP_BEAMFORMEE_STS_MASK);
+}
+
+static u8 cl_bf_get_sts(struct ieee80211_sta *sta)
+{
+	if (sta->he_cap.has_he)
+		return cl_bf_get_sts_he(sta);
+
+	return cl_bf_get_sts_vht(sta);
+}
+
+void cl_bf_update_rate(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	/* Old & new BF state for main rate */
+	bool bf_on_old = bf_db->is_on;
+	bool bf_on_new = cl_bf_is_on(cl_hw, cl_sta, bf_db->num_ss);
+
+	/* Old & new BF state for fallback rate */
+	bool bf_on_old_fbk = bf_db->is_on_fallback;
+	bool bf_on_new_fbk = cl_bf_is_on(cl_hw, cl_sta, bf_db->num_ss_fallback);
+
+	if (bf_on_old != bf_on_new || bf_on_old_fbk != bf_on_new_fbk) {
+		/* BF state for main rate or fallback rate changed */
+
+		/* Save the new state */
+		bf_db->is_on = bf_on_new;
+		bf_db->is_on_fallback = bf_on_new_fbk;
+
+		/* Update the firmware */
+		if (cl_msg_tx_set_tx_bf(cl_hw, cl_sta->sta_idx, bf_on_new, bf_on_new_fbk))
+			pr_err("%s: failed to set TX-BF\n", __func__);
+	}
+}
+
+void cl_bf_sta_add(struct cl_hw *cl_hw, struct cl_sta *cl_sta, struct ieee80211_sta *sta)
+{
+	/* Beamformee capabilities */
+	bool su_beamformee_capable = cl_bf_is_beamformee_capable(cl_sta, false);
+	bool mu_beamformee_capable = cl_bf_is_beamformee_capable(cl_sta, true);
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	WARN_ON_ONCE(sta->rx_nss == 0);
+	bf_db->beamformee_sts = cl_bf_get_sts(sta);
+	bf_db->nc = min_t(u8, sta->rx_nss, WRS_SS_MAX) - 1;
+	cl_sta->su_sid = INVALID_SID;
+
+	bf_pr_trace(cl_hw,
+		    "sta_idx: %u, su_beamformee_capable: %u, mu_beamformee_capable: %u, "
+		    "beamformee_sts: %u, nc = %u\n",
+		    cl_sta->sta_idx, su_beamformee_capable, mu_beamformee_capable,
+		    bf_db->beamformee_sts, bf_db->nc);
+
+	if (bf_db->beamformee_sts == 0)
+		bf_db->beamformee_sts = 3;
+
+	/*
+	 * Init the BF timer
+	 * Period is set to 0. It will be updated before enabling it.
+	 */
+	timer_setup(&bf_db->timer, cl_bf_timer_callback, 0);
+}
+
+void cl_bf_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	/* Disable timer before removing the station */
+	del_timer_sync(&bf_db->timer);
+
+	/*
+	 * Remove the sounding sequence associated with the STA and possibly start another sequence
+	 * for other stations that participate in the same sounding sequence with the STA
+	 */
+	if (cl_sta->su_sid != INVALID_SID) {
+		bf_db->sounding_remove_required = true;
+		cl_sounding_stop_by_sid(cl_hw, cl_sta->su_sid, true);
+	}
+}
+
+void cl_bf_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta, bool active)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	if (bf_db->traffic_active != active) {
+		bf_pr_trace(cl_hw, "Sta: %u, Active: %s\n",
+			    cl_sta->sta_idx, active ? "True" : " False");
+
+		bf_db->traffic_active = active;
+		cl_bf_sounding_decision(cl_hw, cl_sta);
+	}
+}
+
+void cl_bf_reset_sounding_ind(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	cl_sta->bf_db.sounding_indications = 0;
+}
+
+bool cl_bf_is_enabled(struct cl_hw *cl_hw)
+{
+	return cl_hw->bf_db.enable;
+}
+
+bool cl_bf_is_on(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u8 nss)
+{
+	struct cl_bf_sta_db *bf_db = &cl_sta->bf_db;
+
+	return (cl_bf_is_enabled(cl_hw) &&
+		bf_db->sounding_start &&
+		bf_db->sounding_indications &&
+		(nss <= min(cl_hw->conf->ci_bf_max_nss, bf_db->nc)));
+}
+
+void cl_bf_sounding_req_success(struct cl_hw *cl_hw, struct cl_sounding_info *new_elem)
+{
+	/*
+	 * Start a timer to check that we are receiving indications from the station.
+	 * The period of the timer is set to 10 times the sounding-interval.
+	 */
+	u8 i;
+	struct cl_sta *cl_sta;
+	struct cl_bf_sta_db *bf_db;
+	unsigned long period = CL_SOUNDING_FACTOR * cl_sounding_get_interval(cl_hw);
+
+	for (i = 0; i < new_elem->sta_num; i++) {
+		cl_sta = new_elem->su_cl_sta_arr[i];
+		bf_db = &cl_sta->bf_db;
+
+		if (cl_sta) {
+			cl_sta->bf_db.sounding_start = true;
+			cl_sta->su_sid = new_elem->sounding_id;
+
+			/* Don't enable BF timer in case of force mode */
+			if (!cl_hw->bf_db.force)
+				mod_timer(&bf_db->timer, jiffies + msecs_to_jiffies(period));
+		}
+	}
+}
+
+void cl_bf_sounding_req_failure(struct cl_hw *cl_hw, struct cl_sounding_info *new_elem)
+{
+	u8 i;
+	struct cl_sta *cl_sta;
+	struct cl_bf_sta_db *bf_db;
+
+	for (i = 0; i < new_elem->sta_num; i++) {
+		cl_sta = new_elem->su_cl_sta_arr[i];
+
+		if (cl_sta) {
+			bf_db = &cl_sta->bf_db;
+			bf_db->sounding_start = false;
+			bf_db->sounding_indications = 0;
+		}
+	}
+}
+
+void cl_bf_init(struct cl_hw *cl_hw)
+{
+	cl_bf_enable(cl_hw, cl_hw->conf->ci_bf_en, false);
+}
+
-- 
2.36.1

