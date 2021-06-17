Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC963AB84A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jun 2021 18:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhFQQGS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Jun 2021 12:06:18 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:58626
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233650AbhFQQGC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Jun 2021 12:06:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuO2Yihm0vRdapI4bMudMyIhXc1VbFFesZDz1S8XqbJ1crpDXEZu1bbw37dh1IjEEt8PtIMmNrX/9jItZcyc5AvlRlDwGFrDMqEE3pAh8LZEypC/IktKlrdu0XtQb0V93DIxtN64x8wGl+XxLJTJapAypB578jNk1aRyoDQVnCVCZnHxb/UpyM1TIveeNMQkclsSuz9BaOcTSwTyy4SVsexdCflQUzNyM1bpuZzuNQIyg08Rg1qM5TM565qE5V9i/T+i6F+ztlxYLkulRE2eUqa8i5aZ84Ow9Vc9+ZBVBudz8Jx/MN+fKhgt0TDzTZkYlCwjSF91IVU4tTdS8Ylepg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdAUzCB/gj8vEficYS1Su7o+xJTbdKMY+3Vky3oEfE0=;
 b=LqlE2/THAeBwj1wKytemI5WXCs9Qk7wuM5in0RXMu557Rby1yN3ETQ/Uvw0ZfuGNfKplHCzbT92WJWBns/87Cib3WAW30w83jdHgMYuZEWmZsXIBdkinNaVqIHTTj+POyEYFKy8fWk1ik2iWcVBGe3PRxa/yH1/PmXqOPxY/Pcs9FY/Vx5sl+kzt1+U62sLpr95WLAs0kAMFzZZDHvvrA9Q9+rOy0HDTYcp/iU6SBSyLM3QKRzgsJJFoCVGfgLlmJBDUls6HSKwsb5O70klB8ZzKt/tA44nvHwLIHE7ijeqhddb+411kahnq4Brd8ZTwb31tvvHWJpazbGOu3/nSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=celeno.com; dmarc=pass action=none header.from=celeno.com;
 dkim=pass header.d=celeno.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=celeno.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdAUzCB/gj8vEficYS1Su7o+xJTbdKMY+3Vky3oEfE0=;
 b=TeODxjeBykc4XKsRwG9M2oQUHqU0Me8ayqSOLH27cgGzBW+3MOfyxlTRoowA7UOSt/Mve5quwlhIOYsox6VoIEs6v68OIQepaN6ek2ZIzC3Erd5MiAAcptrEu7LFDqwCphgWSwH0ODodgzZ5mWNNsUzcWZ7OL9OUx5Cpr5tnJtE=
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
Subject: [RFC v1 056/256] cl8k: add debugfs.h
Date:   Thu, 17 Jun 2021 15:59:03 +0000
Message-Id: <20210617160223.160998-57-viktor.barna@celeno.com>
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
Received: from localhost.localdomain (62.216.42.54) by PR3PR09CA0018.eurprd09.prod.outlook.com (2603:10a6:102:b7::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 16:03:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adc88c3d-18da-4e7f-7cd6-08d931a9761a
X-MS-TrafficTypeDiagnostic: AM0P192MB0499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0P192MB0499A6A65A0FFA773E874049F60E9@AM0P192MB0499.EURP192.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yl9qovcGHtv8mVypJp1ZEeOAnqftcJMG1rNqpevKhak1aqX3GBJ4A2hGu5W9UYGcMzOrUjoxi70RJ5RJedS/pylo41UBChM3BSv1IC9kdBf9AfwOXLHzqVwA/tkyVii9KLwvfTFVJ9mlAvrGJOOpPbG759qt2UJPMK1gsgkQSu6sjsphPQKkDDzft5H80JP2FDgNLhQUOzgvN8tduVH8x5GnBHy88KdEYKvmOEc2k2KeQwgqk9OvA/O1HIxZIjD5Hr37wGpcOYuf0hp0+moIQNrfYteIrfB3eBIa0Kw37D+TdAJSI9TpWKgdFfBetzCDf+p+zAMfxIN2+6C8EpxxgFixQN23XnD2gxyM+KROjWAY7emSjUpkb18UXKD0MhWfHH76kiCarxHUsFA+COjHqPDN3pCXKlYy6VyWJ3h4W9pb2imvbg7k69FjzNKXYvAXrjJpr9zTpEyoorbr8chVwWe38ubKrG3/Ekt0mGRpkhe59SywPlEeuRBrXRJS/Qs9POi9p4XB2AMOcVcrF4qizkgW9z8tf5vfkDxX3o4AWoiAAcxR8ex084az4Sv0iDPXNTJsNt1vyn/PbBQulKXmuqnIXF7h+Knk9PqUmcZvjOnSuQyxTFjOogSTbnizwgZTm9OH3wBS5kMVbuCH4tRHz7D40GVY1bL+Ai4ZWE8ENEIABHeKy4HH7qQPsdtbi65AlDgHQjmntAZAmwSJp561QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB1412.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39840400004)(396003)(376002)(366004)(346002)(86362001)(107886003)(66556008)(52116002)(83380400001)(55236004)(36756003)(4326008)(186003)(16526019)(956004)(316002)(6486002)(8676002)(54906003)(38100700002)(38350700002)(66476007)(6506007)(2906002)(26005)(9686003)(6512007)(66946007)(2616005)(5660300002)(478600001)(1076003)(6666004)(8936002)(6916009)(69590400013)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MRjwC2445QqtcC5szEzxYyPvJ7Vg05dujTIfPoGHgTWigzgP8/UmAo+pECbu?=
 =?us-ascii?Q?WrYlIMu2QAaTTxtu5c/oRHHfFgUz/3lsOHwWRHXhFCtOT7Gq1dQ78ZwUeRtf?=
 =?us-ascii?Q?XQMU3dKRtJ5y0AEXd3aZOYrvjt1KuWSN8zvAkfIc9f7QDGP7ouqrHBBDm4Fv?=
 =?us-ascii?Q?EoFvxn32FoQ9Gex/ly8Tmh8kmgKNExg+4sx/PVn12w4PD/yy+wdFIBhdjHId?=
 =?us-ascii?Q?5l0R5rnpfqgkjbRqaWEC/qbSV4TfvVLDS2y0K0mqb8KFt8+WIzNXqymbQrSE?=
 =?us-ascii?Q?8UikW+4BJkZleov4F+rVKEJSO51OYYZYlOOkqoJcMxqJHDAI3HiE5e2E8y6x?=
 =?us-ascii?Q?Jj/vUW9QZXxdcfeTJl3CDiOfnNBB7KMtiYVxGuw6iEmEneEv+Q4c41+mvE3k?=
 =?us-ascii?Q?4zbJA67Ru0AM9UVLvF0FwmHIO4JbrQHWS0SOZA6FHAjx50B9pSw8LdXsH++k?=
 =?us-ascii?Q?MSmMM7MyjWNMPRFh9SFD1H3YAOxsLjbx10g+ySOUGvp8FSBTlYZWzoeVVrl5?=
 =?us-ascii?Q?1xm/HDCuAKbjebPgETtAchnyDyIgZ6arHZljvuv7SQ3ndZeVPKFEKTLR7WDP?=
 =?us-ascii?Q?AblfVgXgQM7YLVX9l3u9aoz/8n7jbv2bCpjyxwwkDGv4C8lCsd27KGNa+MlD?=
 =?us-ascii?Q?Z2xPLKMgV7piXnoGfrTcd/5GX9u9eD6/zLxzAMl3/JPVBaouZxOgD/3Zki0j?=
 =?us-ascii?Q?L6KMagxJeBoPsGtri2LgtP8UfMvqJg8XPsHC1NKpKSskcGfyLZL53rDz+Nzh?=
 =?us-ascii?Q?2SrnjVTaRHHbD4TpMlet0qb563RaQpoQWQ6QQxzZFuYFe+X9261eS/Vn1h2j?=
 =?us-ascii?Q?mMHHWTdDnX0hDwLsW2j7JLu/NTJA59zyB5GGWvIPwz82K95hVZio08G4f+nk?=
 =?us-ascii?Q?IixbCrKDQFgmAO1jx4sxDBiLSfhXSaKl5Ht8ZxVDPXh5hkI4sJw6clkN6jYE?=
 =?us-ascii?Q?9a0kjjS6RoQsW3jB0Y4xnOKzr7dhUD1B6dqgQDGZReL9oOck+23MzpQwpEnK?=
 =?us-ascii?Q?7KRVcZ0WKnmA7qt9n9mtDprbCR4wtvnrQPOfkNDw8eLQ5bgNkcJBDP7TXwfw?=
 =?us-ascii?Q?4ArDQps74yAVeFBpuC8PWCEA9noZaRenofUQpHNpBa3qsI53RB/iTSwpIXuA?=
 =?us-ascii?Q?PRrJ2WXSZx3f5IQSpKBvppjSQAAv4n63z4++ArcRKxQtrwKWoMOdxaAXebj2?=
 =?us-ascii?Q?vn/9uLHzntG0EFOBywQ6/r0TAEnI2V273nRoyDeMfENivkbjBBIXU5Mh/gCj?=
 =?us-ascii?Q?guARSG3sLP7XEyXTC5SynHRPeeZDNadI+h5SGQao+/jW231P8FiHINp/w+8d?=
 =?us-ascii?Q?Vm5cwwfqH7QrNQHZNwZl7017?=
