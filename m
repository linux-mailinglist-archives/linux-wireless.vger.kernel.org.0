Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5402553294A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiEXLjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236831AbiEXLjM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:39:12 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2041.outbound.protection.outlook.com [40.107.104.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D77D3C734
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mhSQEtB7TZds+d0uMTBLF5itLV0988tIMLsx+DqXKxIEWdB903ZlV4Nr9ySD46tMaDrfOOx7bnTPVKSX4ICweClWf3XFWj/lwvSOtYNFyel7aBWS7+EeA0VyAyHCYIo0ZHJrClEwrJxaIF9S6jMJKKSyCkM20SFufhLkNuYt6LeNtlgZlwp7Rc3d0/kExiiIgT0S8s5v5gLP+DgZkWCxgQ6Qanjad0VLwMzRvcQeOG44I0pI/6zE2m6OmG6IowZWerLQ1teYnCrNji7fbPhyxKLBcWQdnPPIxHikMt5DROfheNQ380E7R24XKujRLLQaKvR74VBHDkSFzPjJmMn0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvaKk6hSGWJNVfUJtSNLy8oQom+spkz7N1G5Oex5YuM=;
 b=UQDd7muH7XQJk6WYAy9fRHxkH/D4bxXUPWBhmy4FNwGLXNE2MYuWQum+RS4B7EufCkPuodvsa1Asc3kDS9Q9W5J09MvDjXPQenTuZc34oWMfL6/cc43+fqGG5EvcRgIA3WfJBXyoJUOajtWAOmQClNCfRpYTCMJelNuZmVtH9rEx1HcOpVqIgAcbTzYwZBSFTmPR5I/yK3y8fVOruC48aS+8rerb+wq8oIvFAewoK9BPC08yzv0FsFgbsfqvqzCgOsXPxnzvLfqGB6WcQe6/dtGXp3zOB7Sa2AvCSszIObqmO6Uid0PSVFJQJYT9vSntRmNH/2OXNQW2atX0wqV4NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvaKk6hSGWJNVfUJtSNLy8oQom+spkz7N1G5Oex5YuM=;
 b=FArlI2vIoRyQAZQZcJWNXEcRIbrCSk4RPk1X5fjbf58k0LyxIVDNtVZvADMn8iS7SapxKgRkSlylC71+VXTHWNsaYOCAKLJUTZE/0uYl776z0Kw82v5Xi4L/1LAt2pgPXs473Vvr8aXOyoK0absxlRZHufD17lm76wa5ZeVxjsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VI1P192MB0384.EURP192.PROD.OUTLOOK.COM (2603:10a6:803:34::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 11:38:36 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:38:36 +0000
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
Subject: [RFC v2 31/96] cl8k: add fw.c
Date:   Tue, 24 May 2022 14:33:57 +0300
Message-Id: <20220524113502.1094459-32-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: cd24e86f-a279-40b6-4145-08da3d79deae
X-MS-TrafficTypeDiagnostic: VI1P192MB0384:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VI1P192MB03849A0DCAC2157D4858A98AF6D79@VI1P192MB0384.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYrpTkwvAu1u/1bsDVpgm+C16RIHiFitYpHap8m8RnhncU51zcQd6nkPQrnPM/FWWI6MCFwFnACO68Kv+1ilhl8mDuMXfP6GSlShjccdt/19TYr2EIVah6iPuC2BBxGnF58NKXE+gCijCWHljhk6lS99SUJ/CeK4rfRkambpi6ZcQ0cBErJzx0iv+8ix8dVCujQZ3fMd6dCer28l5PmoDZU4WYlBdzafzXuo9EoP80NJ7QwUJS/BtrI9WX5vWubkbUg6luGwDL7WcNReDT2WFyQpf/KYzd7Fh42vsW8k5BVs9YkPNe+zpYlh/wKVA82EViJePdliyV4BxZPQKSf9NwJQsF3oOu8HeM1msQG2IYQZ7hfFX2cjO4eoe4/CYUMJLwqfaErCE7UIltoIFp43rY/PS26rM/LRNl/kb8hSCd/RfKKeg4AGKCQ5uUjlxfyIXpWlHujhjeo1nwPfk44lFApff6xyQtMawJDlCb0wyjZ1+mowitvPplgIodvl15cFdXx75hCUCmOFQeRPVV2r/y3QXud63T3AR8r+oNCoIR8sKsxytWoAPDGV56CiqWg6rENPQD/aDtFhSsnP6HzBsRbyhHPPvBU1LcnCqEX58pLBpZNljJR0lLvg85FIkRD2nMM/tqaJyo7QTQdvdaIDRjr0UvrHh+t6w1TPCimZgvfLlRqnw5C+togZssu9mSHpEYGX1HwrSOKuvAspXWVN2TWy8B0+pLy8lfl7jFF/RgAJWGh2nhG4Y1jHXnck4bsX1icO4RlGo5/0mJCJ3rHcqEu16XbI7QJojMHIDCcZpWlbxFO11lgb1VchA/Hd2DN2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(136003)(366004)(396003)(346002)(39850400004)(376002)(41300700001)(36756003)(6666004)(30864003)(8936002)(508600001)(186003)(83380400001)(966005)(6486002)(6506007)(38100700002)(2906002)(38350700002)(6512007)(107886003)(5660300002)(2616005)(1076003)(66946007)(4326008)(8676002)(26005)(52116002)(316002)(6916009)(9686003)(66556008)(66476007)(86362001)(54906003)(32563001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4kdPi1Lmt/6UExs39311ONqMeGcAthZX1fofkPBnbp68WS68Zm3kKbVJwjJz?=
 =?us-ascii?Q?R/PzUEN78lCFju0LGDpOWhv7K27XONlNyfsZnGkyqqz7Bqzq+2uUbBRnW+2r?=
 =?us-ascii?Q?rBFuLbRZFZRLVLWKaeZedC3Vg/fUqaQ6N2xrRRJIgYo3flXsd+Sye+SLYud/?=
 =?us-ascii?Q?yfKhtJWQfIq8Exrd6dJVG1JhDN1kQsKR5a4PBJit+InYwE9sW6cMKalEDFFU?=
 =?us-ascii?Q?9geS3vKng0EeQbD82gBntzz2Lye7Zrad5IDKi/TW4gH4GoOcbzBELurVgkEQ?=
 =?us-ascii?Q?6SGpngVZSJqYTEAS6OYa781UGCsRHpkfoNQGdf3wGW5S6Vh4nx6iBk12QYud?=
 =?us-ascii?Q?cPueFzh4AkXLC7xX884pOobAJYlX+jZGETFCJi6e8zwprNNVi1B6nta3mAYG?=
 =?us-ascii?Q?UCUtLJhCOM/+poqNkjZW1EWztAmMDu5WiNqgxQ4OoKIZm+y0gvctMzo5kHsX?=
 =?us-ascii?Q?j1ciV+uD2J5EmQhmqH+Kv821Kyf5XZp9r6x9E2OxeIEj70gr4D/tkoFmqY/9?=
 =?us-ascii?Q?9wZa8ocvn7NjwkUFTf/sAPFvEE6U6BbuxEm+z4Hl7qsmh/gEDXnJQzvjtzy0?=
 =?us-ascii?Q?XlfL4suztqEeLQyhW0q9Hho9a1LYmsepvcoJQjxjjTxIGXij53/IWvwBuEMq?=
 =?us-ascii?Q?iWGhvQ/lmEuuVYGEwUye8eI19PgzB3RYi7R4ezHadldImYfHh2b+EKBKVGdP?=
 =?us-ascii?Q?oVoFe/eyAVNza19NFLLWqGhjYhlT7s0c8cPDVOSuti8wod8P3WFXRfN4/Cg2?=
 =?us-ascii?Q?kbf/us0Co/pFtMFtrjgx8K7QDrXj8Wb+o43PZHu5ClkdpB042aowREM6esxk?=
 =?us-ascii?Q?HUNg8kk0P0Suj5NEEYE708Q1Elo81mSIqU1sN7VnDK/SkmTxoRTMAyoklcEd?=
 =?us-ascii?Q?OCVmcEyaqb1rMcN8pAqDuZNlSCzb6ytTLSEoo89huavoC+kiTaSwhLiNf9+F?=
 =?us-ascii?Q?GB6aRiXKaNRzf8EgDbHLnnog2nGFi2P7Pawor6q+ajqOaMx6X4xmZS3uvobj?=
 =?us-ascii?Q?LsGl4UdVRKTCUsvDxXl2XlPkXabHdJB2vZe8jSRP3BEuZu2sEtpSY8ZQUv1q?=
 =?us-ascii?Q?xi1xm1uwGPvh8la/6CoVj6+OcAgIwHHIcgX0ZQux0IaaNK03T7V2V8G0ULd1?=
 =?us-ascii?Q?R7Ml46Do65CIDC3pK9yk3+DcOJVrjTKBVHMZfH5qHQJMTVuzrpjMEqEkqzum?=
 =?us-ascii?Q?0o+P+k4vFNHM3lx6eZ9PGiX5qLmKsHboTyqSF3Rvbn242htvoMwD8R1Rxcxj?=
 =?us-ascii?Q?0QeNU767eNCxgzXN/eK0hVE6OHc84iqm9dWJEw0/mglMpypd7tc0TNqSDsXI?=
 =?us-ascii?Q?lRvhh2lG7tXS4PuuAMEf7RRy9RL0OGpOZoPmoDkk9znW6y044q/8lZ6USPuW?=
 =?us-ascii?Q?dmO22gBiFbrOslcKh8bilE25e1Sv8xEzH0AZGnycw6PzWtT9L7IOnuQ/CvQ/?=
 =?us-ascii?Q?ARkALb3eswYUajY6lXnO5xO1ozbZcwctECYyq0NgRCKtZ9fVVI0h9I9SoJ8I?=
 =?us-ascii?Q?ZNBzRF5Q9cHcIP4j5ojYg1M8ShZwLtBdeG4R3vGJT4iB4I1Xpocdh4aSc65p?=
 =?us-ascii?Q?sx3MW+MXeKHWAYAA5e1WkJKHE936BlcKNTyQZk8l2SXcY3LvUdoHhoJNPwRM?=
 =?us-ascii?Q?6r1yvk8y1eH5fqbh0HNTst+Dc+nvTqBcw6DT+DpEXLzTHBkC7NZ56iR+/OTY?=
 =?us-ascii?Q?VlI+xeAMt0yJgFZ9KbeU4XU3+Y0LY+99K4JkYHnmUUJXNdskpIq1cdx61aWa?=
 =?us-ascii?Q?gI8eEC5+vg06AWHLe+48SEpkRSTWSBw=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd24e86f-a279-40b6-4145-08da3d79deae
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:38:06.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiGYJ/9h2Pp4hqQD8iMfcyVcfjdBq0g/yz+Jgc//vvwSZJtQjOhsveBHXGShUyTEjd4C4dr8+XXCDpG+tOYvkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P192MB0384
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
 drivers/net/wireless/celeno/cl8k/fw.c | 3167 +++++++++++++++++++++++++
 1 file changed, 3167 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/fw.c

diff --git a/drivers/net/wireless/celeno/cl8k/fw.c b/drivers/net/wireless/celeno/cl8k/fw.c
new file mode 100644
index 000000000000..fd981ccdfaee
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/fw.c
@@ -0,0 +1,3167 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#include <linux/utsname.h>
+#include <linux/firmware.h>
+
+#include "chip.h"
+#include "utils.h"
+#include "debug.h"
+#include "recovery.h"
+#include "reg/reg_access.h"
+#include "reg/reg_defs.h"
+#include "phy.h"
+#include "rfic.h"
+#include "mac_addr.h"
+#include "mac80211.h"
+#include "ampdu.h"
+#include "tx.h"
+#include "stats.h"
+#include "fw.h"
+
+#define fw_pr(cl_hw, fmt, ...) \
+	pr_debug("%cmac%u " fmt, (cl_hw)->fw_prefix, (cl_hw)->chip->idx, ##__VA_ARGS__)
+
+/* Location where FW codes must be written */
+#define RAM_SMAC_FW_ADDR 0x00300000
+#define RAM_UMAC_FW_ADDR 0x00280000
+#define RAM_LMAC_FW_ADDR 0x00200000
+
+#define FW_START_MAGIC           "CEFWHDRSTART"
+#define FW_END_MAGIC             "CEFWHDREND"
+#define FW_OFFLOAD_MEM_BASE_ADDR 0x70000000 /* Defined in fw link script */
+#define FW_SECTION_SIZE_MASK     0x7FFFF    /* Mask for max. size of a section */
+#define FW_REMOTE_ROM_BASE_ADDR  0x80000000 /* Defined in fw link script */
+#define FW_REMOTE_ROM_MAX        150000
+
+/* Location (offset) where FW codes must be taken from */
+#define IRAM_START_OFFSET        0x40000
+
+/*
+ * Poor man parser of a plain zip file
+ * We use it just as a container for now. Could use cpio instead.
+ * (no compression, no 64-bit data ... no nothing)
+ * Reference: ZIP File Format Specification v.6.3.4 (2014)
+ *     http://pkware.cachefly.net/webdocs/casestudies/APPNOTE.TXT
+ * For BIG ENDIAN host: zip format is always little endian.
+ * TODO: need alignment on non-intel hosts! zip format has no alignment,padding
+ * TODO: check CRC?
+ */
+
+struct pkzip_local_hdr  {
+	u32 signature;
+	u16 ver2extract;
+	u16 flags;
+	u16 cmpr_meth;
+	u16 filetime;
+	u16 filedate;
+	u32 crc32;
+	u32 cmpr_size;
+	u32 orig_size;
+	u16 fname_len;
+	u16 hdr_extra_len;
+	/* Filename goes here - not 0 terminated! */
+	/* Hdr_extra_data goes here */
+	/* File data goes here; no padding, no alignment */
+} __packed;
+
+#define PKZIP_LOCAL_HDR_MAGIC   0x04034b50
+#define PKZIP_CENTRAL_DIR_MAGIC 0x02014b50
+
+/*
+ * Enumerate zip data in buffer, find named item
+ * Return: 0 on success (the item found)
+ *        -ENOENT the item not found, normal end of data found
+ *        -EINVAL the data is not zip (maybe old format firmware)
+ *         else invalid data format or other error
+ */
+static int cl_enum_zipfile(const void *data, size_t size,
+			   const char *name, char **pdata, size_t *psize)
+{
+	const struct pkzip_local_hdr *phdr = data;
+	int remain_size = (int)size;
+
+	BUILD_BUG_ON(sizeof(struct pkzip_local_hdr) != 30);
+
+	while (remain_size > sizeof(struct pkzip_local_hdr)) {
+		char *pfname;
+		char *edata;
+
+		if (phdr->signature != PKZIP_LOCAL_HDR_MAGIC) {
+			if (phdr->signature == PKZIP_CENTRAL_DIR_MAGIC)
+				return -ENOENT; /* Normal end of zip */
+			if ((void *)phdr == data)
+				/* Bad signature in the first entry - not a zip at all */
+				return -EINVAL;
+			pr_err("ZIP - unexpected block: %8.8X\n", phdr->signature);
+			return -1;
+		}
+
+		if (phdr->fname_len == 0 || phdr->fname_len > 128) {
+			/* FIX max len */
+			pr_err("ZIP entry name len bad: %u\n", phdr->fname_len);
+			return -1;
+		}
+
+		if (phdr->hdr_extra_len == 0) {
+			pr_err("ZIP xtra hdr size=0! FIXME!\n"); /* Copy name to tmp buffer */
+			return -1;
+		}
+
+		pfname = (char *)phdr + sizeof(struct pkzip_local_hdr);
+		/* Because fname in zip is not null term! */
+		pfname[phdr->fname_len] = 0;
+		edata = pfname + phdr->fname_len + phdr->hdr_extra_len;
+		remain_size -= (sizeof(*phdr) + phdr->fname_len + phdr->hdr_extra_len);
+
+		if (phdr->cmpr_size == 0 || phdr->cmpr_size > remain_size) {
+			pr_err("ZIP entry data len bad: %u name=%s, left=%u\n",
+			       phdr->cmpr_size, pfname, remain_size);
+			return -1;
+		}
+
+		if (strncmp(name, pfname, phdr->fname_len) == 0) {
+			if (phdr->cmpr_meth != 0 || phdr->cmpr_size != phdr->orig_size) {
+				pr_err("ZIP entry compressed! name=%s\n", pfname);
+				return -1;
+			}
+
+			*pdata = edata;
+			*psize = (size_t)phdr->cmpr_size;
+			return 0;
+		}
+
+		remain_size -= phdr->cmpr_size;
+		phdr = (const struct pkzip_local_hdr *)(edata + phdr->cmpr_size);
+	}
+
+	return -1;
+}
+
+static int cl_fw_unpack(const void *data, size_t size,
+			const char *name, char **pdata, size_t *psize)
+{
+	/*
+	 * Get named item in firmware container
+	 * Args: pdata : pointer to pointer to item data, psize : pointer to item size
+	 */
+	*pdata = NULL;
+	*psize = 0;
+	return cl_enum_zipfile(data, size, name, pdata, psize);
+}
+
+static int cl_fw_load_other(struct cl_hw *cl_hw, const char *name)
+{
+	/* Handle other stuff in firmware container */
+	char *edata;
+	size_t esize;
+	struct cl_cached_fw *cached_fw = &cl_hw->cached_fw;
+	int rc = cl_fw_unpack(cached_fw->data, cached_fw->size,
+			      name, &edata, &esize);
+
+	if (rc)
+		return rc;
+
+	cl_dbgfile_parse(cl_hw, edata, esize);
+
+	return 0;
+}
+
+/*
+ * Copy the FW code and data into the proper memory inside the firmware asic.
+ * vaddr - run address
+ * paddr - load address
+ * fsize - memory section size to copy
+ * msize - memory section physical size
+ * mem_base - base address of xtensa internal memory
+ * fw_buf - buffer holding the FW binary code and data
+ */
+static void cl_fw_copy_section(struct cl_chip *chip, char *fw_buf, u32 mem_base,
+			       u32 vaddr, u32 paddr, u32 fsize, u32 msize)
+{
+	u32 *src_addr;
+	u32 dst_addr;
+	u32 i;
+
+	src_addr = (u32 *)(fw_buf + (paddr & 0x0007FFFF));
+	/* 512KB - cover all internal iram and dram and some more */
+
+	/* Check if run address is external or internal from xtensa point of view */
+	if ((vaddr & 0xFF000000) == XTENSA_PIF_BASE_ADDR)
+		dst_addr = vaddr & 0x007FFFFF; /* Must be in 8M PCIe window */
+	else
+		dst_addr = (mem_base | (vaddr & 0x0007FFFF));
+
+	for (i = 0; i < fsize; i += sizeof(*src_addr))
+		cl_reg_write_chip(chip, dst_addr + i, *src_addr++);
+}
+
+static int cl_fw_phdrs_upload(struct cl_chip *chip, struct cl_hw *cl_hw,
+			      u32 fw_addr, const void *edata, size_t esize)
+{
+	/*
+	 * Load firmware image with "phdrs" header
+	 * and optional non-resident (offloaded) section
+	 */
+	u32 size = esize, section, section_cnt = 0;
+	char const *pbuf = edata;
+	u32 *src;
+
+	/* Verify FW image phdrs start magic */
+	if (strncmp(pbuf, FW_START_MAGIC, strlen(FW_START_MAGIC))) {
+		cl_dbg_err(cl_hw, "phdrs start magic not found, aborting...\n");
+		return -1;
+	}
+
+	cl_dbg_info(cl_hw, "phdrs start magic found !!!!!\n");
+	pbuf += (strlen(FW_START_MAGIC) + 1);
+	size -= (strlen(FW_START_MAGIC) + 1);
+
+	/* Verify FW image phdrs end magic */
+	while (size > 0) {
+		if (strncmp(pbuf, FW_END_MAGIC, strlen(FW_END_MAGIC)) == 0) {
+			cl_dbg_info(cl_hw, "phdrs end magic found !!!!!\n");
+			break;
+		}
+
+		pbuf += 16;
+		size -= 16;
+		section_cnt++;
+	}
+
+	/* FW image phdrs end magic not found */
+	if (size == 0 || section_cnt > 100) {
+		cl_dbg_err(cl_hw, "phdrs end magic not found, aborting...\n");
+		return -1;
+	}
+
+	/* Remember where the fw code start in firmware buffer */
+	src = (u32 *)(pbuf + (strlen(FW_END_MAGIC) + 1));
+	/* Re-assign firmware buffer ptrs to start */
+	pbuf = edata + (strlen(FW_START_MAGIC) + 1);
+	size = esize - (strlen(FW_START_MAGIC) + 1);
+
+	bool is_offload_present = false;
+	u32 off2_start = 0, off2_end = 0;
+	u32 off3_start = 0, off3_end = 0;
+
+	for (section = 0; section < section_cnt; section++) {
+		u32 *param = (u32 *)pbuf;
+
+		if (param[0] == FW_REMOTE_ROM_BASE_ADDR) {
+			if (param[2] > FW_REMOTE_ROM_MAX) {
+				cl_dbg_info(cl_hw, "%cmac%u: FW remote rom too big = %uK\n",
+					    cl_hw->fw_prefix, chip->idx, param[2]);
+			} else {
+				dma_addr_t phys_dma_addr;
+				char *pfake = (char *)src + (param[1] & FW_SECTION_SIZE_MASK);
+				struct cl_dma_accessed *fw_rom = &cl_hw->fw_remote_rom;
+
+				fw_rom->size = param[2];
+				fw_rom->drv_v_addr = dma_alloc_coherent(cl_hw->chip->dev,
+									fw_rom->size,
+									&phys_dma_addr, GFP_KERNEL);
+				if (!fw_rom->drv_v_addr) {
+					cl_dbg_info(cl_hw, "%cmac%u: FW remote rom dma_alloc_coherent failed = %uK\n",
+						    cl_hw->fw_prefix, chip->idx, fw_rom->size);
+					fw_rom->size = 0;
+				} else {
+					fw_rom->fw_v_addr = FW_REMOTE_ROM_BASE_ADDR;
+					fw_rom->dma_addr = phys_dma_addr;
+					memcpy(fw_rom->drv_v_addr, pfake, fw_rom->size);
+					cl_dbg_info(cl_hw, "%cmac%u: FW remote rom memory use = %uK\n",
+						    cl_hw->fw_prefix, chip->idx, fw_rom->size);
+				}
+			}
+			pbuf += 16;
+			continue;
+		}
+
+		if (param[0] == FW_OFFLOAD_MEM_BASE_ADDR) {
+			is_offload_present = true;
+			u32 *pdata = (u32 *)((char *)src + (param[1] & 0x7FFFF));
+
+			off2_start = pdata[0];
+			off2_end = pdata[1];
+			off3_start = pdata[2];
+			off3_end = pdata[3];
+			cl_dbg_info(cl_hw, "Resident RO DATA block: start=0x%x, end=0x%x\n\n",
+				    off2_start, off2_end);
+			pbuf += 16;
+			continue;
+		}
+
+		cl_fw_copy_section(chip, (char *)src, fw_addr,
+				   param[0],
+				   param[1],
+				   param[2],
+				   param[3]);
+		pbuf += 16;
+	}
+
+	if (is_offload_present) {
+		/* 2nd pass to find the resident RO data block */
+		pbuf -= (16 * section_cnt);
+		char *resident_file_data = NULL;
+		char *resident_umac_file_data = NULL;
+		u32 *param;
+
+		for (section = 0; section < section_cnt; section++) {
+			param = (u32 *)pbuf;
+			if (param[0] <= off2_start &&
+			    (param[0] + param[3]) > off2_end) {
+				resident_file_data =
+					(char *)src + (param[1] & FW_SECTION_SIZE_MASK) +
+					(off2_start - param[0]);
+				cl_dbg_info(cl_hw, "resident_file_data=0x%p.\n",
+					    resident_file_data);
+			}
+
+			if (param[0] <= off3_start &&
+			    (param[0] + param[3]) >= off3_end) {
+				resident_umac_file_data =
+					(char *)src + (param[1] & FW_SECTION_SIZE_MASK) +
+					(off3_start - param[0]);
+				cl_dbg_info(cl_hw, "resident_umac_file_data=0x%p.\n",
+					    resident_umac_file_data);
+			}
+
+			if (param[0] == FW_OFFLOAD_MEM_BASE_ADDR) {
+				char *pfake = (char *)src + (param[1] & FW_SECTION_SIZE_MASK);
+
+				cl_dbgfile_store_offload_data(chip,
+							      cl_hw,
+							      pfake, param[2],
+							      FW_OFFLOAD_MEM_BASE_ADDR,
+							      resident_file_data,
+							      off2_end - off2_start,
+							      off2_start,
+							      resident_umac_file_data,
+							      off3_end - off3_start,
+							      off3_start);
+
+				break; /* This should be last section */
+			}
+			pbuf += 16;
+		}
+
+		if (!resident_file_data)
+			cl_dbg_warn(cl_hw, "FW resident data block [%#X-%#X] not found!\n",
+				    off2_start, off2_end);
+	}
+
+	return 0;
+}
+
+static int cl_fw_upload(struct cl_chip *chip, struct cl_hw *cl_hw,
+			u32 fw_addr, const char *data, size_t size)
+{
+	/* Is it old .bin format (used for firmware tests) */
+	if (data[IRAM_START_OFFSET] == 0x06) {
+		const u32 *src = (const u32 *)data;
+		int i;
+
+		for (i = 0; i < size; i += sizeof(*src))
+			cl_reg_write_chip(chip, fw_addr + i, *src++);
+
+		return 0;
+	}
+
+	if (cl_hw)
+		return cl_fw_phdrs_upload(chip, cl_hw, fw_addr, data, size);
+
+	return 0;
+}
+
+static int cl_fw_load_operational(struct cl_hw *cl_hw, const char *fw_name,
+				  const char *main_str, const char *dbg_str,
+				  u32 ram_addr)
+{
+	int rc;
+	const struct firmware *fw;
+	char *fw_ptr;
+	size_t fw_size;
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_cached_fw *cached_fw = &cl_hw->cached_fw;
+
+	clear_bit(CL_DEV_FW_SYNC, &cl_hw->drv_flags);
+
+	if (!cached_fw->data) {
+		char path_name[CL_PATH_MAX] = {0};
+
+		snprintf(path_name, sizeof(path_name), "cl8k/%s", fw_name);
+		rc = request_firmware(&fw, path_name, chip->dev);
+
+		if (rc) {
+			cl_dbg_err(cl_hw, "# Failed to get %s, with error: %x\n",
+				   path_name, rc);
+			return rc;
+		}
+		cached_fw->data = vzalloc(fw->size);
+		if (!cached_fw->data) {
+			release_firmware(fw);
+			return -ENOMEM;
+		}
+		memcpy(cached_fw->data, fw->data, fw->size);
+		cached_fw->size = fw->size;
+		release_firmware(fw);
+	}
+
+	rc = cl_fw_unpack(cached_fw->data, cached_fw->size,
+			  main_str, &fw_ptr, &fw_size);
+
+	if (rc == 0) {
+		rc = cl_fw_upload(chip, cl_hw, ram_addr,
+				  fw_ptr, fw_size);
+		/* Load other stuff packed in firmware container */
+		if (rc == 0)
+			rc = cl_fw_load_other(cl_hw, dbg_str);
+	} else if (rc != -ENOENT) {
+		/* Assume it is a single file, not a container (used for tests) */
+		rc = cl_fw_upload(chip, cl_hw, ram_addr,
+				  cached_fw->data,
+				  cached_fw->size);
+	}
+
+	return rc;
+}
+
+static int cl_fw_load_lmac(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (cl_fw_load_operational(cl_hw, chip->conf->ce_lmac,
+				   "lmacfw.main", "lmacfw.dbg",
+				   RAM_LMAC_FW_ADDR))
+		return -1;
+
+	cl_hw->fw_active = true;
+
+	return 0;
+}
+
+static int cl_fw_load_smac(struct cl_hw *cl_hw)
+{
+	struct cl_chip *chip = cl_hw->chip;
+
+	if (cl_fw_load_operational(cl_hw, chip->conf->ce_smac,
+				   "smacfw.main", "smacfw.dbg",
+				   RAM_SMAC_FW_ADDR))
+		return -1;
+
+	cl_hw->fw_active = true;
+
+	return 0;
+}
+
+int cl_fw_file_load(struct cl_hw *cl_hw)
+{
+	/* For TCV0 load lmac, and for TCV1 load smac */
+	if (cl_hw_is_tcv0(cl_hw) &&
+	    strcmp(cl_hw->chip->conf->ce_lmac, "no_load")) {
+		if (cl_fw_load_lmac(cl_hw))
+			return -1;
+	} else if (cl_hw_is_tcv1(cl_hw) &&
+		   strcmp(cl_hw->chip->conf->ce_smac, "no_load")) {
+		if (cl_fw_load_smac(cl_hw))
+			return -1;
+	}
+
+	return 0;
+}
+
+void cl_fw_file_cleanup(struct cl_hw *cl_hw)
+{
+	/* Clean up all firmware allocations in cl_hw */
+	cl_dbgfile_release_mem(&cl_hw->dbg_data, &cl_hw->str_offload_env);
+}
+
+void cl_fw_file_release(struct cl_hw *cl_hw)
+{
+	struct cl_cached_fw *cached_fw = &cl_hw->cached_fw;
+
+	if (cached_fw->data) {
+		struct cl_dma_accessed *fw_rom = &cl_hw->fw_remote_rom;
+
+		vfree(cached_fw->data);
+		cached_fw->data = NULL;
+		cached_fw->size = 0;
+
+		if (fw_rom->drv_v_addr) {
+			dma_addr_t phys_dma_addr = fw_rom->dma_addr;
+
+			dma_free_coherent(cl_hw->chip->dev, fw_rom->size, fw_rom->drv_v_addr,
+					  phys_dma_addr);
+			fw_rom->drv_v_addr = NULL;
+			fw_rom->size = 0;
+			fw_rom->fw_v_addr = 0;
+			fw_rom->dma_addr = 0;
+		}
+	}
+}
+
+/* Should be used for REQ and CFM only */
+const char *const msg2str[MSG_TOTAL_REQ_CFM] = {
+	/* MM messages */
+	[MM_RESET_REQ] = "MM_RESET_REQ",
+	[MM_RESET_CFM] = "MM_RESET_CFM",
+	[MM_START_REQ] = "MM_START_REQ",
+	[MM_START_CFM] = "MM_START_CFM",
+	[MM_VERSION_REQ] = "MM_VERSION_REQ",
+	[MM_VERSION_CFM] = "MM_VERSION_CFM",
+	[MM_ADD_IF_REQ] = "MM_ADD_IF_REQ",
+	[MM_ADD_IF_CFM] = "MM_ADD_IF_CFM",
+	[MM_REMOVE_IF_REQ] = "MM_REMOVE_IF_REQ",
+	[MM_REMOVE_IF_CFM] = "MM_REMOVE_IF_CFM",
+	[MM_STA_ADD_REQ] = "MM_STA_ADD_REQ",
+	[MM_STA_ADD_CFM] = "MM_STA_ADD_CFM",
+	[MM_STA_DEL_REQ] = "MM_STA_DEL_REQ",
+	[MM_STA_DEL_CFM] = "MM_STA_DEL_CFM",
+	[MM_SET_FILTER_REQ] = "MM_SET_FILTER_REQ",
+	[MM_SET_FILTER_CFM] = "MM_SET_FILTER_CFM",
+	[MM_SET_CHANNEL_REQ] = "MM_SET_CHANNEL_REQ",
+	[MM_SET_CHANNEL_CFM] = "MM_SET_CHANNEL_CFM",
+	[MM_EXT_CALIB_REQ] = "MM_EXT_CALIB_REQ",
+	[MM_EXT_CALIB_CFM] = "MM_EXT_CALIB_CFM",
+	[MM_SET_DTIM_REQ] = "MM_SET_DTIM_REQ",
+	[MM_SET_DTIM_CFM] = "MM_SET_DTIM_CFM",
+	[MM_SET_BEACON_INT_REQ] = "MM_SET_BEACON_INT_REQ",
+	[MM_SET_BEACON_INT_CFM] = "MM_SET_BEACON_INT_CFM",
+	[MM_SET_BASIC_RATES_REQ] = "MM_SET_BASIC_RATES_REQ",
+	[MM_SET_BASIC_RATES_CFM] = "MM_SET_BASIC_RATES_CFM",
+	[MM_SET_BSSID_REQ] = "MM_SET_BSSID_REQ",
+	[MM_SET_BSSID_CFM] = "MM_SET_BSSID_CFM",
+	[MM_SET_EDCA_REQ] = "MM_SET_EDCA_REQ",
+	[MM_SET_EDCA_CFM] = "MM_SET_EDCA_CFM",
+	[MM_SET_ASSOCIATED_REQ] = "MM_SET_ASSOCIATED_REQ",
+	[MM_SET_ASSOCIATED_CFM] = "MM_SET_ASSOCIATED_CFM",
+	[MM_SET_SLOTTIME_REQ] = "MM_SET_SLOTTIME_REQ",
+	[MM_SET_SLOTTIME_CFM] = "MM_SET_SLOTTIME_CFM",
+	[MM_SET_IDLE_REQ] = "MM_SET_IDLE_REQ",
+	[MM_SET_IDLE_CFM] = "MM_SET_IDLE_CFM",
+	[MM_KEY_ADD_REQ] = "MM_KEY_ADD_REQ",
+	[MM_KEY_ADD_CFM] = "MM_KEY_ADD_CFM",
+	[MM_KEY_DEL_REQ] = "MM_KEY_DEL_REQ",
+	[MM_KEY_DEL_CFM] = "MM_KEY_DEL_CFM",
+	[MM_BA_ADD_TX_REQ] = "MM_BA_ADD_TX_REQ",
+	[MM_BA_ADD_TX_CFM] = "MM_BA_ADD_TX_CFM",
+	[MM_BA_ADD_RX_REQ] = "MM_BA_ADD_RX_REQ",
+	[MM_BA_ADD_RX_CFM] = "MM_BA_ADD_RX_CFM",
+	[MM_BA_DEL_REQ] = "MM_BA_DEL_REQ",
+	[MM_BA_DEL_CFM] = "MM_BA_DEL_CFM",
+	[MM_PHY_RESET_REQ] = "MM_PHY_RESET_REQ",
+	[MM_PHY_RESET_CFM] = "MM_PHY_RESET_CFM",
+	[MM_AVAILABLE_BA_TXQ_REQ] = "MM_AVAILABLE_BA_TXQ_REQ",
+	[MM_AVAILABLE_BA_TXQ_CFM] = "MM_AVAILABLE_BA_TXQ_CFM",
+	[MM_UPDATE_RATE_DL_REQ] = "MM_UPDATE_RATE_DL_REQ",
+	[MM_UPDATE_RATE_DL_CFM] = "MM_UPDATE_RATE_DL_CFM",
+	[MM_UPDATE_RATE_UL_REQ] = "MM_UPDATE_RATE_UL_REQ",
+	[MM_UPDATE_RATE_UL_CFM] = "MM_UPDATE_RATE_UL_CFM",
+	[MM_SET_VNS_REQ] = "MM_SET_VNS_REQ",
+	[MM_SET_VNS_CFM] = "MM_SET_VNS_CFM",
+	[MM_SET_TX_BF_REQ] = "MM_SET_TX_BF_REQ",
+	[MM_SET_TX_BF_CFM] = "MM_SET_TX_BF_CFM",
+	[MM_SOUNDING_REQ] = "MM_SOUNDING_REQ",
+	[MM_SOUNDING_CFM] = "MM_SOUNDING_CFM",
+	[MM_SOUNDING_PAIRING_REQ] = "MM_SOUNDING_PAIRING_REQ",
+	[MM_SOUNDING_PAIRING_CFM] = "MM_SOUNDING_PAIRING_CFM",
+	[MM_SOUNDING_INTERVAL_REQ] = "MM_SOUNDING_INTERVAL_REQ",
+	[MM_SOUNDING_INTERVAL_CFM] = "MM_SOUNDING_INTERVAL_CFM",
+	[MM_SET_DFS_REQ] = "MM_SET_DFS_REQ",
+	[MM_SET_DFS_CFM] = "MM_SET_DFS_CFM",
+	[MM_NDP_TX_CONTROL_REQ] = "MM_NDP_TX_CONTROL_REQ",
+	[MM_NDP_TX_CONTROL_CFM] = "MM_NDP_TX_CONTROL_CFM",
+	[MM_REG_WRITE_REQ] = "MM_REG_WRITE_REQ",
+	[MM_REG_WRITE_CFM] = "MM_REG_WRITE_CFM",
+	[MM_PROT_MODE_REQ] = "MM_PROT_MODE_REQ",
+	[MM_PROT_MODE_CFM] = "MM_PROT_MODE_CFM",
+	[MM_BACKUP_BCN_EN_REQ] = "MM_BACKUP_BCN_EN_REQ",
+	[MM_BACKUP_BCN_EN_CFM] = "MM_BACKUP_BCN_EN_CFM",
+	[MM_START_PERIODIC_TX_TIME_REQ] = "MM_START_PERIODIC_TX_TIME_REQ",
+	[MM_START_PERIODIC_TX_TIME_CFM] = "MM_START_PERIODIC_TX_TIME_CFM",
+	[MM_ANAMON_READ_REQ] = "MM_ANAMON_READ_REQ",
+	[MM_ANAMON_READ_CFM] = "MM_ANAMON_READ_CFM",
+	[MM_REFRESH_PWR_REQ] = "MM_REFRESH_PWR_REQ",
+	[MM_REFRESH_PWR_CFM] = "MM_REFRESH_PWR_CFM",
+	[MM_SET_ANT_PWR_OFFSET_REQ] = "MM_SET_ANT_PWR_OFFSET_REQ",
+	[MM_SET_ANT_PWR_OFFSET_CFM] = "MM_SET_ANT_PWR_OFFSET_CFM",
+	[MM_SET_RATE_FALLBACK_REQ] = "MM_SET_RATE_FALLBACK_REQ",
+	[MM_SET_RATE_FALLBACK_CFM] = "MM_SET_RATE_FALLBACK_CFM",
+	[MM_SPI_WRITE_REQ] = "MM_SPI_WRITE_REQ",
+	[MM_SPI_WRITE_CFM] = "MM_SPI_WRITE_CFM",
+	[MM_SPI_READ_REQ] = "MM_SPI_READ_REQ",
+	[MM_SPI_READ_CFM] = "MM_SPI_READ_CFM",
+
+	/* DBG messages */
+	[DBG_STR_SHIFT(DBG_SET_MOD_FILTER_REQ)] = "DBG_SET_MOD_FILTER_REQ",
+	[DBG_STR_SHIFT(DBG_SET_MOD_FILTER_CFM)] = "DBG_SET_MOD_FILTER_CFM",
+	[DBG_STR_SHIFT(DBG_CE_SET_MOD_FILTER_REQ)] = "DBG_CE_SET_MOD_FILTER_REQ",
+	[DBG_STR_SHIFT(DBG_CE_SET_MOD_FILTER_CFM)] = "DBG_CE_SET_MOD_FILTER_CFM",
+	[DBG_STR_SHIFT(DBG_SET_SEV_FILTER_REQ)] = "DBG_SET_SEV_FILTER_REQ",
+	[DBG_STR_SHIFT(DBG_SET_SEV_FILTER_CFM)] = "DBG_SET_SEV_FILTER_CFM",
+	[DBG_STR_SHIFT(DBG_GET_E2W_STATS_REQ)] = "DBG_GET_E2W_STATS_REQ",
+	[DBG_STR_SHIFT(DBG_GET_E2W_STATS_CFM)] = "DBG_GET_E2W_STATS_CFM",
+	[DBG_STR_SHIFT(DBG_SET_LA_MPIF_MASK_REQ)] = "DBG_SET_LA_MPIF_MASK_REQ",
+	[DBG_STR_SHIFT(DBG_SET_LA_MPIF_MASK_CFM)] = "DBG_SET_LA_MPIF_MASK_CFM",
+	[DBG_STR_SHIFT(DBG_SET_LA_TRIG_POINT_REQ)] = "DBG_SET_LA_TRIG_POINT_REQ",
+	[DBG_STR_SHIFT(DBG_SET_LA_TRIG_POINT_CFM)] = "DBG_SET_LA_TRIG_POINT_CFM",
+	[DBG_STR_SHIFT(DBG_SET_LA_MPIF_DEBUG_MODE_REQ)] = "DBG_SET_LA_MPIF_DEBUG_MODE_REQ",
+	[DBG_STR_SHIFT(DBG_SET_LA_MPIF_DEBUG_MODE_CFM)] = "DBG_SET_LA_MPIF_DEBUG_MODE_CFM",
+	[DBG_STR_SHIFT(DBG_SET_LA_TRIG_RULE_REQ)] = "DBG_SET_LA_TRIG_RULE_REQ",
+	[DBG_STR_SHIFT(DBG_SET_LA_TRIG_RULE_CFM)] = "DBG_SET_LA_TRIG_RULE_CFM",
+	[DBG_STR_SHIFT(DBG_TX_TRACE_DEBUG_FLAG_REQ)] = "DBG_TX_TRACE_DEBUG_FLAG_REQ",
+	[DBG_STR_SHIFT(DBG_TX_TRACE_DEBUG_FLAG_CFM)] = "DBG_TX_TRACE_DEBUG_FLAG_CFM",
+	[DBG_STR_SHIFT(DBG_PRINT_STATS_REQ)] = "DBG_PRINT_STATS_REQ",
+	[DBG_STR_SHIFT(DBG_PRINT_STATS_CFM)] = "DBG_PRINT_STATS_CFM",
+	[DBG_STR_SHIFT(DBG_TRIGGER_REQ)] = "DBG_TRIGGER_REQ",
+	[DBG_STR_SHIFT(DBG_TRIGGER_CFM)] = "DBG_TRIGGER_CFM",
+	[DBG_STR_SHIFT(DBG_TEST_MODE_REQ)] = "DBG_TEST_MODE_REQ",
+	[DBG_STR_SHIFT(DBG_TEST_MODE_CFM)] = "DBG_TEST_MODE_CFM",
+	[DBG_STR_SHIFT(DBG_SOUNDING_CMD_REQ)] = "DBG_SOUNDING_CMD_REQ",
+	[DBG_STR_SHIFT(DBG_SOUNDING_CMD_CFM)] = "DBG_SOUNDING_CMD_CFM",
+	[DBG_STR_SHIFT(DBG_PRESILICON_TESTING_REQ)] = "DBG_PRESILICON_TESTING_REQ",
+	[DBG_STR_SHIFT(DBG_PRESILICON_TESTING_CFM)] = "DBG_PRESILICON_TESTING_CFM",
+};
+
+static void cl_check_exception(struct cl_hw *cl_hw)
+{
+	/* Check if Tensilica exception occurred */
+	int i;
+	struct cl_ipc_exception_struct __iomem *data =
+		(struct cl_ipc_exception_struct __iomem *)cl_hw->ipc_env->shared;
+
+	if (__raw_readl(&data->pattern) != IPC_EXCEPTION_PATTERN)
+		return;
+
+	cl_dbg_err(cl_hw, "######################### firmware tensilica exception:\n");
+	cl_dbg_err(cl_hw, "................................. type: ");
+
+	switch (__raw_readl(&data->type)) {
+	case 0:
+		cl_dbg_err(cl_hw, "EXCEPTION_ILLEGALINSTRUCTION\n");
+		break;
+	case 2:
+		cl_dbg_err(cl_hw, "EXCEPTION_INSTRUCTIONFETCHERROR\n");
+		break;
+	case 3:
+		cl_dbg_err(cl_hw, "EXCEPTION_LOADSTOREERROR\n");
+		break;
+	case 6:
+		cl_dbg_err(cl_hw, "EXCEPTION_INTEGERDIVIDEBYZERO\n");
+		break;
+	case 7:
+		cl_dbg_err(cl_hw, "EXCEPTION_SPECULATION\n");
+		break;
+	case 8:
+		cl_dbg_err(cl_hw, "EXCEPTION_PRIVILEGED\n");
+		break;
+	case 9:
+		cl_dbg_err(cl_hw, "EXCEPTION_UNALIGNED\n");
+		break;
+	case 16:
+		cl_dbg_err(cl_hw, "EXCEPTION_INSTTLBMISS\n");
+		break;
+	case 17:
+		cl_dbg_err(cl_hw, "EXCEPTION_INSTTLBMULTIHIT\n");
+		break;
+	case 18:
+		cl_dbg_err(cl_hw, "EXCEPTION_INSTFETCHPRIVILEGE\n");
+		break;
+	case 20:
+		cl_dbg_err(cl_hw, "EXCEPTION_INSTFETCHPROHIBITED\n");
+		break;
+	case 24:
+		cl_dbg_err(cl_hw, "EXCEPTION_LOADSTORETLBMISS\n");
+		break;
+	case 25:
+		cl_dbg_err(cl_hw, "EXCEPTION_LOADSTORETLBMULTIHIT\n");
+		break;
+	case 26:
+		cl_dbg_err(cl_hw, "EXCEPTION_LOADSTOREPRIVILEGE\n");
+		break;
+	case 28:
+		cl_dbg_err(cl_hw, "EXCEPTION_LOADPROHIBITED\n");
+		break;
+	default:
+		cl_dbg_err(cl_hw, "unknown\n");
+		break;
+	}
+
+	cl_dbg_err(cl_hw, "................................. EPC: %08X\n",
+		   __raw_readl(&data->epc));
+	cl_dbg_err(cl_hw, "................................. EXCSAVE: %08X\n",
+		   __raw_readl(&data->excsave));
+	cl_dbg_err(cl_hw, "..............BACKTRACE-PC.....................\n");
+
+	for (i = 0; i < IPC_BACKTRACT_DEPTH; i++)
+		cl_dbg_err(cl_hw, "PC#%d: 0x%08X\n", i,
+			   __raw_readl(&data->backtrace.pc[i]));
+}
+
+static u16 cl_msg_cfm_clear_bit(u16 cfm)
+{
+	if (cfm < MM_REQ_CFM_MAX)
+		return ((cfm - 1) >> 1);
+
+	return ((cfm - 1 - FIRST_MSG(TASK_DBG) + MM_REQ_CFM_MAX) >> 1);
+}
+
+u16 cl_msg_cfm_set_bit(u16 req)
+{
+	if (req < MM_REQ_CFM_MAX)
+		return (req >> 1);
+
+	return ((req - FIRST_MSG(TASK_DBG) + MM_REQ_CFM_MAX) >> 1);
+}
+
+int cl_msg_cfm_wait(struct cl_hw *cl_hw, u16 bit, u16 req_id)
+{
+	/*
+	 * Start a timeout to stop on the main waiting queue,
+	 * and then check the result.
+	 */
+	struct cl_chip *chip = cl_hw->chip;
+	int timeout = 0, error = 0;
+	int max_timeout = 0;
+
+	if (IS_REAL_PHY(chip)) {
+		if (!cl_hw->msg_calib_timeout)
+			max_timeout = CL_MSG_CFM_TIMEOUT_JIFFIES;
+		else
+			max_timeout = CL_MSG_CFM_TIMEOUT_CALIB_JIFFIES;
+	} else if (chip->conf->ci_phy_dev == PHY_DEV_FRU) {
+		max_timeout = CL_MSG_CFM_TIMEOUT_FRU_JIFFIES;
+	} else {
+		max_timeout = CL_MSG_CFM_TIMEOUT_DUMMY_JIFFIES;
+	}
+
+	/* Wait for confirmation message */
+	timeout = wait_event_timeout(cl_hw->wait_queue,
+				     !CFM_TEST_BIT(bit, &cl_hw->cfm_flags),
+				     max_timeout);
+
+	if (timeout == 0) {
+		/*
+		 * Timeout occurred!
+		 * Make sure that confirmation wasn't received after the timeout.
+		 */
+		if (CFM_TEST_BIT(bit, &cl_hw->cfm_flags)) {
+			cl_dbg_verbose(cl_hw, "[WARN] Timeout occurred - %s\n",
+				       MSG_ID_STR(req_id));
+			error = -ETIMEDOUT;
+		}
+	}
+
+	if (error) {
+		struct cl_irq_stats *irq_stats = &chip->irq_stats;
+		unsigned long now = jiffies, flags;
+		u32 status, raw_status;
+
+		/*
+		 * The interrupt was not handled in time, lets try to handle it safely.
+		 * The spin lock protects us from the following race scenarios:
+		 * 1) atomic read of the IPC status register,
+		 * 2) execution on the msg handler twice from different context.
+		 * 3) disable context switch from the same core.
+		 */
+		spin_lock_irqsave(&chip->isr_lock, flags);
+
+		status = ipc_xmac_2_host_status_get(chip);
+		raw_status = ipc_xmac_2_host_raw_status_get(chip);
+
+		cl_dbg_verbose(cl_hw,
+			       "[INFO] status=0x%x, raw_status=0x%x, last_isr_statuses=0x%x, "
+			       "last_rx=%ums, last_tx=%ums, last_isr=%ums\n",
+			       status,
+			       raw_status,
+			       irq_stats->last_isr_statuses,
+			       jiffies_to_msecs(now - irq_stats->last_rx),
+			       jiffies_to_msecs(now - irq_stats->last_tx),
+			       jiffies_to_msecs(now - irq_stats->last_isr));
+
+		if (status & cl_hw->ipc_e2a_irq.msg) {
+			/*
+			 * WORKAROUND #1: In some cases the kernel is losing sync with the
+			 * interrupt handler and the reason is still unknown.
+			 * It seems that disabling master interrupt for a couple of cycles and
+			 * then re-enabling it restores the sync with the cl interrupt handler.
+			 */
+			ipc_host_global_int_en_set(chip, 0);
+
+			/* Acknowledge the MSG interrupt */
+			ipc_xmac_2_host_ack_set(cl_hw->chip, cl_hw->ipc_e2a_irq.msg);
+
+			/*
+			 * Unlock before calling cl_msg_rx_tasklet() because
+			 * spin_unlock_irqrestore() disables interrupts, but in
+			 * cl_msg_rx_tasklet() there might be several places that
+			 * use spin_unlock_bh() which enables soft-irqs.
+			 */
+			spin_unlock_irqrestore(&chip->isr_lock, flags);
+
+			/*
+			 * Call the tasklet handler (it also gives the CPU that
+			 * is mapped to the cl_interrupt few cycle to recover)
+			 */
+			cl_msg_rx_tasklet((unsigned long)cl_hw);
+
+			/* Re-enable master interrupts */
+			ipc_host_global_int_en_set(chip, 1);
+		} else {
+			/*
+			 * WORKAROUND #2: Try to call the handler unconditioanly.
+			 * Maybe we cleared the "cl_hw->ipc_e2a_irq.msg" without handling it.
+			 */
+
+			/*
+			 * Unlock before calling cl_msg_rx_tasklet() because
+			 * spin_unlock_irqrestore() disables interrupts, but in
+			 * cl_msg_rx_tasklet() there might be several places
+			 * that use spin_unlock_bh() which enables soft-irqs.
+			 */
+			spin_unlock_irqrestore(&chip->isr_lock, flags);
+
+			/* Call the tasklet handler */
+			cl_msg_rx_tasklet((unsigned long)cl_hw);
+		}
+
+		/* Did the workarounds work? */
+		if (CFM_TEST_BIT(bit, &cl_hw->cfm_flags)) {
+			cl_dbg_verbose(cl_hw, "[ERR] Failed to recover from timeout\n");
+		} else {
+			cl_dbg_verbose(cl_hw, "[INFO] Managed to recover from timeout\n");
+			error = 0;
+			goto exit;
+		}
+
+		/* Failed handling the message */
+		CFM_CLEAR_BIT(bit, &cl_hw->cfm_flags);
+
+		cl_check_exception(cl_hw);
+
+		cl_hw_assert_check(cl_hw);
+
+		if (!strcmp(chip->conf->ce_ela_mode, "XTDEBUG") ||
+		    !strcmp(chip->conf->ce_ela_mode, "XTDEBUG_STD")) {
+			/*
+			 * TODO: Special debug hack: collect debug info & skip restart
+			 * "wait4cfm" string is expected by debug functionality
+			 */
+			goto exit;
+		}
+
+		if (!test_bit(CL_DEV_HW_RESTART, &cl_hw->drv_flags) &&
+		    !test_bit(CL_DEV_SW_RESTART, &cl_hw->drv_flags) &&
+		    test_bit(CL_DEV_STARTED, &cl_hw->drv_flags) &&
+		    !cl_hw->is_stop_context) {
+			/* Unlock msg mutex before restarting */
+			mutex_unlock(&cl_hw->msg_tx_mutex);
+
+			cl_recovery_start(cl_hw, RECOVERY_WAIT4CFM);
+			return error;
+		}
+	}
+
+exit:
+	/* Unlock msg mutex */
+	mutex_unlock(&cl_hw->msg_tx_mutex);
+
+	return error;
+}
+
+static void cl_msg_cfm_assign_params(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	u32 *param;
+	u16 msg_id = le16_to_cpu(msg->id);
+	u16 msg_len = le16_to_cpu(msg->param_len);
+
+	/* A message sent in background is not allowed to assign confirmation parameters */
+	if (cl_hw->msg_background) {
+		cl_dbg_verbose(cl_hw,
+			       "Background message can't assign confirmation parameters (%s)\n",
+			       MSG_ID_STR(msg_id));
+		return;
+	}
+
+	if (msg->param_len) {
+		param = kzalloc(msg_len, GFP_ATOMIC);
+		if (param) {
+			memcpy(param, msg->param, msg_len);
+			if (cl_hw->msg_cfm_params[msg_id])
+				cl_dbg_err(cl_hw, "msg_cfm_params is not NULL for %s\n",
+					   MSG_ID_STR(msg_id));
+			cl_hw->msg_cfm_params[msg_id] = param;
+		} else {
+			cl_dbg_err(cl_hw, "param allocation failed\n");
+		}
+	} else {
+		u16 dummy_dest_id = le16_to_cpu(msg->dummy_dest_id);
+		u16 dummy_src_id = le16_to_cpu(msg->dummy_src_id);
+
+		cl_dbg_err(cl_hw, "msg->param_len is 0 [%u,%u,%u]\n",
+			   msg_id, dummy_dest_id, dummy_src_id);
+	}
+}
+
+void cl_msg_cfm_assign_and_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	u16 bit = cl_msg_cfm_clear_bit(le16_to_cpu(msg->id));
+
+	if (CFM_TEST_BIT(bit, &cl_hw->cfm_flags)) {
+		cl_msg_cfm_assign_params(cl_hw, msg);
+		CFM_CLEAR_BIT(bit, &cl_hw->cfm_flags);
+	} else {
+		cl_dbg_verbose(cl_hw, "Msg ID not set in cfm_flags (%s)\n",
+			       MSG_ID_STR(le16_to_cpu(msg->id)));
+	}
+}
+
+void cl_msg_cfm_clear(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	u16 bit = cl_msg_cfm_clear_bit(le16_to_cpu(msg->id));
+
+	if (!CFM_TEST_AND_CLEAR_BIT(bit, &cl_hw->cfm_flags))
+		cl_dbg_verbose(cl_hw, "Msg ID not set in cfm_flags (%s)\n",
+			       MSG_ID_STR(le16_to_cpu(msg->id)));
+}
+
+static inline void rx_mm_start_cfm(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	cl_msg_cfm_clear(cl_hw, msg);
+
+	/* Send indication to the embedded that a new rxbuffer element are ready */
+	cl_hw->ipc_host2xmac_trigger_set(cl_hw->chip, IPC_IRQ_A2E_RXBUF_BACK);
+}
+
+static inline void rx_mm_ba_add_cfm(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	if (le16_to_cpu(msg->id) == MM_BA_ADD_TX_CFM)
+		cl_msg_cfm_assign_and_clear(cl_hw, msg);
+	else
+		cl_msg_cfm_clear(cl_hw, msg);
+}
+
+static inline void rx_mm_agg_tx_report_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	struct cl_agg_tx_report *agg_report = (struct cl_agg_tx_report *)msg->param;
+	struct cl_sta *cl_sta;
+	union cl_rate_ctrl_info rate_ctrl_info;
+	u8 queue_idx = agg_report->tx_queue_idx;
+	u16 ssn = agg_report->new_ssn;
+
+	/* First handle agg cfm */
+	cl_tx_release_skbs_from_cfm(cl_hw, queue_idx, ssn);
+	/*
+	 * Take care of endianness and update gi and format_mod fields of rate
+	 * ctrl info in agg_report for the sake of any function that needs to
+	 * use them
+	 */
+	rate_ctrl_info.word = le32_to_cpu(agg_report->rate_cntrl_info);
+
+	cl_rate_ctrl_convert(&rate_ctrl_info);
+	agg_report->rate_cntrl_info = cpu_to_le32(rate_ctrl_info.word);
+
+	cl_sta_lock(cl_hw);
+	cl_sta = cl_sta_get(cl_hw, agg_report->sta_idx);
+
+	if (cl_sta) {
+		/* TX stats */
+		cl_agg_tx_report_handler(cl_hw, cl_sta, (void *)agg_report);
+		cl_stats_update_tx_agg(cl_hw, cl_sta, agg_report);
+
+		/* RSSI stats */
+		if (!agg_report->ba_not_received)
+			cl_rssi_block_ack_handler(cl_hw, cl_sta, agg_report);
+
+		/*
+		 * TODO: Do we need to notify upper layer at agg_report->success?
+		 * Ageout may need to reset ageout counter if at least one
+		 * frame was success.
+		 * May be needed when sending UDP downlink because BA's are not
+		 * forwarded to driver.
+		 */
+	}
+
+	cl_sta_unlock(cl_hw);
+
+	/* Schedule tasklet to try and empty the queue */
+	tasklet_schedule(&cl_hw->tx_task);
+}
+
+static inline void rx_mm_agg_rx_report_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	struct mm_agg_rx_ind *agg_report = (struct mm_agg_rx_ind *)msg->param;
+	struct cl_sta *cl_sta = NULL;
+	u8 sta_loc;
+
+	for (sta_loc = 0; sta_loc < agg_report->sta_num; sta_loc++) {
+		cl_sta_lock(cl_hw);
+		cl_sta = cl_sta_get(cl_hw, agg_report->sta_idx[sta_loc]);
+		if (cl_sta)
+			cl_agg_rx_report_handler(cl_hw, cl_sta, sta_loc, agg_report);
+		cl_sta_unlock(cl_hw);
+	}
+}
+
+static inline void rx_mm_sounding_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	struct mm_sounding_ind *ind = (struct mm_sounding_ind *)msg->param;
+
+	cl_sounding_indication(cl_hw, ind);
+}
+
+static inline void rx_mm_fw_error_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	struct mm_fw_error_ind *ind = (struct mm_fw_error_ind *)msg->param;
+
+	switch (ind->error_type) {
+	case MM_FW_ERROR_TYPE_MAX:
+	default:
+		cl_dbg_err(cl_hw, "Invalid fw error type %u\n", ind->error_type);
+		break;
+	}
+}
+
+static inline void rx_mm_idle_async_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	cl_hw->idle_async_set = false;
+
+	cl_dbg_trace(cl_hw, "Clear MM_IDLE_ASYNC_IND\n");
+}
+
+static inline void rx_dbg_print_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	cl_hw_assert_print(cl_hw, msg);
+}
+
+static inline void rx_dbg_info_ind(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	cl_fw_dbg_handler(cl_hw);
+}
+
+static void (*mm_hdlrs[])(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg) = {
+	[MM_RESET_CFM]                  = cl_msg_cfm_clear,
+	[MM_START_CFM]                  = rx_mm_start_cfm,
+	[MM_VERSION_CFM]                = cl_msg_cfm_assign_and_clear,
+	[MM_ADD_IF_CFM]                 = cl_msg_cfm_assign_and_clear,
+	[MM_REMOVE_IF_CFM]              = cl_msg_cfm_clear,
+	[MM_STA_ADD_CFM]                = cl_msg_cfm_assign_and_clear,
+	[MM_STA_DEL_CFM]                = cl_msg_cfm_clear,
+	[MM_SET_FILTER_CFM]             = cl_msg_cfm_clear,
+	[MM_SET_CHANNEL_CFM]            = cl_msg_cfm_clear,
+	[MM_EXT_CALIB_CFM]              = cl_msg_cfm_clear,
+	[MM_SET_DTIM_CFM]               = cl_msg_cfm_clear,
+	[MM_SET_BEACON_INT_CFM]         = cl_msg_cfm_clear,
+	[MM_SET_BASIC_RATES_CFM]        = cl_msg_cfm_clear,
+	[MM_SET_BSSID_CFM]              = cl_msg_cfm_clear,
+	[MM_SET_EDCA_CFM]               = cl_msg_cfm_clear,
+	[MM_SET_ASSOCIATED_CFM]         = cl_msg_cfm_clear,
+	[MM_SET_SLOTTIME_CFM]           = cl_msg_cfm_clear,
+	[MM_SET_IDLE_CFM]               = cl_msg_cfm_clear,
+	[MM_KEY_ADD_CFM]                = cl_msg_cfm_assign_and_clear,
+	[MM_KEY_DEL_CFM]                = cl_msg_cfm_clear,
+	[MM_BA_ADD_TX_CFM]              = rx_mm_ba_add_cfm,
+	[MM_BA_ADD_RX_CFM]              = rx_mm_ba_add_cfm,
+	[MM_BA_DEL_CFM]                 = cl_msg_cfm_assign_and_clear,
+	[MM_AVAILABLE_BA_TXQ_CFM]       = cl_msg_cfm_assign_and_clear,
+	[MM_UPDATE_RATE_DL_CFM]         = cl_msg_cfm_clear,
+	[MM_UPDATE_RATE_UL_CFM]         = cl_msg_cfm_clear,
+	[MM_SET_VNS_CFM]                = cl_msg_cfm_clear,
+	[MM_SET_TX_BF_CFM]              = cl_msg_cfm_clear,
+	[MM_PHY_RESET_CFM]              = cl_msg_cfm_clear,
+	[MM_SET_DFS_CFM]                = cl_msg_cfm_clear,
+	[MM_NDP_TX_CONTROL_CFM]         = cl_msg_cfm_clear,
+	[MM_REG_WRITE_CFM]              = cl_msg_cfm_clear,
+	[MM_PROT_MODE_CFM]              = cl_msg_cfm_clear,
+	[MM_SOUNDING_CFM]               = cl_msg_cfm_assign_and_clear,
+	[MM_SOUNDING_PAIRING_CFM]       = cl_msg_cfm_clear,
+	[MM_SOUNDING_INTERVAL_CFM]      = cl_msg_cfm_assign_and_clear,
+	[MM_BACKUP_BCN_EN_CFM]          = cl_msg_cfm_clear,
+	[MM_START_PERIODIC_TX_TIME_CFM] = cl_msg_cfm_clear,
+	[MM_ANAMON_READ_CFM]            = cl_msg_cfm_assign_and_clear,
+	[MM_REFRESH_PWR_CFM]            = cl_msg_cfm_clear,
+	[MM_SET_ANT_PWR_OFFSET_CFM]     = cl_msg_cfm_clear,
+	[MM_SET_RATE_FALLBACK_CFM]      = cl_msg_cfm_clear,
+	[MM_SPI_WRITE_CFM]              = cl_msg_cfm_clear,
+	[MM_SPI_READ_CFM]               = cl_msg_cfm_assign_and_clear,
+	[MM_AGG_TX_REPORT_IND]          = rx_mm_agg_tx_report_ind,
+	[MM_AGG_RX_REPORT_IND]          = rx_mm_agg_rx_report_ind,
+	[MM_SOUNDING_IND]               = rx_mm_sounding_ind,
+	[MM_FW_ERROR_IND]               = rx_mm_fw_error_ind,
+	[MM_IDLE_ASYNC_IND]             = rx_mm_idle_async_ind,
+	[MM_MAX]                        = NULL,
+};
+
+#define DBG_MSG_SHIFT(id)  ((id) - FIRST_MSG(TASK_DBG))
+
+static void (*dbg_hdlrs[])(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg) = {
+	[DBG_MSG_SHIFT(DBG_SET_MOD_FILTER_CFM)]         = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_SET_SEV_FILTER_CFM)]         = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_CE_SET_MOD_FILTER_CFM)]      = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_GET_E2W_STATS_CFM)]          = cl_msg_cfm_assign_and_clear,
+	[DBG_MSG_SHIFT(DBG_SET_LA_MPIF_MASK_CFM)]       = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_SET_LA_TRIG_POINT_CFM)]      = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_SET_LA_MPIF_DEBUG_MODE_CFM)] = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_SET_LA_TRIG_RULE_CFM)]       = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_TX_TRACE_DEBUG_FLAG_CFM)]    = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_PRINT_STATS_CFM)]            = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_TRIGGER_CFM)]                = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_TEST_MODE_CFM)]              = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_SOUNDING_CMD_CFM)]           = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_PRESILICON_TESTING_CFM)]     = cl_msg_cfm_clear,
+	[DBG_MSG_SHIFT(DBG_PRINT_IND)]                  = rx_dbg_print_ind,
+	[DBG_MSG_SHIFT(DBG_INFO_IND)]                   = rx_dbg_info_ind,
+	[DBG_MSG_SHIFT(DBG_MAX)]                        = NULL,
+};
+
+static bool cl_is_dbg_msg(u16 msg_id)
+{
+	return (msg_id >= FIRST_MSG(TASK_DBG) && msg_id < DBG_MAX);
+}
+
+static void cl_msg_rx_run_mm(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg, u16 msg_id)
+{
+	if (msg_id < MM_REQ_CFM_MAX)
+		cl_dbg_trace(cl_hw, "%s\n", msg2str[msg_id]);
+
+	mm_hdlrs[msg_id](cl_hw, msg);
+}
+
+static int cl_msg_rx_run_dbg(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg, u16 msg_id)
+{
+	u16 dbg_id = DBG_MSG_SHIFT(msg_id);
+
+	if (dbg_hdlrs[dbg_id]) {
+		if (msg_id < DBG_REQ_CFM_MAX) {
+			u16 str_id = DBG_STR_SHIFT(msg_id);
+
+			cl_dbg_trace(cl_hw, "%s\n", msg2str[str_id]);
+		}
+
+		dbg_hdlrs[dbg_id](cl_hw, msg);
+		return 0;
+	}
+
+	return -1;
+}
+
+static int cl_msg_rx_run(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	u16 msg_id = le16_to_cpu(msg->id);
+
+	if (msg_id < MM_MAX && mm_hdlrs[msg_id]) {
+		cl_msg_rx_run_mm(cl_hw, msg, msg_id);
+		return 0;
+	}
+
+	if (cl_is_dbg_msg(msg_id))
+		return cl_msg_rx_run_dbg(cl_hw, msg, msg_id);
+
+	return -1;
+}
+
+static bool cl_is_cfm_msg(u16 msg_id)
+{
+	/* A confirmation must be an odd id */
+	if ((msg_id & 0x1) == 0)
+		return false;
+
+	return ((msg_id < MM_FIRST_IND) || cl_is_dbg_msg(msg_id));
+}
+
+static int cl_msg_rx_handler(struct cl_hw *cl_hw, struct cl_ipc_e2a_msg *msg)
+{
+	int ret = 0;
+	u16 msg_id = le16_to_cpu(msg->id);
+
+	/* Relay further actions to the msg parser */
+	ret = cl_msg_rx_run(cl_hw, msg);
+
+	if (ret) {
+		cl_dbg_err(cl_hw, "Unexpected msg (%u)\n", msg_id);
+	} else {
+		/* Wake up the queue in case the msg is a confirmation */
+		if (cl_is_cfm_msg(msg_id))
+			wake_up(&cl_hw->wait_queue);
+	}
+
+	return ret;
+}
+
+void cl_msg_rx_tasklet(unsigned long data)
+{
+	struct cl_hw *cl_hw = (struct cl_hw *)data;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_e2a_msg_elem *msg_elem = NULL;
+	struct cl_ipc_e2a_msg *msg = NULL;
+	int msg_handled = 0;
+	u8 idx;
+
+	while (1) {
+		idx = ipc_env->e2a_msg_host_idx;
+		msg_elem = (struct cl_e2a_msg_elem *)(ipc_env->e2a_msg_hostbuf_array[idx].hostid);
+		msg = msg_elem->msgbuf_ptr;
+
+		/* Look for pattern which means that this hostbuf has been used for a MSG */
+		if (le32_to_cpu(msg->pattern) != IPC_E2A_MSG_VALID_PATTERN)
+			break;
+
+		cl_msg_rx_handler(cl_hw, msg);
+		msg_handled++;
+
+		/* Reset the msg element and re-use it */
+		msg->pattern = 0;
+
+		/* Make sure memory is written before push to HW */
+		wmb();
+
+		/* Push back the buffer */
+		cl_ipc_msgbuf_push(ipc_env, (ptrdiff_t)msg_elem, msg_elem->dma_addr);
+	}
+}
+
+void cl_msg_rx_flush_all(struct cl_hw *cl_hw)
+{
+	int i = 0;
+
+	for (i = FIRST_MSG(TASK_MM); i < MM_MAX; i++) {
+		if (cl_hw->msg_cfm_params[i]) {
+			cl_dbg_verbose(cl_hw, "free MM msg_cfm_params %d\n", i);
+			cl_msg_tx_free_cfm_params(cl_hw, i);
+		}
+	}
+
+	for (i = FIRST_MSG(TASK_DBG); i < DBG_MAX; i++) {
+		if (cl_hw->msg_cfm_params[i]) {
+			cl_dbg_verbose(cl_hw, "free DBG msg_cfm_params %d\n", i);
+			cl_msg_tx_free_cfm_params(cl_hw, i);
+		}
+	}
+}
+
+#define DRV_TASK_ID 100
+
+#define CL_DEF_ANT_BITMAP 0x55
+
+/* No scale-down on ASIC platform */
+#define CL_ASIC_FW_SCALEDOWN 1
+
+struct cl_msg_tx_work {
+	struct work_struct ws;
+
+	/* Background message info */
+	struct cl_hw *cl_hw;
+	void *msg_params;
+};
+
+void cl_msg_tx_free_cfm_params(struct cl_hw *cl_hw, u16 id)
+{
+	/* Free message and set pointer to NULL */
+	kfree(cl_hw->msg_cfm_params[id]);
+	cl_hw->msg_cfm_params[id] = NULL;
+}
+
+static inline void *cl_msg_zalloc(struct cl_hw *cl_hw, u16 msg_id, u8 dst_task_id, u16 param_len)
+{
+	struct cl_fw_msg *msg;
+	u32 total_size = ALIGN(sizeof(struct cl_fw_msg) + param_len, sizeof(u32));
+	u32 max_size = sizeof(u32) * IPC_A2E_MSG_BUF_SIZE;
+
+	if (total_size > max_size) {
+		cl_dbg_err(cl_hw, "total size (%u) > max size (%u)\n",
+			   total_size, max_size);
+		return NULL;
+	}
+
+	/* msg is freed out of the scope of this function */
+	msg = kzalloc(total_size, GFP_ATOMIC);
+	if (!msg)
+		return NULL;
+
+	msg->msg_id = cpu_to_le16(msg_id);
+	msg->dst_kern_id = cl_hw->fw_dst_kern_id;
+	msg->dst_task_id = dst_task_id;
+	msg->src_kern_id = KERN_HOST;
+	msg->src_task_id = DRV_TASK_ID;
+	msg->param_len = cpu_to_le16(param_len);
+
+	return msg->param;
+}
+
+static inline void cl_msg_free(const void *msg_param)
+{
+	kfree(container_of((void *)msg_param, struct cl_fw_msg, param));
+}
+
+static void cl_send_msg_background_handler(struct work_struct *ws)
+{
+	struct cl_msg_tx_work *msg_tx_work = container_of(ws, struct cl_msg_tx_work, ws);
+
+	cl_drv_ops_msg_fw_send(msg_tx_work->cl_hw, msg_tx_work->msg_params, true);
+	kfree(msg_tx_work);
+}
+
+static int cl_send_msg_background(struct cl_hw *cl_hw,
+				  const void *msg_params)
+{
+	/* Generate & populate the work struct wrapper for the background msg */
+	struct cl_msg_tx_work *msg_tx_work = kzalloc(sizeof(*msg_tx_work), GFP_ATOMIC);
+
+	if (msg_tx_work) {
+		INIT_WORK(&msg_tx_work->ws, cl_send_msg_background_handler);
+		msg_tx_work->cl_hw = cl_hw;
+		msg_tx_work->msg_params = (void *)msg_params;
+
+		/* Schedule work, the work will be executed in the background */
+		queue_work(cl_hw->drv_workqueue, &msg_tx_work->ws);
+
+		return 0;
+	}
+
+	cl_dbg_err(cl_hw, "msg_tx_work allocation failed\n");
+	cl_msg_free(msg_params);
+
+	return -ENODATA;
+}
+
+static int cl_send_request(struct cl_hw *cl_hw, const void *msg_params)
+{
+	int ret;
+	bool background = (preempt_count() != 0);
+
+	if (background) {
+		/*
+		 * asynchronous operation mode, message would be triggered in the background
+		 */
+		ret = cl_send_msg_background(cl_hw, msg_params);
+	} else {
+		/*
+		 * synchronous operation mode, message would be triggered immediately
+		 * feedback to caller given immediately
+		 */
+		ret = cl_drv_ops_msg_fw_send(cl_hw, msg_params, false);
+	}
+
+	/*
+	 * In case of synchronous mode ret success implies that the msg was successfully
+	 * transmited where is asynchronous mode ret success implies that the msg was
+	 * successfully pushed to background queue
+	 */
+	return ret;
+}
+
+int cl_msg_tx_reset(struct cl_hw *cl_hw)
+{
+	void *void_param;
+
+	/* RESET REQ has no parameter */
+	void_param = cl_msg_zalloc(cl_hw, MM_RESET_REQ, TASK_MM, 0);
+	if (!void_param)
+		return -ENOMEM;
+
+	return cl_send_request(cl_hw, void_param);
+}
+
+static u8 cl_copy_mask_bits(u8 mask, u8 num_bits)
+{
+	/* Copy first X bits that are set in mask to new_mask */
+	u8 i = 0, cntr = 0, new_mask = 0;
+
+	for (i = 0; i < MAX_ANTENNAS; i++) {
+		if (mask & BIT(i)) {
+			new_mask |= BIT(i);
+
+			cntr++;
+			if (cntr == num_bits)
+				break;
+		}
+	}
+
+	return new_mask;
+}
+
+static void cl_fill_ant_config(struct cl_hw *cl_hw,
+			       struct cl_antenna_config *ant_config,
+			       u8 num_antennas, u8 mask_antennas,
+			       u8 tx_mask_cck, u8 rx_mask_cck)
+{
+	struct cl_chip *chip = cl_hw->chip;
+	u8 ricu_cdb = 0;
+	u8 riu_chain_mask = 0x0;
+	u8 ant, riu_chain;
+
+	riu_chain_mask = cl_hw_ant_mask_to_riu_chain_mask(cl_hw, mask_antennas);
+	ant_config->num_tx_he = num_antennas;
+	ant_config->num_rx = num_antennas;
+	ant_config->mask_tx_he = riu_chain_mask;
+	ant_config->mask_rx = riu_chain_mask;
+
+	/* Configuration for TX OFDM/HT/VHT (limited to 4 antennas) */
+	if (num_antennas <= MAX_ANTENNAS_OFDM_HT_VHT) {
+		ant_config->num_tx_ofdm_ht_vht = num_antennas;
+		ant_config->mask_tx_ofdm_ht_vht = riu_chain_mask;
+	} else {
+		ant_config->num_tx_ofdm_ht_vht = MAX_ANTENNAS_OFDM_HT_VHT;
+		ant_config->mask_tx_ofdm_ht_vht =
+			cl_copy_mask_bits(riu_chain_mask, MAX_ANTENNAS_OFDM_HT_VHT);
+	}
+
+	/* Antenna configuration for CCK */
+	if (cl_band_is_24g(cl_hw)) {
+		for (ant = 0; ant < MAX_ANTENNAS; ant++) {
+			riu_chain = cl_hw_ant_to_riu_chain(cl_hw, ant);
+
+			if (tx_mask_cck & BIT(ant))
+				ant_config->mask_tx_cck |= BIT(riu_chain);
+
+			if (rx_mask_cck & BIT(ant))
+				ant_config->mask_rx_cck |= BIT(riu_chain);
+		}
+	}
+
+	if (IS_REAL_PHY(chip))
+		ricu_cdb = ricu_static_conf_0_cdb_mode_maj_getf(chip);
+	else
+		ricu_cdb = 4;
+
+	/*
+	 * In current implementation cdb_mode equals the num of ants for SX1
+	 * cbd_mask 0x0 -> SX0 chain. 0x1-> SX1 chain.
+	 */
+	ricu_cdb = MAX_ANTENNAS_CHIP - ricu_cdb;
+	ricu_cdb = ANT_MASK(ricu_cdb);
+	ricu_cdb = ~ricu_cdb;
+
+	ant_config->cdb_mask = ricu_cdb;
+
+	cl_dbg_trace(cl_hw, "num_tx_he %u, num_rx %u, mask_tx he 0x%x, mask_rx 0x%x, "
+	       "mask_tx_ofdm_ht_vht 0x%x, mask_tx_cck 0x%x, mask_rx_cck 0x%x\n",
+	       ant_config->num_tx_he, ant_config->num_rx, ant_config->mask_tx_he,
+	       ant_config->mask_rx, ant_config->mask_tx_ofdm_ht_vht, ant_config->mask_tx_cck,
+	       ant_config->mask_rx_cck);
+}
+
+static void cl_fill_fem_config(struct cl_hw *cl_hw, struct cl_fem_config *fem_conf)
+{
+	int i;
+	u32 reg[FEM_REGISTERS_AMOUNT] = {0};
+
+	cl_fem_get_registers(cl_hw, reg);
+
+	for (i = 0; i < FEM_REGISTERS_AMOUNT; i++)
+		fem_conf->reg[i] = cpu_to_le32(reg[i]);
+}
+
+static void cl_fill_calib_chain(struct cl_calib_chain *chain, u8 pair, u8 tx_gain, u8 rx_gain)
+{
+	chain->pair = pair;
+	chain->initial_tx_gain = tx_gain;
+	chain->initial_rx_gain = rx_gain;
+}
+
+static void cl_fill_chain_by_plan(struct cl_hw *cl_hw, struct cl_calib_param *calib_param, u8 chain,
+				  bool is_tx)
+{
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	struct cl_calib_chain *chain_msg_dst = is_tx ?
+					       &calib_param->tx_calib_chain[chain] :
+					       &calib_param->rx_calib_chain[chain];
+
+	/* Fill chain params by default values from nvram */
+	if (is_tx)
+		cl_fill_calib_chain(chain_msg_dst, conf->ci_calib_ant_tx[chain],
+				    conf->ci_calib_tx_init_tx_gain[chain],
+				    conf->ci_calib_tx_init_rx_gain[chain]);
+	else
+		cl_fill_calib_chain(chain_msg_dst, conf->ci_calib_ant_rx[chain],
+				    conf->ci_calib_rx_init_tx_gain[chain],
+				    conf->ci_calib_rx_init_rx_gain[chain]);
+}
+
+static void cl_fill_calib_config(struct cl_hw *cl_hw, struct cl_calib_param *calib_param,
+				 u16 primary, u16 center, struct cl_calib_params calib_params)
+{
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+	struct cl_tcv_conf *conf = cl_hw->conf;
+	s8 sx_freq_offset_mhz;
+	u8 mode = calib_params.mode;
+	u8 chain = 0;
+	u8 calib_bitmap = calib_params.plan_bitmap;
+
+	memset(calib_param->tx_calib_chain, U8_MAX, sizeof(struct cl_calib_chain) * MAX_ANTENNAS);
+	memset(calib_param->rx_calib_chain, U8_MAX, sizeof(struct cl_calib_chain) * MAX_ANTENNAS);
+
+	riu_chain_for_each(chain) {
+		if (calib_bitmap & (1 << chain)) {
+			/* TX fill */
+			cl_fill_chain_by_plan(cl_hw, calib_param, chain, true);
+			if (mode & SET_CHANNEL_MODE_CALIB_IQ)
+				/* RX fill */
+				cl_fill_chain_by_plan(cl_hw, calib_param, chain, false);
+		}
+	}
+
+	calib_param->conf.rx_gain_upper_limit = conf->ci_calib_conf_rx_gain_upper_limit;
+	calib_param->conf.rx_gain_lower_limit = conf->ci_calib_conf_rx_gain_lower_limit;
+	calib_param->conf.nco_freq = cpu_to_le16(CALIB_NCO_FREQ_DEFAULT);
+	calib_param->conf.nco_amp = CALIB_NCO_AMP_DEFAULT;
+	calib_param->conf.sleeve_trshld = GAIN_SLEEVE_TRSHLD_DEFAULT;
+	calib_param->conf.n_samples_exp_lolc = N_SAMPLES_EXP_LOLC;
+	calib_param->conf.n_samples_exp_iqc = N_SAMPLES_EXP_IQC;
+	calib_param->conf.p_thresh = cpu_to_le32(LO_P_THRESH);
+	calib_param->conf.n_bit_fir_scale = N_BIT_FIR_SCALE;
+	calib_param->conf.n_bit_amp_scale = N_BIT_AMP_SCALE;
+	calib_param->conf.n_bit_phase_scale = N_BIT_PHASE_SCALE;
+
+	cl_calib_iq_get_tone_vector(cl_hw, calib_param->conf.tone_vector);
+
+	calib_param->conf.gp_rad_trshld = cpu_to_le32(conf->ci_calib_conf_gp_rad_trshld);
+	calib_param->conf.ga_lin_upper_trshld =
+		cpu_to_le32(conf->ci_calib_conf_ga_lin_upper_trshld);
+	calib_param->conf.ga_lin_lower_trshld =
+		cpu_to_le32(conf->ci_calib_conf_ga_lin_lower_trshld);
+	calib_param->conf.comp_filter_len = COMP_FILTER_LEN_DEFAULT;
+	calib_param->conf.singletons_num = conf->ci_calib_conf_singletons_num;
+	calib_param->conf.tones_num = IQ_NUM_TONES_REQ;
+	calib_param->conf.rampup_time = cpu_to_le16(conf->ci_calib_conf_rampup_time);
+	calib_param->conf.lo_coarse_step = cpu_to_le16(conf->ci_calib_conf_lo_coarse_step);
+	calib_param->conf.lo_fine_step = cpu_to_le16(conf->ci_calib_conf_lo_fine_step);
+
+	sx_freq_offset_mhz = calib_params.sx_freq_offset_mhz;
+
+	calib_param->other_tcv.prim20_freq = cpu_to_le16(primary + sx_freq_offset_mhz);
+	cl_phy_oly_lut_update(cl_hw->chip->rfic_version, cl_hw->nl_band,
+			      center + sx_freq_offset_mhz,
+			      &calib_param->other_tcv.center1_freq_lut);
+
+	if (cl_chip_is_both_enabled(cl_hw->chip)) {
+		calib_param->other_tcv.mask_tx_he =
+			cl_hw_ant_mask_to_riu_chain_mask(cl_hw_other,
+							 cl_hw_other->mask_num_antennas);
+		calib_param->other_tcv.num_tx_he = cl_hw_other->num_antennas;
+		calib_param->other_tcv.band = cl_band_to_fw_idx(cl_hw_other);
+	} else {
+		calib_param->other_tcv.mask_tx_he =
+			cl_hw_ant_mask_to_riu_chain_mask(cl_hw, cl_hw->mask_num_antennas);
+		calib_param->other_tcv.num_tx_he = cl_hw->num_antennas;
+		calib_param->other_tcv.band = cl_band_to_fw_idx(cl_hw);
+	}
+
+	cl_dbg_info(cl_hw, "tcv_idx = %u, channel = %u, bw = %u, sx_freq_offset_mhz = %d\n",
+		    cl_hw->tcv_idx, cl_hw->channel, cl_hw->bw, sx_freq_offset_mhz);
+	cl_dbg_info(cl_hw, "|       TX Calibration      ||       RX Calibration      |\n");
+	cl_dbg_info(cl_hw, "|chain|pair |tx_gain|rx_gain||chain|pair |tx_gain|rx_gain|\n");
+	riu_chain_for_each(chain) {
+		cl_dbg_info(cl_hw, "|  %u  |  %u  | 0x%X  | 0x%X  ||  %u  |  %u  | 0x%X  | 0x%X  |"
+			    "\n", chain, calib_param->tx_calib_chain[chain].pair,
+			    calib_param->tx_calib_chain[chain].initial_tx_gain,
+			    calib_param->tx_calib_chain[chain].initial_rx_gain, chain,
+			    calib_param->rx_calib_chain[chain].pair,
+			    calib_param->rx_calib_chain[chain].initial_tx_gain,
+			    calib_param->rx_calib_chain[chain].initial_rx_gain);
+	}
+}
+
+int cl_msg_tx_start(struct cl_hw *cl_hw)
+{
+	struct mm_start_req *req;
+	struct cl_phy_cfg *phy_cfg;
+	struct cl_start_param *param;
+	struct cl_cca_config *cca_config;
+	struct dbg_meta_data *dbg_metadata;
+	struct cl_chip *chip = cl_hw->chip;
+	struct cl_tcv_conf *tcv_conf = cl_hw->conf;
+	struct cl_chip_conf *chip_conf = chip->conf;
+	struct cl_ipc_host_env *ipc_env = cl_hw->ipc_env;
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+
+	u8 bw = 0, ant = 0;
+	int ret_val;
+
+	req = cl_msg_zalloc(cl_hw, MM_START_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	phy_cfg = &req->phy_cfg;
+	param = &req->param;
+	cca_config = &phy_cfg->cca_config;
+	dbg_metadata = &param->dbg_metadata;
+
+	phy_cfg->band = cl_band_to_fw_idx(cl_hw);
+
+	if (cl_hw_other)
+		phy_cfg->other_band = cl_band_to_fw_idx(cl_hw_other);
+
+	phy_cfg->channel_bandwidth = tcv_conf->ci_cap_bandwidth;
+	phy_cfg->ht_rxldpc_en = tcv_conf->ci_ht_rxldpc_en;
+	phy_cfg->freq_offset = cpu_to_le16(chip->eeprom_cache->calib_power.freq_offset);
+	phy_cfg->vns_tx_power_mode = cl_hw_is_prod_or_listener(cl_hw) ? 0 :
+		tcv_conf->ci_vns_pwr_mode;
+	phy_cfg->vns_rssi_suto_resp_th = tcv_conf->ci_vns_rssi_auto_resp_thr;
+	phy_cfg->afe_config_en = chip_conf->ci_afe_config_en;
+	phy_cfg->no_capture_noise_sleep = chip_conf->ci_no_capture_noise_sleep;
+	phy_cfg->gain_update_enable = tcv_conf->ci_gain_update_enable;
+	phy_cfg->mcs_sig_b = tcv_conf->ci_mcs_sig_b;
+	phy_cfg->ofdm_only = tcv_conf->ci_ofdm_only;
+	phy_cfg->hr_factor = tcv_conf->ci_hr_factor[phy_cfg->channel_bandwidth];
+	phy_cfg->td_csd_en = tcv_conf->ci_csd_en;
+	phy_cfg->pe_duration_bcast = tcv_conf->ci_pe_duration_bcast;
+	phy_cfg->tx_digital_gain = cpu_to_le32(tcv_conf->ci_tx_digital_gain);
+	phy_cfg->tx_digital_gain_cck = cpu_to_le32(tcv_conf->ci_tx_digital_gain_cck);
+	phy_cfg->ofdm_cck_power_offset = (u8)tcv_conf->ci_ofdm_cck_power_offset;
+	phy_cfg->phy_clk_gating_en = tcv_conf->ci_phy_clk_gating_en;
+	phy_cfg->tcv1_chains_sx0 = chip_conf->ci_tcv1_chains_sx0;
+	phy_cfg->dsp_lcu_mode = tcv_conf->ci_dsp_lcu_mode;
+
+	/*
+	 * Set rx_sensitivity according to number of antennas.
+	 * For all other antennas set 0xff which is equal to -1
+	 */
+	memcpy(phy_cfg->rx_sensitivity, cl_hw->rx_sensitivity, MAX_ANTENNAS);
+
+	if (!cl_hw->fw_send_start) {
+		cl_hw->fw_send_start = true;
+		phy_cfg->first_start = true;
+	}
+
+	cl_fill_ant_config(cl_hw, &phy_cfg->ant_config, cl_hw->num_antennas,
+			   cl_hw->mask_num_antennas, tcv_conf->ce_cck_tx_ant_mask,
+			   tcv_conf->ce_cck_rx_ant_mask);
+	cl_fill_fem_config(cl_hw, &phy_cfg->fem_conf);
+
+	if (!chip->rf_reg_overwrite || cl_recovery_in_progress(cl_hw)) {
+		chip->rf_reg_overwrite = true;
+		cl_rfic_read_overwrite_file(cl_hw,
+					    phy_cfg->rf_reg_overwrite_info,
+					    true);
+	}
+
+	cca_config->ed_rise_thr_dbm = (u8)tcv_conf->ci_cca_ed_rise_thr_dbm;
+	cca_config->ed_fall_thr_dbm = (u8)tcv_conf->ci_cca_ed_fall_thr_dbm;
+	cca_config->cs_en = tcv_conf->ci_cca_cs_en;
+	cca_config->modem_en = tcv_conf->ci_cca_modem_en;
+	cca_config->main_ant = cl_hw_ant_to_riu_chain(cl_hw, tcv_conf->ci_cca_main_ant);
+	cca_config->second_ant = cl_hw_ant_to_riu_chain(cl_hw, tcv_conf->ci_cca_second_ant);
+	cca_config->flag0_ctrl = tcv_conf->ci_cca_flag0_ctrl;
+	cca_config->flag1_ctrl = tcv_conf->ci_cca_flag1_ctrl;
+	cca_config->flag2_ctrl = tcv_conf->ci_cca_flag2_ctrl;
+	cca_config->flag3_ctrl = tcv_conf->ci_cca_flag3_ctrl;
+	cca_config->gi_rise_thr_dbm = (u8)tcv_conf->ci_cca_gi_rise_thr_dbm;
+	cca_config->gi_fall_thr_dbm = (u8)tcv_conf->ci_cca_gi_fall_thr_dbm;
+	cca_config->gi_pow_lim_dbm = (u8)tcv_conf->ci_cca_gi_pow_lim_dbm;
+	cca_config->ed_en = cpu_to_le16(tcv_conf->ci_cca_ed_en);
+	cca_config->gi_en = tcv_conf->ci_cca_gi_en;
+
+	param->prot_log_nav_en = tcv_conf->ce_prot_log_nav_en;
+	param->prot_mode = cl_prot_mode_get(cl_hw);
+	param->prot_rate_format = tcv_conf->ce_prot_rate_format;
+	param->prot_rate_mcs = tcv_conf->ce_prot_rate_mcs;
+	param->prot_rate_pre_type = tcv_conf->ce_prot_rate_pre_type;
+	param->bw_signaling_mode = tcv_conf->ce_bw_signaling_mode;
+	param->cfm_size = cpu_to_le16(IPC_CFM_SIZE);
+	param->cfm_dma_base_addr = cpu_to_le32(ipc_env->cfm_dma_base_addr);
+	param->phy_dev = cpu_to_le16(chip_conf->ci_phy_dev);
+	param->fw_scale_down = cpu_to_le16(CL_ASIC_FW_SCALEDOWN);
+	param->hal_timeout.idle = cpu_to_le32(tcv_conf->ci_hal_idle_to);
+	param->hal_timeout.ac0 = cpu_to_le32(tcv_conf->ci_tx_ac0_to);
+	param->hal_timeout.ac1 = cpu_to_le32(tcv_conf->ci_tx_ac1_to);
+	param->hal_timeout.ac2 = cpu_to_le32(tcv_conf->ci_tx_ac2_to);
+	param->hal_timeout.ac3 = cpu_to_le32(tcv_conf->ci_tx_ac3_to);
+	param->hal_timeout.bcn = cpu_to_le32(tcv_conf->ci_tx_bcn_to);
+
+	/* Update rxbuff/txqueue & ring_indices that hold the array metadata */
+	param->ipc_ring_indices_base = cpu_to_le32(ipc_env->ring_indices_elem->dma_addr);
+	param->host_rxbuf_base_addr[CL_RX_BUF_RXM] =
+		ipc_env->rx_hostbuf_array[CL_RX_BUF_RXM].dma_payload_base_addr;
+	param->host_rxbuf_base_addr[CL_RX_BUF_FW] =
+		ipc_env->rx_hostbuf_array[CL_RX_BUF_FW].dma_payload_base_addr;
+
+	/*
+	 * The FW needs to be aware of the DMA addresses of the
+	 * TX queues so it could fetch txdesc from the host.
+	 */
+	param->ipc_host_tx_queues_dma_addr = cpu_to_le32(cl_hw->ipc_env->tx_queues.dma_addr);
+
+	/*
+	 * Compilation flags match check - please add here all compilation flags
+	 * which should be compiled on both driver and firmware.
+	 */
+	param->comp_flags = cpu_to_le32(0) | cpu_to_le32(BIT(CENX_CFG_CE_TX_CFM));
+	param->dbg_test_mode_max = cpu_to_le16(DBG_TEST_MODE_MAX);
+	param->ipc_rxbuf_size[CL_RX_BUF_RXM] =
+		cpu_to_le16(tcv_conf->ci_ipc_rxbuf_size[CL_RX_BUF_RXM]);
+	param->ipc_rxbuf_size[CL_RX_BUF_FW] =
+		cpu_to_le16(tcv_conf->ci_ipc_rxbuf_size[CL_RX_BUF_FW]);
+
+	param->host_pci_gen_ver = chip_conf->ce_host_pci_gen_ver;
+	param->dma_lli_max_chan[0] = chip_conf->ci_dma_lli_max_chan[0];
+	param->dma_lli_max_chan[1] = chip_conf->ci_dma_lli_max_chan[1];
+	param->production_mode = chip_conf->ce_production_mode;
+	param->mult_ampdu_in_txop_en = tcv_conf->ci_mult_ampdu_in_txop_en;
+	param->cca_timeout = cpu_to_le32(tcv_conf->ci_cca_timeout);
+	param->long_retry_limit = tcv_conf->ce_long_retry_limit;
+	param->short_retry_limit = tcv_conf->ce_short_retry_limit;
+	param->assoc_auth_retry_limit = tcv_conf->ci_assoc_auth_retry_limit;
+	param->bcn_tx_path_min_time = cpu_to_le16(tcv_conf->ce_bcn_tx_path_min_time);
+	param->backup_bcn_en = tcv_conf->ci_backup_bcn_en;
+	param->tx_txop_cut_en = tcv_conf->ce_tx_txop_cut_en;
+	param->ac_with_bcns_flushed_cnt_thr = tcv_conf->ci_bcns_flushed_cnt_thr;
+	param->txl_statistics_struct_size = cpu_to_le32(sizeof(struct cl_txl_statistics));
+	param->rxl_statistics_struct_size = cpu_to_le32(sizeof(struct cl_rxl_statistics));
+	param->phy_err_prevents_phy_dump = tcv_conf->ci_phy_err_prevents_phy_dump;
+	param->tx_rx_delay = tcv_conf->ci_tx_rx_delay;
+	param->assert_storm_detect_thd = tcv_conf->ci_fw_assert_storm_detect_thd;
+	param->assert_time_diff_sec = tcv_conf->ci_fw_assert_time_diff_sec;
+	param->ps_ctrl_enabled = tcv_conf->ce_ps_ctrl_enabled;
+	param->phy_data_dma_addr = cpu_to_le32(cl_hw->phy_data_info.dma_addr);
+	param->phy_remote_rom_dma_addr = cpu_to_le32(cl_hw->fw_remote_rom.dma_addr);
+	param->iq_dcoc_calib_tables_dma_addr = cpu_to_le32(cl_hw->iq_dcoc_data_info.dma_addr);
+	param->power_table_dma_addr = cpu_to_le32(cl_hw->power_table_info.dma_addr);
+	param->min_ant_pwr_q1 = cl_power_min_ant_q1(cl_hw);
+
+	for (bw = 0; bw < ARRAY_SIZE(param->bw_factor_q2); bw++) {
+		cl_hw->power_db.bw_factor_q2[bw] = cl_power_bw_factor_q2(cl_hw, bw);
+		param->bw_factor_q2[bw] =
+			cl_convert_signed_to_reg_value(cl_hw->power_db.bw_factor_q2[bw]);
+	}
+
+	for (ant = 0; ant < ARRAY_SIZE(param->ant_factor_q2); ant++) {
+		cl_hw->power_db.ant_factor_q2[ant] = cl_power_array_gain_q2(cl_hw, ant + 1);
+		param->ant_factor_q2[ant] = cl_hw->power_db.ant_factor_q2[ant];
+	}
+
+	param->default_distance.auto_resp_all = tcv_conf->ci_distance_auto_resp_all;
+	param->default_distance.auto_resp_msta = tcv_conf->ci_distance_auto_resp_msta;
+	param->su_force_min_spacing_usec = tcv_conf->ci_su_force_min_spacing;
+	param->mu_force_min_spacing_usec = tcv_conf->ci_mu_force_min_spacing;
+	param->single_tcv = cl_hw_is_tcv0(cl_hw) ?
+		cl_chip_is_only_tcv0_enabled(chip) : cl_chip_is_only_tcv1_enabled(chip);
+	param->rx_padding = tcv_conf->ci_rx_padding_en;
+	param->bar_cap_disable = tcv_conf->ci_bar_disable;
+	param->hw_bsr = tcv_conf->ci_hw_bsr;
+	param->drop_to_lower_bw = tcv_conf->ci_drop_to_lower_bw;
+	param->dra_enable = cl_chip_is_both_enabled(chip); /* DRA enable only in CDB mode */
+	param->mac_clk_gating_en = tcv_conf->ci_mac_clk_gating_en;
+	param->imaging_blocker = tcv_conf->ci_imaging_blocker;
+	param->fec_coding = tcv_conf->ci_he_rxldpc_en;
+	param->cs_required = tcv_conf->ci_cs_required;
+	param->fw_disable_recovery = tcv_conf->ci_fw_disable_recovery;
+
+	dbg_metadata->lmac_req_buf_size = cpu_to_le32(sizeof(struct dbg_error_trace_info_drv));
+	dbg_metadata->physical_queue_cnt = CL_MAX_BA_PHYSICAL_QUEUE_CNT;
+	dbg_metadata->agg_index_max = AGG_IDX_MAX;
+	dbg_metadata->ce_ac_max = CE_AC_MAX;
+	dbg_metadata->mu_user_max = MU_MAX_STREAMS;
+	dbg_metadata->txl_exch_trace_depth = DBG_TXL_FRAME_EXCH_TRACE_DEPTH;
+	dbg_metadata->mac_hw_regs_max = cpu_to_le16(HAL_MACHW_REG_NUM);
+	dbg_metadata->phy_hw_regs_max = cpu_to_le16(PHY_HW_DBG_REGS_CNT);
+	dbg_metadata->thd_chains_data_size = cpu_to_le16(DBG_THD_CHAINS_INFO_ARRAY_SIZE);
+	dbg_metadata->chains_info_elem_cnt = DBG_CHAINS_INFO_ELEM_CNT;
+
+	/* RFIC_init requires that only one TCV may enter */
+	mutex_lock(&chip->start_msg_lock);
+	phy_cfg->is_first_rfic = !chip->first_start_sent;
+	chip->first_start_sent = true;
+
+	ret_val = cl_send_request(cl_hw, req);
+	mutex_unlock(&chip->start_msg_lock);
+
+	return ret_val;
+}
+
+int cl_msg_tx_version(struct cl_hw *cl_hw)
+{
+	void *void_param;
+
+	/* VERSION REQ has no parameter */
+	void_param = cl_msg_zalloc(cl_hw, MM_VERSION_REQ, TASK_MM, 0);
+	if (!void_param)
+		return -ENOMEM;
+
+	return cl_send_request(cl_hw, void_param);
+}
+
+int cl_msg_tx_add_if(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+		     u8 vif_index)
+{
+	struct mm_add_if_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_ADD_IF_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	cl_mac_addr_copy(req->addr.array, vif->addr);
+
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+	case NL80211_IFTYPE_P2P_CLIENT:
+		req->type = MM_STA;
+		break;
+
+	case NL80211_IFTYPE_ADHOC:
+		req->type = MM_IBSS;
+		break;
+
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_P2P_GO:
+		req->type = MM_AP;
+		break;
+
+	case NL80211_IFTYPE_MONITOR:
+		req->type = MM_MONITOR;
+		break;
+
+	case NL80211_IFTYPE_MESH_POINT:
+		req->type = MM_MESH_POINT;
+		break;
+
+	default:
+		req->type = MM_STA;
+		break;
+	}
+
+	req->tx_strip_vlan = 1;
+	req->mac_addr_hi_mask = cpu_to_le32(cl_hw->mask_hi);
+	req->mac_addr_low_mask = cpu_to_le32(cl_hw->mask_low);
+	req->inst_nbr = vif_index;
+
+	if (vif->type == NL80211_IFTYPE_AP) {
+		struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+		struct ps_data *ps = &sdata->u.ap.ps;
+
+		req->start_dtim_count = (u8)(ps->dtim_count);
+	}
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_remove_if(struct cl_hw *cl_hw, u8 vif_index)
+{
+	struct mm_remove_if_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_REMOVE_IF_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->inst_nbr = vif_index;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sta_add(struct cl_hw *cl_hw, struct ieee80211_sta *sta,
+		      struct cl_vif *cl_vif, u8 recovery_sta_idx,
+		      u32 rate_ctrl_info)
+{
+	struct mm_sta_add_req *req;
+	struct ieee80211_sta_ht_cap *ht_cap = &sta->ht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
+	struct ieee80211_sta_he_cap *he_cap = &sta->he_cap;
+	u16 my_aid = 0;
+	u8 inst_nbr = cl_vif->vif_index;
+	bool is_6g = cl_band_is_6g(cl_hw);
+	struct cl_sta *cl_sta = IEEE80211_STA_TO_CL_STA(sta);
+
+	req = cl_msg_zalloc(cl_hw, MM_STA_ADD_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	cl_mac_addr_copy(req->mac_addr.array, sta->addr);
+
+	if (cl_vif->vif->type == NL80211_IFTYPE_STATION)
+		my_aid = cl_vif->vif->bss_conf.aid;
+
+	if (is_6g) {
+		u8 mac_cap_info4 = he_cap->he_cap_elem.mac_cap_info[4];
+
+		req->su_bfee = !!(mac_cap_info4 & IEEE80211_HE_PHY_CAP4_SU_BEAMFORMEE);
+		req->mu_bfee = !!(mac_cap_info4 & IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER);
+	} else if (vht_cap->vht_supported) {
+		req->su_bfee = !!(vht_cap->cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE);
+		req->mu_bfee = !!(vht_cap->cap & IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE);
+	}
+
+	req->ampdu_min_spacing = cl_sta->ampdu_min_spacing;
+
+	if (he_cap->has_he) {
+		u8 mac_cap_info1 = he_cap->he_cap_elem.mac_cap_info[1];
+		u8 mac_cap_info3 = he_cap->he_cap_elem.mac_cap_info[3];
+
+		req->he_tf_mac_padding_duration =
+			(mac_cap_info1 & IEEE80211_HE_MAC_CAP1_TF_MAC_PAD_DUR_MASK);
+
+		req->he_rx_ctrl_frm_to_mbss =
+			(mac_cap_info3 & IEEE80211_HE_MAC_CAP3_RX_CTRL_FRAME_TO_MULTIBSS);
+		/* Fill PE duration table */
+		cl_cap_ppe_duration(cl_hw, sta, req->pe_duration);
+	}
+
+	cl_ampdu_size_exp(cl_hw, sta, &req->ampdu_size_exp_he,
+			  &req->ampdu_size_exp_vht, &req->ampdu_size_exp_ht);
+
+	if (cl_hw->conf->ce_txldpc_en) {
+		if (he_cap->has_he)
+			req->ldpc_enabled = !!(he_cap->he_cap_elem.phy_cap_info[1] &
+					     IEEE80211_HE_PHY_CAP1_LDPC_CODING_IN_PAYLOAD);
+		else if (vht_cap->vht_supported)
+			req->ldpc_enabled = !!(vht_cap->cap & IEEE80211_VHT_CAP_RXLDPC);
+		else if (ht_cap->ht_supported)
+			req->ldpc_enabled = !!(ht_cap->cap & IEEE80211_HT_CAP_LDPC_CODING);
+	}
+
+	/* TODO: Set the interface index from the vif structure */
+	req->inst_nbr = inst_nbr;
+
+	req->aid = cpu_to_le16(sta->aid);
+	req->my_aid = cpu_to_le16(my_aid);
+	req->recovery_sta_idx = recovery_sta_idx;
+
+	/* Station power save configuration */
+	req->uapsd_queues = sta->uapsd_queues;
+	req->max_sp = sta->max_sp;
+
+	/* Set WRS default parameters for rate control */
+	req->tx_params.rate = cpu_to_le32(rate_ctrl_info);
+
+	/* Fill TX antenna with default value */
+	req->tx_params.ant_set = CL_DEF_ANT_BITMAP;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sta_del(struct cl_hw *cl_hw, u8 sta_idx)
+{
+	struct mm_sta_del_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_STA_DEL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sta_idx = sta_idx;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_filter(struct cl_hw *cl_hw, u32 filter, bool force)
+{
+	struct mm_set_filter_req *req;
+	u32 rx_filter = 0;
+
+	if (force)
+		rx_filter = filter;
+	else
+		rx_filter = cl_rx_filter_update_flags(cl_hw, filter);
+
+	if (rx_filter == cl_hw->rx_filter) {
+		cl_dbg_trace(cl_hw, "Rx filter 0x%x already set - return\n", rx_filter);
+		return 0;
+	}
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_FILTER_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	/* Now copy all the flags into the message parameter */
+	req->filter = cpu_to_le32(rx_filter);
+	cl_hw->rx_filter = rx_filter;
+
+	cl_dbg_trace(cl_hw, "new total_flags = 0x%08x\nrx filter set to  0x%08x\n",
+		     filter, rx_filter);
+
+	return cl_send_request(cl_hw, req);
+}
+
+static u8 cl_mark_calib_flags(struct cl_hw *cl_hw, u8 mode)
+{
+	int lna = 0;
+	int chain = 0;
+	u8 calib_info_set = 0;
+	struct cl_iq_dcoc_info *iq_dcoc_db = &cl_hw->phy_data_info.data->iq_dcoc_db;
+
+	/* In case DCOC is going to be calibrated, no need to raise any calibration flag. */
+	if (mode & SET_CHANNEL_MODE_CALIB_DCOC)
+		return calib_info_set;
+
+	/* Check if DCOC flag should be marked */
+	for (lna = 0; lna < DCOC_LNA_GAIN_NUM; lna++) {
+		riu_chain_for_each(chain) {
+			if (iq_dcoc_db->dcoc[lna][chain].i || iq_dcoc_db->dcoc[lna][chain].q) {
+				calib_info_set |= SET_PHY_DATA_FLAGS_DCOC;
+				break;
+			}
+		}
+	}
+
+	/* Check if IQ Tx LOLC flag should be marked */
+	riu_chain_for_each(chain) {
+		if (iq_dcoc_db->iq_tx_lolc[chain]) {
+			calib_info_set |= SET_PHY_DATA_FLAGS_IQ_TX_LOLC;
+			break;
+		}
+	}
+
+	/* Check if IQ Tx flag should be marked */
+	riu_chain_for_each(chain) {
+		if (iq_dcoc_db->iq_tx[chain].coef0 || iq_dcoc_db->iq_tx[chain].coef1 ||
+		    iq_dcoc_db->iq_tx[chain].coef2 || iq_dcoc_db->iq_tx[chain].gain) {
+			calib_info_set |= SET_PHY_DATA_FLAGS_IQ_TX;
+			break;
+		}
+	}
+
+	/* Check if IQ Rx flag should be marked */
+	riu_chain_for_each(chain) {
+		if (iq_dcoc_db->iq_rx[chain].coef0 || iq_dcoc_db->iq_rx[chain].coef1 ||
+		    iq_dcoc_db->iq_rx[chain].coef2 || iq_dcoc_db->iq_rx[chain].gain) {
+			calib_info_set |= SET_PHY_DATA_FLAGS_IQ_RX;
+			return calib_info_set;
+		}
+	}
+	return calib_info_set;
+}
+
+static int _cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u16 primary,
+				  u16 center, struct cl_calib_params calib_params)
+{
+	struct mm_set_channel_req *req;
+	struct cl_hw *cl_hw_other = cl_hw_other_tcv(cl_hw);
+
+	int res = 0;
+	struct cl_phy_data *data = cl_hw->phy_data_info.data;
+	u8 mode = calib_params.mode;
+
+	if (WARN_ON_ONCE(channel == 0))
+		return -EINVAL;
+
+	/* Fill AGC parameters - check before we start building the message */
+	if (cl_agc_params_fill(cl_hw, &data->agc_params))
+		return -1;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_CHANNEL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->band = cl_band_to_fw_idx(cl_hw);
+
+	if (cl_hw_other)
+		req->other_band = cl_band_to_fw_idx(cl_hw_other);
+
+	req->bandwidth = bw;
+	req->prim20_freq = cpu_to_le16(primary);
+	cl_phy_oly_lut_update(cl_hw->chip->rfic_version, cl_hw->nl_band, center,
+			      &req->center1_freq_lut);
+	req->sx_freq_offset_mhz = calib_params.sx_freq_offset_mhz;
+	req->hr_factor = cl_hw->conf->ci_hr_factor[bw];
+	req->signal_ext = cl_hw->conf->ci_signal_extension_en;
+
+	/* Set power per mcs offset after EIRP truncation */
+	cl_power_tables_update(cl_hw, &data->pwr_tables);
+
+	/* Get antenna power offset from eeprom */
+	cl_calib_power_offset_fill(cl_hw, channel, bw, req->ant_pwr_offset);
+
+	if (cl_hw->conf->ce_listener_en)
+		cl_calib_common_fill_phy_data(cl_hw, &data->iq_dcoc_db,
+					      SET_PHY_DATA_FLAGS_LISTENER);
+	else
+		cl_calib_common_fill_phy_data(cl_hw, &data->iq_dcoc_db, SET_PHY_DATA_FLAGS_ALL);
+
+	req->calib_info_set = cl_mark_calib_flags(cl_hw, mode);
+	req->calib_param.mode = mode;
+
+	if (mode & (SET_CHANNEL_MODE_CALIB_LOLC | SET_CHANNEL_MODE_CALIB_IQ))
+		cl_fill_calib_config(cl_hw, &req->calib_param, primary, center, calib_params);
+
+	if (mode & SET_CHANNEL_MODE_CALIB_DCOC) {
+		if (cl_hw->chip->conf->ci_phy_dev == PHY_DEV_ATHOS) {
+			u8 rfic_version = cl_hw->chip->rfic_version;
+
+			if (rfic_version == U8_MAX)
+				cl_dbg_trace(cl_hw, "Couldn't read rfic version\n");
+
+			if (rfic_version == ATHOS_B_VER)
+				req->calib_param.dcoc_max_vga = DCOC_MAX_VGA_ATHOS_B;
+			else
+				req->calib_param.dcoc_max_vga = DCOC_MAX_VGA_ATHOS;
+		} else {
+			req->calib_param.dcoc_max_vga = DCOC_MAX_VGA;
+		}
+	}
+
+	/* Antenna configuration */
+	cl_fill_ant_config(cl_hw, &req->ant_config, cl_hw->num_antennas, cl_hw->mask_num_antennas,
+			   cl_hw->conf->ce_cck_tx_ant_mask, cl_hw->conf->ce_cck_rx_ant_mask);
+	/* FEM configuration */
+	cl_fill_fem_config(cl_hw, &req->fem_conf);
+
+	cl_rfic_read_overwrite_file(cl_hw, req->rf_reg_overwrite_info, false);
+
+	cl_dbg_info(cl_hw,
+		    "band=%u, other_band=%u, channel=%u, bw=%u, primary=%u.%u, center=%u.%u, sx_index=%u\n",
+		    cl_hw->conf->ci_band_num, req->other_band, channel, bw, GET_FREQ_INT(primary),
+		    GET_FREQ_FRAC(primary), GET_FREQ_INT(center), GET_FREQ_FRAC(center),
+		    cl_hw->tcv_idx);
+
+	res = cl_send_request(cl_hw, req);
+
+	cl_temperature_comp_update_calib(cl_hw);
+
+	return res;
+}
+
+int cl_msg_tx_set_channel(struct cl_hw *cl_hw, u32 channel, u8 bw, u32 primary,
+			  u32 center, struct cl_calib_params calib_params)
+{
+	int res = 0;
+	u8 mode = calib_params.mode;
+	s8 sx_freq_offset_mhz = calib_params.sx_freq_offset_mhz;
+	u32 primary_q2 = FREQ_TO_Q2(primary);
+	u32 center_q2 = FREQ_TO_Q2(center);
+
+	/*
+	 * Need to take mutex lock to ensure that no one touching the phy_data
+	 * DMA before FW is reading all its values.
+	 * The mutex is unlocked right after the iq_dcoc_data_info DMA is
+	 * handled in cl_calib_common_handle_set_channel_cfm.
+	 */
+	res = mutex_lock_interruptible(&cl_hw->set_channel_mutex);
+
+	if (res != 0) {
+		cl_dbg_verbose(cl_hw, "Error - mutex_lock_interruptible (%d)\n", res);
+		return res;
+	}
+
+	cl_hw->channel = channel;
+	cl_hw->bw = bw;
+	cl_hw->primary_freq = primary;
+	cl_hw->center_freq = center;
+
+	if (mode == SET_CHANNEL_MODE_CALIB_MANUAL) {
+		primary_q2 += sx_freq_offset_mhz;
+		center_q2 += sx_freq_offset_mhz;
+	}
+
+	if (mode & SET_CHANNEL_MODE_CALIB)
+		cl_hw->msg_calib_timeout = true;
+
+	res = _cl_msg_tx_set_channel(cl_hw, channel, bw, primary_q2, center_q2, calib_params);
+
+	if (mode & SET_CHANNEL_MODE_CALIB) {
+		cl_hw->msg_calib_timeout = false;
+
+		if (!res)
+			res = cl_calib_common_handle_set_channel_cfm(cl_hw, calib_params);
+	}
+
+	mutex_unlock(&cl_hw->set_channel_mutex);
+
+	return res;
+}
+
+int cl_msg_tx_dtim(struct cl_hw *cl_hw, u8 dtim_period)
+{
+	struct mm_set_dtim_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_DTIM_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->dtim_period = dtim_period;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_beacon_int(struct cl_hw *cl_hw, u16 beacon_int, u8 vif_idx)
+{
+	struct mm_set_beacon_int_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_BEACON_INT_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->beacon_int = cpu_to_le16(beacon_int);
+	req->inst_nbr = vif_idx;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_basic_rates(struct cl_hw *cl_hw, u32 basic_rates)
+{
+	struct mm_set_basic_rates_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_BASIC_RATES_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->rates = cpu_to_le32(basic_rates);
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_bssid(struct cl_hw *cl_hw, const u8 *bssid, u8 vif_idx)
+{
+	struct mm_set_bssid_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_BSSID_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	cl_mac_addr_copy(req->bssid.array, bssid);
+	req->inst_nbr = vif_idx;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_edca(struct cl_hw *cl_hw, u8 hw_queue, u32 param,
+		       struct ieee80211_he_mu_edca_param_ac_rec *mu_edca)
+{
+	struct mm_set_edca_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_EDCA_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->ac_param = cpu_to_le32(param);
+	req->hw_queue = hw_queue;
+
+	if (mu_edca) {
+		req->mu_edca_aifsn = mu_edca->aifsn;
+		req->mu_edca_ecw_min_max = mu_edca->ecw_min_max;
+		req->mu_edca_timer = mu_edca->mu_edca_timer;
+	}
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_associated(struct cl_hw *cl_hw,
+			     struct ieee80211_bss_conf *bss_conf)
+{
+	struct mm_set_associated_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_ASSOCIATED_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->aid = cpu_to_le16(bss_conf->aid);
+
+	/* Multiple BSSID feature support */
+	if (bss_conf->nontransmitted && bss_conf->assoc) {
+		u8 i = 0;
+		u8 mask_addr[ETH_ALEN] = {0};
+		u32 bssid_hi_mask = 0;
+		u32 bssid_low_mask = 0;
+
+		for (i = 0; i < ETH_ALEN; i++)
+			mask_addr[i] = (bss_conf->transmitter_bssid[i] ^
+					bss_conf->bssid[i]);
+		cl_mac_addr_array_to_nxmac(mask_addr, &bssid_low_mask,
+					   &bssid_hi_mask);
+		/* Set mask to allow the transmitter BSSID Rx reception */
+		req->bssid_hi_mask = cpu_to_le32(bssid_hi_mask);
+		req->bssid_low_mask = cpu_to_le32(bssid_low_mask);
+	}
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_slottime(struct cl_hw *cl_hw, bool use_short_slot)
+{
+	struct mm_set_slottime_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_SLOTTIME_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->slottime = use_short_slot ? 9 : 20;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_idle(struct cl_hw *cl_hw, u8 idle, bool is_lock)
+{
+	struct mm_set_idle_req *req;
+	int ret = 0;
+
+	if (cl_fem_read_wiring_id(cl_hw->chip)) {
+		cl_dbg_err(cl_hw, "!!! Invalid wiring id [%u] !!! Aborting\n",
+			   cl_hw->chip->fem.wiring_id);
+		return -1;
+	}
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_IDLE_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	if (is_lock)
+		mutex_lock(&cl_hw->chip->set_idle_mutex);
+
+	req->hw_idle = idle;
+
+	cl_dbg_info(cl_hw, "idle = %s\n", idle ? "True" : "False");
+
+	ret = cl_send_request(cl_hw, req);
+
+	if (is_lock)
+		mutex_unlock(&cl_hw->chip->set_idle_mutex);
+
+	return ret;
+}
+
+void cl_msg_tx_idle_async(struct cl_hw *cl_hw, bool is_lock)
+{
+	if (!IS_REAL_PHY(cl_hw->chip))
+		return;
+
+	cl_hw->idle_async_set = true;
+	cl_msg_tx_set_idle(cl_hw, MAC_IDLE_ASYNC, is_lock);
+}
+
+int cl_msg_tx_key_add(struct cl_hw *cl_hw, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta,
+		      struct ieee80211_key_conf *key_conf,
+		      u8 cipher_suite)
+{
+	struct mm_key_add_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_KEY_ADD_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	/* Set Pairwise Default key */
+	if (sta)
+		req->sta_idx = ((struct cl_sta *)sta->drv_priv)->sta_idx;
+	else
+		req->sta_idx = 0xFF;
+
+	req->key_idx = (u8)(key_conf->keyidx);
+	req->inst_nbr = ((struct cl_vif *)vif->drv_priv)->vif_index;
+	req->key.length = key_conf->keylen;
+
+	/* TODO: check if this works well in Big endian platforms */
+	memcpy(req->key.array, key_conf->key, key_conf->keylen);
+
+	req->cipher_suite = cipher_suite;
+	req->spp = cl_hw->conf->ci_spp_ksr_value;
+
+	cl_dbg_info(cl_hw, "sta_idx:%u, key_idx:%u, inst_nbr:%u, cipher:%u, key_len:%u, spp:%u\n",
+		    req->sta_idx, req->key_idx, req->inst_nbr,
+		    req->cipher_suite, req->key.length, req->spp);
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_key_del(struct cl_hw *cl_hw, u8 hw_key_idx)
+{
+	struct mm_key_del_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_KEY_DEL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->hw_key_idx = hw_key_idx;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_ba_add(struct cl_hw *cl_hw, u8 type, u8 sta_idx,
+		     u16 tid, u16 bufsz, u16 ssn)
+{
+	struct mm_ba_add_req *req;
+	u16 msg_id = ((type == BA_AGMT_TX) ? MM_BA_ADD_TX_REQ : MM_BA_ADD_RX_REQ);
+
+	req = cl_msg_zalloc(cl_hw, msg_id, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->type = type;
+	req->sta_idx = sta_idx;
+	req->tid = (u8)tid;
+	req->bufsz = cpu_to_le16(bufsz);
+	req->ssn = cpu_to_le16(ssn);
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_ba_del(struct cl_hw *cl_hw, u8 sta_idx, u16 tid)
+{
+	struct mm_ba_del_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_BA_DEL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sta_idx = sta_idx;
+	req->tid = (u8)tid;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_available_ba_txq(struct cl_hw *cl_hw, u8 sta_idx, u16 tid)
+{
+	struct mm_available_ba_txq_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_AVAILABLE_BA_TXQ_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sta_idx = sta_idx;
+	req->tid = (u8)tid;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_update_rate_dl(struct cl_hw *cl_hw, u8 sta_idx, u32 rate, u32 rate_fallback,
+			     u8 req_bw_tx, u8 op_mode, u8 gid, u8 mu_valid, u8 ltf,
+			     u8 ltf_fallback, u32 rate_he)
+{
+	struct mm_update_rate_dl_req *req;
+
+	cl_dbg_info(cl_hw, "sta_idx=%u, rate=0x%x, rate_fallback=0x%x, req_bw_tx=%u, "
+		    "op_mode=%u, gid=%u, mu_valid=%u, ltf=%u, ltf_fallback=%u, rate_he=0x%x\n",
+		    sta_idx, rate, rate_fallback, req_bw_tx, op_mode, gid, mu_valid,
+		    ltf, ltf_fallback, rate_he);
+
+	req = cl_msg_zalloc(cl_hw, MM_UPDATE_RATE_DL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->tx_params.rate = cpu_to_le32(rate);
+	req->tx_params.rate_he = cpu_to_le32(rate_he);
+	req->tx_params.req_bw_tx = req_bw_tx;
+	req->tx_params.ant_set = CL_DEF_ANT_BITMAP;
+	req->tx_params.ltf = ltf;
+
+	req->op_mode = op_mode;
+	req->sta_idx = sta_idx;
+	req->rate_fallback = cpu_to_le32(rate_fallback);
+	req->ltf_fallback = ltf_fallback;
+
+	/* Gid & mu valid bit is relevant only for MU rate updates. */
+	if (op_mode == RATE_OP_MODE_STA_MU) {
+		req->group_id = gid;
+		req->mu_is_rate_valid = mu_valid;
+	}
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_update_rate_ul(struct cl_hw *cl_hw, u8 sta_idx, u8 bw, u8 nss, u8 mcs, u8 gi_ltf)
+{
+	struct mm_update_rate_ul_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_UPDATE_RATE_UL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sta_idx = sta_idx;
+	req->bw = bw;
+	req->nss = nss;
+	req->mcs = mcs;
+	req->gi_ltf = gi_ltf;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_vns(struct cl_hw *cl_hw, u8 sta_idx, u8 is_vns)
+{
+	struct mm_set_vns_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_VNS_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sta_idx = sta_idx;
+	req->is_vns = is_vns;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_tx_bf(struct cl_hw *cl_hw, u8 sta_idx, u8 is_on, u8 is_on_fallback)
+{
+	struct mm_set_tx_bf_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_TX_BF_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sta_idx = sta_idx;
+	req->is_on = is_on;
+	req->is_on_fallback = is_on_fallback;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sounding(struct cl_hw *cl_hw,
+		       struct mm_sounding_req *sounding_req)
+{
+	struct mm_sounding_req *req;
+	u8 i;
+
+	req = cl_msg_zalloc(cl_hw, MM_SOUNDING_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	memcpy(req, sounding_req, sizeof(*req));
+
+	/* In case of non-TB HE SU/CQI, nc should be set to 0 */
+	if (req->sounding_type == SOUNDING_TYPE_HE_CQI ||
+	    req->sounding_type == SOUNDING_TYPE_HE_SU)
+		for (i = 0; i < req->sta_num; i++)
+			req->info_per_sta[i].nc = 0;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sounding_pairing(struct cl_hw *cl_hw, u8 sounding_id, u8 sounding_type,
+			       u8 gid, u8 sta_idx)
+{
+	struct mm_sounding_pairing *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SOUNDING_PAIRING_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sounding_type = sounding_type;
+	req->sta_idx = sta_idx;
+	req->gid = gid;
+	req->sounding_id = sounding_id;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_sounding_interval(struct cl_hw *cl_hw, u16 interval, u16 lifetime,
+				u8 sounding_type, u8 sta_idx)
+{
+	struct mm_sounding_interval_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SOUNDING_INTERVAL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->interval = cpu_to_le16(interval);
+	req->bfr_lifetime = cpu_to_le16(lifetime);
+	req->sounding_type = sounding_type;
+	req->sta_idx = sta_idx;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_dfs(struct cl_hw *cl_hw, bool enable, u8 standard,
+		      u8 initial_gain, u8 agc_cd_th)
+{
+	struct mm_set_dfs_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_DFS_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->enable = enable;
+	req->standard_fcc = standard == NL80211_DFS_FCC;
+	req->initial_gain = initial_gain;
+	req->agc_cd_th = agc_cd_th;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_ndp_tx_control(struct cl_hw *cl_hw, u8 chain_mask, u8 bw, u8 format, u8 num_ltf)
+{
+	struct mm_ndp_tx_control_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_NDP_TX_CONTROL_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->chain_mask = chain_mask;
+	req->bw = bw;
+	req->format = format;
+	req->num_ltf = num_ltf;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_reg_write(struct cl_hw *cl_hw, u32 address, u32 value, u32 mask)
+{
+	struct mm_reg_write_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_REG_WRITE_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->address = cpu_to_le32(address);
+	req->value = cpu_to_le32(value);
+	req->mask = cpu_to_le32(mask);
+
+	cl_dbg_info(cl_hw, "address=0x%x, value=0x%x, mask=0x%x\n", address, value, mask);
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_prot_mode(struct cl_hw *cl_hw, u8 log_nav_en, u8 mode, u8 rate_format,
+			u8 rate_mcs, u8 rate_pre_type)
+{
+	struct mm_prot_mode_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_PROT_MODE_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->log_nav_en = log_nav_en;
+	req->mode = mode;
+	req->rate_format = rate_format;
+	req->rate_mcs = rate_mcs;
+	req->rate_pre_type = rate_pre_type;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_backup_bcn_en(struct cl_hw *cl_hw, bool backup_bcn_en)
+{
+	struct mm_set_backup_bcn_en_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_BACKUP_BCN_EN_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->backup_bcn_en = backup_bcn_en;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_start_periodic_tx_time(struct cl_hw *cl_hw, u16 periodic_tx_time_off,
+				     u16 periodic_tx_time_on)
+{
+	struct mm_start_periodic_tx_time_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_START_PERIODIC_TX_TIME_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->periodic_tx_time_off = cpu_to_le16(periodic_tx_time_off);
+	req->periodic_tx_time_on = cpu_to_le16(periodic_tx_time_on);
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_anamon_read(struct cl_hw *cl_hw, u8 mode, u8 param1, u8 param2)
+{
+	struct mm_anamon_read_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_ANAMON_READ_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->mode = mode;
+	req->param1 = param1;
+	req->param2 = param2;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_refresh_power(struct cl_hw *cl_hw)
+{
+	void *void_param;
+
+	/* MM_REFRESH_PWR_REQ has no parameter */
+	void_param = cl_msg_zalloc(cl_hw, MM_REFRESH_PWR_REQ, TASK_MM, 0);
+	if (!void_param)
+		return -ENOMEM;
+
+	return cl_send_request(cl_hw, void_param);
+}
+
+int cl_msg_tx_set_ant_pwr_offset(struct cl_hw *cl_hw, s8 pwr_offset[MAX_ANTENNAS])
+{
+	struct mm_set_ant_pwr_offset_req *req;
+	u8 chain, i = 0;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_ANT_PWR_OFFSET_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	for (i = 0; i < MAX_ANTENNAS; i++) {
+		if (!(cl_hw->mask_num_antennas & BIT(i)))
+			continue;
+
+		chain = cl_hw_ant_to_riu_chain(cl_hw, i);
+		pwr_offset[i] = cl_power_offset_check_margin(cl_hw, cl_hw->bw, i, pwr_offset[i]);
+		req->pwr_offset[chain] = cl_convert_signed_to_reg_value(pwr_offset[i]);
+	}
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_set_rate_fallback(struct cl_hw *cl_hw)
+{
+	struct mm_rate_fallback_req *req;
+	struct cl_tcv_conf *conf = cl_hw->conf;
+
+	req = cl_msg_zalloc(cl_hw, MM_SET_RATE_FALLBACK_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->fallback_count_su = conf->ci_rate_fallback[CL_RATE_FALLBACK_COUNT_SU];
+	req->fallback_count_mu = conf->ci_rate_fallback[CL_RATE_FALLBACK_COUNT_MU];
+	req->retry_count_thr = conf->ci_rate_fallback[CL_RATE_FALLBACK_RETRY_COUNT_THR];
+	req->ba_per_thr = conf->ci_rate_fallback[CL_RATE_FALLBACK_BA_PER_THR];
+	req->ba_not_received_thr = conf->ci_rate_fallback[CL_RATE_FALLBACK_BA_NOT_RECEIVED_THR];
+	req->disable_mcs0 = conf->ci_rate_fallback[CL_RATE_FALLBACK_DISABLE_MCS];
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_spi_write(struct cl_hw *cl_hw, u8 page, u8 addr, u8 val, u8 mask)
+{
+	struct mm_spi_write_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SPI_WRITE_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->page = page;
+	req->addr = addr;
+	req->val = val;
+	req->mask = mask;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_spi_read(struct cl_hw *cl_hw, u8 page, u8 addr)
+{
+	struct mm_spi_read_req *req;
+
+	req = cl_msg_zalloc(cl_hw, MM_SPI_READ_REQ, TASK_MM, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->page = page;
+	req->addr = addr;
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_ce_mod_filter(struct cl_hw *cl_hw, u32 filter)
+{
+	struct dbg_set_mod_filter_req *req;
+
+	req = cl_msg_zalloc(cl_hw, DBG_CE_SET_MOD_FILTER_REQ, TASK_DBG, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->mod_filter = cpu_to_le32(filter);
+
+	return cl_send_request(cl_hw, req);
+}
+
+int cl_msg_tx_dbg_set_sev_filter(struct cl_hw *cl_hw, u32 filter)
+{
+	struct dbg_set_sev_filter_req *req;
+
+	req = cl_msg_zalloc(cl_hw, DBG_SET_SEV_FILTER_REQ, TASK_DBG, sizeof(*req));
+	if (!req)
+		return -ENOMEM;
+
+	req->sev_filter = cpu_to_le32(filter);
+
+	return cl_send_request(cl_hw, req);
+}
+
+/* Work struct wrapper for print statistics */
+struct cl_print_stats_work {
+	struct work_struct ws;
+	struct cl_hw *cl_hw;
+	u32 dbg_info_type;
+};
+
+static void cl_print_rx_stats_precent(struct cl_hw *cl_hw, const char *str, u32 x, u32 y)
+{
+	/*
+	 * Example:
+	 * x = 541, y = 19
+	 * Result 28.4736
+	 */
+	u32 integer = x / y;
+	u32 fraction = 10000 * (x - y * (x / y)) / y;
+
+	fw_pr(cl_hw, "%s = %u.%04u\n", str, integer, fraction);
+}
+
+static void cl_print_rx_stats(struct cl_hw *cl_hw, struct cl_rxl_statistics *rx_stats)
+{
+	int i, mu_idx, total_rx = 0;
+	enum format_mode fm;
+
+	fw_pr(cl_hw, "=========================================\n");
+	fw_pr(cl_hw, "        Global RX stats\n");
+	fw_pr(cl_hw, "=========================================\n");
+	fw_pr(cl_hw, "host rxelem not ready      = %u\n",
+	      rx_stats->host_rxelem_not_ready_cnt);
+	fw_pr(cl_hw, "MSDU host rxelem not ready = %u\n",
+	      rx_stats->msdu_host_rxelem_not_ready_cnt);
+	fw_pr(cl_hw, "MSDU dma pool not ready    = %u\n",
+	      rx_stats->dma_rx_pool_not_ready_cnt);
+	fw_pr(cl_hw, "Percent of Rx CCA busy      = %u\n",
+	      rx_stats->cca_busy_percent);
+	fw_pr(cl_hw, "Percent of Rx mine CCA busy = %u\n",
+	      rx_stats->rx_mine_busy_percent);
+	fw_pr(cl_hw, "Percent of Tx mine busy     = %u\n",
+	      rx_stats->tx_mine_busy_percent);
+	fw_pr(cl_hw, "\n");
+
+	fw_pr(cl_hw, "=== Rx Format ==\n");
+	for (fm = 0; fm < FORMATMOD_MAX; fm++)
+		if (rx_stats->stats_rx_format[fm])
+			fw_pr(cl_hw, "Rx Format[%d] = %u\n", fm, rx_stats->stats_rx_format[fm]);
+
+	fw_pr(cl_hw, "=== Rx Decryption errors ==\n");
+	for (i = RHD_DECR_ICVFAIL_IDX; i < RHD_DECR_IDX_MAX; i++)
+		if (rx_stats->decrypt_err[i])
+			fw_pr(cl_hw, "decrypt_err[%d] = %u\n", i, rx_stats->decrypt_err[i]);
+
+	/* RX prints */
+	for (mu_idx = 0; mu_idx < MU_UL_MAX; mu_idx++) {
+		fw_pr(cl_hw, "============================================\n");
+		fw_pr(cl_hw, "=====         RX MAC HW MU [%2d]       =====\n", mu_idx);
+		fw_pr(cl_hw, "============================================\n");
+		total_rx = rx_stats->total_rx_packets[mu_idx] +
+			rx_stats->fcs_error_counter[mu_idx] +
+			rx_stats->phy_error_counter[mu_idx] +
+			rx_stats->ampdu_incorrect_received_counter[mu_idx] +
+			rx_stats->delimiter_error_counter[mu_idx] +
+			rx_stats->rx_fifo_overflow_err_cnt[mu_idx];
+
+		if (total_rx == 0)
+			continue;
+
+		for (i = 0; i < MAX_HANDLED_FRM_TYPE; i++) {
+			if (!rx_stats->emb_ll1_handled_frame_counter[mu_idx][i])
+				continue;
+
+			fw_pr(cl_hw, "emb_handled_packet[%d] - %u\n",
+			      i, rx_stats->emb_ll1_handled_frame_counter[mu_idx][i]);
+		}
+
+		fw_pr(cl_hw, "Total packets dropped (pckt_len > %u) %u\n",
+		      rx_stats->max_mpdu_data_len[mu_idx],
+		      rx_stats->rx_pckt_exceed_max_len_cnt[mu_idx]);
+		fw_pr(cl_hw, "Number of bad formated BA frames = %u\n",
+		      rx_stats->rx_pckt_bad_ba_statinfo_cnt[mu_idx]);
+		fw_pr(cl_hw, "Max occupancy list2 = %u\n",
+		      rx_stats->rhd_ll2_max_cnt[mu_idx]);
+		fw_pr(cl_hw, "Max occupancy list1 = %u\n",
+		      rx_stats->rhd_ll1_max_cnt[mu_idx]);
+		fw_pr(cl_hw, "\n");
+		fw_pr(cl_hw, "Total Qos MPDU received    = %u\n",
+		      rx_stats->total_rx_packets[mu_idx]);
+		fw_pr(cl_hw, "Total Aggregation received = %u\n",
+		      rx_stats->total_agg_packets[mu_idx]);
+		fw_pr(cl_hw, "Number of Rx Fifo Overflow = %u\n",
+		      rx_stats->rx_fifo_overflow_err_cnt[mu_idx]);
+		fw_pr(cl_hw, "Number of FCS ERROR        = %u\n",
+		      rx_stats->fcs_error_counter[mu_idx]);
+		fw_pr(cl_hw, "Number of PHY ERROR        = %u\n",
+		      rx_stats->phy_error_counter[mu_idx]);
+		fw_pr(cl_hw, "Number of AMPDUS           = %u\n",
+		      rx_stats->ampdu_received_counter[mu_idx]);
+		fw_pr(cl_hw, "Number of Incorrect AMPDUS = %u\n",
+		      rx_stats->ampdu_incorrect_received_counter[mu_idx]);
+		fw_pr(cl_hw, "Number of Delimiter errors = %u\n",
+		      rx_stats->delimiter_error_counter[mu_idx]);
+
+		if (rx_stats->total_rx_packets[mu_idx]) {
+			u32 total_rx_packets = rx_stats->total_rx_packets[mu_idx] +
+				rx_stats->rx_fifo_overflow_err_cnt[mu_idx] +
+				rx_stats->fcs_error_counter[mu_idx] +
+				rx_stats->phy_error_counter[mu_idx] +
+				rx_stats->delimiter_error_counter[mu_idx];
+
+			cl_print_rx_stats_precent(cl_hw,
+						  "Rx Fifo Overflow percent  ",
+						  100 * rx_stats->rx_fifo_overflow_err_cnt[mu_idx],
+						  total_rx_packets);
+			cl_print_rx_stats_precent(cl_hw,
+						  "FCS Error percent         ",
+						  100 * rx_stats->fcs_error_counter[mu_idx],
+						  total_rx_packets);
+			cl_print_rx_stats_precent(cl_hw,
+						  "Phy Error percent         ",
+						  100 * rx_stats->phy_error_counter[mu_idx],
+						  total_rx_packets);
+			cl_print_rx_stats_precent(cl_hw,
+						  "Delimiter Error percent   ",
+						  100 * rx_stats->delimiter_error_counter[mu_idx],
+						  total_rx_packets);
+		}
+
+		fw_pr(cl_hw, "Current NAV value          = %u\n", rx_stats->nav_value[mu_idx]);
+		fw_pr(cl_hw, "\n");
+		fw_pr(cl_hw, "Rx LL split stats: 1st LL interrupts = %u\n",
+		      rx_stats->counter_timer_trigger_ll1[mu_idx]);
+		fw_pr(cl_hw, "Rx LL split stats: 2nd LL interrupts = %u\n",
+		      rx_stats->counter_timer_trigger_ll2[mu_idx]);
+		fw_pr(cl_hw, "Number of incorrect format mode received = %u\n",
+		      rx_stats->rx_incorrect_format_mode[mu_idx]);
+
+		for (i = 0; i < RX_CLASSIFICATION_MAX; i++) {
+			if (!rx_stats->rx_class_counter[mu_idx][i])
+				continue;
+
+			fw_pr(cl_hw, "Rx classification rules stats: Rx rule%d= %u\n",
+			      i, rx_stats->rx_class_counter[mu_idx][i]);
+		}
+
+		if (rx_stats->rx_class_int_counter[mu_idx])
+			fw_pr(cl_hw, "Rx classification interrupts rules = %u\n",
+			      rx_stats->rx_class_int_counter[mu_idx]);
+
+		fw_pr(cl_hw, "\n");
+		fw_pr(cl_hw, "Rx Implicit BF statistics:      = %u\n",
+		      rx_stats->rx_imp_bf_counter[mu_idx]);
+		fw_pr(cl_hw, "Rx Implicit BF interrupts stats = %u\n",
+		      rx_stats->rx_imp_bf_int_counter[mu_idx]);
+		fw_pr(cl_hw, "RXM STATISTICS\n");
+		fw_pr(cl_hw, "rxm_stats_overflow      = %u\n",
+		      rx_stats->rxm_stats_overflow[mu_idx]);
+		fw_pr(cl_hw, "rx_incorrect_format_mode= %u\n",
+		      rx_stats->rx_incorrect_format_mode[mu_idx]);
+		fw_pr(cl_hw, "correct_received_mpdu   = %u\n",
+		      rx_stats->correct_received_mpdu[mu_idx]);
+		fw_pr(cl_hw, "incorrect_received_mpdu = %u\n",
+		      rx_stats->incorrect_received_mpdu[mu_idx]);
+		fw_pr(cl_hw, "discarded_mpdu          = %u\n",
+		      rx_stats->discarded_mpdu[mu_idx]);
+		fw_pr(cl_hw, "incorrect_delimiter     = %u\n",
+		      rx_stats->incorrect_delimiter[mu_idx]);
+		fw_pr(cl_hw, "rts_bar_cnt             = %u\n",
+		      rx_stats->rts_bar_cnt[mu_idx]);
+		fw_pr(cl_hw, "rxm_mpdu_cnt            = %u\n",
+		      rx_stats->rxm_mpdu_cnt[mu_idx]);
+
+		if (rx_stats->rxm_mpdu_cnt[mu_idx]) {
+			fw_pr(cl_hw, "rxm_rule0_match        = %u\n",
+			      rx_stats->rxm_rule0_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_rule1_match        = %u\n",
+			      rx_stats->rxm_rule1_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_rule2_match        = %u\n",
+			      rx_stats->rxm_rule2_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_rule3_match        = %u\n",
+			      rx_stats->rxm_rule3_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_rule4_match        = %u\n",
+			      rx_stats->rxm_rule4_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_rule5_match        = %u\n",
+			      rx_stats->rxm_rule5_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_rule6_match        = %u\n",
+			      rx_stats->rxm_rule6_match[mu_idx]);
+			fw_pr(cl_hw, "rxm_default_rule_match = %u\n",
+			      rx_stats->rxm_default_rule_match[mu_idx]);
+
+			fw_pr(cl_hw, "RXM amsdu stat not supported. use iwcl stats instead\n");
+		}
+
+		/* RX AMSDU prints */
+		fw_pr(cl_hw, "\n");
+		fw_pr(cl_hw, "RX AMSDU STATS\n");
+		fw_pr(cl_hw, "AMSDU RX cnt  = %u\n",
+		      rx_stats->stats_tot_rx_amsdu_cnt[mu_idx]);
+
+		for (i = 0; i < ARRAY_SIZE(rx_stats->stats_rx_amsdu_cnt[mu_idx]); i++)
+			if (rx_stats->stats_rx_amsdu_cnt[mu_idx][i])
+				fw_pr(cl_hw, "A-MSDU of %d = %u\n",
+				      i + 1, rx_stats->stats_rx_amsdu_cnt[mu_idx][i]);
+
+		fw_pr(cl_hw, "A-MSDU RX errors:\n");
+		for (i = 0; i < AMSDU_DEAGGREGATION_ERR_MAX; i++)
+			if (rx_stats->stats_rx_amsdu_err[mu_idx][i])
+				fw_pr(cl_hw, " err_id[%d] = %u\n",
+				      i, rx_stats->stats_rx_amsdu_err[mu_idx][i]);
+	}
+
+	fw_pr(cl_hw, "Frequency offset:\n");
+	for (i = 0; i < FREQ_OFFSET_TABLE_IDX_MAX; i++)
+		if (rx_stats->frequency_offset[i])
+			fw_pr(cl_hw, "frequency_offset = %u\n", rx_stats->frequency_offset[i]);
+}
+
+static void cl_print_stats_handler(struct work_struct *ws)
+{
+	struct cl_print_stats_work *stats_work = container_of(ws, struct cl_print_stats_work, ws);
+	struct cl_hw *cl_hw = stats_work->cl_hw;
+	u32 dbg_info_type = stats_work->dbg_info_type;
+
+	if (dbg_info_type == DBG_INFO_RX_STATS) {
+		struct cl_rxl_statistics *rx_stats =
+			&(((struct dbg_info *)cl_hw->dbginfo.buf)->u.rx_stats);
+
+		cl_print_rx_stats(cl_hw, rx_stats);
+	} else {
+		cl_dbg_err(cl_hw, "Info type is not supported: %u\n", dbg_info_type);
+	}
+
+	cl_ipc_dbginfobuf_push(cl_hw->ipc_env, cl_hw->dbginfo.dma_addr);
+	kfree(stats_work);
+}
+
+static void cl_schedule_print_stats(struct cl_hw *cl_hw, u32 dbg_info_type)
+{
+	struct cl_print_stats_work *stats_work =
+		kzalloc(sizeof(*stats_work), GFP_ATOMIC);
+
+	if (stats_work) {
+		INIT_WORK(&stats_work->ws, cl_print_stats_handler);
+		stats_work->cl_hw = cl_hw;
+		stats_work->dbg_info_type = dbg_info_type;
+
+		/* Schedule work, the work will be executed in the background */
+		queue_work(cl_hw->drv_workqueue, &stats_work->ws);
+	} else {
+		cl_dbg_err(cl_hw, "stats_work allocation failed\n");
+	}
+}
+
+void cl_fw_dbg_handler(struct cl_hw *cl_hw)
+{
+	struct dbg_info *dbg_info = NULL;
+
+	/* Function called upon DBG_INFO_IND message reception. */
+	dma_sync_single_for_device(cl_hw->chip->dev, cl_hw->dbginfo.dma_addr,
+				   cl_hw->dbginfo.bufsz, DMA_FROM_DEVICE);
+	dbg_info = (struct dbg_info *)cl_hw->dbginfo.buf;
+
+	if (dbg_info->u.type == DBG_INFO_DUMP) {
+		cl_dbg_info(cl_hw, "type %u): dump received\n",
+			    cl_hw->dbginfo.buf->u.dump.general_data.error_type);
+	} else if (dbg_info->u.type < DBG_INFO_MAX) {
+		cl_schedule_print_stats(cl_hw, dbg_info->u.type);
+	} else {
+		cl_dbg_warn(cl_hw, "Debug info wrong type - %u\n", dbg_info->u.type);
+	}
+}
+
+int cl_fw_dbg_trigger_based_init(struct cl_hw *cl_hw)
+{
+	cl_hw->tb_stats = vzalloc(sizeof(*cl_hw->tb_stats));
+	if (!cl_hw->tb_stats)
+		return -ENOMEM;
+
+	cl_hw->tb_sta_stats = vzalloc(sizeof(*cl_hw->tb_sta_stats));
+	if (!cl_hw->tb_sta_stats)
+		return -ENOMEM;
+
+	cl_hw->tb_stats->ampdu_cnt = INVALID_AMPDU_CNT;
+
+	return 0;
+}
+
+void cl_fw_dbg_trigger_based_deinit(struct cl_hw *cl_hw)
+{
+	vfree(cl_hw->tb_stats);
+	vfree(cl_hw->tb_sta_stats);
+}
+
+void cl_fw_dbg_trigger_based_update(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr,
+				    struct ieee80211_hdr *hdr)
+{
+	struct cl_rx_trigger_based_stats *tb_stats = cl_hw->tb_stats;
+	u8 mu = 0;
+
+	if (!tb_stats->enable)
+		return;
+
+	if (tb_stats->ampdu_cnt == INVALID_AMPDU_CNT) {
+		tb_stats->ampdu_cnt = rxhdr->ampdu_cnt;
+		if (rxhdr->format_mod == FORMATMOD_HE_TRIG) {
+			if (ieee80211_is_qos_nullfunc(hdr->frame_control))
+				tb_stats->qos_null_per_agg += rxhdr->frm_successful_rx;
+			else
+				tb_stats->data_per_agg += rxhdr->frm_successful_rx;
+
+			tb_stats->total += rxhdr->frm_successful_rx;
+		}
+	} else if (tb_stats->ampdu_cnt == rxhdr->ampdu_cnt) {
+		if (rxhdr->format_mod == FORMATMOD_HE_TRIG) {
+			if (ieee80211_is_qos_nullfunc(hdr->frame_control))
+				tb_stats->qos_null_per_agg += rxhdr->frm_successful_rx;
+			else
+				tb_stats->data_per_agg += rxhdr->frm_successful_rx;
+
+			tb_stats->total += rxhdr->frm_successful_rx;
+		}
+	} else {
+		tb_stats->ampdu_cnt = rxhdr->ampdu_cnt;
+		if (unlikely(tb_stats->data_per_agg >= DBG_STATS_MAX_AGG_SIZE))
+			cl_dbg_err(cl_hw, "rx trigger_based agg size %u > 256\n",
+				   tb_stats->data_per_agg);
+		else
+			tb_stats->data[tb_stats->data_per_agg]++;
+
+		if (unlikely(tb_stats->qos_null_per_agg > TID_MAX))
+			tb_stats->qos_null[TID_MAX + 1]++;
+		else
+			tb_stats->qos_null[tb_stats->qos_null_per_agg]++;
+
+		if (tb_stats->modify) {
+			tb_stats->modify = false;
+
+			for (mu = 0; mu < MU_UL_MAX; mu++) {
+				tb_stats->data_per_mu_agg_size[mu][tb_stats->data_per_mu_agg[mu]]++;
+				tb_stats->data_per_mu_agg[mu] = 0;
+			}
+		}
+
+		tb_stats->data_per_agg = 0;
+		tb_stats->qos_null_per_agg = 0;
+
+		if (rxhdr->format_mod == FORMATMOD_HE_TRIG) {
+			if (ieee80211_is_qos_nullfunc(hdr->frame_control))
+				tb_stats->qos_null_per_agg += rxhdr->frm_successful_rx;
+			else
+				tb_stats->data_per_agg += rxhdr->frm_successful_rx;
+
+			tb_stats->total += rxhdr->frm_successful_rx;
+		}
+	}
+
+	if (rxhdr->format_mod == FORMATMOD_HE_TRIG) {
+		mu = rxhdr->key_sram_index - KEY_SRAM_BASE_VAL;
+
+		if (unlikely(mu >= MU_UL_MAX)) {
+			cl_dbg_err(cl_hw, "rxhdr->key_sram_index = %u; valid range: %u...%u\n",
+				   rxhdr->key_sram_index, KEY_SRAM_BASE_VAL,
+				   KEY_SRAM_BASE_VAL + MU_UL_MAX - 1);
+			return;
+		}
+
+		if (ieee80211_is_qos_nullfunc(hdr->frame_control)) {
+			tb_stats->qos_null_per_mu[mu]++;
+		} else if (ieee80211_is_data(hdr->frame_control)) {
+			tb_stats->modify = true;
+			tb_stats->data_per_mu[mu]++;
+			tb_stats->data_per_mu_agg[mu]++;
+		}
+
+		tb_stats->total_per_mu[mu]++;
+	}
+}
+
+void cl_fw_dbg_trigger_based_sta_update(struct cl_hw *cl_hw, struct hw_rxhdr *rxhdr,
+					struct ieee80211_hdr *hdr)
+{
+	struct cl_rx_trigger_based_sta_stats *tb_sta_stat = cl_hw->tb_sta_stats;
+	u8 id = 0;
+
+	if (tb_sta_stat->ampdu_cnt != rxhdr->ampdu_cnt) {
+		tb_sta_stat->ampdu_cnt = rxhdr->ampdu_cnt;
+		if (tb_sta_stat->modify) {
+			tb_sta_stat->modify = false;
+
+			for (id = 0; id < CL_MAX_NUM_STA; id++) {
+				tb_sta_stat->data_per_sta_agg[id][tb_sta_stat->data_per_sta[id]]++;
+				tb_sta_stat->data_per_sta[id] = 0;
+			}
+		}
+	}
+
+	if (rxhdr->format_mod == FORMATMOD_HE_TRIG) {
+		id = rxhdr->key_sram_index - KEY_SRAM_BASE_VAL;
+		tb_sta_stat->modify = true;
+		tb_sta_stat->data_per_sta[id]++;
+	}
+}
-- 
2.36.1

