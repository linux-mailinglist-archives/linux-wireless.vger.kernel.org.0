Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DE83AB84E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhFQQGV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:21 -0400
Received: from mail-eopbgr140040.outbound.protection.outlook.com ([40.107.14.40]:17172
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233629AbhFQQGG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYtd12ranB87O95Rw6UveMOHZ7mWe/M4OMwQ5ZtmQO6sySi285ab1S+IhL7LX3l3efMrPfn7xvzFxFT84629oX21KFqRjR+6kd00wwCu3OL2e4kXygRcwqiwDFNlhqez2cFjf4Y+2iGq2sgfd/pqFNdJyHm/Vs2jqcJYlEz8EgbDeOsKX0HhPlXuXTJDsyjqlT1TWOyLlhoyyoG0+CRLgRsPgE/mVaJyOOOP8V+RT6syxfFuZBqj79NJNee/9I/aQQuwh3TEUa7SDM8jXFcCjVRJAVMvawUTpoazJt+n2w50ytIMhSXeUljo62VUVkf57HrrAC+szvZXxrzY/+zyeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx1Vni1dJuPhx24MSwcONUq6aLZxbJZu/piE5fSdh9g=;
 b=Z0/pyHqWkFrZxcUghcSHu2Gd10vKmu8FQYUCM3f4iOTIOyNZUatAhiV+gWSSsqy7jvvv1h2WbDi/GkMgXp3nq6Yuxhkpsj4WxO6kFK9pxd5kZ6xx+Wy53VV/JxCpfBarg6CK9TtOir4D1nweIAReCsoQAORANtHZ4OsX5orcdQsV8OgYXZ/cCleyjsahhsZSy7vm48TixTAUU9QSlRNGTd2Xt+1ke8cBmD+otUI94eBgMoVtuHvnDOrBp7T7Y2o6g84NgojZLGiYmJrVYA2FUIeGs+ok0wPa95di7tQzmV97NKt1G+cXwKUtuxI1kx3IpPKYpF5uM5UtLzjkP0Fe2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx1Vni1dJuPhx24MSwcONUq6aLZxbJZu/piE5fSdh9g=;
 b=nUbG7B0KaMJA0LIv5Jimk1WdLN3zPkYVki1m984y7tCepktd5g9+NCi6be9dKtKAFOTb7sx3H0866QNqbhBX6c0Jb24Fr+ThDCSQm2sYyvpQmkEior6YlaVvKfUeuek3TrBMSHbIt1gJliOyXaLfzQCSRAyD8u27+uyHhU6fw0w=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:45 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:45 +0000
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
Subject: [RFC v1 052/256] cl8k: add dbgfile.c
Date:   Thu, 17 Jun 2021 15:58:59 +0000
Message-Id: <20210617160223.160998-53-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a70c3f7c-4088-4c63-4b28-08d931a9739a
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB1234CB23C43242C07CD27917F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:133;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2o+UOROSWj5QqnQ2Pyf6Z8jf71TU1FitNOFgsUn0pWSB1MSIq9Wh42XgchWDUNzB53RiH/YRKMuEx0kASo8v6on7qoIzKfivR3e1y3YJzwEtvjQ6CM8BNbKtGxNZjs3Y8kN4vkLoDP9KyKSDzOeQK7Dch2pqag0XFVArWmyFbteEiitiDzniX56JMY1kXq/E3lzXO+dJbPP5VU8HSFBC2GE1kZIB2piklruUJOVdvkG0wRQpj9XHaSjabZzSVSf8ZVxipoxM3WhO0YsJxSHRPZ2bpUVAoKkKt/TK7QwwU0hqpEtrrUs9C8wNhaiHdP9NVYnyDKOu2l1TCshvGFBPjBNU7UsMHwo9mLtFf3otVO92AdunQJzaAim0cw2DKy0YUedY1P0NIswN6BnHaIZYHBuHVZk0CtPxuy5FQqKMzM06NBK0drofUVIlV+dPvQa65b/Ehm1tCMqRYca+q2inJ2D/I+vMJfIFhf8tULzmAi/ltk7eYMNnhg/IJjVVSaz12pPlC8AsibIloWNSDAHU/dLQFOza1EJNZgvUbmQJsVNUZ6s+hZzkPE3jTpuRuXBrg/YPU+ZUSLvIuyXFOv9Sb9rGo8PGGnhQnaOBHtjUX2Y3ycHr7P+sq8Rsyck+L1k+Es+Yf9gFIZGZDq4Z/aVoxb1ixErvYSTmmCoTay3DVux+NeziU3PHDHhRxpG7+oMnSZgZU8CwiDSw0TyADSuLQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(30864003)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DvQ028GU7VXPTthhP9RiKYgijmXdzyKc3x51HDC4otsY1fUCvS9N2RQvbIx8?=
 =?us-ascii?Q?UGpi1nCL2LG7wwhn+VByKbCFTJLbInjiATh77jKmIvfm64UdY34j785PN0P8?=
 =?us-ascii?Q?PoccsGf0cs1dgvPhrhMyj0QQ5p1eVTlFjZ+WGa+EDOWLQphprhSmiuQCRqji?=
 =?us-ascii?Q?HTLikGTq9H1nGMvfLAOSOTX0XgOScJbQiC6JwOl6NyHg/e4hYxHrqrC5U7yt?=
 =?us-ascii?Q?4A0o0wOH12tR0AjVNkvJSGeZJitnmLStMfzMABWdd0awzyPq01RpNTC8dt62?=
 =?us-ascii?Q?jL1nQviFB1jTerm1huJu/Y3NncnRPlBUdu0b+ojjKB6+r/ZbhYqFjwZawkyf?=
 =?us-ascii?Q?W/YQbBMM2aPxlsMCg2vFcv2U+pS34d8Ei06Dg05d7W1Bdllfcu/MEAu56PNd?=
 =?us-ascii?Q?m6jtu2osyR7zu34F5mgXWNO9iXuoDbgNPdoTg8dcZEgiuA7SQTLE4Z1GAzTl?=
 =?us-ascii?Q?Whn9Bv9BF6sEUph/jv0G2PODUEg4Z59Jm3NvsJnJ/O399YC0gKzpIgsROQVm?=
 =?us-ascii?Q?UX8gRC2XdEQ41uM02UDYvGgcyv+XocW+xfWgQZkt0HyF91aIaEVdaZSTY/Mn?=
 =?us-ascii?Q?86x8ImVAXr1i1SHi8+r2i80B5+LjZ3eo0q9rr14jcnIRl+SerbyJ+5VXdL/H?=
 =?us-ascii?Q?XWANrAFEoE+JO8L7hxuv4r2NX0h2R4Gg4ipHUmKQyMKuVnMHAA1b7XLkPCmJ?=
 =?us-ascii?Q?S1+mRkRiNCrtFgiflNot3Tv4+wI6o9gZbeDzlYo/huulqMbtqEc2+LHBb+/u?=
 =?us-ascii?Q?uU1vAZPlZVD2sl8XrLbCtNaRmVppOdapSeevAhTQ+lfvZR1pnm7HDQMMXmQZ?=
 =?us-ascii?Q?u1Juwwm9rigf80vL6GiUCtBdHEZoKO+DObUbJdeXR7tHUlUkNpXsxGimrTSN?=
 =?us-ascii?Q?ijB+F+zd/BGIaZvkPpLcLhMvsdmwcwGRTOLn1jVzE5hhzZfyNDhjDeJ/IxL8?=
 =?us-ascii?Q?rL2ag9wpX4pEYoRuCwC0rNcPjC7UFcZ255oc/U8BxGs72ib1+tMVUlGd0LQQ?=
 =?us-ascii?Q?CQTapUHhML9sZVUqR7xe+imOXM6bW1nPzxLb0irUy9I+TUbHpovKURYaDf5g?=
 =?us-ascii?Q?VMtZnLMjoR6afZpPtY6pTcOVl4YCRGnm+BBg62NKklL+2Ime20OY8xmJbwX9?=
 =?us-ascii?Q?xOa5oEZtEiIxDDhPda7ML48AHxlj0Md1Z7FORMWSr1ROqSbjfGKTTEDTm+NY?=
 =?us-ascii?Q?kXcrESZ1Bc5CbCwYJoNWGlV6WxPaQ4SWqZ/kv8DaHotNGJ4ySW+Q2vIfJ5iS?=
 =?us-ascii?Q?CyIZklw7wQoh7HM6lwAvr4N+7SUHReoOrgbInz5979jtkUwf1iG2U6nC5eEC?=
 =?us-ascii?Q?RxFV3ZnhqL0aVo4s6sf0L6GO?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70c3f7c-4088-4c63-4b28-08d931a9739a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:31.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5r54cEFvgdrV2arz3O1kbXR8v6wIDQZE1BHg3QL+rCJzhzCVcuE+dnOydxyHHAYBQQPbyTify3MzKaw3Hcbsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dbgfile.c | 438 +++++++++++++++++++++
 1 file changed, 438 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dbgfile.c

diff --git a/drivers/net/wireless/celeno/cl8k/dbgfile.c b/drivers/net/wirel=
ess/celeno/cl8k/dbgfile.c
new file mode 100644
index 000000000000..1e8aebbe91f4
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dbgfile.c
@@ -0,0 +1,438 @@
+// SPDX-License-Identifier: MIT
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#include <linux/ctype.h>
+#include "dbgfile.h"
+#include "reg/reg_access.h"
+#include "utils/utils.h"
+#include "dbgfile.h"
+
+const char *cl_dbgfile_get_msg_txt(struct cl_dbg_data *dbg_data, int file_=
id, int line)
+{
+       /* Get the message text from the .dbg file by fileid & line number =
*/
+       int remaining_bytes =3D dbg_data->size;
+       const char *str =3D dbg_data->str;
+       char id_str[32];
+       int idstr_len;
+
+       if (!str || 0 =3D=3D remaining_bytes)
+               return NULL;
+
+       idstr_len =3D snprintf(id_str, sizeof(id_str), "%hu:%hu:", file_id,=
 line);
+
+       /* Skip hash */
+       while (*str++ !=3D '\n')
+               ;
+
+       remaining_bytes -=3D (str - (char *)dbg_data->str);
+
+       while (remaining_bytes > 0) {
+               if (strncmp(id_str, str, idstr_len) =3D=3D 0) {
+                       str +=3D idstr_len;
+                       while (*str =3D=3D ' ')
+                               ++str;
+                       return (const char *)str;
+               }
+
+               str +=3D strnlen(str, 512) + 1;
+               remaining_bytes =3D dbg_data->size - (str - (char *)dbg_dat=
a->str);
+       }
+
+       /* No match found */
+       pr_err("error: file_id=3D%d line=3D%d not found in debug print file=
\n", file_id, line);
+       return NULL;
+}
+
+void cl_dbgfile_parse(struct cl_hw *cl_hw, void *edata, u32 esize)
+{
+       /* Parse & store the firmware debug file */
+       struct cl_dbg_data *dbg_data =3D &cl_hw->dbg_data;
+
+       dbg_data->size =3D esize;
+       dbg_data->str =3D edata;
+}
+
+void cl_dbgfile_release_mem(struct cl_dbg_data *dbg_data,
+                           struct cl_str_offload_env *str_offload_env)
+{
+       dbg_data->str =3D NULL;
+
+       str_offload_env->enabled =3D false;
+       str_offload_env->block1 =3D NULL;
+       str_offload_env->block2 =3D NULL;
+}
+
+/*
+ * Store debug print offload data
+ * - part 1: offloaded block that does not exist on target
+ * - part 2: resident block that remains on target [optional]
+ */
+int cl_dbgfile_store_offload_data(struct cl_chip *chip, struct cl_hw *cl_h=
w,
+                                 void *data1, u32 size1, u32 base1,
+                                 void *data2, u32 size2, u32 base2,
+                                 void *data3, u32 size3, u32 base3)
+{
+       u32 u =3D size1;
+       struct cl_str_offload_env *str_offload_env =3D &cl_hw->str_offload_=
env;
+
+       if (u > 200000)
+               goto err_too_big;
+
+       /* TODO we modify offload data! if caller checks integrity, make a =
copy? */
+       str_offload_env->block1 =3D data1;
+       str_offload_env->size1 =3D size1;
+       str_offload_env->base1 =3D base1;
+
+       str_offload_env->block2 =3D data2;
+       str_offload_env->size2 =3D size2;
+       str_offload_env->base2 =3D base2;
+
+       str_offload_env->block3 =3D data3;
+       str_offload_env->size3 =3D size3;
+       str_offload_env->base3 =3D base3;
+
+       str_offload_env->enabled =3D true;
+
+       cl_dbg_info(cl_hw, "%cmac%u: FW prints offload memory use =3D %uK\n=
",
+                   cl_hw->fw_prefix, chip->idx, (size1 + size2 + 1023) / 1=
024);
+
+       return 0;
+
+err_too_big:
+       pr_err("%s: size too big: %u\n", __func__, u);
+       return 1;
+}
+
+static void do_print_n(struct cl_hw *cl_hw, const char *str, int n)
+{
+       /* Print formatted string with "band" prefix */
+       if (n < 0 || n > 256) {
+               cl_dbg_err(cl_hw, "%cmac%u: *** FW PRINT - BAD SIZE: %d\n",
+                          cl_hw->fw_prefix, cl_hw->chip->idx, n);
+               return;
+       }
+
+       cl_dbg_verbose(cl_hw, "%cmac%u: %.*s\n", cl_hw->fw_prefix, cl_hw->c=
hip->idx, n, str);
+}
+
+static void do_hex_dump_bytes(struct cl_hw *cl_hw, u32 addr, void *data, u=
32 count)
+{
+       cl_dbg_verbose(cl_hw, "%cmac%u: hex dump:\n", cl_hw->fw_prefix, cl_=
hw->chip->idx);
+       cl_hex_dump(NULL, data, count, addr, true);
+}
+
+#define MAGIC_PRINT_OFFLOAD   0xFA  /* 1st (low) byte of signature */
+/* 2-nd signature byte */
+#define MAGIC_PRINT_OFF_XDUMP 0xD0  /* Hex dump, by bytes */
+#define MAGIC_PRINT_OFF_LIT   0x01  /* Literal/preformatted string */
+#define MAGIC_PRINT_OFF_PRINT 0x02  /* Print with 'virtual' format string =
*/
+
+#define MAX_PRINT_OFF_PARAMS  20
+
+static int offload_print(struct cl_str_offload_env *str_offload_env, char =
*fmt, const char *params)
+{
+       static char buf[1024] =3D {0};
+       const char *cur_prm =3D params;
+       char tmp;
+       char *fmt_end =3D fmt;
+       size_t size =3D sizeof(int);
+       int len =3D 0;
+
+       union v {
+               u32 val32;
+               u64 val64;
+               ptrdiff_t str;
+       } v;
+
+       while ((fmt_end =3D strchr(fmt_end, '%'))) {
+               fmt_end++;
+
+               /* Skip '%%'. */
+               if (*fmt_end =3D=3D '%') {
+                       fmt_end++;
+                       continue;
+               }
+
+               /* Skip flags. */
+               while (strchr("-+ 0#", *fmt_end))
+                       fmt_end++;
+
+               /* Skip width. */
+               while (isdigit(*fmt_end))
+                       fmt_end++;
+
+               /* Skip precision. */
+               if (*fmt_end =3D=3D '.') {
+                       while (*fmt_end =3D=3D '-' || *fmt_end =3D=3D '+')
+                               fmt_end++;
+
+                       while (isdigit(*fmt_end))
+                               fmt_end++;
+               }
+
+               /* Get size. */
+               if (*fmt_end =3D=3D 'z') {
+                       /* Remove 'z' from %zu, %zd, %zx and %zX,
+                        * because sizeof(size_t) =3D=3D 4 in the firmware.
+                        * 'z' can only appear in front of 'd', 'u', 'x' or=
 'X'.
+                        */
+                       if (!strchr("duxX", *(fmt_end + 1)))
+                               return -1;
+
+                       fmt_end++;
+                       size =3D 4;
+               } else if (*fmt_end =3D=3D 'l') {
+                       fmt_end++;
+
+                       if (*fmt_end =3D=3D 'l') {
+                               fmt_end++;
+                               size =3D sizeof(long long);
+                       } else {
+                               size =3D sizeof(long);
+                       }
+
+                       if (*fmt_end =3D=3D 'p') /* %p can't get 'l' or 'll=
' modifiers. */
+                               return -1;
+               } else {
+                       size =3D 4;
+               }
+
+               /* Get parameter. */
+               switch (*fmt_end) {
+               case 'p': /* Replace %p with %x, because the firmware's poi=
nters are 32 bit wide */
+                       *fmt_end =3D 'x';
+                       fallthrough;
+               case 'd':
+               case 'u':
+               case 'x':
+               case 'X':
+                       if (size =3D=3D 4)
+                               v.val32 =3D __le32_to_cpu(*(__le32 *)cur_pr=
m);
+                       else
+                               v.val64 =3D __le64_to_cpu(*(__le64 *)cur_pr=
m);
+                       cur_prm +=3D size;
+                       break;
+               case 's':
+                       v.str =3D __le32_to_cpu(*(__le32 *)cur_prm);
+                       cur_prm +=3D 4;
+                       size =3D sizeof(ptrdiff_t);
+
+                       if (v.str >=3D str_offload_env->base3 &&
+                           v.str < str_offload_env->base3 + str_offload_en=
v->size3) {
+                               v.str -=3D str_offload_env->base3;
+                               v.str +=3D (ptrdiff_t)str_offload_env->bloc=
k3;
+                       } else if (v.str >=3D str_offload_env->base2 &&
+                                  v.str < str_offload_env->base2 + str_off=
load_env->size2) {
+                               v.str -=3D str_offload_env->base2;
+                               v.str +=3D (ptrdiff_t)str_offload_env->bloc=
k2;
+                       } else
+                               return -1;
+
+                       break;
+               default:
+                       return -1;
+               }
+
+               /* Print into buffer. */
+               fmt_end++;
+               tmp =3D *fmt_end; /* Truncate the format to the current poi=
nt and then restore. */
+               *fmt_end =3D 0;
+               len +=3D snprintf(buf + len, sizeof(buf) - len, fmt, size =
=3D=3D 4 ? v.val32 : v.val64);
+               *fmt_end =3D tmp;
+               fmt =3D fmt_end;
+       }
+
+       snprintf(buf + len, sizeof(buf) - len, "%s", fmt);
+
+       pr_debug("%s", buf);
+
+       return 0;
+}
+
+struct pr_off_desc {
+       u8 file_id;
+       u8 flag;
+       __le16 line_num;
+       char fmt[];
+};
+
+char *strreplace(char *s, char old, char new)
+{
+       for (; *s; ++s)
+               if (*s =3D=3D old)
+                       *s =3D new;
+       return s;
+}
+
+static int do_dprint(struct cl_hw *cl_hw, u32 fmtaddr, u32 nparams, u32 *p=
arams)
+{
+       /*
+        * fmtaddr - virtual address of format descriptor in firmware,
+        *           must be in the offloaded segment
+        * nparams - size of parameters array in u32; min=3D0, max=3DMAX_PR=
INT_OFF_PARAMS
+        * params  - array of parameters[nparams]
+        */
+       struct cl_str_offload_env *str_offload_env =3D &cl_hw->str_offload_=
env;
+       struct pr_off_desc *pfmt =3D NULL;
+
+       if (!str_offload_env->enabled)
+               return -1;
+
+       if (fmtaddr & 0x3)
+               cl_dbg_warn(cl_hw, "FW PRINT - format not aligned on 4? %8.=
8X\n", fmtaddr);
+
+       if (fmtaddr > str_offload_env->base1 &&
+           fmtaddr < (str_offload_env->base1 + str_offload_env->size1)) {
+               pfmt =3D (void *)((fmtaddr - str_offload_env->base1) + str_=
offload_env->block1);
+       } else {
+               cl_dbg_err(cl_hw, "FW PRINT - format not in allowed area %8=
.8X\n", fmtaddr);
+               return -1;
+       }
+
+       /*
+        * Current string sent by firmware is #mac@ where # is '253' and @ =
is '254'
+        * Replace '253' with 'l' or 's' according to the fw_prefix.
+        * Replace '254' with '0' or '1' according to chip index.
+        */
+       strreplace(pfmt->fmt, (char)253, cl_hw->fw_prefix);
+       strreplace(pfmt->fmt, (char)254, (cl_hw->chip->idx =3D=3D CHIP0) ? =
'0' : '1');
+
+       if (offload_print(str_offload_env, pfmt->fmt, (char *)params) =3D=
=3D -1) {
+               cl_dbg_err(cl_hw, "FW PRINT - ERROR in format! (file %u:%u)=
\n",
+                          pfmt->file_id, pfmt->line_num);
+               /* $$$ dbg dump the struct */
+               cl_hex_dump(NULL, (void *)pfmt, 48, fmtaddr, true);
+               return -1;
+       }
+
+       return 0;
+}
+
+static int do_offload(struct cl_hw *cl_hw, u8 *data, int bytes_remaining)
+{
+       u8 magic2 =3D data[1];
+       u32 nb =3D data[2] + (data[3] << 8); /* Following size in bytes */
+       /* DATA IS UNALIGNED! REVISE if alignment required or BIG ENDIAN! *=
/
+       __le32 *dp =3D (__le32 *)data;
+       int bytes_consumed =3D 4; /* 1 + 1 + 2 */
+
+       /* Data: [0] u8 magic1, u8 magic2, u16 following size in bytes */
+       if (bytes_remaining < 8) {
+               cl_dbg_err(cl_hw, "*** FW PRINT - OFFLOAD PACKET TOO SHORT:=
 %d\n",
+                          bytes_remaining);
+               return bytes_remaining;
+       }
+
+       if (bytes_remaining < (nb + bytes_consumed)) {
+               cl_dbg_err(cl_hw, "*** FW PRINT - OFFLOAD PACKET %u > remai=
nder %d??\n",
+                          nb, bytes_remaining);
+               return bytes_remaining;
+       }
+
+       switch (magic2) {
+       case MAGIC_PRINT_OFF_PRINT: {
+               /*
+                * [1] u32 format descriptor ptr
+                * [2] u32[] parameters
+                */
+               u32 fmtp =3D dp[1];
+               u32 np =3D (nb - 4) / 4; /* Number of printf parameters */
+
+               if (nb < 4 || nb & 3)  {
+                       cl_dbg_err(cl_hw, "*** FW PRINT - bad pkt size: %u\=
n", nb);
+                       goto err;
+               }
+
+               do_dprint(cl_hw, fmtp, np, &dp[2]);
+
+               bytes_consumed +=3D nb; /* Already padded to 4 bytes */
+               }
+               break;
+
+       case MAGIC_PRINT_OFF_LIT: {
+               /* [1] Remaining bytes: literal string */
+               do_print_n(cl_hw, (char *)&dp[1], nb);
+               bytes_consumed +=3D ((nb + 3) / 4) * 4; /* Padding to 4 byt=
es */
+               }
+               break;
+
+       case MAGIC_PRINT_OFF_XDUMP:
+               /* [1] bytes[nb] */
+               if (nb >=3D 1)
+                       do_hex_dump_bytes(cl_hw, 0, &dp[1], nb);
+
+               bytes_consumed +=3D ((nb + 3) / 4) * 4; /* Padding to 4 byt=
es */
+               break;
+
+       default:
+               cl_dbg_err(cl_hw, "*** FW PRINT - BAD TYPE: %4.4X\n", magic=
2);
+               goto err;
+       }
+
+       return bytes_consumed;
+
+err:
+       return bytes_remaining; /* Skip all */
+}
+
+void cl_dbgfile_print_fw_str(struct cl_hw *cl_hw, u8 *str, int max_size)
+{
+       /* Handler for firmware debug prints */
+       int bytes_remaining =3D max_size;
+       int i;
+       u8 delim =3D 0;
+
+       while (bytes_remaining > 0) {
+               /* Scan for normal print data: */
+               for (i =3D 0; i < bytes_remaining; i++) {
+                       if (str[i] < ' ' || str[i] >=3D 0x7F) {
+                               if (str[i] =3D=3D '\t')
+                                       continue;
+                               delim =3D str[i];
+                               break;
+                       }
+               }
+
+               if (i > 0) {
+                       if (delim =3D=3D '\n') {
+                               bytes_remaining -=3D i + 1;
+                               do_print_n(cl_hw, str, i);
+                               str +=3D i + 1;
+                               continue;
+                       }
+
+                       if (delim !=3D MAGIC_PRINT_OFFLOAD) {
+                               do_print_n(cl_hw, str, i);
+                               bytes_remaining -=3D i;
+                               return; /* Better stop parsing this */
+                       }
+                       /* Found offload packet but previous string not ter=
minated: */
+                       do_print_n(cl_hw, str, i);
+                       cl_dbg_err(cl_hw, "*** FW PRINT - NO LINE END2\n");
+                       bytes_remaining -=3D i;
+                       str +=3D i;
+                       continue;
+               }
+
+               /* Delimiter at offset 0 */
+               switch (delim) {
+               case '\n':
+                       do_print_n(cl_hw, " ", 1); /* Print empty line */
+                       str++;
+                       bytes_remaining--;
+                       continue;
+               case 0:
+                       return;
+               case MAGIC_PRINT_OFFLOAD:
+                       i =3D do_offload(cl_hw, str, bytes_remaining);
+                       bytes_remaining -=3D i;
+                       str +=3D i;
+                       break;
+               default:
+                       cl_dbg_err(cl_hw, "*** FW PRINT - BAD BYTE=3D%2.2X =
! rem=3D%d\n",
+                                  delim, bytes_remaining);
+                       return; /* Better stop parsing this */
+               }
+       }
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

