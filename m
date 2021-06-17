Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB393AB847
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhFQQGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:14 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:35841
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233628AbhFQQF7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:05:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLSxgqoQBUcIZe7pHvykRcKhZUjrE9fFV6x3aQjB9ICpsDZ3Z1/eM0uvELsICv6JjeC2P/wrPC5w6lGukj86KXhCx6A9lCHA17cP9oiUJXpJSM4m+GjZg5hdoYZh3/SjZCz3ERtntYls6SCazNi8EubAAo7G3d28M33vW9TYBvxsxuJ5LGZ8eiZ8YUgo12e1tI3eBZs/bFzZYxcPHzZ/LWLQmOclThHVJX6mfCDhziGWu1UkmaMPl5ADbp81i+klCy3Lp6kb/KKRDauvKdFiIX1WuKwU0GTFv5gLJebguJ7+/w2m8QDCIslNOYxbAaV9LFz2fnGBdZxW0SD+JW2sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjxJxYWeTO9AzPV+I2H63GPUn42pIIxw926KKfBV9cQ=;
 b=n5I1bZNj6hGB0wPM0AfolC8H1jOVWb06VYVcs+RB0EFm4BUtlPhgQ3epsfeLUb7fQdJZ1HwbNdmHZbREM5MSPMs8/mbjUf+3I+KYpJxri9WbcyV2iZfDx/ADWoFHhmp9/ZrxkbExhb0og6pOGKUhBTdjsG4eAITd3QiJ785KnED/waa8WZOXKs1YkJlPG2FxBZf0LdfYhGel+HedOgsg34K60PQLvB6wCGTM/ybsk50mGPKgMHP2+TAXDkhRqJ2sq92ma/4c+jjuTTkV7PArS8GshqrYlvtDi5sTm3G7+7A5zL/k1oDhe/rO4ac2TBCJG2ZoGGZqR/RRMUxPDoyRKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjxJxYWeTO9AzPV+I2H63GPUn42pIIxw926KKfBV9cQ=;
 b=Hw4K6e9eivmCNz9vFYEZsGs7gbXC9/IRPy/nhJ2t8GyyFIcBVE5IF2jnhrFOaSC4C2YLZqlXPESlLouVeapZ3XHoCEROEQ0C4Wvo2iYNZUwbEarFANGVA9miVpnBFenwCaDfGQ67eXqj+MWZ9NPzs+9Y5M9YvuPcw7iOgyH/ql8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:43 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:43 +0000
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
Subject: [RFC v1 047/256] cl8k: add config.h
Date:   Thu, 17 Jun 2021 15:58:54 +0000
Message-Id: <20210617160223.160998-48-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc676b62-26bd-4702-04b6-08d931a97046
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB049976CE8A4634FA777A4DDAF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:308;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bf5rwU07lfAxLnqGYsyNcZhfR6et74TXhKhzW8PdXES1T7w/X12f6nfamZXPx05dbDMuFzG9ieKMJzXmWKEWqew+f219l8pdzhbezh9oOb7nM2GTMwnImRlUyXr1yxyFX+JTCkzRWuA3r6lmX2UvI6GWklmfaIa8hyCscrovb2IsSCpxMG5U7PvsffhYcvjYeOPo00Ic7S2qe4hdlXgsMSZTFkC8Arlsc0OlWmRWyoiX+/a5fSWG9Bs7Ddd/de/qN7XMWhQhPO39jqKZMLh/mWHZrVno6c1HRclOah+q8s39bwGeBGZYZtTAvK9Lcf5lmJCwQ3gx9KY+Zw7ffzKlvxUQQLF10yTD0fm38FRqpa8YZTkzy+SQhsaUDkLYN8kI+p8PHzraHcETMB906UAdONYdoXlgGOcCcf33Sv6K6oiAOUe8RdumlthrvmzGG9umMNVBrH67qOLO4WS25LalSOt2KVy+jkp9wDlDaK8ttxeAl88Pu2CB2TmD2Xy3yUigE7xii2KyvYEVTIA5LQV0T+md/mEQQ5/jRSDNDBgAmKQLHohc8SAlRvgl1BxzM/pwsEbRy4io8eXkpy3eRqMNk0AL++HHx+cHyag1ocVZBvGQArp8uHInvVBq64BO7ax88aT/k7qdV1xty+YNFPtgkdBLkB357ogI/JjI79nDAWPEo4CXqkVME1DvK+SrULqIl9/mCzcoxUmIO/e3AAi7JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(30864003)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1/RlsE/nCdQRRPAcRD5VxVMpa5NYparW50GWsilvkX6TA/Mz7d7fet+ZYl9q?=
 =?us-ascii?Q?0y4fthQaQr6ye9ULKRh4wVdoZE624YcjxTuGBEC2k38bS6arRwgmVUpKQf85?=
 =?us-ascii?Q?aHvO+m2kILnr0K772zGkYHpgqaT3nOhdBhjdisVnvm4J6eLQYOE1WGIEG+Ok?=
 =?us-ascii?Q?YwNkCnSXknZafBHVUB+zcYtH0oPq2LoExZbONROEjD4xdiZZozW85wVzMHSG?=
 =?us-ascii?Q?0882rNuQUXr9iQ5zl0vb3UVeiA/i5ACUQrXnbjYIMOEH2V4O/QXl2/EOi4ki?=
 =?us-ascii?Q?cs8HuV+uLM9jra05Y858ByrPGS965AMYajiJ8ZkYVbWCYzvt6fBD9xJqXgee?=
 =?us-ascii?Q?xfUuvSHcP5OeFReGT8MvhB2AJRdzA2Sc2CY2XW14zf3/FYQBi2JpiRnMUPdu?=
 =?us-ascii?Q?VbkWunk3Ovs6qVBPM/b9sEAlWa43VU++12RjF+GDCFPFArNWRShAJqmEuUB0?=
 =?us-ascii?Q?qIXSecnOgtN3QlGl6k5rxxAVEuzv75IzfI5eVaiYM4Smi2uips6j91hyNf79?=
 =?us-ascii?Q?NQ98jDO4s1J9ZxKjhmhYlEt6frNxq5Jxghw2Srl3odkqAYpPuB6JtybOCy9z?=
 =?us-ascii?Q?eNuUaGXRAz5Ygysvyqnry8R2CpWPCeBOirwwNzgH/wkK3wshnrk/8G8g4GsV?=
 =?us-ascii?Q?9htGQ0MWlVh7/TnnCRa+EYZOjspyyg5iFbhVIMT2BAful37R4PleX6CQ/ZEu?=
 =?us-ascii?Q?wOVWuyXDT11rLKSnt79+ehLwj3mBWzZpNmJ8AP4jAoSEuAVtNsHhIZE0Ds2K?=
 =?us-ascii?Q?ohzIYBfsPz4/a2j5KMz/ZaoszOa6yZv7NpXWrjg3ThJanRyXCjZA7mjOHoP3?=
 =?us-ascii?Q?oFBvkXbOB7QJ5UTPKyQX3Amyt0VVgq5U7JKmajnCpcJOGMUOCPmm/e1WdSzP?=
 =?us-ascii?Q?2VDrh3QWGAAtv7x+F/hv+7CEAZl3ljfRMUUzWvihg4dJcRstBMcVhDd3SO4h?=
 =?us-ascii?Q?kumwQZdSTkyNFeCcw+W74d9plEOmMQmR5I860ZS7vHcH18BJZtrGqLC/khg8?=
 =?us-ascii?Q?To6MDj9VtYf3hkJVjnUyvhGCXnPYesbI0s/H8isYjuRSDXSQgj+yIygcqYtu?=
 =?us-ascii?Q?ucCH9U0rU5PmyOZgluGSvUZwqLewCNDIApL7+92XTFE6otyjXEGYKB7mxg1E?=
 =?us-ascii?Q?SZx9xbeWNIpGPlvhhiUl5Le5OUV9nFGUjZd57lPLVmyI4Ak5PV7LMgulDIpq?=
 =?us-ascii?Q?KYnCzxPSrnmJ84soYl1Vpw+QnKh2d4NCL7ucm0SleIAWokEV0HPlO6ES0/yD?=
 =?us-ascii?Q?4t0rJ0mmVP3BJr/DKemYCxjeJU8YLa7G9XQw478u5DHOhNWt51jye/Y9zgRw?=
 =?us-ascii?Q?SruMQ47XQsjtrGsUOaKx9mfM?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc676b62-26bd-4702-04b6-08d931a97046
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:25.4428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgBmCfqSv0cpz7OMrxL17bYUZimxi6eRFhFEV/0Y9vNFP9jEyLxQdJmg+qZN9oW3jdaAtalNnMDMXrmGbltICg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/config.h | 392 ++++++++++++++++++++++
 1 file changed, 392 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/config.h

