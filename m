Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A61532973
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236901AbiEXLkr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiEXLkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:40:42 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2008CB3D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:40:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKemsCIoxL8TQYhTXToEPxKIkm3j+Fa5XGWvq8opBKVL26ye1DBx7G6nNBW9A0y2wYZCp3HzX+zBWQa4q4if64BsrZ5YOxLgTf1FrBFUZDsiaI9DGa952vLPhZoMHqtJM7RgJmV6HsLYvLc2q1unS4pTnNpeSS625XbrIYg65uNPvajBCTr/irxMZMRLgwYaGaE5xJBdSbzxsttstorxX+UN2EBKJNy7H8Sddw5W71PRoFas7hTt1tWl6iexKOVzREB6L6K0Og69p23IAp+IcBBbVd8Pm7WCPzHNtlInk9x9rDf0ZscTWGNvlZlMZkouo1xATlY8326TwLiTTFDfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2U4qluKHCl0d8fU+sfaEKKogD0PPdx32kBb6Om9l5A=;
 b=KZ8FHL1zyv331G4ltV8bEn6oUrl3H28QQiCXjY6XFPPngKBPyQG3rnaSM9uu1r0bMFpzC0lyYyoZYzI31guOwT00D8qGCifG+NOi0If9TGmbP1aaDnBa0RkgeDT8cA9U7TXzpJeGAvdt/6jcm+I2lljqxNCSGar+qzgHclYCaxcyzpO3IfUcbz2zyZrLuKuLQxOvMgrhT7ipl/JbtGRin99JRtg3JHkgBkpDmKnzCROKuYvQugeBbS2emLbfHyswC5LQ5zx+0kvas7emuplaWUUEbZlvhRzcPXUfpN4QFU5onVvW+9SjddSIPm46vPNVwQASyF4vaaihNHWBf3el4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2U4qluKHCl0d8fU+sfaEKKogD0PPdx32kBb6Om9l5A=;
 b=bbVH+UljaXPEkquV+uLkxGdTE071sDoDhC3w6q/+SIAMqBf8P+6g9ExVtd5ZFm7Bvcvcml7MMWqWwR/7eOQvzYqW2D1jbsACR/YlFttHUYaPdXE64TJkgGb2HHlhym30uPq4/SJNeyOvyDJmZmEbaBrUn6E20DcvWuQC3rFo1Zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:31 +0000
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
Subject: [RFC v2 82/96] cl8k: add traffic.c
Date:   Tue, 24 May 2022 14:34:48 +0300
Message-Id: <20220524113502.1094459-83-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: c50ac4d9-d24a-4aae-486a-08da3d79fbd6
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669C9186F0A415DF7525466F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfxbRTIZdhrLb6oREwPeJBPcGhxDGN5xDf87JRqDa96ncgijlxcXMSM2eXUG5zaorwiX1/SvttJ+6hoSYLrIjppwwgiDWYNiMABVm2nyMuYPCJ4Ofn8Sc7XuCfYZCq230TYu1H5NGZ7lyi1xRxBOBIDgXnhrx3+4LPbKcQABiEjBlXA+QSOnmzEp4WhjAalwHY/WRWs7v/wJmUA4rrg8WhNp7KIQCQWkONpwFhyFuOanYTQ9umIdeAgBP9A9H1QGNbf6NyBiYrZHz2lLpDP8ZI/AIu5MGROz3Yyz8tI6pB45IVqmhMtgKShExRCmAw//3u6tI1FSUXJhxr3EETwulLH4dD+jd6IBTsNAYt5/pR9PUiXEMOtdOX6Zzc7uRrU62fkZLWtw2h49rWZa+0WaCMtk2KEICTSFR6X1lLY1Hnv93xBcjlNLTPFpDTqVtBivGYTd76jnfgiQOaEp6+ooHLDvQILKC2MVzJn3BXuhq0Dn232JoNZenMwTCbOLhNX/AiDLYMFXVOIU3wFL5NtRKsza6oFwgknrrGlWRGCtAIUBKygmwL496mcuNdtGRXuxhp3IEn5D0ubQcv88PbU5sfUG5HHFscHnyKK+eSwbxnmWA4n6BTp6IyDATY4AcKoHl0IpRCwAq3R7t6kJGudGtsCNK9wiS+gYjz/yh9ttzI6WSL1ee64AobFGb8C3ODONSdJTHbos5S1Bh9KQ10rzkV+EZLFrNKbJF7krBwAEAdU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kY7ZonhisMMBdklCfVZOFaT2sLmPFvh9utUasL1zWTrT/DS3xPzMDYX3jEh6?=
 =?us-ascii?Q?vfDMLItqKt9d4RzFrTR3kE0j5Z75HvUx7T3P+OdDzHIn1R/NHW/Vswso0MEM?=
 =?us-ascii?Q?mhNcdBwWRPu30QS/jkTnxFcg8TH7E63skkzhfWypEyz2hEaaQZSCzkXg0gav?=
 =?us-ascii?Q?PPfajMYAo/tE4n0mV2ypkDYvK8d3J63PIuhkg2z6M6UuOaUVtp+EtgZrg6Fy?=
 =?us-ascii?Q?/NipzvDPBOPuILOO5TDZvLzsq+T2+kBKoKnqSuhehEa2g7vfkn0Wj8MtpiKa?=
 =?us-ascii?Q?KpvYbWxmgwxxSlKoYyGk28VDahMEcCufNzohFKUy5ZZ9gNdJa1uGB7c6MA/2?=
 =?us-ascii?Q?/G7a1l6i8uc9USvcOhWwluhylInLir9l6jQFL5XNvl+PMkC5jmnl7kunfQKN?=
 =?us-ascii?Q?hqm0ZrjdgT7yvvjU+z0W4XlWYZMzFjz4I0vIyL6TYkWBdAH0wbGaG+Fwh494?=
 =?us-ascii?Q?V1DygnLSUb6v8bSNW7cf8PRJvnI2uKFFX9E2Vpzk3Y8Yuj80X7ot4kAO+SHR?=
 =?us-ascii?Q?9A4AjGgVl9KG+ycA20sdRIq5ueHnN9A7FS8FiNpZPKme1MOFTemzYAn6slBv?=
 =?us-ascii?Q?ixUvgyxKJBzLMkFQG3mOJmgwRurBjP+cfoM+I3ohGA3jce4puyZMQN93g9pJ?=
 =?us-ascii?Q?FTZxe0V58ecj87YULWcHs4p0GXnrOK03UShG8isRnhWfQs9maqsryFFgC4fC?=
 =?us-ascii?Q?SUdmOs3dMldhsl6c9GrhxeIDMjcUaGFARYT7KA6vmrVSLWKiXpZ78b59cqi7?=
 =?us-ascii?Q?CHf7Tpa44I8jVCQVC3BLI7vDyardonUTi8znsJ0RZDchoHkPtzYLaYpPdm+9?=
 =?us-ascii?Q?qSzyVCzkLcZ0VDs3v9iirPqlxvH4GG2Fow0FctNk1xAimeNiu9YDUYy4yAj6?=
 =?us-ascii?Q?vqgE5blscSD3CGofh/tS6QgedcIjZ4ImIUD5uNnMtNUwHq4rXW9+VT634VdW?=
 =?us-ascii?Q?jMR/5lD9gdDDMi8c4Tb6tM6UxSFv558DFjVlCR8nWl3JisuNu895Q2mAgZ4v?=
 =?us-ascii?Q?c9muT3EAlb2Vq+32GEDdXe2JUuUy1phyOdAsXO4+k//rOXWUKWZjnLegRVjd?=
 =?us-ascii?Q?zEXOyKx03/zq9R3pOeIWHpoN/sgPKDG8QkjKazeperLrwCuBTuqWE7jKFbNw?=
 =?us-ascii?Q?keu922y9nriZwH6UWD3OxKclStzfoBIZ4u4kystd9SJj1Ub1bjBNh/V8Lxlx?=
 =?us-ascii?Q?b+gVdWM4fn5+AFBR/x6Fdy78IGDPhgBcsiq8tJDmdS5H13x4ocE1DBpHrZWl?=
 =?us-ascii?Q?aXl4oRDo6vp3zWNLnDpdvPrduOV+h3XReIe/iQuuVGcUvIs0XaA7pOWqn1pT?=
 =?us-ascii?Q?IUZxcWs4DSN9daSFXash+gCwBIWlfzLi9a5KFX3HY2vceSDpIvZOOVZrPG0q?=
 =?us-ascii?Q?EofwnLziJTTnWlz+atluuA7rObUyWfG6iHcsM7BmxSqwCsmNE2rQ8Kopjw1E?=
 =?us-ascii?Q?1rLOxIIWP0mttYh5ZZffDVv0v591e+26C943oF2LFt03dV6TW84o0SBBxSPl?=
 =?us-ascii?Q?lnjaG8yiZwmkNxNDhX8JittHp9QcS6aPIO6DCH/QGz6WtWnCgHA3FLMxyoN3?=
 =?us-ascii?Q?VGuPjbCs6XFKTCTgMM8yl206hPw370MRL/cfOIAf7y7hP0N/EZfNJyniVfu/?=
 =?us-ascii?Q?o7l1b4kbDZ289iJ+mwpbKVQ2yTKXU1AMTltT/Pt0+2p4fYfnA372xl5EyENx?=
 =?us-ascii?Q?klGz8V+jjZpZ47QhvzpH408KD30Jf50lsbuPSMNRdJ1qcuo2mKHHGs3IvekV?=
 =?us-ascii?Q?BneaoGY8aFtAvSl6i68MDXvvKpgIkn4=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50ac4d9-d24a-4aae-486a-08da3d79fbd6
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:55.3682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7OW3UiAtuFEQyPaulxUUicuEnTG0XVPkQ0vnMPWRxAcn6nYYqTUrJ4aATbihgnC/Jyd74juDWoXH3vvWa7cgg==
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
 drivers/net/wireless/celeno/cl8k/traffic.c | 254 +++++++++++++++++++++
 1 file changed, 254 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/traffic.c

