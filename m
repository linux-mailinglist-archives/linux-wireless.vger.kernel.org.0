Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7285C3AB858
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhFQQG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:56 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:9431
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232419AbhFQQGd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP4aCVlqxZmNK2yywF0/4c20Gj/T6+PBNZWKq+uGGvoF7J8sDZ7cBRVsIkJmKwKWNxQHyTA+o/yJZbhNxDFErixmm9LrmRuu3qJhEoXkzyxZpCwQ2/lVyJgQC5PvgVig8qLdWpjR8trPX09pyYPsG0bzdkBY2IYH+IlWaMC1psIt/W6vQ7+1QmeGIkWorwO2NWfd3ecyBaaWF8fFA10FZJM+cMk7yrn+RvKK9FH5Z+eni9KUZSEs+9CdvmqWfsuBUzyOlm2MckoainBKTqHtkBGEEdgU0KXxseTnaxB4cRYU91c09eaBmlAF3kpGmoccuqn01oHTQS/P7Sm9dW03BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe/OkZtnQwmc+xQK7xkES7QrdiJ8x3j18reeYdcovHA=;
 b=GtvpPXf+o9FBfrd3BdhKkDzxsGGbs6N7RUVBdwpTAFegDkMk1SU7UUR3VcXykp1ThZEIqc5RA0r/ctsYVltdUOVZrMMP8ze+Jx8tIn+ZbRljI1u2C6vq5PBevBaF86lQG9o4hy0ZZSkpxXSLZvKzV1d5i4b3bGQKOL1d2ykmwrRtaskR5r7p46BsFzxiGFXOqHEk5T/z6GIabl1gPKxQ+Q1X+cfY74bcKH92+daNwf0eGBAF40hNcRv1tKs+NuqBEmeaZE29WUNleEzI4W+wxrWinoRtU13TxN0T3wW0F8BPBgJZdkUxoKryB2/WQYQ11XCR4EQi4hL3+u6VDj2+Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oe/OkZtnQwmc+xQK7xkES7QrdiJ8x3j18reeYdcovHA=;
 b=n6Vxii8PykHiy2PLS75aKmyDb9zcdHoHTK1ZCMMb52JX+2+CHkAtLUTcXOu7n6mDSmLj1SwXZ2M5nL5Phnqq0r/vBcceblbB55kDJS5horL03pY1cheANgCqttdqZEgxhUvSv9sm7jQgJT74RuHO+PRljMBDPbbvgCiW60f3MFc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1268.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:3a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Thu, 17 Jun
 2021 16:04:19 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:04:19 +0000
From:   viktor.barna@celeno.com
To:     linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Aviad Brikman <aviad.brikman@celeno.com>,
        Eliav Farber <eliav.farber@gmail.com>,
        Oleksandr Savchenko <oleksandr.savchenko@celeno.com>,
        Shay Bar <shay.bar@celeno.com>,
        Viktor Barna <viktor.barna@celeno.com>
