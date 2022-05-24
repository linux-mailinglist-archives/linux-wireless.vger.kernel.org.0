Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C97B532944
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236800AbiEXLiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbiEXLiN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:13 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70052.outbound.protection.outlook.com [40.107.7.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D43D8CB3D
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjUppEkIIWCuSdfDllOQCBMMjUWAQtVg64YUYFF9bPBLz2E+L3lHVgrOT2uIXEbu1aEl7kdNiTuyjEfCVyQfHH+jSh6H1bcBgvU39dFrUkjUS3zkE0x7qUq2gWyPyxhbrtJBnz5tKX0JB0xbf3rKSnS/Litb7M435hKsNmw1O2Jo2/d2vMmNJdBGN5Zkq+PHDu3JbrvfLKOQ0OY5qYNR1tK/B7JBt4T/+WI/+205Zic9IA86JR8f6q7c/Q7dIg9hH+7ZzOlQh9OY+dX9MtzG7zXf0IUEunF/1Q93C/PgReKcRnVEvYg2BKv+4rZ5cY5YIcd8uSFYPbHi4lsn8H7rJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1buV6dRM3M0x/06R3qQp+ncFWo2ZXah0gGW/YWwdR4=;
 b=kSHECAfNY2ki5oDdPFlK3K+WC9nfyH4DDlcmGTLXgnsz9D5vmLMMZ6j21ADTopdEBagSTaDXSvwM2TTq24IN0PJzXbDZj+nDUWKd36ygxtA+PP6KtXjpK+QCJWzq2nXiOFU2d18pVoq2rOkVYRmh3+/Rc/3u19zZhLLIXdfhkefFkD7npbvksLdTW1deNSXQw/zEby9cXnmPmTORbTm3hLuXyjU0l5NnPoafO7IfOf2Eg+d7v2aLUSdzSM8pqbbXa67V9vsSVWGcHAQQ7jBnZGi5bp3ALG/JARWxjOmcV2R1Y07qwQ0ekTifMGm/CCywR52mkVTFxcVslc2oortz+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1buV6dRM3M0x/06R3qQp+ncFWo2ZXah0gGW/YWwdR4=;
 b=fzVjKd5JnXgzxAsAadfCQXJb6vPL+/Yj+raDHDizo3doNJnBSJjXxNL9AJkAbO4yTF6dfsX3XwbQ4kyaDRdwgges9p9kyPnEEoLc7O7PxpehaQXmZPs72DDaYKXdfRFR5uqIbpfAucLyHEnmHJjjFmjN+Y2ukPie08Pdd197i1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:54 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:54 +0000
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
Subject: [RFC v2 16/96] cl8k: add config.h
Date:   Tue, 24 May 2022 14:33:42 +0300
Message-Id: <20220524113502.1094459-17-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9ec262ff-829c-49bb-fd30-08da3d79d7a7
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB046967F66A4D5C30C8FBD3FEF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIGCDBu76DhBf3WHlRD3HdXs3PIHlAOM1FFH5ByNQhAbBBwzWuHGCBza1jEPSSBerVvp8NzHitcYfpDmaCJ0p0YiJYKAnrvAYB3Fh4sQytWBSm7Ius7ORuoHX/QmifEhJxTwHkvW44yZYfrOlpSJ+WdnYzMeVrNUCdG93LpKgiCzwZr69SPnjrs39CSSnVEt13X/CKoKA47lxr+ga+OS/aeKR6N2ur49CpHCt6Pvr0tcgmcHj9P7LRm+XG4UfozFWHVuAGlUo6txDIxtt8ScK4ZLcsrOuI3Xr9zkFJ6kbEgEWlnSaT9mOmC8GTrGOSihzPGi7upGYZ5VV0baLOkAl1D5Cmt3AgZakoGskfL2hmx0+BHvJxIqJkyfA86DI2q7OX8MnMdQYwH9JAiRlszfnyXO7/tQu1f48EF14g82hMBfNTKR5AHgfsU1GpnVI94kqhFBWDWjUToYuk1Nj/S3fueQlbjvhJR+Gjgiq0hPXtyGPj3ha83nV9lKbyFzmAmWNTyebmHG5vAzCsCv58F+29KUeXcxs2+SyE64775rW4/7TmkIAvBghnhAtK+8hACPtHBVOO0QoaufqjueHp/F8QSGrw9BYkIgSw2DKVrFePCgTjUNgOB6nQGasScmUTTXqMCdYKlYKUleOiw+SRq4OBSNp2nZZAX9h68bj5sp+Mqe2BPH4Rf/W1LeNElzNrqN3YZKEyk8z3uagJGCQTV8Ps2wihNo7glH2ErFky2jRu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ysBiN3yk7yM2+ljtS5aaqip4jmZQAvgM3rzaaLiIWF++6FxvlMCvnJQRv/sR?=
 =?us-ascii?Q?CqWtFfIqob22mUqBoZ06gPSAmqW6l8RoseEFQgq8qArbL+rM2bc/5dT+Y+Mo?=
 =?us-ascii?Q?I/2cGjhZeqWt1XrDU+dYSD5EhVjOG9M/NP4Hex8zb19iGXNzX/4/Kfm+rqEG?=
 =?us-ascii?Q?ha4SzBK7W9dOfvqVhR2iBHUlm6/lmrvmjtPhqkRadWwBMqAfcorHNQsUJlG9?=
 =?us-ascii?Q?UVk1nBxbm4TNi0sMkCfWndi3D+LZUIPJQghPAtcxwASGyKjFLKQn5mFJMxPt?=
 =?us-ascii?Q?W345FrDGJ3lM6b4Ky4U1LA6D54D63+7w9k5cgMZAQ0mIaymqiZ0IIr1T6gDG?=
 =?us-ascii?Q?ArMEd2DrOJaswgSs0sXqvvF8CwVAbdUUsff7/D3kYxMrYrszw5abgRCKXh+s?=
 =?us-ascii?Q?mkuePjpdBNY/EtxENyacuDyfrGn+8U8zqdpQ3F/johsMHnsw6aaRU/PpxGRH?=
 =?us-ascii?Q?MoDS2LlChqZVnoxUr97wRRCiNlXjlnxmdt+91KrLDLUVYolHC7gQhPPoTRPf?=
 =?us-ascii?Q?W3/vS8QrSEBHebXw8gHA8a8sQZcR8YZsEoq6vApS8sbeP/l3hFur+NJ05DRE?=
 =?us-ascii?Q?bnNTJn31QhlnVluIwZAz0K3M/4U4ZtQAYhE+Gdjw+fcYXWEnW7LMWH/8vQlX?=
 =?us-ascii?Q?9xZ1IDIetXjMxSXbHnzMQTcQPjIIB0YsLtBgoWrNk6ukbzi5DzbGt5H/Qm4B?=
 =?us-ascii?Q?mZ3XAwlCfU8RTJ7XZA5u4RahWYOMk9AtKz1W0wMQZpUYC4JndaatcVCJLW3/?=
 =?us-ascii?Q?iu0xhkPjQBA8uqoO609bWuzQqf7NrrXC8oqsjlJNyHXqo9uX5Js7qAyHtXJK?=
 =?us-ascii?Q?gkres0QdG9P6YuVarYDQZBV9TYnn91R8LzaTrteQguBzQmiVljkU4Lpf0cn6?=
 =?us-ascii?Q?DdssgxxhYqeDXw1oaBP455KsdKYq6ygvKB17EuxD7TxiRyGVTZQ0Um9vQ9ze?=
 =?us-ascii?Q?8hjFrsVo8nHviDSwrPrwr7DOBeFwQXLzgpGJrmJ3qRN5Ud8sJa1CgJaJk6vu?=
 =?us-ascii?Q?SZCBRlZVO2Iv5Du/9ADe4nuVpYNCxwZSJ05p2pcJfYXq2U4cdcj3v8pkt7qR?=
 =?us-ascii?Q?g9bjKP2coH4gKUE2TzvbzMYf1u3q4DUfzcG4GtObzJvaSH0z0rDuTw5mSwKw?=
 =?us-ascii?Q?VO8YmcuQ3rJbEzZabbsyy7CiaZEb1matF5iw90d+w5FmommHXY6W7YYFAqNS?=
 =?us-ascii?Q?jXD3pslBsv9hMqhk4gbXNwierSXytSDjzBer6pgL9iz4HPwyZx7GuIl+4EtU?=
 =?us-ascii?Q?9wQR4o1T3N6nxySM8Jdlb8fTQpZjpcK+h6mT/HOTg9OE9Z0YN3I8hVxh/2QY?=
 =?us-ascii?Q?tdvojIXJHECQoM5vduVKdYnDQYY655bAXqym/+Hw2MPNpqu7zYVuMaS5N1n4?=
 =?us-ascii?Q?9KbhgpnTUfVf0eVZFcpm+CY4nnBvDNWBirCXU5Ja35SfUWofPNCg4bi7/P5J?=
 =?us-ascii?Q?TNksM9WNUrv49JxEd3UVRZCpP9qgCdaccfmozXRqYc56dhzN1fHeRjTsfOgm?=
 =?us-ascii?Q?C6EFVyfAofTouqn8RcE36vAMtoeY0upic55p7JpY1QqEoBa8Ib61aLNHiAxM?=
 =?us-ascii?Q?Xk4n/2gA0sp7Bz3zaSs1raN5mWzRr9+vy1qEK4UJP55kX8AQwsR6IcrV8bGe?=
 =?us-ascii?Q?XRQTmbB7SrqRECE6f5MkedZTTgjt+UuwjeiG4zCr14PSmffCddfgxrQzSwuS?=
 =?us-ascii?Q?ETN08lRpEHpT9xKyiLZ2WvODmwafcnsFy5jJj2kfpxJJVh8JOKWBqcg/Z33t?=
 =?us-ascii?Q?WkPkCd5IbfGCuDRyYp62uTS386CLo7Y=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec262ff-829c-49bb-fd30-08da3d79d7a7
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:54.6356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNCDFfzDIuoQpKXccJo3QYuWBzO81wGpwTj5bKqeHovKJ1ga5ORIXVBYZnB1kz9qkGuTilUfWw0GUXX3JhczbQ==
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
 drivers/net/wireless/celeno/cl8k/config.h | 405 ++++++++++++++++++++++
 1 file changed, 405 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.h

diff --git a/drivers/net/wireless/celeno/cl8k/config.h b/drivers/net/wireless/celeno/cl8k/config.h
new file mode 100644
index 000000000000..b918e4423efe
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/config.h
@@ -0,0 +1,405 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_CONFIG_H
+#define CL_CONFIG_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/dcache.h>
+
+#define MAX_PARAM_NAME_LENGTH 64
+
+#define PRINT_UNSIGNED_ARR(param, old_val, size, new_val) \
+do { \
+	u8 i; \
+	char buf[STR_LEN_256B]; \
+	int len = 0; \
+	len += snprintf(buf, sizeof(buf), "%s: old value ", #param); \
+	for (i = 0; i < (size) - 1; i++) \
+		len += snprintf(buf + len, sizeof(buf) - len, \
+				"%u,", old_val[i]); \
+	len += snprintf(buf + len, sizeof(buf) - len, \
+			"%u --> new value %s\n", old_val[(size) - 1], new_val); \
+	pr_debug("%s", buf); \
+} while (0)
+
+#define READ_BOOL(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		bool new_val = false; \
+		ret = kstrtobool(value, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %u -> new value %u\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_U8(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u8 new_val = 0; \
+		ret = kstrtou8(value, 0, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %u -> new value %u\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_U16(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u16 new_val = 0; \
+		ret = kstrtou16(value, 0, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %u -> new value %u\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_U32(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u32 new_val = 0; \
+		ret = kstrtou32(value, 0, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %u -> new value %u\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_S8(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		s8 new_val = 0; \
+		ret = kstrtos8(value, 0, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %d -> new value %d\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_S16(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		s16 new_val = 0; \
+		ret = kstrtos16(value, 0, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %d -> new value %d\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_S32(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		s32 new_val = 0; \
+		ret = kstrtos32(value, 0, &new_val); \
+		if (ret) { \
+			pr_err("%s: invalid value [%s]\n", #param, value); \
+			break; \
+		} \
+		if (conf->param != new_val) { \
+			pr_debug("%s: old value %d -> new value %d\n", \
+				 #param, conf->param, new_val); \
+			conf->param = new_val; \
+		} \
+		break; \
+	} \
+}
+
+#define READ_BOOL_ARR(param, size) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u8 i = 0; \
+		char *buf = NULL; \
+		char vector[STR_LEN_256B] = {0}; \
+		char *vector_p = &vector[i]; \
+		bool old_val[size] = {false}; \
+		memcpy(old_val, conf->param, sizeof(old_val)); \
+		if (strlen(value) >= sizeof(vector)) { \
+			pr_err("%s: value [%s] too big [%zu]\n", #param, value, strlen(value)); \
+			ret = -E2BIG; \
+			break; \
+		} \
+		strscpy(vector_p, value, sizeof(vector)); \
+		buf = strsep(&vector_p, ","); \
+		if (!buf) { \
+			pr_err("%s: delimiter ',' not found\n", #param); \
+			ret = -EIO; \
+			break; \
+		} \
+		if (kstrtobool(buf, &conf->param[0]) != 0) { \
+			pr_err("%s: invalid argument [%s]\n", #param, value); \
+			ret = -EINVAL; \
+			break; \
+		} \
+		for (i = 1; i < (size); i++) { \
+			buf = strsep(&vector_p, ","); \
+			if (!buf) \
+				break; \
+			if (kstrtobool(buf, &conf->param[i]) != 0) { \
+				pr_err("%s: invalid argument [%s]\n", #param, value); \
+				break; \
+			} \
+		} \
+		if (i < size) { \
+			pr_err("%s: value [%s] doesn't have %u elements\n", #param, value, size); \
+			ret = -ENODATA; \
+			break; \
+		} \
+		ret = 0; \
+		if (memcmp(old_val, conf->param, sizeof(old_val))) \
+			PRINT_UNSIGNED_ARR(param, old_val, size, value); \
+		break; \
+	} \
+}
+
+#define READ_U8_ARR(param, size, is_array_fix_size) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u8 i = 0; \
+		char *buf = NULL; \
+		char vector[STR_LEN_256B] = {0}; \
+		char *vector_p = &vector[0]; \
+		u8 old_val[size] = {false}; \
+		memcpy(old_val, conf->param, sizeof(old_val)); \
+		if (strlen(value) >= sizeof(vector)) { \
+			pr_err("%s: value [%s] too big [%zu]\n", #param, value, strlen(value)); \
+			ret = -E2BIG; \
+			break; \
+		} \
+		strscpy(vector_p, value, sizeof(vector)); \
+		buf = strsep(&vector_p, ","); \
+		if (!buf) { \
+			pr_err("%s: delimiter ',' not found\n", #param); \
+			ret = -EIO; \
+			break; \
+		} \
+		if (kstrtou8(buf, 0, &conf->param[0]) != 0) { \
+			pr_err("%s: invalid argument [%s]\n", #param, value); \
+			ret = -EINVAL; \
+			break; \
+		} \
+		for (i = 1; i < (size); i++) { \
+			buf = strsep(&vector_p, ","); \
+			if (!buf) \
+				break; \
+			if (kstrtou8(buf, 0, &conf->param[i]) != 0) { \
+				pr_err("%s: invalid argument [%s]\n", #param, value); \
+				break; \
+			} \
+		} \
+		if ((is_array_fix_size) && i < (size)) { \
+			pr_err("%s: value [%s] doesn't have %u elements\n", #param, value, size); \
+			ret = -ENODATA; \
+			break; \
+		} \
+		ret = 0; \
+		if (memcmp(old_val, conf->param, sizeof(old_val))) \
+			PRINT_UNSIGNED_ARR(param, old_val, size, value); \
+		break; \
+	} \
+}
+
+#define READ_U16_ARR(param, size, is_array_fix_size) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u8 i = 0; \
+		char *buf = NULL; \
+		char vector[STR_LEN_256B] = {0}; \
+		char *vector_p = &vector[0]; \
+		u16 old_val[size] = {false}; \
+		memcpy(old_val, conf->param, sizeof(old_val)); \
+		if (strlen(value) >= sizeof(vector)) { \
+			pr_err("%s: value [%s] too big [%zu]\n", #param, value, strlen(value)); \
+			ret = -E2BIG; \
+			break; \
+		} \
+		strscpy(vector_p, value, sizeof(vector)); \
+		buf = strsep(&vector_p, ","); \
+		if (!buf) { \
+			pr_err("%s: delimiter ',' not found\n", #param); \
+			ret = -EIO; \
+			break; \
+		} \
+		if (kstrtou16(buf, 0, &conf->param[0]) != 0) { \
+			pr_err("%s: invalid argument [%s]\n", #param, value); \
+			ret = -EINVAL; \
+			break; \
+		} \
+		for (i = 1; i < (size); i++) { \
+			buf = strsep(&vector_p, ","); \
+			if (!buf) \
+				break; \
+			if (kstrtou16(buf, 0, &conf->param[i]) != 0) { \
+				pr_err("%s: invalid argument [%s]\n", #param, value); \
+				break; \
+			} \
+		} \
+		if ((is_array_fix_size) && i < (size)) { \
+			pr_err("%s: value [%s] doesn't have %u elements\n", #param, value, size); \
+			ret = -ENODATA; \
+			break; \
+		} \
+		ret = 0; \
+		if (memcmp(old_val, conf->param, sizeof(old_val))) \
+			PRINT_UNSIGNED_ARR(param, old_val, size, value); \
+		break; \
+	} \
+}
+
+#define READ_S8_ARR(param, size) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u8 i = 0; \
+		char *buf = NULL; \
+		char vector[STR_LEN_256B] = {0}; \
+		char *vector_p = &vector[0]; \
+		s8 old_val[size] = {false}; \
+		memcpy(old_val, conf->param, sizeof(old_val)); \
+		if (strlen(value) >= sizeof(vector)) { \
+			pr_err("%s: value [%s] too big [%zu]\n", #param, value, strlen(value)); \
+			ret = -E2BIG; \
+			break; \
+		} \
+		strscpy(vector_p, value, sizeof(vector)); \
+		buf = strsep(&vector_p, ","); \
+		if (!buf) { \
+			pr_err("%s: delimiter ',' not found\n", #param); \
+			ret = -EIO; \
+			break; \
+		} \
+		if (kstrtos8(buf, 0, &conf->param[0]) != 0) { \
+			pr_err("%s: invalid argument [%s]\n", #param, value); \
+			ret = -EINVAL; \
+			break; \
+		} \
+		for (i = 1; i < (size); i++) { \
+			buf = strsep(&vector_p, ","); \
+			if (!buf) \
+				break; \
+			if (kstrtos8(buf, 0, &conf->param[i]) != 0) { \
+				pr_err("%s: invalid argument [%s]\n", #param, value); \
+				break; \
+			} \
+		} \
+		if (i < (size)) { \
+			pr_err("%s: value [%s] doesn't have %u elements\n", #param, value, size); \
+			ret = -ENODATA; \
+			break; \
+		} \
+		ret = 0; \
+		if (memcmp(old_val, conf->param, sizeof(old_val))) \
+			PRINT_UNSIGNED_ARR(param, old_val, size, value); \
+		break; \
+	} \
+}
+
+#define READ_STR(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		if (strcmp(value, conf->param)) { \
+			pr_debug("%s: old value %s -> new value %s\n", \
+				 #param, conf->param, value); \
+			strncpy(conf->param, value, sizeof(conf->param) - 1); \
+		} \
+		ret = 0; \
+		break; \
+	} \
+}
+
+#define READ_MAC(param) \
+{ \
+	if (!strcmp(name, #param)) { \
+		u8 i = 0; \
+		char *buf = NULL; \
+		char vector[STR_LEN_32B] = {0}; \
+		char *vector_p = &vector[0]; \
+		u8 old_val[ETH_ALEN] = {false}; \
+		memcpy(old_val, conf->param, ETH_ALEN); \
+		if (strlen(value) >= sizeof(vector)) { \
+			pr_err("%s: value [%s] too big [%zu]\n", #param, value, strlen(value)); \
+			ret = -E2BIG; \
+			break; \
+		} \
+		strscpy(vector_p, value, sizeof(vector)); \
+		buf = strsep(&vector_p, ":"); \
+		if (!buf) { \
+			pr_err("%s: delimiter ':' not found\n", #param); \
+			ret = -EIO; \
+			break; \
+		} \
+		if (kstrtou8(buf, 16, &conf->param[0]) != 0) { \
+			pr_err("%s: invalid argument [%s]\n", #param, value); \
+			ret = -EINVAL; \
+			break; \
+		} \
+		for (i = 1; i < ETH_ALEN; i++) { \
+			buf = strsep(&vector_p, ":"); \
+			if (!buf) \
+				break; \
+			if (kstrtou8(buf, 16, &conf->param[i]) != 0) { \
+				pr_err("%s: invalid argument [%s]\n", #param, value); \
+				break; \
+			} \
+		} \
+		if (i < ETH_ALEN) { \
+			pr_err("%s: value [%s] doesn't have %u elements\n", #param, value, \
+			       ETH_ALEN); \
+			ret = -ENODATA; \
+			break; \
+		} \
+		ret = 0; \
+		if (memcmp(old_val, conf->param, sizeof(old_val))) \
+			pr_debug("%s: old value %pM -> new value %pM\n", \
+				 #param, old_val, conf->param); \
+		break; \
+	} \
+}
+
+bool cl_config_is_non_driver_param(char *name);
+
+#endif /* CL_CONFIG_H */
-- 
2.36.1