diff --git a/drivers/net/wireless/celeno/cl8k/traffic.c b/drivers/net/wireless/celeno/cl8k/traffic.c
new file mode 100644
index 000000000000..788fd02e28a8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/traffic.c
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/ip.h>
+#include <linux/ipv6.h>
+
+#include "bf.h"
+#include "tx.h"
+#include "radio.h"
+#include "utils.h"
+#include "debug.h"
+#include "hw.h"
+#include "traffic.h"
+
+#define TRAFFIC_CNTR_ACTIVE_THR     3       /* 3 * 100ms = 300ms */
+#define TRAFFIC_CNTR_IDLE_THR       20      /* 20 * 100ms = 2sec */
+
+/* Threshold in bytes */
+#define TRAFFIC_ACTIVE_THR_DRV      1920    /* = 150Kbit/sec (150 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_BF       26214   /* = 2mbit/sec (2 * 1024 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_MU       131070  /* = 10mbit/sec (10 * 1024 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_EDCA_6G  2621440 /* = 200mbit/sec (200 * 1024 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_EDCA_5G  2621440 /* = 200mbit/sec (200 * 1024 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_EDCA_24G 655360  /* = 50mbit/sec (50 * 1024 * 1024 / 8 / 10) */
+#define TRAFFIC_ACTIVE_THR_DFS      13107   /* = 1mbit/sec (1 * 1024 * 1024 / 8 / 10) */
+
+static void cl_traffic_mon_ipv4(struct sk_buff *skb, struct cl_sta *cl_sta,
+				enum cl_traffic_mon_direction direction)
+{
+	struct iphdr *iphdr = ip_hdr(skb);
+
+	if (iphdr->protocol == IPPROTO_UDP)
+		cl_sta->traffic_mon[CL_TRFC_MON_PROT_UDP][direction].bytes +=
+			ntohs(iphdr->tot_len) - IPV4_HDR_LEN(iphdr->ihl) - sizeof(struct udphdr);
+	else if (iphdr->protocol == IPPROTO_TCP)
+		cl_sta->traffic_mon[CL_TRFC_MON_PROT_TCP][direction].bytes +=
+			ntohs(iphdr->tot_len) - IPV4_HDR_LEN(iphdr->ihl) - sizeof(struct tcphdr);
+}
+
+static void cl_traffic_mon_ipv6(struct sk_buff *skb, struct cl_sta *cl_sta,
+				enum cl_traffic_mon_direction direction)
+{
+	struct ipv6hdr *ipv6hdr = ipv6_hdr(skb);
+
+	if (ipv6hdr->nexthdr == IPPROTO_UDP)
+		cl_sta->traffic_mon[CL_TRFC_MON_PROT_UDP][direction].bytes +=
+			ntohs(ipv6hdr->payload_len) - sizeof(struct udphdr);
+	else if (ipv6hdr->nexthdr == IPPROTO_TCP)
+		cl_sta->traffic_mon[CL_TRFC_MON_PROT_TCP][direction].bytes +=
+			ntohs(ipv6hdr->payload_len) - sizeof(struct tcphdr);
+}
+
+static void cl_traffic_mon_calc(struct sk_buff *skb, struct cl_sta *cl_sta,
+				enum cl_traffic_mon_direction direction)
+{
+	if (cl_set_network_header_if_proto(skb, ETH_P_IP))
+		cl_traffic_mon_ipv4(skb, cl_sta, direction);
+	else if (cl_set_network_header_if_proto(skb, ETH_P_IPV6))
+		cl_traffic_mon_ipv6(skb, cl_sta, direction);
+}
+
+void cl_traffic_mon_tx(struct cl_sta *cl_sta, struct sk_buff *skb)
+{
+	struct cl_hw *cl_hw = cl_sta->cl_vif->cl_hw;
+
+	if (cl_hw->conf->ci_traffic_mon_en)
+		cl_traffic_mon_calc(skb, cl_sta, CL_TRFC_MON_DIR_DL);
+}
+
+void cl_traffic_mon_rx(struct cl_sta *cl_sta, struct sk_buff *skb)
+{
+	struct cl_hw *cl_hw = cl_sta->cl_vif->cl_hw;
+
+	if (cl_hw->conf->ci_traffic_mon_en)
+		cl_traffic_mon_calc(skb, cl_sta, CL_TRFC_MON_DIR_UL);
+}
+
+void cl_traffic_mon_sta_maintenance(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	u8 i, j;
+
+	for (i = 0; i < CL_TRFC_MON_PROT_MAX; i++)
+		for (j = 0; j < CL_TRFC_MON_DIR_MAX; j++) {
+			cl_sta->traffic_mon[i][j].bytes_per_sec = cl_sta->traffic_mon[i][j].bytes;
+			cl_sta->traffic_mon[i][j].bytes = 0;
+		}
+}
+
+static void cl_traffic_sta_start(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				 enum cl_traffic_level level, enum cl_traffic_direction direction)
+{
+	cl_hw->traffic_db.num_active_sta_dir[direction][level]++;
+
+	/* If other direction is not active increase num_active_sta */
+	if (!cl_sta->traffic_db[1 - direction].activity_db[level].is_active)
+		cl_hw->traffic_db.num_active_sta[level]++;
+
+	if (level == TRAFFIC_LEVEL_DRV)	{
+		/*
+		 * Dynamic CTS:
+		 * If protection mode is disabled, environment is clean,
+		 * and station threshold was reached switch to CTS.
+		 */
+		if (cl_hw->traffic_db.num_active_sta[TRAFFIC_LEVEL_DRV] ==
+		     cl_hw->conf->ci_dyn_cts_sta_thr) {
+			if (cl_prot_mode_get(cl_hw) == TXL_NO_PROT) {
+				cl_hw->traffic_db.dynamic_cts = true;
+				cl_prot_mode_set(cl_hw, TXL_PROT_CTS);
+			}
+		}
+	} else if (level == TRAFFIC_LEVEL_BF) {
+		if (direction == TRAFFIC_DIRECTION_TX)
+			cl_bf_sta_active(cl_hw, cl_sta, true);
+	}
+}
+
+static void cl_traffic_sta_stop(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				enum cl_traffic_level level, enum cl_traffic_direction direction)
+{
+	cl_hw->traffic_db.num_active_sta_dir[direction][level]--;
+
+	/* If other direction is not active decrease num_active_sta */
+	if (!cl_sta->traffic_db[1 - direction].activity_db[level].is_active)
+		cl_hw->traffic_db.num_active_sta[level]--;
+
+	if (level == TRAFFIC_LEVEL_DRV) {
+		/* Dynamic CTS:
+		 * If it was turned on and active station count became lower than
+		 * threshold --> return to no protection
+		 */
+		if (cl_hw->traffic_db.dynamic_cts) {
+			if (cl_hw->traffic_db.num_active_sta[TRAFFIC_LEVEL_DRV] ==
+			    (cl_hw->conf->ci_dyn_cts_sta_thr - 1)) {
+				cl_hw->traffic_db.dynamic_cts = false;
+				cl_prot_mode_set(cl_hw, TXL_NO_PROT);
+			}
+		}
+	} else if (level == TRAFFIC_LEVEL_BF) {
+		if (direction == TRAFFIC_DIRECTION_TX)
+			cl_bf_sta_active(cl_hw, cl_sta, false);
+	}
+}
+
+static void cl_traffic_check_activity(struct cl_hw *cl_hw, struct cl_sta *cl_sta,
+				      enum cl_traffic_level level,
+				      enum cl_traffic_direction direction)
+{
+	struct cl_traffic_activity *activity_db =
+		&cl_sta->traffic_db[direction].activity_db[level];
+	u32 num_bytes = cl_sta->traffic_db[direction].num_bytes;
+
+	if (num_bytes > cl_hw->traffic_db.active_bytes_thr[level]) {
+		activity_db->cntr_active++;
+		activity_db->cntr_idle = 0;
+
+		/* If traffic is above threshold for X consective times change state to active */
+		if (!activity_db->is_active &&
+		    activity_db->cntr_active >= TRAFFIC_CNTR_ACTIVE_THR) {
+			activity_db->is_active = true;
+			cl_traffic_sta_start(cl_hw, cl_sta, level, direction);
+		}
+	} else {
+		activity_db->cntr_active = 0;
+		activity_db->cntr_idle++;
+
+		/* If traffic is below threshold for Y consective times change state to idle */
+		if (activity_db->is_active && activity_db->cntr_idle >= TRAFFIC_CNTR_IDLE_THR) {
+			activity_db->is_active = false;
+			cl_traffic_sta_stop(cl_hw, cl_sta, level, direction);
+		}
+	}
+}
+
+static void cl_traffic_monitor_sta_traffic(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	enum cl_traffic_level level = 0;
+
+	/* Check Tx & Rx activity in all levels */
+	for (level = 0; level < TRAFFIC_LEVEL_MAX; level++) {
+		cl_traffic_check_activity(cl_hw, cl_sta, level, TRAFFIC_DIRECTION_TX);
+		cl_traffic_check_activity(cl_hw, cl_sta, level, TRAFFIC_DIRECTION_RX);
+	}
+
+	/* Save previous Tx num bytes */
+	cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes_prev =
+		cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes;
+
+	/* Reset num_bytes */
+	cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes = 0;
+	cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].num_bytes = 0;
+}
+
+void cl_traffic_init(struct cl_hw *cl_hw)
+{
+	struct cl_traffic_main *traffic_db = &cl_hw->traffic_db;
+
+	traffic_db->active_bytes_thr[TRAFFIC_LEVEL_DRV] = TRAFFIC_ACTIVE_THR_DRV;
+	traffic_db->active_bytes_thr[TRAFFIC_LEVEL_BF] = TRAFFIC_ACTIVE_THR_BF;
+	traffic_db->active_bytes_thr[TRAFFIC_LEVEL_MU] = TRAFFIC_ACTIVE_THR_MU;
+
+	if (cl_band_is_6g(cl_hw))
+		traffic_db->active_bytes_thr[TRAFFIC_LEVEL_EDCA] = TRAFFIC_ACTIVE_THR_EDCA_6G;
+	else if (cl_band_is_5g(cl_hw))
+		traffic_db->active_bytes_thr[TRAFFIC_LEVEL_EDCA] = TRAFFIC_ACTIVE_THR_EDCA_5G;
+	else
+		traffic_db->active_bytes_thr[TRAFFIC_LEVEL_EDCA] = TRAFFIC_ACTIVE_THR_EDCA_24G;
+
+	traffic_db->active_bytes_thr[TRAFFIC_LEVEL_DFS] = TRAFFIC_ACTIVE_THR_DFS;
+}
+
+void cl_traffic_tx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32 num_bytes)
+{
+	cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes += num_bytes;
+	cl_sta->tx_bytes += num_bytes;
+}
+
+void cl_traffic_rx_handler(struct cl_hw *cl_hw, struct cl_sta *cl_sta, u32 num_bytes)
+{
+	cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].num_bytes += num_bytes;
+	cl_sta->rx_bytes += num_bytes;
+}
+
+void cl_traffic_maintenance(struct cl_hw *cl_hw)
+{
+	cl_sta_loop(cl_hw, cl_traffic_monitor_sta_traffic);
+}
+
+void cl_traffic_sta_remove(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	/* Check if station disconnected during traffic */
+	enum cl_traffic_level level = 0;
+	enum cl_traffic_direction direction = 0;
+
+	for (direction = 0; direction < TRAFFIC_DIRECTION_MAX; direction++) {
+		for (level = 0; level < TRAFFIC_LEVEL_MAX; level++) {
+			if (cl_sta->traffic_db[direction].activity_db[level].is_active)
+				cl_traffic_sta_stop(cl_hw, cl_sta, level, direction);
+		}
+
+		memset(&cl_sta->traffic_db, 0, sizeof(cl_sta->traffic_db));
+	}
+}
+
+bool cl_traffic_is_sta_active(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	return (cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].activity_db[TRAFFIC_LEVEL_DRV].is_active ||
+		cl_sta->traffic_db[TRAFFIC_DIRECTION_RX].activity_db[TRAFFIC_LEVEL_DRV].is_active);
+}
+
+bool cl_traffic_is_sta_tx_exist(struct cl_hw *cl_hw, struct cl_sta *cl_sta)
+{
+	return ((cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes != 0) ||
+		(cl_sta->traffic_db[TRAFFIC_DIRECTION_TX].num_bytes_prev != 0));
+}
-- 
2.36.1