Subject: [RFC v1 061/256] cl8k: add dfs/dfs_db.h
Date:   Thu, 17 Jun 2021 15:59:08 +0000
Message-Id: <20210617160223.160998-62-viktor.barna@celeno.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210617160223.160998-1-viktor.barna@celeno.com>
References: <20210617160223.160998-1-viktor.barna@celeno.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [62.216.42.54]
X-ClientProxiedBy: PR3PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:102:b7::23) To AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:38b::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a5e3331-6d43-4553-477a-08d931a979b3
X-MS-TrafficTypeDiagnostic: AM9P192MB1268:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1268F96A30313C868B156BEBF60E9@AM9P192MB1268.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsMx0Uinqbby79ilE0DkbFbFkD1vWfDp2oomyrr8V5Ifz4aBke5j9p1PcH0QazVDgOlddKTDIeBEJ1RY16v6QdkFyXnPpDWkLvjMFqTlMxVN7XkQzeCm7Yip2MPX7LL3A0+dICzAjU9yiJluOByN/iDFAe962Fb6R8TTJDwjMHH/4VjzEUNJEnXqkwVd7u+SOsiCm9QDYcO673RnNmlE9vpaBRldXp0WtC4pYg72QmNNL26uo9qGKeDs2eM7wJTZHMoIeSYfUP6+AGbLNWjmWB87VDrDKYQV3iLy1XktcstItmLl4aeghQnA5fU/HAyhsC3H35Uw+2krlN+GeLd7RpeyAjFC6ZJ5xPdOywiQEKlOmrMoqIfgkuMzGSuAkXxCx4Zp4LD76ICgQnY2pqWL0lo/Hhz4EKPUDT40nllKZJsz+mGZ/gYuLQSB/FKr8IKPED0btJyqXkQAOzIFqIJUHXl2jWQLKDXlFbe5VOjjYmFUC1RwbySiQDLebLeUDlZHDGlskwBDtDVZf+DK+wvTWIkjq9vuwQhRGBRd2ZxlzEXXRyknVQ6jcKI1aN6zljpFuZv9p3H4PFNxiH6+EANewA04zLYt/Nv+AcSCVoYy4ecG9ZKekU4zPhN7Kgthb4qgfzbei9dWyF4XsyPPX9FKzaqg4rhYpc5CpwJrmrTzQHhTQqOV+m/9wjaIuaW0Q/p5Ug7+pfAnZDaLEpQzqaZz+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6486002)(956004)(54906003)(4326008)(2616005)(186003)(38100700002)(16526019)(8676002)(5660300002)(38350700002)(8936002)(26005)(2906002)(6512007)(9686003)(52116002)(83380400001)(6916009)(66946007)(66556008)(66476007)(86362001)(55236004)(498600001)(6666004)(6506007)(1076003)(107886003)(36756003)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jRQ74AMZMCkl0FxxmX5U0Ysew52eDoRmr/ygekQlNJCXRSD5g3a+7xYcWQgB?=
 =?us-ascii?Q?WjJPW5AoeEFgFYWRHM+kTDk2Ey+3kJxt0kyxlXvd6cxpCS+QX8SsObdY4QOP?=
 =?us-ascii?Q?cEzLXPz76JaV90adhDEGY7f67u++YsKLL/ZNaSxgvEgH0rZxJaMUmpHI/E+v?=
 =?us-ascii?Q?O2GvPqJRJUeRZoOwnj3BYXmTVheGhaKkcZtmBAsQudsvyL8ppisHKy0HSZhQ?=
 =?us-ascii?Q?ygp9IsOadsD1yUdVNA62Han304Lg6uozSBeuf5k25W/jrz28AYjGE/tjOCrf?=
 =?us-ascii?Q?10WT7Ha+lHpA6ZjvIyTBNyNdEsaAVTlixF3IcPabfrIkfDYplsVsCECsr9Jf?=
 =?us-ascii?Q?nTouOeAdt5YPFLm0GnCPaDN0cNBsh8A7B3WRZn5A9ipuheIOMr0sIY1dqaeb?=
 =?us-ascii?Q?veXdt/M6rQM7v5jz2H76FigohVlGGktrOo2h+sIhhjQ0ngb+AdXqFdo+UX4S?=
 =?us-ascii?Q?MF4GJxnsp2PTPUlCSjApiVFP/QsCb3vtn0UhGiQ8OnPElxNKvBPIP/IrtgrN?=
 =?us-ascii?Q?+g1Hs33NQF2TMn9rvccYMAzcCymwRS8Pan/1EytGX8rtOdr3CRrdhi3FtOsO?=
 =?us-ascii?Q?gPy3CxC+c73n/qSbTp3QYYmUGYUiAcUuL8ZhxVOU6lghqrbi/gfIpkPyAysy?=
 =?us-ascii?Q?pZuDiWge//jIbLpknT+zg1Wc7fbHl635NUxXd9dR7qs8dLfnjLhJ900v1Lfd?=
 =?us-ascii?Q?ZW28yGPOdNqg+BQQgB1UJf0DtIltNpaMhD5DCt1OCR+pTnri2MprFA+ivNkF?=
 =?us-ascii?Q?EBfpLFgh+31gQtkTpSuSXhYGxutiQsJNdQ9D8PfLAbOOwDF4yOy7lrPO/7m2?=
 =?us-ascii?Q?7fJ5KyYRKApzYnraicAO65l29xcJj1oRn1k7EDYIU6FXf8poIPKaNzGqY6K7?=
 =?us-ascii?Q?ZtJTFGsgkSdjSQ/jxopMft8421SiJycHeg/fsbf883JHBw+Zr2FSugB2oKl/?=
 =?us-ascii?Q?sCu+DQMy8SPUlWSzo4N8F5/U54gnxXhOChAXGWrPOwZ2p6Z7daC3fml5NDER?=
 =?us-ascii?Q?9mid2rly09k4g+zCgk49ZS9xXgDx2ezvpT26/xo3XY1UiSth4drVtwp8Tmtf?=
 =?us-ascii?Q?ZcPsnGbj5nuvzjS/yk1n+LDzk1rwOXTZpgnOsRqvCxKmYFUlyWyfjPZZdEz/?=
 =?us-ascii?Q?PvpzkMvwq8r3DI9N+KFH4A7R9WIzzhDDs/eDy7L8Mh39ycap7LYjMkJivbrG?=
 =?us-ascii?Q?VPkaWd9lvCCIplCiTl41EkggHxFhGQ7Rqt9GZ4FASeZHY7K0j+8ahStmbBcz?=
 =?us-ascii?Q?kaPZP1ptLhGomYKV5xf6MxZbktYLxntzbb64vI2W+tnKFlzRdLe+3LDeOTfQ?=
 =?us-ascii?Q?TlLoEM50vdFq7csTF6z8aPmZ?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a5e3331-6d43-4553-477a-08d931a979b3
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:41.2354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E3j+BW9Q9QeUeDlVky5UhapqQGQh751keF6g6EFM9btM2EHvQfxcgDAxufowvxQUPkfTe+40EZ7s9GDbzJQiyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1268
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dfs/dfs_db.h | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dfs/dfs_db.h

