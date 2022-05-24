Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9871F532942
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiEXLiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbiEXLiW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E393A8CCFA
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PD8jMwQNzL9+2gtbjbhbivYtQc7yQ0rfinnmBuYi0SNq2vxH/hU7xlo4WYqo0efVxx/5WstyfZvqRzJ6XHN+TrmoB2tVndtxV5CgLM3k9nev1cALylmcf8coqO6gdk1bx3v6aordPBEvSS1sadgwWr9cCbxrahSlpPM1ICRSNSkuDP5fIMldZGMXWNFjVBU3xJVTJJ4Vu/MDHHDaRU4r/i8TPefN2/RQULb0EJYT24kUUyczXilD/IP/yGMme87q0a2cuC3YrrHVJvfOL8Zo3+Rdg6yz5AgS+G0b9c6tM4Jw2TZbwtJBMTcyOZh7F63VQtQMN5/W0nb8kxkvlV5NLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBCIt1tSUmwdibKNmYe31vXFjwWKkqpJIcJ9Q5hqVYg=;
 b=QmHQ5EkXIDJou8Ej8N/1KrZq6jkjQonSj9qgT3mJ+lgkdB8zi7+FHhhgi4a6wYvDowXfSy2/HXsfOQ8zEeWk1MYA1UsJQESTWx6wWhd6FqpFnweu/2u2bOjudw77IJEUg4cq/y7D1LvPTiq4JUTvs4WNyP1imbmY/FH3rSQit6hF8CDXmHWu+9mTlmcZi73MQZTcrdqMNbrszG7jr0H9GS12QKnABENEwNh/O8rjWMKeHMmjpeiTLtRUIYS8U7gJ06mSQIyj3ig/Opf2UCoUWJ9+iv0xjP/brdlIYC39gnHkB6cJMscWVdS5OXKFJPomDTmdXFv+x0kyumqMXly1oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBCIt1tSUmwdibKNmYe31vXFjwWKkqpJIcJ9Q5hqVYg=;
 b=3GfyLPrgwe4JUqAQMFvAryWg7u420aXG8AwjzoLs/cdBB++eXoCj8cHTO4IsmVc5cKl8YEuY5AvKIB65NRGexeA1BxRBfJ5Wi1FLkK3MVvZI+xhdUxTm4Cu8MD0mIvVZjDHk0XWEItl90iFREvJiEFt5w7RehZHC4WQxkZsODcw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:57 +0000
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
Subject: [RFC v2 19/96] cl8k: add def.h
Date:   Tue, 24 May 2022 14:33:45 +0300
Message-Id: <20220524113502.1094459-20-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4962d2fe-72ab-4973-11a3-08da3d79d8fd
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB0469863C7FFBD06DEBE397E4F6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qGo9LJm8i6JI2L8fAvwTwCrb9DNUObMOt6JwRey24LEjz/RJz7WwSuJ6LG13a/in8i4TSk705iCXqTX9tGlDLuSd6JGU88J564PzWn5S2sdTOlWf9i3RHDiDwJPe4HQ37ifPJMpWG3U16fGgxsFU4AIyElEpbMM+pJ5+2PI3dLuIDC/SAY5wUg+XWu9y/cZgDRJ8lO409JWz0JtHj+tukto03MhkBTNnSMgco+GZBbnrZSe/XkIo8OvoGmEum35RVSCQOm89wHFnxqbg9MSW1GDrjokMy1/G3j7ZojqIArI/SdWli7Oza1bgNZt/4b5RlPuYy00C8aMqyBwGI1euXvxLGJZUnZErsIRfPAXStFB1jl4UVJ9DLzN0zcRArHZAYG6ZLJyenoGBVqDz4CKhVFcb6uAM/Rhsc1n3NE493tcOW4sV+g8s+Rb9eqGJEMJoDoz/x0hca3R15HxIiUWYvso/MqzAwKFOHjr2nV5rphovS9JSXYGQAPT3lH79p+x34OtK6d2SIwauUcyrMZIlzjWVlG8KIud3ca5LXhZJjAYsh4y2vmGeG7wToF2DkYNCq4p1/RujgmBQv1WIUrLjp1rUjk+0sV2I3CcMkpriOm21mW7L84Vnd5UKWEo7nEKM9tgDnxMFtK//mfG2ujvg5vBenCB2Dz7cD5TbK4JFt7ICWu5FUPnm8qiQvgBvxWkmvThvRrbshhPhx7G4y0p4Da4kS5hIvbc/9v60Lda9ZGw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMaobklahK43RYwgLXHMjNIHhObFR6CTYWVL/L+1od725zzuymqyzs+OKe+h?=
 =?us-ascii?Q?FATx2+IRuc4rkrjhtAMeFn+niQ6bStYwSWPCcdFaXNOgAu2CZuXVXOnCnzWR?=
 =?us-ascii?Q?hUrQVolZlVuPQ3l8PErnwkXR3awYKaTiSMRxUvNMXO8nS5zodi80Uco26QTT?=
 =?us-ascii?Q?8n15BJnfXwPfqK59TGg60Xkq4YV/y1fp7PyhejJO4Q2Tw6rCzrIT8nMuILzS?=
 =?us-ascii?Q?woKlPysCaSjrwolBuUR5PSkCxASKBPWSULAUPDPTHe5hhI2MnQ3fs2cuoRrS?=
 =?us-ascii?Q?2XkQbujCsbADQONQCmP7r8Wr4AmIOHlJiI9gYMAiMEXbPeMp67LG200Z10Xg?=
 =?us-ascii?Q?j/hMIhfcItwRLyAKSf8coO2UN8j6ZTs1ha5gkmr1Rv7q0e77tjXnsIFvEOtW?=
 =?us-ascii?Q?Mk868leEjgVtqT6XQ6fXmCeTMjCOr+d+gxjOdKC2j0/8h0wj4f24fpyHYupt?=
 =?us-ascii?Q?VhSXdBwAAie0E+2zmmPzDI6BGVI7ronD8zZoGQzowukrmD1i9z4odLli9ofF?=
 =?us-ascii?Q?/ulHgNJhPvxd5CYSSR1Ya6spL65oXu6pRNKKZEAqST15huzI8i/KGA7wXg82?=
 =?us-ascii?Q?XZ8K5MT93gDq/WZsAfPOM3kHBI7WhC59sZVsU/h3/8f00m9XV5mgUMsBY3xg?=
 =?us-ascii?Q?eA/wJwMtbyF2bg3BKhCCH1bEi/r2KaRCKdcQE+7n+kh50+DTNYuoHSYgaPq+?=
 =?us-ascii?Q?aY1lzYrvx4VzXzmlfawY9mgtLLLo0Udc64rBCO49YwItLnZxwOZhMJM8JrUQ?=
 =?us-ascii?Q?wiOJCL3pMUokX20Da6eb2ICtQKehAjz7JIID0ineWNkIZIlheiUoG8NoR+fz?=
 =?us-ascii?Q?SM7vuo+Z0col+WhIMnA8LPhlYR7vYbGT0JQHWCWZAFGpA73Kl5Fo0tGsYaU7?=
 =?us-ascii?Q?kdsqSy0/8JeJl9XV+EUiahG8iXh+unQVOm2Iw7o2bj/c6mAQlru/n6yw2bi/?=
 =?us-ascii?Q?vNPYtZWsIcLrmNvh6Jb1YPSkqO2DmtcRm/W2I3v+OPnjzx+GYJGnr7ObnS3S?=
 =?us-ascii?Q?owbWkgr8XEuQNUdSXIKFmdy/ZZhwRXSQQ/QyUTQYsSKEDmZIP0DFu5nSxdnc?=
 =?us-ascii?Q?ZzV7IXZTufuhw18YPL5gluKZCH4YA+914egn7XHX/EXSmJPK2ZHzWle4uMrQ?=
 =?us-ascii?Q?aK4Q6MVoPA25aDtYsVmH/IDroEiLRPKurtx4eJ82crwESFzLruQfSxCVYkwf?=
 =?us-ascii?Q?HOgXoWH86xVnZOR5tcNwBR0IurxZOdNO0kxEPsfiT/fbyfGCspUWwW/jbFOc?=
 =?us-ascii?Q?H7HhleAjPLXtF9sbgEwNXqtD4Fi6EwiP04UIVhi9KA7s1VHCEzUxZiZdiHQA?=
 =?us-ascii?Q?5S1zpAta4hlGk+d58FlEMyX/S6D+gBAHMhI74rF0Iepwj2NFWJSiq5T3uhJ/?=
 =?us-ascii?Q?u8pU4AZ/UAUQMdQV33OvK+++/GHv7/FBbx+vJHdPd2t1ZI+MKqRhHCbAB1Ro?=
 =?us-ascii?Q?EVjHo4ZWj9HrWgXCbMGEBWgjITs7YlgUBXJGs1zgSfbb1XXBSOhVVO4tXY7W?=
 =?us-ascii?Q?t+DitDPVIvcsD22XnJ5WqO52QmSlDXPxJjM3x951e8y06e2vrocKtTrvHmOY?=
 =?us-ascii?Q?ZVAchsmQSYAbpmvX5nQqxv3LBNWbgDH3gXVAnNrcH3qtgA25Kch92dlu5KdK?=
 =?us-ascii?Q?8zcXPa/5SdjlDQXGbRnTHKiYPZlwjUUF4ZxUG0TKFxllX3p87e3nH8/TRo6j?=
 =?us-ascii?Q?NJlVzB2NRnLsg2YCRBfyGWGGkIjntdzJwLWwJ7SikmFJVHUWh8SSNe5eYJqJ?=
 =?us-ascii?Q?qGHJVr6jhWi/iuQGl3Dcp3yqqPkc+Rg=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4962d2fe-72ab-4973-11a3-08da3d79d8fd
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:56.9035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96Mdj1T8DX0kD/C3W08ZWLc8NUO/2EP5pZVYQ8OopfuWWkDlpMaKLApZEVDHc5i7ZElJxSVEuuKykjAEXGb7Bw==
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
 drivers/net/wireless/celeno/cl8k/def.h | 235 +++++++++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/def.h

