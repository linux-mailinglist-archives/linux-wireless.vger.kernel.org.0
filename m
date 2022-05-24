Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C5A532946
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236788AbiEXLiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbiEXLiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:15 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70041.outbound.protection.outlook.com [40.107.7.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2B78CCEA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTCO/saUBNWZ+8UKqF9r6jxuv5rNcylBCz59bYiSzo5rWwLE6k5/K4FSKJiLglAYyAzLI7IAjLLr1tcczuUsIUWoiBT2jDeVsofGaX3po95GGLx8aVO59HmkLSwzH8T7LnF1hfCzwAK3P0l8oZlvDJcINCaxb+1XnRjjA5ciFHnrjh9qfRDz41djh1Jim3dzZGNngC7KTRzzYzMt0wAUNGNf1lCusRthJ3dsa2mNDVmGVn4Tl+xtW8BOQrZWj+vsZ7laHe7YGlQRZgyD9PYf0BGDyu8Di6F8c8ApW6S6Y/Kro5LqHeR92rIVYVoDJcldGrtl1S7KA9gFdceq3DLSvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdJKGhv1awtpSLfprCHArHA5yR4oRhIZpC2DNsxNoXw=;
 b=Ms4hAZWp0m2u4URunuz+nAMKdrQslXVQJzEfWJvLfWIut8Fj7XHMP31UG9PV+A9mxh65fAjj1zC7RsezYo9lFa02acQi7/3ApjurRM/BhZWf0RTV94oGFj6xyx36Oc+VwtprOC+8hY0MIhc969yAmzsfJYxXek3Tumg0tWryTkoYXsVkhp67ekfaou1YKVF1Y+xHLsbMogmH+saVlEK7s12bSrxTXaAn6AfRnrpI6LnNTApp0icTL2Q1ytuMKEGhDBMDXfKUQlURKYhwRwxcnYZAErKMoNt2tjqCGOi3vMRoMKKiuFm8JDiUEoLwIAshPokcOVPFdBpKmE/vzUitmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdJKGhv1awtpSLfprCHArHA5yR4oRhIZpC2DNsxNoXw=;
 b=lMVku6bU+mjBcu4Ku3u2ePUi/GrXM6dKxEVsMC1JIBP+Ec/izljzwuQJMo8Je+p+07jgnpm1yWCI/G31C4KILSqAJFNERD9xtswdbTHC7puxtl9UdTWplomwnNFhXJgOs18xpmlsSbpq5tEm+m11U9loOBFmd5bmfqAHoVO8RsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:56 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:56 +0000
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
Subject: [RFC v2 18/96] cl8k: add debug.h
Date:   Tue, 24 May 2022 14:33:44 +0300
Message-Id: <20220524113502.1094459-19-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f6b95a3-6f2c-41ba-2f3e-08da3d79d894
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469B58BA2E7D096EDEE284BF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3hDs4+1PUkwO21V1syEVwhagl4w89NdDh/3d/jHlH3UP5GHI5Jhhy7u/KDdrMf6AGS9LR4A5tPBeqECiXeF5oPbj5L0F3jp5+vN7yGgXrRPhQ3437TRKgtiqpRHswlhsH+6BW3ssZ9ZbinrjjukLmUky6lzlGNGa6y5INYHrUHDtWd1+pBdEyR8sSc+0XMzBpm2LmoLmJ4rMLOrZbzQxU9SAGU8rOOBKpzsvfHcflNU0VyfQnU+pEQEmQ89QE2ljNNcM5k8z9eXWancDzFjf49ypSD0xZTCchm74LRUjm69NBadIUD4Vt1dujynTyPUSSq6hmPeHSl91fBOTMWSCNzEy4RqfW7plFp9zlnje1XrIxrn0XtNQs8c50QvKxfeHlGI+acoe/NJhZgtQZ4SsOTj3QyolPhjJKJ5G3CslFO5xq9nROqfOo1do6rvASCwiQjpAGp0FlzfAscwhPiUif4+9cjCmwQmKH4yjtvM+UXR/vm3C+kh7qaeXHOkNJqeLw4AfjZ31CInOBfJpGq7l9LmqWaQcnyDiymmNjHb+U3bCo8Hd0Kq2ShZzt9wiUnxVDqSD6ACPjCg7sipyqTubd5mhK/Jd1fZnv8R7i5HuLAcjKlyEotsRKdWg77mvZQIgoYffWqWK0jhQ7R0znPA5YhYvbktnqur5f3TL4gawtaEmKQQHi90tmpyiRgS4k3EMURd2Kvu2TtS6qVYPz3+0uJmVKwTGhQR9pMvMwK4gptg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4LzfykFqoJfIfrdXHvAwKpmrJrrAnQu0eWLfIz5VGsOlPBYLGlff3hEVXPiK?=
 =?us-ascii?Q?gN4MzJVuBeS6O026f6oNfkIVTd7QN4GezVjc2I9OjxZbIxsh2cY3vht98nnB?=
 =?us-ascii?Q?98qgYdpd/Gn9o3ndyWlwgnjDYrq/ttxqg24JQSw4UNiinfgK6Y9NJF6o+9m1?=
 =?us-ascii?Q?waYStMY0co3LQX1SclsM8Nc0AmlvkoXjEk7pd4+DlTh2WygPKvJSkGY2ZRAX?=
 =?us-ascii?Q?oSxrrEnE46Np+M1hr/m6WVhtlQzqJzHnzxQVdECUMRiuRVC8F12fNe6K8KTk?=
 =?us-ascii?Q?carVfuLvdFZntRbQxrwP77CNAmq92LOU9mqpaEm8yfnMKJxC8OcRRfVeOzTv?=
 =?us-ascii?Q?yTYMJvfqpgxRWc+Yr4mp+9H0R2hKfV45EU6deWhae3v9l+xxxHNzgSqsJp3I?=
 =?us-ascii?Q?sLLQdDQoHfv/NwVSuLcMuZJFkdvvlF4YbkjlLqGxAnmehDfkMr8JYAXt4VGe?=
 =?us-ascii?Q?8uTzmPAqNF/AdUicTTqtSbp16nr96Ftc89Bt8VQ6UMcleOSee9sGeqbIIYDp?=
 =?us-ascii?Q?PWRF93haNTqy80GLXPTDwQqzxSntuJn9BSNiNBvpTLlSE3LWM86y4jHA2+jU?=
 =?us-ascii?Q?vVMCttnQAJ2YC4l8NG/tKHuZ2gdb2l09H5eizlyIZ9vYZP6QkEOV4mxiuUqX?=
 =?us-ascii?Q?UmSfZj4QWxmWBbVbrqks9mb3EuXKrrEscwtlv0Ggapteoa7QpArA4wF6XmoJ?=
 =?us-ascii?Q?hqkQ//7O2lNEtgBRJ70adL1VzHQtSJ/cEfPu/UuaUx12HenXfsqC2J6U3WR1?=
 =?us-ascii?Q?F3ctAUX0WwDksUIrNt91j+yCJY8vJcKHJFJiX5P09h05uBSR9Qjwa5Uf5nfZ?=
 =?us-ascii?Q?oAo90kY+kZOpU0VYcZv2x1OinwZ92nyaoaawEdxvLF0LdiGsaZaEdn2MqzgX?=
 =?us-ascii?Q?3hmvUUcRtzSavf7Xp+HI5Nz7MYxUIrwBEivQPMj1dBqFjgXgDvG7TZgW7Eso?=
 =?us-ascii?Q?peLvMvdai1zhxnRggMqB8WIBrBlGNR0P8H8vOMfyGPoKO8GZGfznZjJsBNb3?=
 =?us-ascii?Q?Y1KvhrBynvtMUYpC2RXScq8ENklrK245wOaubWUGz71zvo2FK7mA8QunxVXT?=
 =?us-ascii?Q?URhpzxT6pK5awaogE5pi+PvxidEq9KVSZYpWHDJPCj6hKl/OTEpTuDGTMfLe?=
 =?us-ascii?Q?y/6aP6cluNbwt8GnXsGZhBYRtbIIfCD6sssyxAaENzj3owkjPlb3nt4Jca0n?=
 =?us-ascii?Q?37cpenO5jYVZP/q13JLup7yBdGJUf0M4yDejYEBohyRB4YWORlq9bOvTjVWM?=
 =?us-ascii?Q?Gs3Ep3osdxbaGYA24Pcoe4wJ4CkubvdPAP774c/U5UcSoYOc0g1oqnwjjBPZ?=
 =?us-ascii?Q?RIZhiYOil7QqSvk+POUk/lY1sXSLryj7HgRifwSvUvHodWxPDUlypZf5dBB/?=
 =?us-ascii?Q?b/VccTQKMXtJnPohYyZpD2iVx6PScGjUF2nEYZFlD1S7hvVCljCcPNrKlgz+?=
 =?us-ascii?Q?xVd5FQKurcDMDWm8wAFGXvVNX54bpjVJtrmMYgmJ97Nt3L10J5UnaW8m5xEG?=
 =?us-ascii?Q?LEFAp4NtxnJb/fbbvPZCZQS/Dygfxf76dp2fAFlwWGa4QgB2YVgTMTv1ppgT?=
 =?us-ascii?Q?KIZpKhJ/BzAqz+vYhn776GSYACH/s3CM8nQrfCDEXM/UH8JUff6JsqQjdYkA?=
 =?us-ascii?Q?4Fdqw39/CnP/4jId5PMjSHZ8BoKNdtlvaYaKRDRoTKkgh0p+rlZv/TaD9sw/?=
 =?us-ascii?Q?lBLp7WQrf1DulCdROL1NuAJCwXYx16kSqnak2mVQuNSNBk1/aQ9qCwbUTbyB?=
 =?us-ascii?Q?XHlYk0YUKkovBTxrXTfkrUqqbxOKVaU=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6b95a3-6f2c-41ba-2f3e-08da3d79d894
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:56.1679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfbR+4Bij978MI3niqJxat9HDBIW3/bc4fwwRB8YEIky0ZCJrSVnJWBe+LboNeYF0215caElXme8wnbvJuI3uA==
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
 drivers/net/wireless/celeno/cl8k/debug.h | 160 +++++++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/debug.h

diff --git a/drivers/net/wireless/celeno/cl8k/debug.h b/drivers/net/wireless/celeno/cl8k/debug.h
new file mode 100644
index 000000000000..dffee2125903
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/debug.h
@@ -0,0 +1,160 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_DEBUG_H
+#define CL_DEBUG_H
+
+#include <linux/string.h>
+
+enum cl_dbg_level {
+	DBG_LVL_VERBOSE,
+	DBG_LVL_ERROR,
+	DBG_LVL_WARNING,
+	DBG_LVL_TRACE,
+	DBG_LVL_INFO,
+
+	DBG_LVL_MAX,
+};
+
+#define CL_DBG(cl_hw, lvl, fmt, ...) \
+do { \
+	if ((lvl) <= (cl_hw)->conf->ce_debug_level) \
+		pr_debug("[tcv%u][%s][%d] " fmt, (cl_hw)->idx, __func__, __LINE__, ##__VA_ARGS__); \
+} while (0)
+
+#define CL_DBG_CHIP(chip, lvl, fmt, ...) \
+do { \
+	if ((lvl) <= (chip)->conf->ce_debug_level) \
+		pr_debug("[chip%u][%s][%d] " fmt, (chip)->idx, __func__, __LINE__, ##__VA_ARGS__); \
+} while (0)
+
+#define cl_dbg_verbose(cl_hw, ...) CL_DBG((cl_hw), DBG_LVL_VERBOSE, ##__VA_ARGS__)
+#define cl_dbg_err(cl_hw, ...)     CL_DBG((cl_hw), DBG_LVL_ERROR, ##__VA_ARGS__)
+#define cl_dbg_warn(cl_hw, ...)    CL_DBG((cl_hw), DBG_LVL_WARNING, ##__VA_ARGS__)
+#define cl_dbg_trace(cl_hw, ...)   CL_DBG((cl_hw), DBG_LVL_TRACE, ##__VA_ARGS__)
+#define cl_dbg_info(cl_hw, ...)    CL_DBG((cl_hw), DBG_LVL_INFO, ##__VA_ARGS__)
+
+#define cl_dbg_chip_verbose(chip, ...) CL_DBG_CHIP((chip), DBG_LVL_VERBOSE, ##__VA_ARGS__)
+#define cl_dbg_chip_err(chip, ...)     CL_DBG_CHIP((chip), DBG_LVL_ERROR, ##__VA_ARGS__)
+#define cl_dbg_chip_warn(chip, ...)    CL_DBG_CHIP((chip), DBG_LVL_WARNING, ##__VA_ARGS__)
+#define cl_dbg_chip_trace(chip, ...)   CL_DBG_CHIP((chip), DBG_LVL_TRACE, ##__VA_ARGS__)
+#define cl_dbg_chip_info(chip, ...)    CL_DBG_CHIP((chip), DBG_LVL_INFO, ##__VA_ARGS__)
+
+static inline char *cl_code_basename(const char *filename)
+{
+	char *p = strrchr(filename, '/');
+
+	return p ? p + 1 : (char *)filename;
+}
+
+#define TXT_ERROR \
+	do { \
+		pr_debug("\n"); \
+		pr_debug("#######  #####    #####     #####   #####\n"); \
+		pr_debug("#        #    #   #    #   #     #  #    #\n"); \
+		pr_debug("#        #    #   #    #   #     #  #    #\n"); \
+		pr_debug("#######  #####    #####    #     #  #####\n"); \
+		pr_debug("#        #    #   #    #   #     #  #    #\n"); \
+		pr_debug("#        #     #  #     #  #     #  #     #\n"); \
+		pr_debug("#######  #     #  #     #   #####   #     #\n"); \
+	} while (0)
+
+#define TXT_WARNING \
+	do { \
+		pr_debug("\n"); \
+		pr_debug("#       #   #####   #####    #     #  ###  #     #   #####\n"); \
+		pr_debug("#       #  #     #  #    #   ##    #   #   ##    #  #     #\n"); \
+		pr_debug("#       #  #     #  #    #   # #   #   #   # #   #  #\n"); \
+		pr_debug("#   #   #  #######  #####    #  #  #   #   #  #  #  #    ###\n"); \
+		pr_debug("#  # #  #  #     #  #    #   #   # #   #   #   # #  #     #\n"); \
+		pr_debug("# #   # #  #     #  #     #  #    ##   #   #    ##  #     #\n"); \
+		pr_debug(" #     #   #     #  #     #  #     #  ###  #     #   #####\n"); \
+	} while (0)
+
+#define INFO_CL_HW(cl_hw, ...) \
+	do { \
+		pr_debug("\n"); \
+		pr_debug("CHIP:        %u\n", (cl_hw)->chip->idx); \
+		pr_debug("TCV:         %u\n", (cl_hw)->idx); \
+		pr_debug("FILE:        %s\n", cl_code_basename(__FILE__)); \
+		pr_debug("FUNCTION:    %s\n", __func__); \
+		pr_debug("LINE:        %u\n", __LINE__); \
+		pr_debug("DESCRIPTION: " __VA_ARGS__); \
+		pr_debug("\n"); \
+	} while (0)
+
+#define INFO_CHIP(chip, ...) \
+	do { \
+		pr_debug("\n"); \
+		pr_debug("CHIP:        %u\n", (chip)->idx); \
+		pr_debug("FILE:        %s\n", cl_code_basename(__FILE__)); \
+		pr_debug("FUNCTION:    %s\n", __func__); \
+		pr_debug("LINE:        %u\n", __LINE__); \
+		pr_debug("DESCRIPTION: " __VA_ARGS__); \
+		pr_debug("\n"); \
+	} while (0)
+
+#define CL_DBG_ERROR(cl_hw, ...) \
+	do { \
+		TXT_ERROR; \
+		INFO_CL_HW(cl_hw, __VA_ARGS__); \
+	} while (0)
+
+#define CL_DBG_ERROR_CHIP(chip, ...) \
+	do { \
+		TXT_ERROR; \
+		INFO_CHIP(chip, __VA_ARGS__); \
+	} while (0)
+
+#define CL_DBG_WARNING(cl_hw, ...) \
+	do { \
+		TXT_WARNING; \
+		INFO_CL_HW(cl_hw, __VA_ARGS__); \
+	} while (0)
+
+#define CL_DBG_WARNING_CHIP(chip, ...) \
+	do { \
+		TXT_WARNING; \
+		INFO_CHIP(chip, __VA_ARGS__); \
+	} while (0)
+
+/* Min HW assert before testing asserts time-stamp */
+#define CL_MIN_ASSERT_CNT 10
+
+/* Define max time between hw asserts in msec */
+#define CL_HW_ASSERT_TIME_MAX 5000
+
+struct cl_dbg_data {
+	char *str; /* Pointer to debug strings start address */
+	int size; /* Size of debug strings pool */
+};
+
+/* String offloading to minimize FW size */
+struct cl_str_offload_env {
+	char *block1;
+	u32 size1;
+	u32 base1;
+	char *block2;
+	u32 size2;
+	u32 base2;
+	char *block3;
+	u32 size3;
+	u32 base3;
+	bool enabled;
+	char buf[512];
+};
+
+struct cl_hw;
+struct cl_chip;
+
+void cl_dbgfile_parse(struct cl_hw *cl_hw, void *edata, u32 esize);
+void cl_dbgfile_release_mem(struct cl_dbg_data *dbg_data,
+			    struct cl_str_offload_env *str_offload_env);
+void cl_dbgfile_print_fw_str(struct cl_hw *cl_hw, u8 *str, int max_size);
+int cl_dbgfile_store_offload_data(struct cl_chip *chip, struct cl_hw *cl_hw,
+				  void *data1, u32 size1, u32 base1,
+				  void *data2, u32 size2, u32 base2,
+				  void *data3, u32 size3, u32 base3);
+const char *cl_dbgfile_get_msg_txt(struct cl_dbg_data *dbg_data, u16 file_id, u16 line);
+
+#endif /* CL_DEBUG_H */
-- 
2.36.1

