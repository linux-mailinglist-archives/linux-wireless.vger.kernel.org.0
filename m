Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD43532930
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236794AbiEXLiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbiEXLiN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:38:13 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763E43382
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCAWeHbxzNadOVaUquWkUi2/N1F/pvcz0h1qGBAhi46R42QzpR3mOHxtUb6EWlepvVf2AG7NEEZ+4cKnpMlaUAvxROq4PrjXppD2oV0IGRFgdTsGJ/tgazBmcLg547Fs1/ljgAYjkscErwYXSLgqpmT3SYhyTLyJt2vvr0L8p9DQ5jy9w4gabRAQeLwU6dJMhSk7o3LiIHGvATSuJqrHhszNdNbIYF+SzrTyhcsg/HxVryKxQJR/PIhhT6055fOKXQQLAXRj/kUR02e/m+BaiYL0QgilQckOSj5ZOHBvOeDL0NT14sqLVr0e5P1nRAE8rfKemZSgYuflT4fSiS5T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NS5yavrzXglgWZOKCg1jKxmVi8wSp7Y3hV4xwwv6mg=;
 b=DHNMRRkzBHLUmeXxUNbagzg2OXimqi+6saeUl54rTi4fcg3CPz4xib4eQ7uXq84kJilZ+aIyuylAFfl5ZCbVWJOzPBrnn1PT0eiRfd2IPQ9hZ2rReo6NrxdI7Acv22h9qI9UZwigUCo45vFgN+2aUucPQL20e1qxu7WGfsLUc32SSt4xuUWHw88CnwVR+2CvUViq160SC2FYixI1z1xdu7KCOm/eaiwd6tHmI4/9LCX30XERowiOeHLMUC2LWkswT50ShMuooGhd+LXN4SayXfUzdLO7610tc7CEoIskVXdUVOLZgHCqq61+s4mNitLIz1J+MpKJh6EtLcnztD5ypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NS5yavrzXglgWZOKCg1jKxmVi8wSp7Y3hV4xwwv6mg=;
 b=cIsaf+cBiNtRwZ1omRhtXYK+NRO6GvRhPRH4j7oKVVB4jIKCs8jJJow6uLGKQWlgQPPPTMuSbwlOA9I8pabgO9ThDMTQQsLT9Q3E3UDJWdat7lyviN/PZGxST3JatVM/l7i7LZBL114KBijf0KzY2s0+6YlIP94Klr7zlT9Hn8g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM6P192MB0469.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:37:55 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:37:55 +0000
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
Subject: [RFC v2 17/96] cl8k: add debug.c
Date:   Tue, 24 May 2022 14:33:43 +0300
Message-Id: <20220524113502.1094459-18-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d4a8757-da98-426e-c3e4-08da3d79d821
X-MS-TrafficTypeDiagnostic: AM6P192MB0469:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <AM6P192MB04698E836C7E67A6444C4E4EF6D79@AM6P192MB0469.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oR028BBuprapjVpEO47BT7Nl6joAbUgTS5MERqY+d95MZHJYm/sDLlBgiU4dfcRPOV2SyJXz5LBgFSjHmnk7VfhQNQyoVs6nB0RVn9tsXlwqGNty0xUmPQ1cUUz6rLKP742pTmMzmEIQYXJSyL3qRG4mdKnHzEl+C7KnLVb2fATsbncFPk+dl5DFsEdwhQiYBbUBK5jFyVZTVFP4eLcl7NDVtbdkYh3ScbTBkVgxZu/J4zfSofhaHJBCcRRB5ANgY5HsgL+f4mI8/+Onn7H3zfznYXKU52SNnTYQal6U9kwlhOBpYvkypDjtWwRy4MSrXICE5LNhnMyi5YKrDbXQtCayLWhR1OY2JYz4aWDuDlV1noTKgI1XpVX3l/NKkmKGXDMWjkCVdWhaa5sUbU4cElPNU9quf82UPoEqnbfew31/Zrj6wvkML2QC1064lXfnlJGiOfadOtVnt8DSDQdiE1i1kEMK154YNt5ELZEjBqi8SZk461Ml3HnjtIgVbaTgwrR5soTHMC2xj6gS2zLr8oihq1GC92hJyRDrXPHW/wAClFz0zcDTsHW07/oft/ZRMrB9dEDgrFUeBi3e2JjZDavvs9CYMlieePxCnTyZcq5/QlXi68S+Ou2hEImRUk0b3tr5Z6S4BUK16uvtX7vc1KGvOUjfbL94jn9rfVNFF/hP3U5kLKT+DGpwIVLK2pQiDJea4l+H1hu0Wo6VyCgRe/HVsk88NtSMFIcesHzPtzQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(376002)(136003)(366004)(39850400004)(6486002)(30864003)(6916009)(508600001)(8936002)(86362001)(2906002)(5660300002)(4326008)(1076003)(83380400001)(36756003)(38100700002)(41300700001)(52116002)(186003)(66556008)(2616005)(6506007)(6512007)(26005)(316002)(54906003)(107886003)(8676002)(9686003)(66476007)(38350700002)(66946007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1PFgkOq2styQXbj+6b7o76X9caDtRcGrymbK2pICxvQWEKT0RNX2A/oCBLjW?=
 =?us-ascii?Q?xcuYA2jOVRW0TMjW4dTbqa3evRZi/Vg/a5+mWE6oiwckyQd+PIErmCPI8TnP?=
 =?us-ascii?Q?Vl2PeHNM6X3CK2xjTwevNO17GbiEXLyjORXaVv+yS5erfyR+K1fPoKRfn4Ux?=
 =?us-ascii?Q?vs2uDvxSwyYeInosoYxm4WydMWQdleCXpFf0hkeVgV9v/Xk+L8ngFL2N5TSq?=
 =?us-ascii?Q?+mMTuCzK+dRX2f5iuNrm6L6uF27A9G+nuocttvIM3kFjxet7qH6dgENuBb/O?=
 =?us-ascii?Q?P5wGpLUcIz4mXGO1hyDojPi0rc4ZRnLsfOY+JOesAUQvAHUouQnVw/0Zm5DT?=
 =?us-ascii?Q?87XAApSgMS3M8ZdzanHgGqw0K0lv02wR3pO7A936nVsMI+zKODWhAvy+AAI2?=
 =?us-ascii?Q?rP4hfDbcUUsbNVtkk0xTm9N+4hirfj2Bj/7ZGrtYELRQXaT6WdXR+YeUZvLE?=
 =?us-ascii?Q?GG5hPrzvPSm6fdlf06IzGsxCV7LkiYi53tq5OdaiGyhaI4XGVfjGfI8Vzi0r?=
 =?us-ascii?Q?wsbjJj4jg7nQ5A6GX9pFq2jAb3YjpBboVbs3vrhP/35IYM56q+1aOTMPp3dc?=
 =?us-ascii?Q?B9NnESr+sPFbU6wEzyN7xE5D8zKyewOqyA8C2/m206c+AwVd+PJFHYqokaxb?=
 =?us-ascii?Q?M5lzpiJv/7j8ftHKDUZcPsXob8s1FmTWJ74rFpAyqv7qiS3kXAuDIFmyLSIT?=
 =?us-ascii?Q?GWh+WvFygyCt6WfiF+33lJNNiDEMPNaRjIZBHdrzWIH+q2WR/2/fRFEtRkNe?=
 =?us-ascii?Q?mL1T5z2Cp2lDtKWs2cqLVousFtw5dzow1BE1Ho+fahvXXUfWdgrqr+CmyhhZ?=
 =?us-ascii?Q?TQAcfJh17TStoJOkHINe2a23/fSxXeg8UY3rSq5RMjhRzWV/MZPm1okGxDSC?=
 =?us-ascii?Q?/hqZuyzvGz66x1ztCl6ZrJMeGvOIDDBOfJGP3Ft1xU2duro0f4ZIcvdKk8wQ?=
 =?us-ascii?Q?GQwa7xcDG7+49ml3nZRjv1bYC/UINKjHB5Q4V8fPzOqmERmxEYFqDzlxeUDp?=
 =?us-ascii?Q?RBlXxNLCpju7CXdew9wOYf2IS8tAUCBB2KGsAYmyT0A/NQ71X1pBZeTE/j4o?=
 =?us-ascii?Q?cIZ1lw1SGJVdyhBL//abuxua+DP85lFGvvCJNOBaZSDL6v2cHgU0G5VemSsZ?=
 =?us-ascii?Q?jKFYxzVUopR2CUSwQ5g626TPAj8hgYrR9Kui6iXPcug4PqlT2h8Sl0TweVPW?=
 =?us-ascii?Q?OOlzFI3kjVibCdFG6TxsSPzYdGjQTvJsVIRJu94rxuyHlegk+A0mPpGYUVuP?=
 =?us-ascii?Q?LBB9xj58BQDfzcm11YhselOH5UY4QOnKHDbckYKsVn1t+XysifGN5jXz1G8Q?=
 =?us-ascii?Q?M2cnb9iOJyH12wfILA9P2PobECZUrew8YnkwOslBldJQYc9PuRnxZNDmQ90x?=
 =?us-ascii?Q?nG0g3EuACh3q/FhNHBY6fkrLON2Dj/Gf1YcuxDrNK0fw1mziEdV2NWaYGXXa?=
 =?us-ascii?Q?qZD2G8E5CszDOT2p0OoN6HTD/fp1ujo2duT5uZznp8PRQRJJD0SslAKSo4i1?=
 =?us-ascii?Q?22IzBJ0c0BGGsw5JKkUxETmpppbBUe2EHDmqPJL/dQWwNjePw2p24xNt0tFZ?=
 =?us-ascii?Q?cSrLIJc579rDCpeT42hl9Tf2cIIYF57jF87Uyt7v7DmEpjDwcHZC9v/arH2k?=
 =?us-ascii?Q?bbWJU5WzyC1s+CeGWUUiKUObdhez99umjBqbonuuXu3KWY6GQo8DiNz3HO/F?=
 =?us-ascii?Q?omyxR3uH61zsYPgRrodBfPrbPTslmftC3BvUmAwzpXQoaQUGOAZApx+w9FZ5?=
 =?us-ascii?Q?6szwEOT+l24MxzGojZn3WCrCIJaqCD4=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4a8757-da98-426e-c3e4-08da3d79d821
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:37:55.4181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmuhaYMSxXuOjomiFhi1UHzOv0JwiMR11NkXyf913ZEwO9i+ukem1TyuDRLAUy1UgQSrJcOLt0VTGcQ2/QoWWg==
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
 drivers/net/wireless/celeno/cl8k/debug.c | 442 +++++++++++++++++++++++
 1 file changed, 442 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/debug.c

diff --git a/drivers/net/wireless/celeno/cl8k/debug.c b/drivers/net/wireless/celeno/cl8k/debug.c
new file mode 100644
index 000000000000..f8a438747ac3
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/debug.c
@@ -0,0 +1,442 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/kmod.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/ctype.h>
+
+#include "chip.h"
+#include "hw.h"
+#include "utils.h"
+#include "debug.h"
+
+const char *cl_dbgfile_get_msg_txt(struct cl_dbg_data *dbg_data, u16 file_id, u16 line)
+{
+	/* Get the message text from the .dbg file by file_id & line number */
+	int remaining_bytes = dbg_data->size;
+	const char *str = dbg_data->str;
+	char id_str[32];
+	int idstr_len;
+
+	if (!str || 0 == remaining_bytes)
+		return NULL;
+
+	idstr_len = snprintf(id_str, sizeof(id_str), "%u:%u:", file_id, line);
+
+	/* Skip hash */
+	while (*str++ != '\n')
+		;
+
+	remaining_bytes -= (str - (char *)dbg_data->str);
+
+	while (remaining_bytes > 0) {
+		if (strncmp(id_str, str, idstr_len) == 0) {
+			str += idstr_len;
+			while (*str == ' ')
+				++str;
+			return (const char *)str;
+		}
+
+		str += strnlen(str, 512) + 1;
+		remaining_bytes = dbg_data->size - (str - (char *)dbg_data->str);
+	}
+
+	/* No match found */
+	pr_err("error: file_id=%d line=%d not found in debug print file\n", file_id, line);
+	return NULL;
+}
+
+void cl_dbgfile_parse(struct cl_hw *cl_hw, void *edata, u32 esize)
+{
+	/* Parse & store the firmware debug file */
+	struct cl_dbg_data *dbg_data = &cl_hw->dbg_data;
+
+	dbg_data->size = esize;
+	dbg_data->str = edata;
+}
+
+void cl_dbgfile_release_mem(struct cl_dbg_data *dbg_data,
+			    struct cl_str_offload_env *str_offload_env)
+{
+	dbg_data->str = NULL;
+
+	str_offload_env->enabled = false;
+	str_offload_env->block1 = NULL;
+	str_offload_env->block2 = NULL;
+}
+
+/*
+ * Store debug print offload data
+ * - part 1: offloaded block that does not exist on target
+ * - part 2: resident block that remains on target [optional]
+ */
+int cl_dbgfile_store_offload_data(struct cl_chip *chip, struct cl_hw *cl_hw,
+				  void *data1, u32 size1, u32 base1,
+				  void *data2, u32 size2, u32 base2,
+				  void *data3, u32 size3, u32 base3)
+{
+	u32 u = size1;
+	struct cl_str_offload_env *str_offload_env = &cl_hw->str_offload_env;
+
+	if (u > 200000)
+		goto err_too_big;
+
+	/* TODO we modify offload data! if caller checks integrity, make a copy? */
+	str_offload_env->block1 = data1;
+	str_offload_env->size1 = size1;
+	str_offload_env->base1 = base1;
+
+	str_offload_env->block2 = data2;
+	str_offload_env->size2 = size2;
+	str_offload_env->base2 = base2;
+
+	str_offload_env->block3 = data3;
+	str_offload_env->size3 = size3;
+	str_offload_env->base3 = base3;
+
+	str_offload_env->enabled = true;
+
+	cl_dbg_info(cl_hw, "%cmac%u: FW prints offload memory use = %uK\n",
+		    cl_hw->fw_prefix, chip->idx, (size1 + size2 + 1023) / 1024);
+
+	return 0;
+
+err_too_big:
+	pr_err("%s: size too big: %u\n", __func__, u);
+	return 1;
+}
+
+static void cl_fw_do_print_n(struct cl_hw *cl_hw, const char *str, int n)
+{
+	/* Print formatted string with "band" prefix */
+	if (n < 0 || n > 256) {
+		cl_dbg_err(cl_hw, "%cmac%u: *** FW PRINT - BAD SIZE: %d\n",
+			   cl_hw->fw_prefix, cl_hw->chip->idx, n);
+		return;
+	}
+
+	cl_dbg_verbose(cl_hw, "%cmac%u: %.*s\n", cl_hw->fw_prefix, cl_hw->chip->idx, n, str);
+}
+
+static void cl_fw_do_hex_dump_bytes(struct cl_hw *cl_hw, u32 addr, void *data, u32 count)
+{
+	cl_dbg_verbose(cl_hw, "%cmac%u: hex dump:\n", cl_hw->fw_prefix, cl_hw->chip->idx);
+	cl_hex_dump(NULL, data, count, addr, true);
+}
+
+#define MAGIC_PRINT_OFFLOAD   0xFA  /* 1st (low) byte of signature */
+/* 2nd signature byte */
+#define MAGIC_PRINT_OFF_XDUMP 0xD0  /* Hex dump, by bytes */
+#define MAGIC_PRINT_OFF_LIT   0x01  /* Literal/preformatted string */
+#define MAGIC_PRINT_OFF_PRINT 0x02  /* Print with 'virtual' format string */
+
+static int cl_fw_offload_print(struct cl_str_offload_env *str_offload_env,
+			       char *fmt, const char *params)
+{
+	static char buf[1024] = {0};
+	const char *cur_prm = params;
+	char tmp;
+	char *fmt_end = fmt;
+	size_t size = sizeof(int);
+	int len = 0;
+
+	union v {
+		u32 val32;
+		u64 val64;
+		ptrdiff_t str;
+	} v;
+
+	while ((fmt_end = strchr(fmt_end, '%'))) {
+		fmt_end++;
+
+		/* Skip '%%'. */
+		if (*fmt_end == '%') {
+			fmt_end++;
+			continue;
+		}
+
+		/* Skip flags. */
+		while (strchr("-+ 0#", *fmt_end))
+			fmt_end++;
+
+		/* Skip width. */
+		while (isdigit(*fmt_end))
+			fmt_end++;
+
+		/* Skip precision. */
+		if (*fmt_end == '.') {
+			while (*fmt_end == '-' || *fmt_end == '+')
+				fmt_end++;
+
+			while (isdigit(*fmt_end))
+				fmt_end++;
+		}
+
+		/* Get size. */
+		if (*fmt_end == 'z') {
+			/* Remove 'z' from %zu, %zd, %zx and %zX,
+			 * because sizeof(size_t) == 4 in the firmware.
+			 * 'z' can only appear in front of 'd', 'u', 'x' or 'X'.
+			 */
+			if (!strchr("duxX", *(fmt_end + 1)))
+				return -1;
+
+			fmt_end++;
+			size = 4;
+		} else if (*fmt_end == 'l') {
+			fmt_end++;
+
+			if (*fmt_end == 'l') {
+				fmt_end++;
+				size = sizeof(long long);
+			} else {
+				size = sizeof(long);
+			}
+
+			if (*fmt_end == 'p') /* %p can't get 'l' or 'll' modifiers. */
+				return -1;
+		} else {
+			size = 4;
+		}
+
+		/* Get parameter. */
+		switch (*fmt_end) {
+		case 'p': /* Replace %p with %x, because the firmware's pointers are 32 bit wide */
+			*fmt_end = 'x';
+			fallthrough;
+		case 'd':
+		case 'u':
+		case 'x':
+		case 'X':
+			if (size == 4)
+				v.val32 = __le32_to_cpu(*(__le32 *)cur_prm);
+			else
+				v.val64 = __le64_to_cpu(*(__le64 *)cur_prm);
+			cur_prm += size;
+			break;
+		case 's':
+			v.str = __le32_to_cpu(*(__le32 *)cur_prm);
+			cur_prm += 4;
+			size = sizeof(ptrdiff_t);
+
+			if (v.str >= str_offload_env->base3 &&
+			    v.str < str_offload_env->base3 + str_offload_env->size3) {
+				v.str -= str_offload_env->base3;
+				v.str += (ptrdiff_t)str_offload_env->block3;
+			} else if (v.str >= str_offload_env->base2 &&
+				   v.str < str_offload_env->base2 + str_offload_env->size2) {
+				v.str -= str_offload_env->base2;
+				v.str += (ptrdiff_t)str_offload_env->block2;
+			} else {
+				return -1;
+			}
+
+			break;
+		default:
+			return -1;
+		}
+
+		/* Print into buffer. */
+		fmt_end++;
+		tmp = *fmt_end; /* Truncate the format to the current point and then restore. */
+		*fmt_end = 0;
+		len += snprintf(buf + len, sizeof(buf) - len, fmt, size == 4 ? v.val32 : v.val64);
+		*fmt_end = tmp;
+		fmt = fmt_end;
+	}
+
+	snprintf(buf + len, sizeof(buf) - len, "%s", fmt);
+
+	pr_debug("%s", buf);
+
+	return 0;
+}
+
+struct cl_pr_off_desc {
+	u8 file_id;
+	u8 flag;
+	__le16 line_num;
+	char fmt[];
+};
+
+char *cl_fw_print_normalize(char *s, char old, char new)
+{
+	for (; *s; ++s)
+		if (*s == old)
+			*s = new;
+	return s;
+}
+
+static int cl_fw_do_dprint(struct cl_hw *cl_hw, u32 fmtaddr, u32 nparams, u32 *params)
+{
+	/*
+	 * fmtaddr - virtual address of format descriptor in firmware,
+	 *           must be in the offloaded segment
+	 * nparams - size of parameters array in u32; min=0, max=MAX_PRINT_OFF_PARAMS
+	 * params  - array of parameters[nparams]
+	 */
+	struct cl_str_offload_env *str_offload_env = &cl_hw->str_offload_env;
+	struct cl_pr_off_desc *pfmt = NULL;
+
+	if (!str_offload_env->enabled)
+		return -1;
+
+	if (fmtaddr & 0x3)
+		cl_dbg_warn(cl_hw, "FW PRINT - format not aligned on 4? %8.8X\n", fmtaddr);
+
+	if (fmtaddr > str_offload_env->base1 &&
+	    fmtaddr < (str_offload_env->base1 + str_offload_env->size1)) {
+		pfmt = (void *)((fmtaddr - str_offload_env->base1) + str_offload_env->block1);
+	} else {
+		cl_dbg_err(cl_hw, "FW PRINT - format not in allowed area %8.8X\n", fmtaddr);
+		return -1;
+	}
+
+	/*
+	 * Current string sent by firmware is #mac@ where # is '253' and @ is '254'
+	 * Replace '253' with 'l' or 's' according to the fw_prefix.
+	 * Replace '254' with '0' or '1' according to chip index.
+	 */
+	cl_fw_print_normalize(pfmt->fmt, (char)253, cl_hw->fw_prefix);
+	cl_fw_print_normalize(pfmt->fmt, (char)254, (cl_hw->chip->idx == CHIP0) ? '0' : '1');
+
+	if (cl_fw_offload_print(str_offload_env, pfmt->fmt, (char *)params) < 0) {
+		cl_dbg_err(cl_hw, "FW PRINT - ERROR in format! (file %u:%u)\n",
+			   pfmt->file_id, pfmt->line_num);
+		cl_hex_dump(NULL, (void *)pfmt, 48, fmtaddr, true); /* $$$ dbg dump the struct */
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cl_fw_do_offload(struct cl_hw *cl_hw, u8 *data, int bytes_remaining)
+{
+	u8 magic2 = data[1];
+	u32 nb = data[2] + (data[3] << 8); /* Following size in bytes */
+	/* DATA IS UNALIGNED! REVISE if alignment required or BIG ENDIAN! */
+	__le32 *dp = (__le32 *)data;
+	int bytes_consumed = 4; /* 1 + 1 + 2 */
+
+	/* Data: [0] u8 magic1, u8 magic2, u16 following size in bytes */
+	if (bytes_remaining < 8) {
+		cl_dbg_err(cl_hw, "*** FW PRINT - OFFLOAD PACKET TOO SHORT: %d\n",
+			   bytes_remaining);
+		return bytes_remaining;
+	}
+
+	if (bytes_remaining < (nb + bytes_consumed)) {
+		cl_dbg_err(cl_hw, "*** FW PRINT - OFFLOAD PACKET %u > remainder %d??\n",
+			   nb, bytes_remaining);
+		return bytes_remaining;
+	}
+
+	switch (magic2) {
+	case MAGIC_PRINT_OFF_PRINT: {
+		/*
+		 * [1] u32 format descriptor ptr
+		 * [2] u32[] parameters
+		 */
+		u32 fmtp = le32_to_cpu(dp[1]);
+		u32 np = (nb - 4) / 4; /* Number of printf parameters */
+
+		if (nb < 4 || nb & 3)  {
+			cl_dbg_err(cl_hw, "*** FW PRINT - bad pkt size: %u\n", nb);
+			goto err;
+		}
+
+		cl_fw_do_dprint(cl_hw, fmtp, np, (u32 *)&dp[2]);
+
+		bytes_consumed += nb; /* Already padded to 4 bytes */
+		}
+		break;
+
+	case MAGIC_PRINT_OFF_LIT: {
+		/* [1] Remaining bytes: literal string */
+		cl_fw_do_print_n(cl_hw, (char *)&dp[1], nb);
+		bytes_consumed += ((nb + 3) / 4) * 4; /* Padding to 4 bytes */
+		}
+		break;
+
+	case MAGIC_PRINT_OFF_XDUMP:
+		/* [1] bytes[nb] */
+		if (nb >= 1)
+			cl_fw_do_hex_dump_bytes(cl_hw, 0, &dp[1], nb);
+
+		bytes_consumed += ((nb + 3) / 4) * 4; /* Padding to 4 bytes */
+		break;
+
+	default:
+		cl_dbg_err(cl_hw, "*** FW PRINT - BAD TYPE: %4.4X\n", magic2);
+		goto err;
+	}
+
+	return bytes_consumed;
+
+err:
+	return bytes_remaining; /* Skip all */
+}
+
+void cl_dbgfile_print_fw_str(struct cl_hw *cl_hw, u8 *str, int max_size)
+{
+	/* Handler for firmware debug prints */
+	int bytes_remaining = max_size;
+	int i;
+	u8 delim = 0;
+
+	while (bytes_remaining > 0) {
+		/* Scan for normal print data: */
+		for (i = 0; i < bytes_remaining; i++) {
+			if (str[i] < ' ' || str[i] >= 0x7F) {
+				if (str[i] == '\t')
+					continue;
+				delim = str[i];
+				break;
+			}
+		}
+
+		if (i > 0) {
+			if (delim == '\n') {
+				bytes_remaining -= i + 1;
+				cl_fw_do_print_n(cl_hw, str, i);
+				str += i + 1;
+				continue;
+			}
+
+			if (delim != MAGIC_PRINT_OFFLOAD) {
+				cl_fw_do_print_n(cl_hw, str, i);
+				bytes_remaining -= i;
+				return; /* Better stop parsing this */
+			}
+			/* Found offload packet but previous string not terminated: */
+			cl_fw_do_print_n(cl_hw, str, i);
+			cl_dbg_err(cl_hw, "*** FW PRINT - NO LINE END2\n");
+			bytes_remaining -= i;
+			str += i;
+			continue;
+		}
+
+		/* Delimiter at offset 0 */
+		switch (delim) {
+		case '\n':
+			cl_fw_do_print_n(cl_hw, " ", 1); /* Print empty line */
+			str++;
+			bytes_remaining--;
+			continue;
+		case 0:
+			return;
+		case MAGIC_PRINT_OFFLOAD:
+			i = cl_fw_do_offload(cl_hw, str, bytes_remaining);
+			bytes_remaining -= i;
+			str += i;
+			break;
+		default:
+			cl_dbg_err(cl_hw, "*** FW PRINT - BAD BYTE=%2.2X ! rem=%d\n",
+				   delim, bytes_remaining);
+			return; /* Better stop parsing this */
+		}
+	}
+}
-- 
2.36.1

