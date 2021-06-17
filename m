Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8F13AB84F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbhFQQGW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:22 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:58626
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233634AbhFQQGG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VlUEHFYwkfAFq/QHv7KPqbaJX8LV24jAs6XAYHqkyTOlDF8/niLRqXYpxwAuVWyA4s9CO0A//EmbLiJ84DJaoCvY0A7bE6L4fREQrIg20aUE1ejXvKsnefw65dz6+5dRpPqQEKH7er0zPbqXC5DHoE2KmADGVrZSboZqwxFJ/3gtIW9WNQm+G6SK49AKJ4K6ITfifC0e0QCKUvauiDAymOvNh6YxcdcNzgJSUL1znOBJA83Qn93y8ewNZrr+3VW5HZHwD5nreVgO77wOMP5YU+tBtfNbrIqfqnAfNHA3xTeApJRJg1EKN0UpY4QjkDpaoWoChQotJS4DHlY6zi6KMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4l6tvhRhMr+GOMClI1X/Rm3GmsYxYNSJLt1php8bLA=;
 b=GFWME+2/jikrPumGY5yX+PbyPWNJdthlKwnHI/lX6Rl2bKabyyUOim7YWujcIeRsasF1hAswcFekWVk7iP3wBEm9IUa4gbT1b7roi6odaoiBBWL1qNCSRHR9u2sJ3g3Ibx628JyI/X7imKv+HwQoRTc0DtF+QuG46QzkN5NWLeSpyHGInzBKtJ3Luycaws8x11nb/orVjRs9chBYvSuBtu1WXRfpYAXCUtgWY7DrCJogEUKjL34gZHEZor6dx2uQ+72LVhslCaAGdSgmwnzDGNEk5L/uGP9EJKZZegkS+fvMjUoAZluNHxk0ZiKzvvGPYoyP1SjEwstlA6pmVkIu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4l6tvhRhMr+GOMClI1X/Rm3GmsYxYNSJLt1php8bLA=;
 b=Dd7O4sKDYTd5XkIqgd7KlltcJAso0mfUkdvhtSlMyYxd/T4FjhxYra20UGyl2W49C+k0EISSUmX+HkgkEIXw6u064/UdfUt+NayTzRSSZrATe7VthlpAVEQnze2DsuQVnCPbQbh44wGAYKB7EJoLFW9YdeLwPZBYUGTcaLRUNko=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=celeno.com;
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:38b::16)
 by AM0P192MB0499.EURP192.PROD.OUTLOOK.COM (2603:10a6:208:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15; Thu, 17 Jun
 2021 16:03:47 +0000
Received: from AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f]) by AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
 ([fe80::1847:5583:4db7:102f%4]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:03:47 +0000
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
Subject: [RFC v1 057/256] cl8k: add debugfs_defs.h
Date:   Thu, 17 Jun 2021 15:59:04 +0000
Message-Id: <20210617160223.160998-58-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66ae8dc3-f0cf-4079-afe0-08d931a976b4
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB049975C3E8C95E66B54102AFF60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgTdDUKBEXEFsyqAVLvEiNJC2O89B2szDlbmtn6O0ljaCrnOGlbpeZ+tURl4Ump8OR8T7QJXCxSSiwnDDWrOV1y5WZ5Xh3XZPLxspdPjEg/1qPFW8lraoDMfNjivREQCU2PPpJe21vuGZj0fTxYfvVPPgcczNWENDoDvVSI/xw/K4Lnooc21h1LsH/usO5z4kjYwzxyIwk+SVWjHmH+4+3QTjZSouNaki+DvufXN+gcNB+2McmGfghEk5hhyCTvWAMxk9hFcuFszKD6sxDUe6PBMc5n0pokhFDztz3U95p4BVcCMTI7akIT41tNBJAmqKLnn5It4VzAijklyw75zYIJu7TheR8cz0URo3viPIlraLcB+VIw5wowiTzIP354JKyO/ahkbvvdA/6lSLXD+NwCI4WA1o8P5n/15LHndJGxn7HYGKGOt1ePDJFhWqPl87DzJvyu3sHoDM2ti2H1d/YdcRpGmoOJHlBKMZO88hIMIj4VJ5FU9lYwlBGqQsQnGn792OITHsysbEof7vuJ7VTnD0C18dEpo8eNWPhKRXHzJxFqgCE2NrbCHvWv87n+uNQj93C4ZUoMdWTfy6TNLvVZG3silBVVwYpLqeaAJSr68/rouNYNZ7A2ofliRiqRXK6SKci/4nxhKid+NDg661IVQfyb2qc4DCPOla0w8SAsv4t2qTf8rv59P3C+4p64FlIgKIDiAKuMIOT82YYBk8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hBidrb51LXE+hknjhIaVySLjKrw+w4Laukb45PFIfMYqiEGbiSgfXwINUS+m?=
 =?us-ascii?Q?tnYF4xb0n8tj9hbfETd7GaruIl5Pptud0WRwQMC5lYyirM8eFZDmD3cfi9h5?=
 =?us-ascii?Q?H4iKGoa7/ckGibzm01KDlmm/chBdxuwSRY27Vzm9U/TOK2BW7CSBiSUE2oR+?=
 =?us-ascii?Q?cqUF4R5cSdL37Jtg7U3ofB5McsnzP3aCMRsRU0Q5o3sIM9OSL1eThjKZVuA+?=
 =?us-ascii?Q?9HVglRJHsWqnIxqEjvxNAdBcgUf0pJDpgkxukxrU1gejR+csenstdXUX2DAv?=
 =?us-ascii?Q?K0z9q4kaF1cfmnlGvSaKgv24UfzNvXl//cPSlQbZpwOyS7y+hc5GsQUfWX/D?=
 =?us-ascii?Q?7Bev7u1DyfUQS+O2ceYFFufM5U1KVPKFgKpXyAhY8bSqQCRJz0+GsZtvgRWu?=
 =?us-ascii?Q?IYurmK4376/sAlWmXZvffPL6u0Q/lvfaXY8/px5+LuldXsxHQ2wu0PiqSK79?=
 =?us-ascii?Q?NYta6fYkza3pFHV2xs/SkAXgDS5Evw7pQmlgtFQyn+xOFh9z4OosfxLL3p0u?=
 =?us-ascii?Q?nWE/5bIWgYCUDtN1h80b/spCMfEQuyfti4xYhS0Zq1wyvzB9ShYiRFI/1Q8O?=
 =?us-ascii?Q?FHp1YXMlr0EJG570rjfofkgGmPOe+AjDdl4lY+1e/N/h5RJVY7uv6gFHAEJ0?=
 =?us-ascii?Q?MxvHrEdlzDt1Dt8lDTsLy/b07dCdxm3Fd1MUaFDbSvXLxd08Pjme63eRIiqp?=
 =?us-ascii?Q?5lucrHK/17wOULGYE28djD0M/84TtsWSVbIsmIQ8yktFHRAuZq/JVmkcJtsh?=
 =?us-ascii?Q?fBxdz6a5gByda+7HV5Qk2g/4qpbdifPLkjIC6lUCRv3YsKKwL2qeOVPQcF0n?=
 =?us-ascii?Q?PhYmssEqE4IEXi+4YSchyvO76MTxHi+cyg1iF77jfw4e8TWn6Dm5KXkW9WfX?=
 =?us-ascii?Q?iYZ2VMeYK1HZprXGRjvXGOX+fd90RN83O7czyK1xA3y3AQ70lkG6AVOb6aMj?=
 =?us-ascii?Q?XrwBI0B5l8SXVCOYWMUJOLjKckjGc4s846Lt77tx4JhxhMa6iV48QrtKbByM?=
 =?us-ascii?Q?qbIkGEVO6UpKD0Zfbd7y0KzwC0twJb0DpeiE1q0BJ4VFsX6j7DVpUeOdEQfU?=
 =?us-ascii?Q?ERh9O9Ao8cdWvQwPFpeW1XTDsinQSXc9GeVOVtsp4DWQMeeNW7xi3Xy6eu6w?=
 =?us-ascii?Q?tT9gdKYe/jAKUGhVRCys2eODb9hD9oeYBOYKVLYhmI/6KK46emjTgPbUXno0?=
 =?us-ascii?Q?ZRpKxFi+gBrvBITZee0+2f++J+tJqEEQlTdcjgQr32HWFIj9vxJxF3ySfnxe?=
 =?us-ascii?Q?o2OeHBH8GDEsPAlys27suJJ6Crz6w9RnjpFUmONdpMB9u4XRg9sQASElcRmi?=
 =?us-ascii?Q?+AOJ5NQfn/mUhr1RK3LGLSqK?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ae8dc3-f0cf-4079-afe0-08d931a976b4
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:36.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HN8SdQzxsLPDNScePxTdUW4x5u5VcpnvIQO5XSjJtZLTwAKIfPNZqIasTs1lhBvbZ44DhT+rwfhErQUWWeBE4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 .../net/wireless/celeno/cl8k/debugfs_defs.h   | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/debugfs_defs.h

diff --git a/drivers/net/wireless/celeno/cl8k/debugfs_defs.h b/drivers/net/=
wireless/celeno/cl8k/debugfs_defs.h
new file mode 100644
index 000000000000..d6b8d0db7bb8
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/debugfs_defs.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DEBUGFS_DEFS_H
+#define CL_DEBUGFS_DEFS_H
+
+/* Min HW assert before testing asserts time-stamp */
+#define CL_MIN_ASSERT_CNT 10
+
+/* Define max time between hw asserts in msec */
+#define CL_HW_ASSERT_TIME_MAX 5000
+
+#ifdef CONFIG_CL_DEBUGFS
+
+#include <linux/workqueue.h>
+#include <linux/interrupt.h>
+
+struct cl_debugfs {
+       unsigned long long rateidx;
+       struct dentry *dir;
+       bool trace_prst;
+       struct work_struct coredump_work;
+       bool coredump_scheduled;
+       spinlock_t coredump_lock;
+       unsigned long coredump_call_tstamp;
+       bool unregistering;
+};
+
+#else
+
+struct cl_debugfs {
+};
+
+#endif /* CONFIG_CL_DEBUGFS */
+
+#endif /* CL_DEBUGFS_DEFS_H */
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