X-OriginatorOrg: celeno.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc88c3d-18da-4e7f-7cd6-08d931a9761a
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB1412.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:03:35.1800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f313103b-4c9f-4fd3-b5cf-b97f91c4afa8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwAHNiPBHxsweWVtGHoJ0mTTHXgpjXUCIlBtcxlf89KShFUyZt3i2DKp+e/KcZnVRt0R017w8hb7GzbmuyhwQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P192MB0499
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Viktor Barna <viktor.barna@celeno.com>

(Part of the split. Please, take a look at the cover letter for more
details).

Signed-off-by: Viktor Barna <viktor.barna@celeno.com>
---
 drivers/net/wireless/celeno/cl8k/debugfs.h | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 drivers/net/wireless/celeno/cl8k/debugfs.h

diff --git a/drivers/net/wireless/celeno/cl8k/debugfs.h b/drivers/net/wirel=
ess/celeno/cl8k/debugfs.h
new file mode 100644
index 000000000000..1684c6aea1a9
--- /dev/null
+++ b/drivers/net/wireless/celeno/cl8k/debugfs.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: MIT */
+/* Copyright(c) 2019-2021, Celeno Communications Ltd. */
+
+#ifndef CL_DEBUGFS_H
+#define CL_DEBUGFS_H
+
+#include "debugfs_defs.h"
+#include "hw.h"
+
+#ifdef CONFIG_CL_DEBUGFS
+
+int cl_dbgfs_register(struct cl_hw *cl_hw, const char *name);
+void cl_dbgfs_unregister(struct cl_hw *cl_hw);
+
+#else
+
+static inline int cl_dbgfs_register(struct cl_hw *cl_hw, const char *name)
+{
+       return 0;
+}
+
+static inline void cl_dbgfs_unregister(struct cl_hw *cl_hw)
+{
+}
+
+#endif /* CONFIG_CL_DEBUGFS */
+
+#endif /* CL_DEBUGFS_H */
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