diff --git a/drivers/net/wireless/celeno/cl8k/dfs/dfs_db.h b/drivers/net/wi=
reless/celeno/cl8k/dfs/dfs_db.h
new file mode 100644
index 000000000000..43bb07cef00a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dfs/dfs_db.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DFS_DB_H
+#define CL_DFS_DB_H
+
+#include "dfs/radar.h"
+#include "utils/timer.h"
+
+#define CL_DFS_MAX_TBL_LINE       11    /* Radar Table Max Line */
+#define CL_DFS_MAX_PULSE          4     /* Max Pulses per Interrupt */
+#define CL_DFS_PULSE_BUF_SIZE     64    /* Radar Pulse buffer size */
+#define CL_DFS_PULSE_BUF_MASK     0x03F /* Radar Pulse buffer cyclic mask =
*/
+#define CL_DFS_PULSE_WINDOW       100   /* Radar Pulse search window [ms] =
*/
+#define CL_DFS_MIN_PULSE_TRIG     1     /* Minimum Pulse trigger num */
+#define CL_DFS_MAX_20MHZ_CH       25    /* Maximum 20MHz channels */
+#define CL_DFS_MIN_CH             52    /* Min DFS channel */
+#define CL_DFS_MAX_CH             144   /* Max DFS channel */
+#define CL_DFS_MIN_WEATHER_CH     120   /* Min DFS weather channel */
+#define CL_DFS_MAX_WEATHER_CH     128   /* Max DFS weather channel */
+#define CL_DFS_CAC_TIME           60    /* DFS CAC Time */
+#define CL_DFS_WEATHER_CAC_TIME   600   /* DFS weather channel CAC Time */
+#define CL_DFS_VALIDATION_TIME    1800  /* Validation time */
+#define CL_DFS_CE_CSA_CNT         10    /* According to CE regulation must=
 leave within 1 sec */