diff --git a/drivers/net/wireless/celeno/cl8k/config.h b/drivers/net/wirele=
ss/celeno/cl8k/config.h
new file mode 100644
index 000000000000..7809b72b0f86
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/config.h
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_CONFIG_H
+#define CL_CONFIG_H
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include "vendor_cmd.h"
+
+#define MAX_PARAM_NAME_LENGTH 64
+
+#define PRINT_UNSIGNED_ARR(param, old_val, size, new_val) \
+do { \
+       u8 i; \
+       char buf[STR_LEN_256B]; \
+       int len =3D 0; \
+       len +=3D snprintf(buf, sizeof(buf), "%s: old value ", #param); \
+       for (i =3D 0; i < (size) - 1; i++) \
+               len +=3D snprintf(buf + len, sizeof(buf) - len, \
+                               "%u,", old_val[i]); \
+       len +=3D snprintf(buf + len, sizeof(buf) - len, \
+                       "%u --> new value %s\n", old_val[(size) - 1], new_v=
al); \
+       pr_debug("%s", buf); \
+} while (0)
+
+#define PRINT_SIGNED_ARR(param, old_val, size, new_val) \
+do { \
+       u8 i; \
+       char buf[STR_LEN_256B]; \
+       int len =3D 0; \
+       len +=3D snprintf(buf, sizeof(buf), "%s: old value ", #param); \
+       for (i =3D 0; i < (size) - 1; i++) \
+               len +=3D snprintf(buf + len, sizeof(buf) - len, \
+                               "%d,", old_val[i]); \
+       len +=3D snprintf(buf + len, sizeof(buf) - len, \
+                       "%d --> new value %s\n", old_val[(size) - 1], new_v=
al); \
+       pr_debug("%s", buf); \
+} while (0)
+
+#define READ_BOOL(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               bool new_val =3D false; \
+               if (kstrtobool(value, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %u -> new value %u\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_U8(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               u8 new_val =3D 0; \
+               if (kstrtou8(value, 0, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %u -> new value %u\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_U16(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               u16 new_val =3D 0; \
+               if (kstrtou16(value, 0, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %u -> new value %u\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_U32(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               u32 new_val =3D 0; \
+               if (kstrtou32(value, 0, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %u -> new value %u\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_S8(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               s8 new_val =3D 0; \
+               if (kstrtos8(value, 0, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %d -> new value %d\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_S16(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               s16 new_val =3D 0; \
+               if (kstrtos16(value, 0, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %d -> new value %d\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_S32(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               s32 new_val =3D 0; \
+               if (kstrtos32(value, 0, &new_val) !=3D 0) { \
+                       pr_err("%s: invalid value [%s]\n", #param, value); =
\
+                       return -1; \
+               } \
+               if (conf->param !=3D new_val) { \
+                       pr_debug("%s: old value %d -> new value %d\n", \
+                                #param, conf->param, new_val); \
+                       conf->param =3D new_val; \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_BOOL_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               bool old_val[size] =3D {false}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtobool_vector(value, conf->param, size, ",");=
 \
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_UNSIGNED_ARR(param, old_val, size, va=
lue); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_U8_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               u8 old_val[size] =3D {0}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtou8_vector(value, conf->param, size, ","); \
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_UNSIGNED_ARR(param, old_val, size, va=
lue); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_U16_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               u16 old_val[size] =3D {0}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtou16_vector(value, conf->param, size, ","); =
\
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_UNSIGNED_ARR(param, old_val, size, va=
lue); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_U32_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               u32 old_val[size] =3D {0}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtou32_vector(value, conf->param, size, ","); =
\
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_UNSIGNED_ARR(param, old_val, size, va=
lue); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_S8_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               s8 old_val[size] =3D {0}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtos8_vector(value, conf->param, size, ","); \
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_SIGNED_ARR(param, old_val, size, valu=
e); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_S16_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               s16 old_val[size] =3D {0}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtos16_vector(value, conf->param, size, ","); =
\
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_SIGNED_ARR(param, old_val, size, valu=
e); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_S32_ARR(param, size) \
+do { \
+       if (!strcmp(name, #param)) { \
+               int ret =3D 0; \
+               s32 old_val[size] =3D {0}; \
+               memcpy(old_val, conf->param, sizeof(old_val)); \
+               ret =3D cl_strtos32_vector(value, conf->param, size, ","); =
\
+               if (ret =3D=3D 0) { \
+                       if (memcmp(old_val, conf->param, sizeof(old_val))) =
\
+                               PRINT_SIGNED_ARR(param, old_val, size, valu=
e); \
+               } else if (ret =3D=3D -E2BIG) { \
+                       pr_err("%s: value [%s] too big [%zu]\n", #param, va=
lue, strlen(value)); \
+               } else if (ret =3D=3D -EIO) { \
+                       pr_err("%s: delimiter ',' not found\n", #param); \
+               } else if (ret =3D=3D -EINVAL) { \
+                       pr_err("%s: invalid argument [%s]\n", #param, value=
); \
+               } else if (ret =3D=3D -1) { \
+                       pr_err("%s: value [%s] doesn't have %u elements\n",=
 #param, value, size); \
+               } \
+               return ret; \
+       } \
+} while (0)
+
+#define READ_STR(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               if (strcmp(value, conf->param)) { \
+                       pr_debug("%s: old value %s -> new value %s\n", \
+                                #param, conf->param, value); \
+                       strncpy(conf->param, value, sizeof(conf->param) - 1=
); \
+               } \
+               return 0; \
+       } \
+} while (0)
+
+#define READ_MAC(param) \
+do { \
+       if (!strcmp(name, #param)) { \
+               u8 old_val[ETH_ALEN] =3D {0}; \
+               memcpy(old_val, conf->param, ETH_ALEN); \
+               if (cl_strtou8_hex_vector(value, conf->param, ETH_ALEN, ":"=
)) \
+                       return -1; \
+               if (memcmp(old_val, conf->param, sizeof(old_val))) \
+                       pr_debug("%s: old value %pM -> new value %pM\n", \
+                                #param, old_val, conf->param); \
+               return 0; \
+       } \
+} while (0)
+
+#define print_signed(var) \
+       pr_debug("%s =3D %d\n", #var, conf->var)
+
+#define print_unsigned(var) \
+       pr_debug("%s =3D %u\n", #var, conf->var)
+
+#define print_bool(var) \
+       pr_debug("%s =3D %s\n", #var, conf->var ? "true" : "false")
+
+#define print_str(var) \
+       pr_debug("%s =3D %s\n", #var, conf->var)
+
+#define print_mac(var) \
+       pr_debug("%s =3D %pM\n", #var, conf->var)
+
+#define print_hex(var) \
+       pr_debug("%s =3D 0x%x\n", #var, conf->var)
+
+#define print_signed_arr(var, size) \
+       { \
+               int i, len; \
+               char str[256] =3D {0}; \
+               len =3D snprintf(str, sizeof(str), "%s =3D ", #var); \
+               for (i =3D 0; i < (size); i++) \
+                       len +=3D snprintf(str + len, sizeof(str) - len, \
+                                       "%d%s", conf->var[i], (i < ((size) =
- 1)) ? "," : ""); \
+               pr_debug("%s\n", str); \
+       }
+
+#define print_unsigned_arr(var, size) \
+       { \
+               int i, len; \
+               char str[256] =3D {0}; \
+               len =3D snprintf(str, sizeof(str), "%s =3D ", #var); \
+               for (i =3D 0; i < (size); i++) \
+                       len +=3D snprintf(str + len, sizeof(str) - len, \
+                                       "%u%s", conf->var[i], (i < ((size) =
- 1)) ? "," : ""); \
+               pr_debug("%s\n", str); \
+       }
+
+struct cl_hw;
+
+bool cl_config_is_non_driver_param(char *name);
+int cl_config_cli(struct cl_hw *cl_hw, struct cli_params *cli_params);
+
+#endif /* CL_CONFIG_H */
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

