Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84A6C3AB8A2
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhFQQJc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:09:32 -0400
Received: from mail-vi1eur05on2059.outbound.protection.outlook.com ([40.107.21.59]:25895
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232424AbhFQQIQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:08:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ih1rm9vhjBgVOFaVNK9OoUn4jd+Mn773zrfn1oFFPXCoV7ElrrhZ2g2a0gN4P+9xqtY3yD20bWo0P1Y6DAtoFYZH4ZmIuQvToTMid6mnChRybbvdAxxhz8N0fNBpGAFQ+i0jGQf3/LZGgOJoUslZ/WMKue5RofgnUWyNMOuJxGlyhNM2Eb7E6C7hyiHhPJQvvuZDqnV1faCHo5MYSp8hgbVqIWrBwREJZeKcXUhpA0UlIMoNYojXGqbiytKEqszUrxGMjKBMecwayC6kvh8h1fNX+AtKarnLvOU4O7DDTJXW+5j1vfdIFEdBFluyHXyBiN/0xCtc66Zeba2gznohdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKuSGQxJMMYPVScMuTAb8ucsLD2TjiKrS19M/2OKwkY=;
 b=lOVDt7HqwyMLU4CG7EewQRrLX9WlzY4b2v/CLHYA2HSiWaTJOczU/kYVOorMblsEd7L0PoJinZ4zp7WyF1PjM6nPHZxSO0tqAAlSsVwLtF48QyGfBq//bD+LCSSLPEEMZs9YVOSLyYXiqYOcMxnhkTscSROeTg4p75DQUUx9I+CkBS49vVxqKNzn/Heh6aAXaPY9PnN7PDXXciFi+EMmqju672StiQbCwgsknuJgH+gDgtuI236tXDYZDmEQPlWvnIwf99mPxOfW0Y2SpBnDJgDJRdHBpdVZmRW9OW0qn6Z6OAa/9R3l/YMpOzJByBamiyIfpD1wkmH42aBubqn6Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKuSGQxJMMYPVScMuTAb8ucsLD2TjiKrS19M/2OKwkY=;
 b=BpjD43INCq0c3aHyD33AOiXfrwQzaw8GIAsqL62iw8m2MCDFWRWD73kiR5jftnXVC/l0Dd/xYFkCr5S7k9UaQYBdO8iPSp7NAZ8hON8wH437qzW+cVCJFmyuGT2TmytdT3Z6C9NtG8mhGA+Z3nW+BWTEB4cuYmqkb1ifm3NG3Ug=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM8P192MB1059.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Thu, 17 Jun
 2021 16:05:48 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:05:48 +0000
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
Subject: [RFC v1 135/256] cl8k: add power_cli.c
Date:   Thu, 17 Jun 2021 16:00:22 +0000
Message-Id: <20210617160223.160998-136-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:05:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a556ba2-6b61-4872-029c-08d931a9aa57
X-MS-TrafficTypeDiagnostic: AM8P192MB1059:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8P192MB1059C4E0A264267865104735F60E9@AM8P192MB1059.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:146;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JQJad6qQJlaSSqrJtjWJxiCLiY8a1hoDc3xFX4AqcOWqoLwIVxsdF35k02JbiyYnzOmpPXPg5sz8KSkJ08zhsTpwfLHAZy19rZxsaj4axWoWMszWJrINd88z6HQfYGB41eoWVgmB5ESxWQxS8pOEpM4eyD7ftDR3Qh2NFDs/pOdOAeC5rO3bdAlrdh9gNM6xq7JcF9a+v8G4p/mddRTh3cCLFo9EzK2yZjrA26fYs+A8APtnACXGWpjxgiltNm+ADVy7hEO5IC5nVX7N+hlWLr02Qx0FNtloyvD5U3fTa1q47o74seT17544hsr+/aVeFQWo/KtOtVlbwKh212H8WIuxeasyFKsxnx7N9BIAcXdzDdBqaH1RhD3H38jEvo1E0GKkoiF9XoWofNeG0GDab1nxoAUBKISzjhONFuUwG1KxtKKhe0UcDgsonWo/KhRCa5yv1VI1ybAOCkjpgPL5LKs5YU7r6ngmcC5NE2HwpHxQVd5My9JMva6MDTGMNPI8+gNF64NTuQqe1rg23WZpH0dMrGO2DjwoI7UvGJcnWp4HQTAJb5Zl6pmwknNZz5ycdjsxJa+2Pvqfy5thr6qO+Z1yNQuVyhH8BJHVEe7Q//AbzjAWKY25p5tyxjTt1J/a+Q2XoFYe3A92OaB9Jz5ncmFpXQPEEHqDYuI8o51DhOepohYyZnjdase0yXQQYMxwm9eOys1nU03+F6gGNDOyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(26005)(956004)(498600001)(186003)(66556008)(16526019)(107886003)(66946007)(66476007)(8936002)(6916009)(2616005)(1076003)(2906002)(54906003)(6506007)(6666004)(4326008)(38100700002)(38350700002)(83380400001)(9686003)(6512007)(5660300002)(6486002)(86362001)(55236004)(36756003)(30864003)(52116002)(8676002)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mdr1p9OJuyalRrY8a2B1zetK71OJ9H6mpE41SvHy+FZUu13+YjBow3AHuKHV?=
 =?us-ascii?Q?mmdcV/KZaIU9DN7ZlcC6T28V0nEMltlhpxuAH50qjrLAIFvmpE26lrUYxr0I?=
 =?us-ascii?Q?ezU3tUuRwTUW7JEAG0HzwUGOlJNpe0g433G57PksjDhJhnT23XrSrRyuJxfX?=
 =?us-ascii?Q?hHAspdDjiZ1xJkjhSOFggcXnd7r7qDKkydMln3W1ipCwp45HwKgo4FvEh6km?=
 =?us-ascii?Q?ZrER2wyp+6+QOgi5cidwFc3rBUMBbaI8K2zyEln8E4kil3qnj4y6+PniOVmg?=
 =?us-ascii?Q?wSuKvlz9FrYsczz2TbWcELeqailHnagUsY1dp3dNPpHX4ajfZUzm2hDcNMNc?=
 =?us-ascii?Q?y1Qs9U4zkK+OPwUKiYDB+S7tWhaN/W57S+6DWp7RAmLMd5SXyyPYZ2VuKuRb?=
 =?us-ascii?Q?MYIbRc1hSqS6YBHfq4tmWd2nGSBIEAks04EVUBvVHX7hjwqxg5fwlnCPwxX7?=
 =?us-ascii?Q?L35uZo7QdOyK8GyTn+ezsxnY66vltwq/W0tp7Jgc+kplhz65JGQUJ2HyyNB0?=
 =?us-ascii?Q?oHhhQ2hUEjaALeTgS67g2Qh/ZznYZaAVErWEo/MEd7gtiZeDIezAVKwdmnpF?=
 =?us-ascii?Q?iqUwxSSU8aPEkGRDCqWa0ZzX+drTucdDA7TjtLodEoMqHscXoQCbiPEJrNud?=
 =?us-ascii?Q?dmo/t5sz2UqKQVXfyskezL1bF0L7Aj59b4z7cZo+vyOhLvd5nzBarY6W5rC0?=
 =?us-ascii?Q?quhg1h02EMZvqD8IW4eWMuhHjafTcP4M3PdxxjtB/YS1ytraNBLq2by6As2n?=
 =?us-ascii?Q?X6G0MPuDK8mNHOP/sp0Y5ba0ZFC32iLaeS72/dvbM0acWO6y8Z2tVHxVp8kP?=
 =?us-ascii?Q?3dxih7YOY30rkz1LhVknJgGpOX+6cBEjhzltMrT+38Q36DhtzbGl+8andCRf?=
 =?us-ascii?Q?HXlSnD3qLOG8waCixqcYRtCT7cbjvviQO6OxqRty3RQCkSqkTMCX3PEpqHeU?=
 =?us-ascii?Q?dcY9znc241HwUjJi4VObunPvfaUtwR6laKGBIxCWld0ZW7xhhoxGaqrBzgyy?=
 =?us-ascii?Q?KhwnZVZ0fZfABRFHTw0lw3tgE+wSpE8MHwu023TuoqpFiLe2EQid57WXsMAm?=
 =?us-ascii?Q?5sExZDqfiAD5RD6Hn899H0L7kFtNOwWgetYJk/Kkof8m8T/R3LzQNkQaApkw?=
 =?us-ascii?Q?X0pd5fAmVHY8qyKeMZbcsYOp4/VyNqC8gGf9vXxoRcLt9krXEey3TR1NgKjb?=
 =?us-ascii?Q?1mrf03brJYWZCB0Jwce4hGbdfoaRMXWWSexswmjuiCGmMa5QN1zuHYurJrIV?=
 =?us-ascii?Q?SKnHHRgnZRo7nPuh+7/YED3VCEbUGu1m+9373zupzlWKyBhrodE1eljnAgDI?=
 =?us-ascii?Q?5PGXHdLML4EtUolmG6N2gk9f?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a556ba2-6b61-4872-029c-08d931a9aa57
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:05:03.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ahqtd9H4VAqRX1VWTl3VYEabUnhrdUHrQn3TrcXN41yxtiKo6Yn6aO5N/Df5uJGDc40fBWwErPgNt+hNUEc+kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB1059
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/power_cli.c | 878 +++++++++++++++++++
 1 file changed, 878 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/power_cli.c

diff --git a/drivers/net/wireless/celeno/cl8k/power_cli.c b/drivers/net/wir=
eless/celeno/cl8k/power_cli.c
new file mode 100644
index 000000000000..7adcb93cbf9c
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/power_cli.c
@@ -0,0 +1,878 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include "power_cli.h"
+#include "power.h"
+#include "band.h"
+#include "chip.h"
+#include "utils/utils.h"
+
+static void cl_power_float_to_buf(char **buf, int *len, ssize_t *buf_size,
+                                 s32 x, s32 y, bool zero_pad)
+{
+       bool sign =3D (x >=3D 0 && y > 0) || (x < 0 && y < 0);
+       s32 absx =3D abs(x);
+       s32 absy =3D abs(y);
+       s32 abs_integer =3D 0;
+       s32 fraction =3D 0;
+       s32 signed_integer =3D 0;
+
+       if (x !=3D 0 && y !=3D 0) {
+               abs_integer =3D (absx / absy);
+               if (y =3D=3D 2)
+                       fraction =3D (10 * (absx - absy * abs_integer) / ab=
sy);
+               else
+                       fraction =3D (100 * (absx - absy * abs_integer) / a=
bsy);
+               signed_integer =3D sign ? abs_integer : -abs_integer;
+       }
+
+       if (y =3D=3D 2) {
+               if (signed_integer =3D=3D 0 && !sign)
+                       cl_snprintf(buf, len, buf_size, "-0.%d", fraction);
+               else if (zero_pad)
+                       cl_snprintf(buf, len, buf_size, "%2d.%d", signed_in=
teger, fraction);
+               else
+                       cl_snprintf(buf, len, buf_size, "%d.%d", signed_int=
eger, fraction);
+       } else {
+               if (signed_integer =3D=3D 0 && !sign)
+                       cl_snprintf(buf, len, buf_size, "-0.%02d", fraction=
);
+               else if (zero_pad)
+                       cl_snprintf(buf, len, buf_size, "%2d.%02d", signed_=
integer, fraction);
+               else
+                       cl_snprintf(buf, len, buf_size, "%d.%02d", signed_i=
nteger, fraction);
+       }
+}
+
+static void cl_power_q1_to_buf(char **buf, int *len, ssize_t *buf_size, co=
nst s8 *prefix, s32 x,
+                              const s8 *suffix, bool zero_pad)
+{
+       cl_snprintf(buf, len, buf_size, "%s", prefix);
+       cl_power_float_to_buf(buf, len, buf_size, x, 2, zero_pad);
+       cl_snprintf(buf, len, buf_size, "%s", suffix);
+}
+
+static void cl_power_q8_to_buf(char **buf, int *len, ssize_t *buf_size, co=
nst s8 *prefix, s32 x,
+                              const s8 *suffix, bool zero_pad)
+{
+       cl_snprintf(buf, len, buf_size, "%s", prefix);
+       cl_power_float_to_buf(buf, len, buf_size, x, 256, zero_pad);
+       cl_snprintf(buf, len, buf_size, "%s", suffix);
+}
+
+static void multi_print(char **buf, int *len, ssize_t *buf_size, u8 num_pr=
ints, const s8 *str)
+{
+       u8 i;
+
+       for (i =3D 0; i < num_prints; i++)
+               cl_snprintf(buf, len, buf_size, "%s", str);
+
+       cl_snprintf(buf, len, buf_size, "\n");
+}
+
+static void cl_power_offset_to_buf(struct cl_hw *cl_hw, char **buf,
+                                  int *len, ssize_t *buf_size,
+                                  u8 mode, u8 max_bw, u8 max_mcs)
+{
+       u8 bw, mcs;
+       s8 offset_q1;
+
+       cl_snprintf(buf, len, buf_size, "\nPower Offset per BW & MCS\n");
+
+       cl_snprintf(buf, len, buf_size, "-----");
+       multi_print(buf, len, buf_size, max_mcs, "-----");
+
+       cl_snprintf(buf, len, buf_size, "|   ");
+       for (mcs =3D 0; mcs < max_mcs; mcs++)
+               cl_snprintf(buf, len, buf_size, "|%4u", mcs);
+
+       cl_snprintf(buf, len, buf_size, "|\n");
+
+       cl_snprintf(buf, len, buf_size, "|---");
+       for (mcs =3D 0; mcs < max_mcs - 1; mcs++)
+               cl_snprintf(buf, len, buf_size, "+----");
+
+       cl_snprintf(buf, len, buf_size, "+----|\n");
+
+       for (bw =3D 0; bw < max_bw; bw++) {
+               cl_snprintf(buf, len, buf_size, "|%3u", BW_TO_MHZ(bw));
+
+               for (mcs =3D 0; mcs < max_mcs; mcs++) {
+                       offset_q1 =3D cl_power_offset_q1(cl_hw, mode, bw, m=
cs);
+                       cl_power_q1_to_buf(buf, len, buf_size, "|", offset_=
q1, "", true);
+               }
+
+               cl_snprintf(buf, len, buf_size, "|\n");
+       }
+
+       cl_snprintf(buf, len, buf_size, "-----");
+       multi_print(buf, len, buf_size, max_mcs, "-----");
+}
+
+static void cl_power_bf_gain_to_buf(char **buf, int *len, ssize_t *buf_siz=
e,
+                                   u8 max_nss, s32 *bf_gain_q1)
+{
+       u8 nss;
+
+       cl_snprintf(buf, len, buf_size, "BF gain per NSS =3D ");
+
+       for (nss =3D 0; nss < max_nss; nss++) {
+               if (nss =3D=3D max_nss - 1)
+                       cl_power_q1_to_buf(buf, len, buf_size, "", bf_gain_=
q1[nss], "\n", false);
+               else
+                       cl_power_q1_to_buf(buf, len, buf_size, "", bf_gain_=
q1[nss], ",", false);
+       }
+}
+
+static void cl_power_table_ht_vht_he_to_buf(struct cl_hw *cl_hw, char **bu=
f, int *len,
+                                           ssize_t *buf_size, u8 max_bw, u=
8 max_nss,
+                                           u8 max_mcs, u8 max_nss_arr,
+                                           u8 max_mcs_arr, s8 *ant_pwr_q1,
+                                           s32 *bf_gain_q1, s32 arr_gain_q=
1,
+                                           s32 ant_gain_q1)
+{
+       u8 bw, nss, mcs, one_d_idx;
+       s32 conducted_q1, final_q1;
+
+       cl_snprintf(buf, len, buf_size, "\nPower Table\n");
+
+       cl_snprintf(buf, len, buf_size, "---------");
+       multi_print(buf, len, buf_size, max_bw, "----------");
+
+       cl_snprintf(buf, len, buf_size, "|MCS|BF |");
+       for (bw =3D 0; bw < max_bw; bw++)
+               cl_snprintf(buf, len, buf_size, " %3uMHz  |", BW_TO_MHZ(bw)=
);
+
+       cl_snprintf(buf, len, buf_size, "\n");
+
+       cl_snprintf(buf, len, buf_size, "|   |NSS|");
+       multi_print(buf, len, buf_size, max_bw, "Cond|Finl|");
+
+       for (mcs =3D 0; mcs < max_mcs; mcs++) {
+               cl_snprintf(buf, len, buf_size, "|---+---|");
+               multi_print(buf, len, buf_size, max_bw, "----+----|");
+
+               for (nss =3D 0; nss < max_nss; nss++) {
+                       cl_snprintf(buf, len, buf_size, "|%3u|%3u|", mcs, n=
ss);
+
+                       for (bw =3D 0; bw < max_bw; bw++) {
+                               one_d_idx =3D (bw * max_mcs_arr + mcs) * ma=
x_nss_arr + nss;
+                               conducted_q1 =3D ant_pwr_q1[one_d_idx];
+                               final_q1 =3D conducted_q1 + ant_gain_q1 +
+                                       arr_gain_q1 + bf_gain_q1[nss];
+
+                               if (cl_hw->channel_info.standard =3D=3D CL_=
STANDARD_FCC)
+                                       final_q1 -=3D min(bf_gain_q1[nss] +=
 ant_gain_q1, 6 << 1);
+
+                               cl_power_q1_to_buf(buf, len, buf_size, "", =
conducted_q1, "|", true);
+                               cl_power_q1_to_buf(buf, len, buf_size, "", =
final_q1, "|", true);
+                       }
+
+                       cl_snprintf(buf, len, buf_size, "\n");
+               }
+       }
+
+       cl_snprintf(buf, len, buf_size, "---------");
+       multi_print(buf, len, buf_size, max_bw, "----------");
+
+       cl_snprintf(buf, len, buf_size, "(*) BF disabled =3D BF NSS #%u", m=
ax_nss - 1);
+}
+
+static void cl_power_table_cck_ofdm_to_buf(struct cl_hw *cl_hw, char **buf=
,
+                                          int *len, ssize_t *buf_size,
+                                          u8 max_mcs, s8 *ant_pwr_q1,
+                                          s32 arr_gain_q1, s32 ant_gain_q1=
)
+{
+       u8 mcs;
+       s32 conducted_q1, final_q1;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nPower Table\n"
+                   "|-------------|\n"
+                   "|MCS|Cond|Finl|\n"
+                   "|---+----+----|\n");
+
+       for (mcs =3D 0; mcs < max_mcs; mcs++) {
+               conducted_q1 =3D ant_pwr_q1[mcs];
+               final_q1 =3D conducted_q1 + ant_gain_q1 + arr_gain_q1;
+
+               if (cl_hw->channel_info.standard =3D=3D CL_STANDARD_FCC)
+                       final_q1 -=3D min(ant_gain_q1, 6 << 1);
+
+               cl_snprintf(buf, len, buf_size, "|%3u|", mcs);
+               cl_power_q1_to_buf(buf, len, buf_size, "", conducted_q1, "|=
", true);
+               cl_power_q1_to_buf(buf, len, buf_size, "",  final_q1, "|\n"=
, true);
+       }
+
+       cl_snprintf(buf, len, buf_size, "|-------------|\n");
+}
+
+static void cl_power_trunc_ht_vht_he_to_buf(struct cl_hw *cl_hw, char **bu=
f,
+                                           int *len, ssize_t *buf_size,
+                                           enum cl_wrs_mode mode, u8 max_b=
w,
+                                           u8 max_nss, u8 max_mcs,
+                                           u8 max_nss_arr, u8 max_mcs_arr,
+                                           u8 *trunc_pwr_q1)
+{
+       u8 bw, nss, mcs, one_d_idx;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, mode);
+       s8 pwr_offset_q1;
+       s32 truncate_q1, total_q1;
+
+       cl_snprintf(buf, len, buf_size, "\nTruncate Table\n");
+
+       cl_snprintf(buf, len, buf_size, "---------");
+       multi_print(buf, len, buf_size, max_bw, "----------");
+
+       cl_snprintf(buf, len, buf_size, "|MCS|BF |");
+       for (bw =3D 0; bw < max_bw; bw++)
+               cl_snprintf(buf, len, buf_size, " %3uMHz  |", BW_TO_MHZ(bw)=
);
+
+       cl_snprintf(buf, len, buf_size, "\n");
+
+       cl_snprintf(buf, len, buf_size, "|   |NSS|");
+       multi_print(buf, len, buf_size, max_bw, "Totl|Trnc|");
+
+       for (mcs =3D 0; mcs < max_mcs; mcs++) {
+               cl_snprintf(buf, len, buf_size, "|---+---|");
+               multi_print(buf, len, buf_size, max_bw, "----+----|");
+
+               for (nss =3D 0; nss < max_nss; nss++) {
+                       cl_snprintf(buf, len, buf_size, "|%3u|%3u|", mcs, n=
ss);
+
+                       for (bw =3D 0; bw < max_bw; bw++) {
+                               one_d_idx =3D (bw * max_mcs_arr + mcs) * ma=
x_nss_arr + nss;
+                               truncate_q1 =3D (s32)trunc_pwr_q1[one_d_idx=
];
+                               pwr_offset_q1 =3D cl_power_offset_q1(cl_hw,=
 mode, bw, mcs);
+                               total_q1 =3D cl_power_total_q1(cl_hw, pwr_o=
ffset_q1,
+                                                            tx_ant, nss, m=
ode, false);
+
+                               cl_power_q1_to_buf(buf, len, buf_size, "", =
total_q1, "|", true);
+                               cl_power_q1_to_buf(buf, len, buf_size, "", =
truncate_q1, "|", true);
+                       }
+
+                       cl_snprintf(buf, len, buf_size, "\n");
+               }
+       }
+
+       cl_snprintf(buf, len, buf_size, "---------");
+       multi_print(buf, len, buf_size, max_bw, "----------");
+}
+
+static void cl_power_trunc_cck_ofdm_to_buf(struct cl_hw *cl_hw, char **buf=
,
+                                          int *len, ssize_t *buf_size,
+                                          enum cl_wrs_mode mode, u8 max_mc=
s, u8 *trunc_pwr_q1)
+{
+       u8 mcs;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, mode);
+       s8 pwr_offset_q1;
+       s32 truncate_q1, total_q1;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nTruncate Table\n"
+                   "|-------------|\n"
+                   "|MCS|Totl|Trnc|\n"
+                   "|---+----+----|\n");
+
+       for (mcs =3D 0; mcs < max_mcs; mcs++) {
+               truncate_q1 =3D (s32)trunc_pwr_q1[mcs];
+               pwr_offset_q1 =3D cl_power_offset_q1(cl_hw, mode, CHNL_BW_2=
0, mcs);
+               total_q1 =3D cl_power_total_q1(cl_hw, pwr_offset_q1, tx_ant=
, 0, mode, false);
+
+               cl_snprintf(buf, len, buf_size, "|%3u|", mcs);
+               cl_power_q1_to_buf(buf, len, buf_size, "", total_q1, "|", t=
rue);
+               cl_power_q1_to_buf(buf, len, buf_size, "", truncate_q1, "|\=
n", true);
+       }
+
+       cl_snprintf(buf, len, buf_size, "|-------------|\n");
+}
+
+static void cl_power_config_to_buf(char **buf, int *len,
+                                  ssize_t *buf_size,
+                                  char *mode,
+                                  u8 tx_ant_num,
+                                  s32 arr_gain_q1,
+                                  s32 calib_power_q1,
+                                  s8 ant_pwr_vns,
+                                  s8 pwr_auto_resp_vns,
+                                  s32 vns_actual_q1)
+{
+       cl_snprintf(buf, len, buf_size,
+                   "%s power debug info\n", mode);
+       cl_snprintf(buf, len, buf_size,
+                   "-----------------------\n");
+       cl_snprintf(buf, len, buf_size,
+                   "Tx antenna =3D %u\n", tx_ant_num);
+       cl_power_q1_to_buf(buf, len, buf_size, "Array gain =3D ",
+                          arr_gain_q1, "\n", false);
+       cl_power_q1_to_buf(buf, len, buf_size, "Calib power =3D ",
+                          calib_power_q1, "\n", false);
+       cl_power_q1_to_buf(buf, len, buf_size, "VNS power =3D ",
+                          ant_pwr_vns, "\n", false);
+       cl_power_q1_to_buf(buf, len, buf_size, "VNS auto resp power =3D ",
+                          pwr_auto_resp_vns, "\n", false);
+       cl_power_q1_to_buf(buf, len, buf_size, "VNS actual =3D ",
+                          vns_actual_q1, "\n", false);
+}
+
+static void _cl_power_table_print_he(struct cl_hw *cl_hw, char **buf, int =
*len, ssize_t *buf_size)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_HE);
+       u8 max_bw =3D max_bw_idx(WRS_MODE_HE, cl_band_is_24g(cl_hw));
+       u8 max_nss =3D min_t(u8, tx_ant, PWR_TBL_HE_BF_SIZE);
+       u8 nss;
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 calib_power_q1 =3D cl_power_average_calib_q1(cl_hw, tx_ant);
+       s32 bf_gain_tbl_q1[PWR_TBL_HE_BF_SIZE] =3D {0};
+       s32 vns_actual_q1 =3D pwr_tables->ant_pwr_vns_he + ant_gain_q1 + ar=
r_gain_q1;
+
+       for (nss =3D 0; nss < max_nss; nss++)
+               bf_gain_tbl_q1[nss] =3D cl_power_bf_gain_q1(cl_hw, tx_ant, =
nss);
+
+       cl_power_config_to_buf(buf, len, buf_size, "HE", tx_ant, arr_gain_q=
1,
+                              calib_power_q1, pwr_tables->ant_pwr_vns_he,
+                              pwr_tables->pwr_auto_resp_vns_he, vns_actual=
_q1);
+
+       cl_power_bf_gain_to_buf(buf, len, buf_size, max_nss, bf_gain_tbl_q1=
);
+
+       cl_power_offset_to_buf(cl_hw, buf, len, buf_size, WRS_MODE_HE,
+                              CHNL_BW_MAX_HE, WRS_MCS_MAX_HE);
+
+       cl_power_table_ht_vht_he_to_buf(cl_hw, buf, len, buf_size,
+                                       max_bw, max_nss, WRS_MCS_MAX_HE,
+                                       PWR_TBL_HE_BF_SIZE, WRS_MCS_MAX_HE,
+                                       &pwr_tables->ant_pwr_he[0][0][0],
+                                       bf_gain_tbl_q1, arr_gain_q1, ant_ga=
in_q1);
+}
+
+static void _cl_power_table_print_ht_vht(struct cl_hw *cl_hw, char **buf,
+                                        int *len, ssize_t *buf_size)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool is_5g =3D cl_band_is_5g(cl_hw);
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_VHT);
+       u8 max_bw =3D max_bw_idx(WRS_MODE_VHT, is_24g);
+       u8 max_nss =3D min_t(u8, tx_ant, PWR_TBL_VHT_BF_SIZE);
+       u8 max_mcs =3D (is_5g || (is_24g && cl_hw->conf->ci_vht_cap_24g)) ?
+               WRS_MCS_MAX_VHT : WRS_MCS_MAX_HT;
+       u8 nss;
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 calib_power_q1 =3D cl_power_average_calib_q1(cl_hw, tx_ant);
+       s32 bf_gain_tbl_q1[PWR_TBL_VHT_BF_SIZE] =3D {0};
+       s32 vns_actual_q1 =3D pwr_tables->ant_pwr_vns_ht_vht + ant_gain_q1 =
+ arr_gain_q1;
+
+       for (nss =3D 0; nss < max_nss; nss++)
+               bf_gain_tbl_q1[nss] =3D cl_power_bf_gain_q1(cl_hw, tx_ant, =
nss);
+
+       cl_power_config_to_buf(buf, len, buf_size, "HT/VHT", tx_ant, arr_ga=
in_q1,
+                              calib_power_q1, pwr_tables->ant_pwr_vns_ht_v=
ht,
+                              pwr_tables->pwr_auto_resp_vns_ht_vht, vns_ac=
tual_q1);
+
+       cl_power_bf_gain_to_buf(buf, len, buf_size, max_nss, bf_gain_tbl_q1=
);
+
+       cl_power_offset_to_buf(cl_hw, buf, len, buf_size,
+                              WRS_MODE_VHT, CHNL_BW_MAX_VHT, WRS_MCS_MAX_V=
HT);
+
+       cl_power_table_ht_vht_he_to_buf(cl_hw, buf, len, buf_size,
+                                       max_bw, max_nss, max_mcs,
+                                       PWR_TBL_VHT_BF_SIZE, WRS_MCS_MAX_VH=
T,
+                                       &pwr_tables->ant_pwr_ht_vht[0][0][0=
],
+                                       bf_gain_tbl_q1, arr_gain_q1, ant_ga=
in_q1);
+}
+
+static void _cl_power_table_print_ofdm(struct cl_hw *cl_hw, char **buf,
+                                      int *len, ssize_t *buf_size)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_OFDM);
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 calib_power_q1 =3D cl_power_average_calib_q1(cl_hw, tx_ant);
+       s32 vns_actual_q1 =3D pwr_tables->ant_pwr_vns_ofdm + ant_gain_q1 + =
arr_gain_q1;
+
+       cl_power_config_to_buf(buf, len, buf_size, "OFDM", tx_ant, arr_gain=
_q1,
+                              calib_power_q1, pwr_tables->ant_pwr_vns_ofdm=
,
+                              pwr_tables->pwr_auto_resp_vns_ofdm, vns_actu=
al_q1);
+
+       cl_power_offset_to_buf(cl_hw, buf, len, buf_size, WRS_MODE_OFDM,
+                              CHNL_BW_MAX_OFDM, WRS_MCS_MAX_OFDM);
+
+       cl_power_table_cck_ofdm_to_buf(cl_hw, buf, len, buf_size, WRS_MCS_M=
AX_OFDM,
+                                      pwr_tables->ant_pwr_ofdm,
+                                      arr_gain_q1, ant_gain_q1);
+}
+
+static void _cl_power_table_print_cck(struct cl_hw *cl_hw, char **buf,
+                                     int *len, ssize_t *buf_size)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_CCK);
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant);
+       s32 calib_power_q1 =3D cl_power_average_calib_q1(cl_hw, tx_ant);
+       s32 vns_actual_q1 =3D pwr_tables->ant_pwr_vns_cck + ant_gain_q1 + a=
rr_gain_q1;
+
+       cl_power_config_to_buf(buf, len, buf_size, "CCK", tx_ant, arr_gain_=
q1,
+                              calib_power_q1, pwr_tables->ant_pwr_vns_cck,
+                              pwr_tables->pwr_auto_resp_vns_cck,
+                              vns_actual_q1);
+
+       cl_power_offset_to_buf(cl_hw, buf, len, buf_size, WRS_MODE_CCK,
+                              CHNL_BW_MAX_CCK, WRS_MCS_MAX_CCK);
+
+       cl_power_table_cck_ofdm_to_buf(cl_hw, buf, len, buf_size, WRS_MCS_M=
AX_CCK,
+                                      pwr_tables->ant_pwr_cck,
+                                      arr_gain_q1, ant_gain_q1);
+}
+
+static void _cl_power_trunc_print_he(struct cl_hw *cl_hw, char **buf,
+                                    int *len, ssize_t *buf_size)
+{
+       u8 tx_ant =3D cl_power_tx_ant(cl_hw, WRS_MODE_HE);
+       u8 max_bw =3D max_bw_idx(WRS_MODE_HE, cl_band_is_24g(cl_hw));
+       u8 max_nss =3D min_t(u8, tx_ant, PWR_TBL_HE_BF_SIZE);
+
+       cl_power_trunc_ht_vht_he_to_buf(cl_hw, buf, len, buf_size, WRS_MODE=
_HE,
+                                       max_bw, max_nss, WRS_MCS_MAX_HE,
+                                       PWR_TBL_HE_BF_SIZE, WRS_MCS_MAX_HE,
+                                       &cl_hw->pwr_trunc.he[0][0][0]);
+}
+
+static void _cl_power_trunc_print_ht_vht(struct cl_hw *cl_hw, char **buf,
+                                        int *len, ssize_t *buf_size)
+{
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool is_5g =3D cl_band_is_5g(cl_hw);
+       enum cl_wrs_mode mode;
+       u8 tx_ant, max_bw, max_nss, max_mcs;
+
+       if (is_5g || (is_24g && cl_hw->conf->ci_vht_cap_24g)) {
+               mode =3D WRS_MODE_VHT;
+               max_bw =3D CHNL_BW_MAX_VHT;
+               max_mcs =3D WRS_MCS_MAX_VHT;
+       } else {
+               mode =3D WRS_MODE_HT;
+               max_bw =3D CHNL_BW_MAX_HT;
+               max_mcs =3D WRS_MCS_MAX_HT;
+       }
+
+       tx_ant =3D cl_power_tx_ant(cl_hw, mode);
+       max_nss =3D min_t(u8, tx_ant, PWR_TBL_VHT_BF_SIZE);
+
+       cl_power_trunc_ht_vht_he_to_buf(cl_hw, buf, len, buf_size, mode,
+                                       max_bw, max_nss, max_mcs,
+                                       PWR_TBL_VHT_BF_SIZE, WRS_MCS_MAX_VH=
T,
+                                       &cl_hw->pwr_trunc.ht_vht[0][0][0]);
+}
+
+static void _cl_power_trunc_print_ofdm(struct cl_hw *cl_hw, char **buf,
+                                      int *len, ssize_t *buf_size)
+{
+       cl_power_trunc_cck_ofdm_to_buf(cl_hw, buf, len, buf_size,
+                                      WRS_MODE_OFDM, WRS_MCS_MAX_OFDM,
+                                      cl_hw->pwr_trunc.ofdm);
+}
+
+static void _cl_power_trunc_print_cck(struct cl_hw *cl_hw, char **buf,
+                                     int *len, ssize_t *buf_size)
+{
+       cl_power_trunc_cck_ofdm_to_buf(cl_hw, buf, len, buf_size,
+                                      WRS_MODE_CCK, WRS_MCS_MAX_CCK,
+                                      cl_hw->pwr_trunc.cck);
+}
+
+static void cl_power_print_limits(struct cl_hw *cl_hw, char **buf,
+                                 int *len, ssize_t *buf_size, u8 channel)
+{
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool country_limit =3D cl_hw->channel_info.use_channel_info;
+       bool hardware_limit =3D strlen(cl_hw->conf->ce_hardware_power_table=
) > 0;
+       bool eirp_limit =3D cl_hw->conf->ci_eirp_regulatory_en;
+       u8 bw =3D 0;
+       s16 country_val_q8 =3D 0;
+       s16 hardware_val_q8 =3D 0;
+       s16 eirp_val_q8 =3D 0;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\nPower regulation/limitations\n"
+                   "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
+       cl_snprintf(buf, len, buf_size,
+                   "Country regulation  =3D %s\n", country_limit ?
+                   "On" : "Off");
+       cl_snprintf(buf, len, buf_size,
+                   "Hardware limitation =3D %s\n", hardware_limit ?
+                   "On" : "Off");
+       cl_snprintf(buf, len, buf_size,
+                   "EIRP enable         =3D %s\n\n", eirp_limit ?
+                   "True" : "False");
+
+       if (!eirp_limit || (!country_limit && !hardware_limit))
+               return;
+
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------|\n"
+                   "| BW  | COUNTRY | HARDWARE |  EIRP  |\n"
+                   "|-----------------------------------|\n");
+
+       for (bw =3D 0; bw < max_bw_idx(WRS_MODE_HE, is_24g); bw++) {
+               country_val_q8 =3D cl_chan_info_get_country_limit_q8(cl_hw,=
 channel, bw);
+               hardware_val_q8 =3D cl_chan_info_get_hardware_limit_q8(cl_h=
w, channel, bw);
+               eirp_val_q8 =3D cl_chan_info_get_eirp_limit_q8(cl_hw, bw);
+
+               cl_snprintf(buf, len, buf_size, "| %3u |", BW_TO_MHZ(bw));
+
+               if (country_limit)
+                       cl_power_q8_to_buf(buf, len, buf_size, "   ",
+                                          country_val_q8, " |", true);
+               else
+                       cl_snprintf(buf, len, buf_size, "    X    |");
+
+               if (hardware_limit)
+                       cl_power_q8_to_buf(buf, len, buf_size, "    ",
+                                          hardware_val_q8, " |", true);
+               else
+                       cl_snprintf(buf, len, buf_size, "    X     |");
+
+               cl_power_q8_to_buf(buf, len, buf_size, "  ", eirp_val_q8, "=
 |\n", true);
+       }
+       cl_snprintf(buf, len, buf_size,
+                   "|-----------------------------------|\n"
+                   "(*) EIRP =3D MIN(COUNTRY, HARDWARE)\n\n");
+}
+
+static int cl_power_general_print(struct cl_hw *cl_hw)
+{
+       u8 channel =3D cl_hw->channel;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Power general information\n"
+                   "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D\n");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Channel               =3D %u\n", channel);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Standard              =3D %s\n",
+                   (cl_hw->channel_info.standard =3D=3D CL_STANDARD_FCC) ?
+                   "FCC" : "ETSI");
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Country code          =3D %s\n",
+                   cl_hw->chip->conf->ce_country_code);
+       cl_power_q8_to_buf(&buf, &len, &buf_size, "Antenna gain          =
=3D ",
+                          cl_power_antenna_gain_q8(cl_hw), "\n", false);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Power control percent =3D %u%%\n",
+                   cl_hw->power_db.curr_percentage);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "Power control offset  =3D %d\n",
+                   cl_hw->power_db.curr_offset);
+       cl_snprintf(&buf, &len, &buf_size,
+                   "VNS mode              =3D %u\n",
+                   cl_hw->conf->ci_vns_pwr_mode);
+
+       if (cl_hw->conf->ci_vns_pwr_mode)
+               cl_snprintf(&buf, &len, &buf_size,
+                           "VNS limit             =3D %d\n",
+                           cl_hw->conf->ci_vns_pwr_limit);
+
+       cl_power_print_limits(cl_hw, &buf, &len, &buf_size, channel);
+
+       cl_snprintf(&buf, &len, &buf_size,
+                   "!!! Notice:\n"
+                   "Conducted power =3D Calibrated power + PPMCS offset - =
EIRP delta value\n"
+                   "where EIRP delata value =3D Total - Truncated !!!\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_table_print_he(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       _cl_power_table_print_he(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_table_print_ht_vht(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (cl_band_is_6g(cl_hw))
+               return 0;
+
+       _cl_power_table_print_ht_vht(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_table_print_ofdm(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (cl_band_is_6g(cl_hw))
+               return 0;
+
+       _cl_power_table_print_ofdm(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_table_print_cck(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (!cl_band_is_24g(cl_hw))
+               return 0;
+
+       _cl_power_table_print_cck(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_trunc_print_he(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       _cl_power_trunc_print_he(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_trunc_print_ht_vht(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (cl_band_is_6g(cl_hw))
+               return 0;
+
+       _cl_power_trunc_print_ht_vht(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_trunc_print_ofdm(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (cl_band_is_6g(cl_hw))
+               return 0;
+
+       _cl_power_trunc_print_ofdm(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_trunc_print_cck(struct cl_hw *cl_hw)
+{
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int err =3D 0;
+       int len =3D 0;
+
+       if (!cl_band_is_24g(cl_hw))
+               return 0;
+
+       _cl_power_trunc_print_cck(cl_hw, &buf, &len, &buf_size);
+
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static void cl_power_auto_resp_to_buf(struct cl_hw *cl_hw, char **buf,
+                                     int *len, ssize_t *buf_size, u8 mode,
+                                     u8 max_mcs, s8 *pwr_auto_resp, const =
char *text)
+{
+       u8 mcs;
+       u8 tx_ant_num =3D cl_power_tx_ant(cl_hw, mode);
+       s32 ant_gain_q1 =3D cl_power_antenna_gain_q1(cl_hw);
+       s32 arr_gain_q1 =3D cl_power_array_gain_q1(cl_hw, tx_ant_num);
+       s32 conducted_q1, truncated_q1;
+
+       cl_snprintf(buf, len, buf_size,
+                   "\n%s Auto response\n"
+                   "|------------------|\n"
+                   "|MCS|Cond|Tot |Tab |\n"
+                   "|---+----+----+----|\n",
+                   text);
+
+       for (mcs =3D 0; mcs < max_mcs; mcs++) {
+               conducted_q1 =3D pwr_auto_resp[mcs] - arr_gain_q1;
+               truncated_q1 =3D pwr_auto_resp[mcs] + ant_gain_q1;
+
+               cl_snprintf(buf, len, buf_size,
+                           "|%3u|", mcs);
+               cl_power_q1_to_buf(buf, len, buf_size, "",
+                                  conducted_q1, "|", true);
+               cl_power_q1_to_buf(buf, len, buf_size, "",
+                                  truncated_q1, "|", true);
+               cl_power_q1_to_buf(buf, len, buf_size, "",
+                                  pwr_auto_resp[mcs], "|\n", true);
+       }
+
+       cl_snprintf(buf, len, buf_size,
+                   "|------------------|\n");
+}
+
+static int cl_power_auto_response_print(struct cl_hw *cl_hw)
+{
+       struct cl_pwr_tables *pwr_tables =3D &cl_hw->phy_data_info.data->pw=
r_tables;
+       char *buf =3D NULL;
+       ssize_t buf_size;
+       int len =3D 0;
+       int err =3D 0;
+       bool is_24g =3D cl_band_is_24g(cl_hw);
+       bool is_5g =3D cl_band_is_5g(cl_hw);
+       bool is_6g =3D cl_band_is_6g(cl_hw);
+
+       cl_power_auto_resp_to_buf(cl_hw, &buf, &len, &buf_size, WRS_MODE_HE=
, WRS_MCS_MAX_HE,
+                                 pwr_tables->pwr_auto_resp_he, "HE");
+
+       if (is_6g)
+               goto out;
+
+       if (is_5g || (is_24g && cl_hw->conf->ci_vht_cap_24g))
+               cl_power_auto_resp_to_buf(cl_hw, &buf, &len, &buf_size,
+                                         WRS_MODE_VHT, WRS_MCS_MAX_VHT,
+                                         pwr_tables->pwr_auto_resp_ht_vht,=
 "VHT/HT");
+       else
+               cl_power_auto_resp_to_buf(cl_hw, &buf, &len, &buf_size,
+                                         WRS_MODE_HT, WRS_MCS_MAX_HT,
+                                         pwr_tables->pwr_auto_resp_ht_vht,=
 "HT");
+
+       cl_power_auto_resp_to_buf(cl_hw, &buf, &len, &buf_size,
+                                 WRS_MODE_OFDM, WRS_MCS_MAX_OFDM,
+                                 pwr_tables->pwr_auto_resp_ofdm, "OFDM");
+
+       if (is_24g)
+               cl_power_auto_resp_to_buf(cl_hw, &buf, &len, &buf_size,
+                                         WRS_MODE_CCK, WRS_MCS_MAX_CCK,
+                                         pwr_tables->pwr_auto_resp_cck, "C=
CK");
+
+out:
+       err =3D cl_vendor_reply(cl_hw, buf, len);
+       kfree(buf);
+
+       return err;
+}
+
+static int cl_power_cli_help(struct cl_hw *cl_hw)
+{
+       char *buf =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
+       int err =3D 0;
+
+       if (!buf)
+               return -ENOMEM;
+
+       snprintf(buf, PAGE_SIZE,
+                "usage:\n"
+                "-a : General power information\n"
+                "-b : HE power table\n"
+                "-c : HT/VHT power table\n"
+                "-d : OFDM power table\n"
+                "-e : CCK power table\n"
+                "-f : HE power truncate\n"
+                "-g : HT/VHT power truncate\n"
+                "-h : OFDM power truncate\n"
+                "-i : CCK power truncate\n"
+                "-j : Auto-response power tables\n");
+
+       err =3D cl_vendor_reply(cl_hw, buf, strlen(buf));
+       kfree(buf);
+
+       return err;
+}
+
+int cl_power_cli(struct cl_hw *cl_hw, struct cli_params *cli_params)
+{
+       if (cli_params->num_params !=3D 0)
+               goto err_num_params;
+
+       switch (cli_params->option) {
+       case 'a':
+               return cl_power_general_print(cl_hw);
+       case 'b':
+               return cl_power_table_print_he(cl_hw);
+       case 'c':
+               return cl_power_table_print_ht_vht(cl_hw);
+       case 'd':
+               return cl_power_table_print_ofdm(cl_hw);
+       case 'e':
+               return cl_power_table_print_cck(cl_hw);
+       case 'f':
+               return cl_power_trunc_print_he(cl_hw);
+       case 'g':
+               return cl_power_trunc_print_ht_vht(cl_hw);
+       case 'h':
+               return cl_power_trunc_print_ofdm(cl_hw);
+       case 'i':
+               return cl_power_trunc_print_cck(cl_hw);
+       case 'j':
+               return cl_power_auto_response_print(cl_hw);
+       case '?':
+               return cl_power_cli_help(cl_hw);
+       default:
+               cl_dbg_err(cl_hw, "Illegal option (%c) - try '?' for help\n=
", cli_params->option);
+               break;
+       }
+
+       return 0;
+
+err_num_params:
+       cl_dbg_err(cl_hw, "Wrong number of arguments\n");
+
+       return 0;
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