+#define CL_DFS_LONG_MIN_WIDTH     20    /* Min Long Pulse Width */
+#define CL_DFS_LONG_FALSE_WIDTH   10    /* Low width signals indicates of =
false detections */
+#define CL_DFS_LONG_FALSE_IND     6     /* False indication while searchin=
g for long sequence */
+#define CL_DFS_FCC_CSA_CNT        2     /* According to FCC regulation mus=
t leave within 200ms */
+#define CL_DFS_SAFE_WIDTH         10    /* False detection not expected fo=
r high width signals */
+#define CL_DFS_BUF_SIZE           128   /* Max buffer size for loading cha=
nnels DBs from NVRAM */
+#define CL_DFS_STAGGERED_CHEC_LEN 4     /* Staggered check length */
+#define CL_DFS_ONE_MINUTE         60    /* One minute [s] */
+#define CL_DFS_ONE_MINUTE_MS      60000 /* One minute [ms] */
+#define CL_DFS_ONE_SEC_MS         1000  /* One Second in [ms] */
+#define CL_DFS_THREE_SEC_MS       3000  /* Three Second in [ms] */
+#define CL_DFS_FIVE_SEC_MS        5000  /* Five Second in [ms] */
+#define CL_DFS_TEN_SEC_MS         10000 /* Twn Seconds in [ms] */
+#define CL_DFS_MIN_IDLE           10    /* Minimum consecutive idle decisi=
ons to start OCC */
+#define CL_DFS_CONCEAL_CNT        10     /* Maximum concealed pulses searc=
h */
+#define CL_DFS_FILTER_DELAY       100   /* Delay the decision by 100ms */
+#define CL_DFS_FILTER_PRI_MARGIN  10    /* PRI search margin */
+#define CL_DFS_LTP_PPB_MARGIN     2     /* Low TP PPB margin */
+#define CL_DFS_MAX_STAGGERED      3     /* Max Staggered patterns */
+
+enum cl_radar_waveform {
+       RADAR_WAVEFORM_SHORT,
+       RADAR_WAVEFORM_LONG,
+       RADAR_WAVEFORM_STAGGERED,
+       RADAR_WAVEFORM_SEVERE
+};
+
+struct cl_radar_type {
+       u8 id;
+       s32 min_width;
+       s32 max_width;
+       s32 tol_width;
+       s32 min_pri;
+       s32 max_pri;
+       s32 tol_pri;
+       s32 tol_freq;
+       u8 min_burst;
+       u8 ppb;
+       u8 trig_count;
+       enum cl_radar_waveform waveform;
+};
+
+struct cl_dfs_pulse {
+       s32 freq  : 8;      /* Radar Frequency offset [units of 4MHz] */
+       u32 fom   : 8;      /* Figure of Merit */
+       u32 width : 8;      /* Pulse Width [units of 2 micro sec] */
+       u32 occ   : 1;      /* OCC indication for Primary/Secondary channel=
 */
+       u32 res1  : 7;      /* Reserve */
+       u32 pri   : 16;     /* Pulse Repetition Frequency */
+       u32 res2  : 16;
+       unsigned long time; /* Pulse Receive Time */
+};
+
+struct cl_dfs_db {
+       bool en;
+
+       struct {
+               bool started;
+               bool requested;
+       } cac;
+
+       enum cl_dbg_level dbg_lvl;
+       enum cl_reg_standard dfs_standard;
+       struct cl_radar_type *radar_type;
+       u8 csa_cnt;
+
+       u8 min_pulse_eeq;
+       u8 buf_idx;
+       u8 radar_type_cnt;
+       u16 search_window;
+       u16 last_pri;
+       u16 max_interrupt_diff;
+       u32 pulse_cnt;
+       u32 severe_env_pulse_cnt;
+       struct cl_dfs_pulse dfs_pulse[CL_DFS_PULSE_BUF_SIZE];
+       struct cl_dfs_pulse pulse_buffer[CL_DFS_PULSE_BUF_SIZE];
+       u8 long_pulse_count;
+       u32 last_long_pulse_ts;
+       u8 short_pulse_count;
+       u8 long_pri_match_count;
+};
+
+#endif /* CL_DFS_DB_H */
--
2.30.0

________________________________
The information transmitted is intended only for the person or entity to wh=
ich it is addressed and may contain confidential and/or privileged material=
. Any retransmission, dissemination, copying or other use of, or taking of =
any action in reliance upon this information is prohibited. If you received=
 this in error, please contact the sender and delete the material from any =
computer. Nothing contained herein shall be deemed as a representation, war=
ranty or a commitment by Celeno. No warranties are expressed or implied, in=
cluding, but not limited to, any implied warranties of non-infringement, me=
rchantability and fitness for a particular purpose.
________________________________

