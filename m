Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453F153293B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiEXLhu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236765AbiEXLht (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:37:49 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0647640A01
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7jcpENGP9ZHize1ms1y+fU/rjgS5RX6Aa80S0SQ2jTujVbSQVGyEjhX4DWafTbZxHA6BLJHK2ytEYOfwe5U9Lw/NUG6BbQZgbvL+h2gAIh3f9ZWxcBYM1H8VZNwjDGlTNp6S3uh/RvTWpPb8rBdsyWcnnFXLlM1+Q8LfhZdfqZwI2Z5K0ISSfBgX6ZEuzbgpn9AUSA6EErZt0vI4CqGrKIf4btwLkmnoyckKIgi1EDxyo5r5hgyb6iCRa9gQxLd4oiLx71b1lJrMHx2cCGwiku67GIX3s3va2aeCLwnr9b74k2NR6kxhhsb0QUBkF9f8SMIRblEEZICOpOrGeQ49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pb9OdR9RorX0vFEVOIWgvic/lEeuE/yg3byo4XZRIY=;
 b=QcqM4JqbtM2UfQB2/D0LF/dgrWcsTgnL3KoJsRRYnrN2/dyfLadvWJTssvZ9XsuOcXU5J71UAYZ5k+1D+kF1pijoUpYhaSwAt2EO6Pyjgl9v6U/AP66uvxuQjTXwXu7m4lvLQUijlijjnLo1xFZBXHoBt/DnKOe17To/cQsK0VXmp0TYsT3Y0JldjWmhj/5TneIDKij15vdu0ZMM7n/uxM4gtFbNks+PUpWFbGRCEbyv07LQ6k19MK5fN47ar0evCsh27U9gEOag1DzySwoK5/TNbr+ROCiUNl7D4suAQRMdrv3vT4m6NOCD8xUNDr4pmiVqXd3qvNdPUeM2SHTnIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pb9OdR9RorX0vFEVOIWgvic/lEeuE/yg3byo4XZRIY=;
 b=x2XW4JB6m2vS3EPfEznb9nbJvYSXV9r6e2Im8BZbXB1+P68gVrPL0I26BYaLqkgcN31JTpvMUztQ4+cnFukPxYM/FLBQJr9Iro0mnL4PbD76SSPJ//J0Z4BjruWpFrffFyaGqMhb4Gt+B6WV8KlrUp1oswV57wrDwZltC/SsUYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0305.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 11:37:44 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:44 +0000
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
Subject: [RFC v2 10/96] cl8k: add calib.h
Date:   Tue, 24 May 2022 14:33:36 +0300
Message-Id: <20220524113502.1094459-11-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 75fa00fb-7431-4332-5b0a-08da3d79d0b1
X-MS-TrafficTypeDiagnostic: AM0P192MB0305:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0P192MB03051AEF13F9CFFFE22E80CDF6D79@AM0P192MB0305.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UfmOCJwMSF5pCYb3Ecqq2INHkFfJAmbxtdxH6oDVVk2mPCiNH0y7gZn4Ph5wUbbkGhAbP7a2IE7zt/WSuZYrvwncoJXTiuWhUDlkspeRVaJFWqLB2fMa1rtiQVU9exjYskZUzuaGPII3D1SmvrKeiq4B4ks/N2q9cqqa+FzgmCTdMNjXuom43Tb5fU+ZIOd9LyB3HhT7QT7RDDbImKXzox1wLXOPIa/KPcCBmUEvQE0Oy6MC7DABBLfa1OIgQM31S4/eBgpBGoym9tzprFo8h2LTiQkzRmccqqs3m2NYBDYWsNJRwtx0XjgS5F36XOev3JekNUcTcfW14Z2Ls6D98V7Pk1P+/ofyg8tyuMJwxz1LnJ652Byz/eHmWqSh/tdMXHY7yaqZmAQ7TlZWhWAOZ4QV5LOot+VeuuH2S+dKcUyG2W0kBF1sxbyWffXkjUXVPpMCDZ6k/6lLrq0tmu5a7bHoOK3VqO0EF9t5Z9EVGMdVJr4/PoQj9J+0eGlo6dvVh9n9jjPG6kdfMF8DeNvByoSclVeJq7qjitcs+VuUO2n4UAgxvle3sTP3cdlI+eM0crltIkCGnscfgfmSgR8XaxO3qayZ+F2+Aibyur/HxIIbNgpP+Tz7BUZXF7TKpMx6wTjk9KwXgbSW2k/zcDuS5jeH6ecKTS9FgL3okhEuQdHD4kNUe3YOQQ/6JhOMweAmbzAEBl8MajksxwC4UaJmFzVK/ubS3kkKtBbE/lPcXA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(346002)(396003)(366004)(39850400004)(376002)(136003)(6486002)(6916009)(508600001)(38350700002)(38100700002)(52116002)(6666004)(2906002)(8936002)(54906003)(6512007)(6506007)(26005)(9686003)(30864003)(8676002)(36756003)(5660300002)(316002)(66476007)(4326008)(66556008)(107886003)(66946007)(1076003)(41300700001)(186003)(2616005)(83380400001)(86362001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aggxSA0jRrujROP65F/qGjpJTkrnMe7nxLl8zcuwzoIncp51ZGiYQwBXaER4?=
 =?us-ascii?Q?LP/rdXoXLJxaqk+jlorJZVNfTLTvrGuJv0j5qJuItPBjZJNsQERp+uPeFmCz?=
 =?us-ascii?Q?p+5DlBgOFPWerp7TDi7MsR+ASZNpxMe8SuuEkMfotZVv+LvP9mdPRcmhbSQm?=
 =?us-ascii?Q?qXDjv7uYzWQMi0S1zax9DWYIYW4xo+Wgah7Pih7rQEFXBzCz0tmP3Tk5gtOi?=
 =?us-ascii?Q?oiebqfhpx+e0+WWm4mZFwRM05+/DAEd/d9WwDVnpX4zmARtHhf1qm3Z5L24r?=
 =?us-ascii?Q?4IQKp8sgVrHVFrSxlGHF6usmU5aeE7jaB1Zz3sWDZ3TOdbLv26W1Dj3WOw7U?=
 =?us-ascii?Q?/eoxADOUmL4FriDVWiBn6BsUhAzw/0iYHqAu9CD47nKDw8ABTBluRYNZ7FIq?=
 =?us-ascii?Q?TRAI4ICFK6q765BdzoUdli93piyBy8O5TfmDoZkxXbjto9ThurFgHNHvvYuq?=
 =?us-ascii?Q?1LzkoMZQn0bzQYkSFiVvo+/uAyCYFun6W+7dQqGriVJYxeqhLpHJIWP0e6DC?=
 =?us-ascii?Q?uuHYW/XPpVjEFSz4YlZGD/GNZqnA+PzAmwMCeE8UYSdWDayo/KRkqiu97aho?=
 =?us-ascii?Q?eqWXDFc++3/vy7QR9OJ8g8o6xdEtcrOOMqITyY+gkTJBosQaAnnGEIZS3eWw?=
 =?us-ascii?Q?dIAvhwTWLgiBciN1kE7YSyadnW2XlNKemYv0EgLlNCJ1uxzKMDr4Bc4eDew0?=
 =?us-ascii?Q?JnYNvbdulO6Wy726zXArTXvGEfFru+mjXfTUR1OwiBXSGOsI7/xx5qH5fFyL?=
 =?us-ascii?Q?4P1wuXaXtBHPKfw6cdIVk30w5zCddpEFrTkjKrQP8cP50pURWYnOlpu6mqBz?=
 =?us-ascii?Q?IK46IRqtNl+51mo7q5XWtdxp8QTI8cw1mQYkikpTwJnN99NygVai+YsRY3y7?=
 =?us-ascii?Q?VHvB0GTYDvXTEGmbDjZuz6pDFhrRHMjK/ttiNgAmXi5vn/jfv1s8iZJNyou8?=
 =?us-ascii?Q?EYWdTxq6T8fogQH0Mv7fydvPhWTjVonNtx5Y/XQ0iAvC4q08AMbvWexOlNE9?=
 =?us-ascii?Q?zN15ntUwp18+hOsAWLIzM1Y+vf6RG+CKQPisDUyTP49E0mbcIMSfZTKIGU3U?=
 =?us-ascii?Q?C8gHIfKEOBLum5dfel5Q4PjDse2Xu5Duu3jVQWidgQRJKFrCzwpXz2SaGSnI?=
 =?us-ascii?Q?Yxt46qB5VFIUTSCjKoZI/UhzZGMVpg9N1NhkpakFj41cCo+VkJwd7UMbYjYD?=
 =?us-ascii?Q?XWzCWkS1pi2MOaDRNOgoGjQ6j1ZBCtTPFVUJUL2I4tTld2N/q1VYnBKwlpjj?=
 =?us-ascii?Q?EpMEFDExrz48d50jh3vW6e/RfRVOvcIZm3z7ZQJNr0d4J/qzoncbNf3M3Dcd?=
 =?us-ascii?Q?1xDF4PSfOnwnjKNbzsIHRJ1S8imdDDZ2W4+93IyRFNFo1tWEvpJLC86PFvrx?=
 =?us-ascii?Q?yzQ4Hd9YrgZsj9THwyhMzvF5RhkH4mLsyPti8fduuSLo0OfrqTS5SndH0ju8?=
 =?us-ascii?Q?u07Jh/3iZpfsi7vUjnC2KShXUnQAeE9NSOtqXyD3IlZefefXu+T/F8XdNR6G?=
 =?us-ascii?Q?7fvtvy2y2RjsYJ0cCT8gs56KgHDkhrQIjBoJsOUWKP5VPzq8dEl8WmgcbW2V?=
 =?us-ascii?Q?8bJJ51d/2Cl0xx6xSNaqK0psqg4cC1FkBwEw0a002LRE8/ZtjX1q/Wya5G9C?=
 =?us-ascii?Q?ARivbWzABJXdO+CHujafHJ8EbgkQ681YqCiGGwy2pl6bns1gTlcIX+u6Py/j?=
 =?us-ascii?Q?QRrEC4Xpv398pC6NOetMsUiBF8bISqoqWRS47x9HqNABHSQlNdCApY2jlL6O?=
 =?us-ascii?Q?dDCoPqWhw8S1mSmGyUqD+p+KoxCPUTM=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fa00fb-7431-4332-5b0a-08da3d79d0b1
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:42.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFAAefCeV1xjxG1ituUNi6wun4QPP7KY6L3bHh5+2ZvfLUbYUmDYkL5CDaRC23/UrtUq3mxi8G2PG8Rc+jjRsQ==
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
 drivers/net/wireless/celeno/cl8k/calib.h | 390 +++++++++++++++++++++++
 1 file changed, 390 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/calib.h

diff --git a/drivers/net/wireless/celeno/cl8k/calib.h b/drivers/net/wireless/celeno/cl8k/calib.h
new file mode 100644
index 000000000000..6eb286392dd6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/calib.h
@@ -0,0 +1,390 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_CALIB_H
+#define CL_CALIB_H
+
+#include <linux/workqueue.h>
+#include <net/cfg80211.h>
+
+#include "def.h"
+
+#define DCOC_LNA_GAIN_NUM     8
+#define MAX_SX                2
+#define IQ_NUM_TONES_REQ      8
+#define IQ_NUM_TONES_CFM      (2 * IQ_NUM_TONES_REQ)
+#define SINGLETONS_MAX_NUM    1
+#define LOOPS_MAX_NUM         (2 + SINGLETONS_MAX_NUM) /* 1: pre,2-11:singletone,12:post */
+#define SX_FREQ_OFFSET_Q2     5
+
+enum calib_cfm_id_type {
+	CALIB_CFM_DCOC,
+	CALIB_CFM_IQ,
+	CALIB_CFM_MAX
+};
+
+enum calib_channel_idx_24g {
+	CALIB_CHAN_24G_1,
+	CALIB_CHAN_24G_6,
+	CALIB_CHAN_24G_11,
+	CALIB_CHAN_24G_MAX,
+};
+
+enum calib_channel_idx_5g {
+	CALIB_CHAN_5G_36,
+	CALIB_CHAN_5G_40,
+	CALIB_CHAN_5G_44,
+	CALIB_CHAN_5G_48,
+	CALIB_CHAN_5G_52,
+	CALIB_CHAN_5G_56,
+	CALIB_CHAN_5G_60,
+	CALIB_CHAN_5G_64,
+	CALIB_CHAN_5G_100,
+	CALIB_CHAN_5G_104,
+	CALIB_CHAN_5G_108,
+	CALIB_CHAN_5G_112,
+	CALIB_CHAN_5G_116,
+	CALIB_CHAN_5G_120,
+	CALIB_CHAN_5G_124,
+	CALIB_CHAN_5G_128,
+	CALIB_CHAN_5G_132,
+	CALIB_CHAN_5G_136,
+	CALIB_CHAN_5G_140,
+	CALIB_CHAN_5G_144,
+	CALIB_CHAN_5G_149,
+	CALIB_CHAN_5G_153,
+	CALIB_CHAN_5G_157,
+	CALIB_CHAN_5G_161,
+	CALIB_CHAN_5G_165,
+	CALIB_CHAN_5G_MAX
+};
+
+enum calib_channel_idx_6g {
+	CALIB_CHAN_6G_1,
+	CALIB_CHAN_6G_5,
+	CALIB_CHAN_6G_9,
+	CALIB_CHAN_6G_13,
+	CALIB_CHAN_6G_17,
+	CALIB_CHAN_6G_21,
+	CALIB_CHAN_6G_25,
+	CALIB_CHAN_6G_29,
+	CALIB_CHAN_6G_33,
+	CALIB_CHAN_6G_37,
+	CALIB_CHAN_6G_41,
+	CALIB_CHAN_6G_45,
+	CALIB_CHAN_6G_49,
+	CALIB_CHAN_6G_53,
+	CALIB_CHAN_6G_57,
+	CALIB_CHAN_6G_61,
+	CALIB_CHAN_6G_65,
+	CALIB_CHAN_6G_69,
+	CALIB_CHAN_6G_73,
+	CALIB_CHAN_6G_77,
+	CALIB_CHAN_6G_81,
+	CALIB_CHAN_6G_85,
+	CALIB_CHAN_6G_89,
+	CALIB_CHAN_6G_93,
+	CALIB_CHAN_6G_97,
+	CALIB_CHAN_6G_101,
+	CALIB_CHAN_6G_105,
+	CALIB_CHAN_6G_109,
+	CALIB_CHAN_6G_113,
+	CALIB_CHAN_6G_117,
+	CALIB_CHAN_6G_121,
+	CALIB_CHAN_6G_125,
+	CALIB_CHAN_6G_129,
+	CALIB_CHAN_6G_133,
+	CALIB_CHAN_6G_137,
+	CALIB_CHAN_6G_141,
+	CALIB_CHAN_6G_145,
+	CALIB_CHAN_6G_149,
+	CALIB_CHAN_6G_153,
+	CALIB_CHAN_6G_157,
+	CALIB_CHAN_6G_161,
+	CALIB_CHAN_6G_165,
+	CALIB_CHAN_6G_169,
+	CALIB_CHAN_6G_173,
+	CALIB_CHAN_6G_177,
+	CALIB_CHAN_6G_181,
+	CALIB_CHAN_6G_185,
+	CALIB_CHAN_6G_189,
+	CALIB_CHAN_6G_193,
+	CALIB_CHAN_6G_197,
+	CALIB_CHAN_6G_201,
+	CALIB_CHAN_6G_205,
+	CALIB_CHAN_6G_209,
+	CALIB_CHAN_6G_213,
+	CALIB_CHAN_6G_217,
+	CALIB_CHAN_6G_221,
+	CALIB_CHAN_6G_225,
+	CALIB_CHAN_6G_229,
+	CALIB_CHAN_6G_233,
+	CALIB_CHAN_6G_MAX,
+};
+
+/* MAX(CALIB_CHAN_24G_MAX, CALIB_CHAN_5G_MAX, CALIB_CHAN_6G_MAX) */
+#define CALIB_CHAN_MAX CALIB_CHAN_6G_MAX
+
+struct cl_dcoc_calib {
+	s8 i;
+	s8 q;
+};
+
+struct cl_dcoc_report {
+	__le16 i_dc;
+	__le16 i_iterations;
+	__le16 q_dc;
+	__le16 q_iterations;
+};
+
+struct cl_iq_report {
+	u8 status;
+	__le16 amplitude_mismatch[IQ_NUM_TONES_CFM];
+	__le16 phase_mismatch[IQ_NUM_TONES_CFM];
+	s8 ir_db[LOOPS_MAX_NUM][IQ_NUM_TONES_CFM];
+	s8 ir_db_avg_post;
+};
+
+struct cl_iq_calib {
+	__le32 coef0;
+	__le32 coef1;
+	__le32 coef2;
+	__le32 gain;
+};
+
+struct cl_lolc_report {
+	u8 status;
+	u8 n_iter;
+	__le16 lolc_qual;
+};
+
+struct cl_gain_report {
+	u8 status;
+	u8 rx_gain;
+	u8 tx_gain;
+	u8 gain_quality;
+	__le16 final_p2p;
+	__le16 initial_p2p;
+};
+
+struct cl_iq_dcoc_conf {
+	bool dcoc_calib_needed[TCV_MAX];
+	u8 dcoc_file_num_ant[TCV_MAX];
+	bool iq_calib_needed;
+	u8 iq_file_num_ant[TCV_MAX];
+	bool force_calib;
+};
+
+struct cl_iq_dcoc_info {
+	struct cl_dcoc_calib dcoc[DCOC_LNA_GAIN_NUM][MAX_ANTENNAS];
+	struct cl_iq_calib iq_tx[MAX_ANTENNAS];
+	__le32 iq_tx_lolc[MAX_ANTENNAS];
+	struct cl_iq_calib iq_rx[MAX_ANTENNAS];
+};
+
+struct cl_iq_dcoc_report {
+	struct cl_dcoc_report dcoc[DCOC_LNA_GAIN_NUM][MAX_ANTENNAS];
+	struct cl_gain_report gain_tx[MAX_ANTENNAS];
+	struct cl_gain_report gain_rx[MAX_ANTENNAS];
+	struct cl_lolc_report lolc_report[MAX_ANTENNAS];
+	struct cl_iq_report iq_tx[MAX_ANTENNAS];
+	struct cl_iq_report iq_rx[MAX_ANTENNAS];
+};
+
+struct calib_cfm {
+	u8 status;
+	__le16 raw_bits_data_0;
+	__le16 raw_bits_data_1;
+};
+
+struct cl_iq_dcoc_data {
+	struct cl_iq_dcoc_info iq_dcoc_db;
+	struct cl_iq_dcoc_report report;
+	struct calib_cfm dcoc_iq_cfm[CALIB_CFM_MAX];
+};
+
+struct cl_iq_dcoc_data_info {
+	struct cl_iq_dcoc_data *iq_dcoc_data;
+	u32 dma_addr;
+};
+
+struct cl_calib_params {
+	u8 mode;
+	bool first_channel;
+	s8 sx_freq_offset_mhz;
+	u32 plan_bitmap;
+};
+
+struct cl_calib_work {
+	struct work_struct ws;
+	struct cl_hw *cl_hw;
+};
+
+struct cl_calib_chain {
+	u8 pair;
+	u8 initial_tx_gain;
+	u8 initial_rx_gain;
+};
+
+enum cl_calib_flags {
+	CALIB_FLAG_CREATE = 1 << 0,
+	CALIB_FLAG_VERSION = 1 << 1,
+	CALIB_FLAG_TITLE = 1 << 2,
+	CALIB_FLAG_HEADER_TCV0 = 1 << 3,
+	CALIB_FLAG_HEADER_TCV1 = 1 << 4,
+
+	CALIB_FLAG_HEADER_TCV01 = (CALIB_FLAG_HEADER_TCV0 |
+				   CALIB_FLAG_HEADER_TCV1),
+	CALIB_FLAG_ALL_REPORT = (CALIB_FLAG_CREATE |
+				 CALIB_FLAG_VERSION |
+				 CALIB_FLAG_TITLE),
+	CALIB_FLAG_ALL = (CALIB_FLAG_CREATE |
+			  CALIB_FLAG_VERSION |
+			  CALIB_FLAG_TITLE |
+			  CALIB_FLAG_HEADER_TCV0 |
+			  CALIB_FLAG_HEADER_TCV1)
+};
+
+struct cl_calib_file_flags {
+	u8 dcoc;
+	u8 dcoc_report;
+	u8 lolc;
+	u8 lolc_report;
+	u8 iq_tx;
+	u8 iq_tx_report;
+	u8 iq_rx;
+	u8 iq_rx_report;
+	u8 rx_gain_report;
+	bool iq_plan;
+};
+
+struct cl_calib_errors {
+	u16 dcoc;
+	u16 lolc;
+	u16 iq_tx;
+	u16 iq_rx;
+};
+
+struct cl_calib_db {
+	struct cl_dcoc_calib
+		dcoc[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_SX][MAX_ANTENNAS][DCOC_LNA_GAIN_NUM];
+	u32 iq_tx_lolc[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_SX][MAX_ANTENNAS];
+	struct cl_iq_calib iq_tx[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_SX][MAX_ANTENNAS];
+	struct cl_iq_calib iq_rx[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX][MAX_SX][MAX_ANTENNAS];
+	struct cl_calib_file_flags file_flags;
+	struct cl_calib_errors errors[TCV_MAX];
+	struct list_head plan[TCV_MAX][CALIB_CHAN_MAX][CHNL_BW_MAX];
+	bool is_plan_initialized;
+};
+
+#define SET_PHY_DATA_FLAGS_DCOC       0x1 /* Set DCOC calibration data.*/
+#define SET_PHY_DATA_FLAGS_IQ_TX      0x2 /* Set IQ Tx calibration data.*/
+#define SET_PHY_DATA_FLAGS_IQ_RX      0x4 /* Set IQ Rx calibration data.*/
+#define SET_PHY_DATA_FLAGS_IQ_TX_LOLC 0x8 /* Set IQ Tx LOLC calibration data.*/
+#define SET_PHY_DATA_FLAGS_ALL ( \
+	SET_PHY_DATA_FLAGS_DCOC | \
+	SET_PHY_DATA_FLAGS_IQ_TX | \
+	SET_PHY_DATA_FLAGS_IQ_RX | \
+	SET_PHY_DATA_FLAGS_IQ_TX_LOLC)
+#define SET_PHY_DATA_FLAGS_LISTENER ( \
+	SET_PHY_DATA_FLAGS_DCOC | \
+	SET_PHY_DATA_FLAGS_IQ_RX)
+
+#define CL_CALIB_PARAMS_DEFAULT_STRUCT \
+	((struct cl_calib_params){SET_CHANNEL_MODE_OPERETIONAL, false, 0, 0})
+
+#define CALIB_CHAN_5G_PLAN 6
+#define CALIB_CHAN_6G_PLAN 15
+
+struct cl_chip;
+
+void cl_calib_dcoc_init_calibration(struct cl_hw *cl_hw);
+u8 cl_calib_dcoc_channel_bw_to_idx(struct cl_hw *cl_hw, u8 channel, u8 bw);
+void cl_calib_dcoc_fill_data(struct cl_hw *cl_hw, struct cl_iq_dcoc_info *iq_dcoc_db);
+u8 cl_calib_dcoc_tcv_channel_to_idx(struct cl_chip *chip, u8 tcv_idx, u8 channel, u8 bw);
+void cl_calib_dcoc_handle_set_channel_cfm(struct cl_hw *cl_hw, bool first_channel);
+void cl_calib_common_start_work(struct cl_hw *cl_hw);
+void cl_calib_common_fill_phy_data(struct cl_hw *cl_hw, struct cl_iq_dcoc_info *iq_dcoc_db,
+				   u8 flags);
+int cl_calib_common_tables_alloc(struct cl_hw *cl_hw);
+void cl_calib_common_tables_free(struct cl_hw *cl_hw);
+int cl_calib_common_handle_set_channel_cfm(struct cl_hw *cl_hw,
+					   struct cl_calib_params calib_params);
+int cl_calib_common_check_errors(struct cl_hw *cl_hw);
+s16 cl_calib_common_get_temperature(struct cl_hw *cl_hw, u8 cfm_type);
+
+/* Calibration constants */
+#define CALIB_TX_GAIN_DEFAULT        (0x75)
+#define GAIN_SLEEVE_TRSHLD_DEFAULT   (2)
+#define CALIB_NCO_AMP_DEFAULT        (-10)
+#define CALIB_NCO_FREQ_DEFAULT       (16)       /* 5M/312.5K for LO & RGC */
+#define LO_P_THRESH                  (1000000)
+#define N_SAMPLES_EXP_LOLC           (13)
+#define N_SAMPLES_EXP_IQC            (13)
+#define N_BIT_FIR_SCALE              (11)
+#define N_BIT_AMP_SCALE              (10)
+#define N_BIT_PHASE_SCALE            (10)
+#define GP_RAD_TRSHLD_DEFAULT        (1144) /* Represents 1 degree in Q(16,16): 1*(pi/180) */
+#define GA_LIN_UPPER_TRSHLD_DEFAULT  (66295) /* Represents 0.1 db in Q(16,16): 10^( 0.1/20)*2^16 */
+#define GA_LIN_LOWER_TRSHLD_DEFAULT  (64786) /* Represents -0.1 db in Q(16,16): 10^(-0.1/20)*2^16 */
+#define COMP_FILTER_LEN_DEFAULT      (9)
+#define SINGLETONS_NUM_DEFAULT       (10) /* Set to SINGLETONS_MAX_NUM for now */
+#define IQ_POST_IDX                  (LOOPS_MAX_NUM - 1)
+#define RAMPUP_TIME                  (50)
+#define LO_COARSE_STEP               (20)
+#define LO_FINE_STEP                 (1)
+
+#define DCOC_MAX_VGA                      0x14
+#define CALIB_RX_GAIN_DEFAULT             0x83
+#define CALIB_RX_GAIN_UPPER_LIMIT         0x14
+#define CALIB_RX_GAIN_LOWER_LIMIT         0x0
+#define DCOC_MAX_VGA_ATHOS                0x1E
+#define CALIB_RX_GAIN_DEFAULT_ATHOS       0x8D
+#define CALIB_RX_GAIN_UPPER_LIMIT_ATHOS   0x1E
+#define CALIB_RX_GAIN_LOWER_LIMIT_ATHOS   0x0A
+#define DCOC_MAX_VGA_ATHOS_B              0x14
+#define CALIB_RX_GAIN_DEFAULT_ATHOS_B     0x81
+#define CALIB_RX_GAIN_UPPER_LIMIT_ATHOS_B 0x14
+#define CALIB_RX_GAIN_LOWER_LIMIT_ATHOS_B 0x0
+
+struct cl_calib_iq_restore {
+	u8 bw;
+	u32 primary;
+	u32 center;
+	u8 channel;
+};
+
+bool cl_calib_iq_calibration_needed(struct cl_hw *cl_hw);
+void cl_calib_iq_file_flags_clear(struct cl_chip *chip);
+void cl_calib_iq_file_flags_set(struct cl_chip *chip);
+int cl_calib_iq_post_read_actions(struct cl_chip *chip, char *buf);
+void cl_calib_iq_init_calibration(struct cl_hw *cl_hw);
+void cl_calib_iq_fill_data(struct cl_hw *cl_hw, struct cl_iq_calib *iq_data,
+			   struct cl_iq_calib *iq_chip_data);
+void cl_calib_iq_lolc_fill_data(struct cl_hw *cl_hw, __le32 *iq_lolc);
+void cl_calib_iq_handle_set_channel_cfm(struct cl_hw *cl_hw, u8 plan_bitmap);
+void cl_calib_iq_lolc_handle_set_channel_cfm(struct cl_hw *cl_hw, u8 plan_bitmap);
+int cl_calib_iq_lolc_write_version(struct cl_hw *cl_hw);
+int cl_calib_iq_lolc_report_write_version(struct cl_hw *cl_hw);
+int cl_calib_iq_lolc_write_file(struct cl_hw *cl_hw, s32 *params);
+int cl_calib_iq_lolc_report_write_file(struct cl_hw *cl_hw, s32 *params);
+void cl_calib_iq_get_tone_vector(struct cl_hw *cl_hw, __le16 *tone_vector);
+void cl_calib_iq_init_production(struct cl_hw *cl_hw);
+int cl_calib_iq_set_idle(struct cl_hw *cl_hw, bool idle);
+void cl_calib_restore_channel(struct cl_hw *cl_hw, struct cl_calib_iq_restore *iq_restore);
+void cl_calib_save_channel(struct cl_hw *cl_hw, struct cl_calib_iq_restore *iq_restore);
+
+#define UNCALIBRATED_POWER        15
+#define UNCALIBRATED_POWER_OFFSET 0
+#define UNCALIBRATED_TEMPERATURE  35
+
+struct point;
+void cl_calib_power_read(struct cl_hw *cl_hw);
+void cl_calib_power_offset_fill(struct cl_hw *cl_hw, u8 channel,
+				u8 bw, u8 offset[MAX_ANTENNAS]);
+int cl_calib_runtime_and_switch_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 primary,
+					u32 center);
+void cl_calib_runtime_work(struct cl_hw *cl_hw, u32 channel, u8 bw, u16 primary, u16 center);
+bool cl_calib_runtime_is_allowed(struct cl_hw *cl_hw);
+
+#endif /* CL_CALIB_H */
-- 
2.36.1

