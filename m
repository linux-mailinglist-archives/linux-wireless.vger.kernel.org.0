Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6AE53298E
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiEXLlX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237022AbiEXLlI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:41:08 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50088.outbound.protection.outlook.com [40.107.5.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27223939ED
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OposxdHX6iXMzQtqc4LyunGqTy7GlVmUVdfVSRKB2J+qXQ/6yF4X8fUCQKZGCDql9mcRR/5k+VgtkNqKbzTi0WcBU66cqO+lvSOxNoHdrVCBrD4NwPXT4YvTxk8qh5/AHq6mzrxdKdTDL7CcoWu1EfY41fvNnS9vnwSMFT4tsovBHc1OYA0TS6SrVOTHndo7trdWihGasE3I4j11XplpZ7A6iR+rPd/wgArjlhc4vGBOdUAG+M0mVRtT12utcZqOYCa5QtqkaciISXhozf3XqDr0QTPw3aXdM/ry6jW8lAcFSZQa26PIvo2LOpjoaZIEFFqun8rVNo1z54WfJWccrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdvy+fmVaRleE850ad4Twf1GMSPGF8g1EV1GqhxKpOk=;
 b=kg4RWjAj5fb5AjkS3xUiw8QL3YwGyfLVUJPXn60PhFkkXSljYl+7R51Uq5Nakk0SBxEwDLk1D8gd3231JBr03/c1ulD4477QtS8/FuFbGo1xIVR86qYmLUv49bBRJ6yqn82cETUEBOQILCDRnJ130L28ChRRzEtXx6PATm+oV+8gnZV99CFHbQgMOkEFJZlZPSpIyo1DaJfWMqyn/Y3a0sf+uqIvVUY/m+mP4Nj317//XESQ3BMEyPvCIvk3v7CmBdvM7PWOzSrwXA7fm64J7fYJneFPZl8J3yyp2Uy++BwCn1gQ6NwRnWVBh0KaDWAHfO14LSSU/RKEocH7IyXd6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdvy+fmVaRleE850ad4Twf1GMSPGF8g1EV1GqhxKpOk=;
 b=jX7dPnNM0nbrnkOCf4eRW++RUkWpwFOzhbu8DStzKIo1YmfkDAHin6gTBUENPKA046iHlAWNR5qX/MEwoYLjT1/EIbImkbUdeJmMplHpPYenCFUNw3FkOmV7rj3512ynH7uTJB1LfonkVqLxUNN5UxFDKCo72SPUkBfqzUqVbVY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by DU0P192MB1571.EURP192.PROD.OUTLOOK.COM (2603:10a6:10:34c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Tue, 24 May
 2022 11:39:24 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:24 +0000
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
Subject: [RFC v2 62/96] cl8k: add regdom.c
Date:   Tue, 24 May 2022 14:34:28 +0300
Message-Id: <20220524113502.1094459-63-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c93e2ce-b602-4d90-dd03-08da3d79f212
X-MS-TrafficTypeDiagnostic: DU0P192MB1571:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <DU0P192MB157138C8C63BBD14AB5B1A6EF6D79@DU0P192MB1571.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +iiI+cts60/sVPiTjDDyBxaRC+7Mlb/j9nqO0U6E2OmvrRIzZGOsvFw0FS6epTKkic1Y+IIX+yyH/Fo4VExkaSO+8iCezFBwBYzWqlshC6DqCGnVlNd/3+FmuGE9MDDXaCe7EZT5PNtg74PKqbDP5B23KuY+8b6sutBcvfPjgArpPv97n8/2lIUsh2SRBJl/4K3n6DFXzSFpAimJqgusNatA19jLaeK8Zy2YWd1t+JDQSuNz8lsdU7SSCHLzHj+xafOP15gMvvqDrVGmmd6ElvFxr67jvMHeKtOOcrHxe8ZhVkHa5KT9piNimI6YJPDYR2Jcq1rNLiuh/+CG6bVP+qJzq7VcVjUJxlGQnabpkbTYo84Nce8/doUcIBi9F6oJElPAjqsVA9UesmWeP6JmWSYOuVbkiSiv55Xw1TcyV6iRRT+HUgMQ7pm9QXzYAyNBcj+ehiut+UU5sAX3ZxS0/pt3DlSobrdYDEkdGgwbhZEQ326DwZ5GObH7KPf0HkXr0+VBK23ljueiTX4DlyqX3HQmqTK9ukd1Y0bmH3mZRrIIT3pgFTC7p4ouCi+1FHwm0Kh5+1MVUfKf6cwEkkXPxV/OhASRwj1bLNJZR/fcZAshx8Cs2DJv/74omWX0t4oDE/r8rq2qykPzTzNzAOwUO8s5Wknp4dHPJI+af+abhROv6Vry13IfSKiJkdkq1A5gu0Ycot7h4IQ5kAKLJL2ipzACJ7i49fl+okwKYM3XpCE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(39850400004)(346002)(396003)(376002)(6512007)(186003)(6916009)(9686003)(38350700002)(38100700002)(41300700001)(36756003)(316002)(54906003)(2616005)(1076003)(86362001)(107886003)(8676002)(66476007)(4326008)(66556008)(66946007)(52116002)(8936002)(6506007)(2906002)(83380400001)(508600001)(5660300002)(6486002)(26005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJ09zz5jpBXIv9eS28G63EIFRCy6/dL+oqrmKwjqdoRPKArl0LQfI+RFFJV+?=
 =?us-ascii?Q?25QZz9usMDT7LqFSU0Lds34BgN5pbOru3VgO2eUkCn7i5PHWChUVt3xqpgd5?=
 =?us-ascii?Q?iosNjpmz8Ihbgl4XqYQry2k3xQckLFAkjxa3hHGpBLWKGw2xh0s6ZpqCzFFk?=
 =?us-ascii?Q?F4XdL4hHodyeI4knynKQjSJLy7ATpeYC40UsmeQPMHv+jVKdD1lTNdLJ1U/t?=
 =?us-ascii?Q?AoGRS/otbECMMOuxVVsjeryw9IEx3HmNggB2tZ0ocyCKK1EEFBm4ZB87P1pE?=
 =?us-ascii?Q?TZGJE18XQt0s0m3XpVT7mFzLVRQIp+ih7j7lsrE38Y08EFHUexDjIQp6LYpF?=
 =?us-ascii?Q?S8xs7Z2pKjw4hjKIKVqtsYzUY84Y2y0eF6JOw1IHam6Y1LCV5PBMhxFAjVKN?=
 =?us-ascii?Q?qw5MpEO0i6BSu5WWmqgcmSpZ17Pjx0vMGBem1o3fZwID7wdmxtca+Z/S+ZoQ?=
 =?us-ascii?Q?vGop9Cip/HTSwWsThwCWRReldZXHCFwlFPoyUtq45cZM0n5A7XoqLh+YJjdx?=
 =?us-ascii?Q?zrc+0XE1bXJspaWocaeixv8qUDav2/ZRXUlCPSuKhYbKEcfVE8B3p+sFpRFO?=
 =?us-ascii?Q?YNdzILW3CLgRCpv2rFJWgUwJmupdBpsb7mllmBxypgjYvdS+4Fkvxq1c4VPC?=
 =?us-ascii?Q?j0+wC275w5+d2YTMovXKVqH8IKC5dhqNoUBUM9P0Reyd+TgTZ+ODstOiQz46?=
 =?us-ascii?Q?DiJwelzlPMTKyDc8UOtbzraZKo37XlvYJgu2ez1h7KaYRpMUia9vxkLASuug?=
 =?us-ascii?Q?TivXsCKxNm4GU8g9chkMOCy4IkKkbE5K1hMs+nReNuM0z8XY8ElyytW8rm0t?=
 =?us-ascii?Q?Toz9r2eSCR9hgcevuR5qRQnLaemyTCy3FVWEgqvXv3Z8lc9s2NJpXnWThqQj?=
 =?us-ascii?Q?owoozl0KC35BJFWozfZ/Yq8GVudyGuNlqqAY/Fp8ToEp4T3qJAUEeVvwU6sc?=
 =?us-ascii?Q?ms6il2AMPjw+MmlW2JM7REbQKadFc/6du2+FWOvr8xp9/7E3yPJt0nOL2Ezj?=
 =?us-ascii?Q?gX9GWme8DhP5yAuWEkb+BxetYcs+dC5WkYMVQ5/sxIaBzuSRzCgOzcuBQqry?=
 =?us-ascii?Q?5V/k6U63x+R9+bmkdukcuKytXVFbYu6jlnGHFHBmDZiQZypAtptnrOK44/PZ?=
 =?us-ascii?Q?zqZ31ZxUQPkUhpfw+o+6+SKUeQj1dd59q8AhdjkNM3b+zbYtYrZkRWuTcOY6?=
 =?us-ascii?Q?YSYhNhh295eqoWLVfM90PgPtvEj7vK7jBfsM+Q2lSWbxj1f4tPCo0jpRZosH?=
 =?us-ascii?Q?stgI07/pqZUoLU894/TMXknxci+aC28X2JBFpnqJmFAtftNbxmCH1lNcC7L4?=
 =?us-ascii?Q?fMl8CFwYwandYztyt4VWpH4iDltjMxQW87orzamjXS87ssJF4esydZJ2+p2b?=
 =?us-ascii?Q?2LMdreYcriIkCnsQdq4A8Nl1d7Lu4UnEryYoBBkoo0Q5zQYHqFVn8HDmu7qB?=
 =?us-ascii?Q?iNpBB74CKraPHhA+FyidwMa7y51SUmELzNSRq6MoWWDSyPYWZxV+2YkJWnJb?=
 =?us-ascii?Q?AG2h7g1NGqDJIAePK8fRgoEzWbxcr/iKBvYAWTEPtuoSgqCsRuXcMmwrMBPD?=
 =?us-ascii?Q?/vbzJ3IFY0MZNEL0rkPM3T4OYhHhQZUpnUD/Vps0UQgdOApQQ7uY2/VSRK7O?=
 =?us-ascii?Q?BFQVqhy4242gSoyqtPkbtxSYyiX/ThRp6YztpgT70mwKQbAKUnKDe7R7Fslc?=
 =?us-ascii?Q?Jt69/a1Bdn9/fk8Nk2mNldVTS8hjaQb75eAqmTALFKeBXtWuXQ7eNMG8tJbm?=
 =?us-ascii?Q?ShWxA5Mx/imRvS2TFcNxUojbSWwGYFY=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c93e2ce-b602-4d90-dd03-08da3d79f212
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:38.9556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hg8uLvWEQ7OGBAGtpis58JQEIfReZ+4liALeWSEJf+g2iLRPi5OmTT/26r7KCPcKzea9v3JaI1fB/KUu+Hj8iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P192MB1571
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
 drivers/net/wireless/celeno/cl8k/regdom.c | 301 ++++++++++++++++++++++
 1 file changed, 301 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/regdom.c

diff --git a/drivers/net/wireless/celeno/cl8k/regdom.c b/drivers/net/wireless/celeno/cl8k/regdom.c
new file mode 100644
index 000000000000..1b9d33a33d98
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/regdom.c
@@ -0,0 +1,301 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include "chip.h"
+#include "dfs.h"
+#include "core.h"
+#include "debug.h"
+#include "hw.h"
+#include "utils.h"
+#include "regdom.h"
+
+static struct ieee80211_regdomain cl_regdom_24g = {
+	.n_reg_rules = 2,
+	.alpha2 = "99",
+	.reg_rules = {
+		REG_RULE(2412 - 10, 2472 + 10, 40, 6, 20, 0),
+		REG_RULE(2484 - 10, 2484 + 10, 20, 6, 20, 0),
+	}
+};
+
+static struct ieee80211_regdomain cl_regdom_5g = {
+	.n_reg_rules = 1,
+	.alpha2 = "99",
+	.reg_rules = {
+		REG_RULE(5150 - 10, 5850 + 10, 80, 6, 30, 0),
+	}
+};
+
+static struct ieee80211_regdomain cl_regdom_6g = {
+	.n_reg_rules = 1,
+	.alpha2 = "99",
+	.reg_rules = {
+		REG_RULE(5935 - 10, 7115 + 10, 80, 6, 30, 0),
+	}
+};
+
+static int cl_regd_is_legal_bw(int freq_diff)
+{
+	int bw = 0;
+
+	for (bw = CHNL_BW_20; bw < CHNL_BW_MAX; bw++)
+		if (freq_diff == BW_TO_KHZ(bw))
+			return bw;
+
+	return -EINVAL;
+}
+
+static int cl_regd_domain_update_rule(struct cl_hw *cl_hw, struct ieee80211_regdomain *rd,
+				      int freq, int power, u8 max_bw, u32 flags, u32 dfs_cac_ms)
+{
+	struct ieee80211_reg_rule *reg_rule = &rd->reg_rules[rd->n_reg_rules - 1];
+	struct ieee80211_power_rule *power_rule = &reg_rule->power_rule;
+	int bw, diff;
+
+	reg_rule->freq_range.end_freq_khz = MHZ_TO_KHZ(freq + 10);
+	if (power_rule->max_eirp < DBM_TO_MBM(power))
+		power_rule->max_eirp = DBM_TO_MBM(power);
+
+	diff = reg_rule->freq_range.end_freq_khz - reg_rule->freq_range.start_freq_khz;
+	/* if freq diff is equal to legal BW then update max_bandwidth_khz */
+	bw = cl_regd_is_legal_bw(diff);
+	if (bw >= 0)
+		reg_rule->freq_range.max_bandwidth_khz = BW_TO_KHZ(min((u8)bw, max_bw));
+
+	reg_rule->flags |= flags;
+	reg_rule->dfs_cac_ms = max_t(u32, reg_rule->dfs_cac_ms, dfs_cac_ms);
+
+	return diff;
+}
+
+/*
+ * Add first rule with minimal BW and increase then in cl_regd_domain_update_rule
+ * if new freq range will added
+ */
+static void cl_regd_domain_add_rule(struct cl_hw *cl_hw, struct ieee80211_regdomain *rd,
+				    int freq, int max_power, u8 min_bw, u32 flags, u32 dfs_cac_ms)
+{
+	struct ieee80211_reg_rule *reg_rule = &rd->reg_rules[rd->n_reg_rules];
+	struct ieee80211_freq_range *freq_range = &reg_rule->freq_range;
+	struct ieee80211_power_rule *power_rule = &reg_rule->power_rule;
+
+	freq_range->start_freq_khz = MHZ_TO_KHZ(freq - 10);
+	freq_range->end_freq_khz = MHZ_TO_KHZ(freq + 10);
+	freq_range->max_bandwidth_khz = BW_TO_KHZ(min_bw);
+
+	power_rule->max_eirp = DBM_TO_MBM(max_power);
+	power_rule->max_antenna_gain = DBI_TO_MBI(3);
+
+	reg_rule->flags |= flags;
+	reg_rule->dfs_cac_ms = dfs_cac_ms;
+
+	rd->n_reg_rules++;
+}
+
+static u32 cl_regd_map_reg_flags(u32 reg_flags)
+{
+	u32 flags = 0;
+
+	if (reg_flags & IEEE80211_CHAN_NO_IR)
+		flags = NL80211_RRF_NO_IR;
+
+	if (reg_flags & IEEE80211_CHAN_RADAR)
+		flags |= NL80211_RRF_DFS;
+
+	if (reg_flags & IEEE80211_CHAN_NO_OFDM)
+		flags |= NL80211_RRF_NO_OFDM;
+
+	if (reg_flags & IEEE80211_CHAN_INDOOR_ONLY)
+		flags |= NL80211_RRF_NO_OUTDOOR;
+
+	if (reg_flags & (IEEE80211_CHAN_NO_HT40PLUS | IEEE80211_CHAN_NO_HT40MINUS))
+		flags |= NL80211_RRF_NO_HT40;
+
+	if (reg_flags & IEEE80211_CHAN_NO_80MHZ)
+		flags |= NL80211_RRF_NO_80MHZ;
+
+	if (reg_flags & IEEE80211_CHAN_NO_160MHZ)
+		flags |= NL80211_RRF_NO_160MHZ;
+
+	return flags;
+}
+
+void cl_regd_set(struct cl_hw *cl_hw, struct ieee80211_regdomain *rd,
+		 struct regulatory_request *request)
+{
+	int j = 0;
+	int power = 0, prev_power = 0;
+	u8 bw = 0, prev_bw = 0;
+	int freq = 0, prev_freq = 0;
+	u8 chan = 0;
+	u32 flags = 0, prev_flags = 0;
+	u32 dfs_cac_ms = 0;
+
+	spin_lock_bh(&cl_hw->channel_info_lock);
+
+	memset(rd, 0, sizeof(*rd) + NL80211_MAX_SUPP_REG_RULES * sizeof(struct ieee80211_reg_rule));
+	memcpy(rd->alpha2, request->alpha2, 2);
+
+	rd->dfs_region = request->dfs_region;
+
+	if (request->dfs_region == NL80211_DFS_FCC)
+		cl_hw->channel_info.standard = NL80211_DFS_FCC;
+	else if (request->dfs_region == NL80211_DFS_ETSI)
+		cl_hw->channel_info.standard = NL80211_DFS_ETSI;
+	else
+		cl_hw->channel_info.standard = NL80211_DFS_UNSET;
+
+	for (j = 0; j < cl_channel_num(cl_hw); j++) {
+		struct cl_chan_info *chan_info = &cl_hw->channel_info.channels[CHNL_BW_20][j];
+
+		chan = chan_info->channel;
+		if (!chan)
+			continue;
+
+		/* Translate from country_power (.25dBm) to max_power (1dBm) */
+		power = cl_hw->channel_info.channels[CHNL_BW_20][j].country_max_power_q2 >> 2;
+		bw = cl_chan_info_get_max_bw(cl_hw, chan);
+		freq = ieee80211_channel_to_frequency(chan, cl_hw->nl_band);
+		flags = cl_regd_map_reg_flags(chan_info->flags);
+		dfs_cac_ms = chan_info->dfs_cac_ms;
+		if (freq - prev_freq > 20 || prev_power != power || prev_bw != bw ||
+		    prev_flags != flags)
+			cl_regd_domain_add_rule(cl_hw, rd, freq, power,
+						CHNL_BW_20, flags, dfs_cac_ms);
+		else
+			cl_regd_domain_update_rule(cl_hw, rd, freq, power, bw, flags, dfs_cac_ms);
+
+		prev_freq = freq;
+		prev_power = power;
+		prev_bw = bw;
+		prev_flags = flags;
+	}
+
+	spin_unlock_bh(&cl_hw->channel_info_lock);
+}
+
+static void cl_regd_update_channels(struct cl_hw *cl_hw, struct wiphy *wiphy)
+{
+	enum nl80211_band band;
+	const struct ieee80211_supported_band *cfg_band = NULL;
+
+	for (band = 0; band < NUM_NL80211_BANDS; band++) {
+		if (band != cl_hw->nl_band)
+			continue;
+
+		cfg_band = wiphy->bands[band];
+		if (!cfg_band)
+			continue;
+
+		cl_chan_update_channels_info(cl_hw, cfg_band);
+	}
+}
+
+static void cl_regd_set_by_user(struct cl_hw *cl_hw, struct wiphy *wiphy,
+				struct regulatory_request *request)
+{
+	if (!cl_hw->channel_info.use_channel_info)
+		return;
+
+	cl_regd_update_channels(cl_hw, wiphy);
+	/*
+	 * Here is updated cl_hw->channel_info,
+	 * let's generates new regdom rules into cl_hw->channel_info.rd
+	 */
+	cl_regd_set(cl_hw, cl_hw->channel_info.rd, request);
+	if (cl_band_is_5g(cl_hw))
+		cl_dfs_reinit(cl_hw);
+	/* TODO: calib callback for channels update */
+}
+
+static bool cl_regd_dyn_mode_enabled(struct cl_hw *cl_hw)
+{
+	return !strcmp(cl_hw->chip->conf->ci_regdom_mode, "auto");
+}
+
+static void cl_regd_notifier_apply(struct cl_hw *cl_hw,
+				   struct wiphy *wiphy,
+				   struct regulatory_request *request)
+{
+	if (!request)
+		return;
+
+	switch (request->initiator) {
+	case NL80211_REGDOM_SET_BY_CORE:
+		break;
+	case NL80211_REGDOM_SET_BY_DRIVER:
+		break;
+	case NL80211_REGDOM_SET_BY_USER:
+		if (cl_regd_dyn_mode_enabled(cl_hw))
+			cl_regd_set_by_user(cl_hw, wiphy, request);
+		break;
+	case NL80211_REGDOM_SET_BY_COUNTRY_IE:
+		break;
+	default:
+		break;
+	}
+}
+
+static void cl_regd_notifier(struct wiphy *wiphy,
+			     struct regulatory_request *request)
+{
+	struct ieee80211_hw *hw = wiphy_to_ieee80211_hw(wiphy);
+
+	cl_regd_notifier_apply(hw->priv, wiphy, request);
+}
+
+static int _cl_regd_init(struct cl_hw *cl_hw, struct wiphy *wiphy,
+			 void (*reg_notifier)(struct wiphy *wiphy,
+					      struct regulatory_request *request))
+{
+	if (cl_regd_dyn_mode_enabled(cl_hw)) {
+		const struct ieee80211_regdomain *regd = cl_hw->channel_info.rd;
+
+		wiphy->reg_notifier = reg_notifier;
+		wiphy->regulatory_flags |= REGULATORY_CUSTOM_REG |
+					   REGULATORY_DISABLE_BEACON_HINTS |
+					   REGULATORY_COUNTRY_IE_IGNORE;
+
+		wiphy_apply_custom_regulatory(wiphy, regd);
+
+		return 0;
+	}
+
+	/* default is self managed mode */
+	wiphy->regulatory_flags |= REGULATORY_WIPHY_SELF_MANAGED;
+
+	return regulatory_set_wiphy_regd(wiphy, cl_hw->channel_info.rd);
+}
+
+int cl_regd_init(struct cl_hw *cl_hw, struct wiphy *wiphy)
+{
+	if (cl_hw->channel_info.use_channel_info) {
+		cl_hw->channel_info.rd = kzalloc(sizeof(*cl_hw->channel_info.rd) +
+						 NL80211_MAX_SUPP_REG_RULES *
+						 sizeof(struct ieee80211_reg_rule),
+						 GFP_KERNEL);
+		if (!cl_hw->channel_info.rd) {
+			cl_dbg_err(cl_hw, "memory allocation failed!\n");
+			return -ENOMEM;
+		}
+
+		struct regulatory_request request = {
+			.alpha2[0]  = cl_hw->chip->conf->ci_country_code[0],
+			.alpha2[1]  = cl_hw->chip->conf->ci_country_code[1],
+			.alpha2[2]  = 0,
+			.dfs_region = cl_hw->channel_info.standard,
+		};
+
+		cl_regd_set(cl_hw, cl_hw->channel_info.rd, &request);
+	} else {
+		if (cl_band_is_6g(cl_hw))
+			cl_hw->channel_info.rd = &cl_regdom_6g;
+		else if (cl_band_is_5g(cl_hw))
+			cl_hw->channel_info.rd = &cl_regdom_5g;
+		else
+			cl_hw->channel_info.rd = &cl_regdom_24g;
+	}
+
+	return _cl_regd_init(cl_hw, wiphy, cl_regd_notifier);
+}
+
-- 
2.36.1

