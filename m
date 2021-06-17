Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599393AB910
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFQQMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:12:14 -0400
Received: from mail-eopbgr30082.outbound.protection.outlook.com ([40.107.3.82]:58153
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233901AbhFQQLG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ngRKHYytTH8qQ9Nsx87kEGkQdv3SVGM6RwJTtE5WB3zTvFdQ4Wwx9Uhs0mir1qh0Ypv/BbU/hpBxJAWtAkBXyy8koaayl+2VdKDwg3lJ+ZXOWhYg9WQr0Xs3IZmJr2es1zcCanNBCxU7lYsZDzcXyRiGGyOMSmKdt00rP6BFiaPNOUeOWw+duO6yxD8Wuk2lm+VXsdFfbK8eKk3zhB+P+7yEWo/+OWcxYJgffWQ+xoKdQ9W2/pzzIMqyq7WS5z80MfjyqpzlCqwkjmBYSoTmVT33YaPt+56an8G/XHvbjyxs8r0vksIwm102gmYyYmJN4kEQ314Uo1ouKEPXiRZnrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqBCiGiNkEMI7C+1H4LMo7RnmDW5KH+Ea1KhexpGGOA=;
 b=JlcxU83/vUgeNVTfQ59hANz2CjpPTdjsO4pSJYIYNCur69sXa5BN7oVI3bYW3apuXayvJsFlck20o5wmaYO3d4E700Tb9nwvlWJwD/bbAm+6aRxAwqhK+DQtl5y8uK9LXGom0HvNBCJfjKdfndu4MrbHFYIsBOOrQbATq7FdZqsTIFsW2w4DHStE7ouCQTWyWo044H6ZzejYq1RsiEHcfZKQRRQFO5Mt7oGqgbXIgKn8CumvsgLvEomuchrCK1KsRiXk+jRSSBQPUZ5zw6UMzCVIWccHIgH0Rz07ftQPrf57/SxaAxSN8wAeLHrqkMKZVKufu71xuj3Bne61lZqncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqBCiGiNkEMI7C+1H4LMo7RnmDW5KH+Ea1KhexpGGOA=;
 b=1Hp8mA4+ujxahtf7aOi7sM2DaGpnSl8G8DUlJjwAqUTqov5pXSwlkZF7Mjfuo5yDuV58C+k4FwpE2lIXEEMa7771cuCY5e2i2m1dlakpsnZqXfmdfV1C1iIMCAvjCnR7rudXWijdRgpSdAl3ijngmRuidtX95Ohw6oMmElW871I=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0452.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Thu, 17 Jun
 2021 16:07:55 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:07:55 +0000
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
Subject: [RFC v1 225/256] cl8k: add utils/string.c
Date:   Thu, 17 Jun 2021 16:01:52 +0000
Message-Id: <20210617160223.160998-226-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:06:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4baeea58-73f4-4162-6801-08d931a9e78e
X-MS-TrafficTypeDiagnostic: AM0P192MB0452:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB045288CEB809CBDACD441221F60E9@AM0P192MB0452.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iJokDDTAKToEb0mgpUBviqOuIh68uvzYZLN9QhjoZt+IznD6fOncdT65rKy9+Q15doqVvw3/jjJ48fT+b5Ebt2QJofUVjTZKmMkordjd1VtTvAnuqBCikpUVXM1NTPfcEJwDmDDx1sJ2dsSLK03t/9UZOuaLrP9ezwyOPVqL4mTuH2+AS08ULUmdE0vNFqjUwzLrf+HM28ZndBVAzKA19Vmnc239qETLzz3KPnQdStkYK7uAIDthdfQbbKD57BpWuFI62k0yfEAaH7eelKmux7sSoR6UZw7ghaRWRBVVKDOFGImOgFn1ut3pEcPEqjEkFUN6g8M93ZZRBF8fneVJcWCO9RC8PEZ7GSHadtCGp3xe5K4kJPY3oRprXrXmeF1tfBt9txuYIs/Qqn3Sgvard/dvgEgFjVzQAmX8EglJ34kVjHagsKTe25qlu3sDZrsqybp65rJ7D5R2DK5w4qc0wEoH++tpyRrQF4IcdPK9e5BWGOwJQpDmQ4B7AzvAeJxu/mxP4jrmduCZhWMiHp3OlberVuZWtd1FSqlsQPXtLr84D2PCPnV4iFFTge76eiC5C/TUjQgu5qhyzpfVRSUg9vtG0iLz8fOoqTvHMc/H/TsHz4XKjter1sJsmous5v8AKudw44g/1qEaoSej3Fgj3FrTvqXASAppxnZ2JtH+J+VUvNh6mPnYRR9MYDl+uXLg1IXeQWxNkWCsP3SHP5T5Vg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(136003)(396003)(39850400004)(66946007)(66556008)(54906003)(9686003)(6512007)(16526019)(36756003)(107886003)(8676002)(66476007)(4326008)(26005)(316002)(6486002)(6666004)(8936002)(86362001)(186003)(1076003)(2906002)(2616005)(38100700002)(38350700002)(6916009)(956004)(55236004)(52116002)(508600001)(6506007)(5660300002)(83380400001)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wZ9X5iG4TwqsvtgWlOQEAlu4oT1OX5BqkVH2d1hey6qCrZSvq425aHgGXcXV?=
 =?us-ascii?Q?I1jkf2DO8bYbS4E8eGqXlu0aXAZMBuWcYsWufyMTbf5myxu+kMM0CyMwDhcO?=
 =?us-ascii?Q?mzCp4TheTcV3HHimzcRTqEwXs2VPdUn6ZxRGzqyZKwa+u58bGbcWtU/4Y3Ei?=
 =?us-ascii?Q?OaTZA07L9NX5bzJFjS3QluXjxmwmA3Xg7vMVw7zvWax+SQvVQL9zWIq85Qc/?=
 =?us-ascii?Q?Q2r1oQ7ZNQbmrOqPIi6c7QIJeeS2uVIfGdxpIpVBLzP/vrgBZDAAxj9Ho1UG?=
 =?us-ascii?Q?RqG/sZOPVEqsSYxP/IDHC9JcrA1DQXSvwZYHo3DGNSsWEE90BlRUNR/+4Qs7?=
 =?us-ascii?Q?I9w0IBFFMM3FuJsj1bTtaHgzoAM34m2yqMbS5CMnPONtVWDGAlOlM97Hl7xd?=
 =?us-ascii?Q?lwR52dswG0EQ4N8tup/YtQzKahIku9laojvyRf8hxLMzbYo2HZsFcLX9ybZl?=
 =?us-ascii?Q?wJvTbyjF+tDr0hzyq1q7pVSOzZ3yj2h6eSok4o4b087znomnvj+WrO+RrF2B?=
 =?us-ascii?Q?JftE+OgobsClQfvGLNMiJA3wgvXlCwcWE8a8YoMH3IBys6lTMIPpWAT8t8oP?=
 =?us-ascii?Q?u1Asp40KuWSyKI1ptQwsSUIMxLTee+dQmjeBJ+WDC5D13nRYnI51M54Wt1sD?=
 =?us-ascii?Q?hQbBb3rWpDXxsu6qO50mTEF31k329yyIH2J1AHA6A9WWiVtQCI4Bxk6XrDrC?=
 =?us-ascii?Q?ajOt+ENhzLp3QJLTERKJLMo9yoOb40az7JY2vAIlPXlFOOeqxnkIgqatRuCi?=
 =?us-ascii?Q?HXkhopOCocswkyP8MotCUBoCwnhjkg2IXwSjZWQQG4z8ZHEdvQ/OqCZhNYLq?=
 =?us-ascii?Q?t64mhRhU5JUFaQE5pQYHepXTL4RgqAziumCJFfESOf8tm2v9evdbzwQoBikZ?=
 =?us-ascii?Q?heDw1ZSbIyYV/EeTfRvSWHe/OW7aXB8KlthrC9O4sSyk7HM6lWP7UzWpCaUo?=
 =?us-ascii?Q?+J9qlIhVFdfZoju34p5Q3Jx0Fhze0AF0lDzc7cMujDMNe+rmBuNH/rGjeod8?=
 =?us-ascii?Q?5r/8HS+/b1zNqSdneZPEAV3Wdxz2/5keWsNNBjuph5g+EftX+DCl/qbvTzJ1?=
 =?us-ascii?Q?vDNx8cCEZEab8L15JtptJE93J+u1s/MYouHMTgZSjAgtCvp3AJYANy+Gp0fJ?=
 =?us-ascii?Q?faJlJAYEBkljkcWoBC6TUD83Y9MMJWbeGZh7VvkBsKZOkvoEnhtrS57vzERs?=
 =?us-ascii?Q?j/+ZoztSeS3vrKg5M0sl4X4+EOId2KQNPPUUV9llkLKndNdhdRtdjB6BJWgl?=
 =?us-ascii?Q?AUF+o/Wzd+v6vzpebshsmjIDJNqR0ChnSsVd5BxIs3wrwG1UGSWk3CHgKqwK?=
 =?us-ascii?Q?90UWN7TSqu9ekdPAF8JysNGq?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4baeea58-73f4-4162-6801-08d931a9e78e
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:06:45.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRUkqRw9vHAaHPW0zzvuiJz8tra0w5uy/ex8iqCo79SIkd/YkKs1tWGKoBWjK5lPY99wJYC4Gytb8yYUfhiovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0452
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/utils/string.c   | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/utils/string.c

diff --git a/drivers/net/wireless/celeno/cl8k/utils/string.c b/drivers/net/=
wireless/celeno/cl8k/utils/string.c
new file mode 100644
index 000000000000..1300563e86a6
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/utils/string.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "utils/string.h"
+#include "utils/utils.h"
+
+int cl_strtobool_vector(char *src, bool *dest, u8 elem_cnt, char *delim)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       char vector[STR_LEN_256B] =3D {0};
+
+       if (strlen(src) >=3D sizeof(vector))
+               return -E2BIG;
+
+       strcpy(vector, src);
+       buf =3D cl_strtok(vector, delim);
+
+       if (!buf)
+               return -EIO;
+       if (kstrtobool(buf, &dest[0]) !=3D 0)
+               return -EINVAL;
+
+       for (i =3D 1; i < elem_cnt; i++) {
+               buf =3D cl_strtok(NULL, delim);
+               if (!buf)
+                       break;
+               if (kstrtobool(buf, &dest[i]) !=3D 0)
+                       return -EINVAL;
+       }
+
+       if (i < elem_cnt) {
+               pr_err("src %s doesn't have %u elements\n", src, elem_cnt);
+               return  -1;
+       }
+
+       return 0;
+}
+
+int cl_strtou8_vector(char *src, u8 *dest, u8 elem_cnt, char *delim)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       char vector[STR_LEN_256B] =3D {0};
+
+       if (strlen(src) >=3D sizeof(vector))
+               return -E2BIG;
+
+       strcpy(vector, src);
+       buf =3D cl_strtok(vector, delim);
+
+       if (!buf)
+               return -EIO;
+       if (kstrtou8(buf, 0, &dest[0]) !=3D 0)
+               return -EINVAL;
+
+       for (i =3D 1; i < elem_cnt; i++) {
+               buf =3D cl_strtok(NULL, delim);
+               if (!buf)
+                       break;
+               if (kstrtou8(buf, 0, &dest[i]) !=3D 0)
+                       return -EINVAL;
+       }
+
+       if (i < elem_cnt) {
+               pr_err("src %s doesn't have %u elements\n", src, elem_cnt);
+               return -1;
+       }
+
+       return 0;
+}
+
+int cl_strtou8_hex_vector(char *src, u8 *dest, u8 elem_cnt, char *delim)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       char vector[STR_LEN_32B] =3D {0};
+
+       if (strlen(src) >=3D sizeof(vector))
+               return -E2BIG;
+
+       strcpy(vector, src);
+       buf =3D cl_strtok(vector, delim);
+
+       if (!buf)
+               return -EIO;
+       if (kstrtou8(buf, 16, &dest[0]) !=3D 0)
+               return -EINVAL;
+
+       for (i =3D 1; i < elem_cnt; i++) {
+               buf =3D cl_strtok(NULL, delim);
+               if (!buf)
+                       break;
+               if (kstrtou8(buf, 16, &dest[i]) !=3D 0)
+                       return -1;
+       }
+
+       if (i < elem_cnt) {
+               pr_err("src %s doesn't have %u elements\n", src, elem_cnt);
+               return -1;
+       }
+
+       return 0;
+}
+
+int cl_strtou16_vector(char *src, u16 *dest, u8 elem_cnt, char *delim)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       char vector[STR_LEN_256B] =3D {0};
+
+       if (strlen(src) >=3D sizeof(vector))
+               return -E2BIG;
+
+       strcpy(vector, src);
+       buf =3D cl_strtok(vector, delim);
+
+       if (!buf)
+               return -EIO;
+       if (kstrtou16(buf, 0, &dest[0]) !=3D 0)
+               return -EINVAL;
+
+       for (i =3D 1; i < elem_cnt; i++) {
+               buf =3D cl_strtok(NULL, delim);
+               if (!buf)
+                       break;
+               if (kstrtou16(buf, 0, &dest[i]) !=3D 0)
+                       return -EINVAL;
+       }
+
+       if (i < elem_cnt) {
+               pr_err("src %s doesn't have %u elements\n", src, elem_cnt);
+               return -1;
+       }
+
+       return 0;
+}
+
+int cl_strtou32_vector(char *src, u32 *dest, u8 elem_cnt, char *delim)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       char vector[STR_LEN_256B] =3D {0};
+
+       if (strlen(src) >=3D sizeof(vector))
+               return -E2BIG;
+
+       strcpy(vector, src);
+       buf =3D cl_strtok(vector, delim);
+
+       if (!buf)
+               return -EIO;
+       if (kstrtou32(buf, 0, &dest[0]) !=3D 0)
+               return -EINVAL;
+
+       for (i =3D 1; i < elem_cnt; i++) {
+               buf =3D cl_strtok(NULL, delim);
+               if (!buf)
+                       break;
+               if (kstrtou32(buf, 0, &dest[i]) !=3D 0)
+                       return -EINVAL;
+       }
+
+       if (i < elem_cnt) {
+               pr_err("src %s doesn't have %u elements\n", src, elem_cnt);
+               return -1;
+       }
+
+       return 0;
+}
+
+int cl_strtos8_vector(char *src, s8 *dest, u8 elem_cnt, char *delim)
+{
+       u8 i =3D 0;
+       char *buf =3D NULL;
+       char vector[STR_LEN_256B] =3D {0};
+
+       if (strlen(src) >=3D sizeof(vector))
+               return -E2BIG;
+
+       strcpy(vector, src);
+       buf =3D cl_strtok(vector, delim);
+
+       if (!buf)
+               return -EIO;
+       if (kstrtos8(buf, 0, &dest[0]) !=3D 0)
+               return -EINVAL;
+
+       for (i =3D 1; i < elem_cnt; i++) {
+               buf =3D cl_strtok(NULL, delim);
+               if (!buf)
+                       break;
+               if (kstrtos8(buf, 0, &dest[i]) !=3D 0)
+                       return -EINVAL;
+       }
+
+       if (i < elem_cnt) {
+               pr_err("src %s doesn't have %u elements\n", src, elem_cnt);
+               return -1;
+       }
+
+       return 0;
+}
+
+static s8 *_strtok;
+
+s8 *cl_strtok(s8 *s, const s8 *ct)
+{
+       return cl_strtok_r(s, ct, &_strtok);
+}
+
+/* cl_strtok_r() is a reentrant version of cl_strtok() */
+s8 *cl_strtok_r(s8 *s, const s8 *ct, s8 **saveptr)
+{
+       s8 *sbegin, *send;
+
+       sbegin  =3D s ? s : *saveptr;
+       if (!sbegin)
+               return NULL;
+
+       sbegin +=3D strspn(sbegin, ct);
+       if (*sbegin =3D=3D '\0') {
+               *saveptr =3D NULL;
+               return NULL;
+       }
+
+       send =3D strpbrk(sbegin, ct);
+       if (send && *send !=3D '\0')
+               *send++ =3D '\0';
+
+       *saveptr =3D send;
+
+       return sbegin;
+}
+
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

