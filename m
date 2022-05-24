Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89360532945
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiEXLib (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiEXLiY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:24 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D0943382
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlhZbCQidTg2Gv9SlfndBBW6UoGqQMVlfjitFtevR1O4bmb6yZMKN2OYt9oUG4kxByMlVjTjbnKmT88MsFhnEgJB2q8QZI1H0kDsj1dzOPXfRRQa3iG3RbUU9jShkHuM9tmuDqxj8rIAXDzW8TTz802Vl9rMkrvA0imy7HVANdtaazmkXaXRlCaHJ2/c684lXQEDiacMxjbRcqawAFa7SHGrrHF8ang8fjJ1XEhpksv+OoKFj8OpTdXeYCN5w3w3O5mNBzxY5r5rK84izsvZmGIBTpl9sCMOJXRI4K4Djuct+lkLbePAyWsVK5FboasJR4LqUO06CVBvNCbSIYNLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c3gmp2I8EFIRQV6cQXkdIAEWEsx6BvYYfAHOsMuDkDM=;
 b=LVjRBdWj/OrS/UjOH3jYKMu2uyEYe+wdMiRXrygqHZrgzV2oed5GVhrSRGUjSD9rm0byLQ55fGoXh0brSMGsa7mucr5LY04PdG1W26PyjvG3BoULNkAWdeby35RwEmqqN59oRgG9h53K/DR4uwqV2mOSYfVU7gFmx58Ib1VKTRD+LMTElpcqBkOOpSJeApnApEh2cOORPXyfT+L4jSk6zE9H91uqXyTFaTaI5PFRjXzXoW7bstYF0pWQ0DkSza4+W0sVJKTK7En530l4Ti0cWYl8Td0NQ456v7LPlxcmrd+nBcTKcC3CW0lPMKVxIaYn9S91XJVw/HsZ6m9BS7kFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c3gmp2I8EFIRQV6cQXkdIAEWEsx6BvYYfAHOsMuDkDM=;
 b=sAcNIFLFfy4638abCIHd/i4G0hJsG33wZceYT9P9WXKusarMVxbLCOkDsknynGtpcCphV9b6SliaQlnMICZqqBrxxEuRTLBXzW1g9ZvQZqnOd0218MSVzGXELnUsZ6aHSZhwUatCtM0SYi/lgSCfD7uygZzoJsXXeCNZmEhXEzo=
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
Subject: [RFC v2 21/96] cl8k: add dfs.h
Date:   Tue, 24 May 2022 14:33:47 +0300
Message-Id: <20220524113502.1094459-22-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: d6d5ea6e-b5fd-43aa-f066-08da3d79da18
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469CA0128C507CD66701120F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S+5jgv8TJtncifOpmdgvLXj6fLeXU1wPD7O1zb1cR4Ka8tLX5zUyso6RyPmv/Q/4eHjJTz3vKMWrYtffAFct8Try1nEtAy2YABYyfnbcm0TtcfnpD0lbyKa1qgKpayXZ986T34iNFLlI601wce749ISMK4bAdnorHf6zD+//0qvaHK95KAKnU4FxaD11wsO/ENf/ywFsH3D9S7DWpAA6wbRyukm9IK7t6HzQ6qpiaKStAD2GMyliS5GUsynJDxCUupbdlL1azZ8IlH3dHngrgVfcLaXAOgE03IznUOSFzl7Nsi09RBzqK8ZjZP8OPRqNfuWKzCCjdi9hkeHb2eJVTiFBDpPeHTN0hEtMGOOhqK40BPpZh0FeXs/3GRPnM6IuLCr2pYyTqqy2p3OpnBT9PD6+vYx/NBQzrhSXUNTTMHzYmWTsIe0soCjRcttF60Lny1vQTzTjrcz2hJHPUoX0RLesc2dpeHRI/3q6mUlALgBkZ3F4/NsmmHmvv13hTwagEsbQ8ecrtzFxagpeJ7GgsIjzC6JUTGZTDVI9rTumHO6H3aS1ba39tpHjUh5C1PDVvpuBtc+ClPXp/LKrpKXek6bx69FqsaQV0rsRd5zKRjUPFdZ3Dx6iVnHAXLVoEf3TpxNWuoqFLvPfdZyGvq/19yap+8oPpWqQnrYynrUMLQ2chvUgFs/G8K8MZbm8QuJWR02VvkLHRKRyHxyzr2xHPHpdp6oLJKUevqs6E7Ob3UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQCckivdpmDdbIrul31FQxd2ofRngLy1UB+13v23K6NCVb3gVyVPH49oo/My?=
 =?us-ascii?Q?zfAKvQ8ry/VU4TMNhlVnMw2IuF1pYqxng+1bFC/QqpWNEWAcv7wfHDFrs7dI?=
 =?us-ascii?Q?m4YMWZ5MhuSBZIUa7/Jmwtq5J6FdidgaUA2WhOR6TI6PxhzCYMgLeChyZVZ3?=
 =?us-ascii?Q?QmKmGeRl7Got3B0z/Ing74XrBaM18ytcHMVSkhCz8/GZkBr35FXIbFSQvR0d?=
 =?us-ascii?Q?3+4okO1DBdEZNzu+e2NYcoy31yXsgkrH+R2qQ345bu27i169G2jeC4Ujy7ZN?=
 =?us-ascii?Q?SOh+7AyuGwGSuTsS5n8NJrK2GDueTnO6OAvRPSWP9fy2WbMTy1P0UYCV0Lz/?=
 =?us-ascii?Q?Vr/XoT6pHXqmw55PoZpe6MZArOyMfpPNmNvvOpP1memTrjyc21j6Vf8ew0fW?=
 =?us-ascii?Q?om1ems1fRC6LmuiwJQ2h2OKcQ3cWgpmZX7y3tAFgW5E040LjVOuNVrhIqy8g?=
 =?us-ascii?Q?ARAVH0eYh6q+k57hIHSV1RNQxmuvvQ784ZP/yICzuBfdN75ugZfXC72v2Lzv?=
 =?us-ascii?Q?rapuBNFqJzUh+HMvffPc1BEAdxjYU6UIG1aWsBwd8/HJTturW1PBSAgPaqGB?=
 =?us-ascii?Q?tKFrYDVaDM4QsZQQqMmsWEToDkKYEJq9eDPXID5KMKnvqUHQyPS+tAIyzS/6?=
 =?us-ascii?Q?edl9hx/VsmWSpYTQAzcW/1vczPxMEdQgDkeDkFL2CgrwXsPWk2sfKR+8DxHX?=
 =?us-ascii?Q?EFXifrlXthpQKo3L/NloUBYdi7vqaua+tCUqgoivoL2Lnkrxk/zb8k/nvkd7?=
 =?us-ascii?Q?sSLjwGFH1Mua2o3YHsjsRCdulQXNNu4LR6jU1AKA1hoH1xlIdyy5UUejBLtf?=
 =?us-ascii?Q?EPNuHnFnyof3z0ojEi0E7vXOVWgis4wpA5ZoeI0VkOYEKOV9Xc/9SB3DdCOD?=
 =?us-ascii?Q?jDM9e86EgvmcYhjPMN9lMFCMLMPzTnU8P090qdx3SE9USXrErCnApbJ9AvNy?=
 =?us-ascii?Q?3HFjwrZAAQUipEkBQM5TyobWXEgeoip0vbNZZEIrUzmap8W2vMIK1EthY1M8?=
 =?us-ascii?Q?MKqvJ6S+MeXnWYkMLEAVHQParUJsaqvoJ16bF4goYojJfkPM9UlqaEfgOXSu?=
 =?us-ascii?Q?e68HIbYpS0rW/q8BFs1JP0iTw3WY49PbB1O2KTYmxArGUZKG+G9AXzpLQMoS?=
 =?us-ascii?Q?GhOS65ctnDRSkmVhfZxOA+JpJeGw4EJquzJQcJ+7dzYpojKlZM9XmHJ7PSbT?=
 =?us-ascii?Q?Rt2zMT4ItybpdN64H8bhi9H54lIBP58FUIu/PQHWY/AV3gaeefvBq41ShLkL?=
 =?us-ascii?Q?o8b8+qVFP2FefSyEj9UQpv1/pgGMbKO85lBrwXqP1YC4fGPioVumVFgI2q59?=
 =?us-ascii?Q?fa8KwyWpOdBaQMWi/+7FBAokYRtQn769aMNLAORQ5qtYVraM3JJRo4Gqe9bh?=
 =?us-ascii?Q?hnkADU9XYH6wZb5p56Gi6wsbFTA/NQs73ItUDYII4LqjDhSED1HLvuzwejq4?=
 =?us-ascii?Q?VEc9qpHorXyGjUYQblr7qTqVoolUaORIUAHgYiRGQXTi2SI6hNMiy3LlnojO?=
 =?us-ascii?Q?jFcTHKJXtMQuy2BD/7WFb2nfJVfSGCH5Y0KNztbBwI8CvA/NB6FVqZmg0cPb?=
 =?us-ascii?Q?RjGW26eZ+ey5FNAdhkRppqVQ8rBinxqkpQmGRwapHbhjToy2izT3esviKFkF?=
 =?us-ascii?Q?dL174B4fx72Y7b8zDJoPk2pn8RdLrrDRQt9QDvfphw3OGWmFSS/RVUhxRjb0?=
 =?us-ascii?Q?MGm8TZt9Za/xTxB5f/rWLgNrjmguLqgcDCFTVYTGbca13iqbwCYIZaHV4KNA?=
 =?us-ascii?Q?Iq0mLDNnzY0tHnPZAjyjJaEId6WF1Uk=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d5ea6e-b5fd-43aa-f066-08da3d79da18
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:58.7157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyTi2fZVZ9NHhjQvg+I5zQnr5RONMe1XLXLqGcnFy4mmqrguvs3+YwItycA5AsLvur3D7+PeC17BXZLL4YvYbw==
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
 drivers/net/wireless/celeno/cl8k/dfs.h | 146 +++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs.h

diff --git a/drivers/net/wireless/celeno/cl8k/dfs.h b/drivers/net/wireless/celeno/cl8k/dfs.h
new file mode 100644
index 000000000000..a252844f854b
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs.h
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_DFS_H
+#define CL_DFS_H
+
+#include <linux/types.h>
+#include <linux/spinlock.h>
+
+#include "debug.h"
+
+#define CL_DFS_MAX_TBL_LINE       11    /* Radar Table Max Line */
+#define CL_DFS_PULSE_BUF_SIZE     64    /* Radar Pulse buffer size */
+#define CL_DFS_PULSE_BUF_MASK     0x03F /* Radar Pulse buffer cyclic mask */
+#define CL_DFS_PULSE_WINDOW       100   /* Radar Pulse search window [ms] */
+#define CL_DFS_MIN_PULSE_TRIG     1     /* Minimum Pulse trigger num */
+#define CL_DFS_LONG_MIN_WIDTH     20    /* Min Long Pulse Width */
+#define CL_DFS_LONG_FALSE_WIDTH   10    /* Low width signals indicates of false detections */
+#define CL_DFS_LONG_FALSE_IND     6     /* False indication while searching for long sequence */
+#define CL_DFS_STAGGERED_CHEC_LEN 4     /* Staggered check length */
+#define CL_DFS_CONCEAL_CNT        10    /* Maximum concealed pulses search */
+#define CL_DFS_MIN_FREQ           5250  /* Min DFS frequency */
+#define CL_DFS_MAX_FREQ           5725  /* Max DFS frequency */
+
+enum cl_radar_waveform {
+	RADAR_WAVEFORM_SHORT,
+	RADAR_WAVEFORM_LONG,
+	RADAR_WAVEFORM_STAGGERED,
+	RADAR_WAVEFORM_SEVERE
+};
+
+struct cl_radar_type {
+	u8 id;
+	s32 min_width;
+	s32 max_width;
+	s32 tol_width;
+	s32 min_pri;
+	s32 max_pri;
+	s32 tol_pri;
+	s32 tol_freq;
+	u8 min_burst;
+	u8 ppb;
+	u8 trig_count;
+	enum cl_radar_waveform waveform;
+};
+
+/* Number of pulses in a radar event structure */
+#define RADAR_PULSE_MAX 4
+
+/*
+ * Structure used to store information regarding
+ * E2A radar events in the driver
+ */
+struct cl_radar_elem {
+	struct cl_radar_pulse_array *radarbuf_ptr;
+	dma_addr_t dma_addr;
+};
+
+/* Bit mapping inside a radar pulse element */
+struct cl_radar_pulse {
+	u64 freq        : 8;
+	u64 fom         : 8;
+	u64 len         : 8;  /* Pulse length timer */
+	u64 measure_cnt : 2;  /* Measure count */
+	u64 rsv1        : 6;  /* Reserve1 */
+	u64 rep         : 16; /* PRI */
+	u64 rsv2        : 16; /* Reserve2 */
+};
+
+/* Definition of an array of radar pulses */
+struct cl_radar_pulse_array {
+	/* Buffer containing the radar pulses */
+	u64 pulse[RADAR_PULSE_MAX];
+	/* Number of valid pulses in the buffer */
+	u32 cnt;
+};
+
+struct cl_radar_queue_elem {
+	struct list_head list;
+	struct cl_hw *cl_hw;
+	struct cl_radar_elem radar_elem;
+	unsigned long time;
+};
+
+struct cl_radar_queue {
+	struct list_head head;
+	spinlock_t lock;
+};
+
+struct cl_dfs_pulse {
+	s32 freq  : 8;      /* Radar Frequency offset [units of 4MHz] */
+	u32 fom   : 8;      /* Figure of Merit */
+	u32 width : 8;      /* Pulse Width [units of 2 micro sec] */
+	u32 occ   : 1;      /* OCC indication for Primary/Secondary channel */
+	u32 res1  : 7;      /* Reserve */
+	u32 pri   : 16;     /* Pulse Repetition Frequency */
+	u32 res2  : 16;
+	unsigned long time; /* Pulse Receive Time */
+};
+
+struct cl_dfs_db {
+	bool en;
+	enum cl_dbg_level dbg_lvl;
+	enum nl80211_dfs_regions dfs_standard;
+	struct {
+		bool started;
+		bool requested;
+	} cac;
+	u8 long_pulse_count;
+	u32 last_long_pulse_ts;
+	u8 short_pulse_count;
+	u8 long_pri_match_count;
+	u8 min_pulse_eeq;
+	u8 buf_idx;
+	u8 radar_type_cnt;
+	u16 search_window;
+	u16 max_interrupt_diff;
+	u16 remain_cac_time;
+	u32 pulse_cnt;
+	struct cl_radar_type *radar_type;
+	struct cl_dfs_pulse dfs_pulse[CL_DFS_PULSE_BUF_SIZE];
+	struct cl_dfs_pulse pulse_buffer[CL_DFS_PULSE_BUF_SIZE];
+};
+
+void cl_dfs_init(struct cl_hw *cl_hw);
+void cl_dfs_reinit(struct cl_hw *cl_hw);
+void cl_dfs_start(struct cl_hw *cl_hw);
+void cl_dfs_recovery(struct cl_hw *cl_hw);
+bool cl_dfs_pulse_process(struct cl_hw *cl_hw, struct cl_radar_pulse *pulse, u8 pulse_cnt,
+			  unsigned long time);
+bool __must_check cl_dfs_is_in_cac(struct cl_hw *cl_hw);
+bool __must_check cl_dfs_requested_cac(struct cl_hw *cl_hw);
+bool __must_check cl_dfs_radar_listening(struct cl_hw *cl_hw);
+void cl_dfs_request_cac(struct cl_hw *cl_hw, bool should_do);
+void cl_dfs_force_cac_start(struct cl_hw *cl_hw);
+void cl_dfs_force_cac_end(struct cl_hw *cl_hw);
+void cl_dfs_radar_listen_start(struct cl_hw *cl_hw);
+void cl_dfs_radar_listen_end(struct cl_hw *cl_hw);
+
+void cl_radar_init(struct cl_hw *cl_hw);
+void cl_radar_push(struct cl_hw *cl_hw, struct cl_radar_elem *radar_elem);
+void cl_radar_tasklet_schedule(struct cl_hw *cl_hw);
+void cl_radar_flush(struct cl_hw *cl_hw);
+void cl_radar_close(struct cl_hw *cl_hw);
+
+#endif /* CL_DFS_H */
-- 
2.36.1

