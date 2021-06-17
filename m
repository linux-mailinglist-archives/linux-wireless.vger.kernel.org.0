Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A73AB854
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhFQQGd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:33 -0400
Received: from mail-eopbgr140042.outbound.protection.outlook.com ([40.107.14.42]:47438
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233582AbhFQQGI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y7c5S0uJ4qp2tnwjL0HO4LcaGqrH48MBvRvz6BTFa+y1NRFP9iVgbsJC+cd3ApHNnSe+NkkHqX1OKI0sH4cSLwaRuk22njvlpjIbKfNE1NocMBCAFqPkgYiZ5IPkyHM5zPeDJwTS8b/Kr+48tsUPYJp6AkNpEBqeK6R2ec7EAa/BLzoj6UzXWoE33QwWp49bKQgscpIKncsQEPRXAzPh+RzroVqmDetbxIEt749ilT/0K8pD3/aUf/+73mPRRAp37eReJxkFHlBVga0cvxJeLLN7J3Km6oClfpRWSflah1iHq0Q7fpwsoJVSmbsjSYEuaq7am7IT3HIUDOl0ZqdhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwMDu0msIVwlnONpHqE28GII2DYsZwM/my09z35xb4k=;
 b=Bkqo1+gV1SDG7+AgEO7FP8adJVpEnAy7vr0KRXXv7LNI3CpkLk9qi/S6t1PgMqUKcHPa6VUGwRvybX3yq2wPJww598esrqowL4iyC6KwzA7DcLsWvoTv41udzdAoEgRct76zTKubocj1F4jvqUzWcOg8Dr5/1NTVmP04mDiE/EkXximZHj1itiz2wILsITg1iNKJfE0qom1StLmK3W1l2wWyIC+nMJu8bwkkwWMs44QGGW2Bk4aso4MGoRWoWrTG3sh1NN1nuFlCRdZeKgGx2sKixf87K9DeHpPj/FqGLCKhreoXjnR4eYD6D6uEElqYVSNP1XdZd2OCG4MBQ11z1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwMDu0msIVwlnONpHqE28GII2DYsZwM/my09z35xb4k=;
 b=nA1Ga2VI7tU4vGaAtfLejptgDQ6ZCYaZwV3SAeKWqFH2rUM1bpxNYKnNqB7Go4gA7xM4EQM5VOXESSzD8y9ko7z+y8MeqdfKdyUnSSomPwoKdgbEL173a6My74Bv8bOdV/v4PorA2GZe3ZB7F32GEG4kqBWJw5S13qJ+gTxqCFY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM9P192MB1234.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 16:03:46 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:46 +0000
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
Subject: [RFC v1 053/256] cl8k: add dbgfile.h
Date:   Thu, 17 Jun 2021 15:59:00 +0000
Message-Id: <20210617160223.160998-54-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e3d67b3-aa0a-40ee-16da-08d931a9743c
X-MS-TrafficTypeDiagnostic: AM9P192MB1234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9P192MB12347D5A8C8BBCB43B02B518F60E9@AM9P192MB1234.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qKXqXWEh1Fe9q5MbqGjulTVmr4QNppx1uc2M1vSdXmJ5udmLEUHjGllxQow8L0bQ81QxbC+x7Hox/305RlJqq8oo3wcfotQUY8admpJmZGbh4HYRm1+2zRQPnS4cQEpL++RKFXWoqDb7eX+Lh5c6g1B/FT+B0bzSy0mqvz97O+JSxJWV56UG9KPGEySFP7/cYK0v0FESX25l+XHoI7fNUDGsK6np5ONkXTSz5iur9U+/+C4XfHgDt1PnhJCVNxV0CoeizUwKcK87FwgG7zm6DBCc4oeAE5tj726msIEBpQFJLSqWLC+ufltZfG96+s8atZbr7mOhjqTDzAgOIzgS6ISOO0jVVqpMG7zmpNNqpnRzoQUCv16P8hzTzTSzfhZ3vjShp6MnTJj7vDeabO/CcSqS3DZ6El6X1ji2CvN3+Qk6KBJaHHHEiOB8gBoCQju0ADwEzuOnjjREoLo216JMEaH0wYhxLkMAq/zUD1rvNe8WjFr8Yroo+2zhbsd9Cc9URamQxKwYl/TRlvxI7ZZRNNZbruesF8dxCX1wBly+lz+xz/pl+yJCHf2gk69EH9egShzOnjUjIQTJLorqeGol6V0wS59O/Ipx2xSDw0ztTURaWRL4iCB/r1t19TdsagCmy0OmrkMH5t4ZFcxx2Y7k2mgnwgswO/XPwqxbMuPkM7Q/eKK+Ba5gM1xWHO1fi54naOrOGEmcML4WXT67gZxNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(396003)(39850400004)(6666004)(107886003)(36756003)(956004)(66476007)(66556008)(2616005)(66946007)(6916009)(2906002)(26005)(9686003)(1076003)(6512007)(6486002)(16526019)(6506007)(38100700002)(52116002)(86362001)(8936002)(316002)(38350700002)(186003)(55236004)(54906003)(8676002)(5660300002)(508600001)(83380400001)(4326008)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?llu4UaLHrwplwrxUatCc3Cas0+iANH06yFEtJRhxFLk+i695LAH/AdL6l81e?=
 =?us-ascii?Q?6BZAAD/HiZi7FT8yd2eOGutqN1mc7WgnrgsabL1dPlnUa4dpLtbsO6mgBqJY?=
 =?us-ascii?Q?INXqKWV9aAPyStcdDgyGfmq7Qm/vhtFRqLM58w3rtfVavu0EzkIA3DPPwKzq?=
 =?us-ascii?Q?3bS8jU1RcpRZg65fhUHvNj0L5p4+2fTywbw5WxKuYeHG2zL93Wa38FQnX7vP?=
 =?us-ascii?Q?9A8ue2xKq/OAiSPKIYBzT2xwVgUJJqgZm/YQVlZAUeG4tsiNJGS0O4NT10ns?=
 =?us-ascii?Q?3IDBqMJlZxNQFBIpQsN326PGZHotD99ry0qLV5t6CUmLbThkLntFlW277sSt?=
 =?us-ascii?Q?i7Q04SsMmXVTxueqiiHwYFWckOROUx13z+HBEG+44rUwCUTiGH77dmhXLwcI?=
 =?us-ascii?Q?l4RwfRdSaerRbwlyYIo3ls3CEFNfTsnGwdt6qxkKryAOAZbYKmfvYzvweLGB?=
 =?us-ascii?Q?bvHarV+axf2rFvyvfubQ1GgWi+9j/IcWDLigZUQBrEW4evFQsqTH+sk7Tgfo?=
 =?us-ascii?Q?zLsZqAeC2LQ5NVE41AkzmF4X3TgSq6apYxHR63Bffm4uLsnjQG1ljC+oYEsc?=
 =?us-ascii?Q?kUDzxTamW2zUuoU6jWw7qxbEVO3JfpYS4qffRCc6Wh4ubY36NzvnbDO0c13m?=
 =?us-ascii?Q?5GTcu20HASg67+RVCWRZlePp0fQATH33zZ9rIaPGxWUndEJrAyXN4VX7bDBm?=
 =?us-ascii?Q?pkhxBKjVKgK1OwyqObud9xWv6sb7swwZAI/vryfHLispJFxUz7F7RTW8y/5W?=
 =?us-ascii?Q?QqkMJ9eLrsOngnN1+OF/BhaJ1Dakfs5u62Y2BsLCMLGxdRnjAblBhNQKbVUf?=
 =?us-ascii?Q?fqmRYNeBClkHqB46VZo7lpzYwEPZyvItENpMMS9PxCTVcr7wSU5I3onZEtpB?=
 =?us-ascii?Q?olDpgmCpkSlRzAsT5yQXzN3+K8lxYbJeq5o+mZyFelmRSeU4Y58dRprD7ASK?=
 =?us-ascii?Q?dFc1N2Wtwb68jLAkowlg5lIacStHZ+G3H+QQddqtDFQBFPdi0j8yYnkPGRYR?=
 =?us-ascii?Q?TvYxgWmMot1tqw05MpqpUM2ZiHt2Xe2rLCBTLhCXFqZRu/CqYxedmmSqWi4W?=
 =?us-ascii?Q?nW+h++KmxCWvAt0mU4YzqrHf5FHODiFDcQrabI6DnB6jewx5/M+X9z0nkkLU?=
 =?us-ascii?Q?SXQOeDcYm0IG92JQ8tRcwkIE8xBuESMhVwwNJ5abz02KUpUFFXlbTeuuUs1H?=
 =?us-ascii?Q?9QMKCgsQwLOR5yd/SWr44/xBE55yEj7vjr9vDAr21+WHU5nK39SqPqsU17fS?=
 =?us-ascii?Q?IIumam9CWCL8de5M4+cqCw18dulYhpKNqKreb3wuMyKu8qaGKnf+Lsv/ApUW?=
 =?us-ascii?Q?KgfVsI9QZB2vz7saiyHChYdv?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3d67b3-aa0a-40ee-16da-08d931a9743c
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:32.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gL1imAbc7LhQKaAeDAWVoThxd+0PBnPKx0xyrTf9dpKK8pNI0CLa0sddld0sSbp61J0U+/PJatQydsutueHuEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB1234
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/dbgfile.h | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/dbgfile.h

diff --git a/drivers/net/wireless/celeno/cl8k/dbgfile.h b/drivers/net/wirel=
ess/celeno/cl8k/dbgfile.h
new file mode 100644
index 000000000000..d089fdbbc3ae
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/dbgfile.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DBGFILE_H
+#define CL_DBGFILE_H
+
+#include "hw.h"
+
+#define DBG_FILE_MAX_ASSERT_LEN 256
+#define DBG_FILE_MAX_PRINT_LEN  350
+
+void cl_dbgfile_parse(struct cl_hw *cl_hw, void *edata, u32 esize);
+const char *cl_dbgfile_get_msg_txt(struct cl_dbg_data *dbg_data, int filei=
d, int line);
+void cl_dbgfile_release_mem(struct cl_dbg_data *dbg_data,
+                           struct cl_str_offload_env *str_offload_env);
+void cl_dbgfile_print_fw_str(struct cl_hw *cl_hw, u8 *str, int max_size);
+int cl_dbgfile_store_offload_data(struct cl_chip *chip, struct cl_hw *cl_h=
w,
+                                 void *data1, u32 size1, u32 base1,
+                                 void *data2, u32 size2, u32 base2,
+                                 void *data3, u32 size3, u32 base3);
+const char *cl_dbgfile_get_msg_txt(struct cl_dbg_data *dbg_data, int file_=
id, int line);
+
+#endif /* CL_DBGFILE_H */
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