diff --git a/drivers/net/wireless/celeno/cl8k/def.h b/drivers/net/wireless/celeno/cl8k/def.h
new file mode 100644
index 000000000000..24613836d263
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/def.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_DEF_H
+#define CL_DEF_H
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+#ifndef CONFIG_CL8K_VERSION
+#define CONFIG_CL8K_VERSION "8.0.0.0.0.0"
+#endif /* CONFIG_CL8K_VERSION */
+
+#define ASSERT_ERR(condition) \
+	do { \
+		if (unlikely(!(condition))) \
+			cl_dbg_err(cl_hw, ":ASSERT_ERR(" #condition ")\n"); \
+	} while (0)
+
+#define ASSERT_ERR_CHIP(condition) \
+	do { \
+		if (unlikely(!(condition))) \
+			cl_dbg_chip_err(chip, ":ASSERT_ERR(" #condition ")\n"); \
+	} while (0)
+
+#define msecs_round(ms) jiffies_to_msecs(msecs_to_jiffies(ms))
+
+/* Each chip supports two TCVs */
+#define TCV0            0
+#define TCV1            1
+#define TCV_MAX         2
+
+#define CHIP0    0
+#define CHIP1    1
+#define CHIP_MAX 2
+
+#define TCV_TOTAL (CHIP_MAX * TCV_MAX)
+
+enum cl_fw_band {
+	FW_BAND_2GHZ,
+	FW_BAND_5GHZ,
+	FW_BAND_6GHZ,
+
+	FW_BAND_MAX,
+};
+
+#define BAND_6G  6
+#define BAND_5G  5
+#define BAND_24G 24
+
+#define CL_VENDOR_ID 0x1d69
+
+#define CPU_MAX_NUM 8
+
+/* We support 128 stations and last station is assigned for high priority */
+#define CL_MAX_NUM_STA 128
+#define FW_MAX_NUM_STA (CL_MAX_NUM_STA + 1)
+
+#define MAX_SINGLE_QUEUES   (AC_MAX * FW_MAX_NUM_STA)
+#define HIGH_PRIORITY_QUEUE (MAX_SINGLE_QUEUES - 1)
+
+/* Must be aligned to NX_VIRT_DEV_MAX definition in rwnx_config.h */
+#define MAX_BSS_NUM 8
+#define BSS_INVALID_IDX 0xFF
+
+#define MAX_TX_SW_AMSDU_PACKET 15
+
+#define RX_MAX_MSDU_IN_AMSDU 128
+
+#define CL_PATH_MAX 200
+#define CL_FILENAME_MAX 100
+
+/* MAX/MIN number of antennas supported */
+#define MIN_ANTENNAS             1
+#define MAX_ANTENNAS             6
+#define MAX_ANTENNAS_OFDM_HT_VHT 4
+#define MAX_ANTENNAS_CCK         4
+#define MAX_ANTENNAS_CHIP        8
+
+#define MAX_ANTENNAS_CL808X          8
+#define MAX_ANTENNAS_CL806X          6
+#define MAX_ANTENNAS_CL804X          4
+#define MAX_ANTENNAS_WIRING_ID_27_31 3
+
+#define ANT_MASK(ant) (BIT(ant) - 1)
+
+/* 6GHz defines */
+#define HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_OFFSET 3
+#define HE_6GHZ_CAP_MAX_MPDU_LEN_OFFSET      6
+#define HE_6GHZ_CAP_MAX_AMPDU_LEN_FACTOR     13
+#define HE_6GHZ_CAP_MAX_AMPDU_LEN_EXP_MASK   0x38
+
+#define MHZ_TO_BW(mhz) ilog2((mhz) / 20)
+#define BW_TO_MHZ(bw)  ((1 << (bw)) * 20)
+#define BW_TO_KHZ(bw)  ((1 << (bw)) * 20000)
+
+#define CL_HWQ_BK  0
+#define CL_HWQ_BE  1
+#define CL_HWQ_VI  2
+#define CL_HWQ_VO  3
+#define CL_HWQ_BCN 4
+
+/* Traffic ID enumeration */
+enum {
+	TID_0,
+	TID_1,
+	TID_2,
+	TID_3,
+	TID_4,
+	TID_5,
+	TID_6,
+	TID_7,
+	TID_MAX
+};
+
+/* Access Category enumeration */
+enum {
+	AC_BK = 0,
+	AC_BE,
+	AC_VI,
+	AC_VO,
+	AC_MAX
+};
+
+enum cl_dev_flag {
+	CL_DEV_HW_RESTART,
+	CL_DEV_SW_RESTART,
+	CL_DEV_STOP_HW,
+	CL_DEV_STARTED,
+	CL_DEV_AP_STARTED,
+	CL_DEV_INIT,
+	CL_DEV_FW_SYNC,
+	CL_DEV_FW_ERROR,
+	CL_DEV_REPEATER,
+	CL_DEV_MESH_AP,
+	CL_DEV_RADAR_LISTEN
+};
+
+enum cl_hw_mode {
+	HW_MODE_A,
+	HW_MODE_B,
+	HW_MODE_G,
+	HW_MODE_BG,
+
+	HW_MODE_MAX,
+};
+
+enum cl_channel_bw {
+	CHNL_BW_20,
+	CHNL_BW_40,
+	CHNL_BW_80,
+	CHNL_BW_160,
+
+	CHNL_BW_MAX,
+};
+
+#define MU_UL_MAX 4
+
+#define CHNL_BW_MAX_HE   CHNL_BW_MAX
+#define CHNL_BW_MAX_VHT  CHNL_BW_MAX
+#define CHNL_BW_MAX_HT   CHNL_BW_80
+
+#define CHNL_BW_2_5 4
+#define CHNL_BW_5   5
+#define CHNL_BW_10  6
+
+#define MESH_BASIC_RATE_MAX 12
+
+enum cl_wireless_mode {
+	WIRELESS_MODE_LEGACY,
+	WIRELESS_MODE_HT,
+	WIRELESS_MODE_HT_VHT,
+	WIRELESS_MODE_HT_VHT_HE,
+	WIRELESS_MODE_HE
+};
+
+enum cl_ndp_tx_chains {
+	NDP_TX_PHY0 = 0x1,
+	NDP_TX_PHY1 = 0x2,
+	NDP_TX_PHY01 = 0x3,
+};
+
+#define Q2_TO_FREQ(x)    ((x) >> 2)
+#define FREQ_TO_Q2(freq) ((freq) << 2)
+
+/* Values of the firmware FORMATMOD fields */
+enum format_mode {
+	FORMATMOD_NON_HT = 0,
+	FORMATMOD_NON_HT_DUP_OFDM = 1,
+	FORMATMOD_HT_MF = 2,
+	FORMATMOD_HT_GF = 3,
+	FORMATMOD_VHT = 4,
+	FORMATMOD_HE_SU = 5,
+	FORMATMOD_HE_MU = 6,
+	FORMATMOD_HE_EXT = 7,
+	FORMATMOD_HE_TRIG = 8,
+	FORMATMOD_MAX = 9
+};
+
+/* PHY device options */
+enum {
+	PHY_DEV_OLYMPUS,  /* Olympus - 5g/24g */
+	PHY_DEV_ATHOS,    /* Athos - 6g , AthosB - 6g/5g */
+	PHY_DEV_DUMMY,    /* Dummy */
+	PHY_DEV_FRU,      /* Fake RF Unit */
+	PHY_DEV_LOOPBACK, /* RICU loopback mode */
+	PHY_DEV_MAX,
+};
+
+#define IS_REAL_PHY(chip) ((chip)->conf->ci_phy_dev <= PHY_DEV_ATHOS)
+
+#define riu_chain_for_each(_chain) \
+	for (_chain = cl_hw->first_riu_chain; _chain <= cl_hw->last_riu_chain; _chain++)
+
+#define CL_MU_OFDMA_MAX_STA_PER_GRP   8
+#define CL_MU_MIMO_MAX_STA_PER_GRP    4
+
+#if CL_MU_MIMO_MAX_STA_PER_GRP > CL_MU_OFDMA_MAX_STA_PER_GRP
+#define CL_MU_MAX_STA_PER_GROUP       CL_MU_MIMO_MAX_STA_PER_GRP
+#else
+#define CL_MU_MAX_STA_PER_GROUP       CL_MU_OFDMA_MAX_STA_PER_GRP
+#endif
+
+/* Max flags for driver status description is defined as 32 * MAX_CFM_FLAGS */
+#define MAX_CFM_FLAGS 2
+#define DELAY_HIST_SIZE 32
+
+#define STR_LEN_32B  32
+#define STR_LEN_64B  64
+#define STR_LEN_256B 256
+
+#define STA_HASH_SIZE 256
+#define STA_IDX_INVALID U8_MAX
+
+#endif /* CL_DEF_H */
-- 
2.36.1

