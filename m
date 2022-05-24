Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C2C532981
	for <lists+linux-wireless@lfdr.de>; Tue, 24 May 2022 13:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbiEXLmQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 May 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236962AbiEXLmC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 May 2022 07:42:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945B13F34
        for <linux-wireless@vger.kernel.org>; Tue, 24 May 2022 04:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmunYP1Wh3HtGXm5LzIezqVvM2AiFMQRNC5gv0fw8sIFBO26Cx5He5Yuab5L3CRNzQ7v4P8Um18nKW00ZuLlYllt81t+P0RzrWHoyhDOCNNyEgrpMY696BFZp6YlAqxH/wQaFlvSyBp5t7Q9S4ou4Wirg3I6udFRCZFabuw7Aq/KFSyUHPmGu2m2R8rie8QcLE+Jsb6WloUeq/aMRSrTmNLxvYuY+Bzs3eKq7EB/Ap2tSOztr8q/AKQXbXDWHX/PfWEm87/H+pDEurQYA1o8geV62Cf75vVac1mWu8dD1ApW+X1BqY3qtYhGXMWEoJ2jyN1/lfyjXAw4D7dpzbP+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ViCuvpRF0dGU5KmID2qInaDNXTIDrCXPKu2DOhlZuAs=;
 b=DEVhgcHfa23ir7GNLO2xPqAgyz5qg12cCIEsoVmNita/2kSW93v4Di2mjaZyL9oY3k0o/puesEP7x7IGE6CuE6ND8xuxiXMUlVb6JOIKJQckG+1Sr2MROpbj6/abU4CtAR6ti4is/eqE/IeknixLVxys/i60Wq2+HJZnt1AjeedtSF12sNyPpHyxRwX4Lqf2rDAXSDA8sfayYmVJahry884bvfPGwL+m9Bnk1Cp7jwMdYuFrffKSl3Hi9XYt5W9/PmCXKHRU1C0CEaKacBl0Hj0DPUX7zrsz6CbpwypdKtqYB2/D0Yr0bfsw58AY/EJRo9WjQVrKxx7aODfPgeiIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ViCuvpRF0dGU5KmID2qInaDNXTIDrCXPKu2DOhlZuAs=;
 b=c1ghw7RPwt03t/i4dH0jnPD7kmW3L5xrHaOk/PinGg0bY8NC6thiqfhAb4Sm/CK5qmCPnsbuoYxVmNXY5ZFH/Pl17bJmYOntYKMcSmAyjh3V9enRN8OHrtGwjWe7+8Q9oMlVY80dkKBpCNFJJO/UckkGl9WNxk5E+jxTJzEmcAA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by VE1P192MB0669.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Tue, 24 May
 2022 11:39:34 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::6c57:2d13:9162:cbbb%8]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 11:39:34 +0000
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
Subject: [RFC v2 89/96] cl8k: add version.h
Date:   Tue, 24 May 2022 14:34:55 +0300
Message-Id: <20220524113502.1094459-90-viktor.barna@celeno.com>
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
X-MS-Office365-Filtering-Correlation-Id: 302714aa-2c4a-4498-4d40-08da3d79ff33
X-MS-TrafficTypeDiagnostic: VE1P192MB0669:EE_
X-LD-Processed: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8,ExtFwd
X-Microsoft-Antispam-PRVS: <VE1P192MB0669791574EC778882987BD8F6D79@VE1P192MB0669.EURP192.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVLUS1YqGWj/4pbkpiOutGGjw+wMQltFrfX/7zA0fz6thEA6z7F34FjKv/kKsh90bGhPEI9SksBRi4rRrLFuUFi85SKS6+jnteQ8UJWC9ryZ5YqPc8anOgmzLYd+FcQibPRfHYFshaC+LxKc5PDjtEQaKuCgiYBOmDtHqEzZQ5uTLA1B4vo/Lk0yqmvDBYdA452X0XOsq8h2cvmzFAkPPkgpLpb/F0hBEB8EbauJHlNSq8daEagxUWfZ0E7+LVETfNooGSSE2IWuQobyKoCWt914GPBXEsT8/fcLqu8nCruVVl6glWARMW/jjIa1BjwH1Waq4yvxyu1ZgvD+npiN1E/EtX/gKeZDF8IjHOwrnxcvyHSUkUuzisxqsXAZWdpG1PVuyFr6cQwkC1s3SlyaQBBmQodGQ6WpezWn+MWWWEN0rYHszyidUarzQjFUHJ/pBEupgTfZ8jSw/DZ9imcgmZ+43tjC7Z23bEW0Lps55FgsHVs9atpr+abgLN/njvYLHk7/qlNyvALyWjWmu1j0cX3nihyncMpq0q4b+c9NBlZF5eb2LmOtWKkKMBnhLQnGne7gGlNlGrA/zQq68bqwDUBSj9zXrv8lc8hGo1tkDwIiuZPh2AzNPM4tmWrJHQRKDY0hX7cfcWV944ue6C73jjcww9KNVonFD0qBwOO0Wdu8fc2z/Xa8oa1qO9GZXBAOT4MucIxw/mCUtW5yBMMoFe+agc5RRcTCfBh68Taa2cU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(396003)(376002)(136003)(366004)(346002)(39850400004)(8676002)(9686003)(26005)(36756003)(66946007)(66556008)(66476007)(4326008)(107886003)(83380400001)(6512007)(5660300002)(38350700002)(38100700002)(1076003)(2616005)(316002)(6916009)(6506007)(6486002)(54906003)(86362001)(8936002)(508600001)(41300700001)(6666004)(2906002)(186003)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Or2xIbSkkR38cwqqloDV282RErKA2s1Ha/u0Z0WtnnAWSvyPPdYNibLUN/HB?=
 =?us-ascii?Q?hiG/CPPBCpX4GzbfwdMQu1Z+ghVjFQtrRPt6dSrVPA1FTdUICWPpn2FEgGDB?=
 =?us-ascii?Q?GZmz/JRXt9Bqhag91zF2bGooW4f4DI6htqadSRYwBy38+krU02XatypiS1tK?=
 =?us-ascii?Q?NKDckUcx8KBl0+G/H9lREgIRKBqLJWD18iM23iIU79b2nlmN+BJEqmxdhDX1?=
 =?us-ascii?Q?Odz7HZv5cp0NXvfqI777AIxikNDVvFfyK3GIwZ5cL2yHqw6x/dgwqyYbj1d7?=
 =?us-ascii?Q?qti2zAk/cgIrnVeQbRr5C9zJNbksbudRK5YyQlLvmv82ChaTSp1xszkveuAJ?=
 =?us-ascii?Q?P8d1JA70pNEDPwXnVQuPVPPQiWvxFH2Nb4vaNgcSRk7XaVJNAUuXFFv1ojvT?=
 =?us-ascii?Q?Mj5Jer/XdapBgOWyKxt44STGC1RqIRajKgcxTszYB7mfgSE2ggXxHEMa2ZzD?=
 =?us-ascii?Q?TxkfxCfyqTawbFKxeIU0HAwx5W2HK1GYA72Hi5GcZi9Pn1bFSLUAzAE0EsLA?=
 =?us-ascii?Q?CIF0fTZgZmPMS/TIvRSflYYx/fwRxrjIYR8sBreSRnq1c81HM8ZGWylJAL2v?=
 =?us-ascii?Q?b3xcWDKxwZqZyg4100wtiEiCGnUzjXguQHe2VU+lSHk0pPrxx7ZBMmK5pbri?=
 =?us-ascii?Q?mWZnJab4qZlViTze6IhNDYAZYBjt5a5l7N4Ncbh0L4rfpWZ7xW5kGPtnkZfQ?=
 =?us-ascii?Q?MOPN25hVhiORduDddU2eptrFVypxiv3LbPmzETjfrDKH7gyO04XUPTv2IKb5?=
 =?us-ascii?Q?35TvXW+bffHkDQGOta+5tHOeUJMZO26shlRa6KdN6B7BgcGJkmTPfIdaKWSQ?=
 =?us-ascii?Q?PiAm6EN5OikyKEZ8qN+oFY1balaEX781DyHy+4RRtBfOVmIZcDfEAcboqydw?=
 =?us-ascii?Q?xKvwMwYoRDdXsY4kltwgjej/iwGYidrjr5db6Q0HgwNR69ZLexdjj+KBmk1E?=
 =?us-ascii?Q?uBprKcZrjVUbxCMYz66DMQ0Wg54lnGFRiR+oWypBXDXIoMHNHHCr97crkqFk?=
 =?us-ascii?Q?gpbVcfJWJTa3voyOYrPyV2e1UJkCvbgWEbKHKGiadXPyyUS91mnFfOOksgQc?=
 =?us-ascii?Q?SPWRDwTFV3xldk3bEIHOFBCW/EvhqEVkWtCLT22ULZidtvB3PlqDPOI65qPE?=
 =?us-ascii?Q?7/yc7sX3Qk46HoEFWz38qdEw08pgYfYMTycAPud1j9QFO3ymaA2hXwAGsIx7?=
 =?us-ascii?Q?JutGac0wWAaWhZ1+F7teohBKNvdOS1iPzKUcgDeU+2Fj3VyiYAPsAmCHefHB?=
 =?us-ascii?Q?DHKR7fC4c8SfLg4u87/quCggP+9TXVrT372/yN2X7tSxiVivOXYFqAbxlR6j?=
 =?us-ascii?Q?wdMaba3oyFwpLqtO8KaeBAmqxeo/Bp7tFPlEcp1Y3so971OdKznQsObiNbI6?=
 =?us-ascii?Q?KTQAqjHMP7+TD2IqmQopxfFu3n0lWJexMMA5wXL/bzw9sIcUk81Rgv7W/ye7?=
 =?us-ascii?Q?8I1mbJ4C1ZyFp5aq9CeaW/mp9m/J5xa27vM7kt4Z+Xn+2KqEe0XPPMfTOe+H?=
 =?us-ascii?Q?OVX2e/cRHWbyigheGRw/hiVCwRGRJfC/nhvfiqjgH7aPHyqr8VFa9aqtSOjl?=
 =?us-ascii?Q?rd06C/2rLqLj3JnJjz51mAEcnlet9tJmrtprSYKEUMX/ARTR4Hq8oQUG6Lbx?=
 =?us-ascii?Q?RnOr43ZK4BBb2hDO5jJw94BJrBUWLQdVzzFRHjWDg3dwnM2NLjSvU8I1invb?=
 =?us-ascii?Q?r6/OOy4YIR31/EPARyx6d4pLi5ksdbceIGydpBP/gUaM6Ji85K1+PtkJKU3P?=
 =?us-ascii?Q?zUxxCkc+W5/Dro+uD3aFgPXB9T+0l6s=3D?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 302714aa-2c4a-4498-4d40-08da3d79ff33
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 11:39:00.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2gGMdqXg9O7Dnah/CDZjEvTx5l+8TgqpDup1xN6Z+BtXFQARLHguqLBlX2H5Ub54Fbp6F09HjfhwxzXbmzZTdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0669
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
 drivers/net/wireless/celeno/cl8k/version.h | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/version.h

diff --git a/drivers/net/wireless/celeno/cl8k/version.h b/drivers/net/wireless/celeno/cl8k/version.h
new file mode 100644
index 000000000000..bc6d2ad4153a
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/version.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright(c) 2019-2022, Celeno Communications Ltd. */
+
+#ifndef CL_VERSION_H
+#define CL_VERSION_H
+
+#include "ipc_shared.h"
+
+struct cl_version_db {
+	u32 dsp;
+	u32 rfic_sw;
+	u32 rfic_hw;
+	u32 agcram;
+	char fw[CL_VERSION_STR_SIZE];
+	char drv[CL_VERSION_STR_SIZE];
+	unsigned long last_update;
+};
+
+int cl_version_read(struct cl_hw *cl_hw, char *buf, ssize_t buf_size, ssize_t *total_len);
+int cl_version_update(struct cl_hw *cl_hw);
+void cl_version_sync_wiphy(struct cl_hw *cl_hw, struct wiphy *wiphy);
+
+#endif /* CL_VERSION_H */
-- 
2.36.1

